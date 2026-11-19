"""Extract every file of an AmigaDOS (OFS) disk image, keeping the disk's names and folders, and
check them against disk/SHA1SUMS.

  python3 tools/disk/extract_files.py F18Interceptor.adf [--out DIR]   (default: disk/files)

The volume, "F-18 Interceptor", becomes the folder disk/files/F-18 Interceptor/.
"""
import argparse, hashlib, os, struct, sys

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.normpath(os.path.join(HERE, '..', '..'))
T_HEADER, ST_ROOT, ST_DIR, ST_FILE = 2, 1, 2, -3


def blk(adf, n):
    return adf[512 * n:512 * n + 512]


def L(b, i):                          # long i (counted from the start; negative from the end)
    return struct.unpack_from('>i', b, 4 * i if i >= 0 else 512 + 4 * i)[0]


def name(b):
    return b[432 + 1:432 + 1 + b[432]].decode('latin-1')


def read_file(adf, b):
    size, out, n = struct.unpack_from('>I', b, 512 - 188)[0], bytearray(), L(b, 4)
    while n:                           # OFS data blocks: header 24 bytes, data, next block
        d = blk(adf, n)
        k = struct.unpack_from('>I', d, 12)[0]
        out += d[24:24 + k]
        n = struct.unpack_from('>I', d, 16)[0]
    if len(out) != size:
        raise SystemExit(f'{name(b)}: {len(out)} bytes read, the header says {size}')
    return bytes(out)


def walk(adf, b, path, files):
    for i in range(6, 6 + 72):         # the hash table
        n = L(b, i)
        while n:
            e = blk(adf, n)
            nm, st = name(e), L(e, -1)
            p = path + [nm]
            if st == ST_DIR:
                files.append(('dir', p, None))
                walk(adf, e, p, files)
            elif st == ST_FILE:
                files.append(('file', p, read_file(adf, e)))
            n = L(e, -4)               # next in the hash chain


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('adf')
    ap.add_argument('--out', default=os.path.join(ROOT, 'disk', 'files'))
    a = ap.parse_args()
    adf = open(a.adf, 'rb').read()
    if adf[:3] != b'DOS' or adf[3] != 0:
        raise SystemExit('not an OFS disk')
    root = blk(adf, 880)
    vol = name(root)
    files = []
    walk(adf, root, [vol], files)
    want = {}
    for ln in open(os.path.join(ROOT, 'disk', 'SHA1SUMS'), encoding='utf-8'):
        if ln.strip() and not ln.startswith('#'):
            sha, p = ln.rstrip('\n').split('  ', 1)
            want[p] = sha
    ok = True
    for kind, p, data in sorted(files, key=lambda f: [s.lower() for s in f[1]]):
        dest = os.path.join(a.out, *p)
        if kind == 'dir':
            os.makedirs(dest, exist_ok=True)
            continue
        os.makedirs(os.path.dirname(dest), exist_ok=True)
        open(dest, 'wb').write(data)
        rel = 'files/' + '/'.join(p)
        sha = hashlib.sha1(data).hexdigest()
        if want.get(rel) != sha:
            ok = False
            print(f'{rel}: {"not in SHA1SUMS" if rel not in want else "MISMATCH"}')
    print(f'{sum(1 for f in files if f[0] == "file")} files from "{vol}" to {a.out}' + ('' if ok else ' - NOT as SHA1SUMS says'))
    sys.exit(0 if ok else 1)


if __name__ == '__main__':
    main()
