; F/A-18 Interceptor - hunk 20 (code)
; Numbers into text (BinToBCD, PutNumber), the flight log page (ShowFlightLog, ShowLogDate),
; ChecksumPlanes.
; Included by ../f18_main.s.

;===============================================================================
; Hunk 20: CODE, $CB0 bytes
;===============================================================================
	CODE_HUNK	h020

;-------------------------------------------------------------------------------
; ChecksumPlanes - ChecksumPlanes(plane0-3, width, height): the sum of every word of four
; bitplanes, each rotated left 2 bits first (16 bits). main checks the title picture with it
; ($C560 for the original picture: only then does the title sequence play) and keeps the panel
; and front pictures' sums too.
;-------------------------------------------------------------------------------
ChecksumPlanes:
        link.w  a6,#$0                          ; 00000
        movea.l $8(a6),a0                       ; 00004
        movea.l $c(a6),a1                       ; 00008
        movea.l $10(a6),a2                      ; 0000C
        movea.l $14(a6),a3                      ; 00010
        move.l  $18(a6),d1                      ; 00014
        lsr.w   #$4,d1                          ; 00018
        move.l  $1c(a6),d2                      ; 0001A
        mulu.w  d2,d1                           ; 0001E
        subq.w  #$1,d1                          ; 00020
        move.w  d1,d2                           ; 00022
        moveq   #$0,d0                          ; 00024
l_020_00026:
        move.w  (a0)+,d3                        ; 00026
        rol.w   #$2,d3                          ; 00028
        add.w   d3,d0                           ; 0002A
        dbra    d1,l_020_00026                  ; 0002C
        move.w  d2,d1                           ; 00030
l_020_00032:
        move.w  (a1)+,d3                        ; 00032
        rol.w   #$2,d3                          ; 00034
        add.w   d3,d0                           ; 00036
        dbra    d1,l_020_00032                  ; 00038
        move.w  d2,d1                           ; 0003C
l_020_0003E:
        move.w  (a2)+,d3                        ; 0003E
        rol.w   #$2,d3                          ; 00040
        add.w   d3,d0                           ; 00042
        dbra    d1,l_020_0003E                  ; 00044
        move.w  d2,d1                           ; 00048
l_020_0004A:
        move.w  (a3)+,d3                        ; 0004A
        rol.w   #$2,d3                          ; 0004C
        add.w   d3,d0                           ; 0004E
        dbra    d1,l_020_0004A                  ; 00050
        unlk    a6                              ; 00054
        rts                                     ; 00056
; MonthNames - SEPTEMBER, OCTOBER, NOVEMBER, DECEMBER, 9 characters each, stored back to front
; (copied backwards into the text).
MonthNames:
	dc.b	'REBMETPES  REBOTCO REBMEVON REBMECED'

;-------------------------------------------------------------------------------
; ShowLogDate - Puts the log's date into the briefing text (dat_064_01096: "DATE: SEPTEMBER 6,
; 1994"): one day for each hour of flight time (ConfigBuffer+$08 / 3600), from September 1st:
; month = hours / 32 from the reversed month names at dat_020_00058, day = hours % 32 + 1 (at
; most 30).
;-------------------------------------------------------------------------------
ShowLogDate:
        movea.l (ConfigBuffer).l,a0             ; 0007C
        move.l  $8(a0),d0                       ; 00082
        divu.w  #$e10,d0                        ; 00086
        move.w  d0,d2                           ; 0008A
        lea.l   MonthNames(pc),a0               ; 0008C
        moveq   #$9,d1                          ; 00090
        cmpi.w  #$7f,d0                         ; 00092
        ble.b   l_020_0009A                     ; 00096
        moveq   #$7f,d0                         ; 00098
l_020_0009A:
        lsr.w   #$5,d0                          ; 0009A
        subq.w  #$1,d0                          ; 0009C
        blt.b   l_020_000A6                     ; 0009E
l_020_000A0:
        adda.w  d1,a0                           ; 000A0
        dbra    d0,l_020_000A0                  ; 000A2
l_020_000A6:
        lea.l   (dat_064_01096).l,a1            ; 000A6
        adda.w  #$15,a1                         ; 000AC
        subq.w  #$1,d1                          ; 000B0
l_020_000B2:
        move.b  (a0)+,-(a1)                     ; 000B2
        dbra    d1,l_020_000B2                  ; 000B4
        move.w  d2,d0                           ; 000B8
        andi.w  #$1f,d0                         ; 000BA
        addq.w  #$1,d0                          ; 000BE
        cmpi.w  #$1e,d0                         ; 000C0
        ble.b   l_020_000C8                     ; 000C4
        moveq   #$1e,d0                         ; 000C6
l_020_000C8:
        lea.l   (dat_064_01096).l,a0            ; 000C8
        ext.l   d0                              ; 000CE
        moveq   #$15,d3                         ; 000D0
        moveq   #$2,d2                          ; 000D2
        bsr.w   PutNumber                       ; 000D4
        rts                                     ; 000D8

;-------------------------------------------------------------------------------
; ShowFlightLog - Writes the flight log's figures (ConfigBuffer) into the FLIGHT LOG STATISTICS
; page (hunk 64's text): missions started and completed, cannon / AMRAAM / Sidewinder fired and
; hits, the flight time (hours, minutes), crashes, hits from missiles.
;-------------------------------------------------------------------------------
ShowFlightLog:
        moveq   #$0,d0                          ; 000DA
        movea.l (ConfigBuffer).l,a1             ; 000DC
        move.w  $36(a1),d0                      ; 000E2
        lea.l   (dat_064_00858).l,a0            ; 000E6
        moveq   #$25,d3                         ; 000EC
        moveq   #$3,d2                          ; 000EE
        bsr.w   PutNumber                       ; 000F0
        move.w  $38(a1),d0                      ; 000F4
        lea.l   (dat_064_00883).l,a0            ; 000F8
        moveq   #$25,d3                         ; 000FE
        moveq   #$3,d2                          ; 00100
        bsr.w   PutNumber                       ; 00102
        move.w  $3a(a1),d0                      ; 00106
        lea.l   (dat_064_008D9).l,a0            ; 0010A
        moveq   #$17,d3                         ; 00110
        moveq   #$5,d2                          ; 00112
        bsr.w   PutNumber                       ; 00114
        move.w  $3c(a1),d0                      ; 00118
        lea.l   (dat_064_008D9).l,a0            ; 0011C
        moveq   #$20,d3                         ; 00122
        moveq   #$4,d2                          ; 00124
        bsr.w   PutNumber                       ; 00126
        move.w  $3e(a1),d0                      ; 0012A
        lea.l   (dat_064_00901).l,a0            ; 0012E
        moveq   #$17,d3                         ; 00134
        moveq   #$5,d2                          ; 00136
        bsr.w   PutNumber                       ; 00138
        move.w  $40(a1),d0                      ; 0013C
        lea.l   (dat_064_00901).l,a0            ; 00140
        moveq   #$20,d3                         ; 00146
        moveq   #$4,d2                          ; 00148
        bsr.w   PutNumber                       ; 0014A
        move.w  $42(a1),d0                      ; 0014E
        lea.l   (dat_064_00929).l,a0            ; 00152
        moveq   #$17,d3                         ; 00158
        moveq   #$5,d2                          ; 0015A
        bsr.w   PutNumber                       ; 0015C
        move.w  $44(a1),d0                      ; 00160
        lea.l   (dat_064_00929).l,a0            ; 00164
        moveq   #$20,d3                         ; 0016A
        moveq   #$4,d2                          ; 0016C
        bsr.w   PutNumber                       ; 0016E
        move.l  $8(a1),d0                       ; 00172
        divu.w  #$e10,d0                        ; 00176
        move.l  d0,-(a7)                        ; 0017A
        ext.l   d0                              ; 0017C
        lea.l   (dat_064_00955).l,a0            ; 0017E
        moveq   #$17,d3                         ; 00184
        moveq   #$4,d2                          ; 00186
        bsr.w   PutNumber                       ; 00188
        move.l  (a7)+,d0                        ; 0018C
        swap    d0                              ; 0018E
        ext.l   d0                              ; 00190
        divu.w  #$3c,d0                         ; 00192
        ext.l   d0                              ; 00196
        lea.l   (dat_064_00955).l,a0            ; 00198
        moveq   #$21,d3                         ; 0019E
        moveq   #$2,d2                          ; 001A0
        bsr.w   PutNumber                       ; 001A2
        move.w  $46(a1),d0                      ; 001A6
        lea.l   (dat_064_0097F).l,a0            ; 001AA
        moveq   #$17,d3                         ; 001B0
        moveq   #$4,d2                          ; 001B2
        bsr.w   PutNumber                       ; 001B4
        move.w  $48(a1),d0                      ; 001B8
        lea.l   (dat_064_0099D).l,a0            ; 001BC
        moveq   #$17,d3                         ; 001C2
        moveq   #$4,d2                          ; 001C4

;-------------------------------------------------------------------------------
; PutNumber - PutNumber(d0 = value, a0 = the text line, d3 = column, d2 = digits): writes the
; value into the text in decimal.
;-------------------------------------------------------------------------------
PutNumber:
        move.l  d0,(BCDIn).l                    ; 001C6
        bsr.w   BinToBCD                        ; 001CC
        move.l  (BCDOut).l,d1                   ; 001D0
        adda.w  d3,a0                           ; 001D6
        move.l  a0,d0                           ; 001D8
        movem.l d0-d2,-(a7)                     ; 001DA
        jsr     (PutHex).l                      ; 001DE
        adda.l  #$c,a7                          ; 001E4
        moveq   #$0,d0                          ; 001EA
        movea.l (ConfigBuffer).l,a1             ; 001EC
        rts                                     ; 001F2

;-------------------------------------------------------------------------------
; SetTextPage - SetTextPage(group, slot, index): puts the text page TextGroups[group-3] [index]
; into TextPages[slot].
;-------------------------------------------------------------------------------
SetTextPage:
        link.w  a6,#$0                          ; 001F4
        lea.l   (TextPageTable).l,a0            ; 001F8
        lea.l   (TextGroups).l,a1               ; 001FE
        move.l  $8(a6),d0                       ; 00204
        subq.w  #$3,d0                          ; 00208
        add.w   d0,d0                           ; 0020A
        lea.l   (a0),a2                         ; 0020C
        adda.w  (a1,d0.w),a2                    ; 0020E
        move.l  $10(a6),d0                      ; 00212
        add.w   d0,d0                           ; 00216
        move.w  (a2,d0.w),d1                    ; 00218
        move.l  $c(a6),d0                       ; 0021C
        add.w   d0,d0                           ; 00220
        lea.l   (TextPages).l,a2                ; 00222
        move.w  d1,(a2,d0.w)                    ; 00228
        clr.w   $2(a2,d0.w)                     ; 0022C
        unlk    a6                              ; 00230
        rts                                     ; 00232
	dc.b	$4E,$75
l_020_00236:
        rts                                     ; 00236
sub_020_00238:
        tst.b   (dat_071_001A7).l               ; 00238
        beq.b   l_020_00236                     ; 0023E
        move.l  (dat_071_00038).l,d0            ; 00240
        move.l  (dat_074_000FE).l,d1            ; 00246
        cmp.l   d0,d1                           ; 0024C
        beq.b   l_020_00236                     ; 0024E
        bgt.b   l_020_00262                     ; 00250
        addi.l  #$4000,d1                       ; 00252
        cmpi.l  #$3f0000,d1                     ; 00258
        bgt.b   l_020_00276                     ; 0025E
        bra.b   l_020_0026A                     ; 00260
l_020_00262:
        subi.l  #$4000,d1                       ; 00262
        blt.b   l_020_00272                     ; 00268
l_020_0026A:
        move.l  d1,(dat_074_000FE).l            ; 0026A
        rts                                     ; 00270
l_020_00272:
        moveq   #$0,d1                          ; 00272
        bra.b   l_020_0026A                     ; 00274
l_020_00276:
        move.l  #$3f0000,d1                     ; 00276
        bra.b   l_020_0026A                     ; 0027C
dat_020_0027E:
	dc.b	$FF,$FF,$03,$E8,$01,$F4,$01,$4D,$00,$FA,$00,$C8,$00,$A7,$00,$8F
	dc.b	$00,$7D,$00,$6F,$00,$64,$00,$5B,$00,$53,$00,$4D,$00,$47,$00,$43
	dc.b	$00,$3F,$00,$3B,$00,$38,$00,$35,$00,$32,$00,$30,$00,$2D,$00,$2B
	dc.b	$00,$2A,$00,$28,$00,$26,$00,$25,$00,$24,$00,$22,$00,$21
l_020_002BC:
        moveq   #-1,d0                          ; 002BC
        rts                                     ; 002BE

;-------------------------------------------------------------------------------
; BogeyVector - For "YOUR VECTOR XXX FOR BOGEY": finds the first enemy aircraft placed
; (ModeObjects: type $1x, not $15, existing), works out the heading to it from the player in
; degrees and writes it into the text; returns -1 if there is none.
;-------------------------------------------------------------------------------
BogeyVector:
        lea.l   (ObjectTable).l,a1              ; 002C0
        movea.l (ModeObjects).l,a2              ; 002C6
l_020_002CC:
        tst.w   (a2)                            ; 002CC
        blt.b   l_020_002BC                     ; 002CE
        move.w  $4(a2),d3                       ; 002D0
        adda.w  #$a,a2                          ; 002D4
        lsl.w   #$8,d3                          ; 002D8
        add.w   d3,d3                           ; 002DA
        move.b  $62(a1,d3.w),d1                 ; 002DC
        cmpi.b  #$15,d1                         ; 002E0
        beq.b   l_020_002CC                     ; 002E4
        andi.b  #$f0,d1                         ; 002E6
        cmpi.b  #$10,d1                         ; 002EA
        bne.b   l_020_002CC                     ; 002EE
        btst    #$6,$1(a1,d3.w)                 ; 002F0
        beq.b   l_020_002CC                     ; 002F6
        adda.w  d3,a1                           ; 002F8
        moveq   #$0,d3                          ; 002FA
        moveq   #$0,d4                          ; 002FC
        move.w  #$1f4,d5                        ; 002FE
        jsr     (sub_004_00328).l               ; 00302
        move.l  d2,d4                           ; 00308
        move.l  d0,d2                           ; 0030A
        sub.l   (PlayerX).l,d2                  ; 0030C
        asr.l   #$8,d2                          ; 00312
        moveq   #$0,d3                          ; 00314
        sub.l   (PlayerZ).l,d4                  ; 00316
        asr.l   #$8,d4                          ; 0031C
        moveq   #-1,d5                          ; 0031E
        moveq   #$0,d0                          ; 00320
        moveq   #$0,d1                          ; 00322
        movem.l d0-d5,-(a7)                     ; 00324
        jsr     (VectorToAngles).l              ; 00328
        adda.w  #$18,a7                         ; 0032E
        move.w  (dat_071_00492).l,d0            ; 00332
        ext.l   d0                              ; 00338
        divu.w  #$50,d0                         ; 0033A
        ext.l   d0                              ; 0033E
        move.l  d0,(BCDIn).l                    ; 00340
        bsr.w   BinToBCD                        ; 00346
        lea.l   (dat_064_0216E).l,a1            ; 0034A
        adda.w  #$11,a1                         ; 00350
        move.l  (BCDOut).l,d0                   ; 00354
        move.b  d0,d1                           ; 0035A
        lea.l   (dat_071_004F4).l,a3            ; 0035C
        andi.b  #$f0,$1(a3)                     ; 00362
        andi.b  #$f,d1                          ; 00368
        cmpi.b  #$5,d1                          ; 0036C
        blt.b   l_020_0039C                     ; 00370
        addq.w  #$2,a3                          ; 00372
        lea.l   (ObjectViewPos).l,a2            ; 00374
        move.l  #$a,-$4(a2)                     ; 0037A
        addi.b  #$0,d1                          ; 00382
        abcd.b  -(a2),-(a3)                     ; 00386
        abcd.b  -(a2),-(a3)                     ; 00388
        cmpi.l  #$360,(BCDOut).l                ; 0038A
        blt.b   l_020_0039C                     ; 00394
        clr.w   (dat_071_004F4).l               ; 00396
l_020_0039C:
        move.b  (a3)+,d1                        ; 0039C
        andi.b  #$f,d1                          ; 0039E
        addi.b  #$30,d1                         ; 003A2
        move.b  d1,(a1)+                        ; 003A6
        move.b  (a3),d1                         ; 003A8
        lsr.b   #$4,d1                          ; 003AA
        andi.b  #$f,d1                          ; 003AC
        addi.b  #$30,d1                         ; 003B0
        move.b  d1,(a1)+                        ; 003B4
        move.b  (a3),d1                         ; 003B6
        andi.b  #$f,d1                          ; 003B8
        addi.b  #$30,d1                         ; 003BC
        move.b  d1,(a1)+                        ; 003C0
        moveq   #$0,d0                          ; 003C2
        rts                                     ; 003C4

;-------------------------------------------------------------------------------
; MakeSecurityCode - The security check's question: four random hex digits from the clock's
; microseconds (SecurityCode, and dat_002_02972-02978), written into the "enter security
; countercode" text; CodeCheck works out the answer, which is kept as octal digits in
; SecurityAnswer (dat_002_0297A + 3 of them, the length the input takes: InputLength).
;-------------------------------------------------------------------------------
MakeSecurityCode:
        jsr     (ReadTime).l                    ; 003C6
        move.l  (TimeMicros).l,d0               ; 003CC
        lea.l   (SecurityCode).l,a1             ; 003D2
        move.l  d0,d1                           ; 003D8
        andi.w  #$f,d0                          ; 003DA
        move.w  d0,(dat_002_02972).l            ; 003DE
        move.b  d0,(a1)+                        ; 003E4
        asr.l   #$1,d1                          ; 003E6
        move.l  d1,d0                           ; 003E8
        andi.w  #$f,d0                          ; 003EA
        move.w  d0,(dat_002_02974).l            ; 003EE
        move.b  d0,(a1)+                        ; 003F4
        asr.l   #$1,d1                          ; 003F6
        move.l  d1,d0                           ; 003F8
        andi.w  #$f,d0                          ; 003FA
        move.w  d0,(dat_002_02976).l            ; 003FE
        move.b  d0,(a1)+                        ; 00404
        asr.l   #$1,d1                          ; 00406
        andi.w  #$f,d1                          ; 00408
        move.w  d1,(dat_002_02978).l            ; 0040C
        move.b  d1,(a1)+                        ; 00412
        jsr     (CodeCheck).l                   ; 00414
        move.w  (dat_002_0297A).l,d1            ; 0041A
        addq.b  #$3,d1                          ; 00420
        move.b  d1,(InputLength).l              ; 00422
        lea.l   (SecurityCode).l,a1             ; 00428
        move.b  (dat_002_02975).l,$1(a1)        ; 0042E
        lea.l   (dat_064_002B6).l,a0            ; 00436
        adda.w  #$1f,a0                         ; 0043C
        move.b  (a1)+,d1                        ; 00440
        bsr.w   PutHexDigit                     ; 00442
        move.b  (a1)+,d1                        ; 00446
        bsr.w   PutHexDigit                     ; 00448
        move.b  (a1)+,d1                        ; 0044C
        bsr.w   PutHexDigit                     ; 0044E
        move.b  (a1)+,d1                        ; 00452
        bsr.w   PutHexDigit                     ; 00454
        lea.l   (SecurityAnswer).l,a0           ; 00458
        move.w  (dat_002_0297A).l,d2            ; 0045E
        addq.w  #$2,d2                          ; 00464
        move.w  d2,d3                           ; 00466
l_020_00468:
        move.w  d3,d2                           ; 00468
        move.w  d2,d1                           ; 0046A
        add.w   d2,d2                           ; 0046C
        add.w   d1,d2                           ; 0046E
        move.w  d0,d1                           ; 00470
        lsr.w   d2,d1                           ; 00472
        andi.b  #$7,d1                          ; 00474
        bsr.w   PutHexDigit                     ; 00478
        dbra    d3,l_020_00468                  ; 0047C
        move.b  #$0,(a0)                        ; 00480
        rts                                     ; 00484

;-------------------------------------------------------------------------------
; PutHexDigit - Writes d1 (0-15) at a0 as a hex digit '0'-'9' / 'A'-'F'.
;-------------------------------------------------------------------------------
PutHexDigit:
        cmpi.b  #$9,d1                          ; 00486
        ble.b   l_020_0048E                     ; 0048A
        addq.w  #$7,d1                          ; 0048C
l_020_0048E:
        addi.w  #$30,d1                         ; 0048E
        move.b  d1,(a0)+                        ; 00492
        rts                                     ; 00494

;-------------------------------------------------------------------------------
; CheckSecurityAnswer - Compares what was typed (SecurityInput) with SecurityAnswer and sets
; CodeResult: 1 right, -1 wrong.
;-------------------------------------------------------------------------------
CheckSecurityAnswer:
        lea.l   (SecurityInput).l,a0            ; 00496
        lea.l   (SecurityAnswer).l,a1           ; 0049C
        move.w  (dat_002_0297A).l,d1            ; 004A2
        addq.w  #$2,d1                          ; 004A8
l_020_004AA:
        move.b  (a1)+,d0                        ; 004AA
        ble.b   l_020_004B6                     ; 004AC
        cmp.b   (a0)+,d0                        ; 004AE
        bne.b   l_020_004C0                     ; 004B0
        dbra    d1,l_020_004AA                  ; 004B2
l_020_004B6:
        move.b  #$1,(CodeResult).l              ; 004B6
        rts                                     ; 004BE
l_020_004C0:
        move.b  #$ff,(CodeResult).l             ; 004C0
        rts                                     ; 004C8
l_020_004CA:
        rts                                     ; 004CA
sub_020_004CC:
        lea.l   (Shape89_00000).l,a0            ; 004CC
l_020_004D2:
        move.w  (a0)+,d0                        ; 004D2
        blt.b   l_020_004CA                     ; 004D4
        lea.l   (Shape89_00000).l,a1            ; 004D6
        adda.w  d0,a1                           ; 004DC
l_020_004DE:
        movem.w (a1),d4-d7                      ; 004DE
        cmpi.w  #$ffff,d4                       ; 004E2
        beq.b   l_020_004D2                     ; 004E6
        sub.w   d4,d6                           ; 004E8
        sub.w   d5,d7                           ; 004EA
        moveq   #$0,d5                          ; 004EC
        exg.l   d5,d6                           ; 004EE
        moveq   #$2e,d0                         ; 004F0
        jsr     (ScaleToLengthD0).l             ; 004F2
        move.w  d5,d6                           ; 004F8
        move.w  d7,d0                           ; 004FA
        muls.w  #$ffa8,d6                       ; 004FC
        muls.w  #$f1,d0                         ; 00500
        add.l   d6,d0                           ; 00504
        asr.l   #$8,d0                          ; 00506
        move.w  d5,d6                           ; 00508
        move.w  d7,d1                           ; 0050A
        muls.w  #$ff0f,d6                       ; 0050C
        muls.w  #$ffa8,d1                       ; 00510
        add.l   d6,d1                           ; 00514
        asr.l   #$8,d1                          ; 00516
        move.w  d5,d6                           ; 00518
        move.w  d7,d2                           ; 0051A
        muls.w  #$ffa8,d6                       ; 0051C
        muls.w  #$ff0f,d2                       ; 00520
        add.l   d6,d2                           ; 00524
        asr.l   #$8,d2                          ; 00526
        move.w  d5,d6                           ; 00528
        move.w  d7,d3                           ; 0052A
        muls.w  #$f1,d6                         ; 0052C
        muls.w  #$ffa8,d3                       ; 00530
        add.l   d6,d3                           ; 00534
        asr.l   #$8,d3                          ; 00536
        move.w  d0,d4                           ; 00538
        move.w  d1,d5                           ; 0053A
        neg.w   d4                              ; 0053C
        neg.w   d5                              ; 0053E
        add.w   (a1),d0                         ; 00540
        add.w   $2(a1),d1                       ; 00542
        add.w   (a1),d2                         ; 00546
        add.w   $2(a1),d3                       ; 00548
        add.w   $4(a1),d4                       ; 0054C
        add.w   $6(a1),d5                       ; 00550
        movem.w d0-d5,$8(a1)                    ; 00554
        adda.w  #$14,a1                         ; 0055A
        bra.w   l_020_004DE                     ; 0055E
sub_020_00562:
        jsr     (ReadTime).l                    ; 00562
        move.l  (dat_071_004D2).l,d1            ; 00568
        blt.w   l_020_005F4                     ; 0056E
        move.w  (dat_071_0029E).l,d0            ; 00572
        andi.w  #$100,d0                        ; 00578
        beq.b   l_020_00596                     ; 0057C
        andi.w  #$febf,(dat_071_0029E).l        ; 0057E
        clr.l   (dat_071_004E0).l               ; 00586
        clr.l   (dat_071_004E4).l               ; 0058C
        bra.w   l_020_00670                     ; 00592
l_020_00596:
        sub.l   (TimeSeconds).l,d1              ; 00596
        neg.l   d1                              ; 0059C
        mulu.w  #$3e8,d1                        ; 0059E
        move.l  (TimeMicros).l,d0               ; 005A2
        sub.l   (dat_071_004D6).l,d0            ; 005A8
        divs.w  #$3e8,d0                        ; 005AE
        ext.l   d0                              ; 005B2
        add.l   d0,d1                           ; 005B4
        add.l   d1,(dat_071_004E0).l            ; 005B6
        add.w   d1,(dat_071_004DE).l            ; 005BC
        cmpi.w  #$7d,(dat_071_004DE).l          ; 005C2
        blt.b   l_020_005D2                     ; 005CA
        clr.w   (dat_071_004DE).l               ; 005CC
l_020_005D2:
        move.l  (dat_071_004E0).l,d1            ; 005D2
        sub.l   (dat_071_004E4).l,d1            ; 005D8
        cmpi.l  #$2710,d1                       ; 005DE
        blt.b   l_020_005F4                     ; 005E4
        ori.w   #$40,(dat_071_0029E).l          ; 005E6
        add.l   d1,(dat_071_004E4).l            ; 005EE
l_020_005F4:
        move.l  (TimeSeconds).l,d0              ; 005F4
        cmp.l   (dat_071_004D2).l,d0            ; 005FA
        beq.b   l_020_00666                     ; 00600
        move.l  d0,(dat_071_004D2).l            ; 00602
        subq.b  #$1,(dat_071_00254).l           ; 00608
        lea.l   (dat_071_00255).l,a0            ; 0060E
        tst.b   (a0)                            ; 00614
        beq.b   l_020_00622                     ; 00616
        bclr    #$7,(a0)                        ; 00618
        subq.b  #$1,(a0)                        ; 0061C
        bge.b   l_020_00622                     ; 0061E
        clr.b   (a0)                            ; 00620
l_020_00622:
        lea.l   (dat_071_00256).l,a0            ; 00622
        bsr.w   sub_020_006D2                   ; 00628
        lea.l   (dat_071_00261).l,a0            ; 0062C
        bsr.w   sub_020_006D2                   ; 00632
        lea.l   (dat_071_0025A).l,a0            ; 00636
        bsr.w   sub_020_006D2                   ; 0063C
        move.b  (dat_071_00259).l,d1            ; 00640
        tst.b   (dat_071_00258).l               ; 00646
        beq.b   l_020_0065A                     ; 0064C
        addq.b  #$1,d1                          ; 0064E
        cmpi.b  #$f,d1                          ; 00650
        ble.b   l_020_00660                     ; 00654
        moveq   #$f,d1                          ; 00656
        bra.b   l_020_00660                     ; 00658
l_020_0065A:
        tst.b   d1                              ; 0065A
        blt.b   l_020_00666                     ; 0065C
        subq.b  #$1,d1                          ; 0065E
l_020_00660:
        move.b  d1,(dat_071_00259).l            ; 00660
l_020_00666:
        move.l  (TimeMicros).l,(dat_071_004D6).l ; 00666
l_020_00670:
        jsr     (ReadTime).l                    ; 00670
        move.l  (dat_071_004CA).l,d1            ; 00676
        blt.b   l_020_006D0                     ; 0067C
        sub.l   (TimeSeconds).l,d1              ; 0067E
        neg.l   d1                              ; 00684
        mulu.w  #$3e8,d1                        ; 00686
        move.l  (TimeMicros).l,d0               ; 0068A
        sub.l   (dat_071_004CE).l,d0            ; 00690
        divs.w  #$3e8,d0                        ; 00696
        ext.l   d0                              ; 0069A
        add.l   d0,d1                           ; 0069C
        move.l  d1,(dat_071_004DA).l            ; 0069E
        cmpi.l  #$7fff,d1                       ; 006A4
        bgt.b   l_020_006D0                     ; 006AA
        move.w  (FrameCount).l,d2               ; 006AC
        andi.w  #$7,d2                          ; 006B2
        addq.w  #$1,d2                          ; 006B6
        divu.w  d2,d1                           ; 006B8
        lea.l   dat_020_0027E(pc),a0            ; 006BA
        move.b  (dat_071_0028E).l,d2            ; 006BE
        ext.w   d2                              ; 006C4
        add.w   d2,d2                           ; 006C6
        cmp.w   (a0,d2.w),d1                    ; 006C8
        bge.b   l_020_006D0                     ; 006CC
        bra.b   l_020_00670                     ; 006CE
l_020_006D0:
        rts                                     ; 006D0
sub_020_006D2:
        tst.b   (a0)                            ; 006D2
        blt.b   l_020_006D8                     ; 006D4
        subq.b  #$1,(a0)                        ; 006D6
l_020_006D8:
        rts                                     ; 006D8
sub_020_006DA:
        tst.l   (dat_071_004CA).l               ; 006DA
        blt.b   l_020_00722                     ; 006E0
        move.l  (dat_071_004DA).l,d1            ; 006E2
        cmpi.l  #$7fff,d1                       ; 006E8
        ble.b   l_020_006F8                     ; 006EE
        move.l  #$270f,d0                       ; 006F0
        bra.b   l_020_0071C                     ; 006F6
l_020_006F8:
        move.l  #$c3500,d0                      ; 006F8
        divu.w  d1,d0                           ; 006FE
        cmp.w   (dat_071_004B8).l,d0            ; 00700
        bge.b   l_020_0070E                     ; 00706
        move.w  d0,(dat_071_004B8).l            ; 00708
l_020_0070E:
        cmp.w   (dat_071_002B0).l,d0            ; 0070E
        ble.b   l_020_0071C                     ; 00714
        move.w  d0,(dat_071_002B0).l            ; 00716
l_020_0071C:
        move.w  d0,(dat_071_004B6).l            ; 0071C
l_020_00722:
        move.l  (TimeSeconds).l,(dat_071_004CA).l ; 00722
        move.l  (TimeMicros).l,(dat_071_004CE).l ; 0072C
        rts                                     ; 00736

;-------------------------------------------------------------------------------
; SetViewOctant - Sets ViewOctant (0-7): the eighth of the compass the view faces
; (dat_071_0045C in the cockpit, dat_071_00466 outside), for the scenery order.
;-------------------------------------------------------------------------------
SetViewOctant:
        tst.b   (OutsideView).l                 ; 00738
        beq.b   l_020_00748                     ; 0073E
        move.w  (OutsideCamHeading).l,d0        ; 00740
        bra.b   l_020_0074E                     ; 00746
l_020_00748:
        move.l  (dat_071_0045C).l,d0            ; 00748
l_020_0074E:
        cmpi.w  #$3840,d0                       ; 0074E
        bge.b   l_020_00776                     ; 00752
        cmpi.w  #$1c20,d0                       ; 00754
        bge.b   l_020_00768                     ; 00758
        cmpi.w  #$e10,d0                        ; 0075A
        bge.b   l_020_00764                     ; 0075E
        moveq   #$0,d1                          ; 00760
        bra.b   l_020_00796                     ; 00762
l_020_00764:
        moveq   #$1,d1                          ; 00764
        bra.b   l_020_00796                     ; 00766
l_020_00768:
        cmpi.w  #$2a30,d0                       ; 00768
        bge.b   l_020_00772                     ; 0076C
        moveq   #$2,d1                          ; 0076E
        bra.b   l_020_00796                     ; 00770
l_020_00772:
        moveq   #$3,d1                          ; 00772
        bra.b   l_020_00796                     ; 00774
l_020_00776:
        cmpi.w  #$5460,d0                       ; 00776
        bge.b   l_020_0078A                     ; 0077A
        cmpi.w  #$4650,d0                       ; 0077C
        bge.b   l_020_00786                     ; 00780
        moveq   #$4,d1                          ; 00782
        bra.b   l_020_00796                     ; 00784
l_020_00786:
        moveq   #$5,d1                          ; 00786
        bra.b   l_020_00796                     ; 00788
l_020_0078A:
        cmpi.w  #$6270,d0                       ; 0078A
        bge.b   l_020_00794                     ; 0078E
        moveq   #$6,d1                          ; 00790
        bra.b   l_020_00796                     ; 00792
l_020_00794:
        moveq   #$7,d1                          ; 00794
l_020_00796:
        move.b  d1,(ViewOctant).l               ; 00796
        rts                                     ; 0079C
dat_020_0079E:
	dc.b	$04,$00
dat_020_007A0:
	dc.b	$FF,$01,$00,$00,$00,$00,$00
dat_020_007A7:
	dc.b	$04,$00
dat_020_007A9:
	dc.b	$01,$FF,$00,$00,$00,$00,$00
dat_020_007B0:
	dc.b	$04,$00
dat_020_007B2:
	dc.b	$FF,$01,$00,$00,$00,$00,$00
dat_020_007B9:
	dc.b	$04,$00
dat_020_007BB:
	dc.b	$01,$FF,$00,$00,$00,$00,$00
dat_020_007C2:
        dc.l    dat_020_0079E                   ; 007C2
        dc.l    dat_020_007A0                   ; 007C6
        dc.l    dat_020_007A7                   ; 007CA
        dc.l    dat_020_007A9                   ; 007CE
        dc.l    dat_020_007B0                   ; 007D2
        dc.l    dat_020_007B2                   ; 007D6
        dc.l    dat_020_007B9                   ; 007DA
        dc.l    dat_020_007BB                   ; 007DE
l_020_007E2:
        clr.b   (ShakeKind).l                   ; 007E2
l_020_007E8:
        rts                                     ; 007E8

;-------------------------------------------------------------------------------
; ShakeView - Stage $60: while ShakeKind (1-3) is set, moves the view up and down (ViewY, ClipY
; and the digits' offset) by the next of that kind's offsets (dat_020_007C2), ShakeStep
; counting; at the end puts it back and redraws the instruments.
;-------------------------------------------------------------------------------
ShakeView:
        move.b  (ShakeKind).l,d0                ; 007EA
        beq.b   l_020_007E8                     ; 007F0
        move.w  (ViewShift).l,d1                ; 007F2
        bge.b   l_020_007FC                     ; 007F8
        neg.w   d1                              ; 007FA
l_020_007FC:
        cmpi.w  #$e,d1                          ; 007FC
        bgt.b   l_020_007E2                     ; 00800
        lea.l   dat_020_007C2(pc),a0            ; 00802
        ext.w   d0                              ; 00806
        subq.w  #$1,d0                          ; 00808
        asl.w   #$3,d0                          ; 0080A
        movea.l (a0,d0.w),a1                    ; 0080C
        move.b  (a1),d1                         ; 00810
        cmp.b   (ShakeStep).l,d1                ; 00812
        ble.b   l_020_00874                     ; 00818
        move.w  (StatusBits).l,d2               ; 0081A
        andi.w  #$400,d2                        ; 00820
        bne.b   l_020_00834                     ; 00824
        clr.b   (ShakeStep).l                   ; 00826
        ori.w   #$400,(StatusBits).l            ; 0082C
l_020_00834:
        addq.w  #$4,d0                          ; 00834
        movea.l (a0,d0.w),a1                    ; 00836
        move.b  (ShakeStep).l,d2                ; 0083A
        ext.w   d2                              ; 00840
        move.b  (a1,d2.w),d0                    ; 00842
        addq.b  #$1,(ShakeStep).l               ; 00846
        ext.w   d0                              ; 0084C
        move.w  d0,d1                           ; 0084E
        addi.w  #$90,d1                         ; 00850
        move.w  d1,(ClipY).l                    ; 00854
        move.w  d0,(ViewY).l                    ; 0085A
        asl.w   #$3,d0                          ; 00860
        move.w  d0,d1                           ; 00862
        add.w   d0,d0                           ; 00864
        add.w   d0,d0                           ; 00866
        add.w   d1,d0                           ; 00868
        ext.l   d0                              ; 0086A
        move.l  d0,(PanelShakeOffset).l         ; 0086C
        bra.b   l_020_00896                     ; 00872
l_020_00874:
        clr.b   (ShakeKind).l                   ; 00874
        clr.b   (ShakeStep).l                   ; 0087A
        andi.w  #$fbff,(StatusBits).l           ; 00880
        clr.l   (PanelShakeOffset).l            ; 00888
        move.w  #$90,(ClipY).l                  ; 0088E
l_020_00896:
        jsr     (RedrawInstruments).l           ; 00896
        rts                                     ; 0089C
sub_020_0089E:
        movem.l d0-d3,-(a7)                     ; 0089E
        move.l  (dat_071_00534).l,d0            ; 008A2
        cmpi.l  #$63f000,d0                     ; 008A8
        bgt.w   l_020_008E2                     ; 008AE
        move.l  d0,d2                           ; 008B2
        divu.w  #$c8,d2                         ; 008B4
        addq.w  #$2,d2                          ; 008B8
l_020_008BA:
        move.l  d0,d1                           ; 008BA
        divu.w  d2,d1                           ; 008BC
        move.w  d1,d3                           ; 008BE
        sub.w   d2,d3                           ; 008C0
        beq.b   l_020_008D6                     ; 008C2
        cmpi.w  #$1,d3                          ; 008C4
        beq.b   l_020_008D6                     ; 008C8
        cmpi.w  #$ffff,d3                       ; 008CA
        beq.b   l_020_008D6                     ; 008CE
        add.w   d1,d2                           ; 008D0
        lsr.w   #$1,d2                          ; 008D2
        bra.b   l_020_008BA                     ; 008D4
l_020_008D6:
        move.w  d1,(dat_071_00538).l            ; 008D6
        movem.l (a7)+,d0-d3                     ; 008DC
        rts                                     ; 008E0
l_020_008E2:
        cmpi.l  #$63f0000,d0                    ; 008E2
        bgt.w   l_020_00920                     ; 008E8
        lsr.l   #$4,d0                          ; 008EC
        move.l  d0,d2                           ; 008EE
        divu.w  #$c8,d2                         ; 008F0
        addq.w  #$2,d2                          ; 008F4
l_020_008F6:
        move.l  d0,d1                           ; 008F6
        divu.w  d2,d1                           ; 008F8
        move.w  d1,d3                           ; 008FA
        sub.w   d2,d3                           ; 008FC
        beq.b   l_020_00912                     ; 008FE
        cmpi.w  #$1,d3                          ; 00900
        beq.b   l_020_00912                     ; 00904
        cmpi.w  #$ffff,d3                       ; 00906
        beq.b   l_020_00912                     ; 0090A
        add.w   d1,d2                           ; 0090C
        lsr.w   #$1,d2                          ; 0090E
        bra.b   l_020_008F6                     ; 00910
l_020_00912:
        lsl.w   #$2,d1                          ; 00912
        move.w  d1,(dat_071_00538).l            ; 00914
        movem.l (a7)+,d0-d3                     ; 0091A
        rts                                     ; 0091E
l_020_00920:
        lsr.l   #$8,d0                          ; 00920
        move.l  d0,d2                           ; 00922
        divu.w  #$c8,d2                         ; 00924
        addq.w  #$2,d2                          ; 00928
l_020_0092A:
        move.l  d0,d1                           ; 0092A
        divu.w  d2,d1                           ; 0092C
        move.w  d1,d3                           ; 0092E
        sub.w   d2,d3                           ; 00930
        beq.b   l_020_00946                     ; 00932
        cmpi.w  #$1,d3                          ; 00934
        beq.b   l_020_00946                     ; 00938
        cmpi.w  #$ffff,d3                       ; 0093A
        beq.b   l_020_00946                     ; 0093E
        add.w   d1,d2                           ; 00940
        lsr.w   #$1,d2                          ; 00942
        bra.b   l_020_0092A                     ; 00944
l_020_00946:
        lsl.w   #$4,d1                          ; 00946
        move.w  d1,(dat_071_00538).l            ; 00948
        movem.l (a7)+,d0-d3                     ; 0094E
        rts                                     ; 00952

;-------------------------------------------------------------------------------
; StartWarning - StartWarning(d0 = a sound word): makes it the warning or message now sounding
; (CurrentWarning) and sets the flags that go with it (dat_071_0029C bit 0; dat_071_0029E bit
; 13 for the $2000 kind, cleared for $40xx / $48xx). Used by the keys that answer with a voice
; or tone, the training and the objects.
;-------------------------------------------------------------------------------
StartWarning:
        move.w  d1,-(a7)                        ; 00954
        move.w  d0,(CurrentWarning).l           ; 00956
        ori.w   #$1,(StatusBits).l              ; 0095C
        andi.w  #$ff00,d0                       ; 00964
        move.w  d0,d1                           ; 00968
        andi.w  #$2000,d1                       ; 0096A
        beq.b   l_020_00982                     ; 0096E
        andi.w  #$7fff,(dat_071_0029E).l        ; 00970
        ori.w   #$2000,(dat_071_0029E).l        ; 00978
        bra.b   l_020_00996                     ; 00980
l_020_00982:
        cmpi.w  #$4000,d0                       ; 00982
        beq.b   l_020_0098E                     ; 00986
        cmpi.w  #$4800,d0                       ; 00988
        bne.b   l_020_00996                     ; 0098C
l_020_0098E:
        andi.w  #$dfff,(dat_071_0029E).l        ; 0098E
l_020_00996:
        move.w  (a7)+,d1                        ; 00996
        rts                                     ; 00998

;-------------------------------------------------------------------------------
; ScaleToLengthD0 - ScaleToLength with the length in d0 and the vector in d5-d7 (registers
; instead of the stack).
;-------------------------------------------------------------------------------
ScaleToLengthD0:
        link.w  a6,#$fffc                       ; 0099A
        move.w  d0,-$2(a6)                      ; 0099E
        bra.b   l_020_009B4                     ; 009A2

;-------------------------------------------------------------------------------
; ScaleToLength - ScaleToLength(length, x, y, z): the vector (x, y, z) made length long (its
; size from sub_008_016AC), into dat_071_0041C, 0041E, 00420.
;-------------------------------------------------------------------------------
ScaleToLength:
        link.w  a6,#$fffc                       ; 009A4
        movem.l $8(a6),d0/d5-d7                 ; 009A8
        move.w  $8(a6),-$2(a6)                  ; 009AE
l_020_009B4:
        tst.w   d0                              ; 009B4
        beq.b   l_020_00A24                     ; 009B6
        bgt.b   l_020_009BC                     ; 009B8
        neg.w   d0                              ; 009BA
l_020_009BC:
        move.w  d5,d2                           ; 009BC
        bge.b   l_020_009C2                     ; 009BE
        neg.w   d2                              ; 009C0
l_020_009C2:
        move.w  d6,d3                           ; 009C2
        bge.b   l_020_009C8                     ; 009C4
        neg.w   d3                              ; 009C6
l_020_009C8:
        move.w  d7,d4                           ; 009C8
        bge.b   l_020_009CE                     ; 009CA
        neg.w   d4                              ; 009CC
l_020_009CE:
        jsr     (VectorLength).l                ; 009CE
        beq.b   l_020_00A24                     ; 009D4
        moveq   #$8,d2                          ; 009D6
        ext.l   d0                              ; 009D8
l_020_009DA:
        cmp.l   d1,d0                           ; 009DA
        bgt.b   l_020_009E8                     ; 009DC
        asl.l   #$2,d0                          ; 009DE
        addq.w  #$2,d2                          ; 009E0
        bra.b   l_020_009DA                     ; 009E2
l_020_009E4:
        cmp.l   d1,d0                           ; 009E4
        ble.b   l_020_009F2                     ; 009E6
l_020_009E8:
        asr.l   #$2,d0                          ; 009E8
        subq.w  #$2,d2                          ; 009EA
        cmpi.w  #$1,d2                          ; 009EC
        bgt.b   l_020_009E4                     ; 009F0
l_020_009F2:
        asl.l   #$2,d0                          ; 009F2
        addq.w  #$2,d2                          ; 009F4
        asl.l   #$8,d0                          ; 009F6
        divu.w  d1,d0                           ; 009F8
        muls.w  d0,d5                           ; 009FA
        muls.w  d0,d6                           ; 009FC
        muls.w  d0,d7                           ; 009FE
        asr.l   d2,d5                           ; 00A00
        asr.l   d2,d6                           ; 00A02
        asr.l   d2,d7                           ; 00A04
        tst.w   -$2(a6)                         ; 00A06
        bge.b   l_020_00A12                     ; 00A0A
        neg.w   d5                              ; 00A0C
        neg.w   d6                              ; 00A0E
        neg.w   d7                              ; 00A10
l_020_00A12:
        movem.w d5-d7,(dat_071_0041C).l         ; 00A12
        ext.l   d5                              ; 00A1A
        ext.l   d6                              ; 00A1C
        ext.l   d7                              ; 00A1E
        unlk    a6                              ; 00A20
        rts                                     ; 00A22
l_020_00A24:
        clr.w   d5                              ; 00A24
        clr.w   d6                              ; 00A26
        clr.w   d7                              ; 00A28
        bra.b   l_020_00A12                     ; 00A2A
l_020_00A2C:
        move.w  #$15,(DebugCheckpoint).l        ; 00A2C
        jsr     (Nop).l                         ; 00A34
        bra.b   l_020_00A2C                     ; 00A3A
sub_020_00A3C:
        link.w  a6,#$0                          ; 00A3C
        movem.l $8(a6),d0/d5-d7                 ; 00A40
        tst.w   d0                              ; 00A46
        beq.b   l_020_00A2C                     ; 00A48
        bgt.b   l_020_00A4E                     ; 00A4A
        neg.w   d0                              ; 00A4C
l_020_00A4E:
        move.w  d5,d2                           ; 00A4E
        bge.b   l_020_00A54                     ; 00A50
        neg.w   d2                              ; 00A52
l_020_00A54:
        move.w  d6,d3                           ; 00A54
        bge.b   l_020_00A5A                     ; 00A56
        neg.w   d3                              ; 00A58
l_020_00A5A:
        move.w  d7,d4                           ; 00A5A
        bge.b   l_020_00A60                     ; 00A5C
        neg.w   d4                              ; 00A5E
l_020_00A60:
        jsr     (VectorLength).l                ; 00A60
        moveq   #$3,d2                          ; 00A66
        ext.l   d0                              ; 00A68
l_020_00A6A:
        cmp.l   d1,d0                           ; 00A6A
        bgt.b   l_020_00A78                     ; 00A6C
        asl.l   #$2,d0                          ; 00A6E
        addq.w  #$2,d2                          ; 00A70
        bra.b   l_020_00A6A                     ; 00A72
l_020_00A74:
        cmp.l   d1,d0                           ; 00A74
        ble.b   l_020_00A82                     ; 00A76
l_020_00A78:
        asr.l   #$2,d0                          ; 00A78
        subq.w  #$2,d2                          ; 00A7A
        cmpi.w  #$1,d2                          ; 00A7C
        bgt.b   l_020_00A74                     ; 00A80
l_020_00A82:
        asl.l   #$2,d0                          ; 00A82
        addq.w  #$2,d2                          ; 00A84
        asl.l   #$8,d0                          ; 00A86
        divu.w  d1,d0                           ; 00A88
        muls.w  d0,d5                           ; 00A8A
        muls.w  d0,d6                           ; 00A8C
        muls.w  d0,d7                           ; 00A8E
        asr.l   d2,d5                           ; 00A90
        asr.l   d2,d6                           ; 00A92
        asr.l   d2,d7                           ; 00A94
        tst.w   $8(a6)                          ; 00A96
        bge.b   l_020_00AA2                     ; 00A9A
        neg.w   d5                              ; 00A9C
        neg.w   d6                              ; 00A9E
        neg.w   d7                              ; 00AA0
l_020_00AA2:
        movem.w d5-d7,(dat_071_0041C).l         ; 00AA2
        ext.l   d5                              ; 00AAA
        ext.l   d6                              ; 00AAC
        ext.l   d7                              ; 00AAE
        unlk    a6                              ; 00AB0
        rts                                     ; 00AB2

;-------------------------------------------------------------------------------
; ClearRadarList - Empties RadarList.
;-------------------------------------------------------------------------------
ClearRadarList:
        clr.w   (dat_071_00B52).l               ; 00AB4
        move.l  #RadarList,(RadarListEnd).l     ; 00ABA
        rts                                     ; 00AC4

;-------------------------------------------------------------------------------
; AddRadarObject - Adds an object's position, turned by the player's matrix (dat_071_005CC)
; into the aircraft's axes, to RadarList.
;-------------------------------------------------------------------------------
AddRadarObject:
        move.w  d7,d5                           ; 00AC6
        move.w  d7,-(a7)                        ; 00AC8
        lea.l   (dat_071_005CC).l,a0            ; 00ACA
        movea.l (RadarListEnd).l,a3             ; 00AD0
        move.w  d2,d5                           ; 00AD6
        move.w  d3,d6                           ; 00AD8
        move.w  d4,d7                           ; 00ADA
        muls.w  (a0)+,d5                        ; 00ADC
        muls.w  (a0)+,d6                        ; 00ADE
        muls.w  (a0)+,d7                        ; 00AE0
        add.l   d6,d7                           ; 00AE2
        add.l   d5,d7                           ; 00AE4
        asr.l   #$8,d7                          ; 00AE6
        asl.l   d1,d7                           ; 00AE8
        move.l  d7,(a3)+                        ; 00AEA
        clr.l   (a3)+                           ; 00AEC
        addq.w  #$6,a0                          ; 00AEE
        muls.w  (a0)+,d2                        ; 00AF0
        muls.w  (a0)+,d3                        ; 00AF2
        muls.w  (a0)+,d4                        ; 00AF4
        add.l   d3,d4                           ; 00AF6
        add.l   d2,d4                           ; 00AF8
        asr.l   #$8,d4                          ; 00AFA
        asl.l   d1,d4                           ; 00AFC
        move.l  d4,(a3)+                        ; 00AFE
        move.w  (a7)+,d7                        ; 00B00
        move.w  d7,(a3)+                        ; 00B02
        addq.w  #$2,a3                          ; 00B04
        clr.l   (a3)                            ; 00B06
        clr.l   $4(a3)                          ; 00B08
        clr.l   $8(a3)                          ; 00B0C
        move.l  a3,(RadarListEnd).l             ; 00B10
        rts                                     ; 00B16
sub_020_00B18:
        tst.b   (OutsideView).l                 ; 00B18
        beq.w   l_020_00BCE                     ; 00B1E
        tst.b   (MapView).l                     ; 00B22
        bne.w   l_020_00BCE                     ; 00B28
        tst.b   (CameraFollows).l               ; 00B2C
        bne.w   l_020_00BCE                     ; 00B32
        tst.b   (CameraSequence).l              ; 00B36
        bne.w   l_020_00BCE                     ; 00B3C
        move.w  (OutsideCamPitch).l,d4          ; 00B40
        move.w  (OutsideCamHeading).l,d1        ; 00B46
        move.b  (PitchInput).l,d2               ; 00B4C
        beq.b   l_020_00BA0                     ; 00B52
        andi.b  #$20,d2                         ; 00B54
        bne.b   l_020_00B7C                     ; 00B58
        cmpi.w  #$3840,d4                       ; 00B5A
        blt.b   l_020_00B70                     ; 00B5E
        addi.w  #$1e0,d4                        ; 00B60
        cmpi.w  #$7080,d4                       ; 00B64
        blt.b   l_020_00B98                     ; 00B68
        subi.w  #$7080,d4                       ; 00B6A
        bra.b   l_020_00B98                     ; 00B6E
l_020_00B70:
        addi.w  #$1e0,d4                        ; 00B70
        cmpi.w  #$1c20,d4                       ; 00B74
        blt.b   l_020_00B98                     ; 00B78
        bra.b   l_020_00BCE                     ; 00B7A
l_020_00B7C:
        cmpi.w  #$3840,d4                       ; 00B7C
        blt.b   l_020_00B8E                     ; 00B80
        subi.w  #$1e0,d4                        ; 00B82
        cmpi.w  #$5460,d4                       ; 00B86
        bgt.b   l_020_00B98                     ; 00B8A
        bra.b   l_020_00BCE                     ; 00B8C
l_020_00B8E:
        subi.w  #$1e0,d4                        ; 00B8E
        bge.b   l_020_00B98                     ; 00B92
        addi.w  #$7080,d4                       ; 00B94
l_020_00B98:
        move.w  d4,(OutsideCamPitch).l          ; 00B98
        bra.b   l_020_00BCE                     ; 00B9E
l_020_00BA0:
        move.b  (RollInput).l,d2                ; 00BA0
        beq.b   l_020_00BCE                     ; 00BA6
        andi.b  #$8,d2                          ; 00BA8
        bne.b   l_020_00BBE                     ; 00BAC
        addi.w  #$1e0,d1                        ; 00BAE
        cmpi.w  #$7080,d1                       ; 00BB2
        blt.b   l_020_00BC8                     ; 00BB6
        subi.w  #$7080,d1                       ; 00BB8
        bra.b   l_020_00BC8                     ; 00BBC
l_020_00BBE:
        subi.w  #$1e0,d1                        ; 00BBE
        bge.b   l_020_00BC8                     ; 00BC2
        addi.w  #$7080,d1                       ; 00BC4
l_020_00BC8:
        move.w  d1,(OutsideCamHeading).l        ; 00BC8
l_020_00BCE:
        rts                                     ; 00BCE

;-------------------------------------------------------------------------------
; Divide - dat_071_004A2 = dat_071_0049C (long) / dat_071_004A0 (word), rounded.
;-------------------------------------------------------------------------------
Divide:
        movem.l d0-d2,-(a7)                     ; 00BD0
        move.l  (dat_071_0049C).l,d0            ; 00BD4
        move.w  (dat_071_004A0).l,d1            ; 00BDA
        move.w  d1,d2                           ; 00BE0
        bge.b   l_020_00BE6                     ; 00BE2
        neg.w   d2                              ; 00BE4
l_020_00BE6:
        asr.w   #$1,d2                          ; 00BE6
        divs.w  d1,d0                           ; 00BE8
        swap    d0                              ; 00BEA
        tst.w   d0                              ; 00BEC
        bge.b   l_020_00BF2                     ; 00BEE
        neg.w   d0                              ; 00BF0
l_020_00BF2:
        cmp.w   d0,d2                           ; 00BF2
        bgt.b   l_020_00C04                     ; 00BF4
        swap    d0                              ; 00BF6
        tst.w   d0                              ; 00BF8
        bge.b   l_020_00C00                     ; 00BFA
        subq.w  #$1,d0                          ; 00BFC
        bra.b   l_020_00C06                     ; 00BFE
l_020_00C00:
        addq.w  #$1,d0                          ; 00C00
        bra.b   l_020_00C06                     ; 00C02
l_020_00C04:
        swap    d0                              ; 00C04
l_020_00C06:
        move.w  d0,(dat_071_004A2).l            ; 00C06
        movem.l (a7)+,d0-d2                     ; 00C0C
        rts                                     ; 00C10
sub_020_00C12:
        movem.l d5-d7/a5-a6,-(a7)               ; 00C12
        movea.l #BCDOut,a6                      ; 00C16
        lea.l   (PowersOfTen).l,a5              ; 00C1C
        moveq   #$0,d7                          ; 00C22
        moveq   #$3,d5                          ; 00C24
        clr.w   d6                              ; 00C26
l_020_00C28:
        move.b  (a6),d6                         ; 00C28
        lsr.b   #$4,d6                          ; 00C2A
        andi.w  #$f,d6                          ; 00C2C
        bsr.w   sub_020_00C50                   ; 00C30
        move.b  (a6)+,d6                        ; 00C34
        andi.w  #$f,d6                          ; 00C36
        bsr.w   sub_020_00C50                   ; 00C3A
        dbra    d5,l_020_00C28                  ; 00C3E
        move.l  d7,(BCDIn).l                    ; 00C42
        movem.l (a7)+,d5-d7/a5-a6               ; 00C48
        rts                                     ; 00C4C
l_020_00C4E:
        add.l   (a5),d7                         ; 00C4E
sub_020_00C50:
        dbra    d6,l_020_00C4E                  ; 00C50
        addq.l  #$4,a5                          ; 00C54
        rts                                     ; 00C56

;-------------------------------------------------------------------------------
; BinToBCD - Converts BCDIn (a long, up to 99,999,999) to BCD in BCDOut by subtracting powers
; of ten (dat_020_00C8E).
;-------------------------------------------------------------------------------
BinToBCD:
        movem.l d5-d7/a6,-(a7)                  ; 00C58
        lea.l   (BCDIn).l,a6                    ; 00C5C
        move.l  (a6),d5                         ; 00C62
        lea.l   (PowersOfTen).l,a6              ; 00C64
        moveq   #$0,d7                          ; 00C6A
        move.l  #$10000000,d6                   ; 00C6C
l_020_00C72:
        cmp.l   (a6),d5                         ; 00C72
        bcs.b   l_020_00C7C                     ; 00C74
        sub.l   (a6),d5                         ; 00C76
        add.l   d6,d7                           ; 00C78
        bra.b   l_020_00C72                     ; 00C7A
l_020_00C7C:
        addq.l  #$4,a6                          ; 00C7C
        lsr.l   #$4,d6                          ; 00C7E
        bne.b   l_020_00C72                     ; 00C80
        move.l  d7,(BCDOut).l                   ; 00C82
        movem.l (a7)+,d5-d7/a6                  ; 00C88
        rts                                     ; 00C8C
; PowersOfTen - 10,000,000 down to 1 (longs), for BinToBCD.
PowersOfTen:
	dc.b	$00,$98,$96,$80,$00,$0F,$42,$40,$00,$01,$86,$A0,$00,$00,$27,$10
	dc.b	$00,$00,$03,$E8,$00,$00,$00,$64,$00,$00,$00,$0A,$00,$00,$00,$01
	dc.b	$00,$00
h020_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    11,20                           ; 11 longs pointing into hunk 20
	dc.l	$C66,$C1E,$7DE,$7DA,$7D6,$7D2,$7CE,$7CA
	dc.l	$7C6,$7C2,$4F4
        dc.l    127,71                          ; 127 longs pointing into hunk 71
	dc.l	$4BA,$4C4,$45A,$49E,$3D4,$42A,$498,$376
	dc.l	$8D8,$916,$94A,$8A4,$C08,$BDC,$BD6,$A16
	dc.l	$AA6,$AC0,$AD2,$B12,$ACC,$958,$574,$582
	dc.l	$5EA,$974,$97C,$992,$81C,$830,$884,$960
	dc.l	$A30,$23A,$242,$30E,$318,$2C2,$B24,$BA2
	dc.l	$B4E,$B38,$B2E,$742,$B48,$BCA,$B42,$B9A
	dc.l	$74A,$798,$73A,$B1A,$814,$828,$83C,$848
	dc.l	$87C,$7E4,$7EC,$876,$638,$610,$AB6,$856
	dc.l	$892,$85C,$86E,$88A,$7F4,$648,$642,$662
	dc.l	$6C0,$6AE,$60A,$624,$62E,$71E,$710,$718
	dc.l	$702,$70A,$5BE,$5C6,$5CE,$58E,$5DA,$5F0
	dc.l	$588,$5B8,$5D4,$6A0,$6E4,$5AA,$66C,$56A
	dc.l	$5FC,$604,$692,$732,$678,$6DC,$728,$3CE
	dc.l	$5A4,$668,$68C,$72E,$598,$5F6,$680,$724
	dc.l	$424,$2C8,$334,$224,$1D2,$356,$35E,$390
	dc.l	$398,$C18,$C84,$1C8,$342,$C44,$C5E
        dc.l    2,8                             ; 2 longs pointing into hunk 8
	dc.l	$9D0,$A62
        dc.l    1,72                            ; 1 longs pointing into hunk 72
	dc.l	$ABC
        dc.l    1,7                             ; 1 longs pointing into hunk 7
	dc.l	$A36
        dc.l    2,74                            ; 2 longs pointing into hunk 74
	dc.l	$248,$26C
        dc.l    3,0                             ; 3 longs pointing into hunk 0
	dc.l	$3C8,$564,$672
        dc.l    1,6                             ; 1 longs pointing into hunk 6
	dc.l	$898
        dc.l    18,64                           ; 18 longs pointing into hunk 64
	dc.l	$438,$34C,$200,$1FA,$1BE,$1AC,$180,$19A
	dc.l	$154,$166,$130,$142,$10C,$11E,$FA,$E8
	dc.l	$A8,$CA
        dc.l    11,2                            ; 11 longs pointing into hunk 2
	dc.l	$41C,$460,$4A4,$40E,$400,$3F0,$430,$3E0
	dc.l	$7E,$DE,$1EE
        dc.l    1,0                             ; 1 longs pointing into hunk 0
	dc.l	$416
        dc.l    2,70                            ; 2 longs pointing into hunk 70
	dc.l	$4CE,$4D8
        dc.l    1,0                             ; 1 longs pointing into hunk 0
	dc.l	$32A
        dc.l    1,4                             ; 1 longs pointing into hunk 4
	dc.l	$304
        dc.l    1,0                             ; 1 longs pointing into hunk 0
	dc.l	$1E0
	dc.l	0
	dc.l	HUNK_END
	endc
