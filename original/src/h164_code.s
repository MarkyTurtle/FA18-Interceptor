; F/A-18 Interceptor - hunk 164 (code)
; Included by ../f18_main.s.

;===============================================================================
; Hunk 164: CODE, $18 bytes
;===============================================================================
	CODE_HUNK	h164
sub_164_00000:
        move.l  d2,-(a7)                        ; 00000
        jsr     (sub_158_00000).l               ; 00002
        move.l  d1,d2                           ; 00008
        moveq   #$0,d1                          ; 0000A
        jsr     (sub_159_00036).l               ; 0000C
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
