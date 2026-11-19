; F/A-18 Interceptor - hunk 158 (code)
; Included by ../f18_main.s.

;===============================================================================
; Hunk 158: CODE, $A8 bytes
;===============================================================================
	CODE_HUNK	h158

;-------------------------------------------------------------------------------
; fp_SingleUnpack - Unpacks an IEEE single (d0): d0 = mantissa (normalised, bit 31 set), d1 =
; sign and exponent.
;-------------------------------------------------------------------------------
fp_SingleUnpack:
        move.l  d0,d1                           ; 00000
        and.l   #$7fffffff,d0                   ; 00002
        beq.b   l_158_00020                     ; 00008
        swap    d1                              ; 0000A
        ext.l   d1                              ; 0000C
        and.l   #$80007fff,d1                   ; 0000E
        lsr.w   #$7,d1                          ; 00014
        sub.w   #$7f,d1                         ; 00016
        lsl.l   #$8,d0                          ; 0001A
        bset    #$1f,d0                         ; 0001C
l_158_00020:
        rts                                     ; 00020

;-------------------------------------------------------------------------------
; fp_SinglePack - Packs mantissa d0 / exponent d1 into an IEEE single (rounds; SetFPErr on
; under/overflow).
;-------------------------------------------------------------------------------
fp_SinglePack:
        move.l  d2,-(a7)                        ; 00022
        tst.l   d0                              ; 00024
        beq.b   l_158_00074                     ; 00026
        subq.w  #$8,d1                          ; 00028
l_158_0002A:
        move.l  d0,-(a7)                        ; 0002A
        andi.l  #$ff000000,(a7)+                ; 0002C
        beq.b   l_158_00050                     ; 00032
l_158_00034:
        addq.w  #$1,d1                          ; 00034
        lsr.l   #$1,d0                          ; 00036
        roxr.l  #$1,d2                          ; 00038
        move.l  d0,-(a7)                        ; 0003A
        andi.l  #$ff000000,(a7)+                ; 0003C
        bne.b   l_158_00034                     ; 00042
        tst.l   d2                              ; 00044
        bpl.b   l_158_00050                     ; 00046
        addq.l  #$1,d0                          ; 00048
        bra.b   l_158_0002A                     ; 0004A
l_158_0004C:
        subq.w  #$1,d1                          ; 0004C
        lsl.l   #$1,d0                          ; 0004E
l_158_00050:
        btst    #$17,d0                         ; 00050
        beq.b   l_158_0004C                     ; 00054
        add.w   #$7f,d1                         ; 00056
        ble.b   l_158_00078                     ; 0005A
        cmp.w   #$ff,d1                         ; 0005C
        bge.b   l_158_00088                     ; 00060
        bclr    #$17,d0                         ; 00062
        lsl.w   #$7,d1                          ; 00066
        move.w  d1,-(a7)                        ; 00068
        swap    d1                              ; 0006A
        or.w    (a7)+,d1                        ; 0006C
        swap    d1                              ; 0006E
        clr.w   d1                              ; 00070
        or.l    d1,d0                           ; 00072
l_158_00074:
        move.l  (a7)+,d2                        ; 00074
        rts                                     ; 00076
l_158_00078:
        move.l  #$1,-(a7)                       ; 00078
        jsr     (SetFPErr).l                    ; 0007E
        clr.l   d0                              ; 00084
        bra.b   l_158_000A2                     ; 00086
l_158_00088:
        move.l  #$2,-(a7)                       ; 00088
        jsr     (SetFPErr).l                    ; 0008E
        move.l  #$7f800000,d0                   ; 00094
        tst.l   d1                              ; 0009A
        bpl.b   l_158_000A2                     ; 0009C
        bset    #$1f,d0                         ; 0009E
l_158_000A2:
        lea.l   $4(a7),a7                       ; 000A2
        bra.b   l_158_00074                     ; 000A6
h158_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    2,155                           ; 2 longs pointing into hunk 155
	dc.l	$80,$90
	dc.l	0
	dc.l	HUNK_END
	endc
