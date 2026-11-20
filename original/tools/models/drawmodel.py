"""Run the game's DrawModel (in a 68000 emulator, f18emu) on one ObjectDrawTable entry and capture what it draws, in the
camera's space (before projection): filled polygons (ClipFillPolygon), lines and points."""
import math, struct
from f18emu import Game, ROOT
from unicorn.m68k_const import *

g = Game()
OUT = []


def cap_poly(gm):
    pb = gm['dat_072_03C00'] if 'dat_072_03C00' in gm.sym else gm['PolygonBuffer']
    shift = gm.w(pb); n = gm.w(pb + 2)
    pts = [(gm.w(pb + 4 + i * 6), gm.w(pb + 6 + i * 6), gm.w(pb + 8 + i * 6)) for i in range(n)]
    OUT.append(('poly', gm.uw(gm['DrawColour']), [tuple(c << shift for c in p) for p in pts]))
    return 0


def cap_line(gm):
    a = gm['dat_072_04202']
    p = [(gm.w(a + i * 6), gm.w(a + 2 + i * 6), gm.w(a + 4 + i * 6)) for i in range(2)]
    OUT.append(('line', gm.uw(gm['DrawColour']), p))
    return 0


def cap_point(gm):
    d = [gm.reg(r) for r in (UC_M68K_REG_D0, UC_M68K_REG_D1, UC_M68K_REG_D2)]
    d = [(x & 0xFFFF) - (0x10000 if x & 0x8000 else 0) for x in d]
    OUT.append(('point', gm.uw(gm['DrawColour']), [tuple(d)]))
    return 0


g.hook('sub_019_00018', cap_poly)   # ClipFillPolygon's second entry, used by most operations
g.hook('sub_035_001DA', cap_line)
g.hook('PlotPoint3D', cap_point)
for nm in ('Nop',):
    g.hook(nm, lambda gm: 0)


def rot(yaw, pitch, roll):
    """A rotation matrix (rows), 1.0 = $4000."""
    cy, sy = math.cos(yaw), math.sin(yaw)
    cp, sp = math.cos(pitch), math.sin(pitch)
    cr, sr = math.cos(roll), math.sin(roll)
    Ry = [[cy, 0, sy], [0, 1, 0], [-sy, 0, cy]]
    Rx = [[1, 0, 0], [0, cp, -sp], [0, sp, cp]]
    Rz = [[cr, -sr, 0], [sr, cr, 0], [0, 0, 1]]
    mul = lambda A, B: [[sum(A[i][k] * B[k][j] for k in range(3)) for j in range(3)] for i in range(3)]
    return mul(mul(Ry, Rx), Rz)


def draw(entry, yaw=0.6, pitch=0.35, roll=0.0, dist=0x40000, lod=16, obj=1, model=None, shift=0):
    """Draws ObjectDrawTable entry `entry` (or ModelTable offset `model`, copied into object
    `obj`'s entry) as object `obj`; returns the captured primitives."""
    OUT.clear()
    if model is not None:
        g.uc.mem_write(g['ObjectDrawTable'] + obj * 20, bytes(g.uc.mem_read(g['ModelTable'] + model, 20)))
        entry = obj
    odt = g['ObjectDrawTable'] + entry * 20
    rec = g['ObjectTable'] + obj * 512
    # copy the entry to the object's slot when drawing a scenery shape
    routine, mbase, now, nxt = (struct.unpack('>I', g.uc.mem_read(odt + i * 4, 4))[0] for i in range(4))
    g.setw(rec, 0x0040)                       # exists
    m = rot(yaw, pitch, roll)
    for i in range(3):                        # the object unrotated...
        for j in range(3):
            g.setw(rec + 0x92 + (i * 3 + j) * 2, 0x4000 if i == j else 0)
            g.setw(rec + 0x80 + (i * 3 + j) * 2, 0x4000 if i == j else 0)
    cam = g['dat_071_005A8']                  # ...and the camera turned round it instead
    for i in range(3):
        for j in range(3):
            g.setw(cam + (i * 3 + j) * 2, int(round(m[i][j] * 256)))
    # the object's position relative to the camera: R^T (0, 0, dist), so it ends up ahead
    px, py, pz = (int(round(m[2][k] * dist)) for k in range(3))
    g.setl(g['dat_071_00432'], px); g.setl(g['dat_071_00436'], py); g.setl(g['dat_071_0043A'], pz)
    for v in ('dat_071_00500', 'dat_071_00504', 'dat_071_00508', 'dat_071_0050C'):
        if v in g.sym: g.setl(g[v], 0)
    g.setl(g['dat_071_0050C'], py)            # the height offset the drawing uses
    if shift is None:                         # as the game: DistanceScale by the distance
        shift = g.b(g['DistanceScale'] + min(dist >> 13, 0xEF))
    g.setw(g['dat_071_00488'], shift)
    g.setw(g['dat_071_00510'], lod)
    g.setb(g['dat_071_001AD'], 1)
    g.setb(g['dat_071_0023C'], 1)
    g.setb(g['dat_071_0022B'], 0x10)
    g.setw(g['CurrentObject'], obj)
    g.setw(g['CurrentObjectOffset'], obj * 512)
    g.setw(g['ViewObject'], 0)
    g.setl(g['ShapeNow'], now)
    g.setl(g['ShapeNext'], nxt)
    # the camera's position against the object, /256: the plane tests of the drawing lists use it
    g.setw(g['dat_071_00442'], px >> 8); g.setw(g['dat_071_00442'] + 2, py >> 8); g.setw(g['dat_071_00446'], pz >> 8)
    g.setl(g['dat_071_00448'], py >> 8)
    for k in range(3):
        g.setw(g['dat_071_004FA'] + 2 * k, 0)
    if routine == g['DrawModel']:
        routine = g['DrawSceneryPlain']     # the same, without the own-aircraft checks
    g.call(routine, {UC_M68K_REG_A0: mbase})
    return list(OUT)


if __name__ == '__main__':
    import sys
    a = sys.argv[1]
    r = draw(0, model=int(a[1:], 0)) if a.startswith('m') else draw(int(a, 0))
    print(len(r))
    for x in r[:20]: print(x)
