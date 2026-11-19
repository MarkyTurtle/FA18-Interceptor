; F/A-18 Interceptor - hunk 165 (code)
; Included by ../f18_main.s.

;===============================================================================
; Hunk 165: CODE, $18 bytes
;===============================================================================
	CODE_HUNK	h165
sub_165_00000:
        move.l  d2,-(a7)                        ; 00000
        move.l  d1,-(a7)                        ; 00002
        jsr     (sub_159_00000).l               ; 00004
        move.l  d2,d1                           ; 0000A
        jsr     (sub_158_00022).l               ; 0000C
        move.l  (a7)+,d1                        ; 00012
        move.l  (a7)+,d2                        ; 00014
        rts                                     ; 00016
h165_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    1,159                           ; 1 longs pointing into hunk 159
	dc.l	$6
        dc.l    1,158                           ; 1 longs pointing into hunk 158
	dc.l	$E
	dc.l	0
	dc.l	HUNK_END
	endc
