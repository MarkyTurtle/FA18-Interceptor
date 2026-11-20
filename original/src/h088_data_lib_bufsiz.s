; F/A-18 Interceptor - hunk 88 (data)
; C library: a variable (the stdio buffer size).
; Included by ../f18_main.s.

;===============================================================================
; Hunk 88: DATA, $4 bytes
;===============================================================================
	DATA_HUNK	h088
; GetbufData1 - Data used by _getbuf.
GetbufData1:
	dc.b	$00,$00,$02,$00
h088_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc
