; F/A-18 Interceptor - hunk 143 (bss)
; Included by ../f18_main.s.

;===============================================================================
; Hunk 143: BSS, $1E0 bytes
;===============================================================================
	BSS_HUNK	h143
; _iob - The stdio FILEs: 20 of 24 bytes (stdin, stdout, stderr first).
_iob:
        ds.b    $10                             ; 00000
dat_143_00010:
        ds.b    $1                              ; 00010
dat_143_00011:
        ds.b    $17                             ; 00011
dat_143_00028:
        ds.b    $1                              ; 00028
dat_143_00029:
        ds.b    $7                              ; 00029
dat_143_00030:
        ds.b    $10                             ; 00030
dat_143_00040:
        ds.b    $1                              ; 00040
dat_143_00041:
        ds.b    $19F                            ; 00041
h143_end:
	ifnd	HUNKEXE
	section	bin,code			; (back from the offset section)
	org	0
	dc.l	HUNK_END
	endc
