"""Rename labels across the source (f18_main.s and src/*.s) and add their descriptions, then
check the build still gives the original bytes.

  python3 tools/rename.py NAMES.txt [--no-check]

NAMES.txt, one label per line ('#' starts a comment line):

  OLD  NEW  [- description]
  OLD  NEW  - !description        (replaces the label's existing header or comment)

* OLD is renamed NEW everywhere (whole words only). OLD may already be NEW: then only the
  description is added.
* With a description, a routine (a code label) gets a header box above it, a data label a
  comment line above it; nothing is added if the label already has one. A description may
  run on to the next lines when they start with whitespace (joined, then wrapped).

Then build.py runs: the bytes and the loaded image must not change.
"""
import os, re, subprocess, sys, textwrap

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.normpath(os.path.join(HERE, '..'))
WIDTH = 95
COMMENT_COL = 48        # where an instruction's '; offset' comment starts


def source_files():
    return [os.path.join(ROOT, 'f18_main.s')] + sorted(
        os.path.join(ROOT, 'src', f) for f in os.listdir(os.path.join(ROOT, 'src')) if f.endswith('.s'))


def read_names(path):
    out, cur = [], None
    for ln in open(path, encoding='utf-8'):
        if not ln.strip() or ln.lstrip().startswith('#'):
            continue
        if ln[0] in ' \t' and cur:
            cur[2] = (cur[2] + ' ' + ln.strip()).strip()
            continue
        m = re.match(r'^(\S+)\s+(\S+)(?:\s+-\s+(.*))?$', ln.rstrip('\n'))
        if not m:
            raise SystemExit(f'{path}: cannot read: {ln.rstrip()}')
        cur = [m.group(1), m.group(2), (m.group(3) or '').strip()]
        out.append(cur)
    return out


def main():
    args = [a for a in sys.argv[1:] if not a.startswith('--')]
    names = read_names(args[0])
    ren = {o: n for o, n, d in names if o != n}
    if len(set(ren.values())) != len(ren):
        raise SystemExit('two labels renamed to the same name')
    desc = {n: d for o, n, d in names if d}
    word = re.compile(r'(?<![\w.$])(' + '|'.join(sorted(map(re.escape, ren), key=len, reverse=True)) + r')(?![\w])') if ren else None
    files = {f: open(f, encoding='utf-8').read().split('\n') for f in source_files()}
    defined = set()
    for f, lines in files.items():
        for i, l in enumerate(lines):
            m = re.match(r'^([A-Za-z_.][\w.]*):', l)
            if m:
                defined.add(m.group(1))
    clash = [n for n in ren.values() if n in defined and n not in ren]
    if clash:
        raise SystemExit(f'already defined: {clash[:10]}')
    missing = [o for o in ren if o not in defined]
    if missing:
        raise SystemExit(f'not defined: {missing[:10]}')
    for f, lines in files.items():
        out = []
        for i, l in enumerate(lines):
            if word:
                code, sep, cmt = l.partition(';')
                new = word.sub(lambda m: ren[m.group(1)], code)
                if new != code and sep and code.startswith(' '):
                    new = new.rstrip().expandtabs(8)
                    new = new.ljust(COMMENT_COL) if len(new) < COMMENT_COL else new + ' '
                l = new + sep + cmt
            m = re.match(r'^([A-Za-z_.][\w.]*):', l)
            if m and m.group(1) in desc:
                text0 = desc[m.group(1)]
                if text0.startswith('!') and out and out[-1].startswith(';'):    # replace the old header
                    if out[-1].startswith(';---'):
                        j = len(out) - 2
                        while j >= 0 and not out[j].startswith(';---'):
                            j -= 1
                        del out[j:]
                    else:
                        while out and out[-1].startswith('; '):
                            out.pop()
                prev = out[-1] if out else ''
                if not prev.startswith(';'):
                    code_label = not m.group(1).startswith(('dat_', 'g_', 'v_')) and is_code(lines, i)
                    text = f'{m.group(1)} - {desc[m.group(1)].lstrip("!").strip()}'
                    wrapped = textwrap.wrap(text, WIDTH - 2)
                    if code_label:
                        if out and out[-1] != '':
                            out.append('')
                        out += [';' + '-' * 79] + ['; ' + w for w in wrapped] + [';' + '-' * 79]
                    else:
                        out += ['; ' + w for w in wrapped]
            out.append(l)
        files[f] = out
    for f, lines in files.items():
        open(f, 'w', encoding='utf-8', newline='\n').write('\n'.join(lines))
    print(f'{len(ren)} renamed, {len(desc)} described')
    if '--no-check' not in sys.argv:
        sys.exit(subprocess.run([sys.executable, os.path.join(ROOT, 'build.py')]).returncode)


def is_code(lines, i):
    for nxt in lines[i + 1:i + 4]:
        if nxt.startswith(' ' * 8) and not nxt.strip().startswith(('dc.', 'ds.', 'dcb.')):
            return True
        if nxt.strip().startswith(('dc.', 'ds.', 'dcb.')):
            return False
    return False


if __name__ == '__main__':
    main()
