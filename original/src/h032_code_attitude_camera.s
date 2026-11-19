; F/A-18 Interceptor - hunk 32 (code)
; Attitude and camera: SetAttitude, AnglesToMatrix, SinCos, SetupCamera.
; Included by ../f18_main.s.

;===============================================================================
; Hunk 32: CODE, $1348 bytes
;===============================================================================
	CODE_HUNK	h032

;-------------------------------------------------------------------------------
; UpdateAttitude - Updates an object's attitude (a1) and calls SetAttitude: for an aircraft
; (type '0'-'9') the roll (+$6A) eases back towards level by $7D0 (25 degrees) a step, and the
; pitch and heading come from sub_000_0454A (into dat_071_00490 / 00492); for the others from
; the control bits (+$64, +$65) and the state (+$05).
;-------------------------------------------------------------------------------
UpdateAttitude:
        move.b  $62(a1),d0                      ; 00000
        andi.b  #$f0,d0                         ; 00004
        cmpi.b  #$30,d0                         ; 00008
        bne.w   l_032_0008E                     ; 0000C
        tst.w   $4c(a1)                         ; 00010
        ble.b   l_032_00084                     ; 00014
        tst.b   (dat_071_0017E).l               ; 00016
        bne.b   l_032_00084                     ; 0001C
        movem.l $3e(a1),d2-d4                   ; 0001E
        move.l  #$7d0,d5                        ; 00024
        moveq   #$0,d6                          ; 0002A
        tst.b   (dat_071_00155).l               ; 0002C
        bne.b   l_032_0004E                     ; 00032
        move.w  $6a(a1),d6                      ; 00034
        cmpi.w  #$3840,d6                       ; 00038
        bgt.b   l_032_00046                     ; 0003C
        sub.w   d5,d6                           ; 0003E
        bge.b   l_032_0004E                     ; 00040
l_032_00042:
        moveq   #$0,d6                          ; 00042
        bra.b   l_032_0004E                     ; 00044
l_032_00046:
        add.w   d5,d6                           ; 00046
        cmpi.w  #$7080,d6                       ; 00048
        bge.b   l_032_00042                     ; 0004C
l_032_0004E:
        move.w  d6,$6a(a1)                      ; 0004E
        move.w  $66(a1),d0                      ; 00052
        move.w  $68(a1),d1                      ; 00056
        ext.l   d0                              ; 0005A
        ext.l   d1                              ; 0005C
        move.l  a1,-(a7)                        ; 0005E
        movem.l d0-d5,-(a7)                     ; 00060
        jsr     (VectorToAngles).l              ; 00064
        adda.w  #$18,a7                         ; 0006A
        movea.l (a7)+,a1                        ; 0006E
        move.w  (dat_071_00490).l,d4            ; 00070
        move.w  (dat_071_00492).l,d5            ; 00076
        move.w  $6a(a1),d6                      ; 0007C
        bra.w   SetAttitude                     ; 00080
l_032_00084:
        movem.w $66(a1),d4-d6                   ; 00084
        bra.w   SetAttitude                     ; 0008A
l_032_0008E:
        moveq   #$0,d0                          ; 0008E
        move.w  d0,d2                           ; 00090
        move.w  d0,d4                           ; 00092
        tst.w   (CurrentObject).l               ; 00094
        bne.b   l_032_000AA                     ; 0009A
        tst.b   (dat_071_0017E).l               ; 0009C
        beq.w   l_032_001F4                     ; 000A2
        bra.w   l_032_002F4                     ; 000A6
l_032_000AA:
        btst    #$0,$2(a1)                      ; 000AA
        bne.b   l_032_000C8                     ; 000B0
        move.b  $64(a1),d1                      ; 000B2
        move.b  d1,d3                           ; 000B6
        andi.b  #$10,d3                         ; 000B8
        bne.b   l_032_000C8                     ; 000BC
        andi.b  #$c3,$65(a1)                    ; 000BE
        bra.w   l_032_001F4                     ; 000C4
l_032_000C8:
        cmpi.b  #$6,$5(a1)                      ; 000C8
        beq.w   l_032_0018C                     ; 000CE
        cmpi.b  #$a,$5(a1)                      ; 000D2
        beq.w   l_032_0018C                     ; 000D8
        btst    #$0,$2(a1)                      ; 000DC
        bne.w   l_032_001F4                     ; 000E2
        move.b  d1,d3                           ; 000E6
        andi.b  #$8,d3                          ; 000E8
        beq.b   l_032_00108                     ; 000EC
        move.b  d1,d3                           ; 000EE
        andi.b  #$4,d3                          ; 000F0
        bne.b   l_032_0012C                     ; 000F4
        andi.w  #$dfff,$0(a1)                   ; 000F6
        move.b  d1,d3                           ; 000FC
        andi.b  #$40,d3                         ; 000FE
        bne.b   l_032_0012C                     ; 00102
        bra.w   l_032_001F4                     ; 00104
l_032_00108:
        move.b  d1,d3                           ; 00108
        andi.b  #$2,d3                          ; 0010A
        bne.b   l_032_00120                     ; 0010E
        andi.w  #$dfff,$0(a1)                   ; 00110
        move.b  d1,d3                           ; 00116
        andi.b  #$20,d3                         ; 00118
        beq.w   l_032_001F4                     ; 0011C
l_032_00120:
        move.b  d1,d3                           ; 00120
        andi.b  #$40,d3                         ; 00122
        bne.b   l_032_00136                     ; 00126
        bra.w   l_032_001F4                     ; 00128
l_032_0012C:
        move.b  d1,d3                           ; 0012C
        andi.b  #$20,d3                         ; 0012E
        beq.w   l_032_001F4                     ; 00132
l_032_00136:
        move.b  $62(a1),d0                      ; 00136
        andi.b  #$f0,d0                         ; 0013A
        cmpi.b  #$10,d0                         ; 0013E
        beq.b   l_032_0016C                     ; 00142
        move.w  #$fc40,d4                       ; 00144
        move.w  $6a(a1),d3                      ; 00148
        cmpi.w  #$3840,d3                       ; 0014C
        bgt.b   l_032_0015C                     ; 00150
        cmpi.w  #$118,d3                        ; 00152
        bgt.w   l_032_00294                     ; 00156
        bra.b   l_032_00166                     ; 0015A
l_032_0015C:
        neg.w   d4                              ; 0015C
        cmpi.w  #$6f68,d3                       ; 0015E
        blt.w   l_032_00294                     ; 00162
l_032_00166:
        clr.w   d4                              ; 00166
        bra.w   l_032_00294                     ; 00168
l_032_0016C:
        move.b  $5(a1),d0                       ; 0016C
        beq.b   l_032_00180                     ; 00170
        cmpi.b  #$8,d0                          ; 00172
        beq.b   l_032_0018C                     ; 00176
        cmpi.b  #$1,d0                          ; 00178
        bne.w   l_032_001F4                     ; 0017C
l_032_00180:
        move.b  #$6,$5(a1)                      ; 00180
        move.w  #$1e,$4c(a1)                    ; 00186
l_032_0018C:
        ori.w   #$2000,$0(a1)                   ; 0018C
        cmpi.w  #$1000,$6c(a1)                  ; 00192
        bge.b   l_032_001A0                     ; 00198
        move.w  #$fd80,d4                       ; 0019A
        bra.b   l_032_001B2                     ; 0019E
l_032_001A0:
        cmpi.w  #$2000,$6c(a1)                  ; 001A0
        bge.b   l_032_001AE                     ; 001A6
        move.w  #$fce0,d4                       ; 001A8
        bra.b   l_032_001B2                     ; 001AC
l_032_001AE:
        move.w  #$fbf0,d4                       ; 001AE
l_032_001B2:
        move.w  $6a(a1),d3                      ; 001B2
        cmpi.w  #$3840,d3                       ; 001B6
        bgt.b   l_032_001C6                     ; 001BA
        moveq   #$4,d2                          ; 001BC
        cmpi.w  #$118,d3                        ; 001BE
        bgt.b   l_032_001D2                     ; 001C2
        bra.b   l_032_001D0                     ; 001C4
l_032_001C6:
        neg.w   d4                              ; 001C6
        moveq   #$8,d2                          ; 001C8
        cmpi.w  #$6f68,d3                       ; 001CA
        blt.b   l_032_001D2                     ; 001CE
l_032_001D0:
        moveq   #$0,d2                          ; 001D0
l_032_001D2:
        move.b  $65(a1),d1                      ; 001D2
        andi.b  #$3,d1                          ; 001D6
        or.b    d2,d1                           ; 001DA
        move.b  d1,$65(a1)                      ; 001DC
        move.b  $64(a1),d1                      ; 001E0
        andi.b  #$6,d1                          ; 001E4
        cmpi.b  #$6,d1                          ; 001E8
        bne.b   l_032_001F4                     ; 001EC
        bset    #$4,$3(a1)                      ; 001EE
l_032_001F4:
        move.b  $62(a1),d0                      ; 001F4
        andi.b  #$f0,d0                         ; 001F8
        cmpi.b  #$10,d0                         ; 001FC
        bne.b   l_032_00232                     ; 00200
        move.w  (dat_071_0029C).l,d0            ; 00202
        andi.w  #$40,d0                         ; 00208
        beq.b   l_032_00218                     ; 0020C
        move.l  a1,-(a7)                        ; 0020E
        jsr     (sub_000_0557C).l               ; 00210
        movea.l (a7)+,a1                        ; 00216
l_032_00218:
        move.w  $56(a1),d0                      ; 00218
        move.w  $58(a1),d2                      ; 0021C
        move.w  $5a(a1),d4                      ; 00220
        bra.w   l_032_002BE                     ; 00224
l_032_00228:
        clr.w   d0                              ; 00228
        clr.w   d2                              ; 0022A
        clr.w   d4                              ; 0022C
        bra.w   l_032_002F4                     ; 0022E
l_032_00232:
        move.w  $50(a1),d0                      ; 00232
        move.w  $52(a1),d2                      ; 00236
        move.w  $54(a1),d4                      ; 0023A
        btst    #$5,$20(a1)                     ; 0023E
        bne.b   l_032_00276                     ; 00244
        move.b  $38(a1),d3                      ; 00246
        bge.b   l_032_0027A                     ; 0024A
        cmpi.b  #$ff,d3                         ; 0024C
        beq.b   l_032_0027A                     ; 00250
        andi.w  #$7f,d3                         ; 00252
        bgt.b   l_032_0027A                     ; 00256
        asl.w   #$8,d3                          ; 00258
        add.w   d3,d3                           ; 0025A
        lea.l   (ObjectTable).l,a4              ; 0025C
        tst.b   (dat_071_00285).l               ; 00262
        beq.b   l_032_0027A                     ; 00268
        cmpi.b  #$1,$62(a1)                     ; 0026A
        beq.b   l_032_0027A                     ; 00270
        moveq   #$5,d3                          ; 00272
        bra.b   l_032_00288                     ; 00274
l_032_00276:
        moveq   #$a,d3                          ; 00276
        bra.b   l_032_00288                     ; 00278
l_032_0027A:
        move.w  $26(a1),d3                      ; 0027A
        ble.b   l_032_00294                     ; 0027E
        cmpi.w  #$f,d3                          ; 00280
        ble.b   l_032_00288                     ; 00284
        moveq   #$f,d3                          ; 00286
l_032_00288:
        ext.l   d0                              ; 00288
        ext.l   d2                              ; 0028A
        ext.l   d4                              ; 0028C
        divs.w  d3,d0                           ; 0028E
        divs.w  d3,d2                           ; 00290
        divs.w  d3,d4                           ; 00292
l_032_00294:
        movem.w $56(a1),d5-d7                   ; 00294
        add.w   d0,d5                           ; 0029A
        asr.w   #$1,d5                          ; 0029C
        add.w   d5,d0                           ; 0029E
        asr.w   #$1,d0                          ; 002A0
        move.w  d0,$56(a1)                      ; 002A2
        add.w   d2,d6                           ; 002A6
        asr.w   #$1,d6                          ; 002A8
        add.w   d6,d2                           ; 002AA
        asr.w   #$1,d2                          ; 002AC
        move.w  d2,$58(a1)                      ; 002AE
        add.w   d4,d7                           ; 002B2
        asr.w   #$1,d7                          ; 002B4
        add.w   d7,d4                           ; 002B6
        asr.w   #$1,d4                          ; 002B8
        move.w  d4,$5a(a1)                      ; 002BA
l_032_002BE:
        move.b  (dat_071_0017F).l,d7            ; 002BE
        or.b    (dat_071_0017E).l,d7            ; 002C4
        bne.w   l_032_00228                     ; 002CA
        move.b  $62(a1),d3                      ; 002CE
        andi.b  #$f0,d3                         ; 002D2
        cmpi.b  #$10,d3                         ; 002D6
        bne.b   l_032_002F4                     ; 002DA
        tst.w   (CurrentObject).l               ; 002DC
        bne.b   l_032_002EC                     ; 002E2
        tst.b   (dat_071_0015F).l               ; 002E4
        beq.b   l_032_002F4                     ; 002EA
l_032_002EC:
        move.w  $6a(a1),d7                      ; 002EC
        bsr.w   sub_032_00946                   ; 002F0
l_032_002F4:
        lea.l   $80(a1),a4                      ; 002F4
        bsr.w   sub_032_00AD8                   ; 002F8
        bclr    #$4,$3(a1)                      ; 002FC
        beq.b   l_032_00366                     ; 00302
        move.w  $6a(a1),d6                      ; 00304
        cmpi.w  #$3840,d6                       ; 00308
        beq.b   l_032_00366                     ; 0030C
        blt.b   l_032_00338                     ; 0030E
        cmpi.w  #$5460,d6                       ; 00310
        blt.b   l_032_00348                     ; 00314
        move.w  #$7080,d0                       ; 00316
l_032_0031A:
        sub.w   d6,d0                           ; 0031A
        cmpi.w  #$1,d0                          ; 0031C
        ble.b   l_032_0032E                     ; 00320
        asr.w   #$1,d0                          ; 00322
        cmpi.w  #$50,d0                         ; 00324
        ble.b   l_032_0032E                     ; 00328
        move.w  #$50,d0                         ; 0032A
l_032_0032E:
        add.w   d0,d6                           ; 0032E
        cmpi.w  #$7080,d6                       ; 00330
        bge.b   l_032_00364                     ; 00334
        bra.b   l_032_00366                     ; 00336
l_032_00338:
        cmpi.w  #$1c20,d6                       ; 00338
        ble.b   l_032_00344                     ; 0033C
        move.w  #$3840,d0                       ; 0033E
        bra.b   l_032_0031A                     ; 00342
l_032_00344:
        move.w  d6,d0                           ; 00344
        bra.b   l_032_0034E                     ; 00346
l_032_00348:
        move.w  d6,d0                           ; 00348
        subi.w  #$3840,d0                       ; 0034A
l_032_0034E:
        cmpi.w  #$1,d0                          ; 0034E
        ble.b   l_032_00360                     ; 00352
        asr.w   #$1,d0                          ; 00354
        cmpi.w  #$50,d0                         ; 00356
        ble.b   l_032_00360                     ; 0035A
        move.w  #$50,d0                         ; 0035C
l_032_00360:
        sub.w   d0,d6                           ; 00360
        bge.b   l_032_00366                     ; 00362
l_032_00364:
        moveq   #$0,d6                          ; 00364
l_032_00366:
        cmpi.b  #$a,$5(a1)                      ; 00366
        bne.b   l_032_00394                     ; 0036C
        move.w  $66(a1),d4                      ; 0036E
        cmpi.w  #$3840,d4                       ; 00372
        ble.b   l_032_00386                     ; 00376
        addi.w  #$50,d4                         ; 00378
        cmpi.w  #$7080,d4                       ; 0037C
        bge.b   l_032_0038E                     ; 00380
        bra.w   l_032_00546                     ; 00382
l_032_00386:
        subi.w  #$50,d4                         ; 00386
        bgt.w   l_032_00546                     ; 0038A
l_032_0038E:
        moveq   #$0,d4                          ; 0038E
        bra.w   l_032_00546                     ; 00390
l_032_00394:
        btst    #$6,$3(a1)                      ; 00394
        beq.b   l_032_003C2                     ; 0039A
        move.w  $66(a1),d4                      ; 0039C
        cmpi.w  #$3840,d4                       ; 003A0
        ble.b   l_032_003B4                     ; 003A4
        addi.w  #$a0,d4                         ; 003A6
        cmpi.w  #$7080,d4                       ; 003AA
        bge.b   l_032_003BC                     ; 003AE
        bra.w   l_032_00546                     ; 003B0
l_032_003B4:
        subi.w  #$a0,d4                         ; 003B4
        bgt.w   l_032_00546                     ; 003B8
l_032_003BC:
        moveq   #$0,d4                          ; 003BC
        bra.w   l_032_00546                     ; 003BE
l_032_003C2:
        tst.b   (dat_071_00154).l               ; 003C2
        beq.w   l_032_004A0                     ; 003C8
        tst.w   (CurrentObject).l               ; 003CC
        bne.b   l_032_003DE                     ; 003D2
        btst    #$1,$20(a1)                     ; 003D4
        bne.w   l_032_00460                     ; 003DA
l_032_003DE:
        btst    #$7,$3(a1)                      ; 003DE
        bne.w   l_032_004A0                     ; 003E4
        move.b  $62(a1),d0                      ; 003E8
        andi.b  #$f0,d0                         ; 003EC
        cmpi.b  #$10,d0                         ; 003F0
        bne.w   l_032_004A0                     ; 003F4
        move.w  $66(a1),d0                      ; 003F8
        asr.w   #$1,d0                          ; 003FC
        cmpi.w  #$1c20,d0                       ; 003FE
        bge.b   l_032_00412                     ; 00402
        cmpi.w  #$e10,d0                        ; 00404
        ble.b   l_032_0040E                     ; 00408
        move.w  #$e10,d0                        ; 0040A
l_032_0040E:
        addi.w  #$3840,d0                       ; 0040E
l_032_00412:
        subi.w  #$4650,d0                       ; 00412
        neg.w   d0                              ; 00416
        mulu.w  #$6c,d0                         ; 00418
        asr.l   #$8,d0                          ; 0041C
        move.w  $22(a1),d7                      ; 0041E
        asr.w   #$8,d7                          ; 00422
        mulu.w  d0,d7                           ; 00424
        asr.l   #$6,d7                          ; 00426
        add.w   d7,d0                           ; 00428
        btst    #$7,$3(a1)                      ; 0042A
        bne.b   l_032_0043C                     ; 00430
        cmp.w   $6e(a1),d0                      ; 00432
        bge.b   l_032_00444                     ; 00436
        clr.w   $26(a1)                         ; 00438
l_032_0043C:
        bclr    #$2,$20(a1)                     ; 0043C
        bra.b   l_032_004A0                     ; 00442
l_032_00444:
        bset    #$2,$20(a1)                     ; 00444
        move.w  $56(a1),d1                      ; 0044A
        or.w    $58(a1),d1                      ; 0044E
        or.w    $5a(a1),d1                      ; 00452
        beq.b   l_032_00460                     ; 00456
        asr.w   #$1,d0                          ; 00458
        cmp.w   $6e(a1),d0                      ; 0045A
        blt.b   l_032_004A0                     ; 0045E
l_032_00460:
        clr.w   $56(a1)                         ; 00460
        move.w  #$50,d0                         ; 00464
        sub.w   $26(a1),d0                      ; 00468
        asr.w   #$2,d0                          ; 0046C
        add.w   $26(a1),d0                      ; 0046E
        move.w  d0,$26(a1)                      ; 00472
        move.w  $66(a1),d4                      ; 00476
        add.w   d0,d4                           ; 0047A
        cmpi.w  #$7080,d4                       ; 0047C
        bge.b   l_032_0049A                     ; 00480
        cmpi.w  #$3840,d4                       ; 00482
        bge.w   l_032_00546                     ; 00486
        cmpi.w  #$12c0,d4                       ; 0048A
        ble.w   l_032_00546                     ; 0048E
        subi.w  #$50,d4                         ; 00492
        bra.w   l_032_00546                     ; 00496
l_032_0049A:
        moveq   #$0,d4                          ; 0049A
        bra.w   l_032_00546                     ; 0049C
l_032_004A0:
        move.w  $66(a1),d0                      ; 004A0
        cmpi.w  #$1770,d0                       ; 004A4
        ble.w   l_032_00546                     ; 004A8
        cmpi.w  #$5910,d0                       ; 004AC
        bge.w   l_032_00546                     ; 004B0
        moveq   #$0,d0                          ; 004B4
        move.w  d5,d1                           ; 004B6
        sub.w   $68(a1),d1                      ; 004B8
        bge.b   l_032_004C0                     ; 004BC
        neg.w   d1                              ; 004BE
l_032_004C0:
        cmpi.w  #$4b0,d1                        ; 004C0
        ble.b   l_032_004D6                     ; 004C4
        cmpi.w  #$6bd0,d1                       ; 004C6
        bge.b   l_032_004D6                     ; 004CA
        addq.w  #$1,d0                          ; 004CC
        subi.w  #$3840,d1                       ; 004CE
        bge.b   l_032_004D6                     ; 004D2
        neg.w   d1                              ; 004D4
l_032_004D6:
        move.w  d6,d2                           ; 004D6
        sub.w   $6a(a1),d2                      ; 004D8
        bge.b   l_032_004E0                     ; 004DC
        neg.w   d2                              ; 004DE
l_032_004E0:
        cmpi.w  #$4b0,d2                        ; 004E0
        ble.b   l_032_00542                     ; 004E4
        cmpi.w  #$6bd0,d2                       ; 004E6
        bge.b   l_032_00542                     ; 004EA
        subi.w  #$3840,d2                       ; 004EC
        bge.b   l_032_004F4                     ; 004F0
        neg.w   d2                              ; 004F2
l_032_004F4:
        sub.w   d1,d2                           ; 004F4
        bge.b   l_032_004FA                     ; 004F6
        neg.w   d2                              ; 004F8
l_032_004FA:
        cmpi.w  #$320,d2                        ; 004FA
        blt.b   l_032_00546                     ; 004FE
l_032_00500:
        btst    #$2,$3(a1)                      ; 00500
        bne.b   l_032_0052C                     ; 00506
        bset    #$2,$3(a1)                      ; 00508
        tst.b   $28(a1)                         ; 0050E
        beq.w   l_032_00592                     ; 00512
        move.w  (dat_060_0000C).l,d0            ; 00516
        tst.w   $56(a1)                         ; 0051C
        bge.b   l_032_00524                     ; 00520
        neg.w   d0                              ; 00522
l_032_00524:
        add.w   d0,$56(a1)                      ; 00524
        bra.w   l_032_00592                     ; 00528
l_032_0052C:
        move.w  (dat_060_0000C).l,d0            ; 0052C
        tst.w   $58(a1)                         ; 00532
        bge.b   l_032_0053A                     ; 00536
        neg.w   d0                              ; 00538
l_032_0053A:
        add.w   d0,$58(a1)                      ; 0053A
        bra.w   l_032_00592                     ; 0053E
l_032_00542:
        tst.w   d0                              ; 00542
        bne.b   l_032_00500                     ; 00544
l_032_00546:
        bclr    #$2,$3(a1)                      ; 00546

;-------------------------------------------------------------------------------
; SetAttitude - SetAttitude(a1 = an object, d4-d6 = its three attitude angles): stores the
; angles (+$66, +$68, +$6A), makes its matrix at +$80 from them (AnglesToMatrix), then the
; matrix at +$92 from the negated angles ($7080 - each: the opposite rotation; sub_032_00568).
;-------------------------------------------------------------------------------
SetAttitude:
        movem.w d4-d6,$66(a1)                   ; 0054C
        movem.l d1/d4-d6/a1,-(a7)               ; 00552
        move.w  d4,d0                           ; 00556
        move.w  d5,d2                           ; 00558
        move.w  d6,d4                           ; 0055A
        lea.l   $80(a1),a1                      ; 0055C
        bsr.w   AnglesToMatrix                  ; 00560
        movem.l (a7)+,d1/d5-d7/a1               ; 00564

;-------------------------------------------------------------------------------
; SetInverseMatrix - Makes an object's matrix at +$92 (a1 = the object) from the negated angles
; d5-d7 ($7080 - each).
;-------------------------------------------------------------------------------
SetInverseMatrix:
        adda.w  #$92,a1                         ; 00568
        moveq   #$0,d0                          ; 0056C
        moveq   #$0,d2                          ; 0056E
        moveq   #$0,d4                          ; 00570
        move.w  #$7080,d1                       ; 00572
        tst.w   d5                              ; 00576
        beq.b   l_032_0057E                     ; 00578
        move.w  d1,d0                           ; 0057A
        sub.w   d5,d0                           ; 0057C
l_032_0057E:
        tst.w   d6                              ; 0057E
        beq.b   l_032_00586                     ; 00580
        move.w  d1,d2                           ; 00582
        sub.w   d6,d2                           ; 00584
l_032_00586:
        tst.w   d7                              ; 00586
        beq.b   l_032_0058E                     ; 00588
        move.w  d1,d4                           ; 0058A
        sub.w   d7,d4                           ; 0058C
l_032_0058E:
        bsr.w   AnglesToMatrix2                 ; 0058E
l_032_00592:
        rts                                     ; 00592

;-------------------------------------------------------------------------------
; SetupCamera - The camera, once a frame: from the cockpit (sub_032_00710) or, in the outside
; views (dat_071_00155), from a point near the viewed object (sub_032_005B2).
;-------------------------------------------------------------------------------
SetupCamera:
        tst.b   (dat_071_00155).l               ; 00594
        beq.b   l_032_005A2                     ; 0059A
        bsr.w   SetOutsideCamera                ; 0059C
        rts                                     ; 005A0
l_032_005A2:
        bsr.w   sub_032_00710                   ; 005A2
        rts                                     ; 005A6
l_032_005A8:
        jsr     (sub_020_00B18).l               ; 005A8
        bra.w   l_032_006A8                     ; 005AE

;-------------------------------------------------------------------------------
; SetOutsideCamera - Places the camera outside, near the viewed object (ViewObject, or the
; object in dat_071_00392 when it is a '0' type), at an offset turned by its orientation
; (sub_004_00328).
;-------------------------------------------------------------------------------
SetOutsideCamera:
        tst.b   (dat_071_00184).l               ; 005B2
        beq.b   l_032_005A8                     ; 005B8
        lea.l   (ObjectTable).l,a1              ; 005BA
        move.w  (ViewObject).l,d2               ; 005C0
        bne.b   l_032_005DE                     ; 005C6
        move.w  (dat_071_00392).l,d2            ; 005C8
        btst    #$6,$1(a1,d2.w)                 ; 005CE
        beq.b   l_032_005E0                     ; 005D4
        cmpi.b  #$30,$62(a1,d2.w)               ; 005D6
        bne.b   l_032_005E0                     ; 005DC
l_032_005DE:
        adda.w  d2,a1                           ; 005DE
l_032_005E0:
        move.b  $62(a1),d0                      ; 005E0
        andi.b  #$f0,d0                         ; 005E4
        cmpi.b  #$30,d0                         ; 005E8
        beq.b   l_032_00602                     ; 005EC
        moveq   #$0,d3                          ; 005EE
        moveq   #$0,d4                          ; 005F0
        moveq   #$1,d5                          ; 005F2
        cmpi.b  #$6,(dat_071_0027E).l           ; 005F4
        bne.b   l_032_00608                     ; 005FC
        moveq   #$5,d5                          ; 005FE
        bra.b   l_032_00608                     ; 00600
l_032_00602:
        moveq   #$0,d3                          ; 00602
        moveq   #$0,d4                          ; 00604
        moveq   #-4,d5                          ; 00606
l_032_00608:
        jsr     (sub_004_00328).l               ; 00608
        move.l  d2,d4                           ; 0060E
        move.l  d1,d3                           ; 00610
        move.l  d0,d2                           ; 00612
        sub.l   (CameraX).l,d2                  ; 00614
        sub.l   (CameraY).l,d3                  ; 0061A
        sub.l   (CameraZ).l,d4                  ; 00620
        tst.b   (dat_071_00184).l               ; 00626
        blt.b   l_032_0065A                     ; 0062C
        tst.b   (dat_071_0027E).l               ; 0062E
        beq.b   l_032_0063E                     ; 00634
        move.l  #$230,d5                        ; 00636
        bra.b   l_032_00664                     ; 0063C
l_032_0063E:
        moveq   #$0,d5                          ; 0063E
        move.w  (ViewObject).l,d5               ; 00640
        or.b    (dat_071_00282).l,d5            ; 00646
        cmp.w   (dat_071_00430).l,d5            ; 0064C
        beq.b   l_032_0065E                     ; 00652
        move.w  d5,(dat_071_00430).l            ; 00654
l_032_0065A:
        moveq   #-1,d5                          ; 0065A
        bra.b   l_032_00664                     ; 0065C
l_032_0065E:
        move.l  #$7d0,d5                        ; 0065E
l_032_00664:
        tst.b   (dat_071_0017E).l               ; 00664
        bne.b   l_032_006A8                     ; 0066A
        move.w  (dat_071_00464).l,d0            ; 0066C
        move.w  (dat_071_00466).l,d1            ; 00672
        ext.l   d0                              ; 00678
        ext.l   d1                              ; 0067A
        tst.b   (dat_071_00185).l               ; 0067C
        bne.b   l_032_00686                     ; 00682
        moveq   #-1,d5                          ; 00684
l_032_00686:
        movem.l d0-d5,-(a7)                     ; 00686
        jsr     (VectorToAngles).l              ; 0068A
        adda.w  #$18,a7                         ; 00690
        move.w  (dat_071_00490).l,(dat_071_00464).l ; 00694
        move.w  (dat_071_00492).l,(dat_071_00466).l ; 0069E
l_032_006A8:
        move.w  (dat_071_00464).l,d0            ; 006A8
        move.w  (dat_071_00466).l,d2            ; 006AE
        lea.l   (dat_071_005A8).l,a1            ; 006B4
        bsr.w   sub_032_00F86                   ; 006BA
        lea.l   (dat_071_005A8).l,a1            ; 006BE
        bsr.w   sub_032_011A4                   ; 006C4
        move.w  (dat_071_00466).l,d4            ; 006C8
        lea.l   (dat_071_005CC).l,a1            ; 006CE
        bsr.w   sub_032_00F3E                   ; 006D4
        movem.w (Player_66).l,d0-d2             ; 006D8
        movem.l d0-d2,(dat_071_00458).l         ; 006E0
        rts                                     ; 006E8
sub_032_006EA:
        lea.l   (ObjectTable).l,a0              ; 006EA
        adda.w  (ViewObject).l,a0               ; 006F0
        move.w  #$7080,d1                       ; 006F6
        move.w  $68(a0),d4                      ; 006FA
        beq.b   l_032_00704                     ; 006FE
        sub.w   d4,d1                           ; 00700
        move.w  d1,d4                           ; 00702
l_032_00704:
        lea.l   (dat_071_005DE).l,a1            ; 00704
        bsr.w   sub_032_00F68                   ; 0070A
        rts                                     ; 0070E
sub_032_00710:
        lea.l   (ObjectTable).l,a0              ; 00710
        adda.w  (ViewObject).l,a0               ; 00716
        move.w  $68(a0),d4                      ; 0071C
        lea.l   (dat_071_005CC).l,a1            ; 00720
        bsr.w   sub_032_00F3E                   ; 00726
        lea.l   (ObjectTable).l,a0              ; 0072A
        adda.w  (ViewObject).l,a0               ; 00730
        tst.b   (dat_071_00155).l               ; 00736
        bne.b   l_032_00752                     ; 0073C
        movem.w $66(a0),d0/d2/d4                ; 0073E
        lea.l   (dat_071_005BA).l,a1            ; 00744
        move.l  a0,-(a7)                        ; 0074A
        bsr.w   sub_032_00FD6                   ; 0074C
        movea.l (a7)+,a0                        ; 00750
l_032_00752:
        moveq   #$0,d0                          ; 00752
        moveq   #$0,d2                          ; 00754
        moveq   #$0,d4                          ; 00756
        move.b  $62(a0),d3                      ; 00758
        andi.b  #$f0,d3                         ; 0075C
        move.b  (dat_071_00177).l,d1            ; 00760
        beq.b   l_032_0077E                     ; 00766
        cmpi.b  #$b,d1                          ; 00768
        ble.w   l_032_0083A                     ; 0076C
        subi.b  #$b,d1                          ; 00770
        cmpi.b  #$30,d3                         ; 00774
        bne.b   l_032_007B2                     ; 00778
        bra.w   l_032_007F2                     ; 0077A
l_032_0077E:
        cmpi.b  #$30,d3                         ; 0077E
        bne.b   l_032_0078A                     ; 00782
        moveq   #$c,d1                          ; 00784
        bra.w   l_032_0083A                     ; 00786
l_032_0078A:
        move.b  (dat_071_00181).l,d1            ; 0078A
        cmpi.b  #$1,d1                          ; 00790
        bgt.b   l_032_007A8                     ; 00794
        movem.w $66(a0),d0/d2/d4                ; 00796
        movem.l d0/d2/d4,(dat_071_00458).l      ; 0079C
        bra.w   l_032_00892                     ; 007A4
l_032_007A8:
        subq.b  #$2,d1                          ; 007A8
        beq.w   l_032_00834                     ; 007AA
        bra.w   l_032_0082E                     ; 007AE
l_032_007B2:
        subq.b  #$1,d1                          ; 007B2
        beq.b   l_032_007D6                     ; 007B4
        move.w  $66(a0),d0                      ; 007B6
        cmpi.w  #$230,d0                        ; 007BA
        blt.b   l_032_007C6                     ; 007BE
        cmpi.w  #$6e50,d0                       ; 007C0
        blt.b   l_032_007CE                     ; 007C4
l_032_007C6:
        move.w  #$19f0,d0                       ; 007C6
        bra.w   l_032_00862                     ; 007CA
l_032_007CE:
        move.w  #$1c20,d0                       ; 007CE
        bra.w   l_032_00862                     ; 007D2
l_032_007D6:
        move.w  $66(a0),d0                      ; 007D6
        cmpi.w  #$230,d0                        ; 007DA
        blt.b   l_032_007E6                     ; 007DE
        cmpi.w  #$6e50,d0                       ; 007E0
        blt.b   l_032_007EC                     ; 007E4
l_032_007E6:
        move.w  #$5690,d0                       ; 007E6
        bra.b   l_032_00862                     ; 007EA
l_032_007EC:
        move.w  #$5460,d0                       ; 007EC
        bra.b   l_032_00862                     ; 007F0
l_032_007F2:
        subq.b  #$1,d1                          ; 007F2
        beq.b   l_032_00812                     ; 007F4
        move.w  $66(a0),d0                      ; 007F6
        cmpi.w  #$1e50,d0                       ; 007FA
        bge.b   l_032_0080C                     ; 007FE
        cmpi.w  #$19f0,d0                       ; 00800
        ble.b   l_032_0080C                     ; 00804
        move.w  #$230,d0                        ; 00806
        bra.b   l_032_00862                     ; 0080A
l_032_0080C:
        move.w  #$0,d0                          ; 0080C
        bra.b   l_032_00862                     ; 00810
l_032_00812:
        move.w  $66(a0),d0                      ; 00812
        cmpi.w  #$1e50,d0                       ; 00816
        bge.b   l_032_00828                     ; 0081A
        cmpi.w  #$19f0,d0                       ; 0081C
        ble.b   l_032_00828                     ; 00820
        move.w  #$3610,d0                       ; 00822
        bra.b   l_032_00862                     ; 00826
l_032_00828:
        move.w  #$3840,d0                       ; 00828
        bra.b   l_032_00862                     ; 0082C
l_032_0082E:
        move.w  #$280,d2                        ; 0082E
        bra.b   l_032_00862                     ; 00832
l_032_00834:
        move.w  #$6e00,d2                       ; 00834
        bra.b   l_032_00862                     ; 00838
l_032_0083A:
        cmpi.b  #$30,d3                         ; 0083A
        bne.b   l_032_00848                     ; 0083E
        lea.l   (dat_032_008FC).l,a1            ; 00840
        bra.b   l_032_0084E                     ; 00846
l_032_00848:
        lea.l   (dat_032_008BA).l,a1            ; 00848
l_032_0084E:
        subq.w  #$1,d1                          ; 0084E
        ext.w   d1                              ; 00850
        add.w   d1,d1                           ; 00852
        move.w  d1,d0                           ; 00854
        add.w   d1,d1                           ; 00856
        add.w   d0,d1                           ; 00858
        adda.w  d1,a1                           ; 0085A
        move.w  (a1)+,d0                        ; 0085C
        move.w  (a1)+,d2                        ; 0085E
        move.w  (a1),d4                         ; 00860
l_032_00862:
        move.l  a0,-(a7)                        ; 00862
        movem.w d0/d2/d4,-(a7)                  ; 00864
        lea.l   (dat_071_005F0).l,a1            ; 00868
        bsr.w   sub_032_00FD6                   ; 0086E
        lea.l   (dat_071_005F0).l,a1            ; 00872
        bsr.w   sub_032_011A4                   ; 00878
        movem.w (a7)+,d0/d2/d4                  ; 0087C
        movea.l (a7)+,a0                        ; 00880
        lea.l   $80(a0),a4                      ; 00882
        bsr.w   sub_032_00AD8                   ; 00886
        movem.l d4-d6,(dat_071_00458).l         ; 0088A
l_032_00892:
        move.w  (dat_071_0045A).l,d0            ; 00892
        move.w  (dat_071_0045E).l,d2            ; 00898
        move.w  (dat_071_00462).l,d4            ; 0089E
        lea.l   (dat_071_005A8).l,a1            ; 008A4
        bsr.w   sub_032_00FD6                   ; 008AA
        lea.l   (dat_071_005A8).l,a1            ; 008AE
        bsr.w   sub_032_011A4                   ; 008B4
        rts                                     ; 008B8
dat_032_008BA:
	dc.b	$00,$00,$08,$D0,$00,$00,$00,$00,$12,$C0,$00,$00,$00,$00,$1C,$20
	dc.b	$00,$00,$00,$00,$25,$80,$00,$00,$00,$00,$2E,$E0,$00,$00,$00,$00
	dc.b	$38,$40,$00,$00,$00,$00,$41,$A0,$00,$00,$00,$00,$4B,$00,$00,$00
	dc.b	$00,$00,$54,$60,$00,$00,$00,$00,$5D,$C0,$00,$00,$00,$00,$67,$B0
	dc.b	$00,$00
dat_032_008FC:
	dc.b	$5D,$C0,$1C,$20,$54,$60,$67,$20,$1C,$20,$54,$60,$00,$00,$1C,$20
	dc.b	$54,$60,$09,$60,$1C,$20,$54,$60,$12,$C0,$1C,$20,$54,$60,$1C,$20
	dc.b	$1C,$20,$54,$60,$25,$80,$1C,$20,$54,$60,$2E,$E0,$1C,$20,$54,$60
	dc.b	$38,$40,$1C,$20,$54,$60,$41,$A0,$1C,$20,$54,$60,$4B,$00,$1C,$20
	dc.b	$54,$60,$54,$60,$00,$00,$00,$00,$4E,$75
sub_032_00946:
        movem.l d0-d1/d4/a0,-(a7)               ; 00946
        btst    #$7,$0(a1)                      ; 0094A
        bne.w   l_032_00A72                     ; 00950
        move.w  d7,d4                           ; 00954
        asr.w   #$3,d4                          ; 00956
        move.w  d4,d1                           ; 00958
        cmpi.w  #$384,d4                        ; 0095A
        bge.b   l_032_0096A                     ; 0095E
        bsr.w   sub_032_00A8E                   ; 00960
        bsr.w   SinCos                          ; 00964
        bra.b   l_032_009AA                     ; 00968
l_032_0096A:
        cmpi.w  #$708,d4                        ; 0096A
        bge.b   l_032_00984                     ; 0096E
        bsr.w   sub_032_00A9A                   ; 00970
        move.w  #$708,d3                        ; 00974
        sub.w   d4,d3                           ; 00978
        move.w  d3,d4                           ; 0097A
        bsr.w   SinCos                          ; 0097C
        neg.w   d5                              ; 00980
        bra.b   l_032_009AA                     ; 00982
l_032_00984:
        cmpi.w  #$a8c,d4                        ; 00984
        bge.b   l_032_0099E                     ; 00988
        bsr.w   sub_032_00A9A                   ; 0098A
        move.w  #$e10,d3                        ; 0098E
        sub.w   d4,d3                           ; 00992
        move.w  d3,d4                           ; 00994
        bsr.w   SinCos                          ; 00996
        neg.w   d5                              ; 0099A
        bra.b   l_032_009AA                     ; 0099C
l_032_0099E:
        bsr.w   sub_032_00A8E                   ; 0099E
        subi.w  #$708,d4                        ; 009A2
        bsr.w   SinCos                          ; 009A6
l_032_009AA:
        move.w  d4,$22(a1)                      ; 009AA
        move.w  d5,$24(a1)                      ; 009AE
        move.w  d4,d3                           ; 009B2
        bge.b   l_032_009B8                     ; 009B4
        neg.w   d4                              ; 009B6
l_032_009B8:
        move.w  $54(a1),d1                      ; 009B8
        move.w  d1,d7                           ; 009BC
        tst.w   d5                              ; 009BE
        bge.b   l_032_009C4                     ; 009C0
        neg.w   d4                              ; 009C2
l_032_009C4:
        sub.w   d4,d1                           ; 009C4
        beq.b   l_032_009E0                     ; 009C6
        bgt.b   l_032_009D4                     ; 009C8
        cmpi.w  #$fff9,d1                       ; 009CA
        blt.b   l_032_009DE                     ; 009CE
        moveq   #-1,d1                          ; 009D0
        bra.b   l_032_009E0                     ; 009D2
l_032_009D4:
        cmpi.w  #$7,d1                          ; 009D4
        bgt.b   l_032_009DE                     ; 009D8
        moveq   #$1,d1                          ; 009DA
        bra.b   l_032_009E0                     ; 009DC
l_032_009DE:
        asr.w   #$3,d1                          ; 009DE
l_032_009E0:
        sub.w   d1,d7                           ; 009E0
        move.w  d7,$54(a1)                      ; 009E2
        move.w  d7,d4                           ; 009E6
        bge.b   l_032_009F8                     ; 009E8
        neg.w   d4                              ; 009EA
        tst.w   d5                              ; 009EC
        blt.b   l_032_00A14                     ; 009EE
        cmpi.w  #$100,d5                        ; 009F0
        blt.b   l_032_00A1A                     ; 009F4
        bra.b   l_032_00A02                     ; 009F6
l_032_009F8:
        tst.w   d5                              ; 009F8
        bgt.b   l_032_00A14                     ; 009FA
        cmpi.w  #$ff00,d5                       ; 009FC
        bgt.b   l_032_00A1A                     ; 00A00
l_032_00A02:
        move.w  $50(a1),d6                      ; 00A02
        move.w  $52(a1),d7                      ; 00A06
        eor.w   d6,d7                           ; 00A0A
        blt.b   l_032_00A1A                     ; 00A0C
        neg.w   d3                              ; 00A0E
        neg.w   d5                              ; 00A10
        bra.b   l_032_00A1A                     ; 00A12
l_032_00A14:
        move.w  $50(a1),$52(a1)                 ; 00A14
l_032_00A1A:
        cmp.w   $7e(a1),d4                      ; 00A1A
        ble.b   l_032_00A24                     ; 00A1E
        move.w  $7e(a1),d4                      ; 00A20
l_032_00A24:
        move.w  d4,d7                           ; 00A24
        asr.w   #$2,d7                          ; 00A26
        sub.w   d7,d4                           ; 00A28
        moveq   #$d,d7                          ; 00A2A
        ext.l   d3                              ; 00A2C
        ext.l   d5                              ; 00A2E
        asl.l   #$7,d3                          ; 00A30
        asl.l   #$7,d5                          ; 00A32
        neg.l   d3                              ; 00A34
        neg.l   d5                              ; 00A36
        asr.l   d7,d3                           ; 00A38
        asr.l   d7,d5                           ; 00A3A
        muls.w  d4,d3                           ; 00A3C
        muls.w  d4,d5                           ; 00A3E
        asr.l   d7,d3                           ; 00A40
        asr.l   d7,d5                           ; 00A42
        move.w  $66(a1),d1                      ; 00A44
        cmpi.w  #$3840,d1                       ; 00A48
        blt.b   l_032_00A54                     ; 00A4C
        subi.w  #$7080,d1                       ; 00A4E
        neg.w   d1                              ; 00A52
l_032_00A54:
        cmpi.w  #$e10,d1                        ; 00A54
        bgt.b   l_032_00A72                     ; 00A58
        asr.w   #$8,d1                          ; 00A5A
        add.w   d1,d1                           ; 00A5C
        lea.l   (dat_032_00ABA).l,a0            ; 00A5E
        muls.w  (a0,d1.w),d3                    ; 00A64
        muls.w  (a0,d1.w),d5                    ; 00A68
        asr.l   #$8,d3                          ; 00A6C
        asr.l   #$8,d5                          ; 00A6E
        bra.b   l_032_00A76                     ; 00A70
l_032_00A72:
        clr.w   d3                              ; 00A72
        clr.w   d5                              ; 00A74
l_032_00A76:
        movem.l (a7)+,d0-d1/d4/a0               ; 00A76
        add.w   d3,d0                           ; 00A7A
        add.w   d5,d2                           ; 00A7C
        tst.w   (CurrentObject).l               ; 00A7E
        bne.b   l_032_00A8C                     ; 00A84
        move.w  d3,(dat_071_00316).l            ; 00A86
l_032_00A8C:
        rts                                     ; 00A8C
sub_032_00A8E:
        tst.w   $50(a1)                         ; 00A8E
        bne.b   l_032_00AA8                     ; 00A92
        clr.w   $50(a1)                         ; 00A94
        rts                                     ; 00A98
sub_032_00A9A:
        tst.w   $50(a1)                         ; 00A9A
        beq.b   l_032_00AAE                     ; 00A9E
        move.w  #$ffff,$50(a1)                  ; 00AA0
        rts                                     ; 00AA6
l_032_00AA8:
        clr.w   $50(a1)                         ; 00AA8
        bra.b   l_032_00AB4                     ; 00AAC
l_032_00AAE:
        move.w  #$ffff,$50(a1)                  ; 00AAE
l_032_00AB4:
        neg.w   $54(a1)                         ; 00AB4
        rts                                     ; 00AB8
dat_032_00ABA:
	dc.b	$01,$00,$00,$F0,$00,$DC,$00,$C8,$00,$B4,$00,$A0,$00,$8C,$00,$78
	dc.b	$00,$64,$00,$50,$00,$3C,$00,$28,$00,$14,$00,$00,$00,$00
sub_032_00AD8:
        movem.l d1/a0-a1,-(a7)                  ; 00AD8
        tst.w   d0                              ; 00ADC
        bge.b   l_032_00AE4                     ; 00ADE
        addi.w  #$7080,d0                       ; 00AE0
l_032_00AE4:
        tst.w   d2                              ; 00AE4
        bge.b   l_032_00AEC                     ; 00AE6
        addi.w  #$7080,d2                       ; 00AE8
l_032_00AEC:
        tst.w   d4                              ; 00AEC
        bge.b   l_032_00AF4                     ; 00AEE
        addi.w  #$7080,d4                       ; 00AF0
l_032_00AF4:
        lea.l   (dat_071_00560).l,a1            ; 00AF4
        bsr.w   AnglesToMatrix                  ; 00AFA
        lea.l   (a4),a1                         ; 00AFE
        lea.l   (dat_071_00560).l,a2            ; 00B00
        lea.l   (dat_071_00572).l,a3            ; 00B06
        move.w  (a1),d0                         ; 00B0C
        muls.w  (a2),d0                         ; 00B0E
        move.w  $6(a1),d1                       ; 00B10
        muls.w  $2(a2),d1                       ; 00B14
        move.w  $c(a1),d2                       ; 00B18
        muls.w  $4(a2),d2                       ; 00B1C
        add.l   d1,d0                           ; 00B20
        add.l   d2,d0                           ; 00B22
        move.l  d0,(a3)+                        ; 00B24
        move.w  $2(a1),d0                       ; 00B26
        muls.w  (a2),d0                         ; 00B2A
        move.w  $8(a1),d1                       ; 00B2C
        muls.w  $2(a2),d1                       ; 00B30
        move.w  $e(a1),d2                       ; 00B34
        muls.w  $4(a2),d2                       ; 00B38
        add.l   d1,d0                           ; 00B3C
        add.l   d2,d0                           ; 00B3E
        move.l  d0,(a3)+                        ; 00B40
        move.w  $4(a1),d0                       ; 00B42
        muls.w  (a2),d0                         ; 00B46
        move.w  $a(a1),d1                       ; 00B48
        muls.w  $2(a2),d1                       ; 00B4C
        move.w  $10(a1),d2                      ; 00B50
        muls.w  $4(a2),d2                       ; 00B54
        add.l   d1,d0                           ; 00B58
        add.l   d2,d0                           ; 00B5A
        move.l  d0,(a3)+                        ; 00B5C
        move.w  (a1),d0                         ; 00B5E
        muls.w  $6(a2),d0                       ; 00B60
        move.w  $6(a1),d1                       ; 00B64
        muls.w  $8(a2),d1                       ; 00B68
        move.w  $c(a1),d2                       ; 00B6C
        muls.w  $a(a2),d2                       ; 00B70
        add.l   d1,d0                           ; 00B74
        add.l   d2,d0                           ; 00B76
        move.l  d0,(a3)+                        ; 00B78
        move.w  $2(a1),d0                       ; 00B7A
        muls.w  $6(a2),d0                       ; 00B7E
        move.w  $8(a1),d1                       ; 00B82
        muls.w  $8(a2),d1                       ; 00B86
        move.w  $e(a1),d2                       ; 00B8A
        muls.w  $a(a2),d2                       ; 00B8E
        add.l   d1,d0                           ; 00B92
        add.l   d2,d0                           ; 00B94
        move.l  d0,(a3)+                        ; 00B96
        move.w  $4(a1),d0                       ; 00B98
        muls.w  $6(a2),d0                       ; 00B9C
        move.w  $a(a1),d1                       ; 00BA0
        muls.w  $8(a2),d1                       ; 00BA4
        move.w  $10(a1),d2                      ; 00BA8
        muls.w  $a(a2),d2                       ; 00BAC
        add.l   d1,d0                           ; 00BB0
        add.l   d2,d0                           ; 00BB2
        move.l  d0,(a3)+                        ; 00BB4
        move.w  (a1),d0                         ; 00BB6
        muls.w  $c(a2),d0                       ; 00BB8
        move.w  $6(a1),d1                       ; 00BBC
        muls.w  $e(a2),d1                       ; 00BC0
        move.w  $c(a1),d2                       ; 00BC4
        muls.w  $10(a2),d2                      ; 00BC8
        add.l   d1,d0                           ; 00BCC
        add.l   d2,d0                           ; 00BCE
        move.l  d0,(a3)+                        ; 00BD0
        move.w  $2(a1),d0                       ; 00BD2
        muls.w  $c(a2),d0                       ; 00BD6
        move.w  $8(a1),d1                       ; 00BDA
        muls.w  $e(a2),d1                       ; 00BDE
        move.w  $e(a1),d2                       ; 00BE2
        muls.w  $10(a2),d2                      ; 00BE6
        add.l   d1,d0                           ; 00BEA
        add.l   d2,d0                           ; 00BEC
        move.l  d0,(a3)+                        ; 00BEE
        move.w  $4(a1),d0                       ; 00BF0
        muls.w  $c(a2),d0                       ; 00BF4
        move.w  $a(a1),d1                       ; 00BF8
        muls.w  $e(a2),d1                       ; 00BFC
        move.w  $10(a1),d2                      ; 00C00
        muls.w  $10(a2),d2                      ; 00C04
        add.l   d1,d0                           ; 00C08
        add.l   d2,d0                           ; 00C0A
        move.l  d0,(a3)                         ; 00C0C
        move.l  (dat_071_0058E).l,d0            ; 00C0E
        neg.l   d0                              ; 00C14
        move.l  d0,d1                           ; 00C16
        bge.b   l_032_00C1C                     ; 00C18
        neg.l   d1                              ; 00C1A
l_032_00C1C:
        cmpi.l  #$e210000,d1                    ; 00C1C
        blt.b   l_032_00C74                     ; 00C22
        cmpi.l  #$ff60000,d1                    ; 00C24
        blt.b   l_032_00C4E                     ; 00C2A
        lea.l   (dat_063_008E8).l,a1            ; 00C2C
        moveq   #$c,d2                          ; 00C32
        asr.l   d2,d1                           ; 00C34
        bcc.b   l_032_00C3A                     ; 00C36
        addq.l  #$1,d1                          ; 00C38
l_032_00C3A:
        subi.l  #$ff08,d1                       ; 00C3A
        cmpi.l  #$f8,d1                         ; 00C40
        ble.b   l_032_00C6A                     ; 00C46
        move.w  #$f8,d1                         ; 00C48
        bra.b   l_032_00C6A                     ; 00C4C
l_032_00C4E:
        lea.l   (dat_063_00498).l,a1            ; 00C4E
        moveq   #$10,d2                         ; 00C54
        asr.l   d2,d1                           ; 00C56
        bcc.b   l_032_00C5C                     ; 00C58
        addq.w  #$1,d1                          ; 00C5A
l_032_00C5C:
        subi.w  #$ddb,d1                        ; 00C5C
        cmpi.w  #$225,d1                        ; 00C60
        ble.b   l_032_00C6A                     ; 00C64
        move.w  #$225,d1                        ; 00C66
l_032_00C6A:
        tst.l   d0                              ; 00C6A
        bge.b   l_032_00C70                     ; 00C6C
        neg.w   d1                              ; 00C6E
l_032_00C70:
        move.w  d1,d0                           ; 00C70
        bra.b   l_032_00C82                     ; 00C72
l_032_00C74:
        lea.l   (dat_063_00292).l,a1            ; 00C74
        swap    d0                              ; 00C7A
        asr.w   #$4,d0                          ; 00C7C
        bcc.b   l_032_00C82                     ; 00C7E
        addq.w  #$1,d0                          ; 00C80
l_032_00C82:
        add.w   d0,d0                           ; 00C82
        move.w  d0,d7                           ; 00C84
        blt.b   l_032_00C96                     ; 00C86
        move.w  (a1,d0.w),d2                    ; 00C88
        move.w  d2,d4                           ; 00C8C
        move.w  #$384,d3                        ; 00C8E
        sub.w   d2,d3                           ; 00C92
        bra.b   l_032_00CAA                     ; 00C94
l_032_00C96:
        neg.w   d0                              ; 00C96
        move.w  (a1,d0.w),d1                    ; 00C98
        move.w  #$e10,d2                        ; 00C9C
        sub.w   d1,d2                           ; 00CA0
        move.w  d2,d4                           ; 00CA2
        subi.w  #$a8c,d2                        ; 00CA4
        move.w  d2,d3                           ; 00CA8
l_032_00CAA:
        add.w   d3,d3                           ; 00CAA
        lea.l   (SineTable).l,a0                ; 00CAC
        lea.l   (dat_063_00292).l,a1            ; 00CB2
        move.w  (a0,d3.w),d3                    ; 00CB8
        cmpi.w  #$8f,d3                         ; 00CBC
        bge.b   l_032_00CD4                     ; 00CC0
        tst.w   d7                              ; 00CC2
        bge.b   l_032_00CCC                     ; 00CC4
        move.w  #$a82,d4                        ; 00CC6
        bra.b   l_032_00CD0                     ; 00CCA
l_032_00CCC:
        move.w  #$38e,d4                        ; 00CCC
l_032_00CD0:
        move.w  #$fee2,d3                       ; 00CD0
l_032_00CD4:
        move.l  (dat_071_0058A).l,d0            ; 00CD4
        neg.l   d0                              ; 00CDA
        cmpi.w  #$147,d3                        ; 00CDC
        bgt.b   l_032_00CE8                     ; 00CE0
        asl.w   #$6,d3                          ; 00CE2
        divs.w  d3,d0                           ; 00CE4
        bra.b   l_032_00D10                     ; 00CE6
l_032_00CE8:
        asr.l   #$6,d0                          ; 00CE8
        move.w  d3,d2                           ; 00CEA
        bge.b   l_032_00CF0                     ; 00CEC
        neg.w   d2                              ; 00CEE
l_032_00CF0:
        asr.w   #$1,d2                          ; 00CF0
        divs.w  d3,d0                           ; 00CF2
        swap    d0                              ; 00CF4
        tst.w   d0                              ; 00CF6
        bge.b   l_032_00CFC                     ; 00CF8
        neg.w   d0                              ; 00CFA
l_032_00CFC:
        cmp.w   d0,d2                           ; 00CFC
        bgt.b   l_032_00D0E                     ; 00CFE
        swap    d0                              ; 00D00
        tst.w   d0                              ; 00D02
        bge.b   l_032_00D0A                     ; 00D04
        subq.w  #$1,d0                          ; 00D06
        bra.b   l_032_00D10                     ; 00D08
l_032_00D0A:
        addq.w  #$1,d0                          ; 00D0A
        bra.b   l_032_00D10                     ; 00D0C
l_032_00D0E:
        swap    d0                              ; 00D0E
l_032_00D10:
        add.w   d0,d0                           ; 00D10
        blt.b   l_032_00D6C                     ; 00D12
        cmpi.w  #$180,d0                        ; 00D14
        ble.b   l_032_00D66                     ; 00D18
        move.l  (dat_071_00592).l,d0            ; 00D1A
        cmpi.w  #$147,d3                        ; 00D20
        bgt.b   l_032_00D2C                     ; 00D24
        asl.w   #$6,d3                          ; 00D26
        divs.w  d3,d0                           ; 00D28
        bra.b   l_032_00D54                     ; 00D2A
l_032_00D2C:
        asr.l   #$6,d0                          ; 00D2C
        move.w  d3,d2                           ; 00D2E
        bge.b   l_032_00D34                     ; 00D30
        neg.w   d2                              ; 00D32
l_032_00D34:
        asr.w   #$1,d2                          ; 00D34
        divs.w  d3,d0                           ; 00D36
        swap    d0                              ; 00D38
        tst.w   d0                              ; 00D3A
        bge.b   l_032_00D40                     ; 00D3C
        neg.w   d0                              ; 00D3E
l_032_00D40:
        cmp.w   d0,d2                           ; 00D40
        bgt.b   l_032_00D52                     ; 00D42
        swap    d0                              ; 00D44
        tst.w   d0                              ; 00D46
        bge.b   l_032_00D4E                     ; 00D48
        subq.w  #$1,d0                          ; 00D4A
        bra.b   l_032_00D54                     ; 00D4C
l_032_00D4E:
        addq.w  #$1,d0                          ; 00D4E
        bra.b   l_032_00D54                     ; 00D50
l_032_00D52:
        swap    d0                              ; 00D52
l_032_00D54:
        add.w   d0,d0                           ; 00D54
        bge.b   l_032_00D5A                     ; 00D56
        neg.w   d0                              ; 00D58
l_032_00D5A:
        move.w  (a1,d0.w),d1                    ; 00D5A
        move.w  #$384,d2                        ; 00D5E
        sub.w   d1,d2                           ; 00D62
        bra.b   l_032_00DCC                     ; 00D64
l_032_00D66:
        move.w  (a1,d0.w),d2                    ; 00D66
        bra.b   l_032_00DCC                     ; 00D6A
l_032_00D6C:
        neg.w   d0                              ; 00D6C
        cmpi.w  #$180,d0                        ; 00D6E
        ble.b   l_032_00DC2                     ; 00D72
        move.l  (dat_071_00592).l,d0            ; 00D74
        cmpi.w  #$147,d3                        ; 00D7A
        bgt.b   l_032_00D86                     ; 00D7E
        asl.w   #$6,d3                          ; 00D80
        divs.w  d3,d0                           ; 00D82
        bra.b   l_032_00DAE                     ; 00D84
l_032_00D86:
        asr.l   #$6,d0                          ; 00D86
        move.w  d3,d2                           ; 00D88
        bge.b   l_032_00D8E                     ; 00D8A
        neg.w   d2                              ; 00D8C
l_032_00D8E:
        asr.w   #$1,d2                          ; 00D8E
        divs.w  d3,d0                           ; 00D90
        swap    d0                              ; 00D92
        tst.w   d0                              ; 00D94
        bge.b   l_032_00D9A                     ; 00D96
        neg.w   d0                              ; 00D98
l_032_00D9A:
        cmp.w   d0,d2                           ; 00D9A
        bgt.b   l_032_00DAC                     ; 00D9C
        swap    d0                              ; 00D9E
        tst.w   d0                              ; 00DA0
        bge.b   l_032_00DA8                     ; 00DA2
        subq.w  #$1,d0                          ; 00DA4
        bra.b   l_032_00DAE                     ; 00DA6
l_032_00DA8:
        addq.w  #$1,d0                          ; 00DA8
        bra.b   l_032_00DAE                     ; 00DAA
l_032_00DAC:
        swap    d0                              ; 00DAC
l_032_00DAE:
        add.w   d0,d0                           ; 00DAE
        bge.b   l_032_00DB4                     ; 00DB0
        neg.w   d0                              ; 00DB2
l_032_00DB4:
        move.w  (a1,d0.w),d1                    ; 00DB4
        move.w  #$384,d2                        ; 00DB8
        sub.w   d1,d2                           ; 00DBC
        move.w  d2,d1                           ; 00DBE
        bra.b   l_032_00DC6                     ; 00DC0
l_032_00DC2:
        move.w  (a1,d0.w),d1                    ; 00DC2
l_032_00DC6:
        move.w  #$e10,d2                        ; 00DC6
        sub.w   d1,d2                           ; 00DCA
l_032_00DCC:
        tst.l   (dat_071_0058A).l               ; 00DCC
        blt.b   l_032_00DEA                     ; 00DD2
        tst.l   (dat_071_00592).l               ; 00DD4
        bge.b   l_032_00DFA                     ; 00DDA
        move.w  d2,d1                           ; 00DDC
        cmpi.w  #$708,d1                        ; 00DDE
        ble.b   l_032_00DF4                     ; 00DE2
        move.w  #$1518,d2                       ; 00DE4
        bra.b   l_032_00DF8                     ; 00DE8
l_032_00DEA:
        tst.l   (dat_071_00592).l               ; 00DEA
        bge.b   l_032_00DFA                     ; 00DF0
        move.w  d2,d1                           ; 00DF2
l_032_00DF4:
        move.w  #$708,d2                        ; 00DF4
l_032_00DF8:
        sub.w   d1,d2                           ; 00DF8
l_032_00DFA:
        move.w  d2,d5                           ; 00DFA
        bge.b   l_032_00E00                     ; 00DFC
        neg.w   d5                              ; 00DFE
l_032_00E00:
        move.l  (dat_071_00576).l,d0            ; 00E00
        neg.l   d0                              ; 00E06
        cmpi.w  #$147,d3                        ; 00E08
        bgt.b   l_032_00E14                     ; 00E0C
        asl.w   #$6,d3                          ; 00E0E
        divs.w  d3,d0                           ; 00E10
        bra.b   l_032_00E3C                     ; 00E12
l_032_00E14:
        asr.l   #$6,d0                          ; 00E14
        move.w  d3,d6                           ; 00E16
        bge.b   l_032_00E1C                     ; 00E18
        neg.w   d6                              ; 00E1A
l_032_00E1C:
        asr.w   #$1,d6                          ; 00E1C
        divs.w  d3,d0                           ; 00E1E
        swap    d0                              ; 00E20
        tst.w   d0                              ; 00E22
        bge.b   l_032_00E28                     ; 00E24
        neg.w   d0                              ; 00E26
l_032_00E28:
        cmp.w   d0,d6                           ; 00E28
        bgt.b   l_032_00E3A                     ; 00E2A
        swap    d0                              ; 00E2C
        tst.w   d0                              ; 00E2E
        bge.b   l_032_00E36                     ; 00E30
        subq.w  #$1,d0                          ; 00E32
        bra.b   l_032_00E3C                     ; 00E34
l_032_00E36:
        addq.w  #$1,d0                          ; 00E36
        bra.b   l_032_00E3C                     ; 00E38
l_032_00E3A:
        swap    d0                              ; 00E3A
l_032_00E3C:
        add.w   d0,d0                           ; 00E3C
        blt.b   l_032_00E98                     ; 00E3E
        cmpi.w  #$180,d0                        ; 00E40
        ble.b   l_032_00E92                     ; 00E44
        move.l  (dat_071_00582).l,d0            ; 00E46
        cmpi.w  #$147,d3                        ; 00E4C
        bgt.b   l_032_00E58                     ; 00E50
        asl.w   #$6,d3                          ; 00E52
        divs.w  d3,d0                           ; 00E54
        bra.b   l_032_00E80                     ; 00E56
l_032_00E58:
        asr.l   #$6,d0                          ; 00E58
        move.w  d3,d6                           ; 00E5A
        bge.b   l_032_00E60                     ; 00E5C
        neg.w   d6                              ; 00E5E
l_032_00E60:
        asr.w   #$1,d6                          ; 00E60
        divs.w  d3,d0                           ; 00E62
        swap    d0                              ; 00E64
        tst.w   d0                              ; 00E66
        bge.b   l_032_00E6C                     ; 00E68
        neg.w   d0                              ; 00E6A
l_032_00E6C:
        cmp.w   d0,d6                           ; 00E6C
        bgt.b   l_032_00E7E                     ; 00E6E
        swap    d0                              ; 00E70
        tst.w   d0                              ; 00E72
        bge.b   l_032_00E7A                     ; 00E74
        subq.w  #$1,d0                          ; 00E76
        bra.b   l_032_00E80                     ; 00E78
l_032_00E7A:
        addq.w  #$1,d0                          ; 00E7A
        bra.b   l_032_00E80                     ; 00E7C
l_032_00E7E:
        swap    d0                              ; 00E7E
l_032_00E80:
        add.w   d0,d0                           ; 00E80
        bge.b   l_032_00E86                     ; 00E82
        neg.w   d0                              ; 00E84
l_032_00E86:
        move.w  (a1,d0.w),d1                    ; 00E86
        move.w  #$384,d6                        ; 00E8A
        sub.w   d1,d6                           ; 00E8E
        bra.b   l_032_00EF8                     ; 00E90
l_032_00E92:
        move.w  (a1,d0.w),d6                    ; 00E92
        bra.b   l_032_00EF8                     ; 00E96
l_032_00E98:
        neg.w   d0                              ; 00E98
        cmpi.w  #$180,d0                        ; 00E9A
        ble.b   l_032_00EEE                     ; 00E9E
        move.l  (dat_071_00582).l,d0            ; 00EA0
        cmpi.w  #$147,d3                        ; 00EA6
        bgt.b   l_032_00EB2                     ; 00EAA
        asl.w   #$6,d3                          ; 00EAC
        divs.w  d3,d0                           ; 00EAE
        bra.b   l_032_00EDA                     ; 00EB0
l_032_00EB2:
        asr.l   #$6,d0                          ; 00EB2
        move.w  d3,d6                           ; 00EB4
        bge.b   l_032_00EBA                     ; 00EB6
        neg.w   d6                              ; 00EB8
l_032_00EBA:
        asr.w   #$1,d6                          ; 00EBA
        divs.w  d3,d0                           ; 00EBC
        swap    d0                              ; 00EBE
        tst.w   d0                              ; 00EC0
        bge.b   l_032_00EC6                     ; 00EC2
        neg.w   d0                              ; 00EC4
l_032_00EC6:
        cmp.w   d0,d6                           ; 00EC6
        bgt.b   l_032_00ED8                     ; 00EC8
        swap    d0                              ; 00ECA
        tst.w   d0                              ; 00ECC
        bge.b   l_032_00ED4                     ; 00ECE
        subq.w  #$1,d0                          ; 00ED0
        bra.b   l_032_00EDA                     ; 00ED2
l_032_00ED4:
        addq.w  #$1,d0                          ; 00ED4
        bra.b   l_032_00EDA                     ; 00ED6
l_032_00ED8:
        swap    d0                              ; 00ED8
l_032_00EDA:
        add.w   d0,d0                           ; 00EDA
        bge.b   l_032_00EE0                     ; 00EDC
        neg.w   d0                              ; 00EDE
l_032_00EE0:
        move.w  (a1,d0.w),d1                    ; 00EE0
        move.w  #$384,d6                        ; 00EE4
        sub.w   d1,d6                           ; 00EE8
        move.w  d6,d1                           ; 00EEA
        bra.b   l_032_00EF2                     ; 00EEC
l_032_00EEE:
        move.w  (a1,d0.w),d1                    ; 00EEE
l_032_00EF2:
        move.w  #$e10,d6                        ; 00EF2
        sub.w   d1,d6                           ; 00EF6
l_032_00EF8:
        tst.l   (dat_071_00576).l               ; 00EF8
        blt.b   l_032_00F16                     ; 00EFE
        tst.l   (dat_071_00582).l               ; 00F00
        bge.b   l_032_00F26                     ; 00F06
        move.w  d6,d1                           ; 00F08
        cmpi.w  #$708,d1                        ; 00F0A
        ble.b   l_032_00F20                     ; 00F0E
        move.w  #$1518,d6                       ; 00F10
        bra.b   l_032_00F24                     ; 00F14
l_032_00F16:
        tst.l   (dat_071_00582).l               ; 00F16
        bge.b   l_032_00F26                     ; 00F1C
        move.w  d6,d1                           ; 00F1E
l_032_00F20:
        move.w  #$708,d6                        ; 00F20
l_032_00F24:
        sub.w   d1,d6                           ; 00F24
l_032_00F26:
        tst.w   d6                              ; 00F26
        bge.b   l_032_00F2C                     ; 00F28
        neg.w   d6                              ; 00F2A
l_032_00F2C:
        ext.l   d4                              ; 00F2C
        asl.l   #$3,d4                          ; 00F2E
        ext.l   d5                              ; 00F30
        asl.l   #$3,d5                          ; 00F32
        ext.l   d6                              ; 00F34
        asl.l   #$3,d6                          ; 00F36
        movem.l (a7)+,d1/a0-a1                  ; 00F38
        rts                                     ; 00F3C
sub_032_00F3E:
        asr.w   #$3,d4                          ; 00F3E
        bsr.w   SinCos                          ; 00F40
        move.w  d5,d6                           ; 00F44
        asr.w   #$6,d6                          ; 00F46
        move.w  d6,(a1)+                        ; 00F48
        clr.w   (a1)+                           ; 00F4A
        move.w  d4,d6                           ; 00F4C
        asr.w   #$6,d6                          ; 00F4E
        move.w  d6,(a1)+                        ; 00F50
        clr.w   (a1)+                           ; 00F52
        move.w  #$100,(a1)+                     ; 00F54
        clr.w   (a1)+                           ; 00F58
        asr.w   #$6,d4                          ; 00F5A
        neg.w   d4                              ; 00F5C
        move.w  d4,(a1)+                        ; 00F5E
        clr.w   (a1)+                           ; 00F60
        asr.w   #$6,d5                          ; 00F62
        move.w  d5,(a1)+                        ; 00F64
        rts                                     ; 00F66
sub_032_00F68:
        asr.w   #$3,d4                          ; 00F68
        bsr.w   SinCos                          ; 00F6A
        move.w  d5,(a1)+                        ; 00F6E
        clr.w   (a1)+                           ; 00F70
        move.w  d4,(a1)+                        ; 00F72
        clr.w   (a1)+                           ; 00F74
        move.w  #$4000,(a1)+                    ; 00F76
        clr.w   (a1)+                           ; 00F7A
        neg.w   d4                              ; 00F7C
        move.w  d4,(a1)+                        ; 00F7E
        clr.w   (a1)+                           ; 00F80
        move.w  d5,(a1)+                        ; 00F82
        rts                                     ; 00F84
sub_032_00F86:
        lsr.w   #$3,d0                          ; 00F86
        lsr.w   #$3,d2                          ; 00F88
        bsr.w   SinCos2                         ; 00F8A
        move.w  d3,d6                           ; 00F8E
        asr.w   #$6,d6                          ; 00F90
        move.w  d6,(a1)+                        ; 00F92
        clr.w   (a1)+                           ; 00F94
        move.w  d2,d6                           ; 00F96
        asr.w   #$6,d6                          ; 00F98
        move.w  d6,(a1)+                        ; 00F9A
        move.w  d2,d6                           ; 00F9C
        muls.w  d0,d6                           ; 00F9E
        swap    d6                              ; 00FA0
        asr.w   #$4,d6                          ; 00FA2
        neg.w   d6                              ; 00FA4
        move.w  d6,(a1)+                        ; 00FA6
        move.w  d1,d6                           ; 00FA8
        asr.w   #$6,d6                          ; 00FAA
        move.w  d6,(a1)+                        ; 00FAC
        move.w  d3,d6                           ; 00FAE
        muls.w  d0,d6                           ; 00FB0
        swap    d6                              ; 00FB2
        asr.w   #$4,d6                          ; 00FB4
        move.w  d6,(a1)+                        ; 00FB6
        move.w  d2,d6                           ; 00FB8
        muls.w  d1,d6                           ; 00FBA
        swap    d6                              ; 00FBC
        asr.w   #$4,d6                          ; 00FBE
        neg.w   d6                              ; 00FC0
        move.w  d6,(a1)+                        ; 00FC2
        neg.w   d0                              ; 00FC4
        asr.w   #$6,d0                          ; 00FC6
        move.w  d0,(a1)+                        ; 00FC8
        move.w  d3,d6                           ; 00FCA
        muls.w  d1,d6                           ; 00FCC
        swap    d6                              ; 00FCE
        asr.w   #$4,d6                          ; 00FD0
        move.w  d6,(a1)                         ; 00FD2
        rts                                     ; 00FD4
sub_032_00FD6:
        lsr.w   #$3,d0                          ; 00FD6
        lsr.w   #$3,d2                          ; 00FD8
        lsr.w   #$3,d4                          ; 00FDA
        bsr.w   SinCos2                         ; 00FDC
        bsr.w   SinCos                          ; 00FE0
        move.w  d2,d6                           ; 00FE4
        muls.w  d0,d6                           ; 00FE6
        moveq   #$e,d7                          ; 00FE8
        asr.l   d7,d6                           ; 00FEA
        muls.w  d4,d6                           ; 00FEC
        move.w  d3,d7                           ; 00FEE
        muls.w  d5,d7                           ; 00FF0
        add.l   d6,d7                           ; 00FF2
        swap    d7                              ; 00FF4
        asr.w   #$4,d7                          ; 00FF6
        move.w  d7,(a1)+                        ; 00FF8
        move.w  d1,d6                           ; 00FFA
        muls.w  d4,d6                           ; 00FFC
        swap    d6                              ; 00FFE
        asr.w   #$4,d6                          ; 01000
        neg.w   d6                              ; 01002
        move.w  d6,(a1)+                        ; 01004
        move.w  d3,d6                           ; 01006
        muls.w  d0,d6                           ; 01008
        swap    d7                              ; 0100A
        moveq   #$e,d7                          ; 0100C
        asr.l   d7,d6                           ; 0100E
        muls.w  d4,d6                           ; 01010
        move.w  d2,d7                           ; 01012
        muls.w  d5,d7                           ; 01014
        sub.l   d6,d7                           ; 01016
        swap    d7                              ; 01018
        asr.w   #$4,d7                          ; 0101A
        move.w  d7,(a1)+                        ; 0101C
        move.w  d2,d6                           ; 0101E
        muls.w  d0,d6                           ; 01020
        moveq   #$e,d7                          ; 01022
        asr.l   d7,d6                           ; 01024
        muls.w  d5,d6                           ; 01026
        move.w  d3,d7                           ; 01028
        muls.w  d4,d7                           ; 0102A
        sub.l   d6,d7                           ; 0102C
        swap    d7                              ; 0102E
        asr.w   #$4,d7                          ; 01030
        move.w  d7,(a1)+                        ; 01032
        move.w  d1,d6                           ; 01034
        muls.w  d5,d6                           ; 01036
        swap    d6                              ; 01038
        asr.w   #$4,d6                          ; 0103A
        move.w  d6,(a1)+                        ; 0103C
        move.w  d3,d6                           ; 0103E
        muls.w  d0,d6                           ; 01040
        moveq   #$e,d7                          ; 01042
        asr.l   d7,d6                           ; 01044
        muls.w  d5,d6                           ; 01046
        move.w  d2,d7                           ; 01048
        muls.w  d4,d7                           ; 0104A
        add.l   d6,d7                           ; 0104C
        swap    d7                              ; 0104E
        asr.w   #$4,d7                          ; 01050
        move.w  d7,(a1)+                        ; 01052
        move.w  d2,d6                           ; 01054
        muls.w  d1,d6                           ; 01056
        swap    d6                              ; 01058
        asr.w   #$4,d6                          ; 0105A
        neg.w   d6                              ; 0105C
        move.w  d6,(a1)+                        ; 0105E
        asr.w   #$6,d0                          ; 01060
        neg.w   d0                              ; 01062
        move.w  d0,(a1)+                        ; 01064
        move.w  d3,d6                           ; 01066
        muls.w  d1,d6                           ; 01068
        swap    d6                              ; 0106A
        asr.w   #$4,d6                          ; 0106C
        move.w  d6,(a1)                         ; 0106E
        rts                                     ; 01070

;-------------------------------------------------------------------------------
; AnglesToMatrix - Makes a 3 x 3 rotation matrix (9 words, 2.14, written at (a1)+) from three
; angles d0, d2, d4 (1/80 degree; SinCos2, SinCos).
;-------------------------------------------------------------------------------
AnglesToMatrix:
        lsr.w   #$3,d0                          ; 01072
        lsr.w   #$3,d2                          ; 01074
        lsr.w   #$3,d4                          ; 01076
        bsr.w   SinCos2                         ; 01078
        bsr.w   SinCos                          ; 0107C
        move.w  d2,d6                           ; 01080
        muls.w  d0,d6                           ; 01082
        moveq   #$e,d7                          ; 01084
        asr.l   d7,d6                           ; 01086
        muls.w  d4,d6                           ; 01088
        move.w  d3,d7                           ; 0108A
        muls.w  d5,d7                           ; 0108C
        add.l   d6,d7                           ; 0108E
        moveq   #$e,d6                          ; 01090
        asr.l   d6,d7                           ; 01092
        move.w  d7,(a1)+                        ; 01094
        move.w  d1,d6                           ; 01096
        muls.w  d4,d6                           ; 01098
        moveq   #$e,d7                          ; 0109A
        asr.l   d7,d6                           ; 0109C
        neg.w   d6                              ; 0109E
        move.w  d6,(a1)+                        ; 010A0
        move.w  d3,d6                           ; 010A2
        muls.w  d0,d6                           ; 010A4
        swap    d7                              ; 010A6
        moveq   #$e,d7                          ; 010A8
        asr.l   d7,d6                           ; 010AA
        muls.w  d4,d6                           ; 010AC
        move.w  d2,d7                           ; 010AE
        muls.w  d5,d7                           ; 010B0
        sub.l   d6,d7                           ; 010B2
        moveq   #$e,d6                          ; 010B4
        asr.l   d6,d7                           ; 010B6
        move.w  d7,(a1)+                        ; 010B8
        move.w  d2,d6                           ; 010BA
        muls.w  d0,d6                           ; 010BC
        moveq   #$e,d7                          ; 010BE
        asr.l   d7,d6                           ; 010C0
        muls.w  d5,d6                           ; 010C2
        move.w  d3,d7                           ; 010C4
        muls.w  d4,d7                           ; 010C6
        sub.l   d6,d7                           ; 010C8
        moveq   #$e,d6                          ; 010CA
        asr.l   d6,d7                           ; 010CC
        move.w  d7,(a1)+                        ; 010CE
        move.w  d1,d6                           ; 010D0
        muls.w  d5,d6                           ; 010D2
        moveq   #$e,d7                          ; 010D4
        asr.l   d7,d6                           ; 010D6
        move.w  d6,(a1)+                        ; 010D8
        move.w  d3,d6                           ; 010DA
        muls.w  d0,d6                           ; 010DC
        moveq   #$e,d7                          ; 010DE
        asr.l   d7,d6                           ; 010E0
        muls.w  d5,d6                           ; 010E2
        move.w  d2,d7                           ; 010E4
        muls.w  d4,d7                           ; 010E6
        add.l   d6,d7                           ; 010E8
        moveq   #$e,d6                          ; 010EA
        asr.l   d6,d7                           ; 010EC
        move.w  d7,(a1)+                        ; 010EE
        move.w  d2,d6                           ; 010F0
        muls.w  d1,d6                           ; 010F2
        moveq   #$e,d7                          ; 010F4
        asr.l   d7,d6                           ; 010F6
        neg.w   d6                              ; 010F8
        move.w  d6,(a1)+                        ; 010FA
        neg.w   d0                              ; 010FC
        move.w  d0,(a1)+                        ; 010FE
        move.w  d3,d6                           ; 01100
        muls.w  d1,d6                           ; 01102
        moveq   #$e,d7                          ; 01104
        asr.l   d7,d6                           ; 01106
        move.w  d6,(a1)                         ; 01108
        rts                                     ; 0110A

;-------------------------------------------------------------------------------
; AnglesToMatrix2 - The same for the record's second matrix (+$92).
;-------------------------------------------------------------------------------
AnglesToMatrix2:
        lsr.w   #$3,d0                          ; 0110C
        lsr.w   #$3,d2                          ; 0110E
        lsr.w   #$3,d4                          ; 01110
        bsr.w   SinCos2                         ; 01112
        bsr.w   SinCos                          ; 01116
        move.w  d4,d6                           ; 0111A
        muls.w  d0,d6                           ; 0111C
        moveq   #$e,d7                          ; 0111E
        asr.l   d7,d6                           ; 01120
        muls.w  d2,d6                           ; 01122
        move.w  d5,d7                           ; 01124
        muls.w  d3,d7                           ; 01126
        sub.l   d6,d7                           ; 01128
        moveq   #$e,d6                          ; 0112A
        asr.l   d6,d7                           ; 0112C
        move.w  d7,(a1)+                        ; 0112E
        move.w  d5,d6                           ; 01130
        muls.w  d0,d6                           ; 01132
        moveq   #$e,d7                          ; 01134
        asr.l   d7,d6                           ; 01136
        muls.w  d2,d6                           ; 01138
        move.w  d4,d7                           ; 0113A
        muls.w  d3,d7                           ; 0113C
        add.l   d6,d7                           ; 0113E
        moveq   #$e,d6                          ; 01140
        asr.l   d6,d7                           ; 01142
        neg.w   d7                              ; 01144
        move.w  d7,(a1)+                        ; 01146
        move.w  d1,d6                           ; 01148
        muls.w  d2,d6                           ; 0114A
        moveq   #$e,d7                          ; 0114C
        asr.l   d7,d6                           ; 0114E
        move.w  d6,(a1)+                        ; 01150
        move.w  d4,d6                           ; 01152
        muls.w  d1,d6                           ; 01154
        moveq   #$e,d7                          ; 01156
        asr.l   d7,d6                           ; 01158
        move.w  d6,(a1)+                        ; 0115A
        move.w  d5,d6                           ; 0115C
        muls.w  d1,d6                           ; 0115E
        moveq   #$e,d7                          ; 01160
        asr.l   d7,d6                           ; 01162
        move.w  d6,(a1)+                        ; 01164
        move.w  d0,d6                           ; 01166
        move.w  d6,(a1)+                        ; 01168
        move.w  d4,d6                           ; 0116A
        muls.w  d0,d6                           ; 0116C
        moveq   #$e,d7                          ; 0116E
        asr.l   d7,d6                           ; 01170
        muls.w  d3,d6                           ; 01172
        move.w  d5,d7                           ; 01174
        muls.w  d2,d7                           ; 01176
        add.l   d6,d7                           ; 01178
        moveq   #$e,d6                          ; 0117A
        asr.l   d6,d7                           ; 0117C
        neg.w   d7                              ; 0117E
        move.w  d7,(a1)+                        ; 01180
        move.w  d5,d6                           ; 01182
        muls.w  d0,d6                           ; 01184
        moveq   #$e,d7                          ; 01186
        asr.l   d7,d6                           ; 01188
        muls.w  d3,d6                           ; 0118A
        move.w  d4,d7                           ; 0118C
        muls.w  d2,d7                           ; 0118E
        sub.l   d6,d7                           ; 01190
        moveq   #$e,d6                          ; 01192
        asr.l   d6,d7                           ; 01194
        move.w  d7,(a1)+                        ; 01196
        move.w  d1,d6                           ; 01198
        muls.w  d3,d6                           ; 0119A
        moveq   #$e,d7                          ; 0119C
        asr.l   d7,d6                           ; 0119E
        move.w  d6,(a1)                         ; 011A0
        rts                                     ; 011A2
sub_032_011A4:
        movem.w (dat_071_0040E).l,d0-d2         ; 011A4
        movem.w (a1),d3-d5                      ; 011AC
        muls.w  d0,d3                           ; 011B0
        muls.w  d0,d4                           ; 011B2
        muls.w  d0,d5                           ; 011B4
        asr.l   #$8,d3                          ; 011B6
        asr.l   #$8,d4                          ; 011B8
        asr.l   #$8,d5                          ; 011BA
        movem.w d3-d5,(a1)                      ; 011BC
        addq.w  #$6,a1                          ; 011C0
        movem.w (a1),d3-d5                      ; 011C2
        muls.w  d1,d3                           ; 011C6
        muls.w  d1,d4                           ; 011C8
        muls.w  d1,d5                           ; 011CA
        asr.l   #$8,d3                          ; 011CC
        asr.l   #$8,d4                          ; 011CE
        asr.l   #$8,d5                          ; 011D0
        movem.w d3-d5,(a1)                      ; 011D2
        addq.w  #$6,a1                          ; 011D6
        movem.w (a1),d3-d5                      ; 011D8
        muls.w  d2,d3                           ; 011DC
        muls.w  d2,d4                           ; 011DE
        muls.w  d2,d5                           ; 011E0
        asr.l   #$8,d3                          ; 011E2
        asr.l   #$8,d4                          ; 011E4
        asr.l   #$8,d5                          ; 011E6
        movem.w d3-d5,(a1)                      ; 011E8
        rts                                     ; 011EC

;-------------------------------------------------------------------------------
; SinCos2 - The sines and cosines of two angles (d0, d2: tenths of a degree, 0-3599) from
; SineTable, by quadrant: d0 = sin, d1 = cos of the first, d2 = sin, d3 = cos of the second
; (2.14).
;-------------------------------------------------------------------------------
SinCos2:
        add.w   d0,d0                           ; 011EE
        add.w   d2,d2                           ; 011F0
        lea.l   (SineTable).l,a0                ; 011F2
        move.w  d0,d7                           ; 011F8
        cmpi.w  #$708,d0                        ; 011FA
        bge.b   l_032_01210                     ; 011FE
        move.w  (a0,d0.w),d0                    ; 01200
        move.w  #$708,d6                        ; 01204
        sub.w   d7,d6                           ; 01208
        move.w  (a0,d6.w),d1                    ; 0120A
        bra.b   l_032_01264                     ; 0120E
l_032_01210:
        cmpi.w  #$e10,d0                        ; 01210
        bge.b   l_032_0122E                     ; 01214
        move.w  #$e10,d6                        ; 01216
        sub.w   d0,d6                           ; 0121A
        move.w  (a0,d6.w),d0                    ; 0121C
        move.w  #$708,d6                        ; 01220
        sub.w   d6,d7                           ; 01224
        move.w  (a0,d7.w),d1                    ; 01226
        neg.w   d1                              ; 0122A
        bra.b   l_032_01264                     ; 0122C
l_032_0122E:
        cmpi.w  #$1518,d0                       ; 0122E
        bge.b   l_032_0124E                     ; 01232
        move.w  #$e10,d6                        ; 01234
        sub.w   d6,d0                           ; 01238
        move.w  (a0,d0.w),d0                    ; 0123A
        neg.w   d0                              ; 0123E
        move.w  #$1518,d6                       ; 01240
        sub.w   d7,d6                           ; 01244
        move.w  (a0,d6.w),d1                    ; 01246
        neg.w   d1                              ; 0124A
        bra.b   l_032_01264                     ; 0124C
l_032_0124E:
        move.w  #$1c20,d6                       ; 0124E
        sub.w   d0,d6                           ; 01252
        move.w  (a0,d6.w),d0                    ; 01254
        neg.w   d0                              ; 01258
        move.w  #$1518,d6                       ; 0125A
        sub.w   d6,d7                           ; 0125E
        move.w  (a0,d7.w),d1                    ; 01260
l_032_01264:
        move.w  d2,d7                           ; 01264
        cmpi.w  #$708,d2                        ; 01266
        bge.b   l_032_0127C                     ; 0126A
        move.w  (a0,d2.w),d2                    ; 0126C
        move.w  #$708,d6                        ; 01270
        sub.w   d7,d6                           ; 01274
        move.w  (a0,d6.w),d3                    ; 01276
        bra.b   l_032_012D0                     ; 0127A
l_032_0127C:
        cmpi.w  #$e10,d2                        ; 0127C
        bge.b   l_032_0129A                     ; 01280
        move.w  #$e10,d6                        ; 01282
        sub.w   d2,d6                           ; 01286
        move.w  (a0,d6.w),d2                    ; 01288
        move.w  #$708,d6                        ; 0128C
        sub.w   d6,d7                           ; 01290
        move.w  (a0,d7.w),d3                    ; 01292
        neg.w   d3                              ; 01296
        bra.b   l_032_012D0                     ; 01298
l_032_0129A:
        cmpi.w  #$1518,d2                       ; 0129A
        bge.b   l_032_012BA                     ; 0129E
        move.w  #$e10,d6                        ; 012A0
        sub.w   d6,d2                           ; 012A4
        move.w  (a0,d2.w),d2                    ; 012A6
        neg.w   d2                              ; 012AA
        move.w  #$1518,d6                       ; 012AC
        sub.w   d7,d6                           ; 012B0
        move.w  (a0,d6.w),d3                    ; 012B2
        neg.w   d3                              ; 012B6
        bra.b   l_032_012D0                     ; 012B8
l_032_012BA:
        move.w  #$1c20,d6                       ; 012BA
        sub.w   d2,d6                           ; 012BE
        move.w  (a0,d6.w),d2                    ; 012C0
        neg.w   d2                              ; 012C4
        move.w  #$1518,d6                       ; 012C6
        sub.w   d6,d7                           ; 012CA
        move.w  (a0,d7.w),d3                    ; 012CC
l_032_012D0:
        rts                                     ; 012D0

;-------------------------------------------------------------------------------
; SinCos - The sine and cosine of the angle in d4 (tenths of a degree): d4 = sin, d5 = cos
; (2.14).
;-------------------------------------------------------------------------------
SinCos:
        add.w   d4,d4                           ; 012D2
        lea.l   (SineTable).l,a0                ; 012D4
        move.w  d4,d7                           ; 012DA
        cmpi.w  #$708,d4                        ; 012DC
        bge.b   l_032_012F2                     ; 012E0
        move.w  (a0,d4.w),d4                    ; 012E2
        move.w  #$708,d6                        ; 012E6
        sub.w   d7,d6                           ; 012EA
        move.w  (a0,d6.w),d5                    ; 012EC
        bra.b   l_032_01346                     ; 012F0
l_032_012F2:
        cmpi.w  #$e10,d4                        ; 012F2
        bge.b   l_032_01310                     ; 012F6
        move.w  #$e10,d6                        ; 012F8
        sub.w   d4,d6                           ; 012FC
        move.w  (a0,d6.w),d4                    ; 012FE
        move.w  #$708,d6                        ; 01302
        sub.w   d6,d7                           ; 01306
        move.w  (a0,d7.w),d5                    ; 01308
        neg.w   d5                              ; 0130C
        bra.b   l_032_01346                     ; 0130E
l_032_01310:
        cmpi.w  #$1518,d4                       ; 01310
        bge.b   l_032_01330                     ; 01314
        move.w  #$e10,d6                        ; 01316
        sub.w   d6,d4                           ; 0131A
        move.w  (a0,d4.w),d4                    ; 0131C
        neg.w   d4                              ; 01320
        move.w  #$1518,d6                       ; 01322
        sub.w   d7,d6                           ; 01326
        move.w  (a0,d6.w),d5                    ; 01328
        neg.w   d5                              ; 0132C
        bra.b   l_032_01346                     ; 0132E
l_032_01330:
        move.w  #$1c20,d6                       ; 01330
        sub.w   d4,d6                           ; 01334
        move.w  (a0,d6.w),d4                    ; 01336
        neg.w   d4                              ; 0133A
        move.w  #$1518,d6                       ; 0133C
        sub.w   d6,d7                           ; 01340
        move.w  (a0,d7.w),d5                    ; 01342
l_032_01346:
        rts                                     ; 01346
h032_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    3,32                            ; 3 longs pointing into hunk 32
	dc.l	$A60,$84A,$842
        dc.l    86,71                           ; 86 longs pointing into hunk 71
	dc.l	$A88,$78,$6A0,$72,$696,$616,$61C,$622
	dc.l	$67E,$5B4,$628,$264,$11A8,$648,$64E,$656
	dc.l	$5F8,$630,$25E,$5BC,$6DC,$6EC,$712,$72C
	dc.l	$96,$2DE,$3CE,$A80,$5CA,$18,$9E,$2C6
	dc.l	$666,$2C0,$5C2,$642,$6F2,$718,$732,$2E6
	dc.l	$78C,$762,$2E,$596,$738,$204,$86A,$874
	dc.l	$706,$746,$AF6,$B02,$6D0,$722,$6B6,$6C0
	dc.l	$8A6,$8B0,$B08,$C10,$CD6,$D1C,$D76,$DCE
	dc.l	$DD6,$DEC,$E02,$E48,$EA2,$EFA,$F02,$F18
	dc.l	$3C4,$674,$6A4,$6B0,$6CA,$66E,$69A,$6AA
	dc.l	$8A0,$89A,$6E4,$7A0,$88E,$894
        dc.l    1,4                             ; 1 longs pointing into hunk 4
	dc.l	$60A
        dc.l    1,0                             ; 1 longs pointing into hunk 0
	dc.l	$212
        dc.l    1,20                            ; 1 longs pointing into hunk 20
	dc.l	$5AA
        dc.l    2,0                             ; 2 longs pointing into hunk 0
	dc.l	$66,$68C
        dc.l    2,60                            ; 2 longs pointing into hunk 60
	dc.l	$518,$52E
        dc.l    7,63                            ; 7 longs pointing into hunk 63
	dc.l	$C2E,$C50,$C76,$CB4,$CAE,$11F4,$12D6
	dc.l	0
	dc.l	HUNK_END
	endc
