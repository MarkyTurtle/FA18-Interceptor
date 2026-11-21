; F/A-18 Interceptor - hunk 108 (code)
; C library: fprintf.
; Included by ../f18_main.s.

;===============================================================================
; Hunk 108: CODE, $14C bytes
;===============================================================================
	CODE_HUNK	h108

;-------------------------------------------------------------------------------
; fprintf - fprintf(fp, format, ...): formats each conversion with _pfmt into a buffer and
; writes it with _flsbuf.
;-------------------------------------------------------------------------------
; fprintf's frame: arguments from 8(a6), locals below a6 (after its link)
                rsset   8
fprintf_FP              rs.l    1               ; the stream
fprintf_Format          rs.l    1               ; the format string
fprintf_Args            rs.l    1               ; the first argument (the rest follow it)
fprintf:
        link.w  a6,#$feec                       ; 00000
        movem.l a2,-(a7)                        ; 00004
        lea.l   fprintf_Args(a6),a0             ; 00008
        move.l  a0,-$14(a6)                     ; 0000C
l_108_00010:
        movea.l fprintf_Format(a6),a0           ; 00010
        move.b  (a0),d0                         ; 00014
        tst.b   d0                              ; 00016
        beq.w   l_108_00132                     ; 00018
        moveq   #$0,d1                          ; 0001C
        move.b  (a0),d1                         ; 0001E
        addq.l  #$1,a0                          ; 00020
        move.l  d1,-$8(a6)                      ; 00022
        move.l  a0,fprintf_Format(a6)           ; 00026
        cmpi.l  #$25,d1                         ; 0002A
        bne.w   l_108_000F8                     ; 00030
        move.b  (a0),d0                         ; 00034
        cmpi.b  #$25,d0                         ; 00036
        bne.b   l_108_00078                     ; 0003A
        moveq   #$0,d2                          ; 0003C
        move.b  (a0),d2                         ; 0003E
        addq.l  #$1,fprintf_Format(a6)          ; 00040
        movea.l fprintf_FP(a6),a0               ; 00044
        move.l  iob_WCnt(a0),d0                 ; 00048
        subq.l  #$1,d0                          ; 0004C
        move.l  d0,iob_WCnt(a0)                 ; 0004E
        move.l  d2,-$8(a6)                      ; 00052
        tst.l   d0                              ; 00056
        bmi.b   l_108_00066                     ; 00058
        movea.l (a0),a1                         ; 0005A
        addq.l  #$1,(a0)                        ; 0005C
        move.b  d2,(a1)                         ; 0005E
        moveq   #$0,d0                          ; 00060
        move.b  (a1),d0                         ; 00062
        bra.b   l_108_00010                     ; 00064
l_108_00066:
        move.l  fprintf_FP(a6),-(a7)            ; 00066
        move.l  -$8(a6),-(a7)                   ; 0006A
        jsr     (_flsbuf).l                     ; 0006E
        addq.l  #$8,a7                          ; 00074
        bra.b   l_108_00010                     ; 00076
l_108_00078:
        pea.l   -$c(a6)                         ; 00078
        pea.l   -$14(a6)                        ; 0007C
        pea.l   -$114(a6)                       ; 00080
        move.l  fprintf_Format(a6),-(a7)        ; 00084
        jsr     (_pfmt).l                       ; 00088
        lea.l   $10(a7),a7                      ; 0008E
        move.l  d0,-$10(a6)                     ; 00092
        tst.l   d0                              ; 00096
        beq.w   l_108_00010                     ; 00098
        clr.l   -$4(a6)                         ; 0009C
        move.l  d0,fprintf_Format(a6)           ; 000A0
l_108_000A4:
        move.l  -$4(a6),d0                      ; 000A4
        cmp.l   -$c(a6),d0                      ; 000A8
        bge.w   l_108_00010                     ; 000AC
        movea.l fprintf_FP(a6),a0               ; 000B0
        move.l  iob_WCnt(a0),d1                 ; 000B4
        subq.l  #$1,d1                          ; 000B8
        move.l  d1,iob_WCnt(a0)                 ; 000BA
        tst.l   d1                              ; 000BE
        bmi.b   l_108_000D6                     ; 000C0
        movea.l (a0),a1                         ; 000C2
        addq.l  #$1,(a0)                        ; 000C4
        lea.l   -$114(a6),a2                    ; 000C6
        adda.l  d0,a2                           ; 000CA
        move.b  (a2),d0                         ; 000CC
        move.b  d0,(a1)                         ; 000CE
        moveq   #$0,d1                          ; 000D0
        move.b  (a1),d1                         ; 000D2
        bra.b   l_108_000F2                     ; 000D4
l_108_000D6:
        lea.l   -$114(a6),a0                    ; 000D6
        adda.l  -$4(a6),a0                      ; 000DA
        moveq   #$0,d0                          ; 000DE
        move.b  (a0),d0                         ; 000E0
        move.l  fprintf_FP(a6),-(a7)            ; 000E2
        move.l  d0,-(a7)                        ; 000E6
        jsr     (_flsbuf).l                     ; 000E8
        addq.l  #$8,a7                          ; 000EE
        move.l  d0,d1                           ; 000F0
l_108_000F2:
        addq.l  #$1,-$4(a6)                     ; 000F2
        bra.b   l_108_000A4                     ; 000F6
l_108_000F8:
        movea.l fprintf_FP(a6),a0               ; 000F8
        move.l  iob_WCnt(a0),d0                 ; 000FC
        subq.l  #$1,d0                          ; 00100
        move.l  d0,iob_WCnt(a0)                 ; 00102
        tst.l   d0                              ; 00106
        bmi.b   l_108_0011C                     ; 00108
        movea.l (a0),a1                         ; 0010A
        addq.l  #$1,(a0)                        ; 0010C
        move.l  -$8(a6),d0                      ; 0010E
        move.b  d0,(a1)                         ; 00112
        moveq   #$0,d1                          ; 00114
        move.b  (a1),d1                         ; 00116
        bra.w   l_108_00010                     ; 00118
l_108_0011C:
        move.l  fprintf_FP(a6),-(a7)            ; 0011C
        move.l  -$8(a6),-(a7)                   ; 00120
        jsr     (_flsbuf).l                     ; 00124
        addq.l  #$8,a7                          ; 0012A
        move.l  d0,d1                           ; 0012C
        bra.w   l_108_00010                     ; 0012E
l_108_00132:
        move.l  fprintf_FP(a6),-(a7)            ; 00132
        moveq   #-1,d0                          ; 00136
        move.l  d0,-(a7)                        ; 00138
        jsr     (_flsbuf).l                     ; 0013A
        addq.l  #$8,a7                          ; 00140
        movem.l (a7)+,a2                        ; 00142
        unlk    a6                              ; 00146
        rts                                     ; 00148
	dc.b	$00,$00
h108_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    4,120                           ; 4 longs pointing into hunk 120
	dc.l	$70,$EA,$126,$13C
        dc.l    1,144                           ; 1 longs pointing into hunk 144
	dc.l	$8A
	dc.l	0
	dc.l	HUNK_END
	endc
