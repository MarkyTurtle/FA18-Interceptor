"""Contact sheets of the scenery shapes: each drawn from the side and from above; the flat
ground shapes (DrawGroundShape) from a low angle and from above, on their own sheet."""
import os, sys, struct
from PIL import Image, ImageDraw
import gallery
gallery.SIZE = 180
import drawmodel as dm
g = dm.g
OUT = gallery.OUT
inv = {v: k for k, v in g.sym.items()}


def routine(n):
    return inv.get(struct.unpack('>I', g.uc.mem_read(g['ObjectDrawTable'] + n * 20, 4))[0])


def build(entries, path, cols=3, views=((0.45, 0.0), (0.45, 1.25))):
    S = gallery.SIZE
    cw, ch = 2 * S + 6, S + 18
    rows = (len(entries) + cols - 1) // cols
    im = Image.new('RGB', (cols * cw, rows * ch), (20, 20, 30))
    d = ImageDraw.Draw(im)
    for i, (n, label) in enumerate(entries):
        x, y = (i % cols) * cw, (i // cols) * ch
        for k, (yaw, pitch) in enumerate(views):
            p = '%s/s%03d_%d%s.png' % (OUT, n, k, '' if views[0][1] == 0.0 else 'g')
            if not os.path.exists(p):
                gallery.one('s', n, yaw, pitch, 0, p)
            if os.path.exists(p):
                im.paste(Image.open(p), (x + k * (S + 2), y + 18))
        d.text((x + 4, y + 3), label, fill=(230, 230, 230))
    im.save(path)


if __name__ == '__main__':
    names = dict(a.split('=', 1) for a in sys.argv[2:])
    skip = []
    ents = []
    for n in range(17, 118):
        r = routine(n)
        if r in ('DrawGroundShape', 'DrawGroundShapeFar'):
            skip.append(n); continue
        ents.append((n, 'Shape %d%s' % (n, (' - ' + names[str(n)]) if str(n) in names else '')))
    # the ground shapes (hunk 12's DrawGroundShape) are flat: seen from above and from a low angle
    build([(n, 'Shape %d%s' % (n, (' - ' + names[str(n)]) if str(n) in names else '')) for n in skip],
          OUT + '/scenery_ground.png', views=((0.45, 0.5), (0.45, 1.25)))
    half = (len(ents) + 1) // 2
    build(ents[:half], OUT + '/scenery_a.png')
    build(ents[half:], OUT + '/scenery_b.png')
