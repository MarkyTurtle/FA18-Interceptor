; F/A-18 Interceptor - hunk 96 (code)
; Included by ../f18_main.s.

;===============================================================================
; Hunk 96: CODE, $68 bytes
;===============================================================================
	CODE_HUNK	h096

;-------------------------------------------------------------------------------
; exit - exit(code): closes every stdio stream (fclose on the 20 _iob entries) and every low-
; level file, then _exit(code).
;-------------------------------------------------------------------------------
exit:
        link.w  a6,#$fffc                       ; 00000
        clr.l   -$4(a6)                         ; 00004
l_096_00008:
        move.l  -$4(a6),d0                      ; 00008
        cmpi.l  #$14,d0                         ; 0000C
        bge.b   l_096_00034                     ; 00012
        moveq   #$18,d1                         ; 00014
        jsr     (CXM33).l                       ; 00016
        movea.l d0,a0                           ; 0001C
        adda.l  #_iob,a0                        ; 0001E
        move.l  a0,-(a7)                        ; 00024
        jsr     (fclose).l                      ; 00026
        addq.l  #$4,a7                          ; 0002C
        addq.l  #$1,-$4(a6)                     ; 0002E
        bra.b   l_096_00008                     ; 00032
l_096_00034:
        clr.l   -$4(a6)                         ; 00034
l_096_00038:
        move.l  -$4(a6),d0                      ; 00038
        cmp.l   (_nufbs).l,d0                   ; 0003C
        bge.b   l_096_00054                     ; 00042
        move.l  d0,-(a7)                        ; 00044
        jsr     (close).l                       ; 00046
        addq.l  #$4,a7                          ; 0004C
        addq.l  #$1,-$4(a6)                     ; 0004E
        bra.b   l_096_00038                     ; 00052
l_096_00054:
        move.l  $c(a6),-(a7)                    ; 00054
        move.l  $8(a6),-(a7)                    ; 00058
        jsr     (_exit).l                       ; 0005C
        addq.l  #$8,a7                          ; 00062
        unlk    a6                              ; 00064
        rts                                     ; 00066
h096_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    1,154                           ; 1 longs pointing into hunk 154
	dc.l	$18
        dc.l    1,143                           ; 1 longs pointing into hunk 143
	dc.l	$20
        dc.l    1,105                           ; 1 longs pointing into hunk 105
	dc.l	$28
        dc.l    1,136                           ; 1 longs pointing into hunk 136
	dc.l	$3E
        dc.l    1,117                           ; 1 longs pointing into hunk 117
	dc.l	$48
        dc.l    1,138                           ; 1 longs pointing into hunk 138
	dc.l	$5E
	dc.l	0
	dc.l	HUNK_END
	endc
