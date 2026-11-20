; F/A-18 Interceptor - hunk 0 (code), part 3 of 3
; The C startup (c.o), main, RunGame and GameFrame (the frame loop); the EA IFF picture reader;
; memory and disk checks; the flight log (df0:config) and flight recording (textply/textctl)
; files; the keyboard, joystick, timer and mouse; loading and playing the sounds.
; Included by ../f18_main.s.

;-------------------------------------------------------------------------------
; MoveBullet - Moves one bullet (its number on the stack): tests whether it hit something
; (BulletHitTest) or the ground (BulletHitGround), adds its velocity and the aircraft's, then
; draws it - the hit (DrawBulletHit), the smoke (DrawBulletSmoke) or the tracer (DrawBullet).
;-------------------------------------------------------------------------------
MoveBullet:
        link.w  a6,#$ffee                       ; 0754C
        movem.l a2,-(a7)                        ; 07550
        movea.l (CurrentBullet).l,a0            ; 07554
        adda.w  #$26,a0                         ; 0755A
        movea.l (CurrentBullet).l,a1            ; 0755E
        move.w  $28(a1),d0                      ; 07564
        move.l  a0,-$4(a6)                      ; 07568
        tst.w   d0                              ; 0756C
        ble.w   l_000_0778C                     ; 0756E
        move.l  a1,-$a(a6)                      ; 07572
        addq.l  #$4,a1                          ; 07576
        movea.l (CurrentBullet).l,a2            ; 07578
        addq.l  #$8,a2                          ; 0757E
        move.w  (a0),d0                         ; 07580
        move.l  a1,-$e(a6)                      ; 07582
        move.l  a2,-$12(a6)                     ; 07586
        btst    #$1,d0                          ; 0758A
        bne.w   l_000_076FE                     ; 0758E
        move.w  $a(a6),d0                       ; 07592
        ext.l   d0                              ; 07596
        move.l  d0,-(a7)                        ; 07598
        jsr     (BulletHitTest).l               ; 0759A
        addq.l  #$4,a7                          ; 075A0
        tst.l   d0                              ; 075A2
        beq.b   l_000_075C6                     ; 075A4
        movea.l -$4(a6),a0                      ; 075A6
        move.w  (a0),d0                         ; 075AA
        andi.w  #$fff7,d0                       ; 075AC
        ori.w   #$12,d0                         ; 075B0
        move.w  d0,(a0)                         ; 075B4
        movea.l (CurrentBullet).l,a0            ; 075B6
        move.w  #$2,$28(a0)                     ; 075BC
        bra.w   l_000_07734                     ; 075C2
l_000_075C6:
        movea.l -$e(a6),a0                      ; 075C6
        tst.l   (a0)                            ; 075CA
        bpl.b   l_000_07628                     ; 075CC
        movea.l -$4(a6),a0                      ; 075CE
        move.w  (a0),d0                         ; 075D2
        andi.w  #$ffe7,d0                       ; 075D4
        ori.w   #$2,d0                          ; 075D8
        move.w  d0,(a0)                         ; 075DC
        movea.l (CurrentBullet).l,a0            ; 075DE
        move.w  #$2,$28(a0)                     ; 075E4
        movea.l (CurrentBullet).l,a0            ; 075EA
        move.l  $10(a0),d0                      ; 075F0
        asr.l   #$8,d0                          ; 075F4
        move.w  d0,(dat_071_004A0).l            ; 075F6
        tst.w   d0                              ; 075FC
        beq.w   l_000_07734                     ; 075FE
        move.w  $a(a6),d0                       ; 07602
        ext.l   d0                              ; 07606
        move.l  d0,-(a7)                        ; 07608
        jsr     (BulletHitGround).l             ; 0760A
        addq.l  #$4,a7                          ; 07610
        tst.l   d0                              ; 07612
        beq.w   l_000_07734                     ; 07614
        movea.l -$4(a6),a0                      ; 07618
        move.w  (a0),d0                         ; 0761C
        ori.w   #$80,d0                         ; 0761E
        move.w  d0,(a0)                         ; 07622
        bra.w   l_000_07734                     ; 07624
l_000_07628:
        movea.l -$a(a6),a0                      ; 07628
        tst.l   (a0)                            ; 0762C
        bpl.b   l_000_0765C                     ; 0762E
        movea.l (CurrentBullet).l,a0            ; 07630
        move.w  $30(a0),d0                      ; 07636
        subq.w  #$1,d0                          ; 0763A
        movea.l (CurrentBullet).l,a0            ; 0763C
        move.w  d0,$30(a0)                      ; 07642
        tst.w   d0                              ; 07646
        bpl.b   l_000_07650                     ; 07648
        move.w  #$7f,$30(a0)                    ; 0764A
l_000_07650:
        movea.l -$a(a6),a0                      ; 07650
        addi.l  #$400000,(a0)                   ; 07654
        bra.b   l_000_07692                     ; 0765A
l_000_0765C:
        movea.l -$a(a6),a0                      ; 0765C
        cmpi.l  #$400000,(a0)                   ; 07660
        blt.b   l_000_07692                     ; 07666
        movea.l (CurrentBullet).l,a0            ; 07668
        move.w  $30(a0),d0                      ; 0766E
        addq.w  #$1,d0                          ; 07672
        movea.l (CurrentBullet).l,a0            ; 07674
        move.w  d0,$30(a0)                      ; 0767A
        cmpi.w  #$7f,d0                         ; 0767E
        ble.b   l_000_07688                     ; 07682
        clr.w   $30(a0)                         ; 07684
l_000_07688:
        movea.l -$a(a6),a0                      ; 07688
        subi.l  #$400000,(a0)                   ; 0768C
l_000_07692:
        movea.l -$12(a6),a0                     ; 07692
        tst.l   (a0)                            ; 07696
        bpl.b   l_000_076C6                     ; 07698
        movea.l (CurrentBullet).l,a0            ; 0769A
        move.w  $32(a0),d0                      ; 076A0
        subq.w  #$1,d0                          ; 076A4
        movea.l (CurrentBullet).l,a0            ; 076A6
        move.w  d0,$32(a0)                      ; 076AC
        tst.w   d0                              ; 076B0
        bpl.b   l_000_076BA                     ; 076B2
        move.w  #$7f,$32(a0)                    ; 076B4
l_000_076BA:
        movea.l -$12(a6),a0                     ; 076BA
        addi.l  #$400000,(a0)                   ; 076BE
        bra.b   l_000_07734                     ; 076C4
l_000_076C6:
        movea.l -$12(a6),a0                     ; 076C6
        cmpi.l  #$400000,(a0)                   ; 076CA
        blt.b   l_000_07734                     ; 076D0
        movea.l (CurrentBullet).l,a0            ; 076D2
        move.w  $32(a0),d0                      ; 076D8
        addq.w  #$1,d0                          ; 076DC
        movea.l (CurrentBullet).l,a0            ; 076DE
        move.w  d0,$32(a0)                      ; 076E4
        cmpi.w  #$7f,d0                         ; 076E8
        ble.b   l_000_076F2                     ; 076EC
        clr.w   $32(a0)                         ; 076EE
l_000_076F2:
        movea.l -$12(a6),a0                     ; 076F2
        subi.l  #$400000,(a0)                   ; 076F6
        bra.b   l_000_07734                     ; 076FC
l_000_076FE:
        movea.l -$4(a6),a0                      ; 076FE
        move.w  (a0),d0                         ; 07702
        btst    #$8,d0                          ; 07704
        beq.b   l_000_07734                     ; 07708
        move.l  (PlayerVelX).l,d0               ; 0770A
        asr.l   #$2,d0                          ; 07710
        movea.l -$a(a6),a0                      ; 07712
        add.l   d0,(a0)                         ; 07716
        move.l  (PlayerVelY).l,d0               ; 07718
        asr.l   #$2,d0                          ; 0771E
        movea.l -$e(a6),a0                      ; 07720
        add.l   d0,(a0)                         ; 07724
        move.l  (PlayerVelZ).l,d0               ; 07726
        asr.l   #$2,d0                          ; 0772C
        movea.l -$12(a6),a0                     ; 0772E
        add.l   d0,(a0)                         ; 07732
l_000_07734:
        movea.l -$4(a6),a0                      ; 07734
        move.w  (a0),d0                         ; 07738
        andi.w  #$1002,d0                       ; 0773A
        tst.w   d0                              ; 0773E
        beq.b   l_000_07754                     ; 07740
        move.w  $a(a6),d0                       ; 07742
        ext.l   d0                              ; 07746
        move.l  d0,-(a7)                        ; 07748
        jsr     (DrawBulletHit).l               ; 0774A
        addq.l  #$4,a7                          ; 07750
        bra.b   l_000_077D0                     ; 07752
l_000_07754:
        movea.l -$4(a6),a0                      ; 07754
        move.w  (a0),d0                         ; 07758
        btst    #$d,d0                          ; 0775A
        beq.b   l_000_07772                     ; 0775E
        move.w  $a(a6),d0                       ; 07760
        ext.l   d0                              ; 07764
        move.l  d0,-(a7)                        ; 07766
        jsr     (DrawBulletSmoke).l             ; 07768
        addq.l  #$4,a7                          ; 0776E
        bra.b   l_000_077D0                     ; 07770
l_000_07772:
        move.w  $a(a6),d0                       ; 07772
        ext.l   d0                              ; 07776
        move.l  d0,-(a7)                        ; 07778
        jsr     (DrawBullet).l                  ; 0777A
        addq.l  #$4,a7                          ; 07780
        move.w  (dat_071_00486).l,-$6(a6)       ; 07782
        bra.b   l_000_077D0                     ; 0778A
l_000_0778C:
        movea.l -$4(a6),a0                      ; 0778C
        move.w  (a0),d0                         ; 07790
        andi.w  #$fffe,d0                       ; 07792
        move.w  d0,(a0)                         ; 07796
        move.w  $a(a6),d0                       ; 07798
        ext.l   d0                              ; 0779C
        addq.l  #$1,d0                          ; 0779E
        move.b  (dat_071_0025C).l,d1            ; 077A0
        ext.w   d1                              ; 077A6
        ext.l   d1                              ; 077A8
        cmp.l   d0,d1                           ; 077AA
        bne.b   l_000_077B4                     ; 077AC
        clr.b   (dat_071_0025C).l               ; 077AE
l_000_077B4:
        move.w  $a(a6),d0                       ; 077B4
        ext.l   d0                              ; 077B8
        addq.l  #$1,d0                          ; 077BA
        move.b  (dat_071_0025D).l,d1            ; 077BC
        ext.w   d1                              ; 077C2
        ext.l   d1                              ; 077C4
        cmp.l   d0,d1                           ; 077C6
        bne.b   l_000_077D0                     ; 077C8
        clr.b   (dat_071_0025D).l               ; 077CA
l_000_077D0:
        movem.l (a7)+,a2                        ; 077D0
        unlk    a6                              ; 077D4
        rts                                     ; 077D6

;-------------------------------------------------------------------------------
; BulletHitEffects - What follows a bullet's hit (CurrentBullet): sets its timer and flags for
; the hit's drawing and the damage (BulletDamage).
;-------------------------------------------------------------------------------
BulletHitEffects:
        link.w  a6,#$fff6                       ; 077D8
        movem.l d2-d5,-(a7)                     ; 077DC
        movea.l (CurrentBullet).l,a0            ; 077E0
        adda.w  #$26,a0                         ; 077E6
        move.w  (a0),d0                         ; 077EA
        move.l  a0,-$a(a6)                      ; 077EC
        btst    #$c,d0                          ; 077F0
        beq.b   l_000_07814                     ; 077F4
        moveq   #$0,d0                          ; 077F6
        move.w  #$fff8,-$4(a6)                  ; 077F8
        movea.l (CurrentBullet).l,a0            ; 077FE
        move.w  #$1e,$28(a0)                    ; 07804
        move.w  d0,-$6(a6)                      ; 0780A
        move.w  d0,-$2(a6)                      ; 0780E
        bra.b   l_000_0787A                     ; 07812
l_000_07814:
        movea.l -$a(a6),a0                      ; 07814
        move.w  (a0),d0                         ; 07818
        btst    #$d,d0                          ; 0781A
        beq.b   l_000_0783E                     ; 0781E
        clr.w   -$2(a6)                         ; 07820
        move.w  #$fff8,-$4(a6)                  ; 07824
        move.w  #$ffc8,-$6(a6)                  ; 0782A
        movea.l (CurrentBullet).l,a0            ; 07830
        move.w  #$3c,$28(a0)                    ; 07836
        bra.b   l_000_0787A                     ; 0783C
l_000_0783E:
        move.b  (PlayerType).l,d0               ; 0783E
        cmpi.b  #$11,d0                         ; 07844
        bne.b   l_000_0785C                     ; 07848
        moveq   #$0,d0                          ; 0784A
        move.w  #$38,-$6(a6)                    ; 0784C
        move.w  d0,-$4(a6)                      ; 07852
        move.w  d0,-$2(a6)                      ; 07856
        bra.b   l_000_0786E                     ; 0785A
l_000_0785C:
        move.w  #$6,-$2(a6)                     ; 0785C
        move.w  #$1,-$4(a6)                     ; 07862
        move.w  #$18,-$6(a6)                    ; 07868
l_000_0786E:
        movea.l (CurrentBullet).l,a0            ; 0786E
        move.w  #$14,$28(a0)                    ; 07874
l_000_0787A:
        move.w  (PlayerM11).l,d0                ; 0787A
        move.w  -$2(a6),d1                      ; 07880
        muls.w  d1,d0                           ; 07884
        move.w  (PlayerM12).l,d2                ; 07886
        move.w  -$4(a6),d3                      ; 0788C
        muls.w  d3,d2                           ; 07890
        add.l   d2,d0                           ; 07892
        move.w  (PlayerM13).l,d2                ; 07894
        move.w  -$6(a6),d4                      ; 0789A
        muls.w  d4,d2                           ; 0789E
        add.l   d2,d0                           ; 078A0
        asr.l   #$6,d0                          ; 078A2
        move.l  d0,(dat_071_00422).l            ; 078A4
        move.w  (PlayerM21).l,d2                ; 078AA
        muls.w  d1,d2                           ; 078B0
        move.w  (PlayerM22).l,d5                ; 078B2
        muls.w  d3,d5                           ; 078B8
        add.l   d5,d2                           ; 078BA
        move.w  (PlayerM23).l,d5                ; 078BC
        muls.w  d4,d5                           ; 078C2
        add.l   d5,d2                           ; 078C4
        asr.l   #$6,d2                          ; 078C6
        move.l  d2,(dat_071_00426).l            ; 078C8
        move.w  (PlayerM31).l,d0                ; 078CE
        muls.w  d0,d1                           ; 078D4
        move.w  (PlayerM32).l,d0                ; 078D6
        muls.w  d0,d3                           ; 078DC
        add.l   d3,d1                           ; 078DE
        move.w  (PlayerM33).l,d0                ; 078E0
        muls.w  d0,d4                           ; 078E6
        add.l   d4,d1                           ; 078E8
        asr.l   #$6,d1                          ; 078EA
        move.l  d1,(dat_071_0042A).l            ; 078EC
        movea.l (CurrentBullet).l,a0            ; 078F2
        move.w  (PlayerCellX).l,$30(a0)         ; 078F8
        movea.l (CurrentBullet).l,a0            ; 07900
        move.w  (PlayerCellZ).l,$32(a0)         ; 07906
        move.l  (PlayerX).l,d0                  ; 0790E
        andi.l  #$3fffff,d0                     ; 07914
        move.l  (dat_071_00422).l,d1            ; 0791A
        add.l   d0,d1                           ; 07920
        movea.l (CurrentBullet).l,a0            ; 07922
        move.l  d1,(a0)                         ; 07928
        move.l  (dat_071_00426).l,d0            ; 0792A
        add.l   (PlayerY).l,d0                  ; 07930
        movea.l (CurrentBullet).l,a0            ; 07936
        move.l  d0,$4(a0)                       ; 0793C
        move.l  (PlayerZ).l,d0                  ; 07940
        andi.l  #$3fffff,d0                     ; 07946
        move.l  (dat_071_0042A).l,d1            ; 0794C
        add.l   d0,d1                           ; 07952
        movea.l (CurrentBullet).l,a0            ; 07954
        move.l  d1,$8(a0)                       ; 0795A
        movea.l -$a(a6),a0                      ; 0795E
        move.w  (a0),d0                         ; 07962
        andi.w  #$3000,d0                       ; 07964
        tst.w   d0                              ; 07968
        beq.b   l_000_07978                     ; 0796A
        move.w  #$ffc0,-$4(a6)                  ; 0796C
        clr.w   -$6(a6)                         ; 07972
        bra.b   l_000_079B6                     ; 07976
l_000_07978:
        move.w  #$40,-$4(a6)                    ; 07978
        move.w  #$400,-$6(a6)                   ; 0797E
        move.w  (FrameCount).l,d0               ; 07984
        ext.l   d0                              ; 0798A
        andi.l  #$3,d0                          ; 0798C
        cmpi.l  #$2,d0                          ; 07992
        beq.b   l_000_079B2                     ; 07998
        cmpi.l  #$1,d0                          ; 0799A
        beq.b   l_000_079AC                     ; 079A0
        tst.l   d0                              ; 079A2
        bne.b   l_000_079B6                     ; 079A4
        addq.w  #$3,-$4(a6)                     ; 079A6
        bra.b   l_000_079B6                     ; 079AA
l_000_079AC:
        subq.w  #$3,-$4(a6)                     ; 079AC
        bra.b   l_000_079B6                     ; 079B0
l_000_079B2:
        addq.w  #$5,-$4(a6)                     ; 079B2
l_000_079B6:
        move.w  (PlayerM12).l,d0                ; 079B6
        move.w  -$4(a6),d1                      ; 079BC
        muls.w  d1,d0                           ; 079C0
        move.w  (PlayerM13).l,d2                ; 079C2
        move.w  -$6(a6),d3                      ; 079C8
        muls.w  d3,d2                           ; 079CC
        add.l   d2,d0                           ; 079CE
        asr.l   #$4,d0                          ; 079D0
        move.l  d0,(dat_071_00422).l            ; 079D2
        move.w  (PlayerM22).l,d0                ; 079D8
        muls.w  d1,d0                           ; 079DE
        move.w  (PlayerM23).l,d2                ; 079E0
        muls.w  d3,d2                           ; 079E6
        add.l   d2,d0                           ; 079E8
        asr.l   #$4,d0                          ; 079EA
        move.l  d0,(dat_071_00426).l            ; 079EC
        move.w  (PlayerM32).l,d0                ; 079F2
        muls.w  d0,d1                           ; 079F8
        move.w  (PlayerM33).l,d0                ; 079FA
        muls.w  d0,d3                           ; 07A00
        add.l   d3,d1                           ; 07A02
        asr.l   #$4,d1                          ; 07A04
        move.l  d1,(dat_071_0042A).l            ; 07A06
        clr.w   (BulletHitObject).l             ; 07A0C
        move.w  $a(a6),d0                       ; 07A12
        ext.l   d0                              ; 07A16
        move.l  d0,-(a7)                        ; 07A18
        bsr.w   BulletDamage                    ; 07A1A
        addq.l  #$4,a7                          ; 07A1E
        movem.l (a7)+,d2-d5                     ; 07A20
        unlk    a6                              ; 07A24
        rts                                     ; 07A26

;-------------------------------------------------------------------------------
; BulletHitsObject - A bullet hit an object (the number on the stack): notes it
; (BulletHitObject), moves the bullet into the object's cell and applies the hit
; (BulletDamage).
;-------------------------------------------------------------------------------
BulletHitsObject:
        link.w  a6,#$0                          ; 07A28
        move.w  $e(a6),d0                       ; 07A2C
        move.w  d0,(BulletHitObject).l          ; 07A30
        moveq   #$9,d1                          ; 07A36
        ext.l   d0                              ; 07A38
        asl.l   d1,d0                           ; 07A3A
        movea.l d0,a0                           ; 07A3C
        adda.l  #ObjectTable,a0                 ; 07A3E
        move.l  a0,(CockpitObject).l            ; 07A44
        movea.l (CurrentBullet).l,a1            ; 07A4A
        move.w  $6(a0),$30(a1)                  ; 07A50
        movea.l (CockpitObject).l,a0            ; 07A56
        movea.l (CurrentBullet).l,a1            ; 07A5C
        move.w  $8(a0),$32(a1)                  ; 07A62
        movea.l (CockpitObject).l,a0            ; 07A68
        move.l  $14(a0),d0                      ; 07A6E
        andi.l  #$3fffff,d0                     ; 07A72
        movea.l (CurrentBullet).l,a0            ; 07A78
        move.l  d0,(a0)                         ; 07A7E
        movea.l (CockpitObject).l,a0            ; 07A80
        movea.l (CurrentBullet).l,a1            ; 07A86
        move.l  $18(a0),$4(a1)                  ; 07A8C
        movea.l (CockpitObject).l,a0            ; 07A92
        move.l  $1c(a0),d0                      ; 07A98
        andi.l  #$3fffff,d0                     ; 07A9C
        movea.l (CurrentBullet).l,a0            ; 07AA2
        move.l  d0,$8(a0)                       ; 07AA8
        move.w  #$14,$28(a0)                    ; 07AAC
        movea.l (CockpitObject).l,a0            ; 07AB2
        move.w  $96(a0),d0                      ; 07AB8
        ext.l   d0                              ; 07ABC
        asl.l   #$4,d0                          ; 07ABE
        move.l  d0,(dat_071_00422).l            ; 07AC0
        movea.l (CockpitObject).l,a0            ; 07AC6
        move.w  $9c(a0),d0                      ; 07ACC
        ext.l   d0                              ; 07AD0
        asl.l   #$4,d0                          ; 07AD2
        move.l  d0,(dat_071_00426).l            ; 07AD4
        movea.l (CockpitObject).l,a0            ; 07ADA
        move.w  $a2(a0),d0                      ; 07AE0
        ext.l   d0                              ; 07AE4
        asl.l   #$4,d0                          ; 07AE6
        move.l  d0,(dat_071_0042A).l            ; 07AE8
        move.w  $a(a6),d0                       ; 07AEE
        ext.l   d0                              ; 07AF2
        move.l  d0,-(a7)                        ; 07AF4
        bsr.b   BulletDamage                    ; 07AF6
        addq.l  #$4,a7                          ; 07AF8
        unlk    a6                              ; 07AFA
        rts                                     ; 07AFC

;-------------------------------------------------------------------------------
; BulletDamage - What a bullet's hit does to what it hit (every few frames by FrameCount's low
; bits): the damage and its effects (BulletDamageAt).
;-------------------------------------------------------------------------------
BulletDamage:
        link.w  a6,#$ffe8                       ; 07AFE
        movem.l d2-d3,-(a7)                     ; 07B02
        move.w  (FrameCount).l,d0               ; 07B06
        ext.l   d0                              ; 07B0C
        andi.l  #$3,d0                          ; 07B0E
        cmpi.l  #$2,d0                          ; 07B14
        beq.b   l_000_07B36                     ; 07B1A
        cmpi.l  #$1,d0                          ; 07B1C
        beq.b   l_000_07B2E                     ; 07B22
        tst.l   d0                              ; 07B24
        bne.b   l_000_07B3C                     ; 07B26
        clr.w   -$4(a6)                         ; 07B28
        bra.b   l_000_07B42                     ; 07B2C
l_000_07B2E:
        move.w  #$10,-$4(a6)                    ; 07B2E
        bra.b   l_000_07B42                     ; 07B34
l_000_07B36:
        clr.w   -$4(a6)                         ; 07B36
        bra.b   l_000_07B42                     ; 07B3A
l_000_07B3C:
        move.w  #$fff0,-$4(a6)                  ; 07B3C
l_000_07B42:
        move.w  (BulletHitObject).l,d0          ; 07B42
        moveq   #$9,d1                          ; 07B48
        ext.l   d0                              ; 07B4A
        asl.l   d1,d0                           ; 07B4C
        movea.l d0,a0                           ; 07B4E
        adda.l  #ObjectTable,a0                 ; 07B50
        move.w  $6c(a0),d0                      ; 07B56
        asr.w   #$6,d0                          ; 07B5A
        movea.l (CurrentBullet).l,a0            ; 07B5C
        move.w  $26(a0),d1                      ; 07B62
        move.w  d0,-$6(a6)                      ; 07B66
        btst    #$c,d1                          ; 07B6A
        beq.b   l_000_07B78                     ; 07B6E
        move.w  #$d,-$2(a6)                     ; 07B70
        bra.b   l_000_07BA0                     ; 07B76
l_000_07B78:
        movea.l (CurrentBullet).l,a0            ; 07B78
        move.w  $26(a0),d0                      ; 07B7E
        btst    #$d,d0                          ; 07B82
        beq.b   l_000_07B90                     ; 07B86
        move.w  #$5,-$2(a6)                     ; 07B88
        bra.b   l_000_07BA0                     ; 07B8E
l_000_07B90:
        move.w  -$4(a6),d0                      ; 07B90
        addi.w  #$c6,d0                         ; 07B94
        add.w   -$6(a6),d0                      ; 07B98
        move.w  d0,-$2(a6)                      ; 07B9C
l_000_07BA0:
        move.l  (PlayerX).l,d0                  ; 07BA0
        andi.l  #$3fffff,d0                     ; 07BA6
        move.l  (dat_071_00422).l,d1            ; 07BAC
        add.l   d0,d1                           ; 07BB2
        movea.l (CurrentBullet).l,a0            ; 07BB4
        sub.l   (a0),d1                         ; 07BBA
        move.l  (dat_071_00426).l,d0            ; 07BBC
        add.l   (PlayerY).l,d0                  ; 07BC2
        sub.l   $4(a0),d0                       ; 07BC8
        move.l  (PlayerZ).l,d2                  ; 07BCC
        andi.l  #$3fffff,d2                     ; 07BD2
        move.l  (dat_071_0042A).l,d3            ; 07BD8
        add.l   d2,d3                           ; 07BDE
        sub.l   $8(a0),d3                       ; 07BE0
        move.l  d1,-$a(a6)                      ; 07BE4
        asr.l   #$8,d1                          ; 07BE8
        move.l  d0,-$e(a6)                      ; 07BEA
        asr.l   #$8,d0                          ; 07BEE
        move.l  d3,-$12(a6)                     ; 07BF0
        asr.l   #$8,d3                          ; 07BF4
        move.w  -$2(a6),d2                      ; 07BF6
        ext.l   d2                              ; 07BFA
        move.w  d1,-$14(a6)                     ; 07BFC
        ext.l   d1                              ; 07C00
        move.w  d0,-$16(a6)                     ; 07C02
        ext.l   d0                              ; 07C06
        move.w  d3,-$18(a6)                     ; 07C08
        ext.l   d3                              ; 07C0C
        move.l  d3,-(a7)                        ; 07C0E
        move.l  d0,-(a7)                        ; 07C10
        move.l  d1,-(a7)                        ; 07C12
        move.l  d2,-(a7)                        ; 07C14
        bsr.b   BulletDamageAt                  ; 07C16
        lea.l   $10(a7),a7                      ; 07C18
        movem.l (a7)+,d2-d3                     ; 07C1C
        unlk    a6                              ; 07C20
        rts                                     ; 07C22

;-------------------------------------------------------------------------------
; BulletDamageAt - Part of BulletDamage: the hit's effect at a point (four values on the
; stack).
;-------------------------------------------------------------------------------
BulletDamageAt:
        link.w  a6,#$fff4                       ; 07C24
        movem.l d2-d3,-(a7)                     ; 07C28
        move.w  $a(a6),d0                       ; 07C2C
        ext.l   d0                              ; 07C30
        move.w  $e(a6),d1                       ; 07C32
        ext.l   d1                              ; 07C36
        move.w  $12(a6),d2                      ; 07C38
        ext.l   d2                              ; 07C3C
        move.w  $16(a6),d3                      ; 07C3E
        ext.l   d3                              ; 07C42
        move.l  d3,-(a7)                        ; 07C44
        move.l  d2,-(a7)                        ; 07C46
        move.l  d1,-(a7)                        ; 07C48
        move.l  d0,-(a7)                        ; 07C4A
        jsr     (ScaleToLengthStack).l          ; 07C4C
        lea.l   $10(a7),a7                      ; 07C52
        move.w  (dat_071_0041C).l,d0            ; 07C56
        ext.l   d0                              ; 07C5C
        move.l  d0,$8(a7)                       ; 07C5E
        asl.l   #$3,d0                          ; 07C62
        movea.l (CurrentBullet).l,a0            ; 07C64
        move.l  d0,$c(a0)                       ; 07C6A
        move.w  (dat_071_0041E).l,d1            ; 07C6E
        ext.l   d1                              ; 07C74
        move.l  d1,$c(a7)                       ; 07C76
        asl.l   #$3,d1                          ; 07C7A
        movea.l (CurrentBullet).l,a0            ; 07C7C
        move.l  d1,$10(a0)                      ; 07C82
        move.w  (dat_071_00420).l,d0            ; 07C86
        ext.l   d0                              ; 07C8C
        move.l  d0,$10(a7)                      ; 07C8E
        asl.l   #$3,d0                          ; 07C92
        movea.l (CurrentBullet).l,a0            ; 07C94
        move.l  d0,$14(a0)                      ; 07C9A
        move.l  $8(a7),d1                       ; 07C9E
        movea.l (CurrentBullet).l,a0            ; 07CA2
        move.l  d1,$18(a0)                      ; 07CA8
        move.l  $c(a7),d0                       ; 07CAC
        movea.l (CurrentBullet).l,a0            ; 07CB0
        move.l  d0,$1c(a0)                      ; 07CB6
        move.l  $10(a7),d1                      ; 07CBA
        movea.l (CurrentBullet).l,a0            ; 07CBE
        move.l  d1,$20(a0)                      ; 07CC4
        clr.w   $24(a0)                         ; 07CC8
        movea.l (CurrentBullet).l,a0            ; 07CCC
        move.w  $26(a0),d0                      ; 07CD2
        andi.w  #$3000,d0                       ; 07CD6
        tst.w   d0                              ; 07CDA
        beq.b   l_000_07D3E                     ; 07CDC
        move.l  (PlayerVelX).l,d0               ; 07CDE
        add.l   d0,$c(a0)                       ; 07CE4
        move.l  (PlayerVelY).l,d0               ; 07CE8
        movea.l (CurrentBullet).l,a0            ; 07CEE
        add.l   d0,$10(a0)                      ; 07CF4
        move.l  (PlayerVelZ).l,d0               ; 07CF8
        movea.l (CurrentBullet).l,a0            ; 07CFE
        add.l   d0,$14(a0)                      ; 07D04
        move.l  (PlayerVelX).l,d0               ; 07D08
        asr.l   #$3,d0                          ; 07D0E
        movea.l (CurrentBullet).l,a0            ; 07D10
        add.l   d0,$18(a0)                      ; 07D16
        move.l  (PlayerVelY).l,d0               ; 07D1A
        asr.l   #$3,d0                          ; 07D20
        movea.l (CurrentBullet).l,a0            ; 07D22
        add.l   d0,$1c(a0)                      ; 07D28
        move.l  (PlayerVelZ).l,d0               ; 07D2C
        asr.l   #$3,d0                          ; 07D32
        movea.l (CurrentBullet).l,a0            ; 07D34
        add.l   d0,$20(a0)                      ; 07D3A
l_000_07D3E:
        movem.l (a7)+,d2-d3                     ; 07D3E
        unlk    a6                              ; 07D42
        rts                                     ; 07D44
	dc.b	$00,$00

;-------------------------------------------------------------------------------
; RunGame - Sets the game up after the title and runs it: frees the title pictures' memory,
; allocates the display buffers, frees the sprites, notes the free chip RAM, opens the input
; devices (InitInput), allocates the config buffer (78 bytes) and the flight recording's
; buffers and loads the demo recording (LoadDemoRecording), fades the palette in, makes the
; display, then loops for ever: SelectDrawBuffer, OwnBlitter, GameFrame, DisownBlitter,
; ShowDisplay.
;-------------------------------------------------------------------------------
RunGame:
        link.w  a6,#$fff0                       ; 07D48
        jsr     (FreeTitlePictures).l           ; 07D4C
        jsr     (AllocGameBuffers).l            ; 07D52
        bsr.w   FreeSprites                     ; 07D58
        moveq   #$2,d0                          ; 07D5C
        move.l  d0,-(a7)                        ; 07D5E
        jsr     (_AvailMem).l                   ; 07D60
        addq.l  #$4,a7                          ; 07D66
        move.l  d0,(dat_071_00028).l            ; 07D68
        moveq   #$1,d0                          ; 07D6E
        move.l  d0,-(a7)                        ; 07D70
        move.l  #$1b58,-(a7)                    ; 07D72
        jsr     (_AllocMem).l                   ; 07D78
        addq.l  #$8,a7                          ; 07D7E
        move.l  d0,(dat_073_01654).l            ; 07D80
        jsr     (InitInput).l                   ; 07D86
        move.l  #$10001,-(a7)                   ; 07D8C
        moveq   #$4e,d0                         ; 07D92
        move.l  d0,-(a7)                        ; 07D94
        jsr     (_AllocMem).l                   ; 07D96
        addq.l  #$8,a7                          ; 07D9C
        move.l  d0,(ConfigBuffer).l             ; 07D9E
        moveq   #$2,d0                          ; 07DA4
        move.l  d0,-(a7)                        ; 07DA6
        jsr     (_AvailMem).l                   ; 07DA8
        addq.l  #$4,a7                          ; 07DAE
        move.l  d0,(dat_071_0002C).l            ; 07DB0
        jsr     (AllocRecordBuffers).l          ; 07DB6
        tst.l   d0                              ; 07DBC
        beq.b   l_000_07DC6                     ; 07DBE
        jsr     (LoadDemoRecording).l           ; 07DC0
l_000_07DC6:
        clr.l   -(a7)                           ; 07DC6
        jsr     (_FreeSprite).l                 ; 07DC8
        addq.l  #$4,a7                          ; 07DCE
        btst    #$7,(SoundsLoaded).l            ; 07DD0
        beq.b   l_000_07DE8                     ; 07DD8
        move.l  #$80000,-(a7)                   ; 07DDA
        jsr     (BusyWait).l                    ; 07DE0
        addq.l  #$4,a7                          ; 07DE6
l_000_07DE8:
        clr.w   -$4(a6)                         ; 07DE8
l_000_07DEC:
        cmpi.w  #$10,-$4(a6)                    ; 07DEC
        bge.w   l_000_07EB8                     ; 07DF2
        movea.l (GameColorMap).l,a0             ; 07DF6
        move.l  $4(a0),-$10(a6)                 ; 07DFC
        clr.w   -$2(a6)                         ; 07E02
l_000_07E06:
        cmpi.w  #$20,-$2(a6)                    ; 07E06
        bge.b   l_000_07E76                     ; 07E0C
        movea.l -$10(a6),a0                     ; 07E0E
        move.w  (a0),d0                         ; 07E12
        move.w  d0,-$6(a6)                      ; 07E14
        andi.w  #$f00,d0                        ; 07E18
        subi.w  #$100,d0                        ; 07E1C
        move.w  d0,-$8(a6)                      ; 07E20
        tst.w   d0                              ; 07E24
        bpl.b   l_000_07E2C                     ; 07E26
        clr.w   -$8(a6)                         ; 07E28
l_000_07E2C:
        move.w  -$6(a6),d0                      ; 07E2C
        andi.w  #$f0,d0                         ; 07E30
        subi.w  #$10,d0                         ; 07E34
        move.w  d0,-$a(a6)                      ; 07E38
        tst.w   d0                              ; 07E3C
        bpl.b   l_000_07E44                     ; 07E3E
        clr.w   -$a(a6)                         ; 07E40
l_000_07E44:
        move.w  -$6(a6),d0                      ; 07E44
        andi.w  #$f,d0                          ; 07E48
        subq.w  #$1,d0                          ; 07E4C
        move.w  d0,-$c(a6)                      ; 07E4E
        tst.w   d0                              ; 07E52
        bpl.b   l_000_07E5A                     ; 07E54
        clr.w   -$c(a6)                         ; 07E56
l_000_07E5A:
        move.w  -$8(a6),d0                      ; 07E5A
        or.w    -$a(a6),d0                      ; 07E5E
        or.w    -$c(a6),d0                      ; 07E62
        movea.l -$10(a6),a0                     ; 07E66
        move.w  d0,(a0)                         ; 07E6A
        addq.l  #$2,-$10(a6)                    ; 07E6C
        addq.w  #$1,-$2(a6)                     ; 07E70
        bra.b   l_000_07E06                     ; 07E74
l_000_07E76:
        pea.l   (GameViewPort).l                ; 07E76
        jsr     (_WaitBOVP).l                   ; 07E7C
        addq.l  #$4,a7                          ; 07E82
        moveq   #$20,d0                         ; 07E84
        move.l  d0,-(a7)                        ; 07E86
        movea.l (GameColorMap).l,a0             ; 07E88
        move.l  $4(a0),-(a7)                    ; 07E8E
        pea.l   (GameViewPort).l                ; 07E92
        jsr     (_LoadRGB4).l                   ; 07E98
        lea.l   $c(a7),a7                       ; 07E9E
        move.l  #$a00,-(a7)                     ; 07EA2
        jsr     (BusyWait).l                    ; 07EA8
        addq.l  #$4,a7                          ; 07EAE
        addq.w  #$1,-$4(a6)                     ; 07EB0
        bra.w   l_000_07DEC                     ; 07EB4
l_000_07EB8:
        bsr.w   MakeDisplay                     ; 07EB8
        tst.l   (dat_073_01654).l               ; 07EBC
        beq.b   l_000_07ED8                     ; 07EC2
        move.l  #$1b58,-(a7)                    ; 07EC4
        move.l  (dat_073_01654).l,-(a7)         ; 07ECA
        jsr     (_FreeMem).l                    ; 07ED0
        addq.l  #$8,a7                          ; 07ED6
l_000_07ED8:
        move.l  #$186a0,-(a7)                   ; 07ED8
        jsr     (BusyWait).l                    ; 07EDE
        addq.l  #$4,a7                          ; 07EE4
l_000_07EE6:
        jsr     (SelectDrawBuffer).l            ; 07EE6
        jsr     (_OwnBlitter).l                 ; 07EEC
        jsr     (GameFrame).l                   ; 07EF2
        jsr     (_DisownBlitter).l              ; 07EF8
        bsr.w   ShowDisplay                     ; 07EFE
        bra.b   l_000_07EE6                     ; 07F02

;-------------------------------------------------------------------------------
; InitDisplay - Opens graphics.library and sets up the game's View and ViewPort: two BitMaps of
; 320 x 200 (5 planes for the display, 4 for the second), their RastPorts, and allocates their
; planes ($1F40 bytes each, chip RAM).
;-------------------------------------------------------------------------------
InitDisplay:
        link.w  a6,#$fff4                       ; 07F04
        moveq   #$1d,d0                         ; 07F08
        move.l  d0,-(a7)                        ; 07F0A
        pea.l   (StrGraphicsLibrary2).l         ; 07F0C
        jsr     (_OpenLibrary).l                ; 07F12
        addq.l  #$8,a7                          ; 07F18
        move.l  d0,(_GfxBase).l                 ; 07F1A
        tst.l   d0                              ; 07F20
        bne.b   l_000_07F30                     ; 07F22
        moveq   #$1,d0                          ; 07F24
        move.l  d0,-(a7)                        ; 07F26
        jsr     (exit).l                        ; 07F28
        addq.l  #$4,a7                          ; 07F2E
l_000_07F30:
        movea.l (_GfxBase).l,a0                 ; 07F30
        move.l  $22(a0),(OldView).l             ; 07F36
        pea.l   (GameView).l                    ; 07F3E
        jsr     (_InitView).l                   ; 07F44
        addq.l  #$4,a7                          ; 07F4A
        pea.l   (GameViewPort).l                ; 07F4C
        jsr     (_InitVPort).l                  ; 07F52
        addq.l  #$4,a7                          ; 07F58
        move.l  #GameViewPort,(GameView).l      ; 07F5A
        lea.l   (BitMap1).l,a0                  ; 07F64
        move.l  a0,(GameBitMap1).l              ; 07F6A
        move.l  #BitMap2,(GameBitMap2).l        ; 07F70
        moveq   #$5,d0                          ; 07F7A
        move.l  #$c8,-(a7)                      ; 07F7C
        move.l  #$140,-(a7)                     ; 07F82
        move.l  d0,-(a7)                        ; 07F88
        move.l  a0,-(a7)                        ; 07F8A
        move.l  d0,-$c(a6)                      ; 07F8C
        jsr     (_InitBitMap).l                 ; 07F90
        lea.l   $10(a7),a7                      ; 07F96
        move.l  #$c8,-(a7)                      ; 07F9A
        move.l  #$140,-(a7)                     ; 07FA0
        moveq   #$4,d0                          ; 07FA6
        move.l  d0,-(a7)                        ; 07FA8
        move.l  (GameBitMap2).l,-(a7)           ; 07FAA
        jsr     (_InitBitMap).l                 ; 07FB0
        lea.l   $10(a7),a7                      ; 07FB6
        pea.l   (GameRastPort1).l               ; 07FBA
        jsr     (_InitRastPort).l               ; 07FC0
        addq.l  #$4,a7                          ; 07FC6
        pea.l   (GameRastPort2).l               ; 07FC8
        jsr     (_InitRastPort).l               ; 07FCE
        addq.l  #$4,a7                          ; 07FD4
        movea.l (GameBitMap1).l,a0              ; 07FD6
        move.l  a0,(GameRastPort1BitMap).l      ; 07FDC
        move.l  (GameBitMap2).l,(GameRastPort2BitMap).l ; 07FE2
        move.l  a0,(GameRasInfoBitMap).l        ; 07FEC
        moveq   #$0,d0                          ; 07FF2
        move.w  d0,(GameRasInfoRxOffset).l      ; 07FF4
        move.w  d0,(GameRasInfoRyOffset).l      ; 07FFA
        clr.l   (GameRasInfo).l                 ; 08000
        move.w  #$140,(GameViewPortDWidth).l    ; 08006
        move.w  #$c8,(GameViewPortDHeight).l    ; 0800E
        move.l  #GameRasInfo,(GameViewPortRasInfo).l ; 08016
        move.l  #$10002,-(a7)                   ; 08020
        move.l  #$1f40,-(a7)                    ; 08026
        jsr     (_AllocMem).l                   ; 0802C
        addq.l  #$8,a7                          ; 08032
        movea.l (GameBitMap1).l,a0              ; 08034
        move.l  d0,$8(a0)                       ; 0803A
        move.l  d0,(dat_071_0008E).l            ; 0803E
        move.l  #$10002,-(a7)                   ; 08044
        move.l  #$1f40,-(a7)                    ; 0804A
        jsr     (_AllocMem).l                   ; 08050
        addq.l  #$8,a7                          ; 08056
        movea.l (GameBitMap1).l,a0              ; 08058
        move.l  d0,$c(a0)                       ; 0805E
        move.l  d0,(dat_071_00092).l            ; 08062
        move.l  #$10002,-(a7)                   ; 08068
        move.l  #$1f40,-(a7)                    ; 0806E
        jsr     (_AllocMem).l                   ; 08074
        addq.l  #$8,a7                          ; 0807A
        movea.l (GameBitMap1).l,a0              ; 0807C
        move.l  d0,$10(a0)                      ; 08082
        move.l  d0,(dat_071_00096).l            ; 08086
        move.l  #$10002,-(a7)                   ; 0808C
        move.l  #$1f40,-(a7)                    ; 08092
        jsr     (_AllocMem).l                   ; 08098
        addq.l  #$8,a7                          ; 0809E
        movea.l (GameBitMap1).l,a0              ; 080A0
        move.l  d0,$14(a0)                      ; 080A6
        move.l  d0,(dat_071_0009A).l            ; 080AA
        tst.l   (dat_071_0008E).l               ; 080B0
        beq.b   l_000_080CC                     ; 080B6
        tst.l   (dat_071_00092).l               ; 080B8
        beq.b   l_000_080CC                     ; 080BE
        tst.l   (dat_071_00096).l               ; 080C0
        beq.b   l_000_080CC                     ; 080C6
        tst.l   d0                              ; 080C8
        bne.b   l_000_080DA                     ; 080CA
l_000_080CC:
        move.l  #$fffffc18,-(a7)                ; 080CC
        jsr     (exit).l                        ; 080D2
        addq.l  #$4,a7                          ; 080D8
l_000_080DA:
        move.l  #$10002,-(a7)                   ; 080DA
        move.l  #$1f40,-(a7)                    ; 080E0
        jsr     (_AllocMem).l                   ; 080E6
        addq.l  #$8,a7                          ; 080EC
        movea.l (GameBitMap1).l,a0              ; 080EE
        move.l  d0,$18(a0)                      ; 080F4
        move.l  d0,(dat_071_0009E).l            ; 080F8
        tst.l   d0                              ; 080FE
        bne.b   l_000_08110                     ; 08100
        move.l  #$fffffc18,-(a7)                ; 08102
        jsr     (exit).l                        ; 08108
        addq.l  #$4,a7                          ; 0810E
l_000_08110:
        move.l  (dat_071_0008E).l,(dat_071_000A2).l ; 08110
        move.l  (dat_071_00092).l,(dat_071_000A6).l ; 0811A
        move.l  (dat_071_00096).l,(dat_071_000AA).l ; 08124
        move.l  (dat_071_0009A).l,(dat_071_000AE).l ; 0812E
        movea.l (GameBitMap2).l,a0              ; 08138
        movea.l (GameBitMap1).l,a1              ; 0813E
        move.l  $8(a1),$8(a0)                   ; 08144
        movea.l (GameBitMap1).l,a1              ; 0814A
        move.l  $c(a1),$c(a0)                   ; 08150
        movea.l (GameBitMap1).l,a1              ; 08156
        move.l  $10(a1),$10(a0)                 ; 0815C
        movea.l (GameBitMap1).l,a1              ; 08162
        move.l  $14(a1),$14(a0)                 ; 08168
        jsr     (SetupBufferPlanes).l           ; 0816E
        moveq   #$20,d0                         ; 08174
        move.l  d0,-(a7)                        ; 08176
        jsr     (_GetColorMap).l                ; 08178
        addq.l  #$4,a7                          ; 0817E
        move.l  d0,(GameColorMap).l             ; 08180
        move.l  #$10002,-(a7)                   ; 08186
        moveq   #$40,d1                         ; 0818C
        move.l  d1,-(a7)                        ; 0818E
        jsr     (_AllocMem).l                   ; 08190
        addq.l  #$8,a7                          ; 08196
        move.l  d0,(LivePalette).l              ; 08198
        movea.l (GameColorMap).l,a0             ; 0819E
        move.l  $4(a0),-$4(a6)                  ; 081A4
        clr.l   -$8(a6)                         ; 081AA
l_000_081AE:
        move.l  -$8(a6),d0                      ; 081AE
        cmpi.l  #$20,d0                         ; 081B2
        bge.b   l_000_081D4                     ; 081B8
        asl.l   #$1,d0                          ; 081BA
        movea.l d0,a0                           ; 081BC
        adda.l  #PictureColours,a0              ; 081BE
        movea.l -$4(a6),a1                      ; 081C4
        move.w  (a0),(a1)                       ; 081C8
        addq.l  #$2,-$4(a6)                     ; 081CA
        addq.l  #$1,-$8(a6)                     ; 081CE
        bra.b   l_000_081AE                     ; 081D2
l_000_081D4:
        move.l  (GameColorMap).l,(GameViewPortColorMap).l ; 081D4
        clr.w   (GameViewPortDxOffset).l        ; 081DE
        move.w  #$fffe,(GameViewPortDyOffset).l ; 081E4
        pea.l   (GameViewPort).l                ; 081EC
        pea.l   (GameView).l                    ; 081F2
        jsr     (_MakeVPort).l                  ; 081F8
        addq.l  #$8,a7                          ; 081FE
        pea.l   (GameView).l                    ; 08200
        jsr     (_MrgCop).l                     ; 08206
        addq.l  #$4,a7                          ; 0820C
        move.l  (GameViewLOFCprList).l,(CopperBuffer1).l ; 0820E
        move.l  (GameViewPortDspIns).l,(CopperBuffer2).l ; 08218
        unlk    a6                              ; 08222
        rts                                     ; 08224

;-------------------------------------------------------------------------------
; MakeDisplay - MakeVPort and MrgCop for the game View; keeps its copper lists (two sets, for
; double buffering).
;-------------------------------------------------------------------------------
MakeDisplay:
        suba.l  a0,a0                           ; 08226
        move.l  a0,(GameViewLOFCprList).l       ; 08228
        move.l  a0,(GameViewPortDspIns).l       ; 0822E
        move.l  (GameBitMap2).l,(GameRasInfoBitMap).l ; 08234
        pea.l   (GameViewPort).l                ; 0823E
        pea.l   (GameView).l                    ; 08244
        jsr     (_MakeVPort).l                  ; 0824A
        addq.l  #$8,a7                          ; 08250
        pea.l   (GameView).l                    ; 08252
        jsr     (_MrgCop).l                     ; 08258
        addq.l  #$4,a7                          ; 0825E
        move.l  (GameViewLOFCprList).l,(CopperBuffer1DspIns).l ; 08260
        move.l  (GameViewPortDspIns).l,(CopperBuffer2DspIns).l ; 0826A
        clr.w   (DisplayBuffer).l               ; 08274
        rts                                     ; 0827A

;-------------------------------------------------------------------------------
; ShowDisplay - Waits for the bottom of the ViewPort and loads the View with the copper list of
; the buffer to show (DisplayBuffer); flashes the palette (dat_021_00040 / the game palette)
; while dat_071_00269 counts down, or once when PaletteLoadCount is set.
;-------------------------------------------------------------------------------
ShowDisplay:
        link.w  a6,#$fffe                       ; 0827C
        pea.l   (GameViewPort).l                ; 08280
        jsr     (_WaitBOVP).l                   ; 08286
        addq.l  #$4,a7                          ; 0828C
        move.w  (DisplayBuffer).l,d0            ; 0828E
        move.w  d0,$0(a7)                       ; 08294
        ext.l   d0                              ; 08298
        asl.l   #$2,d0                          ; 0829A
        movea.l d0,a0                           ; 0829C
        adda.l  #CopperBuffer1,a0               ; 0829E
        move.l  (a0),(GameViewLOFCprList).l     ; 082A4
        move.w  $0(a7),d0                       ; 082AA
        ext.l   d0                              ; 082AE
        asl.l   #$2,d0                          ; 082B0
        movea.l d0,a0                           ; 082B2
        adda.l  #CopperBuffer2,a0               ; 082B4
        move.l  (a0),(GameViewPortDspIns).l     ; 082BA
        pea.l   (GameView).l                    ; 082C0
        jsr     (_LoadView).l                   ; 082C6
        addq.l  #$4,a7                          ; 082CC
        tst.b   (dat_071_00269).l               ; 082CE
        beq.w   l_000_08376                     ; 082D4
        pea.l   (GameViewPort).l                ; 082D8
        jsr     (_WaitBOVP).l                   ; 082DE
        addq.l  #$4,a7                          ; 082E4
        jsr     (_WaitBlit).l                   ; 082E6
l_000_082EC:
        move.b  (dat_071_00269).l,d0            ; 082EC
        tst.b   d0                              ; 082F2
        ble.w   l_000_083C0                     ; 082F4
        moveq   #$20,d0                         ; 082F8
        move.l  d0,-(a7)                        ; 082FA
        pea.l   (dat_021_00040).l               ; 082FC
        pea.l   (GameViewPort).l                ; 08302
        jsr     (_LoadRGB4).l                   ; 08308
        lea.l   $c(a7),a7                       ; 0830E
        pea.l   (GameViewPort).l                ; 08312
        jsr     (_WaitBOVP).l                   ; 08318
        addq.l  #$4,a7                          ; 0831E
        pea.l   (GameViewPort).l                ; 08320
        jsr     (_WaitBOVP).l                   ; 08326
        addq.l  #$4,a7                          ; 0832C
        moveq   #$20,d0                         ; 0832E
        move.l  d0,-(a7)                        ; 08330
        move.l  (LivePalette).l,-(a7)           ; 08332
        pea.l   (GameViewPort).l                ; 08338
        jsr     (_LoadRGB4).l                   ; 0833E
        lea.l   $c(a7),a7                       ; 08344
        pea.l   (GameViewPort).l                ; 08348
        jsr     (_WaitBOVP).l                   ; 0834E
        addq.l  #$4,a7                          ; 08354
        pea.l   (GameViewPort).l                ; 08356
        jsr     (_WaitBOVP).l                   ; 0835C
        addq.l  #$4,a7                          ; 08362
        move.b  (dat_071_00269).l,d0            ; 08364
        subq.b  #$1,d0                          ; 0836A
        move.b  d0,(dat_071_00269).l            ; 0836C
        bra.w   l_000_082EC                     ; 08372
l_000_08376:
        tst.b   (PaletteLoadCount).l            ; 08376
        beq.b   l_000_083C0                     ; 0837C
        move.b  (PaletteLoadCount).l,d0         ; 0837E
        subq.b  #$1,d0                          ; 08384
        move.b  d0,(PaletteLoadCount).l         ; 08386
        move.w  (dat_071_002A2).l,d0            ; 0838C
        btst    #$8,d0                          ; 08392
        bne.b   l_000_083C0                     ; 08396
        pea.l   (GameViewPort).l                ; 08398
        jsr     (_WaitBOVP).l                   ; 0839E
        addq.l  #$4,a7                          ; 083A4
        moveq   #$20,d0                         ; 083A6
        move.l  d0,-(a7)                        ; 083A8
        move.l  (LivePalette).l,-(a7)           ; 083AA
        pea.l   (GameViewPort).l                ; 083B0
        jsr     (_LoadRGB4).l                   ; 083B6
        lea.l   $c(a7),a7                       ; 083BC
l_000_083C0:
        move.w  (DisplayBuffer).l,d0            ; 083C0
        moveq   #$1,d1                          ; 083C6
        sub.w   d0,d1                           ; 083C8
        move.w  d1,(DisplayBuffer).l            ; 083CA
        unlk    a6                              ; 083D0
        rts                                     ; 083D2

;-------------------------------------------------------------------------------
; FreeSprites - FreeSprite for sprites 0-7.
;-------------------------------------------------------------------------------
FreeSprites:
        clr.l   -(a7)                           ; 083D4
        jsr     (_FreeSprite).l                 ; 083D6
        addq.l  #$4,a7                          ; 083DC
        moveq   #$1,d0                          ; 083DE
        move.l  d0,-(a7)                        ; 083E0
        jsr     (_FreeSprite).l                 ; 083E2
        addq.l  #$4,a7                          ; 083E8
        moveq   #$2,d0                          ; 083EA
        move.l  d0,-(a7)                        ; 083EC
        jsr     (_FreeSprite).l                 ; 083EE
        addq.l  #$4,a7                          ; 083F4
        moveq   #$3,d0                          ; 083F6
        move.l  d0,-(a7)                        ; 083F8
        jsr     (_FreeSprite).l                 ; 083FA
        addq.l  #$4,a7                          ; 08400
        moveq   #$4,d0                          ; 08402
        move.l  d0,-(a7)                        ; 08404
        jsr     (_FreeSprite).l                 ; 08406
        addq.l  #$4,a7                          ; 0840C
        moveq   #$5,d0                          ; 0840E
        move.l  d0,-(a7)                        ; 08410
        jsr     (_FreeSprite).l                 ; 08412
        addq.l  #$4,a7                          ; 08418
        moveq   #$6,d0                          ; 0841A
        move.l  d0,-(a7)                        ; 0841C
        jsr     (_FreeSprite).l                 ; 0841E
        addq.l  #$4,a7                          ; 08424
        moveq   #$7,d0                          ; 08426
        move.l  d0,-(a7)                        ; 08428
        jsr     (_FreeSprite).l                 ; 0842A
        addq.l  #$4,a7                          ; 08430
        rts                                     ; 08432

;-------------------------------------------------------------------------------
; LoadConfig - Loads df0:config if the disk allows it (CheckDisk): reads it (ReadConfig) or, if
; it is not there, writes a new one (WriteConfig). The blitter is released while the disk is
; used.
;-------------------------------------------------------------------------------
LoadConfig:
        jsr     (_DisownBlitter).l              ; 08434
        jsr     (CheckDisk).l                   ; 0843A
        move.w  d0,(LogDiskStatus).l            ; 08440
        tst.w   d0                              ; 08446
        bne.b   l_000_08464                     ; 08448
        bsr.w   ReadConfig                      ; 0844A
        move.w  d0,(ConfigSize).l               ; 0844E
        subq.w  #$1,d0                          ; 08454
        bne.b   l_000_08462                     ; 08456
        move.w  #$1,(ConfigOnDisk).l            ; 08458
        bra.b   l_000_08464                     ; 08460
l_000_08462:
        bsr.b   WriteConfig                     ; 08462
l_000_08464:
        jsr     (_OwnBlitter).l                 ; 08464
        rts                                     ; 0846A

;-------------------------------------------------------------------------------
; WriteConfig - Writes the config buffer (78 bytes) to a new df0:config; ConfigOnDisk = 1.
;-------------------------------------------------------------------------------
WriteConfig:
        link.w  a6,#$fff4                       ; 0846C
        move.l  #$3ee,-(a7)                     ; 08470
        pea.l   (StrConfig).l                   ; 08476
        jsr     (_Open).l                       ; 0847C
        addq.l  #$8,a7                          ; 08482
        move.l  d0,-$c(a6)                      ; 08484
        tst.l   d0                              ; 08488
        bgt.b   l_000_08492                     ; 0848A
        moveq   #$0,d0                          ; 0848C
        unlk    a6                              ; 0848E
        rts                                     ; 08490
l_000_08492:
        movea.l (ConfigBuffer).l,a0             ; 08492
        moveq   #$4e,d0                         ; 08498
        move.l  d0,-(a7)                        ; 0849A
        move.l  a0,-(a7)                        ; 0849C
        move.l  -$c(a6),-(a7)                   ; 0849E
        move.l  a0,-$4(a6)                      ; 084A2
        jsr     (_Write).l                      ; 084A6
        lea.l   $c(a7),a7                       ; 084AC
        move.l  d0,-$8(a6)                      ; 084B0
        addq.l  #$1,d0                          ; 084B4
        bne.b   l_000_084BE                     ; 084B6
        moveq   #$0,d0                          ; 084B8
        unlk    a6                              ; 084BA
        rts                                     ; 084BC
l_000_084BE:
        move.w  #$1,(ConfigOnDisk).l            ; 084BE
        move.l  -$c(a6),-(a7)                   ; 084C6
        jsr     (_Close).l                      ; 084CA
        addq.l  #$4,a7                          ; 084D0
        unlk    a6                              ; 084D2
        rts                                     ; 084D4

;-------------------------------------------------------------------------------
; ReadConfig - Reads df0:config (78 bytes) into the config buffer; returns 1 if it was there
; (ConfigOnDisk = 1), 0 if not.
;-------------------------------------------------------------------------------
ReadConfig:
        link.w  a6,#$fff4                       ; 084D6
        move.l  #$3ed,-(a7)                     ; 084DA
        pea.l   (StrConfig2).l                  ; 084E0
        jsr     (_Open).l                       ; 084E6
        addq.l  #$8,a7                          ; 084EC
        move.l  d0,-$c(a6)                      ; 084EE
        tst.l   d0                              ; 084F2
        bgt.b   l_000_08502                     ; 084F4
        clr.w   (ConfigOnDisk).l                ; 084F6
        moveq   #$0,d0                          ; 084FC
        unlk    a6                              ; 084FE
        rts                                     ; 08500
l_000_08502:
        move.w  #$1,(ConfigOnDisk).l            ; 08502
        movea.l (ConfigBuffer).l,a0             ; 0850A
        moveq   #$4e,d0                         ; 08510
        move.l  d0,-(a7)                        ; 08512
        move.l  a0,-(a7)                        ; 08514
        move.l  -$c(a6),-(a7)                   ; 08516
        move.l  a0,-$4(a6)                      ; 0851A
        jsr     (_Read).l                       ; 0851E
        lea.l   $c(a7),a7                       ; 08524
        move.l  -$c(a6),-(a7)                   ; 08528
        move.l  d0,-$8(a6)                      ; 0852C
        jsr     (_Close).l                      ; 08530
        addq.l  #$4,a7                          ; 08536
        cmpi.l  #$ffffffff,-$8(a6)              ; 08538
        bne.b   l_000_08548                     ; 08540
        moveq   #$0,d0                          ; 08542
        unlk    a6                              ; 08544
        rts                                     ; 08546
l_000_08548:
        move.w  #$1,(ConfigOnDisk).l            ; 08548
        moveq   #$1,d0                          ; 08550
        unlk    a6                              ; 08552
        rts                                     ; 08554

;-------------------------------------------------------------------------------
; ClearConfig - Clears the config buffer (39 words) and marks it changed (ConfigChanged).
;-------------------------------------------------------------------------------
ClearConfig:
        link.w  a6,#$fffa                       ; 08556
        move.l  (ConfigBuffer).l,-$6(a6)        ; 0855A
        clr.w   -$2(a6)                         ; 08562
l_000_08566:
        cmpi.w  #$27,-$2(a6)                    ; 08566
        bge.b   l_000_0857E                     ; 0856C
        movea.l -$6(a6),a0                      ; 0856E
        clr.w   (a0)                            ; 08572
        addq.l  #$2,-$6(a6)                     ; 08574
        addq.w  #$1,-$2(a6)                     ; 08578
        bra.b   l_000_08566                     ; 0857C
l_000_0857E:
        move.b  #$1,(ConfigChanged).l           ; 0857E
        unlk    a6                              ; 08586
        rts                                     ; 08588

;-------------------------------------------------------------------------------
; SaveConfig - Writes the config buffer to df0:config again (MODE_OLDFILE) if the disk allows
; it and the config was there.
;-------------------------------------------------------------------------------
SaveConfig:
        link.w  a6,#$fff4                       ; 0858A
        move.w  (LogDiskStatus).l,d0            ; 0858E
        tst.w   d0                              ; 08594
        bne.w   l_000_0865E                     ; 08596
        jsr     (_DisownBlitter).l              ; 0859A
        clr.b   (ConfigChanged).l               ; 085A0
        jsr     (CheckDisk).l                   ; 085A6
        move.w  d0,(LogDiskStatus).l            ; 085AC
        tst.w   d0                              ; 085B2
        bne.w   l_000_08658                     ; 085B4
        clr.l   -(a7)                           ; 085B8
        jsr     (_FreeSprite).l                 ; 085BA
        addq.l  #$4,a7                          ; 085C0
        move.w  (ConfigOnDisk).l,d0             ; 085C2
        tst.w   d0                              ; 085C8
        bne.b   l_000_085D2                     ; 085CA
        moveq   #$0,d0                          ; 085CC
        unlk    a6                              ; 085CE
        rts                                     ; 085D0
l_000_085D2:
        move.l  #$3ed,-(a7)                     ; 085D2
        pea.l   (StrConfig3).l                  ; 085D8
        jsr     (_Open).l                       ; 085DE
        addq.l  #$8,a7                          ; 085E4
        clr.l   -(a7)                           ; 085E6
        move.l  d0,-$c(a6)                      ; 085E8
        jsr     (_FreeSprite).l                 ; 085EC
        addq.l  #$4,a7                          ; 085F2
        tst.l   -$c(a6)                         ; 085F4
        bgt.b   l_000_08606                     ; 085F8
        clr.w   (ConfigOnDisk).l                ; 085FA
        moveq   #$0,d0                          ; 08600
        unlk    a6                              ; 08602
        rts                                     ; 08604
l_000_08606:
        movea.l (ConfigBuffer).l,a0             ; 08606
        moveq   #$4e,d0                         ; 0860C
        move.l  d0,-(a7)                        ; 0860E
        move.l  a0,-(a7)                        ; 08610
        move.l  -$c(a6),-(a7)                   ; 08612
        move.l  a0,-$4(a6)                      ; 08616
        jsr     (_Write).l                      ; 0861A
        lea.l   $c(a7),a7                       ; 08620
        clr.l   -(a7)                           ; 08624
        move.l  d0,-$8(a6)                      ; 08626
        jsr     (_FreeSprite).l                 ; 0862A
        addq.l  #$4,a7                          ; 08630
        move.l  -$c(a6),-(a7)                   ; 08632
        jsr     (_Close).l                      ; 08636
        addq.l  #$4,a7                          ; 0863C
        clr.l   -(a7)                           ; 0863E
        jsr     (_FreeSprite).l                 ; 08640
        addq.l  #$4,a7                          ; 08646
        cmpi.l  #$ffffffff,-$8(a6)              ; 08648
        bne.b   l_000_08658                     ; 08650
        moveq   #$0,d0                          ; 08652
        unlk    a6                              ; 08654
        rts                                     ; 08656
l_000_08658:
        jsr     (_OwnBlitter).l                 ; 08658
l_000_0865E:
        unlk    a6                              ; 0865E
        rts                                     ; 08660
	dc.b	'NuNuNu'

;-------------------------------------------------------------------------------
; LoadDemoRecording - Loads the recorded flight: textply (RecordLength bytes) into RecordBuffer
; and textctl (4 * RecordLength) into RecordControls; makes empty files if they are not there.
;-------------------------------------------------------------------------------
LoadDemoRecording:
        link.w  a6,#$fffc                       ; 08668
        move.l  #$3ed,-(a7)                     ; 0866C
        pea.l   (StrTextTextply).l              ; 08672
        jsr     (_Open).l                       ; 08678
        addq.l  #$8,a7                          ; 0867E
        move.l  d0,-$4(a6)                      ; 08680
        tst.l   d0                              ; 08684
        ble.b   l_000_086AC                     ; 08686
        move.l  (RecordLength).l,-(a7)          ; 08688
        move.l  (RecordBuffer).l,-(a7)          ; 0868E
        move.l  d0,-(a7)                        ; 08694
        jsr     (_Read).l                       ; 08696
        lea.l   $c(a7),a7                       ; 0869C
        move.l  (RecordBuffer).l,(RecordPointer).l ; 086A0
        bra.b   l_000_086C4                     ; 086AA
l_000_086AC:
        move.l  #$3ee,-(a7)                     ; 086AC
        pea.l   (StrTextTextply2).l             ; 086B2
        jsr     (_Open).l                       ; 086B8
        addq.l  #$8,a7                          ; 086BE
        move.l  d0,-$4(a6)                      ; 086C0
l_000_086C4:
        move.l  -$4(a6),-(a7)                   ; 086C4
        jsr     (_Close).l                      ; 086C8
        addq.l  #$4,a7                          ; 086CE
        move.l  #$3ed,-(a7)                     ; 086D0
        pea.l   (StrTextTextctl).l              ; 086D6
        jsr     (_Open).l                       ; 086DC
        addq.l  #$8,a7                          ; 086E2
        move.l  d0,-$4(a6)                      ; 086E4
        tst.l   d0                              ; 086E8
        ble.b   l_000_0870A                     ; 086EA
        move.l  (RecordLength).l,d1             ; 086EC
        asl.l   #$2,d1                          ; 086F2
        move.l  d1,-(a7)                        ; 086F4
        move.l  (RecordControls).l,-(a7)        ; 086F6
        move.l  d0,-(a7)                        ; 086FC
        jsr     (_Read).l                       ; 086FE
        lea.l   $c(a7),a7                       ; 08704
        bra.b   l_000_08722                     ; 08708
l_000_0870A:
        move.l  #$3ee,-(a7)                     ; 0870A
        pea.l   (StrTextTextctl2).l             ; 08710
        jsr     (_Open).l                       ; 08716
        addq.l  #$8,a7                          ; 0871C
        move.l  d0,-$4(a6)                      ; 0871E
l_000_08722:
        move.l  -$4(a6),-(a7)                   ; 08722
        jsr     (_Close).l                      ; 08726
        addq.l  #$4,a7                          ; 0872C
        unlk    a6                              ; 0872E
        rts                                     ; 08730

;-------------------------------------------------------------------------------
; SaveRecording - Writes the flight recording: RecordBuffer to textply, RecordControls to
; textctl.
;-------------------------------------------------------------------------------
SaveRecording:
        link.w  a6,#$fffc                       ; 08732
        move.l  #$3ed,-(a7)                     ; 08736
        pea.l   (StrTextTextply3).l             ; 0873C
        jsr     (_Open).l                       ; 08742
        addq.l  #$8,a7                          ; 08748
        move.l  d0,-$4(a6)                      ; 0874A
        tst.l   d0                              ; 0874E
        ble.b   l_000_0876A                     ; 08750
        move.l  (RecordLength).l,-(a7)          ; 08752
        move.l  (RecordBuffer).l,-(a7)          ; 08758
        move.l  d0,-(a7)                        ; 0875E
        jsr     (_Write).l                      ; 08760
        lea.l   $c(a7),a7                       ; 08766
l_000_0876A:
        move.l  -$4(a6),-(a7)                   ; 0876A
        jsr     (_Close).l                      ; 0876E
        addq.l  #$4,a7                          ; 08774
        move.l  #$3ed,-(a7)                     ; 08776
        pea.l   (StrTextTextctl3).l             ; 0877C
        jsr     (_Open).l                       ; 08782
        addq.l  #$8,a7                          ; 08788
        move.l  d0,-$4(a6)                      ; 0878A
        tst.l   d0                              ; 0878E
        ble.b   l_000_087AE                     ; 08790
        move.l  (RecordLength).l,d1             ; 08792
        asl.l   #$2,d1                          ; 08798
        move.l  d1,-(a7)                        ; 0879A
        move.l  (RecordControls).l,-(a7)        ; 0879C
        move.l  d0,-(a7)                        ; 087A2
        jsr     (_Write).l                      ; 087A4
        lea.l   $c(a7),a7                       ; 087AA
l_000_087AE:
        move.l  -$4(a6),-(a7)                   ; 087AE
        jsr     (_Close).l                      ; 087B2
        addq.l  #$4,a7                          ; 087B8
        unlk    a6                              ; 087BA
        rts                                     ; 087BC

;-------------------------------------------------------------------------------
; LoadRecording - Reads the flight recording back (textply, textctl) to replay it.
;-------------------------------------------------------------------------------
LoadRecording:
        link.w  a6,#$fffc                       ; 087BE
        move.l  #$3ed,-(a7)                     ; 087C2
        pea.l   (StrTextTextply4).l             ; 087C8
        jsr     (_Open).l                       ; 087CE
        addq.l  #$8,a7                          ; 087D4
        move.l  d0,-$4(a6)                      ; 087D6
        tst.l   d0                              ; 087DA
        ble.b   l_000_08800                     ; 087DC
        move.l  (RecordLength).l,-(a7)          ; 087DE
        move.l  (RecordBuffer).l,-(a7)          ; 087E4
        move.l  d0,-(a7)                        ; 087EA
        jsr     (_Read).l                       ; 087EC
        lea.l   $c(a7),a7                       ; 087F2
        move.l  (RecordBuffer).l,(RecordPointer).l ; 087F6
l_000_08800:
        move.l  -$4(a6),-(a7)                   ; 08800
        jsr     (_Close).l                      ; 08804
        addq.l  #$4,a7                          ; 0880A
        move.l  #$3ed,-(a7)                     ; 0880C
        pea.l   (StrTextTextctl4).l             ; 08812
        jsr     (_Open).l                       ; 08818
        addq.l  #$8,a7                          ; 0881E
        move.l  d0,-$4(a6)                      ; 08820
        tst.l   d0                              ; 08824
        ble.b   l_000_08844                     ; 08826
        move.l  (RecordLength).l,d1             ; 08828
        asl.l   #$2,d1                          ; 0882E
        move.l  d1,-(a7)                        ; 08830
        move.l  (RecordControls).l,-(a7)        ; 08832
        move.l  d0,-(a7)                        ; 08838
        jsr     (_Read).l                       ; 0883A
        lea.l   $c(a7),a7                       ; 08840
l_000_08844:
        move.l  -$4(a6),-(a7)                   ; 08844
        jsr     (_Close).l                      ; 08848
        addq.l  #$4,a7                          ; 0884E
        unlk    a6                              ; 08850
        rts                                     ; 08852

;-------------------------------------------------------------------------------
; CodeHash - CodeHash(a, b, c, d): a 16-bit check value from four numbers through the tables at
; dat_001_00184 and an LFSR (15 steps, feedback $B400); also leaves (value >> 1) & 3 in
; CodeHashValue.
;-------------------------------------------------------------------------------
CodeHash:
        link.w  a6,#$fff8                       ; 08854
        move.w  $a(a6),d0                       ; 08858
        sub.w   $16(a6),d0                      ; 0885C
        asl.w   #$4,d0                          ; 08860
        move.w  $12(a6),d1                      ; 08862
        ext.l   d1                              ; 08866
        asl.l   #$1,d1                          ; 08868
        movea.l d1,a0                           ; 0886A
        adda.l  #dat_001_00184,a0               ; 0886C
        move.w  (a0),d1                         ; 08872
        add.w   d1,d0                           ; 08874
        add.w   $e(a6),d0                       ; 08876
        andi.w  #$ff,d0                         ; 0887A
        move.w  d0,-$2(a6)                      ; 0887E
        asl.w   #$8,d0                          ; 08882
        add.w   -$2(a6),d0                      ; 08884
        move.w  #$f,-$6(a6)                     ; 08888
        move.w  d0,-$4(a6)                      ; 0888E
l_000_08892:
        tst.w   -$6(a6)                         ; 08892
        beq.b   l_000_088C8                     ; 08896
        move.w  -$4(a6),d0                      ; 08898
        andi.w  #$1,d0                          ; 0889C
        move.w  -$4(a6),d1                      ; 088A0
        asr.w   #$1,d1                          ; 088A4
        andi.w  #$7fff,d1                       ; 088A6
        move.w  d0,-$8(a6)                      ; 088AA
        move.w  d1,-$4(a6)                      ; 088AE
        tst.w   d0                              ; 088B2
        beq.b   l_000_088C2                     ; 088B4
        ext.l   d1                              ; 088B6
        addi.l  #$b400,d1                       ; 088B8
        move.w  d1,-$4(a6)                      ; 088BE
l_000_088C2:
        subq.w  #$1,-$6(a6)                     ; 088C2
        bra.b   l_000_08892                     ; 088C6
l_000_088C8:
        move.w  -$2(a6),d0                      ; 088C8
        asr.w   #$1,d0                          ; 088CC
        andi.w  #$3,d0                          ; 088CE
        move.w  d0,(CodeHashValue).l            ; 088D2
        move.w  -$4(a6),d0                      ; 088D8
        unlk    a6                              ; 088DC
        rts                                     ; 088DE

;-------------------------------------------------------------------------------
; CodeCheck - Works out the expected code from CodeValue1-02978 with the tables at
; dat_001_00184 / dat_001_001A4 (CodeHash), masked by dat_001_001C4[CodeHashValue].
;-------------------------------------------------------------------------------
CodeCheck:
        link.w  a6,#$fff2                       ; 088E0
        movem.l d2-d3,-(a7)                     ; 088E4
        move.w  (CodeValue3).l,d0               ; 088E8
        move.w  d0,$8(a7)                       ; 088EE
        ext.l   d0                              ; 088F2
        asl.l   #$1,d0                          ; 088F4
        movea.l d0,a0                           ; 088F6
        adda.l  #dat_001_00184,a0               ; 088F8
        move.w  (a0),d0                         ; 088FE
        andi.w  #$7,d0                          ; 08900
        move.w  $8(a7),d1                       ; 08904
        ext.l   d1                              ; 08908
        asl.l   #$1,d1                          ; 0890A
        movea.l d1,a0                           ; 0890C
        adda.l  #dat_001_00184,a0               ; 0890E
        move.w  (a0),d1                         ; 08914
        asr.w   #$4,d1                          ; 08916
        move.w  (CodeValue1).l,d2               ; 08918
        move.w  $8(a7),d3                       ; 0891E
        eor.w   d2,d3                           ; 08922
        move.w  d0,-$6(a6)                      ; 08924
        move.w  d1,-$8(a6)                      ; 08928
        btst    #$0,d3                          ; 0892C
        beq.b   l_000_08960                     ; 08930
        asl.w   #$1,d0                          ; 08932
        move.w  (CodeValue2).l,d3               ; 08934
        andi.w  #$1,d3                          ; 0893A
        add.w   d3,d0                           ; 0893E
        move.w  d0,-$4(a6)                      ; 08940
        ext.l   d0                              ; 08944
        asl.l   #$1,d0                          ; 08946
        movea.l d0,a0                           ; 08948
        adda.l  #dat_001_001A4,a0               ; 0894A
        move.w  (a0),d0                         ; 08950
        add.w   d2,d0                           ; 08952
        sub.w   d1,d0                           ; 08954
        andi.w  #$f,d0                          ; 08956
        move.w  d0,(CodeValue2).l               ; 0895A
l_000_08960:
        move.w  -$6(a6),d0                      ; 08960
        asl.w   #$1,d0                          ; 08964
        move.w  (CodeValue2).l,d1               ; 08966
        move.w  (CodeValue1).l,d2               ; 0896C
        sub.w   d2,d1                           ; 08972
        add.w   -$8(a6),d1                      ; 08974
        andi.w  #$f,d1                          ; 08978
        move.w  d0,-$4(a6)                      ; 0897C
        ext.l   d0                              ; 08980
        move.l  d0,$8(a7)                       ; 08982
        asl.l   #$1,d0                          ; 08986
        movea.l d0,a0                           ; 08988
        adda.l  #dat_001_001A4,a0               ; 0898A
        move.w  (a0),d0                         ; 08990
        move.w  d1,-$a(a6)                      ; 08992
        cmp.w   d1,d0                           ; 08996
        beq.b   l_000_089B0                     ; 08998
        move.l  $8(a7),d0                       ; 0899A
        addq.l  #$1,d0                          ; 0899E
        asl.l   #$1,d0                          ; 089A0
        movea.l d0,a0                           ; 089A2
        adda.l  #dat_001_001A4,a0               ; 089A4
        move.w  (a0),d0                         ; 089AA
        cmp.w   d0,d1                           ; 089AC
        bne.b   l_000_089E0                     ; 089AE
l_000_089B0:
        move.w  (CodeValue4).l,d0               ; 089B0
        ext.l   d0                              ; 089B6
        move.w  (CodeValue3).l,d1               ; 089B8
        ext.l   d1                              ; 089BE
        move.w  (CodeValue1).l,d2               ; 089C0
        ext.l   d2                              ; 089C6
        move.l  d2,-(a7)                        ; 089C8
        move.l  d1,-(a7)                        ; 089CA
        moveq   #$8,d3                          ; 089CC
        move.l  d3,-(a7)                        ; 089CE
        move.l  d0,-(a7)                        ; 089D0
        bsr.w   CodeHash                        ; 089D2
        lea.l   $10(a7),a7                      ; 089D6
        move.w  d0,-$2(a6)                      ; 089DA
        bra.b   l_000_08A0C                     ; 089DE
l_000_089E0:
        move.w  (CodeValue2).l,d0               ; 089E0
        ext.l   d0                              ; 089E6
        move.w  (CodeValue3).l,d1               ; 089E8
        ext.l   d1                              ; 089EE
        move.w  (CodeValue1).l,d2               ; 089F0
        ext.l   d2                              ; 089F6
        move.l  d2,-(a7)                        ; 089F8
        move.l  d1,-(a7)                        ; 089FA
        clr.l   -(a7)                           ; 089FC
        move.l  d0,-(a7)                        ; 089FE
        bsr.w   CodeHash                        ; 08A00
        lea.l   $10(a7),a7                      ; 08A04
        move.w  d0,-$2(a6)                      ; 08A08
l_000_08A0C:
        move.w  (CodeHashValue).l,d0            ; 08A0C
        ext.l   d0                              ; 08A12
        asl.l   #$1,d0                          ; 08A14
        movea.l d0,a0                           ; 08A16
        adda.l  #dat_001_001C4,a0               ; 08A18
        move.w  (a0),d0                         ; 08A1E
        move.w  -$2(a6),d1                      ; 08A20
        and.w   d1,d0                           ; 08A24
        movem.l (a7)+,d2-d3                     ; 08A26
        unlk    a6                              ; 08A2A
        rts                                     ; 08A2C
	dc.b	$00,$00

;-------------------------------------------------------------------------------
; FreeTitlePictures - Frees the planes of the instrument and front pictures (pix/inst5,
; pix/frnt5) once they have been copied.
;-------------------------------------------------------------------------------
FreeTitlePictures:
        moveq   #$0,d0                          ; 08A30
        move.w  (FrontBMHD).l,d0                ; 08A32
        moveq   #$0,d1                          ; 08A38
        move.w  (PictureBytes).l,d1             ; 08A3A
        move.l  d1,-(a7)                        ; 08A40
        move.l  d0,-(a7)                        ; 08A42
        movea.l (FrontBitMap).l,a0              ; 08A44
        move.l  $18(a0),-(a7)                   ; 08A4A
        jsr     (_FreeRaster).l                 ; 08A4E
        lea.l   $c(a7),a7                       ; 08A54
        moveq   #$0,d0                          ; 08A58
        move.w  (PanelBMHD).l,d0                ; 08A5A
        moveq   #$0,d1                          ; 08A60
        move.w  (PanelBMHDHeight).l,d1          ; 08A62
        move.l  d1,-(a7)                        ; 08A68
        move.l  d0,-(a7)                        ; 08A6A
        movea.l (PanelBitMap).l,a0              ; 08A6C
        move.l  $18(a0),-(a7)                   ; 08A72
        jsr     (_FreeRaster).l                 ; 08A76
        lea.l   $c(a7),a7                       ; 08A7C
        rts                                     ; 08A80

;-------------------------------------------------------------------------------
; SaveTitleBitMap - Keeps the title picture's plane pointers (TitlePlane0-028FC) if
; dat_071_001A6 is set.
;-------------------------------------------------------------------------------
SaveTitleBitMap:
        tst.b   (dat_071_001A6).l               ; 08A82
        beq.b   l_000_08AD0                     ; 08A88
        movea.l (TitleBitMap).l,a0              ; 08A8A
        move.l  $8(a0),(TitlePlane0).l          ; 08A90
        movea.l (TitleBitMap).l,a0              ; 08A98
        move.l  $c(a0),(TitlePlane1).l          ; 08A9E
        movea.l (TitleBitMap).l,a0              ; 08AA6
        move.l  $10(a0),(TitlePlane2).l         ; 08AAC
        movea.l (TitleBitMap).l,a0              ; 08AB4
        move.l  $14(a0),(TitlePlane3).l         ; 08ABA
        movea.l (TitleBitMap).l,a0              ; 08AC2
        move.l  $18(a0),(TitlePlane4).l         ; 08AC8
l_000_08AD0:
        rts                                     ; 08AD0

;-------------------------------------------------------------------------------
; AllocGameBuffers - Allocates the game's display buffers (chip RAM); exit if that fails.
;-------------------------------------------------------------------------------
AllocGameBuffers:
        link.w  a6,#$fffc                       ; 08AD2
        movem.l a2,-(a7)                        ; 08AD6
        movea.l (PanelBitMap).l,a0              ; 08ADA
        move.l  $8(a0),(PanelPlane0).l          ; 08AE0
        movea.l (PanelBitMap).l,a0              ; 08AE8
        move.l  $c(a0),(PanelPlane1).l          ; 08AEE
        movea.l (PanelBitMap).l,a0              ; 08AF6
        move.l  $10(a0),(PanelPlane2).l         ; 08AFC
        movea.l (PanelBitMap).l,a0              ; 08B04
        move.l  $14(a0),(PanelPlane3).l         ; 08B0A
        move.l  #$10002,-(a7)                   ; 08B12
        moveq   #$20,d0                         ; 08B18
        move.l  d0,-(a7)                        ; 08B1A
        jsr     (_AllocMem).l                   ; 08B1C
        addq.l  #$8,a7                          ; 08B22
        move.l  d0,(dat_002_02958).l            ; 08B24
        tst.l   d0                              ; 08B2A
        bne.b   l_000_08B3C                     ; 08B2C
        move.l  #$fffffc18,-(a7)                ; 08B2E
        jsr     (exit).l                        ; 08B34
        addq.l  #$4,a7                          ; 08B3A
l_000_08B3C:
        movea.l (PanelPlane0).l,a0              ; 08B3C
        adda.w  #$2d0,a0                        ; 08B42
        move.l  a0,(dat_002_0295C).l            ; 08B46
        movea.l (PanelPlane1).l,a0              ; 08B4C
        adda.w  #$2d0,a0                        ; 08B52
        move.l  a0,(dat_002_02960).l            ; 08B56
        movea.l (PanelPlane2).l,a0              ; 08B5C
        adda.w  #$2d0,a0                        ; 08B62
        move.l  a0,(dat_002_02964).l            ; 08B66
        movea.l (PanelPlane3).l,a0              ; 08B6C
        adda.w  #$2d0,a0                        ; 08B72
        move.l  a0,(dat_002_02968).l            ; 08B76
        move.w  (FrontBMHD).l,d0                ; 08B7C
        move.w  (PictureBytes).l,d1             ; 08B82
        mulu.w  d1,d0                           ; 08B88
        lsr.l   #$3,d0                          ; 08B8A
        move.l  #$10002,-(a7)                   ; 08B8C
        move.l  d0,-(a7)                        ; 08B92
        move.l  d0,-$4(a6)                      ; 08B94
        jsr     (_AllocMem).l                   ; 08B98
        addq.l  #$8,a7                          ; 08B9E
        move.l  d0,(PanelPieceMask).l           ; 08BA0
        tst.l   d0                              ; 08BA6
        bne.b   l_000_08BB8                     ; 08BA8
        move.l  #$fffffc18,-(a7)                ; 08BAA
        jsr     (exit).l                        ; 08BB0
        addq.l  #$4,a7                          ; 08BB6
l_000_08BB8:
        movea.l (FrontBitMap).l,a1              ; 08BB8
        movea.l $8(a1),a0                       ; 08BBE
        move.l  a0,(PanelPiecePlane0).l         ; 08BC2
        movea.l (FrontBitMap).l,a2              ; 08BC8
        movea.l $c(a2),a1                       ; 08BCE
        move.l  a1,(PanelPiecePlane1).l         ; 08BD2
        movea.l (FrontBitMap).l,a2              ; 08BD8
        movea.l $10(a2),a0                      ; 08BDE
        move.l  a0,(PanelPiecePlane2).l         ; 08BE2
        movea.l (FrontBitMap).l,a2              ; 08BE8
        movea.l $14(a2),a1                      ; 08BEE
        move.l  a1,(PanelPiecePlane3).l         ; 08BF2
        move.l  (PanelPieceMask).l,-(a7)        ; 08BF8
        move.l  a1,-(a7)                        ; 08BFE
        move.l  (PanelPiecePlane2).l,-(a7)      ; 08C00
        move.l  (PanelPiecePlane1).l,-(a7)      ; 08C06
        move.l  (PanelPiecePlane0).l,-(a7)      ; 08C0C
        move.l  -$4(a6),-(a7)                   ; 08C12
        bsr.b   CopyAndOr3                      ; 08C16
        lea.l   $18(a7),a7                      ; 08C18
        movem.l (a7)+,a2                        ; 08C1C
        unlk    a6                              ; 08C20
        rts                                     ; 08C22

;-------------------------------------------------------------------------------
; CopyAndOr3 - Copies one buffer into dst and ORs three more into it (n bytes each).
;-------------------------------------------------------------------------------
CopyAndOr3:
        link.w  a6,#$0                          ; 08C24
        move.l  $1c(a6),-(a7)                   ; 08C28
        move.l  $c(a6),-(a7)                    ; 08C2C
        move.l  $8(a6),-(a7)                    ; 08C30
        bsr.b   CopyBytes                       ; 08C34
        lea.l   $c(a7),a7                       ; 08C36
        move.l  $1c(a6),-(a7)                   ; 08C3A
        move.l  $10(a6),-(a7)                   ; 08C3E
        move.l  $8(a6),-(a7)                    ; 08C42
        bsr.w   OrBytes                         ; 08C46
        lea.l   $c(a7),a7                       ; 08C4A
        move.l  $1c(a6),-(a7)                   ; 08C4E
        move.l  $14(a6),-(a7)                   ; 08C52
        move.l  $8(a6),-(a7)                    ; 08C56
        bsr.w   OrBytes                         ; 08C5A
        lea.l   $c(a7),a7                       ; 08C5E
        move.l  $1c(a6),-(a7)                   ; 08C62
        move.l  $18(a6),-(a7)                   ; 08C66
        move.l  $8(a6),-(a7)                    ; 08C6A
        bsr.w   OrBytes                         ; 08C6E
        lea.l   $c(a7),a7                       ; 08C72
        unlk    a6                              ; 08C76
        rts                                     ; 08C78

;-------------------------------------------------------------------------------
; CopyBytes - CopyBytes(n, src, dst).
;-------------------------------------------------------------------------------
CopyBytes:
        link.w  a6,#$fffc                       ; 08C7A
        clr.l   -$4(a6)                         ; 08C7E
l_000_08C82:
        move.l  -$4(a6),d0                      ; 08C82
        cmp.l   $8(a6),d0                       ; 08C86
        bge.b   l_000_08CA4                     ; 08C8A
        movea.l $c(a6),a0                       ; 08C8C
        movea.l $10(a6),a1                      ; 08C90
        move.b  (a0),(a1)                       ; 08C94
        addq.l  #$1,$c(a6)                      ; 08C96
        addq.l  #$1,$10(a6)                     ; 08C9A
        addq.l  #$1,-$4(a6)                     ; 08C9E
        bra.b   l_000_08C82                     ; 08CA2
l_000_08CA4:
        unlk    a6                              ; 08CA4
        rts                                     ; 08CA6

;-------------------------------------------------------------------------------
; OrBytes - OrBytes(n, src, dst): dst |= src.
;-------------------------------------------------------------------------------
OrBytes:
        link.w  a6,#$fffc                       ; 08CA8
        clr.l   -$4(a6)                         ; 08CAC
l_000_08CB0:
        move.l  -$4(a6),d0                      ; 08CB0
        cmp.l   $8(a6),d0                       ; 08CB4
        bge.b   l_000_08CD8                     ; 08CB8
        movea.l $10(a6),a0                      ; 08CBA
        move.b  (a0),d0                         ; 08CBE
        movea.l $c(a6),a1                       ; 08CC0
        move.b  (a1),d1                         ; 08CC4
        or.b    d1,d0                           ; 08CC6
        move.b  d0,(a0)                         ; 08CC8
        addq.l  #$1,$10(a6)                     ; 08CCA
        addq.l  #$1,$c(a6)                      ; 08CCE
        addq.l  #$1,-$4(a6)                     ; 08CD2
        bra.b   l_000_08CB0                     ; 08CD6
l_000_08CD8:
        unlk    a6                              ; 08CD8
        rts                                     ; 08CDA

;-------------------------------------------------------------------------------
; OpenKeyboard - Opens keyboard.device and queues a KBD_READEVENT (command 9) for one
; InputEvent (22 bytes, dat_002_029AA).
;-------------------------------------------------------------------------------
OpenKeyboard:
        moveq   #$0,d0                          ; 08CDC
        move.l  d0,-(a7)                        ; 08CDE
        move.l  (dat_001_001FC).l,-(a7)         ; 08CE0
        move.l  d0,-(a7)                        ; 08CE6
        pea.l   (StrKeyboardDevice).l           ; 08CE8
        jsr     (_OpenDevice).l                 ; 08CEE
        lea.l   $10(a7),a7                      ; 08CF4
        move.l  (dat_001_00224).l,-(a7)         ; 08CF8
        move.w  d0,(dat_002_029A8).l            ; 08CFE
        jsr     (MakePort).l                    ; 08D04
        addq.l  #$4,a7                          ; 08D0A
        movea.l (dat_001_001FC).l,a0            ; 08D0C
        move.l  (dat_001_00224).l,$e(a0)        ; 08D12
        moveq   #$16,d0                         ; 08D1A
        move.l  d0,$24(a0)                      ; 08D1C
        lea.l   (dat_002_029AA).l,a1            ; 08D20
        move.l  a1,$28(a0)                      ; 08D26
        move.w  #$9,$1c(a0)                     ; 08D2A
        move.l  a0,-(a7)                        ; 08D30
        move.l  a1,(KeyboardRequest).l          ; 08D32
        jsr     (_SendIO).l                     ; 08D38
        addq.l  #$4,a7                          ; 08D3E
        rts                                     ; 08D40

;-------------------------------------------------------------------------------
; ReadKeyEvent - If the keyboard request has come back: takes the event's raw key code
; (ie_Code), queues the request again and returns the code; 0 if no key.
;-------------------------------------------------------------------------------
ReadKeyEvent:
        link.w  a6,#$fffa                       ; 08D42
        move.l  (dat_001_00224).l,-(a7)         ; 08D46
        jsr     (_GetMsg).l                     ; 08D4C
        addq.l  #$4,a7                          ; 08D52
        move.l  d0,-$6(a6)                      ; 08D54
        tst.l   d0                              ; 08D58
        bne.b   l_000_08D62                     ; 08D5A
        moveq   #$0,d0                          ; 08D5C
        unlk    a6                              ; 08D5E
        rts                                     ; 08D60
l_000_08D62:
        movea.l (KeyboardRequest).l,a0          ; 08D62
        move.w  $6(a0),d0                       ; 08D68
        clr.w   $6(a0)                          ; 08D6C
        move.l  (dat_001_001FC).l,-(a7)         ; 08D70
        move.b  d0,-$1(a6)                      ; 08D76
        jsr     (_SendIO).l                     ; 08D7A
        addq.l  #$4,a7                          ; 08D80
        move.b  -$1(a6),d0                      ; 08D82
        unlk    a6                              ; 08D86
        rts                                     ; 08D88

;-------------------------------------------------------------------------------
; PushKey - PushKey(code): makes GetKey return code next time (a key pressed by the program).
;-------------------------------------------------------------------------------
PushKey:
        link.w  a6,#$0                          ; 08D8A
        move.w  #$1,(dat_001_0024A).l           ; 08D8E
        move.b  $b(a6),d0                       ; 08D96
        ext.w   d0                              ; 08D9A
        move.w  d0,(LastKey).l                  ; 08D9C
        unlk    a6                              ; 08DA2
        rts                                     ; 08DA4

;-------------------------------------------------------------------------------
; GetKey - The next key: a pushed one (PushKey), or one from the keyboard; $FF if there is none
; or it is one of the special codes $70-$7F. A key press is returned as its raw key code, a
; release with $80 added.
;-------------------------------------------------------------------------------
GetKey:
        link.w  a6,#$fffc                       ; 08DA6
        tst.w   (dat_001_0024A).l               ; 08DAA
        beq.b   l_000_08DC2                     ; 08DB0
        clr.w   (dat_001_0024A).l               ; 08DB2
        move.w  (LastKey).l,d0                  ; 08DB8
        unlk    a6                              ; 08DBE
        rts                                     ; 08DC0
l_000_08DC2:
        bsr.w   ReadKeyEvent                    ; 08DC2
        move.b  d0,-$2(a6)                      ; 08DC6
        tst.b   d0                              ; 08DCA
        bne.b   l_000_08DD6                     ; 08DCC
        move.w  #$ff,d0                         ; 08DCE
        unlk    a6                              ; 08DD2
        rts                                     ; 08DD4
l_000_08DD6:
        move.b  -$2(a6),d0                      ; 08DD6
        andi.b  #$7f,d0                         ; 08DDA
        move.b  d0,-$1(a6)                      ; 08DDE
        andi.b  #$70,d0                         ; 08DE2
        cmpi.b  #$70,d0                         ; 08DE6
        bne.b   l_000_08DF4                     ; 08DEA
        move.w  #$ff,d0                         ; 08DEC
        unlk    a6                              ; 08DF0
        rts                                     ; 08DF2
l_000_08DF4:
        move.b  -$2(a6),d0                      ; 08DF4
        andi.b  #$80,d0                         ; 08DF8
        seq.b   d1                              ; 08DFC
        neg.b   d1                              ; 08DFE
        ext.w   d1                              ; 08E00
        ext.l   d1                              ; 08E02
        move.w  d1,-$4(a6)                      ; 08E04
        tst.w   d1                              ; 08E08
        bne.b   l_000_08E1E                     ; 08E0A
        move.b  -$1(a6),d0                      ; 08E0C
        ext.w   d0                              ; 08E10
        ext.l   d0                              ; 08E12
        addi.l  #$80,d0                         ; 08E14
        move.b  d0,-$1(a6)                      ; 08E1A
l_000_08E1E:
        move.b  -$1(a6),d0                      ; 08E1E
        ext.w   d0                              ; 08E22
        unlk    a6                              ; 08E24
        rts                                     ; 08E26

;-------------------------------------------------------------------------------
; OpenTimer - Opens timer.device (UNIT_MICROHZ) into TimerRequest.
;-------------------------------------------------------------------------------
OpenTimer:
        link.w  a6,#$fffe                       ; 08E28
        moveq   #$0,d0                          ; 08E2C
        move.l  d0,-(a7)                        ; 08E2E
        pea.l   (TimerRequest).l                ; 08E30
        move.l  d0,-(a7)                        ; 08E36
        pea.l   (StrTimerDevice).l              ; 08E38
        jsr     (_OpenDevice).l                 ; 08E3E
        lea.l   $10(a7),a7                      ; 08E44
        move.w  d0,-$2(a6)                      ; 08E48
        tst.w   d0                              ; 08E4C
        nop                                     ; 08E4E
        unlk    a6                              ; 08E50
        rts                                     ; 08E52

;-------------------------------------------------------------------------------
; ReadTime - TR_GETSYSTIME: the system time into TimeSeconds (seconds) and TimeMicros
; (microseconds).
;-------------------------------------------------------------------------------
ReadTime:
        move.b  #$5,(dat_002_02984).l           ; 08E54
        clr.b   (dat_002_02985).l               ; 08E5C
        suba.l  a0,a0                           ; 08E62
        move.l  a0,(dat_002_02986).l            ; 08E64
        move.l  a0,(dat_002_0298A).l            ; 08E6A
        move.w  #$a,(dat_002_02998).l           ; 08E70
        pea.l   (TimerRequest).l                ; 08E78
        jsr     (_DoIO).l                       ; 08E7E
        addq.l  #$4,a7                          ; 08E84
        move.l  (dat_002_0299C).l,(TimeSeconds).l ; 08E86
        move.l  (dat_002_029A0).l,(TimeMicros).l ; 08E90
        rts                                     ; 08E9A

;-------------------------------------------------------------------------------
; OpenJoystick - Opens gameport.device unit 1 (the joystick port): creates its port and request
; (exit -1/-2/-3 on failure), sets it to an absolute joystick (SetJoystickType 3) and its
; trigger (SetJoystickTrigger), and queues a GPD_READEVENT.
;-------------------------------------------------------------------------------
OpenJoystick:
        link.w  a6,#$fffe                       ; 08E9C
        move.l  #JoystickEvent,(JoystickEventPtr).l ; 08EA0
        moveq   #$0,d0                          ; 08EAA
        move.l  d0,-(a7)                        ; 08EAC
        move.l  d0,-(a7)                        ; 08EAE
        jsr     (_CreatePort).l                 ; 08EB0
        addq.l  #$8,a7                          ; 08EB6
        move.l  d0,(JoystickRequest).l          ; 08EB8
        tst.l   d0                              ; 08EBE
        bne.b   l_000_08ECE                     ; 08EC0
        moveq   #-1,d0                          ; 08EC2
        move.l  d0,-(a7)                        ; 08EC4
        jsr     (exit).l                        ; 08EC6
        addq.l  #$4,a7                          ; 08ECC
l_000_08ECE:
        move.l  (JoystickRequest).l,-(a7)       ; 08ECE
        jsr     (_CreateStdIO).l                ; 08ED4
        addq.l  #$4,a7                          ; 08EDA
        move.l  d0,(JoystickPort).l             ; 08EDC
        tst.l   d0                              ; 08EE2
        bne.b   l_000_08F00                     ; 08EE4
        move.l  (JoystickRequest).l,-(a7)       ; 08EE6
        jsr     (_DeletePort).l                 ; 08EEC
        addq.l  #$4,a7                          ; 08EF2
        moveq   #-2,d0                          ; 08EF4
        move.l  d0,-(a7)                        ; 08EF6
        jsr     (exit).l                        ; 08EF8
        addq.l  #$4,a7                          ; 08EFE
l_000_08F00:
        clr.l   -(a7)                           ; 08F00
        move.l  (JoystickPort).l,-(a7)          ; 08F02
        moveq   #$1,d0                          ; 08F08
        move.l  d0,-(a7)                        ; 08F0A
        pea.l   (StrGameportDevice).l           ; 08F0C
        jsr     (_OpenDevice).l                 ; 08F12
        lea.l   $10(a7),a7                      ; 08F18
        move.w  d0,-$2(a6)                      ; 08F1C
        tst.w   d0                              ; 08F20
        beq.b   l_000_08F4C                     ; 08F22
        move.l  (JoystickPort).l,-(a7)          ; 08F24
        jsr     (_DeleteStdIO).l                ; 08F2A
        addq.l  #$4,a7                          ; 08F30
        move.l  (JoystickRequest).l,-(a7)       ; 08F32
        jsr     (_DeletePort).l                 ; 08F38
        addq.l  #$4,a7                          ; 08F3E
        moveq   #-3,d0                          ; 08F40
        move.l  d0,-(a7)                        ; 08F42
        jsr     (exit).l                        ; 08F44
        addq.l  #$4,a7                          ; 08F4A
l_000_08F4C:
        move.l  #JoystickEvent,(JoystickEventPtr2).l ; 08F4C
        moveq   #$3,d0                          ; 08F56
        move.l  d0,-(a7)                        ; 08F58
        bsr.w   SetJoystickType                 ; 08F5A
        addq.l  #$4,a7                          ; 08F5E
        tst.l   d0                              ; 08F60
        beq.b   l_000_08F8C                     ; 08F62
        move.l  (JoystickPort).l,-(a7)          ; 08F64
        jsr     (_DeleteStdIO).l                ; 08F6A
        addq.l  #$4,a7                          ; 08F70
        move.l  (JoystickRequest).l,-(a7)       ; 08F72
        jsr     (_DeletePort).l                 ; 08F78
        addq.l  #$4,a7                          ; 08F7E
        moveq   #-4,d0                          ; 08F80
        move.l  d0,-(a7)                        ; 08F82
        jsr     (exit).l                        ; 08F84
        addq.l  #$4,a7                          ; 08F8A
l_000_08F8C:
        bsr.w   SetJoystickTrigger              ; 08F8C
        tst.l   d0                              ; 08F90
        beq.b   l_000_08FBC                     ; 08F92
        move.l  (JoystickPort).l,-(a7)          ; 08F94
        jsr     (_DeleteStdIO).l                ; 08F9A
        addq.l  #$4,a7                          ; 08FA0
        move.l  (JoystickRequest).l,-(a7)       ; 08FA2
        jsr     (_DeletePort).l                 ; 08FA8
        addq.l  #$4,a7                          ; 08FAE
        moveq   #-4,d0                          ; 08FB0
        move.l  d0,-(a7)                        ; 08FB2
        jsr     (exit).l                        ; 08FB4
        addq.l  #$4,a7                          ; 08FBA
l_000_08FBC:
        movea.l (JoystickPort).l,a0             ; 08FBC
        move.w  #$9,$1c(a0)                     ; 08FC2
        movea.l (JoystickPort).l,a0             ; 08FC8
        move.l  #JoystickEvent,$28(a0)          ; 08FCE
        moveq   #$16,d0                         ; 08FD6
        movea.l (JoystickPort).l,a0             ; 08FD8
        move.l  d0,$24(a0)                      ; 08FDE
        clr.b   $1e(a0)                         ; 08FE2
        movea.l (JoystickPort).l,a0             ; 08FE6
        move.l  d0,$24(a0)                      ; 08FEC
        move.l  a0,-(a7)                        ; 08FF0
        jsr     (_SendIO).l                     ; 08FF2
        addq.l  #$4,a7                          ; 08FF8
        unlk    a6                              ; 08FFA
        rts                                     ; 08FFC

;-------------------------------------------------------------------------------
; ReadJoystick - Takes the joystick's event if there is one: fire button down ($68,
; IECODE_LBUTTON) -> FirePressed, up ($E8) -> FireReleased; queues the request again; then
; reads the stick itself (ReadStick).
;-------------------------------------------------------------------------------
ReadJoystick:
        link.w  a6,#$fffa                       ; 08FFE
        move.l  (JoystickRequest).l,-(a7)       ; 09002
        jsr     (_GetMsg).l                     ; 09008
        addq.l  #$4,a7                          ; 0900E
        move.l  d0,-$6(a6)                      ; 09010
        tst.l   d0                              ; 09014
        bne.b   l_000_09020                     ; 09016
        clr.b   (dat_071_001FD).l               ; 09018
        bra.b   l_000_09066                     ; 0901E
l_000_09020:
        movea.l (JoystickEventPtr2).l,a0        ; 09020
        move.w  $6(a0),d0                       ; 09026
        move.w  d0,-$2(a6)                      ; 0902A
        tst.w   d0                              ; 0902E
        beq.b   l_000_0904E                     ; 09030
        cmpi.w  #$68,d0                         ; 09032
        bne.b   l_000_09040                     ; 09036
        jsr     (FirePressed).l                 ; 09038
        bra.b   l_000_0904E                     ; 0903E
l_000_09040:
        cmpi.w  #$e8,-$2(a6)                    ; 09040
        bne.b   l_000_0904E                     ; 09046
        jsr     (FireReleased).l                ; 09048
l_000_0904E:
        movea.l (JoystickEventPtr2).l,a0        ; 0904E
        clr.w   $6(a0)                          ; 09054
        move.l  (JoystickPort).l,-(a7)          ; 09058
        jsr     (_SendIO).l                     ; 0905E
        addq.l  #$4,a7                          ; 09064
l_000_09066:
        bsr.b   ReadStick                       ; 09066
        unlk    a6                              ; 09068
        rts                                     ; 0906A

;-------------------------------------------------------------------------------
; ReadStick - Reads JOY1DAT ($DFF00C) directly and turns it into the stick's directions
; (dat_071_00320).
;-------------------------------------------------------------------------------
ReadStick:
        link.w  a6,#$fff6                       ; 0906C
        move.l  #$dff00c,-$4(a6)                ; 09070
        movea.l -$4(a6),a0                      ; 09078
        move.w  (a0),d0                         ; 0907C
        move.w  d0,(dat_071_00320).l            ; 0907E
        move.w  d0,-$6(a6)                      ; 09084
        ext.l   d0                              ; 09088
        move.l  d0,$0(a7)                       ; 0908A
        andi.l  #$200,d0                        ; 0908E
        asr.l   #$1,d0                          ; 09094
        move.l  $0(a7),d1                       ; 09096
        andi.l  #$100,d1                        ; 0909A
        eor.l   d1,d0                           ; 090A0
        tst.l   d0                              ; 090A2
        beq.b   l_000_090B6                     ; 090A4
        jsr     (StickUp).l                     ; 090A6
        move.b  #$1,(dat_071_00201).l           ; 090AC
        bra.b   l_000_090FC                     ; 090B4
l_000_090B6:
        move.w  -$6(a6),d0                      ; 090B6
        ext.l   d0                              ; 090BA
        move.l  d0,$0(a7)                       ; 090BC
        andi.l  #$2,d0                          ; 090C0
        asr.l   #$1,d0                          ; 090C6
        move.l  $0(a7),d1                       ; 090C8
        andi.l  #$1,d1                          ; 090CC
        eor.l   d1,d0                           ; 090D2
        tst.l   d0                              ; 090D4
        beq.b   l_000_090E8                     ; 090D6
        jsr     (StickDown).l                   ; 090D8
        move.b  #$1,(dat_071_00201).l           ; 090DE
        bra.b   l_000_090FC                     ; 090E6
l_000_090E8:
        tst.b   (dat_071_00201).l               ; 090E8
        beq.b   l_000_090FC                     ; 090EE
        jsr     (StickPitchCentre).l            ; 090F0
        clr.b   (dat_071_00201).l               ; 090F6
l_000_090FC:
        btst    #$1,-$6(a6)                     ; 090FC
        beq.b   l_000_09114                     ; 09102
        jsr     (StickLeft).l                   ; 09104
        move.b  #$1,(dat_071_00202).l           ; 0910A
        bra.b   l_000_09140                     ; 09112
l_000_09114:
        btst    #$1,-$5(a6)                     ; 09114
        beq.b   l_000_0912C                     ; 0911A
        jsr     (StickRight).l                  ; 0911C
        move.b  #$1,(dat_071_00202).l           ; 09122
        bra.b   l_000_09140                     ; 0912A
l_000_0912C:
        tst.b   (dat_071_00202).l               ; 0912C
        beq.b   l_000_09140                     ; 09132
        jsr     (StickRollCentre).l             ; 09134
        clr.b   (dat_071_00202).l               ; 0913A
l_000_09140:
        unlk    a6                              ; 09140
        rts                                     ; 09142

;-------------------------------------------------------------------------------
; SetJoystickType - GPD_SETCTYPE: SetJoystickType(type) (3 = GPCT_ABSJOYSTICK).
;-------------------------------------------------------------------------------
SetJoystickType:
        link.w  a6,#$0                          ; 09144
        movea.l (JoystickPort).l,a0             ; 09148
        move.w  #$b,$1c(a0)                     ; 0914E
        moveq   #$1,d0                          ; 09154
        movea.l (JoystickPort).l,a0             ; 09156
        move.l  d0,$24(a0)                      ; 0915C
        movea.l (JoystickPort).l,a0             ; 09160
        move.l  (JoystickEventPtr).l,$28(a0)    ; 09166
        move.w  $a(a6),d0                       ; 0916E
        movea.l (JoystickEventPtr).l,a0         ; 09172
        move.b  d0,(a0)                         ; 09178
        move.l  (JoystickPort).l,-(a7)          ; 0917A
        jsr     (_SendIO).l                     ; 09180
        addq.l  #$4,a7                          ; 09186
        move.l  (JoystickRequest).l,-(a7)       ; 09188
        jsr     (_WaitPort).l                   ; 0918E
        addq.l  #$4,a7                          ; 09194
        move.l  (JoystickRequest).l,-(a7)       ; 09196
        jsr     (_GetMsg).l                     ; 0919C
        addq.l  #$4,a7                          ; 091A2
        movea.l (JoystickPort).l,a0             ; 091A4
        move.b  $1f(a0),d0                      ; 091AA
        ext.w   d0                              ; 091AE
        ext.l   d0                              ; 091B0
        unlk    a6                              ; 091B2
        rts                                     ; 091B4

;-------------------------------------------------------------------------------
; SetJoystickTrigger - GPD_SETTRIGGER: report every button change.
;-------------------------------------------------------------------------------
SetJoystickTrigger:
        link.w  a6,#$fff8                       ; 091B6
        movea.l (JoystickPort).l,a0             ; 091BA
        move.w  #$d,$1c(a0)                     ; 091C0
        moveq   #$8,d0                          ; 091C6
        movea.l (JoystickPort).l,a0             ; 091C8
        move.l  d0,$24(a0)                      ; 091CE
        lea.l   -$8(a6),a0                      ; 091D2
        movea.l (JoystickPort).l,a1             ; 091D6
        move.l  a0,$28(a1)                      ; 091DC
        move.w  #$3,-$8(a6)                     ; 091E0
        clr.w   -$6(a6)                         ; 091E6
        moveq   #$1,d0                          ; 091EA
        move.w  d0,-$4(a6)                      ; 091EC
        move.w  d0,-$2(a6)                      ; 091F0
        move.l  a1,-(a7)                        ; 091F4
        jsr     (_DoIO).l                       ; 091F6
        addq.l  #$4,a7                          ; 091FC
        unlk    a6                              ; 091FE
        rts                                     ; 09200

;-------------------------------------------------------------------------------
; CloseJoystick - Closes the joystick and keyboard devices (sets the controller type back
; first).
;-------------------------------------------------------------------------------
CloseJoystick:
        move.l  (dat_001_001FC).l,-(a7)         ; 09202
        jsr     (_CloseDevice).l                ; 09208
        addq.l  #$4,a7                          ; 0920E
        move.l  (dat_001_001FC).l,-(a7)         ; 09210
        jsr     (_DeleteStdIO).l                ; 09216
        addq.l  #$4,a7                          ; 0921C
        pea.l   (TimerRequest).l                ; 0921E
        jsr     (_CloseDevice).l                ; 09224
        addq.l  #$4,a7                          ; 0922A
        clr.l   -(a7)                           ; 0922C
        bsr.w   SetJoystickType                 ; 0922E
        addq.l  #$4,a7                          ; 09232
        move.l  (JoystickPort).l,-(a7)          ; 09234
        jsr     (_CloseDevice).l                ; 0923A
        addq.l  #$4,a7                          ; 09240
        move.l  (JoystickPort).l,-(a7)          ; 09242
        jsr     (_DeleteStdIO).l                ; 09248
        addq.l  #$4,a7                          ; 0924E
        moveq   #$0,d0                          ; 09250
        rts                                     ; 09252

;-------------------------------------------------------------------------------
; SetMouseLimits - SetMouseLimits(minx, miny, maxx, maxy) for the mouse pointer the interrupt
; moves.
;-------------------------------------------------------------------------------
SetMouseLimits:
        link.w  a6,#$0                          ; 09254
        move.w  $a(a6),(dat_001_00274).l        ; 09258
        move.w  $e(a6),(dat_001_00276).l        ; 09260
        move.w  $12(a6),(dat_001_00278).l       ; 09268
        move.w  $16(a6),(dat_001_0027A).l       ; 09270
        unlk    a6                              ; 09278
        rts                                     ; 0927A

;-------------------------------------------------------------------------------
; InitMouse - Reads the mouse counters (JOY0DAT, $DFF00A) as the starting point and installs
; the vertical blank interrupt that follows the mouse (AddMouseInterrupt).
;-------------------------------------------------------------------------------
InitMouse:
        link.w  a6,#$fffe                       ; 0927C
        move.w  (CUSTOM+JOY0DAT).l,d0           ; 09280
        move.w  d0,-$2(a6)                      ; 09286
        andi.w  #$ff,d0                         ; 0928A
        move.w  -$2(a6),d1                      ; 0928E
        asr.w   #$8,d1                          ; 09292
        andi.w  #$ff,d1                         ; 09294
        move.w  d0,(MouseLastX).l               ; 09298
        move.w  d1,(MouseLastY).l               ; 0929E
        bsr.w   AddMouseInterrupt               ; 092A4
        unlk    a6                              ; 092A8
        rts                                     ; 092AA

;-------------------------------------------------------------------------------
; ReadButtons - The fire / mouse buttons: bit 0 = left (CIAA PRA bit 6), bit 1 = right (POTGOR
; bit 10).
;-------------------------------------------------------------------------------
ReadButtons:
        link.w  a6,#$fffe                       ; 092AC
        movem.l d7,-(a7)                        ; 092B0
        moveq   #$0,d7                          ; 092B4
        move.b  (dat_002_00192).l,d0            ; 092B6
        btst    #$6,d0                          ; 092BC
        bne.b   l_000_092C4                     ; 092C0
        moveq   #$1,d7                          ; 092C2
l_000_092C4:
        move.w  (CUSTOM+POTGOR).l,d0            ; 092C4
        btst    #$a,d0                          ; 092CA
        bne.b   l_000_092D4                     ; 092CE
        bset    #$1,d7                          ; 092D0
l_000_092D4:
        move.l  d7,d0                           ; 092D4
        movem.l (a7)+,d7                        ; 092D6
        unlk    a6                              ; 092DA
        rts                                     ; 092DC
; MouseInterrupt - The vertical blank interrupt server's code: the mouse counters' change
; (JOY0DAT) added to the pointer position, clamped to SetMouseLimits.
MouseInterrupt:
        link.w  a6,#$ffea                       ; 092DE
        movem.l d2,-(a7)                        ; 092E2
        move.w  (CUSTOM+JOY0DAT).l,d0           ; 092E6
        move.w  d0,-$4(a6)                      ; 092EC
        andi.w  #$ff,d0                         ; 092F0
        move.w  -$4(a6),d1                      ; 092F4
        asr.w   #$8,d1                          ; 092F8
        andi.w  #$ff,d1                         ; 092FA
        move.w  d0,-$6(a6)                      ; 092FE
        sub.w   (MouseLastX).l,d0               ; 09302
        move.w  d1,-$8(a6)                      ; 09308
        sub.w   (MouseLastY).l,d1               ; 0930C
        move.w  d0,-$a(a6)                      ; 09312
        move.w  d1,-$c(a6)                      ; 09316
        cmpi.w  #$ff80,d0                       ; 0931A
        bge.b   l_000_09328                     ; 0931E
        addi.w  #$100,-$a(a6)                   ; 09320
        bra.b   l_000_09338                     ; 09326
l_000_09328:
        move.w  -$a(a6),d0                      ; 09328
        cmpi.w  #$7f,d0                         ; 0932C
        ble.b   l_000_09338                     ; 09330
        subi.w  #$100,-$a(a6)                   ; 09332
l_000_09338:
        move.w  -$c(a6),d0                      ; 09338
        cmpi.w  #$ff80,d0                       ; 0933C
        bge.b   l_000_0934A                     ; 09340
        addi.w  #$100,-$c(a6)                   ; 09342
        bra.b   l_000_0935A                     ; 09348
l_000_0934A:
        move.w  -$c(a6),d0                      ; 0934A
        cmpi.w  #$7f,d0                         ; 0934E
        ble.b   l_000_0935A                     ; 09352
        subi.w  #$100,-$c(a6)                   ; 09354
l_000_0935A:
        move.b  (dat_071_001A8).l,d0            ; 0935A
        tst.b   d0                              ; 09360
        bne.b   l_000_09374                     ; 09362
        tst.w   -$c(a6)                         ; 09364
        bpl.b   l_000_09374                     ; 09368
        move.w  -$c(a6),d0                      ; 0936A
        asr.w   #$1,d0                          ; 0936E
        move.w  d0,-$c(a6)                      ; 09370
l_000_09374:
        move.w  (MouseX).l,d0                   ; 09374
        add.w   -$a(a6),d0                      ; 0937A
        move.w  d0,(MouseX).l                   ; 0937E
        move.w  (MouseY).l,d1                   ; 09384
        sub.w   -$c(a6),d1                      ; 0938A
        move.w  d1,(MouseY).l                   ; 0938E
        move.w  (MouseX).l,d0                   ; 09394
        move.w  (dat_001_00278).l,d1            ; 0939A
        cmp.w   d0,d1                           ; 093A0
        blt.b   l_000_093AA                     ; 093A2
        move.w  (MouseX).l,d1                   ; 093A4
l_000_093AA:
        move.w  (dat_001_00274).l,d0            ; 093AA
        cmp.w   d1,d0                           ; 093B0
        bgt.b   l_000_093CC                     ; 093B2
        move.w  (MouseX).l,d0                   ; 093B4
        move.w  (dat_001_00278).l,d1            ; 093BA
        cmp.w   d0,d1                           ; 093C0
        blt.b   l_000_093CA                     ; 093C2
        move.w  (MouseX).l,d1                   ; 093C4
l_000_093CA:
        move.l  d1,d0                           ; 093CA
l_000_093CC:
        move.w  d0,(MouseX).l                   ; 093CC
        move.w  (MouseY).l,d0                   ; 093D2
        move.w  (dat_001_0027A).l,d1            ; 093D8
        cmp.w   d0,d1                           ; 093DE
        blt.b   l_000_093E8                     ; 093E0
        move.w  (MouseY).l,d1                   ; 093E2
l_000_093E8:
        move.w  (dat_001_00276).l,d0            ; 093E8
        cmp.w   d1,d0                           ; 093EE
        bgt.b   l_000_0940A                     ; 093F0
        move.w  (MouseY).l,d0                   ; 093F2
        move.w  (dat_001_0027A).l,d1            ; 093F8
        cmp.w   d0,d1                           ; 093FE
        blt.b   l_000_09408                     ; 09400
        move.w  (MouseY).l,d1                   ; 09402
l_000_09408:
        move.l  d1,d0                           ; 09408
l_000_0940A:
        move.w  d0,(MouseY).l                   ; 0940A
        move.w  -$6(a6),(MouseLastX).l          ; 09410
        move.w  -$8(a6),(MouseLastY).l          ; 09418
        move.w  (dat_071_00144).l,d0            ; 09420
        addq.w  #$1,d0                          ; 09426
        move.w  d0,(dat_071_00144).l            ; 09428
        move.b  (FadeLevel).l,d0                ; 0942E
        move.b  (FadeTarget).l,d1               ; 09434
        cmp.b   d1,d0                           ; 0943A
        beq.w   l_000_09574                     ; 0943C
        move.b  (dat_071_00273).l,d2            ; 09440
        subq.b  #$1,d2                          ; 09446
        move.b  d2,(dat_071_00273).l            ; 09448
        tst.b   d2                              ; 0944E
        bpl.w   l_000_09596                     ; 09450
        cmp.b   d1,d0                           ; 09454
        ble.b   l_000_0946A                     ; 09456
        subq.b  #$1,d0                          ; 09458
        move.b  d0,(FadeLevel).l                ; 0945A
        move.b  #$1,(dat_071_00273).l           ; 09460
        bra.b   l_000_09480                     ; 09468
l_000_0946A:
        move.b  (FadeLevel).l,d0                ; 0946A
        addq.b  #$1,d0                          ; 09470
        move.b  d0,(FadeLevel).l                ; 09472
        move.b  #$2,(dat_071_00273).l           ; 09478
l_000_09480:
        lea.l   (dat_021_00080).l,a0            ; 09480
        move.b  (FadeLevel).l,d0                ; 09486
        ext.w   d0                              ; 0948C
        ext.l   d0                              ; 0948E
        moveq   #$f,d1                          ; 09490
        sub.l   d0,d1                           ; 09492
        asl.l   #$4,d1                          ; 09494
        asl.l   #$1,d1                          ; 09496
        adda.l  d1,a0                           ; 09498
        moveq   #$10,d0                         ; 0949A
        move.l  d0,-(a7)                        ; 0949C
        move.l  a0,-(a7)                        ; 0949E
        pea.l   (GameViewPort).l                ; 094A0
        move.l  a0,-$10(a6)                     ; 094A6
        jsr     (_LoadRGB4).l                   ; 094AA
        lea.l   $c(a7),a7                       ; 094B0
        move.w  (DisplayBuffer).l,d0            ; 094B4
        moveq   #$1,d1                          ; 094BA
        sub.w   d0,d1                           ; 094BC
        move.w  d1,-$16(a6)                     ; 094BE
        ext.l   d1                              ; 094C2
        asl.l   #$2,d1                          ; 094C4
        movea.l d1,a0                           ; 094C6
        adda.l  #CopperBuffer1,a0               ; 094C8
        move.l  (a0),(GameViewLOFCprList).l     ; 094CE
        move.w  -$16(a6),d0                     ; 094D4
        ext.l   d0                              ; 094D8
        asl.l   #$2,d0                          ; 094DA
        movea.l d0,a0                           ; 094DC
        adda.l  #CopperBuffer2,a0               ; 094DE
        move.l  (a0),(GameViewPortDspIns).l     ; 094E4
        moveq   #$10,d0                         ; 094EA
        move.l  d0,-(a7)                        ; 094EC
        move.l  -$10(a6),-(a7)                  ; 094EE
        pea.l   (GameViewPort).l                ; 094F2
        jsr     (_LoadRGB4).l                   ; 094F8
        lea.l   $c(a7),a7                       ; 094FE
        move.w  -$16(a6),d0                     ; 09502
        ext.l   d0                              ; 09506
        asl.l   #$2,d0                          ; 09508
        movea.l d0,a0                           ; 0950A
        adda.l  #CopperBuffer1,a0               ; 0950C
        move.l  (a0),(GameViewLOFCprList).l     ; 09512
        move.w  -$16(a6),d0                     ; 09518
        ext.l   d0                              ; 0951C
        asl.l   #$2,d0                          ; 0951E
        movea.l d0,a0                           ; 09520
        adda.l  #CopperBuffer2,a0               ; 09522
        move.l  (a0),(GameViewPortDspIns).l     ; 09528
        move.b  (FadeLevel).l,d0                ; 0952E
        move.b  (FadeTarget).l,d1               ; 09534
        cmp.b   d1,d0                           ; 0953A
        bne.b   l_000_09596                     ; 0953C
        move.l  (LivePalette).l,-$14(a6)        ; 0953E
        clr.w   -$2(a6)                         ; 09546
l_000_0954A:
        cmpi.w  #$10,-$2(a6)                    ; 0954A
        bge.b   l_000_0956A                     ; 09550
        movea.l -$10(a6),a0                     ; 09552
        movea.l -$14(a6),a1                     ; 09556
        move.w  (a0),(a1)                       ; 0955A
        addq.l  #$2,-$10(a6)                    ; 0955C
        addq.l  #$2,-$14(a6)                    ; 09560
        addq.w  #$1,-$2(a6)                     ; 09564
        bra.b   l_000_0954A                     ; 09568
l_000_0956A:
        move.b  #$3,(PaletteLoadCount).l        ; 0956A
        bra.b   l_000_09596                     ; 09572
l_000_09574:
        tst.b   (PaletteLoadCount).l            ; 09574
        beq.b   l_000_09596                     ; 0957A
        moveq   #$10,d0                         ; 0957C
        move.l  d0,-(a7)                        ; 0957E
        move.l  (LivePalette).l,-(a7)           ; 09580
        pea.l   (GameViewPort).l                ; 09586
        jsr     (_LoadRGB4).l                   ; 0958C
        lea.l   $c(a7),a7                       ; 09592
l_000_09596:
        jsr     (sub_020_00238).l               ; 09596
        moveq   #$0,d0                          ; 0959C
        movem.l (a7)+,d2                        ; 0959E
        unlk    a6                              ; 095A2
        rts                                     ; 095A4
AddMouseInterrupt:
        move.b  #$2,(dat_002_029F0).l           ; 095A6
        clr.b   (dat_002_029F1).l               ; 095AE
        move.l  #dat_001_0027C,(dat_002_029F2).l ; 095B4
        lea.l   MouseInterrupt(pc),a0           ; 095BE
        move.l  a0,(dat_002_029FA).l            ; 095C2
        pea.l   (MouseInterruptNode).l          ; 095C8
        moveq   #$5,d0                          ; 095CE
        move.l  d0,-(a7)                        ; 095D0
        jsr     (_AddIntServer).l               ; 095D2
        addq.l  #$8,a7                          ; 095D8
        rts                                     ; 095DA

;-------------------------------------------------------------------------------
; RemoveMouseInterrupt - RemIntServer the mouse interrupt.
;-------------------------------------------------------------------------------
RemoveMouseInterrupt:
        pea.l   (MouseInterruptNode).l          ; 095DC
        moveq   #$5,d0                          ; 095E2
        move.l  d0,-(a7)                        ; 095E4
        jsr     (_RemIntServer).l               ; 095E6
        addq.l  #$8,a7                          ; 095EC
        rts                                     ; 095EE
MakePort:
        link.w  a6,#$0                          ; 095F0
        moveq   #$0,d0                          ; 095F4
        movea.l $8(a6),a0                       ; 095F6
        move.b  d0,$e(a0)                       ; 095FA
        move.b  d0,$9(a0)                       ; 095FE
        clr.l   $a(a0)                          ; 09602
        move.b  #$4,$8(a0)                      ; 09606
        moveq   #-1,d0                          ; 0960C
        move.l  d0,-(a7)                        ; 0960E
        jsr     (_AllocSignal).l                ; 09610
        addq.l  #$4,a7                          ; 09616
        movea.l $8(a6),a0                       ; 09618
        move.b  d0,$f(a0)                       ; 0961C
        clr.l   -(a7)                           ; 09620
        jsr     (_FindTask).l                   ; 09622
        addq.l  #$4,a7                          ; 09628
        movea.l $8(a6),a0                       ; 0962A
        move.l  d0,$10(a0)                      ; 0962E
        adda.w  #$14,a0                         ; 09632
        move.l  a0,-(a7)                        ; 09636
        jsr     (_NewList).l                    ; 09638
        addq.l  #$4,a7                          ; 0963E
        unlk    a6                              ; 09640
        rts                                     ; 09642
UnmakePort:
        link.w  a6,#$0                          ; 09644
        moveq   #$0,d0                          ; 09648
        movea.l $8(a6),a0                       ; 0964A
        move.b  $f(a0),d0                       ; 0964E
        move.l  d0,-(a7)                        ; 09652
        jsr     (_FreeSignal).l                 ; 09654
        addq.l  #$4,a7                          ; 0965A
        unlk    a6                              ; 0965C
        rts                                     ; 0965E

;-------------------------------------------------------------------------------
; LoadSound201 - Loads text201 into sound 35 and makes sound 36 from it (two copies at periods
; 179 / 181, looping); sets bit 2 of SoundFlags if it loaded.
;-------------------------------------------------------------------------------
LoadSound201:
        moveq   #$23,d0                         ; 09660
        move.l  d0,-(a7)                        ; 09662
        pea.l   (StrTextText201).l              ; 09664
        jsr     (LoadSound).l                   ; 0966A
        addq.l  #$8,a7                          ; 09670
        tst.l   d0                              ; 09672
        beq.b   l_000_096B8                     ; 09674
        moveq   #$24,d0                         ; 09676
        move.l  d0,-(a7)                        ; 09678
        moveq   #$23,d0                         ; 0967A
        move.l  d0,-(a7)                        ; 0967C
        jsr     (CopySound).l                   ; 0967E
        addq.l  #$8,a7                          ; 09684
        tst.l   d0                              ; 09686
        beq.b   l_000_096B8                     ; 09688
        movea.l (dat_081_0008C).l,a0            ; 0968A
        movea.l (dat_081_00090).l,a1            ; 09690
        moveq   #-1,d0                          ; 09696
        move.l  d0,$10(a1)                      ; 09698
        move.l  d0,$10(a0)                      ; 0969C
        move.l  #$b30000,$8(a0)                 ; 096A0
        move.l  #$b50000,$8(a1)                 ; 096A8
        bset    #$2,(SoundFlags).l              ; 096B0
l_000_096B8:
        rts                                     ; 096B8

;-------------------------------------------------------------------------------
; LoadMusicSamples - Loads the title music's instruments (texti0a, texti0b, texti1-texti5) into
; sounds 13-34 (each file one sound, plus copies at other settings) when there is the chip RAM
; for them; sets their loops and pitches.
;-------------------------------------------------------------------------------
LoadMusicSamples:
        link.w  a6,#$ffdc                       ; 096BA
        movem.l a2-a5,-(a7)                     ; 096BE
        clr.l   -$8(a6)                         ; 096C2
        moveq   #$d,d0                          ; 096C6
        move.l  d0,-(a7)                        ; 096C8
        pea.l   (StrTextTexti0a).l              ; 096CA
        jsr     (LoadSound).l                   ; 096D0
        addq.l  #$8,a7                          ; 096D6
        moveq   #$e,d0                          ; 096D8
        move.l  d0,-(a7)                        ; 096DA
        moveq   #$d,d0                          ; 096DC
        move.l  d0,-(a7)                        ; 096DE
        jsr     (CopySound).l                   ; 096E0
        addq.l  #$8,a7                          ; 096E6
        moveq   #$f,d0                          ; 096E8
        move.l  d0,-(a7)                        ; 096EA
        pea.l   (StrTextTexti0b).l              ; 096EC
        jsr     (LoadSound).l                   ; 096F2
        addq.l  #$8,a7                          ; 096F8
        moveq   #$10,d0                         ; 096FA
        move.l  d0,-(a7)                        ; 096FC
        moveq   #$f,d0                          ; 096FE
        move.l  d0,-(a7)                        ; 09700
        jsr     (CopySound).l                   ; 09702
        addq.l  #$8,a7                          ; 09708
        moveq   #$11,d0                         ; 0970A
        move.l  d0,-(a7)                        ; 0970C
        pea.l   (StrTextTexti1).l               ; 0970E
        jsr     (LoadSound).l                   ; 09714
        addq.l  #$8,a7                          ; 0971A
        moveq   #$12,d0                         ; 0971C
        move.l  d0,-(a7)                        ; 0971E
        moveq   #$11,d0                         ; 09720
        move.l  d0,-(a7)                        ; 09722
        jsr     (CopySound).l                   ; 09724
        addq.l  #$8,a7                          ; 0972A
        moveq   #$13,d0                         ; 0972C
        move.l  d0,-(a7)                        ; 0972E
        pea.l   (StrTextTexti2).l               ; 09730
        jsr     (LoadSound).l                   ; 09736
        addq.l  #$8,a7                          ; 0973C
        moveq   #$14,d0                         ; 0973E
        move.l  d0,-(a7)                        ; 09740
        moveq   #$13,d0                         ; 09742
        move.l  d0,-(a7)                        ; 09744
        jsr     (CopySound).l                   ; 09746
        addq.l  #$8,a7                          ; 0974C
        moveq   #$15,d0                         ; 0974E
        move.l  d0,-(a7)                        ; 09750
        moveq   #$11,d0                         ; 09752
        move.l  d0,-(a7)                        ; 09754
        jsr     (CopySound).l                   ; 09756
        addq.l  #$8,a7                          ; 0975C
        moveq   #$16,d0                         ; 0975E
        move.l  d0,-(a7)                        ; 09760
        moveq   #$11,d0                         ; 09762
        move.l  d0,-(a7)                        ; 09764
        jsr     (CopySound).l                   ; 09766
        addq.l  #$8,a7                          ; 0976C
        moveq   #$17,d0                         ; 0976E
        move.l  d0,-(a7)                        ; 09770
        moveq   #$13,d0                         ; 09772
        move.l  d0,-(a7)                        ; 09774
        jsr     (CopySound).l                   ; 09776
        addq.l  #$8,a7                          ; 0977C
        moveq   #$18,d0                         ; 0977E
        move.l  d0,-(a7)                        ; 09780
        moveq   #$13,d0                         ; 09782
        move.l  d0,-(a7)                        ; 09784
        jsr     (CopySound).l                   ; 09786
        addq.l  #$8,a7                          ; 0978C
        moveq   #$19,d0                         ; 0978E
        move.l  d0,-(a7)                        ; 09790
        pea.l   (StrTextTexti3).l               ; 09792
        jsr     (LoadSound).l                   ; 09798
        addq.l  #$8,a7                          ; 0979E
        moveq   #$1a,d0                         ; 097A0
        move.l  d0,-(a7)                        ; 097A2
        moveq   #$19,d0                         ; 097A4
        move.l  d0,-(a7)                        ; 097A6
        jsr     (CopySound).l                   ; 097A8
        addq.l  #$8,a7                          ; 097AE
        moveq   #$1b,d0                         ; 097B0
        move.l  d0,-(a7)                        ; 097B2
        pea.l   (StrTextTexti4).l               ; 097B4
        jsr     (LoadSound).l                   ; 097BA
        addq.l  #$8,a7                          ; 097C0
        moveq   #$1c,d0                         ; 097C2
        move.l  d0,-(a7)                        ; 097C4
        moveq   #$1b,d0                         ; 097C6
        move.l  d0,-(a7)                        ; 097C8
        jsr     (CopySound).l                   ; 097CA
        addq.l  #$8,a7                          ; 097D0
        moveq   #$1d,d0                         ; 097D2
        move.l  d0,-(a7)                        ; 097D4
        moveq   #$19,d0                         ; 097D6
        move.l  d0,-(a7)                        ; 097D8
        jsr     (CopySound).l                   ; 097DA
        addq.l  #$8,a7                          ; 097E0
        moveq   #$1e,d0                         ; 097E2
        move.l  d0,-(a7)                        ; 097E4
        moveq   #$19,d0                         ; 097E6
        move.l  d0,-(a7)                        ; 097E8
        jsr     (CopySound).l                   ; 097EA
        addq.l  #$8,a7                          ; 097F0
        moveq   #$1f,d0                         ; 097F2
        move.l  d0,-(a7)                        ; 097F4
        moveq   #$1b,d0                         ; 097F6
        move.l  d0,-(a7)                        ; 097F8
        jsr     (CopySound).l                   ; 097FA
        addq.l  #$8,a7                          ; 09800
        moveq   #$20,d0                         ; 09802
        move.l  d0,-(a7)                        ; 09804
        moveq   #$1b,d0                         ; 09806
        move.l  d0,-(a7)                        ; 09808
        jsr     (CopySound).l                   ; 0980A
        addq.l  #$8,a7                          ; 09810
        moveq   #$21,d0                         ; 09812
        move.l  d0,-(a7)                        ; 09814
        pea.l   (StrTextTexti5).l               ; 09816
        jsr     (LoadSound).l                   ; 0981C
        addq.l  #$8,a7                          ; 09822
        moveq   #$22,d0                         ; 09824
        move.l  d0,-(a7)                        ; 09826
        moveq   #$21,d0                         ; 09828
        move.l  d0,-(a7)                        ; 0982A
        jsr     (CopySound).l                   ; 0982C
        addq.l  #$8,a7                          ; 09832
        moveq   #$d,d0                          ; 09834
        move.l  d0,-$4(a6)                      ; 09836
l_000_0983A:
        move.l  -$4(a6),d0                      ; 0983A
        cmpi.l  #$23,d0                         ; 0983E
        bge.b   l_000_0985E                     ; 09844
        asl.l   #$2,d0                          ; 09846
        movea.l d0,a0                           ; 09848
        adda.l  #SoundTable,a0                  ; 0984A
        tst.l   (a0)                            ; 09850
        bne.b   l_000_09858                     ; 09852
        addq.l  #$1,-$8(a6)                     ; 09854
l_000_09858:
        addq.l  #$1,-$4(a6)                     ; 09858
        bra.b   l_000_0983A                     ; 0985C
l_000_0985E:
        tst.l   -$8(a6)                         ; 0985E
        bne.w   l_000_099A0                     ; 09862
        moveq   #$d,d0                          ; 09866
        move.l  d0,-$4(a6)                      ; 09868
l_000_0986C:
        move.l  -$4(a6),d0                      ; 0986C
        cmpi.l  #$23,d0                         ; 09870
        bge.b   l_000_098B4                     ; 09876
        asl.l   #$2,d0                          ; 09878
        movea.l d0,a0                           ; 0987A
        adda.l  #SoundTable,a0                  ; 0987C
        movea.l (a0),a1                         ; 09882
        movea.l d0,a0                           ; 09884
        adda.l  #SoundTable,a0                  ; 09886
        movea.l (a0),a2                         ; 0988C
        moveq   #$0,d1                          ; 0988E
        move.l  d1,$14(a2)                      ; 09890
        move.l  d1,$10(a1)                      ; 09894
        movea.l d0,a0                           ; 09898
        adda.l  #SoundTable,a0                  ; 0989A
        movea.l (a0),a1                         ; 098A0
        movea.l d0,a0                           ; 098A2
        adda.l  #EngineSample,a0                ; 098A4
        move.l  (a0),$20(a1)                    ; 098AA
        addq.l  #$1,-$4(a6)                     ; 098AE
        bra.b   l_000_0986C                     ; 098B2
l_000_098B4:
        movea.l (dat_081_00038).l,a0            ; 098B4
        moveq   #$d,d0                          ; 098BA
        move.l  d0,$10(a0)                      ; 098BC
        movea.l (dat_081_00034).l,a1            ; 098C0
        move.l  d0,$10(a1)                      ; 098C6
        movea.l (dat_081_00040).l,a0            ; 098CA
        moveq   #$1,d0                          ; 098D0
        move.l  d0,$10(a0)                      ; 098D2
        movea.l (dat_081_0003C).l,a1            ; 098D6
        move.l  d0,$10(a1)                      ; 098DC
        movea.l (dat_081_00044).l,a0            ; 098E0
        movea.l (dat_081_00048).l,a1            ; 098E6
        movea.l (dat_081_00054).l,a2            ; 098EC
        movea.l (dat_081_00058).l,a3            ; 098F2
        movea.l (dat_081_00064).l,a4            ; 098F8
        movea.l (dat_081_00068).l,a5            ; 098FE
        move.l  a2,$18(a7)                      ; 09904
        movea.l (dat_081_00074).l,a2            ; 09908
        move.l  a2,$28(a7)                      ; 0990E
        movea.l (dat_081_00078).l,a2            ; 09912
        moveq   #$2,d0                          ; 09918
        move.l  d0,$14(a2)                      ; 0991A
        move.l  d0,$10(a2)                      ; 0991E
        movea.l $28(a7),a2                      ; 09922
        move.l  d0,$14(a2)                      ; 09926
        move.l  d0,$10(a2)                      ; 0992A
        move.l  d0,$14(a5)                      ; 0992E
        move.l  d0,$10(a5)                      ; 09932
        move.l  d0,$14(a4)                      ; 09936
        move.l  d0,$10(a4)                      ; 0993A
        move.l  d0,$14(a3)                      ; 0993E
        move.l  d0,$10(a3)                      ; 09942
        movea.l $18(a7),a2                      ; 09946
        move.l  d0,$14(a2)                      ; 0994A
        move.l  d0,$10(a2)                      ; 0994E
        move.l  d0,$14(a1)                      ; 09952
        move.l  d0,$10(a1)                      ; 09956
        move.l  d0,$14(a0)                      ; 0995A
        move.l  d0,$10(a0)                      ; 0995E
        movea.l (dat_081_00084).l,a0            ; 09962
        movea.l (dat_081_00088).l,a1            ; 09968
        moveq   #$3,d0                          ; 0996E
        move.l  d0,$14(a1)                      ; 09970
        move.l  d0,$10(a1)                      ; 09974
        move.l  d0,$14(a0)                      ; 09978
        move.l  d0,$10(a0)                      ; 0997C
        move.l  (dat_081_00044).l,$20(a0)       ; 09980
        movea.l (dat_081_00088).l,a0            ; 09988
        move.l  (dat_081_00048).l,$20(a0)       ; 0998E
        bset    #$7,(SoundsLoaded).l            ; 09996
        bra.b   l_000_099C2                     ; 0999E
l_000_099A0:
        moveq   #$d,d0                          ; 099A0
        move.l  d0,-$4(a6)                      ; 099A2
l_000_099A6:
        move.l  -$4(a6),d0                      ; 099A6
        cmpi.l  #$23,d0                         ; 099AA
        bge.b   l_000_099C2                     ; 099B0
        move.l  d0,-(a7)                        ; 099B2
        jsr     (FreeSound).l                   ; 099B4
        addq.l  #$4,a7                          ; 099BA
        addq.l  #$1,-$4(a6)                     ; 099BC
        bra.b   l_000_099A6                     ; 099C0
l_000_099C2:
        movem.l (a7)+,a2-a5                     ; 099C2
        unlk    a6                              ; 099C6
        rts                                     ; 099C8

;-------------------------------------------------------------------------------
; LoadEngineSounds - Loads the engine, gear, wind and other sound effects (textegn, textegn2,
; texttre, textger, textcpt, textwnd) into their sound slots.
;-------------------------------------------------------------------------------
LoadEngineSounds:
        link.w  a6,#$fffe                       ; 099CA
        clr.w   -$2(a6)                         ; 099CE
        moveq   #$2,d0                          ; 099D2
        move.l  d0,-(a7)                        ; 099D4
        pea.l   (StrTextTextegn).l              ; 099D6
        jsr     (LoadSound).l                   ; 099DC
        addq.l  #$8,a7                          ; 099E2
        tst.l   d0                              ; 099E4
        beq.b   l_000_099F0                     ; 099E6
        move.w  #$1,-$2(a6)                     ; 099E8
        bra.b   l_000_09A0C                     ; 099EE
l_000_099F0:
        moveq   #$2,d0                          ; 099F0
        move.l  d0,-(a7)                        ; 099F2
        pea.l   (StrTextTextegn2).l             ; 099F4
        jsr     (LoadSound).l                   ; 099FA
        addq.l  #$8,a7                          ; 09A00
        tst.l   d0                              ; 09A02
        beq.b   l_000_09A0C                     ; 09A04
        move.w  #$1,-$2(a6)                     ; 09A06
l_000_09A0C:
        tst.w   -$2(a6)                         ; 09A0C
        beq.b   l_000_09A64                     ; 09A10
        moveq   #$3,d0                          ; 09A12
        move.l  d0,-(a7)                        ; 09A14
        moveq   #$2,d0                          ; 09A16
        move.l  d0,-(a7)                        ; 09A18
        jsr     (CopySound).l                   ; 09A1A
        addq.l  #$8,a7                          ; 09A20
        tst.l   d0                              ; 09A22
        beq.b   l_000_09A64                     ; 09A24
        moveq   #-1,d0                          ; 09A26
        movea.l (EngineSample).l,a0             ; 09A28
        move.l  d0,$10(a0)                      ; 09A2E
        movea.l (EngineSample2).l,a0            ; 09A32
        move.l  d0,$10(a0)                      ; 09A38
        addi.l  #$370,(a0)                      ; 09A3C
        move.l  $4(a0),d0                       ; 09A42
        andi.l  #$7fffffff,d0                   ; 09A46
        subi.l  #$370,d0                        ; 09A4C
        ori.l   #$80000000,d0                   ; 09A52
        move.l  d0,$4(a0)                       ; 09A58
        bset    #$1,(SoundsLoaded).l            ; 09A5C
l_000_09A64:
        moveq   #$4,d0                          ; 09A64
        move.l  d0,-(a7)                        ; 09A66
        moveq   #$20,d0                         ; 09A68
        move.l  d0,-(a7)                        ; 09A6A
        jsr     (AllocSound).l                  ; 09A6C
        addq.l  #$8,a7                          ; 09A72
        tst.l   d0                              ; 09A74
        beq.b   l_000_09AA0                     ; 09A76
        movea.l (EffectSound).l,a0              ; 09A78
        move.l  $4(a0),-(a7)                    ; 09A7E
        move.l  (a0),-(a7)                      ; 09A82
        jsr     (sub_083_001C8).l               ; 09A84
        addq.l  #$8,a7                          ; 09A8A
        movea.l (EffectSound).l,a0              ; 09A8C
        move.l  #dat_086_00000,$30(a0)          ; 09A92
        moveq   #-1,d0                          ; 09A9A
        move.l  d0,$10(a0)                      ; 09A9C
l_000_09AA0:
        moveq   #$6,d0                          ; 09AA0
        move.l  d0,-(a7)                        ; 09AA2
        move.l  #$800,-(a7)                     ; 09AA4
        jsr     (AllocSound).l                  ; 09AAA
        addq.l  #$8,a7                          ; 09AB0
        tst.l   d0                              ; 09AB2
        beq.b   l_000_09AE6                     ; 09AB4
        movea.l (SweepSound).l,a0               ; 09AB6
        move.l  $4(a0),-(a7)                    ; 09ABC
        move.l  (a0),-(a7)                      ; 09AC0
        jsr     (sub_083_002A6).l               ; 09AC2
        addq.l  #$8,a7                          ; 09AC8
        movea.l (SweepSound).l,a0               ; 09ACA
        moveq   #-1,d0                          ; 09AD0
        move.l  d0,$10(a0)                      ; 09AD2
        move.l  #dat_086_00060,$30(a0)          ; 09AD6
        bset    #$0,(SoundFlags).l              ; 09ADE
l_000_09AE6:
        moveq   #$5,d0                          ; 09AE6
        move.l  d0,-(a7)                        ; 09AE8
        pea.l   (StrTextTexttre).l              ; 09AEA
        jsr     (LoadSound).l                   ; 09AF0
        addq.l  #$8,a7                          ; 09AF6
        tst.l   d0                              ; 09AF8
        beq.b   l_000_09B04                     ; 09AFA
        bset    #$2,(SoundsLoaded).l            ; 09AFC
l_000_09B04:
        tst.l   (SweepSound).l                  ; 09B04
        beq.b   l_000_09B3E                     ; 09B0A
        moveq   #$a,d0                          ; 09B0C
        move.l  d0,-(a7)                        ; 09B0E
        moveq   #$6,d0                          ; 09B10
        move.l  d0,-(a7)                        ; 09B12
        jsr     (CopySound).l                   ; 09B14
        addq.l  #$8,a7                          ; 09B1A
        tst.l   d0                              ; 09B1C
        beq.b   l_000_09B3E                     ; 09B1E
        movea.l (GunSoundCopy).l,a0             ; 09B20
        move.l  #dat_086_000F8,$30(a0)          ; 09B26
        move.l  #$960000,$8(a0)                 ; 09B2E
        bset    #$5,(SoundsLoaded).l            ; 09B36
l_000_09B3E:
        moveq   #$b,d0                          ; 09B3E
        move.l  d0,-(a7)                        ; 09B40
        pea.l   (StrTextTextger).l              ; 09B42
        jsr     (LoadSound).l                   ; 09B48
        addq.l  #$8,a7                          ; 09B4E
        tst.l   d0                              ; 09B50
        beq.b   l_000_09B68                     ; 09B52
        moveq   #-1,d0                          ; 09B54
        movea.l (GearSample).l,a0               ; 09B56
        move.l  d0,$10(a0)                      ; 09B5C
        bset    #$6,(SoundsLoaded).l            ; 09B60
l_000_09B68:
        tst.l   (EngineSample).l                ; 09B68
        beq.b   l_000_09B9A                     ; 09B6E
        moveq   #$c,d0                          ; 09B70
        move.l  d0,-(a7)                        ; 09B72
        moveq   #$2,d0                          ; 09B74
        move.l  d0,-(a7)                        ; 09B76
        jsr     (CopySound).l                   ; 09B78
        addq.l  #$8,a7                          ; 09B7E
        tst.l   d0                              ; 09B80
        beq.b   l_000_09B9A                     ; 09B82
        movea.l (EffectSound2).l,a0             ; 09B84
        move.l  #dat_086_000B8,$30(a0)          ; 09B8A
        bset    #$1,(SoundFlags).l              ; 09B92
l_000_09B9A:
        clr.l   -(a7)                           ; 09B9A
        pea.l   (StrTextTextcpt).l              ; 09B9C
        jsr     (LoadSound).l                   ; 09BA2
        addq.l  #$8,a7                          ; 09BA8
        tst.l   d0                              ; 09BAA
        beq.b   l_000_09BE6                     ; 09BAC
        moveq   #$1,d0                          ; 09BAE
        move.l  d0,-(a7)                        ; 09BB0
        clr.l   -(a7)                           ; 09BB2
        jsr     (CopySound).l                   ; 09BB4
        addq.l  #$8,a7                          ; 09BBA
        tst.l   d0                              ; 09BBC
        beq.b   l_000_09BE6                     ; 09BBE
        moveq   #-1,d0                          ; 09BC0
        movea.l (SoundTable).l,a0               ; 09BC2
        move.l  d0,$10(a0)                      ; 09BC8
        movea.l (CatapultSample).l,a0           ; 09BCC
        move.l  d0,$10(a0)                      ; 09BD2
        move.l  #$800015cc,$4(a0)               ; 09BD6
        bset    #$0,(SoundsLoaded).l            ; 09BDE
l_000_09BE6:
        moveq   #$8,d0                          ; 09BE6
        move.l  d0,-(a7)                        ; 09BE8
        pea.l   (StrTextTextwnd).l              ; 09BEA
        jsr     (LoadSound).l                   ; 09BF0
        addq.l  #$8,a7                          ; 09BF6
        tst.l   d0                              ; 09BF8
        beq.b   l_000_09C54                     ; 09BFA
        moveq   #$9,d0                          ; 09BFC
        move.l  d0,-(a7)                        ; 09BFE
        moveq   #$8,d0                          ; 09C00
        move.l  d0,-(a7)                        ; 09C02
        jsr     (CopySound).l                   ; 09C04
        addq.l  #$8,a7                          ; 09C0A
        tst.l   d0                              ; 09C0C
        beq.b   l_000_09C54                     ; 09C0E
        movea.l (dat_081_00024).l,a0            ; 09C10
        moveq   #-1,d0                          ; 09C16
        move.l  d0,$10(a0)                      ; 09C18
        movea.l (WindSample).l,a1               ; 09C1C
        move.l  d0,$10(a1)                      ; 09C22
        addi.l  #$792,(a0)                      ; 09C26
        movea.l (EngineSample2).l,a1            ; 09C2C
        move.l  $4(a1),d0                       ; 09C32
        andi.l  #$7fffffff,d0                   ; 09C36
        subi.l  #$792,d0                        ; 09C3C
        ori.l   #$80000000,d0                   ; 09C42
        move.l  d0,$4(a0)                       ; 09C48
        bset    #$4,(SoundsLoaded).l            ; 09C4C
l_000_09C54:
        unlk    a6                              ; 09C54
        rts                                     ; 09C56

;-------------------------------------------------------------------------------
; StopSound - StopSound(channel): clears the channel's sound and stops it.
;-------------------------------------------------------------------------------
StopSound:
        link.w  a6,#$0                          ; 09C58
        move.l  $8(a6),d0                       ; 09C5C
        asl.l   #$2,d0                          ; 09C60
        movea.l d0,a0                           ; 09C62
        adda.l  #ChannelSound,a0                ; 09C64
        clr.l   (a0)                            ; 09C6A
        move.l  $8(a6),-(a7)                    ; 09C6C
        jsr     (AudioIntAck).l                 ; 09C70
        addq.l  #$4,a7                          ; 09C76
        unlk    a6                              ; 09C78
        rts                                     ; 09C7A

;-------------------------------------------------------------------------------
; PlaySound - PlaySound(sound, channel): starts sound (a slot of SoundTable) on an audio
; channel.
;-------------------------------------------------------------------------------
PlaySound:
        link.w  a6,#$0                          ; 09C7C
        movem.l d2,-(a7)                        ; 09C80
        move.l  $8(a6),d0                       ; 09C84
        asl.l   #$2,d0                          ; 09C88
        movea.l d0,a0                           ; 09C8A
        adda.l  #SoundTable,a0                  ; 09C8C
        tst.l   (a0)                            ; 09C92
        beq.b   l_000_09CDE                     ; 09C94
        move.l  $c(a6),-(a7)                    ; 09C96
        bsr.b   StopSound                       ; 09C9A
        addq.l  #$4,a7                          ; 09C9C
        move.l  $8(a6),d0                       ; 09C9E
        asl.l   #$2,d0                          ; 09CA2
        movea.l d0,a0                           ; 09CA4
        adda.l  #SoundTable,a0                  ; 09CA6
        movea.l (a0),a1                         ; 09CAC
        moveq   #$10,d1                         ; 09CAE
        move.l  $10(a6),d2                      ; 09CB0
        asl.l   d1,d2                           ; 09CB4
        move.l  d2,$c(a1)                       ; 09CB6
        move.l  $c(a6),d1                       ; 09CBA
        asl.l   #$2,d1                          ; 09CBE
        movea.l d1,a0                           ; 09CC0
        adda.l  #ChannelSound,a0                ; 09CC2
        movea.l d0,a1                           ; 09CC8
        adda.l  #SoundTable,a1                  ; 09CCA
        move.l  (a1),(a0)                       ; 09CD0
        move.l  $c(a6),-(a7)                    ; 09CD2
        jsr     (AudioIntAck).l                 ; 09CD6
        addq.l  #$4,a7                          ; 09CDC
l_000_09CDE:
        movem.l (a7)+,d2                        ; 09CDE
        unlk    a6                              ; 09CE2
        rts                                     ; 09CE4

;-------------------------------------------------------------------------------
; PlayTitleMusic - Starts the title music (if the music samples were loaded, SoundsLoaded bit
; 7), unless dat_071_001A7 says it is already playing.
;-------------------------------------------------------------------------------
PlayTitleMusic:
        link.w  a6,#$0                          ; 09CE6
        move.b  (dat_071_001A7).l,d0            ; 09CEA
        tst.b   d0                              ; 09CF0
        bne.w   l_000_09D76                     ; 09CF2
        btst    #$7,(SoundsLoaded).l            ; 09CF6
        beq.b   l_000_09D36                     ; 09CFE
        jsr     (StopAllSounds).l               ; 09D00
        moveq   #$3f,d0                         ; 09D06
        move.l  d0,-(a7)                        ; 09D08
        clr.l   -(a7)                           ; 09D0A
        moveq   #$d,d0                          ; 09D0C
        move.l  d0,-(a7)                        ; 09D0E
        bsr.w   PlaySound                       ; 09D10
        lea.l   $c(a7),a7                       ; 09D14
        moveq   #$3f,d0                         ; 09D18
        move.l  d0,-(a7)                        ; 09D1A
        moveq   #$1,d0                          ; 09D1C
        move.l  d0,-(a7)                        ; 09D1E
        moveq   #$e,d0                          ; 09D20
        move.l  d0,-(a7)                        ; 09D22
        bsr.w   PlaySound                       ; 09D24
        lea.l   $c(a7),a7                       ; 09D28
        move.b  #$2,(dat_071_001A7).l           ; 09D2C
        bra.b   l_000_09D76                     ; 09D34
l_000_09D36:
        btst    #$2,(SoundFlags).l              ; 09D36
        beq.b   l_000_09D70                     ; 09D3E
        move.l  $8(a6),-(a7)                    ; 09D40
        clr.l   -(a7)                           ; 09D44
        moveq   #$23,d0                         ; 09D46
        move.l  d0,-(a7)                        ; 09D48
        bsr.w   PlaySound                       ; 09D4A
        lea.l   $c(a7),a7                       ; 09D4E
        move.l  $8(a6),-(a7)                    ; 09D52
        moveq   #$1,d0                          ; 09D56
        move.l  d0,-(a7)                        ; 09D58
        moveq   #$24,d0                         ; 09D5A
        move.l  d0,-(a7)                        ; 09D5C
        bsr.w   PlaySound                       ; 09D5E
        lea.l   $c(a7),a7                       ; 09D62
        move.b  #$2,(dat_071_001A7).l           ; 09D66
        bra.b   l_000_09D76                     ; 09D6E
l_000_09D70:
        jsr     (StopAllSounds).l               ; 09D70
l_000_09D76:
        unlk    a6                              ; 09D76
        rts                                     ; 09D78

;-------------------------------------------------------------------------------
; PlayStartSound - Plays sound $23 on channels 0 and 1 (if SoundFlags bit 2): at the start and
; when a flight is set up.
;-------------------------------------------------------------------------------
PlayStartSound:
        link.w  a6,#$0                          ; 09D7A
        btst    #$2,(SoundFlags).l              ; 09D7E
        beq.b   l_000_09DAE                     ; 09D86
        move.l  $8(a6),-(a7)                    ; 09D88
        clr.l   -(a7)                           ; 09D8C
        moveq   #$23,d0                         ; 09D8E
        move.l  d0,-(a7)                        ; 09D90
        bsr.w   PlaySound                       ; 09D92
        lea.l   $c(a7),a7                       ; 09D96
        move.l  $8(a6),-(a7)                    ; 09D9A
        moveq   #$1,d0                          ; 09D9E
        move.l  d0,-(a7)                        ; 09DA0
        moveq   #$24,d0                         ; 09DA2
        move.l  d0,-(a7)                        ; 09DA4
        bsr.w   PlaySound                       ; 09DA6
        lea.l   $c(a7),a7                       ; 09DAA
l_000_09DAE:
        unlk    a6                              ; 09DAE
        rts                                     ; 09DB0

;-------------------------------------------------------------------------------
; PlayCatapultSound - Plays CatapultSample (if loaded) on two channels.
;-------------------------------------------------------------------------------
PlayCatapultSound:
        link.w  a6,#$0                          ; 09DB2
        btst    #$0,(SoundsLoaded).l            ; 09DB6
        beq.b   l_000_09E32                     ; 09DBE
        tst.l   (CatapultSample).l              ; 09DC0
        beq.b   l_000_09E42                     ; 09DC6
        movea.l (CatapultSample).l,a0           ; 09DC8
        moveq   #$0,d0                          ; 09DCE
        move.l  d0,$1c(a0)                      ; 09DD0
        movea.l (SoundTable).l,a1               ; 09DD4
        move.l  d0,$1c(a1)                      ; 09DDA
        move.l  d0,$18(a0)                      ; 09DDE
        movea.l (SoundTable).l,a1               ; 09DE2
        move.l  d0,$18(a1)                      ; 09DE8
        moveq   #$10,d0                         ; 09DEC
        move.l  $8(a6),d1                       ; 09DEE
        asl.l   d0,d1                           ; 09DF2
        movea.l (SoundTable).l,a1               ; 09DF4
        move.l  d1,$8(a1)                       ; 09DFA
        move.l  $8(a6),d0                       ; 09DFE
        addq.l  #$2,d0                          ; 09E02
        moveq   #$10,d1                         ; 09E04
        asl.l   d1,d0                           ; 09E06
        move.l  d0,$8(a0)                       ; 09E08
        move.l  $c(a6),-(a7)                    ; 09E0C
        moveq   #$0,d0                          ; 09E10
        move.l  d0,-(a7)                        ; 09E12
        move.l  d0,-(a7)                        ; 09E14
        bsr.w   PlaySound                       ; 09E16
        lea.l   $c(a7),a7                       ; 09E1A
        move.l  $c(a6),-(a7)                    ; 09E1E
        moveq   #$1,d0                          ; 09E22
        move.l  d0,-(a7)                        ; 09E24
        move.l  d0,-(a7)                        ; 09E26
        bsr.w   PlaySound                       ; 09E28
        lea.l   $c(a7),a7                       ; 09E2C
        bra.b   l_000_09E42                     ; 09E30
l_000_09E32:
        move.l  $c(a6),d0                       ; 09E32
        asr.l   #$2,d0                          ; 09E36
        move.l  d0,-(a7)                        ; 09E38
        move.l  $8(a6),-(a7)                    ; 09E3A
        bsr.b   PlayEngineSound                 ; 09E3E
        addq.l  #$8,a7                          ; 09E40
l_000_09E42:
        unlk    a6                              ; 09E42
        rts                                     ; 09E44

;-------------------------------------------------------------------------------
; PlayEngineSound - Plays the engine sound (if loaded, SoundsLoaded bit 1) on two channels at
; the period on the stack, the second slightly detuned, at the volume given.
;-------------------------------------------------------------------------------
PlayEngineSound:
        link.w  a6,#$0                          ; 09E46
        btst    #$1,(SoundsLoaded).l            ; 09E4A
        beq.b   l_000_09EBA                     ; 09E52
        tst.l   (EngineSample2).l               ; 09E54
        beq.b   l_000_09EBA                     ; 09E5A
        movea.l (EngineSample).l,a0             ; 09E5C
        movea.l (EngineSample2).l,a1            ; 09E62
        moveq   #$0,d0                          ; 09E68
        move.l  d0,$1c(a1)                      ; 09E6A
        move.l  d0,$1c(a0)                      ; 09E6E
        move.l  d0,$18(a1)                      ; 09E72
        move.l  d0,$18(a0)                      ; 09E76
        moveq   #$10,d0                         ; 09E7A
        move.l  $8(a6),d1                       ; 09E7C
        asl.l   d0,d1                           ; 09E80
        move.l  d1,$8(a0)                       ; 09E82
        move.l  $8(a6),d0                       ; 09E86
        addq.l  #$2,d0                          ; 09E8A
        moveq   #$10,d1                         ; 09E8C
        asl.l   d1,d0                           ; 09E8E
        move.l  d0,$8(a1)                       ; 09E90
        move.l  $c(a6),-(a7)                    ; 09E94
        clr.l   -(a7)                           ; 09E98
        moveq   #$2,d0                          ; 09E9A
        move.l  d0,-(a7)                        ; 09E9C
        bsr.w   PlaySound                       ; 09E9E
        lea.l   $c(a7),a7                       ; 09EA2
        move.l  $c(a6),-(a7)                    ; 09EA6
        moveq   #$1,d0                          ; 09EAA
        move.l  d0,-(a7)                        ; 09EAC
        moveq   #$3,d0                          ; 09EAE
        move.l  d0,-(a7)                        ; 09EB0
        bsr.w   PlaySound                       ; 09EB2
        lea.l   $c(a7),a7                       ; 09EB6
l_000_09EBA:
        unlk    a6                              ; 09EBA
        rts                                     ; 09EBC
sub_000_09EBE:
        link.w  a6,#$0                          ; 09EBE
        btst    #$0,(SoundsLoaded).l            ; 09EC2
        beq.b   l_000_09EE0                     ; 09ECA
        move.l  $10(a6),-(a7)                   ; 09ECC
        move.l  $c(a6),-(a7)                    ; 09ED0
        move.l  $8(a6),-(a7)                    ; 09ED4
        bsr.b   EnginePitch                     ; 09ED8
        lea.l   $c(a7),a7                       ; 09EDA
        bra.b   l_000_09EF6                     ; 09EDE
l_000_09EE0:
        move.l  $c(a6),d0                       ; 09EE0
        asr.l   #$2,d0                          ; 09EE4
        move.l  $10(a6),-(a7)                   ; 09EE6
        move.l  d0,-(a7)                        ; 09EEA
        move.l  $8(a6),-(a7)                    ; 09EEC
        bsr.b   EnginePitch                     ; 09EF0
        lea.l   $c(a7),a7                       ; 09EF2
l_000_09EF6:
        unlk    a6                              ; 09EF6
        rts                                     ; 09EF8

;-------------------------------------------------------------------------------
; EnginePitch - Sets the engine sound's period from the value on the stack (if loaded,
; SoundsLoaded bit 1).
;-------------------------------------------------------------------------------
EnginePitch:
        link.w  a6,#$0                          ; 09EFA
        movem.l d2,-(a7)                        ; 09EFE
        btst    #$1,(SoundsLoaded).l            ; 09F02
        beq.w   l_000_09F92                     ; 09F0A
        tst.l   (dat_074_00014).l               ; 09F0E
        beq.b   l_000_09F92                     ; 09F14
        movea.l (dat_074_00014).l,a0            ; 09F16
        moveq   #$10,d0                         ; 09F1C
        move.l  $8(a6),d1                       ; 09F1E
        asl.l   d0,d1                           ; 09F22
        movea.l (ChannelSound).l,a1             ; 09F24
        sub.l   $8(a1),d1                       ; 09F2A
        move.l  d1,d0                           ; 09F2E
        move.l  $10(a6),d1                      ; 09F30
        jsr     (CXD33).l                       ; 09F34
        move.l  d0,$18(a0)                      ; 09F3A
        movea.l (ChannelSound).l,a1             ; 09F3E
        move.l  d0,$18(a1)                      ; 09F44
        move.l  $10(a6),d0                      ; 09F48
        move.l  d0,$38(a0)                      ; 09F4C
        movea.l (ChannelSound).l,a1             ; 09F50
        move.l  d0,$38(a1)                      ; 09F56
        moveq   #$10,d1                         ; 09F5A
        move.l  $c(a6),d2                       ; 09F5C
        asl.l   d1,d2                           ; 09F60
        sub.l   $c(a1),d2                       ; 09F62
        move.l  d2,d0                           ; 09F66
        move.l  $10(a6),d1                      ; 09F68
        jsr     (CXD33).l                       ; 09F6C
        move.l  d0,$1c(a0)                      ; 09F72
        movea.l (ChannelSound).l,a1             ; 09F76
        move.l  d0,$1c(a1)                      ; 09F7C
        move.l  $10(a6),d0                      ; 09F80
        move.l  d0,$3c(a0)                      ; 09F84
        movea.l (ChannelSound).l,a1             ; 09F88
        move.l  d0,$3c(a1)                      ; 09F8E
l_000_09F92:
        movem.l (a7)+,d2                        ; 09F92
        unlk    a6                              ; 09F96
        rts                                     ; 09F98

;-------------------------------------------------------------------------------
; PlayWindSound - Plays the wind's sound (if loaded, SoundsLoaded bit 4) at a level from the
; speed.
;-------------------------------------------------------------------------------
PlayWindSound:
        link.w  a6,#$fffc                       ; 09F9A
        btst    #$4,(SoundsLoaded).l            ; 09F9E
        beq.w   l_000_0A02C                     ; 09FA6
        tst.l   (dat_081_00024).l               ; 09FAA
        beq.w   l_000_0A03E                     ; 09FB0
        movea.l (WindSample).l,a0               ; 09FB4
        moveq   #$6,d0                          ; 09FBA
        move.l  d0,-(a7)                        ; 09FBC
        move.l  a0,$4(a7)                       ; 09FBE
        jsr     (sub_083_00272).l               ; 09FC2
        addq.l  #$4,a7                          ; 09FC8
        addi.l  #$168,d0                        ; 09FCA
        moveq   #$10,d1                         ; 09FD0
        asl.l   d1,d0                           ; 09FD2
        movea.l $0(a7),a0                       ; 09FD4
        move.l  d0,$8(a0)                       ; 09FD8
        movea.l (dat_081_00024).l,a0            ; 09FDC
        moveq   #$6,d0                          ; 09FE2
        move.l  d0,-(a7)                        ; 09FE4
        move.l  a0,$4(a7)                       ; 09FE6
        jsr     (sub_083_00272).l               ; 09FEA
        addq.l  #$4,a7                          ; 09FF0
        addi.l  #$168,d0                        ; 09FF2
        moveq   #$10,d1                         ; 09FF8
        asl.l   d1,d0                           ; 09FFA
        movea.l $0(a7),a0                       ; 09FFC
        move.l  d0,$8(a0)                       ; 0A000
        move.l  $8(a6),-(a7)                    ; 0A004
        clr.l   -(a7)                           ; 0A008
        moveq   #$8,d0                          ; 0A00A
        move.l  d0,-(a7)                        ; 0A00C
        bsr.w   PlaySound                       ; 0A00E
        lea.l   $c(a7),a7                       ; 0A012
        move.l  $8(a6),-(a7)                    ; 0A016
        moveq   #$1,d0                          ; 0A01A
        move.l  d0,-(a7)                        ; 0A01C
        moveq   #$9,d0                          ; 0A01E
        move.l  d0,-(a7)                        ; 0A020
        bsr.w   PlaySound                       ; 0A022
        lea.l   $c(a7),a7                       ; 0A026
        bra.b   l_000_0A03E                     ; 0A02A
l_000_0A02C:
        clr.l   -(a7)                           ; 0A02C
        bsr.w   StopSound                       ; 0A02E
        addq.l  #$4,a7                          ; 0A032
        moveq   #$1,d0                          ; 0A034
        move.l  d0,-(a7)                        ; 0A036
        bsr.w   StopSound                       ; 0A038
        addq.l  #$4,a7                          ; 0A03C
l_000_0A03E:
        unlk    a6                              ; 0A03E
        rts                                     ; 0A040

;-------------------------------------------------------------------------------
; PlayEffect - Plays a sampled sound effect on its channel (EffectSound) with the period,
; volume and length given on the stack (into dat_086_00004 and on): stops what the channel was
; playing first. Used by the cockpit sounds, the ejection and the menu beep.
;-------------------------------------------------------------------------------
PlayEffect:
        link.w  a6,#$0                          ; 0A042
        tst.l   (EffectSound).l                 ; 0A046
        beq.w   l_000_0A0D8                     ; 0A04C
        moveq   #$3,d0                          ; 0A050
        move.l  d0,-(a7)                        ; 0A052
        bsr.w   StopSound                       ; 0A054
        addq.l  #$4,a7                          ; 0A058
        move.l  $24(a6),(dat_086_00004).l       ; 0A05A
        move.l  $20(a6),(dat_086_0000C).l       ; 0A062
        moveq   #$10,d0                         ; 0A06A
        move.l  $8(a6),d1                       ; 0A06C
        asl.l   d0,d1                           ; 0A070
        move.l  d1,(dat_086_00014).l            ; 0A072
        move.l  $c(a6),d1                       ; 0A078
        asl.l   d0,d1                           ; 0A07C
        move.l  d1,(dat_086_0001C).l            ; 0A07E
        move.l  $10(a6),(dat_086_00024).l       ; 0A084
        move.l  $14(a6),d1                      ; 0A08C
        asl.l   d0,d1                           ; 0A090
        move.l  d1,(dat_086_0002C).l            ; 0A092
        move.l  $18(a6),d1                      ; 0A098
        asl.l   d0,d1                           ; 0A09C
        move.l  d1,(dat_086_00034).l            ; 0A09E
        move.l  $1c(a6),(dat_086_0003C).l       ; 0A0A4
        move.l  $28(a6),(dat_086_0004C).l       ; 0A0AC
        movea.l (EffectSound).l,a0              ; 0A0B4
        moveq   #$0,d0                          ; 0A0BA
        move.l  d0,$34(a0)                      ; 0A0BC
        moveq   #$1,d0                          ; 0A0C0
        move.l  d0,$2c(a0)                      ; 0A0C2
        clr.l   -(a7)                           ; 0A0C6
        moveq   #$3,d0                          ; 0A0C8
        move.l  d0,-(a7)                        ; 0A0CA
        moveq   #$4,d0                          ; 0A0CC
        move.l  d0,-(a7)                        ; 0A0CE
        bsr.w   PlaySound                       ; 0A0D0
        lea.l   $c(a7),a7                       ; 0A0D4
l_000_0A0D8:
        unlk    a6                              ; 0A0D8
        rts                                     ; 0A0DA

;-------------------------------------------------------------------------------
; PlaySweep - Plays sound 2 sliding in pitch (the start period and the change given on the
; stack: dat_086_00064 and on): explosions, flares and the like (if sounds are on, SoundFlags
; bit 0).
;-------------------------------------------------------------------------------
PlaySweep:
        link.w  a6,#$fffc                       ; 0A0DC
        btst    #$0,(SoundFlags).l              ; 0A0E0
        beq.w   l_000_0A178                     ; 0A0E8
        tst.l   (SweepSound).l                  ; 0A0EC
        beq.w   l_000_0A188                     ; 0A0F2
        moveq   #$2,d0                          ; 0A0F6
        move.l  d0,-(a7)                        ; 0A0F8
        bsr.w   StopSound                       ; 0A0FA
        addq.l  #$4,a7                          ; 0A0FE
        moveq   #$10,d0                         ; 0A100
        move.l  $8(a6),d1                       ; 0A102
        asl.l   d0,d1                           ; 0A106
        move.l  d1,(dat_086_00064).l            ; 0A108
        neg.l   d1                              ; 0A10E
        move.l  d1,d0                           ; 0A110
        move.l  $c(a6),d1                       ; 0A112
        jsr     (CXD33).l                       ; 0A116
        move.l  d0,(dat_086_0006C).l            ; 0A11C
        move.l  $c(a6),(dat_086_00074).l        ; 0A122
        movea.l (SweepSound).l,a0               ; 0A12A
        clr.l   $34(a0)                         ; 0A130
        moveq   #$b,d0                          ; 0A134
        move.l  d0,-(a7)                        ; 0A136
        move.l  a0,$4(a7)                       ; 0A138
        jsr     (sub_083_00272).l               ; 0A13C
        addq.l  #$4,a7                          ; 0A142
        asl.l   #$2,d0                          ; 0A144
        addi.l  #$231e,d0                       ; 0A146
        moveq   #$10,d1                         ; 0A14C
        asl.l   d1,d0                           ; 0A14E
        movea.l $0(a7),a0                       ; 0A150
        move.l  d0,$8(a0)                       ; 0A154
        moveq   #$1,d0                          ; 0A158
        movea.l (SweepSound).l,a0               ; 0A15A
        move.l  d0,$2c(a0)                      ; 0A160
        clr.l   -(a7)                           ; 0A164
        moveq   #$2,d0                          ; 0A166
        move.l  d0,-(a7)                        ; 0A168
        moveq   #$6,d0                          ; 0A16A
        move.l  d0,-(a7)                        ; 0A16C
        bsr.w   PlaySound                       ; 0A16E
        lea.l   $c(a7),a7                       ; 0A172
        bra.b   l_000_0A188                     ; 0A176
l_000_0A178:
        move.b  #$fa,(EngineSoundRequest).l     ; 0A178
        move.b  #$2,(dat_071_00167).l           ; 0A180
l_000_0A188:
        unlk    a6                              ; 0A188
        rts                                     ; 0A18A

;-------------------------------------------------------------------------------
; PlayTireSound - Plays TireSample (if loaded), only for the viewed object: on touching the
; ground.
;-------------------------------------------------------------------------------
PlayTireSound:
        link.w  a6,#$0                          ; 0A18C
        btst    #$2,(SoundsLoaded).l            ; 0A190
        beq.b   l_000_0A1E2                     ; 0A198
        move.w  (CurrentObjectOffset).l,d0      ; 0A19A
        move.w  (ViewObject).l,d1               ; 0A1A0
        cmp.w   d1,d0                           ; 0A1A6
        bne.b   l_000_0A1E2                     ; 0A1A8
        tst.l   (TireSample).l                  ; 0A1AA
        beq.b   l_000_0A1E2                     ; 0A1B0
        movea.l (TireSample).l,a0               ; 0A1B2
        move.l  #$1360000,$8(a0)                ; 0A1B8
        move.l  #$fffe0000,$18(a0)              ; 0A1C0
        moveq   #$1,d0                          ; 0A1C8
        move.l  d0,$10(a0)                      ; 0A1CA
        move.l  $8(a6),-(a7)                    ; 0A1CE
        moveq   #$2,d0                          ; 0A1D2
        move.l  d0,-(a7)                        ; 0A1D4
        moveq   #$5,d0                          ; 0A1D6
        move.l  d0,-(a7)                        ; 0A1D8
        bsr.w   PlaySound                       ; 0A1DA
        lea.l   $c(a7),a7                       ; 0A1DE
l_000_0A1E2:
        unlk    a6                              ; 0A1E2
        rts                                     ; 0A1E4

;-------------------------------------------------------------------------------
; PlayGearSound - Plays GearSample (if loaded), only for the viewed object.
;-------------------------------------------------------------------------------
PlayGearSound:
        link.w  a6,#$0                          ; 0A1E6
        btst    #$6,(SoundsLoaded).l            ; 0A1EA
        beq.b   l_000_0A248                     ; 0A1F2
        move.w  (CurrentObjectOffset).l,d0      ; 0A1F4
        move.w  (ViewObject).l,d1               ; 0A1FA
        cmp.w   d1,d0                           ; 0A200
        bne.b   l_000_0A248                     ; 0A202
        tst.l   (GearSample).l                  ; 0A204
        beq.b   l_000_0A248                     ; 0A20A
        moveq   #$2,d0                          ; 0A20C
        move.l  d0,-(a7)                        ; 0A20E
        bsr.w   StopSound                       ; 0A210
        addq.l  #$4,a7                          ; 0A214
        movea.l (GearSample).l,a0               ; 0A216
        moveq   #$0,d0                          ; 0A21C
        move.l  d0,$2c(a0)                      ; 0A21E
        move.l  #dat_086_00088,$30(a0)          ; 0A222
        move.l  d0,$34(a0)                      ; 0A22A
        moveq   #$1,d0                          ; 0A22E
        move.l  d0,$2c(a0)                      ; 0A230
        move.l  $8(a6),-(a7)                    ; 0A234
        moveq   #$2,d0                          ; 0A238
        move.l  d0,-(a7)                        ; 0A23A
        moveq   #$b,d0                          ; 0A23C
        move.l  d0,-(a7)                        ; 0A23E
        bsr.w   PlaySound                       ; 0A240
        lea.l   $c(a7),a7                       ; 0A244
l_000_0A248:
        unlk    a6                              ; 0A248
        rts                                     ; 0A24A

;-------------------------------------------------------------------------------
; StopChannel2 - Stops sound channel 2.
;-------------------------------------------------------------------------------
StopChannel2:
        moveq   #$2,d0                          ; 0A24C
        move.l  d0,-(a7)                        ; 0A24E
        bsr.w   StopSound                       ; 0A250
        addq.l  #$4,a7                          ; 0A254
        rts                                     ; 0A256

;-------------------------------------------------------------------------------
; PlayEffect2 - Plays EffectSound2 on channel 2 at the period on the stack (if SoundFlags bit
; 1).
;-------------------------------------------------------------------------------
PlayEffect2:
        link.w  a6,#$fffc                       ; 0A258
        btst    #$1,(SoundFlags).l              ; 0A25C
        beq.w   l_000_0A2EC                     ; 0A264
        tst.l   (EffectSound2).l                ; 0A268
        beq.b   l_000_0A2EC                     ; 0A26E
        moveq   #$2,d0                          ; 0A270
        move.l  d0,-(a7)                        ; 0A272
        bsr.w   StopSound                       ; 0A274
        addq.l  #$4,a7                          ; 0A278
        moveq   #$10,d0                         ; 0A27A
        move.l  $8(a6),d1                       ; 0A27C
        asl.l   d0,d1                           ; 0A280
        move.l  d1,(dat_086_000D4).l            ; 0A282
        move.l  $8(a6),d0                       ; 0A288
        subq.l  #$1,d0                          ; 0A28C
        moveq   #$10,d1                         ; 0A28E
        asl.l   d1,d0                           ; 0A290
        neg.l   d0                              ; 0A292
        moveq   #$3c,d1                         ; 0A294
        jsr     (CXD33).l                       ; 0A296
        move.l  d0,(dat_086_000DC).l            ; 0A29C
        movea.l (EffectSound2).l,a0             ; 0A2A2
        clr.l   $34(a0)                         ; 0A2A8
        moveq   #$3,d0                          ; 0A2AC
        move.l  d0,-(a7)                        ; 0A2AE
        move.l  a0,$4(a7)                       ; 0A2B0
        jsr     (sub_083_00272).l               ; 0A2B4
        addq.l  #$4,a7                          ; 0A2BA
        addi.l  #$8c,d0                         ; 0A2BC
        moveq   #$10,d1                         ; 0A2C2
        asl.l   d1,d0                           ; 0A2C4
        movea.l $0(a7),a0                       ; 0A2C6
        move.l  d0,$8(a0)                       ; 0A2CA
        moveq   #$1,d0                          ; 0A2CE
        movea.l (EffectSound2).l,a0             ; 0A2D0
        move.l  d0,$2c(a0)                      ; 0A2D6
        clr.l   -(a7)                           ; 0A2DA
        moveq   #$2,d0                          ; 0A2DC
        move.l  d0,-(a7)                        ; 0A2DE
        moveq   #$c,d0                          ; 0A2E0
        move.l  d0,-(a7)                        ; 0A2E2
        bsr.w   PlaySound                       ; 0A2E4
        lea.l   $c(a7),a7                       ; 0A2E8
l_000_0A2EC:
        unlk    a6                              ; 0A2EC
        rts                                     ; 0A2EE

;-------------------------------------------------------------------------------
; PlayGunSound - Plays the gun's sound (GunSoundCopy) on channel 2.
;-------------------------------------------------------------------------------
PlayGunSound:
        link.w  a6,#$0                          ; 0A2F0
        tst.l   (GunSoundCopy).l                ; 0A2F4
        beq.b   l_000_0A346                     ; 0A2FA
        moveq   #$2,d0                          ; 0A2FC
        move.l  d0,-(a7)                        ; 0A2FE
        bsr.w   StopSound                       ; 0A300
        addq.l  #$4,a7                          ; 0A304
        movea.l (GunSoundCopy).l,a0             ; 0A306
        moveq   #$0,d0                          ; 0A30C
        move.l  d0,$2c(a0)                      ; 0A30E
        move.l  $8(a6),(dat_086_000FC).l        ; 0A312
        moveq   #$10,d0                         ; 0A31A
        move.l  $c(a6),d1                       ; 0A31C
        asl.l   d0,d1                           ; 0A320
        move.l  d1,(dat_086_00104).l            ; 0A322
        moveq   #$0,d0                          ; 0A328
        move.l  d0,$34(a0)                      ; 0A32A
        moveq   #$1,d0                          ; 0A32E
        move.l  d0,$2c(a0)                      ; 0A330
        clr.l   -(a7)                           ; 0A334
        moveq   #$2,d0                          ; 0A336
        move.l  d0,-(a7)                        ; 0A338
        moveq   #$a,d0                          ; 0A33A
        move.l  d0,-(a7)                        ; 0A33C
        bsr.w   PlaySound                       ; 0A33E
        lea.l   $c(a7),a7                       ; 0A342
l_000_0A346:
        unlk    a6                              ; 0A346
        rts                                     ; 0A348
	dc.b	$00,$00
h000_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    1,0                             ; 1 longs pointing into hunk 0
	dc.l	$56
        dc.l    22,1                            ; 22 longs pointing into hunk 1
	dc.l	$1BE,$1B2,$17A,$16E,$158,$14C,$144,$11A
	dc.l	$FA,$EA,$DC,$A2,$9C,$82,$78,$4C
	dc.l	$38,$28,$22,$1C,$8,$2
        dc.l    5,1                             ; 5 longs pointing into hunk 1
	dc.l	$7B4,$6EA,$6CA,$43A,$3E4
        dc.l    3,2                             ; 3 longs pointing into hunk 2
	dc.l	$7F8,$7F0,$7C2
        dc.l    1,1                             ; 1 longs pointing into hunk 1
	dc.l	$1088
        dc.l    1,1                             ; 1 longs pointing into hunk 1
	dc.l	$163A
        dc.l    87,2                            ; 87 longs pointing into hunk 2
	dc.l	$3220,$31E8,$31C2,$3160,$314C,$3138,$3016,$2FBC
	dc.l	$2EF8,$2ED4,$2E46,$2DB2,$2D8C,$2D52,$2CDA,$2C68
	dc.l	$2C30,$2BE8,$2BC6,$2B6E,$2AF6,$2ABA,$2A8C,$2A48
	dc.l	$2A22,$2A16,$29D4,$29B8,$29AC,$299E,$2908,$28D4
	dc.l	$28A4,$2876,$2804,$27C2,$2796,$2770,$273E,$26EA
	dc.l	$2662,$260C,$25E8,$25A2,$2562,$252E,$2506,$24AA
	dc.l	$244C,$2422,$23E8,$23BC,$2372,$2344,$22AE,$224C
	dc.l	$21F0,$2188,$216C,$20FE,$2012,$1FCE,$1F70,$1F46
	dc.l	$1F1A,$1E3C,$1DFC,$1D2A,$1D00,$1CE8,$1CBA,$1BEE
	dc.l	$1BCA,$1B8E,$1B4E,$1B2E,$1ADC,$1ABE,$1A90,$1A5A
	dc.l	$19C0,$1952,$191E,$18E6,$1898,$184C,$16B2
        dc.l    45,2                            ; 45 longs pointing into hunk 2
	dc.l	$7278,$726A,$7218,$720A,$718E,$700A,$6FF8,$6F5C
	dc.l	$6F16,$6EF8,$6ED4,$6EB0,$6E9E,$6E7E,$6E70,$6E38
	dc.l	$6E1C,$6DF2,$6DC4,$6D80,$6D28,$6D18,$6D08,$6C8E
	dc.l	$6C44,$6BD4,$6B32,$6AC6,$6A98,$6A5C,$6A3C,$69E6
	dc.l	$69CC,$69B6,$69A4,$68DA,$6740,$6640,$649C,$6416
	dc.l	$63C4,$6346,$6324,$62FE,$5EF8
        dc.l    47,2                            ; 47 longs pointing into hunk 2
	dc.l	$7D36,$7D24,$7D12,$7D00,$7CF0,$7CCE,$7CC0,$7CB2
	dc.l	$7CA4,$7C96,$7C7E,$7C66,$7BB6,$7B7A,$7B5E,$7AA4
	dc.l	$7A88,$7A7A,$7A5E,$7A4C,$7956,$7938,$7924,$7902
	dc.l	$78F4,$7870,$7832,$7800,$77E2,$76E0,$76D4,$76A8
	dc.l	$769C,$7676,$766A,$763E,$7632,$75EC,$75E0,$75B8
	dc.l	$757A,$7560,$7556,$7400,$7352,$7348,$732C
        dc.l    1,1                             ; 1 longs pointing into hunk 1
	dc.l	$7F0E
        dc.l    25,1                            ; 25 longs pointing into hunk 1
	dc.l	$8A1A,$89A6,$898C,$894C,$8910,$88FA,$886E,$8814
	dc.l	$87CA,$877E,$873E,$8712,$86D8,$86B4,$8674,$85FC
	dc.l	$85DA,$85C4,$854C,$8506,$84F8,$84E2,$84C2,$8478
	dc.l	$845C
        dc.l    19,2                            ; 19 longs pointing into hunk 2
	dc.l	$8A0E,$89F2,$89EA,$89E2,$89C2,$89BA,$89B2,$896E
	dc.l	$8968,$895C,$8936,$891A,$88EA,$88D4,$8608,$855C
	dc.l	$850C,$8494,$8450
        dc.l    14,1                            ; 14 longs pointing into hunk 1
	dc.l	$9212,$9204,$8F0E,$8E3A,$8DB4,$8DAC,$8D92,$8D72
	dc.l	$8D48,$8D14,$8D0E,$8CFA,$8CEA,$8CE2
        dc.l    54,2                            ; 54 longs pointing into hunk 2
	dc.l	$9244,$9236,$9220,$91D8,$91CA,$91BC,$91A6,$9198
	dc.l	$918A,$917C,$9174,$9168,$9162,$9158,$914A,$905A
	dc.l	$9050,$9022,$9004,$8FE8,$8FDA,$8FD0,$8FCA,$8FBE
	dc.l	$8FA4,$8F96,$8F74,$8F66,$8F52,$8F4E,$8F34,$8F26
	dc.l	$8F04,$8EE8,$8EDE,$8ED0,$8EBA,$8EA6,$8EA2,$8E92
	dc.l	$8E88,$8E7A,$8E74,$8E6C,$8E66,$8E5E,$8E58,$8E32
	dc.l	$8DBA,$8D9E,$8D64,$8D34,$8D22,$8D00
        dc.l    11,1                            ; 11 longs pointing into hunk 1
	dc.l	$95B6,$93FA,$93EA,$93DA,$93BC,$93AC,$939C,$9274
	dc.l	$926C,$9264,$925C
        dc.l    12,2                            ; 12 longs pointing into hunk 2
	dc.l	$95DE,$95CA,$95C4,$95BA,$95B0,$95AA,$941C,$9414
	dc.l	$930E,$9304,$92A0,$929A
        dc.l    14,1                            ; 14 longs pointing into hunk 1
	dc.l	$9BEC,$9B9E,$9B44,$9AEC,$99F6,$99D8,$9818,$97B6
	dc.l	$9794,$9732,$9710,$96EE,$96CC,$9666
        dc.l    3,172                           ; 3 longs pointing into hunk 172
	dc.l	$5E,$1640,$9624
        dc.l    1,123                           ; 1 longs pointing into hunk 123
	dc.l	$13E
        dc.l    5,0                             ; 5 longs pointing into hunk 0
	dc.l	$12E,$1D8A,$7DE2,$7EAA,$7EE0
        dc.l    1,167                           ; 1 longs pointing into hunk 167
	dc.l	$D0
        dc.l    12,171                          ; 12 longs pointing into hunk 171
	dc.l	$1E2,$847E,$84E8,$85E0,$867A,$86BA,$86DE,$8718
	dc.l	$8744,$8784,$87D0,$881A
        dc.l    12,0                            ; 12 longs pointing into hunk 0
	dc.l	$206,$226,$23A,$250,$266,$298,$2AE,$382
	dc.l	$3B0,$94C,$B12,$B98
        dc.l    2,0                             ; 2 longs pointing into hunk 0
	dc.l	$282,$3A2
        dc.l    18,172                          ; 18 longs pointing into hunk 172
	dc.l	$2C2,$32E,$36A,$89C,$8C8,$FF8,$1024,$1068
	dc.l	$7D7A,$7D98,$802E,$8052,$8076,$809A,$80E8,$8192
	dc.l	$8B1E,$8B9A
        dc.l    3,181                           ; 3 longs pointing into hunk 181
	dc.l	$2EA,$7F92,$7FB2
        dc.l    10,171                          ; 10 longs pointing into hunk 171
	dc.l	$3BC,$84CC,$8532,$8638,$86CA,$8728,$8770,$87B4
	dc.l	$8806,$884A
        dc.l    1383,71                         ; 1383 longs pointing into hunk 71
	dc.l	$3DA,$41A,$420,$54C,$66C,$428,$508,$5D6
	dc.l	$544,$74A,$79C,$848,$85C,$870,$884,$8A4
	dc.l	$112A,$14B2,$14BA,$1142,$14E0,$114E,$115C,$1170
	dc.l	$119C,$11B6,$11D6,$11F2,$1200,$120E,$121C,$123E
	dc.l	$124C,$125C,$126A,$1278,$128C,$139C,$13F2,$1430
	dc.l	$14EA,$14F8,$1506,$11BC,$11C6,$11E6,$1350,$1222
	dc.l	$1292,$13FA,$129C,$12C4,$12A6,$12B4,$12F2,$1316
	dc.l	$1334,$135E,$137C,$13DE,$13EA,$1404,$141E,$148A
	dc.l	$14A8,$14D8,$1526,$1534,$153A,$1546,$155A,$1572
	dc.l	$15BC,$1578,$15C6,$15E8,$15B8,$15CE,$15C2,$15D4
	dc.l	$15E4,$15EE,$169C,$1A86,$1B02,$1B36,$1B66,$174E
	dc.l	$20C8,$2A00,$2A08,$175A,$19A0,$1A80,$1AF0,$1AFC
	dc.l	$1B24,$1C36,$1E12,$1E46,$1F22,$1F36,$1F76,$2018
	dc.l	$2024,$247C,$24EE,$267C,$280C,$28EC,$2B1E,$2B32
	dc.l	$2CA0,$2DCA,$2E94,$3206,$3292,$331A,$3408,$1766
	dc.l	$182E,$183C,$1856,$1860,$18A2,$18C6,$18EE,$190A
	dc.l	$1E1A,$1E22,$1F7E,$2006,$311A,$3126,$1770,$1C28
	dc.l	$177C,$18B4,$1900,$1924,$1930,$1788,$1798,$181C
	dc.l	$2EB2,$1792,$17B0,$17D6,$2EAC,$2EB8,$3008,$179E
	dc.l	$17A8,$17B6,$300C,$17C4,$17CE,$17DC,$2EBC,$1806
	dc.l	$1F9A,$2954,$2F4C,$1810,$1822,$18C0,$2F04,$3050
	dc.l	$3062,$3074,$322E,$32BA,$32EE,$330C,$337C,$33B6
	dc.l	$33D8,$33FC,$3428,$342E,$1842,$1870,$18AE,$18FA
	dc.l	$1CCC,$1EF0,$25BE,$2638,$27E0,$32E6,$1866,$1A7A
	dc.l	$27EA,$28AC,$28F4,$29DC,$29E6,$1878,$18D4,$1B0E
	dc.l	$1BDC,$1C7A,$20D4,$2162,$261E,$2D1E,$2D94,$2FE8
	dc.l	$309E,$31D6,$1880,$18DC,$1914,$1944,$194C,$19B6
	dc.l	$1A98,$1AB4,$1AC6,$1B16,$1B56,$1B76,$1B9E,$1BC0
	dc.l	$1BD2,$1C72,$1CC2,$1F06,$1F10,$202C,$20B8,$234E
	dc.l	$238C,$23B2,$23C4,$2418,$2442,$246C,$2524,$253E
	dc.l	$2598,$25DE,$25F0,$2602,$2658,$266C,$272C,$2746
	dc.l	$2760,$2778,$27B8,$27CE,$27FA,$28CA,$28E0,$29CA
	dc.l	$29FA,$2A2C,$2A82,$2AA4,$2AEC,$2B0E,$2BB2,$2C0C
	dc.l	$2C44,$2C70,$2D48,$2D82,$2DA0,$2DBE,$2ECA,$2EDC
	dc.l	$2FF4,$319E,$31CA,$31DE,$31FA,$1888,$1AD2,$1BA8
	dc.l	$1BE4,$1C4E,$1C90,$1CD6,$1CF2,$1D1C,$20DC,$2282
	dc.l	$235A,$2394,$23D0,$2402,$242C,$2476,$24C8,$254A
	dc.l	$257C,$25D2,$264C,$2676,$2720,$27DA,$29C2,$29EE
	dc.l	$2A36,$2A6E,$2B18,$2BAA,$2BFC,$2C18,$2C4C,$2D02
	dc.l	$2DD0,$2E5E,$307C,$31AA,$3216,$188E,$1AA8,$1B1C
	dc.l	$1B7E,$1BB4,$20EE,$2362,$2380,$23D8,$23F6,$2552
	dc.l	$2570,$2DA8,$2FFC,$318A,$3194,$18CE,$1C46,$1D92
	dc.l	$227C,$23AA,$2410,$243A,$24A0,$24E8,$2538,$27F2
	dc.l	$28BE,$2B5E,$2C5E,$2C9A,$2D3A,$2D74,$3088,$31EE
	dc.l	$1910,$1936,$193E,$195A,$1D12,$2460,$24BE,$25B0
	dc.l	$25C8,$262A,$2642,$2702,$2710,$2A52,$2A94,$2AC2
	dc.l	$2AFE,$2B76,$196E,$19A8,$1C20,$21AA,$2242,$2264
	dc.l	$258A,$2752,$2B9A,$19AE,$2590,$25FA,$2758,$27B0
	dc.l	$2A7A,$2AE4,$2B56,$2BD4,$2C58,$2D2C,$19DA,$19F6
	dc.l	$1A16,$1AA2,$1B84,$1BAE,$20EA,$2368,$237A,$23DE
	dc.l	$23F0,$2558,$256A,$1B6E,$21B2,$22A4,$28B4,$2D5A
	dc.l	$2F82,$30C2,$3172,$1BF6,$1C02,$1BFA,$1C0A,$1C12
	dc.l	$2106,$21FA,$2226,$2256,$22B4,$2BB8,$1C1A,$21B8
	dc.l	$225E,$23A4,$24FC,$2784,$279E,$2AD2,$2B4E,$2BDC
	dc.l	$2C94,$2D12,$2D6E,$1C56,$1C9C,$228A,$30CE,$30DE
	dc.l	$30F2,$1C5C,$1CA2,$2290,$30FA,$1C6A,$1CB0,$229E
	dc.l	$239C,$240A,$2434,$24D0,$2584,$2D0C,$3098,$1C84
	dc.l	$1D08,$24B4,$26F8,$2880,$289A,$2A62,$2BF0,$2E36
	dc.l	$2E50,$303E,$312E,$31B8,$3490,$1CDE,$1D36,$1E0A
	dc.l	$1FF8,$22DA,$2458,$2696,$2814,$288C,$291C,$2A3E
	dc.l	$2B46,$2C20,$2DD6,$31B2,$320E,$3468,$1D42,$1E52
	dc.l	$1D4A,$1EFC,$2082,$2CB4,$1D52,$1D74,$203C,$1DAA
	dc.l	$347C,$1E28,$1ED0,$1EE4,$1F88,$1F90,$1FD6,$1FFE
	dc.l	$1FA2,$1FB4,$20AC,$2194,$220E,$30D6,$30E6,$20C0
	dc.l	$217E,$2206,$20E4,$2510,$2734,$2BA2,$210E,$22C0
	dc.l	$219C,$2216,$24DC,$2D32,$2D66,$21BE,$24E2,$278C
	dc.l	$27AA,$2AB0,$2ADE,$2B2C,$2B86,$2B8E,$2C06,$2C7C
	dc.l	$2D24,$21C6,$30A4,$30B0,$21CE,$30B6,$3168,$21D6
	dc.l	$3110,$21DC,$21E6,$2E0C,$2F0C,$2F1A,$2F72,$2F7C
	dc.l	$2F94,$2FC6,$2FD0,$221E,$2C8C,$251C,$2D40,$2D7A
	dc.l	$25AA,$25B8,$2624,$2632,$270A,$2718,$281C,$2854
	dc.l	$2892,$2B64,$2C26,$3034,$348A,$2BCE,$2C38,$2CE8
	dc.l	$2CF2,$2E64,$2E6E,$2F62,$2F6C,$2E74,$2E7E,$2E84
	dc.l	$2E8E,$2EA0,$2EC2,$3346,$339C,$2EE8,$2F2A,$2F52
	dc.l	$2F5C,$2F8E,$2F9C,$3090,$30BC,$30EC,$3106,$317C
	dc.l	$3484,$3496,$34A6,$34CC,$360C,$34F8,$3500,$350E
	dc.l	$3528,$352C,$3536,$3556,$357A,$3586,$3598,$3606
	dc.l	$3630,$371C,$3828,$389C,$38AE,$395E,$39B2,$39C4
	dc.l	$39F2,$3A74,$3A86,$3AD0,$3B14,$3B26,$3B58,$354E
	dc.l	$35B0,$3684,$375C,$3770,$3840,$3A16,$3A20,$3B90
	dc.l	$3570,$373E,$37EC,$3802,$384E,$388A,$3A38,$3A4E
	dc.l	$3AAA,$35CA,$380C,$35D6,$35DE,$35FE,$3636,$3666
	dc.l	$36F0,$3648,$365C,$368A,$36A2,$36BA,$3710,$372A
	dc.l	$3744,$3846,$3856,$38B8,$38CC,$3964,$3B60,$3B78
	dc.l	$3BAE,$38DA,$38EE,$399A,$38E4,$38F8,$398A,$3994
	dc.l	$3904,$390E,$3918,$39CE,$39D8,$3A58,$3A62,$3A6C
	dc.l	$3AB4,$3ABE,$3AC8,$3926,$3B66,$3B84,$3BBC,$392E
	dc.l	$3934,$393E,$3944,$394C,$3984,$39E0,$3A08,$3A26
	dc.l	$3AF6,$3B48,$3A92,$3AE2,$3AF0,$3B08,$3B32,$3A98
	dc.l	$3B38,$3B3E,$3B50,$3BA2,$3B7E,$3BC2,$3BDE,$3BEC
	dc.l	$3C00,$3C0C,$3BE4,$3BF2,$3BF8,$3C06,$3C28,$3C6C
	dc.l	$3C56,$3C66,$3C96,$3C9E,$3CAA,$3CBA,$3CCE,$3CE6
	dc.l	$3CF4,$3CB2,$3CC6,$3CDE,$3CFA,$3FF0,$4150,$41E0
	dc.l	$3D06,$3D20,$3D6C,$3DBC,$3DC6,$3E3A,$3E44,$3E60
	dc.l	$3E6A,$3E94,$3E9E,$3EAC,$3EBC,$3EC6,$3ED8,$3EE2
	dc.l	$3F24,$3F2E,$40E6,$40F0,$419C,$41A6,$3D16,$3D56
	dc.l	$3ECE,$3F08,$3F34,$3F8E,$3FD6,$4026,$403E,$4072
	dc.l	$40C0,$40FA,$4146,$4170,$41AE,$3D3A,$3D44,$3F14
	dc.l	$3F1E,$3F9E,$3FAE,$4000,$4016,$4020,$4062,$406C
	dc.l	$40C6,$40D0,$4108,$4114,$411E,$417C,$4186,$3D64
	dc.l	$3D7E,$3D96,$3FB4,$40D6,$40E0,$4124,$418C,$4196
	dc.l	$3DB2,$3DCC,$3DE2,$3E2E,$3E54,$3E88,$3EEC,$3F0E
	dc.l	$40BA,$3F64,$3F7E,$41B8,$41C2,$3F78,$404C,$407C
	dc.l	$3F88,$3FC0,$408C,$4130,$3FC4,$3FD0,$4096,$409E
	dc.l	$4134,$4140,$415C,$4164,$3FCC,$413C,$400C,$4036
	dc.l	$4046,$4076,$40AA,$40B4,$414A,$4176,$41B2,$4058
	dc.l	$4086,$41C8,$41D2,$41DA,$41EE,$4248,$4252,$4272
	dc.l	$42CC,$4332,$43CE,$43F8,$4B0A,$4DF0,$4F16,$52A2
	dc.l	$5356,$53EE,$5552,$41F8,$4208,$4394,$439C,$43BA
	dc.l	$4AAA,$4216,$43AA,$4AB8,$4224,$423A,$433A,$434A
	dc.l	$4242,$4AC6,$5286,$52BA,$4258,$427A,$4296,$429C
	dc.l	$42F6,$4302,$43E0,$425E,$4862,$4870,$4266,$426E
	dc.l	$42A4,$430A,$43E6,$42B0,$4316,$43D8,$42B8,$431E
	dc.l	$43C8,$444E,$4458,$4476,$4480,$42D4,$4AE2,$42DE
	dc.l	$42E8,$432C,$4376,$4384,$4350,$435A,$4360,$485C
	dc.l	$4AD2,$4F20,$436E,$43C0,$4400,$4412,$441A,$443A
	dc.l	$4448,$4468,$4470,$4460,$44B8,$44CA,$44D2,$44DA
	dc.l	$4498,$44A0,$44E0,$44EA,$4538,$4542,$4676,$46C8
	dc.l	$479E,$47EC,$467C,$46D0,$47AA,$47F4,$468C,$4694
	dc.l	$46DC,$46E4,$47BA,$4800,$4772,$4790,$47A4,$47E2
	dc.l	$4A8A,$4A94,$4AE8,$4AF6,$4B00,$4B34,$4B3E,$4B46
	dc.l	$4B56,$4B12,$4F36,$5368,$4B5C,$4B74,$4BC6,$4C06
	dc.l	$4C4A,$4C88,$4CC6,$4D08,$4D44,$4D80,$4DBC,$4DD0
	dc.l	$4B66,$4C3E,$4DD6,$4DDE,$4DE6,$4E3C,$4DF8,$4E1A
	dc.l	$4E02,$4E26,$4E48,$4F40,$4F50,$5450,$5460,$51B2
	dc.l	$528C,$5298,$52E6,$531C,$51BC,$520E,$52CE,$5372
	dc.l	$54AA,$5586,$5598,$5616,$5620,$5660,$5690,$5AFE
	dc.l	$5B06,$5600,$5AF2,$5628,$5632,$5644,$566A,$5672
	dc.l	$5684,$569A,$56A2,$56B4,$56C0,$5AE4,$5B20,$5B2A
	dc.l	$5B50,$5B5A,$5B64,$5B6E,$5654,$571E,$5734,$5746
	dc.l	$5812,$588E,$58A4,$58C0,$58F6,$5950,$5974,$5994
	dc.l	$59AA,$59BC,$59F8,$5A20,$5A44,$5A6A,$5AA6,$5B32
	dc.l	$5B3A,$5B46,$5E86,$5EA4,$5EB0,$5EF0,$6B2A,$6FD0
	dc.l	$6FDA,$6FDE,$7058,$70BE,$711E,$712A,$7174,$717A
	dc.l	$5E8E,$6174,$61D2,$627E,$5E96,$5ECE,$5EBE,$5EC8
	dc.l	$6088,$6204,$622A,$6260,$5EDE,$6B18,$5F5C,$6196
	dc.l	$626A,$6288,$5F62,$617C,$619C,$61A6,$61DC,$61F2
	dc.l	$61FC,$6218,$6232,$6256,$6266,$628E,$5FDC,$604A
	dc.l	$60D4,$6244,$5FEC,$605A,$60E4,$6250,$684A,$6FE6
	dc.l	$6044,$60CE,$6062,$6852,$61C6,$62CE,$62DC,$70C8
	dc.l	$70D2,$7112,$7150,$715A,$682A,$683A,$685A,$6864
	dc.l	$7062,$70AE,$70B8,$70DC,$70FE,$722E,$7238,$6842
	dc.l	$6F80,$7070,$70EC,$71D8,$6AC0,$7264,$6B50,$6B5A
	dc.l	$6B80,$6B64,$6B88,$6B6E,$6BB0,$6BB8,$6BC0,$6BEE
	dc.l	$6C54,$6CC8,$6C7E,$6D4A,$6D5E,$6F78,$6D32,$6F6C
	dc.l	$71F0,$6F70,$71EA,$71F8,$7204,$6F8E,$6FBE,$6FC6
	dc.l	$7026,$7076,$7086,$723E,$7248,$70F4,$7138,$7148
	dc.l	$7160,$716A,$71FE,$72F6,$72FE,$73A6,$74C8,$74D0
	dc.l	$74DA,$770C,$771A,$7728,$7840,$787C,$7888,$7896
	dc.l	$78AC,$78B4,$78BE,$78D0,$78D8,$78E2,$78FA,$7908
	dc.l	$7910,$7932,$7942,$79B8,$79C4,$79DA,$79E2,$79F4
	dc.l	$79FC,$7A40,$7B52,$7BA2,$7BC4,$7BCE,$7CE0,$7CEA
	dc.l	$7CFA,$7D0A,$7D1C,$7D2E,$7326,$7332,$733A,$735C
	dc.l	$736A,$7376,$740E,$7430,$7470,$73F2,$7416,$7478
	dc.l	$744E,$77BE,$77CC,$746A,$77A2,$77B0,$7484,$748C
	dc.l	$74E2,$75F8,$7784,$78A6,$791C,$79D4,$7AC2,$7BAE
	dc.l	$78CA,$792C,$79EE,$7AD6,$7BBE,$78EE,$794E,$7A08
	dc.l	$7AEA,$7BDA,$7986,$7B08,$7A0E,$7A32,$7B44,$7C58
	dc.l	$7C70,$7C88,$7D6A,$7DB2,$7DD4,$8040,$80B2,$8112
	dc.l	$8064,$80BA,$811C,$8088,$80C2,$8126,$80AC,$8130
	dc.l	$80FA,$8116,$8120,$812A,$8134,$819A,$8334,$83AC
	dc.l	$8276,$8290,$83C2,$83CC,$82D0,$82EE,$8366,$836E
	dc.l	$8378,$8380,$8388,$838E,$8442,$8590,$85AE,$8582
	dc.l	$85A2,$8A84,$8E8C,$8E96,$901A,$9080,$90B0,$90E2
	dc.l	$90EA,$90F8,$910E,$9126,$912E,$913C,$935C,$9376
	dc.l	$9380,$9396,$93A6,$93B6,$93C6,$93CE,$9386,$9390
	dc.l	$93D4,$93E4,$93F4,$9404,$940C,$9422,$942A,$9430
	dc.l	$945C,$946C,$9474,$9488,$9530,$9436,$9536,$9442
	dc.l	$944A,$9464,$947C,$94B6,$9540,$9582,$956E,$9576
	dc.l	$96B4,$999A,$9A60,$9AE2,$9B00,$9B3A,$9B64,$9B96
	dc.l	$9BE2,$9C50,$9CFA,$9D3A,$9D82,$9DBA,$9E4E,$9EC6
	dc.l	$9F06,$9FA2,$A0E4,$A194,$A1EE,$A260,$9CEC,$9D30
	dc.l	$9D6A,$A17C,$A184,$A19C,$A1F6,$A1A2,$A1FC
        dc.l    3,172                           ; 3 longs pointing into hunk 172
	dc.l	$3EA,$7BA,$7F14
        dc.l    182,2                           ; 182 longs pointing into hunk 2
	dc.l	$3F2,$6A8,$6B0,$42E,$4D4,$4DC,$80E,$816
	dc.l	$434,$628,$6C4,$6E4,$448,$4B6,$4C4,$820
	dc.l	$83A,$84E,$862,$876,$49A,$514,$5AA,$5C6
	dc.l	$63E,$65A,$4A8,$580,$5BC,$608,$650,$6BE
	dc.l	$716,$71E,$6D8,$6FE,$6DE,$768,$770,$6F8
	dc.l	$750,$834,$7DF8,$7E8A,$8182,$81A0,$81D6,$7E78
	dc.l	$7E94,$7F4E,$7F5C,$800A,$8012,$801C,$81DA,$81E0
	dc.l	$81E8,$81EE,$821A,$8230,$8240,$826C,$8282,$82BC
	dc.l	$82DA,$8304,$8314,$8322,$833A,$834A,$8358,$839A
	dc.l	$83B2,$7F1C,$7F32,$7F3A,$7F40,$7F60,$81F4,$8202
	dc.l	$8210,$822A,$8246,$8254,$8262,$82A6,$82C2,$7F66
	dc.l	$7F72,$7F6C,$7F76,$7FAC,$7FD8,$7FE4,$8036,$805A
	dc.l	$807E,$80A2,$80F0,$813A,$8140,$814C,$8158,$8164
	dc.l	$8236,$7FBC,$7FDE,$7FCA,$7FE8,$7FEE,$7FF6,$7FFC
	dc.l	$8002,$8018,$823A,$81C0,$8214,$8266,$82A0,$821E
	dc.l	$8270,$82B6,$8A34,$8A3C,$8B7E,$8B84,$8A46,$8BBA
	dc.l	$8BCA,$8BDA,$8BEA,$8A5C,$8A64,$8A6E,$8ADC,$8AEA
	dc.l	$8AF8,$8B06,$8A8C,$8A9A,$8AA8,$8AB6,$8AC4,$8A94
	dc.l	$8AA2,$8AB0,$8ABE,$8ACC,$8AE4,$8B3E,$8AF2,$8B4E
	dc.l	$8B00,$8B5E,$8B0E,$8B6E,$8B26,$8B48,$8B58,$8B68
	dc.l	$8B78,$8BA2,$8BFA,$8BC4,$8C0E,$8BD4,$8C08,$8BE4
	dc.l	$8C02,$8BF4,$92B8,$94A2,$94E6,$94F4,$952A,$9588
	dc.l	$94CA,$950E,$94D0,$9514,$94E0,$9524
        dc.l    13,96                           ; 13 longs pointing into hunk 96
	dc.l	$3FE,$7CE,$8B4,$7F2A,$80D4,$810A,$8B36,$8BB2
	dc.l	$8EC8,$8EFA,$8F46,$8F86,$8FB6
        dc.l    2,77                            ; 2 longs pointing into hunk 77
	dc.l	$406,$414
        dc.l    23,181                          ; 23 longs pointing into hunk 181
	dc.l	$450,$460,$488,$530,$6A0,$7D8,$7E8,$8F6
	dc.l	$146E,$14CA,$7DCA,$83D8,$83E4,$83F0,$83FC,$8408
	dc.l	$8414,$8420,$842C,$85BC,$85EE,$862C,$8642
        dc.l    61,0                            ; 61 longs pointing into hunk 0
	dc.l	$458,$480,$558,$566,$686,$15FA,$1606,$1612
	dc.l	$161E,$1666,$1A66,$1D6A,$2044,$2050,$2076,$208E
	dc.l	$2CC0,$20A2,$2CCE,$2FB0,$4284,$4DC8,$4B1E,$4B2C
	dc.l	$4B50,$4BA2,$4BF6,$4C32,$4C78,$4CB6,$4CF8,$4D34
	dc.l	$4D72,$4DAE,$4E10,$4E34,$4FA6,$4FD0,$4FFA,$505C
	dc.l	$50EE,$511A,$51A6,$5304,$507C,$50D0,$5144,$51D4
	dc.l	$51F2,$522A,$5258,$526C,$527E,$52DE,$5C46,$703C
	dc.l	$704C,$7428,$74C0,$749C,$74AE
        dc.l    4,172                           ; 4 longs pointing into hunk 172
	dc.l	$46C,$FBC,$7D62,$7DAA
        dc.l    2,0                             ; 2 longs pointing into hunk 0
	dc.l	$490,$7A2
        dc.l    12,181                          ; 12 longs pointing into hunk 181
	dc.l	$4A0,$51A,$5B0,$644,$7E7E,$8288,$82E0,$831A
	dc.l	$8328,$8350,$835E,$83A0
        dc.l    2,181                           ; 2 longs pointing into hunk 181
	dc.l	$4AE,$82C8
        dc.l    25,20                           ; 25 longs pointing into hunk 20
	dc.l	$4FE,$740,$792,$1188,$11A2,$11A8,$1448,$145A
	dc.l	$1660,$1F54,$1FF0,$26C2,$26DC,$2932,$325A,$286C
	dc.l	$2DEE,$4686,$46D6,$47B4,$47FA,$4778,$6BA6,$7C4E
	dc.l	$9598
        dc.l    12,74                           ; 12 longs pointing into hunk 74
	dc.l	$53E,$1D60,$205C,$9C66,$9CC4,$9F10,$9F18,$9F26
	dc.l	$9F40,$9F52,$9F78,$9F8A
        dc.l    3,0                             ; 3 longs pointing into hunk 0
	dc.l	$57A,$7D4E,$7D54
        dc.l    9,181                           ; 9 longs pointing into hunk 181
	dc.l	$5CC,$660,$7E9A,$830A,$8340,$83B8,$94AC,$94FA
	dc.l	$958E
        dc.l    4,181                           ; 4 longs pointing into hunk 181
	dc.l	$5E4,$7EEE,$8466,$865A
        dc.l    22,36                           ; 22 longs pointing into hunk 36
	dc.l	$5EA,$88A,$13A2,$1482,$14F0,$1B96,$1D7A,$1E5C
	dc.l	$1F30,$1F4E,$1FEA,$22D4,$3568,$35C2,$35F6,$3628
	dc.l	$36FA,$37D0,$3956,$72F0,$7EE8,$8170
        dc.l    3,181                           ; 3 longs pointing into hunk 181
	dc.l	$5F0,$5FC,$82E8
        dc.l    8,37                            ; 8 longs pointing into hunk 37
	dc.l	$5F6,$12CE,$12D4,$12EC,$1394,$13AE,$13C6,$13D8
        dc.l    4,181                           ; 4 longs pointing into hunk 181
	dc.l	$602,$7EFA,$8436,$859C
        dc.l    2,172                           ; 2 longs pointing into hunk 172
	dc.l	$6B6,$7FE
        dc.l    1,184                           ; 1 longs pointing into hunk 184
	dc.l	$7E0
        dc.l    3,181                           ; 3 longs pointing into hunk 181
	dc.l	$82A,$8A50,$8A78
        dc.l    34,73                           ; 34 longs pointing into hunk 73
	dc.l	$8D0,$1000,$1044,$100E,$102C,$104A,$1070,$107E
	dc.l	$109A,$10BA,$10E6,$1102,$110E,$2516,$702A,$7D82
	dc.l	$7EBE,$7ECC,$868A,$86EE,$8754,$8794,$87E0,$882A
	dc.l	$8690,$86A2,$875A,$87E6,$87F8,$86A6,$87FC,$86F8
	dc.l	$879E,$8834
        dc.l    7,152                           ; 7 longs pointing into hunk 152
	dc.l	$910,$4F5C,$546C,$9F36,$9F6E,$A118,$A298
        dc.l    1,150                           ; 1 longs pointing into hunk 150
	dc.l	$B5A
        dc.l    1,3                             ; 1 longs pointing into hunk 3
	dc.l	$BC8
        dc.l    4,171                           ; 4 longs pointing into hunk 171
	dc.l	$C14,$C28,$CBE,$D1C
        dc.l    7,171                           ; 7 longs pointing into hunk 171
	dc.l	$DDC,$F40,$8520,$8698,$8700,$87EE,$883C
        dc.l    1,171                           ; 1 longs pointing into hunk 171
	dc.l	$1092
        dc.l    1,171                           ; 1 longs pointing into hunk 171
	dc.l	$10A6
        dc.l    1,171                           ; 1 longs pointing into hunk 171
	dc.l	$10B2
        dc.l    2,172                           ; 2 longs pointing into hunk 172
	dc.l	$1114,$7ED2
        dc.l    19,0                            ; 19 longs pointing into hunk 0
	dc.l	$1136,$35F0,$37D8,$3820,$3894,$38D2,$3BB4,$37DE
	dc.l	$3868,$38A2,$38BE,$39E6,$3C12,$3A42,$3A9E,$3AFC
	dc.l	$3B6C,$3BCC,$7D88
        dc.l    3,0                             ; 3 longs pointing into hunk 0
	dc.l	$113C,$127E,$2FDC
        dc.l    5,0                             ; 5 longs pointing into hunk 0
	dc.l	$1154,$118E,$1284,$14C2,$1436
        dc.l    3,22                            ; 3 longs pointing into hunk 22
	dc.l	$1162,$1176,$699E
        dc.l    8,8                             ; 8 longs pointing into hunk 8
	dc.l	$1168,$1182,$1194,$11F8,$1206,$1252,$1262,$22C6
        dc.l    1,32                            ; 1 longs pointing into hunk 32
	dc.l	$117C
        dc.l    2,33                            ; 2 longs pointing into hunk 33
	dc.l	$11AE,$11DC
        dc.l    2,28                            ; 2 longs pointing into hunk 28
	dc.l	$11CE,$6EE6
        dc.l    1,25                            ; 1 longs pointing into hunk 25
	dc.l	$1214
        dc.l    3,0                             ; 3 longs pointing into hunk 0
	dc.l	$122A,$1244,$1270
        dc.l    3,23                            ; 3 longs pointing into hunk 23
	dc.l	$1232,$759C,$760C
        dc.l    2,38                            ; 2 longs pointing into hunk 38
	dc.l	$12DA,$12E6
        dc.l    1,40                            ; 1 longs pointing into hunk 40
	dc.l	$12E0
        dc.l    19,39                           ; 19 longs pointing into hunk 39
	dc.l	$130A,$1416,$1310,$140A,$132E,$1358,$1410,$1376
	dc.l	$13A8,$13B4,$13BA,$13C0,$13CC,$13D2,$1428,$143C
	dc.l	$14FE,$150C,$2EEE
        dc.l    2,29                            ; 2 longs pointing into hunk 29
	dc.l	$1442,$14D2
        dc.l    12,6                            ; 12 longs pointing into hunk 6
	dc.l	$14A2,$1C62,$1CA8,$2296,$3100,$42AA,$4310,$438A
	dc.l	$70A8,$7250,$903A,$904A
        dc.l    10,0                            ; 10 longs pointing into hunk 0
	dc.l	$151A,$158C,$162E,$1634,$165A,$2EA6,$3002,$3BD8
	dc.l	$6F66,$71E4
        dc.l    3,0                             ; 3 longs pointing into hunk 0
	dc.l	$1520,$1680,$1694
        dc.l    1,0                             ; 1 longs pointing into hunk 0
	dc.l	$1540
        dc.l    14,5                            ; 14 longs pointing into hunk 5
	dc.l	$1562,$1584,$15A8,$39A4,$4202,$42BE,$4324,$43EC
	dc.l	$90A8,$90DA,$90F2,$9106,$911E,$9136
        dc.l    1,172                           ; 1 longs pointing into hunk 172
	dc.l	$1652
        dc.l    14,4                            ; 14 longs pointing into hunk 4
	dc.l	$16A2,$16A8,$1968,$1A72,$1AEA,$1C3C,$2270,$2176
	dc.l	$2236,$2C84,$2CE2,$34C0,$391E,$39AA
        dc.l    24,2                            ; 24 longs pointing into hunk 2
	dc.l	$17FA,$1FBA,$2306,$26A2,$293C,$2948,$2F34,$2F40
	dc.l	$32C4,$34B0,$34C6,$34D8,$34E2,$34EE,$374A,$3784
	dc.l	$382E,$3872,$387E,$6FA6,$6FB2,$73DA,$73E6,$7DA0
        dc.l    1,7                             ; 1 longs pointing into hunk 7
	dc.l	$1816
        dc.l    11,21                           ; 11 longs pointing into hunk 21
	dc.l	$198A,$1B3C,$1D98,$3540,$35A2,$3678,$3730,$39FC
	dc.l	$35E4,$82FE,$9482
        dc.l    14,0                            ; 14 longs pointing into hunk 0
	dc.l	$19BC,$1A56,$1B42,$1D9E,$1FCA,$20F4,$2DAE,$3012
	dc.l	$2FB8,$3134,$3148,$31BE,$315C,$344E
        dc.l    3,64                            ; 3 longs pointing into hunk 64
	dc.l	$19C6,$22E6,$3776
        dc.l    5,0                             ; 5 longs pointing into hunk 0
	dc.l	$1AE4,$2FA2,$7EF4,$9D02,$9D72
        dc.l    7,26                            ; 7 longs pointing into hunk 26
	dc.l	$1C2E,$20CE,$223C,$226A,$21A2,$2230,$2766
        dc.l    7,0                             ; 7 longs pointing into hunk 0
	dc.l	$1FAC,$32CE,$3454,$1FE0,$3612,$3640,$7DC2
        dc.l    1,17                            ; 1 longs pointing into hunk 17
	dc.l	$2CF8
        dc.l    32,2                            ; 32 longs pointing into hunk 2
	dc.l	$3560,$3590,$35BA,$361C,$3652,$3670,$36E6,$3704
	dc.l	$3766,$37C8,$37E2,$37FA,$3818,$3860,$386C,$38A6
	dc.l	$38C2,$396E,$397A,$39BC,$39EA,$3A30,$3A46,$3A7E
	dc.l	$3AA2,$3ADA,$3B00,$3B1E,$3B70,$3B9A,$3BD0,$3C16
        dc.l    2,59                            ; 2 longs pointing into hunk 59
	dc.l	$3F5C,$3F72
        dc.l    4,63                            ; 4 longs pointing into hunk 63
	dc.l	$46A0,$46F0,$47C6,$480C
        dc.l    44,2                            ; 44 longs pointing into hunk 2
	dc.l	$4AC0,$4BB0,$4E58,$4E9E,$4EB6,$4ED8,$5482,$54C2
	dc.l	$5508,$5524,$559E,$55A6,$55B0,$55BA,$56C6,$575A
	dc.l	$578A,$5840,$58AA,$59D2,$5BE4,$5BEE,$5C0E,$5C22
	dc.l	$5C56,$5CB0,$5CBA,$5CF6,$5D14,$5D2E,$5D6E,$5D88
	dc.l	$5DC8,$5DE2,$5E00,$5E34,$7A46,$7A58,$7A6A,$7A82
	dc.l	$7A94,$7AB4,$7AC8,$7ADC
        dc.l    2,60                            ; 2 longs pointing into hunk 60
	dc.l	$55E2,$55EC
        dc.l    3,31                            ; 3 longs pointing into hunk 31
	dc.l	$774C,$776A,$777C
        dc.l    3,0                             ; 3 longs pointing into hunk 0
	dc.l	$7DB8,$843C,$85A8
        dc.l    1,181                           ; 1 longs pointing into hunk 181
	dc.l	$7F46
        dc.l    1,181                           ; 1 longs pointing into hunk 181
	dc.l	$7F54
        dc.l    2,181                           ; 2 longs pointing into hunk 181
	dc.l	$7FC2,$7FD0
        dc.l    1,181                           ; 1 longs pointing into hunk 181
	dc.l	$817A
        dc.l    2,181                           ; 2 longs pointing into hunk 181
	dc.l	$81FA,$824C
        dc.l    2,181                           ; 2 longs pointing into hunk 181
	dc.l	$8208,$825A
        dc.l    4,171                           ; 4 longs pointing into hunk 171
	dc.l	$84A8,$861C,$8762,$87A6
        dc.l    3,172                           ; 3 longs pointing into hunk 172
	dc.l	$8CF0,$8E40,$8F14
        dc.l    1,0                             ; 1 longs pointing into hunk 0
	dc.l	$8D06
        dc.l    5,172                           ; 5 longs pointing into hunk 172
	dc.l	$8D3A,$8D7C,$8FF4,$9060,$9182
        dc.l    3,172                           ; 3 longs pointing into hunk 172
	dc.l	$8D4E,$900A,$919E
        dc.l    2,172                           ; 2 longs pointing into hunk 172
	dc.l	$8E80,$91F8
        dc.l    5,175                           ; 5 longs pointing into hunk 175
	dc.l	$8EB2,$8EEE,$8F3A,$8F7A,$8FAA
        dc.l    6,177                           ; 6 longs pointing into hunk 177
	dc.l	$8ED6,$8F2C,$8F6C,$8F9C,$9218,$924A
        dc.l    1,172                           ; 1 longs pointing into hunk 172
	dc.l	$9190
        dc.l    3,172                           ; 3 longs pointing into hunk 172
	dc.l	$920A,$9226,$923C
        dc.l    1,172                           ; 1 longs pointing into hunk 172
	dc.l	$95D4
        dc.l    1,172                           ; 1 longs pointing into hunk 172
	dc.l	$95E8
        dc.l    1,172                           ; 1 longs pointing into hunk 172
	dc.l	$9612
        dc.l    1,174                           ; 1 longs pointing into hunk 174
	dc.l	$963A
        dc.l    1,172                           ; 1 longs pointing into hunk 172
	dc.l	$9656
        dc.l    38,80                           ; 38 longs pointing into hunk 80
	dc.l	$966C,$96D2,$96F4,$9716,$9738,$979A,$97BC,$981E
	dc.l	$99DE,$99FC,$9AF2,$9B4A,$9BA4,$9BF2,$9680,$96E2
	dc.l	$9704,$9726,$9748,$9758,$9768,$9778,$9788,$97AA
	dc.l	$97CC,$97DC,$97EC,$97FC,$980C,$982E,$9A1C,$9B16
	dc.l	$9B7A,$9BB6,$9C06,$99B6,$9A6E,$9AAC
        dc.l    68,81                           ; 68 longs pointing into hunk 81
	dc.l	$968C,$9692,$984C,$987E,$9888,$989C,$98A6,$98B6
	dc.l	$98C2,$98CC,$98D8,$98E2,$98E8,$98EE,$98F4,$98FA
	dc.l	$9900,$990A,$9914,$9964,$996A,$9982,$998A,$9990
	dc.l	$9A2A,$9A34,$9A7A,$9A8E,$9AB8,$9ACC,$9B06,$9B22
	dc.l	$9B58,$9B6A,$9B86,$9BC4,$9BCE,$9C12,$9C1E,$9C2E
	dc.l	$9C8E,$9CA8,$9CCC,$9DC2,$9DCA,$9DD6,$9DE4,$9DF6
	dc.l	$9E56,$9E5E,$9E64,$9FAC,$9FB6,$9FDE,$A048,$A0B6
	dc.l	$A0EE,$A12C,$A15C,$A1AC,$A1B4,$A206,$A218,$A26A
	dc.l	$A2A4,$A2D2,$A2F6,$A308
        dc.l    6,83                            ; 6 longs pointing into hunk 83
	dc.l	$9A86,$9AC4,$9FC4,$9FEC,$A13E,$A2B6
        dc.l    21,86                           ; 21 longs pointing into hunk 86
	dc.l	$9A94,$A05E,$A066,$A074,$A080,$A088,$A094,$A0A0
	dc.l	$A0A8,$A0B0,$9AD8,$A10A,$A11E,$A126,$9B28,$A316
	dc.l	$A324,$9B8C,$A284,$A29E,$A224
        dc.l    2,75                            ; 2 longs pointing into hunk 75
	dc.l	$9C72,$9CD8
	dc.l	0
	dc.l	HUNK_SYMBOL
	dc.l	3
	dc.b	'MakePort',0,0,0,0
	dc.l	MakePort
	dc.l	3
	dc.b	'UnmakePort',0,0
	dc.l	UnmakePort
	dc.l	0
	dc.l	HUNK_END
	endc
