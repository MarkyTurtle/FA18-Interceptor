; F/A-18 Interceptor - hunk 148 (data)
; C library: malloc's variables.
; Included by ../f18_main.s.

;===============================================================================
; Hunk 148: DATA, $10 bytes
;===============================================================================
	DATA_HUNK	h148
; RbrkData4 - Data used by rbrk.
RbrkData4:
	dc.b	$00,$00,$00,$00
; RbrkData5 - Data used by rbrk.
RbrkData5:
	dc.b	$00,$00,$00,$00
; RbrkData6 - Data used by _free, _malloc, rbrk.
RbrkData6:
	dc.b	$00,$00,$00,$00
; MemoryUsed - The memory allocated (malloc, free; MemUsed).
MemoryUsed:
	dc.b	$00,$00,$00,$00
h148_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc
