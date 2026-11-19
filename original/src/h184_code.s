; F/A-18 Interceptor - hunk 184 (code)
; Included by ../f18_main.s.

;===============================================================================
; Hunk 184: CODE, $10 bytes
;===============================================================================
	CODE_HUNK	h184
_CloseWorkBench:
        move.l  a6,-(a7)                        ; 00000
        movea.l (dat_002_00000).l,a6            ; 00002
        jsr     -$4e(a6)                        ; 00008
        movea.l (a7)+,a6                        ; 0000C
        rts                                     ; 0000E
h184_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    1,2                             ; 1 longs pointing into hunk 2
	dc.l	$4
	dc.l	0
	dc.l	HUNK_SYMBOL
	dc.l	4
	dc.b	'_CloseWorkBench',0
	dc.l	_CloseWorkBench
	dc.l	0
	dc.l	HUNK_END
	endc
