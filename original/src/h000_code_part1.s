; F/A-18 Interceptor - hunk 0 (code), part 1 of 3
; Included by ../f18_main.s.

;===============================================================================
; Hunk 0: CODE, $A34C bytes
; Lattice C startup (c.o) first, then the game's first module.
;===============================================================================
	CODE_HUNK	h000
sub_000_00000:
        move.l  d0,(dat_001_00040).l            ; 00000
        move.l  a0,(dat_001_00044).l            ; 00006
        move.l  a7,d0                           ; 0000C
        movem.l d1-d6/a0-a6,-(a7)               ; 0000E
        movea.l d0,a5                           ; 00012
        movea.l (AbsExecBase).l,a6              ; 00014
        move.l  a6,(dat_001_0002C).l            ; 0001A
        move.l  a7,(dat_001_0003C).l            ; 00020
        clr.l   (dat_001_00038).l               ; 00026
        suba.l  a1,a1                           ; 0002C
        jsr     -$126(a6)                       ; 0002E
        movea.l d0,a4                           ; 00032
        move.l  $98(a4),(dat_001_00024).l       ; 00034
        tst.l   $ac(a4)                         ; 0003C
        beq.w   l_000_000D8                     ; 00040
        move.l  a5,d0                           ; 00044
        sub.l   $4(a5),d0                       ; 00046
        move.l  d0,(dat_001_00004).l            ; 0004A
        bsr.w   sub_000_001B0                   ; 00050
        movea.l #sub_000_00000,a0               ; 00054
        clr.l   -(a7)                           ; 0005A
        jsr     (_FindTask).l                   ; 0005C
        addq.l  #$4,a7                          ; 00062
        movea.l d0,a0                           ; 00064
        movea.l $ac(a0),a0                      ; 00066
        adda.l  a0,a0                           ; 0006A
        adda.l  a0,a0                           ; 0006C
        movea.l $10(a0),a1                      ; 0006E
        adda.l  a1,a1                           ; 00072
        adda.l  a1,a1                           ; 00074
        move.l  (dat_001_00040).l,d0            ; 00076
        moveq   #$0,d1                          ; 0007C
        move.b  (a1)+,d1                        ; 0007E
        move.l  a1,(dat_001_0004C).l            ; 00080
        add.l   d1,d0                           ; 00086
        addq.l  #$1,d0                          ; 00088
        clr.w   -(a7)                           ; 0008A
        addq.l  #$1,d0                          ; 0008C
        andi.w  #$fffe,d0                       ; 0008E
        suba.l  d0,a7                           ; 00092
        subq.l  #$2,d0                          ; 00094
        clr.w   (a7,d0.w)                       ; 00096
        move.l  (dat_001_00040).l,d0            ; 0009A
        movea.l (dat_001_00044).l,a0            ; 000A0
        move.l  d0,d2                           ; 000A6
        subq.l  #$1,d0                          ; 000A8
        add.l   d1,d2                           ; 000AA
l_000_000AC:
        move.b  (a0,d0.w),(a7,d2.w)             ; 000AC
        subq.l  #$1,d2                          ; 000B2
        dbra    d0,l_000_000AC                  ; 000B4
        move.b  #$20,(a7,d2.w)                  ; 000B8
        subq.l  #$1,d2                          ; 000BE
l_000_000C0:
        move.b  (a1,d2.w),(a7,d2.w)             ; 000C0
        dbra    d2,l_000_000C0                  ; 000C6
        movea.l a7,a1                           ; 000CA
        move.l  a1,-(a7)                        ; 000CC
        jsr     (sub_167_00000).l               ; 000CE
        moveq   #$0,d0                          ; 000D4
        bra.b   l_000_0013A                     ; 000D6
l_000_000D8:
        move.l  $3a(a4),(dat_001_00004).l       ; 000D8
        bsr.w   sub_000_001B0                   ; 000E0
        bsr.w   sub_000_0019E                   ; 000E4
        move.l  d0,(dat_001_00038).l            ; 000E8
        move.l  d0,-(a7)                        ; 000EE
        movea.l d0,a2                           ; 000F0
        move.l  $24(a2),d0                      ; 000F2
        beq.b   l_000_00108                     ; 000F6
        movea.l (dat_001_00030).l,a6            ; 000F8
        movea.l d0,a0                           ; 000FE
        move.l  $0(a0),d1                       ; 00100
        jsr     -$7e(a6)                        ; 00104
l_000_00108:
        move.l  $20(a2),d1                      ; 00108
        beq.b   l_000_0012A                     ; 0010C
        move.l  #$3ed,d2                        ; 0010E
        jsr     -$1e(a6)                        ; 00114
        move.l  d0,(dat_001_00048).l            ; 00118
        beq.b   l_000_0012A                     ; 0011E
        lsl.l   #$2,d0                          ; 00120
        movea.l d0,a0                           ; 00122
        move.l  $8(a0),$a4(a4)                  ; 00124
l_000_0012A:
        clr.l   -(a7)                           ; 0012A
        jsr     (sub_000_003CE).l               ; 0012C
        moveq   #$0,d0                          ; 00132
        bra.b   l_000_0013A                     ; 00134
sub_000_00136:
        move.l  $4(a7),d0                       ; 00136
l_000_0013A:
        move.l  d0,-(a7)                        ; 0013A
        jsr     (sub_123_000B4).l               ; 0013C
        tst.l   (dat_001_00038).l               ; 00142
        beq.b   l_000_00176                     ; 00148
        move.l  (dat_001_00028).l,d1            ; 0014A
        beq.b   l_000_00156                     ; 00150
        jsr     -$24(a6)                        ; 00152
l_000_00156:
        move.l  (dat_001_00048).l,d1            ; 00156
        beq.b   l_000_00162                     ; 0015C
        jsr     -$24(a6)                        ; 0015E
l_000_00162:
        movea.l (AbsExecBase).l,a6              ; 00162
        jsr     -$84(a6)                        ; 00168
        movea.l (dat_001_00038).l,a1            ; 0016C
        jsr     -$17a(a6)                       ; 00172
l_000_00176:
        move.l  (a7)+,d0                        ; 00176
        movea.l (dat_001_0003C).l,a7            ; 00178
        movem.l (a7)+,d1-d6/a0-a6               ; 0017E
        rts                                     ; 00182
l_000_00184:
        movem.l d7/a5-a6,-(a7)                  ; 00184
        move.l  #$30007,d7                      ; 00188
        movea.l $4.w,a6                         ; 0018E
        jsr     -$6c(a6)                        ; 00192
        movem.l (a7)+,d7/a5-a6                  ; 00196
        moveq   #$64,d0                         ; 0019A
        bra.b   l_000_0013A                     ; 0019C
sub_000_0019E:
        lea.l   $5c(a4),a0                      ; 0019E
        jsr     -$180(a6)                       ; 001A2
        lea.l   $5c(a4),a0                      ; 001A6
        jsr     -$174(a6)                       ; 001AA
        rts                                     ; 001AE
sub_000_001B0:
        lea.l   (dat_001_00050).l,a1            ; 001B0
        moveq   #$0,d0                          ; 001B6
        jsr     -$228(a6)                       ; 001B8
        move.l  d0,(dat_001_00030).l            ; 001BC
        beq.b   l_000_00184                     ; 001C2
        rts                                     ; 001C4
	dc.b	$00,$00
sub_000_001C8:
        link.w  a6,#$ffae                       ; 001C8
        movem.l d2-d3,-(a7)                     ; 001CC
        move.l  $10(a6),-$8(a6)                 ; 001D0
        move.l  #$3ed,-(a7)                     ; 001D6
        move.l  $8(a6),-(a7)                    ; 001DC
        jsr     (_Open).l                       ; 001E0
        addq.l  #$8,a7                          ; 001E6
        move.l  d0,-$10(a6)                     ; 001E8
        tst.l   d0                              ; 001EC
        bne.b   l_000_001FA                     ; 001EE
        moveq   #$0,d0                          ; 001F0
        movem.l (a7)+,d2-d3                     ; 001F2
        unlk    a6                              ; 001F6
        rts                                     ; 001F8
l_000_001FA:
        clr.l   -(a7)                           ; 001FA
        pea.l   -$34(a6)                        ; 001FC
        move.l  -$10(a6),-(a7)                  ; 00200
        jsr     (sub_000_00C46).l               ; 00204
        lea.l   $c(a7),a7                       ; 0020A
        move.l  d0,-$c(a6)                      ; 0020E
        tst.l   d0                              ; 00212
        beq.b   l_000_00220                     ; 00214
        moveq   #$0,d0                          ; 00216
        movem.l (a7)+,d2-d3                     ; 00218
        unlk    a6                              ; 0021C
        rts                                     ; 0021E
l_000_00220:
        pea.l   -$34(a6)                        ; 00220
        jsr     (sub_000_00F7C).l               ; 00224
        addq.l  #$4,a7                          ; 0022A
        moveq   #$8,d0                          ; 0022C
        move.l  d0,-(a7)                        ; 0022E
        pea.l   -$49(a6)                        ; 00230
        pea.l   -$34(a6)                        ; 00234
        jsr     (sub_000_00EF4).l               ; 00238
        lea.l   $c(a7),a7                       ; 0023E
        moveq   #$14,d0                         ; 00242
        move.l  d0,-(a7)                        ; 00244
        move.l  -$8(a6),-(a7)                   ; 00246
        pea.l   -$34(a6)                        ; 0024A
        jsr     (sub_000_00EF4).l               ; 0024E
        lea.l   $c(a7),a7                       ; 00254
        moveq   #$8,d0                          ; 00258
        move.l  d0,-(a7)                        ; 0025A
        pea.l   -$49(a6)                        ; 0025C
        pea.l   -$34(a6)                        ; 00260
        jsr     (sub_000_00EF4).l               ; 00264
        lea.l   $c(a7),a7                       ; 0026A
        move.b  #$20,-$41(a6)                   ; 0026E
        pea.l   -$41(a6)                        ; 00274
        move.l  $c(a6),-(a7)                    ; 00278
        pea.l   -$34(a6)                        ; 0027C
        jsr     (sub_000_00900).l               ; 00280
        lea.l   $c(a7),a7                       ; 00286
        moveq   #$8,d0                          ; 0028A
        move.l  d0,-(a7)                        ; 0028C
        pea.l   -$49(a6)                        ; 0028E
        pea.l   -$34(a6)                        ; 00292
        jsr     (sub_000_00EF4).l               ; 00296
        lea.l   $c(a7),a7                       ; 0029C
        moveq   #$4,d0                          ; 002A0
        move.l  d0,-(a7)                        ; 002A2
        pea.l   -$49(a6)                        ; 002A4
        pea.l   -$34(a6)                        ; 002A8
        jsr     (sub_000_00EF4).l               ; 002AC
        lea.l   $c(a7),a7                       ; 002B2
        move.l  #$10002,-(a7)                   ; 002B6
        moveq   #$28,d0                         ; 002BC
        move.l  d0,-(a7)                        ; 002BE
        jsr     (_AllocMem).l                   ; 002C0
        addq.l  #$8,a7                          ; 002C6
        moveq   #$0,d1                          ; 002C8
        movea.l -$8(a6),a0                      ; 002CA
        move.b  $8(a0),d1                       ; 002CE
        moveq   #$0,d2                          ; 002D2
        move.w  (a0),d2                         ; 002D4
        moveq   #$0,d3                          ; 002D6
        move.w  $2(a0),d3                       ; 002D8
        move.l  d3,-(a7)                        ; 002DC
        move.l  d2,-(a7)                        ; 002DE
        move.l  d1,-(a7)                        ; 002E0
        move.l  d0,-(a7)                        ; 002E2
        move.l  d0,-$4e(a6)                     ; 002E4
        jsr     (_InitBitMap).l                 ; 002E8
        lea.l   $10(a7),a7                      ; 002EE
        clr.l   -$4(a6)                         ; 002F2
l_000_002F6:
        moveq   #$0,d0                          ; 002F6
        movea.l -$8(a6),a0                      ; 002F8
        move.b  $8(a0),d0                       ; 002FC
        move.l  -$4(a6),d1                      ; 00300
        cmp.l   d0,d1                           ; 00304
        bcc.b   l_000_00340                     ; 00306
        move.w  (a0),d0                         ; 00308
        move.w  $2(a0),d2                       ; 0030A
        mulu.w  d2,d0                           ; 0030E
        lsr.l   #$3,d0                          ; 00310
        asl.l   #$2,d1                          ; 00312
        movea.l -$4e(a6),a0                     ; 00314
        addq.l  #$8,a0                          ; 00318
        adda.l  d1,a0                           ; 0031A
        move.l  #$10002,-(a7)                   ; 0031C
        move.l  d0,-(a7)                        ; 00322
        move.l  d0,-$40(a6)                     ; 00324
        move.l  a0,$10(a7)                      ; 00328
        jsr     (_AllocMem).l                   ; 0032C
        addq.l  #$8,a7                          ; 00332
        movea.l $8(a7),a0                       ; 00334
        move.l  d0,(a0)                         ; 00338
        addq.l  #$1,-$4(a6)                     ; 0033A
        bra.b   l_000_002F6                     ; 0033E
l_000_00340:
        moveq   #$0,d0                          ; 00340
        movea.l -$4e(a6),a0                     ; 00342
        move.w  (a0),d0                         ; 00346
        move.l  d0,$8(a7)                       ; 00348
        addi.l  #$7f,d0                         ; 0034C
        lsr.l   #$7,d0                          ; 00352
        move.l  $8(a7),d1                       ; 00354
        add.l   d0,d1                           ; 00358
        asl.l   #$1,d1                          ; 0035A
        move.l  #$10002,-(a7)                   ; 0035C
        move.l  d1,-(a7)                        ; 00362
        move.l  d1,-$3c(a6)                     ; 00364
        jsr     (_AllocMem).l                   ; 00368
        addq.l  #$8,a7                          ; 0036E
        moveq   #$8,d1                          ; 00370
        move.l  d1,-(a7)                        ; 00372
        pea.l   -$49(a6)                        ; 00374
        pea.l   -$34(a6)                        ; 00378
        move.l  d0,-$38(a6)                     ; 0037C
        jsr     (sub_000_00EF4).l               ; 00380
        lea.l   $c(a7),a7                       ; 00386
        move.l  -$3c(a6),-(a7)                  ; 0038A
        move.l  -$38(a6),-(a7)                  ; 0038E
        move.l  -$8(a6),-(a7)                   ; 00392
        clr.l   -(a7)                           ; 00396
        move.l  -$4e(a6),-(a7)                  ; 00398
        pea.l   -$34(a6)                        ; 0039C
        jsr     (sub_000_00996).l               ; 003A0
        lea.l   $18(a7),a7                      ; 003A6
        pea.l   -$34(a6)                        ; 003AA
        jsr     (sub_000_00CCE).l               ; 003AE
        addq.l  #$4,a7                          ; 003B4
        move.l  -$10(a6),-(a7)                  ; 003B6
        jsr     (_Close).l                      ; 003BA
        addq.l  #$4,a7                          ; 003C0
        move.l  -$4e(a6),d0                     ; 003C2
        movem.l (a7)+,d2-d3                     ; 003C6
        unlk    a6                              ; 003CA
        rts                                     ; 003CC
sub_000_003CE:
        link.w  a6,#$ffe8                       ; 003CE
        movem.l d2/a2-a3,-(a7)                  ; 003D2
        move.w  #$3,(dat_071_00112).l           ; 003D6
        moveq   #$1d,d0                         ; 003DE
        move.l  d0,-(a7)                        ; 003E0
        pea.l   (dat_001_0005C).l               ; 003E2
        jsr     (_OpenLibrary).l                ; 003E8
        addq.l  #$8,a7                          ; 003EE
        move.l  d0,(dat_002_000C2).l            ; 003F0
        tst.l   d0                              ; 003F6
        bne.b   l_000_00404                     ; 003F8
        clr.l   -(a7)                           ; 003FA
        jsr     (sub_096_00000).l               ; 003FC
        addq.l  #$4,a7                          ; 00402
l_000_00404:
        jsr     (sub_077_00000).l               ; 00404
        move.l  d0,-$4(a6)                      ; 0040A
        tst.l   d0                              ; 0040E
        beq.b   l_000_00418                     ; 00410
        jsr     (sub_077_000DC).l               ; 00412
l_000_00418:
        clr.b   (dat_071_001A7).l               ; 00418
        clr.l   (dat_071_00528).l               ; 0041E
        move.b  #$1,(dat_071_001A6).l           ; 00424
        pea.l   (dat_002_028D8).l               ; 0042C
        pea.l   (dat_002_02894).l               ; 00432
        pea.l   (dat_001_0006D).l               ; 00438
        bsr.w   sub_000_001C8                   ; 0043E
        lea.l   $c(a7),a7                       ; 00442
        move.l  d0,(dat_002_028D4).l            ; 00446
        clr.l   -(a7)                           ; 0044C
        jsr     (_FreeSprite).l                 ; 0044E
        addq.l  #$4,a7                          ; 00454
        jsr     (sub_000_09660).l               ; 00456
        clr.l   -(a7)                           ; 0045C
        jsr     (_FreeSprite).l                 ; 0045E
        addq.l  #$4,a7                          ; 00464
        moveq   #$2,d0                          ; 00466
        move.l  d0,-(a7)                        ; 00468
        jsr     (_AvailMem).l                   ; 0046A
        addq.l  #$4,a7                          ; 00470
        move.l  d0,-$4(a6)                      ; 00472
        cmpi.l  #$30d40,d0                      ; 00476
        ble.b   l_000_00484                     ; 0047C
        jsr     (sub_000_096BA).l               ; 0047E
l_000_00484:
        clr.l   -(a7)                           ; 00484
        jsr     (_FreeSprite).l                 ; 00486
        addq.l  #$4,a7                          ; 0048C
        jsr     (sub_000_07F04).l               ; 0048E
        bsr.w   sub_000_007AE                   ; 00494
        pea.l   (dat_002_00022).l               ; 00498
        jsr     (_WaitBOVP).l                   ; 0049E
        addq.l  #$4,a7                          ; 004A4
        pea.l   (dat_002_00010).l               ; 004A6
        jsr     (_LoadView).l                   ; 004AC
        addq.l  #$4,a7                          ; 004B2
        movea.l (dat_002_028D4).l,a1            ; 004B4
        movea.l $8(a1),a0                       ; 004BA
        movea.l $c(a1),a1                       ; 004BE
        movea.l (dat_002_028D4).l,a3            ; 004C2
        movea.l $10(a3),a2                      ; 004C8
        movea.l $14(a3),a3                      ; 004CC
        moveq   #$0,d0                          ; 004D0
        move.w  (dat_002_028D8).l,d0            ; 004D2
        moveq   #$0,d1                          ; 004D8
        move.w  (dat_002_028DA).l,d1            ; 004DA
        move.l  d1,-(a7)                        ; 004E0
        move.l  d0,-(a7)                        ; 004E2
        move.l  a3,-(a7)                        ; 004E4
        move.l  a2,-(a7)                        ; 004E6
        move.l  a1,-(a7)                        ; 004E8
        move.l  a0,-(a7)                        ; 004EA
        move.l  a0,-$c(a6)                      ; 004EC
        move.l  a1,-$10(a6)                     ; 004F0
        move.l  a2,-$14(a6)                     ; 004F4
        move.l  a3,-$18(a6)                     ; 004F8
        jsr     (sub_020_00000).l               ; 004FC
        lea.l   $18(a7),a7                      ; 00502
        move.w  d0,(dat_071_0001C).l            ; 00506
        cmpi.w  #$c560,d0                       ; 0050C
        bne.b   l_000_0057E                     ; 00510
        pea.l   (dat_002_00022).l               ; 00512
        jsr     (_WaitBOVP).l                   ; 00518
        addq.l  #$4,a7                          ; 0051E
        move.l  #$21000,-(a7)                   ; 00520
        bsr.w   sub_000_008DA                   ; 00526
        addq.l  #$4,a7                          ; 0052A
        clr.l   -(a7)                           ; 0052C
        jsr     (_FreeSprite).l                 ; 0052E
        addq.l  #$4,a7                          ; 00534
        move.l  #$3f0000,d0                     ; 00536
        move.l  d0,(dat_074_000FE).l            ; 0053C
        move.l  d0,(dat_071_00038).l            ; 00542
        btst    #$7,(dat_071_0052B).l           ; 00548
        beq.b   l_000_00560                     ; 00550
        moveq   #$32,d0                         ; 00552
        move.l  d0,-(a7)                        ; 00554
        jsr     (sub_000_09CE6).l               ; 00556
        addq.l  #$4,a7                          ; 0055C
        bra.b   l_000_0056C                     ; 0055E
l_000_00560:
        moveq   #$f,d0                          ; 00560
        move.l  d0,-(a7)                        ; 00562
        jsr     (sub_000_09D7A).l               ; 00564
        addq.l  #$4,a7                          ; 0056A
l_000_0056C:
        move.l  #$43000,-(a7)                   ; 0056C
        bsr.w   sub_000_008DA                   ; 00572
        addq.l  #$4,a7                          ; 00576
        jsr     (sub_000_08A82).l               ; 00578
l_000_0057E:
        movea.l (dat_002_0004A).l,a0            ; 0057E
        move.l  $4(a0),-$8(a6)                  ; 00584
        clr.l   -$4(a6)                         ; 0058A
l_000_0058E:
        cmpi.l  #$20,-$4(a6)                    ; 0058E
        bge.b   l_000_005A8                     ; 00596
        movea.l -$8(a6),a0                      ; 00598
        clr.w   (a0)                            ; 0059C
        addq.l  #$2,-$8(a6)                     ; 0059E
        addq.l  #$1,-$4(a6)                     ; 005A2
        bra.b   l_000_0058E                     ; 005A6
l_000_005A8:
        pea.l   (dat_002_00022).l               ; 005A8
        jsr     (_WaitBOVP).l                   ; 005AE
        addq.l  #$4,a7                          ; 005B4
        moveq   #$20,d0                         ; 005B6
        move.l  d0,-(a7)                        ; 005B8
        movea.l (dat_002_0004A).l,a0            ; 005BA
        move.l  $4(a0),-(a7)                    ; 005C0
        pea.l   (dat_002_00022).l               ; 005C4
        jsr     (_LoadRGB4).l                   ; 005CA
        lea.l   $c(a7),a7                       ; 005D0
        move.w  (dat_071_0001C).l,d0            ; 005D4
        cmpi.w  #$c560,d0                       ; 005DA
        bne.w   l_000_00698                     ; 005DE
        jsr     (_OwnBlitter).l                 ; 005E2
        jsr     (sub_036_000C8).l               ; 005E8
        jsr     (_WaitBlit).l                   ; 005EE
        jsr     (sub_037_00014).l               ; 005F4
        jsr     (_WaitBlit).l                   ; 005FA
        jsr     (_DisownBlitter).l              ; 00600
        movea.l (dat_002_0004A).l,a0            ; 00606
        move.l  $4(a0),-$8(a6)                  ; 0060C
        clr.l   -$4(a6)                         ; 00612
l_000_00616:
        move.l  -$4(a6),d0                      ; 00616
        cmpi.l  #$20,d0                         ; 0061A
        bge.b   l_000_0063C                     ; 00620
        asl.l   #$1,d0                          ; 00622
        movea.l d0,a0                           ; 00624
        adda.l  #dat_002_02894,a0               ; 00626
        movea.l -$8(a6),a1                      ; 0062C
        move.w  (a0),(a1)                       ; 00630
        addq.l  #$2,-$8(a6)                     ; 00632
        addq.l  #$1,-$4(a6)                     ; 00636
        bra.b   l_000_00616                     ; 0063A
l_000_0063C:
        pea.l   (dat_002_00022).l               ; 0063C
        jsr     (_WaitBOVP).l                   ; 00642
        addq.l  #$4,a7                          ; 00648
        moveq   #$20,d0                         ; 0064A
        move.l  d0,-(a7)                        ; 0064C
        movea.l (dat_002_0004A).l,a0            ; 0064E
        move.l  $4(a0),-(a7)                    ; 00654
        pea.l   (dat_002_00022).l               ; 00658
        jsr     (_LoadRGB4).l                   ; 0065E
        lea.l   $c(a7),a7                       ; 00664
        btst    #$7,(dat_071_0052B).l           ; 00668
        beq.b   l_000_00680                     ; 00670
        move.l  #$20000,-(a7)                   ; 00672
        bsr.w   sub_000_008DA                   ; 00678
        addq.l  #$4,a7                          ; 0067C
        bra.b   l_000_00698                     ; 0067E
l_000_00680:
        moveq   #$32,d0                         ; 00680
        move.l  d0,-(a7)                        ; 00682
        jsr     (sub_000_09D7A).l               ; 00684
        addq.l  #$4,a7                          ; 0068A
        move.l  #$a000,-(a7)                    ; 0068C
        bsr.w   sub_000_008DA                   ; 00692
        addq.l  #$4,a7                          ; 00696
l_000_00698:
        bsr.w   sub_000_00806                   ; 00698
        clr.l   -(a7)                           ; 0069C
        jsr     (_FreeSprite).l                 ; 0069E
        addq.l  #$4,a7                          ; 006A4
        tst.l   (dat_002_000C2).l               ; 006A6
        beq.b   l_000_006BC                     ; 006AC
        move.l  (dat_002_000C2).l,-(a7)         ; 006AE
        jsr     (_CloseLibrary).l               ; 006B4
        addq.l  #$4,a7                          ; 006BA
l_000_006BC:
        pea.l   (dat_002_02904).l               ; 006BC
        pea.l   (dat_002_02894).l               ; 006C2
        pea.l   (dat_001_0007B).l               ; 006C8
        bsr.w   sub_000_001C8                   ; 006CE
        lea.l   $c(a7),a7                       ; 006D2
        move.l  d0,(dat_002_02900).l            ; 006D6
        pea.l   (dat_002_02934).l               ; 006DC
        pea.l   (dat_002_02894).l               ; 006E2
        pea.l   (dat_001_00089).l               ; 006E8
        bsr.w   sub_000_001C8                   ; 006EE
        lea.l   $c(a7),a7                       ; 006F2
        move.l  d0,(dat_002_02930).l            ; 006F6
        movea.l (dat_002_02900).l,a1            ; 006FC
        movea.l $8(a1),a0                       ; 00702
        movea.l $c(a1),a2                       ; 00706
        movea.l $10(a1),a3                      ; 0070A
        movea.l $14(a1),a1                      ; 0070E
        moveq   #$0,d1                          ; 00712
        move.w  (dat_002_02904).l,d1            ; 00714
        moveq   #$0,d2                          ; 0071A
        move.w  (dat_002_02906).l,d2            ; 0071C
        move.l  d2,-(a7)                        ; 00722
        move.l  d1,-(a7)                        ; 00724
        move.l  a1,-(a7)                        ; 00726
        move.l  a3,-(a7)                        ; 00728
        move.l  a2,-(a7)                        ; 0072A
        move.l  a0,-(a7)                        ; 0072C
        move.l  a0,-$c(a6)                      ; 0072E
        move.l  a1,-$18(a6)                     ; 00732
        move.l  a2,-$10(a6)                     ; 00736
        move.l  a3,-$14(a6)                     ; 0073A
        jsr     (sub_020_00000).l               ; 0073E
        lea.l   $18(a7),a7                      ; 00744
        move.w  d0,(dat_071_00020).l            ; 00748
        movea.l (dat_002_02930).l,a1            ; 0074E
        movea.l $8(a1),a0                       ; 00754
        movea.l $c(a1),a2                       ; 00758
        movea.l $10(a1),a3                      ; 0075C
        movea.l $14(a1),a1                      ; 00760
        moveq   #$0,d0                          ; 00764
        move.w  (dat_002_02934).l,d0            ; 00766
        moveq   #$0,d1                          ; 0076C
        move.w  (dat_002_02936).l,d1            ; 0076E
        move.l  d1,-(a7)                        ; 00774
        move.l  d0,-(a7)                        ; 00776
        move.l  a1,-(a7)                        ; 00778
        move.l  a3,-(a7)                        ; 0077A
        move.l  a2,-(a7)                        ; 0077C
        move.l  a0,-(a7)                        ; 0077E
        move.l  a0,-$c(a6)                      ; 00780
        move.l  a1,-$18(a6)                     ; 00784
        move.l  a2,-$10(a6)                     ; 00788
        move.l  a3,-$14(a6)                     ; 0078C
        jsr     (sub_020_00000).l               ; 00790
        lea.l   $18(a7),a7                      ; 00796
        move.w  d0,(dat_071_00024).l            ; 0079A
        jsr     (sub_000_07D48).l               ; 007A0
        movem.l (a7)+,d2/a2-a3                  ; 007A6
        unlk    a6                              ; 007AA
        rts                                     ; 007AC
sub_000_007AE:
        moveq   #$1d,d0                         ; 007AE
        move.l  d0,-(a7)                        ; 007B0
        pea.l   (dat_001_00097).l               ; 007B2
        jsr     (_OpenLibrary).l                ; 007B8
        addq.l  #$8,a7                          ; 007BE
        move.l  d0,(dat_002_00000).l            ; 007C0
        tst.l   d0                              ; 007C6
        bne.b   l_000_007D4                     ; 007C8
        clr.l   -(a7)                           ; 007CA
        jsr     (sub_096_00000).l               ; 007CC
        addq.l  #$4,a7                          ; 007D2
l_000_007D4:
        clr.l   -(a7)                           ; 007D4
        jsr     (_FreeSprite).l                 ; 007D6
        addq.l  #$4,a7                          ; 007DC
        jsr     (_CloseWorkBench).l             ; 007DE
        clr.l   -(a7)                           ; 007E4
        jsr     (_FreeSprite).l                 ; 007E6
        addq.l  #$4,a7                          ; 007EC
        tst.l   (dat_002_00000).l               ; 007EE
        beq.b   l_000_00804                     ; 007F4
        move.l  (dat_002_00000).l,-(a7)         ; 007F6
        jsr     (_CloseLibrary).l               ; 007FC
        addq.l  #$4,a7                          ; 00802
l_000_00804:
        rts                                     ; 00804
sub_000_00806:
        movem.l a2,-(a7)                        ; 00806
        moveq   #$0,d0                          ; 0080A
        move.w  (dat_002_028D8).l,d0            ; 0080C
        moveq   #$0,d1                          ; 00812
        move.w  (dat_002_028DA).l,d1            ; 00814
        move.l  d1,-(a7)                        ; 0081A
        move.l  d0,-(a7)                        ; 0081C
        movea.l (dat_002_028D4).l,a0            ; 0081E
        move.l  $18(a0),-(a7)                   ; 00824
        jsr     (_FreeRaster).l                 ; 00828
        lea.l   $c(a7),a7                       ; 0082E
        movea.l (dat_002_0005E).l,a0            ; 00832
        movea.l (dat_002_028D4).l,a2            ; 00838
        movea.l $8(a2),a1                       ; 0083E
        move.l  a1,$8(a0)                       ; 00842
        move.l  a1,(dat_071_000A2).l            ; 00846
        movea.l (dat_002_028D4).l,a2            ; 0084C
        movea.l $c(a2),a1                       ; 00852
        move.l  a1,$c(a0)                       ; 00856
        move.l  a1,(dat_071_000A6).l            ; 0085A
        movea.l (dat_002_028D4).l,a2            ; 00860
        movea.l $10(a2),a1                      ; 00866
        move.l  a1,$10(a0)                      ; 0086A
        move.l  a1,(dat_071_000AA).l            ; 0086E
        movea.l (dat_002_028D4).l,a2            ; 00874
        movea.l $14(a2),a1                      ; 0087A
        move.l  a1,$14(a0)                      ; 0087E
        move.l  a1,(dat_071_000AE).l            ; 00882
        jsr     (sub_036_0004E).l               ; 00888
        move.l  #$10002,-(a7)                   ; 0088E
        move.l  #$1f40,-(a7)                    ; 00894
        jsr     (_AllocMem).l                   ; 0089A
        addq.l  #$8,a7                          ; 008A0
        move.l  d0,(dat_071_000B2).l            ; 008A2
        tst.l   d0                              ; 008A8
        bne.b   l_000_008BA                     ; 008AA
        move.l  #$fffffc18,-(a7)                ; 008AC
        jsr     (sub_096_00000).l               ; 008B2
        addq.l  #$4,a7                          ; 008B8
l_000_008BA:
        move.l  #$10001,-(a7)                   ; 008BA
        move.l  #$202,-(a7)                     ; 008C0
        jsr     (_AllocMem).l                   ; 008C6
        addq.l  #$8,a7                          ; 008CC
        move.l  d0,(dat_073_016A4).l            ; 008CE
        movem.l (a7)+,a2                        ; 008D4
        rts                                     ; 008D8
sub_000_008DA:
        link.w  a6,#$fffc                       ; 008DA
        clr.l   -$4(a6)                         ; 008DE
l_000_008E2:
        move.l  -$4(a6),d0                      ; 008E2
        cmp.l   $8(a6),d0                       ; 008E6
        bge.b   l_000_008F2                     ; 008EA
        addq.l  #$1,-$4(a6)                     ; 008EC
        bra.b   l_000_008E2                     ; 008F0
l_000_008F2:
        clr.l   -(a7)                           ; 008F2
        jsr     (_FreeSprite).l                 ; 008F4
        addq.l  #$4,a7                          ; 008FA
        unlk    a6                              ; 008FC
        rts                                     ; 008FE
sub_000_00900:
        link.w  a6,#$fff4                       ; 00900
        movea.l $8(a6),a0                       ; 00904
        move.l  $18(a0),d0                      ; 00908
        moveq   #$3,d1                          ; 0090C
        jsr     (sub_152_00000).l               ; 0090E
        moveq   #$0,d1                          ; 00914
        movea.l $10(a6),a0                      ; 00916
        move.b  (a0),d1                         ; 0091A
        move.l  d0,-$4(a6)                      ; 0091C
        cmp.l   d0,d1                           ; 00920
        bcc.b   l_000_0092C                     ; 00922
        moveq   #$0,d0                          ; 00924
        move.b  (a0),d0                         ; 00926
        move.l  d0,-$4(a6)                      ; 00928
l_000_0092C:
        move.l  -$4(a6),d0                      ; 0092C
        movea.l $10(a6),a0                      ; 00930
        move.b  d0,(a0)                         ; 00934
l_000_00936:
        tst.l   -$4(a6)                         ; 00936
        ble.b   l_000_00990                     ; 0093A
        lea.l   -$b(a6),a0                      ; 0093C
        moveq   #$3,d0                          ; 00940
        move.l  d0,-(a7)                        ; 00942
        move.l  a0,-(a7)                        ; 00944
        move.l  $8(a6),-(a7)                    ; 00946
        jsr     (sub_000_00EF4).l               ; 0094A
        lea.l   $c(a7),a7                       ; 00950
        move.l  d0,-$8(a6)                      ; 00954
        tst.l   d0                              ; 00958
        beq.b   l_000_00960                     ; 0095A
        unlk    a6                              ; 0095C
        rts                                     ; 0095E
l_000_00960:
        moveq   #$0,d0                          ; 00960
        move.b  -$b(a6),d0                      ; 00962
        lsr.l   #$4,d0                          ; 00966
        asl.l   #$8,d0                          ; 00968
        moveq   #$0,d1                          ; 0096A
        move.b  -$a(a6),d1                      ; 0096C
        lsr.l   #$4,d1                          ; 00970
        asl.l   #$4,d1                          ; 00972
        or.l    d1,d0                           ; 00974
        moveq   #$0,d1                          ; 00976
        move.b  -$9(a6),d1                      ; 00978
        lsr.l   #$4,d1                          ; 0097C
        or.l    d1,d0                           ; 0097E
        movea.l $c(a6),a0                       ; 00980
        move.w  d0,(a0)                         ; 00984
        addq.l  #$2,$c(a6)                      ; 00986
        subq.l  #$1,-$4(a6)                     ; 0098A
        bra.b   l_000_00936                     ; 0098E
l_000_00990:
        moveq   #$0,d0                          ; 00990
        unlk    a6                              ; 00992
        rts                                     ; 00994
sub_000_00996:
        link.w  a6,#$ff8c                       ; 00996
        movem.l d2,-(a7)                        ; 0099A
        movea.l $14(a6),a0                      ; 0099E
        move.b  $8(a0),-$5(a6)                  ; 009A2
        moveq   #$0,d0                          ; 009A8
        move.w  (a0),d0                         ; 009AA
        addi.l  #$f,d0                          ; 009AC
        lsr.l   #$4,d0                          ; 009B2
        asl.l   #$1,d0                          ; 009B4
        move.l  d0,-$a(a6)                      ; 009B6
        addi.l  #$7f,d0                         ; 009BA
        asr.l   #$7,d0                          ; 009C0
        move.l  -$a(a6),d1                      ; 009C2
        add.l   d0,d1                           ; 009C6
        moveq   #$0,d0                          ; 009C8
        move.w  $2(a0),d0                       ; 009CA
        move.b  $a(a0),d2                       ; 009CE
        move.l  d0,-$12(a6)                     ; 009D2
        move.l  d1,-$e(a6)                      ; 009D6
        move.b  d2,-$13(a6)                     ; 009DA
        cmpi.b  #$1,d2                          ; 009DE
        bls.b   l_000_009EE                     ; 009E2
        moveq   #-6,d0                          ; 009E4
        movem.l (a7)+,d2                        ; 009E6
        unlk    a6                              ; 009EA
        rts                                     ; 009EC
l_000_009EE:
        moveq   #$0,d0                          ; 009EE
        movea.l $c(a6),a0                       ; 009F0
        move.w  (a0),d0                         ; 009F4
        move.l  -$a(a6),d1                      ; 009F6
        cmp.l   d0,d1                           ; 009FA
        bne.b   l_000_00A14                     ; 009FC
        move.l  -$e(a6),d0                      ; 009FE
        asl.l   #$1,d0                          ; 00A02
        move.l  $1c(a6),d1                      ; 00A04
        cmp.l   d0,d1                           ; 00A08
        blt.b   l_000_00A14                     ; 00A0A
        cmpi.b  #$11,-$5(a6)                    ; 00A0C
        bls.b   l_000_00A1E                     ; 00A12
l_000_00A14:
        moveq   #-6,d0                          ; 00A14
        movem.l (a7)+,d2                        ; 00A16
        unlk    a6                              ; 00A1A
        rts                                     ; 00A1C
l_000_00A1E:
        moveq   #$0,d0                          ; 00A1E
        movea.l $c(a6),a0                       ; 00A20
        move.w  $2(a0),d0                       ; 00A24
        move.l  -$12(a6),d1                     ; 00A28
        cmp.l   d0,d1                           ; 00A2C
        bls.b   l_000_00A3A                     ; 00A2E
        moveq   #$0,d1                          ; 00A30
        move.w  $2(a0),d1                       ; 00A32
        move.l  d1,-$12(a6)                     ; 00A36
l_000_00A3A:
        clr.l   -$18(a6)                        ; 00A3A
l_000_00A3E:
        moveq   #$0,d0                          ; 00A3E
        movea.l $c(a6),a0                       ; 00A40
        move.b  $5(a0),d0                       ; 00A44
        move.l  -$18(a6),d1                     ; 00A48
        cmp.l   d0,d1                           ; 00A4C
        bcc.b   l_000_00A60                     ; 00A4E
        asl.l   #$2,d1                          ; 00A50
        addq.l  #$8,a0                          ; 00A52
        adda.l  d1,a0                           ; 00A54
        move.l  (a0),-$74(a6,d1.l)              ; 00A56
        addq.l  #$1,-$18(a6)                    ; 00A5A
        bra.b   l_000_00A3E                     ; 00A5E
l_000_00A60:
        move.l  -$18(a6),d0                     ; 00A60
        cmpi.l  #$11,d0                         ; 00A64
        bge.b   l_000_00A78                     ; 00A6A
        asl.l   #$2,d0                          ; 00A6C
        clr.l   -$74(a6,d0.l)                   ; 00A6E
        addq.l  #$1,-$18(a6)                    ; 00A72
        bra.b   l_000_00A60                     ; 00A76
l_000_00A78:
        movea.l $14(a6),a0                      ; 00A78
        move.b  $9(a0),d0                       ; 00A7C
        subq.b  #$1,d0                          ; 00A80
        bne.b   l_000_00AAA                     ; 00A82
        tst.l   $10(a6)                         ; 00A84
        beq.b   l_000_00A9A                     ; 00A88
        moveq   #$0,d0                          ; 00A8A
        move.b  -$5(a6),d0                      ; 00A8C
        asl.l   #$2,d0                          ; 00A90
        move.l  $10(a6),-$74(a6,d0.l)           ; 00A92
        bra.b   l_000_00AA6                     ; 00A98
l_000_00A9A:
        moveq   #$0,d0                          ; 00A9A
        move.b  -$5(a6),d0                      ; 00A9C
        asl.l   #$2,d0                          ; 00AA0
        clr.l   -$74(a6,d0.l)                   ; 00AA2
l_000_00AA6:
        addq.b  #$1,-$5(a6)                     ; 00AA6
l_000_00AAA:
        movea.l $18(a6),a0                      ; 00AAA
        adda.l  -$e(a6),a0                      ; 00AAE
        move.l  a0,-$28(a6)                     ; 00AB2
        move.l  -$12(a6),-$1c(a6)               ; 00AB6
l_000_00ABC:
        tst.l   -$1c(a6)                        ; 00ABC
        ble.w   l_000_00BEE                     ; 00AC0
        clr.l   -$18(a6)                        ; 00AC4
l_000_00AC8:
        moveq   #$0,d0                          ; 00AC8
        move.b  -$5(a6),d0                      ; 00ACA
        move.l  -$18(a6),d1                     ; 00ACE
        cmp.l   d0,d1                           ; 00AD2
        bcc.w   l_000_00BE6                     ; 00AD4
        asl.l   #$2,d1                          ; 00AD8
        lea.l   -$74(a6),a0                     ; 00ADA
        adda.l  d1,a0                           ; 00ADE
        move.l  a0,-$30(a6)                     ; 00AE0
        tst.l   (a0)                            ; 00AE4
        bne.b   l_000_00AFC                     ; 00AE6
        movea.l $18(a6),a0                      ; 00AE8
        adda.l  -$e(a6),a0                      ; 00AEC
        move.l  a0,-$2c(a6)                     ; 00AF0
        lea.l   -$2c(a6),a0                     ; 00AF4
        move.l  a0,-$30(a6)                     ; 00AF8
l_000_00AFC:
        tst.b   -$13(a6)                        ; 00AFC
        bne.b   l_000_00B38                     ; 00B00
        move.l  -$a(a6),-(a7)                   ; 00B02
        movea.l -$30(a6),a0                     ; 00B06
        move.l  (a0),-(a7)                      ; 00B0A
        move.l  $8(a6),-(a7)                    ; 00B0C
        jsr     (sub_000_00EF4).l               ; 00B10
        lea.l   $c(a7),a7                       ; 00B16
        move.l  d0,-$4(a6)                      ; 00B1A
        tst.l   d0                              ; 00B1E
        beq.b   l_000_00B2A                     ; 00B20
        movem.l (a7)+,d2                        ; 00B22
        unlk    a6                              ; 00B26
        rts                                     ; 00B28
l_000_00B2A:
        move.l  -$a(a6),d0                      ; 00B2A
        movea.l -$30(a6),a0                     ; 00B2E
        add.l   d0,(a0)                         ; 00B32
        bra.w   l_000_00BDE                     ; 00B34
l_000_00B38:
        move.l  -$28(a6),d0                     ; 00B38
        sub.l   $18(a6),d0                      ; 00B3C
        move.l  -$e(a6),d1                      ; 00B40
        sub.l   d0,d1                           ; 00B44
        move.l  d1,-(a7)                        ; 00B46
        move.l  $18(a6),-(a7)                   ; 00B48
        move.l  -$28(a6),-(a7)                  ; 00B4C
        move.l  d0,-$20(a6)                     ; 00B50
        move.l  d1,-$24(a6)                     ; 00B54
        jsr     (sub_150_00000).l               ; 00B58
        lea.l   $c(a7),a7                       ; 00B5E
        movea.l $8(a6),a0                       ; 00B62
        move.l  $18(a0),d0                      ; 00B66
        sub.l   $20(a0),d0                      ; 00B6A
        move.l  -$20(a6),d1                     ; 00B6E
        cmp.l   d0,d1                           ; 00B72
        ble.b   l_000_00B84                     ; 00B74
        move.l  -$24(a6),d1                     ; 00B76
        add.l   d0,d1                           ; 00B7A
        move.l  d0,-$20(a6)                     ; 00B7C
        move.l  d1,-$e(a6)                      ; 00B80
l_000_00B84:
        movea.l $18(a6),a0                      ; 00B84
        adda.l  -$24(a6),a0                     ; 00B88
        move.l  -$20(a6),-(a7)                  ; 00B8C
        move.l  a0,-(a7)                        ; 00B90
        move.l  $8(a6),-(a7)                    ; 00B92
        jsr     (sub_000_00EF4).l               ; 00B96
        lea.l   $c(a7),a7                       ; 00B9C
        move.l  d0,-$4(a6)                      ; 00BA0
        tst.l   d0                              ; 00BA4
        beq.b   l_000_00BB0                     ; 00BA6
        movem.l (a7)+,d2                        ; 00BA8
        unlk    a6                              ; 00BAC
        rts                                     ; 00BAE
l_000_00BB0:
        move.l  $18(a6),-$28(a6)                ; 00BB0
        move.l  -$a(a6),-(a7)                   ; 00BB6
        move.l  -$e(a6),-(a7)                   ; 00BBA
        move.l  -$30(a6),-(a7)                  ; 00BBE
        pea.l   -$28(a6)                        ; 00BC2
        jsr     (_UnPackRow).l                  ; 00BC6
        lea.l   $10(a7),a7                      ; 00BCC
        tst.w   d0                              ; 00BD0
        beq.b   l_000_00BDE                     ; 00BD2
        moveq   #-7,d0                          ; 00BD4
        movem.l (a7)+,d2                        ; 00BD6
        unlk    a6                              ; 00BDA
        rts                                     ; 00BDC
l_000_00BDE:
        addq.l  #$1,-$18(a6)                    ; 00BDE
        bra.w   l_000_00AC8                     ; 00BE2
l_000_00BE6:
        subq.l  #$1,-$1c(a6)                    ; 00BE6
        bra.w   l_000_00ABC                     ; 00BEA
l_000_00BEE:
        moveq   #$0,d0                          ; 00BEE
        movem.l (a7)+,d2                        ; 00BF0
        unlk    a6                              ; 00BF4
        rts                                     ; 00BF6
sub_000_00BF8:
        link.w  a6,#$fffc                       ; 00BF8
        moveq   #-5,d0                          ; 00BFC
        move.l  d0,-$4(a6)                      ; 00BFE
        tst.l   $8(a6)                          ; 00C02
        ble.b   l_000_00C3E                     ; 00C06
        moveq   #$1,d0                          ; 00C08
        move.l  d0,-(a7)                        ; 00C0A
        clr.l   -(a7)                           ; 00C0C
        move.l  $8(a6),-(a7)                    ; 00C0E
        jsr     (_Seek).l                       ; 00C12
        lea.l   $c(a7),a7                       ; 00C18
        moveq   #$0,d0                          ; 00C1C
        move.l  d0,-(a7)                        ; 00C1E
        move.l  d0,-(a7)                        ; 00C20
        move.l  $8(a6),-(a7)                    ; 00C22
        jsr     (_Seek).l                       ; 00C26
        lea.l   $c(a7),a7                       ; 00C2C
        move.l  d0,-$4(a6)                      ; 00C30
        tst.l   d0                              ; 00C34
        bpl.b   l_000_00C3E                     ; 00C36
        moveq   #-3,d0                          ; 00C38
        move.l  d0,-$4(a6)                      ; 00C3A
l_000_00C3E:
        move.l  -$4(a6),d0                      ; 00C3E
        unlk    a6                              ; 00C42
        rts                                     ; 00C44
sub_000_00C46:
        link.w  a6,#$fff4                       ; 00C46
        move.l  $8(a6),d0                       ; 00C4A
        move.l  $c(a6),-$8(a6)                  ; 00C4E
        moveq   #$0,d1                          ; 00C54
        movea.l -$8(a6),a0                      ; 00C56
        move.l  d1,(a0)                         ; 00C5A
        move.l  $10(a6),$4(a0)                  ; 00C5C
        move.l  d0,$8(a0)                       ; 00C62
        move.l  d1,$c(a0)                       ; 00C66
        move.l  d1,$1c(a0)                      ; 00C6A
        move.l  d1,$14(a0)                      ; 00C6E
        move.l  d1,$20(a0)                      ; 00C72
        move.l  d1,$18(a0)                      ; 00C76
        move.l  d0,-(a7)                        ; 00C7A
        move.l  d0,-$4(a6)                      ; 00C7C
        move.l  d1,-$c(a6)                      ; 00C80
        bsr.w   sub_000_00BF8                   ; 00C84
        addq.l  #$4,a7                          ; 00C88
        movea.l -$8(a6),a0                      ; 00C8A
        move.l  d0,$10(a0)                      ; 00C8E
        tst.l   d0                              ; 00C92
        bpl.b   l_000_00C9C                     ; 00C94
        move.l  d0,-$c(a6)                      ; 00C96
        bra.b   l_000_00CC6                     ; 00C9A
l_000_00C9C:
        movea.l -$8(a6),a0                      ; 00C9C
        cmpi.l  #$8,$10(a0)                     ; 00CA0
        bge.b   l_000_00CB2                     ; 00CA8
        moveq   #-4,d0                          ; 00CAA
        move.l  d0,-$c(a6)                      ; 00CAC
        bra.b   l_000_00CC6                     ; 00CB0
l_000_00CB2:
        moveq   #-1,d0                          ; 00CB2
        move.l  d0,-(a7)                        ; 00CB4
        clr.l   -(a7)                           ; 00CB6
        move.l  -$4(a6),-(a7)                   ; 00CB8
        jsr     (_Seek).l                       ; 00CBC
        lea.l   $c(a7),a7                       ; 00CC2
l_000_00CC6:
        move.l  -$c(a6),d0                      ; 00CC6
        unlk    a6                              ; 00CCA
        rts                                     ; 00CCC
sub_000_00CCE:
        link.w  a6,#$fffc                       ; 00CCE
        movea.l $8(a6),a0                       ; 00CD2
        tst.l   (a0)                            ; 00CD6
        beq.b   l_000_00CF6                     ; 00CD8
        movea.l $8(a6),a0                       ; 00CDA
        move.l  $c(a0),d0                       ; 00CDE
        movea.l (a0),a0                         ; 00CE2
        move.l  d0,-$4(a6)                      ; 00CE4
        sub.l   $c(a0),d0                       ; 00CE8
        add.l   d0,$20(a0)                      ; 00CEC
        move.l  -$4(a6),$c(a0)                  ; 00CF0
l_000_00CF6:
        moveq   #$0,d0                          ; 00CF6
        unlk    a6                              ; 00CF8
        rts                                     ; 00CFA
sub_000_00CFC:
        link.w  a6,#$fffc                       ; 00CFC
        moveq   #$0,d0                          ; 00D00
        move.l  d0,-$4(a6)                      ; 00D02
        tst.l   $c(a6)                          ; 00D06
        ble.b   l_000_00D3C                     ; 00D0A
        move.l  d0,-(a7)                        ; 00D0C
        move.l  $c(a6),-(a7)                    ; 00D0E
        movea.l $8(a6),a0                       ; 00D12
        move.l  $8(a0),-(a7)                    ; 00D16
        jsr     (_Seek).l                       ; 00D1A
        lea.l   $c(a7),a7                       ; 00D20
        addq.l  #$1,d0                          ; 00D24
        bne.b   l_000_00D30                     ; 00D26
        moveq   #-9,d0                          ; 00D28
        move.l  d0,-$4(a6)                      ; 00D2A
        bra.b   l_000_00D3C                     ; 00D2E
l_000_00D30:
        move.l  $c(a6),d0                       ; 00D30
        movea.l $8(a6),a0                       ; 00D34
        add.l   d0,$c(a0)                       ; 00D38
l_000_00D3C:
        move.l  -$4(a6),d0                      ; 00D3C
        unlk    a6                              ; 00D40
        rts                                     ; 00D42
sub_000_00D44:
        link.w  a6,#$fff4                       ; 00D44
        movea.l $8(a6),a0                       ; 00D48
        move.l  $18(a0),d0                      ; 00D4C
        sub.l   $20(a0),d0                      ; 00D50
        move.l  $18(a0),d1                      ; 00D54
        andi.l  #$1,d1                          ; 00D58
        add.l   d1,d0                           ; 00D5E
        move.l  d0,-(a7)                        ; 00D60
        move.l  a0,-(a7)                        ; 00D62
        move.l  a0,-$4(a6)                      ; 00D64
        bsr.b   sub_000_00CFC                   ; 00D68
        addq.l  #$8,a7                          ; 00D6A
        move.l  d0,-$8(a6)                      ; 00D6C
        tst.l   d0                              ; 00D70
        beq.b   l_000_00D78                     ; 00D72
        unlk    a6                              ; 00D74
        rts                                     ; 00D76
l_000_00D78:
        moveq   #-9,d0                          ; 00D78
        movea.l -$4(a6),a0                      ; 00D7A
        move.l  d0,$14(a0)                      ; 00D7E
        moveq   #$0,d0                          ; 00D82
        move.l  d0,$1c(a0)                      ; 00D84
        move.l  d0,$20(a0)                      ; 00D88
        move.l  $10(a0),d0                      ; 00D8C
        sub.l   $c(a0),d0                       ; 00D90
        move.l  d0,-$c(a6)                      ; 00D94
        tst.l   d0                              ; 00D98
        bne.b   l_000_00DAA                     ; 00D9A
        clr.l   $18(a0)                         ; 00D9C
        moveq   #-1,d0                          ; 00DA0
        move.l  d0,$14(a0)                      ; 00DA2
        bra.w   l_000_00EE8                     ; 00DA6
l_000_00DAA:
        move.l  -$c(a6),d0                      ; 00DAA
        cmpi.l  #$8,d0                          ; 00DAE
        bge.b   l_000_00DC2                     ; 00DB4
        movea.l -$4(a6),a0                      ; 00DB6
        move.l  d0,$18(a0)                      ; 00DBA
        bra.w   l_000_00EE8                     ; 00DBE
l_000_00DC2:
        movea.l -$4(a6),a0                      ; 00DC2
        adda.w  #$14,a0                         ; 00DC6
        move.l  a0,d0                           ; 00DCA
        moveq   #$8,d1                          ; 00DCC
        move.l  d1,-(a7)                        ; 00DCE
        move.l  d0,-(a7)                        ; 00DD0
        movea.l -$4(a6),a0                      ; 00DD2
        move.l  $8(a0),-(a7)                    ; 00DD6
        jsr     (_Read).l                       ; 00DDA
        lea.l   $c(a7),a7                       ; 00DE0
        tst.l   d0                              ; 00DE4
        beq.b   l_000_00DFE                     ; 00DE6
        cmpi.l  #$ffffffff,d0                   ; 00DE8
        bne.b   l_000_00E0C                     ; 00DEE
        moveq   #-3,d0                          ; 00DF0
        movea.l -$4(a6),a0                      ; 00DF2
        move.l  d0,$14(a0)                      ; 00DF6
        unlk    a6                              ; 00DFA
        rts                                     ; 00DFC
l_000_00DFE:
        moveq   #-9,d0                          ; 00DFE
        movea.l -$4(a6),a0                      ; 00E00
        move.l  d0,$14(a0)                      ; 00E04
        unlk    a6                              ; 00E08
        rts                                     ; 00E0A
l_000_00E0C:
        movea.l -$4(a6),a0                      ; 00E0C
        tst.l   (a0)                            ; 00E10
        bne.b   l_000_00E40                     ; 00E12
        move.l  $14(a0),d0                      ; 00E14
        cmpi.l  #$43415420,d0                   ; 00E18
        beq.b   l_000_00E40                     ; 00E1E
        cmpi.l  #$4c495354,d0                   ; 00E20
        beq.b   l_000_00E40                     ; 00E26
        cmpi.l  #$464f524d,d0                   ; 00E28
        beq.b   l_000_00E40                     ; 00E2E
        nop                                     ; 00E30
        moveq   #-4,d0                          ; 00E32
        movea.l -$4(a6),a0                      ; 00E34
        move.l  d0,$14(a0)                      ; 00E38
        unlk    a6                              ; 00E3C
        rts                                     ; 00E3E
l_000_00E40:
        movea.l -$4(a6),a0                      ; 00E40
        addq.l  #$8,$c(a0)                      ; 00E44
        subq.l  #$8,-$c(a6)                     ; 00E48
        tst.l   $14(a0)                         ; 00E4C
        bgt.b   l_000_00E5C                     ; 00E50
        moveq   #-9,d0                          ; 00E52
        move.l  d0,$14(a0)                      ; 00E54
        bra.w   l_000_00EE8                     ; 00E58
l_000_00E5C:
        movea.l -$4(a6),a0                      ; 00E5C
        tst.l   $18(a0)                         ; 00E60
        bmi.b   l_000_00E70                     ; 00E64
        move.l  $18(a0),d0                      ; 00E66
        cmp.l   -$c(a6),d0                      ; 00E6A
        ble.b   l_000_00E82                     ; 00E6E
l_000_00E70:
        movea.l -$4(a6),a0                      ; 00E70
        move.l  -$c(a6),$18(a0)                 ; 00E74
        moveq   #-9,d0                          ; 00E7A
        move.l  d0,$14(a0)                      ; 00E7C
        bra.b   l_000_00EE8                     ; 00E80
l_000_00E82:
        movea.l -$4(a6),a0                      ; 00E82
        move.l  $14(a0),d0                      ; 00E86
        moveq   #$20,d1                         ; 00E8A
l_000_00E8C:
        subi.l  #$8,d1                          ; 00E8C
        bmi.b   l_000_00EE8                     ; 00E92
        cmp.l   dat_000_00E9E(pc,d1.l),d0       ; 00E94
        bne.b   l_000_00E8C                     ; 00E98
        jmp     dat_000_00EA2(pc,d1.l)          ; 00E9A
dat_000_00E9E:
	dc.b	$43,$41,$54,$20
dat_000_00EA2:
	dc.b	$60,$00,$00,$1A,$50,$52,$4F,$50,$60,$00,$00,$12,$46,$4F,$52,$4D
	dc.b	$60,$00,$00,$0A,$4C,$49,$53,$54,$60,$00,$00,$02,$20,$6E,$FF,$FC
	dc.b	$D0,$FC,$00,$1C,$20,$08,$72,$04,$2F,$01,$2F,$00,$2F,$2E,$FF,$FC
	dc.b	$61,$20,$4F,$EF,$00,$0C,$2D,$40,$FF,$F8,$4A,$80,$67,$08,$20,$6E
	dc.b	$FF,$FC,$21,$40,$00,$14
l_000_00EE8:
        movea.l -$4(a6),a0                      ; 00EE8
        move.l  $14(a0),d0                      ; 00EEC
        unlk    a6                              ; 00EF0
        rts                                     ; 00EF2
sub_000_00EF4:
        link.w  a6,#$fffc                       ; 00EF4
        moveq   #$0,d0                          ; 00EF8
        move.l  d0,-$4(a6)                      ; 00EFA
        tst.l   $10(a6)                         ; 00EFE
        bpl.b   l_000_00F0C                     ; 00F02
        moveq   #-6,d0                          ; 00F04
        move.l  d0,-$4(a6)                      ; 00F06
        bra.b   l_000_00F74                     ; 00F0A
l_000_00F0C:
        movea.l $8(a6),a0                       ; 00F0C
        move.l  $18(a0),d0                      ; 00F10
        sub.l   $20(a0),d0                      ; 00F14
        move.l  $10(a6),d1                      ; 00F18
        cmp.l   d0,d1                           ; 00F1C
        ble.b   l_000_00F28                     ; 00F1E
        moveq   #-8,d0                          ; 00F20
        move.l  d0,-$4(a6)                      ; 00F22
        bra.b   l_000_00F74                     ; 00F26
l_000_00F28:
        tst.l   $10(a6)                         ; 00F28
        ble.b   l_000_00F74                     ; 00F2C
        move.l  $10(a6),-(a7)                   ; 00F2E
        move.l  $c(a6),-(a7)                    ; 00F32
        movea.l $8(a6),a0                       ; 00F36
        move.l  $8(a0),-(a7)                    ; 00F3A
        jsr     (_Read).l                       ; 00F3E
        lea.l   $c(a7),a7                       ; 00F44
        tst.l   d0                              ; 00F48
        beq.b   l_000_00F5C                     ; 00F4A
        cmpi.l  #$ffffffff,d0                   ; 00F4C
        bne.b   l_000_00F64                     ; 00F52
        moveq   #-3,d0                          ; 00F54
        move.l  d0,-$4(a6)                      ; 00F56
        bra.b   l_000_00F74                     ; 00F5A
l_000_00F5C:
        moveq   #-9,d0                          ; 00F5C
        move.l  d0,-$4(a6)                      ; 00F5E
        bra.b   l_000_00F74                     ; 00F62
l_000_00F64:
        move.l  $10(a6),d0                      ; 00F64
        movea.l $8(a6),a0                       ; 00F68
        add.l   d0,$c(a0)                       ; 00F6C
        add.l   d0,$20(a0)                      ; 00F70
l_000_00F74:
        move.l  -$4(a6),d0                      ; 00F74
        unlk    a6                              ; 00F78
        rts                                     ; 00F7A
sub_000_00F7C:
        link.w  a6,#$fffc                       ; 00F7C
        move.l  $8(a6),-(a7)                    ; 00F80
        bsr.w   sub_000_00D44                   ; 00F84
        addq.l  #$4,a7                          ; 00F88
        move.l  d0,-$4(a6)                      ; 00F8A
        cmpi.l  #$50524f50,d0                   ; 00F8E
        bne.b   l_000_00FA4                     ; 00F94
        moveq   #-9,d1                          ; 00F96
        movea.l $8(a6),a0                       ; 00F98
        move.l  d1,$14(a0)                      ; 00F9C
        move.l  d1,-$4(a6)                      ; 00FA0
l_000_00FA4:
        move.l  -$4(a6),d0                      ; 00FA4
        unlk    a6                              ; 00FA8
        rts                                     ; 00FAA
sub_000_00FAC:
        link.w  a6,#$fffa                       ; 00FAC
        clr.w   -$2(a6)                         ; 00FB0
        move.l  #$10001,-(a7)                   ; 00FB4
        jsr     (_AvailMem).l                   ; 00FBA
        addq.l  #$4,a7                          ; 00FC0
        move.l  d0,-$6(a6)                      ; 00FC2
        asr.l   #$1,d0                          ; 00FC6
        move.l  -$6(a6),d1                      ; 00FC8
        sub.l   d0,d1                           ; 00FCC
        move.l  d1,-$6(a6)                      ; 00FCE
        cmpi.l  #$1e848,d1                      ; 00FD2
        ble.b   l_000_00FE2                     ; 00FD8
        move.l  #$1e848,-$6(a6)                 ; 00FDA
l_000_00FE2:
        move.l  -$6(a6),d0                      ; 00FE2
        asr.l   #$4,d0                          ; 00FE6
        move.l  d0,-$6(a6)                      ; 00FE8
        addq.l  #$2,d0                          ; 00FEC
        move.l  #$10001,-(a7)                   ; 00FEE
        move.l  d0,-(a7)                        ; 00FF4
        jsr     (_AllocMem).l                   ; 00FF6
        addq.l  #$8,a7                          ; 00FFC
        move.l  d0,(dat_073_0162C).l            ; 00FFE
        tst.l   d0                              ; 01004
        beq.b   l_000_0103A                     ; 01006
        move.l  -$6(a6),d0                      ; 01008
        move.l  d0,(dat_073_01630).l            ; 0100C
        asl.l   #$2,d0                          ; 01012
        move.l  d0,-$6(a6)                      ; 01014
        addq.l  #$8,d0                          ; 01018
        move.l  #$10001,-(a7)                   ; 0101A
        move.l  d0,-(a7)                        ; 01020
        jsr     (_AllocMem).l                   ; 01022
        addq.l  #$8,a7                          ; 01028
        move.l  d0,(dat_073_01638).l            ; 0102A
        tst.l   d0                              ; 01030
        beq.b   l_000_0103A                     ; 01032
        move.w  #$1,-$2(a6)                     ; 01034
l_000_0103A:
        tst.w   -$2(a6)                         ; 0103A
        bne.b   l_000_0104E                     ; 0103E
        suba.l  a0,a0                           ; 01040
        move.l  a0,(dat_073_0162C).l            ; 01042
        move.l  a0,(dat_073_01638).l            ; 01048
l_000_0104E:
        move.w  -$2(a6),d0                      ; 0104E
        ext.l   d0                              ; 01052
        unlk    a6                              ; 01054
        rts                                     ; 01056
sub_000_01058:
        link.w  a6,#$fff0                       ; 01058
        move.l  #$10001,-(a7)                   ; 0105C
        moveq   #$28,d0                         ; 01062
        move.l  d0,-(a7)                        ; 01064
        jsr     (_AllocMem).l                   ; 01066
        addq.l  #$8,a7                          ; 0106C
        move.l  d0,(dat_073_0164C).l            ; 0106E
        addq.l  #$3,d0                          ; 01074
        andi.l  #$fffffffc,d0                   ; 01076
        move.l  d0,(dat_073_0164C).l            ; 0107C
        moveq   #-2,d1                          ; 01082
        move.l  d1,-(a7)                        ; 01084
        pea.l   (dat_001_000AC).l               ; 01086
        move.l  d0,-$10(a6)                     ; 0108C
        jsr     (_Lock).l                       ; 01090
        addq.l  #$8,a7                          ; 01096
        move.l  (dat_073_0164C).l,-(a7)         ; 01098
        move.l  d0,-(a7)                        ; 0109E
        move.l  d0,-$c(a6)                      ; 010A0
        jsr     (_Info).l                       ; 010A4
        addq.l  #$8,a7                          ; 010AA
        move.l  -$c(a6),-(a7)                   ; 010AC
        jsr     (_UnLock).l                     ; 010B0
        addq.l  #$4,a7                          ; 010B6
        movea.l (dat_073_0164C).l,a0            ; 010B8
        move.l  $18(a0),d0                      ; 010BE
        move.l  d0,-$4(a6)                      ; 010C2
        tst.l   d0                              ; 010C6
        bpl.b   l_000_010D2                     ; 010C8
        moveq   #$1,d0                          ; 010CA
        move.l  d0,-$8(a6)                      ; 010CC
        bra.b   l_000_01100                     ; 010D0
l_000_010D2:
        cmpi.l  #$42414400,-$4(a6)              ; 010D2
        bne.b   l_000_010E4                     ; 010DA
        moveq   #$2,d0                          ; 010DC
        move.l  d0,-$8(a6)                      ; 010DE
        bra.b   l_000_01100                     ; 010E2
l_000_010E4:
        movea.l (dat_073_0164C).l,a0            ; 010E4
        cmpi.l  #$50,$8(a0)                     ; 010EA
        bne.b   l_000_010FC                     ; 010F2
        moveq   #$3,d0                          ; 010F4
        move.l  d0,-$8(a6)                      ; 010F6
        bra.b   l_000_01100                     ; 010FA
l_000_010FC:
        clr.l   -$8(a6)                         ; 010FC
l_000_01100:
        tst.l   (dat_073_0164C).l               ; 01100
        beq.b   l_000_0111A                     ; 01106
        moveq   #$28,d0                         ; 01108
        move.l  d0,-(a7)                        ; 0110A
        move.l  (dat_073_0164C).l,-(a7)         ; 0110C
        jsr     (_FreeMem).l                    ; 01112
        addq.l  #$8,a7                          ; 01118
l_000_0111A:
        move.l  -$8(a6),d0                      ; 0111A
        unlk    a6                              ; 0111E
        rts                                     ; 01120
	dc.b	$00,$00
sub_000_01124:
        link.w  a6,#$fffe                       ; 01124
        move.w  (dat_071_002AA).l,-$2(a6)       ; 01128
        bsr.w   sub_000_01514                   ; 01130
        jsr     (sub_000_01748).l               ; 01134
        jsr     (sub_000_03C94).l               ; 0113A
        tst.b   (dat_071_00165).l               ; 01140
        beq.w   l_000_014C0                     ; 01146
        move.w  #$8,(dat_071_004A4).l           ; 0114A
        jsr     (sub_000_041E8).l               ; 01152
        move.w  #$10,(dat_071_004A4).l          ; 01158
        jsr     (sub_022_000B6).l               ; 01160
        jsr     (sub_008_00376).l               ; 01166
        move.w  #$20,(dat_071_004A4).l          ; 0116C
        jsr     (sub_022_000B4).l               ; 01174
        jsr     (sub_032_00594).l               ; 0117A
        jsr     (sub_008_00286).l               ; 01180
        jsr     (sub_020_00738).l               ; 01186
        jsr     (sub_000_043F2).l               ; 0118C
        jsr     (sub_008_00598).l               ; 01192
        move.w  #$60,(dat_071_004A4).l          ; 01198
        jsr     (sub_020_007EA).l               ; 011A0
        jsr     (sub_020_00AB4).l               ; 011A6
        jsr     (sub_033_00010).l               ; 011AC
        move.w  #$68,(dat_071_004A4).l          ; 011B2
        move.b  (dat_071_0026B).l,d0            ; 011BA
        tst.b   d0                              ; 011C0
        beq.b   l_000_011CC                     ; 011C2
        tst.b   (dat_071_00180).l               ; 011C4
        beq.b   l_000_011D2                     ; 011CA
l_000_011CC:
        jsr     (sub_028_00B9C).l               ; 011CC
l_000_011D2:
        move.w  #$70,(dat_071_004A4).l          ; 011D2
        jsr     (sub_033_003CE).l               ; 011DA
        cmpi.l  #$f8000000,(dat_071_00436).l    ; 011E0
        ble.w   l_000_01274                     ; 011EA
        move.w  #$78,(dat_071_004A4).l          ; 011EE
        jsr     (sub_008_0084C).l               ; 011F6
        move.w  #$80,(dat_071_004A4).l          ; 011FC
        jsr     (sub_008_0085E).l               ; 01204
        move.w  #$90,(dat_071_004A4).l          ; 0120A
        jsr     (sub_025_00000).l               ; 01212
        move.w  #$a0,(dat_071_004A4).l          ; 01218
        tst.b   (dat_071_0017D).l               ; 01220
        beq.b   l_000_01230                     ; 01226
        jsr     (sub_000_072DC).l               ; 01228
        bra.b   l_000_01274                     ; 0122E
l_000_01230:
        jsr     (sub_023_00000).l               ; 01230
        tst.l   d0                              ; 01236
        beq.b   l_000_01258                     ; 01238
        move.w  #$a4,(dat_071_004A4).l          ; 0123A
        jsr     (sub_000_072DC).l               ; 01242
        move.w  #$a8,(dat_071_004A4).l          ; 01248
        jsr     (sub_008_009F4).l               ; 01250
        bra.b   l_000_01274                     ; 01256
l_000_01258:
        move.w  #$ac,(dat_071_004A4).l          ; 01258
        jsr     (sub_008_009F4).l               ; 01260
        move.w  #$b0,(dat_071_004A4).l          ; 01266
        jsr     (sub_000_072DC).l               ; 0126E
l_000_01274:
        move.w  #$c0,(dat_071_004A4).l          ; 01274
        jsr     (sub_000_03D4C).l               ; 0127C
        jsr     (sub_000_04AA0).l               ; 01282
        move.w  #$d0,(dat_071_004A4).l          ; 01288
        move.b  (dat_071_00155).l,d0            ; 01290
        tst.b   d0                              ; 01296
        beq.b   l_000_012A4                     ; 01298
        tst.b   (dat_071_00206).l               ; 0129A
        beq.w   l_000_013F8                     ; 012A0
l_000_012A4:
        move.w  (dat_071_002AC).l,d0            ; 012A4
        moveq   #$9,d1                          ; 012AA
        ext.l   d0                              ; 012AC
        asl.l   d1,d0                           ; 012AE
        movea.l d0,a0                           ; 012B0
        adda.l  #dat_071_00B54,a0               ; 012B2
        move.b  $62(a0),d0                      ; 012B8
        cmpi.b  #$30,d0                         ; 012BC
        bne.b   l_000_012CC                     ; 012C0
        tst.b   (dat_071_00206).l               ; 012C2
        beq.w   l_000_0142C                     ; 012C8
l_000_012CC:
        jsr     (sub_037_000A4).l               ; 012CC
        jsr     (sub_037_002F6).l               ; 012D2
        jsr     (sub_038_000FE).l               ; 012D8
        jsr     (sub_040_00064).l               ; 012DE
        jsr     (sub_038_00002).l               ; 012E4
        jsr     (sub_037_008B8).l               ; 012EA
        move.b  (dat_071_00207).l,d0            ; 012F0
        tst.b   d0                              ; 012F6
        bgt.b   l_000_01308                     ; 012F8
        move.w  -$2(a6),d0                      ; 012FA
        andi.w  #$3,d0                          ; 012FE
        cmpi.w  #$1,d0                          ; 01302
        ble.b   l_000_01314                     ; 01306
l_000_01308:
        jsr     (sub_039_005B6).l               ; 01308
        jsr     (sub_039_0064C).l               ; 0130E
l_000_01314:
        move.b  (dat_071_00207).l,d0            ; 01314
        tst.b   d0                              ; 0131A
        bgt.b   l_000_0132C                     ; 0131C
        move.w  -$2(a6),d0                      ; 0131E
        andi.w  #$3,d0                          ; 01322
        cmpi.w  #$2,d0                          ; 01326
        bge.b   l_000_01332                     ; 0132A
l_000_0132C:
        jsr     (sub_039_00878).l               ; 0132C
l_000_01332:
        move.b  (dat_071_00207).l,d0            ; 01332
        tst.b   d0                              ; 01338
        bgt.b   l_000_01356                     ; 0133A
        move.w  -$2(a6),d0                      ; 0133C
        andi.w  #$3,d0                          ; 01340
        cmpi.w  #$2,d0                          ; 01344
        blt.b   l_000_01356                     ; 01348
        cmpi.l  #$ffff8000,(dat_071_00436).l    ; 0134A
        ble.b   l_000_0135C                     ; 01354
l_000_01356:
        jsr     (sub_039_0071A).l               ; 01356
l_000_0135C:
        move.b  (dat_071_00207).l,d0            ; 0135C
        tst.b   d0                              ; 01362
        bgt.b   l_000_01374                     ; 01364
        move.w  -$2(a6),d0                      ; 01366
        andi.w  #$7,d0                          ; 0136A
        cmpi.w  #$2,d0                          ; 0136E
        bge.b   l_000_0137A                     ; 01372
l_000_01374:
        jsr     (sub_039_0082A).l               ; 01374
l_000_0137A:
        move.b  (dat_071_00207).l,d0            ; 0137A
        tst.b   d0                              ; 01380
        bgt.b   l_000_01392                     ; 01382
        move.w  -$2(a6),d0                      ; 01384
        andi.w  #$f,d0                          ; 01388
        cmpi.w  #$2,d0                          ; 0138C
        bge.b   l_000_01398                     ; 01390
l_000_01392:
        jsr     (sub_037_00258).l               ; 01392
l_000_01398:
        move.w  #$1a0,(dat_071_004A4).l         ; 01398
        jsr     (sub_036_00BAA).l               ; 013A0
        jsr     (sub_039_00FA8).l               ; 013A6
        jsr     (sub_037_00340).l               ; 013AC
        jsr     (sub_039_008D2).l               ; 013B2
        jsr     (sub_039_00960).l               ; 013B8
        jsr     (sub_039_001CC).l               ; 013BE
        jsr     (sub_037_00674).l               ; 013C4
        jsr     (sub_039_00164).l               ; 013CA
        jsr     (sub_039_009EE).l               ; 013D0
        jsr     (sub_037_0049C).l               ; 013D6
        move.b  (dat_071_00207).l,d0            ; 013DC
        tst.b   d0                              ; 013E2
        bmi.b   l_000_013EE                     ; 013E4
        subq.b  #$1,d0                          ; 013E6
        move.b  d0,(dat_071_00207).l            ; 013E8
l_000_013EE:
        move.w  #$1d0,(dat_071_004A4).l         ; 013EE
        bra.b   l_000_0142C                     ; 013F6
l_000_013F8:
        tst.b   (dat_071_00155).l               ; 013F8
        beq.b   l_000_0142C                     ; 013FE
        move.b  #$1,(dat_071_001A9).l           ; 01400
        jsr     (sub_039_0064C).l               ; 01408
        jsr     (sub_039_0071A).l               ; 0140E
        jsr     (sub_039_005B6).l               ; 01414
        nop                                     ; 0141A
        move.b  (dat_071_00276).l,d0            ; 0141C
        subq.b  #$2,d0                          ; 01422
        bne.b   l_000_0142C                     ; 01424
        jsr     (sub_039_009EE).l               ; 01426
l_000_0142C:
        move.w  #$1d4,(dat_071_004A4).l         ; 0142C
        jsr     (sub_000_04392).l               ; 01434
        jsr     (sub_039_0064A).l               ; 0143A
        jsr     (sub_029_001A4).l               ; 01440
        jsr     (sub_020_00562).l               ; 01446
        move.w  -$2(a6),d0                      ; 0144C
        andi.w  #$7,d0                          ; 01450
        subq.w  #$7,d0                          ; 01454
        bne.b   l_000_0145E                     ; 01456
        jsr     (sub_020_006DA).l               ; 01458
l_000_0145E:
        move.w  -$2(a6),d0                      ; 0145E
        andi.w  #$f,d0                          ; 01462
        subq.w  #$4,d0                          ; 01466
        bne.b   l_000_01474                     ; 01468
        clr.l   -(a7)                           ; 0146A
        jsr     (_FreeSprite).l                 ; 0146C
        addq.l  #$4,a7                          ; 01472
l_000_01474:
        move.w  -$2(a6),d0                      ; 01474
        andi.w  #$1f,d0                         ; 01478
        subq.w  #$8,d0                          ; 0147C
        bne.b   l_000_01488                     ; 0147E
        jsr     (sub_036_000F2).l               ; 01480
        bra.b   l_000_014A6                     ; 01486
l_000_01488:
        move.b  (dat_071_0027E).l,d0            ; 01488
        tst.b   d0                              ; 0148E
        bne.b   l_000_014A6                     ; 01490
        move.w  -$2(a6),d0                      ; 01492
        andi.w  #$1f,d0                         ; 01496
        cmpi.w  #$10,d0                         ; 0149A
        bne.b   l_000_014A6                     ; 0149E
        jsr     (sub_006_00008).l               ; 014A0
l_000_014A6:
        move.b  (dat_071_0017E).l,d0            ; 014A6
        tst.b   d0                              ; 014AC
        bne.b   l_000_014D0                     ; 014AE
        move.w  (dat_071_002AA).l,d0            ; 014B0
        addq.w  #$1,d0                          ; 014B6
        move.w  d0,(dat_071_002AA).l            ; 014B8
        bra.b   l_000_014D0                     ; 014BE
l_000_014C0:
        jsr     (sub_000_04AA0).l               ; 014C0
        clr.l   -(a7)                           ; 014C6
        jsr     (_FreeSprite).l                 ; 014C8
        addq.l  #$4,a7                          ; 014CE
l_000_014D0:
        jsr     (sub_029_00002).l               ; 014D0
        tst.b   (dat_071_00182).l               ; 014D6
        beq.b   l_000_01502                     ; 014DC
        tst.b   (dat_071_00165).l               ; 014DE
        beq.b   l_000_01502                     ; 014E4
        move.w  #$210,(dat_071_004A4).l         ; 014E6
        jsr     (sub_036_0000C).l               ; 014EE
        move.w  #$218,(dat_071_004A4).l         ; 014F4
        jsr     (sub_039_00276).l               ; 014FC
l_000_01502:
        move.w  #$220,(dat_071_004A4).l         ; 01502
        jsr     (sub_039_013EE).l               ; 0150A
        unlk    a6                              ; 01510
        rts                                     ; 01512
sub_000_01514:
        link.w  a6,#$fffa                       ; 01514
        jsr     (sub_000_08FFE).l               ; 01518
        jsr     (sub_000_092AC).l               ; 0151E
        move.w  (dat_071_0014E).l,d1            ; 01524
        move.w  d0,-$6(a6)                      ; 0152A
        cmp.w   d0,d1                           ; 0152E
        beq.b   l_000_01544                     ; 01530
        move.w  d0,(dat_071_0014E).l            ; 01532
        move.w  d0,(dat_071_00150).l            ; 01538
        jsr     (sub_000_05E84).l               ; 0153E
l_000_01544:
        move.b  (dat_071_0021B).l,d0            ; 01544
        move.b  d0,-$2(a6)                      ; 0154A
        cmpi.b  #$1,d0                          ; 0154E
        beq.b   l_000_01558                     ; 01552
        subq.b  #$2,d0                          ; 01554
        bne.b   l_000_01568                     ; 01556
l_000_01558:
        tst.w   (dat_071_00366).l               ; 01558
        beq.b   l_000_0158A                     ; 0155E
        jsr     (sub_005_00010).l               ; 01560
        bra.b   l_000_01558                     ; 01566
l_000_01568:
        cmpi.b  #$3,-$2(a6)                     ; 01568
        bne.b   l_000_0158A                     ; 0156E
l_000_01570:
        move.w  (dat_071_00366).l,d0            ; 01570
        move.w  (dat_071_00368).l,d1            ; 01576
        or.w    d1,d0                           ; 0157C
        tst.w   d0                              ; 0157E
        beq.b   l_000_0158A                     ; 01580
        jsr     (sub_005_00010).l               ; 01582
        bra.b   l_000_01570                     ; 01588
l_000_0158A:
        jsr     (sub_000_08DA6).l               ; 0158A
        move.b  d0,-$1(a6)                      ; 01590
        cmpi.b  #$ff,d0                         ; 01594
        beq.b   l_000_015B0                     ; 01598
        move.b  d0,-$3(a6)                      ; 0159A
        andi.l  #$ff,d0                         ; 0159E
        move.l  d0,-(a7)                        ; 015A4
        jsr     (sub_005_0015C).l               ; 015A6
        addq.l  #$4,a7                          ; 015AC
        bra.b   l_000_0158A                     ; 015AE
l_000_015B0:
        tst.b   -$2(a6)                         ; 015B0
        bne.b   l_000_015DA                     ; 015B4
        move.w  (dat_071_0036A).l,(dat_071_00366).l; 015B6
        move.w  (dat_071_0036C).l,(dat_071_00368).l; 015C0
        moveq   #$0,d0                          ; 015CA
        move.w  d0,(dat_071_0036A).l            ; 015CC
        move.w  d0,(dat_071_0036C).l            ; 015D2
        bra.b   l_000_015F2                     ; 015D8
l_000_015DA:
        cmpi.b  #$1,-$2(a6)                     ; 015DA
        bne.b   l_000_015F2                     ; 015E0
        move.w  (dat_071_0036C).l,(dat_071_00368).l; 015E2
        clr.w   (dat_071_0036C).l               ; 015EC
l_000_015F2:
        unlk    a6                              ; 015F2
        rts                                     ; 015F4
sub_000_015F6:
        clr.l   -(a7)                           ; 015F6
        jsr     (sub_000_09C58).l               ; 015F8
        addq.l  #$4,a7                          ; 015FE
        moveq   #$1,d0                          ; 01600
        move.l  d0,-(a7)                        ; 01602
        jsr     (sub_000_09C58).l               ; 01604
        addq.l  #$4,a7                          ; 0160A
        moveq   #$2,d0                          ; 0160C
        move.l  d0,-(a7)                        ; 0160E
        jsr     (sub_000_09C58).l               ; 01610
        addq.l  #$4,a7                          ; 01616
        moveq   #$3,d0                          ; 01618
        move.l  d0,-(a7)                        ; 0161A
        jsr     (sub_000_09C58).l               ; 0161C
        addq.l  #$4,a7                          ; 01622
        rts                                     ; 01624
	dc.b	$00,$00
sub_000_01628:
        link.w  a6,#$fffc                       ; 01628
        jsr     (sub_000_08E28).l               ; 0162C
        jsr     (sub_000_08CDC).l               ; 01632
        pea.l   (dat_001_000B4).l               ; 01638
        jsr     (_FindTask).l                   ; 0163E
        addq.l  #$4,a7                          ; 01644
        moveq   #-128,d1                        ; 01646
        move.l  d1,-(a7)                        ; 01648
        move.l  d0,-(a7)                        ; 0164A
        move.l  d0,-$4(a6)                      ; 0164C
        jsr     (_SetTaskPri).l                 ; 01650
        addq.l  #$8,a7                          ; 01656
        jsr     (sub_000_08E9C).l               ; 01658
        jsr     (sub_020_004CC).l               ; 0165E
        jsr     (sub_000_099CA).l               ; 01664
        move.l  #$3c0,d0                        ; 0166A
        move.l  d0,-(a7)                        ; 01670
        move.l  d0,-(a7)                        ; 01672
        move.l  #$fffffc40,d0                   ; 01674
        move.l  d0,-(a7)                        ; 0167A
        move.l  d0,-(a7)                        ; 0167C
        jsr     (sub_000_09254).l               ; 0167E
        lea.l   $10(a7),a7                      ; 01684
        moveq   #$64,d0                         ; 01688
        move.l  d0,-(a7)                        ; 0168A
        move.l  #$a0,-(a7)                      ; 0168C
        jsr     (sub_000_0927C).l               ; 01692
        addq.l  #$8,a7                          ; 01698
        clr.b   (dat_071_0021B).l               ; 0169A
        jsr     (sub_004_0002C).l               ; 016A0
        jsr     (sub_004_00000).l               ; 016A6
        lea.l   dat_000_01962(pc),a0            ; 016AC
        move.l  a0,(dat_002_00004).l            ; 016B0
        unlk    a6                              ; 016B6
        rts                                     ; 016B8
sub_000_016BA:
        link.w  a6,#$fffe                       ; 016BA
        move.b  $13(a6),d0                      ; 016BE
        ext.w   d0                              ; 016C2
        ext.l   d0                              ; 016C4
        add.l   d0,$8(a6)                       ; 016C6
        clr.b   -$1(a6)                         ; 016CA
l_000_016CE:
        move.b  -$1(a6),d0                      ; 016CE
        cmp.b   $13(a6),d0                      ; 016D2
        bge.b   l_000_01712                     ; 016D6
        move.l  $c(a6),d0                       ; 016D8
        andi.l  #$f,d0                          ; 016DC
        addi.l  #$30,d0                         ; 016E2
        move.b  d0,-$2(a6)                      ; 016E8
        cmpi.b  #$39,d0                         ; 016EC
        ble.b   l_000_016F6                     ; 016F0
        addq.b  #$7,-$2(a6)                     ; 016F2
l_000_016F6:
        movea.l $8(a6),a0                       ; 016F6
        move.b  -$2(a6),(a0)                    ; 016FA
        subq.l  #$1,$8(a6)                      ; 016FE
        addq.b  #$1,-$1(a6)                     ; 01702
        move.l  $c(a6),d0                       ; 01706
        lsr.l   #$4,d0                          ; 0170A
        move.l  d0,$c(a6)                       ; 0170C
        bra.b   l_000_016CE                     ; 01710
l_000_01712:
        subq.b  #$1,$13(a6)                     ; 01712
        addq.l  #$1,$8(a6)                      ; 01716
        clr.b   -$1(a6)                         ; 0171A
l_000_0171E:
        move.b  -$1(a6),d0                      ; 0171E
        cmp.b   $13(a6),d0                      ; 01722
        bge.b   l_000_01744                     ; 01726
        movea.l $8(a6),a0                       ; 01728
        move.b  (a0),d0                         ; 0172C
        cmpi.b  #$30,d0                         ; 0172E
        bne.b   l_000_01744                     ; 01732
        move.b  #$20,(a0)                       ; 01734
        addq.l  #$1,$8(a6)                      ; 01738
        nop                                     ; 0173C
        addq.b  #$1,-$1(a6)                     ; 0173E
        bra.b   l_000_0171E                     ; 01742
l_000_01744:
        unlk    a6                              ; 01744
        rts                                     ; 01746
sub_000_01748:
        link.w  a6,#$fffc                       ; 01748
        move.b  (dat_071_00268).l,d0            ; 0174C
        tst.b   d0                              ; 01752
        bmi.w   l_000_01922                     ; 01754
        move.b  (dat_071_00276).l,d0            ; 01758
        tst.b   d0                              ; 0175E
        ble.w   l_000_01922                     ; 01760
        tst.b   (dat_071_001FA).l               ; 01764
        beq.w   l_000_01820                     ; 0176A
        move.b  (dat_071_00160).l,d0            ; 0176E
        tst.b   d0                              ; 01774
        bne.w   l_000_01820                     ; 01776
        move.b  (dat_071_001FC).l,d0            ; 0177A
        tst.b   d0                              ; 01780
        bpl.w   l_000_01820                     ; 01782
        tst.l   (dat_071_002E4).l               ; 01786
        beq.w   l_000_01820                     ; 0178C
        move.l  (dat_071_004C2).l,d0            ; 01790
        sub.l   (dat_071_002E4).l,d0            ; 01796
        sub.l   (dat_071_002D8).l,d0            ; 0179C
        move.l  d0,-$4(a6)                      ; 017A2
        tst.l   (dat_071_002D4).l               ; 017A6
        beq.b   l_000_017BE                     ; 017AC
        move.l  (dat_071_004C2).l,d1            ; 017AE
        sub.l   (dat_071_002D4).l,d1            ; 017B4
        sub.l   d1,-$4(a6)                      ; 017BA
l_000_017BE:
        move.l  -$4(a6),d0                      ; 017BE
        sub.l   (dat_071_002E0).l,d0            ; 017C2
        move.l  d0,-$4(a6)                      ; 017C8
        tst.l   (dat_071_002DC).l               ; 017CC
        beq.b   l_000_017E4                     ; 017D2
        move.l  (dat_071_004C2).l,d1            ; 017D4
        sub.l   (dat_071_002DC).l,d1            ; 017DA
        sub.l   d1,-$4(a6)                      ; 017E0
l_000_017E4:
        tst.l   -$4(a6)                         ; 017E4
        bmi.b   l_000_0180C                     ; 017E8
        cmpi.l  #$4650,-$4(a6)                  ; 017EA
        bge.b   l_000_0180C                     ; 017F2
        move.l  -$4(a6),d0                      ; 017F4
        movea.l (dat_002_0296C).l,a0            ; 017F8
        add.l   d0,$8(a0)                       ; 017FE
        move.b  #$1,(dat_071_00195).l           ; 01802
        bra.b   l_000_0181A                     ; 0180A
l_000_0180C:
        move.w  #$3f,(dat_071_0036E).l          ; 0180C
        jsr     (sub_007_00012).l               ; 01814
l_000_0181A:
        clr.l   (dat_071_002E4).l               ; 0181A
l_000_01820:
        move.b  (dat_071_00168).l,d0            ; 01820
        tst.b   d0                              ; 01826
        bmi.w   l_000_018EC                     ; 01828
        move.b  (dat_071_001FA).l,d0            ; 0182C
        cmpi.b  #$ff,d0                         ; 01832
        bne.b   l_000_01854                     ; 01836
        moveq   #$0,d0                          ; 01838
        move.b  d0,(dat_071_001FA).l            ; 0183A
        move.b  d0,(dat_071_001FB).l            ; 01840
        lea.l   sub_000_01A70(pc),a0            ; 01846
        move.l  a0,(dat_002_00004).l            ; 0184A
        bra.w   l_000_01922                     ; 01850
l_000_01854:
        move.b  (dat_071_001FA).l,d0            ; 01854
        subq.b  #$1,d0                          ; 0185A
        bne.b   l_000_018A0                     ; 0185C
        clr.b   (dat_071_001FA).l               ; 0185E
        tst.b   (dat_071_0027C).l               ; 01864
        beq.b   l_000_01874                     ; 0186A
        move.b  #$1,(dat_071_001FB).l           ; 0186C
l_000_01874:
        move.b  #$1,(dat_071_0017E).l           ; 01874
        move.w  #$3,(dat_071_004A6).l           ; 0187C
        moveq   #$0,d0                          ; 01884
        move.b  d0,(dat_071_00165).l            ; 01886
        move.b  d0,(dat_071_00271).l            ; 0188C
        lea.l   sub_000_01A96(pc),a0            ; 01892
        move.l  a0,(dat_002_00004).l            ; 01896
        bra.w   l_000_01922                     ; 0189C
l_000_018A0:
        move.b  (dat_071_001FA).l,d0            ; 018A0
        subq.b  #$2,d0                          ; 018A6
        bne.b   l_000_01922                     ; 018A8
        moveq   #$0,d0                          ; 018AA
        move.b  d0,(dat_071_001FB).l            ; 018AC
        move.b  (dat_071_001FC).l,d0            ; 018B2
        tst.b   d0                              ; 018B8
        bpl.b   l_000_01922                     ; 018BA
        move.b  #$f0,(dat_071_00168).l          ; 018BC
        clr.b   (dat_071_001FA).l               ; 018C4
        moveq   #$1,d0                          ; 018CA
        move.b  d0,(dat_071_0027D).l            ; 018CC
        move.b  d0,(dat_071_0017E).l            ; 018D2
        move.w  #$6,(dat_071_004A6).l           ; 018D8
        lea.l   dat_000_0319C(pc),a0            ; 018E0
        move.l  a0,(dat_002_00004).l            ; 018E4
        bra.b   l_000_01922                     ; 018EA
l_000_018EC:
        move.b  (dat_071_001FA).l,d0            ; 018EC
        subq.b  #$3,d0                          ; 018F2
        bne.b   l_000_01922                     ; 018F4
        moveq   #$0,d0                          ; 018F6
        move.b  d0,(dat_071_001FB).l            ; 018F8
        move.b  (dat_071_001FC).l,d0            ; 018FE
        tst.b   d0                              ; 01904
        bpl.b   l_000_01922                     ; 01906
        clr.b   (dat_071_001FA).l               ; 01908
        move.w  (dat_071_00290).l,(dat_071_004A6).l; 0190E
        lea.l   dat_000_031C8(pc),a0            ; 01918
        move.l  a0,(dat_002_00004).l            ; 0191C
l_000_01922:
        move.b  (dat_071_001FC).l,d0            ; 01922
        tst.b   d0                              ; 01928
        bmi.b   l_000_01934                     ; 0192A
        subq.b  #$1,d0                          ; 0192C
        move.b  d0,(dat_071_001FC).l            ; 0192E
l_000_01934:
        move.b  (dat_071_00191).l,d0            ; 01934
        addq.b  #$1,d0                          ; 0193A
        move.b  d0,(dat_071_00191).l            ; 0193C
        move.w  (dat_071_004A6).l,d0            ; 01942
        subq.w  #$1,d0                          ; 01948
        move.w  d0,(dat_071_004A6).l            ; 0194A
        movea.l (dat_002_00004).l,a0            ; 01950
        jsr     (a0)                            ; 01956
        clr.b   (dat_071_00173).l               ; 01958
        unlk    a6                              ; 0195E
        rts                                     ; 01960
dat_000_01962:
	dc.b	$4E,$56,$FF,$F2,$4E,$B9
        dc.l    sub_004_0006E                   ; 01968
	dc.b	$2D,$79
        dc.l    dat_071_00030                   ; 0196E
	dc.b	$FF,$FC,$42,$6E,$FF,$F6,$30,$2E,$FF,$F6,$0C,$40,$00,$20,$6C,$1C
	dc.b	$48,$C0,$E3,$80,$20,$40,$D1,$FC
        dc.l    dat_021_00080                   ; 0198A
	dc.b	$22,$6E,$FF,$FC,$32,$90,$54,$AE,$FF,$FC,$52,$6E,$FF,$F6,$60,$DA
	dc.b	$42,$39
        dc.l    dat_071_00276                   ; 019A0
	dc.b	$70,$FF,$13,$C0
        dc.l    dat_071_0017D                   ; 019A8
	dc.b	$13,$C0
        dc.l    dat_071_00227                   ; 019AE
	dc.b	$33,$FC,$00,$03
        dc.l    dat_071_004A6                   ; 019B6
	dc.b	$23,$FC
        dc.l    sub_000_03596                   ; 019BC
        dc.l    dat_002_00004                   ; 019C0
	dc.b	$41,$F9
        dc.l    dat_064_00340                   ; 019C6
	dc.b	$2D,$48,$FF,$F2,$D0,$FC,$00,$15,$42,$AE,$FF,$F8,$70,$00,$30,$39
        dc.l    dat_071_0001C                   ; 019DA
	dc.b	$2D,$48,$FF,$F2,$0C,$80,$00,$00,$C5,$60,$67,$08,$10,$BC,$00,$31
	dc.b	$2D,$40,$FF,$F8,$70,$00,$30,$39
        dc.l    dat_071_00020                   ; 019F6
	dc.b	$0C,$80,$00,$00,$7E,$70,$67,$10,$20,$6E,$FF,$F2,$12,$10,$00,$01
	dc.b	$00,$32,$10,$81,$2D,$40,$FF,$F8,$70,$00,$30,$39
        dc.l    dat_071_00024                   ; 01A16
	dc.b	$0C,$80,$00,$00,$4D,$E8,$67,$10,$20,$6E,$FF,$F2,$12,$10,$00,$01
	dc.b	$00,$34,$10,$81,$2D,$40,$FF,$F8,$4A,$AE,$FF,$F8,$67,$28,$20,$6E
	dc.b	$FF,$F2,$52,$88,$70,$04,$2F,$00,$2F,$2E,$FF,$F8,$2F,$08,$2D,$48
	dc.b	$FF,$F2,$61,$00,$FC,$6C,$4F,$EF,$00,$0C,$23,$FC
        dc.l    sub_000_03534                   ; 01A56
        dc.l    dat_002_00004                   ; 01A5A
	dc.b	$60,$0C,$70,$32,$2F,$00,$4E,$B9
        dc.l    sub_000_09CE6                   ; 01A66
	dc.b	$58,$8F,$4E,$5E,$4E,$75
sub_000_01A70:
        jsr     (sub_004_0006E).l               ; 01A70
        moveq   #$0,d0                          ; 01A76
        move.b  d0,(dat_071_0027C).l            ; 01A78
        move.b  d0,(dat_071_00276).l            ; 01A7E
        move.b  d0,(dat_071_0021B).l            ; 01A84
        lea.l   sub_000_01D30(pc),a0            ; 01A8A
        move.l  a0,(dat_002_00004).l            ; 01A8E
        rts                                     ; 01A94
sub_000_01A96:
        move.w  (dat_071_004A6).l,d0            ; 01A96
        tst.w   d0                              ; 01A9C
        bpl.b   l_000_01AC2                     ; 01A9E
        move.b  (dat_071_00270).l,d0            ; 01AA0
        move.b  (dat_071_00271).l,d1            ; 01AA6
        cmp.b   d1,d0                           ; 01AAC
        bne.b   l_000_01AC2                     ; 01AAE
        move.w  #$2,(dat_071_004A6).l           ; 01AB0
        lea.l   dat_000_01AC4(pc),a0            ; 01AB8
        move.l  a0,(dat_002_00004).l            ; 01ABC
l_000_01AC2:
        rts                                     ; 01AC2
dat_000_01AC4:
	dc.b	$30,$39
        dc.l    dat_071_004A6                   ; 01AC6
	dc.b	$4A,$40,$6A,$12,$13,$FC,$00,$01
        dc.l    dat_071_00165                   ; 01AD2
	dc.b	$41,$FA,$00,$0A,$23,$C8
        dc.l    dat_002_00004                   ; 01ADC
	dc.b	$4E,$75,$4E,$B9
        dc.l    sub_000_015F6                   ; 01AE4
	dc.b	$4E,$B9
        dc.l    sub_004_0006E                   ; 01AEA
	dc.b	$10,$39
        dc.l    dat_071_00276                   ; 01AF0
	dc.b	$55,$00,$66,$08,$13,$FC,$00,$7D
        dc.l    dat_071_00276                   ; 01AFC
	dc.b	$10,$39
        dc.l    dat_071_0021B                   ; 01B02
	dc.b	$57,$00,$66,$2A,$13,$FC,$00,$01
        dc.l    dat_071_0017E                   ; 01B0E
	dc.b	$33,$FC,$00,$02
        dc.l    dat_071_004A6                   ; 01B16
	dc.b	$42,$39
        dc.l    dat_071_00271                   ; 01B1C
	dc.b	$13,$FC,$00,$7F
        dc.l    dat_071_00276                   ; 01B24
	dc.b	$41,$FA,$00,$2A,$23,$C8
        dc.l    dat_002_00004                   ; 01B2E
	dc.b	$60,$1E,$42,$39
        dc.l    dat_071_0021B                   ; 01B36
	dc.b	$48,$79
        dc.l    dat_021_00000                   ; 01B3C
	dc.b	$4E,$B9
        dc.l    sub_000_03C1C                   ; 01B42
	dc.b	$58,$8F,$41,$FA,$02,$BA,$23,$C8
        dc.l    dat_002_00004                   ; 01B4E
	dc.b	$4E,$75,$30,$39
        dc.l    dat_071_004A6                   ; 01B56
	dc.b	$4A,$40,$6A,$36,$61,$00,$00,$94,$13,$FC,$00,$03
        dc.l    dat_071_0021B                   ; 01B66
	dc.b	$70,$00,$13,$C0
        dc.l    dat_071_00155                   ; 01B6E
	dc.b	$33,$FC,$00,$02
        dc.l    dat_071_004A6                   ; 01B76
	dc.b	$13,$FC,$00,$0F
        dc.l    dat_071_00271                   ; 01B7E
	dc.b	$13,$C0
        dc.l    dat_071_00270                   ; 01B84
	dc.b	$41,$FA,$00,$12,$23,$C8
        dc.l    dat_002_00004                   ; 01B8E
	dc.b	$60,$06,$4E,$B9
        dc.l    sub_036_00892                   ; 01B96
	dc.b	$4E,$75,$30,$39
        dc.l    dat_071_004A6                   ; 01B9E
	dc.b	'J@j(B9'
        dc.l    dat_071_00165                   ; 01BA8
	dc.b	$10,$39
        dc.l    dat_071_00270                   ; 01BAE
	dc.b	$12,$39
        dc.l    dat_071_00271                   ; 01BB4
	dc.b	$B0,$01,$66,$12,$33,$FC,$00,$02
        dc.l    dat_071_004A6                   ; 01BC0
	dc.b	$41,$FA,$00,$0A,$23,$C8
        dc.l    dat_002_00004                   ; 01BCA
	dc.b	$4E,$75,$30,$39
        dc.l    dat_071_004A6                   ; 01BD2
	dc.b	$4A,$40,$6A,$18,$42,$39
        dc.l    dat_071_0017E                   ; 01BDC
	dc.b	$13,$FC,$00,$01
        dc.l    dat_071_00165                   ; 01BE4
	dc.b	$41,$FA,$11,$6E,$23,$C8
        dc.l    dat_002_00004                   ; 01BEE
	dc.b	$4E,$75,$13,$F9
        dc.l    dat_071_00277                   ; 01BF6
        dc.l    dat_071_00278                   ; 01BFA
	dc.b	$70,$00,$13,$C0
        dc.l    dat_071_00277                   ; 01C02
	dc.b	$70,$04,$13,$C0
        dc.l    dat_071_00218                   ; 01C0A
	dc.b	$53,$00,$13,$C0
        dc.l    dat_071_00218                   ; 01C12
	dc.b	$70,$00,$13,$C0
        dc.l    dat_071_0027E                   ; 01C1A
	dc.b	$13,$C0
        dc.l    dat_071_0017D                   ; 01C20
	dc.b	$13,$FC,$00,$01
        dc.l    dat_071_00160                   ; 01C28
	dc.b	$4E,$B9
        dc.l    sub_026_00002                   ; 01C2E
	dc.b	$13,$FC,$00,$03
        dc.l    dat_071_00276                   ; 01C36
	dc.b	$4E,$B9
        dc.l    sub_004_00392                   ; 01C3C
	dc.b	$61,$00,$18,$20,$42,$39
        dc.l    dat_071_0027D                   ; 01C46
	dc.b	$13,$FC,$00,$01
        dc.l    dat_071_00165                   ; 01C4E
	dc.b	$70,$00,$33,$C0
        dc.l    dat_071_00356                   ; 01C56
	dc.b	$33,$C0
        dc.l    dat_071_00358                   ; 01C5C
	dc.b	$4E,$B9
        dc.l    sub_006_00000                   ; 01C62
	dc.b	$13,$FC,$00,$FF
        dc.l    dat_071_00228                   ; 01C6A
	dc.b	$33,$FC,$00,$01
        dc.l    dat_071_004A6                   ; 01C72
	dc.b	$4E,$75,$10,$39
        dc.l    dat_071_0017E                   ; 01C7A
	dc.b	$4A,$00,$66,$3C,$10,$39
        dc.l    dat_071_001B0                   ; 01C84
	dc.b	$4A,$00,$6A,$32,$13,$FC,$00,$01
        dc.l    dat_071_00165                   ; 01C90
	dc.b	$61,$00,$17,$CC,$70,$00,$33,$C0
        dc.l    dat_071_00356                   ; 01C9C
	dc.b	$33,$C0
        dc.l    dat_071_00358                   ; 01CA2
	dc.b	$4E,$B9
        dc.l    sub_006_00000                   ; 01CA8
	dc.b	$13,$FC,$00,$FF
        dc.l    dat_071_00228                   ; 01CB0
	dc.b	$41,$FA,$10,$A2,$23,$C8
        dc.l    dat_002_00004                   ; 01CBA
	dc.b	$4E,$75,$30,$39
        dc.l    dat_071_004A6                   ; 01CC2
	dc.b	$4A,$40,$6A,$3A,$10,$39
        dc.l    dat_071_001FB                   ; 01CCC
	dc.b	$4A,$00,$66,$1A,$42,$39
        dc.l    dat_071_00165                   ; 01CD6
	dc.b	$33,$FC,$00,$49
        dc.l    dat_071_0011A                   ; 01CDE
	dc.b	$41,$FA,$00,$22,$23,$C8
        dc.l    dat_002_00004                   ; 01CE8
	dc.b	$60,$16,$13,$FC,$00,$01
        dc.l    dat_071_00165                   ; 01CF2
	dc.b	$61,$00,$17,$6A,$41,$FA,$10,$5C,$23,$C8
        dc.l    dat_002_00004                   ; 01D00
	dc.b	$4E,$75,$10,$39
        dc.l    dat_071_001B0                   ; 01D08
	dc.b	$4A,$00,$6B,$08,$4A,$39
        dc.l    dat_071_00173                   ; 01D12
	dc.b	$67,$16,$13,$FC,$00,$01
        dc.l    dat_071_00165                   ; 01D1C
	dc.b	$61,$00,$17,$40,$41,$FA,$10,$32,$23,$C8
        dc.l    dat_002_00004                   ; 01D2A
	dc.b	$4E,$75
sub_000_01D30:
        link.w  a6,#$fffc                       ; 01D30
        move.l  #dat_071_0011A,-$4(a6)          ; 01D34
        move.l  #$1f0000,(dat_071_00038).l      ; 01D3C
        btst    #$7,(dat_071_0052B).l           ; 01D46
        beq.b   l_000_01D64                     ; 01D4E
        move.b  (dat_071_001A7).l,d0            ; 01D50
        tst.b   d0                              ; 01D56
        bne.b   l_000_01D64                     ; 01D58
        move.l  #$1f0000,(dat_074_000FE).l      ; 01D5A
l_000_01D64:
        moveq   #$f,d0                          ; 01D64
        move.l  d0,-(a7)                        ; 01D66
        jsr     (sub_000_09CE6).l               ; 01D68
        addq.l  #$4,a7                          ; 01D6E
        move.b  #$1,(dat_071_001A7).l           ; 01D70
        jsr     (sub_036_00892).l               ; 01D78
        bsr.w   sub_000_03462                   ; 01D7E
        move.l  #$c000,-(a7)                    ; 01D82
        jsr     (sub_000_008DA).l               ; 01D88
        addq.l  #$4,a7                          ; 01D8E
        clr.b   (dat_071_0027D).l               ; 01D90
        pea.l   (dat_021_00000).l               ; 01D96
        jsr     (sub_000_03C1C).l               ; 01D9C
        addq.l  #$4,a7                          ; 01DA2
        move.l  #$1e0,(dat_071_0010E).l         ; 01DA4
        movea.l -$4(a6),a0                      ; 01DAE
        move.w  #$6,(a0)                        ; 01DB2
        addq.l  #$2,a0                          ; 01DB6
        move.w  #$64,(a0)                       ; 01DB8
        addq.l  #$2,a0                          ; 01DBC
        move.w  #$65,(a0)                       ; 01DBE
        addq.l  #$2,a0                          ; 01DC2
        move.w  #$66,(a0)                       ; 01DC4
        addq.l  #$2,a0                          ; 01DC8
        move.w  #$67,(a0)                       ; 01DCA
        addq.l  #$2,a0                          ; 01DCE
        move.w  #$68,(a0)                       ; 01DD0
        addq.l  #$2,a0                          ; 01DD4
        move.w  #$69,(a0)                       ; 01DD6
        addq.l  #$2,a0                          ; 01DDA
        move.w  #$6a,(a0)                       ; 01DDC
        addq.l  #$2,a0                          ; 01DE0
        move.w  #$6b,(a0)                       ; 01DE2
        addq.l  #$2,a0                          ; 01DE6
        move.w  #$6c,(a0)                       ; 01DE8
        addq.l  #$2,a0                          ; 01DEC
        move.w  #$6d,(a0)                       ; 01DEE
        addq.l  #$2,a0                          ; 01DF2
        clr.w   (a0)                            ; 01DF4
        lea.l   dat_000_01E04(pc),a1            ; 01DF6
        move.l  a1,(dat_002_00004).l            ; 01DFA
        unlk    a6                              ; 01E00
        rts                                     ; 01E02
dat_000_01E04:
	dc.b	$4E,$56,$FF,$FA,$2D,$7C
        dc.l    dat_071_0011A                   ; 01E0A
	dc.b	$FF,$FC,$1D,$79
        dc.l    dat_071_00276                   ; 01E12
	dc.b	$FF,$FB,$4A,$39
        dc.l    dat_071_001FA                   ; 01E1A
	dc.b	$67,$24,$42,$39
        dc.l    dat_071_001FA                   ; 01E22
	dc.b	$30,$39
        dc.l    dat_071_00142                   ; 01E28
	dc.b	$5D,$40,$67,$00,$01,$52,$61,$00,$16,$2E,$41,$FA,$FE,$F8,$23,$C8
        dc.l    dat_002_00004                   ; 01E3C
	dc.b	$60,$00,$01,$40,$10,$39
        dc.l    dat_071_00276                   ; 01E46
	dc.b	$4A,$00,$6F,$00,$00,$D2,$42,$B9
        dc.l    dat_071_00038                   ; 01E52
	dc.b	$61,$00,$16,$0A,$4E,$B9
        dc.l    sub_036_00892                   ; 01E5C
	dc.b	$0C,$2E,$00,$7F,$FF,$FB,$66,$0E,$20,$6E,$FF,$FC,$30,$BC,$00,$65
	dc.b	$54,$AE,$FF,$FC,$60,$72,$0C,$2E,$00,$01,$FF,$FB,$66,$0E,$20,$6E
	dc.b	$FF,$FC,$30,$BC,$00,$66,$54,$AE,$FF,$FC,$60,$5C,$0C,$2E,$00,$02
	dc.b	$FF,$FB,$66,$0E,$20,$6E,$FF,$FC,$30,$BC,$00,$67,$54,$AE,$FF,$FC
	dc.b	$60,$46,$0C,$2E,$00,$7D,$FF,$FB,$66,$0E,$20,$6E,$FF,$FC,$30,$BC
	dc.b	$00,$68,$54,$AE,$FF,$FC,$60,$30,$0C,$2E,$00,$09,$FF,$FB,$66,$0E
	dc.b	$20,$6E,$FF,$FC,$30,$BC,$00,$69,$54,$AE,$FF,$FC,$60,$1A,$4A,$39
        dc.l    dat_071_00162                   ; 01ED0
	dc.b	$67,$12,$20,$6E,$FF,$FC,$30,$BC,$00,$6B,$54,$AE,$FF,$FC,$42,$39
        dc.l    dat_071_00162                   ; 01EE4
	dc.b	$20,$6E,$FF,$FC,$42,$50,$10,$39
        dc.l    dat_071_001FB                   ; 01EF0
	dc.b	$4A,$00,$66,$14,$08,$39,$00,$07
        dc.l    dat_071_0052B                   ; 01EFC
	dc.b	$67,$0A,$33,$FC,$00,$D2
        dc.l    dat_071_004A6                   ; 01F06
	dc.b	$60,$08,$33,$FC,$00,$96
        dc.l    dat_071_004A6                   ; 01F10
	dc.b	$41,$FA,$01,$08,$23,$C8
        dc.l    dat_002_00004                   ; 01F1A
	dc.b	$60,$62,$10,$39
        dc.l    dat_071_00276                   ; 01F22
	dc.b	$4A,$00,$6A,$52,$61,$00,$15,$36,$4E,$B9
        dc.l    sub_036_00892                   ; 01F30
	dc.b	$10,$39
        dc.l    dat_071_00276                   ; 01F36
	dc.b	$0C,$00,$00,$FF,$66,$0C,$41,$FA,$03,$8C,$23,$C8
        dc.l    dat_002_00004                   ; 01F46
	dc.b	$60,$28,$4E,$B9
        dc.l    sub_036_00892                   ; 01F4E
	dc.b	$4E,$B9
        dc.l    sub_020_000DA                   ; 01F54
	dc.b	$20,$6E,$FF,$FC,$30,$BC,$00,$57,$54,$AE,$FF,$FC,$20,$6E,$FF,$FC
	dc.b	$42,$50,$41,$FA,$00,$1A,$23,$C8
        dc.l    dat_002_00004                   ; 01F70
	dc.b	$42,$39
        dc.l    dat_071_00276                   ; 01F76
	dc.b	$60,$06,$42,$39
        dc.l    dat_071_001FA                   ; 01F7E
	dc.b	'N^NuJ9'
        dc.l    dat_071_00162                   ; 01F88
	dc.b	$67,$76,$10,$39
        dc.l    dat_071_00162                   ; 01F90
	dc.b	$53,$00,$66,$3C,$4A,$39
        dc.l    dat_071_00195                   ; 01F9A
	dc.b	$67,$5C,$30,$39
        dc.l    dat_071_002F8                   ; 01FA2
	dc.b	$4A,$40,$66,$52,$4E,$B9
        dc.l    sub_000_0858A                   ; 01FAC
	dc.b	$13,$FC,$00,$FF
        dc.l    dat_071_001A5                   ; 01FB4
	dc.b	$20,$79
        dc.l    dat_002_0296C                   ; 01FBA
	dc.b	$30,$28,$00,$04,$0C,$40,$00,$01,$62,$34,$23,$FC
        dc.l    sub_000_03622                   ; 01FCA
        dc.l    dat_002_00004                   ; 01FCE
	dc.b	$60,$28,$10,$39
        dc.l    dat_071_00162                   ; 01FD6
	dc.b	$55,$00,$66,$1E,$4E,$B9
        dc.l    sub_000_08556                   ; 01FE0
	dc.b	$61,$00,$14,$7C,$4E,$B9
        dc.l    sub_036_00892                   ; 01FEA
	dc.b	$4E,$B9
        dc.l    sub_020_000DA                   ; 01FF0
	dc.b	$33,$FC,$00,$57
        dc.l    dat_071_0011A                   ; 01FF8
	dc.b	$42,$39
        dc.l    dat_071_00162                   ; 01FFE
	dc.b	$60,$12,$4A,$39
        dc.l    dat_071_001FA                   ; 02006
	dc.b	$67,$0A,$41,$FA,$FD,$22,$23,$C8
        dc.l    dat_002_00004                   ; 02012
	dc.b	$42,$39
        dc.l    dat_071_00276                   ; 02018
	dc.b	$4E,$75,$4E,$56,$FF,$FE,$10,$39
        dc.l    dat_071_00276                   ; 02024
	dc.b	$48,$80,$32,$39
        dc.l    dat_071_004A6                   ; 0202C
	dc.b	$3D,$40,$FF,$FE,$4A,$41,$6A,$00,$02,$92,$42,$39
        dc.l    dat_071_001A7                   ; 0203C
	dc.b	$42,$A7,$4E,$B9
        dc.l    sub_000_09C58                   ; 02044
	dc.b	$58,$8F,$70,$01,$2F,$00,$4E,$B9
        dc.l    sub_000_09C58                   ; 02050
	dc.b	$58,$8F,$23,$FC,$00,$3F,$00,$00
        dc.l    dat_074_000FE                   ; 0205C
	dc.b	$30,$2E,$FF,$FE,$0C,$40,$00,$03,$65,$14,$0C,$40,$00,$08,$62,$0E
	dc.b	$70,$28,$2F,$00,$4E,$B9
        dc.l    sub_000_09D7A                   ; 02076
	dc.b	$58,$8F,$60,$2A,$08,$39,$00,$04
        dc.l    dat_071_0052B                   ; 02082
	dc.b	$67,$0E,$70,$08,$2F,$00,$4E,$B9
        dc.l    sub_000_09F9A                   ; 0208E
	dc.b	$58,$8F,$60,$12,$70,$08,$2F,$00,$2F,$3C,$00,$00,$03,$00,$4E,$B9
        dc.l    sub_000_09E46                   ; 020A2
	dc.b	$50,$8F,$33,$FC,$00,$B3
        dc.l    dat_071_00354                   ; 020AC
	dc.b	$61,$00,$13,$B0,$33,$FC,$00,$04
        dc.l    dat_071_004A6                   ; 020B8
	dc.b	$13,$FC,$00,$03
        dc.l    dat_071_00267                   ; 020C0
	dc.b	$13,$FC,$00,$02
        dc.l    dat_071_00268                   ; 020C8
	dc.b	$4E,$B9
        dc.l    sub_026_00002                   ; 020CE
	dc.b	$42,$39
        dc.l    dat_071_0017E                   ; 020D4
	dc.b	$13,$FC,$00,$01
        dc.l    dat_071_00165                   ; 020DC
	dc.b	$13,$FC,$00,$03
        dc.l    dat_071_00206                   ; 020E4
	dc.b	$13,$F9
        dc.l    dat_071_00270                   ; 020EA
        dc.l    dat_071_00271                   ; 020EE
	dc.b	$4E,$B9
        dc.l    sub_000_03C5E                   ; 020F4
	dc.b	$41,$FA,$04,$3A,$23,$C8
        dc.l    dat_002_00004                   ; 020FE
	dc.b	$13,$FC,$00,$03
        dc.l    dat_071_00218                   ; 02106
	dc.b	$13,$FC,$00,$11
        dc.l    dat_071_00219                   ; 0210E
	dc.b	$70,$00,$30,$2E,$FF,$FE,$72,$30,$04,$81,$00,$00,$00,$08,$6B,$00
	dc.b	$01,$90,$B0,$BB,$18,$08,$66,$F0,$4E,$FB,$18,$06,$00,$00,$00,$09
	dc.b	$60,$00,$01,$1E,$00,$00,$00,$7D,$60,$00,$00,$C6,$00,$00,$00,$03
	dc.b	$60,$00,$00,$B4,$00,$00,$00,$02,$60,$00,$00,$44,$00,$00,$00,$01
	dc.b	$60,$00,$00,$20,$00,$00,$00,$7F,$60,$00,$00,$02,$13,$FC,$00,$01
        dc.l    dat_071_0017E                   ; 02162
	dc.b	$41,$FA,$F9,$EC,$23,$C8
        dc.l    dat_002_00004                   ; 0216C
	dc.b	$60,$00,$01,$40,$4E,$B9
        dc.l    sub_004_00268                   ; 02176
	dc.b	$13,$FC,$00,$05
        dc.l    dat_071_00267                   ; 0217E
	dc.b	$41,$FA,$01,$C8,$23,$C8
        dc.l    dat_002_00004                   ; 02188
	dc.b	$60,$00,$01,$24,$33,$FC,$00,$A7
        dc.l    dat_071_00354                   ; 02194
	dc.b	$13,$FC,$00,$FF
        dc.l    dat_071_00184                   ; 0219C
	dc.b	$4E,$B9
        dc.l    sub_026_00D70                   ; 021A2
	dc.b	$70,$00,$13,$C0
        dc.l    dat_071_0017D                   ; 021AA
	dc.b	$70,$01,$13,$C0
        dc.l    dat_071_00155                   ; 021B2
	dc.b	$42,$39
        dc.l    dat_071_0027E                   ; 021B8
	dc.b	$13,$C0
        dc.l    dat_071_00185                   ; 021BE
	dc.b	$33,$FC,$00,$04
        dc.l    dat_071_002AC                   ; 021C6
	dc.b	$33,$FC,$08,$00
        dc.l    dat_071_002AE                   ; 021CE
	dc.b	$13,$FC,$00,$03
        dc.l    dat_071_00282                   ; 021D6
	dc.b	$30,$39
        dc.l    dat_071_01356                   ; 021DC
	dc.b	$00,$40,$01,$00,$33,$C0
        dc.l    dat_071_01356                   ; 021E6
	dc.b	$41,$FA,$01,$D6,$23,$C8
        dc.l    dat_002_00004                   ; 021F0
	dc.b	$60,$00,$00,$BC,$42,$39
        dc.l    dat_071_00218                   ; 021FA
	dc.b	$60,$00,$00,$B2,$13,$FC,$00,$01
        dc.l    dat_071_00267                   ; 02206
	dc.b	$33,$FC,$00,$A7
        dc.l    dat_071_00354                   ; 0220E
	dc.b	$13,$FC,$00,$FF
        dc.l    dat_071_00184                   ; 02216
	dc.b	$13,$FC,$00,$03
        dc.l    dat_071_00186                   ; 0221E
	dc.b	$13,$FC,$00,$02
        dc.l    dat_071_00218                   ; 02226
	dc.b	$61,$00,$0A,$B4,$4E,$B9
        dc.l    sub_026_00D7A                   ; 02230
	dc.b	$4E,$B9
        dc.l    sub_004_00290                   ; 02236
	dc.b	$4E,$B9
        dc.l    sub_026_00002                   ; 0223C
	dc.b	$42,$39
        dc.l    dat_071_0017D                   ; 02242
	dc.b	$41,$FA,$01,$7A,$23,$C8
        dc.l    dat_002_00004                   ; 0224C
	dc.b	$60,$60,$13,$FC,$00,$03
        dc.l    dat_071_00218                   ; 02256
	dc.b	$70,$00,$13,$C0
        dc.l    dat_071_0027E                   ; 0225E
	dc.b	$13,$C0
        dc.l    dat_071_0017D                   ; 02264
	dc.b	$4E,$B9
        dc.l    sub_026_00002                   ; 0226A
	dc.b	$4E,$B9
        dc.l    sub_004_00392                   ; 02270
	dc.b	$61,$00,$11,$EC,$70,$01,$13,$C0
        dc.l    dat_071_0027D                   ; 0227C
	dc.b	$13,$C0
        dc.l    dat_071_00165                   ; 02282
	dc.b	$70,$00,$33,$C0
        dc.l    dat_071_00356                   ; 0228A
	dc.b	$33,$C0
        dc.l    dat_071_00358                   ; 02290
	dc.b	$4E,$B9
        dc.l    sub_006_00000                   ; 02296
	dc.b	$13,$FC,$00,$FF
        dc.l    dat_071_00228                   ; 0229E
	dc.b	$42,$39
        dc.l    dat_071_00155                   ; 022A4
	dc.b	$41,$FA,$00,$A2,$23,$C8
        dc.l    dat_002_00004                   ; 022AE
	dc.b	$10,$39
        dc.l    dat_071_00218                   ; 022B4
	dc.b	$57,$00,$66,$08,$13,$FC,$00,$11
        dc.l    dat_071_00219                   ; 022C0
	dc.b	$4E,$B9
        dc.l    sub_008_00598                   ; 022C6
	dc.b	'N^NuNV'
	dc.b	$FF,$F6,$4E,$B9
        dc.l    sub_036_00892                   ; 022D4
	dc.b	$41,$F9
        dc.l    dat_071_0011A                   ; 022DA
	dc.b	$30,$BC,$00,$40,$54,$88,$2D,$7C
        dc.l    dat_064_00000                   ; 022E6
	dc.b	$FF,$F8,$1D,$7C,$00,$03,$FF,$F7,$2D,$48,$FF,$FC,$10,$2E,$FF,$F7
	dc.b	$0C,$00,$00,$09,$6C,$2C,$48,$80,$48,$C0,$20,$79
        dc.l    dat_002_0296C                   ; 02306
	dc.b	$D0,$FC,$00,$12,$D1,$C0,$4A,$10,$67,$12,$20,$6E,$FF,$F8,$22,$6E
	dc.b	$FF,$FC,$32,$90,$54,$AE,$FF,$F8,$54,$AE,$FF,$FC,$52,$2E,$FF,$F7
	dc.b	$60,$CA,$20,$6E,$FF,$FC,$30,$BC,$80,$6E,$54,$AE,$FF,$FC,$20,$6E
	dc.b	$FF,$FC,$42,$50,$41,$FA,$FA,$C4,$23,$C8
        dc.l    dat_002_00004                   ; 02344
	dc.b	'N^Nu09'
        dc.l    dat_071_004A6                   ; 0234E
	dc.b	$4A,$40,$6A,$20,$70,$00,$13,$C0
        dc.l    dat_071_00165                   ; 0235A
	dc.b	$13,$FC,$00,$0F
        dc.l    dat_071_00271                   ; 02362
	dc.b	$13,$C0
        dc.l    dat_071_00270                   ; 02368
	dc.b	$41,$FA,$00,$0A,$23,$C8
        dc.l    dat_002_00004                   ; 02372
	dc.b	$4E,$75,$10,$39
        dc.l    dat_071_00270                   ; 0237A
	dc.b	$12,$39
        dc.l    dat_071_00271                   ; 02380
	dc.b	$B0,$01,$66,$38,$33,$FC,$00,$02
        dc.l    dat_071_004A6                   ; 0238C
	dc.b	$70,$01,$13,$C0
        dc.l    dat_071_00165                   ; 02394
	dc.b	$13,$FC,$00,$FF
        dc.l    dat_071_00228                   ; 0239C
	dc.b	$13,$FC,$00,$04
        dc.l    dat_071_0027E                   ; 023A4
	dc.b	$13,$C0
        dc.l    dat_071_0027D                   ; 023AA
	dc.b	$33,$FC,$00,$05
        dc.l    dat_071_004A6                   ; 023B2
	dc.b	$41,$FA,$04,$10,$23,$C8
        dc.l    dat_002_00004                   ; 023BC
	dc.b	$4E,$75,$30,$39
        dc.l    dat_071_004A6                   ; 023C4
	dc.b	$4A,$40,$6A,$20,$70,$00,$13,$C0
        dc.l    dat_071_00165                   ; 023D0
	dc.b	$13,$FC,$00,$0F
        dc.l    dat_071_00271                   ; 023D8
	dc.b	$13,$C0
        dc.l    dat_071_00270                   ; 023DE
	dc.b	$41,$FA,$00,$0A,$23,$C8
        dc.l    dat_002_00004                   ; 023E8
	dc.b	$4E,$75,$10,$39
        dc.l    dat_071_00270                   ; 023F0
	dc.b	$12,$39
        dc.l    dat_071_00271                   ; 023F6
	dc.b	$B0,$01,$66,$28,$70,$01,$13,$C0
        dc.l    dat_071_00165                   ; 02402
	dc.b	$13,$FC,$00,$FF
        dc.l    dat_071_00228                   ; 0240A
	dc.b	$13,$C0
        dc.l    dat_071_0027D                   ; 02410
	dc.b	$33,$FC,$00,$05
        dc.l    dat_071_004A6                   ; 02418
	dc.b	$41,$FA,$03,$AA,$23,$C8
        dc.l    dat_002_00004                   ; 02422
	dc.b	$4E,$75,$70,$01,$13,$C0
        dc.l    dat_071_00165                   ; 0242C
	dc.b	$13,$FC,$00,$FF
        dc.l    dat_071_00228                   ; 02434
	dc.b	$13,$C0
        dc.l    dat_071_0027D                   ; 0243A
	dc.b	$33,$FC,$00,$05
        dc.l    dat_071_004A6                   ; 02442
	dc.b	$41,$FA,$00,$0A,$23,$C8
        dc.l    dat_002_00004                   ; 0244C
	dc.b	$4E,$75,$4E,$56,$FF,$FC,$2D,$7C
        dc.l    dat_071_0011A                   ; 02458
	dc.b	$FF,$FC,$4A,$39
        dc.l    dat_071_00173                   ; 02460
	dc.b	$67,$04
	dc.b	'aJ`D09'
        dc.l    dat_071_004A6                   ; 0246C
	dc.b	'J@j:B9'
        dc.l    dat_071_00165                   ; 02476
	dc.b	$10,$39
        dc.l    dat_071_00276                   ; 0247C
	dc.b	$55,$00,$66,$0E,$20,$6E,$FF,$FC,$30,$BC,$00,$09,$54,$AE,$FF,$FC
	dc.b	$60,$12,$20,$6E,$FF,$FC,$30,$BC,$00,$0A,$54,$AE,$FF,$FC,$42,$39
        dc.l    dat_071_0027D                   ; 024A0
	dc.b	$41,$FA,$00,$0C,$23,$C8
        dc.l    dat_002_00004                   ; 024AA
	dc.b	$4E,$5E,$4E,$75,$10,$39
        dc.l    dat_071_001B0                   ; 024B4
	dc.b	$4A,$00,$6B,$08,$4A,$39
        dc.l    dat_071_00173                   ; 024BE
	dc.b	$67,$6E,$13,$FC,$00,$01
        dc.l    dat_071_00165                   ; 024C8
	dc.b	$13,$FC,$00,$FF
        dc.l    dat_071_00228                   ; 024D0
	dc.b	$61,$00,$0F,$8C,$70,$01,$13,$C0
        dc.l    dat_071_00184                   ; 024DC
	dc.b	$13,$C0
        dc.l    dat_071_00185                   ; 024E2
	dc.b	$42,$39
        dc.l    dat_071_0027D                   ; 024E8
	dc.b	$10,$39
        dc.l    dat_071_00276                   ; 024EE
	dc.b	$0C,$00,$00,$7D,$66,$14,$13,$FC,$00,$06
        dc.l    dat_071_0027E                   ; 024FC
	dc.b	$41,$FA,$08,$56,$23,$C8
        dc.l    dat_002_00004                   ; 02506
	dc.b	$60,$26,$13,$FC,$00,$03
        dc.l    dat_071_00206                   ; 02510
	dc.b	$42,$79
        dc.l    dat_073_0162A                   ; 02516
	dc.b	$42,$39
        dc.l    dat_071_00158                   ; 0251C
	dc.b	$33,$FC,$00,$05
        dc.l    dat_071_004A6                   ; 02524
	dc.b	$41,$FA,$08,$8E,$23,$C8
        dc.l    dat_002_00004                   ; 0252E
	dc.b	$4E,$75,$13,$FC,$00,$01
        dc.l    dat_071_0027D                   ; 02538
	dc.b	$30,$39
        dc.l    dat_071_004A6                   ; 0253E
	dc.b	$4A,$40,$6A,$20,$70,$00,$13,$C0
        dc.l    dat_071_00165                   ; 0254A
	dc.b	$13,$FC,$00,$0F
        dc.l    dat_071_00271                   ; 02552
	dc.b	$13,$C0
        dc.l    dat_071_00270                   ; 02558
	dc.b	$41,$FA,$00,$0A,$23,$C8
        dc.l    dat_002_00004                   ; 02562
	dc.b	$4E,$75,$10,$39
        dc.l    dat_071_00270                   ; 0256A
	dc.b	$12,$39
        dc.l    dat_071_00271                   ; 02570
	dc.b	$B0,$01,$66,$2E,$70,$01,$13,$C0
        dc.l    dat_071_00165                   ; 0257C
	dc.b	$13,$FC,$00,$FF
        dc.l    dat_071_00228                   ; 02584
	dc.b	$13,$C0
        dc.l    dat_071_0017D                   ; 0258A
	dc.b	$13,$C0
        dc.l    dat_071_00227                   ; 02590
	dc.b	$33,$FC,$00,$09
        dc.l    dat_071_004A6                   ; 02598
	dc.b	$41,$FA,$00,$0A,$23,$C8
        dc.l    dat_002_00004                   ; 025A2
	dc.b	$4E,$75,$10,$39
        dc.l    dat_071_00166                   ; 025AA
	dc.b	$12,$39
        dc.l    dat_071_00173                   ; 025B0
	dc.b	$80,$01,$13,$C0
        dc.l    dat_071_00166                   ; 025B8
	dc.b	$10,$39
        dc.l    dat_071_001FB                   ; 025BE
	dc.b	$4A,$00,$66,$28,$4A,$39
        dc.l    dat_071_00173                   ; 025C8
	dc.b	$67,$20,$13,$FC,$00,$01
        dc.l    dat_071_00165                   ; 025D2
	dc.b	$61,$00,$0E,$8A,$33,$FC,$FF,$FF
        dc.l    dat_071_004A6                   ; 025DE
	dc.b	$41,$FA,$01,$60,$23,$C8
        dc.l    dat_002_00004                   ; 025E8
	dc.b	$60,$22,$30,$39
        dc.l    dat_071_004A6                   ; 025F0
	dc.b	$4A,$40,$6A,$18,$42,$39
        dc.l    dat_071_00227                   ; 025FA
	dc.b	$33,$FC,$00,$01
        dc.l    dat_071_004A6                   ; 02602
	dc.b	$41,$FA,$00,$0A,$23,$C8
        dc.l    dat_002_00004                   ; 0260C
	dc.b	$4E,$75,$4E,$56,$FF,$FE,$48,$E7,$20,$00,$70,$00,$13,$C0
        dc.l    dat_071_0017E                   ; 0261E
	dc.b	$10,$39
        dc.l    dat_071_00166                   ; 02624
	dc.b	$12,$39
        dc.l    dat_071_00173                   ; 0262A
	dc.b	$80,$01,$13,$C0
        dc.l    dat_071_00166                   ; 02632
	dc.b	$10,$39
        dc.l    dat_071_001FB                   ; 02638
	dc.b	$4A,$00,$66,$2A,$4A,$39
        dc.l    dat_071_00173                   ; 02642
	dc.b	$67,$22,$13,$FC,$00,$01
        dc.l    dat_071_00165                   ; 0264C
	dc.b	$61,$00,$0E,$10,$33,$FC,$FF,$FF
        dc.l    dat_071_004A6                   ; 02658
	dc.b	$41,$FA,$00,$E6,$23,$C8
        dc.l    dat_002_00004                   ; 02662
	dc.b	$60,$00,$00,$86,$30,$39
        dc.l    dat_071_004A6                   ; 0266C
	dc.b	'J@jzB9'
        dc.l    dat_071_00165                   ; 02676
	dc.b	$10,$39
        dc.l    dat_071_00276                   ; 0267C
	dc.b	$48,$80,$3D,$40,$FF,$FE,$0C,$40,$00,$03,$65,$58,$0C,$40,$00,$08
	dc.b	$62,$52,$33,$FC,$00,$5B
        dc.l    dat_071_0011A                   ; 02696
	dc.b	$72,$00,$32,$2E,$FF,$FE,$20,$79
        dc.l    dat_002_0296C                   ; 026A2
	dc.b	$D0,$FC,$00,$12,$D1,$C1,$14,$10,$4A,$02,$66,$1A,$72,$00,$32,$2E
	dc.b	$FF,$FE,$42,$A7,$70,$01,$2F,$00,$2F,$01,$4E,$B9
        dc.l    sub_020_001F4                   ; 026C2
	dc.b	$4F,$EF,$00,$0C,$60,$18,$70,$00,$30,$2E,$FF,$FE,$72,$01,$2F,$01
	dc.b	$2F,$01,$2F,$00,$4E,$B9
        dc.l    sub_020_001F4                   ; 026DC
	dc.b	$4F,$EF,$00,$0C,$41,$FA,$00,$10,$23,$C8
        dc.l    dat_002_00004                   ; 026EA
	dc.b	$4C,$DF,$00,$04,$4E,$5E,$4E,$75,$10,$39
        dc.l    dat_071_001B0                   ; 026F8
	dc.b	$4A,$00,$6B,$08,$4A,$39
        dc.l    dat_071_00173                   ; 02702
	dc.b	$67,$3A,$10,$39
        dc.l    dat_071_00166                   ; 0270A
	dc.b	$12,$39
        dc.l    dat_071_00173                   ; 02710
	dc.b	$80,$01,$13,$C0
        dc.l    dat_071_00166                   ; 02718
	dc.b	$13,$FC,$00,$01
        dc.l    dat_071_00165                   ; 02720
	dc.b	$61,$00,$0D,$3C,$33,$FC,$FF,$FF
        dc.l    dat_071_004A6                   ; 0272C
	dc.b	$13,$FC,$00,$03
        dc.l    dat_071_00206                   ; 02734
	dc.b	$41,$FA,$00,$0A,$23,$C8
        dc.l    dat_002_00004                   ; 0273E
	dc.b	$4E,$75,$30,$39
        dc.l    dat_071_004A6                   ; 02746
	dc.b	$4A,$40,$6A,$26,$70,$01,$13,$C0
        dc.l    dat_071_0017D                   ; 02752
	dc.b	$13,$C0
        dc.l    dat_071_00227                   ; 02758
	dc.b	$33,$FC,$00,$01
        dc.l    dat_071_004A6                   ; 02760
	dc.b	$4E,$B9
        dc.l    sub_026_00C48                   ; 02766
	dc.b	$41,$FA,$00,$0A,$23,$C8
        dc.l    dat_002_00004                   ; 02770
	dc.b	$4E,$75,$30,$39
        dc.l    dat_071_004A6                   ; 02778
	dc.b	$4A,$40,$6A,$1A,$13,$FC,$00,$02
        dc.l    dat_071_0027E                   ; 02784
	dc.b	$13,$FC,$00,$01
        dc.l    dat_071_00185                   ; 0278C
	dc.b	$41,$FA,$00,$0A,$23,$C8
        dc.l    dat_002_00004                   ; 02796
	dc.b	$4E,$75,$10,$39
        dc.l    dat_071_0027E                   ; 0279E
	dc.b	$57,$00,$66,$20,$70,$00,$13,$C0
        dc.l    dat_071_00185                   ; 027AA
	dc.b	$13,$C0
        dc.l    dat_071_00227                   ; 027B0
	dc.b	$33,$FC,$00,$02
        dc.l    dat_071_004A6                   ; 027B8
	dc.b	$41,$FA,$00,$0A,$23,$C8
        dc.l    dat_002_00004                   ; 027C2
	dc.b	$4E,$75,$4E,$56,$FF,$FA,$30,$39
        dc.l    dat_071_004A6                   ; 027CE
	dc.b	$4A,$40,$6A,$00,$00,$A4,$42,$39
        dc.l    dat_071_00165                   ; 027DA
	dc.b	$4A,$39
        dc.l    dat_071_001FB                   ; 027E0
	dc.b	$67,$24,$13,$FC,$00,$01
        dc.l    dat_071_0027C                   ; 027EA
	dc.b	$13,$FC,$00,$02
        dc.l    dat_071_0027D                   ; 027F2
	dc.b	$33,$FC,$00,$03
        dc.l    dat_071_004A6                   ; 027FA
	dc.b	$41,$FA,$00,$DA,$23,$C8
        dc.l    dat_002_00004                   ; 02804
	dc.b	$60,$70,$10,$39
        dc.l    dat_071_00276                   ; 0280C
	dc.b	$48,$80,$2D,$7C
        dc.l    dat_071_0011A                   ; 02814
	dc.b	$FF,$FC,$12,$39
        dc.l    dat_071_00166                   ; 0281C
	dc.b	$3D,$40,$FF,$FA,$4A,$01,$66,$2A,$0C,$40,$00,$03,$65,$24,$0C,$40
	dc.b	$00,$08,$62,$1E,$57,$40,$66,$0E,$20,$6E,$FF,$FC,$30,$BC,$00,$5F
	dc.b	$54,$AE,$FF,$FC,$60,$0C,$20,$6E,$FF,$FC,$30,$BC,$00,$60,$54,$AE
	dc.b	$FF,$FC,$42,$39
        dc.l    dat_071_00166                   ; 02854
	dc.b	$20,$6E,$FF,$FC,$30,$BC,$00,$47,$54,$AE,$FF,$FC,$20,$6E,$FF,$FC
	dc.b	$42,$50,$4E,$B9
        dc.l    sub_020_003C6                   ; 0286C
	dc.b	$41,$FA,$00,$0C,$23,$C8
        dc.l    dat_002_00004                   ; 02876
	dc.b	$4E,$5E,$4E,$75,$10,$39
        dc.l    dat_071_001B0                   ; 02880
	dc.b	$53,$00,$66,$20,$33,$FC,$00,$04
        dc.l    dat_071_0011A                   ; 0288C
	dc.b	$42,$39
        dc.l    dat_071_00193                   ; 02892
	dc.b	$13,$FC,$00,$03
        dc.l    dat_071_001B0                   ; 0289A
	dc.b	$41,$FA,$00,$0A,$23,$C8
        dc.l    dat_002_00004                   ; 028A4
	dc.b	$4E,$75,$4A,$39
        dc.l    dat_071_0027C                   ; 028AC
	dc.b	$67,$26,$4A,$39
        dc.l    dat_071_00155                   ; 028B4
	dc.b	$67,$08,$13,$FC,$00,$02
        dc.l    dat_071_0027D                   ; 028BE
	dc.b	$61,$00,$0B,$9E,$33,$FC,$00,$03
        dc.l    dat_071_004A6                   ; 028CA
	dc.b	$41,$FA,$00,$0A,$23,$C8
        dc.l    dat_002_00004                   ; 028D4
	dc.b	$4E,$75,$4E,$56,$FF,$FE,$30,$39
        dc.l    dat_071_004A6                   ; 028E0
	dc.b	$4A,$40,$6A,$00,$01,$3E,$10,$39
        dc.l    dat_071_00276                   ; 028EC
	dc.b	$48,$80,$12,$39
        dc.l    dat_071_0027C                   ; 028F4
	dc.b	$3D,$40,$FF,$FE,$4A,$01,$6F,$00,$00,$DA,$41,$FA,$01,$4C,$23,$C8
        dc.l    dat_002_00004                   ; 02908
	dc.b	$0C,$40,$00,$03,$65,$4A,$0C,$40,$00,$08,$62,$44,$33,$FC,$00,$5D
        dc.l    dat_071_0011A                   ; 0291C
	dc.b	$72,$00,$32,$2E,$FF,$FE,$70,$03,$2F,$00,$70,$01,$2F,$00,$2F,$01
	dc.b	$4E,$B9
        dc.l    sub_020_001F4                   ; 02932
	dc.b	$4F,$EF,$00,$0C,$20,$79
        dc.l    dat_002_0296C                   ; 0293C
	dc.b	$30,$28,$00,$36,$52,$40,$20,$79
        dc.l    dat_002_0296C                   ; 02948
	dc.b	$31,$40,$00,$36,$13,$FC,$00,$01
        dc.l    dat_071_00195                   ; 02954
	dc.b	$60,$00,$00,$CC,$70,$00,$30,$2E,$FF,$FE,$72,$20,$04,$81,$00,$00
	dc.b	$00,$08,$6B,$00,$00,$BA,$B0,$BB,$18,$08,$66,$F0,$4E,$FB,$18,$06
	dc.b	$00,$00,$00,$09,$60,$00,$00,$40,$00,$00,$00,$7D,$60,$00,$00,$2C
	dc.b	$00,$00,$00,$02,$60,$00,$00,$18,$00,$00,$00,$01,$60,$00,$00,$02
	dc.b	$41,$FA,$01,$26,$23,$C8
        dc.l    dat_002_00004                   ; 0299E
	dc.b	$60,$00,$00,$82,$41,$FA,$FA,$80,$23,$C8
        dc.l    dat_002_00004                   ; 029AC
	dc.b	$60,$74,$41,$FA,$FA,$74,$23,$C8
        dc.l    dat_002_00004                   ; 029B8
	dc.b	$60,$68,$13,$FC,$00,$01
        dc.l    dat_071_00165                   ; 029C2
	dc.b	$33,$FC,$00,$03
        dc.l    dat_071_004A6                   ; 029CA
	dc.b	$41,$FA,$F2,$F0,$23,$C8
        dc.l    dat_002_00004                   ; 029D4
	dc.b	$60,$4C,$10,$39
        dc.l    dat_071_0027C                   ; 029DC
	dc.b	$4A,$00,$6A,$42,$42,$39
        dc.l    dat_071_0027C                   ; 029E6
	dc.b	$13,$FC,$00,$01
        dc.l    dat_071_00165                   ; 029EE
	dc.b	$61,$00,$0A,$6E,$33,$FC,$00,$03
        dc.l    dat_071_004A6                   ; 029FA
	dc.b	$10,$39
        dc.l    dat_071_00268                   ; 02A00
	dc.b	$53,$00,$13,$C0
        dc.l    dat_071_00268                   ; 02A08
	dc.b	$4A,$00,$6B,$0C,$41,$FA,$FD,$B6,$23,$C8
        dc.l    dat_002_00004                   ; 02A16
	dc.b	$60,$0A,$41,$FA,$00,$0C,$23,$C8
        dc.l    dat_002_00004                   ; 02A22
	dc.b	'N^Nu09'
        dc.l    dat_071_004A6                   ; 02A2C
	dc.b	$4A,$40,$6A,$18,$42,$39
        dc.l    dat_071_00165                   ; 02A36
	dc.b	$33,$FC,$00,$43
        dc.l    dat_071_0011A                   ; 02A3E
	dc.b	$41,$FA,$00,$0A,$23,$C8
        dc.l    dat_002_00004                   ; 02A48
	dc.b	$4E,$75,$4E,$75,$10,$39
        dc.l    dat_071_00173                   ; 02A52
	dc.b	$55,$00,$66,$06,$61,$00,$02,$A2,$60,$30,$10,$39
        dc.l    dat_071_001B0                   ; 02A62
	dc.b	$4A,$00,$6A,$26,$13,$FC,$00,$01
        dc.l    dat_071_00165                   ; 02A6E
	dc.b	$61,$00,$09,$EE,$13,$FC,$00,$01
        dc.l    dat_071_00227                   ; 02A7A
	dc.b	$33,$FC,$00,$03
        dc.l    dat_071_004A6                   ; 02A82
	dc.b	$41,$FA,$00,$0A,$23,$C8
        dc.l    dat_002_00004                   ; 02A8C
	dc.b	$4E,$75,$10,$39
        dc.l    dat_071_00173                   ; 02A94
	dc.b	$55,$00,$66,$06,$61,$00,$02,$60,$60,$1C,$30,$39
        dc.l    dat_071_004A6                   ; 02AA4
	dc.b	$4A,$40,$6A,$12,$13,$FC,$00,$01
        dc.l    dat_071_00185                   ; 02AB0
	dc.b	$41,$FA,$00,$0A,$23,$C8
        dc.l    dat_002_00004                   ; 02ABA
	dc.b	$4E,$75,$10,$39
        dc.l    dat_071_00173                   ; 02AC2
	dc.b	$55,$00,$66,$06,$61,$00,$02,$32,$60,$2A,$10,$39
        dc.l    dat_071_0027E                   ; 02AD2
	dc.b	$59,$00,$66,$20,$70,$00,$13,$C0
        dc.l    dat_071_00185                   ; 02ADE
	dc.b	$13,$C0
        dc.l    dat_071_00227                   ; 02AE4
	dc.b	$33,$FC,$00,$02
        dc.l    dat_071_004A6                   ; 02AEC
	dc.b	$41,$FA,$00,$0A,$23,$C8
        dc.l    dat_002_00004                   ; 02AF6
	dc.b	$4E,$75,$10,$39
        dc.l    dat_071_00173                   ; 02AFE
	dc.b	$55,$00,$66,$06,$61,$00,$01,$F6,$60,$66,$30,$39
        dc.l    dat_071_004A6                   ; 02B0E
	dc.b	$4A,$40,$6A,$5C,$42,$39
        dc.l    dat_071_00165                   ; 02B18
	dc.b	$10,$39
        dc.l    dat_071_00276                   ; 02B1E
	dc.b	$0C,$00,$00,$01,$6F,$08,$13,$FC,$00,$01
        dc.l    dat_071_00185                   ; 02B2C
	dc.b	$10,$39
        dc.l    dat_071_00276                   ; 02B32
	dc.b	$48,$80,$48,$C0,$0C,$80,$00,$00,$00,$01,$66,$18,$33,$FC,$00,$07
        dc.l    dat_071_0011A                   ; 02B46
	dc.b	$13,$FC,$00,$05
        dc.l    dat_071_0027E                   ; 02B4E
	dc.b	$13,$FC,$00,$01
        dc.l    dat_071_00227                   ; 02B56
	dc.b	$70,$00,$13,$C0
        dc.l    dat_071_0027D                   ; 02B5E
	dc.b	$13,$C0
        dc.l    dat_071_00193                   ; 02B64
	dc.b	$41,$FA,$00,$0A,$23,$C8
        dc.l    dat_002_00004                   ; 02B6E
	dc.b	$4E,$75,$10,$39
        dc.l    dat_071_00173                   ; 02B76
	dc.b	$55,$00,$66,$06,$61,$00,$01,$7E,$60,$7C,$4A,$39
        dc.l    dat_071_00185                   ; 02B86
	dc.b	$67,$62,$42,$39
        dc.l    dat_071_00185                   ; 02B8E
	dc.b	$61,$00,$08,$CE,$70,$00,$13,$C0
        dc.l    dat_071_0017D                   ; 02B9A
	dc.b	$70,$03,$13,$C0
        dc.l    dat_071_00206                   ; 02BA2
	dc.b	$70,$01,$13,$C0
        dc.l    dat_071_00165                   ; 02BAA
	dc.b	$33,$FC,$00,$02
        dc.l    dat_071_004A6                   ; 02BB2
	dc.b	$10,$39
        dc.l    dat_071_00218                   ; 02BB8
	dc.b	$57,$00,$67,$22,$41,$FA,$00,$40,$23,$C8
        dc.l    dat_002_00004                   ; 02BC6
	dc.b	$13,$FC,$00,$01
        dc.l    dat_071_00161                   ; 02BCE
	dc.b	$42,$39
        dc.l    dat_071_00227                   ; 02BD4
	dc.b	$13,$FC,$00,$06
        dc.l    dat_071_0027E                   ; 02BDC
	dc.b	$60,$1E,$41,$FA,$00,$8A,$23,$C8
        dc.l    dat_002_00004                   ; 02BE8
	dc.b	$60,$12,$10,$39
        dc.l    dat_071_001B0                   ; 02BF0
	dc.b	$53,$00,$66,$08,$13,$FC,$00,$01
        dc.l    dat_071_00165                   ; 02BFC
	dc.b	$4E,$75,$70,$00,$13,$C0
        dc.l    dat_071_00185                   ; 02C06
	dc.b	$30,$39
        dc.l    dat_071_004A6                   ; 02C0C
	dc.b	$4A,$40,$6A,$20,$70,$00,$13,$C0
        dc.l    dat_071_00165                   ; 02C18
	dc.b	$33,$FC,$00,$4B
        dc.l    dat_071_0011A                   ; 02C20
	dc.b	$13,$C0
        dc.l    dat_071_00193                   ; 02C26
	dc.b	$41,$FA,$00,$0A,$23,$C8
        dc.l    dat_002_00004                   ; 02C30
	dc.b	$4E,$75,$10,$39
        dc.l    dat_071_00161                   ; 02C38
	dc.b	$4A,$00,$66,$2C,$33,$FC,$00,$02
        dc.l    dat_071_004A6                   ; 02C44
	dc.b	$13,$FC,$00,$01
        dc.l    dat_071_00165                   ; 02C4C
	dc.b	$61,$00,$08,$10,$70,$01,$13,$C0
        dc.l    dat_071_00227                   ; 02C58
	dc.b	$13,$C0
        dc.l    dat_071_0027D                   ; 02C5E
	dc.b	$41,$FA,$00,$0A,$23,$C8
        dc.l    dat_002_00004                   ; 02C68
	dc.b	$4E,$75,$30,$39
        dc.l    dat_071_004A6                   ; 02C70
	dc.b	$4A,$40,$6A,$66,$13,$FC,$00,$01
        dc.l    dat_071_00185                   ; 02C7C
	dc.b	$61,$5E,$4E,$B9
        dc.l    sub_004_002DA                   ; 02C84
	dc.b	$70,$00,$13,$C0
        dc.l    dat_071_00186                   ; 02C8C
	dc.b	$13,$FC,$00,$06
        dc.l    dat_071_0027E                   ; 02C94
	dc.b	$13,$C0
        dc.l    dat_071_0027D                   ; 02C9A
	dc.b	$10,$39
        dc.l    dat_071_00276                   ; 02CA0
	dc.b	$0C,$00,$00,$03,$6D,$2A,$0C,$00,$00,$08,$6E,$24,$08,$39,$00,$04
        dc.l    dat_071_0052B                   ; 02CB4
	dc.b	$67,$0E,$70,$08,$2F,$00,$4E,$B9
        dc.l    sub_000_09F9A                   ; 02CC0
	dc.b	$58,$8F,$60,$0C,$70,$08,$2F,$00,$4E,$B9
        dc.l    sub_000_09E46                   ; 02CCE
	dc.b	$58,$8F,$41,$FA,$00,$82,$23,$C8
        dc.l    dat_002_00004                   ; 02CDA
	dc.b	$4E,$75,$4E,$B9
        dc.l    sub_004_003AE                   ; 02CE2
	dc.b	$30,$39
        dc.l    dat_071_0029C                   ; 02CE8
	dc.b	$00,$40,$08,$00,$33,$C0
        dc.l    dat_071_0029C                   ; 02CF2
	dc.b	$4E,$B9
        dc.l    sub_017_00000                   ; 02CF8
	dc.b	$4E,$75,$13,$FC,$00,$01
        dc.l    dat_071_00165                   ; 02D02
	dc.b	$61,$D8,$13,$FC,$00,$FF
        dc.l    dat_071_00228                   ; 02D0C
	dc.b	$42,$39
        dc.l    dat_071_0027E                   ; 02D12
	dc.b	$61,$00,$07,$4A,$70,$00,$13,$C0
        dc.l    dat_071_0017E                   ; 02D1E
	dc.b	$13,$C0
        dc.l    dat_071_00185                   ; 02D24
	dc.b	$70,$01,$13,$C0
        dc.l    dat_071_00227                   ; 02D2C
	dc.b	$13,$C0
        dc.l    dat_071_00184                   ; 02D32
	dc.b	$70,$00,$13,$C0
        dc.l    dat_071_0027D                   ; 02D3A
	dc.b	$13,$C0
        dc.l    dat_071_00158                   ; 02D40
	dc.b	$33,$FC,$00,$05
        dc.l    dat_071_004A6                   ; 02D48
	dc.b	$41,$FA,$00,$6A,$23,$C8
        dc.l    dat_002_00004                   ; 02D52
	dc.b	$4E,$75
sub_000_02D58:
        move.b  (dat_071_00155).l,d0            ; 02D58
        tst.b   d0                              ; 02D5E
        bne.b   l_000_02D92                     ; 02D60
        move.b  #$1,(dat_071_00184).l           ; 02D62
        moveq   #$0,d0                          ; 02D6A
        move.b  d0,(dat_071_0027E).l            ; 02D6C
        move.b  d0,(dat_071_0027D).l            ; 02D72
        move.b  d0,(dat_071_00158).l            ; 02D78
        move.w  #$5,(dat_071_004A6).l           ; 02D7E
        lea.l   dat_000_02DB8(pc),a0            ; 02D86
        move.l  a0,(dat_002_00004).l            ; 02D8A
        bra.b   l_000_02DB6                     ; 02D90
l_000_02D92:
        move.b  (dat_071_0017E).l,d0            ; 02D92
        tst.b   d0                              ; 02D98
        bpl.b   l_000_02DB6                     ; 02D9A
        move.w  #$2,(dat_071_004A6).l           ; 02D9C
        move.b  #$a,(dat_071_00271).l           ; 02DA4
        move.l  #sub_000_03B76,(dat_002_00004).l; 02DAC
l_000_02DB6:
        rts                                     ; 02DB6
dat_000_02DB8:
	dc.b	$4E,$56,$FF,$FA,$30,$39
        dc.l    dat_071_004A6                   ; 02DBE
	dc.b	$4A,$40,$6A,$00,$00,$84,$10,$39
        dc.l    dat_071_00276                   ; 02DCA
	dc.b	$42,$39
        dc.l    dat_071_00165                   ; 02DD0
	dc.b	$2D,$7C
        dc.l    dat_071_0011A                   ; 02DD6
	dc.b	$FF,$FC,$1D,$40,$FF,$FB,$0C,$00,$00,$03,$6D,$1C,$0C,$00,$00,$08
	dc.b	$6E,$16,$4E,$B9
        dc.l    sub_020_002C0                   ; 02DEE
	dc.b	$4A,$80,$6B,$0C,$20,$6E,$FF,$FC,$30,$BC,$00,$58,$54,$AE,$FF,$FC
	dc.b	$0C,$2E,$00,$02,$FF,$FB,$67,$28,$10,$39
        dc.l    dat_071_00B58                   ; 02E0C
	dc.b	$08,$00,$00,$03,$67,$0E,$20,$6E,$FF,$FC,$30,$BC,$00,$5A,$54,$AE
	dc.b	$FF,$FC,$60,$16,$20,$6E,$FF,$FC,$30,$BC,$00,$59,$54,$AE,$FF,$FC
	dc.b	$60,$08,$13,$FC,$00,$FF
        dc.l    dat_071_001B0                   ; 02E36
	dc.b	$20,$6E,$FF,$FC,$42,$50,$41,$FA,$00,$0C,$23,$C8
        dc.l    dat_002_00004                   ; 02E46
	dc.b	$4E,$5E,$4E,$75,$10,$39
        dc.l    dat_071_001B0                   ; 02E50
	dc.b	$4A,$00,$6A,$00,$00,$80,$70,$01,$13,$C0
        dc.l    dat_071_00165                   ; 02E5E
	dc.b	$30,$39
        dc.l    dat_071_0029C                   ; 02E64
	dc.b	$00,$40,$00,$40,$33,$C0
        dc.l    dat_071_0029C                   ; 02E6E
	dc.b	$30,$39
        dc.l    dat_071_0029E                   ; 02E74
	dc.b	$00,$40,$01,$00,$33,$C0
        dc.l    dat_071_0029E                   ; 02E7E
	dc.b	$30,$39
        dc.l    dat_071_002A2                   ; 02E84
	dc.b	$00,$40,$00,$02,$33,$C0
        dc.l    dat_071_002A2                   ; 02E8E
	dc.b	$10,$39
        dc.l    dat_071_00276                   ; 02E94
	dc.b	$55,$00,$66,$08,$13,$FC,$00,$01
        dc.l    dat_071_00163                   ; 02EA0
	dc.b	$4E,$B9
        dc.l    sub_000_08E54                   ; 02EA6
	dc.b	$20,$39
        dc.l    dat_071_004C2                   ; 02EAC
	dc.b	$23,$C0
        dc.l    dat_071_002E4                   ; 02EB2
	dc.b	$23,$F9
        dc.l    dat_071_004C2                   ; 02EB8
        dc.l    dat_071_002DC                   ; 02EBC
	dc.b	$42,$79
        dc.l    dat_071_002AA                   ; 02EC2
	dc.b	$33,$FC,$00,$03
        dc.l    dat_071_004A6                   ; 02ECA
	dc.b	$41,$FA,$00,$0A,$23,$C8
        dc.l    dat_002_00004                   ; 02ED4
	dc.b	$4E,$75,$30,$39
        dc.l    dat_071_004A6                   ; 02EDC
	dc.b	$4A,$40,$6A,$18,$13,$FC,$00,$01
        dc.l    dat_071_00171                   ; 02EE8
	dc.b	$4E,$B9
        dc.l    l_039_01880                     ; 02EEE
	dc.b	$41,$FA,$00,$0A,$23,$C8
        dc.l    dat_002_00004                   ; 02EF8
	dc.b	$4E,$75
sub_000_02EFE:
        link.w  a6,#$fffe                       ; 02EFE
        move.b  (dat_071_00168).l,-$1(a6)       ; 02F02
        move.w  (dat_071_00B54).l,d0            ; 02F0A
        btst    #$9,d0                          ; 02F10
        beq.w   l_000_02FE6                     ; 02F14
        move.b  (dat_071_00BD0).l,d0            ; 02F18
        andi.b  #$f,d0                          ; 02F1E
        tst.b   d0                              ; 02F22
        bne.w   l_000_02FE6                     ; 02F24
        tst.b   (dat_071_0015C).l               ; 02F28
        beq.w   l_000_02FC4                     ; 02F2E
        movea.l (dat_002_0296C).l,a0            ; 02F32
        move.w  $10(a0),d0                      ; 02F38
        addq.w  #$1,d0                          ; 02F3C
        movea.l (dat_002_0296C).l,a0            ; 02F3E
        move.w  d0,$10(a0)                      ; 02F44
        moveq   #$1,d0                          ; 02F48
        move.b  d0,(dat_071_00195).l            ; 02F4A
        move.w  (dat_071_0029A).l,d0            ; 02F50
        andi.w  #$feff,d0                       ; 02F56
        move.w  d0,(dat_071_0029A).l            ; 02F5A
        move.w  (dat_071_0029C).l,d0            ; 02F60
        andi.w  #$ffbf,d0                       ; 02F66
        move.w  d0,(dat_071_0029C).l            ; 02F6A
        move.w  (dat_071_00B54).l,d0            ; 02F70
        andi.w  #$fdff,d0                       ; 02F76
        move.w  d0,(dat_071_00B54).l            ; 02F7A
        move.b  (dat_071_00155).l,d0            ; 02F80
        tst.b   d0                              ; 02F86
        bne.b   l_000_02FB6                     ; 02F88
        move.b  #$1,(dat_071_0026A).l           ; 02F8A
        clr.l   (dat_071_00B96).l               ; 02F92
        move.b  #$28,(dat_071_00269).l          ; 02F98
        jsr     (sub_000_015F6).l               ; 02FA0
        moveq   #$78,d0                         ; 02FA6
        move.l  d0,-(a7)                        ; 02FA8
        moveq   #$3f,d0                         ; 02FAA
        move.l  d0,-(a7)                        ; 02FAC
        jsr     (sub_000_0A0DC).l               ; 02FAE
        addq.l  #$8,a7                          ; 02FB4
l_000_02FB6:
        move.l  #sub_000_038D8,(dat_002_00004).l; 02FB6
        bra.w   l_000_03198                     ; 02FC0
l_000_02FC4:
        move.w  (dat_071_00B54).l,d0            ; 02FC4
        andi.w  #$fdff,d0                       ; 02FCA
        move.w  d0,(dat_071_00B54).l            ; 02FCE
        move.l  #$4021,-(a7)                    ; 02FD4
        jsr     (sub_000_03D00).l               ; 02FDA
        addq.l  #$4,a7                          ; 02FE0
        bra.w   l_000_03198                     ; 02FE2
l_000_02FE6:
        move.b  (dat_071_0017E).l,d0            ; 02FE6
        tst.b   d0                              ; 02FEC
        bpl.b   l_000_0301E                     ; 02FEE
        move.w  #$2,(dat_071_004A6).l           ; 02FF0
        move.b  #$a,(dat_071_00271).l           ; 02FF8
        jsr     (sub_000_08E54).l               ; 03000
        move.l  (dat_071_004C2).l,(dat_071_002D4).l; 03006
        move.l  #sub_000_03B76,(dat_002_00004).l; 03010
        bra.w   l_000_03198                     ; 0301A
l_000_0301E:
        move.b  -$1(a6),d0                      ; 0301E
        cmpi.b  #$ff,d0                         ; 03022
        bgt.w   l_000_03118                     ; 03026
        cmpi.b  #$fc,d0                         ; 0302A
        blt.w   l_000_03118                     ; 0302E
        tst.b   (dat_071_00193).l               ; 03032
        beq.w   l_000_03118                     ; 03038
        tst.b   (dat_071_001B0).l               ; 0303C
        beq.w   l_000_03118                     ; 03042
        cmpi.b  #$ff,d0                         ; 03046
        bne.b   l_000_03056                     ; 0304A
        move.b  #$1,(dat_071_00168).l           ; 0304C
        bra.b   l_000_03078                     ; 03054
l_000_03056:
        cmpi.b  #$fe,-$1(a6)                    ; 03056
        bne.b   l_000_03068                     ; 0305C
        move.b  #$2,(dat_071_00168).l           ; 0305E
        bra.b   l_000_03078                     ; 03066
l_000_03068:
        cmpi.b  #$fc,-$1(a6)                    ; 03068
        bne.b   l_000_03078                     ; 0306E
        move.b  #$4,(dat_071_00168).l           ; 03070
l_000_03078:
        move.b  #$1,(dat_071_00165).l           ; 03078
        bsr.w   sub_000_03462                   ; 03080
        moveq   #$0,d0                          ; 03084
        move.b  d0,(dat_071_0027D).l            ; 03086
        move.b  #$fe,(dat_071_00280).l          ; 0308C
        move.b  #$ff,(dat_071_00228).l          ; 03094
        move.b  d0,(dat_071_0017E).l            ; 0309C
        tst.w   (dat_071_002AC).l               ; 030A2
        beq.w   l_000_03198                     ; 030A8
        moveq   #$0,d0                          ; 030AC
        move.w  d0,(dat_071_002AC).l            ; 030AE
        move.w  d0,(dat_071_002AE).l            ; 030B4
        move.b  (dat_071_00204).l,d0            ; 030BA
        move.b  d0,(dat_071_00155).l            ; 030C0
        tst.b   d0                              ; 030C6
        beq.b   l_000_030DC                     ; 030C8
        move.w  #$32,(dat_071_00356).l          ; 030CA
        move.w  #$a7,(dat_071_00354).l          ; 030D2
        bra.b   l_000_030EA                     ; 030DA
l_000_030DC:
        clr.w   (dat_071_00356).l               ; 030DC
        move.w  #$90,(dat_071_00354).l          ; 030E2
l_000_030EA:
        clr.b   (dat_071_00177).l               ; 030EA
        move.w  (dat_071_00356).l,d0            ; 030F0
        asl.w   #$4,d0                          ; 030F6
        move.w  d0,(dat_071_00358).l            ; 030F8
        jsr     (sub_006_00008).l               ; 030FE
        move.b  (dat_071_0018E).l,d0            ; 03104
        andi.b  #$7f,d0                         ; 0310A
        move.b  d0,(dat_071_00282).l            ; 0310E
        bra.w   l_000_03198                     ; 03114
l_000_03118:
        move.b  (dat_071_001FA).l,d0            ; 03118
        cmpi.b  #$ff,d0                         ; 0311E
        bne.b   l_000_0313E                     ; 03122
        clr.b   (dat_071_001FA).l               ; 03124
        move.b  #$ff,(dat_071_001B0).l          ; 0312A
        move.l  #sub_000_03A4C,(dat_002_00004).l; 03132
        bra.b   l_000_03198                     ; 0313C
l_000_0313E:
        cmpi.b  #$f0,-$1(a6)                    ; 0313E
        bne.b   l_000_03152                     ; 03144
        move.l  #sub_000_03A4C,(dat_002_00004).l; 03146
        bra.b   l_000_03198                     ; 03150
l_000_03152:
        cmpi.b  #$ef,-$1(a6)                    ; 03152
        bne.b   l_000_03166                     ; 03158
        move.l  #sub_000_03AA8,(dat_002_00004).l; 0315A
        bra.b   l_000_03198                     ; 03164
l_000_03166:
        move.w  (dat_071_002AE).l,d0            ; 03166
        tst.w   d0                              ; 0316C
        bne.b   l_000_03190                     ; 0316E
        move.b  (dat_071_00155).l,d0            ; 03170
        tst.b   d0                              ; 03176
        bne.b   l_000_03190                     ; 03178
        move.b  (dat_071_00259).l,d0            ; 0317A
        cmpi.b  #$5,d0                          ; 03180
        ble.b   l_000_03190                     ; 03184
        move.b  #$2,(dat_071_00271).l           ; 03186
        bra.b   l_000_03198                     ; 0318E
l_000_03190:
        move.b  #$f,(dat_071_00271).l           ; 03190
l_000_03198:
        unlk    a6                              ; 03198
        rts                                     ; 0319A
dat_000_0319C:
	dc.b	$30,$39
        dc.l    dat_071_004A6                   ; 0319E
	dc.b	$4A,$40,$6A,$20,$70,$00,$13,$C0
        dc.l    dat_071_00165                   ; 031AA
	dc.b	$33,$FC,$00,$0E
        dc.l    dat_071_0011A                   ; 031B2
	dc.b	$13,$C0
        dc.l    dat_071_001B0                   ; 031B8
	dc.b	$23,$FC
        dc.l    sub_000_03A4C                   ; 031BE
        dc.l    dat_002_00004                   ; 031C2
	dc.b	$4E,$75
dat_000_031C8:
	dc.b	$30,$39
        dc.l    dat_071_004A6                   ; 031CA
	dc.b	$4A,$40,$6A,$20,$70,$01,$13,$C0
        dc.l    dat_071_0017E                   ; 031D6
	dc.b	$33,$FC,$00,$02
        dc.l    dat_071_004A6                   ; 031DE
	dc.b	$41,$FA,$00,$10,$23,$C8
        dc.l    dat_002_00004                   ; 031E8
	dc.b	$13,$C0
        dc.l    dat_071_0027D                   ; 031EE
	dc.b	$4E,$75,$4E,$56,$FF,$FA,$30,$39
        dc.l    dat_071_004A6                   ; 031FA
	dc.b	$4A,$40,$6A,$00,$02,$5C,$10,$39
        dc.l    dat_071_00276                   ; 03206
	dc.b	$48,$80,$2D,$7C
        dc.l    dat_071_0011A                   ; 0320E
	dc.b	$FF,$FA,$42,$39
        dc.l    dat_071_00165                   ; 03216
	dc.b	$41,$FA,$FC,$E2,$23,$C8
        dc.l    dat_002_00004                   ; 03220
	dc.b	$3D,$40,$FF,$FE,$61,$00,$02,$38,$10,$39
        dc.l    dat_071_00168                   ; 0322E
	dc.b	$0C,$00,$00,$FF,$66,$00,$00,$D2,$30,$2E,$FF,$FE,$0C,$40,$00,$03
	dc.b	$65,$4C,$0C,$40,$00,$08,$62,$46,$72,$00,$32,$2E,$FF,$FE,$70,$04
	dc.b	$2F,$00,$42,$A7,$2F,$01,$4E,$B9
        dc.l    sub_020_001F4                   ; 0325A
	dc.b	$4F,$EF,$00,$0C,$20,$6E,$FF,$FA,$54,$88,$2D,$48,$FF,$FA,$0C,$6E
	dc.b	$00,$03,$FF,$FE,$66,$0C,$30,$BC,$80,$55,$54,$AE,$FF,$FA,$60,$00
	dc.b	$01,$AE,$20,$6E,$FF,$FA,$30,$BC,$80,$56,$54,$AE,$FF,$FA,$60,$00
	dc.b	$01,$9E,$10,$39
        dc.l    dat_071_00276                   ; 03292
	dc.b	$48,$80,$48,$C0,$0C,$80,$00,$00,$00,$09,$67,$20,$0C,$80,$00,$00
	dc.b	$00,$7D,$66,$50,$20,$6E,$FF,$FA,$30,$BC,$00,$48,$54,$AE,$FF,$FA
	dc.b	$13,$FC,$00,$F0
        dc.l    dat_071_00168                   ; 032BA
	dc.b	$60,$00,$01,$6C,$20,$79
        dc.l    dat_002_0296C                   ; 032C4
	dc.b	$30,$BC,$00,$01,$4E,$B9
        dc.l    sub_000_0858A                   ; 032CE
	dc.b	$20,$6E,$FF,$FA,$30,$BC,$00,$4A,$54,$88,$30,$BC,$80,$53,$54,$88
	dc.b	$13,$FC,$00,$01
        dc.l    dat_071_001FB                   ; 032E6
	dc.b	$13,$FC,$00,$EF
        dc.l    dat_071_00168                   ; 032EE
	dc.b	$2D,$48,$FF,$FA,$60,$00,$01,$34,$20,$6E,$FF,$FA,$30,$BC,$00,$41
	dc.b	$54,$AE,$FF,$FA,$60,$00,$01,$24,$10,$39
        dc.l    dat_071_00168                   ; 0330C
	dc.b	$0C,$00,$00,$FE,$66,$00,$00,$E4,$10,$39
        dc.l    dat_071_00276                   ; 0331A
	dc.b	$48,$80,$48,$C0,$04,$80,$00,$00,$00,$04,$6D,$00,$00,$A0,$0C,$80
	dc.b	$00,$00,$00,$04,$6C,$00,$00,$96,$E3,$80,$4E,$FB,$08,$02,$60,$06
	dc.b	'`,`@`L09'
        dc.l    dat_071_002AA                   ; 03346
	dc.b	$08,$00,$00,$00,$67,$0E,$20,$6E,$FF,$FA,$30,$BC,$00,$24,$54,$AE
	dc.b	$FF,$FA,$60,$78,$20,$6E,$FF,$FA,$30,$BC,$00,$25,$54,$AE,$FF,$FA
	dc.b	$60,$6A,$20,$6E,$FF,$FA,$30,$BC,$00,$2C,$54,$AE,$FF,$FA,$13,$FC
	dc.b	$00,$F0
        dc.l    dat_071_00168                   ; 0337C
	dc.b	$60,$54,$20,$6E,$FF,$FA,$30,$BC,$00,$33,$54,$AE,$FF,$FA,$60,$46
	dc.b	$20,$6E,$FF,$FA,$30,$BC,$00,$39,$54,$88,$30,$39
        dc.l    dat_071_002AA                   ; 0339C
	dc.b	$2D,$48,$FF,$FA,$08,$00,$00,$00,$67,$12,$30,$BC,$80,$3A,$54,$AE
	dc.b	$FF,$FA,$13,$FC,$00,$F0
        dc.l    dat_071_00168                   ; 033B6
	dc.b	$60,$1A,$20,$6E,$FF,$FA,$30,$BC,$80,$5C,$54,$AE,$FF,$FA,$60,$0C
	dc.b	$20,$6E,$FF,$FA,$30,$BC,$00,$42,$54,$AE,$FF,$FA,$10,$39
        dc.l    dat_071_00168                   ; 033D8
	dc.b	$0C,$00,$00,$F0,$67,$4A,$20,$6E,$FF,$FA,$54,$88,$30,$BC,$80,$56
	dc.b	$54,$88,$30,$BC,$80,$53,$54,$88,$2D,$48,$FF,$FA,$60,$32,$10,$39
        dc.l    dat_071_00168                   ; 033FC
	dc.b	$0C,$00,$00,$FD,$66,$26,$10,$39
        dc.l    dat_071_00276                   ; 03408
	dc.b	$48,$80,$48,$C0,$0C,$80,$00,$00,$00,$04,$66,$14,$20,$6E,$FF,$FA
	dc.b	$30,$BC,$00,$4C,$54,$AE,$FF,$FA,$13,$FC,$00,$F0
        dc.l    dat_071_00168                   ; 03428
	dc.b	$10,$39
        dc.l    dat_071_00168                   ; 0342E
	dc.b	$0C,$00,$00,$FC,$66,$20,$20,$6E,$FF,$FA,$30,$BC,$00,$54,$54,$88
	dc.b	$30,$BC,$80,$53,$54,$88,$2D,$48,$FF,$FA,$4E,$B9
        dc.l    sub_000_034A0                   ; 0344E
	dc.b	$4E,$B9
        dc.l    sub_000_0858A                   ; 03454
	dc.b	$20,$6E,$FF,$FA
	dc.b	'BPN^Nu'
sub_000_03462:
        link.w  a6,#$fffc                       ; 03462
        lea.l   (dat_071_0011A).l,a0            ; 03466
        moveq   #$0,d0                          ; 0346C
        move.w  d0,(a0)                         ; 0346E
        addq.l  #$2,a0                          ; 03470
        move.w  d0,(a0)                         ; 03472
        addq.l  #$2,a0                          ; 03474
        move.l  #$1b8,(dat_071_0010E).l         ; 03476
        moveq   #$0,d0                          ; 03480
        move.b  d0,(dat_071_00196).l            ; 03482
        move.b  d0,(dat_071_00193).l            ; 03488
        move.b  d0,(dat_071_001B0).l            ; 0348E
        move.b  d0,(dat_071_00241).l            ; 03494
        unlk    a6                              ; 0349A
        rts                                     ; 0349C
	dc.b	$00,$00
sub_000_034A0:
        link.w  a6,#$fffc                       ; 034A0
        move.b  (dat_071_00276).l,d0            ; 034A4
        ext.w   d0                              ; 034AA
        ext.l   d0                              ; 034AC
        movea.l (dat_002_0296C).l,a0            ; 034AE
        adda.w  #$12,a0                         ; 034B4
        adda.l  d0,a0                           ; 034B8
        move.l  a0,-$4(a6)                      ; 034BA
        jsr     (sub_004_00018).l               ; 034BE
        movea.l (dat_002_0296C).l,a0            ; 034C4
        move.b  (dat_071_00276).l,$6(a0)        ; 034CA
        movea.l -$4(a6),a0                      ; 034D2
        movea.l (dat_002_0296C).l,a1            ; 034D6
        move.b  (a0),$7(a1)                     ; 034DC
        movea.l (dat_002_0296C).l,a0            ; 034E0
        move.w  $38(a0),d0                      ; 034E6
        addq.w  #$1,d0                          ; 034EA
        movea.l (dat_002_0296C).l,a0            ; 034EC
        move.w  d0,$38(a0)                      ; 034F2
        move.b  (dat_071_00277).l,d0            ; 034F6
        addq.b  #$1,d0                          ; 034FC
        move.b  d0,(dat_071_00277).l            ; 034FE
        cmpi.b  #$3,d0                          ; 03504
        ble.b   l_000_03512                     ; 03508
        move.b  #$3,(dat_071_00277).l           ; 0350A
l_000_03512:
        movea.l -$4(a6),a0                      ; 03512
        move.b  (a0),d0                         ; 03516
        addq.b  #$1,d0                          ; 03518
        move.b  d0,(a0)                         ; 0351A
        cmpi.b  #$3,d0                          ; 0351C
        bls.b   l_000_03526                     ; 03520
        move.b  #$3,(a0)                        ; 03522
l_000_03526:
        move.b  (dat_071_00277).l,(dat_071_00278).l; 03526
        unlk    a6                              ; 03530
        rts                                     ; 03532
sub_000_03534:
        move.w  (dat_071_004A6).l,d0            ; 03534
        tst.w   d0                              ; 0353A
        bpl.b   l_000_03566                     ; 0353C
        pea.l   (dat_021_00000).l               ; 0353E
        bsr.w   sub_000_03C1C                   ; 03544
        addq.l  #$4,a7                          ; 03548
        move.w  #$61,(dat_071_0011A).l          ; 0354A
        move.w  #$1f4,(dat_071_004A6).l         ; 03552
        lea.l   dat_000_0356E(pc),a0            ; 0355A
        move.l  a0,(dat_002_00004).l            ; 0355E
        bra.b   l_000_0356C                     ; 03564
l_000_03566:
        jsr     (sub_036_00892).l               ; 03566
l_000_0356C:
        rts                                     ; 0356C
dat_000_0356E:
	dc.b	$10,$39
        dc.l    dat_071_001B0                   ; 03570
	dc.b	$4A,$00,$6A,$1C,$30,$39
        dc.l    dat_071_004A6                   ; 0357A
	dc.b	$4A,$40,$6A,$12,$33,$FC,$00,$03
        dc.l    dat_071_004A6                   ; 03586
	dc.b	$41,$FA,$FF,$E2,$23,$C8
        dc.l    dat_002_00004                   ; 03590
	dc.b	$4E,$75
sub_000_03596:
        move.w  (dat_071_004A6).l,d0            ; 03596
        tst.w   d0                              ; 0359C
        bpl.b   l_000_035C0                     ; 0359E
        pea.l   (dat_021_00000).l               ; 035A0
        bsr.w   sub_000_03C1C                   ; 035A6
        addq.l  #$4,a7                          ; 035AA
        move.w  #$f,(dat_071_0011A).l           ; 035AC
        lea.l   dat_000_035C8(pc),a0            ; 035B4
        move.l  a0,(dat_002_00004).l            ; 035B8
        bra.b   l_000_035C6                     ; 035BE
l_000_035C0:
        jsr     (sub_036_00892).l               ; 035C0
l_000_035C6:
        rts                                     ; 035C6
dat_000_035C8:
	dc.b	$4A,$39
        dc.l    dat_071_00173                   ; 035CA
	dc.b	$67,$50,$23,$FC,$00,$1F,$00,$00
        dc.l    dat_071_00038                   ; 035D6
	dc.b	$13,$FC,$00,$01
        dc.l    dat_071_001A7                   ; 035DE
	dc.b	$48,$79
        dc.l    dat_021_00080                   ; 035E4
	dc.b	$61,$00,$06,$32,$58,$8F,$4E,$B9
        dc.l    sub_000_03462                   ; 035F0
	dc.b	$4E,$B9
        dc.l    sub_036_00892                   ; 035F6
	dc.b	$13,$FC,$00,$01
        dc.l    dat_071_001A3                   ; 035FE
	dc.b	$33,$FC,$00,$05
        dc.l    dat_071_004A6                   ; 03606
	dc.b	$42,$39
        dc.l    dat_071_00276                   ; 0360C
	dc.b	$4E,$B9
        dc.l    sub_000_08434                   ; 03612
	dc.b	$41,$FA,$00,$0A,$23,$C8
        dc.l    dat_002_00004                   ; 0361C
	dc.b	$4E,$75
sub_000_03622:
        link.w  a6,#$fffc                       ; 03622
        jsr     (sub_036_00892).l               ; 03626
        move.w  #$5,(dat_071_004A6).l           ; 0362C
        move.b  (dat_071_001A3).l,d0            ; 03634
        tst.b   d0                              ; 0363A
        bne.b   l_000_0365A                     ; 0363C
        jsr     (sub_000_08434).l               ; 0363E
        move.b  #$ff,(dat_071_001A5).l          ; 03644
        lea.l   dat_000_0370A(pc),a0            ; 0364C
        move.l  a0,(dat_002_00004).l            ; 03650
        bra.w   l_000_036EA                     ; 03656
l_000_0365A:
        move.w  (dat_071_002F8).l,d0            ; 0365A
        tst.w   d0                              ; 03660
        bne.b   l_000_03676                     ; 03662
        clr.b   (dat_071_001A3).l               ; 03664
        lea.l   dat_000_0370A(pc),a0            ; 0366A
        move.l  a0,(dat_002_00004).l            ; 0366E
        bra.b   l_000_036EA                     ; 03674
l_000_03676:
        pea.l   (dat_021_00000).l               ; 03676
        bsr.w   sub_000_03C1C                   ; 0367C
        addq.l  #$4,a7                          ; 03680
        lea.l   (dat_071_0011A).l,a0            ; 03682
        move.w  (dat_071_002F8).l,d0            ; 03688
        move.l  a0,-$4(a6)                      ; 0368E
        subq.w  #$1,d0                          ; 03692
        bne.b   l_000_036A0                     ; 03694
        move.w  #$44,(a0)                       ; 03696
        addq.l  #$2,-$4(a6)                     ; 0369A
        bra.b   l_000_036CE                     ; 0369E
l_000_036A0:
        move.w  (dat_071_002F8).l,d0            ; 036A0
        subq.w  #$2,d0                          ; 036A6
        bne.b   l_000_036B8                     ; 036A8
        movea.l -$4(a6),a0                      ; 036AA
        move.w  #$45,(a0)                       ; 036AE
        addq.l  #$2,-$4(a6)                     ; 036B2
        bra.b   l_000_036CE                     ; 036B6
l_000_036B8:
        move.w  (dat_071_002F8).l,d0            ; 036B8
        subq.w  #$3,d0                          ; 036BE
        bne.b   l_000_036CE                     ; 036C0
        movea.l -$4(a6),a0                      ; 036C2
        move.w  #$46,(a0)                       ; 036C6
        addq.l  #$2,-$4(a6)                     ; 036CA
l_000_036CE:
        movea.l -$4(a6),a0                      ; 036CE
        move.w  #$5e,(a0)                       ; 036D2
        addq.l  #$2,-$4(a6)                     ; 036D6
        movea.l -$4(a6),a0                      ; 036DA
        clr.w   (a0)                            ; 036DE
        lea.l   dat_000_036EE(pc),a0            ; 036E0
        move.l  a0,(dat_002_00004).l            ; 036E4
l_000_036EA:
        unlk    a6                              ; 036EA
        rts                                     ; 036EC
dat_000_036EE:
	dc.b	$10,$39
        dc.l    dat_071_001A3                   ; 036F0
	dc.b	$4A,$00,$66,$10,$4E,$B9
        dc.l    sub_036_00892                   ; 036FA
	dc.b	$41,$FA,$FF,$22,$23,$C8
        dc.l    dat_002_00004                   ; 03704
	dc.b	$4E,$75
dat_000_0370A:
	dc.b	$4E,$56,$FF,$F6,$30,$39
        dc.l    dat_071_002F8                   ; 03710
	dc.b	$4A,$40,$66,$00,$00,$BE,$30,$39
        dc.l    dat_071_004A6                   ; 0371C
	dc.b	$4A,$40,$6A,$00,$00,$AA,$13,$FC,$00,$01
        dc.l    dat_071_0027D                   ; 0372A
	dc.b	$48,$79
        dc.l    dat_021_00000                   ; 03730
	dc.b	$61,$00,$04,$E6,$58,$8F,$70,$00,$13,$C0
        dc.l    dat_071_001B0                   ; 0373E
	dc.b	$13,$C0
        dc.l    dat_071_00193                   ; 03744
	dc.b	$20,$79
        dc.l    dat_002_0296C                   ; 0374A
	dc.b	$30,$28,$00,$04,$0C,$40,$00,$00,$62,$14,$33,$FC,$00,$01
        dc.l    dat_071_0011A                   ; 0375C
	dc.b	$41,$FA,$00,$88,$23,$C8
        dc.l    dat_002_00004                   ; 03766
	dc.b	$60,$7A,$33,$FC,$00,$02
        dc.l    dat_071_0011A                   ; 03770
	dc.b	$41,$F9
        dc.l    dat_064_004E3                   ; 03776
	dc.b	$2D,$48,$FF,$FA,$D0,$FC,$00,$0A,$22,$79
        dc.l    dat_002_0296C                   ; 03784
	dc.b	$D2,$FC,$00,$1E,$42,$6E,$FF,$FE,$2D,$48,$FF,$FA,$2D,$49,$FF,$F6
	dc.b	$0C,$6E,$00,$18,$FF,$FE,$6C,$22,$20,$6E,$FF,$F6,$10,$10,$4A,$00
	dc.b	$67,$18,$20,$6E,$FF,$F6,$22,$6E,$FF,$FA,$12,$90,$52,$AE,$FF,$F6
	dc.b	$52,$AE,$FF,$FA,$52,$6E,$FF,$FE,$60,$D6,$41,$FA,$00,$3C,$23,$C8
        dc.l    dat_002_00004                   ; 037C8
	dc.b	$60,$18,$4E,$B9
        dc.l    sub_036_00892                   ; 037D0
	dc.b	$60,$10,$4E,$B9
        dc.l    sub_000_03462                   ; 037D8
	dc.b	$23,$FC
        dc.l    sub_000_01D30                   ; 037DE
        dc.l    dat_002_00004                   ; 037E2
	dc.b	$4E,$5E,$4E,$75,$10,$39
        dc.l    dat_071_001B0                   ; 037EC
	dc.b	$4A,$00,$6A,$0A,$41,$FA,$00,$28,$23,$C8
        dc.l    dat_002_00004                   ; 037FA
	dc.b	$4E,$75,$10,$39
        dc.l    dat_071_001B0                   ; 03802
	dc.b	$4A,$00,$6B,$08,$4A,$39
        dc.l    dat_071_00173                   ; 0380C
	dc.b	$67,$0A,$41,$FA,$00,$0A,$23,$C8
        dc.l    dat_002_00004                   ; 03818
	dc.b	$4E,$75,$4E,$B9
        dc.l    sub_000_03462                   ; 03820
	dc.b	$33,$FC,$00,$05
        dc.l    dat_071_004A6                   ; 03828
	dc.b	$20,$79
        dc.l    dat_002_0296C                   ; 0382E
	dc.b	$30,$28,$00,$04,$0C,$40,$00,$00,$62,$2A,$33,$FC,$00,$03
        dc.l    dat_071_0011A                   ; 03840
	dc.b	$42,$39
        dc.l    dat_071_00193                   ; 03846
	dc.b	$13,$FC,$00,$02
        dc.l    dat_071_001B0                   ; 0384E
	dc.b	$13,$FC,$00,$14
        dc.l    dat_071_001C5                   ; 03856
	dc.b	$41,$FA,$00,$2C,$23,$C8
        dc.l    dat_002_00004                   ; 03860
	dc.b	$60,$0A,$23,$FC
        dc.l    sub_000_01D30                   ; 03868
        dc.l    dat_002_00004                   ; 0386C
	dc.b	$20,$79
        dc.l    dat_002_0296C                   ; 03872
	dc.b	$30,$28,$00,$04,$52,$40,$20,$79
        dc.l    dat_002_0296C                   ; 0387E
	dc.b	$31,$40,$00,$04,$4E,$75,$10,$39
        dc.l    dat_071_001B0                   ; 0388A
	dc.b	$4A,$00,$6A,$18,$4E,$B9
        dc.l    sub_000_03462                   ; 03894
	dc.b	$33,$FC,$00,$05
        dc.l    dat_071_004A6                   ; 0389C
	dc.b	$23,$FC
        dc.l    sub_000_01D30                   ; 038A2
        dc.l    dat_002_00004                   ; 038A6
	dc.b	$4E,$75,$30,$39
        dc.l    dat_071_004A6                   ; 038AE
	dc.b	$4A,$40,$6A,$12,$42,$79
        dc.l    dat_071_002AA                   ; 038B8
	dc.b	$23,$FC
        dc.l    sub_000_02EFE                   ; 038BE
        dc.l    dat_002_00004                   ; 038C2
	dc.b	$60,$0E,$13,$FC,$00,$01
        dc.l    dat_071_00165                   ; 038CC
	dc.b	$4E,$B9
        dc.l    sub_000_03462                   ; 038D2
	dc.b	$4E,$75
sub_000_038D8:
        move.b  (dat_071_00155).l,d0            ; 038D8
        tst.b   d0                              ; 038DE
        bne.b   l_000_038EC                     ; 038E0
        move.b  (dat_071_00269).l,d0            ; 038E2
        tst.b   d0                              ; 038E8
        beq.b   l_000_03902                     ; 038EA
l_000_038EC:
        tst.b   (dat_071_00155).l               ; 038EC
        beq.w   l_000_0397E                     ; 038F2
        move.w  (dat_071_00B54).l,d0            ; 038F6
        btst    #$a,d0                          ; 038FC
        bne.b   l_000_0397E                     ; 03900
l_000_03902:
        move.w  (dat_071_0029C).l,d0            ; 03902
        andi.w  #$9fff,d0                       ; 03908
        move.w  d0,(dat_071_0029C).l            ; 0390C
        andi.w  #$fffe,d0                       ; 03912
        move.w  d0,(dat_071_0029C).l            ; 03916
        jsr     (sub_004_003E8).l               ; 0391C
        move.b  #$f,(dat_071_00271).l           ; 03922
        moveq   #$0,d0                          ; 0392A
        move.b  d0,(dat_071_00259).l            ; 0392C
        move.w  (dat_071_002A4).l,d0            ; 03932
        andi.w  #$fbff,d0                       ; 03938
        move.w  d0,(dat_071_002A4).l            ; 0393C
        move.b  (dat_071_00267).l,d0            ; 03942
        subq.b  #$1,d0                          ; 03948
        move.b  d0,(dat_071_00267).l            ; 0394A
        tst.b   d0                              ; 03950
        bgt.b   l_000_03974                     ; 03952
        jsr     (sub_036_00892).l               ; 03954
        move.w  #$5,(dat_071_004A6).l           ; 0395A
        clr.b   (dat_071_00165).l               ; 03962
        lea.l   dat_000_039F0(pc),a0            ; 03968
        move.l  a0,(dat_002_00004).l            ; 0396C
        bra.b   l_000_0397E                     ; 03972
l_000_03974:
        lea.l   dat_000_03980(pc),a0            ; 03974
        move.l  a0,(dat_002_00004).l            ; 03978
l_000_0397E:
        rts                                     ; 0397E
dat_000_03980:
	dc.b	$70,$00,$13,$C0
        dc.l    dat_071_0026A                   ; 03984
	dc.b	$30,$39
        dc.l    dat_071_00B56                   ; 0398A
	dc.b	$00,$40,$00,$02,$33,$C0
        dc.l    dat_071_00B56                   ; 03994
	dc.b	$10,$39
        dc.l    dat_071_00155                   ; 0399A
	dc.b	$4A,$00,$66,$06,$4E,$B9
        dc.l    sub_005_00CEE                   ; 039A4
	dc.b	$4E,$B9
        dc.l    sub_004_003E8                   ; 039AA
	dc.b	$33,$FC,$00,$05
        dc.l    dat_071_004A6                   ; 039B2
	dc.b	$41,$FA,$00,$0A,$23,$C8
        dc.l    dat_002_00004                   ; 039BC
	dc.b	$4E,$75,$30,$39
        dc.l    dat_071_004A6                   ; 039C4
	dc.b	'J@j"09'
        dc.l    dat_071_0029C                   ; 039CE
	dc.b	$00,$40,$00,$40,$33,$C0
        dc.l    dat_071_0029C                   ; 039D8
	dc.b	$13,$FC,$00,$FE
        dc.l    dat_071_00280                   ; 039E0
	dc.b	$23,$FC
        dc.l    sub_000_02EFE                   ; 039E6
        dc.l    dat_002_00004                   ; 039EA
	dc.b	$4E,$75
dat_000_039F0:
	dc.b	$30,$39
        dc.l    dat_071_004A6                   ; 039F2
	dc.b	'J@j:Hy'
        dc.l    dat_021_00000                   ; 039FC
	dc.b	$61,$00,$02,$1A,$58,$8F,$10,$39
        dc.l    dat_071_00219                   ; 03A08
	dc.b	$0C,$00,$00,$10,$66,$0A,$33,$FC,$00,$62
        dc.l    dat_071_0011A                   ; 03A16
	dc.b	$60,$08,$33,$FC,$00,$63
        dc.l    dat_071_0011A                   ; 03A20
	dc.b	$42,$39
        dc.l    dat_071_001FB                   ; 03A26
	dc.b	$41,$FA,$00,$0A,$23,$C8
        dc.l    dat_002_00004                   ; 03A30
	dc.b	$4E,$75,$10,$39
        dc.l    dat_071_001B0                   ; 03A38
	dc.b	$4A,$00,$6A,$0A,$23,$FC
        dc.l    sub_000_01A70                   ; 03A42
        dc.l    dat_002_00004                   ; 03A46
	dc.b	$4E,$75
sub_000_03A4C:
        move.b  (dat_071_001B0).l,d0            ; 03A4C
        tst.b   d0                              ; 03A52
        bpl.b   l_000_03A82                     ; 03A54
        move.w  (dat_071_0029C).l,d0            ; 03A56
        andi.w  #$ffbf,d0                       ; 03A5C
        move.w  d0,(dat_071_0029C).l            ; 03A60
        andi.w  #$9fff,d0                       ; 03A66
        move.w  d0,(dat_071_0029C).l            ; 03A6A
        move.w  #$64,(dat_071_004A6).l          ; 03A70
        lea.l   dat_000_03A84(pc),a0            ; 03A78
        move.l  a0,(dat_002_00004).l            ; 03A7C
l_000_03A82:
        rts                                     ; 03A82
dat_000_03A84:
	dc.b	$30,$39
        dc.l    dat_071_004A6                   ; 03A86
	dc.b	$4A,$40,$6A,$18,$70,$00,$13,$C0
        dc.l    dat_071_001FA                   ; 03A92
	dc.b	$13,$C0
        dc.l    dat_071_00168                   ; 03A98
	dc.b	$23,$FC
        dc.l    sub_000_01A70                   ; 03A9E
        dc.l    dat_002_00004                   ; 03AA2
	dc.b	$4E,$75
sub_000_03AA8:
        move.b  (dat_071_001B0).l,d0            ; 03AA8
        tst.b   d0                              ; 03AAE
        bpl.b   l_000_03AE0                     ; 03AB0
        move.w  (dat_071_0029C).l,d0            ; 03AB2
        andi.w  #$ffbf,d0                       ; 03AB8
        move.w  d0,(dat_071_0029C).l            ; 03ABC
        andi.w  #$9fff,d0                       ; 03AC2
        move.w  d0,(dat_071_0029C).l            ; 03AC6
        move.w  #$64,(dat_071_004A6).l          ; 03ACC
        lea.l   dat_000_03B24(pc),a0            ; 03AD4
        move.l  a0,(dat_002_00004).l            ; 03AD8
        bra.b   l_000_03B22                     ; 03ADE
l_000_03AE0:
        move.b  (dat_071_001FA).l,d0            ; 03AE0
        cmpi.b  #$ff,d0                         ; 03AE6
        bne.b   l_000_03B06                     ; 03AEA
        moveq   #$0,d0                          ; 03AEC
        move.b  d0,(dat_071_001FA).l            ; 03AEE
        move.b  d0,(dat_071_001FB).l            ; 03AF4
        move.l  #sub_000_01A70,(dat_002_00004).l; 03AFA
        bra.b   l_000_03B22                     ; 03B04
l_000_03B06:
        move.b  (dat_071_001FA).l,d0            ; 03B06
        subq.b  #$1,d0                          ; 03B0C
        bne.b   l_000_03B22                     ; 03B0E
        move.w  #$ffff,(dat_071_004A6).l        ; 03B10
        lea.l   dat_000_03B24(pc),a0            ; 03B18
        move.l  a0,(dat_002_00004).l            ; 03B1C
l_000_03B22:
        rts                                     ; 03B22
dat_000_03B24:
	dc.b	$30,$39
        dc.l    dat_071_004A6                   ; 03B26
	dc.b	$4A,$40,$6A,$46,$70,$00,$13,$C0
        dc.l    dat_071_001FA                   ; 03B32
	dc.b	$13,$C0
        dc.l    dat_071_00168                   ; 03B38
	dc.b	$4A,$39
        dc.l    dat_071_0027C                   ; 03B3E
	dc.b	$67,$08,$13,$FC,$00,$01
        dc.l    dat_071_001FB                   ; 03B48
	dc.b	$13,$FC,$00,$01
        dc.l    dat_071_0017E                   ; 03B50
	dc.b	$33,$FC,$00,$03
        dc.l    dat_071_004A6                   ; 03B58
	dc.b	$70,$00,$13,$C0
        dc.l    dat_071_00165                   ; 03B60
	dc.b	$13,$C0
        dc.l    dat_071_00271                   ; 03B66
	dc.b	$23,$FC
        dc.l    sub_000_01A96                   ; 03B6C
        dc.l    dat_002_00004                   ; 03B70
	dc.b	$4E,$75
sub_000_03B76:
        clr.b   (dat_071_00165).l               ; 03B76
        move.b  (dat_071_00270).l,d0            ; 03B7C
        move.b  (dat_071_00271).l,d1            ; 03B82
        cmp.b   d1,d0                           ; 03B88
        bne.b   l_000_03B9E                     ; 03B8A
        move.w  #$26,(dat_071_0011A).l          ; 03B8C
        lea.l   dat_000_03BA0(pc),a0            ; 03B94
        move.l  a0,(dat_002_00004).l            ; 03B98
l_000_03B9E:
        rts                                     ; 03B9E
dat_000_03BA0:
	dc.b	$10,$39
        dc.l    dat_071_0017E                   ; 03BA2
	dc.b	$4A,$00,$6B,$70,$13,$FC,$00,$01
        dc.l    dat_071_00165                   ; 03BAE
	dc.b	$4E,$B9
        dc.l    sub_000_03462                   ; 03BB4
	dc.b	$13,$FC,$00,$0F
        dc.l    dat_071_00271                   ; 03BBC
	dc.b	$10,$39
        dc.l    dat_071_0027E                   ; 03BC2
	dc.b	$5D,$00,$66,$0C,$23,$FC
        dc.l    sub_000_02D58                   ; 03BCC
        dc.l    dat_002_00004                   ; 03BD0
	dc.b	$60,$44,$4E,$B9
        dc.l    sub_000_08E54                   ; 03BD8
	dc.b	$20,$39
        dc.l    dat_071_002D4                   ; 03BDE
	dc.b	$22,$39
        dc.l    dat_071_004C2                   ; 03BE4
	dc.b	$92,$80,$23,$C1
        dc.l    dat_071_002D4                   ; 03BEC
	dc.b	$D3,$B9
        dc.l    dat_071_002D8                   ; 03BF2
	dc.b	$4A,$B9
        dc.l    dat_071_002DC                   ; 03BF8
	dc.b	$67,$0C,$20,$39
        dc.l    dat_071_002D4                   ; 03C00
	dc.b	$D1,$B9
        dc.l    dat_071_002DC                   ; 03C06
	dc.b	$42,$B9
        dc.l    dat_071_002D4                   ; 03C0C
	dc.b	$23,$FC
        dc.l    sub_000_02EFE                   ; 03C12
        dc.l    dat_002_00004                   ; 03C16
	dc.b	$4E,$75
sub_000_03C1C:
        link.w  a6,#$fff6                       ; 03C1C
        move.l  $8(a6),-$6(a6)                  ; 03C20
        move.l  (dat_071_00030).l,-$a(a6)       ; 03C26
        clr.w   -$2(a6)                         ; 03C2E
l_000_03C32:
        cmpi.w  #$10,-$2(a6)                    ; 03C32
        bge.b   l_000_03C52                     ; 03C38
        movea.l -$6(a6),a0                      ; 03C3A
        movea.l -$a(a6),a1                      ; 03C3E
        move.l  (a0),(a1)                       ; 03C42
        addq.l  #$4,-$6(a6)                     ; 03C44
        addq.l  #$4,-$a(a6)                     ; 03C48
        addq.w  #$1,-$2(a6)                     ; 03C4C
        bra.b   l_000_03C32                     ; 03C50
l_000_03C52:
        move.b  #$2,(dat_071_00274).l           ; 03C52
        unlk    a6                              ; 03C5A
        rts                                     ; 03C5C
sub_000_03C5E:
        link.w  a6,#$fffa                       ; 03C5E
        move.b  #$2,(dat_071_00274).l           ; 03C62
        move.l  (dat_071_00030).l,-$6(a6)       ; 03C6A
        clr.w   -$2(a6)                         ; 03C72
l_000_03C76:
        cmpi.w  #$10,-$2(a6)                    ; 03C76
        bge.b   l_000_03C8E                     ; 03C7C
        movea.l -$6(a6),a0                      ; 03C7E
        clr.l   (a0)                            ; 03C82
        addq.l  #$4,-$6(a6)                     ; 03C84
        addq.w  #$1,-$2(a6)                     ; 03C88
        bra.b   l_000_03C76                     ; 03C8C
l_000_03C8E:
        unlk    a6                              ; 03C8E
        rts                                     ; 03C90
	dc.b	$00,$00
sub_000_03C94:
        move.b  (dat_071_00260).l,d0            ; 03C94
        subq.b  #$1,d0                          ; 03C9A
        move.b  d0,(dat_071_00260).l            ; 03C9C
        tst.b   d0                              ; 03CA2
        bgt.b   l_000_03CB8                     ; 03CA4
        move.b  #$8,(dat_071_00260).l           ; 03CA6
        move.b  #$86,(dat_071_0025E).l          ; 03CAE
        bra.b   l_000_03CFE                     ; 03CB6
l_000_03CB8:
        move.b  (dat_071_00260).l,d0            ; 03CB8
        subq.b  #$4,d0                          ; 03CBE
        bne.b   l_000_03CCC                     ; 03CC0
        move.b  #$6,(dat_071_0025E).l           ; 03CC2
        bra.b   l_000_03CFE                     ; 03CCA
l_000_03CCC:
        move.b  (dat_071_00260).l,d0            ; 03CCC
        andi.b  #$3,d0                          ; 03CD2
        subq.b  #$2,d0                          ; 03CD6
        bne.b   l_000_03CE4                     ; 03CD8
        move.b  #$4,(dat_071_0025E).l           ; 03CDA
        bra.b   l_000_03CFE                     ; 03CE2
l_000_03CE4:
        move.b  (dat_071_00260).l,d0            ; 03CE4
        cmpi.b  #$8,d0                          ; 03CEA
        ble.b   l_000_03CFE                     ; 03CEE
        move.b  #$8,(dat_071_00260).l           ; 03CF0
        clr.b   (dat_071_0025E).l               ; 03CF8
l_000_03CFE:
        rts                                     ; 03CFE
sub_000_03D00:
        link.w  a6,#$0                          ; 03D00
        move.w  (dat_071_0029C).l,d0            ; 03D04
        btst    #$8,d0                          ; 03D0A
        beq.b   l_000_03D48                     ; 03D0E
        move.w  $a(a6),d1                       ; 03D10
        move.w  d1,(dat_071_004B0).l            ; 03D14
        ori.w   #$1,d0                          ; 03D1A
        move.w  d0,(dat_071_0029C).l            ; 03D1E
        andi.w  #$ff00,d1                       ; 03D24
        move.w  d1,$a(a6)                       ; 03D28
        cmpi.w  #$4000,d1                       ; 03D2C
        beq.b   l_000_03D38                     ; 03D30
        cmpi.w  #$4800,d1                       ; 03D32
        bne.b   l_000_03D48                     ; 03D36
l_000_03D38:
        move.w  (dat_071_0029E).l,d0            ; 03D38
        andi.w  #$dfff,d0                       ; 03D3E
        move.w  d0,(dat_071_0029E).l            ; 03D42
l_000_03D48:
        unlk    a6                              ; 03D48
        rts                                     ; 03D4A
sub_000_03D4C:
        link.w  a6,#$fff4                       ; 03D4C
        clr.b   -$8(a6)                         ; 03D50
        move.w  (dat_071_004B0).l,d0            ; 03D54
        move.w  d0,-$4(a6)                      ; 03D5A
        andi.w  #$ff,d0                         ; 03D5E
        move.l  (dat_071_00520).l,-$c(a6)       ; 03D62
        move.w  (dat_071_0029C).l,d1            ; 03D6A
        move.w  d0,-$6(a6)                      ; 03D70
        btst    #$0,d1                          ; 03D74
        bne.w   l_000_03ECC                     ; 03D78
        move.w  (dat_071_00298).l,d0            ; 03D7C
        andi.w  #$8000,d0                       ; 03D82
        tst.w   d0                              ; 03D86
        beq.b   l_000_03D94                     ; 03D88
        move.w  #$9c06,-$4(a6)                  ; 03D8A
        bra.w   l_000_03EEA                     ; 03D90
l_000_03D94:
        move.w  (dat_071_002A6).l,d0            ; 03D94
        btst    #$5,d0                          ; 03D9A
        beq.b   l_000_03DAA                     ; 03D9E
        move.w  #$4000,-$4(a6)                  ; 03DA0
        bra.w   l_000_03EEA                     ; 03DA6
l_000_03DAA:
        tst.l   -$c(a6)                         ; 03DAA
        bne.b   l_000_03DBA                     ; 03DAE
        tst.b   (dat_071_0023E).l               ; 03DB0
        beq.w   l_000_03EAA                     ; 03DB6
l_000_03DBA:
        move.w  (dat_071_0029C).l,d0            ; 03DBA
        ori.w   #$80,d0                         ; 03DC0
        move.w  d0,(dat_071_0029C).l            ; 03DC4
        move.b  (dat_071_0023E).l,d0            ; 03DCA
        btst    #$4,d0                          ; 03DD0
        beq.b   l_000_03DE0                     ; 03DD4
        move.w  #$8010,-$4(a6)                  ; 03DD6
        bra.w   l_000_03EEA                     ; 03DDC
l_000_03DE0:
        move.b  (dat_071_0023E).l,d0            ; 03DE0
        btst    #$5,d0                          ; 03DE6
        beq.b   l_000_03DF6                     ; 03DEA
        move.w  #$8012,-$4(a6)                  ; 03DEC
        bra.w   l_000_03EEA                     ; 03DF2
l_000_03DF6:
        btst    #$6,-$9(a6)                     ; 03DF6
        beq.b   l_000_03E08                     ; 03DFC
        move.w  #$c004,-$4(a6)                  ; 03DFE
        bra.w   l_000_03EEA                     ; 03E04
l_000_03E08:
        btst    #$7,-$9(a6)                     ; 03E08
        beq.b   l_000_03E1A                     ; 03E0E
        move.w  #$c001,-$4(a6)                  ; 03E10
        bra.w   l_000_03EEA                     ; 03E16
l_000_03E1A:
        btst    #$1,-$9(a6)                     ; 03E1A
        beq.b   l_000_03E2C                     ; 03E20
        move.w  #$8002,-$4(a6)                  ; 03E22
        bra.w   l_000_03EEA                     ; 03E28
l_000_03E2C:
        move.b  (dat_071_0023E).l,d0            ; 03E2C
        btst    #$3,d0                          ; 03E32
        beq.b   l_000_03E52                     ; 03E36
        move.w  (dat_071_0029C).l,d0            ; 03E38
        andi.w  #$ff7f,d0                       ; 03E3E
        move.w  d0,(dat_071_0029C).l            ; 03E42
        move.w  #$8024,-$4(a6)                  ; 03E48
        bra.w   l_000_03EEA                     ; 03E4E
l_000_03E52:
        move.b  (dat_071_0023E).l,d0            ; 03E52
        btst    #$2,d0                          ; 03E58
        beq.b   l_000_03E76                     ; 03E5C
        move.w  (dat_071_0029C).l,d0            ; 03E5E
        andi.w  #$ff7f,d0                       ; 03E64
        move.w  d0,(dat_071_0029C).l            ; 03E68
        move.w  #$800e,-$4(a6)                  ; 03E6E
        bra.b   l_000_03EEA                     ; 03E74
l_000_03E76:
        btst    #$0,-$9(a6)                     ; 03E76
        beq.b   l_000_03E86                     ; 03E7C
        move.w  #$c09,-$4(a6)                   ; 03E7E
        bra.b   l_000_03EEA                     ; 03E84
l_000_03E86:
        move.b  (dat_071_0023E).l,d0            ; 03E86
        btst    #$1,d0                          ; 03E8C
        beq.b   l_000_03EEA                     ; 03E90
        move.w  (dat_071_0029C).l,d0            ; 03E92
        andi.w  #$ff7f,d0                       ; 03E98
        move.w  d0,(dat_071_0029C).l            ; 03E9C
        move.w  #$400d,-$4(a6)                  ; 03EA2
        bra.b   l_000_03EEA                     ; 03EA8
l_000_03EAA:
        move.w  (dat_071_0029C).l,d0            ; 03EAA
        btst    #$2,d0                          ; 03EB0
        bne.b   l_000_03EBA                     ; 03EB4
        clr.w   -$4(a6)                         ; 03EB6
l_000_03EBA:
        move.w  (dat_071_0029C).l,d0            ; 03EBA
        andi.w  #$ff7f,d0                       ; 03EC0
        move.w  d0,(dat_071_0029C).l            ; 03EC4
        bra.b   l_000_03EEA                     ; 03ECA
l_000_03ECC:
        move.w  (dat_071_004B0).l,d0            ; 03ECC
        tst.w   d0                              ; 03ED2
        bne.b   l_000_03EEA                     ; 03ED4
        move.w  (dat_071_0029C).l,d0            ; 03ED6
        andi.w  #$fffe,d0                       ; 03EDC
        move.w  d0,(dat_071_0029C).l            ; 03EE0
        clr.w   -$4(a6)                         ; 03EE6
l_000_03EEA:
        move.w  (dat_071_004B2).l,d0            ; 03EEA
        andi.w  #$ff,d0                         ; 03EF0
        move.w  -$4(a6),d1                      ; 03EF4
        andi.w  #$ff,d1                         ; 03EF8
        cmp.w   d1,d0                           ; 03EFC
        beq.w   l_000_03F8C                     ; 03EFE
        move.w  -$4(a6),d0                      ; 03F02
        move.w  d0,(dat_071_004B0).l            ; 03F06
        move.w  d0,(dat_071_004B2).l            ; 03F0C
        move.w  (dat_071_0029E).l,d0            ; 03F12
        andi.w  #$dfff,d0                       ; 03F18
        move.w  d0,(dat_071_0029E).l            ; 03F1C
        move.w  (dat_071_0029C).l,d0            ; 03F22
        andi.w  #$fffb,d0                       ; 03F28
        move.w  d0,(dat_071_0029C).l            ; 03F2C
        move.w  (dat_071_004B0).l,d0            ; 03F32
        andi.w  #$ff,d0                         ; 03F38
        move.w  d0,-$2(a6)                      ; 03F3C
        asl.w   #$4,d0                          ; 03F40
        move.w  -$2(a6),d1                      ; 03F42
        asl.w   #$3,d1                          ; 03F46
        add.w   d1,d0                           ; 03F48
        move.w  -$2(a6),d1                      ; 03F4A
        asl.w   #$2,d1                          ; 03F4E
        add.w   d1,d0                           ; 03F50
        move.w  d0,-$2(a6)                      ; 03F52
        ext.l   d0                              ; 03F56
        movea.l d0,a0                           ; 03F58
        adda.l  #dat_059_00000,a0               ; 03F5A
        move.b  (a0),d1                         ; 03F60
        move.b  d1,(dat_071_00232).l            ; 03F62
        addi.l  #$1b,d0                         ; 03F68
        movea.l d0,a0                           ; 03F6E
        adda.l  #dat_059_00000,a0               ; 03F70
        move.b  (a0),(dat_071_00233).l          ; 03F76
        move.b  (dat_071_00232).l,d0            ; 03F7C
        andi.b  #$3f,d0                         ; 03F82
        move.b  d0,(dat_071_00263).l            ; 03F86
l_000_03F8C:
        move.w  (dat_071_004B0).l,d0            ; 03F8C
        andi.w  #$8000,d0                       ; 03F92
        tst.w   d0                              ; 03F96
        beq.w   l_000_040F8                     ; 03F98
        move.w  (dat_071_0029E).l,d0            ; 03F9C
        btst    #$d,d0                          ; 03FA2
        bne.b   l_000_03FD4                     ; 03FA6
        ori.w   #$2000,d0                       ; 03FA8
        move.w  d0,(dat_071_0029E).l            ; 03FAC
        move.w  (dat_071_002A6).l,d0            ; 03FB2
        btst    #$5,d0                          ; 03FB8
        bne.b   l_000_03FCA                     ; 03FBC
        move.b  (dat_071_00263).l,(dat_071_00262).l; 03FBE
        bra.b   l_000_03FD4                     ; 03FC8
l_000_03FCA:
        move.b  (dat_071_00544).l,(dat_071_00262).l; 03FCA
l_000_03FD4:
        move.w  (dat_071_004B0).l,d0            ; 03FD4
        btst    #$c,d0                          ; 03FDA
        beq.b   l_000_03FE8                     ; 03FDE
        move.b  #$4,-$7(a6)                     ; 03FE0
        bra.b   l_000_03FEE                     ; 03FE6
l_000_03FE8:
        move.b  #$2,-$7(a6)                     ; 03FE8
l_000_03FEE:
        move.b  (dat_071_0025E).l,d0            ; 03FEE
        and.b   -$7(a6),d0                      ; 03FF4
        tst.b   d0                              ; 03FF8
        beq.w   l_000_041B6                     ; 03FFA
        move.w  (dat_071_0029E).l,d0            ; 03FFE
        btst    #$5,d0                          ; 04004
        beq.b   l_000_04060                     ; 04008
        move.b  (dat_071_0017E).l,d0            ; 0400A
        tst.b   d0                              ; 04010
        bne.b   l_000_04060                     ; 04012
        move.w  (dat_071_0029E).l,d0            ; 04014
        andi.w  #$ffdf,d0                       ; 0401A
        move.w  d0,(dat_071_0029E).l            ; 0401E
        move.w  (dat_071_004B0).l,d0            ; 04024
        andi.w  #$c000,d0                       ; 0402A
        cmpi.w  #$c000,d0                       ; 0402E
        bne.b   l_000_0403C                     ; 04032
        clr.w   (dat_071_004AE).l               ; 04034
        bra.b   l_000_0404A                     ; 0403A
l_000_0403C:
        move.w  (dat_071_004B0).l,d0            ; 0403C
        addq.w  #$1,d0                          ; 04042
        move.w  d0,(dat_071_004AE).l            ; 04044
l_000_0404A:
        tst.b   (dat_071_00233).l               ; 0404A
        beq.w   l_000_041B6                     ; 04050
        bset    #$3,(dat_071_00527).l           ; 04054
        bra.w   l_000_041B6                     ; 0405C
l_000_04060:
        move.w  (dat_071_0029E).l,d0            ; 04060
        ori.w   #$20,d0                         ; 04066
        move.w  d0,(dat_071_0029E).l            ; 0406A
        move.w  (dat_071_004B0).l,(dat_071_004AE).l; 04070
        tst.b   (dat_071_00233).l               ; 0407A
        beq.b   l_000_0408A                     ; 04080
        bset    #$2,(dat_071_00527).l           ; 04082
l_000_0408A:
        tst.b   (dat_071_00263).l               ; 0408A
        beq.w   l_000_041B6                     ; 04090
        move.b  (dat_071_00262).l,d0            ; 04094
        subq.b  #$1,d0                          ; 0409A
        move.b  d0,(dat_071_00262).l            ; 0409C
        tst.b   d0                              ; 040A2
        bpl.w   l_000_041B6                     ; 040A4
        move.w  (dat_071_004AE).l,d0            ; 040A8
        andi.w  #$ff,d0                         ; 040AE
        move.w  d0,(dat_071_004AE).l            ; 040B2
        move.w  d0,(dat_071_004B2).l            ; 040B8
        move.w  d0,(dat_071_004B0).l            ; 040BE
        move.w  (dat_071_0029E).l,d0            ; 040C4
        andi.w  #$dfff,d0                       ; 040CA
        move.w  d0,(dat_071_0029E).l            ; 040CE
        move.w  (dat_071_002A6).l,d0            ; 040D4
        andi.w  #$ffdf,d0                       ; 040DA
        move.w  d0,(dat_071_002A6).l            ; 040DE
        move.w  (dat_071_0029C).l,d0            ; 040E4
        andi.w  #$fffe,d0                       ; 040EA
        move.w  d0,(dat_071_0029C).l            ; 040EE
        bra.w   l_000_041B6                     ; 040F4
l_000_040F8:
        move.w  (dat_071_004B0).l,d0            ; 040F8
        btst    #$e,d0                          ; 040FE
        beq.w   l_000_041AC                     ; 04102
        move.w  (dat_071_0029E).l,d0            ; 04106
        btst    #$d,d0                          ; 0410C
        bne.b   l_000_0414E                     ; 04110
        move.w  (dat_071_0029E).l,d0            ; 04112
        ori.w   #$2000,d0                       ; 04118
        move.w  d0,(dat_071_0029E).l            ; 0411C
        move.w  (dat_071_002A6).l,d0            ; 04122
        btst    #$5,d0                          ; 04128
        bne.b   l_000_0413A                     ; 0412C
        move.b  (dat_071_00263).l,(dat_071_00262).l; 0412E
        bra.b   l_000_04144                     ; 04138
l_000_0413A:
        move.b  (dat_071_00544).l,(dat_071_00262).l; 0413A
l_000_04144:
        move.w  (dat_071_004B0).l,(dat_071_004AE).l; 04144
l_000_0414E:
        move.b  (dat_071_0025E).l,d0            ; 0414E
        btst    #$1,d0                          ; 04154
        beq.b   l_000_041B6                     ; 04158
        move.b  (dat_071_00262).l,d0            ; 0415A
        subq.b  #$1,d0                          ; 04160
        move.b  d0,(dat_071_00262).l            ; 04162
        tst.b   d0                              ; 04168
        bpl.b   l_000_041B6                     ; 0416A
        moveq   #$0,d0                          ; 0416C
        move.w  d0,(dat_071_004B0).l            ; 0416E
        move.w  d0,(dat_071_004AE).l            ; 04174
        move.w  (dat_071_0029E).l,d0            ; 0417A
        andi.w  #$dfff,d0                       ; 04180
        move.w  d0,(dat_071_0029E).l            ; 04184
        move.w  (dat_071_002A6).l,d0            ; 0418A
        andi.w  #$ffdf,d0                       ; 04190
        move.w  d0,(dat_071_002A6).l            ; 04194
        move.w  (dat_071_0029C).l,d0            ; 0419A
        andi.w  #$fffe,d0                       ; 041A0
        move.w  d0,(dat_071_0029C).l            ; 041A4
        bra.b   l_000_041B6                     ; 041AA
l_000_041AC:
        move.w  (dat_071_004B0).l,(dat_071_004AE).l; 041AC
l_000_041B6:
        move.b  (dat_071_00232).l,d0            ; 041B6
        andi.b  #$c0,d0                         ; 041BC
        move.b  d0,(dat_071_00232).l            ; 041C0
        move.b  (dat_071_00230).l,d1            ; 041C6
        cmp.b   d0,d1                           ; 041CC
        beq.b   l_000_041DE                     ; 041CE
        move.b  d0,(dat_071_00230).l            ; 041D0
        move.b  #$2,(dat_071_00231).l           ; 041D6
l_000_041DE:
        clr.b   (dat_071_0025E).l               ; 041DE
        unlk    a6                              ; 041E4
        rts                                     ; 041E6
sub_000_041E8:
        link.w  a6,#$fffe                       ; 041E8
        move.b  (dat_071_00155).l,d0            ; 041EC
        tst.b   d0                              ; 041F2
        bne.b   l_000_04206                     ; 041F4
        move.b  (dat_071_00261).l,d0            ; 041F6
        tst.b   d0                              ; 041FC
        bne.b   l_000_04206                     ; 041FE
        jsr     (sub_005_00CEE).l               ; 04200
l_000_04206:
        move.w  (dat_071_002AC).l,d0            ; 04206
        moveq   #$9,d1                          ; 0420C
        ext.l   d0                              ; 0420E
        asl.l   d1,d0                           ; 04210
        movea.l d0,a0                           ; 04212
        adda.l  #dat_071_00B54,a0               ; 04214
        move.b  $62(a0),d0                      ; 0421A
        andi.b  #$f0,d0                         ; 0421E
        move.w  (dat_071_00296).l,d1            ; 04222
        move.b  d0,-$1(a6)                      ; 04228
        btst    #$1,d1                          ; 0422C
        beq.w   l_000_042EC                     ; 04230
        andi.w  #$fffd,d1                       ; 04234
        move.w  d1,(dat_071_00296).l            ; 04238
        move.b  #$fe,(dat_071_00280).l          ; 0423E
        tst.b   (dat_071_00155).l               ; 04246
        beq.b   l_000_0426C                     ; 0424C
        moveq   #$0,d0                          ; 0424E
        move.b  d0,(dat_071_00155).l            ; 04250
        clr.w   (dat_071_00356).l               ; 04256
        move.b  d0,(dat_071_00176).l            ; 0425C
        move.b  #$1,(dat_071_00205).l           ; 04262
        bra.b   l_000_0427E                     ; 0426A
l_000_0426C:
        move.b  (dat_071_00203).l,(dat_071_00155).l; 0426C
        move.w  #$32,(dat_071_00356).l          ; 04276
l_000_0427E:
        moveq   #$3,d0                          ; 0427E
        move.l  d0,-(a7)                        ; 04280
        jsr     (sub_000_09C58).l               ; 04282
        addq.l  #$4,a7                          ; 04288
        cmpi.b  #$30,-$1(a6)                    ; 0428A
        bne.b   l_000_0429A                     ; 04290
        move.w  #$32,(dat_071_00356).l          ; 04292
l_000_0429A:
        move.w  (dat_071_00356).l,d0            ; 0429A
        asl.w   #$4,d0                          ; 042A0
        move.w  d0,(dat_071_00358).l            ; 042A2
        jsr     (sub_006_00074).l               ; 042A8
        clr.b   (dat_071_00177).l               ; 042AE
        move.b  #$ff,(dat_071_00228).l          ; 042B4
        jsr     (sub_005_00E6E).l               ; 042BC
        cmpi.b  #$30,-$1(a6)                    ; 042C2
        beq.b   l_000_042D2                     ; 042C8
        tst.b   (dat_071_00155).l               ; 042CA
        beq.b   l_000_042EC                     ; 042D0
l_000_042D2:
        tst.b   (dat_071_0017D).l               ; 042D2
        beq.b   l_000_042E4                     ; 042D8
        move.w  #$b3,(dat_071_00354).l          ; 042DA
        bra.b   l_000_042EC                     ; 042E2
l_000_042E4:
        move.w  #$a7,(dat_071_00354).l          ; 042E4
l_000_042EC:
        cmpi.b  #$30,-$1(a6)                    ; 042EC
        bne.b   l_000_04330                     ; 042F2
        move.w  (dat_071_00356).l,d0            ; 042F4
        tst.w   d0                              ; 042FA
        bne.b   l_000_04330                     ; 042FC
        move.w  #$32,(dat_071_00356).l          ; 042FE
        move.w  #$320,(dat_071_00358).l         ; 04306
        jsr     (sub_006_00074).l               ; 0430E
        clr.b   (dat_071_00177).l               ; 04314
        move.b  #$ff,(dat_071_00228).l          ; 0431A
        jsr     (sub_005_00E6E).l               ; 04322
        move.w  #$a7,(dat_071_00354).l          ; 04328
l_000_04330:
        tst.b   (dat_071_00155).l               ; 04330
        beq.b   l_000_0438E                     ; 04336
        move.w  (dat_071_00296).l,d0            ; 04338
        btst    #$4,d0                          ; 0433E
        beq.b   l_000_0435E                     ; 04342
        andi.w  #$ffef,d0                       ; 04344
        move.w  d0,(dat_071_00296).l            ; 04348
        move.b  (dat_071_0017C).l,d0            ; 0434E
        eori.b  #$1,d0                          ; 04354
        move.b  d0,(dat_071_0017C).l            ; 04358
l_000_0435E:
        move.b  (dat_071_0027E).l,d0            ; 0435E
        subq.b  #$6,d0                          ; 04364
        bne.b   l_000_0438E                     ; 04366
        cmpi.l  #$24000,(dat_071_00612).l       ; 04368
        bge.b   l_000_0438E                     ; 04372
        move.w  (dat_071_00354).l,d0            ; 04374
        cmpi.w  #$a7,d0                         ; 0437A
        beq.b   l_000_0438E                     ; 0437E
        move.w  #$a7,(dat_071_00354).l          ; 04380
        jsr     (sub_006_00008).l               ; 04388
l_000_0438E:
        unlk    a6                              ; 0438E
        rts                                     ; 04390
