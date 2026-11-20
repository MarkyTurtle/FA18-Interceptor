; F/A-18 Interceptor - hunk 81 (data)
; SoundTable: the 37 sound slots.
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
; CatapultSample - The sound loaded from text/textcpt (probably the catapult; SoundsLoaded bit
; 0), played by PlayCatapultSound.
CatapultSample:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; EngineSample - The engine sound loaded from text/textegn (SoundsLoaded bit 1).
EngineSample:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; EngineSample2 - The second engine sound, from text/textegn2.
EngineSample2:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; EffectSound - A sound made in memory for PlayEffect (its parameters at EffectParams).
EffectSound:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; TireSample - The sound loaded from text/texttre (probably the tyres' screech on landing;
; SoundsLoaded bit 2), played by PlayTireSound.
TireSample:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; SweepSound - A sound made in memory for PlaySweep (its parameters at SweepParams).
SweepSound:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; WindSample - The wind's sound, from text/textwnd (SoundsLoaded bit 4), with WindSample2.
WindSample:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_081_00024:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; GunSoundCopy - A copy of a loaded sound used for the gun (PlayGunSound; parameters at
; GunParams; SoundsLoaded bit 5).
GunSoundCopy:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; GearSample - The sound loaded from text/textger (probably the landing gear; SoundsLoaded bit
; 6), played by PlayGearSound.
GearSample:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; EffectSound2 - A copy of a loaded sound for PlayEffect2 (parameters at Effect2Params).
EffectSound2:
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
