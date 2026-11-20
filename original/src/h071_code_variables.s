; F/A-18 Interceptor - hunk 71 (code)
; The game's variables (zeros in the file): ObjectTable (16 records of 512 bytes), FrameStage,
; FrameCount, the controls, the drawing state...
; Included by ../f18_main.s.

;===============================================================================
; Hunk 71: CODE, $2D54 bytes
;===============================================================================
	CODE_HUNK	h071
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
; TitleChecksum - The title picture's checksum ($C560 when it is the original: then the title
; sequence plays).
TitleChecksum:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; PanelChecksum - ChecksumPlanes of the instrument panel picture (pix/inst5): $7E70 in the
; original (StateStartup).
PanelChecksum:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; FrontChecksum - ChecksumPlanes of the front picture (pix/frnt5): $4DE8 in the original
; (StateStartup).
FrontChecksum:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00028:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_0002C:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; LivePalette - Points at the palette in use (16 words, then the sprites'): the fades copy into
; it and ShowDisplay loads it.
LivePalette:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00034:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00038:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; DisplayBuffer - Which of the two display buffers is being drawn (0 / 1).
DisplayBuffer:
	dc.b	$00
	dc.b	$00
; BufferPlanes - The two display buffers' plane pointers (two sets of four longs, 16 bytes
; apart).
BufferPlanes:
	dcb.b	32,$00
dat_071_0005E:
	dcb.b	40,$00
; DrawPlanes - Points at the four plane pointers that drawing goes to (the buffer being drawn).
DrawPlanes:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_0008A:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_0008E:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00092:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00096:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_0009A:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_0009E:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_000A2:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_000A6:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_000AA:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_000AE:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_000B2:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; FillPattern - The drawing's pattern: four words for the polygon fills (sub_036), set by each
; shape operation; $000FFFFF (with the next long 0) is solid, others give the patterned fills
; (windows, fields).
FillPattern:
	dc.b	$00
; DrawMask - Which planes drawing changes (bit n = plane n).
DrawMask:
	dc.b	$00
; DrawXor - >= 0: XOR the planes in DrawXorMask.
DrawXor:
	dc.b	$00
dat_071_000B9:
	dc.b	$00
; FillPattern2 - The second long of FillPattern.
FillPattern2:
	dc.b	$00
; DrawXorMask - The planes XORed when DrawXor >= 0.
DrawXorMask:
	dc.b	$00
dat_071_000BC:
	dc.b	$00
	dc.b	$00
dat_071_000BE:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_000C2:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_000C6:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_000CA:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; PrintPosition - The printer's place: the column, the text and the screen offset (a1, a2, a4).
PrintPosition:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_000D6:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; PrintLineStart - The printer's place at the start of the current line.
PrintLineStart:
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
; GunPointNow - The gun's aim point ahead of the aircraft this frame (x, y, z longs,
; ComputeGunPipper).
GunPointNow:
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
; GunPointOld - The aim point of the frame before (ComputeGunPipper), the one shown.
GunPointOld:
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
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; ModeObjects - The object list SetupMode placed (also read by hunk 20 for the "vector for
; bogey" text).
ModeObjects:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_0010E:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00112:
	dc.b	$00
	dc.b	$00
; TextHoldTimer - Frames the last page stays up before TextStatus bit 7 is set.
TextHoldTimer:
	dc.b	$00
	dc.b	$00
dat_071_00116:
	dc.b	$00
	dc.b	$00
dat_071_00118:
	dc.b	$00
	dc.b	$00
; TextPages - The queue of text pages to show (words, ended by 0): each state queues the pages
; for its screen; the text printer (hunk 39) shows them in turn.
TextPages:
	dcb.b	40,$00
; TextPageShown - The first page of the queue last shown.
TextPageShown:
	dc.b	$00
	dc.b	$00
dat_071_00144:
	dc.b	$00
	dc.b	$00
; MouseX - The mouse pointer's x (moved by MouseInterrupt).
MouseX:
	dc.b	$00
	dc.b	$00
; MouseY - The mouse pointer's y.
MouseY:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; ThrottleMouseY - The mouse's Y position last frame, for setting the throttle with the mouse
; (EngineAndSpeed).
ThrottleMouseY:
	dc.b	$00
	dc.b	$00
dat_071_0014E:
	dc.b	$00
	dc.b	$00
dat_071_00150:
	dc.b	$00
	dc.b	$00
; EscortTimer - Mission F3: frames left flying close to the stolen aircraft before they turn
; back (200).
EscortTimer:
	dc.b	$00
	dc.b	$00
; FlightPhysics - Set: the fuller flight model - the stall check (UpdateAttitude), the speed
; lost climbing and gained diving and the lift (ClimbDivePhysics).
FlightPhysics:
	dc.b	$00
; OutsideView - 0 in the cockpit (the panel and the head-up display are drawn); otherwise an
; outside view of ViewObject (the view is taller and the readouts are written over it); keypad
; 5 steps it.
OutsideView:
	dc.b	$00
dat_071_00156:
	dc.b	$00
dat_071_00157:
	dc.b	$00
dat_071_00158:
	dc.b	$00
dat_071_00159:
	dc.b	$00
dat_071_0015A:
	dc.b	$00
	dc.b	$00
dat_071_0015C:
	dc.b	$00
	dc.b	$00
dat_071_0015E:
	dc.b	$00
dat_071_0015F:
	dc.b	$00
; DemoActive - Set while the demo or a recorded flight is playing (DemoSetup); the judges and
; the P key test it.
DemoActive:
	dc.b	$00
; AircraftChosen - Set while the aircraft select page waits for 1 or 2.
AircraftChosen:
	dc.b	$00
; MenuOption - A second choice with a menu key: 1 next mission/save log, 2 clear log.
MenuOption:
	dc.b	$00
dat_071_00163:
	dc.b	$00
	dc.b	$00
; FlightScreen - Set while the screen shows the flight (the 3D view and the cockpit), so
; GameFrame runs its drawing stages; clear for the text screens.
FlightScreen:
	dc.b	$00
dat_071_00166:
	dc.b	$00
dat_071_00167:
	dc.b	$00
; MissionResult - $FF objective achieved, $FE mission failed, $FD Air Force One shot down, $FC
; mission completed (landed); then $F0 back to the menu, $EF qualified.
MissionResult:
	dc.b	$00
; TrainingStep - The training's current manoeuvre (1-7, TrainingSequence), moved on by Return
; or when one is done.
TrainingStep:
	dc.b	$00
dat_071_0016A:
	dc.b	$00
	dc.b	$00
dat_071_0016C:
	dc.b	$00
; ZonesEntered - One bit per zone (Zones) the player has entered.
ZonesEntered:
	dc.b	$00
dat_071_0016E:
	dc.b	$00
dat_071_0016F:
	dc.b	$00
dat_071_00170:
	dc.b	$00
dat_071_00171:
	dc.b	$00
dat_071_00172:
	dc.b	$00
; KeyPressed - Set by HandleKey when a key or button is pressed this frame (2 for the skip key
; during the start).
KeyPressed:
	dc.b	$00
dat_071_00174:
	dc.b	$00
dat_071_00175:
	dc.b	$00
dat_071_00176:
	dc.b	$00
; ViewZoom - The outside camera's distance step (0-$0B: the keypad's 4 and 6, KP1 sets it),
; cleared when the view changes; DrawModel draws more detail when it is 3 or less.
ViewZoom:
	dc.b	$00
dat_071_00178:
	dc.b	$00
dat_071_00179:
	dc.b	$00
	dc.b	$00
dat_071_0017B:
	dc.b	$00
dat_071_0017C:
	dc.b	$00
; MapView - Set while the map view is on (the M key): the camera fixed above the middle of the
; bay looking straight down, at the height kept in dat_071_00034; the view's bottom is then
; ClipY $B3. -1 at startup.
MapView:
	dc.b	$00
; WorldFrozen - Set while the world stands still (before and between flights, the demo's start,
; the debriefing): FrameCount does not advance, the objects and the bullets are not moved.
WorldFrozen:
	dc.b	$00
dat_071_0017F:
	dc.b	$00
dat_071_00180:
	dc.b	$00
dat_071_00181:
	dc.b	$00
dat_071_00182:
	dc.b	$00
dat_071_00183:
	dc.b	$00
; CameraFollows - The outside camera follows the viewed object (set by the keypad's Enter, the
; fly-bys and the judges); cleared for the map view (SetOutsideCamera).
CameraFollows:
	dc.b	$00
; NewView - Set when the view is changed (a new camera position: the fly-by, the start point,
; the cockpit, the M and Enter keys), so that the camera and the scenery are set up again.
NewView:
	dc.b	$00
; CameraShotStep - Which shot of the camera sequence is on (set by the CameraShots steps).
CameraShotStep:
	dc.b	$00
dat_071_00187:
	dc.b	$00
dat_071_00188:
	dc.b	$00
dat_071_00189:
	dc.b	$00
; LaunchRequest - 1: launch the selected missile.
LaunchRequest:
	dc.b	$00
; InstructorFire - Set to make the instructor's aircraft (object 4) fire at once (object 5);
; cleared by JudgeMission.
InstructorFire:
	dc.b	$00
; FireNow - Set to make the next computer aircraft that checks (EnemyMayFire) fire at once;
; cleared after the launch and by JudgeMission.
FireNow:
	dc.b	$00
dat_071_0018D:
	dc.b	$00
dat_071_0018E:
	dc.b	$00
	dc.b	$00
; ShakeKind - The view shake running (ShakeView): 1-3 picks the sequence; 0 none.
ShakeKind:
	dc.b	$00
dat_071_00191:
	dc.b	$00
	dc.b	$00
dat_071_00193:
	dc.b	$00
	dc.b	$00
; ConfigChanged - Set when the flight log (ConfigBuffer) has changed and must be saved
; (SaveConfig clears it).
ConfigChanged:
	dc.b	$00
; TextPageIndex - Which page of TextPages is being shown (times 2).
TextPageIndex:
	dc.b	$00
; SecurityCode - The security check's four digits (0-15), shown to the player.
SecurityCode:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; SecurityAnswer - The countercode expected, as ASCII digits ended by 0 (MakeSecurityCode).
SecurityAnswer:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; LogDiskCheck - Set while the log disk is checked; cleared when the player goes on.
LogDiskCheck:
	dc.b	$00
dat_071_001A4:
	dc.b	$00
dat_071_001A5:
	dc.b	$00
dat_071_001A6:
	dc.b	$00
dat_071_001A7:
	dc.b	$00
dat_071_001A8:
	dc.b	$00
dat_071_001A9:
	dc.b	$00
	dc.b	$00
; TypeDelay - Frames between characters as a page is typed (the low nibble of the page's colour
; byte).
TypeDelay:
	dc.b	$00
; PageFlags - The current page's flags (from its header): bit 0 typed out a character at a
; time.
PageFlags:
	dc.b	$00
; GroundDetail - Bit 7 toggled by the [ key (set at the start): whether the ground's extra
; detail is drawn (the scenery's distance limits, the ground shapes, the water).
GroundDetail:
	dc.b	$00
dat_071_001AE:
	dc.b	$00
dat_071_001AF:
	dc.b	$00
; TextStatus - The text printer's state: 1 waiting for input, 2/3 typing, bit 7 set when the
; queue has been shown (states wait for it).
TextStatus:
	dc.b	$00
; KeyBuffer - The last 10 raw key codes, a ring filled by HandleKey for the text input.
KeyBuffer:
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
; SecurityInput - What the player typed at the security check.
SecurityInput:
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
; InputLength - The most characters the text input takes (20 for the callsign; the
; countercode's length).
InputLength:
	dc.b	$00
; InputPos - The next character's place in the text being typed (the callsign or the
; countercode).
InputPos:
	dc.b	$00
; KeyBufferIn - Where HandleKey puts the next key in KeyBuffer.
KeyBufferIn:
	dc.b	$00
; KeyBufferOut - Where PrintText takes the next key from KeyBuffer.
KeyBufferOut:
	dc.b	$00
; KeyBufferCount - Keys waiting in KeyBuffer.
KeyBufferCount:
	dc.b	$00
; TextBuffer - A small buffer where numbers are turned into digits (BinToBCD) before they are
; printed or drawn.
TextBuffer:
	dc.b	$00
dat_071_001CB:
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_001CE:
	dc.b	$00
dat_071_001CF:
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
; TargetText - The target readout's text line (TargetReadout).
TargetText:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_001DE:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_001E7:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_001F0:
	dc.b	$00
dat_071_001F1:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; QuitRequest - Set by the keys and the game: $FF Shift+Esc (back to the menu), 1 Esc (restart
; the selection), 2 bailed out (hunk 17, when the pilot's parachute object lands), 3 the
; mission's objective is done (hunk 18).
QuitRequest:
	dc.b	$00
; RestartMission - Set when a selection is restarted after the security code was passed: the
; briefing and the security check are skipped.
RestartMission:
	dc.b	$00
; QuitDelay - Frames before QuitRequest 2 or 3 is acted on (4).
QuitDelay:
	dc.b	$00
dat_071_001FD:
	dc.b	$00
; PitchInput - The stick / cursor keys, pitch: $10 up, $20 down, 0 centre.
PitchInput:
	dc.b	$00
; CommaPeriodInput - The , and . keys: $80 ',', $40 '.', 0 neither.
CommaPeriodInput:
	dc.b	$00
; RollInput - The stick / cursor keys, roll: $08 left, $04 right, 0 centre.
RollInput:
	dc.b	$00
dat_071_00201:
	dc.b	$00
dat_071_00202:
	dc.b	$00
dat_071_00203:
	dc.b	$00
dat_071_00204:
	dc.b	$00
dat_071_00205:
	dc.b	$00
; PanelBlitCount - Frames left in which the instrument panel picture is blitted in full
; (DrawPanel): set to 3 when the cockpit appears or the view changes, counted down by
; GameFrame.
PanelBlitCount:
	dc.b	$00
; PanelRedraw - While above 0 every readout of the panel is drawn each frame (otherwise each
; only every fourth frame, in turn); RedrawInstruments sets it and GameFrame counts it down.
PanelRedraw:
	dc.b	$00
dat_071_00208:
	dc.b	$00
dat_071_00209:
	dc.b	$00
dat_071_0020A:
	dc.b	$00
; WeaponRangeRedraw - Frames left to redraw the weapon's range (ShowWeaponRange).
WeaponRangeRedraw:
	dc.b	$00
; TargetReadoutRedraw - Frames left to redraw the target readout in full (set to 2 by the Y key
; and RedrawInstruments).
TargetReadoutRedraw:
	dc.b	$00
dat_071_0020D:
	dc.b	$00
dat_071_0020E:
	dc.b	$00
dat_071_0020F:
	dc.b	$00
dat_071_00210:
	dc.b	$00
dat_071_00211:
	dc.b	$00
dat_071_00212:
	dc.b	$00
; StoresRedraw - Frames left to redraw the stores display (DrawStores): set to 3 when a weapon
; is fired or selected.
StoresRedraw:
	dc.b	$00
dat_071_00214:
	dc.b	$00
dat_071_00215:
	dc.b	$00
dat_071_00216:
	dc.b	$00
dat_071_00217:
	dc.b	$00
; StartPoint - Where the flight starts: an entry of StartPoints (chosen by key in free flight;
; 3, on the carrier, by default; 0 in mission F1).
StartPoint:
	dc.b	$00
; PlayerAircraftType - The player's aircraft: $11 F/A-18, $10 F-16.
PlayerAircraftType:
	dc.b	$00
	dc.b	$00
; RecordMode - The flight recording's mode: 0 recording, 1-3 replaying (1: the events' second
; word is not replayed), 4 finished.
RecordMode:
	dc.b	$00
dat_071_0021C:
	dc.b	$00
dat_071_0021D:
	dc.b	$00
dat_071_0021E:
	dc.b	$00
dat_071_0021F:
	dc.b	$00
; ViewPlace - Which part of its map cell the view is in (UpdateViewCell): used to pick the
; scenery and by the view tables (LookupViewTable).
ViewPlace:
	dc.b	$00
; ViewSubCell - The viewing object's sub-cell (its +$0A).
ViewSubCell:
	dc.b	$00
	dc.b	$00
	dc.b	$00
; ViewOctant - Which eighth of a turn the view's heading is in (0-7, 45 degrees each, worked
; out in hunk 20): picks the order the cells are visited in (BuildSceneryList), so the far ones
; are drawn first.
ViewOctant:
	dc.b	$00
; ViewOctantShown - ViewOctant when the scenery was last built; a change asks for a rebuild
; (UpdateViewCell).
ViewOctantShown:
	dc.b	$00
dat_071_00226:
	dc.b	$00
dat_071_00227:
	dc.b	$00
; RedrawFlags - What must be drawn again (set when the view moves into another map cell...).
RedrawFlags:
	dc.b	$00
dat_071_00229:
	dc.b	$00
dat_071_0022A:
	dc.b	$00
; ObjectDrawFlags - Flags for the object being drawn (DrawObjects; bit 6 and bit 4 tested by
; DrawModel, DistanceScale and the ground shapes).
ObjectDrawFlags:
	dc.b	$00
dat_071_0022C:
	dc.b	$00
dat_071_0022D:
	dc.b	$00
dat_071_0022E:
	dc.b	$00
dat_071_0022F:
	dc.b	$00
dat_071_00230:
	dc.b	$00
dat_071_00231:
	dc.b	$00
dat_071_00232:
	dc.b	$00
dat_071_00233:
	dc.b	$00
; SceneryDetailed - Set while the detailed scenery (SceneryMap2, the cells themselves) is built
; and drawn; clear for the coarse maps.
SceneryDetailed:
	dc.b	$00
; SceneryMapOne - With SceneryDetailed clear: SceneryMap1 rather than SceneryMap0.
SceneryMapOne:
	dc.b	$00
dat_071_00236:
	dc.b	$00
dat_071_00237:
	dc.b	$00
dat_071_00238:
	dc.b	$00
dat_071_00239:
	dc.b	$00
dat_071_0023A:
	dc.b	$00
; HeightBand - How high the view is (0-3, SetHeightBand): decides how much of the ground and
; scenery is drawn (the ground dots, the shadow, the shapes' operations).
HeightBand:
	dc.b	$00
dat_071_0023C:
	dc.b	$00
dat_071_0023D:
	dc.b	$00
; StatusLights - Bits for the panel's status lights (DrawStatusLights): bits 1, 2, 4 and 5.
StatusLights:
	dc.b	$00
; VisualConfirmTimer - Mission F1: counts 30 frames down while an aircraft is held close in the
; view; negative when the confirmation is done.
VisualConfirmTimer:
	dc.b	$00
dat_071_00240:
	dc.b	$00
dat_071_00241:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00248:
	dc.b	$00
dat_071_00249:
	dc.b	$00
dat_071_0024A:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00253:
	dc.b	$00
dat_071_00254:
	dc.b	$00
dat_071_00255:
	dc.b	$00
dat_071_00256:
	dc.b	$00
dat_071_00257:
	dc.b	$00
dat_071_00258:
	dc.b	$00
dat_071_00259:
	dc.b	$00
dat_071_0025A:
	dc.b	$00
dat_071_0025B:
	dc.b	$00
dat_071_0025C:
	dc.b	$00
dat_071_0025D:
	dc.b	$00
; WarningTicks - The warning beat of this frame (WarningTicker): bits for every 8th, 4th and
; 2nd frame.
WarningTicks:
	dc.b	$00
; ShakeStep - How far through its sequence the view shake is (ShakeView).
ShakeStep:
	dc.b	$00
dat_071_00260:
	dc.b	$00
dat_071_00261:
	dc.b	$00
dat_071_00262:
	dc.b	$00
dat_071_00263:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; AircraftLeft - The aircraft the player has left (3; 5 in free flight).
AircraftLeft:
	dc.b	$00
; CodeTries - Tries left at the security code (2, so 3 tries).
CodeTries:
	dc.b	$00
dat_071_00269:
	dc.b	$00
dat_071_0026A:
	dc.b	$00
; SeaView - Set (CheckSeaView) when the ground under the horizon is drawn as sea (colour 6)
; instead of land (colour 4).
SeaView:
	dc.b	$00
dat_071_0026C:
	dc.b	$00
dat_071_0026D:
	dc.b	$00
dat_071_0026E:
	dc.b	$00
dat_071_0026F:
	dc.b	$00
; FadeLevel - The palette's brightness now (0-15; 15 is the full in-flight palette,
; dat_021_00080 row 0), stepped towards FadeTarget by MouseInterrupt.
FadeLevel:
	dc.b	$00
; FadeTarget - The brightness the palette is fading to (FadeLevel); the states set it and wait
; until FadeLevel reaches it.
FadeTarget:
	dc.b	$00
	dc.b	$00
dat_071_00273:
	dc.b	$00
; PaletteLoadCount - Frames left in which ShowDisplay loads LivePalette into the display (set
; when it changes).
PaletteLoadCount:
	dc.b	$00
dat_071_00275:
	dc.b	$00
; GameMode - The flight chosen at the menu: 1 free flight, 2 training demo, 3-8 missions F1-F6,
; 9 qualification, $7D practice maneuvers, $7F demo; -1 the selectable missions page, -2 the
; flight log page; 0 at the menu.
GameMode:
	dc.b	$00
; Difficulty - The difficulty (the flight log's +$02): how often computer aircraft may fire.
Difficulty:
	dc.b	$00
; DifficultySaved - The difficulty as loaded from the flight log.
DifficultySaved:
	dc.b	$00
dat_071_00279:
	dc.b	$00
; MissionTargets - How many targets the mission needs (from the mode's set-up table).
MissionTargets:
	dc.b	$00
; MissionTargetsDone - Targets done so far; when it reaches MissionTargets hunk 18 sets
; MissionResult $FF and QuitRequest 3.
MissionTargetsDone:
	dc.b	$00
; CodeResult - The security code's result: > 0 right, < 0 wrong.
CodeResult:
	dc.b	$00
; KeyMode - How the keys are read: 0 flying (the controls), 1 on the text screens, 2 typing the
; security code.
KeyMode:
	dc.b	$00
; CameraSequence - The camera's opening move: 2 the mission fly-by, 3 when it ends, 4 at the
; aircraft, 5 choosing the start, 6 into the cockpit, 0 done.
CameraSequence:
	dc.b	$00
dat_071_0027F:
	dc.b	$00
; EngineSoundRequest - Which engine or cockpit sound to start next ($FE, $FD, $FC, $FA, $FB...:
; set by the flight and the weapons, taken by CockpitSounds; $FF from the view keys).
EngineSoundRequest:
	dc.b	$00
dat_071_00281:
	dc.b	$00
; ViewChoice - The view chosen with the keypad (Key_KP1 ... Key_KPDot: 0-9).
ViewChoice:
	dc.b	$00
dat_071_00283:
	dc.b	$00
; ShootCue - The head-up display's shoot cue: 1 in range (IN RNG / SHOOT, sound 4), 2 closing
; too fast; 0 none.
ShootCue:
	dc.b	$00
dat_071_00285:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_0028B:
	dc.b	$00
dat_071_0028C:
	dc.b	$00
dat_071_0028D:
	dc.b	$00
dat_071_0028E:
	dc.b	$00
	dc.b	$00
; DebriefDelay - Frames before the debriefing (StateTimer for StateDebriefWait), set with the
; result.
DebriefDelay:
	dc.b	$00
	dc.b	$00
; RescuePod - Mission F4: the rescue pod's object (offset into ObjectTable), 0 until it is
; dropped (Shift+F).
RescuePod:
	dc.b	$00
	dc.b	$00
; CompassPos - The compass strip's position (CompassPosition).
CompassPos:
	dc.b	$00
	dc.b	$00
; GunFlags - Bit 3: the gun is firing.
GunFlags:
	dc.b	$00
	dc.b	$00
dat_071_00298:
	dc.b	$00
	dc.b	$00
dat_071_0029A:
	dc.b	$00
	dc.b	$00
; StatusBits - A word of status bits: 0 a warning or message is showing (StartWarning), 3
; tested by the G key, 6 waiting for the flight to start (set at the ready screen, cleared once
; flying), 8 set by UpdateObject, 10 the view is shaking (ShakeView), 11 set when the aircraft
; is placed; 13-14 cleared on a crash.
StatusBits:
	dc.b	$00
dat_071_0029D:
	dc.b	$00
dat_071_0029E:
	dc.b	$00
	dc.b	$00
dat_071_002A0:
	dc.b	$00
	dc.b	$00
dat_071_002A2:
	dc.b	$00
	dc.b	$00
dat_071_002A4:
	dc.b	$00
	dc.b	$00
dat_071_002A6:
	dc.b	$00
	dc.b	$00
; ViewY - The y offset of what is drawn with PlotInView.
ViewY:
	dc.b	$00
	dc.b	$00
; FrameCount - Counts frames (GameFrame runs some parts every 2nd, 4th, 8th, 16th or 32nd
; frame).
FrameCount:
	dc.b	$00
dat_071_002AB:
	dc.b	$00
; ViewObjectIndex - The number of the object the view follows (0 the player; ViewObject is this
; x $200).
ViewObjectIndex:
	dc.b	$00
	dc.b	$00
; ViewObject - The offset (number << 9) of the object the view is from (normally the player,
; 0).
ViewObject:
	dc.b	$00
	dc.b	$00
dat_071_002B0:
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
dat_071_002BC:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_002C0:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; FuelShown - The fuel readout's last value (ValueChanged).
FuelShown:
	dc.b	$00
	dc.b	$00
; SpeedShown - The speed readout's last value.
SpeedShown:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; ThrottleShown - The throttle readout's last value.
ThrottleShown:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; AltitudeShown - The altitude readout's last value.
AltitudeShown:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_002D4:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_002D8:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; FlightStartTime - When the flight began (TimeSeconds; moved on by the time spent paused), for
; the flight's length in the log.
FlightStartTime:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_002E0:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; MissionStartTime - When the mission started (TimeSeconds).
MissionStartTime:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; PanelShakeOffset - The byte offset added to the instrument panel's blits and digits while the
; view shakes (ShakeView); 0 otherwise.
PanelShakeOffset:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_002EC:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_002F0:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_002F4:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; LogDiskStatus - 0 the log disk is good, 1 no disk in df0:, 2 not initialised, 3 write
; protected.
LogDiskStatus:
	dc.b	$00
	dc.b	$00
dat_071_002FA:
	dc.b	$00
	dc.b	$00
dat_071_002FC:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00300:
	dc.b	$00
	dc.b	$00
dat_071_00302:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; TargetScreenPos - Where the locked target's centre is on the screen (x, y), set by DrawModel;
; the head-up display's target box moves towards it.
TargetScreenPos:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; SeekerPos - Where the missile seeker is on the screen (x, y).
SeekerPos:
	dc.b	$00
	dc.b	$00
dat_071_0030C:
	dc.b	$00
	dc.b	$00
; GunPipperPos - Where the gun pipper is on the screen (x, y); x <= 0 for none.
GunPipperPos:
	dc.b	$00
	dc.b	$00
dat_071_00310:
	dc.b	$00
	dc.b	$00
; TargetBoxPos - Where the head-up display's target box is (x, y), DrawTargetBox.
TargetBoxPos:
	dc.b	$00
	dc.b	$00
dat_071_00314:
	dc.b	$00
	dc.b	$00
dat_071_00316:
	dc.b	$00
	dc.b	$00
; ViewBlockX - The view's cell X / 4: its block on the coarse scenery grid (SceneryMap0 and 1).
ViewBlockX:
	dc.b	$00
	dc.b	$00
; ViewBlockZ - The view's cell Z / 4 (see ViewBlockX).
ViewBlockZ:
	dc.b	$00
	dc.b	$00
; ViewCellX - The viewing object's map cell X (its +$06).
ViewCellX:
	dc.b	$00
	dc.b	$00
; ViewCellZ - The viewing object's map cell Z (its +$08).
ViewCellZ:
	dc.b	$00
	dc.b	$00
dat_071_00320:
	dc.b	$00
	dc.b	$00
; TextColour - The colour the page is drawn in (the high nibble of the page's colour byte).
TextColour:
	dc.b	$00
	dc.b	$00
; DrawColour - The colour Plot and DrawLine draw in (0-15).
DrawColour:
	dc.b	$00
dat_071_00325:
	dc.b	$00
; ColourBits - The colour being drawn (a copy of DrawColour), shifted right one bit per bit-
; plane as the line and fill routines go through the planes.
ColourBits:
	dc.b	$00
dat_071_00327:
	dc.b	$00
dat_071_00328:
	dc.b	$00
	dc.b	$00
dat_071_0032A:
	dc.b	$00
	dc.b	$00
; GridZShown - The position readout's last Z.
GridZShown:
	dc.b	$00
	dc.b	$00
; GridXShown - The position readout's last X.
GridXShown:
	dc.b	$00
	dc.b	$00
dat_071_00330:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00334:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00338:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_0033E:
	dc.b	$00
	dc.b	$00
dat_071_00340:
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
dat_071_0034C:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00350:
	dc.b	$00
	dc.b	$00
dat_071_00352:
	dc.b	$00
	dc.b	$00
; ClipY - The row PlotBigAbove switches at ($90 = 144: the top of the panel).
ClipY:
	dc.b	$00
	dc.b	$00
; ViewShift - How far the cockpit's drawing is moved, in 16-pixel words (ViewX = ViewShift x
; 16): 0 in the cockpit, 50 (off the screen) in the outside views; the digits drawn by
; PrintNumberHUD move with it.
ViewShift:
	dc.b	$00
	dc.b	$00
; ViewX - The x offset of what is drawn with PlotInView (the view window's left edge).
ViewX:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; HUDTapeOffset - Where a HUD scale's ticks start (the tape's or heading scale's pixel offset
; this frame).
HUDTapeOffset:
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
; FrameEvents1 - The first word of the frame's key / button events (recorded and replayed).
FrameEvents1:
	dc.b	$00
	dc.b	$00
; FrameEvents2 - The second word of the frame's events.
FrameEvents2:
	dc.b	$00
	dc.b	$00
; JoyEvents - Joystick button events waiting for ReadControls (bit 2 fire down, bit 3 fire up).
JoyEvents:
	dc.b	$00
dat_071_0036B:
	dc.b	$00
; ViewKeys - The view keys pressed since the last frame (bits: 0 M, 1-2 Enter, 3 KP5, 4 KP8, 5
; KP9, 6 KP6, 7 KP3), passed on each frame by ReadControls (FrameEvents2).
ViewKeys:
	dc.b	$00
; ViewKeys2 - More view keys pressed since the last frame (bits: 0 KP2, 2 KP4, 3 KP7, 5 KP dot,
; 7 KP5...).
ViewKeys2:
	dc.b	$00
; DebugCheckpoint - A number written just before many calls to Nop: where the program last was,
; left from debugging (nothing reads it).
DebugCheckpoint:
	dc.b	$00
	dc.b	$00
dat_071_00370:
	dc.b	$00
	dc.b	$00
; CompassShown - The compass position last drawn (bit 15: draw it again).
CompassShown:
	dc.b	$00
	dc.b	$00
dat_071_00374:
	dc.b	$00
	dc.b	$00
dat_071_00376:
	dc.b	$00
	dc.b	$00
dat_071_00378:
	dc.b	$00
	dc.b	$00
; LoopIndex - A loop counter shared by several drawing loops (the far scenery lists,
; DrawObjects, DrawHUDFixed, DrawTargetBox, DrawStartPointMarkers).
LoopIndex:
	dc.b	$00
	dc.b	$00
dat_071_0037C:
	dc.b	$00
	dc.b	$00
dat_071_0037E:
	dc.b	$00
	dc.b	$00
dat_071_00380:
	dc.b	$00
	dc.b	$00
dat_071_00382:
	dc.b	$00
	dc.b	$00
; CurrentObject - The number of the object being worked on.
CurrentObject:
	dc.b	$00
dat_071_00385:
	dc.b	$00
; CurrentObjectOffset - Its offset in ObjectTable (number << 9).
CurrentObjectOffset:
	dc.b	$00
	dc.b	$00
; BulletHitObject - The object a bullet hit (BulletHitTest), 0 for none.
BulletHitObject:
	dc.b	$00
	dc.b	$00
dat_071_0038A:
	dc.b	$00
	dc.b	$00
dat_071_0038C:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; LockedTarget - The object the radar has locked (offset into ObjectTable), -1 for none.
LockedTarget:
	dc.b	$00
	dc.b	$00
; EjectedPilot - The ejected pilot's object (offset into ObjectTable; type $30, under the
; parachute).
EjectedPilot:
	dc.b	$00
	dc.b	$00
; TargetReadoutMode - What the target readout shows (TargetReadout): stepped by the Y key, set
; to 1 by the radar when a blip is found; bit 15 marks it changed.
TargetReadoutMode:
	dc.b	$00
	dc.b	$00
dat_071_00396:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; RadarListEnd - Where AddRadarObject puts the next entry of RadarList.
RadarListEnd:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_0039E:
	dcb.b	96,$00
; SceneryListLimit - The end of the scenery list being built (BuildSceneryList,
; AddCellScenery): no more entries are added past it.
SceneryListLimit:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; CurrentShape - The scenery item (or shape header) being drawn, for the shape operations that
; read it (the runway's, ShapeSceneryTest).
CurrentShape:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; ShapeNow - The shape DrawModel is drawing (the entry's +$04).
ShapeNow:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; ShapeNext - The shape to draw next (the entry's +$08; an animation sets both).
ShapeNext:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_0040E:
	dc.b	$00
	dc.b	$00
dat_071_00410:
	dc.b	$00
	dc.b	$00
; RadarScale - The radar's scale: $80 for the 10 range, $40 for 20, otherwise 40.
RadarScale:
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
dat_071_0041C:
	dc.b	$00
	dc.b	$00
dat_071_0041E:
	dc.b	$00
	dc.b	$00
dat_071_00420:
	dc.b	$00
	dc.b	$00
dat_071_00422:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00426:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_0042A:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_0042E:
	dc.b	$00
	dc.b	$00
dat_071_00430:
	dc.b	$00
	dc.b	$00
; ViewOffsetX - Minus the camera's x within its map cell (with ViewOffsetY, ViewOffsetZ, set by
; SetCockpitEye / SetOutsideCamera): added to a position in the same cell to make it relative
; to the camera.
ViewOffsetX:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; ViewOffsetY - Minus the camera's height: added to a height to make it relative to the camera
; (so a shape on the ground is drawn only while this is above -$380000).
ViewOffsetY:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; ViewOffsetZ - Minus the camera's z within its map cell (see ViewOffsetX).
ViewOffsetZ:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_0043E:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; ViewOffsetX8 - ViewOffsetX / 256, a word (with ViewOffsetY8 and ViewOffsetZ8): the camera
; offset at the scale the drawing works in.
ViewOffsetX8:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; ViewOffsetZ8 - ViewOffsetZ / 256, a word.
ViewOffsetZ8:
	dc.b	$00
	dc.b	$00
; ViewOffsetY8 - ViewOffsetY / 256, a long: an object's height relative to the camera is its
; height / 256 plus this, so the tests 'below -$C0' mean the camera is well above it.
ViewOffsetY8:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; EyeX - The camera's position in the world (x, then EyeY and EyeZ: the full 32-bit positions,
; cell included).
EyeX:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00450:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00454:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00458:
	dc.b	$00
	dc.b	$00
dat_071_0045A:
	dc.b	$00
	dc.b	$00
dat_071_0045C:
	dc.b	$00
	dc.b	$00
dat_071_0045E:
	dc.b	$00
	dc.b	$00
dat_071_00460:
	dc.b	$00
	dc.b	$00
dat_071_00462:
	dc.b	$00
	dc.b	$00
; OutsideCamPitch - The outside camera's pitch (90 degrees, $1C20, looking straight down for
; the map view); with OutsideCamHeading, from dat_071_00490 / 00492 when it follows.
OutsideCamPitch:
	dc.b	$00
	dc.b	$00
; OutsideCamHeading - The outside camera's heading (see OutsideCamPitch).
OutsideCamHeading:
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
dat_071_00470:
	dc.b	$00
	dc.b	$00
dat_071_00472:
	dc.b	$00
	dc.b	$00
dat_071_00474:
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
dat_071_00486:
	dc.b	$00
	dc.b	$00
; DistanceShift - How far the object being drawn is scaled down by its distance (a shift, from
; DistanceScale): its vertices are shifted right by it so that far objects stay within range.
DistanceShift:
	dc.b	$00
	dc.b	$00
dat_071_0048A:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00490:
	dc.b	$00
	dc.b	$00
dat_071_00492:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00496:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; ClipSwitch - Never written (always 0): the clipping routines test it and always take the same
; branch - a switch left from development.
ClipSwitch:
	dc.b	$00
	dc.b	$00
dat_071_0049C:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_004A0:
	dc.b	$00
	dc.b	$00
dat_071_004A2:
	dc.b	$00
	dc.b	$00
; FrameStage - Which part of GameFrame is running ($08, $10 ... $1D4): set before each part.
FrameStage:
	dc.b	$00
	dc.b	$00
; StateTimer - Counted down by one every frame (RunGameState); a state waits for it to go
; negative.
StateTimer:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; WarningPlaying - The warning sound now playing (a CurrentWarning word): UpdateWarnings starts
; a new one only when it differs.
WarningPlaying:
	dc.b	$00
	dc.b	$00
; CurrentWarning - The warning sound now chosen (UpdateWarnings): a sound word, its low byte
; the sound, the high bits flags; 0 none.
CurrentWarning:
	dc.b	$00
	dc.b	$00
dat_071_004B2:
	dc.b	$00
	dc.b	$00
dat_071_004B4:
	dc.b	$00
	dc.b	$00
dat_071_004B6:
	dc.b	$00
	dc.b	$00
dat_071_004B8:
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
; TimeSeconds - The system time (ReadTime): seconds.
TimeSeconds:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; TimeMicros - The system time (ReadTime): microseconds.
TimeMicros:
	dc.b	$00
	dc.b	$00
dat_071_004C8:
	dc.b	$00
dat_071_004C9:
	dc.b	$00
dat_071_004CA:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_004CE:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_004D2:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_004D6:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_004DA:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_004DE:
	dc.b	$00
	dc.b	$00
dat_071_004E0:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_004E4:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_004E8:
	dc.b	$00
	dc.b	$00
dat_071_004EA:
	dc.b	$00
	dc.b	$00
; ModeVariant - Which of the mode's three variants (ModeTable) was picked, at random; kept when
; the selection is restarted.
ModeVariant:
	dc.b	$00
	dc.b	$00
; BCDIn - BinToBCD's number.
BCDIn:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; BCDOut - BinToBCD's result: eight BCD digits.
BCDOut:
	dc.b	$00
	dc.b	$00
dat_071_004F4:
	dc.b	$00
	dc.b	$00
; HUDScaleStep - The step between a HUD scale's numbers (5 on the tapes, 10 on the heading
; scale), used with its digit places.
HUDScaleStep:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; ObjectViewPos - The position of the object being drawn relative to the camera, in words (x,
; then y and z at +2, +4: /256 scale); also a scratch area for some HUD and radar routines.
ObjectViewPos:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; ObjectViewPosZ - The z word of ObjectViewPos.
ObjectViewPosZ:
	dc.b	$00
	dc.b	$00
; ObjectViewPosL - The position of the object being drawn relative to the camera, as longs (x,
; then y and z at +4, +8).
ObjectViewPosL:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00504:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00508:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_0050C:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00510:
	dc.b	$00
	dc.b	$00
dat_071_00512:
	dc.b	$00
	dc.b	$00
; TargetRangeLast - The locked target's range (+$4A) the last time it was measured, for
; Closure.
TargetRangeLast:
	dc.b	$00
	dc.b	$00
; Closure - How fast the locked target's range changes (per measurement; negative closing).
Closure:
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
; WarningFlags - Warning bits (bit 0 / bit 1: the fuel's two low levels, bit 6: out of
; fuel...).
WarningFlags:
	dc.b	$00
	dc.b	$00
	dc.b	$00
; ControlBits - Bits used by FlightControls from frame to frame (bit 7 a held control; others
; tested).
ControlBits:
	dc.b	$00
; SoundRequests - Sound request bits for CockpitSounds (4 bytes: $00524-$00527), set by the
; game (UpdateObject sets $80 for a warning...).
SoundRequests:
	dc.b	$00
	dc.b	$00
dat_071_00526:
	dc.b	$00
; CockpitSoundBits - Requests for the cockpit's sounds, one bit each, set by the warnings and
; the controls and played by CockpitSounds.
CockpitSoundBits:
	dc.b	$00
dat_071_00528:
	dc.b	$00
	dc.b	$00
; SoundFlags - Sound flags (bit 2: text201 loaded).
SoundFlags:
	dc.b	$00
; SoundsLoaded - Which sounds were loaded (bits, set by LoadEngineSounds; bit 7 the music
; samples, LoadMusicSamples): the sound routines play only those loaded.
SoundsLoaded:
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_0052E:
	dc.b	$00
	dc.b	$00
dat_071_00530:
	dc.b	$00
	dc.b	$00
dat_071_00532:
	dc.b	$00
	dc.b	$00
dat_071_00534:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00538:
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
dat_071_00544:
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
dat_071_00560:
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
dat_071_00572:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00576:
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
dat_071_00582:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_0058A:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_0058E:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00592:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00596:
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
; ViewMatrix - The view's rotation: a 3 x 3 matrix of words (x 256 scale) turning a position
; relative to the camera into view space; set up with the camera each frame.
ViewMatrix:
	dc.b	$00
	dc.b	$00
dat_071_005AA:
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
; PanelViewMatrix - A second view matrix, for the panel's attitude indicator
; (MakeSkyPolygonPanel).
PanelViewMatrix:
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
dat_071_005CC:
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
dat_071_005DE:
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
dat_071_005F0:
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
dat_071_00602:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00606:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_0060A:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; CameraX - The camera's position X (the eye the 3D view is drawn from).
CameraX:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; CameraY - The camera's position Y (height).
CameraY:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; CameraZ - The camera's position Z.
CameraZ:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_0061A:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_0061E:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00622:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; FlyByPoint - A point (x, y, z longs) where the fly-by's camera or a placed object goes
; (FlyBySetup and the mode setup).
FlyByPoint:
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
; Bullets - The gun's bullets: 20 records of 64 bytes. +$00 the position (x, y, z longs within
; its map cell), +$0C the previous position, +$26 flags (bit 0 in flight; 1 hit the ground, 4
; hit something, $1000 / $2000 how it is drawn at the end), +$28 a timer, +$2E the object that
; fired it, +$30 / +$32 its map cell (x, z).
Bullets:
	dcb.b	1280,$00
dat_071_00B42:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00B48:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00B4E:
	dc.b	$00
	dc.b	$00
dat_071_00B50:
	dc.b	$00
	dc.b	$00
dat_071_00B52:
	dc.b	$00
	dc.b	$00
; ObjectTable - The 16 objects (aircraft, missiles, ships...; the player's aircraft is record 0):
; records of 512 bytes, $00B54-$02B53 (an object's offset = its number << 9). What is known:
;   +$00 w  flags ($2000 throttle at full, $0008 probably the afterburner, $0400 spent...)
;                                       +$01 b  bit 6 the object exists, bit 4 in a cell being drawn
;   +$03 b  bit 7   +$05 b  state (the computer pilot's: 1 pull up, 8 route...)   +$06 w  map cell X   +$08 w  map cell Z
;   +$0A b  sub-cell                    +$10 l
;   +$14 l  position X (low 22 bits: inside the cell)   +$18 l  Y (height; negative is up)
;   +$1C l  position Z (low 22 bits: inside the cell)   +$26 w  (a missile: $14 at launch)
;   +$22 w  (a weight-like term in the stall check)   +$26 w  responsiveness (at most 15)
;   +$2C w, +$2E w  the computer pilot's destination: map cell X, Z   +$30 w, +$32 w  in the cell
;   +$34 l  the destination's height   +$3A b  the route (Routes)
;   +$28 b  pitch stick (-20..20)   +$29 b  rudder (-20..20)   +$2A b  roll stick (-60..60)
;   +$2B b  the throttle (0-120)   +$39 b  low nibble: the throttle's step   +$38 b  (copied to its missiles)
;   +$3E l  velocity X   +$42 l  velocity Y   +$46 l  velocity Z
;   +$4C w  a timer (a missile: $96 / $C8 at launch)
;   +$50 w, +$52 w, +$54 w  target rotation rates (computer aircraft)
;   +$56 w, +$58 w, +$5A w  rotation rates: the +$80 matrix turns by them each frame
;   +$5F b  missiles left: low nibble AMRAAMs, high nibble Sidewinders ($24 at the start)
;   +$62 b  type (0 Sidewinder, 1 AMRAAM; $1x aircraft flown by rotation rates; $3x ...)   +$64 b  more control bits
;   +$63 b  selected weapon (high nibble: $10 gun, $30 AMRAAM, else Sidewinder)
;   +$65 b  control bits: $80/$40 rudder (the , and . keys), $20/$10 pitch, $08/$04 roll, $02/$01 throttle
;   +$66 w  pitch   +$68 w  heading   +$6A w  roll  (1/80 degree; SetAttitude, UpdateAttitude)
;   +$80-$90 w  a 3 x 3 rotation matrix made from them (2.14)
;   +$6C w  speed   +$6E w  the speed flown (+$6C + +$78)   +$76 w  lift / sink (vertical velocity)
;   +$78 w  speed lost climbing / gained diving (ClimbDivePhysics)
;   +$7E w  ($1400 for a computer aircraft)   +$71 b   +$72 l  fuel (6,400,000 at the start)
;   +$7C b  bit 7
;   +$92-$A2 w  the opposite rotation (from the negated angles; rows at +$92, +$98, +$9E)
ObjectTable:
	dc.b	$00
	dc.b	$00
Player_02:
	dc.b	$00
Player_03:
	dc.b	$00
Player_04:
	dc.b	$00
	dc.b	$00
PlayerCellX:
	dc.b	$00
	dc.b	$00
PlayerCellZ:
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
; PlayerX - The player's position X (ObjectTable+$14).
PlayerX:
	dc.b	$00
	dc.b	$00
Player_16:
	dc.b	$00
	dc.b	$00
; PlayerY - The player's height (ObjectTable+$18; negative is up).
PlayerY:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; PlayerZ - The player's position Z (ObjectTable+$1C).
PlayerZ:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
Player_20:
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
Player_2B:
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
Player_3B:
	dc.b	$00
	dc.b	$00
	dc.b	$00
; PlayerVelX - The player's velocity X (ObjectTable+$3E).
PlayerVelX:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; PlayerVelY - The player's velocity Y (ObjectTable+$42).
PlayerVelY:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; PlayerVelZ - The player's velocity Z (ObjectTable+$46).
PlayerVelZ:
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
Player_56:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; PlayerMissiles - The player's missiles left (ObjectTable+$5F): low nibble AMRAAMs, high
; nibble Sidewinders.
PlayerMissiles:
	dc.b	$00
Player_60:
	dc.b	$00
	dc.b	$00
PlayerType:
	dc.b	$00
; PlayerWeapon - The player's selected weapon (ObjectTable+$63; high nibble $10 gun, $30
; AMRAAM, else Sidewinder).
PlayerWeapon:
	dc.b	$00
	dc.b	$00
; PlayerControls - The player's control bits (ObjectTable+$65).
PlayerControls:
	dc.b	$00
Player_66:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
Player_6C:
	dc.b	$00
	dc.b	$00
Player_6E:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; PlayerFuel - The player's fuel (ObjectTable+$72): 6,400,000 at the start; the warnings at
; 768,000 and 460,800, out of fuel at 0.
PlayerFuel:
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
Player_7C:
	dc.b	$00
Player_7D:
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
	dc.b	$00
	dc.b	$00
	dc.b	$00
; PlayerM11 - The player's orientation matrix (ObjectTable+$92-$A2: 9 words, rows M11-M13,
; M21-M23, M31-M33).
PlayerM11:
	dc.b	$00
	dc.b	$00
PlayerM12:
	dc.b	$00
	dc.b	$00
PlayerM13:
	dc.b	$00
	dc.b	$00
PlayerM21:
	dc.b	$00
	dc.b	$00
PlayerM22:
	dc.b	$00
	dc.b	$00
PlayerM23:
	dc.b	$00
	dc.b	$00
PlayerM31:
	dc.b	$00
	dc.b	$00
PlayerM32:
	dc.b	$00
	dc.b	$00
PlayerM33:
	dcb.b	350,$00
; Object1 - Object 1 of ObjectTable.
Object1:
	dc.b	$00
Object1_01:
	dcb.b	511,$00
; Object2 - Object 2 of ObjectTable.
Object2:
	dc.b	$00
Object2_01:
	dcb.b	511,$00
; Object3 - Object 3 of ObjectTable.
Object3:
	dc.b	$00
Object3_01:
	dcb.b	511,$00
; Object4 - Object 4 of ObjectTable.
Object4:
	dc.b	$00
	dc.b	$00
Object4_02:
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
Object4_14:
	dcb.b	492,$00
; Object5 - Object 5 of ObjectTable.
Object5:
	dcb.b	512,$00
; Object6 - Object 6 of ObjectTable.
Object6:
	dcb.b	512,$00
; Object7 - Object 7 of ObjectTable.
Object7:
	dcb.b	512,$00
; Object8 - Object 8 of ObjectTable.
Object8:
	dc.b	$00
Object8_01:
	dcb.b	511,$00
; Object9 - Object 9 of ObjectTable.
Object9:
	dcb.b	512,$00
; Object10 - Object 10 of ObjectTable.
Object10:
	dc.b	$00
Object10_01:
	dcb.b	511,$00
; Object11 - Object 11 of ObjectTable.
Object11:
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
	dc.b	$00
	dc.b	$00
Object11_14:
	dcb.b	492,$00
; Object12 - Object 12 of ObjectTable.
Object12:
	dcb.b	512,$00
; Object13 - Object 13 of ObjectTable.
Object13:
	dcb.b	512,$00
; Object14 - Object 14 of ObjectTable.
Object14:
	dcb.b	512,$00
; Object15 - Object 15 of ObjectTable.
Object15:
	dcb.b	512,$00
; SmallObjects - 16 small objects of 32 bytes after the ObjectTable, with the same +$01 flags,
; +$06 / +$08 map cell and +$0A sub-cell.
SmallObjects:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
SmallObjects_04:
	dcb.b	508,$00
h071_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc
