; F/A-18 Interceptor - hunk 72 (code)
; Variables: the 3D pipeline's workspace (the projected points...).
; Included by ../f18_main.s.

;===============================================================================
; Hunk 72: CODE, $63DC bytes
;===============================================================================
	CODE_HUNK	h072
; VertexBuffer - The current model's vertices moved to the camera (3 words each), DrawModel.
VertexBuffer:
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
; PolygonBuffer - The polygon being drawn: a shift, the vertex count, then the vertices (x, y,
; z words).
PolygonBuffer:
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
; RadarList - The objects around the player, turned into the aircraft's own axes (12 bytes of
; position then the object's word): filled by AddRadarObject, read by the radar.
RadarList:
	dcb.b	1120,$00
; RadarBlips - The radar blips last plotted, a list of positions (ended by -1) for each of the
; two display buffers ($28 bytes apart), so they can be erased.
RadarBlips:
	dcb.b	40,$00
dat_072_063B4:
	dcb.b	40,$00
h072_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc
