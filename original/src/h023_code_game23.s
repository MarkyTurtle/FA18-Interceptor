; F/A-18 Interceptor - hunk 23 (code)
; Game logic not yet identified (objects; called by GameFrame).
; Included by ../f18_main.s.

;===============================================================================
; Hunk 23: CODE, $8C4 bytes
;===============================================================================
	CODE_HUNK	h023

;-------------------------------------------------------------------------------
; BulletInFront - d0 = 1 if a bullet in flight (from the cockpit, only one the player fired) is
; nearer the camera than the object that fired it, so it must be drawn after it.
;-------------------------------------------------------------------------------
BulletInFront:
        moveq   #$13,d0                         ; 00000
l_023_00002:
        lea.l   (Bullets).l,a0                  ; 00002
        move.w  d0,d1                           ; 00008
        asl.w   #$6,d1                          ; 0000A
        adda.w  d1,a0                           ; 0000C
        btst    #$0,$27(a0)                     ; 0000E
        bne.b   l_023_0001E                     ; 00014
        dbra    d0,l_023_00002                  ; 00016
l_023_0001A:
        moveq   #$0,d0                          ; 0001A
        rts                                     ; 0001C
l_023_0001E:
        btst    #$5,$26(a0)                     ; 0001E
        bne.b   l_023_0002E                     ; 00024
        tst.b   (OutsideView).l                 ; 00026
        beq.b   l_023_0001A                     ; 0002C
l_023_0002E:
        move.w  $2e(a0),d1                      ; 0002E
        asl.w   #$8,d1                          ; 00032
        add.w   d1,d1                           ; 00034
        lea.l   (ObjectTable).l,a1              ; 00036
        adda.w  d1,a1                           ; 0003C
        lea.l   (CameraCellOffset).l,a2         ; 0003E
        movem.l $14(a1),d2-d4                   ; 00044
        sub.l   $c(a2),d2                       ; 0004A
        bge.b   l_023_00052                     ; 0004E
        neg.l   d2                              ; 00050
l_023_00052:
        sub.l   $10(a2),d3                      ; 00052
        bge.b   l_023_0005A                     ; 00056
        neg.l   d3                              ; 00058
l_023_0005A:
        sub.l   $14(a2),d4                      ; 0005A
        bge.b   l_023_00062                     ; 0005E
        neg.l   d4                              ; 00060
l_023_00062:
        asr.l   #$8,d2                          ; 00062
        asr.l   #$8,d3                          ; 00064
        asr.l   #$8,d4                          ; 00066
        jsr     (VectorLength).l                ; 00068
        move.w  d1,-(a7)                        ; 0006E
        lea.l   (CameraCellOffset).l,a2         ; 00070
        movem.l $0(a0),d2-d4                    ; 00076
        move.w  $30(a0),d5                      ; 0007C
        ext.l   d5                              ; 00080
        swap    d5                              ; 00082
        asl.l   #$6,d5                          ; 00084
        add.l   d5,d2                           ; 00086
        move.w  $32(a0),d5                      ; 00088
        ext.l   d5                              ; 0008C
        swap    d5                              ; 0008E
        asl.l   #$6,d5                          ; 00090
        add.l   d5,d4                           ; 00092
        sub.l   $c(a2),d2                       ; 00094
        bge.b   l_023_0009C                     ; 00098
        neg.l   d2                              ; 0009A
l_023_0009C:
        sub.l   $10(a2),d3                      ; 0009C
        bge.b   l_023_000A4                     ; 000A0
        neg.l   d3                              ; 000A2
l_023_000A4:
        sub.l   $14(a2),d4                      ; 000A4
        bge.b   l_023_000AC                     ; 000A8
        neg.l   d4                              ; 000AA
l_023_000AC:
        asr.l   #$8,d2                          ; 000AC
        asr.l   #$8,d3                          ; 000AE
        asr.l   #$8,d4                          ; 000B0
        jsr     (VectorLength).l                ; 000B2
        move.w  (a7)+,d2                        ; 000B8
        cmp.w   d1,d2                           ; 000BA
        bgt.w   l_023_0001A                     ; 000BC
        moveq   #$1,d0                          ; 000C0
        rts                                     ; 000C2
l_023_000C4:
        rts                                     ; 000C4

;-------------------------------------------------------------------------------
; BulletHitTest - Whether a bullet (its number on the stack) hit an object or a scenery shape
; near it: the objects in its cell (within $800, or BulletHitRange) and the drawing list's
; shapes. d0 = 1 for a hit (BulletHitObject the object hit).
;-------------------------------------------------------------------------------
BulletHitTest:
        moveq   #$0,d0                          ; 000C6
        move.b  (BulletsHeld).l,d1              ; 000C8
        or.b    (WorldFrozen).l,d1              ; 000CE
        bne.b   l_023_000C4                     ; 000D4
        link.w  a6,#$ffa4                       ; 000D6
        move.l  $8(a6),d0                       ; 000DA
        asl.w   #$6,d0                          ; 000DE
        lea.l   (Bullets).l,a3                  ; 000E0
        adda.w  d0,a3                           ; 000E6
        movem.l $c(a3),d0-d2                    ; 000E8
        asr.l   #$8,d0                          ; 000EE
        asr.l   #$8,d1                          ; 000F0
        asr.l   #$8,d2                          ; 000F2
        movem.w d0-d2,(BulletTestPos).l         ; 000F4
        move.w  (BulletTestRange).l,-$12(a6)    ; 000FC
        movem.w (BulletTestFrom).l,d0-d2        ; 00104
        movem.w d0-d2,-$10(a6)                  ; 0010C
        move.w  #$0,(BulletHitObject).l         ; 00112
        lea.l   (ObjectTable).l,a0              ; 0011A
        move.w  $c(a0),-$1a(a6)                 ; 00120
        move.l  $10(a0),-$16(a6)                ; 00126
        move.w  $e(a0),-$14(a6)                 ; 0012C
        move.b  (DistanceCount2).l,d0           ; 00132
        ext.w   d0                              ; 00138
        move.w  d0,-$6(a6)                      ; 0013A
l_023_0013E:
        clr.l   -$a(a6)                         ; 0013E
        moveq   #-1,d5                          ; 00142
        movea.l (DrawListEnd).l,a5              ; 00144
l_023_0014A:
        move.w  (a5),-$2(a6)                    ; 0014A
        suba.w  #$18,a5                         ; 0014E
        addq.w  #$1,-$8(a6)                     ; 00152
        btst    #$6,-$1(a6)                     ; 00156
        bne.w   l_023_002E8                     ; 0015C
        btst    #$4,-$1(a6)                     ; 00160
        beq.w   l_023_00232                     ; 00166
        cmpi.w  #$6,-$a(a6)                     ; 0016A
        bge.w   l_023_002E8                     ; 00170
        addq.w  #$1,-$a(a6)                     ; 00174
        move.b  -$2(a6),d0                      ; 00178
        ext.w   d0                              ; 0017C
        cmp.w   $2e(a3),d0                      ; 0017E
        beq.w   l_023_002E8                     ; 00182
        move.w  d0,d2                           ; 00186
        asl.w   #$8,d0                          ; 00188
        add.w   d0,d0                           ; 0018A
        lea.l   (ObjectTable).l,a0              ; 0018C
        move.w  $6(a0,d0.w),d1                  ; 00192
        cmp.w   $30(a3),d1                      ; 00196
        bne.w   l_023_002E8                     ; 0019A
        move.w  $8(a0,d0.w),d1                  ; 0019E
        cmp.w   $32(a3),d1                      ; 001A2
        bne.w   l_023_002E8                     ; 001A6
        lea.l   (ObjectTable).l,a1              ; 001AA
        move.w  (a0,d0.w),d1                    ; 001B0
        andi.w  #$40,d1                         ; 001B4
        beq.w   l_023_002E8                     ; 001B8
        move.w  d2,(BulletHitObject).l          ; 001BC
        move.w  $c(a0,d0.w),d2                  ; 001C2
        move.l  $10(a0,d0.w),d3                 ; 001C6
        move.w  $e(a0,d0.w),d4                  ; 001CA
        movea.l $1a(a5),a0                      ; 001CE
        movea.l $4(a0),a0                       ; 001D2
        move.w  (a0),d7                         ; 001D6
        blt.b   l_023_001DE                     ; 001D8
        move.w  $4(a0),d7                       ; 001DA
l_023_001DE:
        andi.w  #$3fff,d7                       ; 001DE
        move.b  $7(a0,d7.w),d7                  ; 001E2
        move.b  d7,-$4(a6)                      ; 001E6
        andi.b  #$10,d7                         ; 001EA
        beq.b   l_023_001F6                     ; 001EE
        move.w  #$800,d7                        ; 001F0
        bra.b   l_023_001FC                     ; 001F4
l_023_001F6:
        move.w  (BulletHitRange).l,d7           ; 001F6
l_023_001FC:
        ext.l   d7                              ; 001FC
        movem.l $0(a3),d0-d1/d6                 ; 001FE
        asr.l   #$8,d0                          ; 00204
        sub.w   d0,d2                           ; 00206
        bge.b   l_023_0020C                     ; 00208
        neg.w   d2                              ; 0020A
l_023_0020C:
        cmp.w   d7,d2                           ; 0020C
        bge.w   l_023_002E8                     ; 0020E
        asr.l   #$8,d1                          ; 00212
        sub.l   d1,d3                           ; 00214
        bge.b   l_023_0021A                     ; 00216
        neg.l   d3                              ; 00218
l_023_0021A:
        cmp.l   d7,d3                           ; 0021A
        bge.w   l_023_002E8                     ; 0021C
        asr.l   #$8,d6                          ; 00220
        sub.w   d6,d4                           ; 00222
        bge.b   l_023_00228                     ; 00224
        neg.w   d4                              ; 00226
l_023_00228:
        cmp.w   d7,d4                           ; 00228
        bge.w   l_023_002E8                     ; 0022A
        bra.w   l_023_004CA                     ; 0022E
l_023_00232:
        cmpi.w  #$a,d5                          ; 00232
        bge.w   l_023_002E8                     ; 00236
        addq.w  #$1,d5                          ; 0023A
        lea.l   (dat_072_05400).l,a0            ; 0023C
        lea.l   (dat_072_0542C).l,a1            ; 00242
        move.w  d5,d0                           ; 00248
        asl.w   #$2,d0                          ; 0024A
        move.l  (a0,d0.w),d1                    ; 0024C
        blt.w   l_023_002E8                     ; 00250
        movea.l d1,a0                           ; 00254
        asl.w   #$6,d0                          ; 00256
        adda.w  d0,a1                           ; 00258
        addq.w  #$2,a1                          ; 0025A
        moveq   #$0,d0                          ; 0025C
        move.w  $30(a3),d0                      ; 0025E
        move.b  (a1)+,d2                        ; 00262
        ext.w   d2                              ; 00264
        sub.w   d2,d0                           ; 00266
        move.w  d0,d2                           ; 00268
        bge.b   l_023_0026E                     ; 0026A
        neg.w   d2                              ; 0026C
l_023_0026E:
        cmpi.w  #$1,d2                          ; 0026E
        bgt.b   l_023_002E8                     ; 00272
        move.w  $32(a3),d1                      ; 00274
        move.b  (a1)+,d2                        ; 00278
        ext.w   d2                              ; 0027A
        sub.w   d2,d1                           ; 0027C
        move.w  d1,d2                           ; 0027E
        bge.b   l_023_00284                     ; 00280
        neg.w   d2                              ; 00282
l_023_00284:
        cmpi.w  #$1,d2                          ; 00284
        bgt.b   l_023_002E8                     ; 00288
        ext.w   d0                              ; 0028A
        swap    d0                              ; 0028C
        asr.l   #$2,d0                          ; 0028E
        ext.w   d1                              ; 00290
        swap    d1                              ; 00292
        asr.l   #$2,d1                          ; 00294
        move.l  d0,-$38(a6)                     ; 00296
        move.l  d1,-$3c(a6)                     ; 0029A
        movem.l $0(a3),d0-d2                    ; 0029E
        asr.l   #$8,d1                          ; 002A4
        cmpi.l  #$7fff,d1                       ; 002A6
        bgt.b   l_023_002E8                     ; 002AC
        cmp.w   (a1),d1                         ; 002AE
        bgt.b   l_023_002E8                     ; 002B0
        asr.l   #$8,d0                          ; 002B2
        add.l   -$38(a6),d0                     ; 002B4
        move.w  $2(a1),d6                       ; 002B8
        ext.l   d6                              ; 002BC
        cmp.l   d6,d0                           ; 002BE
        ble.b   l_023_002E8                     ; 002C0
        move.w  $4(a1),d6                       ; 002C2
        ext.l   d6                              ; 002C6
        cmp.l   d6,d0                           ; 002C8
        bge.b   l_023_002E8                     ; 002CA
        asr.l   #$8,d2                          ; 002CC
        add.l   -$3c(a6),d2                     ; 002CE
        move.w  $6(a1),d6                       ; 002D2
        ext.l   d6                              ; 002D6
        cmp.l   d6,d2                           ; 002D8
        ble.b   l_023_002E8                     ; 002DA
        move.w  $8(a1),d6                       ; 002DC
        ext.l   d6                              ; 002E0
        cmp.l   d6,d2                           ; 002E2
        blt.w   l_023_00486                     ; 002E4
l_023_002E8:
        move.w  -$6(a6),d0                      ; 002E8
        cmp.w   -$8(a6),d0                      ; 002EC
        ble.b   l_023_00302                     ; 002F0
        cmpi.w  #$a,d5                          ; 002F2
        bge.b   l_023_00302                     ; 002F6
        cmpi.w  #$6,-$a(a6)                     ; 002F8
        blt.w   l_023_0014A                     ; 002FE
l_023_00302:
        move.l  $8(a6),d0                       ; 00302
        cmpi.w  #$14,d0                         ; 00306
        blt.w   l_023_003DA                     ; 0030A
        move.w  (BulletHitRange).l,d7           ; 0030E
        ext.l   d7                              ; 00314
        movem.l $0(a3),d0-d1/d6                 ; 00316
        asr.l   #$8,d0                          ; 0031C
        sub.w   -$1a(a6),d0                     ; 0031E
        bge.b   l_023_00326                     ; 00322
        neg.w   d0                              ; 00324
l_023_00326:
        cmp.w   d7,d0                           ; 00326
        bge.w   l_023_003DA                     ; 00328
        asr.l   #$8,d1                          ; 0032C
        sub.l   -$16(a6),d1                     ; 0032E
        bge.b   l_023_00336                     ; 00332
        neg.l   d1                              ; 00334
l_023_00336:
        cmp.l   d7,d1                           ; 00336
        bge.w   l_023_003DA                     ; 00338
        asr.l   #$8,d6                          ; 0033C
        sub.w   -$14(a6),d6                     ; 0033E
        bge.b   l_023_00346                     ; 00342
        neg.w   d6                              ; 00344
l_023_00346:
        cmp.w   d7,d6                           ; 00346
        bge.w   l_023_003DA                     ; 00348
        moveq   #$8,d5                          ; 0034C
l_023_0034E:
        movem.l $18(a3),d0-d2                   ; 0034E
        subi.l  #$20,d1                         ; 00354
        moveq   #$6,d4                          ; 0035A
        btst    #$4,$26(a3)                     ; 0035C
        bne.b   l_023_0037A                     ; 00362
        btst    #$5,$26(a3)                     ; 00364
        beq.b   l_023_00386                     ; 0036A
        addi.l  #$20,d1                         ; 0036C
        moveq   #$2,d4                          ; 00372
        move.l  d1,d3                           ; 00374
        asr.l   d4,d3                           ; 00376
        sub.l   d3,d1                           ; 00378
l_023_0037A:
        move.l  d0,d3                           ; 0037A
        asr.l   d4,d3                           ; 0037C
        sub.l   d3,d0                           ; 0037E
        move.l  d2,d3                           ; 00380
        asr.l   d4,d3                           ; 00382
        sub.l   d3,d2                           ; 00384
l_023_00386:
        movem.l d0-d2,$18(a3)                   ; 00386
        add.l   d0,$0(a3)                       ; 0038C
        add.l   d1,$4(a3)                       ; 00390
        add.l   d2,$8(a3)                       ; 00394
        move.w  (BulletHitRange2).l,d7          ; 00398
        ext.l   d7                              ; 0039E
        movem.l $0(a3),d0-d1/d6                 ; 003A0
        asr.l   #$8,d0                          ; 003A6
        sub.w   -$1a(a6),d0                     ; 003A8
        bge.b   l_023_003B0                     ; 003AC
        neg.w   d0                              ; 003AE
l_023_003B0:
        cmp.w   d7,d0                           ; 003B0
        bge.b   l_023_003D2                     ; 003B2
        asr.l   #$8,d1                          ; 003B4
        sub.l   -$16(a6),d1                     ; 003B6
        bge.b   l_023_003BE                     ; 003BA
        neg.l   d1                              ; 003BC
l_023_003BE:
        cmp.l   d7,d1                           ; 003BE
        bge.b   l_023_003D2                     ; 003C0
        asr.l   #$8,d6                          ; 003C2
        sub.w   -$14(a6),d6                     ; 003C4
        bge.b   l_023_003CC                     ; 003C8
        neg.w   d6                              ; 003CA
l_023_003CC:
        cmp.w   d7,d6                           ; 003CC
        blt.w   l_023_00480                     ; 003CE
l_023_003D2:
        subq.b  #$1,d5                          ; 003D2
        bgt.w   l_023_0034E                     ; 003D4
        bra.b   l_023_00434                     ; 003D8
l_023_003DA:
        movem.l $c(a3),d0-d2                    ; 003DA
        subi.l  #$100,d1                        ; 003E0
        moveq   #$6,d4                          ; 003E6
        btst    #$4,$26(a3)                     ; 003E8
        bne.b   l_023_00406                     ; 003EE
        btst    #$5,$26(a3)                     ; 003F0
        beq.b   l_023_00414                     ; 003F6
        addi.l  #$100,d1                        ; 003F8
        moveq   #$2,d4                          ; 003FE
        move.l  d1,d3                           ; 00400
        asr.l   d4,d3                           ; 00402
        sub.l   d3,d1                           ; 00404
l_023_00406:
        move.l  d0,d3                           ; 00406
        move.l  d0,d3                           ; 00408
        asr.l   d4,d3                           ; 0040A
        sub.l   d3,d0                           ; 0040C
        move.l  d2,d3                           ; 0040E
        asr.l   d4,d3                           ; 00410
        sub.l   d3,d2                           ; 00412
l_023_00414:
        movem.l d0-d2,$c(a3)                    ; 00414
        tst.w   $24(a3)                         ; 0041A
        bne.b   l_023_00428                     ; 0041E
        move.w  #$1,$24(a3)                     ; 00420
        bra.b   l_023_00434                     ; 00426
l_023_00428:
        add.l   d0,$0(a3)                       ; 00428
        add.l   d1,$4(a3)                       ; 0042C
        add.l   d2,$8(a3)                       ; 00430
l_023_00434:
        bra.w   l_023_0067A                     ; 00434

;-------------------------------------------------------------------------------
; BulletTestPoint - Tests a bullet's point against the ground and the objects (BulletTestKind).
;-------------------------------------------------------------------------------
BulletTestPoint:
        move.l  $4(a3),d3                       ; 00438
        blt.w   BulletHitGround                 ; 0043C
        move.w  (BulletTestKind).l,d0           ; 00440
        beq.b   l_023_0045C                     ; 00446
        subq.w  #$1,d0                          ; 00448
        beq.b   l_023_00456                     ; 0044A
        move.l  $8(a3),d3                       ; 0044C
        move.w  -$c(a6),d1                      ; 00450
        bra.b   l_023_00464                     ; 00454
l_023_00456:
        move.w  -$e(a6),d1                      ; 00456
        bra.b   l_023_00464                     ; 0045A
l_023_0045C:
        move.l  $0(a3),d3                       ; 0045C
        move.w  -$10(a6),d1                     ; 00460
l_023_00464:
        asr.l   #$8,d3                          ; 00464
        move.w  d3,d7                           ; 00466
        sub.w   d1,d3                           ; 00468
        blt.b   l_023_00476                     ; 0046A
        sub.w   -$12(a6),d7                     ; 0046C
        blt.w   l_023_0013E                     ; 00470
        bra.b   l_023_0047E                     ; 00474
l_023_00476:
        sub.w   -$12(a6),d7                     ; 00476
        bge.w   l_023_0013E                     ; 0047A
l_023_0047E:
        nop                                     ; 0047E
l_023_00480:
        moveq   #$1,d0                          ; 00480
        unlk    a6                              ; 00482
        rts                                     ; 00484
l_023_00486:
        lea.l   $a(a0),a0                       ; 00486
        lea.l   $a(a1),a1                       ; 0048A
l_023_0048E:
        cmp.w   (a1),d1                         ; 0048E
        bgt.b   l_023_004BA                     ; 00490
        move.w  $2(a1),d6                       ; 00492
        ext.l   d6                              ; 00496
        cmp.l   d6,d0                           ; 00498
        ble.b   l_023_004BA                     ; 0049A
        move.w  $4(a1),d6                       ; 0049C
        ext.l   d6                              ; 004A0
        cmp.l   d6,d0                           ; 004A2
        bge.b   l_023_004BA                     ; 004A4
        move.w  $6(a1),d6                       ; 004A6
        ext.l   d6                              ; 004AA
        cmp.l   d6,d2                           ; 004AC
        ble.b   l_023_004BA                     ; 004AE
        move.w  $8(a1),d6                       ; 004B0
        ext.l   d6                              ; 004B4
        cmp.l   d6,d2                           ; 004B6
        blt.b   l_023_004CA                     ; 004B8
l_023_004BA:
        move.l  $a(a1),d3                       ; 004BA
        blt.w   l_023_002E8                     ; 004BE
l_023_004C2:
        movea.l d3,a1                           ; 004C2
        movea.l $a(a0),a0                       ; 004C4
        bra.b   l_023_0048E                     ; 004C8
l_023_004CA:
        swap    d5                              ; 004CA
        btst    #$4,-$1(a6)                     ; 004CC
        beq.w   l_023_005DA                     ; 004D2
        move.w  #$7,d5                          ; 004D6
l_023_004DA:
        movem.l $18(a3),d0-d2                   ; 004DA
        add.l   d0,$0(a3)                       ; 004E0
        add.l   d1,$4(a3)                       ; 004E4
        add.l   d2,$8(a3)                       ; 004E8
        move.b  -$2(a6),d0                      ; 004EC
        ext.w   d0                              ; 004F0
        move.w  d0,(BulletHitObject).l          ; 004F2
        move.l  d5,-(a7)                        ; 004F8
        moveq   #$0,d7                          ; 004FA
        move.b  -$4(a6),d0                      ; 004FC
        andi.b  #$10,d0                         ; 00500
        beq.b   l_023_0050C                     ; 00504
        bsr.w   BulletTestCell                  ; 00506
        bra.b   l_023_00510                     ; 0050A
l_023_0050C:
        bsr.w   BulletTestCell2                 ; 0050C
l_023_00510:
        move.l  (a7)+,d5                        ; 00510
        tst.w   d7                              ; 00512
        bne.b   l_023_00530                     ; 00514
        dbra    d5,l_023_004DA                  ; 00516
        movem.l $c(a3),d0-d2                    ; 0051A
        sub.l   d0,$0(a3)                       ; 00520
        sub.l   d1,$4(a3)                       ; 00524
        sub.l   d2,$8(a3)                       ; 00528
        bra.w   l_023_002E8                     ; 0052C
l_023_00530:
        move.b  -$4(a6),d0                      ; 00530
        andi.b  #$10,d0                         ; 00534
        bne.w   l_023_00480                     ; 00538
        movea.l (ConfigBuffer).l,a1             ; 0053C
        addq.w  #$1,$3c(a1)                     ; 00542
        move.w  (BulletHitObject).l,d0          ; 00546
        asl.w   #$8,d0                          ; 0054C
        add.w   d0,d0                           ; 0054E
        move.w  d0,d7                           ; 00550
        swap    d7                              ; 00552
        lea.l   (ObjectTable).l,a1              ; 00554
        adda.w  d0,a1                           ; 0055A
        move.b  $3c(a1),d7                      ; 0055C
        move.b  d7,d0                           ; 00560
        andi.b  #$f,d7                          ; 00562
        addq.b  #$1,d7                          ; 00566
        cmpi.b  #$3,d7                          ; 00568
        blt.b   l_023_005AC                     ; 0056C
        ori.w   #$200,$0(a1)                    ; 0056E
        move.b  $62(a1),d0                      ; 00574
        cmpi.b  #$15,d0                         ; 00578
        beq.w   l_023_00480                     ; 0057C
        andi.b  #$f0,d0                         ; 00580
        cmpi.b  #$0,d0                          ; 00584
        beq.w   l_023_00480                     ; 00588
        bset    #$1,$20(a1)                     ; 0058C
        swap    d7                              ; 00592
        move.w  d7,(FlameObject).l              ; 00594
        swap    d7                              ; 0059A
        bset    #$4,$2(a1)                      ; 0059C
        move.b  #$1,$5(a1)                      ; 005A2
        bra.w   l_023_00480                     ; 005A8
l_023_005AC:
        andi.b  #$f0,d0                         ; 005AC
        or.b    d7,d0                           ; 005B0
        move.b  d0,$3c(a1)                      ; 005B2
        bra.w   l_023_00480                     ; 005B6

;-------------------------------------------------------------------------------
; BulletHitStep - Steps a hit object's damage counter (+$3C).
;-------------------------------------------------------------------------------
BulletHitStep:
        move.b  $3c(a1),d7                      ; 005BA
        move.b  d7,d0                           ; 005BE
        andi.b  #$f0,d7                         ; 005C0
        addi.b  #$10,d7                         ; 005C4
        cmpi.b  #$30,d7                         ; 005C8
        andi.b  #$f,d0                          ; 005CC
        or.b    d7,d0                           ; 005D0
        move.b  d7,$3c(a1)                      ; 005D2
        bra.w   l_023_00480                     ; 005D6
l_023_005DA:
        move.w  #$8,-$1c(a6)                    ; 005DA
        lea.l   (a0),a2                         ; 005E0
        lea.l   (a1),a4                         ; 005E2
l_023_005E4:
        movem.l $18(a3),d0-d2                   ; 005E4
        add.l   d0,$0(a3)                       ; 005EA
        add.l   d1,$4(a3)                       ; 005EE
        add.l   d2,$8(a3)                       ; 005F2
        lea.l   $e(a2),a0                       ; 005F6
        lea.l   $e(a4),a1                       ; 005FA
        move.w  (a0)+,-$1e(a6)                  ; 005FE
        movem.l $0(a3),d0-d2                    ; 00602
        asr.l   #$8,d0                          ; 00608
        asr.l   #$8,d1                          ; 0060A
        asr.l   #$8,d2                          ; 0060C
        add.l   -$38(a6),d0                     ; 0060E
        add.l   -$3c(a6),d2                     ; 00612
l_023_00616:
        addq.w  #$6,a0                          ; 00616
        move.l  d0,d3                           ; 00618
        move.l  d1,d4                           ; 0061A
        move.l  d2,d5                           ; 0061C
        move.w  (a1)+,d6                        ; 0061E
        ext.l   d6                              ; 00620
        sub.l   d6,d3                           ; 00622
        sub.w   (a1)+,d4                        ; 00624
        move.w  (a1)+,d6                        ; 00626
        ext.l   d6                              ; 00628
        sub.l   d6,d5                           ; 0062A
        movem.w (a0)+,d6-d7                     ; 0062C
        muls.w  d3,d6                           ; 00630
        muls.w  d4,d7                           ; 00632
        add.l   d6,d7                           ; 00634
        move.w  (a0)+,d6                        ; 00636
        muls.w  d5,d6                           ; 00638
        add.l   d6,d7                           ; 0063A
        bge.b   l_023_00648                     ; 0063C
        subq.w  #$1,-$1e(a6)                    ; 0063E
        bgt.b   l_023_00616                     ; 00642
        bra.w   l_023_00480                     ; 00644
l_023_00648:
        subq.w  #$1,-$1c(a6)                    ; 00648
        bgt.b   l_023_005E4                     ; 0064C
        lea.l   (a4),a1                         ; 0064E
        move.l  $a(a1),d3                       ; 00650
        ble.b   l_023_0067A                     ; 00654
        lea.l   (a2),a0                         ; 00656
        movem.l $0(a3),d0-d2                    ; 00658
        movem.l $c(a3),d4-d6                    ; 0065E
        sub.l   d4,d0                           ; 00664
        sub.l   d5,d1                           ; 00666
        sub.l   d6,d2                           ; 00668
        movem.l d0-d2,$0(a3)                    ; 0066A
        asr.l   #$8,d0                          ; 00670
        asr.l   #$8,d1                          ; 00672
        asr.l   #$8,d2                          ; 00674
        bra.w   l_023_004C2                     ; 00676
l_023_0067A:
        moveq   #$0,d0                          ; 0067A
        unlk    a6                              ; 0067C
        rts                                     ; 0067E

;-------------------------------------------------------------------------------
; BulletHitTestNext - BulletHitTest's next entry.
;-------------------------------------------------------------------------------
BulletHitTestNext:
        swap    d5                              ; 00680
        move.l  $4(a3),d3                       ; 00682
        bge.w   l_023_002E8                     ; 00686

;-------------------------------------------------------------------------------
; BulletHitGround - What a bullet that reached the ground hit there; d0 = 1 when something
; counts.
;-------------------------------------------------------------------------------
BulletHitGround:
        link.w  a6,#$0                          ; 0068A
        move.l  $8(a6),d0                       ; 0068E
        asl.w   #$6,d0                          ; 00692
        lea.l   (Bullets).l,a3                  ; 00694
        adda.w  d0,a3                           ; 0069A
        movem.l $c(a3),d0-d2                    ; 0069C
        asr.l   #$8,d1                          ; 006A2
        beq.b   l_023_006D4                     ; 006A4
        move.l  $4(a3),d3                       ; 006A6
        asr.l   #$8,d3                          ; 006AA
        neg.w   d3                              ; 006AC
        asl.l   #$4,d0                          ; 006AE
        asl.l   #$4,d2                          ; 006B0
        divs.w  d1,d0                           ; 006B2
        divs.w  d1,d2                           ; 006B4
        muls.w  d3,d0                           ; 006B6
        muls.w  d3,d2                           ; 006B8
        asr.l   #$4,d0                          ; 006BA
        asr.l   #$4,d2                          ; 006BC
        add.l   d0,$0(a3)                       ; 006BE
        clr.l   $4(a3)                          ; 006C2
        add.l   d2,$8(a3)                       ; 006C6
        asr.l   #$8,d0                          ; 006CA
        asr.l   #$8,d2                          ; 006CC
        moveq   #$0,d0                          ; 006CE
l_023_006D0:
        unlk    a6                              ; 006D0
        rts                                     ; 006D2
l_023_006D4:
        moveq   #$0,d0                          ; 006D4
        bra.b   l_023_006D0                     ; 006D6

;-------------------------------------------------------------------------------
; BulletTestCell - Tests a bullet against a cell's items.
;-------------------------------------------------------------------------------
BulletTestCell:
        movem.l a3/a5,-(a7)                     ; 006D8
        clr.b   -$20(a6)                        ; 006DC
        movem.l $0(a3),d2-d4                    ; 006E0
        lsr.l   #$8,d2                          ; 006E6
        lsr.l   #$8,d3                          ; 006E8
        lsr.l   #$8,d4                          ; 006EA
        movea.w d2,a2                           ; 006EC
        movea.l d3,a1                           ; 006EE
        move.w  d4,-$42(a6)                     ; 006F0
        lea.l   (ObjectTable).l,a3              ; 006F4
        move.w  (BulletHitObject).l,d0          ; 006FA
        asl.w   #$8,d0                          ; 00700
        add.w   d0,d0                           ; 00702
        adda.w  d0,a3                           ; 00704
        cmpi.b  #$20,$62(a3)                    ; 00706
        bne.b   l_023_00716                     ; 0070C
        lea.l   (Carrier_00000).l,a4            ; 0070E
        bra.b   l_023_0071C                     ; 00714
l_023_00716:
        lea.l   (Submarine_00000).l,a4          ; 00716
l_023_0071C:
        movea.l (a4)+,a5                        ; 0071C
        move.w  $2(a5),d7                       ; 0071E
        addi.w  #$a4,d7                         ; 00722
        move.b  $7d(a3),d2                      ; 00726
        andi.w  #$f,d2                          ; 0072A
        move.w  d2,-$5a(a6)                     ; 0072E
        move.w  $2(a3,d7.w),d4                  ; 00732
        asr.w   d2,d4                           ; 00736
        cmp.w   d4,d3                           ; 00738
        bge.b   l_023_0074C                     ; 0073A
l_023_0073C:
        tst.w   (a4)                            ; 0073C
        blt.b   l_023_00796                     ; 0073E
        jsr     (CollideWithList).l             ; 00740
        beq.b   l_023_0073C                     ; 00746
        bra.w   l_023_0079A                     ; 00748
l_023_0074C:
        cmpi.b  #$20,$62(a3)                    ; 0074C
        bne.b   l_023_0075C                     ; 00752
        lea.l   (Carrier_0007C).l,a4            ; 00754
        bra.b   l_023_00762                     ; 0075A
l_023_0075C:
        lea.l   (Submarine_00020).l,a4          ; 0075C
l_023_00762:
        movea.l (a4)+,a5                        ; 00762
        move.w  $2(a5),d7                       ; 00764
        addi.w  #$a4,d7                         ; 00768
        move.w  $2(a3,d7.w),d4                  ; 0076C
        ext.l   d4                              ; 00770
        cmp.l   a1,d4                           ; 00772
        bge.b   l_023_0078E                     ; 00774
        adda.w  #$12,a4                         ; 00776
        movea.l (a4)+,a5                        ; 0077A
        move.w  $2(a5),d7                       ; 0077C
        addi.w  #$a4,d7                         ; 00780
        move.w  $2(a3,d7.w),d4                  ; 00784
        ext.l   d4                              ; 00788
        cmp.l   a1,d4                           ; 0078A
        blt.b   l_023_00796                     ; 0078C
l_023_0078E:
        jsr     (CollideWithList).l             ; 0078E
        bne.b   l_023_0079A                     ; 00794
l_023_00796:
        moveq   #$0,d7                          ; 00796
        bra.b   l_023_0079C                     ; 00798
l_023_0079A:
        moveq   #$1,d7                          ; 0079A
l_023_0079C:
        movem.l (a7)+,a3/a5                     ; 0079C
        rts                                     ; 007A0

;-------------------------------------------------------------------------------
; BulletTestCell2 - As BulletTestCell (the other list).
;-------------------------------------------------------------------------------
BulletTestCell2:
        movem.l a3/a5,-(a7)                     ; 007A2
        clr.b   -$20(a6)                        ; 007A6
        movem.l $0(a3),d2-d4                    ; 007AA
        lsr.l   #$8,d2                          ; 007B0
        lsr.l   #$8,d3                          ; 007B2
        lsr.l   #$8,d4                          ; 007B4
        movea.w d2,a2                           ; 007B6
        movea.l d3,a1                           ; 007B8
        movea.w d4,a4                           ; 007BA
        lea.l   (ObjectTable).l,a0              ; 007BC
        move.w  (BulletHitObject).l,d0          ; 007C2
        asl.w   #$8,d0                          ; 007C8
        add.w   d0,d0                           ; 007CA
        adda.w  d0,a0                           ; 007CC
        lea.l   (Mig_00744).l,a3                ; 007CE
        move.b  $7b(a0),d0                      ; 007D4
        blt.w   l_023_008B8                     ; 007D8
        move.b  $7d(a0),d2                      ; 007DC
        andi.w  #$f,d2                          ; 007E0
        lsr.b   #$4,d0                          ; 007E4
        andi.w  #$f,d0                          ; 007E6
        sub.w   d0,d2                           ; 007EA
        bge.b   l_023_007F0                     ; 007EC
        moveq   #$0,d2                          ; 007EE
l_023_007F0:
        move.w  d2,-$3e(a6)                     ; 007F0
        move.b  $7b(a0),d0                      ; 007F4
        andi.w  #$f,d0                          ; 007F8
        ext.w   d0                              ; 007FC
        add.w   d0,d0                           ; 007FE
        add.w   d0,d0                           ; 00800
        movea.l (a3,d0.w),a3                    ; 00802
l_023_00806:
        movem.w (a3)+,d2-d4                     ; 00806
        bclr    #$f,d2                          ; 0080A
        bne.w   l_023_008BC                     ; 0080E
        move.w  #$a4,d0                         ; 00812
        add.w   d0,d2                           ; 00816
        add.w   d0,d3                           ; 00818
        add.w   d0,d4                           ; 0081A
        bclr    #$e,d2                          ; 0081C
        bne.b   l_023_0083A                     ; 00820
        lea.l   (a0,d2.w),a5                    ; 00822
        movem.w (a0,d4.w),d5-d7                 ; 00826
        sub.w   (a0,d3.w),d5                    ; 0082C
        sub.w   $2(a0,d3.w),d6                  ; 00830
        sub.w   $4(a0,d3.w),d7                  ; 00834
        bra.b   l_023_00882                     ; 00838
l_023_0083A:
        lea.l   (a0,d2.w),a5                    ; 0083A
        move.w  d4,d0                           ; 0083E
        movem.w (a0,d3.w),d2-d4                 ; 00840
        sub.w   (a5),d2                         ; 00846
        sub.w   $2(a5),d3                       ; 00848
        sub.w   $4(a5),d4                       ; 0084C
        movem.w (a0,d0.w),d5-d7                 ; 00850
        sub.w   (a5),d5                         ; 00856
        sub.w   $2(a5),d6                       ; 00858
        sub.w   $4(a5),d7                       ; 0085C
        move.w  d4,d0                           ; 00860
        move.w  d7,d1                           ; 00862
        muls.w  d3,d7                           ; 00864
        muls.w  d6,d4                           ; 00866
        sub.l   d4,d7                           ; 00868
        lsr.l   #$4,d7                          ; 0086A
        muls.w  d5,d0                           ; 0086C
        muls.w  d2,d1                           ; 0086E
        sub.l   d1,d0                           ; 00870
        lsr.l   #$4,d0                          ; 00872
        muls.w  d2,d6                           ; 00874
        muls.w  d3,d5                           ; 00876
        sub.l   d5,d6                           ; 00878
        lsr.l   #$4,d6                          ; 0087A
        move.w  d7,d5                           ; 0087C
        move.w  d6,d7                           ; 0087E
        move.w  d0,d6                           ; 00880
l_023_00882:
        movem.w (a5),d2-d4                      ; 00882
        move.w  -$3e(a6),d0                     ; 00886
        asr.w   d0,d2                           ; 0088A
        asr.w   d0,d3                           ; 0088C
        asr.w   d0,d4                           ; 0088E
        ext.l   d3                              ; 00890
        add.w   $c(a0),d2                       ; 00892
        add.l   $10(a0),d3                      ; 00896
        add.w   $e(a0),d4                       ; 0089A
        sub.w   a2,d2                           ; 0089E
        sub.l   a1,d3                           ; 008A0
        sub.w   a4,d4                           ; 008A2
        neg.w   d2                              ; 008A4
        neg.w   d3                              ; 008A6
        neg.w   d4                              ; 008A8
        muls.w  d2,d5                           ; 008AA
        muls.w  d3,d6                           ; 008AC
        muls.w  d4,d7                           ; 008AE
        add.l   d5,d7                           ; 008B0
        add.l   d6,d7                           ; 008B2
        bge.w   l_023_00806                     ; 008B4
l_023_008B8:
        moveq   #$0,d7                          ; 008B8
        bra.b   l_023_008BE                     ; 008BA
l_023_008BC:
        moveq   #$1,d7                          ; 008BC
l_023_008BE:
        movem.l (a7)+,a3/a5                     ; 008BE
        rts                                     ; 008C2
h023_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    30,71                           ; 30 longs pointing into hunk 71
	dc.l	$FE,$442,$F8,$108,$134,$39A,$1F8,$310
	dc.l	$40,$72,$28,$146,$D0,$CA,$116,$1BE
	dc.l	$4F4,$548,$6FC,$7C4,$38,$11C,$18E,$1AC
	dc.l	$556,$6F6,$7BE,$4,$E2,$696
        dc.l    2,72                            ; 2 longs pointing into hunk 72
	dc.l	$244,$23E
        dc.l    2,24                            ; 2 longs pointing into hunk 24
	dc.l	$742,$790
        dc.l    1,51                            ; 1 longs pointing into hunk 51
	dc.l	$7D0
        dc.l    2,53                            ; 2 longs pointing into hunk 53
	dc.l	$75E,$718
        dc.l    2,52                            ; 2 longs pointing into hunk 52
	dc.l	$756,$710
        dc.l    1,2                             ; 1 longs pointing into hunk 2
	dc.l	$53E
        dc.l    2,8                             ; 2 longs pointing into hunk 8
	dc.l	$6A,$B4
        dc.l    1,73                            ; 1 longs pointing into hunk 73
	dc.l	$596
	dc.l	0
	dc.l	HUNK_END
	endc
