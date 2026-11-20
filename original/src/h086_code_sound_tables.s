; F/A-18 Interceptor - hunk 86 (code)
; Data: the parameter blocks of the sound effects (EffectParams, SweepParams, GearParams, Effect2Params, GunParams).
; Included by ../f18_main.s.

;===============================================================================
; Hunk 86: CODE, $158 bytes
;===============================================================================
	CODE_HUNK	h086
; EffectParams - The sound parameters of PlayEffect (EffectSound): period, volume, length and
; their changes, set on each call.
EffectParams:
	dc.b	$00,$00,$00,$24
EffectParams_04:
	dc.b	$00,$00,$00,$05,$00,$00,$00,$28
EffectParams_0C:
	dc.b	$00,$00,$00,$03,$00,$00,$00,$08
EffectParams_14:
	dc.b	$00,$8C,$00,$00,$00,$00,$00,$0C
EffectParams_1C:
	dc.b	$00,$28,$00,$00,$00,$00,$00,$2C
EffectParams_24:
	dc.b	$00,$00,$00,$05,$00,$00,$00,$08
EffectParams_2C:
	dc.b	$00,$8C,$00,$00,$00,$00,$00,$0C
EffectParams_34:
	dc.b	$00,$00,$00,$00,$00,$00,$00,$2C
EffectParams_3C:
	dc.b	$00,$00,$00,$01,$00,$00,$00,$44,$00,$00,$00,$10,$00,$00,$00,$2C
EffectParams_4C:
	dc.b	$00,$00,$00,$05,$00,$00,$00,$40,$00,$00,$00,$08,$00,$00,$00,$2C
	dc.b	$00,$00,$00,$00
; SweepParams - The sound parameters of PlaySweep (SweepSound).
SweepParams:
	dc.b	$00,$00,$00,$0C
SweepParams_04:
	dc.b	$00,$3C,$00,$00,$00,$00,$00,$1C
SweepParams_0C:
	dc.b	$FF,$FF,$00,$00,$00,$00,$00,$2C
SweepParams_14:
	dc.b	$00,$00,$00,$3C,$00,$00,$00,$0C,$00,$00,$00,$00,$00,$00,$00,$2C
	dc.b	$00,$00,$00,$00
; GearParams - The sound parameters of PlayGearSound.
GearParams:
	dc.b	$00,$00,$00,$08,$02,$BC,$00,$00,$00,$00,$00,$18,$FF,$F9,$00,$00
	dc.b	$00,$00,$00,$2C,$00,$00,$00,$0F,$00,$00,$00,$18,$00,$00,$00,$00
	dc.b	$00,$00,$00,$2C,$FF,$FF,$FF,$FF,$00,$00,$00,$2C,$00,$00,$00,$00
; Effect2Params - The sound parameters of PlayEffect2 (EffectSound2).
Effect2Params:
	dc.b	$00,$00,$00,$0C,$00,$0B,$00,$00,$00,$00,$00,$1C,$00,$02,$00,$00
	dc.b	$00,$00,$00,$2C,$00,$00,$00,$08,$00,$00,$00,$0C
Effect2Params_1C:
	dc.b	$00,$3E,$00,$00,$00,$00,$00,$1C
Effect2Params_24:
	dc.b	$FF,$FF,$00,$00,$00,$00,$00,$2C,$00,$00,$00,$3C,$00,$00,$00,$0C
	dc.b	$00,$00,$00,$00,$00,$00,$00,$2C,$00,$00,$00,$00
; GunParams - The sound parameters of PlayGunSound (GunSoundCopy).
GunParams:
	dc.b	$00,$00,$00,$24
GunParams_04:
	dc.b	$00,$00,$00,$01,$00,$00,$00,$0C
GunParams_0C:
	dc.b	$00,$00,$00,$00,$00,$00,$00,$1C,$00,$00,$00,$00,$00,$00,$00,$2C
	dc.b	$00,$00,$00,$02,$00,$00,$00,$0C,$00,$00,$00,$00,$00,$00,$00,$2C
	dc.b	$00,$00,$00,$01,$00,$00,$00,$40,$00,$00,$00,$08,$00,$00,$00,$08
	dc.b	$01,$18,$00,$00,$00,$00,$00,$0C,$00,$14,$00,$00,$00,$00,$00,$1C
	dc.b	$FF,$FF,$10,$00,$00,$00,$00,$2C,$00,$00,$00,$0A,$00,$00,$00,$2C
	dc.b	$00,$00,$00,$00
h086_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc
