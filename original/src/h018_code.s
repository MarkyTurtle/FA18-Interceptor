; F/A-18 Interceptor - hunk 18 (code)
; Included by ../f18_main.s.

;===============================================================================
; Hunk 18: CODE, $65C bytes
;===============================================================================
	CODE_HUNK	h018
sub_018_00000:
        move.l  d0,-(a7)                        ; 00000
        move.w  (dat_071_00390).l,d0            ; 00002
        cmpi.w  #$ffff,d0                       ; 00008
        beq.b   l_018_00032                     ; 0000C
        cmp.w   (dat_071_00386).l,d0            ; 0000E
        bne.b   l_018_00032                     ; 00014
        move.w  #$4016,d0                       ; 00016
        jsr     (sub_020_00954).l               ; 0001A
        move.w  #$ffff,(dat_071_00390).l        ; 00020
        andi.l  #$ffffbdff,(dat_071_00520).l    ; 00028
l_018_00032:
        move.l  (a7)+,d0                        ; 00032
        rts                                     ; 00034
sub_018_00036:
        clr.b   (dat_071_0018A).l               ; 00036
        clr.b   (dat_071_0018B).l               ; 0003C
        clr.b   (dat_071_0018C).l               ; 00042
        jsr     (sub_017_00430).l               ; 00048
        btst    #$6,(dat_071_0029D).l           ; 0004E
        beq.b   l_018_000C4                     ; 00056
        tst.b   (dat_071_00160).l               ; 00058
        bne.b   l_018_000C4                     ; 0005E
        move.b  (dat_071_00276).l,d0            ; 00060
        cmpi.b  #$2,d0                          ; 00066
        ble.b   l_018_000C4                     ; 0006A
        cmpi.b  #$3,d0                          ; 0006C
        bne.b   l_018_00078                     ; 00070
        bsr.w   sub_018_000C8                   ; 00072
        bra.b   l_018_000C4                     ; 00076
l_018_00078:
        cmpi.b  #$4,d0                          ; 00078
        bne.b   l_018_00084                     ; 0007C
        bsr.w   sub_018_000F4                   ; 0007E
        bra.b   l_018_000C4                     ; 00082
l_018_00084:
        cmpi.b  #$5,d0                          ; 00084
        bne.b   l_018_00090                     ; 00088
        bsr.w   sub_018_00232                   ; 0008A
        bra.b   l_018_000C4                     ; 0008E
l_018_00090:
        cmpi.b  #$6,d0                          ; 00090
        bne.b   l_018_0009C                     ; 00094
        bsr.w   sub_018_0038C                   ; 00096
        bra.b   l_018_000C4                     ; 0009A
l_018_0009C:
        cmpi.b  #$7,d0                          ; 0009C
        bne.b   l_018_000A8                     ; 000A0
        bsr.w   sub_018_00410                   ; 000A2
        bra.b   l_018_000C4                     ; 000A6
l_018_000A8:
        cmpi.b  #$9,d0                          ; 000A8
        bne.b   l_018_000B4                     ; 000AC
        bsr.w   sub_018_00520                   ; 000AE
        bra.b   l_018_000C4                     ; 000B2
l_018_000B4:
        cmpi.b  #$7d,d0                         ; 000B4
        bne.b   l_018_000C0                     ; 000B8
        bsr.w   sub_018_00564                   ; 000BA
        bra.b   l_018_000C4                     ; 000BE
l_018_000C0:
        bsr.w   sub_018_00594                   ; 000C0
l_018_000C4:
        rts                                     ; 000C4
l_018_000C6:
        rts                                     ; 000C6
sub_018_000C8:
        tst.b   (dat_071_00168).l               ; 000C8
        bne.w   l_018_005F6                     ; 000CE
        tst.b   (dat_071_0023F).l               ; 000D2
        bge.b   l_018_000C6                     ; 000D8
        cmpi.b  #$3,(dat_071_001FA).l           ; 000DA
        beq.b   l_018_000C6                     ; 000E2
        move.b  #$ff,(dat_071_00168).l          ; 000E4
        moveq   #$0,d0                          ; 000EC
        bra.w   l_018_005D6                     ; 000EE
l_018_000F2:
        rts                                     ; 000F2
sub_018_000F4:
        tst.b   (dat_071_00168).l               ; 000F4
        bne.w   l_018_005F6                     ; 000FA
        lea.l   (dat_071_01354).l,a1            ; 000FE
        move.w  #$4,(dat_071_00384).l           ; 00104
        move.w  $6(a1),d0                       ; 0010C
        or.w    $c(a1),d0                       ; 00110
        beq.b   l_018_000F2                     ; 00114
        btst    #$6,$1(a1)                      ; 00116
        beq.b   l_018_00142                     ; 0011C
        btst    #$7,$3(a1)                      ; 0011E
        beq.b   l_018_000F2                     ; 00124
        cmpi.w  #$320,$6c(a1)                   ; 00126
        bgt.b   l_018_000F2                     ; 0012C
        btst    #$6,(dat_071_01B55).l           ; 0012E
        bne.b   l_018_000F2                     ; 00136
        btst    #$6,(dat_071_01F55).l           ; 00138
        bne.b   l_018_000F2                     ; 00140
l_018_00142:
        tst.b   (dat_071_0017E).l               ; 00142
        bne.b   l_018_00152                     ; 00148
        move.b  #$5,(dat_071_0017E).l           ; 0014A
l_018_00152:
        subq.b  #$1,(dat_071_0017E).l           ; 00152
        beq.b   l_018_001D8                     ; 00158
        cmpi.b  #$1,(dat_071_0017E).l           ; 0015A
        bgt.w   l_018_00204                     ; 00162
        btst    #$7,(dat_071_0018E).l           ; 00166
        bne.w   l_018_00204                     ; 0016E
        move.b  (dat_071_00282).l,(dat_071_0018E).l; 00172
        bset    #$7,(dat_071_0018E).l           ; 0017C
        move.b  (dat_071_00155).l,(dat_071_00204).l; 00184
        btst    #$6,$1(a1)                      ; 0018E
        beq.w   l_018_00204                     ; 00194
        move.b  #$7,(dat_071_00282).l           ; 00198
        move.b  #$1,(dat_071_00185).l           ; 001A0
        move.b  #$1,(dat_071_00184).l           ; 001A8
        clr.b   (dat_071_0017D).l               ; 001B0
        tst.b   (dat_071_00155).l               ; 001B6
        bne.b   l_018_00204                     ; 001BC
        move.w  $68(a1),(dat_071_002FA).l       ; 001BE
        ori.w   #$2,(dat_071_00296).l           ; 001C6
        move.b  #$ff,(dat_071_00203).l          ; 001CE
        bra.b   l_018_00204                     ; 001D6
l_018_001D8:
        btst    #$6,$1(a1)                      ; 001D8
        beq.b   l_018_00206                     ; 001DE
        move.w  (dat_071_00384).l,d1            ; 001E0
        jsr     (sub_005_012D0).l               ; 001E6
        cmpi.b  #$3,(dat_071_001FA).l           ; 001EC
        beq.b   l_018_00204                     ; 001F4
        move.b  #$ff,(dat_071_00168).l          ; 001F6
        moveq   #$4,d0                          ; 001FE
        bra.w   l_018_005D6                     ; 00200
l_018_00204:
        rts                                     ; 00204
l_018_00206:
        cmpi.b  #$3,(dat_071_001FA).l           ; 00206
        beq.b   l_018_00204                     ; 0020E
        btst    #$7,$20(a1)                     ; 00210
        beq.b   l_018_00222                     ; 00216
        move.b  #$fd,(dat_071_00168).l          ; 00218
        bra.b   l_018_0022A                     ; 00220
l_018_00222:
        move.b  #$fe,(dat_071_00168).l          ; 00222
l_018_0022A:
        moveq   #$0,d0                          ; 0022A
        bra.w   l_018_005D6                     ; 0022C
	dc.b	$4E,$75
sub_018_00232:
        tst.b   (dat_071_00168).l               ; 00232
        bne.w   l_018_005F6                     ; 00238
        lea.l   (dat_071_01354).l,a2            ; 0023C
        lea.l   (dat_071_01754).l,a3            ; 00242
        btst    #$6,$1(a2)                      ; 00248
        bne.b   l_018_00268                     ; 0024E
        btst    #$6,$1(a3)                      ; 00250
        beq.w   l_018_00306                     ; 00256
        btst    #$3,$1(a3)                      ; 0025A
        beq.w   l_018_002FE                     ; 00260
        exg.l   a2,a3                           ; 00264
        bra.b   l_018_00272                     ; 00266
l_018_00268:
        btst    #$3,$1(a2)                      ; 00268
        beq.w   l_018_002FE                     ; 0026E
l_018_00272:
        cmpi.w  #$70,$6(a2)                     ; 00272
        bge.w   l_018_00344                     ; 00278
        movem.l $14(a2),d0-d2                   ; 0027C
        movem.l (dat_071_00B68).l,d3-d5         ; 00282
        cmpi.b  #$3,(dat_071_00277).l           ; 0028A
        bge.b   l_018_002AE                     ; 00292
        cmpi.b  #$2,(dat_071_00277).l           ; 00294
        bge.b   l_018_002A6                     ; 0029C
        move.l  #$30000,d6                      ; 0029E
        bra.b   l_018_002B4                     ; 002A4
l_018_002A6:
        move.l  #$24000,d6                      ; 002A6
        bra.b   l_018_002B4                     ; 002AC
l_018_002AE:
        move.l  #$18000,d6                      ; 002AE
l_018_002B4:
        sub.l   d0,d3                           ; 002B4
        bge.b   l_018_002BA                     ; 002B6
        neg.l   d3                              ; 002B8
l_018_002BA:
        cmp.l   d6,d3                           ; 002BA
        bgt.b   l_018_002EE                     ; 002BC
        sub.l   d1,d4                           ; 002BE
        bge.b   l_018_002C4                     ; 002C0
        neg.l   d4                              ; 002C2
l_018_002C4:
        cmp.l   d6,d4                           ; 002C4
        bgt.b   l_018_002EE                     ; 002C6
        sub.l   d2,d5                           ; 002C8
        bge.b   l_018_002CE                     ; 002CA
        neg.l   d5                              ; 002CC
l_018_002CE:
        cmp.l   d6,d5                           ; 002CE
        bgt.b   l_018_002EE                     ; 002D0
        move.w  (dat_071_00152).l,d0            ; 002D2
        blt.b   l_018_002E2                     ; 002D8
        subq.w  #$1,(dat_071_00152).l           ; 002DA
        bra.b   l_018_002FE                     ; 002E0
l_018_002E2:
        lea.l   (a2),a1                         ; 002E2
        bsr.w   sub_018_0035E                   ; 002E4
        lea.l   (a3),a1                         ; 002E8
        bsr.w   sub_018_0035E                   ; 002EA
l_018_002EE:
        tst.w   (dat_071_00152).l               ; 002EE
        blt.b   l_018_002FE                     ; 002F4
        move.w  #$c8,(dat_071_00152).l          ; 002F6
l_018_002FE:
        tst.w   (dat_071_00152).l               ; 002FE
        bge.b   l_018_0035C                     ; 00304
l_018_00306:
        move.b  (dat_071_0027A).l,d0            ; 00306
        cmp.b   (dat_071_0027B).l,d0            ; 0030C
        bgt.b   l_018_0035C                     ; 00312
        tst.b   (dat_071_0017E).l               ; 00314
        bne.b   l_018_00324                     ; 0031A
        move.b  #$2,(dat_071_0017E).l           ; 0031C
l_018_00324:
        subq.b  #$1,(dat_071_0017E).l           ; 00324
        bne.b   l_018_0035C                     ; 0032A
        cmpi.b  #$3,(dat_071_001FA).l           ; 0032C
        beq.b   l_018_0035C                     ; 00334
        move.b  #$ff,(dat_071_00168).l          ; 00336
        moveq   #$0,d0                          ; 0033E
        bra.w   l_018_005D6                     ; 00340
l_018_00344:
        cmpi.b  #$3,(dat_071_001FA).l           ; 00344
        beq.b   l_018_0035C                     ; 0034C
        move.b  #$fe,(dat_071_00168).l          ; 0034E
        moveq   #$0,d0                          ; 00356
        bra.w   l_018_005D6                     ; 00358
l_018_0035C:
        rts                                     ; 0035C
sub_018_0035E:
        moveq   #$0,d0                          ; 0035E
        move.b  $3a(a1),d0                      ; 00360
        add.w   d0,d0                           ; 00364
        lea.l   (dat_027_00000).l,a4            ; 00366
        adda.w  (a4,d0.w),a4                    ; 0036C
        movem.w (a4)+,d2-d6                     ; 00370
        move.w  d2,$2c(a1)                      ; 00374
        move.w  d3,$2e(a1)                      ; 00378
        move.w  d4,$30(a1)                      ; 0037C
        move.w  d5,$32(a1)                      ; 00380
        move.l  d6,$34(a1)                      ; 00384
        rts                                     ; 00388
l_018_0038A:
        rts                                     ; 0038A
sub_018_0038C:
        tst.b   (dat_071_00168).l               ; 0038C
        bne.w   l_018_005F6                     ; 00392
        move.w  (dat_071_00292).l,d0            ; 00396
        beq.b   l_018_0038A                     ; 0039C
        lea.l   (dat_071_00B54).l,a1            ; 0039E
        adda.w  d0,a1                           ; 003A4
        btst    #$7,$0(a1)                      ; 003A6
        beq.b   l_018_0038A                     ; 003AC
        tst.w   $4c(a1)                         ; 003AE
        bgt.b   l_018_0038A                     ; 003B2
        movem.l (dat_071_02168).l,d0-d2         ; 003B4
        sub.l   $14(a1),d0                      ; 003BC
        bge.b   l_018_003C4                     ; 003C0
        neg.l   d0                              ; 003C2
l_018_003C4:
        sub.l   $1c(a1),d2                      ; 003C4
        bge.b   l_018_003CC                     ; 003C8
        neg.l   d2                              ; 003CA
l_018_003CC:
        cmpi.l  #$10000,d0                      ; 003CC
        bgt.b   l_018_003F6                     ; 003D2
        cmpi.l  #$10000,d2                      ; 003D4
        bgt.b   l_018_003F6                     ; 003DA
        cmpi.b  #$3,(dat_071_001FA).l           ; 003DC
        beq.b   l_018_003F4                     ; 003E4
        move.b  #$ff,(dat_071_00168).l          ; 003E6
        moveq   #$0,d0                          ; 003EE
        bra.w   l_018_005D6                     ; 003F0
l_018_003F4:
        rts                                     ; 003F4
l_018_003F6:
        cmpi.b  #$3,(dat_071_001FA).l           ; 003F6
        beq.b   l_018_003F4                     ; 003FE
        move.b  #$fe,(dat_071_00168).l          ; 00400
        moveq   #$0,d0                          ; 00408
        bra.w   l_018_005D6                     ; 0040A
l_018_0040E:
        rts                                     ; 0040E
sub_018_00410:
        tst.b   (dat_071_00168).l               ; 00410
        bne.w   l_018_005F6                     ; 00416
        lea.l   (dat_071_01354).l,a1            ; 0041A
        move.w  #$4,(dat_071_00384).l           ; 00420
        move.w  $6(a1),d0                       ; 00428
        or.w    $c(a1),d0                       ; 0042C
        beq.b   l_018_0040E                     ; 00430
        btst    #$6,$1(a1)                      ; 00432
        beq.b   l_018_00442                     ; 00438
        btst    #$7,$1(a1)                      ; 0043A
        bne.b   l_018_0040E                     ; 00440
l_018_00442:
        tst.b   (dat_071_0017E).l               ; 00442
        bne.b   l_018_00452                     ; 00448
        move.b  #$2,(dat_071_0017E).l           ; 0044A
l_018_00452:
        subq.b  #$1,(dat_071_0017E).l           ; 00452
        beq.b   l_018_004D8                     ; 00458
        cmpi.b  #$1,(dat_071_0017E).l           ; 0045A
        bgt.w   l_018_0051C                     ; 00462
        btst    #$7,(dat_071_0018E).l           ; 00466
        bne.w   l_018_0051C                     ; 0046E
        move.b  (dat_071_00282).l,(dat_071_0018E).l; 00472
        bset    #$7,(dat_071_0018E).l           ; 0047C
        move.b  (dat_071_00155).l,(dat_071_00204).l; 00484
        btst    #$6,$1(a1)                      ; 0048E
        beq.w   l_018_0051C                     ; 00494
        move.b  #$7,(dat_071_00282).l           ; 00498
        move.b  #$1,(dat_071_00185).l           ; 004A0
        move.b  #$1,(dat_071_00184).l           ; 004A8
        clr.b   (dat_071_0017D).l               ; 004B0
        tst.b   (dat_071_00155).l               ; 004B6
        bne.b   l_018_0051C                     ; 004BC
        move.w  $68(a1),(dat_071_002FA).l       ; 004BE
        ori.w   #$2,(dat_071_00296).l           ; 004C6
        move.b  #$3,(dat_071_00203).l           ; 004CE
        bra.b   l_018_0051C                     ; 004D6
l_018_004D8:
        btst    #$1,$20(a1)                     ; 004D8
        bne.b   l_018_00504                     ; 004DE
        move.w  (dat_071_00384).l,d1            ; 004E0
        jsr     (sub_005_012D0).l               ; 004E6
        cmpi.b  #$3,(dat_071_001FA).l           ; 004EC
        beq.b   l_018_0051C                     ; 004F4
        move.b  #$fe,(dat_071_00168).l          ; 004F6
        moveq   #$7,d0                          ; 004FE
        bra.w   l_018_005D6                     ; 00500
l_018_00504:
        cmpi.b  #$3,(dat_071_001FA).l           ; 00504
        beq.b   l_018_0051C                     ; 0050C
        move.b  #$ff,(dat_071_00168).l          ; 0050E
        moveq   #$0,d0                          ; 00516
        bra.w   l_018_005D6                     ; 00518
l_018_0051C:
        rts                                     ; 0051C
l_018_0051E:
        rts                                     ; 0051E
sub_018_00520:
        tst.b   (dat_071_00168).l               ; 00520
        bne.b   l_018_0051E                     ; 00526
        lea.l   (dat_071_00B54).l,a1            ; 00528
        btst    #$6,$1(a1)                      ; 0052E
        beq.b   l_018_0051E                     ; 00534
        move.w  $2(a1),d0                       ; 00536
        andi.w  #$c080,d0                       ; 0053A
        cmpi.w  #$c080,d0                       ; 0053E
        bne.b   l_018_0051E                     ; 00542
        tst.w   $6e(a1)                         ; 00544
        bne.b   l_018_0051E                     ; 00548
        cmpi.b  #$3,(dat_071_001FA).l           ; 0054A
        beq.b   l_018_0051E                     ; 00552
        move.b  #$ff,(dat_071_00168).l          ; 00554
        moveq   #$0,d0                          ; 0055C
        bra.w   l_018_005D6                     ; 0055E
l_018_00562:
        rts                                     ; 00562
sub_018_00564:
        tst.b   (dat_071_00168).l               ; 00564
        bne.b   l_018_00562                     ; 0056A
        lea.l   (dat_071_01354).l,a1            ; 0056C
        btst    #$6,$1(a1)                      ; 00572
        bne.b   l_018_00562                     ; 00578
        cmpi.b  #$3,(dat_071_001FA).l           ; 0057A
        beq.b   l_018_00562                     ; 00582
        move.b  #$fe,(dat_071_00168).l          ; 00584
        moveq   #$0,d0                          ; 0058C
        bra.w   l_018_005D6                     ; 0058E
l_018_00592:
        rts                                     ; 00592
sub_018_00594:
        tst.b   (dat_071_00168).l               ; 00594
        bne.w   l_018_005F6                     ; 0059A
        move.b  (dat_071_0027A).l,d0            ; 0059E
        cmp.b   (dat_071_0027B).l,d0            ; 005A4
        bgt.b   l_018_00592                     ; 005AA
        tst.b   (dat_071_0017E).l               ; 005AC
        bne.b   l_018_005BC                     ; 005B2
        move.b  #$2,(dat_071_0017E).l           ; 005B4
l_018_005BC:
        subq.b  #$1,(dat_071_0017E).l           ; 005BC
        bne.b   l_018_005F4                     ; 005C2
        cmpi.b  #$3,(dat_071_001FA).l           ; 005C4
        beq.b   l_018_005F4                     ; 005CC
        move.b  #$ff,(dat_071_00168).l          ; 005CE
l_018_005D6:
        move.w  d0,(dat_071_00290).l            ; 005D6
        move.b  #$3,(dat_071_001FA).l           ; 005DC
        move.b  #$4,(dat_071_001FC).l           ; 005E4
        move.b  #$1,(dat_071_0027D).l           ; 005EC
l_018_005F4:
        rts                                     ; 005F4
l_018_005F6:
        move.b  (dat_071_00168).l,d0            ; 005F6
        cmpi.b  #$ff,d0                         ; 005FC
        beq.b   l_018_00606                     ; 00600
        subq.b  #$1,d0                          ; 00602
        bne.b   l_018_00618                     ; 00604
l_018_00606:
        bsr.w   sub_018_0061A                   ; 00606
        bne.b   l_018_00618                     ; 0060A
        move.b  #$fc,(dat_071_00168).l          ; 0060C
        moveq   #$0,d0                          ; 00614
        bra.b   l_018_005D6                     ; 00616
l_018_00618:
        rts                                     ; 00618
sub_018_0061A:
        lea.l   (dat_071_00B54).l,a0            ; 0061A
        btst    #$0,$21(a0)                     ; 00620
        beq.b   l_018_00658                     ; 00626
        btst    #$7,$3(a0)                      ; 00628
        beq.b   l_018_00658                     ; 0062E
        cmpi.b  #$3,(dat_071_00218).l           ; 00630
        beq.b   l_018_00644                     ; 00638
        btst    #$2,$4(a0)                      ; 0063A
        beq.b   l_018_00658                     ; 00640
        bra.b   l_018_0064E                     ; 00642
l_018_00644:
        move.b  $4(a0),d0                       ; 00644
        andi.b  #$c0,d0                         ; 00648
        beq.b   l_018_00658                     ; 0064C
l_018_0064E:
        tst.w   $6e(a0)                         ; 0064E
        bne.b   l_018_00658                     ; 00652
        moveq   #$0,d0                          ; 00654
        rts                                     ; 00656
l_018_00658:
        moveq   #$1,d0                          ; 00658
        rts                                     ; 0065A
h018_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    121,71                          ; 121 longs pointing into hunk 71
	dc.l	$30E,$5A6,$308,$5A0,$5F0,$5D8,$2D4,$2DC
	dc.l	$2F0,$2FA,$300,$28E,$298,$1D2,$4D2,$1AC
	dc.l	$4AC,$1A4,$4A4,$1B2,$4B2,$16A,$178,$180
	dc.l	$46A,$478,$480,$174,$19C,$474,$49C,$144
	dc.l	$14E,$154,$15E,$316,$320,$326,$444,$44E
	dc.l	$454,$45E,$5AE,$5B8,$5BE,$18A,$48A,$186
	dc.l	$1B8,$486,$4B8,$10,$108,$1E2,$424,$4E2
	dc.l	$3A0,$398,$3B8,$13C,$132,$244,$100,$23E
	dc.l	$41C,$56E,$286,$52A,$61C,$2E,$4,$24
	dc.l	$1C2,$4C2,$634,$D4,$5E8,$DE,$1F0,$20A
	dc.l	$330,$348,$3E0,$3FA,$4F0,$508,$54E,$57E
	dc.l	$5C8,$5E0,$CA,$E8,$F6,$1FA,$21C,$226
	dc.l	$234,$33A,$352,$38E,$3EA,$404,$412,$4FA
	dc.l	$512,$522,$558,$566,$588,$596,$5D2,$5F8
	dc.l	$610,$62,$5A,$52,$1CA,$4CA,$44,$3E
	dc.l	$38
        dc.l    1,27                            ; 1 longs pointing into hunk 27
	dc.l	$368
        dc.l    1,20                            ; 1 longs pointing into hunk 20
	dc.l	$1C
        dc.l    1,17                            ; 1 longs pointing into hunk 17
	dc.l	$4A
        dc.l    2,5                             ; 2 longs pointing into hunk 5
	dc.l	$1E8,$4E8
	dc.l	0
	dc.l	HUNK_END
	endc
