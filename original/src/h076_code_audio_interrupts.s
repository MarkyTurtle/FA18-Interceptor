; F/A-18 Interceptor - hunk 76 (code)
; The sound driver's interrupt routines: each channel's audio interrupt, and the vertical blank
; routine that steps the sounds (their period and volume slides and their scripts).
; Included by ../f18_main.s.

;===============================================================================
; Hunk 76: CODE, $1A4 bytes
;===============================================================================
	CODE_HUNK	h076

;-------------------------------------------------------------------------------
; AudioInterrupt - The audio interrupt for one channel (a1 = its descriptor, from Channel0Int's
; is_Data...): acknowledges it (INTREQ) and queues the sample again; when its repeats run out,
; the channel goes on to snd_Next; with no sound, silence and its DMA off.
;-------------------------------------------------------------------------------
AudioInterrupt:
        movem.l d0-d3/a0-a4,-(a7)               ; 00000
        move.w  chan_IntBit(a1),(CUSTOM+INTREQ).l ; 00004
        movea.l chan_Regs(a1),a0                ; 0000C
        movea.l chan_Sound(a1),a2               ; 00010
        movea.l $0(a2),a3                       ; 00014
        cmpa.l  #$0,a3                          ; 00018
        beq.b   l_076_0005C                     ; 0001E
        move.l  snd_Data(a3),ac_ptr(a0)         ; 00020
        move.l  snd_Length(a3),d0               ; 00026
        asr.l   #$1,d0                          ; 0002A
        move.w  d0,ac_len(a0)                   ; 0002C
        move.w  chan_DMAOn(a1),(CUSTOM+DMACON).l ; 00030
        jsr     (AudioSetPeriod).l              ; 00038
        cmpi.l  #$ffffffff,snd_Repeats(a3)      ; 0003E
        beq.b   l_076_0007A                     ; 00046
        subq.l  #$1,snd_Repeats(a3)             ; 00048
        bpl.b   l_076_0007A                     ; 0004C
        move.l  snd_Next(a3),$0(a2)             ; 0004E
        move.l  snd_RepeatsSet(a3),snd_Repeats(a3) ; 00054
        bra.b   l_076_0007A                     ; 0005A
l_076_0005C:
        move.w  #$0,ac_vol(a0)                  ; 0005C
        move.w  #$7c,ac_per(a0)                 ; 00062
        move.w  chan_DMAOff(a1),(CUSTOM+DMACON).l ; 00068
        move.w  #$190,d0                        ; 00070
l_076_00074:
        subi.w  #$1,d0                          ; 00074
        bne.b   l_076_00074                     ; 00078
l_076_0007A:
        movem.l (a7)+,d0-d3/a0-a4               ; 0007A
        rts                                     ; 0007E

;-------------------------------------------------------------------------------
; AudioVBlank - The sound driver's vertical-blank routine: steps each channel's sound
; (AudioChannels), its period and volume changes.
;-------------------------------------------------------------------------------
AudioVBlank:
        movem.l d0-d3/a0-a4,-(a7)               ; 00080
        moveq   #$0,d3                          ; 00084
        lea.l   (AudioChannels).l,a0            ; 00086
l_076_0008C:
        move.l  a0,-(a7)                        ; 0008C
        move.w  d3,-(a7)                        ; 0008E
        movea.l $0(a0),a1                       ; 00090
        movea.l chan_Sound(a1),a2               ; 00094
        movea.l $0(a2),a3                       ; 00098
        cmpa.l  #$0,a3                          ; 0009C
        beq.b   l_076_000F4                     ; 000A2
        jsr     (AudioCountDown).l              ; 000A4
        movea.l chan_Regs(a1),a0                ; 000AA
        jsr     (AudioSetPeriod).l              ; 000AE
        move.l  snd_PeriodStep(a3),d0           ; 000B4
        add.l   d0,snd_Period(a3)               ; 000B8
        move.l  snd_VolumeStep(a3),d0           ; 000BC
        add.l   d0,snd_Volume(a3)               ; 000C0
        cmpi.l  #$0,snd_PeriodSteps(a3)         ; 000C4
        beq.b   l_076_000DC                     ; 000CC
        subq.l  #$1,snd_PeriodSteps(a3)         ; 000CE
        bne.b   l_076_000DC                     ; 000D2
        move.l  #$0,snd_PeriodStep(a3)          ; 000D4
l_076_000DC:
        cmpi.l  #$0,snd_VolumeSteps(a3)         ; 000DC
        beq.b   l_076_000F4                     ; 000E4
        subq.l  #$1,snd_VolumeSteps(a3)         ; 000E6
        bne.b   l_076_000F4                     ; 000EA
        move.l  #$0,snd_VolumeStep(a3)          ; 000EC
l_076_000F4:
        move.w  (a7)+,d3                        ; 000F4
        movea.l (a7)+,a0                        ; 000F6
        addq.l  #$4,a0                          ; 000F8
        addq.w  #$1,d3                          ; 000FA
        cmpi.w  #$4,d3                          ; 000FC
        bne.b   l_076_0008C                     ; 00100
        movem.l (a7)+,d0-d3/a0-a4               ; 00102
        rts                                     ; 00106

;-------------------------------------------------------------------------------
; AudioSetPeriod - Sets a channel's period (at least $7C).
;-------------------------------------------------------------------------------
AudioSetPeriod:
        move.l  snd_Period(a3),d0               ; 00108
        swap    d0                              ; 0010C
        cmpi.w  #$7c,d0                         ; 0010E
        bge.b   l_076_00118                     ; 00112
        move.w  #$7c,d0                         ; 00114
l_076_00118:
        move.w  d0,ac_per(a0)                   ; 00118
        move.l  snd_Volume(a3),d0               ; 0011C
        swap    d0                              ; 00120
        andi.w  #$3f,d0                         ; 00122
        cmp.w   (AudioPeriodMin).l,d0           ; 00126
        ble.b   l_076_00134                     ; 0012C
        move.w  (AudioPeriodMin).l,d0           ; 0012E
l_076_00134:
        move.w  d0,ac_vol(a0)                   ; 00134
        rts                                     ; 00138

;-------------------------------------------------------------------------------
; AudioCountDown - Runs a sound's script (a3) when its snd_Wait runs out: stores each (field,
; value) pair into the sound until a SND_WAIT pair (the frames to wait; 0 ends the sound and
; frees the channel) or a loop (SND_LOOP1 / SND_LOOP2: back to the offset given while the
; counter counts down).
;-------------------------------------------------------------------------------
AudioCountDown:
        cmpi.l  #$0,snd_Wait(a3)                ; 0013A
        beq.b   l_076_001A2                     ; 00142
        subq.l  #$1,snd_Wait(a3)                ; 00144
        bne.b   l_076_001A2                     ; 00148
        movea.l snd_ScriptPos(a3),a0            ; 0014A
l_076_0014E:
        adda.l  snd_Script(a3),a0               ; 0014E
l_076_00152:
        movea.l (a0)+,a4                        ; 00152
        move.l  (a0)+,d0                        ; 00154
        cmpa.l  #SND_WAIT,a4                    ; 00156
        bge.b   l_076_00166                     ; 0015C
        adda.l  a3,a4                           ; 0015E
        move.l  d0,$0(a4)                       ; 00160
        bra.b   l_076_00152                     ; 00164
l_076_00166:
        beq.b   l_076_00182                     ; 00166
        move.w  a4,d1                           ; 00168
        subi.w  #SND_LOOP1,d1                   ; 0016A
        cmpi.l  #$0,snd_Loop1(a3,d1.w)          ; 0016E
        beq.b   l_076_0017E                     ; 00176
        subq.l  #$1,snd_Loop1(a3,d1.w)          ; 00178
        beq.b   l_076_00152                     ; 0017C
l_076_0017E:
        movea.l d0,a0                           ; 0017E
        bra.b   l_076_0014E                     ; 00180
l_076_00182:
        move.l  d0,snd_Wait(a3)                 ; 00182
        suba.l  snd_Script(a3),a0               ; 00186
        move.l  a0,snd_ScriptPos(a3)            ; 0018A
        cmpi.l  #$0,d0                          ; 0018E
        bne.b   l_076_001A2                     ; 00194
        move.l  d0,$0(a2)                       ; 00196
        move.l  d3,d0                           ; 0019A
        jsr     (AudioIntAck_d0).l              ; 0019C
l_076_001A2:
        rts                                     ; 001A2
h076_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    3,76                            ; 3 longs pointing into hunk 76
	dc.l	$B0,$A6,$3A
        dc.l    3,74                            ; 3 longs pointing into hunk 74
	dc.l	$128,$130,$88
        dc.l    1,75                            ; 1 longs pointing into hunk 75
	dc.l	$19E
	dc.l	0
	dc.l	HUNK_END
	endc
