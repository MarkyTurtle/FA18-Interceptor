"""Draw a whole view as the game does: set up a flight in the emulator with the game's own
routines, run the 3D stages of a frame, and capture what reaches the screen - the filled
polygons (after clipping and projection, from dat_072_03000), the lines (DrawLine) and the points
(Plot...) - in screen coordinates. Then paint them, in order, into a 320 x 180 picture.

scene.py [START [HEADING [PITCH [OUT]]]]   START a StartPoints entry (0-4), HEADING in degrees."""
import sys
from PIL import Image, ImageDraw
from unicorn.m68k_const import *
import drawmodel as dm, render

g = dm.g
OUT = []
for name in ('sub_019_00018', 'sub_035_001DA', 'PlotPoint3D'):   # let the game draw these itself
    g.hooks.pop(g[name], None)


def reg(r):
    v = g.reg(r) & 0xFFFF
    return v - 0x10000 if v & 0x8000 else v


def cap_fill(gm):
    a = gm['dat_072_03000']
    n = gm.w(a)
    OUT.append(('poly', gm.uw(gm['DrawColour']), [(gm.w(a + 2 + i * 4), gm.w(a + 4 + i * 4)) for i in range(n)]))
    return 0


def cap_line(gm):
    OUT.append(('line', gm.uw(gm['DrawColour']),
                [(reg(UC_M68K_REG_D0), reg(UC_M68K_REG_D1)), (reg(UC_M68K_REG_D2), reg(UC_M68K_REG_D3))]))
    return 0


def cap_point(size):
    def f(gm):
        OUT.append(('point%d' % size, gm.uw(gm['DrawColour']), [(reg(UC_M68K_REG_D0), reg(UC_M68K_REG_D1))]))
        return 0
    return f


g.hook('sub_036_00AB8', cap_fill)
g.hook('DrawLine', cap_line)
g.hook('Plot', cap_point(1))
g.hook('Plot2', cap_point(2))
g.hook('PlotBig', cap_point(2))

SETUP = ('BuildSceneryBits', 'ResetGame', 'SetupMode', 'sub_004_00268', 'sub_004_00392')
FRAME = ('UpdateViewCell', 'SetupCamera', 'SetCockpitEye', 'SetViewOctant', 'SetHeightBand',
         'UpdateScenery', 'ShakeView', 'ClearRadarList', 'DrawSkyAndGround', 'DrawWaterAreas',
         'DrawSun', 'DrawFarScenery0', 'DrawFarScenery1', 'DrawGroundDots', 'sub_023_00000',
         'DrawObjects', 'sub_000_072DC')


SKY = {}


def run(names, verbose=False):
    for n in names:
        try:
            g.call(n, limit=30_000_000)
            if n == 'DrawSkyAndGround':
                keep_sky()
        except Exception as e:
            print('error in', n, e)


def view(start=0, heading=None, pitch=None, mode=1):
    run(SETUP[:2])
    g.setb(g['GameMode'], mode)
    g.setb(g['StartPoint'], start)
    run(SETUP[2:])
    rec = g['ObjectTable']
    if heading is not None or pitch is not None:
        h = g.w(rec + 0x68) if heading is None else int(heading * 80) % 0x7080
        p = g.w(rec + 0x66) if pitch is None else int(pitch * 80)
        g.setw(rec + 0x66, p); g.setw(rec + 0x68, h)
        g.call('SetAttitude', {UC_M68K_REG_A1: rec, UC_M68K_REG_D4: p % 0x7080, UC_M68K_REG_D5: h, UC_M68K_REG_D6: 0})
    OUT.clear()
    run(FRAME)
    return list(OUT)


def keep_sky():
    """After DrawSkyAndGround: the background it made by blitter (ClearSkyGround), which the
    emulator does not draw - the ground colour (4 land, 6 sea when SeaView is set) and the sky
    polygon (colour 5) that MakeSkyPolygon left at dat_072_03000 (dat_071_0026E set)."""
    a = g['dat_072_03000']
    SKY['sea'] = g.b(g['SeaView']) != 0
    SKY['poly'] = [(g.w(a + 2 + i * 4), g.w(a + 4 + i * 4)) for i in range(g.w(a))] \
        if g.b(g['dat_071_0026E']) else []


def paint(prims, scale=3, horizon=None):
    """The background as the game makes it (keep_sky): the ground colour, then the sky polygon;
    without one (no DrawSkyAndGround run), sky above `horizon`. Then the primitives in order."""
    pal = render.palette()
    d = None
    if 'poly' in SKY:
        im = Image.new('RGB', (320 * scale, 180 * scale), pal[6 if SKY['sea'] else 4])
        d = ImageDraw.Draw(im)
        if len(SKY['poly']) >= 3:
            d.polygon([((x + 0.5) * scale, (y + 0.5) * scale) for x, y in SKY['poly']], fill=pal[5])
    else:
        im = Image.new('RGB', (320 * scale, 180 * scale), pal[5])
        d = ImageDraw.Draw(im)
        if horizon is not None:
            d.rectangle([0, horizon * scale, 320 * scale, 180 * scale], fill=pal[4])
    for kind, col, ps in prims:
        c = pal[col & 15]
        xy = [((x + 0.5) * scale, (y + 0.5) * scale) for x, y in ps]
        if kind == 'poly' and len(xy) >= 3:
            d.polygon(xy, fill=c)
        elif kind == 'line':
            d.line(xy, fill=c, width=scale)
        else:
            w = scale * (2 if kind == 'point2' else 1)
            for x, y in xy:
                d.rectangle([x - scale / 2, y - scale / 2, x - scale / 2 + w - 1, y + scale / 2 - 1], fill=c)
    return im


if __name__ == '__main__':
    a = sys.argv[1:]
    prims = view(int(a[0]) if a else 0, float(a[1]) if len(a) > 1 and a[1] else None, float(a[2]) if len(a) > 2 and a[2] else None)
    print(len(prims), 'drawn')
    rec = g['ObjectTable']
    import math
    hz = 90 - 90 * math.tan(g.w(rec + 0x66) / 80 * math.pi / 180)
    paint(prims, horizon=hz).save(a[3] if len(a) > 3 else 'out/scene.png')
