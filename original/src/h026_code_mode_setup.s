; F/A-18 Interceptor - hunk 26 (code)
; Setting up a mode (SetupMode) and the camera's opening moves (FlyBySetup); more not identified.
; Included by ../f18_main.s.

;===============================================================================
; Hunk 26: CODE, $EB4 bytes
;===============================================================================
	CODE_HUNK	h026
l_026_00000:
        rts                                     ; 00000

;-------------------------------------------------------------------------------
; SetupMode - Sets up the world for GameMode (StateFlightSetup, DemoSetup): the date
; (ShowLogDate), then from the mode's entry in hunk 27's table (ModeTable; the demo uses
; the entry of mode 10) MissionTargets and the list of objects to place (ModeObjects).
;-------------------------------------------------------------------------------
SetupMode:
        jsr     (ShowLogDate).l                 ; 00002
        clr.b   (dat_071_00279).l               ; 00008
        clr.b   (MissionTargetsDone).l          ; 0000E
        clr.w   (EscortTimer).l                 ; 00014
        move.b  (GameMode).l,d0                 ; 0001A
        ext.w   d0                              ; 00020
        cmpi.b  #$7d,d0                         ; 00022
        beq.w   l_026_001A6                     ; 00026
        cmpi.b  #$7e,d0                         ; 0002A
        beq.b   l_026_00036                     ; 0002E
        cmpi.b  #$7f,d0                         ; 00030
        bne.b   l_026_0003A                     ; 00034
l_026_00036:
        moveq   #$a,d0                          ; 00036
        bra.b   l_026_00040                     ; 00038
l_026_0003A:
        cmpi.w  #$9,d0                          ; 0003A
        bgt.b   l_026_00000                     ; 0003E
l_026_00040:
        lea.l   (ModeTable).l,a0                ; 00040
        subq.w  #$1,d0                          ; 00046
        add.w   d0,d0                           ; 00048
        move.w  d0,d1                           ; 0004A
        add.w   d0,d0                           ; 0004C
        add.w   d1,d0                           ; 0004E
        add.w   d0,d0                           ; 00050
        tst.b   (RestartMission).l              ; 00052
        beq.b   l_026_00062                     ; 00058
        move.w  (ModeVariant).l,d1              ; 0005A
        bra.b   l_026_00076                     ; 00060
l_026_00062:
        move.w  (dat_071_004C8).l,d1            ; 00062
        andi.w  #$3,d1                          ; 00068
        beq.b   l_026_00076                     ; 0006C
        subq.w  #$1,d1                          ; 0006E
        move.w  d1,(ModeVariant).l              ; 00070
l_026_00076:
        add.w   d1,d1                           ; 00076
        add.w   d1,d1                           ; 00078
        add.w   d1,d0                           ; 0007A
        lea.l   (a0),a2                         ; 0007C
        adda.w  (a0,d0.w),a2                    ; 0007E
        move.w  $2(a0,d0.w),d0                  ; 00082
        move.b  d0,(MissionTargets).l           ; 00086
        bsr.w   TimesCompleted                  ; 0008C
        adda.w  (a2,d0.w),a2                    ; 00090
        move.l  a2,(ModeObjects).l              ; 00094
l_026_0009A:
        bsr.w   PlaceObject                     ; 0009A
l_026_0009E:
        adda.w  #$a,a2                          ; 0009E
        tst.w   (a2)                            ; 000A2
        blt.b   l_026_000B8                     ; 000A4
        move.w  $8(a2),d0                       ; 000A6
        andi.w  #$7f,d0                         ; 000AA
        cmp.b   (Difficulty).l,d0               ; 000AE
        ble.b   l_026_0009A                     ; 000B4
        bra.b   l_026_0009E                     ; 000B6
l_026_000B8:
        rts                                     ; 000B8

;-------------------------------------------------------------------------------
; TimesCompleted - Returns twice the times the current mission was completed
; (ConfigBuffer+$12+GameMode; 0 for the demo): later flights of a mission get a harder object
; list.
;-------------------------------------------------------------------------------
TimesCompleted:
        moveq   #$0,d0                          ; 000BA
        move.b  (GameMode).l,d1                 ; 000BC
        cmpi.b  #$7e,d1                         ; 000C2
        beq.b   l_026_000DE                     ; 000C6
        cmpi.b  #$7f,d1                         ; 000C8
        beq.b   l_026_000DE                     ; 000CC
        ext.w   d1                              ; 000CE
        movea.l (ConfigBuffer).l,a0             ; 000D0
        move.b  $12(a0,d1.w),d0                 ; 000D6
        ext.w   d0                              ; 000DA
        add.w   d0,d0                           ; 000DC
l_026_000DE:
        rts                                     ; 000DE

;-------------------------------------------------------------------------------
; AimObject - Points a placed object: at the first waypoint of a route, or at another object
; (its destination copied, +$38 = $80 + that object), turning it to face it (VectorToAngles,
; SetAttitude).
;-------------------------------------------------------------------------------
AimObject:
        move.l  a2,-(a7)                        ; 000E0
        move.w  $4(a2),d1                       ; 000E2
        bge.b   l_026_0011E                     ; 000E6
        andi.w  #$7f00,d1                       ; 000E8
        beq.w   l_026_001A2                     ; 000EC
        asr.w   #$7,d1                          ; 000F0
        lea.l   (Routes).l,a4                   ; 000F2
        adda.w  (a4,d1.w),a4                    ; 000F8
        movem.w (a4)+,d2-d6                     ; 000FC
        bsr.w   SetDestination                  ; 00100
        move.b  #$ff,$38(a0)                    ; 00104
        swap    d2                              ; 0010A
        swap    d3                              ; 0010C
        asl.l   #$6,d2                          ; 0010E
        asl.l   #$6,d3                          ; 00110
        asl.l   #$8,d4                          ; 00112
        asl.l   #$8,d5                          ; 00114
        add.l   d4,d2                           ; 00116
        add.l   d5,d3                           ; 00118
        move.l  d3,d4                           ; 0011A
        bra.b   l_026_00168                     ; 0011C
l_026_0011E:
        lea.l   (ObjectTable).l,a1              ; 0011E
        andi.w  #$ff00,d1                       ; 00124
        move.w  d1,d2                           ; 00128
        add.w   d1,d1                           ; 0012A
        adda.w  d1,a1                           ; 0012C
        move.w  $0(a1),d1                       ; 0012E
        andi.w  #$40,d1                         ; 00132
        beq.b   l_026_001A2                     ; 00136
        move.w  $6(a1),$2c(a0)                  ; 00138
        move.w  $8(a1),$2e(a0)                  ; 0013E
        move.w  $c(a1),$30(a0)                  ; 00144
        move.w  $e(a1),$32(a0)                  ; 0014A
        move.l  $10(a1),$34(a0)                 ; 00150
        lsr.w   #$8,d2                          ; 00156
        ori.b   #$80,d2                         ; 00158
        move.b  d2,$38(a0)                      ; 0015C
        move.l  $14(a1),d2                      ; 00160
        move.l  $1c(a1),d4                      ; 00164
l_026_00168:
        sub.l   $14(a0),d2                      ; 00168
        sub.l   $1c(a0),d4                      ; 0016C
        moveq   #$0,d3                          ; 00170
        moveq   #-1,d5                          ; 00172
        moveq   #$0,d0                          ; 00174
        moveq   #$0,d1                          ; 00176
        move.l  a0,-(a7)                        ; 00178
        movem.l d0-d5,-(a7)                     ; 0017A
        jsr     (VectorToAngles).l              ; 0017E
        adda.w  #$18,a7                         ; 00184
        movea.l (a7)+,a0                        ; 00188
        moveq   #$0,d0                          ; 0018A
        move.w  (TargetHeading).l,d2            ; 0018C
        moveq   #$0,d4                          ; 00192
        move.w  d0,d4                           ; 00194
        move.w  d2,d5                           ; 00196
        move.w  d4,d6                           ; 00198
        lea.l   (a0),a1                         ; 0019A
        jsr     (SetAttitude).l                 ; 0019C
l_026_001A2:
        movea.l (a7)+,a2                        ; 001A2
        rts                                     ; 001A4
l_026_001A6:
        move.w  #$4,(CurrentObject).l           ; 001A6
        lea.l   (ObjectTable).l,a4              ; 001AE
        lea.l   (a4),a5                         ; 001B4
        move.w  (CurrentObject).l,d0            ; 001B6
        asl.w   #$8,d0                          ; 001BC
        add.w   d0,d0                           ; 001BE
        move.w  d0,(CurrentObjectOffset).l      ; 001C0
        adda.w  d0,a5                           ; 001C6
        moveq   #$3f,d0                         ; 001C8
l_026_001CA:
        move.l  (a4)+,(a5)+                     ; 001CA
        dbra    d0,l_026_001CA                  ; 001CC
        lea.l   (ModelTable).l,a0               ; 001D0
        move.w  #$3c,d0                         ; 001D6
        adda.w  d0,a0                           ; 001DA
        movem.l (a0),d0-d4                      ; 001DC
        lea.l   (ObjectDrawTable).l,a4          ; 001E0
        move.w  (CurrentObject).l,d6            ; 001E6
        add.w   d6,d6                           ; 001EC
        add.w   d6,d6                           ; 001EE
        move.w  d6,d7                           ; 001F0
        add.w   d6,d6                           ; 001F2
        add.w   d6,d6                           ; 001F4
        add.w   d7,d6                           ; 001F6
        movem.l d0-d4,(a4,d6.w)                 ; 001F8
        moveq   #$0,d3                          ; 001FE
        moveq   #$0,d4                          ; 00200
        move.w  #$48,d5                         ; 00202
        jsr     (TurnByPanelMatrix).l           ; 00206
        lea.l   (ObjectTable).l,a1              ; 0020C
        adda.w  (CurrentObjectOffset).l,a1      ; 00212
        move.b  #$10,$62(a1)                    ; 00218
        movem.l d0-d2,$14(a1)                   ; 0021E
        swap    d0                              ; 00224
        swap    d2                              ; 00226
        lsr.w   #$6,d0                          ; 00228
        lsr.w   #$6,d2                          ; 0022A
        move.w  d0,$6(a1)                       ; 0022C
        move.w  d2,$8(a1)                       ; 00230
        andi.w  #$3,d0                          ; 00234
        subq.w  #$3,d0                          ; 00238
        neg.w   d0                              ; 0023A
        andi.w  #$3,d2                          ; 0023C
        subq.w  #$3,d2                          ; 00240
        neg.w   d2                              ; 00242
        asl.w   #$2,d2                          ; 00244
        add.w   d0,d2                           ; 00246
        move.b  d2,$a(a1)                       ; 00248
        move.b  #$1,$5d(a1)                     ; 0024C
        move.w  #$ffff,$2c(a1)                  ; 00252
        clr.b   $5(a1)                          ; 00258
        move.w  (CurrentObject).l,d0            ; 0025C
        move.b  d0,$5e(a1)                      ; 00262
        clr.b   (dat_073_01658).l               ; 00266
        clr.b   (dat_073_01659).l               ; 0026C
        rts                                     ; 00272
l_026_00274:
        rts                                     ; 00274

;-------------------------------------------------------------------------------
; CheckZones - Each frame (not in the demo): for the eight zones of the map (Zones: rectangles
; of map cells), when the player is inside one, places its objects (PlaceZoneObjects) - the
; first time noted in ZonesEntered.
;-------------------------------------------------------------------------------
CheckZones:
        tst.b   (DemoActive).l                  ; 00276
        bne.b   l_026_00274                     ; 0027C
        lea.l   (Zones).l,a3                    ; 0027E
        moveq   #$0,d7                          ; 00284
l_026_00286:
        tst.w   (a3)                            ; 00286
        blt.b   l_026_00274                     ; 00288
        movem.w (PlayerCellX).l,d5-d6           ; 0028A
        btst    d7,(ZonesEntered).l             ; 00292
        bne.b   l_026_002BC                     ; 00298
        movea.l (a3),a2                         ; 0029A
        movem.w (a2)+,d1-d4                     ; 0029C
        cmp.w   d1,d5                           ; 002A0
        blt.b   l_026_002D6                     ; 002A2
        cmp.w   d2,d5                           ; 002A4
        bgt.b   l_026_002D6                     ; 002A6
        cmp.w   d3,d6                           ; 002A8
        blt.b   l_026_002D6                     ; 002AA
        cmp.w   d4,d6                           ; 002AC
        bgt.b   l_026_002D6                     ; 002AE
        bset    d7,(ZonesEntered).l             ; 002B0
        bsr.w   PlaceZoneObjects                ; 002B6
        bra.b   l_026_002D6                     ; 002BA
l_026_002BC:
        movea.l (a3),a2                         ; 002BC
        movem.w (a2)+,d1-d4                     ; 002BE
        cmp.w   d1,d5                           ; 002C2
        blt.b   l_026_002E2                     ; 002C4
        cmp.w   d2,d5                           ; 002C6
        bgt.b   l_026_002E2                     ; 002C8
        cmp.w   d3,d6                           ; 002CA
        blt.b   l_026_002E2                     ; 002CC
        cmp.w   d4,d6                           ; 002CE
        bgt.b   l_026_002E2                     ; 002D0
        bsr.w   PlaceZoneObjects                ; 002D2
l_026_002D6:
        addq.w  #$4,a3                          ; 002D6
        addq.w  #$1,d7                          ; 002D8
        cmpi.w  #$8,d7                          ; 002DA
        blt.b   l_026_00286                     ; 002DE
        rts                                     ; 002E0
l_026_002E2:
        bclr    d7,(ZonesEntered).l             ; 002E2
        move.w  (a2)+,d0                        ; 002E8
        subq.w  #$1,d0                          ; 002EA
        blt.b   l_026_002D6                     ; 002EC
l_026_002EE:
        lea.l   (ObjectTable).l,a0              ; 002EE
        addq.w  #$4,a2                          ; 002F4
        move.w  (a2)+,d1                        ; 002F6
        move.w  (a2)+,d2                        ; 002F8
        addq.w  #$2,a2                          ; 002FA
        lea.l   (Routes).l,a4                   ; 002FC
        adda.w  (a4,d2.w),a4                    ; 00302
        movem.w (a4)+,d2-d5                     ; 00306
        move.w  d1,d6                           ; 0030A
        andi.w  #$7f,d1                         ; 0030C
        asl.w   #$8,d1                          ; 00310
        add.w   d1,d1                           ; 00312
        adda.w  d1,a0                           ; 00314
        move.b  $38(a0),d1                      ; 00316
        bge.b   l_026_00324                     ; 0031A
        andi.b  #$7f,d1                         ; 0031C
        bne.w   l_026_003D4                     ; 00320
l_026_00324:
        move.w  d6,d1                           ; 00324
        andi.w  #$ff00,d1                       ; 00326
        bne.b   l_026_0035A                     ; 0032A
l_026_0032C:
        cmpi.b  #$3,$7a(a0)                     ; 0032C
        beq.b   l_026_0033C                     ; 00332
        cmpi.b  #$4,$7a(a0)                     ; 00334
        bne.b   l_026_00342                     ; 0033A
l_026_0033C:
        move.b  #$5,$7a(a0)                     ; 0033C
l_026_00342:
        move.w  (a4)+,d6                        ; 00342
        ext.l   d6                              ; 00344
        bsr.w   SetDestination                  ; 00346
        move.b  #$80,$38(a0)                    ; 0034A
        andi.w  #$fffe,$0(a0)                   ; 00350
        bra.w   l_026_003D6                     ; 00356
l_026_0035A:
        tst.w   d6                              ; 0035A
        bge.b   l_026_00386                     ; 0035C
        andi.w  #$7f00,d6                       ; 0035E
        beq.b   l_026_003D6                     ; 00362
        asr.w   #$7,d6                          ; 00364
        lea.l   (Routes).l,a4                   ; 00366
        adda.w  (a4,d6.w),a4                    ; 0036C
        movem.w (a4)+,d2-d6                     ; 00370
        bsr.w   SetDestination                  ; 00374
        move.b  #$ff,$38(a0)                    ; 00378
        andi.w  #$fffe,$0(a0)                   ; 0037E
        bra.b   l_026_003CE                     ; 00384
l_026_00386:
        lea.l   (ObjectTable).l,a1              ; 00386
        andi.w  #$ff00,d6                       ; 0038C
        move.w  d6,d5                           ; 00390
        add.w   d6,d6                           ; 00392
        adda.w  d6,a1                           ; 00394
        move.w  $0(a1),d1                       ; 00396
        andi.w  #$40,d1                         ; 0039A
        beq.b   l_026_0032C                     ; 0039E
        move.w  $6(a1),$2c(a0)                  ; 003A0
        move.w  $8(a1),$2e(a0)                  ; 003A6
        move.w  $c(a1),$30(a0)                  ; 003AC
        move.w  $e(a1),$32(a0)                  ; 003B2
        move.l  $10(a1),$34(a0)                 ; 003B8
        andi.w  #$fffe,$0(a0)                   ; 003BE
        lsr.w   #$8,d5                          ; 003C4
        ori.b   #$80,d5                         ; 003C6
        move.b  d5,$38(a0)                      ; 003CA
l_026_003CE:
        move.b  #$3,$7a(a0)                     ; 003CE
l_026_003D4:
        nop                                     ; 003D4
l_026_003D6:
        dbra    d0,l_026_002EE                  ; 003D6
        bra.w   l_026_002D6                     ; 003DA

;-------------------------------------------------------------------------------
; PlaceObject - PlaceObject(a2 = a 10-byte record): puts the object into ObjectTable with its
; model, unless it is already there or the mode does not want it, and aims it (AimObject).
;-------------------------------------------------------------------------------
PlaceObject:
        moveq   #$0,d0                          ; 003DE
        moveq   #-2,d7                          ; 003E0
        move.l  a2,-(a7)                        ; 003E2
        bsr.w   PlaceObjectList                 ; 003E4
        movea.l (a7)+,a2                        ; 003E8
        tst.w   d7                              ; 003EA
        blt.b   l_026_003F2                     ; 003EC
        bsr.w   AimObject                       ; 003EE
l_026_003F2:
        rts                                     ; 003F2
l_026_003F4:
        rts                                     ; 003F4

;-------------------------------------------------------------------------------
; PlaceZoneObjects - Places a zone's objects (from its list, after the rectangle), in the
; missions only (not free flight, the training demo or practice).
;-------------------------------------------------------------------------------
PlaceZoneObjects:
        move.b  (GameMode).l,d0                 ; 003F6
        cmpi.b  #$2,d0                          ; 003FC
        ble.b   l_026_003F4                     ; 00400
        cmpi.b  #$7d,d0                         ; 00402
        beq.b   l_026_003F4                     ; 00406
        movea.l (a3),a2                         ; 00408
        addq.w  #$8,a2                          ; 0040A
        move.w  (a2)+,d0                        ; 0040C
        subq.w  #$1,d0                          ; 0040E
        blt.w   l_026_006F2                     ; 00410

;-------------------------------------------------------------------------------
; PlaceObjectList - Places the objects of a list (each a ModelTable offset and its data;
; entries for another GameMode skipped), as PlaceObject does for one.
;-------------------------------------------------------------------------------
PlaceObjectList:
        lea.l   (ModelTable).l,a1               ; 00414
        adda.w  (a2)+,a1                        ; 0041A
        swap    d0                              ; 0041C
        move.w  (a2)+,d0                        ; 0041E
        move.w  $4(a2),d3                       ; 00420
        andi.w  #$f00,d3                        ; 00424
        beq.b   l_026_00436                     ; 00428
        lsr.w   #$8,d3                          ; 0042A
        cmp.b   (GameMode).l,d3                 ; 0042C
        bne.w   l_026_004C6                     ; 00432
l_026_00436:
        move.w  (a2),d3                         ; 00436
        andi.w  #$7f,d3                         ; 00438
        move.w  d3,d1                           ; 0043C
        lea.l   (ObjectTable).l,a4              ; 0043E
        asl.w   #$8,d3                          ; 00444
        add.w   d3,d3                           ; 00446
        adda.w  d3,a4                           ; 00448
        btst    #$6,$1(a4)                      ; 0044A
        bne.b   l_026_004C6                     ; 00450
        move.w  d1,d3                           ; 00452
        lea.l   (ObjectDrawTable).l,a0          ; 00454
        add.w   d3,d3                           ; 0045A
        add.w   d3,d3                           ; 0045C
        move.w  d3,d4                           ; 0045E
        add.w   d3,d3                           ; 00460
        add.w   d3,d3                           ; 00462
        add.w   d4,d3                           ; 00464
        adda.w  d3,a0                           ; 00466
        movem.l (a1),d2-d6                      ; 00468
        movem.l d2-d6,(a0)                      ; 0046C
        movea.l $4(a0),a1                       ; 00470
        move.w  (a1),d2                         ; 00474
        blt.b   l_026_00488                     ; 00476
        andi.w  #$4000,d2                       ; 00478
        beq.b   l_026_00484                     ; 0047C
        move.w  $2(a1),d2                       ; 0047E
        bra.b   l_026_00488                     ; 00482
l_026_00484:
        move.w  $4(a1),d2                       ; 00484
l_026_00488:
        andi.w  #$fff,d2                        ; 00488
        move.b  $6(a1,d2.w),d4                  ; 0048C
        andi.b  #$f,d4                          ; 00490
        lea.l   (ObjectTable).l,a0              ; 00494
        move.w  d1,d3                           ; 0049A
        asl.w   #$8,d3                          ; 0049C
        add.w   d3,d3                           ; 0049E
        adda.w  d3,a0                           ; 004A0
        move.b  (MissionTargets).l,d3           ; 004A2
        cmp.b   (dat_071_00279).l,d3            ; 004A8
        ble.b   l_026_004C6                     ; 004AE
        cmpi.b  #$15,$62(a0)                    ; 004B0
        bne.b   l_026_004BE                     ; 004B6
        tst.w   $6(a0)                          ; 004B8
        bne.b   l_026_004C6                     ; 004BC
l_026_004BE:
        btst    #$6,$1(a0)                      ; 004BE
        beq.b   l_026_004CE                     ; 004C4
l_026_004C6:
        addq.w  #$6,a2                          ; 004C6
        swap    d0                              ; 004C8
        bra.w   l_026_006EA                     ; 004CA
l_026_004CE:
        lea.l   (a4),a0                         ; 004CE
        moveq   #$28,d3                         ; 004D0
        lea.l   (a0),a1                         ; 004D2
l_026_004D4:
        clr.l   (a1)+                           ; 004D4
        dbra    d3,l_026_004D4                  ; 004D6
        move.b  $7d(a0),d2                      ; 004DA
        andi.b  #$f0,d2                         ; 004DE
        or.b    d4,d2                           ; 004E2
        move.b  d2,$7d(a0)                      ; 004E4
        move.b  d0,$62(a0)                      ; 004E8
        swap    d0                              ; 004EC
        move.b  d1,$5e(a0)                      ; 004EE
        move.w  (a2)+,d1                        ; 004F2
        move.w  d1,d2                           ; 004F4
        andi.w  #$7f00,d2                       ; 004F6
        lsr.w   #$8,d2                          ; 004FA
        move.b  d2,$3a(a0)                      ; 004FC
        move.w  (a2)+,d2                        ; 00500
        lea.l   (Routes).l,a4                   ; 00502
        adda.w  (a4,d2.w),a4                    ; 00508
        move.w  (a2)+,d2                        ; 0050C
        move.w  d2,d3                           ; 0050E
        andi.w  #$8000,d2                       ; 00510
        bne.b   l_026_00532                     ; 00514
        bclr    #$3,$1(a0)                      ; 00516
        move.b  $62(a0),d2                      ; 0051C
        andi.b  #$f0,d2                         ; 00520
        cmpi.b  #$10,d2                         ; 00524
        bne.b   l_026_00538                     ; 00528
        addq.b  #$1,(dat_071_00279).l           ; 0052A
        bra.b   l_026_00538                     ; 00530
l_026_00532:
        bset    #$3,$1(a0)                      ; 00532
l_026_00538:
        move.w  d3,d2                           ; 00538
        andi.w  #$4000,d3                       ; 0053A
        beq.b   l_026_00546                     ; 0053E
        move.b  #$8,$5(a0)                      ; 00540
l_026_00546:
        swap    d1                              ; 00546
        move.w  d2,d1                           ; 00548
        andi.w  #$2000,d2                       ; 0054A
        beq.b   l_026_00556                     ; 0054E
        bset    #$0,$1(a0)                      ; 00550
l_026_00556:
        movem.w (a4)+,d2-d6                     ; 00556
        swap    d0                              ; 0055A
        move.w  d1,d0                           ; 0055C
        andi.w  #$1000,d1                       ; 0055E
        beq.b   l_026_005DC                     ; 00562
        tst.b   (RestartMission).l              ; 00564
        beq.b   l_026_0058E                     ; 0056A
        swap    d4                              ; 0056C
        move.w  d0,d4                           ; 0056E
        move.w  (dat_071_004E8).l,d0            ; 00570
        move.w  (dat_071_004EA).l,d1            ; 00576
        andi.w  #$80,d4                         ; 0057C
        beq.b   l_026_00586                     ; 00580
        asr.w   #$1,d0                          ; 00582
        asr.w   #$1,d1                          ; 00584
l_026_00586:
        add.w   d0,d2                           ; 00586
        add.w   d1,d3                           ; 00588
        swap    d4                              ; 0058A
        bra.b   l_026_005DC                     ; 0058C
l_026_0058E:
        move.w  (dat_071_004C8).l,d1            ; 0058E
        lsr.w   #$1,d1                          ; 00594
        andi.w  #$3,d1                          ; 00596
        btst    #$4,(dat_071_004C9).l           ; 0059A
        beq.b   l_026_005A6                     ; 005A2
        neg.w   d1                              ; 005A4
l_026_005A6:
        move.w  d1,(dat_071_004E8).l            ; 005A6
        andi.w  #$80,d0                         ; 005AC
        beq.b   l_026_005B4                     ; 005B0
        asr.w   #$1,d1                          ; 005B2
l_026_005B4:
        add.w   d1,d2                           ; 005B4
        move.w  (dat_071_004C8).l,d1            ; 005B6
        lsr.w   #$2,d1                          ; 005BC
        andi.w  #$3,d1                          ; 005BE
        btst    #$5,(dat_071_004C9).l           ; 005C2
        beq.b   l_026_005CE                     ; 005CA
        neg.w   d1                              ; 005CC
l_026_005CE:
        move.w  d1,(dat_071_004EA).l            ; 005CE
        tst.w   d0                              ; 005D4
        beq.b   l_026_005DA                     ; 005D6
        asr.w   #$1,d1                          ; 005D8
l_026_005DA:
        add.w   d1,d3                           ; 005DA
l_026_005DC:
        swap    d1                              ; 005DC
        swap    d0                              ; 005DE
        addq.b  #$1,d7                          ; 005E0
        move.b  d7,$5d(a0)                      ; 005E2
        move.b  #$3,$7a(a0)                     ; 005E6
        move.b  $62(a0),d7                      ; 005EC
        andi.b  #$f0,d7                         ; 005F0
        cmpi.b  #$20,d7                         ; 005F4
        beq.b   l_026_00600                     ; 005F8
        ori.w   #$1080,$0(a0)                   ; 005FA
l_026_00600:
        tst.w   d1                              ; 00600
        bge.b   l_026_00634                     ; 00602
        andi.w  #$7f00,d1                       ; 00604
        beq.b   l_026_0062E                     ; 00608
        asr.w   #$7,d1                          ; 0060A
        lea.l   (Routes).l,a4                   ; 0060C
        adda.w  (a4,d1.w),a4                    ; 00612
        move.w  (a4)+,$2c(a0)                   ; 00616
        move.w  (a4)+,$2e(a0)                   ; 0061A
        move.w  (a4)+,$30(a0)                   ; 0061E
        move.w  (a4)+,$32(a0)                   ; 00622
        move.w  (a4),d1                         ; 00626
        ext.l   d1                              ; 00628
        move.l  d1,$34(a0)                      ; 0062A
l_026_0062E:
        move.b  #$ff,d1                         ; 0062E
        bra.b   l_026_0063E                     ; 00632
l_026_00634:
        bsr.w   SetDestination                  ; 00634
        lsr.w   #$8,d1                          ; 00638
        ori.b   #$80,d1                         ; 0063A
l_026_0063E:
        move.b  d1,$38(a0)                      ; 0063E
        move.w  d2,$6(a0)                       ; 00642
        move.w  d3,$8(a0)                       ; 00646
        move.w  d4,$c(a0)                       ; 0064A
        move.w  d5,$e(a0)                       ; 0064E
        move.l  d6,$10(a0)                      ; 00652
        ext.l   d4                              ; 00656
        ext.l   d5                              ; 00658
        asl.l   #$8,d4                          ; 0065A
        asl.l   #$8,d6                          ; 0065C
        asl.l   #$8,d5                          ; 0065E
        tst.l   d6                              ; 00660
        beq.b   l_026_0067C                     ; 00662
        bset    #$7,$7c(a0)                     ; 00664
        ori.b   #$60,$7c(a0)                    ; 0066A
        move.w  #$2000,$6c(a0)                  ; 00670
        move.w  #$2000,$6e(a0)                  ; 00676
l_026_0067C:
        ori.w   #$140,$0(a0)                    ; 0067C
        andi.w  #$7fff,$0(a0)                   ; 00682
        move.b  #$44,$5f(a0)                    ; 00688
        move.w  #$1f4,$60(a0)                   ; 0068E
        move.l  #$61a800,$72(a0)                ; 00694
        move.b  #$3d,$63(a0)                    ; 0069C
        move.b  #$ff,$71(a0)                    ; 006A2
        move.b  #$6,$64(a0)                     ; 006A8
        move.b  #$10,$64(a0)                    ; 006AE
        ext.l   d2                              ; 006B4
        ext.l   d3                              ; 006B6
        swap    d2                              ; 006B8
        swap    d3                              ; 006BA
        asl.l   #$6,d2                          ; 006BC
        asl.l   #$6,d3                          ; 006BE
        add.l   d4,d2                           ; 006C0
        add.l   d5,d3                           ; 006C2
        move.l  d2,$14(a0)                      ; 006C4
        move.l  d6,$18(a0)                      ; 006C8
        move.l  d3,$1c(a0)                      ; 006CC
        moveq   #$0,d4                          ; 006D0
        moveq   #$0,d5                          ; 006D2
        moveq   #$0,d6                          ; 006D4
        lea.l   (a0),a1                         ; 006D6
        movem.l d0/a0/a2,-(a7)                  ; 006D8
        jsr     (SetAttitude).l                 ; 006DC
        movem.l (a7)+,d0/a0/a2                  ; 006E2
        moveq   #$0,d7                          ; 006E6
        bra.b   l_026_006EC                     ; 006E8
l_026_006EA:
        moveq   #-1,d7                          ; 006EA
l_026_006EC:
        dbra    d0,PlaceObjectList              ; 006EC
        rts                                     ; 006F0
l_026_006F2:
        moveq   #-1,d7                          ; 006F2
        rts                                     ; 006F4
l_026_006F6:
        move.w  #$1e,(DebugCheckpoint).l        ; 006F6
        jsr     (Nop).l                         ; 006FE
        rts                                     ; 00704
l_026_00706:
        rts                                     ; 00706

;-------------------------------------------------------------------------------
; KeepInZone - For a computer aircraft (type $1x, not landing) that belongs to a zone (+$5D):
; when it has left its zone's rectangle, it is turned back (a new destination, SetDestination).
;-------------------------------------------------------------------------------
KeepInZone:
        lea.l   (ObjectTable).l,a0              ; 00708
        move.w  (CurrentObject).l,d0            ; 0070E
        asl.w   #$8,d0                          ; 00714
        add.w   d0,d0                           ; 00716
        beq.b   l_026_00706                     ; 00718
        adda.w  d0,a0                           ; 0071A
        move.b  $62(a0),d5                      ; 0071C
        andi.b  #$f0,d5                         ; 00720
        cmpi.b  #$10,d5                         ; 00724
        bne.b   l_026_00706                     ; 00728
        cmpi.b  #$8,$5(a0)                      ; 0072A
        beq.b   l_026_00706                     ; 00730
        move.b  $5d(a0),d0                      ; 00732
        blt.b   l_026_00706                     ; 00736
        subq.b  #$1,d0                          ; 00738
        blt.b   l_026_006F6                     ; 0073A
        ext.w   d0                              ; 0073C
        add.w   d0,d0                           ; 0073E
        add.w   d0,d0                           ; 00740
        move.w  $6(a0),d5                       ; 00742
        move.w  $8(a0),d6                       ; 00746
        lea.l   (Zones).l,a3                    ; 0074A
        adda.w  d0,a3                           ; 00750
        movea.l (a3),a3                         ; 00752
        movem.w (a3)+,d1-d4                     ; 00754
        cmp.w   d1,d5                           ; 00758
        blt.b   l_026_007A0                     ; 0075A
        cmp.w   d2,d5                           ; 0075C
        bgt.b   l_026_007A0                     ; 0075E
        cmp.w   d3,d6                           ; 00760
        blt.b   l_026_007A0                     ; 00762
        cmp.w   d4,d6                           ; 00764
        bgt.b   l_026_007A0                     ; 00766
        cmpi.b  #$5,$7a(a0)                     ; 00768
        bne.b   l_026_0079E                     ; 0076E
        move.w  (a3)+,d0                        ; 00770
        subq.w  #$1,d0                          ; 00772
        blt.b   l_026_0079C                     ; 00774
l_026_00776:
        addq.w  #$4,a3                          ; 00776
        move.w  (a3)+,d1                        ; 00778
        move.w  (a3)+,d2                        ; 0077A
        addq.w  #$2,a3                          ; 0077C
        lea.l   (Routes).l,a4                   ; 0077E
        adda.w  (a4,d2.w),a4                    ; 00784
        movem.w (a4)+,d2-d6                     ; 00788
        andi.w  #$7f,d1                         ; 0078C
        cmp.w   (CurrentObject).l,d1            ; 00790
        beq.b   l_026_0079E                     ; 00796
        dbra    d0,l_026_00776                  ; 00798
l_026_0079C:
        rts                                     ; 0079C
l_026_0079E:
        rts                                     ; 0079E
l_026_007A0:
        move.w  (a3)+,d0                        ; 007A0
        subq.w  #$1,d0                          ; 007A2
        blt.b   l_026_007EE                     ; 007A4
l_026_007A6:
        addq.w  #$4,a3                          ; 007A6
        move.w  (a3)+,d1                        ; 007A8
        move.w  (a3)+,d2                        ; 007AA
        addq.w  #$2,a3                          ; 007AC
        lea.l   (Routes).l,a4                   ; 007AE
        adda.w  (a4,d2.w),a4                    ; 007B4
        movem.w (a4)+,d2-d6                     ; 007B8
        andi.w  #$7f,d1                         ; 007BC
        cmp.w   (CurrentObject).l,d1            ; 007C0
        bne.b   l_026_007F0                     ; 007C6
        cmpi.b  #$3,$7a(a0)                     ; 007C8
        beq.b   l_026_007D8                     ; 007CE
        cmpi.b  #$4,$7a(a0)                     ; 007D0
        bne.b   l_026_007DE                     ; 007D6
l_026_007D8:
        move.b  #$5,$7a(a0)                     ; 007D8
l_026_007DE:
        andi.w  #$fffe,$0(a0)                   ; 007DE
        bsr.w   SetDestination                  ; 007E4
        move.b  #$ff,$38(a0)                    ; 007E8
l_026_007EE:
        rts                                     ; 007EE
l_026_007F0:
        dbra    d0,l_026_007A6                  ; 007F0
        rts                                     ; 007F4

;-------------------------------------------------------------------------------
; SetDestination - Sets an object's destination and its data (+$2C, +$2E, +$30, +$32 words,
; +$34 long, from d2-d6).
;-------------------------------------------------------------------------------
SetDestination:
        move.w  d2,$2c(a0)                      ; 007F6
        move.w  d3,$2e(a0)                      ; 007FA
        move.w  d4,$30(a0)                      ; 007FE
        move.w  d5,$32(a0)                      ; 00802
        move.l  d6,$34(a0)                      ; 00806
        rts                                     ; 0080A
; CameraShots - The camera sequence's steps (CameraSequence 0-8): each picks the outside
; camera's zoom and next step by the distance (d3).
CameraShots:
        dc.l    CameraShot0                     ; 0080C
        dc.l    CameraShot1                     ; 00810
        dc.l    CameraShot2                     ; 00814
        dc.l    CameraShot3                     ; 00818
        dc.l    CameraShot4                     ; 0081C
        dc.l    CameraShot5                     ; 00820
        dc.l    l_026_00E10                     ; 00824
        dc.l    CameraShot7                     ; 00828
        dc.l    CameraShot8                     ; 0082C
dat_026_00830:
	dc.b	$00,$00,$00,$03,$00,$0F,$FF,$F7,$00,$03,$00,$0E,$FF,$EF,$00,$03
	dc.b	$00,$00,$FF,$F7,$00,$03,$FF,$F2,$00,$00,$00,$03,$FF,$F2,$00,$09
	dc.b	$00,$03,$FF,$F2,$00,$11,$00,$03,$00,$00,$00,$09,$00,$03,$00,$0E
	dc.b	$00,$00,$00,$12,$FF,$FB,$00,$00,$FF,$F7,$00,$0C
dat_026_0086C:
	dc.b	$00,$00,$00,$03,$00,$12,$FF,$F7,$00,$03,$00,$11,$FF,$EE,$00,$03
	dc.b	$00,$00,$FF,$F7,$00,$03,$FF,$F2,$00,$00,$00,$03,$FF,$EE,$00,$09
	dc.b	$00,$03,$FF,$F2,$00,$12,$00,$03,$00,$00,$00,$09,$00,$03,$00,$11
	dc.b	$00,$00,$00,$15,$FF,$FB,$00,$00,$FF,$F1,$00,$11
dat_026_008A8:
	dc.b	$00,$00,$00,$08,$00,$30,$FF,$E0,$00,$04,$00,$2C,$FF,$D4,$00,$04
	dc.b	$00,$00,$FF,$E4,$00,$04,$FF,$D8,$00,$00,$00,$04,$FF,$D0,$00,$1C
	dc.b	$00,$04,$FF,$D8,$00,$2C,$00,$04,$00,$00,$00,$20,$00,$04,$00,$2C
	dc.b	$00,$00,$00,$30,$FF,$F4,$00,$00,$FF,$E0,$00,$30
dat_026_008E4:
	dc.b	$00,$01,$00,$09,$00,$14,$FF,$F2,$00,$0C,$00,$0F,$FF,$EC,$00,$0C
	dc.b	$00,$01,$FF,$F2,$00,$0C,$FF,$F1,$00,$01,$00,$09,$FF,$EC,$00,$0E
	dc.b	$00,$06,$FF,$F1,$00,$14,$00,$06,$00,$01,$00,$0E,$00,$06,$00,$0F
	dc.b	$00,$01,$00,$12,$FF,$F4,$00,$00,$FF,$FA,$00,$0C
l_026_00920:
        rts                                     ; 00920

;-------------------------------------------------------------------------------
; UpdateCamera - The outside camera each frame (not in the cockpit, not frozen): the map view's
; camera, or the camera sequence's step (CameraShots) for the distance to the viewed object.
;-------------------------------------------------------------------------------
UpdateCamera:
        jsr     (CameraHeadingMatrix).l         ; 00922
        tst.b   (OutsideView).l                 ; 00928
        beq.b   l_026_00920                     ; 0092E
        tst.b   (NewView).l                     ; 00930
        beq.b   l_026_00920                     ; 00936
        tst.b   (WorldFrozen).l                 ; 00938
        bne.b   l_026_00920                     ; 0093E
        tst.b   (MapView).l                     ; 00940
        beq.b   l_026_0096E                     ; 00946
        tst.b   (CameraSequence).l              ; 00948
        bne.b   l_026_0096E                     ; 0094E
        lea.l   (ObjectTable).l,a0              ; 00950
        adda.w  (ViewObject).l,a0               ; 00956
        move.l  $14(a0),d5                      ; 0095C
        move.l  (CameraY).l,d6                  ; 00960
        move.l  $1c(a0),d7                      ; 00966
        bra.w   l_026_00AA8                     ; 0096A
l_026_0096E:
        cmpi.b  #$5,(CameraSequence).l          ; 0096E
        beq.b   l_026_00984                     ; 00976
        cmpi.b  #$2,(CameraSequence).l          ; 00978
        bge.w   l_026_00AB4                     ; 00980
l_026_00984:
        lea.l   (ObjectTable).l,a0              ; 00984
        adda.w  (ViewObject).l,a0               ; 0098A
        move.b  $62(a0),d0                      ; 00990
        andi.b  #$f0,d0                         ; 00994
        move.b  d0,d7                           ; 00998
        cmpi.b  #$30,d0                         ; 0099A
        bne.b   l_026_009A8                     ; 0099E
        lea.l   dat_026_008E4(pc),a1            ; 009A0
        bra.w   l_026_00A0E                     ; 009A4
l_026_009A8:
        move.w  $68(a0),d0                      ; 009A8
        move.w  (ViewHeadingSaved).l,d1         ; 009AC
        sub.w   d0,d1                           ; 009B2
        bge.b   l_026_009B8                     ; 009B4
        neg.w   d1                              ; 009B6
l_026_009B8:
        move.w  d0,(ViewHeadingSaved).l         ; 009B8
        cmpi.w  #$1c20,d1                       ; 009BE
        blt.b   l_026_009EE                     ; 009C2
        cmpi.w  #$5460,d1                       ; 009C4
        bgt.b   l_026_009EE                     ; 009C8
        move.b  (ViewChoice).l,d0               ; 009CA
        beq.b   l_026_009EE                     ; 009D0
        cmpi.b  #$8,d0                          ; 009D2
        bge.b   l_026_009EE                     ; 009D6
        cmpi.b  #$4,d0                          ; 009D8
        beq.b   l_026_009EE                     ; 009DC
        addq.b  #$4,d0                          ; 009DE
        cmpi.b  #$8,d0                          ; 009E0
        blt.b   l_026_009E8                     ; 009E4
        subq.b  #$8,d0                          ; 009E6
l_026_009E8:
        move.b  d0,(ViewChoice).l               ; 009E8
l_026_009EE:
        cmpi.b  #$11,$62(a0)                    ; 009EE
        beq.b   l_026_00A04                     ; 009F4
        cmpi.b  #$14,$62(a0)                    ; 009F6
        beq.b   l_026_00A0A                     ; 009FC
        lea.l   dat_026_00830(pc),a1            ; 009FE
        bra.b   l_026_00A0E                     ; 00A02
l_026_00A04:
        lea.l   dat_026_0086C(pc),a1            ; 00A04
        bra.b   l_026_00A0E                     ; 00A08
l_026_00A0A:
        lea.l   dat_026_008A8(pc),a1            ; 00A0A
l_026_00A0E:
        move.b  (ViewChoice).l,d0               ; 00A0E
        ext.w   d0                              ; 00A14
        add.w   d0,d0                           ; 00A16
        move.w  d0,d1                           ; 00A18
        add.w   d0,d0                           ; 00A1A
        add.w   d1,d0                           ; 00A1C
        movem.w (a1,d0.w),d3-d5                 ; 00A1E
        move.b  (OutsideView).l,d0              ; 00A24
        blt.b   l_026_00A50                     ; 00A2A
        ext.w   d0                              ; 00A2C
        cmpi.w  #$1,d0                          ; 00A2E
        bgt.b   l_026_00A48                     ; 00A32
        move.w  d3,d0                           ; 00A34
        move.w  d4,d1                           ; 00A36
        move.w  d5,d2                           ; 00A38
        asr.w   #$1,d0                          ; 00A3A
        asr.w   #$1,d1                          ; 00A3C
        asr.w   #$1,d2                          ; 00A3E
        add.w   d0,d3                           ; 00A40
        add.w   d1,d4                           ; 00A42
        add.w   d2,d5                           ; 00A44
        bra.b   l_026_00A50                     ; 00A46
l_026_00A48:
        subq.w  #$1,d0                          ; 00A48
        asl.w   d0,d3                           ; 00A4A
        asl.w   d0,d4                           ; 00A4C
        asl.w   d0,d5                           ; 00A4E
l_026_00A50:
        move.l  a0,-(a7)                        ; 00A50
        move.b  (ViewChoice).l,d0               ; 00A52
        cmpi.b  #$30,d7                         ; 00A58
        beq.b   l_026_00A68                     ; 00A5C
        tst.b   d0                              ; 00A5E
        beq.b   l_026_00A70                     ; 00A60
        cmpi.b  #$4,d0                          ; 00A62
        beq.b   l_026_00A70                     ; 00A66
l_026_00A68:
        jsr     (TurnByPanelMatrix).l           ; 00A68
        bra.b   l_026_00A76                     ; 00A6E
l_026_00A70:
        jsr     (TurnByViewObject).l            ; 00A70
l_026_00A76:
        movem.l d0-d2,(FlyByPoint).l            ; 00A76
        movem.l (FlyByPoint).l,d5-d7            ; 00A7E
        movea.l (a7)+,a0                        ; 00A86
        move.b  $4(a0),d0                       ; 00A88
        andi.b  #$c0,d0                         ; 00A8C
        bne.b   l_026_00A96                     ; 00A90
        moveq   #$0,d0                          ; 00A92
        bra.b   l_026_00A9A                     ; 00A94
l_026_00A96:
        move.w  $4e(a0),d0                      ; 00A96
l_026_00A9A:
        addi.w  #$7,d0                          ; 00A9A
        ext.l   d0                              ; 00A9E
        asl.l   #$8,d0                          ; 00AA0
        cmp.l   d0,d6                           ; 00AA2
        bge.b   l_026_00AA8                     ; 00AA4
        move.l  d0,d6                           ; 00AA6
l_026_00AA8:
        movem.l d5-d7,(CameraX).l               ; 00AA8
        bra.w   l_026_00E96                     ; 00AB0
l_026_00AB4:
        movem.l (FlyByPoint).l,d5-d7            ; 00AB4
        movem.l (CameraX).l,d0-d2               ; 00ABC
        sub.l   d0,d5                           ; 00AC4
        move.l  d5,d0                           ; 00AC6
        bge.b   l_026_00ACC                     ; 00AC8
        neg.l   d0                              ; 00ACA
l_026_00ACC:
        sub.l   d1,d6                           ; 00ACC
        move.l  d6,d1                           ; 00ACE
        bge.b   l_026_00AD4                     ; 00AD0
        neg.l   d1                              ; 00AD2
l_026_00AD4:
        sub.l   d2,d7                           ; 00AD4
        move.l  d7,d2                           ; 00AD6
        bge.b   l_026_00ADC                     ; 00AD8
        neg.l   d2                              ; 00ADA
l_026_00ADC:
        cmp.l   d0,d1                           ; 00ADC
        bgt.b   l_026_00AE8                     ; 00ADE
        cmp.l   d0,d2                           ; 00AE0
        bgt.b   l_026_00AEC                     ; 00AE2
        move.l  d0,d3                           ; 00AE4
        bra.b   l_026_00AF2                     ; 00AE6
l_026_00AE8:
        cmp.l   d1,d2                           ; 00AE8
        ble.b   l_026_00AF0                     ; 00AEA
l_026_00AEC:
        move.l  d2,d3                           ; 00AEC
        bra.b   l_026_00AF2                     ; 00AEE
l_026_00AF0:
        move.l  d1,d3                           ; 00AF0
l_026_00AF2:
        move.b  (CameraShotStep).l,d0           ; 00AF2
        ext.w   d0                              ; 00AF8
        asl.w   #$2,d0                          ; 00AFA
        lea.l   CameraShots(pc),a0              ; 00AFC
        movea.l (a0,d0.w),a0                    ; 00B00
        jmp     (a0)                            ; 00B04

;-------------------------------------------------------------------------------
; CameraShot0 - Camera sequence step 0 (CameraShots): the zoom by the distance; close enough,
; the camera follows and step 1.
;-------------------------------------------------------------------------------
CameraShot0:
        moveq   #$d,d4                          ; 00B06
        cmpi.l  #$1c00000,d3                    ; 00B08
        bgt.w   l_026_00DE6                     ; 00B0E
        move.b  #$1,(CameraFollows).l           ; 00B12
        clr.b   (MapView).l                     ; 00B1A
        moveq   #$b,d4                          ; 00B20
        cmpi.l  #$d00000,d3                     ; 00B22
        bgt.w   l_026_00DE6                     ; 00B28
        move.b  #$1,(CameraShotStep).l          ; 00B2C
        bra.w   l_026_00CEA                     ; 00B34

;-------------------------------------------------------------------------------
; CameraShot1 - Camera sequence step 1 (CameraShots).
;-------------------------------------------------------------------------------
CameraShot1:
        moveq   #$b,d4                          ; 00B38
        cmpi.l  #$200000,d3                     ; 00B3A
        bgt.w   l_026_00DE6                     ; 00B40
        moveq   #$a,d4                          ; 00B44
        cmpi.l  #$60000,d3                      ; 00B46
        bgt.w   l_026_00DE6                     ; 00B4C
        move.b  #$2,(CameraShotStep).l          ; 00B50
        bra.w   l_026_00CEA                     ; 00B58

;-------------------------------------------------------------------------------
; CameraShot2 - Camera sequence step 2 (CameraShots).
;-------------------------------------------------------------------------------
CameraShot2:
        moveq   #$9,d4                          ; 00B5C
        cmpi.l  #$60000,d3                      ; 00B5E
        bgt.w   l_026_00CEA                     ; 00B64
        moveq   #$7,d4                          ; 00B68
        cmpi.l  #$30000,d3                      ; 00B6A
        bgt.w   l_026_00CEA                     ; 00B70
        move.b  #$3,(CameraShotStep).l          ; 00B74
        bra.w   l_026_00D68                     ; 00B7C

;-------------------------------------------------------------------------------
; CameraShot3 - Camera sequence step 3 (CameraShots).
;-------------------------------------------------------------------------------
CameraShot3:
        moveq   #$7,d4                          ; 00B80
        cmpi.l  #$60000,d3                      ; 00B82
        bgt.w   l_026_00D68                     ; 00B88
        moveq   #$6,d4                          ; 00B8C
        cmpi.l  #$60000,d3                      ; 00B8E
        bgt.w   l_026_00D68                     ; 00B94
        moveq   #$5,d4                          ; 00B98
        cmpi.l  #$d000,d3                       ; 00B9A
        bgt.w   l_026_00D68                     ; 00BA0
        moveq   #$3,d4                          ; 00BA4
        cmpi.l  #$8000,d3                       ; 00BA6
        bgt.w   l_026_00D68                     ; 00BAC
        move.b  #$4,(CameraShotStep).l          ; 00BB0
        bra.w   l_026_00D8C                     ; 00BB8

;-------------------------------------------------------------------------------
; CameraShot4 - Camera sequence step 4 (CameraShots).
;-------------------------------------------------------------------------------
CameraShot4:
        moveq   #$2,d4                          ; 00BBC
        cmpi.l  #$2800,d3                       ; 00BBE
        bgt.w   l_026_00DE6                     ; 00BC4
        move.b  #$5,(CameraShotStep).l          ; 00BC8
        bra.w   l_026_00DB2                     ; 00BD0

;-------------------------------------------------------------------------------
; CameraShot5 - Camera sequence step 5 (CameraShots): the zoom at 1.
;-------------------------------------------------------------------------------
CameraShot5:
        moveq   #$1,d4                          ; 00BD4
        bra.w   l_026_00DE6                     ; 00BD6

;-------------------------------------------------------------------------------
; CameraShot7 - Camera sequence step 7 (CameraShots).
;-------------------------------------------------------------------------------
CameraShot7:
        tst.b   (FlyByPhase).l                  ; 00BDA
        bgt.b   l_026_00C06                     ; 00BE0
        moveq   #$e,d4                          ; 00BE2
        cmpi.l  #$800000,d3                     ; 00BE4
        bgt.w   l_026_00E28                     ; 00BEA
        moveq   #$c,d4                          ; 00BEE
        cmpi.l  #$fff00000,(dat_071_0061E).l    ; 00BF0
        bge.b   l_026_00C06                     ; 00BFA
        cmpi.l  #$100000,d3                     ; 00BFC
        bgt.w   l_026_00E28                     ; 00C02
l_026_00C06:
        move.b  #$3,(CameraSequence).l          ; 00C06
        move.b  #$8,(CameraShotStep).l          ; 00C0E
        jsr     (BayCentre).l                   ; 00C16
        movem.l d0-d2,(FlyByPoint).l            ; 00C1C
        rts                                     ; 00C24

;-------------------------------------------------------------------------------
; CameraShot8 - Camera sequence step 8 (CameraShots): to sequence 4 when close.
;-------------------------------------------------------------------------------
CameraShot8:
        moveq   #$e,d4                          ; 00C26
        cmpi.l  #$800000,d3                     ; 00C28
        bgt.w   l_026_00E28                     ; 00C2E
        moveq   #$c,d4                          ; 00C32
        cmpi.l  #$100000,d3                     ; 00C34
        bgt.w   l_026_00E28                     ; 00C3A
        move.b  #$4,(CameraSequence).l          ; 00C3E
        rts                                     ; 00C46

;-------------------------------------------------------------------------------
; FlyBySetup - Starts the camera's fly-by of the mission's scene (CameraSequence;
; StateFlyByStart).
;-------------------------------------------------------------------------------
FlyBySetup:
        move.b  #$1,(FlyByPhase).l              ; 00C48
        clr.w   (FlyByObject).l                 ; 00C50
        move.b  #$7,(CameraShotStep).l          ; 00C56
        lea.l   (ObjectTable).l,a0              ; 00C5E
        movea.l (ModeObjects).l,a2              ; 00C64
l_026_00C6A:
        tst.w   (a2)                            ; 00C6A
        blt.b   l_026_00CA0                     ; 00C6C
        move.w  $4(a2),d3                       ; 00C6E
        adda.w  #$a,a2                          ; 00C72
        lsl.w   #$8,d3                          ; 00C76
        add.w   d3,d3                           ; 00C78
        move.b  $62(a0,d3.w),d1                 ; 00C7A
        andi.b  #$f0,d1                         ; 00C7E
        cmpi.b  #$10,d1                         ; 00C82
        bne.b   l_026_00C6A                     ; 00C86
        btst    #$6,$1(a0,d3.w)                 ; 00C88
        beq.b   l_026_00C6A                     ; 00C8E
        move.w  d3,(FlyByObject).l              ; 00C90
        btst    #$3,$1(a0,d3.w)                 ; 00C96
        beq.b   l_026_00CBE                     ; 00C9C
        bra.b   l_026_00C6A                     ; 00C9E
l_026_00CA0:
        tst.w   (FlyByObject).l                 ; 00CA0
        bne.b   l_026_00CBE                     ; 00CA6
        move.w  #$3e,(DebugCheckpoint).l        ; 00CA8
        jsr     (Nop).l                         ; 00CB0
        jsr     (BayCentre).l                   ; 00CB6
        bra.b   l_026_00CE0                     ; 00CBC
l_026_00CBE:
        move.w  (FlyByObject).l,d3              ; 00CBE
        move.b  #$ff,(FlyByPhase).l             ; 00CC4
        move.l  $14(a0,d3.w),d0                 ; 00CCC
        move.l  $1c(a0,d3.w),d2                 ; 00CD0
        move.l  (CameraY).l,d1                  ; 00CD4
        move.l  d1,d3                           ; 00CDA
        asr.l   #$2,d3                          ; 00CDC
        sub.l   d3,d1                           ; 00CDE
l_026_00CE0:
        movem.l d0-d2,(FlyByPoint).l            ; 00CE0
        rts                                     ; 00CE8
l_026_00CEA:
        movem.l d3-d6,-(a7)                     ; 00CEA
        lea.l   (ObjectTable).l,a2              ; 00CEE
        adda.w  (ViewObject).l,a2               ; 00CF4
        movem.l (CameraX).l,d0-d2               ; 00CFA
        add.l   $14(a2),d0                      ; 00D02
        add.l   $18(a2),d1                      ; 00D06
        add.l   $1c(a2),d2                      ; 00D0A
        asr.l   #$1,d0                          ; 00D0E
        asr.l   #$1,d1                          ; 00D10
        asr.l   #$1,d2                          ; 00D12
        movem.l d0-d2,-(a7)                     ; 00D14
        add.l   (CameraX).l,d0                  ; 00D18
        add.l   (CameraZ).l,d2                  ; 00D1E
        asr.l   #$1,d0                          ; 00D24
        asr.l   #$1,d1                          ; 00D26
        asr.l   #$1,d2                          ; 00D28
        movem.l (a7)+,d3-d5                     ; 00D2A
        add.l   d3,d0                           ; 00D2E
        add.l   d4,d1                           ; 00D30
        add.l   d5,d2                           ; 00D32
        asr.l   #$1,d0                          ; 00D34
        asr.l   #$1,d1                          ; 00D36
        asr.l   #$1,d2                          ; 00D38
        movem.l d0-d2,-(a7)                     ; 00D3A
        add.l   d3,d0                           ; 00D3E
        add.l   d4,d1                           ; 00D40
        add.l   d5,d2                           ; 00D42
        asr.l   #$1,d0                          ; 00D44
        asr.l   #$1,d1                          ; 00D46
        asr.l   #$1,d2                          ; 00D48
        movem.l (a7)+,d3-d5                     ; 00D4A
        add.l   d3,d0                           ; 00D4E
        add.l   d4,d1                           ; 00D50
        add.l   d5,d2                           ; 00D52
        asr.l   #$1,d0                          ; 00D54
        asr.l   #$1,d1                          ; 00D56
        asr.l   #$1,d2                          ; 00D58
        movem.l d0-d2,(FlyByPoint).l            ; 00D5A
        movem.l (a7)+,d3-d6                     ; 00D62
        bra.b   l_026_00DE6                     ; 00D66
l_026_00D68:
        bsr.w   FlyByPointPlayer                ; 00D68
        bra.w   l_026_00DE6                     ; 00D6C

;-------------------------------------------------------------------------------
; FlyByPointObject4 - FlyByPoint = object 4's position.
;-------------------------------------------------------------------------------
FlyByPointObject4:
        movem.l (Object4_14).l,d0-d2            ; 00D70
        bra.b   l_026_00D82                     ; 00D78

;-------------------------------------------------------------------------------
; FlyByPointPlayer - FlyByPoint = the player's position.
;-------------------------------------------------------------------------------
FlyByPointPlayer:
        movem.l (PlayerX).l,d0-d2               ; 00D7A
l_026_00D82:
        movem.l d0-d2,(FlyByPoint).l            ; 00D82
        rts                                     ; 00D8A
l_026_00D8C:
        movem.l d3-d7,-(a7)                     ; 00D8C
        moveq   #$4,d4                          ; 00D90
        cmpi.b  #$1,(StartPoint).l              ; 00D92
        beq.b   l_026_00DAC                     ; 00D9A
        cmpi.b  #$2,(StartPoint).l              ; 00D9C
        beq.b   l_026_00DAC                     ; 00DA4
        moveq   #-6,d3                          ; 00DA6
        moveq   #-9,d5                          ; 00DA8
        bra.b   l_026_00DD4                     ; 00DAA
l_026_00DAC:
        moveq   #$6,d3                          ; 00DAC
        moveq   #$3,d5                          ; 00DAE
        bra.b   l_026_00DD4                     ; 00DB0
l_026_00DB2:
        movem.l d3-d7,-(a7)                     ; 00DB2
        moveq   #$1,d4                          ; 00DB6
        moveq   #$6,d5                          ; 00DB8
        cmpi.b  #$1,(StartPoint).l              ; 00DBA
        beq.b   l_026_00DD2                     ; 00DC2
        cmpi.b  #$2,(StartPoint).l              ; 00DC4
        beq.b   l_026_00DD2                     ; 00DCC
        moveq   #-6,d3                          ; 00DCE
        bra.b   l_026_00DD4                     ; 00DD0
l_026_00DD2:
        moveq   #$6,d3                          ; 00DD2
l_026_00DD4:
        jsr     (TurnByViewObject).l            ; 00DD4
        movem.l d0-d2,(FlyByPoint).l            ; 00DDA
        movem.l (a7)+,d3-d7                     ; 00DE2
l_026_00DE6:
        cmpi.l  #$240,d3                        ; 00DE6
        bgt.b   l_026_00E28                     ; 00DEC
        cmpi.b  #$6,(CameraSequence).l          ; 00DEE
        blt.b   l_026_00E26                     ; 00DF6
        move.b  #$6,(CameraShotStep).l          ; 00DF8
        move.b  #$5,(dat_071_00275).l           ; 00E00
        move.b  #$0,(CameraFollows).l           ; 00E08
l_026_00E10:
        subq.b  #$1,(dat_071_00275).l           ; 00E10
        bgt.b   l_026_00E26                     ; 00E16
        ori.w   #$2,(GunFlags).l                ; 00E18
        clr.b   (CameraSequence).l              ; 00E20
l_026_00E26:
        rts                                     ; 00E26
l_026_00E28:
        cmpi.l  #$4800,d3                       ; 00E28
        blt.b   l_026_00E3A                     ; 00E2E
        asr.l   #$2,d5                          ; 00E30
        asr.l   #$2,d6                          ; 00E32
        asr.l   #$2,d7                          ; 00E34
        asr.l   #$2,d3                          ; 00E36
        bra.b   l_026_00E28                     ; 00E38
l_026_00E3A:
        move.w  d4,-(a7)                        ; 00E3A
        move.w  #$200,d0                        ; 00E3C
        jsr     (ScaleToLengthD0).l             ; 00E40
        move.w  (a7)+,d4                        ; 00E46
        ext.l   d5                              ; 00E48
        ext.l   d6                              ; 00E4A
        ext.l   d7                              ; 00E4C
        asl.l   d4,d5                           ; 00E4E
        asl.l   d4,d6                           ; 00E50
        asl.l   d4,d7                           ; 00E52
        movem.l (CameraVelocity).l,d0-d2        ; 00E54
        move.l  d0,d3                           ; 00E5C
        or.l    d1,d3                           ; 00E5E
        or.l    d2,d3                           ; 00E60
        beq.b   l_026_00E78                     ; 00E62
        sub.l   d0,d5                           ; 00E64
        sub.l   d1,d6                           ; 00E66
        sub.l   d2,d7                           ; 00E68
        moveq   #$1,d4                          ; 00E6A
        asr.l   d4,d5                           ; 00E6C
        asr.l   d4,d6                           ; 00E6E
        asr.l   d4,d7                           ; 00E70
        add.l   d0,d5                           ; 00E72
        add.l   d1,d6                           ; 00E74
        add.l   d2,d7                           ; 00E76
l_026_00E78:
        movem.l d5-d7,(CameraVelocity).l        ; 00E78
        movem.l (CameraX).l,d0-d2               ; 00E80
        add.l   d0,d5                           ; 00E88
        add.l   d1,d6                           ; 00E8A
        add.l   d2,d7                           ; 00E8C
        movem.l d5-d7,(CameraX).l               ; 00E8E
l_026_00E96:
        andi.l  #$3fffff,d5                     ; 00E96
        andi.l  #$3fffff,d7                     ; 00E9C
        neg.l   d5                              ; 00EA2
        neg.l   d6                              ; 00EA4
        neg.l   d7                              ; 00EA6
        movem.l d5-d7,(CameraCellOffset).l      ; 00EA8
        rts                                     ; 00EB0
	dc.b	$00,$00
h026_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    9,26                            ; 9 longs pointing into hunk 26
	dc.l	$82C,$828,$824,$820,$81C,$818,$814,$810
	dc.l	$80C
        dc.l    126,71                          ; 126 longs pointing into hunk 71
	dc.l	$16,$10,$88,$4A4,$A,$4AA,$52C,$5C
	dc.l	$72,$578,$5D0,$572,$5A8,$54,$566,$64
	dc.l	$590,$59E,$5B8,$5C6,$E1C,$294,$2B2,$2E4
	dc.l	$958,$98C,$CF6,$1C2,$214,$1AA,$1B8,$1E8
	dc.l	$25E,$710,$792,$7C2,$D74,$1B0,$120,$20E
	dc.l	$28E,$2F0,$388,$440,$496,$70A,$952,$986
	dc.l	$C60,$CF0,$D7E,$B0,$1C,$BE,$3F8,$42E
	dc.l	$942,$B1C,$9AE,$9BA,$9CC,$9EA,$A10,$A54
	dc.l	$E04,$E12,$94A,$972,$97C,$C0A,$C42,$DF2
	dc.l	$E22,$AF4,$B30,$B54,$B78,$BB4,$BCC,$C12
	dc.l	$C5A,$DFC,$B16,$E0C,$932,$962,$A7A,$A82
	dc.l	$AAC,$AB8,$AC0,$BF6,$C20,$CD6,$CE4,$CFE
	dc.l	$D1A,$D20,$D5E,$D86,$DDE,$E58,$E7C,$E84
	dc.l	$E92,$EAC,$D96,$DA0,$DBE,$DC8,$92A,$A26
	dc.l	$93A,$278,$C52,$C92,$CA2,$CC0,$BDC,$C4C
	dc.l	$CC8,$18E,$6FA,$CAC,$96,$C66
        dc.l    4,16                            ; 4 longs pointing into hunk 16
	dc.l	$1D2,$416,$1E2,$456
        dc.l    2,73                            ; 2 longs pointing into hunk 73
	dc.l	$26E,$268
        dc.l    1,2                             ; 1 longs pointing into hunk 2
	dc.l	$D2
        dc.l    2,20                            ; 2 longs pointing into hunk 20
	dc.l	$E42,$4
        dc.l    3,32                            ; 3 longs pointing into hunk 32
	dc.l	$924,$19E,$6DE
        dc.l    6,4                             ; 6 longs pointing into hunk 4
	dc.l	$208,$A6A,$A72,$DD6,$C18,$CB8
        dc.l    1,0                             ; 1 longs pointing into hunk 0
	dc.l	$180
        dc.l    2,7                             ; 2 longs pointing into hunk 7
	dc.l	$700,$CB2
        dc.l    10,27                           ; 10 longs pointing into hunk 27
	dc.l	$F4,$2FE,$368,$504,$60E,$780,$7B0,$280
	dc.l	$74C,$42
	dc.l	0
	dc.l	HUNK_END
	endc
