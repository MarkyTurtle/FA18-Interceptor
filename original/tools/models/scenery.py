"""Read the scenery maps (hunk 66) from the loaded game: the items of each map cell."""
import drawmodel as dm

g = dm.g
PLACES = [(-32 if b == 0xE0 else -96 if b == 0xA0 else 96 if b == 0x60 else 32) for b in
          g.uc.mem_read(g['dat_008_015EE'], 32)]


def cells(mapname='SceneryMap2'):
    """{(x, z): [(subcell, shape, dx, dz)]} for every cell of the map."""
    base = g[mapname]
    out = {}
    for row in range(128):
        a0 = base + g.w(base + row * 2)
        n = g.w(a0)
        if n < 0:
            continue
        cols = [g.w(a0 + 2 + k * 2) for k in range(n // 2)]
        ptab = a0 + n + 2
        for i, col in enumerate(cols):
            p = g.l(ptab + i * 4) & 0xFFFFFF
            items = []
            while True:
                h = g.b(p); p += 1
                if h == 0xFF:
                    break
                s = g.b(p); p += 1
                if s & 0x80:
                    k = (h >> 4) & 15
                    dx, dz = PLACES[k * 2], PLACES[k * 2 + 1]
                else:
                    dx, dz = g.w(p), g.w(p + 2); p += 4
                items.append((h & 15, s & 0x7F, dx, dz))
            out[(col, row)] = items
    return out


if __name__ == '__main__':
    import sys
    from collections import Counter
    c = cells(sys.argv[1] if len(sys.argv) > 1 else 'SceneryMap2')
    print(len(c), 'cells')
    for k in sorted(c, key=lambda k: -len(c[k]))[:15]:
        print(k, len(c[k]), sorted(Counter(i[1] for i in c[k]).items()))
    print([i for i in c[sorted(c, key=lambda k: -len(c[k]))[0]]][:12])
