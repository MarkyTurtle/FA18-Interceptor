; F/A-18 Interceptor - hunk 36 (code)
; Drawing: Plot and its variants, DrawLine (the blitter's line mode), the copper lists (the
; double-buffered display).
; Included by ../f18_main.s.

;===============================================================================
; Hunk 36: CODE, $1224 bytes
;===============================================================================
	CODE_HUNK	h036

;-------------------------------------------------------------------------------
; SolidPattern - Sets FillPattern to solid.
;-------------------------------------------------------------------------------
SolidPattern:
        move.l  #$fffff,(FillPattern).l         ; 00000
        rts                                     ; 0000A

;-------------------------------------------------------------------------------
; DrawBufferMark - Draws a short line in colour 13 at the top left corner (0,0)-(8,9) or the
; other way, by which buffer is shown: a marker of the double buffering (DrawBufferMark2 the
; other).
;-------------------------------------------------------------------------------
DrawBufferMark:
        move.l  #$fffff,(FillPattern).l         ; 0000C
        move.w  #$d,(DrawColour).l              ; 00016
        tst.w   (DisplayBuffer).l               ; 0001E
        beq.b   l_036_0004C                     ; 00024
        move.w  #$0,d0                          ; 00026
        move.w  #$0,d1                          ; 0002A
        move.w  #$8,d2                          ; 0002E
        move.w  #$9,d3                          ; 00032
        bra.b   l_036_00048                     ; 00036

;-------------------------------------------------------------------------------
; DrawBufferMark2 - The other line of DrawBufferMark ((8,0)-(0,9)).
;-------------------------------------------------------------------------------
DrawBufferMark2:
        move.w  #$8,d0                          ; 00038
        move.w  #$0,d1                          ; 0003C
        move.w  #$0,d2                          ; 00040
        move.w  #$9,d3                          ; 00044
l_036_00048:
        bsr.w   DrawLine                        ; 00048
l_036_0004C:
        rts                                     ; 0004C

;-------------------------------------------------------------------------------
; SetupBufferPlanes - Fills BufferPlanes (and dat_071_0005E) with the two display buffers'
; plane addresses, in the order the drawing uses (plane 3 first).
;-------------------------------------------------------------------------------
SetupBufferPlanes:
        lea.l   (BufferPlanes).l,a0             ; 0004E
        move.l  (Buffer1Plane3).l,(a0)+         ; 00054
        move.l  (Buffer1Plane2).l,(a0)+         ; 0005A
        move.l  (Buffer1Plane1).l,(a0)+         ; 00060
        move.l  (Buffer1Plane0).l,(a0)+         ; 00066
        move.l  (Buffer2Plane3).l,(a0)+         ; 0006C
        move.l  (Buffer2Plane2).l,(a0)+         ; 00072
        move.l  (Buffer2Plane1).l,(a0)+         ; 00078
        move.l  (Buffer2Plane0).l,(a0)          ; 0007E
        lea.l   (dat_071_0005E).l,a0            ; 00084
        move.l  (Buffer1Plane4).l,(a0)+         ; 0008A
        move.l  (Buffer1Plane3).l,(a0)+         ; 00090
        move.l  (Buffer1Plane2).l,(a0)+         ; 00096
        move.l  (Buffer1Plane1).l,(a0)+         ; 0009C
        move.l  (Buffer1Plane0).l,(a0)+         ; 000A2
        move.l  (Buffer2Plane3).l,(a0)+         ; 000A8
        move.l  (Buffer2Plane3).l,(a0)+         ; 000AE
        move.l  (Buffer2Plane2).l,(a0)+         ; 000B4
        move.l  (Buffer2Plane1).l,(a0)+         ; 000BA
        move.l  (Buffer2Plane0).l,(a0)          ; 000C0
        rts                                     ; 000C6

;-------------------------------------------------------------------------------
; SelectDrawBuffer - Points DrawPlanes (and dat_071_0008A) at the planes of the buffer to draw
; into, by DisplayBuffer: the double buffering's swap.
;-------------------------------------------------------------------------------
SelectDrawBuffer:
        lea.l   (BufferPlanes).l,a0             ; 000C8
        lea.l   (dat_071_0005E).l,a1            ; 000CE
        tst.w   (DisplayBuffer).l               ; 000D4
        beq.b   l_036_000E4                     ; 000DA
        adda.w  #$10,a0                         ; 000DC
        adda.w  #$14,a1                         ; 000E0
l_036_000E4:
        move.l  a0,(DrawPlanes).l               ; 000E4
        move.l  a1,(dat_071_0008A).l            ; 000EA
        rts                                     ; 000F0

;-------------------------------------------------------------------------------
; ClearBothBuffers - Clears the first rows of both display buffers' planes (ClearPlanesRows on
; each half of BufferPlanes).
;-------------------------------------------------------------------------------
ClearBothBuffers:
        lea.l   (BufferPlanes).l,a1             ; 000F2
        bsr.w   ClearPlanesRows                 ; 000F8
        lea.l   (BufferPlanes).l,a1             ; 000FC
        adda.w  #$10,a1                         ; 00102

;-------------------------------------------------------------------------------
; ClearPlanesRows - Clears a block of the four planes listed at a1 with movem.
;-------------------------------------------------------------------------------
ClearPlanesRows:
        movem.l (a1),a0-a3                      ; 00106
        moveq   #$0,d0                          ; 0010A
        move.l  d0,d1                           ; 0010C
        move.l  d0,d2                           ; 0010E
        move.l  d0,d3                           ; 00110
        move.l  d0,d4                           ; 00112
        move.l  d0,d5                           ; 00114
        move.l  d0,d6                           ; 00116
        move.l  d0,d7                           ; 00118
        movea.l d0,a4                           ; 0011A
        movea.l d0,a5                           ; 0011C
        movem.l d0-d7/a4-a5,(a0)                ; 0011E
        movem.l d0-d7/a4-a5,(a1)                ; 00122
        movem.l d0-d7/a4-a5,(a2)                ; 00126
        movem.l d0-d7/a4-a5,(a3)                ; 0012A
        rts                                     ; 0012E

;-------------------------------------------------------------------------------
; PlotInView - Plot at (x + ViewX, y + ViewY), nothing (d2 = -1) if x is off the 320-pixel
; screen.
;-------------------------------------------------------------------------------
PlotInView:
        add.w   (ViewX).l,d0                    ; 00130
        blt.b   l_036_00192                     ; 00136
        cmpi.w  #$140,d0                        ; 00138
        bge.b   l_036_00192                     ; 0013C
        add.w   (ViewY).l,d1                    ; 0013E

;-------------------------------------------------------------------------------
; PlotKeep - Plot, keeping d0/d1.
;-------------------------------------------------------------------------------
PlotKeep:
        movea.l (DrawPlanes).l,a1               ; 00144
        lea.l   (PixelMasks).l,a3               ; 0014A
        lea.l   (PlotColourWriters).l,a4        ; 00150
        move.w  d0,-(a7)                        ; 00156
        move.w  d1,-(a7)                        ; 00158
        bsr.w   PlotCore                        ; 0015A
        move.w  (a7)+,d1                        ; 0015E
        move.w  (a7)+,d0                        ; 00160
        rts                                     ; 00162

;-------------------------------------------------------------------------------
; Plot - Plot(d0 = x, d1 = y): one pixel in the current colour.
;-------------------------------------------------------------------------------
Plot:
        movea.l (DrawPlanes).l,a1               ; 00164
        lea.l   (PixelMasks).l,a3               ; 0016A
        lea.l   (PlotColourWriters).l,a4        ; 00170
        bra.w   PlotCore                        ; 00176

;-------------------------------------------------------------------------------
; Plot2 - A 2-pixel-wide point at (x, y) (two Plots when it straddles a 16-pixel word).
;-------------------------------------------------------------------------------
Plot2:
        move.w  d0,d2                           ; 0017A
        andi.w  #$f,d2                          ; 0017C
        bne.b   l_036_00196                     ; 00180
        movem.w d0-d1,-(a7)                     ; 00182
        bsr.b   Plot                            ; 00186
        movem.w (a7)+,d0-d1                     ; 00188
        subq.w  #$1,d0                          ; 0018C
        bsr.b   Plot                            ; 0018E
        rts                                     ; 00190
l_036_00192:
        moveq   #-1,d2                          ; 00192
        rts                                     ; 00194
l_036_00196:
        movea.l (DrawPlanes).l,a1               ; 00196
        lea.l   (PixelPairMasks).l,a3           ; 0019C
        lea.l   (PlotColourWriters).l,a4        ; 001A2
        bra.b   PlotCore                        ; 001A8

;-------------------------------------------------------------------------------
; Plot2InView - Plot2 at (x + ViewX, y + ViewY), clipped to x 0-318.
;-------------------------------------------------------------------------------
Plot2InView:
        add.w   (ViewX).l,d0                    ; 001AA
        blt.b   l_036_00192                     ; 001B0
        cmpi.w  #$13f,d0                        ; 001B2
        bge.b   l_036_00192                     ; 001B6
        add.w   (ViewY).l,d1                    ; 001B8

;-------------------------------------------------------------------------------
; PlotBig - A big point (2 pixels wide, the colour writers of BigColourWriters), keeping d0/d1.
;-------------------------------------------------------------------------------
PlotBig:
        move.w  d0,-(a7)                        ; 001BE
        move.w  d1,-(a7)                        ; 001C0
        movea.l (DrawPlanes).l,a1               ; 001C2
        lea.l   (PixelPairMasks).l,a3           ; 001C8
        lea.l   (BigColourWriters).l,a4         ; 001CE
        bsr.w   PlotCore                        ; 001D4
        move.w  (a7)+,d1                        ; 001D8
        move.w  (a7)+,d0                        ; 001DA
        rts                                     ; 001DC

;-------------------------------------------------------------------------------
; PlotBigAbove - A big point above row ClipY (PlotBig), a 2-pixel point below it (Plot2).
;-------------------------------------------------------------------------------
PlotBigAbove:
        cmp.w   (ClipY).l,d1                    ; 001DE
        bge.b   Plot2                           ; 001E4
        movea.l (DrawPlanes).l,a1               ; 001E6
        lea.l   (PixelPairMasks).l,a3           ; 001EC
        lea.l   (BigColourWriters).l,a4         ; 001F2

;-------------------------------------------------------------------------------
; PlotCore - Plots one pixel of the current colour into the four planes the drawing goes to
; (DrawPlanes; 40 bytes a row): d0 = x, d1 = y (nothing for y <= 0), a3 = the pixel mask table,
; a4 = the table of colour writers (one per colour, DrawColour & 15). The planes that DrawMask
; bit n clears are left alone; with DrawXor >= 0 the planes in DrawXorMask are XORed instead.
;-------------------------------------------------------------------------------
PlotCore:
        tst.w   d1                              ; 001F8
        ble.b   l_036_00192                     ; 001FA
        move.w  (DrawColour).l,d2               ; 001FC
        andi.w  #$f,d2                          ; 00202
        add.w   d2,d2                           ; 00206
        add.w   d2,d2                           ; 00208
        movea.l (a4,d2.w),a4                    ; 0020A
        move.w  d0,d2                           ; 0020E
        andi.w  #$f,d0                          ; 00210
        add.w   d0,d0                           ; 00214
        move.w  (a3,d0.w),d0                    ; 00216
        move.w  d0,d7                           ; 0021A
        not.w   d0                              ; 0021C
        asl.w   #$3,d1                          ; 0021E
        move.w  d1,d3                           ; 00220
        add.w   d3,d3                           ; 00222
        add.w   d3,d3                           ; 00224
        add.w   d3,d1                           ; 00226
        andi.w  #$fff0,d2                       ; 00228
        asr.w   #$3,d2                          ; 0022C
        add.w   d1,d2                           ; 0022E
        movem.l (a1),a0-a3                      ; 00230
        adda.w  d2,a0                           ; 00234
        adda.w  d2,a1                           ; 00236
        adda.w  d2,a2                           ; 00238
        adda.w  d2,a3                           ; 0023A
        move.w  d0,d1                           ; 0023C
        move.w  d0,d2                           ; 0023E
        move.w  d0,d3                           ; 00240
        move.w  d7,d4                           ; 00242
        move.w  d7,d5                           ; 00244
        move.w  d7,d6                           ; 00246
        btst    #$0,(DrawMask).l                ; 00248
        bne.b   l_036_00258                     ; 00250
        move.w  #$ffff,d0                       ; 00252
        clr.w   d4                              ; 00256
l_036_00258:
        btst    #$1,(DrawMask).l                ; 00258
        bne.b   l_036_00268                     ; 00260
        move.w  #$ffff,d1                       ; 00262
        clr.w   d5                              ; 00266
l_036_00268:
        btst    #$2,(DrawMask).l                ; 00268
        bne.b   l_036_00278                     ; 00270
        move.w  #$ffff,d2                       ; 00272
        clr.w   d6                              ; 00276
l_036_00278:
        btst    #$3,(DrawMask).l                ; 00278
        bne.b   l_036_00288                     ; 00280
        move.w  #$ffff,d3                       ; 00282
        clr.w   d7                              ; 00286
l_036_00288:
        tst.w   (DrawXor).l                     ; 00288
        blt.b   l_036_002D4                     ; 0028E
        andi.l  #$ffff,d0                       ; 00290
        btst    #$0,(DrawXorMask).l             ; 00296
        beq.b   l_036_002A4                     ; 0029E
        eor.w   d4,(a3)                         ; 002A0
        moveq   #-1,d0                          ; 002A2
l_036_002A4:
        btst    #$1,(DrawXorMask).l             ; 002A4
        beq.b   l_036_002B2                     ; 002AC
        eor.w   d5,(a2)                         ; 002AE
        moveq   #-1,d0                          ; 002B0
l_036_002B2:
        btst    #$2,(DrawXorMask).l             ; 002B2
        beq.b   l_036_002C0                     ; 002BA
        eor.w   d6,(a1)                         ; 002BC
        moveq   #-1,d0                          ; 002BE
l_036_002C0:
        btst    #$3,(DrawXorMask).l             ; 002C0
        beq.b   l_036_002CE                     ; 002C8
        eor.w   d7,(a0)                         ; 002CA
        moveq   #-1,d0                          ; 002CC
l_036_002CE:
        tst.l   d0                              ; 002CE
        bpl.b   l_036_002D4                     ; 002D0
        rts                                     ; 002D2
l_036_002D4:
        jmp     (a4)                            ; 002D4
; PixelMasks - The 16 one-pixel masks ($8000 ... $0001).
PixelMasks:
	dc.b	$80,$00,$40,$00,$20,$00,$10,$00,$08,$00,$04,$00,$02,$00,$01,$00
	dc.b	$00,$80,$00,$40,$00,$20,$00,$10,$00,$08,$00,$04,$00,$02,$00,$01
; PlotColourWriters - The 16 colour writers for one pixel: each sets or clears the pixel in
; planes 0-3 for its colour.
PlotColourWriters:
        dc.l    ColourWriter0                   ; 002F6
        dc.l    ColourWriter1                   ; 002FA
        dc.l    ColourWriter2                   ; 002FE
        dc.l    ColourWriter3                   ; 00302
        dc.l    ColourWriter4                   ; 00306
        dc.l    ColourWriter5                   ; 0030A
        dc.l    ColourWriter6                   ; 0030E
        dc.l    ColourWriter7                   ; 00312
        dc.l    ColourWriter8                   ; 00316
        dc.l    ColourWriter9                   ; 0031A
        dc.l    ColourWriter10                  ; 0031E
        dc.l    ColourWriter11                  ; 00322
        dc.l    ColourWriter12                  ; 00326
        dc.l    ColourWriter13                  ; 0032A
        dc.l    ColourWriter14                  ; 0032E
        dc.l    ColourWriter15                  ; 00332

;-------------------------------------------------------------------------------
; PixelPairMasks - The 2-pixel masks ($C000, $6000 ... $0003) - data, though the first trace
; took its first words for instructions (they assemble to the same bytes).
;-------------------------------------------------------------------------------
PixelPairMasks:
        and.b   d0,d0                           ; 00336
        and.b   d0,d0                           ; 00338
        bra.w   h036+$333C                      ; 0033A
	dc.b	$18,$00,$0C,$00,$06,$00,$03,$00,$01,$80,$00,$C0,$00,$60,$00,$30
	dc.b	$00,$18,$00,$0C,$00,$06,$00,$03
; BigColourWriters - The 16 colour writers for a big point.
BigColourWriters:
        dc.l    BigColourWriter0                ; 00356
        dc.l    BigColourWriter1                ; 0035A
        dc.l    BigColourWriter2                ; 0035E
        dc.l    BigColourWriter3                ; 00362
        dc.l    BigColourWriter4                ; 00366
        dc.l    BigColourWriter5                ; 0036A
        dc.l    BigColourWriter6                ; 0036E
        dc.l    BigColourWriter7                ; 00372
        dc.l    BigColourWriter8                ; 00376
        dc.l    BigColourWriter9                ; 0037A
        dc.l    BigColourWriter10               ; 0037E
        dc.l    BigColourWriter11               ; 00382
        dc.l    BigColourWriter12               ; 00386
        dc.l    BigColourWriter13               ; 0038A
        dc.l    BigColourWriter14               ; 0038E
        dc.l    BigColourWriter15               ; 00392
ColourWriter0:
        and.w   d0,(a3)                         ; 00396
        and.w   d1,(a2)                         ; 00398
        and.w   d2,(a1)                         ; 0039A
        and.w   d3,(a0)                         ; 0039C
        rts                                     ; 0039E

;-------------------------------------------------------------------------------
; XorWriter - The XOR writer for one pixel (DrawXor): flips the pixel in each plane.
;-------------------------------------------------------------------------------
XorWriter:
        eor.w   d4,(a3)                         ; 003A0
        eor.w   d5,(a2)                         ; 003A2
        eor.w   d6,(a1)                         ; 003A4
        eor.w   d7,(a0)                         ; 003A6
        rts                                     ; 003A8
ColourWriter1:
        or.w    d4,(a3)                         ; 003AA
        and.w   d1,(a2)                         ; 003AC
        and.w   d2,(a1)                         ; 003AE
        and.w   d3,(a0)                         ; 003B0
        rts                                     ; 003B2
ColourWriter2:
        and.w   d0,(a3)                         ; 003B4
        or.w    d5,(a2)                         ; 003B6
        and.w   d2,(a1)                         ; 003B8
        and.w   d3,(a0)                         ; 003BA
        rts                                     ; 003BC
ColourWriter3:
        or.w    d4,(a3)                         ; 003BE
        or.w    d5,(a2)                         ; 003C0
        and.w   d2,(a1)                         ; 003C2
        and.w   d3,(a0)                         ; 003C4
        rts                                     ; 003C6
ColourWriter4:
        and.w   d0,(a3)                         ; 003C8
        and.w   d1,(a2)                         ; 003CA
        or.w    d6,(a1)                         ; 003CC
        and.w   d3,(a0)                         ; 003CE
        rts                                     ; 003D0
ColourWriter5:
        or.w    d4,(a3)                         ; 003D2
        and.w   d1,(a2)                         ; 003D4
        or.w    d6,(a1)                         ; 003D6
        and.w   d3,(a0)                         ; 003D8
        rts                                     ; 003DA
ColourWriter6:
        and.w   d0,(a3)                         ; 003DC
        or.w    d5,(a2)                         ; 003DE
        or.w    d6,(a1)                         ; 003E0
        and.w   d3,(a0)                         ; 003E2
        rts                                     ; 003E4
ColourWriter7:
        or.w    d4,(a3)                         ; 003E6
        or.w    d5,(a2)                         ; 003E8
        or.w    d6,(a1)                         ; 003EA
        and.w   d3,(a0)                         ; 003EC
        rts                                     ; 003EE
ColourWriter8:
        and.w   d0,(a3)                         ; 003F0
        and.w   d1,(a2)                         ; 003F2
        and.w   d2,(a1)                         ; 003F4
        or.w    d7,(a0)                         ; 003F6
        rts                                     ; 003F8
ColourWriter9:
        or.w    d4,(a3)                         ; 003FA
        and.w   d1,(a2)                         ; 003FC
        and.w   d2,(a1)                         ; 003FE
        or.w    d7,(a0)                         ; 00400
        rts                                     ; 00402
ColourWriter10:
        and.w   d0,(a3)                         ; 00404
        or.w    d5,(a2)                         ; 00406
        and.w   d2,(a1)                         ; 00408
        or.w    d7,(a0)                         ; 0040A
        rts                                     ; 0040C
ColourWriter11:
        or.w    d4,(a3)                         ; 0040E
        or.w    d5,(a2)                         ; 00410
        and.w   d2,(a1)                         ; 00412
        or.w    d7,(a0)                         ; 00414
        rts                                     ; 00416
ColourWriter12:
        and.w   d0,(a3)                         ; 00418
        and.w   d1,(a2)                         ; 0041A
        or.w    d6,(a1)                         ; 0041C
        or.w    d7,(a0)                         ; 0041E
        rts                                     ; 00420
ColourWriter13:
        or.w    d4,(a3)                         ; 00422
        and.w   d1,(a2)                         ; 00424
        or.w    d6,(a1)                         ; 00426
        or.w    d7,(a0)                         ; 00428
        rts                                     ; 0042A
ColourWriter14:
        and.w   d0,(a3)                         ; 0042C
        or.w    d5,(a2)                         ; 0042E
        or.w    d6,(a1)                         ; 00430
        or.w    d7,(a0)                         ; 00432
        rts                                     ; 00434
ColourWriter15:
        or.w    d4,(a3)                         ; 00436
        or.w    d5,(a2)                         ; 00438
        or.w    d6,(a1)                         ; 0043A
        or.w    d7,(a0)                         ; 0043C
        rts                                     ; 0043E
BigColourWriter0:
        and.w   d0,(a3)                         ; 00440
        and.w   d0,$28(a3)                      ; 00442
        and.w   d1,(a2)                         ; 00446
        and.w   d1,$28(a2)                      ; 00448
        and.w   d2,(a1)                         ; 0044C
        and.w   d2,$28(a1)                      ; 0044E
        and.w   d3,(a0)                         ; 00452
        and.w   d3,$28(a0)                      ; 00454
        rts                                     ; 00458
BigColourWriter1:
        or.w    d4,(a3)                         ; 0045A
        or.w    d4,$28(a3)                      ; 0045C
        and.w   d1,(a2)                         ; 00460
        and.w   d1,$28(a2)                      ; 00462
        and.w   d2,(a1)                         ; 00466
        and.w   d2,$28(a1)                      ; 00468
        and.w   d3,(a0)                         ; 0046C
        and.w   d3,$28(a0)                      ; 0046E
        rts                                     ; 00472
BigColourWriter2:
        and.w   d0,(a3)                         ; 00474
        and.w   d0,$28(a3)                      ; 00476
        or.w    d5,(a2)                         ; 0047A
        or.w    d5,$28(a2)                      ; 0047C
        and.w   d2,(a1)                         ; 00480
        and.w   d2,$28(a1)                      ; 00482
        and.w   d3,(a0)                         ; 00486
        and.w   d3,$28(a0)                      ; 00488
        rts                                     ; 0048C
BigColourWriter3:
        or.w    d4,(a3)                         ; 0048E
        or.w    d4,$28(a3)                      ; 00490
        or.w    d5,(a2)                         ; 00494
        or.w    d5,$28(a2)                      ; 00496
        and.w   d2,(a1)                         ; 0049A
        and.w   d2,$28(a1)                      ; 0049C
        and.w   d3,(a0)                         ; 004A0
        and.w   d3,$28(a0)                      ; 004A2
        rts                                     ; 004A6
BigColourWriter4:
        and.w   d0,(a3)                         ; 004A8
        and.w   d0,$28(a3)                      ; 004AA
        and.w   d1,(a2)                         ; 004AE
        and.w   d1,$28(a2)                      ; 004B0
        or.w    d6,(a1)                         ; 004B4
        or.w    d6,$28(a1)                      ; 004B6
        and.w   d3,(a0)                         ; 004BA
        and.w   d3,$28(a0)                      ; 004BC
        rts                                     ; 004C0
BigColourWriter5:
        or.w    d4,(a3)                         ; 004C2
        or.w    d4,$28(a3)                      ; 004C4
        and.w   d1,(a2)                         ; 004C8
        and.w   d1,$28(a2)                      ; 004CA
        or.w    d6,(a1)                         ; 004CE
        or.w    d6,$28(a1)                      ; 004D0
        and.w   d3,(a0)                         ; 004D4
        and.w   d3,$28(a0)                      ; 004D6
        rts                                     ; 004DA
BigColourWriter6:
        and.w   d0,(a3)                         ; 004DC
        and.w   d0,$28(a3)                      ; 004DE
        or.w    d5,(a2)                         ; 004E2
        or.w    d5,$28(a2)                      ; 004E4
        or.w    d6,(a1)                         ; 004E8
        or.w    d6,$28(a1)                      ; 004EA
        and.w   d3,(a0)                         ; 004EE
        and.w   d3,$28(a0)                      ; 004F0
        rts                                     ; 004F4
BigColourWriter7:
        or.w    d4,(a3)                         ; 004F6
        or.w    d4,$28(a3)                      ; 004F8
        or.w    d5,(a2)                         ; 004FC
        or.w    d5,$28(a2)                      ; 004FE
        or.w    d6,(a1)                         ; 00502
        or.w    d6,$28(a1)                      ; 00504
        and.w   d3,(a0)                         ; 00508
        and.w   d3,$28(a0)                      ; 0050A
        rts                                     ; 0050E
BigColourWriter8:
        and.w   d0,(a3)                         ; 00510
        and.w   d0,$28(a3)                      ; 00512
        and.w   d1,(a2)                         ; 00516
        and.w   d1,$28(a2)                      ; 00518
        and.w   d2,(a1)                         ; 0051C
        and.w   d2,$28(a1)                      ; 0051E
        or.w    d7,(a0)                         ; 00522
        or.w    d7,$28(a0)                      ; 00524
        rts                                     ; 00528
BigColourWriter9:
        or.w    d4,(a3)                         ; 0052A
        or.w    d4,$28(a3)                      ; 0052C
        and.w   d1,(a2)                         ; 00530
        and.w   d1,$28(a2)                      ; 00532
        and.w   d2,(a1)                         ; 00536
        and.w   d2,$28(a1)                      ; 00538
        or.w    d7,(a0)                         ; 0053C
        or.w    d7,$28(a0)                      ; 0053E
        rts                                     ; 00542
BigColourWriter10:
        and.w   d0,(a3)                         ; 00544
        and.w   d0,$28(a3)                      ; 00546
        or.w    d5,(a2)                         ; 0054A
        or.w    d5,$28(a2)                      ; 0054C
        and.w   d2,(a1)                         ; 00550
        and.w   d2,$28(a1)                      ; 00552
        or.w    d7,(a0)                         ; 00556
        or.w    d7,$28(a0)                      ; 00558
        rts                                     ; 0055C
BigColourWriter11:
        or.w    d4,(a3)                         ; 0055E
        or.w    d4,$28(a3)                      ; 00560
        or.w    d5,(a2)                         ; 00564
        or.w    d5,$28(a2)                      ; 00566
        and.w   d2,(a1)                         ; 0056A
        and.w   d2,$28(a1)                      ; 0056C
        or.w    d7,(a0)                         ; 00570
        or.w    d7,$28(a0)                      ; 00572
        rts                                     ; 00576
BigColourWriter12:
        and.w   d0,(a3)                         ; 00578
        and.w   d0,$28(a3)                      ; 0057A
        and.w   d1,(a2)                         ; 0057E
        and.w   d1,$28(a2)                      ; 00580
        or.w    d6,(a1)                         ; 00584
        or.w    d6,$28(a1)                      ; 00586
        or.w    d7,(a0)                         ; 0058A
        or.w    d7,$28(a0)                      ; 0058C
        rts                                     ; 00590
BigColourWriter13:
        or.w    d4,(a3)                         ; 00592
        or.w    d4,$28(a3)                      ; 00594
        and.w   d1,(a2)                         ; 00598
        and.w   d1,$28(a2)                      ; 0059A
        or.w    d6,(a1)                         ; 0059E
        or.w    d6,$28(a1)                      ; 005A0
        or.w    d7,(a0)                         ; 005A4
        or.w    d7,$28(a0)                      ; 005A6
        rts                                     ; 005AA
BigColourWriter14:
        and.w   d0,(a3)                         ; 005AC
        and.w   d0,$28(a3)                      ; 005AE
        or.w    d5,(a2)                         ; 005B2
        or.w    d5,$28(a2)                      ; 005B4
        or.w    d6,(a1)                         ; 005B8
        or.w    d6,$28(a1)                      ; 005BA
        or.w    d7,(a0)                         ; 005BE
        or.w    d7,$28(a0)                      ; 005C0
        rts                                     ; 005C4
BigColourWriter15:
        or.w    d4,(a3)                         ; 005C6
        or.w    d4,$28(a3)                      ; 005C8
        or.w    d5,(a2)                         ; 005CC
        or.w    d5,$28(a2)                      ; 005CE
        or.w    d6,(a1)                         ; 005D2
        or.w    d6,$28(a1)                      ; 005D4
        or.w    d7,(a0)                         ; 005D8
        or.w    d7,$28(a0)                      ; 005DA
        rts                                     ; 005DE
l_036_005E0:
        addq.w  #$1,d1                          ; 005E0
        addq.w  #$1,d3                          ; 005E2
        clr.w   d5                              ; 005E4
        bra.b   l_036_0060C                     ; 005E6

;-------------------------------------------------------------------------------
; DrawLine199 - DrawLine with the bottom limit at row 199.
;-------------------------------------------------------------------------------
DrawLine199:
        movea.w #$c7,a2                         ; 005E8
        bra.b   l_036_005F4                     ; 005EC

;-------------------------------------------------------------------------------
; DrawLine - Draws a line with the blitter in line mode, plane by plane in the current colour
; (BLTADAT $8000, a pattern in BLTBDAT, the octant in BLTCON1; 40-byte rows).
;-------------------------------------------------------------------------------
DrawLine:
        movea.w (ClipY).l,a2                    ; 005EE
l_036_005F4:
        move.w  (DrawColour).l,(ColourBits).l   ; 005F4
        cmp.w   d1,d3                           ; 005FE
        beq.b   l_036_005E0                     ; 00600
        bls.b   l_036_0062A                     ; 00602
        move.w  d3,d5                           ; 00604
        sub.w   d1,d5                           ; 00606
        subq.w  #$1,d5                          ; 00608
        addq.w  #$1,d1                          ; 0060A
l_036_0060C:
        cmp.w   a2,d1                           ; 0060C
        bgt.b   l_036_00628                     ; 0060E
        movea.w d1,a1                           ; 00610
        asl.w   #$3,d1                          ; 00612
        move.w  d1,d7                           ; 00614
        add.w   d7,d7                           ; 00616
        add.w   d7,d7                           ; 00618
        add.w   d1,d7                           ; 0061A
        move.w  d2,d4                           ; 0061C
        sub.w   d0,d4                           ; 0061E
        move.w  d0,d6                           ; 00620
        lsr.w   #$3,d0                          ; 00622
        add.w   d0,d7                           ; 00624
        bra.b   l_036_0064C                     ; 00626
l_036_00628:
        rts                                     ; 00628
l_036_0062A:
        move.w  d1,d5                           ; 0062A
        sub.w   d3,d5                           ; 0062C
        subq.w  #$1,d5                          ; 0062E
        move.w  d0,d4                           ; 00630
        sub.w   d2,d4                           ; 00632
        addq.w  #$1,d3                          ; 00634
        cmp.w   a2,d3                           ; 00636
        bgt.b   l_036_00628                     ; 00638
        movea.w d3,a1                           ; 0063A
        asl.w   #$3,d3                          ; 0063C
        move.w  d3,d7                           ; 0063E
        add.w   d7,d7                           ; 00640
        add.w   d7,d7                           ; 00642
        add.w   d3,d7                           ; 00644
        move.w  d2,d6                           ; 00646
        lsr.w   #$3,d2                          ; 00648
        add.w   d2,d7                           ; 0064A
l_036_0064C:
        ext.l   d7                              ; 0064C
        moveq   #$1,d1                          ; 0064E
        andi.w  #$f,d6                          ; 00650
        ror.w   #$4,d6                          ; 00654
        addi.w  #$b00,d6                        ; 00656
        tst.w   d4                              ; 0065A
        bmi.b   l_036_00668                     ; 0065C
        cmp.w   d5,d4                           ; 0065E
        bcs.b   l_036_00692                     ; 00660
        addi.w  #$10,d1                         ; 00662
        bra.b   l_036_00672                     ; 00666
l_036_00668:
        neg.w   d4                              ; 00668
        cmp.w   d5,d4                           ; 0066A
        bcs.b   l_036_00690                     ; 0066C
        addi.w  #$14,d1                         ; 0066E
l_036_00672:
        suba.w  a1,a2                           ; 00672
        cmp.w   a2,d5                           ; 00674
        ble.b   l_036_0068C                     ; 00676
        move.w  a2,d2                           ; 00678
        move.w  d4,d3                           ; 0067A
        muls.w  d2,d3                           ; 0067C
        add.l   d3,d3                           ; 0067E
        divs.w  d5,d3                           ; 00680
        asr.w   #$1,d3                          ; 00682
        bcc.b   l_036_00688                     ; 00684
        addq.w  #$1,d3                          ; 00686
l_036_00688:
        movea.w d3,a2                           ; 00688
        bra.b   l_036_0069C                     ; 0068A
l_036_0068C:
        movea.w d4,a2                           ; 0068C
        bra.b   l_036_0069C                     ; 0068E
l_036_00690:
        addq.w  #$8,d1                          ; 00690
l_036_00692:
        exg.l   d4,d5                           ; 00692
        suba.w  a1,a2                           ; 00694
        cmp.w   a2,d4                           ; 00696
        bgt.b   l_036_0069C                     ; 00698
        movea.w d4,a2                           ; 0069A
l_036_0069C:
        add.w   d5,d5                           ; 0069C
        add.w   d5,d5                           ; 0069E
        add.w   d4,d4                           ; 006A0
        move.w  d5,d2                           ; 006A2
        sub.w   d4,d2                           ; 006A4
        bge.b   l_036_006AC                     ; 006A6
        bset    #$6,d1                          ; 006A8
l_036_006AC:
        move.w  d5,d3                           ; 006AC
        add.w   d4,d4                           ; 006AE
        sub.w   d4,d5                           ; 006B0
        move.w  a2,d4                           ; 006B2
        asl.w   #$6,d4                          ; 006B4
        addi.w  #$42,d4                         ; 006B6
        moveq   #-1,d0                          ; 006BA
        movea.w d5,a3                           ; 006BC
        lea.l   (CUSTOM).l,a0                    ; 006BE
l_036_006C4:
        btst    #$6,DMACONR(a0)                 ; 006C4
        beq.b   l_036_006D2                     ; 006CA
        nop                                     ; 006CC
        nop                                     ; 006CE
        bra.b   l_036_006C4                     ; 006D0
l_036_006D2:
        move.w  a3,BLTAMOD(a0)                  ; 006D2
        move.w  #$28,BLTDMOD(a0)                ; 006D6
        move.w  #$28,BLTCMOD(a0)                ; 006DC
        move.l  d0,BLTAFWM(a0)                  ; 006E2
        move.w  d0,BLTBDAT(a0)                  ; 006E6
        movea.l (DrawPlanes).l,a2               ; 006EA
        movea.l d7,a1                           ; 006F0
        btst    #$0,(DrawMask).l                ; 006F2
        beq.b   l_036_0075A                     ; 006FA
        move.w  d6,d5                           ; 006FC
        tst.w   (DrawXor).l                     ; 006FE
        blt.b   l_036_00710                     ; 00704
        btst    #$0,(dat_071_000B9).l           ; 00706
        bra.b   l_036_00718                     ; 0070E
l_036_00710:
        btst    #$0,(dat_071_00327).l           ; 00710
l_036_00718:
        beq.b   l_036_00720                     ; 00718
        addi.w  #$fa,d5                         ; 0071A
        bra.b   l_036_00724                     ; 0071E
l_036_00720:
        addi.w  #$a,d5                          ; 00720
l_036_00724:
        move.l  $c(a2),d7                       ; 00724
        add.l   a1,d7                           ; 00728
l_036_0072A:
        btst    #$6,DMACONR(a0)                 ; 0072A
        beq.b   l_036_00738                     ; 00730
        nop                                     ; 00732
        nop                                     ; 00734
        bra.b   l_036_0072A                     ; 00736
l_036_00738:
        move.w  d5,BLTCON0(a0)                  ; 00738
        move.w  d1,BLTCON1(a0)                  ; 0073C
        move.w  d2,BLTAPTL(a0)                  ; 00740
        move.l  d7,BLTCPTH(a0)                  ; 00744
        move.l  d7,BLTDPTH(a0)                  ; 00748
        move.w  #$8000,BLTADAT(a0)              ; 0074C
        move.w  d3,BLTBMOD(a0)                  ; 00752
        move.w  d4,BLTSIZE(a0)                  ; 00756
l_036_0075A:
        btst    #$1,(DrawMask).l                ; 0075A
        beq.b   l_036_007C2                     ; 00762
        move.w  d6,d5                           ; 00764
        tst.w   (DrawXor).l                     ; 00766
        blt.b   l_036_00778                     ; 0076C
        btst    #$1,(dat_071_000B9).l           ; 0076E
        bra.b   l_036_00780                     ; 00776
l_036_00778:
        btst    #$1,(dat_071_00327).l           ; 00778
l_036_00780:
        beq.b   l_036_00788                     ; 00780
        addi.w  #$fa,d5                         ; 00782
        bra.b   l_036_0078C                     ; 00786
l_036_00788:
        addi.w  #$a,d5                          ; 00788
l_036_0078C:
        move.l  $8(a2),d7                       ; 0078C
        add.l   a1,d7                           ; 00790
l_036_00792:
        btst    #$6,DMACONR(a0)                 ; 00792
        beq.b   l_036_007A0                     ; 00798
        nop                                     ; 0079A
        nop                                     ; 0079C
        bra.b   l_036_00792                     ; 0079E
l_036_007A0:
        move.w  d5,BLTCON0(a0)                  ; 007A0
        move.w  d1,BLTCON1(a0)                  ; 007A4
        move.w  d2,BLTAPTL(a0)                  ; 007A8
        move.l  d7,BLTCPTH(a0)                  ; 007AC
        move.l  d7,BLTDPTH(a0)                  ; 007B0
        move.w  #$8000,BLTADAT(a0)              ; 007B4
        move.w  d3,BLTBMOD(a0)                  ; 007BA
        move.w  d4,BLTSIZE(a0)                  ; 007BE
l_036_007C2:
        btst    #$2,(DrawMask).l                ; 007C2
        beq.b   l_036_0082A                     ; 007CA
        move.w  d6,d5                           ; 007CC
        tst.w   (DrawXor).l                     ; 007CE
        blt.b   l_036_007E0                     ; 007D4
        btst    #$2,(dat_071_000B9).l           ; 007D6
        bra.b   l_036_007E8                     ; 007DE
l_036_007E0:
        btst    #$2,(dat_071_00327).l           ; 007E0
l_036_007E8:
        beq.b   l_036_007F0                     ; 007E8
        addi.w  #$fa,d5                         ; 007EA
        bra.b   l_036_007F4                     ; 007EE
l_036_007F0:
        addi.w  #$a,d5                          ; 007F0
l_036_007F4:
        move.l  $4(a2),d7                       ; 007F4
        add.l   a1,d7                           ; 007F8
l_036_007FA:
        btst    #$6,DMACONR(a0)                 ; 007FA
        beq.b   l_036_00808                     ; 00800
        nop                                     ; 00802
        nop                                     ; 00804
        bra.b   l_036_007FA                     ; 00806
l_036_00808:
        move.w  d5,BLTCON0(a0)                  ; 00808
        move.w  d1,BLTCON1(a0)                  ; 0080C
        move.w  d2,BLTAPTL(a0)                  ; 00810
        move.l  d7,BLTCPTH(a0)                  ; 00814
        move.l  d7,BLTDPTH(a0)                  ; 00818
        move.w  #$8000,BLTADAT(a0)              ; 0081C
        move.w  d3,BLTBMOD(a0)                  ; 00822
        move.w  d4,BLTSIZE(a0)                  ; 00826
l_036_0082A:
        btst    #$3,(DrawMask).l                ; 0082A
        beq.b   l_036_00890                     ; 00832
        move.w  d6,d5                           ; 00834
        tst.w   (DrawXor).l                     ; 00836
        blt.b   l_036_00848                     ; 0083C
        btst    #$3,(dat_071_000B9).l           ; 0083E
        bra.b   l_036_00850                     ; 00846
l_036_00848:
        btst    #$3,(dat_071_00327).l           ; 00848
l_036_00850:
        beq.b   l_036_00858                     ; 00850
        addi.w  #$fa,d5                         ; 00852
        bra.b   l_036_0085C                     ; 00856
l_036_00858:
        addi.w  #$a,d5                          ; 00858
l_036_0085C:
        move.l  (a2),d7                         ; 0085C
        add.l   a1,d7                           ; 0085E
l_036_00860:
        btst    #$6,DMACONR(a0)                 ; 00860
        beq.b   l_036_0086E                     ; 00866
        nop                                     ; 00868
        nop                                     ; 0086A
        bra.b   l_036_00860                     ; 0086C
l_036_0086E:
        move.w  d5,BLTCON0(a0)                  ; 0086E
        move.w  d1,BLTCON1(a0)                  ; 00872
        move.w  d2,BLTAPTL(a0)                  ; 00876
        move.l  d7,BLTCPTH(a0)                  ; 0087A
        move.l  d7,BLTDPTH(a0)                  ; 0087E
        move.w  #$8000,BLTADAT(a0)              ; 00882
        move.w  d3,BLTBMOD(a0)                  ; 00888
        move.w  d4,BLTSIZE(a0)                  ; 0088C
l_036_00890:
        rts                                     ; 00890

;-------------------------------------------------------------------------------
; ClearScreen - Clears the drawing planes.
;-------------------------------------------------------------------------------
ClearScreen:
        movea.l (Buffer1Plane0).l,a0            ; 00892
        movea.l (Buffer1Plane1).l,a1            ; 00898
        movea.l (Buffer1Plane2).l,a2            ; 0089E
        movea.l (Buffer1Plane3).l,a3            ; 008A4
        movea.l (Buffer1Plane4).l,a4            ; 008AA
        move.w  #$7cf,d0                        ; 008B0
l_036_008B4:
        clr.l   (a0)+                           ; 008B4
        clr.l   (a1)+                           ; 008B6
        clr.l   (a2)+                           ; 008B8
        clr.l   (a3)+                           ; 008BA
        tst.b   (dat_071_001A6).l               ; 008BC
        beq.b   l_036_008C6                     ; 008C2
        clr.l   (a4)+                           ; 008C4
l_036_008C6:
        dbra    d0,l_036_008B4                  ; 008C6
        movea.l (Buffer2Plane0).l,a0            ; 008CA
        movea.l (Buffer2Plane1).l,a1            ; 008D0
        movea.l (Buffer2Plane2).l,a2            ; 008D6
        movea.l (Buffer2Plane3).l,a3            ; 008DC
        movea.l (FillPlane).l,a5                ; 008E2
        move.w  #$7cf,d0                        ; 008E8
l_036_008EC:
        clr.l   (a0)+                           ; 008EC
        clr.l   (a1)+                           ; 008EE
        clr.l   (a2)+                           ; 008F0
        clr.l   (a3)+                           ; 008F2
        clr.l   (a5)+                           ; 008F4
        dbra    d0,l_036_008EC                  ; 008F6
        rts                                     ; 008FA

;-------------------------------------------------------------------------------
; ClearSkyGround - Clears the 3D view (ClipY lines) by blitter to the ground
; colour - plane 2 set, planes 0 and 3 clear, plane 1 set when SeaView: colour 4 (green land)
; or 6 (sea) - then fills the sky polygon (MakeSkyPolygon) into plane 0, making it colour 5
; (the sky). Over the sea it also clears plane 1 under the sky (FillPolygonPlane,
; PlaneOpUnderFill) so the sky stays colour 5. In the cockpit view it keeps the panel's sky
; polygon (MakeSkyPolygonPanel) at PanelSkyPolygon for the attitude indicator.
;-------------------------------------------------------------------------------
ClearSkyGround:
        movea.l (DrawPlanes).l,a2               ; 008FC
        lea.l   (CUSTOM).l,a0                    ; 00902
        move.w  (ClipY).l,d6                    ; 00908
        asl.w   #$6,d6                          ; 0090E
        addi.w  #$14,d6                         ; 00910
        move.l  (a2),d4                         ; 00914
        addi.l  #$28,d4                         ; 00916
        move.w  #$100,d2                        ; 0091C
        moveq   #-1,d5                          ; 00920
l_036_00922:
        btst    #$6,DMACONR(a0)                 ; 00922
        beq.b   l_036_00930                     ; 00928
        nop                                     ; 0092A
        nop                                     ; 0092C
        bra.b   l_036_00922                     ; 0092E
l_036_00930:
        move.w  d2,BLTCON0(a0)                  ; 00930
        move.w  #$0,BLTCON1(a0)                 ; 00934
        move.w  d5,BLTADAT(a0)                  ; 0093A
        move.w  d5,BLTAFWM(a0)                  ; 0093E
        move.w  d5,BLTALWM(a0)                  ; 00942
        move.w  #$1,BLTBMOD(a0)                 ; 00946
        move.w  #$1,BLTCMOD(a0)                 ; 0094C
        move.w  #$1,BLTDMOD(a0)                 ; 00952
        move.l  d4,BLTCPTH(a0)                  ; 00958
        move.l  d4,BLTDPTH(a0)                  ; 0095C
        move.w  d6,BLTSIZE(a0)                  ; 00960
        move.l  $4(a2),d4                       ; 00964
        addi.l  #$28,d4                         ; 00968
        move.w  #$3fa,d2                        ; 0096E
l_036_00972:
        btst    #$6,DMACONR(a0)                 ; 00972
        beq.b   l_036_00982                     ; 00978
        addq.w  #$1,(dat_071_002EC).l           ; 0097A
        bra.b   l_036_00972                     ; 00980
l_036_00982:
        move.l  (dat_071_002EC).l,d0            ; 00982
        move.w  d0,d3                           ; 00988
        swap    d0                              ; 0098A
        cmp.w   d3,d0                           ; 0098C
        ble.b   l_036_00992                     ; 0098E
        move.w  d0,d3                           ; 00990
l_036_00992:
        clr.w   d0                              ; 00992
        swap    d0                              ; 00994
        move.w  d3,d0                           ; 00996
        move.l  d0,(dat_071_002EC).l            ; 00998
        move.w  d2,BLTCON0(a0)                  ; 0099E
        move.l  d4,BLTCPTH(a0)                  ; 009A2
        move.l  d4,BLTDPTH(a0)                  ; 009A6
        move.w  d6,BLTSIZE(a0)                  ; 009AA
        move.l  $8(a2),d4                       ; 009AE
        addi.l  #$28,d4                         ; 009B2
        move.w  #$100,d2                        ; 009B8
        tst.b   (SeaView).l                     ; 009BC
        beq.b   l_036_009C8                     ; 009C2
        move.w  #$3fa,d2                        ; 009C4
l_036_009C8:
        btst    #$6,DMACONR(a0)                 ; 009C8
        beq.b   l_036_009D8                     ; 009CE
        addq.w  #$1,(dat_071_002F0).l           ; 009D0
        bra.b   l_036_009C8                     ; 009D6
l_036_009D8:
        move.l  (dat_071_002F0).l,d0            ; 009D8
        move.w  d0,d3                           ; 009DE
        swap    d0                              ; 009E0
        cmp.w   d3,d0                           ; 009E2
        ble.b   l_036_009E8                     ; 009E4
        move.w  d0,d3                           ; 009E6
l_036_009E8:
        clr.w   d0                              ; 009E8
        swap    d0                              ; 009EA
        move.w  d3,d0                           ; 009EC
        move.l  d0,(dat_071_002F0).l            ; 009EE
        move.w  d2,BLTCON0(a0)                  ; 009F4
        move.l  d4,BLTCPTH(a0)                  ; 009F8
        move.l  d4,BLTDPTH(a0)                  ; 009FC
        move.w  d6,BLTSIZE(a0)                  ; 00A00
        move.l  $c(a2),d4                       ; 00A04
        addi.l  #$28,d4                         ; 00A08
        move.w  #$100,d2                        ; 00A0E
l_036_00A12:
        btst    #$6,DMACONR(a0)                 ; 00A12
        beq.b   l_036_00A22                     ; 00A18
        addq.w  #$1,(dat_071_002F4).l           ; 00A1A
        bra.b   l_036_00A12                     ; 00A20
l_036_00A22:
        move.l  (dat_071_002F4).l,d0            ; 00A22
        move.w  d0,d3                           ; 00A28
        swap    d0                              ; 00A2A
        cmp.w   d3,d0                           ; 00A2C
        ble.b   l_036_00A32                     ; 00A2E
        move.w  d0,d3                           ; 00A30
l_036_00A32:
        clr.w   d0                              ; 00A32
        swap    d0                              ; 00A34
        move.w  d3,d0                           ; 00A36
        move.l  d0,(dat_071_002F4).l            ; 00A38
        move.w  d2,BLTCON0(a0)                  ; 00A3E
        move.l  d4,BLTCPTH(a0)                  ; 00A42
        move.l  d4,BLTDPTH(a0)                  ; 00A46
        move.w  d6,BLTSIZE(a0)                  ; 00A4A
        move.l  (FillPlane).l,-(a7)             ; 00A4E
        move.l  $c(a2),(FillPlane).l            ; 00A54
        jsr     (MakeSkyPolygon).l              ; 00A5C
        bne.b   l_036_00A7C                     ; 00A62
        bsr.w   FillPolygonPlane                ; 00A64
        bne.b   l_036_00A7C                     ; 00A68
        tst.b   (SeaView).l                     ; 00A6A
        beq.b   l_036_00A7C                     ; 00A70
        moveq   #$8,d0                          ; 00A72
        moveq   #$0,d3                          ; 00A74
        moveq   #$0,d4                          ; 00A76
        bsr.w   PlaneOpUnderFill                ; 00A78
l_036_00A7C:
        move.l  (a7)+,(FillPlane).l             ; 00A7C
        tst.b   (OutsideView).l                 ; 00A82
        bne.b   l_036_00AAC                     ; 00A88
        jsr     (MakeSkyPolygonPanel).l         ; 00A8A
        bne.b   l_036_00AAC                     ; 00A90
        lea.l   (dat_072_03000).l,a0            ; 00A92
        lea.l   (PanelSkyPolygon).l,a4          ; 00A98
        move.w  (a0)+,(a4)+                     ; 00A9E
        move.l  (a0)+,(a4)+                     ; 00AA0
        move.l  (a0)+,(a4)+                     ; 00AA2
        move.l  (a0)+,(a4)+                     ; 00AA4
        move.l  (a0)+,(a4)+                     ; 00AA6
        move.l  (a0)+,(a4)+                     ; 00AA8
        rts                                     ; 00AAA
l_036_00AAC:
        move.w  #$0,(PanelSkyPolygon).l         ; 00AAC
        rts                                     ; 00AB4
l_036_00AB6:
        rts                                     ; 00AB6

;-------------------------------------------------------------------------------
; FillPolygon - Fills the polygon at dat_072_03000 in DrawColour: the edges and the area fill
; into one plane (FillPolygonPlane), then each plane of the colour set or cleared from it (or a
; patterned fill, FillPatterned). The 2D fill under ClipFillPolygon.
;-------------------------------------------------------------------------------
FillPolygon:
        nop                                     ; 00AB8
        move.w  #$8400,(CUSTOM+DMACON).l        ; 00ABA
        bsr.w   FillPolygonPlane                ; 00AC2
        bne.b   l_036_00AB6                     ; 00AC6
        tst.w   (DrawXor).l                     ; 00AC8
        blt.b   l_036_00AE0                     ; 00ACE
        move.w  (dat_071_000BC).l,d5            ; 00AD0
        beq.b   l_036_00AE0                     ; 00AD6
        bsr.w   FillPatterned                   ; 00AD8
        bra.w   l_036_00B9A                     ; 00ADC
l_036_00AE0:
        btst    #$0,(DrawMask).l                ; 00AE0
        beq.b   l_036_00B06                     ; 00AE8
        moveq   #$c,d0                          ; 00AEA
        move.w  (FillPattern2).l,d4             ; 00AEC
        move.w  (DrawXor).l,d3                  ; 00AF2
        bge.b   l_036_00B00                     ; 00AF8
        move.w  (ColourBits).l,d3               ; 00AFA
l_036_00B00:
        bsr.w   PlaneOpUnderFill                ; 00B00
        bra.b   l_036_00B0C                     ; 00B04
l_036_00B06:
        lsr.w   (ColourBits).l                  ; 00B06
l_036_00B0C:
        btst    #$1,(DrawMask).l                ; 00B0C
        beq.b   l_036_00B38                     ; 00B14
        moveq   #$8,d0                          ; 00B16
        move.w  (DrawXor).l,d3                  ; 00B18
        blt.b   l_036_00B2C                     ; 00B1E
        move.w  (FillPattern2).l,d4             ; 00B20
        asr.w   #$1,d3                          ; 00B26
        asr.w   #$1,d4                          ; 00B28
        bra.b   l_036_00B32                     ; 00B2A
l_036_00B2C:
        move.w  (ColourBits).l,d3               ; 00B2C
l_036_00B32:
        bsr.w   PlaneOpUnderFill                ; 00B32
        bra.b   l_036_00B3E                     ; 00B36
l_036_00B38:
        lsr.w   (ColourBits).l                  ; 00B38
l_036_00B3E:
        btst    #$2,(DrawMask).l                ; 00B3E
        beq.b   l_036_00B6A                     ; 00B46
        moveq   #$4,d0                          ; 00B48
        move.w  (DrawXor).l,d3                  ; 00B4A
        blt.b   l_036_00B5E                     ; 00B50
        move.w  (FillPattern2).l,d4             ; 00B52
        asr.w   #$2,d3                          ; 00B58
        asr.w   #$2,d4                          ; 00B5A
        bra.b   l_036_00B64                     ; 00B5C
l_036_00B5E:
        move.w  (ColourBits).l,d3               ; 00B5E
l_036_00B64:
        bsr.w   PlaneOpUnderFill                ; 00B64
        bra.b   l_036_00B70                     ; 00B68
l_036_00B6A:
        lsr.w   (ColourBits).l                  ; 00B6A
l_036_00B70:
        btst    #$3,(DrawMask).l                ; 00B70
        beq.b   l_036_00B9A                     ; 00B78
        moveq   #$0,d0                          ; 00B7A
        move.w  (DrawXor).l,d3                  ; 00B7C
        blt.b   l_036_00B90                     ; 00B82
        move.w  (FillPattern2).l,d4             ; 00B84
        asr.w   #$3,d3                          ; 00B8A
        asr.w   #$3,d4                          ; 00B8C
        bra.b   l_036_00B96                     ; 00B8E
l_036_00B90:
        move.w  (ColourBits).l,d3               ; 00B90
l_036_00B96:
        bsr.w   PlaneOpUnderFill                ; 00B96
l_036_00B9A:
        bsr.w   ClearFillPlane                  ; 00B9A
        move.w  #$400,(CUSTOM+DMACON).l         ; 00B9E
        rts                                     ; 00BA6
l_036_00BA8:
        rts                                     ; 00BA8

;-------------------------------------------------------------------------------
; DrawPanelLamp - Blits one of the panel's lamps (at $1990, 2 words wide) on or off by the
; warning state; only when its place is on the screen.
;-------------------------------------------------------------------------------
DrawPanelLamp:
        move.w  #$c,d7                          ; 00BAA
        sub.w   (ViewShift).l,d7                ; 00BAE
        blt.b   l_036_00BA8                     ; 00BB4
        move.w  #$c,d7                          ; 00BB6
        addi.w  #$2,d7                          ; 00BBA
        neg.w   d7                              ; 00BBE
        addi.w  #$14,d7                         ; 00BC0
        sub.w   (ViewShift).l,d7                ; 00BC4
        blt.b   l_036_00BA8                     ; 00BCA
        move.l  #$1990,d1                       ; 00BCC
        movea.w #$2,a4                          ; 00BD2
        move.w  #$542,d6                        ; 00BD6
        movea.w #$25,a5                         ; 00BDA
        move.w  #$c,d7                          ; 00BDE
        add.l   (PanelShakeOffset).l,d1         ; 00BE2
        jsr     (ClipPanelBlit).l               ; 00BE8
        blt.b   l_036_00BA8                     ; 00BEE
        tst.w   d5                              ; 00BF0
        beq.b   l_036_00BFA                     ; 00BF2
        move.w  #$ffff,d3                       ; 00BF4
        bra.b   l_036_00BFE                     ; 00BF8
l_036_00BFA:
        move.w  #$fff0,d3                       ; 00BFA
l_036_00BFE:
        tst.w   d7                              ; 00BFE
        beq.b   l_036_00C08                     ; 00C00
        move.w  #$ffff,d0                       ; 00C02
        bra.b   l_036_00C0C                     ; 00C06
l_036_00C08:
        move.w  #$fff,d0                        ; 00C08
l_036_00C0C:
        add.w   d7,d5                           ; 00C0C
        move.l  #dat_062_00100,d7               ; 00C0E
        movea.l (DrawPlanes).l,a2               ; 00C14
        move.l  $4(a2),d4                       ; 00C1A
        add.l   d1,d4                           ; 00C1E
        sub.w   d5,d6                           ; 00C20
        add.w   d5,d5                           ; 00C22
        add.w   a5,d5                           ; 00C24
        lea.l   (CUSTOM).l,a0                    ; 00C26
        move.w  #$722,d2                        ; 00C2C
l_036_00C30:
        btst    #$6,DMACONR(a0)                 ; 00C30
        beq.b   l_036_00C3E                     ; 00C36
        nop                                     ; 00C38
        nop                                     ; 00C3A
        bra.b   l_036_00C30                     ; 00C3C
l_036_00C3E:
        move.w  d2,BLTCON0(a0)                  ; 00C3E
        move.w  #$0,BLTCON1(a0)                 ; 00C42
        move.w  #$ffff,BLTADAT(a0)              ; 00C48
        move.w  d0,BLTAFWM(a0)                  ; 00C4E
        move.w  d3,BLTALWM(a0)                  ; 00C52
        move.w  #$1,BLTBMOD(a0)                 ; 00C56
        move.w  d5,BLTCMOD(a0)                  ; 00C5C
        move.w  d5,BLTDMOD(a0)                  ; 00C60
        move.l  d7,BLTBPTH(a0)                  ; 00C64
        move.l  d4,BLTCPTH(a0)                  ; 00C68
        move.l  d4,BLTDPTH(a0)                  ; 00C6C
        move.w  d6,BLTSIZE(a0)                  ; 00C70
        bsr.w   DrawAttitudeIndicator           ; 00C74
        move.l  #$7ffff,(FillPattern).l         ; 00C78
        move.w  #$cc,d0                         ; 00C82
        add.w   (ViewX).l,d0                    ; 00C86
        move.w  #$ac,d1                         ; 00C8C
        add.w   (ViewY).l,d1                    ; 00C90
        move.w  d0,d2                           ; 00C96
        addi.w  #$a,d2                          ; 00C98
        move.w  d1,d3                           ; 00C9C
        move.w  #$2,(DrawColour).l              ; 00C9E
        bsr.w   DrawLine199                     ; 00CA6
        move.w  #$d1,d0                         ; 00CAA
        move.w  #$ab,d1                         ; 00CAE
        bsr.w   PlotInView                      ; 00CB2
        move.w  #$ac,d1                         ; 00CB6
        bsr.w   Plot                            ; 00CBA
        move.w  #$d,(DrawColour).l              ; 00CBE
        move.w  #$ce,d0                         ; 00CC6
        move.w  #$a5,d1                         ; 00CCA
        bsr.w   PlotInView                      ; 00CCE
        subq.w  #$2,d0                          ; 00CD2
        addq.w  #$1,d1                          ; 00CD4
        bsr.w   PlotKeep                        ; 00CD6
        subq.w  #$1,d0                          ; 00CDA
        addq.w  #$1,d1                          ; 00CDC
        bsr.w   PlotKeep                        ; 00CDE
        subq.w  #$2,d0                          ; 00CE2
        addq.w  #$3,d1                          ; 00CE4
        bsr.w   PlotKeep                        ; 00CE6
        addi.w  #$11,d0                         ; 00CEA
        addq.w  #$1,d1                          ; 00CEE
        bsr.w   PlotKeep                        ; 00CF0
        addq.w  #$1,d1                          ; 00CF4
        bsr.w   PlotKeep                        ; 00CF6
        addq.w  #$1,d1                          ; 00CFA
        bsr.w   PlotKeep                        ; 00CFC
        subq.w  #$1,d0                          ; 00D00
        addq.w  #$2,d1                          ; 00D02
        bsr.w   PlotKeep                        ; 00D04
        rts                                     ; 00D08
l_036_00D0A:
        rts                                     ; 00D0A

;-------------------------------------------------------------------------------
; DrawAttitudeIndicator - Draws the panel's attitude indicator - the sky
; polygon kept by ClearSkyGround (PanelSkyPolygon), scaled into the instrument's box (x *
; 24/256 + $C1, y * 31/256 + $A2) and filled into plane 2.
;-------------------------------------------------------------------------------
DrawAttitudeIndicator:
        lea.l   (PanelSkyPolygon).l,a0          ; 00D0C
        lea.l   (dat_072_03000).l,a4            ; 00D12
        move.w  (a0)+,d7                        ; 00D18
        ble.b   l_036_00D0A                     ; 00D1A
        move.w  d7,(a4)+                        ; 00D1C
        subq.w  #$1,d7                          ; 00D1E
l_036_00D20:
        move.w  (a0)+,d0                        ; 00D20
        mulu.w  #$18,d0                         ; 00D22
        asr.l   #$8,d0                          ; 00D26
        addi.w  #$c1,d0                         ; 00D28
        add.w   (ViewX).l,d0                    ; 00D2C
        move.w  d0,(a4)+                        ; 00D32
        move.w  (a0)+,d0                        ; 00D34
        mulu.w  #$1f,d0                         ; 00D36
        asr.l   #$8,d0                          ; 00D3A
        addi.w  #$a2,d0                         ; 00D3C
        add.w   (ViewY).l,d0                    ; 00D40
        move.w  d0,(a4)+                        ; 00D46
        dbra    d7,l_036_00D20                  ; 00D48
        bsr.w   FillPolygonPanel                ; 00D4C
        bne.b   l_036_00D0A                     ; 00D50
        moveq   #$4,d0                          ; 00D52
        moveq   #$1,d3                          ; 00D54
        bsr.w   FillPanelPlane                  ; 00D56
        bsr.w   ClearFillPlane                  ; 00D5A
        rts                                     ; 00D5E

;-------------------------------------------------------------------------------
; FillPolygonPanel - FillPolygonPlane with the bottom limit at row $C7, for the attitude
; indicator.
;-------------------------------------------------------------------------------
FillPolygonPanel:
        movea.w #$c7,a4                         ; 00D60
        bra.b   l_036_00D6C                     ; 00D64

;-------------------------------------------------------------------------------
; FillPolygonPlane - Fills the polygon at dat_072_03000 (clipped to ClipY
; lines) into the one plane at FillPlane by blitter: finds its bounding box, draws its
; edges (DrawFillEdges) and area-fills the box in place (BLTCON1 $0A, descending inclusive
; fill). A polygon only a pixel or two across is plotted or drawn as a line instead. d0 = 0
; when the plane was filled (the box kept for PlaneOpUnderFill), 1 otherwise.
;-------------------------------------------------------------------------------
FillPolygonPlane:
        movea.w (ClipY).l,a4                    ; 00D66
l_036_00D6C:
        lea.l   (dat_072_03000).l,a0            ; 00D6C
        move.w  (a0)+,d6                        ; 00D72
        subq.w  #$3,d6                          ; 00D74
        movem.w (a0)+,d0-d5                     ; 00D76
        cmp.w   d0,d2                           ; 00D7A
        bge.b   l_036_00D80                     ; 00D7C
        exg.l   d0,d2                           ; 00D7E
l_036_00D80:
        cmp.w   d0,d4                           ; 00D80
        bge.b   l_036_00D88                     ; 00D82
        move.w  d4,d0                           ; 00D84
        bra.b   l_036_00D8E                     ; 00D86
l_036_00D88:
        cmp.w   d2,d4                           ; 00D88
        ble.b   l_036_00D8E                     ; 00D8A
        move.w  d4,d2                           ; 00D8C
l_036_00D8E:
        cmp.w   d1,d3                           ; 00D8E
        bge.b   l_036_00D94                     ; 00D90
        exg.l   d1,d3                           ; 00D92
l_036_00D94:
        cmp.w   d1,d5                           ; 00D94
        bge.b   l_036_00D9C                     ; 00D96
        move.w  d5,d1                           ; 00D98
        bra.b   l_036_00DA2                     ; 00D9A
l_036_00D9C:
        cmp.w   d3,d5                           ; 00D9C
        ble.b   l_036_00DA2                     ; 00D9E
        move.w  d5,d3                           ; 00DA0
l_036_00DA2:
        subq.w  #$1,d6                          ; 00DA2
        blt.b   l_036_00DCC                     ; 00DA4
        move.w  (a0)+,d4                        ; 00DA6
        move.w  (a0)+,d5                        ; 00DA8
        cmp.w   d0,d4                           ; 00DAA
        bgt.b   l_036_00DB2                     ; 00DAC
        move.w  d4,d0                           ; 00DAE
        bra.b   l_036_00DB8                     ; 00DB0
l_036_00DB2:
        cmp.w   d4,d2                           ; 00DB2
        bge.b   l_036_00DB8                     ; 00DB4
        move.w  d4,d2                           ; 00DB6
l_036_00DB8:
        cmp.w   d1,d5                           ; 00DB8
        bgt.b   l_036_00DC0                     ; 00DBA
        move.w  d5,d1                           ; 00DBC
        bra.b   l_036_00DA2                     ; 00DBE
l_036_00DC0:
        cmp.w   d5,d3                           ; 00DC0
        bge.b   l_036_00DA2                     ; 00DC2
        move.w  d5,d3                           ; 00DC4
        bra.b   l_036_00DA2                     ; 00DC6
l_036_00DC8:
        moveq   #$1,d0                          ; 00DC8
        rts                                     ; 00DCA
l_036_00DCC:
        cmp.w   a4,d1                           ; 00DCC
        bgt.b   l_036_00DC8                     ; 00DCE
        move.w  d3,d7                           ; 00DD0
        sub.w   d1,d7                           ; 00DD2
        bge.b   l_036_00DD8                     ; 00DD4
        neg.w   d7                              ; 00DD6
l_036_00DD8:
        cmpi.w  #$2,d7                          ; 00DD8
        bgt.b   l_036_00E4E                     ; 00DDC
        cmpi.w  #$1,d7                          ; 00DDE
        ble.b   l_036_00E00                     ; 00DE2
        move.w  d2,d6                           ; 00DE4
        sub.w   d0,d6                           ; 00DE6
        bge.b   l_036_00DEC                     ; 00DE8
        neg.w   d6                              ; 00DEA
l_036_00DEC:
        cmpi.w  #$2,d6                          ; 00DEC
        bgt.b   l_036_00E5C                     ; 00DF0
        addq.w  #$1,d1                          ; 00DF2
        cmp.w   a4,d1                           ; 00DF4
        bgt.b   l_036_00E4A                     ; 00DF6
        move.w  d2,d0                           ; 00DF8
        bsr.w   PlotBigAbove                    ; 00DFA
        bra.b   l_036_00E4A                     ; 00DFE
l_036_00E00:
        move.w  d2,d6                           ; 00E00
        sub.w   d0,d6                           ; 00E02
        bge.b   l_036_00E08                     ; 00E04
        neg.w   d6                              ; 00E06
l_036_00E08:
        cmpi.w  #$1,d6                          ; 00E08
        ble.b   l_036_00E34                     ; 00E0C
l_036_00E0E:
        move.l  (FillPattern).l,-(a7)           ; 00E0E
        tst.b   (dat_071_00172).l               ; 00E14
        bne.b   l_036_00E26                     ; 00E1A
        move.l  #$fffff,(FillPattern).l         ; 00E1C
l_036_00E26:
        bsr.w   DrawLine                        ; 00E26
        move.l  (a7)+,(FillPattern).l           ; 00E2A
        moveq   #$1,d0                          ; 00E30
        rts                                     ; 00E32
l_036_00E34:
        addq.w  #$1,d1                          ; 00E34
        cmp.w   a4,d1                           ; 00E36
        bgt.b   l_036_00E4A                     ; 00E38
        subq.w  #$1,d6                          ; 00E3A
        bge.b   l_036_00E44                     ; 00E3C
        bsr.w   Plot                            ; 00E3E
        bra.b   l_036_00E4A                     ; 00E42
l_036_00E44:
        move.w  d2,d0                           ; 00E44
        bsr.w   Plot2                           ; 00E46
l_036_00E4A:
        moveq   #$1,d0                          ; 00E4A
        rts                                     ; 00E4C
l_036_00E4E:
        move.w  d2,d6                           ; 00E4E
        sub.w   d0,d6                           ; 00E50
        bge.b   l_036_00E56                     ; 00E52
        neg.w   d6                              ; 00E54
l_036_00E56:
        cmpi.w  #$1,d6                          ; 00E56
        ble.b   l_036_00E0E                     ; 00E5A
l_036_00E5C:
        subq.w  #$1,d0                          ; 00E5C
        bge.b   l_036_00E62                     ; 00E5E
        clr.w   d0                              ; 00E60
l_036_00E62:
        exg.l   d1,d2                           ; 00E62
        movem.w d0-d3,(dat_071_0034C).l         ; 00E64
        move.w  (DrawColour).l,(ColourBits).l   ; 00E6C
        lea.l   (dat_072_03000).l,a2            ; 00E76
        lea.l   (dat_071_00340).l,a3            ; 00E7C
        move.w  (a2)+,(a3)                      ; 00E82
        subq.w  #$1,(a3)                        ; 00E84
        lea.l   (CUSTOM).l,a0                    ; 00E86
l_036_00E8C:
        movem.w (a2),d0-d3                      ; 00E8C
        addq.w  #$4,a2                          ; 00E90
        move.w  a4,-(a7)                        ; 00E92
        bsr.w   DrawFillEdges                   ; 00E94
        movea.w (a7)+,a4                        ; 00E98
        subq.w  #$1,(a3)                        ; 00E9A
        bgt.b   l_036_00E8C                     ; 00E9C
        move.w  (a2)+,d0                        ; 00E9E
        move.w  (a2),d1                         ; 00EA0
        movem.w (dat_072_03002).l,d2-d3         ; 00EA2
        move.w  a4,-(a7)                        ; 00EAA
        bsr.w   DrawFillEdges                   ; 00EAC
        movea.w (a7)+,a4                        ; 00EB0
        movem.w (dat_071_0034C).l,d1/d3         ; 00EB2
        asr.w   #$4,d3                          ; 00EBA
        move.w  d3,d2                           ; 00EBC
        asr.w   #$4,d1                          ; 00EBE
        sub.w   d1,d3                           ; 00EC0
        move.w  d3,d6                           ; 00EC2
        add.w   d3,d3                           ; 00EC4
        neg.w   d3                              ; 00EC6
        addi.w  #$27,d3                         ; 00EC8
        move.w  (dat_071_00352).l,d5            ; 00ECC
        move.w  d5,d1                           ; 00ED2
        move.w  d5,d7                           ; 00ED4
        asl.w   #$3,d1                          ; 00ED6
        move.w  d1,d0                           ; 00ED8
        add.w   d0,d0                           ; 00EDA
        add.w   d0,d0                           ; 00EDC
        add.w   d0,d1                           ; 00EDE
        add.w   d2,d2                           ; 00EE0
        ext.l   d2                              ; 00EE2
        add.l   d2,d1                           ; 00EE4
        move.l  d1,d2                           ; 00EE6
        cmp.w   a4,d7                           ; 00EE8
        ble.b   l_036_00F00                     ; 00EEA
        sub.w   a4,d7                           ; 00EEC
        move.w  d7,d0                           ; 00EEE
        asl.w   #$3,d7                          ; 00EF0
        move.w  d7,d4                           ; 00EF2
        add.w   d4,d4                           ; 00EF4
        add.w   d4,d4                           ; 00EF6
        add.w   d4,d7                           ; 00EF8
        ext.l   d7                              ; 00EFA
        sub.l   d7,d1                           ; 00EFC
        bra.b   l_036_00F04                     ; 00EFE
l_036_00F00:
        moveq   #$0,d0                          ; 00F00
        moveq   #$0,d7                          ; 00F02
l_036_00F04:
        move.l  d1,(dat_071_00338).l            ; 00F04
        move.l  d2,d1                           ; 00F0A
        add.l   (FillPlane).l,d1                ; 00F0C
        sub.l   d7,d1                           ; 00F12
        move.l  d1,(dat_071_00330).l            ; 00F14
        move.l  d1,d2                           ; 00F1A
        move.l  d1,(dat_071_00334).l            ; 00F1C
        sub.w   (dat_071_00350).l,d5            ; 00F22
        addq.w  #$1,d5                          ; 00F28
        move.w  d5,d7                           ; 00F2A
        addq.w  #$1,d6                          ; 00F2C
        sub.w   d0,d7                           ; 00F2E
        lsl.w   #$6,d7                          ; 00F30
        add.w   d6,d7                           ; 00F32
        move.w  d7,(FillBoxSize).l              ; 00F34
        moveq   #-1,d0                          ; 00F3A
        lea.l   (CUSTOM).l,a0                    ; 00F3C
l_036_00F42:
        btst    #$6,DMACONR(a0)                 ; 00F42
        beq.b   l_036_00F50                     ; 00F48
        nop                                     ; 00F4A
        nop                                     ; 00F4C
        bra.b   l_036_00F42                     ; 00F4E
l_036_00F50:
        move.w  #$9f0,BLTCON0(a0)               ; 00F50
        move.w  #$a,BLTCON1(a0)                 ; 00F56
        move.l  d2,BLTAPTH(a0)                  ; 00F5C
        move.l  d2,BLTDPTH(a0)                  ; 00F60
        move.l  d0,BLTAFWM(a0)                  ; 00F64
        move.w  d3,BLTAMOD(a0)                  ; 00F68
        move.w  d3,BLTBMOD(a0)                  ; 00F6C
        move.w  d3,BLTDMOD(a0)                  ; 00F70
        move.w  d7,BLTSIZE(a0)                  ; 00F74
        moveq   #$0,d0                          ; 00F78
        rts                                     ; 00F7A

;-------------------------------------------------------------------------------
; FillPatterned - The patterned form of FillPolygon's plane pass (the pattern of FillPattern).
;-------------------------------------------------------------------------------
FillPatterned:
        movea.l (DrawPlanes).l,a2               ; 00F7C
        move.l  $4(a2),d2                       ; 00F82
        move.l  (a2),d3                         ; 00F86
        move.w  (FillBoxSize).l,d0              ; 00F88
        move.l  (dat_071_00338).l,d1            ; 00F8E
        add.l   d1,d2                           ; 00F94
        add.l   d1,d3                           ; 00F96
        move.l  (dat_071_00334).l,d1            ; 00F98
        lea.l   (CUSTOM).l,a0                    ; 00F9E
        move.w  #$fca,d4                        ; 00FA4
l_036_00FA8:
        btst    #$6,DMACONR(a0)                 ; 00FA8
        beq.b   l_036_00FB6                     ; 00FAE
        nop                                     ; 00FB0
        nop                                     ; 00FB2
        bra.b   l_036_00FA8                     ; 00FB4
l_036_00FB6:
        move.w  d4,BLTCON0(a0)                  ; 00FB6
        move.w  #$2,BLTCON1(a0)                 ; 00FBA
        move.l  d1,BLTAPTH(a0)                  ; 00FC0
        move.l  d3,BLTBPTH(a0)                  ; 00FC4
        move.l  d2,BLTCPTH(a0)                  ; 00FC8
        move.l  d2,BLTDPTH(a0)                  ; 00FCC
        move.w  d0,BLTSIZE(a0)                  ; 00FD0
        rts                                     ; 00FD4

;-------------------------------------------------------------------------------
; PlaneOpUnderFill - PlaneOpUnderFill(d0 = plane offset in DrawPlanes, d3, d4): a blitter pass
; over FillPolygonPlane's box combining another plane with the filled one (A): d3 = d4 = 0
; clears it under the fill (~A & B), d3 = 1 sets it (A | B), d4 = 1 flips it (A ^ B).
;-------------------------------------------------------------------------------
PlaneOpUnderFill:
        lsr.w   (ColourBits).l                  ; 00FD6
        movea.l (DrawPlanes).l,a2               ; 00FDC
        move.l  (a2,d0.w),d2                    ; 00FE2
        move.w  (FillBoxSize).l,d0              ; 00FE6
        move.l  (dat_071_00338).l,d1            ; 00FEC
        add.l   d2,d1                           ; 00FF2
        move.l  (dat_071_00334).l,d2            ; 00FF4
        lea.l   (CUSTOM).l,a0                    ; 00FFA
l_036_01000:
        btst    #$6,DMACONR(a0)                 ; 01000
        beq.b   l_036_0100E                     ; 01006
        nop                                     ; 01008
        nop                                     ; 0100A
        bra.b   l_036_01000                     ; 0100C
l_036_0100E:
        btst    #$0,d4                          ; 0100E
        bne.b   l_036_0104C                     ; 01012
        btst    #$0,d3                          ; 01014
        beq.b   l_036_01044                     ; 01018
        move.w  #$dfc,BLTCON0(a0)               ; 0101A
        bra.b   l_036_01052                     ; 01020

;-------------------------------------------------------------------------------
; ClearFillPlane - Clears the box FillPolygonPlane used in its work plane (BLTCON0 $D0C) after
; a fill.
;-------------------------------------------------------------------------------
ClearFillPlane:
        move.w  (FillBoxSize).l,d0              ; 01022
        move.l  (dat_071_00330).l,d2            ; 01028
        move.l  d2,d1                           ; 0102E
        lea.l   (CUSTOM).l,a0                    ; 01030
l_036_01036:
        btst    #$6,DMACONR(a0)                 ; 01036
        beq.b   l_036_01044                     ; 0103C
        nop                                     ; 0103E
        nop                                     ; 01040
        bra.b   l_036_01036                     ; 01042
l_036_01044:
        move.w  #$d0c,BLTCON0(a0)               ; 01044
        bra.b   l_036_01052                     ; 0104A
l_036_0104C:
        move.w  #$d3c,BLTCON0(a0)               ; 0104C
l_036_01052:
        move.w  #$2,BLTCON1(a0)                 ; 01052
        move.l  d2,BLTAPTH(a0)                  ; 01058
        move.l  d1,BLTBPTH(a0)                  ; 0105C
        move.l  d1,BLTDPTH(a0)                  ; 01060
        move.w  d0,BLTSIZE(a0)                  ; 01064
        rts                                     ; 01068

;-------------------------------------------------------------------------------
; FillPanelPlane - The attitude indicator's plane pass: combines the filled sky with the
; instrument's mask (dat_062_00154) into the plane.
;-------------------------------------------------------------------------------
FillPanelPlane:
        movea.l (DrawPlanes).l,a2               ; 0106A
        move.l  (a2,d0.w),d2                    ; 01070
        move.w  (FillBoxSize).l,d0              ; 01074
        move.l  (dat_071_00338).l,d1            ; 0107A
        add.l   d2,d1                           ; 01080
        move.l  (dat_071_00334).l,d2            ; 01082
        move.w  (dat_071_00352).l,d6            ; 01088
        sub.w   (ViewY).l,d6                    ; 0108E
        subi.w  #$b7,d6                         ; 01094
        add.w   d6,d6                           ; 01098
        add.w   d6,d6                           ; 0109A
        ext.l   d6                              ; 0109C
        move.l  #dat_062_00154,d5               ; 0109E
        add.l   d6,d5                           ; 010A4
        subq.l  #$2,d5                          ; 010A6
        move.w  d0,d4                           ; 010A8
        andi.w  #$3f,d4                         ; 010AA
        subi.w  #$3,d4                          ; 010AE
        neg.w   d4                              ; 010B2
        cmpi.w  #$1,d4                          ; 010B4
        beq.b   l_036_010D2                     ; 010B8
        move.w  (dat_071_0034C).l,d6            ; 010BA
        asr.w   #$4,d6                          ; 010C0
        move.w  (ViewShift).l,d7                ; 010C2
        addi.w  #$c,d7                          ; 010C8
        cmp.w   d7,d6                           ; 010CC
        bne.b   l_036_010D2                     ; 010CE
        subq.l  #$2,d5                          ; 010D0
l_036_010D2:
        lea.l   (CUSTOM).l,a0                    ; 010D2
l_036_010D8:
        btst    #$6,DMACONR(a0)                 ; 010D8
        beq.b   l_036_010E6                     ; 010DE
        nop                                     ; 010E0
        nop                                     ; 010E2
        bra.b   l_036_010D8                     ; 010E4
l_036_010E6:
        btst    #$0,d3                          ; 010E6
        beq.b   l_036_010F4                     ; 010EA
        move.w  #$fec,BLTCON0(a0)               ; 010EC
        bra.b   l_036_010FA                     ; 010F2
l_036_010F4:
        move.w  #$f4c,BLTCON0(a0)               ; 010F4
l_036_010FA:
        move.w  #$2,BLTCON1(a0)                 ; 010FA
        move.l  d2,BLTAPTH(a0)                  ; 01100
        move.l  d5,BLTCPTH(a0)                  ; 01104
        move.w  d4,BLTCMOD(a0)                  ; 01108
        move.l  d1,BLTBPTH(a0)                  ; 0110C
        move.l  d1,BLTDPTH(a0)                  ; 01110
        move.w  d0,BLTSIZE(a0)                  ; 01114
        rts                                     ; 01118

;-------------------------------------------------------------------------------
; DrawFillEdges - Draws a polygon's edges for the blitter's area fill (one pixel per row, the
; fill's way), clipped to the rows up to a4.
;-------------------------------------------------------------------------------
DrawFillEdges:
        cmp.w   d1,d3                           ; 0111A
        beq.b   l_036_01144                     ; 0111C
        bls.b   l_036_01146                     ; 0111E
        move.w  d3,d5                           ; 01120
        sub.w   d1,d5                           ; 01122
        subq.w  #$1,d5                          ; 01124
        addq.w  #$1,d1                          ; 01126
        cmp.w   a4,d1                           ; 01128
        bgt.b   l_036_01144                     ; 0112A
        movea.w d1,a1                           ; 0112C
        asl.w   #$3,d1                          ; 0112E
        move.w  d1,d7                           ; 01130
        add.w   d7,d7                           ; 01132
        add.w   d7,d7                           ; 01134
        add.w   d1,d7                           ; 01136
        move.w  d2,d4                           ; 01138
        sub.w   d0,d4                           ; 0113A
        move.w  d0,d6                           ; 0113C
        lsr.w   #$3,d0                          ; 0113E
        add.w   d0,d7                           ; 01140
        bra.b   l_036_01168                     ; 01142
l_036_01144:
        rts                                     ; 01144
l_036_01146:
        move.w  d1,d5                           ; 01146
        sub.w   d3,d5                           ; 01148
        subq.w  #$1,d5                          ; 0114A
        move.w  d0,d4                           ; 0114C
        sub.w   d2,d4                           ; 0114E
        addq.w  #$1,d3                          ; 01150
        cmp.w   a4,d3                           ; 01152
        bgt.b   l_036_01144                     ; 01154
        movea.w d3,a1                           ; 01156
        asl.w   #$3,d3                          ; 01158
        move.w  d3,d7                           ; 0115A
        add.w   d7,d7                           ; 0115C
        add.w   d7,d7                           ; 0115E
        add.w   d3,d7                           ; 01160
        move.w  d2,d6                           ; 01162
        lsr.w   #$3,d2                          ; 01164
        add.w   d2,d7                           ; 01166
l_036_01168:
        ext.l   d7                              ; 01168
        add.l   (FillPlane).l,d7                ; 0116A
        moveq   #$3,d1                          ; 01170
        andi.w  #$f,d6                          ; 01172
        ror.w   #$4,d6                          ; 01176
        addi.w  #$b4a,d6                        ; 01178
        tst.w   d4                              ; 0117C
        bmi.b   l_036_0118A                     ; 0117E
        cmp.w   d5,d4                           ; 01180
        bcs.b   l_036_011B0                     ; 01182
        addi.w  #$10,d1                         ; 01184
        bra.b   l_036_01194                     ; 01188
l_036_0118A:
        neg.w   d4                              ; 0118A
        cmp.w   d5,d4                           ; 0118C
        bcs.b   l_036_011AE                     ; 0118E
        addi.w  #$14,d1                         ; 01190
l_036_01194:
        suba.w  a1,a4                           ; 01194
        cmp.w   a4,d5                           ; 01196
        ble.b   l_036_011B8                     ; 01198
        move.w  a4,d2                           ; 0119A
        move.w  d4,d3                           ; 0119C
        muls.w  d2,d3                           ; 0119E
        add.l   d3,d3                           ; 011A0
        divs.w  d5,d3                           ; 011A2
        asr.w   #$1,d3                          ; 011A4
        bcc.b   l_036_011AA                     ; 011A6
        addq.w  #$1,d3                          ; 011A8
l_036_011AA:
        movea.w d3,a4                           ; 011AA
        bra.b   l_036_011BA                     ; 011AC
l_036_011AE:
        addq.w  #$8,d1                          ; 011AE
l_036_011B0:
        exg.l   d4,d5                           ; 011B0
        suba.w  a1,a4                           ; 011B2
        cmp.w   a4,d4                           ; 011B4
        bgt.b   l_036_011BA                     ; 011B6
l_036_011B8:
        movea.w d4,a4                           ; 011B8
l_036_011BA:
        add.w   d5,d5                           ; 011BA
        add.w   d5,d5                           ; 011BC
        add.w   d4,d4                           ; 011BE
        move.w  d5,d2                           ; 011C0
        sub.w   d4,d2                           ; 011C2
        bge.b   l_036_011CA                     ; 011C4
        bset    #$6,d1                          ; 011C6
l_036_011CA:
        move.w  d5,d3                           ; 011CA
        add.w   d4,d4                           ; 011CC
        sub.w   d4,d5                           ; 011CE
        move.w  a4,d4                           ; 011D0
        asl.w   #$6,d4                          ; 011D2
        addi.w  #$42,d4                         ; 011D4
        moveq   #-1,d0                          ; 011D8
l_036_011DA:
        btst    #$6,$2(a0)                      ; 011DA
        beq.b   l_036_011E8                     ; 011E0
        nop                                     ; 011E2
        nop                                     ; 011E4
        bra.b   l_036_011DA                     ; 011E6
l_036_011E8:
        move.w  d6,$40(a0)                      ; 011E8
        move.w  d1,$42(a0)                      ; 011EC
        move.w  d5,$64(a0)                      ; 011F0
        move.w  #$28,$66(a0)                    ; 011F4
        move.w  #$28,$60(a0)                    ; 011FA
        move.w  d2,$52(a0)                      ; 01200
        move.l  d7,$54(a0)                      ; 01204
        move.l  d7,$48(a0)                      ; 01208
        move.l  d0,$44(a0)                      ; 0120C
        move.w  d0,$72(a0)                      ; 01210
        move.w  #$8000,$74(a0)                  ; 01214
        move.w  d3,$62(a0)                      ; 0121A
        move.w  d4,$58(a0)                      ; 0121E
        rts                                     ; 01222
h036_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    42,36                           ; 42 longs pointing into hunk 36
	dc.l	$392,$38E,$38A,$386,$382,$37E,$37A,$376
	dc.l	$372,$36E,$36A,$366,$362,$35E,$35A,$356
	dc.l	$332,$32E,$32A,$326,$322,$31E,$31A,$316
	dc.l	$312,$30E,$30A,$306,$302,$2FE,$2FA,$2F6
	dc.l	$1F4,$1EE,$1D0,$1CA,$1A4,$19E,$172,$16C
	dc.l	$152,$14C
        dc.l    168,71                          ; 168 longs pointing into hunk 71
	dc.l	$6E,$AA,$B0,$8DE,$74,$B6,$8D8,$7A
	dc.l	$BC,$8D2,$80,$C2,$8CC,$8C,$8AC,$56
	dc.l	$92,$8A6,$5C,$98,$8A0,$62,$9E,$89A
	dc.l	$68,$A4,$894,$86,$D0,$50,$CA,$F4
	dc.l	$FE,$8E4,$A50,$A58,$A7E,$F0E,$116C,$20
	dc.l	$D6,$1E0,$5F0,$90A,$D68,$ECE,$108A,$F24
	dc.l	$E68,$EB6,$10BC,$EC,$E6,$146,$166,$198
	dc.l	$1C4,$1E8,$6EC,$8FE,$C16,$F7E,$FDE,$106C
	dc.l	$8BE,$E7E,$6,$12,$24C,$25C,$26C,$27C
	dc.l	$28A,$29A,$2A8,$2B6,$2C4,$6F6,$700,$70A
	dc.l	$75E,$768,$772,$7C6,$7D0,$7DA,$82E,$838
	dc.l	$842,$ACA,$AD2,$AE4,$AEE,$AF4,$B10,$B1A
	dc.l	$B22,$B42,$B4C,$B54,$B74,$B7E,$B86,$C7E
	dc.l	$E10,$E22,$E2C,$F36,$F8A,$FE8,$1024,$1076
	dc.l	$F06,$F90,$FEE,$107C,$E16,$BE4,$BB0,$BC6
	dc.l	$10C4,$132,$1AC,$C88,$D2E,$140,$1BA,$C92
	dc.l	$D42,$1090,$F1E,$F9A,$FF6,$1084,$F16,$102A
	dc.l	$A84,$5FA,$714,$77C,$7E4,$84C,$AFC,$B08
	dc.l	$B2E,$B3A,$B60,$B6C,$B92,$E72,$FD8,$9BE
	dc.l	$A6C,$1A,$1FE,$5F6,$CA2,$CC2,$E6E,$A1C
	dc.l	$A24,$A3A,$9D2,$9DA,$9F0,$97C,$984,$99A
        dc.l    8,72                            ; 8 longs pointing into hunk 72
	dc.l	$A9A,$AB0,$D0E,$A94,$D14,$D6E,$E78,$EA6
        dc.l    2,62                            ; 2 longs pointing into hunk 62
	dc.l	$10A0,$C10
        dc.l    2,33                            ; 2 longs pointing into hunk 33
	dc.l	$A8C,$A5E
        dc.l    1,37                            ; 1 longs pointing into hunk 37
	dc.l	$BEA
	dc.l	0
	dc.l	HUNK_END
	endc
