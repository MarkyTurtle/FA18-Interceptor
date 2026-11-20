; F/A-18 Interceptor - hunk 30 (code)
; ComputerPilot: the computer aircraft's pilots (a state machine steering towards a destination
; or along a route, setting the control bits).
; Included by ../f18_main.s.

;===============================================================================
; Hunk 30: CODE, $11A0 bytes
;===============================================================================
	CODE_HUNK	h030
; PilotStates - The computer pilot's state handlers: one routine for each state (+$05) of an
; aircraft.
PilotStates:
        dc.l    PilotFly                        ; 00000
        dc.l    PilotBank90                     ; 00004
        dc.l    PilotState3                     ; 00008
        dc.l    PilotState4                     ; 0000C
        dc.l    PilotTurnHard                   ; 00010
        dc.l    PilotLevel                      ; 00014
        dc.l    PilotPull                       ; 00018
        dc.l    PilotFly                        ; 0001C
        dc.l    PilotTurnGentle                 ; 00020
        dc.l    PilotWait                       ; 00024
        dc.l    ManAileronRoll                  ; 00028
        dc.l    l_030_0027A                     ; 0002C
        dc.l    l_030_00290                     ; 00030
        dc.l    ManInsideLoop                   ; 00034
        dc.l    l_030_002F8                     ; 00038
        dc.l    l_030_0030E                     ; 0003C
        dc.l    ManSplitS                       ; 00040
        dc.l    l_030_0037C                     ; 00044
        dc.l    l_030_00392                     ; 00048
        dc.l    ManHalfLoop                     ; 0004C
        dc.l    l_030_003F6                     ; 00050
        dc.l    l_030_0040C                     ; 00054
        dc.l    ManBarrelRoll                   ; 00058
        dc.l    l_030_00462                     ; 0005C
        dc.l    l_030_00478                     ; 00060
        dc.l    ManInverted                     ; 00064
        dc.l    l_030_004EA                     ; 00068
        dc.l    l_030_00500                     ; 0006C
        dc.l    l_030_00546                     ; 00070
        dc.l    l_030_00558                     ; 00074
        dc.l    l_030_0056E                     ; 00078
        dc.l    l_030_005D8                     ; 0007C
        dc.l    l_030_005EA                     ; 00080
        dc.l    l_030_00600                     ; 00084
        dc.l    ManTakeoff                      ; 00088
        dc.l    ManClimbOut                     ; 0008C
        dc.l    l_030_00214                     ; 00090
        dc.l    l_030_00252                     ; 00094
        dc.l    ManBreakTurn                    ; 00098
        dc.l    PilotBeforeBreak                ; 0009C
; CombatReactions - How an enemy aircraft reacts when it finds the player on its tail
; (CheckOnTail, hunk 17). 16-byte rows, one word pair (a timer for +$4C, then a pilot state:
; 9 a gentle turn, 5 a harder turn, 2 a break turn) per Difficulty 0-3. The row is chosen by
; the player's range (+$4A): under $300 rows 0-5, under $C00 rows 6-11, under $1E00 rows 12-17,
; farther row 18; within the first three bands +2 rows when the two speeds differ by $C0 or
; more and the enemy is the slower, +4 when it is the faster; +1 row (medium and far bands)
; when it is the player's locked target and the player has just fired. The close band's +1
; row ('being shot at') is never used (see hunk 17).
CombatReactions:
	dc.b	$00,$28,$00,$09,$00,$28,$00,$05,$00,$28,$00,$05,$00,$28,$00,$05
	dc.b	$00,$28,$00,$09,$00,$28,$00,$09,$00,$28,$00,$09,$00,$28,$00,$05
	dc.b	$00,$50,$00,$09,$00,$50,$00,$05,$00,$50,$00,$05,$00,$50,$00,$05
	dc.b	$00,$50,$00,$09,$00,$50,$00,$09,$00,$50,$00,$09,$00,$50,$00,$05
	dc.b	$00,$50,$00,$09,$00,$50,$00,$05,$00,$50,$00,$05,$00,$50,$00,$05
	dc.b	$00,$50,$00,$09,$00,$50,$00,$09,$00,$50,$00,$09,$00,$50,$00,$05
	dc.b	$00,$28,$00,$09,$00,$28,$00,$02,$00,$28,$00,$02,$00,$28,$00,$02
	dc.b	$00,$28,$00,$09,$00,$28,$00,$05,$00,$28,$00,$05,$00,$28,$00,$05
	dc.b	$00,$50,$00,$09,$00,$50,$00,$05,$00,$50,$00,$02,$00,$50,$00,$02
	dc.b	$00,$50,$00,$09,$00,$50,$00,$05,$00,$50,$00,$05,$00,$50,$00,$05
	dc.b	$00,$50,$00,$09,$00,$50,$00,$05,$00,$50,$00,$05,$00,$50,$00,$05
	dc.b	$00,$50,$00,$09,$00,$50,$00,$05,$00,$50,$00,$05,$00,$50,$00,$05
	dc.b	$00,$28,$00,$09,$00,$28,$00,$02,$00,$28,$00,$02,$00,$28,$00,$02
	dc.b	$00,$28,$00,$09,$00,$28,$00,$05,$00,$28,$00,$05,$00,$28,$00,$05
	dc.b	$00,$50,$00,$09,$00,$50,$00,$05,$00,$50,$00,$02,$00,$50,$00,$02
	dc.b	$00,$50,$00,$09,$00,$50,$00,$05,$00,$50,$00,$05,$00,$50,$00,$05
	dc.b	$00,$50,$00,$09,$00,$50,$00,$05,$00,$50,$00,$05,$00,$50,$00,$05
	dc.b	$00,$50,$00,$09,$00,$50,$00,$05,$00,$50,$00,$05,$00,$50,$00,$05
	dc.b	$00,$28,$00,$09,$00,$28,$00,$09,$00,$28,$00,$09,$00,$28,$00,$09

;-------------------------------------------------------------------------------
; ManTakeoff - Take-off (state $23): throttle up until the speed flown reaches $840, then
; (states $24-$26) a timed wait, rotate and climb; back to normal flight above height $240000.
;-------------------------------------------------------------------------------
ManTakeoff:
        cmpi.b  #$60,$2b(a1)                    ; 001D0
        bge.b   l_030_001E0                     ; 001D6
        ori.b   #$1,$65(a1)                     ; 001D8
        bra.b   l_030_001E6                     ; 001DE
l_030_001E0:
        andi.b  #$fc,$65(a1)                    ; 001E0
l_030_001E6:
        cmpi.w  #$840,$6e(a1)                   ; 001E6
        blt.w   l_030_01128                     ; 001EC
        move.b  #$24,$5(a1)                     ; 001F0
        move.w  #$3c,$4c(a1)                    ; 001F6
        bra.w   l_030_01128                     ; 001FC

;-------------------------------------------------------------------------------
; ManClimbOut - The climb after take-off (states $24-$26): waits for the timer, then (state
; $25) pitches up until the pitch (+$66) passes $3840 and back to $68B0, then (state $26) flies
; level until higher than $240000.
;-------------------------------------------------------------------------------
ManClimbOut:
        tst.w   $4c(a1)                         ; 00200
        bge.w   l_030_01128                     ; 00204
        bclr    #$4,$20(a1)                     ; 00208
        move.b  #$25,$5(a1)                     ; 0020E
l_030_00214:
        lea.l   (PitchRates).l,a0               ; 00214
        moveq   #-40,d3                         ; 0021A
        move.w  $66(a1),d4                      ; 0021C
        btst    #$4,$20(a1)                     ; 00220
        bne.b   l_030_00234                     ; 00226
        cmpi.w  #$3840,d4                       ; 00228
        blt.b   l_030_0023A                     ; 0022C
        bset    #$4,$20(a1)                     ; 0022E
l_030_00234:
        cmpi.w  #$68b0,d4                       ; 00234
        blt.b   l_030_00242                     ; 00238
l_030_0023A:
        bsr.w   PitchTowards                    ; 0023A
        bra.w   l_030_01128                     ; 0023E
l_030_00242:
        moveq   #$0,d3                          ; 00242
        bsr.w   PitchTowards                    ; 00244
        clr.b   $65(a1)                         ; 00248
        move.b  #$26,$5(a1)                     ; 0024C
l_030_00252:
        cmpi.l  #$240000,$18(a1)                ; 00252
        bgt.w   l_030_007A0                     ; 0025A
        bra.w   l_030_01128                     ; 0025E

;-------------------------------------------------------------------------------
; ManAileronRoll - The aileron roll (states $0B-$0D): after a 15-frame wait, rolls through a
; full turn and back to level.
;-------------------------------------------------------------------------------
ManAileronRoll:
        bclr    #$3,$20(a1)                     ; 00262
        bclr    #$4,$20(a1)                     ; 00268
        move.b  #$c,$5(a1)                      ; 0026E
        move.w  #$f,$4c(a1)                     ; 00274
l_030_0027A:
        tst.w   $4c(a1)                         ; 0027A
        ble.b   l_030_0028A                     ; 0027E
        bset    #$4,$3(a1)                      ; 00280
        bra.w   l_030_01128                     ; 00286
l_030_0028A:
        move.b  #$d,$5(a1)                      ; 0028A
l_030_00290:
        lea.l   (RollRates).l,a0                ; 00290
        moveq   #$10,d3                         ; 00296
        move.w  (a0,d3.w),d3                    ; 00298
        move.w  $6a(a1),d4                      ; 0029C
        btst    #$4,$20(a1)                     ; 002A0
        bne.b   l_030_002C8                     ; 002A6
        btst    #$3,$20(a1)                     ; 002A8
        bne.b   l_030_002BC                     ; 002AE
        cmpi.w  #$3840,d4                       ; 002B0
        bge.b   l_030_002D8                     ; 002B4
        bset    #$3,$20(a1)                     ; 002B6
l_030_002BC:
        cmpi.w  #$3840,d4                       ; 002BC
        blt.b   l_030_002D8                     ; 002C0
        bset    #$4,$20(a1)                     ; 002C2
l_030_002C8:
        cmpi.w  #$320,d4                        ; 002C8
        blt.w   l_030_007A0                     ; 002CC
        cmpi.w  #$6e00,d4                       ; 002D0
        blt.b   l_030_002D8                     ; 002D4
        moveq   #$0,d3                          ; 002D6
l_030_002D8:
        bsr.w   RollCommand                     ; 002D8
        bra.w   l_030_01128                     ; 002DC

;-------------------------------------------------------------------------------
; ManInsideLoop - The inside loop (states $0E-$10): pitches up through a full loop.
;-------------------------------------------------------------------------------
ManInsideLoop:
        bclr    #$3,$20(a1)                     ; 002E0
        bclr    #$4,$20(a1)                     ; 002E6
        move.b  #$f,$5(a1)                      ; 002EC
        move.w  #$f,$4c(a1)                     ; 002F2
l_030_002F8:
        tst.w   $4c(a1)                         ; 002F8
        ble.b   l_030_00308                     ; 002FC
        bset    #$4,$3(a1)                      ; 002FE
        bra.w   l_030_01128                     ; 00304
l_030_00308:
        move.b  #$10,$5(a1)                     ; 00308
l_030_0030E:
        lea.l   (PitchRates).l,a0               ; 0030E
        moveq   #$c,d3                          ; 00314
        move.w  (a0,d3.w),d3                    ; 00316
        neg.w   d3                              ; 0031A
        move.w  $66(a1),d4                      ; 0031C
        btst    #$4,$20(a1)                     ; 00320
        bne.b   l_030_00348                     ; 00326
        btst    #$3,$20(a1)                     ; 00328
        bne.b   l_030_0033C                     ; 0032E
        cmpi.w  #$3840,d4                       ; 00330
        ble.b   l_030_00350                     ; 00334
        bset    #$3,$20(a1)                     ; 00336
l_030_0033C:
        cmpi.w  #$3840,d4                       ; 0033C
        bgt.b   l_030_00350                     ; 00340
        bset    #$4,$20(a1)                     ; 00342
l_030_00348:
        cmpi.w  #$3840,d4                       ; 00348
        bgt.w   l_030_007A0                     ; 0034C
l_030_00350:
        bsr.w   PitchTowards                    ; 00350
        bra.w   l_030_01128                     ; 00354

;-------------------------------------------------------------------------------
; ManSplitS - The split-S (states $11-$13), only above height $100000: rolls inverted, then
; pulls through (as the loop, state $0F).
;-------------------------------------------------------------------------------
ManSplitS:
        cmpi.l  #$100000,$18(a1)                ; 00358
        ble.w   l_030_007A0                     ; 00360
        bclr    #$3,$20(a1)                     ; 00364
        bclr    #$4,$20(a1)                     ; 0036A
        move.b  #$12,$5(a1)                     ; 00370
        move.w  #$f,$4c(a1)                     ; 00376
l_030_0037C:
        tst.w   $4c(a1)                         ; 0037C
        ble.b   l_030_0038C                     ; 00380
        bset    #$4,$3(a1)                      ; 00382
        bra.w   l_030_01128                     ; 00388
l_030_0038C:
        move.b  #$13,$5(a1)                     ; 0038C
l_030_00392:
        lea.l   (RollRates).l,a0                ; 00392
        moveq   #$10,d3                         ; 00398
        move.w  (a0,d3.w),d3                    ; 0039A
        move.w  $6a(a1),d4                      ; 0039E
        btst    #$3,$20(a1)                     ; 003A2
        bne.b   l_030_003B6                     ; 003A8
        cmpi.w  #$3840,d4                       ; 003AA
        bge.b   l_030_003DC                     ; 003AE
        bset    #$3,$20(a1)                     ; 003B0
l_030_003B6:
        cmpi.w  #$3840,d4                       ; 003B6
        beq.b   l_030_003CC                     ; 003BA
        cmpi.w  #$35c0,d4                       ; 003BC
        blt.b   l_030_003DC                     ; 003C0
        bset    #$4,$3(a1)                      ; 003C2
        moveq   #$0,d3                          ; 003C8
        bra.b   l_030_003DC                     ; 003CA
l_030_003CC:
        move.b  #$f,$5(a1)                      ; 003CC
        move.w  #$2,$4c(a1)                     ; 003D2
        bra.w   l_030_002F8                     ; 003D8
l_030_003DC:
        bsr.w   RollCommand                     ; 003DC
        bra.w   l_030_01128                     ; 003E0

;-------------------------------------------------------------------------------
; ManHalfLoop - The vertical half-loop (states $14-$16): pitches up to inverted, then rolls
; level (state $0D).
;-------------------------------------------------------------------------------
ManHalfLoop:
        bclr    #$3,$20(a1)                     ; 003E4
        move.b  #$15,$5(a1)                     ; 003EA
        move.w  #$f,$4c(a1)                     ; 003F0
l_030_003F6:
        tst.w   $4c(a1)                         ; 003F6
        ble.b   l_030_00406                     ; 003FA
        bset    #$4,$3(a1)                      ; 003FC
        bra.w   l_030_01128                     ; 00402
l_030_00406:
        move.b  #$16,$5(a1)                     ; 00406
l_030_0040C:
        lea.l   (PitchRates).l,a0               ; 0040C
        moveq   #$c,d3                          ; 00412
        move.w  (a0,d3.w),d3                    ; 00414
        neg.w   d3                              ; 00418
        move.w  $66(a1),d4                      ; 0041A
        btst    #$3,$20(a1)                     ; 0041E
        bne.b   l_030_00432                     ; 00424
        cmpi.w  #$3840,d4                       ; 00426
        ble.b   l_030_00442                     ; 0042A
        bset    #$3,$20(a1)                     ; 0042C
l_030_00432:
        cmpi.w  #$3840,d4                       ; 00432
        bgt.b   l_030_00442                     ; 00436
        move.b  #$d,$5(a1)                      ; 00438
        bra.w   l_030_00290                     ; 0043E
l_030_00442:
        bsr.w   PitchTowards                    ; 00442
        bra.w   l_030_01128                     ; 00446

;-------------------------------------------------------------------------------
; ManBarrelRoll - The barrel roll (states $17-$19): rolls and pitches together.
;-------------------------------------------------------------------------------
ManBarrelRoll:
        bclr    #$3,$20(a1)                     ; 0044A
        bclr    #$4,$20(a1)                     ; 00450
        move.b  #$18,$5(a1)                     ; 00456
        move.w  #$f,$4c(a1)                     ; 0045C
l_030_00462:
        tst.w   $4c(a1)                         ; 00462
        ble.b   l_030_00472                     ; 00466
        bset    #$4,$3(a1)                      ; 00468
        bra.w   l_030_01128                     ; 0046E
l_030_00472:
        move.b  #$19,$5(a1)                     ; 00472
l_030_00478:
        lea.l   (RollRates).l,a0                ; 00478
        moveq   #$e,d3                          ; 0047E
        move.w  (a0,d3.w),d3                    ; 00480
        move.w  $6a(a1),d4                      ; 00484
        btst    #$4,$20(a1)                     ; 00488
        bne.b   l_030_004B0                     ; 0048E
        btst    #$3,$20(a1)                     ; 00490
        bne.b   l_030_004A4                     ; 00496
        cmpi.w  #$3840,d4                       ; 00498
        bge.b   l_030_004B8                     ; 0049C
        bset    #$3,$20(a1)                     ; 0049E
l_030_004A4:
        cmpi.w  #$3840,d4                       ; 004A4
        blt.b   l_030_004B8                     ; 004A8
        bset    #$4,$20(a1)                     ; 004AA
l_030_004B0:
        cmpi.w  #$3840,d4                       ; 004B0
        blt.w   l_030_007A0                     ; 004B4
l_030_004B8:
        bsr.w   RollCommand                     ; 004B8
        lea.l   (PitchRates).l,a0               ; 004BC
        moveq   #$e,d3                          ; 004C2
        move.w  (a0,d3.w),d3                    ; 004C4
        neg.w   d3                              ; 004C8
        bsr.w   PitchCommandKeep                ; 004CA
        bra.w   l_030_01128                     ; 004CE

;-------------------------------------------------------------------------------
; ManInverted - Inverted flight (states $1A-$22): rolls inverted, flies inverted, then pulls
; back round.
;-------------------------------------------------------------------------------
ManInverted:
        bclr    #$3,$20(a1)                     ; 004D2
        bclr    #$4,$20(a1)                     ; 004D8
        move.b  #$1b,$5(a1)                     ; 004DE
        move.w  #$f,$4c(a1)                     ; 004E4
l_030_004EA:
        tst.w   $4c(a1)                         ; 004EA
        ble.b   l_030_004FA                     ; 004EE
        bset    #$4,$3(a1)                      ; 004F0
        bra.w   l_030_01128                     ; 004F6
l_030_004FA:
        move.b  #$1c,$5(a1)                     ; 004FA
l_030_00500:
        lea.l   (RollRates).l,a0                ; 00500
        moveq   #$10,d3                         ; 00506
        move.w  (a0,d3.w),d3                    ; 00508
        move.w  $6a(a1),d4                      ; 0050C
        btst    #$3,$20(a1)                     ; 00510
        bne.b   l_030_00524                     ; 00516
        cmpi.w  #$3840,d4                       ; 00518
        bge.b   l_030_0053E                     ; 0051C
        bset    #$3,$20(a1)                     ; 0051E
l_030_00524:
        cmpi.w  #$3840,d4                       ; 00524
        beq.b   l_030_0053A                     ; 00528
        cmpi.w  #$35c0,d4                       ; 0052A
        blt.b   l_030_0053E                     ; 0052E
        bset    #$4,$3(a1)                      ; 00530
        moveq   #$0,d3                          ; 00536
        bra.b   l_030_0053E                     ; 00538
l_030_0053A:
        bra.w   l_030_00546                     ; 0053A
l_030_0053E:
        bsr.w   RollCommand                     ; 0053E
        bra.w   l_030_01128                     ; 00542
l_030_00546:
        bclr    #$4,$20(a1)                     ; 00546
        move.b  #$1e,$5(a1)                     ; 0054C
        move.w  #$a,$4c(a1)                     ; 00552
l_030_00558:
        tst.w   $4c(a1)                         ; 00558
        ble.b   l_030_00568                     ; 0055C
        bset    #$4,$3(a1)                      ; 0055E
        bra.w   l_030_01128                     ; 00564
l_030_00568:
        move.b  #$1f,$5(a1)                     ; 00568
l_030_0056E:
        lea.l   (PitchRates).l,a0               ; 0056E
        moveq   #$8,d3                          ; 00574
        move.w  (a0,d3.w),d3                    ; 00576
        neg.w   d3                              ; 0057A
        move.w  $66(a1),d4                      ; 0057C
        move.w  $6a(a1),d2                      ; 00580
        cmpi.w  #$5460,d2                       ; 00584
        bgt.b   l_030_005AC                     ; 00588
        cmpi.w  #$1c20,d2                       ; 0058A
        blt.b   l_030_005AC                     ; 0058E
        btst    #$4,$20(a1)                     ; 00590
        bne.b   l_030_005A4                     ; 00596
        cmpi.w  #$3840,d4                       ; 00598
        bgt.b   l_030_005C6                     ; 0059C
        bset    #$4,$20(a1)                     ; 0059E
l_030_005A4:
        cmpi.w  #$960,d4                        ; 005A4
        blt.b   l_030_005C6                     ; 005A8
        bra.b   l_030_005CE                     ; 005AA
l_030_005AC:
        btst    #$4,$20(a1)                     ; 005AC
        bne.b   l_030_005C0                     ; 005B2
        cmpi.w  #$3840,d4                       ; 005B4
        blt.b   l_030_005C6                     ; 005B8
        bset    #$4,$20(a1)                     ; 005BA
l_030_005C0:
        cmpi.w  #$6720,d4                       ; 005C0
        blt.b   l_030_005CE                     ; 005C4
l_030_005C6:
        bsr.w   PitchTowards                    ; 005C6
        bra.w   l_030_01128                     ; 005CA
l_030_005CE:
        moveq   #$0,d3                          ; 005CE
        bsr.w   PitchTowards                    ; 005D0
        bra.w   l_030_005D8                     ; 005D4
l_030_005D8:
        bclr    #$4,$20(a1)                     ; 005D8
        move.b  #$21,$5(a1)                     ; 005DE
        move.w  #$19,$4c(a1)                    ; 005E4
l_030_005EA:
        tst.w   $4c(a1)                         ; 005EA
        ble.b   l_030_005FA                     ; 005EE
        bset    #$4,$3(a1)                      ; 005F0
        bra.w   l_030_01128                     ; 005F6
l_030_005FA:
        move.b  #$22,$5(a1)                     ; 005FA
l_030_00600:
        lea.l   (PitchRates).l,a0               ; 00600
        moveq   #$8,d3                          ; 00606
        move.w  (a0,d3.w),d3                    ; 00608
        move.w  $66(a1),d4                      ; 0060C
        move.w  $6a(a1),d2                      ; 00610
        cmpi.w  #$5460,d2                       ; 00614
        bgt.b   l_030_0063C                     ; 00618
        cmpi.w  #$1c20,d2                       ; 0061A
        blt.b   l_030_0063C                     ; 0061E
        btst    #$4,$20(a1)                     ; 00620
        bne.b   l_030_00634                     ; 00626
        cmpi.w  #$3840,d4                       ; 00628
        blt.b   l_030_00656                     ; 0062C
        bset    #$4,$20(a1)                     ; 0062E
l_030_00634:
        cmpi.w  #$6720,d4                       ; 00634
        bgt.b   l_030_00656                     ; 00638
        bra.b   l_030_0065E                     ; 0063A
l_030_0063C:
        btst    #$4,$20(a1)                     ; 0063C
        bne.b   l_030_00650                     ; 00642
        cmpi.w  #$3840,d4                       ; 00644
        bgt.b   l_030_00656                     ; 00648
        bset    #$4,$20(a1)                     ; 0064A
l_030_00650:
        cmpi.w  #$960,d4                        ; 00650
        bgt.b   l_030_0065E                     ; 00654
l_030_00656:
        bsr.w   PitchTowards                    ; 00656
        bra.w   l_030_01128                     ; 0065A
l_030_0065E:
        moveq   #$0,d3                          ; 0065E
        bsr.w   PitchTowards                    ; 00660
        bset    #$3,$20(a1)                     ; 00664
        move.b  #$16,$5(a1)                     ; 0066A
        bra.w   l_030_0040C                     ; 00670

;-------------------------------------------------------------------------------
; ManBreakTurn - The break turn (state $27): banks 90 degrees (state 2) and pulls hard (state
; 7).
;-------------------------------------------------------------------------------
ManBreakTurn:
        move.b  #$28,$5(a1)                     ; 00674
        move.w  #$f,$4c(a1)                     ; 0067A

;-------------------------------------------------------------------------------
; PilotBeforeBreak - State $28: keeps +$03 bit 4 set while the timer runs, then becomes state 2
; (the break turn's 90-degree bank).
;-------------------------------------------------------------------------------
PilotBeforeBreak:
        tst.w   $4c(a1)                         ; 00680
        ble.b   l_030_00690                     ; 00684
        bset    #$4,$3(a1)                      ; 00686
        bra.w   l_030_01128                     ; 0068C
l_030_00690:
        move.b  #$2,$5(a1)                      ; 00690

;-------------------------------------------------------------------------------
; PilotBank90 - State 2: rolls to a 90-degree bank, then state 7 (pull) for 32 frames.
;-------------------------------------------------------------------------------
PilotBank90:
        moveq   #$0,d2                          ; 00696
        lea.l   (RollRates).l,a0                ; 00698
        moveq   #$10,d3                         ; 0069E
        move.w  (a0,d3.w),d3                    ; 006A0
        move.w  #$1c20,d0                       ; 006A4
        move.w  #$5460,d1                       ; 006A8
        move.w  $6a(a1),d4                      ; 006AC
        cmpi.w  #$3840,d4                       ; 006B0
        blt.b   l_030_006B8                     ; 006B4
        move.w  d1,d0                           ; 006B6
l_030_006B8:
        cmp.w   d0,d4                           ; 006B8
        blt.b   l_030_006BE                     ; 006BA
        addq.w  #$1,d2                          ; 006BC
l_030_006BE:
        sub.w   d0,d4                           ; 006BE
        bge.b   l_030_006C4                     ; 006C0
        neg.w   d4                              ; 006C2
l_030_006C4:
        cmpi.w  #$4b0,d4                        ; 006C4
        blt.b   l_030_006D8                     ; 006C8
        tst.w   d2                              ; 006CA
        beq.b   l_030_006D0                     ; 006CC
        neg.w   d3                              ; 006CE
l_030_006D0:
        bsr.w   RollCommand                     ; 006D0
        bra.w   l_030_01128                     ; 006D4
l_030_006D8:
        move.b  #$7,$5(a1)                      ; 006D8
        move.w  #$20,$4c(a1)                    ; 006DE
        andi.b  #$3,$65(a1)                     ; 006E4
        bra.w   l_030_01128                     ; 006EA

;-------------------------------------------------------------------------------
; PilotPull - State 7: pulls (pitch) until the timer runs out.
;-------------------------------------------------------------------------------
PilotPull:
        tst.w   $4c(a1)                         ; 006EE
        blt.w   l_030_007A0                     ; 006F2
        lea.l   (PitchRates).l,a0               ; 006F6
        moveq   #$8,d3                          ; 006FC
        move.w  (a0,d3.w),d3                    ; 006FE
        neg.w   d3                              ; 00702
        bsr.w   PitchCommand                    ; 00704
        bra.w   l_030_01128                     ; 00708

;-------------------------------------------------------------------------------
; PilotState3 - State 3: the normal flight (PilotFly).
;-------------------------------------------------------------------------------
PilotState3:
        bra.w   PilotFly                        ; 0070C

;-------------------------------------------------------------------------------
; PilotState4 - State 4: the normal flight (PilotFly).
;-------------------------------------------------------------------------------
PilotState4:
        bra.w   PilotFly                        ; 00710

;-------------------------------------------------------------------------------
; PilotTurnHard - State 5: banks about 14 degrees and turns, for the timer's frames.
;-------------------------------------------------------------------------------
PilotTurnHard:
        move.w  #$460,d0                        ; 00714
        move.w  #$1e0,d5                        ; 00718
        bra.b   l_030_00726                     ; 0071C

;-------------------------------------------------------------------------------
; PilotTurnGentle - State 9: banks about 8 degrees and turns, for the timer's frames.
;-------------------------------------------------------------------------------
PilotTurnGentle:
        move.w  #$280,d0                        ; 0071E
        move.w  #$140,d5                        ; 00722
l_030_00726:
        move.w  #$7080,d1                       ; 00726
        sub.w   d0,d1                           ; 0072A
        tst.w   $4c(a1)                         ; 0072C
        blt.w   l_030_00884                     ; 00730
        moveq   #$0,d2                          ; 00734
        lea.l   (RollRates).l,a0                ; 00736
        moveq   #$4,d3                          ; 0073C
        move.w  (a0,d3.w),d3                    ; 0073E
        move.w  $6a(a1),d4                      ; 00742
        cmpi.w  #$3840,d4                       ; 00746
        blt.b   l_030_0074E                     ; 0074A
        move.w  d1,d0                           ; 0074C
l_030_0074E:
        cmp.w   d0,d4                           ; 0074E
        blt.b   l_030_00754                     ; 00750
        addq.w  #$1,d2                          ; 00752
l_030_00754:
        sub.w   d0,d4                           ; 00754
        bge.b   l_030_0075A                     ; 00756
        neg.w   d4                              ; 00758
l_030_0075A:
        move.w  #$1000,d0                       ; 0075A
        cmp.w   d5,d4                           ; 0075E
        blt.b   l_030_00770                     ; 00760
        tst.w   d2                              ; 00762
        beq.b   l_030_00768                     ; 00764
        neg.w   d3                              ; 00766
l_030_00768:
        bsr.w   RollCommand                     ; 00768
        bra.w   l_030_01128                     ; 0076C
l_030_00770:
        bsr.w   RollNeutral                     ; 00770
        bra.w   l_030_01128                     ; 00774
l_030_00778:
        move.b  #$a,$5(a1)                      ; 00778
        tst.b   (TrainingReady).l               ; 0077E
        beq.b   l_030_0078E                     ; 00784
        move.w  #$24,$4c(a1)                    ; 00786
        bra.b   PilotWait                       ; 0078C
l_030_0078E:
        move.w  #$3c,$4c(a1)                    ; 0078E

;-------------------------------------------------------------------------------
; PilotWait - State 10: waits for the timer.
;-------------------------------------------------------------------------------
PilotWait:
        tst.w   $4c(a1)                         ; 00794
        blt.w   l_030_00884                     ; 00798
        bra.w   l_030_0112E                     ; 0079C
l_030_007A0:
        btst    #$0,$2(a1)                      ; 007A0
        beq.b   l_030_007B2                     ; 007A6
        tst.b   (dat_071_0016A).l               ; 007A8
        bge.b   l_030_00778                     ; 007AE
        bra.b   l_030_0080C                     ; 007B0
l_030_007B2:
        tst.b   $38(a1)                         ; 007B2
        bge.b   l_030_0080C                     ; 007B6
        cmpi.b  #$ff,$38(a1)                    ; 007B8
        beq.b   l_030_0080C                     ; 007BE
        cmpi.b  #$2,(Difficulty).l              ; 007C0
        ble.b   l_030_007D8                     ; 007C8
        move.b  $64(a1),d0                      ; 007CA
        andi.b  #$60,d0                         ; 007CE
        cmpi.b  #$60,d0                         ; 007D2
        bne.b   l_030_0080C                     ; 007D6
l_030_007D8:
        move.b  (Difficulty).l,d0               ; 007D8
        ble.b   l_030_007FA                     ; 007DE
        subq.b  #$1,d0                          ; 007E0
        beq.b   l_030_007F4                     ; 007E2
        subq.b  #$1,d0                          ; 007E4
        beq.b   l_030_007EE                     ; 007E6
        move.w  #$4,d0                          ; 007E8
        bra.b   l_030_007FE                     ; 007EC
l_030_007EE:
        move.w  #$12,d0                         ; 007EE
        bra.b   l_030_007FE                     ; 007F2
l_030_007F4:
        move.w  #$25,d0                         ; 007F4
        bra.b   l_030_007FE                     ; 007F8
l_030_007FA:
        move.w  #$4b,d0                         ; 007FA
l_030_007FE:
        move.w  d0,$4c(a1)                      ; 007FE
        bra.b   l_030_00812                     ; 00802
l_030_00804:
        move.w  #$b,$4c(a1)                     ; 00804
        bra.b   l_030_00812                     ; 0080A
l_030_0080C:
        move.w  #$a,$4c(a1)                     ; 0080C
l_030_00812:
        move.b  #$6,$5(a1)                      ; 00812

;-------------------------------------------------------------------------------
; PilotLevel - State 6: flies on for the timer's frames (a reaction delay set by the
; difficulty: 75, 37, 18 or 4 frames), keeping clear of the ground.
;-------------------------------------------------------------------------------
PilotLevel:
        btst    #$1,$20(a1)                     ; 00818
        bne.w   l_030_0112E                     ; 0081E
        btst    #$0,$2(a1)                      ; 00822
        bne.b   l_030_0086E                     ; 00828
        tst.w   $4c(a1)                         ; 0082A
        blt.w   l_030_00986                     ; 0082E
        move.w  $6c(a1),d4                      ; 00832
        ext.l   d4                              ; 00836
        asl.l   #$6,d4                          ; 00838
        tst.l   $42(a1)                         ; 0083A
        bge.b   l_030_0085A                     ; 0083E
        cmp.l   $18(a1),d4                      ; 00840
        blt.w   l_030_0112E                     ; 00844
        move.w  #$3c,(DebugCheckpoint).l        ; 00848
        jsr     (Nop).l                         ; 00850
        bra.w   l_030_00986                     ; 00856
l_030_0085A:
        neg.l   d4                              ; 0085A
        addi.l  #$800000,d4                     ; 0085C
        cmp.l   $18(a1),d4                      ; 00862
        blt.w   l_030_00986                     ; 00866
        bra.w   l_030_0112E                     ; 0086A
l_030_0086E:
        tst.b   (dat_071_0016A).l               ; 0086E
        blt.w   l_030_0112E                     ; 00874
        tst.w   $4c(a1)                         ; 00878
        blt.w   l_030_00978                     ; 0087C
        bra.w   l_030_0112E                     ; 00880
l_030_00884:
        clr.b   $5(a1)                          ; 00884
        andi.b  #$3,$65(a1)                     ; 00888
        bra.w   l_030_0112E                     ; 0088E
l_030_00892:
        clr.b   $64(a1)                         ; 00892
l_030_00896:
        unlk    a6                              ; 00896
        rts                                     ; 00898

;-------------------------------------------------------------------------------
; ComputerPilot - Flies a computer aircraft (a1) for the frame, by setting its control bits:
; its state (+$05) chooses what it does, through PilotStates (state - 1). It steers towards its
; destination: map cell +$2C / +$2E, position in the cell +$30 / +$32, height +$34. In mission
; F3 (GameMode 5, the stolen aircraft) an aircraft follows a route (Routes, number +$3A): each
; waypoint is loaded into the destination in turn (state 8). An aircraft sinking too near the
; ground for its speed (height under speed x 64) goes into state 1 for 30 frames (pulls up).
;-------------------------------------------------------------------------------
ComputerPilot:
        link.w  a6,#$ffd4                       ; 0089A
        move.b  $62(a1),d0                      ; 0089E
        andi.b  #$f0,d0                         ; 008A2
        cmpi.b  #$30,d0                         ; 008A6
        beq.b   l_030_00892                     ; 008AA
        move.w  #$1400,$7e(a1)                  ; 008AC
        move.w  $0(a1),d0                       ; 008B2
        andi.w  #$80,d0                         ; 008B6
        beq.b   l_030_00892                     ; 008BA
        move.b  (dat_071_0017F).l,d0            ; 008BC
        or.b    (WorldFrozen).l,d0              ; 008C2
        bne.b   l_030_00896                     ; 008C8
l_030_008CA:
        move.b  $5(a1),d0                       ; 008CA
        beq.w   PilotFly                        ; 008CE
        cmpi.b  #$8,$5(a1)                      ; 008D2
        beq.b   l_030_00916                     ; 008D8
        cmpi.b  #$1,$5(a1)                      ; 008DA
        beq.b   l_030_00916                     ; 008E0
        btst    #$1,$20(a1)                     ; 008E2
        bne.b   l_030_00916                     ; 008E8
        btst    #$0,$2(a1)                      ; 008EA
        bne.b   l_030_00916                     ; 008F0
        move.w  $6c(a1),d4                      ; 008F2
        ext.l   d4                              ; 008F6
        asl.l   #$6,d4                          ; 008F8
        tst.l   $42(a1)                         ; 008FA
        bge.b   l_030_00908                     ; 008FE
        cmp.l   $18(a1),d4                      ; 00900
        blt.b   l_030_00916                     ; 00904
        bra.b   l_030_00986                     ; 00906
l_030_00908:
        neg.l   d4                              ; 00908
        addi.l  #$800000,d4                     ; 0090A
        cmp.l   $18(a1),d4                      ; 00910
        blt.b   l_030_00986                     ; 00914
l_030_00916:
        cmpi.b  #$8,d0                          ; 00916
        beq.b   l_030_00966                     ; 0091A
        cmpi.b  #$5,(GameMode).l                ; 0091C
        bne.b   l_030_00966                     ; 00924
        btst    #$3,$1(a1)                      ; 00926
        beq.b   l_030_00966                     ; 0092C
        tst.w   $4c(a1)                         ; 0092E
        bgt.w   l_030_00966                     ; 00932
        move.b  #$8,$5(a1)                      ; 00936
        moveq   #$0,d0                          ; 0093C
        move.b  $3a(a1),d0                      ; 0093E
        add.w   d0,d0                           ; 00942
        lea.l   (Routes).l,a4                   ; 00944
        adda.w  (a4,d0.w),a4                    ; 0094A
        tst.w   (a4)                            ; 0094E
        blt.b   l_030_00966                     ; 00950
        movem.w (a4),d0-d4                      ; 00952
        movem.w d0-d3,$2c(a1)                   ; 00956
        ext.l   d4                              ; 0095C
        move.l  d4,$34(a1)                      ; 0095E
        bra.w   l_030_008CA                     ; 00962
l_030_00966:
        subq.w  #$1,d0                          ; 00966
        ext.w   d0                              ; 00968
        add.w   d0,d0                           ; 0096A
        add.w   d0,d0                           ; 0096C
        lea.l   PilotStates(pc),a0              ; 0096E
        movea.l (a0,d0.w),a0                    ; 00972
        jmp     (a0)                            ; 00976
l_030_00978:
        move.b  #$8,$5(a1)                      ; 00978
        move.w  #$1e,$4c(a1)                    ; 0097E
        bra.b   PilotFly                        ; 00984
l_030_00986:
        move.b  #$1,$5(a1)                      ; 00986
        move.w  #$1e,$4c(a1)                    ; 0098C

;-------------------------------------------------------------------------------
; PilotFly - The normal flight (states 0, 1, 3, 4 and 8): steers towards the destination
; (+$2C-+$34), with the checks on height and attitude.
;-------------------------------------------------------------------------------
PilotFly:
        btst    #$1,$20(a1)                     ; 00992
        bne.b   l_030_009E0                     ; 00998
        cmpi.b  #$8,$5(a1)                      ; 0099A
        bne.b   l_030_009F4                     ; 009A0
        btst    #$0,$2(a1)                      ; 009A2
        beq.b   l_030_009BC                     ; 009A8
        tst.b   (dat_071_0016A).l               ; 009AA
        bge.w   l_030_0112E                     ; 009B0
        tst.w   $4c(a1)                         ; 009B4
        blt.w   l_030_00804                     ; 009B8
l_030_009BC:
        move.w  $66(a1),d4                      ; 009BC
        cmpi.w  #$e10,d4                        ; 009C0
        blt.b   l_030_009CC                     ; 009C4
        cmpi.w  #$6270,d4                       ; 009C6
        blt.b   l_030_00A04                     ; 009CA
l_030_009CC:
        move.w  $6a(a1),d4                      ; 009CC
        cmpi.w  #$1c20,d4                       ; 009D0
        blt.b   l_030_00A04                     ; 009D4
        cmpi.w  #$5460,d4                       ; 009D6
        blt.w   l_030_007F4                     ; 009DA
        bra.b   l_030_00A04                     ; 009DE
l_030_009E0:
        cmpi.w  #$3840,$66(a1)                  ; 009E0
        bgt.b   l_030_00A04                     ; 009E6
        cmpi.w  #$af0,$66(a1)                   ; 009E8
        blt.b   l_030_00A04                     ; 009EE
        bra.w   l_030_00812                     ; 009F0
l_030_009F4:
        btst    #$0,$2(a1)                      ; 009F4
        bne.b   l_030_00A04                     ; 009FA
        tst.w   $4c(a1)                         ; 009FC
        blt.w   l_030_007A0                     ; 00A00
l_030_00A04:
        move.w  $2c(a1),d0                      ; 00A04
        blt.w   l_030_00892                     ; 00A08
        move.b  $62(a1),d1                      ; 00A0C
        andi.b  #$f0,d1                         ; 00A10
        cmpi.b  #$0,d1                          ; 00A14
        bne.b   l_030_00A28                     ; 00A18
        subq.w  #$1,$26(a1)                     ; 00A1A
        cmpi.w  #$a,$26(a1)                     ; 00A1E
        bge.w   l_030_00892                     ; 00A24
l_030_00A28:
        sub.w   $6(a1),d0                       ; 00A28
        ext.l   d0                              ; 00A2C
        moveq   #$e,d5                          ; 00A2E
        asl.l   d5,d0                           ; 00A30
        move.w  $2e(a1),d1                      ; 00A32
        sub.w   $8(a1),d1                       ; 00A36
        ext.l   d1                              ; 00A3A
        asl.l   d5,d1                           ; 00A3C
        move.w  $c(a1),d2                       ; 00A3E
        move.w  $e(a1),d6                       ; 00A42
        ext.l   d2                              ; 00A46
        ext.l   d6                              ; 00A48
        movem.w $30(a1),d3/d5                   ; 00A4A
        btst    #$1,$20(a1)                     ; 00A50
        bne.b   l_030_00AB2                     ; 00A56
        move.b  $62(a1),d4                      ; 00A58
        andi.b  #$f0,d4                         ; 00A5C
        cmpi.b  #$0,d4                          ; 00A60
        beq.b   l_030_00AB2                     ; 00A64
        cmpi.b  #$14,$62(a1)                    ; 00A66
        beq.b   l_030_00AB2                     ; 00A6C
        cmpi.b  #$15,$62(a1)                    ; 00A6E
        beq.b   l_030_00AB2                     ; 00A74
        move.w  $6c(a1),d4                      ; 00A76
        ext.l   d4                              ; 00A7A
        cmpi.b  #$8,$5(a1)                      ; 00A7C
        beq.b   l_030_00A88                     ; 00A82
        asl.l   #$7,d4                          ; 00A84
        bra.b   l_030_00A8A                     ; 00A86
l_030_00A88:
        asl.l   #$6,d4                          ; 00A88
l_030_00A8A:
        tst.l   $42(a1)                         ; 00A8A
        bge.b   l_030_00A9E                     ; 00A8E
        cmp.l   $18(a1),d4                      ; 00A90
        blt.b   l_030_00AB2                     ; 00A94
        cmp.l   $34(a1),d4                      ; 00A96
        blt.b   l_030_00AB2                     ; 00A9A
        bra.b   l_030_00AB6                     ; 00A9C
l_030_00A9E:
        neg.l   d4                              ; 00A9E
        addi.l  #$800000,d4                     ; 00AA0
        cmp.l   $18(a1),d4                      ; 00AA6
        bgt.b   l_030_00AB2                     ; 00AAA
        cmp.l   $34(a1),d4                      ; 00AAC
        blt.b   l_030_00AB6                     ; 00AB0
l_030_00AB2:
        move.l  $34(a1),d4                      ; 00AB2
l_030_00AB6:
        ext.l   d3                              ; 00AB6
        ext.l   d5                              ; 00AB8
        tst.b   $38(a1)                         ; 00ABA
        blt.b   l_030_00AD8                     ; 00ABE
        move.b  $38(a1),d7                      ; 00AC0
        ext.w   d7                              ; 00AC4
        asl.l   d7,d3                           ; 00AC6
        asl.l   d7,d4                           ; 00AC8
        asl.l   d7,d5                           ; 00ACA
        andi.l  #$3fff,d3                       ; 00ACC
        andi.l  #$3fff,d5                       ; 00AD2
l_030_00AD8:
        sub.l   d2,d3                           ; 00AD8
        sub.l   d6,d5                           ; 00ADA
        add.l   d0,d3                           ; 00ADC
        add.l   d1,d5                           ; 00ADE
        move.l  $10(a1),d6                      ; 00AE0
        sub.l   d6,d4                           ; 00AE4
        move.l  d5,d7                           ; 00AE6
        move.l  d4,d6                           ; 00AE8
        move.l  d3,d5                           ; 00AEA
        move.l  d5,d0                           ; 00AEC
        bge.b   l_030_00AF2                     ; 00AEE
        neg.l   d0                              ; 00AF0
l_030_00AF2:
        move.l  d6,d1                           ; 00AF2
        bge.b   l_030_00AF8                     ; 00AF4
        neg.l   d1                              ; 00AF6
l_030_00AF8:
        move.l  d7,d2                           ; 00AF8
        bge.b   l_030_00AFE                     ; 00AFA
        neg.l   d2                              ; 00AFC
l_030_00AFE:
        cmp.l   d0,d1                           ; 00AFE
        bgt.b   l_030_00B0A                     ; 00B00
        cmp.l   d0,d2                           ; 00B02
        bgt.b   l_030_00B0E                     ; 00B04
        move.l  d0,d3                           ; 00B06
        bra.b   l_030_00B14                     ; 00B08
l_030_00B0A:
        cmp.l   d1,d2                           ; 00B0A
        ble.b   l_030_00B12                     ; 00B0C
l_030_00B0E:
        move.l  d2,d3                           ; 00B0E
        bra.b   l_030_00B14                     ; 00B10
l_030_00B12:
        move.l  d1,d3                           ; 00B12
l_030_00B14:
        cmpi.l  #$4800,d3                       ; 00B14
        blt.b   l_030_00B26                     ; 00B1A
        asr.l   #$2,d5                          ; 00B1C
        asr.l   #$2,d6                          ; 00B1E
        asr.l   #$2,d7                          ; 00B20
        asr.l   #$2,d3                          ; 00B22
        bra.b   l_030_00B14                     ; 00B24
l_030_00B26:
        move.w  #$c0,d0                         ; 00B26
        jsr     (ScaleToLengthD0).l             ; 00B2A
        cmpi.b  #$8,$5(a1)                      ; 00B30
        bne.b   l_030_00B7C                     ; 00B36
        move.l  #$c000,-$4(a6)                  ; 00B38
        move.l  #$10000,-$8(a6)                 ; 00B40
        move.l  #$18000,-$c(a6)                 ; 00B48
        move.l  #$ffff4000,-$14(a6)             ; 00B50
        move.l  #$ffff0000,-$10(a6)             ; 00B58
        move.l  #$fffe8000,-$18(a6)             ; 00B60
        move.l  #$30000,-$1c(a6)                ; 00B68
        move.l  #$80000,-$20(a6)                ; 00B70
        bra.w   l_030_00C0C                     ; 00B78
l_030_00B7C:
        move.b  $62(a1),d0                      ; 00B7C
        andi.b  #$f0,d0                         ; 00B80
        cmpi.b  #$10,d0                         ; 00B84
        beq.b   l_030_00BCC                     ; 00B88
        move.l  #$10000,-$4(a6)                 ; 00B8A
        move.l  #$10000,-$8(a6)                 ; 00B92
        move.l  #$20000,-$c(a6)                 ; 00B9A
        move.l  #$ffff0000,-$14(a6)             ; 00BA2
        move.l  #$ffff0000,-$10(a6)             ; 00BAA
        move.l  #$fffe0000,-$18(a6)             ; 00BB2
        move.l  #$20000,-$1c(a6)                ; 00BBA
        move.l  #$20000,-$20(a6)                ; 00BC2
        bra.b   l_030_00C0C                     ; 00BCA
l_030_00BCC:
        move.l  #$30000,-$4(a6)                 ; 00BCC
        move.l  #$40000,-$8(a6)                 ; 00BD4
        move.l  #$50000,-$c(a6)                 ; 00BDC
        move.l  #$fffd0000,-$14(a6)             ; 00BE4
        move.l  #$fffc0000,-$10(a6)             ; 00BEC
        move.l  #$fffb0000,-$18(a6)             ; 00BF4
        move.l  #$80000,-$1c(a6)                ; 00BFC
        move.l  #$80000,-$20(a6)                ; 00C04
l_030_00C0C:
        andi.b  #$79,$64(a1)                    ; 00C0C
        bra.b   l_030_00C1E                     ; 00C12
sub_030_00C14:
        move.b  $64(a1),d0                      ; 00C14
        andi.b  #$6,d0                          ; 00C18
        beq.b   l_030_00C6E                     ; 00C1C
l_030_00C1E:
        move.w  $92(a1),d0                      ; 00C1E
        move.w  $98(a1),d1                      ; 00C22
        move.w  $9e(a1),d2                      ; 00C26
        muls.w  d5,d0                           ; 00C2A
        muls.w  d6,d1                           ; 00C2C
        muls.w  d7,d2                           ; 00C2E
        add.l   d0,d2                           ; 00C30
        add.l   d1,d2                           ; 00C32
        move.l  d2,d4                           ; 00C34
        bge.b   l_030_00C3A                     ; 00C36
        neg.l   d4                              ; 00C38
l_030_00C3A:
        move.w  $94(a1),d0                      ; 00C3A
        move.w  $9a(a1),d1                      ; 00C3E
        move.w  $a0(a1),d3                      ; 00C42
        muls.w  d5,d0                           ; 00C46
        muls.w  d6,d1                           ; 00C48
        muls.w  d7,d3                           ; 00C4A
        add.l   d0,d3                           ; 00C4C
        add.l   d1,d3                           ; 00C4E
        move.l  d3,d0                           ; 00C50
        bge.b   l_030_00C56                     ; 00C52
        neg.l   d0                              ; 00C54
l_030_00C56:
        cmp.l   d0,d4                           ; 00C56
        bgt.b   l_030_00C64                     ; 00C58
        ori.b   #$8,$64(a1)                     ; 00C5A
        move.l  d3,d2                           ; 00C60
        bra.b   l_030_00C9C                     ; 00C62
l_030_00C64:
        andi.b  #$f7,$64(a1)                    ; 00C64
        tst.l   d2                              ; 00C6A
        bra.b   l_030_00C9C                     ; 00C6C
l_030_00C6E:
        move.b  $64(a1),d0                      ; 00C6E
        andi.b  #$8,d0                          ; 00C72
        bne.b   l_030_00C86                     ; 00C76
        move.w  $92(a1),d0                      ; 00C78
        move.w  $98(a1),d1                      ; 00C7C
        move.w  $9e(a1),d2                      ; 00C80
        bra.b   l_030_00C92                     ; 00C84
l_030_00C86:
        move.w  $94(a1),d0                      ; 00C86
        move.w  $9a(a1),d1                      ; 00C8A
        move.w  $a0(a1),d2                      ; 00C8E
l_030_00C92:
        muls.w  d5,d0                           ; 00C92
        muls.w  d6,d1                           ; 00C94
        muls.w  d7,d2                           ; 00C96
        add.l   d0,d2                           ; 00C98
        add.l   d1,d2                           ; 00C9A
l_030_00C9C:
        move.l  d2,d3                           ; 00C9C
        bge.b   l_030_00CBE                     ; 00C9E
        andi.b  #$fe,$64(a1)                    ; 00CA0
        btst    #$3,$64(a1)                     ; 00CA6
        beq.b   l_030_00CB4                     ; 00CAC
        cmp.l   -$14(a6),d2                     ; 00CAE
        bra.b   l_030_00CB8                     ; 00CB2
l_030_00CB4:
        cmp.l   -$10(a6),d2                     ; 00CB4
l_030_00CB8:
        bge.w   l_030_010C6                     ; 00CB8
        bra.b   l_030_00CDA                     ; 00CBC
l_030_00CBE:
        ori.b   #$1,$64(a1)                     ; 00CBE
        btst    #$3,$64(a1)                     ; 00CC4
        beq.b   l_030_00CD2                     ; 00CCA
        cmp.l   -$4(a6),d2                      ; 00CCC
        bra.b   l_030_00CD6                     ; 00CD0
l_030_00CD2:
        cmp.l   -$8(a6),d2                      ; 00CD2
l_030_00CD6:
        ble.w   l_030_010C6                     ; 00CD6
l_030_00CDA:
        move.b  $64(a1),d0                      ; 00CDA
        andi.b  #$8,d0                          ; 00CDE
        bne.w   l_030_00FBA                     ; 00CE2
        move.l  d2,d3                           ; 00CE6
        bge.b   l_030_00CEC                     ; 00CE8
        neg.l   d3                              ; 00CEA
l_030_00CEC:
        move.b  $64(a1),d0                      ; 00CEC
        andi.b  #$2,d0                          ; 00CF0
        beq.b   l_030_00CFE                     ; 00CF4
        cmp.l   -$c(a6),d3                      ; 00CF6
        blt.w   l_030_0112E                     ; 00CFA
l_030_00CFE:
        cmp.l   -$20(a6),d3                     ; 00CFE
        bge.b   l_030_00D0A                     ; 00D02
        ori.b   #$80,$64(a1)                    ; 00D04
l_030_00D0A:
        cmp.l   -$1c(a6),d3                     ; 00D0A
        blt.b   l_030_00D18                     ; 00D0E
l_030_00D10:
        andi.b  #$df,$64(a1)                    ; 00D10
        bra.b   l_030_00D36                     ; 00D16
l_030_00D18:
        move.w  $96(a1),d0                      ; 00D18
        move.w  $9c(a1),d1                      ; 00D1C
        move.w  $a2(a1),d4                      ; 00D20
        muls.w  d5,d0                           ; 00D24
        muls.w  d6,d1                           ; 00D26
        muls.w  d7,d4                           ; 00D28
        add.l   d0,d4                           ; 00D2A
        add.l   d1,d4                           ; 00D2C
        blt.b   l_030_00D10                     ; 00D2E
        ori.b   #$20,$64(a1)                    ; 00D30
l_030_00D36:
        andi.b  #$fd,$64(a1)                    ; 00D36
        swap    d3                              ; 00D3C
        cmpi.w  #$a,d3                          ; 00D3E
        ble.b   l_030_00D46                     ; 00D42
        moveq   #$a,d3                          ; 00D44
l_030_00D46:
        move.b  $62(a1),d0                      ; 00D46
        andi.b  #$f0,d0                         ; 00D4A
        cmpi.b  #$10,d0                         ; 00D4E
        beq.b   l_030_00DB4                     ; 00D52
        lea.l   (TurnRatesOther).l,a0           ; 00D54
        add.w   d3,d3                           ; 00D5A
        move.w  (a0,d3.w),d3                    ; 00D5C
        tst.l   d2                              ; 00D60
        blt.b   l_030_00D66                     ; 00D62
        neg.w   d3                              ; 00D64
l_030_00D66:
        tst.w   d3                              ; 00D66
        beq.b   l_030_00D84                     ; 00D68
        blt.b   l_030_00D78                     ; 00D6A
        cmp.w   $58(a1),d3                      ; 00D6C
        ble.b   l_030_00D84                     ; 00D70
        move.b  #$80,d2                         ; 00D72
        bra.b   l_030_00D86                     ; 00D76
l_030_00D78:
        cmp.w   $58(a1),d3                      ; 00D78
        bge.b   l_030_00D84                     ; 00D7C
        move.b  #$40,d2                         ; 00D7E
        bra.b   l_030_00D86                     ; 00D82
l_030_00D84:
        moveq   #$0,d2                          ; 00D84
l_030_00D86:
        move.b  $65(a1),d1                      ; 00D86
        andi.b  #$3,d1                          ; 00D8A
        or.b    d2,d1                           ; 00D8E
        move.b  d1,$65(a1)                      ; 00D90
        move.b  $62(a1),d0                      ; 00D94
        andi.b  #$f0,d0                         ; 00D98
        cmpi.b  #$10,d0                         ; 00D9C
        beq.w   l_030_0112E                     ; 00DA0
        move.w  d3,$52(a1)                      ; 00DA4
        clr.w   $54(a1)                         ; 00DA8
        clr.w   $50(a1)                         ; 00DAC
        bra.w   l_030_0112E                     ; 00DB0
l_030_00DB4:
        cmpi.b  #$14,$62(a1)                    ; 00DB4
        beq.b   l_030_00DCC                     ; 00DBA
        cmpi.b  #$8,$5(a1)                      ; 00DBC
        beq.b   l_030_00DCC                     ; 00DC2
        lea.l   (RollRates).l,a0                ; 00DC4
        bra.b   l_030_00DD2                     ; 00DCA
l_030_00DCC:
        lea.l   (dat_030_0118A).l,a0            ; 00DCC
l_030_00DD2:
        add.w   d3,d3                           ; 00DD2
        move.w  (a0,d3.w),d3                    ; 00DD4
        cmpi.w  #$1800,$6c(a1)                  ; 00DD8
        blt.b   l_030_00DE2                     ; 00DDE
        asr.w   #$1,d3                          ; 00DE0
l_030_00DE2:
        move.l  d2,d0                           ; 00DE2
        bge.b   l_030_00DEA                     ; 00DE4
        neg.w   d3                              ; 00DE6
        neg.l   d0                              ; 00DE8
l_030_00DEA:
        move.w  $6a(a1),d4                      ; 00DEA
        cmpi.w  #$1770,d4                       ; 00DEE
        blt.b   l_030_00DFC                     ; 00DF2
        cmpi.w  #$5910,d4                       ; 00DF4
        ble.w   l_030_00D66                     ; 00DF8
l_030_00DFC:
        move.w  $66(a1),d1                      ; 00DFC
        cmpi.w  #$6a40,d1                       ; 00E00
        bgt.b   l_030_00E0E                     ; 00E04
        cmpi.w  #$640,d1                        ; 00E06
        bgt.w   l_030_00D66                     ; 00E0A
l_030_00E0E:
        muls.w  $96(a1),d5                      ; 00E0E
        muls.w  $9c(a1),d6                      ; 00E12
        muls.w  $a2(a1),d7                      ; 00E16
        add.l   d5,d7                           ; 00E1A
        add.l   d6,d7                           ; 00E1C
        bge.b   l_030_00E2E                     ; 00E1E
        move.l  #$300000,d1                     ; 00E20
        move.l  d1,d7                           ; 00E26
        sub.l   d0,d1                           ; 00E28
        add.l   d7,d1                           ; 00E2A
        move.l  d1,d0                           ; 00E2C
l_030_00E2E:
        asr.l   #$8,d0                          ; 00E2E
        cmpi.w  #$3000,d0                       ; 00E30
        ble.b   l_030_00E3C                     ; 00E34
        move.w  #$3000,d0                       ; 00E36
        bra.b   l_030_00E58                     ; 00E3A
l_030_00E3C:
        cmpi.w  #$20,d0                         ; 00E3C
        bgt.b   l_030_00E4E                     ; 00E40
        cmpi.w  #$1000,d0                       ; 00E42
        bge.b   l_030_00E58                     ; 00E46
        move.w  #$1000,d0                       ; 00E48
        bra.b   l_030_00E58                     ; 00E4C
l_030_00E4E:
        cmpi.w  #$1800,d0                       ; 00E4E
        bge.b   l_030_00E58                     ; 00E52
        move.w  #$1800,d0                       ; 00E54
l_030_00E58:
        cmpi.b  #$3,$7a(a1)                     ; 00E58
        beq.b   l_030_00E68                     ; 00E5E
        cmpi.b  #$4,$7a(a1)                     ; 00E60
        bne.b   l_030_00ED2                     ; 00E66
l_030_00E68:
        tst.w   d3                              ; 00E68
        bge.b   l_030_00E9E                     ; 00E6A
        move.b  $64(a1),d2                      ; 00E6C
        andi.b  #$60,d2                         ; 00E70
        cmpi.b  #$60,d2                         ; 00E74
        bne.b   l_030_00E86                     ; 00E78
        cmpi.w  #$3840,d4                       ; 00E7A
        blt.b   l_030_00E86                     ; 00E7E
        cmpi.w  #$6d60,d4                       ; 00E80
        blt.b   l_030_00E98                     ; 00E84
l_030_00E86:
        cmpi.w  #$3840,d4                       ; 00E86
        ble.b   l_030_00ED2                     ; 00E8A
        cmpi.w  #$68b0,d4                       ; 00E8C
        bgt.b   l_030_00ED2                     ; 00E90
        cmpi.w  #$6720,d4                       ; 00E92
        bgt.b   l_030_00ED0                     ; 00E96
l_030_00E98:
        move.w  #$f0,d3                         ; 00E98
        bra.b   l_030_00ED2                     ; 00E9C
l_030_00E9E:
        move.b  $64(a1),d2                      ; 00E9E
        andi.b  #$60,d2                         ; 00EA2
        cmpi.b  #$60,d2                         ; 00EA6
        bne.b   l_030_00EB8                     ; 00EAA
        cmpi.w  #$3840,d4                       ; 00EAC
        bgt.b   l_030_00EB8                     ; 00EB0
        cmpi.w  #$320,d4                        ; 00EB2
        bgt.b   l_030_00ECA                     ; 00EB6
l_030_00EB8:
        cmpi.w  #$3840,d4                       ; 00EB8
        bge.b   l_030_00ED2                     ; 00EBC
        cmpi.w  #$7d0,d4                        ; 00EBE
        blt.b   l_030_00ED2                     ; 00EC2
        cmpi.w  #$960,d4                        ; 00EC4
        blt.b   l_030_00ED0                     ; 00EC8
l_030_00ECA:
        move.w  #$ff10,d3                       ; 00ECA
        bra.b   l_030_00ED2                     ; 00ECE
l_030_00ED0:
        moveq   #$0,d3                          ; 00ED0
l_030_00ED2:
        move.b  $5(a1),d2                       ; 00ED2
        beq.b   l_030_00EF2                     ; 00ED6
        cmpi.b  #$1,d2                          ; 00ED8
        beq.b   l_030_00EF2                     ; 00EDC
        cmpi.b  #$8,d2                          ; 00EDE
        bne.w   l_030_0112E                     ; 00EE2
        move.w  $2(a1),d2                       ; 00EE6
        andi.w  #$80,d2                         ; 00EEA
        bne.w   l_030_0112E                     ; 00EEE
l_030_00EF2:
        bsr.w   RollTowardsRate                 ; 00EF2
        move.b  $62(a1),d1                      ; 00EF6
        andi.b  #$f0,d1                         ; 00EFA
        cmpi.b  #$10,d1                         ; 00EFE
        beq.b   l_030_00F10                     ; 00F02
        move.w  d3,$54(a1)                      ; 00F04
        clr.w   $52(a1)                         ; 00F08
        clr.w   $50(a1)                         ; 00F0C
l_030_00F10:
        cmpi.b  #$8,$5(a1)                      ; 00F10
        bne.b   l_030_00F26                     ; 00F16
        asr.w   #$1,d0                          ; 00F18
        bra.b   l_030_00F26                     ; 00F1A
sub_030_00F1C:
        cmpi.b  #$14,$62(a1)                    ; 00F1C
        bne.b   l_030_00F26                     ; 00F22
        asr.w   #$1,d0                          ; 00F24
l_030_00F26:
        move.w  d0,$7e(a1)                      ; 00F26
        bra.w   l_030_0112E                     ; 00F2A

;-------------------------------------------------------------------------------
; RollTowardsRate - Rolls so the roll rate (+$58) goes towards d3, with limits near level and
; inverted flight.
;-------------------------------------------------------------------------------
RollTowardsRate:
        move.b  $64(a1),d2                      ; 00F2E
        andi.b  #$60,d2                         ; 00F32
        cmpi.b  #$60,d2                         ; 00F36
        bne.b   l_030_00F7A                     ; 00F3A
        tst.w   d3                              ; 00F3C
        beq.b   RollNeutral                     ; 00F3E
        blt.b   l_030_00F4E                     ; 00F40
        cmp.w   $58(a1),d3                      ; 00F42
        ble.b   RollNeutral                     ; 00F46
        move.b  #$80,d2                         ; 00F48
        bra.b   l_030_00F58                     ; 00F4C
l_030_00F4E:
        cmp.w   $58(a1),d3                      ; 00F4E
        bge.b   RollNeutral                     ; 00F52
        move.b  #$40,d2                         ; 00F54
l_030_00F58:
        move.w  $6a(a1),d3                      ; 00F58
        cmpi.w  #$3840,d3                       ; 00F5C
        bgt.b   l_030_00F6E                     ; 00F60
        cmpi.w  #$50,d3                         ; 00F62
        ble.b   l_030_00FAA                     ; 00F66
        ori.b   #$4,d2                          ; 00F68
        bra.b   l_030_00FAA                     ; 00F6C
l_030_00F6E:
        cmpi.w  #$7030,d3                       ; 00F6E
        bgt.b   l_030_00FAA                     ; 00F72
        ori.b   #$8,d2                          ; 00F74
        bra.b   l_030_00FAA                     ; 00F78
l_030_00F7A:
        btst    #$7,$64(a1)                     ; 00F7A
        beq.b   RollCommand                     ; 00F80
        move.w  $6a(a1),d2                      ; 00F82
        cmpi.w  #$3840,d2                       ; 00F86
        bgt.b   l_030_00F94                     ; 00F8A
        cmpi.w  #$190,d2                        ; 00F8C
        blt.b   RollCommand                     ; 00F90
        bra.b   l_030_00FA4                     ; 00F92
l_030_00F94:
        cmpi.w  #$6ef0,d2                       ; 00F94
        ble.b   l_030_00FA0                     ; 00F98

;-------------------------------------------------------------------------------
; RollCommand - Sets the roll control bits (+$65: $08 one way for d3 > 0, $04 the other, none
; for 0).
;-------------------------------------------------------------------------------
RollCommand:
        tst.w   d3                              ; 00F9A
        beq.b   RollNeutral                     ; 00F9C
        blt.b   l_030_00FA4                     ; 00F9E
l_030_00FA0:
        moveq   #$8,d2                          ; 00FA0
        bra.b   l_030_00FAA                     ; 00FA2
l_030_00FA4:
        moveq   #$4,d2                          ; 00FA4
        bra.b   l_030_00FAA                     ; 00FA6

;-------------------------------------------------------------------------------
; RollNeutral - Clears the roll control bits.
;-------------------------------------------------------------------------------
RollNeutral:
        moveq   #$0,d2                          ; 00FA8
l_030_00FAA:
        move.b  $65(a1),d1                      ; 00FAA
        andi.b  #$3,d1                          ; 00FAE
        or.b    d2,d1                           ; 00FB2
        move.b  d1,$65(a1)                      ; 00FB4
        rts                                     ; 00FB8
l_030_00FBA:
        move.l  d2,d3                           ; 00FBA
        bge.b   l_030_00FC0                     ; 00FBC
        neg.l   d3                              ; 00FBE
l_030_00FC0:
        move.b  $64(a1),d0                      ; 00FC0
        andi.b  #$4,d0                          ; 00FC4
        beq.b   l_030_00FD2                     ; 00FC8
        cmp.l   -$c(a6),d3                      ; 00FCA
        ble.w   l_030_0112E                     ; 00FCE
l_030_00FD2:
        cmp.l   -$1c(a6),d3                     ; 00FD2
        blt.b   l_030_00FE0                     ; 00FD6
l_030_00FD8:
        andi.b  #$bf,$64(a1)                    ; 00FD8
        bra.b   l_030_00FFE                     ; 00FDE
l_030_00FE0:
        move.w  $96(a1),d0                      ; 00FE0
        move.w  $9c(a1),d1                      ; 00FE4
        move.w  $a2(a1),d4                      ; 00FE8
        muls.w  d5,d0                           ; 00FEC
        muls.w  d6,d1                           ; 00FEE
        muls.w  d7,d4                           ; 00FF0
        add.l   d0,d4                           ; 00FF2
        add.l   d1,d4                           ; 00FF4
        blt.b   l_030_00FD8                     ; 00FF6
        ori.b   #$40,$64(a1)                    ; 00FF8
l_030_00FFE:
        andi.b  #$fb,$64(a1)                    ; 00FFE
        swap    d3                              ; 01004
        cmpi.w  #$a,d3                          ; 01006
        ble.b   l_030_0100E                     ; 0100A
        moveq   #$a,d3                          ; 0100C
l_030_0100E:
        move.b  $62(a1),d0                      ; 0100E
        andi.b  #$f0,d0                         ; 01012
        cmpi.b  #$10,d0                         ; 01016
        beq.b   l_030_01024                     ; 0101A
        lea.l   (TurnRatesOther).l,a0           ; 0101C
        bra.b   l_030_0103A                     ; 01022
l_030_01024:
        cmpi.b  #$14,$62(a1)                    ; 01024
        beq.b   l_030_01034                     ; 0102A
        lea.l   (PitchRates).l,a0               ; 0102C
        bra.b   l_030_0103A                     ; 01032
l_030_01034:
        lea.l   (TurnRatesAF1).l,a0             ; 01034
l_030_0103A:
        add.w   d3,d3                           ; 0103A
        move.w  (a0,d3.w),d3                    ; 0103C
        tst.l   d2                              ; 01040
        blt.b   l_030_01046                     ; 01042
        neg.w   d3                              ; 01044
l_030_01046:
        move.b  $5(a1),d2                       ; 01046
        beq.b   l_030_01066                     ; 0104A
        cmpi.b  #$1,d2                          ; 0104C
        beq.b   l_030_01066                     ; 01050
        cmpi.b  #$8,d2                          ; 01052
        bne.w   l_030_0112E                     ; 01056
        move.w  $2(a1),d2                       ; 0105A
        andi.w  #$80,d2                         ; 0105E
        bne.w   l_030_0112E                     ; 01062
l_030_01066:
        bsr.w   PitchCommand                    ; 01066
        move.b  $62(a1),d1                      ; 0106A
        andi.b  #$f0,d1                         ; 0106E
        cmpi.b  #$10,d1                         ; 01072
        beq.w   l_030_0112E                     ; 01076
        move.w  d3,$50(a1)                      ; 0107A
        clr.w   $52(a1)                         ; 0107E
        clr.w   $54(a1)                         ; 01082
        bra.w   l_030_0112E                     ; 01086

;-------------------------------------------------------------------------------
; PitchCommandKeep - PitchCommand, keeping the roll bits too.
;-------------------------------------------------------------------------------
PitchCommandKeep:
        moveq   #-1,d1                          ; 0108A
        bra.b   l_030_01090                     ; 0108C

;-------------------------------------------------------------------------------
; PitchCommand - Sets the pitch control bits (+$65: $10 or $20) so the pitch rate (+$56) goes
; towards d3, keeping the throttle bits.
;-------------------------------------------------------------------------------
PitchCommand:
        moveq   #$0,d1                          ; 0108E
l_030_01090:
        tst.w   d3                              ; 01090
        blt.b   l_030_0109E                     ; 01092
        cmp.w   $56(a1),d3                      ; 01094
        ble.b   l_030_010A8                     ; 01098
        moveq   #$10,d2                         ; 0109A
        bra.b   l_030_010AA                     ; 0109C
l_030_0109E:
        cmp.w   $56(a1),d3                      ; 0109E
        bge.b   l_030_010A8                     ; 010A2
        moveq   #$20,d2                         ; 010A4
        bra.b   l_030_010AA                     ; 010A6
l_030_010A8:
        moveq   #$0,d2                          ; 010A8
l_030_010AA:
        move.b  $65(a1),d1                      ; 010AA
        tst.w   d1                              ; 010AE
        bge.b   l_030_010B8                     ; 010B0
        andi.b  #$cf,d1                         ; 010B2
        bra.b   l_030_010BC                     ; 010B6
l_030_010B8:
        andi.b  #$3,d1                          ; 010B8
l_030_010BC:
        or.b    d2,d1                           ; 010BC
        move.b  d1,$65(a1)                      ; 010BE
        rts                                     ; 010C2

;-------------------------------------------------------------------------------
; PitchTowards - The same as PitchCommand (an alternative entry).
;-------------------------------------------------------------------------------
PitchTowards:
        bra.b   PitchCommand                    ; 010C4
l_030_010C6:
        move.b  $62(a1),d0                      ; 010C6
        andi.b  #$f0,d0                         ; 010CA
        cmpi.b  #$10,d0                         ; 010CE
        beq.b   l_030_010E0                     ; 010D2
        clr.w   $50(a1)                         ; 010D4
        clr.w   $52(a1)                         ; 010D8
        clr.w   $54(a1)                         ; 010DC
l_030_010E0:
        move.b  $64(a1),d0                      ; 010E0
        andi.b  #$8,d0                          ; 010E4
        bne.b   l_030_010F8                     ; 010E8
        ori.b   #$2,$64(a1)                     ; 010EA
        ori.b   #$20,$64(a1)                    ; 010F0
        bra.b   l_030_01122                     ; 010F6
l_030_010F8:
        move.w  $96(a1),d0                      ; 010F8
        move.w  $9c(a1),d1                      ; 010FC
        move.w  $a2(a1),d2                      ; 01100
        muls.w  d5,d0                           ; 01104
        muls.w  d6,d1                           ; 01106
        muls.w  d7,d2                           ; 01108
        add.l   d0,d2                           ; 0110A
        add.l   d1,d2                           ; 0110C
        bge.b   l_030_01116                     ; 0110E
        move.l  d3,d2                           ; 01110
        bra.w   l_030_00FFE                     ; 01112
l_030_01116:
        ori.b   #$4,$64(a1)                     ; 01116
        ori.b   #$40,$64(a1)                    ; 0111C
l_030_01122:
        bchg    #$8,$64(a1)                     ; 01122
l_030_01128:
        ori.b   #$10,$64(a1)                    ; 01128
l_030_0112E:
        unlk    a6                              ; 0112E
        rts                                     ; 01130
; TurnRatesOther - Turn rates by strength (0-10) for objects that are not aircraft (missiles).
TurnRatesOther:
	dc.b	$00,$A0,$01,$40,$01,$E0,$02,$30,$02,$80,$02,$D0,$03,$20,$03,$C0
	dc.b	$04,$10,$04,$60,$05,$00
; PitchRates - Pitch rates by strength (0-10) for the aircraft; the manoeuvres use them too.
PitchRates:
	dc.b	$00,$50,$00,$78,$00,$A0,$00,$F0,$01,$40,$01,$40,$01,$90,$01,$E0
	dc.b	$01,$E0,$02,$30,$02,$80
; RollRates - Roll rates by strength (0-10), used by the manoeuvres.
RollRates:
	dc.b	$00,$50,$00,$A0,$00,$F0,$00,$F0,$01,$40,$01,$90,$02,$30,$02,$D0
	dc.b	$03,$20,$03,$70,$03,$C0
; TurnRatesAF1 - The gentle turn rates of Air Force One ($14).
TurnRatesAF1:
	dc.b	$00,$08,$00,$10,$00,$18,$00,$20,$00,$28,$00,$30,$00,$38,$00,$40
	dc.b	$00,$48,$00,$50,$00,$58
dat_030_0118A:
	dc.b	$00,$08,$00,$10,$00,$18,$00,$20,$00,$28,$00,$30,$00,$38,$00,$40
	dc.b	$00,$48,$00,$50,$00,$58
h030_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    59,30                           ; 59 longs pointing into hunk 30
	dc.l	$1036,$102E,$101E,$DCE,$DC6,$D56,$738,$6F8
	dc.l	$69A,$602,$570,$502,$4BE,$47A,$40E,$394
	dc.l	$310,$292,$216,$9C,$98,$94,$90,$8C
	dc.l	$88,$84,$80,$7C,$78,$74,$70,$6C
	dc.l	$68,$64,$60,$5C,$58,$54,$50,$4C
	dc.l	$48,$44,$40,$3C,$38,$34,$30,$2C
	dc.l	$28,$24,$20,$1C,$18,$14,$10,$C
	dc.l	$8,$4,$0
        dc.l    10,71                           ; 10 longs pointing into hunk 71
	dc.l	$920,$7C4,$7DA,$7AA,$870,$9AC,$8C4,$8BE
	dc.l	$780,$84C
        dc.l    1,27                            ; 1 longs pointing into hunk 27
	dc.l	$946
        dc.l    1,20                            ; 1 longs pointing into hunk 20
	dc.l	$B2C
        dc.l    1,7                             ; 1 longs pointing into hunk 7
	dc.l	$852
	dc.l	0
	dc.l	HUNK_END
	endc
