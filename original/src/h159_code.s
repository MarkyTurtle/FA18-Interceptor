; F/A-18 Interceptor - hunk 159 (code)
; Included by ../f18_main.s.

;===============================================================================
; Hunk 159: CODE, $D8 bytes
;===============================================================================
	CODE_HUNK	h159
sub_159_00000:
        move.l  d0,d2                           ; 00000
        and.l   #$7fffffff,d0                   ; 00002
        bne.b   l_159_00012                     ; 00008
        moveq   #$0,d0                          ; 0000A
        moveq   #$0,d1                          ; 0000C
        moveq   #$0,d2                          ; 0000E
        bra.b   l_159_00034                     ; 00010
l_159_00012:
        swap    d2                              ; 00012
        ext.l   d2                              ; 00014
        asr.w   #$4,d2                          ; 00016
        and.l   #$800007ff,d2                   ; 00018
        sub.w   #$3ff,d2                        ; 0001E
        move.l  d2,-(a7)                        ; 00022
        moveq   #$a,d2                          ; 00024
l_159_00026:
        lsl.l   #$1,d1                          ; 00026
        roxl.l  #$1,d0                          ; 00028
        dbra    d2,l_159_00026                  ; 0002A
        bset    #$1f,d0                         ; 0002E
        move.l  (a7)+,d2                        ; 00032
l_159_00034:
        rts                                     ; 00034
sub_159_00036:
        move.l  d3,-(a7)                        ; 00036
        move.l  d0,-(a7)                        ; 00038
        or.l    d1,(a7)+                        ; 0003A
        beq.b   l_159_000A2                     ; 0003C
        sub.w   #$b,d2                          ; 0003E
        tst.l   d0                              ; 00042
        bne.b   l_159_0004E                     ; 00044
        move.l  d1,d0                           ; 00046
        clr.l   d1                              ; 00048
        sub.w   #$20,d2                         ; 0004A
l_159_0004E:
        move.l  d0,-(a7)                        ; 0004E
        andi.l  #$ffe00000,(a7)+                ; 00050
        beq.b   l_159_0007C                     ; 00056
l_159_00058:
        addq.w  #$1,d2                          ; 00058
        lsr.l   #$1,d0                          ; 0005A
        roxr.l  #$1,d1                          ; 0005C
        roxr.l  #$1,d3                          ; 0005E
        move.l  d0,-(a7)                        ; 00060
        andi.l  #$ffe00000,(a7)+                ; 00062
        bne.b   l_159_00058                     ; 00068
        tst.l   d3                              ; 0006A
        bpl.b   l_159_0007C                     ; 0006C
        addq.l  #$1,d1                          ; 0006E
        bcc.b   l_159_0007C                     ; 00070
        addq.l  #$1,d0                          ; 00072
        bra.b   l_159_0004E                     ; 00074
l_159_00076:
        subq.w  #$1,d2                          ; 00076
        lsl.l   #$1,d1                          ; 00078
        roxl.l  #$1,d0                          ; 0007A
l_159_0007C:
        btst    #$14,d0                         ; 0007C
        beq.b   l_159_00076                     ; 00080
        add.w   #$3ff,d2                        ; 00082
        ble.b   l_159_000A6                     ; 00086
        cmp.w   #$7ff,d2                        ; 00088
        bge.b   l_159_000B6                     ; 0008C
        and.l   #$fffff,d0                      ; 0008E
        lsl.w   #$4,d2                          ; 00094
        move.w  d2,-(a7)                        ; 00096
        clr.w   d2                              ; 00098
        swap    d2                              ; 0009A
        or.w    (a7)+,d2                        ; 0009C
        swap    d2                              ; 0009E
        or.l    d2,d0                           ; 000A0
l_159_000A2:
        move.l  (a7)+,d3                        ; 000A2
        rts                                     ; 000A4
l_159_000A6:
        move.l  #$1,-(a7)                       ; 000A6
        jsr     (sub_155_00000).l               ; 000AC
        moveq   #$0,d0                          ; 000B2
        bra.b   l_159_000CE                     ; 000B4
l_159_000B6:
        move.l  #$2,-(a7)                       ; 000B6
        jsr     (sub_155_00000).l               ; 000BC
        move.w  #$7ff0,d0                       ; 000C2
        swap    d2                              ; 000C6
        or.w    d2,d0                           ; 000C8
        swap    d0                              ; 000CA
        clr.w   d0                              ; 000CC
l_159_000CE:
        lea.l   $4(a7),a7                       ; 000CE
        moveq   #$0,d1                          ; 000D2
        bra.b   l_159_000A2                     ; 000D4
	dc.b	$00,$00
h159_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    2,155                           ; 2 longs pointing into hunk 155
	dc.l	$AE,$BE
	dc.l	0
	dc.l	HUNK_END
	endc
