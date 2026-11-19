; F/A-18 Interceptor - hunk 100 (data)
; C library: Enable_Abort.
; Included by ../f18_main.s.

;===============================================================================
; Hunk 100: DATA, $4 bytes
;===============================================================================
	DATA_HUNK	h100
; Enable_Abort - Non-zero: CTRL-C / CTRL-D end the program (Chk_Abort).
Enable_Abort:
	dc.b	$00,$00,$00,$00
h100_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc
