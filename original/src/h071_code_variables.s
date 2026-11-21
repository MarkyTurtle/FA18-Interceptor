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
; RadarAltitude - The radar altimeter's height (RunGame), shown when RadarAltimeterOn.
RadarAltitude:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; AltitudeValue - The height for the altitude readout (RunGame), at most 99,999.
AltitudeValue:
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
; MapViewHeight - The map view's camera height ($3000000 at the start; the M key keeps the
; camera's).
MapViewHeight:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; TitleTimer - The title and menu screens' timer (TimeSeconds-based; $1F0000 to wait).
TitleTimer:
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
; BufferPlanes5 - The five plane addresses of the display buffer (SetupBufferPlanes), for
; SelectDrawBuffer.
BufferPlanes5:
	dcb.b	40,$00
; DrawPlanes - Points at the four plane pointers that drawing goes to (the buffer being drawn).
DrawPlanes:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; DrawBitPlanes - Points at the plane list of the buffer being drawn (SelectDrawBuffer).
DrawBitPlanes:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; Buffer1Plane0 - Display buffer 1's plane 0 (with Buffer1Plane1-4 after it: the 5-plane
; BitMap's planes, InitDisplay).
Buffer1Plane0:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; Buffer1Plane1 - Display buffer 1's plane 1.
Buffer1Plane1:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; Buffer1Plane2 - Display buffer 1's plane 2.
Buffer1Plane2:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; Buffer1Plane3 - Display buffer 1's plane 3.
Buffer1Plane3:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; Buffer1Plane4 - Display buffer 1's plane 4.
Buffer1Plane4:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; Buffer2Plane0 - Display buffer 2's plane 0 (with Buffer2Plane1-3).
Buffer2Plane0:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; Buffer2Plane1 - Display buffer 2's plane 1.
Buffer2Plane1:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; Buffer2Plane2 - Display buffer 2's plane 2.
Buffer2Plane2:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; Buffer2Plane3 - Display buffer 2's plane 3.
Buffer2Plane3:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; FillPlane - The plane FillPolygonPlane fills into (and draws the edges in): normally a work
; plane, plane 0 for the sky.
FillPlane:
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
; FillPatternBits - The low byte of FillPattern's second word: DrawLine draws in the planes
; whose bits are set.
FillPatternBits:
	dc.b	$00
; FillPattern2 - The second long of FillPattern.
FillPattern2:
	dc.b	$00
; DrawXorMask - The planes XORed when DrawXor >= 0.
DrawXorMask:
	dc.b	$00
; FillPattern3 - FillPattern's third word (FillPolygon: whether the fill is patterned).
FillPattern3:
	dc.b	$00
	dc.b	$00
; DistanceScaleX - DistanceScale's scaled values (with DistanceScaleY at 000C2, DistanceScaleZ
; at 000C6).
DistanceScaleX:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; DistanceScaleY - DistanceScaleY - See DistanceScaleX.
DistanceScaleY:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; DistanceScaleZ - See DistanceScaleX.
DistanceScaleZ:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; FlightValue - A long value that FlyAircraft and PitchEffect use with the cockpit object
; (not worked out).
FlightValue:
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
; PrintTarget - The plane address PrintText draws into.
PrintTarget:
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
; TextCursor - Where text is printed next (a byte offset in the planes; $1B8 at the top of a
; page).
TextCursor:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; TextRows - A text setting set to 3 at the start (main).
TextRows:
	dc.b	$00
	dc.b	$00
; TextHoldTimer - Frames the last page stays up before TextStatus bit 7 is set.
TextHoldTimer:
	dc.b	$00
	dc.b	$00
; PrintIndex - PrintText's position in its text.
PrintIndex:
	dc.b	$00
	dc.b	$00
; PrintCount - PrintText's character count (-1 from PrintNumber).
PrintCount:
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
; MouseIntFrames - Counts the mouse interrupt's frames.
MouseIntFrames:
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
; LastFrameEvents - The previous frame's control events (ReadControls).
LastFrameEvents:
	dc.b	$00
	dc.b	$00
; FrameControlEvents - The control events of the frame (ReadControls), read by MouseThrottle.
FrameControlEvents:
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
; HeightBandChanged - Set by SetHeightBand when the height band changes, so that the scenery
; lists are rebuilt.
HeightBandChanged:
	dc.b	$00
; TextInputOn - Set while text can be typed (the callsign): HandleKey and the G key test it.
TextInputOn:
	dc.b	$00
; ObjectsHeld - Set (with WorldFrozen) to hold the objects still while the flight is being
; readied.
ObjectsHeld:
	dc.b	$00
; LaunchFlag - Tested by LaunchMissile.
LaunchFlag:
	dc.b	$00
; MissileFlag - Set by UpdateMissile.
MissileFlag:
	dc.b	$00
	dc.b	$00
; FlightHeld - Tested by StateFlying and UpdateObject.
FlightHeld:
	dc.b	$00
	dc.b	$00
; StepFlag - Tested by StepObject.
StepFlag:
	dc.b	$00
; AttitudeFlag - Tested by UpdateAttitude.
AttitudeFlag:
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
; TrainingReady - Set when the flight is ready; the training's instructor and TargetReadout
; test it.
TrainingReady:
	dc.b	$00
	dc.b	$00
; FlightScreen - Set while the screen shows the flight (the 3D view and the cockpit), so
; GameFrame runs its drawing stages; clear for the text screens.
FlightScreen:
	dc.b	$00
; BriefingLastKey - The key last seen on the briefing screens (to act on a new press only).
BriefingLastKey:
	dc.b	$00
; EngineSoundHold - Frames for which the engine sound is held back while another sound plays
; (set by the engine, missiles and PlaySweep).
EngineSoundHold:
	dc.b	$00
; MissionResult - $FF objective achieved, $FE mission failed, $FD Air Force One shot down, $FC
; mission completed (landed); then $F0 back to the menu, $EF qualified.
MissionResult:
	dc.b	$00
; TrainingStep - The training's current manoeuvre (1-7, TrainingSequence), moved on by Return
; or when one is done.
TrainingStep:
	dc.b	$00
; TrainingWaitKey - The training instructor waiting for the player ($FF / $FE, TrainingPilot):
; Return and fire are tested against it.
TrainingWaitKey:
	dc.b	$00
	dc.b	$00
; TrainingStepFlag - Set to $FF by TrainingAndGLimit (the training's steps).
TrainingStepFlag:
	dc.b	$00
; ZonesEntered - One bit per zone (Zones) the player has entered.
ZonesEntered:
	dc.b	$00
; SceneryFlag - Tested by DrawSceneryPlain.
SceneryFlag:
	dc.b	$00
; FlightStep - A step value used by FlyAircraft (compared with 3...).
FlightStep:
	dc.b	$00
; FlightFlag170 - Tested three times by FlyAircraft, cleared by ResetPlayer.
FlightFlag170:
	dc.b	$00
; HUDOn - Whether the head-up display shows its readouts (the G load, height, speed, heading
; and gun sight): set when the flight starts, toggled by the H key.
HUDOn:
	dc.b	$00
; GroundDotsDrawn - Set by DrawGroundDots while drawing (FillPolygonPlane tests it).
GroundDotsDrawn:
	dc.b	$00
; KeyPressed - Set by HandleKey when a key or button is pressed this frame (2 for the skip key
; during the start).
KeyPressed:
	dc.b	$00
; RadarAltimeterOn - Set when the height shown is the radar altimeter's (RadarAltitude) rather
; than the height above the sea.
RadarAltimeterOn:
	dc.b	$00
; DrawGroupsReady - Set when the drawing groups are built (tested by BuildDrawGroups).
DrawGroupsReady:
	dc.b	$00
; AnglesSet - Set by VectorToAngles; cleared by SwitchView and ResetViewAndRecording.
AnglesSet:
	dc.b	$00
; ViewZoom - The outside camera's distance step (0-$0B: the keypad's 4 and 6, KP1 sets it),
; cleared when the view changes; DrawModel draws more detail when it is 3 or less.
ViewZoom:
	dc.b	$00
; ZoomKeyHeld - Cleared by the keypad's view keys (KP1, 2, 4, 6, 7) and BackToCockpitView.
ZoomKeyHeld:
	dc.b	$00
; ViewKeyFlag - Cleared by the KP1 key and SetViewLimits.
ViewKeyFlag:
	dc.b	$00
	dc.b	$00
; EjectKeyFlag - The E key's flag (eject), cleared for a new aircraft.
EjectKeyFlag:
	dc.b	$00
; ViewSide - Flipped by SwitchView (GunFlags bit 4) in the outside view: which side the camera
; is on (OutsideEyeOffset).
ViewSide:
	dc.b	$00
; MapView - Set while the map view is on (the M key): the camera fixed above the middle of the
; bay looking straight down, at the height kept in MapViewHeight; the view's bottom is then
; ClipY $B3. -1 at startup.
MapView:
	dc.b	$00
; WorldFrozen - Set while the world stands still (before and between flights, the demo's start,
; the debriefing): FrameCount does not advance, the objects and the bullets are not moved.
WorldFrozen:
	dc.b	$00
; PilotsHeld - Set to stop the computer pilots (tested with WorldFrozen by ComputerPilot);
; UpdateAttitude reads it.
PilotsHeld:
	dc.b	$00
; JToggle2 - Toggled with JToggle by the J key; GameFrame and DrawWaterAreas test it.
JToggle2:
	dc.b	$00
; CockpitViewKind - The kind of cockpit view (CockpitViewMatrix tests 1).
CockpitViewKind:
	dc.b	$00
; GameFrameFlag - Tested by GameFrame.
GameFrameFlag:
	dc.b	$00
; DebugNumbersOn - Set to show ShowDebugNumbers' readings.
DebugNumbersOn:
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
; JustFired - Set when the player fires a missile (PlayerLaunch); the computer pilots'
; reactions read and clear it.
JustFired:
	dc.b	$00
; EjectSoundCount - Frames of the ejection's sound (-1 from CheckEjection, counted by
; CockpitSounds).
EjectSoundCount:
	dc.b	$00
; TKeyPressed - Set by the T key; the radar blips' drawing takes and clears it.
TKeyPressed:
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
; BulletsHeld - Set to stop the bullets moving (tested with WorldFrozen).
BulletsHeld:
	dc.b	$00
; JudgeSavedView - The view choice saved by the judges (bit 7 set while saved), put back by
; StateFlying.
JudgeSavedView:
	dc.b	$00
	dc.b	$00
; ShakeKind - The view shake running (ShakeView): 1-3 picks the sequence; 0 none.
ShakeKind:
	dc.b	$00
; FrameParity - Counted up by RunGameState each frame; its low bits pace the cockpit sounds.
FrameParity:
	dc.b	$00
	dc.b	$00
; TextShowing - Set while a text screen is up (ClearTextPages and the text states); StateFlying
; tests it.
TextShowing:
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
; GameStarted - Set to 1 at the start (InitGameValues).
GameStarted:
	dc.b	$00
; TextKeyCount - Counts keys on the text screens (HandleKey); -1 to start a new page.
TextKeyCount:
	dc.b	$00
; TitleShown - Set once the title picture is up (main; SaveTitleBitMap tests it).
TitleShown:
	dc.b	$00
; MusicState - The title music: 0 not playing, 1 playing (the menus), 2 started
; (PlayTitleMusic); MenuBeep and PrintNumber stay quiet while it plays.
MusicState:
	dc.b	$00
; MouseActive - Set when the mouse is used for the controls (ResetPlayerFlags; EngineAndSpeed
; and MouseInterrupt test it).
MouseActive:
	dc.b	$00
; ReadoutsDrawn - Set by GameFrame when the panel's readouts have been drawn this frame
; (cleared by UpdateMissile; tested by the readouts).
ReadoutsDrawn:
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
; PrintDelay - PrintText's character delay counter.
PrintDelay:
	dc.b	$00
; PrintFlag - Set by PrintText and PrintNumber while printing.
PrintFlag:
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
; TextBuffer1 - TextBuffer + 1: where the digits start.
TextBuffer1:
	dc.b	$00
	dc.b	$00
	dc.b	$00
; TextBuffer4 - TextBuffer + 4.
TextBuffer4:
	dc.b	$00
; TextBuffer5 - TextBuffer + 5.
TextBuffer5:
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
; ReadoutText1 - A text buffer of TargetReadout.
ReadoutText1:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; ReadoutText2 - A text buffer of TargetReadout.
ReadoutText2:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; ReadoutText3a - A text buffer of TargetReadout.
ReadoutText3a:
	dc.b	$00
; ReadoutText3 - A text buffer of TargetReadout.
ReadoutText3:
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
; JoystickFlag - Cleared by ReadJoystick.
JoystickFlag:
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
; StickXMoved - Set by ReadStick when the stick moved across.
StickXMoved:
	dc.b	$00
; StickYMoved - Set by ReadStick when the stick moved up or down.
StickYMoved:
	dc.b	$00
; SavedOutsideView - The outside view to go back to (SwitchView sets OutsideView from it); -1
; from the Enter key and the judges.
SavedOutsideView:
	dc.b	$00
; SavedOutsideView2 - OutsideView kept by the judges, put back by StateFlying.
SavedOutsideView2:
	dc.b	$00
; ViewSwitched - Set by SwitchView when the view changes (DrawObjects clears it).
ViewSwitched:
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
; ObjectsDrawnCount - How many objects DrawObjects drew this frame (the radar tests it).
ObjectsDrawnCount:
	dc.b	$00
; GridZRedraw - Frames left to redraw ShowGridZ's readout.
GridZRedraw:
	dc.b	$00
; GridXRedraw - Frames left to redraw ShowGridX's readout.
GridXRedraw:
	dc.b	$00
; WeaponRangeRedraw - Frames left to redraw the weapon's range (ShowWeaponRange).
WeaponRangeRedraw:
	dc.b	$00
; TargetReadoutRedraw - Frames left to redraw the target readout in full (set to 2 by the Y key
; and RedrawInstruments).
TargetReadoutRedraw:
	dc.b	$00
; RadarRangeRedraw - Frames left to redraw the radar's range (ShowRadarRange).
RadarRangeRedraw:
	dc.b	$00
; PanelIndicatorRedraw - Frames left to redraw the indicator drawn by DrawPanelIndicator (set to 2
; by the controls and the engine).
PanelIndicatorRedraw:
	dc.b	$00
; BackslashLampRedraw - Frames left to redraw the lamp of the backslash key's function (it
; flips the player's +$00 bit 11).
BackslashLampRedraw:
	dc.b	$00
; JLampRedraw - Frames left to redraw the lamp of the J key's function.
JLampRedraw:
	dc.b	$00
; Redraw211 - A redraw count set by RedrawInstruments.
Redraw211:
	dc.b	$00
; PanelIndicatorBlink - Frames of blinking for DrawPanelIndicator's indicator (8 from the E key).
PanelIndicatorBlink:
	dc.b	$00
; StoresRedraw - Frames left to redraw the stores display (DrawStores): set to 3 when a weapon
; is fired or selected.
StoresRedraw:
	dc.b	$00
; MissilesLeftRedraw - Frames left to redraw the missiles left (ShowMissilesLeft).
MissilesLeftRedraw:
	dc.b	$00
; PanelLampRedraw - Frames left to redraw DrawAfterburnerLamp's lamp (3 from the A key and
; UpdateObject).
PanelLampRedraw:
	dc.b	$00
; AfterburnerOn - Set (with a beep) while the player's throttle setting (+$6C) is $1200 or more
; and he has not ejected: probably the afterburner, whose lamp on the panel blinks
; (DrawAfterburnerLamp).
AfterburnerOn:
	dc.b	$00
; ModelVariant - Which variant of the model to draw (ShapeSelectVariant; bit 7 flipped by the A
; key).
ModelVariant:
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
; ChaffLeft - Chaff charges left (16 at the start; the C key uses one).
ChaffLeft:
	dc.b	$00
; FlaresLeft - Flares left (16 at the start, ResetPlayerAircraft; the F key uses one).
FlaresLeft:
	dc.b	$00
; ChaffTime - Frames left of the chaff just dropped (30 from the C key), as FlareTime.
ChaffTime:
	dc.b	$00
; FlareTime - Frames left of the flare just dropped (30 from the F key): while it lasts,
; missiles may be drawn off (UpdateObject).
FlareTime:
	dc.b	$00
; ViewPlace - Which cell of its 4 x 4 block the view's cell is (UpdateViewCell; as an object's
; obj_Place): used to pick the
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
; SceneryCellCount - Counts the cells added by BuildSceneryList.
SceneryCellCount:
	dc.b	$00
; MarkersOn - Set while the start points' markers are drawn (the start point's choice, the
; clearance; DrawStartPointMarkers and the map's markers test it).
MarkersOn:
	dc.b	$00
; RedrawFlags - What must be drawn again (set when the view moves into another map cell...).
RedrawFlags:
	dc.b	$00
; SceneryBuilt - Set by UpdateScenery when the scenery lists have been built.
SceneryBuilt:
	dc.b	$00
; DistanceBits - Bits set before DistanceScale (bits 4 and 6 tested by it and the routine
; before it).
DistanceBits:
	dc.b	$00
; ObjectDrawFlags - Flags for the object being drawn (DrawObjects; bit 6 and bit 4 tested by
; DrawModel, DistanceScale and the ground shapes).
ObjectDrawFlags:
	dc.b	$00
; DrawGroupCount - The number of drawing groups (SmallObjectsToList, BuildDrawGroups).
DrawGroupCount:
	dc.b	$00
; DrawGroupIndex - The drawing group being worked on (counts down from DrawGroupCount).
DrawGroupIndex:
	dc.b	$00
; DistanceCount2 - A count kept by DistanceScale and the routine before it.
DistanceCount2:
	dc.b	$00
; DistanceCount3 - A count kept by the routine before DistanceScale.
DistanceCount3:
	dc.b	$00
; WarningLast - The warning chosen last frame (UpdateWarnings).
WarningLast:
	dc.b	$00
; WarningLampCount - Frames for the warning lamp (2, counted down by TargetReadout).
WarningLampCount:
	dc.b	$00
; LampBits - The panel's warning lamps (bits 0-5, UpdateWarnings) and two of the target
; readout's (bits 6-7).
LampBits:
	dc.b	$00
; WarningLampNow - The lamp of the warning now chosen (UpdateWarnings).
WarningLampNow:
	dc.b	$00
; SceneryDetailed - Set while the detailed scenery (SceneryMap2, the cells themselves) is built
; and drawn; clear for the coarse maps.
SceneryDetailed:
	dc.b	$00
; SceneryMapOne - With SceneryDetailed clear: SceneryMap1 rather than SceneryMap0.
SceneryMapOne:
	dc.b	$00
; DistanceFlag - Tested by DistanceScale and the routine before it.
DistanceFlag:
	dc.b	$00
; DistanceFlag237 - Cleared by the routine before DistanceScale.
DistanceFlag237:
	dc.b	$00
; RadarLockState - The radar's lock state (DrawRadarBlips; cleared when the lock is lost).
RadarLockState:
	dc.b	$00
; EjectSoundLength - A sound value CheckEjection sets ($78) for CockpitSounds.
EjectSoundLength:
	dc.b	$00
; EjectSoundPitch - A sound value CheckEjection sets ($3F) for CockpitSounds (DrawSceneryPlain
; also writes it).
EjectSoundPitch:
	dc.b	$00
; HeightBand - How high the view is (0-3, SetHeightBand): decides how much of the ground and
; scenery is drawn (the ground dots, the shadow, the shapes' operations).
HeightBand:
	dc.b	$00
; HeightMid - Set by SetHeightBand while the view is between heights $1C2 and $C80 (x 8);
; tested by the scenery drawing.
HeightMid:
	dc.b	$00
; RadarBlipBits - Bits set by DrawRadarBlips for the kinds of blip drawn this frame.
RadarBlipBits:
	dc.b	$00
; StatusLights - Bits for the panel's status lights (DrawStatusLights): bits 1, 2, 4 and 5.
StatusLights:
	dc.b	$00
; VisualConfirmTimer - Mission F1: counts 30 frames down while an aircraft is held close in the
; view; negative when the confirmation is done.
VisualConfirmTimer:
	dc.b	$00
; GearState - Probably the landing gear's movement (the G key sets it, with a count to $0C;
; EngineAndSpeed and the controls use it).
GearState:
	dc.b	$00
; TextPaused - Set while the text waits (ClearTextPages; PrintText tests it).
TextPaused:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; ShiftDown - Set while the left Shift key is held (HandleKey reads it).
ShiftDown:
	dc.b	$00
; LeftAmigaDown - Set while the left Amiga key is held.
LeftAmigaDown:
	dc.b	$00
; RightAmigaDown - Set while the right Amiga key is held.
RightAmigaDown:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; BlinkCounter - A counter whose low bit makes the start markers and radar blips blink.
BlinkCounter:
	dc.b	$00
; ClockBlink - Counted down by UpdateClock; its low bit makes the radar range blink.
ClockBlink:
	dc.b	$00
; GearSoundCount - The gear's sound counter ($83 from the G key, counted by CockpitSounds).
GearSoundCount:
	dc.b	$00
; TargetReadoutCount - A count for the target readout (5 from the Y key, 1 when the radar finds
; a blip).
TargetReadoutCount:
	dc.b	$00
; RadarBlipTimer - A timer for the radar's blip ($18; the target readout counts it down).
RadarBlipTimer:
	dc.b	$00
; ClockFlag - Set and cleared by TrainingAndGLimit, tested by UpdateClock.
ClockFlag:
	dc.b	$00
; CrashKind - How the aircraft was lost (StateCrashed; 5 tested by StateFlying and the sounds).
CrashKind:
	dc.b	$00
; BeepCount - Frames of the cockpit's beep (3; MenuBeep waits for it).
BeepCount:
	dc.b	$00
; CountermeasureSound - The sound to make for a countermeasure (2 a flare, 1 chaff), played by
; UpdateBullets.
CountermeasureSound:
	dc.b	$00
; BulletHitAircraft - Which aircraft (number + 1) a bullet hit this frame, kept for
; CheckOnTail's reaction; cleared by MoveBullet.
BulletHitAircraft:
	dc.b	$00
; BulletHitAircraft2 - As BulletHitAircraft, for the other kind of hit.
BulletHitAircraft2:
	dc.b	$00
; WarningTicks - The warning beat of this frame (WarningTicker): bits for every 8th, 4th and
; 2nd frame.
WarningTicks:
	dc.b	$00
; ShakeStep - How far through its sequence the view shake is (ShakeView).
ShakeStep:
	dc.b	$00
; WarningTickCount - WarningTicker's counter (8 frames).
WarningTickCount:
	dc.b	$00
; ViewKeyRepeat - Set to -1 by the keypad's view keys (KP1, KP5); SwitchView tests it.
ViewKeyRepeat:
	dc.b	$00
; WarningRepeat - Frames until the warning sound is repeated (UpdateWarnings).
WarningRepeat:
	dc.b	$00
; WarningRepeatTime - The repeat time for the warning now sounding (copied to WarningRepeat).
WarningRepeatTime:
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
; FlashCount - Frames left of the yellow flash (ShowDisplay shows FlashPalette while it
; counts; $28 when hit).
FlashCount:
	dc.b	$00
; NewAircraftReady - Set when a new aircraft is ready to fly (StateFlying, StateNewAircraft;
; FlyAircraft tests it).
NewAircraftReady:
	dc.b	$00
; SeaView - Set (CheckSeaView) when the ground under the horizon is drawn as sea (colour 6)
; instead of land (colour 4).
SeaView:
	dc.b	$00
; ViewTable2Hit - Set by CheckViewTable2 when the view is in its table (used by hunk 28).
ViewTable2Hit:
	dc.b	$00
; WaterDrawn - Set when DrawWaterAreas drew the coarse areas this frame.
WaterDrawn:
	dc.b	$00
; SkyPolygonReady - Set when MakeSkyPolygon left a sky polygon to fill (cleared when there is
; none).
SkyPolygonReady:
	dc.b	$00
; Hunk24Flag - Set by hunk 24's routines (ObjectCollisions, CollideWithList), tested by
; UpdateObject.
Hunk24Flag:
	dc.b	$00
; FadeLevel - The palette's brightness now (0-15; 15 is the full in-flight palette,
; FlightPalette row 0), stepped towards FadeTarget by MouseInterrupt.
FadeLevel:
	dc.b	$00
; FadeTarget - The brightness the palette is fading to (FadeLevel); the states set it and wait
; until FadeLevel reaches it.
FadeTarget:
	dc.b	$00
	dc.b	$00
; MouseIntCount - MouseInterrupt's counter (1, 2...).
MouseIntCount:
	dc.b	$00
; PaletteLoadCount - Frames left in which ShowDisplay loads LivePalette into the display (set
; when it changes).
PaletteLoadCount:
	dc.b	$00
; FlyByCountdown - The fly-by's countdown (5).
FlyByCountdown:
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
; TargetsPlaced - Counts the mission's targets placed (PlaceObjectList, PlaceAhead; cleared
; by SetupMode).
TargetsPlaced:
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
; FlyByPhase - The fly-by's phase (FlyBySetup, CameraShot7, the map's markers).
FlyByPhase:
	dc.b	$00
; EngineSoundRequest - Which engine or cockpit sound to start next ($FE, $FD, $FC, $FA, $FB...:
; set by the flight and the weapons, taken by CockpitSounds; $FF from the view keys).
EngineSoundRequest:
	dc.b	$00
; PlayerFlag281 - Cleared by ResetPlayerFlags.
PlayerFlag281:
	dc.b	$00
; ViewChoice - The view chosen with the keypad (Key_KP1 ... Key_KPDot: 0-9).
ViewChoice:
	dc.b	$00
; PlayerFlag283 - Cleared by ResetPlayerFlags.
PlayerFlag283:
	dc.b	$00
; ShootCue - The head-up display's shoot cue: 1 in range (IN RNG / SHOOT, sound 4), 2 closing
; too fast; 0 none.
ShootCue:
	dc.b	$00
; JToggle - Toggled by the J key: LaunchMissile lets the computer aircraft fire twice as often
; while it is set.
JToggle:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; ObjectScaled - Set while DrawObjects draws an object scaled by distance (ObjectRecord sets
; it; DrawFarScenery1 clears it).
ObjectScaled:
	dc.b	$00
; DrawDetail - The detail to draw the objects with (5, 3 or 1, by the view's turn rates:
; DetailByTurnRate), put in their drawing entries.
DrawDetail:
	dc.b	$00
; ObjectDrawByte - The drawn object's entry's byte +$07 (DrawObjects; its low two bits for
; DrawSceneryPlain).
ObjectDrawByte:
	dc.b	$00
; ClockStep - UpdateClock's step (15 at the start).
ClockStep:
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
; WarningBits4 - Bit 15 tested by UpdateWarnings first (the most urgent warning).
WarningBits4:
	dc.b	$00
	dc.b	$00
; FlightBits - Bits of the flight's state: 1 set by SetHeightBand (tested by ShowGLoad), 8 set
; by FlyAircraft and cleared when the flight starts; MakeSkyPolygon reads the whole word.
FlightBits:
	dc.b	$00
	dc.b	$00
; StatusBits - A word of status bits: 0 a warning or message is showing (StartWarning), 3
; tested by the G key, 6 waiting for the flight to start (set at the ready screen, cleared once
; flying), 8 set by UpdateObject, 10 the view is shaking (ShakeView), 11 set when the aircraft
; is placed; 13-14 cleared on a crash.
StatusBits:
	dc.b	$00
; StatusBitsLow - The low byte of StatusBits (bit 6 tested by JudgeMission and
; ShowHeadingText).
StatusBitsLow:
	dc.b	$00
; WarningBits - Bits for the warnings: 8 set when the flight is ready, 13 a $2000-kind warning
; is sounding (StartWarning), 14 set by FlyAircraft (tested by EngineAndSpeed), 15 cleared by
; StartWarning; 5 and 6 used by UpdateWarnings and UpdateClock.
WarningBits:
	dc.b	$00
	dc.b	$00
; FlightBits4 - Bits used by FlyAircraft (bit 4).
FlightBits4:
	dc.b	$00
	dc.b	$00
; FlightBits2 - More bits of the flight's state: 1 set when ready and by FlyAircraft, 8 tested
; by ShowDisplay, 13 the sky fills the view (DrawSkyAndGround), 14 cleared by EngineAndSpeed.
FlightBits2:
	dc.b	$00
	dc.b	$00
; CrashBits - Bits cleared on a crash (bit 10).
CrashBits:
	dc.b	$00
	dc.b	$00
; WarningBits3 - More warning bits (bit 5 tested and cleared by UpdateWarnings).
WarningBits3:
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
; BlinkPhase - Bits that alternate with time (bit 0, bit 1): the gauges and lamps that blink
; test them.
BlinkPhase:
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
; BestTime - The best of the times TimeSomething measures.
BestTime:
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
; PolygonsDrawn2 - Another count of the polygons filled.
PolygonsDrawn2:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; ControlDelay - FlightControls' delay counter (2).
ControlDelay:
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
; PauseStartTime - When the game was paused (TimeSeconds), so that FlightStartTime can be moved
; on by the pause.
PauseStartTime:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; PausedTotal - The time spent paused in total (StatePaused adds to it).
PausedTotal:
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
; FlightTimeExtra - Time added to the flight's length by FlyAircraft.
FlightTimeExtra:
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
; SkyStepCount1 - Counters stepped by ClearSkyGround each frame (with SkyStepCount2, 3).
SkyStepCount1:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; SkyStepCount2 - See SkyStepCount1.
SkyStepCount2:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; SkyStepCount3 - See SkyStepCount1.
SkyStepCount3:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; LogDiskStatus - 0 the log disk is good, 1 no disk in df0:, 2 not initialised, 3 write
; protected.
LogDiskStatus:
	dc.b	$00
	dc.b	$00
; ViewHeadingSaved - The viewed object's heading (+$68) when the outside view began;
; UpdateCamera turns the camera by its change.
ViewHeadingSaved:
	dc.b	$00
	dc.b	$00
; RecordCount - The flight recording's count (cleared by ResetRecording).
RecordCount:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; ReplayCount - The replay's count (cleared by ResetRecording).
ReplayCount:
	dc.b	$00
	dc.b	$00
; ObjectListPointer - DrawObjects' pointer into the object list.
ObjectListPointer:
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
; SeekerPosY - The y word of SeekerPos.
SeekerPosY:
	dc.b	$00
	dc.b	$00
; GunPipperPos - Where the gun pipper is on the screen (x, y); x <= 0 for none.
GunPipperPos:
	dc.b	$00
	dc.b	$00
; GunPipperPosY - The y word of GunPipperPos.
GunPipperPosY:
	dc.b	$00
	dc.b	$00
; TargetBoxPos - Where the head-up display's target box is (x, y), DrawTargetBox.
TargetBoxPos:
	dc.b	$00
	dc.b	$00
; TargetBoxPosY - The y word of TargetBoxPos.
TargetBoxPosY:
	dc.b	$00
	dc.b	$00
; GLoadValue - The G load (worked out in UpdateAttitude's ComputeGLoad; ShowGLoad prints it).
GLoadValue:
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
; StickValue - ReadStick's last value.
StickValue:
	dc.b	$00
	dc.b	$00
; TextColour - The colour the page is drawn in (the high nibble of the page's colour byte).
TextColour:
	dc.b	$00
	dc.b	$00
; DrawColour - The colour Plot and DrawLine draw in (0-15).
DrawColour:
	dc.b	$00
; PrintColour - The colour PrintNumber and the HUD's digits draw in (bits 0-3, one per plane).
PrintColour:
	dc.b	$00
; ColourBits - The colour being drawn (a copy of DrawColour), shifted right one bit per bit-
; plane as the line and fill routines go through the planes.
ColourBits:
	dc.b	$00
; ColourPlaneBits - The low byte of ColourBits: DrawLine sets or clears each plane by its bit.
ColourPlaneBits:
	dc.b	$00
; MarkerIndex - DrawStartPointMarkers' index (-1 none).
MarkerIndex:
	dc.b	$00
	dc.b	$00
; MarkerX - DrawStartPointMarkers' x.
MarkerX:
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
; FillPlaneStart - The fill's start address in its plane (FillPolygonPlane, ClearFillPlane).
FillPlaneStart:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; FillBoxModulo - The fill's box modulo or second offset for the blitter (FillPolygonPlane).
FillBoxModulo:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; FillBoxStart - The fill's box start offset in the plane (FillPolygonPlane).
FillBoxStart:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; FillBoxSize - The fill's box size for the blitter (BLTSIZE), worked out by FillPolygonPlane.
FillBoxSize:
	dc.b	$00
	dc.b	$00
; FillWork - FillPolygonPlane's work area.
FillWork:
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
; FillBox - The filled polygon's bounding box (x1, y1, x2, y2: FillPolygonPlane).
FillBox:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; FillTop - The fill's top row (FillPolygonPlane).
FillTop:
	dc.b	$00
	dc.b	$00
; FillBottom - The fill's bottom row (FillPolygonPlane, FillPanelPlane).
FillBottom:
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
; ToggleKeys - Keys pressed this frame that switch something (bits: 0 backslash, 1 F, 2 C, 3
; J), for the recording.
ToggleKeys:
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
; HeadingTens - The viewed object's heading in tens of degrees (CompassPosition).
HeadingTens:
	dc.b	$00
	dc.b	$00
; CompassShown - The compass position last drawn (bit 15: draw it again).
CompassShown:
	dc.b	$00
	dc.b	$00
; FuelShownLast - The fuel value last drawn by DrawFuelGauge.
FuelShownLast:
	dc.b	$00
	dc.b	$00
; BulletHitRange - How close a bullet must pass to hit an object ($140 at the start; $800 for
; some, BulletHitTest).
BulletHitRange:
	dc.b	$00
	dc.b	$00
; BulletHitRange2 - A second hit range for bullets ($140).
BulletHitRange2:
	dc.b	$00
	dc.b	$00
; LoopIndex - A loop counter shared by several drawing loops (the far scenery lists,
; DrawObjects, DrawHUDFixed, DrawTargetBox, DrawStartPointMarkers).
LoopIndex:
	dc.b	$00
	dc.b	$00
; FarList0Count - The number of entries in FarSceneryList0 (DrawFarScenery0's loop count).
FarList0Count:
	dc.b	$00
	dc.b	$00
; FarList1Count - The number of entries in FarSceneryList1.
FarList1Count:
	dc.b	$00
	dc.b	$00
; ObjectListCount - The number of entries in the object drawing list (DrawObjects).
ObjectListCount:
	dc.b	$00
	dc.b	$00
; DistanceFactor - The drawn object's distance turned by DistanceCurve (x 256; $7FFE far away).
DistanceFactor:
	dc.b	$00
	dc.b	$00
; CurrentObject - The number of the object being worked on.
CurrentObject:
	dc.b	$00
; DistanceBits385 - Bits DistanceScale adds in.
DistanceBits385:
	dc.b	$00
; CurrentObjectOffset - Its offset in ObjectTable (number << 9).
CurrentObjectOffset:
	dc.b	$00
	dc.b	$00
; BulletHitObject - The object a bullet hit (BulletHitTest), 0 for none.
BulletHitObject:
	dc.b	$00
	dc.b	$00
; FlyByObject - The object the fly-by shows (FlyBySetup).
FlyByObject:
	dc.b	$00
	dc.b	$00
; DistanceScaleBits - Bits worked out with DistanceScale.
DistanceScaleBits:
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
; DrawListEnd - The end of the drawing list built this frame (BulletHitTest goes through it).
DrawListEnd:
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
; DrawGroupList - A list of groups for the drawing order (BuildDrawGroups).
DrawGroupList:
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
; ScaleFactors - The three scale words of ScaleRows ($A8 at the start).
ScaleFactors:
	dc.b	$00
	dc.b	$00
; ScaleFactorZ - The last of ScaleFactors ($FC).
ScaleFactorZ:
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
; ScaledVector - ScaleToLength's result (x, y, z words).
ScaledVector:
	dc.b	$00
	dc.b	$00
; ScaledVectorY - The y word of ScaledVector.
ScaledVectorY:
	dc.b	$00
	dc.b	$00
; ScaledVectorZ - The z word of ScaledVector.
ScaledVectorZ:
	dc.b	$00
	dc.b	$00
; HitPointX - The point of a bullet's hit (x, then HitPointY and HitPointZ), for its effects.
HitPointX:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; HitPointY - The hit's height (see HitPointX).
HitPointY:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; HitPointZ - The hit's z (see HitPointX).
HitPointZ:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; ViewCellLast - The view's cell last frame (UpdateViewCell), to see when it changes.
ViewCellLast:
	dc.b	$00
	dc.b	$00
; OutsideCamZoomLast - The outside camera's last zoom value (SetOutsideCamera).
OutsideCamZoomLast:
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
; ViewCellCheck - The camera's distance into its cell, checked by UpdateViewCell against $A000.
ViewCellCheck:
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
; EyeY - The y long of EyeX.
EyeY:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; EyeZ - The z long of EyeX.
EyeZ:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; OutsideCamPos - The outside camera's position (x, y, z longs; SetOutsideCamera,
; CockpitViewMatrix).
OutsideCamPos:
	dc.b	$00
	dc.b	$00
; ViewPitchAngle - The view's pitch (with ViewHeadingAngle, ViewRollAngle: the angles
; CockpitViewMatrix builds the view from; SkyFillsView tests it).
ViewPitchAngle:
	dc.b	$00
	dc.b	$00
; ViewHeadingLong - The view's heading as a long (SetViewOctant).
ViewHeadingLong:
	dc.b	$00
	dc.b	$00
; ViewHeadingAngle - The view's heading (see ViewPitchAngle).
ViewHeadingAngle:
	dc.b	$00
	dc.b	$00
; ViewHeightLong - The view's height as a long (SetHeightBand).
ViewHeightLong:
	dc.b	$00
	dc.b	$00
; ViewRollAngle - The view's roll (see ViewPitchAngle; MakeSkyPolygon tests it against $3840,
; upside down).
ViewRollAngle:
	dc.b	$00
	dc.b	$00
; OutsideCamPitch - The outside camera's pitch (90 degrees, $1C20, looking straight down for
; the map view); with OutsideCamHeading, from TargetPitch / 00492 when it follows.
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
; FlightScratch - FlyAircraft's working words.
FlightScratch:
	dc.b	$00
	dc.b	$00
; FlightScratch2 - FlyAircraft's working word.
FlightScratch2:
	dc.b	$00
	dc.b	$00
; FlightScratch3 - FlyAircraft's working word.
FlightScratch3:
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
; TurnedZ - TurnToView's z result.
TurnedZ:
	dc.b	$00
	dc.b	$00
; DistanceShift - How far the object being drawn is scaled down by its distance (a shift, from
; DistanceScale): its vertices are shifted right by it so that far objects stay within range.
DistanceShift:
	dc.b	$00
	dc.b	$00
; ObjectDrawWord - The drawn object's entry's word +$08 (DrawObjects, for DrawSceneryPlain).
ObjectDrawWord:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; TargetPitch - The pitch worked out by VectorToAngles (with TargetHeading).
TargetPitch:
	dc.b	$00
	dc.b	$00
; TargetHeading - A heading worked out by VectorToAngles (the direction to something), used by
; BogeyVector, AimObject and UpdateAttitude.
TargetHeading:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; ClipPoint - A point (three words) worked out by the clipping (the line clips, the horizon's
; crossings).
ClipPoint:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; ClipSwitch - Never written (always 0): the clipping routines test it and always take the same
; branch - a switch left from development.
ClipSwitch:
	dc.b	$00
	dc.b	$00
; DivideWhat - Divide's dividend (a long).
DivideWhat:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; DivideBy - Divide's divisor (a word); VectorToAngles and MoveBullet set it.
DivideBy:
	dc.b	$00
	dc.b	$00
; DivideResult - Divide's result.
DivideResult:
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
; WarningSaved - The warning saved by UpdateWarnings (its low byte).
WarningSaved:
	dc.b	$00
	dc.b	$00
; TargetReadoutShown - The target readout's value last drawn (-1 to draw it again).
TargetReadoutShown:
	dc.b	$00
	dc.b	$00
; TimedResult - The result of TimeSomething (shown by ShowDebugNumbers).
TimedResult:
	dc.b	$00
	dc.b	$00
; BestClock - The smallest of a timed value kept by TimeSomething ($7FFF at the start).
BestClock:
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
; PlaceRandom - A random word for placing objects (SetupMode, PlaceObjectList).
PlaceRandom:
	dc.b	$00
; PlaceRandomLow - The low byte of PlaceRandom.
PlaceRandomLow:
	dc.b	$00
; ClockStart - A start time kept by UpdateClock (-1 when not running).
ClockStart:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; StartMicros - Microseconds kept by TimeSomething.
StartMicros:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; ClockLast - UpdateClock's last time read (-1 to start again).
ClockLast:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; ClockMicros - UpdateClock's last microseconds (for its timing).
ClockMicros:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; TimedValue - A time measured by TimeSomething (at most $7FFF).
TimedValue:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; ClockFrames - UpdateClock's frame counter (up to $7D).
ClockFrames:
	dc.b	$00
	dc.b	$00
; ClockSum - UpdateClock's sum of elapsed time.
ClockSum:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; ClockMark - UpdateClock's last mark (compared to ClockSum against 10,000).
ClockMark:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; PlaceWork1 - PlaceObjectList's working words.
PlaceWork1:
	dc.b	$00
	dc.b	$00
; PlaceWork2 - PlaceObjectList's working words.
PlaceWork2:
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
; BogeyWork - BogeyVector's work area.
BogeyWork:
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
; ObjectViewPosYL - The y long of ObjectViewPosL.
ObjectViewPosYL:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; ObjectViewPosZL - The z long of ObjectViewPosL.
ObjectViewPosZL:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; ObjectViewY - The drawn object's height relative to the camera (a long), used by DrawModel as
; its y.
ObjectViewY:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; ObjectDistance - The distance of the object being drawn (VectorLength's result), for the
; level of detail.
ObjectDistance:
	dc.b	$00
	dc.b	$00
; ObjectDistanceSound - A distance kept by DrawObjects for the cockpit sounds ($7FFF when
; none).
ObjectDistanceSound:
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
; FlightSoundBits - Sound request bits from FlyAircraft for CockpitSounds (bits 0, 1, 3).
FlightSoundBits:
	dc.b	$00
; CockpitSoundBits - Requests for the cockpit's sounds, one bit each, set by the warnings and
; the controls and played by CockpitSounds.
CockpitSoundBits:
	dc.b	$00
; GKeyValue - A long read by the G key (cleared at the start).
GKeyValue:
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
; ControlScratch2 - FlightControls' working word.
ControlScratch2:
	dc.b	$00
	dc.b	$00
; ControlScratch3 - FlightControls' working word.
ControlScratch3:
	dc.b	$00
	dc.b	$00
; ControlScratch - FlightControls' working word.
ControlScratch:
	dc.b	$00
	dc.b	$00
; AngleDistance - VectorToAngles' distance (a long), used by AngleBySize.
AngleDistance:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; AngleScratch - VectorToAngles' working word.
AngleScratch:
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
; WarningRepeatDefault - The default repeat time for warnings.
WarningRepeatDefault:
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
; AngleWork - NormaliseAngles' work area (with the longs after it).
AngleWork:
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
; AngleWork2 - NormaliseAngles' work area.
AngleWork2:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; AngleWork4 - NormaliseAngles' work long.
AngleWork4:
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
; AngleWork6 - NormaliseAngles' work long.
AngleWork6:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; AngleWork3 - NormaliseAngles' work long.
AngleWork3:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; AngleWork5 - NormaliseAngles' work long.
AngleWork5:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; AngleWork7 - NormaliseAngles' work long.
AngleWork7:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; SceneryMatrix - A matrix for turning the scenery's vertices (DrawSceneryPlain,
; TransformMoreVertices).
SceneryMatrix:
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
; ViewMatrix01 - The view matrix's second word (ViewMatrix + 2), where DrawGroundDots and hunk
; 28 start reading it.
ViewMatrix01:
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
; PanelMatrixHeading - A matrix for the viewed object's heading (CockpitViewMatrix; used by
; SetOutsideCamera and AddRadarObject).
PanelMatrixHeading:
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
; PanelVector - A vector turned by TurnByPanelMatrix (or CameraHeadingMatrix's matrix).
PanelVector:
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
; ObjectMatrix - The drawn object's matrix combined with the view (CockpitViewMatrix, the
; scenery's transforms).
ObjectMatrix:
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
; CameraCellOffset - Minus the camera's position within its cell (x, y, z longs; SetCameraAt,
; the M key).
CameraCellOffset:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; CameraCellOffsetY - The y long of CameraCellOffset.
CameraCellOffsetY:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; CameraCellOffsetZ - The z long of CameraCellOffset.
CameraCellOffsetZ:
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
; CameraVelocity - The camera's movement (x, y, z longs; cleared for the map view and by
; ResetGame).
CameraVelocity:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; CameraVelocityY - The y long of CameraVelocity.
CameraVelocityY:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; CameraVelocityZ - The z long of CameraVelocity.
CameraVelocityZ:
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
; Bullets - The gun's bullets: 20 Bullet records (64 bytes each, below).
; Bullet - a record of Bullets (emits no bytes: the offsets).
                rsreset
blt_X                   rs.l    1               ; the position in its map cell (x and z wrap at
blt_Y                   rs.l    1               ; $400000 into the next cell)
blt_Z                   rs.l    1
blt_VelX                rs.l    1               ; its velocity, per frame (BulletHitTest's step:
blt_VelY                rs.l    1               ; these / 256)
blt_VelZ                rs.l    1
blt_DriftX              rs.l    1               ; an eighth of the velocity (set with it by
blt_DriftY              rs.l    1               ; BulletDamageAt)
blt_DriftZ              rs.l    1
                        rs.w    1               ; (cleared with them)
blt_Flags               rs.w    1               ; bit 0 in flight; 1 hit the ground, 4 hit
                                                ; something, $100 moves with the aircraft, $1000
                                                ; / $2000 how it is drawn at the end
blt_Timer               rs.w    1               ; frames left
                        rs.w    2
blt_Owner               rs.w    1               ; the object that fired it
blt_CellX               rs.w    1               ; its map cell (x, z)
blt_CellZ               rs.w    1
                        rs.b    $40-$34
BULLET_SIZE             rs.b    0
Bullets:
	dcb.b	1280,$00
; BulletTestFrom - BulletHitTest's start point (x, y, z words).
BulletTestFrom:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; BulletTestPos - BulletHitTest's bullet position (x, y, z words).
BulletTestPos:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; BulletTestKind - The kind of test BulletTestPoint makes (0, 1 or more).
BulletTestKind:
	dc.b	$00
	dc.b	$00
; BulletTestRange - BulletHitTest's range word.
BulletTestRange:
	dc.b	$00
	dc.b	$00
; PolygonsDrawn - Counts the polygons filled this frame (ClipPolygonEdge4; cleared each frame).
PolygonsDrawn:
	dc.b	$00
	dc.b	$00
; Object - an ObjectTable record (512 bytes; emits no bytes: the offsets). An object's
; offset in ObjectTable is its number << 9.
                rsreset
obj_Flags               rs.w    1               ; flags ($2000 throttle at full, $0008 probably the
                                                ; afterburner, $0400 spent...); low byte: bit 6 it
                                                ; exists, bit 4 in a cell being drawn
obj_Flags2              rs.w    1               ; more flags (low byte bit 7...)
obj_Bits                rs.b    1               ; bits: 3 on the ground; 6 or 7 over a ship's deck
                                                ; (obj_DeckHeight)
obj_State               rs.b    1               ; the computer pilot's state (1 pull up, 8 route...)
obj_CellX               rs.w    1               ; its map cell
obj_CellZ               rs.w    1
obj_SubCell             rs.b    1               ; where in the cell
obj_Place               rs.b    1               ; which cell of its 4 x 4 block it is in: (3 - x & 3) +
                                                ; 4 x (3 - z & 3), as ViewPlace for the view
obj_X8                  rs.w    1               ; the position in the cell / 256 (x, z), and its
                                                ; height (long)
obj_Z8                  rs.w    1
obj_Y8                  rs.l    1
obj_X                   rs.l    1               ; the position (low 22 bits of x and z: inside the
                                                ; cell; y is the height, up)
obj_Y                   rs.l    1
obj_Z                   rs.l    1
obj_Status              rs.b    1               ; what has happened to it: bit 1 destroyed, 2
                                                ; damaged, 6 signature confirmed, 7 hit by the
                                                ; player
obj_Status2             rs.b    1               ; bit 0: landed (the flight time counted;
                                                ; PlayerParked)
obj_SinRoll             rs.w    1               ; the sine of the roll (2.14, ComputeGLoad; the stall check
                                                ; uses it)
obj_CosRoll             rs.w    1               ; the cosine of the roll (2.14, ComputeGLoad)
obj_Response            rs.w    1               ; responsiveness (at most 15; a missile: $14 at
                                                ; launch)
obj_StickPitch          rs.b    1               ; the pitch stick (-20..20)
obj_Rudder              rs.b    1               ; the rudder (-20..20)
obj_StickRoll           rs.b    1               ; the roll stick (-60..60)
obj_Throttle            rs.b    1               ; the throttle (0-120)
obj_DestCellX           rs.w    1               ; the computer pilot's destination: its map cell,
obj_DestCellZ           rs.w    1
obj_DestX               rs.w    1               ; where in it,
obj_DestZ               rs.w    1
obj_DestY               rs.l    1               ; and its height
obj_Target              rs.b    1               ; its target ($80 + an object; copied to its
                                                ; missiles)
obj_ThrottleStep        rs.b    1               ; low nibble: the throttle's step
obj_Route               rs.b    1               ; the route (Routes)
                        rs.b    1
obj_Hits                rs.b    1               ; cannon hits: low nibble the count (the third destroys it),
                                                ; high nibble BulletHitStep's
obj_FlameLength         rs.b    1               ; the flame's length (0-4: grows while it burns,
                                                ; Flags2 bit 4)
obj_VelX                rs.l    1               ; its velocity
obj_VelY                rs.l    1
obj_VelZ                rs.l    1
obj_Range               rs.w    1               ; the range to its target (the locked target, for
                                                ; the player)
obj_Timer               rs.w    1               ; a timer (a missile: $96 / $C8 at launch)
obj_DeckHeight          rs.w    1               ; the height of the deck it is over (a ship's, from its model:
                                                ; ObjectCollisions, with obj_Bits bit 6 or 7; / 256)
obj_AimRate1            rs.w    1               ; target rotation rates (computer aircraft)
obj_AimRate2            rs.w    1
obj_AimRate3            rs.w    1
obj_PitchRate           rs.w    1               ; rotation rates, which the matrix turns by each
                                                ; frame: the pitch stick drives this one,
obj_YawRate             rs.w    1               ; the rudder this one,
obj_RollRate            rs.w    1               ; the roll stick this one
                        rs.b    1
obj_Zone                rs.b    1               ; its zone (Zones, for KeepInZone)
obj_Group               rs.b    1               ; objects with the same don't collide (a missile:
                                                ; its launcher's number)
obj_Missiles            rs.b    1               ; missiles left: low nibble AMRAAMs, high nibble
                                                ; Sidewinders
obj_Rounds              rs.w    1               ; cannon rounds left
obj_Type                rs.b    1               ; its type (0 Sidewinder, 1 AMRAAM; $1x an aircraft:
                                                ; $10 F-16, $11 F/A-18; $3x a parachute or pod...)
obj_Weapon              rs.b    1               ; the selected weapon (high nibble: $10 gun, $20
                                                ; Sidewinder, $30 AMRAAM)
obj_Controls2           rs.b    1               ; more control bits (bits 5 and 6: its target is in
                                                ; its forward cone)
obj_Controls            rs.b    1               ; control bits: $80/$40 rudder, $20/$10 pitch,
                                                ; $08/$04 roll, $02/$01 throttle
obj_Pitch               rs.w    1               ; its attitude (1/80 degree)
obj_Heading             rs.w    1
obj_Roll                rs.w    1
obj_Speed               rs.w    1               ; its speed
obj_SpeedFlown          rs.w    1               ; the speed flown (obj_Speed + obj_ClimbSpeed)
obj_MapSnap             rs.b    1               ; the map mark's last place (the low nibbles of x
                                                ; and y)
obj_MapDir              rs.b    1               ; the map mark's direction (the heading in 16ths;
                                                ; -1: not yet)
obj_Fuel                rs.l    1               ; fuel (6,400,000 at the start)
obj_Lift                rs.w    1               ; lift / sink (vertical velocity)
obj_ClimbSpeed          rs.w    1               ; speed lost climbing / gained diving
                                                ; (ClimbDivePhysics)
obj_Attack              rs.b    1               ; 3 attacking, 4 attacking close (obj_Range <
                                                ; $1E00), 5 broken off (sent on its route)
obj_ShapeFlag           rs.b    1               ; the shape drawn's flag byte (DrawSceneryPlain;
                                                ; negative: none)
obj_Ejection            rs.b    1               ; the ejection: low nibble its step, bit 7
                                                ; (SetObjectBit7C)
obj_Scale               rs.b    1               ; low nibble: a scale shift
obj_PilotTimer          rs.w    1               ; the computer pilot's timer ($1400 for a computer
                                                ; aircraft)
obj_Matrix              rs.w    9               ; a 3 x 3 rotation matrix from the angles (2.14,
                                                ; rows of 3 words)
obj_Inverse             rs.w    9               ; the opposite rotation, from the negated angles
                                                ; (its third column: the nose)
obj_Vertices            rs.w    174             ; its own copy of its model's vertices
OBJECT_SIZE             rs.b    0
; ObjectTable - The 16 objects (aircraft, missiles, ships...; the player's aircraft is record 0):
; Object records (above) of 512 bytes, $00B54-$02B53 (an object's offset = its number << 9).
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
; PlayerY - The player's height (ObjectTable+$18; positive is up).
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
; PlayerThrottle - The player's throttle (ObjectTable +$2B, 0-120).
PlayerThrottle:
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
; PlayerPitchRate - The player's pitch rate (+$56).
PlayerPitchRate:
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
; PlayerRounds - The player's cannon rounds left (+$60, 500 at the start).
PlayerRounds:
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
; PlayerPitch - The player's pitch (+$66).
PlayerPitch:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; PlayerSpeed - The player's speed setting (+$6C).
PlayerSpeed:
	dc.b	$00
	dc.b	$00
; PlayerSpeedFlown - The player's speed flown (+$6E).
PlayerSpeedFlown:
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
; PlayerEjection - The player's ejection state (+$7C: the low nibble the step, bits 4-6 more).
PlayerEjection:
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
