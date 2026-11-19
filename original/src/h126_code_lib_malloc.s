; F/A-18 Interceptor - hunk 126 (code)
; C library: malloc, free.
; Included by ../f18_main.s.

;===============================================================================
; Hunk 126: CODE, $284 bytes
;===============================================================================
	CODE_HUNK	h126
sub_126_00000:
        link.w  a6,#$fffc                       ; 00000
        move.l  (dat_148_0000C).l,d0            ; 00004
        asl.l   #$3,d0                          ; 0000A
        unlk    a6                              ; 0000C
        rts                                     ; 0000E
malloc:
        link.w  a6,#$fffc                       ; 00010
        move.l  $8(a6),d0                       ; 00014
        move.l  d0,-(a7)                        ; 00018
        move.l  d0,-$4(a6)                      ; 0001A
        bsr.b   _malloc                         ; 0001E
        addq.l  #$4,a7                          ; 00020
        unlk    a6                              ; 00022
        rts                                     ; 00024

;-------------------------------------------------------------------------------
; _malloc - The allocator: first fit from the free list (8-byte units); grows the heap by
; _MSTEP with AllocMemTracked when nothing fits.
;-------------------------------------------------------------------------------
_malloc:
        link.w  a6,#$ffec                       ; 00026
        tst.l   $8(a6)                          ; 0002A
        bgt.b   l_126_00036                     ; 0002E
        moveq   #$0,d0                          ; 00030
        unlk    a6                              ; 00032
        rts                                     ; 00034
l_126_00036:
        move.l  $8(a6),d0                       ; 00036
        addq.l  #$7,d0                          ; 0003A
        moveq   #$8,d1                          ; 0003C
        jsr     (CXD33).l                       ; 0003E
        move.l  #dat_148_00008,-$8(a6)          ; 00044
        movea.l -$8(a6),a0                      ; 0004C
        move.l  (a0),-$4(a6)                    ; 00050
        move.l  d0,-$10(a6)                     ; 00054
l_126_00058:
        tst.l   -$4(a6)                         ; 00058
        beq.b   l_126_000B4                     ; 0005C
        move.l  -$10(a6),d0                     ; 0005E
        movea.l -$4(a6),a0                      ; 00062
        move.l  $4(a0),d1                       ; 00066
        cmp.l   d0,d1                           ; 0006A
        bcs.b   l_126_000A4                     ; 0006C
        cmp.l   d0,d1                           ; 0006E
        bne.b   l_126_0007A                     ; 00070
        movea.l -$8(a6),a1                      ; 00072
        move.l  (a0),(a1)                       ; 00076
        bra.b   l_126_00090                     ; 00078
l_126_0007A:
        movea.l -$4(a6),a0                      ; 0007A
        move.l  $4(a0),d0                       ; 0007E
        sub.l   -$10(a6),d0                     ; 00082
        move.l  d0,$4(a0)                       ; 00086
        asl.l   #$3,d0                          ; 0008A
        add.l   d0,-$4(a6)                      ; 0008C
l_126_00090:
        move.l  -$10(a6),d0                     ; 00090
        sub.l   d0,(dat_148_0000C).l            ; 00094
        movea.l -$4(a6),a0                      ; 0009A
        move.l  a0,d0                           ; 0009E
        unlk    a6                              ; 000A0
        rts                                     ; 000A2
l_126_000A4:
        move.l  -$4(a6),-$8(a6)                 ; 000A4
        movea.l -$4(a6),a0                      ; 000AA
        move.l  (a0),-$4(a6)                    ; 000AE
        bra.b   l_126_00058                     ; 000B2
l_126_000B4:
        move.l  -$10(a6),d0                     ; 000B4
        asl.l   #$3,d0                          ; 000B8
        move.l  (_MSTEP).l,d1                   ; 000BA
        add.l   d1,d0                           ; 000C0
        subq.l  #$1,d0                          ; 000C2
        jsr     (CXD33).l                       ; 000C4
        move.l  (_MSTEP).l,d1                   ; 000CA
        jsr     (CXM33).l                       ; 000D0
        move.l  d0,-(a7)                        ; 000D6
        move.l  d0,-$14(a6)                     ; 000D8
        jsr     (AllocMemTracked).l             ; 000DC
        addq.l  #$4,a7                          ; 000E2
        move.l  d0,-$c(a6)                      ; 000E4
        tst.l   d0                              ; 000E8
        beq.b   l_126_00104                     ; 000EA
        move.l  -$14(a6),-(a7)                  ; 000EC
        move.l  d0,-(a7)                        ; 000F0
        bsr.b   free                            ; 000F2
        addq.l  #$8,a7                          ; 000F4
        move.l  $8(a6),-(a7)                    ; 000F6
        bsr.w   _malloc                         ; 000FA
        addq.l  #$4,a7                          ; 000FE
        unlk    a6                              ; 00100
        rts                                     ; 00102
l_126_00104:
        moveq   #$0,d0                          ; 00104
        unlk    a6                              ; 00106
        rts                                     ; 00108

;-------------------------------------------------------------------------------
; free - free(block, size).
;-------------------------------------------------------------------------------
free:
        link.w  a6,#$fffc                       ; 0010A
        move.l  $c(a6),d0                       ; 0010E
        move.l  d0,-(a7)                        ; 00112
        move.l  $8(a6),-(a7)                    ; 00114
        move.l  d0,-$4(a6)                      ; 00118
        bsr.b   _free                           ; 0011C
        addq.l  #$8,a7                          ; 0011E
        unlk    a6                              ; 00120
        rts                                     ; 00122

;-------------------------------------------------------------------------------
; _free - Puts a block back on the free list, merging it with its neighbours.
;-------------------------------------------------------------------------------
_free:
        link.w  a6,#$ffe4                       ; 00124
        tst.l   $c(a6)                          ; 00128
        bgt.b   l_126_00134                     ; 0012C
        moveq   #-1,d0                          ; 0012E
        unlk    a6                              ; 00130
        rts                                     ; 00132
l_126_00134:
        movea.l $8(a6),a0                       ; 00134
        exg.l   d0,a0                           ; 00138
        andi.w  #$fffe,d0                       ; 0013A
        exg.l   d0,a0                           ; 0013E
        move.l  $c(a6),d0                       ; 00140
        addq.l  #$7,d0                          ; 00144
        moveq   #$8,d1                          ; 00146
        jsr     (CXD33).l                       ; 00148
        move.l  d0,-$1c(a6)                     ; 0014E
        asl.l   #$3,d0                          ; 00152
        move.l  a0,-$14(a6)                     ; 00154
        adda.l  d0,a0                           ; 00158
        move.l  -$1c(a6),d0                     ; 0015A
        add.l   d0,(dat_148_0000C).l            ; 0015E
        move.l  #dat_148_00008,-$c(a6)          ; 00164
        movea.l -$c(a6),a1                      ; 0016C
        move.l  (a1),-$4(a6)                    ; 00170
        move.l  a0,-$18(a6)                     ; 00174
l_126_00178:
        tst.l   -$4(a6)                         ; 00178
        beq.w   l_126_00266                     ; 0017C
        movea.l -$4(a6),a0                      ; 00180
        move.l  $4(a0),d0                       ; 00184
        asl.l   #$3,d0                          ; 00188
        adda.l  d0,a0                           ; 0018A
        move.l  a0,-$8(a6)                      ; 0018C
        movea.l -$4(a6),a0                      ; 00190
        cmpa.l  -$18(a6),a0                     ; 00194
        bls.b   l_126_001B2                     ; 00198
        movea.l -$14(a6),a1                     ; 0019A
        move.l  a0,(a1)                         ; 0019E
        move.l  -$1c(a6),$4(a1)                 ; 001A0
        movea.l -$c(a6),a0                      ; 001A6
        move.l  a1,(a0)                         ; 001AA
        moveq   #$0,d0                          ; 001AC
        unlk    a6                              ; 001AE
        rts                                     ; 001B0
l_126_001B2:
        movea.l -$4(a6),a0                      ; 001B2
        cmpa.l  -$18(a6),a0                     ; 001B6
        bne.b   l_126_001DA                     ; 001BA
        movea.l -$14(a6),a1                     ; 001BC
        move.l  (a0),(a1)                       ; 001C0
        move.l  -$1c(a6),d0                     ; 001C2
        add.l   $4(a0),d0                       ; 001C6
        move.l  d0,$4(a1)                       ; 001CA
        movea.l -$c(a6),a0                      ; 001CE
        move.l  a1,(a0)                         ; 001D2
        moveq   #$0,d0                          ; 001D4
        unlk    a6                              ; 001D6
        rts                                     ; 001D8
l_126_001DA:
        movea.l -$14(a6),a0                     ; 001DA
        cmpa.l  -$8(a6),a0                      ; 001DE
        bcc.b   l_126_001F4                     ; 001E2
        move.l  -$1c(a6),d0                     ; 001E4
        sub.l   d0,(dat_148_0000C).l            ; 001E8
        moveq   #-1,d0                          ; 001EE
        unlk    a6                              ; 001F0
        rts                                     ; 001F2
l_126_001F4:
        movea.l -$14(a6),a0                     ; 001F4
        cmpa.l  -$8(a6),a0                      ; 001F8
        bne.b   l_126_0024E                     ; 001FC
        movea.l -$4(a6),a0                      ; 001FE
        tst.l   (a0)                            ; 00202
        beq.b   l_126_00222                     ; 00204
        movea.l -$18(a6),a0                     ; 00206
        movea.l -$4(a6),a1                      ; 0020A
        cmpa.l  (a1),a0                         ; 0020E
        bls.b   l_126_00222                     ; 00210
        move.l  -$1c(a6),d0                     ; 00212
        sub.l   d0,(dat_148_0000C).l            ; 00216
        moveq   #-1,d0                          ; 0021C
        unlk    a6                              ; 0021E
        rts                                     ; 00220
l_126_00222:
        move.l  -$1c(a6),d0                     ; 00222
        movea.l -$4(a6),a0                      ; 00226
        add.l   d0,$4(a0)                       ; 0022A
        tst.l   (a0)                            ; 0022E
        beq.b   l_126_00248                     ; 00230
        movea.l -$18(a6),a0                     ; 00232
        movea.l -$4(a6),a1                      ; 00236
        cmpa.l  (a1),a0                         ; 0023A
        bne.b   l_126_00248                     ; 0023C
        move.l  $4(a0),d0                       ; 0023E
        add.l   d0,$4(a1)                       ; 00242
        move.l  (a0),(a1)                       ; 00246
l_126_00248:
        moveq   #$0,d0                          ; 00248
        unlk    a6                              ; 0024A
        rts                                     ; 0024C
l_126_0024E:
        move.l  -$4(a6),-$c(a6)                 ; 0024E
        move.l  -$8(a6),-$10(a6)                ; 00254
        movea.l -$4(a6),a0                      ; 0025A
        move.l  (a0),-$4(a6)                    ; 0025E
        bra.w   l_126_00178                     ; 00262
l_126_00266:
        movea.l -$c(a6),a0                      ; 00266
        move.l  -$14(a6),(a0)                   ; 0026A
        suba.l  a0,a0                           ; 0026E
        movea.l -$14(a6),a1                     ; 00270
        move.l  a0,(a1)                         ; 00274
        move.l  -$1c(a6),$4(a1)                 ; 00276
        move.l  a0,d0                           ; 0027C
        unlk    a6                              ; 0027E
        rts                                     ; 00280
	dc.b	$00,$00
h126_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    7,148                           ; 7 longs pointing into hunk 148
	dc.l	$6,$46,$96,$160,$166,$1EA,$218
        dc.l    3,152                           ; 3 longs pointing into hunk 152
	dc.l	$40,$C6,$14A
        dc.l    2,1                             ; 2 longs pointing into hunk 1
	dc.l	$BC,$CC
        dc.l    1,154                           ; 1 longs pointing into hunk 154
	dc.l	$D2
        dc.l    1,123                           ; 1 longs pointing into hunk 123
	dc.l	$DE
	dc.l	0
	dc.l	HUNK_END
	endc
