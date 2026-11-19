; F/A-18 Interceptor - hunk 120 (code)
; C library: _filbuf, _flsbuf, _getbuf.
; Included by ../f18_main.s.

;===============================================================================
; Hunk 120: CODE, $3F0 bytes
;===============================================================================
	CODE_HUNK	h120

;-------------------------------------------------------------------------------
; _filbuf - _filbuf(fp): refills a stream's buffer with read(); returns its first character or
; EOF.
;-------------------------------------------------------------------------------
_filbuf:
        link.w  a6,#$fff8                       ; 00000
        movea.l $8(a6),a0                       ; 00004
        move.b  $10(a0),d0                      ; 00008
        andi.b  #$30,d0                         ; 0000C
        tst.b   d0                              ; 00010
        beq.b   l_120_0001A                     ; 00012
        moveq   #-1,d0                          ; 00014
        unlk    a6                              ; 00016
        rts                                     ; 00018
l_120_0001A:
        movea.l $8(a6),a0                       ; 0001A
        tst.l   $12(a0)                         ; 0001E
        bne.b   l_120_00040                     ; 00022
        move.b  $10(a0),d0                      ; 00024
        btst    #$2,d0                          ; 00028
        bne.b   l_120_00040                     ; 0002C
        move.l  a0,-(a7)                        ; 0002E
        bsr.w   _getbuf                         ; 00030
        addq.l  #$4,a7                          ; 00034
        tst.l   d0                              ; 00036
        beq.b   l_120_00040                     ; 00038
        moveq   #-1,d0                          ; 0003A
        unlk    a6                              ; 0003C
        rts                                     ; 0003E
l_120_00040:
        movea.l $8(a6),a0                       ; 00040
        move.b  $10(a0),d0                      ; 00044
        btst    #$2,d0                          ; 00048
        beq.b   l_120_00056                     ; 0004C
        moveq   #$1,d0                          ; 0004E
        move.l  d0,-$8(a6)                      ; 00050
        bra.b   l_120_00080                     ; 00054
l_120_00056:
        movea.l $8(a6),a0                       ; 00056
        move.b  $10(a0),d0                      ; 0005A
        btst    #$1,d0                          ; 0005E
        beq.b   l_120_0006A                     ; 00062
        moveq   #-1,d0                          ; 00064
        unlk    a6                              ; 00066
        rts                                     ; 00068
l_120_0006A:
        movea.l $8(a6),a0                       ; 0006A
        move.b  $10(a0),d0                      ; 0006E
        ori.b   #$1,d0                          ; 00072
        move.b  d0,$10(a0)                      ; 00076
        move.l  $12(a0),-$8(a6)                 ; 0007A
l_120_00080:
        moveq   #$0,d0                          ; 00080
        movea.l $8(a6),a0                       ; 00082
        move.b  $11(a0),d0                      ; 00086
        move.l  -$8(a6),-(a7)                   ; 0008A
        move.l  $c(a0),-(a7)                    ; 0008E
        move.l  d0,-(a7)                        ; 00092
        jsr     (read).l                        ; 00094
        lea.l   $c(a7),a7                       ; 0009A
        move.l  d0,-$4(a6)                      ; 0009E
        tst.l   d0                              ; 000A2
        bpl.b   l_120_000B6                     ; 000A4
        movea.l $8(a6),a0                       ; 000A6
        move.b  $10(a0),d0                      ; 000AA
        ori.b   #$20,d0                         ; 000AE
        move.b  d0,$10(a0)                      ; 000B2
l_120_000B6:
        tst.l   -$4(a6)                         ; 000B6
        bne.b   l_120_000CC                     ; 000BA
        movea.l $8(a6),a0                       ; 000BC
        move.b  $10(a0),d0                      ; 000C0
        ori.b   #$10,d0                         ; 000C4
        move.b  d0,$10(a0)                      ; 000C8
l_120_000CC:
        tst.l   -$4(a6)                         ; 000CC
        ble.b   l_120_000E0                     ; 000D0
        movea.l $8(a6),a0                       ; 000D2
        move.l  -$4(a6),$4(a0)                  ; 000D6
        move.l  $c(a0),(a0)                     ; 000DC
l_120_000E0:
        movea.l $8(a6),a0                       ; 000E0
        move.b  $10(a0),d0                      ; 000E4
        andi.b  #$30,d0                         ; 000E8
        tst.b   d0                              ; 000EC
        beq.b   l_120_000F6                     ; 000EE
        moveq   #-1,d0                          ; 000F0
        unlk    a6                              ; 000F2
        rts                                     ; 000F4
l_120_000F6:
        movea.l $8(a6),a0                       ; 000F6
        move.l  $4(a0),d0                       ; 000FA
        subq.l  #$1,d0                          ; 000FE
        move.l  d0,$4(a0)                       ; 00100
        tst.l   d0                              ; 00104
        bmi.b   l_120_00112                     ; 00106
        movea.l (a0),a1                         ; 00108
        addq.l  #$1,(a0)                        ; 0010A
        moveq   #$0,d0                          ; 0010C
        move.b  (a1),d0                         ; 0010E
        bra.b   l_120_0011C                     ; 00110
l_120_00112:
        move.l  $8(a6),-(a7)                    ; 00112
        bsr.w   _filbuf                         ; 00116
        addq.l  #$4,a7                          ; 0011A
l_120_0011C:
        unlk    a6                              ; 0011C
        rts                                     ; 0011E

;-------------------------------------------------------------------------------
; _flsbuf - _flsbuf(c, fp): writes out a stream's buffer with write() and stores c; returns c
; or EOF.
;-------------------------------------------------------------------------------
_flsbuf:
        link.w  a6,#$fff2                       ; 00120
        move.l  $8(a6),-$a(a6)                  ; 00124
        movea.l $c(a6),a0                       ; 0012A
        move.b  $10(a0),d0                      ; 0012E
        andi.b  #$30,d0                         ; 00132
        tst.b   d0                              ; 00136
        beq.b   l_120_00140                     ; 00138
        moveq   #-1,d0                          ; 0013A
        unlk    a6                              ; 0013C
        rts                                     ; 0013E
l_120_00140:
        movea.l $c(a6),a0                       ; 00140
        tst.l   $12(a0)                         ; 00144
        bne.b   l_120_001C0                     ; 00148
        move.b  $10(a0),d0                      ; 0014A
        btst    #$2,d0                          ; 0014E
        bne.b   l_120_001C0                     ; 00152
        cmpi.l  #$ffffffff,$8(a6)               ; 00154
        bne.b   l_120_00164                     ; 0015C
        moveq   #$0,d0                          ; 0015E
        unlk    a6                              ; 00160
        rts                                     ; 00162
l_120_00164:
        move.l  $c(a6),-(a7)                    ; 00164
        bsr.w   _getbuf                         ; 00168
        addq.l  #$4,a7                          ; 0016C
        tst.l   d0                              ; 0016E
        beq.b   l_120_00178                     ; 00170
        moveq   #-1,d0                          ; 00172
        unlk    a6                              ; 00174
        rts                                     ; 00176
l_120_00178:
        movea.l $c(a6),a0                       ; 00178
        move.b  $10(a0),d0                      ; 0017C
        ori.b   #$2,d0                          ; 00180
        move.b  d0,$10(a0)                      ; 00184
        move.l  $12(a0),d0                      ; 00188
        move.l  d0,$8(a0)                       ; 0018C
        subq.l  #$1,d0                          ; 00190
        move.l  d0,$8(a0)                       ; 00192
        tst.l   d0                              ; 00196
        bmi.b   l_120_001AA                     ; 00198
        movea.l (a0),a1                         ; 0019A
        addq.l  #$1,(a0)                        ; 0019C
        move.l  $8(a6),d0                       ; 0019E
        move.b  d0,(a1)                         ; 001A2
        moveq   #$0,d1                          ; 001A4
        move.b  (a1),d1                         ; 001A6
        bra.b   l_120_001BA                     ; 001A8
l_120_001AA:
        move.l  $c(a6),-(a7)                    ; 001AA
        move.l  $8(a6),-(a7)                    ; 001AE
        bsr.w   _flsbuf                         ; 001B2
        addq.l  #$8,a7                          ; 001B6
        move.l  d0,d1                           ; 001B8
l_120_001BA:
        move.l  d1,d0                           ; 001BA
        unlk    a6                              ; 001BC
        rts                                     ; 001BE
l_120_001C0:
        movea.l $c(a6),a0                       ; 001C0
        move.b  $10(a0),d0                      ; 001C4
        btst    #$2,d0                          ; 001C8
        beq.b   l_120_00216                     ; 001CC
        cmpi.l  #$ffffffff,$8(a6)               ; 001CE
        bne.b   l_120_001DE                     ; 001D6
        moveq   #$0,d0                          ; 001D8
        unlk    a6                              ; 001DA
        rts                                     ; 001DC
l_120_001DE:
        move.l  $8(a6),d0                       ; 001DE
        move.b  d0,-$1(a6)                      ; 001E2
        moveq   #$0,d0                          ; 001E6
        movea.l $c(a6),a0                       ; 001E8
        move.b  $11(a0),d0                      ; 001EC
        moveq   #$1,d1                          ; 001F0
        move.l  d1,-(a7)                        ; 001F2
        pea.l   -$1(a6)                         ; 001F4
        move.l  d0,-(a7)                        ; 001F8
        move.l  d1,-$e(a6)                      ; 001FA
        jsr     (write).l                       ; 001FE
        lea.l   $c(a7),a7                       ; 00204
        moveq   #-1,d1                          ; 00208
        move.l  d1,$8(a6)                       ; 0020A
        move.l  d0,-$6(a6)                      ; 0020E
        bra.w   l_120_002D6                     ; 00212
l_120_00216:
        movea.l $c(a6),a0                       ; 00216
        move.b  $10(a0),d0                      ; 0021A
        btst    #$0,d0                          ; 0021E
        beq.b   l_120_0022A                     ; 00222
        moveq   #-1,d0                          ; 00224
        unlk    a6                              ; 00226
        rts                                     ; 00228
l_120_0022A:
        movea.l $c(a6),a0                       ; 0022A
        move.b  $10(a0),d0                      ; 0022E
        ori.b   #$2,d0                          ; 00232
        move.b  d0,$10(a0)                      ; 00236
        cmpi.l  #$ffffffff,$8(a6)               ; 0023A
        beq.b   l_120_0027E                     ; 00242
        tst.l   $8(a0)                          ; 00244
        ble.b   l_120_0027E                     ; 00248
        move.l  $8(a0),d0                       ; 0024A
        subq.l  #$1,d0                          ; 0024E
        move.l  d0,$8(a0)                       ; 00250
        tst.l   d0                              ; 00254
        bmi.b   l_120_00268                     ; 00256
        movea.l (a0),a1                         ; 00258
        addq.l  #$1,(a0)                        ; 0025A
        move.l  $8(a6),d0                       ; 0025C
        move.b  d0,(a1)                         ; 00260
        moveq   #$0,d1                          ; 00262
        move.b  (a1),d1                         ; 00264
        bra.b   l_120_00278                     ; 00266
l_120_00268:
        move.l  $c(a6),-(a7)                    ; 00268
        move.l  $8(a6),-(a7)                    ; 0026C
        bsr.w   _flsbuf                         ; 00270
        addq.l  #$8,a7                          ; 00274
        move.l  d0,d1                           ; 00276
l_120_00278:
        moveq   #-1,d0                          ; 00278
        move.l  d0,$8(a6)                       ; 0027A
l_120_0027E:
        movea.l $c(a6),a1                       ; 0027E
        movea.l (a1),a0                         ; 00282
        cmpa.l  $c(a1),a0                       ; 00284
        beq.b   l_120_002CC                     ; 00288
        tst.l   $8(a1)                          ; 0028A
        bpl.b   l_120_00298                     ; 0028E
        move.l  $12(a1),-$e(a6)                 ; 00290
        bra.b   l_120_002A8                     ; 00296
l_120_00298:
        movea.l $c(a6),a0                       ; 00298
        move.l  $12(a0),d0                      ; 0029C
        sub.l   $8(a0),d0                       ; 002A0
        move.l  d0,-$e(a6)                      ; 002A4
l_120_002A8:
        moveq   #$0,d0                          ; 002A8
        movea.l $c(a6),a0                       ; 002AA
        move.b  $11(a0),d0                      ; 002AE
        move.l  -$e(a6),-(a7)                   ; 002B2
        move.l  $c(a0),-(a7)                    ; 002B6
        move.l  d0,-(a7)                        ; 002BA
        jsr     (write).l                       ; 002BC
        lea.l   $c(a7),a7                       ; 002C2
        move.l  d0,-$6(a6)                      ; 002C6
        bra.b   l_120_002D6                     ; 002CA
l_120_002CC:
        moveq   #$0,d0                          ; 002CC
        move.l  d0,-$6(a6)                      ; 002CE
        move.l  d0,-$e(a6)                      ; 002D2
l_120_002D6:
        cmpi.l  #$ffffffff,-$6(a6)              ; 002D6
        bne.b   l_120_002F2                     ; 002DE
        movea.l $c(a6),a0                       ; 002E0
        move.b  $10(a0),d0                      ; 002E4
        ori.b   #$20,d0                         ; 002E8
        move.b  d0,$10(a0)                      ; 002EC
        bra.b   l_120_0030C                     ; 002F0
l_120_002F2:
        move.l  -$6(a6),d0                      ; 002F2
        cmp.l   -$e(a6),d0                      ; 002F6
        beq.b   l_120_0030C                     ; 002FA
        movea.l $c(a6),a0                       ; 002FC
        move.b  $10(a0),d0                      ; 00300
        ori.b   #$10,d0                         ; 00304
        move.b  d0,$10(a0)                      ; 00308
l_120_0030C:
        movea.l $c(a6),a0                       ; 0030C
        move.l  $12(a0),d0                      ; 00310
        move.l  d0,$8(a0)                       ; 00314
        movea.l $c(a0),a1                       ; 00318
        move.l  a1,(a0)                         ; 0031C
        move.l  $8(a6),d0                       ; 0031E
        cmpi.l  #$ffffffff,d0                   ; 00322
        beq.b   l_120_00354                     ; 00328
        move.l  $8(a0),d1                       ; 0032A
        subq.l  #$1,d1                          ; 0032E
        move.l  d1,$8(a0)                       ; 00330
        tst.l   d1                              ; 00334
        bmi.b   l_120_00344                     ; 00336
        movea.l (a0),a1                         ; 00338
        addq.l  #$1,(a0)                        ; 0033A
        move.b  d0,(a1)                         ; 0033C
        moveq   #$0,d1                          ; 0033E
        move.b  (a1),d1                         ; 00340
        bra.b   l_120_00354                     ; 00342
l_120_00344:
        move.l  $c(a6),-(a7)                    ; 00344
        move.l  $8(a6),-(a7)                    ; 00348
        bsr.w   _flsbuf                         ; 0034C
        addq.l  #$8,a7                          ; 00350
        move.l  d0,d1                           ; 00352
l_120_00354:
        movea.l $c(a6),a0                       ; 00354
        move.b  $10(a0),d0                      ; 00358
        andi.b  #$30,d0                         ; 0035C
        tst.b   d0                              ; 00360
        beq.b   l_120_0036A                     ; 00362
        moveq   #-1,d0                          ; 00364
        unlk    a6                              ; 00366
        rts                                     ; 00368
l_120_0036A:
        cmpi.l  #$ffffffff,-$a(a6)              ; 0036A
        bne.b   l_120_0037A                     ; 00372
        moveq   #$0,d0                          ; 00374
        unlk    a6                              ; 00376
        rts                                     ; 00378
l_120_0037A:
        move.l  -$a(a6),d0                      ; 0037A
        unlk    a6                              ; 0037E
        rts                                     ; 00380

;-------------------------------------------------------------------------------
; _getbuf - _getbuf(fp): gives a stream its buffer (malloc'd, _bufsiz bytes) or makes it
; unbuffered.
;-------------------------------------------------------------------------------
_getbuf:
        link.w  a6,#$0                          ; 00382
        movea.l $8(a6),a0                       ; 00386
        tst.l   $12(a0)                         ; 0038A
        beq.b   l_120_003A0                     ; 0038E
        move.b  $10(a0),d0                      ; 00390
        btst    #$3,d0                          ; 00394
        bne.b   l_120_003A0                     ; 00398
        moveq   #$0,d0                          ; 0039A
        unlk    a6                              ; 0039C
        rts                                     ; 0039E
l_120_003A0:
        move.l  (dat_088_00000).l,-(a7)         ; 003A0
        jsr     (malloc).l                      ; 003A6
        addq.l  #$4,a7                          ; 003AC
        movea.l $8(a6),a0                       ; 003AE
        move.l  d0,(a0)                         ; 003B2
        move.l  d0,$c(a0)                       ; 003B4
        tst.l   d0                              ; 003B8
        bne.b   l_120_003CA                     ; 003BA
        moveq   #$c,d0                          ; 003BC
        move.l  d0,(errno).l                    ; 003BE
        moveq   #-1,d0                          ; 003C4
        unlk    a6                              ; 003C6
        rts                                     ; 003C8
l_120_003CA:
        movea.l $8(a6),a0                       ; 003CA
        move.l  (dat_088_00000).l,$12(a0)       ; 003CE
        move.b  $10(a0),d0                      ; 003D6
        andi.b  #$f3,d0                         ; 003DA
        move.b  d0,$10(a0)                      ; 003DE
        moveq   #$0,d0                          ; 003E2
        move.l  d0,$8(a0)                       ; 003E4
        move.l  d0,$4(a0)                       ; 003E8
        unlk    a6                              ; 003EC
        rts                                     ; 003EE
h120_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    3,117                           ; 3 longs pointing into hunk 117
	dc.l	$96,$200,$2BE
        dc.l    2,88                            ; 2 longs pointing into hunk 88
	dc.l	$3A2,$3D0
        dc.l    1,126                           ; 1 longs pointing into hunk 126
	dc.l	$3A8
        dc.l    1,94                            ; 1 longs pointing into hunk 94
	dc.l	$3C0
	dc.l	0
	dc.l	HUNK_END
	endc
