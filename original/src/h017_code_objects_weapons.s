; F/A-18 Interceptor - hunk 17 (code)
; UpdateAllObjects (every object's update, each frame), LaunchMissile, UpdateMissile,
; falling objects.
; Included by ../f18_main.s.

;===============================================================================
; Hunk 17: CODE, $1A00 bytes
;===============================================================================
	CODE_HUNK	h017

;-------------------------------------------------------------------------------
; UpdateAllObjects - Updates every object for the frame: the small objects' timers count down;
; every 16 frames sub_026_00276; each object's per-frame flag (+$02 bit 0) is cleared; then for
; each of the 16 objects in turn (unrolled): its timer (+$4C), sub_017_005A8, UpdateMissile,
; sub_017_01862 and UpdateObject.
;-------------------------------------------------------------------------------
UpdateAllObjects:
        move.l  d5,-(a7)                        ; 00000
        tst.b   (dat_071_0017E).l               ; 00002
        bne.b   l_017_0004E                     ; 00008
        lea.l   (SmallObjects_04).l,a0          ; 0000A
        subq.w  #$1,(a0)                        ; 00010
        subq.w  #$1,$20(a0)                     ; 00012
        subq.w  #$1,$40(a0)                     ; 00016
        subq.w  #$1,$60(a0)                     ; 0001A
        subq.w  #$1,$80(a0)                     ; 0001E
        subq.w  #$1,$a0(a0)                     ; 00022
        subq.w  #$1,$c0(a0)                     ; 00026
        subq.w  #$1,$e0(a0)                     ; 0002A
        subq.w  #$1,$100(a0)                    ; 0002E
        subq.w  #$1,$120(a0)                    ; 00032
        subq.w  #$1,$140(a0)                    ; 00036
        subq.w  #$1,$160(a0)                    ; 0003A
        subq.w  #$1,$180(a0)                    ; 0003E
        subq.w  #$1,$1a0(a0)                    ; 00042
        subq.w  #$1,$1c0(a0)                    ; 00046
        subq.w  #$1,$1e0(a0)                    ; 0004A
l_017_0004E:
        move.w  (FrameCount).l,d0               ; 0004E
        andi.w  #$f,d0                          ; 00054
        cmpi.w  #$3,d0                          ; 00058
        bne.b   l_017_00064                     ; 0005C
        jsr     (sub_026_00276).l               ; 0005E
l_017_00064:
        lea.l   (ObjectTable).l,a0              ; 00064
        move.w  #$fffe,d0                       ; 0006A
        and.w   d0,$2(a0)                       ; 0006E
        and.w   d0,$202(a0)                     ; 00072
        and.w   d0,$402(a0)                     ; 00076
        and.w   d0,$602(a0)                     ; 0007A
        and.w   d0,$802(a0)                     ; 0007E
        and.w   d0,$a02(a0)                     ; 00082
        and.w   d0,$c02(a0)                     ; 00086
        and.w   d0,$e02(a0)                     ; 0008A
        and.w   d0,$1002(a0)                    ; 0008E
        and.w   d0,$1202(a0)                    ; 00092
        and.w   d0,$1402(a0)                    ; 00096
        and.w   d0,$1602(a0)                    ; 0009A
        and.w   d0,$1802(a0)                    ; 0009E
        and.w   d0,$1a02(a0)                    ; 000A2
        and.w   d0,$1c02(a0)                    ; 000A6
        tst.b   (dat_071_0017E).l               ; 000AA
        bne.b   l_017_000CE                     ; 000B0
        tst.b   (dat_071_0021F).l               ; 000B2
        ble.b   l_017_000C0                     ; 000B8
        subq.b  #$1,(dat_071_0021F).l           ; 000BA
l_017_000C0:
        tst.b   (dat_071_0021E).l               ; 000C0
        ble.b   l_017_000CE                     ; 000C6
        subq.b  #$1,(dat_071_0021E).l           ; 000C8
l_017_000CE:
        bsr.w   sub_017_00430                   ; 000CE
        clr.w   (CurrentObject).l               ; 000D2
        clr.w   (CurrentObjectOffset).l         ; 000D8
        lea.l   (ObjectTable).l,a1              ; 000DE
        lea.l   (Object4).l,a2                  ; 000E4
        tst.b   (dat_071_0017E).l               ; 000EA
        bne.b   l_017_000F6                     ; 000F0
        subq.w  #$1,$4c(a1)                     ; 000F2
l_017_000F6:
        andi.w  #$fffd,$0(a1)                   ; 000F6
        bsr.w   sub_017_005A8                   ; 000FC
        bsr.w   UpdateMissile                   ; 00100
        bsr.w   sub_017_01862                   ; 00104
        jsr     (UpdateObject).l                ; 00108
        move.w  #$1,(CurrentObject).l           ; 0010E
        move.w  #$200,(CurrentObjectOffset).l   ; 00116
        lea.l   (Object1).l,a1                  ; 0011E
        lea.l   (ObjectTable).l,a2              ; 00124
        btst    #$6,$1(a1)                      ; 0012A
        bne.w   l_017_00148                     ; 00130
        tst.b   (LaunchRequest).l               ; 00134
        bne.b   l_017_00144                     ; 0013A
        bsr.w   sub_017_00468                   ; 0013C
        bne.b   l_017_00148                     ; 00140
        bra.b   l_017_00154                     ; 00142
l_017_00144:
        bsr.w   sub_017_00ACC                   ; 00144
l_017_00148:
        bsr.w   sub_017_00DFE                   ; 00148
        beq.b   l_017_00154                     ; 0014C
        jsr     (UpdateObject).l                ; 0014E
l_017_00154:
        move.w  #$2,(CurrentObject).l           ; 00154
        move.w  #$400,(CurrentObjectOffset).l   ; 0015C
        lea.l   (Object2).l,a1                  ; 00164
        lea.l   (ObjectTable).l,a2              ; 0016A
        btst    #$6,$1(a1)                      ; 00170
        bne.b   l_017_0018C                     ; 00176
        tst.b   (LaunchRequest).l               ; 00178
        bne.b   l_017_00188                     ; 0017E
        bsr.w   sub_017_00468                   ; 00180
        bne.b   l_017_0018C                     ; 00184
        bra.b   l_017_00198                     ; 00186
l_017_00188:
        bsr.w   sub_017_00ACC                   ; 00188
l_017_0018C:
        bsr.w   sub_017_00DFE                   ; 0018C
        beq.b   l_017_00198                     ; 00190
        jsr     (UpdateObject).l                ; 00192
l_017_00198:
        move.w  #$3,(CurrentObject).l           ; 00198
        move.w  #$600,(CurrentObjectOffset).l   ; 001A0
        lea.l   (Object3).l,a1                  ; 001A8
        lea.l   (ObjectTable).l,a2              ; 001AE
        btst    #$6,$1(a1)                      ; 001B4
        bne.b   l_017_001D0                     ; 001BA
        tst.b   (LaunchRequest).l               ; 001BC
        bne.b   l_017_001CC                     ; 001C2
        bsr.w   sub_017_00468                   ; 001C4
        bne.b   l_017_001D0                     ; 001C8
        bra.b   l_017_001DC                     ; 001CA
l_017_001CC:
        bsr.w   sub_017_00ACC                   ; 001CC
l_017_001D0:
        bsr.w   sub_017_00DFE                   ; 001D0
        beq.b   l_017_001DC                     ; 001D4
        jsr     (UpdateObject).l                ; 001D6
l_017_001DC:
        lea.l   (Object4).l,a1                  ; 001DC
        btst    #$6,$1(a1)                      ; 001E2
        beq.b   l_017_0020A                     ; 001E8
        move.w  #$4,(CurrentObject).l           ; 001EA
        move.w  #$800,(CurrentObjectOffset).l   ; 001F2
        bsr.w   sub_017_0072A                   ; 001FA
        bsr.w   sub_017_00DFE                   ; 001FE
        beq.b   l_017_0020A                     ; 00202
        jsr     (UpdateObject).l                ; 00204
l_017_0020A:
        move.w  #$5,(CurrentObject).l           ; 0020A
        move.w  #$a00,(CurrentObjectOffset).l   ; 00212
        lea.l   (Object5).l,a1                  ; 0021A
        lea.l   (Object4).l,a2                  ; 00220
        btst    #$6,$1(a1)                      ; 00226
        bne.b   l_017_00242                     ; 0022C
        tst.b   (dat_071_0018B).l               ; 0022E
        bne.b   l_017_0023E                     ; 00234
        bsr.w   sub_017_00496                   ; 00236
        bne.b   l_017_00242                     ; 0023A
        bra.b   l_017_0024E                     ; 0023C
l_017_0023E:
        bsr.w   LaunchMissile                   ; 0023E
l_017_00242:
        bsr.w   sub_017_00DFE                   ; 00242
        beq.b   l_017_0024E                     ; 00246
        jsr     (UpdateObject).l                ; 00248
l_017_0024E:
        lea.l   (Object6).l,a1                  ; 0024E
        btst    #$6,$1(a1)                      ; 00254
        beq.b   l_017_00278                     ; 0025A
        move.w  #$6,(CurrentObject).l           ; 0025C
        move.w  #$c00,(CurrentObjectOffset).l   ; 00264
        bsr.w   sub_017_00DFE                   ; 0026C
        beq.b   l_017_00278                     ; 00270
        jsr     (UpdateObject).l                ; 00272
l_017_00278:
        move.w  #$7,(CurrentObject).l           ; 00278
        move.w  #$e00,(CurrentObjectOffset).l   ; 00280
        lea.l   (Object7).l,a1                  ; 00288
        lea.l   (Object6).l,a2                  ; 0028E
        btst    #$6,$1(a1)                      ; 00294
        lea.l   (Object8).l,a1                  ; 0029A
        btst    #$6,$1(a1)                      ; 002A0
        beq.b   l_017_002C4                     ; 002A6
        move.w  #$8,(CurrentObject).l           ; 002A8
        move.w  #$1000,(CurrentObjectOffset).l  ; 002B0
        bsr.w   sub_017_00DFE                   ; 002B8
        beq.b   l_017_002C4                     ; 002BC
        jsr     (UpdateObject).l                ; 002BE
l_017_002C4:
        move.w  #$9,(CurrentObject).l           ; 002C4
        move.w  #$1200,(CurrentObjectOffset).l  ; 002CC
        lea.l   (Object9).l,a1                  ; 002D4
        lea.l   (Object8).l,a2                  ; 002DA
        btst    #$6,$1(a1)                      ; 002E0
        bne.b   l_017_002F2                     ; 002E6
        bsr.w   sub_017_00522                   ; 002E8
        beq.b   l_017_002FE                     ; 002EC
        bsr.w   LaunchMissile                   ; 002EE
l_017_002F2:
        bsr.w   sub_017_00DFE                   ; 002F2
        beq.b   l_017_002FE                     ; 002F6
        jsr     (UpdateObject).l                ; 002F8
l_017_002FE:
        lea.l   (Object10).l,a1                 ; 002FE
        btst    #$6,$1(a1)                      ; 00304
        beq.b   l_017_00328                     ; 0030A
        move.w  #$a,(CurrentObject).l           ; 0030C
        move.w  #$1400,(CurrentObjectOffset).l  ; 00314
        bsr.w   sub_017_00DFE                   ; 0031C
        beq.b   l_017_00328                     ; 00320
        jsr     (UpdateObject).l                ; 00322
l_017_00328:
        move.w  #$b,(CurrentObject).l           ; 00328
        move.w  #$1600,(CurrentObjectOffset).l  ; 00330
        lea.l   (Object11).l,a1                 ; 00338
        lea.l   (Object10).l,a2                 ; 0033E
        btst    #$6,$1(a1)                      ; 00344
        bne.b   l_017_00356                     ; 0034A
        bsr.w   sub_017_00522                   ; 0034C
        beq.b   l_017_00362                     ; 00350
        bsr.w   LaunchMissile                   ; 00352
l_017_00356:
        bsr.w   sub_017_00DFE                   ; 00356
        beq.b   l_017_00362                     ; 0035A
        jsr     (UpdateObject).l                ; 0035C
l_017_00362:
        lea.l   (Object12).l,a1                 ; 00362
        btst    #$6,$1(a1)                      ; 00368
        beq.b   l_017_0038C                     ; 0036E
        move.w  #$c,(CurrentObject).l           ; 00370
        move.w  #$1800,(CurrentObjectOffset).l  ; 00378
        bsr.w   sub_017_00DFE                   ; 00380
        beq.b   l_017_0038C                     ; 00384
        jsr     (UpdateObject).l                ; 00386
l_017_0038C:
        move.w  #$d,(CurrentObject).l           ; 0038C
        move.w  #$1a00,(CurrentObjectOffset).l  ; 00394
        lea.l   (Object13).l,a1                 ; 0039C
        lea.l   (Object12).l,a2                 ; 003A2
        btst    #$6,$1(a1)                      ; 003A8
        bne.b   l_017_003BA                     ; 003AE
        bsr.w   sub_017_00522                   ; 003B0
        beq.b   l_017_003C6                     ; 003B4
        bsr.w   LaunchMissile                   ; 003B6
l_017_003BA:
        bsr.w   sub_017_00DFE                   ; 003BA
        beq.b   l_017_003C6                     ; 003BE
        jsr     (UpdateObject).l                ; 003C0
l_017_003C6:
        lea.l   (Object14).l,a1                 ; 003C6
        btst    #$6,$1(a1)                      ; 003CC
        beq.b   l_017_003F6                     ; 003D2
        bset    #$2,$1(a1)                      ; 003D4
        move.w  #$e,(CurrentObject).l           ; 003DA
        move.w  #$1c00,(CurrentObjectOffset).l  ; 003E2
        bsr.w   sub_017_00DFE                   ; 003EA
        beq.b   l_017_003F6                     ; 003EE
        jsr     (UpdateObject).l                ; 003F0
l_017_003F6:
        lea.l   (Object15).l,a1                 ; 003F6
        btst    #$6,$1(a1)                      ; 003FC
        beq.b   l_017_00426                     ; 00402
        bset    #$2,$1(a1)                      ; 00404
        move.w  #$f,(CurrentObject).l           ; 0040A
        move.w  #$1e00,(CurrentObjectOffset).l  ; 00412
        bsr.w   sub_017_00DFE                   ; 0041A
        beq.b   l_017_00426                     ; 0041E
        jsr     (UpdateObject).l                ; 00420
l_017_00426:
        jsr     (sub_018_00036).l               ; 00426
        move.l  (a7)+,d5                        ; 0042C
        rts                                     ; 0042E
sub_017_00430:
        move.w  (dat_071_00390).l,d0            ; 00430
        blt.b   l_017_00466                     ; 00436
        lea.l   (ObjectTable).l,a1              ; 00438
        adda.w  d0,a1                           ; 0043E
        btst    #$6,$1(a1)                      ; 00440
        beq.b   l_017_00450                     ; 00446
        btst    #$1,$20(a1)                     ; 00448
        beq.b   l_017_00466                     ; 0044E
l_017_00450:
        move.w  #$ffff,(dat_071_00390).l        ; 00450
        clr.b   (dat_071_00238).l               ; 00458
        move.w  #$ffff,(dat_071_0030A).l        ; 0045E
l_017_00466:
        rts                                     ; 00466
sub_017_00468:
        move.l  a2,-(a7)                        ; 00468
        tst.w   (dat_071_00392).l               ; 0046A
        bne.b   l_017_004E0                     ; 00470
        lea.l   (ObjectTable).l,a2              ; 00472
        move.b  $7c(a2),d0                      ; 00478
        move.b  d0,d1                           ; 0047C
        andi.b  #$f,d0                          ; 0047E
        cmpi.b  #$e,d0                          ; 00482
        blt.b   l_017_004AE                     ; 00486
        andi.b  #$f0,d1                         ; 00488
        move.b  d1,$7c(a2)                      ; 0048C
        bsr.w   sub_017_00A96                   ; 00490
        bra.b   l_017_004EE                     ; 00494
sub_017_00496:
        move.l  a2,-(a7)                        ; 00496
        tst.w   (dat_071_00392).l               ; 00498
        bne.b   l_017_004E0                     ; 0049E
        lea.l   (ObjectTable).l,a2              ; 004A0
        move.b  $7c(a2),d0                      ; 004A6
        andi.b  #$f,d0                          ; 004AA
l_017_004AE:
        cmpi.b  #$9,d0                          ; 004AE
        bne.b   l_017_004C2                     ; 004B2
        tst.b   (dat_071_00155).l               ; 004B4
        bne.b   l_017_004C2                     ; 004BA
        bsr.w   sub_017_00506                   ; 004BC
        bra.b   l_017_004E0                     ; 004C0
l_017_004C2:
        cmpi.b  #$1,d0                          ; 004C2
        bne.b   l_017_004E4                     ; 004C6
        move.b  #$3f,(dat_071_0023A).l          ; 004C8
        move.b  #$78,(dat_071_00239).l          ; 004D0
        move.b  #$ff,(dat_071_00188).l          ; 004D8
l_017_004E0:
        moveq   #$0,d0                          ; 004E0
        bra.b   l_017_004F0                     ; 004E2
l_017_004E4:
        cmpi.b  #$3,d0                          ; 004E4
        bne.b   l_017_004E0                     ; 004E8
        bsr.w   sub_017_00A2A                   ; 004EA
l_017_004EE:
        moveq   #$1,d0                          ; 004EE
l_017_004F0:
        movea.l (a7)+,a2                        ; 004F0
        rts                                     ; 004F2
dat_017_004F4:
	dc.b	$00,$C8,$00,$0E,$00,$08,$00,$C8,$00,$00,$00,$02,$00,$01,$00,$05
	dc.b	$00,$01
sub_017_00506:
        move.l  a1,-(a7)                        ; 00506
        lea.l   dat_017_004F4(pc),a1            ; 00508
        movem.w (a1),d0-d7/a0                   ; 0050C
        movem.l d0-d7/a0,-(a7)                  ; 00510
        jsr     (sub_000_0A042).l               ; 00514
        adda.w  #$24,a7                         ; 0051A
        movea.l (a7)+,a1                        ; 0051E
        rts                                     ; 00520
sub_017_00522:
        move.w  $0(a2),d0                       ; 00522
        andi.w  #$8700,d0                       ; 00526
        bne.b   l_017_0059A                     ; 0052A
        btst    #$1,$20(a2)                     ; 0052C
        bne.b   l_017_0059A                     ; 00532
        tst.b   (dat_071_0018C).l               ; 00534
        bne.b   l_017_0059E                     ; 0053A
        btst    #$6,$1(a2)                      ; 0053C
        beq.b   l_017_0059A                     ; 00542
        move.b  $38(a2),d0                      ; 00544
        bge.b   l_017_00570                     ; 00548
        andi.w  #$7f,d0                         ; 0054A
        asl.w   #$8,d0                          ; 0054E
        add.w   d0,d0                           ; 00550
        lea.l   (ObjectTable).l,a3              ; 00552
        btst    #$6,$1(a3,d0.w)                 ; 00558
        beq.b   l_017_0059A                     ; 0055E
        btst    #$1,$20(a3,d0.w)                ; 00560
        bne.b   l_017_0059A                     ; 00566
        btst    #$0,$1(a3,d0.w)                 ; 00568
        bne.b   l_017_0059A                     ; 0056E
l_017_00570:
        move.b  $64(a2),d0                      ; 00570
        andi.b  #$60,d0                         ; 00574
        cmpi.b  #$60,d0                         ; 00578
        bne.b   l_017_0059A                     ; 0057C
        btst    #$0,$1(a2)                      ; 0057E
        beq.b   l_017_0059A                     ; 00584
        move.b  $63(a2),d0                      ; 00586
        andi.b  #$f0,d0                         ; 0058A
        cmpi.b  #$20,d0                         ; 0058E
        beq.b   l_017_0059E                     ; 00592
        cmpi.b  #$30,d0                         ; 00594
        beq.b   l_017_0059E                     ; 00598
l_017_0059A:
        moveq   #$0,d0                          ; 0059A
        rts                                     ; 0059C
l_017_0059E:
        clr.b   (dat_071_0018C).l               ; 0059E
        moveq   #$1,d0                          ; 005A4
        rts                                     ; 005A6
sub_017_005A8:
        move.w  $56(a1),d0                      ; 005A8
        move.w  d0,d1                           ; 005AC
        asr.w   #$3,d1                          ; 005AE
        add.w   d1,d0                           ; 005B0
        add.w   (dat_071_00316).l,d0            ; 005B2
        asr.w   #$3,d0                          ; 005B8
        bge.b   l_017_005BE                     ; 005BA
        neg.w   d0                              ; 005BC
l_017_005BE:
        cmpi.w  #$4e,d0                         ; 005BE
        blt.b   l_017_005DE                     ; 005C2
        tst.b   (dat_071_00258).l               ; 005C4
        bne.b   l_017_005E4                     ; 005CA
        move.b  #$1,(dat_071_00258).l           ; 005CC
        moveq   #$8,d0                          ; 005D4
        jsr     (sub_039_0186E).l               ; 005D6
        bra.b   l_017_005E4                     ; 005DC
l_017_005DE:
        clr.b   (dat_071_00258).l               ; 005DE
l_017_005E4:
        cmpi.b  #$7d,(dat_071_00276).l          ; 005E4
        bne.w   l_017_006C0                     ; 005EC
        bclr    #$3,$2(a1)                      ; 005F0
        beq.w   l_017_006C0                     ; 005F6
        move.b  (dat_071_00169).l,d0            ; 005FA
        cmpi.b  #$ff,(dat_071_0016A).l          ; 00600
        beq.b   l_017_00616                     ; 00608
        addq.b  #$1,d0                          ; 0060A
        cmpi.b  #$7,d0                          ; 0060C
        ble.b   l_017_00616                     ; 00610
        move.b  #$1,d0                          ; 00612
l_017_00616:
        move.b  d0,(dat_071_00169).l            ; 00616
        addq.b  #$1,d0                          ; 0061C
        cmpi.b  #$7,d0                          ; 0061E
        ble.b   l_017_00628                     ; 00622
        move.b  #$1,d0                          ; 00624
l_017_00628:
        ext.w   d0                              ; 00628
        asl.w   #$3,d0                          ; 0062A
        lea.l   (dat_017_009A2).l,a5            ; 0062C
        move.w  (a5,d0.w),d0                    ; 00632
        jsr     (sub_020_00954).l               ; 00636
        move.b  #$fe,(dat_071_0016A).l          ; 0063C
        move.b  $63(a1),d1                      ; 00644
        lea.l   (a2),a4                         ; 00648
        lea.l   (a1),a5                         ; 0064A
        moveq   #$28,d0                         ; 0064C
l_017_0064E:
        move.l  (a4)+,(a5)+                     ; 0064E
        dbra    d0,l_017_0064E                  ; 00650
        move.b  d1,$63(a1)                      ; 00654
        clr.b   $5e(a1)                         ; 00658
        move.b  #$11,$62(a1)                    ; 0065C
        bclr    #$0,$2(a1)                      ; 00662
        clr.b   $5(a1)                          ; 00668
        clr.b   $65(a1)                         ; 0066C
        moveq   #$9,d3                          ; 00670
        moveq   #$1,d4                          ; 00672
        move.w  #$ff9f,d5                       ; 00674
        exg.l   a1,a2                           ; 00678
        jsr     (sub_004_00328).l               ; 0067A
        exg.l   a1,a2                           ; 00680
        move.l  d0,$14(a1)                      ; 00682
        move.l  d1,$18(a1)                      ; 00686
        move.l  d2,$1c(a1)                      ; 0068A
        move.l  d0,d3                           ; 0068E
        move.l  d2,d4                           ; 00690
        asr.l   #$8,d3                          ; 00692
        asr.l   #$8,d4                          ; 00694
        andi.w  #$3fff,d3                       ; 00696
        andi.w  #$3fff,d4                       ; 0069A
        swap    d0                              ; 0069E
        swap    d2                              ; 006A0
        asr.w   #$6,d0                          ; 006A2
        asr.w   #$6,d2                          ; 006A4
        movem.w d0/d2,$6(a1)                    ; 006A6
        movem.w d3-d4,$c(a1)                    ; 006AC
        asr.l   #$8,d1                          ; 006B2
        move.l  d1,$10(a1)                      ; 006B4
        move.b  #$ff,(RedrawFlags).l            ; 006B8
l_017_006C0:
        tst.b   (dat_071_0016C).l               ; 006C0
        blt.b   l_017_00728                     ; 006C6
        tst.b   (dat_071_0017E).l               ; 006C8
        bne.b   l_017_00728                     ; 006CE
        beq.w   l_017_00756                     ; 006D0
        move.b  (dat_071_00169).l,d0            ; 006D4
        ext.w   d0                              ; 006DA
        asl.w   #$2,d0                          ; 006DC
        lea.l   (dat_017_009EA).l,a3            ; 006DE
        movea.l (a3,d0.w),a3                    ; 006E4
        movea.l (a3),a3                         ; 006E8
        lea.l   $2(a3),a3                       ; 006EA
        lea.l   (dat_073_0162A).l,a4            ; 006EE
        adda.w  (a4),a3                         ; 006F4
        move.b  $65(a1),(a3)                    ; 006F6
        addq.w  #$1,(a4)                        ; 006FA
        cmpi.w  #$1fd,(a4)                      ; 006FC
        blt.b   l_017_00728                     ; 00700
        move.b  #$ff,(a3)                       ; 00702
        move.b  #$ff,(dat_071_0016C).l          ; 00706
        move.b  (dat_071_00169).l,d0            ; 0070E
        ext.w   d0                              ; 00714
        asl.w   #$2,d0                          ; 00716
        lea.l   (dat_017_009EA).l,a3            ; 00718
        movea.l (a3,d0.w),a3                    ; 0071E
        movea.l (a3),a3                         ; 00722
        move.w  (a4),$0(a3)                     ; 00724
l_017_00728:
        rts                                     ; 00728
sub_017_0072A:
        cmpi.b  #$7d,(dat_071_00276).l          ; 0072A
        bne.b   l_017_00756                     ; 00732
        btst    #$0,$2(a1)                      ; 00734
        bne.b   l_017_00756                     ; 0073A
        clr.b   $5(a1)                          ; 0073C
        tst.w   (Player_6E).l                   ; 00740
        beq.w   l_017_008CA                     ; 00746
        bset    #$0,$2(a1)                      ; 0074A
        clr.w   (dat_073_0162A).l               ; 00750
l_017_00756:
        tst.b   (dat_071_0017E).l               ; 00756
        bne.w   l_017_008CA                     ; 0075C
        btst    #$0,$2(a1)                      ; 00760
        beq.w   l_017_008CA                     ; 00766
        cmpi.b  #$2,(dat_071_00276).l           ; 0076A
        bne.b   l_017_007B8                     ; 00772
        tst.b   (dat_071_00163).l               ; 00774
        beq.w   l_017_008CA                     ; 0077A
        bclr    #$3,(Player_02).l               ; 0077E
        beq.b   l_017_007B8                     ; 00786
        move.l  a1,-(a7)                        ; 00788
        clr.w   $0(a1)                          ; 0078A
        jsr     (sub_026_00002).l               ; 0078E
        movea.l (a7)+,a1                        ; 00794
        bset    #$0,$2(a1)                      ; 00796
        move.b  #$60,$2b(a1)                    ; 0079C
        bsr.w   sub_017_008F8                   ; 007A2
        lea.l   (dat_017_009EA).l,a3            ; 007A6
        move.b  (dat_071_00169).l,d0            ; 007AC
        ext.w   d0                              ; 007B2
        asl.w   #$3,d0                          ; 007B4
        bra.b   l_017_007FA                     ; 007B6
l_017_007B8:
        lea.l   (dat_017_009EA).l,a3            ; 007B8
        move.b  (dat_071_00169).l,d0            ; 007BE
        ext.w   d0                              ; 007C4
        asl.w   #$3,d0                          ; 007C6
        bgt.b   l_017_007FA                     ; 007C8
        cmpi.b  #$2,(dat_071_00276).l           ; 007CA
        bne.b   l_017_007FA                     ; 007D2
        move.b  #$60,$2b(a1)                    ; 007D4
        move.b  #$fe,(dat_071_00280).l          ; 007DA
        move.l  $4(a3,d0.w),d0                  ; 007E2
        beq.w   l_017_008CA                     ; 007E6
        blt.w   l_017_0081C                     ; 007EA
        cmpi.w  #$14,(dat_073_0162A).l          ; 007EE
        bgt.b   l_017_0081C                     ; 007F6
        bra.b   l_017_00806                     ; 007F8
l_017_007FA:
        move.l  $4(a3,d0.w),d0                  ; 007FA
        beq.w   l_017_008CA                     ; 007FE
        blt.w   l_017_008CC                     ; 00802
l_017_00806:
        movea.l d0,a3                           ; 00806
        movea.l (a3),a3                         ; 00808
        lea.l   $2(a3),a3                       ; 0080A
        lea.l   (dat_073_0162A).l,a4            ; 0080E
        adda.w  (a4),a3                         ; 00814
        move.b  (a3),d0                         ; 00816
        bge.w   l_017_0089C                     ; 00818
l_017_0081C:
        cmpi.b  #$2,(dat_071_00276).l           ; 0081C
        beq.b   l_017_0086A                     ; 00824
        bclr    #$3,$2(a1)                      ; 00826
        bne.b   l_017_0086A                     ; 0082C
        tst.b   (dat_071_0016A).l               ; 0082E
        blt.w   l_017_008CA                     ; 00834
        move.b  #$ff,(dat_071_0016A).l          ; 00838
        move.b  (dat_071_00169).l,d0            ; 00840
        addq.b  #$1,d0                          ; 00846
        cmpi.b  #$7,d0                          ; 00848
        ble.b   l_017_00852                     ; 0084C
        move.b  #$1,d0                          ; 0084E
l_017_00852:
        ext.w   d0                              ; 00852
        asl.w   #$3,d0                          ; 00854
        lea.l   (dat_017_009A2).l,a5            ; 00856
        move.w  (a5,d0.w),d0                    ; 0085C
        jsr     (sub_020_00954).l               ; 00860
        bra.w   l_017_008CA                     ; 00866
l_017_0086A:
        clr.b   (dat_071_0016A).l               ; 0086A
        cmpi.b  #$7,(dat_071_00169).l           ; 00870
        blt.b   l_017_00894                     ; 00878
        move.l  a1,-(a7)                        ; 0087A
        clr.w   $0(a1)                          ; 0087C
        jsr     (sub_026_00002).l               ; 00880
        movea.l (a7)+,a1                        ; 00886
        bset    #$0,$2(a1)                      ; 00888
        move.b  #$60,$2b(a1)                    ; 0088E
l_017_00894:
        bsr.w   sub_017_008F8                   ; 00894
        bra.w   l_017_007B8                     ; 00898
l_017_0089C:
        bclr    #$3,$2(a1)                      ; 0089C
        move.b  d0,$65(a1)                      ; 008A2
        addq.w  #$1,(a4)                        ; 008A6
        cmpi.w  #$1fd,(a4)                      ; 008A8
        blt.b   l_017_008CA                     ; 008AC
        move.w  #$1d,d0                         ; 008AE
        jsr     (sub_020_00954).l               ; 008B2
        bra.b   l_017_008C4                     ; 008B8
	dc.b	$30,$3C,$00,$1E,$4E,$B9
        dc.l    sub_020_00954                   ; 008C0
l_017_008C4:
        bclr    #$0,$2(a1)                      ; 008C4
l_017_008CA:
        rts                                     ; 008CA
l_017_008CC:
        tst.w   (dat_073_0162A).l               ; 008CC
        beq.b   l_017_008E4                     ; 008D2
        tst.b   $5(a1)                          ; 008D4
        bne.b   l_017_008CA                     ; 008D8
        andi.b  #$c3,$65(a1)                    ; 008DA
        bra.w   l_017_0081C                     ; 008E0
l_017_008E4:
        bclr    #$3,$2(a1)                      ; 008E4
        move.b  d0,$5(a1)                       ; 008EA
        move.w  #$1,(dat_073_0162A).l           ; 008EE
        rts                                     ; 008F6
sub_017_008F8:
        move.b  (dat_071_00169).l,d0            ; 008F8
        addq.b  #$1,d0                          ; 008FE
        cmpi.b  #$7,d0                          ; 00900
        ble.b   l_017_0090A                     ; 00904
        move.b  #$1,d0                          ; 00906
l_017_0090A:
        move.b  d0,(dat_071_00169).l            ; 0090A
        clr.b   (dat_071_00176).l               ; 00910
        clr.w   (dat_073_0162A).l               ; 00916
        clr.b   $65(a1)                         ; 0091C
        move.b  (dat_071_00169).l,d0            ; 00920
        bgt.b   l_017_0092A                     ; 00926
        moveq   #$1,d0                          ; 00928
l_017_0092A:
        ext.w   d0                              ; 0092A
        move.w  d0,d1                           ; 0092C
        move.w  (CurrentObject).l,d0            ; 0092E
        cmp.w   (dat_071_002AC).l,d0            ; 00934
        bne.b   l_017_0094E                     ; 0093A
        asl.w   #$3,d0                          ; 0093C
        lea.l   (dat_017_009EA).l,a5            ; 0093E
        adda.w  d0,a5                           ; 00944
        move.l  (a5),d0                         ; 00946
        move.b  d0,(dat_071_00282).l            ; 00948
l_017_0094E:
        cmpi.b  #$2,(dat_071_00276).l           ; 0094E
        bne.b   l_017_00970                     ; 00956
        tst.b   (dat_071_00155).l               ; 00958
        beq.b   l_017_00970                     ; 0095E
        lsr.w   #$8,d0                          ; 00960
        andi.b  #$ff,d0                         ; 00962
        bgt.b   l_017_0096A                     ; 00966
        moveq   #-1,d0                          ; 00968
l_017_0096A:
        move.b  d0,(dat_071_00155).l            ; 0096A
l_017_00970:
        move.b  #$ff,(RedrawFlags).l            ; 00970
        cmpi.b  #$4,d1                          ; 00978
        bne.b   l_017_0098E                     ; 0097C
        cmpi.l  #$100000,$18(a1)                ; 0097E
        bgt.b   l_017_0098E                     ; 00986
        move.w  #$35,d0                         ; 00988
        bra.b   l_017_0099A                     ; 0098C
l_017_0098E:
        lea.l   (dat_017_009A2).l,a5            ; 0098E
        asl.w   #$3,d1                          ; 00994
        move.w  $2(a5,d1.w),d0                  ; 00996
l_017_0099A:
        jsr     (sub_020_00954).l               ; 0099A
        rts                                     ; 009A0
dat_017_009A2:
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$2E,$00,$17,$00,$00,$00,$00
	dc.b	$00,$31,$00,$1A,$00,$00,$00,$00,$00,$30,$00,$19,$00,$00,$00,$00
	dc.b	$00,$32,$00,$1B,$00,$00,$00,$00,$00,$33,$00,$2B,$00,$00,$00,$00
	dc.b	$00,$2F,$00,$18,$00,$00,$00,$00,$00,$34,$00,$1C,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00
dat_017_009EA:
	dc.b	$00,$00,$01,$03,$80,$00,$00,$23,$00,$00,$01,$03,$80,$00,$00,$0B
	dc.b	$00,$00,$01,$03,$80,$00,$00,$27,$00,$00,$01,$03,$80,$00,$00,$0E
	dc.b	$00,$00,$01,$03,$80,$00,$00,$11,$00,$00,$01,$03,$80,$00,$00,$14
	dc.b	$00,$00,$01,$03,$80,$00,$00,$17,$00,$00,$01,$01,$80,$00,$00,$1A
sub_017_00A2A:
        move.l  a1,d1                           ; 00A2A
        subi.l  #ObjectTable,d1                 ; 00A2C
        move.w  d1,(dat_071_00392).l            ; 00A32
        tst.b   (dat_071_00155).l               ; 00A38
        bne.b   l_017_00A4C                     ; 00A3E
        move.w  (CurrentObject).l,d1            ; 00A40
        jsr     (sub_005_012D0).l               ; 00A46
l_017_00A4C:
        lea.l   (a2),a4                         ; 00A4C
        lea.l   (a1),a5                         ; 00A4E
        moveq   #$28,d0                         ; 00A50
l_017_00A52:
        move.l  (a4)+,(a5)+                     ; 00A52
        dbra    d0,l_017_00A52                  ; 00A54
        bclr    #$7,$0(a1)                      ; 00A58
        move.b  #$30,$62(a1)                    ; 00A5E
        move.w  #$e10,d0                        ; 00A64
        move.w  #$3840,d2                       ; 00A68
        move.w  #$3840,d4                       ; 00A6C
        lea.l   $80(a1),a4                      ; 00A70
        movem.l a1-a2,-(a7)                     ; 00A74
        jsr     (sub_032_00AD8).l               ; 00A78
        movem.w d4-d6,$66(a1)                   ; 00A7E
        jsr     (SetAttitude).l                 ; 00A84
        movem.l (a7)+,a1-a2                     ; 00A8A
        move.w  #$28,d0                         ; 00A8E
        bra.w   l_017_00BDA                     ; 00A92
sub_017_00A96:
        move.l  a1,d1                           ; 00A96
        subi.l  #ObjectTable,d1                 ; 00A98
        move.w  d1,(dat_071_00292).l            ; 00A9E
        lea.l   (a2),a4                         ; 00AA4
        lea.l   (a1),a5                         ; 00AA6
        moveq   #$28,d0                         ; 00AA8
l_017_00AAA:
        move.l  (a4)+,(a5)+                     ; 00AAA
        dbra    d0,l_017_00AAA                  ; 00AAC
        bclr    #$7,$0(a1)                      ; 00AB0
        move.b  #$31,$62(a1)                    ; 00AB6
        move.w  #$dc,d0                         ; 00ABC
        bra.w   l_017_00BDA                     ; 00AC0
l_017_00AC4:
        bclr    #$6,$1(a1)                      ; 00AC4
        rts                                     ; 00ACA
sub_017_00ACC:
        clr.b   (LaunchRequest).l               ; 00ACC
        move.b  #$1,(dat_071_00187).l           ; 00AD2
        move.l  (WarningFlags).l,d6             ; 00ADA
        andi.l  #$4000,d6                       ; 00AE0
        beq.b   l_017_00B38                     ; 00AE6
        andi.l  #$ffffbfff,(WarningFlags).l     ; 00AE8
        ori.l   #$8,(SoundRequests).l           ; 00AF2
        bra.b   l_017_00B38                     ; 00AFC

;-------------------------------------------------------------------------------
; LaunchMissile - LaunchMissile(a2 = the launcher, a1 = the new object): fires the launcher's
; selected missile, if it has one left (+$5F: low nibble AMRAAMs, high nibble Sidewinders; a
; computer aircraft only every 8, 6 or 4 frames by Difficulty, while dat_071_00159 allows it).
; The missile starts as a copy of the launcher's record (its first $A4 bytes); its type (+$62)
; is 1 for an AIM-120 AMRAAM (weapon $30), 0 for an AIM-9L Sidewinder; the player's launches
; are counted in the flight log (+$3E AMRAAMs, +$42 Sidewinders fired). It is placed at its
; pylon (dat_017_00DA6, turned by the launcher's orientation +$92) and given the launcher's
; velocity plus a push along its nose.
;-------------------------------------------------------------------------------
LaunchMissile:
        tst.b   (dat_071_00159).l               ; 00AFE
        beq.b   l_017_00AC4                     ; 00B04
        cmpi.b  #$3,(Difficulty).l              ; 00B06
        bge.b   l_017_00B22                     ; 00B0E
        cmpi.b  #$2,(Difficulty).l              ; 00B10
        bge.b   l_017_00B1E                     ; 00B18
        moveq   #$7,d1                          ; 00B1A
        bra.b   l_017_00B24                     ; 00B1C
l_017_00B1E:
        moveq   #$5,d1                          ; 00B1E
        bra.b   l_017_00B24                     ; 00B20
l_017_00B22:
        moveq   #$3,d1                          ; 00B22
l_017_00B24:
        tst.b   (dat_071_00285).l               ; 00B24
        beq.b   l_017_00B2E                     ; 00B2A
        lsr.w   #$1,d1                          ; 00B2C
l_017_00B2E:
        move.w  (FrameCount).l,d0               ; 00B2E
        and.w   d1,d0                           ; 00B34
        bne.b   l_017_00AC4                     ; 00B36
l_017_00B38:
        move.b  $5f(a2),d1                      ; 00B38
        move.b  $63(a2),d0                      ; 00B3C
        andi.b  #$f0,d0                         ; 00B40
        cmpi.b  #$30,d0                         ; 00B44
        beq.b   l_017_00B50                     ; 00B48
        andi.b  #$f0,d1                         ; 00B4A
        bra.b   l_017_00B54                     ; 00B4E
l_017_00B50:
        andi.b  #$f,d1                          ; 00B50
l_017_00B54:
        beq.w   l_017_00AC4                     ; 00B54
        move.l  a2,d0                           ; 00B58
        subi.l  #ObjectTable,d0                 ; 00B5A
        cmp.w   (ViewObject).l,d0               ; 00B60
        bne.b   l_017_00B78                     ; 00B66
        move.b  #$8,(dat_071_00167).l           ; 00B68
        move.b  #$fb,(dat_071_00280).l          ; 00B70
l_017_00B78:
        lea.l   (a2),a4                         ; 00B78
        lea.l   (a1),a5                         ; 00B7A
        moveq   #$28,d0                         ; 00B7C
l_017_00B7E:
        move.l  (a4)+,(a5)+                     ; 00B7E
        dbra    d0,l_017_00B7E                  ; 00B80
        clr.b   $5(a1)                          ; 00B84
        movea.l (ConfigBuffer).l,a0             ; 00B88
        move.b  $63(a1),d0                      ; 00B8E
        andi.b  #$f0,d0                         ; 00B92
        cmpi.b  #$30,d0                         ; 00B96
        bne.b   l_017_00BBC                     ; 00B9A
        move.b  #$1,$62(a1)                     ; 00B9C
        move.w  #$14,d0                         ; 00BA2
        cmpa.l  #ObjectTable,a2                 ; 00BA6
        bne.b   l_017_00BDA                     ; 00BAC
        addq.w  #$1,$3e(a0)                     ; 00BAE
        move.b  #$1,(dat_071_00195).l           ; 00BB2
        bra.b   l_017_00BDA                     ; 00BBA
l_017_00BBC:
        move.b  #$0,$62(a1)                     ; 00BBC
        move.w  #$0,d0                          ; 00BC2
        cmpa.l  #ObjectTable,a2                 ; 00BC6
        bne.b   l_017_00BDA                     ; 00BCC
        addq.w  #$1,$42(a0)                     ; 00BCE
        move.b  #$1,(dat_071_00195).l           ; 00BD2
l_017_00BDA:
        lea.l   (MissileModels).l,a4            ; 00BDA
        adda.w  d0,a4                           ; 00BE0
        lea.l   (ObjectDrawTable).l,a5          ; 00BE2
        move.w  (CurrentObject).l,d3            ; 00BE8
        add.w   d3,d3                           ; 00BEE
        add.w   d3,d3                           ; 00BF0
        move.w  d3,d4                           ; 00BF2
        add.w   d3,d3                           ; 00BF4
        add.w   d3,d3                           ; 00BF6
        add.w   d4,d3                           ; 00BF8
        adda.w  d3,a5                           ; 00BFA
        movem.l (a4),d2-d6                      ; 00BFC
        movem.l d2-d6,(a5)                      ; 00C00
        clr.w   $56(a1)                         ; 00C04
        clr.w   $58(a1)                         ; 00C08
        clr.w   $5a(a1)                         ; 00C0C
        clr.b   $64(a1)                         ; 00C10
        bclr    #$2,$3(a1)                      ; 00C14
        move.b  $62(a1),d1                      ; 00C1A
        andi.b  #$f0,d1                         ; 00C1E
        cmpi.b  #$30,d1                         ; 00C22
        beq.b   l_017_00C8A                     ; 00C26
        move.b  $5f(a2),d1                      ; 00C28
        move.b  d1,d2                           ; 00C2C
        move.b  $63(a2),d0                      ; 00C2E
        andi.b  #$f0,d0                         ; 00C32
        cmpi.b  #$30,d0                         ; 00C36
        beq.b   l_017_00C4E                     ; 00C3A
        andi.b  #$f0,d1                         ; 00C3C
        andi.b  #$f,d2                          ; 00C40
        subi.b  #$10,d1                         ; 00C44
        move.b  d1,d0                           ; 00C48
        lsr.b   #$4,d0                          ; 00C4A
        bra.b   l_017_00C5C                     ; 00C4C
l_017_00C4E:
        andi.b  #$f,d1                          ; 00C4E
        andi.b  #$f0,d2                         ; 00C52
        subq.b  #$1,d1                          ; 00C56
        move.b  d1,d0                           ; 00C58
        addq.b  #$2,d0                          ; 00C5A
l_017_00C5C:
        or.b    d2,d1                           ; 00C5C
        move.b  d1,$5f(a2)                      ; 00C5E
        move.b  #$3,(dat_071_00213).l           ; 00C62
        move.b  #$3,(dat_071_00214).l           ; 00C6A
        cmpi.b  #$10,$62(a2)                    ; 00C72
        beq.b   l_017_00C82                     ; 00C78
        lea.l   (dat_017_00DD6).l,a4            ; 00C7A
        bra.b   l_017_00C9C                     ; 00C80
l_017_00C82:
        lea.l   (dat_017_00DB2).l,a4            ; 00C82
        bra.b   l_017_00C9C                     ; 00C88
l_017_00C8A:
        lea.l   (PylonOffsets).l,a4             ; 00C8A
        moveq   #$0,d0                          ; 00C90
        cmpi.b  #$30,$62(a1)                    ; 00C92
        beq.b   l_017_00C9C                     ; 00C98
        moveq   #$1,d0                          ; 00C9A
l_017_00C9C:
        ext.w   d0                              ; 00C9C
        add.w   d0,d0                           ; 00C9E
        move.w  d0,d1                           ; 00CA0
        add.w   d1,d1                           ; 00CA2
        add.w   d1,d0                           ; 00CA4
        movem.w (a4,d0.w),d3-d5                 ; 00CA6
        move.w  d3,d6                           ; 00CAC
        move.w  d4,d0                           ; 00CAE
        move.w  d5,d7                           ; 00CB0
        muls.w  $92(a2),d6                      ; 00CB2
        muls.w  $94(a2),d0                      ; 00CB6
        muls.w  $96(a2),d7                      ; 00CBA
        add.l   d6,d0                           ; 00CBE
        add.l   d7,d0                           ; 00CC0
        move.w  d3,d6                           ; 00CC2
        move.w  d4,d1                           ; 00CC4
        move.w  d5,d7                           ; 00CC6
        muls.w  $98(a2),d6                      ; 00CC8
        muls.w  $9a(a2),d1                      ; 00CCC
        muls.w  $9c(a2),d7                      ; 00CD0
        add.l   d6,d1                           ; 00CD4
        add.l   d7,d1                           ; 00CD6
        move.w  d4,d2                           ; 00CD8
        muls.w  $9e(a2),d3                      ; 00CDA
        muls.w  $a0(a2),d2                      ; 00CDE
        muls.w  $a2(a2),d5                      ; 00CE2
        add.l   d3,d2                           ; 00CE6
        add.l   d5,d2                           ; 00CE8
        asr.l   #$6,d0                          ; 00CEA
        asr.l   #$6,d1                          ; 00CEC
        asr.l   #$6,d2                          ; 00CEE
        add.l   d0,$14(a1)                      ; 00CF0
        add.l   d1,$18(a1)                      ; 00CF4
        add.l   d2,$1c(a1)                      ; 00CF8
        move.w  #$96,d0                         ; 00CFC
        cmpi.b  #$0,$62(a1)                     ; 00D00
        beq.b   l_017_00D0C                     ; 00D06
        move.w  #$c8,d0                         ; 00D08
l_017_00D0C:
        move.w  d0,$4c(a1)                      ; 00D0C
        move.w  #$14,$26(a1)                    ; 00D10
        ori.w   #$10c0,$0(a1)                   ; 00D16
        ori.w   #$100,$0(a1)                    ; 00D1C
        ori.w   #$2,$0(a1)                      ; 00D22
        clr.w   $76(a1)                         ; 00D28
        move.w  $2(a1),d0                       ; 00D2C
        andi.w  #$80,d0                         ; 00D30
        beq.b   l_017_00D3A                     ; 00D34
        clr.l   $42(a1)                         ; 00D36
l_017_00D3A:
        andi.w  #$ff7f,$2(a1)                   ; 00D3A
        move.w  #$ffff,$2c(a1)                  ; 00D40
        move.b  #$8c,(RedrawFlags).l            ; 00D46
        move.b  $38(a2),$38(a1)                 ; 00D4E
        move.b  $62(a1),d0                      ; 00D54
        andi.b  #$f0,d0                         ; 00D58
        cmpi.b  #$30,d0                         ; 00D5C
        bne.b   l_017_00DA4                     ; 00D60
        move.w  $94(a2),d5                      ; 00D62
        move.w  $9a(a2),d6                      ; 00D66
        move.w  $a0(a2),d7                      ; 00D6A
        asr.w   #$2,d5                          ; 00D6E
        asr.w   #$2,d6                          ; 00D70
        asr.w   #$2,d7                          ; 00D72
        cmpi.b  #$30,$62(a1)                    ; 00D74
        beq.b   l_017_00D82                     ; 00D7A
        neg.w   d5                              ; 00D7C
        neg.w   d6                              ; 00D7E
        neg.w   d7                              ; 00D80
l_017_00D82:
        move.w  #$3c0,d0                        ; 00D82
        jsr     (sub_020_0099A).l               ; 00D86
        movem.l $3e(a1),d0-d2                   ; 00D8C
        add.l   d0,d5                           ; 00D92
        add.l   d1,d6                           ; 00D94
        add.l   d2,d7                           ; 00D96
        movem.l d5-d7,$3e(a1)                   ; 00D98
        move.w  #$ffec,$4c(a1)                  ; 00D9E
l_017_00DA4:
        rts                                     ; 00DA4
; PylonOffsets - Where a missile leaves the aircraft (x, y, z words, by missile type), in the
; aircraft's own axes.
PylonOffsets:
	dc.b	$00,$00,$00,$03,$00,$14,$00,$00,$FF,$FD,$00,$00
dat_017_00DB2:
	dc.b	$FF,$ED,$FF,$FF,$00,$00,$00,$13,$FF,$FF,$00,$00,$FF,$F9,$FF,$FE
	dc.b	$00,$02,$00,$07,$FF,$FE,$00,$02,$FF,$F1,$FF,$FE,$00,$01,$00,$0F
	dc.b	$FF,$FE,$00,$01
dat_017_00DD6:
	dc.b	$FF,$E6,$00,$00,$00,$00,$00,$1A,$00,$00,$00,$00,$FF,$FB,$FF,$FE
	dc.b	$00,$02,$00,$05,$FF,$FE,$00,$02,$FF,$F1,$FF,$FE,$00,$01,$00,$0F
	dc.b	$FF,$FE,$00,$01
l_017_00DFA:
        moveq   #$1,d0                          ; 00DFA
        rts                                     ; 00DFC
sub_017_00DFE:
        tst.b   (dat_071_0017E).l               ; 00DFE
        bne.b   l_017_00DFA                     ; 00E04
        move.b  $62(a1),d0                      ; 00E06
        andi.b  #$f0,d0                         ; 00E0A
        cmpi.b  #$0,d0                          ; 00E0E
        beq.w   l_017_012CA                     ; 00E12
        cmpi.b  #$30,d0                         ; 00E16
        beq.w   l_017_01102                     ; 00E1A
        cmpi.b  #$20,d0                         ; 00E1E
        beq.b   l_017_00DFA                     ; 00E22
        subq.w  #$1,$4c(a1)                     ; 00E24
        btst    #$4,$0(a1)                      ; 00E28
        beq.b   l_017_00DFA                     ; 00E2E
        tst.b   (dat_071_0015E).l               ; 00E30
        beq.b   l_017_00DFA                     ; 00E36
        btst    #$1,$20(a1)                     ; 00E38
        beq.b   l_017_00E96                     ; 00E3E
        move.l  #$0,$34(a1)                     ; 00E40
        move.w  $6(a1),$2c(a1)                  ; 00E48
        move.w  $8(a1),$2e(a1)                  ; 00E4E
        move.w  $c(a1),$30(a1)                  ; 00E54
        move.w  $e(a1),$32(a1)                  ; 00E5A
        move.w  $6c(a1),d0                      ; 00E60
        cmpi.w  #$1200,d0                       ; 00E64
        bgt.b   l_017_00E76                     ; 00E68
        addi.w  #$90,d0                         ; 00E6A
        cmpi.w  #$1200,d0                       ; 00E6E
        ble.b   l_017_00E84                     ; 00E72
        bra.b   l_017_00E80                     ; 00E74
l_017_00E76:
        subi.w  #$90,d0                         ; 00E76
        cmpi.w  #$1200,d0                       ; 00E7A
        bge.b   l_017_00E84                     ; 00E7E
l_017_00E80:
        move.w  #$1200,d0                       ; 00E80
l_017_00E84:
        move.w  d0,$6c(a1)                      ; 00E84
        move.w  d0,$6e(a1)                      ; 00E88
        andi.w  #$dff7,$2(a1)                   ; 00E8C
        moveq   #$1,d0                          ; 00E92
        rts                                     ; 00E94
l_017_00E96:
        btst    #$0,$2(a1)                      ; 00E96
        bne.w   UpdateMissile                   ; 00E9C
        tst.w   $2c(a1)                         ; 00EA0
        blt.w   UpdateMissile                   ; 00EA4
        bsr.w   sub_017_018E8                   ; 00EA8
        move.w  $6c(a1),d2                      ; 00EAC
        cmpi.b  #$ff,$38(a1)                    ; 00EB0
        bne.b   l_017_00F02                     ; 00EB6
        cmpi.b  #$14,$62(a1)                    ; 00EB8
        bne.w   l_017_00F9C                     ; 00EBE
        move.w  $2(a1),d1                       ; 00EC2
        andi.w  #$80,d1                         ; 00EC6
        beq.b   l_017_00EDE                     ; 00ECA
        move.w  $6c(a1),d1                      ; 00ECC
        cmpi.w  #$100,d1                        ; 00ED0
        blt.w   l_017_01012                     ; 00ED4
        asr.w   #$1,d1                          ; 00ED8
        bra.w   l_017_00FE6                     ; 00EDA
l_017_00EDE:
        move.w  #$1680,d1                       ; 00EDE
        cmpi.l  #$6c0,$10(a1)                   ; 00EE2
        bgt.w   l_017_00FDC                     ; 00EEA
        tst.b   $7c(a1)                         ; 00EEE
        bge.b   l_017_00EFA                     ; 00EF2
        bchg    #$7,$7c(a1)                     ; 00EF4
l_017_00EFA:
        move.w  #$600,d1                        ; 00EFA
        bra.w   l_017_00FDC                     ; 00EFE
l_017_00F02:
        lea.l   (ObjectTable).l,a2              ; 00F02
        move.b  $38(a1),d1                      ; 00F08
        cmpi.b  #$ff,d1                         ; 00F0C
        beq.b   l_017_00F30                     ; 00F10
        andi.w  #$7f,d1                         ; 00F12
        asl.w   #$8,d1                          ; 00F16
        add.w   d1,d1                           ; 00F18
        adda.w  d1,a2                           ; 00F1A
        btst    #$6,$1(a1)                      ; 00F1C
        bne.b   l_017_00F30                     ; 00F22
        move.b  #$80,$38(a1)                    ; 00F24
        lea.l   (ObjectTable).l,a2              ; 00F2A
l_017_00F30:
        move.w  $6c(a2),d1                      ; 00F30
        move.w  d1,d0                           ; 00F34
        btst    #$5,$4(a1)                      ; 00F36
        beq.b   l_017_00F52                     ; 00F3C
        cmpi.w  #$240,$4a(a1)                   ; 00F3E
        ble.b   l_017_00F8C                     ; 00F44
        cmpi.w  #$600,$4a(a1)                   ; 00F46
        bge.b   l_017_00FCC                     ; 00F4C
        bra.w   l_017_00FDC                     ; 00F4E
l_017_00F52:
        btst    #$0,$2(a1)                      ; 00F52
        bne.b   l_017_00F76                     ; 00F58
        move.b  $5(a1),d3                       ; 00F5A
        beq.b   l_017_00F76                     ; 00F5E
        cmpi.b  #$1,d3                          ; 00F60
        beq.b   l_017_00F76                     ; 00F64
        cmpi.w  #$360,$4a(a1)                   ; 00F66
        ble.b   l_017_00FDC                     ; 00F6C
        cmpi.b  #$6,d3                          ; 00F6E
        beq.b   l_017_00F8C                     ; 00F72
        bra.b   l_017_00FCC                     ; 00F74
l_017_00F76:
        move.b  $64(a1),d3                      ; 00F76
        andi.w  #$60,d3                         ; 00F7A
        cmpi.w  #$180,$4a(a1)                   ; 00F7E
        blt.b   l_017_00FCC                     ; 00F84
        cmpi.w  #$60,d3                         ; 00F86
        bne.b   l_017_00FC4                     ; 00F8A
l_017_00F8C:
        cmpi.w  #$300,$4a(a1)                   ; 00F8C
        bge.b   l_017_00F9C                     ; 00F92
        add.w   d1,d1                           ; 00F94
        cmpi.w  #$1bc0,d1                       ; 00F96
        ble.b   l_017_00FDC                     ; 00F9A
l_017_00F9C:
        cmpi.b  #$15,$62(a1)                    ; 00F9C
        beq.b   l_017_00FB2                     ; 00FA2
        btst    #$3,$1(a1)                      ; 00FA4
        bne.b   l_017_00FBE                     ; 00FAA
        move.w  #$1d40,d1                       ; 00FAC
        bra.b   l_017_00FDC                     ; 00FB0
l_017_00FB2:
        move.w  #$1ec0,d1                       ; 00FB2
        bra.b   l_017_00FDC                     ; 00FB6
	dc.b	$32,$3C,$1A,$40,$60,$1E
l_017_00FBE:
        move.w  #$15c0,d1                       ; 00FBE
        bra.b   l_017_00FDC                     ; 00FC2
l_017_00FC4:
        cmpi.w  #$300,$4a(a1)                   ; 00FC4
        bgt.b   l_017_00FDC                     ; 00FCA
l_017_00FCC:
        move.w  d1,d0                           ; 00FCC
        asr.w   #$3,d0                          ; 00FCE
        cmpi.w  #$420,d0                        ; 00FD0
        blt.b   l_017_00FDA                     ; 00FD4
        move.w  #$420,d0                        ; 00FD6
l_017_00FDA:
        sub.w   d0,d1                           ; 00FDA
l_017_00FDC:
        cmpi.w  #$900,d1                        ; 00FDC
        bgt.b   l_017_00FE6                     ; 00FE0
        move.w  #$900,d1                        ; 00FE2
l_017_00FE6:
        add.w   d2,d1                           ; 00FE6
        asr.w   #$1,d1                          ; 00FE8
        move.w  d1,d0                           ; 00FEA
        move.w  #$90,d3                         ; 00FEC
        move.w  d3,d4                           ; 00FF0
        sub.w   d2,d0                           ; 00FF2
        bge.b   l_017_00FFA                     ; 00FF4
        neg.w   d0                              ; 00FF6
        neg.w   d4                              ; 00FF8
l_017_00FFA:
        cmp.w   d3,d0                           ; 00FFA
        blt.b   l_017_01002                     ; 00FFC
        add.w   d4,d2                           ; 00FFE
        move.w  d2,d1                           ; 01000
l_017_01002:
        cmp.w   $6c(a1),d1                      ; 01002
        beq.b   l_017_01016                     ; 01006
        blt.b   l_017_0100E                     ; 01008
        moveq   #$1,d2                          ; 0100A
        bra.b   l_017_01018                     ; 0100C
l_017_0100E:
        moveq   #$2,d2                          ; 0100E
        bra.b   l_017_01018                     ; 01010
l_017_01012:
        clr.b   $2b(a1)                         ; 01012
l_017_01016:
        moveq   #$0,d2                          ; 01016
l_017_01018:
        move.b  $65(a1),d0                      ; 01018
        andi.b  #$fc,d0                         ; 0101C
        or.b    d2,d0                           ; 01020
        move.b  d0,$65(a1)                      ; 01022

;-------------------------------------------------------------------------------
; UpdateMissile - Updates a missile (a1): its timer (+$4C) counts down; while the motor burns
; (timer >= 50) its speed (+$6C, +$6E) rises by $1E0 a frame to at most $4200, then it eases
; towards $3000 ($240 a frame); at 12 it is spent (flag $400 in +$00)...
;-------------------------------------------------------------------------------
UpdateMissile:
        tst.b   (dat_071_0017E).l               ; 01026
        bne.w   l_017_010FA                     ; 0102C
        cmpi.b  #$8,$5(a1)                      ; 01030
        bne.w   l_017_010BC                     ; 01036
        btst    #$0,$2(a1)                      ; 0103A
        bne.b   l_017_010BC                     ; 01040
        cmpi.w  #$480,$4a(a1)                   ; 01042
        bgt.b   l_017_010BC                     ; 01048
        moveq   #$0,d0                          ; 0104A
        move.b  $3a(a1),d0                      ; 0104C
        add.w   d0,d0                           ; 01050
        lea.l   (Routes).l,a4                   ; 01052
        adda.w  (a4,d0.w),a4                    ; 01058
l_017_0105C:
        move.l  (a4),d0                         ; 0105C
        cmp.l   $2c(a1),d0                      ; 0105E
        bne.b   l_017_0106E                     ; 01062
        move.l  $4(a4),d0                       ; 01064
        cmp.l   $30(a1),d0                      ; 01068
        beq.b   l_017_01086                     ; 0106C
l_017_0106E:
        adda.w  #$a,a4                          ; 0106E
        tst.w   (a4)                            ; 01072
        bge.b   l_017_0105C                     ; 01074
        move.w  #$35,(dat_071_0036E).l          ; 01076
        jsr     (Nop).l                         ; 0107E
        bra.b   l_017_010BC                     ; 01084
l_017_01086:
        tst.w   $a(a4)                          ; 01086
        bge.b   l_017_010A4                     ; 0108A
        bclr    #$7,$1(a1)                      ; 0108C
        beq.b   l_017_010BC                     ; 01092
        cmpi.b  #$15,$62(a1)                    ; 01094
        bne.b   l_017_010BC                     ; 0109A
        ori.w   #$200,$0(a1)                    ; 0109C
        bra.b   l_017_010BC                     ; 010A2
l_017_010A4:
        movem.w $a(a4),d0-d4                    ; 010A4
        movem.w d0-d3,$2c(a1)                   ; 010AA
        ext.l   d4                              ; 010B0
        move.l  d4,$34(a1)                      ; 010B2
        move.w  #$7fff,$4a(a1)                  ; 010B6
l_017_010BC:
        cmpi.b  #$8,$5(a1)                      ; 010BC
        beq.w   l_017_01526                     ; 010C2
        move.w  $0(a1),d0                       ; 010C6
        move.w  d0,d1                           ; 010CA
        andi.w  #$8,d0                          ; 010CC
        bne.b   l_017_010F2                     ; 010D0
        lea.l   (ObjectTable).l,a3              ; 010D2
        move.b  $38(a1),d0                      ; 010D8
        cmpi.b  #$ff,d0                         ; 010DC
        beq.w   l_017_013FE                     ; 010E0
        andi.w  #$7f,d0                         ; 010E4
        asl.w   #$8,d0                          ; 010E8
        add.w   d0,d0                           ; 010EA
        adda.w  d0,a3                           ; 010EC
        bra.w   l_017_013D6                     ; 010EE
l_017_010F2:
        andi.w  #$2,d1                          ; 010F2
        bne.w   l_017_01378                     ; 010F6
l_017_010FA:
        moveq   #$1,d0                          ; 010FA
        rts                                     ; 010FC
l_017_010FE:
        moveq   #$1,d0                          ; 010FE
        rts                                     ; 01100
l_017_01102:
        move.b  (dat_071_00158).l,d1            ; 01102
        or.b    (dat_071_0017E).l,d1            ; 01108
        bne.b   l_017_010FE                     ; 0110E
        move.w  $0(a1),d1                       ; 01110
        andi.w  #$400,d1                        ; 01114
        bne.w   l_017_012B2                     ; 01118
        movem.l $3e(a1),d0-d2                   ; 0111C
        btst    #$7,$0(a1)                      ; 01122
        beq.b   l_017_01196                     ; 01128
        move.w  $4c(a1),d3                      ; 0112A
        ble.b   l_017_01142                     ; 0112E
        cmpi.w  #$5,d3                          ; 01130
        blt.b   l_017_0113E                     ; 01134
        move.w  #$4,$4c(a1)                     ; 01136
        bra.b   l_017_01142                     ; 0113C
l_017_0113E:
        subq.w  #$1,$4c(a1)                     ; 0113E
l_017_01142:
        tst.w   $4c(a1)                         ; 01142
        bgt.b   l_017_01170                     ; 01146
        cmpi.b  #$30,$62(a1)                    ; 01148
        bne.b   l_017_01170                     ; 0114E
        tst.b   (dat_071_001FA).l               ; 01150
        bne.b   l_017_01170                     ; 01156
        cmpi.b  #$30,$62(a1)                    ; 01158
        bne.b   l_017_01170                     ; 0115E
        move.b  #$2,(dat_071_001FA).l           ; 01160
        move.b  #$4,(dat_071_001FC).l           ; 01168
l_017_01170:
        cmpi.l  #$c0,d0                         ; 01170
        bge.b   l_017_0117E                     ; 01176
        addi.l  #$c,d0                          ; 01178
l_017_0117E:
        clr.l   d1                              ; 0117E
        tst.l   d2                              ; 01180
        bgt.b   l_017_01188                     ; 01182
        addq.l  #$1,d2                          ; 01184
        bra.b   l_017_0118A                     ; 01186
l_017_01188:
        subq.l  #$1,d2                          ; 01188
l_017_0118A:
        bra.w   l_017_0127C                     ; 0118A
l_017_0118E:
        addq.w  #$1,$4c(a1)                     ; 0118E
        moveq   #$6,d6                          ; 01192
        bra.b   l_017_011D0                     ; 01194
l_017_01196:
        move.w  $4c(a1),d3                      ; 01196
        blt.b   l_017_0118E                     ; 0119A
        addq.w  #$1,$4c(a1)                     ; 0119C
        moveq   #$2,d6                          ; 011A0
        cmpi.w  #$3,$4c(a1)                     ; 011A2
        blt.b   l_017_0121E                     ; 011A8
        moveq   #$3,d6                          ; 011AA
        cmpi.b  #$30,$62(a1)                    ; 011AC
        bne.b   l_017_0121E                     ; 011B2
        move.w  (ObjectTable).l,d4              ; 011B4
        btst    #$6,d4                          ; 011BA
        beq.b   l_017_011EE                     ; 011BE
        btst    #$2,d4                          ; 011C0
        beq.b   l_017_011D0                     ; 011C4
        cmpi.w  #$5,$4c(a1)                     ; 011C6
        blt.b   l_017_011EE                     ; 011CC
        bra.b   l_017_0121E                     ; 011CE
l_017_011D0:
        move.w  (ObjectTable).l,d4              ; 011D0
        andi.w  #$600,d4                        ; 011D6
        bne.b   l_017_011EE                     ; 011DA
        cmpi.l  #$2000,$18(a1)                  ; 011DC
        blt.b   l_017_011EE                     ; 011E4
        cmpi.w  #$14,$4c(a1)                    ; 011E6
        blt.b   l_017_0121E                     ; 011EC
l_017_011EE:
        movem.l d0-d2,-(a7)                     ; 011EE
        tst.b   (dat_071_00185).l               ; 011F2
        beq.b   l_017_0121A                     ; 011F8
        move.w  (CurrentObject).l,d1            ; 011FA
        cmp.w   (dat_071_002AC).l,d1            ; 01200
        beq.b   l_017_0121A                     ; 01206
        jsr     (sub_005_012D0).l               ; 01208
        clr.b   (dat_071_001A9).l               ; 0120E
        jsr     (sub_005_00B8E).l               ; 01214
l_017_0121A:
        movem.l (a7)+,d0-d2                     ; 0121A
l_017_0121E:
        move.l  d0,d4                           ; 0121E
        bge.b   l_017_01224                     ; 01220
        neg.l   d4                              ; 01222
l_017_01224:
        move.l  d2,d5                           ; 01224
        bge.b   l_017_0122A                     ; 01226
        neg.l   d5                              ; 01228
l_017_0122A:
        cmp.l   d4,d5                           ; 0122A
        bge.b   l_017_01230                     ; 0122C
        exg.l   d4,d5                           ; 0122E
l_017_01230:
        move.w  $4c(a1),d4                      ; 01230
        neg.w   d4                              ; 01234
        addi.w  #$f0,d4                         ; 01236
        bgt.b   l_017_0123E                     ; 0123A
        clr.w   d4                              ; 0123C
l_017_0123E:
        ext.l   d4                              ; 0123E
        cmp.l   d4,d5                           ; 01240
        blt.b   l_017_01250                     ; 01242
        move.l  d0,d4                           ; 01244
        move.l  d2,d5                           ; 01246
        asr.l   d6,d4                           ; 01248
        sub.l   d4,d0                           ; 0124A
        asr.l   d6,d5                           ; 0124C
        sub.l   d5,d2                           ; 0124E
l_017_01250:
        cmpi.w  #$3,$4c(a1)                     ; 01250
        blt.b   l_017_01264                     ; 01256
        tst.l   d1                              ; 01258
        ble.b   l_017_01264                     ; 0125A
        subi.l  #$3c0,d1                        ; 0125C
        bra.b   l_017_0127C                     ; 01262
l_017_01264:
        cmpi.l  #$fffffd00,d1                   ; 01264
        ble.b   l_017_01274                     ; 0126A
        subi.l  #$3c,d1                         ; 0126C
        bra.b   l_017_0127C                     ; 01272
l_017_01274:
        addi.l  #$fffffd00,d1                   ; 01274
        asr.l   #$1,d1                          ; 0127A
l_017_0127C:
        movem.l d0-d2,$3e(a1)                   ; 0127C
        tst.l   d0                              ; 01282
        bge.b   l_017_01288                     ; 01284
        neg.l   d0                              ; 01286
l_017_01288:
        tst.l   d1                              ; 01288
        bge.b   l_017_0128E                     ; 0128A
        neg.l   d1                              ; 0128C
l_017_0128E:
        tst.l   d2                              ; 0128E
        bge.b   l_017_01294                     ; 01290
        neg.l   d2                              ; 01292
l_017_01294:
        cmp.l   d0,d1                           ; 01294
        ble.b   l_017_012A4                     ; 01296
        cmp.l   d1,d2                           ; 01298
        ble.b   l_017_012A0                     ; 0129A
l_017_0129C:
        move.l  d2,d0                           ; 0129C
        bra.b   l_017_012A8                     ; 0129E
l_017_012A0:
        move.l  d1,d0                           ; 012A0
        bra.b   l_017_012A8                     ; 012A2
l_017_012A4:
        cmp.l   d0,d2                           ; 012A4
        bgt.b   l_017_0129C                     ; 012A6
l_017_012A8:
        asr.l   #$2,d0                          ; 012A8
        move.w  d0,$6e(a1)                      ; 012AA
        moveq   #$1,d0                          ; 012AE
        rts                                     ; 012B0
l_017_012B2:
        ori.w   #$20,$2(a2)                     ; 012B2
l_017_012B8:
        clr.w   $0(a1)                          ; 012B8
        move.b  #$c,(RedrawFlags).l             ; 012BC
        moveq   #$0,d0                          ; 012C4
        rts                                     ; 012C6
l_017_012C8:
        rts                                     ; 012C8
l_017_012CA:
        btst    #$6,$1(a1)                      ; 012CA
        beq.b   l_017_012C8                     ; 012D0
        move.b  (dat_071_00158).l,d1            ; 012D2
        or.b    (dat_071_0017E).l,d1            ; 012D8
        bne.b   l_017_012E6                     ; 012DE
        subq.w  #$1,$4c(a1)                     ; 012E0
        ble.b   l_017_012B8                     ; 012E4
l_017_012E6:
        move.w  $0(a1),d1                       ; 012E6
        andi.w  #$400,d1                        ; 012EA
        bne.b   l_017_01306                     ; 012EE
        move.w  $4c(a1),d1                      ; 012F0
        cmpi.w  #$32,d1                         ; 012F4
        bge.b   l_017_01342                     ; 012F8
        cmpi.w  #$c,d1                          ; 012FA
        bge.b   l_017_01308                     ; 012FE
        ori.w   #$400,$0(a1)                    ; 01300
l_017_01306:
        nop                                     ; 01306
l_017_01308:
        move.w  #$3000,d1                       ; 01308
        bra.b   l_017_01312                     ; 0130C
l_017_0130E:
        move.w  #$4200,d1                       ; 0130E
l_017_01312:
        move.l  #$0,$34(a1)                     ; 01312
        move.w  $6c(a1),d0                      ; 0131A
        cmp.w   d1,d0                           ; 0131E
        bgt.b   l_017_0132C                     ; 01320
        addi.w  #$240,d0                        ; 01322
        cmp.w   d1,d0                           ; 01326
        ble.b   l_017_01336                     ; 01328
        bra.b   l_017_01334                     ; 0132A
l_017_0132C:
        subi.w  #$240,d0                        ; 0132C
        cmp.w   d1,d0                           ; 01330
        bge.b   l_017_01336                     ; 01332
l_017_01334:
        move.w  d1,d0                           ; 01334
l_017_01336:
        move.w  d0,$6c(a1)                      ; 01336
        move.w  d0,$6e(a1)                      ; 0133A
        moveq   #$1,d0                          ; 0133E
        rts                                     ; 01340
l_017_01342:
        move.w  $6c(a1),d0                      ; 01342
        addi.w  #$1e0,d0                        ; 01346
        cmpi.w  #$4200,d0                       ; 0134A
        ble.b   l_017_01354                     ; 0134E
        move.w  #$4200,d0                       ; 01350
l_017_01354:
        move.w  d0,$6c(a1)                      ; 01354
        move.w  d0,$6e(a1)                      ; 01358
        btst    #$1,$1(a1)                      ; 0135C
        beq.w   l_017_01772                     ; 01362
        andi.w  #$fffe,$0(a1)                   ; 01366
        btst    #$3,$1(a1)                      ; 0136C
        beq.w   l_017_01772                     ; 01372
        bra.b   l_017_01386                     ; 01376
l_017_01378:
        andi.w  #$fffe,$0(a1)                   ; 01378
        btst    #$3,$1(a1)                      ; 0137E
        beq.b   l_017_013D2                     ; 01384
l_017_01386:
        move.w  (dat_071_00390).l,d0            ; 01386
        cmpi.w  #$ffff,d0                       ; 0138C
        beq.w   l_017_0130E                     ; 01390
        cmp.w   (CurrentObjectOffset).l,d0      ; 01394
        beq.w   l_017_0130E                     ; 0139A
        lea.l   (ObjectTable).l,a2              ; 0139E
        adda.w  d0,a2                           ; 013A4
        move.w  $6(a2),$2c(a1)                  ; 013A6
        move.w  $8(a2),$2e(a1)                  ; 013AC
        movem.w $c(a2),d2-d3                    ; 013B2
        move.l  $10(a2),d4                      ; 013B8
        movem.w d2-d3,$30(a1)                   ; 013BC
        move.l  d4,$34(a1)                      ; 013C2
        lsr.w   #$8,d0                          ; 013C6
        lsr.w   #$1,d0                          ; 013C8
        ori.b   #$80,d0                         ; 013CA
        move.b  d0,$38(a1)                      ; 013CE
l_017_013D2:
        moveq   #$1,d0                          ; 013D2
        rts                                     ; 013D4
l_017_013D6:
        cmpi.b  #$5,$7a(a1)                     ; 013D6
        bne.b   l_017_013E4                     ; 013DC
        move.b  #$3,$7a(a1)                     ; 013DE
l_017_013E4:
        btst    #$6,$1(a3)                      ; 013E4
        beq.w   l_017_0165E                     ; 013EA
        ori.w   #$1,$0(a1)                      ; 013EE
        move.l  #ObjectTable,d0                 ; 013F4
        cmp.l   a3,d0                           ; 013FA
        beq.b   l_017_01462                     ; 013FC
l_017_013FE:
        cmpi.b  #$8,$5(a1)                      ; 013FE
        beq.b   l_017_01462                     ; 01404
        movem.l $14(a1),d0-d2                   ; 01406
        movem.l (PlayerX).l,d3-d5               ; 0140C
        cmpi.b  #$3,(Difficulty).l              ; 01414
        bge.b   l_017_01438                     ; 0141C
        cmpi.b  #$2,(Difficulty).l              ; 0141E
        bge.b   l_017_01430                     ; 01426
        move.l  #$180000,d6                     ; 01428
        bra.b   l_017_0143E                     ; 0142E
l_017_01430:
        move.l  #$240000,d6                     ; 01430
        bra.b   l_017_0143E                     ; 01436
l_017_01438:
        move.l  #$300000,d6                     ; 01438
l_017_0143E:
        sub.l   d0,d3                           ; 0143E
        bge.b   l_017_01444                     ; 01440
        neg.l   d3                              ; 01442
l_017_01444:
        cmp.l   d6,d3                           ; 01444
        bgt.b   l_017_01462                     ; 01446
        sub.l   d1,d4                           ; 01448
        bge.b   l_017_0144E                     ; 0144A
        neg.l   d4                              ; 0144C
l_017_0144E:
        cmp.l   d6,d4                           ; 0144E
        bgt.b   l_017_01462                     ; 01450
        sub.l   d2,d5                           ; 01452
        bge.b   l_017_01458                     ; 01454
        neg.l   d5                              ; 01456
l_017_01458:
        cmp.l   d6,d5                           ; 01458
        bgt.b   l_017_01462                     ; 0145A
        move.b  #$80,$38(a1)                    ; 0145C
l_017_01462:
        move.w  $2(a1),d0                       ; 01462
        andi.w  #$1,d0                          ; 01466
        beq.b   l_017_014A8                     ; 0146A
        btst    #$8,$64(a1)                     ; 0146C
        bne.b   l_017_0148E                     ; 01472
        btst    #$1,$64(a1)                     ; 01474
        bne.b   l_017_01482                     ; 0147A
        move.w  #$ffa0,d3                       ; 0147C
        bra.b   l_017_01486                     ; 01480
l_017_01482:
        move.w  #$a8,d3                         ; 01482
l_017_01486:
        moveq   #$0,d4                          ; 01486
        move.w  #$ffd0,d5                       ; 01488
        bra.b   l_017_014F8                     ; 0148C
l_017_0148E:
        btst    #$1,$64(a1)                     ; 0148E
        bne.b   l_017_0149C                     ; 01494
        move.w  #$ffa0,d4                       ; 01496
        bra.b   l_017_014A0                     ; 0149A
l_017_0149C:
        move.w  #$60,d4                         ; 0149C
l_017_014A0:
        moveq   #$0,d3                          ; 014A0
        move.w  #$ffd0,d5                       ; 014A2
        bra.b   l_017_014F8                     ; 014A6
l_017_014A8:
        move.w  (FrameCount).l,d3               ; 014A8
        andi.w  #$ff,d3                         ; 014AE
        bne.b   l_017_014DE                     ; 014B2
        move.b  #$14,d3                         ; 014B4
        move.b  $28(a3),d4                      ; 014B8
        bge.b   l_017_014C0                     ; 014BC
        neg.b   d4                              ; 014BE
l_017_014C0:
        cmp.w   d3,d4                           ; 014C0
        bgt.b   l_017_014D0                     ; 014C2
        move.b  $2a(a3),d4                      ; 014C4
        bge.b   l_017_014CC                     ; 014C8
        neg.b   d4                              ; 014CA
l_017_014CC:
        cmp.b   d3,d4                           ; 014CC
        ble.b   l_017_014DE                     ; 014CE
l_017_014D0:
        move.w  $16(a3),d4                      ; 014D0
        andi.w  #$4,d4                          ; 014D4
        move.b  d4,(dat_071_0015A).l            ; 014D8
l_017_014DE:
        tst.b   (dat_071_0015A).l               ; 014DE
        bra.b   l_017_014F0                     ; 014E4
sub_017_014E6:
        moveq   #$0,d3                          ; 014E6
        moveq   #$0,d4                          ; 014E8
        move.w  #$150,d5                        ; 014EA
        bra.b   l_017_014F8                     ; 014EE
l_017_014F0:
        moveq   #$0,d3                          ; 014F0
        moveq   #$0,d4                          ; 014F2
        move.w  #$ffdc,d5                       ; 014F4
l_017_014F8:
        exg.l   a1,a3                           ; 014F8
        jsr     (sub_004_00328).l               ; 014FA
        exg.l   a1,a3                           ; 01500
        move.l  d0,d3                           ; 01502
        move.l  d2,d4                           ; 01504
        asr.l   #$8,d3                          ; 01506
        asr.l   #$8,d4                          ; 01508
        andi.w  #$3fff,d3                       ; 0150A
        andi.w  #$3fff,d4                       ; 0150E
        swap    d0                              ; 01512
        swap    d2                              ; 01514
        asr.w   #$6,d0                          ; 01516
        asr.w   #$6,d2                          ; 01518
        movem.w d0/d2-d4,$2c(a1)                ; 0151A
        asr.l   #$8,d1                          ; 01520
        move.l  d1,$34(a1)                      ; 01522
l_017_01526:
        btst    #$1,$20(a1)                     ; 01526
        bne.w   l_017_01654                     ; 0152C
        bsr.w   sub_017_016EA                   ; 01530
        move.b  $5(a1),d0                       ; 01534
        beq.b   l_017_01564                     ; 01538
        cmpi.b  #$1,d0                          ; 0153A
        beq.b   l_017_01564                     ; 0153E
        cmpi.b  #$6,d0                          ; 01540
        beq.w   l_017_01654                     ; 01544
        cmpi.b  #$8,d0                          ; 01548
        bne.b   l_017_01564                     ; 0154C
        cmpi.b  #$5,(dat_071_00276).l           ; 0154E
        bne.w   l_017_01654                     ; 01556
        tst.b   (dat_071_00187).l               ; 0155A
        beq.w   l_017_01654                     ; 01560
l_017_01564:
        btst    #$5,$4(a1)                      ; 01564
        beq.w   l_017_01654                     ; 0156A
        lea.l   (dat_030_000A0).l,a4            ; 0156E
        move.w  (GunFlags).l,d0                 ; 01574
        moveq   #$0,d2                          ; 0157A
        cmpi.w  #$300,$4a(a3)                   ; 0157C
        bgt.b   l_017_015B0                     ; 01582
        move.w  $6c(a1),d1                      ; 01584
        sub.w   $6c(a3),d1                      ; 01588
        bge.b   l_017_01592                     ; 0158C
        neg.w   d1                              ; 0158E
        moveq   #$1,d2                          ; 01590
l_017_01592:
        cmpi.w  #$c0,d1                         ; 01592
        blt.b   l_017_015A4                     ; 01596
        adda.w  #$20,a4                         ; 01598
        tst.b   d2                              ; 0159C
        bne.b   l_017_015A4                     ; 0159E
        adda.w  #$20,a4                         ; 015A0
l_017_015A4:
        andi.w  #$8,d0                          ; 015A4
        bra.b   l_017_01610                     ; 015A8
	dc.b	$D8,$FC,$00,$10,$60,$60
l_017_015B0:
        adda.w  #$60,a4                         ; 015B0
        cmpi.w  #$c00,$4a(a3)                   ; 015B4
        ble.b   l_017_015CE                     ; 015BA
        adda.w  #$60,a4                         ; 015BC
        cmpi.w  #$1e00,$4a(a3)                  ; 015C0
        ble.b   l_017_015CE                     ; 015C6
        adda.w  #$60,a4                         ; 015C8
        bra.b   l_017_01610                     ; 015CC
l_017_015CE:
        move.w  $6c(a1),d1                      ; 015CE
        sub.w   $6c(a3),d1                      ; 015D2
        bge.b   l_017_015DC                     ; 015D6
        neg.w   d1                              ; 015D8
        moveq   #$1,d2                          ; 015DA
l_017_015DC:
        cmpi.w  #$c0,d1                         ; 015DC
        blt.b   l_017_015EE                     ; 015E0
        adda.w  #$20,a4                         ; 015E2
        tst.b   d2                              ; 015E6
        bne.b   l_017_015EE                     ; 015E8
        adda.w  #$20,a4                         ; 015EA
l_017_015EE:
        move.w  (dat_071_00390).l,d0            ; 015EE
        blt.b   l_017_01610                     ; 015F4
        cmp.w   (CurrentObjectOffset).l,d0      ; 015F6
        bne.b   l_017_01610                     ; 015FC
        tst.b   (dat_071_00187).l               ; 015FE
        beq.b   l_017_01610                     ; 01604
        clr.b   (dat_071_00187).l               ; 01606
        adda.w  #$10,a4                         ; 0160C
l_017_01610:
        move.b  (Difficulty).l,d1               ; 01610
        ext.w   d1                              ; 01616
        cmpi.w  #$3,d1                          ; 01618
        ble.b   l_017_01620                     ; 0161C
        moveq   #$3,d1                          ; 0161E
l_017_01620:
        add.w   d1,d1                           ; 01620
        add.w   d1,d1                           ; 01622
        move.w  (a4,d1.w),$4c(a1)               ; 01624
        move.w  $2(a4,d1.w),d0                  ; 0162A
        cmpi.b  #$8,$5(a1)                      ; 0162E
        bne.b   l_017_01650                     ; 01634
        btst    #$3,$1(a1)                      ; 01636
        beq.b   l_017_01650                     ; 0163C
        bclr    #$3,$1(a1)                      ; 0163E
        addq.b  #$1,(dat_071_00279).l           ; 01644
        addq.b  #$1,(dat_071_0027A).l           ; 0164A
l_017_01650:
        move.b  d0,$5(a1)                       ; 01650
l_017_01654:
        clr.b   (dat_071_00187).l               ; 01654
l_017_0165A:
        moveq   #$1,d0                          ; 0165A
        rts                                     ; 0165C
l_017_0165E:
        btst    #$4,$0(a1)                      ; 0165E
        beq.b   l_017_0165A                     ; 01664
        movea.l (dat_071_0010A).l,a3            ; 01666
l_017_0166C:
        tst.w   (a3)                            ; 0166C
        blt.b   l_017_01686                     ; 0166E
        move.w  $4(a3),d0                       ; 01670
        andi.w  #$ff,d0                         ; 01674
        cmp.w   (CurrentObject).l,d0            ; 01678
        beq.b   l_017_016B2                     ; 0167E
        adda.w  #$a,a3                          ; 01680
        bra.b   l_017_0166C                     ; 01684
l_017_01686:
        move.b  $5d(a1),d0                      ; 01686
        ble.b   l_017_016A2                     ; 0168A
        lea.l   (dat_027_00140).l,a3            ; 0168C
        subq.b  #$1,d0                          ; 01692
        ext.w   d0                              ; 01694
        asl.w   #$2,d0                          ; 01696
        movea.l (a3,d0.w),a3                    ; 01698
        adda.w  #$a,a3                          ; 0169C
        bra.b   l_017_0166C                     ; 016A0
l_017_016A2:
        move.w  #$34,(dat_071_0036E).l          ; 016A2
        jsr     (Nop).l                         ; 016AA
        bra.b   l_017_01654                     ; 016B0
l_017_016B2:
        move.w  $6(a3),d2                       ; 016B2
        lea.l   (Routes).l,a4                   ; 016B6
        adda.w  (a4,d2.w),a4                    ; 016BC
        movem.w (a4)+,d2-d6                     ; 016C0
        move.w  d2,$2c(a1)                      ; 016C4
        move.w  d3,$2e(a1)                      ; 016C8
        move.w  d4,$30(a1)                      ; 016CC
        move.w  d5,$32(a1)                      ; 016D0
        move.l  d6,$34(a1)                      ; 016D4
        move.b  #$ff,$38(a1)                    ; 016D8
        bclr    #$0,$1(a1)                      ; 016DE
        bra.w   l_017_01654                     ; 016E4
l_017_016E8:
        rts                                     ; 016E8
sub_017_016EA:
        move.b  $39(a1),d0                      ; 016EA
        andi.b  #$f0,d0                         ; 016EE
        cmpi.b  #$10,d0                         ; 016F2
        bne.b   l_017_016E8                     ; 016F6
        cmpi.w  #$3000,$4a(a3)                  ; 016F8
        bgt.b   l_017_0176A                     ; 016FE
        movem.l $14(a3),d5-d7                   ; 01700
        sub.l   $14(a1),d5                      ; 01706
        sub.l   $18(a1),d6                      ; 0170A
        sub.l   $1c(a1),d7                      ; 0170E
        asr.l   #$8,d5                          ; 01712
        asr.l   #$8,d6                          ; 01714
        asr.l   #$8,d7                          ; 01716
        move.w  #$c0,d0                         ; 01718
        jsr     (sub_020_0099A).l               ; 0171C
        muls.w  $96(a3),d5                      ; 01722
        muls.w  $9c(a3),d6                      ; 01726
        muls.w  $a2(a3),d7                      ; 0172A
        add.l   d5,d7                           ; 0172E
        add.l   d6,d7                           ; 01730
        bge.b   l_017_0176A                     ; 01732
        cmpi.l  #$ffd40000,d7                   ; 01734
        bgt.b   l_017_0176A                     ; 0173A
        move.w  $96(a3),d2                      ; 0173C
        move.w  $9c(a3),d3                      ; 01740
        move.w  $a2(a3),d4                      ; 01744
        muls.w  $96(a1),d2                      ; 01748
        muls.w  $9c(a1),d3                      ; 0174C
        muls.w  $a2(a1),d4                      ; 01750
        add.l   d2,d4                           ; 01754
        add.l   d3,d4                           ; 01756
        blt.b   l_017_0176A                     ; 01758
        cmpi.l  #$d000000,d4                    ; 0175A
        blt.b   l_017_0176A                     ; 01760
        bset    #$5,$4(a1)                      ; 01762
        rts                                     ; 01768
l_017_0176A:
        bclr    #$5,$4(a1)                      ; 0176A
        rts                                     ; 01770
l_017_01772:
        ori.w   #$1,$0(a1)                      ; 01772
        move.b  $38(a1),d0                      ; 01778
        andi.w  #$7f,d0                         ; 0177C
        asl.w   #$8,d0                          ; 01780
        add.w   d0,d0                           ; 01782
        bne.b   l_017_017A0                     ; 01784
        cmpi.b  #$0,$62(a1)                     ; 01786
        bne.b   l_017_01798                     ; 0178C
        move.b  (dat_071_0025C).l,d1            ; 0178E
        bne.b   l_017_017D8                     ; 01794
        bra.b   l_017_017A0                     ; 01796
l_017_01798:
        move.b  (dat_071_0025D).l,d1            ; 01798
        bne.b   l_017_017D8                     ; 0179E
l_017_017A0:
        lea.l   (ObjectTable).l,a3              ; 017A0
        adda.w  d0,a3                           ; 017A6
        btst    #$6,$1(a1)                      ; 017A8
        bne.b   l_017_017B6                     ; 017AE
        bclr    #$7,$1(a1)                      ; 017B0
l_017_017B6:
        move.w  $6(a3),$2c(a1)                  ; 017B6
        move.w  $8(a3),$2e(a1)                  ; 017BC
        move.w  $c(a3),$30(a1)                  ; 017C2
        move.w  $e(a3),$32(a1)                  ; 017C8
        move.l  $10(a3),$34(a1)                 ; 017CE
        moveq   #$1,d0                          ; 017D4
        rts                                     ; 017D6
l_017_017D8:
        lea.l   (dat_071_00642).l,a3            ; 017D8
        subq.b  #$1,d1                          ; 017DE
        ext.w   d1                              ; 017E0
        asl.w   #$6,d1                          ; 017E2
        adda.w  d1,a3                           ; 017E4
        moveq   #$0,d3                          ; 017E6
        moveq   #$0,d5                          ; 017E8
        move.w  $30(a3),d3                      ; 017EA
        move.w  $32(a3),d5                      ; 017EE
        move.w  d3,$2c(a1)                      ; 017F2
        move.w  d5,$2e(a1)                      ; 017F6
        asl.w   #$6,d3                          ; 017FA
        asl.w   #$6,d5                          ; 017FC
        swap    d3                              ; 017FE
        swap    d5                              ; 01800
        movem.l $0(a3),d0-d2                    ; 01802
        add.l   d0,d3                           ; 01808
        add.l   d2,d5                           ; 0180A
        move.l  d1,d4                           ; 0180C
        asr.l   #$8,d0                          ; 0180E
        asr.l   #$8,d1                          ; 01810
        asr.l   #$8,d2                          ; 01812
        move.w  d0,$30(a1)                      ; 01814
        move.w  d2,$32(a1)                      ; 01818
        move.l  d1,$34(a1)                      ; 0181C
        move.w  #$4800,d0                       ; 01820
        sub.l   $14(a1),d3                      ; 01824
        bge.b   l_017_0182C                     ; 01828
        neg.l   d3                              ; 0182A
l_017_0182C:
        cmp.l   d0,d3                           ; 0182C
        bgt.b   l_017_01850                     ; 0182E
        sub.l   $18(a1),d4                      ; 01830
        bge.b   l_017_01838                     ; 01834
        neg.l   d4                              ; 01836
l_017_01838:
        cmp.l   d0,d4                           ; 01838
        bgt.b   l_017_01850                     ; 0183A
        sub.l   $1c(a1),d5                      ; 0183C
        bge.b   l_017_01844                     ; 01840
        neg.l   d5                              ; 01842
l_017_01844:
        cmp.l   d0,d5                           ; 01844
        bgt.b   l_017_01850                     ; 01846
        bset    #$0,$3(a1)                      ; 01848
        bra.b   l_017_0185E                     ; 0184E
l_017_01850:
        btst    #$0,$3(a1)                      ; 01850
        beq.b   l_017_0185E                     ; 01856
        bset    #$5,$20(a1)                     ; 01858
l_017_0185E:
        moveq   #$1,d0                          ; 0185E
        rts                                     ; 01860
sub_017_01862:
        cmpi.w  #$1200,$6c(a1)                  ; 01862
        blt.b   l_017_0188E                     ; 01868
        move.b  $7c(a1),d1                      ; 0186A
        andi.b  #$70,d1                         ; 0186E
        bne.b   l_017_0188E                     ; 01872
        tst.b   (dat_071_00216).l               ; 01874
        bne.b   l_017_01894                     ; 0187A
        move.b  #$1,(dat_071_00216).l           ; 0187C
        moveq   #$4,d0                          ; 01884
        jsr     (sub_039_0186E).l               ; 01886
        bra.b   l_017_01894                     ; 0188C
l_017_0188E:
        clr.b   (dat_071_00216).l               ; 0188E
l_017_01894:
        move.w  (dat_071_00390).l,d0            ; 01894
        ble.b   l_017_018E6                     ; 0189A
        lea.l   (ObjectTable).l,a2              ; 0189C
        adda.w  d0,a2                           ; 018A2
        addi.b  #$10,$39(a1)                    ; 018A4
        cmpi.w  #$480,$4a(a1)                   ; 018AA
        blt.b   l_017_018CA                     ; 018B0
        moveq   #$20,d1                         ; 018B2
        cmpi.w  #$900,$4a(a1)                   ; 018B4
        blt.b   l_017_018BE                     ; 018BA
        moveq   #$50,d1                         ; 018BC
l_017_018BE:
        move.b  $39(a1),d0                      ; 018BE
        andi.b  #$f0,d0                         ; 018C2
        cmp.b   d0,d1                           ; 018C6
        bge.b   l_017_018E6                     ; 018C8
l_017_018CA:
        andi.b  #$f,$39(a1)                     ; 018CA
        move.w  $c(a2),d0                       ; 018D0
        move.w  $e(a2),d1                       ; 018D4
        move.w  $6(a2),d2                       ; 018D8
        move.w  $8(a2),d4                       ; 018DC
        move.l  $10(a2),d3                      ; 018E0
        bra.b   l_017_0192A                     ; 018E4
l_017_018E6:
        rts                                     ; 018E6
sub_017_018E8:
        addi.b  #$10,$39(a1)                    ; 018E8
        cmpi.w  #$480,$4a(a1)                   ; 018EE
        blt.b   l_017_0190E                     ; 018F4
        moveq   #$20,d1                         ; 018F6
        cmpi.w  #$900,$4a(a1)                   ; 018F8
        blt.b   l_017_01902                     ; 018FE
        moveq   #$50,d1                         ; 01900
l_017_01902:
        move.b  $39(a1),d0                      ; 01902
        andi.b  #$f0,d0                         ; 01906
        cmp.b   d0,d1                           ; 0190A
        bge.b   l_017_018E6                     ; 0190C
l_017_0190E:
        andi.b  #$f,$39(a1)                     ; 0190E
        move.w  $2c(a1),d2                      ; 01914
        blt.b   l_017_018E6                     ; 01918
        move.w  $2e(a1),d4                      ; 0191A
        move.w  $30(a1),d0                      ; 0191E
        move.w  $32(a1),d1                      ; 01922
        move.l  $34(a1),d3                      ; 01926
l_017_0192A:
        ext.l   d2                              ; 0192A
        ext.l   d4                              ; 0192C
        sub.w   $6(a1),d2                       ; 0192E
        swap    d2                              ; 01932
        asr.l   #$2,d2                          ; 01934
        sub.w   $c(a1),d0                       ; 01936
        ext.l   d0                              ; 0193A
        add.l   d0,d2                           ; 0193C
        bge.b   l_017_01942                     ; 0193E
        neg.l   d2                              ; 01940
l_017_01942:
        sub.w   $8(a1),d4                       ; 01942
        swap    d4                              ; 01946
        asr.l   #$2,d4                          ; 01948
        sub.w   $e(a1),d1                       ; 0194A
        ext.l   d1                              ; 0194E
        add.l   d1,d4                           ; 01950
        bge.b   l_017_01956                     ; 01952
        neg.l   d4                              ; 01954
l_017_01956:
        sub.l   $10(a1),d3                      ; 01956
        bge.b   l_017_0195E                     ; 0195A
        neg.l   d3                              ; 0195C
l_017_0195E:
        move.l  #$7f00,d0                       ; 0195E
        cmp.l   d0,d2                           ; 01964
        bgt.b   l_017_019CC                     ; 01966
        cmp.l   d0,d3                           ; 01968
        bgt.b   l_017_019CC                     ; 0196A
        cmp.l   d0,d4                           ; 0196C
        bgt.b   l_017_019CC                     ; 0196E
        jsr     (sub_008_016AC).l               ; 01970
        move.w  d1,$4a(a1)                      ; 01976
        bset    #$0,$4(a1)                      ; 0197A
        cmpi.w  #$36c0,d1                       ; 01980
        bgt.b   l_017_019D2                     ; 01984
        cmpi.w  #$1e00,d1                       ; 01986
        bgt.b   l_017_0199C                     ; 0198A
        cmpi.b  #$3,$7a(a1)                     ; 0198C
        bne.b   l_017_019AA                     ; 01992
        move.b  #$4,$7a(a1)                     ; 01994
        bra.b   l_017_019AA                     ; 0199A
l_017_0199C:
        cmpi.b  #$4,$7a(a1)                     ; 0199C
        bne.b   l_017_019AA                     ; 019A2
        move.b  #$3,$7a(a1)                     ; 019A4
l_017_019AA:
        tst.w   (CurrentObjectOffset).l         ; 019AA
        beq.b   l_017_019E0                     ; 019B0
        cmpi.w  #$1800,d1                       ; 019B2
        bgt.b   l_017_019CC                     ; 019B6
        cmpi.w  #$300,d1                        ; 019B8
        bgt.b   l_017_019E2                     ; 019BC
        andi.b  #$f,$63(a1)                     ; 019BE
        ori.b   #$10,$63(a1)                    ; 019C4
        rts                                     ; 019CA
l_017_019CC:
        move.w  #$7fff,$4a(a1)                  ; 019CC
l_017_019D2:
        tst.w   (CurrentObjectOffset).l         ; 019D2
        beq.b   l_017_019E0                     ; 019D8
        ori.b   #$f0,$63(a1)                    ; 019DA
l_017_019E0:
        rts                                     ; 019E0
l_017_019E2:
        andi.b  #$f,$63(a1)                     ; 019E2
        cmpi.w  #$c00,d1                        ; 019E8
        bgt.b   l_017_019F6                     ; 019EC
        ori.b   #$20,$63(a1)                    ; 019EE
        rts                                     ; 019F4
l_017_019F6:
        ori.b   #$30,$63(a1)                    ; 019F6
        rts                                     ; 019FC
	dc.b	$00,$00
h017_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    11,17                           ; 11 longs pointing into hunk 17
	dc.l	$C8C,$C84,$C7C,$990,$940,$858,$7BA,$7A8
	dc.l	$71A,$6E0,$62E
        dc.l    213,71                          ; 213 longs pointing into hunk 71
	dc.l	$4CC,$4D4,$4DC,$94A,$1668,$B0A,$B14,$1418
	dc.l	$1422,$1612,$1876,$1880,$1890,$5C6,$5D0,$5E0
	dc.l	$5B4,$17DA,$179A,$1790,$1210,$B4,$BC,$C2
	dc.l	$CA,$AF8,$ADC,$AEE,$B6C,$7DE,$B74,$AD6
	dc.l	$155C,$1600,$1608,$1656,$C66,$C6E,$776,$462
	dc.l	$45A,$432,$454,$1388,$15F0,$1896,$604,$640
	dc.l	$830,$83C,$86C,$5FC,$618,$6D6,$710,$7AE
	dc.l	$7C0,$842,$874,$8FA,$90C,$922,$AA0,$46C
	dc.l	$49A,$A34,$6C2,$70A,$DA,$11A,$160,$1A4
	dc.l	$1F6,$216,$268,$284,$2B4,$2D0,$318,$334
	dc.l	$37C,$398,$3E6,$416,$1396,$15F8,$19AC,$19D4
	dc.l	$D4,$112,$158,$19C,$1EE,$20E,$260,$27C
	dc.l	$2AC,$2C8,$310,$32C,$374,$390,$3DE,$40E
	dc.l	$930,$A42,$BEA,$11FC,$167A,$B62,$936,$1202
	dc.l	$164C,$1646,$474,$4A2,$742,$782,$BA8,$BC8
	dc.l	$11B6,$11D2,$1410,$1576,$116C,$1152,$1164,$66
	dc.l	$E0,$E6,$120,$126,$166,$16C,$1AA,$1B0
	dc.l	$1DE,$21C,$222,$250,$28A,$290,$29C,$2D6
	dc.l	$2DC,$300,$33A,$340,$364,$39E,$3A4,$3C8
	dc.l	$3F8,$43A,$554,$A2E,$A9A,$B5C,$F04,$F2C
	dc.l	$10D4,$13A0,$13F6,$17A2,$189E,$C,$50,$B30
	dc.l	$14AA,$14DA,$14E0,$B00,$4,$AC,$EC,$6CA
	dc.l	$758,$E00,$1028,$110A,$12DA,$6BC,$974,$D4A
	dc.l	$12C0,$BB6,$BD6,$912,$5E8,$72E,$76E,$7CE
	dc.l	$820,$952,$1552,$11F4,$4B6,$95A,$96C,$A3A
	dc.l	$B26,$1104,$12D4,$E32,$536,$5A0,$230,$136
	dc.l	$17A,$1BE,$ACE,$107A,$16A6
        dc.l    3,27                            ; 3 longs pointing into hunk 27
	dc.l	$168E,$1054,$16B8
        dc.l    2,16                            ; 2 longs pointing into hunk 16
	dc.l	$BDC,$BE4
        dc.l    7,73                            ; 7 longs pointing into hunk 73
	dc.l	$6F0,$752,$7F2,$810,$8CE,$8F2,$918
        dc.l    1,30                            ; 1 longs pointing into hunk 30
	dc.l	$1570
        dc.l    1,2                             ; 1 longs pointing into hunk 2
	dc.l	$B8A
        dc.l    2,39                            ; 2 longs pointing into hunk 39
	dc.l	$5D8,$1888
        dc.l    3,26                            ; 3 longs pointing into hunk 26
	dc.l	$790,$882,$60
        dc.l    1,0                             ; 1 longs pointing into hunk 0
	dc.l	$516
        dc.l    2,32                            ; 2 longs pointing into hunk 32
	dc.l	$A86,$A7A
        dc.l    3,5                             ; 3 longs pointing into hunk 5
	dc.l	$1216,$A48,$120A
        dc.l    7,20                            ; 7 longs pointing into hunk 20
	dc.l	$D88,$171E,$638,$862,$8B4,$8C0,$99C
        dc.l    2,4                             ; 2 longs pointing into hunk 4
	dc.l	$67C,$14FC
        dc.l    1,8                             ; 1 longs pointing into hunk 8
	dc.l	$1972
        dc.l    15,22                           ; 15 longs pointing into hunk 22
	dc.l	$10A,$150,$194,$1D8,$206,$24A,$274,$2C0
	dc.l	$2FA,$324,$35E,$388,$3C2,$3F2,$422
        dc.l    1,18                            ; 1 longs pointing into hunk 18
	dc.l	$428
        dc.l    2,7                             ; 2 longs pointing into hunk 7
	dc.l	$1080,$16AC
	dc.l	0
	dc.l	HUNK_END
	endc
