; F/A-18 Interceptor - hunk 169 (bss)
; C library: __main's variables (argv...).
; Included by ../f18_main.s.

;===============================================================================
; Hunk 169: BSS, $8C bytes
;===============================================================================
	BSS_HUNK	h169
dat_169_00000:
        ds.b    $4                              ; 00000
dat_169_00004:
        ds.b    $80                             ; 00004
dat_169_00084:
        ds.b    $4                              ; 00084
dat_169_00088:
        ds.b    $4                              ; 00088
h169_end:
	ifnd	HUNKEXE
	section	bin,code			; (back from the offset section)
	org	0
	dc.l	HUNK_END
	endc
