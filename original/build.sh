#!/bin/sh
# Assemble the executable's source both ways and check it against the file on the disk:
# byte for byte (-Fbin), and as an ordinary executable that loads to the same image (-Fhunkexe).
# Needs vasmm68k_mot (http://sun.hasenbraten.de/vasm/) on the PATH, and python3.
set -e
cd "$(dirname "$0")"
exec python3 build.py
