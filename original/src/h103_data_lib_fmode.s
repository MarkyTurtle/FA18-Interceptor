; F/A-18 Interceptor - hunk 103 (data)
; C library: a variable (the default file mode).
; Included by ../f18_main.s.

;===============================================================================
; Hunk 103: DATA, $4 bytes
;===============================================================================
	DATA_HUNK	h103
dat_103_00000:
	dc.b	$00,$00,$00,$00
h103_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc
