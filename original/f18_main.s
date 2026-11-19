; F/A-18 Interceptor (Intellisoft / Electronic Arts 1988, Amiga) - the game's executable
; ("F-18 Interceptor" on the disk: an AmigaDOS hunk executable of 185 hunks, mostly Lattice C)
;
; Made by original/tools/disasm/make.py from its config; edited by hand since November 2026.
; The hunks are in src/, one file per hunk named hNNN_type_contents.s (hunk 0 in three parts);
; the empty hunks are written here. Before each include, a note says what the hunk is.
; Assemble (f18_hunks.i explains the two ways):
;   vasmm68k_mot -Fbin -m68000 -no-opt -o f18_main.exe f18_main.s      -> the file, byte-identical
;   vasmm68k_mot -Fhunkexe -kick1hunks -nosym -DHUNKEXE -m68000 -no-opt -o f18_check.exe f18_main.s
;
; Labels are named by hunk and offset: sub_HHH_OOOOO (called), l_HHH_OOOOO (jumped to),
; dat_HHH_OOOOO (data); hHHH is the start of hunk HHH and hHHH_end its end.

	include	"f18_hunks.i"
	include	"f18_os.i"
	include	"f18_hw.i"

;===============================================================================
; The hunks
;===============================================================================
; Each hunk is one section of one object module of the original link (Lattice C, and some
; assembly), in link order:
;
;   0          the game's main module: startup, main, the frame loop, files, input, sound
;   1, 2       its data and variables (the library bases, the display, the pictures...)
;   3          _UnPackRow (EA IFF)
;   4 - 40     the game's modules: keyboard, controls, the 3D world and its drawing, weapons,
;              the camera, the drawing primitives, the head-up display and instruments...
;   41 - 70    data: the 3D models, the texts, the trig tables, other tables (in CODE hunks)
;   71 - 73    the game's variables (CODE hunks of zeros): ObjectTable, the lists, buffers
;   74 - 86    the sound: the driver, audio.device, loading the samples
;   88 - 169   the Lattice C library (stdio, files, memory, 32-bit and floating point)
;   171 - 184  amiga.lib: the system library call stubs and the port / IO request helpers
;
; 48 hunks are empty (size 0): a module's code, data or BSS section with nothing in it.
; docs/CODE.md has more about each part.

;===============================================================================
; The hunk header (the -Fbin build only: with -Fhunkexe vasm writes its own)
;===============================================================================
	ifnd	HUNKEXE
	section	bin,code
	org	0
	dc.l	HUNK_HEADER,0			; no resident libraries
	dc.l	185,0,184			; hunks, first, last
        dc.l    h000_end/4                      ; hunk 0: code, 41804 bytes
        dc.l    h001_end/4                      ; hunk 1: data, 876 bytes
        dc.l    h002_end/4                      ; hunk 2: bss, 10756 bytes
        dc.l    h003_end/4                      ; hunk 3: code, 148 bytes
        dc.l    h004_end/4                      ; hunk 4: code, 2036 bytes
        dc.l    h005_end/4                      ; hunk 5: code, 5800 bytes
        dc.l    h006_end/4                      ; hunk 6: code, 472 bytes
        dc.l    h007_end/4                      ; hunk 7: code, 20 bytes
        dc.l    h008_end/4                      ; hunk 8: code, 6420 bytes
        dc.l    h009_end/4                      ; hunk 9: code, 4420 bytes
        dc.l    h010_end/4                      ; hunk 10: code, 4008 bytes
        dc.l    h011_end/4                      ; hunk 11: code, 288 bytes
        dc.l    h012_end/4                      ; hunk 12: code, 1808 bytes
        dc.l    h013_end/4                      ; hunk 13: code, 4972 bytes
        dc.l    h014_end/4                      ; hunk 14: code, 4060 bytes
        dc.l    h015_end/4                      ; hunk 15: code, 1916 bytes
        dc.l    h016_end/4                      ; hunk 16: code, 3116 bytes
        dc.l    h017_end/4                      ; hunk 17: code, 6656 bytes
        dc.l    h018_end/4                      ; hunk 18: code, 1628 bytes
        dc.l    h019_end/4                      ; hunk 19: code, 1824 bytes
        dc.l    h020_end/4                      ; hunk 20: code, 3248 bytes
        dc.l    h021_end/4                      ; hunk 21: code, 640 bytes
        dc.l    h022_end/4                      ; hunk 22: code, 2932 bytes
        dc.l    h023_end/4                      ; hunk 23: code, 2244 bytes
        dc.l    h024_end/4                      ; hunk 24: code, 2832 bytes
        dc.l    h025_end/4                      ; hunk 25: code, 3400 bytes
        dc.l    h026_end/4                      ; hunk 26: code, 3764 bytes
        dc.l    h027_end/4                      ; hunk 27: code, 2328 bytes
        dc.l    h028_end/4                      ; hunk 28: code, 5300 bytes
        dc.l    h029_end/4                      ; hunk 29: code, 1840 bytes
        dc.l    h030_end/4                      ; hunk 30: code, 4512 bytes
        dc.l    h031_end/4                      ; hunk 31: code, 1884 bytes
        dc.l    h032_end/4                      ; hunk 32: code, 4936 bytes
        dc.l    h033_end/4                      ; hunk 33: code, 1060 bytes
        dc.l    h034_end/4                      ; hunk 34: code, 1296 bytes
        dc.l    h035_end/4                      ; hunk 35: code, 2068 bytes
        dc.l    h036_end/4                      ; hunk 36: code, 4644 bytes
        dc.l    h037_end/4                      ; hunk 37: code, 2656 bytes
        dc.l    h038_end/4                      ; hunk 38: code, 2000 bytes
        dc.l    h039_end/4                      ; hunk 39: code, 6480 bytes
        dc.l    h040_end/4                      ; hunk 40: code, 6124 bytes
        dc.l    h041_end/4                      ; hunk 41: code, 2832 bytes
        dc.l    h042_end/4                      ; hunk 42: code, 3224 bytes
        dc.l    h043_end/4                      ; hunk 43: code, 2068 bytes
        dc.l    h044_end/4                      ; hunk 44: code, 2024 bytes
        dc.l    h045_end/4                      ; hunk 45: code, 724 bytes
        dc.l    h046_end/4                      ; hunk 46: code, 1120 bytes
        dc.l    h047_end/4                      ; hunk 47: code, 772 bytes
        dc.l    h048_end/4                      ; hunk 48: code, 608 bytes
        dc.l    h049_end/4                      ; hunk 49: code, 1512 bytes
        dc.l    h050_end/4                      ; hunk 50: code, 1124 bytes
        dc.l    h051_end/4                      ; hunk 51: code, 3440 bytes
        dc.l    h052_end/4                      ; hunk 52: code, 3284 bytes
        dc.l    h053_end/4                      ; hunk 53: code, 2568 bytes
        dc.l    h054_end/4                      ; hunk 54: code, 2328 bytes
        dc.l    h055_end/4                      ; hunk 55: code, 2012 bytes
        dc.l    h056_end/4                      ; hunk 56: code, 1736 bytes
        dc.l    h057_end/4                      ; hunk 57: code, 1704 bytes
        dc.l    h058_end/4                      ; hunk 58: code, 2488 bytes
        dc.l    h059_end/4                      ; hunk 59: code, 1512 bytes
        dc.l    h060_end/4                      ; hunk 60: code, 248 bytes
        dc.l    h061_end/4                      ; hunk 61: code, 872 bytes
        dc.l    h062_end/4+$40000000            ; hunk 62: code, 456 bytes
        dc.l    h063_end/4                      ; hunk 63: code, 4596 bytes
        dc.l    h064_end/4                      ; hunk 64: code, 9256 bytes
        dc.l    h065_end/4                      ; hunk 65: code, 4440 bytes
        dc.l    h066_end/4                      ; hunk 66: code, 1848 bytes
        dc.l    h067_end/4                      ; hunk 67: code, 720 bytes
        dc.l    h068_end/4                      ; hunk 68: code, 6224 bytes
        dc.l    h069_end/4                      ; hunk 69: code, 888 bytes
        dc.l    h070_end/4                      ; hunk 70: code, 3492 bytes
        dc.l    h071_end/4                      ; hunk 71: code, 11604 bytes
        dc.l    h072_end/4                      ; hunk 72: code, 25564 bytes
        dc.l    h073_end/4                      ; hunk 73: code, 5800 bytes
        dc.l    h074_end/4                      ; hunk 74: code, 260 bytes
        dc.l    h075_end/4                      ; hunk 75: code, 404 bytes
        dc.l    h076_end/4                      ; hunk 76: code, 420 bytes
        dc.l    h077_end/4                      ; hunk 77: code, 344 bytes
        dc.l    h078_end/4                      ; hunk 78: data, 40 bytes
        dc.l    h079_end/4                      ; hunk 79: bss, 4 bytes
        dc.l    h080_end/4                      ; hunk 80: code, 1180 bytes
        dc.l    h081_end/4                      ; hunk 81: data, 164 bytes
        dc.l    h082_end/4                      ; hunk 82: bss, 0 bytes
        dc.l    h083_end/4                      ; hunk 83: code, 732 bytes
        dc.l    h084_end/4                      ; hunk 84: data, 4 bytes
        dc.l    h085_end/4                      ; hunk 85: bss, 0 bytes
        dc.l    h086_end/4                      ; hunk 86: code, 344 bytes
        dc.l    h087_end/4                      ; hunk 87: code, 0 bytes
        dc.l    h088_end/4                      ; hunk 88: data, 4 bytes
        dc.l    h089_end/4                      ; hunk 89: bss, 0 bytes
        dc.l    h090_end/4                      ; hunk 90: code, 0 bytes
        dc.l    h091_end/4                      ; hunk 91: data, 260 bytes
        dc.l    h092_end/4                      ; hunk 92: bss, 0 bytes
        dc.l    h093_end/4                      ; hunk 93: code, 0 bytes
        dc.l    h094_end/4                      ; hunk 94: data, 4 bytes
        dc.l    h095_end/4                      ; hunk 95: bss, 0 bytes
        dc.l    h096_end/4                      ; hunk 96: code, 104 bytes
        dc.l    h097_end/4                      ; hunk 97: data, 0 bytes
        dc.l    h098_end/4                      ; hunk 98: bss, 0 bytes
        dc.l    h099_end/4                      ; hunk 99: code, 160 bytes
        dc.l    h100_end/4                      ; hunk 100: data, 4 bytes
        dc.l    h101_end/4                      ; hunk 101: bss, 0 bytes
        dc.l    h102_end/4                      ; hunk 102: code, 0 bytes
        dc.l    h103_end/4                      ; hunk 103: data, 4 bytes
        dc.l    h104_end/4                      ; hunk 104: bss, 0 bytes
        dc.l    h105_end/4                      ; hunk 105: code, 712 bytes
        dc.l    h106_end/4                      ; hunk 106: data, 0 bytes
        dc.l    h107_end/4                      ; hunk 107: bss, 0 bytes
        dc.l    h108_end/4                      ; hunk 108: code, 332 bytes
        dc.l    h109_end/4                      ; hunk 109: data, 0 bytes
        dc.l    h110_end/4                      ; hunk 110: bss, 0 bytes
        dc.l    h111_end/4                      ; hunk 111: code, 124 bytes
        dc.l    h112_end/4                      ; hunk 112: data, 0 bytes
        dc.l    h113_end/4                      ; hunk 113: bss, 0 bytes
        dc.l    h114_end/4                      ; hunk 114: code, 0 bytes
        dc.l    h115_end/4                      ; hunk 115: data, 4 bytes
        dc.l    h116_end/4                      ; hunk 116: bss, 0 bytes
        dc.l    h117_end/4                      ; hunk 117: code, 1544 bytes
        dc.l    h118_end/4                      ; hunk 118: data, 16 bytes
        dc.l    h119_end/4                      ; hunk 119: bss, 0 bytes
        dc.l    h120_end/4                      ; hunk 120: code, 1008 bytes
        dc.l    h121_end/4                      ; hunk 121: data, 0 bytes
        dc.l    h122_end/4                      ; hunk 122: bss, 0 bytes
        dc.l    h123_end/4                      ; hunk 123: code, 364 bytes
        dc.l    h124_end/4                      ; hunk 124: data, 0 bytes
        dc.l    h125_end/4                      ; hunk 125: bss, 12 bytes
        dc.l    h126_end/4                      ; hunk 126: code, 644 bytes
        dc.l    h127_end/4                      ; hunk 127: data, 0 bytes
        dc.l    h128_end/4                      ; hunk 128: bss, 0 bytes
        dc.l    h129_end/4                      ; hunk 129: code, 136 bytes
        dc.l    h130_end/4                      ; hunk 130: data, 0 bytes
        dc.l    h131_end/4                      ; hunk 131: bss, 0 bytes
        dc.l    h132_end/4                      ; hunk 132: code, 36 bytes
        dc.l    h133_end/4                      ; hunk 133: data, 0 bytes
        dc.l    h134_end/4                      ; hunk 134: bss, 0 bytes
        dc.l    h135_end/4                      ; hunk 135: code, 0 bytes
        dc.l    h136_end/4                      ; hunk 136: data, 4 bytes
        dc.l    h137_end/4                      ; hunk 137: bss, 120 bytes
        dc.l    h138_end/4                      ; hunk 138: code, 104 bytes
        dc.l    h139_end/4                      ; hunk 139: data, 0 bytes
        dc.l    h140_end/4                      ; hunk 140: bss, 0 bytes
        dc.l    h141_end/4                      ; hunk 141: code, 0 bytes
        dc.l    h142_end/4                      ; hunk 142: data, 0 bytes
        dc.l    h143_end/4                      ; hunk 143: bss, 480 bytes
        dc.l    h144_end/4                      ; hunk 144: code, 2172 bytes
        dc.l    h145_end/4                      ; hunk 145: data, 20 bytes
        dc.l    h146_end/4                      ; hunk 146: bss, 0 bytes
        dc.l    h147_end/4                      ; hunk 147: code, 0 bytes
        dc.l    h148_end/4                      ; hunk 148: data, 16 bytes
        dc.l    h149_end/4                      ; hunk 149: bss, 0 bytes
        dc.l    h150_end/4                      ; hunk 150: code, 40 bytes
        dc.l    h151_end/4                      ; hunk 151: code, 192 bytes
        dc.l    h152_end/4                      ; hunk 152: code, 68 bytes
        dc.l    h153_end/4                      ; hunk 153: code, 160 bytes
        dc.l    h154_end/4                      ; hunk 154: code, 68 bytes
        dc.l    h155_end/4                      ; hunk 155: code, 16 bytes
        dc.l    h156_end/4                      ; hunk 156: data, 0 bytes
        dc.l    h157_end/4                      ; hunk 157: bss, 0 bytes
        dc.l    h158_end/4                      ; hunk 158: code, 168 bytes
        dc.l    h159_end/4                      ; hunk 159: code, 216 bytes
        dc.l    h160_end/4                      ; hunk 160: code, 20 bytes
        dc.l    h161_end/4                      ; hunk 161: code, 28 bytes
        dc.l    h162_end/4                      ; hunk 162: code, 20 bytes
        dc.l    h163_end/4                      ; hunk 163: code, 56 bytes
        dc.l    h164_end/4                      ; hunk 164: code, 24 bytes
        dc.l    h165_end/4                      ; hunk 165: code, 24 bytes
        dc.l    h166_end/4                      ; hunk 166: code, 916 bytes
        dc.l    h167_end/4                      ; hunk 167: code, 620 bytes
        dc.l    h168_end/4                      ; hunk 168: data, 80 bytes
        dc.l    h169_end/4                      ; hunk 169: bss, 140 bytes
        dc.l    h170_end/4                      ; hunk 170: code, 0 bytes
        dc.l    h171_end/4                      ; hunk 171: code, 332 bytes
        dc.l    h172_end/4                      ; hunk 172: code, 440 bytes
        dc.l    h173_end/4                      ; hunk 173: code, 0 bytes
        dc.l    h174_end/4                      ; hunk 174: code, 20 bytes
        dc.l    h175_end/4                      ; hunk 175: code, 240 bytes
        dc.l    h176_end/4                      ; hunk 176: data, 0 bytes
        dc.l    h177_end/4                      ; hunk 177: code, 44 bytes
        dc.l    h178_end/4                      ; hunk 178: data, 0 bytes
        dc.l    h179_end/4                      ; hunk 179: code, 132 bytes
        dc.l    h180_end/4                      ; hunk 180: data, 0 bytes
        dc.l    h181_end/4                      ; hunk 181: code, 320 bytes
        dc.l    h182_end/4                      ; hunk 182: data, 0 bytes
        dc.l    h183_end/4                      ; hunk 183: data, 0 bytes
        dc.l    h184_end/4                      ; hunk 184: code, 16 bytes
	endc

; Hunk 0: The C startup (c.o), main, RunGame and GameFrame (the frame loop); the EA IFF
;         picture reader; memory and disk checks; the flight log (df0:config) and flight
;         recording (textply/textctl) files; the keyboard, joystick, timer and mouse; loading
;         and playing the sounds.
	include	"src/h000_code_main_part1.s"
	include	"src/h000_code_main_part2.s"
	include	"src/h000_code_main_part3.s"

; Hunk 1: Initialised data: the C library's variables (_SysBase, _DOSBase...), the library and
;         file names, the code-check tables.
	include	"src/h001_data_globals.s"

; Hunk 2: Variables: the graphics library bases, the View, ViewPort, BitMaps and RastPorts,
;         the pictures' BitMaps and BMHDs, the flight log buffer, the device requests.
	include	"src/h002_bss_display_vars.s"

; Hunk 3: _UnPackRow: ByteRun1 decompression of a picture row (from the EA IFF code).
	include	"src/h003_code_unpackrow.s"

; Hunk 4: Game set-up and small helpers: the difficulty from the flight log, resetting
;         objects.
	include	"src/h004_code_setup.s"

; Hunk 5: HandleKey: the keyboard commands (each Key_ label is named by its key) and the stick
;         directions.
	include	"src/h005_code_keyboard.s"

; Hunk 6: The fire button, the instruments' redraw counters, ResetPlayerAircraft.
	include	"src/h006_code_controls.s"

; Hunk 7: Nop (an empty function) and a wrapper round the mouse interrupt.
	include	"src/h007_code_nop.s"

; Hunk 8: The 3D world's objects: which map cell the view is in (UpdateViewCell), DrawObjects
;         (the visible objects and the scenery, scaled by distance).
	include	"src/h008_code_objects.s"

; Hunk 9: Support for hunk 8: object lists and distances (DistanceScale) (not worked out yet)
	include	"src/h009_code_object_lists.s"

; Hunk 10: Object drawing routines, called through ObjectDrawTable (hunk 16).
	include	"src/h010_code_draw_objects.s"

; Hunk 11: A routine used by hunk 10's object drawing (not worked out yet)
	include	"src/h011_code_draw_helper.s"

; Hunk 12: More object drawing routines, called through ObjectDrawTable.
	include	"src/h012_code_draw_objects2.s"

; Hunk 13: The 3D pipeline used by the object drawing (hunks 10, 12): transforming, projecting
;         and clipping points and faces (not worked out yet)
	include	"src/h013_code_3d_pipeline.s"

; Hunk 14: More of the 3D pipeline, used by hunk 13 (not worked out yet)
	include	"src/h014_code_3d_pipeline2.s"

; Hunk 15: More of the 3D pipeline, used by hunks 13 and 10 (not worked out yet)
	include	"src/h015_code_3d_pipeline3.s"

; Hunk 16: ObjectDrawTable: each object's draw routine and model (the models are in hunks
;         41-58, 69, 70); MissileModels.
	include	"src/h016_code_model_table.s"

; Hunk 17: Aircraft and weapons: LaunchMissile (pylons, the flight log's counts) and the
;         missiles' and aircraft's updates (not worked out yet)
	include	"src/h017_code_weapons.s"

; Hunk 18: Game logic not yet identified (used by hunks 16 and 17).
	include	"src/h018_code_game18.s"

; Hunk 19: Arithmetic for the 3D pipeline (used by hunks 12-14) (not worked out yet)
	include	"src/h019_code_3d_maths.s"

; Hunk 20: Numbers into text (BinToBCD, PutNumber), the flight log page (ShowFlightLog,
;         ShowLogDate), ChecksumPlanes.
	include	"src/h020_code_text_log.s"

; Hunk 21: Data: colour tables (the palette ShowDisplay flashes) (not worked out yet)
	include	"src/h021_code_colours.s"

; Hunk 22: UpdateObject (each object's frame: states, computer pilots, warnings) and RecordFrame
;         (the flight recording).
	include	"src/h022_code_update_objects.s"

; Hunk 23: Game logic not yet identified (objects; called by GameFrame).
	include	"src/h023_code_game23.s"

; Hunk 24: Game logic not yet identified (objects and the flight log; used by hunks 22, 23).
	include	"src/h024_code_game24.s"

; Hunk 25: Game logic not yet identified (called by GameFrame; plots points).
	include	"src/h025_code_game25.s"

; Hunk 26: Game logic not yet identified (objects, the camera, the game modes; used by hunks 0
;         and 17).
	include	"src/h026_code_game26.s"

; Hunk 27: Data: a table used by hunks 17, 18, 26 and 30 (not worked out yet)
	include	"src/h027_code_table27.s"

; Hunk 28: Game logic not yet identified (uses the gun sound's variables; called by GameFrame).
	include	"src/h028_code_game28.s"

; Hunk 29: Game logic not yet identified (objects, the camera, the game modes).
	include	"src/h029_code_game29.s"

; Hunk 30: Steering from the orientation matrices, setting the control bits (+$65): probably
;         the computer pilots.
	include	"src/h030_code_pilots.s"

; Hunk 31: Lines drawn relative to the camera (DrawLine) (not worked out yet)
	include	"src/h031_code_lines3d.s"

; Hunk 32: Attitude and camera: SetAttitude, AnglesToMatrix, SinCos, SetupCamera.
	include	"src/h032_code_attitude_camera.s"

; Hunk 33: The 3D view's outline: PutEdge and the view's corners (320 x 180).
	include	"src/h033_code_3d_outline.s"

; Hunk 34: Used by hunk 33's outline (not worked out yet)
	include	"src/h034_code_3d_outline2.s"

; Hunk 35: Drawing with the blitter for the 3D pipeline (used by hunks 13-15, 29, 31) (not
;         worked out yet)
	include	"src/h035_code_blitter_draw.s"

; Hunk 36: Drawing: Plot and its variants, DrawLine (the blitter's line mode), the copper lists
;         (the double-buffered display).
	include	"src/h036_code_drawing.s"

; Hunk 37: Blitter copies: the title picture and the instrument panel onto the screen.
	include	"src/h037_code_blitter_copies.s"

; Hunk 38: Display drawing not yet identified (plots points for objects).
	include	"src/h038_code_display38.s"

; Hunk 39: The head-up display and instruments ("GUN RNG SHOOT"...) (not worked out yet)
	include	"src/h039_code_hud.s"

; Hunk 40: Display drawing not yet identified (points and lines for objects).
	include	"src/h040_code_display40.s"

; Hunk 41: A 3D model (shape data, used through ObjectDrawTable).
	include	"src/h041_code_model41.s"

; Hunk 42: A 3D model (shape data, used through ObjectDrawTable).
	include	"src/h042_code_model42.s"

; Hunk 43: A 3D model (shape data, used through ObjectDrawTable).
	include	"src/h043_code_model43.s"

; Hunk 44: A 3D model (shape data, used through ObjectDrawTable).
	include	"src/h044_code_model44.s"

; Hunk 45: A 3D model (shape data, used through ObjectDrawTable).
	include	"src/h045_code_model45.s"

; Hunk 46: Shape data shared by the models of hunks 47-50.
	include	"src/h046_code_model_shared.s"

; Hunk 47: A 3D model (shape data, used through ObjectDrawTable).
	include	"src/h047_code_model47.s"

; Hunk 48: A 3D model (shape data, used through ObjectDrawTable).
	include	"src/h048_code_model48.s"

; Hunk 49: A 3D model (shape data, used through ObjectDrawTable).
	include	"src/h049_code_model49.s"

; Hunk 50: A 3D model (shape data, used through ObjectDrawTable).
	include	"src/h050_code_model50.s"

; Hunk 51: A 3D model (shape data, used through ObjectDrawTable).
	include	"src/h051_code_model51.s"

; Hunk 52: A 3D model (shape data, used through ObjectDrawTable).
	include	"src/h052_code_model52.s"

; Hunk 53: A 3D model (shape data, used through ObjectDrawTable).
	include	"src/h053_code_model53.s"

; Hunk 54: A 3D model (shape data, used through ObjectDrawTable).
	include	"src/h054_code_model54.s"

; Hunk 55: A 3D model (shape data, used through ObjectDrawTable).
	include	"src/h055_code_model55.s"

; Hunk 56: A 3D model (shape data, used through ObjectDrawTable).
	include	"src/h056_code_model56.s"

; Hunk 57: A 3D model (shape data, used through ObjectDrawTable).
	include	"src/h057_code_model57.s"

; Hunk 58: A 3D model (shape data, used through ObjectDrawTable).
	include	"src/h058_code_model58.s"

; Hunk 59: Text: the head-up display's warning messages (STALL, LOW FUEL - CRITICAL...).
	include	"src/h059_code_messages.s"

; Hunk 60: Data: a small table used by hunks 0 and 32 (not worked out yet)
	include	"src/h060_code_table60.s"

; Hunk 61: Data for the head-up display (hunk 39) (not worked out yet)
	include	"src/h061_code_hud_data.s"

; Hunk 62: Data in chip RAM: graphics for the blitter (hunks 36, 37).
	include	"src/h062_code_chip_graphics.s"

; Hunk 63: Tables: SineTable (a quarter wave in tenths of a degree, 2.14) and others.
	include	"src/h063_code_trig_tables.s"

; Hunk 64: Text: the menus, the briefings (the six missions), the flight log page, the training
;         texts, the log disk messages.
	include	"src/h064_code_texts.s"

; Hunk 65: Data: a table used by hunk 8 (not worked out yet)
	include	"src/h065_code_table65.s"

; Hunk 66: Data: a table used by hunk 8 (not worked out yet)
	include	"src/h066_code_table66.s"

; Hunk 67: Data: a table used by hunks 66, 5, 4, 28 and 29 (not worked out yet)
	include	"src/h067_code_table67.s"

; Hunk 68: Data: a table used by hunk 28 (not worked out yet)
	include	"src/h068_code_table68.s"

; Hunk 69: A 3D model (shape data, used through ObjectDrawTable).
	include	"src/h069_code_model69.s"

; Hunk 70: A 3D model (shape data, used through ObjectDrawTable).
	include	"src/h070_code_model70.s"

; Hunk 71: The game's variables (zeros in the file): ObjectTable (16 records of 512 bytes),
;         FrameStage, FrameCount, the controls, the drawing state...
	include	"src/h071_code_variables.s"

; Hunk 72: Variables: the 3D pipeline's workspace (the projected points...).
	include	"src/h072_code_3d_workspace.s"

; Hunk 73: More variables: the visible object and scenery lists, the flight recording's
;         buffers...
	include	"src/h073_code_variables2.s"

; Hunk 74: The sound driver's data: the four audio channels' descriptors.
	include	"src/h074_code_audio_channels.s"

; Hunk 75: The sound driver: audio DMA and interrupt control, installing the audio interrupts.
	include	"src/h075_code_audio_driver.s"

; Hunk 76: The sound driver's interrupt routines (not worked out yet)
	include	"src/h076_code_audio_interrupts.s"

; Hunk 77: InitSound / CloseSound: audio.device and the game's audio interrupts.
	include	"src/h077_code_audio_device.s"

; Hunk 78: Data: "audio.device", the channel allocation.
	include	"src/h078_data_audio_strings.s"

; Hunk 79: A sound variable.
	include	"src/h079_bss_audio_vars.s"

; Hunk 80: Sound loading: LoadSound, CopySound, FreeSound.
	include	"src/h080_code_load_sounds.s"

; Hunk 81: SoundTable: the 37 sound slots.
	include	"src/h081_data_sound_table.s"

;===============================================================================
; Hunk 82: BSS, $0 bytes
;===============================================================================
; (empty: a section of a module with nothing in it)
	BSS_HUNK	h082
h082_end:
	ifnd	HUNKEXE
	section	bin,code			; (back from the offset section)
	org	0
	dc.l	HUNK_END
	endc

; Hunk 83: Floating-point arithmetic for the sound (single and double precision, through the C
;         library).
	include	"src/h083_code_float_maths.s"

; Hunk 84: A variable of hunk 83.
	include	"src/h084_data_float_vars.s"

;===============================================================================
; Hunk 85: BSS, $0 bytes
;===============================================================================
; (empty: a section of a module with nothing in it)
	BSS_HUNK	h085
h085_end:
	ifnd	HUNKEXE
	section	bin,code			; (back from the offset section)
	org	0
	dc.l	HUNK_END
	endc

; Hunk 86: Data used by the sound code in hunk 0 (not worked out yet)
	include	"src/h086_code_sound_tables.s"

;===============================================================================
; Hunk 87: CODE, $0 bytes
;===============================================================================
; (empty: a section of a module with nothing in it)
	CODE_HUNK	h087
h087_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc

; Hunk 88: C library: a variable (the stdio buffer size).
	include	"src/h088_data_lib_bufsiz.s"

;===============================================================================
; Hunk 89: BSS, $0 bytes
;===============================================================================
; (empty: a section of a module with nothing in it)
	BSS_HUNK	h089
h089_end:
	ifnd	HUNKEXE
	section	bin,code			; (back from the offset section)
	org	0
	dc.l	HUNK_END
	endc

;===============================================================================
; Hunk 90: CODE, $0 bytes
;===============================================================================
; (empty: a section of a module with nothing in it)
	CODE_HUNK	h090
h090_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc

; Hunk 91: C library: _ctype, the character class table.
	include	"src/h091_data_lib_ctype.s"

;===============================================================================
; Hunk 92: BSS, $0 bytes
;===============================================================================
; (empty: a section of a module with nothing in it)
	BSS_HUNK	h092
h092_end:
	ifnd	HUNKEXE
	section	bin,code			; (back from the offset section)
	org	0
	dc.l	HUNK_END
	endc

;===============================================================================
; Hunk 93: CODE, $0 bytes
;===============================================================================
; (empty: a section of a module with nothing in it)
	CODE_HUNK	h093
h093_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc

; Hunk 94: C library: errno.
	include	"src/h094_data_lib_errno.s"

;===============================================================================
; Hunk 95: BSS, $0 bytes
;===============================================================================
; (empty: a section of a module with nothing in it)
	BSS_HUNK	h095
h095_end:
	ifnd	HUNKEXE
	section	bin,code			; (back from the offset section)
	org	0
	dc.l	HUNK_END
	endc

; Hunk 96: C library: exit.
	include	"src/h096_code_lib_exit.s"

;===============================================================================
; Hunk 97: DATA, $0 bytes
;===============================================================================
; (empty: a section of a module with nothing in it)
	DATA_HUNK	h097
h097_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc

;===============================================================================
; Hunk 98: BSS, $0 bytes
;===============================================================================
; (empty: a section of a module with nothing in it)
	BSS_HUNK	h098
h098_end:
	ifnd	HUNKEXE
	section	bin,code			; (back from the offset section)
	org	0
	dc.l	HUNK_END
	endc

; Hunk 99: C library: Chk_Abort (CTRL-C / CTRL-D).
	include	"src/h099_code_lib_chk_abort.s"

; Hunk 100: C library: Enable_Abort.
	include	"src/h100_data_lib_enable_abort.s"

;===============================================================================
; Hunk 101: BSS, $0 bytes
;===============================================================================
; (empty: a section of a module with nothing in it)
	BSS_HUNK	h101
h101_end:
	ifnd	HUNKEXE
	section	bin,code			; (back from the offset section)
	org	0
	dc.l	HUNK_END
	endc

;===============================================================================
; Hunk 102: CODE, $0 bytes
;===============================================================================
; (empty: a section of a module with nothing in it)
	CODE_HUNK	h102
h102_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc

; Hunk 103: C library: a variable (the default file mode).
	include	"src/h103_data_lib_fmode.s"

;===============================================================================
; Hunk 104: BSS, $0 bytes
;===============================================================================
; (empty: a section of a module with nothing in it)
	BSS_HUNK	h104
h104_end:
	ifnd	HUNKEXE
	section	bin,code			; (back from the offset section)
	org	0
	dc.l	HUNK_END
	endc

; Hunk 105: C library: fopen, freopen, fclose.
	include	"src/h105_code_lib_fopen.s"

;===============================================================================
; Hunk 106: DATA, $0 bytes
;===============================================================================
; (empty: a section of a module with nothing in it)
	DATA_HUNK	h106
h106_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc

;===============================================================================
; Hunk 107: BSS, $0 bytes
;===============================================================================
; (empty: a section of a module with nothing in it)
	BSS_HUNK	h107
h107_end:
	ifnd	HUNKEXE
	section	bin,code			; (back from the offset section)
	org	0
	dc.l	HUNK_END
	endc

; Hunk 108: C library: fprintf.
	include	"src/h108_code_lib_fprintf.s"

;===============================================================================
; Hunk 109: DATA, $0 bytes
;===============================================================================
; (empty: a section of a module with nothing in it)
	DATA_HUNK	h109
h109_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc

;===============================================================================
; Hunk 110: BSS, $0 bytes
;===============================================================================
; (empty: a section of a module with nothing in it)
	BSS_HUNK	h110
h110_end:
	ifnd	HUNKEXE
	section	bin,code			; (back from the offset section)
	org	0
	dc.l	HUNK_END
	endc

; Hunk 111: C library: fread.
	include	"src/h111_code_lib_fread.s"

;===============================================================================
; Hunk 112: DATA, $0 bytes
;===============================================================================
; (empty: a section of a module with nothing in it)
	DATA_HUNK	h112
h112_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc

;===============================================================================
; Hunk 113: BSS, $0 bytes
;===============================================================================
; (empty: a section of a module with nothing in it)
	BSS_HUNK	h113
h113_end:
	ifnd	HUNKEXE
	section	bin,code			; (back from the offset section)
	org	0
	dc.l	HUNK_END
	endc

;===============================================================================
; Hunk 114: CODE, $0 bytes
;===============================================================================
; (empty: a section of a module with nothing in it)
	CODE_HUNK	h114
h114_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc

; Hunk 115: C library: a variable (the I/O mode).
	include	"src/h115_data_lib_iomode.s"

;===============================================================================
; Hunk 116: BSS, $0 bytes
;===============================================================================
; (empty: a section of a module with nothing in it)
	BSS_HUNK	h116
h116_end:
	ifnd	HUNKEXE
	section	bin,code			; (back from the offset section)
	org	0
	dc.l	HUNK_END
	endc

; Hunk 117: C library: low-level I/O (open, read, write, lseek, close...) and the console.
	include	"src/h117_code_lib_unixio.s"

; Hunk 118: C library: variables of the console.
	include	"src/h118_data_lib_unixio_vars.s"

;===============================================================================
; Hunk 119: BSS, $0 bytes
;===============================================================================
; (empty: a section of a module with nothing in it)
	BSS_HUNK	h119
h119_end:
	ifnd	HUNKEXE
	section	bin,code			; (back from the offset section)
	org	0
	dc.l	HUNK_END
	endc

; Hunk 120: C library: _filbuf, _flsbuf, _getbuf.
	include	"src/h120_code_lib_stdio_buf.s"

;===============================================================================
; Hunk 121: DATA, $0 bytes
;===============================================================================
; (empty: a section of a module with nothing in it)
	DATA_HUNK	h121
h121_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc

;===============================================================================
; Hunk 122: BSS, $0 bytes
;===============================================================================
; (empty: a section of a module with nothing in it)
	BSS_HUNK	h122
h122_end:
	ifnd	HUNKEXE
	section	bin,code			; (back from the offset section)
	org	0
	dc.l	HUNK_END
	endc

; Hunk 123: C library: AllocMemTracked (getmem), sbrk, the memory list.
	include	"src/h123_code_lib_memory.s"

;===============================================================================
; Hunk 124: DATA, $0 bytes
;===============================================================================
; (empty: a section of a module with nothing in it)
	DATA_HUNK	h124
h124_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc

; Hunk 125: C library: _MemList.
	include	"src/h125_bss_lib_memlist.s"

; Hunk 126: C library: malloc, free.
	include	"src/h126_code_lib_malloc.s"

;===============================================================================
; Hunk 127: DATA, $0 bytes
;===============================================================================
; (empty: a section of a module with nothing in it)
	DATA_HUNK	h127
h127_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc

;===============================================================================
; Hunk 128: BSS, $0 bytes
;===============================================================================
; (empty: a section of a module with nothing in it)
	BSS_HUNK	h128
h128_end:
	ifnd	HUNKEXE
	section	bin,code			; (back from the offset section)
	org	0
	dc.l	HUNK_END
	endc

; Hunk 129: C library: strcat, strncat.
	include	"src/h129_code_lib_strcat.s"

;===============================================================================
; Hunk 130: DATA, $0 bytes
;===============================================================================
; (empty: a section of a module with nothing in it)
	DATA_HUNK	h130
h130_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc

;===============================================================================
; Hunk 131: BSS, $0 bytes
;===============================================================================
; (empty: a section of a module with nothing in it)
	BSS_HUNK	h131
h131_end:
	ifnd	HUNKEXE
	section	bin,code			; (back from the offset section)
	org	0
	dc.l	HUNK_END
	endc

; Hunk 132: C library: strlen.
	include	"src/h132_code_lib_strlen.s"

;===============================================================================
; Hunk 133: DATA, $0 bytes
;===============================================================================
; (empty: a section of a module with nothing in it)
	DATA_HUNK	h133
h133_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc

;===============================================================================
; Hunk 134: BSS, $0 bytes
;===============================================================================
; (empty: a section of a module with nothing in it)
	BSS_HUNK	h134
h134_end:
	ifnd	HUNKEXE
	section	bin,code			; (back from the offset section)
	org	0
	dc.l	HUNK_END
	endc

;===============================================================================
; Hunk 135: CODE, $0 bytes
;===============================================================================
; (empty: a section of a module with nothing in it)
	CODE_HUNK	h135
h135_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc

; Hunk 136: C library: _nufbs.
	include	"src/h136_data_lib_nufbs.s"

; Hunk 137: C library: _ufbs, the low-level files.
	include	"src/h137_bss_lib_ufbs.s"

; Hunk 138: C library: _exit.
	include	"src/h138_code_lib__exit.s"

;===============================================================================
; Hunk 139: DATA, $0 bytes
;===============================================================================
; (empty: a section of a module with nothing in it)
	DATA_HUNK	h139
h139_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc

;===============================================================================
; Hunk 140: BSS, $0 bytes
;===============================================================================
; (empty: a section of a module with nothing in it)
	BSS_HUNK	h140
h140_end:
	ifnd	HUNKEXE
	section	bin,code			; (back from the offset section)
	org	0
	dc.l	HUNK_END
	endc

;===============================================================================
; Hunk 141: CODE, $0 bytes
;===============================================================================
; (empty: a section of a module with nothing in it)
	CODE_HUNK	h141
h141_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc

;===============================================================================
; Hunk 142: DATA, $0 bytes
;===============================================================================
; (empty: a section of a module with nothing in it)
	DATA_HUNK	h142
h142_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc

; Hunk 143: C library: _iob, the stdio FILEs.
	include	"src/h143_bss_lib_iob.s"

; Hunk 144: C library: _pfmt, the printf formatter.
	include	"src/h144_code_lib_pfmt.s"

; Hunk 145: C library: the hex digits.
	include	"src/h145_data_lib_hexdigits.s"

;===============================================================================
; Hunk 146: BSS, $0 bytes
;===============================================================================
; (empty: a section of a module with nothing in it)
	BSS_HUNK	h146
h146_end:
	ifnd	HUNKEXE
	section	bin,code			; (back from the offset section)
	org	0
	dc.l	HUNK_END
	endc

;===============================================================================
; Hunk 147: CODE, $0 bytes
;===============================================================================
; (empty: a section of a module with nothing in it)
	CODE_HUNK	h147
h147_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc

; Hunk 148: C library: malloc's variables.
	include	"src/h148_data_lib_malloc_vars.s"

;===============================================================================
; Hunk 149: BSS, $0 bytes
;===============================================================================
; (empty: a section of a module with nothing in it)
	BSS_HUNK	h149
h149_end:
	ifnd	HUNKEXE
	section	bin,code			; (back from the offset section)
	org	0
	dc.l	HUNK_END
	endc

; Hunk 150: C library: movmem.
	include	"src/h150_code_lib_movmem.s"

; Hunk 151: C library: double add / subtract.
	include	"src/h151_code_lib_dadd.s"

; Hunk 152: C library: CXD33, 32-bit divide.
	include	"src/h152_code_lib_ldiv.s"

; Hunk 153: C library: double divide.
	include	"src/h153_code_lib_ddiv.s"

; Hunk 154: C library: CXM33, 32-bit multiply.
	include	"src/h154_code_lib_lmul.s"

; Hunk 155: C library: SetFPErr.
	include	"src/h155_code_lib_fperr.s"

;===============================================================================
; Hunk 156: DATA, $0 bytes
;===============================================================================
; (empty: a section of a module with nothing in it)
	DATA_HUNK	h156
h156_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc

;===============================================================================
; Hunk 157: BSS, $0 bytes
;===============================================================================
; (empty: a section of a module with nothing in it)
	BSS_HUNK	h157
h157_end:
	ifnd	HUNKEXE
	section	bin,code			; (back from the offset section)
	org	0
	dc.l	HUNK_END
	endc

; Hunk 158: C library: IEEE single pack / unpack.
	include	"src/h158_code_lib_float_pack.s"

; Hunk 159: C library: IEEE double pack / unpack.
	include	"src/h159_code_lib_double_pack.s"

; Hunk 160: C library: long to single.
	include	"src/h160_code_lib_ltof.s"

; Hunk 161: C library: long to double.
	include	"src/h161_code_lib_ltod.s"

; Hunk 162: C library: single to long.
	include	"src/h162_code_lib_ftol.s"

; Hunk 163: C library: double to long.
	include	"src/h163_code_lib_dtol.s"

; Hunk 164: C library: single to double.
	include	"src/h164_code_lib_ftod.s"

; Hunk 165: C library: double to single.
	include	"src/h165_code_lib_dtof.s"

; Hunk 166: C library: double to decimal digits (for printf).
	include	"src/h166_code_lib_dtoa.s"

; Hunk 167: C library: __main (the command line, stdio, calls main).
	include	"src/h167_code_lib__main.s"

; Hunk 168: C library: the console window's name and an error message.
	include	"src/h168_data_lib_strings.s"

; Hunk 169: C library: __main's variables (argv...).
	include	"src/h169_bss_lib_main_vars.s"

;===============================================================================
; Hunk 170: CODE, $0 bytes
;===============================================================================
; (empty: a section of a module with nothing in it)
	CODE_HUNK	h170
h170_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc

; Hunk 171: The dos.library call stubs (_Open, _Close, _Read...).
	include	"src/h171_code_stubs_dos.s"

; Hunk 172: The exec.library call stubs (_AllocMem, _FindTask...).
	include	"src/h172_code_stubs_exec.s"

;===============================================================================
; Hunk 173: CODE, $0 bytes
;===============================================================================
; (empty: a section of a module with nothing in it)
	CODE_HUNK	h173
h173_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc

; Hunk 174: amiga.lib: _NewList.
	include	"src/h174_code_stubs_newlist.s"

; Hunk 175: amiga.lib: _CreatePort, _DeletePort.
	include	"src/h175_code_stubs_ports.s"

;===============================================================================
; Hunk 176: DATA, $0 bytes
;===============================================================================
; (empty: a section of a module with nothing in it)
	DATA_HUNK	h176
h176_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc

; Hunk 177: amiga.lib: _CreateStdIO, _DeleteStdIO.
	include	"src/h177_code_stubs_stdio.s"

;===============================================================================
; Hunk 178: DATA, $0 bytes
;===============================================================================
; (empty: a section of a module with nothing in it)
	DATA_HUNK	h178
h178_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc

; Hunk 179: amiga.lib: _CreateExtIO, _DeleteExtIO.
	include	"src/h179_code_stubs_extio.s"

;===============================================================================
; Hunk 180: DATA, $0 bytes
;===============================================================================
; (empty: a section of a module with nothing in it)
	DATA_HUNK	h180
h180_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc

; Hunk 181: The graphics.library call stubs (_LoadRGB4, _MakeVPort, _WaitBlit...).
	include	"src/h181_code_stubs_graphics.s"

;===============================================================================
; Hunk 182: DATA, $0 bytes
;===============================================================================
; (empty: a section of a module with nothing in it)
	DATA_HUNK	h182
h182_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc

;===============================================================================
; Hunk 183: DATA, $0 bytes
;===============================================================================
; (empty: a section of a module with nothing in it)
	DATA_HUNK	h183
h183_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc

; Hunk 184: The intuition.library call stub (_CloseWorkBench).
	include	"src/h184_code_stubs_intuition.s"
