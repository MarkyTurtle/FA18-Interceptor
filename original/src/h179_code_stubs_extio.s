; F/A-18 Interceptor - hunk 179 (code)
; amiga.lib: _CreateExtIO, _DeleteExtIO.
; Included by ../f18_main.s.

;===============================================================================
; Hunk 179: CODE, $84 bytes
;===============================================================================
	CODE_HUNK	h179
_CreateExtIO:
        movem.l d2-d4,-(a7)                     ; 00000
h179_L8:
        move.l  $10(a7),d2                      ; 00004
        move.l  $14(a7),d3                      ; 00008
h179_L6:
        tst.l   d2                              ; 0000C
        bne.b   h179_L5                         ; 0000E
h179_L2:
        moveq   #$0,d0                          ; 00010
        bra.b   h179_L1                         ; 00012
h179_L5:
        move.l  #$10001,-(a7)                   ; 00014
        move.l  d3,-(a7)                        ; 0001A
        jsr     (_AllocMem).l                   ; 0001C
        movea.l d0,a0                           ; 00022
        exg.l   d4,a0                           ; 00024
        tst.l   d4                              ; 00026
        exg.l   d4,a0                           ; 00028
        addq.l  #$8,a7                          ; 0002A
        bne.b   h179_L4                         ; 0002C
h179_L3:
        moveq   #$0,d0                          ; 0002E
        bra.b   h179_L1                         ; 00030
h179_L4:
        move.b  #$5,$8(a0)                      ; 00032
        move.w  d3,$12(a0)                      ; 00038
        move.l  d2,$e(a0)                       ; 0003C
        move.l  a0,d0                           ; 00040
h179_L1:
        movem.l (a7)+,d2-d4                     ; 00042
        rts                                     ; 00046
_DeleteExtIO:
        movem.l d2-d3,-(a7)                     ; 00048
h179_L14:
        movea.l $c(a7),a0                       ; 0004C
h179_L12:
        exg.l   d3,a0                           ; 00050
        tst.l   d3                              ; 00052
        exg.l   d3,a0                           ; 00054
        beq.w   h179_L9                         ; 00056
h179_L11:
        move.b  #$ff,$8(a0)                     ; 0005A
        moveq   #-1,d2                          ; 00060
        move.l  d2,$14(a0)                      ; 00062
        moveq   #-1,d2                          ; 00066
        move.l  d2,$18(a0)                      ; 00068
        moveq   #$0,d2                          ; 0006C
        move.w  $12(a0),d2                      ; 0006E
        move.l  d2,-(a7)                        ; 00072
        move.l  a0,-(a7)                        ; 00074
        jsr     (_FreeMem).l                    ; 00076
        addq.l  #$8,a7                          ; 0007C
h179_L9:
        movem.l (a7)+,d2-d3                     ; 0007E
        rts                                     ; 00082
h179_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    1,172                           ; 1 longs pointing into hunk 172
	dc.l	$78
        dc.l    1,172                           ; 1 longs pointing into hunk 172
	dc.l	$1E
	dc.l	0
	dc.l	HUNK_SYMBOL
	dc.l	3
	dc.b	'_CreateExtIO'
	dc.l	_CreateExtIO
	dc.l	3
	dc.b	'_DeleteExtIO'
	dc.l	_DeleteExtIO
	dc.l	1
	dc.b	'.L11'
	dc.l	h179_L11
	dc.l	1
	dc.b	'.L12'
	dc.l	h179_L12
	dc.l	1
	dc.b	'.L13'
	dc.l	$48
	dc.l	1
	dc.b	'.L14'
	dc.l	h179_L14
	dc.l	1
	dc.b	'.L1',0
	dc.l	h179_L1
	dc.l	1
	dc.b	'.L2',0
	dc.l	h179_L2
	dc.l	1
	dc.b	'.L3',0
	dc.l	h179_L3
	dc.l	1
	dc.b	'.L4',0
	dc.l	h179_L4
	dc.l	1
	dc.b	'.L5',0
	dc.l	h179_L5
	dc.l	1
	dc.b	'.L6',0
	dc.l	h179_L6
	dc.l	1
	dc.b	'.L7',0
	dc.l	$0
	dc.l	1
	dc.b	'.L8',0
	dc.l	h179_L8
	dc.l	1
	dc.b	'.L9',0
	dc.l	h179_L9
	dc.l	0
	dc.l	HUNK_END
	endc
