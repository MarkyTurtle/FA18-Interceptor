; F/A-18 Interceptor - hunk 15 (code)
; More of the 3D pipeline, used by hunks 13 and 10 (not worked out yet)
; Included by ../f18_main.s.

;===============================================================================
; Hunk 15: CODE, $77C bytes
;===============================================================================
	CODE_HUNK	h015

;-------------------------------------------------------------------------------
; ShapeBlob - Op $F8: a vertex, a colour and a size: a round blob, its radius the size over the
; distance (at most $7F), plotted by PlotPoint3DBig.
;-------------------------------------------------------------------------------
ShapeBlob:
        lea.l   (VertexBuffer).l,a3             ; 00000
        adda.w  (a2)+,a3                        ; 00006
        move.w  (a2)+,(DrawColour).l            ; 00008
        move.w  (a2)+,d6                        ; 0000E
        movem.l a1-a2/a5,-(a7)                  ; 00010
        bsr.w   DrawBlob                        ; 00014
        movem.l (a7)+,a1-a2/a5                  ; 00018
        rts                                     ; 0001C

;-------------------------------------------------------------------------------
; ShapeBlobList - Op $11C: a list of ShapeBlob entries.
;-------------------------------------------------------------------------------
ShapeBlobList:
        movem.l a1/a5,-(a7)                     ; 0001E
        clr.w   -$7e(a6)                        ; 00022
        clr.w   -$6e(a6)                        ; 00026
l_015_0002A:
        tst.w   -$6e(a6)                        ; 0002A
        bne.b   l_015_00058                     ; 0002E
        lea.l   (VertexBuffer).l,a3             ; 00030
        adda.w  (a2)+,a3                        ; 00036
        move.w  (a2)+,(DrawColour).l            ; 00038
        move.w  (a2)+,d6                        ; 0003E
        bge.b   l_015_0004A                     ; 00040
        addq.w  #$1,-$6e(a6)                    ; 00042
        andi.w  #$7fff,d6                       ; 00046
l_015_0004A:
        move.l  a2,-(a7)                        ; 0004A
        bsr.w   DrawBlob                        ; 0004C
        or.w    d0,-$7e(a6)                     ; 00050
        movea.l (a7)+,a2                        ; 00054
        bra.b   l_015_0002A                     ; 00056
l_015_00058:
        movem.l (a7)+,a1/a5                     ; 00058
        move.w  -$7e(a6),d0                     ; 0005C
        rts                                     ; 00060

;-------------------------------------------------------------------------------
; DrawBlob - Draws a round blob at the vertex a3 (scaled by -8(a6)), its size by the distance
; (ShapeBlob, ShapeBlobList).
;-------------------------------------------------------------------------------
DrawBlob:
        movem.w (a3),d3-d5                      ; 00062
        move.w  -$8(a6),d0                      ; 00066
        asl.w   d0,d3                           ; 0006A
        asl.w   d0,d4                           ; 0006C
        asl.w   d0,d5                           ; 0006E
        movem.w d3-d6,-(a7)                     ; 00070
        move.w  d3,d0                           ; 00074
        bge.b   l_015_0007A                     ; 00076
        neg.w   d0                              ; 00078
l_015_0007A:
        move.w  d4,d1                           ; 0007A
        bge.b   l_015_00080                     ; 0007C
        neg.w   d1                              ; 0007E
l_015_00080:
        move.w  d5,d2                           ; 00080
        bge.b   l_015_00086                     ; 00082
        neg.w   d2                              ; 00084
l_015_00086:
        move.w  d2,d4                           ; 00086
        move.w  d1,d3                           ; 00088
        move.w  d0,d2                           ; 0008A
        jsr     (VectorLength).l                ; 0008C
        move.w  d1,d7                           ; 00092
        movem.w (a7)+,d0-d2/d6                  ; 00094
        tst.w   d7                              ; 00098
        ble.b   l_015_000A4                     ; 0009A
        divu.w  d7,d6                           ; 0009C
        cmpi.w  #$7f,d6                         ; 0009E
        ble.b   l_015_000A8                     ; 000A2
l_015_000A4:
        move.w  #$7f,d6                         ; 000A4
l_015_000A8:
        jsr     (PlotPoint3DBig).l              ; 000A8
        rts                                     ; 000AE
l_015_000B0:
        moveq   #$0,d0                          ; 000B0
        rts                                     ; 000B2

;-------------------------------------------------------------------------------
; DrawObjectFlame - For the object FlameObject: draws a blob behind it (the engine's flame or
; a missile's smoke), its size and colour changing.
;-------------------------------------------------------------------------------
DrawObjectFlame:
        move.w  (CurrentObjectOffset).l,d0      ; 000B4
        cmp.w   (FlameObject).l,d0              ; 000BA
        bne.b   l_015_000B0                     ; 000C0
        link.w  a6,#$ffd2                       ; 000C2
        move.w  #$ffff,-$26(a6)                 ; 000C6
        clr.w   -$1e(a6)                        ; 000CC
        lea.l   (ObjectTable).l,a1              ; 000D0
        adda.w  d0,a1                           ; 000D6
        clr.b   d0                              ; 000D8
        cmpi.b  #$6,(FlameStep).l               ; 000DA
        blt.b   l_015_000EA                     ; 000E2
        move.b  (FlameStep2).l,d0               ; 000E4
l_015_000EA:
        move.b  d0,-$20(a6)                     ; 000EA
        move.b  $3d(a1),-$a(a6)                 ; 000EE
        ble.w   l_015_00394                     ; 000F4
        cmpi.b  #$6,(FlameStep).l               ; 000F8
        bge.b   l_015_00106                     ; 00100
        subq.b  #$1,-$a(a6)                     ; 00102
l_015_00106:
        movem.l $3e(a1),d0-d2                   ; 00106
        movem.l $14(a1),d3-d5                   ; 0010C
        sub.l   (EyeX).l,d3                     ; 00112
        sub.l   (EyeY).l,d4                     ; 00118
        sub.l   (EyeZ).l,d5                     ; 0011E
        cmpi.w  #$100,$6e(a1)                   ; 00124
        blt.b   l_015_00132                     ; 0012A
        asr.l   #$8,d0                          ; 0012C
        asr.l   #$8,d1                          ; 0012E
        asr.l   #$8,d2                          ; 00130
l_015_00132:
        asr.l   #$8,d3                          ; 00132
        asr.l   #$8,d4                          ; 00134
        asr.l   #$8,d5                          ; 00136
        muls.w  d3,d0                           ; 00138
        muls.w  d4,d1                           ; 0013A
        muls.w  d5,d2                           ; 0013C
        add.l   d0,d2                           ; 0013E
        add.l   d1,d2                           ; 00140
        blt.b   l_015_00172                     ; 00142
        clr.w   -$22(a6)                        ; 00144
        move.b  (FlameStep2).l,d0               ; 00148
        sub.b   (FlameStep).l,d0                ; 0014E
        cmpi.b  #$6,(FlameStep).l               ; 00154
        bge.b   l_015_00160                     ; 0015C
        subq.b  #$1,d0                          ; 0015E
l_015_00160:
        add.b   $3d(a1),d0                      ; 00160
        bge.b   l_015_0016C                     ; 00164
        add.b   (FlameStep).l,d0                ; 00166
l_015_0016C:
        move.b  d0,-$20(a6)                     ; 0016C
        bra.b   l_015_00178                     ; 00170
l_015_00172:
        move.w  #$ffff,-$22(a6)                 ; 00172
l_015_00178:
        lea.l   (ObjectTable).l,a1              ; 00178
        adda.w  (CurrentObjectOffset).l,a1      ; 0017E
        move.b  -$20(a6),d0                     ; 00184
        ext.w   d0                              ; 00188
        add.w   d0,d0                           ; 0018A
        add.w   d0,d0                           ; 0018C
        move.w  d0,d3                           ; 0018E
        add.w   d0,d0                           ; 00190
        add.w   d3,d0                           ; 00192
        lea.l   (FlamePoints).l,a3              ; 00194
        adda.w  d0,a3                           ; 0019A
        movem.l (a3),d3-d5                      ; 0019C
        sub.l   (EyeX).l,d3                     ; 001A0
        sub.l   (EyeY).l,d4                     ; 001A6
        sub.l   (EyeZ).l,d5                     ; 001AC
        moveq   #$0,d7                          ; 001B2
        move.l  d3,d0                           ; 001B4
        bge.b   l_015_001BA                     ; 001B6
        neg.l   d0                              ; 001B8
l_015_001BA:
        move.l  d4,d1                           ; 001BA
        bge.b   l_015_001C0                     ; 001BC
        neg.l   d1                              ; 001BE
l_015_001C0:
        move.l  d5,d2                           ; 001C0
        bge.b   l_015_001C6                     ; 001C2
        neg.l   d2                              ; 001C4
l_015_001C6:
        move.l  #$4000,d6                       ; 001C6
        cmp.l   d6,d0                           ; 001CC
        bgt.b   l_015_001D8                     ; 001CE
        cmp.l   d6,d1                           ; 001D0
        bgt.b   l_015_001D8                     ; 001D2
        cmp.l   d6,d2                           ; 001D4
        ble.b   l_015_001FA                     ; 001D6
l_015_001D8:
        moveq   #$8,d7                          ; 001D8
        move.l  #$40000,d6                      ; 001DA
        cmp.l   d6,d0                           ; 001E0
        bgt.b   l_015_001EE                     ; 001E2
        cmp.l   d6,d1                           ; 001E4
        bgt.b   l_015_001EE                     ; 001E6
        cmp.l   d6,d2                           ; 001E8
        bgt.b   l_015_001EE                     ; 001EA
        moveq   #$4,d7                          ; 001EC
l_015_001EE:
        asr.l   d7,d3                           ; 001EE
        asr.l   d7,d4                           ; 001F0
        asr.l   d7,d5                           ; 001F2
        asr.l   d7,d0                           ; 001F4
        asr.l   d7,d1                           ; 001F6
        asr.l   d7,d2                           ; 001F8
l_015_001FA:
        btst    #$0,-$20(a6)                    ; 001FA
        beq.b   l_015_0021E                     ; 00200
        btst    #$1,$20(a1)                     ; 00202
        bne.b   l_015_00214                     ; 00208
        move.w  #$8,(DrawColour).l              ; 0020A
        bra.b   l_015_00238                     ; 00212
l_015_00214:
        move.w  #$3,(DrawColour).l              ; 00214
        bra.b   l_015_00238                     ; 0021C
l_015_0021E:
        btst    #$1,$20(a1)                     ; 0021E
        bne.b   l_015_00230                     ; 00224
        move.w  #$a,(DrawColour).l              ; 00226
        bra.b   l_015_00238                     ; 0022E
l_015_00230:
        move.w  #$c,(DrawColour).l              ; 00230
l_015_00238:
        move.w  #$9c0,d6                        ; 00238
        movem.w d3-d6,-(a7)                     ; 0023C
        move.w  d2,d4                           ; 00240
        move.w  d1,d3                           ; 00242
        move.w  d0,d2                           ; 00244
        jsr     (VectorLength).l                ; 00246
        movem.w (a7)+,d3-d6                     ; 0024C
        moveq   #$8,d0                          ; 00250
        sub.w   d7,d0                           ; 00252
        movea.w d7,a3                           ; 00254
        asr.w   d0,d1                           ; 00256
        move.w  d1,d7                           ; 00258
        move.w  d6,-(a7)                        ; 0025A
        jsr     (TurnToView).l                  ; 0025C
        move.w  d6,d0                           ; 00262
        move.w  d2,d1                           ; 00264
        move.w  d5,d2                           ; 00266
        move.w  (a7)+,d6                        ; 00268
        ext.l   d6                              ; 0026A
        tst.w   d7                              ; 0026C
        ble.b   l_015_00278                     ; 0026E
        divu.w  d7,d6                           ; 00270
        cmpi.w  #$7f,d6                         ; 00272
        ble.b   l_015_0027C                     ; 00276
l_015_00278:
        move.w  #$7f,d6                         ; 00278
l_015_0027C:
        tst.w   -$26(a6)                        ; 0027C
        blt.w   l_015_00340                     ; 00280
        cmpi.b  #$1,$3d(a1)                     ; 00284
        ble.w   l_015_00340                     ; 0028A
        movem.w d0-d2/d6/a3,-(a7)               ; 0028E
        movem.w -$2c(a6),d3-d5/d7/a4            ; 00292
        swap    d0                              ; 00298
        suba.w  a3,a4                           ; 0029A
        move.w  a4,d0                           ; 0029C
        asl.w   d0,d3                           ; 0029E
        asl.w   d0,d4                           ; 002A0
        asl.w   d0,d5                           ; 002A2
        swap    d0                              ; 002A4
        sub.w   d3,d0                           ; 002A6
        sub.w   d4,d1                           ; 002A8
        sub.w   d5,d2                           ; 002AA
        sub.w   d7,d6                           ; 002AC
        asr.w   #$2,d0                          ; 002AE
        asr.w   #$2,d1                          ; 002B0
        asr.w   #$2,d2                          ; 002B2
        asr.w   #$2,d6                          ; 002B4
        add.w   d3,d0                           ; 002B6
        add.w   d4,d1                           ; 002B8
        add.w   d5,d2                           ; 002BA
        add.w   d7,d6                           ; 002BC
        jsr     (PlotPoint3DBig).l              ; 002BE
        or.w    d0,-$1e(a6)                     ; 002C4
        movem.w (a7),d0-d2/d6/a3                ; 002C8
        movem.w -$2c(a6),d3-d5/d7/a4            ; 002CC
        swap    d0                              ; 002D2
        suba.w  a3,a4                           ; 002D4
        move.w  a4,d0                           ; 002D6
        asl.w   d0,d3                           ; 002D8
        asl.w   d0,d4                           ; 002DA
        asl.w   d0,d5                           ; 002DC
        swap    d0                              ; 002DE
        sub.w   d3,d0                           ; 002E0
        sub.w   d4,d1                           ; 002E2
        sub.w   d5,d2                           ; 002E4
        sub.w   d7,d6                           ; 002E6
        asr.w   #$1,d0                          ; 002E8
        asr.w   #$1,d1                          ; 002EA
        asr.w   #$1,d2                          ; 002EC
        asr.w   #$1,d6                          ; 002EE
        add.w   d3,d0                           ; 002F0
        add.w   d4,d1                           ; 002F2
        add.w   d5,d2                           ; 002F4
        add.w   d7,d6                           ; 002F6
        jsr     (PlotPoint3DBig).l              ; 002F8
        or.w    d0,-$1e(a6)                     ; 002FE
        movem.w (a7),d0-d2/d6/a3                ; 00302
        movem.w -$2c(a6),d3-d5/d7/a4            ; 00306
        swap    d0                              ; 0030C
        suba.w  a3,a4                           ; 0030E
        move.w  a4,d0                           ; 00310
        asl.w   d0,d3                           ; 00312
        asl.w   d0,d4                           ; 00314
        asl.w   d0,d5                           ; 00316
        swap    d0                              ; 00318
        sub.w   d0,d3                           ; 0031A
        sub.w   d1,d4                           ; 0031C
        sub.w   d2,d5                           ; 0031E
        sub.w   d6,d7                           ; 00320
        asr.w   #$2,d3                          ; 00322
        asr.w   #$2,d4                          ; 00324
        asr.w   #$2,d5                          ; 00326
        asr.w   #$2,d7                          ; 00328
        add.w   d3,d0                           ; 0032A
        add.w   d4,d1                           ; 0032C
        add.w   d5,d2                           ; 0032E
        add.w   d7,d6                           ; 00330
        jsr     (PlotPoint3DBig).l              ; 00332
        or.w    d0,-$1e(a6)                     ; 00338
        movem.w (a7)+,d0-d2/d6/a3               ; 0033C
l_015_00340:
        movem.w d0-d2/d6/a3,-$2c(a6)            ; 00340
        tst.b   -$a(a6)                         ; 00346
        bgt.b   l_015_00352                     ; 0034A
        move.w  d6,d7                           ; 0034C
        asr.w   #$3,d7                          ; 0034E
        sub.w   d7,d6                           ; 00350
l_015_00352:
        jsr     (PlotPoint3DBig).l              ; 00352
        or.w    d0,-$1e(a6)                     ; 00358
        tst.w   -$22(a6)                        ; 0035C
        blt.b   l_015_00376                     ; 00360
        subq.b  #$1,-$20(a6)                    ; 00362
        bge.b   l_015_0038C                     ; 00366
        move.b  (FlameStep).l,d0                ; 00368
        subq.b  #$1,d0                          ; 0036E
        move.b  d0,-$20(a6)                     ; 00370
        bra.b   l_015_0038C                     ; 00374
l_015_00376:
        addq.b  #$1,-$20(a6)                    ; 00376
        move.b  (FlameStep).l,d0                ; 0037A
        subq.b  #$1,d0                          ; 00380
        cmp.b   -$20(a6),d0                     ; 00382
        bge.b   l_015_0038C                     ; 00386
        clr.b   -$20(a6)                        ; 00388
l_015_0038C:
        subq.b  #$1,-$a(a6)                     ; 0038C
        bge.w   l_015_00178                     ; 00390
l_015_00394:
        move.w  -$1e(a6),d0                     ; 00394
        unlk    a6                              ; 00398
        rts                                     ; 0039A

;-------------------------------------------------------------------------------
; MakeVerticesFA18 - Ops $EC-$F4: computes the F/A-18 model's extra vertices (as
; MakeVerticesF16).
;-------------------------------------------------------------------------------
MakeVerticesFA18:
        lea.l   (ObjectTable).l,a3              ; 0039C
        move.w  (CurrentObjectOffset).l,d0      ; 003A2
        addi.w  #$a4,d0                         ; 003A8
        adda.w  d0,a3                           ; 003AC
        bsr.w   FA18Midpoints                   ; 003AE
        lea.l   (VertexBuffer).l,a3             ; 003B2
        adda.w  (a2)+,a3                        ; 003B8
        bsr.w   FA18Midpoints                   ; 003BA
        movem.w $6c(a3),d0-d5                   ; 003BE
        add.w   d0,d3                           ; 003C4
        add.w   d1,d4                           ; 003C6
        add.w   d2,d5                           ; 003C8
        asr.w   #$1,d3                          ; 003CA
        asr.w   #$1,d4                          ; 003CC
        asr.w   #$1,d5                          ; 003CE
        movem.w $60(a3),d0-d2                   ; 003D0
        add.w   d0,d3                           ; 003D6
        add.w   d1,d4                           ; 003D8
        add.w   d2,d5                           ; 003DA
        asr.w   #$1,d3                          ; 003DC
        asr.w   #$1,d4                          ; 003DE
        asr.w   #$1,d5                          ; 003E0
        movem.w d3-d5,$294(a3)                  ; 003E2
        moveq   #$0,d0                          ; 003E8
        rts                                     ; 003EA

;-------------------------------------------------------------------------------
; FA18Midpoints - Part of MakeVerticesFA18: midpoints of edges, into +$84.
;-------------------------------------------------------------------------------
FA18Midpoints:
        movem.w $12(a3),d0-d5                   ; 003EC
        add.w   d0,d3                           ; 003F2
        add.w   d1,d4                           ; 003F4
        add.w   d2,d5                           ; 003F6
        asr.w   #$1,d3                          ; 003F8
        asr.w   #$1,d4                          ; 003FA
        asr.w   #$1,d5                          ; 003FC
        movem.w d3-d5,$84(a3)                   ; 003FE
        movem.w $36(a3),d0-d2                   ; 00404
        move.w  d0,d6                           ; 0040A
        move.w  d1,d7                           ; 0040C
        movea.w d2,a4                           ; 0040E
        sub.w   d3,d0                           ; 00410
        sub.w   d4,d1                           ; 00412
        sub.w   d5,d2                           ; 00414
        sub.w   d0,d3                           ; 00416
        sub.w   d1,d4                           ; 00418
        sub.w   d2,d5                           ; 0041A
        movem.w d3-d5,$8a(a3)                   ; 0041C
        movem.w $30(a3),d0-d2                   ; 00422
        sub.w   d0,d6                           ; 00428
        sub.w   d1,d7                           ; 0042A
        suba.w  d2,a4                           ; 0042C
        add.w   d3,d6                           ; 0042E
        add.w   d4,d7                           ; 00430
        adda.w  d5,a4                           ; 00432
        movem.w d6-d7/a4,$90(a3)                ; 00434
        movem.w $12(a3),d0-d7/a4                ; 0043A
        sub.w   d0,d6                           ; 00440
        sub.w   d1,d7                           ; 00442
        suba.w  d2,a4                           ; 00444
        add.w   d6,d3                           ; 00446
        add.w   d7,d4                           ; 00448
        add.w   a4,d5                           ; 0044A
        movem.w d3-d5,$96(a3)                   ; 0044C
        movem.w $8a(a3),d0-d5                   ; 00452
        add.w   d6,d0                           ; 00458
        add.w   d7,d1                           ; 0045A
        add.w   a4,d2                           ; 0045C
        add.w   d6,d3                           ; 0045E
        add.w   d7,d4                           ; 00460
        add.w   a4,d5                           ; 00462
        movem.w d0-d5,$e4(a3)                   ; 00464
        add.w   d0,d3                           ; 0046A
        add.w   d1,d4                           ; 0046C
        add.w   d2,d5                           ; 0046E
        asr.w   #$1,d3                          ; 00470
        asr.w   #$1,d4                          ; 00472
        asr.w   #$1,d5                          ; 00474
        movem.w d3-d5,$a8(a3)                   ; 00476
        movem.w $1e(a3),d0-d2                   ; 0047C
        movem.w $96(a3),d3-d5                   ; 00482
        move.w  d3,d6                           ; 00488
        move.w  d4,d7                           ; 0048A
        movea.w d5,a4                           ; 0048C
        add.w   d0,d3                           ; 0048E
        add.w   d1,d4                           ; 00490
        add.w   d2,d5                           ; 00492
        asr.w   #$1,d3                          ; 00494
        asr.w   #$1,d4                          ; 00496
        asr.w   #$1,d5                          ; 00498
        add.w   d3,d0                           ; 0049A
        add.w   d4,d1                           ; 0049C
        add.w   d5,d2                           ; 0049E
        asr.w   #$1,d0                          ; 004A0
        asr.w   #$1,d1                          ; 004A2
        asr.w   #$1,d2                          ; 004A4
        add.w   d6,d3                           ; 004A6
        add.w   d7,d4                           ; 004A8
        add.w   a4,d5                           ; 004AA
        asr.w   #$1,d3                          ; 004AC
        asr.w   #$1,d4                          ; 004AE
        asr.w   #$1,d5                          ; 004B0
        movem.w d0-d5,$9c(a3)                   ; 004B2
        movem.w $6(a3),d0-d5                    ; 004B8
        add.w   d0,d3                           ; 004BE
        add.w   d1,d4                           ; 004C0
        add.w   d2,d5                           ; 004C2
        asr.w   #$1,d3                          ; 004C4
        asr.w   #$1,d4                          ; 004C6
        asr.w   #$1,d5                          ; 004C8
        movem.w d3-d5,$ae(a3)                   ; 004CA
        movem.w $24(a3),d0-d5                   ; 004D0
        movem.w $3c(a3),d6-d7/a4                ; 004D6
        sub.w   d3,d0                           ; 004DC
        sub.w   d4,d1                           ; 004DE
        sub.w   d5,d2                           ; 004E0
        add.w   d0,d6                           ; 004E2
        add.w   d1,d7                           ; 004E4
        adda.w  d2,a4                           ; 004E6
        movem.w d6-d7/a4,$7e(a3)                ; 004E8
        movem.w $48(a3),d3-d5                   ; 004EE
        add.w   d0,d3                           ; 004F4
        add.w   d1,d4                           ; 004F6
        add.w   d2,d5                           ; 004F8
        movem.w $54(a3),d6-d7/a4                ; 004FA
        add.w   d0,d6                           ; 00500
        add.w   d1,d7                           ; 00502
        adda.w  d2,a4                           ; 00504
        movem.w d3-d7/a4,$b4(a3)                ; 00506
        move.w  d0,d3                           ; 0050C
        move.w  d1,d4                           ; 0050E
        move.w  d2,d5                           ; 00510
        asr.w   #$1,d0                          ; 00512
        asr.w   #$1,d1                          ; 00514
        asr.w   #$1,d2                          ; 00516
        add.w   d0,d3                           ; 00518
        add.w   d1,d4                           ; 0051A
        add.w   d2,d5                           ; 0051C
        movem.w $6(a3),d0-d2/d6-d7/a4           ; 0051E
        add.w   d3,d0                           ; 00524
        add.w   d4,d1                           ; 00526
        add.w   d5,d2                           ; 00528
        add.w   d3,d6                           ; 0052A
        add.w   d4,d7                           ; 0052C
        adda.w  d5,a4                           ; 0052E
        movem.w d0-d2/d6-d7/a4,$c0(a3)          ; 00530
        movem.w $24(a3),d0-d2/d6-d7/a4          ; 00536
        sub.w   d6,d0                           ; 0053C
        sub.w   d7,d1                           ; 0053E
        sub.w   a4,d2                           ; 00540
        movem.w $c0(a3),d6-d7/a4                ; 00542
        add.w   d0,d6                           ; 00548
        add.w   d1,d7                           ; 0054A
        adda.w  d2,a4                           ; 0054C
        movem.w d6-d7/a4,$d8(a3)                ; 0054E
        movem.w $c6(a3),d6-d7/a4                ; 00554
        add.w   d0,d6                           ; 0055A
        add.w   d1,d7                           ; 0055C
        adda.w  d2,a4                           ; 0055E
        movem.w d6-d7/a4,$de(a3)                ; 00560
        add.w   d0,d3                           ; 00566
        add.w   d1,d4                           ; 00568
        add.w   d2,d5                           ; 0056A
        movem.w $42(a3),d0-d2                   ; 0056C
        add.w   d3,d0                           ; 00572
        add.w   d4,d1                           ; 00574
        add.w   d5,d2                           ; 00576
        movem.w $4e(a3),d6-d7/a4                ; 00578
        add.w   d3,d6                           ; 0057E
        add.w   d4,d7                           ; 00580
        adda.w  d5,a4                           ; 00582
        movem.w d0-d2/d6-d7/a4,$cc(a3)          ; 00584
        rts                                     ; 0058A

;-------------------------------------------------------------------------------
; MakeVerticesFA18Both - An F/A-18 vertex builder for the object's own vertices and then
; VertexBuffer.
;-------------------------------------------------------------------------------
MakeVerticesFA18Both:
        lea.l   (ObjectTable).l,a3              ; 0058C
        move.w  (CurrentObjectOffset).l,d0      ; 00592
        addi.w  #$a4,d0                         ; 00598
        adda.w  d0,a3                           ; 0059C
        bsr.w   FA18MovedVertices               ; 0059E
        lea.l   (VertexBuffer).l,a3             ; 005A2

;-------------------------------------------------------------------------------
; FA18MovedVertices - Moves F/A-18 vertices by the difference of two others.
;-------------------------------------------------------------------------------
FA18MovedVertices:
        movem.w $18(a3),d0-d2                   ; 005A8
        movem.w $2a(a3),d3-d7/a4                ; 005AE
        sub.w   d0,d3                           ; 005B4
        sub.w   d1,d4                           ; 005B6
        sub.w   d2,d5                           ; 005B8
        sub.w   d3,d0                           ; 005BA
        sub.w   d4,d1                           ; 005BC
        sub.w   d5,d2                           ; 005BE
        movem.w d0-d2,$5a(a3)                   ; 005C0
        add.w   d3,d0                           ; 005C6
        add.w   d4,d1                           ; 005C8
        add.w   d5,d2                           ; 005CA
        sub.w   d0,d6                           ; 005CC
        sub.w   d1,d7                           ; 005CE
        suba.w  d2,a4                           ; 005D0
        sub.w   d6,d0                           ; 005D2
        sub.w   d7,d1                           ; 005D4
        sub.w   a4,d2                           ; 005D6
        movem.w d0-d2,$60(a3)                   ; 005D8
        add.w   d6,d0                           ; 005DE
        add.w   d7,d1                           ; 005E0
        add.w   a4,d2                           ; 005E2
        movem.w $36(a3),d3-d7/a4                ; 005E4
        sub.w   d0,d3                           ; 005EA
        sub.w   d1,d4                           ; 005EC
        sub.w   d2,d5                           ; 005EE
        sub.w   d3,d0                           ; 005F0
        sub.w   d4,d1                           ; 005F2
        sub.w   d5,d2                           ; 005F4
        movem.w d0-d2,$66(a3)                   ; 005F6
        add.w   d3,d0                           ; 005FC
        add.w   d4,d1                           ; 005FE
        add.w   d5,d2                           ; 00600
        sub.w   d0,d6                           ; 00602
        sub.w   d1,d7                           ; 00604
        suba.w  d2,a4                           ; 00606
        sub.w   d6,d0                           ; 00608
        sub.w   d7,d1                           ; 0060A
        sub.w   a4,d2                           ; 0060C
        movem.w d0-d2,$6c(a3)                   ; 0060E
        movem.w $12(a3),d0-d2                   ; 00614
        movem.w $42(a3),d3-d7/a4                ; 0061A
        sub.w   d0,d3                           ; 00620
        sub.w   d1,d4                           ; 00622
        sub.w   d2,d5                           ; 00624
        sub.w   d3,d0                           ; 00626
        sub.w   d4,d1                           ; 00628
        sub.w   d5,d2                           ; 0062A
        movem.w d0-d2,$72(a3)                   ; 0062C
        add.w   d3,d0                           ; 00632
        add.w   d4,d1                           ; 00634
        add.w   d5,d2                           ; 00636
        sub.w   d0,d6                           ; 00638
        sub.w   d1,d7                           ; 0063A
        suba.w  d2,a4                           ; 0063C
        sub.w   d6,d0                           ; 0063E
        sub.w   d7,d1                           ; 00640
        sub.w   a4,d2                           ; 00642
        movem.w d0-d2,$78(a3)                   ; 00644
        add.w   d6,d0                           ; 0064A
        add.w   d7,d1                           ; 0064C
        add.w   a4,d2                           ; 0064E
        movem.w $4e(a3),d3-d7/a4                ; 00650
        sub.w   d0,d3                           ; 00656
        sub.w   d1,d4                           ; 00658
        sub.w   d2,d5                           ; 0065A
        sub.w   d3,d0                           ; 0065C
        sub.w   d4,d1                           ; 0065E
        sub.w   d5,d2                           ; 00660
        movem.w d0-d2,$7e(a3)                   ; 00662
        add.w   d3,d0                           ; 00668
        add.w   d4,d1                           ; 0066A
        add.w   d5,d2                           ; 0066C
        sub.w   d0,d6                           ; 0066E
        sub.w   d1,d7                           ; 00670
        suba.w  d2,a4                           ; 00672
        sub.w   d6,d0                           ; 00674
        sub.w   d7,d1                           ; 00676
        sub.w   a4,d2                           ; 00678
        movem.w d0-d2,$84(a3)                   ; 0067A
        moveq   #$0,d0                          ; 00680
        rts                                     ; 00682

;-------------------------------------------------------------------------------
; MakeVerticesBoth8A - A vertex builder (into +$8A) for the object's own vertices and then
; VertexBuffer.
;-------------------------------------------------------------------------------
MakeVerticesBoth8A:
        lea.l   (ObjectTable).l,a3              ; 00684
        move.w  (CurrentObjectOffset).l,d0      ; 0068A
        addi.w  #$a4,d0                         ; 00690
        adda.w  d0,a3                           ; 00694
        bsr.w   MovedVertex8A                   ; 00696
        lea.l   (VertexBuffer).l,a3             ; 0069A

;-------------------------------------------------------------------------------
; MovedVertex8A - A vertex moved by an edge's difference, into +$8A.
;-------------------------------------------------------------------------------
MovedVertex8A:
        movem.w (a3),d0-d7/a4                   ; 006A0
        sub.w   d0,d6                           ; 006A4
        sub.w   d1,d7                           ; 006A6
        suba.w  d2,a4                           ; 006A8
        add.w   d6,d3                           ; 006AA
        add.w   d7,d4                           ; 006AC
        add.w   a4,d5                           ; 006AE
        movem.w d3-d5,$8a(a3)                   ; 006B0
        add.w   d0,d3                           ; 006B6
        add.w   d1,d4                           ; 006B8
        add.w   d2,d5                           ; 006BA
        asr.w   #$1,d3                          ; 006BC
        asr.w   #$1,d4                          ; 006BE
        asr.w   #$1,d5                          ; 006C0
        movem.w d3-d5,$90(a3)                   ; 006C2
        sub.w   d0,d3                           ; 006C8
        sub.w   d1,d4                           ; 006CA
        sub.w   d2,d5                           ; 006CC
        asr.w   #$1,d3                          ; 006CE
        asr.w   #$1,d4                          ; 006D0
        asr.w   #$1,d5                          ; 006D2
        sub.w   d3,d0                           ; 006D4
        sub.w   d4,d1                           ; 006D6
        sub.w   d5,d2                           ; 006D8
        movem.w d0-d2,$96(a3)                   ; 006DA
        movem.w $6(a3),d6-d7/a4                 ; 006E0
        movem.w $90(a3),d0-d2                   ; 006E6
        sub.w   d6,d0                           ; 006EC
        sub.w   d7,d1                           ; 006EE
        sub.w   a4,d2                           ; 006F0
        asr.w   #$1,d0                          ; 006F2
        asr.w   #$1,d1                          ; 006F4
        asr.w   #$1,d2                          ; 006F6
        sub.w   d0,d6                           ; 006F8
        sub.w   d1,d7                           ; 006FA
        suba.w  d2,a4                           ; 006FC
        movem.w d6-d7/a4,$a2(a3)                ; 006FE
        sub.w   d3,d6                           ; 00704
        sub.w   d4,d7                           ; 00706
        suba.w  d5,a4                           ; 00708
        movem.w d6-d7/a4,$a8(a3)                ; 0070A
        sub.w   $96(a3),d0                      ; 00710
        sub.w   $98(a3),d1                      ; 00714
        sub.w   $9a(a3),d2                      ; 00718
        neg.w   d0                              ; 0071C
        neg.w   d1                              ; 0071E
        neg.w   d2                              ; 00720
        movem.w d0-d2,$9c(a3)                   ; 00722
        moveq   #$0,d0                          ; 00728
        rts                                     ; 0072A

;-------------------------------------------------------------------------------
; MakeVerticesPod - Op $104: computes the rescue pod model's extra vertices.
;-------------------------------------------------------------------------------
MakeVerticesPod:
        lea.l   (ObjectTable).l,a3              ; 0072C
        move.w  (CurrentObjectOffset).l,d0      ; 00732
        addi.w  #$a4,d0                         ; 00738
        adda.w  d0,a3                           ; 0073C
        bsr.w   PodMovedVertex                  ; 0073E
        lea.l   (VertexBuffer).l,a3             ; 00742

;-------------------------------------------------------------------------------
; PodMovedVertex - Part of MakeVerticesPod: a vertex moved by an edge's difference, into +$8A.
;-------------------------------------------------------------------------------
PodMovedVertex:
        movem.w (a3),d0-d7/a4                   ; 00748
        sub.w   d0,d6                           ; 0074C
        sub.w   d1,d7                           ; 0074E
        suba.w  d2,a4                           ; 00750
        add.w   d6,d3                           ; 00752
        add.w   d7,d4                           ; 00754
        add.w   a4,d5                           ; 00756
        movem.w d3-d5,$8a(a3)                   ; 00758
        movem.w $1e(a3),d3-d5                   ; 0075E
        add.w   d6,d3                           ; 00764
        add.w   d7,d4                           ; 00766
        add.w   a4,d5                           ; 00768
        movem.w d3-d5,$90(a3)                   ; 0076A
        moveq   #$0,d0                          ; 00770
        rts                                     ; 00772

;-------------------------------------------------------------------------------
; ShapeEndList - A shape operation that ends the list (d0 = 0).
;-------------------------------------------------------------------------------
ShapeEndList:
        moveq   #$0,d0                          ; 00774
        rts                                     ; 00776

;-------------------------------------------------------------------------------
; ShapeEndList2 - A shape operation that ends the list (d0 = 0).
;-------------------------------------------------------------------------------
ShapeEndList2:
        moveq   #$0,d0                          ; 00778
        rts                                     ; 0077A
h015_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    24,71                           ; 24 longs pointing into hunk 71
	dc.l	$A,$3A,$20E,$218,$22A,$234,$120,$1AE
	dc.l	$11A,$1A8,$114,$1A2,$B6,$180,$3A4,$594
	dc.l	$68C,$734,$D2,$17A,$39E,$58E,$686,$72E
        dc.l    11,73                           ; 11 longs pointing into hunk 73
	dc.l	$BC,$DE,$FC,$150,$158,$168,$36A,$37C
	dc.l	$196,$E6,$14A
        dc.l    1,31                            ; 1 longs pointing into hunk 31
	dc.l	$25E
        dc.l    2,8                             ; 2 longs pointing into hunk 8
	dc.l	$8E,$248
        dc.l    5,35                            ; 5 longs pointing into hunk 35
	dc.l	$AA,$2C0,$2FA,$334,$354
        dc.l    6,72                            ; 6 longs pointing into hunk 72
	dc.l	$2,$32,$3B4,$5A4,$69C,$744
	dc.l	0
	dc.l	HUNK_END
	endc
