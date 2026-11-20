; F/A-18 Interceptor - hunk 2 (bss)
; Variables: the graphics library bases, the View, ViewPort, BitMaps and RastPorts, the
; pictures' BitMaps and BMHDs, the flight log buffer, the device requests.
; Included by ../f18_main.s.

;===============================================================================
; Hunk 2: BSS, $2A04 bytes
;===============================================================================
	BSS_HUNK	h002
; _IntuitionBase - intuition.library (opened only to close the Workbench screen).
_IntuitionBase:
        ds.b    $4                              ; 00000
; GameState - The game's current state: the routine run once a frame (called from
; RunGameState). The game moves from screen to screen and through a mission by storing the next
; state's routine here (the State labels, hunk 0).
GameState:
        ds.b    $4                              ; 00004
; CockpitObject - Points at the viewed object's record (ObjectTable) while CockpitSounds runs.
CockpitObject:
        ds.b    $4                              ; 00008
; CurrentBullet - Points at the bullet (Bullets) being moved or fired.
CurrentBullet:
        ds.b    $4                              ; 0000C
; GameView - The game's View.
GameView:
        ds.b    $4                              ; 00010
; GameViewLOFCprList - The game View's LOFCprList (View +4): the copper list made by MrgCop
; (MakeDisplay keeps one per buffer; ShowDisplay loads the shown buffer's).
GameViewLOFCprList:
        ds.b    $E                              ; 00014
; GameViewPort - The game's ViewPort (320 x 200).
GameViewPort:
        ds.b    $4                              ; 00022
; GameViewPortColorMap - The ViewPort's ColorMap (+4).
GameViewPortColorMap:
        ds.b    $4                              ; 00026
; GameViewPortDspIns - The game ViewPort's DspIns (ViewPort +8): its copper instructions (one
; per buffer, as GameViewLOFCprList).
GameViewPortDspIns:
        ds.b    $10                             ; 0002A
; GameViewPortDWidth - The ViewPort's DWidth (320).
GameViewPortDWidth:
        ds.b    $2                              ; 0003A
; GameViewPortDHeight - The ViewPort's DHeight (200).
GameViewPortDHeight:
        ds.b    $2                              ; 0003C
; GameViewPortDxOffset - The ViewPort's DxOffset (0).
GameViewPortDxOffset:
        ds.b    $2                              ; 0003E
; GameViewPortDyOffset - The ViewPort's DyOffset (-2), then Modes.
GameViewPortDyOffset:
        ds.b    $6                              ; 00040
; GameViewPortRasInfo - The ViewPort's RasInfo pointer (to GameRasInfo).
GameViewPortRasInfo:
        ds.b    $4                              ; 00046
; GameColorMap - The ViewPort's ColorMap.
GameColorMap:
        ds.b    $4                              ; 0004A
; GameRasInfo - The game ViewPort's RasInfo: Next (0), then its BitMap (GameRasInfoBitMap) and
; offsets.
GameRasInfo:
        ds.b    $4                              ; 0004E
; GameRasInfoBitMap - The RasInfo's BitMap: the buffer shown (MakeDisplay switches it).
GameRasInfoBitMap:
        ds.b    $4                              ; 00052
; GameRasInfoRxOffset - The RasInfo's RxOffset.
GameRasInfoRxOffset:
        ds.b    $2                              ; 00056
; GameRasInfoRyOffset - The RasInfo's RyOffset.
GameRasInfoRyOffset:
        ds.b    $2                              ; 00058
; GameBitMap1 - The display's BitMap (5 planes, 320 x 200).
GameBitMap1:
        ds.b    $4                              ; 0005A
; GameBitMap2 - The second BitMap (4 planes, 320 x 200).
GameBitMap2:
        ds.b    $4                              ; 0005E
; BitMap1 - The display BitMap's structure.
BitMap1:
        ds.b    $28                             ; 00062
; BitMap2 - The second BitMap's structure.
BitMap2:
        ds.b    $28                             ; 0008A
; CopperBuffer1 - The copper list of display buffer 1 (copied from GameViewLOFCprList by
; InitDisplay).
CopperBuffer1:
        ds.b    $4                              ; 000B2
; CopperBuffer1DspIns - Display buffer 1's DspIns (with CopperBuffer1, its LOFCprList).
CopperBuffer1DspIns:
        ds.b    $4                              ; 000B6
; CopperBuffer2 - The copper list of display buffer 2.
CopperBuffer2:
        ds.b    $4                              ; 000BA
; CopperBuffer2DspIns - Display buffer 2's DspIns.
CopperBuffer2DspIns:
        ds.b    $4                              ; 000BE
; _GfxBase - graphics.library.
_GfxBase:
        ds.b    $4                              ; 000C2
; OldView - The View the system showed before the game (GfxBase->ActiView), put back at the
; end.
OldView:
        ds.b    $4                              ; 000C6
; GameRastPort1 - The RastPort of BitMap1.
GameRastPort1:
        ds.b    $4                              ; 000CA
; GameRastPort1BitMap - GameRastPort1's BitMap pointer (RastPort +4).
GameRastPort1BitMap:
        ds.b    $60                             ; 000CE
; GameRastPort2 - The RastPort of BitMap2.
GameRastPort2:
        ds.b    $4                              ; 0012E
; GameRastPort2BitMap - GameRastPort2's BitMap pointer (RastPort +4).
GameRastPort2BitMap:
        ds.b    $60                             ; 00132
; ReadButtonsData1 - Data used by ReadButtons.
ReadButtonsData1:
        ds.b    $F02                            ; 00192
; SceneryBits0 - A bit for each of the 128 x 128 map cells that has scenery in SceneryMap0 (16
; bytes a row), made by BuildSceneryBits for a quick test.
SceneryBits0:
        ds.b    $800                            ; 01094
; SceneryBits1 - SceneryMap1's cells as bits (see SceneryBits0).
SceneryBits1:
        ds.b    $800                            ; 01894
; SceneryBits2 - SceneryMap2's cells as bits (see SceneryBits0).
SceneryBits2:
        ds.b    $800                            ; 02094
; PictureColours - The colours read from a picture's CMAP (32 RGB4 words).
PictureColours:
        ds.b    $40                             ; 02894
; TitleBitMap - The title picture's BitMap (pix/splsh).
TitleBitMap:
        ds.b    $4                              ; 028D4
; TitleBMHD - The title picture's BMHD (20 bytes: width.w, height.w ...).
TitleBMHD:
        ds.b    $2                              ; 028D8
; TitleBMHDHeight - The title picture's height (in its BMHD).
TitleBMHDHeight:
        ds.b    $12                             ; 028DA
; TitlePlane0 - The title picture's saved planes (SaveTitleBitMap: then TitlePlane1-4).
TitlePlane0:
        ds.b    $4                              ; 028EC
; TitlePlane1 - The title picture's plane 1.
TitlePlane1:
        ds.b    $4                              ; 028F0
; TitlePlane2 - The title picture's plane 2.
TitlePlane2:
        ds.b    $4                              ; 028F4
; TitlePlane3 - The title picture's plane 3.
TitlePlane3:
        ds.b    $4                              ; 028F8
; TitlePlane4 - The title picture's plane 4.
TitlePlane4:
        ds.b    $4                              ; 028FC
; PanelBitMap - The instrument panel picture's BitMap (pix/inst5, 320 x 55).
PanelBitMap:
        ds.b    $4                              ; 02900
; PanelBMHD - The instrument panel picture's BMHD.
PanelBMHD:
        ds.b    $2                              ; 02904
; PanelBMHDHeight - The panel picture's height (in its BMHD).
PanelBMHDHeight:
        ds.b    $12                             ; 02906
; PanelPlane0 - The instrument panel picture's plane 0 (AllocGameBuffers; then 1-3:
; PanelPlane1-3).
PanelPlane0:
        ds.b    $4                              ; 02918
; PanelPlane1 - The panel picture's plane 1.
PanelPlane1:
        ds.b    $4                              ; 0291C
; PanelPlane2 - The panel picture's plane 2.
PanelPlane2:
        ds.b    $4                              ; 02920
; PanelPlane3 - The panel picture's plane 3.
PanelPlane3:
        ds.b    $8                              ; 02924
; PanelPieceMask - The mask of the panel's piece (DrawPanelPiece).
PanelPieceMask:
        ds.b    $4                              ; 0292C
; FrontBitMap - The front picture's BitMap (pix/frnt5, 288 x 12).
FrontBitMap:
        ds.b    $4                              ; 02930
; FrontBMHD - The front picture's BMHD.
FrontBMHD:
        ds.b    $2                              ; 02934
; PictureBytes - The size of a picture's plane in bytes (from its BMHD), for allocating and
; freeing.
PictureBytes:
        ds.b    $12                             ; 02936
; PanelPiecePlane0 - The panel piece's planes (then PanelPiecePlane1, 2).
PanelPiecePlane0:
        ds.b    $4                              ; 02948
; PanelPiecePlane1 - The panel piece's plane 1.
PanelPiecePlane1:
        ds.b    $4                              ; 0294C
; PanelPiecePlane2 - The panel piece's plane 2.
PanelPiecePlane2:
        ds.b    $4                              ; 02950
; PanelPiecePlane3 - The panel piece's plane 3.
PanelPiecePlane3:
        ds.b    $4                              ; 02954
; AllocGameBuffersData1 - Data used by AllocGameBuffers.
AllocGameBuffersData1:
        ds.b    $4                              ; 02958
; AllocGameBuffersData2 - Data used by AllocGameBuffers.
AllocGameBuffersData2:
        ds.b    $4                              ; 0295C
; AllocGameBuffersData3 - Data used by AllocGameBuffers.
AllocGameBuffersData3:
        ds.b    $4                              ; 02960
; AllocGameBuffersData4 - Data used by AllocGameBuffers.
AllocGameBuffersData4:
        ds.b    $4                              ; 02964
; AllocGameBuffersData5 - Data used by AllocGameBuffers.
AllocGameBuffersData5:
        ds.b    $4                              ; 02968
; ConfigBuffer - The pilot's flight log (df0:config, 78 bytes; disk/FILES.md has its fields):
; +$02 copied to Difficulty, +$08 the accumulated flight time in seconds, +$36 missions
; started, +$38 missions completed, +$3A/+$3C cannon rounds fired/hits, +$3E/+$40 AMRAAMs
; fired/hits, +$42/+$44 Sidewinders fired/hits, +$46 crashes, +$48 hits from missiles.
ConfigBuffer:
        ds.b    $4                              ; 0296C
; ConfigSize - The flight log's size as read (LoadConfig).
ConfigSize:
        ds.b    $2                              ; 02970
; CodeValue1 - The security check's working values (MakeSecurityCode, CodeCheck): the first.
CodeValue1:
        ds.b    $2                              ; 02972
; CodeValue2 - The security check's second working value.
CodeValue2:
        ds.b    $1                              ; 02974
; CodeValue2Low - The low byte of CodeValue2.
CodeValue2Low:
        ds.b    $1                              ; 02975
; CodeValue4 - The security check's fourth working value.
CodeValue4:
        ds.b    $2                              ; 02976
; CodeValue3 - The security check's third working value.
CodeValue3:
        ds.b    $2                              ; 02978
; CodeHashValue - The security code's hash (CodeHash), used to make and check the answer.
CodeHashValue:
        ds.b    $2                              ; 0297A
; TimerRequest - The timer device's IO request (OpenTimer, ReadTime).
TimerRequest:
        ds.b    $8                              ; 0297C
; TimerCommand - The timer request's fields (command, flags...: ReadTime).
TimerCommand:
        ds.b    $1                              ; 02984
; ReadTimeData1 - Data used by ReadTime.
ReadTimeData1:
        ds.b    $1                              ; 02985
; ReadTimeData2 - Data used by ReadTime.
ReadTimeData2:
        ds.b    $4                              ; 02986
; ReadTimeData3 - Data used by ReadTime.
ReadTimeData3:
        ds.b    $E                              ; 0298A
; ReadTimeData4 - Data used by ReadTime.
ReadTimeData4:
        ds.b    $4                              ; 02998
; TimerSeconds - The time read (seconds; ReadTime).
TimerSeconds:
        ds.b    $4                              ; 0299C
; TimerMicros - The time read (microseconds).
TimerMicros:
        ds.b    $4                              ; 029A0
; KeyboardRequest - The keyboard device's IO request (OpenKeyboard, ReadKeyEvent).
KeyboardRequest:
        ds.b    $4                              ; 029A4
; OpenKeyboardData1 - Data used by OpenKeyboard.
OpenKeyboardData1:
        ds.b    $2                              ; 029A8
; OpenKeyboardData2 - Data used by OpenKeyboard.
OpenKeyboardData2:
        ds.b    $16                             ; 029AA
; LastKey - The key code last pushed (PushKey, GetKey).
LastKey:
        ds.b    $2                              ; 029C0
; JoystickEventPtr2 - Points at JoystickEvent too (ReadJoystick).
JoystickEventPtr2:
        ds.b    $4                              ; 029C2
; JoystickPort - The gameport device's message port (OpenJoystick).
JoystickPort:
        ds.b    $4                              ; 029C6
; JoystickEvent - The gameport's input event buffer.
JoystickEvent:
        ds.b    $16                             ; 029CA
; JoystickEventPtr - Points at JoystickEvent (the request's data).
JoystickEventPtr:
        ds.b    $4                              ; 029E0
; JoystickRequest - The gameport device's IO request (OpenJoystick).
JoystickRequest:
        ds.b    $4                              ; 029E4
; MouseInterruptNode - The interrupt structure of the mouse's vertical-blank server
; (AddMouseInterrupt).
MouseInterruptNode:
        ds.b    $8                              ; 029E8
; AddMouseInterruptData1 - Data used by AddMouseInterrupt.
AddMouseInterruptData1:
        ds.b    $1                              ; 029F0
; AddMouseInterruptData2 - Data used by AddMouseInterrupt.
AddMouseInterruptData2:
        ds.b    $1                              ; 029F1
; AddMouseInterruptData3 - Data used by AddMouseInterrupt.
AddMouseInterruptData3:
        ds.b    $8                              ; 029F2
; AddMouseInterruptData4 - Data used by AddMouseInterrupt.
AddMouseInterruptData4:
        ds.b    $4                              ; 029FA
; MouseLastX - The mouse counter's last X (MouseInterrupt).
MouseLastX:
        ds.b    $2                              ; 029FE
; MouseLastY - The mouse counter's last Y.
MouseLastY:
        ds.b    $4                              ; 02A00
h002_end:
	ifnd	HUNKEXE
	section	bin,code			; (back from the offset section)
	org	0
	dc.l	HUNK_END
	endc
