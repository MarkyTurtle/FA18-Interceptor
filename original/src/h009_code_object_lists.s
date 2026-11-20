; F/A-18 Interceptor - hunk 9 (code)
; Support for hunk 8: object lists and distances (DistanceScale) (not worked out yet)
; Included by ../f18_main.s.

;===============================================================================
; Hunk 9: CODE, $1144 bytes
;===============================================================================
	CODE_HUNK	h009
l_009_00000:
        move.w  #$11,(DebugCheckpoint).l        ; 00000
        jsr     (Nop).l                         ; 00008
        bra.b   l_009_00000                     ; 0000E
l_009_00010:
        move.w  #$12,(DebugCheckpoint).l        ; 00010
        jsr     (Nop).l                         ; 00018
        bra.b   l_009_00010                     ; 0001E
l_009_00020:
        clr.b   -$2e(a6)                        ; 00020
        tst.b   (dat_071_00236).l               ; 00024
        bne.b   l_009_00032                     ; 0002A
        movea.l -$24(a6),a0                     ; 0002C
        clr.w   (a0)                            ; 00030
l_009_00032:
        movea.l (a7)+,a0                        ; 00032
        clr.w   (dat_073_00210).l               ; 00034
        movea.l -$14(a6),a2                     ; 0003A
        lea.l   (dat_071_0039E).l,a5            ; 0003E
        clr.b   (dat_071_0022C).l               ; 00044
        clr.b   (dat_071_0022E).l               ; 0004A
        clr.b   (dat_071_00237).l               ; 00050
        lea.l   (VertexBuffer).l,a4             ; 00056
l_009_0005C:
        move.b  (a0)+,d0                        ; 0005C
        blt.w   l_009_00584                     ; 0005E
        cmpi.b  #$14,d0                         ; 00062
        bgt.b   l_009_00000                     ; 00066
        ext.w   d0                              ; 00068
        movea.l -$3a(a6),a1                     ; 0006A
        move.b  (a1,d0.w),d0                    ; 0006E
        ext.w   d0                              ; 00072
        move.w  d0,d1                           ; 00074
        lea.l   (dat_008_0149C).l,a1            ; 00076
        add.w   d1,d1                           ; 0007C
        move.b  (a1,d1.w),d2                    ; 0007E
        move.b  $1(a1,d1.w),d3                  ; 00082
        ext.w   d2                              ; 00086
        ext.w   d3                              ; 00088
        add.w   (ViewCellX).l,d2                ; 0008A
        bge.b   l_009_00096                     ; 00090
        addi.w  #$80,d2                         ; 00092
l_009_00096:
        add.w   (ViewCellZ).l,d3                ; 00096
        bge.b   l_009_000A2                     ; 0009C
        addi.w  #$80,d3                         ; 0009E
l_009_000A2:
        lsl.w   #$8,d2                          ; 000A2
        andi.l  #$ff,d3                         ; 000A4
        add.w   d2,d3                           ; 000AA
        move.l  d3,(dat_071_0038C).l            ; 000AC
        asl.w   #$2,d0                          ; 000B2
        movea.l -$18(a6),a1                     ; 000B4
        movem.w (a1,d0.w),d2-d3                 ; 000B8
        tst.b   (SceneryDetailed).l             ; 000BE
        beq.b   l_009_000E2                     ; 000C4
        lea.l   (dat_008_0151A).l,a1            ; 000C6
        move.b  (ViewPlace).l,d6                ; 000CC
        ext.w   d6                              ; 000D2
        add.w   d6,d6                           ; 000D4
        add.w   d6,d6                           ; 000D6
        movem.w (a1,d6.w),d0-d1                 ; 000D8
        add.l   d0,d2                           ; 000DE
        add.l   d1,d3                           ; 000E0
l_009_000E2:
        asl.l   #$2,d2                          ; 000E2
        asl.l   #$2,d3                          ; 000E4
        move.b  (a0)+,d0                        ; 000E6
l_009_000E8:
        move.b  (a0)+,d1                        ; 000E8
        cmpi.b  #$f,d1                          ; 000EA
        bgt.w   l_009_00010                     ; 000EE
        movea.l -$32(a6),a1                     ; 000F2
        ext.w   d1                              ; 000F6
        move.b  (a1,d1.w),d1                    ; 000F8
        move.b  d1,d6                           ; 000FC
        ext.w   d6                              ; 000FE
        move.w  d6,(dat_071_0038C).l            ; 00100
        add.w   d6,d6                           ; 00106
        add.w   d6,d6                           ; 00108
        movea.l -$1c(a6),a1                     ; 0010A
        movem.w (a1,d6.w),d4-d5                 ; 0010E
        asl.l   #$2,d4                          ; 00114
        asl.l   #$2,d5                          ; 00116
        ext.w   d1                              ; 00118
        asl.w   #$5,d1                          ; 0011A
        move.w  d1,d6                           ; 0011C
        add.w   d1,d1                           ; 0011E
        add.w   d6,d1                           ; 00120
        lea.l   (a4,d1.w),a3                    ; 00122
        move.l  a3,(SceneryListLimit).l         ; 00126
        addi.l  #$60,(SceneryListLimit).l       ; 0012C
        move.l  a2,(a5)                         ; 00136
        moveq   #$0,d1                          ; 00138
l_009_0013A:
        cmpa.l  (SceneryListLimit).l,a3         ; 0013A
        bge.w   l_009_00546                     ; 00140
        cmpi.b  #$ff,(a3)                       ; 00144
        beq.w   l_009_00546                     ; 00148
        addq.b  #$1,d1                          ; 0014C
        move.w  (a3)+,d6                        ; 0014E
        move.w  d6,d7                           ; 00150
        andi.w  #$ff,d6                         ; 00152
        move.w  d6,(CurrentObject).l            ; 00156
        lsr.w   #$8,d7                          ; 0015C
        move.b  d7,(dat_071_0022A).l            ; 0015E
        lsl.w   #$8,d6                          ; 00164
        blt.w   l_009_00208                     ; 00166
        or.b    d7,d6                           ; 0016A
        move.w  d6,(a2)+                        ; 0016C
        btst    #$6,d7                          ; 0016E
        beq.b   l_009_00186                     ; 00172
        lea.l   (SmallObjects).l,a1             ; 00174
        andi.w  #$ff00,d6                       ; 0017A
        lsr.w   #$3,d6                          ; 0017E
        move.w  $2(a1,d6.w),d6                  ; 00180
        bra.b   l_009_00188                     ; 00184
l_009_00186:
        lsr.w   #$8,d6                          ; 00186
l_009_00188:
        swap    d7                              ; 00188
        add.w   d6,d6                           ; 0018A
        add.w   d6,d6                           ; 0018C
        move.w  d6,d7                           ; 0018E
        add.w   d6,d6                           ; 00190
        add.w   d6,d6                           ; 00192
        add.w   d7,d6                           ; 00194
        swap    d7                              ; 00196
        lea.l   (ObjectDrawTable).l,a1          ; 00198
        adda.w  d6,a1                           ; 0019E
        move.l  a1,(a2)+                        ; 001A0
        moveq   #$0,d6                          ; 001A2
        btst    #$6,d7                          ; 001A4
        bne.b   l_009_001B2                     ; 001A8
        btst    #$4,d7                          ; 001AA
        bne.b   l_009_001B2                     ; 001AE
        move.w  (a3)+,d6                        ; 001B0
l_009_001B2:
        tst.b   (SceneryDetailed).l             ; 001B2
        bne.b   l_009_001BE                     ; 001B8
        add.w   d6,d6                           ; 001BA
        add.w   d6,d6                           ; 001BC
l_009_001BE:
        move.l  a1,-(a7)                        ; 001BE
        lea.l   (dat_008_0151A).l,a1            ; 001C0
        move.b  (ViewPlace).l,d7                ; 001C6
        ext.w   d7                              ; 001CC
        add.w   d7,d7                           ; 001CE
        add.w   d7,d7                           ; 001D0
        move.w  (a1,d7.w),d7                    ; 001D2
        movea.l (a7)+,a1                        ; 001D6
        ext.l   d7                              ; 001D8
        asl.l   #$2,d7                          ; 001DA
        sub.l   d7,d6                           ; 001DC
        add.l   d4,d6                           ; 001DE
        add.l   d2,d6                           ; 001E0
        move.l  d6,(dat_071_000BE).l            ; 001E2
        move.l  d6,-(a7)                        ; 001E8
        moveq   #$0,d6                          ; 001EA
        btst    #$6,(dat_071_0022A).l           ; 001EC
        bne.b   l_009_00200                     ; 001F4
        btst    #$4,(dat_071_0022A).l           ; 001F6
        beq.b   l_009_00218                     ; 001FE
l_009_00200:
        clr.w   (dat_071_000C2).l               ; 00200
        bra.b   l_009_00224                     ; 00206
l_009_00208:
        move.w  #$26,(DebugCheckpoint).l        ; 00208
        jsr     (Nop).l                         ; 00210
        bra.b   l_009_00208                     ; 00216
l_009_00218:
        movea.l $4(a1),a1                       ; 00218
        clr.w   (dat_071_000C2).l               ; 0021C
        move.w  (a3)+,d6                        ; 00222
l_009_00224:
        tst.b   (SceneryDetailed).l             ; 00224
        bne.b   l_009_00230                     ; 0022A
        add.w   d6,d6                           ; 0022C
        add.w   d6,d6                           ; 0022E
l_009_00230:
        lea.l   (dat_008_0151A).l,a1            ; 00230
        move.b  (ViewPlace).l,d7                ; 00236
        ext.w   d7                              ; 0023C
        add.w   d7,d7                           ; 0023E
        add.w   d7,d7                           ; 00240
        move.w  $2(a1,d7.w),d7                  ; 00242
        ext.l   d7                              ; 00246
        asl.l   #$2,d7                          ; 00248
        sub.l   d7,d6                           ; 0024A
        add.l   d5,d6                           ; 0024C
        add.l   d3,d6                           ; 0024E
        move.l  d6,(dat_071_000C6).l            ; 00250
        move.l  (a7)+,d7                        ; 00256
        move.w  d0,-(a7)                        ; 00258
        btst    #$4,(dat_071_0022A).l           ; 0025A
        beq.b   l_009_002AC                     ; 00262
        btst    #$6,(dat_071_0022A).l           ; 00264
        beq.b   l_009_00280                     ; 0026C
        lea.l   (SmallObjects).l,a1             ; 0026E
        move.w  (CurrentObject).l,d0            ; 00274
        asl.w   #$5,d0                          ; 0027A
        adda.w  d0,a1                           ; 0027C
        bra.b   l_009_002A0                     ; 0027E
l_009_00280:
        lea.l   (ObjectTable).l,a1              ; 00280
        move.w  (CurrentObject).l,d0            ; 00286
        asl.w   #$8,d0                          ; 0028C
        add.w   d0,d0                           ; 0028E
        adda.w  d0,a1                           ; 00290
        tst.b   (dat_071_00236).l               ; 00292
        bne.b   l_009_002A0                     ; 00298
        bclr    #$2,$1(a1)                      ; 0029A
l_009_002A0:
        move.w  $c(a1),d0                       ; 002A0
        andi.w  #$fff,d0                        ; 002A4
        ext.l   d0                              ; 002A8
        add.l   d0,d7                           ; 002AA
l_009_002AC:
        move.w  (ViewOffsetX8).l,d0             ; 002AC
        ext.l   d0                              ; 002B2
        add.l   d0,d7                           ; 002B4
        bge.b   l_009_002BA                     ; 002B6
        neg.l   d7                              ; 002B8
l_009_002BA:
        asr.l   #$8,d7                          ; 002BA
        asr.l   #$4,d7                          ; 002BC
        btst    #$6,(dat_071_0022A).l           ; 002BE
        bne.b   l_009_002D2                     ; 002C6
        btst    #$4,(dat_071_0022A).l           ; 002C8
        beq.b   l_009_002DE                     ; 002D0
l_009_002D2:
        move.w  $e(a1),d0                       ; 002D2
        andi.w  #$fff,d0                        ; 002D6
        ext.l   d0                              ; 002DA
        add.l   d0,d6                           ; 002DC
l_009_002DE:
        move.w  (ViewOffsetZ8).l,d0             ; 002DE
        ext.l   d0                              ; 002E4
        add.l   d0,d6                           ; 002E6
        bge.b   l_009_002EC                     ; 002E8
        neg.l   d6                              ; 002EA
l_009_002EC:
        asr.l   #$8,d6                          ; 002EC
        asr.l   #$4,d6                          ; 002EE
        move.l  (ViewOffsetY8).l,d0             ; 002F0
        btst    #$6,(dat_071_0022A).l           ; 002F6
        bne.b   l_009_0030A                     ; 002FE
        btst    #$4,(dat_071_0022A).l           ; 00300
        beq.b   l_009_00316                     ; 00308
l_009_0030A:
        move.l  $10(a1),d0                      ; 0030A
        add.l   (ViewOffsetY8).l,d0             ; 0030E
        bge.b   l_009_00318                     ; 00314
l_009_00316:
        neg.l   d0                              ; 00316
l_009_00318:
        asr.l   #$8,d0                          ; 00318
        asr.l   #$3,d0                          ; 0031A
        cmp.w   d6,d7                           ; 0031C
        bge.b   l_009_0032A                     ; 0031E
        move.w  d6,d7                           ; 00320
        cmp.w   d0,d7                           ; 00322
        bge.b   l_009_00330                     ; 00324
        move.w  d0,d7                           ; 00326
        bra.b   l_009_00330                     ; 00328
l_009_0032A:
        cmp.w   d0,d7                           ; 0032A
        bge.b   l_009_00330                     ; 0032C
        move.w  d0,d7                           ; 0032E
l_009_00330:
        lsr.w   #$1,d7                          ; 00330
        cmpi.w  #$ef,d7                         ; 00332
        ble.b   l_009_0034A                     ; 00336
        move.w  #$f,(DebugCheckpoint).l         ; 00338
        jsr     (Nop).l                         ; 00340
        move.w  #$ef,d7                         ; 00346
l_009_0034A:
        lea.l   (DistanceScale).l,a1            ; 0034A
        move.b  (a1,d7.w),d6                    ; 00350
        or.b    d6,-$5(a2)                      ; 00354
        ext.w   d6                              ; 00358
        bra.w   l_009_0045A                     ; 0035A
; DistanceScale - The scale shift for each distance (0-$EF): how far an object's coordinates
; are shifted down before it is drawn.
DistanceScale:
	dc.b	$00,$01,$01,$02,$02,$02,$03,$03,$03,$03,$03,$03,$04,$04,$04,$04
	dc.b	$04,$04,$04,$04,$04,$05,$05,$05,$05,$05,$05,$05,$05,$05,$06,$06
	dc.b	$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$07,$07,$07,$07
	dc.b	$07,$07,$07,$07,$07,$07,$07,$08,$08,$08,$08,$08,$08,$08,$08,$08
	dc.b	$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$09,$09,$09,$09,$09,$09
	dc.b	$09,$09,$09,$09,$09,$09,$09,$09,$09,$09,$0A,$0A,$0A,$0A,$0A,$0A
	dc.b	$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0B,$0B
	dc.b	$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B
	dc.b	$0B,$0B,$0B,$0B,$0B,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C
	dc.b	$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0D,$0D,$0D
	dc.b	$0D,$0D,$0D,$0D,$0D,$0D,$0D,$0D,$0D,$0D,$0D,$0D,$0D,$0D,$0D,$0D
	dc.b	$0D,$0D,$0D,$0D,$0D,$0D,$0D,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E
	dc.b	$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E
	dc.b	$0E,$0E,$0E
	dcb.b	39,$0F
	dc.b	$42,$46
l_009_0045A:
        move.l  (dat_071_000BE).l,d0            ; 0045A
        asr.l   d6,d0                           ; 00460
        move.w  d0,(a2)+                        ; 00462
        move.w  (dat_071_000C2).l,d0            ; 00464
        asr.w   d6,d0                           ; 0046A
        move.w  d0,(a2)+                        ; 0046C
        move.l  (dat_071_000C6).l,d0            ; 0046E
        asr.l   d6,d0                           ; 00474
        move.w  d0,(a2)+                        ; 00476
        move.w  (a7)+,d0                        ; 00478
        addq.b  #$1,(dat_071_0022E).l           ; 0047A
        moveq   #$0,d7                          ; 00480
        btst    #$6,(dat_071_0022A).l           ; 00482
        bne.b   l_009_004A4                     ; 0048A
        btst    #$4,(dat_071_0022A).l           ; 0048C
        bne.b   l_009_004A4                     ; 00494
        move.b  d1,d7                           ; 00496
        lsl.w   #$4,d7                          ; 00498
        swap    d7                              ; 0049A
        or.l    (dat_071_0038C).l,d7            ; 0049C
        bra.b   l_009_004B0                     ; 004A2
l_009_004A4:
        or.b    (dat_071_00385).l,d7            ; 004A4
        ror.l   #$8,d7                          ; 004AA
        bset    #$1f,d7                         ; 004AC
l_009_004B0:
        move.l  d7,(a2)+                        ; 004B0
        clr.w   (a2)+                           ; 004B2
        move.b  -$2e(a6),d6                     ; 004B4
        move.b  d6,(a2)+                        ; 004B8
        subq.b  #$1,d6                          ; 004BA
        bge.b   l_009_004C2                     ; 004BC
        move.b  #$3,d6                          ; 004BE
l_009_004C2:
        move.b  d6,-$2e(a6)                     ; 004C2
        clr.b   (a2)+                           ; 004C6
        clr.l   (a2)+                           ; 004C8
        swap    d7                              ; 004CA
        move.w  d7,(dat_071_0038C).l            ; 004CC
        swap    d7                              ; 004D2
        addq.w  #$1,(dat_073_00210).l           ; 004D4
        tst.b   (dat_071_00236).l               ; 004DA
        bne.b   l_009_00524                     ; 004E0
        lea.l   (dat_009_00536).l,a1            ; 004E2
        move.l  (ViewOffsetY8).l,d6             ; 004E8
        neg.l   d6                              ; 004EE
        asr.l   #$8,d6                          ; 004F0
        asr.l   #$3,d6                          ; 004F2
        cmpi.l  #$3,d6                          ; 004F4
        ble.b   l_009_00502                     ; 004FA
        move.w  #$46,d6                         ; 004FC
        bra.b   l_009_00514                     ; 00500
l_009_00502:
        add.l   d6,d6                           ; 00502
        add.l   d6,d6                           ; 00504
        tst.b   (HeightBandChanged).l           ; 00506
        beq.b   l_009_00510                     ; 0050C
        addq.w  #$2,d6                          ; 0050E
l_009_00510:
        move.w  (a1,d6.l),d6                    ; 00510
l_009_00514:
        cmp.w   (dat_073_00210).l,d6            ; 00514
        bge.b   l_009_00524                     ; 0051A
        movea.l -$24(a6),a1                     ; 0051C
        addi.w  #$18,(a1)                       ; 00520
l_009_00524:
        cmpi.w  #$46,(dat_073_00210).l          ; 00524
        blt.b   l_009_00532                     ; 0052C
        suba.w  #$18,a2                         ; 0052E
l_009_00532:
        bra.w   l_009_0013A                     ; 00532
dat_009_00536:
	dc.b	$00,$1E,$00,$28,$00,$1E,$00,$32,$00,$20,$00,$3C,$00,$28,$00,$46
l_009_00546:
        tst.b   (SceneryDetailed).l             ; 00546
        beq.b   l_009_00576                     ; 0054C
        tst.b   (dat_071_00236).l               ; 0054E
        bne.b   l_009_00576                     ; 00554
        cmpi.b  #$1,d1                          ; 00556
        bgt.b   l_009_00564                     ; 0055A
        move.l  #$ffffffff,(a5)                 ; 0055C
        bra.b   l_009_00576                     ; 00562
l_009_00564:
        adda.w  #$4,a5                          ; 00564
        move.w  d1,(a5)+                        ; 00568
        move.l  #$ffffffff,(a5)                 ; 0056A
        addq.b  #$1,(dat_071_0022C).l           ; 00570
l_009_00576:
        subq.b  #$1,d0                          ; 00576
        bgt.w   l_009_000E8                     ; 00578
        adda.w  #$600,a4                        ; 0057C
        bra.w   l_009_0005C                     ; 00580
l_009_00584:
        move.w  #$ffff,(a2)                     ; 00584
        move.b  #$1,(dat_071_00175).l           ; 00588
        move.b  (dat_071_0022C).l,(dat_071_0022D).l ; 00590
        tst.b   (SceneryDetailed).l             ; 0059A
        beq.w   l_009_006F8                     ; 005A0
        bra.b   l_009_005B6                     ; 005A4
l_009_005A6:
        move.w  #$10,(DebugCheckpoint).l        ; 005A6
        jsr     (Nop).l                         ; 005AE
        bra.b   l_009_005A6                     ; 005B4
l_009_005B6:
        move.l  #SceneryList,d7                 ; 005B6
        cmp.l   a2,d7                           ; 005BC
        bgt.b   l_009_005A6                     ; 005BE
        beq.w   l_009_006F8                     ; 005C0
        suba.w  #$18,a2                         ; 005C4
        move.l  a2,(dat_071_00396).l            ; 005C8
        clr.b   d0                              ; 005CE
        clr.b   (dat_071_0022F).l               ; 005D0
l_009_005D6:
        move.w  (a2)+,d7                        ; 005D6
        movea.l (a2)+,a1                        ; 005D8
        movem.w (a2)+,d2-d4                     ; 005DA
        move.l  (a2)+,d6                        ; 005DE
        btst    #$6,d7                          ; 005E0
        bne.w   l_009_006DC                     ; 005E4
        btst    #$4,d7                          ; 005E8
        bne.w   l_009_006DC                     ; 005EC
        move.l  $4(a1),d1                       ; 005F0
        ble.w   l_009_006BE                     ; 005F4
        movea.l d1,a0                           ; 005F8
        move.w  (a0),d1                         ; 005FA
        blt.b   l_009_0060E                     ; 005FC
        andi.w  #$4000,d1                       ; 005FE
        beq.b   l_009_0060A                     ; 00602
        move.w  $2(a0),d1                       ; 00604
        bra.b   l_009_0060E                     ; 00608
l_009_0060A:
        move.w  $4(a0),d1                       ; 0060A
l_009_0060E:
        cmpi.w  #$ffff,d1                       ; 0060E
        beq.w   l_009_006BE                     ; 00612
        andi.w  #$fff,d1                        ; 00616
        move.w  (a0,d1.w),d1                    ; 0061A
        blt.w   l_009_006BE                     ; 0061E
        adda.w  d1,a0                           ; 00622
        andi.w  #$f,d7                          ; 00624
        asl.w   d7,d2                           ; 00628
        asl.w   d7,d3                           ; 0062A
        asl.w   d7,d4                           ; 0062C
        andi.w  #$3fff,d2                       ; 0062E
        andi.w  #$3fff,d4                       ; 00632
        ext.w   d0                              ; 00636
        move.w  d0,d1                           ; 00638
        lea.l   (dat_072_05400).l,a1            ; 0063A
        add.w   d1,d1                           ; 00640
        add.w   d1,d1                           ; 00642
        move.l  a0,(a1,d1.w)                    ; 00644
        lea.l   (dat_072_0542C).l,a1            ; 00648
        asl.w   #$6,d1                          ; 0064E
        adda.w  d1,a1                           ; 00650
        move.l  d6,(a1)+                        ; 00652
        move.w  (a0)+,(a1)+                     ; 00654
        move.w  (a0)+,d6                        ; 00656
        add.w   d2,d6                           ; 00658
        move.w  d6,(a1)+                        ; 0065A
        move.w  (a0)+,d6                        ; 0065C
        add.w   d2,d6                           ; 0065E
        move.w  d6,(a1)+                        ; 00660
        move.w  (a0)+,d6                        ; 00662
        add.w   d4,d6                           ; 00664
        move.w  d6,(a1)+                        ; 00666
        move.w  (a0)+,d6                        ; 00668
        add.w   d4,d6                           ; 0066A
        move.w  d6,(a1)+                        ; 0066C
l_009_0066E:
        move.w  (a0)+,(a1)+                     ; 0066E
        move.w  (a0)+,d6                        ; 00670
        add.w   d2,d6                           ; 00672
        move.w  d6,(a1)+                        ; 00674
        move.w  (a0)+,d6                        ; 00676
        add.w   d2,d6                           ; 00678
        move.w  d6,(a1)+                        ; 0067A
        move.w  (a0)+,d6                        ; 0067C
        add.w   d4,d6                           ; 0067E
        move.w  d6,(a1)+                        ; 00680
        move.w  (a0)+,d6                        ; 00682
        add.w   d4,d6                           ; 00684
        move.w  d6,(a1)+                        ; 00686
        move.l  (a0)+,d1                        ; 00688
        bgt.b   l_009_00690                     ; 0068A
        move.l  d1,(a1)+                        ; 0068C
        bra.b   l_009_00694                     ; 0068E
l_009_00690:
        move.l  a1,-(a7)                        ; 00690
        addq.w  #$4,a1                          ; 00692
l_009_00694:
        move.w  (a0)+,d7                        ; 00694
        subq.w  #$1,d7                          ; 00696
l_009_00698:
        move.w  (a0)+,d6                        ; 00698
        add.w   d2,d6                           ; 0069A
        move.w  d6,(a1)+                        ; 0069C
        move.w  (a0)+,d6                        ; 0069E
        move.w  d6,(a1)+                        ; 006A0
        move.w  (a0)+,d6                        ; 006A2
        add.w   d4,d6                           ; 006A4
        move.w  d6,(a1)+                        ; 006A6
        addq.w  #$6,a0                          ; 006A8
        dbra    d7,l_009_00698                  ; 006AA
        tst.l   d1                              ; 006AE
        ble.b   l_009_006D4                     ; 006B0
        move.l  (a7)+,d7                        ; 006B2
        exg.l   d7,a1                           ; 006B4
        move.l  d7,(a1)                         ; 006B6
        exg.l   d7,a1                           ; 006B8
        movea.l d1,a0                           ; 006BA
        bra.b   l_009_0066E                     ; 006BC
l_009_006BE:
        ext.w   d0                              ; 006BE
        move.w  d0,d1                           ; 006C0
        lea.l   (dat_072_05400).l,a1            ; 006C2
        add.w   d1,d1                           ; 006C8
        add.w   d1,d1                           ; 006CA
        move.l  #$ffffffff,(a1,d1.w)            ; 006CC
l_009_006D4:
        addq.b  #$1,d0                          ; 006D4
        cmpi.b  #$b,d0                          ; 006D6
        bge.b   l_009_006F8                     ; 006DA
l_009_006DC:
        addq.b  #$1,(dat_071_0022F).l           ; 006DC
        move.b  (dat_071_0022F).l,d7            ; 006E2
        cmp.b   (dat_071_0022E).l,d7            ; 006E8
        bge.b   l_009_006F8                     ; 006EE
        suba.w  #$28,a2                         ; 006F0
        bra.w   l_009_005D6                     ; 006F4
l_009_006F8:
        tst.b   (SceneryDetailed).l             ; 006F8
        beq.b   l_009_0073C                     ; 006FE
        tst.b   (dat_071_00236).l               ; 00700
        bne.b   l_009_0073C                     ; 00706
        lea.l   (VisibleObjects).l,a0           ; 00708
        move.w  #$ffff,(a0)                     ; 0070E
        lea.l   (ObjectTable).l,a2              ; 00712
        clr.w   d0                              ; 00718
l_009_0071A:
        btst    #$6,$1(a2)                      ; 0071A
        beq.b   l_009_00730                     ; 00720
        btst    #$2,$1(a2)                      ; 00722
        beq.b   l_009_00730                     ; 00728
        move.w  d0,(a0)+                        ; 0072A
        move.w  #$ffff,(a0)                     ; 0072C
l_009_00730:
        addq.w  #$1,d0                          ; 00730
        adda.w  #$200,a2                        ; 00732
        cmpi.w  #$10,d0                         ; 00736
        blt.b   l_009_0071A                     ; 0073A
l_009_0073C:
        unlk    a6                              ; 0073C
        rts                                     ; 0073E
sub_009_00740:
        movem.l d0-d7/a0-a5,-(a7)               ; 00740
        tst.b   (dat_071_00175).l               ; 00744
        beq.w   l_009_008B8                     ; 0074A
l_009_0074E:
        lea.l   (dat_071_0039E).l,a0            ; 0074E
        move.b  (dat_071_0022D).l,d0            ; 00754
        subq.b  #$1,d0                          ; 0075A
        blt.w   l_009_0089C                     ; 0075C
        ext.w   d0                              ; 00760
        move.w  d0,d1                           ; 00762
        add.w   d0,d0                           ; 00764
        add.w   d0,d0                           ; 00766
        add.w   d1,d1                           ; 00768
        add.w   d1,d0                           ; 0076A
        adda.w  d0,a0                           ; 0076C
        tst.w   (a0)                            ; 0076E
        blt.w   l_009_008B8                     ; 00770
        lea.l   (dat_073_00000).l,a3            ; 00774
        movea.l (a0)+,a1                        ; 0077A
        lea.l   (a1),a2                         ; 0077C
        move.w  (a0)+,d0                        ; 0077E
        ble.b   l_009_007C4                     ; 00780
        move.w  d0,d7                           ; 00782
        cmpi.w  #$16,d7                         ; 00784
        ble.b   l_009_0078E                     ; 00788
        move.w  #$16,d7                         ; 0078A
l_009_0078E:
        move.w  d7,d0                           ; 0078E
        subq.w  #$1,d0                          ; 00790
l_009_00792:
        move.w  (a1)+,d1                        ; 00792
        move.w  d1,d2                           ; 00794
        andi.w  #$f,d2                          ; 00796
        move.w  d2,(DistanceShift).l            ; 0079A
        btst    #$6,d1                          ; 007A0
        beq.b   l_009_007B2                     ; 007A4
        move.w  #$7fff,d1                       ; 007A6
        adda.w  #$a,a1                          ; 007AA
        bra.w   l_009_0084E                     ; 007AE
l_009_007B2:
        move.w  $e(a1),d3                       ; 007B2
        beq.b   l_009_007D4                     ; 007B6
        asl.w   d2,d3                           ; 007B8
        adda.w  #$a,a1                          ; 007BA
        move.w  d3,d1                           ; 007BE
        bra.w   l_009_0084E                     ; 007C0
l_009_007C4:
        move.w  #$37,(DebugCheckpoint).l        ; 007C4
        jsr     (Nop).l                         ; 007CC
        bra.b   l_009_007C4                     ; 007D2
l_009_007D4:
        addq.w  #$4,a1                          ; 007D4
        movem.w (a1)+,d2-d4                     ; 007D6
        clr.b   (dat_071_0028B).l               ; 007DA
        btst    #$4,d1                          ; 007E0
        beq.b   l_009_00840                     ; 007E4
        lea.l   (ObjectTable).l,a0              ; 007E6
        move.w  d1,d6                           ; 007EC
        andi.w  #$ff00,d1                       ; 007EE
        add.w   d1,d1                           ; 007F2
        bra.b   l_009_00804                     ; 007F4
sub_009_007F6:
        lea.l   (SmallObjects).l,a0             ; 007F6
        move.w  d1,d6                           ; 007FC
        andi.w  #$ff00,d1                       ; 007FE
        asr.w   #$3,d1                          ; 00802
l_009_00804:
        adda.w  d1,a0                           ; 00804
        andi.w  #$f,d6                          ; 00806
        move.w  $c(a0),d3                       ; 0080A
        andi.w  #$fff,d3                        ; 0080E
        asr.w   d6,d3                           ; 00812
        add.w   d3,d2                           ; 00814
        move.w  $e(a0),d3                       ; 00816
        andi.w  #$fff,d3                        ; 0081A
        asr.w   d6,d3                           ; 0081E
        add.w   d3,d4                           ; 00820
        move.l  $10(a0),d3                      ; 00822
        move.l  d3,d1                           ; 00826
        asr.l   d6,d3                           ; 00828
        add.l   (ViewOffsetY8).l,d1             ; 0082A
        asr.l   d6,d1                           ; 00830
        move.l  d1,(ObjectViewY).l              ; 00832
        move.b  #$1,(dat_071_0028B).l           ; 00838
l_009_00840:
        jsr     (ScaledViewOffset).l            ; 00840
        move.w  (DistanceShift).l,d2            ; 00846
        asl.w   d2,d1                           ; 0084C
l_009_0084E:
        move.w  d1,(a3)+                        ; 0084E
        adda.w  #$c,a1                          ; 00850
        dbra    d0,l_009_00792                  ; 00854
        bsr.w   sub_009_008BE                   ; 00858
        lea.l   (a2),a1                         ; 0085C
        lea.l   (VertexBuffer).l,a5             ; 0085E
        lea.l   (a5),a4                         ; 00864
        subq.w  #$1,d7                          ; 00866
        move.w  d7,d6                           ; 00868
l_009_0086A:
        movem.l (a2)+,d0-d5                     ; 0086A
        movem.l d0-d5,(a5)                      ; 0086E
        adda.w  #$18,a5                         ; 00872
        dbra    d6,l_009_0086A                  ; 00876
        lea.l   (dat_073_000B0).l,a3            ; 0087A
l_009_00880:
        move.w  (a3)+,d4                        ; 00880
        asl.w   #$3,d4                          ; 00882
        move.w  d4,d5                           ; 00884
        add.w   d4,d4                           ; 00886
        add.w   d5,d4                           ; 00888
        movem.l (a4,d4.w),d0-d5                 ; 0088A
        movem.l d0-d5,(a1)                      ; 00890
        adda.w  #$18,a1                         ; 00894
        dbra    d7,l_009_00880                  ; 00898
l_009_0089C:
        subq.b  #$1,(dat_071_0022D).l           ; 0089C
        blt.b   l_009_008AE                     ; 008A2
        tst.b   -$2c(a6)                        ; 008A4
        beq.b   l_009_008B8                     ; 008A8
        bra.w   l_009_0074E                     ; 008AA
l_009_008AE:
        move.b  (dat_071_0022C).l,(dat_071_0022D).l ; 008AE
l_009_008B8:
        movem.l (a7)+,d0-d7/a0-a5               ; 008B8
        rts                                     ; 008BC
sub_009_008BE:
        movem.l d0-d6/a0-a5,-(a7)               ; 008BE
        lea.l   (dat_073_0002C).l,a5            ; 008C2
        movem.l (dat_073_00000).l,d0-d6/a1-a4   ; 008C8
        movem.l d0-d6/a1-a4,(a5)                ; 008D0
        lea.l   $84(a5),a4                      ; 008D4
        move.w  d7,d1                           ; 008D8
        subq.w  #$1,d1                          ; 008DA
l_009_008DC:
        lea.l   (a5),a0                         ; 008DC
        move.w  d1,d6                           ; 008DE
l_009_008E0:
        move.w  (a0)+,d0                        ; 008E0
        bge.b   l_009_008EA                     ; 008E2
        dbra    d6,l_009_008E0                  ; 008E4
        bra.b   l_009_00916                     ; 008E8
l_009_008EA:
        lea.l   -$2(a0),a1                      ; 008EA
        subq.w  #$1,d6                          ; 008EE
        bge.b   l_009_008F8                     ; 008F0
        move.w  $2c(a1),(a4)                    ; 008F2
        bra.b   l_009_00916                     ; 008F6
l_009_008F8:
        cmp.w   (a0)+,d0                        ; 008F8
        blt.b   l_009_00902                     ; 008FA
        dbra    d6,l_009_008F8                  ; 008FC
        bra.b   l_009_0090C                     ; 00900
l_009_00902:
        lea.l   -$2(a0),a1                      ; 00902
        move.w  (a1),d0                         ; 00906
        dbra    d6,l_009_008F8                  ; 00908
l_009_0090C:
        move.w  #$ffff,(a1)                     ; 0090C
        move.w  $2c(a1),(a4)+                   ; 00910
        bra.b   l_009_008DC                     ; 00914
l_009_00916:
        movem.l (a7)+,d0-d6/a0-a5               ; 00916
        rts                                     ; 0091A
sub_009_0091C:
        cmpi.b  #$2,d5                          ; 0091C
        beq.w   l_009_00938                     ; 00920
        cmpi.b  #$3,d5                          ; 00924
        beq.w   l_009_00932                     ; 00928
        cmp.w   d2,d3                           ; 0092C
        blt.w   l_009_00944                     ; 0092E
l_009_00932:
        cmp.w   d1,d2                           ; 00932
        blt.w   l_009_00944                     ; 00934
l_009_00938:
        cmp.w   d0,d1                           ; 00938
        blt.w   l_009_00944                     ; 0093A
        movem.w (a7)+,d0-d4                     ; 0093E
        rts                                     ; 00942
l_009_00944:
        move.w  #$14,(DebugCheckpoint).l        ; 00944
        jsr     (Nop).l                         ; 0094C
        bra.b   l_009_00944                     ; 00952
l_009_00954:
        unlk    a6                              ; 00954
        rts                                     ; 00956
sub_009_00958:
        link.w  a6,#$ffde                       ; 00958
        lea.l   (SceneryList).l,a1              ; 0095C
        moveq   #-1,d5                          ; 00962
l_009_00964:
        tst.w   (a1)                            ; 00964
        blt.b   l_009_00970                     ; 00966
        addq.w  #$1,d5                          ; 00968
        adda.w  #$18,a1                         ; 0096A
        bra.b   l_009_00964                     ; 0096E
l_009_00970:
        cmpi.w  #$1,d5                          ; 00970
        blt.b   l_009_00954                     ; 00974
        suba.w  #$18,a1                         ; 00976
l_009_0097A:
        move.w  (a1),d1                         ; 0097A
        movea.l $2(a1),a2                       ; 0097C
        move.l  $4(a2),d7                       ; 00980
        ble.b   l_009_009B0                     ; 00984
        movea.l d7,a0                           ; 00986
        move.w  (a0),d7                         ; 00988
        blt.b   l_009_0099C                     ; 0098A
        andi.w  #$4000,d7                       ; 0098C
        beq.b   l_009_00998                     ; 00990
        move.w  $2(a0),d7                       ; 00992
        bra.b   l_009_0099C                     ; 00996
l_009_00998:
        move.w  $4(a0),d7                       ; 00998
l_009_0099C:
        cmpi.w  #$ffff,d7                       ; 0099C
        beq.b   l_009_009B0                     ; 009A0
        andi.w  #$fff,d7                        ; 009A2
        move.b  $7(a0,d7.w),d7                  ; 009A6
        andi.b  #$10,d7                         ; 009AA
        bne.b   l_009_009BA                     ; 009AE
l_009_009B0:
        subq.w  #$1,d5                          ; 009B0
        blt.b   l_009_00954                     ; 009B2
        suba.w  #$18,a1                         ; 009B4
        bra.b   l_009_0097A                     ; 009B8
l_009_009BA:
        move.w  d5,(dat_073_015E2).l            ; 009BA
        lea.l   (a1),a0                         ; 009C0
        bsr.w   sub_009_01052                   ; 009C2
        move.w  (ViewOffsetX8).l,d2             ; 009C6
        move.w  (ViewOffsetZ8).l,d4             ; 009CC
        neg.w   d2                              ; 009D2
        neg.w   d4                              ; 009D4
        ext.l   d2                              ; 009D6
        ext.l   d4                              ; 009D8
        bsr.w   sub_009_01114                   ; 009DA
        move.l  d2,-$c(a6)                      ; 009DE
        move.l  d4,-$10(a6)                     ; 009E2
        move.w  (a1),d1                         ; 009E6
        btst    #$4,d1                          ; 009E8
        beq.b   l_009_009F4                     ; 009EC
        bsr.w   ObjectPosition                  ; 009EE
        bra.b   l_009_009F8                     ; 009F2
l_009_009F4:
        bsr.w   sub_009_00FF8                   ; 009F4
l_009_009F8:
        movea.l d2,a3                           ; 009F8
        movea.l d3,a4                           ; 009FA
        movea.l d4,a5                           ; 009FC
        move.l  #$c00,d7                        ; 009FE
l_009_00A04:
        subq.w  #$1,d5                          ; 00A04
        blt.b   l_009_00A58                     ; 00A06
        suba.w  #$18,a1                         ; 00A08
        move.w  (a1),d1                         ; 00A0C
        btst    #$6,d1                          ; 00A0E
        beq.b   l_009_00A1E                     ; 00A12
        bsr.w   SmallObjectPosition             ; 00A14
        bsr.w   SmallObjectOf                   ; 00A18
        bra.b   l_009_00A36                     ; 00A1C
l_009_00A1E:
        btst    #$4,d1                          ; 00A1E
        beq.b   l_009_00A2E                     ; 00A22
        bsr.w   ObjectPosition                  ; 00A24
        bsr.w   ObjectOf                        ; 00A28
        bra.b   l_009_00A36                     ; 00A2C
l_009_00A2E:
        bsr.w   sub_009_00FF8                   ; 00A2E
        bsr.w   sub_009_010EC                   ; 00A32
l_009_00A36:
        sub.l   a3,d2                           ; 00A36
        bge.b   l_009_00A3C                     ; 00A38
        neg.l   d2                              ; 00A3A
l_009_00A3C:
        cmp.l   d7,d2                           ; 00A3C
        bgt.b   l_009_00A54                     ; 00A3E
        sub.l   a4,d3                           ; 00A40
        bge.b   l_009_00A46                     ; 00A42
        neg.l   d3                              ; 00A44
l_009_00A46:
        cmp.l   d7,d3                           ; 00A46
        bgt.b   l_009_00A54                     ; 00A48
        sub.l   a5,d4                           ; 00A4A
        bge.b   l_009_00A50                     ; 00A4C
        neg.l   d4                              ; 00A4E
l_009_00A50:
        cmp.l   d7,d4                           ; 00A50
        ble.b   l_009_00A04                     ; 00A52
l_009_00A54:
        adda.w  #$18,a1                         ; 00A54
l_009_00A58:
        addq.w  #$1,d5                          ; 00A58
        move.w  d5,(dat_073_015E4).l            ; 00A5A
        move.w  #$ffff,(dat_073_015E6).l        ; 00A60
        bra.b   l_009_00A6E                     ; 00A68
l_009_00A6A:
        adda.w  #$18,a1                         ; 00A6A
l_009_00A6E:
        tst.w   (a1)                            ; 00A6E
        blt.w   l_009_00F04                     ; 00A70
        move.l  a1,d1                           ; 00A74
        cmp.l   a0,d1                           ; 00A76
        beq.w   l_009_00EF6                     ; 00A78
        blt.b   l_009_00AEE                     ; 00A7C
        move.w  (a0),d1                         ; 00A7E
        btst    #$4,d1                          ; 00A80
        beq.b   l_009_00A8C                     ; 00A84
        bsr.w   ObjectPosition                  ; 00A86
        bra.b   l_009_00A94                     ; 00A8A
l_009_00A8C:
        exg.l   a0,a1                           ; 00A8C
        bsr.w   sub_009_00FF8                   ; 00A8E
        exg.l   a0,a1                           ; 00A92
l_009_00A94:
        move.l  d2,d5                           ; 00A94
        move.l  d3,d6                           ; 00A96
        move.l  d4,d7                           ; 00A98
        move.w  (a1),d1                         ; 00A9A
        btst    #$6,d1                          ; 00A9C
        beq.b   l_009_00AAC                     ; 00AA0
        bsr.w   SmallObjectPosition             ; 00AA2
        bsr.w   SmallObjectOf                   ; 00AA6
        bra.b   l_009_00AC4                     ; 00AAA
l_009_00AAC:
        btst    #$4,d1                          ; 00AAC
        beq.b   l_009_00ABC                     ; 00AB0
        bsr.w   ObjectPosition                  ; 00AB2
        bsr.w   ObjectOf                        ; 00AB6
        bra.b   l_009_00AC4                     ; 00ABA
l_009_00ABC:
        bsr.w   sub_009_00FF8                   ; 00ABC
        bsr.w   sub_009_010EC                   ; 00AC0
l_009_00AC4:
        move.l  #$a00,d0                        ; 00AC4
        sub.l   d5,d2                           ; 00ACA
        bge.b   l_009_00AD0                     ; 00ACC
        neg.l   d2                              ; 00ACE
l_009_00AD0:
        cmp.l   d0,d2                           ; 00AD0
        bgt.w   l_009_00F04                     ; 00AD2
        sub.l   d6,d3                           ; 00AD6
        bge.b   l_009_00ADC                     ; 00AD8
        neg.l   d3                              ; 00ADA
l_009_00ADC:
        cmp.l   d0,d3                           ; 00ADC
        bgt.w   l_009_00F04                     ; 00ADE
        sub.l   d7,d4                           ; 00AE2
        bge.b   l_009_00AE8                     ; 00AE4
        neg.l   d4                              ; 00AE6
l_009_00AE8:
        cmp.l   d0,d4                           ; 00AE8
        bgt.w   l_009_00F04                     ; 00AEA
l_009_00AEE:
        move.w  (a1),d1                         ; 00AEE
        btst    #$6,d1                          ; 00AF0
        bne.b   l_009_00B16                     ; 00AF4
        btst    #$4,d1                          ; 00AF6
        bne.w   l_009_00B7E                     ; 00AFA
        bsr.w   sub_009_00FF8                   ; 00AFE
        bsr.w   sub_009_010EC                   ; 00B02
        move.w  d2,-$2(a6)                      ; 00B06
        move.l  d3,-$6(a6)                      ; 00B0A
        move.w  d4,-$8(a6)                      ; 00B0E
        bra.w   l_009_00BFE                     ; 00B12
l_009_00B16:
        lea.l   (SmallObjects).l,a3             ; 00B16
        andi.w  #$ff00,d1                       ; 00B1C
        asr.w   #$3,d1                          ; 00B20
        move.w  $c(a3,d1.w),d2                  ; 00B22
        move.w  $e(a3,d1.w),d4                  ; 00B26
        move.l  $10(a3,d1.w),-$6(a6)            ; 00B2A
        move.w  d1,-(a7)                        ; 00B30
        bsr.w   SmallObjectOf                   ; 00B32
        move.w  (a7)+,d1                        ; 00B36
        move.w  d2,-$2(a6)                      ; 00B38
        move.w  d4,-$8(a6)                      ; 00B3C
        movea.l $2(a0),a4                       ; 00B40
        movea.l $10(a4),a4                      ; 00B44
        move.l  $2(a4),d0                       ; 00B48
        move.l  d0,-$16(a6)                     ; 00B4C
        blt.b   l_009_00B56                     ; 00B50
        bra.w   l_009_00BFE                     ; 00B52
l_009_00B56:
        bclr    #$1f,d0                         ; 00B56
        move.w  (a0),d1                         ; 00B5A
        andi.w  #$ff00,d1                       ; 00B5C
        lsr.w   #$3,d1                          ; 00B60
        lea.l   (ObjectTable).l,a2              ; 00B62
        add.l   $10(a2,d1.w),d0                 ; 00B68
        move.l  (ViewOffsetY8).l,d1             ; 00B6C
        neg.l   d1                              ; 00B72
        cmp.l   d0,d1                           ; 00B74
        bgt.w   l_009_00EF0                     ; 00B76
        bra.w   l_009_00EE8                     ; 00B7A
l_009_00B7E:
        lea.l   (ObjectTable).l,a3              ; 00B7E
        andi.w  #$ff00,d1                       ; 00B84
        add.w   d1,d1                           ; 00B88
        move.w  $c(a3,d1.w),d2                  ; 00B8A
        move.w  $e(a3,d1.w),d4                  ; 00B8E
        move.l  $10(a3,d1.w),-$6(a6)            ; 00B92
        move.w  d1,-(a7)                        ; 00B98
        bsr.w   ObjectOf                        ; 00B9A
        move.w  (a7)+,d1                        ; 00B9E
        move.w  d2,-$2(a6)                      ; 00BA0
        move.w  d4,-$8(a6)                      ; 00BA4
        move.b  $4(a3,d1.w),d0                  ; 00BA8
        andi.b  #$c0,d0                         ; 00BAC
        beq.b   l_009_00BFE                     ; 00BB0
        movea.l $2(a0),a4                       ; 00BB2
        movea.l $10(a4),a4                      ; 00BB6
        move.l  $2(a4),d0                       ; 00BBA
        move.l  d0,-$16(a6)                     ; 00BBE
        blt.b   l_009_00BD6                     ; 00BC2
        move.w  #$22,(DebugCheckpoint).l        ; 00BC4
        jsr     (Nop).l                         ; 00BCC
        bra.w   l_009_00EF0                     ; 00BD2
l_009_00BD6:
        bclr    #$1f,d0                         ; 00BD6
        move.w  (a0),d1                         ; 00BDA
        andi.w  #$ff00,d1                       ; 00BDC
        add.w   d1,d1                           ; 00BE0
        lea.l   (ObjectTable).l,a2              ; 00BE2
        add.l   $10(a2,d1.w),d0                 ; 00BE8
        move.l  (ViewOffsetY8).l,d1             ; 00BEC
        neg.l   d1                              ; 00BF2
        cmp.l   d0,d1                           ; 00BF4
        bgt.w   l_009_00EF0                     ; 00BF6
        bra.w   l_009_00EE8                     ; 00BFA
l_009_00BFE:
        movea.l $2(a0),a4                       ; 00BFE
        movea.l $10(a4),a4                      ; 00C02
        move.w  (a4)+,d0                        ; 00C06
        blt.w   l_009_00C8A                     ; 00C08
        exg.l   a0,a1                           ; 00C0C
        bsr.w   sub_009_00FF8                   ; 00C0E
        exg.l   a0,a1                           ; 00C12
        movea.w d2,a3                           ; 00C14
        movea.w d4,a5                           ; 00C16
        addq.w  #$4,a4                          ; 00C18
        movea.l (a4),a2                         ; 00C1A
l_009_00C1C:
        movem.w (a2),d2-d4                      ; 00C1C
        movem.w $6(a2),d5-d7                    ; 00C20
        add.w   a3,d2                           ; 00C26
        add.w   a5,d4                           ; 00C28
        sub.w   -$2(a6),d2                      ; 00C2A
        sub.w   -$8(a6),d4                      ; 00C2E
        neg.w   d2                              ; 00C32
        move.l  -$6(a6),d3                      ; 00C34
        neg.w   d4                              ; 00C38
        muls.w  d5,d2                           ; 00C3A
        muls.w  d6,d3                           ; 00C3C
        muls.w  d7,d4                           ; 00C3E
        add.l   d3,d4                           ; 00C40
        add.l   d2,d4                           ; 00C42
        move.l  d4,d1                           ; 00C44
        movem.w (a2)+,d2-d4                     ; 00C46
        addq.w  #$6,a2                          ; 00C4A
        add.w   a3,d2                           ; 00C4C
        add.w   a5,d4                           ; 00C4E
        ext.l   d2                              ; 00C50
        ext.l   d4                              ; 00C52
        sub.l   -$c(a6),d2                      ; 00C54
        move.l  (ViewOffsetY8).l,d3             ; 00C58
        sub.l   -$10(a6),d4                     ; 00C5E
        neg.l   d2                              ; 00C62
        neg.l   d3                              ; 00C64
        neg.l   d4                              ; 00C66
        muls.w  d5,d2                           ; 00C68
        muls.w  d6,d3                           ; 00C6A
        muls.w  d7,d4                           ; 00C6C
        add.l   d3,d4                           ; 00C6E
        add.l   d2,d4                           ; 00C70
        bge.b   l_009_00C7C                     ; 00C72
        dbra    d0,l_009_00C1C                  ; 00C74
        bra.w   l_009_00EE8                     ; 00C78
l_009_00C7C:
        tst.l   d1                              ; 00C7C
        bge.w   l_009_00EF0                     ; 00C7E
        dbra    d0,l_009_00C1C                  ; 00C82
        bra.w   l_009_00EE8                     ; 00C86
l_009_00C8A:
        andi.w  #$3fff,d0                       ; 00C8A
        move.w  d0,-$12(a6)                     ; 00C8E
        move.l  (a4)+,-$16(a6)                  ; 00C92
        move.l  a4,-(a7)                        ; 00C96
        move.w  (a0),d1                         ; 00C98
        andi.w  #$ff00,d1                       ; 00C9A
        add.w   d1,d1                           ; 00C9E
        lea.l   (ObjectTable).l,a2              ; 00CA0
        adda.w  d1,a2                           ; 00CA6
        movea.l (a4)+,a4                        ; 00CA8
        move.w  (a4),d0                         ; 00CAA
        addi.w  #$a4,d0                         ; 00CAC
        move.l  (ViewOffsetY8).l,d1             ; 00CB0
        neg.l   d1                              ; 00CB6
        move.b  $7d(a2),d3                      ; 00CB8
        andi.w  #$f,d3                          ; 00CBC
        move.w  d3,-$20(a6)                     ; 00CC0
        move.w  $2(a2,d0.w),d0                  ; 00CC4
        asr.w   d3,d0                           ; 00CC8
        cmp.w   d0,d1                           ; 00CCA
        blt.w   l_009_00D74                     ; 00CCC
l_009_00CD0:
        clr.w   -$18(a6)                        ; 00CD0
        move.w  (a4),-$1a(a6)                   ; 00CD4
        blt.w   l_009_00D74                     ; 00CD8
l_009_00CDC:
        move.w  (a4)+,d0                        ; 00CDC
        bge.b   l_009_00CEE                     ; 00CDE
        andi.w  #$fff,d0                        ; 00CE0
        move.w  -$1a(a6),d1                     ; 00CE4
        addq.w  #$1,-$18(a6)                    ; 00CE8
        bra.b   l_009_00CF4                     ; 00CEC
l_009_00CEE:
        move.w  (a4),d1                         ; 00CEE
        andi.w  #$fff,d1                        ; 00CF0
l_009_00CF4:
        addi.w  #$a4,d0                         ; 00CF4
        addi.w  #$a4,d1                         ; 00CF8
        move.w  #$ff00,d3                       ; 00CFC
        lea.l   (a2,d0.w),a5                    ; 00D00
        movem.w (a2,d1.w),d5-d7                 ; 00D04
        sub.w   (a5),d5                         ; 00D0A
        sub.w   $4(a5),d7                       ; 00D0C
        muls.w  d3,d7                           ; 00D10
        asr.l   #$6,d7                          ; 00D12
        muls.w  d3,d5                           ; 00D14
        neg.l   d5                              ; 00D16
        asr.l   #$6,d5                          ; 00D18
        exg.l   d5,d7                           ; 00D1A
        movem.w (a5),d2-d4                      ; 00D1C
        move.w  -$20(a6),d0                     ; 00D20
        asr.w   d0,d2                           ; 00D24
        asr.l   d0,d3                           ; 00D26
        asr.w   d0,d4                           ; 00D28
        add.w   $c(a2),d2                       ; 00D2A
        add.l   $10(a2),d3                      ; 00D2E
        add.w   $e(a2),d4                       ; 00D32
        add.w   (ViewOffsetX8).l,d2             ; 00D36
        add.l   (ViewOffsetY8).l,d3             ; 00D3C
        add.w   (ViewOffsetZ8).l,d4             ; 00D42
        neg.w   d2                              ; 00D48
        neg.w   d3                              ; 00D4A
        neg.w   d4                              ; 00D4C
        muls.w  d2,d5                           ; 00D4E
        muls.w  d4,d7                           ; 00D50
        add.l   d5,d7                           ; 00D52
        blt.b   l_009_00D66                     ; 00D54
        tst.w   -$18(a6)                        ; 00D56
        bne.w   l_009_00CD0                     ; 00D5A
l_009_00D5E:
        move.w  (a4)+,d0                        ; 00D5E
        bge.b   l_009_00D5E                     ; 00D60
        bra.w   l_009_00CD0                     ; 00D62
l_009_00D66:
        tst.w   -$18(a6)                        ; 00D66
        beq.w   l_009_00CDC                     ; 00D6A
        movea.l (a7)+,a4                        ; 00D6E
        bra.w   l_009_00EE8                     ; 00D70
l_009_00D74:
        movea.l (a7)+,a4                        ; 00D74
        addq.w  #$4,a4                          ; 00D76
l_009_00D78:
        movea.l (a4)+,a2                        ; 00D78
        movem.w $2(a2),d2-d4                    ; 00D7A
        andi.w  #$fff,d4                        ; 00D80
        addi.w  #$a4,d2                         ; 00D84
        addi.w  #$a4,d3                         ; 00D88
        addi.w  #$a4,d4                         ; 00D8C
        move.w  (a0),d1                         ; 00D90
        andi.w  #$ff00,d1                       ; 00D92
        add.w   d1,d1                           ; 00D96
        lea.l   (ObjectTable).l,a2              ; 00D98
        adda.w  d1,a2                           ; 00D9E
        lea.l   (a2,d2.w),a5                    ; 00DA0
        move.w  d4,d1                           ; 00DA4
        movem.w (a2,d3.w),d2-d4                 ; 00DA6
        sub.w   (a5),d2                         ; 00DAC
        sub.w   $2(a5),d3                       ; 00DAE
        sub.w   $4(a5),d4                       ; 00DB2
        movem.w (a2,d1.w),d5-d7                 ; 00DB6
        sub.w   (a5),d5                         ; 00DBC
        sub.w   $2(a5),d6                       ; 00DBE
        sub.w   $4(a5),d7                       ; 00DC2
        move.w  d4,d0                           ; 00DC6
        move.w  d7,d1                           ; 00DC8
        muls.w  d3,d7                           ; 00DCA
        muls.w  d6,d4                           ; 00DCC
        sub.l   d4,d7                           ; 00DCE
        asr.l   #$6,d7                          ; 00DD0
        muls.w  d5,d0                           ; 00DD2
        muls.w  d2,d1                           ; 00DD4
        sub.l   d1,d0                           ; 00DD6
        asr.l   #$6,d0                          ; 00DD8
        muls.w  d2,d6                           ; 00DDA
        muls.w  d3,d5                           ; 00DDC
        sub.l   d5,d6                           ; 00DDE
        asr.l   #$6,d6                          ; 00DE0
        move.w  d7,d5                           ; 00DE2
        move.w  d6,d7                           ; 00DE4
        move.w  d0,d6                           ; 00DE6
        movem.w (a5),d2-d4                      ; 00DE8
        move.w  -$20(a6),d0                     ; 00DEC
        asr.w   d0,d2                           ; 00DF0
        asr.l   d0,d3                           ; 00DF2
        asr.w   d0,d4                           ; 00DF4
        add.w   $c(a2),d2                       ; 00DF6
        add.l   $10(a2),d3                      ; 00DFA
        add.w   $e(a2),d4                       ; 00DFE
        sub.w   -$2(a6),d2                      ; 00E02
        sub.l   -$6(a6),d3                      ; 00E06
        sub.w   -$8(a6),d4                      ; 00E0A
        neg.w   d2                              ; 00E0E
        neg.l   d3                              ; 00E10
        neg.w   d4                              ; 00E12
        muls.w  d5,d2                           ; 00E14
        muls.w  d6,d3                           ; 00E16
        muls.w  d7,d4                           ; 00E18
        add.l   d3,d4                           ; 00E1A
        add.l   d2,d4                           ; 00E1C
        move.l  d4,d1                           ; 00E1E
        movem.w (a5),d2-d4                      ; 00E20
        asr.w   d0,d2                           ; 00E24
        asr.l   d0,d3                           ; 00E26
        asr.w   d0,d4                           ; 00E28
        add.w   $c(a2),d2                       ; 00E2A
        add.l   $10(a2),d3                      ; 00E2E
        add.w   $e(a2),d4                       ; 00E32
        ext.l   d2                              ; 00E36
        ext.l   d4                              ; 00E38
        sub.l   -$c(a6),d2                      ; 00E3A
        add.l   (ViewOffsetY8).l,d3             ; 00E3E
        sub.l   -$10(a6),d4                     ; 00E44
        neg.l   d2                              ; 00E48
        neg.l   d3                              ; 00E4A
        neg.l   d4                              ; 00E4C
        muls.w  d5,d2                           ; 00E4E
        muls.w  d6,d3                           ; 00E50
        muls.w  d7,d4                           ; 00E52
        add.l   d3,d4                           ; 00E54
        add.l   d2,d4                           ; 00E56
        bge.b   l_009_00E66                     ; 00E58
        subq.w  #$1,-$12(a6)                    ; 00E5A
        bge.w   l_009_00D78                     ; 00E5E
        bra.w   l_009_00EE8                     ; 00E62
l_009_00E66:
        tst.l   d1                              ; 00E66
        bge.w   l_009_00EF0                     ; 00E68
        tst.w   -$16(a6)                        ; 00E6C
        bge.b   l_009_00EE0                     ; 00E70
        movea.l -$4(a4),a2                      ; 00E72
        movem.w $2(a2),d2-d3                    ; 00E76
        addi.w  #$a4,d2                         ; 00E7C
        addi.w  #$a4,d3                         ; 00E80
        move.w  (a0),d1                         ; 00E84
        andi.w  #$ff00,d1                       ; 00E86
        add.w   d1,d1                           ; 00E8A
        lea.l   (ObjectTable).l,a2              ; 00E8C
        adda.w  d1,a2                           ; 00E92
        lea.l   (a2,d2.w),a5                    ; 00E94
        movem.w (a2,d3.w),d2-d4                 ; 00E98
        sub.w   (a5),d2                         ; 00E9E
        sub.w   $2(a5),d3                       ; 00EA0
        sub.w   $4(a5),d4                       ; 00EA4
        move.w  $2(a5),d7                       ; 00EA8
        muls.w  d7,d4                           ; 00EAC
        asr.l   #$6,d4                          ; 00EAE
        neg.w   d7                              ; 00EB0
        muls.w  d2,d7                           ; 00EB2
        asr.l   #$6,d7                          ; 00EB4
        move.w  d4,d5                           ; 00EB6
        movem.w (a5),d2-d4                      ; 00EB8
        move.w  -$20(a6),d0                     ; 00EBC
        asr.w   d0,d2                           ; 00EC0
        asr.w   d0,d4                           ; 00EC2
        add.w   $c(a2),d2                       ; 00EC4
        add.w   $e(a2),d4                       ; 00EC8
        sub.w   -$2(a6),d2                      ; 00ECC
        sub.w   -$8(a6),d4                      ; 00ED0
        neg.w   d2                              ; 00ED4
        neg.w   d4                              ; 00ED6
        muls.w  d5,d2                           ; 00ED8
        muls.w  d7,d4                           ; 00EDA
        add.l   d2,d4                           ; 00EDC
        bge.b   l_009_00EF0                     ; 00EDE
l_009_00EE0:
        subq.w  #$1,-$12(a6)                    ; 00EE0
        bge.w   l_009_00D78                     ; 00EE4
l_009_00EE8:
        ori.w   #$c000,$2(a1)                   ; 00EE8
        bra.b   l_009_00EF6                     ; 00EEE
l_009_00EF0:
        ori.w   #$8000,$2(a1)                   ; 00EF0
l_009_00EF6:
        addq.w  #$1,(dat_073_015E6).l           ; 00EF6
        bra.w   l_009_00A6A                     ; 00EFC
l_009_00F00:
        unlk    a6                              ; 00F00
        rts                                     ; 00F02
l_009_00F04:
        move.w  (dat_073_015E6).l,d7            ; 00F04
        ble.b   l_009_00F00                     ; 00F0A
        move.w  d7,d6                           ; 00F0C
        lea.l   (SceneryList).l,a0              ; 00F0E
        lea.l   (VertexBuffer).l,a1             ; 00F14
        move.w  (dat_073_015E4).l,d0            ; 00F1A
        blt.b   l_009_00F00                     ; 00F20
        asl.w   #$3,d0                          ; 00F22
        move.w  d0,d1                           ; 00F24
        add.w   d0,d0                           ; 00F26
        add.w   d1,d0                           ; 00F28
        adda.w  d0,a0                           ; 00F2A
        lea.l   (a0),a2                         ; 00F2C
        lea.l   (a1),a3                         ; 00F2E
l_009_00F30:
        movem.l (a0)+,d0-d5                     ; 00F30
        movem.l d0-d5,(a1)                      ; 00F34
        adda.w  #$18,a1                         ; 00F38
        dbra    d7,l_009_00F30                  ; 00F3C
        lea.l   (a3),a1                         ; 00F40
        move.w  d6,d7                           ; 00F42
l_009_00F44:
        tst.w   (a3)                            ; 00F44
        blt.b   l_009_00F6C                     ; 00F46
        move.w  $2(a3),d0                       ; 00F48
        andi.w  #$c000,d0                       ; 00F4C
        cmpi.w  #$c000,d0                       ; 00F50
        bne.b   l_009_00F6C                     ; 00F54
        andi.w  #$fff,$2(a3)                    ; 00F56
        movem.l (a3),d0-d5                      ; 00F5C
        movem.l d0-d5,(a2)                      ; 00F60
        move.w  #$ffff,(a3)                     ; 00F64
        adda.w  #$18,a2                         ; 00F68
l_009_00F6C:
        adda.w  #$18,a3                         ; 00F6C
        dbra    d7,l_009_00F44                  ; 00F70
        move.w  (dat_073_015E2).l,d0            ; 00F74
        sub.w   (dat_073_015E4).l,d0            ; 00F7A
        asl.w   #$3,d0                          ; 00F80
        move.w  d0,d1                           ; 00F82
        add.w   d0,d0                           ; 00F84
        add.w   d1,d0                           ; 00F86
        movem.l (a1,d0.w),d0-d5                 ; 00F88
        movem.l d0-d5,(a2)                      ; 00F8E
        adda.w  #$18,a2                         ; 00F92
        move.w  d6,d7                           ; 00F96
l_009_00F98:
        tst.w   (a1)                            ; 00F98
        blt.b   l_009_00FBC                     ; 00F9A
        move.w  $2(a1),d0                       ; 00F9C
        andi.w  #$c000,d0                       ; 00FA0
        cmpi.w  #$8000,d0                       ; 00FA4
        bne.b   l_009_00FBC                     ; 00FA8
        andi.w  #$fff,$2(a1)                    ; 00FAA
        movem.l (a1),d0-d5                      ; 00FB0
        movem.l d0-d5,(a2)                      ; 00FB4
        adda.w  #$18,a2                         ; 00FB8
l_009_00FBC:
        adda.w  #$18,a1                         ; 00FBC
        dbra    d7,l_009_00F98                  ; 00FC0
        unlk    a6                              ; 00FC4
        rts                                     ; 00FC6

;-------------------------------------------------------------------------------
; SmallObjectPosition - The position of the small object in d1 (high byte): from its record in
; SmallObjects.
;-------------------------------------------------------------------------------
SmallObjectPosition:
        andi.w  #$ff00,d1                       ; 00FC8
        lsr.w   #$3,d1                          ; 00FCC
        lea.l   (SmallObjects).l,a2             ; 00FCE
        adda.w  d1,a2                           ; 00FD4
        bra.b   l_009_00FE6                     ; 00FD6

;-------------------------------------------------------------------------------
; ObjectPosition - The position of the object in d1 (high byte): from its record in ObjectTable
; (+$0C cell, +$10 height...).
;-------------------------------------------------------------------------------
ObjectPosition:
        andi.w  #$ff00,d1                       ; 00FD8
        add.w   d1,d1                           ; 00FDC
        lea.l   (ObjectTable).l,a2              ; 00FDE
        adda.w  d1,a2                           ; 00FE4
l_009_00FE6:
        move.w  $c(a2),d2                       ; 00FE6
        ext.l   d2                              ; 00FEA
        move.l  $10(a2),d3                      ; 00FEC
        move.w  $e(a2),d4                       ; 00FF0
        ext.l   d4                              ; 00FF4
        rts                                     ; 00FF6
sub_009_00FF8:
        movem.w d5-d7,-(a7)                     ; 00FF8
        move.w  $6(a1),d2                       ; 00FFC
        ext.l   d2                              ; 01000
        move.w  $a(a1),d4                       ; 01002
        ext.l   d4                              ; 01006
        andi.w  #$f,d1                          ; 01008
        asl.l   d1,d2                           ; 0100C
        asl.l   d1,d4                           ; 0100E
        moveq   #$0,d3                          ; 01010
        moveq   #$0,d5                          ; 01012
        move.w  $e(a1),d3                       ; 01014
        move.w  d3,d5                           ; 01018
        lsr.w   #$8,d3                          ; 0101A
        andi.w  #$ff,d5                         ; 0101C
        move.w  (ViewCellX).l,d6                ; 01020
        andi.w  #$ff,d6                         ; 01026
        move.w  (ViewCellZ).l,d7                ; 0102A
        andi.w  #$ff,d7                         ; 01030
        sub.w   d6,d3                           ; 01034
        sub.w   d7,d5                           ; 01036
        swap    d3                              ; 01038
        swap    d5                              ; 0103A
        asr.l   #$2,d3                          ; 0103C
        asr.l   #$2,d5                          ; 0103E
        sub.l   d3,d2                           ; 01040
        sub.l   d5,d4                           ; 01042
        move.w  $8(a1),d3                       ; 01044
        ext.l   d3                              ; 01048
        asl.l   d1,d3                           ; 0104A
        movem.w (a7)+,d5-d7                     ; 0104C
        rts                                     ; 01050
sub_009_01052:
        move.w  (a1),d1                         ; 01052
        btst    #$4,d1                          ; 01054
        bne.b   l_009_01070                     ; 01058
        move.w  $e(a1),d1                       ; 0105A
        move.w  d1,-$1e(a6)                     ; 0105E
        andi.w  #$ff,-$1e(a6)                   ; 01062
        lsr.w   #$8,d1                          ; 01068
        move.w  d1,-$1c(a6)                     ; 0106A
        rts                                     ; 0106E
l_009_01070:
        move.l  a2,-(a7)                        ; 01070
        andi.w  #$ff00,d1                       ; 01072
        add.w   d1,d1                           ; 01076
        lea.l   (ObjectTable).l,a2              ; 01078
        adda.w  d1,a2                           ; 0107E
        move.w  $6(a2),d1                       ; 01080
        andi.w  #$ff,d1                         ; 01084
        move.w  d1,-$1c(a6)                     ; 01088
        move.w  $8(a2),d1                       ; 0108C
        andi.w  #$ff,d1                         ; 01090
        move.w  d1,-$1e(a6)                     ; 01094
        movea.l (a7)+,a2                        ; 01098
        rts                                     ; 0109A

;-------------------------------------------------------------------------------
; SmallObjectOf - a2 = the SmallObjects record of the drawing-list entry at a1.
;-------------------------------------------------------------------------------
SmallObjectOf:
        move.l  a2,-(a7)                        ; 0109C
        move.w  (a1),d1                         ; 0109E
        andi.w  #$ff00,d1                       ; 010A0
        lsr.w   #$3,d1                          ; 010A4
        lea.l   (SmallObjects).l,a2             ; 010A6
        bra.b   l_009_010BE                     ; 010AC

;-------------------------------------------------------------------------------
; ObjectOf - a2 = the ObjectTable record of the drawing-list entry at a1.
;-------------------------------------------------------------------------------
ObjectOf:
        move.l  a2,-(a7)                        ; 010AE
        move.w  (a1),d1                         ; 010B0
        andi.w  #$ff00,d1                       ; 010B2
        add.w   d1,d1                           ; 010B6
        lea.l   (ObjectTable).l,a2              ; 010B8
l_009_010BE:
        adda.w  d1,a2                           ; 010BE
        moveq   #$0,d1                          ; 010C0
        move.w  $6(a2),d1                       ; 010C2
        andi.w  #$ff,d1                         ; 010C6
        sub.w   -$1c(a6),d1                     ; 010CA
        swap    d1                              ; 010CE
        asr.l   #$2,d1                          ; 010D0
        add.l   d1,d2                           ; 010D2
        moveq   #$0,d1                          ; 010D4
        move.w  $8(a2),d1                       ; 010D6
        andi.w  #$ff,d1                         ; 010DA
        sub.w   -$1e(a6),d1                     ; 010DE
        swap    d1                              ; 010E2
        asr.l   #$2,d1                          ; 010E4
        add.l   d1,d4                           ; 010E6
        movea.l (a7)+,a2                        ; 010E8
        rts                                     ; 010EA
sub_009_010EC:
        moveq   #$0,d1                          ; 010EC
        move.w  $e(a1),d1                       ; 010EE
        lsr.w   #$8,d1                          ; 010F2
        sub.w   -$1c(a6),d1                     ; 010F4
        swap    d1                              ; 010F8
        asr.l   #$2,d1                          ; 010FA
        add.l   d1,d2                           ; 010FC
        moveq   #$0,d1                          ; 010FE
        move.w  $e(a1),d1                       ; 01100
        andi.w  #$ff,d1                         ; 01104
        sub.w   -$1e(a6),d1                     ; 01108
        swap    d1                              ; 0110C
        asr.l   #$2,d1                          ; 0110E
        add.l   d1,d4                           ; 01110
        rts                                     ; 01112
sub_009_01114:
        moveq   #$0,d1                          ; 01114
        move.w  (ViewCellX).l,d1                ; 01116
        andi.w  #$ff,d1                         ; 0111C
        sub.w   -$1c(a6),d1                     ; 01120
        swap    d1                              ; 01124
        asr.l   #$2,d1                          ; 01126
        add.l   d1,d2                           ; 01128
        moveq   #$0,d1                          ; 0112A
        move.w  (ViewCellZ).l,d1                ; 0112C
        andi.w  #$ff,d1                         ; 01132
        sub.w   -$1e(a6),d1                     ; 01136
        swap    d1                              ; 0113A
        asr.l   #$2,d1                          ; 0113C
        add.l   d1,d4                           ; 0113E
        rts                                     ; 01140
	dc.b	$00,$00
h009_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    2,9                             ; 2 longs pointing into hunk 9
	dc.l	$4E4,$34C
        dc.l    6,72                            ; 6 longs pointing into hunk 72
	dc.l	$63C,$6C4,$64A,$860,$F16,$58
        dc.l    117,71                          ; 117 longs pointing into hunk 71
	dc.l	$52,$5D2,$6DE,$6E4,$4C,$47C,$6EA,$5CA
	dc.l	$158,$276,$288,$4A6,$596,$756,$89E,$8B4
	dc.l	$46,$572,$592,$8B0,$26,$294,$4DC,$550
	dc.l	$702,$160,$1F0,$1FA,$25E,$268,$2C2,$2CC
	dc.l	$2FA,$304,$486,$490,$C0,$1B4,$226,$548
	dc.l	$59C,$6FA,$508,$128,$132,$13C,$40,$750
	dc.l	$282,$714,$7E8,$B64,$B80,$BE4,$CA2,$D9A
	dc.l	$E8E,$FE0,$107A,$10BA,$176,$270,$7F8,$B18
	dc.l	$FD0,$10A8,$58C,$746,$7DC,$83C,$834,$79C
	dc.l	$848,$98,$102C,$112E,$8C,$1022,$1118,$AE
	dc.l	$102,$49E,$4CE,$CE,$1C8,$238,$2E0,$9CE
	dc.l	$D44,$2F2,$310,$4EA,$82C,$B6E,$BEE,$C5A
	dc.l	$CB2,$D3E,$E40,$2AE,$9C8,$D38,$252,$470
	dc.l	$202,$21E,$466,$1E4,$45C,$4,$14,$20C
	dc.l	$33C,$5AA,$7C8,$948,$BC8
        dc.l    20,73                           ; 20 longs pointing into hunk 73
	dc.l	$776,$8C4,$8CC,$87C,$A64,$EF8,$F06,$A5C
	dc.l	$F1C,$F7C,$9BC,$F76,$70A,$5B8,$95E,$F10
	dc.l	$36,$4D6,$516,$528
        dc.l    1,16                            ; 1 longs pointing into hunk 16
	dc.l	$19A
        dc.l    8,7                             ; 8 longs pointing into hunk 7
	dc.l	$A,$1A,$212,$342,$5B0,$7CE,$94E,$BCE
        dc.l    5,8                             ; 5 longs pointing into hunk 8
	dc.l	$78,$C8,$1C2,$232,$842
	dc.l	0
	dc.l	HUNK_END
	endc
