; F/A-18 Interceptor - hunk 40 (code)
; The head-up display (DrawHUD): the fixed symbols and the glass's outline, the height, speed
; and heading (numbers on the F/A-18, tapes on the F-16), the gun sight, the missile seeker
; and the target box.
; Included by ../f18_main.s.

;===============================================================================
; Hunk 40: CODE, $17EC bytes
;===============================================================================
	CODE_HUNK	h040
dat_040_00000:
	dc.b	$00,$00,$70,$00,$00,$00,$B0,$00,$00,$02,$10,$00
dat_040_0000C:
	dc.b	$00,$00,$C0,$00,$00,$02,$00,$00,$00,$02,$40,$00
dat_040_00018:
	dc.b	$00,$00,$C0,$00,$00,$02,$00,$00,$00,$02,$40,$00,$00,$02,$A0,$00
	dc.b	$00,$02,$E0,$00,$00,$04,$20,$00,$00,$04,$60,$00
dat_040_00034:
	dc.b	$00,$00,$E0,$00,$00,$02,$20,$00
dat_040_0003C:
	dc.b	$00,$00,$C0,$00,$00,$02,$20,$00,$00,$02,$60,$00,$00,$02,$A0,$00
	dc.b	$00,$02,$E0,$00
dat_040_00050:
	dc.b	$00,$00,$60,$00,$00,$00,$A0,$00,$00,$00,$E0,$00
l_040_0005C:
        clr.b   (ShootCue).l                    ; 0005C
l_040_00062:
        rts                                     ; 00062

;-------------------------------------------------------------------------------
; DrawHUD - The head-up display, in the cockpit only (not OutsideView): the gun cross, the
; fixed symbols, the target box, the missile seeker and the weapon; while HUDOn (the H key),
; the G load, the height, speed and heading, and the gun sight.
;-------------------------------------------------------------------------------
DrawHUD:
        move.l  #$fffff,(FillPattern).l         ; 00064
        tst.b   (OutsideView).l                 ; 0006E
        bne.b   l_040_0005C                     ; 00074
        bsr.w   DrawGunCross                    ; 00076
        bsr.w   DrawHUDFixed                    ; 0007A
        bsr.w   DrawTargetBox                   ; 0007E
        bsr.w   DrawMissileSeeker               ; 00082
        jsr     (ShowWeapon).l                  ; 00086
        tst.b   (HUDOn).l                       ; 0008C
        beq.b   l_040_00062                     ; 00092
        jsr     (ShowGLoad).l                   ; 00094
        bsr.w   HUDAltitude                     ; 0009A
        bsr.w   DrawGunSight                    ; 0009E
        rts                                     ; 000A2
l_040_000A4:
        rts                                     ; 000A4

;-------------------------------------------------------------------------------
; DrawGunCross - The small cross at the centre of the head-up display (160, 129).
;-------------------------------------------------------------------------------
DrawGunCross:
        move.w  #$a0,d0                         ; 000A6
        add.w   (ViewX).l,d0                    ; 000AA
        cmpi.w  #$1,d0                          ; 000B0
        ble.b   l_040_000A4                     ; 000B4
        cmpi.w  #$13d,d0                        ; 000B6
        bge.b   l_040_000A4                     ; 000BA
        move.w  #$81,d1                         ; 000BC
        add.w   (ViewY).l,d1                    ; 000C0
        move.w  #$8,(DrawColour).l              ; 000C6
        movem.w d0-d1,-(a7)                     ; 000CE
        jsr     (Plot2).l                       ; 000D2
        movem.w (a7)+,d0-d1                     ; 000D8
        addq.w  #$1,d1                          ; 000DC
        movem.w d0-d1,-(a7)                     ; 000DE
        jsr     (Plot2).l                       ; 000E2
        movem.w (a7)+,d0-d1                     ; 000E8
        addq.w  #$1,d1                          ; 000EC
        movem.w d0-d1,-(a7)                     ; 000EE
        jsr     (Plot2).l                       ; 000F2
        movem.w (a7)+,d0-d1                     ; 000F8
        subq.w  #$1,d0                          ; 000FC
        addq.w  #$1,d1                          ; 000FE
        movem.w d0-d1,-(a7)                     ; 00100
        jsr     (Plot2).l                       ; 00104
        movem.w (a7)+,d0-d1                     ; 0010A
        addq.w  #$2,d0                          ; 0010E
        jsr     (Plot2).l                       ; 00110
        rts                                     ; 00116

;-------------------------------------------------------------------------------
; HUDAltitude - The head-up display's height, then (falling into HUDSpeed and HUDHeading) the
; speed and the heading; only while HUDOn. The F/A-18 ($11) shows numbers: the height in feet
; (+$18 / 1024 x 5, or the radar altimeter dat_071_00028 while RadarAltimeterOn is set, at most
; 99,999) with FT at the right, the speed (+$6E / 12) with KT at the left. The F-16 ($10,
; ViewObject +$62) shows moving tapes instead, with tick marks every 5 and numbers every 10
; (HUDTapeTicks) and a pointer at the middle (HUDTapePointer).
;-------------------------------------------------------------------------------
HUDAltitude:
        move.w  #$d,(DrawColour).l              ; 00118
        lea.l   (ObjectTable).l,a0              ; 00120
        adda.w  (ViewObject).l,a0               ; 00126
        tst.b   (RadarAltimeterOn).l            ; 0012C
        beq.b   l_040_0014A                     ; 00132
        move.l  (dat_071_00028).l,d0            ; 00134
        cmpi.l  #$1869f,d0                      ; 0013A
        ble.b   l_040_0015A                     ; 00140
        move.l  #$1869f,d0                      ; 00142
        bra.b   l_040_0015A                     ; 00148
l_040_0014A:
        move.l  $18(a0),d0                      ; 0014A
        asr.l   #$7,d0                          ; 0014E
        asr.l   #$3,d0                          ; 00150
        move.l  d0,d1                           ; 00152
        add.l   d0,d0                           ; 00154
        add.l   d0,d0                           ; 00156
        add.l   d1,d0                           ; 00158
l_040_0015A:
        cmpi.b  #$10,$62(a0)                    ; 0015A
        beq.w   l_040_001C2                     ; 00160
        lea.l   (TextBuffer).l,a2               ; 00164
        lea.l   $6(a2),a0                       ; 0016A
        moveq   #$5,d6                          ; 0016E
        moveq   #$5,d7                          ; 00170
        move.l  d0,(BCDIn).l                    ; 00172
        jsr     (BinToBCD).l                    ; 00178
        lea.l   dat_040_00018(pc),a1            ; 0017E
        move.w  d7,d2                           ; 00182
        lea.l   $d38.w,a4                       ; 00184
        move.w  #$18,d0                         ; 00188
        swap    d0                              ; 0018C
        move.w  d6,d0                           ; 0018E
        jsr     (PrintNumberHUD0).l             ; 00190
        move.w  #$ca,d0                         ; 00196
        lea.l   (sub_040_001C0).l,a2            ; 0019A
        lea.l   $2(a2),a0                       ; 001A0
        lea.l   dat_040_00034(pc),a1            ; 001A4
        lea.l   $e52.w,a4                       ; 001A8
        move.w  #$1a,d0                         ; 001AC
        swap    d0                              ; 001B0
        move.w  #$1,d0                          ; 001B2
        jsr     (PrintTextHUD).l                ; 001B6
        bra.w   HUDSpeed                        ; 001BC
sub_040_001C0:
        not.w   (a4)                            ; 001C0
l_040_001C2:
        divu.w  #$a,d0                          ; 001C2
        ext.l   d0                              ; 001C6
        moveq   #$0,d2                          ; 001C8
        move.l  d0,(BCDIn).l                    ; 001CA
        jsr     (BinToBCD).l                    ; 001D0
        move.l  (BCDOut).l,d0                   ; 001D6
        move.l  d0,d1                           ; 001DC
        andi.w  #$ff0f,d0                       ; 001DE
        andi.w  #$ff,d1                         ; 001E2
        cmpi.w  #$20,d1                         ; 001E6
        ble.b   l_040_0021E                     ; 001EA
        cmpi.w  #$70,d1                         ; 001EC
        bgt.b   l_040_001FE                     ; 001F0
        ori.w   #$50,d0                         ; 001F2
        move.l  #$ffffffce,d2                   ; 001F6
        bra.b   l_040_0021E                     ; 001FC
l_040_001FE:
        move.l  #$ffffff9c,d2                   ; 001FE
        addi.l  #$64,(BCDIn).l                  ; 00204
        jsr     (BinToBCD).l                    ; 0020E
        move.l  (BCDOut).l,d0                   ; 00214
        andi.w  #$ff00,d0                       ; 0021A
l_040_0021E:
        lsr.l   #$4,d0                          ; 0021E
        move.l  d0,(BCDOut).l                   ; 00220
        move.l  (BCDOut).l,-(a7)                ; 00226
        move.l  d1,(BCDOut).l                   ; 0022C
        jsr     (BCDToBinary).l                 ; 00232
        move.l  (a7)+,(BCDOut).l                ; 00238
        move.l  (BCDIn).l,d1                    ; 0023E
        add.l   d2,d1                           ; 00244
        divs.w  #$3,d1                          ; 00246
        move.w  #$df,d0                         ; 0024A
        add.w   (ViewX).l,d0                    ; 0024E
        move.w  d1,-(a7)                        ; 00254
        addi.w  #$5b,d1                         ; 00256
        add.w   (ViewY).l,d1                    ; 0025A
        move.w  d1,(HUDTapeOffset).l            ; 00260
        addq.w  #$2,d1                          ; 00266
        tst.w   d0                              ; 00268
        ble.b   l_040_00278                     ; 0026A
        cmpi.w  #$13f,d0                        ; 0026C
        bge.b   l_040_00278                     ; 00270
        jsr     (PlotKeep).l                    ; 00272
l_040_00278:
        move.w  (a7)+,d5                        ; 00278
        asl.w   #$3,d5                          ; 0027A
        move.w  d5,d3                           ; 0027C
        add.w   d3,d3                           ; 0027E
        add.w   d3,d3                           ; 00280
        add.w   d3,d5                           ; 00282
        ext.l   d5                              ; 00284
        addi.l  #$e02,d5                        ; 00286
        move.l  d5,-(a7)                        ; 0028C
        move.w  d1,-(a7)                        ; 0028E
        bsr.w   HUDDigits2Alt                   ; 00290
        move.l  #$5,(HUDScaleStep).l            ; 00294
        move.w  (a7)+,d1                        ; 0029E
        move.l  (a7)+,d5                        ; 002A0
        move.l  (BCDOut).l,-(a7)                ; 002A2
        move.l  d5,-(a7)                        ; 002A8
        move.w  d1,-(a7)                        ; 002AA
l_040_002AC:
        subi.l  #$258,d5                        ; 002AC
        cmpi.l  #$af0,d5                        ; 002B2
        blt.b   l_040_002F0                     ; 002B8
        subi.w  #$f,d1                          ; 002BA
        move.w  d1,-(a7)                        ; 002BE
        move.l  d5,-(a7)                        ; 002C0
        move.w  #$df,d0                         ; 002C2
        jsr     (PlotInView).l                  ; 002C6
        move.l  (a7)+,d5                        ; 002CC
        move.l  d5,-(a7)                        ; 002CE
        lea.l   (HUDScaleStep).l,a1             ; 002D0
        lea.l   (ObjectViewPos).l,a2            ; 002D6
        addi.w  #$0,d0                          ; 002DC
        abcd.b  -(a2),-(a1)                     ; 002E0
        abcd.b  -(a2),-(a1)                     ; 002E2
        abcd.b  -(a2),-(a1)                     ; 002E4
        bsr.w   HUDDigits2Alt                   ; 002E6
        move.l  (a7)+,d5                        ; 002EA
        move.w  (a7)+,d1                        ; 002EC
        bra.b   l_040_002AC                     ; 002EE
l_040_002F0:
        move.w  (a7)+,d1                        ; 002F0
        move.l  (a7)+,d5                        ; 002F2
        move.l  (a7)+,(BCDOut).l                ; 002F4
l_040_002FA:
        tst.l   (BCDOut).l                      ; 002FA
        beq.w   l_040_0034A                     ; 00300
        addi.l  #$258,d5                        ; 00304
        cmpi.l  #$1130,d5                       ; 0030A
        bgt.w   l_040_0034A                     ; 00310
        addi.w  #$f,d1                          ; 00314
        move.w  d1,-(a7)                        ; 00318
        move.l  d5,-(a7)                        ; 0031A
        move.w  #$df,d0                         ; 0031C
        jsr     (PlotInView).l                  ; 00320
        move.l  (a7)+,d5                        ; 00326
        move.l  d5,-(a7)                        ; 00328
        lea.l   (HUDScaleStep).l,a1             ; 0032A
        lea.l   (ObjectViewPos).l,a2            ; 00330
        addi.w  #$0,d0                          ; 00336
	dc.b	$83,$0A,$83,$0A  sbcd -(a2),-(a1),#$830a
	dc.b	$83,$0A,$61,$00  sbcd -(a2),-(a1),#$6100
	dc.b	$09,$F0,$2A,$1F  bset d4,$1f(a0,d2.l)
        move.w  (a7)+,d1                        ; 00346
        bra.b   l_040_002FA                     ; 00348
l_040_0034A:
        move.w  #$d4,d0                         ; 0034A
        move.w  #$1,d1                          ; 0034E
        bsr.w   HUDTapeTicks                    ; 00352
        move.w  #$ce,d0                         ; 00356
        bsr.w   HUDTapePointer                  ; 0035A

;-------------------------------------------------------------------------------
; HUDSpeed - The speed (+$6E / 12, 0 when the aircraft has crashed): a number with KT on the
; F/A-18, a tape on the left on the F-16.
;-------------------------------------------------------------------------------
HUDSpeed:
        lea.l   (ObjectTable).l,a0              ; 0035E
        adda.w  (ViewObject).l,a0               ; 00364
        moveq   #$0,d0                          ; 0036A
        btst    #$7,$0(a0)                      ; 0036C
        bne.b   l_040_0037C                     ; 00372
        move.w  $6e(a0),d0                      ; 00374
        bge.b   l_040_0037C                     ; 00378
        neg.w   d0                              ; 0037A
l_040_0037C:
        cmpi.b  #$10,$62(a0)                    ; 0037C
        beq.w   l_040_003EC                     ; 00382
        lea.l   (TextBuffer).l,a2               ; 00386
        lea.l   $4(a2),a0                       ; 0038C
        moveq   #$3,d6                          ; 00390
        moveq   #$3,d7                          ; 00392
        ext.l   d0                              ; 00394
        divu.w  #$c,d0                          ; 00396
        ext.l   d0                              ; 0039A
        move.l  d0,(BCDIn).l                    ; 0039C
        jsr     (BinToBCD).l                    ; 003A2
        lea.l   dat_040_0003C(pc),a1            ; 003A8
        move.w  d7,d2                           ; 003AC
        lea.l   $d2a.w,a4                       ; 003AE
        move.w  #$a,d0                          ; 003B2
        swap    d0                              ; 003B6
        move.w  d6,d0                           ; 003B8
        jsr     (PrintNumberHUD0).l             ; 003BA
        move.w  #$71,d0                         ; 003C0
        lea.l   (dat_040_003EA).l,a2            ; 003C4
        lea.l   $2(a2),a0                       ; 003CA
        lea.l   dat_040_00050(pc),a1            ; 003CE
        lea.l   $e44.w,a4                       ; 003D2
        move.w  #$c,d0                          ; 003D6
        swap    d0                              ; 003DA
        move.w  #$1,d0                          ; 003DC
        jsr     (PrintTextHUD).l                ; 003E0
        bra.w   HUDHeading                      ; 003E6
dat_040_003EA:
	dc.b	$4B,$54
l_040_003EC:
        ext.l   d0                              ; 003EC
        divu.w  #$c,d0                          ; 003EE
        ext.l   d0                              ; 003F2
        moveq   #$0,d2                          ; 003F4
        move.l  d0,(BCDIn).l                    ; 003F6
        jsr     (BinToBCD).l                    ; 003FC
        move.l  (BCDOut).l,d0                   ; 00402
        move.l  d0,d1                           ; 00408
        andi.w  #$ff0f,d0                       ; 0040A
        andi.w  #$ff,d1                         ; 0040E
        cmpi.w  #$20,d1                         ; 00412
        ble.b   l_040_0044A                     ; 00416
        cmpi.w  #$70,d1                         ; 00418
        bgt.b   l_040_0042A                     ; 0041C
        ori.w   #$50,d0                         ; 0041E
        move.l  #$ffffffce,d2                   ; 00422
        bra.b   l_040_0044A                     ; 00428
l_040_0042A:
        move.l  #$ffffff9c,d2                   ; 0042A
        addi.l  #$64,(BCDIn).l                  ; 00430
        jsr     (BinToBCD).l                    ; 0043A
        move.l  (BCDOut).l,d0                   ; 00440
        andi.w  #$ff00,d0                       ; 00446
l_040_0044A:
        lsr.l   #$4,d0                          ; 0044A
        move.l  d0,(BCDOut).l                   ; 0044C
        move.l  (BCDOut).l,-(a7)                ; 00452
        move.l  d1,(BCDOut).l                   ; 00458
        jsr     (BCDToBinary).l                 ; 0045E
        move.l  (a7)+,(BCDOut).l                ; 00464
        move.l  (BCDIn).l,d1                    ; 0046A
        add.l   d2,d1                           ; 00470
        divs.w  #$3,d1                          ; 00472
        move.w  d1,d5                           ; 00476
        addi.w  #$5b,d1                         ; 00478
        add.w   (ViewY).l,d1                    ; 0047C
        move.w  d1,(HUDTapeOffset).l            ; 00482
        asl.w   #$3,d5                          ; 00488
        move.w  d5,d3                           ; 0048A
        add.w   d3,d3                           ; 0048C
        add.w   d3,d3                           ; 0048E
        add.w   d3,d5                           ; 00490
        ext.l   d5                              ; 00492
        addi.l  #$df2,d5                        ; 00494
        move.l  d5,-(a7)                        ; 0049A
        bsr.w   HUDDigits2                      ; 0049C
        move.l  (a7)+,d5                        ; 004A0
        move.l  #$5,(HUDScaleStep).l            ; 004A2
        move.l  (BCDOut).l,-(a7)                ; 004AC
        move.l  d5,-(a7)                        ; 004B2
l_040_004B4:
        subi.l  #$258,d5                        ; 004B4
        cmpi.l  #$af0,d5                        ; 004BA
        blt.b   l_040_004E2                     ; 004C0
        lea.l   (HUDScaleStep).l,a1             ; 004C2
        lea.l   (ObjectViewPos).l,a2            ; 004C8
        addi.w  #$0,d0                          ; 004CE
        abcd.b  -(a2),-(a1)                     ; 004D2
        abcd.b  -(a2),-(a1)                     ; 004D4
        abcd.b  -(a2),-(a1)                     ; 004D6
        move.l  d5,-(a7)                        ; 004D8
        bsr.w   HUDDigits2                      ; 004DA
        move.l  (a7)+,d5                        ; 004DE
        bra.b   l_040_004B4                     ; 004E0
l_040_004E2:
        move.l  (a7)+,d5                        ; 004E2
        move.l  (a7)+,(BCDOut).l                ; 004E4
l_040_004EA:
        tst.l   (BCDOut).l                      ; 004EA
        beq.w   l_040_00522                     ; 004F0
        addi.l  #$258,d5                        ; 004F4
        cmpi.l  #$1130,d5                       ; 004FA
        bgt.b   l_040_00522                     ; 00500
        lea.l   (HUDScaleStep).l,a1             ; 00502
        lea.l   (ObjectViewPos).l,a2            ; 00508
        addi.w  #$0,d0                          ; 0050E
	dc.b	$83,$0A,$83,$0A  sbcd -(a2),-(a1),#$830a
	dc.b	$83,$0A,$2F,$05  sbcd -(a2),-(a1),#$2f05
        bsr.w   HUDDigits2                      ; 0051A
        move.l  (a7)+,d5                        ; 0051E
        bra.b   l_040_004EA                     ; 00520
l_040_00522:
        move.w  #$69,d0                         ; 00522
        move.w  #$0,d1                          ; 00526
        bsr.w   HUDTapeTicks                    ; 0052A
        move.w  #$6b,d0                         ; 0052E
        bsr.w   HUDTapePointer2                 ; 00532
        move.w  #$6e,d0                         ; 00536
        add.w   (ViewX).l,d0                    ; 0053A
        cmpi.w  #$5,d0                          ; 00540
        ble.b   HUDHeading                      ; 00544
        cmpi.w  #$13b,d0                        ; 00546
        bge.b   HUDHeading                      ; 0054A
        move.w  #$56,d1                         ; 0054C
        add.w   (ViewY).l,d1                    ; 00550
        jsr     (Plot2).l                       ; 00556
        move.w  #$6c,d0                         ; 0055C
        move.w  #$57,d1                         ; 00560
        jsr     (PlotInView).l                  ; 00564
        addq.w  #$1,d1                          ; 0056A
        jsr     (PlotKeep).l                    ; 0056C
        move.w  #$6e,d0                         ; 00572
        add.w   (ViewX).l,d0                    ; 00576
        addq.w  #$1,d1                          ; 0057C
        jsr     (Plot2).l                       ; 0057E

;-------------------------------------------------------------------------------
; HUDHeading - The heading scale across the top: a mark at the centre (159, 63), the heading's
; tens as numbers every 10 degrees (HeadingLabelPlaces gives their places; HUDDigits3), and the
; scale's ticks (HUDHeadingTicks).
;-------------------------------------------------------------------------------
HUDHeading:
        move.w  #$9f,d0                         ; 00584
        move.w  #$3f,d1                         ; 00588
        jsr     (PlotInView).l                  ; 0058C
        blt.b   l_040_005A4                     ; 00592
        addq.w  #$1,d1                          ; 00594
        jsr     (PlotKeep).l                    ; 00596
        addq.w  #$1,d1                          ; 0059C
        jsr     (Plot).l                        ; 0059E
l_040_005A4:
        lea.l   (ObjectTable).l,a0              ; 005A4
        adda.w  (ViewObject).l,a0               ; 005AA
        move.w  $68(a0),d0                      ; 005B0
        asr.w   #$3,d0                          ; 005B4
        ext.l   d0                              ; 005B6
        moveq   #$0,d2                          ; 005B8
        move.l  d0,(BCDIn).l                    ; 005BA
        jsr     (BinToBCD).l                    ; 005C0
        move.l  (BCDOut).l,d0                   ; 005C6
        move.l  d0,d1                           ; 005CC
        andi.w  #$ff0f,d0                       ; 005CE
        andi.w  #$ff,d1                         ; 005D2
        cmpi.w  #$40,d1                         ; 005D6
        ble.b   l_040_005FC                     ; 005DA
        move.l  #$ffffff9c,d2                   ; 005DC
        addi.l  #$64,(BCDIn).l                  ; 005E2
        jsr     (BinToBCD).l                    ; 005EC
        move.l  (BCDOut).l,d0                   ; 005F2
        andi.w  #$ff00,d0                       ; 005F8
l_040_005FC:
        lsr.l   #$4,d0                          ; 005FC
        cmpi.l  #$360,d0                        ; 005FE
        blt.b   l_040_00608                     ; 00604
        moveq   #$0,d0                          ; 00606
l_040_00608:
        move.l  d0,(BCDOut).l                   ; 00608
        move.l  (BCDOut).l,-(a7)                ; 0060E
        move.l  d1,(BCDOut).l                   ; 00614
        jsr     (BCDToBinary).l                 ; 0061A
        move.l  (a7)+,(BCDOut).l                ; 00620
        move.l  (BCDIn).l,d1                    ; 00626
        add.l   d2,d1                           ; 0062C
        divs.w  #$5,d1                          ; 0062E
        neg.w   d1                              ; 00632
        move.w  d1,d5                           ; 00634
        addi.w  #$9f,d5                         ; 00636
        move.w  d5,(HUDTapeOffset).l            ; 0063A
        asl.w   #$3,d1                          ; 00640
        lea.l   (HeadingLabelPlaces).l,a1       ; 00642
        adda.w  d1,a1                           ; 00648
        move.w  d1,-(a7)                        ; 0064A
        bsr.w   HUDDigits3                      ; 0064C
        move.w  (a7)+,d1                        ; 00650
        move.l  #$a,(HUDScaleStep).l            ; 00652
        move.l  (BCDOut).l,-(a7)                ; 0065C
        move.w  d1,-(a7)                        ; 00662
l_040_00664:
        addi.w  #$a0,d1                         ; 00664
        cmpi.w  #$b0,d1                         ; 00668
        bgt.b   l_040_006A8                     ; 0066C
        lea.l   (HUDScaleStep).l,a1             ; 0066E
        lea.l   (ObjectViewPos).l,a2            ; 00674
        addi.w  #$0,d0                          ; 0067A
        abcd.b  -(a2),-(a1)                     ; 0067E
        abcd.b  -(a2),-(a1)                     ; 00680
        abcd.b  -(a2),-(a1)                     ; 00682
        cmpi.l  #$360,(BCDOut).l                ; 00684
        blt.b   l_040_00696                     ; 0068E
        clr.l   (BCDOut).l                      ; 00690
l_040_00696:
        lea.l   (HeadingLabelPlaces).l,a1       ; 00696
        adda.w  d1,a1                           ; 0069C
        move.w  d1,-(a7)                        ; 0069E
        bsr.w   HUDDigits3                      ; 006A0
        move.w  (a7)+,d1                        ; 006A4
        bra.b   l_040_00664                     ; 006A6
l_040_006A8:
        move.w  (a7)+,d1                        ; 006A8
        move.l  (a7)+,(BCDOut).l                ; 006AA
        tst.l   (BCDOut).l                      ; 006B0
        bgt.b   l_040_006C2                     ; 006B6
        move.l  #$360,(BCDOut).l                ; 006B8
l_040_006C2:
        subi.w  #$a0,d1                         ; 006C2
        cmpi.w  #$ff50,d1                       ; 006C6
        blt.b   l_040_006F4                     ; 006CA
        lea.l   (HUDScaleStep).l,a1             ; 006CC
        lea.l   (ObjectViewPos).l,a2            ; 006D2
        addi.w  #$0,d0                          ; 006D8
	dc.b	$83,$0A,$83,$0A  sbcd -(a2),-(a1),#$830a
	dc.b	$83,$0A,$43,$F9  sbcd -(a2),-(a1),#$43f9
        dc.l    HeadingLabelPlaces              ; 006E4
	dc.b	$D2,$C1,$3F,$01,$61,$00,$06,$0E,$32,$1F,$60,$BC
l_040_006F4:
        move.l  #$3d,d1                         ; 006F4
        add.w   (ViewY).l,d1                    ; 006FA
        bsr.w   HUDHeadingTicks                 ; 00700
        rts                                     ; 00704
	dc.b	$00,$00,$50,$00,$00,$00,$90,$00,$00,$00,$60,$00,$00,$00,$A0,$00
	dc.b	$00,$00,$70,$00,$00,$00,$B0,$00,$00,$00,$80,$00,$00,$00,$C0,$00
	dc.b	$00,$00,$90,$00,$00,$00,$D0,$00,$00,$00,$A0,$00,$00,$00,$E0,$00
	dc.b	$00,$00,$B0,$00,$00,$00,$F0,$00,$00,$00,$C0,$00,$00,$02,$00,$00
	dc.b	$00,$00,$D0,$00,$00,$02,$10,$00,$00,$00,$E0,$00,$00,$02,$20,$00
	dc.b	$00,$00,$F0,$00,$00,$02,$30,$00,$00,$02,$00,$00,$00,$02,$40,$00
	dc.b	$00,$02,$10,$00,$00,$02,$50,$00,$00,$02,$20,$00,$00,$02,$60,$00
	dc.b	$00,$02,$30,$00,$00,$02,$70,$00,$00,$02,$40,$00,$00,$02,$80,$00
	dc.b	$00,$02,$50,$00,$00,$02,$90,$00,$00,$02,$60,$00,$00,$02,$A0,$00
	dc.b	$00,$02,$70,$00,$00,$02,$B0,$00,$00,$02,$80,$00,$00,$02,$C0,$00
	dc.b	$00,$02,$90,$00,$00,$02,$D0,$00,$00,$02,$A0,$00,$00,$02,$E0,$00
	dc.b	$00,$02,$B0,$00,$00,$02,$F0,$00
; HeadingLabelPlaces - Data, not code: the places of the heading scale's numbers (pairs of
; longs: byte offset and blitter shift), indexed by the heading's position.
HeadingLabelPlaces:
	dc.b	$00,$02,$C0,$00  ori.b #$0,d2
        ori.b   #$0,d4                          ; 007C2
	dc.b	$00,$02,$D0,$00  ori.b #$0,d2
	dc.b	$00,$04,$10,$00  ori.b #$0,d4
	dc.b	$00,$02,$E0,$00  ori.b #$0,d2
	dc.b	$00,$04,$20,$00  ori.b #$0,d4
	dc.b	$00,$02,$F0,$00  ori.b #$0,d2
	dc.b	$00,$04,$30,$00  ori.b #$0,d4
        ori.b   #$0,d4                          ; 007DE
	dc.b	$00,$04,$40,$00  ori.b #$0,d4
	dc.b	$00,$04,$10,$00  ori.b #$0,d4
	dc.b	$00,$04,$50,$00  ori.b #$0,d4
	dc.b	$00,$04,$20,$00  ori.b #$0,d4
	dc.b	$00,$04,$60,$00  ori.b #$0,d4
	dc.b	$00,$04,$30,$00  ori.b #$0,d4
	dc.b	$00,$04,$70,$00  ori.b #$0,d4
	dc.b	$00,$04,$40,$00  ori.b #$0,d4
	dc.b	$00,$04,$80,$00  ori.b #$0,d4
	dc.b	$00,$04,$50,$00  ori.b #$0,d4
	dc.b	$00,$04,$90,$00  ori.b #$0,d4
	dc.b	$00,$04,$60,$00  ori.b #$0,d4
	dc.b	$00,$04,$A0,$00  ori.b #$0,d4
	dc.b	$00,$04,$70,$00  ori.b #$0,d4
	dc.b	$00,$04,$B0,$00  ori.b #$0,d4
	dc.b	$00,$04,$80,$00  ori.b #$0,d4
	dc.b	$00,$04,$C0,$00  ori.b #$0,d4
	dc.b	$00,$04,$90,$00  ori.b #$0,d4
	dc.b	$00,$04,$D0,$00  ori.b #$0,d4
	dc.b	$00,$04,$A0,$00  ori.b #$0,d4
	dc.b	$00,$04,$E0,$00  ori.b #$0,d4
	dc.b	$00,$04,$B0,$00  ori.b #$0,d4
	dc.b	$00,$04,$F0,$00  ori.b #$0,d4
	dc.b	$00,$04,$C0,$00  ori.b #$0,d4
        ori.b   #$0,d6                          ; 00842
	dc.b	$00,$04,$D0,$00  ori.b #$0,d4
	dc.b	$00,$06,$10,$00  ori.b #$0,d6
	dc.b	$00,$04,$E0,$00  ori.b #$0,d4
	dc.b	$00,$06,$20,$00  ori.b #$0,d6
	dc.b	$00,$04,$F0,$00  ori.b #$0,d4
	dc.b	$00,$06,$30,$00  ori.b #$0,d6
        ori.b   #$0,d6                          ; 0085E
	dc.b	$00,$06,$40,$00  ori.b #$0,d6
	dc.b	$00,$06,$10,$00  ori.b #$0,d6
	dc.b	$00,$06,$50,$00  ori.b #$0,d6
	dc.b	$00,$06,$20,$00  ori.b #$0,d6
	dc.b	$00,$06,$60,$00  ori.b #$0,d6
	dc.b	$00,$06,$30,$00  ori.b #$0,d6
	dc.b	$00,$06,$70,$00  ori.b #$0,d6

;-------------------------------------------------------------------------------
; HUDTapePointer - The 5-pixel pointer line at the middle of a tape (y 90), at x d0.
;-------------------------------------------------------------------------------
HUDTapePointer:
        add.w   (ViewX).l,d0                    ; 0087E
        cmpi.w  #$13b,d0                        ; 00884
        bge.b   l_040_008AC                     ; 00888
        move.w  #$5a,d1                         ; 0088A
        move.w  d0,d2                           ; 0088E
        addq.w  #$4,d2                          ; 00890
        cmpi.w  #$4,d2                          ; 00892
        ble.b   l_040_008AC                     ; 00896
        move.w  d1,d3                           ; 00898
        add.w   (ViewY).l,d1                    ; 0089A
        add.w   (ViewY).l,d3                    ; 008A0
        jsr     (DrawLine).l                    ; 008A6
l_040_008AC:
        rts                                     ; 008AC

;-------------------------------------------------------------------------------
; HUDTapePointer2 - As HUDTapePointer (the other tape).
;-------------------------------------------------------------------------------
HUDTapePointer2:
        add.w   (ViewX).l,d0                    ; 008AE
        cmpi.w  #$13b,d0                        ; 008B4
        bge.b   l_040_008DC                     ; 008B8
        move.w  #$5a,d1                         ; 008BA
        move.w  d0,d2                           ; 008BE
        addq.w  #$4,d2                          ; 008C0
        cmpi.w  #$4,d2                          ; 008C2
        ble.b   l_040_008DC                     ; 008C6
        move.w  d1,d3                           ; 008C8
        add.w   (ViewY).l,d1                    ; 008CA
        add.w   (ViewY).l,d3                    ; 008D0
        jsr     (DrawLine).l                    ; 008D6
l_040_008DC:
        rts                                     ; 008DC
l_040_008DE:
        rts                                     ; 008DE

;-------------------------------------------------------------------------------
; DrawGunSight - The gun sight, while RadarScale is $80 (as when the gun is selected): the
; pipper (a circle, DrawHUDShape, from dat_040_016F4) where the bullets will be (GunPipperPos,
; from ComputeGunPipper), on the locked target or at (159, 91) without one; and on a target the
; range bar (DrawRangeArc: the target's range +$4A x $4C / $8CA0) and its closure
; (ShowClosure). With the gun selected (+$63 $1x), the target within 8 pixels of the pipper
; and closer than $900, it gives the shoot cue: ShootCue set, sound 4 and SHOOT (ShowShootCue).
;-------------------------------------------------------------------------------
DrawGunSight:
        cmpi.w  #$80,(RadarScale).l             ; 008E0
        bne.b   l_040_008DE                     ; 008E8
        lea.l   (ObjectTable).l,a1              ; 008EA
        adda.w  (ViewObject).l,a1               ; 008F0
        move.b  $63(a1),d5                      ; 008F6
        andi.b  #$f0,d5                         ; 008FA
        cmpi.b  #$10,d5                         ; 008FE
        beq.b   l_040_00934                     ; 00902
        tst.w   (LockedTarget).l                ; 00904
        blt.w   l_040_00A6C                     ; 0090A
        move.w  #$9f,d0                         ; 0090E
        move.w  #$5b,d1                         ; 00912
        tst.w   (SeekerPos).l                   ; 00916
        ble.b   l_040_00928                     ; 0091C
        tst.w   (LockedTarget).l                ; 0091E
        bge.w   l_040_009C0                     ; 00924
l_040_00928:
        movem.w d0-d1,(GunPipperPos).l          ; 00928
        bra.w   l_040_009C0                     ; 00930
l_040_00934:
        move.w  (SeekerPos).l,d0                ; 00934
        ble.b   l_040_00994                     ; 0093A
        sub.w   (GunPipperPos).l,d0             ; 0093C
        bge.b   l_040_00946                     ; 00942
        neg.w   d0                              ; 00944
l_040_00946:
        cmpi.w  #$8,d0                          ; 00946
        bgt.b   l_040_00994                     ; 0094A
        move.w  (dat_071_0030C).l,d1            ; 0094C
        sub.w   (dat_071_00310).l,d1            ; 00952
        bge.b   l_040_0095C                     ; 00958
        neg.w   d1                              ; 0095A
l_040_0095C:
        cmpi.w  #$8,d1                          ; 0095C
        bgt.b   l_040_00994                     ; 00960
        cmpi.w  #$900,$4a(a1)                   ; 00962
        bgt.b   l_040_00994                     ; 00968
        tst.b   (ShootCue).l                    ; 0096A
        bne.b   l_040_0098C                     ; 00970
        tst.w   (LockedTarget).l                ; 00972
        blt.b   l_040_00994                     ; 00978
        ori.l   #$4,(SoundRequests).l           ; 0097A
        move.b  #$1,(ShootCue).l                ; 00984
l_040_0098C:
        jsr     (ShowShootCue).l                ; 0098C
        bra.b   l_040_009AC                     ; 00992
l_040_00994:
        tst.b   (ShootCue).l                    ; 00994
        beq.b   l_040_009AC                     ; 0099A
        clr.b   (ShootCue).l                    ; 0099C
        ori.l   #$8,(SoundRequests).l           ; 009A2
l_040_009AC:
        movem.w (GunPipperPos).l,d0-d1          ; 009AC
        tst.w   d0                              ; 009B4
        ble.w   l_040_00A6C                     ; 009B6
        jsr     (PlotInView).l                  ; 009BA
l_040_009C0:
        movem.w (GunPipperPos).l,d0-d1          ; 009C0
        tst.w   d0                              ; 009C8
        ble.w   l_040_00A6C                     ; 009CA
        add.w   (ViewY).l,d1                    ; 009CE
        move.w  #$50,d2                         ; 009D4
        lea.l   (dat_040_016F4).l,a0            ; 009D8
        move.w  #$a,(DrawColour).l              ; 009DE
        bsr.w   DrawHUDShape                    ; 009E6
        tst.w   (LockedTarget).l                ; 009EA
        blt.w   l_040_00A6C                     ; 009F0
        movem.w (GunPipperPos).l,d0-d1          ; 009F4
        add.w   (ViewY).l,d1                    ; 009FC
        lea.l   (ObjectTable).l,a0              ; 00A02
        adda.w  (ViewObject).l,a0               ; 00A08
        move.w  $4a(a0),d2                      ; 00A0E
        move.l  a0,-(a7)                        ; 00A12
        mulu.w  #$4c,d2                         ; 00A14
        divu.w  #$8ca0,d2                       ; 00A18
        lea.l   (dat_040_0171E).l,a0            ; 00A1C
        move.w  #$d,(DrawColour).l              ; 00A22
        bsr.w   DrawRangeArc                    ; 00A2A
        movea.l (a7)+,a0                        ; 00A2E
        move.w  $4a(a0),d0                      ; 00A30
        cmpi.w  #$7f00,d0                       ; 00A34
        bgt.b   l_040_00A6C                     ; 00A38
        tst.b   (WorldFrozen).l                 ; 00A3A
        bne.b   l_040_00A4A                     ; 00A40
        bclr    #$0,$4(a0)                      ; 00A42
        bne.b   l_040_00A52                     ; 00A48
l_040_00A4A:
        move.w  (Closure).l,d0                  ; 00A4A
        bra.b   l_040_00A66                     ; 00A50
l_040_00A52:
        move.w  d0,d1                           ; 00A52
        sub.w   (TargetRangeLast).l,d0          ; 00A54
        move.w  d0,(Closure).l                  ; 00A5A
        move.w  d1,(TargetRangeLast).l          ; 00A60
l_040_00A66:
        jsr     (ShowClosure).l                 ; 00A66
l_040_00A6C:
        tst.b   (WorldFrozen).l                 ; 00A6C
        bne.b   l_040_00A78                     ; 00A72
        bsr.w   ComputeGunPipper                ; 00A74
l_040_00A78:
        rts                                     ; 00A78

;-------------------------------------------------------------------------------
; ComputeGunPipper - Where the gun's bullets will be: a point ahead of the aircraft along its
; own axes ($600 up, $4000 ahead, by its matrix +$92), kept two frames (GunPointNow, then
; GunPointOld) so it lags behind as the aircraft turns, as the bullets would; projected into
; GunPipperPos.
;-------------------------------------------------------------------------------
ComputeGunPipper:
        lea.l   (ObjectTable).l,a1              ; 00A7A
        adda.w  (ViewObject).l,a1               ; 00A80
        movem.l (GunPointOld).l,d2-d4           ; 00A86
        sub.l   $14(a1),d2                      ; 00A8E
        sub.l   $18(a1),d3                      ; 00A92
        sub.l   $1c(a1),d4                      ; 00A96
        asr.l   #$8,d2                          ; 00A9A
        asr.l   #$8,d3                          ; 00A9C
        asr.l   #$8,d4                          ; 00A9E
        lea.l   (ViewMatrix).l,a2               ; 00AA0
        move.w  d2,d5                           ; 00AA6
        move.w  d3,d6                           ; 00AA8
        move.w  d4,d7                           ; 00AAA
        muls.w  (a2)+,d5                        ; 00AAC
        muls.w  (a2)+,d6                        ; 00AAE
        muls.w  (a2)+,d7                        ; 00AB0
        add.l   d6,d7                           ; 00AB2
        add.l   d5,d7                           ; 00AB4
        asr.l   #$8,d7                          ; 00AB6
        move.w  d7,d0                           ; 00AB8
        move.w  d2,d5                           ; 00ABA
        move.w  d3,d6                           ; 00ABC
        move.w  d4,d7                           ; 00ABE
        muls.w  (a2)+,d5                        ; 00AC0
        muls.w  (a2)+,d6                        ; 00AC2
        muls.w  (a2)+,d7                        ; 00AC4
        add.l   d6,d7                           ; 00AC6
        add.l   d5,d7                           ; 00AC8
        asr.l   #$8,d7                          ; 00ACA
        muls.w  (a2)+,d2                        ; 00ACC
        muls.w  (a2)+,d3                        ; 00ACE
        muls.w  (a2)+,d4                        ; 00AD0
        add.l   d3,d4                           ; 00AD2
        add.l   d2,d4                           ; 00AD4
        asr.l   #$8,d4                          ; 00AD6
        move.w  d7,d1                           ; 00AD8
        move.w  d4,d2                           ; 00ADA
        jsr     (ProjectPoint).l                ; 00ADC
        movem.w d0-d1,(GunPipperPos).l          ; 00AE2
        move.w  #$600,d4                        ; 00AEA
        move.w  #$4000,d5                       ; 00AEE
        lea.l   (a1),a2                         ; 00AF2
        adda.w  #$92,a2                         ; 00AF4
        move.w  d4,d0                           ; 00AF8
        move.w  d5,d7                           ; 00AFA
        muls.w  $2(a2),d0                       ; 00AFC
        muls.w  $4(a2),d7                       ; 00B00
        add.l   d7,d0                           ; 00B04
        move.w  d4,d1                           ; 00B06
        move.w  d5,d7                           ; 00B08
        muls.w  $8(a2),d1                       ; 00B0A
        muls.w  $a(a2),d7                       ; 00B0E
        add.l   d7,d1                           ; 00B12
        move.w  d4,d2                           ; 00B14
        muls.w  $e(a2),d2                       ; 00B16
        muls.w  $10(a2),d5                      ; 00B1A
        add.l   d5,d2                           ; 00B1E
        asr.l   #$6,d0                          ; 00B20
        asr.l   #$6,d1                          ; 00B22
        asr.l   #$6,d2                          ; 00B24
        add.l   $14(a1),d0                      ; 00B26
        add.l   $18(a1),d1                      ; 00B2A
        add.l   $1c(a1),d2                      ; 00B2E
        movem.l (GunPointNow).l,d3-d5           ; 00B32
        movem.l d3-d5,(GunPointOld).l           ; 00B3A
        movem.l d0-d2,(GunPointNow).l           ; 00B42
        rts                                     ; 00B4A

;-------------------------------------------------------------------------------
; ClearLockTone - Clears the lock warnings (WarningFlags $4000 and $200) and requests sound 8
; (silence) if either was on.
;-------------------------------------------------------------------------------
ClearLockTone:
        move.l  (WarningFlags).l,d5             ; 00B4C
        andi.l  #$4200,d5                       ; 00B52
        beq.b   l_040_00B6E                     ; 00B58
        andi.l  #$ffffbdff,(WarningFlags).l     ; 00B5A
        ori.l   #$8,(SoundRequests).l           ; 00B64
l_040_00B6E:
        rts                                     ; 00B6E

;-------------------------------------------------------------------------------
; DrawMissileSeeker - The missile seeker, with a missile selected (+$63 $20 Sidewinder, $30
; AMRAAM) and a locked target in the head-up display's middle: when the seeker (SeekerPos) is
; within 5 pixels of the target box it has the target (WarningFlags $4000, the lock tone); then
; within range ($1800 for the Sidewinder, $2700 for the AMRAAM) it gives the shoot cue
; (ShootCue 1, sound 4, IN RNG) or, closing too fast (Closure below -$2A3), ShootCue 2 and
; sound $10. Without the target, WarningFlags $200 and sound $100 (probably the search tone).
; Draws the seeker symbol (DrawSeekerSymbol).
;-------------------------------------------------------------------------------
DrawMissileSeeker:
        tst.w   (LockedTarget).l                ; 00B70
        blt.b   ClearLockTone                   ; 00B76
        lea.l   (ObjectTable).l,a1              ; 00B78
        adda.w  (ViewObject).l,a1               ; 00B7E
        move.b  $63(a1),d5                      ; 00B84
        andi.b  #$f0,d5                         ; 00B88
        cmpi.b  #$10,d5                         ; 00B8C
        beq.b   ClearLockTone                   ; 00B90
        movem.w (TargetBoxPos).l,d0-d1          ; 00B92
        tst.w   d0                              ; 00B9A
        blt.b   ClearLockTone                   ; 00B9C
        cmpi.w  #$60,d0                         ; 00B9E
        ble.w   l_040_00C80                     ; 00BA2
        cmpi.w  #$de,d0                         ; 00BA6
        bge.w   l_040_00C80                     ; 00BAA
        cmpi.w  #$2e,d1                         ; 00BAE
        ble.w   l_040_00C80                     ; 00BB2
        cmpi.w  #$86,d1                         ; 00BB6
        bge.w   l_040_00C80                     ; 00BBA
        movem.w (SeekerPos).l,d2-d3             ; 00BBE
        sub.w   d0,d2                           ; 00BC6
        bge.b   l_040_00BCC                     ; 00BC8
        neg.w   d2                              ; 00BCA
l_040_00BCC:
        cmpi.w  #$5,d2                          ; 00BCC
        bgt.w   l_040_00C8E                     ; 00BD0
        sub.w   d1,d3                           ; 00BD4
        bge.b   l_040_00BDA                     ; 00BD6
        neg.w   d3                              ; 00BD8
l_040_00BDA:
        cmpi.w  #$5,d3                          ; 00BDA
        bgt.w   l_040_00C8E                     ; 00BDE
        moveq   #$1,d4                          ; 00BE2
        ori.l   #$4000,(WarningFlags).l         ; 00BE4
        andi.l  #$fffffdff,(WarningFlags).l     ; 00BEE
        move.w  #$2700,d7                       ; 00BF8
        cmpi.b  #$30,d5                         ; 00BFC
        beq.b   l_040_00C0E                     ; 00C00
        move.w  #$1800,d7                       ; 00C02
        cmpi.b  #$20,d5                         ; 00C06
        bne.w   l_040_00CFA                     ; 00C0A
l_040_00C0E:
        cmp.w   $4a(a1),d7                      ; 00C0E
        ble.b   l_040_00C78                     ; 00C12
        tst.w   (LockedTarget).l                ; 00C14
        blt.b   l_040_00C78                     ; 00C1A
        cmpi.w  #$fd5d,(Closure).l              ; 00C1C
        blt.b   l_040_00C5A                     ; 00C24
        cmpi.b  #$1,(ShootCue).l                ; 00C26
        bne.b   l_040_00C44                     ; 00C2E
        move.b  (BlinkPhase).l,d7               ; 00C30
        andi.b  #$1f,d7                         ; 00C36
        cmpi.b  #$9,d7                          ; 00C3A
        beq.b   l_040_00C44                     ; 00C3E
        bra.w   l_040_00CE0                     ; 00C40
l_040_00C44:
        ori.l   #$4,(SoundRequests).l           ; 00C44
        move.b  #$1,(ShootCue).l                ; 00C4E
        bra.w   l_040_00CE0                     ; 00C56
l_040_00C5A:
        cmpi.b  #$2,(ShootCue).l                ; 00C5A
        beq.b   l_040_00CE0                     ; 00C62
        ori.l   #$10,(SoundRequests).l          ; 00C64
        move.b  #$2,(ShootCue).l                ; 00C6E
        bra.b   l_040_00CE0                     ; 00C76
l_040_00C78:
        clr.b   (ShootCue).l                    ; 00C78
        bra.b   l_040_00CAE                     ; 00C7E
l_040_00C80:
        bsr.w   ClearLockTone                   ; 00C80
        clr.b   (ShootCue).l                    ; 00C84
        moveq   #$0,d4                          ; 00C8A
        bra.b   l_040_00CE0                     ; 00C8C
l_040_00C8E:
        clr.b   (ShootCue).l                    ; 00C8E
        moveq   #$0,d4                          ; 00C94
        move.l  (WarningFlags).l,d6             ; 00C96
        move.l  d6,d5                           ; 00C9C
        andi.l  #$4000,d6                       ; 00C9E
        bne.b   l_040_00CC2                     ; 00CA4
        andi.l  #$200,d5                        ; 00CA6
        beq.b   l_040_00CC2                     ; 00CAC
l_040_00CAE:
        move.b  (BlinkPhase).l,d7               ; 00CAE
        andi.b  #$1f,d7                         ; 00CB4
        cmpi.b  #$9,d7                          ; 00CB8
        beq.b   l_040_00CC2                     ; 00CBC
        bra.w   l_040_00CE0                     ; 00CBE
l_040_00CC2:
        andi.l  #$ffffbfff,(WarningFlags).l     ; 00CC2
        ori.l   #$200,(WarningFlags).l          ; 00CCC
        ori.l   #$100,(SoundRequests).l         ; 00CD6
l_040_00CE0:
        move.w  #$a,(DrawColour).l              ; 00CE0
        bsr.w   DrawSeekerSymbol                ; 00CE8
        tst.b   (ShootCue).l                    ; 00CEC
        beq.b   l_040_00CFA                     ; 00CF2
        jsr     (ShowShootCue).l                ; 00CF4
l_040_00CFA:
        rts                                     ; 00CFA

;-------------------------------------------------------------------------------
; HUDDigits3 - Draws the three digits at TextBuffer+3 (PrintNumberHUD) at the place given in
; a1: the heading labels.
;-------------------------------------------------------------------------------
HUDDigits3:
        moveq   #$1,d4                          ; 00CFC
        move.w  #$10,d0                         ; 00CFE
        move.l  #$858,d5                        ; 00D02
        moveq   #$1,d6                          ; 00D08
        moveq   #$2,d7                          ; 00D0A
        lea.l   (TextBuffer).l,a2               ; 00D0C
        lea.l   $3(a2),a0                       ; 00D12
        bra.b   l_040_00D4A                     ; 00D16

;-------------------------------------------------------------------------------
; HUDDigits2 - Draws two digits (PrintNumberHUD) with the places in dat_040_0000C.
;-------------------------------------------------------------------------------
HUDDigits2:
        moveq   #$0,d4                          ; 00D18
        lea.l   dat_040_0000C(pc),a1            ; 00D1A
        move.w  #$a,d0                          ; 00D1E
        moveq   #$2,d6                          ; 00D22
        moveq   #$2,d7                          ; 00D24
        lea.l   (TextBuffer).l,a2               ; 00D26
        lea.l   $3(a2),a0                       ; 00D2C
        bra.b   l_040_00D4A                     ; 00D30

;-------------------------------------------------------------------------------
; HUDDigits2Alt - Draws two digits (PrintNumberHUD) with the places in dat_040_00000, for the
; F-16's altitude tape.
;-------------------------------------------------------------------------------
HUDDigits2Alt:
        moveq   #$1,d4                          ; 00D32
        lea.l   dat_040_00000(pc),a1            ; 00D34
        move.w  #$1a,d0                         ; 00D38
        moveq   #$2,d6                          ; 00D3C
        moveq   #$2,d7                          ; 00D3E
        lea.l   (TextBuffer).l,a2               ; 00D40
        lea.l   $3(a2),a0                       ; 00D46
l_040_00D4A:
        move.w  d7,d2                           ; 00D4A
        movea.l d5,a4                           ; 00D4C
        swap    d0                              ; 00D4E
        move.w  d6,d0                           ; 00D50
        jsr     (PrintNumberHUD).l              ; 00D52
        rts                                     ; 00D58
l_040_00D5A:
        rts                                     ; 00D5A

;-------------------------------------------------------------------------------
; HUDTapeTicks - A tape's tick marks (every 3 lines from HUDTapeOffset, longer every fifth), at
; x d0, offset d1.
;-------------------------------------------------------------------------------
HUDTapeTicks:
        add.w   (ViewX).l,d0                    ; 00D5C
        ble.b   l_040_00D5A                     ; 00D62
        cmpi.w  #$13f,d0                        ; 00D64
        bge.b   l_040_00D5A                     ; 00D68
        link.w  a6,#$fff8                       ; 00D6A
        move.w  d0,-$4(a6)                      ; 00D6E
        move.w  d1,-$6(a6)                      ; 00D72
        add.w   d1,d0                           ; 00D76
        move.w  (HUDTapeOffset).l,d1            ; 00D78
        move.w  d1,-(a7)                        ; 00D7E
        jsr     (Plot2).l                       ; 00D80
        move.w  (a7)+,d1                        ; 00D86
        move.w  #$0,-$2(a6)                     ; 00D88
l_040_00D8E:
        move.w  -$4(a6),d0                      ; 00D8E
        subq.w  #$3,d1                          ; 00D92
        cmpi.w  #$47,d1                         ; 00D94
        ble.b   l_040_00DC6                     ; 00D98
        move.w  d1,-(a7)                        ; 00D9A
        cmpi.w  #$4,-$2(a6)                     ; 00D9C
        beq.b   l_040_00DB4                     ; 00DA2
        cmpi.w  #$9,-$2(a6)                     ; 00DA4
        beq.b   l_040_00DB4                     ; 00DAA
        jsr     (Plot).l                        ; 00DAC
        bra.b   l_040_00DBE                     ; 00DB2
l_040_00DB4:
        add.w   -$6(a6),d0                      ; 00DB4
        jsr     (Plot2).l                       ; 00DB8
l_040_00DBE:
        move.w  (a7)+,d1                        ; 00DBE
        addq.w  #$1,-$2(a6)                     ; 00DC0
        bra.b   l_040_00D8E                     ; 00DC4
l_040_00DC6:
        move.w  (HUDTapeOffset).l,d1            ; 00DC6
        move.w  #$0,-$2(a6)                     ; 00DCC
l_040_00DD2:
        move.w  -$4(a6),d0                      ; 00DD2
        addq.w  #$3,d1                          ; 00DD6
        cmpi.w  #$70,d1                         ; 00DD8
        bge.b   l_040_00E0A                     ; 00DDC
        move.w  d1,-(a7)                        ; 00DDE
        cmpi.w  #$4,-$2(a6)                     ; 00DE0
        beq.b   l_040_00DF8                     ; 00DE6
        cmpi.w  #$9,-$2(a6)                     ; 00DE8
        beq.b   l_040_00DF8                     ; 00DEE
        jsr     (Plot).l                        ; 00DF0
        bra.b   l_040_00E02                     ; 00DF6
l_040_00DF8:
        add.w   -$6(a6),d0                      ; 00DF8
        jsr     (Plot2).l                       ; 00DFC
l_040_00E02:
        move.w  (a7)+,d1                        ; 00E02
        addq.w  #$1,-$2(a6)                     ; 00E04
        bra.b   l_040_00DD2                     ; 00E08
l_040_00E0A:
        unlk    a6                              ; 00E0A
        rts                                     ; 00E0C

;-------------------------------------------------------------------------------
; HUDHeadingTicks - The heading scale's tick marks, every 10 pixels from HUDTapeOffset, longer
; at the labelled ones.
;-------------------------------------------------------------------------------
HUDHeadingTicks:
        link.w  a6,#$fff8                       ; 00E0E
        move.w  d1,-$4(a6)                      ; 00E12
        move.w  (HUDTapeOffset).l,d0            ; 00E16
        jsr     (PlotInView).l                  ; 00E1C
        blt.b   l_040_00E2C                     ; 00E22
        subq.w  #$1,d1                          ; 00E24
        jsr     (PlotKeep).l                    ; 00E26
l_040_00E2C:
        move.w  #$0,-$2(a6)                     ; 00E2C
l_040_00E32:
        move.w  -$4(a6),d1                      ; 00E32
        addi.w  #$a,d0                          ; 00E36
        blt.b   l_040_00E84                     ; 00E3A
        cmpi.w  #$13f,d0                        ; 00E3C
        bgt.b   l_040_00E84                     ; 00E40
        move.w  #$b9,d2                         ; 00E42
        add.w   (ViewX).l,d2                    ; 00E46
        cmp.w   d2,d0                           ; 00E4C
        bge.b   l_040_00E84                     ; 00E4E
        move.w  d0,-(a7)                        ; 00E50
        cmpi.w  #$1,-$2(a6)                     ; 00E52
        beq.b   l_040_00E6A                     ; 00E58
        cmpi.w  #$3,-$2(a6)                     ; 00E5A
        beq.b   l_040_00E6A                     ; 00E60
        jsr     (Plot).l                        ; 00E62
        bra.b   l_040_00E7C                     ; 00E68
l_040_00E6A:
        jsr     (PlotKeep).l                    ; 00E6A
        move.w  -$4(a6),d1                      ; 00E70
        subq.w  #$1,d1                          ; 00E74
        jsr     (Plot).l                        ; 00E76
l_040_00E7C:
        move.w  (a7)+,d0                        ; 00E7C
        addq.w  #$1,-$2(a6)                     ; 00E7E
        bra.b   l_040_00E32                     ; 00E82
l_040_00E84:
        move.w  (HUDTapeOffset).l,d0            ; 00E84
        add.w   (ViewX).l,d0                    ; 00E8A
        move.w  #$0,-$2(a6)                     ; 00E90
l_040_00E96:
        move.w  -$4(a6),d1                      ; 00E96
        subi.w  #$a,d0                          ; 00E9A
        blt.b   l_040_00EE8                     ; 00E9E
        cmpi.w  #$13f,d0                        ; 00EA0
        bgt.b   l_040_00EE8                     ; 00EA4
        move.w  #$85,d2                         ; 00EA6
        add.w   (ViewX).l,d2                    ; 00EAA
        cmp.w   d2,d0                           ; 00EB0
        ble.b   l_040_00EE8                     ; 00EB2
        move.w  d0,-(a7)                        ; 00EB4
        cmpi.w  #$1,-$2(a6)                     ; 00EB6
        beq.b   l_040_00ECE                     ; 00EBC
        cmpi.w  #$3,-$2(a6)                     ; 00EBE
        beq.b   l_040_00ECE                     ; 00EC4
        jsr     (Plot).l                        ; 00EC6
        bra.b   l_040_00EE0                     ; 00ECC
l_040_00ECE:
        jsr     (PlotKeep).l                    ; 00ECE
        move.w  -$4(a6),d1                      ; 00ED4
        subq.w  #$1,d1                          ; 00ED8
        jsr     (Plot).l                        ; 00EDA
l_040_00EE0:
        move.w  (a7)+,d0                        ; 00EE0
        addq.w  #$1,-$2(a6)                     ; 00EE2
        bra.b   l_040_00E96                     ; 00EE6
l_040_00EE8:
        unlk    a6                              ; 00EE8
        rts                                     ; 00EEA
	dc.b	$4E,$75

;-------------------------------------------------------------------------------
; DrawHUDFixed - The head-up display's fixed symbols: the aircraft's boresight mark (159,
; 71-75) with its wings, the two horizon bars (141 and 173, line 90) and, for the aircraft
; ($10-$12), the glass's outline (five lines from dat_040_01308, colours from dat_040_01320).
;-------------------------------------------------------------------------------
DrawHUDFixed:
        move.l  #$fffff,(FillPattern).l         ; 00EEE
        move.w  #$a,(DrawColour).l              ; 00EF8
        move.w  #$9f,d0                         ; 00F00
        move.w  #$47,d1                         ; 00F04
        jsr     (PlotInView).l                  ; 00F08
        blt.b   l_040_00F5A                     ; 00F0E
        addq.w  #$1,d1                          ; 00F10
        jsr     (PlotKeep).l                    ; 00F12
        addq.w  #$2,d1                          ; 00F18
        jsr     (PlotKeep).l                    ; 00F1A
        addq.w  #$1,d1                          ; 00F20
        jsr     (Plot).l                        ; 00F22
        move.w  #$9d,d0                         ; 00F28
        add.w   (ViewX).l,d0                    ; 00F2C
        cmpi.w  #$4,d0                          ; 00F32
        blt.b   l_040_00F5A                     ; 00F36
        move.w  #$48,d1                         ; 00F38
        move.w  d0,d2                           ; 00F3C
        addq.w  #$4,d2                          ; 00F3E
        cmpi.w  #$13b,d2                        ; 00F40
        bgt.b   l_040_00F5A                     ; 00F44
        move.w  d1,d3                           ; 00F46
        add.w   (ViewY).l,d1                    ; 00F48
        add.w   (ViewY).l,d3                    ; 00F4E
        jsr     (DrawLine).l                    ; 00F54
l_040_00F5A:
        move.w  #$a,(DrawColour).l              ; 00F5A
        move.w  #$8d,d0                         ; 00F62
        add.w   (ViewX).l,d0                    ; 00F66
        cmpi.w  #$5,d0                          ; 00F6C
        blt.b   l_040_00F94                     ; 00F70
        move.w  #$5a,d1                         ; 00F72
        move.w  d0,d2                           ; 00F76
        addq.w  #$4,d2                          ; 00F78
        cmpi.w  #$13b,d2                        ; 00F7A
        bgt.b   l_040_00F94                     ; 00F7E
        move.w  d1,d3                           ; 00F80
        add.w   (ViewY).l,d1                    ; 00F82
        add.w   (ViewY).l,d3                    ; 00F88
        jsr     (DrawLine).l                    ; 00F8E
l_040_00F94:
        move.w  #$ad,d0                         ; 00F94
        add.w   (ViewX).l,d0                    ; 00F98
        cmpi.w  #$5,d0                          ; 00F9E
        blt.b   l_040_00FC6                     ; 00FA2
        move.w  #$5a,d1                         ; 00FA4
        move.w  d0,d2                           ; 00FA8
        addq.w  #$4,d2                          ; 00FAA
        cmpi.w  #$13b,d2                        ; 00FAC
        bgt.b   l_040_00FC6                     ; 00FB0
        move.w  d1,d3                           ; 00FB2
        add.w   (ViewY).l,d1                    ; 00FB4
        add.w   (ViewY).l,d3                    ; 00FBA
        jsr     (DrawLine).l                    ; 00FC0
l_040_00FC6:
        lea.l   (ObjectTable).l,a0              ; 00FC6
        adda.w  (ViewObject).l,a0               ; 00FCC
        move.b  $62(a0),d0                      ; 00FD2
        cmpi.b  #$10,d0                         ; 00FD6
        beq.b   l_040_00FEA                     ; 00FDA
        cmpi.b  #$11,d0                         ; 00FDC
        beq.b   l_040_00FEA                     ; 00FE0
        cmpi.b  #$12,d0                         ; 00FE2
        bne.w   l_040_01076                     ; 00FE6
l_040_00FEA:
        clr.w   (LoopIndex).l                   ; 00FEA
l_040_00FF0:
        lea.l   (dat_040_01308).l,a0            ; 00FF0
        adda.w  (LoopIndex).l,a0                ; 00FF6
        movem.w (a0),d0-d3                      ; 00FFC
        lea.l   (dat_040_01320).l,a0            ; 01000
        adda.w  (LoopIndex).l,a0                ; 01006
        move.w  (a0),(DrawColour).l             ; 0100C
        add.w   (ViewX).l,d0                    ; 01012
        bge.b   l_040_01026                     ; 01018
        clr.w   d0                              ; 0101A
        add.w   (ViewX).l,d2                    ; 0101C
        blt.b   l_040_01064                     ; 01022
        bra.b   l_040_01048                     ; 01024
l_040_01026:
        cmpi.w  #$13f,d0                        ; 01026
        ble.b   l_040_0103E                     ; 0102A
        move.w  #$13f,d0                        ; 0102C
        add.w   (ViewX).l,d2                    ; 01030
        cmpi.w  #$13f,d2                        ; 01036
        ble.b   l_040_01052                     ; 0103A
        bra.b   l_040_01064                     ; 0103C
l_040_0103E:
        add.w   (ViewX).l,d2                    ; 0103E
        bge.b   l_040_01048                     ; 01044
        clr.w   d2                              ; 01046
l_040_01048:
        cmpi.w  #$13f,d2                        ; 01048
        ble.b   l_040_01052                     ; 0104C
        move.w  #$13f,d2                        ; 0104E
l_040_01052:
        add.w   (ViewY).l,d1                    ; 01052
        add.w   (ViewY).l,d3                    ; 01058
        jsr     (DrawLine).l                    ; 0105E
l_040_01064:
        addq.w  #$4,(LoopIndex).l               ; 01064
        cmpi.w  #$14,(LoopIndex).l              ; 0106A
        blt.w   l_040_00FF0                     ; 01072
l_040_01076:
        rts                                     ; 01076

;-------------------------------------------------------------------------------
; DrawTargetBox - The head-up display's target box: with a weapon selected and a target on the
; screen (TargetScreenPos) the box (TargetBoxPos) moves towards it a few pixels a frame (faster
; with WarningFlags bit 14), then is drawn with DrawLine; apparently the seeker's lock.
;-------------------------------------------------------------------------------
DrawTargetBox:
        clr.w   (LoopIndex).l                   ; 01078
        move.w  #$a,(DrawColour).l              ; 0107E
l_040_01086:
        movem.w (TargetScreenPos).l,d0-d1       ; 01086
        tst.b   (WorldFrozen).l                 ; 0108E
        bne.w   l_040_011BC                     ; 01094
        movem.w (TargetBoxPos).l,d2-d3          ; 01098
        moveq   #$0,d5                          ; 010A0
        lea.l   (ObjectTable).l,a1              ; 010A2
        adda.w  (ViewObject).l,a1               ; 010A8
        move.b  $63(a1),d4                      ; 010AE
        andi.b  #$f0,d4                         ; 010B2
        beq.b   l_040_010BC                     ; 010B6
        tst.w   d0                              ; 010B8
        bgt.b   l_040_010C4                     ; 010BA
l_040_010BC:
        move.w  #$ffff,d4                       ; 010BC
        bra.w   l_040_011B0                     ; 010C0
l_040_010C4:
        tst.w   d2                              ; 010C4
        bgt.b   l_040_010D4                     ; 010C6
        move.w  #$9f,d4                         ; 010C8
        move.w  #$5b,d2                         ; 010CC
        bra.w   l_040_011B0                     ; 010D0
l_040_010D4:
        move.l  (WarningFlags).l,d6             ; 010D4
        andi.l  #$4000,d6                       ; 010DA
        bne.b   l_040_010E8                     ; 010E0
        moveq   #$4,d6                          ; 010E2
        moveq   #$2,d7                          ; 010E4
        bra.b   l_040_010EC                     ; 010E6
l_040_010E8:
        moveq   #$2,d6                          ; 010E8
        moveq   #$1,d7                          ; 010EA
l_040_010EC:
        move.w  d2,d4                           ; 010EC
        sub.w   d0,d2                           ; 010EE
        bge.b   l_040_01120                     ; 010F0
        cmpi.w  #$fff1,d2                       ; 010F2
        blt.b   l_040_01104                     ; 010F6
        asr.w   d7,d2                           ; 010F8
        cmpi.w  #$fffb,d2                       ; 010FA
        blt.b   l_040_01106                     ; 010FE
        addq.w  #$1,d5                          ; 01100
        bra.b   l_040_01106                     ; 01102
l_040_01104:
        asr.w   d6,d2                           ; 01104
l_040_01106:
        cmpi.w  #$1,d7                          ; 01106
        beq.b   l_040_01116                     ; 0110A
        cmpi.w  #$ffff,d2                       ; 0110C
        bge.b   l_040_0114C                     ; 01110
        moveq   #-1,d2                          ; 01112
        bra.b   l_040_0114C                     ; 01114
l_040_01116:
        cmpi.w  #$fffe,d2                       ; 01116
        bge.b   l_040_0114C                     ; 0111A
        moveq   #-2,d2                          ; 0111C
        bra.b   l_040_0114C                     ; 0111E
l_040_01120:
        cmpi.w  #$f,d2                          ; 01120
        bgt.b   l_040_01132                     ; 01124
        asr.w   d7,d2                           ; 01126
        cmpi.w  #$5,d2                          ; 01128
        bgt.b   l_040_01134                     ; 0112C
        addq.w  #$1,d5                          ; 0112E
        bra.b   l_040_01134                     ; 01130
l_040_01132:
        asr.w   d6,d2                           ; 01132
l_040_01134:
        cmpi.w  #$1,d7                          ; 01134
        beq.b   l_040_01144                     ; 01138
        cmpi.w  #$1,d2                          ; 0113A
        ble.b   l_040_0114C                     ; 0113E
        moveq   #$1,d2                          ; 01140
        bra.b   l_040_0114C                     ; 01142
l_040_01144:
        cmpi.w  #$2,d2                          ; 01144
        ble.b   l_040_0114C                     ; 01148
        moveq   #$2,d2                          ; 0114A
l_040_0114C:
        sub.w   d2,d4                           ; 0114C
        move.w  d3,d2                           ; 0114E
        sub.w   d1,d3                           ; 01150
        bge.b   l_040_01182                     ; 01152
        cmpi.w  #$fff1,d3                       ; 01154
        blt.b   l_040_01166                     ; 01158
        asr.w   d7,d3                           ; 0115A
        cmpi.w  #$fffb,d3                       ; 0115C
        blt.b   l_040_01168                     ; 01160
        addq.w  #$1,d5                          ; 01162
        bra.b   l_040_01168                     ; 01164
l_040_01166:
        asr.w   d6,d3                           ; 01166
l_040_01168:
        cmpi.w  #$1,d7                          ; 01168
        beq.b   l_040_01178                     ; 0116C
        cmpi.w  #$ffff,d3                       ; 0116E
        bge.b   l_040_011AE                     ; 01172
        moveq   #-1,d3                          ; 01174
        bra.b   l_040_011AE                     ; 01176
l_040_01178:
        cmpi.w  #$fffe,d3                       ; 01178
        bge.b   l_040_011AE                     ; 0117C
        moveq   #-2,d3                          ; 0117E
        bra.b   l_040_011AE                     ; 01180
l_040_01182:
        cmpi.w  #$f,d3                          ; 01182
        bgt.b   l_040_01194                     ; 01186
        asr.w   d7,d3                           ; 01188
        cmpi.w  #$5,d3                          ; 0118A
        bgt.b   l_040_01196                     ; 0118E
        addq.w  #$1,d5                          ; 01190
        bra.b   l_040_01196                     ; 01192
l_040_01194:
        asr.w   d6,d3                           ; 01194
l_040_01196:
        cmpi.w  #$1,d7                          ; 01196
        beq.b   l_040_011A6                     ; 0119A
        cmpi.w  #$1,d3                          ; 0119C
        ble.b   l_040_011AE                     ; 011A0
        moveq   #$1,d3                          ; 011A2
        bra.b   l_040_011AE                     ; 011A4
l_040_011A6:
        cmpi.w  #$2,d3                          ; 011A6
        ble.b   l_040_011AE                     ; 011AA
        moveq   #$2,d3                          ; 011AC
l_040_011AE:
        sub.w   d3,d2                           ; 011AE
l_040_011B0:
        move.w  d4,(TargetBoxPos).l             ; 011B0
        move.w  d2,(dat_071_00314).l            ; 011B6
l_040_011BC:
        tst.w   (Player_56).l                   ; 011BC
        beq.b   l_040_011DC                     ; 011C2
        move.w  (Player_16).l,d2                ; 011C4
        andi.w  #$1c,d2                         ; 011CA
        lea.l   (dat_040_012E8).l,a0            ; 011CE
        add.w   (a0,d2.w),d0                    ; 011D4
        add.w   $2(a0,d2.w),d1                  ; 011D8
l_040_011DC:
        add.w   (ViewX).l,d0                    ; 011DC
        add.w   (ViewY).l,d1                    ; 011E2
        move.w  d0,d2                           ; 011E8
        ble.w   l_040_012E6                     ; 011EA
        move.w  d1,d3                           ; 011EE
        ble.w   l_040_012E6                     ; 011F0
        lea.l   (dat_040_01334).l,a0            ; 011F4
        adda.w  (LoopIndex).l,a0                ; 011FA
        add.w   (a0),d0                         ; 01200
        bge.b   l_040_01206                     ; 01202
        clr.w   d0                              ; 01204
l_040_01206:
        cmpi.w  #$13f,d0                        ; 01206
        ble.b   l_040_01210                     ; 0120A
        move.w  #$13f,d0                        ; 0120C
l_040_01210:
        add.w   $4(a0),d2                       ; 01210
        bge.b   l_040_01218                     ; 01214
        clr.w   d2                              ; 01216
l_040_01218:
        cmpi.w  #$13f,d2                        ; 01218
        ble.b   l_040_01222                     ; 0121C
        move.w  #$13f,d2                        ; 0121E
l_040_01222:
        add.w   $2(a0),d1                       ; 01222
        add.w   $6(a0),d3                       ; 01226
        add.w   (ViewY).l,d1                    ; 0122A
        add.w   (ViewY).l,d3                    ; 01230
        move.w  (dat_040_01308).l,d4            ; 01236
        addq.w  #$1,d4                          ; 0123C
        add.w   (ViewX).l,d4                    ; 0123E
        cmpi.w  #$13f,d4                        ; 01244
        bgt.b   l_040_012C2                     ; 01248
        cmp.w   d4,d0                           ; 0124A
        bge.b   l_040_01258                     ; 0124C
        cmp.w   d0,d2                           ; 0124E
        bne.b   l_040_01256                     ; 01250
        tst.w   (a0)                            ; 01252
        blt.b   l_040_012C2                     ; 01254
l_040_01256:
        move.w  d4,d0                           ; 01256
l_040_01258:
        cmp.w   d4,d2                           ; 01258
        bge.b   l_040_0125E                     ; 0125A
        move.w  d4,d2                           ; 0125C
l_040_0125E:
        move.w  (dat_040_01318).l,d4            ; 0125E
        subq.w  #$1,d4                          ; 01264
        add.w   (ViewX).l,d4                    ; 01266
        blt.b   l_040_012C2                     ; 0126C
        cmp.w   d4,d0                           ; 0126E
        ble.b   l_040_0127C                     ; 01270
        cmp.w   d0,d2                           ; 01272
        bne.b   l_040_0127A                     ; 01274
        tst.w   (a0)                            ; 01276
        bge.b   l_040_012C2                     ; 01278
l_040_0127A:
        move.w  d4,d0                           ; 0127A
l_040_0127C:
        cmp.w   d4,d2                           ; 0127C
        ble.b   l_040_01282                     ; 0127E
        move.w  d4,d2                           ; 01280
l_040_01282:
        move.w  (dat_040_0130E).l,d4            ; 01282
        add.w   (ViewY).l,d4                    ; 01288
        cmp.w   d4,d1                           ; 0128E
        bge.b   l_040_0129E                     ; 01290
        cmp.w   d1,d3                           ; 01292
        bne.b   l_040_0129C                     ; 01294
        tst.w   $2(a0)                          ; 01296
        blt.b   l_040_012C2                     ; 0129A
l_040_0129C:
        move.w  d4,d1                           ; 0129C
l_040_0129E:
        cmp.w   d4,d3                           ; 0129E
        bge.b   l_040_012A4                     ; 012A0
        move.w  d4,d3                           ; 012A2
l_040_012A4:
        move.w  (dat_040_0130A).l,d4            ; 012A4
        add.w   (ViewY).l,d4                    ; 012AA
        cmp.w   d4,d1                           ; 012B0
        ble.b   l_040_012B6                     ; 012B2
        move.w  d4,d1                           ; 012B4
l_040_012B6:
        cmp.w   d4,d3                           ; 012B6
        ble.b   l_040_012BC                     ; 012B8
        move.w  d4,d3                           ; 012BA
l_040_012BC:
        jsr     (DrawLine).l                    ; 012BC
l_040_012C2:
        addq.w  #$4,(LoopIndex).l               ; 012C2
        cmpi.w  #$10,(LoopIndex).l              ; 012C8
        blt.w   l_040_01086                     ; 012D0
        move.l  (TargetScreenPos).l,(SeekerPos).l ; 012D4
        move.w  #$ffff,(TargetScreenPos).l      ; 012DE
l_040_012E6:
        rts                                     ; 012E6
dat_040_012E8:
	dc.b	$00,$00,$00,$00,$00,$00,$00,$01,$00,$01,$00,$00,$00,$01,$00,$01
	dc.b	$00,$00,$00,$00,$00,$00,$FF,$FF,$FF,$FF,$00,$00,$FF,$FF,$FF,$FF
dat_040_01308:
	dc.b	$00,$55
dat_040_0130A:
	dc.b	$00,$90,$00,$55
dat_040_0130E:
	dc.b	$00,$2D,$00,$5D,$00,$24,$00,$E1,$00,$24
dat_040_01318:
	dc.b	$00,$E9,$00,$2D,$00,$E9,$00,$90
dat_040_01320:
	dc.b	$00,$00,$00,$00,$00,$08,$00,$00,$00,$0A,$00,$00,$00,$08,$00,$00
	dc.b	$00,$00,$00,$00
dat_040_01334:
	dc.b	$FF,$F7,$00,$08,$FF,$F7,$FF,$F8,$00,$09,$FF,$F8,$00,$09,$00,$08
	dc.b	$FF,$F7,$00,$08

;-------------------------------------------------------------------------------
; DrawHUDShape - Draws a shape of point offsets (a0: byte pairs, d2 of them) round (d0, d1),
; only inside the head-up display: the gun pipper.
;-------------------------------------------------------------------------------
DrawHUDShape:
        link.w  a6,#$fff0                       ; 01348
        move.w  d0,-$2(a6)                      ; 0134C
        move.w  d1,-$4(a6)                      ; 01350
        move.w  d2,-$e(a6)                      ; 01354
        cmpi.w  #$e,d0                          ; 01358
        ble.w   l_040_0143E                     ; 0135C
        cmpi.w  #$132,d0                        ; 01360
        bge.w   l_040_0143E                     ; 01364
        move.w  #$63,d2                         ; 01368
        add.w   (ViewX).l,d2                    ; 0136C
        cmp.w   d2,d0                           ; 01372
        ble.w   l_040_0143E                     ; 01374
        move.w  #$db,d2                         ; 01378
        add.w   (ViewX).l,d2                    ; 0137C
        cmp.w   d2,d0                           ; 01382
        bge.w   l_040_0143E                     ; 01384
        cmpi.w  #$39,d1                         ; 01388
        ble.w   l_040_0143E                     ; 0138C
        cmpi.w  #$84,d1                         ; 01390
        bge.w   l_040_0143E                     ; 01394
l_040_01398:
        move.b  (a0)+,d0                        ; 01398
        move.b  (a0)+,d1                        ; 0139A
        blt.b   l_040_013C0                     ; 0139C
        neg.b   d1                              ; 0139E
        ext.w   d0                              ; 013A0
        ext.w   d1                              ; 013A2
        add.w   -$2(a6),d0                      ; 013A4
        add.w   -$4(a6),d1                      ; 013A8
        move.l  a0,-(a7)                        ; 013AC
        jsr     (Plot).l                        ; 013AE
        movea.l (a7)+,a0                        ; 013B4
        subq.w  #$1,-$e(a6)                     ; 013B6
        blt.w   l_040_0143A                     ; 013BA
        bra.b   l_040_01398                     ; 013BE
l_040_013C0:
        subq.w  #$2,a0                          ; 013C0
l_040_013C2:
        move.b  -(a0),d1                        ; 013C2
        move.b  -(a0),d0                        ; 013C4
        blt.b   l_040_013E8                     ; 013C6
        subq.b  #$1,d1                          ; 013C8
        ext.w   d0                              ; 013CA
        ext.w   d1                              ; 013CC
        add.w   -$2(a6),d0                      ; 013CE
        add.w   -$4(a6),d1                      ; 013D2
        move.l  a0,-(a7)                        ; 013D6
        jsr     (Plot).l                        ; 013D8
        movea.l (a7)+,a0                        ; 013DE
        subq.w  #$1,-$e(a6)                     ; 013E0
        blt.b   l_040_0143A                     ; 013E4
        bra.b   l_040_013C2                     ; 013E6
l_040_013E8:
        addq.w  #$2,a0                          ; 013E8
l_040_013EA:
        move.b  (a0)+,d0                        ; 013EA
        move.b  (a0)+,d1                        ; 013EC
        blt.b   l_040_01412                     ; 013EE
        neg.b   d0                              ; 013F0
        subq.b  #$1,d1                          ; 013F2
        ext.w   d0                              ; 013F4
        ext.w   d1                              ; 013F6
        add.w   -$2(a6),d0                      ; 013F8
        add.w   -$4(a6),d1                      ; 013FC
        move.l  a0,-(a7)                        ; 01400
        jsr     (Plot).l                        ; 01402
        movea.l (a7)+,a0                        ; 01408
        subq.w  #$1,-$e(a6)                     ; 0140A
        blt.b   l_040_0143A                     ; 0140E
        bra.b   l_040_013EA                     ; 01410
l_040_01412:
        subq.w  #$2,a0                          ; 01412
l_040_01414:
        move.b  -(a0),d1                        ; 01414
        move.b  -(a0),d0                        ; 01416
        blt.b   l_040_0143A                     ; 01418
        neg.b   d0                              ; 0141A
        neg.b   d1                              ; 0141C
        ext.w   d0                              ; 0141E
        ext.w   d1                              ; 01420
        add.w   -$2(a6),d0                      ; 01422
        add.w   -$4(a6),d1                      ; 01426
        move.l  a0,-(a7)                        ; 0142A
        jsr     (Plot).l                        ; 0142C
        movea.l (a7)+,a0                        ; 01432
        subq.w  #$1,-$e(a6)                     ; 01434
        bge.b   l_040_01414                     ; 01438
l_040_0143A:
        unlk    a6                              ; 0143A
        rts                                     ; 0143C
l_040_0143E:
        move.w  #$55,d0                         ; 0143E
        add.w   (ViewX).l,d0                    ; 01442
        move.w  d0,-$6(a6)                      ; 01448
        move.w  #$e9,d0                         ; 0144C
        add.w   (ViewX).l,d0                    ; 01450
        move.w  d0,-$8(a6)                      ; 01456
        move.w  #$2d,-$a(a6)                    ; 0145A
        move.w  #$90,-$c(a6)                    ; 01460
l_040_01466:
        move.b  (a0)+,d0                        ; 01466
        move.b  (a0)+,d1                        ; 01468
        blt.b   l_040_014B2                     ; 0146A
        neg.b   d1                              ; 0146C
        ext.w   d0                              ; 0146E
        ext.w   d1                              ; 01470
        add.w   -$2(a6),d0                      ; 01472
        add.w   -$4(a6),d1                      ; 01476
        cmpi.w  #$e,d0                          ; 0147A
        ble.b   l_040_014A8                     ; 0147E
        cmpi.w  #$132,d0                        ; 01480
        bge.b   l_040_014A8                     ; 01484
        cmp.w   -$6(a6),d0                      ; 01486
        ble.b   l_040_014A8                     ; 0148A
        cmp.w   -$8(a6),d0                      ; 0148C
        bge.b   l_040_014A8                     ; 01490
        cmp.w   -$a(a6),d1                      ; 01492
        ble.b   l_040_014A8                     ; 01496
        cmp.w   -$c(a6),d1                      ; 01498
        bge.b   l_040_014A8                     ; 0149C
        move.l  a0,-(a7)                        ; 0149E
        jsr     (Plot).l                        ; 014A0
        movea.l (a7)+,a0                        ; 014A6
l_040_014A8:
        subq.w  #$1,-$e(a6)                     ; 014A8
        blt.w   l_040_01596                     ; 014AC
        bra.b   l_040_01466                     ; 014B0
l_040_014B2:
        subq.w  #$2,a0                          ; 014B2
l_040_014B4:
        move.b  -(a0),d1                        ; 014B4
        move.b  -(a0),d0                        ; 014B6
        blt.b   l_040_014FE                     ; 014B8
        ext.w   d0                              ; 014BA
        ext.w   d1                              ; 014BC
        add.w   -$2(a6),d0                      ; 014BE
        add.w   -$4(a6),d1                      ; 014C2
        cmpi.w  #$e,d0                          ; 014C6
        ble.b   l_040_014F4                     ; 014CA
        cmpi.w  #$132,d0                        ; 014CC
        bge.b   l_040_014F4                     ; 014D0
        cmp.w   -$6(a6),d0                      ; 014D2
        ble.b   l_040_014F4                     ; 014D6
        cmp.w   -$8(a6),d0                      ; 014D8
        bge.b   l_040_014F4                     ; 014DC
        cmp.w   -$a(a6),d1                      ; 014DE
        ble.b   l_040_014F4                     ; 014E2
        cmp.w   -$c(a6),d1                      ; 014E4
        bge.b   l_040_014F4                     ; 014E8
        move.l  a0,-(a7)                        ; 014EA
        jsr     (Plot).l                        ; 014EC
        movea.l (a7)+,a0                        ; 014F2
l_040_014F4:
        subq.w  #$1,-$e(a6)                     ; 014F4
        blt.w   l_040_01596                     ; 014F8
        bra.b   l_040_014B4                     ; 014FC
l_040_014FE:
        addq.w  #$2,a0                          ; 014FE
l_040_01500:
        move.b  (a0)+,d0                        ; 01500
        move.b  (a0)+,d1                        ; 01502
        blt.b   l_040_0154A                     ; 01504
        neg.b   d0                              ; 01506
        ext.w   d0                              ; 01508
        ext.w   d1                              ; 0150A
        add.w   -$2(a6),d0                      ; 0150C
        add.w   -$4(a6),d1                      ; 01510
        cmpi.w  #$e,d0                          ; 01514
        ble.b   l_040_01542                     ; 01518
        cmpi.w  #$132,d0                        ; 0151A
        bge.b   l_040_01542                     ; 0151E
        cmp.w   -$6(a6),d0                      ; 01520
        ble.b   l_040_01542                     ; 01524
        cmp.w   -$8(a6),d0                      ; 01526
        bge.b   l_040_01542                     ; 0152A
        cmp.w   -$a(a6),d1                      ; 0152C
        ble.b   l_040_01542                     ; 01530
        cmp.w   -$c(a6),d1                      ; 01532
        bge.b   l_040_01542                     ; 01536
        move.l  a0,-(a7)                        ; 01538
        jsr     (Plot).l                        ; 0153A
        movea.l (a7)+,a0                        ; 01540
l_040_01542:
        subq.w  #$1,-$e(a6)                     ; 01542
        blt.b   l_040_01596                     ; 01546
        bra.b   l_040_01500                     ; 01548
l_040_0154A:
        subq.w  #$2,a0                          ; 0154A
l_040_0154C:
        move.b  -(a0),d1                        ; 0154C
        move.b  -(a0),d0                        ; 0154E
        blt.b   l_040_01596                     ; 01550
        neg.b   d0                              ; 01552
        neg.b   d1                              ; 01554
        ext.w   d0                              ; 01556
        ext.w   d1                              ; 01558
        add.w   -$2(a6),d0                      ; 0155A
        add.w   -$4(a6),d1                      ; 0155E
        cmpi.w  #$e,d0                          ; 01562
        ble.b   l_040_01590                     ; 01566
        cmpi.w  #$132,d0                        ; 01568
        bge.b   l_040_01590                     ; 0156C
        cmp.w   -$6(a6),d0                      ; 0156E
        ble.b   l_040_01590                     ; 01572
        cmp.w   -$8(a6),d0                      ; 01574
        bge.b   l_040_01590                     ; 01578
        cmp.w   -$a(a6),d1                      ; 0157A
        ble.b   l_040_01590                     ; 0157E
        cmp.w   -$c(a6),d1                      ; 01580
        bge.b   l_040_01590                     ; 01584
        move.l  a0,-(a7)                        ; 01586
        jsr     (Plot).l                        ; 01588
        movea.l (a7)+,a0                        ; 0158E
l_040_01590:
        subq.w  #$1,-$e(a6)                     ; 01590
        bge.b   l_040_0154C                     ; 01594
l_040_01596:
        unlk    a6                              ; 01596
        rts                                     ; 01598

;-------------------------------------------------------------------------------
; DrawRangeArc - The gun sight's range bar: d2 points of the circle (a0) from its start, so its
; length shows the range.
;-------------------------------------------------------------------------------
DrawRangeArc:
        link.w  a6,#$fff0                       ; 0159A
        move.w  d0,-$2(a6)                      ; 0159E
        move.w  d1,-$4(a6)                      ; 015A2
        move.w  d2,-$e(a6)                      ; 015A6
        move.w  #$55,d0                         ; 015AA
        add.w   (ViewX).l,d0                    ; 015AE
        move.w  d0,-$6(a6)                      ; 015B4
        move.w  #$e9,d0                         ; 015B8
        add.w   (ViewX).l,d0                    ; 015BC
        move.w  d0,-$8(a6)                      ; 015C2
        move.w  #$2d,-$a(a6)                    ; 015C6
        move.w  #$90,-$c(a6)                    ; 015CC
l_040_015D2:
        move.b  (a0)+,d0                        ; 015D2
        move.b  (a0)+,d1                        ; 015D4
        blt.b   l_040_015E2                     ; 015D6
        neg.b   d1                              ; 015D8
        subq.w  #$1,-$e(a6)                     ; 015DA
        blt.b   l_040_0161E                     ; 015DE
        bra.b   l_040_015D2                     ; 015E0
l_040_015E2:
        subq.w  #$2,a0                          ; 015E2
        subq.w  #$1,-$4(a6)                     ; 015E4
l_040_015E8:
        move.b  -(a0),d1                        ; 015E8
        move.b  -(a0),d0                        ; 015EA
        blt.b   l_040_015F6                     ; 015EC
        subq.w  #$1,-$e(a6)                     ; 015EE
        blt.b   l_040_0161E                     ; 015F2
        bra.b   l_040_015E8                     ; 015F4
l_040_015F6:
        addq.w  #$2,a0                          ; 015F6
l_040_015F8:
        move.b  (a0)+,d0                        ; 015F8
        move.b  (a0)+,d1                        ; 015FA
        blt.b   l_040_01608                     ; 015FC
        neg.b   d0                              ; 015FE
        subq.w  #$1,-$e(a6)                     ; 01600
        blt.b   l_040_0161E                     ; 01604
        bra.b   l_040_015F8                     ; 01606
l_040_01608:
        subq.w  #$2,a0                          ; 01608
        addq.w  #$1,-$4(a6)                     ; 0160A
l_040_0160E:
        move.b  -(a0),d1                        ; 0160E
        move.b  -(a0),d0                        ; 01610
        blt.b   l_040_01654                     ; 01612
        neg.b   d0                              ; 01614
        neg.b   d1                              ; 01616
        subq.w  #$1,-$e(a6)                     ; 01618
        bge.b   l_040_0160E                     ; 0161C
l_040_0161E:
        ext.w   d0                              ; 0161E
        ext.w   d1                              ; 01620
        add.w   -$2(a6),d0                      ; 01622
        add.w   -$4(a6),d1                      ; 01626
        cmpi.w  #$2,d0                          ; 0162A
        ble.b   l_040_01654                     ; 0162E
        cmpi.w  #$13e,d0                        ; 01630
        bge.b   l_040_01654                     ; 01634
        cmp.w   -$6(a6),d0                      ; 01636
        ble.b   l_040_01654                     ; 0163A
        cmp.w   -$8(a6),d0                      ; 0163C
        bge.b   l_040_01654                     ; 01640
        cmp.w   -$a(a6),d1                      ; 01642
        ble.b   l_040_01654                     ; 01646
        cmp.w   -$c(a6),d1                      ; 01648
        bge.b   l_040_01654                     ; 0164C
        jsr     (PlotBigAbove).l                ; 0164E
l_040_01654:
        unlk    a6                              ; 01654
        rts                                     ; 01656
l_040_01658:
        rts                                     ; 01658

;-------------------------------------------------------------------------------
; DrawSeekerSymbol - The seeker's symbol at (d0, d1): steady while searching (d4 = 0, the shape
; dat_040_01778), flashing (three frames in four) with a target (d4 = 1); only inside the head-
; up display.
;-------------------------------------------------------------------------------
DrawSeekerSymbol:
        tst.w   d4                              ; 0165A
        bne.b   l_040_0167E                     ; 0165C
        cmpi.w  #$58,d0                         ; 0165E
        ble.b   l_040_01658                     ; 01662
        cmpi.w  #$e6,d0                         ; 01664
        bge.b   l_040_01658                     ; 01668
        cmpi.w  #$27,d1                         ; 0166A
        ble.b   l_040_01658                     ; 0166E
        cmpi.w  #$8d,d1                         ; 01670
        bge.b   l_040_01658                     ; 01674
        lea.l   (dat_040_01778).l,a0            ; 01676
        bra.b   l_040_016A8                     ; 0167C
l_040_0167E:
        move.w  (FrameCount).l,d2               ; 0167E
        andi.w  #$3,d2                          ; 01684
        beq.b   l_040_01658                     ; 01688
        cmpi.w  #$60,d0                         ; 0168A
        ble.b   l_040_01658                     ; 0168E
        cmpi.w  #$de,d0                         ; 01690
        bge.b   l_040_01658                     ; 01694
        cmpi.w  #$2e,d1                         ; 01696
        ble.b   l_040_016F0                     ; 0169A
        cmpi.w  #$86,d1                         ; 0169C
        bge.b   l_040_016F0                     ; 016A0
        lea.l   (dat_040_01792).l,a0            ; 016A2
l_040_016A8:
        add.w   (ViewX).l,d0                    ; 016A8
        cmpi.w  #$a,d0                          ; 016AE
        blt.b   l_040_016F0                     ; 016B2
        cmpi.w  #$136,d0                        ; 016B4
        bgt.b   l_040_016F0                     ; 016B8
        add.w   (ViewY).l,d1                    ; 016BA
        link.w  a6,#$fff0                       ; 016C0
        move.w  d0,-$2(a6)                      ; 016C4
        move.w  d1,-$4(a6)                      ; 016C8
l_040_016CC:
        move.b  (a0)+,d0                        ; 016CC
        move.b  (a0)+,d1                        ; 016CE
        move.b  d0,d2                           ; 016D0
        or.b    d1,d2                           ; 016D2
        beq.b   l_040_016EE                     ; 016D4
        ext.w   d0                              ; 016D6
        ext.w   d1                              ; 016D8
        add.w   -$2(a6),d0                      ; 016DA
        add.w   -$4(a6),d1                      ; 016DE
        move.l  a0,-(a7)                        ; 016E2
        jsr     (Plot).l                        ; 016E4
        movea.l (a7)+,a0                        ; 016EA
        bra.b   l_040_016CC                     ; 016EC
l_040_016EE:
        unlk    a6                              ; 016EE
l_040_016F0:
        rts                                     ; 016F0
	dc.b	$FF,$FF
dat_040_016F4:
	dc.b	$00,$0C,$01,$0C,$02,$0C,$03,$0C,$04,$0C,$05,$0B,$06,$0B,$07,$0B
	dc.b	$08,$0A,$09,$0A,$0A,$09,$0B,$08,$0C,$07,$0D,$06,$0D,$05,$0E,$04
	dc.b	$0E,$03,$0E,$02,$0E,$01,$0E,$00,$FF,$FF
dat_040_0171E:
	dc.b	$00,$0B,$01,$0B,$02,$0B,$03,$0B,$04,$0B,$05,$0A,$06,$0A,$07,$0A
	dc.b	$08,$09,$09,$09,$0A,$08,$0B,$07,$0C,$06,$0C,$05,$0D,$04,$0D,$03
	dc.b	$0D,$02,$0D,$01,$0D,$00,$FF,$FF,$FF,$FF,$00,$0E,$01,$0E,$02,$0E
	dc.b	$03,$0E,$04,$0E,$05,$0E,$06,$0D,$07,$0D,$08,$0D,$09,$0C,$0A,$0C
	dc.b	$0B,$0B,$0C,$0A,$0D,$09,$0E,$08,$0F,$07,$0F,$06,$0F,$05,$10,$04
	dc.b	$10,$03,$10,$02,$10,$01,$10,$00,$FF,$FF
dat_040_01778:
	dc.b	$00,$03,$01,$02,$02,$01,$03,$00,$02,$FF,$01,$FE,$00,$FD,$FF,$FE
	dc.b	$FE,$FF,$FD,$00,$FE,$01,$FF,$02,$00,$00
dat_040_01792:
	dc.b	$00,$09,$01,$08,$02,$07,$03,$06,$04,$05,$05,$04,$06,$03,$07,$02
	dc.b	$08,$01,$09,$00,$0A,$00,$0A,$FF,$09,$FF,$08,$FE,$07,$FD,$06,$FC
	dc.b	$05,$FB,$04,$FA,$03,$F9,$02,$F8,$01,$F7,$00,$F6,$FF,$F6,$FE,$F7
	dc.b	$FD,$F8,$FC,$F9,$FB,$FA,$FA,$FB,$F9,$FC,$F8,$FD,$F7,$FE,$F6,$FF
	dc.b	$F5,$FF,$F5,$00,$F6,$00,$F7,$01,$F8,$02,$F9,$03,$FA,$04,$FB,$05
	dc.b	$FC,$06,$FD,$07,$FE,$08,$FF,$09,$00,$00
h040_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    17,40                           ; 17 longs pointing into hunk 40
	dc.l	$16A4,$1678,$12A6,$1284,$1260,$1238,$11F6,$11D0
	dc.l	$1002,$FF2,$A1E,$9DA,$6E4,$698,$644,$3C6
	dc.l	$19C
        dc.l    233,71                          ; 233 longs pointing into hunk 71
	dc.l	$8E4,$A4C,$A5C,$C20,$A56,$A62,$AA2,$5E
	dc.l	$96C,$988,$996,$99E,$C2A,$C52,$C5E,$C72
	dc.l	$C7A,$C86,$C90,$CEE,$B4E,$B60,$BEA,$BF4
	dc.l	$C98,$CC8,$CD2,$10D6,$980,$9A8,$B6A,$C4A
	dc.l	$C6A,$CDC,$12E,$FEC,$FF8,$1008,$1066,$106E
	dc.l	$107A,$11FC,$12C4,$12CC,$11BE,$11C6,$262,$484
	dc.l	$63C,$D7A,$DC8,$E18,$E86,$166,$388,$D0E
	dc.l	$D28,$D42,$29A,$2D8,$332,$4A8,$4CA,$50A
	dc.l	$658,$676,$6D4,$1D8,$216,$222,$228,$22E
	dc.l	$23A,$2A4,$2D2,$2F6,$2FC,$32C,$404,$442
	dc.l	$44E,$454,$45A,$466,$4AE,$4C4,$4E6,$4EC
	dc.l	$504,$5C8,$5F4,$60A,$610,$616,$622,$65E
	dc.l	$670,$68A,$692,$6AC,$6B2,$6BE,$6CE,$174
	dc.l	$1CC,$20A,$240,$39E,$3F8,$436,$46C,$5BC
	dc.l	$5E8,$628,$906,$920,$974,$9EC,$B72,$C16
	dc.l	$A3C,$A6E,$1090,$B96,$109C,$11B2,$11B8,$A8A
	dc.l	$B36,$B3E,$B46,$92C,$93E,$954,$9B0,$9C4
	dc.l	$9F8,$AE6,$918,$936,$94E,$BC2,$12DA,$108A
	dc.l	$12D6,$12E2,$8E,$C32,$CB0,$1680,$6A,$EF4
	dc.l	$CA,$11C,$9E2,$A26,$CE4,$EFC,$F5E,$100E
	dc.l	$1082,$C2,$25C,$47E,$552,$6FC,$89C,$8A2
	dc.l	$8CC,$8D2,$9D0,$9FE,$F4A,$F50,$F84,$F8A
	dc.l	$FB6,$FBC,$1054,$105A,$11E4,$122C,$1232,$128A
	dc.l	$12AC,$16BC,$AC,$250,$53C,$578,$880,$8B0
	dc.l	$D5E,$E48,$E8C,$EAC,$F2E,$F68,$F9A,$1014
	dc.l	$101E,$1032,$1040,$11DE,$1240,$1268,$136E,$137E
	dc.l	$1444,$1452,$15B0,$15BE,$16AA,$128,$366,$5AC
	dc.l	$8F2,$A0A,$A82,$B80,$FCE,$10AA,$122,$360
	dc.l	$5A6,$8EC,$A04,$A7C,$B7A,$FC8,$10A4,$70
	dc.l	$136
        dc.l    50,36                           ; 50 longs pointing into hunk 36
	dc.l	$2C8,$322,$566,$58E,$9BC,$E1E,$F0A,$274
	dc.l	$56E,$598,$E28,$E6C,$ED0,$F14,$F1C,$1650
	dc.l	$D4,$E4,$F4,$106,$112,$558,$580,$D82
	dc.l	$DBA,$DFE,$5A0,$DAE,$DF2,$E64,$E78,$EC8
	dc.l	$EDC,$F24,$13B0,$13DA,$1404,$142E,$14A2,$14EE
	dc.l	$153C,$158A,$16E6,$8A8,$8D8,$F56,$F90,$FC2
	dc.l	$1060,$12BE
        dc.l    1,35                            ; 1 longs pointing into hunk 35
	dc.l	$ADE
        dc.l    10,39                           ; 10 longs pointing into hunk 39
	dc.l	$1B8,$3E2,$D54,$192,$3BC,$96,$A68,$98E
	dc.l	$CF6,$88
        dc.l    11,20                           ; 11 longs pointing into hunk 20
	dc.l	$234,$460,$61C,$17A,$1D2,$210,$3A4,$3FE
	dc.l	$43C,$5C2,$5EE
	dc.l	0
	dc.l	HUNK_END
	endc
