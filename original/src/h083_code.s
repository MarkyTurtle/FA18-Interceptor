; F/A-18 Interceptor - hunk 83 (code)
; Included by ../f18_main.s.

;===============================================================================
; Hunk 83: CODE, $2DC bytes
;===============================================================================
	CODE_HUNK	h083
	dc.b	$4E,$56,$FF,$F0,$42,$AE,$FF,$F8,$42,$AE,$FF,$FC,$20,$2E,$00,$0C
	dc.b	$72,$04,$4E,$B9
        dc.l    sub_152_00000                   ; 00014
	dc.b	$22,$2E,$FF,$FC,$B2,$80,$6C,$7C,$20,$2E,$FF,$F8,$4E,$B9
        dc.l    sub_162_00000                   ; 00026
	dc.b	$20,$6E,$00,$08,$10,$80,$52,$AE,$00,$08,$20,$2E,$00,$0C,$72,$04
	dc.b	$4E,$B9
        dc.l    sub_152_00000                   ; 0003C
	dc.b	$4E,$B9
        dc.l    sub_160_00000                   ; 00042
	dc.b	$4E,$B9
        dc.l    sub_164_00000                   ; 00048
	dc.b	$2F,$40,$00,$00,$20,$3C,$40,$5F,$80,$00,$2F,$41,$00,$04,$72,$00
	dc.b	$24,$2F,$00,$00,$26,$2F,$00,$04,$4E,$B9
        dc.l    sub_153_00000                   ; 00066
	dc.b	$2F,$40,$00,$00,$20,$2E,$FF,$F8,$2F,$41,$00,$04,$4E,$B9
        dc.l    sub_164_00000                   ; 00078
	dc.b	$24,$2F,$00,$00,$26,$2F,$00,$04,$4E,$B9
        dc.l    sub_151_00000                   ; 00086
	dc.b	$4E,$B9
        dc.l    sub_165_00000                   ; 0008C
	dc.b	$2D,$40,$FF,$F8,$52,$AE,$FF,$FC,$60,$00,$FF,$72,$42,$AE,$FF,$FC
	dc.b	$20,$2E,$00,$0C,$72,$02,$4E,$B9
        dc.l    sub_152_00000                   ; 000A8
	dc.b	$22,$2E,$FF,$FC,$B2,$80,$6C,$7C,$20,$2E,$FF,$F8,$4E,$B9
        dc.l    sub_162_00000                   ; 000BA
	dc.b	$20,$6E,$00,$08,$10,$80,$52,$AE,$00,$08,$20,$2E,$00,$0C,$72,$04
	dc.b	$4E,$B9
        dc.l    sub_152_00000                   ; 000D0
	dc.b	$4E,$B9
        dc.l    sub_160_00000                   ; 000D6
	dc.b	$4E,$B9
        dc.l    sub_164_00000                   ; 000DC
	dc.b	$2F,$40,$00,$00,$20,$3C,$40,$5F,$80,$00,$2F,$41,$00,$04,$72,$00
	dc.b	$24,$2F,$00,$00,$26,$2F,$00,$04,$4E,$B9
        dc.l    sub_153_00000                   ; 000FA
	dc.b	$2F,$40,$00,$00,$20,$2E,$FF,$F8,$2F,$41,$00,$04,$4E,$B9
        dc.l    sub_164_00000                   ; 0010C
	dc.b	$24,$2F,$00,$00,$26,$2F,$00,$04,$4E,$B9
        dc.l    sub_151_00008                   ; 0011A
	dc.b	$4E,$B9
        dc.l    sub_165_00000                   ; 00120
	dc.b	$2D,$40,$FF,$F8,$52,$AE,$FF,$FC,$60,$00,$FF,$72,$42,$AE,$FF,$FC
	dc.b	$20,$2E,$00,$0C,$72,$04,$4E,$B9
        dc.l    sub_152_00000                   ; 0013C
	dc.b	$22,$2E,$FF,$FC,$B2,$80,$6C,$7C,$20,$2E,$FF,$F8,$4E,$B9
        dc.l    sub_162_00000                   ; 0014E
	dc.b	$20,$6E,$00,$08,$10,$80,$52,$AE,$00,$08,$20,$2E,$00,$0C,$72,$04
	dc.b	$4E,$B9
        dc.l    sub_152_00000                   ; 00164
	dc.b	$4E,$B9
        dc.l    sub_160_00000                   ; 0016A
	dc.b	$4E,$B9
        dc.l    sub_164_00000                   ; 00170
	dc.b	$2F,$40,$00,$00,$20,$3C,$40,$5F,$80,$00,$2F,$41,$00,$04,$72,$00
	dc.b	$24,$2F,$00,$00,$26,$2F,$00,$04,$4E,$B9
        dc.l    sub_153_00000                   ; 0018E
	dc.b	$2F,$40,$00,$00,$20,$2E,$FF,$F8,$2F,$41,$00,$04,$4E,$B9
        dc.l    sub_164_00000                   ; 001A0
	dc.b	$24,$2F,$00,$00,$26,$2F,$00,$04,$4E,$B9
        dc.l    sub_151_00000                   ; 001AE
	dc.b	$4E,$B9
        dc.l    sub_165_00000                   ; 001B4
	dc.b	$2D,$40,$FF,$F8,$52,$AE,$FF,$FC,$60,$00,$FF,$72,$4E,$5E,$4E,$75
sub_083_001C8:
        link.w  a6,#$fffc                       ; 001C8
        clr.l   -$4(a6)                         ; 001CC
l_083_001D0:
        move.l  $c(a6),d0                       ; 001D0
        moveq   #$2,d1                          ; 001D4
        jsr     (sub_152_00000).l               ; 001D6
        move.l  -$4(a6),d1                      ; 001DC
        cmp.l   d0,d1                           ; 001E0
        bge.b   l_083_001F6                     ; 001E2
        movea.l $8(a6),a0                       ; 001E4
        move.b  #$7f,(a0)                       ; 001E8
        addq.l  #$1,$8(a6)                      ; 001EC
        addq.l  #$1,-$4(a6)                     ; 001F0
        bra.b   l_083_001D0                     ; 001F4
l_083_001F6:
        clr.l   -$4(a6)                         ; 001F6
l_083_001FA:
        move.l  $c(a6),d0                       ; 001FA
        moveq   #$2,d1                          ; 001FE
        jsr     (sub_152_00000).l               ; 00200
        move.l  -$4(a6),d1                      ; 00206
        cmp.l   d0,d1                           ; 0020A
        bge.b   l_083_00220                     ; 0020C
        movea.l $8(a6),a0                       ; 0020E
        move.b  #$82,(a0)                       ; 00212
        addq.l  #$1,$8(a6)                      ; 00216
        addq.l  #$1,-$4(a6)                     ; 0021A
        bra.b   l_083_001FA                     ; 0021E
l_083_00220:
        unlk    a6                              ; 00220
        rts                                     ; 00222
sub_083_00224:
        link.w  a6,#$fffc                       ; 00224
        move.l  (dat_084_00000).l,d0            ; 00228
        andi.l  #$1,d0                          ; 0022E
        move.l  (dat_084_00000).l,d1            ; 00234
        asr.l   #$3,d1                          ; 0023A
        andi.l  #$1,d1                          ; 0023C
        eor.l   d1,d0                           ; 00242
        move.l  (dat_084_00000).l,d1            ; 00244
        asr.l   #$1,d1                          ; 0024A
        andi.l  #$7fffffff,d1                   ; 0024C
        move.l  d1,(dat_084_00000).l            ; 00252
        move.l  d0,-$4(a6)                      ; 00258
        tst.l   d0                              ; 0025C
        beq.b   l_083_0026A                     ; 0025E
        subi.l  #$80000000,(dat_084_00000).l    ; 00260
l_083_0026A:
        move.l  -$4(a6),d0                      ; 0026A
        unlk    a6                              ; 0026E
        rts                                     ; 00270
sub_083_00272:
        link.w  a6,#$fff8                       ; 00272
        clr.l   -$4(a6)                         ; 00276
l_083_0027A:
        move.l  $8(a6),d0                       ; 0027A
        subq.l  #$1,$8(a6)                      ; 0027E
        tst.l   d0                              ; 00282
        ble.b   l_083_0029E                     ; 00284
        move.l  -$4(a6),d0                      ; 00286
        asl.l   #$1,d0                          ; 0028A
        move.l  d0,$0(a7)                       ; 0028C
        bsr.b   sub_083_00224                   ; 00290
        move.l  $0(a7),d1                       ; 00292
        add.l   d0,d1                           ; 00296
        move.l  d1,-$4(a6)                      ; 00298
        bra.b   l_083_0027A                     ; 0029C
l_083_0029E:
        move.l  -$4(a6),d0                      ; 0029E
        unlk    a6                              ; 002A2
        rts                                     ; 002A4
sub_083_002A6:
        link.w  a6,#$fff8                       ; 002A6
        clr.l   -$4(a6)                         ; 002AA
l_083_002AE:
        move.l  -$4(a6),d0                      ; 002AE
        cmp.l   $c(a6),d0                       ; 002B2
        bge.b   l_083_002D8                     ; 002B6
        movea.l $8(a6),a0                       ; 002B8
        addq.l  #$1,$8(a6)                      ; 002BC
        moveq   #$8,d0                          ; 002C0
        move.l  d0,-(a7)                        ; 002C2
        move.l  a0,$4(a7)                       ; 002C4
        bsr.b   sub_083_00272                   ; 002C8
        addq.l  #$4,a7                          ; 002CA
        movea.l $0(a7),a0                       ; 002CC
        move.b  d0,(a0)                         ; 002D0
        addq.l  #$1,-$4(a6)                     ; 002D2
        bra.b   l_083_002AE                     ; 002D6
l_083_002D8:
        unlk    a6                              ; 002D8
        rts                                     ; 002DA
h083_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    5,84                            ; 5 longs pointing into hunk 84
	dc.l	$266,$254,$246,$236,$22A
        dc.l    8,152                           ; 8 longs pointing into hunk 152
	dc.l	$14,$3C,$A8,$D0,$13C,$164,$1D8,$202
        dc.l    3,162                           ; 3 longs pointing into hunk 162
	dc.l	$26,$BA,$14E
        dc.l    3,160                           ; 3 longs pointing into hunk 160
	dc.l	$42,$D6,$16A
        dc.l    6,164                           ; 6 longs pointing into hunk 164
	dc.l	$48,$78,$DC,$10C,$170,$1A0
        dc.l    3,153                           ; 3 longs pointing into hunk 153
	dc.l	$66,$FA,$18E
        dc.l    3,151                           ; 3 longs pointing into hunk 151
	dc.l	$86,$1AE,$11A
        dc.l    3,165                           ; 3 longs pointing into hunk 165
	dc.l	$8C,$120,$1B4
	dc.l	0
	dc.l	HUNK_END
	endc
