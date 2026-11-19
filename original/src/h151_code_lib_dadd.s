; F/A-18 Interceptor - hunk 151 (code)
; C library: double add / subtract.
; Included by ../f18_main.s.

;===============================================================================
; Hunk 151: CODE, $C0 bytes
;===============================================================================
	CODE_HUNK	h151

;-------------------------------------------------------------------------------
; fp_DoubleSub - Double d0:d1 - d2:d3 (negates and falls into fp_DoubleAdd).
;-------------------------------------------------------------------------------
fp_DoubleSub:
        movem.l d2-d7,-(a7)                     ; 00000
        clr.l   d7                              ; 00004
        bra.b   l_151_00012                     ; 00006

;-------------------------------------------------------------------------------
; fp_DoubleAdd - Double d0:d1 + d2:d3.
;-------------------------------------------------------------------------------
fp_DoubleAdd:
        movem.l d2-d7,-(a7)                     ; 00008
        move.l  #$80000000,d7                   ; 0000C
l_151_00012:
        move.l  d2,d4                           ; 00012
        bclr    #$1f,d4                         ; 00014
        move.l  d4,-(a7)                        ; 00018
        or.l    d3,(a7)+                        ; 0001A
        beq.w   l_151_000BA                     ; 0001C
        move.l  d0,d4                           ; 00020
        bclr    #$1f,d4                         ; 00022
        move.l  d4,-(a7)                        ; 00026
        or.l    d1,(a7)+                        ; 00028
        bne.b   l_151_00036                     ; 0002A
        move.l  d2,d0                           ; 0002C
        move.l  d3,d1                           ; 0002E
        eor.l   d7,d0                           ; 00030
        bra.w   l_151_000BA                     ; 00032
l_151_00036:
        move.l  d2,-(a7)                        ; 00036
        jsr     (fp_DoubleUnpack).l             ; 00038
        move.l  d0,d4                           ; 0003E
        move.l  d1,d5                           ; 00040
        move.l  d2,d6                           ; 00042
        move.l  (a7)+,d0                        ; 00044
        move.l  d3,d1                           ; 00046
        jsr     (fp_DoubleUnpack).l             ; 00048
        move.l  d6,d3                           ; 0004E
        move.w  d2,d3                           ; 00050
        sub.w   d6,d3                           ; 00052
        bge.b   l_151_00074                     ; 00054
        neg.w   d3                              ; 00056
        cmpi.w  #$40,d3                         ; 00058
        blt.b   l_151_00066                     ; 0005C
        move.l  d4,d0                           ; 0005E
        move.l  d5,d1                           ; 00060
        move.l  d6,d2                           ; 00062
        bra.b   l_151_000B4                     ; 00064
l_151_00066:
        subq.w  #$1,d3                          ; 00066
l_151_00068:
        lsr.l   #$1,d0                          ; 00068
        roxr.l  #$1,d1                          ; 0006A
        dbra    d3,l_151_00068                  ; 0006C
        move.w  d6,d3                           ; 00070
        bra.b   l_151_0008C                     ; 00072
l_151_00074:
        beq.b   l_151_0008A                     ; 00074
        cmpi.w  #$40,d3                         ; 00076
        blt.b   l_151_00080                     ; 0007A
        eor.l   d7,d2                           ; 0007C
        bra.b   l_151_000B4                     ; 0007E
l_151_00080:
        subq.w  #$1,d3                          ; 00080
l_151_00082:
        lsr.l   #$1,d4                          ; 00082
        roxr.l  #$1,d5                          ; 00084
        dbra    d3,l_151_00082                  ; 00086
l_151_0008A:
        move.w  d2,d3                           ; 0008A
l_151_0008C:
        eor.l   d2,d6                           ; 0008C
        eor.l   d7,d6                           ; 0008E
        bmi.b   l_151_000A0                     ; 00090
        add.l   d5,d1                           ; 00092
        addx.l  d4,d0                           ; 00094
        bcc.b   l_151_000B2                     ; 00096
        roxr.l  #$1,d0                          ; 00098
        roxr.l  #$1,d1                          ; 0009A
        addq.w  #$1,d3                          ; 0009C
        bra.b   l_151_000B2                     ; 0009E
l_151_000A0:
        sub.l   d1,d5                           ; 000A0
        subx.l  d0,d4                           ; 000A2
        bcc.b   l_151_000AE                     ; 000A4
        bchg    #$1f,d3                         ; 000A6
        neg.l   d5                              ; 000AA
        negx.l  d4                              ; 000AC
l_151_000AE:
        move.l  d4,d0                           ; 000AE
        move.l  d5,d1                           ; 000B0
l_151_000B2:
        move.l  d3,d2                           ; 000B2
l_151_000B4:
        jsr     (fp_DoublePack).l               ; 000B4
l_151_000BA:
        movem.l (a7)+,d2-d7                     ; 000BA
        rts                                     ; 000BE
h151_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    3,159                           ; 3 longs pointing into hunk 159
	dc.l	$3A,$4A,$B6
	dc.l	0
	dc.l	HUNK_END
	endc
