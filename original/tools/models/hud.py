"""The head-up display as the game draws it: a flight is set up in the emulator (views.fly), then
DrawHUD runs and its lines, pixels and digits are captured and painted over the 3D view.
Digits are written straight into the bit-planes (DrawCharPlane), which the tool does not
render, so each is captured at DrawCharPlane's first plane and drawn with a small font here.
The emulator gets the BCD instructions (abcd/sbcd) wrong, so a scale's later labels can repeat
a number (32 33 33 instead of 32 33 34)."""
import sys
from unicorn import UC_HOOK_CODE
from unicorn.m68k_const import *
from PIL import ImageDraw
import views, scene, render
g = scene.g
CHARS = []


def _sx(v):
    v &= 0xFFFF
    return v - 0x10000 if v & 0x8000 else v


def plot_core(uc, addr, size, _):
    scene.OUT.append(('point1', g.uw(g['DrawColour']), [(_sx(uc.reg_read(UC_M68K_REG_D0)), _sx(uc.reg_read(UC_M68K_REG_D1)))]))


def char_plane(uc, addr, size, _):
    a5 = uc.reg_read(UC_M68K_REG_A5); d1 = uc.reg_read(UC_M68K_REG_D1); d5 = uc.reg_read(UC_M68K_REG_D5)
    if (g.l(a5) + d5) & 0xFFFFFFFF != d1:
        return                                  # one of the other three planes
    off = d5 & 0xFFFF
    ch = chr(g.b(uc.reg_read(UC_M68K_REG_A2) - 1))
    x = (off % 40) * 8 + ((uc.reg_read(UC_M68K_REG_D2) >> 12) & 15)
    c = (x, off // 40, ch, g.b(g['dat_071_00325']) & 15)
    if c not in CHARS:                          # the planes may share an address here
        CHARS.append(c)


g.uc.hook_add(UC_HOOK_CODE, plot_core, begin=g['PlotCore'], end=g['PlotCore'])
g.uc.hook_add(UC_HOOK_CODE, char_plane, begin=g['DrawCharPlane'], end=g['DrawCharPlane'])


def hud(speed=0x400, flying=True, aircraft=0x11, weapon=0, target=None, rng=0x600, frames=1, **kw):
    """aircraft: $11 the F/A-18, $10 the F-16 (PlayerAircraftType). weapon: the player's +$63
    ($10 the gun, $20 the Sidewinder, $30 the AMRAAM). target: where a locked target (object 8,
    at range rng) is on the screen; the head-up display then runs `frames` frames, so that the
    target box can slide onto it and the seeker follow."""
    im = views.fly(**kw)
    rec = g['ObjectTable']
    g.setw(rec + 0x6E, speed)
    g.setb(g['OutsideView'], 0)
    g.setw(g['ViewX'], 0); g.setw(g['ViewY'], 0)      # the cockpit view, not panned
    g.setw(g['ViewShift'], 0)                      # the digits' byte offset to match
    g.setb(rec + 0x62, aircraft)
    g.setb(g['HUDOn'], 1 if flying else 0)
    g.setb(rec + 0x63, weapon)
    if target:
        tgt = rec + 8 * 0x200
        g.setw(tgt, g.uw(tgt) | 0x40)               # the object exists
        g.setw(rec + 0x4A, rng); g.setw(tgt + 0x4A, rng)
        g.setw(g['LockedTarget'], 8 * 0x200)
        g.setw(g['RadarScale'], 0x80 if weapon == 0x10 else 0x100)
    for _ in range(frames):
        if target:
            g.setw(g['TargetScreenPos'], target[0]); g.setw(g['TargetScreenPos'] + 2, target[1])
        scene.OUT.clear(); CHARS.clear()
        scene.run(['DrawHUD'])
    pal = render.palette()
    s = im.size[0] // 320
    d = ImageDraw.Draw(im)
    for kind, col, pts in scene.OUT:
        c = pal[col & 15]
        if kind == 'line':
            d.line([(x * s + s // 2, y * s + s // 2) for x, y in pts], fill=c, width=s)
        elif kind.startswith('point'):
            for x, y in pts:
                d.rectangle([x * s, y * s, x * s + s - 1, y * s + s - 1], fill=c)
    for x, y, ch, col in CHARS:
        d.text((x * s, y * s - s), ch, fill=pal[col or 13])
    return im, list(scene.OUT), list(CHARS)


if __name__ == '__main__':
    for name, ac in (('fa18', 0x11), ('f16', 0x10)):
        im, prims, chars = hud(cell=(66, 69), height=0x18000, heading=330, pitch=-5, aircraft=ac)
        im.save('out/hud_%s.png' % name)
        print(name, len(prims), 'primitives;', ' '.join('%s@%d,%d' % (c[2], c[0], c[1]) for c in chars))
    for name, wp in (('gun', 0x10), ('missile', 0x20)):
        im, prims, chars = hud(cell=(66, 69), height=0x18000, heading=330, pitch=-5, weapon=wp,
                               target=(170, 84), frames=12)
        im.save('out/hud_%s.png' % name)
        print(name, len(prims), 'primitives;', ''.join(c[2] for c in chars))
    from PIL import Image
    ims = [Image.open('out/hud_%s.png' % n) for n in ('fa18', 'f16', 'gun', 'missile')]
    w, h = ims[0].size
    sheet = Image.new('RGB', (w * 2, h * 2))
    for i, im in enumerate(ims):
        sheet.paste(im, ((i % 2) * w, (i // 2) * h))
    sheet.resize((w, h)).save('out/hud.png')
