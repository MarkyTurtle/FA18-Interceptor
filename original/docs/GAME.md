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
`BCDOut`, `DivideWhat` / `004A0` for `Divide`...).

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
| (first) | `ReadControls`, `RunGameState`, `WarningTicker` | the joystick, buttons and keys; **the game's state** (below); the warnings' 8-frame beat |
| `$08` | `SwitchView` | the cockpit or the outside view (`OutsideView`, `ViewShift`) |
| `$10` | `UpdateViewCell` (which calls `UpdateAllObjects`) | **the objects**: every object's update - computer pilots, the player's controls or the replay, engine, attitude, flight, missiles; the flight recording - and which map cell the view is in |
| `$20` | `SetupCamera`, `SetCockpitEye`, `SetViewOctant`, `SetHeightBand`, `UpdateScenery` | **the camera**: the pilot's eye in the aircraft, the compass eighth faced, how high the view is (`HeightBand`), and the scenery lists rebuilt when needed |
| `$60` | `ShakeView`, `ClearRadarList`, `DrawSkyAndGround` | the view shaken (`ShakeKind`), the radar's list emptied, and **the sky and the ground** (below) |
| `$68` | `DrawWaterAreas` | the bay's water |
| `$70` | `DrawSun` | the sun (probably) |
| `$78`, `$80` | `DrawFarScenery0`, `DrawFarScenery1` | the far scenery, from the two coarse maps |
| `$90` | `DrawGroundDots` | dots on the ground when low, to judge height and speed by |
| `$A0`-`$B0` | `BulletInFront`, `DrawObjects`, `UpdateBullets` | **the 3D view's objects and scenery** |
| `$C0` | `UpdateWarnings`, `CockpitSounds` | the warning sounds (on `WarningTicks`), the cockpit's sounds |
| `$D0` | `DrawPanel`, `DrawPanelPiece`, `DrawRadar`, `DrawHUD`, `DrawStatusLights`, `DrawCompass`, hunk 39 (several, some every 4th / 8th / 16th frame) | **the cockpit**: the instrument panel and the instruments |
| `$1A0` | `DrawPanelLamp`, hunks 37 and 39 | ? (the head-up display) |
| `$1D0`, `$1D4` | hunk 39, `CheckViewObjectGone`, `DrawMapMarkers`, `UpdateClock` (the time: `ReadTime`), and every 8 / 16 / 32 frames more | ? (the outside views; the clock) |
| `$210`-`$220` | `DrawBufferMark`, `ShowDebugNumbers`, `PrintText` (the flight log page, `SaveConfig`) | the menus and pages |

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
record holds (the `Object` structure above `ObjectTable` names all that is known, `obj_...`):

* whether it exists (`obj_Flags` low byte bit 6), its type (`obj_Type`, below), its state (`obj_State`) and a timer
  (`obj_Timer`);
* what has happened to it (`obj_Status`): bit 1 destroyed, bit 6 its signature confirmed (seen up
  close, so the radar's readout names it), bit 7 hit by the player;
* its position: a map cell (`obj_CellX`, `obj_CellZ`) and a 32-bit position (`obj_X`, `obj_Y`,
  `obj_Z`) whose low 22 bits are the position inside the cell; Y is height, positive upwards (`$708` on
  a runway; the game's own frame, drawn in the emulator, shows this);
* its velocity (`obj_VelX`, `obj_VelY`, `obj_VelZ`) and speed (`obj_Speed`, `obj_SpeedFlown`);
* its attitude: pitch, heading, roll (`obj_Pitch`, `obj_Heading`, `obj_Roll`) and two rotation matrices made from
  them (`obj_Matrix`, and `obj_Inverse` from the negated angles, whose third column is the nose's direction);
* its weapons: the selected weapon (`obj_Weapon`) and missiles left (`obj_Missiles`: 4 AMRAAMs and 2 Sidewinders
  for the player at the start);
* its control bits (`obj_Controls2`, `obj_Controls`), sticks (`obj_StickPitch`, `obj_Rudder`,
  `obj_StickRoll`) and throttle (`obj_Throttle`); the pitch stick drives `obj_PitchRate`, the rudder
  `obj_YawRate`, the roll stick `obj_RollRate`;
* for a computer aircraft, whether it is attacking (`obj_Attack`: 3, 4 when close, 5 broken off and
  sent along its route) and its destination (`obj_DestCellX`...);
* `obj_Group`: objects with the same value don't collide (a missile gets its launcher's number).
* how many cannon hits it has taken (`obj_Hits`, low nibble: the third destroys it), the sine and
  cosine of its roll (`obj_SinRoll`, `obj_CosRoll`, for the G load and the stall check), the height
  of a ship's deck under it (`obj_DeckHeight`, with `obj_Bits` bit 6 or 7: the floor it can't go
  below), and which cell of its 4 x 4 block it is in (`obj_Place`).

The types (`obj_Type`) seen so far:

| Type | Object |
|---|---|
| `$00`, `$01` | Sidewinder, AMRAAM missiles |
| `$10` | F-16 (the player's, if chosen; the stolen aircraft of F3; the instructor) |
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

The map is 128 x 128 cells. The **scenery** (the ground's features: runways, buildings and the
like, drawn as shapes) is kept in three maps in hunk 66 (`SceneryMap0`-`2`): for each map row,
the columns that have something and, for each such cell, a list of items (its place in the
cell and a shape). At start-up `BuildSceneryBits` turns each into a bit per cell
(`SceneryBits0`-`2`) for a quick test. Maps 0 and 1 work on a coarse grid of blocks of 4 x 4
cells - the large features, seen from afar, each built into a list of its own - and map 2 on
the cells themselves, the detail near the viewer (`SceneryList`). Everything lies in one corner
of the map: the coarse maps use blocks 0-16 (cells 0-67), the detailed map mostly a regular
pattern of cells around X 41-70, Z 44-70, and the free flight's starting locations are at cells
15-17.

The items' shape numbers index `ObjectDrawTable` beyond the 16 objects: entries 17-117 are the
scenery shapes, in hunks 42-50, 54-56, 69 and 70, drawn by `DrawScenery` (the same `DrawModel`)
or, for most of hunks 69 and 70, by hunk 12's renderer (`DrawGroundShape`): flat shapes whose
vertices are only x and z, all at the shape's height - the city's ground, the parks and hills,
and the roads (pictures in MODELS.md). Some are drawn only within a height of the camera.

Each time the view enters a new cell or turns into a new eighth of the compass (`ViewOctant`),
`BuildSceneryList` goes through the cells around it in an order from hunk 65 chosen by the
sub-cell and the octant (presumably the furthest first, as nothing is sorted) and adds each cell's scenery and objects
(`AddCellScenery`) to the list that is drawn.

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
  (`+$80`) is turned each frame by its three rates (`+$56`, `+$58`, `+$5A`; `NormaliseAngles`). The
  player's rates come from `FlightControls`: the stick deflection (`+$28`-`+$2A`, which builds
  up from the control bits) is looked up in a response table (`ControlResponse`, hunk 60) - so
  the stick sets how fast the aircraft rolls and pitches, not its angles. A computer aircraft
  has target rates (`+$50`-`+$54`) that its actual rates move about three quarters of the way to
  each frame, divided by its responsiveness (`+$26`). The roll eases back towards level (up to
  `$50` a frame) and, when `FlightPhysics` is set, a stall check compares a minimum speed worked
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
  flight log's `+$02`); see below.
* Falling objects: their velocity is damped horizontally and pulled down vertically (`$3C0`, then
  `$3C`, a frame).

### Computer pilots and combat

**The object slots.** `UpdateAllObjects` (hunk 17) runs the objects in a fixed order, and the
slots have fixed jobs: 0 is the player; 1-3 take the player's missiles (`PlayerLaunch` when
`LaunchRequest` is set, with no rate limit), or the ejected pilot / the rescue pod
(`EjectAndDrop`); 4 is the training instructor (`TrainingPilot`) and 5 his missile, or the
player's ejection (`CheckEjection`); and the enemies sit in pairs - aircraft 8, 10 and 12, each
followed by the slot for its missile (9, 11, 13). Every slot is then moved by `StepObject` (by
kind: missiles, pods and parachutes by their own physics, aircraft by their pilot) and
`UpdateObject`.

**The pilot's states.** `ComputerPilot` (hunk 30) runs the handler for the aircraft's state
(`+$05`, `PilotStates`, indexed from state 1). The handlers fly by setting the same control bits
(`+$65`) a player would (`RollCommand`, `PitchCommand`, `RollTowardsRate`), with strengths
looked up in `PitchRates` and `RollRates`; most count down the timer `+$4C`.

| State | Handler | What it does |
|---|---|---|
| 1, 3, 4, 8 | `PilotFly` | normal flight: steer towards the destination or the route's next waypoint |
| 2 | `PilotBank90` | roll to a 90-degree bank, then state 7 for 32 frames |
| 5 | `PilotTurnHard` | bank about 14 degrees and turn, for the timer |
| 6 | `PilotLevel` | fly on for the timer (a reaction delay) |
| 7 | `PilotPull` | pull until the timer runs out |
| 9 | `PilotTurnGentle` | bank about 8 degrees and turn, for the timer |
| 10 | `PilotWait` | wait for the timer |
| `$0B`-`$0D` | `ManAileronRoll` | aileron roll |
| `$0E`-`$10` | `ManInsideLoop` | inside loop |
| `$11`-`$13` | `ManSplitS` | split-S (only above height `$100000`) |
| `$14`-`$16` | `ManHalfLoop` | vertical half-loop |
| `$17`-`$19` | `ManBarrelRoll` | barrel roll |
| `$1A`-`$22` | `ManInverted` | roll inverted, fly inverted, roll back |
| `$23` | `ManTakeoff` | throttle up and lift off at speed `$840` |
| `$24`-`$26` | `ManClimbOut` | climb after take-off, then level above `$240000` |
| `$27` | `ManBreakTurn` | break turn: states 2 then 7 |
| `$28` | `PilotBeforeBreak` | hold for the timer, then the break turn |

**The training demo** is the instructor flying these manoeuvres in turn: `TrainingSequence`
(hunk 17) lists 8-byte steps - a view, then either a flight recording to play or (bit 31 set) a
pilot state: take-off, aileron roll, break turn, inside loop, split-S, half-loop, barrel roll and
inverted flight. `TrainingStep` counts through them (`NextManoeuvre`); in practice mode the step
wraps from 7 back to 1.

**Reacting to the player.** Each frame `CheckOnTail` sets an enemy's `+$04` bit 5 when the player
is within `$3000`, closing from behind and flying the same way. While it is set the enemy picks a
reaction from `CombatReactions` (hunk 30): a timer and a state - a gentle turn (9), a harder turn
(5) or a break turn (2) - by the player's range (under `$300`, `$C00`, `$1E00`, or farther), by
whether the enemy is slower or faster than the player by `$C0` or more, by whether the player has
just fired at it as the locked target, and by the **difficulty** (0-3): the harder the game, the
sooner an enemy breaks hard. At close range a row for "being shot at by the gun" exists but is
never used: the code tests `GunFlags` and then branches unconditionally past the row. In the
interception missions an aircraft on its route (state 8) that reacts this way counts as a target
met (`MissionTargets`).

**Enemy fire.** An enemy fires its missile (`EnemyMayFire`, then `LaunchMissile`) when it is
active and undamaged, its target (`+$38`) is still alive, the target lies in its forward cone
(`+$64` bits 5 and 6) and its pilot is attacking (`+$63` high nibble `$20` or `$30`); `FireNow`
forces the next launch. `LaunchMissile` then lets a computer aircraft fire only every 8, 6 or 4
frames by the difficulty (twice as often when `JToggle` is set), and only while it has
missiles left (`+$5F`).

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
* **The numbers** (hunk 39), each drawn only when its value changes (`ValueChanged`, the last
  value shown kept in `FuelShown`, `SpeedShown`...) since anything drawn must go into both
  display buffers:

  | Routine | Shows |
  |---|---|
  | `ShowSpeed` | the speed flown (`+$6E`) / 12 |
  | `ShowAltitude` | the height (`+$18`), up to 99,999 |
  | `ShowFuel` | the fuel (`+$72`) / 256 |
  | `ShowThrottle` | the throttle (`+$2B`, 0-120) as a percentage |
  | `ShowWeapon` | GUN and its rounds (`+$60`), SW and the Sidewinders, or AM and the AMRAAMs (`+$5F`), by the selected weapon (`+$63`: `$1x`, `$2x`, `$3x`) |
  | `ShowRadarRange` | the radar's range, 10, 20 or 40 (`RadarScale`) |
  | `ShowGridX`, `ShowGridZ` | the position as two 3-digit grid numbers: (position - `$10000000`) / `$700000` + 375 |
  | `ShowGLoad` | apparently the G meter, from the pitch rate (`+$56`) |
  | `ShowHeadingText` | "HDG" and the heading in degrees, written over an outside view |

  The F/A-18 and F-16 cockpits put some of them in different places. `ShowDebugNumbers` prints
  the mouse's position when a flag is set - apparently left from development.
* **The head-up display** (hunk 40, `DrawHUD`), drawn only in the cockpit (`OutsideView` 0):
  * fixed symbols (`DrawHUDFixed`): the boresight mark, two horizon bars and the outline of the
    glass; the gun cross below the centre (`DrawGunCross`);
  * while its readouts are on (`HUDOn`: set when the flight starts, toggled by the H key), the
    height, speed and heading (`HUDAltitude`, `HUDSpeed`, `HUDHeading`). The
    two aircraft differ: the **F/A-18** shows the height (in feet: the height / 1024 x 5) and
    the speed (knots: `+$6E` / 12) as numbers with FT and KT, the **F-16** as moving tapes either
    side with a pointer. Both have a heading scale across the top, numbered every 10 degrees;
  * the **target box** that slides towards the locked target (`DrawTargetBox`), the weapon and
    the G load (hunk 39);
  * with a missile selected, the **seeker** (`DrawMissileSeeker`): when it lies on the target
    box it has the target (the lock tone), and within the missile's range - `$1800` for the
    Sidewinder, `$2700` for the AMRAAM - the cue **IN RNG** (`ShootCue`), or a warning when
    closing too fast (`Closure`);
  * with the gun, the **gun sight** (`DrawGunSight`): a pipper where the bullets will be,
    computed from a point ahead of the aircraft kept two frames so that it lags in a turn
    (`ComputeGunPipper`), a range bar and the closure rate, and **SHOOT** when the target is
    within 8 pixels of the pipper and closer than `$900`.

  `tools/models/hud.py` draws it in the emulator:

  ![The head-up display: the F/A-18 and the F-16 (above); a target locked with the gun - the
  pipper, its range bar and the closure - and with a Sidewinder, in range (below)](images/hud.png)

`OutsideView` is set for the outside views (the keypad chooses the view, `ViewChoice`): then the
view fills more of the screen and the heading, speed and height are written over it instead.

The menus, briefings and typed input use the same screen: **the text printer** (`PrintText`)
types the queued pages a character at a time with a click, drawing each character into the
bit-planes with the CPU (`DrawCharPlane`, the `Font` in hunk 61, the columns in `TextColumns`).
A page starts with its position, flags and colour (the high nibble the colour, the low the
delay between characters); its lines end with 0 and the page with -1. For the callsign and the
security code it reads the keys from `KeyBuffer` instead (a ring of the last 10 key codes filled
by `HandleKey`, turned into letters by `KeyToAscii`).

## The 3D view

Pictures of every model and scenery shape, drawn by running the game's own code in an
emulator, are in [`MODELS.md`](MODELS.md).


**The sky and the ground** are not drawn as objects, and there is no copper effect: each frame
`ClearSkyGround` (hunk 36) clears the 3D view by blitter, one plane at a time, to the ground's
colour - 4 (green) over land, or 6 (dark blue) when `CheckSeaView` finds that the view looks out
over the sea (`SeaView`, from a table of map blocks, heights and view directions,
`SeaViewTable`). `MakeSkyPolygon` (hunk 33) turns the view's four corner directions by the view
matrix, finds where the horizon crosses the view's edges (hunk 34), and builds the polygon of the
view above it - two horizon points and the corners on the sky's side. It is filled into plane 0
(`FillPolygonPlane`: edges, then the blitter's area fill), which turns the ground colour 4 into
5, the blue-grey sky; over the sea plane 1 is also cleared under it (`PlaneOpUnderFill`), so the
sky is colour 5 there too. On land the bay's water is then drawn on the ground as flat colour-6
polygons (`DrawWaterAreas`, hunk 28), and a small orange mark in a fixed direction is probably
the sun (`DrawSun`). The same sky polygon, made with the instrument's own matrix and shrunk into
its box, is the panel's **attitude indicator** (`DrawAttitudeIndicator`). The in-flight palette
is the first row of `FlightPalette` (16 rows, darker each row, stepped through to fade in and
out); `FlashPalette` is the all-yellow palette flashed while `FlashCount` counts down.

* The **camera** (`SetupCamera`) is the cockpit, or in the outside views a point near the viewed
  object (`SetOutsideCamera`); `CameraX`, `CameraY`, `CameraZ` and the viewer's cell are what
  everything is drawn relative to.
* `DrawObjects` (hunk 8) goes through the visible objects (`VisibleObjects`): each one's
  distance (the largest of |dx|, |dy|, |dz|) picks a scale (`DistanceScale`), its coordinates
  are shifted down by it, and its draw routine from `ObjectDrawTable` (hunk 16) draws its model
  (hunks 41-58, 69, 70). Then the scenery (`SceneryList`, 24-byte entries), then the small
  objects.
* Each object's `ObjectDrawTable` entry is a copy of a `ModelTable` entry (20 bytes: the draw
  routine, the model's base address, the shape list now and next - for animations - and a
  second model), made when the object is placed (`PlaceObject` takes the entry's offset from the mission's list). The models:

  | `ModelTable` | Model | Hunk |
  |---|---|---|
  | `$00`, `$14` | Sidewinder, AMRAAM | 51 |
  | `$28`, `$104` | a pilot under his parachute (animated; the downed pilot of F4) | 58 |
  | `$3C` | F-16 | 51 |
  | `$50` | F/A-18 | 41 |
  | `$64`, `$118`, `$12C` | the airliner: Air Force One, 707, 767 | 57 |
  | `$78`, `$8C` | MiG (one shape for both) | 51 |
  | `$A0`, `$B4` | the carrier (always object 14) | 52 |
  | `$C8` | the cruise missile | 55 |
  | `$DC` | the rescue pod: a box under a parachute (animated) | 58 |
  | `$F0` | the submarine (object 15 of F6, the shadow sub) | 53 |

* **A model** (`DrawModel`, hunk 10) starts with a list choosing the shape by distance - the
  levels of detail: distance words (bits 0-13) compared with the object's distance, with
  offsets to follow, and a word with the top bit set giving the chosen shape's offset (the
  exact layout of the list is not fully worked out). A shape begins with a header: a number, two distance limits, two scale
  shifts (a byte's nibbles), flags and the vertex counts; then the vertices (three words each),
  which are turned by the object's matrix and moved to the camera (`VertexBuffer`). Then comes
  the shape's **drawing list**: entries that test which side of a plane (three of the
  vertices) the camera is on and jump to one branch or the other, and lists of faces and lines.
  This orders the drawing without sorting - the far side of the model is drawn first and the near
  side over it, like a BSP tree. The tests (`FacesCamera`) take the normal of three vertices,
  or a stored point and normal, or one of the model's coordinates.
* A **face list** is a run of operations from `ShapeOps` (hunk 13), each a word with the top
  bit set (bit 14 marks the last), followed by its operands: a point (vertex, colour), a line
  (two vertices, colour), a **filled polygon** (`ShapePolygon`: the vertices, the last marked
  with bit 15, then the colour - drawn from both sides if the colour has bit 15, from the back
  only with a second colour), and some 60 more: lines in runs, fans and lists; parallelograms
  from three corners; the runway's polygons, chosen by which side of them the viewer is; the
  buildings' grids of windows; the aircraft's **shadow** (op `$10`, its faces flattened onto
  the ground in colour 0); round blobs scaled by distance; operations that compute a model's
  extra vertices (its moving parts); and ones that skip or pick part of the list - an animation
  frame by `FrameCount`, the ejection's step, which side of a triangle faces the camera. The
  `ShapeOps` header in hunk 13 groups them; `tools/models/opstats.py` lists their users. Vertices are
  byte offsets into `VertexBuffer`. A list can first transform more vertices
  (`TransformMoreVertices`), so the parts of a model not drawn are not transformed either.
* **Projection** (`ProjectPoint`, hunk 35): x' = 160 + 160 x / z, y' = 90 + 90 y / z - a view
  90 degrees wide on the 320 x 180 window; polygons are clipped to it and filled
  (`ClipFillPolygon`, hunk 19).
* Animated objects (`DrawAnimated`, `DrawParachute`) change the shape drawn each frame by their
  timer; an aircraft that is hit starts its explosion (`DrawAircraft`).
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

`StateFlightSetup` then sets up the world for the mode (hunk 26, `SetupMode`, from the mode's
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
* How an enemy decides to attack (who sets `+$63` and the forward-cone bits `+$64`), and the
  object records' unknown fields in `ModeTable`.
* The clipping (hunk 19), the runway's view-dependent operations ($1C-$28) in detail, and op
  `$7C`.
* What each scenery shape is; the operations no shape uses; what `FlightBits2` bit `$2000` (a whole-sky
  view) and the second view table (`CheckViewTable2`) are for.
* Some of the instruments (hunk 39) and the panel's blitter-drawn gauges (hunk 37); the
  head-up display's target box in detail; the outside views' extra drawing (`DrawMapMarkers`)
  and stage `$1A0` (`DrawPanelLamp`); the particle records at `Bullets` (hunk 23,
  `UpdateBullets`).
* The outside views' choices (`ViewChoice`, `CameraSequence`); what `GunFlags` bits 1, 3 and 4
  are besides the view switch.
* The rest of the flight log's words, and which sound file is which effect.
