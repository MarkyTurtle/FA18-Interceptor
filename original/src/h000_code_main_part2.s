; F/A-18 Interceptor - hunk 0 (code), part 2 of 3
; The C startup (c.o), main, RunGame and GameFrame (the frame loop); the EA IFF picture reader;
; memory and disk checks; the flight log (df0:config) and flight recording (textply/textctl)
; files; the keyboard, joystick, timer and mouse; loading and playing the sounds.
; Included by ../f18_main.s.

;-------------------------------------------------------------------------------
; CheckViewObjectGone - When the object the view follows (dat_071_002AC) no longer exists (+$00
; bit 6), returns the view to the player's aircraft and asks for everything to be redrawn.
;-------------------------------------------------------------------------------
CheckViewObjectGone:
        tst.w   (ViewObjectIndex).l             ; 04392
        beq.b   l_000_043F0                     ; 04398
        move.w  (ViewObjectIndex).l,d0          ; 0439A
        moveq   #$9,d1                          ; 043A0
        ext.l   d0                              ; 043A2
        asl.l   d1,d0                           ; 043A4
        movea.l d0,a0                           ; 043A6
        adda.l  #ObjectTable,a0                 ; 043A8
        move.w  (a0),d0                         ; 043AE
        btst    #$6,d0                          ; 043B0
        bne.b   l_000_043F0                     ; 043B4
        moveq   #$0,d0                          ; 043B6
        move.w  d0,(ViewObjectIndex).l          ; 043B8
        move.w  d0,(ViewObject).l               ; 043BE
        move.b  #$ff,(RedrawFlags).l            ; 043C4
        move.b  (OutsideView).l,d0              ; 043CC
        tst.b   d0                              ; 043D2
        bne.b   l_000_043F0                     ; 043D4
        clr.b   (ViewZoom).l                    ; 043D6
        moveq   #$0,d0                          ; 043DC
        move.w  d0,(ViewShift).l                ; 043DE
        move.w  d0,(ViewX).l                    ; 043E4
        jsr     (sub_005_00E6E).l               ; 043EA
l_000_043F0:
        rts                                     ; 043F0

;-------------------------------------------------------------------------------
; SetHeightBand - Sets HeightBand from the view's height (/8): 0 up to $64, 1 to $12C, 2 to
; $C80, and 3 between $258 and $C4E (asking for the scenery to be rebuilt, RedrawFlags $0B,
; when it changes); dat_071_0023C while between $1C2 and $C80. More after (not worked out).
;-------------------------------------------------------------------------------
SetHeightBand:
        link.w  a6,#$fffa                       ; 043F2
        tst.b   (OutsideView).l                 ; 043F6
        beq.b   l_000_04410                     ; 043FC
        move.w  (OutsideCamPitch).l,d0          ; 043FE
        asr.w   #$3,d0                          ; 04404
        clr.w   -$4(a6)                         ; 04406
        move.w  d0,-$2(a6)                      ; 0440A
        bra.b   l_000_04428                     ; 0440E
l_000_04410:
        move.l  (dat_071_00458).l,d0            ; 04410
        asr.l   #$3,d0                          ; 04416
        move.l  (dat_071_00460).l,d1            ; 04418
        asr.l   #$3,d1                          ; 0441E
        move.w  d0,-$2(a6)                      ; 04420
        move.w  d1,-$4(a6)                      ; 04424
l_000_04428:
        move.w  -$2(a6),d0                      ; 04428
        cmpi.w  #$258,d0                        ; 0442C
        ble.b   l_000_04466                     ; 04430
        cmpi.w  #$c4e,d0                        ; 04432
        bge.b   l_000_04466                     ; 04436
        move.b  (dat_071_00156).l,d0            ; 04438
        tst.b   d0                              ; 0443E
        bne.w   l_000_044DE                     ; 04440
        addq.b  #$1,d0                          ; 04444
        move.b  d0,(dat_071_00156).l            ; 04446
        move.b  (RedrawFlags).l,d0              ; 0444C
        ori.b   #$b,d0                          ; 04452
        move.b  d0,(RedrawFlags).l              ; 04456
        move.b  #$3,(HeightBand).l              ; 0445C
        bra.b   l_000_044DE                     ; 04464
l_000_04466:
        tst.b   (dat_071_00156).l               ; 04466
        beq.b   l_000_04484                     ; 0446C
        clr.b   (dat_071_00156).l               ; 0446E
        move.b  (RedrawFlags).l,d0              ; 04474
        ori.b   #$b,d0                          ; 0447A
        move.b  d0,(RedrawFlags).l              ; 0447E
l_000_04484:
        move.w  -$2(a6),d0                      ; 04484
        cmpi.w  #$1c2,d0                        ; 04488
        ble.b   l_000_0449E                     ; 0448C
        cmpi.w  #$c80,d0                        ; 0448E
        bge.b   l_000_0449E                     ; 04492
        move.b  #$1,(dat_071_0023C).l           ; 04494
        bra.b   l_000_044DE                     ; 0449C
l_000_0449E:
        clr.b   (dat_071_0023C).l               ; 0449E
        move.w  -$2(a6),d0                      ; 044A4
        cmpi.w  #$c80,d0                        ; 044A8
        bge.b   l_000_044D8                     ; 044AC
        cmpi.w  #$12c,d0                        ; 044AE
        ble.b   l_000_044BE                     ; 044B2
        move.b  #$2,(HeightBand).l              ; 044B4
        bra.b   l_000_044DE                     ; 044BC
l_000_044BE:
        cmpi.w  #$64,-$2(a6)                    ; 044BE
        ble.b   l_000_044D0                     ; 044C4
        move.b  #$1,(HeightBand).l              ; 044C6
        bra.b   l_000_044DE                     ; 044CE
l_000_044D0:
        clr.b   (HeightBand).l                  ; 044D0
        bra.b   l_000_044DE                     ; 044D6
l_000_044D8:
        clr.b   (HeightBand).l                  ; 044D8
l_000_044DE:
        move.w  (dat_071_0029A).l,d0            ; 044DE
        andi.w  #$fffd,d0                       ; 044E4
        move.w  d0,(dat_071_0029A).l            ; 044E8
        clr.b   -$5(a6)                         ; 044EE
        move.w  -$2(a6),d0                      ; 044F2
        cmpi.w  #$384,d0                        ; 044F6
        blt.b   l_000_04502                     ; 044FA
        cmpi.w  #$a8c,d0                        ; 044FC
        blt.b   l_000_0451A                     ; 04500
l_000_04502:
        move.w  -$4(a6),d0                      ; 04502
        cmpi.w  #$384,d0                        ; 04506
        blt.b   l_000_04530                     ; 0450A
        cmpi.w  #$a8c,d0                        ; 0450C
        bgt.b   l_000_04530                     ; 04510
        move.b  #$1,-$5(a6)                     ; 04512
        bra.b   l_000_04530                     ; 04518
l_000_0451A:
        move.w  -$4(a6),d0                      ; 0451A
        cmpi.w  #$384,d0                        ; 0451E
        blt.b   l_000_0452A                     ; 04522
        cmpi.w  #$a8c,d0                        ; 04524
        blt.b   l_000_04530                     ; 04528
l_000_0452A:
        move.b  #$1,-$5(a6)                     ; 0452A
l_000_04530:
        tst.b   -$5(a6)                         ; 04530
        beq.b   l_000_04546                     ; 04534
        move.w  (dat_071_0029A).l,d0            ; 04536
        ori.w   #$2,d0                          ; 0453C
        move.w  d0,(dat_071_0029A).l            ; 04540
l_000_04546:
        unlk    a6                              ; 04546
        rts                                     ; 04548

;-------------------------------------------------------------------------------
; VectorToAngles - VectorToAngles(pitch, heading, dx, dy, dz): the heading and pitch of a
; direction (an arctangent: the ratio of two parts (Divide) looked up in ArcTanTable, by
; octant), into dat_071_00490 (pitch) and dat_071_00492 (heading).
;-------------------------------------------------------------------------------
VectorToAngles:
        link.w  a6,#$ffe4                       ; 0454A
        movem.l d2,-(a7)                        ; 0454E
        move.w  #$2,-$1c(a6)                    ; 04552
        moveq   #$0,d0                          ; 04558
        move.b  d0,-$9(a6)                      ; 0455A
        tst.l   $10(a6)                         ; 0455E
        bpl.b   l_000_04570                     ; 04562
        neg.l   $10(a6)                         ; 04564
        bset    #$0,d0                          ; 04568
        move.b  d0,-$9(a6)                      ; 0456C
l_000_04570:
        tst.l   $14(a6)                         ; 04570
        bpl.b   l_000_04580                     ; 04574
        neg.l   $14(a6)                         ; 04576
        bset    #$1,-$9(a6)                     ; 0457A
l_000_04580:
        tst.l   $18(a6)                         ; 04580
        bpl.b   l_000_04590                     ; 04584
        neg.l   $18(a6)                         ; 04586
        bset    #$2,-$9(a6)                     ; 0458A
l_000_04590:
        move.l  $10(a6),d0                      ; 04590
        cmp.l   $14(a6),d0                      ; 04594
        ble.b   l_000_045AE                     ; 04598
        cmp.l   $18(a6),d0                      ; 0459A
        ble.b   l_000_045A6                     ; 0459E
        move.l  d0,-$16(a6)                     ; 045A0
        bra.b   l_000_045C4                     ; 045A4
l_000_045A6:
        move.l  $18(a6),-$16(a6)                ; 045A6
        bra.b   l_000_045C4                     ; 045AC
l_000_045AE:
        move.l  $14(a6),d0                      ; 045AE
        cmp.l   $18(a6),d0                      ; 045B2
        ble.b   l_000_045BE                     ; 045B6
        move.l  d0,-$16(a6)                     ; 045B8
        bra.b   l_000_045C4                     ; 045BC
l_000_045BE:
        move.l  $18(a6),-$16(a6)                ; 045BE
l_000_045C4:
        cmpi.l  #$10000000,-$16(a6)             ; 045C4
        ble.b   l_000_045F8                     ; 045CC
        move.l  $10(a6),d0                      ; 045CE
        asr.l   #$3,d0                          ; 045D2
        move.l  $14(a6),d1                      ; 045D4
        asr.l   #$3,d1                          ; 045D8
        move.l  $18(a6),d2                      ; 045DA
        asr.l   #$3,d2                          ; 045DE
        move.w  #$e,-$18(a6)                    ; 045E0
        clr.w   -$1a(a6)                        ; 045E6
        move.l  d0,$10(a6)                      ; 045EA
        move.l  d1,$14(a6)                      ; 045EE
        move.l  d2,$18(a6)                      ; 045F2
        bra.b   l_000_0464A                     ; 045F6
l_000_045F8:
        cmpi.l  #$2000000,-$16(a6)              ; 045F8
        ble.b   l_000_0460E                     ; 04600
        move.w  #$e,-$18(a6)                    ; 04602
        clr.w   -$1a(a6)                        ; 04608
        bra.b   l_000_0464A                     ; 0460C
l_000_0460E:
        cmpi.l  #$800000,-$16(a6)               ; 0460E
        ble.b   l_000_04626                     ; 04616
        move.w  #$c,-$18(a6)                    ; 04618
        move.w  #$2,-$1a(a6)                    ; 0461E
        bra.b   l_000_0464A                     ; 04624
l_000_04626:
        cmpi.l  #$200000,-$16(a6)               ; 04626
        ble.b   l_000_0463E                     ; 0462E
        move.w  #$a,-$18(a6)                    ; 04630
        move.w  #$4,-$1a(a6)                    ; 04636
        bra.b   l_000_0464A                     ; 0463C
l_000_0463E:
        move.w  #$8,-$18(a6)                    ; 0463E
        move.w  #$6,-$1a(a6)                    ; 04644
l_000_0464A:
        move.w  -$18(a6),d0                     ; 0464A
        ext.l   d0                              ; 0464E
        move.l  $10(a6),d1                      ; 04650
        asr.l   d0,d1                           ; 04654
        move.l  $18(a6),d2                      ; 04656
        asr.l   d0,d2                           ; 0465A
        move.w  d1,-$4(a6)                      ; 0465C
        move.w  d2,-$6(a6)                      ; 04660
        cmp.w   d2,d1                           ; 04664
        bgt.b   l_000_046BA                     ; 04666
        move.w  -$1a(a6),d0                     ; 04668
        ext.l   d0                              ; 0466C
        move.l  $10(a6),d1                      ; 0466E
        asl.l   d0,d1                           ; 04672
        move.l  d1,(dat_071_0049C).l            ; 04674
        move.w  d2,(dat_071_004A0).l            ; 0467A
        tst.w   d2                              ; 04680
        beq.b   l_000_046B0                     ; 04682
        jsr     (Divide).l                      ; 04684
        move.w  (dat_071_004A2).l,d0            ; 0468A
        asr.w   #$6,d0                          ; 04690
        move.w  d0,(dat_071_004A2).l            ; 04692
        ext.l   d0                              ; 04698
        asl.l   #$1,d0                          ; 0469A
        movea.l d0,a0                           ; 0469C
        adda.l  #ArcTanTable,a0                 ; 0469E
        move.w  (a0),d0                         ; 046A4
        ext.l   d0                              ; 046A6
        asl.l   #$3,d0                          ; 046A8
        move.l  d0,-$12(a6)                     ; 046AA
        bra.b   l_000_04706                     ; 046AE
l_000_046B0:
        move.l  #$e10,-$12(a6)                  ; 046B0
        bra.b   l_000_04706                     ; 046B8
l_000_046BA:
        move.w  -$1a(a6),d0                     ; 046BA
        ext.l   d0                              ; 046BE
        move.l  $18(a6),d1                      ; 046C0
        asl.l   d0,d1                           ; 046C4
        move.l  d1,(dat_071_0049C).l            ; 046C6
        move.w  -$4(a6),(dat_071_004A0).l       ; 046CC
        jsr     (Divide).l                      ; 046D4
        move.w  (dat_071_004A2).l,d0            ; 046DA
        asr.w   #$6,d0                          ; 046E0
        move.w  d0,(dat_071_004A2).l            ; 046E2
        ext.l   d0                              ; 046E8
        asl.l   #$1,d0                          ; 046EA
        movea.l d0,a0                           ; 046EC
        adda.l  #ArcTanTable,a0                 ; 046EE
        move.w  (a0),d0                         ; 046F4
        ext.l   d0                              ; 046F6
        move.l  #$384,d1                        ; 046F8
        sub.l   d0,d1                           ; 046FE
        asl.l   #$3,d1                          ; 04700
        move.l  d1,-$12(a6)                     ; 04702
l_000_04706:
        move.b  -$9(a6),d0                      ; 04706
        andi.b  #$5,d0                          ; 0470A
        move.b  d0,-$a(a6)                      ; 0470E
        subq.b  #$5,d0                          ; 04712
        bne.b   l_000_04726                     ; 04714
        move.l  #$3840,d0                       ; 04716
        sub.l   -$12(a6),d0                     ; 0471C
        move.l  d0,-$12(a6)                     ; 04720
        bra.b   l_000_0474C                     ; 04724
l_000_04726:
        cmpi.b  #$4,-$a(a6)                     ; 04726
        bne.b   l_000_04738                     ; 0472C
        addi.l  #$3840,-$12(a6)                 ; 0472E
        bra.b   l_000_0474C                     ; 04736
l_000_04738:
        tst.b   -$a(a6)                         ; 04738
        bne.b   l_000_0474C                     ; 0473C
        move.l  #$7080,d0                       ; 0473E
        sub.l   -$12(a6),d0                     ; 04744
        move.l  d0,-$12(a6)                     ; 04748
l_000_0474C:
        move.w  -$18(a6),d0                     ; 0474C
        ext.l   d0                              ; 04750
        move.l  $18(a6),d1                      ; 04752
        asr.l   d0,d1                           ; 04756
        move.w  d1,-$8(a6)                      ; 04758
        muls.w  d1,d1                           ; 0475C
        move.l  $10(a6),d2                      ; 0475E
        asr.l   d0,d2                           ; 04762
        move.w  d2,-$8(a6)                      ; 04764
        muls.w  d2,d2                           ; 04768
        move.l  d1,-$16(a6)                     ; 0476A
        add.l   d2,d1                           ; 0476E
        move.l  d1,(dat_071_00534).l            ; 04770
        jsr     (sub_020_0089E).l               ; 04776
        move.w  -$18(a6),d0                     ; 0477C
        ext.l   d0                              ; 04780
        move.l  $14(a6),d1                      ; 04782
        asr.l   d0,d1                           ; 04786
        move.w  d1,-$2(a6)                      ; 04788
        ext.l   d1                              ; 0478C
        move.w  (dat_071_00538).l,d0            ; 0478E
        ext.l   d0                              ; 04794
        cmp.l   d0,d1                           ; 04796
        bgt.b   l_000_047E0                     ; 04798
        asl.l   #$8,d1                          ; 0479A
        move.l  d1,(dat_071_0049C).l            ; 0479C
        move.w  (dat_071_00538).l,d0            ; 047A2
        move.w  d0,(dat_071_004A0).l            ; 047A8
        tst.w   d0                              ; 047AE
        beq.b   l_000_047D6                     ; 047B0
        jsr     (Divide).l                      ; 047B2
        move.w  (dat_071_004A2).l,d0            ; 047B8
        ext.l   d0                              ; 047BE
        asl.l   #$1,d0                          ; 047C0
        movea.l d0,a0                           ; 047C2
        adda.l  #ArcTanTable,a0                 ; 047C4
        move.w  (a0),d0                         ; 047CA
        ext.l   d0                              ; 047CC
        asl.l   #$3,d0                          ; 047CE
        move.l  d0,-$e(a6)                      ; 047D0
        bra.b   l_000_04822                     ; 047D4
l_000_047D6:
        move.l  #$e10,-$e(a6)                   ; 047D6
        bra.b   l_000_04822                     ; 047DE
l_000_047E0:
        move.w  (dat_071_00538).l,d0            ; 047E0
        ext.l   d0                              ; 047E6
        asl.l   #$8,d0                          ; 047E8
        move.l  d0,(dat_071_0049C).l            ; 047EA
        move.w  -$2(a6),(dat_071_004A0).l       ; 047F0
        jsr     (Divide).l                      ; 047F8
        move.w  (dat_071_004A2).l,d0            ; 047FE
        ext.l   d0                              ; 04804
        asl.l   #$1,d0                          ; 04806
        movea.l d0,a0                           ; 04808
        adda.l  #ArcTanTable,a0                 ; 0480A
        move.w  (a0),d0                         ; 04810
        ext.l   d0                              ; 04812
        move.l  #$384,d1                        ; 04814
        sub.l   d0,d1                           ; 0481A
        asl.l   #$3,d1                          ; 0481C
        move.l  d1,-$e(a6)                      ; 0481E
l_000_04822:
        btst    #$1,-$9(a6)                     ; 04822
        bne.b   l_000_04838                     ; 04828
        move.l  #$7080,d0                       ; 0482A
        sub.l   -$e(a6),d0                      ; 04830
        move.l  d0,-$e(a6)                      ; 04834
l_000_04838:
        cmpi.l  #$7080,-$e(a6)                  ; 04838
        blt.b   l_000_04846                     ; 04840
        clr.l   -$e(a6)                         ; 04842
l_000_04846:
        cmpi.l  #$7080,-$12(a6)                 ; 04846
        blt.b   l_000_04854                     ; 0484E
        clr.l   -$12(a6)                        ; 04850
l_000_04854:
        tst.l   $1c(a6)                         ; 04854
        bmi.b   l_000_0486C                     ; 04858
        move.b  (CameraSequence).l,d0           ; 0485A
        move.b  (dat_071_00176).l,d1            ; 04860
        or.b    d1,d0                           ; 04866
        tst.b   d0                              ; 04868
        bne.b   l_000_04884                     ; 0486A
l_000_0486C:
        move.b  #$1,(dat_071_00176).l           ; 0486C
        move.l  -$e(a6),$8(a6)                  ; 04874
        move.l  -$12(a6),$c(a6)                 ; 0487A
        bra.w   l_000_04A84                     ; 04880
l_000_04884:
        move.l  -$e(a6),d0                      ; 04884
        sub.l   $8(a6),d0                       ; 04888
        move.l  d0,-$e(a6)                      ; 0488C
        tst.l   d0                              ; 04890
        bpl.b   l_000_0490E                     ; 04892
        cmpi.l  #$ffffc7c0,d0                   ; 04894
        bge.b   l_000_048E6                     ; 0489A
        addi.l  #$7080,d0                       ; 0489C
        moveq   #$0,d1                          ; 048A2
        move.w  -$1c(a6),d1                     ; 048A4
        asr.l   d1,d0                           ; 048A8
        move.l  d0,-$e(a6)                      ; 048AA
        move.l  $1c(a6),d1                      ; 048AE
        cmp.l   d1,d0                           ; 048B2
        ble.b   l_000_048BA                     ; 048B4
        move.l  d1,-$e(a6)                      ; 048B6
l_000_048BA:
        move.l  -$e(a6),d0                      ; 048BA
        add.l   $8(a6),d0                       ; 048BE
        move.l  d0,-$e(a6)                      ; 048C2
        cmpi.l  #$7080,d0                       ; 048C6
        blt.b   l_000_048DC                     ; 048CC
        subi.l  #$7080,d0                       ; 048CE
        move.l  d0,$8(a6)                       ; 048D4
        bra.w   l_000_04984                     ; 048D8
l_000_048DC:
        move.l  -$e(a6),$8(a6)                  ; 048DC
        bra.w   l_000_04984                     ; 048E2
l_000_048E6:
        move.l  -$e(a6),d0                      ; 048E6
        neg.l   d0                              ; 048EA
        moveq   #$0,d1                          ; 048EC
        move.w  -$1c(a6),d1                     ; 048EE
        asr.l   d1,d0                           ; 048F2
        move.l  d0,-$e(a6)                      ; 048F4
        move.l  $1c(a6),d1                      ; 048F8
        cmp.l   d1,d0                           ; 048FC
        ble.b   l_000_04904                     ; 048FE
        move.l  d1,-$e(a6)                      ; 04900
l_000_04904:
        move.l  -$e(a6),d0                      ; 04904
        sub.l   d0,$8(a6)                       ; 04908
        bra.b   l_000_04984                     ; 0490C
l_000_0490E:
        move.l  -$e(a6),d0                      ; 0490E
        cmpi.l  #$3840,d0                       ; 04912
        ble.b   l_000_04960                     ; 04918
        move.l  #$7080,d1                       ; 0491A
        sub.l   d0,d1                           ; 04920
        moveq   #$0,d0                          ; 04922
        move.w  -$1c(a6),d0                     ; 04924
        asr.l   d0,d1                           ; 04928
        move.l  d1,-$e(a6)                      ; 0492A
        move.l  $1c(a6),d0                      ; 0492E
        cmp.l   d0,d1                           ; 04932
        ble.b   l_000_0493A                     ; 04934
        move.l  d0,-$e(a6)                      ; 04936
l_000_0493A:
        move.l  -$e(a6),d0                      ; 0493A
        move.l  $8(a6),d1                       ; 0493E
        sub.l   d0,d1                           ; 04942
        move.l  d1,-$e(a6)                      ; 04944
        tst.l   d1                              ; 04948
        bpl.b   l_000_04958                     ; 0494A
        addi.l  #$7080,d1                       ; 0494C
        move.l  d1,$8(a6)                       ; 04952
        bra.b   l_000_04984                     ; 04956
l_000_04958:
        move.l  -$e(a6),$8(a6)                  ; 04958
        bra.b   l_000_04984                     ; 0495E
l_000_04960:
        moveq   #$0,d0                          ; 04960
        move.w  -$1c(a6),d0                     ; 04962
        move.l  -$e(a6),d1                      ; 04966
        asr.l   d0,d1                           ; 0496A
        move.l  d1,-$e(a6)                      ; 0496C
        move.l  $1c(a6),d0                      ; 04970
        cmp.l   d0,d1                           ; 04974
        ble.b   l_000_0497C                     ; 04976
        move.l  d0,-$e(a6)                      ; 04978
l_000_0497C:
        move.l  -$e(a6),d0                      ; 0497C
        add.l   d0,$8(a6)                       ; 04980
l_000_04984:
        move.l  -$12(a6),d0                     ; 04984
        sub.l   $c(a6),d0                       ; 04988
        move.l  d0,-$12(a6)                     ; 0498C
        tst.l   d0                              ; 04990
        bpl.b   l_000_04A0E                     ; 04992
        cmpi.l  #$ffffc7c0,d0                   ; 04994
        bge.b   l_000_049E6                     ; 0499A
        addi.l  #$7080,d0                       ; 0499C
        moveq   #$0,d1                          ; 049A2
        move.w  -$1c(a6),d1                     ; 049A4
        asr.l   d1,d0                           ; 049A8
        move.l  d0,-$12(a6)                     ; 049AA
        move.l  $1c(a6),d1                      ; 049AE
        cmp.l   d1,d0                           ; 049B2
        ble.b   l_000_049BA                     ; 049B4
        move.l  d1,-$12(a6)                     ; 049B6
l_000_049BA:
        move.l  -$12(a6),d0                     ; 049BA
        add.l   $c(a6),d0                       ; 049BE
        move.l  d0,-$12(a6)                     ; 049C2
        cmpi.l  #$7080,d0                       ; 049C6
        blt.b   l_000_049DC                     ; 049CC
        subi.l  #$7080,d0                       ; 049CE
        move.l  d0,$c(a6)                       ; 049D4
        bra.w   l_000_04A84                     ; 049D8
l_000_049DC:
        move.l  -$12(a6),$c(a6)                 ; 049DC
        bra.w   l_000_04A84                     ; 049E2
l_000_049E6:
        move.l  -$12(a6),d0                     ; 049E6
        neg.l   d0                              ; 049EA
        moveq   #$0,d1                          ; 049EC
        move.w  -$1c(a6),d1                     ; 049EE
        asr.l   d1,d0                           ; 049F2
        move.l  d0,-$12(a6)                     ; 049F4
        move.l  $1c(a6),d1                      ; 049F8
        cmp.l   d1,d0                           ; 049FC
        ble.b   l_000_04A04                     ; 049FE
        move.l  d1,-$12(a6)                     ; 04A00
l_000_04A04:
        move.l  -$12(a6),d0                     ; 04A04
        sub.l   d0,$c(a6)                       ; 04A08
        bra.b   l_000_04A84                     ; 04A0C
l_000_04A0E:
        move.l  -$12(a6),d0                     ; 04A0E
        cmpi.l  #$3840,d0                       ; 04A12
        ble.b   l_000_04A60                     ; 04A18
        move.l  #$7080,d1                       ; 04A1A
        sub.l   d0,d1                           ; 04A20
        moveq   #$0,d0                          ; 04A22
        move.w  -$1c(a6),d0                     ; 04A24
        asr.l   d0,d1                           ; 04A28
        move.l  d1,-$12(a6)                     ; 04A2A
        move.l  $1c(a6),d0                      ; 04A2E
        cmp.l   d0,d1                           ; 04A32
        ble.b   l_000_04A3A                     ; 04A34
        move.l  d0,-$12(a6)                     ; 04A36
l_000_04A3A:
        move.l  -$12(a6),d0                     ; 04A3A
        move.l  $c(a6),d1                       ; 04A3E
        sub.l   d0,d1                           ; 04A42
        move.l  d1,-$12(a6)                     ; 04A44
        tst.l   d1                              ; 04A48
        bpl.b   l_000_04A58                     ; 04A4A
        addi.l  #$7080,d1                       ; 04A4C
        move.l  d1,$c(a6)                       ; 04A52
        bra.b   l_000_04A84                     ; 04A56
l_000_04A58:
        move.l  -$12(a6),$c(a6)                 ; 04A58
        bra.b   l_000_04A84                     ; 04A5E
l_000_04A60:
        moveq   #$0,d0                          ; 04A60
        move.w  -$1c(a6),d0                     ; 04A62
        move.l  -$12(a6),d1                     ; 04A66
        asr.l   d0,d1                           ; 04A6A
        move.l  d1,-$12(a6)                     ; 04A6C
        move.l  $1c(a6),d0                      ; 04A70
        cmp.l   d0,d1                           ; 04A74
        ble.b   l_000_04A7C                     ; 04A76
        move.l  d0,-$12(a6)                     ; 04A78
l_000_04A7C:
        move.l  -$12(a6),d0                     ; 04A7C
        add.l   d0,$c(a6)                       ; 04A80
l_000_04A84:
        move.l  $8(a6),d0                       ; 04A84
        move.w  d0,(dat_071_00490).l            ; 04A88
        move.l  $c(a6),d0                       ; 04A8E
        move.w  d0,(dat_071_00492).l            ; 04A92
        movem.l (a7)+,d2                        ; 04A98
        unlk    a6                              ; 04A9C
        rts                                     ; 04A9E

;-------------------------------------------------------------------------------
; CockpitSounds - The cockpit's sounds for the frame: each request bit of SoundRequests
; (warnings and events, set by the rest of the game) starts its tone (sub_000_0A042, nine
; parameters each) and the requests are cleared; the engine's sound follows the throttle (+$2B,
; 0-120)...
;-------------------------------------------------------------------------------
CockpitSounds:
        link.w  a6,#$ffe2                       ; 04AA0
        movem.l d2,-(a7)                        ; 04AA4
        move.w  (ViewObjectIndex).l,d0          ; 04AA8
        moveq   #$9,d1                          ; 04AAE
        ext.l   d0                              ; 04AB0
        asl.l   d1,d0                           ; 04AB2
        movea.l d0,a0                           ; 04AB4
        adda.l  #ObjectTable,a0                 ; 04AB6
        move.l  a0,d0                           ; 04ABC
        move.l  d0,(CockpitObject).l            ; 04ABE
        move.b  (EngineSoundRequest).l,-$11(a6) ; 04AC4
        movea.l d0,a0                           ; 04ACC
        addq.l  #$2,a0                          ; 04ACE
        move.b  (CameraSequence).l,d0           ; 04AD0
        move.l  a0,-$10(a6)                     ; 04AD6
        tst.b   d0                              ; 04ADA
        bne.w   l_000_052BE                     ; 04ADC
        move.b  (MapView).l,d0                  ; 04AE0
        move.b  (WorldFrozen).l,d1              ; 04AE6
        or.b    d1,d0                           ; 04AEC
        tst.b   d0                              ; 04AEE
        bne.w   l_000_052BE                     ; 04AF0
        tst.b   (FlightScreen).l                ; 04AF4
        beq.w   l_000_052BE                     ; 04AFA
        move.b  (dat_071_00255).l,d0            ; 04AFE
        tst.b   d0                              ; 04B04
        bpl.b   l_000_04B44                     ; 04B06
        tst.b   (OutsideView).l                 ; 04B08
        beq.b   l_000_04B26                     ; 04B0E
        tst.b   (NewView).l                     ; 04B10
        beq.b   l_000_04B32                     ; 04B16
        moveq   #$5,d0                          ; 04B18
        move.l  d0,-(a7)                        ; 04B1A
        jsr     (PlayGearSound).l               ; 04B1C
        addq.l  #$4,a7                          ; 04B22
        bra.b   l_000_04B32                     ; 04B24
l_000_04B26:
        moveq   #$a,d0                          ; 04B26
        move.l  d0,-(a7)                        ; 04B28
        jsr     (PlayGearSound).l               ; 04B2A
        addq.l  #$4,a7                          ; 04B30
l_000_04B32:
        move.b  (dat_071_00255).l,d0            ; 04B32
        andi.b  #$7f,d0                         ; 04B38
        move.b  d0,(dat_071_00255).l            ; 04B3C
        bra.b   l_000_04B5A                     ; 04B42
l_000_04B44:
        move.b  (dat_071_00255).l,d0            ; 04B44
        subq.b  #$1,d0                          ; 04B4A
        bne.b   l_000_04B5A                     ; 04B4C
        jsr     (StopChannel2).l                ; 04B4E
        clr.b   (dat_071_00255).l               ; 04B54
l_000_04B5A:
        tst.l   (SoundRequests).l               ; 04B5A
        beq.w   l_000_04DD4                     ; 04B60
        move.b  (dat_071_0025A).l,d0            ; 04B64
        tst.b   d0                              ; 04B6A
        bgt.w   l_000_04DD4                     ; 04B6C
        btst    #$6,(CockpitSoundBits).l        ; 04B70
        beq.b   l_000_04BAE                     ; 04B78
        moveq   #$4,d0                          ; 04B7A
        move.l  d0,-(a7)                        ; 04B7C
        move.l  d0,-(a7)                        ; 04B7E
        moveq   #$3,d0                          ; 04B80
        move.l  d0,-(a7)                        ; 04B82
        moveq   #$5,d0                          ; 04B84
        move.l  d0,-(a7)                        ; 04B86
        moveq   #$10,d0                         ; 04B88
        move.l  d0,-(a7)                        ; 04B8A
        move.l  #$c8,-(a7)                      ; 04B8C
        moveq   #$8,d0                          ; 04B92
        move.l  d0,-(a7)                        ; 04B94
        moveq   #$10,d0                         ; 04B96
        move.l  d0,-(a7)                        ; 04B98
        move.l  #$a0,-(a7)                      ; 04B9A
        jsr     (PlayEffect).l                  ; 04BA0
        lea.l   $24(a7),a7                      ; 04BA6
        bra.w   l_000_04DCE                     ; 04BAA
l_000_04BAE:
        movea.l (CockpitObject).l,a0            ; 04BAE
        move.b  $7c(a0),d0                      ; 04BB4
        andi.b  #$f,d0                          ; 04BB8
        tst.b   d0                              ; 04BBC
        bne.w   l_000_04DCE                     ; 04BBE
        btst    #$7,(CockpitSoundBits).l        ; 04BC2
        beq.b   l_000_04C02                     ; 04BCA
        moveq   #$4,d0                          ; 04BCC
        move.l  d0,-(a7)                        ; 04BCE
        moveq   #$1,d0                          ; 04BD0
        move.l  d0,-(a7)                        ; 04BD2
        moveq   #$3,d0                          ; 04BD4
        move.l  d0,-(a7)                        ; 04BD6
        moveq   #$5,d0                          ; 04BD8
        move.l  d0,-(a7)                        ; 04BDA
        moveq   #$a,d0                          ; 04BDC
        move.l  d0,-(a7)                        ; 04BDE
        move.l  #$c8,-(a7)                      ; 04BE0
        moveq   #$8,d0                          ; 04BE6
        move.l  d0,-(a7)                        ; 04BE8
        moveq   #$a,d0                          ; 04BEA
        move.l  d0,-(a7)                        ; 04BEC
        move.l  #$144,-(a7)                     ; 04BEE
        jsr     (PlayEffect).l                  ; 04BF4
        lea.l   $24(a7),a7                      ; 04BFA
        bra.w   l_000_04DCE                     ; 04BFE
l_000_04C02:
        btst    #$0,(CockpitSoundBits).l        ; 04C02
        beq.b   l_000_04C46                     ; 04C0A
        moveq   #$4,d0                          ; 04C0C
        move.l  d0,-(a7)                        ; 04C0E
        moveq   #$3,d0                          ; 04C10
        move.l  d0,-(a7)                        ; 04C12
        move.l  d0,-(a7)                        ; 04C14
        moveq   #$5,d0                          ; 04C16
        move.l  d0,-(a7)                        ; 04C18
        moveq   #$10,d0                         ; 04C1A
        move.l  d0,-(a7)                        ; 04C1C
        move.l  #$b4,-(a7)                      ; 04C1E
        moveq   #$8,d0                          ; 04C24
        move.l  d0,-(a7)                        ; 04C26
        moveq   #$10,d0                         ; 04C28
        move.l  d0,-(a7)                        ; 04C2A
        moveq   #$7c,d0                         ; 04C2C
        move.l  d0,-(a7)                        ; 04C2E
        jsr     (PlayEffect).l                  ; 04C30
        lea.l   $24(a7),a7                      ; 04C36
        move.b  #$3,(dat_071_0025A).l           ; 04C3A
        bra.w   l_000_04DCE                     ; 04C42
l_000_04C46:
        btst    #$2,(CockpitSoundBits).l        ; 04C46
        beq.b   l_000_04C84                     ; 04C4E
        moveq   #$1,d0                          ; 04C50
        move.l  d0,-(a7)                        ; 04C52
        clr.l   -(a7)                           ; 04C54
        move.l  d0,-(a7)                        ; 04C56
        moveq   #$5,d0                          ; 04C58
        move.l  d0,-(a7)                        ; 04C5A
        moveq   #$3,d0                          ; 04C5C
        move.l  d0,-(a7)                        ; 04C5E
        move.l  #$e5,d0                         ; 04C60
        move.l  d0,-(a7)                        ; 04C66
        moveq   #$5,d0                          ; 04C68
        move.l  d0,-(a7)                        ; 04C6A
        moveq   #$3,d0                          ; 04C6C
        move.l  d0,-(a7)                        ; 04C6E
        move.l  #$e5,-(a7)                      ; 04C70
        jsr     (PlayEffect).l                  ; 04C76
        lea.l   $24(a7),a7                      ; 04C7C
        bra.w   l_000_04DCE                     ; 04C80
l_000_04C84:
        btst    #$0,(dat_071_00526).l           ; 04C84
        beq.b   l_000_04CC2                     ; 04C8C
        moveq   #$1,d0                          ; 04C8E
        move.l  d0,-(a7)                        ; 04C90
        moveq   #$0,d0                          ; 04C92
        move.l  d0,-(a7)                        ; 04C94
        moveq   #$1,d0                          ; 04C96
        move.l  d0,-(a7)                        ; 04C98
        moveq   #$3,d0                          ; 04C9A
        move.l  d0,-(a7)                        ; 04C9C
        clr.l   -(a7)                           ; 04C9E
        move.l  #$c8,-(a7)                      ; 04CA0
        moveq   #$9,d0                          ; 04CA6
        move.l  d0,-(a7)                        ; 04CA8
        moveq   #$4,d0                          ; 04CAA
        move.l  d0,-(a7)                        ; 04CAC
        move.l  #$c0,-(a7)                      ; 04CAE
        jsr     (PlayEffect).l                  ; 04CB4
        lea.l   $24(a7),a7                      ; 04CBA
        bra.w   l_000_04DCE                     ; 04CBE
l_000_04CC2:
        btst    #$4,(CockpitSoundBits).l        ; 04CC2
        beq.b   l_000_04D04                     ; 04CCA
        moveq   #$5,d0                          ; 04CCC
        move.l  d0,-(a7)                        ; 04CCE
        moveq   #$1,d0                          ; 04CD0
        move.l  d0,-(a7)                        ; 04CD2
        moveq   #$3,d0                          ; 04CD4
        move.l  d0,-(a7)                        ; 04CD6
        moveq   #$5,d0                          ; 04CD8
        move.l  d0,-(a7)                        ; 04CDA
        moveq   #$f,d0                          ; 04CDC
        move.l  d0,-(a7)                        ; 04CDE
        move.l  #$1f4,d0                        ; 04CE0
        move.l  d0,-(a7)                        ; 04CE6
        moveq   #$5,d0                          ; 04CE8
        move.l  d0,-(a7)                        ; 04CEA
        moveq   #$f,d0                          ; 04CEC
        move.l  d0,-(a7)                        ; 04CEE
        move.l  #$1f4,-(a7)                     ; 04CF0
        jsr     (PlayEffect).l                  ; 04CF6
        lea.l   $24(a7),a7                      ; 04CFC
        bra.w   l_000_04DCE                     ; 04D00
l_000_04D04:
        btst    #$1,(CockpitSoundBits).l        ; 04D04
        beq.b   l_000_04D40                     ; 04D0C
        moveq   #$5,d0                          ; 04D0E
        move.l  d0,-(a7)                        ; 04D10
        moveq   #$3,d0                          ; 04D12
        move.l  d0,-(a7)                        ; 04D14
        move.l  d0,-(a7)                        ; 04D16
        moveq   #$1,d0                          ; 04D18
        move.l  d0,-(a7)                        ; 04D1A
        clr.l   -(a7)                           ; 04D1C
        move.l  #$82,-(a7)                      ; 04D1E
        moveq   #$5,d0                          ; 04D24
        move.l  d0,-(a7)                        ; 04D26
        moveq   #$a,d0                          ; 04D28
        move.l  d0,-(a7)                        ; 04D2A
        move.l  #$1f4,-(a7)                     ; 04D2C
        jsr     (PlayEffect).l                  ; 04D32
        lea.l   $24(a7),a7                      ; 04D38
        bra.w   l_000_04DCE                     ; 04D3C
l_000_04D40:
        btst    #$5,(CockpitSoundBits).l        ; 04D40
        beq.b   l_000_04D7C                     ; 04D48
        moveq   #$5,d0                          ; 04D4A
        move.l  d0,-(a7)                        ; 04D4C
        moveq   #$2,d0                          ; 04D4E
        move.l  d0,-(a7)                        ; 04D50
        moveq   #$3,d0                          ; 04D52
        move.l  d0,-(a7)                        ; 04D54
        moveq   #$1,d0                          ; 04D56
        move.l  d0,-(a7)                        ; 04D58
        clr.l   -(a7)                           ; 04D5A
        move.l  #$14a,-(a7)                     ; 04D5C
        moveq   #$5,d0                          ; 04D62
        move.l  d0,-(a7)                        ; 04D64
        moveq   #$8,d0                          ; 04D66
        move.l  d0,-(a7)                        ; 04D68
        move.l  #$190,-(a7)                     ; 04D6A
        jsr     (PlayEffect).l                  ; 04D70
        lea.l   $24(a7),a7                      ; 04D76
        bra.b   l_000_04DCE                     ; 04D7A
l_000_04D7C:
        btst    #$3,(dat_071_00526).l           ; 04D7C
        beq.b   l_000_04DB8                     ; 04D84
        moveq   #$5,d0                          ; 04D86
        move.l  d0,-(a7)                        ; 04D88
        moveq   #$1,d0                          ; 04D8A
        move.l  d0,-(a7)                        ; 04D8C
        moveq   #$3,d0                          ; 04D8E
        move.l  d0,-(a7)                        ; 04D90
        moveq   #$1,d0                          ; 04D92
        move.l  d0,-(a7)                        ; 04D94
        clr.l   -(a7)                           ; 04D96
        move.l  #$82,-(a7)                      ; 04D98
        moveq   #$5,d0                          ; 04D9E
        move.l  d0,-(a7)                        ; 04DA0
        moveq   #$a,d0                          ; 04DA2
        move.l  d0,-(a7)                        ; 04DA4
        move.l  #$1f4,-(a7)                     ; 04DA6
        jsr     (PlayEffect).l                  ; 04DAC
        lea.l   $24(a7),a7                      ; 04DB2
        bra.b   l_000_04DCE                     ; 04DB6
l_000_04DB8:
        btst    #$3,(CockpitSoundBits).l        ; 04DB8
        beq.b   l_000_04DCE                     ; 04DC0
        moveq   #$3,d0                          ; 04DC2
        move.l  d0,-(a7)                        ; 04DC4
        jsr     (StopSound).l                   ; 04DC6
        addq.l  #$4,a7                          ; 04DCC
l_000_04DCE:
        clr.l   (SoundRequests).l               ; 04DCE
l_000_04DD4:
        tst.b   (dat_071_00188).l               ; 04DD4
        beq.b   l_000_04E40                     ; 04DDA
        move.b  (dat_071_00188).l,d0            ; 04DDC
        subq.b  #$1,d0                          ; 04DE2
        move.b  d0,(dat_071_00188).l            ; 04DE4
        tst.b   d0                              ; 04DEA
        bgt.b   l_000_04E40                     ; 04DEC
        tst.b   (OutsideView).l                 ; 04DEE
        beq.b   l_000_04E18                     ; 04DF4
        move.b  (dat_071_0023A).l,d0            ; 04DF6
        ext.w   d0                              ; 04DFC
        ext.l   d0                              ; 04DFE
        move.b  (dat_071_00239).l,d1            ; 04E00
        ext.w   d1                              ; 04E06
        ext.l   d1                              ; 04E08
        move.l  d1,-(a7)                        ; 04E0A
        move.l  d0,-(a7)                        ; 04E0C
        jsr     (PlaySweep).l                   ; 04E0E
        addq.l  #$8,a7                          ; 04E14
        bra.b   l_000_04E3A                     ; 04E16
l_000_04E18:
        move.b  (dat_071_0023A).l,d0            ; 04E18
        ext.w   d0                              ; 04E1E
        ext.l   d0                              ; 04E20
        asr.l   #$1,d0                          ; 04E22
        move.b  (dat_071_00239).l,d1            ; 04E24
        ext.w   d1                              ; 04E2A
        ext.l   d1                              ; 04E2C
        move.l  d1,-(a7)                        ; 04E2E
        move.l  d0,-(a7)                        ; 04E30
        jsr     (PlaySweep).l                   ; 04E32
        addq.l  #$8,a7                          ; 04E38
l_000_04E3A:
        clr.b   (dat_071_00188).l               ; 04E3A
l_000_04E40:
        tst.b   -$11(a6)                        ; 04E40
        bne.b   l_000_04E56                     ; 04E44
        move.b  (dat_071_00191).l,d0            ; 04E46
        andi.b  #$3,d0                          ; 04E4C
        tst.b   d0                              ; 04E50
        bne.w   l_000_0528A                     ; 04E52
l_000_04E56:
        movea.l (CockpitObject).l,a0            ; 04E56
        move.b  $62(a0),d0                      ; 04E5C
        andi.b  #$f0,d0                         ; 04E60
        cmpi.b  #$30,d0                         ; 04E64
        beq.w   l_000_05274                     ; 04E68
        move.b  $2b(a0),d0                      ; 04E6C
        ext.w   d0                              ; 04E70
        move.w  d0,-$2(a6)                      ; 04E72
        tst.w   d0                              ; 04E76
        bpl.b   l_000_04E7E                     ; 04E78
        neg.w   -$2(a6)                         ; 04E7A
l_000_04E7E:
        move.w  #$3d,-$6(a6)                    ; 04E7E
        move.w  -$2(a6),d0                      ; 04E84
        ext.l   d0                              ; 04E88
        move.l  d0,-(a7)                        ; 04E8A
        bsr.w   sub_000_0530E                   ; 04E8C
        addq.l  #$4,a7                          ; 04E90
        move.w  d0,-$4(a6)                      ; 04E92
        tst.w   d0                              ; 04E96
        beq.w   l_000_05262                     ; 04E98
        movea.l (CockpitObject).l,a0            ; 04E9C
        move.w  $5a(a0),d0                      ; 04EA2
        asr.w   #$4,d0                          ; 04EA6
        move.w  d0,-$c(a6)                      ; 04EA8
        tst.w   d0                              ; 04EAC
        bpl.b   l_000_04EB4                     ; 04EAE
        neg.w   -$c(a6)                         ; 04EB0
l_000_04EB4:
        movea.l (CockpitObject).l,a0            ; 04EB4
        move.w  $56(a0),d0                      ; 04EBA
        asr.w   #$4,d0                          ; 04EBE
        move.w  d0,-$a(a6)                      ; 04EC0
        tst.w   d0                              ; 04EC4
        bpl.b   l_000_04ECC                     ; 04EC6
        neg.w   -$a(a6)                         ; 04EC8
l_000_04ECC:
        move.w  -$c(a6),d0                      ; 04ECC
        cmp.w   -$a(a6),d0                      ; 04ED0
        bge.b   l_000_04EE6                     ; 04ED4
        movea.l (CockpitObject).l,a0            ; 04ED6
        move.w  $56(a0),d1                      ; 04EDC
        asr.w   #$4,d1                          ; 04EE0
        add.w   d1,-$c(a6)                      ; 04EE2
l_000_04EE6:
        move.w  -$2(a6),d0                      ; 04EE6
        cmpi.w  #$78,d0                         ; 04EEA
        blt.b   l_000_04EFA                     ; 04EEE
        move.w  -$c(a6),d0                      ; 04EF0
        sub.w   d0,-$2(a6)                      ; 04EF4
        bra.b   l_000_04F14                     ; 04EF8
l_000_04EFA:
        move.w  -$2(a6),d0                      ; 04EFA
        move.w  -$c(a6),d1                      ; 04EFE
        add.w   d0,d1                           ; 04F02
        move.w  d1,-$2(a6)                      ; 04F04
        cmpi.w  #$78,d1                         ; 04F08
        ble.b   l_000_04F14                     ; 04F0C
        move.w  #$78,-$2(a6)                    ; 04F0E
l_000_04F14:
        tst.b   (OutsideView).l                 ; 04F14
        beq.w   l_000_05088                     ; 04F1A
        move.b  (CameraSequence).l,d0           ; 04F1E
        tst.b   d0                              ; 04F24
        bne.w   l_000_05088                     ; 04F26
        move.w  -$4(a6),d0                      ; 04F2A
        asr.w   #$2,d0                          ; 04F2E
        sub.w   d0,-$4(a6)                      ; 04F30
        move.b  (NewView).l,d0                  ; 04F34
        tst.b   d0                              ; 04F3A
        bne.b   l_000_04F70                     ; 04F3C
        tst.w   (dat_071_00512).l               ; 04F3E
        beq.b   l_000_04F70                     ; 04F44
        move.w  -$6(a6),d0                      ; 04F46
        ext.l   d0                              ; 04F4A
        asl.l   #$5,d0                          ; 04F4C
        move.w  (dat_071_00512).l,d1            ; 04F4E
        ext.l   d1                              ; 04F54
        move.l  d0,-$16(a6)                     ; 04F56
        jsr     (CXD33).l                       ; 04F5A
        move.w  d0,-$6(a6)                      ; 04F60
        cmpi.w  #$3f,d0                         ; 04F64
        ble.b   l_000_04F70                     ; 04F68
        move.w  #$3f,-$6(a6)                    ; 04F6A
l_000_04F70:
        move.w  -$2(a6),d0                      ; 04F70
        asl.w   #$1,d0                          ; 04F74
        move.w  #$320,d1                        ; 04F76
        sub.w   d0,d1                           ; 04F7A
        move.w  -$2(a6),d0                      ; 04F7C
        asr.w   #$1,d0                          ; 04F80
        sub.w   d0,d1                           ; 04F82
        move.w  -$2(a6),d0                      ; 04F84
        asr.w   #$2,d0                          ; 04F88
        sub.w   d0,d1                           ; 04F8A
        move.w  d1,-$a(a6)                      ; 04F8C
        cmpi.b  #$fe,-$11(a6)                   ; 04F90
        bne.b   l_000_04FB0                     ; 04F96
        ext.l   d1                              ; 04F98
        move.w  -$4(a6),d0                      ; 04F9A
        ext.l   d0                              ; 04F9E
        move.l  d0,-(a7)                        ; 04FA0
        move.l  d1,-(a7)                        ; 04FA2
        jsr     (PlayEngineSound).l             ; 04FA4
        addq.l  #$8,a7                          ; 04FAA
        bra.w   l_000_05284                     ; 04FAC
l_000_04FB0:
        cmpi.b  #$fd,-$11(a6)                   ; 04FB0
        bne.b   l_000_04FDA                     ; 04FB6
        move.w  -$a(a6),d0                      ; 04FB8
        ext.l   d0                              ; 04FBC
        addi.l  #$20,d0                         ; 04FBE
        move.w  -$6(a6),d1                      ; 04FC4
        ext.l   d1                              ; 04FC8
        move.l  d1,-(a7)                        ; 04FCA
        move.l  d0,-(a7)                        ; 04FCC
        jsr     (PlayEngineSound).l             ; 04FCE
        addq.l  #$8,a7                          ; 04FD4
        bra.w   l_000_05284                     ; 04FD6
l_000_04FDA:
        cmpi.b  #$fc,-$11(a6)                   ; 04FDA
        bne.b   l_000_05004                     ; 04FE0
        move.w  -$a(a6),d0                      ; 04FE2
        ext.l   d0                              ; 04FE6
        addi.l  #$20,d0                         ; 04FE8
        move.w  -$4(a6),d1                      ; 04FEE
        ext.l   d1                              ; 04FF2
        move.l  d1,-(a7)                        ; 04FF4
        move.l  d0,-(a7)                        ; 04FF6
        jsr     (PlayEngineSound).l             ; 04FF8
        addq.l  #$8,a7                          ; 04FFE
        bra.w   l_000_05284                     ; 05000
l_000_05004:
        cmpi.b  #$fb,-$11(a6)                   ; 05004
        bne.b   l_000_05026                     ; 0500A
        move.w  -$a(a6),d0                      ; 0500C
        ext.l   d0                              ; 05010
        move.w  -$6(a6),d1                      ; 05012
        ext.l   d1                              ; 05016
        move.l  d1,-(a7)                        ; 05018
        move.l  d0,-(a7)                        ; 0501A
        bsr.w   sub_000_052C6                   ; 0501C
        addq.l  #$8,a7                          ; 05020
        bra.w   l_000_05284                     ; 05022
l_000_05026:
        cmpi.b  #$fa,-$11(a6)                   ; 05026
        bne.b   l_000_05066                     ; 0502C
        move.w  -$6(a6),d0                      ; 0502E
        asl.w   #$1,d0                          ; 05032
        move.w  d0,-$8(a6)                      ; 05034
        cmpi.w  #$3f,d0                         ; 05038
        ble.b   l_000_05044                     ; 0503C
        move.w  #$3f,-$8(a6)                    ; 0503E
l_000_05044:
        move.w  -$a(a6),d0                      ; 05044
        ext.l   d0                              ; 05048
        addi.l  #$16,d0                         ; 0504A
        move.w  -$8(a6),d1                      ; 05050
        ext.l   d1                              ; 05054
        move.l  d1,-(a7)                        ; 05056
        move.l  d0,-(a7)                        ; 05058
        jsr     (PlayEngineSound).l             ; 0505A
        addq.l  #$8,a7                          ; 05060
        bra.w   l_000_05284                     ; 05062
l_000_05066:
        move.w  -$a(a6),d0                      ; 05066
        ext.l   d0                              ; 0506A
        move.w  -$4(a6),d1                      ; 0506C
        ext.l   d1                              ; 05070
        moveq   #$20,d2                         ; 05072
        move.l  d2,-(a7)                        ; 05074
        move.l  d1,-(a7)                        ; 05076
        move.l  d0,-(a7)                        ; 05078
        jsr     (sub_000_09EFA).l               ; 0507A
        lea.l   $c(a7),a7                       ; 05080
        bra.w   l_000_05284                     ; 05084
l_000_05088:
        cmpi.w  #$28,-$4(a6)                    ; 05088
        bge.b   l_000_05096                     ; 0508E
        move.w  #$28,-$4(a6)                    ; 05090
l_000_05096:
        move.w  -$2(a6),d0                      ; 05096
        asl.w   #$1,d0                          ; 0509A
        move.w  #$310,d1                        ; 0509C
        sub.w   d0,d1                           ; 050A0
        move.w  -$2(a6),d0                      ; 050A2
        asr.w   #$2,d0                          ; 050A6
        sub.w   d0,d1                           ; 050A8
        move.w  d1,-$a(a6)                      ; 050AA
        cmpi.b  #$fe,-$11(a6)                   ; 050AE
        bne.b   l_000_050F8                     ; 050B4
        movea.l -$10(a6),a0                     ; 050B6
        move.w  (a0),d0                         ; 050BA
        btst    #$3,d0                          ; 050BC
        bne.b   l_000_050DA                     ; 050C0
        ext.l   d1                              ; 050C2
        move.w  -$4(a6),d0                      ; 050C4
        ext.l   d0                              ; 050C8
        move.l  d0,-(a7)                        ; 050CA
        move.l  d1,-(a7)                        ; 050CC
        jsr     (PlayCatapultSound).l           ; 050CE
        addq.l  #$8,a7                          ; 050D4
        bra.w   l_000_05284                     ; 050D6
l_000_050DA:
        move.w  -$a(a6),d0                      ; 050DA
        ext.l   d0                              ; 050DE
        move.w  -$4(a6),d1                      ; 050E0
        ext.l   d1                              ; 050E4
        asr.l   #$2,d1                          ; 050E6
        move.l  d1,-(a7)                        ; 050E8
        move.l  d0,-(a7)                        ; 050EA
        jsr     (PlayEngineSound).l             ; 050EC
        addq.l  #$8,a7                          ; 050F2
        bra.w   l_000_05284                     ; 050F4
l_000_050F8:
        cmpi.b  #$fd,-$11(a6)                   ; 050F8
        bne.b   l_000_05124                     ; 050FE
        move.w  -$a(a6),d0                      ; 05100
        ext.l   d0                              ; 05104
        addi.l  #$23,d0                         ; 05106
        move.w  -$6(a6),d1                      ; 0510C
        ext.l   d1                              ; 05110
        asr.l   #$1,d1                          ; 05112
        move.l  d1,-(a7)                        ; 05114
        move.l  d0,-(a7)                        ; 05116
        jsr     (PlayEngineSound).l             ; 05118
        addq.l  #$8,a7                          ; 0511E
        bra.w   l_000_05284                     ; 05120
l_000_05124:
        cmpi.b  #$fc,-$11(a6)                   ; 05124
        bne.b   l_000_0514E                     ; 0512A
        move.w  -$a(a6),d0                      ; 0512C
        ext.l   d0                              ; 05130
        addi.l  #$20,d0                         ; 05132
        move.w  -$4(a6),d1                      ; 05138
        ext.l   d1                              ; 0513C
        move.l  d1,-(a7)                        ; 0513E
        move.l  d0,-(a7)                        ; 05140
        jsr     (PlayCatapultSound).l           ; 05142
        addq.l  #$8,a7                          ; 05148
        bra.w   l_000_05284                     ; 0514A
l_000_0514E:
        cmpi.b  #$fb,-$11(a6)                   ; 0514E
        bne.b   l_000_05170                     ; 05154
        move.w  -$a(a6),d0                      ; 05156
        ext.l   d0                              ; 0515A
        move.w  -$6(a6),d1                      ; 0515C
        ext.l   d1                              ; 05160
        move.l  d1,-(a7)                        ; 05162
        move.l  d0,-(a7)                        ; 05164
        bsr.w   sub_000_052C6                   ; 05166
        addq.l  #$8,a7                          ; 0516A
        bra.w   l_000_05284                     ; 0516C
l_000_05170:
        cmpi.b  #$fa,-$11(a6)                   ; 05170
        bne.b   l_000_051B0                     ; 05176
        move.w  -$6(a6),d0                      ; 05178
        asl.w   #$1,d0                          ; 0517C
        move.w  d0,-$8(a6)                      ; 0517E
        cmpi.w  #$28,d0                         ; 05182
        ble.b   l_000_0518E                     ; 05186
        move.w  #$28,-$8(a6)                    ; 05188
l_000_0518E:
        move.w  -$a(a6),d0                      ; 0518E
        ext.l   d0                              ; 05192
        addi.l  #$16,d0                         ; 05194
        move.w  -$8(a6),d1                      ; 0519A
        ext.l   d1                              ; 0519E
        move.l  d1,-(a7)                        ; 051A0
        move.l  d0,-(a7)                        ; 051A2
        jsr     (PlayEngineSound).l             ; 051A4
        addq.l  #$8,a7                          ; 051AA
        bra.w   l_000_05284                     ; 051AC
l_000_051B0:
        tst.b   (dat_071_00167).l               ; 051B0
        beq.b   l_000_051FE                     ; 051B6
        btst    #$0,(SoundsLoaded).l            ; 051B8
        beq.b   l_000_051E0                     ; 051C0
        move.w  -$a(a6),d0                      ; 051C2
        ext.l   d0                              ; 051C6
        moveq   #$20,d1                         ; 051C8
        move.l  d1,-(a7)                        ; 051CA
        moveq   #$a,d1                          ; 051CC
        move.l  d1,-(a7)                        ; 051CE
        move.l  d0,-(a7)                        ; 051D0
        jsr     (sub_000_09EBE).l               ; 051D2
        lea.l   $c(a7),a7                       ; 051D8
        bra.w   l_000_05284                     ; 051DC
l_000_051E0:
        move.w  -$a(a6),d0                      ; 051E0
        ext.l   d0                              ; 051E4
        moveq   #$20,d1                         ; 051E6
        move.l  d1,-(a7)                        ; 051E8
        moveq   #$28,d1                         ; 051EA
        move.l  d1,-(a7)                        ; 051EC
        move.l  d0,-(a7)                        ; 051EE
        jsr     (sub_000_09EBE).l               ; 051F0
        lea.l   $c(a7),a7                       ; 051F6
        bra.w   l_000_05284                     ; 051FA
l_000_051FE:
        movea.l -$10(a6),a0                     ; 051FE
        move.w  (a0),d0                         ; 05202
        btst    #$3,d0                          ; 05204
        beq.b   l_000_05214                     ; 05208
        btst    #$0,(SoundsLoaded).l            ; 0520A
        bne.b   l_000_05234                     ; 05212
l_000_05214:
        move.w  -$a(a6),d0                      ; 05214
        ext.l   d0                              ; 05218
        move.w  -$4(a6),d1                      ; 0521A
        ext.l   d1                              ; 0521E
        moveq   #$20,d2                         ; 05220
        move.l  d2,-(a7)                        ; 05222
        move.l  d1,-(a7)                        ; 05224
        move.l  d0,-(a7)                        ; 05226
        jsr     (sub_000_09EBE).l               ; 05228
        lea.l   $c(a7),a7                       ; 0522E
        bra.b   l_000_05284                     ; 05232
l_000_05234:
        move.w  -$a(a6),d0                      ; 05234
        ext.l   d0                              ; 05238
        move.w  -$4(a6),d1                      ; 0523A
        ext.l   d1                              ; 0523E
        move.l  d1,$8(a7)                       ; 05240
        asr.l   #$2,d1                          ; 05244
        move.l  $8(a7),d2                       ; 05246
        asr.l   #$3,d2                          ; 0524A
        add.l   d2,d1                           ; 0524C
        moveq   #$20,d2                         ; 0524E
        move.l  d2,-(a7)                        ; 05250
        move.l  d1,-(a7)                        ; 05252
        move.l  d0,-(a7)                        ; 05254
        jsr     (sub_000_09EBE).l               ; 05256
        lea.l   $c(a7),a7                       ; 0525C
        bra.b   l_000_05284                     ; 05260
l_000_05262:
        bsr.w   sub_000_05502                   ; 05262
        ext.l   d0                              ; 05266
        move.l  d0,-(a7)                        ; 05268
        jsr     (PlayWindSound).l               ; 0526A
        addq.l  #$4,a7                          ; 05270
        bra.b   l_000_05284                     ; 05272
l_000_05274:
        bsr.w   sub_000_05502                   ; 05274
        ext.l   d0                              ; 05278
        move.l  d0,-(a7)                        ; 0527A
        jsr     (PlayWindSound).l               ; 0527C
        addq.l  #$4,a7                          ; 05282
l_000_05284:
        clr.b   (EngineSoundRequest).l          ; 05284
l_000_0528A:
        move.b  (dat_071_00167).l,d0            ; 0528A
        tst.b   d0                              ; 05290
        ble.b   l_000_052BE                     ; 05292
        subq.b  #$1,d0                          ; 05294
        move.b  d0,(dat_071_00167).l            ; 05296
        tst.b   d0                              ; 0529C
        bne.b   l_000_052BE                     ; 0529E
        move.b  (OutsideView).l,d0              ; 052A0
        tst.b   d0                              ; 052A6
        bne.b   l_000_052BE                     ; 052A8
        movea.l -$10(a6),a0                     ; 052AA
        move.w  (a0),d0                         ; 052AE
        btst    #$3,d0                          ; 052B0
        bne.b   l_000_052BE                     ; 052B4
        move.b  #$fe,(EngineSoundRequest).l     ; 052B6
l_000_052BE:
        movem.l (a7)+,d2                        ; 052BE
        unlk    a6                              ; 052C2
        rts                                     ; 052C4
sub_000_052C6:
        link.w  a6,#$0                          ; 052C6
        btst    #$1,(SoundFlags).l              ; 052CA
        beq.b   l_000_052EC                     ; 052D2
        move.w  $e(a6),d0                       ; 052D4
        ext.l   d0                              ; 052D8
        move.l  d0,-(a7)                        ; 052DA
        jsr     (PlayEffect2).l                 ; 052DC
        addq.l  #$4,a7                          ; 052E2
        clr.b   (dat_071_00167).l               ; 052E4
        bra.b   l_000_0530A                     ; 052EA
l_000_052EC:
        move.w  $a(a6),d0                       ; 052EC
        ext.l   d0                              ; 052F0
        addi.l  #$16,d0                         ; 052F2
        move.w  $e(a6),d1                       ; 052F8
        ext.l   d1                              ; 052FC
        move.l  d1,-(a7)                        ; 052FE
        move.l  d0,-(a7)                        ; 05300
        jsr     (PlayEngineSound).l             ; 05302
        addq.l  #$8,a7                          ; 05308
l_000_0530A:
        unlk    a6                              ; 0530A
        rts                                     ; 0530C
sub_000_0530E:
        link.w  a6,#$fffa                       ; 0530E
        tst.w   $a(a6)                          ; 05312
        beq.w   l_000_054C0                     ; 05316
        tst.b   (dat_071_00167).l               ; 0531A
        beq.b   l_000_0532A                     ; 05320
        move.w  #$3f,$a(a6)                     ; 05322
        bra.b   l_000_05354                     ; 05328
l_000_0532A:
        move.w  $a(a6),d0                       ; 0532A
        cmpi.w  #$8,d0                          ; 0532E
        ble.b   l_000_05344                     ; 05332
        moveq   #$78,d1                         ; 05334
        sub.w   d0,d1                           ; 05336
        asr.w   #$2,d1                          ; 05338
        moveq   #$3f,d0                         ; 0533A
        sub.w   d1,d0                           ; 0533C
        move.w  d0,$a(a6)                       ; 0533E
        bra.b   l_000_05354                     ; 05342
l_000_05344:
        moveq   #$78,d0                         ; 05344
        sub.w   $a(a6),d0                       ; 05346
        asr.w   #$1,d0                          ; 0534A
        moveq   #$3c,d1                         ; 0534C
        sub.w   d0,d1                           ; 0534E
        move.w  d1,$a(a6)                       ; 05350
l_000_05354:
        tst.b   (OutsideView).l                 ; 05354
        beq.w   l_000_054A8                     ; 0535A
        tst.w   $a(a6)                          ; 0535E
        beq.w   l_000_054DC                     ; 05362
        tst.b   (NewView).l                     ; 05366
        beq.w   l_000_0544E                     ; 0536C
        move.b  (ViewChoice).l,d0               ; 05370
        ext.w   d0                              ; 05376
        move.w  d0,-$2(a6)                      ; 05378
        cmpi.w  #$4,d0                          ; 0537C
        ble.b   l_000_05392                     ; 05380
        moveq   #$8,d1                          ; 05382
        sub.w   d0,d1                           ; 05384
        move.w  d1,-$2(a6)                      ; 05386
        tst.w   d1                              ; 0538A
        bpl.b   l_000_05392                     ; 0538C
        clr.w   -$2(a6)                         ; 0538E
l_000_05392:
        move.w  -$2(a6),d0                      ; 05392
        ext.l   d0                              ; 05396
        cmpi.l  #$4,d0                          ; 05398
        bcc.b   l_000_053EC                     ; 0539E
        asl.l   #$1,d0                          ; 053A0
        jmp     dat_000_053A6(pc,d0.l)          ; 053A2
dat_000_053A6:
	dc.b	$60,$06,$60,$18
	dc.b	'`*`40.'
	dc.b	$00,$0A,$48,$C0,$2F,$00,$61,$00,$01,$2E,$58,$8F,$3D,$40,$00,$0A
	dc.b	$60,$2A,$30,$2E,$00,$0A,$48,$C0,$2F,$00,$61,$00,$01,$1A,$58,$8F
	dc.b	$3D,$40,$00,$0A,$60,$16,$30,$2E,$00,$0A,$E4,$40,$91,$6E,$00,$0A
	dc.b	$60,$0A,$30,$2E,$00,$0A,$E6,$40,$91,$6E,$00,$0A
l_000_053EC:
        move.b  (OutsideView).l,d0              ; 053EC
        ext.w   d0                              ; 053F2
        ext.l   d0                              ; 053F4
        subi.l  #$1,d0                          ; 053F6
        blt.w   l_000_05480                     ; 053FC
        cmpi.l  #$4,d0                          ; 05400
        bge.b   l_000_05480                     ; 05406
        asl.l   #$1,d0                          ; 05408
        jmp     dat_000_0540E(pc,d0.l)          ; 0540A
dat_000_0540E:
	dc.b	$60,$06,$60,$10,$60,$1A,$60,$2C,$30,$2E,$00,$0A,$E6,$40,$91,$6E
	dc.b	$00,$0A,$60,$5E,$30,$2E,$00,$0A,$E4,$40,$91,$6E,$00,$0A,$60,$52
	dc.b	$30,$2E,$00,$0A,$48,$C0,$2F,$00,$61,$00,$00,$AE,$58,$8F,$3D,$40
	dc.b	$00,$0A,$60,$3E,$30,$2E,$00,$0A,$E2,$40,$3D,$40,$00,$0A,$60,$32
l_000_0544E:
        tst.w   (dat_071_00512).l               ; 0544E
        beq.b   l_000_05480                     ; 05454
        move.w  $a(a6),d0                       ; 05456
        ext.l   d0                              ; 0545A
        asl.l   #$5,d0                          ; 0545C
        move.w  (dat_071_00512).l,d1            ; 0545E
        ext.l   d1                              ; 05464
        move.l  d0,-$6(a6)                      ; 05466
        jsr     (CXD33).l                       ; 0546A
        move.w  d0,$a(a6)                       ; 05470
        cmpi.w  #$54,d0                         ; 05474
        ble.b   l_000_05480                     ; 05478
        move.w  #$54,$a(a6)                     ; 0547A
l_000_05480:
        movea.l (CockpitObject).l,a0            ; 05480
        move.w  $2(a0),d0                       ; 05486
        btst    #$3,d0                          ; 0548A
        bne.b   l_000_0549A                     ; 0548E
        move.w  $a(a6),d0                       ; 05490
        asr.w   #$2,d0                          ; 05494
        sub.w   d0,$a(a6)                       ; 05496
l_000_0549A:
        tst.w   $a(a6)                          ; 0549A
        bgt.b   l_000_054DC                     ; 0549E
        move.w  #$1,$a(a6)                      ; 054A0
        bra.b   l_000_054DC                     ; 054A6
l_000_054A8:
        move.b  (dat_071_00259).l,d0            ; 054A8
        cmpi.b  #$5,d0                          ; 054AE
        ble.b   l_000_054DC                     ; 054B2
        move.w  $a(a6),d0                       ; 054B4
        asr.w   #$1,d0                          ; 054B8
        move.w  d0,$a(a6)                       ; 054BA
        bra.b   l_000_054DC                     ; 054BE
l_000_054C0:
        movea.l (CockpitObject).l,a0            ; 054C0
        move.w  $2(a0),d0                       ; 054C6
        btst    #$7,d0                          ; 054CA
        beq.b   l_000_054DC                     ; 054CE
        tst.w   $6e(a0)                         ; 054D0
        beq.b   l_000_054DC                     ; 054D4
        move.w  #$c,$a(a6)                      ; 054D6
l_000_054DC:
        move.w  $a(a6),d0                       ; 054DC
        ext.l   d0                              ; 054E0
        unlk    a6                              ; 054E2
        rts                                     ; 054E4

;-------------------------------------------------------------------------------
; FiveEighths - Returns the word argument x 5/8 (x/2 + x/8).
;-------------------------------------------------------------------------------
FiveEighths:
        link.w  a6,#$0                          ; 054E6
        move.w  $a(a6),d0                       ; 054EA
        asr.w   #$1,d0                          ; 054EE
        move.w  $a(a6),d1                       ; 054F0
        asr.w   #$3,d1                          ; 054F4
        add.w   d1,d0                           ; 054F6
        move.w  d0,$a(a6)                       ; 054F8
        ext.l   d0                              ; 054FC
        unlk    a6                              ; 054FE
        rts                                     ; 05500
sub_000_05502:
        link.w  a6,#$fffe                       ; 05502
        movea.l (CockpitObject).l,a0            ; 05506
        move.b  $62(a0),d0                      ; 0550C
        andi.b  #$f0,d0                         ; 05510
        cmpi.b  #$30,d0                         ; 05514
        bne.b   l_000_05522                     ; 05518
        move.w  #$10,-$2(a6)                    ; 0551A
        bra.b   l_000_05570                     ; 05520
l_000_05522:
        movea.l (CockpitObject).l,a0            ; 05522
        move.w  $6e(a0),d0                      ; 05528
        move.w  d0,-$2(a6)                      ; 0552C
        tst.w   d0                              ; 05530
        bpl.b   l_000_05538                     ; 05532
        neg.w   -$2(a6)                         ; 05534
l_000_05538:
        moveq   #$9,d0                          ; 05538
        move.w  -$2(a6),d1                      ; 0553A
        asr.w   d0,d1                           ; 0553E
        move.w  d1,-$2(a6)                      ; 05540
        cmpi.w  #$3f,d1                         ; 05544
        ble.b   l_000_05550                     ; 05548
        move.w  #$3f,-$2(a6)                    ; 0554A
l_000_05550:
        move.b  (OutsideView).l,d0              ; 05550
        tst.b   d0                              ; 05556
        bne.b   l_000_05564                     ; 05558
        move.w  -$2(a6),d0                      ; 0555A
        asr.w   #$1,d0                          ; 0555E
        move.w  d0,-$2(a6)                      ; 05560
l_000_05564:
        tst.w   -$2(a6)                         ; 05564
        bne.b   l_000_05570                     ; 05568
        move.w  #$1,-$2(a6)                     ; 0556A
l_000_05570:
        move.w  -$2(a6),d0                      ; 05570
        ext.l   d0                              ; 05574
        unlk    a6                              ; 05576
        rts                                     ; 05578
	dc.b	$00,$00

;-------------------------------------------------------------------------------
; FlightControls - The flight controls of an aircraft (CurrentObject): its stick deflection
; (+$28 pitch, +$29 and +$2A the other two axes, signed bytes; the last two zero on the ground,
; +$04 bit 3) is looked up in a response table (ControlResponse, or ControlResponse2 with flag
; $100) to give its rotation rates (+$56, +$58, +$5A; sub_000_05CF0...), the pitch limited at
; low speed (+$6C <= $300). For the player it also checks the fuel (PlayerFuel): the warning
; bits of WarningFlags below 768,000 and 460,800, and out of fuel at 0.
;-------------------------------------------------------------------------------
FlightControls:
        link.w  a6,#$ffe0                       ; 0557C
        movem.l d2-d3/a2-a3,-(a7)               ; 05580
        move.w  (CurrentObject).l,d0            ; 05584
        moveq   #$9,d1                          ; 0558A
        move.w  d0,-$2(a6)                      ; 0558C
        ext.l   d0                              ; 05590
        asl.l   d1,d0                           ; 05592
        movea.l d0,a0                           ; 05594
        adda.l  #ObjectTable,a0                 ; 05596
        move.l  a0,(CockpitObject).l            ; 0559C
        addq.l  #$2,a0                          ; 055A2
        movea.l (CockpitObject).l,a1            ; 055A4
        adda.w  #$56,a1                         ; 055AA
        movea.l (CockpitObject).l,a2            ; 055AE
        adda.w  #$58,a2                         ; 055B4
        movea.l (CockpitObject).l,a3            ; 055B8
        adda.w  #$5a,a3                         ; 055BE
        move.l  a0,-$a(a6)                      ; 055C2
        move.l  a1,-$e(a6)                      ; 055C6
        move.l  a2,-$12(a6)                     ; 055CA
        move.l  a3,-$16(a6)                     ; 055CE
        tst.w   -$2(a6)                         ; 055D2
        beq.b   l_000_055E0                     ; 055D6
        move.w  (a0),d0                         ; 055D8
        btst    #$8,d0                          ; 055DA
        beq.b   l_000_055EA                     ; 055DE
l_000_055E0:
        move.l  #ControlResponse,-$6(a6)        ; 055E0
        bra.b   l_000_055F2                     ; 055E8
l_000_055EA:
        move.l  #ControlResponse2,-$6(a6)       ; 055EA
l_000_055F2:
        movea.l -$a(a6),a0                      ; 055F2
        move.w  (a0),d0                         ; 055F6
        andi.w  #$ffbf,d0                       ; 055F8
        move.w  d0,(a0)                         ; 055FC
        move.w  (StatusBits).l,d1               ; 055FE
        btst    #$6,d1                          ; 05604
        beq.w   l_000_05ADE                     ; 05608
        tst.w   -$2(a6)                         ; 0560C
        bne.w   l_000_056C4                     ; 05610
        tst.l   (PlayerFuel).l                  ; 05614
        bgt.b   l_000_0565A                     ; 0561A
        moveq   #$0,d1                          ; 0561C
        move.l  d1,(PlayerFuel).l               ; 0561E
        btst    #$6,(ControlBits).l             ; 05624
        bne.w   l_000_056C4                     ; 0562C
        move.l  (WarningFlags).l,d0             ; 05630
        andi.l  #$fffffffc,d0                   ; 05636
        ori.l   #$40,d0                         ; 0563C
        move.l  d0,(WarningFlags).l             ; 05642
        move.w  (a0),d0                         ; 05648
        andi.w  #$fff7,d0                       ; 0564A
        move.w  d0,(a0)                         ; 0564E
        move.b  #$2,(dat_071_0020E).l           ; 05650
        bra.b   l_000_056C4                     ; 05658
l_000_0565A:
        cmpi.l  #$70800,(PlayerFuel).l          ; 0565A
        bge.b   l_000_0568A                     ; 05664
        btst    #$1,(ControlBits).l             ; 05666
        bne.b   l_000_056C4                     ; 0566E
        move.l  (WarningFlags).l,d0             ; 05670
        andi.l  #$ffffffbe,d0                   ; 05676
        ori.l   #$2,d0                          ; 0567C
        move.l  d0,(WarningFlags).l             ; 05682
        bra.b   l_000_056C4                     ; 05688
l_000_0568A:
        cmpi.l  #$bb800,(PlayerFuel).l          ; 0568A
        bge.b   l_000_056BA                     ; 05694
        btst    #$0,(ControlBits).l             ; 05696
        bne.b   l_000_056C4                     ; 0569E
        move.l  (WarningFlags).l,d0             ; 056A0
        andi.l  #$ffffffbd,d0                   ; 056A6
        ori.l   #$1,d0                          ; 056AC
        move.l  d0,(WarningFlags).l             ; 056B2
        bra.b   l_000_056C4                     ; 056B8
l_000_056BA:
        andi.l  #$ffffffbc,(WarningFlags).l     ; 056BA
l_000_056C4:
        movea.l (CockpitObject).l,a0            ; 056C4
        move.b  $28(a0),d0                      ; 056CA
        ext.w   d0                              ; 056CE
        move.b  $29(a0),d1                      ; 056D0
        ext.w   d1                              ; 056D4
        move.b  $2a(a0),d2                      ; 056D6
        ext.w   d2                              ; 056DA
        move.b  $4(a0),d3                       ; 056DC
        move.w  d0,-$18(a6)                     ; 056E0
        move.w  d1,-$1a(a6)                     ; 056E4
        move.w  d2,-$1c(a6)                     ; 056E8
        btst    #$3,d3                          ; 056EC
        beq.b   l_000_056FC                     ; 056F0
        moveq   #$0,d0                          ; 056F2
        move.w  d0,-$1a(a6)                     ; 056F4
        move.w  d0,-$1c(a6)                     ; 056F8
l_000_056FC:
        tst.w   -$18(a6)                        ; 056FC
        beq.w   l_000_0580E                     ; 05700
        move.w  -$18(a6),d0                     ; 05704
        ext.l   d0                              ; 05708
        tst.l   d0                              ; 0570A
        bpl.b   l_000_05724                     ; 0570C
        neg.l   d0                              ; 0570E
        asl.l   #$1,d0                          ; 05710
        movea.l -$6(a6),a0                      ; 05712
        adda.l  d0,a0                           ; 05716
        move.w  (a0),d0                         ; 05718
        neg.w   d0                              ; 0571A
        move.w  d0,(dat_071_0052E).l            ; 0571C
        bra.b   l_000_05738                     ; 05722
l_000_05724:
        move.w  -$18(a6),d0                     ; 05724
        ext.l   d0                              ; 05728
        asl.l   #$1,d0                          ; 0572A
        movea.l -$6(a6),a0                      ; 0572C
        adda.l  d0,a0                           ; 05730
        move.w  (a0),(dat_071_0052E).l          ; 05732
l_000_05738:
        movea.l -$a(a6),a0                      ; 05738
        move.w  (a0),d0                         ; 0573C
        btst    #$7,d0                          ; 0573E
        bne.b   l_000_05758                     ; 05742
        move.w  (dat_071_0052E).l,d0            ; 05744
        ext.l   d0                              ; 0574A
        move.l  d0,-(a7)                        ; 0574C
        bsr.w   sub_000_05CF0                   ; 0574E
        addq.l  #$4,a7                          ; 05752
        bra.w   l_000_0586E                     ; 05754
l_000_05758:
        movea.l (CockpitObject).l,a0            ; 05758
        move.b  $20(a0),d0                      ; 0575E
        btst    #$0,d0                          ; 05762
        beq.b   l_000_05788                     ; 05766
        move.w  -$2(a6),d0                      ; 05768
        ext.l   d0                              ; 0576C
        move.l  d0,-(a7)                        ; 0576E
        bsr.w   sub_000_05BDE                   ; 05770
        addq.l  #$4,a7                          ; 05774
        move.w  -$2(a6),d0                      ; 05776
        ext.l   d0                              ; 0577A
        move.l  d0,-(a7)                        ; 0577C
        bsr.w   sub_000_05CAA                   ; 0577E
        addq.l  #$4,a7                          ; 05782
        bra.w   l_000_0586E                     ; 05784
l_000_05788:
        movea.l (CockpitObject).l,a0            ; 05788
        move.w  $6c(a0),d0                      ; 0578E
        cmpi.w  #$300,d0                        ; 05792
        ble.b   l_000_057F0                     ; 05796
        move.w  $66(a0),d0                      ; 05798
        tst.w   d0                              ; 0579C
        beq.b   l_000_057A6                     ; 0579E
        cmpi.w  #$6d60,d0                       ; 057A0
        ble.b   l_000_057F0                     ; 057A4
l_000_057A6:
        tst.w   -$18(a6)                        ; 057A6
        bpl.b   l_000_057D0                     ; 057AA
        move.w  -$18(a6),d0                     ; 057AC
        ext.l   d0                              ; 057B0
        neg.l   d0                              ; 057B2
        asr.l   #$1,d0                          ; 057B4
        asl.l   #$1,d0                          ; 057B6
        movea.l -$6(a6),a0                      ; 057B8
        adda.l  d0,a0                           ; 057BC
        move.w  (a0),d0                         ; 057BE
        ext.l   d0                              ; 057C0
        neg.l   d0                              ; 057C2
        move.l  d0,-(a7)                        ; 057C4
        bsr.w   sub_000_05CF0                   ; 057C6
        addq.l  #$4,a7                          ; 057CA
        bra.w   l_000_0586E                     ; 057CC
l_000_057D0:
        move.w  -$2(a6),d0                      ; 057D0
        ext.l   d0                              ; 057D4
        move.l  d0,-(a7)                        ; 057D6
        bsr.w   sub_000_05BDE                   ; 057D8
        addq.l  #$4,a7                          ; 057DC
        move.w  -$2(a6),d0                      ; 057DE
        ext.l   d0                              ; 057E2
        move.l  d0,-(a7)                        ; 057E4
        bsr.w   sub_000_05CAA                   ; 057E6
        addq.l  #$4,a7                          ; 057EA
        bra.w   l_000_0586E                     ; 057EC
l_000_057F0:
        move.w  -$2(a6),d0                      ; 057F0
        ext.l   d0                              ; 057F4
        move.l  d0,-(a7)                        ; 057F6
        bsr.w   sub_000_05BDE                   ; 057F8
        addq.l  #$4,a7                          ; 057FC
        move.w  -$2(a6),d0                      ; 057FE
        ext.l   d0                              ; 05802
        move.l  d0,-(a7)                        ; 05804
        bsr.w   sub_000_05CAA                   ; 05806
        addq.l  #$4,a7                          ; 0580A
        bra.b   l_000_0586E                     ; 0580C
l_000_0580E:
        moveq   #$0,d0                          ; 0580E
        move.w  d0,(dat_071_0052E).l            ; 05810
        movea.l -$a(a6),a0                      ; 05816
        move.w  (a0),d1                         ; 0581A
        move.w  d0,-$18(a6)                     ; 0581C
        btst    #$7,d1                          ; 05820
        beq.b   l_000_05836                     ; 05824
        move.w  -$2(a6),d0                      ; 05826
        ext.l   d0                              ; 0582A
        move.l  d0,-(a7)                        ; 0582C
        bsr.w   sub_000_05BDE                   ; 0582E
        addq.l  #$4,a7                          ; 05832
        bra.b   l_000_0586E                     ; 05834
l_000_05836:
        movea.l -$e(a6),a0                      ; 05836
        tst.w   (a0)                            ; 0583A
        beq.b   l_000_0586E                     ; 0583C
        movea.l (CockpitObject).l,a1            ; 0583E
        move.w  $26(a1),d0                      ; 05844
        tst.w   d0                              ; 05848
        bne.b   l_000_0586E                     ; 0584A
        tst.w   -$2(a6)                         ; 0584C
        bne.b   l_000_05860                     ; 05850
        moveq   #$2,d0                          ; 05852
        move.l  d0,-(a7)                        ; 05854
        move.l  a0,-(a7)                        ; 05856
        bsr.w   EaseToZero                      ; 05858
        addq.l  #$8,a7                          ; 0585C
        bra.b   l_000_0586E                     ; 0585E
l_000_05860:
        moveq   #$1,d0                          ; 05860
        move.l  d0,-(a7)                        ; 05862
        move.l  -$e(a6),-(a7)                   ; 05864
        bsr.w   EaseToZero                      ; 05868
        addq.l  #$8,a7                          ; 0586C
l_000_0586E:
        tst.w   -$1a(a6)                        ; 0586E
        beq.b   l_000_058E0                     ; 05872
        move.w  -$1a(a6),d0                     ; 05874
        ext.l   d0                              ; 05878
        tst.l   d0                              ; 0587A
        bpl.b   l_000_05894                     ; 0587C
        neg.l   d0                              ; 0587E
        asl.l   #$1,d0                          ; 05880
        movea.l -$6(a6),a0                      ; 05882
        adda.l  d0,a0                           ; 05886
        move.w  (a0),d0                         ; 05888
        neg.w   d0                              ; 0588A
        move.w  d0,(dat_071_00530).l            ; 0588C
        bra.b   l_000_058A8                     ; 05892
l_000_05894:
        move.w  -$1a(a6),d0                     ; 05894
        ext.l   d0                              ; 05898
        asl.l   #$1,d0                          ; 0589A
        movea.l -$6(a6),a0                      ; 0589C
        adda.l  d0,a0                           ; 058A0
        move.w  (a0),(dat_071_00530).l          ; 058A2
l_000_058A8:
        movea.l (CockpitObject).l,a0            ; 058A8
        move.b  $4(a0),d0                       ; 058AE
        btst    #$1,d0                          ; 058B2
        bne.b   l_000_058D0                     ; 058B6
        tst.w   $6e(a0)                         ; 058B8
        beq.b   l_000_058D0                     ; 058BC
        move.w  (dat_071_00530).l,d0            ; 058BE
        ext.l   d0                              ; 058C4
        move.l  d0,-(a7)                        ; 058C6
        bsr.w   sub_000_05D5A                   ; 058C8
        addq.l  #$4,a7                          ; 058CC
        bra.b   l_000_05912                     ; 058CE
l_000_058D0:
        moveq   #$1,d0                          ; 058D0
        move.l  d0,-(a7)                        ; 058D2
        move.l  -$12(a6),-(a7)                  ; 058D4
        bsr.w   EaseToZero                      ; 058D8
        addq.l  #$8,a7                          ; 058DC
        bra.b   l_000_05912                     ; 058DE
l_000_058E0:
        tst.w   -$1c(a6)                        ; 058E0
        beq.b   l_000_058F2                     ; 058E4
        movea.l -$a(a6),a0                      ; 058E6
        move.w  (a0),d0                         ; 058EA
        btst    #$7,d0                          ; 058EC
        bne.b   l_000_05912                     ; 058F0
l_000_058F2:
        moveq   #$0,d0                          ; 058F2
        move.w  d0,(dat_071_00530).l            ; 058F4
        move.w  d0,-$1a(a6)                     ; 058FA
        movea.l -$12(a6),a0                     ; 058FE
        tst.w   (a0)                            ; 05902
        beq.b   l_000_05912                     ; 05904
        moveq   #$1,d0                          ; 05906
        move.l  d0,-(a7)                        ; 05908
        move.l  a0,-(a7)                        ; 0590A
        bsr.w   EaseToZero                      ; 0590C
        addq.l  #$8,a7                          ; 05910
l_000_05912:
        tst.w   -$1c(a6)                        ; 05912
        beq.w   l_000_05AA2                     ; 05916
        movea.l -$a(a6),a0                      ; 0591A
        move.w  (a0),d0                         ; 0591E
        btst    #$7,d0                          ; 05920
        beq.b   l_000_0597A                     ; 05924
        tst.w   -$1c(a6)                        ; 05926
        bpl.b   l_000_05956                     ; 0592A
        cmpi.w  #$fff6,-$1c(a6)                 ; 0592C
        bge.b   l_000_0593A                     ; 05932
        move.w  #$fff6,-$1c(a6)                 ; 05934
l_000_0593A:
        move.w  -$1c(a6),d0                     ; 0593A
        ext.l   d0                              ; 0593E
        neg.l   d0                              ; 05940
        asl.l   #$1,d0                          ; 05942
        movea.l -$6(a6),a0                      ; 05944
        adda.l  d0,a0                           ; 05948
        move.w  (a0),d0                         ; 0594A
        neg.w   d0                              ; 0594C
        move.w  d0,(dat_071_00532).l            ; 0594E
        bra.b   l_000_059AE                     ; 05954
l_000_05956:
        cmpi.w  #$a,-$1c(a6)                    ; 05956
        ble.b   l_000_05964                     ; 0595C
        move.w  #$a,-$1c(a6)                    ; 0595E
l_000_05964:
        move.w  -$1c(a6),d0                     ; 05964
        ext.l   d0                              ; 05968
        asl.l   #$1,d0                          ; 0596A
        movea.l -$6(a6),a0                      ; 0596C
        adda.l  d0,a0                           ; 05970
        move.w  (a0),(dat_071_00532).l          ; 05972
        bra.b   l_000_059AE                     ; 05978
l_000_0597A:
        move.w  -$1c(a6),d0                     ; 0597A
        ext.l   d0                              ; 0597E
        tst.l   d0                              ; 05980
        bpl.b   l_000_0599A                     ; 05982
        neg.l   d0                              ; 05984
        asl.l   #$1,d0                          ; 05986
        movea.l -$6(a6),a0                      ; 05988
        adda.l  d0,a0                           ; 0598C
        move.w  (a0),d0                         ; 0598E
        neg.w   d0                              ; 05990
        move.w  d0,(dat_071_00532).l            ; 05992
        bra.b   l_000_059AE                     ; 05998
l_000_0599A:
        move.w  -$1c(a6),d0                     ; 0599A
        ext.l   d0                              ; 0599E
        asl.l   #$1,d0                          ; 059A0
        movea.l -$6(a6),a0                      ; 059A2
        adda.l  d0,a0                           ; 059A6
        move.w  (a0),(dat_071_00532).l          ; 059A8
l_000_059AE:
        movea.l -$a(a6),a0                      ; 059AE
        move.w  (a0),d0                         ; 059B2
        btst    #$7,d0                          ; 059B4
        bne.b   l_000_059D0                     ; 059B8
        move.w  (dat_071_00532).l,d0            ; 059BA
        ext.l   d0                              ; 059C0
        neg.l   d0                              ; 059C2
        move.l  d0,-(a7)                        ; 059C4
        bsr.w   sub_000_05DB4                   ; 059C6
        addq.l  #$4,a7                          ; 059CA
        bra.w   l_000_05AE8                     ; 059CC
l_000_059D0:
        movea.l (CockpitObject).l,a0            ; 059D0
        move.w  $6e(a0),-$1e(a6)                ; 059D6
        move.w  $6a(a0),-$20(a6)                ; 059DC
        move.b  $4(a0),d0                       ; 059E2
        btst    #$1,d0                          ; 059E6
        bne.w   l_000_05A84                     ; 059EA
        tst.w   -$1e(a6)                        ; 059EE
        beq.w   l_000_05A84                     ; 059F2
        move.w  (dat_071_00532).l,d0            ; 059F6
        ext.l   d0                              ; 059FC
        move.l  d0,-(a7)                        ; 059FE
        bsr.w   sub_000_05D5A                   ; 05A00
        addq.l  #$4,a7                          ; 05A04
        move.w  -$20(a6),d0                     ; 05A06
        cmpi.w  #$50,d0                         ; 05A0A
        blt.b   l_000_05A16                     ; 05A0E
        cmpi.w  #$7030,d0                       ; 05A10
        ble.b   l_000_05A34                     ; 05A14
l_000_05A16:
        cmpi.w  #$360,-$1e(a6)                  ; 05A16
        ble.b   l_000_05A34                     ; 05A1C
        move.w  (dat_071_00532).l,d0            ; 05A1E
        ext.l   d0                              ; 05A24
        neg.l   d0                              ; 05A26
        move.l  d0,-(a7)                        ; 05A28
        bsr.w   sub_000_05DB4                   ; 05A2A
        addq.l  #$4,a7                          ; 05A2E
        bra.w   l_000_05AE8                     ; 05A30
l_000_05A34:
        cmpi.w  #$3840,-$20(a6)                 ; 05A34
        bge.b   l_000_05A62                     ; 05A3A
        tst.w   -$1c(a6)                        ; 05A3C
        bmi.b   l_000_05A58                     ; 05A40
        move.w  (dat_071_00532).l,d0            ; 05A42
        ext.l   d0                              ; 05A48
        neg.l   d0                              ; 05A4A
        move.l  d0,-(a7)                        ; 05A4C
        bsr.w   sub_000_05DB4                   ; 05A4E
        addq.l  #$4,a7                          ; 05A52
        bra.w   l_000_05AE8                     ; 05A54
l_000_05A58:
        movea.l -$16(a6),a0                     ; 05A58
        clr.w   (a0)                            ; 05A5C
        bra.w   l_000_05AE8                     ; 05A5E
l_000_05A62:
        tst.w   -$1c(a6)                        ; 05A62
        bgt.b   l_000_05A7C                     ; 05A66
        move.w  (dat_071_00532).l,d0            ; 05A68
        ext.l   d0                              ; 05A6E
        neg.l   d0                              ; 05A70
        move.l  d0,-(a7)                        ; 05A72
        bsr.w   sub_000_05DB4                   ; 05A74
        addq.l  #$4,a7                          ; 05A78
        bra.b   l_000_05AE8                     ; 05A7A
l_000_05A7C:
        movea.l -$16(a6),a0                     ; 05A7C
        clr.w   (a0)                            ; 05A80
        bra.b   l_000_05AE8                     ; 05A82
l_000_05A84:
        moveq   #$1,d0                          ; 05A84
        move.l  d0,-(a7)                        ; 05A86
        move.l  -$12(a6),-(a7)                  ; 05A88
        bsr.w   EaseToZero                      ; 05A8C
        addq.l  #$8,a7                          ; 05A90
        moveq   #$1,d0                          ; 05A92
        move.l  d0,-(a7)                        ; 05A94
        move.l  -$16(a6),-(a7)                  ; 05A96
        bsr.w   EaseToZero                      ; 05A9A
        addq.l  #$8,a7                          ; 05A9E
        bra.b   l_000_05AE8                     ; 05AA0
l_000_05AA2:
        moveq   #$0,d0                          ; 05AA2
        move.w  d0,(dat_071_00532).l            ; 05AA4
        movea.l -$a(a6),a0                      ; 05AAA
        move.w  (a0),d1                         ; 05AAE
        move.w  d0,-$1c(a6)                     ; 05AB0
        btst    #$7,d1                          ; 05AB4
        beq.b   l_000_05AC8                     ; 05AB8
        move.w  -$2(a6),d0                      ; 05ABA
        ext.l   d0                              ; 05ABE
        move.l  d0,-(a7)                        ; 05AC0
        bsr.w   sub_000_05CAA                   ; 05AC2
        addq.l  #$4,a7                          ; 05AC6
l_000_05AC8:
        movea.l -$16(a6),a0                     ; 05AC8
        tst.w   (a0)                            ; 05ACC
        beq.b   l_000_05AE8                     ; 05ACE
        moveq   #$1,d0                          ; 05AD0
        move.l  d0,-(a7)                        ; 05AD2
        move.l  a0,-(a7)                        ; 05AD4
        bsr.w   EaseToZero                      ; 05AD6
        addq.l  #$8,a7                          ; 05ADA
        bra.b   l_000_05AE8                     ; 05ADC
l_000_05ADE:
        andi.l  #$ffffffbc,(WarningFlags).l     ; 05ADE
l_000_05AE8:
        tst.w   -$2(a6)                         ; 05AE8
        bne.w   l_000_05B72                     ; 05AEC
        move.w  (StatusBits).l,d0               ; 05AF0
        btst    #$6,d0                          ; 05AF6
        beq.b   l_000_05B60                     ; 05AFA
        tst.l   (PlayerFuel).l                  ; 05AFC
        beq.b   l_000_05B60                     ; 05B02
        move.b  (Player_20).l,d0                ; 05B04
        btst    #$2,d0                          ; 05B0A
        beq.b   l_000_05B4C                     ; 05B0E
        movea.l -$a(a6),a0                      ; 05B10
        move.w  (a0),d0                         ; 05B14
        btst    #$7,d0                          ; 05B16
        bne.b   l_000_05B4C                     ; 05B1A
        btst    #$7,(ControlBits).l             ; 05B1C
        bne.b   l_000_05B38                     ; 05B24
        bset    #$7,(ControlBits).l             ; 05B26
        bset    #$5,(CockpitSoundBits).l        ; 05B2E
        bra.b   l_000_05B72                     ; 05B36
l_000_05B38:
        move.w  (dat_071_002C0).l,d0            ; 05B38
        tst.w   d0                              ; 05B3E
        bpl.b   l_000_05B72                     ; 05B40
        move.w  #$2,(dat_071_002C0).l           ; 05B42
        bra.b   l_000_05B72                     ; 05B4A
l_000_05B4C:
        btst    #$7,(ControlBits).l             ; 05B4C
        beq.b   l_000_05B72                     ; 05B54
        bclr    #$7,(ControlBits).l             ; 05B56
        bra.b   l_000_05B72                     ; 05B5E
l_000_05B60:
        btst    #$7,(ControlBits).l             ; 05B60
        beq.b   l_000_05B72                     ; 05B68
        bclr    #$7,(ControlBits).l             ; 05B6A
l_000_05B72:
        movem.l (a7)+,d2-d3/a2-a3               ; 05B72
        unlk    a6                              ; 05B76
        rts                                     ; 05B78

;-------------------------------------------------------------------------------
; EaseToZero - Moves the word at a0 towards 0 by its value shifted right by the given amount
; (at least 1 step), for the controls' return to centre.
;-------------------------------------------------------------------------------
EaseToZero:
        link.w  a6,#$fffe                       ; 05B7A
        movea.l $8(a6),a0                       ; 05B7E
        move.w  (a0),d0                         ; 05B82
        move.w  d0,$0(a7)                       ; 05B84
        cmpi.w  #$fff1,d0                       ; 05B88
        bge.b   l_000_05BA0                     ; 05B8C
        neg.w   d0                              ; 05B8E
        move.w  $e(a6),d1                       ; 05B90
        asr.w   d1,d0                           ; 05B94
        move.w  $0(a7),d1                       ; 05B96
        add.w   d0,d1                           ; 05B9A
        move.w  d1,(a0)                         ; 05B9C
        bra.b   l_000_05BDA                     ; 05B9E
l_000_05BA0:
        movea.l $8(a6),a0                       ; 05BA0
        move.w  (a0),d0                         ; 05BA4
        move.w  d0,$0(a7)                       ; 05BA6
        cmpi.w  #$f,d0                          ; 05BAA
        ble.b   l_000_05BC0                     ; 05BAE
        move.w  $e(a6),d1                       ; 05BB0
        asr.w   d1,d0                           ; 05BB4
        move.w  $0(a7),d1                       ; 05BB6
        sub.w   d0,d1                           ; 05BBA
        move.w  d1,(a0)                         ; 05BBC
        bra.b   l_000_05BDA                     ; 05BBE
l_000_05BC0:
        movea.l $8(a6),a0                       ; 05BC0
        move.w  (a0),d0                         ; 05BC4
        tst.w   d0                              ; 05BC6
        bpl.b   l_000_05BD0                     ; 05BC8
        addq.w  #$1,d0                          ; 05BCA
        move.w  d0,(a0)                         ; 05BCC
        bra.b   l_000_05BDA                     ; 05BCE
l_000_05BD0:
        movea.l $8(a6),a0                       ; 05BD0
        move.w  (a0),d0                         ; 05BD4
        subq.w  #$1,d0                          ; 05BD6
        move.w  d0,(a0)                         ; 05BD8
l_000_05BDA:
        unlk    a6                              ; 05BDA
        rts                                     ; 05BDC
sub_000_05BDE:
        link.w  a6,#$fff2                       ; 05BDE
        movea.l (CockpitObject).l,a0            ; 05BE2
        adda.w  #$66,a0                         ; 05BE8
        movea.l (CockpitObject).l,a1            ; 05BEC
        adda.w  #$56,a1                         ; 05BF2
        move.w  (a0),d0                         ; 05BF6
        move.l  a0,-$6(a6)                      ; 05BF8
        move.l  a1,-$a(a6)                      ; 05BFC
        tst.w   d0                              ; 05C00
        ble.w   l_000_05CA6                     ; 05C02
        cmpi.w  #$190,d0                        ; 05C06
        bge.b   l_000_05C54                     ; 05C0A
        movea.l (CockpitObject).l,a0            ; 05C0C
        move.w  $2(a0),d0                       ; 05C12
        btst    #$6,d0                          ; 05C16
        bne.b   l_000_05C4C                     ; 05C1A
        ori.w   #$40,d0                         ; 05C1C
        movea.l (CockpitObject).l,a0            ; 05C20
        move.w  d0,$2(a0)                       ; 05C26
        move.w  (a0),d0                         ; 05C2A
        andi.w  #$1600,d0                       ; 05C2C
        cmpi.w  #$1000,d0                       ; 05C30
        bne.b   l_000_05C4C                     ; 05C34
        move.b  $4(a0),d0                       ; 05C36
        btst    #$1,d0                          ; 05C3A
        bne.b   l_000_05C4C                     ; 05C3E
        moveq   #$f,d0                          ; 05C40
        move.l  d0,-(a7)                        ; 05C42
        jsr     (PlayTireSound).l               ; 05C44
        addq.l  #$4,a7                          ; 05C4A
l_000_05C4C:
        movea.l -$a(a6),a0                      ; 05C4C
        clr.w   (a0)                            ; 05C50
        bra.b   l_000_05CA6                     ; 05C52
l_000_05C54:
        movea.l (CockpitObject).l,a0            ; 05C54
        move.w  $6c(a0),d0                      ; 05C5A
        cmpi.w  #$6c0,d0                        ; 05C5E
        bge.b   l_000_05C6A                     ; 05C62
        clr.w   -$2(a6)                         ; 05C64
        bra.b   l_000_05C70                     ; 05C68
l_000_05C6A:
        move.w  #$1,-$2(a6)                     ; 05C6A
l_000_05C70:
        movea.l -$6(a6),a0                      ; 05C70
        move.w  (a0),d0                         ; 05C74
        cmpi.w  #$3840,d0                       ; 05C76
        bge.b   l_000_05C84                     ; 05C7A
        move.w  #$ffc0,-$c(a6)                  ; 05C7C
        bra.b   l_000_05C8A                     ; 05C82
l_000_05C84:
        move.w  #$40,-$c(a6)                    ; 05C84
l_000_05C8A:
        movea.l -$a(a6),a0                      ; 05C8A
        move.w  (a0),d0                         ; 05C8E
        move.w  d0,$0(a7)                       ; 05C90
        sub.w   -$c(a6),d0                      ; 05C94
        move.w  -$2(a6),d1                      ; 05C98
        asr.w   d1,d0                           ; 05C9C
        move.w  $0(a7),d1                       ; 05C9E
        sub.w   d0,d1                           ; 05CA2
        move.w  d1,(a0)                         ; 05CA4
l_000_05CA6:
        unlk    a6                              ; 05CA6
        rts                                     ; 05CA8
sub_000_05CAA:
        link.w  a6,#$fff8                       ; 05CAA
        movea.l (CockpitObject).l,a0            ; 05CAE
        adda.w  #$6a,a0                         ; 05CB4
        movea.l (CockpitObject).l,a1            ; 05CB8
        adda.w  #$5a,a1                         ; 05CBE
        move.l  a0,-$4(a6)                      ; 05CC2
        move.l  a1,-$8(a6)                      ; 05CC6
        tst.w   (a0)                            ; 05CCA
        beq.b   l_000_05CE6                     ; 05CCC
        move.w  (a0),d0                         ; 05CCE
        cmpi.w  #$3840,d0                       ; 05CD0
        ble.b   l_000_05CDC                     ; 05CD4
        move.w  #$20,(a1)                       ; 05CD6
        bra.b   l_000_05CEC                     ; 05CDA
l_000_05CDC:
        movea.l -$8(a6),a0                      ; 05CDC
        move.w  #$ffe0,(a0)                     ; 05CE0
        bra.b   l_000_05CEC                     ; 05CE4
l_000_05CE6:
        movea.l -$8(a6),a0                      ; 05CE6
        clr.w   (a0)                            ; 05CEA
l_000_05CEC:
        unlk    a6                              ; 05CEC
        rts                                     ; 05CEE
sub_000_05CF0:
        link.w  a6,#$fffa                       ; 05CF0
        movea.l (CockpitObject).l,a0            ; 05CF4
        move.w  $2(a0),d0                       ; 05CFA
        btst    #$7,d0                          ; 05CFE
        bne.b   l_000_05D12                     ; 05D02
        move.w  $26(a0),d0                      ; 05D04
        tst.w   d0                              ; 05D08
        beq.b   l_000_05D12                     ; 05D0A
        tst.w   $a(a6)                          ; 05D0C
        ble.b   l_000_05D56                     ; 05D10
l_000_05D12:
        movea.l (CockpitObject).l,a0            ; 05D12
        move.b  $20(a0),d0                      ; 05D18
        btst    #$2,d0                          ; 05D1C
        beq.b   l_000_05D2C                     ; 05D20
        move.w  $a(a6),d0                       ; 05D22
        asr.w   #$1,d0                          ; 05D26
        move.w  d0,$a(a6)                       ; 05D28
l_000_05D2C:
        movea.l (CockpitObject).l,a0            ; 05D2C
        adda.w  #$56,a0                         ; 05D32
        move.w  (a0),d0                         ; 05D36
        move.w  d0,$0(a7)                       ; 05D38
        sub.w   $a(a6),d0                       ; 05D3C
        asr.w   #$2,d0                          ; 05D40
        move.w  $0(a7),d1                       ; 05D42
        sub.w   d0,d1                           ; 05D46
        move.w  d1,(a0)                         ; 05D48
        move.l  a0,-(a7)                        ; 05D4A
        move.l  a0,-$4(a6)                      ; 05D4C
        bsr.w   sub_000_05E2E                   ; 05D50
        addq.l  #$4,a7                          ; 05D54
l_000_05D56:
        unlk    a6                              ; 05D56
        rts                                     ; 05D58
sub_000_05D5A:
        link.w  a6,#$fffa                       ; 05D5A
        move.w  $a(a6),d0                       ; 05D5E
        asr.w   #$1,d0                          ; 05D62
        move.w  $a(a6),d1                       ; 05D64
        asr.w   #$3,d1                          ; 05D68
        add.w   d1,d0                           ; 05D6A
        movea.l (CockpitObject).l,a0            ; 05D6C
        move.b  $20(a0),d1                      ; 05D72
        move.w  d0,$a(a6)                       ; 05D76
        btst    #$2,d1                          ; 05D7A
        beq.b   l_000_05D86                     ; 05D7E
        asr.w   #$1,d0                          ; 05D80
        move.w  d0,$a(a6)                       ; 05D82
l_000_05D86:
        movea.l (CockpitObject).l,a0            ; 05D86
        adda.w  #$58,a0                         ; 05D8C
        move.w  (a0),d0                         ; 05D90
        move.w  d0,$0(a7)                       ; 05D92
        sub.w   $a(a6),d0                       ; 05D96
        asr.w   #$2,d0                          ; 05D9A
        move.w  $0(a7),d1                       ; 05D9C
        sub.w   d0,d1                           ; 05DA0
        move.w  d1,(a0)                         ; 05DA2
        move.l  a0,-(a7)                        ; 05DA4
        move.l  a0,-$4(a6)                      ; 05DA6
        bsr.w   sub_000_05E2E                   ; 05DAA
        addq.l  #$4,a7                          ; 05DAE
        unlk    a6                              ; 05DB0
        rts                                     ; 05DB2
sub_000_05DB4:
        link.w  a6,#$fff8                       ; 05DB4
        move.w  $a(a6),d0                       ; 05DB8
        asr.w   #$1,d0                          ; 05DBC
        move.w  $a(a6),d1                       ; 05DBE
        asr.w   #$3,d1                          ; 05DC2
        add.w   d1,d0                           ; 05DC4
        movea.l (CockpitObject).l,a0            ; 05DC6
        move.b  $20(a0),d1                      ; 05DCC
        move.w  d0,$a(a6)                       ; 05DD0
        btst    #$2,d1                          ; 05DD4
        beq.b   l_000_05DE0                     ; 05DD8
        asr.w   #$1,d0                          ; 05DDA
        move.w  d0,$a(a6)                       ; 05DDC
l_000_05DE0:
        movea.l (CockpitObject).l,a0            ; 05DE0
        move.b  $62(a0),d0                      ; 05DE6
        cmpi.b  #$14,d0                         ; 05DEA
        bne.b   l_000_05DF8                     ; 05DEE
        move.w  #$2,-$6(a6)                     ; 05DF0
        bra.b   l_000_05DFE                     ; 05DF6
l_000_05DF8:
        move.w  #$1,-$6(a6)                     ; 05DF8
l_000_05DFE:
        movea.l (CockpitObject).l,a0            ; 05DFE
        adda.w  #$5a,a0                         ; 05E04
        move.w  (a0),d0                         ; 05E08
        move.w  d0,$0(a7)                       ; 05E0A
        sub.w   $a(a6),d0                       ; 05E0E
        move.w  -$6(a6),d1                      ; 05E12
        asr.w   d1,d0                           ; 05E16
        move.w  $0(a7),d1                       ; 05E18
        sub.w   d0,d1                           ; 05E1C
        move.w  d1,(a0)                         ; 05E1E
        move.l  a0,-(a7)                        ; 05E20
        move.l  a0,-$4(a6)                      ; 05E22
        bsr.b   sub_000_05E2E                   ; 05E26
        addq.l  #$4,a7                          ; 05E28
        unlk    a6                              ; 05E2A
        rts                                     ; 05E2C
sub_000_05E2E:
        link.w  a6,#$fffe                       ; 05E2E
        movea.l (CockpitObject).l,a0            ; 05E32
        move.w  $6c(a0),d0                      ; 05E38
        asr.w   #$7,d0                          ; 05E3C
        movea.l $8(a6),a0                       ; 05E3E
        move.w  (a0),d1                         ; 05E42
        move.w  d0,-$2(a6)                      ; 05E44
        tst.w   d1                              ; 05E48
        bmi.b   l_000_05E64                     ; 05E4A
        cmpi.w  #$500,d1                        ; 05E4C
        bge.b   l_000_05E56                     ; 05E50
        clr.w   -$2(a6)                         ; 05E52
l_000_05E56:
        movea.l $8(a6),a0                       ; 05E56
        move.w  (a0),d0                         ; 05E5A
        add.w   -$2(a6),d0                      ; 05E5C
        move.w  d0,(a0)                         ; 05E60
        bra.b   l_000_05E80                     ; 05E62
l_000_05E64:
        movea.l $8(a6),a0                       ; 05E64
        move.w  (a0),d0                         ; 05E68
        cmpi.w  #$fb00,d0                       ; 05E6A
        ble.b   l_000_05E74                     ; 05E6E
        clr.w   -$2(a6)                         ; 05E70
l_000_05E74:
        movea.l $8(a6),a0                       ; 05E74
        move.w  (a0),d0                         ; 05E78
        sub.w   -$2(a6),d0                      ; 05E7A
        move.w  d0,(a0)                         ; 05E7E
l_000_05E80:
        unlk    a6                              ; 05E80
        rts                                     ; 05E82
sub_000_05E84:
        tst.l   (PlayerFuel).l                  ; 05E84
        beq.b   l_000_05ED2                     ; 05E8A
        tst.b   (dat_071_001A8).l               ; 05E8C
        beq.b   l_000_05ED2                     ; 05E92
        move.w  (dat_071_00150).l,d0            ; 05E94
        andi.w  #$3,d0                          ; 05E9A
        subq.w  #$3,d0                          ; 05E9E
        bne.b   l_000_05ED2                     ; 05EA0
        move.w  (Player_02).l,d0                ; 05EA2
        btst    #$3,d0                          ; 05EA8
        bne.b   l_000_05EC4                     ; 05EAC
        move.b  (Player_2B).l,d0                ; 05EAE
        cmpi.b  #$78,d0                         ; 05EB4
        blt.b   l_000_05ECC                     ; 05EB8
        move.b  #$79,(dat_071_00240).l          ; 05EBA
        bra.b   l_000_05ECC                     ; 05EC2
l_000_05EC4:
        move.b  #$77,(dat_071_00240).l          ; 05EC4
l_000_05ECC:
        clr.w   (dat_071_00150).l               ; 05ECC
l_000_05ED2:
        rts                                     ; 05ED2

;-------------------------------------------------------------------------------
; EngineAndSpeed - An aircraft's engine and speed for the frame (CurrentObject), while it has
; fuel (+$72): the throttle bits of its control byte (+$65: 1 up, 2 down) move the throttle
; (+$2B, 0-120) by a step that grows while the bit is held (+$39's low nibble, up to 8,
; halved); at 120 a held throttle-up sets flag $2000 and a further one flag $8 (probably the
; afterburner); throttle-down clears them. For the player the mouse's vertical movement
; (dat_071_0014C - MouseY) is read too. The speed (+$6C) then changes towards what the throttle
; gives (through Decay); ClimbDivePhysics; and the speed flown (+$6E) = +$6C + +$78.
;-------------------------------------------------------------------------------
EngineAndSpeed:
        link.w  a6,#$ffce                       ; 05ED4
        movem.l d2/a2-a5,-(a7)                  ; 05ED8
        move.w  (CurrentObject).l,d0            ; 05EDC
        moveq   #$9,d1                          ; 05EE2
        move.w  d0,-$32(a6)                     ; 05EE4
        ext.l   d0                              ; 05EE8
        asl.l   d1,d0                           ; 05EEA
        movea.l d0,a0                           ; 05EEC
        adda.l  #ObjectTable,a0                 ; 05EEE
        move.l  a0,d0                           ; 05EF4
        move.l  d0,(CockpitObject).l            ; 05EF6
        movea.l d0,a0                           ; 05EFC
        move.l  a0,-$2c(a6)                     ; 05EFE
        addq.l  #$2,a0                          ; 05F02
        movea.l d0,a1                           ; 05F04
        addq.l  #$4,a1                          ; 05F06
        movea.l d0,a2                           ; 05F08
        adda.w  #$20,a2                         ; 05F0A
        movea.l d0,a3                           ; 05F0E
        adda.w  #$2b,a3                         ; 05F10
        movea.l d0,a4                           ; 05F14
        adda.w  #$65,a4                         ; 05F16
        movea.l d0,a5                           ; 05F1A
        adda.w  #$6c,a5                         ; 05F1C
        move.l  a0,-$30(a6)                     ; 05F20
        movea.l d0,a0                           ; 05F24
        adda.w  #$39,a0                         ; 05F26
        move.w  (a5),d1                         ; 05F2A
        neg.w   d1                              ; 05F2C
        move.w  d1,-$18(a6)                     ; 05F2E
        move.l  a0,-$c(a6)                      ; 05F32
        move.l  a1,-$10(a6)                     ; 05F36
        move.l  a2,-$14(a6)                     ; 05F3A
        move.l  a3,-$4(a6)                      ; 05F3E
        move.l  a4,-$8(a6)                      ; 05F42
        move.l  a5,-$20(a6)                     ; 05F46
        movea.l d0,a0                           ; 05F4A
        tst.l   $72(a0)                         ; 05F4C
        beq.w   l_000_06270                     ; 05F50
        tst.w   -$32(a6)                        ; 05F54
        bne.b   l_000_05F74                     ; 05F58
        move.w  (ThrottleMouseY).l,d0           ; 05F5A
        move.w  (MouseY).l,d1                   ; 05F60
        sub.w   d1,d0                           ; 05F66
        move.w  d0,-$28(a6)                     ; 05F68
        tst.w   d0                              ; 05F6C
        bpl.b   l_000_05F74                     ; 05F6E
        neg.w   -$28(a6)                        ; 05F70
l_000_05F74:
        movea.l -$8(a6),a0                      ; 05F74
        move.b  (a0),d0                         ; 05F78
        andi.b  #$3,d0                          ; 05F7A
        tst.b   d0                              ; 05F7E
        beq.w   l_000_061AC                     ; 05F80
        movea.l -$c(a6),a0                      ; 05F84
        move.b  (a0),d0                         ; 05F88
        ext.w   d0                              ; 05F8A
        ext.l   d0                              ; 05F8C
        andi.l  #$f,d0                          ; 05F8E
        addq.w  #$1,d0                          ; 05F94
        move.w  d0,-$16(a6)                     ; 05F96
        cmpi.w  #$8,d0                          ; 05F9A
        ble.b   l_000_05FA8                     ; 05F9E
        move.w  #$8,-$16(a6)                    ; 05FA0
        bra.b   l_000_05FC2                     ; 05FA6
l_000_05FA8:
        movea.l -$c(a6),a0                      ; 05FA8
        move.b  (a0),d0                         ; 05FAC
        ext.w   d0                              ; 05FAE
        ext.l   d0                              ; 05FB0
        andi.l  #$f0,d0                         ; 05FB2
        move.w  -$16(a6),d1                     ; 05FB8
        ext.l   d1                              ; 05FBC
        or.l    d1,d0                           ; 05FBE
        move.b  d0,(a0)                         ; 05FC0
l_000_05FC2:
        move.w  -$16(a6),d0                     ; 05FC2
        asr.w   #$1,d0                          ; 05FC6
        move.w  d0,-$16(a6)                     ; 05FC8
        tst.w   d0                              ; 05FCC
        beq.b   l_000_05FF0                     ; 05FCE
        movea.l -$4(a6),a0                      ; 05FD0
        move.b  (a0),d0                         ; 05FD4
        tst.b   d0                              ; 05FD6
        bne.b   l_000_05FF0                     ; 05FD8
        move.w  (ViewObjectIndex).l,d0          ; 05FDA
        move.w  -$32(a6),d1                     ; 05FE0
        cmp.w   d0,d1                           ; 05FE4
        bne.b   l_000_05FF0                     ; 05FE6
        move.b  #$fe,(EngineSoundRequest).l     ; 05FE8
l_000_05FF0:
        movea.l -$8(a6),a0                      ; 05FF0
        move.b  (a0),d0                         ; 05FF4
        andi.b  #$3,d0                          ; 05FF6
        subq.b  #$1,d0                          ; 05FFA
        bne.w   l_000_06098                     ; 05FFC
        movea.l -$30(a6),a0                     ; 06000
        move.w  (a0),d0                         ; 06004
        andi.w  #$fbff,d0                       ; 06006
        move.w  d0,(a0)                         ; 0600A
        movea.l -$4(a6),a0                      ; 0600C
        move.b  (a0),d1                         ; 06010
        ext.w   d1                              ; 06012
        ext.l   d1                              ; 06014
        move.w  -$16(a6),d2                     ; 06016
        ext.l   d2                              ; 0601A
        add.l   d2,d1                           ; 0601C
        move.b  d1,(a0)                         ; 0601E
        cmpi.b  #$78,d1                         ; 06020
        blt.w   l_000_06158                     ; 06024
        movea.l -$30(a6),a0                     ; 06028
        move.w  (a0),d0                         ; 0602C
        btst    #$d,d0                          ; 0602E
        beq.b   l_000_06068                     ; 06032
        btst    #$3,d0                          ; 06034
        bne.b   l_000_0608C                     ; 06038
        ori.w   #$8,d0                          ; 0603A
        move.w  d0,(a0)                         ; 0603E
        move.b  #$2,(dat_071_0020E).l           ; 06040
        move.w  (ViewObjectIndex).l,d0          ; 06048
        move.w  -$32(a6),d1                     ; 0604E
        cmp.w   d0,d1                           ; 06052
        bne.b   l_000_0608C                     ; 06054
        move.b  #$fd,(EngineSoundRequest).l     ; 06056
        move.b  #$6,(dat_071_00167).l           ; 0605E
        bra.b   l_000_0608C                     ; 06066
l_000_06068:
        movea.l -$30(a6),a0                     ; 06068
        move.w  (a0),d0                         ; 0606C
        ori.w   #$2000,d0                       ; 0606E
        move.w  d0,(a0)                         ; 06072
        movea.l -$8(a6),a0                      ; 06074
        move.b  (a0),d0                         ; 06078
        andi.b  #$fc,d0                         ; 0607A
        move.b  d0,(a0)                         ; 0607E
        tst.w   -$32(a6)                        ; 06080
        bne.b   l_000_0608C                     ; 06084
        clr.b   (dat_071_00240).l               ; 06086
l_000_0608C:
        movea.l -$4(a6),a0                      ; 0608C
        move.b  #$78,(a0)                       ; 06090
        bra.w   l_000_06158                     ; 06094
l_000_06098:
        movea.l -$8(a6),a0                      ; 06098
        move.b  (a0),d0                         ; 0609C
        andi.b  #$3,d0                          ; 0609E
        subq.b  #$2,d0                          ; 060A2
        bne.w   l_000_06158                     ; 060A4
        movea.l -$30(a6),a0                     ; 060A8
        move.w  (a0),d0                         ; 060AC
        andi.w  #$dfff,d0                       ; 060AE
        move.w  d0,(a0)                         ; 060B2
        btst    #$3,d0                          ; 060B4
        beq.b   l_000_060EA                     ; 060B8
        andi.w  #$fff7,d0                       ; 060BA
        move.w  d0,(a0)                         ; 060BE
        movea.l -$4(a6),a0                      ; 060C0
        move.b  (a0),d0                         ; 060C4
        subq.b  #$1,d0                          ; 060C6
        move.b  d0,(a0)                         ; 060C8
        move.b  #$2,(dat_071_0020E).l           ; 060CA
        move.w  (ViewObjectIndex).l,d0          ; 060D2
        move.w  -$32(a6),d1                     ; 060D8
        cmp.w   d0,d1                           ; 060DC
        bne.b   l_000_06158                     ; 060DE
        move.b  #$fc,(EngineSoundRequest).l     ; 060E0
        bra.b   l_000_06158                     ; 060E8
l_000_060EA:
        movea.l -$4(a6),a0                      ; 060EA
        move.b  (a0),d0                         ; 060EE
        tst.b   d0                              ; 060F0
        bmi.b   l_000_0613A                     ; 060F2
        subq.b  #$4,d0                          ; 060F4
        move.b  d0,(a0)                         ; 060F6
        tst.b   d0                              ; 060F8
        bpl.b   l_000_06158                     ; 060FA
        movea.l -$10(a6),a0                     ; 060FC
        move.b  (a0),d0                         ; 06100
        btst    #$3,d0                          ; 06102
        beq.b   l_000_06110                     ; 06106
        movea.l -$4(a6),a0                      ; 06108
        clr.b   (a0)                            ; 0610C
        bra.b   l_000_06158                     ; 0610E
l_000_06110:
        movea.l -$30(a6),a0                     ; 06110
        move.w  (a0),d0                         ; 06114
        btst    #$a,d0                          ; 06116
        bne.b   l_000_06158                     ; 0611A
        movea.l -$8(a6),a0                      ; 0611C
        move.b  (a0),d1                         ; 06120
        andi.b  #$fc,d1                         ; 06122
        move.b  d1,(a0)                         ; 06126
        movea.l -$4(a6),a0                      ; 06128
        clr.b   (a0)                            ; 0612C
        ori.w   #$400,d0                        ; 0612E
        movea.l -$30(a6),a0                     ; 06132
        move.w  d0,(a0)                         ; 06136
        bra.b   l_000_06158                     ; 06138
l_000_0613A:
        movea.l -$4(a6),a0                      ; 0613A
        move.b  (a0),d0                         ; 0613E
        ext.w   d0                              ; 06140
        ext.l   d0                              ; 06142
        move.w  -$16(a6),d1                     ; 06144
        ext.l   d1                              ; 06148
        sub.l   d1,d0                           ; 0614A
        move.b  d0,(a0)                         ; 0614C
        cmpi.b  #$e0,d0                         ; 0614E
        bge.b   l_000_06158                     ; 06152
        move.b  #$e0,(a0)                       ; 06154
l_000_06158:
        tst.w   -$32(a6)                        ; 06158
        bne.b   l_000_061BC                     ; 0615C
        movea.l -$4(a6),a0                      ; 0615E
        move.b  (a0),d0                         ; 06162
        ext.w   d0                              ; 06164
        move.w  d0,-$24(a6)                     ; 06166
        tst.w   d0                              ; 0616A
        bpl.b   l_000_06172                     ; 0616C
        clr.w   -$24(a6)                        ; 0616E
l_000_06172:
        tst.b   (dat_071_001A8).l               ; 06172
        beq.b   l_000_061BC                     ; 06178
        move.w  (MouseY).l,d0                   ; 0617A
        cmpi.w  #$3c0,d0                        ; 06180
        bge.b   l_000_0618E                     ; 06184
        cmpi.w  #$10,-$28(a6)                   ; 06186
        bge.b   l_000_061BC                     ; 0618C
l_000_0618E:
        move.w  -$24(a6),d0                     ; 0618E
        asl.w   #$3,d0                          ; 06192
        move.w  d0,(ThrottleMouseY).l           ; 06194
        move.w  (MouseY).l,d1                   ; 0619A
        tst.w   d1                              ; 061A0
        bmi.b   l_000_061BC                     ; 061A2
        move.w  d0,(MouseY).l                   ; 061A4
        bra.b   l_000_061BC                     ; 061AA
l_000_061AC:
        movea.l -$c(a6),a0                      ; 061AC
        move.b  (a0),d0                         ; 061B0
        andi.b  #$f0,d0                         ; 061B2
        move.b  d0,(a0)                         ; 061B6
        addq.b  #$1,d0                          ; 061B8
        move.b  d0,(a0)                         ; 061BA
l_000_061BC:
        tst.w   -$32(a6)                        ; 061BC
        bne.w   l_000_0629E                     ; 061C0
        move.b  (GameMode).l,d0                 ; 061C4
        subq.b  #$2,d0                          ; 061CA
        beq.w   l_000_0629E                     ; 061CC
        tst.b   (dat_071_001A8).l               ; 061D0
        beq.w   l_000_0629E                     ; 061D6
        move.w  (MouseY).l,d0                   ; 061DA
        cmpi.w  #$3c0,d0                        ; 061E0
        bge.b   l_000_061F0                     ; 061E4
        cmpi.w  #$10,-$28(a6)                   ; 061E6
        ble.w   l_000_0629E                     ; 061EC
l_000_061F0:
        move.w  (MouseY).l,d0                   ; 061F0
        tst.w   d0                              ; 061F6
        bpl.b   l_000_0620A                     ; 061F8
        clr.w   (MouseY).l                      ; 061FA
        move.b  #$ff,(dat_071_00240).l          ; 06200
        bra.b   l_000_06264                     ; 06208
l_000_0620A:
        movea.l -$30(a6),a0                     ; 0620A
        move.w  (a0),d0                         ; 0620E
        btst    #$3,d0                          ; 06210
        beq.b   l_000_06230                     ; 06214
        move.w  (MouseY).l,d0                   ; 06216
        ext.l   d0                              ; 0621C
        cmpi.l  #$360,d0                        ; 0621E
        bge.b   l_000_06264                     ; 06224
        asr.l   #$3,d0                          ; 06226
        move.b  d0,(dat_071_00240).l            ; 06228
        bra.b   l_000_06264                     ; 0622E
l_000_06230:
        tst.w   (MouseY).l                      ; 06230
        beq.b   l_000_06264                     ; 06236
        movea.l -$4(a6),a0                      ; 06238
        move.b  (a0),d0                         ; 0623C
        tst.b   d0                              ; 0623E
        bne.b   l_000_06254                     ; 06240
        move.w  (ViewObjectIndex).l,d0          ; 06242
        tst.w   d0                              ; 06248
        bne.b   l_000_06254                     ; 0624A
        move.b  #$fe,(EngineSoundRequest).l     ; 0624C
l_000_06254:
        move.w  (MouseY).l,d0                   ; 06254
        ext.l   d0                              ; 0625A
        asr.l   #$3,d0                          ; 0625C
        move.b  d0,(dat_071_00240).l            ; 0625E
l_000_06264:
        move.w  (MouseY).l,(ThrottleMouseY).l   ; 06264
        bra.b   l_000_0629E                     ; 0626E
l_000_06270:
        movea.l -$4(a6),a0                      ; 06270
        clr.b   (a0)                            ; 06274
        tst.w   -$32(a6)                        ; 06276
        bne.b   l_000_06292                     ; 0627A
        tst.b   (dat_071_001A8).l               ; 0627C
        beq.b   l_000_06292                     ; 06282
        moveq   #$0,d0                          ; 06284
        move.w  d0,(ThrottleMouseY).l           ; 06286
        move.w  d0,(MouseY).l                   ; 0628C
l_000_06292:
        movea.l -$30(a6),a0                     ; 06292
        move.w  (a0),d0                         ; 06296
        andi.w  #$fff7,d0                       ; 06298
        move.w  d0,(a0)                         ; 0629C
l_000_0629E:
        movea.l -$4(a6),a0                      ; 0629E
        move.b  (a0),d0                         ; 062A2
        ext.w   d0                              ; 062A4
        ext.l   d0                              ; 062A6
        asl.l   #$8,d0                          ; 062A8
        move.w  -$18(a6),d1                     ; 062AA
        neg.w   d1                              ; 062AE
        move.w  d0,-$24(a6)                     ; 062B0
        move.w  d1,-$1c(a6)                     ; 062B4
        cmpi.w  #$800,d1                        ; 062B8
        bge.b   l_000_062C4                     ; 062BC
        clr.w   -$1a(a6)                        ; 062BE
        bra.b   l_000_062CC                     ; 062C2
l_000_062C4:
        bsr.w   sub_000_06A32                   ; 062C4
        move.w  d0,-$1a(a6)                     ; 062C8
l_000_062CC:
        move.w  (StatusBits).l,d0               ; 062CC
        btst    #$6,d0                          ; 062D2
        beq.w   l_000_06812                     ; 062D6
        move.w  (dat_071_0029E).l,d0            ; 062DA
        btst    #$e,d0                          ; 062E0
        bne.w   l_000_06812                     ; 062E4
        tst.w   -$24(a6)                        ; 062E8
        bne.b   l_000_062FC                     ; 062EC
        movea.l -$30(a6),a0                     ; 062EE
        move.w  (a0),d0                         ; 062F2
        btst    #$3,d0                          ; 062F4
        beq.w   l_000_06750                     ; 062F8
l_000_062FC:
        movea.l (CockpitObject).l,a0            ; 062FC
        tst.l   $72(a0)                         ; 06302
        beq.w   l_000_06750                     ; 06306
        movea.l -$30(a6),a0                     ; 0630A
        move.w  (a0),d0                         ; 0630E
        btst    #$3,d0                          ; 06310
        beq.w   l_000_063F6                     ; 06314
        move.w  #$600,d0                        ; 06318
        move.w  d0,-$26(a6)                     ; 0631C
        ext.l   d0                              ; 06320
        movea.l (CockpitObject).l,a0            ; 06322
        sub.l   d0,$72(a0)                      ; 06328
        move.w  #$3a98,d0                       ; 0632C
        sub.w   -$1a(a6),d0                     ; 06330
        move.w  d0,-$16(a6)                     ; 06334
        cmpi.w  #$4650,d0                       ; 06338
        ble.b   l_000_06344                     ; 0633C
        move.w  #$4650,-$16(a6)                 ; 0633E
l_000_06344:
        movea.l (CockpitObject).l,a0            ; 06344
        move.b  $7c(a0),d0                      ; 0634A
        andi.b  #$70,d0                         ; 0634E
        tst.b   d0                              ; 06352
        bne.b   l_000_06360                     ; 06354
        move.w  -$16(a6),d0                     ; 06356
        asr.w   #$2,d0                          ; 0635A
        sub.w   d0,-$16(a6)                     ; 0635C
l_000_06360:
        movea.l -$2c(a6),a0                     ; 06360
        move.w  (a0),d0                         ; 06364
        btst    #$b,d0                          ; 06366
        beq.b   l_000_06376                     ; 0636A
        move.w  -$16(a6),d0                     ; 0636C
        asr.w   #$2,d0                          ; 06370
        sub.w   d0,-$16(a6)                     ; 06372
l_000_06376:
        move.w  -$1c(a6),d0                     ; 06376
        cmp.w   -$16(a6),d0                     ; 0637A
        bge.b   l_000_063D4                     ; 0637E
        tst.w   -$18(a6)                        ; 06380
        ble.b   l_000_06390                     ; 06384
        subi.w  #$78,-$18(a6)                   ; 06386
        bra.w   l_000_06812                     ; 0638C
l_000_06390:
        movea.l -$30(a6),a0                     ; 06390
        move.w  (a0),d0                         ; 06394
        btst    #$7,d0                          ; 06396
        bne.b   l_000_063B8                     ; 0639A
        cmpi.w  #$1d4c,-$1c(a6)                 ; 0639C
        ble.b   l_000_063AE                     ; 063A2
        subi.w  #$2d,-$18(a6)                   ; 063A4
        bra.w   l_000_06812                     ; 063AA
l_000_063AE:
        subi.w  #$36,-$18(a6)                   ; 063AE
        bra.w   l_000_06812                     ; 063B4
l_000_063B8:
        moveq   #-37,d0                         ; 063B8
        move.l  d0,-(a7)                        ; 063BA
        bsr.w   sub_000_069C6                   ; 063BC
        addq.l  #$4,a7                          ; 063C0
        movea.l (CockpitObject).l,a0            ; 063C2
        move.w  $26(a0),d0                      ; 063C8
        add.w   d0,-$18(a6)                     ; 063CC
        bra.w   l_000_06812                     ; 063D0
l_000_063D4:
        move.w  -$16(a6),d0                     ; 063D4
        ext.l   d0                              ; 063D8
        addi.l  #$3c,d0                         ; 063DA
        move.w  -$1c(a6),d1                     ; 063E0
        ext.l   d1                              ; 063E4
        cmp.l   d0,d1                           ; 063E6
        ble.w   l_000_06812                     ; 063E8
        addi.w  #$3c,-$18(a6)                   ; 063EC
        bra.w   l_000_06812                     ; 063F2
l_000_063F6:
        move.w  -$24(a6),d0                     ; 063F6
        move.w  d0,-$26(a6)                     ; 063FA
        tst.w   d0                              ; 063FE
        bpl.b   l_000_06406                     ; 06400
        neg.w   -$26(a6)                        ; 06402
l_000_06406:
        moveq   #$9,d0                          ; 06406
        move.w  -$26(a6),d1                     ; 06408
        asr.w   d0,d1                           ; 0640C
        move.w  d1,-$26(a6)                     ; 0640E
        ext.l   d1                              ; 06412
        movea.l (CockpitObject).l,a0            ; 06414
        sub.l   d1,$72(a0)                      ; 0641A
        tst.w   -$24(a6)                        ; 0641E
        bmi.w   l_000_06650                     ; 06422
        move.w  -$18(a6),d0                     ; 06426
        neg.w   d0                              ; 0642A
        movea.l -$30(a6),a0                     ; 0642C
        move.w  (a0),d1                         ; 06430
        move.w  d0,-$1c(a6)                     ; 06432
        btst    #$7,d1                          ; 06436
        bne.w   l_000_06560                     ; 0643A
        move.w  -$24(a6),d0                     ; 0643E
        asr.w   #$1,d0                          ; 06442
        move.w  -$24(a6),d1                     ; 06444
        asr.w   #$3,d1                          ; 06448
        sub.w   d1,d0                           ; 0644A
        move.w  d0,-$16(a6)                     ; 0644C
        asr.w   #$2,d0                          ; 06450
        move.w  -$16(a6),d1                     ; 06452
        sub.w   d0,d1                           ; 06456
        movea.l -$14(a6),a0                     ; 06458
        move.b  (a0),d0                         ; 0645C
        move.w  d1,-$16(a6)                     ; 0645E
        btst    #$0,d0                          ; 06462
        beq.b   l_000_0646E                     ; 06466
        asr.w   #$2,d1                          ; 06468
        move.w  d1,-$16(a6)                     ; 0646A
l_000_0646E:
        cmpi.w  #$1fef,-$16(a6)                 ; 0646E
        ble.b   l_000_0647C                     ; 06474
        move.w  #$1fef,-$16(a6)                 ; 06476
l_000_0647C:
        move.w  -$16(a6),d0                     ; 0647C
        sub.w   -$1a(a6),d0                     ; 06480
        movea.l -$2c(a6),a0                     ; 06484
        move.w  (a0),d1                         ; 06488
        move.w  d0,-$16(a6)                     ; 0648A
        btst    #$b,d1                          ; 0648E
        beq.b   l_000_0649A                     ; 06492
        asr.w   #$2,d0                          ; 06494
        sub.w   d0,-$16(a6)                     ; 06496
l_000_0649A:
        movea.l (CockpitObject).l,a0            ; 0649A
        move.b  $7c(a0),d0                      ; 064A0
        andi.b  #$70,d0                         ; 064A4
        tst.b   d0                              ; 064A8
        bne.b   l_000_064B6                     ; 064AA
        move.w  -$16(a6),d0                     ; 064AC
        asr.w   #$2,d0                          ; 064B0
        sub.w   d0,-$16(a6)                     ; 064B2
l_000_064B6:
        move.w  -$1c(a6),d0                     ; 064B6
        cmp.w   -$16(a6),d0                     ; 064BA
        bge.b   l_000_0650E                     ; 064BE
        tst.w   -$18(a6)                        ; 064C0
        ble.b   l_000_064CE                     ; 064C4
        subi.w  #$78,-$18(a6)                   ; 064C6
        bra.b   l_000_064F0                     ; 064CC
l_000_064CE:
        move.w  -$16(a6),d0                     ; 064CE
        ext.l   d0                              ; 064D2
        move.w  -$1c(a6),d1                     ; 064D4
        ext.l   d1                              ; 064D8
        sub.l   d1,d0                           ; 064DA
        cmpi.l  #$150,d0                        ; 064DC
        bge.b   l_000_064EA                     ; 064E2
        subq.w  #$5,-$18(a6)                    ; 064E4
        bra.b   l_000_064F0                     ; 064E8
l_000_064EA:
        subi.w  #$2a,-$18(a6)                   ; 064EA
l_000_064F0:
        move.w  -$18(a6),d0                     ; 064F0
        neg.w   d0                              ; 064F4
        move.w  d0,-$1c(a6)                     ; 064F6
        move.w  -$16(a6),d1                     ; 064FA
        cmp.w   d1,d0                           ; 064FE
        ble.w   l_000_06812                     ; 06500
        neg.w   d1                              ; 06504
        move.w  d1,-$18(a6)                     ; 06506
        bra.w   l_000_06812                     ; 0650A
l_000_0650E:
        move.w  -$16(a6),d0                     ; 0650E
        ext.l   d0                              ; 06512
        addi.l  #$3c,d0                         ; 06514
        move.w  -$1c(a6),d1                     ; 0651A
        ext.l   d1                              ; 0651E
        cmp.l   d0,d1                           ; 06520
        ble.w   l_000_06812                     ; 06522
        cmpi.l  #$1d4c,d1                       ; 06526
        ble.b   l_000_06538                     ; 0652C
        addi.w  #$52,-$18(a6)                   ; 0652E
        bra.w   l_000_06812                     ; 06534
l_000_06538:
        move.w  -$1c(a6),d0                     ; 06538
        ext.l   d0                              ; 0653C
        move.w  -$16(a6),d1                     ; 0653E
        ext.l   d1                              ; 06542
        sub.l   d1,d0                           ; 06544
        cmpi.l  #$1e0,d0                        ; 06546
        bge.b   l_000_06556                     ; 0654C
        addq.w  #$7,-$18(a6)                    ; 0654E
        bra.w   l_000_06812                     ; 06552
l_000_06556:
        addi.w  #$3c,-$18(a6)                   ; 06556
        bra.w   l_000_06812                     ; 0655C
l_000_06560:
        move.w  -$24(a6),d0                     ; 06560
        asr.w   #$3,d0                          ; 06564
        move.w  d0,-$16(a6)                     ; 06566
        asr.w   #$2,d0                          ; 0656A
        sub.w   d0,-$16(a6)                     ; 0656C
        movea.l -$10(a6),a0                     ; 06570
        move.b  (a0),d0                         ; 06574
        btst    #$3,d0                          ; 06576
        bne.b   l_000_0658C                     ; 0657A
        movea.l -$4(a6),a0                      ; 0657C
        move.b  (a0),d0                         ; 06580
        cmpi.b  #$c,d0                          ; 06582
        bge.b   l_000_0658C                     ; 06586
        clr.w   -$16(a6)                        ; 06588
l_000_0658C:
        movea.l -$10(a6),a0                     ; 0658C
        move.b  (a0),d0                         ; 06590
        andi.b  #$44,d0                         ; 06592
        tst.b   d0                              ; 06596
        bne.b   l_000_065A6                     ; 06598
        move.w  -$16(a6),d0                     ; 0659A
        asr.w   #$1,d0                          ; 0659E
        move.w  d0,-$16(a6)                     ; 065A0
        bra.b   l_000_065B6                     ; 065A4
l_000_065A6:
        movea.l -$14(a6),a0                     ; 065A6
        move.b  (a0),d0                         ; 065AA
        btst    #$0,d0                          ; 065AC
        beq.b   l_000_065B6                     ; 065B0
        clr.w   -$16(a6)                        ; 065B2
l_000_065B6:
        moveq   #$0,d0                          ; 065B6
        move.w  d0,-$22(a6)                     ; 065B8
        move.w  -$1c(a6),d0                     ; 065BC
        cmp.w   -$16(a6),d0                     ; 065C0
        bge.b   l_000_0660C                     ; 065C4
        tst.w   -$18(a6)                        ; 065C6
        ble.b   l_000_065D4                     ; 065CA
        move.w  #$ff88,-$22(a6)                 ; 065CC
        bra.b   l_000_06628                     ; 065D2
l_000_065D4:
        movea.l -$10(a6),a0                     ; 065D4
        move.b  (a0),d0                         ; 065D8
        btst    #$3,d0                          ; 065DA
        beq.b   l_000_065F6                     ; 065DE
        move.w  -$16(a6),d0                     ; 065E0
        sub.w   -$1c(a6),d0                     ; 065E4
        asr.w   #$8,d0                          ; 065E8
        addi.w  #$42,d0                         ; 065EA
        neg.w   d0                              ; 065EE
        move.w  d0,-$22(a6)                     ; 065F0
        bra.b   l_000_06628                     ; 065F4
l_000_065F6:
        move.w  -$16(a6),d0                     ; 065F6
        sub.w   -$1c(a6),d0                     ; 065FA
        asr.w   #$8,d0                          ; 065FE
        addi.w  #$16,d0                         ; 06600
        neg.w   d0                              ; 06604
        move.w  d0,-$22(a6)                     ; 06606
        bra.b   l_000_06628                     ; 0660A
l_000_0660C:
        move.w  -$16(a6),d0                     ; 0660C
        ext.l   d0                              ; 06610
        addi.l  #$f,d0                          ; 06612
        move.w  -$1c(a6),d1                     ; 06618
        ext.l   d1                              ; 0661C
        cmp.l   d0,d1                           ; 0661E
        ble.b   l_000_06628                     ; 06620
        move.w  #$f,-$22(a6)                    ; 06622
l_000_06628:
        move.w  -$22(a6),d0                     ; 06628
        ext.l   d0                              ; 0662C
        move.l  d0,-(a7)                        ; 0662E
        bsr.w   sub_000_069C6                   ; 06630
        addq.l  #$4,a7                          ; 06634
        tst.w   -$22(a6)                        ; 06636
        beq.w   l_000_06812                     ; 0663A
        movea.l (CockpitObject).l,a0            ; 0663E
        move.w  $26(a0),d0                      ; 06644
        add.w   d0,-$18(a6)                     ; 06648
        bra.w   l_000_06812                     ; 0664C
l_000_06650:
        tst.w   -$24(a6)                        ; 06650
        bpl.w   l_000_06812                     ; 06654
        movea.l -$30(a6),a0                     ; 06658
        move.w  (a0),d0                         ; 0665C
        btst    #$7,d0                          ; 0665E
        bne.b   l_000_066BC                     ; 06662
        tst.w   -$18(a6)                        ; 06664
        bpl.b   l_000_06674                     ; 06668
        addi.w  #$57,-$18(a6)                   ; 0666A
        bra.w   l_000_06812                     ; 06670
l_000_06674:
        move.w  -$24(a6),d0                     ; 06674
        neg.w   d0                              ; 06678
        move.w  d0,-$16(a6)                     ; 0667A
        asr.w   #$2,d0                          ; 0667E
        move.w  -$16(a6),d1                     ; 06680
        sub.w   d0,d1                           ; 06684
        move.w  d1,-$16(a6)                     ; 06686
        move.w  -$18(a6),d0                     ; 0668A
        cmp.w   d1,d0                           ; 0668E
        ble.b   l_000_0669C                     ; 06690
        subi.w  #$2a,-$18(a6)                   ; 06692
        bra.w   l_000_06812                     ; 06698
l_000_0669C:
        move.w  -$16(a6),d0                     ; 0669C
        ext.l   d0                              ; 066A0
        subi.l  #$2a,d0                         ; 066A2
        move.w  -$18(a6),d1                     ; 066A8
        cmp.w   d0,d1                           ; 066AC
        bge.w   l_000_06812                     ; 066AE
        addi.w  #$2a,-$18(a6)                   ; 066B2
        bra.w   l_000_06812                     ; 066B8
l_000_066BC:
        moveq   #$0,d0                          ; 066BC
        move.w  d0,-$22(a6)                     ; 066BE
        tst.w   -$18(a6)                        ; 066C2
        bpl.b   l_000_066D0                     ; 066C6
        move.w  #$3c,-$22(a6)                   ; 066C8
        bra.b   l_000_06728                     ; 066CE
l_000_066D0:
        move.w  -$24(a6),d0                     ; 066D0
        neg.w   d0                              ; 066D4
        asr.w   #$4,d0                          ; 066D6
        move.w  d0,-$16(a6)                     ; 066D8
        asr.w   #$2,d0                          ; 066DC
        move.w  -$16(a6),d1                     ; 066DE
        sub.w   d0,d1                           ; 066E2
        movea.l -$10(a6),a0                     ; 066E4
        move.b  (a0),d0                         ; 066E8
        move.w  d1,-$16(a6)                     ; 066EA
        btst    #$2,d0                          ; 066EE
        bne.b   l_000_066FA                     ; 066F2
        asr.w   #$1,d1                          ; 066F4
        move.w  d1,-$16(a6)                     ; 066F6
l_000_066FA:
        move.w  -$18(a6),d0                     ; 066FA
        cmp.w   -$16(a6),d0                     ; 066FE
        ble.b   l_000_0670C                     ; 06702
        move.w  #$ffea,-$22(a6)                 ; 06704
        bra.b   l_000_06728                     ; 0670A
l_000_0670C:
        move.w  -$16(a6),d0                     ; 0670C
        ext.l   d0                              ; 06710
        subi.l  #$16,d0                         ; 06712
        move.w  -$18(a6),d1                     ; 06718
        ext.l   d1                              ; 0671C
        cmp.l   d0,d1                           ; 0671E
        bge.b   l_000_06728                     ; 06720
        move.w  #$16,-$22(a6)                   ; 06722
l_000_06728:
        move.w  -$22(a6),d0                     ; 06728
        ext.l   d0                              ; 0672C
        move.l  d0,-(a7)                        ; 0672E
        bsr.w   sub_000_069C6                   ; 06730
        addq.l  #$4,a7                          ; 06734
        tst.w   -$22(a6)                        ; 06736
        beq.w   l_000_06812                     ; 0673A
        movea.l (CockpitObject).l,a0            ; 0673E
        move.w  $26(a0),d0                      ; 06744
        add.w   d0,-$18(a6)                     ; 06748
        bra.w   l_000_06812                     ; 0674C
l_000_06750:
        movea.l -$30(a6),a0                     ; 06750
        move.w  (a0),d0                         ; 06754
        btst    #$7,d0                          ; 06756
        bne.b   l_000_067D8                     ; 0675A
        tst.w   -$18(a6)                        ; 0675C
        ble.b   l_000_0679C                     ; 06760
        move.w  -$18(a6),d0                     ; 06762
        cmpi.w  #$90,d0                         ; 06766
        ble.b   l_000_06784                     ; 0676A
        cmpi.w  #$52,d0                         ; 0676C
        ble.b   l_000_0677C                     ; 06770
        subi.w  #$52,-$18(a6)                   ; 06772
        bra.w   l_000_06812                     ; 06778
l_000_0677C:
        clr.w   -$18(a6)                        ; 0677C
        bra.w   l_000_06812                     ; 06780
l_000_06784:
        move.w  -$18(a6),d0                     ; 06784
        cmpi.w  #$3c,d0                         ; 06788
        ble.b   l_000_06796                     ; 0678C
        subi.w  #$3c,-$18(a6)                   ; 0678E
        bra.b   l_000_06812                     ; 06794
l_000_06796:
        clr.w   -$18(a6)                        ; 06796
        bra.b   l_000_06812                     ; 0679A
l_000_0679C:
        cmpi.w  #$1d4c,-$1c(a6)                 ; 0679C
        ble.b   l_000_067AA                     ; 067A2
        addi.w  #$52,-$18(a6)                   ; 067A4
l_000_067AA:
        move.w  -$1c(a6),d0                     ; 067AA
        cmpi.w  #$5dc,d0                        ; 067AE
        bge.b   l_000_067C2                     ; 067B2
        cmpi.w  #$1e,d0                         ; 067B4
        ble.b   l_000_06812                     ; 067B8
        addi.w  #$1e,-$18(a6)                   ; 067BA
        bra.b   l_000_06812                     ; 067C0
l_000_067C2:
        cmpi.w  #$3c,-$1c(a6)                   ; 067C2
        ble.b   l_000_067D2                     ; 067C8
        addi.w  #$3c,-$18(a6)                   ; 067CA
        bra.b   l_000_06812                     ; 067D0
l_000_067D2:
        clr.w   -$18(a6)                        ; 067D2
        bra.b   l_000_06812                     ; 067D6
l_000_067D8:
        clr.l   -(a7)                           ; 067D8
        bsr.w   sub_000_069C6                   ; 067DA
        addq.l  #$4,a7                          ; 067DE
        tst.w   -$18(a6)                        ; 067E0
        ble.b   l_000_067FE                     ; 067E4
        move.w  -$18(a6),d0                     ; 067E6
        cmpi.w  #$f,d0                          ; 067EA
        ble.b   l_000_067F8                     ; 067EE
        subi.w  #$f,-$18(a6)                    ; 067F0
        bra.b   l_000_06812                     ; 067F6
l_000_067F8:
        clr.w   -$18(a6)                        ; 067F8
        bra.b   l_000_06812                     ; 067FC
l_000_067FE:
        cmpi.w  #$f,-$1c(a6)                    ; 067FE
        ble.b   l_000_0680E                     ; 06804
        addi.w  #$f,-$18(a6)                    ; 06806
        bra.b   l_000_06812                     ; 0680C
l_000_0680E:
        clr.w   -$18(a6)                        ; 0680E
l_000_06812:
        move.w  -$18(a6),d0                     ; 06812
        neg.w   d0                              ; 06816
        move.w  d0,-$1c(a6)                     ; 06818
        tst.w   -$32(a6)                        ; 0681C
        bne.b   l_000_06868                     ; 06820
        cmpi.w  #$20d0,d0                       ; 06822
        blt.b   l_000_06858                     ; 06826
        move.w  (dat_071_002A2).l,d0            ; 06828
        btst    #$e,d0                          ; 0682E
        bne.b   l_000_06868                     ; 06832
        ori.w   #$4000,d0                       ; 06834
        move.w  d0,(dat_071_002A2).l            ; 06838
        move.b  #$3,(ShakeKind).l               ; 0683E
        move.b  #$fa,(EngineSoundRequest).l     ; 06846
        move.b  #$2,(dat_071_00167).l           ; 0684E
        bra.b   l_000_06868                     ; 06856
l_000_06858:
        move.w  (dat_071_002A2).l,d0            ; 06858
        andi.w  #$bfff,d0                       ; 0685E
        move.w  d0,(dat_071_002A2).l            ; 06862
l_000_06868:
        clr.w   -$16(a6)                        ; 06868
        movea.l -$30(a6),a0                     ; 0686C
        move.w  (a0),d0                         ; 06870
        andi.w  #$c000,d0                       ; 06872
        cmpi.w  #$c000,d0                       ; 06876
        bne.b   l_000_06894                     ; 0687A
        moveq   #$3,d0                          ; 0687C
        move.l  d0,-(a7)                        ; 0687E
        moveq   #$7,d0                          ; 06880
        move.l  d0,-(a7)                        ; 06882
        move.l  -$20(a6),-(a7)                  ; 06884
        bsr.w   Decay                           ; 06888
        lea.l   $c(a7),a7                       ; 0688C
        bra.w   l_000_06940                     ; 06890
l_000_06894:
        movea.l -$30(a6),a0                     ; 06894
        move.w  (a0),d0                         ; 06898
        btst    #$7,d0                          ; 0689A
        beq.b   l_000_068CC                     ; 0689E
        movea.l -$2c(a6),a0                     ; 068A0
        move.w  (a0),d0                         ; 068A4
        btst    #$b,d0                          ; 068A6
        beq.b   l_000_068CC                     ; 068AA
        movea.l -$20(a6),a0                     ; 068AC
        move.w  (a0),d0                         ; 068B0
        cmpi.w  #$40,d0                         ; 068B2
        ble.b   l_000_068CC                     ; 068B6
        moveq   #$4,d0                          ; 068B8
        move.l  d0,-(a7)                        ; 068BA
        moveq   #$f,d0                          ; 068BC
        move.l  d0,-(a7)                        ; 068BE
        move.l  a0,-(a7)                        ; 068C0
        bsr.w   Decay                           ; 068C2
        lea.l   $c(a7),a7                       ; 068C6
        bra.b   l_000_06940                     ; 068CA
l_000_068CC:
        movea.l -$30(a6),a0                     ; 068CC
        move.w  (a0),d0                         ; 068D0
        btst    #$7,d0                          ; 068D2
        beq.b   l_000_068FE                     ; 068D6
        movea.l (CockpitObject).l,a0            ; 068D8
        move.b  $7c(a0),d0                      ; 068DE
        btst    #$7,d0                          ; 068E2
        beq.b   l_000_068FE                     ; 068E6
        moveq   #$5,d0                          ; 068E8
        move.l  d0,-(a7)                        ; 068EA
        moveq   #$1f,d0                         ; 068EC
        move.l  d0,-(a7)                        ; 068EE
        move.l  -$20(a6),-(a7)                  ; 068F0
        bsr.w   Decay                           ; 068F4
        lea.l   $c(a7),a7                       ; 068F8
        bra.b   l_000_06940                     ; 068FC
l_000_068FE:
        movea.l -$14(a6),a0                     ; 068FE
        move.b  (a0),d0                         ; 06902
        btst    #$0,d0                          ; 06904
        beq.b   l_000_06920                     ; 06908
        moveq   #$2,d0                          ; 0690A
        move.l  d0,-(a7)                        ; 0690C
        moveq   #$3,d0                          ; 0690E
        move.l  d0,-(a7)                        ; 06910
        move.l  -$20(a6),-(a7)                  ; 06912
        bsr.w   Decay                           ; 06916
        lea.l   $c(a7),a7                       ; 0691A
        bra.b   l_000_06940                     ; 0691E
l_000_06920:
        movea.l -$10(a6),a0                     ; 06920
        move.b  (a0),d0                         ; 06924
        btst    #$3,d0                          ; 06926
        beq.b   l_000_06934                     ; 0692A
        move.w  #$6c,-$16(a6)                   ; 0692C
        bra.b   l_000_06940                     ; 06932
l_000_06934:
        move.w  -$18(a6),d0                     ; 06934
        neg.w   d0                              ; 06938
        movea.l -$20(a6),a0                     ; 0693A
        move.w  d0,(a0)                         ; 0693E
l_000_06940:
        tst.w   -$16(a6)                        ; 06940
        beq.b   l_000_0699C                     ; 06944
        movea.l -$10(a6),a0                     ; 06946
        move.b  (a0),d0                         ; 0694A
        btst    #$3,d0                          ; 0694C
        beq.b   l_000_06990                     ; 06950
        movea.l -$4(a6),a0                      ; 06952
        move.b  (a0),d0                         ; 06956
        ext.w   d0                              ; 06958
        ext.l   d0                              ; 0695A
        move.w  -$16(a6),d1                     ; 0695C
        ext.l   d1                              ; 06960
        cmp.l   d1,d0                           ; 06962
        bge.b   l_000_06982                     ; 06964
        neg.l   d1                              ; 06966
        cmp.l   d1,d0                           ; 06968
        ble.b   l_000_06982                     ; 0696A
        moveq   #$3,d0                          ; 0696C
        move.l  d0,-(a7)                        ; 0696E
        moveq   #$7,d0                          ; 06970
        move.l  d0,-(a7)                        ; 06972
        move.l  -$20(a6),-(a7)                  ; 06974
        bsr.w   Decay                           ; 06978
        lea.l   $c(a7),a7                       ; 0697C
        bra.b   l_000_0699C                     ; 06980
l_000_06982:
        move.w  -$18(a6),d0                     ; 06982
        neg.w   d0                              ; 06986
        movea.l -$20(a6),a0                     ; 06988
        move.w  d0,(a0)                         ; 0698C
        bra.b   l_000_0699C                     ; 0698E
l_000_06990:
        move.w  -$18(a6),d0                     ; 06990
        neg.w   d0                              ; 06994
        movea.l -$20(a6),a0                     ; 06996
        move.w  d0,(a0)                         ; 0699A
l_000_0699C:
        jsr     (ClimbDivePhysics).l            ; 0699C
        movea.l (CockpitObject).l,a0            ; 069A2
        move.w  $78(a0),d0                      ; 069A8
        movea.l -$20(a6),a0                     ; 069AC
        move.w  (a0),d1                         ; 069B0
        add.w   d1,d0                           ; 069B2
        movea.l (CockpitObject).l,a0            ; 069B4
        move.w  d0,$6e(a0)                      ; 069BA
        movem.l (a7)+,d2/a2-a5                  ; 069BE
        unlk    a6                              ; 069C2
        rts                                     ; 069C4
sub_000_069C6:
        link.w  a6,#$fffe                       ; 069C6
        movea.l (CockpitObject).l,a0            ; 069CA
        move.w  $26(a0),d0                      ; 069D0
        move.w  d0,$0(a7)                       ; 069D4
        sub.w   $a(a6),d0                       ; 069D8
        asr.w   #$3,d0                          ; 069DC
        move.w  $0(a7),d1                       ; 069DE
        sub.w   d0,d1                           ; 069E2
        movea.l (CockpitObject).l,a0            ; 069E4
        move.w  d1,$26(a0)                      ; 069EA
        unlk    a6                              ; 069EE
        rts                                     ; 069F0

;-------------------------------------------------------------------------------
; Decay - Decay(p, limit, shift): *p -= *p >> shift while |*p| > limit; then 0.
;-------------------------------------------------------------------------------
Decay:
        link.w  a6,#$fffe                       ; 069F2
        movea.l $8(a6),a0                       ; 069F6
        move.w  (a0),d0                         ; 069FA
        ext.l   d0                              ; 069FC
        move.w  $e(a6),d1                       ; 069FE
        ext.l   d1                              ; 06A02
        cmp.l   d1,d0                           ; 06A04
        bgt.b   l_000_06A0E                     ; 06A06
        neg.l   d1                              ; 06A08
        cmp.l   d1,d0                           ; 06A0A
        bge.b   l_000_06A28                     ; 06A0C
l_000_06A0E:
        movea.l $8(a6),a0                       ; 06A0E
        move.w  (a0),d0                         ; 06A12
        move.w  $12(a6),d1                      ; 06A14
        move.w  d0,$0(a7)                       ; 06A18
        asr.w   d1,d0                           ; 06A1C
        move.w  $0(a7),d1                       ; 06A1E
        sub.w   d0,d1                           ; 06A22
        move.w  d1,(a0)                         ; 06A24
        bra.b   l_000_06A2E                     ; 06A26
l_000_06A28:
        movea.l $8(a6),a0                       ; 06A28
        clr.w   (a0)                            ; 06A2C
l_000_06A2E:
        unlk    a6                              ; 06A2E
        rts                                     ; 06A30
sub_000_06A32:
        link.w  a6,#$fff6                       ; 06A32
        movem.l d2,-(a7)                        ; 06A36
        movea.l (CockpitObject).l,a0            ; 06A3A
        move.w  $66(a0),d0                      ; 06A40
        move.w  d0,-$2(a6)                      ; 06A44
        cmpi.w  #$3840,d0                       ; 06A48
        blt.b   l_000_06A54                     ; 06A4C
        subi.w  #$7080,-$2(a6)                  ; 06A4E
l_000_06A54:
        move.w  -$2(a6),d0                      ; 06A54
        asr.w   #$1,d0                          ; 06A58
        movea.l (CockpitObject).l,a0            ; 06A5A
        move.w  $6a(a0),d1                      ; 06A60
        move.w  d0,-$2(a6)                      ; 06A64
        move.w  d1,-$4(a6)                      ; 06A68
        cmpi.w  #$3840,d1                       ; 06A6C
        blt.b   l_000_06A7C                     ; 06A70
        move.w  #$7080,d0                       ; 06A72
        sub.w   d1,d0                           ; 06A76
        move.w  d0,-$4(a6)                      ; 06A78
l_000_06A7C:
        move.w  -$4(a6),d0                      ; 06A7C
        cmpi.w  #$1c20,d0                       ; 06A80
        blt.b   l_000_06A90                     ; 06A84
        move.w  #$3840,d1                       ; 06A86
        sub.w   d0,d1                           ; 06A8A
        move.w  d1,-$4(a6)                      ; 06A8C
l_000_06A90:
        move.w  -$4(a6),d0                      ; 06A90
        asr.w   #$3,d0                          ; 06A94
        movea.l (CockpitObject).l,a0            ; 06A96
        move.w  $56(a0),d1                      ; 06A9C
        move.w  d0,-$4(a6)                      ; 06AA0
        move.w  d1,-$6(a6)                      ; 06AA4
        tst.w   d1                              ; 06AA8
        bpl.b   l_000_06AB0                     ; 06AAA
        neg.w   -$6(a6)                         ; 06AAC
l_000_06AB0:
        move.w  -$6(a6),d0                      ; 06AB0
        asl.w   #$1,d0                          ; 06AB4
        add.w   -$4(a6),d0                      ; 06AB6
        sub.w   -$2(a6),d0                      ; 06ABA
        move.l  (dat_071_000CA).l,d1            ; 06ABE
        movea.l (CockpitObject).l,a0            ; 06AC4
        sub.l   $18(a0),d1                      ; 06ACA
        move.w  $2(a0),d2                       ; 06ACE
        move.w  d0,-$6(a6)                      ; 06AD2
        move.l  d1,-$a(a6)                      ; 06AD6
        btst    #$3,d2                          ; 06ADA
        beq.b   l_000_06AEA                     ; 06ADE
        moveq   #$b,d0                          ; 06AE0
        asr.l   d0,d1                           ; 06AE2
        move.l  d1,-$a(a6)                      ; 06AE4
        bra.b   l_000_06AF6                     ; 06AE8
l_000_06AEA:
        moveq   #$d,d0                          ; 06AEA
        move.l  -$a(a6),d1                      ; 06AEC
        asr.l   d0,d1                           ; 06AF0
        move.l  d1,-$a(a6)                      ; 06AF2
l_000_06AF6:
        move.w  -$6(a6),d0                      ; 06AF6
        ext.l   d0                              ; 06AFA
        add.l   -$a(a6),d0                      ; 06AFC
        move.w  d0,-$6(a6)                      ; 06B00
        ext.l   d0                              ; 06B04
        movem.l (a7)+,d2                        ; 06B06
        unlk    a6                              ; 06B0A
        rts                                     ; 06B0C

;-------------------------------------------------------------------------------
; FlyAircraft - The flight model for one aircraft (CurrentObject; dat_002_00008 = its record):
; the nose's direction is the third column of its +$92 matrix (M13, M23, M33, into
; dat_071_00470-00474); ScaleToLength makes it a velocity of the aircraft's speed (+$6E) along
; the nose (dat_071_0041C-00420); each part of the velocity then moves part of the way there
; from the present velocity (EaseVelocity), +$76 is added to the vertical part (unless bit 0 of
; dat_071_0016F), and the result is the new velocity (+$3E, +$42, +$46). Then the undercarriage
; / landing and the rest (dat_071_0016F modes 1 and 3 add or take away $6000 vertically; type
; $14 uses +$4E)...
;-------------------------------------------------------------------------------
FlyAircraft:
        link.w  a6,#$ffca                       ; 06B0E
        movem.l d2-d4/a2-a3,-(a7)               ; 06B12
        move.w  (CurrentObject).l,d0            ; 06B16
        moveq   #$9,d1                          ; 06B1C
        move.w  d0,-$24(a6)                     ; 06B1E
        ext.l   d0                              ; 06B22
        asl.l   d1,d0                           ; 06B24
        movea.l d0,a0                           ; 06B26
        adda.l  #ObjectTable,a0                 ; 06B28
        move.l  a0,d0                           ; 06B2E
        move.l  d0,(CockpitObject).l            ; 06B30
        movea.l d0,a0                           ; 06B36
        move.l  a0,-$28(a6)                     ; 06B38
        addq.l  #$2,a0                          ; 06B3C
        movea.l d0,a1                           ; 06B3E
        addq.l  #$4,a1                          ; 06B40
        movea.l d0,a2                           ; 06B42
        adda.w  #$20,a2                         ; 06B44
        movea.l d0,a3                           ; 06B48
        move.w  $96(a3),d1                      ; 06B4A
        move.w  d1,(dat_071_00470).l            ; 06B4E
        move.w  $96(a3),d2                      ; 06B54
        move.w  d2,(dat_071_00470).l            ; 06B58
        move.w  $9c(a3),d1                      ; 06B5E
        move.w  d1,(dat_071_00472).l            ; 06B62
        move.w  $a2(a3),d2                      ; 06B68
        move.w  d2,(dat_071_00474).l            ; 06B6C
        move.w  $6e(a3),d1                      ; 06B72
        neg.w   d1                              ; 06B76
        move.w  d1,-$22(a6)                     ; 06B78
        ext.l   d1                              ; 06B7C
        move.w  (dat_071_00470).l,d3            ; 06B7E
        ext.l   d3                              ; 06B84
        move.w  (dat_071_00472).l,d4            ; 06B86
        ext.l   d4                              ; 06B8C
        ext.l   d2                              ; 06B8E
        move.l  d2,-(a7)                        ; 06B90
        move.l  d4,-(a7)                        ; 06B92
        move.l  d3,-(a7)                        ; 06B94
        move.l  d1,-(a7)                        ; 06B96
        move.l  a0,-$2c(a6)                     ; 06B98
        move.l  a1,-$30(a6)                     ; 06B9C
        move.l  a2,-$34(a6)                     ; 06BA0
        jsr     (ScaleToLength).l               ; 06BA4
        lea.l   $10(a7),a7                      ; 06BAA
        move.w  (dat_071_0041C).l,-$2(a6)       ; 06BAE
        move.w  (dat_071_0041E).l,-$4(a6)       ; 06BB6
        move.w  (dat_071_00420).l,-$6(a6)       ; 06BBE
        movea.l -$2c(a6),a0                     ; 06BC6
        move.w  (a0),d0                         ; 06BCA
        btst    #$7,d0                          ; 06BCC
        bne.b   l_000_06C42                     ; 06BD0
        movea.l (CockpitObject).l,a0            ; 06BD2
        move.l  $3e(a0),d0                      ; 06BD8
        asr.l   #$2,d0                          ; 06BDC
        move.l  $46(a0),d1                      ; 06BDE
        asr.l   #$2,d1                          ; 06BE2
        move.w  d0,-$8(a6)                      ; 06BE4
        move.w  d1,-$c(a6)                      ; 06BE8
        tst.b   (dat_071_00170).l               ; 06BEC
        beq.b   l_000_06C0E                     ; 06BF2
        tst.w   -$24(a6)                        ; 06BF4
        bne.b   l_000_06C0E                     ; 06BF8
        move.l  $3e(a0),d0                      ; 06BFA
        asr.l   #$6,d0                          ; 06BFE
        move.l  $46(a0),d1                      ; 06C00
        asr.l   #$6,d1                          ; 06C04
        move.w  d0,-$8(a6)                      ; 06C06
        move.w  d1,-$c(a6)                      ; 06C0A
l_000_06C0E:
        move.w  -$2(a6),d0                      ; 06C0E
        ext.l   d0                              ; 06C12
        move.w  -$8(a6),d1                      ; 06C14
        ext.l   d1                              ; 06C18
        move.l  d1,-(a7)                        ; 06C1A
        move.l  d0,-(a7)                        ; 06C1C
        bsr.w   EaseVelocity                    ; 06C1E
        addq.l  #$8,a7                          ; 06C22
        move.w  -$6(a6),d1                      ; 06C24
        ext.l   d1                              ; 06C28
        move.w  -$c(a6),d2                      ; 06C2A
        ext.l   d2                              ; 06C2E
        move.l  d2,-(a7)                        ; 06C30
        move.l  d1,-(a7)                        ; 06C32
        move.w  d0,-$2(a6)                      ; 06C34
        bsr.w   EaseVelocity                    ; 06C38
        addq.l  #$8,a7                          ; 06C3C
        move.w  d0,-$6(a6)                      ; 06C3E
l_000_06C42:
        movea.l (CockpitObject).l,a0            ; 06C42
        move.l  $42(a0),d0                      ; 06C48
        asr.l   #$2,d0                          ; 06C4C
        move.w  d0,-$a(a6)                      ; 06C4E
        tst.b   (dat_071_00170).l               ; 06C52
        beq.b   l_000_06C66                     ; 06C58
        tst.w   -$24(a6)                        ; 06C5A
        bne.b   l_000_06C66                     ; 06C5E
        asr.w   #$4,d0                          ; 06C60
        move.w  d0,-$a(a6)                      ; 06C62
l_000_06C66:
        move.w  -$4(a6),d0                      ; 06C66
        ext.l   d0                              ; 06C6A
        move.w  -$a(a6),d1                      ; 06C6C
        ext.l   d1                              ; 06C70
        move.l  d1,-(a7)                        ; 06C72
        move.l  d0,-(a7)                        ; 06C74
        bsr.w   EaseVelocity                    ; 06C76
        addq.l  #$8,a7                          ; 06C7A
        move.b  (dat_071_0016F).l,d1            ; 06C7C
        move.w  d0,-$4(a6)                      ; 06C82
        btst    #$0,d1                          ; 06C86
        bne.b   l_000_06C9A                     ; 06C8A
        movea.l (CockpitObject).l,a0            ; 06C8C
        move.w  $76(a0),d1                      ; 06C92
        add.w   d1,-$4(a6)                      ; 06C96
l_000_06C9A:
        move.w  -$2(a6),d0                      ; 06C9A
        ext.l   d0                              ; 06C9E
        asl.l   #$2,d0                          ; 06CA0
        move.w  -$4(a6),d1                      ; 06CA2
        ext.l   d1                              ; 06CA6
        asl.l   #$2,d1                          ; 06CA8
        move.w  -$6(a6),d2                      ; 06CAA
        ext.l   d2                              ; 06CAE
        asl.l   #$2,d2                          ; 06CB0
        move.l  #$6000,-$1c(a6)                 ; 06CB2
        move.l  d0,-$10(a6)                     ; 06CBA
        move.l  d1,-$14(a6)                     ; 06CBE
        move.l  d2,-$18(a6)                     ; 06CC2
        tst.b   (dat_071_00170).l               ; 06CC6
        beq.b   l_000_06D00                     ; 06CCC
        tst.w   -$24(a6)                        ; 06CCE
        bne.b   l_000_06D00                     ; 06CD2
        move.w  -$2(a6),d0                      ; 06CD4
        ext.l   d0                              ; 06CD8
        asl.l   #$6,d0                          ; 06CDA
        move.w  -$4(a6),d1                      ; 06CDC
        ext.l   d1                              ; 06CE0
        asl.l   #$6,d1                          ; 06CE2
        move.w  -$6(a6),d2                      ; 06CE4
        ext.l   d2                              ; 06CE8
        asl.l   #$6,d2                          ; 06CEA
        move.l  #$60000,-$1c(a6)                ; 06CEC
        move.l  d0,-$10(a6)                     ; 06CF4
        move.l  d1,-$14(a6)                     ; 06CF8
        move.l  d2,-$18(a6)                     ; 06CFC
l_000_06D00:
        move.l  -$10(a6),d0                     ; 06D00
        neg.l   d0                              ; 06D04
        movea.l (CockpitObject).l,a0            ; 06D06
        move.l  d0,$3e(a0)                      ; 06D0C
        move.l  -$14(a6),d0                     ; 06D10
        neg.l   d0                              ; 06D14
        movea.l (CockpitObject).l,a0            ; 06D16
        move.l  d0,$42(a0)                      ; 06D1C
        move.l  -$18(a6),d0                     ; 06D20
        neg.l   d0                              ; 06D24
        movea.l (CockpitObject).l,a0            ; 06D26
        move.l  d0,$46(a0)                      ; 06D2C
        tst.b   (WorldFrozen).l                 ; 06D30
        beq.b   l_000_06D42                     ; 06D36
        moveq   #$0,d0                          ; 06D38
        move.l  d0,-$1c(a6)                     ; 06D3A
        move.l  d0,-$14(a6)                     ; 06D3E
l_000_06D42:
        tst.w   -$24(a6)                        ; 06D42
        bne.b   l_000_06D6E                     ; 06D46
        move.b  (dat_071_0016F).l,d0            ; 06D48
        subq.b  #$3,d0                          ; 06D4E
        bne.b   l_000_06D5C                     ; 06D50
        move.l  -$1c(a6),d0                     ; 06D52
        sub.l   d0,-$14(a6)                     ; 06D56
        bra.b   l_000_06D6E                     ; 06D5A
l_000_06D5C:
        move.b  (dat_071_0016F).l,d0            ; 06D5C
        subq.b  #$1,d0                          ; 06D62
        bne.b   l_000_06D6E                     ; 06D64
        move.l  -$1c(a6),d0                     ; 06D66
        add.l   d0,-$14(a6)                     ; 06D6A
l_000_06D6E:
        movea.l -$30(a6),a0                     ; 06D6E
        move.b  (a0),d0                         ; 06D72
        andi.b  #$c0,d0                         ; 06D74
        tst.b   d0                              ; 06D78
        beq.w   l_000_06E1A                     ; 06D7A
        movea.l (CockpitObject).l,a0            ; 06D7E
        move.b  $7c(a0),d0                      ; 06D84
        andi.b  #$70,d0                         ; 06D88
        tst.b   d0                              ; 06D8C
        bne.b   l_000_06DF0                     ; 06D8E
        move.b  $62(a0),d0                      ; 06D90
        cmpi.b  #$14,d0                         ; 06D94
        bne.b   l_000_06DC2                     ; 06D98
        move.w  $4e(a0),d0                      ; 06D9A
        ext.l   d0                              ; 06D9E
        asl.l   #$8,d0                          ; 06DA0
        addi.l  #$a8c,d0                        ; 06DA2
        move.l  d0,-$20(a6)                     ; 06DA8
        cmpi.l  #$a8c,d0                        ; 06DAC
        bge.w   l_000_06E6E                     ; 06DB2
        move.l  #$a8c,-$20(a6)                  ; 06DB6
        bra.w   l_000_06E6E                     ; 06DBE
l_000_06DC2:
        movea.l (CockpitObject).l,a0            ; 06DC2
        move.w  $4e(a0),d0                      ; 06DC8
        ext.l   d0                              ; 06DCC
        asl.l   #$8,d0                          ; 06DCE
        addi.l  #$708,d0                        ; 06DD0
        move.l  d0,-$20(a6)                     ; 06DD6
        cmpi.l  #$708,d0                        ; 06DDA
        bge.w   l_000_06E6E                     ; 06DE0
        move.l  #$708,-$20(a6)                  ; 06DE4
        bra.w   l_000_06E6E                     ; 06DEC
l_000_06DF0:
        movea.l (CockpitObject).l,a0            ; 06DF0
        move.w  $4e(a0),d0                      ; 06DF6
        ext.l   d0                              ; 06DFA
        asl.l   #$8,d0                          ; 06DFC
        addi.l  #$2ee,d0                        ; 06DFE
        move.l  d0,-$20(a6)                     ; 06E04
        cmpi.l  #$2ee,d0                        ; 06E08
        bge.b   l_000_06E6E                     ; 06E0E
        move.l  #$2ee,-$20(a6)                  ; 06E10
        bra.b   l_000_06E6E                     ; 06E18
l_000_06E1A:
        movea.l (CockpitObject).l,a0            ; 06E1A
        move.b  $62(a0),d0                      ; 06E20
        andi.b  #$f0,d0                         ; 06E24
        tst.b   d0                              ; 06E28
        bne.b   l_000_06E36                     ; 06E2A
        move.l  #$fffffe00,-$20(a6)             ; 06E2C
        bra.b   l_000_06E6E                     ; 06E34
l_000_06E36:
        movea.l (CockpitObject).l,a0            ; 06E36
        move.b  $7c(a0),d0                      ; 06E3C
        andi.b  #$70,d0                         ; 06E40
        tst.b   d0                              ; 06E44
        bne.b   l_000_06E66                     ; 06E46
        move.b  $62(a0),d0                      ; 06E48
        cmpi.b  #$14,d0                         ; 06E4C
        bne.b   l_000_06E5C                     ; 06E50
        move.l  #$a8c,-$20(a6)                  ; 06E52
        bra.b   l_000_06E6E                     ; 06E5A
l_000_06E5C:
        move.l  #$708,-$20(a6)                  ; 06E5C
        bra.b   l_000_06E6E                     ; 06E64
l_000_06E66:
        move.l  #$2ee,-$20(a6)                  ; 06E66
l_000_06E6E:
        movea.l (CockpitObject).l,a0            ; 06E6E
        move.l  $18(a0),d0                      ; 06E74
        sub.l   -$14(a6),d0                     ; 06E78
        movea.l (CockpitObject).l,a0            ; 06E7C
        move.l  d0,$18(a0)                      ; 06E82
        move.l  -$20(a6),d1                     ; 06E86
        cmp.l   d1,d0                           ; 06E8A
        bgt.w   l_000_071AE                     ; 06E8C
        movea.l -$34(a6),a0                     ; 06E90
        move.b  (a0),d0                         ; 06E94
        andi.b  #$fb,d0                         ; 06E96
        move.b  d0,(a0)                         ; 06E9A
        movea.l (CockpitObject).l,a0            ; 06E9C
        move.b  $62(a0),d0                      ; 06EA2
        andi.b  #$f0,d0                         ; 06EA6
        tst.b   d0                              ; 06EAA
        beq.b   l_000_06EB8                     ; 06EAC
        movea.l (CockpitObject).l,a0            ; 06EAE
        move.l  d1,$18(a0)                      ; 06EB4
l_000_06EB8:
        movea.l -$30(a6),a0                     ; 06EB8
        move.b  (a0),d0                         ; 06EBC
        andi.b  #$c0,d0                         ; 06EBE
        tst.b   d0                              ; 06EC2
        bne.b   l_000_06F30                     ; 06EC4
        movea.l -$2c(a6),a0                     ; 06EC6
        move.w  (a0),d0                         ; 06ECA
        btst    #$7,d0                          ; 06ECC
        beq.b   l_000_06EE4                     ; 06ED0
        movea.l (CockpitObject).l,a0            ; 06ED2
        move.w  $4c(a0),d0                      ; 06ED8
        andi.w  #$7,d0                          ; 06EDC
        tst.w   d0                              ; 06EE0
        bne.b   l_000_06F30                     ; 06EE2
l_000_06EE4:
        jsr     (sub_028_0115A).l               ; 06EE4
        movea.l -$30(a6),a0                     ; 06EEA
        move.b  (a0),d0                         ; 06EEE
        btst    #$1,d0                          ; 06EF0
        beq.b   l_000_06F30                     ; 06EF4
        movea.l (CockpitObject).l,a0            ; 06EF6
        move.b  $7c(a0),d0                      ; 06EFC
        move.b  d0,$14(a7)                      ; 06F00
        andi.b  #$70,d0                         ; 06F04
        tst.b   d0                              ; 06F08
        bne.b   l_000_06F30                     ; 06F0A
        move.b  $14(a7),d0                      ; 06F0C
        ori.b   #$80,d0                         ; 06F10
        movea.l (CockpitObject).l,a0            ; 06F14
        move.b  d0,$7c(a0)                      ; 06F1A
        tst.w   -$24(a6)                        ; 06F1E
        bne.b   l_000_06F30                     ; 06F22
        movea.l -$34(a6),a0                     ; 06F24
        move.b  (a0),d0                         ; 06F28
        ori.b   #$1,d0                          ; 06F2A
        move.b  d0,(a0)                         ; 06F2E
l_000_06F30:
        tst.w   -$24(a6)                        ; 06F30
        bne.w   l_000_07180                     ; 06F34
        movea.l -$28(a6),a0                     ; 06F38
        move.w  (a0),d0                         ; 06F3C
        btst    #$9,d0                          ; 06F3E
        bne.w   l_000_07104                     ; 06F42
        movea.l -$2c(a6),a0                     ; 06F46
        move.w  (a0),d0                         ; 06F4A
        btst    #$7,d0                          ; 06F4C
        bne.w   l_000_07056                     ; 06F50
        ori.w   #$80,d0                         ; 06F54
        move.w  d0,(a0)                         ; 06F58
        movea.l (CockpitObject).l,a0            ; 06F5A
        clr.w   $26(a0)                         ; 06F60
        jsr     (ReadTime).l                    ; 06F64
        move.l  (TimeSeconds).l,(FlightStartTime).l ; 06F6A
        moveq   #$0,d0                          ; 06F74
        move.b  d0,(dat_071_0016F).l            ; 06F76
        moveq   #$1,d0                          ; 06F7C
        move.b  d0,(ShakeKind).l                ; 06F7E
        cmpi.w  #$240,-$4(a6)                   ; 06F84
        blt.b   l_000_06FCE                     ; 06F8A
        move.b  (dat_071_0026A).l,d0            ; 06F8C
        tst.b   d0                              ; 06F92
        bne.w   l_000_07178                     ; 06F94
        movea.l -$28(a6),a0                     ; 06F98
        move.w  (a0),d0                         ; 06F9C
        ori.w   #$200,d0                        ; 06F9E
        move.w  d0,(a0)                         ; 06FA2
        movea.l (ConfigBuffer).l,a0             ; 06FA4
        move.w  $46(a0),d0                      ; 06FAA
        addq.w  #$1,d0                          ; 06FAE
        movea.l (ConfigBuffer).l,a0             ; 06FB0
        move.w  d0,$46(a0)                      ; 06FB6
        move.b  #$1,(ConfigChanged).l           ; 06FBA
        move.b  #$4,(MissionResult).l           ; 06FC2
        bra.w   l_000_07178                     ; 06FCA
l_000_06FCE:
        tst.w   (Player_6E).l                   ; 06FCE
        beq.w   l_000_07178                     ; 06FD4
        move.w  (Player_6E).l,(Player_6C).l     ; 06FD8
        move.b  #$fe,(EngineSoundRequest).l     ; 06FE2
        movea.l -$30(a6),a0                     ; 06FEA
        move.b  (a0),d0                         ; 06FEE
        btst    #$1,d0                          ; 06FF0
        bne.b   l_000_07008                     ; 06FF4
        movea.l (CockpitObject).l,a0            ; 06FF6
        move.b  $7c(a0),d0                      ; 06FFC
        andi.b  #$70,d0                         ; 07000
        tst.b   d0                              ; 07004
        beq.b   l_000_0702E                     ; 07006
l_000_07008:
        movea.l (CockpitObject).l,a0            ; 07008
        move.w  $6e(a0),d0                      ; 0700E
        cmpi.w  #$3c0,d0                        ; 07012
        blt.b   l_000_0702E                     ; 07016
        movea.l -$2c(a6),a0                     ; 07018
        move.w  (a0),d0                         ; 0701C
        ori.w   #$1000,d0                       ; 0701E
        move.w  d0,(a0)                         ; 07022
        move.w  (CurrentObjectOffset).l,(dat_073_0165A).l ; 07024
l_000_0702E:
        cmpi.w  #$180,-$4(a6)                   ; 0702E
        ble.b   l_000_07046                     ; 07034
        moveq   #$28,d0                         ; 07036
        move.l  d0,-(a7)                        ; 07038
        jsr     (PlayTireSound).l               ; 0703A
        addq.l  #$4,a7                          ; 07040
        bra.w   l_000_07178                     ; 07042
l_000_07046:
        moveq   #$1e,d0                         ; 07046
        move.l  d0,-(a7)                        ; 07048
        jsr     (PlayTireSound).l               ; 0704A
        addq.l  #$4,a7                          ; 07050
        bra.w   l_000_07178                     ; 07052
l_000_07056:
        move.w  (Player_6E).l,d0                ; 07056
        tst.w   d0                              ; 0705C
        bne.b   l_000_070DA                     ; 0705E
        move.w  (dat_071_002A2).l,d0            ; 07060
        btst    #$1,d0                          ; 07066
        bne.b   l_000_070BC                     ; 0706A
        moveq   #$4,d0                          ; 0706C
        move.b  d0,(ShakeKind).l                ; 0706E
        move.w  (dat_071_0029A).l,d0            ; 07074
        btst    #$8,d0                          ; 0707A
        beq.b   l_000_070AC                     ; 0707E
        andi.w  #$feff,d0                       ; 07080
        move.w  d0,(dat_071_0029A).l            ; 07084
        movea.l -$30(a6),a0                     ; 0708A
        move.b  (a0),d0                         ; 0708E
        btst    #$2,d0                          ; 07090
        bne.b   l_000_070A6                     ; 07094
        movea.l -$2c(a6),a0                     ; 07096
        move.w  (a0),d0                         ; 0709A
        andi.w  #$c000,d0                       ; 0709C
        cmpi.w  #$c000,d0                       ; 070A0
        bne.b   l_000_070AC                     ; 070A4
l_000_070A6:
        jsr     (sub_006_00132).l               ; 070A6
l_000_070AC:
        move.w  (dat_071_002A2).l,d0            ; 070AC
        ori.w   #$2,d0                          ; 070B2
        move.w  d0,(dat_071_002A2).l            ; 070B6
l_000_070BC:
        tst.l   (PlayerFuel).l                  ; 070BC
        bne.w   l_000_07178                     ; 070C2
        move.w  (dat_071_0029E).l,d0            ; 070C6
        ori.w   #$4000,d0                       ; 070CC
        move.w  d0,(dat_071_0029E).l            ; 070D0
        bra.w   l_000_07178                     ; 070D6
l_000_070DA:
        move.w  (dat_071_002A2).l,d0            ; 070DA
        btst    #$1,d0                          ; 070E0
        beq.w   l_000_07178                     ; 070E4
        move.b  #$3,(ShakeKind).l               ; 070E8
        bset    #$1,(dat_071_00526).l           ; 070F0
        andi.w  #$fffd,d0                       ; 070F8
        move.w  d0,(dat_071_002A2).l            ; 070FC
        bra.b   l_000_07178                     ; 07102
l_000_07104:
        movea.l -$28(a6),a0                     ; 07104
        move.w  (a0),d0                         ; 07108
        btst    #$9,d0                          ; 0710A
        bne.b   l_000_07178                     ; 0710E
        move.w  (dat_071_0029E).l,d0            ; 07110
        btst    #$e,d0                          ; 07116
        beq.b   l_000_07178                     ; 0711A
        move.l  (PlayerFuel).l,d0               ; 0711C
        addi.l  #$190,d0                        ; 07122
        move.l  d0,(PlayerFuel).l               ; 07128
        cmpi.l  #$61a80000,d0                   ; 0712E
        bge.b   l_000_0714E                     ; 07134
        move.w  (dat_071_002A0).l,d0            ; 07136
        btst    #$4,d0                          ; 0713C
        bne.b   l_000_07178                     ; 07140
        ori.w   #$10,d0                         ; 07142
        move.w  d0,(dat_071_002A0).l            ; 07146
        bra.b   l_000_07178                     ; 0714C
l_000_0714E:
        move.w  (dat_071_0029E).l,d0            ; 0714E
        andi.w  #$bfff,d0                       ; 07154
        move.w  d0,(dat_071_0029E).l            ; 07158
        move.w  (dat_071_002A0).l,d0            ; 0715E
        andi.w  #$ffef,d0                       ; 07164
        move.w  d0,(dat_071_002A0).l            ; 07168
        move.l  #$61a80000,(PlayerFuel).l       ; 0716E
l_000_07178:
        clr.l   (PlayerVelY).l                  ; 07178
        bra.b   l_000_0718C                     ; 0717E
l_000_07180:
        movea.l -$2c(a6),a0                     ; 07180
        move.w  (a0),d0                         ; 07184
        ori.w   #$80,d0                         ; 07186
        move.w  d0,(a0)                         ; 0718A
l_000_0718C:
        movea.l (CockpitObject).l,a0            ; 0718C
        move.w  $6e(a0),d0                      ; 07192
        cmpi.w  #$3c0,d0                        ; 07196
        bge.w   l_000_07280                     ; 0719A
        movea.l -$2c(a6),a0                     ; 0719E
        move.w  (a0),d0                         ; 071A2
        andi.w  #$efff,d0                       ; 071A4
        move.w  d0,(a0)                         ; 071A8
        bra.w   l_000_07280                     ; 071AA
l_000_071AE:
        movea.l -$2c(a6),a0                     ; 071AE
        move.w  (a0),d0                         ; 071B2
        btst    #$7,d0                          ; 071B4
        beq.w   l_000_07262                     ; 071B8
        andi.w  #$ff7f,d0                       ; 071BC
        move.w  d0,(a0)                         ; 071C0
        movea.l -$30(a6),a0                     ; 071C2
        move.b  (a0),d0                         ; 071C6
        btst    #$3,d0                          ; 071C8
        beq.b   l_000_071DC                     ; 071CC
        andi.b  #$f7,d0                         ; 071CE
        move.b  d0,(a0)                         ; 071D2
        move.b  #$4,(ShakeKind).l               ; 071D4
l_000_071DC:
        tst.w   -$24(a6)                        ; 071DC
        bne.b   l_000_0724E                     ; 071E0
        jsr     (ReadTime).l                    ; 071E2
        move.l  (FlightStartTime).l,d0          ; 071E8
        move.l  (TimeSeconds).l,d1              ; 071EE
        sub.l   d0,d1                           ; 071F4
        move.l  d1,(FlightStartTime).l          ; 071F6
        add.l   d1,(dat_071_002E0).l            ; 071FC
        clr.l   (FlightStartTime).l             ; 07202
        movea.l (CockpitObject).l,a0            ; 07208
        move.b  $21(a0),d0                      ; 0720E
        ori.b   #$1,d0                          ; 07212
        movea.l (CockpitObject).l,a0            ; 07216
        move.b  d0,$21(a0)                      ; 0721C
        movea.l -$2c(a6),a0                     ; 07220
        move.w  (a0),d0                         ; 07224
        andi.w  #$efff,d0                       ; 07226
        move.w  d0,(a0)                         ; 0722A
        move.w  (dat_071_002A2).l,d0            ; 0722C
        andi.w  #$fffd,d0                       ; 07232
        move.w  d0,(dat_071_002A2).l            ; 07236
        move.w  (dat_071_0029A).l,d0            ; 0723C
        ori.w   #$100,d0                        ; 07242
        move.w  d0,(dat_071_0029A).l            ; 07246
        bra.b   l_000_07254                     ; 0724C
l_000_0724E:
        jsr     (sub_006_000F6).l               ; 0724E
l_000_07254:
        movea.l -$30(a6),a0                     ; 07254
        move.b  (a0),d0                         ; 07258
        andi.b  #$fd,d0                         ; 0725A
        move.b  d0,(a0)                         ; 0725E
        bra.b   l_000_07280                     ; 07260
l_000_07262:
        move.l  (dat_071_000CA).l,d0            ; 07262
        movea.l (CockpitObject).l,a0            ; 07268
        move.l  $18(a0),d1                      ; 0726E
        cmp.l   d0,d1                           ; 07272
        ble.b   l_000_07280                     ; 07274
        movea.l (CockpitObject).l,a0            ; 07276
        move.l  d0,$18(a0)                      ; 0727C
l_000_07280:
        movem.l (a7)+,d2-d4/a2-a3               ; 07280
        unlk    a6                              ; 07284
        rts                                     ; 07286

;-------------------------------------------------------------------------------
; EaseVelocity - EaseVelocity(target, current): d = target + current, divided by 4 if |d| > 4,
; by 2 if |d| > 2; returns d - current (how far the velocity moves this frame).
;-------------------------------------------------------------------------------
EaseVelocity:
        link.w  a6,#$fffc                       ; 07288
        move.w  $a(a6),d0                       ; 0728C
        add.w   $e(a6),d0                       ; 07290
        move.w  d0,-$2(a6)                      ; 07294
        move.w  d0,-$4(a6)                      ; 07298
        tst.w   d0                              ; 0729C
        bpl.b   l_000_072A4                     ; 0729E
        neg.w   -$4(a6)                         ; 072A0
l_000_072A4:
        cmpi.w  #$4,-$4(a6)                     ; 072A4
        ble.b   l_000_072B8                     ; 072AA
        move.w  -$2(a6),d0                      ; 072AC
        asr.w   #$2,d0                          ; 072B0
        move.w  d0,-$2(a6)                      ; 072B2
        bra.b   l_000_072CA                     ; 072B6
l_000_072B8:
        cmpi.w  #$2,-$4(a6)                     ; 072B8
        ble.b   l_000_072CA                     ; 072BE
        move.w  -$2(a6),d0                      ; 072C0
        asr.w   #$1,d0                          ; 072C4
        move.w  d0,-$2(a6)                      ; 072C6
l_000_072CA:
        move.w  -$2(a6),d0                      ; 072CA
        sub.w   $e(a6),d0                       ; 072CE
        move.w  d0,$a(a6)                       ; 072D2
        ext.l   d0                              ; 072D6
        unlk    a6                              ; 072D8
        rts                                     ; 072DA

;-------------------------------------------------------------------------------
; UpdateBullets - The gun, each frame unless WorldFrozen: fires a bullet while the trigger is
; held (GunFlags bit 3) and rounds are left, counting them in the flight log (+$3A), and moves
; every bullet (MoveBullet); also the gun's sound.
;-------------------------------------------------------------------------------
UpdateBullets:
        link.w  a6,#$ffea                       ; 072DC
        moveq   #$0,d0                          ; 072E0
        move.b  d0,-$3(a6)                      ; 072E2
        move.b  d0,-$1(a6)                      ; 072E6
        move.b  d0,-$2(a6)                      ; 072EA
        jsr     (SolidPattern).l                ; 072EE
        move.l  #Player_7D,-$8(a6)              ; 072F4
        move.l  #Player_3B,-$c(a6)              ; 072FC
        movea.l -$c(a6),a0                      ; 07304
        move.b  (a0),d0                         ; 07308
        subq.b  #$1,d0                          ; 0730A
        move.b  d0,(a0)                         ; 0730C
        clr.w   -$10(a6)                        ; 0730E
l_000_07312:
        move.w  -$10(a6),d0                     ; 07312
        cmpi.w  #$14,d0                         ; 07316
        bge.w   l_000_0752C                     ; 0731A
        ext.l   d0                              ; 0731E
        asl.l   #$6,d0                          ; 07320
        movea.l d0,a0                           ; 07322
        adda.l  #Bullets,a0                     ; 07324
        move.l  a0,(CurrentBullet).l            ; 0732A
        tst.b   (dat_071_0018D).l               ; 07330
        bne.b   l_000_07350                     ; 07336
        tst.b   (WorldFrozen).l                 ; 07338
        bne.b   l_000_07350                     ; 0733E
        move.w  $28(a0),d0                      ; 07340
        subq.w  #$1,d0                          ; 07344
        movea.l (CurrentBullet).l,a0            ; 07346
        move.w  d0,$28(a0)                      ; 0734C
l_000_07350:
        movea.l (CurrentBullet).l,a0            ; 07350
        adda.w  #$26,a0                         ; 07356
        move.b  (WorldFrozen).l,d0              ; 0735A
        move.l  a0,-$14(a6)                     ; 07360
        tst.b   d0                              ; 07364
        bne.b   l_000_07374                     ; 07366
        move.w  (GunFlags).l,d0                 ; 07368
        btst    #$3,d0                          ; 0736E
        bne.b   l_000_0737E                     ; 07372
l_000_07374:
        tst.b   (dat_071_0025B).l               ; 07374
        beq.w   l_000_0750C                     ; 0737A
l_000_0737E:
        movea.l -$14(a6),a0                     ; 0737E
        move.w  (a0),d0                         ; 07382
        btst    #$0,d0                          ; 07384
        bne.w   l_000_0750C                     ; 07388
        tst.b   -$3(a6)                         ; 0738C
        bne.w   l_000_074FE                     ; 07390
        movea.l -$8(a6),a0                      ; 07394
        move.b  (a0),d0                         ; 07398
        andi.b  #$f0,d0                         ; 0739A
        tst.b   d0                              ; 0739E
        beq.w   l_000_074FE                     ; 073A0
        move.w  (Player_60).l,d0                ; 073A4
        cmpi.w  #$1,d0                          ; 073AA
        blt.w   l_000_074FE                     ; 073AE
        addq.b  #$1,-$3(a6)                     ; 073B2
        move.b  (a0),d0                         ; 073B6
        move.b  d0,$0(a7)                       ; 073B8
        andi.b  #$f0,d0                         ; 073BC
        subi.b  #$10,d0                         ; 073C0
        move.b  $0(a7),d1                       ; 073C4
        andi.b  #$f,d1                          ; 073C8
        or.b    d0,d1                           ; 073CC
        move.b  d1,(a0)                         ; 073CE
        addq.b  #$1,-$1(a6)                     ; 073D0
        addq.b  #$1,-$2(a6)                     ; 073D4
        movea.l (ConfigBuffer).l,a0             ; 073D8
        move.w  $3a(a0),d1                      ; 073DE
        addq.w  #$3,d1                          ; 073E2
        movea.l (ConfigBuffer).l,a0             ; 073E4
        move.w  d1,$3a(a0)                      ; 073EA
        move.b  #$1,(ConfigChanged).l           ; 073EE
        movea.l -$14(a6),a0                     ; 073F6
        move.w  #$401,(a0)                      ; 073FA
        movea.l (CurrentBullet).l,a0            ; 073FE
        clr.w   $2e(a0)                         ; 07404
        move.b  d0,-$d(a6)                      ; 07408
        tst.b   (dat_071_0025B).l               ; 0740C
        beq.b   l_000_07476                     ; 07412
        move.b  (MapView).l,d0                  ; 07414
        tst.b   d0                              ; 0741A
        bne.b   l_000_0742E                     ; 0741C
        moveq   #$30,d0                         ; 0741E
        move.l  d0,-(a7)                        ; 07420
        moveq   #$1c,d0                         ; 07422
        move.l  d0,-(a7)                        ; 07424
        jsr     (PlaySweep).l                   ; 07426
        addq.l  #$8,a7                          ; 0742C
l_000_0742E:
        move.b  (dat_071_0025B).l,d0            ; 0742E
        subq.b  #$1,d0                          ; 07434
        bne.b   l_000_07454                     ; 07436
        movea.l -$14(a6),a0                     ; 07438
        move.w  (a0),d0                         ; 0743C
        ori.w   #$2000,d0                       ; 0743E
        move.w  d0,(a0)                         ; 07442
        move.w  -$10(a6),d0                     ; 07444
        ext.l   d0                              ; 07448
        addq.l  #$1,d0                          ; 0744A
        move.b  d0,(dat_071_0025D).l            ; 0744C
        bra.b   l_000_0746E                     ; 07452
l_000_07454:
        movea.l -$14(a6),a0                     ; 07454
        move.w  (a0),d0                         ; 07458
        ori.w   #$1000,d0                       ; 0745A
        move.w  d0,(a0)                         ; 0745E
        move.w  -$10(a6),d0                     ; 07460
        ext.l   d0                              ; 07464
        addq.l  #$1,d0                          ; 07466
        move.b  d0,(dat_071_0025C).l            ; 07468
l_000_0746E:
        clr.b   (dat_071_0025B).l               ; 0746E
        bra.b   l_000_074EE                     ; 07474
l_000_07476:
        move.b  (MapView).l,d0                  ; 07476
        tst.b   d0                              ; 0747C
        bne.b   l_000_074C6                     ; 0747E
        btst    #$5,(SoundsLoaded).l            ; 07480
        beq.b   l_000_074B6                     ; 07488
        tst.b   (OutsideView).l                 ; 0748A
        beq.b   l_000_074A4                     ; 07490
        moveq   #$1e,d0                         ; 07492
        move.l  d0,-(a7)                        ; 07494
        moveq   #$6,d0                          ; 07496
        move.l  d0,-(a7)                        ; 07498
        jsr     (PlayGunSound).l                ; 0749A
        addq.l  #$8,a7                          ; 074A0
        bra.b   l_000_074C6                     ; 074A2
l_000_074A4:
        moveq   #$16,d0                         ; 074A4
        move.l  d0,-(a7)                        ; 074A6
        moveq   #$6,d0                          ; 074A8
        move.l  d0,-(a7)                        ; 074AA
        jsr     (PlayGunSound).l                ; 074AC
        addq.l  #$8,a7                          ; 074B2
        bra.b   l_000_074C6                     ; 074B4
l_000_074B6:
        moveq   #$30,d0                         ; 074B6
        move.l  d0,-(a7)                        ; 074B8
        moveq   #$1c,d0                         ; 074BA
        move.l  d0,-(a7)                        ; 074BC
        jsr     (PlaySweep).l                   ; 074BE
        addq.l  #$8,a7                          ; 074C4
l_000_074C6:
        move.w  (Player_60).l,d0                ; 074C6
        subq.w  #$3,d0                          ; 074CC
        move.w  d0,(Player_60).l                ; 074CE
        tst.w   d0                              ; 074D4
        bpl.b   l_000_074DE                     ; 074D6
        clr.w   (Player_60).l                   ; 074D8
l_000_074DE:
        move.b  #$3,(StoresRedraw).l            ; 074DE
        movea.l -$c(a6),a0                      ; 074E6
        move.b  #$14,(a0)                       ; 074EA
l_000_074EE:
        move.w  -$10(a6),d0                     ; 074EE
        ext.l   d0                              ; 074F2
        move.l  d0,-(a7)                        ; 074F4
        bsr.w   BulletHitEffects                ; 074F6
        addq.l  #$4,a7                          ; 074FA
        bra.b   l_000_0750C                     ; 074FC
l_000_074FE:
        movea.l -$c(a6),a0                      ; 074FE
        move.b  (a0),d0                         ; 07502
        tst.b   d0                              ; 07504
        ble.b   l_000_0750C                     ; 07506
        addq.b  #$1,-$1(a6)                     ; 07508
l_000_0750C:
        movea.l -$14(a6),a0                     ; 0750C
        move.w  (a0),d0                         ; 07510
        btst    #$0,d0                          ; 07512
        beq.b   l_000_07524                     ; 07516
        move.w  -$10(a6),d0                     ; 07518
        ext.l   d0                              ; 0751C
        move.l  d0,-(a7)                        ; 0751E
        bsr.b   MoveBullet                      ; 07520
        addq.l  #$4,a7                          ; 07522
l_000_07524:
        addq.w  #$2,-$10(a6)                    ; 07524
        bra.w   l_000_07312                     ; 07528
l_000_0752C:
        tst.b   -$1(a6)                         ; 0752C
        bne.b   l_000_07548                     ; 07530
        movea.l -$c(a6),a0                      ; 07532
        clr.b   (a0)                            ; 07536
        movea.l -$8(a6),a0                      ; 07538
        move.b  (a0),d0                         ; 0753C
        andi.b  #$f,d0                          ; 0753E
        ori.b   #$50,d0                         ; 07542
        move.b  d0,(a0)                         ; 07546
l_000_07548:
        unlk    a6                              ; 07548
        rts                                     ; 0754A
