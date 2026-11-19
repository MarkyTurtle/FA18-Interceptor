"""Render what drawmodel captured into a PNG, with the game's own palette."""
import os, struct
from PIL import Image, ImageDraw
import drawmodel as dm

g = dm.g


def palette(label=None):
    if label is None or label == 'inst5':
        d = open(os.path.join(dm.ROOT if hasattr(dm, 'ROOT') else '', 'disk', 'files', 'F-18 Interceptor', 'pix', 'inst5'), 'rb').read()
        i = d.index(b'CMAP'); n = int.from_bytes(d[i + 4:i + 8], 'big'); c = d[i + 8:i + 8 + n]
        return [tuple(c[j:j + 3]) for j in range(0, n, 3)]
    return _palette(label)


def _palette(label):
    a = g[label]
    out = []
    for i in range(32):
        v = g.uw(a + i * 2)
        out.append((((v >> 8) & 15) * 17, ((v >> 4) & 15) * 17, (v & 15) * 17))
    return out


def project(prims, size, margin=12):
    pts = []
    for kind, col, ps in prims:
        for x, y, z in ps:
            if z > 0:
                pts.append((x / z, -y / z))
    if not pts:
        return None
    x0 = min(p[0] for p in pts); x1 = max(p[0] for p in pts)
    y0 = min(p[1] for p in pts); y1 = max(p[1] for p in pts)
    s = (size - 2 * margin) / max(x1 - x0, y1 - y0, 1e-9)
    ox = margin + ((size - 2 * margin) - (x1 - x0) * s) / 2 - x0 * s
    oy = margin + ((size - 2 * margin) - (y1 - y0) * s) / 2 - y0 * s
    return lambda p: (ox + p[0] / p[2] * s, oy - p[1] / p[2] * s)


def render(prims, pal, size=320, bg=(64, 64, 112), width=1):
    im = Image.new('RGB', (size, size), bg)
    d = ImageDraw.Draw(im)
    pr = project(prims, size)
    if pr is None:
        return im
    for kind, col, ps in prims:
        c = pal[col & 15]
        ps = [p for p in ps if p[2] > 0]
        if not ps:
            continue
        xy = [pr(p) for p in ps]
        if kind == 'poly' and len(xy) >= 3:
            d.polygon(xy, fill=c)
        elif kind == 'poly' or kind == 'line':
            d.line(xy, fill=c, width=width)
        else:
            d.point(xy, fill=c)
    return im


if __name__ == '__main__':
    import sys
    pal = palette(sys.argv[2] if len(sys.argv) > 2 else 'dat_021_00000')
    a = sys.argv[1]
    prims = dm.draw(0, model=int(a[1:], 0)) if a.startswith('m') else dm.draw(int(a, 0))
    render(prims, pal).save('/tmp/out.png')
    print(len(prims))
