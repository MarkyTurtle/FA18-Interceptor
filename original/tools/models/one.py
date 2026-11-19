import sys, render, drawmodel as dm
kind, n, yaw, pitch, out = sys.argv[1], int(sys.argv[2], 0), float(sys.argv[3]), float(sys.argv[4]), sys.argv[5]
pal = render.palette()
dist = int(sys.argv[6], 0) if len(sys.argv) > 6 else 0x40000
prims = dm.draw(0, model=n, yaw=yaw, pitch=pitch, dist=dist) if kind == 'm' else dm.draw(n, yaw=yaw, pitch=pitch, dist=dist)
prims = [p for p in prims if p[1] != 0 and (p[1] & 0xFF00) != 0xFC00]   # the shadows
render.render(prims, pal, size=int(sys.argv[7]) if len(sys.argv) > 7 else 240,
              bg=pal[6] if kind == 's' else pal[5], width=2 if kind == 's' else 1).save(out)
print(len(prims))
