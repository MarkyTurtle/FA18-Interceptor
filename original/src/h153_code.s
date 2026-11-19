; F/A-18 Interceptor - hunk 153 (code)
; Included by ../f18_main.s.

;===============================================================================
; Hunk 153: CODE, $A0 bytes
;===============================================================================
	CODE_HUNK	h153

;-------------------------------------------------------------------------------
; fp_DoubleDiv - Double d0:d1 / d2:d3 (SetFPErr 3 on divide by zero).
;-------------------------------------------------------------------------------
fp_DoubleDiv:
        movem.l d2-d7,-(a7)                     ; 00000
        move.l  d2,-(a7)                        ; 00004
        andi.w  #$7fff,(a7)                     ; 00006
        or.l    d3,(a7)+                        ; 0000A
        bne.b   l_153_00024                     ; 0000C
        move.l  #$3,-(a7)                       ; 0000E
        jsr     (SetFPErr).l                    ; 00014
        lea.l   $4(a7),a7                       ; 0001A
        clr.l   d0                              ; 0001E
        clr.l   d1                              ; 00020
        bra.b   l_153_00068                     ; 00022
l_153_00024:
        move.l  d0,-(a7)                        ; 00024
        andi.w  #$7fff,(a7)                     ; 00026
        or.l    d1,(a7)+                        ; 0002A
        beq.b   l_153_00068                     ; 0002C
        move.l  d2,-(a7)                        ; 0002E
        jsr     (fp_DoubleUnpack).l             ; 00030
        move.l  d0,d4                           ; 00036
        move.l  d1,d5                           ; 00038
        move.l  d2,d6                           ; 0003A
        move.l  (a7)+,d0                        ; 0003C
        move.l  d3,d1                           ; 0003E
        jsr     (fp_DoubleUnpack).l             ; 00040
        exg.l   d2,d6                           ; 00046
        sub.w   d6,d2                           ; 00048
        swap    d6                              ; 0004A
        swap    d2                              ; 0004C
        eor.w   d6,d2                           ; 0004E
        swap    d2                              ; 00050
        move.l  d0,d6                           ; 00052
        move.l  d1,d7                           ; 00054
        clr.l   d0                              ; 00056
        clr.l   d1                              ; 00058
        clr.l   d3                              ; 0005A
        bsr.b   sub_153_0006E                   ; 0005C
        move.l  d1,d0                           ; 0005E
        bsr.b   sub_153_0006E                   ; 00060
        jsr     (fp_DoublePack).l               ; 00062
l_153_00068:
        movem.l (a7)+,d2-d7                     ; 00068
        rts                                     ; 0006C
sub_153_0006E:
        move.w  #$20,-(a7)                      ; 0006E
        moveq   #$0,d1                          ; 00072
l_153_00074:
        lsl.l   #$1,d1                          ; 00074
        tst.l   d3                              ; 00076
        bne.b   l_153_00084                     ; 00078
        cmp.l   d6,d4                           ; 0007A
        bcs.b   l_153_0008E                     ; 0007C
        bne.b   l_153_00084                     ; 0007E
        cmp.l   d7,d5                           ; 00080
        bcs.b   l_153_0008E                     ; 00082
l_153_00084:
        sub.l   d7,d5                           ; 00084
        subx.l  d6,d4                           ; 00086
        bcc.b   l_153_0008C                     ; 00088
        subq.l  #$1,d3                          ; 0008A
l_153_0008C:
        addq.l  #$1,d1                          ; 0008C
l_153_0008E:
        lsl.l   #$1,d5                          ; 0008E
        roxl.l  #$1,d4                          ; 00090
        roxl.l  #$1,d3                          ; 00092
        subq.w  #$1,(a7)                        ; 00094
        bne.b   l_153_00074                     ; 00096
        lea.l   $2(a7),a7                       ; 00098
        rts                                     ; 0009C
	dc.b	$00,$00
h153_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    1,155                           ; 1 longs pointing into hunk 155
	dc.l	$16
        dc.l    3,159                           ; 3 longs pointing into hunk 159
	dc.l	$32,$42,$64
	dc.l	0
	dc.l	HUNK_END
	endc
