; F/A-18 Interceptor - hunk 144 (code)
; C library: _pfmt, the printf formatter.
; Included by ../f18_main.s.

;===============================================================================
; Hunk 144: CODE, $87C bytes
;===============================================================================
	CODE_HUNK	h144

;-------------------------------------------------------------------------------
; _pfmt - The printf formatter: one conversion (%[-][0][width][.prec][l]c) from the format into
; a buffer; returns where the format goes on.
;-------------------------------------------------------------------------------
_pfmt:
        link.w  a6,#$ffb4                       ; 00000
        movem.l a2,-(a7)                        ; 00004
        moveq   #$0,d0                          ; 00008
        move.l  d0,-$18(a6)                     ; 0000A
        moveq   #-1,d1                          ; 0000E
        move.l  d1,-$1c(a6)                     ; 00010
        moveq   #$20,d1                         ; 00014
        move.l  d1,-$20(a6)                     ; 00016
        movea.l $8(a6),a0                       ; 0001A
        move.b  (a0),d1                         ; 0001E
        move.l  d0,-$10(a6)                     ; 00020
        move.l  d0,-$24(a6)                     ; 00024
        move.l  d0,-$14(a6)                     ; 00028
        cmpi.b  #$2d,d1                         ; 0002C
        bne.b   l_144_0003C                     ; 00030
        moveq   #$1,d0                          ; 00032
        addq.l  #$1,$8(a6)                      ; 00034
        move.l  d0,-$10(a6)                     ; 00038
l_144_0003C:
        moveq   #$0,d0                          ; 0003C
        movea.l $8(a6),a0                       ; 0003E
        move.b  (a0),d0                         ; 00042
        move.l  d0,$4(a7)                       ; 00044
        addq.l  #$1,d0                          ; 00048
        movea.l d0,a0                           ; 0004A
        adda.l  #_ctype,a0                      ; 0004C
        move.b  (a0),d0                         ; 00052
        btst    #$2,d0                          ; 00054
        beq.b   l_144_000BC                     ; 00058
        cmpi.l  #$30,$4(a7)                     ; 0005A
        bne.b   l_144_0006A                     ; 00062
        moveq   #$30,d0                         ; 00064
        move.l  d0,-$20(a6)                     ; 00066
l_144_0006A:
        moveq   #$0,d0                          ; 0006A
        movea.l $8(a6),a0                       ; 0006C
        move.b  (a0),d0                         ; 00070
        addq.l  #$1,$8(a6)                      ; 00072
        andi.l  #$f,d0                          ; 00076
        move.l  d0,-$24(a6)                     ; 0007C
l_144_00080:
        moveq   #$0,d0                          ; 00080
        movea.l $8(a6),a0                       ; 00082
        move.b  (a0),d0                         ; 00086
        addq.l  #$1,d0                          ; 00088
        movea.l d0,a1                           ; 0008A
        adda.l  #_ctype,a1                      ; 0008C
        move.b  (a1),d0                         ; 00092
        btst    #$2,d0                          ; 00094
        beq.b   l_144_000BC                     ; 00098
        move.l  -$24(a6),d0                     ; 0009A
        moveq   #$a,d1                          ; 0009E
        jsr     (CXM33).l                       ; 000A0
        moveq   #$0,d1                          ; 000A6
        move.b  (a0),d1                         ; 000A8
        addq.l  #$1,$8(a6)                      ; 000AA
        andi.l  #$f,d1                          ; 000AE
        add.l   d1,d0                           ; 000B4
        move.l  d0,-$24(a6)                     ; 000B6
        bra.b   l_144_00080                     ; 000BA
l_144_000BC:
        movea.l $8(a6),a0                       ; 000BC
        move.b  (a0),d0                         ; 000C0
        cmpi.b  #$2e,d0                         ; 000C2
        bne.b   l_144_0010C                     ; 000C6
        addq.l  #$1,$8(a6)                      ; 000C8
        clr.l   -$1c(a6)                        ; 000CC
l_144_000D0:
        moveq   #$0,d0                          ; 000D0
        movea.l $8(a6),a0                       ; 000D2
        move.b  (a0),d0                         ; 000D6
        addq.l  #$1,d0                          ; 000D8
        movea.l d0,a1                           ; 000DA
        adda.l  #_ctype,a1                      ; 000DC
        move.b  (a1),d0                         ; 000E2
        btst    #$2,d0                          ; 000E4
        beq.b   l_144_0010C                     ; 000E8
        move.l  -$1c(a6),d0                     ; 000EA
        moveq   #$a,d1                          ; 000EE
        jsr     (CXM33).l                       ; 000F0
        moveq   #$0,d1                          ; 000F6
        move.b  (a0),d1                         ; 000F8
        addq.l  #$1,$8(a6)                      ; 000FA
        andi.l  #$f,d1                          ; 000FE
        add.l   d1,d0                           ; 00104
        move.l  d0,-$1c(a6)                     ; 00106
        bra.b   l_144_000D0                     ; 0010A
l_144_0010C:
        movea.l $8(a6),a0                       ; 0010C
        move.b  (a0),d0                         ; 00110
        cmpi.b  #$6c,d0                         ; 00112
        bne.b   l_144_00122                     ; 00116
        moveq   #$1,d0                          ; 00118
        addq.l  #$1,$8(a6)                      ; 0011A
        move.l  d0,-$14(a6)                     ; 0011E
l_144_00122:
        clr.l   -$30(a6)                        ; 00122
        moveq   #$0,d0                          ; 00126
        movea.l $8(a6),a0                       ; 00128
        move.b  (a0),d0                         ; 0012C
        moveq   #$48,d1                         ; 0012E
l_144_00130:
        subi.l  #$8,d1                          ; 00130
        bmi.w   l_144_003C0                     ; 00136
        cmp.l   dat_144_00144(pc,d1.l),d0       ; 0013A
        bne.b   l_144_00130                     ; 0013E
        jmp     PfmtJump1+2(pc,d1.l)            ; 00140
dat_144_00144:
	dc.b	$00,$00

;-------------------------------------------------------------------------------
; PfmtJump1 - _pfmt's jump table entries (data read as code).
;-------------------------------------------------------------------------------
PfmtJump1:
        ori.w   #$6000,-(a6)                    ; 00146
        andi.w  #$0,$65(a6)                     ; 0014A
        bra.w   l_144_003B2                     ; 00150
	dc.b	$00,$00

;-------------------------------------------------------------------------------
; PfmtJump2 - More of _pfmt's jump table (data read as code).
;-------------------------------------------------------------------------------
PfmtJump2:
        ori.w   #$6000,-(a7)                    ; 00156
        andi.w  #$0,(a0)                        ; 0015A
        ori.w   #$6000,-(a3)                    ; 0015E
        andi.b  #$0,$73(a2)                     ; 00162
        bra.w   l_144_0033C                     ; 00168
	dc.b	$00,$00,$00,$6F,$60,$00,$01,$58,$00,$00,$00,$78,$60,$00,$00,$DC
	dc.b	$00,$00,$00,$75,$60,$00,$00,$38,$00,$00,$00,$64,$60,$00,$00,$02
	dc.b	$4A,$AE,$FF,$EC,$67,$0E,$22,$6E,$00,$10,$20,$51,$58,$91,$2D,$50
	dc.b	$FF,$CC,$60,$0C,$22,$6E,$00,$10,$20,$51,$58,$91,$2D,$50,$FF,$CC
	dc.b	$4A,$AE,$FF,$CC,$6A,$28,$70,$01,$2D,$40,$FF,$E8,$60,$20,$4A,$AE
	dc.b	$FF,$EC,$67,$0E,$22,$6E,$00,$10,$20,$51,$58,$91,$2D,$50,$FF,$CC
	dc.b	$60,$0C,$22,$6E,$00,$10,$20,$51,$58,$91,$2D,$50,$FF,$CC,$70,$0B
	dc.b	$2D,$40,$FF,$FC,$20,$2E,$FF,$CC,$72,$0A,$4E,$B9
        dc.l    CXD33                           ; 001E8
	dc.b	$2D,$41,$FF,$F8,$4A,$81,$6A,$04,$44,$AE,$FF,$F8,$53,$AE,$FF,$FC
	dc.b	$20,$2E,$FF,$F8,$06,$80,$00,$00,$00,$30,$22,$2E,$FF,$FC,$1D,$80
	dc.b	$18,$B8,$20,$2E,$FF,$CC,$72,$0A,$4E,$B9
        dc.l    CXD33                           ; 00216
	dc.b	$2D,$40,$FF,$CC,$4A,$AE,$FF,$CC,$66,$BC,$0C,$AE,$00,$00,$00,$01
	dc.b	$FF,$E8,$66,$0E,$53,$AE,$FF,$FC,$20,$2E,$FF,$FC,$1D,$BC,$00,$2D
	dc.b	$08,$B8,$41,$EE,$FF,$B8,$20,$2E,$FF,$FC,$D1,$C0,$72,$0B,$92,$80
	dc.b	$2D,$41,$FF,$F4,$2D,$48,$FF,$D0,$60,$00,$01,$76,$4A,$AE,$FF,$EC
	dc.b	$67,$0E,$22,$6E,$00,$10,$20,$51,$58,$91,$2D,$50,$FF,$CC,$60,$0C
	dc.b	$22,$6E,$00,$10,$20,$51,$58,$91,$2D,$50,$FF,$CC,$70,$08,$2D,$40
	dc.b	$FF,$FC,$53,$AE,$FF,$FC,$20,$2E,$FF,$CC,$02,$80,$00,$00,$00,$0F
	dc.b	$20,$40,$D1,$FC
        dc.l    _HexDigits                      ; 0028E
	dc.b	$20,$2E,$FF,$FC,$1D,$90,$08,$B8,$20,$2E,$FF,$CC,$E8,$80,$02,$80
	dc.b	$0F,$FF,$FF,$FF,$2D,$40,$FF,$CC,$4A,$AE,$FF,$CC,$66,$CC,$41,$EE
	dc.b	$FF,$B8,$20,$2E,$FF,$FC,$D1,$C0,$72,$08,$92,$80,$2D,$41,$FF,$F4
	dc.b	$2D,$48,$FF,$D0,$60,$00,$01,$02,$4A,$AE,$FF,$EC,$67,$0E,$22,$6E
	dc.b	$00,$10,$20,$51,$58,$91,$2D,$50,$FF,$CC,$60,$0C,$22,$6E,$00,$10
	dc.b	$20,$51,$58,$91,$2D,$50,$FF,$CC,$70,$0B,$2D,$40,$FF,$FC,$53,$AE
	dc.b	$FF,$FC,$20,$2E,$FF,$CC,$02,$80,$00,$00,$00,$07,$06,$80,$00,$00
	dc.b	$00,$30,$22,$2E,$FF,$FC,$1D,$80,$18,$B8,$20,$2E,$FF,$CC,$E6,$80
	dc.b	$02,$80,$1F,$FF,$FF,$FF,$2D,$40,$FF,$CC,$4A,$AE,$FF,$CC,$66,$CE
	dc.b	$41,$EE,$FF,$B8,$20,$2E,$FF,$FC,$D1,$C0,$72,$0B,$92,$80,$2D,$41
	dc.b	$FF,$F4,$2D,$48,$FF,$D0,$60,$00,$00,$90
l_144_0033C:
        cmpi.l  #$ffffffff,-$1c(a6)             ; 0033C
        bne.b   l_144_0034E                     ; 00344
        move.l  #$c8,-$1c(a6)                   ; 00346
l_144_0034E:
        movea.l $10(a6),a1                      ; 0034E
        movea.l (a1),a0                         ; 00352
        addq.l  #$4,(a1)                        ; 00354
        movea.l (a0),a1                         ; 00356
        move.l  a1,-$30(a6)                     ; 00358
        cmpa.l  #$0,a1                          ; 0035C
        bne.b   l_144_0036C                     ; 00362
        move.l  #dat_145_00010,-$30(a6)         ; 00364
l_144_0036C:
        clr.l   -$c(a6)                         ; 0036C
l_144_00370:
        move.l  -$c(a6),d0                      ; 00370
        cmp.l   -$1c(a6),d0                     ; 00374
        bge.b   l_144_003CA                     ; 00378
        movea.l -$30(a6),a0                     ; 0037A
        adda.l  d0,a0                           ; 0037E
        move.b  (a0),d0                         ; 00380
        tst.b   d0                              ; 00382
        beq.b   l_144_003CA                     ; 00384
        addq.l  #$1,-$c(a6)                     ; 00386
        bra.b   l_144_00370                     ; 0038A

;-------------------------------------------------------------------------------
; PfmtString - _pfmt's string conversion.
;-------------------------------------------------------------------------------
PfmtString:
        lea.l   -$48(a6),a0                     ; 0038C
        moveq   #$1,d0                          ; 00390
        move.l  d0,-$c(a6)                      ; 00392
        movea.l $10(a6),a2                      ; 00396
        movea.l (a2),a1                         ; 0039A
        addq.l  #$4,(a2)                        ; 0039C
        move.l  (a1),d0                         ; 0039E
        move.b  d0,-$48(a6)                     ; 003A0
        move.l  a0,-$30(a6)                     ; 003A4
        bra.b   l_144_003CA                     ; 003A8

;-------------------------------------------------------------------------------
; PfmtSetFlag2 - _pfmt: sets a conversion flag to 2.
;-------------------------------------------------------------------------------
PfmtSetFlag2:
        moveq   #$2,d0                          ; 003AA
        move.l  d0,-$2c(a6)                     ; 003AC
        bra.b   l_144_003CA                     ; 003B0
l_144_003B2:
        clr.l   -$2c(a6)                        ; 003B2
        bra.b   l_144_003CA                     ; 003B6

;-------------------------------------------------------------------------------
; PfmtSetFlag1 - _pfmt: sets a conversion flag to 1.
;-------------------------------------------------------------------------------
PfmtSetFlag1:
        moveq   #$1,d0                          ; 003B8
        move.l  d0,-$2c(a6)                     ; 003BA
        bra.b   l_144_003CA                     ; 003BE
l_144_003C0:
        moveq   #$0,d0                          ; 003C0
        movem.l (a7)+,a2                        ; 003C2
        unlk    a6                              ; 003C6
        rts                                     ; 003C8
l_144_003CA:
        tst.l   -$30(a6)                        ; 003CA
        beq.w   l_144_004A2                     ; 003CE
        tst.l   -$24(a6)                        ; 003D2
        beq.b   l_144_003E2                     ; 003D6
        move.l  -$24(a6),d0                     ; 003D8
        cmp.l   -$c(a6),d0                      ; 003DC
        bge.b   l_144_003E8                     ; 003E0
l_144_003E2:
        move.l  -$c(a6),-$24(a6)                ; 003E2
l_144_003E8:
        move.l  -$c(a6),d0                      ; 003E8
        sub.l   d0,-$24(a6)                     ; 003EC
        clr.l   -$4(a6)                         ; 003F0
        tst.l   -$10(a6)                        ; 003F4
        beq.b   l_144_00442                     ; 003F8
l_144_003FA:
        move.l  -$c(a6),d0                      ; 003FA
        subq.l  #$1,d0                          ; 003FE
        move.l  d0,-$c(a6)                      ; 00400
        tst.l   d0                              ; 00404
        bmi.b   l_144_00420                     ; 00406
        movea.l $c(a6),a0                       ; 00408
        adda.l  -$4(a6),a0                      ; 0040C
        addq.l  #$1,-$4(a6)                     ; 00410
        movea.l -$30(a6),a1                     ; 00414
        move.b  (a1),(a0)                       ; 00418
        addq.l  #$1,-$30(a6)                    ; 0041A
        bra.b   l_144_003FA                     ; 0041E
l_144_00420:
        move.l  -$24(a6),d0                     ; 00420
        subq.l  #$1,d0                          ; 00424
        move.l  d0,-$24(a6)                     ; 00426
        tst.l   d0                              ; 0042A
        bmi.b   l_144_0048A                     ; 0042C
        movea.l $c(a6),a0                       ; 0042E
        adda.l  -$4(a6),a0                      ; 00432
        addq.l  #$1,-$4(a6)                     ; 00436
        move.l  -$20(a6),d0                     ; 0043A
        move.b  d0,(a0)                         ; 0043E
        bra.b   l_144_00420                     ; 00440
l_144_00442:
        move.l  -$24(a6),d0                     ; 00442
        subq.l  #$1,d0                          ; 00446
        move.l  d0,-$24(a6)                     ; 00448
        tst.l   d0                              ; 0044C
        bmi.b   l_144_00464                     ; 0044E
        movea.l $c(a6),a0                       ; 00450
        adda.l  -$4(a6),a0                      ; 00454
        addq.l  #$1,-$4(a6)                     ; 00458
        move.l  -$20(a6),d0                     ; 0045C
        move.b  d0,(a0)                         ; 00460
        bra.b   l_144_00442                     ; 00462
l_144_00464:
        move.l  -$c(a6),d0                      ; 00464
        subq.l  #$1,d0                          ; 00468
        move.l  d0,-$c(a6)                      ; 0046A
        tst.l   d0                              ; 0046E
        bmi.b   l_144_0048A                     ; 00470
        movea.l $c(a6),a0                       ; 00472
        adda.l  -$4(a6),a0                      ; 00476
        addq.l  #$1,-$4(a6)                     ; 0047A
        movea.l -$30(a6),a1                     ; 0047E
        move.b  (a1),(a0)                       ; 00482
        addq.l  #$1,-$30(a6)                    ; 00484
        bra.b   l_144_00464                     ; 00488
l_144_0048A:
        movea.l $14(a6),a0                      ; 0048A
        move.l  -$4(a6),(a0)                    ; 0048E
        movea.l $8(a6),a0                       ; 00492
        addq.l  #$1,a0                          ; 00496
        move.l  a0,d0                           ; 00498
        movem.l (a7)+,a2                        ; 0049A
        unlk    a6                              ; 0049E
        rts                                     ; 004A0
l_144_004A2:
        cmpi.l  #$ffffffff,-$1c(a6)             ; 004A2
        bne.b   l_144_004B2                     ; 004AA
        moveq   #$6,d0                          ; 004AC
        move.l  d0,-$1c(a6)                     ; 004AE
l_144_004B2:
        cmpi.l  #$14,-$1c(a6)                   ; 004B2
        blt.b   l_144_004C0                     ; 004BA
        moveq   #$13,d0                         ; 004BC
        bra.b   l_144_004C4                     ; 004BE
l_144_004C0:
        move.l  -$1c(a6),d0                     ; 004C0
l_144_004C4:
        move.l  d0,-$c(a6)                      ; 004C4
        addq.l  #$1,d0                          ; 004C8
        cmpi.l  #$1,-$2c(a6)                    ; 004CA
        seq.b   d1                              ; 004D2
        neg.b   d1                              ; 004D4
        ext.w   d1                              ; 004D6
        ext.l   d1                              ; 004D8
        pea.l   -$48(a6)                        ; 004DA
        pea.l   -$18(a6)                        ; 004DE
        pea.l   -$28(a6)                        ; 004E2
        move.l  d1,-(a7)                        ; 004E6
        move.l  d0,-(a7)                        ; 004E8
        movea.l $10(a6),a0                      ; 004EA
        move.l  (a0),-(a7)                      ; 004EE
        jsr     (fp_DoubleToDigits).l           ; 004F0
        lea.l   $18(a7),a7                      ; 004F6
        movea.l $10(a6),a0                      ; 004FA
        addq.l  #$8,(a0)                        ; 004FE
        lea.l   -$48(a6),a0                     ; 00500
        move.l  -$28(a6),d1                     ; 00504
        move.l  d0,-$c(a6)                      ; 00508
        move.l  d1,-$4(a6)                      ; 0050C
        move.l  a0,-$30(a6)                     ; 00510
        tst.l   d1                              ; 00514
        bpl.b   l_144_0051C                     ; 00516
        neg.l   -$4(a6)                         ; 00518
l_144_0051C:
        cmpi.l  #$2,-$2c(a6)                    ; 0051C
        bne.b   l_144_00540                     ; 00524
        tst.l   -$c(a6)                         ; 00526
        beq.b   l_144_0053A                     ; 0052A
        cmpi.l  #$6,-$4(a6)                     ; 0052C
        blt.b   l_144_0053A                     ; 00534
        moveq   #$0,d0                          ; 00536
        bra.b   l_144_0053C                     ; 00538
l_144_0053A:
        moveq   #$1,d0                          ; 0053A
l_144_0053C:
        move.l  d0,-$2c(a6)                     ; 0053C
l_144_00540:
        tst.l   -$c(a6)                         ; 00540
        beq.b   l_144_0054A                     ; 00544
        subq.l  #$1,-$28(a6)                    ; 00546
l_144_0054A:
        moveq   #$0,d0                          ; 0054A
        move.l  d0,-$4(a6)                      ; 0054C
        tst.l   -$18(a6)                        ; 00550
        beq.b   l_144_0055A                     ; 00554
        addq.l  #$1,-$4(a6)                     ; 00556
l_144_0055A:
        tst.l   -$2c(a6)                        ; 0055A
        beq.b   l_144_0058A                     ; 0055E
        move.l  -$1c(a6),d0                     ; 00560
        addq.l  #$1,d0                          ; 00564
        move.l  -$4(a6),d1                      ; 00566
        add.l   d1,d0                           ; 0056A
        move.l  d0,-$4(a6)                      ; 0056C
        tst.l   -$28(a6)                        ; 00570
        bmi.b   l_144_0057E                     ; 00574
        move.l  -$28(a6),d0                     ; 00576
        add.l   d0,-$4(a6)                      ; 0057A
l_144_0057E:
        tst.l   -$1c(a6)                        ; 0057E
        beq.b   l_144_005C4                     ; 00582
        addq.l  #$1,-$4(a6)                     ; 00584
        bra.b   l_144_005C4                     ; 00588
l_144_0058A:
        move.l  -$1c(a6),d0                     ; 0058A
        addq.l  #$6,d0                          ; 0058E
        add.l   d0,-$4(a6)                      ; 00590
        tst.l   -$28(a6)                        ; 00594
        bpl.b   l_144_005A2                     ; 00598
        move.l  -$28(a6),d0                     ; 0059A
        neg.l   d0                              ; 0059E
        bra.b   l_144_005A6                     ; 005A0
l_144_005A2:
        move.l  -$28(a6),d0                     ; 005A2
l_144_005A6:
        move.l  d0,-$8(a6)                      ; 005A6
        cmpi.l  #$63,d0                         ; 005AA
        ble.b   l_144_005B6                     ; 005B0
        addq.l  #$1,-$4(a6)                     ; 005B2
l_144_005B6:
        cmpi.l  #$3e7,-$8(a6)                   ; 005B6
        ble.b   l_144_005C4                     ; 005BE
        addq.l  #$1,-$4(a6)                     ; 005C0
l_144_005C4:
        tst.l   -$10(a6)                        ; 005C4
        bne.b   l_144_005FE                     ; 005C8
        move.l  -$24(a6),d0                     ; 005CA
        cmp.l   -$4(a6),d0                      ; 005CE
        ble.b   l_144_005FE                     ; 005D2
        move.l  -$4(a6),d0                      ; 005D4
        sub.l   d0,-$24(a6)                     ; 005D8
l_144_005DC:
        move.l  -$24(a6),d0                     ; 005DC
        subq.l  #$1,d0                          ; 005E0
        move.l  d0,-$24(a6)                     ; 005E2
        tst.l   d0                              ; 005E6
        bmi.b   l_144_005FE                     ; 005E8
        movea.l $c(a6),a0                       ; 005EA
        addq.l  #$1,$c(a6)                      ; 005EE
        move.l  -$20(a6),d0                     ; 005F2
        move.b  d0,(a0)                         ; 005F6
        addq.l  #$1,-$4(a6)                     ; 005F8
        bra.b   l_144_005DC                     ; 005FC
l_144_005FE:
        tst.l   -$18(a6)                        ; 005FE
        beq.b   l_144_00610                     ; 00602
        movea.l $c(a6),a0                       ; 00604
        move.b  #$2d,(a0)                       ; 00608
        addq.l  #$1,$c(a6)                      ; 0060C
l_144_00610:
        tst.l   -$2c(a6)                        ; 00610
        beq.w   l_144_0071C                     ; 00614
        tst.l   -$28(a6)                        ; 00618
        bpl.b   l_144_0068E                     ; 0061C
        movea.l $c(a6),a0                       ; 0061E
        move.b  #$30,(a0)                       ; 00622
        addq.l  #$1,a0                          ; 00626
        move.b  #$2e,(a0)                       ; 00628
        addq.l  #$1,a0                          ; 0062C
        move.l  a0,$c(a6)                       ; 0062E
l_144_00632:
        move.l  -$1c(a6),d0                     ; 00632
        subq.l  #$1,d0                          ; 00636
        move.l  d0,-$1c(a6)                     ; 00638
        tst.l   d0                              ; 0063C
        bmi.w   l_144_00824                     ; 0063E
        move.l  -$28(a6),d0                     ; 00642
        addq.l  #$1,d0                          ; 00646
        move.l  d0,-$28(a6)                     ; 00648
        tst.l   d0                              ; 0064C
        bpl.b   l_144_0065E                     ; 0064E
        movea.l $c(a6),a0                       ; 00650
        move.b  #$30,(a0)                       ; 00654
        addq.l  #$1,$c(a6)                      ; 00658
        bra.b   l_144_00632                     ; 0065C
l_144_0065E:
        move.l  -$c(a6),d0                      ; 0065E
        subq.l  #$1,d0                          ; 00662
        move.l  d0,-$c(a6)                      ; 00664
        tst.l   d0                              ; 00668
        bmi.b   l_144_00680                     ; 0066A
        movea.l -$30(a6),a0                     ; 0066C
        movea.l $c(a6),a1                       ; 00670
        move.b  (a0),(a1)                       ; 00674
        addq.l  #$1,-$30(a6)                    ; 00676
        addq.l  #$1,$c(a6)                      ; 0067A
        bra.b   l_144_00632                     ; 0067E
l_144_00680:
        movea.l $c(a6),a0                       ; 00680
        move.b  #$30,(a0)                       ; 00684
        addq.l  #$1,$c(a6)                      ; 00688
        bra.b   l_144_00632                     ; 0068C
l_144_0068E:
        move.l  -$28(a6),d0                     ; 0068E
        subq.l  #$1,-$28(a6)                    ; 00692
        tst.l   d0                              ; 00696
        bmi.b   l_144_006CA                     ; 00698
        move.l  -$c(a6),d0                      ; 0069A
        subq.l  #$1,d0                          ; 0069E
        move.l  d0,-$c(a6)                      ; 006A0
        tst.l   d0                              ; 006A4
        bmi.b   l_144_006BC                     ; 006A6
        movea.l -$30(a6),a0                     ; 006A8
        movea.l $c(a6),a1                       ; 006AC
        move.b  (a0),(a1)                       ; 006B0
        addq.l  #$1,-$30(a6)                    ; 006B2
        addq.l  #$1,$c(a6)                      ; 006B6
        bra.b   l_144_0068E                     ; 006BA
l_144_006BC:
        movea.l $c(a6),a0                       ; 006BC
        move.b  #$30,(a0)                       ; 006C0
        addq.l  #$1,$c(a6)                      ; 006C4
        bra.b   l_144_0068E                     ; 006C8
l_144_006CA:
        tst.l   -$1c(a6)                        ; 006CA
        beq.b   l_144_006DC                     ; 006CE
        movea.l $c(a6),a0                       ; 006D0
        move.b  #$2e,(a0)                       ; 006D4
        addq.l  #$1,$c(a6)                      ; 006D8
l_144_006DC:
        move.l  -$1c(a6),d0                     ; 006DC
        subq.l  #$1,d0                          ; 006E0
        move.l  d0,-$1c(a6)                     ; 006E2
        tst.l   d0                              ; 006E6
        bmi.w   l_144_00824                     ; 006E8
        move.l  -$c(a6),d0                      ; 006EC
        subq.l  #$1,d0                          ; 006F0
        move.l  d0,-$c(a6)                      ; 006F2
        tst.l   d0                              ; 006F6
        bmi.b   l_144_0070E                     ; 006F8
        movea.l -$30(a6),a0                     ; 006FA
        movea.l $c(a6),a1                       ; 006FE
        move.b  (a0),(a1)                       ; 00702
        addq.l  #$1,-$30(a6)                    ; 00704
        addq.l  #$1,$c(a6)                      ; 00708
        bra.b   l_144_006DC                     ; 0070C
l_144_0070E:
        movea.l $c(a6),a0                       ; 0070E
        move.b  #$30,(a0)                       ; 00712
        addq.l  #$1,$c(a6)                      ; 00716
        bra.b   l_144_006DC                     ; 0071A
l_144_0071C:
        move.l  -$c(a6),d0                      ; 0071C
        subq.l  #$1,d0                          ; 00720
        move.l  d0,-$c(a6)                      ; 00722
        tst.l   d0                              ; 00726
        bmi.b   l_144_0073E                     ; 00728
        movea.l -$30(a6),a0                     ; 0072A
        movea.l $c(a6),a1                       ; 0072E
        move.b  (a0),(a1)                       ; 00732
        addq.l  #$1,-$30(a6)                    ; 00734
        addq.l  #$1,$c(a6)                      ; 00738
        bra.b   l_144_0074A                     ; 0073C
l_144_0073E:
        movea.l $c(a6),a0                       ; 0073E
        move.b  #$30,(a0)                       ; 00742
        addq.l  #$1,$c(a6)                      ; 00746
l_144_0074A:
        movea.l $c(a6),a0                       ; 0074A
        move.b  #$2e,(a0)                       ; 0074E
        addq.l  #$1,$c(a6)                      ; 00752
l_144_00756:
        move.l  -$1c(a6),d0                     ; 00756
        subq.l  #$1,d0                          ; 0075A
        move.l  d0,-$1c(a6)                     ; 0075C
        tst.l   d0                              ; 00760
        bmi.b   l_144_00794                     ; 00762
        move.l  -$c(a6),d0                      ; 00764
        subq.l  #$1,d0                          ; 00768
        move.l  d0,-$c(a6)                      ; 0076A
        tst.l   d0                              ; 0076E
        bmi.b   l_144_00786                     ; 00770
        movea.l -$30(a6),a0                     ; 00772
        movea.l $c(a6),a1                       ; 00776
        move.b  (a0),(a1)                       ; 0077A
        addq.l  #$1,-$30(a6)                    ; 0077C
        addq.l  #$1,$c(a6)                      ; 00780
        bra.b   l_144_00756                     ; 00784
l_144_00786:
        movea.l $c(a6),a0                       ; 00786
        move.b  #$30,(a0)                       ; 0078A
        addq.l  #$1,$c(a6)                      ; 0078E
        bra.b   l_144_00756                     ; 00792
l_144_00794:
        movea.l $c(a6),a0                       ; 00794
        move.b  #$45,(a0)                       ; 00798
        addq.l  #$1,a0                          ; 0079C
        move.l  a0,$c(a6)                       ; 0079E
        tst.l   -$28(a6)                        ; 007A2
        bpl.b   l_144_007B6                     ; 007A6
        move.b  #$2d,(a0)                       ; 007A8
        addq.l  #$1,$c(a6)                      ; 007AC
        neg.l   -$28(a6)                        ; 007B0
        bra.b   l_144_007C2                     ; 007B4
l_144_007B6:
        movea.l $c(a6),a0                       ; 007B6
        move.b  #$2b,(a0)                       ; 007BA
        addq.l  #$1,$c(a6)                      ; 007BE
l_144_007C2:
        moveq   #$b,d0                          ; 007C2
        move.l  d0,-$c(a6)                      ; 007C4
l_144_007C8:
        subq.l  #$1,-$c(a6)                     ; 007C8
        move.l  -$28(a6),d0                     ; 007CC
        moveq   #$a,d1                          ; 007D0
        jsr     (CXD33).l                       ; 007D2
        addi.l  #$30,d1                         ; 007D8
        move.l  -$c(a6),d0                      ; 007DE
        move.b  d1,-$48(a6,d0.l)                ; 007E2
        move.l  -$28(a6),d0                     ; 007E6
        moveq   #$a,d1                          ; 007EA
        jsr     (CXD33).l                       ; 007EC
        move.l  d0,-$28(a6)                     ; 007F2
        cmpi.l  #$9,-$c(a6)                     ; 007F6
        bgt.b   l_144_007C8                     ; 007FE
        tst.l   -$28(a6)                        ; 00800
        bne.b   l_144_007C8                     ; 00804
l_144_00806:
        move.l  -$c(a6),d0                      ; 00806
        cmpi.l  #$b,d0                          ; 0080A
        bge.b   l_144_00824                     ; 00810
        addq.l  #$1,-$c(a6)                     ; 00812
        movea.l $c(a6),a0                       ; 00816
        move.b  -$48(a6,d0.l),(a0)              ; 0081A
        addq.l  #$1,$c(a6)                      ; 0081E
        bra.b   l_144_00806                     ; 00822
l_144_00824:
        cmpi.l  #$1,-$10(a6)                    ; 00824
        bne.b   l_144_00862                     ; 0082C
        move.l  -$24(a6),d0                     ; 0082E
        cmp.l   -$4(a6),d0                      ; 00832
        ble.b   l_144_00862                     ; 00836
        move.l  -$4(a6),d0                      ; 00838
        sub.l   d0,-$24(a6)                     ; 0083C
l_144_00840:
        move.l  -$24(a6),d0                     ; 00840
        subq.l  #$1,d0                          ; 00844
        move.l  d0,-$24(a6)                     ; 00846
        tst.l   d0                              ; 0084A
        bmi.b   l_144_00862                     ; 0084C
        movea.l $c(a6),a0                       ; 0084E
        addq.l  #$1,$c(a6)                      ; 00852
        move.l  -$20(a6),d0                     ; 00856
        move.b  d0,(a0)                         ; 0085A
        addq.l  #$1,-$4(a6)                     ; 0085C
        bra.b   l_144_00840                     ; 00860
l_144_00862:
        movea.l $14(a6),a0                      ; 00862
        move.l  -$4(a6),(a0)                    ; 00866
        movea.l $8(a6),a0                       ; 0086A
        addq.l  #$1,a0                          ; 0086E
        move.l  a0,d0                           ; 00870
        movem.l (a7)+,a2                        ; 00872
        unlk    a6                              ; 00876
        rts                                     ; 00878
	dc.b	$00,$00
h144_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    2,145                           ; 2 longs pointing into hunk 145
	dc.l	$366,$28E
        dc.l    3,91                            ; 3 longs pointing into hunk 91
	dc.l	$4E,$8E,$DE
        dc.l    2,154                           ; 2 longs pointing into hunk 154
	dc.l	$A2,$F2
        dc.l    4,152                           ; 4 longs pointing into hunk 152
	dc.l	$1E8,$216,$7D4,$7EE
        dc.l    1,166                           ; 1 longs pointing into hunk 166
	dc.l	$4F2
	dc.l	0
	dc.l	HUNK_END
	endc
