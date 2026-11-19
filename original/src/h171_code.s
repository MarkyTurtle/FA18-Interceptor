; F/A-18 Interceptor - hunk 171 (code)
; Included by ../f18_main.s.

;===============================================================================
; Hunk 171: CODE, $14C bytes
;===============================================================================
	CODE_HUNK	h171
_Open:
        movem.l d2/a6,-(a7)                     ; 00000
        movem.l $c(a7),d1-d2                    ; 00004
        movea.l (dat_001_00030).l,a6            ; 0000A
        jsr     -$1e(a6)                        ; 00010
        movem.l (a7)+,d2/a6                     ; 00014
        rts                                     ; 00018
	dc.b	$00,$00
_Close:
        move.l  a6,-(a7)                        ; 0001C
        move.l  $8(a7),d1                       ; 0001E
        movea.l (dat_001_00030).l,a6            ; 00022
        jsr     -$24(a6)                        ; 00028
        movea.l (a7)+,a6                        ; 0002C
        rts                                     ; 0002E
_Read:
        movem.l d2-d3/a6,-(a7)                  ; 00030
        movem.l $10(a7),d1-d3                   ; 00034
        movea.l (dat_001_00030).l,a6            ; 0003A
        jsr     -$2a(a6)                        ; 00040
        movem.l (a7)+,d2-d3/a6                  ; 00044
        rts                                     ; 00048
	dc.b	$00,$00
_Write:
        movem.l d2-d3/a6,-(a7)                  ; 0004C
        movem.l $10(a7),d1-d3                   ; 00050
        movea.l (dat_001_00030).l,a6            ; 00056
        jsr     -$30(a6)                        ; 0005C
        movem.l (a7)+,d2-d3/a6                  ; 00060
        rts                                     ; 00064
	dc.b	$00,$00
_Input:
        move.l  a6,-(a7)                        ; 00068
        movea.l (dat_001_00030).l,a6            ; 0006A
        jsr     -$36(a6)                        ; 00070
        movea.l (a7)+,a6                        ; 00074
        rts                                     ; 00076
_Output:
        move.l  a6,-(a7)                        ; 00078
        movea.l (dat_001_00030).l,a6            ; 0007A
        jsr     -$3c(a6)                        ; 00080
        movea.l (a7)+,a6                        ; 00084
        rts                                     ; 00086
_Seek:
        movem.l d2-d3/a6,-(a7)                  ; 00088
        movem.l $10(a7),d1-d3                   ; 0008C
        movea.l (dat_001_00030).l,a6            ; 00092
        jsr     -$42(a6)                        ; 00098
        movem.l (a7)+,d2-d3/a6                  ; 0009C
        rts                                     ; 000A0
	dc.b	$00,$00
_DeleteFile:
        move.l  a6,-(a7)                        ; 000A4
        move.l  $8(a7),d1                       ; 000A6
        movea.l (dat_001_00030).l,a6            ; 000AA
        jsr     -$48(a6)                        ; 000B0
        movea.l (a7)+,a6                        ; 000B4
        rts                                     ; 000B6
_Rename:
        movem.l d2/a6,-(a7)                     ; 000B8
        movem.l $c(a7),d1-d2                    ; 000BC
        movea.l (dat_001_00030).l,a6            ; 000C2
        jsr     -$4e(a6)                        ; 000C8
        movem.l (a7)+,d2/a6                     ; 000CC
        rts                                     ; 000D0
	dc.b	$00,$00
_Lock:
        movem.l d2/a6,-(a7)                     ; 000D4
        movem.l $c(a7),d1-d2                    ; 000D8
        movea.l (dat_001_00030).l,a6            ; 000DE
        jsr     -$54(a6)                        ; 000E4
        movem.l (a7)+,d2/a6                     ; 000E8
        rts                                     ; 000EC
	dc.b	$00,$00
_UnLock:
        move.l  a6,-(a7)                        ; 000F0
        move.l  $8(a7),d1                       ; 000F2
        movea.l (dat_001_00030).l,a6            ; 000F6
        jsr     -$5a(a6)                        ; 000FC
        movea.l (a7)+,a6                        ; 00100
        rts                                     ; 00102
_Examine:
        movem.l d2/a6,-(a7)                     ; 00104
        movem.l $c(a7),d1-d2                    ; 00108
        movea.l (dat_001_00030).l,a6            ; 0010E
        jsr     -$66(a6)                        ; 00114
        movem.l (a7)+,d2/a6                     ; 00118
        rts                                     ; 0011C
	dc.b	$00,$00
_Info:
        movem.l d2/a6,-(a7)                     ; 00120
        movem.l $c(a7),d1-d2                    ; 00124
        movea.l (dat_001_00030).l,a6            ; 0012A
        jsr     -$72(a6)                        ; 00130
        movem.l (a7)+,d2/a6                     ; 00134
        rts                                     ; 00138
	dc.b	$00,$00
_IoErr:
        move.l  a6,-(a7)                        ; 0013C
        movea.l (dat_001_00030).l,a6            ; 0013E
        jsr     -$84(a6)                        ; 00144
        movea.l (a7)+,a6                        ; 00148
        rts                                     ; 0014A
h171_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    14,1                            ; 14 longs pointing into hunk 1
	dc.l	$C,$24,$3C,$58,$6C,$7C,$94,$AC
	dc.l	$C4,$E0,$F8,$110,$12C,$140
	dc.l	0
	dc.l	HUNK_SYMBOL
	dc.l	2
	dc.b	'_Open',0,0,0
	dc.l	_Open
	dc.l	2
	dc.b	'_Close',0,0
	dc.l	_Close
	dc.l	2
	dc.b	'_Read',0,0,0
	dc.l	_Read
	dc.l	2
	dc.b	'_Write',0,0
	dc.l	_Write
	dc.l	2
	dc.b	'_Input',0,0
	dc.l	_Input
	dc.l	2
	dc.b	'_Output',0
	dc.l	_Output
	dc.l	2
	dc.b	'_Seek',0,0,0
	dc.l	_Seek
	dc.l	3
	dc.b	'_DeleteFile',0
	dc.l	_DeleteFile
	dc.l	2
	dc.b	'_Rename',0
	dc.l	_Rename
	dc.l	2
	dc.b	'_Lock',0,0,0
	dc.l	_Lock
	dc.l	2
	dc.b	'_UnLock',0
	dc.l	_UnLock
	dc.l	2
	dc.b	'_Examine'
	dc.l	_Examine
	dc.l	2
	dc.b	'_Info',0,0,0
	dc.l	_Info
	dc.l	2
	dc.b	'_IoErr',0,0
	dc.l	_IoErr
	dc.l	0
	dc.l	HUNK_END
	endc
