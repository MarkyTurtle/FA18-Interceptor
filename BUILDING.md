# Building

* **`original/`**: the original game. Its source reassembles byte-identical to the executable
  on the original disk.
* **`enhanced/`**: not started yet.

## What you need

| Tool | Needed for | Notes |
|---|---|---|
| [vasm](http://sun.hasenbraten.de/vasm/) (`vasmm68k_mot`), the 68000 assembler with Motorola syntax | every build | Build it from its source (`make CPU=m68k SYNTAX=mot`). Tested with vasm 2.0f |
| [Python](https://www.python.org/) 3 | the build check, the tools | Tested with Python 3.11 and 3.13 |
| Python package `capstone` | the disassembly tool (`original/tools/disasm/make.py`) | `pip install capstone` |
| A C/C++ compiler and Git | only to read the original IPF again (`original/tools/disk/build_dump.sh`) | gcc / g++ |

## The original

```
python original/build.py                   # assembles f18_main.s both ways and checks it (any system)
original/build.sh                          # the same (Linux, macOS, WSL)
```

`build.py` checks two things:

* `vasmm68k_mot -Fbin` makes `f18_main.exe` byte-identical to `F-18 Interceptor` on the disk
  (SHA-1 `0f64b302d22f4d1df1872d2f817a507d193c3ee8`);
* `vasmm68k_mot -Fhunkexe -DHUNKEXE` makes `f18_check.exe`, an ordinary executable built by vasm
  from the labels, which loads to the same image as the original: every hunk's contents and
  relocations. That proves every address in the source is a label rather than a number, so the
  source can be changed (and grow) and still make a working program.

To make the source again from its config (`original/tools/disasm/main_cfg.py`):

```
python3 original/tools/disasm/make.py      # writes original/f18_main.s, then runs the checks
```

To read the original disk again, from the IPF to the files in `original/disk/files/`:

```
sh original/tools/disk/build_dump.sh                                   # builds capsimg and dump
original/tools/disk/dump F18Interceptor.ipf TRACKDIR                   # raw MFM tracks
python3 original/tools/disk/ipf_to_adf.py TRACKDIR F18Interceptor.adf  # AmigaDOS sectors -> ADF
python3 original/tools/disk/extract_files.py F18Interceptor.adf        # -> disk/files, checked against disk/SHA1SUMS
```

## GitHub Actions

`.github/workflows/original.yml` runs on every push that changes the source or the build, on
Windows and Linux (Python 3.11 and 3.13): `original/build.py` (and `build.sh` on Linux), then a
check that the build left the checkout unchanged. vasm is built from its source mirror
(`.github/actions/vasm`).
