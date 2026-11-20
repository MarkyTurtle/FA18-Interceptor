; F/A-18 Interceptor - hunk 33 (code)
; The sky: DrawSkyAndGround, MakeSkyPolygon (the view above the horizon, from PutEdge and the
; view's corners, 320 x 180), DrawSun.
; Included by ../f18_main.s.

;===============================================================================
; Hunk 33: CODE, $424 bytes
;===============================================================================
	CODE_HUNK	h033
dat_033_00000:
	dc.b	$28,$00,$DC,$00,$D5,$00,$DA,$00,$D8,$00,$24,$00,$26,$00,$2B,$00

;-------------------------------------------------------------------------------
; DrawSkyAndGround - Frame stage $60: the 3D view's background. Normally
; ClearSkyGround; when dat_071_002A2 bit $2000 is set, a whole-view polygon instead
; (SkyFillsView).
;-------------------------------------------------------------------------------
DrawSkyAndGround:
        move.w  (dat_071_002A2).l,d0            ; 00010
        andi.w  #$2000,d0                       ; 00016
        bne.b   l_033_00024                     ; 0001A
        jsr     (ClearSkyGround).l              ; 0001C
        rts                                     ; 00022
l_033_00024:
        bsr.w   SkyFillsView                    ; 00024
        rts                                     ; 00028

;-------------------------------------------------------------------------------
; MakeSkyPolygonPanel - MakeSkyPolygon with the second matrix (PanelViewMatrix): the sky
; polygon for the instrument panel's attitude indicator.
;-------------------------------------------------------------------------------
MakeSkyPolygonPanel:
        lea.l   (PanelViewMatrix).l,a2          ; 0002A
        bra.b   l_033_00038                     ; 00030

;-------------------------------------------------------------------------------
; MakeSkyPolygon - Turns the view's four corner directions (dat_033_00000) by
; the view matrix (ViewMatrix), finds where the horizon cuts the view's edges (hunk 34), and
; builds the polygon of the view above the horizon - the sky - at dat_072_03000 from the two
; horizon points (PutEdge) and the corners on the sky's side. Returns d0 = 0 (dat_071_0026E
; set) when there is sky to fill, 1 when there is none.
;-------------------------------------------------------------------------------
MakeSkyPolygon:
        lea.l   (ViewMatrix).l,a2               ; 00032
l_033_00038:
        lea.l   (a2),a4                         ; 00038
        link.w  a6,#$fffe                       ; 0003A
        lea.l   dat_033_00000(pc),a1            ; 0003E
        lea.l   (dat_072_03000).l,a3            ; 00042
        lea.l   -$2(a6),a0                      ; 00048
        move.w  #$4,(a0)                        ; 0004C
l_033_00050:
        move.w  (a1)+,d2                        ; 00050
        move.l  (ViewOffsetY).l,d3              ; 00052
        swap    d3                              ; 00058
        asr.w   #$2,d3                          ; 0005A
        move.w  (a1)+,d4                        ; 0005C
        lea.l   (a4),a2                         ; 0005E
        move.w  d2,d5                           ; 00060
        move.w  d3,d6                           ; 00062
        move.w  d4,d7                           ; 00064
        muls.w  (a2)+,d5                        ; 00066
        muls.w  (a2)+,d6                        ; 00068
        muls.w  (a2)+,d7                        ; 0006A
        add.l   d6,d7                           ; 0006C
        add.l   d5,d7                           ; 0006E
        asr.l   #$8,d7                          ; 00070
        bcc.b   l_033_00076                     ; 00072
        addq.w  #$1,d7                          ; 00074
l_033_00076:
        move.w  d7,(a3)+                        ; 00076
        move.w  d2,d5                           ; 00078
        move.w  d3,d6                           ; 0007A
        move.w  d4,d7                           ; 0007C
        muls.w  (a2)+,d5                        ; 0007E
        muls.w  (a2)+,d6                        ; 00080
        muls.w  (a2)+,d7                        ; 00082
        add.l   d6,d7                           ; 00084
        add.l   d5,d7                           ; 00086
        asr.l   #$8,d7                          ; 00088
        bcc.b   l_033_0008E                     ; 0008A
        addq.w  #$1,d7                          ; 0008C
l_033_0008E:
        move.w  d7,(a3)+                        ; 0008E
        muls.w  (a2)+,d2                        ; 00090
        muls.w  (a2)+,d3                        ; 00092
        muls.w  (a2)+,d4                        ; 00094
        add.l   d3,d4                           ; 00096
        add.l   d2,d4                           ; 00098
        asr.l   #$8,d4                          ; 0009A
        bcc.b   l_033_000A0                     ; 0009C
        addq.w  #$1,d4                          ; 0009E
l_033_000A0:
        move.w  d4,(a3)+                        ; 000A0
        move.w  d4,d3                           ; 000A2
        adda.w  #$1a,a3                         ; 000A4
        subq.w  #$1,(a0)                        ; 000A8
        bgt.b   l_033_00050                     ; 000AA
        lea.l   (dat_073_000DC).l,a4            ; 000AC
        clr.l   (a4)+                           ; 000B2
        clr.l   (a4)+                           ; 000B4
        clr.l   (a4)+                           ; 000B6
        clr.l   (a4)                            ; 000B8
        jsr     (FindHorizonEdges).l            ; 000BA
        lea.l   (dat_073_000DC).l,a1            ; 000C0
        tst.w   $2(a1)                          ; 000C6
        beq.b   l_033_00106                     ; 000CA
        tst.w   $6(a1)                          ; 000CC
        beq.b   l_033_000DE                     ; 000D0
        move.w  $a(a1),d0                       ; 000D2
        move.w  $e(a1),d1                       ; 000D6
        bra.w   l_033_00152                     ; 000DA
l_033_000DE:
        tst.w   $0(a1)                          ; 000DE
        beq.b   l_033_000F0                     ; 000E2
        move.w  $a(a1),d0                       ; 000E4
        move.w  $8(a1),d1                       ; 000E8
        bra.w   l_033_0019E                     ; 000EC
l_033_000F0:
        tst.w   $4(a1)                          ; 000F0
        beq.b   l_033_00102                     ; 000F4
        move.w  $a(a1),d0                       ; 000F6
        move.w  $c(a1),d1                       ; 000FA
        bra.w   l_033_001EC                     ; 000FE
l_033_00102:
        bra.w   l_033_00374                     ; 00102
l_033_00106:
        tst.w   $0(a1)                          ; 00106
        beq.b   l_033_00134                     ; 0010A
        tst.w   $6(a1)                          ; 0010C
        beq.b   l_033_0011E                     ; 00110
        move.w  $8(a1),d0                       ; 00112
        move.w  $e(a1),d1                       ; 00116
        bra.w   l_033_0023A                     ; 0011A
l_033_0011E:
        tst.w   $4(a1)                          ; 0011E
        beq.b   l_033_00130                     ; 00122
        move.w  $8(a1),d0                       ; 00124
        move.w  $c(a1),d1                       ; 00128
        bra.w   l_033_00288                     ; 0012C
l_033_00130:
        bra.w   l_033_00374                     ; 00130
l_033_00134:
        tst.w   $4(a1)                          ; 00134
        beq.w   SkyFillsView                    ; 00138
        tst.w   $6(a1)                          ; 0013C
        beq.b   l_033_0014E                     ; 00140
        move.w  $c(a1),d0                       ; 00142
        move.w  $e(a1),d1                       ; 00146
        bra.w   l_033_002CA                     ; 0014A
l_033_0014E:
        bra.w   l_033_00374                     ; 0014E
l_033_00152:
        lea.l   (dat_072_03000).l,a1            ; 00152
        move.w  #$4,(a1)+                       ; 00158
        tst.b   (OutsideView).l                 ; 0015C
        bne.b   l_033_00170                     ; 00162
        move.w  (dat_071_0029A).l,d6            ; 00164
        andi.w  #$2,d6                          ; 0016A
        bne.b   l_033_0018E                     ; 0016E
l_033_00170:
        bsr.w   PutEdge                         ; 00170
        bsr.w   PutCornerBR                     ; 00174
        bsr.w   PutCornerBL                     ; 00178
        lea.l   (dat_072_0300A).l,a1            ; 0017C
        bsr.w   PutCornerTR                     ; 00182
        bsr.w   PutCornerTL                     ; 00186
        bra.w   l_033_00350                     ; 0018A
l_033_0018E:
        bsr.w   PutEdge                         ; 0018E
        bsr.w   PutCornerBR                     ; 00192
        bsr.w   PutCornerBL                     ; 00196
        bra.w   l_033_00350                     ; 0019A
l_033_0019E:
        lea.l   (dat_072_03000).l,a1            ; 0019E
        move.w  #$5,(a1)+                       ; 001A4
        move.w  (dat_071_0029A).l,d6            ; 001A8
        andi.w  #$2,d6                          ; 001AE
        bne.b   l_033_001D8                     ; 001B2
        bsr.w   PutEdge                         ; 001B4
        bsr.w   PutCornerTR                     ; 001B8
        bsr.w   PutCornerBR                     ; 001BC
        bsr.w   PutCornerBL                     ; 001C0
        lea.l   (dat_072_03000).l,a1            ; 001C4
        move.w  #$3,(a1)+                       ; 001CA
        addq.w  #$8,a1                          ; 001CE
        bsr.w   PutCornerTL                     ; 001D0
        bra.w   l_033_00350                     ; 001D4
l_033_001D8:
        bsr.w   PutEdge                         ; 001D8
        bsr.w   PutCornerTR                     ; 001DC
        bsr.w   PutCornerBR                     ; 001E0
        bsr.w   PutCornerBL                     ; 001E4
        bra.w   l_033_00350                     ; 001E8
l_033_001EC:
        lea.l   (dat_072_03000).l,a1            ; 001EC
        move.w  #$5,(a1)+                       ; 001F2
        move.w  (dat_071_0029A).l,d6            ; 001F6
        andi.w  #$2,d6                          ; 001FC
        bne.b   l_033_00216                     ; 00200
        bsr.w   PutEdge                         ; 00202
        bsr.w   PutCornerBR                     ; 00206
        bsr.w   PutCornerTR                     ; 0020A
        bsr.w   PutCornerTL                     ; 0020E
        bra.w   l_033_00350                     ; 00212
l_033_00216:
        bsr.w   PutEdge                         ; 00216
        bsr.w   PutCornerBR                     ; 0021A
        bsr.w   PutCornerTR                     ; 0021E
        bsr.w   PutCornerTL                     ; 00222
        lea.l   (dat_072_03000).l,a1            ; 00226
        move.w  #$3,(a1)+                       ; 0022C
        addq.w  #$8,a1                          ; 00230
        bsr.w   PutCornerBL                     ; 00232
        bra.w   l_033_00350                     ; 00236
l_033_0023A:
        lea.l   (dat_072_03000).l,a1            ; 0023A
        move.w  #$5,(a1)+                       ; 00240
        move.w  (dat_071_0029A).l,d6            ; 00244
        andi.w  #$2,d6                          ; 0024A
        bne.b   l_033_00274                     ; 0024E
        bsr.w   PutEdge                         ; 00250
        bsr.w   PutCornerBR                     ; 00254
        bsr.w   PutCornerBL                     ; 00258
        bsr.w   PutCornerTL                     ; 0025C
        lea.l   (dat_072_03000).l,a1            ; 00260
        move.w  #$3,(a1)+                       ; 00266
        addq.w  #$8,a1                          ; 0026A
        bsr.w   PutCornerTR                     ; 0026C
        bra.w   l_033_00350                     ; 00270
l_033_00274:
        bsr.w   PutEdge                         ; 00274
        bsr.w   PutCornerBR                     ; 00278
        bsr.w   PutCornerBL                     ; 0027C
        bsr.w   PutCornerTL                     ; 00280
        bra.w   l_033_00350                     ; 00284
l_033_00288:
        lea.l   (dat_072_03000).l,a1            ; 00288
        move.w  #$4,(a1)+                       ; 0028E
        cmpi.w  #$3840,(dat_071_00462).l        ; 00292
        bge.b   l_033_002BA                     ; 0029A
        bsr.w   PutEdge                         ; 0029C
        bsr.w   PutCornerBL                     ; 002A0
        bsr.w   PutCornerTL                     ; 002A4
        lea.l   (dat_072_0300A).l,a1            ; 002A8
        bsr.w   PutCornerBR                     ; 002AE
        bsr.w   PutCornerTR                     ; 002B2
        bra.w   l_033_00350                     ; 002B6
l_033_002BA:
        bsr.w   PutEdge                         ; 002BA
        bsr.w   PutCornerBL                     ; 002BE
        bsr.w   PutCornerTL                     ; 002C2
        bra.w   l_033_00350                     ; 002C6
l_033_002CA:
        lea.l   (dat_072_03000).l,a1            ; 002CA
        move.w  #$5,(a1)+                       ; 002D0
        move.w  (dat_071_0029A).l,d6            ; 002D4
        andi.w  #$2,d6                          ; 002DA
        bne.b   l_033_002F4                     ; 002DE
        bsr.w   PutEdge                         ; 002E0
        bsr.w   PutCornerTR                     ; 002E4
        bsr.w   PutCornerTL                     ; 002E8
        bsr.w   PutCornerBL                     ; 002EC
        bra.w   l_033_00350                     ; 002F0
l_033_002F4:
        bsr.w   PutEdge                         ; 002F4
        bsr.w   PutCornerTR                     ; 002F8
        bsr.w   PutCornerTL                     ; 002FC
        bsr.w   PutCornerBL                     ; 00300
        lea.l   (dat_072_03000).l,a1            ; 00304
        move.w  #$3,(a1)+                       ; 0030A
        addq.w  #$8,a1                          ; 0030E
        bsr.w   PutCornerBR                     ; 00310
        bra.w   l_033_00350                     ; 00314

;-------------------------------------------------------------------------------
; SkyFillsView - The sky polygon as the whole view (all four corners): used when no horizon
; edge crosses the view and the view looks up (its pitch, dat_071_0045A or OutsideCamPitch
; outside, above $3840); otherwise no sky at all.
;-------------------------------------------------------------------------------
SkyFillsView:
        lea.l   (dat_072_03000).l,a1            ; 00318
        move.w  #$4,(a1)+                       ; 0031E
        bsr.w   PutCornerTL                     ; 00322
        bsr.w   PutCornerTR                     ; 00326
        bsr.w   PutCornerBR                     ; 0032A
        bsr.w   PutCornerBL                     ; 0032E
        tst.b   (OutsideView).l                 ; 00332
        bne.b   l_033_00342                     ; 00338
        move.w  (dat_071_0045A).l,d0            ; 0033A
        bra.b   l_033_00348                     ; 00340
l_033_00342:
        move.w  (OutsideCamPitch).l,d0          ; 00342
l_033_00348:
        cmpi.w  #$3840,d0                       ; 00348
        bgt.b   l_033_00350                     ; 0034C
        bra.b   l_033_00374                     ; 0034E
l_033_00350:
        move.w  #$1,(FillPattern).l             ; 00350
        move.w  #$1,(DrawXor).l                 ; 00358
        clr.l   (FillPattern2).l                ; 00360
        move.b  #$1,(dat_071_0026E).l           ; 00366
        moveq   #$0,d0                          ; 0036E
        unlk    a6                              ; 00370
        rts                                     ; 00372
l_033_00374:
        clr.b   (dat_071_0026E).l               ; 00374
        moveq   #$1,d0                          ; 0037A
        unlk    a6                              ; 0037C
        rts                                     ; 0037E

;-------------------------------------------------------------------------------
; PutEdge - PutEdge(d0, d1 = two projected points of dat_072_03600, 8 bytes each): writes their
; screen positions at (a1)+, as (319 - x, 179 - y).
;-------------------------------------------------------------------------------
PutEdge:
        asl.w   #$3,d0                          ; 00380
        asl.w   #$3,d1                          ; 00382
        lea.l   (dat_072_03600).l,a0            ; 00384
        move.w  #$13f,d2                        ; 0038A
        move.w  d2,d4                           ; 0038E
        sub.w   (a0,d0.w),d2                    ; 00390
        move.w  #$b3,d3                         ; 00394
        move.w  d3,d5                           ; 00398
        sub.w   $2(a0,d0.w),d3                  ; 0039A
        move.w  d2,(a1)+                        ; 0039E
        move.w  d3,(a1)+                        ; 003A0
        sub.w   (a0,d1.w),d4                    ; 003A2
        sub.w   $2(a0,d1.w),d5                  ; 003A6
        move.w  d4,(a1)+                        ; 003AA
        move.w  d5,(a1)+                        ; 003AC
        rts                                     ; 003AE

;-------------------------------------------------------------------------------
; PutCornerTL - Writes the view's corner (0, 0) at (a1)+.
;-------------------------------------------------------------------------------
PutCornerTL:
        clr.l   (a1)+                           ; 003B0
        rts                                     ; 003B2

;-------------------------------------------------------------------------------
; PutCornerTR - Writes the view's corner (319, 0) at (a1)+.
;-------------------------------------------------------------------------------
PutCornerTR:
        move.w  #$13f,(a1)+                     ; 003B4
        clr.w   (a1)+                           ; 003B8
        rts                                     ; 003BA

;-------------------------------------------------------------------------------
; PutCornerBR - Writes the view's corner (319, 179) at (a1)+.
;-------------------------------------------------------------------------------
PutCornerBR:
        move.w  #$13f,(a1)+                     ; 003BC
        move.w  #$b3,(a1)+                      ; 003C0
        rts                                     ; 003C4

;-------------------------------------------------------------------------------
; PutCornerBL - Writes the view's corner (0, 179) at (a1)+.
;-------------------------------------------------------------------------------
PutCornerBL:
        clr.w   (a1)+                           ; 003C6
        move.w  #$b3,(a1)+                      ; 003C8
        rts                                     ; 003CC

;-------------------------------------------------------------------------------
; DrawSun - Frame stage $70: plots a small mark in colour 9 (orange) in a fixed
; direction in the sky (-$2000, $3800, -$2000, turned by the view matrix): probably the sun.
;-------------------------------------------------------------------------------
DrawSun:
        move.w  #$e000,d2                       ; 003CE
        move.w  #$3800,d3                       ; 003D2
        move.w  #$e000,d4                       ; 003D6
        lea.l   (ViewMatrix).l,a0               ; 003DA
        move.w  d2,d5                           ; 003E0
        move.w  d3,d6                           ; 003E2
        move.w  d4,d0                           ; 003E4
        muls.w  (a0)+,d5                        ; 003E6
        muls.w  (a0)+,d6                        ; 003E8
        muls.w  (a0)+,d0                        ; 003EA
        add.l   d6,d0                           ; 003EC
        add.l   d5,d0                           ; 003EE
        asr.l   #$8,d0                          ; 003F0
        move.w  d2,d5                           ; 003F2
        move.w  d3,d6                           ; 003F4
        move.w  d4,d1                           ; 003F6
        muls.w  (a0)+,d5                        ; 003F8
        muls.w  (a0)+,d6                        ; 003FA
        muls.w  (a0)+,d1                        ; 003FC
        add.l   d6,d1                           ; 003FE
        add.l   d5,d1                           ; 00400
        asr.l   #$8,d1                          ; 00402
        muls.w  (a0)+,d2                        ; 00404
        muls.w  (a0)+,d3                        ; 00406
        muls.w  (a0)+,d4                        ; 00408
        add.l   d3,d2                           ; 0040A
        add.l   d4,d2                           ; 0040C
        asr.l   #$8,d2                          ; 0040E
        moveq   #$8,d6                          ; 00410
        move.w  #$9,(DrawColour).l              ; 00412
        jsr     (PlotPoint3DBig).l              ; 0041A
        rts                                     ; 00420
	dc.b	$00,$00
h033_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    21,71                           ; 21 longs pointing into hunk 71
	dc.l	$15E,$334,$12,$166,$1AA,$1F8,$246,$2D6
	dc.l	$54,$344,$296,$33C,$2C,$34,$3DC,$36A
	dc.l	$376,$354,$35C,$362,$416
        dc.l    15,72                           ; 15 longs pointing into hunk 72
	dc.l	$44,$386,$154,$17E,$1A0,$1C6,$1EE,$228
	dc.l	$23C,$262,$28A,$2AA,$2CC,$306,$31A
        dc.l    2,73                            ; 2 longs pointing into hunk 73
	dc.l	$AE,$C2
        dc.l    1,36                            ; 1 longs pointing into hunk 36
	dc.l	$1E
        dc.l    1,35                            ; 1 longs pointing into hunk 35
	dc.l	$41C
        dc.l    1,34                            ; 1 longs pointing into hunk 34
	dc.l	$BC
	dc.l	0
	dc.l	HUNK_END
	endc
