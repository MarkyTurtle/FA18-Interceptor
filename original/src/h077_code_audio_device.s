; F/A-18 Interceptor - hunk 77 (code)
; InitSound / CloseSound: audio.device and the game's audio interrupts.
; Included by ../f18_main.s.

;===============================================================================
; Hunk 77: CODE, $158 bytes
;===============================================================================
	CODE_HUNK	h077

;-------------------------------------------------------------------------------
; InitSound - Opens audio.device (allocating the four channels: a port and an IOAudio request)
; and installs the game's own audio interrupts and vertical blank server (AudioInstall,
; AddSoundVBlank). Returns 0 if audio.device did not open.
;-------------------------------------------------------------------------------
InitSound:
        tst.l   (InitSoundData2).l              ; 00000
        bne.b   l_077_00030                     ; 00006
        move.l  #$10002,-(a7)                   ; 00008
        moveq   #$44,d0                         ; 0000E
        move.l  d0,-(a7)                        ; 00010
        jsr     (_AllocMem).l                   ; 00012
        addq.l  #$8,a7                          ; 00018
        move.l  d0,(AudioRequest).l             ; 0001A
        tst.l   d0                              ; 00020
        bne.b   l_077_00028                     ; 00022
        moveq   #$1,d0                          ; 00024
        rts                                     ; 00026
l_077_00028:
        moveq   #$1,d0                          ; 00028
        move.l  d0,(InitSoundData2).l           ; 0002A
l_077_00030:
        tst.l   (InitSoundData3).l              ; 00030
        bne.b   l_077_0006E                     ; 00036
        movea.l (AudioRequest).l,a0             ; 00038
        move.b  #$7f,$9(a0)                     ; 0003E
        clr.l   -(a7)                           ; 00044
        pea.l   (StrPortName).l                 ; 00046
        jsr     (_CreatePort).l                 ; 0004C
        addq.l  #$8,a7                          ; 00052
        movea.l (AudioRequest).l,a0             ; 00054
        move.l  d0,$e(a0)                       ; 0005A
        tst.l   d0                              ; 0005E
        bne.b   l_077_00066                     ; 00060
        moveq   #$2,d0                          ; 00062
        rts                                     ; 00064
l_077_00066:
        moveq   #$1,d0                          ; 00066
        move.l  d0,(InitSoundData3).l           ; 00068
l_077_0006E:
        tst.l   (InitSoundData4).l              ; 0006E
        bne.b   l_077_000BC                     ; 00074
        movea.l (AudioRequest).l,a0             ; 00076
        move.l  #InitSoundData1,$22(a0)         ; 0007C
        moveq   #$1,d0                          ; 00084
        movea.l (AudioRequest).l,a0             ; 00086
        move.l  d0,$26(a0)                      ; 0008C
        moveq   #$0,d0                          ; 00090
        move.l  d0,-(a7)                        ; 00092
        move.l  (AudioRequest).l,-(a7)          ; 00094
        move.l  d0,-(a7)                        ; 0009A
        pea.l   (StrAudioDevice).l              ; 0009C
        jsr     (_OpenDevice).l                 ; 000A2
        lea.l   $10(a7),a7                      ; 000A8
        tst.l   d0                              ; 000AC
        beq.b   l_077_000B4                     ; 000AE
        moveq   #$3,d0                          ; 000B0
        rts                                     ; 000B2
l_077_000B4:
        moveq   #$1,d0                          ; 000B4
        move.l  d0,(InitSoundData4).l           ; 000B6
l_077_000BC:
        tst.l   (AudioDeviceOpen).l             ; 000BC
        bne.b   l_077_000D8                     ; 000C2
        jsr     (AudioInstall).l                ; 000C4
        jsr     (AddSoundVBlank).l              ; 000CA
        moveq   #$1,d0                          ; 000D0
        move.l  d0,(AudioDeviceOpen).l          ; 000D2
l_077_000D8:
        moveq   #$0,d0                          ; 000D8
        rts                                     ; 000DA

;-------------------------------------------------------------------------------
; CloseSound - Gives the audio channels back (AudioRemove, RemSoundVBlank) and closes
; audio.device.
;-------------------------------------------------------------------------------
CloseSound:
        tst.l   (AudioDeviceOpen).l             ; 000DC
        beq.b   l_077_000F6                     ; 000E2
        jsr     (AudioRemove).l                 ; 000E4
        jsr     (RemSoundVBlank).l              ; 000EA
        clr.l   (AudioDeviceOpen).l             ; 000F0
l_077_000F6:
        tst.l   (InitSoundData4).l              ; 000F6
        beq.b   l_077_00112                     ; 000FC
        move.l  (AudioRequest).l,-(a7)          ; 000FE
        jsr     (_CloseDevice).l                ; 00104
        addq.l  #$4,a7                          ; 0010A
        clr.l   (InitSoundData4).l              ; 0010C
l_077_00112:
        tst.l   (InitSoundData3).l              ; 00112
        beq.b   l_077_00132                     ; 00118
        movea.l (AudioRequest).l,a0             ; 0011A
        move.l  $e(a0),-(a7)                    ; 00120
        jsr     (_DeletePort).l                 ; 00124
        addq.l  #$4,a7                          ; 0012A
        clr.l   (InitSoundData3).l              ; 0012C
l_077_00132:
        tst.l   (InitSoundData2).l              ; 00132
        beq.b   l_077_00152                     ; 00138
        moveq   #$44,d0                         ; 0013A
        move.l  d0,-(a7)                        ; 0013C
        move.l  (AudioRequest).l,-(a7)          ; 0013E
        jsr     (_FreeMem).l                    ; 00144
        addq.l  #$8,a7                          ; 0014A
        clr.l   (InitSoundData2).l              ; 0014C
l_077_00152:
        moveq   #$0,d0                          ; 00152
        rts                                     ; 00154
	dc.b	$00,$00
h077_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    19,78                           ; 19 longs pointing into hunk 78
	dc.l	$14E,$134,$12E,$114,$10E,$F8,$F2,$DE
	dc.l	$D4,$BE,$B8,$9E,$7E,$70,$6A,$48
	dc.l	$32,$2C,$2
        dc.l    9,79                            ; 9 longs pointing into hunk 79
	dc.l	$140,$11C,$100,$96,$88,$78,$56,$3A
	dc.l	$1C
        dc.l    1,172                           ; 1 longs pointing into hunk 172
	dc.l	$14
        dc.l    2,175                           ; 2 longs pointing into hunk 175
	dc.l	$4E,$126
        dc.l    1,172                           ; 1 longs pointing into hunk 172
	dc.l	$A4
        dc.l    4,75                            ; 4 longs pointing into hunk 75
	dc.l	$C6,$CC,$E6,$EC
        dc.l    1,172                           ; 1 longs pointing into hunk 172
	dc.l	$106
        dc.l    1,172                           ; 1 longs pointing into hunk 172
	dc.l	$146
	dc.l	0
	dc.l	HUNK_END
	endc
