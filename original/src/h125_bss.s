; F/A-18 Interceptor - hunk 125 (bss)
; Included by ../f18_main.s.

;===============================================================================
; Hunk 125: BSS, $C bytes
;===============================================================================
	BSS_HUNK	h125
dat_125_00000:
        ds.b    $C                              ; 00000
h125_end:
	ifnd	HUNKEXE
	section	bin,code			; (back from the offset section)
	org	0
	dc.l	HUNK_END
	endc
