"""The config original/f18_main.s was first made from (kept for the record: the source is edited
by hand since November 2026, and make.py writes what this gives to tools/disasm/regen/).

f18_main.s: the game's executable, "F-18 Interceptor" on the disk (331,232 bytes, 185 hunks).

Keys are (hunk, offset). The executable's own symbols (HUNK_SYMBOL: mostly the amiga.lib-style
library call stubs) name their places automatically; NAMES adds to or overrides them.
"""
NAME = 'main'
EXE = 'disk/files/F-18 Interceptor/F-18 Interceptor'

ENTRIES = []            # (hunk, offset) of code nothing else reaches
NAMES = {}              # (hunk, offset) -> name
HEADERS = {}            # (hunk, offset) -> routine header text
COMMENTS = {}           # (hunk, offset) -> end-of-line comment
HUNK_TEXT = {           # hunk -> a line or two under the hunk's heading
    0: 'Lattice C startup (c.o) first, then the game\'s first module.',
}
SWEEP = True

PROLOGUE = r'''
; F/A-18 Interceptor (Intellisoft / Electronic Arts 1988, Amiga) - the game's executable
; ("F-18 Interceptor" on the disk: an AmigaDOS hunk executable of 185 hunks, mostly Lattice C)
;
; Made by original/tools/disasm/make.py from its config (tools/disasm/main_cfg.py).
; Assemble (f18_hunks.i explains the two ways):
;   vasmm68k_mot -Fbin -m68000 -no-opt -o f18_main.exe f18_main.s      -> the file, byte-identical
;   vasmm68k_mot -Fhunkexe -kick1hunks -nosym -DHUNKEXE -m68000 -no-opt -o f18_check.exe f18_main.s
;
; Labels are named by hunk and offset: sub_HHH_OOOOO (called), l_HHH_OOOOO (jumped to),
; dat_HHH_OOOOO (data); hHHH is the start of hunk HHH and hHHH_end its end.

	include	"f18_hunks.i"
'''
