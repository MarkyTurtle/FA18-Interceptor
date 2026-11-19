; F/A-18 Interceptor - hunk 125 (bss)
; Included by ../f18_main.s.

;===============================================================================
; Hunk 125: BSS, $C bytes
;===============================================================================
	BSS_HUNK	h125
; _MemList - The list of AllocMemTracked blocks (head, tail), freed at exit.
_MemList:
        ds.b    $C                              ; 00000
h125_end:
	ifnd	HUNKEXE
	section	bin,code			; (back from the offset section)
	org	0
	dc.l	HUNK_END
	endc
