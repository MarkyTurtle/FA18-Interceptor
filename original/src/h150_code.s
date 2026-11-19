; F/A-18 Interceptor - hunk 150 (code)
; Included by ../f18_main.s.

;===============================================================================
; Hunk 150: CODE, $28 bytes
;===============================================================================
	CODE_HUNK	h150
sub_150_00000:
        movea.l $4(a7),a0                       ; 00000
        movea.l $8(a7),a1                       ; 00004
        move.l  $c(a7),d0                       ; 00008
        ble.b   l_150_00024                     ; 0000C
        cmpa.l  a0,a1                           ; 0000E
        bcs.b   l_150_0001E                     ; 00010
        adda.l  d0,a0                           ; 00012
        adda.l  d0,a1                           ; 00014
l_150_00016:
        move.b  -(a0),-(a1)                     ; 00016
        subq.l  #$1,d0                          ; 00018
        bne.b   l_150_00016                     ; 0001A
        rts                                     ; 0001C
l_150_0001E:
        move.b  (a0)+,(a1)+                     ; 0001E
        subq.l  #$1,d0                          ; 00020
        bne.b   l_150_0001E                     ; 00022
l_150_00024:
        rts                                     ; 00024
	dc.b	$00,$00
h150_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc
