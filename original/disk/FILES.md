# The files on the disk

The original disk (`F18Interceptor.ipf`, SHA-1 in `SHA1SUMS`) is an ordinary AmigaDOS OFS disk,
volume **F-18 Interceptor** (25 March 1988). All 160 tracks are standard AmigaDOS tracks with good
checksums and no weak bits: there is no copy protection on the tracks. It decodes to
`F18Interceptor.adf` (`../tools/disk/`), and `files/` holds every file from it, in its folders
(empty folders on the disk - `fonts`, `System`, `devs/clipboards` - are not kept by git;
`extract_files.py` makes them).

`s/startup-sequence` runs `BindDrivers`, `LoadWb` and `endcli`: the disk boots to Workbench, and
the game is started from its icon.

| File | Bytes | What it is |
|---|---|---|
| `F-18 Interceptor` | 331,232 | **The game**: the executable, `../f18_main.s` |
| `F-18 Interceptor.info` | 7,756 | Its Workbench icon |
| `config` | 78 | **The pilot's flight log** (below): read at startup, written back from the log page |
| `pix/splsh` | 23,224 | IFF ILBM, 320 x 200, 5 planes, ByteRun1: the title picture |
| `pix/inst5` | 7,230 | IFF ILBM, 320 x 55, 5 planes, ByteRun1: the instrument panel (blitted to rows 145-199) |
| `pix/frnt5` | 988 | IFF ILBM, 288 x 12, 5 planes, ByteRun1: the front picture |
| `text/textply`, `text/textctl` | 3,676, 14,704 | **The flight recording** (the demo flight): below |
| the other 15 `text/` files | 568 - 65,590 | **Sound samples**: raw 8-bit signed PCM (below). Not text: the folder's name is the game's |
| `.info`, `Disk.info` | 33, 306 | Workbench: the disk's window and icon |
| `c/`, `l/`, `libs/`, `devs/` | | Workbench 1.2 (1986-87) system files: `BindDrivers`, `LoadWb`, `NewCLI`..., the handlers, `icon.library`, `info.library`, `version.library`, the keymaps, `system-configuration` |

## The formats

### The pictures (`pix/`)

Standard IFF ILBM, read by Electronic Arts' public-domain IFF code (`LoadPicture` in hunk 0:
`OpenRIFF`, `GetChunkHdr`, `GetCMAP`, `GetBODY`, `_UnPackRow`). The reader is simplified: it expects
the chunks in the order the files have them - `BMHD`, `CMAP` (32 colours), one 4-byte chunk
(`GRAB` here), `BODY` - and reads them in that order rather than by name. The planes go into chip
RAM; the colours become RGB4 words.

`main` checks the title picture: `ChecksumPlanes` adds up every word of its first four planes,
each rotated left 2 bits, and only when the sum is `$C560` (the original picture) does the
title sequence play.

### The sound samples (`text/`)

Each is raw 8-bit signed PCM, no header: `LoadSound(name, slot)` (hunk 80) reads the whole
file into chip RAM as one of the 37 sound slots (`SoundTable`, hunk 81). `CopySound(from, to)`
makes another slot that plays the same data with its own settings. A slot is a 64-byte record:

| Offset | Size | |
|---|---|---|
| `+$00` | long | the sample data (chip RAM) |
| `+$04` | long | its length in bytes; bit 31 set = the data belongs to another slot (not freed) |
| `+$08` | long | the period, 16.16 fixed point (`$166` = 358 when loaded) |
| `+$0C` | long | the volume, 16.16 (`$3F` = 63, full) |
| `+$10` | long | how many times it plays (1; -1 loops) |
| `+$14`-`+$3C` | | the rest of the settings (copied by `CopySound`) |

| File | Bytes | Slots | |
|---|---|---|---|
| `text201` | 568 | 35, 36 | loaded by `LoadSound201` (periods 179 / 181, looping) |
| `texti0a` | 2,044 | 13, 14 | the title music's instruments, loaded by `LoadMusicSamples` only when there is more than 200,000 bytes of chip RAM free |
| `texti0b` | 2,012 | 15, 16 | |
| `texti1` | 32,770 | 17, 18, 21, 22 | |
| `texti2` | 32,786 | 19, 20, 23, 24 | |
| `texti3` | 32,914 | 25, 26, 29, 30 | |
| `texti4` | 32,720 | 27, 28, 31, 32 | |
| `texti5` | 65,590 | 33, 34 | |
| `textegn`, `textegn2`, `texttre`, `textger`, `textcpt`, `textwnd` | 3,462 - 20,000 | | the sound effects, loaded by `LoadEngineSounds` (by their names: engine, ..., gear, cockpit, wind - not yet checked one by one) |

### The flight log (`config`)

78 bytes, big-endian words: the pilot's log, shown on the FLIGHT LOG STATISTICS page (hunk 64's
text) and written back to the disk from there ("1 ... UPDATE CURRENT LOG ONTO DISK"; "SHIFT 2
... RESET LOG" clears it). `LoadConfig` reads it at startup, or writes a new one, only if the
disk is a DOS disk and not write-protected (`CheckDisk`).

| Offset | Size | | In this file |
|---|---|---|---|
| `+$02` | word | a setting the game keeps in `dat_071_00277` (`GetLogSetting`) | 2 |
| `+$08` | long | accumulated flight time, in seconds; also sets the briefing's date: one day per hour flown from September 1st, 1994 (`ShowLogDate`) | 1,163 |
| `+$36` | word | missions started | 3 |
| `+$38` | word | missions successfully completed | 3 |
| `+$3A`, `+$3C` | word | M61 cannon rounds fired, hits | 15, 0 |
| `+$3E`, `+$40` | word | AIM-120 AMRAAMs fired, hits | 7, 4 |
| `+$42`, `+$44` | word | AIM-9L Sidewinders fired, hits | 1, 1 |
| `+$46` | word | crashes | 0 |
| `+$48` | word | hits from missiles | 0 |

The other words are not identified yet (`+$1E`-`+$23` hold the bytes `R`, `O`, `IE`).

### The flight recording (`textply`, `textctl`)

The game records a flight into two buffers (`RecordBuffer`, `RecordControls`), sized from the
free memory at startup (`AllocRecordBuffers`: `RecordLength` = half the free public memory,
at most 125,000, / 16; the controls take 4 bytes per position byte), and replays it. The disk
holds a recording (3,676 and 14,704 bytes: the second 4 times the first), loaded at startup by
`LoadDemoRecording`, which makes empty files if there are none; `SaveRecording` writes a new one.
Its layout (`RecordFrame` writes it, `PlayerFrameControls` replays it): `textply` has one
byte per frame, the player's control bits (as the object record's `+$65`: `$80`/`$40` the `,` and
`.` keys, `$20`/`$10` pitch, `$08`/`$04` roll); `textctl` has two words per frame, the key and button
events of that frame. A replay ends at three `$FF` bytes in `textply`, or at the end.
