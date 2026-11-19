# F/A-18 Interceptor (Intellisoft / Electronic Arts 1988, Amiga) - the original

> This folder is **the original game**: the executable's source, which reassembles
> byte-identical to the file on the disk, and every file from the disk. See the
> [top-level README](../README.md) and [`../BUILDING.md`](../BUILDING.md).

| File | What it is |
|---|---|
| `f18_main.s` | The game's executable, `F-18 Interceptor`: the hunk header, then an include per hunk (the empty hunks are written here). First traced and labelled automatically (`tools/disasm/`), now edited by hand |
| `src/hNNN_type.s` | One file per hunk (`h000_code_part1.s`-`part3.s`: hunk 0 is split at routine boundaries, so every file stays small enough to read on GitHub) |
| `f18_hunks.i` | The hunk structure: the macros that let `f18_main.s` assemble either to the exact file (`-Fbin`) or as an ordinary executable (`-Fhunkexe -DHUNKEXE`) |
| `build.py`, `build.sh` | Assemble `f18_main.s` both ways and check it against the original (`../BUILDING.md`) |
| `disk/files/` | Every file from the disk, in its folders, as on the disk (`F-18 Interceptor/` is the volume) |
| `disk/FILES.md` | What each file is |
| `disk/SHA1SUMS` | SHA-1 of the IPF, the decoded ADF and every file |
| `tools/` | below |

```
vasmm68k_mot -Fbin -m68000 -no-opt -o f18_main.exe f18_main.s      ; sha1 0f64b302d22f4d1df1872d2f817a507d193c3ee8
```

`-no-opt` matters: the source keeps the original instruction sizes.

## The executable

An AmigaDOS hunk executable: 185 hunks (126 CODE, 32 DATA, 27 BSS; 48 of them empty), linked
with Lattice C - hunk 0 starts with Lattice's startup code (`c.o`), and the code is mostly
compiled C (`link a5`/`unlk a5` frames). Hunk 62 is DATA loaded into chip RAM. The file keeps
104 symbols (HUNK_SYMBOL), mostly the stubs that call the system libraries (`_OpenLibrary`,
`_LoadRGB4`, `_OwnBlitter`...) and the IFF picture unpacker (`_UnPackRow`); they name their
places in the source.

Several CODE hunks hold no code: hunks 71-73 are the game's variables (zeros in the file,
addressed from nearly every module), and hunks such as 42, 51, 63-65, 68 and 70 are tables.

In the source each hunk is under its own `org 0`, so a label's value is its offset in the
hunk, the value the file stores (LoadSeg adds the hunk's address when it loads it). Labels are
named by hunk and offset: `sub_HHH_OOOOO` (called), `l_HHH_OOOOO` (jumped to), `dat_HHH_OOOOO`
(data), `hHHH` and `hHHH_end` (a hunk's start and end). Each hunk's relocation and symbol tables
follow it, as in the file, in the `-Fbin` build only.

**The source is edited by hand** (since November 2026): it was made by `tools/disasm/make.py`
from its config, and is now the source itself - names and comments go straight into
`f18_main.s` and `src/*.s`, and `build.py` checks after every edit that it still assembles to the
original bytes and the same image. `make.py` is kept for the record (it writes to
`tools/disasm/regen/`, never over the source).

## Tools

| | |
|---|---|
| `tools/disasm/make.py` | How the source was first made (kept for the record): generates it from `main_cfg.py` with the engine into `tools/disasm/regen/` and runs `build.py`'s checks there. The source in this folder is edited by hand and no longer made from it |
| `tools/disasm/hunk.py` | The hunk layer over the engine: each hunk gets its own virtual base (`$40000000 + n*$100000`) and every relocated long is patched to the virtual address it points at, so the engine traces across hunks and only relocated longs become labels; it writes the source with the hunk structure |
| `tools/disasm/core.py`, `hw.py` | The disassembly engine (from the New Zealand Story disassembly): traces the code from the entry points (capstone), sweeps for code nothing reaches, checks with vasm that every instruction reassembles to its own bytes (any that does not is written as `dc.w`) |
| `tools/disasm/hunkfile.py` | Reads a hunk executable block by block (everything needed to write it back byte for byte), and its loaded image for `build.py`'s second check |
| `tools/disk/build_dump.sh`, `dump.cpp` | Builds capsimg (the SPS IPF library) and `dump`, which writes the IPF's tracks as raw MFM |
| `tools/disk/ipf_to_adf.py` | Decodes the raw MFM tracks (AmigaDOS sectors, checksums checked) into an ADF |
| `tools/disk/extract_files.py` | Extracts the files from the ADF and checks them against `disk/SHA1SUMS` |
