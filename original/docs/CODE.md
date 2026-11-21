# The code

(How the game works - start-up, the frame, the objects, flight, the 3D view... - is in
[`GAME.md`](GAME.md).)

What is known about `f18_main.s` and `src/*.s`, module by module. Each file in `src/` is named
`hNNN_type_contents.s` (its hunk's number and type, and what it holds); `f18_main.s` has a note
on every hunk before its include, and an overview of the groups at the top. Each hunk is one object module
of the original link: compiled Lattice C (functions start with `link a6` / end with `unlk a6`,
arguments on the stack, results in `d0`), some assembly. Routine headers in the source say what
each named routine does.

### The C routines' stack frames

A compiled routine starts `link.w a6,#-n`. Its caller pushes the arguments right to left, as
longs, so the first is at `8(a6)`, the next at `$C(a6)`...; a word argument is read from the
long's low half (`$A(a6)`), a byte from its last byte; the locals sit below `a6`. Where a
routine's arguments and locals are known they are named, in a block above its label that emits
no bytes:

```
; IFFReadBytes's frame: arguments from 8(a6), locals below a6 (after its link)
                rsset   8
IFFReadBytes_Context    rs.l    1               ; the IFF context
IFFReadBytes_Buffer     rs.l    1               ; where the bytes go
IFFReadBytes_Bytes      rs.l    1               ; how many to read
IFFReadBytes_Result     equ     -$4             ; 0, or an error
IFFReadBytes:
        link.w  a6,#$fffc
        ...
        movea.l IFFReadBytes_Context(a6),a0
        move.l  gc_ckSize(a0),d0
```

A word argument gets an `rs.w` for the long's unused high half first, so its name is the
address read. The names are `Routine_Name`, so each is unique. Structures the routines point
at are `rs` structures too: the IFF reader's `GroupContext` (`gc_...`) and `BitMapHeader`
(`bmh_...`) above `LoadPicture`; the system's (`bm_` BitMap, `io_` IOStdReq, `mp_`/`ln_`
MsgPort, `ie_` InputEvent) and the C library's (`iob_` FILE, `ufb_` low-level file) in `f18_os.i`. With `-no-opt`
a named offset assembles to the same bytes as the number, so the build stays byte-identical.

## How it runs

`_start` (Lattice's `c.o`) -> `main` (hunk 0):

1. opens graphics.library and the sound (`InitSound`, hunk 77);
2. loads the title picture (`LoadPicture` "df0:pix/splsh"), closes the Workbench screen, loads
   the sound samples (`LoadSound201`, and `LoadMusicSamples` when there is the chip RAM);
3. sets up the display (`InitDisplay`), shows the title picture and - if `ChecksumPlanes` says it
   is the original picture - plays the title sequence;
4. loads the panel and front pictures (pix/inst5, pix/frnt5);
5. `RunGame`: the input devices (`InitInput`: keyboard, joystick, mouse interrupt, timer, the
   input handler), the flight log, the flight recording; then for ever:
   `SelectDrawBuffer`, `OwnBlitter`, **`GameFrame`**, `DisownBlitter`, `ShowDisplay`.

`GameFrame` (hunk 0) runs one frame: `ReadControls` (joystick, buttons, every key through
`HandleKey`), then the simulation and drawing modules in a fixed order, setting `FrameStage`
before each. Some parts run only every 2nd, 4th, 8th, 16th or 32nd frame (`FrameCount`).

## The hunks

| Hunks | What they are |
|---|---|
| 0 | The C startup, `main`, `RunGame`, `GameFrame`; the game's states (`RunGameState` and the `State` routines: the screens and the flow of a flight, see GAME.md); the IFF picture reader; memory and disk checks; the flight log and the flight recording files; the keyboard, joystick, timer and mouse; sound loading and `PlaySound` |
| 1, 2 | The program's data and variables: the library bases, the View, ViewPort, BitMaps and RastPorts, the picture BitMaps, the device requests |
| 3 | `_UnPackRow`: ByteRun1 decompression (from the EA IFF code) |
| 4 | Small helpers and game set-up (flight log setting, reset of the game state) |
| 5 | `HandleKey`: the keyboard commands (each `Key_` label is named by its key) |
| 6 | Instrument redraw counters, the fire button (`FirePressed`), `ResetPlayerAircraft` |
| 8 | The 3D world's objects: which map cell the view is in (`UpdateViewCell`), `DrawObjects` (the visible objects and the scenery list, scaled by distance) |
| 17 | Objects and weapons: `UpdateAllObjects` (the object slots), `LaunchMissile`, `EnemyMayFire`, `CheckOnTail`, ejecting, the training sequence |
| 22 | `UpdateObject` (each object's frame), `RecordFrame` (the flight recording) |
| 30 | The computer pilots (`ComputerPilot`, `PilotStates`): the states, the manoeuvres, `CombatReactions` |
| 32 | Attitude and camera: `UpdateAttitude`, `SetAttitude`, `AnglesToMatrix`, `SinCos`, `SetupCamera` |
| 33, 34 | The sky: `DrawSkyAndGround`, `MakeSkyPolygon` (the view above the horizon), `DrawSun` |
| 18 | Judging the missions (`JudgeMission`, `JudgeF1`..., `CheckMissionTargets`): sets `MissionResult` |
| 26 | Setting up a mode (`SetupMode`), the camera's opening moves (`FlyBySetup`) |
| 10 | `DrawModel`: drawing a 3D model (levels of detail, vertices, the plane-test drawing list) |
| 13, 19, 35 | The shapes' operations (`ShapeOps`: point, line, `ShapePolygon`...), `ClipFillPolygon`, `ProjectPoint` |
| 38-40 | The radar, the instruments' readouts, the target readout, the text printer, the head-up display |
| 7, 9, 11, 23, 24, 29, 31 | The rest of the game: terrain, scenery, the special shapes - being worked out |
| 20 | Number and text output, the flight log page (`ShowFlightLog`, `ShowLogDate`), `ChecksumPlanes`; the text pages (`SetTextPage`); the security check (`MakeSecurityCode`, `CheckSecurityAnswer`) |
| 35, 36 | Drawing: the projection, `Plot` and its variants, `DrawLine` (blitter line mode), the copper lists (double-buffered display), `ClearSkyGround`, `FillPolygonPlane`, `DrawAttitudeIndicator` |
| 37 | Blitter copies: the title picture and the instrument panel onto the screen |
| 41-58, 69, 70 | The 3D models (see GAME.md: 41 the F/A-18, 51 missiles, F-16 and MiG, 52 the carrier, 55 the cruise missile, 57 the airliner, 58 animated objects...), drawn by `DrawModel` (hunk 10) through `ModelTable` (hunk 16); and the scenery shapes (42-50, 54-56, 69, 70: `ObjectDrawTable` entries 17-117) |
| 59-68 | Data tables (some partly mistaken for code by the first trace) |
| 21 | The palettes: the in-flight palette's 16 fade levels, the yellow flash |
| 28 | The bay's water areas (`DrawWaterAreas`) and more |
| 12-15 | The shapes' operations (`ShapeOps`), the flat ground shapes (`DrawGroundShape`) |
| 25 | `DrawGroundDots` |
| 62 | Data in chip RAM (graphics) |
| 63 | Tables: `SineTable` (a quarter wave in tenths of a degree, 2.14) and others |
| 64 | The menu and briefing texts: the six missions (F1 VISUAL CONFIRMATION, F2 EMERGENCY DEFENSE, F3 INTERCEPT STOLEN AIRCRAFT, F4 SEARCH AND RESCUE, F5 INTERCEPT INCOMING CRUISE MISSILE, F6 CARRIER SUB MISSION), the flight log page, the training texts; all addressed as numbered text pages (`TextPageTable`) |
| 67 | `StartPoints` (the free flight's starting locations) and other tables |
| 71-73 | The game's variables (zeros in the file): `ObjectTable` (512-byte records, from `ObjectTable`), `FrameStage`, `FrameCount`, the mouse position... |
| 74-77 | The sound driver: the four audio channels' descriptors (`AudioChannels`), DMA and interrupt control, audio.device (`InitSound`, `CloseSound`) |
| 78-83 | Sound loading (`LoadSound`, `CopySound`, `SoundTable`) and its arithmetic |
| 96-167 | The Lattice C library (stdio, low-level I/O, memory, 32-bit multiply/divide, IEEE floating point) |
| 168-184 | The library's data and the stubs that call the system libraries (`_Open`, `_AllocMem`, `_LoadRGB4`...) |

## Includes

| | |
|---|---|
| `f18_hunks.i` | The hunk structure (see `../README.md`) |
| `f18_os.i` | The system library calls (`_LVO...`), structure offsets, and constants the program uses |
| `f18_hw.i` | The custom chip registers the program uses (offsets from `CUSTOM`) |

## Tools for editing

* `tools/rename.py NAMES.txt` renames labels everywhere and adds their header boxes (`OLD NEW -
  description`; `- !description` replaces an existing header), then runs `build.py`.
* `tools/frames.py [ROUTINE...]` lists the C routines' frames: the argument and local offsets each
  uses (with their sizes and names), and how many bytes its callers pop. `tools/frames.py --name
  SPEC` writes the frame blocks above and puts the names into the routines' code; SPEC has a
  routine's name, then a line per offset (`  $8  Context  the IFF context`; an array local takes
  its size, `-$34/36`). A spec adds to the names a routine has; giving an offset a new name
  renames it. `tools/frames.py --todo` lists the offsets still unnamed: every argument has a
  name; the locals of the larger routines (the flight model, the scenery and HUD drawing...)
  are still numbers.
* `tools/decode.py LABEL` turns a `dc.b` region that turns out to be code into instructions
  (relocated longs stay labels), then runs `build.py`; the file is put back if the build differs.

## The objects

`ObjectTable` (hunk 71) holds 16 objects of 512 bytes: the player's aircraft is record 0 (its
fields are named `Player...` where the code uses them directly: `PlayerX`, `PlayerVelX`,
`PlayerWeapon`, `PlayerM11`...), the rest are other aircraft, missiles and so on (`Object1` ...
`Object15`). The header above `ObjectTable` in `src/h071_code_variables.s` lists the fields known so far:
the map cell and position (X/Z in map cells plus 22 bits inside the cell), the velocity, the
attitude angles and two rotation matrices, the type, the selected weapon and missiles left,
the control bits.

Units: angles are 1/80 degree (a full turn is `$7080` = 28,800); sines, cosines and matrix
elements are 2.14 fixed point (16384 = 1).
