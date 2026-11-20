; F/A-18 Interceptor - hunk 143 (bss)
; C library: _iob, the stdio FILEs.
; Included by ../f18_main.s.

;===============================================================================
; Hunk 143: BSS, $1E0 bytes
;===============================================================================
	BSS_HUNK	h143
; _iob - The stdio FILEs: 20 of 24 bytes (stdin, stdout, stderr first).
_iob:
        ds.b    $10                             ; 00000
; MainData6 - Data used by __main.
MainData6:
        ds.b    $1                              ; 00010
; MainData7 - Data used by __main.
MainData7:
        ds.b    $17                             ; 00011
; MainData8 - Data used by __main.
MainData8:
        ds.b    $1                              ; 00028
; MainData9 - Data used by __main.
MainData9:
        ds.b    $7                              ; 00029
; MainData10 - Data used by __main.
MainData10:
        ds.b    $10                             ; 00030
; MainData11 - Data used by __main.
MainData11:
        ds.b    $1                              ; 00040
; MainData12 - Data used by __main.
MainData12:
        ds.b    $19F                            ; 00041
h143_end:
	ifnd	HUNKEXE
	section	bin,code			; (back from the offset section)
	org	0
	dc.l	HUNK_END
	endc
