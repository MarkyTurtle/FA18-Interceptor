; F/A-18 Interceptor - hunk 24 (code)
; Game logic not yet identified (objects and the flight log; used by hunks 22, 23).
; Included by ../f18_main.s.

;===============================================================================
; Hunk 24: CODE, $B10 bytes
;===============================================================================
	CODE_HUNK	h024
l_024_00000:
        moveq   #$0,d0                          ; 00000
        unlk    a6                              ; 00002
        rts                                     ; 00004
sub_024_00006:
        clr.b   (dat_071_0026F).l               ; 00006
        moveq   #$0,d0                          ; 0000C
        link.w  a6,#$ffa4                       ; 0000E
        lea.l   (ObjectTable).l,a0              ; 00012
        move.w  (CurrentObjectOffset).l,d0      ; 00018
        move.b  $5e(a0,d0.w),-$1a(a6)           ; 0001E
        andi.b  #$3f,$4(a0,d0.w)                ; 00024
        move.w  (a0,d0.w),-$14(a6)              ; 0002A
        move.w  $2(a0,d0.w),-$16(a6)            ; 00030
        move.b  $62(a0,d0.w),d6                 ; 00036
        andi.b  #$f0,d6                         ; 0003A
        cmpi.b  #$20,d6                         ; 0003E
        beq.b   l_024_00000                     ; 00042
        move.b  d6,-$22(a6)                     ; 00044
l_024_00048:
        addi.w  #$200,d0                        ; 00048
        cmpi.w  #$1e00,d0                       ; 0004C
        bgt.w   l_024_0064C                     ; 00050
        move.w  (a0,d0.w),d1                    ; 00054
        move.w  d1,d5                           ; 00058
        andi.w  #$40,d1                         ; 0005A
        beq.b   l_024_00048                     ; 0005E
        andi.w  #$600,d5                        ; 00060
        bne.b   l_024_00048                     ; 00064
        move.b  $5e(a0,d0.w),d5                 ; 00066
        cmp.b   -$1a(a6),d5                     ; 0006A
        beq.b   l_024_00048                     ; 0006E
        btst    #$3,-$13(a6)                    ; 00070
        bne.b   l_024_00080                     ; 00076
        btst    #$3,$1(a0,d0.w)                 ; 00078
        beq.b   l_024_00048                     ; 0007E
l_024_00080:
        move.b  $62(a0,d0.w),d7                 ; 00080
        cmpi.b  #$15,d7                         ; 00084
        beq.b   l_024_000DC                     ; 00088
        andi.b  #$f0,d7                         ; 0008A
        cmpi.b  #$30,d7                         ; 0008E
        beq.b   l_024_00048                     ; 00092
        cmpi.b  #$20,d7                         ; 00094
        bne.b   l_024_000A2                     ; 00098
        movea.l #$a0000,a1                      ; 0009A
        bra.b   l_024_000F6                     ; 000A0
l_024_000A2:
        move.b  -$22(a6),d1                     ; 000A2
        cmpi.b  #$0,d1                          ; 000A6
        beq.b   l_024_000B0                     ; 000AA
        cmp.b   d7,d1                           ; 000AC
        beq.b   l_024_000BE                     ; 000AE
l_024_000B0:
        movea.l #$10000,a1                      ; 000B0
        movea.l #$5000,a2                       ; 000B6
        bra.b   l_024_000F6                     ; 000BC
l_024_000BE:
        btst    #$0,-$16(a6)                    ; 000BE
        bne.b   l_024_000EA                     ; 000C4
        btst    #$0,$2(a0,d0.w)                 ; 000C6
        bne.b   l_024_000EA                     ; 000CC
        movea.l #$7000,a1                       ; 000CE
        movea.l #$1000,a2                       ; 000D4
        bra.b   l_024_000F6                     ; 000DA
l_024_000DC:
        movea.l #$5000,a1                       ; 000DC
        movea.l #$1000,a2                       ; 000E2
        bra.b   l_024_000F6                     ; 000E8
l_024_000EA:
        movea.l #$6000,a1                       ; 000EA
        movea.l #$800,a2                        ; 000F0
l_024_000F6:
        movem.l $14(a0,d0.w),d5-d7              ; 000F6
        sub.l   d2,d5                           ; 000FC
        bge.b   l_024_00102                     ; 000FE
        neg.l   d5                              ; 00100
l_024_00102:
        cmp.l   a1,d5                           ; 00102
        bgt.w   l_024_00048                     ; 00104
        sub.l   d3,d6                           ; 00108
        bge.b   l_024_0010E                     ; 0010A
        neg.l   d6                              ; 0010C
l_024_0010E:
        cmp.l   a1,d6                           ; 0010E
        bgt.w   l_024_00048                     ; 00110
        sub.l   d4,d7                           ; 00114
        bge.b   l_024_0011A                     ; 00116
        neg.l   d7                              ; 00118
l_024_0011A:
        cmp.l   a1,d7                           ; 0011A
        bgt.w   l_024_00048                     ; 0011C
        move.b  #$1,(dat_071_0026F).l           ; 00120
        ori.w   #$1,$2(a0,d0.w)                 ; 00128
        move.b  $62(a0,d0.w),d7                 ; 0012E
        andi.b  #$f0,d7                         ; 00132
        cmpi.b  #$20,d7                         ; 00136
        beq.w   l_024_001F6                     ; 0013A
        movem.l $14(a0,d0.w),d5-d7              ; 0013E
        move.w  a2,-$40(a6)                     ; 00144
        sub.l   d2,d5                           ; 00148
        bge.b   l_024_0014E                     ; 0014A
        neg.l   d5                              ; 0014C
l_024_0014E:
        cmp.l   a2,d5                           ; 0014E
        bgt.b   l_024_00166                     ; 00150
        sub.l   d3,d6                           ; 00152
        bge.b   l_024_00158                     ; 00154
        neg.l   d6                              ; 00156
l_024_00158:
        cmp.l   a2,d6                           ; 00158
        bgt.b   l_024_00166                     ; 0015A
        sub.l   d4,d7                           ; 0015C
        bge.b   l_024_00162                     ; 0015E
        neg.l   d7                              ; 00160
l_024_00162:
        cmp.l   a2,d7                           ; 00162
        ble.b   l_024_001AE                     ; 00164
l_024_00166:
        movem.l $14(a0,d0.w),d5-d7              ; 00166
        move.l  $3e(a0,d0.w),d1                 ; 0016C
        asr.l   #$1,d1                          ; 00170
        sub.l   d1,d5                           ; 00172
        move.l  $42(a0,d0.w),d1                 ; 00174
        asr.l   #$1,d1                          ; 00178
        sub.l   d1,d6                           ; 0017A
        move.l  $46(a0,d0.w),d1                 ; 0017C
        asr.l   #$1,d1                          ; 00180
        sub.l   d1,d7                           ; 00182
        move.w  -$40(a6),d1                     ; 00184
        ext.l   d1                              ; 00188
        sub.l   d2,d5                           ; 0018A
        bge.b   l_024_00190                     ; 0018C
        neg.l   d5                              ; 0018E
l_024_00190:
        cmp.l   d1,d5                           ; 00190
        bgt.w   l_024_00048                     ; 00192
        sub.l   d3,d6                           ; 00196
        bge.b   l_024_0019C                     ; 00198
        neg.l   d6                              ; 0019A
l_024_0019C:
        cmp.l   d1,d6                           ; 0019C
        bgt.w   l_024_00048                     ; 0019E
        sub.l   d4,d7                           ; 001A2
        bge.b   l_024_001A8                     ; 001A4
        neg.l   d7                              ; 001A6
l_024_001A8:
        cmp.l   d1,d7                           ; 001A8
        bgt.w   l_024_00048                     ; 001AA
l_024_001AE:
        adda.w  d0,a0                           ; 001AE
        move.w  $0(a0),d1                       ; 001B0
        andi.w  #$1000,d1                       ; 001B4
        beq.w   l_024_00A1E                     ; 001B8
        ori.w   #$200,$0(a0)                    ; 001BC
        move.b  $62(a0),d1                      ; 001C2
        andi.b  #$f0,d1                         ; 001C6
        cmpi.b  #$0,d1                          ; 001CA
        beq.w   l_024_00A1E                     ; 001CE
        bset    #$1,$20(a0)                     ; 001D2
        cmpi.b  #$15,d1                         ; 001D8
        beq.w   l_024_00A1E                     ; 001DC
        move.w  d0,(dat_073_0165A).l            ; 001E0
        bset    #$4,$2(a0)                      ; 001E6
        move.b  #$1,$5(a0)                      ; 001EC
        bra.w   l_024_00A1E                     ; 001F2
l_024_001F6:
        move.w  d0,-(a7)                        ; 001F6
        clr.w   -$44(a6)                        ; 001F8
        bra.b   l_024_00224                     ; 001FC
l_024_001FE:
        move.w  (a7),d0                         ; 001FE
        move.w  (ViewObject).l,d7               ; 00200
        cmp.w   (CurrentObjectOffset).l,d7      ; 00206
        bne.w   l_024_002D4                     ; 0020C
        tst.w   -$44(a6)                        ; 00210
        bgt.w   l_024_002D4                     ; 00214
        addq.w  #$1,-$44(a6)                    ; 00218
        movem.l -$2e(a6),d2-d4                  ; 0021C
        bra.b   l_024_0022A                     ; 00222
l_024_00224:
        movem.l d2-d4,-$2e(a6)                  ; 00224
l_024_0022A:
        andi.l  #$3fffff,d2                     ; 0022A
        andi.l  #$3fffff,d4                     ; 00230
        asr.l   #$8,d2                          ; 00236
        asr.l   #$8,d3                          ; 00238
        asr.l   #$8,d4                          ; 0023A
        move.w  (ViewObject).l,d7               ; 0023C
        cmp.w   (CurrentObjectOffset).l,d7      ; 00242
        bne.b   l_024_00282                     ; 00248
        lea.l   (ObjectTable).l,a3              ; 0024A
        adda.w  d7,a3                           ; 00250
        move.b  $7d(a3),d5                      ; 00252
        andi.w  #$f,d5                          ; 00256
        tst.w   -$44(a6)                        ; 0025A
        bgt.b   l_024_00266                     ; 0025E
        adda.w  #$a4,a3                         ; 00260
        bra.b   l_024_0026A                     ; 00264
l_024_00266:
        adda.w  #$b6,a3                         ; 00266
l_024_0026A:
        move.w  (a3),d7                         ; 0026A
        asr.w   d5,d7                           ; 0026C
        add.w   d7,d2                           ; 0026E
        move.w  $2(a3),d7                       ; 00270
        asr.w   d5,d7                           ; 00274
        ext.l   d7                              ; 00276
        add.l   d7,d3                           ; 00278
        move.w  $4(a3),d7                       ; 0027A
        asr.w   d5,d7                           ; 0027E
        add.w   d7,d4                           ; 00280
l_024_00282:
        movea.w d2,a2                           ; 00282
        movea.l d3,a1                           ; 00284
        move.w  d4,-$42(a6)                     ; 00286
        lea.l   (a0,d0.w),a3                    ; 0028A
        cmpi.b  #$20,$62(a3)                    ; 0028E
        bne.b   l_024_0029E                     ; 00294
        lea.l   (dat_052_00000).l,a4            ; 00296
        bra.b   l_024_002A4                     ; 0029C
l_024_0029E:
        lea.l   (dat_053_00000).l,a4            ; 0029E
l_024_002A4:
        movea.l (a4)+,a5                        ; 002A4
        move.w  (a5),d7                         ; 002A6
        addi.w  #$a4,d7                         ; 002A8
        move.b  $7d(a3),d2                      ; 002AC
        andi.w  #$f,d2                          ; 002B0
        move.w  d2,-$5a(a6)                     ; 002B4
        move.w  $2(a3,d7.w),d4                  ; 002B8
        asr.w   d2,d4                           ; 002BC
        cmp.w   d4,d3                           ; 002BE
        bge.w   l_024_002E0                     ; 002C0
l_024_002C4:
        tst.w   (a4)                            ; 002C4
        blt.b   l_024_002D4                     ; 002C6
        bsr.w   sub_024_0059E                   ; 002C8
        beq.b   l_024_002C4                     ; 002CC
        move.w  (a7)+,d0                        ; 002CE
        bra.w   l_024_00A18                     ; 002D0
l_024_002D4:
        movem.l -$2e(a6),d2-d4                  ; 002D4
        move.w  (a7)+,d0                        ; 002DA
        bra.w   l_024_00048                     ; 002DC
l_024_002E0:
        move.w  $2(a3,d7.w),d1                  ; 002E0
        move.w  -$5a(a6),d0                     ; 002E4
        asr.w   d0,d1                           ; 002E8
        move.w  d1,-$34(a6)                     ; 002EA
        lea.l   (a5),a4                         ; 002EE
l_024_002F0:
        clr.w   -$30(a6)                        ; 002F0
        move.w  (a4),-$32(a6)                   ; 002F4
        blt.w   l_024_00574                     ; 002F8
l_024_002FC:
        move.w  (a4)+,d0                        ; 002FC
        bge.b   l_024_0030E                     ; 002FE
        andi.w  #$fff,d0                        ; 00300
        move.w  -$32(a6),d1                     ; 00304
        addq.w  #$1,-$30(a6)                    ; 00308
        bra.b   l_024_00314                     ; 0030C
l_024_0030E:
        move.w  (a4),d1                         ; 0030E
        andi.w  #$fff,d1                        ; 00310
l_024_00314:
        addi.w  #$a4,d0                         ; 00314
        addi.w  #$a4,d1                         ; 00318
        lea.l   (a3,d0.w),a5                    ; 0031C
        movem.w (a3,d1.w),d5-d7                 ; 00320
        sub.w   (a5),d5                         ; 00326
        sub.w   $4(a5),d7                       ; 00328
        neg.w   d7                              ; 0032C
        exg.l   d5,d7                           ; 0032E
        move.w  (a5),d2                         ; 00330
        move.w  $4(a5),d4                       ; 00332
        move.w  -$5a(a6),d0                     ; 00336
        asr.w   d0,d2                           ; 0033A
        asr.w   d0,d4                           ; 0033C
        add.w   $c(a3),d2                       ; 0033E
        add.w   $e(a3),d4                       ; 00342
        sub.w   a2,d2                           ; 00346
        sub.w   -$42(a6),d4                     ; 00348
        neg.w   d2                              ; 0034C
        neg.w   d4                              ; 0034E
        muls.w  d2,d5                           ; 00350
        muls.w  d4,d7                           ; 00352
        add.l   d5,d7                           ; 00354
        bge.w   l_024_00564                     ; 00356
        tst.w   -$30(a6)                        ; 0035A
        beq.b   l_024_002FC                     ; 0035E
        cmpi.b  #$20,$62(a3)                    ; 00360
        beq.b   l_024_0037C                     ; 00366
        move.w  #$1ac,-$46(a6)                  ; 00368
        move.w  #$1b2,-$48(a6)                  ; 0036E
        move.w  #$1b8,-$4a(a6)                  ; 00374
        bra.b   l_024_0038E                     ; 0037A
l_024_0037C:
        move.w  #$1e8,-$46(a6)                  ; 0037C
        move.w  #$1ee,-$48(a6)                  ; 00382
        move.w  #$1f4,-$4a(a6)                  ; 00388
l_024_0038E:
        lea.l   (ObjectTable).l,a4              ; 0038E
        adda.w  (CurrentObjectOffset).l,a4      ; 00394
        tst.w   -$44(a6)                        ; 0039A
        beq.w   l_024_004E8                     ; 0039E
        move.w  $2(a4),d2                       ; 003A2
        andi.w  #$80,d2                         ; 003A6
        beq.w   l_024_004D0                     ; 003AA
        move.w  -$46(a6),d0                     ; 003AE
        move.w  -$4a(a6),d1                     ; 003B2
        move.w  (a3,d0.w),d6                    ; 003B6
        move.w  $4(a3,d0.w),d7                  ; 003BA
        sub.w   (a3,d1.w),d6                    ; 003BE
        sub.w   $4(a3,d1.w),d7                  ; 003C2
        neg.w   d7                              ; 003C6
        move.w  d6,d2                           ; 003C8
        move.w  d7,d3                           ; 003CA
        move.w  (a3,d1.w),d4                    ; 003CC
        move.w  $4(a3,d1.w),d5                  ; 003D0
        move.w  -$5a(a6),d1                     ; 003D4
        asr.w   d1,d4                           ; 003D8
        asr.w   d1,d5                           ; 003DA
        add.w   $c(a3),d4                       ; 003DC
        add.w   $e(a3),d5                       ; 003E0
        sub.w   a2,d4                           ; 003E4
        sub.w   -$42(a6),d5                     ; 003E6
        muls.w  d4,d7                           ; 003EA
        muls.w  d5,d6                           ; 003EC
        add.l   d7,d6                           ; 003EE
        blt.w   l_024_004D0                     ; 003F0
        move.w  -$48(a6),d1                     ; 003F4
        move.w  (a3,d1.w),d4                    ; 003F8
        move.w  $4(a3,d1.w),d5                  ; 003FC
        move.w  -$5a(a6),d1                     ; 00400
        asr.w   d1,d4                           ; 00404
        asr.w   d1,d5                           ; 00406
        add.w   $c(a3),d4                       ; 00408
        add.w   $e(a3),d5                       ; 0040C
        sub.w   a2,d4                           ; 00410
        sub.w   -$42(a6),d5                     ; 00412
        muls.w  d4,d3                           ; 00416
        muls.w  d5,d2                           ; 00418
        add.l   d3,d2                           ; 0041A
        bge.w   l_024_004D0                     ; 0041C
        move.w  -$48(a6),d0                     ; 00420
        move.w  -$4a(a6),d1                     ; 00424
        move.w  (a3,d0.w),d6                    ; 00428
        move.w  $4(a3,d0.w),d7                  ; 0042C
        sub.w   (a3,d1.w),d6                    ; 00430
        sub.w   $4(a3,d1.w),d7                  ; 00434
        neg.w   d7                              ; 00438
        move.w  d6,d2                           ; 0043A
        move.w  d7,d3                           ; 0043C
        move.w  (a3,d1.w),d4                    ; 0043E
        move.w  $4(a3,d1.w),d5                  ; 00442
        move.w  -$5a(a6),d1                     ; 00446
        asr.w   d1,d4                           ; 0044A
        asr.w   d1,d5                           ; 0044C
        add.w   $c(a3),d4                       ; 0044E
        add.w   $e(a3),d5                       ; 00452
        sub.w   a2,d4                           ; 00456
        sub.w   -$42(a6),d5                     ; 00458
        muls.w  d4,d7                           ; 0045C
        muls.w  d5,d6                           ; 0045E
        add.l   d7,d6                           ; 00460
        bge.b   l_024_004D0                     ; 00462
        move.w  -$46(a6),d0                     ; 00464
        move.w  -$4a(a6),d1                     ; 00468
        lea.l   (a3,d1.w),a5                    ; 0046C
        move.w  (a3,d0.w),d6                    ; 00470
        move.w  $4(a3,d0.w),d7                  ; 00474
        move.w  d6,d4                           ; 00478
        move.w  d7,d5                           ; 0047A
        sub.w   (a3,d1.w),d6                    ; 0047C
        sub.w   $4(a3,d1.w),d7                  ; 00480
        asr.w   #$1,d6                          ; 00484
        asr.w   #$1,d7                          ; 00486
        add.w   d6,d4                           ; 00488
        add.w   d7,d5                           ; 0048A
        move.w  -$5a(a6),d1                     ; 0048C
        asr.w   d1,d4                           ; 00490
        asr.w   d1,d5                           ; 00492
        add.w   $c(a3),d4                       ; 00494
        add.w   $e(a3),d5                       ; 00498
        sub.w   a2,d4                           ; 0049C
        sub.w   -$42(a6),d5                     ; 0049E
        muls.w  d4,d3                           ; 004A2
        muls.w  d5,d2                           ; 004A4
        add.l   d3,d2                           ; 004A6
        blt.b   l_024_004D0                     ; 004A8
        move.w  #$92,d0                         ; 004AA
        move.w  $4(a4,d0.w),d1                  ; 004AE
        move.w  $10(a4,d0.w),d2                 ; 004B2
        muls.w  $4(a3,d0.w),d1                  ; 004B6
        muls.w  $10(a3,d0.w),d2                 ; 004BA
        add.l   d1,d2                           ; 004BE
        cmpi.l  #$e000000,d2                    ; 004C0
        blt.b   l_024_004D0                     ; 004C6
        ori.w   #$4000,$2(a4)                   ; 004C8
        bra.b   l_024_004E8                     ; 004CE
l_024_004D0:
        move.w  $2(a4),d3                       ; 004D0
        move.w  d3,d7                           ; 004D4
        andi.w  #$4000,d3                       ; 004D6
        beq.b   l_024_004E2                     ; 004DA
        andi.w  #$8000,d7                       ; 004DC
        bne.b   l_024_004E8                     ; 004E0
l_024_004E2:
        andi.w  #$bfff,$2(a4)                   ; 004E2
l_024_004E8:
        tst.w   -$44(a6)                        ; 004E8
        bne.b   l_024_004F6                     ; 004EC
        ori.b   #$40,$4(a4)                     ; 004EE
        bra.b   l_024_004FC                     ; 004F4
l_024_004F6:
        ori.b   #$80,$4(a4)                     ; 004F6
l_024_004FC:
        move.w  -$34(a6),$4e(a4)                ; 004FC
        move.l  $10(a4),d3                      ; 00502
        cmpi.b  #$20,$62(a3)                    ; 00506
        bne.b   l_024_00516                     ; 0050C
        lea.l   (dat_052_0007C).l,a4            ; 0050E
        bra.b   l_024_0051C                     ; 00514
l_024_00516:
        lea.l   (dat_053_00020).l,a4            ; 00516
l_024_0051C:
        movea.l (a4)+,a5                        ; 0051C
        move.w  $2(a5),d7                       ; 0051E
        addi.w  #$a4,d7                         ; 00522
        move.w  $2(a3,d7.w),d4                  ; 00526
        move.w  -$5a(a6),d7                     ; 0052A
        asr.w   d7,d4                           ; 0052E
        ext.l   d4                              ; 00530
        cmp.l   d4,d3                           ; 00532
        blt.b   l_024_00558                     ; 00534
        adda.w  #$12,a4                         ; 00536
        movea.l (a4)+,a5                        ; 0053A
        move.w  $2(a5),d7                       ; 0053C
        addi.w  #$a4,d7                         ; 00540
        move.w  $2(a3,d7.w),d4                  ; 00544
        move.w  -$5a(a6),d7                     ; 00548
        asr.w   d7,d4                           ; 0054C
        addi.w  #$7,d4                          ; 0054E
        ext.l   d4                              ; 00552
        cmp.l   d4,d3                           ; 00554
        bge.b   l_024_00594                     ; 00556
l_024_00558:
        bsr.w   sub_024_0059E                   ; 00558
        beq.b   l_024_00594                     ; 0055C
        move.w  (a7)+,d0                        ; 0055E
        bra.w   l_024_00A18                     ; 00560
l_024_00564:
        tst.w   -$30(a6)                        ; 00564
        bne.w   l_024_002F0                     ; 00568
l_024_0056C:
        move.w  (a4)+,d0                        ; 0056C
        bge.b   l_024_0056C                     ; 0056E
        bra.w   l_024_002F0                     ; 00570
l_024_00574:
        tst.w   -$44(a6)                        ; 00574
        bne.b   l_024_00594                     ; 00578
        lea.l   (ObjectTable).l,a4              ; 0057A
        move.w  (CurrentObjectOffset).l,d0      ; 00580
        move.b  $4(a4,d0.w),d2                  ; 00586
        andi.b  #$40,d2                         ; 0058A
        beq.b   l_024_00594                     ; 0058E
        clr.l   $42(a4,d0.w)                    ; 00590
l_024_00594:
        bra.w   l_024_001FE                     ; 00594
l_024_00598:
        subq.w  #$2,a4                          ; 00598
        moveq   #$1,d7                          ; 0059A
        rts                                     ; 0059C
sub_024_0059E:
        move.l  (a4)+,d2                        ; 0059E
        blt.b   l_024_00598                     ; 005A0
        movea.l d2,a5                           ; 005A2
        movem.w $2(a5),d2-d4                    ; 005A4
        andi.w  #$fff,d4                        ; 005AA
        addi.w  #$a4,d2                         ; 005AE
        addi.w  #$a4,d3                         ; 005B2
        addi.w  #$a4,d4                         ; 005B6
        lea.l   (a3,d2.w),a5                    ; 005BA
        move.w  d4,d0                           ; 005BE
        movem.w (a3,d3.w),d2-d4                 ; 005C0
        sub.w   (a5),d2                         ; 005C6
        sub.w   $2(a5),d3                       ; 005C8
        sub.w   $4(a5),d4                       ; 005CC
        movem.w (a3,d0.w),d5-d7                 ; 005D0
        sub.w   (a5),d5                         ; 005D6
        sub.w   $2(a5),d6                       ; 005D8
        sub.w   $4(a5),d7                       ; 005DC
        move.w  d4,d0                           ; 005E0
        move.w  d7,d1                           ; 005E2
        muls.w  d3,d7                           ; 005E4
        muls.w  d6,d4                           ; 005E6
        sub.l   d4,d7                           ; 005E8
        moveq   #$7,d4                          ; 005EA
        add.w   -$5a(a6),d4                     ; 005EC
        asr.l   d4,d7                           ; 005F0
        muls.w  d5,d0                           ; 005F2
        muls.w  d2,d1                           ; 005F4
        sub.l   d1,d0                           ; 005F6
        asr.l   d4,d0                           ; 005F8
        muls.w  d2,d6                           ; 005FA
        muls.w  d3,d5                           ; 005FC
        sub.l   d5,d6                           ; 005FE
        asr.l   d4,d6                           ; 00600
        move.w  d7,d5                           ; 00602
        move.w  d6,d7                           ; 00604
        move.w  d0,d6                           ; 00606
        movem.w (a5),d2-d4                      ; 00608
        swap    d7                              ; 0060C
        move.w  -$5a(a6),d7                     ; 0060E
        asr.w   d7,d2                           ; 00612
        asr.l   d7,d3                           ; 00614
        asr.w   d7,d4                           ; 00616
        swap    d7                              ; 00618
        add.w   $c(a3),d2                       ; 0061A
        add.l   $10(a3),d3                      ; 0061E
        add.w   $e(a3),d4                       ; 00622
        sub.w   a2,d2                           ; 00626
        sub.l   a1,d3                           ; 00628
        sub.w   -$42(a6),d4                     ; 0062A
        neg.w   d2                              ; 0062E
        neg.w   d3                              ; 00630
        neg.w   d4                              ; 00632
        muls.w  d2,d5                           ; 00634
        muls.w  d3,d6                           ; 00636
        muls.w  d4,d7                           ; 00638
        add.l   d5,d7                           ; 0063A
        add.l   d6,d7                           ; 0063C
        blt.w   sub_024_0059E                   ; 0063E
l_024_00642:
        tst.l   (a4)+                           ; 00642
        bge.b   l_024_00642                     ; 00644
        subq.w  #$2,a4                          ; 00646
        moveq   #$0,d7                          ; 00648
        rts                                     ; 0064A
l_024_0064C:
        lea.l   (ObjectTable).l,a3              ; 0064C
        adda.w  (CurrentObjectOffset).l,a3      ; 00652
        cmpi.l  #$7fff,$10(a3)                  ; 00658
        bgt.w   l_024_00B04                     ; 00660
        move.b  (dat_071_0022E).l,d0            ; 00664
        ext.w   d0                              ; 0066A
        move.w  d0,-$6(a6)                      ; 0066C
        clr.l   -$a(a6)                         ; 00670
        moveq   #-1,d5                          ; 00674
        movea.l (dat_071_00396).l,a5            ; 00676
l_024_0067C:
        move.w  (a5),-$2(a6)                    ; 0067C
        suba.w  #$18,a5                         ; 00680
        addq.w  #$1,-$8(a6)                     ; 00684
        btst    #$4,-$1(a6)                     ; 00688
        bne.w   l_024_00744                     ; 0068E
        btst    #$6,-$1(a6)                     ; 00692
        bne.w   l_024_00744                     ; 00698
        cmpi.w  #$a,d5                          ; 0069C
        bge.w   l_024_00744                     ; 006A0
        addq.w  #$1,d5                          ; 006A4
        lea.l   (dat_072_05400).l,a0            ; 006A6
        lea.l   (dat_072_0542C).l,a1            ; 006AC
        move.w  d5,d0                           ; 006B2
        asl.w   #$2,d0                          ; 006B4
        move.l  (a0,d0.w),d1                    ; 006B6
        blt.w   l_024_00744                     ; 006BA
        movea.l d1,a0                           ; 006BE
        asl.w   #$6,d0                          ; 006C0
        adda.w  d0,a1                           ; 006C2
        addq.w  #$2,a1                          ; 006C4
        moveq   #$0,d0                          ; 006C6
        move.b  $7(a3),d0                       ; 006C8
        sub.b   (a1)+,d0                        ; 006CC
        move.b  d0,d2                           ; 006CE
        bge.b   l_024_006D4                     ; 006D0
        neg.b   d2                              ; 006D2
l_024_006D4:
        cmpi.b  #$1,d2                          ; 006D4
        bgt.b   l_024_00744                     ; 006D8
        move.b  $9(a3),d1                       ; 006DA
        sub.b   (a1)+,d1                        ; 006DE
        move.b  d1,d2                           ; 006E0
        bge.b   l_024_006E6                     ; 006E2
        neg.b   d2                              ; 006E4
l_024_006E6:
        cmpi.b  #$1,d2                          ; 006E6
        bgt.b   l_024_00744                     ; 006EA
        ext.w   d0                              ; 006EC
        swap    d0                              ; 006EE
        asr.l   #$2,d0                          ; 006F0
        ext.w   d1                              ; 006F2
        swap    d1                              ; 006F4
        asr.l   #$2,d1                          ; 006F6
        move.l  d0,-$38(a6)                     ; 006F8
        move.l  d1,-$3c(a6)                     ; 006FC
        move.w  $c(a3),d0                       ; 00700
        ext.l   d0                              ; 00704
        add.l   -$38(a6),d0                     ; 00706
        move.l  $10(a3),d1                      ; 0070A
        move.w  $e(a3),d2                       ; 0070E
        ext.l   d2                              ; 00712
        add.l   -$3c(a6),d2                     ; 00714
        cmp.w   (a1),d1                         ; 00718
        bgt.b   l_024_00744                     ; 0071A
        move.w  $2(a1),d6                       ; 0071C
        ext.l   d6                              ; 00720
        cmp.l   d6,d0                           ; 00722
        ble.b   l_024_00744                     ; 00724
        move.w  $4(a1),d6                       ; 00726
        ext.l   d6                              ; 0072A
        cmp.l   d6,d0                           ; 0072C
        bge.b   l_024_00744                     ; 0072E
        move.w  $6(a1),d6                       ; 00730
        ext.l   d6                              ; 00734
        cmp.l   d6,d2                           ; 00736
        ble.b   l_024_00744                     ; 00738
        move.w  $8(a1),d6                       ; 0073A
        ext.l   d6                              ; 0073E
        cmp.l   d6,d2                           ; 00740
        blt.b   l_024_0075C                     ; 00742
l_024_00744:
        move.w  -$6(a6),d0                      ; 00744
        cmp.w   -$8(a6),d0                      ; 00748
        ble.w   l_024_00AB0                     ; 0074C
        cmpi.w  #$a,d5                          ; 00750
        bge.w   l_024_00AB0                     ; 00754
        bra.w   l_024_0067C                     ; 00758
l_024_0075C:
        move.b  #$1,(dat_071_0026F).l           ; 0075C
        lea.l   $a(a0),a0                       ; 00764
        lea.l   $a(a1),a1                       ; 00768
l_024_0076C:
        cmp.w   (a1),d1                         ; 0076C
        bgt.b   l_024_00798                     ; 0076E
        move.w  $2(a1),d6                       ; 00770
        ext.l   d6                              ; 00774
        cmp.l   d6,d0                           ; 00776
        ble.b   l_024_00798                     ; 00778
        move.w  $4(a1),d6                       ; 0077A
        ext.l   d6                              ; 0077E
        cmp.l   d6,d0                           ; 00780
        bge.b   l_024_00798                     ; 00782
        move.w  $6(a1),d6                       ; 00784
        ext.l   d6                              ; 00788
        cmp.l   d6,d2                           ; 0078A
        ble.b   l_024_00798                     ; 0078C
        move.w  $8(a1),d6                       ; 0078E
        ext.l   d6                              ; 00792
        cmp.l   d6,d2                           ; 00794
        blt.b   l_024_007A6                     ; 00796
l_024_00798:
        move.l  $a(a1),d3                       ; 00798
        blt.b   l_024_00744                     ; 0079C
        movea.l d3,a1                           ; 0079E
        movea.l $a(a0),a0                       ; 007A0
        bra.b   l_024_0076C                     ; 007A4
l_024_007A6:
        move.w  $2(a3),d6                       ; 007A6
        andi.w  #$2,d6                          ; 007AA
        beq.w   l_024_00B04                     ; 007AE
        swap    d5                              ; 007B2
        lea.l   (a0),a2                         ; 007B4
        lea.l   (a1),a4                         ; 007B6
        lea.l   $e(a2),a0                       ; 007B8
        lea.l   $e(a4),a1                       ; 007BC
        move.w  (a0)+,-$1e(a6)                  ; 007C0
        move.b  $7d(a3),d3                      ; 007C4
        move.w  $a4(a3),d6                      ; 007C8
        andi.w  #$f,d3                          ; 007CC
        asr.w   d3,d6                           ; 007D0
        ext.l   d6                              ; 007D2
        add.l   d6,d0                           ; 007D4
        move.w  $a6(a3),d4                      ; 007D6
        asr.w   d3,d4                           ; 007DA
        add.w   d4,d1                           ; 007DC
        move.w  $a8(a3),d6                      ; 007DE
        asr.w   d3,d6                           ; 007E2
        ext.l   d6                              ; 007E4
        add.l   d6,d2                           ; 007E6
        ext.l   d1                              ; 007E8
        move.b  $62(a3),d3                      ; 007EA
        andi.b  #$f0,d3                         ; 007EE
        cmpi.b  #$0,d3                          ; 007F2
        bne.b   l_024_00828                     ; 007F6
        move.w  #$8,-$4c(a6)                    ; 007F8
        movem.l $3e(a3),d3-d5                   ; 007FE
        asr.l   #$3,d3                          ; 00804
        asr.l   #$3,d4                          ; 00806
        asr.l   #$3,d5                          ; 00808
        neg.l   d3                              ; 0080A
        neg.l   d4                              ; 0080C
        neg.l   d5                              ; 0080E
        movem.l d3-d5,-$58(a6)                  ; 00810
        neg.l   d3                              ; 00816
        neg.l   d4                              ; 00818
        neg.l   d5                              ; 0081A
        asr.l   #$5,d3                          ; 0081C
        asr.l   #$5,d4                          ; 0081E
        asr.l   #$5,d5                          ; 00820
        sub.l   d3,d0                           ; 00822
        sub.l   d4,d1                           ; 00824
        sub.l   d5,d2                           ; 00826
l_024_00828:
        addq.w  #$6,a0                          ; 00828
        move.l  d0,d3                           ; 0082A
        move.l  d1,d4                           ; 0082C
        move.l  d2,d5                           ; 0082E
        move.w  (a1)+,d6                        ; 00830
        ext.l   d6                              ; 00832
        sub.l   d6,d3                           ; 00834
        sub.w   (a1)+,d4                        ; 00836
        move.w  (a1)+,d6                        ; 00838
        ext.l   d6                              ; 0083A
        sub.l   d6,d5                           ; 0083C
        movem.w (a0)+,d6-d7                     ; 0083E
        muls.w  d3,d6                           ; 00842
        muls.w  d4,d7                           ; 00844
        add.l   d6,d7                           ; 00846
        move.w  (a0)+,d6                        ; 00848
        muls.w  d5,d6                           ; 0084A
        add.l   d6,d7                           ; 0084C
        bge.w   l_024_008E4                     ; 0084E
        subq.w  #$1,-$1e(a6)                    ; 00852
        bgt.b   l_024_00828                     ; 00856
        move.b  $62(a3),d3                      ; 00858
        andi.b  #$f0,d3                         ; 0085C
        cmpi.b  #$0,d3                          ; 00860
        bne.w   l_024_00A18                     ; 00864
        movem.l $3e(a3),d2-d4                   ; 00868
        sub.l   -$58(a6),d2                     ; 0086E
        sub.l   -$54(a6),d3                     ; 00872
        sub.l   -$50(a6),d4                     ; 00876
        adda.w  #$18,a5                         ; 0087A
        move.w  (a5)+,d7                        ; 0087E
        movea.l (a5)+,a1                        ; 00880
        adda.w  #$a,a5                          ; 00882
        btst    #$4,d7                          ; 00886
        bne.b   l_024_008D4                     ; 0088A
        btst    #$6,d7                          ; 0088C
        bne.b   l_024_008D4                     ; 00890
        move.l  $4(a1),d1                       ; 00892
        ble.b   l_024_008D4                     ; 00896
        movea.l d1,a0                           ; 00898
        move.w  (a0),d1                         ; 0089A
        blt.b   l_024_008AE                     ; 0089C
        andi.w  #$4000,d1                       ; 0089E
        beq.b   l_024_008AA                     ; 008A2
        move.w  $2(a0),d1                       ; 008A4
        bra.b   l_024_008AE                     ; 008A8
l_024_008AA:
        move.w  $4(a0),d1                       ; 008AA
l_024_008AE:
        cmpi.w  #$ffff,d1                       ; 008AE
        beq.b   l_024_008D4                     ; 008B2
        andi.w  #$fff,d1                        ; 008B4
        move.b  $7(a0,d1.w),d1                  ; 008B8
        andi.b  #$10,d1                         ; 008BC
        beq.b   l_024_008D4                     ; 008C0
        movem.l $3e(a3),d5-d7                   ; 008C2
        asr.l   #$1,d5                          ; 008C8
        asr.l   #$1,d6                          ; 008CA
        asr.l   #$1,d7                          ; 008CC
        add.l   d5,d2                           ; 008CE
        add.l   d6,d3                           ; 008D0
        add.l   d7,d4                           ; 008D2
l_024_008D4:
        sub.l   d2,$14(a3)                      ; 008D4
        sub.l   d3,$18(a3)                      ; 008D8
        sub.l   d4,$1c(a3)                      ; 008DC
        bra.w   l_024_00A18                     ; 008E0
l_024_008E4:
        move.b  $62(a3),d3                      ; 008E4
        andi.b  #$f0,d3                         ; 008E8
        cmpi.b  #$10,d3                         ; 008EC
        beq.b   l_024_00936                     ; 008F0
        cmpi.b  #$0,d3                          ; 008F2
        bne.w   l_024_00AFC                     ; 008F6
        subq.w  #$1,-$4c(a6)                    ; 008FA
        blt.w   l_024_00AFC                     ; 008FE
        movem.l $3e(a3),d3-d5                   ; 00902
        asr.l   #$3,d3                          ; 00908
        asr.l   #$3,d4                          ; 0090A
        asr.l   #$3,d5                          ; 0090C
        add.l   d3,-$58(a6)                     ; 0090E
        add.l   d4,-$54(a6)                     ; 00912
        add.l   d5,-$50(a6)                     ; 00916
        asr.l   #$8,d3                          ; 0091A
        asr.l   #$8,d4                          ; 0091C
        asr.l   #$8,d5                          ; 0091E
        add.l   d3,d0                           ; 00920
        add.l   d4,d1                           ; 00922
        add.l   d5,d2                           ; 00924
        lea.l   $e(a2),a0                       ; 00926
        lea.l   $e(a4),a1                       ; 0092A
        move.w  (a0)+,-$1e(a6)                  ; 0092E
        bra.w   l_024_00828                     ; 00932
l_024_00936:
        lea.l   $e(a2),a0                       ; 00936
        lea.l   $e(a4),a1                       ; 0093A
        move.w  (a0)+,-$1e(a6)                  ; 0093E
        move.b  $7d(a3),d3                      ; 00942
        andi.w  #$f,d3                          ; 00946
        move.w  $aa(a3),d0                      ; 0094A
        move.w  $ac(a3),d1                      ; 0094E
        move.w  $ae(a3),d2                      ; 00952
        asr.w   d3,d0                           ; 00956
        asr.w   d3,d1                           ; 00958
        asr.w   d3,d2                           ; 0095A
        ext.l   d1                              ; 0095C
        add.w   $c(a3),d0                       ; 0095E
        add.l   $10(a3),d1                      ; 00962
        add.w   $e(a3),d2                       ; 00966
        ext.l   d0                              ; 0096A
        ext.l   d2                              ; 0096C
        add.l   -$38(a6),d0                     ; 0096E
        add.l   -$3c(a6),d2                     ; 00972
l_024_00976:
        addq.w  #$6,a0                          ; 00976
        move.l  d0,d3                           ; 00978
        move.l  d1,d4                           ; 0097A
        move.l  d2,d5                           ; 0097C
        move.w  (a1)+,d6                        ; 0097E
        ext.l   d6                              ; 00980
        sub.l   d6,d3                           ; 00982
        sub.w   (a1)+,d4                        ; 00984
        move.w  (a1)+,d6                        ; 00986
        ext.l   d6                              ; 00988
        sub.l   d6,d5                           ; 0098A
        movem.w (a0)+,d6-d7                     ; 0098C
        muls.w  d3,d6                           ; 00990
        muls.w  d4,d7                           ; 00992
        add.l   d6,d7                           ; 00994
        move.w  (a0)+,d6                        ; 00996
        muls.w  d5,d6                           ; 00998
        add.l   d6,d7                           ; 0099A
        bge.b   l_024_009A8                     ; 0099C
        subq.w  #$1,-$1e(a6)                    ; 0099E
        bgt.b   l_024_00976                     ; 009A2
        bra.w   l_024_00A18                     ; 009A4
l_024_009A8:
        lea.l   $e(a2),a0                       ; 009A8
        lea.l   $e(a4),a1                       ; 009AC
        move.w  (a0)+,-$1e(a6)                  ; 009B0
        move.b  $7d(a3),d3                      ; 009B4
        andi.w  #$f,d3                          ; 009B8
        move.w  $b0(a3),d0                      ; 009BC
        move.w  $b2(a3),d1                      ; 009C0
        move.w  $b4(a3),d2                      ; 009C4
        asr.w   d3,d0                           ; 009C8
        asr.w   d3,d1                           ; 009CA
        asr.w   d3,d2                           ; 009CC
        ext.l   d1                              ; 009CE
        add.w   $c(a3),d0                       ; 009D0
        add.l   $10(a3),d1                      ; 009D4
        add.w   $e(a3),d2                       ; 009D8
        ext.l   d0                              ; 009DC
        ext.l   d2                              ; 009DE
        add.l   -$38(a6),d0                     ; 009E0
        add.l   -$3c(a6),d2                     ; 009E4
l_024_009E8:
        addq.w  #$6,a0                          ; 009E8
        move.l  d0,d3                           ; 009EA
        move.l  d1,d4                           ; 009EC
        move.l  d2,d5                           ; 009EE
        move.w  (a1)+,d6                        ; 009F0
        ext.l   d6                              ; 009F2
        sub.l   d6,d3                           ; 009F4
        sub.w   (a1)+,d4                        ; 009F6
        move.w  (a1)+,d6                        ; 009F8
        ext.l   d6                              ; 009FA
        sub.l   d6,d5                           ; 009FC
        movem.w (a0)+,d6-d7                     ; 009FE
        muls.w  d3,d6                           ; 00A02
        muls.w  d4,d7                           ; 00A04
        add.l   d6,d7                           ; 00A06
        move.w  (a0)+,d6                        ; 00A08
        muls.w  d5,d6                           ; 00A0A
        add.l   d6,d7                           ; 00A0C
        bge.w   l_024_00AB0                     ; 00A0E
        subq.w  #$1,-$1e(a6)                    ; 00A12
        bgt.b   l_024_009E8                     ; 00A16
l_024_00A18:
        moveq   #$20,d0                         ; 00A18
        unlk    a6                              ; 00A1A
        rts                                     ; 00A1C
l_024_00A1E:
        lea.l   (ObjectTable).l,a1              ; 00A1E
        adda.w  (CurrentObjectOffset).l,a1      ; 00A24
        btst    #$3,$1(a1)                      ; 00A2A
        beq.b   l_024_00A7E                     ; 00A30
        tst.b   $5e(a1)                         ; 00A32
        bne.b   l_024_00A68                     ; 00A36
        movea.l (ConfigBuffer).l,a2             ; 00A38
        cmpi.b  #$0,$62(a1)                     ; 00A3E
        bne.b   l_024_00A54                     ; 00A44
        btst    #$3,$1(a0)                      ; 00A46
        bne.b   l_024_00A68                     ; 00A4C
        addq.w  #$1,$44(a2)                     ; 00A4E
        bra.b   l_024_00A68                     ; 00A52
l_024_00A54:
        cmpi.b  #$1,$62(a1)                     ; 00A54
        bne.b   l_024_00A68                     ; 00A5A
        btst    #$3,$1(a0)                      ; 00A5C
        bne.b   l_024_00A68                     ; 00A62
        addq.w  #$1,$40(a2)                     ; 00A64
l_024_00A68:
        btst    #$3,$1(a0)                      ; 00A68
        beq.b   l_024_00A7E                     ; 00A6E
        bset    #$7,$20(a0)                     ; 00A70
        bset    #$7,$20(a1)                     ; 00A76
        bra.b   l_024_00AAA                     ; 00A7C
l_024_00A7E:
        bclr    #$7,$20(a0)                     ; 00A7E
        bclr    #$7,$20(a1)                     ; 00A84
        tst.w   (CurrentObjectOffset).l         ; 00A8A
        bne.b   l_024_00AAA                     ; 00A90
        move.b  $62(a0),d0                      ; 00A92
        andi.b  #$f0,d0                         ; 00A96
        cmpi.b  #$0,d0                          ; 00A9A
        bne.b   l_024_00AAA                     ; 00A9E
        movea.l (ConfigBuffer).l,a0             ; 00AA0
        addq.w  #$1,$48(a0)                     ; 00AA6
l_024_00AAA:
        moveq   #$40,d0                         ; 00AAA
        unlk    a6                              ; 00AAC
        rts                                     ; 00AAE
l_024_00AB0:
        move.l  $10(a3),d1                      ; 00AB0
        move.l  d1,d2                           ; 00AB4
        move.b  $7b(a3),d0                      ; 00AB6
        blt.b   l_024_00B00                     ; 00ABA
        move.b  $62(a3),d7                      ; 00ABC
        andi.b  #$f0,d7                         ; 00AC0
        cmpi.b  #$10,d7                         ; 00AC4
        bne.b   l_024_00B00                     ; 00AC8
        andi.w  #$f,d0                          ; 00ACA
        bne.b   l_024_00B00                     ; 00ACE
        move.w  $a6(a3),d1                      ; 00AD0
        move.b  $7d(a3),d3                      ; 00AD4
        andi.w  #$f,d3                          ; 00AD8
        asr.w   d3,d1                           ; 00ADC
        ext.l   d1                              ; 00ADE
        add.l   d2,d1                           ; 00AE0
        blt.b   l_024_00B0A                     ; 00AE2
        move.w  $ac(a3),d1                      ; 00AE4
        asr.w   d3,d1                           ; 00AE8
        ext.l   d1                              ; 00AEA
        add.l   d2,d1                           ; 00AEC
        blt.b   l_024_00B0A                     ; 00AEE
        move.w  $b2(a3),d1                      ; 00AF0
        asr.w   d3,d1                           ; 00AF4
        ext.l   d1                              ; 00AF6
        add.l   d2,d1                           ; 00AF8
        bra.b   l_024_00B00                     ; 00AFA
l_024_00AFC:
        move.l  $10(a3),d1                      ; 00AFC
l_024_00B00:
        tst.l   d1                              ; 00B00
        blt.b   l_024_00B0A                     ; 00B02
l_024_00B04:
        moveq   #$0,d0                          ; 00B04
        unlk    a6                              ; 00B06
        rts                                     ; 00B08
l_024_00B0A:
        moveq   #$10,d0                         ; 00B0A
        unlk    a6                              ; 00B0C
        rts                                     ; 00B0E
h024_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    2,53                            ; 2 longs pointing into hunk 53
	dc.l	$518,$2A0
        dc.l    2,52                            ; 2 longs pointing into hunk 52
	dc.l	$510,$298
        dc.l    2,2                             ; 2 longs pointing into hunk 2
	dc.l	$A3A,$AA2
        dc.l    1,73                            ; 1 longs pointing into hunk 73
	dc.l	$1E2
        dc.l    21,71                           ; 21 longs pointing into hunk 71
	dc.l	$666,$8,$124,$760,$678,$202,$23E,$1A
	dc.l	$208,$244,$396,$582,$654,$A26,$A8C,$14
	dc.l	$24C,$390,$57C,$64E,$A20
        dc.l    2,72                            ; 2 longs pointing into hunk 72
	dc.l	$6AE,$6A8
	dc.l	0
	dc.l	HUNK_END
	endc
