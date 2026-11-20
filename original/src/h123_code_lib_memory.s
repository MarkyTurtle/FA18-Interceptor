; F/A-18 Interceptor - hunk 123 (code)
; C library: AllocMemTracked (getmem), sbrk, the memory list.
; Included by ../f18_main.s.

;===============================================================================
; Hunk 123: CODE, $16C bytes
;===============================================================================
	CODE_HUNK	h123

;-------------------------------------------------------------------------------
; AllocMemTracked - Lattice getmem: AllocMem(size+12) and links the block into a list
; (_MemList) so XCEXIT can free everything; returns the memory after the 12-byte header
; (next, prev, size).
;-------------------------------------------------------------------------------
AllocMemTracked:
        link.w  a6,#$fffc                       ; 00000
        move.l  $8(a6),d0                       ; 00004
        addi.l  #$c,d0                          ; 00008
        clr.l   -(a7)                           ; 0000E
        move.l  d0,-(a7)                        ; 00010
        jsr     (_AllocMem).l                   ; 00012
        addq.l  #$8,a7                          ; 00018
        move.l  d0,-$4(a6)                      ; 0001A
        tst.l   d0                              ; 0001E
        bne.b   l_123_00028                     ; 00020
        moveq   #$0,d0                          ; 00022
        unlk    a6                              ; 00024
        rts                                     ; 00026
l_123_00028:
        movea.l -$4(a6),a0                      ; 00028
        exg.l   d0,a0                           ; 0002C
        andi.w  #$fffe,d0                       ; 0002E
        exg.l   d0,a0                           ; 00032
        move.l  $8(a6),d0                       ; 00034
        addi.l  #$c,d0                          ; 00038
        move.l  d0,$8(a0)                       ; 0003E
        move.l  -$4(a6),-(a7)                   ; 00042
        pea.l   (_MemList).l                    ; 00046
        bsr.w   ListAddTail                     ; 0004C
        addq.l  #$8,a7                          ; 00050
        movea.l -$4(a6),a0                      ; 00052
        adda.w  #$c,a0                          ; 00056
        move.l  a0,d0                           ; 0005A
        unlk    a6                              ; 0005C
        rts                                     ; 0005E

;-------------------------------------------------------------------------------
; sbrk - sbrk(size): AllocMemTracked(size), or -1.
;-------------------------------------------------------------------------------
sbrk:
        link.w  a6,#$fffc                       ; 00060
        move.l  $8(a6),-(a7)                    ; 00064
        bsr.b   AllocMemTracked                 ; 00068
        addq.l  #$4,a7                          ; 0006A
        move.l  d0,-$4(a6)                      ; 0006C
        tst.l   d0                              ; 00070
        beq.b   l_123_00078                     ; 00072
        unlk    a6                              ; 00074
        rts                                     ; 00076
l_123_00078:
        movea.l #$ffffffff,a0                   ; 00078
        move.l  a0,d0                           ; 0007E
        unlk    a6                              ; 00080
        rts                                     ; 00082

;-------------------------------------------------------------------------------
; rbrk - Frees every tracked block and clears the heap's variables.
;-------------------------------------------------------------------------------
rbrk:
        bsr.b   FreeAllTracked                  ; 00084
        moveq   #$0,d0                          ; 00086
        move.l  d0,(dat_001_00010).l            ; 00088
        move.l  d0,(dat_001_00008).l            ; 0008E
        move.l  d0,(dat_001_0000C).l            ; 00094
        move.l  d0,(dat_148_00008).l            ; 0009A
        move.l  d0,(dat_148_00000).l            ; 000A0
        move.l  d0,(dat_148_0000C).l            ; 000A6
        move.l  d0,(dat_148_00004).l            ; 000AC
        rts                                     ; 000B2

;-------------------------------------------------------------------------------
; FreeAllTracked - FreeMem every block in the tracked list.
;-------------------------------------------------------------------------------
FreeAllTracked:
        link.w  a6,#$fff8                       ; 000B4
        move.l  (_MemList).l,-$4(a6)            ; 000B8
l_123_000C0:
        tst.l   -$4(a6)                         ; 000C0
        beq.b   l_123_000E4                     ; 000C4
        movea.l -$4(a6),a0                      ; 000C6
        move.l  (a0),-$8(a6)                    ; 000CA
        move.l  $8(a0),-(a7)                    ; 000CE
        move.l  a0,-(a7)                        ; 000D2
        jsr     (_FreeMem).l                    ; 000D4
        addq.l  #$8,a7                          ; 000DA
        move.l  -$8(a6),-$4(a6)                 ; 000DC
        bra.b   l_123_000C0                     ; 000E2
l_123_000E4:
        unlk    a6                              ; 000E4
        rts                                     ; 000E6

;-------------------------------------------------------------------------------
; ListAddTail - Adds a node to the end of a (head, tail) list.
;-------------------------------------------------------------------------------
ListAddTail:
        link.w  a6,#$0                          ; 000E8
        movea.l $8(a6),a1                       ; 000EC
        movea.l $4(a1),a0                       ; 000F0
        movea.l $c(a6),a1                       ; 000F4
        move.l  a0,$4(a1)                       ; 000F8
        suba.l  a0,a0                           ; 000FC
        move.l  a0,(a1)                         ; 000FE
        movea.l $8(a6),a0                       ; 00100
        tst.l   $4(a0)                          ; 00104
        beq.b   l_123_00110                     ; 00108
        movea.l $4(a0),a0                       ; 0010A
        move.l  a1,(a0)                         ; 0010E
l_123_00110:
        movea.l $c(a6),a0                       ; 00110
        movea.l $8(a6),a1                       ; 00114
        move.l  a0,$4(a1)                       ; 00118
        tst.l   (a1)                            ; 0011C
        bne.b   l_123_00122                     ; 0011E
        move.l  a0,(a1)                         ; 00120
l_123_00122:
        unlk    a6                              ; 00122
        rts                                     ; 00124

;-------------------------------------------------------------------------------
; ListRemove - Removes a node from a (head, tail) list.
;-------------------------------------------------------------------------------
ListRemove:
        link.w  a6,#$0                          ; 00126
        movea.l $c(a6),a0                       ; 0012A
        tst.l   (a0)                            ; 0012E
        bne.b   l_123_0013E                     ; 00130
        movea.l $8(a6),a1                       ; 00132
        move.l  $4(a0),$4(a1)                   ; 00136
        bra.b   l_123_0014A                     ; 0013C
l_123_0013E:
        movea.l $c(a6),a1                       ; 0013E
        movea.l (a1),a0                         ; 00142
        move.l  $4(a1),$4(a0)                   ; 00144
l_123_0014A:
        movea.l $c(a6),a0                       ; 0014A
        tst.l   $4(a0)                          ; 0014E
        bne.b   l_123_0015C                     ; 00152
        movea.l $8(a6),a1                       ; 00154
        move.l  (a0),(a1)                       ; 00158
        bra.b   l_123_00166                     ; 0015A
l_123_0015C:
        movea.l $c(a6),a1                       ; 0015C
        movea.l $4(a1),a0                       ; 00160
        move.l  (a1),(a0)                       ; 00164
l_123_00166:
        unlk    a6                              ; 00166
        rts                                     ; 00168
	dc.b	$00,$00
h123_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    2,125                           ; 2 longs pointing into hunk 125
	dc.l	$BA,$48
        dc.l    1,172                           ; 1 longs pointing into hunk 172
	dc.l	$14
        dc.l    3,1                             ; 3 longs pointing into hunk 1
	dc.l	$8A,$90,$96
        dc.l    4,148                           ; 4 longs pointing into hunk 148
	dc.l	$9C,$A8,$A2,$AE
        dc.l    1,172                           ; 1 longs pointing into hunk 172
	dc.l	$D6
	dc.l	0
	dc.l	HUNK_END
	endc
