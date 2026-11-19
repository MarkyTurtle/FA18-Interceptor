; F/A-18 Interceptor - hunk 19 (code)
; Arithmetic for the 3D pipeline (used by hunks 12-14) (not worked out yet)
; Included by ../f18_main.s.

;===============================================================================
; Hunk 19: CODE, $720 bytes
;===============================================================================
	CODE_HUNK	h019
l_019_00000:
        bra.w   l_019_00704                     ; 00000
l_019_00004:
        move.w  #$1f,(dat_071_0036E).l          ; 00004
        jsr     (Nop).l                         ; 0000C
        bra.w   l_019_00718                     ; 00012
sub_019_00016:
        nop                                     ; 00016
sub_019_00018:
        link.w  a6,#$fffa                       ; 00018
        clr.w   d7                              ; 0001C
        lea.l   (dat_072_03C00).l,a0            ; 0001E
        move.w  (a0)+,-$2(a6)                   ; 00024
        move.w  (a0)+,d0                        ; 00028
        cmpi.w  #$3,d0                          ; 0002A
        blt.b   l_019_00004                     ; 0002E
        move.w  d0,-$4(a6)                      ; 00030
        lea.l   (dat_072_03600).l,a1            ; 00034
        lea.l   (dat_073_001A2).l,a2            ; 0003A
        lea.l   (dat_073_00198).l,a3            ; 00040
        lea.l   (dat_073_000FC).l,a4            ; 00046
        clr.l   (a4)                            ; 0004C
        clr.l   $4(a4)                          ; 0004E
        moveq   #$1,d0                          ; 00052
l_019_00054:
        beq.b   l_019_00000                     ; 00054
        subq.w  #$1,-$4(a6)                     ; 00056
        blt.w   l_019_0040C                     ; 0005A
        movem.w (a0)+,d0-d2                     ; 0005E
        move.w  -$2(a6),d3                      ; 00062
        asl.l   d3,d0                           ; 00066
        asl.l   d3,d1                           ; 00068
        asl.l   d3,d2                           ; 0006A
        tst.b   (a4)                            ; 0006C
        bne.b   l_019_0007C                     ; 0006E
        movem.w d0-d2,$6(a2)                    ; 00070
        addq.b  #$1,(a4)                        ; 00076
        bra.w   l_019_0010A                     ; 00078
l_019_0007C:
        movem.w (a2),d3-d5                      ; 0007C
        cmp.w   d2,d1                           ; 00080
        bgt.b   l_019_0008C                     ; 00082
        cmp.w   d5,d4                           ; 00084
        ble.w   l_019_0010A                     ; 00086
        bra.b   l_019_00092                     ; 0008A
l_019_0008C:
        cmp.w   d5,d4                           ; 0008C
        bgt.w   l_019_0010A                     ; 0008E
l_019_00092:
        movem.w d0-d2,-(a7)                     ; 00092
        sub.w   d4,d1                           ; 00096
        neg.w   d2                              ; 00098
        add.w   d5,d2                           ; 0009A
        add.w   d1,d2                           ; 0009C
        beq.b   l_019_00108                     ; 0009E
        sub.w   d4,d5                           ; 000A0
        muls.w  d5,d1                           ; 000A2
        move.w  d2,d6                           ; 000A4
        bge.b   l_019_000AA                     ; 000A6
        neg.w   d6                              ; 000A8
l_019_000AA:
        asr.w   #$1,d6                          ; 000AA
        divs.w  d2,d1                           ; 000AC
        swap    d1                              ; 000AE
        tst.w   d1                              ; 000B0
        bge.b   l_019_000B6                     ; 000B2
        neg.w   d1                              ; 000B4
l_019_000B6:
        cmp.w   d1,d6                           ; 000B6
        bgt.b   l_019_000C8                     ; 000B8
        swap    d1                              ; 000BA
        tst.w   d1                              ; 000BC
        bge.b   l_019_000C4                     ; 000BE
        subq.w  #$1,d1                          ; 000C0
        bra.b   l_019_000CA                     ; 000C2
l_019_000C4:
        addq.w  #$1,d1                          ; 000C4
        bra.b   l_019_000CA                     ; 000C6
l_019_000C8:
        swap    d1                              ; 000C8
l_019_000CA:
        add.w   d4,d1                           ; 000CA
        sub.w   d3,d0                           ; 000CC
        muls.w  d5,d0                           ; 000CE
        divs.w  d2,d0                           ; 000D0
        swap    d0                              ; 000D2
        tst.w   d0                              ; 000D4
        bge.b   l_019_000DA                     ; 000D6
        neg.w   d0                              ; 000D8
l_019_000DA:
        cmp.w   d0,d6                           ; 000DA
        bgt.b   l_019_000EC                     ; 000DC
        swap    d0                              ; 000DE
        tst.w   d0                              ; 000E0
        bge.b   l_019_000E8                     ; 000E2
        subq.w  #$1,d0                          ; 000E4
        bra.b   l_019_000EE                     ; 000E6
l_019_000E8:
        addq.w  #$1,d0                          ; 000E8
        bra.b   l_019_000EE                     ; 000EA
l_019_000EC:
        swap    d0                              ; 000EC
l_019_000EE:
        add.w   d3,d0                           ; 000EE
        move.w  d1,d2                           ; 000F0
        movem.w d0-d2,(a3)                      ; 000F2
        movem.w (a7)+,d0-d2                     ; 000F6
        movem.w d0-d2,(a2)                      ; 000FA
        bsr.w   sub_019_00138                   ; 000FE
        addq.b  #$1,$4(a4)                      ; 00102
        bra.b   l_019_0010E                     ; 00106
l_019_00108:
        bra.b   l_019_00126                     ; 00108
l_019_0010A:
        movem.w d0-d2,(a2)                      ; 0010A
l_019_0010E:
        cmp.w   d2,d1                           ; 0010E
        bgt.b   l_019_00120                     ; 00110
        movem.w d0-d2,(a3)                      ; 00112
        bsr.w   sub_019_00138                   ; 00116
        beq.b   l_019_00126                     ; 0011A
        addq.b  #$1,$4(a4)                      ; 0011C
l_019_00120:
        moveq   #$1,d0                          ; 00120
        bra.w   l_019_00054                     ; 00122
l_019_00126:
        move.w  #$1,(dat_071_0036E).l           ; 00126
        jsr     (Nop).l                         ; 0012E
        bra.w   l_019_00054                     ; 00134
sub_019_00138:
        movem.w d0-d2,-(a7)                     ; 00138
        movem.w (a3),d0-d2                      ; 0013C
        tst.b   $1(a4)                          ; 00140
        bne.b   l_019_00154                     ; 00144
        movem.w d0-d2,$16(a2)                   ; 00146
        addq.b  #$1,$1(a4)                      ; 0014C
        bra.w   l_019_001F2                     ; 00150
l_019_00154:
        movem.w $10(a2),d3-d5                   ; 00154
        neg.w   d1                              ; 0015A
        neg.w   d4                              ; 0015C
        cmp.w   d2,d1                           ; 0015E
        bgt.b   l_019_0016A                     ; 00160
        cmp.w   d5,d4                           ; 00162
        ble.w   l_019_001F0                     ; 00164
        bra.b   l_019_00170                     ; 00168
l_019_0016A:
        cmp.w   d5,d4                           ; 0016A
        bgt.w   l_019_001F0                     ; 0016C
l_019_00170:
        neg.w   d1                              ; 00170
        neg.w   d4                              ; 00172
        movem.w d0-d2,-(a7)                     ; 00174
        sub.w   d4,d1                           ; 00178
        neg.w   d2                              ; 0017A
        add.w   d5,d2                           ; 0017C
        sub.w   d1,d2                           ; 0017E
        beq.b   l_019_001EE                     ; 00180
        add.w   d4,d5                           ; 00182
        muls.w  d5,d1                           ; 00184
        move.w  d2,d6                           ; 00186
        bge.b   l_019_0018C                     ; 00188
        neg.w   d6                              ; 0018A
l_019_0018C:
        asr.w   #$1,d6                          ; 0018C
        divs.w  d2,d1                           ; 0018E
        swap    d1                              ; 00190
        tst.w   d1                              ; 00192
        bge.b   l_019_00198                     ; 00194
        neg.w   d1                              ; 00196
l_019_00198:
        cmp.w   d1,d6                           ; 00198
        bgt.b   l_019_001AA                     ; 0019A
        swap    d1                              ; 0019C
        tst.w   d1                              ; 0019E
        bge.b   l_019_001A6                     ; 001A0
        subq.w  #$1,d1                          ; 001A2
        bra.b   l_019_001AC                     ; 001A4
l_019_001A6:
        addq.w  #$1,d1                          ; 001A6
        bra.b   l_019_001AC                     ; 001A8
l_019_001AA:
        swap    d1                              ; 001AA
l_019_001AC:
        add.w   d4,d1                           ; 001AC
        sub.w   d3,d0                           ; 001AE
        muls.w  d5,d0                           ; 001B0
        divs.w  d2,d0                           ; 001B2
        swap    d0                              ; 001B4
        tst.w   d0                              ; 001B6
        bge.b   l_019_001BC                     ; 001B8
        neg.w   d0                              ; 001BA
l_019_001BC:
        cmp.w   d0,d6                           ; 001BC
        bgt.b   l_019_001CE                     ; 001BE
        swap    d0                              ; 001C0
        tst.w   d0                              ; 001C2
        bge.b   l_019_001CA                     ; 001C4
        subq.w  #$1,d0                          ; 001C6
        bra.b   l_019_001D0                     ; 001C8
l_019_001CA:
        addq.w  #$1,d0                          ; 001CA
        bra.b   l_019_001D0                     ; 001CC
l_019_001CE:
        swap    d0                              ; 001CE
l_019_001D0:
        add.w   d3,d0                           ; 001D0
        move.w  d1,d2                           ; 001D2
        neg.w   d2                              ; 001D4
        movem.w d0-d2,(a3)                      ; 001D6
        movem.w (a7)+,d0-d2                     ; 001DA
        movem.w d0-d2,$10(a2)                   ; 001DE
        bsr.w   sub_019_0022A                   ; 001E4
        addq.b  #$1,$5(a4)                      ; 001E8
        bra.b   l_019_001F8                     ; 001EC
l_019_001EE:
        bra.b   l_019_00216                     ; 001EE
l_019_001F0:
        neg.w   d1                              ; 001F0
l_019_001F2:
        movem.w d0-d2,$10(a2)                   ; 001F2
l_019_001F8:
        neg.w   d1                              ; 001F8
        cmp.w   d2,d1                           ; 001FA
        bgt.b   l_019_0020E                     ; 001FC
        neg.w   d1                              ; 001FE
        movem.w d0-d2,(a3)                      ; 00200
        bsr.w   sub_019_0022A                   ; 00204
        beq.b   l_019_00216                     ; 00208
        addq.b  #$1,$5(a4)                      ; 0020A
l_019_0020E:
        moveq   #$1,d0                          ; 0020E
        movem.w (a7)+,d0-d2                     ; 00210
        rts                                     ; 00214
l_019_00216:
        move.w  #$3,(dat_071_0036E).l           ; 00216
        jsr     (Nop).l                         ; 0021E
        movem.w (a7)+,d0-d2                     ; 00224
        rts                                     ; 00228
sub_019_0022A:
        movem.w d0-d2,-(a7)                     ; 0022A
        movem.w (a3),d0-d2                      ; 0022E
        tst.b   $2(a4)                          ; 00232
        bne.b   l_019_00246                     ; 00236
        movem.w d0-d2,$26(a2)                   ; 00238
        addq.b  #$1,$2(a4)                      ; 0023E
        bra.w   l_019_002DA                     ; 00242
l_019_00246:
        movem.w $20(a2),d3-d5                   ; 00246
        move.w  d2,d6                           ; 0024C
        cmp.w   d2,d0                           ; 0024E
        bgt.b   l_019_0025A                     ; 00250
        cmp.w   d5,d3                           ; 00252
        ble.w   l_019_002DA                     ; 00254
        bra.b   l_019_00260                     ; 00258
l_019_0025A:
        cmp.w   d5,d3                           ; 0025A
        bgt.w   l_019_002DA                     ; 0025C
l_019_00260:
        movem.w d0-d2,-(a7)                     ; 00260
        sub.w   d3,d0                           ; 00264
        neg.w   d2                              ; 00266
        add.w   d5,d2                           ; 00268
        add.w   d0,d2                           ; 0026A
        beq.b   l_019_002D8                     ; 0026C
        sub.w   d3,d5                           ; 0026E
        muls.w  d5,d0                           ; 00270
        move.w  d2,d6                           ; 00272
        bge.b   l_019_00278                     ; 00274
        neg.w   d6                              ; 00276
l_019_00278:
        asr.w   #$1,d6                          ; 00278
        divs.w  d2,d0                           ; 0027A
        swap    d0                              ; 0027C
        tst.w   d0                              ; 0027E
        bge.b   l_019_00284                     ; 00280
        neg.w   d0                              ; 00282
l_019_00284:
        cmp.w   d0,d6                           ; 00284
        bgt.b   l_019_00296                     ; 00286
        swap    d0                              ; 00288
        tst.w   d0                              ; 0028A
        bge.b   l_019_00292                     ; 0028C
        subq.w  #$1,d0                          ; 0028E
        bra.b   l_019_00298                     ; 00290
l_019_00292:
        addq.w  #$1,d0                          ; 00292
        bra.b   l_019_00298                     ; 00294
l_019_00296:
        swap    d0                              ; 00296
l_019_00298:
        add.w   d3,d0                           ; 00298
        sub.w   d4,d1                           ; 0029A
        muls.w  d5,d1                           ; 0029C
        divs.w  d2,d1                           ; 0029E
        swap    d1                              ; 002A0
        tst.w   d1                              ; 002A2
        bge.b   l_019_002A8                     ; 002A4
        neg.w   d1                              ; 002A6
l_019_002A8:
        cmp.w   d1,d6                           ; 002A8
        bgt.b   l_019_002BA                     ; 002AA
        swap    d1                              ; 002AC
        tst.w   d1                              ; 002AE
        bge.b   l_019_002B6                     ; 002B0
        subq.w  #$1,d1                          ; 002B2
        bra.b   l_019_002BC                     ; 002B4
l_019_002B6:
        addq.w  #$1,d1                          ; 002B6
        bra.b   l_019_002BC                     ; 002B8
l_019_002BA:
        swap    d1                              ; 002BA
l_019_002BC:
        add.w   d4,d1                           ; 002BC
        move.w  d0,d2                           ; 002BE
        movem.w d0-d2,(a3)                      ; 002C0
        movem.w (a7)+,d0-d2                     ; 002C4
        movem.w d0-d2,$20(a2)                   ; 002C8
        bsr.w   sub_019_0030E                   ; 002CE
        addq.b  #$1,$6(a4)                      ; 002D2
        bra.b   l_019_002E0                     ; 002D6
l_019_002D8:
        bra.b   l_019_002FA                     ; 002D8
l_019_002DA:
        movem.w d0-d2,$20(a2)                   ; 002DA
l_019_002E0:
        cmp.w   d2,d0                           ; 002E0
        bgt.b   l_019_002F2                     ; 002E2
        movem.w d0-d2,(a3)                      ; 002E4
        bsr.w   sub_019_0030E                   ; 002E8
        beq.b   l_019_002FA                     ; 002EC
        addq.b  #$1,$6(a4)                      ; 002EE
l_019_002F2:
        moveq   #$1,d0                          ; 002F2
        movem.w (a7)+,d0-d2                     ; 002F4
        rts                                     ; 002F8
l_019_002FA:
        move.w  #$4,(dat_071_0036E).l           ; 002FA
        jsr     (Nop).l                         ; 00302
        movem.w (a7)+,d0-d2                     ; 00308
        rts                                     ; 0030C
sub_019_0030E:
        movem.w d0-d2,-(a7)                     ; 0030E
        movem.w (a3),d0-d2                      ; 00312
        tst.b   $3(a4)                          ; 00316
        bne.b   l_019_0032A                     ; 0031A
        movem.w d0-d2,$36(a2)                   ; 0031C
        addq.b  #$1,$3(a4)                      ; 00322
        bra.w   l_019_003D6                     ; 00326
l_019_0032A:
        movem.w $30(a2),d3-d5                   ; 0032A
        neg.w   d0                              ; 00330
        neg.w   d3                              ; 00332
        cmp.w   d2,d0                           ; 00334
        bgt.b   l_019_00344                     ; 00336
        cmp.w   d5,d3                           ; 00338
        ble.w   l_019_003D4                     ; 0033A
        bra.b   l_019_0034A                     ; 0033E
l_019_00340:
        bra.w   l_019_003F8                     ; 00340
l_019_00344:
        cmp.w   d5,d3                           ; 00344
        bgt.w   l_019_003D4                     ; 00346
l_019_0034A:
        neg.w   d0                              ; 0034A
        neg.w   d3                              ; 0034C
        movem.w d0-d2,-(a7)                     ; 0034E
        sub.w   d3,d0                           ; 00352
        neg.w   d2                              ; 00354
        add.w   d5,d2                           ; 00356
        sub.w   d0,d2                           ; 00358
        beq.b   l_019_00340                     ; 0035A
        add.w   d3,d5                           ; 0035C
        muls.w  d5,d0                           ; 0035E
        move.w  d2,d6                           ; 00360
        bge.b   l_019_00366                     ; 00362
        neg.w   d6                              ; 00364
l_019_00366:
        asr.w   #$1,d6                          ; 00366
        divs.w  d2,d0                           ; 00368
        swap    d0                              ; 0036A
        tst.w   d0                              ; 0036C
        bge.b   l_019_00372                     ; 0036E
        neg.w   d0                              ; 00370
l_019_00372:
        cmp.w   d0,d6                           ; 00372
        bgt.b   l_019_00384                     ; 00374
        swap    d0                              ; 00376
        tst.w   d0                              ; 00378
        bge.b   l_019_00380                     ; 0037A
        subq.w  #$1,d0                          ; 0037C
        bra.b   l_019_00386                     ; 0037E
l_019_00380:
        addq.w  #$1,d0                          ; 00380
        bra.b   l_019_00386                     ; 00382
l_019_00384:
        swap    d0                              ; 00384
l_019_00386:
        add.w   d3,d0                           ; 00386
        sub.w   d4,d1                           ; 00388
        muls.w  d5,d1                           ; 0038A
        move.w  d2,d6                           ; 0038C
        bge.b   l_019_00392                     ; 0038E
        neg.w   d6                              ; 00390
l_019_00392:
        asr.w   #$1,d6                          ; 00392
        divs.w  d2,d1                           ; 00394
        swap    d1                              ; 00396
        tst.w   d1                              ; 00398
        bge.b   l_019_0039E                     ; 0039A
        neg.w   d1                              ; 0039C
l_019_0039E:
        cmp.w   d1,d6                           ; 0039E
        bgt.b   l_019_003B0                     ; 003A0
        swap    d1                              ; 003A2
        tst.w   d1                              ; 003A4
        bge.b   l_019_003AC                     ; 003A6
        subq.w  #$1,d1                          ; 003A8
        bra.b   l_019_003B2                     ; 003AA
l_019_003AC:
        addq.w  #$1,d1                          ; 003AC
        bra.b   l_019_003B2                     ; 003AE
l_019_003B0:
        swap    d1                              ; 003B0
l_019_003B2:
        add.w   d4,d1                           ; 003B2
        move.w  d0,d2                           ; 003B4
        neg.w   d2                              ; 003B6
        movem.w d0-d2,(a3)                      ; 003B8
        move.l  (a3),(a1)+                      ; 003BC
        move.w  $4(a3),(a1)+                    ; 003BE
        addq.w  #$1,d7                          ; 003C2
        movem.w (a7)+,d0-d2                     ; 003C4
        movem.w d0-d2,$30(a2)                   ; 003C8
        addq.b  #$1,$7(a4)                      ; 003CE
        bra.b   l_019_003DC                     ; 003D2
l_019_003D4:
        neg.w   d0                              ; 003D4
l_019_003D6:
        movem.w d0-d2,$30(a2)                   ; 003D6
l_019_003DC:
        neg.w   d0                              ; 003DC
        cmp.w   d2,d0                           ; 003DE
        bgt.b   l_019_003F0                     ; 003E0
        neg.w   d0                              ; 003E2
        move.w  d0,(a1)+                        ; 003E4
        move.w  d1,(a1)+                        ; 003E6
        move.w  d2,(a1)+                        ; 003E8
        addq.w  #$1,d7                          ; 003EA
        addq.b  #$1,$7(a4)                      ; 003EC
l_019_003F0:
        moveq   #$1,d0                          ; 003F0
        movem.w (a7)+,d0-d2                     ; 003F2
        rts                                     ; 003F6
l_019_003F8:
        move.w  #$5,(dat_071_0036E).l           ; 003F8
        jsr     (Nop).l                         ; 00400
        movem.w (a7)+,d0-d2                     ; 00406
        rts                                     ; 0040A
l_019_0040C:
        tst.b   $4(a4)                          ; 0040C
        beq.w   l_019_004A0                     ; 00410
        movem.w (a2),d0-d5                      ; 00414
        cmp.w   d2,d1                           ; 00418
        bgt.b   l_019_00436                     ; 0041A
        cmp.w   d5,d4                           ; 0041C
        ble.w   l_019_004A0                     ; 0041E
        bra.b   l_019_0043C                     ; 00422
l_019_00424:
        move.w  #$6,(dat_071_0036E).l           ; 00424
        jsr     (Nop).l                         ; 0042C
        bra.w   l_019_00704                     ; 00432
l_019_00436:
        cmp.w   d5,d4                           ; 00436
        bgt.w   l_019_004A0                     ; 00438
l_019_0043C:
        sub.w   d4,d1                           ; 0043C
        neg.w   d2                              ; 0043E
        add.w   d5,d2                           ; 00440
        add.w   d1,d2                           ; 00442
        beq.b   l_019_00424                     ; 00444
        sub.w   d4,d5                           ; 00446
        muls.w  d5,d1                           ; 00448
        move.w  d2,d6                           ; 0044A
        bge.b   l_019_00450                     ; 0044C
        neg.w   d6                              ; 0044E
l_019_00450:
        asr.w   #$1,d6                          ; 00450
        divs.w  d2,d1                           ; 00452
        swap    d1                              ; 00454
        tst.w   d1                              ; 00456
        bge.b   l_019_0045C                     ; 00458
        neg.w   d1                              ; 0045A
l_019_0045C:
        cmp.w   d1,d6                           ; 0045C
        bgt.b   l_019_0046E                     ; 0045E
        swap    d1                              ; 00460
        tst.w   d1                              ; 00462
        bge.b   l_019_0046A                     ; 00464
        subq.w  #$1,d1                          ; 00466
        bra.b   l_019_00470                     ; 00468
l_019_0046A:
        addq.w  #$1,d1                          ; 0046A
        bra.b   l_019_00470                     ; 0046C
l_019_0046E:
        swap    d1                              ; 0046E
l_019_00470:
        add.w   d4,d1                           ; 00470
        sub.w   d3,d0                           ; 00472
        muls.w  d5,d0                           ; 00474
        divs.w  d2,d0                           ; 00476
        swap    d0                              ; 00478
        tst.w   d0                              ; 0047A
        bge.b   l_019_00480                     ; 0047C
        neg.w   d0                              ; 0047E
l_019_00480:
        cmp.w   d0,d6                           ; 00480
        bgt.b   l_019_00492                     ; 00482
        swap    d0                              ; 00484
        tst.w   d0                              ; 00486
        bge.b   l_019_0048E                     ; 00488
        subq.w  #$1,d0                          ; 0048A
        bra.b   l_019_00494                     ; 0048C
l_019_0048E:
        addq.w  #$1,d0                          ; 0048E
        bra.b   l_019_00494                     ; 00490
l_019_00492:
        swap    d0                              ; 00492
l_019_00494:
        add.w   d3,d0                           ; 00494
        move.w  d1,d2                           ; 00496
        movem.w d0-d2,(a3)                      ; 00498
        bsr.w   sub_019_00138                   ; 0049C
l_019_004A0:
        tst.b   $5(a4)                          ; 004A0
        beq.w   l_019_00540                     ; 004A4
        movem.w $10(a2),d0-d5                   ; 004A8
        neg.w   d1                              ; 004AE
        neg.w   d4                              ; 004B0
        cmp.w   d2,d1                           ; 004B2
        bgt.b   l_019_004D0                     ; 004B4
        cmp.w   d5,d4                           ; 004B6
        ble.w   l_019_00540                     ; 004B8
        bra.b   l_019_004D6                     ; 004BC
l_019_004BE:
        move.w  #$7,(dat_071_0036E).l           ; 004BE
        jsr     (Nop).l                         ; 004C6
        bra.w   l_019_00704                     ; 004CC
l_019_004D0:
        cmp.w   d5,d4                           ; 004D0
        bgt.w   l_019_00540                     ; 004D2
l_019_004D6:
        neg.w   d1                              ; 004D6
        neg.w   d4                              ; 004D8
        sub.w   d4,d1                           ; 004DA
        neg.w   d2                              ; 004DC
        add.w   d5,d2                           ; 004DE
        sub.w   d1,d2                           ; 004E0
        beq.b   l_019_004BE                     ; 004E2
        add.w   d4,d5                           ; 004E4
        muls.w  d5,d1                           ; 004E6
        move.w  d2,d6                           ; 004E8
        bge.b   l_019_004EE                     ; 004EA
        neg.w   d6                              ; 004EC
l_019_004EE:
        asr.w   #$1,d6                          ; 004EE
        divs.w  d2,d1                           ; 004F0
        swap    d1                              ; 004F2
        tst.w   d1                              ; 004F4
        bge.b   l_019_004FA                     ; 004F6
        neg.w   d1                              ; 004F8
l_019_004FA:
        cmp.w   d1,d6                           ; 004FA
        bgt.b   l_019_0050C                     ; 004FC
        swap    d1                              ; 004FE
        tst.w   d1                              ; 00500
        bge.b   l_019_00508                     ; 00502
        subq.w  #$1,d1                          ; 00504
        bra.b   l_019_0050E                     ; 00506
l_019_00508:
        addq.w  #$1,d1                          ; 00508
        bra.b   l_019_0050E                     ; 0050A
l_019_0050C:
        swap    d1                              ; 0050C
l_019_0050E:
        add.w   d4,d1                           ; 0050E
        sub.w   d3,d0                           ; 00510
        muls.w  d5,d0                           ; 00512
        divs.w  d2,d0                           ; 00514
        swap    d0                              ; 00516
        tst.w   d0                              ; 00518
        bge.b   l_019_0051E                     ; 0051A
        neg.w   d0                              ; 0051C
l_019_0051E:
        cmp.w   d0,d6                           ; 0051E
        bgt.b   l_019_00530                     ; 00520
        swap    d0                              ; 00522
        tst.w   d0                              ; 00524
        bge.b   l_019_0052C                     ; 00526
        subq.w  #$1,d0                          ; 00528
        bra.b   l_019_00532                     ; 0052A
l_019_0052C:
        addq.w  #$1,d0                          ; 0052C
        bra.b   l_019_00532                     ; 0052E
l_019_00530:
        swap    d0                              ; 00530
l_019_00532:
        add.w   d3,d0                           ; 00532
        move.w  d1,d2                           ; 00534
        neg.w   d2                              ; 00536
        movem.w d0-d2,(a3)                      ; 00538
        bsr.w   sub_019_0022A                   ; 0053C
l_019_00540:
        tst.b   $6(a4)                          ; 00540
        beq.w   l_019_005D6                     ; 00544
        movem.w $20(a2),d0-d5                   ; 00548
        cmp.w   d2,d0                           ; 0054E
        bgt.b   l_019_0056C                     ; 00550
        cmp.w   d5,d3                           ; 00552
        ble.w   l_019_005D6                     ; 00554
        bra.b   l_019_00572                     ; 00558
l_019_0055A:
        move.w  #$8,(dat_071_0036E).l           ; 0055A
        jsr     (Nop).l                         ; 00562
        bra.w   l_019_00704                     ; 00568
l_019_0056C:
        cmp.w   d5,d3                           ; 0056C
        bgt.w   l_019_005D6                     ; 0056E
l_019_00572:
        sub.w   d3,d0                           ; 00572
        neg.w   d2                              ; 00574
        add.w   d5,d2                           ; 00576
        add.w   d0,d2                           ; 00578
        beq.b   l_019_0055A                     ; 0057A
        sub.w   d3,d5                           ; 0057C
        muls.w  d5,d0                           ; 0057E
        move.w  d2,d6                           ; 00580
        bge.b   l_019_00586                     ; 00582
        neg.w   d6                              ; 00584
l_019_00586:
        asr.w   #$1,d6                          ; 00586
        divs.w  d2,d0                           ; 00588
        swap    d0                              ; 0058A
        tst.w   d0                              ; 0058C
        bge.b   l_019_00592                     ; 0058E
        neg.w   d0                              ; 00590
l_019_00592:
        cmp.w   d0,d6                           ; 00592
        bgt.b   l_019_005A4                     ; 00594
        swap    d0                              ; 00596
        tst.w   d0                              ; 00598
        bge.b   l_019_005A0                     ; 0059A
        subq.w  #$1,d0                          ; 0059C
        bra.b   l_019_005A6                     ; 0059E
l_019_005A0:
        addq.w  #$1,d0                          ; 005A0
        bra.b   l_019_005A6                     ; 005A2
l_019_005A4:
        swap    d0                              ; 005A4
l_019_005A6:
        add.w   d3,d0                           ; 005A6
        sub.w   d4,d1                           ; 005A8
        muls.w  d5,d1                           ; 005AA
        divs.w  d2,d1                           ; 005AC
        swap    d1                              ; 005AE
        tst.w   d1                              ; 005B0
        bge.b   l_019_005B6                     ; 005B2
        neg.w   d1                              ; 005B4
l_019_005B6:
        cmp.w   d1,d6                           ; 005B6
        bgt.b   l_019_005C8                     ; 005B8
        swap    d1                              ; 005BA
        tst.w   d1                              ; 005BC
        bge.b   l_019_005C4                     ; 005BE
        subq.w  #$1,d1                          ; 005C0
        bra.b   l_019_005CA                     ; 005C2
l_019_005C4:
        addq.w  #$1,d1                          ; 005C4
        bra.b   l_019_005CA                     ; 005C6
l_019_005C8:
        swap    d1                              ; 005C8
l_019_005CA:
        add.w   d4,d1                           ; 005CA
        move.w  d0,d2                           ; 005CC
        movem.w d0-d2,(a3)                      ; 005CE
        bsr.w   sub_019_0030E                   ; 005D2
l_019_005D6:
        tst.b   $7(a4)                          ; 005D6
        beq.w   l_019_00676                     ; 005DA
        movem.w $30(a2),d0-d5                   ; 005DE
        neg.w   d0                              ; 005E4
        neg.w   d3                              ; 005E6
        cmp.w   d2,d0                           ; 005E8
        bgt.b   l_019_00606                     ; 005EA
        cmp.w   d5,d3                           ; 005EC
        ble.w   l_019_00676                     ; 005EE
        bra.b   l_019_0060C                     ; 005F2
l_019_005F4:
        move.w  #$9,(dat_071_0036E).l           ; 005F4
        jsr     (Nop).l                         ; 005FC
        bra.w   l_019_00704                     ; 00602
l_019_00606:
        cmp.w   d5,d3                           ; 00606
        bgt.w   l_019_00676                     ; 00608
l_019_0060C:
        neg.w   d0                              ; 0060C
        neg.w   d3                              ; 0060E
        sub.w   d3,d0                           ; 00610
        neg.w   d2                              ; 00612
        add.w   d5,d2                           ; 00614
        sub.w   d0,d2                           ; 00616
        beq.b   l_019_005F4                     ; 00618
        add.w   d3,d5                           ; 0061A
        muls.w  d5,d0                           ; 0061C
        move.w  d2,d6                           ; 0061E
        bge.b   l_019_00624                     ; 00620
        neg.w   d6                              ; 00622
l_019_00624:
        asr.w   #$1,d6                          ; 00624
        divs.w  d2,d0                           ; 00626
        swap    d0                              ; 00628
        tst.w   d0                              ; 0062A
        bge.b   l_019_00630                     ; 0062C
        neg.w   d0                              ; 0062E
l_019_00630:
        cmp.w   d0,d6                           ; 00630
        bgt.b   l_019_00642                     ; 00632
        swap    d0                              ; 00634
        tst.w   d0                              ; 00636
        bge.b   l_019_0063E                     ; 00638
        subq.w  #$1,d0                          ; 0063A
        bra.b   l_019_00644                     ; 0063C
l_019_0063E:
        addq.w  #$1,d0                          ; 0063E
        bra.b   l_019_00644                     ; 00640
l_019_00642:
        swap    d0                              ; 00642
l_019_00644:
        add.w   d3,d0                           ; 00644
        sub.w   d4,d1                           ; 00646
        muls.w  d5,d1                           ; 00648
        divs.w  d2,d1                           ; 0064A
        swap    d1                              ; 0064C
        tst.w   d1                              ; 0064E
        bge.b   l_019_00654                     ; 00650
        neg.w   d1                              ; 00652
l_019_00654:
        cmp.w   d1,d6                           ; 00654
        bgt.b   l_019_00666                     ; 00656
        swap    d1                              ; 00658
        tst.w   d1                              ; 0065A
        bge.b   l_019_00662                     ; 0065C
        subq.w  #$1,d1                          ; 0065E
        bra.b   l_019_00668                     ; 00660
l_019_00662:
        addq.w  #$1,d1                          ; 00662
        bra.b   l_019_00668                     ; 00664
l_019_00666:
        swap    d1                              ; 00666
l_019_00668:
        add.w   d4,d1                           ; 00668
        move.w  d0,d2                           ; 0066A
        neg.w   d2                              ; 0066C
        move.w  d0,(a1)+                        ; 0066E
        move.w  d1,(a1)+                        ; 00670
        move.w  d2,(a1)+                        ; 00672
        addq.w  #$1,d7                          ; 00674
l_019_00676:
        tst.w   d7                              ; 00676
        beq.w   l_019_006EA                     ; 00678
        cmpi.w  #$2,d7                          ; 0067C
        ble.b   l_019_006A0                     ; 00680
        lea.l   (dat_072_03600).l,a1            ; 00682
        lea.l   (dat_072_03000).l,a0            ; 00688
        move.w  #$13f,d0                        ; 0068E
        move.w  #$b3,d1                         ; 00692
        move.w  d7,(a0)+                        ; 00696
        subq.w  #$1,d7                          ; 00698
l_019_0069A:
        movem.w (a1)+,d3-d5                     ; 0069A
        tst.w   d5                              ; 0069E
l_019_006A0:
        ble.w   l_019_00718                     ; 006A0
        muls.w  #$a0,d3                         ; 006A4
        divs.w  d5,d3                           ; 006A8
        addi.w  #$a0,d3                         ; 006AA
        blt.b   l_019_006F0                     ; 006AE
        cmpi.w  #$140,d3                        ; 006B0
        bge.b   l_019_006F8                     ; 006B4
l_019_006B6:
        muls.w  #$5a,d4                         ; 006B6
        divs.w  d5,d4                           ; 006BA
        addi.w  #$5a,d4                         ; 006BC
        blt.b   l_019_006F4                     ; 006C0
        cmpi.w  #$b4,d4                         ; 006C2
        bge.b   l_019_006FE                     ; 006C6
l_019_006C8:
        move.w  d0,d2                           ; 006C8
        move.w  d1,d5                           ; 006CA
        sub.w   d3,d2                           ; 006CC
        sub.w   d4,d5                           ; 006CE
        move.w  d2,(a0)+                        ; 006D0
        move.w  d5,(a0)+                        ; 006D2
        dbra    d7,l_019_0069A                  ; 006D4
        jsr     (sub_036_00AB8).l               ; 006D8
        addq.w  #$1,(dat_071_00B52).l           ; 006DE
        unlk    a6                              ; 006E4
        moveq   #$1,d0                          ; 006E6
        rts                                     ; 006E8
l_019_006EA:
        unlk    a6                              ; 006EA
        moveq   #$0,d0                          ; 006EC
        rts                                     ; 006EE
l_019_006F0:
        clr.w   d3                              ; 006F0
        bra.b   l_019_006B6                     ; 006F2
l_019_006F4:
        clr.w   d4                              ; 006F4
        bra.b   l_019_006C8                     ; 006F6
l_019_006F8:
        move.w  #$13f,d3                        ; 006F8
        bra.b   l_019_006B6                     ; 006FC
l_019_006FE:
        move.w  #$b3,d4                         ; 006FE
        bra.b   l_019_006C8                     ; 00702
l_019_00704:
        addq.w  #$1,(dat_071_002BC).l           ; 00704
        move.w  #$a,(dat_071_0036E).l           ; 0070A
        jsr     (Nop).l                         ; 00712
l_019_00718:
        clr.w   d7                              ; 00718
        unlk    a6                              ; 0071A
        moveq   #$0,d0                          ; 0071C
        rts                                     ; 0071E
h019_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    12,71                           ; 12 longs pointing into hunk 71
	dc.l	$8,$12A,$21A,$2FE,$3FC,$428,$4C2,$55E
	dc.l	$5F8,$70E,$706,$6E0
        dc.l    4,72                            ; 4 longs pointing into hunk 72
	dc.l	$36,$684,$68A,$20
        dc.l    3,73                            ; 3 longs pointing into hunk 73
	dc.l	$42,$3C,$48
        dc.l    10,7                            ; 10 longs pointing into hunk 7
	dc.l	$E,$130,$220,$304,$402,$42E,$4C8,$564
	dc.l	$5FE,$714
        dc.l    1,36                            ; 1 longs pointing into hunk 36
	dc.l	$6DA
	dc.l	0
	dc.l	HUNK_END
	endc
