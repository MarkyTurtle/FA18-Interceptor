; F/A-18 Interceptor - hunk 148 (data)
; C library: malloc's variables.
; Included by ../f18_main.s.

;===============================================================================
; Hunk 148: DATA, $10 bytes
;===============================================================================
	DATA_HUNK	h148
dat_148_00000:
	dc.b	$00,$00,$00,$00
dat_148_00004:
	dc.b	$00,$00,$00,$00
dat_148_00008:
	dc.b	$00,$00,$00,$00
dat_148_0000C:
	dc.b	$00,$00,$00,$00
h148_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc
