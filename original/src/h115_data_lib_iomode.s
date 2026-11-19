; F/A-18 Interceptor - hunk 115 (data)
; C library: a variable (the I/O mode).
; Included by ../f18_main.s.

;===============================================================================
; Hunk 115: DATA, $4 bytes
;===============================================================================
	DATA_HUNK	h115
dat_115_00000:
	dc.b	$00,$00,$00,$00
h115_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc
