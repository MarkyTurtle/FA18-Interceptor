; F/A-18 Interceptor - hunk 155 (code)
; Included by ../f18_main.s.

;===============================================================================
; Hunk 155: CODE, $10 bytes
;===============================================================================
	CODE_HUNK	h155

;-------------------------------------------------------------------------------
; SetFPErr - Sets _FPERR (the floating-point error: 1 underflow, 2 overflow, 3 divide by zero).
;-------------------------------------------------------------------------------
SetFPErr:
        link.w  a6,#$0                          ; 00000
        move.l  $8(a6),(_FPERR).l               ; 00004
        unlk    a6                              ; 0000C
        rts                                     ; 0000E
h155_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    1,1                             ; 1 longs pointing into hunk 1
	dc.l	$8
	dc.l	0
	dc.l	HUNK_END
	endc
