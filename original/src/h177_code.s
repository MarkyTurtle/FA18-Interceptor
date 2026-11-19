; F/A-18 Interceptor - hunk 177 (code)
; Included by ../f18_main.s.

;===============================================================================
; Hunk 177: CODE, $2C bytes
;===============================================================================
	CODE_HUNK	h177
_CreateStdIO:
        move.l  d2,-(a7)                        ; 00000
h177_L4:
        move.l  $8(a7),d2                       ; 00002
h177_L2:
        pea.l   $30.w                           ; 00006
        move.l  d2,-(a7)                        ; 0000A
        jsr     (_CreateExtIO).l                ; 0000C
        addq.l  #$8,a7                          ; 00012
h177_L1:
        move.l  (a7)+,d2                        ; 00014
        rts                                     ; 00016
_DeleteStdIO:
        move.l  d2,-(a7)                        ; 00018
h177_L8:
        move.l  $8(a7),d2                       ; 0001A
h177_L6:
        move.l  d2,-(a7)                        ; 0001E
        jsr     (_DeleteExtIO).l                ; 00020
        addq.l  #$4,a7                          ; 00026
h177_L5:
        move.l  (a7)+,d2                        ; 00028
        rts                                     ; 0002A
h177_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    2,179                           ; 2 longs pointing into hunk 179
	dc.l	$22,$E
	dc.l	0
	dc.l	HUNK_SYMBOL
	dc.l	3
	dc.b	'_CreateStdIO'
	dc.l	_CreateStdIO
	dc.l	3
	dc.b	'_DeleteStdIO'
	dc.l	_DeleteStdIO
	dc.l	1
	dc.b	'.L1',0
	dc.l	h177_L1
	dc.l	1
	dc.b	'.L2',0
	dc.l	h177_L2
	dc.l	1
	dc.b	'.L3',0
	dc.l	$0
	dc.l	1
	dc.b	'.L4',0
	dc.l	h177_L4
	dc.l	1
	dc.b	'.L5',0
	dc.l	h177_L5
	dc.l	1
	dc.b	'.L6',0
	dc.l	h177_L6
	dc.l	1
	dc.b	'.L7',0
	dc.l	$18
	dc.l	1
	dc.b	'.L8',0
	dc.l	h177_L8
	dc.l	0
	dc.l	HUNK_END
	endc
