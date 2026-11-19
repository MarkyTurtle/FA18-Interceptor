"""Load F/A-18 Interceptor's executable into a 68000 emulator (unicorn) so its routines can
be run - here to draw the 3D models by calling the game's own DrawModel and capturing the
polygons, lines and points it produces."""
import struct, sys, os, subprocess
ROOT = os.path.normpath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', '..'))
sys.path.insert(0, os.path.join(ROOT, 'tools', 'disasm'))
import hunkfile
from unicorn import Uc, UC_ARCH_M68K, UC_MODE_BIG_ENDIAN, UC_HOOK_CODE, UcError
from unicorn.m68k_const import *

EXE = os.path.join(ROOT, 'tools', 'models', 'f18_sym.exe')   # assembled with its symbols


def assemble():
    """Assembles the source as a hunk executable keeping the labels (HUNK_SYMBOL)."""
    if not os.path.exists(EXE) or os.path.getmtime(EXE) < max(
            os.path.getmtime(os.path.join(ROOT, 'src', f)) for f in os.listdir(os.path.join(ROOT, 'src'))):
        subprocess.run(['vasmm68k_mot', '-Fhunkexe', '-kick1hunks', '-DHUNKEXE', '-m68000', '-no-opt',
                        '-quiet', '-o', EXE, 'f18_main.s'], cwd=ROOT, check=True,
                       stdin=subprocess.DEVNULL, stdout=subprocess.DEVNULL)
BASE = 0x10000
TRAMP = 0x7000                 # jsr routine ; then STOP
STOP = 0x7006
MEM = 0x200000


class Game:
    def __init__(self):
        assemble()
        hdr, hunks = hunkfile.parse(open(EXE, 'rb').read())
        img = hunkfile.image(hdr, hunks)
        self.base = []
        a = BASE
        for typ, size, data, rel in img:
            self.base.append(a)
            a += (size + 15) & ~15
        self.mem = bytearray(MEM)
        for i, (typ, size, data, rel) in enumerate(img):
            b = self.base[i]
            self.mem[b:b + len(data)] = data
            for t, offs in rel.items():
                for o in offs:
                    v = struct.unpack_from('>I', self.mem, b + o)[0]
                    struct.pack_into('>I', self.mem, b + o, (v + self.base[t]) & 0xFFFFFFFF)
        self.sym = {}
        for i, h in enumerate(hunks):
            for name, n, off in (h.symbols or []):
                self.sym[name.rstrip(b'\0').decode()] = self.base[i] + off
        self.uc = Uc(UC_ARCH_M68K, UC_MODE_BIG_ENDIAN)
        self.uc.ctl_set_cpu_model(UC_CPU_M68K_M68020)
        self.uc.mem_map(0, MEM)
        self.uc.mem_map(0xBF0000, 0x10000)       # CIAs
        self.uc.mem_map(0xDF0000, 0x10000)       # custom chips (writes ignored, reads 0)
        self.uc.mem_write(0, bytes(self.mem))
        self.hooks = {}
        self.uc.hook_add(UC_HOOK_CODE, self._code)

    def __getitem__(self, name):
        return self.sym[name]

    # memory helpers
    def w(self, a): return struct.unpack('>h', self.uc.mem_read(a, 2))[0]
    def uw(self, a): return struct.unpack('>H', self.uc.mem_read(a, 2))[0]
    def l(self, a): return struct.unpack('>i', self.uc.mem_read(a, 4))[0]
    def b(self, a): return self.uc.mem_read(a, 1)[0]
    def setw(self, a, v): self.uc.mem_write(a, struct.pack('>H', v & 0xFFFF))
    def setl(self, a, v): self.uc.mem_write(a, struct.pack('>I', v & 0xFFFFFFFF))
    def setb(self, a, v): self.uc.mem_write(a, bytes([v & 0xFF]))
    def reg(self, r): return self.uc.reg_read(r)

    def hook(self, name, fn):
        """fn(game) runs instead of the routine (it returns to the caller)."""
        self.hooks[self.sym[name] if isinstance(name, str) else name] = fn

    def _code(self, uc, addr, size, _):
        if addr == STOP:
            uc.emu_stop(); return
        fn = self.hooks.get(addr)
        if fn:
            r = fn(self)
            sp = uc.reg_read(UC_M68K_REG_A7)
            ret = struct.unpack('>I', uc.mem_read(sp, 4))[0]
            uc.reg_write(UC_M68K_REG_A7, sp + 4)
            uc.reg_write(UC_M68K_REG_D0, (r or 0) & 0xFFFFFFFF)
            uc.reg_write(UC_M68K_REG_PC, ret)

    def call(self, name, regs=None, limit=5_000_000):
        sp = 0x7FF0
        start = self.sym[name] if isinstance(name, str) else name
        self.uc.mem_write(TRAMP, b'\x4e\xb9' + struct.pack('>I', start) + b'\x4e\x71\x4e\x71')
        self.uc.reg_write(UC_M68K_REG_A7, sp)
        for r, v in (regs or {}).items():
            self.uc.reg_write(r, v & 0xFFFFFFFF)
        try:
            self.uc.emu_start(TRAMP, 0xFFFFFFFF, count=limit)
        except UcError as e:
            raise RuntimeError('%s at %06X' % (e, self.reg(UC_M68K_REG_PC)))
        return self.reg(UC_M68K_REG_D0)
