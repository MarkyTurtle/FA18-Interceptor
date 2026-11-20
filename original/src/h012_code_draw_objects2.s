; F/A-18 Interceptor - hunk 12 (code)
; More object drawing routines, called through ObjectDrawTable.
; Included by ../f18_main.s.

;===============================================================================
; Hunk 12: CODE, $710 bytes
;===============================================================================
	CODE_HUNK	h012
l_012_00000:
        moveq   #$0,d0                          ; 00000
        rts                                     ; 00002

;-------------------------------------------------------------------------------
; DrawGroundShape - The draw routine of the flat ground shapes (most of hunks 69 and 70: the
; city's ground, parks and hills, and the roads): only while the shape is at most $380000 below
; the camera (ViewOffsetY). Picks a level of detail by distance (dat_071_00510, scaled by
; RadarScale unless GroundDetail is set), then turns its vertices - x and z only, all at the
; shape's height - by the view matrix into VertexBuffer, and runs its face list through
; ShapeOps (with further vertex groups, sub_012_0020E, as DrawModel's TransformMoreVertices).
;-------------------------------------------------------------------------------
DrawGroundShape:
        cmpi.l  #$ffc80000,(ViewOffsetY).l      ; 00004
        blt.b   l_012_00000                     ; 0000E
        bra.b   l_012_0001E                     ; 00010

;-------------------------------------------------------------------------------
; DrawGroundShapeFar - As DrawGroundShape, to $FF800000.
;-------------------------------------------------------------------------------
DrawGroundShapeFar:
        cmpi.l  #$ff800000,(ViewOffsetY).l      ; 00012
        blt.b   l_012_00000                     ; 0001C
l_012_0001E:
        link.w  a6,#$ff68                       ; 0001E
        move.l  #$fffff,(FillPattern).l         ; 00022
        move.w  (dat_071_00510).l,d2            ; 0002C
        move.w  d2,-$96(a6)                     ; 00032
        tst.b   (GroundDetail).l                ; 00036
        bne.b   l_012_00050                     ; 0003C
        move.w  (RadarScale).l,d3               ; 0003E
        ext.l   d3                              ; 00044
        asl.l   #$8,d3                          ; 00046
        divu.w  #$80,d3                         ; 00048
        mulu.w  d3,d2                           ; 0004C
        asr.l   #$8,d2                          ; 0004E
l_012_00050:
        move.w  d2,-$28(a6)                     ; 00050
l_012_00054:
        movea.l (ShapeNow).l,a2                 ; 00054
        move.w  (a2)+,d0                        ; 0005A
        blt.b   l_012_0007A                     ; 0005C
        move.w  (DistanceShift).l,d1            ; 0005E
        asr.w   d1,d0                           ; 00064
        cmp.w   d2,d0                           ; 00066
        bge.b   l_012_00078                     ; 00068
        move.l  (a2),(ShapeNow).l               ; 0006A
        bge.b   l_012_00054                     ; 00070
l_012_00072:
        moveq   #$0,d0                          ; 00072
        unlk    a6                              ; 00074
        rts                                     ; 00076
l_012_00078:
        addq.w  #$4,a2                          ; 00078
l_012_0007A:
        cmpi.w  #$ffff,d0                       ; 0007A
        beq.b   l_012_00072                     ; 0007E
        movea.l (a2)+,a1                        ; 00080
        move.l  a1,(CurrentShape).l             ; 00082
        move.l  a2,(ShapeNow).l                 ; 00088
        move.w  (ViewOffsetX8).l,d0             ; 0008E
        move.l  (ViewOffsetY).l,d1              ; 00094
        asr.l   #$8,d1                          ; 0009A
        move.w  (ViewOffsetZ8).l,d2             ; 0009C
        move.b  (ObjectDrawFlags).l,d7          ; 000A2
        andi.b  #$f,d7                          ; 000A8
        ext.w   d7                              ; 000AC
        move.w  d7,-$8(a6)                      ; 000AE
        beq.b   l_012_000BA                     ; 000B2
        asr.w   d7,d0                           ; 000B4
        asr.l   d7,d1                           ; 000B6
        asr.w   d7,d2                           ; 000B8
l_012_000BA:
        movem.w d0-d2,-$86(a6)                  ; 000BA
        clr.w   (PolygonBuffer).l               ; 000C0
        lea.l   (VertexBuffer).l,a3             ; 000C6
        lea.l   (ViewMatrix).l,a2               ; 000CC
        lea.l   (a2),a4                         ; 000D2
        move.w  (ObjectViewPos).l,d0            ; 000D4
        move.w  (ObjectViewPosZ).l,d1           ; 000DA
        add.w   -$86(a6),d0                     ; 000E0
        add.w   -$82(a6),d1                     ; 000E4
        lea.l   -$a(a6),a0                      ; 000E8
        move.w  (a1)+,(a0)                      ; 000EC
        addq.w  #$4,a1                          ; 000EE
        move.w  -$84(a6),d2                     ; 000F0
        move.w  d2,d3                           ; 000F4
        move.w  d2,d6                           ; 000F6
        muls.w  $e(a4),d2                       ; 000F8
        asr.l   #$8,d2                          ; 000FC
        movea.w d2,a5                           ; 000FE
        muls.w  $2(a4),d3                       ; 00100
        asr.l   #$8,d3                          ; 00104
        muls.w  $8(a4),d6                       ; 00106
        asr.l   #$8,d6                          ; 0010A
        movem.w d3/d6/a5,-$78(a6)               ; 0010C
l_012_00112:
        move.w  (a1)+,d2                        ; 00112
        move.w  (a1)+,d4                        ; 00114
        move.w  -$8(a6),d7                      ; 00116
        asr.w   d7,d2                           ; 0011A
        asr.w   d7,d4                           ; 0011C
        add.w   d0,d2                           ; 0011E
        add.w   d1,d4                           ; 00120
        lea.l   (a4),a2                         ; 00122
        move.w  d2,d5                           ; 00124
        move.w  d4,d7                           ; 00126
        muls.w  (a2)+,d5                        ; 00128
        addq.w  #$2,a2                          ; 0012A
        muls.w  (a2)+,d7                        ; 0012C
        add.l   d5,d7                           ; 0012E
        asr.l   #$8,d7                          ; 00130
        add.w   d3,d7                           ; 00132
        move.w  d7,(a3)+                        ; 00134
        move.w  d2,d5                           ; 00136
        move.w  d4,d7                           ; 00138
        muls.w  (a2)+,d5                        ; 0013A
        addq.w  #$2,a2                          ; 0013C
        muls.w  (a2)+,d7                        ; 0013E
        add.l   d5,d7                           ; 00140
        asr.l   #$8,d7                          ; 00142
        add.w   d6,d7                           ; 00144
        move.w  d7,(a3)+                        ; 00146
        muls.w  (a2)+,d2                        ; 00148
        muls.w  $2(a2),d4                       ; 0014A
        add.l   d2,d4                           ; 0014E
        asr.l   #$8,d4                          ; 00150
        add.w   a5,d4                           ; 00152
        move.w  d4,(a3)+                        ; 00154
        subq.w  #$1,(a0)                        ; 00156
        bgt.b   l_012_00112                     ; 00158
        clr.w   -$7c(a6)                        ; 0015A
        movea.l (ShapeNow).l,a2                 ; 0015E
        clr.w   -$6a(a6)                        ; 00164
l_012_00168:
        tst.w   -$6a(a6)                        ; 00168
        bne.b   l_012_0019E                     ; 0016C
        move.w  (a2)+,d0                        ; 0016E
        bge.b   l_012_001C0                     ; 00170
        cmpi.w  #$ffff,d0                       ; 00172
        beq.b   l_012_0019E                     ; 00176
        move.w  d0,d1                           ; 00178
        andi.w  #$4000,d1                       ; 0017A
        beq.b   l_012_00184                     ; 0017E
        addq.w  #$1,-$6a(a6)                    ; 00180
l_012_00184:
        andi.w  #$3fff,d0                       ; 00184
        lea.l   (ShapeOps).l,a0                 ; 00188
        movea.l (a0,d0.w),a0                    ; 0018E
        jsr     (a0)                            ; 00192
        tst.w   d0                              ; 00194
        blt.b   l_012_001A6                     ; 00196
        or.w    d0,-$7c(a6)                     ; 00198
        bra.b   l_012_00168                     ; 0019C
l_012_0019E:
        move.w  -$7c(a6),d0                     ; 0019E
        unlk    a6                              ; 001A2
        rts                                     ; 001A4
l_012_001A6:
        moveq   #$0,d0                          ; 001A6
        unlk    a6                              ; 001A8
        rts                                     ; 001AA
l_012_001AC:
        move.w  (a2)+,d0                        ; 001AC
        blt.b   l_012_0019E                     ; 001AE
        move.w  (DistanceShift).l,d1            ; 001B0
        asr.w   d1,d0                           ; 001B6
        cmp.w   -$28(a6),d0                     ; 001B8
        blt.b   l_012_0019E                     ; 001BC
        movea.l (a2),a2                         ; 001BE
l_012_001C0:
        cmpi.w  #$7fff,d0                       ; 001C0
        beq.b   l_012_001DA                     ; 001C4
        move.w  (DistanceShift).l,d1            ; 001C6
        asr.w   d1,d0                           ; 001CC
        cmp.w   -$28(a6),d0                     ; 001CE
        blt.b   l_012_001AC                     ; 001D2
        tst.w   (a2)+                           ; 001D4
        blt.b   l_012_001DA                     ; 001D6
        addq.w  #$2,a2                          ; 001D8
l_012_001DA:
        move.w  (a2)+,d0                        ; 001DA
        beq.b   l_012_001E4                     ; 001DC
        move.w  (a2)+,d7                        ; 001DE
        bsr.w   sub_012_0020E                   ; 001E0
l_012_001E4:
        move.w  (a2)+,d0                        ; 001E4
        move.w  d0,d1                           ; 001E6
        andi.w  #$4000,d1                       ; 001E8
        beq.b   l_012_001F2                     ; 001EC
        addq.w  #$1,-$6a(a6)                    ; 001EE
l_012_001F2:
        andi.w  #$3fff,d0                       ; 001F2
        lea.l   (ShapeOps).l,a0                 ; 001F6
        movea.l (a0,d0.w),a0                    ; 001FC
        jsr     (a0)                            ; 00200
        tst.w   d0                              ; 00202
        blt.b   l_012_001A6                     ; 00204
        or.w    d0,-$7c(a6)                     ; 00206
        bra.w   l_012_00168                     ; 0020A
sub_012_0020E:
        lea.l   (VertexBuffer).l,a3             ; 0020E
        move.w  d7,d2                           ; 00214
        asr.w   #$1,d2                          ; 00216
        add.w   d7,d2                           ; 00218
        adda.w  d2,a3                           ; 0021A
        move.w  d0,-$a(a6)                      ; 0021C
        movea.l (CurrentShape).l,a1             ; 00220
        addq.w  #$6,a1                          ; 00226
        adda.w  d7,a1                           ; 00228
        lea.l   (ViewMatrix).l,a0               ; 0022A
        lea.l   (a0),a4                         ; 00230
        move.w  -$86(a6),d0                     ; 00232
        move.w  -$82(a6),d1                     ; 00236
        add.w   (ObjectViewPos).l,d0            ; 0023A
        add.w   (ObjectViewPosZ).l,d1           ; 00240
        movem.w -$78(a6),d3/d6                  ; 00246
l_012_0024C:
        move.w  (a1)+,d2                        ; 0024C
        move.w  (a1)+,d4                        ; 0024E
        move.w  -$8(a6),d7                      ; 00250
        asr.w   d7,d2                           ; 00254
        asr.w   d7,d4                           ; 00256
        add.w   d0,d2                           ; 00258
        add.w   d1,d4                           ; 0025A
        lea.l   (a4),a0                         ; 0025C
        move.w  d2,d5                           ; 0025E
        move.w  d4,d7                           ; 00260
        muls.w  (a0)+,d5                        ; 00262
        addq.w  #$2,a0                          ; 00264
        muls.w  (a0)+,d7                        ; 00266
        add.l   d5,d7                           ; 00268
        asr.l   #$8,d7                          ; 0026A
        add.w   d3,d7                           ; 0026C
        move.w  d7,(a3)+                        ; 0026E
        move.w  d2,d5                           ; 00270
        move.w  d4,d7                           ; 00272
        muls.w  (a0)+,d5                        ; 00274
        addq.w  #$2,a0                          ; 00276
        muls.w  (a0)+,d7                        ; 00278
        add.l   d5,d7                           ; 0027A
        asr.l   #$8,d7                          ; 0027C
        add.w   d6,d7                           ; 0027E
        move.w  d7,(a3)+                        ; 00280
        muls.w  (a0)+,d2                        ; 00282
        muls.w  $2(a0),d4                       ; 00284
        add.l   d2,d4                           ; 00288
        asr.l   #$8,d4                          ; 0028A
        add.w   -$74(a6),d4                     ; 0028C
        move.w  d4,(a3)+                        ; 00290
        subq.w  #$1,-$a(a6)                     ; 00292
        bgt.b   l_012_0024C                     ; 00296
        rts                                     ; 00298

;-------------------------------------------------------------------------------
; ShapePolygonN - Op $60: a count and that many vertex offsets: a polygon drawn from either
; side (the ground shapes' hills).
;-------------------------------------------------------------------------------
ShapePolygonN:
        move.w  (a2)+,d7                        ; 0029A
        lea.l   (PolygonBuffer).l,a0            ; 0029C
        move.w  #$0,(a0)+                       ; 002A2
        lea.l   (VertexBuffer).l,a3             ; 002A6
        move.w  d7,(a0)+                        ; 002AC
        subq.w  #$3,d7                          ; 002AE
        move.w  (a2)+,d1                        ; 002B0
        lea.l   (a3,d1.w),a4                    ; 002B2
        move.l  (a4)+,(a0)+                     ; 002B6
        move.w  (a4),d6                         ; 002B8
        move.w  d6,(a0)+                        ; 002BA
        move.w  (a2)+,d1                        ; 002BC
        lea.l   (a3,d1.w),a4                    ; 002BE
        move.l  (a4)+,(a0)+                     ; 002C2
        move.w  (a4),(a0)+                      ; 002C4
        and.w   (a4),d6                         ; 002C6
l_012_002C8:
        move.w  (a2)+,d1                        ; 002C8
        lea.l   (a3,d1.w),a4                    ; 002CA
        move.l  (a4)+,(a0)+                     ; 002CE
        move.w  (a4),(a0)+                      ; 002D0
        and.w   (a4),d6                         ; 002D2
        subq.w  #$1,d7                          ; 002D4
        bge.b   l_012_002C8                     ; 002D6
        move.w  (a2)+,(DrawColour).l            ; 002D8
        tst.w   d6                              ; 002DE
        blt.b   l_012_002EE                     ; 002E0
        move.l  a2,-(a7)                        ; 002E2
        jsr     (ClipFillPolygon).l             ; 002E4
        movea.l (a7)+,a2                        ; 002EA
        rts                                     ; 002EC
l_012_002EE:
        moveq   #$0,d0                          ; 002EE
        rts                                     ; 002F0

;-------------------------------------------------------------------------------
; ShapePolygonN2 - Op $64: as ShapePolygonN (another form).
;-------------------------------------------------------------------------------
ShapePolygonN2:
        move.w  (a2)+,d7                        ; 002F2
        lea.l   (PolygonBuffer).l,a0            ; 002F4
        move.w  #$0,(a0)+                       ; 002FA
        lea.l   (VertexBuffer).l,a3             ; 002FE
        move.w  d7,(a0)+                        ; 00304
        subq.w  #$4,d7                          ; 00306
        move.l  (a3)+,(a0)+                     ; 00308
        move.w  (a3)+,d6                        ; 0030A
        move.w  d6,(a0)+                        ; 0030C
        move.l  (a3)+,(a0)+                     ; 0030E
        move.w  (a3),(a0)+                      ; 00310
        and.w   (a3)+,d6                        ; 00312
        move.l  (a3)+,(a0)+                     ; 00314
        move.w  (a3),(a0)+                      ; 00316
        and.w   (a3)+,d6                        ; 00318
l_012_0031A:
        move.l  (a3)+,(a0)+                     ; 0031A
        move.w  (a3),(a0)+                      ; 0031C
        and.w   (a3)+,d6                        ; 0031E
        dbra    d7,l_012_0031A                  ; 00320
        move.w  (a2)+,(DrawColour).l            ; 00324
        tst.w   d6                              ; 0032A
        blt.b   l_012_0033A                     ; 0032C
        move.l  a2,-(a7)                        ; 0032E
        jsr     (ClipFillPolygon).l             ; 00330
        movea.l (a7)+,a2                        ; 00336
        rts                                     ; 00338
l_012_0033A:
        moveq   #$0,d0                          ; 0033A
        rts                                     ; 0033C

;-------------------------------------------------------------------------------
; ShapePolygonRun - Op $68: a count and a vertex offset: a polygon of that many consecutive
; vertices.
;-------------------------------------------------------------------------------
ShapePolygonRun:
        move.w  (a2)+,d7                        ; 0033E
        lea.l   (PolygonBuffer).l,a0            ; 00340
        clr.w   (a0)+                           ; 00346
        lea.l   (VertexBuffer).l,a3             ; 00348
        adda.w  (a2)+,a3                        ; 0034E
        move.w  d7,(a0)+                        ; 00350
        subq.w  #$3,d7                          ; 00352
        move.l  (a3)+,(a0)+                     ; 00354
        move.w  (a3)+,d6                        ; 00356
        move.w  d6,(a0)+                        ; 00358
        move.l  (a3)+,(a0)+                     ; 0035A
        move.w  (a3),(a0)+                      ; 0035C
        and.w   (a3)+,d6                        ; 0035E
        move.l  (a3)+,(a0)+                     ; 00360
        move.w  (a3),(a0)+                      ; 00362
        and.w   (a3)+,d6                        ; 00364
l_012_00366:
        move.l  (a3)+,(a0)+                     ; 00366
        move.w  (a3),(a0)+                      ; 00368
        and.w   (a3)+,d6                        ; 0036A
        dbra    d7,l_012_00366                  ; 0036C
        tst.w   d6                              ; 00370
        blt.b   l_012_003BC                     ; 00372
        bra.b   l_012_00388                     ; 00374
sub_012_00376:
        move.w  #$7,(DrawColour).l              ; 00376
        move.w  #$f,d1                          ; 0037E
        move.w  #$ffff,d2                       ; 00382
        bra.b   l_012_00398                     ; 00386
l_012_00388:
        move.w  #$7,(DrawColour).l              ; 00388
        move.w  #$3,d1                          ; 00390
        move.w  #$3,d2                          ; 00394
l_012_00398:
        movem.w d1-d2,(FillPattern).l           ; 00398
        move.l  a2,-(a7)                        ; 003A0
        jsr     (ClipFillPolygon).l             ; 003A2
        movea.l (a7)+,a2                        ; 003A8
        move.w  #$f,d1                          ; 003AA
        move.w  #$ffff,d2                       ; 003AE
        movem.w d1-d2,(FillPattern).l           ; 003B2
        rts                                     ; 003BA
l_012_003BC:
        moveq   #$0,d0                          ; 003BC
        rts                                     ; 003BE

;-------------------------------------------------------------------------------
; CheckSeaView - Sets SeaView when the view looks over the sea (SeaViewTable, by
; LookupViewTable). Run every other frame.
;-------------------------------------------------------------------------------
CheckSeaView:
        lea.l   (SeaViewTable).l,a0             ; 003C0
        bsr.w   LookupViewTable                 ; 003C6
        beq.b   l_012_003D6                     ; 003CA
        move.b  #$1,(SeaView).l                 ; 003CC
        rts                                     ; 003D4
l_012_003D6:
        move.b  #$0,(SeaView).l                 ; 003D6
        rts                                     ; 003DE

;-------------------------------------------------------------------------------
; CheckViewTable2 - Sets dat_071_0026C from the view table at dat_012_006C0 (LookupViewTable),
; every other frame; used by hunk 28.
;-------------------------------------------------------------------------------
CheckViewTable2:
        lea.l   (dat_012_006C0).l,a0            ; 003E0
        bsr.w   LookupViewTable                 ; 003E6
        beq.b   l_012_003F6                     ; 003EA
        move.b  #$1,(dat_071_0026C).l           ; 003EC
        rts                                     ; 003F4
l_012_003F6:
        move.b  #$0,(dat_071_0026C).l           ; 003F6
        rts                                     ; 003FE

;-------------------------------------------------------------------------------
; LookupViewTable - LookupViewTable(a0 = table): d0 = 1 if the view is listed: the table lists,
; by ViewBlockZ then ViewBlockX (each a list of values ending -1, then offsets), entries of a
; height bound (a flag word, 0 = below, then a long against the camera height) followed by
; lists of ViewPlace values, each followed by the ViewOctants that count.
;-------------------------------------------------------------------------------
LookupViewTable:
        move.w  (ViewBlockX).l,d0               ; 00400
        move.w  (ViewBlockZ).l,d1               ; 00406
        lea.l   (a0),a1                         ; 0040C
        moveq   #-2,d3                          ; 0040E
l_012_00410:
        addq.w  #$2,d3                          ; 00410
        move.w  (a0)+,d2                        ; 00412
        blt.b   l_012_0048C                     ; 00414
        cmp.w   d2,d1                           ; 00416
        bne.b   l_012_00410                     ; 00418
l_012_0041A:
        tst.w   (a0)+                           ; 0041A
        bge.b   l_012_0041A                     ; 0041C
        move.w  (a0,d3.w),d3                    ; 0041E
        lea.l   (a1,d3.w),a0                    ; 00422
        moveq   #-2,d3                          ; 00426
l_012_00428:
        addq.w  #$2,d3                          ; 00428
        move.w  (a0)+,d2                        ; 0042A
        blt.b   l_012_0048C                     ; 0042C
        cmp.w   d2,d0                           ; 0042E
        bne.b   l_012_00428                     ; 00430
l_012_00432:
        tst.w   (a0)+                           ; 00432
        bge.b   l_012_00432                     ; 00434
        move.w  (a0,d3.w),d3                    ; 00436
        lea.l   (a1,d3.w),a0                    ; 0043A
        move.l  (ViewOffsetY8).l,d4             ; 0043E
        neg.l   d4                              ; 00444
l_012_00446:
        tst.w   (a0)                            ; 00446
        blt.b   l_012_0048C                     ; 00448
        cmpi.w  #$0,(a0)+                       ; 0044A
        beq.b   l_012_00456                     ; 0044E
        cmp.l   (a0)+,d4                        ; 00450
        blt.b   l_012_0048C                     ; 00452
        bra.b   l_012_0045A                     ; 00454
l_012_00456:
        cmp.l   (a0)+,d4                        ; 00456
        bgt.b   l_012_0048C                     ; 00458
l_012_0045A:
        move.b  (ViewPlace).l,d6                ; 0045A
l_012_00460:
        move.b  (a0)+,d5                        ; 00460
        blt.b   l_012_0046E                     ; 00462
        cmp.b   d5,d6                           ; 00464
        beq.b   l_012_0047A                     ; 00466
l_012_00468:
        tst.b   (a0)+                           ; 00468
        bge.b   l_012_00468                     ; 0046A
        bra.b   l_012_00460                     ; 0046C
l_012_0046E:
        move.w  a0,d5                           ; 0046E
        btst    #$0,d5                          ; 00470
        beq.b   l_012_00446                     ; 00474
        addq.w  #$1,a0                          ; 00476
        bra.b   l_012_00446                     ; 00478
l_012_0047A:
        move.b  (ViewOctant).l,d6               ; 0047A
l_012_00480:
        move.b  (a0)+,d5                        ; 00480
        blt.b   l_012_00460                     ; 00482
        cmp.b   d5,d6                           ; 00484
        bne.b   l_012_00480                     ; 00486
        moveq   #$1,d0                          ; 00488
        rts                                     ; 0048A
l_012_0048C:
        moveq   #$0,d0                          ; 0048C
        rts                                     ; 0048E
; SeaViewTable - The view table of CheckSeaView: where, how high and looking which way the view
; shows sea instead of land.
SeaViewTable:
	dc.b	$00,$0C,$00,$0D,$00,$0E,$00,$0F,$00,$10,$00,$11,$00,$12,$00,$13
	dc.b	$FF,$FF,$00,$22,$00,$34,$00,$46,$00,$58,$00,$6A,$00,$7C,$00,$8E
	dc.b	$00,$98,$00,$11,$00,$12,$00,$13,$00,$14,$FF,$FF,$00,$9E,$00,$9E
	dc.b	$00,$9E,$00,$9E,$00,$11,$00,$12,$00,$13,$00,$14,$FF,$FF,$00,$9E
	dc.b	$00,$9E,$00,$9E,$00,$9E,$00,$11,$00,$12,$00,$13,$00,$14,$FF,$FF
	dc.b	$00,$9E,$00,$9E,$00,$9E,$00,$9E,$00,$11,$00,$12,$00,$13,$00,$14
	dc.b	$FF,$FF,$00,$9E,$00,$9E,$00,$9E,$00,$9E,$00,$11,$00,$12,$00,$13
	dc.b	$00,$14,$FF,$FF,$01,$0E,$00,$9E,$00,$9E,$00,$9E,$00,$10,$00,$12
	dc.b	$00,$13,$00,$14,$FF,$FF,$02,$12,$00,$9E,$00,$9E,$00,$9E,$00,$13
	dc.b	$00,$14,$FF,$FF,$00,$9E,$00,$9E,$00,$14,$FF,$FF,$00,$9E,$00,$00
	dc.b	$00,$00,$C0,$00,$00,$05,$FF,$01,$05,$FF,$02,$05,$FF,$03,$05,$FF
	dc.b	$04,$05,$FF,$05,$05,$FF,$06,$05,$FF,$07,$05,$FF,$08,$05,$FF,$09
	dc.b	$05,$FF,$0A,$05,$FF,$0B,$05,$FF,$0C,$05,$FF,$0D,$05,$FF,$0E,$05
	dc.b	$FF,$0F,$05,$FF,$FF,$00,$00,$00,$00,$00,$20,$00,$00,$06,$FF,$01
	dc.b	$06,$FF,$02,$06,$FF,$03,$06,$FF,$04,$06,$FF,$05,$06,$FF,$06,$06
	dc.b	$FF,$07,$06,$FF,$08,$06,$FF,$09,$06,$FF,$0A,$06,$FF,$0B,$06,$FF
	dc.b	$0C,$06,$FF,$0D,$06,$FF,$0E,$06,$FF,$0F,$06,$FF,$FF,$00,$00,$00
	dc.b	$00,$00,$1F,$00,$00,$05,$FF,$01,$05,$FF,$02,$05,$FF,$03,$05,$FF
	dc.b	$04,$05,$FF,$05,$05,$FF,$06,$05,$FF,$07,$05,$FF,$08,$05,$FF,$09
	dc.b	$05,$FF,$0A,$05,$FF,$0B,$05,$FF,$0C,$05,$FF,$0D,$05,$FF,$0E,$05
	dc.b	$FF,$0F,$05,$FF,$FF,$00,$00,$00,$00,$00,$08,$00,$00,$04,$06,$FF
	dc.b	$01,$04,$06,$FF,$02,$04,$06,$FF,$03,$04,$06,$FF,$04,$04,$06,$FF
	dc.b	$05,$04,$06,$FF,$06,$04,$06,$FF,$07,$04,$06,$FF,$08,$04,$06,$FF
	dc.b	$09,$04,$06,$FF,$0A,$04,$06,$FF,$0B,$04,$06,$FF,$0C,$04,$06,$FF
	dc.b	$0D,$04,$06,$FF,$0E,$04,$06,$FF,$0F,$04,$06,$FF,$FF,$00,$00,$00
	dc.b	$00,$00,$04,$00,$00,$00,$01,$02,$03,$07,$FF,$01,$00,$01,$02,$03
	dc.b	$07,$FF,$04,$00,$01,$02,$03,$07,$FF,$05,$00,$01,$02,$03,$07,$FF
	dc.b	$08,$00,$01,$02,$03,$07,$FF,$09,$00,$01,$02,$03,$07,$FF,$0C,$00
	dc.b	$01,$02,$03,$07,$FF,$0D,$00,$01,$02,$03,$07,$FF,$FF,$00,$00,$00
	dc.b	$00,$00,$03,$00,$02,$00,$01,$02,$03,$FF,$06,$00,$01,$02,$03,$FF
	dc.b	$0A,$00,$01,$02,$03,$FF,$0E,$00,$01,$02,$03,$FF,$FF,$00,$00,$00
	dc.b	$00,$00,$02,$00,$03,$00,$01,$02,$03,$FF,$07,$00,$01,$02,$03,$FF
	dc.b	$0B,$00,$01,$02,$03,$FF,$0F,$00,$01,$02,$03,$FF,$FF,$00,$FF,$FF
	dc.b	$FF,$FF,$00,$00,$00,$00,$02,$60,$06,$04,$FF,$0A,$07,$FF,$FF,$00
	dc.b	$00,$00,$00,$00,$02,$00,$09,$01,$FF,$0A,$06,$FF,$FF,$00,$FF,$FF
dat_012_006C0:
	dc.b	$00,$11,$FF,$FF,$00,$06,$00,$10,$FF,$FF,$00,$0C,$00,$00,$00,$00
	dc.b	$0A,$00,$04,$03,$04,$05,$06,$FF,$06,$05,$FF,$08,$03,$04,$05,$06
	dc.b	$FF,$09,$02,$03,$04,$05,$06,$07,$FF,$0A,$03,$04,$05,$06,$FF,$0C
	dc.b	$00,$01,$02,$03,$04,$05,$06,$07,$FF,$0D,$02,$03,$04,$05,$06,$07
	dc.b	$FF,$0E,$02,$03,$04,$05,$06,$FF,$0F,$03,$04,$05,$FF,$FF,$FF,$FF
h012_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    2,12                            ; 2 longs pointing into hunk 12
	dc.l	$3E2,$3C2
        dc.l    2,13                            ; 2 longs pointing into hunk 13
	dc.l	$18A,$1F8
        dc.l    9,72                            ; 9 longs pointing into hunk 72
	dc.l	$C2,$29E,$2F6,$342,$C8,$210,$2A8,$300
	dc.l	$34A
        dc.l    40,71                           ; 40 longs pointing into hunk 71
	dc.l	$CE,$22C,$A4,$2E,$40,$38,$60,$1B2
	dc.l	$1C8,$56,$6C,$8A,$160,$84,$222,$DC
	dc.l	$242,$D6,$23C,$9E,$A,$18,$96,$90
	dc.l	$2DA,$326,$37A,$38C,$28,$39C,$3B6,$408
	dc.l	$402,$45C,$47C,$3F0,$3FA,$3D0,$3DA,$440
        dc.l    3,19                            ; 3 longs pointing into hunk 19
	dc.l	$2E6,$332,$3A4
	dc.l	0
	dc.l	HUNK_END
	endc
