; F/A-18 Interceptor - hunk 161 (code)
; C library: long to double.
; Included by ../f18_main.s.

;===============================================================================
; Hunk 161: CODE, $1C bytes
;===============================================================================
	CODE_HUNK	h161

;-------------------------------------------------------------------------------
; fp_LongToDouble - IEEE double from the long in d0.
;-------------------------------------------------------------------------------
fp_LongToDouble:
        move.l  d2,-(a7)                        ; 00000
        clr.l   d1                              ; 00002
        moveq   #$1f,d2                         ; 00004
        tst.l   d0                              ; 00006
        bpl.b   l_161_00010                     ; 00008
        neg.l   d0                              ; 0000A
        bset    #$1f,d2                         ; 0000C
l_161_00010:
        jsr     (fp_DoublePack).l               ; 00010
        move.l  (a7)+,d2                        ; 00016
        rts                                     ; 00018
	dc.b	$00,$00
h161_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    1,159                           ; 1 longs pointing into hunk 159
	dc.l	$12
	dc.l	0
	dc.l	HUNK_END
	endc
