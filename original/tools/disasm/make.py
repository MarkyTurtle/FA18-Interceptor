"""Generate f18_main.s from its config, assemble it both ways with vasm and check it.

  python3 tools/disasm/make.py [--out DIR]       (default: original/, the source itself)

Writes f18_main.s (and the trace state, tools/disasm/main_trace.json), then checks:
  * the -Fbin build is byte-identical to the executable on the disk;
  * the -Fhunkexe -DHUNKEXE build loads to the same image (contents and relocations).
"""
import argparse, hashlib, os, subprocess, sys

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.normpath(os.path.join(HERE, '..', '..'))
sys.path.insert(0, HERE)
import hunk, hunkfile
import main_cfg


def build(cfg):
    reject = set()
    while True:
        p = hunk.HunkProgram(cfg)
        p.reject = reject
        p.trace()
        p.verify()
        owners = {p.sweep_owner[a] for a in p.bad if a in getattr(p, 'sweep_owner', {})}
        if not owners:
            return p
        reject |= owners


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--out', default=ROOT)
    a = ap.parse_args()
    p = build(main_cfg)
    src = os.path.join(a.out, 'f18_main.s')
    open(src, 'w').write('\n'.join(p.generate()) + '\n')
    p.save_trace()
    p.stats()
    print(f'  {len(p.tentative)} relocated pointers into code traced as routines')
    if os.path.abspath(a.out) != ROOT:
        import shutil
        shutil.copy(os.path.join(ROOT, 'f18_hunks.i'), a.out)
    sys.path.insert(0, ROOT)
    import build as b
    ok = b.check(a.out)
    sys.exit(0 if ok else 1)


if __name__ == '__main__':
    main()
