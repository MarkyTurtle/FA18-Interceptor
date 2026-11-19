; F/A-18 Interceptor - hunk 111 (code)
; C library: fread.
; Included by ../f18_main.s.

;===============================================================================
; Hunk 111: CODE, $7C bytes
;===============================================================================
	CODE_HUNK	h111

;-------------------------------------------------------------------------------
; fread - fread(buf, size, count, fp): reads size*count bytes one at a time (getc, _filbuf when
; the buffer is empty); returns the number of whole items.
;-------------------------------------------------------------------------------
fread:
        link.w  a6,#$fff4                       ; 00000
        clr.l   -$4(a6)                         ; 00004
l_111_00008:
        move.l  -$4(a6),d0                      ; 00008
        cmp.l   $10(a6),d0                      ; 0000C
        bge.b   l_111_00072                     ; 00010
        clr.l   -$8(a6)                         ; 00012
l_111_00016:
        move.l  -$8(a6),d0                      ; 00016
        cmp.l   $c(a6),d0                       ; 0001A
        bge.b   l_111_0006C                     ; 0001E
        movea.l $14(a6),a0                      ; 00020
        move.l  $4(a0),d0                       ; 00024
        subq.l  #$1,d0                          ; 00028
        move.l  d0,$4(a0)                       ; 0002A
        tst.l   d0                              ; 0002E
        bmi.b   l_111_0003C                     ; 00030
        movea.l (a0),a1                         ; 00032
        addq.l  #$1,(a0)                        ; 00034
        moveq   #$0,d0                          ; 00036
        move.b  (a1),d0                         ; 00038
        bra.b   l_111_00048                     ; 0003A
l_111_0003C:
        move.l  $14(a6),-(a7)                   ; 0003C
        jsr     (_filbuf).l                     ; 00040
        addq.l  #$4,a7                          ; 00046
l_111_00048:
        move.l  d0,-$c(a6)                      ; 00048
        addq.l  #$1,d0                          ; 0004C
        bne.b   l_111_00058                     ; 0004E
        move.l  -$4(a6),d0                      ; 00050
        unlk    a6                              ; 00054
        rts                                     ; 00056
l_111_00058:
        movea.l $8(a6),a0                       ; 00058
        addq.l  #$1,$8(a6)                      ; 0005C
        move.l  -$c(a6),d0                      ; 00060
        move.b  d0,(a0)                         ; 00064
        addq.l  #$1,-$8(a6)                     ; 00066
        bra.b   l_111_00016                     ; 0006A
l_111_0006C:
        addq.l  #$1,-$4(a6)                     ; 0006C
        bra.b   l_111_00008                     ; 00070
l_111_00072:
        move.l  -$4(a6),d0                      ; 00072
        unlk    a6                              ; 00076
        rts                                     ; 00078
	dc.b	$00,$00
h111_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    1,120                           ; 1 longs pointing into hunk 120
	dc.l	$42
	dc.l	0
	dc.l	HUNK_END
	endc
