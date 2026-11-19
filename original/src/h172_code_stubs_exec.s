; F/A-18 Interceptor - hunk 172 (code)
; The exec.library call stubs (_AllocMem, _FindTask...).
; Included by ../f18_main.s.

;===============================================================================
; Hunk 172: CODE, $1B8 bytes
;===============================================================================
	CODE_HUNK	h172
_AddIntServer:
        move.l  a6,-(a7)                        ; 00000
        movea.l (_SysBase).l,a6                 ; 00002
        movem.l $8(a7),d0/a1                    ; 00008
        jsr     _LVOAddIntServer(a6)            ; 0000E
        movea.l (a7)+,a6                        ; 00012
        rts                                     ; 00014
	dc.b	$00,$00
_RemIntServer:
        move.l  a6,-(a7)                        ; 00018
        movea.l (_SysBase).l,a6                 ; 0001A
        movem.l $8(a7),d0/a1                    ; 00020
        jsr     _LVORemIntServer(a6)            ; 00026
        movea.l (a7)+,a6                        ; 0002A
        rts                                     ; 0002C
	dc.b	$00,$00
_AllocMem:
        move.l  a6,-(a7)                        ; 00030
        movea.l (_SysBase).l,a6                 ; 00032
        movem.l $8(a7),d0-d1                    ; 00038
        jsr     _LVOAllocMem(a6)                ; 0003E
        movea.l (a7)+,a6                        ; 00042
        rts                                     ; 00044
	dc.b	$00,$00
_FreeMem:
        move.l  a6,-(a7)                        ; 00048
        movea.l (_SysBase).l,a6                 ; 0004A
        movea.l $8(a7),a1                       ; 00050
        move.l  $c(a7),d0                       ; 00054
        jsr     _LVOFreeMem(a6)                 ; 00058
        movea.l (a7)+,a6                        ; 0005C
        rts                                     ; 0005E
_AvailMem:
        move.l  a6,-(a7)                        ; 00060
        movea.l (_SysBase).l,a6                 ; 00062
        move.l  $8(a7),d1                       ; 00068
        jsr     _LVOAvailMem(a6)                ; 0006C
        movea.l (a7)+,a6                        ; 00070
        rts                                     ; 00072
_FindTask:
        move.l  a6,-(a7)                        ; 00074
        movea.l (_SysBase).l,a6                 ; 00076
        movea.l $8(a7),a1                       ; 0007C
        jsr     _LVOFindTask(a6)                ; 00080
        movea.l (a7)+,a6                        ; 00084
        rts                                     ; 00086
_SetTaskPri:
        move.l  a6,-(a7)                        ; 00088
        movea.l (_SysBase).l,a6                 ; 0008A
        movea.l $8(a7),a1                       ; 00090
        move.l  $c(a7),d0                       ; 00094
        jsr     _LVOSetTaskPri(a6)              ; 00098
        movea.l (a7)+,a6                        ; 0009C
        rts                                     ; 0009E
_SetSignal:
        move.l  a6,-(a7)                        ; 000A0
        movea.l (_SysBase).l,a6                 ; 000A2
        movem.l $8(a7),d0-d1                    ; 000A8
        jsr     _LVOSetSignal(a6)               ; 000AE
        movea.l (a7)+,a6                        ; 000B2
        rts                                     ; 000B4
	dc.b	$00,$00
_AllocSignal:
        move.l  a6,-(a7)                        ; 000B8
        movea.l (_SysBase).l,a6                 ; 000BA
        move.l  $8(a7),d0                       ; 000C0
        jsr     _LVOAllocSignal(a6)             ; 000C4
        movea.l (a7)+,a6                        ; 000C8
        rts                                     ; 000CA
_FreeSignal:
        move.l  a6,-(a7)                        ; 000CC
        movea.l (_SysBase).l,a6                 ; 000CE
        move.l  $8(a7),d0                       ; 000D4
        jsr     _LVOFreeSignal(a6)              ; 000D8
        movea.l (a7)+,a6                        ; 000DC
        rts                                     ; 000DE
_AddPort:
        move.l  a6,-(a7)                        ; 000E0
        movea.l (_SysBase).l,a6                 ; 000E2
        movea.l $8(a7),a1                       ; 000E8
        jsr     _LVOAddPort(a6)                 ; 000EC
        movea.l (a7)+,a6                        ; 000F0
        rts                                     ; 000F2
_RemPort:
        move.l  a6,-(a7)                        ; 000F4
        movea.l (_SysBase).l,a6                 ; 000F6
        movea.l $8(a7),a1                       ; 000FC
        jsr     _LVORemPort(a6)                 ; 00100
        movea.l (a7)+,a6                        ; 00104
        rts                                     ; 00106
_GetMsg:
        move.l  a6,-(a7)                        ; 00108
        movea.l (_SysBase).l,a6                 ; 0010A
        movea.l $8(a7),a0                       ; 00110
        jsr     _LVOGetMsg(a6)                  ; 00114
        movea.l (a7)+,a6                        ; 00118
        rts                                     ; 0011A
_WaitPort:
        move.l  a6,-(a7)                        ; 0011C
        movea.l (_SysBase).l,a6                 ; 0011E
        movea.l $8(a7),a0                       ; 00124
        jsr     _LVOWaitPort(a6)                ; 00128
        movea.l (a7)+,a6                        ; 0012C
        rts                                     ; 0012E
_CloseLibrary:
        move.l  a6,-(a7)                        ; 00130
        movea.l (_SysBase).l,a6                 ; 00132
        movea.l $8(a7),a1                       ; 00138
        jsr     _LVOCloseLibrary(a6)            ; 0013C
        movea.l (a7)+,a6                        ; 00140
        rts                                     ; 00142
_OpenDevice:
        move.l  a6,-(a7)                        ; 00144
        movea.l (_SysBase).l,a6                 ; 00146
        movea.l $8(a7),a0                       ; 0014C
        movem.l $c(a7),d0/a1                    ; 00150
        move.l  $14(a7),d1                      ; 00156
        jsr     _LVOOpenDevice(a6)              ; 0015A
        movea.l (a7)+,a6                        ; 0015E
        rts                                     ; 00160
	dc.b	$00,$00
_CloseDevice:
        move.l  a6,-(a7)                        ; 00164
        movea.l (_SysBase).l,a6                 ; 00166
        movea.l $8(a7),a1                       ; 0016C
        jsr     _LVOCloseDevice(a6)             ; 00170
        movea.l (a7)+,a6                        ; 00174
        rts                                     ; 00176
_DoIO:
        move.l  a6,-(a7)                        ; 00178
        movea.l (_SysBase).l,a6                 ; 0017A
        movea.l $8(a7),a1                       ; 00180
        jsr     _LVODoIO(a6)                    ; 00184
        movea.l (a7)+,a6                        ; 00188
        rts                                     ; 0018A
_SendIO:
        move.l  a6,-(a7)                        ; 0018C
        movea.l (_SysBase).l,a6                 ; 0018E
        movea.l $8(a7),a1                       ; 00194
        jsr     _LVOSendIO(a6)                  ; 00198
        movea.l (a7)+,a6                        ; 0019C
        rts                                     ; 0019E
_OpenLibrary:
        move.l  a6,-(a7)                        ; 001A0
        movea.l (_SysBase).l,a6                 ; 001A2
        movea.l $8(a7),a1                       ; 001A8
        move.l  $c(a7),d0                       ; 001AC
        jsr     _LVOOpenLibrary(a6)             ; 001B0
        movea.l (a7)+,a6                        ; 001B4
        rts                                     ; 001B6
h172_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    20,1                            ; 20 longs pointing into hunk 1
	dc.l	$4,$1C,$34,$4C,$64,$78,$8C,$A4
	dc.l	$BC,$D0,$E4,$F8,$10C,$120,$134,$148
	dc.l	$168,$17C,$190,$1A4
	dc.l	0
	dc.l	HUNK_SYMBOL
	dc.l	4
	dc.b	'_AddIntServer',0,0,0
	dc.l	_AddIntServer
	dc.l	4
	dc.b	'_RemIntServer',0,0,0
	dc.l	_RemIntServer
	dc.l	3
	dc.b	'_AllocMem',0,0,0
	dc.l	_AllocMem
	dc.l	2
	dc.b	'_FreeMem'
	dc.l	_FreeMem
	dc.l	3
	dc.b	'_AvailMem',0,0,0
	dc.l	_AvailMem
	dc.l	3
	dc.b	'_FindTask',0,0,0
	dc.l	_FindTask
	dc.l	3
	dc.b	'_SetTaskPri',0
	dc.l	_SetTaskPri
	dc.l	3
	dc.b	'_SetSignal',0,0
	dc.l	_SetSignal
	dc.l	3
	dc.b	'_AllocSignal'
	dc.l	_AllocSignal
	dc.l	3
	dc.b	'_FreeSignal',0
	dc.l	_FreeSignal
	dc.l	2
	dc.b	'_AddPort'
	dc.l	_AddPort
	dc.l	2
	dc.b	'_RemPort'
	dc.l	_RemPort
	dc.l	2
	dc.b	'_GetMsg',0
	dc.l	_GetMsg
	dc.l	3
	dc.b	'_WaitPort',0,0,0
	dc.l	_WaitPort
	dc.l	4
	dc.b	'_CloseLibrary',0,0,0
	dc.l	_CloseLibrary
	dc.l	3
	dc.b	'_OpenDevice',0
	dc.l	_OpenDevice
	dc.l	3
	dc.b	'_CloseDevice'
	dc.l	_CloseDevice
	dc.l	2
	dc.b	'_DoIO',0,0,0
	dc.l	_DoIO
	dc.l	2
	dc.b	'_SendIO',0
	dc.l	_SendIO
	dc.l	3
	dc.b	'_OpenLibrary'
	dc.l	_OpenLibrary
	dc.l	0
	dc.l	HUNK_END
	endc
