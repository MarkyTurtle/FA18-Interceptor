"""Decode dump's raw MFM tracks (AmigaDOS: 11 sectors, $4489 sync) into an ADF.

  python3 tools/disk/ipf_to_adf.py TRACKDIR OUT.adf

Every sector's header and data checksums must be good and every track complete (all 160 tracks
of the F/A-18 Interceptor disk are: it has no copy protection on the tracks); otherwise it says
which and stops. Tracks 160-163 (cylinders 80-81) in the IPF are empty and are not part of it.
"""
import os, struct, sys

SYNC = '0100010010001001' * 2          # $4489 $4489


def track_bits(fn):
    d = open(fn, 'rb').read()
    n = struct.unpack('<I', d[:4])[0]
    s = bin(int.from_bytes(d[4:], 'big'))[2:].zfill(8 * (len(d) - 4))[:n]
    return s + s, n                    # twice round: a sector may run over the index


def longs(s, pos, n):
    """n AmigaDOS longs (odd bits, then even bits) from bit pos; and the raw MFM longs"""
    raw = [int(s[pos + 32 * i:pos + 32 * i + 32], 2) for i in range(2 * n)]
    return [((o & 0x55555555) << 1) | (e & 0x55555555) for o, e in zip(raw[:n], raw[n:])], raw


def checksum(raw):
    c = 0
    for x in raw:
        c ^= x
    return c & 0x55555555


def decode_track(fn, t):
    s, n = track_bits(fn)
    found, p = {}, s.find(SYNC)
    while 0 <= p < n:
        q = p + 32
        (info,), ri = longs(s, q, 1)
        _, rl = longs(s, q + 64, 4)
        (hc,), _ = longs(s, q + 320, 1)
        (dc,), _ = longs(s, q + 384, 1)
        data, rd = longs(s, q + 448, 128)
        fmt, trk, sec = info >> 24, (info >> 16) & 255, (info >> 8) & 255
        if fmt == 0xFF and trk == t and sec < 11 and checksum(ri + rl) == hc and checksum(rd) == dc:
            found.setdefault(sec, b''.join(struct.pack('>I', x) for x in data))
        p = s.find(SYNC, p + 32)
    return found


def main():
    tdir, out = sys.argv[1], sys.argv[2]
    adf = bytearray()
    bad = []
    for t in range(160):
        sec = decode_track(os.path.join(tdir, f't{t:03d}.bin'), t)
        if len(sec) != 11:
            bad.append(f'track {t}: {len(sec)} good sectors of 11')
        adf += b''.join(sec.get(k, bytes(512)) for k in range(11))
    if bad:
        raise SystemExit('\n'.join(bad))
    open(out, 'wb').write(adf)
    print(f'{out}: 160 tracks, every sector good')


if __name__ == '__main__':
    main()
