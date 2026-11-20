; F/A-18 Interceptor - hunk 38 (code)
; The radar scope (DrawRadar, DrawRadarBlips: confirming a target's signature) and the panel's
; status lights (DrawStatusLights).
; Included by ../f18_main.s.

;===============================================================================
; Hunk 38: CODE, $7D0 bytes
;===============================================================================
	CODE_HUNK	h038
l_038_00000:
        rts                                     ; 00000

;-------------------------------------------------------------------------------
; DrawStatusLights - The panel's small status lights beside the radar: pairs of big dots, each
; lit in its colour while a bit of StatusLights is set (and one while the viewed object has
; +$20 bit 2).
;-------------------------------------------------------------------------------
DrawStatusLights:
        move.l  #$fffff,(FillPattern).l         ; 00002
        btst    #$2,(StatusLights).l            ; 0000C
        bne.b   l_038_0001C                     ; 00014
        move.w  #$3,d2                          ; 00016
        bra.b   l_038_00020                     ; 0001A
l_038_0001C:
        move.w  #$1,d2                          ; 0001C
l_038_00020:
        move.w  d2,(DrawColour).l               ; 00020
        move.w  #$125,d0                        ; 00026
        move.w  #$9c,d1                         ; 0002A
        jsr     (Plot2InView).l                 ; 0002E
        blt.b   l_038_00000                     ; 00034
        addq.w  #$2,d0                          ; 00036
        jsr     (PlotBig).l                     ; 00038
        btst    #$1,(StatusLights).l            ; 0003E
        bne.b   l_038_0004E                     ; 00046
        move.w  #$3,d2                          ; 00048
        bra.b   l_038_00052                     ; 0004C
l_038_0004E:
        move.w  #$4,d2                          ; 0004E
l_038_00052:
        move.w  d2,(DrawColour).l               ; 00052
        addq.w  #$3,d0                          ; 00058
        jsr     (PlotBig).l                     ; 0005A
        addq.w  #$2,d0                          ; 00060
        jsr     (PlotBig).l                     ; 00062
        btst    #$4,(StatusLights).l            ; 00068
        bne.b   l_038_00078                     ; 00070
        move.w  #$3,d2                          ; 00072
        bra.b   l_038_0007C                     ; 00076
l_038_00078:
        move.w  #$2,d2                          ; 00078
l_038_0007C:
        move.w  d2,(DrawColour).l               ; 0007C
        subq.w  #$2,d0                          ; 00082
        addq.w  #$3,d1                          ; 00084
        jsr     (PlotBig).l                     ; 00086
        addq.w  #$2,d0                          ; 0008C
        jsr     (PlotBig).l                     ; 0008E
        btst    #$5,(StatusLights).l            ; 00094
        bne.b   l_038_000A4                     ; 0009C
        move.w  #$3,d2                          ; 0009E
        bra.b   l_038_000A8                     ; 000A2
l_038_000A4:
        move.w  #$2,d2                          ; 000A4
l_038_000A8:
        move.w  d2,(DrawColour).l               ; 000A8
        subq.w  #$7,d0                          ; 000AE
        jsr     (PlotBig).l                     ; 000B0
        addq.w  #$2,d0                          ; 000B6
        jsr     (PlotBig).l                     ; 000B8
        lea.l   (ObjectTable).l,a0              ; 000BE
        adda.w  (ViewObject).l,a0               ; 000C4
        move.w  #$3,d2                          ; 000CA
        btst    #$2,$20(a0)                     ; 000CE
        beq.b   l_038_000E4                     ; 000D4
        btst    #$1,(BlinkPhase).l              ; 000D6
        beq.b   l_038_000E4                     ; 000DE
        move.w  #$1,d2                          ; 000E0
l_038_000E4:
        move.w  d2,(DrawColour).l               ; 000E4
        addq.w  #$8,d0                          ; 000EA
        jsr     (PlotBig).l                     ; 000EC
        addq.w  #$2,d0                          ; 000F2
        jsr     (PlotBig).l                     ; 000F4
        rts                                     ; 000FA
l_038_000FC:
        rts                                     ; 000FC

;-------------------------------------------------------------------------------
; DrawRadar - The radar scope on the panel (GameFrame stage $D0): its two lines
; (DrawRadarLines) and the blips (DrawRadarBlips), spread over frames.
;-------------------------------------------------------------------------------
DrawRadar:
        move.l  #$fffff,(FillPattern).l         ; 000FE
        move.l  #$16b8,d1                       ; 00108
        movea.w #$4,a4                          ; 0010E
        move.w  #$8,d7                          ; 00112
        add.l   (PanelShakeOffset).l,d1         ; 00116
        jsr     (ClipPanelBlit).l               ; 0011C
        blt.b   l_038_000FC                     ; 00122
        cmpi.b  #$1,(PanelRedraw).l             ; 00124
        bgt.b   l_038_00148                     ; 0012C
        beq.b   l_038_00158                     ; 0012E
        move.w  (FrameCount).l,d0               ; 00130
        andi.w  #$e,d0                          ; 00136
        beq.b   DrawRadarLines                  ; 0013A
        cmpi.w  #$8,d0                          ; 0013C
        beq.w   DrawRadarBlips                  ; 00140
        bra.w   l_038_0026A                     ; 00144
l_038_00148:
        move.w  #$ffff,(RadarBlips).l           ; 00148
        move.w  #$ffff,(dat_072_063B4).l        ; 00150
l_038_00158:
        bsr.w   DrawRadarLines                  ; 00158
        bsr.w   DrawRadarBlips                  ; 0015C
        rts                                     ; 00160
dat_038_00162:
	dc.b	$00,$9A,$00,$A3,$00,$8B,$00,$93,$00,$A2,$00,$A3,$00,$B1,$00,$93

;-------------------------------------------------------------------------------
; DrawRadarLines - The scope's two lines (dat_038_00162), offset by ViewX / ViewY.
;-------------------------------------------------------------------------------
DrawRadarLines:
        move.w  #$3,(DrawColour).l              ; 00172
        lea.l   dat_038_00162(pc),a0            ; 0017A
        movem.w (a0)+,d0-d3                     ; 0017E
        add.w   (ViewX).l,d0                    ; 00182
        blt.b   l_038_001B4                     ; 00188
        cmpi.w  #$140,d0                        ; 0018A
        bge.b   l_038_001B4                     ; 0018E
        add.w   (ViewX).l,d2                    ; 00190
        blt.b   l_038_001B4                     ; 00196
        cmpi.w  #$140,d2                        ; 00198
        bge.b   l_038_001B4                     ; 0019C
        add.w   (ViewY).l,d1                    ; 0019E
        add.w   (ViewY).l,d3                    ; 001A4
        move.l  a0,-(a7)                        ; 001AA
        jsr     (DrawLine199).l                 ; 001AC
        movea.l (a7)+,a0                        ; 001B2
l_038_001B4:
        movem.w (a0)+,d0-d3                     ; 001B4
        add.w   (ViewX).l,d0                    ; 001B8
        blt.b   l_038_001E6                     ; 001BE
        cmpi.w  #$140,d0                        ; 001C0
        bge.b   l_038_001E6                     ; 001C4
        add.w   (ViewX).l,d2                    ; 001C6
        blt.b   l_038_001E6                     ; 001CC
        cmpi.w  #$140,d2                        ; 001CE
        bge.b   l_038_001E6                     ; 001D2
        add.w   (ViewY).l,d1                    ; 001D4
        add.w   (ViewY).l,d3                    ; 001DA
        jsr     (DrawLine199).l                 ; 001E0
l_038_001E6:
        bra.w   l_038_0026A                     ; 001E6

;-------------------------------------------------------------------------------
; DrawRadarBlips - The player's mark at the scope's centre; erases the last frame's blips
; (RadarBlips, one list per display buffer) and plots each object of RadarList that is in range
; ($1B either side, $16 ahead and $10 behind, in units of $2000). An aircraft that comes within
; $10000 has its signature confirmed (+$20 bit 6, the target readout then names it); in mission
; F1 any aircraft (type $1x) held there counts down VisualConfirmTimer.
;-------------------------------------------------------------------------------
DrawRadarBlips:
        move.w  #$9d,d0                         ; 001EA
        add.w   (ViewX).l,d0                    ; 001EE
        blt.b   l_038_0026A                     ; 001F4
        cmpi.w  #$140,d0                        ; 001F6
        bge.b   l_038_0026A                     ; 001FA
        move.w  #$a8,d1                         ; 001FC
        add.w   (ViewY).l,d1                    ; 00200
        move.w  #$c,(DrawColour).l              ; 00206
        jsr     (Plot).l                        ; 0020E
        move.w  #$9f,d0                         ; 00214
        add.w   (ViewX).l,d0                    ; 00218
        blt.b   l_038_0026A                     ; 0021E
        cmpi.w  #$140,d0                        ; 00220
        bge.b   l_038_0026A                     ; 00224
        move.w  #$a8,d1                         ; 00226
        add.w   (ViewY).l,d1                    ; 0022A
        jsr     (Plot).l                        ; 00230
        move.w  #$9e,d0                         ; 00236
        add.w   (ViewX).l,d0                    ; 0023A
        move.w  #$a8,d1                         ; 00240
        add.w   (ViewY).l,d1                    ; 00244
        jsr     (Plot).l                        ; 0024A
        move.w  #$9e,d0                         ; 00250
        add.w   (ViewX).l,d0                    ; 00254
        move.w  #$a7,d1                         ; 0025A
        add.w   (ViewY).l,d1                    ; 0025E
        jsr     (Plot).l                        ; 00264
l_038_0026A:
        tst.b   (ObjectsDrawnCount).l           ; 0026A
        beq.w   l_038_000FC                     ; 00270
        lea.l   (RadarBlips).l,a2               ; 00274
        tst.w   (DisplayBuffer).l               ; 0027A
        beq.b   l_038_00286                     ; 00280
        adda.w  #$28,a2                         ; 00282
l_038_00286:
        move.w  #$0,(DrawColour).l              ; 00286
        moveq   #$a,d2                          ; 0028E
l_038_00290:
        move.w  (a2)+,d0                        ; 00290
        bge.b   l_038_002AC                     ; 00292
        cmpi.w  #$ffff,d0                       ; 00294
        beq.b   l_038_002C0                     ; 00298
        bclr    #$f,d0                          ; 0029A
        move.w  (a2)+,d1                        ; 0029E
        move.l  a2,-(a7)                        ; 002A0
        move.w  d2,-(a7)                        ; 002A2
        jsr     (Plot2).l                       ; 002A4
        bra.b   l_038_002B8                     ; 002AA
l_038_002AC:
        move.w  (a2)+,d1                        ; 002AC
        move.l  a2,-(a7)                        ; 002AE
        move.w  d2,-(a7)                        ; 002B0
        jsr     (Plot).l                        ; 002B2
l_038_002B8:
        move.w  (a7)+,d2                        ; 002B8
        movea.l (a7)+,a2                        ; 002BA
        dbra    d2,l_038_00290                  ; 002BC
l_038_002C0:
        moveq   #$0,d7                          ; 002C0
        addq.b  #$1,(BlinkCounter).l            ; 002C2
        clr.b   (RadarBlipBits).l               ; 002C8
        lea.l   (RadarList).l,a0                ; 002CE
        moveq   #$1,d6                          ; 002D4
        lea.l   (RadarBlips).l,a2               ; 002D6
        tst.w   (DisplayBuffer).l               ; 002DC
        beq.b   l_038_002E8                     ; 002E2
        adda.w  #$28,a2                         ; 002E4
l_038_002E8:
        movem.l (a0)+,d0-d2                     ; 002E8
        move.l  d0,d3                           ; 002EC
        or.l    d1,d3                           ; 002EE
        or.l    d2,d3                           ; 002F0
        beq.w   l_038_005FA                     ; 002F2
        exg.l   d1,d2                           ; 002F6
        move.l  d0,d5                           ; 002F8
        movea.l d1,a5                           ; 002FA
        move.w  #$d,d4                          ; 002FC
        asr.l   d4,d0                           ; 00300
        bcc.b   l_038_00306                     ; 00302
        addq.l  #$1,d0                          ; 00304
l_038_00306:
        asr.l   d4,d1                           ; 00306
        bcc.b   l_038_0030C                     ; 00308
        addq.l  #$1,d1                          ; 0030A
l_038_0030C:
        move.w  (a0),d3                         ; 0030C
        btst    #$4,d3                          ; 0030E
        beq.w   l_038_005EC                     ; 00312
        move.w  d3,d4                           ; 00316
        andi.w  #$ff00,d4                       ; 00318
        add.w   d4,d4                           ; 0031C
        lea.l   (ObjectTable).l,a1              ; 0031E
        adda.w  d4,a1                           ; 00324
        cmp.w   (ViewObject).l,d4               ; 00326
        beq.b   l_038_0036A                     ; 0032C
        btst    #$6,$1(a1)                      ; 0032E
        beq.b   l_038_0036A                     ; 00334
        btst    #$7,$3(a1)                      ; 00336
        bne.b   l_038_0036A                     ; 0033C
        neg.l   d0                              ; 0033E
        cmpi.l  #$1b,d0                         ; 00340
        bgt.b   l_038_00362                     ; 00346
        cmpi.l  #$ffffffe5,d0                   ; 00348
        blt.b   l_038_00362                     ; 0034E
        neg.l   d1                              ; 00350
        cmpi.l  #$16,d1                         ; 00352
        bge.b   l_038_00362                     ; 00358
        cmpi.l  #$fffffff0,d1                   ; 0035A
        bge.b   l_038_00374                     ; 00360
l_038_00362:
        btst    #$4,d3                          ; 00362
        beq.w   l_038_005EC                     ; 00366
l_038_0036A:
        bclr    #$6,$0(a1)                      ; 0036A
        bra.w   l_038_005EC                     ; 00370
l_038_00374:
        move.b  (GameMode).l,d1                 ; 00374
        cmpi.b  #$7d,d1                         ; 0037A
        beq.w   l_038_00488                     ; 0037E
        subq.b  #$2,d1                          ; 00382
        beq.w   l_038_00488                     ; 00384
        move.l  d5,d1                           ; 00388
        bge.b   l_038_0038E                     ; 0038A
        neg.l   d1                              ; 0038C
l_038_0038E:
        cmpi.l  #$10000,d1                      ; 0038E
        bgt.w   l_038_00482                     ; 00394
        move.l  a5,d1                           ; 00398
        bge.b   l_038_0039E                     ; 0039A
        neg.l   d1                              ; 0039C
l_038_0039E:
        cmpi.l  #$10000,d1                      ; 0039E
        bgt.w   l_038_00482                     ; 003A4
        bset    #$6,$20(a1)                     ; 003A8
        move.b  $62(a1),d1                      ; 003AE
        andi.b  #$f0,d1                         ; 003B2
        cmpi.b  #$20,d1                         ; 003B6
        beq.w   l_038_00488                     ; 003BA
        tst.w   (LockedTarget).l                ; 003BE
        blt.b   l_038_003F0                     ; 003C4
        cmpi.b  #$10,d1                         ; 003C6
        bne.b   l_038_003F0                     ; 003CA
        tst.w   (ViewObject).l                  ; 003CC
        bne.b   l_038_003F0                     ; 003D2
        tst.b   (VisualConfirmTimer).l          ; 003D4
        beq.b   l_038_003E8                     ; 003DA
        blt.b   l_038_003F0                     ; 003DC
l_038_003DE:
        subq.b  #$1,(VisualConfirmTimer).l      ; 003DE
        beq.b   l_038_003DE                     ; 003E4
        bra.b   l_038_003F0                     ; 003E6
l_038_003E8:
        move.b  #$1e,(VisualConfirmTimer).l     ; 003E8
l_038_003F0:
        btst    #$1,$20(a1)                     ; 003F0
        bne.w   l_038_00488                     ; 003F6
        move.w  $0(a1),d0                       ; 003FA
        andi.w  #$600,d0                        ; 003FE
        bne.w   l_038_00488                     ; 00402
        btst    #$7,$3(a1)                      ; 00406
        bne.w   l_038_00488                     ; 0040C
        cmpi.b  #$30,d1                         ; 00410
        beq.w   l_038_00488                     ; 00414
        cmpi.b  #$0,d1                          ; 00418
        bne.b   l_038_00428                     ; 0041C
        btst    #$3,$1(a1)                      ; 0041E
        beq.b   l_038_00456                     ; 00424
        bra.b   l_038_00488                     ; 00426
l_038_00428:
        btst    #$3,$1(a1)                      ; 00428
        beq.b   l_038_0043A                     ; 0042E
        bset    #$1,(RadarBlipBits).l           ; 00430
        bra.b   l_038_00488                     ; 00438
l_038_0043A:
        cmpi.b  #$15,$62(a1)                    ; 0043A
        beq.b   l_038_0044C                     ; 00440
        bset    #$2,(RadarBlipBits).l           ; 00442
        bra.b   l_038_00488                     ; 0044A
l_038_0044C:
        bset    #$3,(RadarBlipBits).l           ; 0044C
        bra.b   l_038_00488                     ; 00454
l_038_00456:
        move.b  $38(a1),d1                      ; 00456
        andi.w  #$7f,d1                         ; 0045A
        cmp.w   (ViewObjectIndex).l,d1          ; 0045E
        bne.b   l_038_00488                     ; 00464
        cmpi.b  #$0,$62(a1)                     ; 00466
        bne.b   l_038_00478                     ; 0046C
        bset    #$4,(RadarBlipBits).l           ; 0046E
        bra.b   l_038_00488                     ; 00476
l_038_00478:
        bset    #$5,(RadarBlipBits).l           ; 00478
        bra.b   l_038_00488                     ; 00480
l_038_00482:
        bclr    #$6,$20(a1)                     ; 00482
l_038_00488:
        btst    #$4,d3                          ; 00488
        beq.b   l_038_00494                     ; 0048C
        bset    #$6,$0(a1)                      ; 0048E
l_038_00494:
        move.l  d5,d0                           ; 00494
        move.l  a5,d1                           ; 00496
        move.l  a0,-(a7)                        ; 00498
        lea.l   (ObjectTable).l,a0              ; 0049A
        adda.w  (ViewObject).l,a0               ; 004A0
        move.b  $63(a0),d4                      ; 004A6
        movea.l (a7)+,a0                        ; 004AA
        andi.b  #$f,d4                          ; 004AC
        ext.w   d4                              ; 004B0
        asr.l   d4,d0                           ; 004B2
        bcc.b   l_038_004B8                     ; 004B4
        addq.l  #$1,d0                          ; 004B6
l_038_004B8:
        asr.l   d4,d1                           ; 004B8
        bcc.b   l_038_004BE                     ; 004BA
        addq.l  #$1,d1                          ; 004BC
l_038_004BE:
        neg.l   d0                              ; 004BE
        cmpi.l  #$1b,d0                         ; 004C0
        bgt.w   l_038_005EC                     ; 004C6
        cmpi.l  #$ffffffe5,d0                   ; 004CA
        blt.w   l_038_005EC                     ; 004D0
        neg.l   d1                              ; 004D4
        cmpi.l  #$16,d1                         ; 004D6
        bge.w   l_038_005EC                     ; 004DC
        cmpi.l  #$fffffff0,d1                   ; 004E0
        blt.w   l_038_005EC                     ; 004E6
        addi.w  #$9e,d0                         ; 004EA
        add.w   (ViewX).l,d0                    ; 004EE
        blt.w   l_038_005E6                     ; 004F4
        cmpi.w  #$140,d0                        ; 004F8
        bge.w   l_038_005E6                     ; 004FC
        addi.w  #$a7,d1                         ; 00500
        btst    #$4,d3                          ; 00504
        beq.w   l_038_005E6                     ; 00508
        move.l  (ViewOffsetY8).l,d5             ; 0050C
        move.w  d3,d4                           ; 00512
        andi.w  #$ff00,d4                       ; 00514
        add.w   d4,d4                           ; 00518
        cmp.w   (LockedTarget).l,d4             ; 0051A
        bne.b   l_038_0052E                     ; 00520
        btst    #$0,(BlinkCounter).l            ; 00522
        beq.w   l_038_005E6                     ; 0052A
l_038_0052E:
        move.l  a0,-(a7)                        ; 0052E
        lea.l   (ObjectTable).l,a0              ; 00530
        adda.w  d4,a0                           ; 00536
        neg.l   d5                              ; 00538
        bclr    #$0,d7                          ; 0053A
        cmp.l   $10(a0),d5                      ; 0053E
        bgt.b   l_038_00548                     ; 00542
        bset    #$0,d7                          ; 00544
l_038_00548:
        move.b  $62(a0),d5                      ; 00548
        andi.b  #$f0,d5                         ; 0054C
        cmpi.b  #$20,d5                         ; 00550
        beq.b   l_038_00588                     ; 00554
        cmpi.b  #$30,d5                         ; 00556
        beq.b   l_038_00588                     ; 0055A
        btst    #$6,$20(a0)                     ; 0055C
        beq.b   l_038_0058E                     ; 00562
        btst    #$1,$20(a0)                     ; 00564
        bne.b   l_038_0058E                     ; 0056A
        btst    #$3,$1(a0)                      ; 0056C
        bne.b   l_038_0057E                     ; 00572
        cmpi.b  #$0,d5                          ; 00574
        beq.b   l_038_00582                     ; 00578
        moveq   #$1,d2                          ; 0057A
        bra.b   l_038_00590                     ; 0057C
l_038_0057E:
        moveq   #$4,d2                          ; 0057E
        bra.b   l_038_00590                     ; 00580
l_038_00582:
        move.w  #$2,d2                          ; 00582
        bra.b   l_038_00590                     ; 00586
l_038_00588:
        move.w  #$5,d2                          ; 00588
        bra.b   l_038_00590                     ; 0058C
l_038_0058E:
        moveq   #$8,d2                          ; 0058E
l_038_00590:
        move.w  d2,(DrawColour).l               ; 00590
        movea.l (a7)+,a0                        ; 00596
        tst.w   (DisplayBuffer).l               ; 00598
        bne.b   l_038_005A8                     ; 0059E
        cmpa.l  #dat_072_063B4,a2               ; 005A0
        bra.b   l_038_005AE                     ; 005A6
l_038_005A8:
        cmpa.l  #h072_end,a2                    ; 005A8
l_038_005AE:
        bge.b   l_038_005E6                     ; 005AE
        move.w  d3,-(a7)                        ; 005B0
        add.w   (ViewY).l,d1                    ; 005B2
        btst    #$0,d7                          ; 005B8
        bne.b   l_038_005CE                     ; 005BC
        move.w  d0,(a2)+                        ; 005BE
        move.w  d1,(a2)+                        ; 005C0
        movem.l d6/a0-a2,-(a7)                  ; 005C2
        jsr     (Plot).l                        ; 005C6
        bra.b   l_038_005E0                     ; 005CC
l_038_005CE:
        move.w  d0,(a2)                         ; 005CE
        ori.w   #$8000,(a2)+                    ; 005D0
        move.w  d1,(a2)+                        ; 005D4
        movem.l d6/a0-a2,-(a7)                  ; 005D6
        jsr     (Plot2).l                       ; 005DA
l_038_005E0:
        movem.l (a7)+,d6/a0-a2                  ; 005E0
        move.w  (a7)+,d3                        ; 005E4
l_038_005E6:
        bset    #$5,d3                          ; 005E6
        bra.b   l_038_005F0                     ; 005EA
l_038_005EC:
        bclr    #$5,d3                          ; 005EC
l_038_005F0:
        move.w  d3,(a0)+                        ; 005F0
        addq.w  #$2,a0                          ; 005F2
        addq.w  #$1,d6                          ; 005F4
        bra.w   l_038_002E8                     ; 005F6
l_038_005FA:
        move.w  #$ffff,(a2)                     ; 005FA
        move.b  (RadarBlipBits).l,d0            ; 005FE
        beq.w   l_038_006C8                     ; 00604
        move.b  (StatusLights).l,d1             ; 00608
        btst    #$4,d0                          ; 0060E
        bne.b   l_038_00630                     ; 00612
        btst    #$5,d0                          ; 00614
        beq.b   l_038_00646                     ; 00618
        btst    #$5,d1                          ; 0061A
        bne.w   l_038_006DE                     ; 0061E
        ori.l   #$1,(SoundRequests).l           ; 00622
        bra.w   l_038_006DE                     ; 0062C
l_038_00630:
        btst    #$4,d1                          ; 00630
        bne.w   l_038_006DE                     ; 00634
        ori.l   #$1,(SoundRequests).l           ; 00638
        bra.w   l_038_006DE                     ; 00642
l_038_00646:
        btst    #$3,d0                          ; 00646
        beq.b   l_038_0066E                     ; 0064A
        btst    #$3,d1                          ; 0064C
        bne.b   l_038_0065E                     ; 00650
        ori.l   #$2,(SoundRequests).l           ; 00652
        bra.b   l_038_00684                     ; 0065C
l_038_0065E:
        btst    #$2,d0                          ; 0065E
        beq.b   l_038_0068E                     ; 00662
        btst    #$2,d1                          ; 00664
        beq.b   l_038_0067A                     ; 00668
        bra.w   l_038_006DE                     ; 0066A
l_038_0066E:
        btst    #$2,d0                          ; 0066E
        beq.b   l_038_006A6                     ; 00672
        btst    #$2,d1                          ; 00674
        bne.b   l_038_0068E                     ; 00678
l_038_0067A:
        ori.l   #$2,(SoundRequests).l           ; 0067A
l_038_00684:
        move.b  #$18,(RadarBlipTimer).l         ; 00684
        bra.b   l_038_006DE                     ; 0068C
l_038_0068E:
        btst    #$1,d0                          ; 0068E
        beq.b   l_038_006DE                     ; 00692
        btst    #$1,d1                          ; 00694
        bne.b   l_038_006DE                     ; 00698
        cmpi.b  #$5,(GameMode).l                ; 0069A
        beq.b   l_038_006DE                     ; 006A2
        bra.b   l_038_006BC                     ; 006A4
l_038_006A6:
        btst    #$1,d0                          ; 006A6
        beq.b   l_038_006C8                     ; 006AA
        cmpi.b  #$5,(GameMode).l                ; 006AC
        beq.b   l_038_006C8                     ; 006B4
        btst    #$1,d1                          ; 006B6
        bne.b   l_038_006DE                     ; 006BA
l_038_006BC:
        ori.l   #$800,(SoundRequests).l         ; 006BC
        bra.b   l_038_006DE                     ; 006C6
l_038_006C8:
        move.w  (CurrentWarning).l,d1           ; 006C8
        andi.w  #$ff,d1                         ; 006CE
        cmpi.w  #$800e,d1                       ; 006D2
        bne.b   l_038_006DE                     ; 006D6
        clr.w   (CurrentWarning).l              ; 006D8
l_038_006DE:
        move.b  d0,(StatusLights).l             ; 006DE
        tst.b   (TKeyPressed).l                 ; 006E4
        beq.w   l_038_007CC                     ; 006EA
        clr.b   (TKeyPressed).l                 ; 006EE
        lea.l   (RadarList).l,a0                ; 006F4
        moveq   #$0,d0                          ; 006FA
        tst.w   (LockedTarget).l                ; 006FC
        blt.b   l_038_00736                     ; 00702
l_038_00704:
        move.w  $c(a0,d0.w),d1                  ; 00704
        andi.w  #$ff00,d1                       ; 00708
        add.w   d1,d1                           ; 0070C
        cmp.w   (LockedTarget).l,d1             ; 0070E
        beq.b   l_038_00732                     ; 00714
        addi.w  #$10,d0                         ; 00716
        cmpi.w  #$460,d0                        ; 0071A
        blt.b   l_038_00704                     ; 0071E
        move.w  #$30,(DebugCheckpoint).l        ; 00720
        jsr     (Nop).l                         ; 00728
        moveq   #$0,d0                          ; 0072E
        bra.b   l_038_00736                     ; 00730
l_038_00732:
        addi.w  #$10,d0                         ; 00732
l_038_00736:
        move.l  (a0,d0.w),d5                    ; 00736
        or.l    $4(a0,d0.w),d5                  ; 0073A
        or.l    $8(a0,d0.w),d5                  ; 0073E
        beq.b   l_038_007BC                     ; 00742
        move.w  $c(a0,d0.w),d2                  ; 00744
        btst    #$4,d2                          ; 00748
        beq.b   l_038_007B4                     ; 0074C
        btst    #$5,d2                          ; 0074E
        beq.b   l_038_007B4                     ; 00752
        lea.l   (ObjectTable).l,a2              ; 00754
        andi.w  #$ff00,d2                       ; 0075A
        add.w   d2,d2                           ; 0075E
        move.b  $62(a2,d2.w),d5                 ; 00760
        andi.b  #$f0,d5                         ; 00764
        cmpi.b  #$0,d5                          ; 00768
        beq.b   l_038_007B4                     ; 0076C
        cmpi.b  #$20,d5                         ; 0076E
        beq.b   l_038_007B4                     ; 00772
        cmpi.b  #$30,d5                         ; 00774
        beq.b   l_038_007B4                     ; 00778
        btst    #$1,$20(a2,d2.w)                ; 0077A
        bne.b   l_038_007B4                     ; 00780
        move.w  d2,(LockedTarget).l             ; 00782
        move.w  #$1,(TargetReadoutMode).l       ; 00788
        move.b  #$1,(TargetReadoutCount).l      ; 00790
        move.b  #$ff,(RadarBlipTimer).l         ; 00798
        asr.w   #$4,d0                          ; 007A0
        addq.b  #$1,d0                          ; 007A2
        move.b  d0,(RadarLockState).l           ; 007A4
        andi.w  #$dfff,(WarningBits).l          ; 007AA
        bra.b   l_038_007CC                     ; 007B2
l_038_007B4:
        addi.w  #$10,d0                         ; 007B4
        bra.w   l_038_00736                     ; 007B8
l_038_007BC:
        move.b  #$0,(RadarLockState).l          ; 007BC
        move.w  #$ffff,(LockedTarget).l         ; 007C4
l_038_007CC:
        rts                                     ; 007CC
	dc.b	$00,$00
h038_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    92,71                           ; 92 longs pointing into hunk 71
	dc.l	$C6,$328,$3CE,$4A2,$460,$C0,$320,$49C
	dc.l	$532,$756,$3D6,$3E0,$3EC,$628,$63E,$658
	dc.l	$680,$6C2,$50E,$10,$42,$6C,$98,$60A
	dc.l	$6E0,$2CA,$434,$446,$450,$472,$47C,$600
	dc.l	$26C,$6CA,$6DA,$DA,$132,$2C4,$526,$128
	dc.l	$688,$79C,$794,$78C,$3C0,$51C,$6FE,$710
	dc.l	$784,$7C8,$7A6,$7C0,$6E6,$6F0,$376,$69E
	dc.l	$6B0,$27C,$2DE,$59A,$7AE,$8,$104,$22
	dc.l	$54,$7E,$AA,$E6,$176,$20A,$28A,$592
	dc.l	$1A0,$1A6,$1D6,$1DC,$202,$22C,$246,$260
	dc.l	$5B4,$118,$184,$192,$1BA,$1C8,$1F0,$21A
	dc.l	$23C,$256,$4F0,$724
        dc.l    8,72                            ; 8 longs pointing into hunk 72
	dc.l	$14C,$154,$276,$2D8,$5A2,$5AA,$2D0,$6F6
        dc.l    20,36                           ; 20 longs pointing into hunk 36
	dc.l	$3A,$5C,$64,$88,$90,$B2,$BA,$EE
	dc.l	$F6,$30,$2A6,$5DC,$210,$232,$24C,$266
	dc.l	$2B4,$5C8,$1AE,$1E2
        dc.l    1,37                            ; 1 longs pointing into hunk 37
	dc.l	$11E
        dc.l    1,7                             ; 1 longs pointing into hunk 7
	dc.l	$72A
	dc.l	0
	dc.l	HUNK_END
	endc
