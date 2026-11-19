# How F/A-18 Interceptor works

What the disassembly has shown so far about how the game is organised and what it does, from
start-up to a frame of flight. It grows as more of the code is worked out; **open questions** are
listed at the end. Names in `code` are labels in the source (`../f18_main.s`, `../src/`).
`CODE.md` lists the hunks; `../disk/FILES.md` the files and their formats.

## The program

The game is one AmigaDOS executable, `F-18 Interceptor`, started from its Workbench icon (the
disk boots to Workbench). It was written mostly in C, compiled with Lattice C and linked with the
Lattice library and amiga.lib, with some modules in assembly: the drawing primitives, the blitter
copies, the sound driver, the 3D maths. Each object module became up to three hunks (code, data,
BSS), 185 in all.

It is a system-friendly program at start-up and a hardware-banging one once it runs:

* It uses the OS for memory, files, the display (a View and ViewPort of its own, made with
  `MakeVPort` / `MrgCop` and shown with `LoadView`), the keyboard, joystick and timer devices,
  and audio.device (only to allocate the four channels).
* Then it takes over: it closes the Workbench screen to free chip RAM, owns the blitter while a
  frame is drawn, drives the blitter and the audio hardware directly, installs its own audio
  interrupt handlers and two vertical blank interrupt servers (the mouse and the sound), and
  raises its task's priority.

Two programming styles show in the code. The C modules use stack frames (`link a6`), arguments on
the stack and results in `d0`, and call the library for 32-bit multiply / divide (`CXM33`,
`CXD33`) and for floating point. The assembly modules pass values in registers and keep their
state in fixed global variables (hunk 71), often passing data through them (`BCDIn` /
`BCDOut`, `dat_071_0049C` / `004A0` for `Divide`...).

## Start-up

`_start` (Lattice's `c.o`) opens dos.library, handles the Workbench message and calls `main`:

1. graphics.library; the sound (`InitSound`: audio.device, the game's audio interrupts).
2. The title picture, `df0:pix/splsh` (`LoadPicture`, EA's IFF reader).
3. `CloseWorkbenchScreen`; the sound samples: `text201`, and the title music's instruments
   (`LoadMusicSamples`) only if more than 200,000 bytes of chip RAM are free.
4. The display (`InitDisplay`: 320 x 200, a 5-plane BitMap for the display and a 4-plane one),
   then the title picture's checksum (`ChecksumPlanes`, `TitleChecksum`): only for the
   original picture (`$C560`) does the title sequence play.
5. The instrument panel and front pictures (`pix/inst5`, `pix/frnt5`), and their checksums
   (`PanelChecksum`, `FrontChecksum`).
6. `RunGame`: frees the title pictures, allocates the display buffers, opens the input
   (`InitInput`: timer, keyboard, joystick, the mouse interrupt, the input handler; raises the
   priority), reads the flight log (`LoadConfig`), allocates the flight recording's buffers
   from free fast / public memory and loads the demo flight (`LoadDemoRecording`), fades the
   palette in, sets the first state (`StateStartup`) and enters the main loop.

## The main loop and the frame

`RunGame` never returns. Each pass is one frame:

```
SelectDrawBuffer   point the drawing at the buffer not being shown
OwnBlitter
GameFrame          everything for this frame
DisownBlitter
ShowDisplay        wait for the bottom of the ViewPort, LoadView the buffer just drawn
```

The display is double-buffered: two copper lists (`MakeDisplay`), the drawing going to one
buffer (`DrawPlanes`) while the other is shown. Anything drawn once has to be drawn into both,
which is why the instruments have redraw counters set to 3 (`RedrawInstruments`).

`GameFrame` runs the frame's parts in a fixed order, setting `FrameStage` before each one (if
the game stopped, it said where). `FrameCount` counts frames; some parts run only every 2nd, 4th,
8th, 16th or 32nd frame, and the objects' slower work is spread out by object number. The
stages (`?` = not worked out yet):

| Stage | Routines | What |
|---|---|---|
| (first) | `ReadControls`, `RunGameState`, `sub_000_03C94` | the joystick, buttons and keys; **the game's state** (below) and the flight log's time |
| `$08` | `sub_000_041E8` | ? (the view, the gun sound, the instruments) |
| `$10` | `UpdateViewCell` (which calls `UpdateAllObjects`) | **the objects**: every object's update - computer pilots, the player's controls or the replay, engine, attitude, flight, missiles; the flight recording - and which map cell the view is in |
| `$20` | `SetupCamera`, `sub_008_00286`, `sub_020_00738`, `sub_000_043F2`, `sub_008_00598` | the camera, and ? (the view's position and scenery) |
| `$60` | `sub_020_007EA`, `sub_020_00AB4`, `sub_033_00010` | ? (the 3D view's outline) |
| `$68` | `sub_028_00B9C` | ? |
| `$70` | `sub_033_003CE` | ? (3D: through hunk 35) |
| `$78`, `$80` | `sub_008_0084C`, `sub_008_0085E` | ? (the scenery list) |
| `$90` | `sub_025_00000` | ? (points: the ground or the sky) |
| `$A0`-`$B0` | `sub_023_00000`, `DrawObjects`, `sub_000_072DC` | **the 3D view's objects and scenery** |
| `$C0` | `sub_000_03D4C`, `CockpitSounds` | ? (uses the custom chips), the cockpit's sounds |
| `$D0` | `DrawPanel`, `sub_037_002F6`, `DrawRadar`, `sub_040_00064`, `DrawStatusLights`, `sub_037_008B8`, hunk 39 (several, some every 4th / 8th / 16th frame) | **the cockpit**: the instrument panel and the instruments |
| `$1A0` | `sub_036_00BAA`, hunks 37 and 39 | ? (the head-up display) |
| `$1D0`, `$1D4` | hunk 39, `sub_000_04392`, `sub_029_001A4`, `sub_020_00562` (the time: `ReadTime`), and every 8 / 16 / 32 frames more | ? (the outside views; the clock) |
| `$210`-`$220` | `sub_036_0000C`, `sub_039_00276`, `PrintText` (the flight log page, `SaveConfig`) | the menus and pages |

## Input

* **Keyboard**: keyboard.device with one read request kept queued (`ReadKeyEvent`). `GetKey`
  returns raw key codes, releases with `$80` added; `HandleKey` (hunk 5) is the game's command
  table, choosing by the game's modes; each `Key_` label is named after its key.
* **Joystick** (port 2): gameport.device as an absolute joystick reports the fire button
  (`ReadJoystick`); the stick's directions are read straight from `JOY1DAT` (`ReadStick`) and go
  to the same routines as the cursor keys (`StickUp`, `StickLeft`...).
* **Mouse** (port 1): a vertical blank interrupt (`MouseInterrupt`) adds the change in
  `JOY0DAT`'s counters to `MouseX` / `MouseY`, within limits (`SetMouseLimits`); the buttons are
  read from the CIA and `POTGOR` (`ReadButtons`).

The stick and keys set three bytes - `PitchInput`, `RollInput`, `CommaPeriodInput` - which are
packed into the player's **control bits** (the object record's `+$65`: `$20` / `$10` pitch, `$08` /
`$04` roll, `$80` / `$40` the rudder - the `,` and `.` keys - and `$02` / `$01` the throttle down /
up). Every aircraft is flown through its control bits:
the player's come from the stick, the computer pilots set theirs (hunk 30), and a replay reads
them back from the recording.

The fire button (`FirePressed`): with the gun selected it turns the gun on while held; with a
missile selected it asks for a launch (`LaunchRequest`).

## The world

### Objects

Everything that moves is an **object**: `ObjectTable` holds 16 records of 512 bytes; record 0 is
the player's F/A-18 (named `Player...` where the code reaches its fields directly), the others are
aircraft, missiles and other objects. `SmallObjects` are 16 more of 32 bytes. An object's
record holds (see the header above `ObjectTable` for all that is known):

* whether it exists (`+$01` bit 6), its type (`+$62`, below), its state (`+$05`) and a timer
  (`+$4C`);
* what has happened to it (`+$20`): bit 1 destroyed, bit 6 its signature confirmed (seen up
  close, so the radar's readout names it), bit 7 hit by the player;
* its position: a map cell (`+$06` X, `+$08` Z) and a 32-bit position (`+$14` X, `+$18` Y, `+$1C` Z)
  whose low 22 bits are the position inside the cell; Y is height, negative upwards;
* its velocity (`+$3E`, `+$42`, `+$46`) and speed (`+$6C`, `+$6E`);
* its attitude: pitch, heading, roll (`+$66`, `+$68`, `+$6A`) and two rotation matrices made from
  them (`+$80`, and `+$92` from the negated angles, whose third column is the nose's direction);
* its weapons: the selected weapon (`+$63`) and missiles left (`+$5F`: 4 AMRAAMs and 2 Sidewinders
  for the player at the start);
* its control bits (`+$64`, `+$65`) and the throttle (probably `+$2B`).

The types (`+$62`) seen so far:

| Type | Object |
|---|---|
| `$00`, `$01` | Sidewinder, AMRAAM missiles |
| `$10` | F-16 (the player's, if chosen; the unknown aircraft of mission F1) |
| `$11` | F/A-18 (the player's) |
| `$12`, `$13` | MiG-29, MiG-25 |
| `$14` | Air Force One |
| `$15` | the cruise missile |
| `$16`, `$17` | 707, 767 airliners |
| `$30` | the ejected pilot under his parachute |

The target readout's names (hunk 39) give most of these; the player's type comes from the
aircraft chosen (`PlayerAircraftType`).

### The map

The world is divided into **map cells**: an object's cell numbers (X, Z) plus 22 bits of
position inside the cell. `UpdateViewCell` works out the cell (and sub-cell) the view is in and
asks for the scenery to be redrawn when it changes (`RedrawFlags`); `FindObjectsInCell` finds
the objects in a cell. Distances to objects are taken relative to the viewer's cell, so the
32-bit coordinates never have to cover the whole world at once.

### Units

* Angles: 1/80 degree, a full turn = `$7080` (28,800). Shifted down 3 bits they are tenths of a
  degree, the index into `SineTable` (a quarter wave, 901 entries).
* Sines, cosines and matrix elements: 2.14 fixed point (16384 = 1); products are shifted back
  with `asr.l #14`.
* Speeds: a missile tops out at `$4200` (`+$6C`); in what units is not known yet.

## Flight

Each frame `UpdateObject` (hunk 22) does one object's work:

* its destroyed / crashed states (flags in `+$00`, the timer `+$4C`);
* the **computer pilot** for an aircraft other than the player (`ComputerPilot`, hunk 30): a
  state machine - the aircraft's state (`+$05`) picks a handler (`PilotStates`) - that steers
  towards a destination (a map cell, a position in it and a height: `+$2C`-`+$34`), reading the
  aircraft's matrices to see where it lies in the aircraft's own axes, and flies by setting the
  aircraft's control bits like a player would. In some missions an aircraft follows a route of
  waypoints (`Routes`, hunk 27); one sinking too near the ground for its speed pulls up first;
* for the player, `PlayerFrameControls`: the control bits from the stick, or from the recording
  in a replay; and the warnings from the attitude and sink rate;
* `UpdateAttitude` (hunk 32): an aircraft (type `$1x`) turns by **rotation rates**: its matrix
  (`+$80`) is turned each frame by its three rates (`+$56`, `+$58`, `+$5A`; `sub_032_00AD8`). The
  player's rates come from `FlightControls`: the stick deflection (`+$28`-`+$2A`, which builds
  up from the control bits) is looked up in a response table (`ControlResponse`, hunk 60) - so
  the stick sets how fast the aircraft rolls and pitches, not its angles. A computer aircraft
  has target rates (`+$50`-`+$54`) that its actual rates move about three quarters of the way to
  each frame, divided by its responsiveness (`+$26`). The roll eases back towards level (up to
  `$50` a frame) and, when `dat_071_00154` is set, a stall check compares a minimum speed worked
  out from the pitch (and `+$22`) with the speed. Type `$3x` objects instead keep their pitch and
  heading along their direction of flight (`VectorToAngles`) while their roll eases level.
  `SetAttitude` makes the matrices from the angles;
* `FlyAircraft` (hunk 0): the velocity moves towards the nose's direction at the aircraft's
  speed (`ScaleToLength`, `EaseVelocity`), so the aircraft goes where it points but with
  inertia; `+$76` is added vertically;
* the position moves by the velocity.

### The controls, the engine and the speed

* **Stick deflection** builds up from the control bits each frame (`PlayerFrameControls`):
  pitch (`+$28`) by 1 a frame to +-20, rudder (`+$29`) by 1 to +-20, roll (`+$2A`) by 3 to +-60;
  reversing starts again from +-1, and letting go returns it to 0 at once.
* **Throttle** (`+$2B`, 0-120; `EngineAndSpeed`): while the throttle-up bit is held the step
  grows (to 4 a frame); at 120 a held throttle-up sets one flag and a further one another,
  probably the afterburner; throttle-down takes them off. The player's mouse is read here too.
* **Speed**: `+$6C` moves towards what the throttle gives; the speed flown is `+$6E` = `+$6C` +
  `+$78`. With `FlightPhysics` set, `ClimbDivePhysics` makes `+$78` the speed lost climbing and
  gained diving (a table by speed times the sine of the pitch), and `+$76` the lift or sink (a
  table by speed), which `FlyAircraft` adds to the vertical velocity; the stall check also runs
  only then. Without it the aircraft flies simply where it points.

**Fuel** is the record's `+$72` (`PlayerFuel`: 6,400,000 at the start); `FlightControls` sets
the low-fuel warnings at 768,000 and 460,800 (`WarningFlags`) and out-of-fuel at 0. What sets
the speed from the throttle, and how the fuel is used, are not worked out yet.

### Weapons

* The **gun**: on while the fire button is held with the gun selected (`GunFlags`).
* **Missiles**: `LaunchMissile` makes a new object as a copy of the launcher's record, of type 0
  (AIM-9L Sidewinder) or 1 (AIM-120 AMRAAM), at its pylon (`PylonOffsets`, turned by the
  launcher's orientation), with the launcher's velocity plus a push along its nose. Then
  `UpdateMissile` flies it: while the motor burns (its timer at 50 or more) the speed rises by
  `$1E0` a frame up to `$4200`, then it slows towards `$3000`; at 12 it is spent.
* Computer aircraft fire too, every 8, 6 or 4 frames at the most by the **difficulty** (the
  flight log's `+$02`).
* Falling objects: their velocity is damped horizontally and pulled down vertically (`$3C0`, then
  `$3C`, a frame).

## The cockpit

The bottom of the screen is the instrument panel (`pix/inst5`, drawn by `DrawPanel`); the
instruments are drawn over it each frame (stage `$D0`), several only every few frames:

* **The radar scope** (`DrawRadar`, hunk 38): every object near the player is turned into the
  aircraft's own axes (`AddRadarObject` into `RadarList`) and plotted as a blip if it is in the
  scope's range (about `$1B` x `$2000` either side, `$16` ahead, `$10` behind). Each display
  buffer keeps the list of its blips (`RadarBlips`) so that they can be erased next time. An
  aircraft that comes close (`$10000`) has its **signature confirmed** (`+$20` bit 6) - which is
  what mission F1, Visual Confirmation, asks for.
* **The target readout** (`TargetReadout`, hunk 39): for the locked target (`LockedTarget`) its
  type - MIG-29, MIG-25, AF-1, 707, 767, F-16, CRUISE, or NO SIG while its signature is
  unconfirmed - and in turn its altitude, heading and speed.
* **The status lights** beside the radar (`DrawStatusLights`, `StatusLights`).
* The numbers of the other instruments and the head-up display's texts (hunk 39, "GUN RNG
  SHOOT"...) and hunk 40 are not worked out yet.

The menus, briefings and typed input use the same screen: **the text printer** (`PrintText`)
types the queued pages a character at a time with a click, drawing each character into the
bit-planes with the CPU (`DrawCharPlane`, the `Font` in hunk 61, the columns in `TextColumns`).
A page starts with its position, flags and colour (the high nibble the colour, the low the
delay between characters); its lines end with 0 and the page with -1. For the callsign and the
security code it reads the keys from `KeyBuffer` instead (a ring of the last 10 key codes filled
by `HandleKey`, turned into letters by `KeyToAscii`).

## The 3D view

* The **camera** (`SetupCamera`) is the cockpit, or in the outside views a point near the viewed
  object (`SetOutsideCamera`); `CameraX`, `CameraY`, `CameraZ` and the viewer's cell are what
  everything is drawn relative to.
* `DrawObjects` (hunk 8) goes through the visible objects (`VisibleObjects`): each one's
  distance (the largest of |dx|, |dy|, |dz|) picks a scale (`DistanceScale`), its coordinates
  are shifted down by it, and its draw routine from `ObjectDrawTable` (hunk 16) draws its model
  (hunks 41-58, 69, 70). Then the scenery (`SceneryList`, 24-byte entries), then the small
  objects.
* The 3D pipeline (hunks 13-15, 19, 34, 35; its workspace in hunk 72) transforms, projects and
  clips; the view is 320 x 180 (`PutCornerBR` = (319, 179)), its outline built by `PutEdge`.
* The drawing: points (`Plot` and its variants: one pixel, 2 pixels, big points, in the 16
  colours of 4 planes) and lines (`DrawLine`, the blitter's line mode).
* The cockpit: the instrument panel picture (`pix/inst5`, 320 x 55) is blitted to rows 145-199
  (`DrawPanel`); the head-up display and instruments are drawn over the view (hunks 38-40); the
  messages come from hunk 59 (`Messages`, 54 of 28 bytes):
  the warnings (STALL, the fuel levels, CRASH IMMINENT - PULL UP, AT MAXIMUM ALTITUDE, COLLISION
  PROXIMITY, damage, TURBINE FAILURE), the threat alerts (ENEMY IN VICINITY, IR / RH MISSILE,
  CRUISE MISSILE), the countermeasures (flares, chaff), the arrestor hook, EJECT, TARGET
  DESTROYED, and the training manoeuvres (AILERON ROLL, BARREL ROLL, INSIDE LOOP, BREAK TURN,
  SPLIT-S, VERTICAL HALF-LOOP, INVERTED FLIGHT, each started with the trigger).

## The screens: the game's states

Everything outside the flight itself - the title, the menus, the briefings, the security check,
the start of a flight, the debriefing - is a **state machine**. `GameState` holds the routine of
the current state (the `State` labels in hunk 0); `RunGameState` calls it once a frame, and a
state moves on by storing the next one. Two things pace the states:

* `StateTimer` is counted down every frame; a state that sets it waits until it goes negative.
* The **text pages**. A screen's text is a queue of page numbers (`TextPages`, ended by 0); the
  text printer in hunk 39 types the pages out one after another, and sets bit 7 of `TextStatus`
  when the queue is done (or waits for typed input: the callsign, the security code). States wait
  on it, and most let a key (`KeyPressed`) skip ahead. `TextPageTable` (hunk 64) gives each page's
  text; `SetTextPage` picks a page from a mode's own list (`TextGroups`), which is how each
  mission gets its briefing and result texts.

`RunGameState` also acts on `QuitRequest`: `$FF` (Shift+Esc) goes back to the main menu, 1 (Esc)
restarts the selection, 2 (set when the pilot's parachute lands, hunk 17) the bailout screen, 3
(set by hunk 18 when the mission's targets are done) the debriefing. And while a mission is
flown it adds the time to the flight log.

### From start-up to the menu

```
StateStartup        the pictures' checksums --(wrong)--> StateChecksumError -> StateChecksumLock (stops)
StateTitle          the credits page; any key ->
StateTitleWait      music on, LoadConfig
StateLogDisk        no log disk / not initialised / write-protected: says so and waits
StateWelcome        first tour: "enter your callsign" (StateCallsign); else "welcome back" + callsign
StateNewTour        counts a tour; the first time "you are now officially ..."
StateMainMenu       the menu (below)
StateMenuChoice     waits for a menu key (HandleKey sets GameMode)
```

The credits page (hunk 64): F/A-18 Interceptor, (c) 1988 Intellisoft; designed and programmed
by Bob Dinnerman; design assistance Moses Ma; sounds and music by Dave Warhol; published by
Electronic Arts, San Mateo.

### The main menu and the modes

The menu key sets `GameMode`, which then decides almost everything about the flight:

| Key | Menu line | `GameMode` | Next |
|---|---|---|---|
| 1 | DEMO | `$7F` (only if a recording is loaded) | `StateDemoStart`: replays the recorded flight - mission F1 at difficulty 0 (`DemoSetup`, `RecordMode` 3) - and starts it again when it ends |
| 2 | FREE FLIGHT, NO ENEMY CONFRONTATION | 1 | security check, the overview, "select your free flight starting location" (`StartPoints`), then the aircraft (F/A-18 or F-16) unless starting on the carrier; 5 aircraft |
| 3 | TRAINING: DEMO OF MANEUVERS | 2 | security check, "basic flight maneuvers part 1"; you watch the instructor's aircraft (object 4) |
| 4 | TRAINING: PRACTICE MANEUVERS | `$7D` | security check, "part 2", straight into the cockpit |
| 5 | QUALIFICATION: REQUIRED FOR MISSIONS | 9 | security check, the carrier landing briefing; landing sets the log's "qualified" word |
| 6 | SELECTABLE MISSIONS | -1 | `StateMissionList`: the missions the log allows, chosen with F1-F6 |
| 7 | NEXT ACTIVE ADVANCED MISSION | the one after the log's last (3-8) | needs the qualification |
| 8 | YOUR CURRENT FLIGHT LOG STATISTICS | -2 | `StateFlightLogPage`: 1 saves the log to disk, Shift+2 clears it |
| F1-F6 | (the missions) | 3-8 | F1 always; F*n* once F*n*-1 has been completed |
| Esc / Shift+Esc | | | restart the selection / back to the main menu |

`StateFlightSetup` then sets up the world for the mode (hunk 26, `sub_026_00002`, from the mode's
table in hunk 27), gives the player 3 aircraft (`AircraftLeft`) and starts the chain for the mode.

### A mission

```
StateBriefingFade .. StateBriefing   fade in; NORAD STRATEGIC COMMAND and the mission's briefing
StateFlyByStart .. StateFlyByWait    the camera flies round the mission's scene (CameraSequence 2 -> 3)
StateSecurityCheck                   the copy protection (below)
StateSecurityResult                  "CLEARANCE CONFIRMED - SCRAMBLE IMMEDIATELY"; counts a mission started
StateClearance .. StateToCockpit     the camera comes to the aircraft and into the cockpit (CameraSequence 4 -> 6)
StateReadyText                       "YOUR VECTOR XXX FOR BOGEY", "READY FOR TAKEOFF" / "READY TO LAUNCH" (on the carrier)
StateReadyWait, StateGo              starts the mission's clock; the player has the controls
StateFlying                          the flight
```

The other modes join the same chain at different points (the training and the qualification
skip the briefing and the fly-by; the demo goes straight to `StateReady`).

While flying, `StateFlying` watches for:

* **A crash** (the player's flags bit 9): `StateCrashed` takes an aircraft; with one left a new
  one is set up (`StateNewAircraft`), otherwise "HEY ROOKIE, F/A-18'S (or F-16'S) DON'T GROW ON
  TREES" (`StateNoAircraftLeft`) and back to the menu.
* **Pause** (`StatePause`: "- PAUSED -"; the time paused is not counted in the log).
* **The mission's result** (`MissionResult`), shown by `StateDebrief`:
  * `$FF` the objective achieved (hunk 18: `MissionTargetsDone` reached `MissionTargets`): the
    mission's success text and "RETURN TO BASE" or "RETURN TO CARRIER"; for the qualification,
    "LANDING SUCCESSFUL - YOU ARE NOW QUALIFIED" (the log's `+$00` set and saved).
  * `$FE` the mission failed: Air Force One destroyed (F2), the stolen aircraft beyond recovery
    range (F3), the rescue pod too far from the downed pilot (F4), the cruise missile exploded
    (F5)...
  * `$FD` in F2: "YOU HAVE DESTROYED AIR FORCE ONE".
  * `$FC` the mission completed (back on the ground): "YOUR LOG NOW REFLECTS THIS COMPLETED
    MISSION"; `MissionCompleted` records it (the log's last mission, the mission's count, the
    missions completed) and raises the difficulty by one, to at most 3; the log is saved.
  * then `$F0` back to the menu, or `$EF` (qualified) a restart.
* **Bailing out**: "YOU HAVE SURVIVED YOUR BAILOUT" (`StateBailout`).

### The security check

Every mode except the demo passes through `StateSecurityCheck`, the game's **copy protection**:
the DEFENSENET SECURITY CHECK. `MakeSecurityCode` takes four random hex digits from the clock and
shows them; the player must type the countercode, which `CodeCheck` works out from the digits
with its tables (`CodeHash`) - presumably what the game's documentation let a buyer look up.
`CheckSecurityAnswer` sets `CodeResult`. There are three tries (`CodeTries`); after the third
wrong answer, "UNAUTHORIZED CLEARANCE - DUE TO THREE FAILED ATTEMPTS ... - REBOOT -" and the game
stops (`StateLockedUp`). Once passed, restarting the same selection with Esc skips the check and
the briefing (`RestartMission`).

## The flight log and the missions

The disk is also the **log disk**: `config` is the pilot's flight log (missions started and
completed, the shots fired and hits of each weapon, the flight time, crashes, hits taken, the
difficulty). It is read at start-up and written back from the FLIGHT LOG STATISTICS page, but
only to a DOS disk that is not write-protected (`CheckDisk`: "NO LOG DISK PRESENT IN DF0:",
"UNINITIALIZED LOG DISK IN DF0:"...). The briefing's date comes from the flight time: one day
for each hour flown, from September 1st, 1994.

There are six missions, chosen with F1-F6 (hunk 64's texts; `GameMode` 3-8): Visual
Confirmation, Emergency Defense Operation (Air Force One), Intercept Stolen Aircraft, Search and
Rescue Operation, Intercept Incoming Cruise Missile, Carrier Sub Mission. They open one at a time:
the log counts how often each was completed (`+$12`+mode), and F*n* needs F*n*-1. A mission
needs the qualification (a carrier landing) first. The game flow above shows how one is
briefed, started and debriefed.

### Setting up a mission

`SetupMode` (hunk 26) builds the world for `GameMode` from `ModeTable` (hunk 27):

* Each mode has **three variants**, one picked at random (`ModeVariant`, kept if the selection
  is restarted), each with its number of targets (`MissionTargets`).
* Each variant has an object list **per number of times the mission has been completed** (the
  log's `+$12`+mode, `TimesCompleted`): flying a mission again brings a harder one.
* The list's 10-byte records place the objects (`PlaceObject`): the model, the object number
  (which of the 16 records it takes), the lowest **difficulty** it appears at, and optionally
  the one mode it is for. `AimObject` points each at its route's first waypoint or at another
  object it is to follow.

So what you meet depends on the mission, the variant, how often you have completed it and the
difficulty (which itself goes up by one with each mission completed).

### Judging a mission

`JudgeMission` (hunk 18) runs every frame, after the objects have moved, and calls the mode's
judge, which sets `MissionResult` and asks for the debriefing (`QuitRequest` 3):

| Mission | Success (`$FF`) | Failure (`$FE`) |
|---|---|---|
| F1 Visual confirmation | the unknown aircraft held close in view for 30 frames (`VisualConfirmTimer`, counted in hunk 38) | |
| F2 Emergency defense | Air Force One (object 4) down and slow, its attackers (objects 8, 10) gone | Air Force One destroyed (`$FD` if the player shot it) |
| F3 Intercept stolen aircraft | the targets done; flying close to a stolen aircraft (within a distance that shrinks with the difficulty) for 200 frames (`EscortTimer`) turns both back along their routes | they reach map cell X `$70`: beyond recovery range |
| F4 Search and rescue | the rescue pod (dropped with Shift+F, `DropRescuePod`) comes down within `$10000` of the downed pilot (object 11) | the pod lands further away |
| F5 Intercept cruise missile | the missile (object 4) shot down | it exploded (the view goes to it) |
| F6 Carrier sub mission | the targets done (`CheckMissionTargets`) | |
| Qualification | the aircraft down on the carrier and stopped | |
| Practice maneuvers | | the instructor's aircraft lost |

After a success the mission is completed (`$FC`) only once the player is back down at home and
stopped (`PlayerParked`): on the carrier if the flight started there, otherwise on the
airfield.

### Ejecting

Shift+E ejects: the player's record `+$7C` (low nibble) counts the sequence down
(`EjectAndDrop`): the ejection's sound, then the pilot becomes an object of his own (type `$30`,
`EjectPilot`, `EjectedPilot`) which the view follows (`ViewFollow`). When the parachute is down
(hunk 17) `QuitRequest` 2 brings "YOU HAVE SURVIVED YOUR BAILOUT". The same counter, started at
`$F` by Shift+F in mission F4, drops the rescue pod.

## The flight recording and the demo

The game can record a flight and play it back - the demo it shows is one. `RecordFrame` stores,
each frame, the player's control byte (`RecordBuffer`) and the frame's two key / button event
words (`RecordControls`); `PlayerFrameControls` plays them back in the replay modes
(`RecordMode` 1-3). Since the aircraft is flown only through its control bits and those events,
replaying the same inputs flies the same flight. The buffers are sized from the free memory at
start-up (at most 125,000 / 16 frames); `LoadDemoRecording` loads the disk's recording
(`text/textply`, `text/textctl`), `SaveRecording` writes one.

## Sound

* The samples are raw 8-bit PCM files (the `text/` folder), loaded into 37 sound slots
  (`SoundTable`, `LoadSound`); a slot can share another's data with other settings
  (`CopySound`) - one sample played at several pitches.
* audio.device is opened only to allocate the channels; then the game plays them itself: each
  channel's descriptor (`AudioChannels`) has its registers, DMA and interrupt bits, and an audio
  interrupt handler of the game's own (`AudioInstall`); a vertical blank server runs the sound.
* The title music's instruments are loaded only when there is the chip RAM.

## Memory

* Chip RAM: the display (two BitMaps of 320 x 200), the pictures, the samples, the graphics of
  hunk 62. The Workbench screen is closed to make room; the music needs more than 200,000 bytes
  free.
* The flight recording's buffers come from fast / public memory: half of what is free, at most
  125,000 bytes.
* Every allocation through the C library is tracked (`AllocMemTracked`) and freed at exit.

## Checks

* The pictures' checksums (`ChecksumPlanes`): the title (`$C560`), the instrument panel
  (`$7E70`) and the front (`$4DE8`). The title sequence plays only for the original title
  picture, and `StateStartup` stops the game at "CHECKSUM ERROR -" (with a code: 1 title, 2 panel,
  4 front, and the sum in hex) if any differs - against altered pictures.
* The security countercode (`MakeSecurityCode`, `CodeCheck` / `CodeHash`, `CheckSecurityAnswer`):
  the copy protection, asked before every flight (above).

## Open questions

* What speed the throttle gives (the target of `+$6C`), the afterburner, the fuel use, and what
  sets `FlightPhysics` (a game option, probably).
* The countermeasures (flares, chaff), damage, landing on the carrier (the flags the judges test).
* The computer pilots' states one by one (hunk 30), their attacks and firing; the object
  records' unknown fields in `ModeTable`.
* The 3D pipeline (hunks 13-15) and the model format (hunks 41-58).
* The ground, sky and scenery; the map and what is in each cell.
* The head-up display and most instruments (hunks 39-40).
* The views (`dat_071_00155`, `CameraSequence`) and the training's manoeuvres.
* The rest of the flight log's words, and which sound file is which effect.
