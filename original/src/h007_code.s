; F/A-18 Interceptor - hunk 7 (code)
; Included by ../f18_main.s.

;===============================================================================
; Hunk 7: CODE, $14 bytes
;===============================================================================
	CODE_HUNK	h007
l_007_00000:
        jsr     (RemoveMouseInterrupt).l        ; 00000
        bsr.w   sub_007_00012                   ; 00006
        jsr     (AddMouseInterrupt).l           ; 0000A
        rts                                     ; 00010
sub_007_00012:
        rts                                     ; 00012
h007_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    2,0                             ; 2 longs pointing into hunk 0
	dc.l	$C,$2
	dc.l	0
	dc.l	HUNK_END
	endc
