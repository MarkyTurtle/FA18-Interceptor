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
; ExtraVertices - Vertices made by the shape operations (ShapeLineRow) and the scenery
; transforms.
ExtraVertices:
	dcb.b	1536,$00
; ScreenPolygon - The polygon in screen coordinates (count, then x, y pairs) after clipping and
; projection; the sky polygon too.
ScreenPolygon:
	dc.b	$00
	dc.b	$00
; ScreenPolygonPoints - ScreenPolygon's points (after its count).
ScreenPolygonPoints:
	dc.b	$00
	dc.b	$00
; ScreenPolygonFirst - ScreenPolygon's first point.
ScreenPolygonFirst:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; ScreenPolygonCorner - A corner in ScreenPolygon (MakeSkyPolygon).
ScreenPolygonCorner:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; ScreenPolygonLimit - A limit within ScreenPolygon (DrawGroundDots, DrawPuffShape).
ScreenPolygonLimit:
	dcb.b	148,$00
; PanelSkyPolygon - The sky polygon for the attitude indicator (count, then x,y pairs), kept by
; ClearSkyGround in the cockpit view; count 0 for none.
PanelSkyPolygon:
	dcb.b	1374,$00
; ClipCorners - The corners of the polygon being clipped (ClipFillPolygonBuffer) and the view's
; corners (FindHorizonEdges).
ClipCorners:
	dcb.b	1536,$00
; PolygonBuffer - The polygon being drawn: a shift, the vertex count, then the vertices (x, y,
; z words).
PolygonBuffer:
	dc.b	$00
	dc.b	$00
; PolygonColourWord - The colour word of the polygon being drawn (ShapePolygon).
PolygonColourWord:
	dc.b	$00
	dc.b	$00
; PlanePoints - Points copied for a side test or a grid (the vertices' turned positions).
PlanePoints:
	dcb.b	1534,$00
; LineEnds - The two ends of the 3D line being drawn (x, y, z words each).
LineEnds:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; LineEnd2 - The second end in LineEnds.
LineEnd2:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; LineEndsEnd - The end of LineEnds.
LineEndsEnd:
	dcb.b	4594,$00
; CellItemPointers - Pointers to the items of the cells near a point (for BulletHitTest and
; CollideWithList).
CellItemPointers:
	dcb.b	44,$00
; CellItemPointers2 - More pointers to cell items (see CellItemPointers).
CellItemPointers2:
	dcb.b	2816,$00
; RadarList - The objects around the player, turned into the aircraft's own axes (12 bytes of
; position then the object's word): filled by AddRadarObject, read by the radar.
RadarList:
	dcb.b	1120,$00
; RadarBlips - The radar blips last plotted, a list of positions (ended by -1) for each of the
; two display buffers ($28 bytes apart), so they can be erased.
RadarBlips:
	dcb.b	40,$00
; RadarObjectList - The objects the radar shows this frame (AddRadarObject; -1 ends it).
RadarObjectList:
	dcb.b	40,$00
h072_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc
