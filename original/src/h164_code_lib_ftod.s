; F/A-18 Interceptor - hunk 164 (code)
; C library: single to double.
; Included by ../f18_main.s.

;===============================================================================
; Hunk 164: CODE, $18 bytes
;===============================================================================
	CODE_HUNK	h164

;-------------------------------------------------------------------------------
; fp_SingleToDouble - IEEE single d0 -> double d0:d1.
;-------------------------------------------------------------------------------
fp_SingleToDouble:
        move.l  d2,-(a7)                        ; 00000
        jsr     (fp_SingleUnpack).l             ; 00002
        move.l  d1,d2                           ; 00008
        moveq   #$0,d1                          ; 0000A
        jsr     (fp_DoublePack).l               ; 0000C
        move.l  (a7)+,d2                        ; 00012
        rts                                     ; 00014
	dc.b	$00,$00
h164_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    1,158                           ; 1 longs pointing into hunk 158
	dc.l	$4
        dc.l    1,159                           ; 1 longs pointing into hunk 159
	dc.l	$E
	dc.l	0
	dc.l	HUNK_END
	endc
