"""Read an AmigaDOS hunk executable into its blocks, in file order, keeping everything needed to
write it back byte for byte (memory flags, reloc order, symbol name padding).

  hunks = parse(data)      -> header dict, list of Hunk
  image(hunks)             -> the loaded image: [(type, alloc size, data, {target: sorted offsets})]
"""
import struct

HUNK_CODE, HUNK_DATA, HUNK_BSS = 0x3E9, 0x3EA, 0x3EB
HUNK_RELOC32, HUNK_SYMBOL, HUNK_DEBUG, HUNK_END, HUNK_HEADER = 0x3EC, 0x3F0, 0x3F1, 0x3F2, 0x3F3
TYPE_NAME = {HUNK_CODE: 'code', HUNK_DATA: 'data', HUNK_BSS: 'bss'}


class Hunk:
    def __init__(self, n):
        self.n = n
        self.type = None          # 'code' / 'data' / 'bss'
        self.type_word = None     # the block id as stored (memory flags in the top bits too)
        self.nlongs = 0           # data longs as stored in the block (bss: the size)
        self.data = b''
        self.relocs = []          # [(target, [offsets in file order])] in file order
        self.symbols = []         # [(name bytes incl. padding, name length in longs, offset)]
        self.blocks = []          # block ids in file order (to check nothing unexpected is there)


def parse(d):
    p = 0

    def L():
        nonlocal p
        v = struct.unpack_from('>I', d, p)[0]
        p += 4
        return v
    if L() != HUNK_HEADER:
        raise ValueError('not a hunk executable')
    names = []
    while True:
        n = L()
        if n == 0:
            break
        names.append(d[p:p + 4 * n]); p += 4 * n
    count, first, last = L(), L(), L()
    sizes = [L() for _ in range(last - first + 1)]
    hdr = {'libs': names, 'count': count, 'first': first, 'last': last, 'sizes': sizes}
    hunks = []
    h = None
    while p < len(d):
        bid = L()
        kind = bid & 0x3FFFFFFF
        if h is None:
            h = Hunk(len(hunks))
        h.blocks.append(kind)
        if kind in (HUNK_CODE, HUNK_DATA, HUNK_BSS):
            h.type, h.type_word = TYPE_NAME[kind], bid
            h.nlongs = L()
            if kind != HUNK_BSS:
                h.data = d[p:p + 4 * h.nlongs]; p += 4 * h.nlongs
        elif kind == HUNK_RELOC32:
            while True:
                n = L()
                if n == 0:
                    break
                t = L()
                h.relocs.append((t, [L() for _ in range(n)]))
        elif kind == HUNK_SYMBOL:
            while True:
                n = L()
                if n == 0:
                    break
                nm = d[p:p + 4 * n]; p += 4 * n
                h.symbols.append((nm, n, L()))
        elif kind == HUNK_END:
            hunks.append(h)
            h = None
        else:
            raise ValueError(f'hunk {len(hunks)}: unexpected block ${bid:X} at file ${p - 4:X}')
    if h is not None:
        raise ValueError('file ends inside a hunk')
    return hdr, hunks


def image(hdr, hunks):
    """What LoadSeg makes of it: each hunk's type, allocated size, contents and relocations."""
    out = []
    for h, sz in zip(hunks, hdr['sizes']):
        rel = {}
        for t, offs in h.relocs:
            rel.setdefault(t, []).extend(offs)
        out.append((h.type, (sz & 0x3FFFFFFF) * 4, h.data, {t: sorted(v) for t, v in rel.items()}))
    return out
