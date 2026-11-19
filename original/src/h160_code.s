; F/A-18 Interceptor - hunk 160 (code)
; Included by ../f18_main.s.

;===============================================================================
; Hunk 160: CODE, $14 bytes
;===============================================================================
	CODE_HUNK	h160

;-------------------------------------------------------------------------------
; fp_LongToSingle - IEEE single from the long in d0.
;-------------------------------------------------------------------------------
fp_LongToSingle:
        move.l  d1,-(a7)                        ; 00000
        jsr     (fp_LongToDouble).l             ; 00002
        jsr     (fp_DoubleToSingle).l           ; 00008
        move.l  (a7)+,d1                        ; 0000E
        rts                                     ; 00010
	dc.b	$00,$00
h160_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    1,161                           ; 1 longs pointing into hunk 161
	dc.l	$4
        dc.l    1,165                           ; 1 longs pointing into hunk 165
	dc.l	$A
	dc.l	0
	dc.l	HUNK_END
	endc
