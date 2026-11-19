; F/A-18 Interceptor - hunk 99 (code)
; Included by ../f18_main.s.

;===============================================================================
; Hunk 99: CODE, $A0 bytes
;===============================================================================
	CODE_HUNK	h099
sub_099_00000:
        link.w  a6,#$fffc                       ; 00000
        move.l  #$3000,-(a7)                    ; 00004
        clr.l   -(a7)                           ; 0000A
        jsr     (_SetSignal).l                  ; 0000C
        addq.l  #$8,a7                          ; 00012
        andi.l  #$3000,d0                       ; 00014
        move.l  d0,-$4(a6)                      ; 0001A
        tst.l   d0                              ; 0001E
        bne.b   l_099_00028                     ; 00020
        moveq   #$0,d0                          ; 00022
        unlk    a6                              ; 00024
        rts                                     ; 00026
l_099_00028:
        tst.l   (dat_100_00000).l               ; 00028
        beq.b   l_099_00092                     ; 0002E
        moveq   #$5e,d0                         ; 00030
        move.l  d0,-(a7)                        ; 00032
        jsr     (sub_117_0050E).l               ; 00034
        addq.l  #$4,a7                          ; 0003A
        cmpi.l  #$2000,-$4(a6)                  ; 0003C
        bne.b   l_099_0004A                     ; 00044
        moveq   #$44,d0                         ; 00046
        bra.b   l_099_0004C                     ; 00048
l_099_0004A:
        moveq   #$43,d0                         ; 0004A
l_099_0004C:
        move.l  d0,-(a7)                        ; 0004C
        jsr     (sub_117_0050E).l               ; 0004E
        addq.l  #$4,a7                          ; 00054
        moveq   #$a,d0                          ; 00056
        move.l  d0,-(a7)                        ; 00058
        jsr     (sub_117_0050E).l               ; 0005A
        addq.l  #$4,a7                          ; 00060
        clr.l   -$4(a6)                         ; 00062
l_099_00066:
        move.l  -$4(a6),d0                      ; 00066
        cmp.l   (dat_136_00000).l,d0            ; 0006A
        bge.b   l_099_00082                     ; 00070
        move.l  d0,-(a7)                        ; 00072
        jsr     (sub_117_00396).l               ; 00074
        addq.l  #$4,a7                          ; 0007A
        addq.l  #$1,-$4(a6)                     ; 0007C
        bra.b   l_099_00066                     ; 00080
l_099_00082:
        moveq   #$0,d0                          ; 00082
        move.l  d0,-(a7)                        ; 00084
        move.l  d0,-(a7)                        ; 00086
        jsr     (sub_138_00000).l               ; 00088
        addq.l  #$8,a7                          ; 0008E
        bra.b   l_099_0009A                     ; 00090
l_099_00092:
        move.l  -$4(a6),d0                      ; 00092
        unlk    a6                              ; 00096
        rts                                     ; 00098
l_099_0009A:
        unlk    a6                              ; 0009A
        rts                                     ; 0009C
	dc.b	$00,$00
h099_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    1,100                           ; 1 longs pointing into hunk 100
	dc.l	$2A
        dc.l    1,172                           ; 1 longs pointing into hunk 172
	dc.l	$E
        dc.l    4,117                           ; 4 longs pointing into hunk 117
	dc.l	$36,$50,$5C,$76
        dc.l    1,136                           ; 1 longs pointing into hunk 136
	dc.l	$6C
        dc.l    1,138                           ; 1 longs pointing into hunk 138
	dc.l	$8A
	dc.l	0
	dc.l	HUNK_END
	endc
