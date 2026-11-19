; F/A-18 Interceptor - hunk 129 (code)
; Included by ../f18_main.s.

;===============================================================================
; Hunk 129: CODE, $88 bytes
;===============================================================================
	CODE_HUNK	h129
	dc.b	$4E,$56,$FF,$FC,$2F,$2E,$00,$08,$4E,$B9
        dc.l    sub_132_00000                   ; 0000A
	dc.b	$58,$8F,$20,$6E,$00,$08,$D1,$C0,$2D,$48,$FF,$FC,$20,$6E,$FF,$FC
	dc.b	$52,$AE,$FF,$FC,$22,$6E,$00,$0C,$10,$11,$10,$80,$52,$AE,$00,$0C
	dc.b	$4A,$00,$66,$E8,$20,$2E,$00,$08,$4E,$5E,$4E,$75
sub_129_0003A:
        link.w  a6,#$fffc                       ; 0003A
        move.l  $8(a6),-(a7)                    ; 0003E
        jsr     (sub_132_00000).l               ; 00042
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
