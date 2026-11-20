; F/A-18 Interceptor - hunk 73 (code)
; More variables: the visible object and scenery lists, the flight recording's buffers...
; Included by ../f18_main.s.

;===============================================================================
; Hunk 73: CODE, $16A8 bytes
;===============================================================================
	CODE_HUNK	h073
; SmallListTemplate - A block of 11 longs copied to SmallList by sub_009_008BE (a list's
; starting values).
SmallListTemplate:
	dcb.b	44,$00
; SmallList - The list sub_009_008BE builds (from SmallListTemplate).
SmallList:
	dcb.b	44,$00
; ResetList - A list cleared by ResetGame.
ResetList:
	dcb.b	88,$00
; SmallListWork - sub_009_007F6's work area.
SmallListWork:
	dcb.b	44,$00
; SkyPolygonCorners - MakeSkyPolygon's corner flags and counts (with the words after it: the
; horizon crossings counted by FindHorizonEdges).
SkyPolygonCorners:
	dc.b	$00
	dc.b	$00
; HorizonCrossCount1 - A count of horizon crossings (FindHorizonEdges).
HorizonCrossCount1:
	dc.b	$00
	dc.b	$00
; HorizonCrossCount2 - A count of horizon crossings (FindHorizonEdges).
HorizonCrossCount2:
	dc.b	$00
	dc.b	$00
; HorizonCrossCount3 - A count of horizon crossings (FindHorizonEdges).
HorizonCrossCount3:
	dc.b	$00
	dc.b	$00
; HorizonCross1 - A horizon crossing (FindHorizonEdges).
HorizonCross1:
	dc.b	$00
	dc.b	$00
; HorizonCross2 - A horizon crossing (FindHorizonEdges).
HorizonCross2:
	dc.b	$00
	dc.b	$00
; HorizonCross3 - A horizon crossing (FindHorizonEdges).
HorizonCross3:
	dc.b	$00
	dc.b	$00
; HorizonCross4 - A horizon crossing (FindHorizonEdges).
HorizonCross4:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; ClipWork1 - ClipFillPolygonBuffer's work areas (with ClipWork2, ClipWork3).
ClipWork1:
	dcb.b	156,$00
; ClipWork2 - See ClipWork1.
ClipWork2:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; ClipWork3 - See ClipWork1.
ClipWork3:
	dcb.b	110,$00
; DistanceCount - A count kept by DistanceScale (up to $46).
DistanceCount:
	dc.b	$00
	dc.b	$00
; VisibleObjects - The objects to draw this frame: words (object numbers), ending with one <=
; 0.
VisibleObjects:
	dcb.b	32,$00
; FarSceneryList0 - The list built from SceneryMap0 on the coarse grid.
FarSceneryList0:
	dcb.b	1680,$00
; FarSceneryList1 - The list built from SceneryMap1 on the coarse grid.
FarSceneryList1:
	dcb.b	1680,$00
; SceneryList - The scenery to draw: entries of 24 bytes (flags and number word, the model, x /
; y / z words, a long...), ending with $FFFF.
SceneryList:
	dcb.b	1680,$00
; DrawSortFirst - sub_009_00958's working words (with DrawSortLast, DrawSortIndex).
DrawSortFirst:
	dc.b	$00
	dc.b	$00
; DrawSortLast - See DrawSortFirst.
DrawSortLast:
	dc.b	$00
	dc.b	$00
; DrawSortIndex - See DrawSortFirst.
DrawSortIndex:
	dcb.b	66,$00
; ResetWord - A word cleared by ResetGame.
ResetWord:
	dc.b	$00
	dc.b	$00
; TrainingFrame - The frame reached in a manoeuvre's recorded control bytes.
TrainingFrame:
	dc.b	$00
	dc.b	$00
; RecordBuffer - The flight recording's positions (textply).
RecordBuffer:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; RecordLength - Its size in bytes (the controls are 4 times that).
RecordLength:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; RecordPointer - Where the replay has got to in RecordBuffer.
RecordPointer:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; RecordControls - The flight recording's controls (textctl).
RecordControls:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; RecordControlsPointer - Where RecordFrame writes the next event words in RecordControls.
RecordControlsPointer:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; ReplayControlsPointer - Where the replay reads the next event words in RecordControls.
ReplayControlsPointer:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; ReplayPointer - Where the replay reads the next control byte in RecordBuffer.
ReplayPointer:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; InfoData - The InfoData buffer for CheckDisk.
InfoData:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; InfoDataPtr - Points at a loaded data block (RunGame).
InfoDataPtr:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; FlameStep - The flame's animation step (0-6, sub_022_00AB6; DrawObjectFlame draws by it).
FlameStep:
	dc.b	$00
; FlameStep2 - A second step of the flame's animation (0-5).
FlameStep2:
	dc.b	$00
; FlameObject - The object whose flame is drawn (DrawObjectFlame; FlyAircraft sets it to the
; current object, $800 at the start).
FlameObject:
	dc.b	$00
	dc.b	$00
; FlamePoints - The flame's points (DrawObjectFlame, sub_022_00AB6).
FlamePoints:
	dcb.b	72,$00
; BlobRowsBuffer - A chip buffer for DrawBlobRows (allocated by SetupGameDisplay).
BlobRowsBuffer:
	dc.b	$00,$00,$00,$00
h073_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc
