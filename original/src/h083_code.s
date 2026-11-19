; F/A-18 Interceptor - hunk 83 (code)
; Included by ../f18_main.s.

;===============================================================================
; Hunk 83: CODE, $2DC bytes
;===============================================================================
	CODE_HUNK	h083
sub_083_00000:
        link.w  a6,#$fff0                       ; 00000
        clr.l   -$8(a6)                         ; 00004
        clr.l   -$4(a6)                         ; 00008
l_083_0000C:
        move.l  $c(a6),d0                       ; 0000C
        moveq   #$4,d1                          ; 00010
        jsr     (CXD33).l                       ; 00012
        move.l  -$4(a6),d1                      ; 00018
        cmp.l   d0,d1                           ; 0001C
        bge.b   l_083_0009C                     ; 0001E
        move.l  -$8(a6),d0                      ; 00020
        jsr     (fp_SingleToLong).l             ; 00024
        movea.l $8(a6),a0                       ; 0002A
        move.b  d0,(a0)                         ; 0002E
        addq.l  #$1,$8(a6)                      ; 00030
        move.l  $c(a6),d0                       ; 00034
        moveq   #$4,d1                          ; 00038
        jsr     (CXD33).l                       ; 0003A
        jsr     (fp_LongToSingle).l             ; 00040
        jsr     (fp_SingleToDouble).l           ; 00046
        move.l  d0,$0(a7)                       ; 0004C
        move.l  #$405f8000,d0                   ; 00050
        move.l  d1,$4(a7)                       ; 00056
        moveq   #$0,d1                          ; 0005A
        move.l  $0(a7),d2                       ; 0005C
        move.l  $4(a7),d3                       ; 00060
        jsr     (fp_DoubleDiv).l                ; 00064
        move.l  d0,$0(a7)                       ; 0006A
        move.l  -$8(a6),d0                      ; 0006E
        move.l  d1,$4(a7)                       ; 00072
        jsr     (fp_SingleToDouble).l           ; 00076
        move.l  $0(a7),d2                       ; 0007C
        move.l  $4(a7),d3                       ; 00080
        jsr     (fp_DoubleSub).l                ; 00084
        jsr     (fp_DoubleToSingle).l           ; 0008A
        move.l  d0,-$8(a6)                      ; 00090
        addq.l  #$1,-$4(a6)                     ; 00094
        bra.w   l_083_0000C                     ; 00098
l_083_0009C:
        clr.l   -$4(a6)                         ; 0009C
l_083_000A0:
        move.l  $c(a6),d0                       ; 000A0
        moveq   #$2,d1                          ; 000A4
        jsr     (CXD33).l                       ; 000A6
        move.l  -$4(a6),d1                      ; 000AC
        cmp.l   d0,d1                           ; 000B0
        bge.b   l_083_00130                     ; 000B2
        move.l  -$8(a6),d0                      ; 000B4
        jsr     (fp_SingleToLong).l             ; 000B8
        movea.l $8(a6),a0                       ; 000BE
        move.b  d0,(a0)                         ; 000C2
        addq.l  #$1,$8(a6)                      ; 000C4
        move.l  $c(a6),d0                       ; 000C8
        moveq   #$4,d1                          ; 000CC
        jsr     (CXD33).l                       ; 000CE
        jsr     (fp_LongToSingle).l             ; 000D4
        jsr     (fp_SingleToDouble).l           ; 000DA
        move.l  d0,$0(a7)                       ; 000E0
        move.l  #$405f8000,d0                   ; 000E4
        move.l  d1,$4(a7)                       ; 000EA
        moveq   #$0,d1                          ; 000EE
        move.l  $0(a7),d2                       ; 000F0
        move.l  $4(a7),d3                       ; 000F4
        jsr     (fp_DoubleDiv).l                ; 000F8
        move.l  d0,$0(a7)                       ; 000FE
        move.l  -$8(a6),d0                      ; 00102
        move.l  d1,$4(a7)                       ; 00106
        jsr     (fp_SingleToDouble).l           ; 0010A
        move.l  $0(a7),d2                       ; 00110
        move.l  $4(a7),d3                       ; 00114
        jsr     (fp_DoubleAdd).l                ; 00118
        jsr     (fp_DoubleToSingle).l           ; 0011E
        move.l  d0,-$8(a6)                      ; 00124
        addq.l  #$1,-$4(a6)                     ; 00128
        bra.w   l_083_000A0                     ; 0012C
l_083_00130:
        clr.l   -$4(a6)                         ; 00130
l_083_00134:
        move.l  $c(a6),d0                       ; 00134
        moveq   #$4,d1                          ; 00138
        jsr     (CXD33).l                       ; 0013A
        move.l  -$4(a6),d1                      ; 00140
        cmp.l   d0,d1                           ; 00144
        bge.b   l_083_001C4                     ; 00146
        move.l  -$8(a6),d0                      ; 00148
        jsr     (fp_SingleToLong).l             ; 0014C
        movea.l $8(a6),a0                       ; 00152
        move.b  d0,(a0)                         ; 00156
        addq.l  #$1,$8(a6)                      ; 00158
        move.l  $c(a6),d0                       ; 0015C
        moveq   #$4,d1                          ; 00160
        jsr     (CXD33).l                       ; 00162
        jsr     (fp_LongToSingle).l             ; 00168
        jsr     (fp_SingleToDouble).l           ; 0016E
        move.l  d0,$0(a7)                       ; 00174
        move.l  #$405f8000,d0                   ; 00178
        move.l  d1,$4(a7)                       ; 0017E
        moveq   #$0,d1                          ; 00182
        move.l  $0(a7),d2                       ; 00184
        move.l  $4(a7),d3                       ; 00188
        jsr     (fp_DoubleDiv).l                ; 0018C
        move.l  d0,$0(a7)                       ; 00192
        move.l  -$8(a6),d0                      ; 00196
        move.l  d1,$4(a7)                       ; 0019A
        jsr     (fp_SingleToDouble).l           ; 0019E
        move.l  $0(a7),d2                       ; 001A4
        move.l  $4(a7),d3                       ; 001A8
        jsr     (fp_DoubleSub).l                ; 001AC
        jsr     (fp_DoubleToSingle).l           ; 001B2
        move.l  d0,-$8(a6)                      ; 001B8
        addq.l  #$1,-$4(a6)                     ; 001BC
        bra.w   l_083_00134                     ; 001C0
l_083_001C4:
        unlk    a6                              ; 001C4
        rts                                     ; 001C6
sub_083_001C8:
        link.w  a6,#$fffc                       ; 001C8
        clr.l   -$4(a6)                         ; 001CC
l_083_001D0:
        move.l  $c(a6),d0                       ; 001D0
        moveq   #$2,d1                          ; 001D4
        jsr     (CXD33).l                       ; 001D6
        move.l  -$4(a6),d1                      ; 001DC
        cmp.l   d0,d1                           ; 001E0
        bge.b   l_083_001F6                     ; 001E2
        movea.l $8(a6),a0                       ; 001E4
        move.b  #$7f,(a0)                       ; 001E8
        addq.l  #$1,$8(a6)                      ; 001EC
        addq.l  #$1,-$4(a6)                     ; 001F0
        bra.b   l_083_001D0                     ; 001F4
l_083_001F6:
        clr.l   -$4(a6)                         ; 001F6
l_083_001FA:
        move.l  $c(a6),d0                       ; 001FA
        moveq   #$2,d1                          ; 001FE
        jsr     (CXD33).l                       ; 00200
        move.l  -$4(a6),d1                      ; 00206
        cmp.l   d0,d1                           ; 0020A
        bge.b   l_083_00220                     ; 0020C
        movea.l $8(a6),a0                       ; 0020E
        move.b  #$82,(a0)                       ; 00212
        addq.l  #$1,$8(a6)                      ; 00216
        addq.l  #$1,-$4(a6)                     ; 0021A
        bra.b   l_083_001FA                     ; 0021E
l_083_00220:
        unlk    a6                              ; 00220
        rts                                     ; 00222
sub_083_00224:
        link.w  a6,#$fffc                       ; 00224
        move.l  (dat_084_00000).l,d0            ; 00228
        andi.l  #$1,d0                          ; 0022E
        move.l  (dat_084_00000).l,d1            ; 00234
        asr.l   #$3,d1                          ; 0023A
        andi.l  #$1,d1                          ; 0023C
        eor.l   d1,d0                           ; 00242
        move.l  (dat_084_00000).l,d1            ; 00244
        asr.l   #$1,d1                          ; 0024A
        andi.l  #$7fffffff,d1                   ; 0024C
        move.l  d1,(dat_084_00000).l            ; 00252
        move.l  d0,-$4(a6)                      ; 00258
        tst.l   d0                              ; 0025C
        beq.b   l_083_0026A                     ; 0025E
        subi.l  #$80000000,(dat_084_00000).l    ; 00260
l_083_0026A:
        move.l  -$4(a6),d0                      ; 0026A
        unlk    a6                              ; 0026E
        rts                                     ; 00270
sub_083_00272:
        link.w  a6,#$fff8                       ; 00272
        clr.l   -$4(a6)                         ; 00276
l_083_0027A:
        move.l  $8(a6),d0                       ; 0027A
        subq.l  #$1,$8(a6)                      ; 0027E
        tst.l   d0                              ; 00282
        ble.b   l_083_0029E                     ; 00284
        move.l  -$4(a6),d0                      ; 00286
        asl.l   #$1,d0                          ; 0028A
        move.l  d0,$0(a7)                       ; 0028C
        bsr.b   sub_083_00224                   ; 00290
        move.l  $0(a7),d1                       ; 00292
        add.l   d0,d1                           ; 00296
        move.l  d1,-$4(a6)                      ; 00298
        bra.b   l_083_0027A                     ; 0029C
l_083_0029E:
        move.l  -$4(a6),d0                      ; 0029E
        unlk    a6                              ; 002A2
        rts                                     ; 002A4
sub_083_002A6:
        link.w  a6,#$fff8                       ; 002A6
        clr.l   -$4(a6)                         ; 002AA
l_083_002AE:
        move.l  -$4(a6),d0                      ; 002AE
        cmp.l   $c(a6),d0                       ; 002B2
        bge.b   l_083_002D8                     ; 002B6
        movea.l $8(a6),a0                       ; 002B8
        addq.l  #$1,$8(a6)                      ; 002BC
        moveq   #$8,d0                          ; 002C0
        move.l  d0,-(a7)                        ; 002C2
        move.l  a0,$4(a7)                       ; 002C4
        bsr.b   sub_083_00272                   ; 002C8
        addq.l  #$4,a7                          ; 002CA
        movea.l $0(a7),a0                       ; 002CC
        move.b  d0,(a0)                         ; 002D0
        addq.l  #$1,-$4(a6)                     ; 002D2
        bra.b   l_083_002AE                     ; 002D6
l_083_002D8:
        unlk    a6                              ; 002D8
        rts                                     ; 002DA
h083_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    5,84                            ; 5 longs pointing into hunk 84
	dc.l	$266,$254,$246,$236,$22A
        dc.l    8,152                           ; 8 longs pointing into hunk 152
	dc.l	$14,$3C,$A8,$D0,$13C,$164,$1D8,$202
        dc.l    3,162                           ; 3 longs pointing into hunk 162
	dc.l	$26,$BA,$14E
        dc.l    3,160                           ; 3 longs pointing into hunk 160
	dc.l	$42,$D6,$16A
        dc.l    6,164                           ; 6 longs pointing into hunk 164
	dc.l	$48,$78,$DC,$10C,$170,$1A0
        dc.l    3,153                           ; 3 longs pointing into hunk 153
	dc.l	$66,$FA,$18E
        dc.l    3,151                           ; 3 longs pointing into hunk 151
	dc.l	$86,$1AE,$11A
        dc.l    3,165                           ; 3 longs pointing into hunk 165
	dc.l	$8C,$120,$1B4
	dc.l	0
	dc.l	HUNK_END
	endc
