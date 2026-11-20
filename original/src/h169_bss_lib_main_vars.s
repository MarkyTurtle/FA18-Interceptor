; F/A-18 Interceptor - hunk 169 (bss)
; C library: __main's variables (argv...).
; Included by ../f18_main.s.

;===============================================================================
; Hunk 169: BSS, $8C bytes
;===============================================================================
	BSS_HUNK	h169
; MainData14 - Data used by __main.
MainData14:
        ds.b    $4                              ; 00000
; MainData15 - Data used by __main.
MainData15:
        ds.b    $80                             ; 00004
; MainData16 - Data used by __main.
MainData16:
        ds.b    $4                              ; 00084
; MainData17 - Data used by __main.
MainData17:
        ds.b    $4                              ; 00088
h169_end:
	ifnd	HUNKEXE
	section	bin,code			; (back from the offset section)
	org	0
	dc.l	HUNK_END
	endc
