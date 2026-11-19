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
   then the title picture's checksum (`ChecksumPlanes`): only for the original picture (`$C560`)
   does the title sequence play.
5. The instrument panel and front pictures (`pix/inst5`, `pix/frnt5`).
6. `RunGame`: frees the title pictures, allocates the display buffers, opens the input
   (`InitInput`: timer, keyboard, joystick, the mouse interrupt, the input handler; raises the
   priority), reads the flight log (`LoadConfig`), allocates the flight recording's buffers
   from free fast / public memory and loads the demo flight (`LoadDemoRecording`), fades the
   palette in, and enters the main loop.

## The main loop and the frame

`RunGame` never returns. Each pass is one frame:

```
sub_036_000C8      (swap the display buffers - not yet checked)
OwnBlitter
GameFrame          everything for this frame
DisownBlitter
ShowDisplay        wait for the bottom of the ViewPort, LoadView the buffer just drawn
```

The display is double-buffered: two copper lists (`MakeDisplay`), the drawing going to one
buffer (`DrawPlanes`) while the other is shown. Anything drawn once has to be drawn into both,
which is why the instruments have redraw counters set to 3 (`RedrawInstruments`).

`GameFrame` runs the frame's parts in a fixed order, setting `FrameStage` before each one (a
number from `$08` to `$1D4` - if the game stopped, it said where). `FrameCount` counts frames;
some parts run only every 2nd, 4th, 8th, 16th or 32nd frame, and the 16 objects' slower work is
spread out by object number (`FrameCount & 31 == the object`). The order, as far as worked out:

1. `ReadControls`: the joystick and buttons, every key waiting (`HandleKey`).
2. The objects: `UpdateObject` for each (the computer pilots, the player's controls or the
   replay, the flight model, the missiles), `RecordFrame`.
3. The camera (`SetupCamera`), which map cell the view is in (`UpdateViewCell`).
4. The 3D view: the ground and sky (not yet checked), `DrawObjects` (the visible objects and
   the scenery).
5. The cockpit: the instrument panel (`DrawPanel`), the head-up display and instruments (hunks
   38-40), the messages.
6. The sound: `CockpitSounds` (the requested warning tones, the engine following the throttle).

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

* whether it exists (`+$01` bit 6), its type (`+$62`: `0` Sidewinder, `1` AMRAAM, `'0'`-`'9'`
  aircraft...), its state (`+$05`) and a timer (`+$4C`);
* its position: a map cell (`+$06` X, `+$08` Z) and a 32-bit position (`+$14` X, `+$18` Y, `+$1C` Z)
  whose low 22 bits are the position inside the cell; Y is height, negative upwards;
* its velocity (`+$3E`, `+$42`, `+$46`) and speed (`+$6C`, `+$6E`);
* its attitude: pitch, heading, roll (`+$66`, `+$68`, `+$6A`) and two rotation matrices made from
  them (`+$80`, and `+$92` from the negated angles, whose third column is the nose's direction);
* its weapons: the selected weapon (`+$63`) and missiles left (`+$5F`: 4 AMRAAMs and 2 Sidewinders
  for the player at the start);
* its control bits (`+$64`, `+$65`) and the throttle (probably `+$2B`).

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

## The flight log and the missions

The disk is also the **log disk**: `config` is the pilot's flight log (missions started and
completed, the shots fired and hits of each weapon, the flight time, crashes, hits taken, the
difficulty). It is read at start-up and written back from the FLIGHT LOG STATISTICS page, but
only to a DOS disk that is not write-protected (`CheckDisk`: "NO LOG DISK PRESENT IN DF0:",
"UNINITIALIZED LOG DISK IN DF0:"...). The briefing's date comes from the flight time: one day
for each hour flown, from September 1st, 1994.

There are six missions, chosen with F1-F6 (hunk 64's texts): Visual Confirmation, Emergency
Defense, Intercept Stolen Aircraft, Search and Rescue, Intercept Incoming Cruise Missile, Carrier
Sub Mission. How a mission is set up and judged is not worked out yet.

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

* The title picture's checksum must be `$C560` for the title sequence to play
  (`ChecksumPlanes`) - an integrity check of the picture.
* `CodeCheck` / `CodeHash` compute a 16-bit value from four numbers with tables and an LFSR:
  probably a code check of some kind; where it is used is not known yet.

## Open questions

* What speed the throttle gives (the target of `+$6C`), the afterburner, the fuel use, and what
  sets `FlightPhysics` (a game option, probably).
* The countermeasures (flares, chaff), damage, ejecting, landing on the carrier.
* The computer pilots' states one by one (hunk 30), their attacks and firing; the missions
  (setting them up, success and failure).
* The 3D pipeline (hunks 13-15) and the model format (hunks 41-58).
* The ground, sky and scenery; the map and what is in each cell.
* The head-up display and instruments (hunks 38-40).
* The game's modes (`dat_071_00155`, `dat_071_0027E`, `dat_071_00276`...): the views, the menus,
  the training.
* The rest of the flight log's words, and which sound file is which effect.
