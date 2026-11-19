# The code

What is known about `f18_main.s` and `src/*.s`, module by module. Each file in `src/` is named
`hNNN_type_contents.s` (its hunk's number and type, and what it holds); `f18_main.s` has a note
on every hunk before its include, and an overview of the groups at the top. Each hunk is one object module
of the original link: compiled Lattice C (functions start with `link a6` / end with `unlk a6`,
arguments on the stack, results in `d0`), some assembly. Routine headers in the source say what
each named routine does; routines still called `sub_HHH_OOOOO` are not worked out yet.

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
   `sub_036_000C8`, `OwnBlitter`, **`GameFrame`**, `DisownBlitter`, `ShowDisplay`.

`GameFrame` (hunk 0) runs one frame: `ReadControls` (joystick, buttons, every key through
`HandleKey`), then the simulation and drawing modules in a fixed order, setting `FrameStage`
before each. Some parts run only every 2nd, 4th, 8th, 16th or 32nd frame (`FrameCount`).

## The hunks

| Hunks | What they are |
|---|---|
| 0 | The C startup, `main`, `RunGame`, `GameFrame`; the IFF picture reader; memory and disk checks; the flight log and the flight recording files; the keyboard, joystick, timer and mouse; sound loading and `PlaySound` |
| 1, 2 | The program's data and variables: the library bases, the View, ViewPort, BitMaps and RastPorts, the picture BitMaps, the device requests |
| 3 | `_UnPackRow`: ByteRun1 decompression (from the EA IFF code) |
| 4 | Small helpers and game set-up (flight log setting, reset of the game state) |
| 5 | `HandleKey`: the keyboard commands (each `Key_` label is named by its key) |
| 6 | Instrument redraw counters, the fire button (`FirePressed`), `ResetPlayerAircraft` |
| 8 | The 3D world's objects: which map cell the view is in (`UpdateViewCell`), `DrawObjects` (the visible objects and the scenery list, scaled by distance) |
| 17 | Aircraft and weapons: `LaunchMissile` (pylons, the flight log's counts) and more |
| 22 | `UpdateObject` (each object's frame), `RecordFrame` (the flight recording) |
| 30 | Steering from the orientation matrices: probably the computer pilots (they set the control bits, +$65) |
| 32 | Attitude and camera: `UpdateAttitude`, `SetAttitude`, `AnglesToMatrix`, `SinCos`, `SetupCamera` |
| 33 | The 3D view's outline (`PutEdge`, the view's corners: 320 x 180) |
| 7, 9-16, 18-31, 34, 38-40 | The rest of the game: flight model, missions, terrain, instruments - being worked out |
| 20 | Number and text output, the flight log page (`ShowFlightLog`, `ShowLogDate`), `ChecksumPlanes` |
| 35, 36 | Drawing: `Plot` and its variants, `DrawLine` (blitter line mode), the copper lists (double-buffered display) |
| 37 | Blitter copies: the title picture and the instrument panel onto the screen |
| 41-70 | Data tables (some partly mistaken for code by the first trace) |
| 62 | Data in chip RAM (graphics) |
| 63 | Tables: `SineTable` (a quarter wave in tenths of a degree, 2.14) and others |
| 64 | The menu and briefing texts: the six missions (F1 VISUAL CONFIRMATION, F2 EMERGENCY DEFENSE, F3 INTERCEPT STOLEN AIRCRAFT, F4 SEARCH AND RESCUE, F5 INTERCEPT INCOMING CRUISE MISSILE, F6 CARRIER SUB MISSION), the flight log page, the training texts |
| 71-73 | The game's variables (zeros in the file): `ObjectTable` (512-byte records, from `dat_071_00B54`), `FrameStage`, `FrameCount`, the mouse position... |
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
