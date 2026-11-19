; F/A-18 Interceptor - hunk 154 (code)
; C library: CXM33, 32-bit multiply.
; Included by ../f18_main.s.

;===============================================================================
; Hunk 154: CODE, $44 bytes
;===============================================================================
	CODE_HUNK	h154

;-------------------------------------------------------------------------------
; CXM33 - Signed 32-bit multiply: d0 = d0 * d1.
;-------------------------------------------------------------------------------
CXM33:
        movem.l d1-d4,-(a7)                     ; 00000
        move.l  d0,d4                           ; 00004
        eor.l   d1,d4                           ; 00006
        tst.l   d0                              ; 00008
        beq.b   l_154_0003C                     ; 0000A
        bpl.b   l_154_00010                     ; 0000C
        neg.l   d0                              ; 0000E
l_154_00010:
        move.l  d0,d2                           ; 00010
        tst.l   d1                              ; 00012
        bne.b   l_154_0001A                     ; 00014
        clr.l   d0                              ; 00016
        bra.b   l_154_0003C                     ; 00018
l_154_0001A:
        bpl.b   l_154_0001E                     ; 0001A
        neg.l   d1                              ; 0001C
l_154_0001E:
        move.l  d0,d3                           ; 0001E
        mulu.w  d1,d3                           ; 00020
        swap    d2                              ; 00022
        mulu.w  d1,d2                           ; 00024
        swap    d2                              ; 00026
        clr.w   d2                              ; 00028
        add.l   d2,d3                           ; 0002A
        swap    d1                              ; 0002C
        mulu.w  d1,d0                           ; 0002E
        swap    d0                              ; 00030
        clr.w   d0                              ; 00032
        add.l   d3,d0                           ; 00034
        tst.l   d4                              ; 00036
        bpl.b   l_154_0003C                     ; 00038
        neg.l   d0                              ; 0003A
l_154_0003C:
        movem.l (a7)+,d1-d4                     ; 0003C
        rts                                     ; 00040
	dc.b	$00,$00
h154_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc
