; F/A-18 Interceptor - hunk 35 (code)
; Drawing with the blitter for the 3D pipeline (used by hunks 13-15, 29, 31) (not worked out
; yet)
; Included by ../f18_main.s.

;===============================================================================
; Hunk 35: CODE, $814 bytes
;===============================================================================
	CODE_HUNK	h035
l_035_00000:
        move.w  #$1b,(dat_071_0036E).l          ; 00000
        jsr     (Nop).l                         ; 00008
        moveq   #$0,d0                          ; 0000E
        rts                                     ; 00010
l_035_00012:
        moveq   #$0,d0                          ; 00012
        move.l  #$ffffffff,(dat_071_00328).l    ; 00014
        rts                                     ; 0001E
sub_035_00020:
        moveq   #-5,d7                          ; 00020
        bra.b   l_035_0003A                     ; 00022
sub_035_00024:
        move.w  (dat_071_00488).l,d7            ; 00024
        bra.b   l_035_0003A                     ; 0002A
sub_035_0002C:
        moveq   #-4,d7                          ; 0002C
        bra.b   l_035_0003A                     ; 0002E
	dc.b	$7E,$FD,$60,$06
sub_035_00034:
        moveq   #-2,d7                          ; 00034
        bra.b   l_035_0003A                     ; 00036
sub_035_00038:
        moveq   #-1,d7                          ; 00038
l_035_0003A:
        cmp.w   d2,d0                           ; 0003A
        bge.b   l_035_00012                     ; 0003C
        cmp.w   d2,d1                           ; 0003E
        bge.b   l_035_00012                     ; 00040
        move.w  d0,d3                           ; 00042
        neg.w   d3                              ; 00044
        cmp.w   d2,d3                           ; 00046
        bge.b   l_035_00012                     ; 00048
        move.w  d1,d3                           ; 0004A
        neg.w   d3                              ; 0004C
        cmp.w   d2,d3                           ; 0004E
        bge.b   l_035_00012                     ; 00050
        tst.w   d2                              ; 00052
        ble.b   l_035_00000                     ; 00054
        muls.w  #$a0,d0                         ; 00056
        divs.w  d2,d0                           ; 0005A
        addi.w  #$a0,d0                         ; 0005C
        blt.b   l_035_000D4                     ; 00060
        cmpi.w  #$140,d0                        ; 00062
        bge.b   l_035_000DC                     ; 00066
l_035_00068:
        muls.w  #$5a,d1                         ; 00068
        divs.w  d2,d1                           ; 0006C
        addi.w  #$5a,d1                         ; 0006E
        blt.b   l_035_000D8                     ; 00072
        cmpi.w  #$b4,d1                         ; 00074
        bge.b   l_035_000E2                     ; 00078
l_035_0007A:
        subi.w  #$13f,d0                        ; 0007A
        neg.w   d0                              ; 0007E
        subi.w  #$b3,d1                         ; 00080
        neg.w   d1                              ; 00084
        addq.w  #$1,d1                          ; 00086
        cmp.w   (ClipY).l,d1                    ; 00088
        bgt.b   l_035_00012                     ; 0008E
        movem.w d0-d1,(dat_071_00328).l         ; 00090
        tst.w   d7                              ; 00098
        blt.b   l_035_000E8                     ; 0009A
        move.w  #$30,d2                         ; 0009C
        asr.w   d7,d2                           ; 000A0
        cmp.w   -$28(a6),d2                     ; 000A2
        bge.b   l_035_000C4                     ; 000A6
        move.w  #$50,d2                         ; 000A8
        asr.w   d7,d2                           ; 000AC
        cmp.w   -$28(a6),d2                     ; 000AE
        bge.b   l_035_000BC                     ; 000B2
l_035_000B4:
        jsr     (Plot).l                        ; 000B4
        bra.b   l_035_000D0                     ; 000BA
l_035_000BC:
        jsr     (Plot2).l                       ; 000BC
        bra.b   l_035_000D0                     ; 000C2
l_035_000C4:
        jsr     (PlotBigAbove).l                ; 000C4
        bra.b   l_035_000D0                     ; 000CA
l_035_000CC:
        bsr.w   sub_035_00550                   ; 000CC
l_035_000D0:
        moveq   #$1,d0                          ; 000D0
        rts                                     ; 000D2
l_035_000D4:
        clr.w   d0                              ; 000D4
        bra.b   l_035_00068                     ; 000D6
l_035_000D8:
        clr.w   d1                              ; 000D8
        bra.b   l_035_0007A                     ; 000DA
l_035_000DC:
        move.w  #$13f,d0                        ; 000DC
        bra.b   l_035_00068                     ; 000E0
l_035_000E2:
        move.w  #$b3,d1                         ; 000E2
        bra.b   l_035_0007A                     ; 000E6
l_035_000E8:
        addq.w  #$1,d7                          ; 000E8
        bge.b   l_035_000B4                     ; 000EA
        addq.w  #$1,d7                          ; 000EC
        bge.b   l_035_000BC                     ; 000EE
        addq.w  #$1,d7                          ; 000F0
        bge.b   l_035_000C4                     ; 000F2
        addq.w  #$1,d7                          ; 000F4
        bge.b   l_035_000CC                     ; 000F6
        move.w  d0,d0                           ; 000F8
        rts                                     ; 000FA
l_035_000FC:
        moveq   #$0,d0                          ; 000FC
        rts                                     ; 000FE
sub_035_00100:
        lea.l   (dat_072_04202).l,a1            ; 00100
        move.w  (a1)+,d0                        ; 00106
        move.w  (a1)+,d1                        ; 00108
        move.w  (a1)+,d2                        ; 0010A
        ble.b   l_035_000FC                     ; 0010C
        cmp.w   d2,d0                           ; 0010E
        bgt.b   l_035_000FC                     ; 00110
        move.w  d0,d5                           ; 00112
        neg.w   d5                              ; 00114
        cmp.w   d2,d5                           ; 00116
        bgt.b   l_035_000FC                     ; 00118
        cmp.w   d2,d1                           ; 0011A
        bgt.b   l_035_000FC                     ; 0011C
        move.w  d1,d5                           ; 0011E
        neg.w   d5                              ; 00120
        cmp.w   d2,d5                           ; 00122
        bgt.b   l_035_000FC                     ; 00124
        muls.w  #$a0,d0                         ; 00126
        divs.w  d2,d0                           ; 0012A
        addi.w  #$a0,d0                         ; 0012C
        bge.b   l_035_00136                     ; 00130
        clr.w   d0                              ; 00132
        bra.b   l_035_00140                     ; 00134
l_035_00136:
        cmpi.w  #$140,d0                        ; 00136
        blt.b   l_035_00140                     ; 0013A
        move.w  #$13f,d0                        ; 0013C
l_035_00140:
        muls.w  #$5a,d1                         ; 00140
        divs.w  d2,d1                           ; 00144
        addi.w  #$5a,d1                         ; 00146
        bge.b   l_035_00150                     ; 0014A
        clr.w   d1                              ; 0014C
        bra.b   l_035_0015A                     ; 0014E
l_035_00150:
        cmpi.w  #$b4,d1                         ; 00150
        blt.b   l_035_0015A                     ; 00154
        move.w  #$b3,d1                         ; 00156
l_035_0015A:
        subi.w  #$13f,d0                        ; 0015A
        neg.w   d0                              ; 0015E
        subi.w  #$b3,d1                         ; 00160
        neg.w   d1                              ; 00164
        move.w  (a1)+,d2                        ; 00166
        move.w  (a1)+,d3                        ; 00168
        move.w  (a1)+,d4                        ; 0016A
        ble.b   l_035_001D0                     ; 0016C
        cmp.w   d4,d2                           ; 0016E
        bgt.b   l_035_001D0                     ; 00170
        move.w  d2,d5                           ; 00172
        neg.w   d5                              ; 00174
        cmp.w   d4,d5                           ; 00176
        bgt.b   l_035_001D0                     ; 00178
        cmp.w   d4,d3                           ; 0017A
        bgt.b   l_035_001D0                     ; 0017C
        move.w  d3,d5                           ; 0017E
        neg.w   d5                              ; 00180
        cmp.w   d4,d5                           ; 00182
        bgt.b   l_035_001D0                     ; 00184
        muls.w  #$a0,d2                         ; 00186
        divs.w  d4,d2                           ; 0018A
        addi.w  #$a0,d2                         ; 0018C
        bge.b   l_035_00196                     ; 00190
        clr.w   d2                              ; 00192
        bra.b   l_035_001A0                     ; 00194
l_035_00196:
        cmpi.w  #$140,d2                        ; 00196
        blt.b   l_035_001A0                     ; 0019A
        move.w  #$13f,d2                        ; 0019C
l_035_001A0:
        muls.w  #$5a,d3                         ; 001A0
        divs.w  d4,d3                           ; 001A4
        addi.w  #$5a,d3                         ; 001A6
        bge.b   l_035_001B0                     ; 001AA
        clr.w   d3                              ; 001AC
        bra.b   l_035_001BA                     ; 001AE
l_035_001B0:
        cmpi.w  #$b4,d3                         ; 001B0
        blt.b   l_035_001BA                     ; 001B4
        move.w  #$b3,d3                         ; 001B6
l_035_001BA:
        subi.w  #$13f,d2                        ; 001BA
        neg.w   d2                              ; 001BE
        subi.w  #$b3,d3                         ; 001C0
        neg.w   d3                              ; 001C4
        jsr     (DrawLine).l                    ; 001C6
        moveq   #$1,d0                          ; 001CC
        rts                                     ; 001CE
l_035_001D0:
        moveq   #$0,d0                          ; 001D0
        rts                                     ; 001D2
l_035_001D4:
        unlk    a6                              ; 001D4
        moveq   #$0,d0                          ; 001D6
        rts                                     ; 001D8
sub_035_001DA:
        link.w  a6,#$fffc                       ; 001DA
        lea.l   (dat_072_04202).l,a1            ; 001DE
        lea.l   (dat_072_03000).l,a0            ; 001E4
        move.w  #$1,-$2(a6)                     ; 001EA
l_035_001F0:
        movem.w (a1),d3-d5                      ; 001F0
        cmp.w   d5,d3                           ; 001F4
        blt.b   l_035_00224                     ; 001F6
        move.w  $6(a1),d2                       ; 001F8
        move.w  $a(a1),d6                       ; 001FC
        cmp.w   d2,d6                           ; 00200
        ble.b   l_035_001D4                     ; 00202
        bsr.w   sub_035_00456                   ; 00204
        beq.w   l_035_00386                     ; 00208
        tst.w   (dat_071_0049A).l               ; 0020C
        bge.b   l_035_0025A                     ; 00212
        neg.w   d2                              ; 00214
        cmp.w   d2,d6                           ; 00216
        ble.b   l_035_0025A                     ; 00218
        bsr.w   sub_035_00484                   ; 0021A
        bne.b   l_035_0025A                     ; 0021E
        bra.w   l_035_003CA                     ; 00220
l_035_00224:
        move.w  d3,d6                           ; 00224
        neg.w   d6                              ; 00226
        cmp.w   d5,d6                           ; 00228
        blt.w   l_035_002E8                     ; 0022A
        move.w  $6(a1),d2                       ; 0022E
        move.w  $a(a1),d6                       ; 00232
        neg.w   d2                              ; 00236
        cmp.w   d2,d6                           ; 00238
        ble.b   l_035_001D4                     ; 0023A
        bsr.w   sub_035_00484                   ; 0023C
        beq.w   l_035_003BE                     ; 00240
        tst.w   (dat_071_0049A).l               ; 00244
        bge.b   l_035_0025A                     ; 0024A
        neg.w   d2                              ; 0024C
        cmp.w   d2,d6                           ; 0024E
        ble.b   l_035_0025A                     ; 00250
        bsr.w   sub_035_00456                   ; 00252
        beq.w   l_035_00386                     ; 00256
l_035_0025A:
        tst.w   d4                              ; 0025A
        bge.b   l_035_002A2                     ; 0025C
        move.w  d4,d6                           ; 0025E
        neg.w   d6                              ; 00260
        cmp.w   d5,d6                           ; 00262
        blt.w   l_035_001D4                     ; 00264
        move.w  $8(a1),d2                       ; 00268
        move.w  $a(a1),d6                       ; 0026C
        neg.w   d2                              ; 00270
        cmp.w   d2,d6                           ; 00272
        ble.w   l_035_001D4                     ; 00274
        bsr.w   sub_035_004E6                   ; 00278
        beq.b   l_035_002E4                     ; 0027C
        tst.w   (dat_071_0049A).l               ; 0027E
        bge.w   l_035_001D4                     ; 00284
        cmp.w   d5,d4                           ; 00288
        blt.w   l_035_001D4                     ; 0028A
        neg.w   d2                              ; 0028E
        cmp.w   d2,d6                           ; 00290
        ble.w   l_035_001D4                     ; 00292
        bsr.w   sub_035_004B8                   ; 00296
        bne.w   l_035_001D4                     ; 0029A
l_035_0029E:
        bra.w   l_035_003CA                     ; 0029E
l_035_002A2:
        cmp.w   d5,d4                           ; 002A2
        blt.w   l_035_001D4                     ; 002A4
        move.w  $8(a1),d2                       ; 002A8
        move.w  $a(a1),d6                       ; 002AC
        cmp.w   d2,d6                           ; 002B0
        ble.w   l_035_001D4                     ; 002B2
        bsr.w   sub_035_004B8                   ; 002B6
        beq.b   l_035_0029E                     ; 002BA
        tst.w   (dat_071_0049A).l               ; 002BC
        bge.w   l_035_001D4                     ; 002C2
        move.w  d4,d6                           ; 002C6
        neg.w   d6                              ; 002C8
        cmp.w   d5,d6                           ; 002CA
        blt.w   l_035_001D4                     ; 002CC
        move.w  $a(a1),d6                       ; 002D0
        neg.w   d2                              ; 002D4
        cmp.w   d2,d6                           ; 002D6
        ble.w   l_035_001D4                     ; 002D8
        bsr.w   sub_035_004E6                   ; 002DC
        bne.w   l_035_001D4                     ; 002E0
l_035_002E4:
        bra.w   l_035_003CA                     ; 002E4
l_035_002E8:
        cmp.w   d5,d4                           ; 002E8
        blt.b   l_035_00318                     ; 002EA
        move.w  $8(a1),d2                       ; 002EC
        move.w  $a(a1),d6                       ; 002F0
        cmp.w   d2,d6                           ; 002F4
        ble.w   l_035_001D4                     ; 002F6
        bsr.w   sub_035_004B8                   ; 002FA
        beq.b   l_035_0029E                     ; 002FE
        tst.w   (dat_071_0049A).l               ; 00300
        bge.b   l_035_0034E                     ; 00306
        neg.w   d2                              ; 00308
        cmp.w   d2,d6                           ; 0030A
        ble.b   l_035_0034E                     ; 0030C
        bsr.w   sub_035_004E6                   ; 0030E
        bne.b   l_035_0034E                     ; 00312
        bra.w   l_035_003CA                     ; 00314
l_035_00318:
        move.w  d4,d6                           ; 00318
        neg.w   d6                              ; 0031A
        cmp.w   d5,d6                           ; 0031C
        blt.w   l_035_003C0                     ; 0031E
        move.w  $8(a1),d2                       ; 00322
        move.w  $a(a1),d6                       ; 00326
        neg.w   d2                              ; 0032A
        cmp.w   d2,d6                           ; 0032C
        ble.w   l_035_001D4                     ; 0032E
        bsr.w   sub_035_004E6                   ; 00332
        beq.b   l_035_002E4                     ; 00336
        tst.w   (dat_071_0049A).l               ; 00338
        bge.b   l_035_0034E                     ; 0033E
        neg.w   d2                              ; 00340
        cmp.w   d2,d6                           ; 00342
        ble.b   l_035_0034E                     ; 00344
        bsr.w   sub_035_004B8                   ; 00346
        beq.w   l_035_0029E                     ; 0034A
l_035_0034E:
        tst.w   d3                              ; 0034E
        bge.b   l_035_00388                     ; 00350
        move.w  d3,d6                           ; 00352
        neg.w   d6                              ; 00354
        cmp.w   d5,d6                           ; 00356
        blt.b   l_035_003C4                     ; 00358
        move.w  $6(a1),d2                       ; 0035A
        move.w  $a(a1),d6                       ; 0035E
        neg.w   d2                              ; 00362
        cmp.w   d2,d6                           ; 00364
        ble.b   l_035_003C4                     ; 00366
        bsr.w   sub_035_00484                   ; 00368
        beq.b   l_035_003BE                     ; 0036C
        tst.w   (dat_071_0049A).l               ; 0036E
        bge.b   l_035_003C4                     ; 00374
        cmp.w   d5,d3                           ; 00376
        blt.b   l_035_003C4                     ; 00378
        neg.w   d2                              ; 0037A
        cmp.w   d2,d6                           ; 0037C
        ble.b   l_035_003C4                     ; 0037E
        bsr.w   sub_035_00456                   ; 00380
        bne.b   l_035_003C4                     ; 00384
l_035_00386:
        bra.b   l_035_003CA                     ; 00386
l_035_00388:
        cmp.w   d5,d3                           ; 00388
        blt.b   l_035_003C4                     ; 0038A
        move.w  $6(a1),d2                       ; 0038C
        move.w  $a(a1),d6                       ; 00390
        cmp.w   d2,d6                           ; 00394
        ble.b   l_035_003C4                     ; 00396
        bsr.w   sub_035_00456                   ; 00398
        beq.b   l_035_00386                     ; 0039C
        tst.w   (dat_071_0049A).l               ; 0039E
        bge.b   l_035_003C4                     ; 003A4
        move.w  d3,d6                           ; 003A6
        neg.w   d6                              ; 003A8
        cmp.w   d5,d6                           ; 003AA
        blt.b   l_035_003C4                     ; 003AC
        move.w  $a(a1),d6                       ; 003AE
        neg.w   d2                              ; 003B2
        cmp.w   d2,d6                           ; 003B4
        ble.b   l_035_003C4                     ; 003B6
        bsr.w   sub_035_00484                   ; 003B8
        bne.b   l_035_003C4                     ; 003BC
l_035_003BE:
        bra.b   l_035_003CA                     ; 003BE
l_035_003C0:
        tst.w   d5                              ; 003C0
        bge.b   l_035_003D2                     ; 003C2
l_035_003C4:
        unlk    a6                              ; 003C4
        moveq   #$0,d0                          ; 003C6
        rts                                     ; 003C8
l_035_003CA:
        movem.w (dat_071_00496).l,d3-d5         ; 003CA
l_035_003D2:
        tst.w   d5                              ; 003D2
        ble.b   l_035_00424                     ; 003D4
        muls.w  #$a0,d3                         ; 003D6
        divs.w  d5,d3                           ; 003DA
        addi.w  #$a0,d3                         ; 003DC
        blt.b   l_035_00442                     ; 003E0
        cmpi.w  #$140,d3                        ; 003E2
        bge.b   l_035_0044A                     ; 003E6
l_035_003E8:
        muls.w  #$5a,d4                         ; 003E8
        divs.w  d5,d4                           ; 003EC
        addi.w  #$5a,d4                         ; 003EE
        blt.b   l_035_00446                     ; 003F2
        cmpi.w  #$b4,d4                         ; 003F4
        bge.b   l_035_00450                     ; 003F8
l_035_003FA:
        subi.w  #$13f,d3                        ; 003FA
        neg.w   d3                              ; 003FE
        subi.w  #$b3,d4                         ; 00400
        neg.w   d4                              ; 00404
        move.w  d3,(a0)+                        ; 00406
        move.w  d4,(a0)+                        ; 00408
        subq.w  #$1,-$2(a6)                     ; 0040A
        beq.b   l_035_00430                     ; 0040E
        movem.w (dat_072_03000).l,d0-d3         ; 00410
        jsr     (DrawLine).l                    ; 00418
        unlk    a6                              ; 0041E
        moveq   #$1,d0                          ; 00420
        rts                                     ; 00422
l_035_00424:
        move.w  #$16,(dat_071_0036E).l          ; 00424
        bra.w   l_035_001D4                     ; 0042C
l_035_00430:
        movem.w (a1),d0-d5                      ; 00430
        movem.w d3-d5,(a1)                      ; 00434
        movem.w d0-d2,$6(a1)                    ; 00438
        bra.w   l_035_001F0                     ; 0043E
l_035_00442:
        clr.w   d3                              ; 00442
        bra.b   l_035_003E8                     ; 00444
l_035_00446:
        clr.w   d4                              ; 00446
        bra.b   l_035_003FA                     ; 00448
l_035_0044A:
        move.w  #$13f,d3                        ; 0044A
        bra.b   l_035_003E8                     ; 0044E
l_035_00450:
        move.w  #$b3,d4                         ; 00450
        bra.b   l_035_003FA                     ; 00454
sub_035_00456:
        movem.l d0-d6,-(a7)                     ; 00456
        movem.w $6(a1),d0-d2                    ; 0045A
        move.w  d2,d6                           ; 00460
        sub.w   d5,d6                           ; 00462
        sub.w   d2,d0                           ; 00464
        neg.w   d0                              ; 00466
        sub.w   d5,d3                           ; 00468
        add.w   d0,d3                           ; 0046A
l_035_0046C:
        beq.b   l_035_0046C                     ; 0046C
        sub.w   d1,d4                           ; 0046E
        neg.w   d4                              ; 00470
        muls.w  d0,d4                           ; 00472
        divs.w  d3,d4                           ; 00474
        sub.w   d4,d1                           ; 00476
        muls.w  d0,d6                           ; 00478
        divs.w  d3,d6                           ; 0047A
        sub.w   d6,d2                           ; 0047C
        move.w  d2,d0                           ; 0047E
        bra.w   l_035_00516                     ; 00480
sub_035_00484:
        movem.l d0-d6,-(a7)                     ; 00484
        movem.w $6(a1),d0-d2                    ; 00488
        neg.w   d0                              ; 0048E
        neg.w   d3                              ; 00490
        move.w  d2,d6                           ; 00492
        sub.w   d5,d6                           ; 00494
        sub.w   d2,d0                           ; 00496
        neg.w   d0                              ; 00498
        sub.w   d5,d3                           ; 0049A
        add.w   d0,d3                           ; 0049C
l_035_0049E:
        beq.b   l_035_0049E                     ; 0049E
        sub.w   d1,d4                           ; 004A0
        neg.w   d4                              ; 004A2
        muls.w  d0,d4                           ; 004A4
        divs.w  d3,d4                           ; 004A6
        sub.w   d4,d1                           ; 004A8
        muls.w  d0,d6                           ; 004AA
        divs.w  d3,d6                           ; 004AC
        sub.w   d6,d2                           ; 004AE
        move.w  d2,d0                           ; 004B0
        neg.w   d0                              ; 004B2
        bra.w   l_035_00516                     ; 004B4
sub_035_004B8:
        movem.l d0-d6,-(a7)                     ; 004B8
        movem.w $6(a1),d0-d2                    ; 004BC
        move.w  d2,d6                           ; 004C2
        sub.w   d5,d6                           ; 004C4
        sub.w   d2,d1                           ; 004C6
        neg.w   d1                              ; 004C8
        sub.w   d5,d4                           ; 004CA
        add.w   d1,d4                           ; 004CC
l_035_004CE:
        beq.b   l_035_004CE                     ; 004CE
        sub.w   d0,d3                           ; 004D0
        neg.w   d3                              ; 004D2
        muls.w  d1,d3                           ; 004D4
        divs.w  d4,d3                           ; 004D6
        sub.w   d3,d0                           ; 004D8
        muls.w  d1,d6                           ; 004DA
        divs.w  d4,d6                           ; 004DC
        sub.w   d6,d2                           ; 004DE
        move.w  d2,d1                           ; 004E0
        bra.w   l_035_00516                     ; 004E2
sub_035_004E6:
        movem.l d0-d6,-(a7)                     ; 004E6
        movem.w $6(a1),d0-d2                    ; 004EA
        neg.w   d1                              ; 004F0
        neg.w   d4                              ; 004F2
        move.w  d2,d6                           ; 004F4
        sub.w   d5,d6                           ; 004F6
        sub.w   d2,d1                           ; 004F8
        neg.w   d1                              ; 004FA
        sub.w   d5,d4                           ; 004FC
        add.w   d1,d4                           ; 004FE
l_035_00500:
        beq.b   l_035_00500                     ; 00500
        sub.w   d0,d3                           ; 00502
        neg.w   d3                              ; 00504
        muls.w  d1,d3                           ; 00506
        divs.w  d4,d3                           ; 00508
        sub.w   d3,d0                           ; 0050A
        muls.w  d1,d6                           ; 0050C
        divs.w  d4,d6                           ; 0050E
        sub.w   d6,d2                           ; 00510
        move.w  d2,d1                           ; 00512
        neg.w   d1                              ; 00514
l_035_00516:
        movem.w d0-d2,(dat_071_00496).l         ; 00516
        move.w  d2,d5                           ; 0051E
        blt.b   l_035_00538                     ; 00520
        move.w  d2,d6                           ; 00522
        cmp.w   d5,d0                           ; 00524
        bgt.b   l_035_00538                     ; 00526
        neg.w   d0                              ; 00528
        cmp.w   d5,d0                           ; 0052A
        bgt.b   l_035_00538                     ; 0052C
        cmp.w   d6,d1                           ; 0052E
        bgt.b   l_035_00538                     ; 00530
        neg.w   d1                              ; 00532
        cmp.w   d6,d1                           ; 00534
        ble.b   l_035_00540                     ; 00536
l_035_00538:
        moveq   #$1,d0                          ; 00538
        movem.l (a7)+,d0-d6                     ; 0053A
        rts                                     ; 0053E
l_035_00540:
        moveq   #$0,d0                          ; 00540
        movem.l (a7)+,d0-d6                     ; 00542
        rts                                     ; 00546
l_035_00548:
        jsr     (Plot2).l                       ; 00548
        rts                                     ; 0054E
sub_035_00550:
        move.w  d6,d5                           ; 00550
        subq.w  #$1,d5                          ; 00552
        blt.b   l_035_00548                     ; 00554
        link.w  a6,#$fff8                       ; 00556
        movea.l (dat_073_016A4).l,a2            ; 0055A
        subq.w  #$1,d5                          ; 00560
        bge.b   l_035_00570                     ; 00562
        move.w  d6,(a2)+                        ; 00564
        move.l  #$ffff0001,(a2)                 ; 00566
        bra.w   l_035_005E0                     ; 0056C
l_035_00570:
        cmpi.w  #$7f,d6                         ; 00570
        ble.b   l_035_0057A                     ; 00574
        move.w  #$7f,d6                         ; 00576
l_035_0057A:
        move.w  d6,(a2)+                        ; 0057A
        move.w  d6,d2                           ; 0057C
        move.w  d2,d5                           ; 0057E
        add.w   d5,d5                           ; 00580
        add.w   d5,d5                           ; 00582
        lea.l   (a2,d5.w),a3                    ; 00584
        clr.w   d3                              ; 00588
        moveq   #$3,d4                          ; 0058A
        sub.w   d2,d4                           ; 0058C
        sub.w   d2,d4                           ; 0058E
        cmp.w   d2,d3                           ; 00590
        bge.b   l_035_005D2                     ; 00592
l_035_00594:
        neg.w   d3                              ; 00594
        move.w  d3,(a2)                         ; 00596
        neg.w   d3                              ; 00598
        move.w  d3,$2(a2)                       ; 0059A
        neg.w   d2                              ; 0059E
        move.w  d2,(a3)                         ; 005A0
        neg.w   d2                              ; 005A2
        move.w  d2,$2(a3)                       ; 005A4
        tst.w   d4                              ; 005A8
        bge.b   l_035_005B8                     ; 005AA
        add.w   d3,d4                           ; 005AC
        add.w   d3,d4                           ; 005AE
        add.w   d3,d4                           ; 005B0
        add.w   d3,d4                           ; 005B2
        addq.w  #$6,d4                          ; 005B4
        bra.b   l_035_005CA                     ; 005B6
l_035_005B8:
        move.w  d3,d5                           ; 005B8
        sub.w   d2,d5                           ; 005BA
        add.w   d5,d5                           ; 005BC
        add.w   d5,d5                           ; 005BE
        addi.w  #$a,d5                          ; 005C0
        add.w   d5,d4                           ; 005C4
        subq.w  #$1,d2                          ; 005C6
        addq.w  #$4,a2                          ; 005C8
l_035_005CA:
        subq.w  #$4,a3                          ; 005CA
        addq.w  #$1,d3                          ; 005CC
        cmp.w   d2,d3                           ; 005CE
        blt.b   l_035_00594                     ; 005D0
l_035_005D2:
        cmp.w   d2,d3                           ; 005D2
        bne.b   l_035_005E0                     ; 005D4
        neg.w   d3                              ; 005D6
        move.w  d3,(a2)                         ; 005D8
        neg.w   d3                              ; 005DA
        move.w  d3,$2(a2)                       ; 005DC
l_035_005E0:
        move.w  d0,-$6(a6)                      ; 005E0
        movea.l (dat_073_016A4).l,a4            ; 005E4
        move.w  (a4)+,d4                        ; 005EA
        move.w  d4,d6                           ; 005EC
        subq.w  #$1,d4                          ; 005EE
        sub.w   d4,d1                           ; 005F0
        cmpi.w  #$1,d1                          ; 005F2
        bge.b   l_035_0062C                     ; 005F6
        subq.w  #$1,d1                          ; 005F8
        add.w   d1,d4                           ; 005FA
        bge.b   l_035_00604                     ; 005FC
        add.w   d4,d6                           ; 005FE
        ble.w   l_035_0080E                     ; 00600
l_035_00604:
        neg.w   d1                              ; 00604
        asl.w   #$2,d1                          ; 00606
        adda.w  d1,a4                           ; 00608
        moveq   #$1,d1                          ; 0060A
        bra.b   l_035_0062C                     ; 0060C
l_035_0060E:
        move.w  d1,d5                           ; 0060E
        sub.w   (ClipY).l,d5                    ; 00610
        sub.w   d6,d1                           ; 00616
        sub.w   d4,d1                           ; 00618
        cmp.w   (ClipY).l,d1                    ; 0061A
        bgt.w   l_035_0080E                     ; 00620
        sub.w   d5,d6                           ; 00624
        bge.b   l_035_0063C                     ; 00626
        add.w   d6,d4                           ; 00628
        bra.b   l_035_0063C                     ; 0062A
l_035_0062C:
        add.w   d4,d1                           ; 0062C
        add.w   d6,d1                           ; 0062E
        cmp.w   (ClipY).l,d1                    ; 00630
        bge.b   l_035_0060E                     ; 00636
        sub.w   d6,d1                           ; 00638
        sub.w   d4,d1                           ; 0063A
l_035_0063C:
        move.w  d1,d5                           ; 0063C
        asl.w   #$3,d5                          ; 0063E
        move.w  d5,d1                           ; 00640
        add.w   d1,d1                           ; 00642
        add.w   d1,d1                           ; 00644
        add.w   d5,d1                           ; 00646
        movea.l (DrawPlanes).l,a1               ; 00648
        movea.l $c(a1),a1                       ; 0064E
        adda.w  d1,a1                           ; 00652
        lea.l   (CUSTOM).l,a2                    ; 00654
l_035_0065A:
        btst    #$6,DMACONR(a2)                 ; 0065A
        beq.b   l_035_00668                     ; 00660
        nop                                     ; 00662
        nop                                     ; 00664
        bra.b   l_035_0065A                     ; 00666
l_035_00668:
        move.w  #$0,BLTCON1(a2)                 ; 00668
        move.w  #$ffff,BLTADAT(a2)              ; 0066E
        move.w  (DrawColour).l,-$2(a6)          ; 00674
l_035_0067C:
        move.w  -$2(a6),-$4(a6)                 ; 0067C
        move.w  (a4),d0                         ; 00682
        add.w   -$6(a6),d0                      ; 00684
        bge.b   l_035_0068C                     ; 00688
        clr.w   d0                              ; 0068A
l_035_0068C:
        move.w  $2(a4),d7                       ; 0068C
        add.w   -$6(a6),d7                      ; 00690
        cmpi.w  #$140,d7                        ; 00694
        blt.b   l_035_0069E                     ; 00698
        move.w  #$13f,d7                        ; 0069A
l_035_0069E:
        sub.w   d0,d7                           ; 0069E
        move.w  d0,d1                           ; 006A0
        andi.w  #$f,d0                          ; 006A2
        andi.w  #$fff0,d1                       ; 006A6
        asr.w   #$3,d1                          ; 006AA
        lea.l   (a1,d1.w),a0                    ; 006AC
        move.w  d7,d1                           ; 006B0
        move.w  d0,d7                           ; 006B2
        neg.w   d0                              ; 006B4
        addi.w  #$10,d0                         ; 006B6
        cmp.w   d1,d0                           ; 006BA
        ble.b   l_035_006C2                     ; 006BC
        move.w  d1,d0                           ; 006BE
        addq.w  #$1,d0                          ; 006C0
l_035_006C2:
        sub.w   d0,d1                           ; 006C2
        add.w   d0,d0                           ; 006C4
        move.w  dat_035_006D2(pc,d0.w),d0       ; 006C6
        ror.w   d7,d0                           ; 006CA
        move.w  d0,BLTAFWM(a2)                  ; 006CC
        bra.b   l_035_006F4                     ; 006D0
dat_035_006D2:
	dc.b	$00,$00,$80,$00,$C0,$00,$E0,$00,$F0,$00,$F8,$00,$FC,$00,$FE,$00
	dc.b	$FF,$00,$FF,$80,$FF,$C0,$FF,$E0,$FF,$F0,$FF,$F8,$FF,$FC,$FF,$FE
	dc.b	$FF,$FF
l_035_006F4:
        move.w  #$41,d7                         ; 006F4
        cmpi.w  #$f,d1                          ; 006F8
        blt.b   l_035_0070C                     ; 006FC
        move.w  d1,d0                           ; 006FE
        addq.w  #$1,d0                          ; 00700
        andi.w  #$fff0,d0                       ; 00702
        sub.w   d0,d1                           ; 00706
        asr.w   #$4,d0                          ; 00708
        add.w   d0,d7                           ; 0070A
l_035_0070C:
        tst.w   d1                              ; 0070C
        blt.b   l_035_0073A                     ; 0070E
        addq.w  #$1,d7                          ; 00710
        add.w   d1,d1                           ; 00712
        move.w  dat_035_0071A(pc,d1.w),d0       ; 00714
        bra.b   l_035_0073C                     ; 00718
dat_035_0071A:
	dc.b	$80,$00,$C0,$00,$E0,$00,$F0,$00,$F8,$00,$FC,$00,$FE,$00,$FF,$00
	dc.b	$FF,$80,$FF,$C0,$FF,$E0,$FF,$F0,$FF,$F8,$FF,$FC,$FF,$FE,$FF,$FF
l_035_0073A:
        moveq   #-1,d0                          ; 0073A
l_035_0073C:
        move.w  d0,BLTALWM(a2)                  ; 0073C
        lsr.w   -$4(a6)                         ; 00740
        bcc.b   l_035_0074C                     ; 00744
        move.w  #$3fa,d0                        ; 00746
        bra.b   l_035_00750                     ; 0074A
l_035_0074C:
        move.w  #$30a,d0                        ; 0074C
l_035_00750:
        move.w  d0,BLTCON0(a2)                  ; 00750
        move.l  a0,BLTCPTH(a2)                  ; 00754
        move.l  a0,BLTDPTH(a2)                  ; 00758
        move.w  d7,BLTSIZE(a2)                  ; 0075C
        lea.l   $1f40(a0),a0                    ; 00760
        lsr.w   -$4(a6)                         ; 00764
        bcc.b   l_035_00770                     ; 00768
        move.w  #$3fa,d0                        ; 0076A
        bra.b   l_035_00774                     ; 0076E
l_035_00770:
        move.w  #$30a,d0                        ; 00770
l_035_00774:
        btst    #$6,DMACONR(a2)                 ; 00774
        beq.b   l_035_00782                     ; 0077A
        nop                                     ; 0077C
        nop                                     ; 0077E
        bra.b   l_035_00774                     ; 00780
l_035_00782:
        move.w  d0,BLTCON0(a2)                  ; 00782
        move.l  a0,BLTCPTH(a2)                  ; 00786
        move.l  a0,BLTDPTH(a2)                  ; 0078A
        move.w  d7,BLTSIZE(a2)                  ; 0078E
        lea.l   $1f40(a0),a0                    ; 00792
        lsr.w   -$4(a6)                         ; 00796
        bcc.b   l_035_007A2                     ; 0079A
        move.w  #$3fa,d0                        ; 0079C
        bra.b   l_035_007A6                     ; 007A0
l_035_007A2:
        move.w  #$30a,d0                        ; 007A2
l_035_007A6:
        btst    #$6,DMACONR(a2)                 ; 007A6
        beq.b   l_035_007B4                     ; 007AC
        nop                                     ; 007AE
        nop                                     ; 007B0
        bra.b   l_035_007A6                     ; 007B2
l_035_007B4:
        move.w  d0,BLTCON0(a2)                  ; 007B4
        move.l  a0,BLTCPTH(a2)                  ; 007B8
        move.l  a0,BLTDPTH(a2)                  ; 007BC
        move.w  d7,BLTSIZE(a2)                  ; 007C0
        lea.l   $1f40(a0),a0                    ; 007C4
        lsr.w   -$4(a6)                         ; 007C8
        bcc.b   l_035_007D4                     ; 007CC
        move.w  #$3fa,d0                        ; 007CE
        bra.b   l_035_007D8                     ; 007D2
l_035_007D4:
        move.w  #$30a,d0                        ; 007D4
l_035_007D8:
        btst    #$6,DMACONR(a2)                 ; 007D8
        beq.b   l_035_007E6                     ; 007DE
        nop                                     ; 007E0
        nop                                     ; 007E2
        bra.b   l_035_007D8                     ; 007E4
l_035_007E6:
        move.w  d0,BLTCON0(a2)                  ; 007E6
        move.l  a0,BLTCPTH(a2)                  ; 007EA
        move.l  a0,BLTDPTH(a2)                  ; 007EE
        move.w  d7,BLTSIZE(a2)                  ; 007F2
        adda.w  #$28,a1                         ; 007F6
        tst.w   d4                              ; 007FA
        blt.b   l_035_00806                     ; 007FC
        addq.w  #$4,a4                          ; 007FE
        subq.w  #$1,d4                          ; 00800
        bge.w   l_035_0067C                     ; 00802
l_035_00806:
        subq.w  #$4,a4                          ; 00806
        subq.w  #$1,d6                          ; 00808
        bge.w   l_035_0067C                     ; 0080A
l_035_0080E:
        unlk    a6                              ; 0080E
        rts                                     ; 00810
	dc.b	$00,$00
h035_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    21,71                           ; 21 longs pointing into hunk 71
	dc.l	$4,$428,$676,$64A,$26,$20E,$246,$280
	dc.l	$2BE,$302,$33A,$370,$3A0,$3CE,$51A,$1A
	dc.l	$94,$8A,$612,$61C,$632
        dc.l    1,7                             ; 1 longs pointing into hunk 7
	dc.l	$A
        dc.l    2,73                            ; 2 longs pointing into hunk 73
	dc.l	$55C,$5E6
        dc.l    6,36                            ; 6 longs pointing into hunk 36
	dc.l	$C6,$BE,$54A,$B6,$1C8,$41A
        dc.l    4,72                            ; 4 longs pointing into hunk 72
	dc.l	$102,$1E0,$1E6,$414
	dc.l	0
	dc.l	HUNK_END
	endc
