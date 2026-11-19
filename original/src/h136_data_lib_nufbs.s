; F/A-18 Interceptor - hunk 136 (data)
; C library: _nufbs.
; Included by ../f18_main.s.

;===============================================================================
; Hunk 136: DATA, $4 bytes
;===============================================================================
	DATA_HUNK	h136
; _nufbs - How many low-level files (_ufbs entries) there are.
_nufbs:
	dc.b	$00,$00,$00,$14
h136_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc
