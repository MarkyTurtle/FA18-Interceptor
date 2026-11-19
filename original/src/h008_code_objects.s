; F/A-18 Interceptor - hunk 8 (code)
; The 3D world's objects: which map cell the view is in (UpdateViewCell), DrawObjects (the
; visible objects and the scenery, scaled by distance).
; Included by ../f18_main.s.

;===============================================================================
; Hunk 8: CODE, $1914 bytes
;===============================================================================
	CODE_HUNK	h008
sub_008_00000:
        movem.l d0-d6,-(a7)                     ; 00000
        tst.b   (dat_071_0017C).l               ; 00004
        beq.b   l_008_00078                     ; 0000A
        clr.w   d0                              ; 0000C
        lea.l   (ObjectTable).l,a0              ; 0000E
        adda.w  (ViewObject).l,a0               ; 00014
        move.l  $14(a0),d2                      ; 0001A
        andi.l  #$3fffff,d2                     ; 0001E
        add.l   (dat_071_00602).l,d2            ; 00024
        bge.b   l_008_00032                     ; 0002A
        neg.l   d2                              ; 0002C
        bset    #$0,d0                          ; 0002E
l_008_00032:
        asr.l   #$8,d2                          ; 00032
        move.l  $18(a0),d3                      ; 00034
        add.l   (dat_071_00606).l,d3            ; 00038
        bge.b   l_008_00046                     ; 0003E
        neg.l   d3                              ; 00040
        bset    #$1,d0                          ; 00042
l_008_00046:
        asr.l   #$8,d3                          ; 00046
        move.l  $1c(a0),d4                      ; 00048
        andi.l  #$3fffff,d4                     ; 0004C
        add.l   (dat_071_0060A).l,d4            ; 00052
        bge.b   l_008_00060                     ; 00058
        neg.l   d4                              ; 0005A
        bset    #$2,d0                          ; 0005C
l_008_00060:
        asr.l   #$8,d4                          ; 00060
        movem.w d2-d4,-(a7)                     ; 00062
        jsr     (sub_008_016AC).l               ; 00066
        movem.w (a7)+,d2-d4                     ; 0006C
        move.w  d1,d5                           ; 00070
        subi.w  #$200,d1                        ; 00072
        bgt.b   l_008_00082                     ; 00076
l_008_00078:
        clr.l   d2                              ; 00078
        clr.l   d3                              ; 0007A
        clr.l   d4                              ; 0007C
        bra.w   l_008_00114                     ; 0007E
l_008_00082:
        move.w  d5,d6                           ; 00082
        asr.w   #$1,d6                          ; 00084
        cmp.w   d6,d1                           ; 00086
        blt.b   l_008_000F0                     ; 00088
        moveq   #$0,d6                          ; 0008A
        move.w  d5,d6                           ; 0008C
        sub.w   d1,d6                           ; 0008E
        ext.l   d6                              ; 00090
        swap    d6                              ; 00092
        divu.w  d5,d6                           ; 00094
        mulu.w  d6,d2                           ; 00096
        mulu.w  d6,d3                           ; 00098
        mulu.w  d6,d4                           ; 0009A
        asr.l   #$8,d2                          ; 0009C
        bcc.b   l_008_000A2                     ; 0009E
        addq.l  #$1,d2                          ; 000A0
l_008_000A2:
        asr.l   #$8,d3                          ; 000A2
        bcc.b   l_008_000A8                     ; 000A4
        addq.l  #$1,d3                          ; 000A6
l_008_000A8:
        asr.l   #$8,d4                          ; 000A8
        bcc.b   l_008_000AE                     ; 000AA
        addq.l  #$1,d4                          ; 000AC
l_008_000AE:
        btst    #$0,d0                          ; 000AE
        beq.b   l_008_000B6                     ; 000B2
        neg.l   d2                              ; 000B4
l_008_000B6:
        btst    #$1,d0                          ; 000B6
        beq.b   l_008_000BE                     ; 000BA
        neg.l   d3                              ; 000BC
l_008_000BE:
        btst    #$2,d0                          ; 000BE
        beq.b   l_008_000C6                     ; 000C2
        neg.l   d4                              ; 000C4
l_008_000C6:
        lea.l   (ObjectTable).l,a0              ; 000C6
        adda.w  (ViewObject).l,a0               ; 000CC
        move.l  $14(a0),d0                      ; 000D2
        andi.l  #$3fffff,d0                     ; 000D6
        sub.l   d0,d2                           ; 000DC
        sub.l   $18(a0),d3                      ; 000DE
        move.l  $1c(a0),d0                      ; 000E2
        andi.l  #$3fffff,d0                     ; 000E6
        sub.l   d0,d4                           ; 000EC
        bra.b   l_008_0012C                     ; 000EE
l_008_000F0:
        ext.l   d1                              ; 000F0
        asl.l   #$8,d1                          ; 000F2
        divu.w  d5,d1                           ; 000F4
        mulu.w  d1,d2                           ; 000F6
        mulu.w  d1,d3                           ; 000F8
        mulu.w  d1,d4                           ; 000FA
        btst    #$0,d0                          ; 000FC
        bne.b   l_008_00104                     ; 00100
        neg.l   d2                              ; 00102
l_008_00104:
        btst    #$1,d0                          ; 00104
        bne.b   l_008_0010C                     ; 00108
        neg.l   d3                              ; 0010A
l_008_0010C:
        btst    #$2,d0                          ; 0010C
        bne.b   l_008_00114                     ; 00110
        neg.l   d4                              ; 00112
l_008_00114:
        move.l  (dat_071_00602).l,d0            ; 00114
        move.l  (dat_071_00606).l,d1            ; 0011A
        move.l  (dat_071_0060A).l,d5            ; 00120
        add.l   d0,d2                           ; 00126
        add.l   d1,d3                           ; 00128
        add.l   d5,d4                           ; 0012A
l_008_0012C:
        move.l  d2,(dat_071_00432).l            ; 0012C
        move.l  d3,(dat_071_00436).l            ; 00132
        move.l  d4,(dat_071_0043A).l            ; 00138
        movem.l (a7)+,d0-d6                     ; 0013E
        rts                                     ; 00142
sub_008_00144:
        moveq   #$0,d0                          ; 00144
        move.l  d0,d1                           ; 00146
        move.l  d0,d2                           ; 00148
        move.l  d0,d3                           ; 0014A
        move.l  d0,d4                           ; 0014C
        move.l  d0,d5                           ; 0014E
        move.l  d0,d6                           ; 00150
        movea.l d0,a3                           ; 00152
        moveq   #$3f,d7                         ; 00154
        lea.l   (dat_002_01094).l,a0            ; 00156
        lea.l   (dat_002_01894).l,a1            ; 0015C
        lea.l   (dat_002_02094).l,a2            ; 00162
l_008_00168:
        movem.l d0-d6/a3,(a0)                   ; 00168
        movem.l d0-d6/a3,(a1)                   ; 0016C
        movem.l d0-d6/a3,(a2)                   ; 00170
        adda.w  #$20,a0                         ; 00174
        adda.w  #$20,a1                         ; 00178
        adda.w  #$20,a2                         ; 0017C
        dbra    d7,l_008_00168                  ; 00180
        lea.l   (dat_066_00000).l,a0            ; 00184
        lea.l   (dat_002_01094).l,a2            ; 0018A
        move.w  #$7f,d2                         ; 00190
l_008_00194:
        move.w  (a0),d3                         ; 00194
        ble.w   l_008_00268                     ; 00196
        lea.l   (dat_066_00000).l,a1            ; 0019A
        adda.w  d3,a1                           ; 001A0
        move.w  (a1)+,d1                        ; 001A2
        blt.b   l_008_001C6                     ; 001A4
        asr.w   #$1,d1                          ; 001A6
        subq.w  #$1,d1                          ; 001A8
l_008_001AA:
        move.w  (a1)+,d3                        ; 001AA
        move.w  d3,d5                           ; 001AC
        asr.w   #$5,d5                          ; 001AE
        add.w   d5,d5                           ; 001B0
        add.w   d5,d5                           ; 001B2
        andi.w  #$1f,d3                         ; 001B4
        move.l  (a2,d5.w),d4                    ; 001B8
        bset    d3,d4                           ; 001BC
        move.l  d4,(a2,d5.w)                    ; 001BE
        dbra    d1,l_008_001AA                  ; 001C2
l_008_001C6:
        addq.w  #$2,a0                          ; 001C6
        adda.w  #$10,a2                         ; 001C8
        dbra    d2,l_008_00194                  ; 001CC
        lea.l   (dat_066_00100).l,a0            ; 001D0
        lea.l   (dat_002_01894).l,a2            ; 001D6
        move.w  #$7f,d2                         ; 001DC
l_008_001E0:
        move.w  (a0),d3                         ; 001E0
        ble.w   l_008_0026E                     ; 001E2
        lea.l   (dat_066_00100).l,a1            ; 001E6
        adda.w  d3,a1                           ; 001EC
        move.w  (a1)+,d1                        ; 001EE
        blt.b   l_008_00212                     ; 001F0
        asr.w   #$1,d1                          ; 001F2
        subq.w  #$1,d1                          ; 001F4
l_008_001F6:
        move.w  (a1)+,d3                        ; 001F6
        move.w  d3,d5                           ; 001F8
        asr.w   #$5,d5                          ; 001FA
        add.w   d5,d5                           ; 001FC
        add.w   d5,d5                           ; 001FE
        andi.w  #$1f,d3                         ; 00200
        move.l  (a2,d5.w),d4                    ; 00204
        bset    d3,d4                           ; 00208
        move.l  d4,(a2,d5.w)                    ; 0020A
        dbra    d1,l_008_001F6                  ; 0020E
l_008_00212:
        addq.w  #$2,a0                          ; 00212
        adda.w  #$10,a2                         ; 00214
        dbra    d2,l_008_001E0                  ; 00218
        lea.l   (dat_066_00200).l,a0            ; 0021C
        lea.l   (dat_002_02094).l,a2            ; 00222
        move.w  #$7f,d2                         ; 00228
l_008_0022C:
        move.w  (a0),d3                         ; 0022C
        ble.b   l_008_00274                     ; 0022E
        lea.l   (dat_066_00200).l,a1            ; 00230
        adda.w  d3,a1                           ; 00236
        move.w  (a1)+,d1                        ; 00238
        blt.b   l_008_0025C                     ; 0023A
        asr.w   #$1,d1                          ; 0023C
        subq.w  #$1,d1                          ; 0023E
l_008_00240:
        move.w  (a1)+,d3                        ; 00240
        move.w  d3,d5                           ; 00242
        asr.w   #$5,d5                          ; 00244
        add.w   d5,d5                           ; 00246
        add.w   d5,d5                           ; 00248
        andi.w  #$1f,d3                         ; 0024A
        move.l  (a2,d5.w),d4                    ; 0024E
        bset    d3,d4                           ; 00252
        move.l  d4,(a2,d5.w)                    ; 00254
        dbra    d1,l_008_00240                  ; 00258
l_008_0025C:
        addq.w  #$2,a0                          ; 0025C
        adda.w  #$10,a2                         ; 0025E
        dbra    d2,l_008_0022C                  ; 00262
        rts                                     ; 00266
l_008_00268:
        move.w  #$43,d0                         ; 00268
        bra.b   l_008_00278                     ; 0026C
l_008_0026E:
        move.w  #$44,d0                         ; 0026E
        bra.b   l_008_00278                     ; 00272
l_008_00274:
        move.w  #$45,d0                         ; 00274
l_008_00278:
        move.w  d0,(dat_071_0036E).l            ; 00278
        jsr     (Nop).l                         ; 0027E
        rts                                     ; 00284
sub_008_00286:
        tst.b   (dat_071_00155).l               ; 00286
        bne.w   l_008_00344                     ; 0028C
        lea.l   (ObjectTable).l,a2              ; 00290
        adda.w  (ViewObject).l,a2               ; 00296
        cmpi.b  #$30,$62(a2)                    ; 0029C
        bne.b   l_008_002AC                     ; 002A2
        moveq   #$0,d3                          ; 002A4
        moveq   #$1,d4                          ; 002A6
        moveq   #-5,d5                          ; 002A8
        bra.b   l_008_002C0                     ; 002AA
l_008_002AC:
        moveq   #$0,d3                          ; 002AC
        cmpi.b  #$11,$62(a2)                    ; 002AE
        beq.b   l_008_002BC                     ; 002B4
        moveq   #$4,d4                          ; 002B6
        moveq   #$12,d5                         ; 002B8
        bra.b   l_008_002C0                     ; 002BA
l_008_002BC:
        moveq   #$5,d4                          ; 002BC
        moveq   #$14,d5                         ; 002BE
l_008_002C0:
        move.w  d3,d6                           ; 002C0
        move.w  d4,d0                           ; 002C2
        move.w  d5,d7                           ; 002C4
        muls.w  $92(a2),d6                      ; 002C6
        muls.w  $94(a2),d0                      ; 002CA
        muls.w  $96(a2),d7                      ; 002CE
        add.l   d6,d0                           ; 002D2
        add.l   d7,d0                           ; 002D4
        move.w  d3,d6                           ; 002D6
        move.w  d4,d1                           ; 002D8
        move.w  d5,d7                           ; 002DA
        muls.w  $98(a2),d6                      ; 002DC
        muls.w  $9a(a2),d1                      ; 002E0
        muls.w  $9c(a2),d7                      ; 002E4
        add.l   d6,d1                           ; 002E8
        add.l   d7,d1                           ; 002EA
        move.w  d4,d2                           ; 002EC
        muls.w  $9e(a2),d3                      ; 002EE
        muls.w  $a0(a2),d2                      ; 002F2
        muls.w  $a2(a2),d5                      ; 002F6
        add.l   d3,d2                           ; 002FA
        add.l   d5,d2                           ; 002FC
        asr.l   #$6,d0                          ; 002FE
        asr.l   #$6,d1                          ; 00300
        asr.l   #$6,d2                          ; 00302
        movem.l $14(a2),d3-d5                   ; 00304
        add.l   d0,d3                           ; 0030A
        add.l   d1,d4                           ; 0030C
        add.l   d2,d5                           ; 0030E
        movem.l d3-d5,(dat_071_0044C).l         ; 00310
        move.l  $14(a2),d3                      ; 00318
        andi.l  #$3fffff,d3                     ; 0031C
        add.l   d3,d0                           ; 00322
        add.l   $18(a2),d1                      ; 00324
        move.l  $1c(a2),d3                      ; 00328
        andi.l  #$3fffff,d3                     ; 0032C
        add.l   d3,d2                           ; 00332
        neg.l   d0                              ; 00334
        neg.l   d1                              ; 00336
        neg.l   d2                              ; 00338
        movem.l d0-d2,(dat_071_00432).l         ; 0033A
        bra.b   l_008_00360                     ; 00342
l_008_00344:
        bsr.w   sub_008_00000                   ; 00344
        movem.l (CameraX).l,d0-d2               ; 00348
        movem.l d0-d2,(dat_071_0044C).l         ; 00350
        movem.l (dat_071_00432).l,d0-d2         ; 00358
l_008_00360:
        asr.l   #$8,d0                          ; 00360
        asr.l   #$8,d1                          ; 00362
        asr.l   #$8,d2                          ; 00364
        movem.w d0-d2,(dat_071_00442).l         ; 00366
        move.l  d1,(dat_071_00448).l            ; 0036E
        rts                                     ; 00374

;-------------------------------------------------------------------------------
; UpdateViewCell - Works out which map cell and sub-cell the view (ViewObject, or the player's
; position in other modes) is in, and sets RedrawFlags when it changes (also when the height
; crosses $A000, or dat_071_00224 changes).
;-------------------------------------------------------------------------------
UpdateViewCell:
        moveq   #$0,d5                          ; 00376
        move.b  (dat_071_00224).l,d0            ; 00378
        cmp.b   (dat_071_00225).l,d0            ; 0037E
        beq.b   l_008_00398                     ; 00384
        move.b  d0,(dat_071_00225).l            ; 00386
        tst.b   (dat_071_00156).l               ; 0038C
        bne.b   l_008_00398                     ; 00392
        ori.b   #$b,d5                          ; 00394
l_008_00398:
        move.l  (dat_071_00436).l,d0            ; 00398
        neg.l   d0                              ; 0039E
        cmpi.l  #$a000,d0                       ; 003A0
        bge.b   l_008_003B6                     ; 003A6
        cmpi.l  #$a000,(dat_071_0043E).l        ; 003A8
        bge.b   l_008_003C2                     ; 003B2
        bra.b   l_008_003C6                     ; 003B4
l_008_003B6:
        cmpi.l  #$a000,(dat_071_0043E).l        ; 003B6
        bge.b   l_008_003C6                     ; 003C0
l_008_003C2:
        ori.b   #$b,d5                          ; 003C2
l_008_003C6:
        move.l  d0,(dat_071_0043E).l            ; 003C6
        clr.w   d0                              ; 003CC
        swap    d0                              ; 003CE
        asr.l   #$5,d0                          ; 003D0
        cmp.w   (dat_071_0042E).l,d0            ; 003D2
        beq.b   l_008_003EE                     ; 003D8
        cmpi.b  #$2,(CameraSequence).l          ; 003DA
        beq.b   l_008_003E8                     ; 003E2
        ori.b   #$b,d5                          ; 003E4
l_008_003E8:
        move.w  d0,(dat_071_0042E).l            ; 003E8
l_008_003EE:
        jsr     (UpdateAllObjects).l            ; 003EE
        tst.b   (dat_071_00155).l               ; 003F4
        bne.b   l_008_0044E                     ; 003FA
        lea.l   (ObjectTable).l,a3              ; 003FC
        adda.w  (ViewObject).l,a3               ; 00402
        bsr.w   sub_008_0052E                   ; 00408
        move.w  $6(a3),(ViewCellX).l            ; 0040C
        move.w  $8(a3),(ViewCellZ).l            ; 00414
        move.b  $a(a3),(ViewSubCell).l          ; 0041C
        move.w  (ViewCellX).l,d0                ; 00424
        andi.w  #$3,d0                          ; 0042A
        subq.w  #$3,d0                          ; 0042E
        neg.w   d0                              ; 00430
        move.w  (ViewCellZ).l,d1                ; 00432
        andi.w  #$3,d1                          ; 00438
        subq.w  #$3,d1                          ; 0043C
        neg.w   d1                              ; 0043E
        asl.w   #$2,d1                          ; 00440
        add.w   d0,d1                           ; 00442
        move.b  d1,(dat_071_00220).l            ; 00444
        bra.w   l_008_00526                     ; 0044A
l_008_0044E:
        move.w  d5,-(a7)                        ; 0044E
        jsr     (sub_026_00922).l               ; 00450
        move.w  (a7)+,d5                        ; 00456
        lea.l   (ObjectTable).l,a3              ; 00458
        bsr.w   sub_008_0052E                   ; 0045E
        move.l  (CameraX).l,d0                  ; 00462
        move.l  (CameraZ).l,d1                  ; 00468
        andi.l  #$1fffffff,d0                   ; 0046E
        andi.l  #$1fffffff,d1                   ; 00474
        swap    d0                              ; 0047A
        swap    d1                              ; 0047C
        asr.w   #$4,d0                          ; 0047E
        asr.w   #$4,d1                          ; 00480
        move.w  d0,d2                           ; 00482
        move.w  d1,d3                           ; 00484
        andi.w  #$3,d0                          ; 00486
        andi.w  #$3,d1                          ; 0048A
        subq.b  #$3,d0                          ; 0048E
        neg.b   d0                              ; 00490
        subq.b  #$3,d1                          ; 00492
        neg.b   d1                              ; 00494
        add.b   d1,d1                           ; 00496
        add.b   d1,d1                           ; 00498
        add.b   d0,d1                           ; 0049A
        asr.w   #$2,d2                          ; 0049C
        asr.w   #$2,d3                          ; 0049E
        move.w  d2,d0                           ; 004A0
        move.w  d3,d4                           ; 004A2
        andi.w  #$3,d2                          ; 004A4
        andi.w  #$3,d3                          ; 004A8
        subq.b  #$3,d2                          ; 004AC
        neg.b   d2                              ; 004AE
        subq.b  #$3,d3                          ; 004B0
        neg.b   d3                              ; 004B2
        add.b   d3,d3                           ; 004B4
        add.b   d3,d3                           ; 004B6
        add.b   d2,d3                           ; 004B8
        cmp.b   (ViewSubCell).l,d1              ; 004BA
        beq.b   l_008_004E0                     ; 004C0
        cmpi.b  #$2,(CameraSequence).l          ; 004C2
        bne.b   l_008_004D8                     ; 004CA
        cmpi.l  #$fffff000,(dat_071_00448).l    ; 004CC
        ble.b   l_008_004DA                     ; 004D6
l_008_004D8:
        moveq   #-1,d5                          ; 004D8
l_008_004DA:
        move.b  d1,(ViewSubCell).l              ; 004DA
l_008_004E0:
        cmp.b   (dat_071_00220).l,d3            ; 004E0
        beq.b   l_008_00506                     ; 004E6
        cmpi.b  #$2,(CameraSequence).l          ; 004E8
        bne.b   l_008_004FE                     ; 004F0
        cmpi.l  #$fffff000,(dat_071_00448).l    ; 004F2
        ble.b   l_008_00500                     ; 004FC
l_008_004FE:
        moveq   #-1,d5                          ; 004FE
l_008_00500:
        move.b  d3,(dat_071_00220).l            ; 00500
l_008_00506:
        cmp.w   (ViewCellX).l,d0                ; 00506
        beq.b   l_008_00516                     ; 0050C
        moveq   #-1,d5                          ; 0050E
        move.w  d0,(ViewCellX).l                ; 00510
l_008_00516:
        cmp.w   (ViewCellZ).l,d4                ; 00516
        beq.b   l_008_00526                     ; 0051C
        moveq   #-1,d5                          ; 0051E
        move.w  d4,(ViewCellZ).l                ; 00520
l_008_00526:
        or.b    d5,(RedrawFlags).l              ; 00526
        rts                                     ; 0052C
sub_008_0052E:
        move.w  $56(a3),d0                      ; 0052E
        bge.b   l_008_00536                     ; 00532
        neg.w   d0                              ; 00534
l_008_00536:
        move.w  $58(a3),d1                      ; 00536
        bge.b   l_008_0053E                     ; 0053A
        neg.w   d1                              ; 0053C
l_008_0053E:
        move.w  $5a(a3),d2                      ; 0053E
        bge.b   l_008_00546                     ; 00542
        neg.w   d2                              ; 00544
l_008_00546:
        asr.w   #$2,d2                          ; 00546
        cmp.w   d0,d1                           ; 00548
        bgt.b   l_008_00554                     ; 0054A
        cmp.w   d0,d2                           ; 0054C
        ble.b   l_008_0055E                     ; 0054E
        move.w  d2,d0                           ; 00550
        bra.b   l_008_0055E                     ; 00552
l_008_00554:
        cmp.w   d2,d1                           ; 00554
        bgt.b   l_008_0055C                     ; 00556
        move.w  d2,d0                           ; 00558
        bra.b   l_008_0055E                     ; 0055A
l_008_0055C:
        move.w  d1,d0                           ; 0055C
l_008_0055E:
        cmpi.w  #$60,d0                         ; 0055E
        bgt.b   l_008_0057C                     ; 00562
        move.w  $6c(a3),d1                      ; 00564
        bge.b   l_008_0056C                     ; 00568
        neg.w   d1                              ; 0056A
l_008_0056C:
        cmpi.w  #$1000,d1                       ; 0056C
        bgt.b   l_008_00582                     ; 00570
        move.b  #$5,(dat_071_0028C).l           ; 00572
        rts                                     ; 0057A
l_008_0057C:
        cmpi.w  #$c0,d0                         ; 0057C
        bgt.b   l_008_0058C                     ; 00580
l_008_00582:
        move.b  #$3,(dat_071_0028C).l           ; 00582
        rts                                     ; 0058A
l_008_0058C:
        move.b  #$1,(dat_071_0028C).l           ; 0058C
        rts                                     ; 00594
l_008_00596:
        rts                                     ; 00596
sub_008_00598:
        cmpi.l  #$f8000000,(dat_071_00436).l    ; 00598
        blt.b   l_008_00596                     ; 005A2
        movem.l d0-d5/a0,-(a7)                  ; 005A4
        clr.b   -$2c(a6)                        ; 005A8
        move.b  (RedrawFlags).l,d0              ; 005AC
        beq.w   l_008_006CE                     ; 005B2
        move.w  #$49,(FrameStage).l             ; 005B6
        bsr.w   sub_008_007BA                   ; 005BE
        move.b  d0,d1                           ; 005C2
        andi.b  #$f,d1                          ; 005C4
        cmpi.b  #$c,d1                          ; 005C8
        beq.b   l_008_005E8                     ; 005CC
        cmpi.b  #$b,d1                          ; 005CE
        beq.b   l_008_005E8                     ; 005D2
        cmpi.b  #$f,d1                          ; 005D4
        beq.b   l_008_005E8                     ; 005D8
        move.w  #$27,(dat_071_0036E).l          ; 005DA
        jsr     (Nop).l                         ; 005E2
l_008_005E8:
        tst.b   (dat_071_00155).l               ; 005E8
        beq.b   l_008_00612                     ; 005EE
        move.l  (CameraX).l,d1                  ; 005F0
        move.l  (CameraZ).l,d2                  ; 005F6
        andi.l  #$1fffffff,d1                   ; 005FC
        andi.l  #$1fffffff,d2                   ; 00602
        swap    d1                              ; 00608
        swap    d2                              ; 0060A
        asr.w   #$8,d1                          ; 0060C
        asr.w   #$8,d2                          ; 0060E
        bra.b   l_008_0062A                     ; 00610
l_008_00612:
        lea.l   (ObjectTable).l,a1              ; 00612
        adda.w  (ViewObject).l,a1               ; 00618
        move.w  $6(a1),d1                       ; 0061E
        move.w  $8(a1),d2                       ; 00622
        asr.w   #$2,d1                          ; 00626
        asr.w   #$2,d2                          ; 00628
l_008_0062A:
        move.w  d1,(dat_071_00318).l            ; 0062A
        move.w  d2,(dat_071_0031A).l            ; 00630
        move.b  #$1,(dat_071_00229).l           ; 00636
        clr.b   (dat_071_00234).l               ; 0063E
        clr.b   (dat_071_00235).l               ; 00644
        btst    #$0,d0                          ; 0064A
        beq.b   l_008_00664                     ; 0064E
        bclr    #$0,(RedrawFlags).l             ; 00650
        bsr.w   sub_008_00E44                   ; 00658
        btst    #$7,(RedrawFlags).l             ; 0065C
l_008_00664:
        btst    #$1,(RedrawFlags).l             ; 00664
        beq.b   l_008_0068A                     ; 0066C
        bclr    #$1,(RedrawFlags).l             ; 0066E
        move.b  #$1,(dat_071_00235).l           ; 00676
        bsr.w   sub_008_00E44                   ; 0067E
        btst    #$7,(RedrawFlags).l             ; 00682
l_008_0068A:
        move.b  #$1,(dat_071_00234).l           ; 0068A
        btst    #$2,(RedrawFlags).l             ; 00692
        beq.b   l_008_006A4                     ; 0069A
        bclr    #$2,(RedrawFlags).l             ; 0069C
l_008_006A4:
        btst    #$3,(RedrawFlags).l             ; 006A4
        beq.b   l_008_006C2                     ; 006AC
        bclr    #$3,(RedrawFlags).l             ; 006AE
        bsr.w   sub_008_00E44                   ; 006B6
        move.w  #$4a,(FrameStage).l             ; 006BA
l_008_006C2:
        move.b  #$1,-$2c(a6)                    ; 006C2
        clr.b   (RedrawFlags).l                 ; 006C8
l_008_006CE:
        jsr     (sub_009_00740).l               ; 006CE
        move.w  #$4b,(FrameStage).l             ; 006D4
        clr.b   -$2c(a6)                        ; 006DC
        jsr     (sub_009_00958).l               ; 006E0
        move.w  #$4c,(FrameStage).l             ; 006E6
        move.w  (FrameCount).l,d1               ; 006EE
        andi.w  #$1,d1                          ; 006F4
        bne.b   l_008_0070A                     ; 006F8
        jsr     (sub_012_003C0).l               ; 006FA
        move.w  #$4d,(FrameStage).l             ; 00700
        bra.b   l_008_00718                     ; 00708
l_008_0070A:
        jsr     (sub_012_003E0).l               ; 0070A
        move.w  #$4e,(FrameStage).l             ; 00710
l_008_00718:
        movem.l (a7)+,d0-d5/a0                  ; 00718
        tst.b   (dat_071_00177).l               ; 0071C
        bne.b   l_008_0075E                     ; 00722
        tst.b   (dat_071_00174).l               ; 00724
        beq.b   l_008_0075E                     ; 0072A
        move.w  #$72,d0                         ; 0072C
        move.w  #$a0,d1                         ; 00730
        tst.b   (dat_071_00229).l               ; 00734
        beq.b   l_008_00750                     ; 0073A
        move.l  #$fffff,(dat_071_000B6).l       ; 0073C
        move.w  #$f,(DrawColour).l              ; 00746
        bra.b   l_008_00758                     ; 0074E
l_008_00750:
        move.w  #$6,(DrawColour).l              ; 00750
l_008_00758:
        jsr     (PlotBigAbove).l                ; 00758
l_008_0075E:
        clr.b   (dat_071_00229).l               ; 0075E
        rts                                     ; 00764
sub_008_00766:
        addq.w  #$1,(PlayerCellX).l             ; 00766
        cmpi.w  #$7f,(PlayerCellX).l            ; 0076C
        ble.b   l_008_0077C                     ; 00774
        clr.w   (PlayerCellX).l                 ; 00776
l_008_0077C:
        rts                                     ; 0077C
sub_008_0077E:
        subq.w  #$1,(PlayerCellX).l             ; 0077E
        bge.b   l_008_0078E                     ; 00784
        move.w  #$7f,(PlayerCellX).l            ; 00786
l_008_0078E:
        rts                                     ; 0078E
sub_008_00790:
        addq.w  #$1,(PlayerCellZ).l             ; 00790
        cmpi.w  #$7f,(PlayerCellZ).l            ; 00796
        ble.b   l_008_007A6                     ; 0079E
        clr.w   (PlayerCellZ).l                 ; 007A0
l_008_007A6:
        rts                                     ; 007A6
sub_008_007A8:
        subq.w  #$1,(PlayerCellZ).l             ; 007A8
        bge.b   l_008_007B8                     ; 007AE
        move.w  #$7f,(PlayerCellZ).l            ; 007B0
l_008_007B8:
        rts                                     ; 007B8
sub_008_007BA:
        lea.l   (ObjectTable).l,a0              ; 007BA
        move.b  #$10,d7                         ; 007C0
        or.b    d7,$1(a0)                       ; 007C4
        or.b    d7,$201(a0)                     ; 007C8
        or.b    d7,$401(a0)                     ; 007CC
        or.b    d7,$601(a0)                     ; 007D0
        or.b    d7,$801(a0)                     ; 007D4
        or.b    d7,$a01(a0)                     ; 007D8
        or.b    d7,$c01(a0)                     ; 007DC
        or.b    d7,$e01(a0)                     ; 007E0
        or.b    d7,$1001(a0)                    ; 007E4
        or.b    d7,$1201(a0)                    ; 007E8
        or.b    d7,$1401(a0)                    ; 007EC
        or.b    d7,$1601(a0)                    ; 007F0
        or.b    d7,$1801(a0)                    ; 007F4
        or.b    d7,$1a01(a0)                    ; 007F8
        or.b    d7,$1c01(a0)                    ; 007FC
        or.b    d7,$1e01(a0)                    ; 00800
        lea.l   (SmallObjects).l,a0             ; 00804
        or.b    d7,$1(a0)                       ; 0080A
        or.b    d7,$21(a0)                      ; 0080E
        or.b    d7,$41(a0)                      ; 00812
        or.b    d7,$61(a0)                      ; 00816
        or.b    d7,$81(a0)                      ; 0081A
        or.b    d7,$a1(a0)                      ; 0081E
        or.b    d7,$c1(a0)                      ; 00822
        or.b    d7,$e1(a0)                      ; 00826
        or.b    d7,$101(a0)                     ; 0082A
        or.b    d7,$121(a0)                     ; 0082E
        or.b    d7,$141(a0)                     ; 00832
        or.b    d7,$161(a0)                     ; 00836
        or.b    d7,$181(a0)                     ; 0083A
        or.b    d7,$1a1(a0)                     ; 0083E
        or.b    d7,$1c1(a0)                     ; 00842
        or.b    d7,$1e1(a0)                     ; 00846
        rts                                     ; 0084A
sub_008_0084C:
        clr.b   (dat_071_00235).l               ; 0084C
        move.w  (dat_071_0037C).l,(dat_071_0037A).l ; 00852
        bra.b   l_008_00870                     ; 0085C
sub_008_0085E:
        move.b  #$1,(dat_071_00235).l           ; 0085E
        move.w  (dat_071_0037E).l,(dat_071_0037A).l ; 00866
l_008_00870:
        clr.b   (dat_071_00234).l               ; 00870
        clr.b   (dat_071_0028B).l               ; 00876
        move.l  (dat_071_00448).l,d0            ; 0087C
        neg.l   d0                              ; 00882
        cmpi.l  #$7fff,d0                       ; 00884
        ble.b   l_008_00896                     ; 0088A
        move.w  #$7ffe,(dat_071_00382).l        ; 0088C
        bra.b   l_008_008AC                     ; 00894
l_008_00896:
        asr.w   #$7,d0                          ; 00896
        lea.l   (dat_065_00000).l,a2            ; 00898
        move.b  (a2,d0.w),d0                    ; 0089E
        ext.w   d0                              ; 008A2
        asl.w   #$8,d0                          ; 008A4
        move.w  d0,(dat_071_00382).l            ; 008A6
l_008_008AC:
        tst.b   (dat_071_00235).l               ; 008AC
        bne.b   l_008_008BC                     ; 008B2
        lea.l   (dat_073_00232).l,a0            ; 008B4
        bra.b   l_008_008C2                     ; 008BA
l_008_008BC:
        lea.l   (dat_073_008C2).l,a0            ; 008BC
l_008_008C2:
        move.w  (dat_071_0037A).l,d0            ; 008C2
        adda.w  d0,a0                           ; 008C8
        move.w  (a0)+,d7                        ; 008CA
        cmpi.w  #$ffff,d7                       ; 008CC
        beq.w   l_008_009F2                     ; 008D0
        move.b  d7,(dat_071_0022B).l            ; 008D4
        move.b  d7,d0                           ; 008DA
        andi.w  #$f,d0                          ; 008DC
        move.w  d0,(dat_071_00488).l            ; 008E0
        movea.l (a0)+,a1                        ; 008E6
        tst.w   (a1)                            ; 008E8
        blt.w   l_008_009E6                     ; 008EA
        cmpi.l  #l_010_00010,(a1)               ; 008EE
        bne.b   l_008_00904                     ; 008F4
        cmpi.l  #$ffc80000,(dat_071_00436).l    ; 008F6
        blt.w   l_008_009E6                     ; 00900
l_008_00904:
        movem.w (a0)+,d2-d4                     ; 00904
        movem.w d2-d4,(dat_071_004FA).l         ; 00908
        asl.l   #$8,d2                          ; 00910
        asl.l   #$8,d3                          ; 00912
        asl.l   #$8,d4                          ; 00914
        movem.l d2-d4,(dat_071_00500).l         ; 00916
        cmpi.l  #sub_010_00004,(a1)             ; 0091E
        beq.b   l_008_00988                     ; 00924
        move.w  $4(a0),d1                       ; 00926
        ext.l   d1                              ; 0092A
        asl.l   d0,d1                           ; 0092C
        cmpi.l  #$400,d1                        ; 0092E
        bge.b   l_008_00970                     ; 00934
        cmpi.l  #$100,d1                        ; 00936
        blt.b   l_008_0095E                     ; 0093C
        move.w  (FrameCount).l,d0               ; 0093E
        move.w  d7,d1                           ; 00944
        btst    #$8,d1                          ; 00946
        bne.b   l_008_00954                     ; 0094A
        andi.w  #$3,d0                          ; 0094C
        beq.b   l_008_0095E                     ; 00950
        bra.b   l_008_00970                     ; 00952
l_008_00954:
        andi.w  #$3,d0                          ; 00954
        cmpi.w  #$2,d0                          ; 00958
        bne.b   l_008_00970                     ; 0095C
l_008_0095E:
        movem.w (dat_071_004FA).l,d2-d4         ; 0095E
        jsr     (sub_008_01652).l               ; 00966
        move.w  d1,$4(a0)                       ; 0096C
l_008_00970:
        move.w  $8(a0),(dat_071_0048A).l        ; 00970
        bge.b   l_008_00988                     ; 00978
        subq.b  #$1,$6(a0)                      ; 0097A
        bge.b   l_008_009E6                     ; 0097E
        move.b  (dat_071_0028C).l,$6(a0)        ; 00980
l_008_00988:
        subq.b  #$1,$7(a0)                      ; 00988
        move.b  $7(a0),(dat_071_0028D).l        ; 0098C
        move.w  $4(a0),d1                       ; 00994
        move.w  d1,(dat_071_00510).l            ; 00998
        cmp.w   (dat_071_00382).l,d1            ; 0099E
        movea.l (a1)+,a2                        ; 009A4
        movea.l (a1)+,a0                        ; 009A6
        move.l  (a1)+,(dat_071_00406).l         ; 009A8
        move.l  (a1)+,(dat_071_0040A).l         ; 009AE
        lsr.w   #$8,d7                          ; 009B4
        ext.w   d7                              ; 009B6
        move.w  d7,(CurrentObject).l            ; 009B8
        jsr     (a2)                            ; 009BE
        tst.b   (dat_071_00235).l               ; 009C0
        bne.b   l_008_009D0                     ; 009C6
        lea.l   (dat_073_00232).l,a0            ; 009C8
        bra.b   l_008_009D6                     ; 009CE
l_008_009D0:
        lea.l   (dat_073_008C2).l,a0            ; 009D0
l_008_009D6:
        move.w  (dat_071_0037A).l,d1            ; 009D6
        tst.w   d0                              ; 009DC
        bgt.b   l_008_009E2                     ; 009DE
        moveq   #-1,d0                          ; 009E0
l_008_009E2:
        move.w  d0,$14(a0,d1.w)                 ; 009E2
l_008_009E6:
        addi.w  #$18,(dat_071_0037A).l          ; 009E6
        bra.w   l_008_008AC                     ; 009EE
l_008_009F2:
        rts                                     ; 009F2

;-------------------------------------------------------------------------------
; DrawObjects - Draws the objects and the scenery: for each of VisibleObjects, its position
; relative to the view (map cell and position in the cell) and its distance (the largest of
; |dx|, |dy|, |dz|) give its scale (DistanceScale), then its routine of ObjectDrawTable draws
; it; then each entry of SceneryList (sub_008_01652 gives its depth); then the small objects
; near the view.
;-------------------------------------------------------------------------------
DrawObjects:
        move.b  #$1,(dat_071_00234).l           ; 009F4
        move.b  #$4,(dat_071_0022B).l           ; 009FC
        clr.b   (dat_071_0028D).l               ; 00A04
        clr.w   (dat_071_0048A).l               ; 00A0A
        clr.l   (dat_071_00302).l               ; 00A10
        clr.w   (dat_071_0037A).l               ; 00A16
l_008_00A1C:
        lea.l   (VisibleObjects).l,a0           ; 00A1C
        adda.w  (dat_071_0037A).l,a0            ; 00A22
        move.w  (a0),d0                         ; 00A28
        ble.w   l_008_00B70                     ; 00A2A
        lea.l   (ObjectTable).l,a0              ; 00A2E
        move.w  d0,(CurrentObject).l            ; 00A34
        asl.w   #$8,d0                          ; 00A3A
        add.w   d0,d0                           ; 00A3C
        move.w  d0,(CurrentObjectOffset).l      ; 00A3E
        adda.w  d0,a0                           ; 00A44
        moveq   #$0,d7                          ; 00A46
        move.w  $6(a0),d7                       ; 00A48
        sub.w   (ViewCellX).l,d7                ; 00A4C
        swap    d7                              ; 00A52
        asl.l   #$6,d7                          ; 00A54
        move.l  $14(a0),d4                      ; 00A56
        andi.l  #$3fffff,d4                     ; 00A5A
        add.l   d4,d7                           ; 00A60
        moveq   #$0,d6                          ; 00A62
        move.w  $8(a0),d6                       ; 00A64
        sub.w   (ViewCellZ).l,d6                ; 00A68
        swap    d6                              ; 00A6E
        asl.l   #$6,d6                          ; 00A70
        move.l  $1c(a0),d4                      ; 00A72
        andi.l  #$3fffff,d4                     ; 00A76
        add.l   d4,d6                           ; 00A7C
        move.l  d7,d2                           ; 00A7E
        move.l  d6,d4                           ; 00A80
        asr.l   #$8,d7                          ; 00A82
        asr.l   #$8,d6                          ; 00A84
        move.w  (dat_071_00442).l,d0            ; 00A86
        ext.l   d0                              ; 00A8C
        add.l   d0,d7                           ; 00A8E
        bge.b   l_008_00A94                     ; 00A90
        neg.l   d7                              ; 00A92
l_008_00A94:
        asr.l   #$8,d7                          ; 00A94
        asr.l   #$4,d7                          ; 00A96
        move.w  (dat_071_00446).l,d0            ; 00A98
        ext.l   d0                              ; 00A9E
        add.l   d0,d6                           ; 00AA0
        bge.b   l_008_00AA6                     ; 00AA2
        neg.l   d6                              ; 00AA4
l_008_00AA6:
        asr.l   #$8,d6                          ; 00AA6
        asr.l   #$4,d6                          ; 00AA8
        move.l  $10(a0),d0                      ; 00AAA
        add.l   (dat_071_00448).l,d0            ; 00AAE
        bge.b   l_008_00AB8                     ; 00AB4
        neg.l   d0                              ; 00AB6
l_008_00AB8:
        asr.l   #$8,d0                          ; 00AB8
        asr.l   #$3,d0                          ; 00ABA
        cmp.w   d6,d7                           ; 00ABC
        bge.b   l_008_00ACA                     ; 00ABE
        move.w  d6,d7                           ; 00AC0
        cmp.w   d0,d7                           ; 00AC2
        bge.b   l_008_00AD0                     ; 00AC4
        move.w  d0,d7                           ; 00AC6
        bra.b   l_008_00AD0                     ; 00AC8
l_008_00ACA:
        cmp.w   d0,d7                           ; 00ACA
        bge.b   l_008_00AD0                     ; 00ACC
        move.w  d0,d7                           ; 00ACE
l_008_00AD0:
        lsr.w   #$1,d7                          ; 00AD0
        cmpi.w  #$ef,d7                         ; 00AD2
        ble.b   l_008_00AEA                     ; 00AD6
        move.w  #$29,(dat_071_0036E).l          ; 00AD8
        jsr     (Nop).l                         ; 00AE0
        move.w  #$ef,d7                         ; 00AE6
l_008_00AEA:
        lea.l   (DistanceScale).l,a1            ; 00AEA
        move.b  (a1,d7.w),d6                    ; 00AF0
        ext.w   d6                              ; 00AF4
        move.w  d6,(dat_071_00488).l            ; 00AF6
        move.l  $18(a0),d3                      ; 00AFC
        move.l  d3,d0                           ; 00B00
        add.l   (dat_071_00436).l,d0            ; 00B02
        asr.l   d6,d0                           ; 00B08
        move.l  d0,(dat_071_0050C).l            ; 00B0A
        move.b  #$1,(dat_071_0028B).l           ; 00B10
        asr.l   d6,d2                           ; 00B18
        asr.l   d6,d3                           ; 00B1A
        asr.l   d6,d4                           ; 00B1C
        movem.l d2-d4,(dat_071_00500).l         ; 00B1E
        asr.l   #$8,d2                          ; 00B26
        asr.l   #$8,d3                          ; 00B28
        asr.l   #$8,d4                          ; 00B2A
        movem.w d2-d4,(dat_071_004FA).l         ; 00B2C
        jsr     (sub_008_01652).l               ; 00B34
        lea.l   (ObjectDrawTable).l,a1          ; 00B3A
        move.w  (CurrentObject).l,d1            ; 00B40
        add.w   d1,d1                           ; 00B46
        add.w   d1,d1                           ; 00B48
        move.w  d1,d7                           ; 00B4A
        add.w   d1,d1                           ; 00B4C
        add.w   d1,d1                           ; 00B4E
        add.w   d7,d1                           ; 00B50
        adda.w  d1,a1                           ; 00B52
        movea.l (a1)+,a2                        ; 00B54
        movea.l (a1)+,a0                        ; 00B56
        move.l  (a1)+,(dat_071_00406).l         ; 00B58
        move.l  (a1)+,(dat_071_0040A).l         ; 00B5E
        jsr     (a2)                            ; 00B64
        addq.w  #$2,(dat_071_0037A).l           ; 00B66
        bra.w   l_008_00A1C                     ; 00B6C
l_008_00B70:
        move.w  (dat_071_00380).l,(dat_071_0037A).l ; 00B70
l_008_00B7A:
        lea.l   (SceneryList).l,a0              ; 00B7A
        move.w  (dat_071_0037A).l,d0            ; 00B80
        adda.w  d0,a0                           ; 00B86
        move.w  (a0)+,d7                        ; 00B88
        cmpi.w  #$ffff,d7                       ; 00B8A
        beq.w   l_008_00D0E                     ; 00B8E
        move.b  d7,(dat_071_0022B).l            ; 00B92
        move.b  d7,d0                           ; 00B98
        andi.w  #$f,d0                          ; 00B9A
        move.w  d0,(dat_071_00488).l            ; 00B9E
        movea.l (a0)+,a1                        ; 00BA4
        tst.w   (a1)                            ; 00BA6
        blt.w   l_008_00CF6                     ; 00BA8
        cmpi.l  #l_010_00010,(a1)               ; 00BAC
        bne.b   l_008_00BC2                     ; 00BB2
        cmpi.l  #$ffc00000,(dat_071_00436).l    ; 00BB4
        blt.w   l_008_00CF6                     ; 00BBE
l_008_00BC2:
        movem.w (a0)+,d2-d4                     ; 00BC2
        move.l  (a0),(dat_071_00302).l          ; 00BC6
        move.w  d7,d1                           ; 00BCC
        lsr.w   #$8,d1                          ; 00BCE
        move.w  d1,(CurrentObject).l            ; 00BD0
        clr.b   (dat_071_0028B).l               ; 00BD6
        btst    #$6,d7                          ; 00BDC
        bne.w   l_008_00BFA                     ; 00BE0
        btst    #$4,d7                          ; 00BE4
        bne.b   l_008_00C00                     ; 00BE8
        movem.w d2-d4,(dat_071_004FA).l         ; 00BEA
        asl.l   #$8,d2                          ; 00BF2
        asl.l   #$8,d3                          ; 00BF4
        asl.l   #$8,d4                          ; 00BF6
        bra.b   l_008_00C1C                     ; 00BF8
l_008_00BFA:
        bsr.w   sub_008_00DDC                   ; 00BFA
        bra.b   l_008_00C04                     ; 00BFE
l_008_00C00:
        bsr.w   sub_008_00DEE                   ; 00C00
l_008_00C04:
        movem.l d2-d4,(dat_071_00500).l         ; 00C04
        asr.l   #$8,d2                          ; 00C0C
        asr.l   #$8,d3                          ; 00C0E
        asr.l   #$8,d4                          ; 00C10
        movem.w d2-d4,(dat_071_004FA).l         ; 00C12
        bra.b   l_008_00C24                     ; 00C1A
l_008_00C1C:
        movem.l d2-d4,(dat_071_00500).l         ; 00C1C
l_008_00C24:
        move.w  $4(a0),d1                       ; 00C24
        ext.l   d1                              ; 00C28
        asl.l   d0,d1                           ; 00C2A
        cmpi.l  #$400,d1                        ; 00C2C
        bge.b   l_008_00C6E                     ; 00C32
        cmpi.l  #$100,d1                        ; 00C34
        blt.b   l_008_00C5C                     ; 00C3A
        move.w  (FrameCount).l,d0               ; 00C3C
        move.w  d7,d1                           ; 00C42
        btst    #$8,d1                          ; 00C44
        bne.b   l_008_00C52                     ; 00C48
        andi.w  #$3,d0                          ; 00C4A
        beq.b   l_008_00C5C                     ; 00C4E
        bra.b   l_008_00C6E                     ; 00C50
l_008_00C52:
        andi.w  #$3,d0                          ; 00C52
        cmpi.w  #$2,d0                          ; 00C56
        bne.b   l_008_00C6E                     ; 00C5A
l_008_00C5C:
        movem.w (dat_071_004FA).l,d2-d4         ; 00C5C
        jsr     (sub_008_01652).l               ; 00C64
        move.w  d1,$4(a0)                       ; 00C6A
l_008_00C6E:
        btst    #$6,d7                          ; 00C6E
        bne.b   l_008_00C92                     ; 00C72
        btst    #$4,d7                          ; 00C74
        bne.b   l_008_00C92                     ; 00C78
        move.w  $8(a0),(dat_071_0048A).l        ; 00C7A
        bge.b   l_008_00C92                     ; 00C82
        subq.b  #$1,$6(a0)                      ; 00C84
        bge.b   l_008_00CF6                     ; 00C88
        move.b  (dat_071_0028C).l,$6(a0)        ; 00C8A
l_008_00C92:
        subq.b  #$1,$7(a0)                      ; 00C92
        move.b  $7(a0),(dat_071_0028D).l        ; 00C96
        move.w  $4(a0),d1                       ; 00C9E
        move.w  d1,(dat_071_00510).l            ; 00CA2
        andi.w  #$ff00,d7                       ; 00CA8
        add.w   d7,d7                           ; 00CAC
        move.w  d7,(CurrentObjectOffset).l      ; 00CAE
        cmp.w   (ViewObject).l,d7               ; 00CB4
        bne.b   l_008_00CCE                     ; 00CBA
        tst.b   (dat_071_00155).l               ; 00CBC
        bne.b   l_008_00CC8                     ; 00CC2
        move.w  #$7fff,d1                       ; 00CC4
l_008_00CC8:
        move.w  d1,(dat_071_00512).l            ; 00CC8
l_008_00CCE:
        movea.l (a1)+,a2                        ; 00CCE
        movea.l (a1)+,a0                        ; 00CD0
        move.l  (a1)+,(dat_071_00406).l         ; 00CD2
        move.l  (a1)+,(dat_071_0040A).l         ; 00CD8
        jsr     (a2)                            ; 00CDE
        lea.l   (SceneryList).l,a0              ; 00CE0
        move.w  (dat_071_0037A).l,d1            ; 00CE6
        tst.w   d0                              ; 00CEC
        bgt.b   l_008_00CF2                     ; 00CEE
        moveq   #-1,d0                          ; 00CF0
l_008_00CF2:
        move.w  d0,$14(a0,d1.w)                 ; 00CF2
l_008_00CF6:
        addi.w  #$18,(dat_071_0037A).l          ; 00CF6
        bra.w   l_008_00B7A                     ; 00CFE
	dc.b	$06,$79,$00,$18
        dc.l    dat_071_0037A                   ; 00D06
	dc.b	$60,$00,$FE,$6E
l_008_00D0E:
        clr.b   (dat_071_00205).l               ; 00D0E
        clr.b   (dat_071_00208).l               ; 00D14
        tst.b   (dat_071_00155).l               ; 00D1A
        bne.w   l_008_00DDA                     ; 00D20
        cmpi.b  #$1,(dat_071_00207).l           ; 00D24
        bgt.b   l_008_00D4C                     ; 00D2C
        move.w  (FrameCount).l,d0               ; 00D2E
        move.w  d0,d1                           ; 00D34
        andi.w  #$2,d1                          ; 00D36
        bne.b   l_008_00D42                     ; 00D3A
        addq.b  #$1,(dat_071_00208).l           ; 00D3C
l_008_00D42:
        andi.w  #$3,d0                          ; 00D42
        bne.w   l_008_00DDA                     ; 00D46
        bra.b   l_008_00D52                     ; 00D4A
l_008_00D4C:
        addq.b  #$1,(dat_071_00208).l           ; 00D4C
l_008_00D52:
        clr.w   (dat_071_0037A).l               ; 00D52
        lea.l   (ObjectTable).l,a1              ; 00D58
        moveq   #$0,d0                          ; 00D5E
l_008_00D60:
        move.w  (ViewObject).l,d1               ; 00D60
        cmp.w   d1,d0                           ; 00D66
        beq.b   l_008_00DD0                     ; 00D68
        btst    #$6,$1(a1,d0.w)                 ; 00D6A
        beq.b   l_008_00DD0                     ; 00D70
        movem.l $14(a1,d0.w),d2-d4              ; 00D72
        sub.l   $14(a1,d1.w),d2                 ; 00D78
        sub.l   $18(a1,d1.w),d3                 ; 00D7C
        sub.l   $1c(a1,d1.w),d4                 ; 00D80
        move.l  d2,d5                           ; 00D84
        bge.b   l_008_00D8A                     ; 00D86
        neg.l   d5                              ; 00D88
l_008_00D8A:
        move.l  d3,d6                           ; 00D8A
        bge.b   l_008_00D90                     ; 00D8C
        neg.l   d6                              ; 00D8E
l_008_00D90:
        move.l  d4,d7                           ; 00D90
        bge.b   l_008_00D96                     ; 00D92
        neg.l   d7                              ; 00D94
l_008_00D96:
        cmp.l   d5,d6                           ; 00D96
        blt.b   l_008_00DA2                     ; 00D98
        cmp.l   d6,d7                           ; 00D9A
        bgt.b   l_008_00DA8                     ; 00D9C
        move.l  d6,d7                           ; 00D9E
        bra.b   l_008_00DA8                     ; 00DA0
l_008_00DA2:
        cmp.l   d5,d7                           ; 00DA2
        bgt.b   l_008_00DA8                     ; 00DA4
        move.l  d5,d7                           ; 00DA6
l_008_00DA8:
        moveq   #$0,d1                          ; 00DA8
l_008_00DAA:
        cmpi.l  #$7fffff,d7                     ; 00DAA
        ble.b   l_008_00DB8                     ; 00DB0
        addq.w  #$2,d1                          ; 00DB2
        asr.l   #$2,d7                          ; 00DB4
        bra.b   l_008_00DAA                     ; 00DB6
l_008_00DB8:
        move.w  d1,d5                           ; 00DB8
        addq.w  #$8,d5                          ; 00DBA
        asr.l   d5,d2                           ; 00DBC
        asr.l   d5,d3                           ; 00DBE
        asr.l   d5,d4                           ; 00DC0
        move.w  d0,d7                           ; 00DC2
        asr.w   #$1,d7                          ; 00DC4
        bset    #$4,d7                          ; 00DC6
        jsr     (sub_020_00AC6).l               ; 00DCA
l_008_00DD0:
        addi.w  #$200,d0                        ; 00DD0
        cmpi.w  #$2000,d0                       ; 00DD4
        blt.b   l_008_00D60                     ; 00DD8
l_008_00DDA:
        rts                                     ; 00DDA
sub_008_00DDC:
        lea.l   (SmallObjects).l,a2             ; 00DDC
        move.w  d7,d1                           ; 00DE2
        move.w  d7,d6                           ; 00DE4
        andi.w  #$ff00,d1                       ; 00DE6
        asr.w   #$3,d1                          ; 00DEA
        bra.b   l_008_00DFE                     ; 00DEC
sub_008_00DEE:
        lea.l   (ObjectTable).l,a2              ; 00DEE
        move.w  d7,d1                           ; 00DF4
        move.w  d7,d6                           ; 00DF6
        andi.w  #$ff00,d1                       ; 00DF8
        add.w   d1,d1                           ; 00DFC
l_008_00DFE:
        adda.w  d1,a2                           ; 00DFE
        andi.w  #$f,d6                          ; 00E00
        move.l  $14(a2),d3                      ; 00E04
        andi.l  #$fffff,d3                      ; 00E08
        asr.l   d6,d3                           ; 00E0E
        asl.l   #$8,d2                          ; 00E10
        add.l   d3,d2                           ; 00E12
        move.l  $1c(a2),d3                      ; 00E14
        andi.l  #$fffff,d3                      ; 00E18
        asr.l   d6,d3                           ; 00E1E
        asl.l   #$8,d4                          ; 00E20
        add.l   d3,d4                           ; 00E22
        move.l  $18(a2),d3                      ; 00E24
        move.l  d3,d1                           ; 00E28
        asr.l   d6,d3                           ; 00E2A
        add.l   (dat_071_00436).l,d1            ; 00E2C
        asr.l   d6,d1                           ; 00E32
        move.l  d1,(dat_071_0050C).l            ; 00E34
        move.b  #$1,(dat_071_0028B).l           ; 00E3A
        rts                                     ; 00E42
sub_008_00E44:
        link.w  a6,#$ffc4                       ; 00E44
        clr.b   (dat_071_00226).l               ; 00E48
        tst.b   (dat_071_00234).l               ; 00E4E
        beq.w   l_008_00EBE                     ; 00E54
        tst.b   (dat_071_00156).l               ; 00E58
        beq.b   l_008_00E6A                     ; 00E5E
        move.l  #dat_065_0011E,-$c(a6)          ; 00E60
        bra.b   l_008_00E72                     ; 00E68
l_008_00E6A:
        move.l  #dat_065_00380,-$c(a6)          ; 00E6A
l_008_00E72:
        move.l  #SceneryList,-$14(a6)           ; 00E72
        move.l  #dat_071_00380,-$24(a6)         ; 00E7A
        move.l  #dat_066_00200,-$4(a6)          ; 00E82
        move.l  #dat_002_02094,-$8(a6)          ; 00E8A
        move.l  #dat_008_0155A,-$18(a6)         ; 00E92
        move.l  #dat_008_015AE,-$1c(a6)         ; 00E9A
        move.w  (ViewCellX).l,-$26(a6)          ; 00EA2
        move.w  (ViewCellZ).l,-$28(a6)          ; 00EAA
        move.b  (ViewSubCell).l,-$2a(a6)        ; 00EB2
        bra.w   l_008_00F6C                     ; 00EBA
l_008_00EBE:
        move.l  #dat_065_00380,-$c(a6)          ; 00EBE
        tst.b   (dat_071_00235).l               ; 00EC6
        bne.b   l_008_00EEA                     ; 00ECC
        cmpi.l  #$ffff6000,(dat_071_00436).l    ; 00ECE
        ble.b   l_008_00EEA                     ; 00ED8
        move.l  #dat_065_00F62,-$c(a6)          ; 00EDA
        addq.b  #$1,(dat_071_00226).l           ; 00EE2
        bra.b   l_008_00EFA                     ; 00EE8
l_008_00EEA:
        tst.b   (dat_071_00156).l               ; 00EEA
        beq.b   l_008_00EFA                     ; 00EF0
        move.l  #dat_065_0011E,-$c(a6)          ; 00EF2
l_008_00EFA:
        tst.b   (dat_071_00235).l               ; 00EFA
        bne.b   l_008_00F24                     ; 00F00
        move.l  #dat_066_00000,-$4(a6)          ; 00F02
        move.l  #dat_002_01094,-$8(a6)          ; 00F0A
        move.l  #dat_073_00232,-$14(a6)         ; 00F12
        move.l  #dat_071_0037C,-$24(a6)         ; 00F1A
        bra.b   l_008_00F44                     ; 00F22
l_008_00F24:
        move.l  #dat_066_00100,-$4(a6)          ; 00F24
        move.l  #dat_002_01894,-$8(a6)          ; 00F2C
        move.l  #dat_073_008C2,-$14(a6)         ; 00F34
        move.l  #dat_071_0037E,-$24(a6)         ; 00F3C
l_008_00F44:
        move.l  #dat_008_014C6,-$18(a6)         ; 00F44
        move.l  #dat_008_0151A,-$1c(a6)         ; 00F4C
        move.w  (dat_071_00318).l,-$26(a6)      ; 00F54
        move.w  (dat_071_0031A).l,-$28(a6)      ; 00F5C
        move.b  (dat_071_00220).l,-$2a(a6)      ; 00F64
l_008_00F6C:
        lea.l   (dat_065_00040).l,a1            ; 00F6C
        move.b  -$2a(a6),d0                     ; 00F72
        ext.w   d0                              ; 00F76
        move.b  (a1,d0.w),d0                    ; 00F78
        ext.w   d0                              ; 00F7C
        asl.w   #$3,d0                          ; 00F7E
        lea.l   (dat_065_00050).l,a1            ; 00F80
        adda.w  d0,a1                           ; 00F86
        move.l  a1,-$36(a6)                     ; 00F88
        move.w  d0,d1                           ; 00F8C
        add.w   d0,d0                           ; 00F8E
        lea.l   (dat_065_00080).l,a1            ; 00F90
        adda.w  d0,a1                           ; 00F96
        move.l  a1,-$32(a6)                     ; 00F98
        add.w   d1,d0                           ; 00F9C
        lea.l   (dat_065_000C0).l,a1            ; 00F9E
        adda.w  d0,a1                           ; 00FA4
        move.l  a1,-$3a(a6)                     ; 00FA6
        lea.l   (dat_072_00000).l,a1            ; 00FAA
        move.w  #$ffff,d0                       ; 00FB0
        move.w  #$60,d1                         ; 00FB4
        moveq   #$d,d2                          ; 00FB8
l_008_00FBA:
        bsr.w   sub_008_0145A                   ; 00FBA
        dbra    d2,l_008_00FBA                  ; 00FBE
        tst.b   (dat_071_00226).l               ; 00FC2
        bne.b   l_008_00FF8                     ; 00FC8
        move.b  -$2a(a6),d0                     ; 00FCA
        ext.w   d0                              ; 00FCE
        lea.l   (dat_065_00070).l,a0            ; 00FD0
        move.b  (a0,d0.w),d0                    ; 00FD6
        ext.w   d0                              ; 00FDA
        tst.b   (dat_071_00156).l               ; 00FDC
        bne.b   l_008_01034                     ; 00FE2
        asl.w   #$4,d0                          ; 00FE4
        move.b  (dat_071_00224).l,d1            ; 00FE6
        movea.l -$36(a6),a0                     ; 00FEC
        ext.w   d1                              ; 00FF0
        move.b  (a0,d1.w),d1                    ; 00FF2
        bra.b   l_008_01054                     ; 00FF6
l_008_00FF8:
        move.b  (dat_071_00220).l,d0            ; 00FF8
        ext.w   d0                              ; 00FFE
        move.w  d0,d1                           ; 01000
        lea.l   (dat_065_00070).l,a0            ; 01002
        move.b  (a0,d0.w),d0                    ; 01008
        ext.w   d0                              ; 0100C
        asl.w   #$5,d0                          ; 0100E
        lea.l   (dat_065_00040).l,a1            ; 01010
        move.b  (a1,d1.w),d1                    ; 01016
        ext.w   d1                              ; 0101A
        asl.w   #$4,d1                          ; 0101C
        lea.l   (dat_065_00080).l,a1            ; 0101E
        adda.w  d1,a1                           ; 01024
        move.b  (ViewSubCell).l,d1              ; 01026
        ext.w   d1                              ; 0102C
        move.b  (a1,d1.w),d1                    ; 0102E
        bra.b   l_008_01054                     ; 01032
l_008_01034:
        lea.l   (dat_065_00070).l,a0            ; 01034
        move.b  (a0,d0.w),d0                    ; 0103A
        ext.w   d0                              ; 0103E
        add.w   d0,d0                           ; 01040
        bra.b   l_008_0105A                     ; 01042
l_008_01044:
        move.w  #$42,(dat_071_0036E).l          ; 01044
        jsr     (Nop).l                         ; 0104C
        bra.b   l_008_01044                     ; 01052
l_008_01054:
        ext.w   d1                              ; 01054
        add.w   d1,d1                           ; 01056
        add.w   d1,d0                           ; 01058
l_008_0105A:
        movea.l -$c(a6),a0                      ; 0105A
        move.w  (a0,d0.w),d0                    ; 0105E
        ble.b   l_008_01044                     ; 01062
        adda.w  d0,a0                           ; 01064
        move.l  a0,-(a7)                        ; 01066
        lea.l   (dat_072_00000).l,a3            ; 01068
        moveq   #$e,d4                          ; 0106E
l_008_01070:
        move.b  (a0)+,d0                        ; 01070
        blt.w   l_008_0111E                     ; 01072
        subq.w  #$1,d4                          ; 01076
        blt.w   l_008_0110E                     ; 01078
        cmpi.b  #$14,d0                         ; 0107C
        bgt.b   l_008_010FE                     ; 01080
        ext.w   d0                              ; 01082
        movea.l -$3a(a6),a2                     ; 01084
        move.b  (a2,d0.w),d0                    ; 01088
        ext.w   d0                              ; 0108C
        add.w   d0,d0                           ; 0108E
        lea.l   (dat_008_0149C).l,a2            ; 01090
        tst.b   (dat_071_00234).l               ; 01096
        bne.b   l_008_010A4                     ; 0109C
        move.w  #$1e,d3                         ; 0109E
        bra.b   l_008_010A8                     ; 010A2
l_008_010A4:
        move.w  #$7f,d3                         ; 010A4
l_008_010A8:
        move.b  (a2,d0.w),d2                    ; 010A8
        ext.w   d2                              ; 010AC
        move.w  -$26(a6),d1                     ; 010AE
        add.w   d2,d1                           ; 010B2
        blt.b   l_008_010CE                     ; 010B4
        cmp.w   d3,d1                           ; 010B6
        bgt.b   l_008_010D2                     ; 010B8
l_008_010BA:
        move.b  $1(a2,d0.w),d2                  ; 010BA
        ext.w   d2                              ; 010BE
        move.w  -$28(a6),d0                     ; 010C0
        add.w   d2,d0                           ; 010C4
        blt.b   l_008_010D8                     ; 010C6
        cmp.w   d3,d0                           ; 010C8
        ble.b   l_008_010EA                     ; 010CA
        bra.b   l_008_010DC                     ; 010CC
l_008_010CE:
        move.w  d3,d1                           ; 010CE
        bra.b   l_008_010BA                     ; 010D0
l_008_010D2:
        move.w  #$0,d1                          ; 010D2
        bra.b   l_008_010BA                     ; 010D6
l_008_010D8:
        move.w  d3,d0                           ; 010D8
        bra.b   l_008_010EA                     ; 010DA
l_008_010DC:
        move.w  #$0,d0                          ; 010DC
        bra.b   l_008_010EA                     ; 010E0
	dc.b	$32,$3C,$00,$10,$30,$3C,$00,$00
l_008_010EA:
        lea.l   (a3),a1                         ; 010EA
        bsr.w   sub_008_0112C                   ; 010EC
        move.b  (a0)+,d0                        ; 010F0
        ext.w   d0                              ; 010F2
        adda.w  d0,a0                           ; 010F4
        adda.w  #$600,a3                        ; 010F6
        bra.w   l_008_01070                     ; 010FA
l_008_010FE:
        move.w  #$c,(dat_071_0036E).l           ; 010FE
        jsr     (Nop).l                         ; 01106
        bra.b   l_008_010FE                     ; 0110C
l_008_0110E:
        move.w  #$d,(dat_071_0036E).l           ; 0110E
        jsr     (Nop).l                         ; 01116
        bra.b   l_008_0110E                     ; 0111C
l_008_0111E:
        move.w  #$52,(FrameStage).l             ; 0111E
        jmp     (l_009_00020).l                 ; 01126
sub_008_0112C:
        movem.l d2-d5/a0-a5,-(a7)               ; 0112C
        move.w  d0,d2                           ; 01130
        move.w  d1,d3                           ; 01132
        movea.l -$4(a6),a0                      ; 01134
        add.w   d0,d0                           ; 01138
        adda.w  (a0,d0.w),a0                    ; 0113A
        tst.w   (a0)                            ; 0113E
        blt.w   l_008_01212                     ; 01140
        asl.w   #$3,d0                          ; 01144
        move.w  d1,d6                           ; 01146
        move.w  d1,d4                           ; 01148
        asr.w   #$5,d6                          ; 0114A
        add.w   d6,d6                           ; 0114C
        add.w   d6,d6                           ; 0114E
        add.w   d0,d6                           ; 01150
        andi.w  #$1f,d4                         ; 01152
        movea.l -$8(a6),a5                      ; 01156
        move.l  (a5,d6.w),d5                    ; 0115A
        btst    d4,d5                           ; 0115E
        beq.w   l_008_01212                     ; 01160
        lea.l   (a0),a5                         ; 01164
        adda.w  (a0),a5                         ; 01166
        addq.l  #$2,a5                          ; 01168
        bsr.w   sub_008_0121C                   ; 0116A
        add.w   d0,d0                           ; 0116E
        add.w   d0,d0                           ; 01170
        movea.l (a5,d0.w),a5                    ; 01172
        move.b  #$ff,d1                         ; 01176
l_008_0117A:
        move.b  (a5)+,d0                        ; 0117A
        cmpi.b  #$ff,d0                         ; 0117C
        beq.w   l_008_0120E                     ; 01180
        move.b  d0,d6                           ; 01184
        andi.b  #$f,d0                          ; 01186
        cmp.b   d0,d1                           ; 0118A
        beq.b   l_008_011B4                     ; 0118C
        bsr.w   FindObjectsInCell               ; 0118E
        moveq   #$10,d5                         ; 01192
        move.b  d0,d1                           ; 01194
        ext.w   d0                              ; 01196
        asl.w   #$5,d0                          ; 01198
        move.w  d0,d7                           ; 0119A
        add.w   d0,d0                           ; 0119C
        add.w   d7,d0                           ; 0119E
        lea.l   (a1,d0.w),a2                    ; 011A0
        move.l  a2,(dat_071_003FE).l            ; 011A4
        addi.l  #$5d,(dat_071_003FE).l          ; 011AA
l_008_011B4:
        subq.b  #$1,d5                          ; 011B4
        blt.b   l_008_011FE                     ; 011B6
        cmpa.l  (dat_071_003FE).l,a2            ; 011B8
        bge.b   l_008_0120E                     ; 011BE
        move.b  (a5)+,d7                        ; 011C0
        move.b  d7,d0                           ; 011C2
        andi.b  #$80,d7                         ; 011C4
        move.b  d7,(a2)+                        ; 011C8
        andi.b  #$7f,d0                         ; 011CA
        move.b  d0,(a2)+                        ; 011CE
        btst    #$7,d7                          ; 011D0
        beq.b   l_008_011F4                     ; 011D4
        lsr.b   #$4,d6                          ; 011D6
        andi.w  #$f,d6                          ; 011D8
        add.w   d6,d6                           ; 011DC
        lea.l   (dat_008_015EE).l,a3            ; 011DE
        move.b  (a3,d6.w),d0                    ; 011E4
        ext.w   d0                              ; 011E8
        move.w  d0,(a2)+                        ; 011EA
        move.b  $1(a3,d6.w),d0                  ; 011EC
        move.w  d0,(a2)+                        ; 011F0
        bra.b   l_008_011F6                     ; 011F2
l_008_011F4:
        move.l  (a5)+,(a2)+                     ; 011F4
l_008_011F6:
        move.b  #$ff,(a2)                       ; 011F6
        bra.w   l_008_0117A                     ; 011FA
l_008_011FE:
        move.w  #$38,(dat_071_0036E).l          ; 011FE
        jsr     (Nop).l                         ; 01206
        bra.b   l_008_011FE                     ; 0120C
l_008_0120E:
        bsr.w   FindObjectsInCell               ; 0120E
l_008_01212:
        bsr.w   sub_008_01310                   ; 01212
        movem.l (a7)+,d2-d5/a0-a5               ; 01216
        rts                                     ; 0121A
sub_008_0121C:
        moveq   #$0,d6                          ; 0121C
        move.w  (a0)+,d7                        ; 0121E
        asr.w   #$1,d7                          ; 01220
l_008_01222:
        move.w  d7,d0                           ; 01222
        sub.w   d6,d0                           ; 01224
        blt.b   l_008_01246                     ; 01226
        asr.w   #$1,d0                          ; 01228
        add.w   d6,d0                           ; 0122A
        move.w  d0,d4                           ; 0122C
        add.w   d4,d4                           ; 0122E
        cmp.w   (a0,d4.w),d1                    ; 01230
        beq.b   l_008_01244                     ; 01234
        blt.b   l_008_0123E                     ; 01236
        move.w  d0,d6                           ; 01238
        addq.w  #$1,d6                          ; 0123A
        bra.b   l_008_01222                     ; 0123C
l_008_0123E:
        move.w  d0,d7                           ; 0123E
        subq.w  #$1,d7                          ; 01240
        bra.b   l_008_01222                     ; 01242
l_008_01244:
        rts                                     ; 01244
l_008_01246:
        move.w  #$1c,(dat_071_0036E).l          ; 01246
        jsr     (Nop).l                         ; 0124E
        rts                                     ; 01254
l_008_01256:
        rts                                     ; 01256

;-------------------------------------------------------------------------------
; FindObjectsInCell - Finds the objects (ObjectTable, then SmallObjects) that are in the map
; cell d3 = X, d2 = Z, d1 = sub-cell and are marked for drawing (+$01 bit 4): clears the mark
; and writes an entry at (a2)+ for each ($10 for an object, $40 for a small object; its number;
; $FF).
;-------------------------------------------------------------------------------
FindObjectsInCell:
        tst.b   d1                              ; 01258
        blt.b   l_008_01256                     ; 0125A
        tst.b   (dat_071_00234).l               ; 0125C
        beq.b   l_008_01256                     ; 01262
        move.w  #$50,(FrameStage).l             ; 01264
        move.l  d6,-(a7)                        ; 0126C
        lea.l   (ObjectTable).l,a0              ; 0126E
        moveq   #$0,d6                          ; 01274
l_008_01276:
        btst    #$6,$1(a0)                      ; 01276
        beq.b   l_008_012A8                     ; 0127C
        btst    #$4,$1(a0)                      ; 0127E
        beq.b   l_008_012A8                     ; 01284
        cmp.w   $6(a0),d3                       ; 01286
        bne.b   l_008_012A8                     ; 0128A
        cmp.w   $8(a0),d2                       ; 0128C
        bne.b   l_008_012A8                     ; 01290
        cmp.b   $a(a0),d1                       ; 01292
        bne.b   l_008_012A8                     ; 01296
        bclr    #$4,$1(a0)                      ; 01298
        move.b  #$10,(a2)+                      ; 0129E
        move.b  d6,(a2)+                        ; 012A2
        move.b  #$ff,(a2)                       ; 012A4
l_008_012A8:
        adda.w  #$200,a0                        ; 012A8
        addq.b  #$1,d6                          ; 012AC
        cmpi.b  #$10,d6                         ; 012AE
        blt.b   l_008_01276                     ; 012B2
        lea.l   (SmallObjects).l,a0             ; 012B4
        moveq   #$0,d6                          ; 012BA
l_008_012BC:
        btst    #$6,$1(a0)                      ; 012BC
        beq.b   l_008_012EE                     ; 012C2
        btst    #$4,$1(a0)                      ; 012C4
        beq.b   l_008_012EE                     ; 012CA
        cmp.w   $6(a0),d3                       ; 012CC
        bne.b   l_008_012EE                     ; 012D0
        cmp.w   $8(a0),d2                       ; 012D2
        bne.b   l_008_012EE                     ; 012D6
        cmp.b   $a(a0),d1                       ; 012D8
        bne.b   l_008_012EE                     ; 012DC
        bclr    #$4,$1(a0)                      ; 012DE
        move.b  #$40,(a2)+                      ; 012E4
        move.b  d6,(a2)+                        ; 012E8
        move.b  #$ff,(a2)                       ; 012EA
l_008_012EE:
        adda.w  #$20,a0                         ; 012EE
        addq.b  #$1,d6                          ; 012F2
        cmpi.b  #$10,d6                         ; 012F4
        blt.b   l_008_012BC                     ; 012F8
        move.l  (a7)+,d6                        ; 012FA
        rts                                     ; 012FC
l_008_012FE:
        move.w  #$e,(dat_071_0036E).l           ; 012FE
        jsr     (Nop).l                         ; 01306
        bra.b   l_008_012FE                     ; 0130C
l_008_0130E:
        rts                                     ; 0130E
sub_008_01310:
        tst.b   (dat_071_00234).l               ; 01310
        beq.b   l_008_0130E                     ; 01316
        move.w  #$51,(FrameStage).l             ; 01318
        move.b  #$ff,d1                         ; 01320
        lea.l   (ObjectTable).l,a0              ; 01324
        moveq   #$0,d6                          ; 0132A
l_008_0132C:
        btst    #$6,$1(a0)                      ; 0132C
        beq.b   l_008_013A6                     ; 01332
        btst    #$4,$1(a0)                      ; 01334
        beq.b   l_008_013A6                     ; 0133A
        cmp.w   $6(a0),d3                       ; 0133C
        bne.b   l_008_013A6                     ; 01340
        cmp.w   $8(a0),d2                       ; 01342
        bne.b   l_008_013A6                     ; 01346
        move.b  $a(a0),d4                       ; 01348
        cmp.b   d4,d1                           ; 0134C
        beq.b   l_008_01396                     ; 0134E
        move.b  d4,d1                           ; 01350
        blt.b   l_008_012FE                     ; 01352
        ext.w   d4                              ; 01354
        swap    d1                              ; 01356
        asl.w   #$5,d4                          ; 01358
        move.w  d4,d1                           ; 0135A
        add.w   d4,d4                           ; 0135C
        add.w   d1,d4                           ; 0135E
        swap    d1                              ; 01360
        lea.l   (a1,d4.w),a2                    ; 01362
        move.l  a2,(dat_071_003FE).l            ; 01366
        addi.l  #$5d,(dat_071_003FE).l          ; 0136C
l_008_01376:
        cmpa.l  (dat_071_003FE).l,a2            ; 01376
        bge.b   l_008_0130E                     ; 0137C
        move.b  (a2),d4                         ; 0137E
        blt.b   l_008_01396                     ; 01380
        btst    #$4,d4                          ; 01382
        bne.b   l_008_01392                     ; 01386
        btst    #$6,d4                          ; 01388
        bne.b   l_008_01392                     ; 0138C
        addq.w  #$4,a2                          ; 0138E
        bra.b   l_008_01376                     ; 01390
l_008_01392:
        addq.w  #$2,a2                          ; 01392
        bra.b   l_008_01376                     ; 01394
l_008_01396:
        bclr    #$4,$1(a0)                      ; 01396
        move.b  #$10,(a2)+                      ; 0139C
        move.b  d6,(a2)+                        ; 013A0
        move.b  #$ff,(a2)                       ; 013A2
l_008_013A6:
        adda.w  #$200,a0                        ; 013A6
        addq.b  #$1,d6                          ; 013AA
        cmpi.b  #$10,d6                         ; 013AC
        blt.w   l_008_0132C                     ; 013B0
        move.b  #$ff,d1                         ; 013B4
        lea.l   (SmallObjects).l,a0             ; 013B8
        moveq   #$0,d6                          ; 013BE
l_008_013C0:
        btst    #$6,$1(a0)                      ; 013C0
        beq.b   l_008_0143A                     ; 013C6
        btst    #$4,$1(a0)                      ; 013C8
        beq.b   l_008_0143A                     ; 013CE
        cmp.w   $6(a0),d3                       ; 013D0
        bne.b   l_008_0143A                     ; 013D4
        cmp.w   $8(a0),d2                       ; 013D6
        bne.b   l_008_0143A                     ; 013DA
        move.b  $a(a0),d4                       ; 013DC
        cmp.b   d4,d1                           ; 013E0
        beq.b   l_008_0142A                     ; 013E2
        move.b  d4,d1                           ; 013E4
        blt.b   l_008_0144A                     ; 013E6
        ext.w   d4                              ; 013E8
        swap    d1                              ; 013EA
        asl.w   #$5,d4                          ; 013EC
        move.w  d4,d1                           ; 013EE
        add.w   d4,d4                           ; 013F0
        add.w   d1,d4                           ; 013F2
        swap    d1                              ; 013F4
        lea.l   (a1,d4.w),a2                    ; 013F6
        move.l  a2,(dat_071_003FE).l            ; 013FA
        addi.l  #$5d,(dat_071_003FE).l          ; 01400
l_008_0140A:
        cmpa.l  (dat_071_003FE).l,a2            ; 0140A
        bge.b   l_008_01448                     ; 01410
        move.b  (a2),d4                         ; 01412
        blt.b   l_008_0142A                     ; 01414
        btst    #$4,d4                          ; 01416
        bne.b   l_008_01426                     ; 0141A
        btst    #$6,d4                          ; 0141C
        bne.b   l_008_01426                     ; 01420
        addq.w  #$4,a2                          ; 01422
        bra.b   l_008_0140A                     ; 01424
l_008_01426:
        addq.w  #$2,a2                          ; 01426
        bra.b   l_008_0140A                     ; 01428
l_008_0142A:
        bclr    #$4,$1(a0)                      ; 0142A
        move.b  #$40,(a2)+                      ; 01430
        move.b  d6,(a2)+                        ; 01434
        move.b  #$ff,(a2)                       ; 01436
l_008_0143A:
        adda.w  #$20,a0                         ; 0143A
        addq.b  #$1,d6                          ; 0143E
        cmpi.b  #$10,d6                         ; 01440
        blt.w   l_008_013C0                     ; 01444
l_008_01448:
        rts                                     ; 01448
l_008_0144A:
        move.w  #$36,(dat_071_0036E).l          ; 0144A
        jsr     (Nop).l                         ; 01452
        bra.b   l_008_0144A                     ; 01458
sub_008_0145A:
        move.w  d0,(a1)                         ; 0145A
        adda.w  d1,a1                           ; 0145C
        move.w  d0,(a1)                         ; 0145E
        adda.w  d1,a1                           ; 01460
        move.w  d0,(a1)                         ; 01462
        adda.w  d1,a1                           ; 01464
        move.w  d0,(a1)                         ; 01466
        adda.w  d1,a1                           ; 01468
        move.w  d0,(a1)                         ; 0146A
        adda.w  d1,a1                           ; 0146C
        move.w  d0,(a1)                         ; 0146E
        adda.w  d1,a1                           ; 01470
        move.w  d0,(a1)                         ; 01472
        adda.w  d1,a1                           ; 01474
        move.w  d0,(a1)                         ; 01476
        adda.w  d1,a1                           ; 01478
        move.w  d0,(a1)                         ; 0147A
        adda.w  d1,a1                           ; 0147C
        move.w  d0,(a1)                         ; 0147E
        adda.w  d1,a1                           ; 01480
        move.w  d0,(a1)                         ; 01482
        adda.w  d1,a1                           ; 01484
        move.w  d0,(a1)                         ; 01486
        adda.w  d1,a1                           ; 01488
        move.w  d0,(a1)                         ; 0148A
        adda.w  d1,a1                           ; 0148C
        move.w  d0,(a1)                         ; 0148E
        adda.w  d1,a1                           ; 01490
        move.w  d0,(a1)                         ; 01492
        adda.w  d1,a1                           ; 01494
        move.w  d0,(a1)                         ; 01496
        adda.w  d1,a1                           ; 01498
        rts                                     ; 0149A
dat_008_0149C:
	dc.b	$01,$01,$00,$01,$FF,$01,$01,$00,$00,$00,$FF,$00,$01,$FF,$00,$FF
	dc.b	$FF,$FF,$01,$02,$00,$02,$FF,$02,$02,$01,$FE,$01,$02,$00,$FE,$00
	dc.b	$02,$FF,$FE,$FF,$01,$FE,$00,$FE,$FF,$FE
dat_008_014C6:
	dc.b	$40,$00,$40,$00,$00,$00,$40,$00,$C0,$00,$40,$00,$40,$00,$00,$00
	dc.b	$00,$00,$00,$00,$C0,$00,$00,$00,$40,$00,$C0,$00,$00,$00,$C0,$00
	dc.b	$C0,$00,$C0,$00,$40,$00,$80,$00,$00,$00,$80,$00,$C0,$00,$80,$00
	dc.b	$80,$00,$40,$00,$80,$00,$40,$00,$80,$00,$00,$00,$80,$00,$00,$00
	dc.b	$80,$00,$C0,$00,$80,$00,$C0,$00,$40,$00,$80,$00,$00,$00,$80,$00
	dc.b	$C0,$00,$80,$00
dat_008_0151A:
	dc.b	$30,$00,$30,$00,$20,$00,$30,$00,$10,$00,$30,$00,$00,$00,$30,$00
	dc.b	$30,$00,$20,$00,$20,$00,$20,$00,$10,$00,$20,$00,$00,$00,$20,$00
	dc.b	$30,$00,$10,$00,$20,$00,$10,$00,$10,$00,$10,$00,$00,$00,$10,$00
	dc.b	$30,$00,$00,$00,$20,$00,$00,$00,$10,$00,$00,$00,$00,$00,$00,$00
dat_008_0155A:
	dc.b	$10,$00,$10,$00,$00,$00,$10,$00,$F0,$00,$10,$00,$10,$00,$00,$00
	dc.b	$00,$00,$00,$00,$F0,$00,$00,$00,$10,$00,$F0,$00,$00,$00,$F0,$00
	dc.b	$F0,$00,$F0,$00,$10,$00,$20,$00,$00,$00,$20,$00,$F0,$00,$20,$00
	dc.b	$20,$00,$10,$00,$E0,$00,$10,$00,$20,$00,$00,$00,$E0,$00,$00,$00
	dc.b	$20,$00,$F0,$00,$E0,$00,$F0,$00,$10,$00,$E0,$00,$00,$00,$E0,$00
	dc.b	$F0,$00,$E0,$00
dat_008_015AE:
	dc.b	$0C,$00,$0C,$00,$08,$00,$0C,$00,$04,$00,$0C,$00,$00,$00,$0C,$00
	dc.b	$0C,$00,$08,$00,$08,$00,$08,$00,$04,$00,$08,$00,$00,$00,$08,$00
	dc.b	$0C,$00,$04,$00,$08,$00,$04,$00,$04,$00,$04,$00,$00,$00,$04,$00
	dc.b	$0C,$00,$00,$00,$08,$00,$00,$00,$04,$00,$00,$00,$00,$00,$00,$00
dat_008_015EE:
	dc.b	$E0,$E0,$A0,$E0,$60,$E0,$20,$E0,$E0,$A0,$A0,$A0,$60,$A0,$20,$A0
	dc.b	$E0,$60,$A0,$60,$60,$60,$20,$60,$E0,$20,$A0,$20,$60,$20,$20,$20
dat_008_0160E:
	dc.b	$03,$03,$02,$03,$01,$03,$00,$03,$03,$02,$02,$02,$01,$02,$00,$02
	dc.b	$03,$01,$02,$01,$01,$01,$00,$01,$03,$00,$02,$00,$01,$00,$00,$00
	dc.b	$94,$45,$6A,$02,$44,$42,$96,$46,$6A,$02,$44,$43,$98
	dc.b	'GjnDD`j'
l_008_01642:
        move.w  #$7fff,d1                       ; 01642
        move.w  d1,(dat_071_00510).l            ; 01646
        movem.l (a7)+,d5/d7                     ; 0164C
        rts                                     ; 01650
sub_008_01652:
        movem.l d5/d7,-(a7)                     ; 01652
        move.w  (dat_071_00442).l,d1            ; 01656
        move.l  (dat_071_00448).l,d6            ; 0165C
        move.w  (dat_071_00446).l,d7            ; 01662
        move.w  (dat_071_00488).l,d5            ; 01668
        asr.w   d5,d1                           ; 0166E
        asr.l   d5,d6                           ; 01670
        asr.w   d5,d7                           ; 01672
        add.w   d1,d2                           ; 01674
        bpl.b   l_008_0167A                     ; 01676
        neg.w   d2                              ; 01678
l_008_0167A:
        tst.b   (dat_071_0028B).l               ; 0167A
        beq.b   l_008_0168C                     ; 01680
        move.l  (dat_071_0050C).l,d3            ; 01682
        asr.l   #$8,d3                          ; 01688
        bra.b   l_008_01690                     ; 0168A
l_008_0168C:
        ext.l   d3                              ; 0168C
        add.l   d6,d3                           ; 0168E
l_008_01690:
        bpl.b   l_008_01694                     ; 01690
        neg.l   d3                              ; 01692
l_008_01694:
        cmpi.l  #$7fff0,d3                      ; 01694
        bge.b   l_008_01642                     ; 0169A
        add.w   d7,d4                           ; 0169C
        bpl.b   l_008_016A2                     ; 0169E
        neg.w   d4                              ; 016A0
l_008_016A2:
        asr.w   #$4,d2                          ; 016A2
        asr.l   #$4,d3                          ; 016A4
        asr.w   #$4,d4                          ; 016A6
        movem.l (a7)+,d5/d7                     ; 016A8
sub_008_016AC:
        movem.l d5/a0,-(a7)                     ; 016AC
        moveq   #$e,d5                          ; 016B0
        lea.l   (dat_008_01710).l,a0            ; 016B2
        cmp.w   d2,d3                           ; 016B8
        ble.b   l_008_016BE                     ; 016BA
        exg.l   d2,d3                           ; 016BC
l_008_016BE:
        ext.l   d3                              ; 016BE
        beq.b   l_008_016D0                     ; 016C0
        asl.l   #$8,d3                          ; 016C2
        tst.w   d2                              ; 016C4
        bne.b   l_008_016CC                     ; 016C6
        moveq   #$0,d3                          ; 016C8
        bra.b   l_008_016D0                     ; 016CA
l_008_016CC:
        divu.w  d2,d3                           ; 016CC
        add.w   d3,d3                           ; 016CE
l_008_016D0:
        move.w  (a0,d3.w),d3                    ; 016D0
        mulu.w  d3,d2                           ; 016D4
        ext.l   d4                              ; 016D6
        asl.l   d5,d4                           ; 016D8
        cmp.l   d2,d4                           ; 016DA
        ble.b   l_008_016E0                     ; 016DC
        exg.l   d2,d4                           ; 016DE
l_008_016E0:
        asr.l   d5,d2                           ; 016E0
        tst.w   d2                              ; 016E2
        bne.b   l_008_016EA                     ; 016E4
        moveq   #$0,d4                          ; 016E6
        bra.b   l_008_016F0                     ; 016E8
l_008_016EA:
        divu.w  d2,d4                           ; 016EA
        asr.w   #$6,d4                          ; 016EC
        add.w   d4,d4                           ; 016EE
l_008_016F0:
        move.w  (a0,d4.w),d1                    ; 016F0
        mulu.w  d2,d1                           ; 016F4
        asr.l   d5,d1                           ; 016F6
        movem.l (a7)+,d5/a0                     ; 016F8
        cmpi.l  #$7fff,d1                       ; 016FC
        ble.b   l_008_01708                     ; 01702
        move.w  #$7fff,d1                       ; 01704
l_008_01708:
        move.w  d1,(dat_071_00510).l            ; 01708
        rts                                     ; 0170E
dat_008_01710:
	dc.b	$40,$00,$40,$00,$40,$00,$40,$01,$40,$02,$40,$03,$40,$04,$40,$06
	dc.b	$40,$08,$40,$0A,$40,$0C,$40,$0F,$40,$12,$40,$15,$40,$18,$40,$1C
	dc.b	'@ @$@(@-@2@7@<@B@H@N@T@[@b@i@p@x@'
	dc.b	$80,$40,$88,$40,$90,$40,$98,$40,$A1,$40,$AA,$40,$B4,$40,$BD,$40
	dc.b	$C7,$40,$D1,$40,$DB,$40,$E6,$40,$F0,$40,$FB,$41,$06,$41,$12,$41
	dc.b	$1E
	dc.b	'A)A6ABAOA[AiAvA'
	dc.b	$83,$41,$91,$41,$9F,$41,$AD,$41,$BC,$41,$CB,$41,$DA,$41,$E9,$41
	dc.b	$F8,$42,$08,$42,$18
	dc.b	'B(B8BIBYBjB|B'
	dc.b	$8D,$42,$9F,$42,$B1,$42,$C3,$42,$D5,$42,$E8,$42,$FA,$43,$0D
	dc.b	'C!C4CHC[CpC'
	dc.b	$84,$43,$98,$43,$AD,$43,$C2,$43,$D7,$43,$EC,$44,$02,$44,$18
	dc.b	'D.DDDZDqD'
	dc.b	$87,$44,$9E,$44,$B6,$44,$CD,$44,$E5,$44,$FC,$45,$14
	dc.b	'E-EEE^EvE'
	dc.b	$8F,$45,$A8,$45,$C2,$45,$DB,$45,$F5,$46,$0F
	dc.b	'F)FDF^FyF'
	dc.b	$94,$46,$AF,$46,$CA,$46,$E5,$47,$01,$47,$1D
	dc.b	'G9GUGqG'
	dc.b	$8E,$47,$AB,$47,$C7,$47,$E5,$48,$02,$48,$1F
	dc.b	'H=H[HxH'
	dc.b	$97,$48,$B5,$48,$D3,$48,$F2,$49,$11
	dc.b	'I0IOInI'
	dc.b	$8E,$49,$AD,$49,$CD,$49,$ED,$4A,$0D
	dc.b	'J-JNJnJ'
	dc.b	$8F,$4A,$B0,$4A,$D1,$4A,$F2,$4B,$14
	dc.b	'K5KWKyK'
	dc.b	$9B,$4B,$BD,$4B,$DF,$4C,$02
	dc.b	'L$LGLjL'
	dc.b	$8D,$4C,$B0,$4C,$D3,$4C,$F7,$4D,$1B,$4D,$3E,$4D,$62,$4D,$86,$4D
	dc.b	$AA,$4D,$CF,$4D,$F3,$4E,$18,$4E,$3D,$4E,$62,$4E,$87,$4E,$AC,$4E
	dc.b	$D1,$4E,$F6,$4F,$1C,$4F,$42,$4F,$67,$4F,$8D,$4F,$B3,$4F,$DA,$50
	dc.b	$00
	dc.b	'P&PMPtP'
	dc.b	$9B,$50,$C2,$50,$E9,$51,$10,$51,$37,$51,$5F,$51,$86,$51,$AE,$51
	dc.b	$D6,$51,$FE
	dc.b	'R&RNRvR'
	dc.b	$9F,$52,$C7,$52,$F0,$53,$19,$53,$42,$53,$6B,$53,$94,$53,$BD,$53
	dc.b	$E6,$54,$10,$54,$39,$54,$63,$54,$8D,$54,$B6,$54,$E0,$55,$0B,$55
	dc.b	$35,$55,$5F,$55,$89,$55,$B4,$55,$DF,$56,$09,$56,$34,$56,$5F,$56
	dc.b	$8A,$56,$B5,$56,$E0,$57,$0C,$57,$37,$57,$63,$57,$8E,$57,$BA,$57
	dc.b	$E6,$58,$12,$58,$3E,$58,$6A,$58,$96,$58,$C2,$58,$EF,$59,$1B,$59
	dc.b	$48,$59,$75,$59,$A1,$59,$CE,$59,$FB,$5A,$28,$5A,$55,$5A,$82,$00
	dc.b	$00
h008_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    11,8                            ; 11 longs pointing into hunk 8
	dc.l	$16B4,$11E0,$1092,$F4E,$F46,$E9C,$E94,$C66
	dc.l	$B36,$968,$68
        dc.l    271,71                          ; 271 longs pointing into hunk 71
	dc.l	$890,$8A8,$9A0,$6,$26,$3A,$54,$116
	dc.l	$11C,$122,$34C,$464,$46A,$5F2,$5F8,$38E
	dc.l	$E5A,$EEC,$FDE,$A12,$BC8,$8E2,$AF8,$BA0
	dc.l	$166A,$8D6,$A00,$B94,$726,$63A,$736,$760
	dc.l	$528,$5AE,$654,$660,$668,$672,$686,$696
	dc.l	$6A0,$6A8,$6B2,$6CA,$E4A,$EE4,$FC4,$646
	dc.l	$67A,$84E,$862,$8AE,$9C2,$EC8,$EFC,$640
	dc.l	$68E,$872,$9F8,$E50,$1098,$125E,$1312,$288
	dc.l	$3F6,$5EA,$CBE,$D1C,$A40,$CB0,$9BA,$A36
	dc.l	$B42,$BD2,$A9A,$1664,$370,$4D2,$4F8,$87E
	dc.l	$AB0,$165E,$36A,$A88,$1658,$314,$354,$3AE
	dc.l	$3BC,$3C8,$13A,$134,$39A,$59E,$8FC,$B04
	dc.l	$BBA,$E2E,$ED4,$12E,$33E,$35C,$11A6,$11B0
	dc.l	$11BA,$1368,$1372,$1378,$13FC,$1406,$140C,$806
	dc.l	$DDE,$12B6,$13BA,$10,$C8,$292,$3FE,$45A
	dc.l	$614,$768,$770,$778,$780,$78A,$792,$79A
	dc.l	$7A2,$7AA,$7B4,$7BC,$A30,$D5A,$DF0,$1270
	dc.l	$1326,$9B0,$B60,$CDA,$9AA,$B5A,$CD4,$CCA
	dc.l	$99A,$CA4,$1648,$170A,$878,$B14,$BD8,$E3E
	dc.l	$167C,$B0C,$E36,$1684,$91A,$B22,$C08,$C20
	dc.l	$90C,$962,$B30,$BEE,$C16,$C60,$B72,$E7C
	dc.l	$868,$F3E,$854,$F1C,$858,$86C,$8C4,$9D8
	dc.l	$9EA,$A18,$A24,$B68,$B76,$B82,$CE8,$CFA
	dc.l	$D06,$D54,$3D4,$3EA,$990,$A06,$C9A,$974
	dc.l	$A0C,$C7E,$576,$586,$590,$982,$C8C,$37A
	dc.l	$FE8,$380,$388,$420,$4BC,$4DC,$EB4,$1028
	dc.l	$446,$4E2,$502,$F66,$FFA,$418,$434,$518
	dc.l	$522,$A6A,$EAC,$410,$426,$508,$512,$A4E
	dc.l	$EA4,$632,$F5E,$62C,$F56,$71E,$16,$CE
	dc.l	$298,$404,$61A,$CB6,$D62,$5BA,$6BE,$6D8
	dc.l	$6EA,$704,$714,$1122,$1268,$131C,$D10,$D16
	dc.l	$D3E,$D4E,$D28,$742,$74A,$754,$6F0,$940
	dc.l	$C3E,$D30,$3DE,$4C6,$4EC,$27A,$5DE,$ADC
	dc.l	$1048,$1102,$1112,$1202,$124A,$1302,$144E
        dc.l    4,9                             ; 4 longs pointing into hunk 9
	dc.l	$AEC,$6E2,$6D0,$1128
        dc.l    10,73                           ; 10 longs pointing into hunk 73
	dc.l	$A1E,$B7C,$CE2,$E74,$8BE,$9D2,$F36,$8B6
	dc.l	$9CA,$F14
        dc.l    9,66                            ; 9 longs pointing into hunk 66
	dc.l	$21E,$232,$E84,$1D2,$1E8,$F26,$186,$19C
	dc.l	$F04
        dc.l    2,72                            ; 2 longs pointing into hunk 72
	dc.l	$FAC,$106A
        dc.l    1,17                            ; 1 longs pointing into hunk 17
	dc.l	$3F0
        dc.l    15,65                           ; 15 longs pointing into hunk 65
	dc.l	$89A,$FA0,$F82,$F92,$1020,$FD2,$1004,$1036
	dc.l	$F6E,$1012,$EDC,$E6C,$EC0,$E62,$EF4
        dc.l    1,16                            ; 1 longs pointing into hunk 16
	dc.l	$B3C
        dc.l    9,2                             ; 9 longs pointing into hunk 2
	dc.l	$164,$224,$E8C,$15E,$1D8,$F2E,$158,$18C
	dc.l	$F0C
        dc.l    1,20                            ; 1 longs pointing into hunk 20
	dc.l	$DCC
        dc.l    1,26                            ; 1 longs pointing into hunk 26
	dc.l	$452
        dc.l    1,36                            ; 1 longs pointing into hunk 36
	dc.l	$75A
        dc.l    2,12                            ; 2 longs pointing into hunk 12
	dc.l	$70C,$6FC
        dc.l    3,10                            ; 3 longs pointing into hunk 10
	dc.l	$920,$8F0,$BAE
        dc.l    10,7                            ; 10 longs pointing into hunk 7
	dc.l	$280,$5E4,$AE2,$104E,$1108,$1118,$1208,$1250
	dc.l	$1308,$1454
	dc.l	0
	dc.l	HUNK_END
	endc
