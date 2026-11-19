; F/A-18 Interceptor - the hunk structure, for the two ways the source assembles:
;
;   vasmm68k_mot -Fbin -m68000 -no-opt -o f18_main.exe f18_main.s
;       The executable exactly as on the disk. Each hunk is under its own org 0, so its labels
;       are offsets in the hunk (the values the file stores, which LoadSeg relocates); the hunk
;       header and each hunk's block id, relocation and symbol tables are written as dc.l.
;
;   vasmm68k_mot -Fhunkexe -kick1hunks -nosym -DHUNKEXE -m68000 -no-opt -o f18_check.exe f18_main.s
;       An ordinary executable: each hunk is a section and vasm makes the relocations from the
;       labels. build.py checks its contents and relocations equal the original's.

HUNK_CODE	equ	$3E9
HUNK_DATA	equ	$3EA
HUNK_BSS	equ	$3EB
HUNK_RELOC32	equ	$3EC
HUNK_SYMBOL	equ	$3F0
HUNK_END	equ	$3F2
HUNK_HEADER	equ	$3F3
HUNKF_CHIP	equ	$40000000
HUNKF_FAST	equ	$80000000

AbsExecBase	equ	4

; \1 = the hunk's name (h000...): starts the hunk and defines the label \1 at its start;
; the hunk's end is the label \1_end (its size, for the header).
HUNKSTART	macro			; \1 name, \2 section type, \3 block id (with memory flags)
	ifd	HUNKEXE
	section	\1,\2
	else
	section	bin,code
	org	0
	dc.l	\3,\1_end/4
	org	0
	endc
\1:
	endm

BSSSTART	macro			; \1 name, \2 section type, \3 block id: labels only, no data
	ifd	HUNKEXE
	section	\1,\2
	else
	section	bin,code
	org	0
	dc.l	\3,\1_end/4
	offset	0
	endc
\1:
	endm

CODE_HUNK	macro
	HUNKSTART	\1,code,HUNK_CODE
	endm
CODE_C_HUNK	macro
	HUNKSTART	\1,code_c,HUNK_CODE+HUNKF_CHIP
	endm
CODE_F_HUNK	macro
	HUNKSTART	\1,code_f,HUNK_CODE+HUNKF_FAST
	endm
DATA_HUNK	macro
	HUNKSTART	\1,data,HUNK_DATA
	endm
DATA_C_HUNK	macro
	HUNKSTART	\1,data_c,HUNK_DATA+HUNKF_CHIP
	endm
DATA_F_HUNK	macro
	HUNKSTART	\1,data_f,HUNK_DATA+HUNKF_FAST
	endm
BSS_HUNK	macro
	BSSSTART	\1,bss,HUNK_BSS
	endm
BSS_C_HUNK	macro
	BSSSTART	\1,bss_c,HUNK_BSS+HUNKF_CHIP
	endm
BSS_F_HUNK	macro
	BSSSTART	\1,bss_f,HUNK_BSS+HUNKF_FAST
	endm
