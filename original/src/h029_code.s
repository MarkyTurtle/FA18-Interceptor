; F/A-18 Interceptor - hunk 29 (code)
; Included by ../f18_main.s.

;===============================================================================
; Hunk 29: CODE, $730 bytes
;===============================================================================
	CODE_HUNK	h029
l_029_00000:
        rts                                     ; 00000
sub_029_00002:
        cmpi.b  #$1,(dat_071_00276).l           ; 00002
        bne.b   l_029_00000                     ; 0000A
        cmpi.b  #$5,(dat_071_0027E).l           ; 0000C
        blt.b   l_029_00000                     ; 00014
        cmpi.l  #$fe800000,(dat_071_00436).l    ; 00016
        bge.b   l_029_00000                     ; 00020
        addq.b  #$1,(dat_071_00253).l           ; 00022
        tst.b   (dat_071_00155).l               ; 00028
        beq.b   l_029_00038                     ; 0002E
        lea.l   (dat_071_0060E).l,a4            ; 00030
        bra.b   l_029_00048                     ; 00036
l_029_00038:
        lea.l   (dat_071_00B54).l,a4            ; 00038
        move.w  (dat_071_002AE).l,d2            ; 0003E
        lea.l   $14(a4,d2.w),a4                 ; 00044
l_029_00048:
        lea.l   (dat_067_00032).l,a0            ; 00048
        move.w  #$0,(dat_071_0037A).l           ; 0004E
l_029_00056:
        cmpi.b  #$5,(dat_071_0027E).l           ; 00056
        ble.b   l_029_000A0                     ; 0005E
        tst.b   (dat_071_0017E).l               ; 00060
        bne.b   l_029_000A0                     ; 00066
        move.w  (dat_071_0037A).l,d0            ; 00068
        cmp.b   (dat_071_00218).l,d0            ; 0006E
        beq.b   l_029_00080                     ; 00074
        cmpi.b  #$6,(dat_071_0027E).l           ; 00076
        beq.b   l_029_00094                     ; 0007E
l_029_00080:
        move.b  (dat_071_00227).l,d0            ; 00080
        beq.b   l_029_000A0                     ; 00086
        move.b  (dat_071_00253).l,d0            ; 00088
        andi.b  #$1,d0                          ; 0008E
        bne.b   l_029_000A0                     ; 00092
l_029_00094:
        adda.w  #$10,a0                         ; 00094
        tst.w   (a0)                            ; 00098
        bge.w   l_029_00198                     ; 0009A
l_029_0009E:
        rts                                     ; 0009E
l_029_000A0:
        movem.w (a0)+,d0-d4                     ; 000A0
        tst.w   d0                              ; 000A4
        bge.b   l_029_000D6                     ; 000A6
        cmpi.w  #$ffff,d0                       ; 000A8
        beq.b   l_029_0009E                     ; 000AC
        addq.w  #$6,a0                          ; 000AE
        andi.w  #$7fff,d0                       ; 000B0
        asl.w   #$8,d0                          ; 000B4
        add.w   d0,d0                           ; 000B6
        lea.l   (dat_071_00B54).l,a1            ; 000B8
        adda.w  d0,a1                           ; 000BE
        btst    #$6,$1(a1)                      ; 000C0
        beq.w   l_029_00198                     ; 000C6
        move.l  $14(a1),d0                      ; 000CA
        move.l  $1c(a1),d1                      ; 000CE
        bra.w   l_029_00110                     ; 000D2
l_029_000D6:
        swap    d0                              ; 000D6
        asl.l   #$8,d0                          ; 000D8
        swap    d1                              ; 000DA
        asl.l   #$8,d1                          ; 000DC
        asl.w   #$2,d2                          ; 000DE
        lea.l   (dat_008_0151A).l,a1            ; 000E0
        movem.w (a1,d2.w),d5-d6                 ; 000E6
        asl.l   #$8,d5                          ; 000EC
        asl.l   #$8,d6                          ; 000EE
        asl.l   #$2,d5                          ; 000F0
        asl.l   #$2,d6                          ; 000F2
        add.l   d5,d0                           ; 000F4
        add.l   d6,d1                           ; 000F6
        movem.w (a0)+,d5-d7                     ; 000F8
        asl.l   #$4,d5                          ; 000FC
        asl.l   #$4,d6                          ; 000FE
        asl.l   #$8,d3                          ; 00100
        asl.l   #$8,d4                          ; 00102
        asl.l   #$2,d3                          ; 00104
        asl.l   #$2,d4                          ; 00106
        add.l   d5,d3                           ; 00108
        add.l   d6,d4                           ; 0010A
        add.l   d3,d0                           ; 0010C
        add.l   d4,d1                           ; 0010E
l_029_00110:
        movem.l (a4),d2-d4                      ; 00110
        sub.l   d0,d2                           ; 00114
        sub.l   d1,d4                           ; 00116
        neg.l   d2                              ; 00118
        neg.l   d3                              ; 0011A
        neg.l   d4                              ; 0011C
        moveq   #$e,d5                          ; 0011E
        asr.l   d5,d2                           ; 00120
        asr.l   d5,d3                           ; 00122
        asr.l   d5,d4                           ; 00124
        lea.l   (dat_071_005A8).l,a1            ; 00126
        move.w  d2,d5                           ; 0012C
        move.w  d3,d6                           ; 0012E
        move.w  d4,d0                           ; 00130
        muls.w  (a1)+,d5                        ; 00132
        muls.w  (a1)+,d6                        ; 00134
        muls.w  (a1)+,d0                        ; 00136
        add.l   d6,d0                           ; 00138
        add.l   d5,d0                           ; 0013A
        asr.l   #$8,d0                          ; 0013C
        move.w  d2,d5                           ; 0013E
        move.w  d3,d6                           ; 00140
        move.w  d4,d1                           ; 00142
        muls.w  (a1)+,d5                        ; 00144
        muls.w  (a1)+,d6                        ; 00146
        muls.w  (a1)+,d1                        ; 00148
        add.l   d6,d1                           ; 0014A
        add.l   d5,d1                           ; 0014C
        asr.l   #$8,d1                          ; 0014E
        muls.w  (a1)+,d2                        ; 00150
        muls.w  (a1)+,d3                        ; 00152
        muls.w  (a1)+,d4                        ; 00154
        add.l   d3,d2                           ; 00156
        add.l   d4,d2                           ; 00158
        asr.l   #$8,d2                          ; 0015A
        movem.l a0/a4,-(a7)                     ; 0015C
        move.w  #$2,(dat_071_00324).l           ; 00160
        jsr     (sub_035_00038).l               ; 00168
        move.w  (dat_071_0037A).l,d2            ; 0016E
        addq.w  #$1,d2                          ; 00174
        move.w  (dat_071_00328).l,d0            ; 00176
        blt.b   l_029_00194                     ; 0017C
        move.w  (dat_071_0032A).l,d1            ; 0017E
        moveq   #$0,d3                          ; 00184
        move.w  #$9,(dat_071_00324).l           ; 00186
        jsr     (sub_039_01144).l               ; 0018E
l_029_00194:
        movem.l (a7)+,a0/a4                     ; 00194
l_029_00198:
        addq.w  #$1,(dat_071_0037A).l           ; 00198
        bra.w   l_029_00056                     ; 0019E
l_029_001A2:
        rts                                     ; 001A2
sub_029_001A4:
        tst.b   (dat_071_0017D).l               ; 001A4
        ble.b   l_029_001A2                     ; 001AA
        tst.b   (dat_071_00155).l               ; 001AC
        beq.b   l_029_001A2                     ; 001B2
        link.w  a6,#$fff6                       ; 001B4
        move.l  #$fffff,(dat_071_000B6).l       ; 001B8
        move.w  #$8,(dat_071_00324).l           ; 001C2
        movem.l (dat_071_0060E).l,d0-d2         ; 001CA
        exg.l   d1,d2                           ; 001D2
        swap    d2                              ; 001D4
        neg.w   d2                              ; 001D6
        move.w  d2,-$2(a6)                      ; 001D8
        swap    d0                              ; 001DC
        swap    d1                              ; 001DE
        neg.w   d0                              ; 001E0
        neg.w   d1                              ; 001E2
        swap    d0                              ; 001E4
        move.w  d1,d0                           ; 001E6
        move.l  d0,-(a7)                        ; 001E8
        move.w  #$f660,d0                       ; 001EA
        move.w  #$f680,-$4(a6)                  ; 001EE
        move.w  #$73,-$6(a6)                    ; 001F4
        move.w  #$18,-$8(a6)                    ; 001FA
l_029_00200:
        lea.l   (dat_072_04202).l,a5            ; 00200
        move.w  -$4(a6),d2                      ; 00206
        move.w  -$2(a6),d3                      ; 0020A
        move.w  #$23e0,d4                       ; 0020E
        jsr     (sub_028_010FA).l               ; 00212
        move.w  -$4(a6),d2                      ; 00218
        move.w  -$2(a6),d3                      ; 0021C
        move.w  #$ef60,d4                       ; 00220
        jsr     (sub_028_010FA).l               ; 00224
        movem.l d0/a0,-(a7)                     ; 0022A
        move.w  #$8,(dat_071_00324).l           ; 0022E
        jsr     (sub_035_001DA).l               ; 00236
        move.w  d0,d1                           ; 0023C
        movem.l (a7)+,d0/a0                     ; 0023E
        btst    #$0,-$7(a6)                     ; 00242
        beq.b   l_029_00290                     ; 00248
        move.w  -$6(a6),d2                      ; 0024A
        tst.w   d1                              ; 0024E
        beq.b   l_029_00290                     ; 00250
        movem.l d0/a0,-(a7)                     ; 00252
        moveq   #$2,d3                          ; 00256
        move.l  (dat_072_03004).l,d0            ; 00258
        move.l  d0,d1                           ; 0025E
        swap    d0                              ; 00260
        subi.w  #$c,d0                          ; 00262
        subq.w  #$5,d1                          ; 00266
        cmpi.w  #$8,d1                          ; 00268
        blt.b   l_029_0028C                     ; 0026C
        cmpi.w  #$8,d0                          ; 0026E
        blt.b   l_029_0028C                     ; 00272
        cmpi.w  #$12c,d0                        ; 00274
        blt.b   l_029_0027E                     ; 00278
        move.w  #$12c,d0                        ; 0027A
l_029_0027E:
        move.w  #$2,(dat_071_00324).l           ; 0027E
        jsr     (sub_039_01144).l               ; 00286
l_029_0028C:
        movem.l (a7)+,d0/a0                     ; 0028C
l_029_00290:
        addi.w  #$1c0,-$4(a6)                   ; 00290
        btst    #$0,-$7(a6)                     ; 00296
        beq.b   l_029_002A2                     ; 0029C
        addq.w  #$1,-$6(a6)                     ; 0029E
l_029_002A2:
        subq.w  #$1,-$8(a6)                     ; 002A2
        bgt.w   l_029_00200                     ; 002A6
        move.w  #$feb0,-$4(a6)                  ; 002AA
        move.w  #$22,-$6(a6)                    ; 002B0
        move.w  #$10,-$8(a6)                    ; 002B6
        move.l  (a7),d0                         ; 002BC
        swap    d0                              ; 002BE
        move.w  #$c0,d0                         ; 002C0
        swap    d0                              ; 002C4
l_029_002C6:
        lea.l   (dat_072_04202).l,a5            ; 002C6
        move.w  #$1440,d2                       ; 002CC
        move.w  -$2(a6),d3                      ; 002D0
        move.w  -$4(a6),d4                      ; 002D4
        jsr     (sub_028_010FA).l               ; 002D8
        move.w  #$ea40,d2                       ; 002DE
        move.w  -$2(a6),d3                      ; 002E2
        move.w  -$4(a6),d4                      ; 002E6
        jsr     (sub_028_010FA).l               ; 002EA
        movem.l d0/a0,-(a7)                     ; 002F0
        move.w  #$8,(dat_071_00324).l           ; 002F4
        jsr     (sub_035_001DA).l               ; 002FC
        move.w  d0,d1                           ; 00302
        movem.l (a7)+,d0/a0                     ; 00304
        btst    #$0,-$7(a6)                     ; 00308
        beq.b   l_029_00354                     ; 0030E
        move.w  -$6(a6),d2                      ; 00310
        tst.w   d1                              ; 00314
        beq.b   l_029_00354                     ; 00316
        movem.l d0/a0,-(a7)                     ; 00318
        moveq   #$1,d3                          ; 0031C
        move.l  (dat_072_03000).l,d0            ; 0031E
        move.l  d0,d1                           ; 00324
        swap    d0                              ; 00326
        subq.w  #$1,d1                          ; 00328
        cmpi.w  #$4,d1                          ; 0032A
        bge.b   l_029_00332                     ; 0032E
        moveq   #$4,d1                          ; 00330
l_029_00332:
        cmpi.w  #$af,d1                         ; 00332
        blt.b   l_029_0033C                     ; 00336
        move.w  #$af,d1                         ; 00338
l_029_0033C:
        tst.w   d0                              ; 0033C
        bge.b   l_029_00342                     ; 0033E
        moveq   #$0,d0                          ; 00340
l_029_00342:
        move.w  #$2,(dat_071_00324).l           ; 00342
        jsr     (sub_039_01144).l               ; 0034A
        movem.l (a7)+,d0/a0                     ; 00350
l_029_00354:
        addi.w  #$230,-$4(a6)                   ; 00354
        btst    #$0,-$7(a6)                     ; 0035A
        beq.b   l_029_00366                     ; 00360
        addq.w  #$1,-$6(a6)                     ; 00362
l_029_00366:
        subq.w  #$1,-$8(a6)                     ; 00366
        bgt.w   l_029_002C6                     ; 0036A
        move.l  (a7)+,d0                        ; 0036E
        moveq   #$0,d6                          ; 00370
l_029_00372:
        lea.l   (dat_071_00B54).l,a0            ; 00372
        adda.w  d6,a0                           ; 00378
        move.w  $0(a0),d7                       ; 0037A
        move.w  d7,d2                           ; 0037E
        andi.w  #$40,d7                         ; 00380
        beq.w   l_029_00414                     ; 00384
        andi.w  #$8,d2                          ; 00388
        beq.b   l_029_00398                     ; 0038C
        btst    #$7,$3(a0)                      ; 0038E
        bne.w   l_029_00414                     ; 00394
l_029_00398:
        movem.l $14(a0),d2-d4                   ; 00398
        swap    d2                              ; 0039E
        swap    d4                              ; 003A0
        lea.l   (dat_072_04202).l,a5            ; 003A2
        move.l  d0,-(a7)                        ; 003A8
        move.w  d6,-(a7)                        ; 003AA
        move.w  -$2(a6),d3                      ; 003AC
        jsr     (sub_028_010FA).l               ; 003B0
        tst.w   (a7)                            ; 003B6
        beq.b   l_029_003FC                     ; 003B8
        move.w  #$3,(dat_071_00324).l           ; 003BA
        move.b  $62(a0),d7                      ; 003C2
        andi.b  #$f0,d7                         ; 003C6
        cmpi.b  #$20,d7                         ; 003CA
        bne.b   l_029_003D6                     ; 003CE
        bsr.w   sub_029_00568                   ; 003D0
        bra.b   l_029_00410                     ; 003D4
l_029_003D6:
        cmpi.b  #$3,(dat_071_00276).l           ; 003D6
        bne.b   l_029_003E8                     ; 003DE
        btst    #$6,$20(a0)                     ; 003E0
        beq.b   l_029_00404                     ; 003E6
l_029_003E8:
        move.w  $0(a0),d7                       ; 003E8
        andi.w  #$8,d7                          ; 003EC
        bne.b   l_029_003FC                     ; 003F0
        move.w  #$1,(dat_071_00324).l           ; 003F2
        bra.b   l_029_00404                     ; 003FA
l_029_003FC:
        move.w  #$d,(dat_071_00324).l           ; 003FC
l_029_00404:
        move.w  (a7)+,d6                        ; 00404
        move.l  (a7)+,d0                        ; 00406
        move.l  d0,-(a7)                        ; 00408
        move.w  d6,-(a7)                        ; 0040A
        bsr.w   sub_029_00592                   ; 0040C
l_029_00410:
        move.w  (a7)+,d6                        ; 00410
        move.l  (a7)+,d0                        ; 00412
l_029_00414:
        addi.w  #$200,d6                        ; 00414
        cmpi.w  #$1e00,d6                       ; 00418
        ble.w   l_029_00372                     ; 0041C
        unlk    a6                              ; 00420
        rts                                     ; 00422
dat_029_00424:
	dc.b	$00,$22,$00,$32,$00,$45,$00,$58,$00,$68,$00,$78,$00,$88,$00,$9B
	dc.b	$00,$AE,$00,$BE,$00,$D1,$00,$E4,$00,$F4,$01,$04,$01,$14,$01,$27
	dc.b	$00,$22,$FD,$00,$01,$FE,$00,$01,$FF,$FF,$03,$00,$FF,$03,$01,$FE
	dc.b	$05,$80,$FD,$02,$01,$FE,$01,$02,$FF,$FF,$03,$00,$FE,$04,$01,$00
	dc.b	$03,$02,$02,$01,$80,$FD,$03,$01,$FE,$01,$02,$FF,$FE,$05,$00,$FF
	dc.b	$03,$01,$00,$02,$02,$01,$01,$80,$FE,$03,$02,$FF,$FF,$05,$00,$FF
	dc.b	$04,$01,$00,$02,$02,$00,$01,$80,$FE,$FF,$01,$FF,$FF,$03,$00,$FF
	dc.b	$06,$01,$FF,$03,$02,$FF,$01,$80,$FE,$00,$01,$FF,$00,$02,$00,$FF
	dc.b	$04,$01,$FF,$05,$02,$03,$02,$80,$FE,$01,$01,$FF,$00,$02,$00,$FF
	dc.b	$03,$01,$FE,$05,$02,$01,$02,$03,$03,$01,$80,$FE,$02,$01,$FF,$00
	dc.b	$03,$00,$FE,$04,$01,$FF,$03,$02,$01,$02,$03,$02,$01,$80,$FF,$FE
	dc.b	$05,$00,$FF,$03,$01,$FF,$03,$02,$00,$01,$03,$00,$01,$80,$FE,$FE
	dc.b	$01,$FF,$FE,$03,$00,$FF,$04,$01,$FF,$03,$02,$FE,$02,$03,$FE,$01
	dc.b	$80,$FE,$FF,$01,$FF,$FF,$02,$00,$FF,$03,$01,$FE,$05,$02,$FE,$02
	dc.b	$03,$FD,$01,$80,$FE,$00,$01,$FF,$FF,$02,$00,$FE,$04,$01,$FD,$05
	dc.b	$02,$FC,$02,$80,$FE,$01,$01,$FF,$FF,$03,$00,$FC,$06,$01,$FF,$03
	dc.b	$02,$01,$01,$80,$FE,$FC,$02,$FF,$FD,$05,$00,$FE,$04,$01,$FF,$02
	dc.b	$02,$00,$01,$80,$FD,$FD,$01,$FE,$FE,$02,$FF,$FE,$05,$00,$FF,$03
	dc.b	$01,$FF,$02,$02,$FF,$01,$80,$FD,$FE,$01,$FE,$FE,$02,$FF,$FF,$03
	dc.b	$00,$FF,$04,$01,$FE,$03,$02,$FE,$01,$80
dat_029_0055E:
	dc.b	$FF,$01,$01,$00,$FB,$0B,$01,$FC,$09,$80
sub_029_00568:
        tst.b   (dat_071_00227).l               ; 00568
        blt.b   l_029_00590                     ; 0056E
        movem.w (dat_072_04202).l,d0-d2         ; 00570
        jsr     (sub_035_00020).l               ; 00578
        blt.b   l_029_00590                     ; 0057E
        move.w  #$3,(dat_071_00324).l           ; 00580
        lea.l   dat_029_0055E(pc),a1            ; 00588
        bra.w   l_029_006E8                     ; 0058C
l_029_00590:
        rts                                     ; 00590
sub_029_00592:
        movem.w (dat_072_04202).l,d0-d2         ; 00592
        move.l  $14(a0),d2                      ; 0059A
        move.l  $1c(a0),d4                      ; 0059E
        swap    d2                              ; 005A2
        move.w  -$2(a6),d3                      ; 005A4
        swap    d4                              ; 005A8
        jsr     (sub_028_010FA).l               ; 005AA
        movem.w (dat_072_04202).l,d0-d2         ; 005B0
        jsr     (sub_035_00020).l               ; 005B8
        bge.b   l_029_005C8                     ; 005BE
        clr.b   (dat_071_0027F).l               ; 005C0
        bra.b   l_029_00590                     ; 005C6
l_029_005C8:
        move.l  a0,d7                           ; 005C8
        subi.l  #dat_071_00B54,d7               ; 005CA
        cmp.w   (dat_071_0038A).l,d7            ; 005D0
        bne.b   l_029_00600                     ; 005D6
        tst.b   (dat_071_0027F).l               ; 005D8
        blt.b   l_029_005F8                     ; 005DE
        cmpi.w  #$14,d0                         ; 005E0
        blt.b   l_029_00600                     ; 005E4
        cmpi.w  #$12c,d0                        ; 005E6
        bgt.b   l_029_00600                     ; 005EA
        cmpi.w  #$e,d1                          ; 005EC
        blt.b   l_029_00600                     ; 005F0
        cmpi.w  #$ba,d1                         ; 005F2
        bgt.b   l_029_00600                     ; 005F6
l_029_005F8:
        move.b  #$1,(dat_071_0027F).l           ; 005F8
l_029_00600:
        tst.b   (dat_071_00185).l               ; 00600
        bne.w   l_029_0068E                     ; 00606
        move.w  (dat_071_002AA).l,d7            ; 0060A
        move.b  (dat_071_00227).l,d6            ; 00610
        blt.w   l_029_00590                     ; 00616
        beq.b   l_029_00624                     ; 0061A
        ext.w   d6                              ; 0061C
        and.w   d6,d7                           ; 0061E
        beq.w   l_029_0068E                     ; 00620
l_029_00624:
        tst.b   $71(a0)                         ; 00624
        blt.w   l_029_0068E                     ; 00628
        moveq   #$0,d7                          ; 0062C
        move.b  $70(a0),d7                      ; 0062E
        move.b  d7,d6                           ; 00632
        lsr.b   #$4,d6                          ; 00634
        andi.b  #$f,d7                          ; 00636
        move.b  d0,d2                           ; 0063A
        andi.b  #$f,d2                          ; 0063C
        sub.b   d6,d2                           ; 00640
        bge.b   l_029_00650                     ; 00642
        cmpi.b  #$f8,d2                         ; 00644
        bgt.b   l_029_0065A                     ; 00648
        addi.b  #$10,d2                         ; 0064A
        bra.b   l_029_0065A                     ; 0064E
l_029_00650:
        cmpi.b  #$8,d2                          ; 00650
        blt.b   l_029_0065A                     ; 00654
        subi.b  #$10,d2                         ; 00656
l_029_0065A:
        neg.b   d2                              ; 0065A
        ext.w   d2                              ; 0065C
        add.w   d2,d0                           ; 0065E
        move.b  d1,d3                           ; 00660
        andi.b  #$f,d3                          ; 00662
        sub.b   d7,d3                           ; 00666
        bge.b   l_029_00676                     ; 00668
        cmpi.b  #$f8,d3                         ; 0066A
        bgt.b   l_029_00680                     ; 0066E
        addi.b  #$10,d3                         ; 00670
        bra.b   l_029_00680                     ; 00674
l_029_00676:
        cmpi.b  #$8,d3                          ; 00676
        blt.b   l_029_00680                     ; 0067A
        subi.b  #$10,d3                         ; 0067C
l_029_00680:
        neg.b   d3                              ; 00680
        ext.w   d3                              ; 00682
        add.w   d3,d1                           ; 00684
        move.b  $71(a0),d4                      ; 00686
        bra.w   l_029_006DA                     ; 0068A
l_029_0068E:
        move.w  $68(a0),d7                      ; 0068E
        move.w  #$384,d6                        ; 00692
        moveq   #$0,d4                          ; 00696
        sub.w   d6,d7                           ; 00698
        blt.b   l_029_006B0                     ; 0069A
        move.w  #$708,d6                        ; 0069C
l_029_006A0:
        addq.b  #$1,d4                          ; 006A0
        cmpi.b  #$f,d4                          ; 006A2
        bgt.b   l_029_006AE                     ; 006A6
        sub.w   d6,d7                           ; 006A8
        bge.b   l_029_006A0                     ; 006AA
        bra.b   l_029_006B0                     ; 006AC
l_029_006AE:
        moveq   #$0,d4                          ; 006AE
l_029_006B0:
        move.b  d4,$71(a0)                      ; 006B0
        move.w  d0,d6                           ; 006B4
        move.w  d1,d7                           ; 006B6
        andi.b  #$f,d6                          ; 006B8
        andi.b  #$f,d7                          ; 006BC
        asl.b   #$4,d6                          ; 006C0
        or.b    d6,d7                           ; 006C2
        move.b  d7,$70(a0)                      ; 006C4
        tst.b   (dat_071_00185).l               ; 006C8
        beq.b   l_029_0072E                     ; 006CE
        btst    #$0,(dat_071_002AB).l           ; 006D0
        beq.b   l_029_0072E                     ; 006D8
l_029_006DA:
        ext.w   d4                              ; 006DA
        add.w   d4,d4                           ; 006DC
        lea.l   dat_029_00424(pc),a1            ; 006DE
        move.w  (a1,d4.w),d5                    ; 006E2
        adda.w  d5,a1                           ; 006E6
l_029_006E8:
        move.b  (a1)+,d5                        ; 006E8
        cmpi.b  #$80,d5                         ; 006EA
        beq.b   l_029_0072E                     ; 006EE
        move.b  (a1)+,d6                        ; 006F0
        move.b  (a1)+,d7                        ; 006F2
        subq.b  #$1,d7                          ; 006F4
        ext.w   d5                              ; 006F6
        ext.w   d6                              ; 006F8
        ext.w   d7                              ; 006FA
        move.w  d0,-(a7)                        ; 006FC
        move.w  d1,-(a7)                        ; 006FE
        move.w  d0,d2                           ; 00700
        move.w  d1,d3                           ; 00702
        add.w   d5,d1                           ; 00704
        blt.b   l_029_00728                     ; 00706
        cmpi.w  #$b3,d1                         ; 00708
        bgt.b   l_029_00728                     ; 0070C
        add.w   d5,d3                           ; 0070E
        add.w   d6,d0                           ; 00710
        blt.b   l_029_00728                     ; 00712
        add.w   d6,d2                           ; 00714
        add.w   d7,d2                           ; 00716
        cmpi.w  #$13f,d2                        ; 00718
        bgt.b   l_029_00728                     ; 0071C
        move.l  a1,-(a7)                        ; 0071E
        jsr     (sub_036_005EE).l               ; 00720
        movea.l (a7)+,a1                        ; 00726
l_029_00728:
        move.w  (a7)+,d1                        ; 00728
        move.w  (a7)+,d0                        ; 0072A
        bra.b   l_029_006E8                     ; 0072C
l_029_0072E:
        rts                                     ; 0072E
h029_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    50,71                           ; 50 longs pointing into hunk 71
	dc.l	$5D2,$5C2,$5DA,$5FC,$62,$24,$8A,$2A
	dc.l	$1AE,$1BE,$60C,$6D4,$178,$180,$164,$18A
	dc.l	$1C6,$232,$282,$2F8,$346,$3BE,$3F6,$400
	dc.l	$584,$128,$1C,$32,$1CE,$40,$3A,$BA
	dc.l	$374,$5CC,$6,$3DA,$602,$6CA,$82,$56A
	dc.l	$612,$1A6,$70,$10,$5A,$7A,$52,$6A
	dc.l	$170,$19A
        dc.l    1,8                             ; 1 longs pointing into hunk 8
	dc.l	$E2
        dc.l    1,67                            ; 1 longs pointing into hunk 67
	dc.l	$4A
        dc.l    8,72                            ; 8 longs pointing into hunk 72
	dc.l	$25A,$320,$202,$2C8,$3A4,$574,$596,$5B4
        dc.l    6,28                            ; 6 longs pointing into hunk 28
	dc.l	$214,$226,$2DA,$2EC,$3B2,$5AC
        dc.l    3,39                            ; 3 longs pointing into hunk 39
	dc.l	$190,$288,$34C
        dc.l    1,36                            ; 1 longs pointing into hunk 36
	dc.l	$722
        dc.l    5,35                            ; 5 longs pointing into hunk 35
	dc.l	$238,$2FE,$57A,$5BA,$16A
	dc.l	0
	dc.l	HUNK_END
	endc
