; F/A-18 Interceptor - hunk 5 (code)
; HandleKey: the keyboard commands (each Key_ label is named by its key) and the stick
; directions.
; Included by ../f18_main.s.

;===============================================================================
; Hunk 5: CODE, $16A8 bytes
;===============================================================================
	CODE_HUNK	h005
l_005_00000:
        move.w  #$33,(DebugCheckpoint).l        ; 00000
        jsr     (Nop).l                         ; 00008
        rts                                     ; 0000E

;-------------------------------------------------------------------------------
; ViewKeysFrame - Handles the view keys of the frame (FrameEvents1).
;-------------------------------------------------------------------------------
ViewKeysFrame:
        move.w  (FrameEvents1).l,d0             ; 00010
        andi.w  #$f0,d0                         ; 00016
        bne.b   l_005_00000                     ; 0001A
        moveq   #$0,d0                          ; 0001C
        move.b  (OutsideView).l,d5              ; 0001E
        moveq   #$0,d6                          ; 00024
        lea.l   (FrameEvents1).l,a0             ; 00026
        tst.w   (a0)                            ; 0002C
        beq.b   l_005_00098                     ; 0002E
        bclr    #$0,(a0)                        ; 00030
        bne.w   Key_G                           ; 00034
        bclr    #$1,(a0)                        ; 00038
        bne.w   Key_A                           ; 0003C
        bclr    #$2,(a0)                        ; 00040
        bne.w   Key_Space                       ; 00044
        bclr    #$3,(a0)                        ; 00048
        bne.w   Key_SpaceUp                     ; 0004C
        bclr    #$4,(a0)                        ; 00050
        bne.w   Key_Return                      ; 00054
        bclr    #$5,(a0)                        ; 00058
        bne.w   Key_E                           ; 0005C
        bclr    #$6,(a0)                        ; 00060
        bne.w   Key_R                           ; 00064
        bclr    #$7,(a0)                        ; 00068
        bne.w   Key_T                           ; 0006C
        bclr    #$0,$1(a0)                      ; 00070
        bne.w   Key_Backslash_Backspace         ; 00076
        bclr    #$1,$1(a0)                      ; 0007A
        bne.w   Key_F                           ; 00080
        bclr    #$2,$1(a0)                      ; 00084
        bne.w   Key_C                           ; 0008A
        bclr    #$3,$1(a0)                      ; 0008E
        bne.w   Key_J                           ; 00094
l_005_00098:
        cmpi.b  #$2,(RecordMode).l              ; 00098
        beq.w   l_005_00158                     ; 000A0
        cmpi.b  #$1,(RecordMode).l              ; 000A4
        beq.w   l_005_00158                     ; 000AC
        lea.l   (FrameEvents2).l,a0             ; 000B0
        tst.w   (a0)                            ; 000B6
        beq.w   l_005_0014C                     ; 000B8
        bclr    #$0,(a0)                        ; 000BC
        bne.w   Key_M                           ; 000C0
        bclr    #$1,(a0)                        ; 000C4
        bne.w   l_005_00A54                     ; 000C8
        bclr    #$2,(a0)                        ; 000CC
        bne.w   l_005_00AAA                     ; 000D0
        bclr    #$3,(a0)                        ; 000D4
        bne.w   l_005_00BD8                     ; 000D8
        bclr    #$4,(a0)                        ; 000DC
        bne.w   Key_KP8                         ; 000E0
        bclr    #$5,(a0)                        ; 000E4
        bne.w   Key_KP9                         ; 000E8
        bclr    #$6,(a0)                        ; 000EC
        bne.w   Key_KP6                         ; 000F0
        bclr    #$7,(a0)                        ; 000F4
        bne.w   Key_KP3                         ; 000F8
        bclr    #$0,$1(a0)                      ; 000FC
        bne.w   Key_KP2                         ; 00102
        bclr    #$1,$1(a0)                      ; 00106
        bne.w   Key_KP1                         ; 0010C
        bclr    #$2,$1(a0)                      ; 00110
        bne.w   Key_KP4                         ; 00116
        bclr    #$3,$1(a0)                      ; 0011A
        bne.w   Key_KP7                         ; 00120
        bclr    #$4,$1(a0)                      ; 00124
        bne.w   l_005_00B9E                     ; 0012A
        bclr    #$5,$1(a0)                      ; 0012E
        bne.w   Key_KPDot                       ; 00134
        bclr    #$6,$1(a0)                      ; 00138
        bne.w   Key_KP2Up_KP4Up_KP6Up           ; 0013E
        bclr    #$7,$1(a0)                      ; 00142
        bne.w   l_005_00C78                     ; 00148
l_005_0014C:
        clr.b   (LeftAmigaDown).l               ; 0014C
        clr.b   (RightAmigaDown).l              ; 00152
l_005_00158:
        rts                                     ; 00158
l_005_0015A:
        rts                                     ; 0015A

;-------------------------------------------------------------------------------
; HandleKey - HandleKey(code): the keyboard commands. Takes a raw key code from GetKey
; (releases have $80 added) and, depending on what the game is doing (its modes in
; OutsideView, CameraSequence, RecordMode, GameMode...), goes to the key's command:
; the Key_ labels below are named by the key that leads there (Amiga raw key codes: $40 Space,
; $4C-$4F the cursor keys, $50-$59 F1-F10, $0F-$3F the numeric keypad...).
;-------------------------------------------------------------------------------
HandleKey:
        link.w  a6,#$0                          ; 0015C
        move.l  $8(a6),d0                       ; 00160
        unlk    a6                              ; 00164
        tst.b   (TextKeyCount).l                ; 00166
        bgt.b   l_005_0017A                     ; 0016C
        addq.b  #$1,(TextKeyCount).l            ; 0016E
        ble.b   l_005_0015A                     ; 00174
        bclr    #$7,d0                          ; 00176
l_005_0017A:
        move.b  (OutsideView).l,d5              ; 0017A
        move.b  (ShiftDown).l,d6                ; 00180
        move.b  (CameraSequence).l,d3           ; 00186
        cmpi.b  #$3,d3                          ; 0018C
        beq.w   l_005_00420                     ; 00190
        tst.b   (LogDiskCheck).l                ; 00194
        bne.w   l_005_00420                     ; 0019A
        tst.b   (KeyMode).l                     ; 0019E
        bne.w   l_005_00420                     ; 001A4
        tst.b   (AircraftChosen).l              ; 001A8
        bne.w   l_005_0038A                     ; 001AE
        tst.b   (TextInputOn).l                 ; 001B2
        beq.w   l_005_0038A                     ; 001B8
        tst.b   (GameMode).l                    ; 001BC
        beq.w   l_005_0038A                     ; 001C2
        move.b  (RecordMode).l,d1               ; 001C6
        blt.w   l_005_0038A                     ; 001CC
        cmpi.b  #$3,d1                          ; 001D0
        beq.w   l_005_00418                     ; 001D4
        tst.b   d3                              ; 001D8
        bne.w   l_005_002C8                     ; 001DA
        cmpi.b  #$2,(GameMode).l                ; 001DE
        beq.w   l_005_002C8                     ; 001E6
        move.b  (PlayerEjection).l,d4           ; 001EA
        andi.b  #$f,d4                          ; 001F0
        bne.w   l_005_002C8                     ; 001F4
        cmpi.b  #$1,d1                          ; 001F8
        beq.w   l_005_002C8                     ; 001FC
        cmpi.b  #$2,d1                          ; 00200
        beq.w   l_005_002C8                     ; 00204
        cmpi.b  #$5,d1                          ; 00208
        bge.w   l_005_00418                     ; 0020C
        cmpi.b  #$40,d0                         ; 00210
        beq.w   Key_Space                       ; 00214
        cmpi.b  #$4c,d0                         ; 00218
        beq.w   Key_Up                          ; 0021C
        cmpi.b  #$4d,d0                         ; 00220
        beq.w   Key_Down                        ; 00224
        cmpi.b  #$4f,d0                         ; 00228
        beq.w   Key_Left                        ; 0022C
        cmpi.b  #$4e,d0                         ; 00230
        beq.w   Key_Right                       ; 00234
        cmpi.b  #$38,d0                         ; 00238
        beq.w   Key_Comma                       ; 0023C
        cmpi.b  #$39,d0                         ; 00240
        beq.w   Key_Period                      ; 00244
        cmpi.b  #$c,d0                          ; 00248
        beq.w   Key_Equals                      ; 0024C
        cmpi.b  #$b,d0                          ; 00250
        beq.w   Key_Minus                       ; 00254
        cmpi.b  #$d,d0                          ; 00258
        beq.w   Key_Backslash_Backspace         ; 0025C
        cmpi.b  #$41,d0                         ; 00260
        beq.w   Key_Backslash_Backspace         ; 00264
        cmpi.b  #$12,d0                         ; 00268
        beq.w   Key_E                           ; 0026C
        cmpi.b  #$13,d0                         ; 00270
        beq.w   Key_R                           ; 00274
        cmpi.b  #$24,d0                         ; 00278
        beq.w   Key_G                           ; 0027C
        cmpi.b  #$20,d0                         ; 00280
        beq.w   Key_A                           ; 00284
        cmpi.b  #$23,d0                         ; 00288
        beq.w   Key_F                           ; 0028C
        cmpi.b  #$33,d0                         ; 00290
        beq.w   Key_C                           ; 00294
        cmpi.b  #$26,d0                         ; 00298
        beq.w   Key_J                           ; 0029C
        cmpi.b  #$25,d0                         ; 002A0
        beq.w   Key_H                           ; 002A4
        cmpi.b  #$21,d0                         ; 002A8
        beq.w   Key_S                           ; 002AC
        cmpi.b  #$14,d0                         ; 002B0
        beq.w   Key_T                           ; 002B4
        cmpi.b  #$15,d0                         ; 002B8
        beq.w   Key_Y                           ; 002BC
        cmpi.b  #$37,d0                         ; 002C0
        beq.w   Key_M                           ; 002C4
l_005_002C8:
        move.b  (CameraSequence).l,d3           ; 002C8
        beq.b   l_005_002DC                     ; 002CE
        cmpi.b  #$6,d3                          ; 002D0
        beq.w   l_005_0035C                     ; 002D4
        bra.w   l_005_00364                     ; 002D8
l_005_002DC:
        cmpi.b  #$44,d0                         ; 002DC
        beq.w   Key_Return                      ; 002E0
        cmpi.b  #$3e,d0                         ; 002E4
        beq.w   Key_KP8                         ; 002E8
        cmpi.b  #$1e,d0                         ; 002EC
        beq.w   Key_KP2                         ; 002F0
        cmpi.b  #$2d,d0                         ; 002F4
        beq.w   Key_KP4                         ; 002F8
        cmpi.b  #$2f,d0                         ; 002FC
        beq.w   Key_KP6                         ; 00300
        cmpi.b  #$3d,d0                         ; 00304
        beq.w   Key_KP7                         ; 00308
        cmpi.b  #$1d,d0                         ; 0030C
        beq.w   Key_KP1                         ; 00310
        cmpi.b  #$2e,d0                         ; 00314
        beq.w   Key_KP5                         ; 00318
        cmpi.b  #$3f,d0                         ; 0031C
        beq.w   Key_KP9                         ; 00320
        cmpi.b  #$1f,d0                         ; 00324
        beq.w   Key_KP3                         ; 00328
        cmpi.b  #$3c,d0                         ; 0032C
        beq.w   Key_KPDot                       ; 00330
        cmpi.b  #$9e,d0                         ; 00334
        beq.w   Key_KP2Up_KP4Up_KP6Up           ; 00338
        cmpi.b  #$ad,d0                         ; 0033C
        beq.w   Key_KP2Up_KP4Up_KP6Up           ; 00340
        cmpi.b  #$af,d0                         ; 00344
        beq.w   Key_KP2Up_KP4Up_KP6Up           ; 00348
        cmpi.b  #$bd,d0                         ; 0034C
        beq.w   Key_KP2Up_KP4Up_KP6Up           ; 00350
        cmpi.b  #$9d,d0                         ; 00354
        beq.w   Key_KP2Up_KP4Up_KP6Up           ; 00358
l_005_0035C:
        cmpi.b  #$43,d0                         ; 0035C
        beq.w   Key_KPEnter                     ; 00360
l_005_00364:
        cmpi.b  #$45,d0                         ; 00364
        beq.w   Key_Esc                         ; 00368
        cmpi.b  #$2,(GameMode).l                ; 0036C
        beq.w   l_005_003F8                     ; 00374
        cmpi.b  #$5,d3                          ; 00378
        beq.b   l_005_0038A                     ; 0037C
        cmpi.b  #$6,d3                          ; 0037E
        beq.b   l_005_0038A                     ; 00382
        tst.b   d3                              ; 00384
        bgt.w   l_005_00420                     ; 00386
l_005_0038A:
        cmpi.b  #$1,d0                          ; 0038A
        blt.b   l_005_003A6                     ; 0038E
        cmpi.b  #$a,d0                          ; 00390
        ble.w   l_005_0105A                     ; 00394
        cmpi.b  #$50,d0                         ; 00398
        blt.b   l_005_003A6                     ; 0039C
        cmpi.b  #$59,d0                         ; 0039E
        ble.w   l_005_01038                     ; 003A2
l_005_003A6:
        cmpi.b  #$1d,d0                         ; 003A6
        bne.b   l_005_003B0                     ; 003AA
        moveq   #$0,d4                          ; 003AC
        bra.b   l_005_003F4                     ; 003AE
l_005_003B0:
        cmpi.b  #$1e,d0                         ; 003B0
        bne.b   l_005_003BA                     ; 003B4
        moveq   #$1,d4                          ; 003B6
        bra.b   l_005_003F4                     ; 003B8
l_005_003BA:
        cmpi.b  #$1f,d0                         ; 003BA
        bne.b   l_005_003C4                     ; 003BE
        moveq   #$2,d4                          ; 003C0
        bra.b   l_005_003F4                     ; 003C2
l_005_003C4:
        cmpi.b  #$2d,d0                         ; 003C4
        bne.b   l_005_003CE                     ; 003C8
        moveq   #$3,d4                          ; 003CA
        bra.b   l_005_003F4                     ; 003CC
l_005_003CE:
        cmpi.b  #$2e,d0                         ; 003CE
        bne.b   l_005_003D8                     ; 003D2
        moveq   #$4,d4                          ; 003D4
        bra.b   l_005_003F4                     ; 003D6
l_005_003D8:
        cmpi.b  #$2f,d0                         ; 003D8
        bne.b   l_005_003E2                     ; 003DC
        moveq   #$5,d4                          ; 003DE
        bra.b   l_005_003F4                     ; 003E0
l_005_003E2:
        cmpi.b  #$3d,d0                         ; 003E2
        bne.b   l_005_003EC                     ; 003E6
        moveq   #$6,d4                          ; 003E8
        bra.b   l_005_003F4                     ; 003EA
l_005_003EC:
        cmpi.b  #$3e,d0                         ; 003EC
        bne.b   l_005_003F8                     ; 003F0
        moveq   #$7,d4                          ; 003F2
l_005_003F4:
        bra.w   l_005_01060                     ; 003F4
l_005_003F8:
        cmpi.b  #$1b,d0                         ; 003F8
        beq.w   Key_RBracket                    ; 003FC
        cmpi.b  #$1a,d0                         ; 00400
        beq.w   Key_LBracket                    ; 00404
        cmpi.b  #$9b,d0                         ; 00408
        beq.w   Key_KP2Up_KP4Up_KP6Up           ; 0040C
        cmpi.b  #$9a,d0                         ; 00410
        beq.w   Key_KP2Up_KP4Up_KP6Up           ; 00414
l_005_00418:
        cmpi.b  #$19,d0                         ; 00418
        beq.w   Key_P                           ; 0041C
l_005_00420:
        cmpi.b  #$2,(KeyMode).l                 ; 00420
        bne.b   l_005_00432                     ; 00428
        cmpi.b  #$43,d0                         ; 0042A
        beq.w   Key_KPEnter                     ; 0042E
l_005_00432:
        cmpi.b  #$cc,d0                         ; 00432
        beq.w   Key_UpUp_DownUp                 ; 00436
        cmpi.b  #$cd,d0                         ; 0043A
        beq.w   Key_UpUp_DownUp                 ; 0043E
        cmpi.b  #$cf,d0                         ; 00442
        beq.w   Key_LeftUp_RightUp              ; 00446
        cmpi.b  #$ce,d0                         ; 0044A
        beq.w   Key_LeftUp_RightUp              ; 0044E
        cmpi.b  #$b8,d0                         ; 00452
        beq.w   Key_CommaUp_PeriodUp            ; 00456
        cmpi.b  #$b9,d0                         ; 0045A
        beq.w   Key_CommaUp_PeriodUp            ; 0045E
        cmpi.b  #$8c,d0                         ; 00462
        beq.w   Key_EqualsUp_MinusUp            ; 00466
        cmpi.b  #$8b,d0                         ; 0046A
        beq.w   Key_EqualsUp_MinusUp            ; 0046E
        cmpi.b  #$c0,d0                         ; 00472
        beq.w   Key_SpaceUp                     ; 00476
        cmpi.b  #$60,d0                         ; 0047A
        beq.b   Key_LShift                      ; 0047E
        cmpi.b  #$61,d0                         ; 00480
        bne.b   l_005_00492                     ; 00484
Key_LShift:
        move.b  #$1,(ShiftDown).l               ; 00486
        bra.w   Key_LShiftUp_RShiftUp           ; 0048E
l_005_00492:
        cmpi.b  #$e0,d0                         ; 00492
        beq.w   Key_LShiftUp_RShiftUp           ; 00496
        cmpi.b  #$e1,d0                         ; 0049A
        beq.w   Key_LShiftUp_RShiftUp           ; 0049E
        cmpi.b  #$66,d0                         ; 004A2
        beq.b   Key_LAmiga                      ; 004A6
        cmpi.b  #$e6,d0                         ; 004A8
        bne.b   l_005_004BE                     ; 004AC
        bra.w   Key_LShiftUp_RShiftUp           ; 004AE
Key_LAmiga:
        move.b  #$1,(LeftAmigaDown).l           ; 004B2
        bra.w   Key_LShiftUp_RShiftUp           ; 004BA
l_005_004BE:
        cmpi.b  #$67,d0                         ; 004BE
        beq.b   Key_RAmiga                      ; 004C2
        cmpi.b  #$e7,d0                         ; 004C4
        bne.b   l_005_004DA                     ; 004C8
        bra.w   Key_LShiftUp_RShiftUp           ; 004CA
Key_RAmiga:
        move.b  #$1,(RightAmigaDown).l          ; 004CE
        bra.w   Key_LShiftUp_RShiftUp           ; 004D6
l_005_004DA:
        cmpi.b  #$2,(TextStatus).l              ; 004DA
        beq.b   l_005_004EC                     ; 004E2
        cmpi.b  #$31,d0                         ; 004E4
        beq.w   Key_Z_Del                       ; 004E8
l_005_004EC:
        cmpi.b  #$46,d0                         ; 004EC
        beq.w   Key_Z_Del                       ; 004F0
        cmpi.b  #$45,d0                         ; 004F4
        beq.w   Key_Esc                         ; 004F8
        cmpi.b  #$44,d0                         ; 004FC
        bne.w   l_005_01624                     ; 00500
        clr.b   (LogDiskCheck).l                ; 00504
        bra.w   l_005_01624                     ; 0050A
Key_E:
        tst.b   d6                              ; 0050E
        bne.b   l_005_00516                     ; 00510
        bra.w   l_005_01624                     ; 00512
l_005_00516:
        tst.b   (WorldFrozen).l                 ; 00516
        bne.w   l_005_01624                     ; 0051C
        move.b  #$8,(PanelIndicatorBlink).l     ; 00520
        lea.l   (EjectKeyFlag).l,a0             ; 00528
        bsr.w   ToggleByte                      ; 0052E
        bset    #$5,(JoyEvents).l               ; 00532
        ori.b   #$a,(PlayerEjection).l          ; 0053A
        bra.w   l_005_01624                     ; 00542

;-------------------------------------------------------------------------------
; SetViewLimits - Sets ClipY by ViewY (the bottom of the 3D view).
;-------------------------------------------------------------------------------
SetViewLimits:
        tst.w   (ViewY).l                       ; 00546
        beq.b   l_005_0055C                     ; 0054C
        move.w  #$0,d1                          ; 0054E
        move.w  #$90,(ClipY).l                  ; 00552
        bra.b   l_005_00568                     ; 0055A
l_005_0055C:
        move.w  #$ffff,d1                       ; 0055C
        move.w  #$8f,(ClipY).l                  ; 00560
l_005_00568:
        move.w  d1,(ViewY).l                    ; 00568
        asl.w   #$3,d1                          ; 0056E
        move.w  d1,d3                           ; 00570
        add.w   d3,d3                           ; 00572
        add.w   d3,d3                           ; 00574
        add.w   d3,d1                           ; 00576
        ext.l   d1                              ; 00578
        move.l  d1,(PanelShakeOffset).l         ; 0057A
        move.b  #$0,(ViewKeyFlag).l             ; 00580
        bra.w   ApplyViewZoom                   ; 00588
Key_T:
        jsr     (KeyBeep).l                     ; 0058C
        bset    #$7,(JoyEvents).l               ; 00592
        move.b  #$1,(TKeyPressed).l             ; 0059A
        bra.w   l_005_01624                     ; 005A2
	dc.b	$41,$F9
        dc.l    CameraFollows                   ; 005A8
	dc.b	$60,$00,$10,$4E
Key_R:
        jsr     (KeyBeep).l                     ; 005B0
        bset    #$6,(JoyEvents).l               ; 005B6
        lea.l   (ObjectTable).l,a0              ; 005BE
        adda.w  (ViewObject).l,a0               ; 005C4
        move.b  $63(a0),d4                      ; 005CA
        andi.b  #$f,d4                          ; 005CE
        cmpi.b  #$9,d4                          ; 005D2
        beq.b   l_005_005E4                     ; 005D6
        cmpi.b  #$b,d4                          ; 005D8
        beq.b   l_005_005EA                     ; 005DC
        move.b  #$b,d4                          ; 005DE
        bra.b   l_005_005EE                     ; 005E2
l_005_005E4:
        move.b  #$d,d4                          ; 005E4
        bra.b   l_005_005EE                     ; 005E8
l_005_005EA:
        move.b  #$9,d4                          ; 005EA
l_005_005EE:
        andi.b  #$f0,$63(a0)                    ; 005EE
        or.b    d4,$63(a0)                      ; 005F4
        move.b  #$3,(WeaponRangeRedraw).l       ; 005F8
        bra.w   l_005_01624                     ; 00600
Key_Space:
        tst.b   d6                              ; 00604
        bne.w   l_005_01624                     ; 00606
        jsr     (FirePressed).l                 ; 0060A
        bra.w   l_005_01624                     ; 00610
Key_SpaceUp:
        jsr     (FireReleased).l                ; 00614
        bra.w   l_005_01624                     ; 0061A
Key_Y:
        move.w  (TargetReadoutMode).l,d0        ; 0061E
        addq.w  #$1,d0                          ; 00624
        cmpi.w  #$3,d0                          ; 00626
        ble.b   l_005_0062E                     ; 0062A
        moveq   #$1,d0                          ; 0062C
l_005_0062E:
        bset    #$f,d0                          ; 0062E
        move.w  d0,(TargetReadoutMode).l        ; 00632
        move.b  #$5,(TargetReadoutCount).l      ; 00638
        move.b  #$2,(TargetReadoutRedraw).l     ; 00640
        bra.w   l_005_01624                     ; 00648
Key_H:
        move.b  (HUDOn).l,d4                    ; 0064C
        addq.b  #$1,d4                          ; 00652
        cmpi.b  #$1,d4                          ; 00654
        ble.b   l_005_0065C                     ; 00658
        clr.b   d4                              ; 0065A
l_005_0065C:
        move.b  d4,(HUDOn).l                    ; 0065C
        bra.w   l_005_01624                     ; 00662

;-------------------------------------------------------------------------------
; PlayerFrameControls - The player's controls for the frame: in the replay modes (RecordMode
; 1-3) the control byte and the event words come from the recording (ReplayPointer,
; ReplayControlsPointer; it ends at three $FF bytes or at the end of the buffer, and starts
; again); then the throttle (+$2B) is moved towards GearState (ThrottleUp / 008BC /
; 008C6)...
;-------------------------------------------------------------------------------
PlayerFrameControls:
        tst.w   (CurrentObjectOffset).l         ; 00666
        bne.w   l_005_007D2                     ; 0066C
        move.b  (RecordMode).l,d0               ; 00670
        ble.w   l_005_00728                     ; 00676
        cmpi.b  #$3,d0                          ; 0067A
        bgt.w   l_005_00728                     ; 0067E
        movea.l (ReplayPointer).l,a0            ; 00682
        move.b  (a0)+,(PlayerControls).l        ; 00688
        move.l  a0,(ReplayPointer).l            ; 0068E
        movea.l (ReplayControlsPointer).l,a2    ; 00694
        move.w  (a2)+,(FrameEvents1).l          ; 0069A
        move.w  (a2)+,d0                        ; 006A0
        cmpi.b  #$1,(RecordMode).l              ; 006A2
        beq.b   l_005_006B2                     ; 006AA
        move.w  d0,(FrameEvents2).l             ; 006AC
l_005_006B2:
        move.l  (RecordLength).l,d0             ; 006B2
        add.l   d0,d0                           ; 006B8
        add.l   d0,d0                           ; 006BA
        add.l   (RecordControls).l,d0           ; 006BC
        cmp.l   a2,d0                           ; 006C2
        bgt.b   l_005_006CC                     ; 006C4
        movea.l (RecordControls).l,a2           ; 006C6
l_005_006CC:
        move.l  a2,(ReplayControlsPointer).l    ; 006CC
l_005_006D2:
        movea.l (ReplayPointer).l,a3            ; 006D2
        cmpi.b  #$ff,(a3)+                      ; 006D8
        bne.b   l_005_006EA                     ; 006DC
        cmpi.b  #$ff,(a3)+                      ; 006DE
        bne.b   l_005_006EA                     ; 006E2
        cmpi.b  #$ff,(a3)+                      ; 006E4
        beq.b   l_005_00724                     ; 006E8
l_005_006EA:
        cmpa.l  (RecordPointer).l,a0            ; 006EA
        beq.b   l_005_00724                     ; 006F0
        move.l  (RecordBuffer).l,d0             ; 006F2
        add.l   (RecordLength).l,d0             ; 006F8
        cmp.l   a0,d0                           ; 006FE
        bgt.b   l_005_00728                     ; 00700
        move.l  (RecordBuffer).l,(ReplayPointer).l ; 00702
        move.l  (RecordControls).l,(ReplayControlsPointer).l ; 0070C
        addq.l  #$4,(ReplayControlsPointer).l   ; 00716
        movea.l (ReplayPointer).l,a0            ; 0071C
        bra.b   l_005_006D2                     ; 00722
l_005_00724:
        bra.w   l_005_0159C                     ; 00724
l_005_00728:
        move.b  $7c(a1),d0                      ; 00728
        andi.b  #$f,d0                          ; 0072C
        bne.w   l_005_007F6                     ; 00730
        tst.b   (WorldFrozen).l                 ; 00734
        bne.b   l_005_007B4                     ; 0073A
        move.b  (GearState).l,d0                ; 0073C
        beq.b   l_005_007B4                     ; 00742
        bgt.b   l_005_00748                     ; 00744
        clr.b   d0                              ; 00746
l_005_00748:
        move.b  (RecordMode).l,d1               ; 00748
        cmpi.b  #$3,d1                          ; 0074E
        beq.b   l_005_007B4                     ; 00752
        subq.b  #$1,d1                          ; 00754
        beq.b   l_005_007B4                     ; 00756
        move.b  $39(a1),d1                      ; 00758
        andi.b  #$f,d1                          ; 0075C
        sub.b   $2b(a1),d0                      ; 00760
        beq.b   l_005_00798                     ; 00764
        bgt.b   l_005_00780                     ; 00766
        cmpi.b  #$f8,d0                         ; 00768
        blt.b   l_005_0077A                     ; 0076C
        cmpi.b  #$2,d1                          ; 0076E
        blt.b   l_005_0077A                     ; 00772
        bsr.w   ThrottleHold                    ; 00774
        bra.b   l_005_007B4                     ; 00778
l_005_0077A:
        bsr.w   ThrottleDown                    ; 0077A
        bra.b   l_005_007B4                     ; 0077E
l_005_00780:
        cmpi.b  #$8,d0                          ; 00780
        bgt.b   l_005_00792                     ; 00784
        cmpi.b  #$2,d1                          ; 00786
        blt.b   l_005_00792                     ; 0078A
        bsr.w   ThrottleHold                    ; 0078C
        bra.b   l_005_007B4                     ; 00790
l_005_00792:
        bsr.w   ThrottleUp                      ; 00792
        bra.b   l_005_007B4                     ; 00796
l_005_00798:
        cmpi.b  #$78,$2b(a1)                    ; 00798
        blt.b   l_005_007B0                     ; 0079E
        btst    #$3,$3(a1)                      ; 007A0
        bne.b   l_005_007B0                     ; 007A6
        btst    #$5,$2(a1)                      ; 007A8
        bne.b   l_005_007B4                     ; 007AE
l_005_007B0:
        bsr.w   ThrottleHoldReset               ; 007B0
l_005_007B4:
        tst.w   (CurrentObjectOffset).l         ; 007B4
        bne.b   l_005_007D2                     ; 007BA
        move.b  (RecordMode).l,d4               ; 007BC
        beq.b   l_005_007C8                     ; 007C2
        subq.b  #$1,d4                          ; 007C4
        bne.b   l_005_007D2                     ; 007C6
l_005_007C8:
        move.l  a1,-(a7)                        ; 007C8
        jsr     (RecordFrame).l                 ; 007CA
        movea.l (a7)+,a1                        ; 007D0
l_005_007D2:
        clr.b   d4                              ; 007D2
        btst    #$4,$4(a1)                      ; 007D4
        beq.b   l_005_007F8                     ; 007DA
        tst.w   $4c(a1)                         ; 007DC
        bge.b   l_005_007EA                     ; 007E0
        bclr    #$4,$4(a1)                      ; 007E2
        bra.b   l_005_007F8                     ; 007E8
l_005_007EA:
        move.b  d4,$28(a1)                      ; 007EA
        move.b  d4,$29(a1)                      ; 007EE
        move.b  d4,$2a(a1)                      ; 007F2
l_005_007F6:
        rts                                     ; 007F6
l_005_007F8:
        move.b  $65(a1),d2                      ; 007F8
        move.b  d2,d3                           ; 007FC
        andi.b  #$30,d2                         ; 007FE
        bne.b   l_005_00806                     ; 00802
        bra.b   l_005_00836                     ; 00804
l_005_00806:
        cmpi.b  #$10,d2                         ; 00806
        beq.b   l_005_00822                     ; 0080A
        move.b  $28(a1),d4                      ; 0080C
        ble.b   l_005_00816                     ; 00810
        moveq   #-1,d4                          ; 00812
        bra.b   l_005_00818                     ; 00814
l_005_00816:
        subq.b  #$1,d4                          ; 00816
l_005_00818:
        cmpi.b  #$ec,d4                         ; 00818
        bge.b   l_005_00836                     ; 0081C
        moveq   #-20,d4                         ; 0081E
        bra.b   l_005_00836                     ; 00820
l_005_00822:
        move.b  $28(a1),d4                      ; 00822
        bge.b   l_005_0082C                     ; 00826
        moveq   #$1,d4                          ; 00828
        bra.b   l_005_0082E                     ; 0082A
l_005_0082C:
        addq.b  #$1,d4                          ; 0082C
l_005_0082E:
        cmpi.b  #$14,d4                         ; 0082E
        ble.b   l_005_00836                     ; 00832
        moveq   #$14,d4                         ; 00834
l_005_00836:
        move.b  d4,$28(a1)                      ; 00836
        clr.b   d4                              ; 0083A
        move.b  d3,d2                           ; 0083C
        andi.b  #$c0,d3                         ; 0083E
        beq.b   l_005_00874                     ; 00842
        cmpi.b  #$40,d3                         ; 00844
        beq.b   l_005_00860                     ; 00848
        move.b  $29(a1),d4                      ; 0084A
        ble.b   l_005_00854                     ; 0084E
        moveq   #-1,d4                          ; 00850
        bra.b   l_005_00856                     ; 00852
l_005_00854:
        subq.b  #$1,d4                          ; 00854
l_005_00856:
        cmpi.b  #$ec,d4                         ; 00856
        bge.b   l_005_00874                     ; 0085A
        moveq   #-20,d4                         ; 0085C
        bra.b   l_005_00874                     ; 0085E
l_005_00860:
        move.b  $29(a1),d4                      ; 00860
        bge.b   l_005_0086A                     ; 00864
        moveq   #$1,d4                          ; 00866
        bra.b   l_005_0086C                     ; 00868
l_005_0086A:
        addq.b  #$1,d4                          ; 0086A
l_005_0086C:
        cmpi.b  #$14,d4                         ; 0086C
        ble.b   l_005_00874                     ; 00870
        moveq   #$14,d4                         ; 00872
l_005_00874:
        move.b  d4,$29(a1)                      ; 00874
        clr.b   d4                              ; 00878
        andi.b  #$c,d2                          ; 0087A
        bne.b   l_005_00882                     ; 0087E
        bra.b   l_005_008B2                     ; 00880
l_005_00882:
        cmpi.b  #$4,d2                          ; 00882
        beq.b   l_005_0089E                     ; 00886
        move.b  $2a(a1),d4                      ; 00888
        ble.b   l_005_00892                     ; 0088C
        moveq   #-3,d4                          ; 0088E
        bra.b   l_005_00894                     ; 00890
l_005_00892:
        subq.b  #$3,d4                          ; 00892
l_005_00894:
        cmpi.b  #$c4,d4                         ; 00894
        bge.b   l_005_008B2                     ; 00898
        moveq   #-60,d4                         ; 0089A
        bra.b   l_005_008B2                     ; 0089C
l_005_0089E:
        move.b  $2a(a1),d4                      ; 0089E
        bge.b   l_005_008A8                     ; 008A2
        moveq   #$3,d4                          ; 008A4
        bra.b   l_005_008AA                     ; 008A6
l_005_008A8:
        addq.b  #$3,d4                          ; 008A8
l_005_008AA:
        cmpi.b  #$3c,d4                         ; 008AA
        ble.b   l_005_008B2                     ; 008AE
        moveq   #$3c,d4                         ; 008B0
l_005_008B2:
        move.b  d4,$2a(a1)                      ; 008B2
        rts                                     ; 008B6

;-------------------------------------------------------------------------------
; ThrottleUp - Sets PlayerControls' throttle bits (bits 0-1) to 1 (up).
;-------------------------------------------------------------------------------
ThrottleUp:
        moveq   #$1,d2                          ; 008B8
        bra.b   l_005_008C8                     ; 008BA

;-------------------------------------------------------------------------------
; ThrottleDown - Sets PlayerControls' throttle bits to 2 (down).
;-------------------------------------------------------------------------------
ThrottleDown:
        moveq   #$2,d2                          ; 008BC
        bra.b   l_005_008C8                     ; 008BE

;-------------------------------------------------------------------------------
; ThrottleHoldReset - Clears GearState, then ThrottleHold.
;-------------------------------------------------------------------------------
ThrottleHoldReset:
        clr.b   (GearState).l                   ; 008C0

;-------------------------------------------------------------------------------
; ThrottleHold - Clears PlayerControls' throttle bits (neither up nor down).
;-------------------------------------------------------------------------------
ThrottleHold:
        moveq   #$0,d2                          ; 008C6
l_005_008C8:
        move.b  (PlayerControls).l,d1           ; 008C8
        andi.b  #$fc,d1                         ; 008CE
        or.b    d2,d1                           ; 008D2
        move.b  d1,(PlayerControls).l           ; 008D4
        rts                                     ; 008DA
Key_Down:
        bsr.w   StickDown                       ; 008DC
        bra.w   l_005_01624                     ; 008E0
Key_Up:
        bsr.w   StickUp                         ; 008E4
        bra.w   l_005_01624                     ; 008E8
Key_UpUp_DownUp:
        bsr.w   StickPitchCentre                ; 008EC
        bra.w   l_005_01624                     ; 008F0

;-------------------------------------------------------------------------------
; StickDown - The stick (or cursor down) pushed down: PitchInput = $20 (and into the player's
; control bits, ObjectTable+$65, when MapView or CameraFollows is set).
;-------------------------------------------------------------------------------
StickDown:
        moveq   #$20,d2                         ; 008F4
        bra.b   l_005_008FE                     ; 008F6

;-------------------------------------------------------------------------------
; StickUp - The stick pushed up: PitchInput = $10.
;-------------------------------------------------------------------------------
StickUp:
        moveq   #$10,d2                         ; 008F8
        bra.b   l_005_008FE                     ; 008FA

;-------------------------------------------------------------------------------
; StickPitchCentre - The stick back in the middle (up/down): PitchInput = 0.
;-------------------------------------------------------------------------------
StickPitchCentre:
        moveq   #$0,d2                          ; 008FC
l_005_008FE:
        move.b  d2,(PitchInput).l               ; 008FE
        tst.b   (MapView).l                     ; 00904
        bne.b   l_005_00914                     ; 0090A
        tst.b   (CameraFollows).l               ; 0090C
        beq.b   l_005_00926                     ; 00912
l_005_00914:
        move.b  (PlayerControls).l,d1           ; 00914
        andi.b  #$cf,d1                         ; 0091A
        or.b    d2,d1                           ; 0091E
        move.b  d1,(PlayerControls).l           ; 00920
l_005_00926:
        rts                                     ; 00926
Key_Left:
        bsr.w   StickLeft                       ; 00928
        bra.w   l_005_01624                     ; 0092C
Key_Right:
        bsr.w   StickRight                      ; 00930
        bra.w   l_005_01624                     ; 00934
Key_LeftUp_RightUp:
        bsr.w   StickRollCentre                 ; 00938
        bra.w   l_005_01624                     ; 0093C

;-------------------------------------------------------------------------------
; StickLeft - The stick pushed left: RollInput = $08.
;-------------------------------------------------------------------------------
StickLeft:
        moveq   #$8,d2                          ; 00940
        bra.b   l_005_0094A                     ; 00942

;-------------------------------------------------------------------------------
; StickRight - The stick pushed right: RollInput = $04.
;-------------------------------------------------------------------------------
StickRight:
        moveq   #$4,d2                          ; 00944
        bra.b   l_005_0094A                     ; 00946

;-------------------------------------------------------------------------------
; StickRollCentre - The stick back in the middle (left/right): RollInput = 0.
;-------------------------------------------------------------------------------
StickRollCentre:
        moveq   #$0,d2                          ; 00948
l_005_0094A:
        move.b  d2,(RollInput).l                ; 0094A
        tst.b   (MapView).l                     ; 00950
        bne.b   l_005_00962                     ; 00956
        tst.b   (CameraFollows).l               ; 00958
        beq.w   l_005_00974                     ; 0095E
l_005_00962:
        move.b  (PlayerControls).l,d1           ; 00962
        andi.b  #$f3,d1                         ; 00968
        or.b    d2,d1                           ; 0096C
        move.b  d1,(PlayerControls).l           ; 0096E
l_005_00974:
        rts                                     ; 00974
Key_Comma:
        move.b  #$80,d2                         ; 00976
        bra.b   l_005_00984                     ; 0097A
Key_Period:
        move.b  #$40,d2                         ; 0097C
        bra.b   l_005_00984                     ; 00980
Key_CommaUp_PeriodUp:
        moveq   #$0,d2                          ; 00982
l_005_00984:
        move.b  (PlayerControls).l,d1           ; 00984
        andi.b  #$3f,d1                         ; 0098A
        or.b    d2,d1                           ; 0098E
        move.b  d1,(PlayerControls).l           ; 00990
        move.b  d2,(CommaPeriodInput).l         ; 00996
        bra.w   l_005_01624                     ; 0099C
Key_Equals:
        moveq   #$1,d2                          ; 009A0
        bra.b   l_005_009AA                     ; 009A2
Key_Minus:
        moveq   #$2,d2                          ; 009A4
        bra.b   l_005_009AA                     ; 009A6
Key_EqualsUp_MinusUp:
        moveq   #$0,d2                          ; 009A8
l_005_009AA:
        move.b  (PlayerControls).l,d1           ; 009AA
        andi.b  #$fc,d1                         ; 009B0
        or.b    d2,d1                           ; 009B4
        move.b  d1,(PlayerControls).l           ; 009B6
        bsr.w   ResetMouseThrottle              ; 009BC
        bra.w   l_005_01624                     ; 009C0
Key_Backslash_Backspace:
        bsr.w   ResetMouseThrottle              ; 009C4
        jsr     (KeyBeep).l                     ; 009C8
        bset    #$0,(ToggleKeys).l              ; 009CE
        move.b  #$3,(BackslashLampRedraw).l     ; 009D6
        eori.w  #$800,(ObjectTable).l           ; 009DE
        bra.w   l_005_01624                     ; 009E6

;-------------------------------------------------------------------------------
; ResetMouseThrottle - Clears GearState and the mouse's throttle positions (MouseY,
; ThrottleMouseY).
;-------------------------------------------------------------------------------
ResetMouseThrottle:
        clr.b   (GearState).l                   ; 009EA
        clr.w   (MouseY).l                      ; 009F0
        clr.w   (ThrottleMouseY).l              ; 009F6
        rts                                     ; 009FC
Key_A:
        bset    #$1,(JoyEvents).l               ; 009FE
        cmpi.b  #$11,(PlayerType).l             ; 00A06
        bne.w   l_005_01624                     ; 00A0E
        jsr     (KeyBeep).l                     ; 00A12
        eori.w  #$8000,(Player_02).l            ; 00A18
        bchg    #$7,(ModelVariant).l            ; 00A20
        move.b  #$3,(PanelLampRedraw).l         ; 00A28
        swap    d0                              ; 00A30
        btst    #$7,(Player_02).l               ; 00A32
        beq.b   l_005_00A40                     ; 00A3A
        move.w  #$4023,d0                       ; 00A3C
l_005_00A40:
        jsr     (StartWarning).l                ; 00A40
        swap    d0                              ; 00A46
        bra.w   l_005_01624                     ; 00A48
Key_KPEnter:
        move.b  #$2,(KeyPressed).l              ; 00A4C
l_005_00A54:
        tst.b   d6                              ; 00A54
        bne.b   l_005_00AAA                     ; 00A56
        bset    #$1,(ViewKeys).l                ; 00A58
        tst.b   d5                              ; 00A60
        bne.b   l_005_00A6C                     ; 00A62
        move.b  #$4,(ViewChoice).l              ; 00A64
l_005_00A6C:
        move.b  #$1,(NewView).l                 ; 00A6C
l_005_00A74:
        move.b  #$1,(CameraFollows).l           ; 00A74
        clr.b   (MapView).l                     ; 00A7C
l_005_00A82:
        lea.l   (ObjectTable).l,a0              ; 00A82
        move.w  (ViewObject).l,d4               ; 00A88
        move.w  $68(a0,d4.w),(ViewHeadingSaved).l ; 00A8E
        ori.w   #$2,(GunFlags).l                ; 00A96
        move.b  #$ff,(SavedOutsideView).l       ; 00A9E
        bra.w   l_005_01624                     ; 00AA6
l_005_00AAA:
        bset    #$2,(ViewKeys).l                ; 00AAA
        move.b  #$ff,(AnglesSet).l              ; 00AB2
        lea.l   (StartPoints).l,a0              ; 00ABA
        move.b  (StartPoint).l,d0               ; 00AC0
        ext.w   d0                              ; 00AC6
        asl.w   #$4,d0                          ; 00AC8
        move.w  d0,d1                           ; 00ACA
        adda.w  d0,a0                           ; 00ACC
        move.w  (a0),d0                         ; 00ACE
        bge.b   l_005_00B0A                     ; 00AD0
        andi.w  #$7fff,d0                       ; 00AD2
        asl.w   #$8,d0                          ; 00AD6
        add.w   d0,d0                           ; 00AD8
        lea.l   (ObjectTable).l,a1              ; 00ADA
        adda.w  d0,a1                           ; 00AE0
        cmpi.b  #$20,$62(a1)                    ; 00AE2
        bne.b   l_005_00AF8                     ; 00AE8
        move.w  #$ffdc,d3                       ; 00AEA
        move.w  #$2f,d4                         ; 00AEE
        move.w  #$ffd0,d5                       ; 00AF2
        bra.b   l_005_00B02                     ; 00AF6
l_005_00AF8:
        moveq   #$0,d3                          ; 00AF8
        move.w  #$14,d4                         ; 00AFA
        move.w  #$ff96,d5                       ; 00AFE
l_005_00B02:
        jsr     (TurnByObject).l                ; 00B02
        bra.b   l_005_00B44                     ; 00B08
l_005_00B0A:
        lea.l   (ViewPoints).l,a0               ; 00B0A
        adda.w  d1,a0                           ; 00B10
        movem.w (a0),d0-d5                      ; 00B12
        swap    d0                              ; 00B16
        asl.l   #$6,d0                          ; 00B18
        swap    d1                              ; 00B1A
        asl.l   #$6,d1                          ; 00B1C
        add.w   d2,d2                           ; 00B1E
        add.w   d2,d2                           ; 00B20
        lea.l   (SubCellOffsets).l,a4                   ; 00B22
        movem.w (a4,d2.w),d6-d7                 ; 00B28
        asl.l   #$8,d6                          ; 00B2E
        asl.l   #$8,d7                          ; 00B30
        add.l   d6,d0                           ; 00B32
        add.l   d7,d1                           ; 00B34
        asl.l   #$8,d4                          ; 00B36
        asl.l   #$8,d5                          ; 00B38
        add.l   d4,d0                           ; 00B3A
        add.l   d5,d1                           ; 00B3C
        asl.l   #$8,d3                          ; 00B3E
        move.l  d1,d2                           ; 00B40
        move.l  d3,d1                           ; 00B42
l_005_00B44:
        jsr     (SetCameraAt).l                 ; 00B44
        clr.b   (NewView).l                     ; 00B4A
        tst.b   (OutsideView).l                 ; 00B50
        beq.w   l_005_00A74                     ; 00B56
        clr.b   (AnglesSet).l                   ; 00B5A
        bra.w   l_005_01624                     ; 00B60
l_005_00B64:
        moveq   #$0,d4                          ; 00B64
        bra.b   l_005_00BB4                     ; 00B66
Key_KP9:
        bset    #$5,(ViewKeys).l                ; 00B68
        tst.b   (OutsideView).l                 ; 00B70
        beq.w   BackToCockpitView               ; 00B76
        moveq   #$1,d4                          ; 00B7A
        bra.b   l_005_00BB4                     ; 00B7C
l_005_00B7E:
        moveq   #$2,d4                          ; 00B7E
        bra.b   l_005_00BB4                     ; 00B80
Key_KP3:
        bset    #$7,(ViewKeys).l                ; 00B82
        moveq   #$3,d4                          ; 00B8A
        bra.b   l_005_00BB4                     ; 00B8C

;-------------------------------------------------------------------------------
; OutsideViewKind - Picks an outside view (4, 5 or 6) for the keypad keys.
;-------------------------------------------------------------------------------
OutsideViewKind:
        moveq   #$4,d4                          ; 00B8E
        bra.b   l_005_00BB4                     ; 00B90
l_005_00B92:
        moveq   #$5,d4                          ; 00B92
        bra.b   l_005_00BB4                     ; 00B94
l_005_00B96:
        moveq   #$6,d4                          ; 00B96
        bra.b   l_005_00BB4                     ; 00B98
l_005_00B9A:
        moveq   #$7,d4                          ; 00B9A
        bra.b   l_005_00BB4                     ; 00B9C
l_005_00B9E:
        bset    #$4,(ViewKeys2).l               ; 00B9E
        moveq   #$8,d4                          ; 00BA6
        bra.b   l_005_00BB4                     ; 00BA8
Key_KPDot:
        bset    #$5,(ViewKeys2).l               ; 00BAA
        moveq   #$9,d4                          ; 00BB2
l_005_00BB4:
        move.b  d4,(ViewChoice).l               ; 00BB4
        move.b  #$ff,(RedrawFlags).l            ; 00BBA
        tst.b   (EngineSoundRequest).l          ; 00BC2
        bne.w   l_005_01624                     ; 00BC8
        move.b  #$ff,(EngineSoundRequest).l     ; 00BCC
        bra.w   l_005_01624                     ; 00BD4
l_005_00BD8:
        tst.b   (OutsideView).l                 ; 00BD8
        bne.b   l_005_00BF2                     ; 00BDE
Key_KP5:
        move.b  (OutsideView).l,d4              ; 00BE0
        bne.b   l_005_00B9E                     ; 00BE6
        bset    #$3,(ViewKeys).l                ; 00BE8
        bra.b   l_005_00C6C                     ; 00BF0
l_005_00BF2:
        move.b  (OutsideView).l,d4              ; 00BF2
        beq.w   l_005_01624                     ; 00BF8
        tst.b   (CameraSequence).l              ; 00BFC
        bne.w   l_005_01624                     ; 00C02
        bset    #$3,(ViewKeys).l                ; 00C06
        tst.b   (MapView).l                     ; 00C0E
        beq.b   l_005_00C42                     ; 00C14
        move.l  (CameraY).l,d1                  ; 00C16
        subi.l  #$2000000,d1                    ; 00C1C
        cmpi.l  #$1000000,d1                    ; 00C22
        bge.b   l_005_00C30                     ; 00C28
        move.l  #$1000000,d1                    ; 00C2A
l_005_00C30:
        move.l  d1,(CameraY).l                  ; 00C30
        move.b  #$ff,(RedrawFlags).l            ; 00C36
        bra.w   l_005_01624                     ; 00C3E
l_005_00C42:
        subq.b  #$1,d4                          ; 00C42
        bgt.b   l_005_00C48                     ; 00C44
        moveq   #-1,d4                          ; 00C46
l_005_00C48:
        move.b  d4,(OutsideView).l              ; 00C48
        move.b  #$ff,(RedrawFlags).l            ; 00C4E
        tst.b   (EngineSoundRequest).l          ; 00C56
        bne.w   l_005_01624                     ; 00C5C
        move.b  #$ff,(EngineSoundRequest).l     ; 00C60
        bra.w   l_005_01624                     ; 00C68
l_005_00C6C:
        move.b  #$ff,(ViewKeyRepeat).l          ; 00C6C
        bra.w   l_005_01624                     ; 00C74
l_005_00C78:
        bset    #$7,(ViewKeys2).l               ; 00C78
        move.b  (OutsideView).l,d4              ; 00C80
        beq.w   l_005_01624                     ; 00C86
        tst.b   (CameraSequence).l              ; 00C8A
        bne.w   l_005_01624                     ; 00C90
        tst.b   (MapView).l                     ; 00C94
        beq.b   l_005_00CC8                     ; 00C9A
        move.l  (CameraY).l,d1                  ; 00C9C
        addi.l  #$2000000,d1                    ; 00CA2
        cmpi.l  #$8000000,d1                    ; 00CA8
        ble.b   l_005_00CB6                     ; 00CAE
        move.l  #$8000000,d1                    ; 00CB0
l_005_00CB6:
        move.l  d1,(CameraY).l                  ; 00CB6
        move.b  #$ff,(RedrawFlags).l            ; 00CBC
        bra.w   l_005_01624                     ; 00CC4
l_005_00CC8:
        addq.b  #$1,d4                          ; 00CC8
        beq.b   l_005_00CDA                     ; 00CCA
        cmpi.b  #$4,d4                          ; 00CCC
        blt.w   l_005_00C48                     ; 00CD0
        moveq   #$4,d4                          ; 00CD4
        bra.w   l_005_00C48                     ; 00CD6
l_005_00CDA:
        moveq   #$1,d4                          ; 00CDA
        bra.w   l_005_00C48                     ; 00CDC
Key_KP8:
        bset    #$4,(ViewKeys).l                ; 00CE0
        tst.b   d5                              ; 00CE8
        bne.w   l_005_00B64                     ; 00CEA

;-------------------------------------------------------------------------------
; BackToCockpitView - Back to the cockpit's view (ZoomKeyHeld cleared).
;-------------------------------------------------------------------------------
BackToCockpitView:
        clr.b   d7                              ; 00CEE
        move.b  #$0,(ZoomKeyHeld).l             ; 00CF0
        bra.w   l_005_00DB4                     ; 00CF8
Key_KP2:
        bset    #$0,(ViewKeys2).l               ; 00CFC
        tst.b   d5                              ; 00D04
        bne.w   OutsideViewKind                 ; 00D06
        moveq   #$6,d7                          ; 00D0A
        move.b  #$0,(ZoomKeyHeld).l             ; 00D0C
        bra.w   l_005_00DB4                     ; 00D14
Key_KP4:
        bset    #$2,(ViewKeys2).l               ; 00D18
        tst.b   d5                              ; 00D20
        bne.w   l_005_00B96                     ; 00D22
        move.b  #$0,(ZoomKeyHeld).l             ; 00D26
        subq.b  #$1,(ViewZoom).l                ; 00D2E
        blt.b   l_005_00D44                     ; 00D34
        beq.b   BackToCockpitView               ; 00D36
        cmpi.b  #$b,(ViewZoom).l                ; 00D38
        bge.b   BackToCockpitView               ; 00D40
        bra.b   l_005_00DC2                     ; 00D42
l_005_00D44:
        moveq   #$b,d7                          ; 00D44
        bra.b   l_005_00DB4                     ; 00D46
Key_KP6:
        bset    #$6,(ViewKeys).l                ; 00D48
        tst.b   d5                              ; 00D50
        bne.w   l_005_00B7E                     ; 00D52
        move.b  #$0,(ZoomKeyHeld).l             ; 00D56
        addq.b  #$1,(ViewZoom).l                ; 00D5E
        cmpi.b  #$b,(ViewZoom).l                ; 00D64
        ble.b   l_005_00DC2                     ; 00D6C
        bra.w   BackToCockpitView               ; 00D6E
Key_KP7:
        bset    #$3,(ViewKeys2).l               ; 00D72
        tst.b   d5                              ; 00D7A
        bne.w   l_005_00B9A                     ; 00D7C
        moveq   #$c,d7                          ; 00D80
        move.b  #$0,(ZoomKeyHeld).l             ; 00D82
        move.b  #$ff,(RedrawFlags).l            ; 00D8A
        bra.b   l_005_00DB4                     ; 00D92
Key_KP1:
        bset    #$1,(ViewKeys2).l               ; 00D94
        tst.b   d5                              ; 00D9C
        bne.w   l_005_00B92                     ; 00D9E
        moveq   #$d,d7                          ; 00DA2
        move.b  #$0,(ZoomKeyHeld).l             ; 00DA4
        move.b  #$ff,(RedrawFlags).l            ; 00DAC
l_005_00DB4:
        move.b  d7,(ViewZoom).l                 ; 00DB4
        move.b  #$3,(PanelBlitCount).l          ; 00DBA
l_005_00DC2:
        jsr     (StartGunSound).l               ; 00DC2
        move.w  #$ffff,(TargetScreenPos).l      ; 00DC8
        move.b  #$ff,(RedrawFlags).l            ; 00DD0
        move.b  #$0,(ViewKeyFlag).l             ; 00DD8
        move.b  #$ff,(ViewKeyRepeat).l          ; 00DE0
        lea.l   (ObjectTable).l,a0              ; 00DE8
        adda.w  (ViewObject).l,a0               ; 00DEE
        move.b  $62(a0),d4                      ; 00DF4
        andi.b  #$f0,d4                         ; 00DF8
        cmpi.b  #$30,d4                         ; 00DFC
        beq.w   l_005_01624                     ; 00E00
        move.b  (ViewZoom).l,d4                 ; 00E04
        cmpi.b  #$3,d4                          ; 00E0A
        blt.b   l_005_00E4C                     ; 00E0E
        cmpi.b  #$9,d4                          ; 00E10
        ble.b   l_005_00E1C                     ; 00E14
        cmpi.b  #$c,d4                          ; 00E16
        blt.b   l_005_00E4C                     ; 00E1A
l_005_00E1C:
        move.w  #$b3,d7                         ; 00E1C
        cmpi.b  #$5,d4                          ; 00E20
        blt.b   l_005_00E2C                     ; 00E24
        cmpi.b  #$7,d4                          ; 00E26
        ble.b   l_005_00E30                     ; 00E2A
l_005_00E2C:
        move.w  #$a7,d7                         ; 00E2C
l_005_00E30:
        cmp.w   (ClipY).l,d7                    ; 00E30
        bne.b   l_005_00E4C                     ; 00E36
        move.w  #$32,(ViewShift).l              ; 00E38
        move.w  #$320,(ViewX).l                 ; 00E40
        bra.w   l_005_01624                     ; 00E48
l_005_00E4C:
        lea.l   (Key_KP1Data1).l,a0             ; 00E4C
        move.b  (ViewZoom).l,d4                 ; 00E52
        ext.w   d4                              ; 00E58
        move.b  (a0,d4.w),d4                    ; 00E5A
        ext.w   d4                              ; 00E5E
        move.w  d4,(ViewShift).l                ; 00E60
        asl.w   #$4,d4                          ; 00E66
        move.w  d4,(ViewX).l                    ; 00E68

;-------------------------------------------------------------------------------
; ApplyViewZoom - Redraws the instruments and sets up the view for ViewZoom (the panel shown or
; not, ClipY).
;-------------------------------------------------------------------------------
ApplyViewZoom:
        jsr     (RedrawInstruments).l           ; 00E6E
        move.b  (ViewZoom).l,d4                 ; 00E74
        cmpi.b  #$3,d4                          ; 00E7A
        blt.b   l_005_00E8C                     ; 00E7E
        cmpi.b  #$9,d4                          ; 00E80
        ble.b   l_005_00E98                     ; 00E84
        cmpi.b  #$c,d4                          ; 00E86
        bge.b   l_005_00E98                     ; 00E8A
l_005_00E8C:
        move.w  #$90,(ClipY).l                  ; 00E8C
        bra.w   l_005_01624                     ; 00E94
l_005_00E98:
        cmpi.b  #$4,d4                          ; 00E98
        ble.b   l_005_00EB0                     ; 00E9C
        cmpi.b  #$8,d4                          ; 00E9E
        bge.b   l_005_00EB0                     ; 00EA2
        move.w  #$b3,(ClipY).l                  ; 00EA4
        bra.w   l_005_01624                     ; 00EAC
l_005_00EB0:
        move.w  #$a7,(ClipY).l                  ; 00EB0
        bra.w   l_005_01624                     ; 00EB8
; Key_KP1Data1 - Data used by Key_KP1.
Key_KP1Data1:
	dc.b	$00,$F9,$F2,$EB,$CE,$32,$32,$32,$32,$15,$0E,$07,$32,$32
Key_RBracket:
        moveq   #$20,d3                         ; 00ECA
        tst.b   d5                              ; 00ECC
        beq.b   l_005_00EDA                     ; 00ECE
        tst.b   (NewView).l                     ; 00ED0
        bne.w   l_005_00BF2                     ; 00ED6
l_005_00EDA:
        cmp.w   (RadarScale).l,d3               ; 00EDA
        bge.b   l_005_00F08                     ; 00EE0
        asr.w   (RadarScale).l                  ; 00EE2
        bra.b   l_005_00F08                     ; 00EE8
Key_LBracket:
        tst.b   d5                              ; 00EEA
        beq.b   l_005_00EF8                     ; 00EEC
        tst.b   (NewView).l                     ; 00EEE
        bne.w   l_005_00C78                     ; 00EF4
l_005_00EF8:
        cmpi.w  #$80,(RadarScale).l             ; 00EF8
        bge.b   l_005_00F08                     ; 00F00
        asl.w   (RadarScale).l                  ; 00F02
l_005_00F08:
        move.b  #$3,(RadarRangeRedraw).l        ; 00F08
        move.b  #$ff,(ViewKeyRepeat).l          ; 00F10
        move.b  (GroundDetail).l,d4             ; 00F18
        andi.b  #$7f,d4                         ; 00F1E
        bne.b   l_005_00F2C                     ; 00F22
        move.b  #$ff,(RedrawFlags).l            ; 00F24
l_005_00F2C:
        cmpi.w  #$80,(RadarScale).l             ; 00F2C
        beq.b   l_005_00F42                     ; 00F34
        bclr    #$7,(GroundDetail).l            ; 00F36
        bra.w   l_005_01624                     ; 00F3E
l_005_00F42:
        bset    #$7,(GroundDetail).l            ; 00F42
        bra.w   l_005_01624                     ; 00F4A
Key_KP2Up_KP4Up_KP6Up:
        bset    #$6,(ViewKeys2).l               ; 00F4E
        move.b  #$5,(ViewKeyRepeat).l           ; 00F56
        bra.w   l_005_01624                     ; 00F5E
Key_Return:
        cmpi.b  #$2,(GameMode).l                ; 00F62
        beq.b   l_005_00F7E                     ; 00F6A
        cmpi.b  #$7d,(GameMode).l               ; 00F6C
        bne.b   l_005_00FA2                     ; 00F74
        tst.b   (TrainingWaitKey).l             ; 00F76
        bge.b   l_005_00F90                     ; 00F7C
l_005_00F7E:
        jsr     (KeyBeep).l                     ; 00F7E
        bset    #$3,(Player_02).l               ; 00F84
        bra.w   l_005_01624                     ; 00F8C
l_005_00F90:
        swap    d0                              ; 00F90
        move.w  #$401f,d0                       ; 00F92
        jsr     (StartWarning).l                ; 00F96
        swap    d0                              ; 00F9C
        bra.w   l_005_01624                     ; 00F9E
l_005_00FA2:
        jsr     (KeyBeep).l                     ; 00FA2
        move.b  (PlayerEjection).l,d4           ; 00FA8
        andi.b  #$f,d4                          ; 00FAE
        bne.w   l_005_01624                     ; 00FB2
        bset    #$4,(JoyEvents).l               ; 00FB6
        move.b  (PlayerWeapon).l,d4             ; 00FBE
        andi.b  #$f0,d4                         ; 00FC4
        subi.b  #$10,d4                         ; 00FC8
        bge.b   l_005_00FD2                     ; 00FCC
        move.b  #$30,d4                         ; 00FCE
l_005_00FD2:
        andi.b  #$f,(PlayerWeapon).l            ; 00FD2
        or.b    d4,(PlayerWeapon).l             ; 00FDA
        move.b  #$3,(StoresRedraw).l            ; 00FE0
        move.b  #$3,(MissilesLeftRedraw).l      ; 00FE8
        clr.b   (ShootCue).l                    ; 00FF0
        bra.w   l_005_01624                     ; 00FF6
Key_G:
        bset    #$0,(JoyEvents).l               ; 00FFA
        btst    #$7,(Player_03).l               ; 01002
        bne.b   l_005_0102E                     ; 0100A
        bchg    #$7,(PlayerEjection).l          ; 0100C
        move.l  (GKeyValue).l,d4                ; 01014
        andi.l  #$40,d4                         ; 0101A
        beq.b   l_005_0102E                     ; 01020
        move.b  #$83,(GearSoundCount).l         ; 01022
        bra.w   l_005_01624                     ; 0102A
l_005_0102E:
        jsr     (KeyBeep).l                     ; 0102E
        bra.w   l_005_01624                     ; 01034
l_005_01038:
        cmpi.w  #$59,d0                         ; 01038
        bgt.b   l_005_010B6                     ; 0103C
        tst.b   (GameMode).l                    ; 0103E
        beq.b   l_005_0104E                     ; 01044
        tst.b   (LeftAmigaDown).l               ; 01046
        beq.b   l_005_010B6                     ; 0104C
l_005_0104E:
        move.w  d0,d4                           ; 0104E
        subi.w  #$50,d4                         ; 01050
        addi.w  #$a,d4                          ; 01054
        bra.b   l_005_01060                     ; 01058
l_005_0105A:
        move.w  d0,d4                           ; 0105A
        subi.w  #$1,d4                          ; 0105C
l_005_01060:
        tst.b   (AircraftChosen).l              ; 01060
        beq.b   l_005_01090                     ; 01066
        cmpi.w  #$0,d4                          ; 01068
        blt.b   l_005_0108C                     ; 0106C
        cmpi.w  #$1,d4                          ; 0106E
        bgt.b   l_005_0108C                     ; 01072
        beq.b   l_005_0107C                     ; 01074
        move.b  #$11,d4                         ; 01076
        bra.b   l_005_01080                     ; 0107A
l_005_0107C:
        move.b  #$10,d4                         ; 0107C
l_005_01080:
        move.b  d4,(PlayerAircraftType).l       ; 01080
        clr.b   (AircraftChosen).l              ; 01086
l_005_0108C:
        bra.w   l_005_01624                     ; 0108C
l_005_01090:
        tst.b   (TextInputOn).l                 ; 01090
        bne.w   l_005_01160                     ; 01096
        cmpi.w  #$0,d4                          ; 0109A
        blt.w   l_005_01624                     ; 0109E
        cmpi.w  #$8,d4                          ; 010A2
        bgt.w   l_005_01624                     ; 010A6
        addq.w  #$1,d4                          ; 010AA
        move.b  d4,(TextInputOn).l              ; 010AC
        bra.w   l_005_01624                     ; 010B2
l_005_010B6:
        move.b  (RecordMode).l,d2               ; 010B6
        bgt.b   l_005_010C4                     ; 010BC
        tst.b   d6                              ; 010BE
        beq.b   l_005_010C8                     ; 010C0
        bra.b   l_005_010C8                     ; 010C2
l_005_010C4:
        bra.w   l_005_01624                     ; 010C4
l_005_010C8:
        cmpi.b  #$fd,d2                         ; 010C8
        beq.b   l_005_010D6                     ; 010CC
        tst.b   d2                              ; 010CE
        beq.b   l_005_010E2                     ; 010D0
        bra.w   l_005_01624                     ; 010D2
l_005_010D6:
        subi.w  #$50,d4                         ; 010D6
        addi.w  #$b,d4                          ; 010DA
        bra.w   l_005_012C2                     ; 010DE
l_005_010E2:
        tst.b   (WorldFrozen).l                 ; 010E2
        bne.w   l_005_01624                     ; 010E8
        move.w  d0,d4                           ; 010EC
        subi.w  #$4f,d4                         ; 010EE
        cmpi.w  #$1,d4                          ; 010F2
        bne.b   l_005_01120                     ; 010F6
        tst.b   (GearState).l                   ; 010F8
        bne.b   l_005_0110A                     ; 010FE
        cmpi.b  #$c,(PlayerThrottle).l          ; 01100
        beq.b   l_005_01114                     ; 01108
l_005_0110A:
        cmpi.b  #$c,(GearState).l               ; 0110A
        bne.b   l_005_01120                     ; 01112
l_005_01114:
        move.b  #$ff,(GearState).l              ; 01114
        bra.w   l_005_01624                     ; 0111C
l_005_01120:
        add.b   d4,d4                           ; 01120
        move.b  d4,d5                           ; 01122
        add.b   d4,d4                           ; 01124
        add.b   d5,d4                           ; 01126
        add.b   d4,d4                           ; 01128
        cmpi.b  #$78,d4                         ; 0112A
        blt.b   l_005_01132                     ; 0112E
        addq.b  #$1,d4                          ; 01130
l_005_01132:
        move.b  d4,(GearState).l                ; 01132
        tst.b   (MouseActive).l                 ; 01138
        beq.w   l_005_01624                     ; 0113E
        ext.w   d4                              ; 01142
        asl.w   #$3,d4                          ; 01144
        cmpi.w  #$3c0,d4                        ; 01146
        ble.b   l_005_01150                     ; 0114A
        move.w  #$3c0,d4                        ; 0114C
l_005_01150:
        move.w  d4,(MouseY).l                   ; 01150
        move.w  d4,(ThrottleMouseY).l           ; 01156
        bra.w   l_005_01624                     ; 0115C
l_005_01160:
        tst.b   (GameMode).l                    ; 01160
        bne.w   l_005_01248                     ; 01166
        cmpi.b  #$0,d4                          ; 0116A
        blt.w   l_005_01624                     ; 0116E
        tst.b   d4                              ; 01172
        beq.w   l_005_01232                     ; 01174
        cmpi.b  #$1,d4                          ; 01178
        beq.b   l_005_011E4                     ; 0117C
        cmpi.b  #$2,d4                          ; 0117E
        beq.b   l_005_011D4                     ; 01182
        cmpi.b  #$3,d4                          ; 01184
        beq.w   l_005_0122A                     ; 01188
        cmpi.b  #$4,d4                          ; 0118C
        beq.w   l_005_0122E                     ; 01190
        cmpi.b  #$5,d4                          ; 01194
        beq.w   l_005_01226                     ; 01198
        cmpi.b  #$7,d4                          ; 0119C
        beq.w   l_005_01222                     ; 011A0
        movea.l (ConfigBuffer).l,a0             ; 011A4
        tst.w   $0(a0)                          ; 011AA
        bne.b   l_005_011B2                     ; 011AE
        bra.b   l_005_011DA                     ; 011B0
l_005_011B2:
        cmpi.b  #$6,d4                          ; 011B2
        bne.b   l_005_011F2                     ; 011B6
        move.b  #$1,(MenuOption).l              ; 011B8
        move.b  $6(a0),d4                       ; 011C0
        addq.b  #$1,d4                          ; 011C4
        cmpi.b  #$3,d4                          ; 011C6
        blt.b   l_005_011D2                     ; 011CA
        cmpi.b  #$8,d4                          ; 011CC
        ble.b   l_005_011D4                     ; 011D0
l_005_011D2:
        moveq   #$3,d4                          ; 011D2
l_005_011D4:
        move.b  d4,(GameMode).l                 ; 011D4
l_005_011DA:
        jsr     (MenuBeep).l                    ; 011DA
        bra.w   l_005_01624                     ; 011E0
l_005_011E4:
        tst.b   d6                              ; 011E4
        beq.b   l_005_011D4                     ; 011E6
        move.b  #$2,(MenuOption).l              ; 011E8
        bra.b   l_005_011D4                     ; 011F0
l_005_011F2:
        subi.b  #$a,d4                          ; 011F2
        cmpi.b  #$0,d4                          ; 011F6
        blt.w   l_005_01624                     ; 011FA
        cmpi.b  #$5,d4                          ; 011FE
        bgt.b   l_005_0121E                     ; 01202
        addq.b  #$1,d4                          ; 01204
        addq.b  #$2,d4                          ; 01206
        cmpi.b  #$3,d4                          ; 01208
        beq.b   l_005_011D4                     ; 0120C
        lea.l   $12(a0),a0                      ; 0120E
        ext.w   d4                              ; 01212
        tst.b   -$1(a0,d4.w)                    ; 01214
        beq.w   l_005_01624                     ; 01218
        bra.b   l_005_011D4                     ; 0121C
l_005_0121E:
        bra.w   l_005_01624                     ; 0121E
l_005_01222:
        moveq   #-2,d4                          ; 01222
        bra.b   l_005_011D4                     ; 01224
l_005_01226:
        moveq   #-1,d4                          ; 01226
        bra.b   l_005_011D4                     ; 01228
l_005_0122A:
        moveq   #$7d,d4                         ; 0122A
        bra.b   l_005_011D4                     ; 0122C
l_005_0122E:
        moveq   #$9,d4                          ; 0122E
        bra.b   l_005_011D4                     ; 01230
l_005_01232:
        move.b  #$1,(MenuOption).l              ; 01232
        tst.l   (ReplayPointer).l               ; 0123A
        beq.w   l_005_01624                     ; 01240
        moveq   #$7f,d4                         ; 01244
        bra.b   l_005_011D4                     ; 01246
l_005_01248:
        btst    #$3,(StatusBits).l              ; 01248
        bne.b   l_005_012B0                     ; 01250
        lea.l   (StartPoints).l,a0              ; 01252
        move.b  d4,d1                           ; 01258
        ext.w   d1                              ; 0125A
        asl.w   #$4,d1                          ; 0125C
        clr.w   d2                              ; 0125E
l_005_01260:
        move.w  (a0,d2.w),d3                    ; 01260
        blt.b   l_005_01270                     ; 01264
        cmp.w   d2,d1                           ; 01266
        ble.b   l_005_01276                     ; 01268
        addi.w  #$10,d2                         ; 0126A
        bra.b   l_005_01260                     ; 0126E
l_005_01270:
        addq.w  #$1,d3                          ; 01270
        beq.w   l_005_01624                     ; 01272
l_005_01276:
        move.b  d4,(StartPoint).l               ; 01276
        tst.b   (CameraSequence).l              ; 0127C
        blt.w   l_005_01624                     ; 01282
        tst.b   (KeyMode).l                     ; 01286
        bne.w   l_005_01624                     ; 0128C
        lea.l   (NewView).l,a0                  ; 01290
        bra.w   ToggleByte                      ; 01296

;-------------------------------------------------------------------------------
; ViewKeyCommon - The common end of the view keys (KeyPressed -1, then the outside or the
; cockpit).
;-------------------------------------------------------------------------------
ViewKeyCommon:
        move.b  #$ff,(KeyPressed).l             ; 0129A
        tst.b   (OutsideView).l                 ; 012A2
        bne.w   l_005_00A6C                     ; 012A8
        bra.w   l_005_01624                     ; 012AC
l_005_012B0:
        move.b  (RecordMode).l,d2               ; 012B0
        beq.w   l_005_012C6                     ; 012B6
        cmpi.b  #$2,d2                          ; 012BA
        beq.w   l_005_012C6                     ; 012BE
l_005_012C2:
        bra.w   l_005_01624                     ; 012C2
l_005_012C6:
        addq.w  #$1,d4                          ; 012C6
        bra.b   l_005_012CC                     ; 012C8
	dc.b	$42,$44
l_005_012CC:
        bra.w   l_005_01624                     ; 012CC

;-------------------------------------------------------------------------------
; ViewFollow - ViewFollow(d1 = object): the outside view follows that object (ViewObject).
;-------------------------------------------------------------------------------
ViewFollow:
        move.b  #$ff,(RedrawFlags).l            ; 012D0
        move.w  #$ffff,(SeekerPos).l            ; 012D8
        move.b  #$fe,(EngineSoundRequest).l     ; 012E0
        move.w  d1,(ViewObjectIndex).l          ; 012E8
        asl.w   #$8,d1                          ; 012EE
        add.w   d1,d1                           ; 012F0
        move.w  d1,(ViewObject).l               ; 012F2
        jsr     (StartGunSound).l               ; 012F8
        tst.b   (OutsideView).l                 ; 012FE
        beq.b   l_005_0131C                     ; 01304
        move.b  (SavedOutsideView).l,(OutsideView).l ; 01306
        move.b  #$3,(PanelBlitCount).l          ; 01310
        bra.w   l_005_01624                     ; 01318
l_005_0131C:
        lea.l   (ObjectTable).l,a0              ; 0131C
        move.w  $68(a0,d1.w),(ViewHeadingSaved).l ; 01322
        move.b  $62(a0,d1.w),d4                 ; 0132A
        andi.b  #$f0,d4                         ; 0132E
        cmpi.b  #$30,d4                         ; 01332
        bne.w   BackToCockpitView               ; 01336
        move.w  #$32,(ViewShift).l              ; 0133A
        move.w  #$320,(ViewX).l                 ; 01342
        clr.b   (ViewZoom).l                    ; 0134A
        bsr.w   ApplyViewZoom                   ; 01350
        move.w  #$a7,(ClipY).l                  ; 01354
        bra.w   l_005_01624                     ; 0135C
	dc.b	$02,$70,$FF,$BF,$40,$00,$60,$00,$02,$BC,$4E,$B9
        dc.l    RearmAircraft                   ; 0136C
	dc.b	$60,$00,$02,$B2
Key_M:
        tst.b   (CameraSequence).l              ; 01374
        bne.w   l_005_01624                     ; 0137A
        bset    #$0,(ViewKeys).l                ; 0137E
        tst.b   (MapView).l                     ; 01386
        beq.b   l_005_0139C                     ; 0138C
        move.l  (CameraY).l,(MapViewHeight).l   ; 0138E
        bra.w   l_005_00A6C                     ; 01398
l_005_0139C:
        move.w  d0,-(a7)                        ; 0139C
        jsr     (StopAllSounds).l               ; 0139E
        move.w  (a7)+,d0                        ; 013A4
        move.l  #$10c00000,d4                   ; 013A6
        move.l  (MapViewHeight).l,d1            ; 013AC
        move.l  #$11400000,d2                   ; 013B2
        move.l  d4,(CameraX).l                  ; 013B8
        move.l  d1,(CameraY).l                  ; 013BE
        move.l  d2,(CameraZ).l                  ; 013C4
        andi.l  #$3fffff,d4                     ; 013CA
        andi.l  #$3fffff,d2                     ; 013D0
        neg.l   d4                              ; 013D6
        neg.l   d1                              ; 013D8
        neg.l   d2                              ; 013DA
        move.l  d4,(CameraCellOffset).l         ; 013DC
        move.l  d1,(CameraCellOffsetY).l        ; 013E2
        move.l  d2,(CameraCellOffsetZ).l        ; 013E8
        clr.l   (CameraVelocity).l              ; 013EE
        clr.l   (CameraVelocityY).l             ; 013F4
        clr.l   (CameraVelocityZ).l             ; 013FA
        move.w  #$1c20,(OutsideCamPitch).l      ; 01400
        clr.w   (OutsideCamHeading).l           ; 01408
        clr.b   (CameraFollows).l               ; 0140E
        move.b  #$1,(NewView).l                 ; 01414
        move.b  #$1,(MapView).l                 ; 0141C
        tst.b   (OutsideView).l                 ; 01424
        beq.w   l_005_00A82                     ; 0142A
        move.w  #$b3,(ClipY).l                  ; 0142E
        bra.w   l_005_01624                     ; 01436
Key_S:
        cmpi.b  #$7d,(GameMode).l               ; 0143A
        bne.b   l_005_01452                     ; 01442
        jsr     (KeyBeep).l                     ; 01444
        eori.w  #$1000,(Object4_02).l           ; 0144A
l_005_01452:
        bra.w   l_005_01624                     ; 01452
Key_P:
        tst.b   (CameraSequence).l              ; 01456
        blt.w   l_005_01624                     ; 0145C
        tst.b   (WorldFrozen).l                 ; 01460
        beq.b   l_005_0147A                     ; 01466
        move.b  #$fe,(EngineSoundRequest).l     ; 01468
        lea.l   (WorldFrozen).l,a0              ; 01470
        bra.w   ToggleByte                      ; 01476
l_005_0147A:
        move.w  d0,-(a7)                        ; 0147A
        jsr     (StopAllSounds).l               ; 0147C
        move.w  (a7)+,d0                        ; 01482
        tst.b   (RecordMode).l                  ; 01484
        bne.b   l_005_014A8                     ; 0148A
        move.l  (RecordPointer).l,d3            ; 0148C
        ble.b   l_005_014A8                     ; 01492
        tst.b   (DemoActive).l                  ; 01494
        beq.b   l_005_014A8                     ; 0149A
        movea.l d3,a0                           ; 0149C
        moveq   #-1,d3                          ; 0149E
        move.b  d3,(a0)+                        ; 014A0
        move.b  d3,(a0)+                        ; 014A2
        move.b  d3,(a0)+                        ; 014A4
        move.b  d3,(a0)+                        ; 014A6
l_005_014A8:
        move.b  #$ff,(WorldFrozen).l            ; 014A8
        bra.w   l_005_01624                     ; 014B0

;-------------------------------------------------------------------------------
; FreezeWorld - Stops the world (WorldFrozen) and rounds FrameCount down to a multiple of 8.
;-------------------------------------------------------------------------------
FreezeWorld:
        move.b  #$1,(WorldFrozen).l             ; 014B4
        andi.w  #$fff8,(FrameCount).l           ; 014BC
        bra.w   l_005_01624                     ; 014C4
Key_F:
        tst.b   d6                              ; 014C8
        bne.b   l_005_0150A                     ; 014CA
        bset    #$1,(ToggleKeys).l              ; 014CC
        subq.b  #$1,(FlaresLeft).l              ; 014D4
        ble.b   l_005_014F4                     ; 014DA
        move.b  #$1e,(FlareTime).l              ; 014DC
        move.w  d0,d4                           ; 014E4
        move.w  #$4026,d0                       ; 014E6
        move.b  #$2,(CountermeasureSound).l     ; 014EA
        bra.b   l_005_014FE                     ; 014F2
l_005_014F4:
        clr.b   (FlaresLeft).l                  ; 014F4
        move.w  #$4027,d0                       ; 014FA
l_005_014FE:
        jsr     (StartWarning).l                ; 014FE
        move.w  d4,d0                           ; 01504
        bra.w   l_005_01624                     ; 01506
l_005_0150A:
        cmpi.b  #$6,(GameMode).l                ; 0150A
        bne.b   l_005_01556                     ; 01512
        tst.w   (RescuePod).l                   ; 01514
        bne.b   l_005_01556                     ; 0151A
        btst    #$6,(Object1_01).l              ; 0151C
        beq.b   l_005_0153A                     ; 01524
        btst    #$6,(Object2_01).l              ; 01526
        beq.b   l_005_0153A                     ; 0152E
        btst    #$6,(Object3_01).l              ; 01530
        bne.b   l_005_01556                     ; 01538
l_005_0153A:
        ori.b   #$f,(PlayerEjection).l          ; 0153A
        move.w  d0,-(a7)                        ; 01542
        moveq   #$30,d0                         ; 01544
        move.l  d0,-(a7)                        ; 01546
        moveq   #$1c,d0                         ; 01548
        move.l  d0,-(a7)                        ; 0154A
        jsr     (PlaySweep).l                   ; 0154C
        addq.l  #$8,a7                          ; 01552
        move.w  (a7)+,d0                        ; 01554
l_005_01556:
        bra.w   l_005_01624                     ; 01556
Key_C:
        bset    #$2,(ToggleKeys).l              ; 0155A
        subq.b  #$1,(ChaffLeft).l               ; 01562
        ble.b   l_005_01582                     ; 01568
        move.b  #$1e,(ChaffTime).l              ; 0156A
        move.w  d0,d4                           ; 01572
        move.w  #$4028,d0                       ; 01574
        move.b  #$1,(CountermeasureSound).l     ; 01578
        bra.b   l_005_0158C                     ; 01580
l_005_01582:
        clr.b   (ChaffLeft).l                   ; 01582
        move.w  #$4029,d0                       ; 01588
l_005_0158C:
        jsr     (StartWarning).l                ; 0158C
        move.w  d4,d0                           ; 01592
        bra.w   l_005_01624                     ; 01594
	dc.b	$60,$00,$00,$8A
l_005_0159C:
        tst.l   (ReplayPointer).l               ; 0159C
        beq.w   l_005_01624                     ; 015A2
        move.l  (RecordBuffer).l,(ReplayPointer).l ; 015A6
        move.l  (RecordControls).l,(ReplayControlsPointer).l ; 015B0
        addq.l  #$1,(ReplayPointer).l           ; 015BA
        addq.l  #$8,(ReplayControlsPointer).l   ; 015C0
        move.b  #$3,(RecordMode).l              ; 015C6
        move.b  #$1,(QuitRequest).l             ; 015CE
        bra.w   l_005_01624                     ; 015D6
Key_J:
        lea.l   (JToggle2).l,a0                 ; 015DA
        bset    #$3,(ToggleKeys).l              ; 015E0
        move.b  #$3,(JLampRedraw).l             ; 015E8
        jsr     (KeyBeep).l                     ; 015F0
        lea.l   (JToggle).l,a0                  ; 015F6

;-------------------------------------------------------------------------------
; ToggleByte - Flips the byte at a0 between 0 and 1 (the keys that switch something on and
; off).
;-------------------------------------------------------------------------------
ToggleByte:
        tst.b   (a0)                            ; 015FC
        beq.b   l_005_01606                     ; 015FE
        move.b  #$0,(a0)                        ; 01600
        bra.b   l_005_01624                     ; 01604
l_005_01606:
        move.b  #$1,(a0)                        ; 01606
        bra.b   l_005_01624                     ; 0160A
Key_Esc:
        tst.b   d6                              ; 0160C
        beq.b   l_005_01612                     ; 0160E
        bra.b   l_005_0161C                     ; 01610
l_005_01612:
        move.b  #$1,(QuitRequest).l             ; 01612
        bra.b   l_005_01624                     ; 0161A
l_005_0161C:
        move.b  #$ff,(QuitRequest).l            ; 0161C
l_005_01624:
        tst.b   (KeyPressed).l                  ; 01624
        bne.b   l_005_0168C                     ; 0162A
        btst    #$7,d0                          ; 0162C
        bne.b   l_005_0168C                     ; 01630
        move.b  #$1,(KeyPressed).l              ; 01632
        cmpi.b  #$a,(KeyBufferCount).l          ; 0163A
        bge.b   l_005_0168C                     ; 01642
        move.b  (KeyBufferIn).l,d4              ; 01644
        cmpi.b  #$a,d4                          ; 0164A
        blt.b   l_005_01652                     ; 0164E
        moveq   #$0,d4                          ; 01650
l_005_01652:
        ext.w   d4                              ; 01652
        lea.l   (KeyBuffer).l,a3                ; 01654
        move.b  d0,(a3,d4.w)                    ; 0165A
        andi.w  #$ff,d0                         ; 0165E
        lea.l   (KeyToAscii).l,a3               ; 01662
        move.b  (a3,d0.w),d0                    ; 01668
        addq.b  #$1,d4                          ; 0166C
        move.b  d4,(KeyBufferIn).l              ; 0166E
        addq.b  #$1,(KeyBufferCount).l          ; 01674
        lea.l   (SecurityInput).l,a3            ; 0167A
        move.b  (InputPos).l,d4                 ; 01680
        ext.w   d4                              ; 01686
        move.b  d0,(a3,d4.w)                    ; 01688
l_005_0168C:
        clr.b   (ShiftDown).l                   ; 0168C
        clr.b   (LeftAmigaDown).l               ; 01692
        clr.b   (RightAmigaDown).l              ; 01698
Key_LShiftUp_RShiftUp:
        rts                                     ; 0169E
Key_Z_Del:
        jmp     (WithoutMouseInterrupt).l       ; 016A0
	dc.b	$00,$00
h005_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    1,5                             ; 1 longs pointing into hunk 5
	dc.l	$E4E
        dc.l    327,71                          ; 327 longs pointing into hunk 71
	dc.l	$154,$4D2,$169A,$14E,$4B6,$1048,$1694,$182
	dc.l	$48A,$168E,$F78,$FF2,$15EC,$9DA,$584,$DDC
	dc.l	$CF4,$D10,$D2A,$D5A,$D86,$DA8,$524,$52A
	dc.l	$A24,$644,$A2C,$FE4,$FEC,$DBE,$1314,$F0C
	dc.l	$5FC,$C18,$C32,$C9E,$CB8,$1390,$13BA,$13C0
	dc.l	$13C6,$13DE,$13E4,$13EA,$13F0,$13F6,$13FC,$C70
	dc.l	$DE4,$F14,$F5A,$D30,$D3C,$D60,$D68,$DB6
	dc.l	$E06,$E54,$E76,$134C,$124C,$A9A,$AA2,$1308
	dc.l	$20,$17C,$B52,$B72,$BDA,$BE2,$BF4,$C4A
	dc.l	$C82,$12A4,$1300,$130C,$1426,$15D2,$1616,$1620
	dc.l	$4DE,$1682,$167C,$163E,$1676,$1646,$1670,$1656
	dc.l	$15DC,$518,$736,$10E4,$1462,$1472,$14AC,$14B8
	dc.l	$14EE,$157C,$1564,$1584,$14D6,$14F6,$156E,$14E0
	dc.l	$15F8,$F1A,$F3A,$F46,$EDC,$EE4,$EFC,$F04
	dc.l	$F30,$556,$564,$E32,$E90,$EA8,$EB4,$1358
	dc.l	$1432,$1026,$63C,$620,$634,$12DC,$DCC,$64E
	dc.l	$65E,$1516,$BBE,$C3A,$C52,$CC0,$D8E,$DB0
	dc.l	$DD4,$F28,$12D4,$5C6,$A8A,$DF0,$12F4,$12EA
	dc.l	$668,$7B6,$144E,$1534,$152A,$1520,$1EC,$53E
	dc.l	$68A,$8CA,$8D6,$916,$922,$964,$970,$986
	dc.l	$992,$9AC,$9B8,$9E2,$A0A,$A1C,$A36,$F88
	dc.l	$FAA,$FC0,$FD6,$FDC,$1006,$1010,$1104,$153E
	dc.l	$5C0,$A84,$ADC,$DEA,$131E,$59E,$94C,$998
	dc.l	$900,$1394,$13AE,$AB6,$B5C,$906,$952,$A7E
	dc.l	$C10,$C96,$1388,$1420,$1082,$1AA,$1062,$1088
	dc.l	$BC4,$BD0,$C58,$C64,$12E4,$146C,$1A0,$424
	dc.l	$1288,$168,$170,$11BC,$11EC,$1236,$A50,$129E
	dc.l	$1626,$1636,$1BE,$1E2,$370,$F66,$F70,$1040
	dc.l	$1162,$11D6,$143E,$150E,$1B4,$1092,$10AE,$A92
	dc.l	$1326,$A68,$BB6,$188,$2CA,$BFE,$C8C,$127E
	dc.l	$1376,$1458,$AC2,$1278,$A70,$B4C,$ED2,$EF0
	dc.l	$1292,$1418,$5A8,$90E,$95A,$A78,$1410,$140A
	dc.l	$1404,$1496,$9C,$A8,$1C8,$672,$6A6,$74A
	dc.l	$7BE,$10B8,$12B2,$1486,$15CA,$9F8,$1158,$9F2
	dc.l	$1152,$113A,$73E,$8C2,$9EC,$10FA,$110E,$1118
	dc.l	$1134,$548,$56A,$57C,$E44,$E6A,$1346,$E3C
	dc.l	$E62,$133E,$A5C,$AAE,$B6C,$B86,$BA2,$BAE
	dc.l	$BEC,$C0A,$C7C,$CE4,$D00,$D1C,$D4C,$D76
	dc.l	$D98,$F52,$1382,$536,$596,$5BA,$9D2,$A02
	dc.l	$FBA,$FFE,$14D0,$155E,$15E4,$B2,$6AE,$12
	dc.l	$28,$69C,$1016,$196,$506,$14C0,$4
        dc.l    26,73                           ; 26 longs pointing into hunk 73
	dc.l	$696,$6CE,$712,$718,$15B6,$15C2,$6BE,$6C8
	dc.l	$70E,$15B2,$684,$690,$6D4,$708,$71E,$123C
	dc.l	$159E,$15AC,$15BC,$6B4,$6FA,$6F4,$704,$15A8
	dc.l	$6EC,$148E
        dc.l    1,2                             ; 1 longs pointing into hunk 2
	dc.l	$11A6
        dc.l    1,8                             ; 1 longs pointing into hunk 8
	dc.l	$B24
        dc.l    3,67                            ; 3 longs pointing into hunk 67
	dc.l	$B0C,$ABC,$1254
        dc.l    11,39                           ; 11 longs pointing into hunk 39
	dc.l	$58E,$5B2,$9CA,$A14,$F80,$FA4,$1030,$1446
	dc.l	$15F2,$11DC,$1664
        dc.l    6,6                             ; 6 longs pointing into hunk 6
	dc.l	$E70,$DC4,$12FA,$136C,$616,$60C
        dc.l    1,0                             ; 1 longs pointing into hunk 0
	dc.l	$154E
        dc.l    2,7                             ; 2 longs pointing into hunk 7
	dc.l	$A,$16A2
        dc.l    1,22                            ; 1 longs pointing into hunk 22
	dc.l	$7CC
        dc.l    2,4                             ; 2 longs pointing into hunk 4
	dc.l	$B04,$B46
        dc.l    4,20                            ; 4 longs pointing into hunk 20
	dc.l	$A42,$F98,$1500,$158E
        dc.l    2,0                             ; 2 longs pointing into hunk 0
	dc.l	$13A0,$147E
	dc.l	0
	dc.l	HUNK_END
	endc
