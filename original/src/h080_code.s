; F/A-18 Interceptor - hunk 80 (code)
; Included by ../f18_main.s.

;===============================================================================
; Hunk 80: CODE, $49C bytes
;===============================================================================
	CODE_HUNK	h080
sub_080_00000:
        link.w  a6,#$fff0                       ; 00000
        clr.l   -$8(a6)                         ; 00004
        move.l  #$10000,-(a7)                   ; 00008
        move.l  #$110,-(a7)                     ; 0000E
        jsr     (_AllocMem).l                   ; 00014
        addq.l  #$8,a7                          ; 0001A
        move.l  d0,-$c(a6)                      ; 0001C
        tst.l   d0                              ; 00020
        beq.b   l_080_0007C                     ; 00022
        addq.l  #$4,d0                          ; 00024
        andi.l  #$fffffffc,d0                   ; 00026
        move.l  #$3ed,-(a7)                     ; 0002C
        move.l  $8(a6),-(a7)                    ; 00032
        move.l  d0,-$10(a6)                     ; 00036
        jsr     (_Lock).l                       ; 0003A
        addq.l  #$8,a7                          ; 00040
        move.l  -$10(a6),-(a7)                  ; 00042
        move.l  d0,-(a7)                        ; 00046
        move.l  d0,-$4(a6)                      ; 00048
        jsr     (_Examine).l                    ; 0004C
        addq.l  #$8,a7                          ; 00052
        movea.l -$10(a6),a0                     ; 00054
        move.l  $7c(a0),-$8(a6)                 ; 00058
        move.l  -$4(a6),-(a7)                   ; 0005E
        jsr     (_UnLock).l                     ; 00062
        addq.l  #$4,a7                          ; 00068
        move.l  #$110,-(a7)                     ; 0006A
        move.l  -$c(a6),-(a7)                   ; 00070
        jsr     (_FreeMem).l                    ; 00074
        addq.l  #$8,a7                          ; 0007A
l_080_0007C:
        move.l  -$8(a6),d0                      ; 0007C
        unlk    a6                              ; 00080
        rts                                     ; 00082
sub_080_00084:
        link.w  a6,#$fffc                       ; 00084
        tst.l   (dat_078_0000E).l               ; 00088
        bne.b   l_080_00096                     ; 0008E
        moveq   #$0,d0                          ; 00090
        unlk    a6                              ; 00092
        rts                                     ; 00094
l_080_00096:
        move.l  $c(a6),d0                       ; 00096
        asl.l   #$2,d0                          ; 0009A
        movea.l d0,a0                           ; 0009C
        adda.l  #dat_081_00000,a0               ; 0009E
        tst.l   (a0)                            ; 000A4
        beq.b   l_080_000B2                     ; 000A6
        move.l  $c(a6),-(a7)                    ; 000A8
        bsr.w   sub_080_003EE                   ; 000AC
        addq.l  #$4,a7                          ; 000B0
l_080_000B2:
        move.l  $c(a6),d0                       ; 000B2
        asl.l   #$2,d0                          ; 000B6
        movea.l d0,a0                           ; 000B8
        adda.l  #dat_081_00000,a0               ; 000BA
        move.l  #$10000,-(a7)                   ; 000C0
        moveq   #$40,d0                         ; 000C6
        move.l  d0,-(a7)                        ; 000C8
        move.l  a0,$8(a7)                       ; 000CA
        jsr     (_AllocMem).l                   ; 000CE
        addq.l  #$8,a7                          ; 000D4
        movea.l $0(a7),a0                       ; 000D6
        move.l  d0,(a0)                         ; 000DA
        tst.l   d0                              ; 000DC
        bne.b   l_080_000E6                     ; 000DE
        moveq   #$0,d0                          ; 000E0
        unlk    a6                              ; 000E2
        rts                                     ; 000E4
l_080_000E6:
        move.l  $c(a6),d0                       ; 000E6
        asl.l   #$2,d0                          ; 000EA
        movea.l d0,a0                           ; 000EC
        adda.l  #dat_081_00000,a0               ; 000EE
        movea.l (a0),a1                         ; 000F4
        moveq   #$2,d0                          ; 000F6
        move.l  d0,-(a7)                        ; 000F8
        move.l  $8(a6),-(a7)                    ; 000FA
        move.l  a1,$8(a7)                       ; 000FE
        jsr     (_AllocMem).l                   ; 00102
        addq.l  #$8,a7                          ; 00108
        movea.l $0(a7),a0                       ; 0010A
        move.l  d0,(a0)                         ; 0010E
        tst.l   d0                              ; 00110
        beq.b   l_080_00172                     ; 00112
        move.l  $c(a6),d0                       ; 00114
        asl.l   #$2,d0                          ; 00118
        movea.l d0,a0                           ; 0011A
        adda.l  #dat_081_00000,a0               ; 0011C
        movea.l (a0),a1                         ; 00122
        move.l  $8(a6),$4(a1)                   ; 00124
        movea.l d0,a0                           ; 0012A
        adda.l  #dat_081_00000,a0               ; 0012C
        movea.l (a0),a1                         ; 00132
        move.l  #$1660000,$8(a1)                ; 00134
        movea.l d0,a0                           ; 0013C
        adda.l  #dat_081_00000,a0               ; 0013E
        movea.l (a0),a1                         ; 00144
        move.l  #$3f0000,$c(a1)                 ; 00146
        movea.l d0,a0                           ; 0014E
        adda.l  #dat_081_00000,a0               ; 00150
        movea.l (a0),a1                         ; 00156
        moveq   #$1,d1                          ; 00158
        move.l  d1,$10(a1)                      ; 0015A
        movea.l d0,a0                           ; 0015E
        adda.l  #dat_081_00000,a0               ; 00160
        movea.l (a0),a1                         ; 00166
        clr.l   $20(a1)                         ; 00168
        move.l  d1,d0                           ; 0016C
        unlk    a6                              ; 0016E
        rts                                     ; 00170
l_080_00172:
        move.l  $c(a6),d0                       ; 00172
        asl.l   #$2,d0                          ; 00176
        movea.l d0,a0                           ; 00178
        adda.l  #dat_081_00000,a0               ; 0017A
        moveq   #$40,d0                         ; 00180
        move.l  d0,-(a7)                        ; 00182
        move.l  (a0),-(a7)                      ; 00184
        jsr     (_FreeMem).l                    ; 00186
        addq.l  #$8,a7                          ; 0018C
        move.l  $c(a6),d0                       ; 0018E
        asl.l   #$2,d0                          ; 00192
        movea.l d0,a0                           ; 00194
        adda.l  #dat_081_00000,a0               ; 00196
        suba.l  a1,a1                           ; 0019C
        move.l  a1,(a0)                         ; 0019E
        move.l  a1,d0                           ; 001A0
        unlk    a6                              ; 001A2
        rts                                     ; 001A4
sub_080_001A6:
        link.w  a6,#$fff8                       ; 001A6
        move.l  $8(a6),-(a7)                    ; 001AA
        bsr.w   sub_080_00000                   ; 001AE
        addq.l  #$4,a7                          ; 001B2
        move.l  d0,-$8(a6)                      ; 001B4
        tst.l   d0                              ; 001B8
        bne.b   l_080_001C2                     ; 001BA
        moveq   #$0,d0                          ; 001BC
        unlk    a6                              ; 001BE
        rts                                     ; 001C0
l_080_001C2:
        move.l  $c(a6),-(a7)                    ; 001C2
        move.l  -$8(a6),-(a7)                   ; 001C6
        bsr.w   sub_080_00084                   ; 001CA
        addq.l  #$8,a7                          ; 001CE
        tst.l   d0                              ; 001D0
        bne.b   l_080_001DA                     ; 001D2
        moveq   #$0,d0                          ; 001D4
        unlk    a6                              ; 001D6
        rts                                     ; 001D8
l_080_001DA:
        pea.l   (dat_081_000A0).l               ; 001DA
        move.l  $8(a6),-(a7)                    ; 001E0
        jsr     (sub_105_00000).l               ; 001E4
        addq.l  #$8,a7                          ; 001EA
        move.l  d0,-$4(a6)                      ; 001EC
        tst.l   d0                              ; 001F0
        beq.b   l_080_00226                     ; 001F2
        move.l  $c(a6),d1                       ; 001F4
        asl.l   #$2,d1                          ; 001F8
        movea.l d1,a0                           ; 001FA
        adda.l  #dat_081_00000,a0               ; 001FC
        movea.l (a0),a1                         ; 00202
        move.l  d0,-(a7)                        ; 00204
        moveq   #$1,d1                          ; 00206
        move.l  d1,-(a7)                        ; 00208
        move.l  -$8(a6),-(a7)                   ; 0020A
        move.l  (a1),-(a7)                      ; 0020E
        jsr     (sub_111_00000).l               ; 00210
        lea.l   $10(a7),a7                      ; 00216
        move.l  -$4(a6),-(a7)                   ; 0021A
        jsr     (sub_105_0025A).l               ; 0021E
        addq.l  #$4,a7                          ; 00224
l_080_00226:
        moveq   #$1,d0                          ; 00226
        unlk    a6                              ; 00228
        rts                                     ; 0022A
sub_080_0022C:
        link.w  a6,#$fffc                       ; 0022C
        movem.l a2,-(a7)                        ; 00230
        tst.l   (dat_078_0000E).l               ; 00234
        bne.b   l_080_00246                     ; 0023A
        moveq   #$0,d0                          ; 0023C
        movem.l (a7)+,a2                        ; 0023E
        unlk    a6                              ; 00242
        rts                                     ; 00244
l_080_00246:
        move.l  $c(a6),d0                       ; 00246
        asl.l   #$2,d0                          ; 0024A
        movea.l d0,a0                           ; 0024C
        adda.l  #dat_081_00000,a0               ; 0024E
        tst.l   (a0)                            ; 00254
        beq.b   l_080_00262                     ; 00256
        move.l  $c(a6),-(a7)                    ; 00258
        bsr.w   sub_080_003EE                   ; 0025C
        addq.l  #$4,a7                          ; 00260
l_080_00262:
        move.l  $8(a6),d0                       ; 00262
        asl.l   #$2,d0                          ; 00266
        movea.l d0,a0                           ; 00268
        adda.l  #dat_081_00000,a0               ; 0026A
        tst.l   (a0)                            ; 00270
        bne.b   l_080_0027E                     ; 00272
        moveq   #$0,d0                          ; 00274
        movem.l (a7)+,a2                        ; 00276
        unlk    a6                              ; 0027A
        rts                                     ; 0027C
l_080_0027E:
        move.l  $c(a6),d0                       ; 0027E
        asl.l   #$2,d0                          ; 00282
        movea.l d0,a0                           ; 00284
        adda.l  #dat_081_00000,a0               ; 00286
        move.l  #$10000,-(a7)                   ; 0028C
        moveq   #$40,d0                         ; 00292
        move.l  d0,-(a7)                        ; 00294
        move.l  a0,$c(a7)                       ; 00296
        jsr     (_AllocMem).l                   ; 0029A
        addq.l  #$8,a7                          ; 002A0
        movea.l $4(a7),a0                       ; 002A2
        move.l  d0,(a0)                         ; 002A6
        tst.l   d0                              ; 002A8
        bne.b   l_080_002B6                     ; 002AA
        moveq   #$0,d0                          ; 002AC
        movem.l (a7)+,a2                        ; 002AE
        unlk    a6                              ; 002B2
        rts                                     ; 002B4
l_080_002B6:
        move.l  $c(a6),d0                       ; 002B6
        asl.l   #$2,d0                          ; 002BA
        movea.l d0,a0                           ; 002BC
        adda.l  #dat_081_00000,a0               ; 002BE
        movea.l (a0),a1                         ; 002C4
        move.l  $8(a6),d1                       ; 002C6
        asl.l   #$2,d1                          ; 002CA
        movea.l d1,a0                           ; 002CC
        adda.l  #dat_081_00000,a0               ; 002CE
        movea.l (a0),a2                         ; 002D4
        move.l  (a2),(a1)                       ; 002D6
        movea.l d0,a0                           ; 002D8
        adda.l  #dat_081_00000,a0               ; 002DA
        movea.l (a0),a1                         ; 002E0
        movea.l d1,a0                           ; 002E2
        adda.l  #dat_081_00000,a0               ; 002E4
        movea.l (a0),a2                         ; 002EA
        move.l  $4(a2),d2                       ; 002EC
        ori.l   #$80000000,d2                   ; 002F0
        move.l  d2,$4(a1)                       ; 002F6
        movea.l d0,a0                           ; 002FA
        adda.l  #dat_081_00000,a0               ; 002FC
        movea.l (a0),a1                         ; 00302
        movea.l d1,a0                           ; 00304
        adda.l  #dat_081_00000,a0               ; 00306
        movea.l (a0),a2                         ; 0030C
        move.l  $8(a2),$8(a1)                   ; 0030E
        movea.l d0,a0                           ; 00314
        adda.l  #dat_081_00000,a0               ; 00316
        movea.l (a0),a1                         ; 0031C
        movea.l d1,a0                           ; 0031E
        adda.l  #dat_081_00000,a0               ; 00320
        movea.l (a0),a2                         ; 00326
        move.l  $c(a2),$c(a1)                   ; 00328
        movea.l d0,a0                           ; 0032E
        adda.l  #dat_081_00000,a0               ; 00330
        movea.l (a0),a1                         ; 00336
        movea.l d1,a0                           ; 00338
        adda.l  #dat_081_00000,a0               ; 0033A
        movea.l (a0),a2                         ; 00340
        move.l  $10(a2),$10(a1)                 ; 00342
        movea.l d0,a0                           ; 00348
        adda.l  #dat_081_00000,a0               ; 0034A
        movea.l (a0),a1                         ; 00350
        movea.l d1,a0                           ; 00352
        adda.l  #dat_081_00000,a0               ; 00354
        movea.l (a0),a2                         ; 0035A
        move.l  $18(a2),$18(a1)                 ; 0035C
        movea.l d0,a0                           ; 00362
        adda.l  #dat_081_00000,a0               ; 00364
        movea.l (a0),a1                         ; 0036A
        movea.l d1,a0                           ; 0036C
        adda.l  #dat_081_00000,a0               ; 0036E
        movea.l (a0),a2                         ; 00374
        move.l  $1c(a2),$1c(a1)                 ; 00376
        movea.l d0,a0                           ; 0037C
        adda.l  #dat_081_00000,a0               ; 0037E
        movea.l (a0),a1                         ; 00384
        movea.l d1,a0                           ; 00386
        adda.l  #dat_081_00000,a0               ; 00388
        movea.l (a0),a2                         ; 0038E
        move.l  $20(a2),$20(a1)                 ; 00390
        movea.l d0,a0                           ; 00396
        adda.l  #dat_081_00000,a0               ; 00398
        movea.l (a0),a1                         ; 0039E
        movea.l d1,a0                           ; 003A0
        adda.l  #dat_081_00000,a0               ; 003A2
        movea.l (a0),a2                         ; 003A8
        move.l  $2c(a2),$2c(a1)                 ; 003AA
        movea.l d0,a0                           ; 003B0
        adda.l  #dat_081_00000,a0               ; 003B2
        movea.l (a0),a1                         ; 003B8
        movea.l d1,a0                           ; 003BA
        adda.l  #dat_081_00000,a0               ; 003BC
        movea.l (a0),a2                         ; 003C2
        move.l  $38(a2),$38(a1)                 ; 003C4
        movea.l d0,a0                           ; 003CA
        adda.l  #dat_081_00000,a0               ; 003CC
        movea.l (a0),a1                         ; 003D2
        movea.l d1,a0                           ; 003D4
        adda.l  #dat_081_00000,a0               ; 003D6
        movea.l (a0),a2                         ; 003DC
        move.l  $3c(a2),$3c(a1)                 ; 003DE
        moveq   #$1,d0                          ; 003E4
        movem.l (a7)+,a2                        ; 003E6
        unlk    a6                              ; 003EA
        rts                                     ; 003EC
sub_080_003EE:
        link.w  a6,#$0                          ; 003EE
        movem.l a2,-(a7)                        ; 003F2
        move.l  $8(a6),d0                       ; 003F6
        asl.l   #$2,d0                          ; 003FA
        movea.l d0,a0                           ; 003FC
        adda.l  #dat_081_00000,a0               ; 003FE
        tst.l   (a0)                            ; 00404
        beq.b   l_080_0046E                     ; 00406
        movea.l d0,a0                           ; 00408
        adda.l  #dat_081_00000,a0               ; 0040A
        movea.l (a0),a1                         ; 00410
        move.l  $4(a1),d1                       ; 00412
        andi.l  #$80000000,d1                   ; 00416
        tst.l   d1                              ; 0041C
        bne.b   l_080_00442                     ; 0041E
        movea.l d0,a0                           ; 00420
        adda.l  #dat_081_00000,a0               ; 00422
        movea.l (a0),a1                         ; 00428
        movea.l d0,a0                           ; 0042A
        adda.l  #dat_081_00000,a0               ; 0042C
        movea.l (a0),a2                         ; 00432
        move.l  $4(a2),-(a7)                    ; 00434
        move.l  (a1),-(a7)                      ; 00438
        jsr     (_FreeMem).l                    ; 0043A
        addq.l  #$8,a7                          ; 00440
l_080_00442:
        move.l  $8(a6),d0                       ; 00442
        asl.l   #$2,d0                          ; 00446
        movea.l d0,a0                           ; 00448
        adda.l  #dat_081_00000,a0               ; 0044A
        moveq   #$40,d0                         ; 00450
        move.l  d0,-(a7)                        ; 00452
        move.l  (a0),-(a7)                      ; 00454
        jsr     (_FreeMem).l                    ; 00456
        addq.l  #$8,a7                          ; 0045C
        move.l  $8(a6),d0                       ; 0045E
        asl.l   #$2,d0                          ; 00462
        movea.l d0,a0                           ; 00464
        adda.l  #dat_081_00000,a0               ; 00466
        clr.l   (a0)                            ; 0046C
l_080_0046E:
        movem.l (a7)+,a2                        ; 0046E
        unlk    a6                              ; 00472
        rts                                     ; 00474
sub_080_00476:
        link.w  a6,#$fffc                       ; 00476
        clr.l   -$4(a6)                         ; 0047A
l_080_0047E:
        move.l  -$4(a6),d0                      ; 0047E
        cmpi.l  #$28,d0                         ; 00482
        bge.b   l_080_00498                     ; 00488
        move.l  d0,-(a7)                        ; 0048A
        bsr.w   sub_080_003EE                   ; 0048C
        addq.l  #$4,a7                          ; 00490
        addq.l  #$1,-$4(a6)                     ; 00492
        bra.b   l_080_0047E                     ; 00496
l_080_00498:
        unlk    a6                              ; 00498
        rts                                     ; 0049A
h080_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    43,81                           ; 43 longs pointing into hunk 81
	dc.l	$468,$44C,$42E,$424,$40C,$400,$3D8,$3CE
	dc.l	$3BE,$3B4,$3A4,$39A,$38A,$380,$370,$366
	dc.l	$356,$34C,$33C,$332,$322,$318,$308,$2FE
	dc.l	$2E6,$2DC,$2D0,$2C0,$288,$26C,$250,$1FE
	dc.l	$1DC,$198,$17C,$162,$152,$140,$12E,$11E
	dc.l	$F0,$BC,$A0
        dc.l    4,172                           ; 4 longs pointing into hunk 172
	dc.l	$16,$D0,$104,$29C
        dc.l    1,171                           ; 1 longs pointing into hunk 171
	dc.l	$3C
        dc.l    1,171                           ; 1 longs pointing into hunk 171
	dc.l	$4E
        dc.l    1,171                           ; 1 longs pointing into hunk 171
	dc.l	$64
        dc.l    4,172                           ; 4 longs pointing into hunk 172
	dc.l	$76,$188,$43C,$458
        dc.l    2,78                            ; 2 longs pointing into hunk 78
	dc.l	$8A,$236
        dc.l    2,105                           ; 2 longs pointing into hunk 105
	dc.l	$1E6,$220
        dc.l    1,111                           ; 1 longs pointing into hunk 111
	dc.l	$212
	dc.l	0
	dc.l	HUNK_END
	endc
