# F/A-18 Interceptor (Amiga) - disassembly

The Amiga flight simulator **F/A-18 Interceptor** (Intellisoft / Electronic Arts, 1988),
taken apart: its disk, every file on it, and the game's executable as a 68000 source that
reassembles byte-identical to the original.

| Folder | What it is |
|---|---|
| [`original/`](original) | **The original game**: the executable's source (`f18_main.s`), every file from the disk, and the tools that made them |
| [`enhanced/`](enhanced) | The enhanced game (not started yet) |

The disk is an ordinary AmigaDOS (OFS) disk with no copy protection on the tracks: Workbench
boots it (`s/startup-sequence` runs `LoadWb`) and the game starts from its icon. The game is one
AmigaDOS executable, `F-18 Interceptor` (331,232 bytes, 185 hunks, mostly compiled Lattice C),
which loads its pictures (`pix/`) and data (`text/`, `config`) from `df0:` as it runs.

[`BUILDING.md`](BUILDING.md) says how to build and check it.
