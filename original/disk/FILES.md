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
| `config` | 78 | Read (and probably written) by the game: `df0:config` |
| `pix/splsh` | 23,224 | IFF ILBM, 320 x 200, 5 planes, ByteRun1: the title picture (`df0:pix/splsh`) |
| `pix/inst5` | 7,230 | IFF ILBM, 320 x 55, 5 planes, ByteRun1 (`df0:pix/inst5`) |
| `pix/frnt5` | 988 | IFF ILBM, 288 x 12, 5 planes, ByteRun1 (`df0:pix/frnt5`) |
| `text/text201` ... `text/textwnd` | 568 - 65,590 | 17 binary data files the game loads by name (`df0:text/...`): not text, not yet identified |
| `.info`, `Disk.info` | 33, 306 | Workbench: the disk's window and icon |
| `c/`, `l/`, `libs/`, `devs/` | | Workbench 1.2 (1986-87) system files: `BindDrivers`, `LoadWb`, `NewCLI`..., the handlers, `icon.library`, `info.library`, `version.library`, the keymaps, `system-configuration` |
