; F/A-18 Interceptor - hunk 129 (code)
; Included by ../f18_main.s.

;===============================================================================
; Hunk 129: CODE, $88 bytes
;===============================================================================
	CODE_HUNK	h129

;-------------------------------------------------------------------------------
; strcat - strcat(dst, src).
;-------------------------------------------------------------------------------
strcat:
        link.w  a6,#$fffc                       ; 00000
        move.l  $8(a6),-(a7)                    ; 00004
        jsr     (strlen).l                      ; 00008
        addq.l  #$4,a7                          ; 0000E
        movea.l $8(a6),a0                       ; 00010
        adda.l  d0,a0                           ; 00014
        move.l  a0,-$4(a6)                      ; 00016
l_129_0001A:
        movea.l -$4(a6),a0                      ; 0001A
        addq.l  #$1,-$4(a6)                     ; 0001E
        movea.l $c(a6),a1                       ; 00022
        move.b  (a1),d0                         ; 00026
        move.b  d0,(a0)                         ; 00028
        addq.l  #$1,$c(a6)                      ; 0002A
        tst.b   d0                              ; 0002E
        bne.b   l_129_0001A                     ; 00030
        move.l  $8(a6),d0                       ; 00032
        unlk    a6                              ; 00036
        rts                                     ; 00038
strncat:
        link.w  a6,#$fffc                       ; 0003A
        move.l  $8(a6),-(a7)                    ; 0003E
        jsr     (strlen).l                      ; 00042
        addq.l  #$4,a7                          ; 00048
        movea.l $8(a6),a0                       ; 0004A
        adda.l  d0,a0                           ; 0004E
        move.l  a0,-$4(a6)                      ; 00050
l_129_00054:
        move.l  $10(a6),d0                      ; 00054
        subq.l  #$1,$10(a6)                     ; 00058
        tst.l   d0                              ; 0005C
        ble.b   l_129_0007A                     ; 0005E
        movea.l $c(a6),a0                       ; 00060
        move.b  (a0),d0                         ; 00064
        movea.l -$4(a6),a1                      ; 00066
        move.b  d0,(a1)                         ; 0006A
        addq.l  #$1,$c(a6)                      ; 0006C
        tst.b   d0                              ; 00070
        beq.b   l_129_0007A                     ; 00072
        addq.l  #$1,-$4(a6)                     ; 00074
        bra.b   l_129_00054                     ; 00078
l_129_0007A:
        movea.l -$4(a6),a0                      ; 0007A
        clr.b   (a0)                            ; 0007E
        move.l  $8(a6),d0                       ; 00080
        unlk    a6                              ; 00084
        rts                                     ; 00086
h129_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    2,132                           ; 2 longs pointing into hunk 132
	dc.l	$A,$44
	dc.l	0
	dc.l	HUNK_END
	endc
