; F/A-18 Interceptor - hunk 39 (code)
; The instruments' numbers and texts ("GUN RNG SHOOT"...), the target readout (TargetReadout)
; and the text printer (PrintText: the menus, briefings and typed input).
; Included by ../f18_main.s.

;===============================================================================
; Hunk 39: CODE, $1950 bytes
;===============================================================================
	CODE_HUNK	h039
; GLoadDigitPlaces - The places of the G load's digits on the head-up display.
GLoadDigitPlaces:
	dc.b	$00,$00,$A0,$00,$00,$00,$E0,$00,$00,$02,$50,$00
; GLoadPointPlace - The place of the G load's decimal point.
GLoadPointPlace:
	dc.b	$00,$00,$C0,$00,$00,$02,$00,$00,$00,$02,$60,$00
; GLetterPlace - The place of the letter G.
GLetterPlace:
	dc.b	$00,$02,$C0,$00
; MissilesLeftPlaces - The places of the missiles-left digits on the panel.
MissilesLeftPlaces:
	dc.b	$00,$00,$D0,$00,$00,$02,$10,$00,$00,$02,$50,$00
; AltitudePanelPlaces - The places of the altitude readout's digits on the panel.
AltitudePanelPlaces:
	dc.b	$00,$00,$00,$00,$00,$00,$40,$00,$00,$00,$80,$00,$00,$00,$E0,$00
	dc.b	$00,$02,$20,$00,$00,$02,$60,$00,$00,$02,$F0,$00,$00,$04,$30,$00
; SpeedPanelPlaces - The places of the speed readout's digits on the panel.
SpeedPanelPlaces:
	dc.b	$00,$00,$20,$00,$00,$00,$80,$00,$00,$00,$C0,$00,$00,$02,$00,$00
; SpeedPanelPlaces2 - More places for the speed readout.
SpeedPanelPlaces2:
	dc.b	$00,$00,$00,$00,$00,$00,$60,$00,$00,$00,$A0,$00,$00,$00,$E0,$00
	dc.b	$00,$02,$70,$00,$00,$02,$B0,$00,$00,$02,$F0,$00
; HeadingPanelPlaces - The places of the heading readout's digits.
HeadingPanelPlaces:
	dc.b	$00,$00,$40,$00,$00,$00,$80,$00,$00,$00,$C0,$00,$00,$02,$40,$00
	dc.b	$00,$02,$80,$00,$00,$02,$C0,$00
; WeaponRangePlaces - The places of the weapon range's digits.
WeaponRangePlaces:
	dc.b	$00,$00,$00,$00,$00,$00,$40,$00
; FuelPlaces - The places of the fuel readout's digits.
FuelPlaces:
	dc.b	$00,$00,$80,$00
; WeaponPlaces - The places of the weapon's name on the head-up display.
WeaponPlaces:
	dc.b	$00,$00,$C0,$00,$00,$02,$00,$00,$00,$02,$40,$00,$00,$02,$80,$00
	dc.b	$00,$02,$C0,$00,$00,$04,$00,$00,$00,$04,$40,$00,$00,$04,$80,$00
	dc.b	$00,$04,$C0,$00,$00,$06,$00,$00,$00,$06,$40,$00,$00,$06,$80,$00
	dc.b	$00,$06,$C0,$00,$00,$08,$00,$00,$00,$08,$40,$00,$00,$08,$80,$00
	dc.b	$00,$08,$C0,$00,$00,$0A,$00,$00,$00,$0A,$40,$00,$00,$0A,$80,$00
	dc.b	$00,$0A,$C0,$00,$00,$0C,$00,$00,$00,$0C,$40,$00,$00,$0C,$80,$00
	dc.b	$00,$0C,$C0,$00,$00,$0E,$00,$00,$00,$0E,$40,$00,$00,$0E,$80,$00
	dc.b	$00,$0E,$C0,$00,$00,$10,$00,$00,$00,$10,$40,$00,$00,$10,$80,$00
	dc.b	$00,$10,$C0,$00
; RadarRangePlaces - The places of the radar range's digits.
RadarRangePlaces:
	dc.b	$00,$00,$20,$00,$00,$00,$80,$00
; GridXPlaces - The places of the grid X readout's digits.
GridXPlaces:
	dc.b	$00,$00,$40,$00,$00,$00,$70,$00,$00,$00,$B0,$00,$00,$02,$10,$00
	dc.b	$00,$02,$50,$00
; GridZPlaces - The places of the grid Z readout's digits.
GridZPlaces:
	dc.b	$00,$00,$40,$00,$00,$00,$70,$00,$00,$00,$B0,$00,$00,$02,$10,$00
	dc.b	$00,$02,$70,$00
; DebugNumberPlaces - The places of ShowDebugNumbers' digits.
DebugNumberPlaces:
	dc.b	$00,$00,$80,$00,$00,$00,$C0,$00,$00,$02,$20,$00,$00,$02,$60,$00
	dc.b	$00,$02,$C0,$00,$00,$04,$00,$00

;-------------------------------------------------------------------------------
; ShowWeaponRange - The selected weapon's range on the panel (2, 10 or 40 by the weapon:
; obj_Weapon low nibble 9, $B or other), while WeaponRangeRedraw counts down.
;-------------------------------------------------------------------------------
ShowWeaponRange:
        tst.b   (WeaponRangeRedraw).l           ; 00164
        ble.b   l_039_001C8                     ; 0016A
        subq.b  #$1,(WeaponRangeRedraw).l       ; 0016C
        lea.l   (ObjectTable).l,a1              ; 00172
        adda.w  (ViewObject).l,a1               ; 00178
        move.b  obj_Weapon(a1),d0               ; 0017E
        andi.b  #$f,d0                          ; 00182
        cmpi.b  #$9,d0                          ; 00186
        bne.b   l_039_00190                     ; 0018A
        moveq   #$2,d0                          ; 0018C
        bra.b   l_039_0019C                     ; 0018E
l_039_00190:
        cmpi.b  #$b,d0                          ; 00190
        bne.b   l_039_0019A                     ; 00194
        moveq   #$a,d0                          ; 00196
        bra.b   l_039_0019C                     ; 00198
l_039_0019A:
        moveq   #$28,d0                         ; 0019A
l_039_0019C:
        move.l  d0,(BCDIn).l                    ; 0019C
        jsr     (BinToBCD).l                    ; 001A2
        lea.l   WeaponRangePlaces(pc),a1        ; 001A8
        lea.l   (TextBuffer).l,a2               ; 001AC
        lea.l   $3(a2),a0                       ; 001B2
        lea.l   $1cd2.w,a4                      ; 001B6
        lea.l   $12.w,a5                        ; 001BA
        move.w  #$4,d5                          ; 001BE
        moveq   #$2,d0                          ; 001C2
        bra.w   l_039_00E3C                     ; 001C4
l_039_001C8:
        rts                                     ; 001C8
l_039_001CA:
        rts                                     ; 001CA

;-------------------------------------------------------------------------------
; ShowRadarRange - The radar's range: 10 (RadarScale $80), 20 ($40) or 40.
;-------------------------------------------------------------------------------
ShowRadarRange:
        tst.b   (RadarRangeRedraw).l            ; 001CC
        ble.b   l_039_001CA                     ; 001D2
        subq.b  #$1,(RadarRangeRedraw).l        ; 001D4
        move.w  (RadarScale).l,d0               ; 001DA
        cmpi.w  #$80,d0                         ; 001E0
        bne.b   l_039_001EA                     ; 001E4
        moveq   #$a,d0                          ; 001E6
        bra.b   l_039_0021A                     ; 001E8
l_039_001EA:
        cmpi.w  #$40,d0                         ; 001EA
        bne.b   l_039_001F4                     ; 001EE
        moveq   #$14,d0                         ; 001F0
        bra.b   l_039_001F6                     ; 001F2
l_039_001F4:
        moveq   #$28,d0                         ; 001F4
l_039_001F6:
        move.b  #$1,(RadarRangeRedraw).l        ; 001F6
        btst    #$0,(ClockBlink).l              ; 001FE
        beq.b   l_039_0021A                     ; 00206
        move.w  #$f0a,d6                        ; 00208
        move.w  #$4,d5                          ; 0020C
        move.w  #$0,(DrawColour).l              ; 00210
        bra.b   l_039_0022A                     ; 00218
l_039_0021A:
        move.w  #$fca,d6                        ; 0021A
        move.w  #$4,d5                          ; 0021E
        move.w  #$4,(DrawColour).l              ; 00222
l_039_0022A:
        movem.w d0/d5-d6,-(a7)                  ; 0022A
        move.w  #$f6,d0                         ; 0022E
        move.w  #$bc,d1                         ; 00232
        move.l  #$fffff,(FillPattern).l         ; 00236
        jsr     (PlotInView).l                  ; 00240
        movem.w (a7)+,d0/d5-d6                  ; 00246
        move.l  d0,(BCDIn).l                    ; 0024A
        jsr     (BinToBCD).l                    ; 00250
        lea.l   RadarRangePlaces(pc),a1         ; 00256
        lea.l   (TextBuffer).l,a2               ; 0025A
        lea.l   $2(a2),a0                       ; 00260
        lea.l   $1cde.w,a4                      ; 00264
        lea.l   $1e.w,a5                        ; 00268
        moveq   #$1,d0                          ; 0026C
        bra.w   l_039_00E40                     ; 0026E
	dc.b	$4E,$75
l_039_00274:
        rts                                     ; 00274

;-------------------------------------------------------------------------------
; ShowDebugNumbers - Prints TimedResult and, while DebugNumbersOn is set, the mouse's X and Y:
; apparently a programmer's readout.
;-------------------------------------------------------------------------------
ShowDebugNumbers:
        move.w  #$9,(DrawColour).l              ; 00276
        move.w  (TimedResult).l,d0              ; 0027E
        ext.l   d0                              ; 00284
        move.l  d0,(BCDIn).l                    ; 00286
        jsr     (BinToBCD).l                    ; 0028C
        moveq   #$3,d0                          ; 00292
        lea.l   DebugNumberPlaces(pc),a1        ; 00294
        lea.l   (TextBuffer1).l,a2              ; 00298
        lea.l   $4(a2),a0                       ; 0029E
        lea.l   $78.w,a4                        ; 002A2
        lea.l   $0.w,a5                         ; 002A6
        bsr.w   PrintNumber                     ; 002AA
        tst.b   (DebugNumbersOn).l              ; 002AE
        beq.b   l_039_00274                     ; 002B4
        move.w  (MouseX).l,d0                   ; 002B6
        bge.b   l_039_002C0                     ; 002BC
        neg.w   d0                              ; 002BE
l_039_002C0:
        ext.l   d0                              ; 002C0
        move.l  d0,(BCDIn).l                    ; 002C2
        jsr     (BinToBCD).l                    ; 002C8
        moveq   #$3,d0                          ; 002CE
        lea.l   DebugNumberPlaces(pc),a1        ; 002D0
        lea.l   (TextBuffer1).l,a2              ; 002D4
        lea.l   $4(a2),a0                       ; 002DA
        lea.l   $7c.w,a4                        ; 002DE
        lea.l   $4.w,a5                         ; 002E2
        bsr.w   PrintNumber                     ; 002E6
        move.w  (MouseY).l,d0                   ; 002EA
        bge.b   l_039_002F4                     ; 002F0
        neg.w   d0                              ; 002F2
l_039_002F4:
        ext.l   d0                              ; 002F4
        move.l  d0,(BCDIn).l                    ; 002F6
        jsr     (BinToBCD).l                    ; 002FC
        moveq   #$3,d0                          ; 00302
        lea.l   DebugNumberPlaces(pc),a1        ; 00304
        lea.l   (TextBuffer1).l,a2              ; 00308
        lea.l   $4(a2),a0                       ; 0030E
        lea.l   $80.w,a4                        ; 00312
        lea.l   $8.w,a5                         ; 00316
        bsr.w   PrintNumber                     ; 0031A
        rts                                     ; 0031E

;-------------------------------------------------------------------------------
; ValueChanged - ValueChanged(d0 = value, a1 = the last value shown): whether an instrument's
; number must be drawn again (it changed, or the panel is being redrawn); returns -1 if not,
; otherwise the value, remembered with bit 15 set.
;-------------------------------------------------------------------------------
ValueChanged:
        tst.b   (PanelRedraw).l                 ; 00320
        bgt.b   l_039_00354                     ; 00326
        move.w  (a1),d2                         ; 00328
        blt.b   l_039_00348                     ; 0032A
        cmp.w   d2,d0                           ; 0032C
        beq.b   l_039_00344                     ; 0032E
        btst    #$0,(BlinkPhase).l              ; 00330
        bne.b   l_039_00344                     ; 00338
        tst.b   (WorldFrozen).l                 ; 0033A
        bne.b   l_039_00348                     ; 00340
        bra.b   l_039_00354                     ; 00342
l_039_00344:
        moveq   #-1,d0                          ; 00344
        rts                                     ; 00346
l_039_00348:
        andi.w  #$7fff,(a1)                     ; 00348
        andi.w  #$7fff,d2                       ; 0034C
        move.w  d2,d0                           ; 00350
        bra.b   l_039_0035A                     ; 00352
l_039_00354:
        move.w  d0,(a1)                         ; 00354
        ori.w   #$8000,(a1)                     ; 00356
l_039_0035A:
        tst.w   d0                              ; 0035A
        rts                                     ; 0035C
l_039_0035E:
        rts                                     ; 0035E

;-------------------------------------------------------------------------------
; ShowWeapon - The selected weapon and what is left: GUN and the rounds (obj_Rounds) for weapon
; $1x, SW and the Sidewinders (obj_Missiles high nibble) for $2x, AM and the AMRAAMs
; (obj_Missiles low nibble) for $3x.
;-------------------------------------------------------------------------------
ShowWeapon:
        move.w  #$d,(DrawColour).l              ; 00360
        lea.l   (ObjectTable).l,a1              ; 00368
        adda.w  (ViewObject).l,a1               ; 0036E
        lea.l   (TextBuffer).l,a2               ; 00374
        moveq   #$0,d0                          ; 0037A
        move.b  obj_Weapon(a1),d2               ; 0037C
        andi.b  #$f0,d2                         ; 00380
        beq.b   l_039_0035E                     ; 00384
        cmpi.b  #$10,d2                         ; 00386
        beq.b   l_039_003D0                     ; 0038A
        move.b  obj_Missiles(a1),d0             ; 0038C
        cmpi.b  #$30,d2                         ; 00390
        beq.b   l_039_003B2                     ; 00394
        move.b  #$20,(a2)                       ; 00396
        move.b  #$53,$1(a2)                     ; 0039A
        move.b  #$57,$2(a2)                     ; 003A0
        lsr.b   #$4,d0                          ; 003A6
        lea.l   $5(a2),a0                       ; 003A8
        moveq   #$4,d6                          ; 003AC
        moveq   #$0,d7                          ; 003AE
        bra.b   l_039_003EC                     ; 003B0
l_039_003B2:
        move.b  #$20,(a2)                       ; 003B2
        move.b  #$41,$1(a2)                     ; 003B6
        move.b  #$4d,$2(a2)                     ; 003BC
        andi.b  #$f,d0                          ; 003C2
        lea.l   $5(a2),a0                       ; 003C6
        moveq   #$4,d6                          ; 003CA
        moveq   #$0,d7                          ; 003CC
        bra.b   l_039_003EC                     ; 003CE
l_039_003D0:
        move.w  obj_Rounds(a1),d0               ; 003D0
        move.b  #$47,(a2)                       ; 003D4
        move.b  #$55,$1(a2)                     ; 003D8
        move.b  #$4e,$2(a2)                     ; 003DE
        lea.l   $7(a2),a0                       ; 003E4
        moveq   #$6,d6                          ; 003E8
        moveq   #$2,d7                          ; 003EA
l_039_003EC:
        move.b  #$20,$3(a2)                     ; 003EC
        move.l  d0,(BCDIn).l                    ; 003F2
        jsr     (BinToBCD).l                    ; 003F8
        lea.l   WeaponPlaces(pc),a1             ; 003FE
        move.w  d7,d2                           ; 00402
        lea.l   $1432.w,a4                      ; 00404
        move.w  #$a,d0                          ; 00408
        swap    d0                              ; 0040C
        move.w  d6,d0                           ; 0040E
        bsr.w   PrintNumberHUD0                 ; 00410
        rts                                     ; 00414

;-------------------------------------------------------------------------------
; ShowClosure - Prints the closure rate (d0) beside the gun sight.
;-------------------------------------------------------------------------------
ShowClosure:
        move.w  #$d,(DrawColour).l              ; 00416
        lea.l   (TextBuffer).l,a2               ; 0041E
        tst.w   d0                              ; 00424
        bge.b   l_039_00430                     ; 00426
        neg.w   d0                              ; 00428
        move.b  #$20,(a2)                       ; 0042A
        bra.b   l_039_00434                     ; 0042E
l_039_00430:
        move.b  #$2d,(a2)                       ; 00430
l_039_00434:
        lea.l   $5(a2),a0                       ; 00434
        moveq   #$4,d6                          ; 00438
        moveq   #$3,d7                          ; 0043A
        ext.l   d0                              ; 0043C
        move.l  d0,(BCDIn).l                    ; 0043E
        jsr     (BinToBCD).l                    ; 00444
        lea.l   WeaponPlaces(pc),a1             ; 0044A
        move.w  d7,d2                           ; 0044E
        lea.l   $134e.w,a4                      ; 00450
        move.w  #$16,d0                         ; 00454
        swap    d0                              ; 00458
        move.w  d6,d0                           ; 0045A
        moveq   #$1,d4                          ; 0045C
        bsr.w   PrintNumberHUD                  ; 0045E
        rts                                     ; 00462

;-------------------------------------------------------------------------------
; ShowGLoad - Apparently the G meter: the pitch rotation rate (obj_PitchRate, plus a little of
; GLoadValue) / 8, plus or minus 1 g (10 tenths) as the aircraft is upright or not
; (FlightBits bit 1), with its sign; the F/A-18 ($11) and F-16 cockpits put it in different
; places.
;-------------------------------------------------------------------------------
ShowGLoad:
        lea.l   (ObjectTable).l,a4              ; 00464
        adda.w  (ViewObject).l,a4               ; 0046A
        move.w  #$d,(DrawColour).l              ; 00470
        move.l  #$fffff,(FillPattern).l         ; 00478
        cmpi.b  #$11,obj_Type(a4)               ; 00482
        beq.b   l_039_004A6                     ; 00488
        move.w  #$72,d0                         ; 0048A
        move.w  #$41,d1                         ; 0048E
        jsr     (PlotInView).l                  ; 00492
        lea.l   $994.w,a4                       ; 00498
        move.w  #$c,d2                          ; 0049C
        lea.l   GLoadDigitPlaces(pc),a1         ; 004A0
        bra.b   l_039_004E2                     ; 004A4
l_039_004A6:
        lea.l   (TextG).l,a2                    ; 004A6
        lea.l   $1(a2),a0                       ; 004AC
        lea.l   GLetterPlace(pc),a1             ; 004B0
        lea.l   $12f2.w,a4                      ; 004B4
        move.w  #$a,d0                          ; 004B8
        swap    d0                              ; 004BC
        move.w  #$0,d0                          ; 004BE
        jsr     (PrintTextHUD).l                ; 004C2
        move.w  #$64,d0                         ; 004C8
        move.w  #$7d,d1                         ; 004CC
        jsr     (PlotInView).l                  ; 004D0
        lea.l   $12f2.w,a4                      ; 004D6
        move.w  #$a,d2                          ; 004DA
        lea.l   GLoadPointPlace(pc),a1          ; 004DE
l_039_004E2:
        lea.l   (TextBuffer).l,a2               ; 004E2
        lea.l   (ObjectTable).l,a0              ; 004E8
        adda.w  (ViewObject).l,a0               ; 004EE
        move.w  obj_PitchRate(a0),d0            ; 004F4
        move.w  d0,d1                           ; 004F8
        asr.w   #$3,d1                          ; 004FA
        add.w   d1,d0                           ; 004FC
        move.w  (GLoadValue).l,d6               ; 004FE
        bge.b   l_039_00508                     ; 00504
        neg.w   d6                              ; 00506
l_039_00508:
        cmpi.w  #$1,d6                          ; 00508
        ble.b   l_039_00514                     ; 0050C
        add.w   (GLoadValue).l,d0               ; 0050E
l_039_00514:
        asr.w   #$3,d0                          ; 00514
        move.w  (FlightBits).l,d1               ; 00516
        andi.w  #$2,d1                          ; 0051C
        beq.b   l_039_00528                     ; 00520
        addi.w  #$a,d0                          ; 00522
        bra.b   l_039_0052C                     ; 00526
l_039_00528:
        subi.w  #$a,d0                          ; 00528
l_039_0052C:
        bge.b   l_039_00536                     ; 0052C
        neg.w   d0                              ; 0052E
        move.b  #$20,(a2)                       ; 00530
        bra.b   l_039_0053A                     ; 00534
l_039_00536:
        move.b  #$2d,(a2)                       ; 00536
l_039_0053A:
        lea.l   $3(a2),a0                       ; 0053A
        moveq   #$2,d6                          ; 0053E
        moveq   #$1,d7                          ; 00540
        ext.l   d0                              ; 00542
        move.l  d0,(BCDIn).l                    ; 00544
        jsr     (BinToBCD).l                    ; 0054A
        move.w  d2,d0                           ; 00550
        move.w  d7,d2                           ; 00552
        swap    d0                              ; 00554
        move.w  d6,d0                           ; 00556
        bsr.w   PrintNumberHUD0                 ; 00558
        rts                                     ; 0055C
; TextG - The text of the G load ('G').
TextG:
	dc.b	$47
; StrInRng - "IN RNG"
StrInRng:
	dc.b	'IN RNG'
; StrShoot - " SHOOT"
StrShoot:
	dc.b	' SHOOT'
	dc.b	$00

;-------------------------------------------------------------------------------
; ShowShootCue - Prints the shoot cue: IN RNG with a missile, SHOOT with the gun.
;-------------------------------------------------------------------------------
ShowShootCue:
        lea.l   (ObjectTable).l,a1              ; 0056C
        adda.w  (ViewObject).l,a1               ; 00572
        move.b  obj_Weapon(a1),d0               ; 00578
        andi.b  #$f0,d0                         ; 0057C
        cmpi.b  #$10,d0                         ; 00580
        beq.b   l_039_0058C                     ; 00584
        lea.l   StrInRng(pc),a2                 ; 00586
        bra.b   l_039_00590                     ; 0058A
l_039_0058C:
        lea.l   StrShoot(pc),a2                 ; 0058C
l_039_00590:
        lea.l   $6(a2),a0                       ; 00590
        lea.l   WeaponPlaces(pc),a1             ; 00594
        lea.l   $1440.w,a4                      ; 00598
        move.w  #$18,d0                         ; 0059C
        swap    d0                              ; 005A0
        move.w  #$5,d0                          ; 005A2
        move.w  #$d,(DrawColour).l              ; 005A6
        bsr.w   PrintTextHUD                    ; 005AE
        rts                                     ; 005B2
l_039_005B4:
        rts                                     ; 005B4

;-------------------------------------------------------------------------------
; ShowHeadingText - In an outside view (OutsideView): "HDG" and the heading in degrees
; (obj_Heading / 80).
;-------------------------------------------------------------------------------
ShowHeadingText:
        tst.b   (OutsideView).l                 ; 005B6
        beq.w   l_039_00648                     ; 005BC
        tst.b   (ReadoutsDrawn).l               ; 005C0
        beq.b   l_039_005B4                     ; 005C6
        btst    #$6,(StatusBitsLow).l           ; 005C8
        beq.b   l_039_005B4                     ; 005D0
        lea.l   (ObjectTable).l,a0              ; 005D2
        move.w  (ViewObject).l,d1               ; 005D8
        move.w  obj_Heading(a0,d1.w),d0         ; 005DE
        ext.l   d0                              ; 005E2
        asr.l   #$3,d0                          ; 005E4
        divu.w  #$a,d0                          ; 005E6
        move.w  d0,(HeadingTens).l              ; 005EA
        ext.l   d0                              ; 005F0
        move.l  d0,(BCDIn).l                    ; 005F2
        jsr     (BinToBCD).l                    ; 005F8
        lea.l   HeadingPanelPlaces(pc),a1       ; 005FE
        lea.l   (TextBuffer).l,a2               ; 00602
        lea.l   $6(a2),a0                       ; 00608
        move.b  #$48,(a2)                       ; 0060C
        move.b  #$44,$1(a2)                     ; 00610
        move.b  #$47,$2(a2)                     ; 00616
        moveq   #$5,d0                          ; 0061C
        moveq   #$2,d2                          ; 0061E
        lea.l   $1cca.w,a4                      ; 00620
        lea.l   $a.w,a5                         ; 00624
        move.w  #$fca,d6                        ; 00628
        move.w  #$0,d5                          ; 0062C
        movem.l d0/d2/a0-a2/a4-a5,-(a7)         ; 00630
        bsr.w   PanelDigitsOne                  ; 00634
        movem.l (a7)+,d0/d2/a0-a2/a4-a5         ; 00638
        move.w  #$f3a,d6                        ; 0063C
        move.w  #$c,d5                          ; 00640
        bsr.w   PanelDigitsOne                  ; 00644
l_039_00648:
        rts                                     ; 00648

;-------------------------------------------------------------------------------
; EmptyReadout - Does nothing (an instrument with no readout).
;-------------------------------------------------------------------------------
EmptyReadout:
        rts                                     ; 0064A

;-------------------------------------------------------------------------------
; ShowSpeed - The speed readout: the speed flown (obj_SpeedFlown) / 12; 0 for a destroyed
; aircraft.
;-------------------------------------------------------------------------------
ShowSpeed:
        lea.l   (ObjectTable).l,a1              ; 0064C
        adda.w  (ViewObject).l,a1               ; 00652
        moveq   #$0,d0                          ; 00658
        btst    #$7,obj_Flags(a1)               ; 0065A
        bne.b   l_039_0066A                     ; 00660
        move.w  obj_SpeedFlown(a1),d0           ; 00662
        bge.b   l_039_0066A                     ; 00666
        neg.w   d0                              ; 00668
l_039_0066A:
        tst.b   (OutsideView).l                 ; 0066A
        beq.b   l_039_00686                     ; 00670
        tst.b   (ReadoutsDrawn).l               ; 00672
        beq.b   l_039_00692                     ; 00678
        btst    #$6,(StatusBitsLow).l           ; 0067A
        beq.b   l_039_00692                     ; 00682
        bra.b   l_039_00694                     ; 00684
l_039_00686:
        lea.l   (SpeedShown).l,a1               ; 00686
        bsr.w   ValueChanged                    ; 0068C
        bge.b   l_039_00694                     ; 00690
l_039_00692:
        rts                                     ; 00692
l_039_00694:
        ext.l   d0                              ; 00694
        divu.w  #$c,d0                          ; 00696
        ext.l   d0                              ; 0069A
        move.l  d0,(BCDIn).l                    ; 0069C
        jsr     (BinToBCD).l                    ; 006A2
        moveq   #$3,d0                          ; 006A8
        lea.l   (TextBuffer5).l,a2              ; 006AA
        lea.l   $4(a2),a0                       ; 006B0
        tst.b   (OutsideView).l                 ; 006B4
        beq.b   l_039_006CA                     ; 006BA
        lea.l   SpeedPanelPlaces2(pc),a1        ; 006BC
        lea.l   $1cd2.w,a4                      ; 006C0
        lea.l   $12.w,a5                        ; 006C4
        bra.b   l_039_006D6                     ; 006C8
l_039_006CA:
        lea.l   SpeedPanelPlaces(pc),a1         ; 006CA
        lea.l   $1a0e.w,a4                      ; 006CE
        lea.l   $1e.w,a5                        ; 006D2
l_039_006D6:
        move.w  #$fca,d6                        ; 006D6
        tst.b   (OutsideView).l                 ; 006DA
        bne.b   l_039_006EA                     ; 006E0
        move.w  #$4,d5                          ; 006E2
        bra.w   l_039_00E40                     ; 006E6
l_039_006EA:
        move.w  #$0,d5                          ; 006EA
        addq.w  #$3,d0                          ; 006EE
        move.b  #$4b,$4(a2)                     ; 006F0
        move.b  #$54,$5(a2)                     ; 006F6
        move.b  #$53,$6(a2)                     ; 006FC
        movem.l d0/a0-a2/a4-a5,-(a7)            ; 00702
        bsr.w   PanelDigitsD0                   ; 00706
        movem.l (a7)+,d0/a0-a2/a4-a5            ; 0070A
        move.w  #$f3a,d6                        ; 0070E
        move.w  #$c,d5                          ; 00712
        bra.w   PanelDigitsD0                   ; 00716

;-------------------------------------------------------------------------------
; ShowAltitude - The altitude readout from the height (obj_Y), at most 99,999 (or AltitudeValue
; in another mode).
;-------------------------------------------------------------------------------
ShowAltitude:
        tst.b   (RadarAltimeterOn).l            ; 0071A
        beq.b   l_039_00738                     ; 00720
        move.l  (AltitudeValue).l,d0            ; 00722
        cmpi.l  #$1869f,d0                      ; 00728
        ble.b   l_039_00754                     ; 0072E
        move.l  #$1869f,d0                      ; 00730
        bra.b   l_039_00754                     ; 00736
l_039_00738:
        lea.l   (ObjectTable).l,a0              ; 00738
        adda.w  (ViewObject).l,a0               ; 0073E
        move.l  obj_Y(a0),d0                    ; 00744
        asr.l   #$7,d0                          ; 00748
        asr.l   #$3,d0                          ; 0074A
        move.l  d0,d1                           ; 0074C
        add.l   d0,d0                           ; 0074E
        add.l   d0,d0                           ; 00750
        add.l   d1,d0                           ; 00752
l_039_00754:
        tst.b   (OutsideView).l                 ; 00754
        beq.b   l_039_00770                     ; 0075A
        tst.b   (ReadoutsDrawn).l               ; 0075C
        beq.b   l_039_00790                     ; 00762
        btst    #$6,(StatusBitsLow).l           ; 00764
        beq.b   l_039_00790                     ; 0076C
        bra.b   l_039_007A6                     ; 0076E
l_039_00770:
        tst.b   (PanelRedraw).l                 ; 00770
        bgt.b   l_039_007A6                     ; 00776
        move.l  (AltitudeShown).l,d2            ; 00778
        blt.b   l_039_00792                     ; 0077E
        cmp.l   d2,d0                           ; 00780
        beq.b   l_039_00790                     ; 00782
        btst    #$0,(BlinkPhase).l              ; 00784
        bne.b   l_039_00790                     ; 0078C
        bra.b   l_039_007A6                     ; 0078E
l_039_00790:
        rts                                     ; 00790
l_039_00792:
        andi.l  #$7fffffff,(AltitudeShown).l    ; 00792
        andi.l  #$7fffffff,d2                   ; 0079C
        move.l  d2,d0                           ; 007A2
        bra.b   l_039_007B6                     ; 007A4
l_039_007A6:
        move.l  d0,(AltitudeShown).l            ; 007A6
        ori.l   #$80000000,(AltitudeShown).l    ; 007AC
l_039_007B6:
        move.l  d0,(BCDIn).l                    ; 007B6
        jsr     (BinToBCD).l                    ; 007BC
        moveq   #$5,d0                          ; 007C2
        lea.l   AltitudePanelPlaces(pc),a1      ; 007C4
        lea.l   (TextBuffer4).l,a2              ; 007C8
        lea.l   $6(a2),a0                       ; 007CE
        tst.b   (OutsideView).l                 ; 007D2
        beq.b   l_039_007E4                     ; 007D8
        lea.l   $1cda.w,a4                      ; 007DA
        lea.l   $1a.w,a5                        ; 007DE
        bra.b   l_039_007EC                     ; 007E2
l_039_007E4:
        lea.l   $18ce.w,a4                      ; 007E4
        lea.l   $1e.w,a5                        ; 007E8
l_039_007EC:
        move.w  #$fca,d6                        ; 007EC
        tst.b   (OutsideView).l                 ; 007F0
        bne.b   l_039_00800                     ; 007F6
        move.w  #$4,d5                          ; 007F8
        bra.w   l_039_00E40                     ; 007FC
l_039_00800:
        move.w  #$0,d5                          ; 00800
        addq.w  #$2,d0                          ; 00804
        move.b  #$46,$6(a2)                     ; 00806
        move.b  #$54,$7(a2)                     ; 0080C
        movem.l d0/a0-a2/a4-a5,-(a7)            ; 00812
        bsr.w   PanelDigitsD0                   ; 00816
        movem.l (a7)+,d0/a0-a2/a4-a5            ; 0081A
        move.w  #$f3a,d6                        ; 0081E
        move.w  #$c,d5                          ; 00822
        bra.w   PanelDigitsD0                   ; 00826

;-------------------------------------------------------------------------------
; ShowFuel - The fuel readout: the viewed aircraft's fuel (obj_Fuel) / 256, five digits.
;-------------------------------------------------------------------------------
ShowFuel:
        lea.l   (ObjectTable).l,a1              ; 0082A
        adda.w  (ViewObject).l,a1               ; 00830
        move.l  obj_Fuel(a1),d0                 ; 00836
        asr.l   #$8,d0                          ; 0083A
        lea.l   (FuelShown).l,a1                ; 0083C
        bsr.w   ValueChanged                    ; 00842
        bge.b   l_039_0084A                     ; 00846
        rts                                     ; 00848
l_039_0084A:
        ext.l   d0                              ; 0084A
        move.l  d0,(BCDIn).l                    ; 0084C
        jsr     (BinToBCD).l                    ; 00852
        moveq   #$4,d0                          ; 00858
        lea.l   FuelPlaces(pc),a1               ; 0085A
        lea.l   (TextBuffer1).l,a2              ; 0085E
        lea.l   $5(a2),a0                       ; 00864
        lea.l   $1ca4.w,a4                      ; 00868
        lea.l   $c.w,a5                         ; 0086C
        move.w  #$0,d5                          ; 00870
        bra.w   DrawPanelDigits                 ; 00874

;-------------------------------------------------------------------------------
; ShowThrottle - The throttle readout in percent: obj_Throttle (0-120) x 256 / $133.
;-------------------------------------------------------------------------------
ShowThrottle:
        lea.l   (ObjectTable).l,a1              ; 00878
        adda.w  (ViewObject).l,a1               ; 0087E
        move.b  obj_Throttle(a1),d0             ; 00884
        ext.w   d0                              ; 00888
        asl.w   #$8,d0                          ; 0088A
        bge.b   l_039_00890                     ; 0088C
        neg.w   d0                              ; 0088E
l_039_00890:
        ext.l   d0                              ; 00890
        divu.w  #$133,d0                        ; 00892
        lea.l   (ThrottleShown).l,a1            ; 00896
        bsr.w   ValueChanged                    ; 0089C
        bge.b   l_039_008A4                     ; 008A0
        rts                                     ; 008A2
l_039_008A4:
        ext.l   d0                              ; 008A4
        move.l  d0,(BCDIn).l                    ; 008A6
        jsr     (BinToBCD).l                    ; 008AC
        moveq   #$2,d0                          ; 008B2
        lea.l   WeaponRangePlaces(pc),a1        ; 008B4
        lea.l   (TextBuffer).l,a2               ; 008B8
        lea.l   $3(a2),a0                       ; 008BE
        lea.l   $1b76.w,a4                      ; 008C2
        lea.l   $1e.w,a5                        ; 008C6
        move.w  #$4,d5                          ; 008CA
        bra.w   l_039_00E3C                     ; 008CE

;-------------------------------------------------------------------------------
; ShowGridZ - The position readout's Z: (obj_Z - $10000000) / 256 / $7000 + $177, three digits;
; drawn only when it changes (twice, for both display buffers).
;-------------------------------------------------------------------------------
ShowGridZ:
        lea.l   (ObjectTable).l,a1              ; 008D2
        adda.w  (ViewObject).l,a1               ; 008D8
        move.l  obj_Z(a1),d0                    ; 008DE
        subi.l  #$10000000,d0                   ; 008E2
        asr.l   #$8,d0                          ; 008E8
        divs.w  #$7000,d0                       ; 008EA
        addi.w  #$177,d0                        ; 008EE
        cmp.w   (GridZShown).l,d0               ; 008F2
        bne.b   l_039_0090A                     ; 008F8
        tst.b   (GridZRedraw).l                 ; 008FA
        ble.b   l_039_0095E                     ; 00900
        subq.b  #$1,(GridZRedraw).l             ; 00902
        bra.b   l_039_00918                     ; 00908
l_039_0090A:
        move.w  d0,(GridZShown).l               ; 0090A
        move.b  #$2,(GridZRedraw).l             ; 00910
l_039_00918:
        tst.b   (RadarAltimeterOn).l            ; 00918
        bne.b   l_039_0092E                     ; 0091E
        ext.l   d0                              ; 00920
        move.l  d0,(BCDIn).l                    ; 00922
        jsr     (BinToBCD).l                    ; 00928
l_039_0092E:
        moveq   #$3,d0                          ; 0092E
        lea.l   GridZPlaces(pc),a1              ; 00930
        lea.l   (TextBuffer).l,a2               ; 00934
        lea.l   $4(a2),a0                       ; 0093A
        lea.l   $1c44.w,a4                      ; 0093E
        lea.l   $24.w,a5                        ; 00942
        move.w  #$4,d5                          ; 00946
        movem.l d0/a0-a2/a4-a5,-(a7)            ; 0094A
        bsr.w   DrawPanelDigits                 ; 0094E
        movem.l (a7)+,d0/a0-a2/a4-a5            ; 00952
        move.w  #$c,d5                          ; 00956
        bra.w   DrawPanelDigits                 ; 0095A
l_039_0095E:
        rts                                     ; 0095E

;-------------------------------------------------------------------------------
; ShowGridX - The position readout's X, worked out as ShowGridZ from obj_X.
;-------------------------------------------------------------------------------
ShowGridX:
        lea.l   (ObjectTable).l,a1              ; 00960
        adda.w  (ViewObject).l,a1               ; 00966
        move.l  obj_X(a1),d0                    ; 0096C
        subi.l  #$f000000,d0                    ; 00970
        asr.l   #$8,d0                          ; 00976
        divs.w  #$5999,d0                       ; 00978
        addi.w  #$4c4,d0                        ; 0097C
        cmp.w   (GridXShown).l,d0               ; 00980
        bne.b   l_039_00998                     ; 00986
        tst.b   (GridXRedraw).l                 ; 00988
        ble.b   l_039_009EC                     ; 0098E
        subq.b  #$1,(GridXRedraw).l             ; 00990
        bra.b   l_039_009A6                     ; 00996
l_039_00998:
        move.w  d0,(GridXShown).l               ; 00998
        move.b  #$2,(GridXRedraw).l             ; 0099E
l_039_009A6:
        tst.b   (RadarAltimeterOn).l            ; 009A6
        bne.b   l_039_009BC                     ; 009AC
        ext.l   d0                              ; 009AE
        move.l  d0,(BCDIn).l                    ; 009B0
        jsr     (BinToBCD).l                    ; 009B6
l_039_009BC:
        moveq   #$3,d0                          ; 009BC
        lea.l   GridXPlaces(pc),a1              ; 009BE
        lea.l   (TextBuffer).l,a2               ; 009C2
        lea.l   $4(a2),a0                       ; 009C8
        lea.l   $1d84.w,a4                      ; 009CC
        lea.l   $24.w,a5                        ; 009D0
        move.w  #$4,d5                          ; 009D4
        movem.l d0/a0-a2/a4-a5,-(a7)            ; 009D8
        bsr.w   DrawPanelDigits                 ; 009DC
        movem.l (a7)+,d0/a0-a2/a4-a5            ; 009E0
        move.w  #$c,d5                          ; 009E4
        bra.w   DrawPanelDigits                 ; 009E8
l_039_009EC:
        rts                                     ; 009EC

;-------------------------------------------------------------------------------
; TargetReadout - The locked target's readout on the panel (twice a frame stage, every few
; frames): its type - MIG-29 ($12), MIG-25 ($13), AF-1 ($14), 707 ($16), 767 ($17), F-16 ($10),
; CRUISE ($15) - or NO SIG until its signature is confirmed (obj_Status bit 6), then in turn
; its altitude (ALT:), heading (HDG:, degrees) and speed (SPD:).
;-------------------------------------------------------------------------------
TargetReadout:
        move.w  (LockedTarget).l,d2             ; 009EE
        blt.w   l_039_00C10                     ; 009F4
        move.w  (StatusBits).l,d3               ; 009F8
        andi.w  #$81,d3                         ; 009FE
        bne.w   l_039_00C10                     ; 00A02
        subq.b  #$1,(RadarBlipTimer).l          ; 00A06
        bge.w   l_039_00C10                     ; 00A0C
        move.b  #$ff,(RadarBlipTimer).l         ; 00A10
        lea.l   (ObjectTable).l,a1              ; 00A18
        tst.b   (TargetReadoutRedraw).l         ; 00A1E
        bgt.b   l_039_00A6A                     ; 00A24
        tst.b   (TargetReadoutCount).l          ; 00A26
        blt.b   l_039_00A40                     ; 00A2C
        btst    #$0,(TargetReadoutCount).l      ; 00A2E
        beq.b   l_039_009EC                     ; 00A36
        move.w  (TargetReadoutMode).l,d0        ; 00A38
        bra.b   l_039_00A58                     ; 00A3E
l_039_00A40:
        move.b  #$1,(TargetReadoutCount).l      ; 00A40
        move.w  (TargetReadoutMode).l,d0        ; 00A48
        addq.w  #$1,d0                          ; 00A4E
        cmpi.w  #$3,d0                          ; 00A50
        ble.b   l_039_00A58                     ; 00A54
        moveq   #$1,d0                          ; 00A56
l_039_00A58:
        bset    #$f,d0                          ; 00A58
        move.w  d0,(TargetReadoutMode).l        ; 00A5C
        move.b  #$2,(TargetReadoutRedraw).l     ; 00A62
l_039_00A6A:
        move.w  (TargetReadoutMode).l,d0        ; 00A6A
        bclr    #$f,d0                          ; 00A70
        bne.b   l_039_00A84                     ; 00A74
        subq.b  #$1,(TargetReadoutRedraw).l     ; 00A76
        bge.w   l_039_00CA6                     ; 00A7C
        bra.w   l_039_00D78                     ; 00A80
l_039_00A84:
        move.w  d0,(TargetReadoutMode).l        ; 00A84
        lea.l   (TargetText).l,a2               ; 00A8A
        lea.l   (TextBlankLine).l,a1            ; 00A90
l_039_00A96:
        move.b  (a1)+,d1                        ; 00A96
        beq.b   l_039_00A9E                     ; 00A98
        move.b  d1,(a2)+                        ; 00A9A
        bra.b   l_039_00A96                     ; 00A9C
l_039_00A9E:
        andi.b  #$3f,(LampBits).l               ; 00A9E
        ori.b   #$80,(LampBits).l               ; 00AA6
        lea.l   (ObjectTable).l,a4              ; 00AAE
        adda.w  d2,a4                           ; 00AB4
        btst    #$6,obj_Status(a4)              ; 00AB6
        bne.b   l_039_00AD0                     ; 00ABC
        lea.l   (TextNoSig).l,a1                ; 00ABE
        andi.b  #$3f,(LampBits).l               ; 00AC4
        bra.w   l_039_00B56                     ; 00ACC
l_039_00AD0:
        move.b  obj_Type(a4),d1                 ; 00AD0
        cmpi.b  #$12,d1                         ; 00AD4
        bne.b   l_039_00AE4                     ; 00AD8
        lea.l   (TextMiG29).l,a1                ; 00ADA
        bra.w   l_039_00B56                     ; 00AE0
l_039_00AE4:
        cmpi.b  #$13,d1                         ; 00AE4
        bne.b   l_039_00AF2                     ; 00AE8
        lea.l   (TextMiG25).l,a1                ; 00AEA
        bra.b   l_039_00B56                     ; 00AF0
l_039_00AF2:
        cmpi.b  #$14,d1                         ; 00AF2
        bne.b   l_039_00B00                     ; 00AF6
        lea.l   (TextAF1).l,a1                  ; 00AF8
        bra.b   l_039_00B28                     ; 00AFE
l_039_00B00:
        cmpi.b  #$16,d1                         ; 00B00
        bne.b   l_039_00B0E                     ; 00B04
        lea.l   (Text707).l,a1                  ; 00B06
        bra.b   l_039_00B28                     ; 00B0C
l_039_00B0E:
        cmpi.b  #$17,d1                         ; 00B0E
        bne.b   l_039_00B1C                     ; 00B12
        lea.l   (Text767).l,a1                  ; 00B14
        bra.b   l_039_00B28                     ; 00B1A
l_039_00B1C:
        cmpi.b  #$10,d1                         ; 00B1C
        bne.b   l_039_00B3A                     ; 00B20
        lea.l   (TextF16).l,a1                  ; 00B22
l_039_00B28:
        andi.b  #$3f,(LampBits).l               ; 00B28
        ori.b   #$40,(LampBits).l               ; 00B30
        bra.b   l_039_00B56                     ; 00B38
l_039_00B3A:
        cmpi.b  #$15,d1                         ; 00B3A
        bne.b   l_039_00B64                     ; 00B3E
        lea.l   (TextCruise).l,a1               ; 00B40
        andi.b  #$3f,(LampBits).l               ; 00B46
        ori.b   #$80,(LampBits).l               ; 00B4E
l_039_00B56:
        lea.l   (ReadoutText1).l,a2             ; 00B56
l_039_00B5C:
        move.b  (a1)+,d1                        ; 00B5C
        beq.b   l_039_00B64                     ; 00B5E
        move.b  d1,(a2)+                        ; 00B60
        bra.b   l_039_00B5C                     ; 00B62
l_039_00B64:
        lea.l   (ReadoutText2).l,a2             ; 00B64
        subq.w  #$1,d0                          ; 00B6A
        bne.b   l_039_00B9E                     ; 00B6C
        lea.l   (TextALT).l,a1                  ; 00B6E
l_039_00B74:
        move.b  (a1)+,d1                        ; 00B74
        beq.b   l_039_00B7C                     ; 00B76
        move.b  d1,(a2)+                        ; 00B78
        bra.b   l_039_00B74                     ; 00B7A
l_039_00B7C:
        move.l  obj_Y(a4),d0                    ; 00B7C
        asr.l   #$7,d0                          ; 00B80
        asr.l   #$3,d0                          ; 00B82
        move.l  d0,d1                           ; 00B84
        add.l   d0,d0                           ; 00B86
        add.l   d0,d0                           ; 00B88
        add.l   d1,d0                           ; 00B8A
        lea.l   (ReadoutText3).l,a2             ; 00B8C
        moveq   #$4,d2                          ; 00B92
        moveq   #$0,d4                          ; 00B94
        bsr.w   PutDigits                       ; 00B96
        bra.w   l_039_00CA6                     ; 00B9A
l_039_00B9E:
        subq.w  #$1,d0                          ; 00B9E
        bne.b   l_039_00BD0                     ; 00BA0
        lea.l   (TextHDG).l,a1                  ; 00BA2
l_039_00BA8:
        move.b  (a1)+,d1                        ; 00BA8
        beq.b   l_039_00BB0                     ; 00BAA
        move.b  d1,(a2)+                        ; 00BAC
        bra.b   l_039_00BA8                     ; 00BAE
l_039_00BB0:
        move.w  obj_Heading(a4),d0              ; 00BB0
        ext.l   d0                              ; 00BB4
        asr.l   #$3,d0                          ; 00BB6
        divu.w  #$a,d0                          ; 00BB8
        ext.l   d0                              ; 00BBC
        lea.l   (ReadoutText3a).l,a2            ; 00BBE
        moveq   #$2,d2                          ; 00BC4
        moveq   #$1,d4                          ; 00BC6
        bsr.w   PutDigits                       ; 00BC8
        bra.w   l_039_00CA6                     ; 00BCC
l_039_00BD0:
        subq.w  #$1,d0                          ; 00BD0
        bne.w   l_039_00CA6                     ; 00BD2
        lea.l   (TextSPD).l,a1                  ; 00BD6
l_039_00BDC:
        move.b  (a1)+,d1                        ; 00BDC
        beq.b   l_039_00BE4                     ; 00BDE
        move.b  d1,(a2)+                        ; 00BE0
        bra.b   l_039_00BDC                     ; 00BE2
l_039_00BE4:
        moveq   #$0,d0                          ; 00BE4
        btst    #$7,obj_Flags(a4)               ; 00BE6
        bne.b   l_039_00BF6                     ; 00BEC
        move.w  obj_SpeedFlown(a4),d0           ; 00BEE
        bge.b   l_039_00BF6                     ; 00BF2
        neg.w   d0                              ; 00BF4
l_039_00BF6:
        ext.l   d0                              ; 00BF6
        divu.w  #$c,d0                          ; 00BF8
        ext.l   d0                              ; 00BFC
        lea.l   (ReadoutText3a).l,a2            ; 00BFE
        moveq   #$3,d2                          ; 00C04
        moveq   #$0,d4                          ; 00C06
        bsr.w   PutDigits                       ; 00C08
        bra.w   l_039_00CA6                     ; 00C0C
l_039_00C10:
        tst.w   (TargetReadoutMode).l           ; 00C10
        beq.b   l_039_00C1C                     ; 00C16
        bgt.b   l_039_00C64                     ; 00C18
        bra.b   l_039_00C6E                     ; 00C1A
l_039_00C1C:
        move.w  (WarningPlaying).l,d0           ; 00C1C
        cmp.w   (TargetReadoutShown).l,d0       ; 00C22
        beq.b   l_039_00C96                     ; 00C28
        move.w  d0,(TargetReadoutShown).l       ; 00C2A
        andi.w  #$ff,d0                         ; 00C30
        add.w   d0,d0                           ; 00C34
        add.w   d0,d0                           ; 00C36
        move.w  d0,d1                           ; 00C38
        add.w   d0,d0                           ; 00C3A
        add.w   d0,d1                           ; 00C3C
        add.w   d0,d0                           ; 00C3E
        add.w   d0,d1                           ; 00C40
        addq.w  #$1,d1                          ; 00C42
        lea.l   (Messages).l,a1                 ; 00C44
        adda.w  d1,a1                           ; 00C4A
        lea.l   (TargetText).l,a2               ; 00C4C
        moveq   #$1a,d1                         ; 00C52
l_039_00C54:
        move.b  (a1)+,(a2)+                     ; 00C54
        dbra    d1,l_039_00C54                  ; 00C56
        move.b  #$2,(TargetReadoutRedraw).l     ; 00C5A
        bra.b   l_039_00CA6                     ; 00C62
l_039_00C64:
        move.w  #$ffff,(TargetReadoutMode).l    ; 00C64
        bra.b   l_039_00C7E                     ; 00C6C
l_039_00C6E:
        clr.w   (TargetReadoutMode).l           ; 00C6E
        bra.b   l_039_00C7E                     ; 00C74
	dc.b	$13,$FC,$00,$02
        dc.l    TargetReadoutRedraw             ; 00C7A
l_039_00C7E:
        lea.l   (Messages).l,a1                 ; 00C7E
        addq.w  #$1,a1                          ; 00C84
        lea.l   (TargetText).l,a2               ; 00C86
        moveq   #$1a,d1                         ; 00C8C
l_039_00C8E:
        move.b  (a1)+,(a2)+                     ; 00C8E
        dbra    d1,l_039_00C8E                  ; 00C90
        bra.b   l_039_00CA6                     ; 00C94
l_039_00C96:
        tst.b   (TargetReadoutRedraw).l         ; 00C96
        ble.w   l_039_00D78                     ; 00C9C
        subq.b  #$1,(TargetReadoutRedraw).l     ; 00CA0
l_039_00CA6:
        lea.l   (TargetText).l,a2               ; 00CA6
        lea.l   WeaponPlaces(pc),a1             ; 00CAC
        lea.l   $1e0c.w,a4                      ; 00CB0
        lea.l   $c.w,a5                         ; 00CB4
        moveq   #$19,d0                         ; 00CB8
        move.w  #$fca,d6                        ; 00CBA
        swap    d6                              ; 00CBE
        move.w  (ViewShift).l,d6                ; 00CC0
        move.l  (PanelShakeOffset).l,d7         ; 00CC6
        movem.l d0/d6-d7/a1-a2/a4-a5,-(a7)      ; 00CCC
        move.b  (LampBits).l,d3                 ; 00CD0
        rol.b   #$2,d3                          ; 00CD6
        andi.b  #$3,d3                          ; 00CD8
        beq.b   l_039_00CF4                     ; 00CDC
        subq.b  #$1,d3                          ; 00CDE
        beq.b   l_039_00D06                     ; 00CE0
        move.w  #$c,d5                          ; 00CE2
        bsr.w   DrawPanelCharsIfShown           ; 00CE6
        move.w  #$4,d5                          ; 00CEA
        move.w  #$0,d3                          ; 00CEE
        bra.b   l_039_00D16                     ; 00CF2
l_039_00CF4:
        move.w  #$0,d5                          ; 00CF4
        bsr.w   DrawPanelCharsIfShown           ; 00CF8
        move.w  #$c,d5                          ; 00CFC
        move.w  #$4,d3                          ; 00D00
        bra.b   l_039_00D16                     ; 00D04
l_039_00D06:
        move.w  #$4,d5                          ; 00D06
        bsr.w   DrawPanelCharsIfShown           ; 00D0A
        move.w  #$c,d5                          ; 00D0E
        move.w  #$0,d3                          ; 00D12
l_039_00D16:
        movem.l (a7)+,d0/d6-d7/a1-a2/a4-a5      ; 00D16
        tst.b   (OutsideView).l                 ; 00D1A
        beq.b   l_039_00D3E                     ; 00D20
        tst.b   (TrainingReady).l               ; 00D22
        beq.b   l_039_00D78                     ; 00D28
        lea.l   $1b14.w,a4                      ; 00D2A
        lea.l   $c.w,a5                         ; 00D2E
        move.w  #$c,d5                          ; 00D32
        move.w  #$f3a,d6                        ; 00D36
        bra.w   l_039_00E8C                     ; 00D3A
l_039_00D3E:
        tst.b   (WarningLampCount).l            ; 00D3E
        blt.b   l_039_00D78                     ; 00D44
        subq.b  #$1,(WarningLampCount).l        ; 00D46
        swap    d6                              ; 00D4C
        move.w  #$f0a,d6                        ; 00D4E
        swap    d6                              ; 00D52
        movem.l d0/d3/d6-d7/a1-a2/a4-a5,-(a7)   ; 00D54
        bsr.w   DrawPanelCharsIfShown           ; 00D58
        movem.l (a7)+,d0/d3/d6-d7/a1-a2/a4-a5   ; 00D5C
        move.w  d3,d5                           ; 00D60

;-------------------------------------------------------------------------------
; DrawPanelCharsIfShown - DrawPanelChars, in the cockpit, or outside while TrainingReady is
; set.
;-------------------------------------------------------------------------------
DrawPanelCharsIfShown:
        tst.b   (OutsideView).l                 ; 00D62
        beq.w   DrawPanelChars                  ; 00D68
        tst.b   (TrainingReady).l               ; 00D6C
        beq.b   l_039_00D78                     ; 00D72
        bra.w   DrawPanelChars                  ; 00D74
l_039_00D78:
        rts                                     ; 00D78

;-------------------------------------------------------------------------------
; PutDigits - PutDigits(d0 = value, a2 = the end of the field, d2 = digits - 1, d4 = keep
; leading zeros): writes the value in decimal backwards into a text.
;-------------------------------------------------------------------------------
PutDigits:
        move.l  d0,(BCDIn).l                    ; 00D7A
        jsr     (BinToBCD).l                    ; 00D80
        move.l  (BCDOut).l,d3                   ; 00D86
        move.w  d2,d0                           ; 00D8C
l_039_00D8E:
        move.w  d3,d1                           ; 00D8E
        andi.w  #$f,d1                          ; 00D90
        addi.w  #$30,d1                         ; 00D94
        move.b  d1,-(a2)                        ; 00D98
        lsr.l   #$4,d3                          ; 00D9A
        dbra    d2,l_039_00D8E                  ; 00D9C
        tst.b   d4                              ; 00DA0
        bne.b   l_039_00DB6                     ; 00DA2
        subq.w  #$1,d0                          ; 00DA4
l_039_00DA6:
        cmpi.b  #$30,(a2)+                      ; 00DA6
        bne.b   l_039_00DB6                     ; 00DAA
        move.b  #$20,-$1(a2)                    ; 00DAC
        dbra    d0,l_039_00DA6                  ; 00DB2
l_039_00DB6:
        rts                                     ; 00DB6
; TextBlankLine - 26 spaces: clears the target readout.
TextBlankLine:
	dc.b	'                          '
	dc.b	$00
; TextALT - "ALT:"
TextALT:
	dc.b	$41,$4C,$54,$3A,$00
; TextHDG - "HDG:"
TextHDG:
	dc.b	$48,$44,$47,$3A,$00
; TextSPD - "SPD:"
TextSPD:
	dc.b	$53,$50,$44,$3A,$00
; TextMiG29 - "MIG-29" (written M1G-29 on the disk).
TextMiG29:
	dc.b	'M1G-29'
	dc.b	$00
; TextMiG25 - "MIG-25" (written M1G-25).
TextMiG25:
	dc.b	'M1G-25'
	dc.b	$00
; TextAF1 - " AF-1 "
TextAF1:
	dc.b	' AF-1 '
	dc.b	$00
; TextF16 - " F-16 "
TextF16:
	dc.b	' F-16 '
	dc.b	$00
; TextCruise - "CRUISE"
TextCruise:
	dc.b	'CRUISE'
	dc.b	$00
; TextNoSig - "NO SIG": the target's signature is not confirmed yet.
TextNoSig:
	dc.b	'NO SIG'
	dc.b	$00
Text707:
	dc.b	' 707  '
	dc.b	$00
Text767:
	dc.b	' 767  '
	dc.b	$00

;-------------------------------------------------------------------------------
; PanelDigitsD0 - DrawPanelDigits with the count in d0 and no offset.
;-------------------------------------------------------------------------------
PanelDigitsD0:
        swap    d6                              ; 00E1A
        move.w  #$0,d6                          ; 00E1C
        moveq   #$0,d7                          ; 00E20
        move.w  d0,d2                           ; 00E22
        bra.b   l_039_00E50                     ; 00E24

;-------------------------------------------------------------------------------
; PanelDigitsOne - DrawPanelDigits for one digit.
;-------------------------------------------------------------------------------
PanelDigitsOne:
        swap    d6                              ; 00E26
        move.w  #$0,d6                          ; 00E28
        moveq   #$0,d7                          ; 00E2C
        moveq   #$1,d4                          ; 00E2E
        bra.b   l_039_00E52                     ; 00E30
	dc.b	$78,$01,$60,$1C

;-------------------------------------------------------------------------------
; DrawPanelDigits - Draws an instrument's digits (BCDOut) on the panel: a4 the screen offset,
; a1 the digits' columns, d5 the colour.
;-------------------------------------------------------------------------------
DrawPanelDigits:
        move.w  #$f3a,d6                        ; 00E36
        bra.b   l_039_00E40                     ; 00E3A
l_039_00E3C:
        move.w  #$fca,d6                        ; 00E3C
l_039_00E40:
        swap    d6                              ; 00E40
        move.w  (ViewShift).l,d6                ; 00E42
        move.l  (PanelShakeOffset).l,d7         ; 00E48
        move.w  d0,d2                           ; 00E4E
l_039_00E50:
        moveq   #$0,d4                          ; 00E50
l_039_00E52:
        move.l  (BCDOut).l,d3                   ; 00E52
l_039_00E58:
        move.w  d3,d1                           ; 00E58
        andi.w  #$f,d1                          ; 00E5A
        addi.w  #$30,d1                         ; 00E5E
        cmpi.w  #$39,d1                         ; 00E62
        ble.b   l_039_00E6A                     ; 00E66
        addq.w  #$7,d1                          ; 00E68
l_039_00E6A:
        move.b  d1,-(a0)                        ; 00E6A
        lsr.l   #$4,d3                          ; 00E6C
        dbra    d2,l_039_00E58                  ; 00E6E
        tst.b   d4                              ; 00E72
        bne.b   DrawPanelChars                  ; 00E74
        move.w  d0,d2                           ; 00E76
        subq.w  #$1,d2                          ; 00E78
l_039_00E7A:
        cmpi.b  #$30,(a0)+                      ; 00E7A
        bne.b   DrawPanelChars                  ; 00E7E
        move.b  #$20,-$1(a0)                    ; 00E80
        dbra    d2,l_039_00E7A                  ; 00E86
        bra.b   DrawPanelChars                  ; 00E8A
l_039_00E8C:
        swap    d6                              ; 00E8C
        move.w  #$0,d6                          ; 00E8E
        moveq   #$0,d7                          ; 00E92

;-------------------------------------------------------------------------------
; DrawPanelChars - Draws a string's characters (a2) into the panel's planes with the panel
; font, at the places given in a1 (byte offset and shift), skipping those off the screen.
;-------------------------------------------------------------------------------
DrawPanelChars:
        adda.l  d7,a4                           ; 00E94
        move.w  #$142,d7                        ; 00E96
        movea.l (DrawPlanes).l,a0               ; 00E9A
        move.l  (a0,d5.w),d1                    ; 00EA0
        add.w   d6,d6                           ; 00EA4
l_039_00EA6:
        move.w  (a1)+,d5                        ; 00EA6
        move.w  (a1)+,d3                        ; 00EA8
        move.b  (a2)+,d4                        ; 00EAA
        move.w  a5,d2                           ; 00EAC
        add.w   d6,d2                           ; 00EAE
        add.w   d5,d2                           ; 00EB0
        blt.b   l_039_00EF0                     ; 00EB2
        cmpi.w  #$28,d2                         ; 00EB4
        bge.b   l_039_00EF0                     ; 00EB8
        add.w   d6,d5                           ; 00EBA
        ext.l   d5                              ; 00EBC
        add.l   a4,d5                           ; 00EBE
        add.l   d1,d5                           ; 00EC0
        andi.w  #$ff,d4                         ; 00EC2
        subi.w  #$20,d4                         ; 00EC6
        add.w   d4,d4                           ; 00ECA
        lea.l   (PanelFont).l,a3                ; 00ECC
        adda.w  (a3,d4.w),a3                    ; 00ED2
        move.l  a3,d4                           ; 00ED6
        swap    d6                              ; 00ED8
        move.w  d6,d2                           ; 00EDA
        swap    d6                              ; 00EDC
        or.w    d3,d2                           ; 00EDE
        btst    #$0,d5                          ; 00EE0
        bne.b   l_039_00EF6                     ; 00EE4
        move.l  d1,-(a7)                        ; 00EE6
        move.l  d5,d1                           ; 00EE8
        bsr.w   DrawPanelChar                   ; 00EEA
        move.l  (a7)+,d1                        ; 00EEE
l_039_00EF0:
        dbra    d0,l_039_00EA6                  ; 00EF0
        rts                                     ; 00EF4
l_039_00EF6:
        move.w  #$46,(DebugCheckpoint).l        ; 00EF6
        jsr     (Nop).l                         ; 00EFE
        bra.b   l_039_00EF0                     ; 00F04

;-------------------------------------------------------------------------------
; DrawPanelChar - Draws one character of the panel font into the planes (for DrawPanelChars).
;-------------------------------------------------------------------------------
DrawPanelChar:
        movem.l d0-d1/d6,-(a7)                  ; 00F06
        swap    d2                              ; 00F0A
        move.w  d3,d2                           ; 00F0C
        swap    d2                              ; 00F0E
        move.w  d7,d6                           ; 00F10
        movea.l d4,a0                           ; 00F12
        movea.l d1,a3                           ; 00F14
        lsr.w   #$6,d6                          ; 00F16
        subq.w  #$1,d6                          ; 00F18
        move.w  d2,d0                           ; 00F1A
        rol.w   #$4,d2                          ; 00F1C
        andi.w  #$f,d2                          ; 00F1E
        andi.w  #$f0,d0                         ; 00F22
        beq.b   l_039_00F80                     ; 00F26
        andi.w  #$c0,d0                         ; 00F28
        bne.b   l_039_00F58                     ; 00F2C
l_039_00F2E:
        move.l  #$e0000000,d1                   ; 00F2E
        moveq   #$0,d0                          ; 00F34
        move.b  (a0),d0                         ; 00F36
        ror.l   #$8,d0                          ; 00F38
        lsr.l   d2,d1                           ; 00F3A
        lsr.l   d2,d0                           ; 00F3C
        move.l  (a3),d3                         ; 00F3E
        not.l   d0                              ; 00F40
        and.l   d1,d0                           ; 00F42
        not.l   d1                              ; 00F44
        and.l   d3,d1                           ; 00F46
        or.l    d0,d1                           ; 00F48
        move.l  d1,(a3)                         ; 00F4A
        addq.w  #$1,a0                          ; 00F4C
        adda.w  #$28,a3                         ; 00F4E
        dbra    d6,l_039_00F2E                  ; 00F52
        bra.b   l_039_00F9A                     ; 00F56
l_039_00F58:
        move.l  #$e0000000,d1                   ; 00F58
        moveq   #$0,d0                          ; 00F5E
        move.b  (a0),d0                         ; 00F60
        ror.l   #$8,d0                          ; 00F62
        lsr.l   d2,d1                           ; 00F64
        lsr.l   d2,d0                           ; 00F66
        move.l  (a3),d3                         ; 00F68
        and.l   d1,d0                           ; 00F6A
        not.l   d1                              ; 00F6C
        and.l   d3,d1                           ; 00F6E
        or.l    d0,d1                           ; 00F70
        move.l  d1,(a3)                         ; 00F72
        addq.w  #$1,a0                          ; 00F74
        adda.w  #$28,a3                         ; 00F76
        dbra    d6,l_039_00F58                  ; 00F7A
        bra.b   l_039_00F9A                     ; 00F7E
l_039_00F80:
        move.l  #$e0000000,d1                   ; 00F80
        lsr.l   d2,d1                           ; 00F86
        move.l  (a3),d3                         ; 00F88
        not.l   d1                              ; 00F8A
        and.l   d3,d1                           ; 00F8C
        move.l  d1,(a3)                         ; 00F8E
        addq.w  #$1,a0                          ; 00F90
        adda.w  #$28,a3                         ; 00F92
        dbra    d6,l_039_00F80                  ; 00F96
l_039_00F9A:
        swap    d2                              ; 00F9A
        move.w  d2,d3                           ; 00F9C
        swap    d6                              ; 00F9E
        movem.l (a7)+,d0-d1/d6                  ; 00FA0
        rts                                     ; 00FA4
l_039_00FA6:
        rts                                     ; 00FA6

;-------------------------------------------------------------------------------
; ShowMissilesLeft - The number of missiles left (obj_Missiles) by the weapon's type on the
; panel, while MissilesLeftRedraw counts down.
;-------------------------------------------------------------------------------
ShowMissilesLeft:
        tst.b   (MissilesLeftRedraw).l          ; 00FA8
        ble.b   l_039_00FA6                     ; 00FAE
        subq.b  #$1,(MissilesLeftRedraw).l      ; 00FB0
        lea.l   (ObjectTable).l,a1              ; 00FB6
        adda.w  (ViewObject).l,a1               ; 00FBC
        moveq   #$0,d0                          ; 00FC2
        move.b  obj_Missiles(a1),d0             ; 00FC4
        lea.l   (TextBuffer).l,a2               ; 00FC8
        move.b  obj_Weapon(a1),d2               ; 00FCE
        andi.b  #$f0,d2                         ; 00FD2
        beq.w   l_039_010DA                     ; 00FD6
        cmpi.b  #$10,d2                         ; 00FDA
        beq.b   l_039_01028                     ; 00FDE
        cmpi.b  #$30,d2                         ; 00FE0
        beq.b   l_039_01006                     ; 00FE4
        move.b  #$20,(a2)                       ; 00FE6
        move.b  #$53,$1(a2)                     ; 00FEA
        move.b  #$57,$2(a2)                     ; 00FF0
        lsr.b   #$4,d0                          ; 00FF6
        lea.l   $5(a2),a0                       ; 00FF8
        moveq   #$4,d6                          ; 00FFC
        moveq   #$0,d7                          ; 00FFE
        lea.l   MissilesLeftPlaces(pc),a1       ; 01000
        bra.b   l_039_01048                     ; 01004
l_039_01006:
        move.b  #$20,(a2)                       ; 01006
        move.b  #$41,$1(a2)                     ; 0100A
        move.b  #$4d,$2(a2)                     ; 01010
        andi.b  #$f,d0                          ; 01016
        lea.l   $5(a2),a0                       ; 0101A
        moveq   #$4,d6                          ; 0101E
        moveq   #$0,d7                          ; 01020
        lea.l   MissilesLeftPlaces(pc),a1       ; 01022
        bra.b   l_039_01048                     ; 01026
l_039_01028:
        move.w  obj_Rounds(a1),d0               ; 01028
        move.b  #$47,(a2)                       ; 0102C
        move.b  #$55,$1(a2)                     ; 01030
        move.b  #$4e,$2(a2)                     ; 01036
        lea.l   $7(a2),a0                       ; 0103C
        moveq   #$6,d6                          ; 01040
        moveq   #$2,d7                          ; 01042
        lea.l   MissilesLeftPlaces(pc),a1       ; 01044
l_039_01048:
        move.b  #$20,$3(a2)                     ; 01048
        move.b  #$20,$5(a2)                     ; 0104E
        move.b  #$20,$6(a2)                     ; 01054
        move.w  d7,d2                           ; 0105A
        lea.l   $1cc6.w,a4                      ; 0105C
        lea.l   $6.w,a5                         ; 01060
        move.w  #$fca,d6                        ; 01064
        move.w  #$4,d5                          ; 01068
        move.w  d0,-(a7)                        ; 0106C
        moveq   #$2,d0                          ; 0106E
        swap    d6                              ; 01070
        move.w  (ViewShift).l,d6                ; 01072
        move.l  (PanelShakeOffset).l,d7         ; 01078
        bsr.w   DrawPanelChars                  ; 0107E
        move.w  (a7)+,d0                        ; 01082
        lea.l   (TextBuffer).l,a2               ; 01084
        tst.w   d0                              ; 0108A
        ble.b   l_039_010A0                     ; 0108C
        move.b  #$41,(a2)                       ; 0108E
        move.b  #$52,$1(a2)                     ; 01092
        move.b  #$4d,$2(a2)                     ; 01098
        bra.b   l_039_010B0                     ; 0109E
l_039_010A0:
        move.b  #$20,(a2)                       ; 010A0
        move.b  #$4e,$1(a2)                     ; 010A4
        move.b  #$4f,$2(a2)                     ; 010AA
l_039_010B0:
        lea.l   MissilesLeftPlaces(pc),a1       ; 010B0
        move.w  d7,d2                           ; 010B4
        lea.l   $1b86.w,a4                      ; 010B6
        lea.l   $6.w,a5                         ; 010BA
        move.w  #$4,d5                          ; 010BE
        move.w  #$fca,d6                        ; 010C2
        swap    d6                              ; 010C6
        moveq   #$2,d0                          ; 010C8
        move.w  (ViewShift).l,d6                ; 010CA
        move.l  (PanelShakeOffset).l,d7         ; 010D0
        bra.w   DrawPanelChars                  ; 010D6
l_039_010DA:
        move.b  #$20,(a2)                       ; 010DA
        move.b  #$20,$1(a2)                     ; 010DE
        move.b  #$20,$2(a2)                     ; 010E4
        lea.l   MissilesLeftPlaces(pc),a1       ; 010EA
        move.w  d7,d2                           ; 010EE
        lea.l   $1cc6.w,a4                      ; 010F0
        lea.l   $6.w,a5                         ; 010F4
        move.w  #$4,d5                          ; 010F8
        move.w  #$fca,d6                        ; 010FC
        swap    d6                              ; 01100
        move.w  (ViewShift).l,d6                ; 01102
        move.l  (PanelShakeOffset).l,d7         ; 01108
        moveq   #$2,d0                          ; 0110E
        bsr.w   DrawPanelChars                  ; 01110
        lea.l   (TextBuffer).l,a2               ; 01114
        lea.l   MissilesLeftPlaces(pc),a1       ; 0111A
        move.w  d7,d2                           ; 0111E
        lea.l   $1b86.w,a4                      ; 01120
        lea.l   $6.w,a5                         ; 01124
        move.w  #$4,d5                          ; 01128
        moveq   #$2,d0                          ; 0112C
        move.w  #$fca,d6                        ; 0112E
        swap    d6                              ; 01132
        move.w  (ViewShift).l,d6                ; 01134
        move.l  (PanelShakeOffset).l,d7         ; 0113A
        bra.w   DrawPanelChars                  ; 01140

;-------------------------------------------------------------------------------
; DrawSmallNumber - Draws the number d2 (BinToBCD) with the panel's digits at the places in a1.
;-------------------------------------------------------------------------------
DrawSmallNumber:
        ext.l   d2                              ; 01144
        move.l  d2,(BCDIn).l                    ; 01146
        jsr     (BinToBCD).l                    ; 0114C
        lea.l   WeaponRangePlaces(pc),a1        ; 01152
        lea.l   (TextBuffer).l,a2               ; 01156
        move.w  d3,d2                           ; 0115C
        lea.l   $1(a2,d2.w),a0                  ; 0115E
        move.w  d0,d3                           ; 01162
        andi.w  #$f,d3                          ; 01164
        asr.w   #$2,d3                          ; 01168
        addq.w  #$2,d3                          ; 0116A
        add.w   d3,d3                           ; 0116C
        add.w   d3,d3                           ; 0116E
        adda.w  d3,a1                           ; 01170
        asr.w   #$3,d0                          ; 01172
        ext.l   d0                              ; 01174
        asl.w   #$3,d1                          ; 01176
        move.w  d1,d3                           ; 01178
        add.w   d3,d3                           ; 0117A
        add.w   d3,d3                           ; 0117C
        add.w   d3,d1                           ; 0117E
        ext.l   d1                              ; 01180
        movea.l d1,a4                           ; 01182
        bclr    #$0,d0                          ; 01184
        adda.l  d0,a4                           ; 01188
        swap    d0                              ; 0118A
        move.w  d2,d0                           ; 0118C
        moveq   #$0,d6                          ; 0118E
        moveq   #$0,d7                          ; 01190
        moveq   #$1,d4                          ; 01192
        bra.b   l_039_011D0                     ; 01194

;-------------------------------------------------------------------------------
; PrintNumberShifted - PrintNumber (from its second step), moved with the view (ViewShift) and
; the shaking.
;-------------------------------------------------------------------------------
PrintNumberShifted:
        move.w  (ViewShift).l,d6                ; 01196
        move.l  (PanelShakeOffset).l,d7         ; 0119C
        bra.b   l_039_011CC                     ; 011A2

;-------------------------------------------------------------------------------
; PrintNumberHUD0 - PrintNumberHUD with d4 = 0.
;-------------------------------------------------------------------------------
PrintNumberHUD0:
        moveq   #$0,d4                          ; 011A4

;-------------------------------------------------------------------------------
; PrintNumberHUD - PrintNumber on the head-up display: moved with the view (ViewShift) and the
; shaking.
;-------------------------------------------------------------------------------
PrintNumberHUD:
        move.w  (ViewShift).l,d6                ; 011A6
        move.l  (PanelShakeOffset).l,d7         ; 011AC
        bra.b   l_039_011D0                     ; 011B2

;-------------------------------------------------------------------------------
; PrintTextHUD - Draws the text at a2 (no number conversion) on the head-up display, moved with
; the view and the shaking.
;-------------------------------------------------------------------------------
PrintTextHUD:
        move.w  (ViewShift).l,d6                ; 011B4
        move.l  (PanelShakeOffset).l,d7         ; 011BA
        bra.b   l_039_01200                     ; 011C0

;-------------------------------------------------------------------------------
; PrintTextFixed - Draws the text at a2 without moving it with the view.
;-------------------------------------------------------------------------------
PrintTextFixed:
        moveq   #$0,d6                          ; 011C2
        moveq   #$0,d7                          ; 011C4
        bra.b   l_039_01200                     ; 011C6

;-------------------------------------------------------------------------------
; PrintNumber - Writes the number in BCDOut as digits (leading zeros as spaces) into a text and
; draws it on the panel.
;-------------------------------------------------------------------------------
PrintNumber:
        moveq   #$0,d6                          ; 011C8
        moveq   #$0,d7                          ; 011CA
l_039_011CC:
        move.w  d0,d2                           ; 011CC
        moveq   #$0,d4                          ; 011CE
l_039_011D0:
        move.l  (BCDOut).l,d3                   ; 011D0
        move.w  d2,d5                           ; 011D6
l_039_011D8:
        move.w  d3,d1                           ; 011D8
        andi.w  #$f,d1                          ; 011DA
        addi.w  #$30,d1                         ; 011DE
        move.b  d1,-(a0)                        ; 011E2
        lsr.l   #$4,d3                          ; 011E4
        dbra    d2,l_039_011D8                  ; 011E6
        tst.b   d4                              ; 011EA
        bne.b   l_039_01200                     ; 011EC
        subq.w  #$1,d5                          ; 011EE
l_039_011F0:
        cmpi.b  #$30,(a0)+                      ; 011F0
        bne.b   l_039_01200                     ; 011F4
        move.b  #$20,-$1(a0)                    ; 011F6
        subq.w  #$1,d5                          ; 011FC
        bge.b   l_039_011F0                     ; 011FE
l_039_01200:
        adda.l  d7,a4                           ; 01200
        move.w  #$142,d7                        ; 01202
        movea.l (DrawPlanes).l,a5               ; 01206
        add.w   d6,d6                           ; 0120C
l_039_0120E:
        move.w  (a1)+,d5                        ; 0120E
        move.w  (a1)+,d3                        ; 01210
        move.b  (a2)+,d4                        ; 01212
        cmpi.b  #$20,d4                         ; 01214
        beq.w   l_039_012CC                     ; 01218
        swap    d0                              ; 0121C
        move.w  d0,d2                           ; 0121E
        swap    d0                              ; 01220
        add.w   d6,d2                           ; 01222
        add.w   d5,d2                           ; 01224
        blt.w   l_039_012CC                     ; 01226
        cmpi.w  #$28,d2                         ; 0122A
        bge.w   l_039_012CC                     ; 0122E
        add.w   d6,d5                           ; 01232
        ext.l   d5                              ; 01234
        add.l   a4,d5                           ; 01236
        andi.w  #$ff,d4                         ; 01238
        subi.w  #$20,d4                         ; 0123C
        add.w   d4,d4                           ; 01240
        lea.l   (PanelFont).l,a3                ; 01242
        adda.w  (a3,d4.w),a3                    ; 01248
        move.l  a3,d4                           ; 0124C
        move.l  (a5),d1                         ; 0124E
        add.l   d5,d1                           ; 01250
        btst    #$0,d1                          ; 01252
        beq.b   l_039_0125A                     ; 01256
        bra.b   l_039_012CC                     ; 01258
l_039_0125A:
        move.w  #$b0a,d2                        ; 0125A
        btst    #$3,(PrintColour).l             ; 0125E
        beq.b   l_039_0126C                     ; 01266
        move.w  #$bfa,d2                        ; 01268
l_039_0126C:
        or.w    d3,d2                           ; 0126C
        bsr.w   DrawCharPlane                   ; 0126E
        move.l  $4(a5),d1                       ; 01272
        add.l   d5,d1                           ; 01276
        move.w  #$b0a,d2                        ; 01278
        btst    #$2,(PrintColour).l             ; 0127C
        beq.b   l_039_0128A                     ; 01284
        move.w  #$bfa,d2                        ; 01286
l_039_0128A:
        or.w    d3,d2                           ; 0128A
        bsr.w   DrawCharPlane                   ; 0128C
        move.l  $8(a5),d1                       ; 01290
        add.l   d5,d1                           ; 01294
        move.w  #$b0a,d2                        ; 01296
        btst    #$1,(PrintColour).l             ; 0129A
        beq.b   l_039_012A8                     ; 012A2
        move.w  #$bfa,d2                        ; 012A4
l_039_012A8:
        or.w    d3,d2                           ; 012A8
        bsr.w   DrawCharPlane                   ; 012AA
        move.l  $c(a5),d1                       ; 012AE
        add.l   d5,d1                           ; 012B2
        move.w  #$b0a,d2                        ; 012B4
        btst    #$0,(PrintColour).l             ; 012B8
        beq.b   l_039_012C6                     ; 012C0
        move.w  #$bfa,d2                        ; 012C2
l_039_012C6:
        or.w    d3,d2                           ; 012C6
        bsr.w   DrawCharPlane                   ; 012C8
l_039_012CC:
        dbra    d0,l_039_0120E                  ; 012CC
        rts                                     ; 012D0
l_039_012D2:
        lea.l   (TextPages).l,a0                ; 012D2
        move.b  (TextPageIndex).l,d0            ; 012D8
        ext.w   d0                              ; 012DE
        tst.w   $2(a0,d0.w)                     ; 012E0
        beq.b   l_039_012F0                     ; 012E4
        addq.b  #$2,(TextPageIndex).l           ; 012E6
        bra.w   l_039_013E6                     ; 012EC
l_039_012F0:
        move.b  #$1,(TextStatus).l              ; 012F0
        move.w  #$32,(TextHoldTimer).l          ; 012F8
        bra.w   l_039_013B6                     ; 01300
l_039_01304:
        btst    #$0,(PageFlags).l               ; 01304
        bne.b   l_039_0133A                     ; 0130C
        subq.b  #$1,(PrintFlag).l               ; 0130E
        blt.b   l_039_0133A                     ; 01314
        movem.l (PrintLineStart).l,a1-a2/a4     ; 01316
        movem.l a1-a2/a4,(PrintPosition).l      ; 0131E
        move.b  (MusicState).l,d1               ; 01326
        beq.b   l_039_01332                     ; 0132C
        subq.b  #$1,d1                          ; 0132E
        bne.b   l_039_01338                     ; 01330
l_039_01332:
        moveq   #$2,d1                          ; 01332
        bsr.w   TypeClick                       ; 01334
l_039_01338:
        rts                                     ; 01338
l_039_0133A:
        addq.w  #$1,a2                          ; 0133A
        move.b  (a2)+,d0                        ; 0133C
        ext.w   d0                              ; 0133E
        asl.w   #$2,d0                          ; 01340
        move.w  d0,(PrintIndex).l               ; 01342
        move.b  (a2),(PageFlags).l              ; 01348
        blt.b   l_039_0136A                     ; 0134E
        addq.w  #$1,a2                          ; 01350
        move.b  #$1,(PrintFlag).l               ; 01352
        move.b  (a2)+,d1                        ; 0135A
        move.b  d1,d6                           ; 0135C
        andi.w  #$f0,d6                         ; 0135E
        lsr.w   #$4,d6                          ; 01362
        move.w  d6,(TextColour).l               ; 01364
l_039_0136A:
        move.w  #$ffff,(PrintCount).l           ; 0136A
        adda.l  (TextCursor).l,a4               ; 01372
        andi.w  #$f,d1                          ; 01378
        lea.l   (TextPages).l,a0                ; 0137C
        move.b  (TextPageIndex).l,d0            ; 01382
        ext.w   d0                              ; 01388
        move.w  (a0,d0.w),d0                    ; 0138A
        btst    #$e,d0                          ; 0138E
        beq.b   l_039_0139E                     ; 01392
        move.b  #$2,(TypeDelay).l               ; 01394
        bra.b   l_039_013A4                     ; 0139C
l_039_0139E:
        move.b  d1,(TypeDelay).l                ; 0139E
l_039_013A4:
        lea.l   (TextColumns).l,a1              ; 013A4
        movem.l a1-a2/a4,(PrintLineStart).l     ; 013AA
        bra.w   l_039_017F4                     ; 013B2
l_039_013B6:
        clr.b   (TextPageIndex).l               ; 013B6
        clr.l   (TextPages).l                   ; 013BC
        bra.b   l_039_013EC                     ; 013C2
l_039_013C4:
        move.l  #$1b8,(TextCursor).l            ; 013C4
        tst.w   (TextHoldTimer).l               ; 013CE
        ble.b   l_039_013E6                     ; 013D4
        subq.w  #$1,(TextHoldTimer).l           ; 013D6
        bgt.b   l_039_013E6                     ; 013DC
        ori.b   #$80,(TextStatus).l             ; 013DE
l_039_013E6:
        clr.b   (TextShowing).l                 ; 013E6
l_039_013EC:
        rts                                     ; 013EC

;-------------------------------------------------------------------------------
; PrintText - The text printer, once a frame (GameFrame's last stages): shows the queue of text
; pages (TextPages) one after another, typing them out a character per frame or more with a
; click (TypeClick), each page held TextHoldTimer frames; sets TextStatus bit 7 when the queue
; is done. With TextStatus 2 (the callsign) or 3 (the security countercode) it takes typed keys
; from KeyBuffer instead: letters and digits (KeyToAscii) up to InputLength, backspace, and
; Return, which saves the callsign (SaveConfig) or checks the code (CheckSecurityAnswer).
;-------------------------------------------------------------------------------
PrintText:
        tst.b   (TextPaused).l                  ; 013EE
        bne.b   l_039_013EC                     ; 013F4
        lea.l   (TextPages).l,a0                ; 013F6
        move.b  (TextPageIndex).l,d1            ; 013FC
        ext.w   d1                              ; 01402
        move.w  (a0,d1.w),d0                    ; 01404
        beq.b   l_039_013C4                     ; 01408
        tst.b   d1                              ; 0140A
        bne.b   l_039_01414                     ; 0140C
        move.w  d0,(TextPageShown).l            ; 0140E
l_039_01414:
        tst.b   (TextShowing).l                 ; 01414
        bne.w   l_039_0151A                     ; 0141A
        clr.b   (InputPos).l                    ; 0141E
        lea.l   (TextColumns).l,a1              ; 01424
        lea.l   (TextPageTable).l,a0            ; 0142A
        move.w  d0,d2                           ; 01430
        bgt.b   l_039_01444                     ; 01432
        movea.l (PrintTarget).l,a4              ; 01434
        adda.l  #$1b8,a4                        ; 0143A
        andi.w  #$3fff,d0                       ; 01440
l_039_01444:
        subq.w  #$1,d0                          ; 01444
        add.w   d0,d0                           ; 01446
        move.w  (a0,d0.w),d0                    ; 01448
        lea.l   (a0,d0.w),a2                    ; 0144C
        tst.w   d2                              ; 01450
        bge.b   l_039_01458                     ; 01452
        addq.w  #$2,a2                          ; 01454
        bra.b   l_039_0146E                     ; 01456
l_039_01458:
        moveq   #$0,d0                          ; 01458
        move.b  (a2)+,d0                        ; 0145A
        asl.w   #$3,d0                          ; 0145C
        move.w  d0,d1                           ; 0145E
        asl.w   #$2,d0                          ; 01460
        add.w   d1,d0                           ; 01462
        move.b  (a2)+,d1                        ; 01464
        ext.w   d1                              ; 01466
        add.w   d1,d0                           ; 01468
        ext.l   d0                              ; 0146A
        movea.l d0,a4                           ; 0146C
l_039_0146E:
        clr.w   (TextHoldTimer).l               ; 0146E
        clr.w   (PrintIndex).l                  ; 01474
        clr.w   (PrintCount).l                  ; 0147A
        cmpi.b  #$2,(TextStatus).l              ; 01480
        bge.b   l_039_01492                     ; 01488
        clr.b   (TextStatus).l                  ; 0148A
        bra.b   l_039_014C4                     ; 01490
l_039_01492:
        clr.b   (KeyBufferCount).l              ; 01492
        clr.b   (KeyBufferOut).l                ; 01498
        clr.b   (KeyBufferIn).l                 ; 0149E
        lea.l   (KeyBuffer).l,a0                ; 014A4
        lea.l   (SecurityInput).l,a3            ; 014AA
        moveq   #$9,d0                          ; 014B0
l_039_014B2:
        clr.b   (a0)+                           ; 014B2
        clr.b   (a3)+                           ; 014B4
        dbra    d0,l_039_014B2                  ; 014B6
        moveq   #$0,d4                          ; 014BA
        clr.b   (PrintDelay).l                  ; 014BC
        bra.b   l_039_014D4                     ; 014C2
l_039_014C4:
        move.b  #$1,(PrintDelay).l              ; 014C4
        move.b  #$1,(PrintFlag).l               ; 014CC
l_039_014D4:
        move.b  #$1,(TextShowing).l             ; 014D4
        move.b  (a2)+,(PageFlags).l             ; 014DC
        move.b  (a2)+,d1                        ; 014E2
        move.b  d1,d6                           ; 014E4
        andi.w  #$f0,d6                         ; 014E6
        lsr.w   #$4,d6                          ; 014EA
        move.w  d6,(TextColour).l               ; 014EC
        btst    #$e,d2                          ; 014F2
        beq.b   l_039_01504                     ; 014F6
        move.b  #$2,(TypeDelay).l               ; 014F8
        bra.w   l_039_0165C                     ; 01500
l_039_01504:
        andi.w  #$f,d1                          ; 01504
        move.b  d1,(TypeDelay).l                ; 01508
        movem.l a1-a2/a4,(PrintLineStart).l     ; 0150E
        bra.w   l_039_0165C                     ; 01516
l_039_0151A:
        tst.w   (TextHoldTimer).l               ; 0151A
        bgt.w   l_039_013C4                     ; 01520
        cmpi.b  #$2,(TextStatus).l              ; 01524
        bge.b   l_039_0155C                     ; 0152C
        subq.w  #$1,(PrintIndex).l              ; 0152E
        bgt.w   l_039_013EC                     ; 01534
        btst    #$0,(PageFlags).l               ; 01538
        bne.b   l_039_0154E                     ; 01540
        movem.l (PrintLineStart).l,a1-a2/a4     ; 01542
        bra.w   l_039_015F6                     ; 0154A
l_039_0154E:
        subq.w  #$1,(PrintCount).l              ; 0154E
        ble.w   l_039_015F6                     ; 01554
        bra.w   l_039_015E4                     ; 01558
l_039_0155C:
        tst.b   (InputLength).l                 ; 0155C
        blt.w   l_039_015AE                     ; 01562
        lea.l   (KeyBuffer).l,a0                ; 01566
        move.b  (KeyBufferOut).l,d5             ; 0156C
        ext.w   d5                              ; 01572
        move.b  (a0,d5.w),d4                    ; 01574
        beq.w   l_039_013EC                     ; 01578
        cmpi.b  #$44,d4                         ; 0157C
        beq.b   l_039_015AE                     ; 01580
        tst.b   (PrintDelay).l                  ; 01582
        ble.b   l_039_015F6                     ; 01588
        subq.b  #$1,(PrintDelay).l              ; 0158A
        subq.b  #$1,(KeyBufferCount).l          ; 01590
        clr.b   (a0,d5.w)                       ; 01596
        addq.b  #$1,d5                          ; 0159A
        cmpi.b  #$a,d5                          ; 0159C
        blt.b   l_039_015A4                     ; 015A0
        clr.b   d5                              ; 015A2
l_039_015A4:
        move.b  d5,(KeyBufferOut).l             ; 015A4
        bra.w   l_039_01654                     ; 015AA
l_039_015AE:
        cmpi.b  #$3,(TextStatus).l              ; 015AE
        bne.b   l_039_015CA                     ; 015B6
        jsr     (CheckSecurityAnswer).l         ; 015B8
        ori.b   #$80,(TextStatus).l             ; 015BE
        bra.w   l_039_013EC                     ; 015C6
l_039_015CA:
        andi.b  #$fd,(TextStatus).l             ; 015CA
        jsr     (SaveConfig).l                  ; 015D2
        move.b  #$ff,(TextKeyCount).l           ; 015D8
        bra.w   l_039_013EC                     ; 015E0
l_039_015E4:
        tst.b   (PrintDelay).l                  ; 015E4
        ble.w   l_039_013EC                     ; 015EA
        subq.b  #$1,(PrintDelay).l              ; 015EE
        bra.b   l_039_01654                     ; 015F4
l_039_015F6:
        move.b  (TypeDelay).l,d1                ; 015F6
        ext.w   d1                              ; 015FC
        move.w  d1,(PrintCount).l               ; 015FE
        move.b  #$1,(PrintDelay).l              ; 01604
        cmpi.b  #$41,d4                         ; 0160C
        bne.b   l_039_01654                     ; 01610
        tst.b   (InputPos).l                    ; 01612
        ble.b   l_039_01654                     ; 01618
        subq.b  #$1,(InputPos).l                ; 0161A
        addq.b  #$1,(InputLength).l             ; 01620
        movea.l (ConfigBuffer).l,a0             ; 01626
        adda.w  #$1e,a0                         ; 0162C
        move.b  (InputPos).l,d5                 ; 01630
        ext.w   d5                              ; 01636
        clr.b   (a0,d5.w)                       ; 01638
        lea.l   (SecurityInput).l,a0            ; 0163C
        adda.w  d5,a0                           ; 01642
        clr.b   (a0)+                           ; 01644
        clr.b   (a0)                            ; 01646
        movem.l (PrintPosition).l,a1-a2/a4      ; 01648
        subq.w  #$4,a1                          ; 01650
        bra.b   l_039_0165C                     ; 01652
l_039_01654:
        movem.l (PrintPosition).l,a1-a2/a4      ; 01654
l_039_0165C:
        lea.l   (Font).l,a3                     ; 0165C
        movea.l (DrawPlanes).l,a5               ; 01662
        move.w  #$1c2,d7                        ; 01668
        cmpi.b  #$2,(TextStatus).l              ; 0166C
        blt.b   l_039_016CE                     ; 01674
        tst.b   d4                              ; 01676
        beq.w   l_039_017F4                     ; 01678
        andi.w  #$ff,d4                         ; 0167C
        lea.l   (KeyToAscii).l,a0               ; 01680
        move.b  (a0,d4.w),d4                    ; 01686
        beq.w   l_039_017F4                     ; 0168A
        cmpi.b  #$20,d4                         ; 0168E
        blt.b   l_039_016D8                     ; 01692
        tst.b   (PrintDelay).l                  ; 01694
        ble.b   l_039_016D8                     ; 0169A
        cmpi.b  #$3,(TextStatus).l              ; 0169C
        beq.b   l_039_016BC                     ; 016A4
        movea.l (ConfigBuffer).l,a0             ; 016A6
        adda.w  #$1e,a0                         ; 016AC
        move.b  (InputPos).l,d5                 ; 016B0
        ext.w   d5                              ; 016B6
        move.b  d4,(a0,d5.w)                    ; 016B8
l_039_016BC:
        addq.b  #$1,(InputPos).l                ; 016BC
        subq.b  #$1,(InputLength).l             ; 016C2
        bge.b   l_039_016D8                     ; 016C8
        moveq   #$20,d4                         ; 016CA
        bra.b   l_039_016D8                     ; 016CC
l_039_016CE:
        move.b  (a2),d4                         ; 016CE
        blt.w   l_039_012D2                     ; 016D0
        beq.w   l_039_01304                     ; 016D4
l_039_016D8:
        move.w  (a1),d5                         ; 016D8
        ext.l   d5                              ; 016DA
        add.l   a4,d5                           ; 016DC
        move.w  $2(a1),d3                       ; 016DE
        move.w  (TextColour).l,d6               ; 016E2
        andi.w  #$ff,d4                         ; 016E8
        cmpi.b  #$8,d4                          ; 016EC
        bne.b   l_039_01702                     ; 016F0
        tst.b   (PrintDelay).l                  ; 016F2
        bgt.b   l_039_016FC                     ; 016F8
        subq.w  #$4,a1                          ; 016FA
l_039_016FC:
        moveq   #$5c,d4                         ; 016FC
        move.w  #$0,d6                          ; 016FE
l_039_01702:
        subi.w  #$20,d4                         ; 01702
        btst    #$0,(PageFlags).l               ; 01706
        beq.b   l_039_01758                     ; 0170E
        tst.w   d4                              ; 01710
        bne.b   l_039_0173A                     ; 01712
        cmpi.b  #$2,(TextStatus).l              ; 01714
        beq.b   l_039_0173A                     ; 0171C
        move.b  (PageFlags).l,d0                ; 0171E
        andi.b  #$2,d0                          ; 01724
        beq.b   l_039_01758                     ; 01728
        addq.w  #$4,a1                          ; 0172A
        addq.w  #$1,a2                          ; 0172C
        movem.l a1-a2/a4,(PrintPosition).l      ; 0172E
        bra.w   l_039_015F6                     ; 01736
l_039_0173A:
        tst.b   (PrintDelay).l                  ; 0173A
        beq.b   l_039_01758                     ; 01740
        move.b  (MusicState).l,d1               ; 01742
        beq.b   l_039_01752                     ; 01748
        subq.b  #$1,d1                          ; 0174A
        bne.b   l_039_01758                     ; 0174C
        moveq   #$2,d1                          ; 0174E
        bra.b   l_039_01754                     ; 01750
l_039_01752:
        moveq   #$2,d1                          ; 01752
l_039_01754:
        bsr.w   TypeClick                       ; 01754
l_039_01758:
        add.w   d4,d4                           ; 01758
        adda.w  (a3,d4.w),a3                    ; 0175A
        move.l  a3,d4                           ; 0175E
        btst    #$3,d6                          ; 01760
        bne.b   l_039_0176C                     ; 01764
        move.w  #$b0a,d2                        ; 01766
        bra.b   l_039_01770                     ; 0176A
l_039_0176C:
        move.w  #$bfa,d2                        ; 0176C
l_039_01770:
        or.w    d3,d2                           ; 01770
        move.l  (a5),d1                         ; 01772
        add.l   d5,d1                           ; 01774
        bsr.w   DrawCharPlane                   ; 01776
        move.l  $4(a5),d1                       ; 0177A
        add.l   d5,d1                           ; 0177E
        btst    #$2,d6                          ; 01780
        bne.b   l_039_0178C                     ; 01784
        move.w  #$b0a,d2                        ; 01786
        bra.b   l_039_01790                     ; 0178A
l_039_0178C:
        move.w  #$bfa,d2                        ; 0178C
l_039_01790:
        or.w    d3,d2                           ; 01790
        bsr.w   DrawCharPlane                   ; 01792
        move.l  $8(a5),d1                       ; 01796
        add.l   d5,d1                           ; 0179A
        btst    #$1,d6                          ; 0179C
        bne.b   l_039_017A8                     ; 017A0
        move.w  #$b0a,d2                        ; 017A2
        bra.b   l_039_017AC                     ; 017A6
l_039_017A8:
        move.w  #$bfa,d2                        ; 017A8
l_039_017AC:
        or.w    d3,d2                           ; 017AC
        bsr.w   DrawCharPlane                   ; 017AE
        move.l  $c(a5),d1                       ; 017B2
        add.l   d5,d1                           ; 017B6
        btst    #$0,d6                          ; 017B8
        bne.b   l_039_017C4                     ; 017BC
        move.w  #$b0a,d2                        ; 017BE
        bra.b   l_039_017C8                     ; 017C2
l_039_017C4:
        move.w  #$bfa,d2                        ; 017C4
l_039_017C8:
        or.w    d3,d2                           ; 017C8
        bsr.w   DrawCharPlane                   ; 017CA
        btst    #$0,(PageFlags).l               ; 017CE
        bne.b   l_039_017E8                     ; 017D6
        addq.w  #$4,a1                          ; 017D8
        addq.w  #$1,a2                          ; 017DA
        movem.l a1-a2/a4,(PrintPosition).l      ; 017DC
        bra.w   l_039_015F6                     ; 017E4
l_039_017E8:
        tst.b   (PrintDelay).l                  ; 017E8
        bgt.b   l_039_017F4                     ; 017EE
        addq.w  #$4,a1                          ; 017F0
        addq.w  #$1,a2                          ; 017F2
l_039_017F4:
        movem.l a1-a2/a4,(PrintPosition).l      ; 017F4
        rts                                     ; 017FC

;-------------------------------------------------------------------------------
; DrawCharPlane - Draws one character's 8-pixel-wide rows into one bit-plane, set or cleared by
; the colour's bit for that plane (the text is drawn by the CPU, not the blitter).
;-------------------------------------------------------------------------------
DrawCharPlane:
        move.l  d0,-(a7)                        ; 017FE
        move.l  d6,-(a7)                        ; 01800
        swap    d2                              ; 01802
        move.w  d3,d2                           ; 01804
        swap    d2                              ; 01806
        move.w  d7,d6                           ; 01808
        movea.l d4,a0                           ; 0180A
        movea.l d1,a3                           ; 0180C
        lsr.w   #$6,d6                          ; 0180E
        subq.w  #$1,d6                          ; 01810
        move.w  d2,d0                           ; 01812
        rol.w   #$4,d2                          ; 01814
        andi.w  #$f,d2                          ; 01816
        andi.w  #$f0,d0                         ; 0181A
        bne.b   l_039_0183E                     ; 0181E
l_039_01820:
        moveq   #$0,d0                          ; 01820
        move.b  (a0),d0                         ; 01822
        asl.w   #$8,d0                          ; 01824
        swap    d0                              ; 01826
        move.l  (a3),d3                         ; 01828
        lsr.l   d2,d0                           ; 0182A
        not.l   d0                              ; 0182C
        and.l   d0,d3                           ; 0182E
        move.l  d3,(a3)                         ; 01830
        addq.w  #$1,a0                          ; 01832
        adda.w  #$28,a3                         ; 01834
        dbra    d6,l_039_01820                  ; 01838
        bra.b   l_039_0185E                     ; 0183C
l_039_0183E:
        moveq   #$0,d0                          ; 0183E
        move.b  (a0),d0                         ; 01840
        asl.w   #$8,d0                          ; 01842
        swap    d0                              ; 01844
        move.l  (a3),d3                         ; 01846
        lsr.l   d2,d0                           ; 01848
        not.l   d0                              ; 0184A
        and.l   d0,d3                           ; 0184C
        not.l   d0                              ; 0184E
        or.l    d0,d3                           ; 01850
        move.l  d3,(a3)                         ; 01852
        addq.w  #$1,a0                          ; 01854
        adda.w  #$28,a3                         ; 01856
        dbra    d6,l_039_0183E                  ; 0185A
l_039_0185E:
        swap    d2                              ; 0185E
        move.w  d2,d3                           ; 01860
        swap    d6                              ; 01862
        move.l  (a7)+,d6                        ; 01864
        move.l  (a7)+,d0                        ; 01866
        rts                                     ; 01868

;-------------------------------------------------------------------------------
; TypeClick - The printer's click as a character is typed.
;-------------------------------------------------------------------------------
TypeClick:
        moveq   #$1,d0                          ; 0186A
        bra.b   l_039_0189A                     ; 0186C

;-------------------------------------------------------------------------------
; BeepPitch - A beep at the pitch in d0 (in the cockpit view only).
;-------------------------------------------------------------------------------
BeepPitch:
        tst.b   (OutsideView).l                 ; 0186E
        bne.b   l_039_018CC                     ; 01874
        movem.l d0-d7/a0-a4,-(a7)               ; 01876
        ext.l   d0                              ; 0187A
        moveq   #$4,d1                          ; 0187C
        bra.b   l_039_018A6                     ; 0187E
l_039_01880:
        moveq   #$2,d0                          ; 01880
        moveq   #$2,d1                          ; 01882
        bra.b   l_039_0189A                     ; 01884

;-------------------------------------------------------------------------------
; KeyBeep - The beep of a key while flying: only in the cockpit view, then as MenuBeep.
;-------------------------------------------------------------------------------
KeyBeep:
        tst.b   (OutsideView).l                 ; 01886
        bne.b   l_039_018CC                     ; 0188C

;-------------------------------------------------------------------------------
; MenuBeep - The sound of a menu key.
;-------------------------------------------------------------------------------
MenuBeep:
        tst.b   (MusicState).l                  ; 0188E
        bne.b   l_039_01880                     ; 01894
        moveq   #$2,d0                          ; 01896
        moveq   #$4,d1                          ; 01898
l_039_0189A:
        tst.b   (BeepCount).l                   ; 0189A
        bgt.b   l_039_018CC                     ; 018A0
        movem.l d0-d7/a0-a4,-(a7)               ; 018A2
l_039_018A6:
        moveq   #$1,d6                          ; 018A6
        move.l  d0,d7                           ; 018A8
        movea.l d7,a0                           ; 018AA
        move.l  #$12c,d0                        ; 018AC
        moveq   #$1,d2                          ; 018B2
        move.l  d0,d3                           ; 018B4
        move.l  d1,d4                           ; 018B6
        move.l  d2,d5                           ; 018B8
        movem.l d0-d7/a0,-(a7)                  ; 018BA
        jsr     (PlayEffect).l                  ; 018BE
        adda.w  #$24,a7                         ; 018C4
        movem.l (a7)+,d0-d7/a0-a4               ; 018C8
l_039_018CC:
        rts                                     ; 018CC
; KeyToAscii - Raw key code to character: the digits and letters of the main keyboard, space
; ($40) and backspace ($41 gives 8); 0 for keys the input ignores.
KeyToAscii:
	dc.b	$00
	dc.b	'1234567890'
	dc.b	$00,$00,$00,$00,$00
	dc.b	'QWERTYUIOP'
	dc.b	$00,$00,$00,$00,$00,$00
	dc.b	'ASDFGHJKL'
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	'ZXCVBNM'
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$20,$08
	dcb.b	64,$00
h039_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    15,39                           ; 15 longs pointing into hunk 39
	dc.l	$1682,$BD8,$BA4,$B70,$B42,$B24,$B16,$B08
	dc.l	$AFA,$AEC,$ADC,$AC0,$A92,$4C4,$4A8
        dc.l    311,71                          ; 311 longs pointing into hunk 71
	dc.l	$1308,$134A,$14DE,$153C,$170A,$1720,$17D2,$1398
	dc.l	$13A0,$14FC,$150A,$15F8,$FAA,$FB2,$A20,$A66
	dc.l	$A78,$C5E,$C7A,$C98,$CA2,$1DC,$1CE,$1D6
	dc.l	$1FA,$166,$16E,$5C2,$674,$75E,$17A,$370
	dc.l	$46C,$4F0,$574,$5DA,$654,$740,$832,$880
	dc.l	$8DA,$968,$FBE,$174,$36A,$466,$4EA,$56E
	dc.l	$5D4,$64E,$73A,$82C,$87A,$8D4,$962,$A1A
	dc.l	$AB0,$FB8,$33C,$202,$322,$772,$334,$788
	dc.l	$77A,$798,$7A8,$7B2,$898,$688,$83E,$5EC
	dc.l	$D24,$D6E,$C24,$C2C,$C1E,$A8C,$B58,$B66
	dc.l	$B8E,$BC0,$C00,$C4E,$C88,$CA8,$1AE,$25C
	dc.l	$29A,$2D6,$30A,$376,$420,$4E4,$604,$6AC
	dc.l	$7CA,$860,$8BA,$936,$9C4,$FCA,$1086,$1116
	dc.l	$1158,$A08,$A14,$A28,$A32,$A44,$9F0,$A3A
	dc.l	$A4A,$A5E,$A6C,$A86,$C12,$C68,$C70,$1366
	dc.l	$14EE,$16E4,$98A,$992,$9A2,$8FC,$904,$914
	dc.l	$982,$99A,$8F4,$90C,$71C,$91A,$9A8,$280
	dc.l	$2B0,$D88,$E54,$11D2,$19E,$24C,$288,$2C4
	dc.l	$2F8,$3F4,$440,$546,$5F4,$69E,$7B8,$84E
	dc.l	$8A8,$924,$9B2,$D7C,$1148,$14AC,$163E,$1494
	dc.l	$1592,$14A0,$149A,$156E,$15A6,$1420,$1614,$161C
	dc.l	$1632,$16B2,$16BE,$155E,$1622,$16C4,$14A6,$1568
	dc.l	$5B8,$66C,$6B6,$6DC,$756,$7D4,$7F2,$D1C
	dc.l	$D64,$1870,$1888,$D40,$D48,$AA2,$AAA,$AC8
	dc.l	$B2C,$B34,$B4A,$B52,$CD2,$214,$226,$27A
	dc.l	$364,$41A,$474,$5AA,$1262,$1280,$129E,$12BC
	dc.l	$23C,$47E,$13F0,$1328,$1744,$1890,$1374,$13CA
	dc.l	$12DA,$12E8,$1384,$13B8,$13FE,$1410,$12D4,$137E
	dc.l	$13BE,$13F8,$12F4,$13E2,$1484,$148C,$1528,$15B2
	dc.l	$15C2,$15CE,$1670,$16A0,$1718,$131A,$13AE,$1512
	dc.l	$1546,$1310,$1356,$14D0,$1322,$1436,$164C,$1658
	dc.l	$1732,$17E0,$17F8,$14BE,$14C8,$1584,$158C,$15E6
	dc.l	$15F0,$1608,$1696,$16F4,$173C,$17EA,$136E,$147C
	dc.l	$1550,$1600,$1344,$1476,$1530,$12FC,$13D0,$13D8
	dc.l	$1470,$151C,$13E8,$1416,$14D8,$2EC,$2B8,$CC8
	dc.l	$E4A,$107A,$10D2,$110A,$113C,$119E,$11AE,$11BC
	dc.l	$CC2,$E44,$1074,$10CC,$1104,$1136,$1198,$11A8
	dc.l	$11B6,$189C,$15DC,$500,$510,$5CC,$67E,$768
	dc.l	$9FA,$518,$E9C,$1208,$1664,$724,$EFA
        dc.l    18,20                           ; 18 longs pointing into hunk 20
	dc.l	$1A4,$252,$28E,$2CA,$2FE,$3FA,$446,$54C
	dc.l	$5FA,$6A4,$7BE,$854,$8AE,$92A,$9B8,$D82
	dc.l	$114E,$15BA
        dc.l    2,59                            ; 2 longs pointing into hunk 59
	dc.l	$C46,$C80
        dc.l    3,61                            ; 3 longs pointing into hunk 61
	dc.l	$165E,$ECE,$1244
        dc.l    2,2                             ; 2 longs pointing into hunk 2
	dc.l	$1628,$16A8
        dc.l    1,0                             ; 1 longs pointing into hunk 0
	dc.l	$18C0
        dc.l    1,0                             ; 1 longs pointing into hunk 0
	dc.l	$15D4
        dc.l    3,64                            ; 3 longs pointing into hunk 64
	dc.l	$13A6,$1426,$142C
        dc.l    3,36                            ; 3 longs pointing into hunk 36
	dc.l	$242,$494,$4D2
        dc.l    1,7                             ; 1 longs pointing into hunk 7
	dc.l	$F00
	dc.l	0
	dc.l	HUNK_END
	endc
