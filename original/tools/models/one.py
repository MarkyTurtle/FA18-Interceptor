"""Draw one model (m + ModelTable offset) or scenery shape (s + ObjectDrawTable entry) to a PNG.

one.py KIND N YAW PITCH OUT [DIST [SIZE [TIMER]]]

DIST 0 (the default) places the camera far enough for the whole shape to be in front of it.
TIMER sets the object's timer (+$4C), which picks the frame of the animated models."""
import sys, statistics, render, drawmodel as dm

kind, n, yaw, pitch, out = sys.argv[1], int(sys.argv[2], 0), float(sys.argv[3]), float(sys.argv[4]), sys.argv[5]
dist = int(sys.argv[6], 0) if len(sys.argv) > 6 else 0
size = int(sys.argv[7]) if len(sys.argv) > 7 else 240
timer = int(sys.argv[8], 0) if len(sys.argv) > 8 else 10
pal = render.palette()


def draw(d, lod):
    dm.g.setw(dm.g['ObjectTable'] + 512 + 0x4C, timer)
    p = dm.draw(0, model=n, yaw=yaw, pitch=pitch, dist=d, lod=lod) if kind == 'm' else \
        dm.draw(n, yaw=yaw, pitch=pitch, dist=d, lod=lod)
    return [q for q in p if q[1] & 15 != 0]           # colour 0: the shadows on the ground


def fits(prims):
    """Whether the shape is wholly well in front of the camera."""
    zs = [v[2] for _, _, ps in prims for v in ps]
    return not zs or min(zs) > 0.4 * statistics.median(zs)


best = []
for lod in (16, 12, 8, 6, 4, 2, 24, 40):          # the level with the most detail
    for d in ([dist] if dist else [0x40000, 0x80000, 0x100000, 0x200000, 0x400000]):
        prims = draw(d, lod)
        if fits(prims):
            break
    if len(prims) > len(best):
        best = prims
render.render(best, pal, size=size, bg=pal[6] if kind == 's' else pal[5],
              width=2 if kind == 's' else 1).save(out)
print(len(best))
