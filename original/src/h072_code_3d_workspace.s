; F/A-18 Interceptor - hunk 72 (code)
; Variables: the 3D pipeline's workspace (the projected points...).
; Included by ../f18_main.s.

;===============================================================================
; Hunk 72: CODE, $63DC bytes
;===============================================================================
	CODE_HUNK	h072
dat_072_00000:
	dcb.b	10752,$00
dat_072_02A00:
	dcb.b	1536,$00
dat_072_03000:
	dc.b	$00
	dc.b	$00
dat_072_03002:
	dc.b	$00
	dc.b	$00
dat_072_03004:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_072_0300A:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_072_0300E:
	dcb.b	148,$00
dat_072_030A2:
	dcb.b	1374,$00
dat_072_03600:
	dcb.b	1536,$00
dat_072_03C00:
	dc.b	$00
	dc.b	$00
dat_072_03C02:
	dc.b	$00
	dc.b	$00
dat_072_03C04:
	dcb.b	1534,$00
dat_072_04202:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_072_04208:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_072_0420E:
	dcb.b	4594,$00
dat_072_05400:
	dcb.b	44,$00
dat_072_0542C:
	dcb.b	2816,$00
dat_072_05F2C:
	dcb.b	1120,$00
dat_072_0638C:
	dcb.b	40,$00
dat_072_063B4:
	dcb.b	40,$00
h072_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc
