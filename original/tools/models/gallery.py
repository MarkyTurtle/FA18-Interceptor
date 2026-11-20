"""Render every model and scenery shape (each in its own process: a few crash the emulator) and
put them on contact sheets."""
import subprocess, os, sys
from PIL import Image, ImageDraw

SIZE = 240
HERE = os.path.dirname(os.path.abspath(__file__))
OUT = os.environ.get('OUT', os.path.join(HERE, 'out'))
os.makedirs(OUT, exist_ok=True)

MODELS = [(0x00, 'Sidewinder'), (0x14, 'AMRAAM'), (0x28, 'Pilot and parachute'), (0x3C, 'F-16'),
          (0x50, 'F/A-18'), (0x64, 'Air Force One'), (0x78, 'MiG'), (0xA0, 'Aircraft carrier'),
          (0xC8, 'Cruise missile'), (0xDC, 'Rescue pod (box) on parachute'), (0xF0, 'Ship (F6, object 15)'),
          (0x118, 'Airliner (707/767)')]


def one(kind, n, yaw, pitch, dist, path):
    r = subprocess.run([sys.executable, 'one.py', kind, str(n), str(yaw), str(pitch), path, str(dist), str(SIZE)],
                       cwd=HERE, capture_output=True, text=True, timeout=120)
    try:
        return int(r.stdout.strip().split()[-1])
    except Exception:
        return None


def sheet(items, path, cols=4, size=240):
    rows = (len(items) + cols - 1) // cols
    im = Image.new('RGB', (cols * size, rows * (size + 18)), (20, 20, 30))
    d = ImageDraw.Draw(im)
    for i, (p, label) in enumerate(items):
        x, y = (i % cols) * size, (i // cols) * (size + 18)
        if p and os.path.exists(p):
            im.paste(Image.open(p), (x, y + 18))
        d.text((x + 4, y + 3), label, fill=(230, 230, 230))
    im.save(path)


if __name__ == '__main__':
    what = sys.argv[1]
    if what == 'models':
        items = []
        for n, name in MODELS:
            p = '%s/model_%03X.png' % (OUT, n)
            c = one('m', n, 2.5, 0.45, 0, p)
            items.append((p if c else None, '%s ($%02X)%s' % (name, n, '' if c else ': -')))
        sheet(items, OUT + '/models.png')
    else:
        lo, hi = int(sys.argv[2]), int(sys.argv[3])
        items = []
        for n in range(lo, hi):
            p = '%s/scenery_%03d.png' % (OUT, n)
            c = one('s', n, 2.5, -0.5, int(sys.argv[4], 0) if len(sys.argv) > 4 else 0x100000, p)
            items.append((p if c else None, 'Scenery %d%s' % (n, '' if c else ': -')))
        sheet(items, '%s/scenery_%d_%d.png' % (OUT, lo, hi - 1), cols=6, size=200)
