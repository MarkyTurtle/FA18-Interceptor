"""Turn a data region of the source that is really code into instructions, then check the build.

  python3 tools/decode.py LABEL [--to OFFSET] [--at OFFSET]

LABEL starts the region (a label in f18_main.s or src/*.s); it runs to the next label, or to
OFFSET (hex, in the hunk) with --to. --at gives the region's offset when nothing in it says. Its bytes (the dc.b / dc.w / dcb.b lines, and dc.l lines
that hold a relocated address) are disassembled from the start (capstone, 68000). Relocated
longs become the labels they were; branches inside the region get new labels l_HHH_OOOOO, and
branches outside it use the label there or hHHH+$offset. The region is replaced in the file
and build.py must still pass (the bytes and the loaded image), or the file is put back.
"""
import os, re, subprocess, sys
import capstone

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.normpath(os.path.join(HERE, '..'))
sys.path.insert(0, os.path.join(HERE, 'disasm'))
from core import is_branch, BRANCH_NOT

COL = 48
PLACEHOLDER = 0x7F000000


def files():
    return [os.path.join(ROOT, 'f18_main.s')] + sorted(
        os.path.join(ROOT, 'src', f) for f in os.listdir(os.path.join(ROOT, 'src')) if f.endswith('.s'))


def dcb_bytes(text):
    """The bytes of a dc.b operand list: numbers and quoted strings ('' is a quote)."""
    out, i, text = bytearray(), 0, text.strip()
    while i < len(text):
        if text[i] in ' \t,':
            i += 1
        elif text[i] in '\'"':
            q, i = text[i], i + 1
            while i < len(text):
                if text[i] == q and i + 1 < len(text) and text[i + 1] == q:
                    out.append(ord(q)); i += 2
                elif text[i] == q:
                    i += 1
                    break
                else:
                    out += text[i].encode('latin-1'); i += 1
        else:
            j = i
            while j < len(text) and text[j] not in ',':
                j += 1
            out.append(num(text[i:j]))
            i = j
    return bytes(out)


def num(tok):
    tok = tok.strip()
    return int(tok[1:], 16) if tok.startswith('$') else int(tok)


def main():
    label = sys.argv[1]
    to = int(sys.argv[sys.argv.index('--to') + 1], 16) if '--to' in sys.argv else None
    at = int(sys.argv[sys.argv.index('--at') + 1], 16) if '--at' in sys.argv else None
    for f in files():
        L = open(f, encoding='utf-8').read().split('\n')
        if f'{label}:' in (l.split(';')[0].strip() for l in L):
            break
    else:
        raise SystemExit(f'{label}: not found')
    start = next(i for i, l in enumerate(L) if l.split(';')[0].strip() == f'{label}:')
    hunk = None
    for l in L[:start][::-1]:
        m = re.match(r'^\t\w+_HUNK\t(h(\d+))', l)
        if m:
            hunk = int(m.group(2))
            break
    if hunk is None:                                    # a later part of a split hunk
        m = re.search(r"h(\d{3})_\w+\.s$", os.path.basename(f))
        hunk = int(m.group(1))
    # the region's lines and bytes
    data, rel, i = bytearray(), {}, start + 1
    off0 = None
    while i < len(L):
        l = L[i]
        code = l.split(';')[0]
        if re.match(r'^[A-Za-z_.][\w.]*:', l) or (code.startswith(' ' * 8) and not code.strip().startswith(('dc.', 'dcb.'))):
            break
        s = code.strip()
        m = re.search(r';\s*([0-9A-F]{5})\b', l)
        if s.startswith('dc.l') and m:                  # a relocated long: dc.l label ; offset
            if off0 is None:
                off0 = int(m.group(1), 16) - len(data)
            rel[len(data)] = s.split(None, 1)[1].strip()
            data += (PLACEHOLDER + len(rel)).to_bytes(4, 'big')   # a value to find in the operands
        elif s.startswith('dc.b'):
            data += dcb_bytes(code.split('dc.b', 1)[1])
        elif s.startswith('dc.w'):
            for t in s[4:].split(','):
                data += num(t).to_bytes(2, 'big')
        elif s.startswith('dcb.b'):
            n, v = s[5:].split(',')
            data += bytes([num(v)]) * num(n)
        elif s:
            break
        i += 1
        if to is not None and off0 is not None and off0 + len(data) >= to:
            break
    end = i
    if off0 is None and at is not None:
        off0 = at
    if off0 is None:
        m = re.match(r'^\w+_(\d{3})_([0-9A-F]{5})$', label)
        if not m:
            raise SystemExit('cannot tell the region\'s offset: give a label named by its offset, or one with a dc.l in it')
        off0 = int(m.group(2), 16)
    md = capstone.Cs(capstone.CS_ARCH_M68K, capstone.CS_MODE_BIG_ENDIAN | capstone.CS_MODE_M68K_000)
    out, p, newlab, ins = [], 0, set(), []
    while p < len(data):
        got = list(md.disasm(bytes(data[p:p + 10]), off0 + p, count=1))
        if not got:
            raise SystemExit(f'${off0 + p:05X}: not an instruction')
        x = got[0]
        ins.append((p, x))
        if is_branch(x.mnemonic.split('.')[0]):
            t = int(re.findall(r'\$([0-9a-f]+)', x.op_str)[-1], 16)
            if off0 <= t < off0 + len(data):
                newlab.add(t)
        p += x.size
    if p != len(data):
        raise SystemExit('the last instruction runs past the region')
    for p, x in ins:
        a = off0 + p
        if a in newlab and a != off0:
            out.append(f'l_{hunk:03d}_{a:05X}:')
        m, o = x.mnemonic, x.op_str
        if m.split('.')[0] == 'moveq':
            mm = re.match(r'#\$([0-9a-f]+), (d\d)', o)
            v = int(mm.group(1), 16)
            if v > 127:
                o = f'#{v - 256}, {mm.group(2)}'
        if m.split('.')[0] in BRANCH_NOT:
            m = m.split('.')[0]
        if is_branch(m.split('.')[0]):
            t = int(re.findall(r'\$([0-9a-f]+)', o)[-1], 16)
            name = label if t == off0 else (f'l_{hunk:03d}_{t:05X}' if t in newlab else f'h{hunk:03d}+${t:X}')
            o = re.sub(r'\$[0-9a-f]+$', name, o)
        o = re.sub(r'\$([0-9a-f]+)\(pc', lambda mm: (label if int(mm.group(1), 16) == off0 else f'h{hunk:03d}+${int(mm.group(1), 16):X}') + '(pc', o)
        for k, (r, lab) in enumerate(rel.items()):
            if p < r + 4 and r < p + x.size:
                if not p + 2 <= r <= p + x.size - 4:
                    raise SystemExit(f'${a:05X}: a relocated long is not an operand of {m} {o}')
                v = f'${PLACEHOLDER + k + 1:x}'
                o = re.sub(re.escape(v) + r'(\.[wl])?', lambda mm: f'({lab}){mm.group(1)}' if mm.group(1) else lab, o)
        line = f'        {m:<8}{o.replace(", ", ",")}'
        out.append((line.ljust(COL) if len(line) < COL else line + ' ') + f'; {a:05X}')
    L[start + 1:end] = out
    old = open(f, encoding='utf-8').read()
    open(f, 'w', encoding='utf-8', newline='\n').write('\n'.join(L))
    r = subprocess.run([sys.executable, os.path.join(ROOT, 'build.py')], capture_output=True, text=True)
    print(r.stdout.strip())
    if r.returncode:
        open(f, 'w', encoding='utf-8', newline='\n').write(old)
        print(r.stderr[-2000:])
        raise SystemExit(f'{label}: the build no longer matches - the file is put back')
    print(f'{label}: {len(ins)} instructions')


if __name__ == '__main__':
    main()
