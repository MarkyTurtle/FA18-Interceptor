; F/A-18 Interceptor - hunk 78 (data)
; Included by ../f18_main.s.

;===============================================================================
; Hunk 78: DATA, $28 bytes
;===============================================================================
	DATA_HUNK	h078
dat_078_00000:
	dc.b	$0F,$00
dat_078_00002:
	dc.b	$00,$00,$00,$00
dat_078_00006:
	dc.b	$00,$00,$00,$00
dat_078_0000A:
	dc.b	$00,$00,$00,$00
dat_078_0000E:
	dc.b	$00,$00,$00,$00
dat_078_00012:
	dc.b	'abcdefg'
	dc.b	$00
dat_078_0001A:
	dc.b	'audio.device'
	dc.b	$00,$00
h078_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc
