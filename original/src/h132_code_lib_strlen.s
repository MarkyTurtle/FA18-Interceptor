; F/A-18 Interceptor - hunk 132 (code)
; C library: strlen.
; Included by ../f18_main.s.

;===============================================================================
; Hunk 132: CODE, $24 bytes
;===============================================================================
	CODE_HUNK	h132

;-------------------------------------------------------------------------------
; strlen - strlen(s).
;-------------------------------------------------------------------------------
; strlen's frame: arguments from 8(a6), locals below a6 (after its link)
                rsset   8
strlen_String           rs.l    1               ; the string
strlen_Length           equ     -$4             ; the count (returned)
strlen:
        link.w  a6,#$fffc                       ; 00000
        clr.l   strlen_Length(a6)               ; 00004
l_132_00008:
        movea.l strlen_String(a6),a0            ; 00008
        adda.l  strlen_Length(a6),a0            ; 0000C
        move.b  (a0),d0                         ; 00010
        tst.b   d0                              ; 00012
        beq.b   l_132_0001C                     ; 00014
        addq.l  #$1,strlen_Length(a6)           ; 00016
        bra.b   l_132_00008                     ; 0001A
l_132_0001C:
        move.l  strlen_Length(a6),d0            ; 0001C
        unlk    a6                              ; 00020
        rts                                     ; 00022
h132_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc
