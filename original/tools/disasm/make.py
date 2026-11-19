"""Generate the source from its config, assemble it both ways with vasm and check it.

  python3 tools/disasm/make.py [--out DIR]       (default: tools/disasm/regen/)

Kept for the record: the source in original/ (f18_main.s and src/) was made by this from
main_cfg.py and is edited by hand since November 2026 - it is the source now, and this never
writes over it. It writes what the config gives (f18_main.s, src/, and the trace state,
tools/disasm/main_trace.json) to DIR, for comparing with the hand-edited source, then checks:
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
    ap.add_argument('--out', default=os.path.join(HERE, 'regen'))
    a = ap.parse_args()
    p = build(main_cfg)
    if os.path.abspath(a.out) == ROOT:
        raise SystemExit('the source in original/ is edited by hand: make.py does not write over it')
    os.makedirs(a.out, exist_ok=True)
    hunk.write_tree(p.generate(), a.out)
    p.save_trace()
    p.stats()
    print(f'  {len(p.tentative)} relocated pointers into code traced as routines')
    import shutil
    shutil.copy(os.path.join(ROOT, 'f18_hunks.i'), a.out)
    sys.path.insert(0, ROOT)
    import build as b
    ok = b.check(a.out)
    sys.exit(0 if ok else 1)


if __name__ == '__main__':
    main()
