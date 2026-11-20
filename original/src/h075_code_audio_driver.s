; F/A-18 Interceptor - hunk 75 (code)
; The sound driver: audio DMA and interrupt control, installing the audio interrupts.
; Included by ../f18_main.s.

;===============================================================================
; Hunk 75: CODE, $194 bytes
;===============================================================================
	CODE_HUNK	h075

;-------------------------------------------------------------------------------
; AudioStopDMA - AudioStopDMA(channel): writes the channel's DMACON "off" bits (stops its
; sound).
;-------------------------------------------------------------------------------
AudioStopDMA:
        move.l  $4(a7),d0                       ; 00000
        asl.l   #$2,d0                          ; 00004
        lea.l   (AudioChannels).l,a0            ; 00006
        movea.l (a0,d0.w),a0                    ; 0000C
        move.w  $10(a0),$dff096.l               ; 00010
        rts                                     ; 00018

;-------------------------------------------------------------------------------
; AudioStartDMA - AudioStartDMA(channel): writes the channel's DMACON "on" bits.
;-------------------------------------------------------------------------------
AudioStartDMA:
        move.l  $4(a7),d0                       ; 0001A
        asl.l   #$2,d0                          ; 0001E
        lea.l   (AudioChannels).l,a0            ; 00020
        movea.l (a0,d0.w),a0                    ; 00026
        move.w  $12(a0),(CUSTOM+DMACON).l       ; 0002A
        rts                                     ; 00032

;-------------------------------------------------------------------------------
; AudioIntOn - AudioIntOn(channel): clears and enables the channel's audio interrupt (INTREQ,
; INTENA).
;-------------------------------------------------------------------------------
AudioIntOn:
        move.l  $4(a7),d0                       ; 00034
        asl.l   #$2,d0                          ; 00038
        lea.l   (AudioChannels).l,a0            ; 0003A
        movea.l (a0,d0.w),a0                    ; 00040
        move.w  $16(a0),(CUSTOM+INTREQ).l       ; 00044
        move.w  $14(a0),(CUSTOM+INTENA).l       ; 0004C
        rts                                     ; 00054

;-------------------------------------------------------------------------------
; AudioIntOff - AudioIntOff(channel): disables and clears the channel's audio interrupt.
;-------------------------------------------------------------------------------
AudioIntOff:
        move.l  $4(a7),d0                       ; 00056
        asl.l   #$2,d0                          ; 0005A
        lea.l   (AudioChannels).l,a0            ; 0005C
        movea.l (a0,d0.w),a0                    ; 00062
        move.w  $16(a0),(CUSTOM+INTENA).l       ; 00066
        move.w  $16(a0),(CUSTOM+INTREQ).l       ; 0006E
        rts                                     ; 00076

;-------------------------------------------------------------------------------
; AudioIntAck - AudioIntAck(channel): acknowledges the channel's audio interrupt (INTREQ).
;-------------------------------------------------------------------------------
AudioIntAck:
        move.l  $4(a7),d0                       ; 00078
AudioIntAck_d0:
        asl.l   #$2,d0                          ; 0007C
        lea.l   (AudioChannels).l,a0            ; 0007E
        movea.l (a0,d0.w),a0                    ; 00084
        move.w  $14(a0),(CUSTOM+INTREQ).l       ; 00088
        rts                                     ; 00090

;-------------------------------------------------------------------------------
; AudioSetVector - Installs the channel's audio interrupt handler (exec SetIntVector, its
; interrupt number), keeping the old one.
;-------------------------------------------------------------------------------
AudioSetVector:
        movem.l d0-d7/a0-a6,-(a7)               ; 00092
        asl.l   #$2,d0                          ; 00096
        lea.l   (AudioChannels).l,a0            ; 00098
        movea.l (a0,d0.w),a2                    ; 0009E
        move.l  a2,-(a7)                        ; 000A2
        move.l  $c(a2),d0                       ; 000A4
        movea.l $8(a2),a1                       ; 000A8
        movea.l $4.w,a6                         ; 000AC
        movea.l a6,a0                           ; 000B0
        adda.l  #$ffffff5e,a0                   ; 000B2
        jsr     (a0)                            ; 000B8
        movea.l (a7)+,a2                        ; 000BA
        move.l  d0,$18(a2)                      ; 000BC
        movem.l (a7)+,d0-d7/a0-a6               ; 000C0
        rts                                     ; 000C4

;-------------------------------------------------------------------------------
; AudioRestoreVector - Puts the channel's old audio interrupt handler back (exec SetIntVector).
;-------------------------------------------------------------------------------
AudioRestoreVector:
        movem.l d0-d7/a0-a6,-(a7)               ; 000C6
        asl.l   #$2,d0                          ; 000CA
        lea.l   (AudioChannels).l,a0            ; 000CC
        movea.l (a0,d0.w),a2                    ; 000D2
        move.l  $c(a2),d0                       ; 000D6
        movea.l $18(a2),a1                      ; 000DA
        movea.l $4.w,a6                         ; 000DE
        movea.l a6,a0                           ; 000E2
        adda.l  #$ffffff5e,a0                   ; 000E4
        jsr     (a0)                            ; 000EA
        movem.l (a7)+,d0-d7/a0-a6               ; 000EC
        rts                                     ; 000F0

;-------------------------------------------------------------------------------
; AddSoundVBlank - Adds the sound's vertical blank interrupt server (exec AddIntServer,
; INTB_VERTB, SoundVBlankNode).
;-------------------------------------------------------------------------------
AddSoundVBlank:
        movem.l d0-d7/a0-a6,-(a7)               ; 000F2
        move.w  #$5,d0                          ; 000F6
        lea.l   (SoundVBlankNode).l,a1          ; 000FA
        movea.l $4.w,a6                         ; 00100
        movea.l a6,a0                           ; 00104
        adda.l  #$ffffff58,a0                   ; 00106
        jsr     (a0)                            ; 0010C
        movem.l (a7)+,d0-d7/a0-a6               ; 0010E
        rts                                     ; 00112

;-------------------------------------------------------------------------------
; RemSoundVBlank - Removes the sound's vertical blank interrupt server (exec RemIntServer).
;-------------------------------------------------------------------------------
RemSoundVBlank:
        movem.l d0-d7/a0-a6,-(a7)               ; 00114
        move.w  #$5,d0                          ; 00118
        lea.l   (SoundVBlankNode).l,a1          ; 0011C
        movea.l $4.w,a6                         ; 00122
        movea.l a6,a0                           ; 00126
        adda.l  #$ffffff52,a0                   ; 00128
        jsr     (a0)                            ; 0012E
        movem.l (a7)+,d0-d7/a0-a6               ; 00130
        rts                                     ; 00134

;-------------------------------------------------------------------------------
; AudioStartAll - AudioStartDMA on channels 3-0.
;-------------------------------------------------------------------------------
AudioStartAll:
        moveq   #$3,d0                          ; 00136
l_075_00138:
        move.l  d0,-(a7)                        ; 00138
        jsr     AudioStartDMA(pc)               ; 0013A
        move.l  (a7)+,d0                        ; 0013E
        subq.l  #$1,d0                          ; 00140
        bge.b   l_075_00138                     ; 00142
        rts                                     ; 00144

;-------------------------------------------------------------------------------
; AudioIntOnAll - AudioIntOn on channels 3-0.
;-------------------------------------------------------------------------------
AudioIntOnAll:
        moveq   #$3,d0                          ; 00146
l_075_00148:
        move.l  d0,-(a7)                        ; 00148
        jsr     AudioIntOn(pc)                  ; 0014A
        move.l  (a7)+,d0                        ; 0014E
        subq.l  #$1,d0                          ; 00150
        bge.b   l_075_00148                     ; 00152
        rts                                     ; 00154

;-------------------------------------------------------------------------------
; AudioIntOffAll - AudioIntOff on channels 3-0.
;-------------------------------------------------------------------------------
AudioIntOffAll:
        moveq   #$3,d0                          ; 00156
l_075_00158:
        move.l  d0,-(a7)                        ; 00158
        jsr     AudioIntOff(pc)                 ; 0015A
        move.l  (a7)+,d0                        ; 0015E
        subq.l  #$1,d0                          ; 00160
        bge.b   l_075_00158                     ; 00162
        rts                                     ; 00164

;-------------------------------------------------------------------------------
; AudioInstall - Takes over the four audio channels: their interrupts off, the game's handlers
; in (AudioSetVector), the interrupts on.
;-------------------------------------------------------------------------------
AudioInstall:
        jsr     AudioIntOffAll(pc)              ; 00166
        moveq   #$3,d0                          ; 0016A
l_075_0016C:
        move.l  d0,-(a7)                        ; 0016C
        jsr     AudioSetVector(pc)              ; 0016E
        move.l  (a7)+,d0                        ; 00172
        subq.l  #$1,d0                          ; 00174
        bge.b   l_075_0016C                     ; 00176
        jsr     AudioIntOnAll(pc)               ; 00178
        rts                                     ; 0017C

;-------------------------------------------------------------------------------
; AudioRemove - Gives the audio channels back: interrupts off, the old handlers back.
;-------------------------------------------------------------------------------
AudioRemove:
        jsr     AudioIntOffAll(pc)              ; 0017E
        moveq   #$3,d0                          ; 00182
l_075_00184:
        move.l  d0,-(a7)                        ; 00184
        jsr     AudioRestoreVector(pc)          ; 00186
        move.l  (a7)+,d0                        ; 0018A
        subq.l  #$1,d0                          ; 0018C
        bge.b   l_075_00184                     ; 0018E
        rts                                     ; 00190
	dc.b	$00,$00
h075_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    9,74                            ; 9 longs pointing into hunk 74
	dc.l	$FC,$11E,$8,$22,$3C,$5E,$80,$9A
	dc.l	$CE
	dc.l	0
	dc.l	HUNK_END
	endc
