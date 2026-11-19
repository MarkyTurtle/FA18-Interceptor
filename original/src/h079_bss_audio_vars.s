; F/A-18 Interceptor - hunk 79 (bss)
; A sound variable.
; Included by ../f18_main.s.

;===============================================================================
; Hunk 79: BSS, $4 bytes
;===============================================================================
	BSS_HUNK	h079
dat_079_00000:
        ds.b    $4                              ; 00000
h079_end:
	ifnd	HUNKEXE
	section	bin,code			; (back from the offset section)
	org	0
	dc.l	HUNK_END
	endc
