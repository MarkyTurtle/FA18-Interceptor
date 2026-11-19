; F/A-18 Interceptor - hunk 84 (data)
; A variable of hunk 83.
; Included by ../f18_main.s.

;===============================================================================
; Hunk 84: DATA, $4 bytes
;===============================================================================
	DATA_HUNK	h084
dat_084_00000:
	dc.b	$47,$09,$12,$47
h084_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc
