; F/A-18 Interceptor - hunk 138 (code)
; Included by ../f18_main.s.

;===============================================================================
; Hunk 138: CODE, $68 bytes
;===============================================================================
	CODE_HUNK	h138

;-------------------------------------------------------------------------------
; _exit - _exit(code): closes the AmigaDOS file of every open low-level file (_ufbs) and leaves
; through XCEXIT.
;-------------------------------------------------------------------------------
_exit:
        link.w  a6,#$fffa                       ; 00000
        movem.l d5-d7,-(a7)                     ; 00004
        move.l  (_nufbs).l,d6                   ; 00008
        moveq   #$0,d7                          ; 0000E
l_138_00010:
        cmp.w   d6,d7                           ; 00010
        bge.b   l_138_0004E                     ; 00012
        move.l  d7,d0                           ; 00014
        muls.w  #$6,d0                          ; 00016
        movea.l d0,a0                           ; 0001A
        adda.l  #_ufbs,a0                       ; 0001C
        move.b  (a0),d5                         ; 00022
        tst.b   d5                              ; 00024
        beq.b   l_138_0004A                     ; 00026
        move.l  d5,d0                           ; 00028
        btst    #$2,d0                          ; 0002A
        bne.b   l_138_0004A                     ; 0002E
        move.l  d7,d0                           ; 00030
        muls.w  #$6,d0                          ; 00032
        movea.l d0,a0                           ; 00036
        adda.l  #_ufbs,a0                       ; 00038
        move.l  $2(a0),-(a7)                    ; 0003E
        jsr     (_Close).l                      ; 00042
        addq.l  #$4,a7                          ; 00048
l_138_0004A:
        addq.w  #$1,d7                          ; 0004A
        bra.b   l_138_00010                     ; 0004C
l_138_0004E:
        move.l  $c(a6),-(a7)                    ; 0004E
        move.l  $8(a6),-(a7)                    ; 00052
        jsr     (XCEXIT).l                      ; 00056
        addq.l  #$8,a7                          ; 0005C
        movem.l (a7)+,d5-d7                     ; 0005E
        unlk    a6                              ; 00062
        rts                                     ; 00064
	dc.b	$00,$00
h138_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    1,136                           ; 1 longs pointing into hunk 136
	dc.l	$A
        dc.l    2,137                           ; 2 longs pointing into hunk 137
	dc.l	$1E,$3A
        dc.l    1,171                           ; 1 longs pointing into hunk 171
	dc.l	$44
        dc.l    1,0                             ; 1 longs pointing into hunk 0
	dc.l	$58
	dc.l	0
	dc.l	HUNK_END
	endc
