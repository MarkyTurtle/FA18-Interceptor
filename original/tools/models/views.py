"""In-game views: the game's own frame drawn in the emulator (scene.py) from chosen places.

views.py            the views used in docs/MODELS.md, into out/view_*.png"""
import math, sys
from unicorn.m68k_const import *
import scene

g = scene.g


def fly(start=0, cell=None, height=None, heading=None, pitch=0.0):
    """A free flight from StartPoints entry `start`, then moved to map cell `cell` (x, z) at
    `height` (positive upwards), facing `heading` degrees, pitched `pitch` degrees; one frame
    is run to build the scenery lists and a second one drawn."""
    scene.run(scene.SETUP[:2])
    g.setb(g['GameMode'], 1)
    g.setb(g['StartPoint'], start)
    scene.run(scene.SETUP[2:])
    rec = g['ObjectTable']
    if cell is not None:
        g.setw(rec + 6, cell[0]); g.setw(rec + 8, cell[1])
        g.setl(rec + 0x14, (cell[0] << 22) | 0x200000)
        g.setl(rec + 0x1C, (cell[1] << 22) | 0x200000)
    if height is not None:
        g.setl(rec + 0x18, height)
    if heading is not None:
        g.call('SetAttitude', {UC_M68K_REG_A1: rec, UC_M68K_REG_D4: int(pitch * 80) % 0x7080,
                               UC_M68K_REG_D5: int(heading * 80) % 0x7080, UC_M68K_REG_D6: 0})
    scene.run(scene.FRAME)
    scene.OUT.clear()
    scene.run(scene.FRAME)
    hz = 90 + 90 * math.tan(g.w(rec + 0x66) / 80 * math.pi / 180) if g.w(rec + 0x66) < 0x3840 else \
        90 - 90 * math.tan((0x7080 - g.w(rec + 0x66)) / 80 * math.pi / 180)
    return scene.paint(list(scene.OUT), horizon=hz)


VIEWS = [
    ('runway', 'On the runway at the first free-flight start', dict(start=0)),
    ('runway2', 'The third free-flight start', dict(start=2)),
    ('carrier', 'On the carrier\'s deck', dict(start=3)),
    ('airfield', 'Over the airfield', dict(start=0, height=0x20000, heading=0)),
    ('baybridge', 'The Bay Bridge, from the south', dict(cell=(65, 69), height=0x10000, heading=45)),
    ('goldengate', 'Towards the Golden Gate, over the city', dict(cell=(66, 69), height=0x18000, heading=330)),
    ('sutro', 'The city and Sutro Tower', dict(cell=(66, 69), height=0x30000, heading=135)),
]

if __name__ == '__main__':
    for name, title, kw in VIEWS:
        fly(**kw).save('out/view_%s.png' % name)
        print(name)
