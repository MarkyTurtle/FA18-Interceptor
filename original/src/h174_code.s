; F/A-18 Interceptor - hunk 174 (code)
; Included by ../f18_main.s.

;===============================================================================
; Hunk 174: CODE, $14 bytes
;===============================================================================
	CODE_HUNK	h174
_NewList:
        movea.l $4(a7),a0                       ; 00000
        move.l  a0,(a0)                         ; 00004
        addq.l  #$4,(a0)                        ; 00006
        clr.l   $4(a0)                          ; 00008
        move.l  a0,$8(a0)                       ; 0000C
        rts                                     ; 00010
	dc.b	$00,$00
h174_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_SYMBOL
	dc.l	2
	dc.b	'_NewList'
	dc.l	_NewList
	dc.l	0
	dc.l	HUNK_END
	endc
