; F/A-18 Interceptor - hunk 168 (data)
; C library: the console window's name and an error message.
; Included by ../f18_main.s.

;===============================================================================
; Hunk 168: DATA, $50 bytes
;===============================================================================
	DATA_HUNK	h168
; s_ConsoleWindow - "con:10/10/320/80/": the console window's name.
s_ConsoleWindow:
	dc.b	'con:10/10/320/80/'
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00
; StrErrorNonTerminatedQuotedStri - "Error: non-terminated quoted string"
StrErrorNonTerminatedQuotedStri:
	dc.b	'Error: non-terminated quoted string'
	dc.b	$0A,$00
dat_168_0004D:
	dc.b	$2A,$00,$00
h168_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc
