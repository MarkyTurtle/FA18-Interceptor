; F/A-18 Interceptor - hunk 34 (code)
; Where the horizon crosses the view's edges, for MakeSkyPolygon (not worked out in detail
; yet).
; Included by ../f18_main.s.

;===============================================================================
; Hunk 34: CODE, $510 bytes
;===============================================================================
	CODE_HUNK	h034
sub_034_00000:
        link.w  a6,#$fffc                       ; 00000
        clr.b   -$2(a6)                         ; 00004
        lea.l   (dat_072_03600).l,a0            ; 00008
        lea.l   (dat_072_03000).l,a1            ; 0000E
        clr.w   d0                              ; 00014
        move.w  #$7,$8(a6)                      ; 00016
l_034_0001C:
        btst    #$0,d0                          ; 0001C
        beq.b   l_034_00034                     ; 00020
        move.w  d0,d3                           ; 00022
        addq.w  #$1,d3                          ; 00024
        cmp.w   $8(a6),d3                       ; 00026
        ble.b   l_034_0002E                     ; 0002A
        clr.w   d3                              ; 0002C
l_034_0002E:
        move.w  d0,d1                           ; 0002E
        subq.w  #$1,d1                          ; 00030
        bra.b   l_034_00042                     ; 00032
l_034_00034:
        move.w  d0,d3                           ; 00034
        move.w  d0,d1                           ; 00036
        addq.w  #$2,d1                          ; 00038
        cmp.w   $8(a6),d1                       ; 0003A
        ble.b   l_034_00042                     ; 0003E
        clr.w   d1                              ; 00040
l_034_00042:
        asl.w   #$4,d1                          ; 00042
        move.w  d0,d6                           ; 00044
        asl.w   #$3,d6                          ; 00046
        lea.l   (a0,d6.w),a3                    ; 00048
        tst.b   -$2(a6)                         ; 0004C
        beq.b   l_034_0005A                     ; 00050
        clr.b   -$2(a6)                         ; 00052
        bra.w   l_034_002E0                     ; 00056
l_034_0005A:
        asl.w   #$4,d3                          ; 0005A
        movem.w (a1,d3.w),d3-d5                 ; 0005C
        addq.w  #$1,d3                          ; 00062
        addq.w  #$1,d4                          ; 00064
        cmp.w   d5,d3                           ; 00066
        blt.b   l_034_000A4                     ; 00068
        move.w  (a1,d1.w),d2                    ; 0006A
        move.w  $4(a1,d1.w),d6                  ; 0006E
        cmp.w   d2,d6                           ; 00072
        ble.w   l_034_00284                     ; 00074
        bsr.w   sub_034_00302                   ; 00078
        beq.w   l_034_0022E                     ; 0007C
        tst.w   (dat_071_0049A).l               ; 00080
        bge.b   l_034_000DC                     ; 00086
        neg.w   d2                              ; 00088
        cmp.w   d2,d6                           ; 0008A
        ble.b   l_034_000DC                     ; 0008C
        bsr.w   sub_034_00378                   ; 0008E
        bne.b   l_034_000DC                     ; 00092
        addq.w  #$1,(dat_073_000E2).l           ; 00094
        move.w  d0,(dat_073_000EA).l            ; 0009A
        bra.w   l_034_002A0                     ; 000A0
l_034_000A4:
        move.w  d3,d6                           ; 000A4
        neg.w   d6                              ; 000A6
        cmp.w   d5,d6                           ; 000A8
        blt.w   l_034_00182                     ; 000AA
        move.w  (a1,d1.w),d2                    ; 000AE
        move.w  $4(a1,d1.w),d6                  ; 000B2
        neg.w   d2                              ; 000B6
        cmp.w   d2,d6                           ; 000B8
        ble.w   l_034_00284                     ; 000BA
        bsr.w   sub_034_00378                   ; 000BE
        beq.w   l_034_00272                     ; 000C2
        tst.w   (dat_071_0049A).l               ; 000C6
        bge.b   l_034_000DC                     ; 000CC
        neg.w   d2                              ; 000CE
        cmp.w   d2,d6                           ; 000D0
        ble.b   l_034_000DC                     ; 000D2
        bsr.w   sub_034_00302                   ; 000D4
        beq.w   l_034_0022E                     ; 000D8
l_034_000DC:
        tst.w   d4                              ; 000DC
        bge.b   l_034_00130                     ; 000DE
        move.w  d4,d6                           ; 000E0
        neg.w   d6                              ; 000E2
        cmp.w   d5,d6                           ; 000E4
        blt.w   l_034_00284                     ; 000E6
        move.w  $2(a1,d1.w),d2                  ; 000EA
        move.w  $4(a1,d1.w),d6                  ; 000EE
        neg.w   d2                              ; 000F2
        cmp.w   d2,d6                           ; 000F4
        ble.w   l_034_00284                     ; 000F6
        bsr.w   sub_034_0046A                   ; 000FA
        beq.b   l_034_00172                     ; 000FE
        tst.w   (dat_071_0049A).l               ; 00100
        bge.w   l_034_00284                     ; 00106
        cmp.w   d5,d4                           ; 0010A
        blt.w   l_034_00284                     ; 0010C
        neg.w   d2                              ; 00110
        cmp.w   d2,d6                           ; 00112
        ble.w   l_034_00284                     ; 00114
        bsr.w   sub_034_003F4                   ; 00118
        bne.w   l_034_00284                     ; 0011C
l_034_00120:
        addq.w  #$1,(dat_073_000DC).l           ; 00120
        move.w  d0,(dat_073_000E4).l            ; 00126
        bra.w   l_034_002A0                     ; 0012C
l_034_00130:
        cmp.w   d5,d4                           ; 00130
        blt.w   l_034_00284                     ; 00132
        move.w  $2(a1,d1.w),d2                  ; 00136
        move.w  $4(a1,d1.w),d6                  ; 0013A
        cmp.w   d2,d6                           ; 0013E
        ble.w   l_034_00284                     ; 00140
        bsr.w   sub_034_003F4                   ; 00144
        beq.b   l_034_00120                     ; 00148
        tst.w   (dat_071_0049A).l               ; 0014A
        bge.w   l_034_00284                     ; 00150
        move.w  d4,d6                           ; 00154
        neg.w   d6                              ; 00156
        cmp.w   d5,d6                           ; 00158
        blt.w   l_034_00284                     ; 0015A
        move.w  $4(a1,d1.w),d6                  ; 0015E
        neg.w   d2                              ; 00162
        cmp.w   d2,d6                           ; 00164
        ble.w   l_034_00284                     ; 00166
        bsr.w   sub_034_0046A                   ; 0016A
        bne.w   l_034_00284                     ; 0016E
l_034_00172:
        addq.w  #$1,(dat_073_000E0).l           ; 00172
        move.w  d0,(dat_073_000E8).l            ; 00178
        bra.w   l_034_002A0                     ; 0017E
l_034_00182:
        cmp.w   d5,d4                           ; 00182
        blt.b   l_034_001BE                     ; 00184
        move.w  $2(a1,d1.w),d2                  ; 00186
        move.w  $4(a1,d1.w),d6                  ; 0018A
        cmp.w   d2,d6                           ; 0018E
        ble.w   l_034_00284                     ; 00190
        bsr.w   sub_034_003F4                   ; 00194
        beq.b   l_034_00120                     ; 00198
        tst.w   (dat_071_0049A).l               ; 0019A
        bge.b   l_034_001F4                     ; 001A0
        neg.w   d2                              ; 001A2
        cmp.w   d2,d6                           ; 001A4
        ble.b   l_034_001F4                     ; 001A6
        bsr.w   sub_034_0046A                   ; 001A8
        bne.b   l_034_001F4                     ; 001AC
        addq.w  #$1,(dat_073_000E0).l           ; 001AE
        move.w  d0,(dat_073_000E8).l            ; 001B4
        bra.w   l_034_002A0                     ; 001BA
l_034_001BE:
        move.w  d4,d6                           ; 001BE
        neg.w   d6                              ; 001C0
        cmp.w   d5,d6                           ; 001C2
        blt.w   l_034_00280                     ; 001C4
        move.w  $2(a1,d1.w),d2                  ; 001C8
        move.w  $4(a1,d1.w),d6                  ; 001CC
        neg.w   d2                              ; 001D0
        cmp.w   d2,d6                           ; 001D2
        ble.w   l_034_00284                     ; 001D4
        bsr.w   sub_034_0046A                   ; 001D8
        beq.b   l_034_00172                     ; 001DC
        tst.w   (dat_071_0049A).l               ; 001DE
        bge.b   l_034_001F4                     ; 001E4
        neg.w   d2                              ; 001E6
        cmp.w   d2,d6                           ; 001E8
        ble.b   l_034_001F4                     ; 001EA
        bsr.w   sub_034_003F4                   ; 001EC
        beq.w   l_034_00120                     ; 001F0
l_034_001F4:
        tst.w   d3                              ; 001F4
        bge.b   l_034_0023C                     ; 001F6
        move.w  d3,d6                           ; 001F8
        neg.w   d6                              ; 001FA
        cmp.w   d5,d6                           ; 001FC
        blt.w   l_034_00284                     ; 001FE
        move.w  (a1,d1.w),d2                    ; 00202
        move.w  $4(a1,d1.w),d6                  ; 00206
        neg.w   d2                              ; 0020A
        cmp.w   d2,d6                           ; 0020C
        ble.b   l_034_00284                     ; 0020E
        bsr.w   sub_034_00378                   ; 00210
        beq.b   l_034_00272                     ; 00214
        tst.w   (dat_071_0049A).l               ; 00216
        bge.b   l_034_00284                     ; 0021C
        cmp.w   d5,d3                           ; 0021E
        blt.b   l_034_00284                     ; 00220
        neg.w   d2                              ; 00222
        cmp.w   d2,d6                           ; 00224
        ble.b   l_034_00284                     ; 00226
        bsr.w   sub_034_00302                   ; 00228
        bne.b   l_034_00284                     ; 0022C
l_034_0022E:
        addq.w  #$1,(dat_073_000DE).l           ; 0022E
        move.w  d0,(dat_073_000E6).l            ; 00234
        bra.b   l_034_002A0                     ; 0023A
l_034_0023C:
        cmp.w   d5,d3                           ; 0023C
        blt.b   l_034_00284                     ; 0023E
        move.w  (a1,d1.w),d2                    ; 00240
        move.w  $4(a1,d1.w),d6                  ; 00244
        cmp.w   d2,d6                           ; 00248
        ble.b   l_034_00284                     ; 0024A
        bsr.w   sub_034_00302                   ; 0024C
        beq.b   l_034_0022E                     ; 00250
        tst.w   (dat_071_0049A).l               ; 00252
        bge.b   l_034_00284                     ; 00258
        move.w  d3,d6                           ; 0025A
        neg.w   d6                              ; 0025C
        cmp.w   d5,d6                           ; 0025E
        blt.b   l_034_00284                     ; 00260
        move.w  $4(a1,d1.w),d6                  ; 00262
        neg.w   d2                              ; 00266
        cmp.w   d2,d6                           ; 00268
        ble.b   l_034_00284                     ; 0026A
        bsr.w   sub_034_00378                   ; 0026C
        bne.b   l_034_00284                     ; 00270
l_034_00272:
        addq.w  #$1,(dat_073_000E2).l           ; 00272
        move.w  d0,(dat_073_000EA).l            ; 00278
        bra.b   l_034_002A0                     ; 0027E
l_034_00280:
        tst.w   d5                              ; 00280
        bge.b   l_034_00292                     ; 00282
l_034_00284:
        clr.l   (a3)                            ; 00284
        move.w  d0,d6                           ; 00286
        asl.w   #$4,d6                          ; 00288
        clr.w   $e(a1,d6.w)                     ; 0028A
        bra.w   l_034_002E0                     ; 0028E
l_034_00292:
        btst    #$0,d0                          ; 00292
        beq.b   l_034_002E0                     ; 00296
        move.b  #$1,-$2(a6)                     ; 00298
        bra.b   l_034_002E0                     ; 0029E
l_034_002A0:
        movem.w (dat_071_00496).l,d3-d5         ; 002A0
        tst.w   d5                              ; 002A8
l_034_002AA:
        ble.b   l_034_002AA                     ; 002AA
        muls.w  #$140,d3                        ; 002AC
        divs.w  d5,d3                           ; 002B0
        asr.w   #$1,d3                          ; 002B2
        bcc.b   l_034_002B8                     ; 002B4
        addq.w  #$1,d3                          ; 002B6
l_034_002B8:
        addi.w  #$a0,d3                         ; 002B8
        blt.b   l_034_002EE                     ; 002BC
        cmpi.w  #$140,d3                        ; 002BE
        bge.b   l_034_002F6                     ; 002C2
l_034_002C4:
        muls.w  #$b4,d4                         ; 002C4
        divs.w  d5,d4                           ; 002C8
        asr.w   #$1,d4                          ; 002CA
        bcc.b   l_034_002D0                     ; 002CC
        addq.w  #$1,d4                          ; 002CE
l_034_002D0:
        addi.w  #$5a,d4                         ; 002D0
        blt.b   l_034_002F2                     ; 002D4
        cmpi.w  #$b4,d4                         ; 002D6
        bge.b   l_034_002FC                     ; 002DA
l_034_002DC:
        movem.w d3-d4,(a3)                      ; 002DC
l_034_002E0:
        addq.w  #$1,d0                          ; 002E0
        cmp.w   $8(a6),d0                       ; 002E2
        ble.w   l_034_0001C                     ; 002E6
        unlk    a6                              ; 002EA
        rts                                     ; 002EC
l_034_002EE:
        clr.w   d3                              ; 002EE
        bra.b   l_034_002C4                     ; 002F0
l_034_002F2:
        clr.w   d4                              ; 002F2
        bra.b   l_034_002DC                     ; 002F4
l_034_002F6:
        move.w  #$13f,d3                        ; 002F6
        bra.b   l_034_002C4                     ; 002FA
l_034_002FC:
        move.w  #$b3,d4                         ; 002FC
        bra.b   l_034_002DC                     ; 00300
sub_034_00302:
        movem.l d0-d6,-(a7)                     ; 00302
        movem.w (a1,d1.w),d0-d2                 ; 00306
        subq.w  #$1,d3                          ; 0030C
        subq.w  #$1,d4                          ; 0030E
        move.w  d2,d6                           ; 00310
        sub.w   d5,d6                           ; 00312
        sub.w   d2,d0                           ; 00314
        neg.w   d0                              ; 00316
        sub.w   d5,d3                           ; 00318
        add.w   d0,d3                           ; 0031A
        beq.b   l_034_00374                     ; 0031C
        sub.w   d1,d4                           ; 0031E
        neg.w   d4                              ; 00320
        muls.w  d0,d4                           ; 00322
        move.w  d3,d5                           ; 00324
        bge.b   l_034_0032A                     ; 00326
        neg.w   d5                              ; 00328
l_034_0032A:
        asr.w   #$1,d5                          ; 0032A
        divs.w  d3,d4                           ; 0032C
        swap    d4                              ; 0032E
        tst.w   d4                              ; 00330
        bge.b   l_034_00336                     ; 00332
        neg.w   d4                              ; 00334
l_034_00336:
        cmp.w   d4,d5                           ; 00336
        bgt.b   l_034_00348                     ; 00338
        swap    d4                              ; 0033A
        tst.w   d4                              ; 0033C
        bge.b   l_034_00344                     ; 0033E
        subq.w  #$1,d4                          ; 00340
        bra.b   l_034_0034A                     ; 00342
l_034_00344:
        addq.w  #$1,d4                          ; 00344
        bra.b   l_034_0034A                     ; 00346
l_034_00348:
        swap    d4                              ; 00348
l_034_0034A:
        sub.w   d4,d1                           ; 0034A
        muls.w  d0,d6                           ; 0034C
        divs.w  d3,d6                           ; 0034E
        swap    d6                              ; 00350
        tst.w   d6                              ; 00352
        bge.b   l_034_00358                     ; 00354
        neg.w   d6                              ; 00356
l_034_00358:
        cmp.w   d6,d5                           ; 00358
        bgt.b   l_034_0036A                     ; 0035A
        swap    d6                              ; 0035C
        tst.w   d6                              ; 0035E
        bge.b   l_034_00366                     ; 00360
        subq.w  #$1,d6                          ; 00362
        bra.b   l_034_0036C                     ; 00364
l_034_00366:
        addq.w  #$1,d6                          ; 00366
        bra.b   l_034_0036C                     ; 00368
l_034_0036A:
        swap    d6                              ; 0036A
l_034_0036C:
        sub.w   d6,d2                           ; 0036C
        move.w  d2,d0                           ; 0036E
        bra.w   l_034_004DE                     ; 00370
l_034_00374:
        bra.w   l_034_00500                     ; 00374
sub_034_00378:
        movem.l d0-d6,-(a7)                     ; 00378
        movem.w (a1,d1.w),d0-d2                 ; 0037C
        subq.w  #$1,d3                          ; 00382
        subq.w  #$1,d4                          ; 00384
        neg.w   d0                              ; 00386
        neg.w   d3                              ; 00388
        move.w  d2,d6                           ; 0038A
        sub.w   d5,d6                           ; 0038C
        sub.w   d2,d0                           ; 0038E
        neg.w   d0                              ; 00390
        sub.w   d5,d3                           ; 00392
        add.w   d0,d3                           ; 00394
        beq.b   l_034_003F0                     ; 00396
        sub.w   d1,d4                           ; 00398
        neg.w   d4                              ; 0039A
        muls.w  d0,d4                           ; 0039C
        move.w  d3,d5                           ; 0039E
        bge.b   l_034_003A4                     ; 003A0
        neg.w   d5                              ; 003A2
l_034_003A4:
        asr.w   #$1,d5                          ; 003A4
        divs.w  d3,d4                           ; 003A6
        swap    d4                              ; 003A8
        tst.w   d4                              ; 003AA
        bge.b   l_034_003B0                     ; 003AC
        neg.w   d4                              ; 003AE
l_034_003B0:
        cmp.w   d4,d5                           ; 003B0
        bgt.b   l_034_003C2                     ; 003B2
        swap    d4                              ; 003B4
        tst.w   d4                              ; 003B6
        bge.b   l_034_003BE                     ; 003B8
        subq.w  #$1,d4                          ; 003BA
        bra.b   l_034_003C4                     ; 003BC
l_034_003BE:
        addq.w  #$1,d4                          ; 003BE
        bra.b   l_034_003C4                     ; 003C0
l_034_003C2:
        swap    d4                              ; 003C2
l_034_003C4:
        sub.w   d4,d1                           ; 003C4
        muls.w  d0,d6                           ; 003C6
        divs.w  d3,d6                           ; 003C8
        swap    d6                              ; 003CA
        tst.w   d6                              ; 003CC
        bge.b   l_034_003D2                     ; 003CE
        neg.w   d6                              ; 003D0
l_034_003D2:
        cmp.w   d6,d5                           ; 003D2
        bgt.b   l_034_003E4                     ; 003D4
        swap    d6                              ; 003D6
        tst.w   d6                              ; 003D8
        bge.b   l_034_003E0                     ; 003DA
        subq.w  #$1,d6                          ; 003DC
        bra.b   l_034_003E6                     ; 003DE
l_034_003E0:
        addq.w  #$1,d6                          ; 003E0
        bra.b   l_034_003E6                     ; 003E2
l_034_003E4:
        swap    d6                              ; 003E4
l_034_003E6:
        sub.w   d6,d2                           ; 003E6
        move.w  d2,d0                           ; 003E8
        neg.w   d0                              ; 003EA
        bra.w   l_034_004DE                     ; 003EC
l_034_003F0:
        bra.w   l_034_00500                     ; 003F0
sub_034_003F4:
        movem.l d0-d6,-(a7)                     ; 003F4
        movem.w (a1,d1.w),d0-d2                 ; 003F8
        subq.w  #$1,d3                          ; 003FE
        subq.w  #$1,d4                          ; 00400
        move.w  d2,d6                           ; 00402
        sub.w   d5,d6                           ; 00404
        sub.w   d2,d1                           ; 00406
        neg.w   d1                              ; 00408
        sub.w   d5,d4                           ; 0040A
        add.w   d1,d4                           ; 0040C
        beq.b   l_034_00466                     ; 0040E
        sub.w   d0,d3                           ; 00410
        neg.w   d3                              ; 00412
        muls.w  d1,d3                           ; 00414
        move.w  d4,d5                           ; 00416
        bge.b   l_034_0041C                     ; 00418
        neg.w   d5                              ; 0041A
l_034_0041C:
        asr.w   #$1,d5                          ; 0041C
        divs.w  d4,d3                           ; 0041E
        swap    d3                              ; 00420
        tst.w   d3                              ; 00422
        bge.b   l_034_00428                     ; 00424
        neg.w   d3                              ; 00426
l_034_00428:
        cmp.w   d3,d5                           ; 00428
        bgt.b   l_034_0043A                     ; 0042A
        swap    d3                              ; 0042C
        tst.w   d3                              ; 0042E
        bge.b   l_034_00436                     ; 00430
        subq.w  #$1,d3                          ; 00432
        bra.b   l_034_0043C                     ; 00434
l_034_00436:
        addq.w  #$1,d3                          ; 00436
        bra.b   l_034_0043C                     ; 00438
l_034_0043A:
        swap    d3                              ; 0043A
l_034_0043C:
        sub.w   d3,d0                           ; 0043C
        muls.w  d1,d6                           ; 0043E
        divs.w  d4,d6                           ; 00440
        swap    d6                              ; 00442
        tst.w   d6                              ; 00444
        bge.b   l_034_0044A                     ; 00446
        neg.w   d6                              ; 00448
l_034_0044A:
        cmp.w   d6,d5                           ; 0044A
        bgt.b   l_034_0045C                     ; 0044C
        swap    d6                              ; 0044E
        tst.w   d6                              ; 00450
        bge.b   l_034_00458                     ; 00452
        subq.w  #$1,d6                          ; 00454
        bra.b   l_034_0045E                     ; 00456
l_034_00458:
        addq.w  #$1,d6                          ; 00458
        bra.b   l_034_0045E                     ; 0045A
l_034_0045C:
        swap    d6                              ; 0045C
l_034_0045E:
        sub.w   d6,d2                           ; 0045E
        move.w  d2,d1                           ; 00460
        bra.w   l_034_004DE                     ; 00462
l_034_00466:
        bra.w   l_034_00500                     ; 00466
sub_034_0046A:
        movem.l d0-d6,-(a7)                     ; 0046A
        movem.w (a1,d1.w),d0-d2                 ; 0046E
        subq.w  #$1,d3                          ; 00474
        subq.w  #$1,d4                          ; 00476
        neg.w   d1                              ; 00478
        neg.w   d4                              ; 0047A
        move.w  d2,d6                           ; 0047C
        sub.w   d5,d6                           ; 0047E
        sub.w   d2,d1                           ; 00480
        neg.w   d1                              ; 00482
        sub.w   d5,d4                           ; 00484
        add.w   d1,d4                           ; 00486
        beq.b   l_034_00500                     ; 00488
        sub.w   d0,d3                           ; 0048A
        neg.w   d3                              ; 0048C
        muls.w  d1,d3                           ; 0048E
        move.w  d4,d5                           ; 00490
        bge.b   l_034_00496                     ; 00492
        neg.w   d5                              ; 00494
l_034_00496:
        asr.w   #$1,d5                          ; 00496
        divs.w  d4,d3                           ; 00498
        swap    d3                              ; 0049A
        tst.w   d3                              ; 0049C
        bge.b   l_034_004A2                     ; 0049E
        neg.w   d3                              ; 004A0
l_034_004A2:
        cmp.w   d3,d5                           ; 004A2
        bgt.b   l_034_004B4                     ; 004A4
        swap    d3                              ; 004A6
        tst.w   d3                              ; 004A8
        bge.b   l_034_004B0                     ; 004AA
        subq.w  #$1,d3                          ; 004AC
        bra.b   l_034_004B6                     ; 004AE
l_034_004B0:
        addq.w  #$1,d3                          ; 004B0
        bra.b   l_034_004B6                     ; 004B2
l_034_004B4:
        swap    d3                              ; 004B4
l_034_004B6:
        sub.w   d3,d0                           ; 004B6
        muls.w  d1,d6                           ; 004B8
        divs.w  d4,d6                           ; 004BA
        swap    d6                              ; 004BC
        tst.w   d6                              ; 004BE
        bge.b   l_034_004C4                     ; 004C0
        neg.w   d6                              ; 004C2
l_034_004C4:
        cmp.w   d6,d5                           ; 004C4
        bgt.b   l_034_004D6                     ; 004C6
        swap    d6                              ; 004C8
        tst.w   d6                              ; 004CA
        bge.b   l_034_004D2                     ; 004CC
        subq.w  #$1,d6                          ; 004CE
        bra.b   l_034_004D8                     ; 004D0
l_034_004D2:
        addq.w  #$1,d6                          ; 004D2
        bra.b   l_034_004D8                     ; 004D4
l_034_004D6:
        swap    d6                              ; 004D6
l_034_004D8:
        sub.w   d6,d2                           ; 004D8
        move.w  d2,d1                           ; 004DA
        neg.w   d1                              ; 004DC
l_034_004DE:
        movem.w d0-d2,(dat_071_00496).l         ; 004DE
        move.w  d2,d5                           ; 004E6
        blt.b   l_034_00500                     ; 004E8
        move.w  d2,d6                           ; 004EA
        cmp.w   d5,d0                           ; 004EC
        bgt.b   l_034_00500                     ; 004EE
        neg.w   d0                              ; 004F0
        cmp.w   d5,d0                           ; 004F2
        bgt.b   l_034_00500                     ; 004F4
        cmp.w   d6,d1                           ; 004F6
        bgt.b   l_034_00500                     ; 004F8
        neg.w   d1                              ; 004FA
        cmp.w   d6,d1                           ; 004FC
        ble.b   l_034_00508                     ; 004FE
l_034_00500:
        moveq   #$1,d0                          ; 00500
        movem.l (a7)+,d0-d6                     ; 00502
        rts                                     ; 00506
l_034_00508:
        moveq   #$0,d0                          ; 00508
        movem.l (a7)+,d0-d6                     ; 0050A
        rts                                     ; 0050E
h034_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    10,71                           ; 10 longs pointing into hunk 71
	dc.l	$82,$C8,$102,$14C,$19C,$1E0,$218,$254
	dc.l	$2A4,$4E2
        dc.l    12,73                           ; 12 longs pointing into hunk 73
	dc.l	$96,$9C,$122,$128,$174,$17A,$1B0,$1B6
	dc.l	$230,$236,$274,$27A
        dc.l    2,72                            ; 2 longs pointing into hunk 72
	dc.l	$A,$10
	dc.l	0
	dc.l	HUNK_END
	endc
