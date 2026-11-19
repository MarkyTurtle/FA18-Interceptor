"""Disassembly of an AmigaDOS hunk executable, on top of the engine in core.py.

core.Program works on one binary in one address space. A hunk executable is a set of hunks that
LoadSeg puts anywhere, joined by relocations. Here each hunk gets its own VIRTUAL base,
VB(n) = $40000000 + n * $100000, and every relocated longword is patched to the virtual
address it points at before tracing. Then core's tracing, sweeping and vasm verification work
unchanged across all hunks, and a relocated operand can never be mistaken for a plain number
(or the other way round): the relocation tables say exactly which longwords are addresses.

The source written assembles two ways (see f18_hunks.i):
  vasmm68k_mot -Fbin                 -> the whole executable file, byte for byte: each hunk under
                                        its own org 0 (so labels are hunk offsets), with the hunk
                                        header, relocation and symbol tables written as dc.l
  vasmm68k_mot -Fhunkexe -DHUNKEXE   -> an ordinary executable that vasm makes from the labels;
                                        its loaded image (contents and relocations) must equal
                                        the original's, which checks every relocated operand is
                                        a label
"""
import os, re, sys
import capstone

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import core
import hunkfile

VB0, SHIFT = 0x40000000, 20


def vb(n):
    return VB0 + (n << SHIFT)


HUNK_MACRO = {('code', 0): 'CODE_HUNK', ('data', 0): 'DATA_HUNK', ('bss', 0): 'BSS_HUNK',
              ('code', 1): 'CODE_C_HUNK', ('data', 1): 'DATA_C_HUNK', ('bss', 1): 'BSS_C_HUNK',
              ('code', 2): 'CODE_F_HUNK', ('data', 2): 'DATA_F_HUNK', ('bss', 2): 'BSS_F_HUNK'}


class HunkProgram(core.Program):
    def __init__(self, cfg):
        self.cfg = cfg
        here = os.path.dirname(os.path.abspath(cfg.__file__))
        self.root = os.path.normpath(os.path.join(here, '..', '..'))
        self.raw = open(os.path.join(self.root, cfg.EXE), 'rb').read()
        self.hdr, self.hunks = hunkfile.parse(self.raw)
        self.size = [4 * h.nlongs for h in self.hunks]
        buf = bytearray()
        self.segs = []
        self.rel = {}                       # virtual address of a relocated long -> virtual target
        for h in self.hunks:
            sz = self.size[h.n]
            c = bytearray(h.data) if h.type != 'bss' else bytearray(sz)
            for t, offs in h.relocs:
                for o in offs:
                    v = vb(t) + int.from_bytes(c[o:o + 4], 'big')
                    c[o:o + 4] = v.to_bytes(4, 'big')
                    self.rel[vb(h.n) + o] = v
            if sz:
                self.segs.append((len(buf), len(buf) + sz, vb(h.n)))
            buf += c
        self.data = bytes(buf)
        self.md = capstone.Cs(capstone.CS_ARCH_M68K, capstone.CS_MODE_BIG_ENDIAN | capstone.CS_MODE_M68K_000)
        self.ins, self.labels, self.refs = {}, {}, {}
        self.indirect, self.vectors, self.bad = [], {}, set()
        self.state_file = os.path.join(here, cfg.NAME + '_trace.json')
        # names: the executable's own symbols, then the config's ((hunk, offset) -> name)
        self.names = {}
        for h in self.hunks:
            for nm, n, off in h.symbols:
                s = nm.rstrip(b'\0').decode('latin-1')
                if s.startswith('.'):
                    s = f'h{h.n:03d}_{s[1:]}'           # assembler-local (.L1): not unique
                self.names.setdefault(vb(h.n) + off, s)
        for (n, off), s in getattr(cfg, 'NAMES', {}).items():
            self.names[vb(n) + off] = s
        cfg.NAMES = self.names                      # core.lname/all_labels read cfg.NAMES
        self.ptrtabs, self.reltabs = {}, {}

    # ---- addresses
    def split(self, v):
        n = (v - VB0) >> SHIFT
        if v < VB0 or n >= len(self.hunks):
            return None
        return n, v - vb(n)

    def is_code_hunk(self, v):
        s = self.split(v)
        return s is not None and self.hunks[s[0]].type == 'code' and s[1] < self.size[s[0]]

    def relocs_in(self, a, e):
        return [r for r in range(a & ~1, e, 2) if r in self.rel]

    # ---- trace
    def trace(self):
        self.came_from, self.bad_paths, self.swept, self.hints = {}, [], [], []
        entries = [vb(0)] + [v for v in self.names if self.is_code_hunk(v) and not self.names[v].startswith('h')]
        entries += [vb(n) + o for n, o in getattr(self.cfg, 'ENTRIES', [])]
        for e in entries:
            self.labels[e] = 'entry'
        self._follow(list(entries))
        self.drop_bad_relocs()
        # relocated pointers into code hunks (function pointers, jsr/pea/lea targets): try each
        # as code, kept only if it decodes cleanly without running into anything traced
        cand = sorted({t for t in self.rel.values() if self.is_code_hunk(t)} - set(self.ins))
        self.tentative = self.try_code(cand, min_ins=1)
        self.drop_bad_relocs()
        self.sweep()
        self.drop_bad_relocs()
        self._refs()

    def try_code(self, cand, min_ins=3):
        kept = []
        for g in cand:
            if g in self.ins or g in getattr(self, 'within', {}) or self.inside_ins(g):
                continue
            snap = (dict(self.ins), dict(self.labels), dict(self.came_from), len(self.bad_paths), len(self.indirect))
            self.labels.setdefault(g, 'sub')
            self._follow([g])
            new = [x for x in self.ins if x not in snap[0]]
            ok = len(self.bad_paths) == snap[3] and len(new) >= min_ins and self.no_overlap()
            ok = ok and not any(self.ins[x][3].startswith('0000') for x in new) and self.relocs_ok(new)
            if ok:
                kept.append(g)
            else:
                self.ins, self.labels, self.came_from = snap[0], snap[1], snap[2]
                del self.bad_paths[snap[3]:]
                del self.indirect[snap[4]:]
        return kept

    def inside_ins(self, g):
        for k in (2, 4, 6, 8):
            x = self.ins.get(g - k)
            if x and x[0] > k:
                return True
        return False

    def no_overlap(self):
        span = set()
        for x, (z, *_r) in self.ins.items():
            for k in range(z):
                if x + k in span:
                    return False
                span.add(x + k)
        return True

    def reloc_fits(self, a):
        """a relocated long inside an instruction must be one of its operands, whole"""
        sz, m, op, hx = self.ins[a]
        for r in self.relocs_in(a - 2, a + sz):
            if r < a + 2 or r + 4 > a + sz or f'${self.rel[r]:x}' not in op:
                return False
        return True

    def relocs_ok(self, addrs):
        return all(self.reloc_fits(a) for a in addrs)

    def drop_bad_relocs(self):
        """An instruction holding part of a relocated long (or one not as an operand) is data."""
        for a in [a for a in self.ins if not self.reloc_fits(a)]:
            del self.ins[a]
            self.bad_paths.append((a, None, 'relocated long not an operand: kept as data'))

    def sweep(self):
        # core.sweep, with relocations respected (a swept routine must fit them too)
        before = set(self.ins)
        core.Program.sweep(self)
        new = [a for a in self.ins if a not in before]
        bad_owner = {self.sweep_owner.get(a) for a in new if not self.reloc_fits(a)}
        for a in new:
            if self.sweep_owner.get(a) in bad_owner:
                del self.ins[a]
        self.swept = [g for g in self.swept if g not in bad_owner]

    def _refs(self):
        for a, (sz, m, op, hx) in self.ins.items():
            for mm in re.finditer(r'\$([0-9a-f]+)\(pc', op):
                self.addref(int(mm.group(1), 16))
        for t in self.rel.values():
            self.addref(t)
        self.check_overlaps()
        # relocated longs not inside instructions are emitted whole (dc.l): a reference into
        # the middle of one is written as label+n
        for r in self.rel:
            if r not in self.ins and r not in self.within:
                for k in (1, 2, 3):
                    self.within.setdefault(r + k, r)
        for v in list(self.refs) + list(self.labels):
            if v in self.within:
                self.refs.setdefault(self.within[v], 'dat')

    def imm_is_addr(self, a, m, op):
        return False                      # relocations decide what is an address

    def addref(self, v):
        if self.inside(v):
            self.refs.setdefault(v, 'dat')

    # ---- names
    def lname(self, a):
        if a in self.names:
            return self.names[a]
        n, off = self.split(a)
        k = self.labels.get(a)
        if a not in self.ins:
            return f'dat_{n:03d}_{off:05X}'
        if k in ('sub', 'entry'):
            return f'sub_{n:03d}_{off:05X}'
        return f'l_{n:03d}_{off:05X}'

    def sym(self, v):
        s = self.split(v)
        if s is None:
            return None
        n, off = s
        if v in self.labset:
            return self.lname(v)
        if off == self.size[n]:
            return f'h{n:03d}_end'
        if off == 0:
            return f'h{n:03d}'
        b = self.within.get(v)
        if b is not None and b in self.labset:
            return f'{self.lname(b)}+{v - b}'
        return f'h{n:03d}+${off:X}'

    def convert(self, a, m, op):
        mn, o = self.numeric(m, op)
        base = mn.split('.')[0]
        if core.is_branch(base):
            return mn, re.sub(r'\$[0-9a-f]+$', self.sym(int(core.HEX.findall(o)[-1], 16)), o)
        o = re.sub(r'\$([0-9a-f]+)\(pc', lambda mm: (self.sym(int(mm.group(1), 16)) or mm.group(0)[:-3]) + '(pc', o)
        sz = self.ins[a][0]
        for r in self.relocs_in(a + 2, a + sz):
            v = self.rel[r]
            s = self.sym(v)
            o = re.sub(r'\$%x\b(\.[wl])?' % v, lambda mm: f'({s}){mm.group(1)}' if mm.group(1) else s, o, count=1)
        # absolute addresses that are not relocated: ExecBase, the custom chips, the CIAs
        o = re.sub(r'(?<![#\w-])\$4\.l', '(AbsExecBase).l', o)
        return mn, o

    # ---- output
    def emit_bytes(self, a, e):
        """[a, e) as data: relocated longs as dc.l label, the rest through core.emit_data"""
        out = []
        p = a
        while p < e:
            if p in self.rel:
                out.append(f'\tdc.l\t{self.sym(self.rel[p])}'.expandtabs(8).ljust(48) + f'; {self.loc(p)}')
                p += 4
                continue
            q = p
            while q < e and q not in self.rel:
                q += 1
            out.extend(self.emit_data(p, q))
            p = q
        return out

    def loc(self, v):
        n, off = self.split(v)
        return f'{off:05X}'

    def generate(self):
        cfg = self.cfg
        self.labset = self.all_labels() | {r for r in self.rel if r not in self.ins and r not in self.within and r in self.refs}
        self.vecs_inv = set()
        hdrs = {vb(n) + o: t for (n, o), t in getattr(cfg, 'HEADERS', {}).items()}
        cmts = {vb(n) + o: t for (n, o), t in getattr(cfg, 'COMMENTS', {}).items()}
        htext = getattr(cfg, 'HUNK_TEXT', {})
        out = cfg.PROLOGUE.strip('\n').split('\n')
        hd = self.hdr
        out += ['', ';' + '=' * 79, '; The hunk header (the -Fbin build only: with -Fhunkexe vasm writes its own)',
                ';' + '=' * 79, '\tifnd\tHUNKEXE', '\tsection\tbin,code', '\torg\t0',
                f'\tdc.l\tHUNK_HEADER,0\t\t\t; no resident libraries',
                f'\tdc.l\t{hd["count"]},{hd["first"]},{hd["last"]}\t\t\t; hunks, first, last']
        for h, s in zip(self.hunks, hd['sizes']):
            fl = s >> 30
            expr = f'h{h.n:03d}_end/4' + (f'+${fl << 30:08X}' if fl else '')
            out.append(f'\tdc.l\t{expr}'.expandtabs(8).ljust(48) + f'; hunk {h.n}: {h.type}, {4 * (s & 0x3FFFFFFF)} bytes')
        out.append('\tendc')
        for h in self.hunks:
            n, size = h.n, self.size[h.n]
            fl = h.type_word >> 30
            if fl != hd['sizes'][n] >> 30:
                raise SystemExit(f'hunk {n}: memory flags differ between the header and the hunk')
            out += ['', ';' + '=' * 79, f'; Hunk {n}: {h.type.upper()}, ${size:X} bytes'
                    + {1: ' (chip RAM)', 2: ' (fast RAM)'}.get(fl, '')]
            for l in htext.get(n, '').strip('\n').split('\n'):
                if l:
                    out.append('; ' + l)
            out += [';' + '=' * 79, f'\t{HUNK_MACRO[(h.type, fl)]}\th{n:03d}']
            a, end = vb(n), vb(n) + size
            if h.type == 'bss':
                offs = sorted(x for x in self.labset if a <= x < end)
                for x, y in zip(offs, offs[1:] + [end]):
                    out.append(f'{self.lname(x)}:')
                    out.append(f'\tds.b\t${y - x:X}'.expandtabs(8).ljust(48) + f'; {self.loc(x)}')
                if offs and offs[0] != a or (not offs and size):
                    raise SystemExit(f'hunk {n}: BSS starts without a label')
                a = end
            while a < end:
                if a in hdrs:
                    out += ['', ';' + '-' * 79] + [('; ' + l) if l else ';' for l in hdrs[a].strip('\n').split('\n')] + [';' + '-' * 79]
                if a in self.labset:
                    out.append(f'{self.lname(a)}:')
                if h.type == 'code' and a in self.ins:
                    sz, m, op, hx = self.ins[a]
                    mn, o = self.numeric(m, op)
                    c = cmts.get(a, '')
                    if a in self.bad:
                        out.extend(l + (f'  {mn} {o}' if i == 0 else '') for i, l in enumerate(self.emit_bytes(a, a + sz)))
                    else:
                        mn, o = self.convert(a, m, op)
                        out.append(f'\t{mn}\t{o}'.expandtabs(8).ljust(48) + f'; {self.loc(a)}' + (f'  {c}' if c else ''))
                    a += sz
                    continue
                e2 = a + 1
                while e2 < end and not (h.type == 'code' and e2 in self.ins) and e2 not in self.labset and e2 not in hdrs:
                    e2 += 1
                if a in self.rel and e2 < a + 4:
                    e2 = a + 4
                out.extend(self.emit_bytes(a, e2))
                a = e2
            out.append(f'h{n:03d}_end:')
            out += ['\tifnd\tHUNKEXE' + ('' if not (h.relocs or h.symbols) else '\t\t\t\t; the hunk\'s tables, as in the original file')]
            if h.type == 'bss':
                out += ['\tsection\tbin,code\t\t\t; (back from the offset section)', '\torg\t0']
            if h.relocs:
                out.append('\tdc.l\tHUNK_RELOC32')
                for t, offs in h.relocs:
                    out.append(f'\tdc.l\t{len(offs)},{t}'.expandtabs(8).ljust(48) + f'; {len(offs)} longs pointing into hunk {t}')
                    for i in range(0, len(offs), 8):
                        out.append('\tdc.l\t' + ','.join(f'${x:X}' for x in offs[i:i + 8]))
                out.append('\tdc.l\t0')
            if h.symbols:
                out.append('\tdc.l\tHUNK_SYMBOL')
                for nm, k, off in h.symbols:
                    s = nm.rstrip(b'\0')
                    want = s.decode('latin-1')
                    want = f'h{n:03d}_{want[1:]}' if want.startswith('.') else want
                    v = vb(n) + off
                    target = want if self.names.get(v) == want and v in self.labset else f'${off:X}'
                    pad = ',0' * (len(nm) - len(s))
                    out.append(f"\tdc.l\t{k}\n\tdc.b\t'{s.decode('latin-1')}'{pad}\n\tdc.l\t{target}")
                out.append('\tdc.l\t0')
            out += ['\tdc.l\tHUNK_END', '\tendc']
        return out


PART_LIMIT = 200_000            # bytes: a file stays well under what GitHub shows in the browser


def write_tree(lines, outdir, main='f18_main.s'):
    """Write the source as f18_main.s (prologue, hunk header, and an include per hunk) and one
    file per non-empty hunk in src/ (hNNN_type.s; the hand-edited source has since renamed them
    hNNN_type_contents.s); a hunk bigger than PART_LIMIT is split at routine boundaries
    (hNNN_type_partK.s). Empty hunks stay in f18_main.s."""
    blocks, cur, head = [], None, []
    i = 0
    while i < len(lines):                       # a hunk's block starts at its ';====' heading
        m = re.match(r'^; Hunk (\d+): (\w+)', lines[i + 1]) if i + 1 < len(lines) and lines[i].startswith(';===') else None
        if m:
            if cur is None and head and head[-1] == '':
                head.pop()
            cur = [int(m.group(1)), m.group(2).lower(), []]
            blocks.append(cur)
            if cur and cur[2] == [] and blocks[-2:-1] and blocks[-2][2] and blocks[-2][2][-1] == '':
                blocks[-2][2].pop()
        (cur[2] if cur else head).append(lines[i])
        i += 1
    os.makedirs(os.path.join(outdir, 'src'), exist_ok=True)
    out = head + ['']
    for n, typ, bl in blocks:
        body = [l for l in bl]
        has = any(re.match(r'^\S+:', l) and not re.match(rf'^h{n:03d}(_end)?:', l) for l in body) or \
            any(l.startswith('\t') and not l.startswith(('\tifnd', '\tendc', '\tdc.l\tHUNK_END', '\tsection', '\torg')) and 'HUNK' not in l for l in body)
        if not has:
            out += body + ['']
            continue
        parts, p, size = [[]], 0, 0
        for l in body:
            # a routine header box (';---' then '; name - ...') or a label starts a new part when full
            if size > PART_LIMIT and (l.startswith(';---') or (re.match(r'^sub_\S+:', l) and not parts[-1][-1].startswith(';'))):
                parts.append([])
                size = 0
            parts[-1].append(l)
            size += len(l) + 1
        names = [f'h{n:03d}_{typ}.s'] if len(parts) == 1 else [f'h{n:03d}_{typ}_part{k + 1}.s' for k in range(len(parts))]
        for k, (nm, pl) in enumerate(zip(names, parts)):
            hdr = [f'; F/A-18 Interceptor - hunk {n} ({typ})' + (f', part {k + 1} of {len(parts)}' if len(parts) > 1 else ''),
                   f'; Included by ../{main}.', '']
            open(os.path.join(outdir, 'src', nm), 'w').write('\n'.join(hdr + pl) + '\n')
            out.append(f'\tinclude\t"src/{nm}"')
        out.append('')
    open(os.path.join(outdir, main), 'w').write('\n'.join(out).rstrip('\n') + '\n')
