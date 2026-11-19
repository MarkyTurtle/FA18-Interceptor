; F/A-18 Interceptor - hunk 162 (code)
; C library: single to long.
; Included by ../f18_main.s.

;===============================================================================
; Hunk 162: CODE, $14 bytes
;===============================================================================
	CODE_HUNK	h162

;-------------------------------------------------------------------------------
; fp_SingleToLong - The long from the IEEE single in d0 (truncated).
;-------------------------------------------------------------------------------
fp_SingleToLong:
        move.l  d1,-(a7)                        ; 00000
        jsr     (fp_SingleToDouble).l           ; 00002
        jsr     (fp_DoubleToLong).l             ; 00008
        move.l  (a7)+,d1                        ; 0000E
        rts                                     ; 00010
	dc.b	$00,$00
h162_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    1,164                           ; 1 longs pointing into hunk 164
	dc.l	$4
        dc.l    1,163                           ; 1 longs pointing into hunk 163
	dc.l	$A
	dc.l	0
	dc.l	HUNK_END
	endc
