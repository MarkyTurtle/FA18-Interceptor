; F/A-18 Interceptor - hunk 31 (code)
; Lines drawn relative to the camera (DrawLine) (not worked out yet)
; Included by ../f18_main.s.

;===============================================================================
; Hunk 31: CODE, $75C bytes
;===============================================================================
	CODE_HUNK	h031

;-------------------------------------------------------------------------------
; DrawBullet - Draws a bullet (its number on the stack) as an orange point (colour 9) at its
; place relative to the camera.
;-------------------------------------------------------------------------------
DrawBullet:
        link.w  a6,#$ffc2                       ; 00000
        move.l  $8(a6),d0                       ; 00004
        asl.w   #$6,d0                          ; 00008
        lea.l   (Bullets).l,a3                  ; 0000A
        adda.w  d0,a3                           ; 00010
        move.w  #$9,(DrawColour).l              ; 00012
l_031_0001A:
        move.w  $30(a3),d3                      ; 0001A
        sub.w   (ViewCellX).l,d3                ; 0001E
        asl.w   #$8,d3                          ; 00024
        asl.w   #$6,d3                          ; 00026
        ext.l   d3                              ; 00028
        move.w  $32(a3),d5                      ; 0002A
        sub.w   (ViewCellZ).l,d5                ; 0002E
        asl.w   #$8,d5                          ; 00034
        asl.w   #$6,d5                          ; 00036
        ext.l   d5                              ; 00038
        move.l  $0(a3),d4                       ; 0003A
        asr.l   #$8,d4                          ; 0003E
        add.w   d4,d3                           ; 00040
        add.w   (ViewOffsetX8).l,d3             ; 00042
        move.l  $8(a3),d4                       ; 00048
        asr.l   #$8,d4                          ; 0004C
        add.w   d4,d5                           ; 0004E
        add.w   (ViewOffsetZ8).l,d5             ; 00050
        move.l  $4(a3),d4                       ; 00056
        add.l   (ViewOffsetY).l,d4              ; 0005A
        asr.l   #$8,d4                          ; 00060
        bsr.w   TurnToView                      ; 00062
        move.w  d6,d0                           ; 00066
        move.w  d2,d1                           ; 00068
        move.w  d5,d2                           ; 0006A
        jsr     (sub_035_00038).l               ; 0006C
        beq.b   l_031_0007E                     ; 00072
        move.w  $26(a3),d0                      ; 00074
        andi.w  #$202,d0                        ; 00078
        beq.b   l_031_00084                     ; 0007C
l_031_0007E:
        andi.w  #$fdff,$26(a3)                  ; 0007E
l_031_00084:
        unlk    a6                              ; 00084
        rts                                     ; 00086

;-------------------------------------------------------------------------------
; DrawBulletSmoke - Draws a bullet's smoke: a grey puff (colour 13) growing as its timer (+$28)
; runs down from $3A, at most 12 (DrawPuff).
;-------------------------------------------------------------------------------
DrawBulletSmoke:
        link.w  a6,#$ffc2                       ; 00088
        move.l  $8(a6),d0                       ; 0008C
        asl.w   #$6,d0                          ; 00090
        lea.l   (Bullets).l,a3                  ; 00092
        adda.w  d0,a3                           ; 00098
        move.w  #$d,(DrawColour).l              ; 0009A
        cmpi.w  #$3a,$28(a3)                    ; 000A2
        bgt.w   l_031_0001A                     ; 000A8
        move.w  $30(a3),d3                      ; 000AC
        sub.w   (ViewCellX).l,d3                ; 000B0
        asl.w   #$8,d3                          ; 000B6
        asl.w   #$6,d3                          ; 000B8
        ext.l   d3                              ; 000BA
        move.w  $32(a3),d5                      ; 000BC
        sub.w   (ViewCellZ).l,d5                ; 000C0
        asl.w   #$8,d5                          ; 000C6
        asl.w   #$6,d5                          ; 000C8
        ext.l   d5                              ; 000CA
        movem.l $0(a3),d0-d2                    ; 000CC
        asr.l   #$8,d0                          ; 000D2
        asr.l   #$8,d1                          ; 000D4
        asr.l   #$8,d2                          ; 000D6
        add.l   d3,d0                           ; 000D8
        add.l   d5,d2                           ; 000DA
        moveq   #$3a,d3                         ; 000DC
        sub.w   $28(a3),d3                      ; 000DE
        cmpi.w  #$c,d3                          ; 000E2
        ble.b   l_031_000EA                     ; 000E6
        moveq   #$c,d3                          ; 000E8
l_031_000EA:
        moveq   #$0,d4                          ; 000EA
        moveq   #$0,d7                          ; 000EC
        unlk    a6                              ; 000EE
        bra.w   DrawPuff                        ; 000F0

;-------------------------------------------------------------------------------
; DrawBulletHit - Draws a bullet's hit: three small orange 3D crosses (dat_031_001BE) round
; where it struck.
;-------------------------------------------------------------------------------
DrawBulletHit:
        link.w  a6,#$ffc2                       ; 000F4
        move.l  $8(a6),d0                       ; 000F8
        asl.w   #$6,d0                          ; 000FC
        lea.l   (Bullets).l,a3                  ; 000FE
        adda.w  d0,a3                           ; 00104
        move.w  $30(a3),d3                      ; 00106
        sub.w   (ViewCellX).l,d3                ; 0010A
        asl.w   #$8,d3                          ; 00110
        asl.w   #$6,d3                          ; 00112
        ext.l   d3                              ; 00114
        move.w  $32(a3),d5                      ; 00116
        sub.w   (ViewCellZ).l,d5                ; 0011A
        asl.w   #$8,d5                          ; 00120
        asl.w   #$6,d5                          ; 00122
        ext.l   d5                              ; 00124
        move.l  $0(a3),d4                       ; 00126
        asr.l   #$8,d4                          ; 0012A
        add.w   d4,d3                           ; 0012C
        add.w   (ViewOffsetX8).l,d3             ; 0012E
        move.l  $8(a3),d4                       ; 00134
        asr.l   #$8,d4                          ; 00138
        add.w   d4,d5                           ; 0013A
        add.w   (ViewOffsetZ8).l,d5             ; 0013C
        move.l  $4(a3),d4                       ; 00142
        add.l   (ViewOffsetY).l,d4              ; 00146
        asr.l   #$8,d4                          ; 0014C
        movem.w d3-d5,-$8(a6)                   ; 0014E
        move.w  #$3,-$a(a6)                     ; 00154
        move.w  #$f,(FillPattern).l             ; 0015A
        move.w  #$ffff,(DrawXor).l              ; 00162
        clr.l   (dat_071_000BA).l               ; 0016A
        move.w  #$9,(DrawColour).l              ; 00170
        lea.l   (dat_031_001BE).l,a2            ; 00178
        movea.w -$8(a6),a4                      ; 0017E
        movea.w -$6(a6),a5                      ; 00182
l_031_00186:
        lea.l   (dat_072_04202).l,a1            ; 00186
l_031_0018C:
        movem.w (a2)+,d3-d5                     ; 0018C
        add.w   a4,d3                           ; 00190
        add.w   a5,d4                           ; 00192
        add.w   -$4(a6),d5                      ; 00194
        bsr.w   TurnToView                      ; 00198
        move.w  d6,(a1)+                        ; 0019C
        move.w  d2,(a1)+                        ; 0019E
        move.w  d5,(a1)+                        ; 001A0
        cmpa.l  #dat_072_0420E,a1               ; 001A2
        blt.b   l_031_0018C                     ; 001A8
        move.l  a2,-(a7)                        ; 001AA
        jsr     (sub_035_00100).l               ; 001AC
        movea.l (a7)+,a2                        ; 001B2
        subq.w  #$1,-$a(a6)                     ; 001B4
        bgt.b   l_031_00186                     ; 001B8
        unlk    a6                              ; 001BA
        rts                                     ; 001BC
dat_031_001BE:
	dc.b	$FF,$FD,$00,$03,$FF,$FD,$00,$03,$FF,$FD,$00,$03,$00,$02,$00,$01
	dc.b	$FF,$FE,$FF,$FE,$FF,$FF,$00,$02,$FF,$FD,$FF,$FD,$FF,$FD,$00,$03
	dc.b	$00,$03,$00,$03

;-------------------------------------------------------------------------------
; TurnToView - Turns a point relative to the camera (d3, d4, d5) by the view matrix
; (dat_071_005A8): the result in d6, d2, d5.
;-------------------------------------------------------------------------------
TurnToView:
        lea.l   (dat_071_005A8).l,a0            ; 001E2
        movem.w (a0)+,d0-d2                     ; 001E8
        muls.w  d3,d0                           ; 001EC
        muls.w  d4,d1                           ; 001EE
        muls.w  d5,d2                           ; 001F0
        add.l   d1,d0                           ; 001F2
        add.l   d2,d0                           ; 001F4
        asr.l   #$8,d0                          ; 001F6
        move.w  d0,d6                           ; 001F8
        movem.w (a0)+,d0-d2                     ; 001FA
        muls.w  d3,d0                           ; 001FE
        muls.w  d4,d1                           ; 00200
        muls.w  d5,d2                           ; 00202
        add.l   d0,d2                           ; 00204
        add.l   d1,d2                           ; 00206
        asr.l   #$8,d2                          ; 00208
        muls.w  (a0)+,d3                        ; 0020A
        muls.w  (a0)+,d4                        ; 0020C
        muls.w  (a0)+,d5                        ; 0020E
        add.l   d3,d5                           ; 00210
        add.l   d4,d5                           ; 00212
        asr.l   #$8,d5                          ; 00214
        move.w  d5,(dat_071_00486).l            ; 00216
        rts                                     ; 0021C
dat_031_0021E:
        dc.l    dat_031_0023E                   ; 0021E
        dc.l    dat_031_00250                   ; 00222
        dc.l    dat_031_00262                   ; 00226
        dc.l    dat_031_00274                   ; 0022A
        dc.l    dat_031_00286                   ; 0022E
        dc.l    dat_031_00298                   ; 00232
        dc.l    dat_031_002AA                   ; 00236
        dc.l    dat_031_002BC                   ; 0023A
dat_031_0023E:
	dc.b	$00,$0A,$00,$04,$00,$0C,$00,$0A,$FF,$FE,$FF,$F8,$FF,$F2,$FF,$FE
	dc.b	$FF,$F8
dat_031_00250:
	dc.b	$00,$0A,$FF,$FA,$00,$0A,$00,$0A,$00,$06,$FF,$FA,$FF,$F2,$00,$06
	dc.b	$FF,$FA
dat_031_00262:
	dc.b	$00,$0A,$FF,$F4,$00,$06,$00,$0A,$00,$08,$FF,$FE,$FF,$F2,$00,$08
	dc.b	$FF,$FE
dat_031_00274:
	dc.b	$00,$0A,$FF,$F4,$FF,$FC,$00,$0A,$00,$08,$00,$02,$FF,$F2,$00,$08
	dc.b	$00,$02
dat_031_00286:
	dc.b	$00,$0A,$FF,$F6,$FF,$F4,$00,$0A,$00,$04,$00,$08,$FF,$F2,$00,$04
	dc.b	$00,$08
dat_031_00298:
	dc.b	$00,$0A,$FF,$FC,$FF,$F4,$00,$0A,$00,$04,$00,$08,$FF,$F2,$00,$04
	dc.b	$00,$08
dat_031_002AA:
	dc.b	$00,$0A,$00,$08,$FF,$F8,$00,$0A,$FF,$F8,$00,$04,$FF,$F2,$FF,$F8
	dc.b	$00,$04
dat_031_002BC:
	dc.b	$00,$0A,$00,$0C,$00,$04,$00,$0A,$FF,$F8,$00,$00,$FF,$F2,$FF,$F8
	dc.b	$00,$00
dat_031_002CE:
	dc.b	$03,$12,$03,$00,$03,$12,$0C,$0C,$F4,$0C,$F4,$0C,$09,$00,$00,$06
	dc.b	$FA,$06,$FA,$F4,$09,$EE,$FD,$FD,$F4,$0C,$F4,$FA,$00,$FA,$FA,$FA
	dc.b	$FA,$00,$FD,$EE,$F4,$03,$09
dat_031_002F5:
	dc.b	$06,$24,$06,$00,$06,$24,$18,$18,$E8,$18,$E8,$18,$12,$00,$00,$0C
	dc.b	$F4,$0C,$F4,$E8,$12,$DC,$FA,$FA,$E8,$18,$E8,$F4,$00,$F4,$F4,$F4
	dc.b	$F4,$00,$FA,$DC,$E8,$06,$12
dat_031_0031C:
	dc.b	$09,$36,$09,$00,$09,$36,$24,$24,$DC,$24,$DC,$24,$1B,$00,$00,$12
	dc.b	$EE,$12,$EE,$DC,$1B,$CA,$F7,$F7,$DC,$24,$DC,$EE,$00,$EE,$EE,$EE
	dc.b	$EE,$00,$F7,$CA,$DC,$09,$1B
dat_031_00343:
	dc.b	$00,$0C,$10,$0C,$0C,$FC,$F4,$0C,$FC,$10,$00,$0C,$00,$00,$F6,$F0
	dc.b	$00,$0C,$00,$F4,$10,$0C,$F4,$FC,$F4,$F4,$FC,$00,$00,$00
dat_031_00361:
	dc.b	$09,$09,$09,$09,$09,$09,$09,$09,$09,$09,$09,$09
dat_031_0036D:
	dc.b	$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02
dat_031_00379:
	dc.b	$0D,$0A,$0D,$0A,$0D,$0A,$0D,$0A,$0D,$0A,$0D,$0A
dat_031_00385:
	dc.b	$09,$09,$09,$09,$09,$09,$09,$09,$09,$09,$09,$09
dat_031_00391:
	dc.b	$09,$09,$09,$09,$09,$09,$09,$09,$09,$09,$09,$09,$00
dat_031_0039E:
	dc.b	$00,$00,$00,$04,$00,$08,$00,$0C,$00,$10,$00,$14,$00,$18,$00,$1C
	dc.b	$00,$00,$00,$04,$00,$08,$00,$0C,$00,$10,$00,$14,$00,$18,$00,$1C
	dc.b	$00,$00,$00,$04,$00,$08,$00,$0C,$00,$10,$00,$14,$00,$18,$00,$1C
	dc.b	$00,$00,$00,$04,$00,$08,$00,$0C,$00,$10,$00,$14,$00,$18,$00,$1C
	dc.b	$00,$00
l_031_003E0:
        rts                                     ; 003E0

;-------------------------------------------------------------------------------
; DrawPuff - Draws a round puff of smoke or fire at a point (d0-d2) of size d3 and kind d4,
; scaled by distance (at most $7F); only within $8000 of the camera's height. Also used by
; DrawModel.
;-------------------------------------------------------------------------------
DrawPuff:
        move.w  #$f,(FillPattern).l             ; 003E2
        move.w  #$ffff,(DrawXor).l              ; 003EA
        clr.l   (dat_071_000BA).l               ; 003F2
        move.l  d1,d5                           ; 003F8
        add.l   (ViewOffsetY8).l,d5             ; 003FA
        bge.b   l_031_00404                     ; 00400
        neg.l   d5                              ; 00402
l_031_00404:
        cmpi.l  #$8000,d5                       ; 00404
        bgt.b   l_031_003E0                     ; 0040A
        cmpi.b  #$3,d4                          ; 0040C
        bne.b   l_031_00446                     ; 00410
        movem.l d0-d4/d7,-(a7)                  ; 00412
        bsr.w   sub_031_00704                   ; 00416
        move.w  d1,d5                           ; 0041A
        movem.l (a7)+,d0-d4/d7                  ; 0041C
        move.w  #$2800,d6                       ; 00420
        mulu.w  d3,d6                           ; 00424
        divu.w  #$6,d6                          ; 00426
        addi.w  #$2800,d6                       ; 0042A
        ext.l   d6                              ; 0042E
        tst.w   d5                              ; 00430
        ble.b   l_031_0043C                     ; 00432
        divu.w  d5,d6                           ; 00434
        cmpi.w  #$7f,d6                         ; 00436
        ble.b   l_031_00440                     ; 0043A
l_031_0043C:
        move.w  #$7f,d6                         ; 0043C
l_031_00440:
        swap    d7                              ; 00440
        move.w  d6,d7                           ; 00442
        swap    d7                              ; 00444
l_031_00446:
        add.l   (ViewOffsetY8).l,d1             ; 00446
        move.w  (ViewOffsetX8).l,d5             ; 0044C
        move.w  (ViewOffsetZ8).l,d6             ; 00452
        ext.l   d5                              ; 00458
        ext.l   d6                              ; 0045A
        add.l   d5,d0                           ; 0045C
        add.l   d6,d2                           ; 0045E
        asr.l   d7,d0                           ; 00460
        asr.l   d7,d1                           ; 00462
        asr.l   d7,d2                           ; 00464
        link.w  a6,#$fffc                       ; 00466
        clr.w   -$2(a6)                         ; 0046A
        swap    d7                              ; 0046E
        move.w  d7,d6                           ; 00470
        swap    d7                              ; 00472
        movem.w d0-d4/d6-d7,-(a7)               ; 00474
        bsr.w   sub_031_004CC                   ; 00478
        or.w    d0,-$2(a6)                      ; 0047C
        movem.w (a7)+,d0-d4/d6-d7               ; 00480
        cmpi.b  #$3,d4                          ; 00484
        blt.b   l_031_004C4                     ; 00488
        addq.w  #$1,d4                          ; 0048A
        subq.w  #$1,d3                          ; 0048C
        bge.b   l_031_00492                     ; 0048E
        moveq   #$0,d3                          ; 00490
l_031_00492:
        movem.w d0-d4/d6-d7,-(a7)               ; 00492
        bsr.w   sub_031_004CC                   ; 00496
        or.w    d0,-$2(a6)                      ; 0049A
        movem.w (a7)+,d0-d4/d6-d7               ; 0049E
        cmpi.b  #$4,d4                          ; 004A2
        blt.b   l_031_004C4                     ; 004A6
        addq.w  #$1,d4                          ; 004A8
        subq.w  #$1,d3                          ; 004AA
        bge.b   l_031_004B0                     ; 004AC
        moveq   #$0,d3                          ; 004AE
l_031_004B0:
        addi.w  #$14,d0                         ; 004B0
        addi.w  #$a,d1                          ; 004B4
        addi.w  #$14,d2                         ; 004B8
        bsr.w   sub_031_004CC                   ; 004BC
        or.w    d0,-$2(a6)                      ; 004C0
l_031_004C4:
        move.w  -$2(a6),d0                      ; 004C4
        unlk    a6                              ; 004C8
        rts                                     ; 004CA
sub_031_004CC:
        link.w  a6,#$ffc2                       ; 004CC
        move.b  d4,-$2e(a6)                     ; 004D0
        clr.w   -$1e(a6)                        ; 004D4
        move.w  d6,-$3c(a6)                     ; 004D8
        move.w  d7,-$18(a6)                     ; 004DC
        movem.w d0-d2,-$8(a6)                   ; 004E0
        move.w  d3,-$30(a6)                     ; 004E6
        move.w  #$b,-$a(a6)                     ; 004EA
        move.w  #$3,(dat_072_03000).l           ; 004F0
        subq.b  #$1,d4                          ; 004F8
        ble.b   l_031_00556                     ; 004FA
        subq.b  #$1,d4                          ; 004FC
        ble.b   l_031_00544                     ; 004FE
        subq.b  #$1,d4                          ; 00500
        ble.b   l_031_0052C                     ; 00502
        subq.b  #$1,d4                          ; 00504
        ble.b   l_031_0051A                     ; 00506
        move.l  #dat_031_00391,-$34(a6)         ; 00508
        move.l  #dat_031_002F5,-$38(a6)         ; 00510
        bra.b   l_031_00566                     ; 00518
l_031_0051A:
        move.l  #dat_031_00385,-$34(a6)         ; 0051A
        move.l  #dat_031_0031C,-$38(a6)         ; 00522
        bra.b   l_031_00566                     ; 0052A
l_031_0052C:
        move.l  #dat_031_00379,-$34(a6)         ; 0052C
        move.l  #dat_031_00343,-$38(a6)         ; 00534
        move.w  #$8,-$a(a6)                     ; 0053C
        bra.b   l_031_00566                     ; 00542
l_031_00544:
        move.l  #dat_031_0036D,-$34(a6)         ; 00544
        move.l  #dat_031_002CE,-$38(a6)         ; 0054C
        bra.b   l_031_00566                     ; 00554
l_031_00556:
        move.l  #dat_031_00361,-$34(a6)         ; 00556
        move.l  #dat_031_002CE,-$38(a6)         ; 0055E
l_031_00566:
        movea.l -$38(a6),a4                     ; 00566
        move.w  -$a(a6),d4                      ; 0056A
        move.w  d4,d5                           ; 0056E
        add.w   d4,d4                           ; 00570
        add.w   d5,d4                           ; 00572
        adda.w  d4,a4                           ; 00574
        move.b  (a4),d0                         ; 00576
        move.b  $1(a4),d1                       ; 00578
        move.b  $2(a4),d2                       ; 0057C
        ext.w   d0                              ; 00580
        ext.w   d1                              ; 00582
        ext.w   d2                              ; 00584
        move.w  -$30(a6),d4                     ; 00586
        mulu.w  d4,d0                           ; 0058A
        mulu.w  d4,d1                           ; 0058C
        mulu.w  d4,d2                           ; 0058E
        add.w   d5,d5                           ; 00590
        add.w   d4,d5                           ; 00592
        add.w   d4,d5                           ; 00594
        lea.l   dat_031_0039E(pc),a3            ; 00596
        move.w  (a3,d5.w),d3                    ; 0059A
        move.w  -$18(a6),d4                     ; 0059E
        asr.w   d4,d0                           ; 005A2
        asr.w   d4,d1                           ; 005A4
        asr.w   d4,d2                           ; 005A6
        add.w   -$8(a6),d0                      ; 005A8
        add.w   -$6(a6),d1                      ; 005AC
        add.w   -$4(a6),d2                      ; 005B0
        movea.w d0,a4                           ; 005B4
        movea.w d1,a5                           ; 005B6
        move.w  d2,-$2(a6)                      ; 005B8
        move.w  d3,d4                           ; 005BC
        movea.l -$34(a6),a2                     ; 005BE
        move.w  -$a(a6),d3                      ; 005C2
        move.b  (a2,d3.w),d3                    ; 005C6
        tst.b   -$2e(a6)                        ; 005CA
        bne.b   l_031_005D2                     ; 005CE
        moveq   #$d,d3                          ; 005D0
l_031_005D2:
        move.w  d3,(DrawColour).l               ; 005D2
        lea.l   dat_031_0021E(pc),a2            ; 005D8
        movea.l (a2,d4.w),a2                    ; 005DC
        lea.l   (dat_072_03002).l,a1            ; 005E0
l_031_005E6:
        cmpi.b  #$3,-$2e(a6)                    ; 005E6
        bne.b   l_031_005F6                     ; 005EC
        moveq   #$0,d3                          ; 005EE
        moveq   #$0,d4                          ; 005F0
        moveq   #$0,d5                          ; 005F2
        bra.b   l_031_005FA                     ; 005F4
l_031_005F6:
        movem.w (a2)+,d3-d5                     ; 005F6
l_031_005FA:
        add.w   a4,d3                           ; 005FA
        add.w   a5,d4                           ; 005FC
        add.w   -$2(a6),d5                      ; 005FE
        move.w  -$18(a6),d7                     ; 00602
        asr.w   d7,d3                           ; 00606
        asr.w   d7,d4                           ; 00608
        asr.w   d7,d5                           ; 0060A
        lea.l   (dat_071_005A8).l,a0            ; 0060C
        movem.w (a0)+,d0-d2                     ; 00612
        muls.w  d3,d0                           ; 00616
        muls.w  d4,d1                           ; 00618
        muls.w  d5,d2                           ; 0061A
        add.l   d1,d0                           ; 0061C
        add.l   d2,d0                           ; 0061E
        asr.l   #$8,d0                          ; 00620
        move.w  d0,d6                           ; 00622
        movem.w (a0)+,d0-d2                     ; 00624
        muls.w  d3,d0                           ; 00628
        muls.w  d4,d1                           ; 0062A
        muls.w  d5,d2                           ; 0062C
        add.l   d0,d2                           ; 0062E
        add.l   d1,d2                           ; 00630
        asr.l   #$8,d2                          ; 00632
        muls.w  (a0)+,d3                        ; 00634
        muls.w  (a0)+,d4                        ; 00636
        muls.w  (a0)+,d5                        ; 00638
        add.l   d3,d5                           ; 0063A
        add.l   d4,d5                           ; 0063C
        asr.l   #$8,d5                          ; 0063E
        ble.b   l_031_006AA                     ; 00640
        cmp.w   d5,d6                           ; 00642
        bgt.b   l_031_006AA                     ; 00644
        move.w  d6,d4                           ; 00646
        neg.w   d4                              ; 00648
        cmp.w   d5,d4                           ; 0064A
        bgt.b   l_031_006AA                     ; 0064C
        cmp.w   d5,d2                           ; 0064E
        bgt.b   l_031_006AA                     ; 00650
        move.w  d2,d4                           ; 00652
        neg.w   d4                              ; 00654
        cmp.w   d5,d4                           ; 00656
        bgt.b   l_031_006AA                     ; 00658
        muls.w  #$a0,d6                         ; 0065A
        divs.w  d5,d6                           ; 0065E
        addi.w  #$a0,d6                         ; 00660
        blt.b   l_031_006BA                     ; 00664
        cmpi.w  #$140,d6                        ; 00666
        bge.b   l_031_006C2                     ; 0066A
l_031_0066C:
        move.w  d2,d7                           ; 0066C
        muls.w  #$5a,d7                         ; 0066E
        divs.w  d5,d7                           ; 00672
        addi.w  #$5a,d7                         ; 00674
        blt.b   l_031_006BE                     ; 00678
        cmpi.w  #$b4,d7                         ; 0067A
        bge.b   l_031_006C8                     ; 0067E
l_031_00680:
        subi.w  #$13f,d6                        ; 00680
        neg.w   d6                              ; 00684
        subi.w  #$b3,d7                         ; 00686
        neg.w   d7                              ; 0068A
        move.w  d6,(a1)+                        ; 0068C
        move.w  d7,(a1)+                        ; 0068E
        cmpi.b  #$3,-$2e(a6)                    ; 00690
        beq.b   l_031_006CE                     ; 00696
        cmpa.l  #dat_072_0300E,a1               ; 00698
        blt.w   l_031_005E6                     ; 0069E
        bra.b   l_031_006CE                     ; 006A2
l_031_006A4:
        move.w  #$1,-$1e(a6)                    ; 006A4
l_031_006AA:
        subq.w  #$1,-$a(a6)                     ; 006AA
        bge.w   l_031_00566                     ; 006AE
        move.w  -$1e(a6),d0                     ; 006B2
        unlk    a6                              ; 006B6
        rts                                     ; 006B8
l_031_006BA:
        clr.w   d6                              ; 006BA
        bra.b   l_031_0066C                     ; 006BC
l_031_006BE:
        clr.w   d7                              ; 006BE
        bra.b   l_031_00680                     ; 006C0
l_031_006C2:
        move.w  #$13f,d6                        ; 006C2
        bra.b   l_031_0066C                     ; 006C6
l_031_006C8:
        move.w  #$b3,d7                         ; 006C8
        bra.b   l_031_00680                     ; 006CC
l_031_006CE:
        move.b  -$2e(a6),d0                     ; 006CE
        beq.b   l_031_006F4                     ; 006D2
        subq.b  #$3,d0                          ; 006D4
        bne.b   l_031_006EC                     ; 006D6
        movem.w (dat_072_03002).l,d0-d1         ; 006D8
        move.w  -$3c(a6),d6                     ; 006E0
        jsr     (sub_035_00550).l               ; 006E4
        bra.b   l_031_006A4                     ; 006EA
l_031_006EC:
        jsr     (sub_036_00AB8).l               ; 006EC
        bra.b   l_031_006A4                     ; 006F2
l_031_006F4:
        movem.w (dat_072_03002).l,d0-d3         ; 006F4
        jsr     (DrawLine).l                    ; 006FC
        bra.b   l_031_006A4                     ; 00702
sub_031_00704:
        movem.w (ViewOffsetX8).l,d3-d5          ; 00704
        moveq   #$0,d7                          ; 0070C
        add.l   d3,d0                           ; 0070E
        bge.b   l_031_00714                     ; 00710
        neg.l   d0                              ; 00712
l_031_00714:
        add.l   d4,d1                           ; 00714
        bge.b   l_031_0071A                     ; 00716
        neg.l   d1                              ; 00718
l_031_0071A:
        add.l   d5,d2                           ; 0071A
        bge.b   l_031_00720                     ; 0071C
        neg.l   d2                              ; 0071E
l_031_00720:
        move.l  #$4000,d6                       ; 00720
        cmp.l   d6,d0                           ; 00726
        bgt.b   l_031_00732                     ; 00728
        cmp.l   d6,d1                           ; 0072A
        bgt.b   l_031_00732                     ; 0072C
        cmp.l   d6,d2                           ; 0072E
        ble.b   l_031_0074E                     ; 00730
l_031_00732:
        moveq   #$8,d7                          ; 00732
        move.l  #$40000,d6                      ; 00734
        cmp.l   d6,d0                           ; 0073A
        bgt.b   l_031_00748                     ; 0073C
        cmp.l   d6,d1                           ; 0073E
        bgt.b   l_031_00748                     ; 00740
        cmp.l   d6,d2                           ; 00742
        bgt.b   l_031_00748                     ; 00744
        moveq   #$4,d7                          ; 00746
l_031_00748:
        asr.l   d7,d0                           ; 00748
        asr.l   d7,d1                           ; 0074A
        asr.l   d7,d2                           ; 0074C
l_031_0074E:
        move.w  d2,d4                           ; 0074E
        move.w  d1,d3                           ; 00750
        move.w  d0,d2                           ; 00752
        jsr     (VectorLength).l                ; 00754
        rts                                     ; 0075A
h031_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    19,31                           ; 19 longs pointing into hunk 31
	dc.l	$560,$558,$54E,$546,$536,$52E,$524,$51C
	dc.l	$512,$50A,$23A,$236,$232,$22E,$22A,$226
	dc.l	$222,$21E,$17A
        dc.l    33,71                           ; 33 longs pointing into hunk 71
	dc.l	$30,$C2,$11C,$20,$B2,$10C,$218,$C
	dc.l	$94,$100,$1E4,$60E,$15E,$166,$16C,$3E6
	dc.l	$3EE,$3F4,$16,$9E,$174,$5D4,$52,$13E
	dc.l	$454,$3FC,$448,$5C,$148,$44,$130,$44E
	dc.l	$708
        dc.l    1,8                             ; 1 longs pointing into hunk 8
	dc.l	$756
        dc.l    3,35                            ; 3 longs pointing into hunk 35
	dc.l	$6E6,$6E,$1AE
        dc.l    7,72                            ; 7 longs pointing into hunk 72
	dc.l	$188,$1A4,$4F4,$5E2,$69A,$6DC,$6F8
        dc.l    2,36                            ; 2 longs pointing into hunk 36
	dc.l	$6FE,$6EE
	dc.l	0
	dc.l	HUNK_END
	endc
