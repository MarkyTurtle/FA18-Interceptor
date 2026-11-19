; F/A-18 Interceptor - hunk 166 (code)
; Included by ../f18_main.s.

;===============================================================================
; Hunk 166: CODE, $394 bytes
;===============================================================================
	CODE_HUNK	h166

;-------------------------------------------------------------------------------
; fp_DoubleToDigits - Converts a double to decimal digits and an exponent, for printf's
; %e/%f/%g.
;-------------------------------------------------------------------------------
fp_DoubleToDigits:
        link.w  a0,#$ffe2                       ; 00000
        link.w  a1,#$0                          ; 00004
        movem.l d1-d7/a2-a3,-(a7)               ; 00008
        movea.l $8(a0),a2                       ; 0000C
        move.l  (a2)+,d0                        ; 00010
        move.l  (a2),d1                         ; 00012
        jsr     (fp_DoubleUnpack).l             ; 00014
        clr.w   $8(a1)                          ; 0001A
        clr.w   $6(a1)                          ; 0001E
        move.l  d0,-(a7)                        ; 00022
        or.l    d1,(a7)+                        ; 00024
        bne.b   l_166_00036                     ; 00026
        movea.l $1c(a0),a2                      ; 00028
        move.l  $c(a0),d3                       ; 0002C
        subq.l  #$1,d3                          ; 00030
        bra.w   l_166_0012C                     ; 00032
l_166_00036:
        addq.w  #$1,d2                          ; 00036
        move.w  d2,$4(a1)                       ; 00038
        swap    d2                              ; 0003C
        move.w  d2,$8(a1)                       ; 0003E
l_166_00042:
        clr.w   d6                              ; 00042
        move.w  $4(a1),d2                       ; 00044
        beq.b   l_166_000A6                     ; 00048
        bpl.b   l_166_0005E                     ; 0004A
        addq.w  #$3,d2                          ; 0004C
        bmi.b   l_166_00068                     ; 0004E
        eori.w  #$3,d2                          ; 00050
        add.w   d2,$4(a1)                       ; 00054
        bsr.w   sub_166_0015A                   ; 00058
        bra.b   l_166_000A6                     ; 0005C
l_166_0005E:
        bsr.w   sub_166_00192                   ; 0005E
        addq.w  #$1,$6(a1)                      ; 00062
        bra.b   l_166_0007A                     ; 00066
l_166_00068:
        moveq   #$4,d2                          ; 00068
        add.w   d2,$4(a1)                       ; 0006A
        bsr.w   sub_166_0015A                   ; 0006E
        bsr.w   sub_166_00166                   ; 00072
        subq.w  #$1,$6(a1)                      ; 00076
l_166_0007A:
        tst.l   d0                              ; 0007A
        bmi.b   l_166_00042                     ; 0007C
        subq.w  #$1,$4(a1)                      ; 0007E
        lsl.l   #$1,d1                          ; 00082
        roxl.l  #$1,d0                          ; 00084
        bra.b   l_166_0007A                     ; 00086
	dc.b	$42,$42
l_166_0008A:
        clr.w   d6                              ; 0008A
        move.l  d0,-(a7)                        ; 0008C
        or.l    d1,(a7)+                        ; 0008E
        beq.b   l_166_000A6                     ; 00090
l_166_00092:
        bsr.w   sub_166_00166                   ; 00092
        tst.w   d6                              ; 00096
        bne.b   l_166_000A6                     ; 00098
        cmpi.w  #$1,d2                          ; 0009A
        bne.b   l_166_000A6                     ; 0009E
        subq.w  #$1,$6(a1)                      ; 000A0
        bra.b   l_166_00092                     ; 000A4
l_166_000A6:
        addi.b  #$30,d6                         ; 000A6
        move.b  d6,$a(a1,d2.w)                  ; 000AA
        addq.w  #$1,d2                          ; 000AE
        cmp.w   #$14,d2                         ; 000B0
        bmi.b   l_166_0008A                     ; 000B4
        moveq   #$1,d3                          ; 000B6
        move.l  $c(a0),d2                       ; 000B8
        tst.l   $10(a0)                         ; 000BC
        beq.b   l_166_000D0                     ; 000C0
        move.l  #$1,d4                          ; 000C2
        add.w   $6(a1),d2                       ; 000C8
        subq.w  #$1,d2                          ; 000CC
        bmi.b   l_166_0010A                     ; 000CE
l_166_000D0:
        moveq   #$14,d4                         ; 000D0
        cmpi.w  #$12,d2                         ; 000D2
        bge.b   l_166_0010A                     ; 000D6
        move.w  d2,d4                           ; 000D8
        move.b  $b(a1,d2.w),d5                  ; 000DA
        addi.b  #$5,d5                          ; 000DE
l_166_000E2:
        cmpi.b  #$39,d5                         ; 000E2
        ble.b   l_166_0010A                     ; 000E6
        move.b  #$30,$b(a1,d2.w)                ; 000E8
        addq.b  #$1,$a(a1,d2.w)                 ; 000EE
        move.b  $a(a1,d2.l),d5                  ; 000F2
        subq.w  #$1,d2                          ; 000F6
        bpl.b   l_166_000E2                     ; 000F8
        addq.w  #$1,$6(a1)                      ; 000FA
        subq.w  #$1,d3                          ; 000FE
        moveq   #$0,d5                          ; 00100
        cmp.l   $10(a0),d5                      ; 00102
        beq.b   l_166_0010A                     ; 00106
        addq.l  #$1,d4                          ; 00108
l_166_0010A:
        movea.l $1c(a0),a2                      ; 0010A
        lea.l   $a(a1,d3.w),a3                  ; 0010E
        move.l  d4,d0                           ; 00112
        beq.b   l_166_00134                     ; 00114
        subq.w  #$1,d4                          ; 00116
        move.w  d4,d3                           ; 00118
        subi.w  #$14,d3                         ; 0011A
        bmi.b   l_166_00122                     ; 0011E
        moveq   #$13,d4                         ; 00120
l_166_00122:
        move.b  (a3)+,(a2)+                     ; 00122
        dbra    d4,l_166_00122                  ; 00124
        tst.w   d3                              ; 00128
        bmi.b   l_166_00134                     ; 0012A
l_166_0012C:
        move.b  #$30,(a2)+                      ; 0012C
        dbra    d3,l_166_0012C                  ; 00130
l_166_00134:
        movea.l $18(a0),a2                      ; 00134
        clr.l   (a2)                            ; 00138
        tst.w   $8(a1)                          ; 0013A
        beq.b   l_166_00142                     ; 0013E
        subq.l  #$1,(a2)                        ; 00140
l_166_00142:
        movea.l $14(a0),a2                      ; 00142
        clr.l   d1                              ; 00146
        move.w  $6(a1),d1                       ; 00148
        ext.l   d1                              ; 0014C
        move.l  d1,(a2)                         ; 0014E
        movem.l (a7)+,d1-d7/a2-a3               ; 00150
        unlk    a1                              ; 00154
        unlk    a0                              ; 00156
        rts                                     ; 00158
sub_166_0015A:
        lsr.l   #$1,d0                          ; 0015A
        roxr.l  #$1,d1                          ; 0015C
        sub.w   #$1,d2                          ; 0015E
        bne.b   sub_166_0015A                   ; 00162
        rts                                     ; 00164
sub_166_00166:
        moveq   #$0,d6                          ; 00166
        movem.l d2-d3,-(a7)                     ; 00168
        move.l  d0,d2                           ; 0016C
        move.l  d1,d3                           ; 0016E
        lsl.l   #$1,d1                          ; 00170
        roxl.l  #$1,d0                          ; 00172
        roxl.l  #$1,d6                          ; 00174
        lsl.l   #$1,d1                          ; 00176
        roxl.l  #$1,d0                          ; 00178
        roxl.l  #$1,d6                          ; 0017A
        add.l   d3,d1                           ; 0017C
        addx.l  d2,d0                           ; 0017E
        bcc.w   l_166_00186                     ; 00180
        addq.l  #$1,d6                          ; 00184
l_166_00186:
        lsl.l   #$1,d1                          ; 00186
        roxl.l  #$1,d0                          ; 00188
        roxl.l  #$1,d6                          ; 0018A
        movem.l (a7)+,d2-d3                     ; 0018C
        rts                                     ; 00190
sub_166_00192:
        move.l  d2,-(a7)                        ; 00192
        moveq   #$0,d2                          ; 00194
        move.w  #$40,-(a7)                      ; 00196
l_166_0019A:
        lsl.l   #$1,d1                          ; 0019A
        roxl.l  #$1,d0                          ; 0019C
        roxl.l  #$1,d2                          ; 0019E
        cmpi.w  #$a,d2                          ; 001A0
        blt.b   l_166_001AE                     ; 001A4
        subi.l  #$a,d2                          ; 001A6
        addq.l  #$1,d1                          ; 001AC
l_166_001AE:
        subq.w  #$1,(a7)                        ; 001AE
        bne.b   l_166_0019A                     ; 001B0
        lea.l   $2(a7),a7                       ; 001B2
        move.l  (a7)+,d2                        ; 001B6
        rts                                     ; 001B8
sub_166_001BA:
        link.w  a0,#$fff4                       ; 001BA
        link.w  a1,#$0                          ; 001BE
        movem.l d1-d6/a2-a3,-(a7)               ; 001C2
        moveq   #$0,d0                          ; 001C6
        moveq   #$0,d1                          ; 001C8
        move.w  d0,$0(a1)                       ; 001CA
        move.w  d0,$2(a1)                       ; 001CE
        move.w  d0,$4(a1)                       ; 001D2
        move.w  d0,$6(a1)                       ; 001D6
l_166_001DA:
        bsr.w   sub_166_00352                   ; 001DA
        cmpi.b  #$30,d6                         ; 001DE
        bne.b   l_166_001EC                     ; 001E2
        ori.w   #$2000,$4(a1)                   ; 001E4
        bra.b   l_166_001DA                     ; 001EA
l_166_001EC:
        cmpi.b  #$2d,d6                         ; 001EC
        bne.b   l_166_001FC                     ; 001F0
        ori.w   #$8000,$4(a1)                   ; 001F2
l_166_001F8:
        bsr.w   sub_166_00352                   ; 001F8
l_166_001FC:
        cmpi.b  #$30,d6                         ; 001FC
        blt.b   l_166_00240                     ; 00200
        cmpi.b  #$39,d6                         ; 00202
        bgt.b   l_166_00240                     ; 00206
        ori.w   #$2000,$4(a1)                   ; 00208
        move.w  d6,$a(a1)                       ; 0020E
        move.w  $6(a1),d6                       ; 00212
        sub.w   d6,$2(a1)                       ; 00216
        move.l  d0,-(a7)                        ; 0021A
        andi.l  #$f0000000,(a7)+                ; 0021C
        beq.b   l_166_0022A                     ; 00222
        addq.w  #$1,$2(a1)                      ; 00224
        bra.b   l_166_001F8                     ; 00228
l_166_0022A:
        bsr.w   sub_166_00166                   ; 0022A
        move.w  $a(a1),d6                       ; 0022E
        andi.l  #$f,d6                          ; 00232
        add.l   d6,d1                           ; 00238
        clr.l   d6                              ; 0023A
        addx.l  d6,d0                           ; 0023C
        bra.b   l_166_001F8                     ; 0023E
l_166_00240:
        cmpi.b  #$2e,d6                         ; 00240
        bne.b   l_166_00252                     ; 00244
        tst.w   $6(a1)                          ; 00246
        bne.b   l_166_002AE                     ; 0024A
        addq.w  #$1,$6(a1)                      ; 0024C
        bra.b   l_166_001F8                     ; 00250
l_166_00252:
        cmpi.b  #$45,d6                         ; 00252
        beq.b   l_166_0025E                     ; 00256
        cmpi.b  #$65,d6                         ; 00258
        bne.b   l_166_002AE                     ; 0025C
l_166_0025E:
        bsr.w   sub_166_00352                   ; 0025E
        cmpi.b  #$2b,d6                         ; 00262
        beq.b   l_166_00274                     ; 00266
        cmpi.b  #$2d,d6                         ; 00268
        bne.b   l_166_00278                     ; 0026C
        ori.w   #$1000,$4(a1)                   ; 0026E
l_166_00274:
        bsr.w   sub_166_00352                   ; 00274
l_166_00278:
        cmpi.b  #$30,d6                         ; 00278
        blt.b   l_166_002AE                     ; 0027C
        cmpi.b  #$39,d6                         ; 0027E
        bgt.b   l_166_002AE                     ; 00282
        move.w  $0(a1),d5                       ; 00284
        asl.w   $0(a1)                          ; 00288
        asl.w   $0(a1)                          ; 0028C
        add.w   d5,$0(a1)                       ; 00290
        asl.w   $0(a1)                          ; 00294
        andi.w  #$f,d6                          ; 00298
        add.w   d6,$0(a1)                       ; 0029C
l_166_002A0:
        cmpi.w  #$fff,$0(a1)                    ; 002A0
        blt.b   l_166_00274                     ; 002A6
        asr.w   $0(a1)                          ; 002A8
        bra.b   l_166_002A0                     ; 002AC
l_166_002AE:
        move.w  $4(a1),-(a7)                    ; 002AE
        andi.w  #$2000,(a7)+                    ; 002B2
        bne.b   l_166_002C2                     ; 002B6
        movea.l $14(a0),a2                      ; 002B8
        clr.l   (a2)                            ; 002BC
        bra.w   l_166_00342                     ; 002BE
l_166_002C2:
        move.w  $0(a1),d2                       ; 002C2
        move.w  $4(a1),-(a7)                    ; 002C6
        andi.w  #$1000,(a7)+                    ; 002CA
        beq.b   l_166_002D2                     ; 002CE
        neg.w   d2                              ; 002D0
l_166_002D2:
        add.w   d2,$2(a1)                       ; 002D2
        move.l  d0,-(a7)                        ; 002D6
        or.l    d1,(a7)+                        ; 002D8
        beq.b   l_166_00330                     ; 002DA
        move.w  #$3f,$0(a1)                     ; 002DC
l_166_002E2:
        tst.l   d0                              ; 002E2
        bmi.b   l_166_002F0                     ; 002E4
        lsl.l   #$1,d1                          ; 002E6
        roxl.l  #$1,d0                          ; 002E8
        subq.w  #$1,$0(a1)                      ; 002EA
        bra.b   l_166_002E2                     ; 002EE
l_166_002F0:
        tst.w   $2(a1)                          ; 002F0
        beq.b   l_166_00316                     ; 002F4
        bmi.b   l_166_0030C                     ; 002F6
        moveq   #$4,d2                          ; 002F8
        add.w   d2,$0(a1)                       ; 002FA
        bsr.w   sub_166_0015A                   ; 002FE
        bsr.w   sub_166_00166                   ; 00302
        subq.w  #$1,$2(a1)                      ; 00306
        bra.b   l_166_002E2                     ; 0030A
l_166_0030C:
        bsr.w   sub_166_00192                   ; 0030C
        addq.w  #$1,$2(a1)                      ; 00310
        bra.b   l_166_002E2                     ; 00314
l_166_00316:
        moveq   #$0,d2                          ; 00316
        move.w  $0(a1),d2                       ; 00318
        move.w  $4(a1),-(a7)                    ; 0031C
        andi.w  #$8000,(a7)+                    ; 00320
        beq.b   l_166_0032A                     ; 00324
        bset    #$1f,d2                         ; 00326
l_166_0032A:
        jsr     (fp_DoublePack).l               ; 0032A
l_166_00330:
        movea.l $18(a0),a2                      ; 00330
        move.l  d0,(a2)+                        ; 00334
        move.l  d1,(a2)                         ; 00336
        movea.l $14(a0),a2                      ; 00338
        move.l  #$1,(a2)                        ; 0033C
l_166_00342:
        moveq   #$0,d0                          ; 00342
        move.w  $8(a1),d0                       ; 00344
        movem.l (a7)+,d1-d6/a2                  ; 00348
        unlk    a1                              ; 0034C
        unlk    a0                              ; 0034E
        rts                                     ; 00350
sub_166_00352:
        move.l  $8(a0),d6                       ; 00352
        beq.b   l_166_00362                     ; 00356
        move.l  #$0,$8(a0)                      ; 00358
        rts                                     ; 00360
l_166_00362:
        movem.l d0-d5/a0-a2,-(a7)               ; 00362
        movea.l $10(a0),a2                      ; 00366
        jsr     (a2)                            ; 0036A
        move.w  d0,d6                           ; 0036C
        movem.l (a7)+,d0-d5/a0-a2               ; 0036E
        move.w  d6,$8(a1)                       ; 00372
        subq.l  #$1,$c(a0)                      ; 00376
        bne.b   l_166_00384                     ; 0037A
        ori.w   #$800,$4(a1)                    ; 0037C
        rts                                     ; 00382
l_166_00384:
        move.w  $4(a1),-(a7)                    ; 00384
        andi.w  #$800,(a7)+                     ; 00388
        beq.b   l_166_00390                     ; 0038C
        moveq   #-1,d6                          ; 0038E
l_166_00390:
        rts                                     ; 00390
	dc.b	$00,$00
h166_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    2,159                           ; 2 longs pointing into hunk 159
	dc.l	$16,$32C
	dc.l	0
	dc.l	HUNK_END
	endc
