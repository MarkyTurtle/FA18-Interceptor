; F/A-18 Interceptor - hunk 3 (code)
; Included by ../f18_main.s.

;===============================================================================
; Hunk 3: CODE, $94 bytes
;===============================================================================
	CODE_HUNK	h003
_UnPackRow:
        link.w  a6,#$fff0                       ; 00000
        movem.l d4-d7/a4-a5,-(a7)               ; 00004
        movea.l $8(a6),a0                       ; 00008
        movea.l (a0),a5                         ; 0000C
        movea.l $c(a6),a0                       ; 0000E
        movea.l (a0),a4                         ; 00012
        move.l  $10(a6),d5                      ; 00014
        move.l  $14(a6),d4                      ; 00018
        move.w  #$1,-$e(a6)                     ; 0001C
        move.b  #$80,-$f(a6)                    ; 00022
UN1:
        tst.b   d4                              ; 00028
        ble.b   UN5                             ; 0002A
        subq.b  #$1,d5                          ; 0002C
        blt.b   UN6                             ; 0002E
        move.b  (a5),d7                         ; 00030
        addq.l  #$1,a5                          ; 00032
        tst.b   d7                              ; 00034
        bmi.b   UN3                             ; 00036
        addq.b  #$1,d7                          ; 00038
        sub.b   d7,d5                           ; 0003A
        blt.b   UN6                             ; 0003C
        sub.b   d7,d4                           ; 0003E
        blt.b   UN6                             ; 00040
UN2:
        move.b  (a5),(a4)                       ; 00042
        addq.l  #$1,a5                          ; 00044
        addq.l  #$1,a4                          ; 00046
        subq.b  #$1,d7                          ; 00048
        tst.b   d7                              ; 0004A
        bgt.b   UN2                             ; 0004C
        bra.b   UN1                             ; 0004E
UN3:
        move.b  -$f(a6),d0                      ; 00050
        cmp.b   d7,d0                           ; 00054
        beq.b   UN1                             ; 00056
        move.l  d7,d0                           ; 00058
        neg.b   d0                              ; 0005A
        addq.b  #$1,d0                          ; 0005C
        move.l  d0,d7                           ; 0005E
        subq.b  #$1,d5                          ; 00060
        blt.b   UN6                             ; 00062
        sub.b   d7,d4                           ; 00064
        blt.b   UN6                             ; 00066
        move.b  (a5),d6                         ; 00068
        addq.l  #$1,a5                          ; 0006A
UN4:
        move.b  d6,(a4)                         ; 0006C
        addq.l  #$1,a4                          ; 0006E
        subq.b  #$1,d7                          ; 00070
        tst.b   d7                              ; 00072
        bgt.b   UN4                             ; 00074
        bra.b   UN1                             ; 00076
UN5:
        clr.w   -$e(a6)                         ; 00078
UN6:
        movea.l $8(a6),a0                       ; 0007C
        move.l  a5,(a0)                         ; 00080
        movea.l $c(a6),a0                       ; 00082
        move.l  a4,(a0)                         ; 00086
        move.w  -$e(a6),d0                      ; 00088
        movem.l (a7)+,d4-d7/a4-a5               ; 0008C
        unlk    a6                              ; 00090
        rts                                     ; 00092
h003_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_SYMBOL
	dc.l	3
	dc.b	'_UnPackRow',0,0
	dc.l	_UnPackRow
	dc.l	1
	dc.b	'UN1',0
	dc.l	UN1
	dc.l	1
	dc.b	'UN2',0
	dc.l	UN2
	dc.l	1
	dc.b	'UN3',0
	dc.l	UN3
	dc.l	1
	dc.b	'UN4',0
	dc.l	UN4
	dc.l	1
	dc.b	'UN5',0
	dc.l	UN5
	dc.l	1
	dc.b	'UN6',0
	dc.l	UN6
	dc.l	0
	dc.l	HUNK_END
	endc
