; F/A-18 Interceptor - hunk 137 (bss)
; C library: _ufbs, the low-level files.
; Included by ../f18_main.s.

;===============================================================================
; Hunk 137: BSS, $78 bytes
;===============================================================================
	BSS_HUNK	h137
; _ufbs - The low-level files: 6 bytes each (flags.w, AmigaDOS file handle.l).
_ufbs:
        ds.b    $2                              ; 00000
; MainData1 - Data used by __main.
MainData1:
        ds.b    $4                              ; 00002
; MainData2 - Data used by __main.
MainData2:
        ds.b    $2                              ; 00006
; MainData3 - Data used by __main.
MainData3:
        ds.b    $4                              ; 00008
; MainData4 - Data used by __main.
MainData4:
        ds.b    $2                              ; 0000C
; MainData5 - Data used by __main.
MainData5:
        ds.b    $6A                             ; 0000E
h137_end:
	ifnd	HUNKEXE
	section	bin,code			; (back from the offset section)
	org	0
	dc.l	HUNK_END
	endc
