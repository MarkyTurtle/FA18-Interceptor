; F/A-18 Interceptor - hunk 10 (code)
; Object drawing routines, called through ObjectDrawTable (hunk 16).
; Included by ../f18_main.s.

;===============================================================================
; Hunk 10: CODE, $FA8 bytes
;===============================================================================
	CODE_HUNK	h010
l_010_00000:
        moveq   #$0,d0                          ; 00000
        rts                                     ; 00002

;-------------------------------------------------------------------------------
; DrawSceneryNear - DrawScenery only while ViewOffsetY (the object's height against the
; camera) is under $FFD80000.
;-------------------------------------------------------------------------------
DrawSceneryNear:
        cmpi.l  #$ffd80000,(ViewOffsetY).l      ; 00004
        bge.b   l_010_00000                     ; 0000E

;-------------------------------------------------------------------------------
; DrawScenery - The draw routine of most scenery shapes: DrawModel without the checks for the
; player's own aircraft.
;-------------------------------------------------------------------------------
DrawScenery:
        bra.w   DrawSceneryPlain                ; 00010

;-------------------------------------------------------------------------------
; DrawModel - Draws an object's model: picks the shape by distance from the model's list (a
; word each: the distance in bits 0-13, bit 14 a 4-byte entry, a negative word the shape's
; offset), reads the shape's header (two distance limits, the scale shifts, flags, the vertex
; counts), turns its vertices by the object's matrix (+$92) and moves them to the camera (into
; VertexBuffer; the first one, the centre, also gives the locked target's place on the screen,
; TargetScreenPos), then runs the shape's drawing list: plane tests on three vertices choose
; which branch is drawn first, so the nearer faces cover the further ones, and the faces and
; lines are drawn.
;-------------------------------------------------------------------------------
DrawModel:
        btst    #$6,(ObjectDrawFlags).l         ; 00014
        bne.b   l_010_00000                     ; 0001C
        tst.b   (OutsideView).l                 ; 0001E
        bne.w   DrawSceneryPlain                ; 00024
        move.w  (CurrentObjectOffset).l,d0      ; 00028
        cmp.w   (ViewObject).l,d0               ; 0002E
        bne.w   DrawSceneryPlain                ; 00034
        move.b  (ViewZoom).l,d0                 ; 00038
        cmpi.b  #$3,d0                          ; 0003E
        blt.b   l_010_0004C                     ; 00042
        cmpi.b  #$9,d0                          ; 00044
        ble.w   l_010_000CC                     ; 00048
l_010_0004C:
        move.l  (ShapeNext).l,d0                ; 0004C
        cmp.l   (ShapeNow).l,d0                 ; 00052
        beq.w   DrawSceneryPlain                ; 00058
        move.l  d0,(ShapeNow).l                 ; 0005C
        tst.b   (ViewSwitched).l                ; 00062
        bne.w   DrawSceneryPlain                ; 00068
        move.b  (HeightBand).l,d1               ; 0006C
        beq.b   l_010_00094                     ; 00072
        cmpi.b  #$3,d1                          ; 00074
        bge.w   DrawSceneryPlain                ; 00078
        move.l  (ViewOffsetY8).l,d3             ; 0007C
        move.w  (DistanceShift).l,d5            ; 00082
        asr.l   d5,d3                           ; 00088
        cmpi.l  #$ffffffe0,d3                   ; 0008A
        bge.w   DrawSceneryPlain                ; 00090
l_010_00094:
        movea.l (ShapeNow).l,a2                 ; 00094
        move.w  (a2)+,d0                        ; 0009A
        blt.b   l_010_000B0                     ; 0009C
        andi.w  #$4000,d0                       ; 0009E
        beq.b   l_010_000BE                     ; 000A2
        addq.l  #$6,(ShapeNow).l                ; 000A4
        bra.b   DrawSceneryPlain                ; 000AA
l_010_000AC:
        moveq   #$0,d0                          ; 000AC
        rts                                     ; 000AE
l_010_000B0:
        cmpi.w  #$ffff,d0                       ; 000B0
        beq.b   l_010_000AC                     ; 000B4
        addq.l  #$4,(ShapeNow).l                ; 000B6
        bra.b   DrawSceneryPlain                ; 000BC
l_010_000BE:
        move.w  (a2),d0                         ; 000BE
        blt.b   l_010_000AC                     ; 000C0
        ext.l   d0                              ; 000C2
        add.l   d0,(ShapeNow).l                 ; 000C4
        bra.b   DrawSceneryPlain                ; 000CA
l_010_000CC:
        link.w  a6,#$ff68                       ; 000CC
        clr.w   -$80(a6)                        ; 000D0
        ori.w   #$1,-$80(a6)                    ; 000D4
        bra.b   l_010_000E4                     ; 000DA

;-------------------------------------------------------------------------------
; DrawSceneryPlain - DrawModel's main part (also the entry of some scenery shapes).
;-------------------------------------------------------------------------------
DrawSceneryPlain:
        link.w  a6,#$ff68                       ; 000DC
        clr.w   -$80(a6)                        ; 000E0
l_010_000E4:
        move.w  (ObjectDistance).l,d1           ; 000E4
        move.w  d1,-$96(a6)                     ; 000EA
        tst.b   (GroundDetail).l                ; 000EE
        bne.b   l_010_00108                     ; 000F4
        move.w  (RadarScale).l,d3               ; 000F6
        ext.l   d3                              ; 000FC
        asl.l   #$8,d3                          ; 000FE
        divu.w  #$80,d3                         ; 00100
        mulu.w  d3,d1                           ; 00104
        asr.l   #$8,d1                          ; 00106
l_010_00108:
        move.w  d1,-$28(a6)                     ; 00108
        movea.l (ShapeNow).l,a2                 ; 0010C
        move.l  a0,-$2c(a6)                     ; 00112
        move.w  (DistanceShift).l,d3            ; 00116
l_010_0011C:
        move.w  (a2)+,d0                        ; 0011C
        blt.b   l_010_0014C                     ; 0011E
        move.w  d0,d2                           ; 00120
        andi.w  #$3fff,d0                       ; 00122
        asr.w   d3,d0                           ; 00126
        cmp.w   d1,d0                           ; 00128
        bgt.b   l_010_00142                     ; 0012A
        andi.w  #$4000,d2                       ; 0012C
        beq.b   l_010_00136                     ; 00130
        addq.w  #$4,a2                          ; 00132
        bra.b   l_010_0011C                     ; 00134
l_010_00136:
        move.w  (a2),d0                         ; 00136
        blt.b   l_010_00168                     ; 00138
        movea.l -$2c(a6),a2                     ; 0013A
        adda.w  d0,a2                           ; 0013E
        bra.b   l_010_0011C                     ; 00140
l_010_00142:
        andi.w  #$4000,d2                       ; 00142
        bne.b   l_010_0014A                     ; 00146
        addq.w  #$2,a2                          ; 00148
l_010_0014A:
        move.w  (a2)+,d0                        ; 0014A
l_010_0014C:
        cmpi.w  #$ffff,d0                       ; 0014C
        beq.b   l_010_00168                     ; 00150
        move.w  d0,d1                           ; 00152
        andi.w  #$2000,d1                       ; 00154
        beq.b   l_010_0016E                     ; 00158
        tst.b   (SceneryDetailed).l             ; 0015A
        beq.b   l_010_001A2                     ; 00160
l_010_00162:
        moveq   #$1,d0                          ; 00162
        unlk    a6                              ; 00164
        rts                                     ; 00166
l_010_00168:
        moveq   #$0,d0                          ; 00168
        unlk    a6                              ; 0016A
        rts                                     ; 0016C
l_010_0016E:
        cmpi.w  #$80,(RadarScale).l             ; 0016E
        bge.b   l_010_0019A                     ; 00176
        tst.b   (SceneryDetailed).l             ; 00178
        bne.b   l_010_001A2                     ; 0017E
        lea.l   (SceneryList).l,a3              ; 00180
l_010_00186:
        move.w  (a3),d1                         ; 00186
        blt.b   l_010_001A2                     ; 00188
        lsr.w   #$8,d1                          ; 0018A
        cmp.w   (CurrentObject).l,d1            ; 0018C
        beq.b   l_010_00162                     ; 00192
        adda.w  #$18,a3                         ; 00194
        bra.b   l_010_00186                     ; 00198
l_010_0019A:
        tst.b   (SceneryDetailed).l             ; 0019A
        beq.b   l_010_00162                     ; 001A0
l_010_001A2:
        move.w  d0,d1                           ; 001A2
        moveq   #$0,d7                          ; 001A4
        andi.w  #$4000,d1                       ; 001A6
        bne.b   l_010_001C2                     ; 001AA
        moveq   #$1,d7                          ; 001AC
        tst.b   (dat_071_0016E).l               ; 001AE
        beq.b   l_010_001C2                     ; 001B4
        move.w  (FrameCount).l,d4               ; 001B6
        andi.w  #$1,d4                          ; 001BC
        beq.b   l_010_00168                     ; 001C0
l_010_001C2:
        move.w  d7,-$62(a6)                     ; 001C2
        andi.w  #$fff,d0                        ; 001C6
        movea.l -$2c(a6),a3                     ; 001CA
        lea.l   (a3,d0.w),a1                    ; 001CE
        move.l  a1,(CurrentShape).l             ; 001D2
        move.l  a2,(ShapeNow).l                 ; 001D8
        move.w  (a1)+,d0                        ; 001DE
        move.b  d0,-$88(a6)                     ; 001E0
        move.w  (a1)+,d4                        ; 001E4
        move.w  (a1)+,d5                        ; 001E6
        move.b  (a1)+,d6                        ; 001E8
        move.b  d6,d7                           ; 001EA
        asr.b   #$4,d6                          ; 001EC
        andi.w  #$f,d6                          ; 001EE
        andi.w  #$f,d7                          ; 001F2
        movem.l (ViewOffsetX).l,d0-d2           ; 001F6
        move.w  (DistanceShift).l,d3            ; 001FE
        beq.b   l_010_0020C                     ; 00204
        asr.l   d3,d0                           ; 00206
        asr.l   d3,d1                           ; 00208
        asr.l   d3,d2                           ; 0020A
l_010_0020C:
        movem.l d0-d2,-$20(a6)                  ; 0020C
        asr.l   #$8,d0                          ; 00212
        asr.l   #$8,d1                          ; 00214
        asr.l   #$8,d2                          ; 00216
        movem.w d0-d2,-$86(a6)                  ; 00218
        neg.w   d0                              ; 0021E
        neg.w   d1                              ; 00220
        neg.w   d2                              ; 00222
        movem.w d0-d2,-$26(a6)                  ; 00224
        move.w  d7,-$4(a6)                      ; 0022A
        asr.w   d3,d5                           ; 0022E
        cmp.w   -$96(a6),d5                     ; 00230
        bge.b   l_010_0023C                     ; 00234
        move.w  d7,d3                           ; 00236
        clr.w   d2                              ; 00238
        bra.b   l_010_00256                     ; 0023A
l_010_0023C:
        move.w  (DistanceShift).l,d3            ; 0023C
        asr.w   d3,d4                           ; 00242
        cmp.w   -$96(a6),d4                     ; 00244
        bge.b   l_010_00252                     ; 00248
        move.w  d6,d3                           ; 0024A
        move.w  d7,d2                           ; 0024C
        sub.w   d6,d2                           ; 0024E
        bra.b   l_010_00256                     ; 00250
l_010_00252:
        clr.w   d3                              ; 00252
        move.w  d7,d2                           ; 00254
l_010_00256:
        move.w  d2,-$6(a6)                      ; 00256
        add.w   (DistanceShift).l,d3            ; 0025A
        move.w  d3,-$8(a6)                      ; 00260
        move.b  (a1)+,d6                        ; 00264
        move.b  d6,-$64(a6)                     ; 00266
        cmpi.l  #$fffffec0,(ViewOffsetY8).l     ; 0026A
        ble.w   l_010_002AE                     ; 00274
        tst.b   (HeightMid).l                   ; 00278
        bne.w   l_010_002AE                     ; 0027E
        andi.b  #$42,d6                         ; 00282
        cmpi.b  #$42,d6                         ; 00286
        bne.b   l_010_002AE                     ; 0028A
        tst.w   (ObjectDrawWord).l              ; 0028C
        ble.b   l_010_002A0                     ; 00292
        move.b  (ObjectDrawByte).l,d0           ; 00294
        andi.b  #$3,d0                          ; 0029A
        bne.b   l_010_002AE                     ; 0029E
l_010_002A0:
        lea.l   $2(a1),a3                       ; 002A0
        jsr     (SceneryFacing).l               ; 002A4
        blt.w   l_010_00168                     ; 002AA
l_010_002AE:
        move.w  #$0,(PolygonBuffer).l           ; 002AE
        lea.l   (VertexBuffer).l,a3             ; 002B6
        move.b  -$64(a6),d6                     ; 002BC
        btst    #$0,d6                          ; 002C0
        beq.w   l_010_0072C                     ; 002C4
        lea.l   (ObjectTable).l,a0              ; 002C8
        adda.w  (CurrentObjectOffset).l,a0      ; 002CE
        move.w  $0(a0),d1                       ; 002D4
        btst    #$6,d1                          ; 002D8
        beq.w   l_010_00168                     ; 002DC
        move.b  -$88(a6),$7b(a0)                ; 002E0
        andi.w  #$400,d1                        ; 002E6
        beq.b   l_010_00340                     ; 002EA
        move.w  $4c(a0),d1                      ; 002EC
        cmpi.w  #$e,d1                          ; 002F0
        bne.b   l_010_00338                     ; 002F4
        move.w  -$28(a6),d0                     ; 002F6
        ext.l   d0                              ; 002FA
        move.w  (DistanceShift).l,d2            ; 002FC
        asl.l   d2,d0                           ; 00302
        asr.l   #$1,d0                          ; 00304
        tst.w   d0                              ; 00306
        ble.b   l_010_0031A                     ; 00308
        move.l  #$10000,d2                      ; 0030A
        divu.w  d0,d2                           ; 00310
        cmpi.l  #$78,d2                         ; 00312
        ble.b   l_010_0031E                     ; 00318
l_010_0031A:
        move.w  #$78,d2                         ; 0031A
l_010_0031E:
        move.b  d2,(dat_071_00239).l            ; 0031E
        asr.w   #$1,d2                          ; 00324
        move.b  d2,(dat_071_0023A).l            ; 00326
        asr.w   #$4,d2                          ; 0032C
        moveq   #$4,d4                          ; 0032E
        sub.w   d2,d4                           ; 00330
        move.b  d4,(dat_071_00188).l            ; 00332
l_010_00338:
        cmpi.w  #$c,d1                          ; 00338
        ble.w   l_010_00B42                     ; 0033C
l_010_00340:
        move.l  -$20(a6),d0                     ; 00340
        move.l  -$18(a6),d2                     ; 00344
        move.l  (ObjectViewPosL).l,d3           ; 00348
        move.l  (ObjectViewPosZL).l,d4          ; 0034E
        add.l   d3,d0                           ; 00354
        add.l   d4,d2                           ; 00356
        move.l  (ObjectViewY).l,d1              ; 00358
        moveq   #$8,d7                          ; 0035E
        sub.w   -$6(a6),d7                      ; 00360
        asr.l   d7,d0                           ; 00364
        asr.l   d7,d1                           ; 00366
        asr.l   d7,d2                           ; 00368
        movem.w d0-d2,-$14(a6)                  ; 0036A
        lea.l   (ObjectTable).l,a0              ; 00370
        adda.w  (CurrentObjectOffset).l,a0      ; 00376
        adda.w  #$92,a0                         ; 0037C
        lea.l   (SceneryMatrix).l,a2            ; 00380
        movem.w (a0)+,d0-d7                     ; 00386
        asr.w   #$6,d0                          ; 0038A
        asr.w   #$6,d1                          ; 0038C
        asr.w   #$6,d2                          ; 0038E
        asr.w   #$6,d3                          ; 00390
        asr.w   #$6,d4                          ; 00392
        asr.w   #$6,d5                          ; 00394
        asr.w   #$6,d6                          ; 00396
        asr.w   #$6,d7                          ; 00398
        movem.w d0-d7,(a2)                      ; 0039A
        move.w  (a0),d0                         ; 0039E
        asr.w   #$6,d0                          ; 003A0
        move.w  d0,$10(a2)                      ; 003A2
        lea.l   (ObjectTable).l,a0              ; 003A6
        adda.w  (CurrentObjectOffset).l,a0      ; 003AC
        adda.w  #$a4,a0                         ; 003B2
        move.b  (a1)+,d0                        ; 003B6
        ext.w   d0                              ; 003B8
        move.b  (a1)+,d1                        ; 003BA
        ext.w   d1                              ; 003BC
        subq.w  #$1,d0                          ; 003BE
        subq.w  #$1,d1                          ; 003C0
        sub.w   d1,d0                           ; 003C2
        blt.w   l_010_0059C                     ; 003C4
        move.w  #$39,-$60(a6)                   ; 003C8
        movem.w (a1)+,d2-d4                     ; 003CE
        lea.l   (SceneryMatrix).l,a2            ; 003D2
        move.w  d2,d5                           ; 003D8
        move.w  d3,d6                           ; 003DA
        move.w  d4,d7                           ; 003DC
        muls.w  (a2)+,d5                        ; 003DE
        muls.w  (a2)+,d6                        ; 003E0
        muls.w  (a2)+,d7                        ; 003E2
        add.l   d6,d7                           ; 003E4
        add.l   d5,d7                           ; 003E6
        asr.l   #$8,d7                          ; 003E8
        movea.w d7,a4                           ; 003EA
        move.w  d2,d5                           ; 003EC
        move.w  d3,d6                           ; 003EE
        move.w  d4,d7                           ; 003F0
        muls.w  (a2)+,d5                        ; 003F2
        muls.w  (a2)+,d6                        ; 003F4
        muls.w  (a2)+,d7                        ; 003F6
        add.l   d6,d7                           ; 003F8
        add.l   d5,d7                           ; 003FA
        asr.l   #$8,d7                          ; 003FC
        move.w  d7,d6                           ; 003FE
        muls.w  (a2)+,d2                        ; 00400
        muls.w  (a2)+,d3                        ; 00402
        muls.w  (a2)+,d4                        ; 00404
        add.l   d3,d4                           ; 00406
        add.l   d2,d4                           ; 00408
        asr.l   #$8,d4                          ; 0040A
        move.w  a4,(a0)+                        ; 0040C
        move.w  d7,(a0)+                        ; 0040E
        move.w  d4,(a0)+                        ; 00410
        tst.w   d1                              ; 00412
        blt.w   l_010_005AC                     ; 00414
        btst    #$0,-$7f(a6)                    ; 00418
        beq.b   l_010_00428                     ; 0041E
        bsr.w   sub_010_005B6                   ; 00420
        bra.w   l_010_004B6                     ; 00424
l_010_00428:
        move.w  a4,d2                           ; 00428
        move.w  d6,d3                           ; 0042A
        move.w  -$8(a6),d7                      ; 0042C
        asr.w   d7,d2                           ; 00430
        asr.w   d7,d3                           ; 00432
        asr.w   d7,d4                           ; 00434
        add.w   -$14(a6),d2                     ; 00436
        add.w   -$12(a6),d3                     ; 0043A
        add.w   -$10(a6),d4                     ; 0043E
        lea.l   (ViewMatrix).l,a2               ; 00442
        move.w  d2,d5                           ; 00448
        move.w  d3,d6                           ; 0044A
        move.w  d4,d7                           ; 0044C
        muls.w  (a2)+,d5                        ; 0044E
        muls.w  (a2)+,d6                        ; 00450
        muls.w  (a2)+,d7                        ; 00452
        add.l   d6,d7                           ; 00454
        add.l   d5,d7                           ; 00456
        asr.l   #$8,d7                          ; 00458
        move.w  d7,(a3)+                        ; 0045A
        move.w  d2,d5                           ; 0045C
        move.w  d3,d6                           ; 0045E
        move.w  d4,d7                           ; 00460
        muls.w  (a2)+,d5                        ; 00462
        muls.w  (a2)+,d6                        ; 00464
        muls.w  (a2)+,d7                        ; 00466
        add.l   d6,d7                           ; 00468
        add.l   d5,d7                           ; 0046A
        asr.l   #$8,d7                          ; 0046C
        move.w  d7,(a3)+                        ; 0046E
        muls.w  (a2)+,d2                        ; 00470
        muls.w  (a2)+,d3                        ; 00472
        muls.w  (a2)+,d4                        ; 00474
        add.l   d3,d4                           ; 00476
        add.l   d2,d4                           ; 00478
        asr.l   #$8,d4                          ; 0047A
        move.w  d4,(a3)+                        ; 0047C
        move.w  (LockedTarget).l,d2             ; 0047E
        blt.b   l_010_004B6                     ; 00484
        cmp.w   (CurrentObjectOffset).l,d2      ; 00486
        bne.b   l_010_004B6                     ; 0048C
        movem.w d0-d1/d4/d7,-(a7)               ; 0048E
        movem.w -$6(a3),d0-d2                   ; 00492
        jsr     (ProjectPoint).l                ; 00498
        sub.w   (ViewX).l,d0                    ; 0049E
        sub.w   (ViewY).l,d1                    ; 004A4
        movem.w d0-d1,(TargetScreenPos).l       ; 004AA
        movem.w (a7)+,d0-d1/d4/d7               ; 004B2
l_010_004B6:
        cmpi.w  #$1,-$62(a6)                    ; 004B6
        ble.b   l_010_004E4                     ; 004BC
        move.w  d4,d2                           ; 004BE
        ble.b   l_010_004DE                     ; 004C0
        asr.w   #$1,d2                          ; 004C2
        add.w   d2,d4                           ; 004C4
        move.w  -$6(a3),d2                      ; 004C6
        cmp.w   d4,d2                           ; 004CA
        bgt.b   l_010_004DE                     ; 004CC
        neg.w   d2                              ; 004CE
        cmp.w   d4,d2                           ; 004D0
        bgt.b   l_010_004DE                     ; 004D2
        cmp.w   d4,d7                           ; 004D4
        bgt.b   l_010_004DE                     ; 004D6
        neg.w   d7                              ; 004D8
        cmp.w   d4,d7                           ; 004DA
        ble.b   l_010_004E4                     ; 004DC
l_010_004DE:
        unlk    a6                              ; 004DE
        moveq   #$0,d0                          ; 004E0
        rts                                     ; 004E2
l_010_004E4:
        movem.w (a1)+,d2-d4                     ; 004E4
        lea.l   (SceneryMatrix).l,a2            ; 004E8
        move.w  d2,d5                           ; 004EE
        move.w  d3,d6                           ; 004F0
        move.w  d4,d7                           ; 004F2
        muls.w  (a2)+,d5                        ; 004F4
        muls.w  (a2)+,d6                        ; 004F6
        muls.w  (a2)+,d7                        ; 004F8
        add.l   d6,d7                           ; 004FA
        add.l   d5,d7                           ; 004FC
        asr.l   #$8,d7                          ; 004FE
        movea.w d7,a4                           ; 00500
        move.w  d2,d5                           ; 00502
        move.w  d3,d6                           ; 00504
        move.w  d4,d7                           ; 00506
        muls.w  (a2)+,d5                        ; 00508
        muls.w  (a2)+,d6                        ; 0050A
        muls.w  (a2)+,d7                        ; 0050C
        add.l   d6,d7                           ; 0050E
        add.l   d5,d7                           ; 00510
        asr.l   #$8,d7                          ; 00512
        move.w  d7,d6                           ; 00514
        muls.w  (a2)+,d2                        ; 00516
        muls.w  (a2)+,d3                        ; 00518
        muls.w  (a2)+,d4                        ; 0051A
        add.l   d3,d4                           ; 0051C
        add.l   d2,d4                           ; 0051E
        asr.l   #$8,d4                          ; 00520
        move.w  d4,d3                           ; 00522
        subq.w  #$1,-$60(a6)                    ; 00524
        blt.b   l_010_00530                     ; 00528
        move.w  a4,(a0)+                        ; 0052A
        move.w  d7,(a0)+                        ; 0052C
        move.w  d3,(a0)+                        ; 0052E
l_010_00530:
        subq.w  #$1,d1                          ; 00530
        blt.b   l_010_005AC                     ; 00532
        btst    #$0,-$7f(a6)                    ; 00534
        beq.b   l_010_00542                     ; 0053A
        bsr.w   sub_010_005B6                   ; 0053C
        bra.b   l_010_00598                     ; 00540
l_010_00542:
        move.w  a4,d2                           ; 00542
        move.w  d6,d3                           ; 00544
        move.w  -$8(a6),d7                      ; 00546
        asr.w   d7,d2                           ; 0054A
        asr.w   d7,d3                           ; 0054C
        asr.w   d7,d4                           ; 0054E
        add.w   -$14(a6),d2                     ; 00550
        add.w   -$12(a6),d3                     ; 00554
        add.w   -$10(a6),d4                     ; 00558
        lea.l   (ViewMatrix).l,a2               ; 0055C
        move.w  d2,d5                           ; 00562
        move.w  d3,d6                           ; 00564
        move.w  d4,d7                           ; 00566
        muls.w  (a2)+,d5                        ; 00568
        muls.w  (a2)+,d6                        ; 0056A
        muls.w  (a2)+,d7                        ; 0056C
        add.l   d6,d7                           ; 0056E
        add.l   d5,d7                           ; 00570
        asr.l   #$8,d7                          ; 00572
        move.w  d7,(a3)+                        ; 00574
        move.w  d2,d5                           ; 00576
        move.w  d3,d6                           ; 00578
        move.w  d4,d7                           ; 0057A
        muls.w  (a2)+,d5                        ; 0057C
        muls.w  (a2)+,d6                        ; 0057E
        muls.w  (a2)+,d7                        ; 00580
        add.l   d6,d7                           ; 00582
        add.l   d5,d7                           ; 00584
        asr.l   #$8,d7                          ; 00586
        move.w  d7,(a3)+                        ; 00588
        muls.w  (a2)+,d2                        ; 0058A
        muls.w  (a2)+,d3                        ; 0058C
        muls.w  (a2)+,d4                        ; 0058E
        add.l   d3,d4                           ; 00590
        add.l   d2,d4                           ; 00592
        asr.l   #$8,d4                          ; 00594
        move.w  d4,(a3)+                        ; 00596
l_010_00598:
        bra.w   l_010_004E4                     ; 00598
l_010_0059C:
        move.w  #$17,(DebugCheckpoint).l        ; 0059C
        jsr     (Nop).l                         ; 005A4
        bra.b   l_010_0059C                     ; 005AA
l_010_005AC:
        subq.w  #$1,d0                          ; 005AC
        bgt.w   l_010_004E4                     ; 005AE
        bra.w   l_010_009C0                     ; 005B2
sub_010_005B6:
        movem.w -$6(a1),d2-d4                   ; 005B6
        subi.w  #$28,d3                         ; 005BC
        subi.w  #$a3,d4                         ; 005C0
        move.w  -$8(a6),d7                      ; 005C4
        asr.w   d7,d2                           ; 005C8
        asr.w   d7,d3                           ; 005CA
        asr.w   d7,d4                           ; 005CC
        lea.l   (ObjectMatrix).l,a2             ; 005CE
        move.w  d2,d5                           ; 005D4
        move.w  d3,d6                           ; 005D6
        move.w  d4,d7                           ; 005D8
        muls.w  (a2)+,d5                        ; 005DA
        muls.w  (a2)+,d6                        ; 005DC
        muls.w  (a2)+,d7                        ; 005DE
        add.l   d6,d7                           ; 005E0
        add.l   d5,d7                           ; 005E2
        asr.l   #$8,d7                          ; 005E4
        move.w  d7,(a3)+                        ; 005E6
        move.w  d2,d5                           ; 005E8
        move.w  d3,d6                           ; 005EA
        move.w  d4,d7                           ; 005EC
        muls.w  (a2)+,d5                        ; 005EE
        muls.w  (a2)+,d6                        ; 005F0
        muls.w  (a2)+,d7                        ; 005F2
        add.l   d6,d7                           ; 005F4
        add.l   d5,d7                           ; 005F6
        asr.l   #$8,d7                          ; 005F8
        move.w  d7,(a3)+                        ; 005FA
        muls.w  (a2)+,d2                        ; 005FC
        muls.w  (a2)+,d3                        ; 005FE
        muls.w  (a2)+,d4                        ; 00600
        add.l   d3,d4                           ; 00602
        add.l   d2,d4                           ; 00604
        asr.l   #$8,d4                          ; 00606
        move.w  d4,(a3)+                        ; 00608
        rts                                     ; 0060A
l_010_0060C:
        unlk    a6                              ; 0060C
        moveq   #$0,d0                          ; 0060E
        rts                                     ; 00610
l_010_00612:
        cmpi.l  #$ffffffe0,(ViewOffsetY8).l     ; 00612
        blt.b   l_010_0063C                     ; 0061C
        andi.w  #$4,d7                          ; 0061E
        beq.b   l_010_0062A                     ; 00622
        move.w  #$170,d7                        ; 00624
        bra.b   l_010_0062E                     ; 00628
l_010_0062A:
        move.w  #$60,d7                         ; 0062A
l_010_0062E:
        move.w  (DistanceShift).l,d6            ; 0062E
        asr.w   d6,d7                           ; 00634
        cmp.w   -$28(a6),d7                     ; 00636
        blt.b   l_010_0060C                     ; 0063A
l_010_0063C:
        move.w  a5,d3                           ; 0063C
        move.w  d3,d6                           ; 0063E
        muls.w  $e(a4),d3                       ; 00640
        asr.l   #$8,d3                          ; 00644
        movea.w d3,a5                           ; 00646
        move.w  d6,d3                           ; 00648
        muls.w  $2(a4),d3                       ; 0064A
        asr.l   #$8,d3                          ; 0064E
        muls.w  $8(a4),d6                       ; 00650
        asr.l   #$8,d6                          ; 00654
        movem.w d3/d6/a5,-$78(a6)               ; 00656
        move.w  (a1)+,d2                        ; 0065C
        move.w  (a1)+,d4                        ; 0065E
        move.w  -$8(a6),d7                      ; 00660
        asr.w   d7,d2                           ; 00664
        asr.w   d7,d4                           ; 00666
        add.w   d0,d2                           ; 00668
        add.w   d1,d4                           ; 0066A
        lea.l   (a4),a2                         ; 0066C
        move.w  d2,d5                           ; 0066E
        move.w  d4,d7                           ; 00670
        muls.w  (a2)+,d5                        ; 00672
        addq.w  #$2,a2                          ; 00674
        muls.w  (a2)+,d7                        ; 00676
        add.l   d5,d7                           ; 00678
        asr.l   #$8,d7                          ; 0067A
        add.w   d3,d7                           ; 0067C
        move.w  d7,(a3)+                        ; 0067E
        move.w  d2,d5                           ; 00680
        move.w  d4,d7                           ; 00682
        muls.w  (a2)+,d5                        ; 00684
        addq.w  #$2,a2                          ; 00686
        muls.w  (a2)+,d7                        ; 00688
        add.l   d5,d7                           ; 0068A
        asr.l   #$8,d7                          ; 0068C
        add.w   d6,d7                           ; 0068E
        move.w  d7,(a3)+                        ; 00690
        muls.w  (a2)+,d2                        ; 00692
        muls.w  $2(a2),d4                       ; 00694
        add.l   d2,d4                           ; 00698
        asr.l   #$8,d4                          ; 0069A
        add.w   a5,d4                           ; 0069C
        move.w  d4,(a3)+                        ; 0069E
        tst.w   -$62(a6)                        ; 006A0
        beq.b   l_010_006CC                     ; 006A4
        move.w  d4,d2                           ; 006A6
        ble.b   l_010_006C6                     ; 006A8
        asr.w   #$1,d2                          ; 006AA
        add.w   d2,d4                           ; 006AC
        move.w  -$6(a3),d2                      ; 006AE
        cmp.w   d4,d2                           ; 006B2
        bgt.b   l_010_006C6                     ; 006B4
        neg.w   d2                              ; 006B6
        cmp.w   d4,d2                           ; 006B8
        bgt.b   l_010_006C6                     ; 006BA
        cmp.w   d4,d7                           ; 006BC
        bgt.b   l_010_006C6                     ; 006BE
        neg.w   d7                              ; 006C0
        cmp.w   d4,d7                           ; 006C2
        ble.b   l_010_006CC                     ; 006C4
l_010_006C6:
        unlk    a6                              ; 006C6
        moveq   #$0,d0                          ; 006C8
        rts                                     ; 006CA
l_010_006CC:
        tst.w   (a0)                            ; 006CC
        ble.w   l_010_009C0                     ; 006CE
l_010_006D2:
        move.w  (a1)+,d2                        ; 006D2
        move.w  (a1)+,d4                        ; 006D4
        move.w  -$8(a6),d7                      ; 006D6
        asr.w   d7,d2                           ; 006DA
        asr.w   d7,d4                           ; 006DC
        add.w   d0,d2                           ; 006DE
        add.w   d1,d4                           ; 006E0
        lea.l   (a4),a2                         ; 006E2
        move.w  d2,d5                           ; 006E4
        move.w  d4,d7                           ; 006E6
        muls.w  (a2)+,d5                        ; 006E8
        addq.w  #$2,a2                          ; 006EA
        muls.w  (a2)+,d7                        ; 006EC
        add.l   d5,d7                           ; 006EE
        asr.l   #$8,d7                          ; 006F0
        add.w   d3,d7                           ; 006F2
        move.w  d7,(a3)+                        ; 006F4
        move.w  d2,d5                           ; 006F6
        move.w  d4,d7                           ; 006F8
        muls.w  (a2)+,d5                        ; 006FA
        addq.w  #$2,a2                          ; 006FC
        muls.w  (a2)+,d7                        ; 006FE
        add.l   d5,d7                           ; 00700
        asr.l   #$8,d7                          ; 00702
        add.w   d6,d7                           ; 00704
        move.w  d7,(a3)+                        ; 00706
        muls.w  (a2)+,d2                        ; 00708
        muls.w  $2(a2),d4                       ; 0070A
        add.l   d2,d4                           ; 0070E
        asr.l   #$8,d4                          ; 00710
        add.w   a5,d4                           ; 00712
        move.w  d4,(a3)+                        ; 00714
        subq.w  #$1,(a0)                        ; 00716
        bgt.b   l_010_006D2                     ; 00718
        move.b  -$64(a6),d4                     ; 0071A
        andi.b  #$4,d4                          ; 0071E
        beq.w   l_010_009C0                     ; 00722
        jmp     (l_011_00006).l                 ; 00726
l_010_0072C:
        move.b  (a1)+,d3                        ; 0072C
        ext.w   d3                              ; 0072E
        addq.w  #$1,a1                          ; 00730
        lea.l   (ViewMatrix).l,a2               ; 00732
        lea.l   (a2),a4                         ; 00738
        movem.l -$20(a6),d0-d2                  ; 0073A
        exg.l   d1,d2                           ; 00740
        add.l   (ObjectViewPosL).l,d0           ; 00742
        add.l   (ObjectViewPosZL).l,d1          ; 00748
        add.l   (ObjectViewPosYL).l,d2          ; 0074E
        moveq   #$8,d7                          ; 00754
        sub.w   -$6(a6),d7                      ; 00756
        asr.l   d7,d0                           ; 0075A
        asr.l   d7,d1                           ; 0075C
        asr.l   d7,d2                           ; 0075E
        movea.w d2,a5                           ; 00760
        lea.l   -$a(a6),a0                      ; 00762
        subq.w  #$1,d3                          ; 00766
        move.w  d3,(a0)                         ; 00768
        move.w  d6,d7                           ; 0076A
        andi.w  #$2,d6                          ; 0076C
        bne.w   l_010_00612                     ; 00770
        movem.w (a1)+,d2-d4                     ; 00774
        move.w  -$8(a6),d7                      ; 00778
        asr.w   d7,d2                           ; 0077C
        asr.w   d7,d3                           ; 0077E
        asr.w   d7,d4                           ; 00780
        add.w   d0,d2                           ; 00782
        add.w   a5,d3                           ; 00784
        add.w   d1,d4                           ; 00786
        lea.l   (a4),a2                         ; 00788
        move.w  d2,d5                           ; 0078A
        move.w  d3,d6                           ; 0078C
        move.w  d4,d7                           ; 0078E
        muls.w  (a2)+,d5                        ; 00790
        muls.w  (a2)+,d6                        ; 00792
        muls.w  (a2)+,d7                        ; 00794
        add.l   d6,d7                           ; 00796
        add.l   d5,d7                           ; 00798
        asr.l   #$8,d7                          ; 0079A
        move.w  d7,(a3)+                        ; 0079C
        move.w  d2,d5                           ; 0079E
        move.w  d3,d6                           ; 007A0
        move.w  d4,d7                           ; 007A2
        muls.w  (a2)+,d5                        ; 007A4
        muls.w  (a2)+,d6                        ; 007A6
        muls.w  (a2)+,d7                        ; 007A8
        add.l   d6,d7                           ; 007AA
        add.l   d5,d7                           ; 007AC
        asr.l   #$8,d7                          ; 007AE
        move.w  d7,(a3)+                        ; 007B0
        muls.w  (a2)+,d2                        ; 007B2
        muls.w  (a2)+,d3                        ; 007B4
        muls.w  (a2)+,d4                        ; 007B6
        add.l   d3,d4                           ; 007B8
        add.l   d2,d4                           ; 007BA
        asr.l   #$8,d4                          ; 007BC
        move.w  d4,(a3)+                        ; 007BE
        tst.w   -$62(a6)                        ; 007C0
        beq.b   l_010_007EC                     ; 007C4
        move.w  d4,d2                           ; 007C6
        ble.b   l_010_007E6                     ; 007C8
        asr.w   #$1,d2                          ; 007CA
        add.w   d2,d4                           ; 007CC
        move.w  -$6(a3),d2                      ; 007CE
        cmp.w   d4,d2                           ; 007D2
        bgt.b   l_010_007E6                     ; 007D4
        neg.w   d2                              ; 007D6
        cmp.w   d4,d2                           ; 007D8
        bgt.b   l_010_007E6                     ; 007DA
        cmp.w   d4,d7                           ; 007DC
        bgt.b   l_010_007E6                     ; 007DE
        neg.w   d7                              ; 007E0
        cmp.w   d4,d7                           ; 007E2
        ble.b   l_010_007EC                     ; 007E4
l_010_007E6:
        unlk    a6                              ; 007E6
        moveq   #$0,d0                          ; 007E8
        rts                                     ; 007EA
l_010_007EC:
        tst.w   (a0)                            ; 007EC
        ble.b   l_010_00840                     ; 007EE
l_010_007F0:
        movem.w (a1)+,d2-d4                     ; 007F0
        move.w  -$8(a6),d7                      ; 007F4
        asr.w   d7,d2                           ; 007F8
        asr.w   d7,d3                           ; 007FA
        asr.w   d7,d4                           ; 007FC
        add.w   d0,d2                           ; 007FE
        add.w   a5,d3                           ; 00800
        add.w   d1,d4                           ; 00802
        lea.l   (a4),a2                         ; 00804
        move.w  d2,d5                           ; 00806
        move.w  d3,d6                           ; 00808
        move.w  d4,d7                           ; 0080A
        muls.w  (a2)+,d5                        ; 0080C
        muls.w  (a2)+,d6                        ; 0080E
        muls.w  (a2)+,d7                        ; 00810
        add.l   d6,d7                           ; 00812
        add.l   d5,d7                           ; 00814
        asr.l   #$8,d7                          ; 00816
        move.w  d7,(a3)+                        ; 00818
        move.w  d2,d5                           ; 0081A
        move.w  d3,d6                           ; 0081C
        move.w  d4,d7                           ; 0081E
        muls.w  (a2)+,d5                        ; 00820
        muls.w  (a2)+,d6                        ; 00822
        muls.w  (a2)+,d7                        ; 00824
        add.l   d6,d7                           ; 00826
        add.l   d5,d7                           ; 00828
        asr.l   #$8,d7                          ; 0082A
        move.w  d7,(a3)+                        ; 0082C
        muls.w  (a2)+,d2                        ; 0082E
        muls.w  (a2)+,d3                        ; 00830
        muls.w  (a2)+,d4                        ; 00832
        add.l   d3,d4                           ; 00834
        add.l   d2,d4                           ; 00836
        asr.l   #$8,d4                          ; 00838
        move.w  d4,(a3)+                        ; 0083A
        subq.w  #$1,(a0)                        ; 0083C
        bgt.b   l_010_007F0                     ; 0083E
l_010_00840:
        move.b  -$64(a6),d4                     ; 00840
        andi.b  #$8,d4                          ; 00844
        beq.w   l_010_009C0                     ; 00848
        lea.l   (dat_072_02A00).l,a0            ; 0084C
l_010_00852:
        move.w  (a1)+,-$30(a6)                  ; 00852
        blt.w   l_010_009C0                     ; 00856
        move.w  #$c,-$a(a6)                     ; 0085A
        movem.w (a1)+,d2-d4                     ; 00860
        move.w  -$8(a6),d7                      ; 00864
        asr.w   d7,d2                           ; 00868
        asr.w   d7,d3                           ; 0086A
        asr.w   d7,d4                           ; 0086C
        add.w   d0,d2                           ; 0086E
        add.w   a5,d3                           ; 00870
        add.w   d1,d4                           ; 00872
        lea.l   (ViewMatrix).l,a2               ; 00874
        move.w  d2,d5                           ; 0087A
        move.w  d3,d6                           ; 0087C
        move.w  d4,d7                           ; 0087E
        muls.w  (a2)+,d5                        ; 00880
        muls.w  (a2)+,d6                        ; 00882
        muls.w  (a2)+,d7                        ; 00884
        add.l   d6,d7                           ; 00886
        add.l   d5,d7                           ; 00888
        move.l  d7,(a0)                         ; 0088A
        asr.l   #$8,d7                          ; 0088C
        move.w  d7,(a3)+                        ; 0088E
        move.w  d2,d5                           ; 00890
        move.w  d3,d6                           ; 00892
        move.w  d4,d7                           ; 00894
        muls.w  (a2)+,d5                        ; 00896
        muls.w  (a2)+,d6                        ; 00898
        muls.w  (a2)+,d7                        ; 0089A
        add.l   d6,d7                           ; 0089C
        add.l   d5,d7                           ; 0089E
        move.l  d7,$4(a0)                       ; 008A0
        asr.l   #$8,d7                          ; 008A4
        move.w  d7,(a3)+                        ; 008A6
        muls.w  (a2)+,d2                        ; 008A8
        muls.w  (a2)+,d3                        ; 008AA
        muls.w  (a2)+,d4                        ; 008AC
        add.l   d3,d4                           ; 008AE
        add.l   d2,d4                           ; 008B0
        move.l  d4,$8(a0)                       ; 008B2
        asr.l   #$8,d4                          ; 008B6
        move.w  d4,(a3)+                        ; 008B8
        adda.w  #$6,a3                          ; 008BA
l_010_008BE:
        movem.w (a1)+,d2-d4                     ; 008BE
        move.w  -$8(a6),d7                      ; 008C2
        asr.w   d7,d2                           ; 008C6
        asr.w   d7,d3                           ; 008C8
        asr.w   d7,d4                           ; 008CA
        add.w   d0,d2                           ; 008CC
        add.w   a5,d3                           ; 008CE
        add.w   d1,d4                           ; 008D0
        lea.l   (ViewMatrix).l,a2               ; 008D2
        move.w  d2,d5                           ; 008D8
        move.w  d3,d6                           ; 008DA
        move.w  d4,d7                           ; 008DC
        muls.w  (a2)+,d5                        ; 008DE
        muls.w  (a2)+,d6                        ; 008E0
        muls.w  (a2)+,d7                        ; 008E2
        add.l   d6,d7                           ; 008E4
        add.l   d5,d7                           ; 008E6
        move.l  d7,$c(a0)                       ; 008E8
        move.w  d2,d5                           ; 008EC
        move.w  d3,d6                           ; 008EE
        move.w  d4,d7                           ; 008F0
        muls.w  (a2)+,d5                        ; 008F2
        muls.w  (a2)+,d6                        ; 008F4
        muls.w  (a2)+,d7                        ; 008F6
        add.l   d6,d7                           ; 008F8
        add.l   d5,d7                           ; 008FA
        move.l  d7,$10(a0)                      ; 008FC
        muls.w  (a2)+,d2                        ; 00900
        muls.w  (a2)+,d3                        ; 00902
        muls.w  (a2)+,d4                        ; 00904
        add.l   d3,d4                           ; 00906
        add.l   d2,d4                           ; 00908
        move.l  d4,$14(a0)                      ; 0090A
        movem.w d0-d1,-(a7)                     ; 0090E
        move.w  (a1)+,d0                        ; 00912
        cmpi.w  #$1,d0                          ; 00914
        ble.b   l_010_00962                     ; 00918
        movem.l (a0),d2-d7                      ; 0091A
        asr.l   #$4,d2                          ; 0091E
        asr.l   #$4,d3                          ; 00920
        asr.l   #$4,d4                          ; 00922
        asr.l   #$4,d5                          ; 00924
        asr.l   #$4,d6                          ; 00926
        asr.l   #$4,d7                          ; 00928
        sub.l   d2,d5                           ; 0092A
        sub.l   d3,d6                           ; 0092C
        sub.l   d4,d7                           ; 0092E
        divs.w  d0,d5                           ; 00930
        divs.w  d0,d6                           ; 00932
        divs.w  d0,d7                           ; 00934
        ext.l   d5                              ; 00936
        ext.l   d6                              ; 00938
        ext.l   d7                              ; 0093A
        subq.w  #$2,d0                          ; 0093C
l_010_0093E:
        add.l   d5,d2                           ; 0093E
        add.l   d6,d3                           ; 00940
        add.l   d7,d4                           ; 00942
        move.l  d2,d1                           ; 00944
        asr.l   #$4,d1                          ; 00946
        move.w  d1,(a3)                         ; 00948
        move.l  d3,d1                           ; 0094A
        asr.l   #$4,d1                          ; 0094C
        move.w  d1,$2(a3)                       ; 0094E
        move.l  d4,d1                           ; 00952
        asr.l   #$4,d1                          ; 00954
        move.w  d1,$4(a3)                       ; 00956
        adda.w  -$a(a6),a3                      ; 0095A
        dbra    d0,l_010_0093E                  ; 0095E
l_010_00962:
        movem.l $c(a0),d5-d7                    ; 00962
        movem.l d5-d7,(a0)                      ; 00968
        asr.l   #$8,d5                          ; 0096C
        asr.l   #$8,d6                          ; 0096E
        asr.l   #$8,d7                          ; 00970
        movem.w d5-d7,(a3)                      ; 00972
        adda.w  -$a(a6),a3                      ; 00976
        movem.w (a7)+,d0-d1                     ; 0097A
        subq.w  #$1,-$30(a6)                    ; 0097E
        bgt.w   l_010_008BE                     ; 00982
        tst.w   -$a(a6)                         ; 00986
        blt.b   l_010_009B4                     ; 0098A
        move.w  #$fff4,-$a(a6)                  ; 0098C
        move.l  a3,-$72(a6)                     ; 00992
        move.w  (a1)+,d2                        ; 00996
        beq.b   l_010_009B4                     ; 00998
        btst    #$f,d2                          ; 0099A
        beq.b   l_010_009A8                     ; 0099E
        subq.w  #$6,a3                          ; 009A0
        andi.w  #$7fff,d2                       ; 009A2
        bra.b   l_010_009AC                     ; 009A6
l_010_009A8:
        suba.w  #$12,a3                         ; 009A8
l_010_009AC:
        move.w  d2,-$30(a6)                     ; 009AC
        bra.w   l_010_008BE                     ; 009B0
l_010_009B4:
        tst.w   (a1)                            ; 009B4
        ble.b   l_010_009C0                     ; 009B6
        movea.l -$72(a6),a3                     ; 009B8
        bra.w   l_010_00852                     ; 009BC
l_010_009C0:
        move.l  #$fffff,(FillPattern).l         ; 009C0
        clr.l   (FillPattern2).l                ; 009CA
        movea.l (ShapeNow).l,a5                 ; 009D0
        clr.w   -$66(a6)                        ; 009D6
        clr.w   -$7c(a6)                        ; 009DA
l_010_009DE:
        tst.w   -$66(a6)                        ; 009DE
        bne.w   l_010_00B0C                     ; 009E2
        move.w  (a5)+,d0                        ; 009E6
        blt.w   l_010_00A68                     ; 009E8
        move.w  (a5)+,d7                        ; 009EC
        move.w  d7,d1                           ; 009EE
        andi.w  #$fc00,d1                       ; 009F0
        cmpi.w  #$fc00,d1                       ; 009F4
        beq.b   l_010_00A56                     ; 009F8
        andi.w  #$c00,d1                        ; 009FA
        bne.b   l_010_00A44                     ; 009FE
        lea.l   (VertexBuffer).l,a3             ; 00A00
        move.w  d7,d1                           ; 00A06
        andi.w  #$2000,d1                       ; 00A08
        bne.b   l_010_00A38                     ; 00A0C
        lea.l   (dat_072_03C04).l,a0            ; 00A0E
        lea.l   (a3,d0.w),a4                    ; 00A14
        move.l  (a4)+,(a0)+                     ; 00A18
        move.w  (a4),(a0)+                      ; 00A1A
        movem.w (a5)+,d1-d2                     ; 00A1C
        lea.l   (a3,d1.w),a4                    ; 00A20
        move.l  (a4)+,(a0)+                     ; 00A24
        move.w  (a4),(a0)+                      ; 00A26
        lea.l   (a3,d2.w),a4                    ; 00A28
        move.l  (a4)+,(a0)+                     ; 00A2C
        move.w  (a4),(a0)                       ; 00A2E
        movea.w d7,a3                           ; 00A30
        bsr.w   sub_010_00E54                   ; 00A32
        bra.b   l_010_00A48                     ; 00A36
l_010_00A38:
        movem.w (a5)+,d0-d5                     ; 00A38
        jsr     (PlaneFacesCamera).l            ; 00A3C
        bra.b   l_010_00A48                     ; 00A42
l_010_00A44:
        bsr.w   AxisPlaneTest                   ; 00A44
l_010_00A48:
        beq.b   l_010_00A56                     ; 00A48
        movea.l -$2c(a6),a3                     ; 00A4A
        adda.w  $2(a5),a3                       ; 00A4E
        lea.l   (a3),a5                         ; 00A52
        bra.b   l_010_009DE                     ; 00A54
l_010_00A56:
        movea.l -$2c(a6),a3                     ; 00A56
        adda.w  (a5),a3                         ; 00A5A
        lea.l   (a3),a5                         ; 00A5C
        bra.w   l_010_009DE                     ; 00A5E
l_010_00A62:
        unlk    a6                              ; 00A62
        moveq   #$0,d0                          ; 00A64
        rts                                     ; 00A66
l_010_00A68:
        cmpi.w  #$ffff,d0                       ; 00A68
        beq.b   l_010_00A62                     ; 00A6C
        clr.w   -$6c(a6)                        ; 00A6E
        clr.w   -$7a(a6)                        ; 00A72
        move.w  d0,d1                           ; 00A76
        andi.w  #$2000,d1                       ; 00A78
        beq.b   l_010_00A9A                     ; 00A7C
        addq.w  #$1,-$6c(a6)                    ; 00A7E
        move.w  d0,d1                           ; 00A82
        andi.w  #$1000,d1                       ; 00A84
        beq.b   l_010_00A90                     ; 00A88
        movea.l (a5)+,a2                        ; 00A8A
        bra.w   l_010_00BCE                     ; 00A8C
l_010_00A90:
        movea.l -$2c(a6),a3                     ; 00A90
        andi.w  #$fff,d0                        ; 00A94
        bra.b   l_010_00AE2                     ; 00A98
l_010_00A9A:
        move.w  d0,d1                           ; 00A9A
        andi.w  #$4000,d1                       ; 00A9C
        beq.b   l_010_00AA6                     ; 00AA0
        addq.w  #$1,-$66(a6)                    ; 00AA2
l_010_00AA6:
        move.w  d0,d1                           ; 00AA6
        andi.w  #$1000,d1                       ; 00AA8
        beq.b   l_010_00AB2                     ; 00AAC
        movea.l (a5)+,a1                        ; 00AAE
        bra.b   l_010_00ABE                     ; 00AB0
l_010_00AB2:
        movea.l -$2c(a6),a3                     ; 00AB2
        andi.w  #$fff,d0                        ; 00AB6
        lea.l   (a3,d0.w),a1                    ; 00ABA
l_010_00ABE:
        clr.w   -$68(a6)                        ; 00ABE
l_010_00AC2:
        tst.w   -$7a(a6)                        ; 00AC2
        bne.b   l_010_00B00                     ; 00AC6
        tst.w   -$6c(a6)                        ; 00AC8
        bne.b   l_010_00B0C                     ; 00ACC
        tst.w   -$68(a6)                        ; 00ACE
        bne.b   l_010_00B00                     ; 00AD2
        move.w  (a1)+,d0                        ; 00AD4
        move.w  d0,d1                           ; 00AD6
        andi.w  #$8000,d1                       ; 00AD8
        beq.b   l_010_00AE2                     ; 00ADC
        addq.w  #$1,-$68(a6)                    ; 00ADE
l_010_00AE2:
        move.w  d0,d1                           ; 00AE2
        andi.w  #$1000,d1                       ; 00AE4
        beq.b   l_010_00AF0                     ; 00AE8
        movea.l (a1)+,a2                        ; 00AEA
        bra.w   l_010_00BCE                     ; 00AEC
l_010_00AF0:
        andi.w  #$fff,d0                        ; 00AF0
        movea.l -$2c(a6),a3                     ; 00AF4
        lea.l   (a3,d0.w),a2                    ; 00AF8
        bra.w   l_010_00BCE                     ; 00AFC
l_010_00B00:
        bra.w   l_010_009DE                     ; 00B00
l_010_00B04:
        move.w  -$7c(a6),d0                     ; 00B04
        unlk    a6                              ; 00B08
        rts                                     ; 00B0A
l_010_00B0C:
        btst    #$6,(ObjectDrawFlags).l         ; 00B0C
        bne.b   l_010_00B04                     ; 00B14
        btst    #$4,(ObjectDrawFlags).l         ; 00B16
        beq.b   l_010_00B04                     ; 00B1E
        lea.l   (ObjectTable).l,a0              ; 00B20
        adda.w  (CurrentObjectOffset).l,a0      ; 00B26
        move.w  $0(a0),d0                       ; 00B2C
        andi.w  #$400,d0                        ; 00B30
        beq.b   l_010_00BA0                     ; 00B34
        move.w  $4c(a0),d1                      ; 00B36
        blt.b   l_010_00BA0                     ; 00B3A
        cmpi.w  #$10,d1                         ; 00B3C
        bge.b   l_010_00BA0                     ; 00B40
l_010_00B42:
        moveq   #$f,d3                          ; 00B42
        sub.w   d1,d3                           ; 00B44
        cmpi.w  #$f,d3                          ; 00B46
        bgt.b   l_010_00BA0                     ; 00B4A
        move.w  $c(a0),d0                       ; 00B4C
        move.l  $10(a0),d1                      ; 00B50
        move.w  $e(a0),d2                       ; 00B54
        ext.l   d0                              ; 00B58
        move.w  $6(a0),d4                       ; 00B5A
        sub.w   (ViewCellX).l,d4                ; 00B5E
        ext.l   d4                              ; 00B64
        moveq   #$e,d5                          ; 00B66
        asl.l   d5,d4                           ; 00B68
        add.l   d4,d0                           ; 00B6A
        ext.l   d2                              ; 00B6C
        move.w  $8(a0),d4                       ; 00B6E
        sub.w   (ViewCellZ).l,d4                ; 00B72
        ext.l   d4                              ; 00B78
        asl.l   d5,d4                           ; 00B7A
        add.l   d4,d2                           ; 00B7C
        moveq   #$3,d4                          ; 00B7E
        cmpi.b  #$15,$62(a0)                    ; 00B80
        beq.b   l_010_00B94                     ; 00B86
        moveq   #$1,d4                          ; 00B88
        btst    #$1,$4(a0)                      ; 00B8A
        beq.b   l_010_00B94                     ; 00B90
        moveq   #$2,d4                          ; 00B92
l_010_00B94:
        move.w  (DistanceShift).l,d7            ; 00B94
        jsr     (DrawPuff).l                    ; 00B9A
l_010_00BA0:
        jsr     (DrawObjectFlame).l             ; 00BA0
        move.w  -$7c(a6),d0                     ; 00BA6
        unlk    a6                              ; 00BAA
        rts                                     ; 00BAC
sub_010_00BAE:
        unlk    a6                              ; 00BAE
        moveq   #$0,d0                          ; 00BB0
        rts                                     ; 00BB2
l_010_00BB4:
        bra.w   l_010_00AC2                     ; 00BB4
l_010_00BB8:
        move.w  (a2)+,d0                        ; 00BB8
        blt.b   l_010_00BB4                     ; 00BBA
        move.w  (DistanceShift).l,d1            ; 00BBC
        asr.w   d1,d0                           ; 00BC2
        cmp.w   -$28(a6),d0                     ; 00BC4
        blt.b   l_010_00BB4                     ; 00BC8
        bra.w   l_010_00C2E                     ; 00BCA
l_010_00BCE:
        clr.w   -$6a(a6)                        ; 00BCE
l_010_00BD2:
        tst.w   -$6a(a6)                        ; 00BD2
        bne.b   l_010_00BB4                     ; 00BD6
        move.w  (a2)+,d0                        ; 00BD8
        bge.b   l_010_00C16                     ; 00BDA
        cmpi.w  #$ffff,d0                       ; 00BDC
        bne.b   l_010_00BF0                     ; 00BE0
        move.w  d0,(DebugCheckpoint).l          ; 00BE2
        jsr     (Nop).l                         ; 00BE8
        bra.b   l_010_00BB4                     ; 00BEE
l_010_00BF0:
        move.w  d0,d1                           ; 00BF0
        andi.w  #$4000,d1                       ; 00BF2
        beq.b   l_010_00BFC                     ; 00BF6
        addq.w  #$1,-$6a(a6)                    ; 00BF8
l_010_00BFC:
        andi.w  #$3fff,d0                       ; 00BFC
        lea.l   (ShapeOps).l,a0                 ; 00C00
        movea.l (a0,d0.w),a0                    ; 00C06
        jsr     (a0)                            ; 00C0A
        blt.w   l_010_00AC2                     ; 00C0C
        or.w    d0,-$7c(a6)                     ; 00C10
        bra.b   l_010_00BD2                     ; 00C14
l_010_00C16:
        cmpi.w  #$7fff,d0                       ; 00C16
        beq.b   l_010_00C2E                     ; 00C1A
        move.w  (DistanceShift).l,d1            ; 00C1C
        asr.w   d1,d0                           ; 00C22
        cmp.w   -$28(a6),d0                     ; 00C24
        blt.b   l_010_00BB8                     ; 00C28
        tst.w   (a2)+                           ; 00C2A
        bge.b   l_010_00BB4                     ; 00C2C
l_010_00C2E:
        move.w  (a2)+,d0                        ; 00C2E
        ble.b   l_010_00C38                     ; 00C30
        move.w  (a2)+,d7                        ; 00C32
        bsr.w   TransformMoreVertices           ; 00C34
l_010_00C38:
        move.w  (a2)+,d0                        ; 00C38
        move.w  d0,d1                           ; 00C3A
        andi.w  #$4000,d1                       ; 00C3C
        beq.b   l_010_00C46                     ; 00C40
        addq.w  #$1,-$6a(a6)                    ; 00C42
l_010_00C46:
        andi.w  #$3fff,d0                       ; 00C46
        lea.l   (ShapeOps).l,a0                 ; 00C4A
        movea.l (a0,d0.w),a0                    ; 00C50
        jsr     (a0)                            ; 00C54
        blt.w   l_010_00AC2                     ; 00C56
        or.w    d0,-$7c(a6)                     ; 00C5A
        bra.w   l_010_00BD2                     ; 00C5E

;-------------------------------------------------------------------------------
; TransformMoreVertices - Transforms a further group of a shape's vertices into VertexBuffer
; when a face list needs them (a count and an offset before the list), so parts not drawn cost
; nothing.
;-------------------------------------------------------------------------------
TransformMoreVertices:
        lea.l   (VertexBuffer).l,a3             ; 00C62
        move.l  a1,-(a7)                        ; 00C68
        move.w  d0,-$a(a6)                      ; 00C6A
        movea.l (CurrentShape).l,a1             ; 00C6E
        move.b  $7(a1),d6                       ; 00C74
        btst    #$0,d6                          ; 00C78
        beq.w   l_010_00D5A                     ; 00C7C
        movem.l a2/a5,-(a7)                     ; 00C80
        lea.l   $a(a1,d7.w),a1                  ; 00C84
        lea.l   (SceneryMatrix).l,a2            ; 00C88
        lea.l   (a2),a4                         ; 00C8E
        adda.w  d7,a3                           ; 00C90
        movem.l -$20(a6),d0-d2                  ; 00C92
        exg.l   d1,d2                           ; 00C98
        movem.l (ObjectViewPosL).l,d3-d5        ; 00C9A
        add.l   d3,d0                           ; 00CA2
        add.l   d4,d2                           ; 00CA4
        add.l   d5,d1                           ; 00CA6
        moveq   #$8,d7                          ; 00CA8
        sub.w   -$6(a6),d7                      ; 00CAA
        asr.l   d7,d0                           ; 00CAE
        asr.l   d7,d1                           ; 00CB0
        asr.l   d7,d2                           ; 00CB2
        movea.w d2,a0                           ; 00CB4
l_010_00CB6:
        movem.w (a1)+,d2-d4                     ; 00CB6
        move.w  -$8(a6),d7                      ; 00CBA
        asr.w   d7,d2                           ; 00CBE
        asr.w   d7,d3                           ; 00CC0
        asr.w   d7,d4                           ; 00CC2
        lea.l   (a4),a2                         ; 00CC4
        move.w  d2,d5                           ; 00CC6
        move.w  d3,d6                           ; 00CC8
        move.w  d4,d7                           ; 00CCA
        muls.w  (a2)+,d5                        ; 00CCC
        muls.w  (a2)+,d6                        ; 00CCE
        muls.w  (a2)+,d7                        ; 00CD0
        add.l   d6,d7                           ; 00CD2
        add.l   d5,d7                           ; 00CD4
        asr.l   #$8,d7                          ; 00CD6
        movea.w d7,a5                           ; 00CD8
        move.w  d2,d5                           ; 00CDA
        move.w  d3,d6                           ; 00CDC
        move.w  d4,d7                           ; 00CDE
        muls.w  (a2)+,d5                        ; 00CE0
        muls.w  (a2)+,d6                        ; 00CE2
        muls.w  (a2)+,d7                        ; 00CE4
        add.l   d6,d7                           ; 00CE6
        add.l   d5,d7                           ; 00CE8
        asr.l   #$8,d7                          ; 00CEA
        muls.w  (a2)+,d2                        ; 00CEC
        muls.w  (a2)+,d3                        ; 00CEE
        muls.w  (a2)+,d4                        ; 00CF0
        add.l   d3,d4                           ; 00CF2
        add.l   d2,d4                           ; 00CF4
        asr.l   #$8,d4                          ; 00CF6
        btst    #$0,-$7f(a6)                    ; 00CF8
        beq.b   l_010_00D06                     ; 00CFE
        bsr.w   sub_010_005B6                   ; 00D00
        bra.b   l_010_00D4A                     ; 00D04
l_010_00D06:
        move.w  a5,d2                           ; 00D06
        move.w  d7,d3                           ; 00D08
        add.w   d0,d2                           ; 00D0A
        add.w   a0,d3                           ; 00D0C
        add.w   d1,d4                           ; 00D0E
        lea.l   $12(a4),a2                      ; 00D10
        move.w  d2,d5                           ; 00D14
        move.w  d3,d6                           ; 00D16
        move.w  d4,d7                           ; 00D18
        muls.w  (a2)+,d5                        ; 00D1A
        muls.w  (a2)+,d6                        ; 00D1C
        muls.w  (a2)+,d7                        ; 00D1E
        add.l   d6,d7                           ; 00D20
        add.l   d5,d7                           ; 00D22
        asr.l   #$8,d7                          ; 00D24
        move.w  d7,(a3)+                        ; 00D26
        move.w  d2,d5                           ; 00D28
        move.w  d3,d6                           ; 00D2A
        move.w  d4,d7                           ; 00D2C
        muls.w  (a2)+,d5                        ; 00D2E
        muls.w  (a2)+,d6                        ; 00D30
        muls.w  (a2)+,d7                        ; 00D32
        add.l   d6,d7                           ; 00D34
        add.l   d5,d7                           ; 00D36
        asr.l   #$8,d7                          ; 00D38
        move.w  d7,(a3)+                        ; 00D3A
        muls.w  (a2)+,d2                        ; 00D3C
        muls.w  (a2)+,d3                        ; 00D3E
        muls.w  (a2)+,d4                        ; 00D40
        add.l   d3,d4                           ; 00D42
        add.l   d2,d4                           ; 00D44
        asr.l   #$8,d4                          ; 00D46
        move.w  d4,(a3)+                        ; 00D48
l_010_00D4A:
        subq.w  #$1,-$a(a6)                     ; 00D4A
        bgt.w   l_010_00CB6                     ; 00D4E
        movem.l (a7)+,a2/a5                     ; 00D52
        movea.l (a7)+,a1                        ; 00D56
        rts                                     ; 00D58
l_010_00D5A:
        adda.w  #$a,a1                          ; 00D5A
        adda.w  d7,a1                           ; 00D5E
        lea.l   (ViewMatrix).l,a0               ; 00D60
        lea.l   (a0),a4                         ; 00D66
        movem.l -$20(a6),d0-d2                  ; 00D68
        exg.l   d1,d2                           ; 00D6E
        add.l   (ObjectViewPosL).l,d0           ; 00D70
        add.l   (ObjectViewPosZL).l,d1          ; 00D76
        moveq   #$8,d3                          ; 00D7C
        sub.w   -$6(a6),d3                      ; 00D7E
        asr.l   d3,d0                           ; 00D82
        asr.l   d3,d1                           ; 00D84
        asr.l   d3,d2                           ; 00D86
        move.w  d2,-$12(a6)                     ; 00D88
        andi.w  #$2,d6                          ; 00D8C
        bne.b   l_010_00DEC                     ; 00D90
        adda.w  d7,a3                           ; 00D92
l_010_00D94:
        movem.w (a1)+,d2-d4                     ; 00D94
        move.w  -$8(a6),d7                      ; 00D98
        asr.w   d7,d2                           ; 00D9C
        asr.w   d7,d3                           ; 00D9E
        asr.w   d7,d4                           ; 00DA0
        add.w   d0,d2                           ; 00DA2
        add.w   -$12(a6),d3                     ; 00DA4
        add.w   d1,d4                           ; 00DA8
        lea.l   (a4),a0                         ; 00DAA
        move.w  d2,d5                           ; 00DAC
        move.w  d3,d6                           ; 00DAE
        move.w  d4,d7                           ; 00DB0
        muls.w  (a0)+,d5                        ; 00DB2
        muls.w  (a0)+,d6                        ; 00DB4
        muls.w  (a0)+,d7                        ; 00DB6
        add.l   d6,d7                           ; 00DB8
        add.l   d5,d7                           ; 00DBA
        asr.l   #$8,d7                          ; 00DBC
        move.w  d7,(a3)+                        ; 00DBE
        move.w  d2,d5                           ; 00DC0
        move.w  d3,d6                           ; 00DC2
        move.w  d4,d7                           ; 00DC4
        muls.w  (a0)+,d5                        ; 00DC6
        muls.w  (a0)+,d6                        ; 00DC8
        muls.w  (a0)+,d7                        ; 00DCA
        add.l   d6,d7                           ; 00DCC
        add.l   d5,d7                           ; 00DCE
        asr.l   #$8,d7                          ; 00DD0
        move.w  d7,(a3)+                        ; 00DD2
        muls.w  (a0)+,d2                        ; 00DD4
        muls.w  (a0)+,d3                        ; 00DD6
        muls.w  (a0)+,d4                        ; 00DD8
        add.l   d3,d4                           ; 00DDA
        add.l   d2,d4                           ; 00DDC
        asr.l   #$8,d4                          ; 00DDE
        move.w  d4,(a3)+                        ; 00DE0
        subq.w  #$1,-$a(a6)                     ; 00DE2
        bgt.b   l_010_00D94                     ; 00DE6
        movea.l (a7)+,a1                        ; 00DE8
        rts                                     ; 00DEA
l_010_00DEC:
        move.w  d7,d2                           ; 00DEC
        asr.w   #$1,d2                          ; 00DEE
        add.w   d2,d7                           ; 00DF0
        adda.w  d7,a3                           ; 00DF2
        movem.w -$78(a6),d3/d6                  ; 00DF4
l_010_00DFA:
        move.w  (a1)+,d2                        ; 00DFA
        move.w  (a1)+,d4                        ; 00DFC
        move.w  -$8(a6),d7                      ; 00DFE
        asr.w   d7,d2                           ; 00E02
        asr.w   d7,d4                           ; 00E04
        add.w   d0,d2                           ; 00E06
        add.w   d1,d4                           ; 00E08
        lea.l   (a4),a0                         ; 00E0A
        move.w  d2,d5                           ; 00E0C
        move.w  d4,d7                           ; 00E0E
        muls.w  (a0)+,d5                        ; 00E10
        addq.w  #$2,a0                          ; 00E12
        muls.w  (a0)+,d7                        ; 00E14
        add.l   d5,d7                           ; 00E16
        asr.l   #$8,d7                          ; 00E18
        add.w   d3,d7                           ; 00E1A
        move.w  d7,(a3)+                        ; 00E1C
        move.w  d2,d5                           ; 00E1E
        move.w  d4,d7                           ; 00E20
        muls.w  (a0)+,d5                        ; 00E22
        addq.w  #$2,a0                          ; 00E24
        muls.w  (a0)+,d7                        ; 00E26
        add.l   d5,d7                           ; 00E28
        asr.l   #$8,d7                          ; 00E2A
        add.w   d6,d7                           ; 00E2C
        move.w  d7,(a3)+                        ; 00E2E
        muls.w  (a0)+,d2                        ; 00E30
        muls.w  $2(a0),d4                       ; 00E32
        add.l   d2,d4                           ; 00E36
        asr.l   #$8,d4                          ; 00E38
        add.w   -$74(a6),d4                     ; 00E3A
        move.w  d4,(a3)+                        ; 00E3E
        subq.w  #$1,-$a(a6)                     ; 00E40
        bgt.b   l_010_00DFA                     ; 00E44
        movea.l (a7)+,a1                        ; 00E46
        rts                                     ; 00E48

;-------------------------------------------------------------------------------
; FacesCamera - The side test of DrawModel's drawing list and of ShapePolygon: returns d7 = 1
; when the camera is on the front of the plane - from three transformed vertices (their cross
; product dotted with the first; flags $3000 clear), from a stored point and normal
; (PlaneFacesCamera), or against one of the model's coordinates (flags $C00, AxisPlaneTest).
;-------------------------------------------------------------------------------
FacesCamera:
        move.w  d7,d1                           ; 00E4A
        andi.w  #$c00,d1                        ; 00E4C
        bne.w   l_010_00F02                     ; 00E50
sub_010_00E54:
        andi.w  #$3000,d7                       ; 00E54
        beq.b   l_010_00E9C                     ; 00E58
        movea.l -$2c(a6),a0                     ; 00E5A
        adda.w  (a2)+,a0                        ; 00E5E
        movem.w (a0),d0-d5                      ; 00E60

;-------------------------------------------------------------------------------
; PlaneFacesCamera - The side test for a plane given as a point and a normal (6 words): the
; normal dotted with the camera's offset from the point.
;-------------------------------------------------------------------------------
PlaneFacesCamera:
        move.w  (DistanceShift).l,d7            ; 00E64
        asr.w   d7,d0                           ; 00E6A
        asr.w   d7,d1                           ; 00E6C
        asr.w   d7,d2                           ; 00E6E
        add.w   (ObjectViewPos).l,d0            ; 00E70
        add.w   (ObjectViewPosZ).l,d2           ; 00E76
        sub.w   -$26(a6),d0                     ; 00E7C
        sub.w   -$24(a6),d1                     ; 00E80
        sub.w   -$22(a6),d2                     ; 00E84
        muls.w  d3,d0                           ; 00E88
        muls.w  d4,d1                           ; 00E8A
        muls.w  d5,d2                           ; 00E8C
        add.l   d0,d2                           ; 00E8E
        add.l   d1,d2                           ; 00E90
        blt.b   l_010_00E98                     ; 00E92
        moveq   #$1,d7                          ; 00E94
        rts                                     ; 00E96
l_010_00E98:
        clr.w   d7                              ; 00E98
        rts                                     ; 00E9A
l_010_00E9C:
        lea.l   (dat_072_03C04).l,a0            ; 00E9C
        movem.w (a0),d0-d5                      ; 00EA2
        sub.w   d0,d3                           ; 00EA6
        sub.w   d1,d4                           ; 00EA8
        sub.w   d2,d5                           ; 00EAA
        movem.w $c(a0),d6-d7                    ; 00EAC
        sub.w   d0,d6                           ; 00EB2
        sub.w   d1,d7                           ; 00EB4
        move.w  $10(a0),d0                      ; 00EB6
        sub.w   d2,d0                           ; 00EBA
        move.w  a3,d1                           ; 00EBC
        asr.w   #$7,d1                          ; 00EBE
        andi.w  #$7,d1                          ; 00EC0
        beq.b   l_010_00ED2                     ; 00EC4
        asl.w   d1,d3                           ; 00EC6
        asl.w   d1,d4                           ; 00EC8
        asl.w   d1,d5                           ; 00ECA
        asl.w   d1,d6                           ; 00ECC
        asl.w   d1,d7                           ; 00ECE
        asl.w   d1,d0                           ; 00ED0
l_010_00ED2:
        move.w  d5,d1                           ; 00ED2
        move.w  d0,d2                           ; 00ED4
        muls.w  d4,d0                           ; 00ED6
        muls.w  d7,d5                           ; 00ED8
        sub.l   d5,d0                           ; 00EDA
        asr.l   #$8,d0                          ; 00EDC
        muls.w  d3,d2                           ; 00EDE
        muls.w  d6,d1                           ; 00EE0
        sub.l   d2,d1                           ; 00EE2
        asr.l   #$8,d1                          ; 00EE4
        muls.w  d3,d7                           ; 00EE6
        muls.w  d4,d6                           ; 00EE8
        sub.l   d6,d7                           ; 00EEA
        asr.l   #$8,d7                          ; 00EEC
        muls.w  (a0)+,d0                        ; 00EEE
        muls.w  (a0)+,d1                        ; 00EF0
        muls.w  (a0),d7                         ; 00EF2
        add.l   d0,d7                           ; 00EF4
        add.l   d1,d7                           ; 00EF6
        blt.b   l_010_00EFE                     ; 00EF8
        moveq   #$1,d7                          ; 00EFA
        rts                                     ; 00EFC
l_010_00EFE:
        clr.w   d7                              ; 00EFE
        rts                                     ; 00F00
l_010_00F02:
        move.w  -$4(a2),d0                      ; 00F02
        andi.w  #$3fff,d0                       ; 00F06

;-------------------------------------------------------------------------------
; AxisPlaneTest - The side test against one coordinate of the model (the flags' bits 10-11 pick
; which).
;-------------------------------------------------------------------------------
AxisPlaneTest:
        movea.l (CurrentShape).l,a0             ; 00F0A
        move.w  d7,d1                           ; 00F10
        andi.w  #$c00,d7                        ; 00F12
        asr.w   #$8,d7                          ; 00F16
        asr.w   #$2,d7                          ; 00F18
        subq.w  #$1,d7                          ; 00F1A
        beq.b   l_010_00F76                     ; 00F1C
        subq.w  #$1,d7                          ; 00F1E
        beq.b   l_010_00F4C                     ; 00F20
        move.b  $6(a0),d5                       ; 00F22
        andi.w  #$f,d5                          ; 00F26
        move.w  $e(a0,d0.w),d2                  ; 00F2A
        asr.w   d5,d2                           ; 00F2E
        move.w  (ViewOffsetZ8).l,d7             ; 00F30
        neg.w   d7                              ; 00F36
        move.w  (ObjectViewPosZ).l,d6           ; 00F38
        move.w  (DistanceShift).l,d5            ; 00F3E
        asl.w   d5,d6                           ; 00F44
        add.w   d6,d2                           ; 00F46
        cmp.w   d2,d7                           ; 00F48
        bra.b   l_010_00F90                     ; 00F4A
l_010_00F4C:
        move.b  $6(a0),d5                       ; 00F4C
        andi.w  #$f,d5                          ; 00F50
        move.w  $a(a0,d0.w),d2                  ; 00F54
        asr.w   d5,d2                           ; 00F58
        move.w  (ViewOffsetX8).l,d7             ; 00F5A
        neg.w   d7                              ; 00F60
        move.w  (ObjectViewPos).l,d6            ; 00F62
        move.w  (DistanceShift).l,d5            ; 00F68
        asl.w   d5,d6                           ; 00F6E
        add.w   d6,d2                           ; 00F70
        cmp.w   d2,d7                           ; 00F72
        bra.b   l_010_00F90                     ; 00F74
l_010_00F76:
        move.b  $6(a0),d5                       ; 00F76
        andi.w  #$f,d5                          ; 00F7A
        move.w  $c(a0,d0.w),d2                  ; 00F7E
        asr.w   d5,d2                           ; 00F82
        move.l  (ViewOffsetY8).l,d7             ; 00F84
        neg.l   d7                              ; 00F8A
        ext.l   d2                              ; 00F8C
        cmp.l   d2,d7                           ; 00F8E
l_010_00F90:
        blt.b   l_010_00F98                     ; 00F90
        btst    #$c,d1                          ; 00F92
        rts                                     ; 00F96
l_010_00F98:
        btst    #$c,d1                          ; 00F98
        bne.b   l_010_00FA2                     ; 00F9C
        moveq   #$1,d7                          ; 00F9E
        rts                                     ; 00FA0
l_010_00FA2:
        clr.w   d7                              ; 00FA2
        rts                                     ; 00FA4
	dc.b	$00,$00
h010_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    1,10                            ; 1 longs pointing into hunk 10
	dc.l	$A3E
        dc.l    102,71                          ; 102 longs pointing into hunk 71
	dc.l	$328,$320,$334,$3A,$2CA,$372,$3A8,$B22
	dc.l	$F8,$172,$F0,$5D0,$444,$55E,$734,$876
	dc.l	$8D4,$D62,$382,$3D4,$4EA,$C8A,$480,$4A6
	dc.l	$4A0,$4AE,$296,$28E,$84,$118,$200,$23E
	dc.l	$25C,$2FE,$630,$B96,$BBE,$C1E,$E66,$F40
	dc.l	$F6A,$E6,$64,$6E,$18,$B10,$B1A,$20
	dc.l	$30,$2A,$2D0,$378,$3AE,$488,$B28,$18E
	dc.l	$4E,$54,$5E,$96,$A6,$B8,$C6,$10E
	dc.l	$1DA,$9D2,$1D4,$C70,$F0C,$350,$74A,$D78
	dc.l	$750,$34A,$744,$C9E,$D72,$35A,$E78,$F3A
	dc.l	$E72,$F64,$F32,$F5C,$7E,$270,$618,$F86
	dc.l	$A,$1FA,$B74,$B60,$9C6,$9CC,$5A0,$BE4
	dc.l	$15C,$17A,$19C,$27A,$1B0,$1B8
        dc.l    1,73                            ; 1 longs pointing into hunk 73
	dc.l	$182
        dc.l    7,72                            ; 7 longs pointing into hunk 72
	dc.l	$84E,$2B8,$A02,$C64,$2B2,$A10,$E9E
        dc.l    1,15                            ; 1 longs pointing into hunk 15
	dc.l	$BA2
        dc.l    1,31                            ; 1 longs pointing into hunk 31
	dc.l	$B9C
        dc.l    2,7                             ; 2 longs pointing into hunk 7
	dc.l	$5A6,$BEA
        dc.l    3,13                            ; 3 longs pointing into hunk 13
	dc.l	$C02,$C4C,$2A6
        dc.l    1,11                            ; 1 longs pointing into hunk 11
	dc.l	$728
        dc.l    1,35                            ; 1 longs pointing into hunk 35
	dc.l	$49A
	dc.l	0
	dc.l	HUNK_END
	endc
