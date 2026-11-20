; F/A-18 Interceptor - hunk 76 (code)
; The sound driver's interrupt routines (not worked out yet)
; Included by ../f18_main.s.

;===============================================================================
; Hunk 76: CODE, $1A4 bytes
;===============================================================================
	CODE_HUNK	h076

;-------------------------------------------------------------------------------
; AudioInterrupt - The audio interrupt for one channel (the four entries of dat_074_00090...):
; acknowledges it (INTREQ) and queues the channel's next piece of sound.
;-------------------------------------------------------------------------------
AudioInterrupt:
        movem.l d0-d3/a0-a4,-(a7)               ; 00000
        move.w  $16(a1),(CUSTOM+INTREQ).l       ; 00004
        movea.l $0(a1),a0                       ; 0000C
        movea.l $4(a1),a2                       ; 00010
        movea.l $0(a2),a3                       ; 00014
        cmpa.l  #$0,a3                          ; 00018
        beq.b   l_076_0005C                     ; 0001E
        move.l  $0(a3),$0(a0)                   ; 00020
        move.l  $4(a3),d0                       ; 00026
        asr.l   #$1,d0                          ; 0002A
        move.w  d0,$4(a0)                       ; 0002C
        move.w  $10(a1),(CUSTOM+DMACON).l       ; 00030
        jsr     (AudioSetPeriod).l              ; 00038
        cmpi.l  #$ffffffff,$10(a3)              ; 0003E
        beq.b   l_076_0007A                     ; 00046
        subq.l  #$1,$10(a3)                     ; 00048
        bpl.b   l_076_0007A                     ; 0004C
        move.l  $20(a3),$0(a2)                  ; 0004E
        move.l  $14(a3),$10(a3)                 ; 00054
        bra.b   l_076_0007A                     ; 0005A
l_076_0005C:
        move.w  #$0,$8(a0)                      ; 0005C
        move.w  #$7c,$6(a0)                     ; 00062
        move.w  $12(a1),(CUSTOM+DMACON).l       ; 00068
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
        movea.l $4(a1),a2                       ; 00094
        movea.l $0(a2),a3                       ; 00098
        cmpa.l  #$0,a3                          ; 0009C
        beq.b   l_076_000F4                     ; 000A2
        jsr     (AudioCountDown).l              ; 000A4
        movea.l $0(a1),a0                       ; 000AA
        jsr     (AudioSetPeriod).l              ; 000AE
        move.l  $18(a3),d0                      ; 000B4
        add.l   d0,$8(a3)                       ; 000B8
        move.l  $1c(a3),d0                      ; 000BC
        add.l   d0,$c(a3)                       ; 000C0
        cmpi.l  #$0,$38(a3)                     ; 000C4
        beq.b   l_076_000DC                     ; 000CC
        subq.l  #$1,$38(a3)                     ; 000CE
        bne.b   l_076_000DC                     ; 000D2
        move.l  #$0,$18(a3)                     ; 000D4
l_076_000DC:
        cmpi.l  #$0,$3c(a3)                     ; 000DC
        beq.b   l_076_000F4                     ; 000E4
        subq.l  #$1,$3c(a3)                     ; 000E6
        bne.b   l_076_000F4                     ; 000EA
        move.l  #$0,$1c(a3)                     ; 000EC
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
        move.l  $8(a3),d0                       ; 00108
        swap    d0                              ; 0010C
        cmpi.w  #$7c,d0                         ; 0010E
        bge.b   l_076_00118                     ; 00112
        move.w  #$7c,d0                         ; 00114
l_076_00118:
        move.w  d0,$6(a0)                       ; 00118
        move.l  $c(a3),d0                       ; 0011C
        swap    d0                              ; 00120
        andi.w  #$3f,d0                         ; 00122
        cmp.w   (dat_074_000FE).l,d0            ; 00126
        ble.b   l_076_00134                     ; 0012C
        move.w  (dat_074_000FE).l,d0            ; 0012E
l_076_00134:
        move.w  d0,$8(a0)                       ; 00134
        rts                                     ; 00138

;-------------------------------------------------------------------------------
; AudioCountDown - Counts down a channel's sound length and moves to its next part.
;-------------------------------------------------------------------------------
AudioCountDown:
        cmpi.l  #$0,$2c(a3)                     ; 0013A
        beq.b   l_076_001A2                     ; 00142
        subq.l  #$1,$2c(a3)                     ; 00144
        bne.b   l_076_001A2                     ; 00148
        movea.l $34(a3),a0                      ; 0014A
l_076_0014E:
        adda.l  $30(a3),a0                      ; 0014E
l_076_00152:
        movea.l (a0)+,a4                        ; 00152
        move.l  (a0)+,d0                        ; 00154
        cmpa.l  #$2c,a4                         ; 00156
        bge.b   l_076_00166                     ; 0015C
        adda.l  a3,a4                           ; 0015E
        move.l  d0,$0(a4)                       ; 00160
        bra.b   l_076_00152                     ; 00164
l_076_00166:
        beq.b   l_076_00182                     ; 00166
        move.w  a4,d1                           ; 00168
        subi.w  #$40,d1                         ; 0016A
        cmpi.l  #$0,$24(a3,d1.w)                ; 0016E
        beq.b   l_076_0017E                     ; 00176
        subq.l  #$1,$24(a3,d1.w)                ; 00178
        beq.b   l_076_00152                     ; 0017C
l_076_0017E:
        movea.l d0,a0                           ; 0017E
        bra.b   l_076_0014E                     ; 00180
l_076_00182:
        move.l  d0,$2c(a3)                      ; 00182
        suba.l  $30(a3),a0                      ; 00186
        move.l  a0,$34(a3)                      ; 0018A
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
