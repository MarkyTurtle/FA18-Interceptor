; F/A-18 Interceptor - hunk 118 (data)
; C library: variables of the console.
; Included by ../f18_main.s.

;===============================================================================
; Hunk 118: DATA, $10 bytes
;===============================================================================
	DATA_HUNK	h118
dat_118_00000:
	dc.b	$FF,$FF,$FF,$FF,$00,$00,$00,$00,$00,$00,$00,$01
dat_118_0000C:
	dc.b	$00
dat_118_0000D:
	dc.b	$2A,$00,$00
h118_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc
