; F/A-18 Interceptor - hunk 145 (data)
; Included by ../f18_main.s.

;===============================================================================
; Hunk 145: DATA, $14 bytes
;===============================================================================
	DATA_HUNK	h145
; _HexDigits - "0123456789ABCDEF" (for printf).
_HexDigits:
	dc.b	'0123456789ABCDEF'
dat_145_00010:
	dc.b	$00,$00,$00,$00
h145_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc
