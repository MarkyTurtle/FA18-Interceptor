; F/A-18 Interceptor - hunk 13 (code)
; The shapes' drawing operations: ShapeOps (point, line, filled polygon and special
; operations), with hunks 12, 14 and 15.
; Included by ../f18_main.s.

;===============================================================================
; Hunk 13: CODE, $136C bytes
;===============================================================================
	CODE_HUNK	h013
; ShapeOps - The drawing operations of a shape's face lists (DrawModel): a word with the top
; bit set picks one by its low 14 bits (an offset into this table; bit 14 marks the list's
; last). Each takes its operands from the list (a2) and returns d0 < 0 to end the list. Kinds:
; points and lines ($04, $08, $18, $2C-$38, $C0, $128, $12C), polygons ($0C, $3C-$48, $60-$68,
; $78, $114, $DC), the runway's view-dependent polygons ($1C-$28), the buildings' window grids
; ($4C-$58, $E4), the aircraft's shadow ($10), round blobs ($F8, $11C), operations that make
; extra vertices ($88-$90, $A4-$BC, $D0, $D4, $EC-$F4, $FC, $104), and ones that skip or pick
; part of the list (animation frames, ejection steps, which side faces the camera: $84, $C4,
; $CC, $D8, $108-$124, $130, $134). tools/models/opstats.py lists which models and shapes use
; each; those left unnamed ($14, $5C, $6C-$74, $80, $8C, $94-$A0, $B0, $C8, $E0, $100) are used
; by none of them.
ShapeOps:
        dc.l    ShapeNop                        ; 00000
        dc.l    ShapePoint                      ; 00004
        dc.l    ShapeLine                       ; 00008
        dc.l    ShapePolygon                    ; 0000C
        dc.l    ShapeShadow                     ; 00010
        dc.l    sub_013_0096E                   ; 00014
        dc.l    ShapeLineRow                    ; 00018
        dc.l    ShapeRunwaySide                 ; 0001C
        dc.l    ShapeRunwaySide2                ; 00020
        dc.l    ShapeRunwaySide3                ; 00024
        dc.l    ShapeRunwaySide4                ; 00028
        dc.l    ShapeLineRun                    ; 0002C
        dc.l    ShapeLineRunOffset              ; 00030
        dc.l    ShapeLineList                   ; 00034
        dc.l    ShapeLineFan                    ; 00038
        dc.l    ShapeParallelogram3             ; 0003C
        dc.l    ShapeParallelogram              ; 00040
        dc.l    ShapeQuadList                   ; 00044
        dc.l    ShapeQuadList                   ; 00048
        dc.l    ShapeLineGrid                   ; 0004C
        dc.l    ShapePaneGrid                   ; 00050
        dc.l    ShapePaneGrid2                  ; 00054
        dc.l    ShapeLineGridColour             ; 00058
        dc.l    sub_014_00086                   ; 0005C
        dc.l    ShapePolygonN                   ; 00060
        dc.l    ShapePolygonN2                  ; 00064
        dc.l    ShapePolygonRun                 ; 00068
        dc.l    sub_013_01158                   ; 0006C
        dc.l    sub_015_00774                   ; 00070
        dc.l    sub_015_00778                   ; 00074
        dc.l    ShapeParallelogramPat           ; 00078
        dc.l    ShapeSceneryTest                ; 0007C
        dc.l    sub_013_00D58                   ; 00080
        dc.l    ShapeCockpitFlag                ; 00084
        dc.l    ShapeMakeVertices               ; 00088
        dc.l    sub_013_01228                   ; 0008C
        dc.l    ShapeMakeVertices2              ; 00090
        dc.l    sub_013_012DC                   ; 00094
        dc.l    sub_014_00DA8                   ; 00098
        dc.l    sub_013_006E8                   ; 0009C
        dc.l    sub_013_008AA                   ; 000A0
        dc.l    ShapeMakeVertices3              ; 000A4
        dc.l    MakeVerticesF16                 ; 000A8
        dc.l    MakeVerticesMiG                 ; 000AC
        dc.l    sub_014_00BCE                   ; 000B0
        dc.l    MakeVerticesSidewinder          ; 000B4
        dc.l    sub_014_00DA8                   ; 000B8
        dc.l    MakeVerticesSidewinder          ; 000BC
        dc.l    ShapeLineAlt                    ; 000C0
        dc.l    ShapePointIfFront               ; 000C4
        dc.l    sub_014_00868                   ; 000C8
        dc.l    ShapeSkipUnlessFlag3            ; 000CC
        dc.l    MakeVerticesBetween             ; 000D0
        dc.l    MakeVerticesMoved               ; 000D4
        dc.l    ShapeSkipBeforeEjection         ; 000D8
        dc.l    ShapePolygonTable               ; 000DC
        dc.l    sub_015_0058C                   ; 000E0
        dc.l    ShapePaneGridColour             ; 000E4
        dc.l    ShapePointAlt                   ; 000E8
        dc.l    MakeVerticesFA18                ; 000EC
        dc.l    MakeVerticesFA18                ; 000F0
        dc.l    MakeVerticesFA18                ; 000F4
        dc.l    ShapeBlob                       ; 000F8
        dc.l    MakeVerticesCruise              ; 000FC
        dc.l    sub_015_00684                   ; 00100
        dc.l    MakeVerticesPod                 ; 00104
        dc.l    ShapeSkipDuringEjection         ; 00108
        dc.l    ShapeSkipIfBack                 ; 0010C
        dc.l    ShapeAnimate52                  ; 00110
        dc.l    ShapeParallelogramFront         ; 00114
        dc.l    ShapeSmallObjectFrame           ; 00118
        dc.l    ShapeBlobList                   ; 0011C
        dc.l    ShapeAnimate18                  ; 00120
        dc.l    ShapeSkipIfObject57             ; 00124
        dc.l    ShapeLineFromAbove              ; 00128
        dc.l    ShapeLineListFromAbove          ; 0012C
        dc.l    ShapeSkipWord                   ; 00130
        dc.l    ShapeSelectVariant              ; 00134

;-------------------------------------------------------------------------------
; ShapeNop - Draws nothing.
;-------------------------------------------------------------------------------
ShapeNop:
        moveq   #$0,d0                          ; 00138
        rts                                     ; 0013A

;-------------------------------------------------------------------------------
; ShapePoint - A point: the vertex (an offset into VertexBuffer) and its colour; projected and
; plotted (PlotPoint3D).
;-------------------------------------------------------------------------------
ShapePoint:
        lea.l   (VertexBuffer).l,a3             ; 0013C
        adda.w  (a2)+,a3                        ; 00142
        movem.w (a3),d0-d2                      ; 00144
        move.w  (a2)+,(DrawColour).l            ; 00148
        movem.l a1-a2,-(a7)                     ; 0014E
        jsr     (PlotPoint3D).l                 ; 00152
        movem.l (a7)+,a1-a2                     ; 00158
        rts                                     ; 0015C

;-------------------------------------------------------------------------------
; ShapePointAlt - Op $E8: a point (as ShapePoint) plotted by sub_035_00034 instead.
;-------------------------------------------------------------------------------
ShapePointAlt:
        lea.l   (VertexBuffer).l,a3             ; 0015E
        adda.w  (a2)+,a3                        ; 00164
        movem.w (a3),d0-d2                      ; 00166
        move.w  (a2)+,(DrawColour).l            ; 0016A
        movem.l a1-a2,-(a7)                     ; 00170
        jsr     (sub_035_00034).l               ; 00174
        movem.l (a7)+,a1-a2                     ; 0017A
        rts                                     ; 0017E

;-------------------------------------------------------------------------------
; ShapeSmallObjectFrame - Op $118: picks the part of the list for the small object's state
; (SmallObjects +$04): used by shapes 17-19.
;-------------------------------------------------------------------------------
ShapeSmallObjectFrame:
        lea.l   (SmallObjects).l,a4             ; 00180
        move.w  (CurrentObject).l,d0            ; 00186
        asl.w   #$5,d0                          ; 0018C
        adda.w  d0,a4                           ; 0018E
        move.w  $4(a4),d0                       ; 00190
        blt.b   l_013_001E8                     ; 00194
        move.w  d0,d2                           ; 00196
        moveq   #$2,d1                          ; 00198
        andi.w  #$7,d0                          ; 0019A
        subq.w  #$1,d0                          ; 0019E
        ble.b   l_013_001B6                     ; 001A0
        addi.w  #$86,d1                         ; 001A2
        subq.w  #$2,d0                          ; 001A6
        ble.b   l_013_001B6                     ; 001A8
        addi.w  #$86,d1                         ; 001AA
        subq.w  #$2,d0                          ; 001AE
        ble.b   l_013_001B6                     ; 001B0
        addi.w  #$86,d1                         ; 001B2
l_013_001B6:
        adda.w  d1,a2                           ; 001B6
        cmpi.w  #$c,d2                          ; 001B8
        bge.b   l_013_001D0                     ; 001BC
        subi.w  #$b,d2                          ; 001BE
        neg.w   d2                              ; 001C2
        asr.w   #$1,d2                          ; 001C4
        asl.w   #$3,d2                          ; 001C6
        adda.w  #$26,a2                         ; 001C8
        adda.w  d2,a2                           ; 001CC
        bra.b   l_013_001E8                     ; 001CE
l_013_001D0:
        cmpi.w  #$74,d2                         ; 001D0
        ble.b   l_013_001E8                     ; 001D4
        subi.w  #$80,d2                         ; 001D6
        addi.w  #$c,d2                          ; 001DA
        asr.w   #$1,d2                          ; 001DE
        asl.w   #$3,d2                          ; 001E0
        adda.w  #$56,a2                         ; 001E2
        adda.w  d2,a2                           ; 001E6
l_013_001E8:
        moveq   #$0,d0                          ; 001E8
        rts                                     ; 001EA

;-------------------------------------------------------------------------------
; ShapeSkipIfObject57 - Op $124: skips a word when the object is number $57.
;-------------------------------------------------------------------------------
ShapeSkipIfObject57:
        cmpi.w  #$57,(CurrentObject).l          ; 001EC
        bne.b   l_013_001F8                     ; 001F4
        addq.w  #$2,a2                          ; 001F6
l_013_001F8:
        moveq   #$0,d0                          ; 001F8
        rts                                     ; 001FA

;-------------------------------------------------------------------------------
; ShapeAnimate18 - Op $120: picks one of 16 frames of $12 bytes each by FrameCount.
;-------------------------------------------------------------------------------
ShapeAnimate18:
        moveq   #$12,d0                         ; 001FC
        move.w  (FrameCount).l,d1               ; 001FE
        andi.w  #$f,d1                          ; 00204
        bra.b   l_013_0021A                     ; 00208

;-------------------------------------------------------------------------------
; ShapeAnimate52 - Op $110: picks one of 16 frames of $34 bytes each by FrameCount (animated
; parts of the carrier and submarine models).
;-------------------------------------------------------------------------------
ShapeAnimate52:
        moveq   #$34,d0                         ; 0020A
        move.w  (FrameCount).l,d1               ; 0020C
        andi.w  #$f,d1                          ; 00212
        bra.b   l_013_0021A                     ; 00216
l_013_00218:
        adda.w  d0,a2                           ; 00218
l_013_0021A:
        dbra    d1,l_013_00218                  ; 0021A
        moveq   #$0,d0                          ; 0021E
        rts                                     ; 00220

;-------------------------------------------------------------------------------
; ShapeSkipIfBack - Op $10C: three vertex offsets and a word: if the triangle faces away from
; the camera, skips the next $12 bytes.
;-------------------------------------------------------------------------------
ShapeSkipIfBack:
        lea.l   (dat_072_03C04).l,a0            ; 00222
        lea.l   (VertexBuffer).l,a3             ; 00228
        movem.w (a2)+,d0-d2                     ; 0022E
        move.l  (a3,d0.w),(a0)+                 ; 00232
        move.w  $4(a3,d0.w),(a0)+               ; 00236
        move.l  (a3,d1.w),(a0)+                 ; 0023A
        move.w  $4(a3,d1.w),(a0)+               ; 0023E
        move.l  (a3,d2.w),(a0)+                 ; 00242
        move.w  $4(a3,d2.w),(a0)+               ; 00246
        movea.w (a2)+,a3                        ; 0024A
        move.w  a3,d7                           ; 0024C
        jsr     (FacesCamera).l                 ; 0024E
        bne.b   l_013_00258                     ; 00254
        rts                                     ; 00256
l_013_00258:
        adda.w  #$12,a2                         ; 00258
        rts                                     ; 0025C

;-------------------------------------------------------------------------------
; ShapePointIfFront - Op $C4: three vertex offsets and a colour: plots the first vertex if the
; triangle faces the camera.
;-------------------------------------------------------------------------------
ShapePointIfFront:
        lea.l   (dat_072_03C04).l,a0            ; 0025E
        lea.l   (VertexBuffer).l,a3             ; 00264
        movem.w (a2)+,d0-d2                     ; 0026A
        move.l  (a3,d0.w),(a0)+                 ; 0026E
        move.w  $4(a3,d0.w),(a0)+               ; 00272
        move.l  (a3,d1.w),(a0)+                 ; 00276
        move.w  $4(a3,d1.w),(a0)+               ; 0027A
        move.l  (a3,d2.w),(a0)+                 ; 0027E
        move.w  $4(a3,d2.w),(a0)+               ; 00282
        movea.w (a2)+,a3                        ; 00286
        move.w  a3,d7                           ; 00288
        jsr     (FacesCamera).l                 ; 0028A
        bne.b   l_013_002B0                     ; 00290
        movem.w (dat_072_03C04).l,d0-d2         ; 00292
        move.w  a3,(DrawColour).l               ; 0029A
        movem.l a1-a2,-(a7)                     ; 002A0
        jsr     (PlotPoint3D).l                 ; 002A4
        movem.l (a7)+,a1-a2                     ; 002AA
        rts                                     ; 002AE
l_013_002B0:
        moveq   #$0,d0                          ; 002B0
        rts                                     ; 002B2

;-------------------------------------------------------------------------------
; ShapeLineAlt - Op $C0: a line (as ShapeLine) drawn by sub_035_00100 instead.
;-------------------------------------------------------------------------------
ShapeLineAlt:
        lea.l   (sub_035_00100).l,a4            ; 002B4
        bra.b   l_013_002D2                     ; 002BA

;-------------------------------------------------------------------------------
; ShapeLineFromAbove - Op $128: a line (as ShapeLine) drawn only when the shape is seen from
; well above (dat_071_00448 below -$C0); otherwise its three words are skipped.
;-------------------------------------------------------------------------------
ShapeLineFromAbove:
        cmpi.l  #$ffffff40,(dat_071_00448).l    ; 002BC
        blt.b   ShapeLine                       ; 002C6
        addq.w  #$6,a2                          ; 002C8
        bra.b   l_013_00316                     ; 002CA

;-------------------------------------------------------------------------------
; ShapeLine - Op $08, a line: two vertex offsets and a colour; drawn (sub_035_001DA) unless
; both ends are behind the camera.
;-------------------------------------------------------------------------------
ShapeLine:
        lea.l   (sub_035_001DA).l,a4            ; 002CC
l_013_002D2:
        move.l  #$ffffffff,(dat_071_000B6).l    ; 002D2
        lea.l   (dat_072_04202).l,a0            ; 002DC
        lea.l   (VertexBuffer).l,a3             ; 002E2
        move.w  (a2)+,d1                        ; 002E8
        move.l  (a3,d1.w),(a0)+                 ; 002EA
        move.w  $4(a3,d1.w),d6                  ; 002EE
        move.w  d6,(a0)+                        ; 002F2
        move.w  (a2)+,d1                        ; 002F4
        move.l  (a3,d1.w),(a0)+                 ; 002F6
        move.w  $4(a3,d1.w),d7                  ; 002FA
        move.w  (a2)+,(DrawColour).l            ; 002FE
        and.w   d7,d6                           ; 00304
        blt.b   l_013_00316                     ; 00306
        move.w  d7,(a0)+                        ; 00308
        movem.l a1-a2/a5,-(a7)                  ; 0030A
        jsr     (a4)                            ; 0030E
        movem.l (a7)+,a1-a2/a5                  ; 00310
        rts                                     ; 00314
l_013_00316:
        moveq   #$0,d0                          ; 00316
        rts                                     ; 00318

;-------------------------------------------------------------------------------
; ShapeParallelogramFront - Op $114: three vertex offsets: a parallelogram (a fourth corner
; made from them) tested for which side faces the camera, with ShapePolygon's colour words.
;-------------------------------------------------------------------------------
ShapeParallelogramFront:
        lea.l   (VertexBuffer).l,a3             ; 0031A
        lea.l   (PolygonBuffer).l,a0            ; 00320
        move.l  #$4,(a0)+                       ; 00326
        movem.w (a2)+,d1-d3                     ; 0032C
        move.l  (a3,d1.w),(a0)+                 ; 00330
        move.w  $4(a3,d1.w),(a0)+               ; 00334
        move.l  (a3,d2.w),(a0)+                 ; 00338
        move.w  $4(a3,d2.w),(a0)+               ; 0033C
        move.l  (a3,d3.w),(a0)+                 ; 00340
        move.w  $4(a3,d3.w),(a0)+               ; 00344
        movem.w -$12(a0),d2-d7                  ; 00348
        move.w  d4,d0                           ; 0034E
        and.w   d7,d0                           ; 00350
        sub.w   d2,d5                           ; 00352
        sub.w   d3,d6                           ; 00354
        sub.w   d4,d7                           ; 00356
        movem.w -$6(a0),d2-d4                   ; 00358
        and.w   d4,d0                           ; 0035E
        sub.w   d5,d2                           ; 00360
        sub.w   d6,d3                           ; 00362
        sub.w   d7,d4                           ; 00364
        and.w   d4,d0                           ; 00366
        bge.b   l_013_0036E                     ; 00368
        moveq   #-1,d0                          ; 0036A
        rts                                     ; 0036C
l_013_0036E:
        movem.w d2-d4,(a0)                      ; 0036E
        bra.b   l_013_003C6                     ; 00372

;-------------------------------------------------------------------------------
; ShapePolygon - A filled polygon: vertex offsets, the last with bit 15 set, then the colour
; word. With bit 15 set the face is drawn from either side; otherwise it is tested
; (sub_010_00E4A) and drawn only from the front, unless bit 14 is set and a second colour word
; follows for its back. A face not drawn, or with every vertex behind the camera, returns -1,
; which ends the rest of its face list in DrawModel; otherwise it is clipped and filled
; (ClipFillPolygon).
;-------------------------------------------------------------------------------
ShapePolygon:
        lea.l   (PolygonBuffer).l,a0            ; 00374
        clr.w   (a0)+                           ; 0037A
        addq.w  #$2,a0                          ; 0037C
        lea.l   (VertexBuffer).l,a3             ; 0037E
        moveq   #$3,d7                          ; 00384
        move.w  (a2)+,d1                        ; 00386
        lea.l   (a3,d1.w),a4                    ; 00388
        move.l  (a4)+,(a0)+                     ; 0038C
        move.w  (a4),d6                         ; 0038E
        move.w  d6,(a0)+                        ; 00390
        move.w  (a2)+,d1                        ; 00392
        lea.l   (a3,d1.w),a4                    ; 00394
        move.l  (a4)+,(a0)+                     ; 00398
        move.w  (a4),(a0)+                      ; 0039A
        and.w   (a4),d6                         ; 0039C
l_013_0039E:
        move.w  (a2)+,d1                        ; 0039E
        blt.b   l_013_003B0                     ; 003A0
        lea.l   (a3,d1.w),a4                    ; 003A2
        move.l  (a4)+,(a0)+                     ; 003A6
        move.w  (a4),(a0)+                      ; 003A8
        and.w   (a4),d6                         ; 003AA
        addq.w  #$1,d7                          ; 003AC
        bra.b   l_013_0039E                     ; 003AE
l_013_003B0:
        andi.w  #$7fff,d1                       ; 003B0
        lea.l   (a3,d1.w),a4                    ; 003B4
        move.l  (a4)+,(a0)+                     ; 003B8
        move.w  (a4),(a0)+                      ; 003BA
        and.w   (a4),d6                         ; 003BC
        blt.b   l_013_0040A                     ; 003BE
        move.w  d7,(dat_072_03C02).l            ; 003C0
l_013_003C6:
        movea.w (a2)+,a3                        ; 003C6
        move.w  a3,d7                           ; 003C8
        blt.b   l_013_003F4                     ; 003CA
        addq.w  #$1,-$32(a6)                    ; 003CC
        jsr     (FacesCamera).l                 ; 003D0
        beq.b   l_013_003E4                     ; 003D6
        move.w  a3,d1                           ; 003D8
        andi.w  #$4000,d1                       ; 003DA
        beq.b   l_013_0040A                     ; 003DE
        move.w  (a2)+,d7                        ; 003E0
        bra.b   l_013_003F4                     ; 003E2
l_013_003E4:
        addq.w  #$1,-$34(a6)                    ; 003E4
        move.w  a3,d1                           ; 003E8
        move.w  d1,d7                           ; 003EA
        andi.w  #$4000,d1                       ; 003EC
        beq.b   l_013_003F4                     ; 003F0
        addq.w  #$2,a2                          ; 003F2
l_013_003F4:
        move.w  d7,(DrawColour).l               ; 003F4
        movem.l a1-a2/a5,-(a7)                  ; 003FA
        jsr     (ClipFillPolygon).l             ; 003FE
        movem.l (a7)+,a1-a2/a5                  ; 00404
        rts                                     ; 00408
l_013_0040A:
        moveq   #-1,d0                          ; 0040A
        rts                                     ; 0040C
l_013_0040E:
        movem.l (a7)+,a1/a5                     ; 0040E
        move.w  -$7e(a6),d0                     ; 00412
        rts                                     ; 00416

;-------------------------------------------------------------------------------
; ShapePolygonTable - Op $DC: a pointer to a table of faces, then offsets into it (ended by a
; negative word): each a ShapePolygon-style face.
;-------------------------------------------------------------------------------
ShapePolygonTable:
        movem.l a1/a5,-(a7)                     ; 00418
        clr.w   -$7e(a6)                        ; 0041C
        clr.w   (PolygonBuffer).l               ; 00420
        movea.l (a2)+,a4                        ; 00426
l_013_00428:
        move.w  (a2)+,d1                        ; 00428
        blt.b   l_013_0040E                     ; 0042A
        move.l  a4,-(a7)                        ; 0042C
        adda.w  d1,a4                           ; 0042E
        lea.l   (dat_072_03C04).l,a0            ; 00430
        lea.l   (VertexBuffer).l,a3             ; 00436
        moveq   #$3,d7                          ; 0043C
        move.w  (a4)+,d1                        ; 0043E
        move.l  (a3,d1.w),(a0)+                 ; 00440
        move.w  $4(a3,d1.w),d6                  ; 00444
        move.w  d6,(a0)+                        ; 00448
        move.w  (a4)+,d1                        ; 0044A
        move.l  (a3,d1.w),(a0)+                 ; 0044C
        move.w  $4(a3,d1.w),(a0)+               ; 00450
        and.w   -$2(a0),d6                      ; 00454
l_013_00458:
        move.w  (a4)+,d1                        ; 00458
        blt.b   l_013_0046C                     ; 0045A
        move.l  (a3,d1.w),(a0)+                 ; 0045C
        move.w  $4(a3,d1.w),(a0)+               ; 00460
        and.w   -$2(a0),d6                      ; 00464
        addq.w  #$1,d7                          ; 00468
        bra.b   l_013_00458                     ; 0046A
l_013_0046C:
        andi.w  #$7fff,d1                       ; 0046C
        move.l  (a3,d1.w),(a0)+                 ; 00470
        move.w  $4(a3,d1.w),(a0)+               ; 00474
        and.w   -$2(a0),d6                      ; 00478
        blt.b   l_013_004B4                     ; 0047C
        move.w  d7,(dat_072_03C02).l            ; 0047E
        movea.w (a4)+,a3                        ; 00484
        move.w  a3,d7                           ; 00486
        blt.b   l_013_004A0                     ; 00488
        jsr     (FacesCamera).l                 ; 0048A
        beq.b   l_013_0049E                     ; 00490
        move.w  a3,d1                           ; 00492
        andi.w  #$4000,d1                       ; 00494
        beq.b   l_013_004B4                     ; 00498
        move.w  (a4)+,d7                        ; 0049A
        bra.b   l_013_004A0                     ; 0049C
l_013_0049E:
        move.w  a3,d7                           ; 0049E
l_013_004A0:
        move.w  d7,(DrawColour).l               ; 004A0
        move.l  a2,-(a7)                        ; 004A6
        jsr     (ClipFillPolygon).l             ; 004A8
        or.w    d0,-$7e(a6)                     ; 004AE
        movea.l (a7)+,a2                        ; 004B2
l_013_004B4:
        movea.l (a7)+,a4                        ; 004B4
        bra.w   l_013_00428                     ; 004B6
l_013_004BA:
        moveq   #-1,d0                          ; 004BA
        rts                                     ; 004BC

;-------------------------------------------------------------------------------
; ShapeShadow - Op $10: the aircraft's shadow on the ground: in colour 0, its faces (offsets
; into the object's own vertices, ObjectTable +$A4) flattened onto the ground below it; only
; while low enough (and, from the cockpit, depending on dat_071_0023B and which object it is).
; Used by every aircraft model.
;-------------------------------------------------------------------------------
ShapeShadow:
        move.l  (dat_071_00436).l,d0            ; 004BE
        lea.l   (ObjectTable).l,a4              ; 004C4
        adda.w  (CurrentObjectOffset).l,a4      ; 004CA
        move.b  $4(a4),d3                       ; 004D0
        move.b  d3,d7                           ; 004D4
        andi.b  #$c0,d7                         ; 004D6
        beq.b   l_013_004E2                     ; 004DA
        cmpi.b  #$c0,d7                         ; 004DC
        bne.b   l_013_00544                     ; 004E0
l_013_004E2:
        andi.b  #$40,d3                         ; 004E2
        beq.b   l_013_00506                     ; 004E6
        move.w  $4e(a4),d7                      ; 004E8
        neg.w   d7                              ; 004EC
        ext.l   d7                              ; 004EE
        asl.l   #$8,d7                          ; 004F0
        cmp.l   d7,d0                           ; 004F2
        bge.b   l_013_00544                     ; 004F4
        sub.l   d7,d0                           ; 004F6
        move.w  (dat_071_00488).l,d3            ; 004F8
        asr.l   d3,d0                           ; 004FE
        move.l  d0,-$90(a6)                     ; 00500
        bra.b   l_013_0050C                     ; 00504
l_013_00506:
        move.l  -$1c(a6),-$90(a6)               ; 00506
l_013_0050C:
        cmpi.l  #$fff00000,d0                   ; 0050C
        blt.b   l_013_004BA                     ; 00512
        tst.b   (OutsideView).l                 ; 00514
        bne.b   l_013_00574                     ; 0051A
        cmpi.b  #$3,(dat_071_0023B).l           ; 0051C
        bge.b   l_013_00574                     ; 00524
        move.w  (CurrentObject).l,d7            ; 00526
        cmp.w   (dat_071_002AC).l,d7            ; 0052C
        bne.b   l_013_00548                     ; 00532
        tst.b   (dat_071_0023B).l               ; 00534
        beq.b   l_013_00544                     ; 0053A
        move.l  #$ffffe000,d2                   ; 0053C
        bra.b   l_013_00570                     ; 00542
l_013_00544:
        moveq   #$1,d0                          ; 00544
        rts                                     ; 00546
l_013_00548:
        cmpi.b  #$30,$62(a4)                    ; 00548
        beq.b   l_013_00574                     ; 0054E
        cmpi.l  #$ffff0000,d0                   ; 00550
        bge.b   l_013_00574                     ; 00556
        cmpi.b  #$14,$62(a4)                    ; 00558
        beq.b   l_013_00574                     ; 0055E
        cmpi.b  #$1,(dat_071_0023B).l           ; 00560
        ble.b   l_013_00544                     ; 00568
        move.l  #$fff60000,d2                   ; 0056A
l_013_00570:
        cmp.l   d2,d0                           ; 00570
        blt.b   l_013_00544                     ; 00572
l_013_00574:
        movem.l a1/a5,-(a7)                     ; 00574
        move.w  (a2)+,d0                        ; 00578
        ext.l   d0                              ; 0057A
        asl.l   #$8,d0                          ; 0057C
        cmp.l   $18(a4),d0                      ; 0057E
        blt.w   l_013_0060A                     ; 00582
        adda.w  #$a4,a4                         ; 00586
        move.w  (dat_071_00488).l,-$2(a6)       ; 0058A
        move.l  d0,d2                           ; 00592
        neg.l   d0                              ; 00594
        swap    d0                              ; 00596
        ext.l   d0                              ; 00598
        asr.l   #$5,d0                          ; 0059A
        sub.w   -$2(a6),d0                      ; 0059C
        bgt.b   l_013_005B2                     ; 005A0
        clr.w   d0                              ; 005A2
        move.l  -$20(a6),-$94(a6)               ; 005A4
        move.l  -$18(a6),-$8c(a6)               ; 005AA
        bra.b   l_013_005CE                     ; 005B0
l_013_005B2:
        add.w   d0,-$2(a6)                      ; 005B2
        move.l  -$20(a6),d1                     ; 005B6
        move.l  -$18(a6),d3                     ; 005BA
        asr.l   d0,d1                           ; 005BE
        asr.l   d0,d3                           ; 005C0
        move.w  -$2(a6),d0                      ; 005C2
        asr.l   d0,d2                           ; 005C6
        movem.l d1-d3,-$94(a6)                  ; 005C8
l_013_005CE:
        movem.l -$94(a6),d1-d3                  ; 005CE
        move.l  (dat_071_00500).l,d4            ; 005D4
        move.l  (dat_071_00508).l,d5            ; 005DA
        asr.l   d0,d4                           ; 005E0
        asr.l   d0,d5                           ; 005E2
        add.l   d4,d1                           ; 005E4
        add.l   d5,d3                           ; 005E6
        moveq   #$8,d7                          ; 005E8
        sub.w   -$6(a6),d7                      ; 005EA
        asr.l   d7,d1                           ; 005EE
        asr.l   d7,d2                           ; 005F0
        asr.l   d7,d3                           ; 005F2
        movem.w d1-d3,-$14(a6)                  ; 005F4
        move.w  #$0,(DrawColour).l              ; 005FA
        clr.w   (PolygonBuffer).l               ; 00602
        bra.b   l_013_00622                     ; 00608
l_013_0060A:
        movem.l (a7)+,a1/a5                     ; 0060A
        moveq   #$1,d0                          ; 0060E
        rts                                     ; 00610
l_013_00612:
        move.w  (a2)+,d0                        ; 00612
        blt.b   l_013_0060A                     ; 00614
        ext.l   d0                              ; 00616
        lea.l   (a4),a5                         ; 00618
        suba.w  #$94,a5                         ; 0061A
        cmp.l   (a5),d0                         ; 0061E
        blt.b   l_013_0060A                     ; 00620
l_013_00622:
        tst.w   $2(a2)                          ; 00622
        bne.b   l_013_00662                     ; 00626
        movem.w $4(a2),d1-d3                    ; 00628
        move.w  (a4,d1.w),d0                    ; 0062E
        move.w  (a4,d2.w),d5                    ; 00632
        sub.w   d0,d5                           ; 00636
        move.w  (a4,d3.w),d6                    ; 00638
        sub.w   d0,d6                           ; 0063C
        move.w  $4(a4,d1.w),d4                  ; 0063E
        move.w  $4(a4,d2.w),d1                  ; 00642
        sub.w   d4,d1                           ; 00646
        move.w  $4(a4,d3.w),d3                  ; 00648
        sub.w   d4,d3                           ; 0064C
        muls.w  d1,d6                           ; 0064E
        muls.w  d5,d3                           ; 00650
        sub.l   d3,d6                           ; 00652
        asr.l   #$8,d6                          ; 00654
        bge.b   l_013_00662                     ; 00656
        move.w  (a2)+,d7                        ; 00658
        add.w   d7,d7                           ; 0065A
        addq.w  #$2,d7                          ; 0065C
        adda.w  d7,a2                           ; 0065E
        bra.b   l_013_00612                     ; 00660
l_013_00662:
        move.w  (a2)+,d7                        ; 00662
        addq.w  #$2,a2                          ; 00664
        lea.l   (dat_072_03C02).l,a0            ; 00666
        move.w  d7,(a0)+                        ; 0066C
        move.w  d7,-$e(a6)                      ; 0066E
l_013_00672:
        move.w  (a2)+,d7                        ; 00672
        move.w  -$8(a6),d5                      ; 00674
        move.w  (a4,d7.w),d2                    ; 00678
        asr.w   d5,d2                           ; 0067C
        move.w  $4(a4,d7.w),d4                  ; 0067E
        asr.w   d5,d4                           ; 00682
        add.w   -$14(a6),d2                     ; 00684
        move.w  -$12(a6),d3                     ; 00688
        add.w   -$10(a6),d4                     ; 0068C
        lea.l   (dat_071_005A8).l,a5            ; 00690
        move.w  d2,d5                           ; 00696
        move.w  d3,d6                           ; 00698
        move.w  d4,d7                           ; 0069A
        muls.w  (a5)+,d5                        ; 0069C
        muls.w  (a5)+,d6                        ; 0069E
        muls.w  (a5)+,d7                        ; 006A0
        add.l   d6,d7                           ; 006A2
        add.l   d5,d7                           ; 006A4
        asr.l   #$8,d7                          ; 006A6
        move.w  d7,(a0)+                        ; 006A8
        move.w  d2,d5                           ; 006AA
        move.w  d3,d6                           ; 006AC
        move.w  d4,d7                           ; 006AE
        muls.w  (a5)+,d5                        ; 006B0
        muls.w  (a5)+,d6                        ; 006B2
        muls.w  (a5)+,d7                        ; 006B4
        add.l   d6,d7                           ; 006B6
        add.l   d5,d7                           ; 006B8
        asr.l   #$8,d7                          ; 006BA
        move.w  d7,(a0)+                        ; 006BC
        muls.w  (a5)+,d2                        ; 006BE
        muls.w  (a5)+,d3                        ; 006C0
        muls.w  (a5)+,d4                        ; 006C2
        add.l   d3,d4                           ; 006C4
        add.l   d2,d4                           ; 006C6
        asr.l   #$8,d4                          ; 006C8
        move.w  d4,(a0)+                        ; 006CA
        subq.w  #$1,-$e(a6)                     ; 006CC
        bgt.b   l_013_00672                     ; 006D0
        movem.l a2/a4,-(a7)                     ; 006D2
        jsr     (ClipFillPolygon).l             ; 006D6
        movem.l (a7)+,a2/a4                     ; 006DC
        bra.w   l_013_00612                     ; 006E0
l_013_006E4:
        moveq   #-1,d0                          ; 006E4
        rts                                     ; 006E6
sub_013_006E8:
        clr.w   -$7e(a6)                        ; 006E8
        move.l  (a2)+,d0                        ; 006EC
        move.w  (a2)+,-$5e(a6)                  ; 006EE
        lea.l   (VertexBuffer).l,a3             ; 006F2
        movem.w $6(a3),d1-d3                    ; 006F8
        cmp.w   d3,d1                           ; 006FE
        bgt.b   l_013_006E4                     ; 00700
        neg.w   d1                              ; 00702
        cmp.w   d3,d1                           ; 00704
        bgt.b   l_013_006E4                     ; 00706
        cmp.w   d3,d2                           ; 00708
        bgt.b   l_013_006E4                     ; 0070A
        neg.w   d2                              ; 0070C
        cmp.w   d3,d2                           ; 0070E
        bgt.b   l_013_006E4                     ; 00710
        movem.l a1-a2/a5,-(a7)                  ; 00712
        lea.l   (PolygonBuffer).l,a0            ; 00716
        move.l  #$4,(a0)+                       ; 0071C
        move.w  (dat_071_00442).l,d6            ; 00722
        move.w  (dat_071_00446).l,d7            ; 00728
        neg.w   d6                              ; 0072E
        neg.w   d7                              ; 00730
        move.w  (dat_071_004FA).l,d2            ; 00732
        move.w  (dat_071_004FE).l,d3            ; 00738
        move.w  (dat_071_00488).l,d5            ; 0073E
        asl.w   d5,d2                           ; 00744
        asl.w   d5,d3                           ; 00746
        sub.w   d2,d6                           ; 00748
        blt.b   l_013_00762                     ; 0074A
        sub.w   d3,d7                           ; 0074C
        bge.b   l_013_0076E                     ; 0074E
        neg.w   d7                              ; 00750
l_013_00752:
        cmp.w   d6,d7                           ; 00752
        bgt.b   l_013_00758                     ; 00754
        swap    d0                              ; 00756
l_013_00758:
        move.w  d0,(DrawColour).l               ; 00758
        bra.w   l_013_00816                     ; 0075E
l_013_00762:
        sub.w   d3,d7                           ; 00762
        blt.b   l_013_0076A                     ; 00764
        neg.w   d6                              ; 00766
        bra.b   l_013_00752                     ; 00768
l_013_0076A:
        neg.w   d6                              ; 0076A
        neg.w   d7                              ; 0076C
l_013_0076E:
        cmp.w   d6,d7                           ; 0076E
        bgt.b   l_013_00774                     ; 00770
        swap    d0                              ; 00772
l_013_00774:
        move.w  d0,(DrawColour).l               ; 00774
        movem.w (a3)+,d0-d7/a4                  ; 0077A
        movem.w d0-d5,(a0)                      ; 0077E
        sub.w   d3,d0                           ; 00782
        sub.w   d4,d1                           ; 00784
        sub.w   d5,d2                           ; 00786
        sub.w   d3,d6                           ; 00788
        sub.w   d4,d7                           ; 0078A
        suba.w  d5,a4                           ; 0078C
        movem.w (a3),d3-d5                      ; 0078E
        add.w   d6,d3                           ; 00792
        add.w   d7,d4                           ; 00794
        add.w   a4,d5                           ; 00796
        movem.w d3-d5,$c(a0)                    ; 00798
        add.w   d0,d3                           ; 0079E
        add.w   d1,d4                           ; 007A0
        add.w   d2,d5                           ; 007A2
        movem.w d3-d5,$12(a0)                   ; 007A4
        jsr     (ClipFillPolygon).l             ; 007AA
        or.w    d0,-$7e(a6)                     ; 007B0
        move.w  -$5e(a6),(DrawColour).l         ; 007B4
        tst.b   (dat_071_00156).l               ; 007BC
        beq.w   l_013_0089C                     ; 007C2
        lea.l   (dat_072_03C04).l,a0            ; 007C6
        lea.l   (VertexBuffer).l,a3             ; 007CC
        move.l  $12(a0),$c(a0)                  ; 007D2
        move.w  $16(a0),$10(a0)                 ; 007D8
        movem.w (a3),d0-d7/a4                   ; 007DE
        sub.w   d3,d6                           ; 007E2
        sub.w   d4,d7                           ; 007E4
        suba.w  d5,a4                           ; 007E6
        move.w  d0,d3                           ; 007E8
        move.w  d1,d4                           ; 007EA
        move.w  d2,d5                           ; 007EC
        add.w   d6,d0                           ; 007EE
        add.w   d7,d1                           ; 007F0
        add.w   a4,d2                           ; 007F2
        movem.w d0-d2,$6(a0)                    ; 007F4
        sub.w   $c(a0),d0                       ; 007FA
        sub.w   $e(a0),d1                       ; 007FE
        sub.w   $10(a0),d2                      ; 00802
        sub.w   d0,d3                           ; 00806
        sub.w   d1,d4                           ; 00808
        sub.w   d2,d5                           ; 0080A
        movem.w d3-d5,$12(a0)                   ; 0080C
        bra.w   l_013_00892                     ; 00812
l_013_00816:
        movem.w (a3)+,d0-d7/a4                  ; 00816
        movem.w d6-d7/a4,(a0)                   ; 0081A
        sub.w   d3,d0                           ; 0081E
        sub.w   d4,d1                           ; 00820
        sub.w   d5,d2                           ; 00822
        movem.w (a3),d3-d5                      ; 00824
        movem.w d3-d5,$6(a0)                    ; 00828
        add.w   d0,d3                           ; 0082E
        add.w   d1,d4                           ; 00830
        add.w   d2,d5                           ; 00832
        add.w   d0,d6                           ; 00834
        add.w   d1,d7                           ; 00836
        adda.w  d2,a4                           ; 00838
        movem.w d3-d7/a4,$c(a0)                 ; 0083A
        jsr     (ClipFillPolygon).l             ; 00840
        or.w    d0,-$7e(a6)                     ; 00846
        move.w  -$5e(a6),(DrawColour).l         ; 0084A
        tst.b   (dat_071_00156).l               ; 00852
        beq.b   l_013_0089C                     ; 00858
        lea.l   (dat_072_03C04).l,a0            ; 0085A
        lea.l   (VertexBuffer).l,a3             ; 00860
        movem.w (a3),d0-d2                      ; 00866
        movem.w d0-d2,(a0)                      ; 0086A
        movem.w $c(a0),d3-d7/a4                 ; 0086E
        movem.w d6-d7/a4,$6(a0)                 ; 00874
        movem.w d3-d5,$12(a0)                   ; 0087A
        sub.w   d0,d3                           ; 00880
        sub.w   d1,d4                           ; 00882
        sub.w   d2,d5                           ; 00884
        add.w   d3,d6                           ; 00886
        add.w   d4,d7                           ; 00888
        adda.w  d5,a4                           ; 0088A
        movem.w d6-d7/a4,$c(a0)                 ; 0088C
l_013_00892:
        jsr     (ClipFillPolygon).l             ; 00892
        or.w    d0,-$7e(a6)                     ; 00898
l_013_0089C:
        movem.l (a7)+,a1-a2/a5                  ; 0089C
        move.w  -$7e(a6),d0                     ; 008A0
        rts                                     ; 008A4
l_013_008A6:
        moveq   #-1,d0                          ; 008A6
        rts                                     ; 008A8
sub_013_008AA:
        move.l  (a2)+,d0                        ; 008AA
        lea.l   (VertexBuffer).l,a3             ; 008AC
        movem.w $6(a3),d1-d3                    ; 008B2
        cmp.w   d3,d1                           ; 008B8
        bgt.b   l_013_008A6                     ; 008BA
        neg.w   d1                              ; 008BC
        cmp.w   d3,d1                           ; 008BE
        bgt.b   l_013_008A6                     ; 008C0
        cmp.w   d3,d2                           ; 008C2
        bgt.b   l_013_008A6                     ; 008C4
        neg.w   d2                              ; 008C6
        cmp.w   d3,d2                           ; 008C8
        bgt.b   l_013_008A6                     ; 008CA
        lea.l   (PolygonBuffer).l,a0            ; 008CC
        move.l  #$3,(a0)+                       ; 008D2
        move.w  (dat_071_00442).l,d6            ; 008D8
        move.w  (dat_071_00446).l,d7            ; 008DE
        neg.w   d6                              ; 008E4
        neg.w   d7                              ; 008E6
        move.w  (dat_071_004FA).l,d2            ; 008E8
        move.w  (dat_071_004FE).l,d3            ; 008EE
        move.w  (dat_071_00488).l,d5            ; 008F4
        asl.w   d5,d2                           ; 008FA
        asl.w   d5,d3                           ; 008FC
        sub.w   d2,d6                           ; 008FE
        blt.b   l_013_00912                     ; 00900
        sub.w   d3,d7                           ; 00902
        bge.b   l_013_0091E                     ; 00904
        neg.w   d7                              ; 00906
l_013_00908:
        cmp.w   d6,d7                           ; 00908
        bgt.b   l_013_0090E                     ; 0090A
        swap    d0                              ; 0090C
l_013_0090E:
        move.w  d0,d7                           ; 0090E
        bra.b   l_013_00940                     ; 00910
l_013_00912:
        sub.w   d3,d7                           ; 00912
        blt.b   l_013_0091A                     ; 00914
        neg.w   d6                              ; 00916
        bra.b   l_013_00908                     ; 00918
l_013_0091A:
        neg.w   d6                              ; 0091A
        neg.w   d7                              ; 0091C
l_013_0091E:
        cmp.w   d6,d7                           ; 0091E
        bgt.b   l_013_00924                     ; 00920
        swap    d0                              ; 00922
l_013_00924:
        move.w  d0,d7                           ; 00924
        move.l  $0(a3),(a0)+                    ; 00926
        move.w  $4(a3),(a0)+                    ; 0092A
        move.l  $6(a3),(a0)+                    ; 0092E
        move.w  $a(a3),(a0)+                    ; 00932
        move.l  $18(a3),(a0)+                   ; 00936
        move.w  $1c(a3),(a0)+                   ; 0093A
        bra.b   l_013_00958                     ; 0093E
l_013_00940:
        move.l  $0(a3),(a0)+                    ; 00940
        move.w  $4(a3),(a0)+                    ; 00944
        move.l  $c(a3),(a0)+                    ; 00948
        move.w  $10(a3),(a0)+                   ; 0094C
        move.l  $12(a3),(a0)+                   ; 00950
        move.w  $16(a3),(a0)+                   ; 00954
l_013_00958:
        move.w  d7,(DrawColour).l               ; 00958
        movem.l a1-a2/a5,-(a7)                  ; 0095E
        jsr     (ClipFillPolygon).l             ; 00962
        movem.l (a7)+,a1-a2/a5                  ; 00968
        rts                                     ; 0096C
sub_013_0096E:
        movem.l a1/a5,-(a7)                     ; 0096E
        lea.l   (dat_072_03C04).l,a0            ; 00972
        lea.l   (VertexBuffer).l,a3             ; 00978
        move.w  (a2)+,d1                        ; 0097E
        lea.l   (a3,d1.w),a4                    ; 00980
        move.l  (a4)+,(a0)+                     ; 00984
        move.w  (a4),(a0)+                      ; 00986
        move.w  (a2)+,d1                        ; 00988
        lea.l   (a3,d1.w),a4                    ; 0098A
        move.l  (a4)+,(a0)+                     ; 0098E
        move.w  (a4),(a0)+                      ; 00990
        move.w  (a2)+,d1                        ; 00992
        lea.l   (a3,d1.w),a4                    ; 00994
        move.l  (a4)+,(a0)+                     ; 00998
        move.w  (a4),(a0)                       ; 0099A
        addq.w  #$1,-$32(a6)                    ; 0099C
        movea.l (a2)+,a3                        ; 009A0
        move.w  a3,d7                           ; 009A2
        jsr     (FacesCamera).l                 ; 009A4
        bne.b   l_013_009B0                     ; 009AA
        addq.w  #$1,-$34(a6)                    ; 009AC
l_013_009B0:
        move.w  (a2)+,(DrawColour).l            ; 009B0
        move.w  (a2)+,-$a(a6)                   ; 009B6
        lea.l   (VertexBuffer).l,a3             ; 009BA
l_013_009C0:
        subq.w  #$1,-$a(a6)                     ; 009C0
        blt.b   l_013_009F4                     ; 009C4
        moveq   #-1,d6                          ; 009C6
        lea.l   (dat_072_04202).l,a0            ; 009C8
        move.w  (a2)+,d1                        ; 009CE
        lea.l   (a3,d1.w),a4                    ; 009D0
        move.l  (a4)+,(a0)+                     ; 009D4
        move.w  (a4),(a0)+                      ; 009D6
        and.w   (a4),d6                         ; 009D8
        move.w  (a2)+,d1                        ; 009DA
        lea.l   (a3,d1.w),a4                    ; 009DC
        move.l  (a4)+,(a0)+                     ; 009E0
        move.w  (a4),(a0)                       ; 009E2
        and.w   (a4),d6                         ; 009E4
        bne.b   l_013_009C0                     ; 009E6
        move.l  a2,-(a7)                        ; 009E8
        jsr     (sub_035_001DA).l               ; 009EA
        movea.l (a7)+,a2                        ; 009F0
        bra.b   l_013_009C0                     ; 009F2
l_013_009F4:
        movem.l (a7)+,a1/a5                     ; 009F4
        moveq   #$1,d0                          ; 009F8
        rts                                     ; 009FA

;-------------------------------------------------------------------------------
; ShapeLineRow - Op $18: a count and two vertices: vertices evenly spaced between the two (into
; dat_072_02A00), joined by lines; used by the Golden Gate's shapes (91, 92).
;-------------------------------------------------------------------------------
ShapeLineRow:
        clr.w   -$7e(a6)                        ; 009FC
        lea.l   (VertexBuffer).l,a3             ; 00A00
        lea.l   (dat_072_02A00).l,a4            ; 00A06
        lea.l   $c(a4),a0                       ; 00A0C
        move.w  (a2)+,d0                        ; 00A10
        move.w  d0,-$30(a6)                     ; 00A12
        move.w  (a2)+,d1                        ; 00A16
        movem.w (a3,d1.w),d2-d4                 ; 00A18
        move.w  (a2)+,d1                        ; 00A1E
        movem.w (a3,d1.w),d5-d7                 ; 00A20
        ext.l   d2                              ; 00A26
        asl.l   #$4,d2                          ; 00A28
        ext.l   d3                              ; 00A2A
        asl.l   #$4,d3                          ; 00A2C
        ext.l   d4                              ; 00A2E
        asl.l   #$4,d4                          ; 00A30
        ext.l   d5                              ; 00A32
        asl.l   #$4,d5                          ; 00A34
        ext.l   d6                              ; 00A36
        asl.l   #$4,d6                          ; 00A38
        ext.l   d7                              ; 00A3A
        asl.l   #$4,d7                          ; 00A3C
        sub.l   d2,d5                           ; 00A3E
        sub.l   d3,d6                           ; 00A40
        sub.l   d4,d7                           ; 00A42
        divs.w  d0,d5                           ; 00A44
        divs.w  d0,d6                           ; 00A46
        divs.w  d0,d7                           ; 00A48
        ext.l   d5                              ; 00A4A
        ext.l   d6                              ; 00A4C
        ext.l   d7                              ; 00A4E
        move.w  d0,d1                           ; 00A50
        subq.w  #$2,d0                          ; 00A52
l_013_00A54:
        add.l   d5,d2                           ; 00A54
        add.l   d6,d3                           ; 00A56
        add.l   d7,d4                           ; 00A58
        movem.l d2-d4,(a4)                      ; 00A5A
        adda.w  #$18,a4                         ; 00A5E
        dbra    d0,l_013_00A54                  ; 00A62
        move.w  (a2)+,d0                        ; 00A66
        movem.w (a3,d0.w),d2-d4                 ; 00A68
        move.w  (a2)+,d0                        ; 00A6E
        movem.w (a3,d0.w),d5-d7                 ; 00A70
        ext.l   d2                              ; 00A76
        asl.l   #$4,d2                          ; 00A78
        ext.l   d3                              ; 00A7A
        asl.l   #$4,d3                          ; 00A7C
        ext.l   d4                              ; 00A7E
        asl.l   #$4,d4                          ; 00A80
        ext.l   d5                              ; 00A82
        asl.l   #$4,d5                          ; 00A84
        ext.l   d6                              ; 00A86
        asl.l   #$4,d6                          ; 00A88
        ext.l   d7                              ; 00A8A
        asl.l   #$4,d7                          ; 00A8C
        sub.l   d2,d5                           ; 00A8E
        sub.l   d3,d6                           ; 00A90
        sub.l   d4,d7                           ; 00A92
        divs.w  d1,d5                           ; 00A94
        divs.w  d1,d6                           ; 00A96
        divs.w  d1,d7                           ; 00A98
        ext.l   d5                              ; 00A9A
        ext.l   d6                              ; 00A9C
        ext.l   d7                              ; 00A9E
        subq.w  #$2,d1                          ; 00AA0
l_013_00AA2:
        add.l   d5,d2                           ; 00AA2
        add.l   d6,d3                           ; 00AA4
        add.l   d7,d4                           ; 00AA6
        movem.l d2-d4,(a0)                      ; 00AA8
        adda.w  #$18,a0                         ; 00AAC
        dbra    d1,l_013_00AA2                  ; 00AB0
        move.w  (a2)+,(DrawColour).l            ; 00AB4
        movem.l a1-a2/a5,-(a7)                  ; 00ABA
        lea.l   (dat_072_02A00).l,a4            ; 00ABE
        subq.w  #$1,-$30(a6)                    ; 00AC4
l_013_00AC8:
        movem.l (a4)+,d1-d6                     ; 00AC8
        asr.l   #$4,d1                          ; 00ACC
        bcc.b   l_013_00AD2                     ; 00ACE
        addq.w  #$1,d1                          ; 00AD0
l_013_00AD2:
        asr.l   #$4,d2                          ; 00AD2
        bcc.b   l_013_00AD8                     ; 00AD4
        addq.w  #$1,d2                          ; 00AD6
l_013_00AD8:
        asr.l   #$4,d3                          ; 00AD8
        bcc.b   l_013_00ADE                     ; 00ADA
        addq.w  #$1,d3                          ; 00ADC
l_013_00ADE:
        asr.l   #$4,d4                          ; 00ADE
        bcc.b   l_013_00AE4                     ; 00AE0
        addq.w  #$1,d4                          ; 00AE2
l_013_00AE4:
        asr.l   #$4,d5                          ; 00AE4
        bcc.b   l_013_00AEA                     ; 00AE6
        addq.w  #$1,d5                          ; 00AE8
l_013_00AEA:
        asr.l   #$4,d6                          ; 00AEA
        bcc.b   l_013_00AF0                     ; 00AEC
        addq.w  #$1,d6                          ; 00AEE
l_013_00AF0:
        movem.w d1-d6,(dat_072_04202).l         ; 00AF0
        move.l  a4,-(a7)                        ; 00AF8
        jsr     (sub_035_001DA).l               ; 00AFA
        or.w    d0,-$7e(a6)                     ; 00B00
        movea.l (a7)+,a4                        ; 00B04
        subq.w  #$1,-$30(a6)                    ; 00B06
        bgt.b   l_013_00AC8                     ; 00B0A
        movem.l (a7)+,a1-a2/a5                  ; 00B0C
        move.w  -$7e(a6),d0                     ; 00B10
        rts                                     ; 00B14

;-------------------------------------------------------------------------------
; ShapeCockpitFlag - Op $84: sets the drawing's flag -$7A(a6) when the view is from the cockpit
; and the viewed object's +$04 bit 6 is set (the carrier models).
;-------------------------------------------------------------------------------
ShapeCockpitFlag:
        tst.b   (OutsideView).l                 ; 00B16
        bne.b   l_013_00B3A                     ; 00B1C
        lea.l   (ObjectTable).l,a3              ; 00B1E
        adda.w  (ViewObject).l,a3               ; 00B24
        move.b  $4(a3),d1                       ; 00B2A
        andi.b  #$40,d1                         ; 00B2E
        beq.b   l_013_00B3A                     ; 00B32
        move.w  #$1,-$7a(a6)                    ; 00B34
l_013_00B3A:
        moveq   #$0,d0                          ; 00B3A
        rts                                     ; 00B3C
l_013_00B3E:
        moveq   #$0,d0                          ; 00B3E
        rts                                     ; 00B40

;-------------------------------------------------------------------------------
; ShapeSceneryTest - Op $7C: works on the scenery record (dat_071_00402) when the view is low
; (dat_071_00448 above -$140) and dat_071_0023C is clear; used with the window grids (not
; worked out).
;-------------------------------------------------------------------------------
ShapeSceneryTest:
        movea.l (dat_071_00402).l,a3            ; 00B42
        adda.w  #$a,a3                          ; 00B48
        adda.w  (a2)+,a3                        ; 00B4C
        cmpi.l  #$fffffec0,(dat_071_00448).l    ; 00B4E
        ble.b   l_013_00B3E                     ; 00B58
        tst.b   (dat_071_0023C).l               ; 00B5A
        bne.b   l_013_00B3E                     ; 00B60
sub_013_00B62:
        move.w  (a3)+,d5                        ; 00B62
        move.w  (a3)+,d7                        ; 00B64
        sub.w   (a3)+,d5                        ; 00B66
        sub.w   (a3)+,d7                        ; 00B68
        neg.w   d5                              ; 00B6A
        neg.w   d7                              ; 00B6C
        clr.w   d6                              ; 00B6E
        move.w  #$100,d0                        ; 00B70
        jsr     (sub_020_0099A).l               ; 00B74
        movem.w d5-d7,-(a7)                     ; 00B7A
        move.w  -$26(a6),d5                     ; 00B7E
        sub.w   (dat_071_004FA).l,d5            ; 00B82
        clr.w   d6                              ; 00B88
        move.w  -$22(a6),d7                     ; 00B8A
        sub.w   (dat_071_004FE).l,d7            ; 00B8E
        move.w  #$100,d0                        ; 00B94
        jsr     (sub_020_0099A).l               ; 00B98
        movem.w (a7)+,d0-d2                     ; 00B9E
        muls.w  d5,d0                           ; 00BA2
        muls.w  d6,d1                           ; 00BA4
        muls.w  d7,d2                           ; 00BA6
        add.l   d0,d2                           ; 00BA8
        add.l   d1,d2                           ; 00BAA
        bge.b   l_013_00BB0                     ; 00BAC
        neg.l   d2                              ; 00BAE
l_013_00BB0:
        asr.l   #$4,d2                          ; 00BB0
        lea.l   (dat_013_00BEC).l,a3            ; 00BB2
        cmpi.l  #$ffffff80,(dat_071_00448).l    ; 00BB8
        bgt.b   l_013_00BCA                     ; 00BC2
        lea.l   (dat_013_00C04).l,a3            ; 00BC4
l_013_00BCA:
        move.w  -$28(a6),d0                     ; 00BCA
        asr.w   #$4,d0                          ; 00BCE
        cmpi.w  #$a,d0                          ; 00BD0
        ble.b   l_013_00BDA                     ; 00BD4
        move.w  #$b,d0                          ; 00BD6
l_013_00BDA:
        add.w   d0,d0                           ; 00BDA
        move.w  (a3,d0.w),d1                    ; 00BDC
        cmp.w   d1,d2                           ; 00BE0
        blt.b   l_013_00BE8                     ; 00BE2
        moveq   #$0,d0                          ; 00BE4
        rts                                     ; 00BE6
l_013_00BE8:
        moveq   #-1,d0                          ; 00BE8
        rts                                     ; 00BEA
dat_013_00BEC:
	dc.b	$00,$00,$00,$10,$00,$20,$01,$00,$02,$00,$04,$00,$08,$00,$0B,$00
	dc.b	$0D,$00,$0E,$00,$0F,$00,$0F,$80
dat_013_00C04:
	dc.b	$00,$00,$00,$10,$00,$20,$01,$80,$06,$00,$0C,$00,$0E,$00,$0F,$00
	dc.b	$0F,$80,$10,$00,$14,$00,$1A,$00

;-------------------------------------------------------------------------------
; ShapeLineGrid - Op $4C: a colour and a vertex: a grid of lines across the face spanned by
; three vertices (the counts in the next word) - the rows of windows on the buildings.
;-------------------------------------------------------------------------------
ShapeLineGrid:
        move.w  #$f,d0                          ; 00C1C
        move.w  #$ffff,d1                       ; 00C20
        clr.w   d2                              ; 00C24
        clr.w   d3                              ; 00C26
        movem.w d0-d3,(dat_071_000B6).l         ; 00C28
        move.w  (a2)+,(DrawColour).l            ; 00C30
        clr.w   -$7e(a6)                        ; 00C36
        lea.l   (VertexBuffer).l,a3             ; 00C3A
        adda.w  (a2)+,a3                        ; 00C40
        move.w  (a2),-$38(a6)                   ; 00C42
        move.w  (a2)+,-$3a(a6)                  ; 00C46
        movem.l a1-a2/a5,-(a7)                  ; 00C4A
        movem.w (a3)+,d1-d6                     ; 00C4E
        sub.w   (a3),d1                         ; 00C52
        sub.w   $2(a3),d2                       ; 00C54
        sub.w   $4(a3),d3                       ; 00C58
        sub.w   (a3),d4                         ; 00C5C
        sub.w   $2(a3),d5                       ; 00C5E
        sub.w   $4(a3),d6                       ; 00C62
        movem.w d1-d6,-$46(a6)                  ; 00C66
        movem.w -$40(a6),d4-d6                  ; 00C6C
        asr.w   #$1,d4                          ; 00C72
        asr.w   #$1,d5                          ; 00C74
        asr.w   #$1,d6                          ; 00C76
        movem.w (a3),d1-d3                      ; 00C78
        sub.w   d4,d1                           ; 00C7C
        sub.w   d5,d2                           ; 00C7E
        sub.w   d6,d3                           ; 00C80
        add.w   -$46(a6),d1                     ; 00C82
        add.w   -$44(a6),d2                     ; 00C86
        add.w   -$42(a6),d3                     ; 00C8A
        movem.w d1-d3,-$4c(a6)                  ; 00C8E
        clr.l   d4                              ; 00C94
        clr.l   d5                              ; 00C96
        clr.l   d6                              ; 00C98
        bra.b   l_013_00CAE                     ; 00C9A
l_013_00C9C:
        movem.w -$58(a6),d4-d6                  ; 00C9C
        add.w   -$40(a6),d4                     ; 00CA2
        add.w   -$3e(a6),d5                     ; 00CA6
        add.w   -$3c(a6),d6                     ; 00CAA
l_013_00CAE:
        movem.w d4-d6,-$58(a6)                  ; 00CAE
        asr.w   #$1,d4                          ; 00CB4
        asr.w   #$1,d5                          ; 00CB6
        asr.w   #$1,d6                          ; 00CB8
        movem.w (a3),d1-d3                      ; 00CBA
        add.w   d4,d1                           ; 00CBE
        add.w   d5,d2                           ; 00CC0
        add.w   d6,d3                           ; 00CC2
        move.w  d1,d4                           ; 00CC4
        move.w  d2,d5                           ; 00CC6
        move.w  d3,d6                           ; 00CC8
        add.w   -$46(a6),d4                     ; 00CCA
        add.w   -$44(a6),d5                     ; 00CCE
        add.w   -$42(a6),d6                     ; 00CD2
        movem.w d1-d6,(dat_072_04202).l         ; 00CD6
        move.l  a3,-(a7)                        ; 00CDE
        jsr     (sub_035_001DA).l               ; 00CE0
        or.w    d0,-$7e(a6)                     ; 00CE6
        movea.l (a7)+,a3                        ; 00CEA
        subq.w  #$1,-$38(a6)                    ; 00CEC
        bgt.b   l_013_00C9C                     ; 00CF0
        clr.l   d4                              ; 00CF2
        clr.l   d5                              ; 00CF4
        clr.l   d6                              ; 00CF6
        bra.b   l_013_00D0C                     ; 00CF8
l_013_00CFA:
        movem.w -$58(a6),d4-d6                  ; 00CFA
        add.w   -$40(a6),d4                     ; 00D00
        add.w   -$3e(a6),d5                     ; 00D04
        add.w   -$3c(a6),d6                     ; 00D08
l_013_00D0C:
        movem.w d4-d6,-$58(a6)                  ; 00D0C
        asr.w   #$1,d4                          ; 00D12
        asr.w   #$1,d5                          ; 00D14
        asr.w   #$1,d6                          ; 00D16
        movem.w -$4c(a6),d1-d3                  ; 00D18
        sub.w   d4,d1                           ; 00D1E
        sub.w   d5,d2                           ; 00D20
        sub.w   d6,d3                           ; 00D22
        move.w  d1,d4                           ; 00D24
        move.w  d2,d5                           ; 00D26
        move.w  d3,d6                           ; 00D28
        sub.w   -$46(a6),d4                     ; 00D2A
        sub.w   -$44(a6),d5                     ; 00D2E
        sub.w   -$42(a6),d6                     ; 00D32
        movem.w d1-d6,(dat_072_04202).l         ; 00D36
        jsr     (sub_035_001DA).l               ; 00D3E
        or.w    d0,-$7e(a6)                     ; 00D44
        subq.w  #$1,-$3a(a6)                    ; 00D48
        bgt.b   l_013_00CFA                     ; 00D4C
        movem.l (a7)+,a1-a2/a5                  ; 00D4E
        move.w  -$7e(a6),d0                     ; 00D52
        rts                                     ; 00D56
sub_013_00D58:
        move.l  #$fffff,(dat_071_000B6).l       ; 00D58
        move.w  (a2)+,(DrawColour).l            ; 00D62
        bra.b   l_013_00D88                     ; 00D68

;-------------------------------------------------------------------------------
; ShapePaneGrid - Op $50: a grid of small panes (colour 13, pattern 2,0,2,0) across the face
; spanned by three vertices - windows.
;-------------------------------------------------------------------------------
ShapePaneGrid:
        move.w  #$d,(DrawColour).l              ; 00D6A
        move.w  #$2,d0                          ; 00D72
        move.w  #$0,d1                          ; 00D76
        move.w  #$2,d2                          ; 00D7A
        clr.w   d3                              ; 00D7E
        movem.w d0-d3,(dat_071_000B6).l         ; 00D80
l_013_00D88:
        lea.l   (VertexBuffer).l,a3             ; 00D88
        adda.w  (a2)+,a3                        ; 00D8E
        move.w  (a2),-$38(a6)                   ; 00D90
        move.w  (a2)+,-$3a(a6)                  ; 00D94
        movem.l a1-a2/a5,-(a7)                  ; 00D98
        movem.w (a3)+,d1-d6                     ; 00D9C
        lea.l   $6(a3),a4                       ; 00DA0
        sub.w   (a3),d1                         ; 00DA4
        sub.w   $2(a3),d2                       ; 00DA6
        sub.w   $4(a3),d3                       ; 00DAA
        sub.w   (a3),d4                         ; 00DAE
        sub.w   $2(a3),d5                       ; 00DB0
        sub.w   $4(a3),d6                       ; 00DB4
        movem.w d1-d6,-$46(a6)                  ; 00DB8
        asr.w   #$1,d4                          ; 00DBE
        asr.w   #$1,d5                          ; 00DC0
        asr.w   #$1,d6                          ; 00DC2
        movem.w (a3),d1-d3                      ; 00DC4
        sub.w   d4,d1                           ; 00DC8
        sub.w   d5,d2                           ; 00DCA
        sub.w   d6,d3                           ; 00DCC
        add.w   -$46(a6),d1                     ; 00DCE
        add.w   -$44(a6),d2                     ; 00DD2
        add.w   -$42(a6),d3                     ; 00DD6
        movem.w d1-d3,-$4c(a6)                  ; 00DDA
        movem.w (a4),d1-d3                      ; 00DE0
        sub.w   d4,d1                           ; 00DE4
        sub.w   d5,d2                           ; 00DE6
        sub.w   d6,d3                           ; 00DE8
        add.w   -$46(a6),d1                     ; 00DEA
        add.w   -$44(a6),d2                     ; 00DEE
        add.w   -$42(a6),d3                     ; 00DF2
        movem.w d1-d3,-$52(a6)                  ; 00DF6
        clr.w   -$7e(a6)                        ; 00DFC
        lea.l   (PolygonBuffer).l,a0            ; 00E00
        move.l  #$4,(a0)+                       ; 00E06
        clr.w   d4                              ; 00E0C
        clr.w   d5                              ; 00E0E
        clr.w   d6                              ; 00E10
        bra.b   l_013_00E26                     ; 00E12
l_013_00E14:
        movem.w -$58(a6),d4-d6                  ; 00E14
        add.w   -$40(a6),d4                     ; 00E1A
        add.w   -$3e(a6),d5                     ; 00E1E
        add.w   -$3c(a6),d6                     ; 00E22
l_013_00E26:
        movem.w d4-d6,-$58(a6)                  ; 00E26
        lea.l   (dat_072_03C04).l,a0            ; 00E2C
        movem.w (a3),d1-d3                      ; 00E32
        asr.w   #$1,d4                          ; 00E36
        asr.w   #$1,d5                          ; 00E38
        asr.w   #$1,d6                          ; 00E3A
        add.w   d4,d1                           ; 00E3C
        add.w   d5,d2                           ; 00E3E
        add.w   d6,d3                           ; 00E40
        move.w  d1,d4                           ; 00E42
        move.w  d2,d5                           ; 00E44
        move.w  d3,d6                           ; 00E46
        add.w   -$46(a6),d4                     ; 00E48
        add.w   -$44(a6),d5                     ; 00E4C
        add.w   -$42(a6),d6                     ; 00E50
        movem.w d1-d6,(a0)                      ; 00E54
        adda.w  #$c,a0                          ; 00E58
        movem.w (a4),d4-d6                      ; 00E5C
        movem.w -$58(a6),d1-d3                  ; 00E60
        asr.w   #$1,d1                          ; 00E66
        asr.w   #$1,d2                          ; 00E68
        asr.w   #$1,d3                          ; 00E6A
        add.w   d1,d4                           ; 00E6C
        add.w   d2,d5                           ; 00E6E
        add.w   d3,d6                           ; 00E70
        move.w  d4,d1                           ; 00E72
        move.w  d5,d2                           ; 00E74
        move.w  d6,d3                           ; 00E76
        add.w   -$46(a6),d1                     ; 00E78
        add.w   -$44(a6),d2                     ; 00E7C
        add.w   -$42(a6),d3                     ; 00E80
        movem.w d1-d6,(a0)                      ; 00E84
        movem.l a3-a4,-(a7)                     ; 00E88
        jsr     (sub_019_00018).l               ; 00E8C
        or.w    d0,-$7e(a6)                     ; 00E92
        movem.l (a7)+,a3-a4                     ; 00E96
        subq.w  #$1,-$38(a6)                    ; 00E9A
        bgt.w   l_013_00E14                     ; 00E9E
        clr.w   d4                              ; 00EA2
        clr.w   d5                              ; 00EA4
        clr.w   d6                              ; 00EA6
        bra.b   l_013_00EBC                     ; 00EA8
l_013_00EAA:
        movem.w -$58(a6),d4-d6                  ; 00EAA
        add.w   -$40(a6),d4                     ; 00EB0
        add.w   -$3e(a6),d5                     ; 00EB4
        add.w   -$3c(a6),d6                     ; 00EB8
l_013_00EBC:
        movem.w d4-d6,-$58(a6)                  ; 00EBC
        lea.l   (dat_072_03C04).l,a0            ; 00EC2
        movem.w -$4c(a6),d1-d3                  ; 00EC8
        asr.w   #$1,d4                          ; 00ECE
        asr.w   #$1,d5                          ; 00ED0
        asr.w   #$1,d6                          ; 00ED2
        sub.w   d4,d1                           ; 00ED4
        sub.w   d5,d2                           ; 00ED6
        sub.w   d6,d3                           ; 00ED8
        move.w  d1,d4                           ; 00EDA
        move.w  d2,d5                           ; 00EDC
        move.w  d3,d6                           ; 00EDE
        sub.w   -$46(a6),d4                     ; 00EE0
        sub.w   -$44(a6),d5                     ; 00EE4
        sub.w   -$42(a6),d6                     ; 00EE8
        movem.w d1-d6,(a0)                      ; 00EEC
        adda.w  #$c,a0                          ; 00EF0
        movem.w -$52(a6),d4-d6                  ; 00EF4
        movem.w -$58(a6),d1-d3                  ; 00EFA
        asr.w   #$1,d1                          ; 00F00
        asr.w   #$1,d2                          ; 00F02
        asr.w   #$1,d3                          ; 00F04
        sub.w   d1,d4                           ; 00F06
        sub.w   d2,d5                           ; 00F08
        sub.w   d3,d6                           ; 00F0A
        move.w  d4,d1                           ; 00F0C
        move.w  d5,d2                           ; 00F0E
        move.w  d6,d3                           ; 00F10
        sub.w   -$46(a6),d1                     ; 00F12
        sub.w   -$44(a6),d2                     ; 00F16
        sub.w   -$42(a6),d3                     ; 00F1A
        movem.w d1-d6,(a0)                      ; 00F1E
        jsr     (sub_019_00018).l               ; 00F22
        subq.w  #$1,-$3a(a6)                    ; 00F28
        bgt.w   l_013_00EAA                     ; 00F2C
        movem.l (a7)+,a1-a2/a5                  ; 00F30
        move.w  -$7e(a6),d0                     ; 00F34
        rts                                     ; 00F38

;-------------------------------------------------------------------------------
; ShapePaneGridColour - Op $E4: ShapePaneGrid2 in a given colour (solid pattern).
;-------------------------------------------------------------------------------
ShapePaneGridColour:
        movem.l a1/a5,-(a7)                     ; 00F3A
        move.l  #$fffff,(dat_071_000B6).l       ; 00F3E
        move.w  (a2)+,(DrawColour).l            ; 00F48
        bra.b   l_013_00F72                     ; 00F4E

;-------------------------------------------------------------------------------
; ShapePaneGrid2 - Op $54: as ShapePaneGrid, the face given the other way round.
;-------------------------------------------------------------------------------
ShapePaneGrid2:
        movem.l a1/a5,-(a7)                     ; 00F50
        move.w  #$d,(DrawColour).l              ; 00F54
        move.w  #$2,d0                          ; 00F5C
        move.w  #$0,d1                          ; 00F60
        move.w  #$2,d2                          ; 00F64
        clr.w   d3                              ; 00F68
        movem.w d0-d3,(dat_071_000B6).l         ; 00F6A
l_013_00F72:
        lea.l   (VertexBuffer).l,a3             ; 00F72
        adda.w  (a2)+,a3                        ; 00F78
        move.w  (a2)+,-$38(a6)                  ; 00F7A
        movem.w (a3)+,d1-d6                     ; 00F7E
        sub.w   $6(a3),d1                       ; 00F82
        sub.w   $8(a3),d2                       ; 00F86
        sub.w   $a(a3),d3                       ; 00F8A
        sub.w   $6(a3),d4                       ; 00F8E
        sub.w   $8(a3),d5                       ; 00F92
        sub.w   $a(a3),d6                       ; 00F96
        movem.w d1-d6,-$46(a6)                  ; 00F9A
        movem.w (a3)+,d1-d3                     ; 00FA0
        sub.w   (a3),d1                         ; 00FA4
        sub.w   $2(a3),d2                       ; 00FA6
        sub.w   $4(a3),d3                       ; 00FAA
        movem.w d1-d3,-$52(a6)                  ; 00FAE
        clr.w   -$7e(a6)                        ; 00FB4
        lea.l   (PolygonBuffer).l,a0            ; 00FB8
        move.l  #$4,(a0)+                       ; 00FBE
        bra.b   l_013_00FC8                     ; 00FC4
l_013_00FC6:
        addq.w  #$6,a3                          ; 00FC6
l_013_00FC8:
        move.w  (a2)+,-$3a(a6)                  ; 00FC8
        clr.w   d4                              ; 00FCC
        clr.w   d5                              ; 00FCE
        clr.w   d6                              ; 00FD0
        bra.b   l_013_00FE6                     ; 00FD2
l_013_00FD4:
        movem.w -$58(a6),d4-d6                  ; 00FD4
        add.w   -$40(a6),d4                     ; 00FDA
        add.w   -$3e(a6),d5                     ; 00FDE
        add.w   -$3c(a6),d6                     ; 00FE2
l_013_00FE6:
        movem.w d4-d6,-$58(a6)                  ; 00FE6
        lea.l   (dat_072_03C04).l,a0            ; 00FEC
        movem.w (a3),d1-d3                      ; 00FF2
        asr.w   #$1,d4                          ; 00FF6
        asr.w   #$1,d5                          ; 00FF8
        asr.w   #$1,d6                          ; 00FFA
        add.w   d4,d1                           ; 00FFC
        add.w   d5,d2                           ; 00FFE
        add.w   d6,d3                           ; 01000
        move.w  d1,d4                           ; 01002
        move.w  d2,d5                           ; 01004
        move.w  d3,d6                           ; 01006
        add.w   -$46(a6),d4                     ; 01008
        add.w   -$44(a6),d5                     ; 0100C
        add.w   -$42(a6),d6                     ; 01010
        movem.w d1-d6,(a0)                      ; 01014
        adda.w  #$c,a0                          ; 01018
        movem.w (a3),d4-d6                      ; 0101C
        add.w   -$52(a6),d4                     ; 01020
        add.w   -$50(a6),d5                     ; 01024
        add.w   -$4e(a6),d6                     ; 01028
        movem.w -$58(a6),d1-d3                  ; 0102C
        asr.w   #$1,d1                          ; 01032
        asr.w   #$1,d2                          ; 01034
        asr.w   #$1,d3                          ; 01036
        add.w   d1,d4                           ; 01038
        add.w   d2,d5                           ; 0103A
        add.w   d3,d6                           ; 0103C
        move.w  d4,d1                           ; 0103E
        move.w  d5,d2                           ; 01040
        move.w  d6,d3                           ; 01042
        add.w   -$46(a6),d1                     ; 01044
        add.w   -$44(a6),d2                     ; 01048
        add.w   -$42(a6),d3                     ; 0104C
        movem.w d1-d6,(a0)                      ; 01050
        movem.l a2-a3,-(a7)                     ; 01054
        jsr     (sub_019_00018).l               ; 01058
        or.w    d0,-$7e(a6)                     ; 0105E
        movem.l (a7)+,a2-a3                     ; 01062
        subq.w  #$1,-$3a(a6)                    ; 01066
        bgt.w   l_013_00FD4                     ; 0106A
        subq.w  #$1,-$38(a6)                    ; 0106E
        bgt.w   l_013_00FC6                     ; 01072
        movem.l (a7)+,a1/a5                     ; 01076
        move.w  -$7e(a6),d0                     ; 0107A
        rts                                     ; 0107E

;-------------------------------------------------------------------------------
; ShapeLineGridColour - Op $58: as ShapeLineGrid, in a given colour.
;-------------------------------------------------------------------------------
ShapeLineGridColour:
        movem.l a1/a5,-(a7)                     ; 01080
        move.w  #$f,d0                          ; 01084
        move.w  #$ffff,d1                       ; 01088
        clr.w   d2                              ; 0108C
        clr.w   d3                              ; 0108E
        movem.w d0-d3,(dat_071_000B6).l         ; 01090
        move.w  (a2)+,(DrawColour).l            ; 01098
        lea.l   (VertexBuffer).l,a3             ; 0109E
        adda.w  (a2)+,a3                        ; 010A4
        move.w  (a2)+,-$38(a6)                  ; 010A6
        movem.w (a3)+,d1-d6                     ; 010AA
        sub.w   (a3),d1                         ; 010AE
        sub.w   $2(a3),d2                       ; 010B0
        sub.w   $4(a3),d3                       ; 010B4
        movem.w d1-d3,-$40(a6)                  ; 010B8
        sub.w   (a3),d4                         ; 010BE
        sub.w   $2(a3),d5                       ; 010C0
        sub.w   $4(a3),d6                       ; 010C4
        movem.w d4-d6,-$52(a6)                  ; 010C8
        clr.w   -$7e(a6)                        ; 010CE
        bra.b   l_013_010D6                     ; 010D2
l_013_010D4:
        addq.w  #$6,a3                          ; 010D4
l_013_010D6:
        move.w  (a2)+,-$3a(a6)                  ; 010D6
        clr.w   d4                              ; 010DA
        clr.w   d5                              ; 010DC
        clr.w   d6                              ; 010DE
        bra.b   l_013_010F4                     ; 010E0
l_013_010E2:
        movem.w -$58(a6),d4-d6                  ; 010E2
        add.w   -$40(a6),d4                     ; 010E8
        add.w   -$3e(a6),d5                     ; 010EC
        add.w   -$3c(a6),d6                     ; 010F0
l_013_010F4:
        movem.w d4-d6,-$58(a6)                  ; 010F4
        movem.w (a3),d1-d3                      ; 010FA
        asr.w   #$1,d4                          ; 010FE
        asr.w   #$1,d5                          ; 01100
        asr.w   #$1,d6                          ; 01102
        add.w   d4,d1                           ; 01104
        add.w   d5,d2                           ; 01106
        add.w   d6,d3                           ; 01108
        movem.w d1-d3,(dat_072_04202).l         ; 0110A
        movem.w (a3),d1-d3                      ; 01112
        add.w   -$52(a6),d1                     ; 01116
        add.w   -$50(a6),d2                     ; 0111A
        add.w   -$4e(a6),d3                     ; 0111E
        add.w   d4,d1                           ; 01122
        add.w   d5,d2                           ; 01124
        add.w   d6,d3                           ; 01126
        movem.w d1-d3,(dat_072_04208).l         ; 01128
        movem.l a2-a3,-(a7)                     ; 01130
        jsr     (sub_035_001DA).l               ; 01134
        or.w    d0,-$7e(a6)                     ; 0113A
        movem.l (a7)+,a2-a3                     ; 0113E
        subq.w  #$1,-$3a(a6)                    ; 01142
        bgt.b   l_013_010E2                     ; 01146
        subq.w  #$1,-$38(a6)                    ; 01148
        bgt.b   l_013_010D4                     ; 0114C
        movem.l (a7)+,a1/a5                     ; 0114E
        move.w  -$7e(a6),d0                     ; 01152
        rts                                     ; 01156
sub_013_01158:
        move.w  #$2,d0                          ; 01158
        move.w  #$0,d1                          ; 0115C
        move.w  #$2,d2                          ; 01160
        bra.b   l_013_01170                     ; 01164

;-------------------------------------------------------------------------------
; ShapeParallelogramPat - Op $78: a colour and a vertex: a parallelogram of three consecutive
; vertices and a fourth made from them, filled with pattern 8,8,0,0 (the ground shapes'
; patterned fields).
;-------------------------------------------------------------------------------
ShapeParallelogramPat:
        move.w  #$8,d0                          ; 01166
        move.w  #$8,d1                          ; 0116A
        clr.w   d2                              ; 0116E
l_013_01170:
        clr.w   d3                              ; 01170
        movem.w d0-d3,(dat_071_000B6).l         ; 01172
        move.w  (a2)+,(DrawColour).l            ; 0117A
        lea.l   (VertexBuffer).l,a3             ; 01180
        adda.w  (a2)+,a3                        ; 01186
        movem.l a1-a2/a5,-(a7)                  ; 01188
        lea.l   (PolygonBuffer).l,a0            ; 0118C
        move.l  #$4,(a0)+                       ; 01192
        movem.w (a3)+,d2-d7                     ; 01198
        movem.w d2-d7,(a0)                      ; 0119C
        move.w  d4,d0                           ; 011A0
        and.w   d7,d0                           ; 011A2
        adda.w  #$c,a0                          ; 011A4
        sub.w   d2,d5                           ; 011A8
        sub.w   d3,d6                           ; 011AA
        sub.w   d4,d7                           ; 011AC
        movem.w (a3),d2-d4                      ; 011AE
        and.w   d4,d0                           ; 011B2
        movem.w d2-d4,(a0)                      ; 011B4
        addq.w  #$6,a0                          ; 011B8
        sub.w   d5,d2                           ; 011BA
        sub.w   d6,d3                           ; 011BC
        sub.w   d7,d4                           ; 011BE
        and.w   d4,d0                           ; 011C0
        blt.b   l_013_011D4                     ; 011C2
        movem.w d2-d4,(a0)                      ; 011C4
        jsr     (sub_019_00018).l               ; 011C8
        movem.l (a7)+,a1-a2/a5                  ; 011CE
        rts                                     ; 011D2
l_013_011D4:
        movem.l (a7)+,a1-a2/a5                  ; 011D4
        moveq   #$0,d0                          ; 011D8
        rts                                     ; 011DA

;-------------------------------------------------------------------------------
; ShapeMakeVertices - Op $88: a vertex offset and a shift: computes further vertices from the
; ones after it (edge differences scaled by the shift) into VertexBuffer.
;-------------------------------------------------------------------------------
ShapeMakeVertices:
        lea.l   (VertexBuffer).l,a3             ; 011DC
        adda.w  (a2)+,a3                        ; 011E2
        movem.w $6(a3),d0-d7/a4                 ; 011E4
        sub.w   d3,d0                           ; 011EA
        sub.w   d4,d1                           ; 011EC
        sub.w   d5,d2                           ; 011EE
        sub.w   d6,d3                           ; 011F0
        sub.w   d7,d4                           ; 011F2
        sub.w   a4,d5                           ; 011F4
        swap    d0                              ; 011F6
        move.w  (a2)+,d0                        ; 011F8
        bge.b   l_013_01206                     ; 011FA
        neg.w   d0                              ; 011FC
        asr.w   d0,d3                           ; 011FE
        asr.w   d0,d4                           ; 01200
        asr.w   d0,d5                           ; 01202
        bra.b   l_013_0120C                     ; 01204
l_013_01206:
        asl.w   d0,d3                           ; 01206
        asl.w   d0,d4                           ; 01208
        asl.w   d0,d5                           ; 0120A
l_013_0120C:
        swap    d0                              ; 0120C
        sub.w   d3,d6                           ; 0120E
        sub.w   d4,d7                           ; 01210
        suba.w  d5,a4                           ; 01212
        movem.w d6-d7/a4,$30(a3)                ; 01214
        sub.w   d0,d6                           ; 0121A
        sub.w   d1,d7                           ; 0121C
        suba.w  d2,a4                           ; 0121E
        movem.w d6-d7/a4,$36(a3)                ; 01220
        bra.b   l_013_01230                     ; 01226
sub_013_01228:
        lea.l   (VertexBuffer).l,a3             ; 01228
        adda.w  (a2)+,a3                        ; 0122E
l_013_01230:
        movem.w (a3)+,d0-d7/a4                  ; 01230
        sub.w   d3,d0                           ; 01234
        sub.w   d4,d1                           ; 01236
        sub.w   d5,d2                           ; 01238
        add.w   d0,d6                           ; 0123A
        add.w   d1,d7                           ; 0123C
        adda.w  d2,a4                           ; 0123E
        movem.w d6-d7/a4,$6(a3)                 ; 01240
        movem.w (a3)+,d6-d7/a4                  ; 01246
        add.w   d0,d6                           ; 0124A
        add.w   d1,d7                           ; 0124C
        adda.w  d2,a4                           ; 0124E
        movem.w d6-d7/a4,$6(a3)                 ; 01250
        swap    d0                              ; 01256
        swap    d1                              ; 01258
        swap    d2                              ; 0125A
        move.w  d3,d0                           ; 0125C
        move.w  d4,d1                           ; 0125E
        move.w  d5,d2                           ; 01260
        movem.w -$c(a3),d3-d7/a4                ; 01262
        sub.w   d0,d3                           ; 01268
        sub.w   d1,d4                           ; 0126A
        sub.w   d2,d5                           ; 0126C
        add.w   d3,d6                           ; 0126E
        add.w   d4,d7                           ; 01270
        adda.w  d5,a4                           ; 01272
        movem.w d6-d7/a4,$c(a3)                 ; 01274
        swap    d0                              ; 0127A
        swap    d1                              ; 0127C
        swap    d2                              ; 0127E
        add.w   d0,d6                           ; 01280
        add.w   d1,d7                           ; 01282
        adda.w  d2,a4                           ; 01284
        movem.w d6-d7/a4,$12(a3)                ; 01286
        moveq   #$0,d0                          ; 0128C
        rts                                     ; 0128E

;-------------------------------------------------------------------------------
; ShapeMakeVertices2 - Op $90: as ShapeMakeVertices, from the vertices $C bytes on (Coit
; Tower).
;-------------------------------------------------------------------------------
ShapeMakeVertices2:
        lea.l   (VertexBuffer).l,a3             ; 01290
        adda.w  (a2)+,a3                        ; 01296
        movem.w $c(a3),d0-d7/a4                 ; 01298
        sub.w   d3,d0                           ; 0129E
        sub.w   d4,d1                           ; 012A0
        sub.w   d5,d2                           ; 012A2
        sub.w   d6,d3                           ; 012A4
        sub.w   d7,d4                           ; 012A6
        sub.w   a4,d5                           ; 012A8
        swap    d0                              ; 012AA
        move.w  (a2)+,d0                        ; 012AC
        bge.b   l_013_012BA                     ; 012AE
        neg.w   d0                              ; 012B0
        asr.w   d0,d3                           ; 012B2
        asr.w   d0,d4                           ; 012B4
        asr.w   d0,d5                           ; 012B6
        bra.b   l_013_012C0                     ; 012B8
l_013_012BA:
        asl.w   d0,d3                           ; 012BA
        asl.w   d0,d4                           ; 012BC
        asl.w   d0,d5                           ; 012BE
l_013_012C0:
        swap    d0                              ; 012C0
        sub.w   d3,d6                           ; 012C2
        sub.w   d4,d7                           ; 012C4
        suba.w  d5,a4                           ; 012C6
        movem.w d6-d7/a4,$48(a3)                ; 012C8
        sub.w   d0,d6                           ; 012CE
        sub.w   d1,d7                           ; 012D0
        suba.w  d2,a4                           ; 012D2
        movem.w d6-d7/a4,$4e(a3)                ; 012D4
        bra.b   l_013_012E4                     ; 012DA
sub_013_012DC:
        lea.l   (VertexBuffer).l,a3             ; 012DC
        adda.w  (a2)+,a3                        ; 012E2
l_013_012E4:
        movem.w (a3)+,d0-d7/a4                  ; 012E4
        sub.w   d3,d0                           ; 012E8
        sub.w   d4,d1                           ; 012EA
        sub.w   d5,d2                           ; 012EC
        add.w   d0,d6                           ; 012EE
        add.w   d1,d7                           ; 012F0
        adda.w  d2,a4                           ; 012F2
        movem.w d6-d7/a4,$12(a3)                ; 012F4
        movem.w (a3)+,d6-d7/a4                  ; 012FA
        add.w   d0,d6                           ; 012FE
        add.w   d1,d7                           ; 01300
        adda.w  d2,a4                           ; 01302
        movem.w d6-d7/a4,$12(a3)                ; 01304
        movem.w (a3)+,d6-d7/a4                  ; 0130A
        add.w   d0,d6                           ; 0130E
        add.w   d1,d7                           ; 01310
        adda.w  d2,a4                           ; 01312
        movem.w d6-d7/a4,$12(a3)                ; 01314
        movem.w (a3)+,d6-d7/a4                  ; 0131A
        add.w   d0,d6                           ; 0131E
        add.w   d1,d7                           ; 01320
        adda.w  d2,a4                           ; 01322
        movem.w d6-d7/a4,$12(a3)                ; 01324
        swap    d0                              ; 0132A
        swap    d1                              ; 0132C
        swap    d2                              ; 0132E
        move.w  d3,d0                           ; 01330
        move.w  d4,d1                           ; 01332
        move.w  d5,d2                           ; 01334
        movem.w -$18(a3),d3-d5                  ; 01336
        movem.w -$6(a3),d6-d7/a4                ; 0133C
        sub.w   d0,d3                           ; 01342
        sub.w   d1,d4                           ; 01344
        sub.w   d2,d5                           ; 01346
        add.w   d3,d6                           ; 01348
        add.w   d4,d7                           ; 0134A
        adda.w  d5,a4                           ; 0134C
        movem.w d6-d7/a4,$18(a3)                ; 0134E
        swap    d0                              ; 01354
        swap    d1                              ; 01356
        swap    d2                              ; 01358
        add.w   d0,d6                           ; 0135A
        add.w   d1,d7                           ; 0135C
        adda.w  d2,a4                           ; 0135E
        movem.w d6-d7/a4,$1e(a3)                ; 01360
        moveq   #$0,d0                          ; 01366
        rts                                     ; 01368
	dc.b	$00,$00
h013_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    36,13                           ; 36 longs pointing into hunk 13
	dc.l	$BC6,$BB4,$128,$124,$120,$118,$114,$110
	dc.l	$10C,$E8,$E4,$DC,$C4,$C0,$A0,$9C
	dc.l	$94,$90,$8C,$88,$84,$80,$7C,$78
	dc.l	$6C,$58,$54,$50,$4C,$18,$14,$10
	dc.l	$C,$8,$4,$0
        dc.l    70,71                           ; 70 longs pointing into hunk 71
	dc.l	$200,$20E,$692,$7BE,$854,$B5C,$520,$536
	dc.l	$564,$4FA,$58C,$740,$8F6,$B44,$516,$B18
	dc.l	$B26,$52E,$4CC,$188,$1F0,$528,$4C6,$B20
	dc.l	$182,$5DC,$5D6,$73A,$8F0,$B90,$734,$8EA
	dc.l	$B84,$72A,$8E0,$2C2,$B54,$BBE,$4C0,$724
	dc.l	$8DA,$2D8,$C2C,$D5E,$D84,$F44,$F6E,$1094
	dc.l	$1176,$14A,$16C,$29C,$300,$3F6,$4A2,$5FE
	dc.l	$75A,$776,$7B8,$84E,$95A,$9B2,$AB6,$C32
	dc.l	$D64,$D6E,$F4A,$F58,$109A,$117C
        dc.l    55,72                           ; 55 longs pointing into hunk 72
	dc.l	$A08,$AC0,$2DE,$9CA,$AF4,$CDA,$D3A,$110E
	dc.l	$112C,$224,$260,$296,$322,$376,$3C2,$422
	dc.l	$432,$480,$604,$668,$718,$7C8,$85C,$8CE
	dc.l	$974,$E02,$E2E,$EC4,$FBA,$FEE,$118E,$13E
	dc.l	$160,$22A,$266,$2E4,$31C,$380,$438,$6F4
	dc.l	$7CE,$862,$8AE,$97A,$9BC,$A02,$C3C,$D8A
	dc.l	$F74,$10A0,$1182,$11DE,$122A,$1292,$12DE
        dc.l    10,15                           ; 10 longs pointing into hunk 15
	dc.l	$104,$100,$E0,$11C,$F8,$F4,$F0,$EC
	dc.l	$74,$70
        dc.l    2,20                            ; 2 longs pointing into hunk 20
	dc.l	$B76,$B9A
        dc.l    5,10                            ; 5 longs pointing into hunk 10
	dc.l	$250,$28C,$3D2,$48C,$9A6
        dc.l    10,35                           ; 10 longs pointing into hunk 35
	dc.l	$176,$154,$2A6,$2B6,$2CE,$9EC,$AFC,$CE2
	dc.l	$D40,$1136
        dc.l    11,19                           ; 11 longs pointing into hunk 19
	dc.l	$400,$4AA,$6D8,$7AC,$842,$894,$964,$E8E
	dc.l	$F24,$105A,$11CA
        dc.l    3,12                            ; 3 longs pointing into hunk 12
	dc.l	$68,$64,$60
        dc.l    31,14                           ; 31 longs pointing into hunk 14
	dc.l	$BC,$B8,$B4,$98,$B0,$AC,$A8,$134
	dc.l	$130,$FC,$D8,$D4,$D0,$CC,$C8,$108
	dc.l	$A4,$40,$3C,$38,$34,$12C,$30,$2C
	dc.l	$28,$24,$20,$1C,$5C,$48,$44
	dc.l	0
	dc.l	HUNK_END
	endc
