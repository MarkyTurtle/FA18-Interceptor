"""frames.py [NAME...]: the stack frames of the C-style routines (those that start with
`link.w a6,#-n`): which argument and local offsets each uses, with what sizes, and how many bytes
of arguments its callers push (the addq / lea that tidies the stack after the call).
With no names, a one-line summary of every such routine.

The routines were compiled from C: arguments are pushed right to left as longs, so the first is
at 8(a6), the next at $C(a6)... (a word argument is read from its low half, +2); locals sit
below a6, from -n up to -1."""
import re, glob, sys, collections, os

os.chdir(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
OFF = re.compile(r'(-?)\$([0-9a-f]+)\(a6\)|(-?)([0-9]+)\(a6\)')
SIZE = re.compile(r'^\s*\w+\.(b|w|l)\b')


def ends(line):
    """a routine's body runs to the next routine's header (or link): past its own data tables."""
    return line.startswith(';----') or re.match(r'\s+link\.w\s+a6', line)


def routines():
    for f in sorted(glob.glob('src/*.s')):
        L = open(f).read().split('\n')
        name = None
        for i, l in enumerate(L):
            m = re.match(r'^([A-Za-z_]\w*):', l)
            if m and not m.group(1).startswith('l_'):
                name, start = m.group(1), i
            if name and re.match(r'\s+link\.w\s+a6,#', l) and i - start <= 3:
                body = []
                for x in L[i + 1:]:
                    if ends(x):
                        break
                    body.append(x)
                frame = int(re.search(r'#\$?([0-9a-fx-]+)', l).group(1).replace('$', ''), 16) if '$' in l else int(re.search(r'#(-?\d+)', l).group(1))
                if frame >= 0x8000: frame -= 0x10000
                yield f, name, frame, body
                name = None


def callers():
    """name -> list of the argument bytes popped after each call."""
    out = collections.defaultdict(list)
    for f in sorted(glob.glob('src/*.s')):
        L = open(f).read().split('\n')
        for i, l in enumerate(L):
            m = re.match(r'\s+(?:jsr|bsr\.[bw])\s+\(?(\w+)\)?(?:\.l)?\s*(;|$)', l)
            if not m: continue
            nxt = L[i + 1] if i + 1 < len(L) else ''
            p = re.match(r'\s+addq\.[wl]\s+#\$?([0-9a-f]+),a7', nxt) or re.match(r'\s+lea\.l\s+\$([0-9a-f]+)\(a7\),a7', nxt)
            out[m.group(1)].append(int(p.group(1), 16) if p else 0)
    return out


def named():
    """the frame names already given (from the blocks frames.py --name wrote): name -> offset."""
    out = {}
    for f in sorted(glob.glob('src/*.s')):
        L = open(f).read().split('\n')
        for i, l in enumerate(L):
            if BLOCK.match(l):
                j = i + 1
                while j < len(L) and re.match(r'^(\w+)?\s+(rs\.[bwl]|equ|rsset)\b', L[j]):
                    j += 1
                out.update(old_names(L[i + 1:j]))
    return out


NAMED = re.compile(r'(?<![\w$])([A-Za-z_]\w*)(?:\+(\d+))?\(a6[,)]')


def uses(body, names=None):
    u = collections.defaultdict(set)
    for l in body:
        code = l.split(';')[0]
        for m in NAMED.finditer(code):
            if names and m.group(1) in names:
                s = SIZE.match(code)
                u[names[m.group(1)] + int(m.group(2) or 0)].add(s.group(1) if s else '?')
        for m in OFF.finditer(code):
            if m.group(2) is not None:
                off = int(m.group(2), 16) * (-1 if m.group(1) else 1)
            else:
                off = int(m.group(4)) * (-1 if m.group(3) else 1)
            s = SIZE.match(code)
            u[off].add(s.group(1) if s else '?')
    return u


# --- naming ------------------------------------------------------------------------------------
# frames.py --name SPEC: give a routine's arguments and locals names. SPEC holds blocks like
#
#   IFFReadBytes
#     $8  Context  the IFF context
#     $C  Buffer   where the bytes go
#     -$4 Result   the count read, or an error
#
# (an offset, a name and a description; a local that is an array takes its size, -$40/32 Name).
# For each routine the tool writes, just above its label, a block that emits no bytes:
#
#   ; IFFReadBytes's frame: arguments from 8(a6), locals below a6 (after its link)
#                   rsset   8
#   IFFReadBytes_Context    rs.l    1           ; the IFF context
#   IFFReadBytes_Result     equ     -$4         ; the count read, or an error
#
# and replaces the numbers in the routine's body: $8(a6) -> IFFReadBytes_Context(a6), a word
# argument's low half $A(a6) -> IFFReadBytes_Context+2(a6). Run it again to change a name or a
# description: the block is rewritten and the old names are replaced too.

COL = 48
BLOCK = re.compile(r"^; (\w+)'s frame: ")


def num(s):
    neg = s.startswith('-')
    s = s.lstrip('-')
    v = int(s[1:], 16) if s.startswith('$') else int(s)
    return -v if neg else v


def hexs(v):
    return ('-$%X' if v < 0 else '$%X') % abs(v)


def read_spec(path):
    spec, cur = {}, None
    for ln in open(path):
        if not ln.strip() or ln.lstrip().startswith('#'):
            continue
        if not ln[0].isspace():
            cur = spec.setdefault(ln.split()[0], [])
            continue
        off, name, *desc = ln.split(None, 2)
        size = None
        if '/' in off:
            off, size = off.split('/')
            size = int(size)
        cur.append((num(off), size, name, desc[0].strip() if desc else ''))
    return spec


def pad(code, cmt):
    return (code.ljust(COL) if len(code) < COL else code + ' ') + cmt if cmt else code


def lab(s):
    return s.ljust(24) if len(s) < 24 else s + ' '


def block(name, fields):
    args = sorted(f for f in fields if f[0] >= 8)
    locs = sorted((f for f in fields if f[0] < 0), reverse=True)
    out = ["; %s's frame: arguments from 8(a6), locals below a6 (after its link)" % name]
    if args:
        out.append(' ' * 16 + 'rsset   8')
        at = 8
        for off, size, n, d in args:
            slot = 8 + (off - 8) // 4 * 4
            while at < slot:   # an argument it never reads
                out.append(pad(' ' * 16 + 'rs.l    1', '; (not read)'))
                at += 4
            lo = off - slot    # a word is read from the long's low half, a byte from its last
            if lo:
                out.append(pad(' ' * 16 + ('rs.w    1' if lo == 2 else 'rs.b    %d' % lo),
                               '; (pushed as a long: the high part)'))
            out.append(pad(lab('%s_%s' % (name, n)) + 'rs.%s    1' % ( {0: 'l', 2: 'w', 3: 'b'}[lo]),
                           '; ' + d if d else ''))
            at = slot + 4
    for off, size, n, d in locs:
        out.append(pad(lab('%s_%s' % (name, n)) + 'equ     %s' % hexs(off),
                       '; ' + d + (' (%d bytes)' % size if size else '') if d or size else ''))
    return out


def old_names(lines):
    """name -> offset, from a block written before."""
    old, at = {}, 8
    for x in lines:
        x = x.split(';')[0]
        m = re.match(r'^(\w+)?\s+equ\s+(\S+)', x)
        if m:
            old[m.group(1)] = num(m.group(2))
            continue
        m = re.match(r'^(\w+)?\s+rs\.([bwl])\s+(\d+)', x)
        if m:
            if m.group(1): old[m.group(1)] = at
            at += {'b': 1, 'w': 2, 'l': 4}[m.group(2)] * int(m.group(3))
    return old


def apply(spec):
    files = {}
    for f in sorted(glob.glob('src/*.s')):
        files[f] = open(f).read().split('\n')
    done = set()
    for f, L in files.items():
        i = 0
        while i < len(L):
            m = re.match(r'^([A-Za-z_]\w*):', L[i])
            if not m or m.group(1) not in spec:
                i += 1
                continue
            name, fields = m.group(1), spec[m.group(1)]
            done.add(name)
            # drop an old block just above the label
            j = i
            while j > 0 and re.match(r'^(\w+)?\s+(rs\.[bwl]|equ|rsset)\b', L[j - 1]):
                j -= 1
            if j > 0 and BLOCK.match(L[j - 1]) and BLOCK.match(L[j - 1]).group(1) == name:
                j -= 1
            else:
                j = i
            old = old_names(L[j:i])
            new = block(name, fields)
            L[j:i] = new
            i = j + len(new)
            # the body: to the next label that isn't a branch label
            byoff = {}
            for off, size, n, d in fields:
                full = '%s_%s' % (name, n)
                if off >= 8:
                    for k in range(4 - (off - 8) % 4): byoff[off + k] = full + ('+%d' % k if k else '')
                else:
                    for k in range(size or 1): byoff[off + k] = full + ('+%d' % k if k else '')
            oldrev = {v: k for k, v in old.items()}
            k = i + 1
            while not re.match(r'\s+link\.w\s+a6', L[k]):
                k += 1
            k += 1
            while k < len(L) and not ends(L[k]):
                code, sep, cmt = L[k].partition(';')
                def sub(mo):
                    tok = mo.group(1)
                    base = re.match(r'^(\w+)(?:\+(\d+))?$', tok)
                    if base and base.group(1) in old:
                        v = old[base.group(1)] + int(base.group(2) or 0)
                    elif re.match(r'^-?\$?[0-9a-fA-F]+$', tok) and (tok.lstrip('-').startswith('$') or tok.lstrip('-').isdigit()):
                        v = num(tok)
                    else:
                        return mo.group(0)
                    return (byoff.get(v) or hexs(v)) + '(a6' + mo.group(2)
                nc = re.sub(r'(?<![\w$])(-?\$?[0-9a-fA-F]+|\w+(?:\+\d+)?)\(a6([,)])', sub, code)
                if nc != code:
                    L[k] = pad(nc.rstrip(), sep + cmt) if sep else nc.rstrip()
                k += 1
            i = k
    for f, L in files.items():
        txt = '\n'.join(L)
        if txt != open(f).read():
            open(f, 'w').write(txt)
    missing = set(spec) - done
    if missing:
        print('not found:', ' '.join(sorted(missing)))


if __name__ == '__main__' and len(sys.argv) > 2 and sys.argv[1] == '--name':
    apply(read_spec(sys.argv[2]))


if __name__ == '__main__' and sys.argv[1:2] != ['--name']:
    want = set(sys.argv[1:])
    cl = callers()
    nm = named()
    for f, name, frame, body in routines():
        if want and name not in want: continue
        u = uses(body, nm)
        args = sorted(o for o in u if o >= 8); locs = sorted(o for o in u if o < 0)
        pushed = collections.Counter(cl.get(name, []))
        if not want:
            print('%-28s %-34s frame %4d  args %-30s callers pop %s' % (name, f[4:], frame,
                  ' '.join('$%X%s' % (o, ''.join(sorted(u[o]))) for o in args)[:30],
                  ','.join('%d' % k for k in sorted(pushed)) or '-'))
            continue
        mine = {v: k[len(name) + 1:] for k, v in nm.items() if k.startswith(name + '_')}
        show = lambda o: hexs(o) + '(%s)' % '/'.join(sorted(u[o])) + ('=' + mine[o] if o in mine else '')
        print('%s (%s): link #%d' % (name, f[4:], frame))
        print('  arguments:', ' '.join(map(show, args)) or 'none')
        print('  locals:   ', ' '.join(map(show, locs)) or 'none')
        print('  callers pop:', dict(pushed) or 'none seen')
