; F/A-18 Interceptor - hunk 6 (code)
; Included by ../f18_main.s.

;===============================================================================
; Hunk 6: CODE, $1D8 bytes
;===============================================================================
	CODE_HUNK	h006
sub_006_00000:
        move.w  #$90,(dat_071_00354).l          ; 00000
sub_006_00008:
        moveq   #$3,d4                          ; 00008
        move.b  d4,(dat_071_00207).l            ; 0000A
        move.b  d4,(dat_071_00206).l            ; 00010
        move.b  d4,(dat_071_00209).l            ; 00016
        move.b  d4,(dat_071_0020A).l            ; 0001C
        move.b  d4,(dat_071_0020E).l            ; 00022
        move.b  d4,(dat_071_0020F).l            ; 00028
        move.b  d4,(dat_071_00210).l            ; 0002E
        move.b  d4,(dat_071_00211).l            ; 00034
        move.b  d4,(dat_071_0020B).l            ; 0003A
        move.b  d4,(dat_071_0020D).l            ; 00040
        move.b  d4,(dat_071_00213).l            ; 00046
        move.b  d4,(dat_071_00214).l            ; 0004C
        move.b  d4,(dat_071_00215).l            ; 00052
        move.b  d4,(dat_071_0020C).l            ; 00058
        tst.b   (dat_071_00190).l               ; 0005E
        bne.b   l_006_00072                     ; 00064
        clr.w   (dat_071_002A8).l               ; 00066
        clr.l   (dat_071_002E8).l               ; 0006C
l_006_00072:
        rts                                     ; 00072
sub_006_00074:
        bset    #$7,(dat_071_001AD).l           ; 00074
        move.w  #$80,(dat_071_00412).l          ; 0007C
        move.b  #$3,(dat_071_0020D).l           ; 00084
        rts                                     ; 0008C
sub_006_0008E:
        move.b  (dat_071_00BD0).l,d4            ; 0008E
        andi.b  #$f,d4                          ; 00094
        bne.b   l_006_000B4                     ; 00098
        cmpi.b  #$7d,(dat_071_00276).l          ; 0009A
        bne.b   l_006_000B6                     ; 000A2
        tst.b   (dat_071_0016A).l               ; 000A4
        bge.b   l_006_000B4                     ; 000AA
        bset    #$3,(dat_071_01356).l           ; 000AC
l_006_000B4:
        rts                                     ; 000B4
l_006_000B6:
        bset    #$2,(dat_071_0036A).l           ; 000B6
        move.b  (dat_071_00BB7).l,d4            ; 000BE
        andi.b  #$f0,d4                         ; 000C4
        beq.b   l_006_000D8                     ; 000C8
        cmpi.b  #$10,d4                         ; 000CA
        beq.b   l_006_000DA                     ; 000CE
        move.b  #$1,(dat_071_0018A).l           ; 000D0
l_006_000D8:
        rts                                     ; 000D8
l_006_000DA:
        ori.w   #$8,(dat_071_00296).l           ; 000DA
        rts                                     ; 000E2
sub_006_000E4:
        bset    #$3,(dat_071_0036A).l           ; 000E4
        andi.w  #$fff7,(dat_071_00296).l        ; 000EC
        rts                                     ; 000F4
sub_006_000F6:
        movem.l d4/d7/a1,-(a7)                  ; 000F6
        move.b  #$1,d7                          ; 000FA
        bra.b   l_006_00106                     ; 000FE
	dc.b	$48,$E7,$09,$40,$42,$07
l_006_00106:
        lea.l   (ObjectTable).l,a1              ; 00106
        adda.w  (dat_071_00386).l,a1            ; 0010C
        btst    #$7,$3(a1)                      ; 00112
        bne.b   l_006_0012C                     ; 00118
        tst.b   d7                              ; 0011A
        bne.b   l_006_00126                     ; 0011C
        bclr    #$7,$7c(a1)                     ; 0011E
        bra.b   l_006_0012C                     ; 00124
l_006_00126:
        bset    #$7,$7c(a1)                     ; 00126
l_006_0012C:
        movem.l (a7)+,d4/d7/a1                  ; 0012C
        rts                                     ; 00130
sub_006_00132:
        swap    d0                              ; 00132
        move.w  #$4005,d0                       ; 00134
        jsr     (sub_020_00954).l               ; 00138
        swap    d0                              ; 0013E
        cmpi.b  #$6,(dat_071_00276).l           ; 00140
        bne.b   sub_006_0015E                   ; 00148
        move.b  (dat_071_00168).l,d3            ; 0014A
        subq.b  #$1,d3                          ; 00150
        beq.b   sub_006_0015E                   ; 00152
        addq.b  #$2,d3                          ; 00154
        beq.b   sub_006_0015E                   ; 00156
        clr.b   (dat_071_00168).l               ; 00158
sub_006_0015E:
        move.l  #$61a800,(dat_071_00BC6).l      ; 0015E
        move.b  #$24,(dat_071_00BB3).l          ; 00168
        move.w  #$1f4,(dat_071_00BB4).l         ; 00170
        move.b  #$3,(dat_071_00213).l           ; 00178
        move.b  #$3,(dat_071_00214).l           ; 00180
        move.b  #$10,(dat_071_0021C).l          ; 00188
        move.b  #$10,(dat_071_0021D).l          ; 00190
        clr.b   (dat_071_0025B).l               ; 00198
        clr.b   (dat_071_0025D).l               ; 0019E
        clr.b   (dat_071_0025C).l               ; 001A4
        clr.w   (dat_071_00292).l               ; 001AA
        movem.l d0/d4/a0-a1,-(a7)               ; 001B0
        lea.l   (ObjectTable).l,a0              ; 001B4
        adda.w  #$200,a0                        ; 001BA
        moveq   #$2,d0                          ; 001BE
l_006_001C0:
        moveq   #$28,d4                         ; 001C0
        lea.l   (a0),a1                         ; 001C2
l_006_001C4:
        clr.l   (a1)+                           ; 001C4
        dbra    d4,l_006_001C4                  ; 001C6
        adda.w  #$200,a0                        ; 001CA
        dbra    d0,l_006_001C0                  ; 001CE
        movem.l (a7)+,d0/d4/a0-a1               ; 001D2
        rts                                     ; 001D6
h006_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    48,71                           ; 48 longs pointing into hunk 71
	dc.l	$1AC,$1A6,$1A0,$19A,$A6,$DE,$F0,$D4
	dc.l	$BA,$E8,$14C,$15A,$9E,$144,$10E,$B0
	dc.l	$90,$C0,$164,$16C,$174,$108,$1B6,$80
	dc.l	$78,$6E,$68,$4,$60,$194,$18C,$5A
	dc.l	$54,$4E,$184,$48,$17C,$42,$88,$3C
	dc.l	$36,$30,$2A,$24,$1E,$18,$12,$C
        dc.l    1,20                            ; 1 longs pointing into hunk 20
	dc.l	$13A
	dc.l	0
	dc.l	HUNK_END
	endc
