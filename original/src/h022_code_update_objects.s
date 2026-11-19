; F/A-18 Interceptor - hunk 22 (code)
; UpdateObject (each object's frame: states, computer pilots, warnings) and RecordFrame (the
; flight recording).
; Included by ../f18_main.s.

;===============================================================================
; Hunk 22: CODE, $B74 bytes
;===============================================================================
	CODE_HUNK	h022
l_022_00000:
        rts                                     ; 00000

;-------------------------------------------------------------------------------
; RecordFrame - Records one frame of the flight while recording is on (dat_071_00160, and bit 6
; of dat_071_0029C): the player's control byte (PlayerControls) into RecordBuffer, and the two
; words of key / button events waiting (dat_071_00366, dat_071_00368) into RecordControls. When
; RecordBuffer is full the recording stops (RecordMode = 4, dat_071_0017E = 1) and both
; pointers go back to the start.
;-------------------------------------------------------------------------------
RecordFrame:
        tst.b   (dat_071_00160).l               ; 00002
        beq.b   l_022_00000                     ; 00008
        move.w  (dat_071_0029C).l,d0            ; 0000A
        andi.w  #$40,d0                         ; 00010
        beq.b   l_022_00000                     ; 00014
        move.b  (RecordMode).l,d1               ; 00016
        beq.b   l_022_00024                     ; 0001C
        cmpi.b  #$1,d1                          ; 0001E
        bne.b   l_022_00000                     ; 00022
l_022_00024:
        tst.b   (dat_071_0017E).l               ; 00024
        bne.b   l_022_00000                     ; 0002A
        cmpi.b  #$1,(RecordMode).l              ; 0002C
        bne.b   l_022_00046                     ; 00034
        movea.l (ReplayControlsPointer).l,a0    ; 00036
        move.w  (FrameEvents2).l,$2(a0)         ; 0003C
        bra.b   l_022_000B2                     ; 00044
l_022_00046:
        move.l  (RecordBuffer).l,d0             ; 00046
        add.l   (RecordLength).l,d0             ; 0004C
        movea.l (RecordPointer).l,a0            ; 00052
        cmp.l   a0,d0                           ; 00058
        bgt.b   l_022_00082                     ; 0005A
        move.b  #$4,(RecordMode).l              ; 0005C
        move.b  #$1,(dat_071_0017E).l           ; 00064
        move.l  (RecordBuffer).l,(RecordPointer).l ; 0006C
        move.l  (RecordControls).l,(RecordControlsPointer).l ; 00076
        rts                                     ; 00080
l_022_00082:
        move.b  (PlayerControls).l,(a0)+        ; 00082
        move.l  a0,(RecordPointer).l            ; 00088
        movea.l (RecordControlsPointer).l,a1    ; 0008E
        move.w  (FrameEvents1).l,(a1)+          ; 00094
        move.w  (FrameEvents2).l,(a1)+          ; 0009A
        move.l  a1,(RecordControlsPointer).l    ; 000A0
        clr.w   (FrameEvents1).l                ; 000A6
        clr.w   (FrameEvents2).l                ; 000AC
l_022_000B2:
        rts                                     ; 000B2
sub_022_000B4:
        rts                                     ; 000B4
sub_022_000B6:
        rts                                     ; 000B6
	dc.b	$4E,$75
l_022_000BA:
        btst    #$6,$1(a1)                      ; 000BA
        beq.b   l_022_000FC                     ; 000C0
        movem.w $66(a1),d5-d7                   ; 000C2
        movem.l a0-a1,-(a7)                     ; 000C8
        jsr     (SetInverseMatrix).l            ; 000CC
        movem.l (a7)+,a0-a1                     ; 000D2
        move.w  $c(a1),d2                       ; 000D6
        move.w  $e(a1),d4                       ; 000DA
        ext.l   d2                              ; 000DE
        ext.l   d4                              ; 000E0
        swap    d2                              ; 000E2
        rol.l   #$4,d2                          ; 000E4
        swap    d4                              ; 000E6
        rol.l   #$4,d4                          ; 000E8
        subq.w  #$3,d2                          ; 000EA
        neg.w   d2                              ; 000EC
        subq.w  #$3,d4                          ; 000EE
        neg.w   d4                              ; 000F0
        add.w   d4,d4                           ; 000F2
        add.w   d4,d4                           ; 000F4
        add.w   d2,d4                           ; 000F6
        move.b  d4,$a(a1)                       ; 000F8
l_022_000FC:
        rts                                     ; 000FC

;-------------------------------------------------------------------------------
; UpdateObject - Updates one object (a1) for the frame: its destroyed / crashed states (flags
; in +$00, the timer +$4C), the computer pilot for objects other than the player
; (sub_030_0089A, while bit 6 of dat_071_0029C is set), the player's controls or replay
; (PlayerFrameControls), and for the player the warnings from its attitude and sink rate
; (dat_071_00524, the message dat_071_004B0)...
;-------------------------------------------------------------------------------
UpdateObject:
        moveq   #$0,d0                          ; 000FE
        tst.w   (CurrentObject).l               ; 00100
        beq.b   l_022_00110                     ; 00106
        or.b    (dat_071_00158).l,d0            ; 00108
        bne.b   l_022_000BA                     ; 0010E
l_022_00110:
        or.b    (dat_071_0017E).l,d0            ; 00110
        bne.b   l_022_000FC                     ; 00116
        tst.w   (CurrentObject).l               ; 00118
        bne.b   l_022_0012C                     ; 0011E
        tst.b   (dat_071_00155).l               ; 00120
        bne.b   l_022_00144                     ; 00126
        bra.w   l_022_001D6                     ; 00128
l_022_0012C:
        move.w  (FrameCount).l,d0               ; 0012C
        andi.w  #$1f,d0                         ; 00132
        cmp.w   (CurrentObject).l,d0            ; 00136
        bne.b   l_022_00144                     ; 0013C
        jsr     (sub_026_00708).l               ; 0013E
l_022_00144:
        move.w  $0(a1),d0                       ; 00144
        move.w  d0,d1                           ; 00148
        andi.w  #$400,d0                        ; 0014A
        beq.b   l_022_001C6                     ; 0014E
        tst.w   $4c(a1)                         ; 00150
        bgt.b   l_022_001C0                     ; 00154
        andi.w  #$fbff,$0(a1)                   ; 00156
        move.b  $62(a1),d2                      ; 0015C
        cmpi.b  #$15,d2                         ; 00160
        beq.b   l_022_001A4                     ; 00164
        andi.b  #$f0,d2                         ; 00166
        cmpi.b  #$0,d2                          ; 0016A
        beq.b   l_022_001A4                     ; 0016E
        cmpi.b  #$10,d2                         ; 00170
        bne.b   l_022_0018C                     ; 00174
        btst    #$3,$1(a1)                      ; 00176
        bne.b   l_022_0018C                     ; 0017C
        btst    #$7,$3(a1)                      ; 0017E
        bne.b   l_022_0018C                     ; 00184
        addq.b  #$1,(MissionTargetsDone).l      ; 00186
l_022_0018C:
        tst.w   (CurrentObject).l               ; 0018C
        beq.b   l_022_001A4                     ; 00192
        btst    #$7,$3(a1)                      ; 00194
        bne.b   l_022_001A4                     ; 0019A
        btst    #$7,$0(a1)                      ; 0019C
        beq.b   l_022_001C0                     ; 001A2
l_022_001A4:
        andi.w  #$ffbf,$0(a1)                   ; 001A4
        move.w  #$14,$4c(a1)                    ; 001AA
        bclr    #$6,$0(a1)                      ; 001B0
        andi.w  #$dfff,$0(a1)                   ; 001B6
        bra.w   l_022_00816                     ; 001BC
l_022_001C0:
        andi.w  #$dfff,$0(a1)                   ; 001C0
l_022_001C6:
        move.w  d1,d0                           ; 001C6
        andi.w  #$1000,d1                       ; 001C8
        bne.b   l_022_001D6                     ; 001CC
        andi.w  #$100,d0                        ; 001CE
        beq.w   l_022_00368                     ; 001D2
l_022_001D6:
        btst    #$0,$2(a1)                      ; 001D6
        beq.b   l_022_001EC                     ; 001DC
        tst.b   $5(a1)                          ; 001DE
        bne.b   l_022_001EC                     ; 001E2
        bset    #$4,$3(a1)                      ; 001E4
        bra.b   l_022_00208                     ; 001EA
l_022_001EC:
        move.w  (dat_071_0029C).l,d0            ; 001EC
        andi.w  #$40,d0                         ; 001F2
        beq.w   l_022_0031E                     ; 001F6
        tst.w   (CurrentObject).l               ; 001FA
        beq.b   l_022_00208                     ; 00200
        jsr     (ComputerPilot).l               ; 00202
l_022_00208:
        jsr     (PlayerFrameControls).l         ; 00208
        tst.w   (CurrentObject).l               ; 0020E
        bne.w   l_022_002BA                     ; 00214
        move.l  $42(a1),d0                      ; 00218
        bge.b   l_022_00262                     ; 0021C
        neg.l   d0                              ; 0021E
        btst    #$1,$20(a1)                     ; 00220
        bne.b   l_022_00288                     ; 00226
        cmpi.w  #$3840,$66(a1)                  ; 00228
        bgt.b   l_022_00262                     ; 0022E
        cmpi.w  #$1e0,$66(a1)                   ; 00230
        blt.b   l_022_00262                     ; 00236
        asl.l   #$4,d0                          ; 00238
        cmp.l   $18(a1),d0                      ; 0023A
        blt.b   l_022_00262                     ; 0023E
l_022_00240:
        btst    #$7,$3(a1)                      ; 00240
        bne.b   l_022_002BA                     ; 00246
        cmpi.w  #$9c06,(dat_071_004B0).l        ; 00248
        beq.b   l_022_002BA                     ; 00250
        ori.l   #$80,(SoundRequests).l          ; 00252
        move.w  #$9c06,d0                       ; 0025C
        bra.b   l_022_002B2                     ; 00260
l_022_00262:
        cmpi.w  #$3840,$6a(a1)                  ; 00262
        bgt.b   l_022_00274                     ; 00268
        cmpi.w  #$4b0,$6a(a1)                   ; 0026A
        blt.b   l_022_002BA                     ; 00270
        bra.b   l_022_0027C                     ; 00272
l_022_00274:
        cmpi.w  #$6bd0,$6a(a1)                  ; 00274
        bgt.b   l_022_002BA                     ; 0027A
l_022_0027C:
        cmpi.l  #$1800,$18(a1)                  ; 0027C
        ble.b   l_022_00240                     ; 00284
        bra.b   l_022_002BA                     ; 00286
l_022_00288:
        move.b  $7c(a1),d1                      ; 00288
        andi.b  #$f,d1                          ; 0028C
        bne.b   l_022_002BA                     ; 00290
        asl.l   #$6,d0                          ; 00292
        cmp.l   $18(a1),d0                      ; 00294
        blt.b   l_022_002BA                     ; 00298
        cmpi.w  #$d02a,(dat_071_004B0).l        ; 0029A
        beq.b   l_022_002BA                     ; 002A2
        ori.l   #$40,(SoundRequests).l          ; 002A4
        move.w  #$d02a,d0                       ; 002AE
l_022_002B2:
        jsr     (sub_020_00954).l               ; 002B2
        bra.b   l_022_0031E                     ; 002B8
l_022_002BA:
        move.w  (CurrentObject).l,d0            ; 002BA
        cmp.w   (dat_071_002AC).l,d0            ; 002C0
        bne.b   l_022_002F6                     ; 002C6
        tst.b   (dat_071_00155).l               ; 002C8
        bne.b   l_022_002F6                     ; 002CE
        btst    #$0,$3(a1)                      ; 002D0
        beq.b   l_022_002F6                     ; 002D6
        cmpi.w  #$d00a,(dat_071_004B0).l        ; 002D8
        beq.b   l_022_002F6                     ; 002E0
        move.w  #$d00a,d0                       ; 002E2
        jsr     (sub_020_00954).l               ; 002E6
        ori.l   #$80,(SoundRequests).l          ; 002EC
l_022_002F6:
        btst    #$1,$20(a1)                     ; 002F6
        bne.b   l_022_0031E                     ; 002FC
        move.b  $62(a1),d0                      ; 002FE
        andi.b  #$f0,d0                         ; 00302
        cmpi.b  #$10,d0                         ; 00306
        bne.b   l_022_0031E                     ; 0030A
        btst    #$4,$0(a1)                      ; 0030C
        beq.b   l_022_0031E                     ; 00312
        move.l  a1,-(a7)                        ; 00314
        jsr     (EngineAndSpeed).l              ; 00316
        movea.l (a7)+,a1                        ; 0031C
l_022_0031E:
        move.b  $62(a1),d0                      ; 0031E
        andi.b  #$f0,d0                         ; 00322
        cmpi.b  #$30,d0                         ; 00326
        beq.b   l_022_00334                     ; 0032A
        btst    #$7,$0(a1)                      ; 0032C
        bne.b   l_022_0033E                     ; 00332
l_022_00334:
        move.l  a1,-(a7)                        ; 00334
        jsr     (UpdateAttitude).l              ; 00336
        movea.l (a7)+,a1                        ; 0033C
l_022_0033E:
        tst.w   (CurrentObject).l               ; 0033E
        beq.b   l_022_003A8                     ; 00344
        move.w  $96(a1),d5                      ; 00346
        move.w  $9c(a1),d6                      ; 0034A
        move.w  $a2(a1),d7                      ; 0034E
        asr.w   #$2,d5                          ; 00352
        asr.w   #$2,d6                          ; 00354
        asr.w   #$2,d7                          ; 00356
        move.w  $0(a1),d0                       ; 00358
        andi.w  #$100,d0                        ; 0035C
        beq.b   l_022_00372                     ; 00360
        andi.w  #$feff,$0(a1)                   ; 00362
l_022_00368:
        moveq   #$0,d5                          ; 00368
        moveq   #$0,d6                          ; 0036A
        moveq   #$0,d7                          ; 0036C
        bra.w   l_022_0041E                     ; 0036E
l_022_00372:
        move.b  $62(a1),d0                      ; 00372
        andi.b  #$f0,d0                         ; 00376
        cmpi.b  #$30,d0                         ; 0037A
        bne.b   l_022_003A8                     ; 0037E
        move.l  $18(a1),d4                      ; 00380
        add.l   $42(a1),d4                      ; 00384
        bgt.b   l_022_00392                     ; 00388
        bset    #$7,$0(a1)                      ; 0038A
        clr.l   d4                              ; 00390
l_022_00392:
        move.l  d4,$18(a1)                      ; 00392
        movem.l $3e(a1),d5-d7                   ; 00396
        btst    #$7,$0(a1)                      ; 0039C
        beq.b   l_022_003CC                     ; 003A2
        bra.w   l_022_00816                     ; 003A4
l_022_003A8:
        move.w  (dat_071_0029C).l,d0            ; 003A8
        andi.w  #$40,d0                         ; 003AE
        bne.b   l_022_003BC                     ; 003B2
        moveq   #$0,d5                          ; 003B4
        moveq   #$0,d6                          ; 003B6
        moveq   #$0,d7                          ; 003B8
        bra.b   l_022_003CC                     ; 003BA
l_022_003BC:
        move.l  a1,-(a7)                        ; 003BC
        jsr     (FlyAircraft).l                 ; 003BE
        movea.l (a7)+,a1                        ; 003C4
        movem.l $3e(a1),d5-d7                   ; 003C6
l_022_003CC:
        btst    #$4,$0(a1)                      ; 003CC
        bne.b   l_022_003DC                     ; 003D2
        movem.l d5-d7/a1,-(a7)                  ; 003D4
        bra.w   l_022_004E6                     ; 003D8
l_022_003DC:
        move.l  #$1fffffff,d0                   ; 003DC
        move.l  $14(a1),d2                      ; 003E2
        move.l  $1c(a1),d4                      ; 003E6
        add.l   d5,d2                           ; 003EA
        blt.b   l_022_003F6                     ; 003EC
        cmp.l   d0,d2                           ; 003EE
        ble.b   l_022_003F8                     ; 003F0
        move.l  d0,d2                           ; 003F2
        bra.b   l_022_003F8                     ; 003F4
l_022_003F6:
        moveq   #$0,d4                          ; 003F6
l_022_003F8:
        add.l   d7,d4                           ; 003F8
        blt.b   l_022_00404                     ; 003FA
        cmp.l   d0,d4                           ; 003FC
        ble.b   l_022_00406                     ; 003FE
        move.l  d0,d4                           ; 00400
        bra.b   l_022_00406                     ; 00402
l_022_00404:
        moveq   #$0,d4                          ; 00404
l_022_00406:
        move.l  d2,$14(a1)                      ; 00406
        move.l  d4,$1c(a1)                      ; 0040A
        cmpi.b  #$15,$62(a1)                    ; 0040E
        bne.b   l_022_0041E                     ; 00414
        move.l  #$b000,$18(a1)                  ; 00416
l_022_0041E:
        movem.l d5-d7/a1,-(a7)                  ; 0041E
        move.l  $18(a1),d3                      ; 00422
        moveq   #$0,d6                          ; 00426
        move.l  $14(a1),d0                      ; 00428
        move.l  d0,d2                           ; 0042C
        andi.l  #$3fffff,d2                     ; 0042E
        move.l  $1c(a1),d1                      ; 00434
        move.l  d1,d4                           ; 00438
        andi.l  #$3fffff,d4                     ; 0043A
        swap    d0                              ; 00440
        asr.w   #$6,d0                          ; 00442
        cmp.w   $6(a1),d0                       ; 00444
        beq.b   l_022_00450                     ; 00448
        move.w  d0,$6(a1)                       ; 0044A
        moveq   #-1,d6                          ; 0044E
l_022_00450:
        swap    d1                              ; 00450
        asr.w   #$6,d1                          ; 00452
        cmp.w   $8(a1),d1                       ; 00454
        beq.b   l_022_00460                     ; 00458
        move.w  d1,$8(a1)                       ; 0045A
        moveq   #-1,d6                          ; 0045E
l_022_00460:
        tst.b   d6                              ; 00460
        beq.b   l_022_0046A                     ; 00462
        move.b  d6,(RedrawFlags).l              ; 00464
l_022_0046A:
        asr.l   #$8,d2                          ; 0046A
        asr.l   #$8,d3                          ; 0046C
        asr.l   #$8,d4                          ; 0046E
        move.w  d2,$c(a1)                       ; 00470
        move.w  d4,$e(a1)                       ; 00474
        move.l  d3,$10(a1)                      ; 00478
        swap    d2                              ; 0047C
        rol.l   #$4,d2                          ; 0047E
        swap    d4                              ; 00480
        rol.l   #$4,d4                          ; 00482
        move.w  d2,d5                           ; 00484
        move.w  d4,d7                           ; 00486
        subq.w  #$3,d2                          ; 00488
        neg.w   d2                              ; 0048A
        subq.w  #$3,d4                          ; 0048C
        neg.w   d4                              ; 0048E
        add.w   d4,d4                           ; 00490
        add.w   d4,d4                           ; 00492
        add.w   d2,d4                           ; 00494
        cmp.b   $a(a1),d4                       ; 00496
        beq.b   l_022_004E6                     ; 0049A
        move.b  d4,$a(a1)                       ; 0049C
        move.w  $6(a1),d0                       ; 004A0
        sub.w   (ViewCellX).l,d0                ; 004A4
        bge.b   l_022_004AE                     ; 004AA
        neg.w   d0                              ; 004AC
l_022_004AE:
        cmpi.w  #$2,d0                          ; 004AE
        bgt.b   l_022_004E6                     ; 004B2
        move.w  $8(a1),d0                       ; 004B4
        sub.w   (ViewCellZ).l,d0                ; 004B8
        bge.b   l_022_004C2                     ; 004BE
        neg.w   d0                              ; 004C0
l_022_004C2:
        cmpi.w  #$2,d0                          ; 004C2
        bgt.b   l_022_004E6                     ; 004C6
        move.b  #$ff,(RedrawFlags).l            ; 004C8
        lsr.w   #$2,d5                          ; 004D0
        lsr.w   #$2,d7                          ; 004D2
        subq.w  #$3,d5                          ; 004D4
        neg.w   d5                              ; 004D6
        subq.w  #$3,d7                          ; 004D8
        neg.w   d7                              ; 004DA
        add.w   d7,d7                           ; 004DC
        add.w   d7,d7                           ; 004DE
        add.w   d5,d7                           ; 004E0
        move.b  d7,$b(a1)                       ; 004E2
l_022_004E6:
        move.b  $7c(a1),d0                      ; 004E6
        move.b  d0,d1                           ; 004EA
        andi.b  #$f0,d1                         ; 004EC
        andi.b  #$f,d0                          ; 004F0
        beq.b   l_022_00528                     ; 004F4
        cmpi.b  #$6,d0                          ; 004F6
        ble.b   l_022_00506                     ; 004FA
        subq.b  #$1,d0                          ; 004FC
        cmpi.b  #$6,d0                          ; 004FE
        bgt.b   l_022_00522                     ; 00502
        moveq   #$0,d0                          ; 00504
l_022_00506:
        addq.b  #$1,d0                          ; 00506
        cmpi.b  #$6,d0                          ; 00508
        ble.b   l_022_00522                     ; 0050C
        btst    #$5,$3(a1)                      ; 0050E
        bne.b   l_022_0051A                     ; 00514
        subq.b  #$1,d0                          ; 00516
        bra.b   l_022_00522                     ; 00518
l_022_0051A:
        clr.b   d0                              ; 0051A
        andi.w  #$ffdf,$2(a1)                   ; 0051C
l_022_00522:
        or.b    d1,d0                           ; 00522
        move.b  d0,$7c(a1)                      ; 00524
l_022_00528:
        move.b  d1,d0                           ; 00528
        andi.b  #$f,d0                          ; 0052A
        tst.b   d1                              ; 0052E
        blt.b   l_022_0053A                     ; 00530
        ble.b   l_022_0055A                     ; 00532
        subi.b  #$10,d1                         ; 00534
        bra.b   l_022_0054C                     ; 00538
l_022_0053A:
        bclr    #$7,d1                          ; 0053A
        cmpi.b  #$60,d1                         ; 0053E
        bge.b   l_022_0055A                     ; 00542
        addi.b  #$10,d1                         ; 00544
        bset    #$7,d1                          ; 00548
l_022_0054C:
        or.b    d0,d1                           ; 0054C
        move.b  d1,$7c(a1)                      ; 0054E
        move.b  #$3,(dat_071_00215).l           ; 00552
l_022_0055A:
        tst.w   (CurrentObjectOffset).l         ; 0055A
        bne.b   l_022_00586                     ; 00560
        move.b  (dat_071_00217).l,d1            ; 00562
        blt.b   l_022_00570                     ; 00568
        ble.b   l_022_00586                     ; 0056A
        subq.b  #$1,d1                          ; 0056C
        bra.b   l_022_00580                     ; 0056E
l_022_00570:
        bclr    #$7,d1                          ; 00570
        cmpi.b  #$5,d1                          ; 00574
        bge.b   l_022_00586                     ; 00578
        addq.b  #$1,d1                          ; 0057A
        bset    #$7,d1                          ; 0057C
l_022_00580:
        move.b  d1,(dat_071_00217).l            ; 00580
l_022_00586:
        btst    #$2,$0(a1)                      ; 00586
        beq.b   l_022_00596                     ; 0058C
        movem.l (a7)+,d5-d7/a1                  ; 0058E
        bra.w   l_022_00816                     ; 00592
l_022_00596:
        movem.l $14(a1),d2-d4                   ; 00596
        movem.l (a7),d5-d7                      ; 0059C
        sub.l   d5,d2                           ; 005A0
        sub.l   d6,d3                           ; 005A2
        sub.l   d7,d4                           ; 005A4
        jsr     (sub_024_00006).l               ; 005A6
        movem.l (a7)+,d5-d7/a1                  ; 005AC
        beq.w   l_022_0082C                     ; 005B0
        move.w  (CurrentObject).l,d1            ; 005B4
        btst    #$5,d0                          ; 005BA
        beq.b   l_022_005C8                     ; 005BE
        clr.l   $56(a1)                         ; 005C0
        clr.w   $5a(a1)                         ; 005C4
l_022_005C8:
        cmpi.w  #$10,d0                         ; 005C8
        beq.b   l_022_00616                     ; 005CC
        cmpi.w  #$20,d0                         ; 005CE
        bne.b   l_022_00616                     ; 005D2
        move.b  $62(a1),d2                      ; 005D4
        andi.b  #$f0,d2                         ; 005D8
        cmpi.b  #$0,d2                          ; 005DC
        beq.b   l_022_00616                     ; 005E0
        move.b  $62(a1),d2                      ; 005E2
        andi.b  #$f0,d2                         ; 005E6
        cmpi.b  #$0,d2                          ; 005EA
        bne.b   l_022_00602                     ; 005EE
        move.l  d5,d2                           ; 005F0
        move.l  d6,d3                           ; 005F2
        move.l  d7,d4                           ; 005F4
        asr.l   #$2,d2                          ; 005F6
        asr.l   #$2,d3                          ; 005F8
        asr.l   #$2,d4                          ; 005FA
        sub.l   d2,d5                           ; 005FC
        sub.l   d3,d6                           ; 005FE
        sub.l   d4,d7                           ; 00600
l_022_00602:
        btst    #$7,$3(a1)                      ; 00602
        bne.b   l_022_0060E                     ; 00608
        sub.l   d6,$18(a1)                      ; 0060A
l_022_0060E:
        sub.l   d5,$14(a1)                      ; 0060E
        sub.l   d7,$1c(a1)                      ; 00612
l_022_00616:
        movem.l $14(a1),d2-d4                   ; 00616
        andi.l  #$3fffff,d2                     ; 0061C
        andi.l  #$3fffff,d4                     ; 00622
        asr.l   #$8,d2                          ; 00628
        asr.l   #$8,d3                          ; 0062A
        asr.l   #$8,d4                          ; 0062C
        move.w  d2,$c(a1)                       ; 0062E
        move.w  d4,$e(a1)                       ; 00632
        move.l  d3,$10(a1)                      ; 00636
        move.w  $6e(a1),d2                      ; 0063A
        tst.w   d1                              ; 0063E
        bne.w   l_022_00742                     ; 00640
        move.b  $7c(a1),d3                      ; 00644
        andi.b  #$f,d3                          ; 00648
        bne.w   l_022_0074E                     ; 0064C
        btst    #$4,d0                          ; 00650
        beq.b   l_022_0065E                     ; 00654
        bset    #$7,$3(a1)                      ; 00656
        bra.b   l_022_0069A                     ; 0065C
l_022_0065E:
        tst.b   (dat_071_0015C).l               ; 0065E
        beq.w   l_022_00816                     ; 00664
        cmpi.w  #$20,d0                         ; 00668
        bgt.b   l_022_0069A                     ; 0066C
        bset    #$7,$0(a1)                      ; 0066E
        bne.b   l_022_0069A                     ; 00674
        cmpi.w  #$3c0,d2                        ; 00676
        bgt.b   l_022_0069A                     ; 0067A
        btst    #$5,d0                          ; 0067C
        beq.b   l_022_0069A                     ; 00680
        move.l  a1,-(a7)                        ; 00682
        move.l  #$30,-(a7)                      ; 00684
        move.l  #$1c,-(a7)                      ; 0068A
        jsr     (sub_000_0A0DC).l               ; 00690
        addq.l  #$8,a7                          ; 00696
        movea.l (a7)+,a1                        ; 00698
l_022_0069A:
        bset    #$7,$0(a1)                      ; 0069A
        cmpi.w  #$3c0,d2                        ; 006A0
        ble.w   l_022_00816                     ; 006A4
        tst.b   (dat_071_0026A).l               ; 006A8
        bne.w   l_022_00816                     ; 006AE
        btst    #$6,d0                          ; 006B2
        beq.b   l_022_00710                     ; 006B6
        btst    #$0,(dat_071_002AB).l           ; 006B8
        bne.b   l_022_006E6                     ; 006C0
        move.b  (dat_071_0021F).l,d1            ; 006C2
        or.b    (dat_071_0021E).l,d1            ; 006C8
        bgt.w   l_022_00816                     ; 006CE
        bset    #$1,$20(a1)                     ; 006D2
        move.w  #$9014,d1                       ; 006D8
        ori.w   #$100,(dat_071_0029C).l         ; 006DC
        bra.b   l_022_006F8                     ; 006E4
l_022_006E6:
        move.w  #$d00b,d1                       ; 006E6
        btst    #$1,(dat_071_002AB).l           ; 006EA
        beq.b   l_022_006F8                     ; 006F2
        move.w  #$d00c,d1                       ; 006F4
l_022_006F8:
        swap    d0                              ; 006F8
        move.w  d1,d0                           ; 006FA
        jsr     (sub_020_00954).l               ; 006FC
        swap    d0                              ; 00702
        move.b  #$1,(dat_071_00190).l           ; 00704
        bra.w   l_022_00816                     ; 0070C
l_022_00710:
        ori.w   #$200,$0(a1)                    ; 00710
        btst    #$6,d0                          ; 00716
        bne.b   l_022_00736                     ; 0071A
        movea.l (ConfigBuffer).l,a0             ; 0071C
        addq.w  #$1,$46(a0)                     ; 00722
        move.b  #$1,(dat_071_00195).l           ; 00726
        move.b  #$4,(MissionResult).l           ; 0072E
l_022_00736:
        tst.b   (dat_071_00155).l               ; 00736
        bne.b   l_022_00742                     ; 0073C
        bra.w   l_022_00816                     ; 0073E
l_022_00742:
        cmpi.w  #$40,d0                         ; 00742
        beq.b   l_022_0074E                     ; 00746
        bset    #$7,$0(a1)                      ; 00748
l_022_0074E:
        btst    #$2,$0(a1)                      ; 0074E
        beq.b   l_022_00772                     ; 00754
        cmpi.w  #$f,$4c(a1)                     ; 00756
        ble.w   l_022_00816                     ; 0075C
        move.w  #$3a,(dat_071_0036E).l          ; 00760
        jsr     (Nop).l                         ; 00768
        bra.w   l_022_00816                     ; 0076E
l_022_00772:
        move.b  $62(a1),d2                      ; 00772
        andi.b  #$f0,d2                         ; 00776
        cmpi.b  #$30,d2                         ; 0077A
        bne.b   l_022_0078A                     ; 0077E
        btst    #$1,$0(a1)                      ; 00780
        beq.w   l_022_00816                     ; 00786
l_022_0078A:
        bset    #$1,$20(a1)                     ; 0078A
        cmpi.w  #$40,d0                         ; 00790
        beq.b   l_022_0079C                     ; 00794
        andi.w  #$efff,$0(a1)                   ; 00796
l_022_0079C:
        cmpi.b  #$0,d2                          ; 0079C
        beq.b   l_022_007CC                     ; 007A0
        cmpi.b  #$15,$62(a1)                    ; 007A2
        beq.b   l_022_007F6                     ; 007A8
        cmpi.w  #$40,d0                         ; 007AA
        blt.b   l_022_007F6                     ; 007AE
        move.w  (CurrentObjectOffset).l,(dat_073_0165A).l ; 007B0
        bset    #$4,$2(a1)                      ; 007BA
        bset    #$1,$20(a1)                     ; 007C0
        move.b  #$1,$5(a1)                      ; 007C6
l_022_007CC:
        cmpi.w  #$40,d0                         ; 007CC
        beq.b   l_022_0081C                     ; 007D0
l_022_007D2:
        moveq   #$11,d1                         ; 007D2
        cmpi.w  #$20,d0                         ; 007D4
        bge.b   l_022_007F2                     ; 007D8
        bsr.w   sub_022_008BA                   ; 007DA
        move.l  a1,-(a7)                        ; 007DE
        jsr     (sub_028_0115A).l               ; 007E0
        movea.l (a7)+,a1                        ; 007E6
        btst    #$1,$4(a1)                      ; 007E8
        bne.b   l_022_007F6                     ; 007EE
        moveq   #$0,d1                          ; 007F0
l_022_007F2:
        bsr.w   sub_022_008EA                   ; 007F2
l_022_007F6:
        ori.w   #$400,$0(a1)                    ; 007F6
        move.w  #$f,$4c(a1)                     ; 007FC
        bset    #$1,$0(a1)                      ; 00802
        tst.w   (CurrentObject).l               ; 00808
        beq.b   l_022_00816                     ; 0080E
        bclr    #$1,$0(a1)                      ; 00810
l_022_00816:
        bsr.w   sub_022_00AB6                   ; 00816
        rts                                     ; 0081A
l_022_0081C:
        bclr    #$6,$1(a1)                      ; 0081C
        move.b  #$c,(RedrawFlags).l             ; 00822
        rts                                     ; 0082A
l_022_0082C:
        btst    #$1,$20(a1)                     ; 0082C
        beq.b   l_022_0084C                     ; 00832
        btst    #$7,$3(a1)                      ; 00834
        beq.b   l_022_0084C                     ; 0083A
        btst    #$2,$0(a1)                      ; 0083C
        bne.b   l_022_0084C                     ; 00842
        andi.w  #$efff,$0(a1)                   ; 00844
        bra.b   l_022_007F6                     ; 0084A
l_022_0084C:
        move.b  $62(a1),d2                      ; 0084C
        andi.b  #$f0,d2                         ; 00850
        cmpi.b  #$30,d2                         ; 00854
        beq.b   l_022_00816                     ; 00858
        bclr    #$7,$0(a1)                      ; 0085A
        cmpi.b  #$0,d2                          ; 00860
        bne.b   l_022_0087A                     ; 00864
        moveq   #$0,d0                          ; 00866
        btst    #$2,$0(a1)                      ; 00868
        bne.b   l_022_00884                     ; 0086E
        btst    #$7,$3(a1)                      ; 00870
        bne.w   l_022_007D2                     ; 00876
l_022_0087A:
        btst    #$1,$0(a1)                      ; 0087A
        bne.w   l_022_007F6                     ; 00880
l_022_00884:
        tst.b   (dat_071_0026F).l               ; 00884
        beq.b   l_022_00894                     ; 0088A
        bset    #$1,$3(a1)                      ; 0088C
        bra.b   l_022_008B6                     ; 00892
l_022_00894:
        bclr    #$1,$3(a1)                      ; 00894
        beq.b   l_022_008B6                     ; 0089A
        move.b  $62(a1),d0                      ; 0089C
        andi.b  #$f0,d0                         ; 008A0
        cmpi.b  #$0,d0                          ; 008A4
        bne.b   l_022_008B6                     ; 008A8
        bset    #$5,$20(a1)                     ; 008AA
        clr.b   (dat_071_00284).l               ; 008B0
l_022_008B6:
        bra.w   l_022_00816                     ; 008B6
sub_022_008BA:
        move.l  d5,d0                           ; 008BA
        move.l  d6,d1                           ; 008BC
        move.l  d7,d2                           ; 008BE
        asr.l   #$8,d1                          ; 008C0
        beq.b   l_022_008E8                     ; 008C2
        move.l  $18(a1),d3                      ; 008C4
        asr.l   #$8,d3                          ; 008C8
        neg.w   d3                              ; 008CA
        asl.l   #$4,d0                          ; 008CC
        asl.l   #$4,d2                          ; 008CE
        divs.w  d1,d0                           ; 008D0
        divs.w  d1,d2                           ; 008D2
        muls.w  d3,d0                           ; 008D4
        muls.w  d3,d2                           ; 008D6
        asr.l   #$4,d0                          ; 008D8
        asr.l   #$4,d2                          ; 008DA
        add.l   d0,$14(a1)                      ; 008DC
        clr.l   $18(a1)                         ; 008E0
        add.l   d2,$1c(a1)                      ; 008E4
l_022_008E8:
        rts                                     ; 008E8
sub_022_008EA:
        lea.l   (SmallObjects).l,a4             ; 008EA
        moveq   #$f,d0                          ; 008F0
l_022_008F2:
        btst    #$6,$1(a4)                      ; 008F2
        beq.b   l_022_00904                     ; 008F8
        adda.w  #$20,a4                         ; 008FA
        dbra    d0,l_022_008F2                  ; 008FE
        bra.b   l_022_00932                     ; 00902
l_022_00904:
        movem.l (a1),d2-d7/a0/a5                ; 00904
        movem.l d2-d7/a0/a5,(a4)                ; 00908
        move.w  #$40,$0(a4)                     ; 0090C
        move.w  #$7f,$4(a4)                     ; 00912
        tst.w   d1                              ; 00918
        bne.b   l_022_00926                     ; 0091A
        moveq   #$12,d1                         ; 0091C
        btst    #$0,d0                          ; 0091E
        beq.b   l_022_00926                     ; 00922
        moveq   #$13,d1                         ; 00924
l_022_00926:
        move.w  d1,$2(a4)                       ; 00926
        move.b  #$ff,(RedrawFlags).l            ; 0092A
l_022_00932:
        rts                                     ; 00932
; LiftTable - ClimbDivePhysics: the lift for each speed flown (31 words, speed / 128).
LiftTable:
	dc.b	$02,$00,$01,$E0,$01,$C0,$01,$A0,$01,$68,$01,$30,$01,$10,$00,$E8
	dc.b	$00,$C8,$00,$B0,$00,$90,$00,$68,$00,$60,$00,$58,$00,$50,$00,$40
	dc.b	$00,$32,$00,$26,$00,$1D,$00,$17,$00,$12,$00,$0E,$00,$0B,$00,$08
	dc.b	$00,$05,$00,$04,$00,$03,$00,$03,$00,$02,$00,$02,$00,$01,$00,$01
; ClimbDiveTable - ClimbDivePhysics: a value for each speed (31 words, speed / 128).
ClimbDiveTable:
	dc.b	$01,$80,$01,$60,$01,$40,$01,$20,$01,$00,$00,$E0,$00,$C0,$00,$A0
	dc.b	$00,$90,$00,$84,$00,$7E,$00,$78,$00,$72,$00,$6C,$00,$66,$00,$60
	dc.b	$00,$5A,$00,$54,$00,$4E,$00,$48,$00,$42,$00,$3C,$00,$36,$00,$30
	dc.b	$00,$2A,$00,$24,$00,$1E,$00,$18,$00,$12,$00,$0C,$00,$06,$00,$02
	dc.b	$00,$00
l_022_009B6:
        clr.w   $76(a1)                         ; 009B6
        clr.w   $78(a1)                         ; 009BA
        rts                                     ; 009BE

;-------------------------------------------------------------------------------
; ClimbDivePhysics - Only when FlightPhysics is set: the speed lost climbing and gained diving
; (+$78: from the speed (+$6C / 128, 0-30) in ClimbDiveTable, times a term from the sine of the
; pitch (+$66)), and the lift / sink (+$76, added to the vertical velocity by FlyAircraft) from
; the speed flown (+$6E / 128) in LiftTable.
;-------------------------------------------------------------------------------
ClimbDivePhysics:
        lea.l   (ObjectTable).l,a1              ; 009C0
        adda.w  (CurrentObjectOffset).l,a1      ; 009C6
        tst.b   (FlightPhysics).l               ; 009CC
        beq.b   l_022_009B6                     ; 009D2
        move.w  $6c(a1),d0                      ; 009D4
        bge.b   l_022_009DC                     ; 009D8
        neg.w   d0                              ; 009DA
l_022_009DC:
        asr.w   #$7,d0                          ; 009DC
        cmpi.w  #$1e,d0                         ; 009DE
        ble.b   l_022_009E6                     ; 009E2
        moveq   #$1e,d0                         ; 009E4
l_022_009E6:
        lea.l   ClimbDiveTable(pc),a0           ; 009E6
        add.w   d0,d0                           ; 009EA
        move.w  (a0,d0.w),d1                    ; 009EC
        lea.l   (SineTable).l,a0                ; 009F0
        move.w  $66(a1),d2                      ; 009F6
        asr.w   #$3,d2                          ; 009FA
        cmpi.w  #$708,d2                        ; 009FC
        bgt.b   l_022_00A1E                     ; 00A00
        neg.w   d2                              ; 00A02
        addi.w  #$384,d2                        ; 00A04
        add.w   d2,d2                           ; 00A08
        move.w  (a0,d2.w),d3                    ; 00A0A
        asr.w   #$6,d3                          ; 00A0E
        neg.w   d3                              ; 00A10
        addi.w  #$100,d3                        ; 00A12
        move.w  $2(a0,d2.w),d4                  ; 00A16
        asr.w   #$6,d4                          ; 00A1A
        bra.b   l_022_00A40                     ; 00A1C
l_022_00A1E:
        neg.w   d2                              ; 00A1E
        addi.w  #$e10,d2                        ; 00A20
        neg.w   d2                              ; 00A24
        addi.w  #$384,d2                        ; 00A26
        add.w   d2,d2                           ; 00A2A
        move.w  (a0,d2.w),d3                    ; 00A2C
        asr.w   #$6,d3                          ; 00A30
        neg.w   d3                              ; 00A32
        addi.w  #$100,d3                        ; 00A34
        neg.w   d3                              ; 00A38
        move.w  $2(a0,d2.w),d4                  ; 00A3A
        asr.w   #$6,d4                          ; 00A3E
l_022_00A40:
        muls.w  d3,d1                           ; 00A40
        asr.l   #$3,d1                          ; 00A42
        btst    #$7,$3(a1)                      ; 00A44
        bne.b   l_022_00A78                     ; 00A4A
        tst.b   $7c(a1)                         ; 00A4C
        blt.b   l_022_00A58                     ; 00A50
        move.w  d1,d0                           ; 00A52
        asr.w   #$2,d0                          ; 00A54
        sub.w   d0,d1                           ; 00A56
l_022_00A58:
        move.w  $78(a1),d0                      ; 00A58
        move.w  d0,d2                           ; 00A5C
        cmp.w   d1,d0                           ; 00A5E
        ble.b   l_022_00A7C                     ; 00A60
        sub.w   d1,d0                           ; 00A62
        cmpi.w  #$ff,d0                         ; 00A64
        bgt.b   l_022_00A74                     ; 00A68
        tst.w   d2                              ; 00A6A
        beq.b   l_022_00A82                     ; 00A6C
        blt.b   l_022_00A78                     ; 00A6E
        subq.w  #$1,d2                          ; 00A70
        bra.b   l_022_00A82                     ; 00A72
l_022_00A74:
        asr.w   #$8,d0                          ; 00A74
        bra.b   l_022_00A80                     ; 00A76
l_022_00A78:
        moveq   #$0,d2                          ; 00A78
        bra.b   l_022_00A82                     ; 00A7A
l_022_00A7C:
        sub.w   d1,d0                           ; 00A7C
        asr.w   #$5,d0                          ; 00A7E
l_022_00A80:
        sub.w   d0,d2                           ; 00A80
l_022_00A82:
        move.w  d2,$78(a1)                      ; 00A82
        move.w  $6e(a1),d0                      ; 00A86
        bge.b   l_022_00A8E                     ; 00A8A
        neg.w   d0                              ; 00A8C
l_022_00A8E:
        asr.w   #$7,d0                          ; 00A8E
        cmpi.w  #$1e,d0                         ; 00A90
        ble.b   l_022_00A98                     ; 00A94
        moveq   #$1e,d0                         ; 00A96
l_022_00A98:
        lea.l   LiftTable(pc),a0                ; 00A98
        add.w   d0,d0                           ; 00A9C
        move.w  (a0,d0.w),d2                    ; 00A9E
        move.w  $76(a1),d0                      ; 00AA2
        move.w  d0,d1                           ; 00AA6
        sub.w   d2,d0                           ; 00AA8
        asr.w   #$6,d0                          ; 00AAA
        sub.w   d0,d1                           ; 00AAC
        move.w  d2,$76(a1)                      ; 00AAE
        rts                                     ; 00AB2
l_022_00AB4:
        rts                                     ; 00AB4
sub_022_00AB6:
        move.w  (CurrentObjectOffset).l,d0      ; 00AB6
        cmp.w   (dat_073_0165A).l,d0            ; 00ABC
        bne.b   l_022_00AB4                     ; 00AC2
        lea.l   (ObjectTable).l,a1              ; 00AC4
        adda.w  d0,a1                           ; 00ACA
        tst.b   (dat_071_0017E).l               ; 00ACC
        bne.b   l_022_00AB4                     ; 00AD2
        lea.l   (dat_073_0165C).l,a0            ; 00AD4
        move.b  (dat_073_01659).l,d0            ; 00ADA
        ext.w   d0                              ; 00AE0
        add.w   d0,d0                           ; 00AE2
        add.w   d0,d0                           ; 00AE4
        move.w  d0,d3                           ; 00AE6
        add.w   d0,d0                           ; 00AE8
        add.w   d3,d0                           ; 00AEA
        adda.w  d0,a0                           ; 00AEC
        move.l  $14(a1),(a0)+                   ; 00AEE
        move.l  $18(a1),(a0)+                   ; 00AF2
        move.l  $1c(a1),(a0)+                   ; 00AF6
        cmpi.b  #$5,(dat_073_01658).l           ; 00AFA
        bge.b   l_022_00B10                     ; 00B02
        move.l  $14(a1),(a0)+                   ; 00B04
        move.l  $18(a1),(a0)+                   ; 00B08
        move.l  $1c(a1),(a0)+                   ; 00B0C
l_022_00B10:
        addq.b  #$1,(dat_073_01659).l           ; 00B10
        cmpi.b  #$5,(dat_073_01659).l           ; 00B16
        ble.b   l_022_00B26                     ; 00B1E
        clr.b   (dat_073_01659).l               ; 00B20
l_022_00B26:
        cmpi.b  #$6,(dat_073_01658).l           ; 00B26
        bge.b   l_022_00B36                     ; 00B2E
        addq.b  #$1,(dat_073_01658).l           ; 00B30
l_022_00B36:
        tst.w   $6e(a1)                         ; 00B36
        beq.b   l_022_00B44                     ; 00B3A
        btst    #$4,$2(a1)                      ; 00B3C
        bne.b   l_022_00B5C                     ; 00B42
l_022_00B44:
        move.b  $3d(a1),d0                      ; 00B44
        beq.b   l_022_00B4E                     ; 00B48
        subq.b  #$1,d0                          ; 00B4A
        bgt.b   l_022_00B6E                     ; 00B4C
l_022_00B4E:
        clr.b   (dat_073_01658).l               ; 00B4E
        clr.b   (dat_073_01659).l               ; 00B54
        bra.b   l_022_00B6E                     ; 00B5A
l_022_00B5C:
        move.b  (dat_073_01658).l,d0            ; 00B5C
        subq.b  #$1,d0                          ; 00B62
        cmpi.b  #$5,d0                          ; 00B64
        blt.b   l_022_00B6E                     ; 00B68
        move.b  #$4,d0                          ; 00B6A
l_022_00B6E:
        move.b  d0,$3d(a1)                      ; 00B6E
        rts                                     ; 00B72
h022_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    70,71                           ; 70 longs pointing into hunk 71
	dc.l	$4,$18,$30,$60,$3E,$9C,$AE,$96
	dc.l	$A8,$8B2,$6C4,$6CA,$708,$12E,$6BC,$6EE
	dc.l	$9CE,$2C2,$188,$660,$556,$4BA,$4A6,$564
	dc.l	$582,$C,$1EE,$3AA,$6E0,$886,$6AA,$55C
	dc.l	$7B2,$9C8,$AB8,$102,$11A,$138,$18E,$1FC
	dc.l	$210,$2BC,$340,$5B6,$80A,$84,$9C2,$AC6
	dc.l	$8EC,$466,$4CC,$826,$92E,$26,$68,$112
	dc.l	$ACE,$10A,$122,$2CA,$738,$24C,$29E,$2DC
	dc.l	$258,$2AA,$2F2,$732,$72A,$764
        dc.l    24,73                           ; 24 longs pointing into hunk 73
	dc.l	$38,$7C,$90,$A2,$78,$4E,$54,$72
	dc.l	$8A,$48,$6E,$7B6,$ABE,$AD6,$AFE,$B2A
	dc.l	$B32,$B50,$B5E,$ADC,$B12,$B1A,$B22,$B56
        dc.l    1,63                            ; 1 longs pointing into hunk 63
	dc.l	$9F2
        dc.l    2,32                            ; 2 longs pointing into hunk 32
	dc.l	$CE,$338
        dc.l    3,20                            ; 3 longs pointing into hunk 20
	dc.l	$2B4,$2E8,$6FE
        dc.l    1,24                            ; 1 longs pointing into hunk 24
	dc.l	$5A8
        dc.l    1,0                             ; 1 longs pointing into hunk 0
	dc.l	$692
        dc.l    1,5                             ; 1 longs pointing into hunk 5
	dc.l	$20A
        dc.l    2,0                             ; 2 longs pointing into hunk 0
	dc.l	$3C0,$318
        dc.l    1,28                            ; 1 longs pointing into hunk 28
	dc.l	$7E2
        dc.l    1,26                            ; 1 longs pointing into hunk 26
	dc.l	$140
        dc.l    1,30                            ; 1 longs pointing into hunk 30
	dc.l	$204
        dc.l    1,2                             ; 1 longs pointing into hunk 2
	dc.l	$71E
        dc.l    1,7                             ; 1 longs pointing into hunk 7
	dc.l	$76A
	dc.l	0
	dc.l	HUNK_END
	endc
