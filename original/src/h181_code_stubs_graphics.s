; F/A-18 Interceptor - hunk 181 (code)
; The graphics.library call stubs (_LoadRGB4, _MakeVPort, _WaitBlit...).
; Included by ../f18_main.s.

;===============================================================================
; Hunk 181: CODE, $140 bytes
;===============================================================================
	CODE_HUNK	h181
_LoadRGB4:
        move.l  a6,-(a7)                        ; 00000
        movem.l $8(a7),a0-a1                    ; 00002
        move.l  $10(a7),d0                      ; 00008
        movea.l (_GfxBase).l,a6                 ; 0000C
        jsr     _LVOLoadRGB4(a6)                ; 00012
        movea.l (a7)+,a6                        ; 00016
        rts                                     ; 00018
	dc.b	$00,$00
_InitRastPort:
        move.l  a6,-(a7)                        ; 0001C
        movea.l $8(a7),a1                       ; 0001E
        movea.l (_GfxBase).l,a6                 ; 00022
        jsr     _LVOInitRastPort(a6)            ; 00028
        movea.l (a7)+,a6                        ; 0002C
        rts                                     ; 0002E
_InitVPort:
        move.l  a6,-(a7)                        ; 00030
        movea.l $8(a7),a0                       ; 00032
        movea.l (_GfxBase).l,a6                 ; 00036
        jsr     _LVOInitVPort(a6)               ; 0003C
        movea.l (a7)+,a6                        ; 00040
        rts                                     ; 00042
_MrgCop:
        move.l  a6,-(a7)                        ; 00044
        movea.l $8(a7),a1                       ; 00046
        movea.l (_GfxBase).l,a6                 ; 0004A
        jsr     _LVOMrgCop(a6)                  ; 00050
        movea.l (a7)+,a6                        ; 00054
        rts                                     ; 00056
_MakeVPort:
        move.l  a6,-(a7)                        ; 00058
        movem.l $8(a7),a0-a1                    ; 0005A
        movea.l (_GfxBase).l,a6                 ; 00060
        jsr     _LVOMakeVPort(a6)               ; 00066
        movea.l (a7)+,a6                        ; 0006A
        rts                                     ; 0006C
	dc.b	$00,$00
_LoadView:
        move.l  a6,-(a7)                        ; 00070
        movea.l $8(a7),a1                       ; 00072
        movea.l (_GfxBase).l,a6                 ; 00076
        jsr     _LVOLoadView(a6)                ; 0007C
        movea.l (a7)+,a6                        ; 00080
        rts                                     ; 00082
_WaitBlit:
        move.l  a6,-(a7)                        ; 00084
        movea.l (_GfxBase).l,a6                 ; 00086
        jsr     _LVOWaitBlit(a6)                ; 0008C
        movea.l (a7)+,a6                        ; 00090
        rts                                     ; 00092
_InitView:
        move.l  a6,-(a7)                        ; 00094
        movea.l $8(a7),a1                       ; 00096
        movea.l (_GfxBase).l,a6                 ; 0009A
        jsr     _LVOInitView(a6)                ; 000A0
        movea.l (a7)+,a6                        ; 000A4
        rts                                     ; 000A6
_InitBitMap:
        movem.l d2/a6,-(a7)                     ; 000A8
        movea.l $c(a7),a0                       ; 000AC
        movem.l $10(a7),d0-d2                   ; 000B0
        movea.l (_GfxBase).l,a6                 ; 000B6
        jsr     _LVOInitBitMap(a6)              ; 000BC
        movem.l (a7)+,d2/a6                     ; 000C0
        rts                                     ; 000C4
	dc.b	$00,$00
_WaitBOVP:
        move.l  a6,-(a7)                        ; 000C8
        movea.l $8(a7),a0                       ; 000CA
        movea.l (_GfxBase).l,a6                 ; 000CE
        jsr     _LVOWaitBOVP(a6)                ; 000D4
        movea.l (a7)+,a6                        ; 000D8
        rts                                     ; 000DA
_FreeSprite:
        move.l  a6,-(a7)                        ; 000DC
        move.l  $8(a7),d0                       ; 000DE
        movea.l (_GfxBase).l,a6                 ; 000E2
        jsr     _LVOFreeSprite(a6)              ; 000E8
        movea.l (a7)+,a6                        ; 000EC
        rts                                     ; 000EE
_OwnBlitter:
        move.l  a6,-(a7)                        ; 000F0
        movea.l (_GfxBase).l,a6                 ; 000F2
        jsr     _LVOOwnBlitter(a6)              ; 000F8
        movea.l (a7)+,a6                        ; 000FC
        rts                                     ; 000FE
_DisownBlitter:
        move.l  a6,-(a7)                        ; 00100
        movea.l (_GfxBase).l,a6                 ; 00102
        jsr     _LVODisownBlitter(a6)           ; 00108
        movea.l (a7)+,a6                        ; 0010C
        rts                                     ; 0010E
_FreeRaster:
        move.l  a6,-(a7)                        ; 00110
        movea.l $8(a7),a0                       ; 00112
        movem.l $c(a7),d0-d1                    ; 00116
        movea.l (_GfxBase).l,a6                 ; 0011C
        jsr     _LVOFreeRaster(a6)              ; 00122
        movea.l (a7)+,a6                        ; 00126
        rts                                     ; 00128
	dc.b	$00,$00
_GetColorMap:
        move.l  a6,-(a7)                        ; 0012C
        move.l  $8(a7),d0                       ; 0012E
        movea.l (_GfxBase).l,a6                 ; 00132
        jsr     _LVOGetColorMap(a6)             ; 00138
        movea.l (a7)+,a6                        ; 0013C
        rts                                     ; 0013E
h181_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    15,2                            ; 15 longs pointing into hunk 2
	dc.l	$E,$24,$38,$4C,$62,$78,$88,$9C
	dc.l	$B8,$D0,$E4,$F4,$104,$11E,$134
	dc.l	0
	dc.l	HUNK_SYMBOL
	dc.l	3
	dc.b	'_LoadRGB4',0,0,0
	dc.l	_LoadRGB4
	dc.l	4
	dc.b	'_InitRastPort',0,0,0
	dc.l	_InitRastPort
	dc.l	3
	dc.b	'_InitVPort',0,0
	dc.l	_InitVPort
	dc.l	2
	dc.b	'_MrgCop',0
	dc.l	_MrgCop
	dc.l	3
	dc.b	'_MakeVPort',0,0
	dc.l	_MakeVPort
	dc.l	3
	dc.b	'_LoadView',0,0,0
	dc.l	_LoadView
	dc.l	3
	dc.b	'_WaitBlit',0,0,0
	dc.l	_WaitBlit
	dc.l	3
	dc.b	'_InitView',0,0,0
	dc.l	_InitView
	dc.l	3
	dc.b	'_InitBitMap',0
	dc.l	_InitBitMap
	dc.l	3
	dc.b	'_WaitBOVP',0,0,0
	dc.l	_WaitBOVP
	dc.l	3
	dc.b	'_FreeSprite',0
	dc.l	_FreeSprite
	dc.l	3
	dc.b	'_OwnBlitter',0
	dc.l	_OwnBlitter
	dc.l	4
	dc.b	'_DisownBlitter',0,0
	dc.l	_DisownBlitter
	dc.l	3
	dc.b	'_FreeRaster',0
	dc.l	_FreeRaster
	dc.l	3
	dc.b	'_GetColorMap'
	dc.l	_GetColorMap
	dc.l	0
	dc.l	HUNK_END
	endc
