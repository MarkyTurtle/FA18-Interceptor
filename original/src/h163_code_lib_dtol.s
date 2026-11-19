; F/A-18 Interceptor - hunk 163 (code)
; C library: double to long.
; Included by ../f18_main.s.

;===============================================================================
; Hunk 163: CODE, $38 bytes
;===============================================================================
	CODE_HUNK	h163

;-------------------------------------------------------------------------------
; fp_DoubleToLong - The long from the IEEE double in d0:d1 (truncated; saturates).
;-------------------------------------------------------------------------------
fp_DoubleToLong:
        move.l  d2,-(a7)                        ; 00000
        move.l  d0,d2                           ; 00002
        bclr    #$1f,d2                         ; 00004
        tst.l   d2                              ; 00008
        bne.b   l_163_00010                     ; 0000A
l_163_0000C:
        moveq   #$0,d0                          ; 0000C
        bra.b   l_163_00032                     ; 0000E
l_163_00010:
        jsr     (fp_DoubleUnpack).l             ; 00010
        addq.w  #$1,d2                          ; 00016
        ble.b   l_163_0000C                     ; 00018
        subi.w  #$20,d2                         ; 0001A
        bmi.b   l_163_00028                     ; 0001E
        moveq   #-1,d0                          ; 00020
        bclr    #$1f,d0                         ; 00022
        bra.b   l_163_0002C                     ; 00026
l_163_00028:
        neg.w   d2                              ; 00028
        lsr.l   d2,d0                           ; 0002A
l_163_0002C:
        tst.l   d2                              ; 0002C
        bpl.b   l_163_00032                     ; 0002E
        neg.l   d0                              ; 00030
l_163_00032:
        move.l  (a7)+,d2                        ; 00032
        rts                                     ; 00034
	dc.b	$00,$00
h163_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    1,159                           ; 1 longs pointing into hunk 159
	dc.l	$12
	dc.l	0
	dc.l	HUNK_END
	endc
