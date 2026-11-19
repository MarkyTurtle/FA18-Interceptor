"""Assemble the game's executable from f18_main.s and check it against the file on the disk:

  * vasm -Fbin: byte for byte (SHA-1) - the source reproduces the original file;
  * vasm -Fhunkexe -DHUNKEXE: the executable vasm makes from the labels loads to the same image
    (every hunk's contents and relocations) - so every address in the source is a label, and
    the source can be changed and still make a working program.

  python original/build.py          (needs vasmm68k_mot on the PATH, and Python 3)
"""
import hashlib, os, subprocess, sys

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(HERE, 'tools', 'disasm'))
import hunkfile

MAIN_SHA1 = '0f64b302d22f4d1df1872d2f817a507d193c3ee8'
ORIGINAL = os.path.join(HERE, 'disk', 'files', 'F-18 Interceptor', 'F-18 Interceptor')
VASM = ['vasmm68k_mot', '-m68000', '-no-opt', '-quiet']


def vasm(args, cwd):
    r = subprocess.run(VASM + args, cwd=cwd, capture_output=True, text=True)
    if r.returncode:
        sys.stdout.write(r.stdout + r.stderr)
    return r.returncode == 0


def check(d=HERE):
    ok = True
    out = os.path.join(d, 'f18_main.exe')
    if not vasm(['-Fbin', '-o', 'f18_main.exe', 'f18_main.s'], d):
        print('f18_main.s: vasm -Fbin failed')
        return False
    got = hashlib.sha1(open(out, 'rb').read()).hexdigest()
    print(f'f18_main.exe: {"OK" if got == MAIN_SHA1 else f"MISMATCH ({got})"}')
    ok &= got == MAIN_SHA1
    if not vasm(['-Fhunkexe', '-kick1hunks', '-nosym', '-DHUNKEXE', '-o', 'f18_check.exe', 'f18_main.s'], d):
        print('f18_main.s: vasm -Fhunkexe failed')
        return False
    want = hunkfile.image(*hunkfile.parse(open(ORIGINAL, 'rb').read()))
    have = hunkfile.image(*hunkfile.parse(open(os.path.join(d, 'f18_check.exe'), 'rb').read()))
    diff = [n for n, (x, y) in enumerate(zip(want, have)) if x != y]
    same = len(want) == len(have) and not diff
    print(f'f18_check.exe (-Fhunkexe): {"OK, the same image" if same else "DIFFERENT"}'
          + ('' if same else f' ({len(have)} hunks of {len(want)}; differing: {diff[:10]})'))
    return ok and same


if __name__ == '__main__':
    sys.exit(0 if check() else 1)
