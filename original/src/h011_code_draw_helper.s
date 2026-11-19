; F/A-18 Interceptor - hunk 11 (code)
; A routine used by hunk 10's object drawing (not worked out yet)
; Included by ../f18_main.s.

;===============================================================================
; Hunk 11: CODE, $120 bytes
;===============================================================================
	CODE_HUNK	h011
l_011_00000:
        jmp     (l_010_009C0).l                 ; 00000
l_011_00006:
        move.w  (a1)+,-$30(a6)                  ; 00006
        blt.b   l_011_00000                     ; 0000A
        move.w  d3,-(a7)                        ; 0000C
        move.w  d6,-(a7)                        ; 0000E
        movem.w -$c(a3),d2-d7                   ; 00010
        sub.w   d2,d5                           ; 00016
        sub.w   d3,d6                           ; 00018
        sub.w   d4,d7                           ; 0001A
        movem.w d5-d7,-$58(a6)                  ; 0001C
        move.w  (a7)+,d6                        ; 00022
        move.w  (a7)+,d3                        ; 00024
l_011_00026:
        move.w  (a1)+,d2                        ; 00026
        move.w  (a1)+,d4                        ; 00028
        move.w  -$8(a6),d7                      ; 0002A
        beq.b   l_011_00034                     ; 0002E
        asr.w   d7,d2                           ; 00030
        asr.w   d7,d4                           ; 00032
l_011_00034:
        add.w   d0,d2                           ; 00034
        add.w   d1,d4                           ; 00036
        lea.l   (a4),a2                         ; 00038
        move.w  d2,d5                           ; 0003A
        move.w  d4,d7                           ; 0003C
        muls.w  (a2)+,d5                        ; 0003E
        addq.w  #$2,a2                          ; 00040
        muls.w  (a2)+,d7                        ; 00042
        add.l   d5,d7                           ; 00044
        asr.l   #$8,d7                          ; 00046
        add.w   d3,d7                           ; 00048
        move.w  d7,(a3)+                        ; 0004A
        move.w  d2,d5                           ; 0004C
        move.w  d4,d7                           ; 0004E
        muls.w  (a2)+,d5                        ; 00050
        addq.w  #$2,a2                          ; 00052
        muls.w  (a2)+,d7                        ; 00054
        add.l   d5,d7                           ; 00056
        asr.l   #$8,d7                          ; 00058
        add.w   d6,d7                           ; 0005A
        move.w  d7,(a3)+                        ; 0005C
        muls.w  (a2)+,d2                        ; 0005E
        muls.w  $2(a2),d4                       ; 00060
        add.l   d2,d4                           ; 00064
        asr.l   #$8,d4                          ; 00066
        add.w   a5,d4                           ; 00068
        move.w  d4,(a3)+                        ; 0006A
        move.w  -$6(a3),d2                      ; 0006C
        exg.l   d7,d4                           ; 00070
        add.w   -$58(a6),d2                     ; 00072
        add.w   -$56(a6),d4                     ; 00076
        add.w   -$54(a6),d7                     ; 0007A
        movem.w d2/d4/d7,(a3)                   ; 0007E
        addq.w  #$6,a3                          ; 00082
        subq.w  #$1,-$30(a6)                    ; 00084
        bgt.b   l_011_00026                     ; 00088
        tst.w   (a1)+                           ; 0008A
        blt.w   l_011_00000                     ; 0008C
        move.w  (a1)+,d2                        ; 00090
        move.w  (a1)+,d4                        ; 00092
        move.w  -$8(a6),d7                      ; 00094
        beq.b   l_011_0009E                     ; 00098
        asr.w   d7,d2                           ; 0009A
        asr.w   d7,d4                           ; 0009C
l_011_0009E:
        add.w   d0,d2                           ; 0009E
        add.w   d1,d4                           ; 000A0
        lea.l   (a4),a2                         ; 000A2
        move.w  d2,d5                           ; 000A4
        move.w  d4,d7                           ; 000A6
        muls.w  (a2)+,d5                        ; 000A8
        addq.w  #$2,a2                          ; 000AA
        muls.w  (a2)+,d7                        ; 000AC
        add.l   d5,d7                           ; 000AE
        asr.l   #$8,d7                          ; 000B0
        add.w   d3,d7                           ; 000B2
        move.w  d7,(a3)+                        ; 000B4
        move.w  d2,d5                           ; 000B6
        move.w  d4,d7                           ; 000B8
        muls.w  (a2)+,d5                        ; 000BA
        addq.w  #$2,a2                          ; 000BC
        muls.w  (a2)+,d7                        ; 000BE
        add.l   d5,d7                           ; 000C0
        asr.l   #$8,d7                          ; 000C2
        add.w   d6,d7                           ; 000C4
        move.w  d7,(a3)+                        ; 000C6
        muls.w  (a2)+,d2                        ; 000C8
        muls.w  $2(a2),d4                       ; 000CA
        add.l   d2,d4                           ; 000CE
        asr.l   #$8,d4                          ; 000D0
        add.w   a5,d4                           ; 000D2
        move.w  d4,(a3)+                        ; 000D4
        move.w  (a1)+,d2                        ; 000D6
        move.w  (a1)+,d4                        ; 000D8
        move.w  -$8(a6),d7                      ; 000DA
        beq.b   l_011_000E4                     ; 000DE
        asr.w   d7,d2                           ; 000E0
        asr.w   d7,d4                           ; 000E2
l_011_000E4:
        add.w   d0,d2                           ; 000E4
        add.w   d1,d4                           ; 000E6
        lea.l   (a4),a2                         ; 000E8
        move.w  d2,d5                           ; 000EA
        move.w  d4,d7                           ; 000EC
        muls.w  (a2)+,d5                        ; 000EE
        addq.w  #$2,a2                          ; 000F0
        muls.w  (a2)+,d7                        ; 000F2
        add.l   d5,d7                           ; 000F4
        asr.l   #$8,d7                          ; 000F6
        add.w   d3,d7                           ; 000F8
        move.w  d7,(a3)+                        ; 000FA
        move.w  d2,d5                           ; 000FC
        move.w  d4,d7                           ; 000FE
        muls.w  (a2)+,d5                        ; 00100
        addq.w  #$2,a2                          ; 00102
        muls.w  (a2)+,d7                        ; 00104
        add.l   d5,d7                           ; 00106
        asr.l   #$8,d7                          ; 00108
        add.w   d6,d7                           ; 0010A
        move.w  d7,(a3)+                        ; 0010C
        muls.w  (a2)+,d2                        ; 0010E
        muls.w  $2(a2),d4                       ; 00110
        add.l   d2,d4                           ; 00114
        asr.l   #$8,d4                          ; 00116
        add.w   a5,d4                           ; 00118
        move.w  d4,(a3)+                        ; 0011A
        bra.w   l_011_00006                     ; 0011C
h011_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    1,10                            ; 1 longs pointing into hunk 10
	dc.l	$2
	dc.l	0
	dc.l	HUNK_END
	endc
