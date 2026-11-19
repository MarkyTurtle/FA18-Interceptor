; F/A-18 Interceptor - hunk 94 (data)
; Included by ../f18_main.s.

;===============================================================================
; Hunk 94: DATA, $4 bytes
;===============================================================================
	DATA_HUNK	h094
; errno - The C library's error number.
errno:
	dc.b	$00,$00,$00,$00
h094_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc
