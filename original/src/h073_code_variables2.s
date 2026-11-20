; F/A-18 Interceptor - hunk 73 (code)
; More variables: the visible object and scenery lists, the flight recording's buffers...
; Included by ../f18_main.s.

;===============================================================================
; Hunk 73: CODE, $16A8 bytes
;===============================================================================
	CODE_HUNK	h073
dat_073_00000:
	dcb.b	44,$00
dat_073_0002C:
	dcb.b	44,$00
dat_073_00058:
	dcb.b	88,$00
dat_073_000B0:
	dcb.b	44,$00
dat_073_000DC:
	dc.b	$00
	dc.b	$00
dat_073_000DE:
	dc.b	$00
	dc.b	$00
dat_073_000E0:
	dc.b	$00
	dc.b	$00
dat_073_000E2:
	dc.b	$00
	dc.b	$00
dat_073_000E4:
	dc.b	$00
	dc.b	$00
dat_073_000E6:
	dc.b	$00
	dc.b	$00
dat_073_000E8:
	dc.b	$00
	dc.b	$00
dat_073_000EA:
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
dat_073_000FC:
	dcb.b	156,$00
dat_073_00198:
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
dat_073_001A2:
	dcb.b	110,$00
dat_073_00210:
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
dat_073_015E2:
	dc.b	$00
	dc.b	$00
dat_073_015E4:
	dc.b	$00
	dc.b	$00
dat_073_015E6:
	dcb.b	66,$00
dat_073_01628:
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
dat_073_01654:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_073_01658:
	dc.b	$00
dat_073_01659:
	dc.b	$00
dat_073_0165A:
	dc.b	$00
	dc.b	$00
dat_073_0165C:
	dcb.b	72,$00
dat_073_016A4:
	dc.b	$00,$00,$00,$00
h073_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc
