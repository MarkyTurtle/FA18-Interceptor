; F/A-18 Interceptor (Intellisoft / Electronic Arts 1988, Amiga) - the game's executable
; ("F-18 Interceptor" on the disk: an AmigaDOS hunk executable of 185 hunks, mostly Lattice C)
;
; Made by original/tools/disasm/make.py from its config; edited by hand since November 2026.
; The hunks are in src/ (one file per hunk, hunk 0 in three parts); empty hunks are here.
; Assemble (f18_hunks.i explains the two ways):
;   vasmm68k_mot -Fbin -m68000 -no-opt -o f18_main.exe f18_main.s      -> the file, byte-identical
;   vasmm68k_mot -Fhunkexe -kick1hunks -nosym -DHUNKEXE -m68000 -no-opt -o f18_check.exe f18_main.s
;
; Labels are named by hunk and offset: sub_HHH_OOOOO (called), l_HHH_OOOOO (jumped to),
; dat_HHH_OOOOO (data); hHHH is the start of hunk HHH and hHHH_end its end.

	include	"f18_hunks.i"

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

	include	"src/h000_code_part1.s"
	include	"src/h000_code_part2.s"
	include	"src/h000_code_part3.s"

	include	"src/h001_data.s"

	include	"src/h002_bss.s"

	include	"src/h003_code.s"

	include	"src/h004_code.s"

	include	"src/h005_code.s"

	include	"src/h006_code.s"

	include	"src/h007_code.s"

	include	"src/h008_code.s"

	include	"src/h009_code.s"

	include	"src/h010_code.s"

	include	"src/h011_code.s"

	include	"src/h012_code.s"

	include	"src/h013_code.s"

	include	"src/h014_code.s"

	include	"src/h015_code.s"

	include	"src/h016_code.s"

	include	"src/h017_code.s"

	include	"src/h018_code.s"

	include	"src/h019_code.s"

	include	"src/h020_code.s"

	include	"src/h021_code.s"

	include	"src/h022_code.s"

	include	"src/h023_code.s"

	include	"src/h024_code.s"

	include	"src/h025_code.s"

	include	"src/h026_code.s"

	include	"src/h027_code.s"

	include	"src/h028_code.s"

	include	"src/h029_code.s"

	include	"src/h030_code.s"

	include	"src/h031_code.s"

	include	"src/h032_code.s"

	include	"src/h033_code.s"

	include	"src/h034_code.s"

	include	"src/h035_code.s"

	include	"src/h036_code.s"

	include	"src/h037_code.s"

	include	"src/h038_code.s"

	include	"src/h039_code.s"

	include	"src/h040_code.s"

	include	"src/h041_code.s"

	include	"src/h042_code.s"

	include	"src/h043_code.s"

	include	"src/h044_code.s"

	include	"src/h045_code.s"

	include	"src/h046_code.s"

	include	"src/h047_code.s"

	include	"src/h048_code.s"

	include	"src/h049_code.s"

	include	"src/h050_code.s"

	include	"src/h051_code.s"

	include	"src/h052_code.s"

	include	"src/h053_code.s"

	include	"src/h054_code.s"

	include	"src/h055_code.s"

	include	"src/h056_code.s"

	include	"src/h057_code.s"

	include	"src/h058_code.s"

	include	"src/h059_code.s"

	include	"src/h060_code.s"

	include	"src/h061_code.s"

	include	"src/h062_code.s"

	include	"src/h063_code.s"

	include	"src/h064_code.s"

	include	"src/h065_code.s"

	include	"src/h066_code.s"

	include	"src/h067_code.s"

	include	"src/h068_code.s"

	include	"src/h069_code.s"

	include	"src/h070_code.s"

	include	"src/h071_code.s"

	include	"src/h072_code.s"

	include	"src/h073_code.s"

	include	"src/h074_code.s"

	include	"src/h075_code.s"

	include	"src/h076_code.s"

	include	"src/h077_code.s"

	include	"src/h078_data.s"

	include	"src/h079_bss.s"

	include	"src/h080_code.s"

	include	"src/h081_data.s"

;===============================================================================
; Hunk 82: BSS, $0 bytes
;===============================================================================
	BSS_HUNK	h082
h082_end:
	ifnd	HUNKEXE
	section	bin,code			; (back from the offset section)
	org	0
	dc.l	HUNK_END
	endc

	include	"src/h083_code.s"

	include	"src/h084_data.s"

;===============================================================================
; Hunk 85: BSS, $0 bytes
;===============================================================================
	BSS_HUNK	h085
h085_end:
	ifnd	HUNKEXE
	section	bin,code			; (back from the offset section)
	org	0
	dc.l	HUNK_END
	endc

	include	"src/h086_code.s"

;===============================================================================
; Hunk 87: CODE, $0 bytes
;===============================================================================
	CODE_HUNK	h087
h087_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc

	include	"src/h088_data.s"

;===============================================================================
; Hunk 89: BSS, $0 bytes
;===============================================================================
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
	CODE_HUNK	h090
h090_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc

	include	"src/h091_data.s"

;===============================================================================
; Hunk 92: BSS, $0 bytes
;===============================================================================
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
	CODE_HUNK	h093
h093_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc

	include	"src/h094_data.s"

;===============================================================================
; Hunk 95: BSS, $0 bytes
;===============================================================================
	BSS_HUNK	h095
h095_end:
	ifnd	HUNKEXE
	section	bin,code			; (back from the offset section)
	org	0
	dc.l	HUNK_END
	endc

	include	"src/h096_code.s"

;===============================================================================
; Hunk 97: DATA, $0 bytes
;===============================================================================
	DATA_HUNK	h097
h097_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc

;===============================================================================
; Hunk 98: BSS, $0 bytes
;===============================================================================
	BSS_HUNK	h098
h098_end:
	ifnd	HUNKEXE
	section	bin,code			; (back from the offset section)
	org	0
	dc.l	HUNK_END
	endc

	include	"src/h099_code.s"

	include	"src/h100_data.s"

;===============================================================================
; Hunk 101: BSS, $0 bytes
;===============================================================================
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
	CODE_HUNK	h102
h102_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc

	include	"src/h103_data.s"

;===============================================================================
; Hunk 104: BSS, $0 bytes
;===============================================================================
	BSS_HUNK	h104
h104_end:
	ifnd	HUNKEXE
	section	bin,code			; (back from the offset section)
	org	0
	dc.l	HUNK_END
	endc

	include	"src/h105_code.s"

;===============================================================================
; Hunk 106: DATA, $0 bytes
;===============================================================================
	DATA_HUNK	h106
h106_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc

;===============================================================================
; Hunk 107: BSS, $0 bytes
;===============================================================================
	BSS_HUNK	h107
h107_end:
	ifnd	HUNKEXE
	section	bin,code			; (back from the offset section)
	org	0
	dc.l	HUNK_END
	endc

	include	"src/h108_code.s"

;===============================================================================
; Hunk 109: DATA, $0 bytes
;===============================================================================
	DATA_HUNK	h109
h109_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc

;===============================================================================
; Hunk 110: BSS, $0 bytes
;===============================================================================
	BSS_HUNK	h110
h110_end:
	ifnd	HUNKEXE
	section	bin,code			; (back from the offset section)
	org	0
	dc.l	HUNK_END
	endc

	include	"src/h111_code.s"

;===============================================================================
; Hunk 112: DATA, $0 bytes
;===============================================================================
	DATA_HUNK	h112
h112_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc

;===============================================================================
; Hunk 113: BSS, $0 bytes
;===============================================================================
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
	CODE_HUNK	h114
h114_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc

	include	"src/h115_data.s"

;===============================================================================
; Hunk 116: BSS, $0 bytes
;===============================================================================
	BSS_HUNK	h116
h116_end:
	ifnd	HUNKEXE
	section	bin,code			; (back from the offset section)
	org	0
	dc.l	HUNK_END
	endc

	include	"src/h117_code.s"

	include	"src/h118_data.s"

;===============================================================================
; Hunk 119: BSS, $0 bytes
;===============================================================================
	BSS_HUNK	h119
h119_end:
	ifnd	HUNKEXE
	section	bin,code			; (back from the offset section)
	org	0
	dc.l	HUNK_END
	endc

	include	"src/h120_code.s"

;===============================================================================
; Hunk 121: DATA, $0 bytes
;===============================================================================
	DATA_HUNK	h121
h121_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc

;===============================================================================
; Hunk 122: BSS, $0 bytes
;===============================================================================
	BSS_HUNK	h122
h122_end:
	ifnd	HUNKEXE
	section	bin,code			; (back from the offset section)
	org	0
	dc.l	HUNK_END
	endc

	include	"src/h123_code.s"

;===============================================================================
; Hunk 124: DATA, $0 bytes
;===============================================================================
	DATA_HUNK	h124
h124_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc

	include	"src/h125_bss.s"

	include	"src/h126_code.s"

;===============================================================================
; Hunk 127: DATA, $0 bytes
;===============================================================================
	DATA_HUNK	h127
h127_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc

;===============================================================================
; Hunk 128: BSS, $0 bytes
;===============================================================================
	BSS_HUNK	h128
h128_end:
	ifnd	HUNKEXE
	section	bin,code			; (back from the offset section)
	org	0
	dc.l	HUNK_END
	endc

	include	"src/h129_code.s"

;===============================================================================
; Hunk 130: DATA, $0 bytes
;===============================================================================
	DATA_HUNK	h130
h130_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc

;===============================================================================
; Hunk 131: BSS, $0 bytes
;===============================================================================
	BSS_HUNK	h131
h131_end:
	ifnd	HUNKEXE
	section	bin,code			; (back from the offset section)
	org	0
	dc.l	HUNK_END
	endc

	include	"src/h132_code.s"

;===============================================================================
; Hunk 133: DATA, $0 bytes
;===============================================================================
	DATA_HUNK	h133
h133_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc

;===============================================================================
; Hunk 134: BSS, $0 bytes
;===============================================================================
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
	CODE_HUNK	h135
h135_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc

	include	"src/h136_data.s"

	include	"src/h137_bss.s"

	include	"src/h138_code.s"

;===============================================================================
; Hunk 139: DATA, $0 bytes
;===============================================================================
	DATA_HUNK	h139
h139_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc

;===============================================================================
; Hunk 140: BSS, $0 bytes
;===============================================================================
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
	CODE_HUNK	h141
h141_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc

;===============================================================================
; Hunk 142: DATA, $0 bytes
;===============================================================================
	DATA_HUNK	h142
h142_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc

	include	"src/h143_bss.s"

	include	"src/h144_code.s"

	include	"src/h145_data.s"

;===============================================================================
; Hunk 146: BSS, $0 bytes
;===============================================================================
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
	CODE_HUNK	h147
h147_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc

	include	"src/h148_data.s"

;===============================================================================
; Hunk 149: BSS, $0 bytes
;===============================================================================
	BSS_HUNK	h149
h149_end:
	ifnd	HUNKEXE
	section	bin,code			; (back from the offset section)
	org	0
	dc.l	HUNK_END
	endc

	include	"src/h150_code.s"

	include	"src/h151_code.s"

	include	"src/h152_code.s"

	include	"src/h153_code.s"

	include	"src/h154_code.s"

	include	"src/h155_code.s"

;===============================================================================
; Hunk 156: DATA, $0 bytes
;===============================================================================
	DATA_HUNK	h156
h156_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc

;===============================================================================
; Hunk 157: BSS, $0 bytes
;===============================================================================
	BSS_HUNK	h157
h157_end:
	ifnd	HUNKEXE
	section	bin,code			; (back from the offset section)
	org	0
	dc.l	HUNK_END
	endc

	include	"src/h158_code.s"

	include	"src/h159_code.s"

	include	"src/h160_code.s"

	include	"src/h161_code.s"

	include	"src/h162_code.s"

	include	"src/h163_code.s"

	include	"src/h164_code.s"

	include	"src/h165_code.s"

	include	"src/h166_code.s"

	include	"src/h167_code.s"

	include	"src/h168_data.s"

	include	"src/h169_bss.s"

;===============================================================================
; Hunk 170: CODE, $0 bytes
;===============================================================================
	CODE_HUNK	h170
h170_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc

	include	"src/h171_code.s"

	include	"src/h172_code.s"

;===============================================================================
; Hunk 173: CODE, $0 bytes
;===============================================================================
	CODE_HUNK	h173
h173_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc

	include	"src/h174_code.s"

	include	"src/h175_code.s"

;===============================================================================
; Hunk 176: DATA, $0 bytes
;===============================================================================
	DATA_HUNK	h176
h176_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc

	include	"src/h177_code.s"

;===============================================================================
; Hunk 178: DATA, $0 bytes
;===============================================================================
	DATA_HUNK	h178
h178_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc

	include	"src/h179_code.s"

;===============================================================================
; Hunk 180: DATA, $0 bytes
;===============================================================================
	DATA_HUNK	h180
h180_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc

	include	"src/h181_code.s"

;===============================================================================
; Hunk 182: DATA, $0 bytes
;===============================================================================
	DATA_HUNK	h182
h182_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc

;===============================================================================
; Hunk 183: DATA, $0 bytes
;===============================================================================
	DATA_HUNK	h183
h183_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc

	include	"src/h184_code.s"
