; F/A-18 Interceptor - hunk 137 (bss)
; Included by ../f18_main.s.

;===============================================================================
; Hunk 137: BSS, $78 bytes
;===============================================================================
	BSS_HUNK	h137
; _ufbs - The low-level files: 6 bytes each (flags.w, AmigaDOS file handle.l).
_ufbs:
        ds.b    $2                              ; 00000
dat_137_00002:
        ds.b    $4                              ; 00002
dat_137_00006:
        ds.b    $2                              ; 00006
dat_137_00008:
        ds.b    $4                              ; 00008
dat_137_0000C:
        ds.b    $2                              ; 0000C
dat_137_0000E:
        ds.b    $6A                             ; 0000E
h137_end:
	ifnd	HUNKEXE
	section	bin,code			; (back from the offset section)
	org	0
	dc.l	HUNK_END
	endc
