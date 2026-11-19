; F/A-18 Interceptor - hunk 7 (code)
; Nop (an empty function) and a wrapper round the mouse interrupt.
; Included by ../f18_main.s.

;===============================================================================
; Hunk 7: CODE, $14 bytes
;===============================================================================
	CODE_HUNK	h007

;-------------------------------------------------------------------------------
; WithoutMouseInterrupt - RemoveMouseInterrupt, Nop, AddMouseInterrupt.
;-------------------------------------------------------------------------------
WithoutMouseInterrupt:
        jsr     (RemoveMouseInterrupt).l        ; 00000
        bsr.w   Nop                             ; 00006
        jsr     (AddMouseInterrupt).l           ; 0000A
        rts                                     ; 00010

;-------------------------------------------------------------------------------
; Nop - Does nothing (an empty function: the calls to it were probably debugging or stack
; checks once).
;-------------------------------------------------------------------------------
Nop:
        rts                                     ; 00012
h007_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    2,0                             ; 2 longs pointing into hunk 0
	dc.l	$C,$2
	dc.l	0
	dc.l	HUNK_END
	endc
