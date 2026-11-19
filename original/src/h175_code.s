; F/A-18 Interceptor - hunk 175 (code)
; Included by ../f18_main.s.

;===============================================================================
; Hunk 175: CODE, $F0 bytes
;===============================================================================
	CODE_HUNK	h175
_CreatePort:
        movem.l d2-d7/a2,-(a7)                  ; 00000
h175_L11:
        move.l  $20(a7),d4                      ; 00004
        move.b  $27(a7),d3                      ; 00008
h175_L9:
        move.l  #$ffffffff,-(a7)                ; 0000C
        jsr     (_AllocSignal).l                ; 00012
        move.l  d0,d2                           ; 00018
        move.b  d2,d6                           ; 0001A
        move.b  d6,d5                           ; 0001C
        moveq   #$0,d2                          ; 0001E
        move.b  d6,d2                           ; 00020
        cmpi.l  #$ffffffff,d2                   ; 00022
        addq.l  #$4,a7                          ; 00028
        bne.b   h175_L8                         ; 0002A
h175_L2:
        moveq   #$0,d0                          ; 0002C
        bra.w   h175_L1                         ; 0002E
h175_L8:
        move.l  #$10001,-(a7)                   ; 00032
        pea.l   $22.w                           ; 00038
        jsr     (_AllocMem).l                   ; 0003C
        movea.l d0,a2                           ; 00042
        exg.l   d7,a2                           ; 00044
        tst.l   d7                              ; 00046
        exg.l   d7,a2                           ; 00048
        addq.l  #$8,a7                          ; 0004A
        bne.b   h175_L7                         ; 0004C
h175_L3:
        moveq   #$0,d2                          ; 0004E
        move.b  d5,d2                           ; 00050
        move.l  d2,-(a7)                        ; 00052
        jsr     (_FreeSignal).l                 ; 00054
        moveq   #$0,d0                          ; 0005A
        addq.l  #$4,a7                          ; 0005C
        bra.b   h175_L1                         ; 0005E
h175_L7:
        move.l  d4,$a(a2)                       ; 00060
        move.b  d3,$9(a2)                       ; 00064
        move.b  #$4,$8(a2)                      ; 00068
        clr.b   $e(a2)                          ; 0006E
        move.b  d5,$f(a2)                       ; 00072
        clr.l   -(a7)                           ; 00076
        jsr     (_FindTask).l                   ; 00078
        move.l  d0,$10(a2)                      ; 0007E
        tst.l   d4                              ; 00082
        addq.l  #$4,a7                          ; 00084
        beq.b   h175_L6                         ; 00086
h175_L5:
        move.l  a2,-(a7)                        ; 00088
        jsr     (_AddPort).l                    ; 0008A
        addq.l  #$4,a7                          ; 00090
        bra.b   h175_L4                         ; 00092
h175_L6:
        pea.l   $14(a2)                         ; 00094
        jsr     (_NewList).l                    ; 00098
        addq.l  #$4,a7                          ; 0009E
h175_L4:
        move.l  a2,d0                           ; 000A0
h175_L1:
        movem.l (a7)+,d2-d7/a2                  ; 000A2
        rts                                     ; 000A6
_DeletePort:
        movem.l d2/a2,-(a7)                     ; 000A8
h175_L17:
        movea.l $c(a7),a2                       ; 000AC
h175_L15:
        tst.l   $a(a2)                          ; 000B0
        beq.b   h175_L13                        ; 000B4
h175_L14:
        move.l  a2,-(a7)                        ; 000B6
        jsr     (_RemPort).l                    ; 000B8
        addq.l  #$4,a7                          ; 000BE
h175_L13:
        move.b  #$ff,$8(a2)                     ; 000C0
        moveq   #-1,d2                          ; 000C6
        move.l  d2,$14(a2)                      ; 000C8
        moveq   #$0,d2                          ; 000CC
        move.b  $f(a2),d2                       ; 000CE
        move.l  d2,-(a7)                        ; 000D2
        jsr     (_FreeSignal).l                 ; 000D4
        pea.l   $22.w                           ; 000DA
        move.l  a2,-(a7)                        ; 000DE
        jsr     (_FreeMem).l                    ; 000E0
        lea.l   $c(a7),a7                       ; 000E6
h175_L12:
        movem.l (a7)+,d2/a2                     ; 000EA
        rts                                     ; 000EE
h175_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    1,172                           ; 1 longs pointing into hunk 172
	dc.l	$E2
        dc.l    1,172                           ; 1 longs pointing into hunk 172
	dc.l	$BA
        dc.l    1,174                           ; 1 longs pointing into hunk 174
	dc.l	$9A
        dc.l    1,172                           ; 1 longs pointing into hunk 172
	dc.l	$8C
        dc.l    2,172                           ; 2 longs pointing into hunk 172
	dc.l	$56,$D6
        dc.l    1,172                           ; 1 longs pointing into hunk 172
	dc.l	$7A
        dc.l    1,172                           ; 1 longs pointing into hunk 172
	dc.l	$14
        dc.l    1,172                           ; 1 longs pointing into hunk 172
	dc.l	$3E
	dc.l	0
	dc.l	HUNK_SYMBOL
	dc.l	3
	dc.b	'_CreatePort',0
	dc.l	_CreatePort
	dc.l	3
	dc.b	'_DeletePort',0
	dc.l	_DeletePort
	dc.l	1
	dc.b	'.L10'
	dc.l	$0
	dc.l	1
	dc.b	'.L11'
	dc.l	h175_L11
	dc.l	1
	dc.b	'.L12'
	dc.l	h175_L12
	dc.l	1
	dc.b	'.L13'
	dc.l	h175_L13
	dc.l	1
	dc.b	'.L14'
	dc.l	h175_L14
	dc.l	1
	dc.b	'.L15'
	dc.l	h175_L15
	dc.l	1
	dc.b	'.L16'
	dc.l	$A8
	dc.l	1
	dc.b	'.L17'
	dc.l	h175_L17
	dc.l	1
	dc.b	'.L1',0
	dc.l	h175_L1
	dc.l	1
	dc.b	'.L2',0
	dc.l	h175_L2
	dc.l	1
	dc.b	'.L3',0
	dc.l	h175_L3
	dc.l	1
	dc.b	'.L4',0
	dc.l	h175_L4
	dc.l	1
	dc.b	'.L5',0
	dc.l	h175_L5
	dc.l	1
	dc.b	'.L6',0
	dc.l	h175_L6
	dc.l	1
	dc.b	'.L7',0
	dc.l	h175_L7
	dc.l	1
	dc.b	'.L8',0
	dc.l	h175_L8
	dc.l	1
	dc.b	'.L9',0
	dc.l	h175_L9
	dc.l	0
	dc.l	HUNK_END
	endc
