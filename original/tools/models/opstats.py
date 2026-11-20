"""Which shape operations (ShapeOps) each model and scenery shape uses: hooks every operation's
routine and draws everything at several distances and levels of detail. Prints a table of
operation -> users, for working out the special operations."""
import struct, sys
from unicorn import UC_HOOK_CODE
import drawmodel as dm
g = dm.g
inv = {v: k for k, v in g.sym.items()}
ops = [struct.unpack('>I', g.uc.mem_read(g['ShapeOps'] + 4 * i, 4))[0] for i in range(78)]
byaddr = {}
for i, a in enumerate(ops):
    byaddr.setdefault(a, []).append(i * 4)
CUR = [None]
USED = {}
SEQ = []
KINDS = {}


def settle():
    for k, (op, at) in enumerate(SEQ):
        end = SEQ[k + 1][1] if k + 1 < len(SEQ) else len(dm.OUT)
        for p in dm.OUT[at:end]:
            c = KINDS.setdefault(op, {})
            key = '%s/%X' % (p[0], p[1] & 0xF)
            c[key] = c.get(key, 0) + 1
    SEQ.clear()


def hit(uc, addr, size, _):
    # the dispatch is "movea.l (a0,d0.w),a0 / jsr (a0)": d0 holds the op's offset
    from unicorn.m68k_const import UC_M68K_REG_D0
    op = uc.reg_read(UC_M68K_REG_D0) & 0x3FFF
    USED.setdefault(op, set()).add(CUR[0])
    SEQ.append((op, len(dm.OUT)))


for a in byaddr:
    g.uc.hook_add(UC_HOOK_CODE, hit, begin=a, end=a)

MODELS = list(range(0, 0x140, 0x14))
for m in MODELS:
    CUR[0] = 'm%02X' % m
    for dist in (0x8000, 0x20000, 0x80000, 0x200000):
        for yaw, pitch in ((0.6, 0.35), (3.5, -0.4)):
            try:
                dm.draw(0, yaw, pitch, dist=dist, model=m)
            except Exception:
                pass
            settle()
for n in range(17, 118):
    CUR[0] = 's%d' % n
    for dist in (0x8000, 0x20000, 0x80000):
        for yaw, pitch in ((0.45, 0.0), (0.45, 1.25), (3.6, 0.3)):
            try:
                dm.draw(n, yaw, pitch, dist=dist)
            except Exception:
                pass
            settle()
for op in sorted(USED):
    a = ops[op // 4]
    print('%02X %-24s %s' % (op, inv.get(a, hex(a)), ' '.join(sorted(u for u in USED[op] if u))))
    print('      draws:', ' '.join('%s x%d' % kv for kv in sorted(KINDS.get(op, {}).items())) or '-')
