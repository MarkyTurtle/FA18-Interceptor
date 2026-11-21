; F/A-18 Interceptor - hunk 4 (code)
; Game set-up and small helpers: the difficulty from the flight log, resetting objects.
; Included by ../f18_main.s.

;===============================================================================
; Hunk 4: CODE, $7F4 bytes
;===============================================================================
	CODE_HUNK	h004

;-------------------------------------------------------------------------------
; GetDifficulty - Copies the difficulty from the flight log (+$02) into Difficulty and
; DifficultySaved.
;-------------------------------------------------------------------------------
GetDifficulty:
        movea.l (ConfigBuffer).l,a0             ; 00000
        move.w  $2(a0),d0                       ; 00006
        move.b  d0,(Difficulty).l               ; 0000A
        move.b  d0,(DifficultySaved).l          ; 00010
        rts                                     ; 00016

;-------------------------------------------------------------------------------
; PutDifficulty - Stores Difficulty into the flight log (+$02).
;-------------------------------------------------------------------------------
PutDifficulty:
        movea.l (ConfigBuffer).l,a0             ; 00018
        move.b  (Difficulty).l,d0               ; 0001E
        ext.w   d0                              ; 00024
        move.w  d0,$2(a0)                       ; 00026
        rts                                     ; 0002A

;-------------------------------------------------------------------------------
; InitGameValues - The values set once at the start: the palette at full brightness (FadeLevel,
; FadeTarget 15), the keys in text mode (KeyMode 1), the F/A-18 as the aircraft
; (PlayerAircraftType $11).
;-------------------------------------------------------------------------------
InitGameValues:
        lea.l   (FileSize).l,a0                 ; 0002C
        move.w  #$fffc,$2a(a0)                  ; 00032
        clr.b   (PaletteLoadCount).l            ; 00038
        clr.b   (TextKeyCount).l                ; 0003E
        move.b  #$f,(FadeLevel).l               ; 00044
        move.b  #$f,(FadeTarget).l              ; 0004C
        move.b  #$1,(KeyMode).l                 ; 00054
        move.b  #$1,(GameStarted).l             ; 0005C
        move.b  #$11,(PlayerAircraftType).l     ; 00064
        rts                                     ; 0006C

;-------------------------------------------------------------------------------
; ResetGame - Resets the world for a new flight: difficulty, objects, the text page queue and
; the screen.
;-------------------------------------------------------------------------------
ResetGame:
        bsr.w   ClearGameFlags                  ; 0006E
        bsr.w   SetGameFlags                    ; 00072
        move.b  (DifficultySaved).l,(Difficulty).l ; 00076
        clr.w   (TrainingFrame).l               ; 00080
        clr.w   (ResetWord).l                   ; 00086
        clr.l   (TextPages).l                   ; 0008C
        moveq   #-1,d0                          ; 00092
        move.b  d0,(RedrawFlags).l              ; 00094
        move.b  d0,(TextStatus).l               ; 0009A
        move.b  d0,(CameraSequence).l           ; 000A0
        move.w  #$5,(StateTimer).l              ; 000A6
        move.l  #$1b8,(TextCursor).l            ; 000AE
        jsr     (ClearScreen).l                 ; 000B8
        lea.l   (ObjectTable).l,a0              ; 000BE
        moveq   #$f,d0                          ; 000C4
l_004_000C6:
        moveq   #$28,d4                         ; 000C6
        lea.l   (a0),a1                         ; 000C8
l_004_000CA:
        clr.l   (a1)+                           ; 000CA
        dbra    d4,l_004_000CA                  ; 000CC
        adda.w  #$200,a0                        ; 000D0
        dbra    d0,l_004_000C6                  ; 000D4
        lea.l   (SmallObjects).l,a0             ; 000D8
        moveq   #$f,d0                          ; 000DE
l_004_000E0:
        moveq   #$7,d4                          ; 000E0
        lea.l   (a0),a1                         ; 000E2
l_004_000E4:
        clr.l   (a1)+                           ; 000E4
        dbra    d4,l_004_000E4                  ; 000E6
        adda.w  #$20,a0                         ; 000EA
        dbra    d0,l_004_000E0                  ; 000EE
        bsr.w   ResetPlayerFlags                ; 000F2
        move.w  #$140,(BulletHitRange).l        ; 000F6
        move.w  #$140,(BulletHitRange2).l       ; 000FE
        move.b  #$0,(StartPoint).l              ; 00106
        move.b  #$1,(MarkersOn).l               ; 0010E
        move.w  #$800,(FlameObject).l           ; 00116
        bsr.w   BayCentre                       ; 0011E
        bsr.w   SetCameraAt                     ; 00122
        move.l  #$3000000,(MapViewHeight).l     ; 00126
        clr.l   (CameraVelocity).l              ; 00130
        clr.l   (CameraVelocityY).l             ; 00136
        clr.l   (CameraVelocityZ).l             ; 0013C
        move.w  #$1c20,(OutsideCamPitch).l      ; 00142
        move.w  #$0,(OutsideCamHeading).l       ; 0014A
        move.w  #$a7,(ClipY).l                  ; 00152
        move.w  #$32,(ViewShift).l              ; 0015A
        move.w  #$320,(ViewX).l                 ; 00162
        moveq   #-1,d0                          ; 0016A
        move.l  d0,(ClockStart).l               ; 0016C
        move.l  d0,(ClockLast).l                ; 00172
        move.b  d0,(ViewOctantShown).l          ; 00178
        move.b  #$f,(ClockStep).l               ; 0017E
        move.w  #$7fff,(BestClock).l            ; 00186
        move.l  #$800000,(FlightValue).l        ; 0018E
        move.w  #$a8,(ScaleFactors).l           ; 00198
        move.w  #$fc,(ScaleFactorZ).l           ; 001A0
        move.w  #$80,(RadarScale).l             ; 001A8
        move.b  #$80,(GroundDetail).l           ; 001B0
        lea.l   (ResetList).l,a0                ; 001B8
        moveq   #$15,d1                         ; 001BE
        clr.w   d0                              ; 001C0
l_004_001C2:
        move.w  d0,(a0)+                        ; 001C2
        addq.w  #$1,d0                          ; 001C4
        dbra    d1,l_004_001C2                  ; 001C6
        moveq   #$30,d1                         ; 001CA
        lea.l   (TextBuffer).l,a0               ; 001CC
        move.l  #QuitRequest,d0                 ; 001D2
        sub.l   a0,d0                           ; 001D8
        subq.w  #$1,d0                          ; 001DA
l_004_001DC:
        move.b  d1,(a0)+                        ; 001DC
        dbra    d0,l_004_001DC                  ; 001DE
        lea.l   (TargetText).l,a0               ; 001E2
        moveq   #$20,d1                         ; 001E8
        moveq   #$1b,d0                         ; 001EA
l_004_001EC:
        move.b  d1,(a0)+                        ; 001EC
        dbra    d0,l_004_001EC                  ; 001EE
        bsr.w   ResetRecording                  ; 001F2
        jsr     (BuildSceneryBits).l            ; 001F6
        jsr     (UpdateViewCell).l              ; 001FC
        jsr     (UpdateScenery).l               ; 00202
        rts                                     ; 00208

;-------------------------------------------------------------------------------
; ClearGameFlags - Clears the variables from DemoActive to ConfigChanged, and from DebriefDelay
; to LogDiskStatus (ResetGame).
;-------------------------------------------------------------------------------
ClearGameFlags:
        lea.l   (DemoActive).l,a0               ; 0020A
        move.l  #ConfigChanged,d0               ; 00210
        sub.l   a0,d0                           ; 00216
        subq.w  #$1,d0                          ; 00218
l_004_0021A:
        clr.b   (a0)+                           ; 0021A
        dbra    d0,l_004_0021A                  ; 0021C
        lea.l   (DebriefDelay).l,a0             ; 00220
        move.l  #LogDiskStatus,d0               ; 00226
        sub.l   a0,d0                           ; 0022C
        lsr.w   #$1,d0                          ; 0022E
        subq.w  #$1,d0                          ; 00230
l_004_00232:
        clr.w   (a0)+                           ; 00232
        dbra    d0,l_004_00232                  ; 00234
        rts                                     ; 00238

;-------------------------------------------------------------------------------
; SetGameFlags - Sets every byte from FlightPhysics to DemoActive to 1 (ResetGame).
;-------------------------------------------------------------------------------
SetGameFlags:
        lea.l   (FlightPhysics).l,a0            ; 0023A
        move.l  #DemoActive,d0                  ; 00240
        sub.l   a0,d0                           ; 00246
        subq.w  #$1,d0                          ; 00248
l_004_0024A:
        move.b  #$1,(a0)+                       ; 0024A
        dbra    d0,l_004_0024A                  ; 0024E
        rts                                     ; 00252

;-------------------------------------------------------------------------------
; BayCentre - d0-d2 = the middle of the bay ($10C00000, $5000000, $11400000): where the camera
; starts and the map view looks from.
;-------------------------------------------------------------------------------
BayCentre:
        move.l  #$10c00000,d0                   ; 00254
        move.l  #$5000000,d1                    ; 0025A
        move.l  #$11400000,d2                   ; 00260
        rts                                     ; 00266

;-------------------------------------------------------------------------------
; CameraAtStart - Puts the camera at ($10800000, $3000000, $10C00000) (SetCameraAt).
;-------------------------------------------------------------------------------
CameraAtStart:
        move.l  #$10800000,d0                   ; 00268
        move.l  #$3000000,d1                    ; 0026E
        move.l  #$10c00000,d2                   ; 00274
        bra.b   SetCameraAt                     ; 0027A

;-------------------------------------------------------------------------------
; CameraAtRunway - Puts the camera low over one runway ($10546800, $5000, $10A36700)
; (SetCameraAt).
;-------------------------------------------------------------------------------
CameraAtRunway:
        move.l  #$10546800,d0                   ; 0027C
        move.l  #$5000,d1                       ; 00282
        move.l  #$10a36700,d2                   ; 00288
        bra.b   SetCameraAt                     ; 0028E

;-------------------------------------------------------------------------------
; CameraAtRunway2 - Puts the camera low over another place ($0F248000, $5000, $0FCCF000)
; (SetCameraAt).
;-------------------------------------------------------------------------------
CameraAtRunway2:
        move.l  #$f248000,d0                    ; 00290
        move.l  #$5000,d1                       ; 00296
        move.l  #$fccf000,d2                    ; 0029C

;-------------------------------------------------------------------------------
; SetCameraAt - Sets the camera's position (CameraX/Y/Z from d0-d2) and the negated offsets
; within its cell at CameraCellOffset.
;-------------------------------------------------------------------------------
SetCameraAt:
        move.l  d0,(CameraX).l                  ; 002A2
        move.l  d1,(CameraY).l                  ; 002A8
        move.l  d2,(CameraZ).l                  ; 002AE
        andi.l  #$3fffff,d0                     ; 002B4
        andi.l  #$3fffff,d2                     ; 002BA
        neg.l   d0                              ; 002C0
        neg.l   d1                              ; 002C2
        neg.l   d2                              ; 002C4
        move.l  d0,(CameraCellOffset).l         ; 002C6
        move.l  d1,(CameraCellOffsetY).l        ; 002CC
        move.l  d2,(CameraCellOffsetZ).l        ; 002D2
        rts                                     ; 002D8

;-------------------------------------------------------------------------------
; PointAheadOfView - FlyByPoint = the point $E980 along the viewed object's axis
; (TurnByPlayer): a place ahead of it.
;-------------------------------------------------------------------------------
PointAheadOfView:
        moveq   #$0,d3                          ; 002DA
        moveq   #$0,d4                          ; 002DC
        move.w  #$e980,d5                       ; 002DE
        bsr.w   TurnByPlayer                    ; 002E2
        movem.l d0-d2,(FlyByPoint).l            ; 002E6
        rts                                     ; 002EE

;-------------------------------------------------------------------------------
; TurnByPanelMatrix - Turns (d3, d4, d5) by the viewed object's matrix (after
; CameraHeadingMatrix), into PanelVector.
;-------------------------------------------------------------------------------
TurnByPanelMatrix:
        movem.l a1-a2,-(a7)                     ; 002F0
        movem.w d3-d5,-(a7)                     ; 002F4
        jsr     (CameraHeadingMatrix).l         ; 002F8
        movem.w (a7)+,d3-d5                     ; 002FE
        lea.l   (ObjectTable).l,a1              ; 00302
        adda.w  (ViewObject).l,a1               ; 00308
        lea.l   (PanelVector).l,a2              ; 0030E
        bra.b   l_004_0033E                     ; 00314

;-------------------------------------------------------------------------------
; TurnByViewObject - Turns (d3, d4, d5) by the viewed object's matrix (+$92) into world axes:
; d0-d2.
;-------------------------------------------------------------------------------
TurnByViewObject:
        movem.l a1-a2,-(a7)                     ; 00316
        lea.l   (ObjectTable).l,a1              ; 0031A
        adda.w  (ViewObject).l,a1               ; 00320
        bra.b   l_004_00338                     ; 00326

;-------------------------------------------------------------------------------
; TurnByObject - Turns (d3, d4, d5) by the matrix of the object at a1 (+$92): d0-d2.
;-------------------------------------------------------------------------------
TurnByObject:
        movem.l a1-a2,-(a7)                     ; 00328
        bra.b   l_004_00338                     ; 0032C

;-------------------------------------------------------------------------------
; TurnByPlayer - Turns (d3, d4, d5) by the player's matrix: d0-d2.
;-------------------------------------------------------------------------------
TurnByPlayer:
        movem.l a1-a2,-(a7)                     ; 0032E
        lea.l   (ObjectTable).l,a1              ; 00332
l_004_00338:
        lea.l   (a1),a2                         ; 00338
        adda.w  #$92,a2                         ; 0033A
l_004_0033E:
        move.w  d3,d6                           ; 0033E
        move.w  d4,d0                           ; 00340
        move.w  d5,d7                           ; 00342
        muls.w  (a2),d6                         ; 00344
        muls.w  $2(a2),d0                       ; 00346
        muls.w  $4(a2),d7                       ; 0034A
        add.l   d6,d0                           ; 0034E
        add.l   d7,d0                           ; 00350
        move.w  d3,d6                           ; 00352
        move.w  d4,d1                           ; 00354
        move.w  d5,d7                           ; 00356
        muls.w  $6(a2),d6                       ; 00358
        muls.w  $8(a2),d1                       ; 0035C
        muls.w  $a(a2),d7                       ; 00360
        add.l   d6,d1                           ; 00364
        add.l   d7,d1                           ; 00366
        move.w  d4,d2                           ; 00368
        muls.w  $c(a2),d3                       ; 0036A
        muls.w  $e(a2),d2                       ; 0036E
        muls.w  $10(a2),d5                      ; 00372
        add.l   d3,d2                           ; 00376
        add.l   d5,d2                           ; 00378
        asr.l   #$4,d0                          ; 0037A
        asr.l   #$4,d1                          ; 0037C
        asr.l   #$4,d2                          ; 0037E
        add.l   $14(a1),d0                      ; 00380
        add.l   $18(a1),d1                      ; 00384
        add.l   $1c(a1),d2                      ; 00388
        movem.l (a7)+,a1-a2                     ; 0038C
        rts                                     ; 00390

;-------------------------------------------------------------------------------
; ResetViewAndRecording - Back to the cockpit view (a new view, the camera following), then
; ResetRecording.
;-------------------------------------------------------------------------------
ResetViewAndRecording:
        clr.b   (OutsideView).l                 ; 00392
        clr.b   (AnglesSet).l                   ; 00398
        move.b  #$1,(NewView).l                 ; 0039E
        move.b  #$1,(CameraFollows).l           ; 003A6

;-------------------------------------------------------------------------------
; ResetRecording - Points the flight recording's and the replay's pointers back to the start of
; their buffers, then ResetPlayer.
;-------------------------------------------------------------------------------
ResetRecording:
        move.l  (RecordBuffer).l,(RecordPointer).l ; 003AE
        move.l  (RecordControls).l,(RecordControlsPointer).l ; 003B8
        move.l  (RecordBuffer).l,(ReplayPointer).l ; 003C2
        move.l  (RecordControls).l,(ReplayControlsPointer).l ; 003CC
        addq.l  #$4,(ReplayControlsPointer).l   ; 003D6
        clr.w   (RecordCount).l                 ; 003DC
        clr.w   (ReplayCount).l                 ; 003E2

;-------------------------------------------------------------------------------
; ResetPlayer - A new aircraft for the player: everything redrawn, ResetPlayerFlags and
; ResetPlayerMotion, the throttle and its mouse position at 9, the engine sound restarted.
;-------------------------------------------------------------------------------
ResetPlayer:
        move.b  #$ff,(RedrawFlags).l            ; 003E8
        bsr.w   ResetPlayerFlags                ; 003F0
        bsr.w   ResetPlayerMotion               ; 003F4
        clr.w   (EjectedPilot).l                ; 003F8
        moveq   #$9,d0                          ; 003FE
        move.b  d0,(PlayerThrottle).l           ; 00400
        asl.w   #$3,d0                          ; 00406
        move.w  d0,(MouseY).l                   ; 00408
        move.w  d0,(ThrottleMouseY).l           ; 0040E
        move.b  #$fe,(EngineSoundRequest).l     ; 00414
        lea.l   (ModelTable).l,a0               ; 0041C
        move.b  (PlayerAircraftType).l,d1       ; 00422
        cmpi.b  #$10,d1                         ; 00428
        bne.b   l_004_00434                     ; 0042C
        move.w  #$3c,d0                         ; 0042E
        bra.b   l_004_00438                     ; 00432
l_004_00434:
        move.w  #$50,d0                         ; 00434
l_004_00438:
        move.b  d1,(PlayerType).l               ; 00438
        adda.w  d0,a0                           ; 0043E
        movem.l (a0),d0-d4                      ; 00440
        move.l  #DrawModel,d0                   ; 00444
        movem.l d0-d4,(ObjectDrawTable).l       ; 0044A
        movea.l (ObjectDrawEntries).l,a1        ; 00452
        move.w  (a1),d2                         ; 00458
        blt.b   l_004_0046C                     ; 0045A
        andi.w  #$4000,d2                       ; 0045C
        beq.b   l_004_00468                     ; 00460
        move.w  $2(a1),d2                       ; 00462
        bra.b   l_004_0046C                     ; 00466
l_004_00468:
        move.w  $4(a1),d2                       ; 00468
l_004_0046C:
        andi.w  #$fff,d2                        ; 0046C
        move.b  $6(a1,d2.w),d4                  ; 00470
        andi.b  #$f,d4                          ; 00474
        move.b  d4,(Player_7D).l                ; 00478
        clr.b   (FlightFlag170).l               ; 0047E
        lea.l   (ObjectTable).l,a1              ; 00484
        andi.w  #$f9ff,obj_Flags(a1)            ; 0048A
        andi.w  #$deff,obj_Flags2(a1)           ; 00490
        andi.w  #$7ff7,obj_Flags2(a1)           ; 00496
        bclr    #$4,obj_Flags2(a1)              ; 0049C
        ori.w   #$80,obj_Flags2(a1)             ; 004A2
        andi.b  #$3f,obj_Bits(a1)               ; 004A8
        bclr    #$1,obj_Bits(a1)                ; 004AE
        andi.b  #$f7,obj_Bits(a1)               ; 004B4
        bclr    #$0,obj_Status(a1)              ; 004BA
        bclr    #$2,obj_Status(a1)              ; 004C0
        bclr    #$1,obj_Status(a1)              ; 004C6
        move.b  #$0,obj_Ejection(a1)            ; 004CC
        clr.b   (ModelVariant).l                ; 004D2
        clr.b   (GearState).l                   ; 004D8
        clr.b   (EjectKeyFlag).l                ; 004DE
        clr.b   (PanelIndicatorBlink).l         ; 004E4
l_004_004EA:
        lea.l   (StartPoints).l,a0              ; 004EA
        move.b  (StartPoint).l,d0               ; 004F0
        ext.w   d0                              ; 004F6
        asl.w   #$4,d0                          ; 004F8
        adda.w  d0,a0                           ; 004FA
        movem.w (a0)+,d0-d4                     ; 004FC
        tst.w   d0                              ; 00500
        blt.w   l_004_005E0                     ; 00502
        move.w  d0,(ViewBlockX).l               ; 00506
        move.w  d1,(ViewBlockZ).l               ; 0050C
        move.b  d2,$b(a1)                       ; 00512
        lea.l   (StartPointSubCells).l,a2       ; 00516
        move.w  d2,d6                           ; 0051C
        add.w   d6,d6                           ; 0051E
        move.w  (ViewBlockX).l,d5               ; 00520
        asl.w   #$2,d5                          ; 00526
        move.b  (a2,d6.w),d7                    ; 00528
        ext.w   d7                              ; 0052C
        add.w   d7,d5                           ; 0052E
        move.w  d5,$6(a1)                       ; 00530
        move.w  d5,(ViewCellX).l                ; 00534
        move.w  (ViewBlockZ).l,d5               ; 0053A
        asl.w   #$2,d5                          ; 00540
        move.b  $1(a2,d6.w),d7                  ; 00542
        ext.w   d7                              ; 00546
        add.w   d7,d5                           ; 00548
        move.w  d5,(ViewCellZ).l                ; 0054A
        move.w  d5,$8(a1)                       ; 00550
        swap    d0                              ; 00554
        asl.l   #$8,d0                          ; 00556
        swap    d1                              ; 00558
        asl.l   #$8,d1                          ; 0055A
        asl.w   #$2,d2                          ; 0055C
        lea.l   (SubCellOffsets).l,a2                   ; 0055E
        movem.w (a2,d2.w),d5-d6                 ; 00564
        asl.l   #$8,d5                          ; 0056A
        asl.l   #$8,d6                          ; 0056C
        asl.l   #$2,d5                          ; 0056E
        asl.l   #$2,d6                          ; 00570
        add.l   d5,d0                           ; 00572
        add.l   d6,d1                           ; 00574
        movem.w (a0)+,d5-d7                     ; 00576
        asl.l   #$4,d5                          ; 0057A
        asl.l   #$4,d6                          ; 0057C
        asl.l   #$8,d3                          ; 0057E
        asl.l   #$8,d4                          ; 00580
        asl.l   #$2,d3                          ; 00582
        asl.l   #$2,d4                          ; 00584
        add.l   d5,d3                           ; 00586
        add.l   d6,d4                           ; 00588
        move.l  #$708,$18(a1)                   ; 0058A
        add.l   d3,d0                           ; 00592
        add.l   d4,d1                           ; 00594
        move.l  d0,$14(a1)                      ; 00596
        move.l  d1,$1c(a1)                      ; 0059A
        neg.l   d3                              ; 0059E
        neg.l   d4                              ; 005A0
        move.l  d3,(ViewOffsetX).l              ; 005A2
        move.l  d4,(ViewOffsetZ).l              ; 005A8
        move.l  #$fffff8f8,(ViewOffsetY).l      ; 005AE
        neg.l   d3                              ; 005B8
        neg.l   d4                              ; 005BA
        asr.l   #$8,d3                          ; 005BC
        asr.l   #$8,d4                          ; 005BE
        move.w  d3,$c(a1)                       ; 005C0
        move.w  d4,$e(a1)                       ; 005C4
        move.l  #$fffffff9,$10(a1)              ; 005C8
        moveq   #$0,d4                          ; 005D0
        moveq   #$0,d6                          ; 005D2
        mulu.w  #$a,d7                          ; 005D4
        asl.w   #$3,d7                          ; 005D8
        move.w  d7,d5                           ; 005DA
        bra.w   l_004_00700                     ; 005DC
l_004_005E0:
        andi.w  #$7fff,d0                       ; 005E0
        move.w  d0,d1                           ; 005E4
        asl.w   #$8,d0                          ; 005E6
        add.w   d0,d0                           ; 005E8
        adda.w  d0,a1                           ; 005EA
        btst    #$6,$1(a1)                      ; 005EC
        bne.b   l_004_005FE                     ; 005F2
        clr.b   (StartPoint).l                  ; 005F4
        bra.w   l_004_004EA                     ; 005FA
l_004_005FE:
        lea.l   (ObjectTable).l,a2              ; 005FE
        lea.l   (ObjectDrawTable).l,a4          ; 00604
        asl.w   #$2,d1                          ; 0060A
        move.w  d1,d0                           ; 0060C
        asl.w   #$2,d1                          ; 0060E
        add.w   d0,d1                           ; 00610
        movea.l $10(a4,d1.w),a4                 ; 00612
        move.l  $2(a4),d0                       ; 00616
        blt.b   l_004_0062C                     ; 0061A
        move.w  #$28,(DebugCheckpoint).l        ; 0061C
        jsr     (Nop).l                         ; 00624
        clr.l   d0                              ; 0062A
l_004_0062C:
        bclr    #$1f,d0                         ; 0062C
        move.l  d0,d1                           ; 00630
        addi.l  #$7,d0                          ; 00632
        move.l  d0,obj_Y8(a2)                   ; 00638
        asl.l   #$8,d1                          ; 0063C
        addi.l  #$708,d1                        ; 0063E
        move.l  d1,obj_Y(a2)                    ; 00644
        ori.b   #$c0,obj_Bits(a2)               ; 00648
        ori.b   #$8,obj_Bits(a2)                ; 0064E
        move.w  #$a4,d0                         ; 00654
        clr.w   obj_X(a2,d0.w)                  ; 00658
        move.l  $66(a1),obj_Pitch(a2)           ; 0065C
        move.w  $6a(a1),obj_Roll(a2)            ; 00662
        move.w  #$b,d3                          ; 00668
        moveq   #$0,d4                          ; 0066C
        move.w  #$68,d5                         ; 0066E
        bsr.w   TurnByObject                    ; 00672
        lea.l   (ObjectTable).l,a1              ; 00676
        move.l  d0,obj_X(a1)                    ; 0067C
        move.l  d2,obj_Z(a1)                    ; 00680
        move.l  d0,d3                           ; 00684
        move.l  d2,d4                           ; 00686
        andi.l  #$3fffff,d3                     ; 00688
        andi.l  #$3fffff,d4                     ; 0068E
        asr.l   #$8,d3                          ; 00694
        asr.l   #$8,d4                          ; 00696
        move.w  d3,obj_X8(a1)                   ; 00698
        move.w  d4,obj_Z8(a1)                   ; 0069C
        move.l  d2,d1                           ; 006A0
        andi.l  #$1fffffff,d0                   ; 006A2
        andi.l  #$1fffffff,d1                   ; 006A8
        swap    d0                              ; 006AE
        swap    d1                              ; 006B0
        asr.w   #$4,d0                          ; 006B2
        asr.w   #$4,d1                          ; 006B4
        move.w  d0,d2                           ; 006B6
        move.w  d1,d3                           ; 006B8
        andi.w  #$3,d0                          ; 006BA
        andi.w  #$3,d1                          ; 006BE
        subq.b  #$3,d0                          ; 006C2
        neg.b   d0                              ; 006C4
        subq.b  #$3,d1                          ; 006C6
        neg.b   d1                              ; 006C8
        add.b   d1,d1                           ; 006CA
        add.b   d1,d1                           ; 006CC
        add.b   d0,d1                           ; 006CE
        move.b  d1,obj_SubCell(a1)              ; 006D0
        asr.w   #$2,d2                          ; 006D4
        asr.w   #$2,d3                          ; 006D6
        move.w  d2,obj_CellX(a1)                ; 006D8
        move.w  d3,obj_CellZ(a1)                ; 006DC
        andi.w  #$3,d2                          ; 006E0
        andi.w  #$3,d3                          ; 006E4
        subq.b  #$3,d2                          ; 006E8
        neg.b   d2                              ; 006EA
        subq.b  #$3,d3                          ; 006EC
        neg.b   d3                              ; 006EE
        add.b   d3,d3                           ; 006F0
        add.b   d3,d3                           ; 006F2
        add.b   d2,d3                           ; 006F4
        move.b  d3,$b(a1)                       ; 006F6
        movem.w obj_Pitch(a1),d4-d6             ; 006FA
l_004_00700:
        jsr     (SetAttitude).l                 ; 00700
        rts                                     ; 00706

;-------------------------------------------------------------------------------
; ResetPlayerMotion - Clears the player's speeds, forces, rates and the like (ObjectTable +$6C,
; +$6E, +$78, +$3E-$49, +$50, +$56-$5B).
;-------------------------------------------------------------------------------
ResetPlayerMotion:
        lea.l   (ObjectTable).l,a1              ; 00708
        clr.w   obj_Speed(a1)                   ; 0070E
        clr.w   obj_SpeedFlown(a1)              ; 00712
        clr.w   obj_ClimbSpeed(a1)              ; 00716
        clr.l   obj_VelX(a1)                    ; 0071A
        clr.l   obj_VelY(a1)                    ; 0071E
        clr.l   obj_VelZ(a1)                    ; 00722
        clr.l   obj_PitchRate(a1)               ; 00726
        clr.w   obj_RollRate(a1)                ; 0072A
        clr.l   obj_AimRate1(a1)                ; 0072E
        clr.w   obj_AimRate3(a1)                ; 00732
        clr.b   obj_Controls(a1)                ; 00736
        move.b  #$9,obj_Throttle(a1)            ; 0073A
        andi.w  #$7fff,obj_Flags(a1)            ; 00740
        clr.l   (WarningFlags).l                ; 00746
        clr.l   (SoundRequests).l               ; 0074C
        clr.w   (CurrentWarning).l              ; 00752
        clr.w   (WarningPlaying).l              ; 00758
        move.w  #$ffff,(TargetReadoutShown).l   ; 0075E
        rts                                     ; 00766

;-------------------------------------------------------------------------------
; ResetPlayerFlags - Resets the player's record: the weapons (+$63 $0D, ResetPlayerAircraft),
; its flags (+$00 = $1148), +$7E $1400, and the flash and warning counters.
;-------------------------------------------------------------------------------
ResetPlayerFlags:
        lea.l   (ObjectTable).l,a0              ; 00768
        bclr    #$0,$21(a0)                     ; 0076E
        move.b  #$d,obj_Weapon(a0)              ; 00774
        jsr     (ResetPlayerAircraft).l         ; 0077A
        move.w  #$148,obj_Flags(a0)             ; 00780
        ori.w   #$1080,obj_Flags(a0)            ; 00786
        move.w  #$1400,obj_PilotTimer(a0)       ; 0078C
        clr.b   (FlashCount).l                  ; 00792
        clr.b   (NewAircraftReady).l            ; 00798
        clr.b   (PlayerFlag283).l               ; 0079E
        clr.b   (PlayerFlag281).l               ; 007A4
        clr.b   (CrashKind).l                   ; 007AA
        clr.b   (VisualConfirmTimer).l          ; 007B0
        clr.b   (JToggle).l                     ; 007B6
        move.w  #$7fff,(ObjectDistanceSound).l  ; 007BC
        move.b  #$1,(MouseActive).l             ; 007C4
        move.b  #$ff,$71(a0)                    ; 007CC
        move.w  #$ffff,(LockedTarget).l         ; 007D2
        clr.b   (RadarLockState).l              ; 007DA
        tst.b   (MissionResult).l               ; 007E0
        beq.b   l_004_007F0                     ; 007E6
        move.b  #$4,(MissionResult).l           ; 007E8
l_004_007F0:
        rts                                     ; 007F0
	dc.b	$00,$00
h004_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    1,80                            ; 1 longs pointing into hunk 80
	dc.l	$2E
        dc.l    120,71                          ; 120 longs pointing into hunk 71
	dc.l	$3E4,$3DE,$4D4,$4E6,$4E0,$30A,$322,$1E4
	dc.l	$1D4,$1CE,$8E,$1B4,$1AC,$1A4,$19C,$156
	dc.l	$166,$15E,$194,$75A,$754,$74E,$748,$17A
	dc.l	$7D6,$7DC,$7B2,$7A6,$174,$16E,$182,$18A
	dc.l	$7A0,$A2,$3A2,$3AA,$39A,$394,$14E,$146
	dc.l	$132,$138,$13E,$2A4,$2AA,$2B0,$2C8,$2CE
	dc.l	$2D4,$2EA,$7B8,$480,$7C0,$762,$79A,$794
	dc.l	$410,$40A,$7C8,$112,$4DA,$10A,$4F2,$5F6
	dc.l	$3FA,$DA,$402,$43A,$47A,$486,$600,$678
	dc.l	$70A,$76A,$C0,$304,$31C,$334,$12,$78
	dc.l	$C,$20,$7C,$12C,$418,$102,$FA,$54C
	dc.l	$536,$50E,$53C,$508,$522,$7AC,$310,$5AA
	dc.l	$5B4,$5A4,$B4,$7E2,$7EC,$9C,$AA,$96
	dc.l	$3EC,$68,$424,$60,$40,$58,$50,$48
	dc.l	$3A,$242,$23C,$228,$222,$212,$20C,$620
        dc.l    13,73                           ; 13 longs pointing into hunk 73
	dc.l	$3D2,$3D8,$3BE,$3BA,$3CE,$3C8,$3B4,$3B0
	dc.l	$3C4,$1BA,$88,$82,$11A
        dc.l    2,2                             ; 2 longs pointing into hunk 2
	dc.l	$2,$1A
        dc.l    1,10                            ; 1 longs pointing into hunk 10
	dc.l	$446
        dc.l    4,16                            ; 4 longs pointing into hunk 16
	dc.l	$41E,$44E,$454,$606
        dc.l    1,36                            ; 1 longs pointing into hunk 36
	dc.l	$BA
        dc.l    2,32                            ; 2 longs pointing into hunk 32
	dc.l	$702,$2FA
        dc.l    5,8                             ; 5 longs pointing into hunk 8
	dc.l	$204,$1FE,$518,$560,$1F8
        dc.l    1,6                             ; 1 longs pointing into hunk 6
	dc.l	$77C
        dc.l    1,67                            ; 1 longs pointing into hunk 67
	dc.l	$4EC
        dc.l    1,7                             ; 1 longs pointing into hunk 7
	dc.l	$626
	dc.l	0
	dc.l	HUNK_END
	endc
