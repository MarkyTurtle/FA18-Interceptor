; F/A-18 Interceptor - hunk 37 (code)
; Included by ../f18_main.s.

;===============================================================================
; Hunk 37: CODE, $A60 bytes
;===============================================================================
	CODE_HUNK	h037
dat_037_00000:
        dc.l    dat_002_028FC                   ; 00000
        dc.l    dat_002_028F8                   ; 00004
        dc.l    dat_002_028F4                   ; 00008
        dc.l    dat_002_028F0                   ; 0000C
        dc.l    dat_002_028EC                   ; 00010

;-------------------------------------------------------------------------------
; CopyTitleToScreen - Blits the title picture's five planes (TitleBitMap's saved planes) to the
; display, 320 x 200.
;-------------------------------------------------------------------------------
CopyTitleToScreen:
        lea.l   (CUSTOM).l,a0                    ; 00014
        movea.l (dat_071_0008A).l,a2            ; 0001A
        lea.l   dat_037_00000(pc),a1            ; 00020
        move.w  #$9f0,d2                        ; 00024
        movea.w #$14,a4                         ; 00028
        move.w  #$c8,d6                         ; 0002C
        asl.w   #$6,d6                          ; 00030
        addi.w  #$14,d6                         ; 00032
        movea.w #$1,a5                          ; 00036
        move.l  (a2)+,d4                        ; 0003A
        movea.l (a1)+,a3                        ; 0003C
        move.l  (a3),d0                         ; 0003E
        jsr     (_WaitBlit).l                   ; 00040
        move.w  d2,BLTCON0(a0)                  ; 00046
        move.w  #$0,BLTCON1(a0)                 ; 0004A
        move.w  #$ffff,BLTAFWM(a0)              ; 00050
        move.w  #$ffff,BLTALWM(a0)              ; 00056
        move.w  a5,BLTAMOD(a0)                  ; 0005C
        move.w  a5,BLTDMOD(a0)                  ; 00060
        bsr.w   sub_037_00084                   ; 00064
        bsr.w   sub_037_00074                   ; 00068
        bsr.w   sub_037_00074                   ; 0006C
        bsr.w   sub_037_00074                   ; 00070
sub_037_00074:
        move.l  (a2)+,d4                        ; 00074
        movea.l (a1)+,a3                        ; 00076
        move.l  (a3),d0                         ; 00078
        jsr     (_WaitBlit).l                   ; 0007A
        move.w  d2,$40(a0)                      ; 00080
sub_037_00084:
        move.l  d0,$50(a0)                      ; 00084
        move.l  d4,$54(a0)                      ; 00088
        move.w  d6,$58(a0)                      ; 0008C
        rts                                     ; 00090
dat_037_00092:
        dc.l    dat_002_02924                   ; 00092
        dc.l    dat_002_02920                   ; 00096
        dc.l    dat_002_0291C                   ; 0009A
        dc.l    dat_002_02918                   ; 0009E
l_037_000A2:
        rts                                     ; 000A2

;-------------------------------------------------------------------------------
; DrawPanel - While dat_071_00206 counts down: blits the instrument panel picture (pix/inst5)
; into the display at row 145 (55 rows, fewer if dat_071_002A8 is set), four planes.
;-------------------------------------------------------------------------------
DrawPanel:
        tst.b   (dat_071_00206).l               ; 000A4
        ble.b   l_037_000A2                     ; 000AA
        subq.b  #$1,(dat_071_00206).l           ; 000AC
        lea.l   (CUSTOM).l,a0                    ; 000B2
        movea.l (DrawPlanes).l,a2               ; 000B8
        lea.l   dat_037_00092(pc),a1            ; 000BE
        move.w  #$9f0,d2                        ; 000C2
        move.l  #$16a8,d1                       ; 000C6
        movea.w #$14,a4                         ; 000CC
        move.w  #$37,d6                         ; 000D0
        tst.w   (ViewY).l                       ; 000D4
        ble.b   l_037_000E2                     ; 000DA
        sub.w   (ViewY).l,d6                    ; 000DC
l_037_000E2:
        asl.w   #$6,d6                          ; 000E2
        addi.w  #$14,d6                         ; 000E4
        movea.w #$1,a5                          ; 000E8
        move.w  #$0,d7                          ; 000EC
        add.l   (dat_071_002E8).l,d1            ; 000F0
        bsr.w   sub_037_00A22                   ; 000F6
        blt.w   l_037_00148                     ; 000FA
        add.w   d7,d5                           ; 000FE
        add.w   d7,d7                           ; 00100
        ext.l   d7                              ; 00102
        move.l  (a2)+,d4                        ; 00104
        add.l   d1,d4                           ; 00106
        sub.w   d5,d6                           ; 00108
        add.w   d5,d5                           ; 0010A
        movea.l (a1)+,a3                        ; 0010C
        move.l  (a3),d0                         ; 0010E
        add.l   d7,d0                           ; 00110
        addq.w  #$1,d5                          ; 00112
        jsr     (_WaitBlit).l                   ; 00114
        move.w  #$0,BLTCON1(a0)                 ; 0011A
        move.w  #$ffff,BLTAFWM(a0)              ; 00120
        move.w  #$ffff,BLTALWM(a0)              ; 00126
        move.w  d5,BLTAMOD(a0)                  ; 0012C
        subq.w  #$1,d5                          ; 00130
        add.w   a5,d5                           ; 00132
        move.w  d5,BLTDMOD(a0)                  ; 00134
        bsr.w   sub_037_00244                   ; 00138
        bsr.w   sub_037_00234                   ; 0013C
        bsr.w   sub_037_00234                   ; 00140
        bsr.w   sub_037_00234                   ; 00144
l_037_00148:
        tst.w   (dat_071_00356).l               ; 00148
        beq.w   l_037_00216                     ; 0014E
        move.w  (ClipY).l,d0                    ; 00152
        subi.w  #$90,d0                         ; 00158
        move.w  d0,d7                           ; 0015C
        asl.w   #$3,d0                          ; 0015E
        move.w  d0,d1                           ; 00160
        add.w   d0,d0                           ; 00162
        add.w   d0,d0                           ; 00164
        add.w   d1,d0                           ; 00166
        ext.l   d0                              ; 00168
        move.l  #$16a8,d1                       ; 0016A
        move.w  (dat_071_00356).l,d6            ; 00170
        bgt.b   l_037_00194                     ; 00176
        cmpi.w  #$ffec,d6                       ; 00178
        bgt.b   l_037_00184                     ; 0017C
        move.w  #$14,d6                         ; 0017E
        bra.b   l_037_0019E                     ; 00182
l_037_00184:
        move.w  d6,d4                           ; 00184
        neg.w   d6                              ; 00186
        add.w   d4,d4                           ; 00188
        addi.w  #$28,d4                         ; 0018A
        ext.l   d4                              ; 0018E
        add.l   d4,d1                           ; 00190
        bra.b   l_037_0019E                     ; 00192
l_037_00194:
        cmpi.w  #$14,d6                         ; 00194
        blt.b   l_037_0019E                     ; 00198
        move.w  #$14,d6                         ; 0019A
l_037_0019E:
        move.w  d6,d5                           ; 0019E
        subi.w  #$14,d5                         ; 001A0
        neg.w   d5                              ; 001A4
        add.w   d5,d5                           ; 001A6
        addq.w  #$1,d5                          ; 001A8
        addi.w  #$dc0,d6                        ; 001AA
        tst.w   (ViewY).l                       ; 001AE
        ble.b   l_037_001C0                     ; 001B4
        move.w  (ViewY).l,d4                    ; 001B6
        lsl.w   #$6,d4                          ; 001BC
        sub.w   d4,d6                           ; 001BE
l_037_001C0:
        movea.l (DrawPlanes).l,a2               ; 001C0
        move.l  (a2),d4                         ; 001C6
        add.l   d1,d4                           ; 001C8
        moveq   #-1,d3                          ; 001CA
        add.l   d0,d1                           ; 001CC
        asl.w   #$6,d7                          ; 001CE
        sub.w   d7,d6                           ; 001D0
        move.w  #$30a,d2                        ; 001D2
        move.l  (a2)+,d4                        ; 001D6
        add.l   d1,d4                           ; 001D8
        jsr     (_WaitBlit).l                   ; 001DA
        move.w  #$0,BLTCON1(a0)                 ; 001E0
        move.w  d3,BLTADAT(a0)                  ; 001E6
        move.w  d3,BLTAFWM(a0)                  ; 001EA
        move.w  d3,BLTALWM(a0)                  ; 001EE
        move.w  d5,BLTCMOD(a0)                  ; 001F2
        move.w  d5,BLTDMOD(a0)                  ; 001F6
        bsr.w   sub_037_00222                   ; 001FA
        move.w  #$30a,d2                        ; 001FE
        bsr.w   sub_037_00218                   ; 00202
        move.w  #$3fa,d2                        ; 00206
        bsr.w   sub_037_00218                   ; 0020A
        move.w  #$3fa,d2                        ; 0020E
        bsr.w   sub_037_00218                   ; 00212
l_037_00216:
        rts                                     ; 00216
sub_037_00218:
        move.l  (a2)+,d4                        ; 00218
        add.l   d1,d4                           ; 0021A
        jsr     (_WaitBlit).l                   ; 0021C
sub_037_00222:
        move.w  d2,$40(a0)                      ; 00222
        move.l  d4,$48(a0)                      ; 00226
        move.l  d4,$54(a0)                      ; 0022A
        move.w  d6,$58(a0)                      ; 0022E
        rts                                     ; 00232
sub_037_00234:
        move.l  (a2)+,d4                        ; 00234
        add.l   d1,d4                           ; 00236
        movea.l (a1)+,a3                        ; 00238
        move.l  (a3),d0                         ; 0023A
        add.l   d7,d0                           ; 0023C
        jsr     (_WaitBlit).l                   ; 0023E
sub_037_00244:
        move.w  d2,$40(a0)                      ; 00244
        move.l  d0,$50(a0)                      ; 00248
        move.l  d4,$54(a0)                      ; 0024C
        move.w  d6,$58(a0)                      ; 00250
        rts                                     ; 00254
l_037_00256:
        rts                                     ; 00256
sub_037_00258:
        move.w  (dat_071_002C6).l,d2            ; 00258
        andi.w  #$7fff,d2                       ; 0025E
        lsr.w   #$8,d2                          ; 00262
        lsr.w   #$2,d2                          ; 00264
        tst.b   (dat_071_00207).l               ; 00266
        bgt.b   l_037_00280                     ; 0026C
        cmp.w   (dat_071_00374).l,d2            ; 0026E
        beq.b   l_037_00256                     ; 00274
        btst    #$0,(dat_071_002AB).l           ; 00276
        beq.b   l_037_00286                     ; 0027E
l_037_00280:
        move.w  d2,(dat_071_00374).l            ; 00280
l_037_00286:
        move.w  #$15,d3                         ; 00286
        move.w  #$70,d0                         ; 0028A
        add.w   (ViewX).l,d0                    ; 0028E
        ble.b   l_037_00256                     ; 00294
        cmpi.w  #$13c,d0                        ; 00296
        bgt.b   l_037_00256                     ; 0029A
        move.w  #$b4,d1                         ; 0029C
        add.w   (ViewY).l,d1                    ; 002A0
l_037_002A6:
        subq.w  #$1,d2                          ; 002A6
        bgt.b   l_037_002B4                     ; 002A8
        move.w  #$0,(DrawColour).l              ; 002AA
        bra.b   l_037_002BC                     ; 002B2
l_037_002B4:
        move.w  #$4,(DrawColour).l              ; 002B4
l_037_002BC:
        movem.w d0-d3,-(a7)                     ; 002BC
        jsr     (Plot2).l                       ; 002C0
        movem.w (a7)+,d0-d3                     ; 002C6
        movem.w d0-d3,-(a7)                     ; 002CA
        addq.w  #$2,d0                          ; 002CE
        jsr     (Plot2).l                       ; 002D0
        movem.w (a7)+,d0-d3                     ; 002D6
        subq.w  #$1,d1                          ; 002DA
        dbra    d3,l_037_002A6                  ; 002DC
        rts                                     ; 002E0
dat_037_002E2:
        dc.l    dat_002_0292C                   ; 002E2
dat_037_002E6:
        dc.l    dat_002_02954                   ; 002E6
        dc.l    dat_002_02950                   ; 002EA
        dc.l    dat_002_0294C                   ; 002EE
        dc.l    dat_002_02948                   ; 002F2
sub_037_002F6:
        lea.l   dat_037_002E6(pc),a1            ; 002F6
        lea.l   dat_037_002E2(pc),a3            ; 002FA
        move.w  #$fce,d2                        ; 002FE
        movea.l (a3),a3                         ; 00302
        move.l  (a3),d0                         ; 00304
        move.l  #$14ca,d1                       ; 00306
        movea.w #$12,a4                         ; 0030C
        move.w  #$312,d6                        ; 00310
        movea.w #$5,a5                          ; 00314
        move.w  #$1,d7                          ; 00318
        bsr.w   sub_037_007EA                   ; 0031C
        rts                                     ; 00320
dat_037_00322:
	dc.b	$00,$55,$00,$AC,$00,$33,$00,$AC,$FF,$FF
dat_037_0032C:
	dc.b	$00,$4A,$00,$9F,$00,$3E,$00,$9F,$00,$51,$00,$A7,$00,$37,$00,$A7
	dc.b	$FF,$FF
l_037_0033E:
        rts                                     ; 0033E
sub_037_00340:
        tst.b   (dat_071_00213).l               ; 00340
        ble.b   l_037_0033E                     ; 00346
        subq.b  #$1,(dat_071_00213).l           ; 00348
        lea.l   (ObjectTable).l,a0              ; 0034E
        adda.w  (ViewObject).l,a0               ; 00354
        move.b  $62(a0),d1                      ; 0035A
        andi.b  #$f0,d1                         ; 0035E
        cmpi.b  #$0,d1                          ; 00362
        beq.b   l_037_0033E                     ; 00366
        move.l  #$fffff,(dat_071_000B6).l       ; 00368
        move.w  #$44,d0                         ; 00372
        add.w   (ViewX).l,d0                    ; 00376
        blt.b   l_037_003E2                     ; 0037C
        cmpi.w  #$13f,d0                        ; 0037E
        bgt.b   l_037_003E2                     ; 00382
        move.w  #$a3,d1                         ; 00384
        add.w   (ViewY).l,d1                    ; 00388
        move.b  $63(a0),d5                      ; 0038E
        andi.b  #$f0,d5                         ; 00392
        cmpi.b  #$10,d5                         ; 00396
        bne.b   l_037_003B4                     ; 0039A
        move.w  #$1,(DrawColour).l              ; 0039C
        movem.l d0-d1/d5/a0,-(a7)               ; 003A4
        jsr     (Plot).l                        ; 003A8
        movem.l (a7)+,d0-d1/d5/a0               ; 003AE
        bra.b   l_037_003D2                     ; 003B2
l_037_003B4:
        move.w  #$0,(DrawColour).l              ; 003B4
        movem.l d0-d1/d5/a0,-(a7)               ; 003BC
        jsr     (Plot).l                        ; 003C0
        movem.l (a7)+,d0-d1/d5/a0               ; 003C6
        move.w  #$4,(DrawColour).l              ; 003CA
l_037_003D2:
        movem.l d5/a0,-(a7)                     ; 003D2
        addq.w  #$1,d1                          ; 003D6
        jsr     (Plot).l                        ; 003D8
        movem.l (a7)+,d5/a0                     ; 003DE
l_037_003E2:
        lea.l   dat_037_00322(pc),a1            ; 003E2
        move.b  $5f(a0),d4                      ; 003E6
        lsr.b   #$4,d4                          ; 003EA
        cmpi.b  #$20,d5                         ; 003EC
        beq.b   l_037_003F8                     ; 003F0
        bclr    #$1f,d4                         ; 003F2
        bra.b   l_037_003FC                     ; 003F6
l_037_003F8:
        bset    #$1f,d4                         ; 003F8
l_037_003FC:
        bsr.w   sub_037_00422                   ; 003FC
        lea.l   dat_037_0032C(pc),a1            ; 00400
        move.b  $5f(a0),d4                      ; 00404
        andi.b  #$f,d4                          ; 00408
        cmpi.b  #$30,d5                         ; 0040C
        beq.b   l_037_00418                     ; 00410
        bclr    #$1f,d4                         ; 00412
        bra.b   l_037_0041C                     ; 00416
l_037_00418:
        bset    #$1f,d4                         ; 00418
l_037_0041C:
        bsr.w   sub_037_00422                   ; 0041C
        rts                                     ; 00420
sub_037_00422:
        subq.b  #$1,d4                          ; 00422
        bge.b   l_037_00430                     ; 00424
        move.w  #$0,(DrawColour).l              ; 00426
        bra.b   l_037_0044A                     ; 0042E
l_037_00430:
        tst.l   d4                              ; 00430
        bgt.b   l_037_00442                     ; 00432
        tst.b   d4                              ; 00434
        bgt.b   l_037_00442                     ; 00436
        move.w  #$1,(DrawColour).l              ; 00438
        bra.b   l_037_0044A                     ; 00440
l_037_00442:
        move.w  #$4,(DrawColour).l              ; 00442
l_037_0044A:
        move.w  (a1)+,d0                        ; 0044A
        blt.b   l_037_0049A                     ; 0044C
        move.w  (a1)+,d1                        ; 0044E
        add.w   (ViewX).l,d0                    ; 00450
        ble.b   sub_037_00422                   ; 00456
        cmpi.w  #$13e,d0                        ; 00458
        bge.b   sub_037_00422                   ; 0045C
        move.w  d0,d2                           ; 0045E
        add.w   (ViewY).l,d1                    ; 00460
        move.w  d1,d3                           ; 00466
        addq.w  #$6,d3                          ; 00468
        movem.l d4-d5/a0-a1,-(a7)               ; 0046A
        movem.w d2-d3,-(a7)                     ; 0046E
        jsr     (DrawLine199).l                 ; 00472
        movem.w (a7)+,d0-d1                     ; 00478
        subq.w  #$1,d0                          ; 0047C
        movem.w d0-d1,-(a7)                     ; 0047E
        jsr     (Plot).l                        ; 00482
        movem.w (a7)+,d0-d1                     ; 00488
        addq.w  #$2,d0                          ; 0048C
        jsr     (Plot).l                        ; 0048E
        movem.l (a7)+,d4-d5/a0-a1               ; 00494
        bra.b   sub_037_00422                   ; 00498
l_037_0049A:
        rts                                     ; 0049A
sub_037_0049C:
        tst.b   (dat_071_0020E).l               ; 0049C
        ble.b   l_037_00504                     ; 004A2
        subq.b  #$1,(dat_071_0020E).l           ; 004A4
        move.w  #$f1,d0                         ; 004AA
        add.w   (ViewX).l,d0                    ; 004AE
        blt.b   l_037_00504                     ; 004B4
        cmpi.w  #$137,d0                        ; 004B6
        bgt.b   l_037_00504                     ; 004BA
        move.w  #$b4,d1                         ; 004BC
        add.w   (ViewY).l,d1                    ; 004C0
        move.w  d0,d2                           ; 004C6
        addi.w  #$9,d2                          ; 004C8
        move.w  d1,d3                           ; 004CC
        move.l  #$fffff,(dat_071_000B6).l       ; 004CE
        lea.l   (ObjectTable).l,a2              ; 004D8
        adda.w  (ViewObject).l,a2               ; 004DE
        btst    #$3,$3(a2)                      ; 004E4
        bne.b   l_037_004F6                     ; 004EA
        move.w  #$0,(DrawColour).l              ; 004EC
        bra.b   l_037_004FE                     ; 004F4
l_037_004F6:
        move.w  #$9,(DrawColour).l              ; 004F6
l_037_004FE:
        jsr     (DrawLine199).l                 ; 004FE
l_037_00504:
        tst.b   (dat_071_0020F).l               ; 00504
        ble.b   l_037_00560                     ; 0050A
        subq.b  #$1,(dat_071_0020F).l           ; 0050C
        move.l  #$1a68,d1                       ; 00512
        movea.w #$3,a4                          ; 00518
        move.w  #$1c3,d6                        ; 0051C
        movea.w #$23,a5                         ; 00520
        move.w  #$0,d7                          ; 00524
        add.l   (dat_071_002E8).l,d1            ; 00528
        bsr.w   sub_037_00A22                   ; 0052E
        blt.b   l_037_005B0                     ; 00532
        move.w  #$30a,d2                        ; 00534
        lea.l   (ObjectTable).l,a0              ; 00538
        move.w  (ViewObject).l,d0               ; 0053E
        move.w  (a0,d0.w),d0                    ; 00544
        andi.w  #$800,d0                        ; 00548
        beq.b   l_037_00552                     ; 0054C
        move.w  #$3fa,d2                        ; 0054E
l_037_00552:
        moveq   #$c,d4                          ; 00552
        move.w  #$7f,d0                         ; 00554
        move.w  #$8000,d3                       ; 00558
        bsr.w   sub_037_00604                   ; 0055C
l_037_00560:
        tst.b   (dat_071_00210).l               ; 00560
        ble.b   l_037_005B0                     ; 00566
        subq.b  #$1,(dat_071_00210).l           ; 00568
        move.l  #$1a14,d1                       ; 0056E
        movea.w #$2,a4                          ; 00574
        move.w  #$1c2,d6                        ; 00578
        movea.w #$25,a5                         ; 0057C
        move.w  #$12,d7                         ; 00580
        add.l   (dat_071_002E8).l,d1            ; 00584
        bsr.w   sub_037_00A22                   ; 0058A
        blt.b   l_037_005B0                     ; 0058E
        move.w  #$30a,d2                        ; 00590
        tst.b   (dat_071_00285).l               ; 00594
        beq.b   l_037_005A0                     ; 0059A
        move.w  #$3fa,d2                        ; 0059C
l_037_005A0:
        moveq   #$c,d4                          ; 005A0
        move.w  #$fff,d0                        ; 005A2
        move.w  #$fc00,d3                       ; 005A6
        bsr.w   sub_037_00604                   ; 005AA
l_037_005AE:
        rts                                     ; 005AE
l_037_005B0:
        tst.b   (dat_071_00212).l               ; 005B0
        ble.b   l_037_005AE                     ; 005B6
        subq.b  #$1,(dat_071_00212).l           ; 005B8
        move.l  #$1888,d1                       ; 005BE
        movea.w #$2,a4                          ; 005C4
        move.w  #$202,d6                        ; 005C8
        movea.w #$25,a5                         ; 005CC
        move.w  #$0,d7                          ; 005D0
        add.l   (dat_071_002E8).l,d1            ; 005D4
        bsr.w   sub_037_00A22                   ; 005DA
        blt.b   l_037_005AE                     ; 005DE
        move.w  #$30a,d2                        ; 005E0
        tst.b   (dat_071_0017B).l               ; 005E4
        beq.b   l_037_005FA                     ; 005EA
        btst    #$0,(dat_071_00212).l           ; 005EC
        beq.b   l_037_005FA                     ; 005F4
        move.w  #$3fa,d2                        ; 005F6
l_037_005FA:
        moveq   #$c,d4                          ; 005FA
        move.w  #$7f,d0                         ; 005FC
        move.w  #$ffff,d3                       ; 00600
sub_037_00604:
        movea.l (DrawPlanes).l,a2               ; 00604
        move.l  (a2,d4.w),d4                    ; 0060A
        tst.w   d5                              ; 0060E
        beq.b   l_037_00616                     ; 00610
        move.w  #$ffff,d3                       ; 00612
l_037_00616:
        tst.w   d7                              ; 00616
        beq.b   l_037_0061E                     ; 00618
        move.w  #$ffff,d0                       ; 0061A
l_037_0061E:
        add.w   d7,d5                           ; 0061E
        add.l   d1,d4                           ; 00620
        sub.w   d5,d6                           ; 00622
        add.w   d5,d5                           ; 00624
        add.w   a5,d5                           ; 00626
        lea.l   (CUSTOM).l,a0                    ; 00628
        jsr     (_WaitBlit).l                   ; 0062E
        move.w  d2,BLTCON0(a0)                  ; 00634
        move.w  #$0,BLTCON1(a0)                 ; 00638
        move.w  #$ffff,BLTADAT(a0)              ; 0063E
        move.w  d0,BLTAFWM(a0)                  ; 00644
        move.w  d3,BLTALWM(a0)                  ; 00648
        move.w  d5,BLTCMOD(a0)                  ; 0064C
        move.w  d5,BLTDMOD(a0)                  ; 00650
        move.l  d4,BLTCPTH(a0)                  ; 00654
        move.l  d4,BLTDPTH(a0)                  ; 00658
        move.w  d6,BLTSIZE(a0)                  ; 0065C
        rts                                     ; 00660
dat_037_00662:
        dc.l    dat_062_000E4                   ; 00662
        dc.l    dat_062_000C8                   ; 00666
        dc.l    dat_062_000AC                   ; 0066A
        dc.l    dat_062_00090                   ; 0066E
l_037_00672:
        rts                                     ; 00672
sub_037_00674:
        move.l  #$1c70,d1                       ; 00674
        movea.w #$2,a4                          ; 0067A
        move.w  #$202,d6                        ; 0067E
        movea.w #$25,a5                         ; 00682
        move.w  #$0,d7                          ; 00686
        add.l   (dat_071_002E8).l,d1            ; 0068A
        bsr.w   sub_037_00A22                   ; 00690
        blt.b   l_037_006BE                     ; 00694
        move.w  #$30a,d2                        ; 00696
        tst.b   (dat_071_00216).l               ; 0069A
        ble.b   l_037_006B0                     ; 006A0
        btst    #$1,(dat_071_002AB).l           ; 006A2
        beq.b   l_037_006B0                     ; 006AA
        move.w  #$3fa,d2                        ; 006AC
l_037_006B0:
        moveq   #$c,d4                          ; 006B0
        move.w  #$3f,d0                         ; 006B2
        move.w  #$fffe,d3                       ; 006B6
        bsr.w   sub_037_00604                   ; 006BA
l_037_006BE:
        tst.b   (dat_071_00215).l               ; 006BE
        ble.b   l_037_00672                     ; 006C4
        subq.b  #$1,(dat_071_00215).l           ; 006C6
        lea.l   (ObjectTable).l,a1              ; 006CC
        adda.w  (ViewObject).l,a1               ; 006D2
        move.b  $7c(a1),d0                      ; 006D8
        lea.l   dat_037_00662(pc),a1            ; 006DC
        bclr    #$7,d0                          ; 006E0
        asr.b   #$5,d0                          ; 006E4
        ext.w   d0                              ; 006E6
        add.w   d0,d0                           ; 006E8
        add.w   d0,d0                           ; 006EA
        adda.w  d0,a1                           ; 006EC
        move.l  #dat_062_00074,d0               ; 006EE
        move.l  #$1d88,d1                       ; 006F4
        move.w  #$0,d7                          ; 006FA
        movea.w #$2,a4                          ; 006FE
        move.w  #$1c2,d6                        ; 00702
        movea.w #$25,a5                         ; 00706
        movea.l (DrawPlanes).l,a2               ; 0070A
        add.l   (dat_071_002E8).l,d1            ; 00710
        bsr.w   sub_037_00A22                   ; 00716
        blt.w   l_037_00672                     ; 0071A
        add.w   d7,d5                           ; 0071E
        add.w   d7,d7                           ; 00720
        ext.l   d7                              ; 00722
        sub.w   d5,d6                           ; 00724
        add.w   d5,d5                           ; 00726
        addq.w  #$1,d5                          ; 00728
        ext.l   d5                              ; 0072A
        move.l  (a2),d4                         ; 0072C
        add.l   d1,d4                           ; 0072E
        move.l  (a1)+,d3                        ; 00730
        add.l   d7,d3                           ; 00732
        add.l   d7,d0                           ; 00734
        move.w  #$f3a,d2                        ; 00736
        lea.l   (CUSTOM).l,a0                    ; 0073A
        jsr     (_WaitBlit).l                   ; 00740
        move.w  d2,BLTCON0(a0)                  ; 00746
        move.w  #$0,BLTCON1(a0)                 ; 0074A
        move.w  #$ffff,BLTAFWM(a0)              ; 00750
        move.w  #$ffff,BLTALWM(a0)              ; 00756
        move.w  d5,BLTAMOD(a0)                  ; 0075C
        move.w  d5,BLTBMOD(a0)                  ; 00760
        subq.w  #$1,d5                          ; 00764
        add.w   a5,d5                           ; 00766
        move.w  d5,BLTCMOD(a0)                  ; 00768
        move.w  d5,BLTDMOD(a0)                  ; 0076C
        move.l  d0,BLTAPTH(a0)                  ; 00770
        move.l  d3,BLTBPTH(a0)                  ; 00774
        move.l  d4,BLTCPTH(a0)                  ; 00778
        move.l  d4,BLTDPTH(a0)                  ; 0077C
        move.w  d6,BLTSIZE(a0)                  ; 00780
        lea.l   (ObjectTable).l,a1              ; 00784
        adda.w  (ViewObject).l,a1               ; 0078A
        btst    #$7,$2(a1)                      ; 00790
        beq.b   l_037_007E8                     ; 00796
        move.w  #$e,d0                          ; 00798
        move.w  #$c0,d1                         ; 0079C
        move.w  #$c,d2                          ; 007A0
        move.w  #$c3,d3                         ; 007A4
        add.w   (ViewX).l,d0                    ; 007A8
        blt.b   l_037_007E8                     ; 007AE
        cmpi.w  #$140,d0                        ; 007B0
        bge.b   l_037_007E8                     ; 007B4
        add.w   (ViewX).l,d2                    ; 007B6
        blt.b   l_037_007E8                     ; 007BC
        cmpi.w  #$140,d2                        ; 007BE
        bge.b   l_037_007E8                     ; 007C2
        add.w   (ViewY).l,d1                    ; 007C4
        add.w   (ViewY).l,d3                    ; 007CA
        move.l  #$fffff,(dat_071_000B6).l       ; 007D0
        move.w  #$0,(DrawColour).l              ; 007DA
        jsr     (DrawLine199).l                 ; 007E2
l_037_007E8:
        rts                                     ; 007E8
sub_037_007EA:
        movea.l #$0,a0                          ; 007EA
        movea.l (DrawPlanes).l,a2               ; 007F0
        add.l   (dat_071_002E8).l,d1            ; 007F6
        bsr.w   sub_037_00A22                   ; 007FC
        blt.w   l_037_008B0                     ; 00800
        add.w   d7,d5                           ; 00804
        add.w   d7,d7                           ; 00806
        ext.l   d7                              ; 00808
        sub.w   d5,d6                           ; 0080A
        add.w   d5,d5                           ; 0080C
        addq.w  #$1,d5                          ; 0080E
        swap    d2                              ; 00810
        move.w  a0,d2                           ; 00812
        add.w   d2,d5                           ; 00814
        swap    d2                              ; 00816
        ext.l   d5                              ; 00818
l_037_0081A:
        cmpi.l  #$28,d1                         ; 0081A
        bge.b   l_037_00836                     ; 00820
        addi.l  #$28,d1                         ; 00822
        add.l   a4,d7                           ; 00828
        add.l   a4,d7                           ; 0082A
        subi.w  #$40,d6                         ; 0082C
        bge.b   l_037_0081A                     ; 00830
        bra.w   l_037_008B0                     ; 00832
l_037_00836:
        move.l  (a2)+,d4                        ; 00836
        add.l   d1,d4                           ; 00838
        movea.l (a1)+,a3                        ; 0083A
        move.l  (a3),d3                         ; 0083C
        add.l   d7,d3                           ; 0083E
        add.l   d7,d0                           ; 00840
        lea.l   (CUSTOM).l,a0                    ; 00842
        jsr     (_WaitBlit).l                   ; 00848
        move.w  #$0,BLTCON1(a0)                 ; 0084E
        move.w  #$ffff,BLTAFWM(a0)              ; 00854
        move.w  #$ffff,BLTALWM(a0)              ; 0085A
        move.w  d5,BLTBMOD(a0)                  ; 00860
        swap    d2                              ; 00864
        sub.w   d2,d5                           ; 00866
        swap    d2                              ; 00868
        move.w  d5,BLTAMOD(a0)                  ; 0086A
        subq.w  #$1,d5                          ; 0086E
        add.w   a5,d5                           ; 00870
        move.w  d5,BLTCMOD(a0)                  ; 00872
        move.w  d5,BLTDMOD(a0)                  ; 00876
        bsr.w   sub_037_00896                   ; 0087A
        bsr.w   sub_037_00886                   ; 0087E
        bsr.w   sub_037_00886                   ; 00882
sub_037_00886:
        move.l  (a2)+,d4                        ; 00886
        add.l   d1,d4                           ; 00888
        movea.l (a1)+,a3                        ; 0088A
        move.l  (a3),d3                         ; 0088C
        add.l   d7,d3                           ; 0088E
        jsr     (_WaitBlit).l                   ; 00890
sub_037_00896:
        move.w  d2,$40(a0)                      ; 00896
        move.l  d0,$50(a0)                      ; 0089A
        move.l  d3,$4c(a0)                      ; 0089E
        move.l  d4,$48(a0)                      ; 008A2
        move.l  d4,$54(a0)                      ; 008A6
        move.w  d6,$58(a0)                      ; 008AA
        rts                                     ; 008AE
l_037_008B0:
        moveq   #-1,d0                          ; 008B0
        rts                                     ; 008B2
	dc.b	$4E,$75
l_037_008B6:
        rts                                     ; 008B6
sub_037_008B8:
        bsr.w   sub_037_009EA                   ; 008B8
        move.w  (dat_071_00294).l,d0            ; 008BC
        tst.b   (dat_071_00207).l               ; 008C2
        bgt.b   l_037_008F2                     ; 008C8
        move.w  (dat_071_00372).l,d2            ; 008CA
        blt.b   l_037_008E2                     ; 008D0
        cmp.w   d2,d0                           ; 008D2
        beq.b   l_037_008B6                     ; 008D4
        btst    #$0,(dat_071_002AB).l           ; 008D6
        bne.b   l_037_008B6                     ; 008DE
        bra.b   l_037_008F2                     ; 008E0
l_037_008E2:
        andi.w  #$7fff,(dat_071_00372).l        ; 008E2
        andi.w  #$7fff,d2                       ; 008EA
        move.w  d2,d0                           ; 008EE
        bra.b   l_037_00900                     ; 008F0
l_037_008F2:
        move.w  d0,(dat_071_00372).l            ; 008F2
        ori.w   #$8000,(dat_071_00372).l        ; 008F8
l_037_00900:
        lea.l   (CUSTOM).l,a0                    ; 00900
        movea.l (DrawPlanes).l,a2               ; 00906
        move.l  #$17b0,d1                       ; 0090C
        movea.w #$2,a4                          ; 00912
        movea.w #$23,a5                         ; 00916
        move.w  #$1c3,d3                        ; 0091A
        move.w  #$c,d7                          ; 0091E
        add.l   (dat_071_002E8).l,d1            ; 00922
        bsr.w   sub_037_00A22                   ; 00928
        blt.b   l_037_008B6                     ; 0092C
        add.w   d7,d5                           ; 0092E
        add.l   $c(a2),d1                       ; 00930
        sub.w   d5,d3                           ; 00934
        add.w   d5,d5                           ; 00936
        movea.w d5,a4                           ; 00938
        move.l  #$ffff0000,d6                   ; 0093A
        asr.w   #$1,d0                          ; 00940
        move.w  d0,d4                           ; 00942
        andi.w  #$f,d0                          ; 00944
        beq.b   l_037_00956                     ; 00948
        subq.l  #$2,d1                          ; 0094A
        swap    d6                              ; 0094C
        neg.w   d0                              ; 0094E
        addi.w  #$10,d0                         ; 00950
        ror.w   #$4,d0                          ; 00954
l_037_00956:
        andi.w  #$f0,d4                         ; 00956
        asr.w   #$3,d4                          ; 0095A
        ext.l   d4                              ; 0095C
        addi.l  #dat_062_00174,d4               ; 0095E
        add.w   d7,d7                           ; 00964
        ext.l   d7                              ; 00966
        add.l   d7,d4                           ; 00968
        move.w  #$73a,d2                        ; 0096A
        move.w  a4,d5                           ; 0096E
        addi.w  #$7,d5                          ; 00970
        jsr     (_WaitBlit).l                   ; 00974
        move.w  d2,BLTCON0(a0)                  ; 0097A
        move.w  d0,BLTCON1(a0)                  ; 0097E
        move.w  #$ffff,BLTADAT(a0)              ; 00982
        move.w  d6,BLTALWM(a0)                  ; 00988
        swap    d6                              ; 0098C
        move.w  d6,BLTAFWM(a0)                  ; 0098E
        move.w  d5,BLTBMOD(a0)                  ; 00992
        subi.w  #$7,d5                          ; 00996
        add.w   a5,d5                           ; 0099A
        move.w  d5,BLTCMOD(a0)                  ; 0099C
        move.w  d5,BLTDMOD(a0)                  ; 009A0
        move.l  d4,BLTBPTH(a0)                  ; 009A4
        move.l  d1,BLTCPTH(a0)                  ; 009A8
        move.l  d1,BLTDPTH(a0)                  ; 009AC
        move.w  d3,BLTSIZE(a0)                  ; 009B0
        move.l  #$fffff,(dat_071_000B6).l       ; 009B4
        move.w  #$d0,d0                         ; 009BE
        add.w   (ViewX).l,d0                    ; 009C2
        blt.b   l_037_009E8                     ; 009C8
        cmpi.w  #$140,d0                        ; 009CA
        bge.b   l_037_009E8                     ; 009CE
        move.w  #$96,d1                         ; 009D0
        move.w  d0,d2                           ; 009D4
        move.w  d1,d3                           ; 009D6
        addq.w  #$7,d3                          ; 009D8
        move.w  #$1,(DrawColour).l              ; 009DA
        jsr     (DrawLine199).l                 ; 009E2
l_037_009E8:
        rts                                     ; 009E8
sub_037_009EA:
        lea.l   (ObjectTable).l,a0              ; 009EA
        move.w  (ViewObject).l,d1               ; 009F0
        move.w  $68(a0,d1.w),d0                 ; 009F6
        ext.l   d0                              ; 009FA
        asr.l   #$3,d0                          ; 009FC
        divu.w  #$a,d0                          ; 009FE
        move.w  d0,(dat_071_00370).l            ; 00A02
        asr.w   #$1,d0                          ; 00A08
        mulu.w  #$87,d0                         ; 00A0A
        asr.l   #$8,d0                          ; 00A0E
        subi.w  #$4,d0                          ; 00A10
        bge.b   l_037_00A1A                     ; 00A14
        addi.w  #$60,d0                         ; 00A16
l_037_00A1A:
        move.w  d0,(dat_071_00294).l            ; 00A1A
        rts                                     ; 00A20
sub_037_00A22:
        move.w  (dat_071_00356).l,d5            ; 00A22
        add.w   d5,d7                           ; 00A28
        bge.b   l_037_00A40                     ; 00A2A
        neg.w   d7                              ; 00A2C
        cmp.w   a4,d7                           ; 00A2E
        bge.b   l_037_00A3C                     ; 00A30
        add.w   d7,d5                           ; 00A32
        add.w   d5,d5                           ; 00A34
        ext.l   d5                              ; 00A36
        add.l   d5,d1                           ; 00A38
        bra.b   l_037_00A5C                     ; 00A3A
l_037_00A3C:
        moveq   #-1,d5                          ; 00A3C
        rts                                     ; 00A3E
l_037_00A40:
        add.w   d5,d5                           ; 00A40
        ext.l   d5                              ; 00A42
        add.l   d5,d1                           ; 00A44
        move.w  d7,d5                           ; 00A46
        moveq   #$0,d7                          ; 00A48
        add.w   a4,d5                           ; 00A4A
        subi.w  #$14,d5                         ; 00A4C
        blt.b   l_037_00A5C                     ; 00A50
        cmp.w   a4,d5                           ; 00A52
        bge.b   l_037_00A3C                     ; 00A54
        move.w  d5,d5                           ; 00A56
        rts                                     ; 00A58
	dc.b	$7E,$00
l_037_00A5C:
        moveq   #$0,d5                          ; 00A5C
        rts                                     ; 00A5E
h037_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    11,181                          ; 11 longs pointing into hunk 181
	dc.l	$42,$7C,$116,$1DC,$21E,$240,$630,$742
	dc.l	$84A,$892,$976
        dc.l    97,71                           ; 97 longs pointing into hunk 71
	dc.l	$356,$4E0,$540,$6D4,$78C,$9F2,$350,$4DA
	dc.l	$53A,$6CE,$786,$9EC,$1C,$BA,$1C2,$606
	dc.l	$70C,$7F2,$908,$36E,$4D4,$7D6,$9BA,$2AE
	dc.l	$2B8,$3A0,$3B8,$3CE,$42A,$43C,$446,$4F0
	dc.l	$4FA,$7DE,$9DE,$A04,$8BE,$A1C,$596,$6C0
	dc.l	$6C8,$69C,$562,$56A,$5E6,$5B2,$5BA,$5F0
	dc.l	$506,$50E,$49E,$4A6,$342,$34A,$270,$282
	dc.l	$25A,$27A,$6A6,$8DA,$8CC,$8E6,$8F4,$8FC
	dc.l	$268,$8C4,$A6,$AE,$D6,$DE,$1B0,$1B8
	dc.l	$2A2,$38A,$462,$4C2,$7C6,$7CC,$F2,$52A
	dc.l	$586,$5D6,$68C,$712,$7F8,$924,$290,$378
	dc.l	$452,$4B0,$7AA,$7B8,$9C4,$14A,$172,$A24
	dc.l	$154
        dc.l    6,62                            ; 6 longs pointing into hunk 62
	dc.l	$960,$66E,$66A,$666,$662,$6F0
        dc.l    14,2                            ; 14 longs pointing into hunk 2
	dc.l	$2E6,$2EA,$2EE,$2F2,$2E2,$92,$96,$9A
	dc.l	$9E,$0,$4,$8,$C,$10
        dc.l    11,36                           ; 11 longs pointing into hunk 36
	dc.l	$2C2,$2D2,$3AA,$3C2,$3DA,$484,$490,$474
	dc.l	$500,$7E4,$9E4
	dc.l	0
	dc.l	HUNK_END
	endc
