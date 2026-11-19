; F/A-18 Interceptor - hunk 81 (data)
; Included by ../f18_main.s.

;===============================================================================
; Hunk 81: DATA, $A4 bytes
;===============================================================================
	DATA_HUNK	h081
; SoundTable - The sound slots: 37 pointers to 64-byte sound records (0 = empty). A sound
; record: +$00 the sample data (chip RAM), +$04 its length in bytes (bit 31: shared, not
; freed), +$08 the period (16.16), +$0C the volume (16.16, 63 = full), +$10 how many times it
; plays (-1 = loops)...
SoundTable:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_081_00004:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_081_00008:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_081_0000C:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_081_00010:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_081_00014:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_081_00018:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_081_00020:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_081_00024:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_081_00028:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_081_0002C:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_081_00030:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_081_00034:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_081_00038:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_081_0003C:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_081_00040:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_081_00044:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_081_00048:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_081_00054:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_081_00058:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_081_00064:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_081_00068:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_081_00074:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_081_00078:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00,$00,$00,$00
dat_081_00084:
	dc.b	$00,$00,$00,$00
dat_081_00088:
	dc.b	$00,$00,$00,$00
dat_081_0008C:
	dc.b	$00,$00,$00,$00
dat_081_00090:
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
dat_081_000A0:
	dc.b	$72,$00,$00,$00
h081_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc
