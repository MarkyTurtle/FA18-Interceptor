; F/A-18 Interceptor - hunk 86 (code)
; Data: the sound effects' scripts (EffectParams, SweepParams, GearParams, Effect2Params,
; GunParams): see Sound in hunk 81.
; Included by ../f18_main.s.

;===============================================================================
; Hunk 86: CODE, $158 bytes
;===============================================================================
	CODE_HUNK	h086
; EffectParams - EffectSound's script (PlayEffect sets the named values on each call): Period
; and Volume for Time frames, then Period2 and Volume2 for Time2, that Repeats2 times; then a
; pause of Time3, the whole Repeats times. (Each name is the value of the pair on its line.)
EffectParams:
EffectRepeats           equ     *+4
        dc.l    snd_Loop1,5                     ; 00000
EffectRepeats2          equ     *+4
        dc.l    snd_Loop2,3                     ; 00008
EffectPeriod            equ     *+4
        dc.l    snd_Period,$8C<<16              ; 00010
EffectVolume            equ     *+4
        dc.l    snd_Volume,$28<<16              ; 00018
EffectTime              equ     *+4
        dc.l    SND_WAIT,5                      ; 00020 (frames; 0 ends)
EffectPeriod2           equ     *+4
        dc.l    snd_Period,$8C<<16              ; 00028
EffectVolume2           equ     *+4
        dc.l    snd_Volume,$0<<16               ; 00030
EffectTime2             equ     *+4
        dc.l    SND_WAIT,1                      ; 00038 (frames; 0 ends)
        dc.l    SND_LOOP2,$10                   ; 00040 (to +$10 while it counts)
EffectTime3             equ     *+4
        dc.l    SND_WAIT,5                      ; 00048 (frames; 0 ends)
        dc.l    SND_LOOP1,$8                    ; 00050 (to +$8 while it counts)
        dc.l    SND_WAIT,0                      ; 00058 (frames; 0 ends)
; SweepParams - SweepSound's script (PlaySweep): a fade from SweepVolume over SweepTime frames.
SweepParams:
SweepVolume             equ     *+4
        dc.l    snd_Volume,$3C<<16              ; 00060
SweepVolumeStep         equ     *+4
        dc.l    snd_VolumeStep,-$1<<16          ; 00068
SweepTime               equ     *+4
        dc.l    SND_WAIT,60                     ; 00070 (frames; 0 ends)
        dc.l    snd_Volume,$0<<16               ; 00078
        dc.l    SND_WAIT,0                      ; 00080 (frames; 0 ends)
; GearParams - GearSample's script (PlayGearSound): the period falls from $2BC for 15 frames,
; then holds.
GearParams:
        dc.l    snd_Period,$2BC<<16             ; 00088
        dc.l    snd_PeriodStep,-$7<<16          ; 00090
        dc.l    SND_WAIT,15                     ; 00098 (frames; 0 ends)
        dc.l    snd_PeriodStep,$0<<16           ; 000A0
        dc.l    SND_WAIT,-1                     ; 000A8 (frames; 0 ends)
        dc.l    SND_WAIT,0                      ; 000B0 (frames; 0 ends)
; Effect2Params - EffectSound2's script (PlayEffect2): rises for 8 frames, then fades from
; Effect2Volume over 60.
Effect2Params:
        dc.l    snd_Volume,$B<<16               ; 000B8
        dc.l    snd_VolumeStep,$2<<16           ; 000C0
        dc.l    SND_WAIT,8                      ; 000C8 (frames; 0 ends)
Effect2Volume           equ     *+4
        dc.l    snd_Volume,$3E<<16              ; 000D0
Effect2VolumeStep       equ     *+4
        dc.l    snd_VolumeStep,-$1<<16          ; 000D8
        dc.l    SND_WAIT,60                     ; 000E0 (frames; 0 ends)
        dc.l    snd_Volume,$0<<16               ; 000E8
        dc.l    SND_WAIT,0                      ; 000F0 (frames; 0 ends)
; GunParams - GunSoundCopy's script (PlayGunSound): GunRepeats bursts of silence and
; GunVolume, then a lower shot that fades.
GunParams:
GunRepeats              equ     *+4
        dc.l    snd_Loop1,1                     ; 000F8
GunVolume               equ     *+4
        dc.l    snd_Volume,$0<<16               ; 00100
        dc.l    snd_VolumeStep,$0<<16           ; 00108
        dc.l    SND_WAIT,2                      ; 00110 (frames; 0 ends)
        dc.l    snd_Volume,$0<<16               ; 00118
        dc.l    SND_WAIT,1                      ; 00120 (frames; 0 ends)
        dc.l    SND_LOOP1,$8                    ; 00128 (to +$8 while it counts)
        dc.l    snd_Period,$118<<16             ; 00130
        dc.l    snd_Volume,$14<<16              ; 00138
        dc.l    snd_VolumeStep,-61440           ; 00140
        dc.l    SND_WAIT,10                     ; 00148 (frames; 0 ends)
        dc.l    SND_WAIT,0                      ; 00150 (frames; 0 ends)
h086_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc
