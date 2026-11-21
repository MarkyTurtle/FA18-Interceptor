; F/A-18 Interceptor - hunk 126 (code)
; C library: malloc, free.
; Included by ../f18_main.s.

;===============================================================================
; Hunk 126: CODE, $284 bytes
;===============================================================================
	CODE_HUNK	h126

;-------------------------------------------------------------------------------
; MemUsed - The memory used (MemoryUsed x 8).
;-------------------------------------------------------------------------------
MemUsed:
        link.w  a6,#$fffc                       ; 00000
        move.l  (MemoryUsed).l,d0               ; 00004
        asl.l   #$3,d0                          ; 0000A
        unlk    a6                              ; 0000C
        rts                                     ; 0000E
; malloc's frame: arguments from 8(a6), locals below a6 (after its link)
                rsset   8
malloc_Size             rs.l    1               ; the bytes wanted
malloc_Size2            equ     -$4             ; the size (kept)
malloc:
        link.w  a6,#$fffc                       ; 00010
        move.l  malloc_Size(a6),d0              ; 00014
        move.l  d0,-(a7)                        ; 00018
        move.l  d0,malloc_Size2(a6)             ; 0001A
        bsr.b   _malloc                         ; 0001E
        addq.l  #$4,a7                          ; 00020
        unlk    a6                              ; 00022
        rts                                     ; 00024

;-------------------------------------------------------------------------------
; _malloc - The allocator: first fit from the free list (8-byte units); grows the heap by
; _MSTEP with AllocMemTracked when nothing fits.
;-------------------------------------------------------------------------------
; _malloc's frame: arguments from 8(a6), locals below a6 (after its link)
                rsset   8
_malloc_Size            rs.l    1               ; the bytes wanted
_malloc_Block           equ     -$4             ; the free block looked at
_malloc_Prev            equ     -$8             ; the one before it
_malloc_NewBlock        equ     -$C             ; what AllocMemTracked returned
_malloc_Units           equ     -$10            ; the size wanted, in 8-byte units
_malloc_Grow            equ     -$14            ; the size to get from the system (rounded up to _MSTEP)
_malloc:
        link.w  a6,#$ffec                       ; 00026
        tst.l   _malloc_Size(a6)                ; 0002A
        bgt.b   l_126_00036                     ; 0002E
        moveq   #$0,d0                          ; 00030
        unlk    a6                              ; 00032
        rts                                     ; 00034
l_126_00036:
        move.l  _malloc_Size(a6),d0             ; 00036
        addq.l  #$7,d0                          ; 0003A
        moveq   #$8,d1                          ; 0003C
        jsr     (CXD33).l                       ; 0003E
        move.l  #RbrkData6,_malloc_Prev(a6)     ; 00044
        movea.l _malloc_Prev(a6),a0             ; 0004C
        move.l  (a0),_malloc_Block(a6)          ; 00050
        move.l  d0,_malloc_Units(a6)            ; 00054
l_126_00058:
        tst.l   _malloc_Block(a6)               ; 00058
        beq.b   l_126_000B4                     ; 0005C
        move.l  _malloc_Units(a6),d0            ; 0005E
        movea.l _malloc_Block(a6),a0            ; 00062
        move.l  $4(a0),d1                       ; 00066
        cmp.l   d0,d1                           ; 0006A
        bcs.b   l_126_000A4                     ; 0006C
        cmp.l   d0,d1                           ; 0006E
        bne.b   l_126_0007A                     ; 00070
        movea.l _malloc_Prev(a6),a1             ; 00072
        move.l  (a0),(a1)                       ; 00076
        bra.b   l_126_00090                     ; 00078
l_126_0007A:
        movea.l _malloc_Block(a6),a0            ; 0007A
        move.l  $4(a0),d0                       ; 0007E
        sub.l   _malloc_Units(a6),d0            ; 00082
        move.l  d0,$4(a0)                       ; 00086
        asl.l   #$3,d0                          ; 0008A
        add.l   d0,_malloc_Block(a6)            ; 0008C
l_126_00090:
        move.l  _malloc_Units(a6),d0            ; 00090
        sub.l   d0,(MemoryUsed).l               ; 00094
        movea.l _malloc_Block(a6),a0            ; 0009A
        move.l  a0,d0                           ; 0009E
        unlk    a6                              ; 000A0
        rts                                     ; 000A2
l_126_000A4:
        move.l  _malloc_Block(a6),_malloc_Prev(a6) ; 000A4
        movea.l _malloc_Block(a6),a0            ; 000AA
        move.l  (a0),_malloc_Block(a6)          ; 000AE
        bra.b   l_126_00058                     ; 000B2
l_126_000B4:
        move.l  _malloc_Units(a6),d0            ; 000B4
        asl.l   #$3,d0                          ; 000B8
        move.l  (_MSTEP).l,d1                   ; 000BA
        add.l   d1,d0                           ; 000C0
        subq.l  #$1,d0                          ; 000C2
        jsr     (CXD33).l                       ; 000C4
        move.l  (_MSTEP).l,d1                   ; 000CA
        jsr     (CXM33).l                       ; 000D0
        move.l  d0,-(a7)                        ; 000D6
        move.l  d0,_malloc_Grow(a6)             ; 000D8
        jsr     (AllocMemTracked).l             ; 000DC
        addq.l  #$4,a7                          ; 000E2
        move.l  d0,_malloc_NewBlock(a6)         ; 000E4
        tst.l   d0                              ; 000E8
        beq.b   l_126_00104                     ; 000EA
        move.l  _malloc_Grow(a6),-(a7)          ; 000EC
        move.l  d0,-(a7)                        ; 000F0
        bsr.b   free                            ; 000F2
        addq.l  #$8,a7                          ; 000F4
        move.l  _malloc_Size(a6),-(a7)          ; 000F6
        bsr.w   _malloc                         ; 000FA
        addq.l  #$4,a7                          ; 000FE
        unlk    a6                              ; 00100
        rts                                     ; 00102
l_126_00104:
        moveq   #$0,d0                          ; 00104
        unlk    a6                              ; 00106
        rts                                     ; 00108

;-------------------------------------------------------------------------------
; free - free(block, size).
;-------------------------------------------------------------------------------
; free's frame: arguments from 8(a6), locals below a6 (after its link)
                rsset   8
free_Block              rs.l    1               ; the block
free_Size               rs.l    1               ; its size
free_Size2              equ     -$4             ; the size (kept)
free:
        link.w  a6,#$fffc                       ; 0010A
        move.l  free_Size(a6),d0                ; 0010E
        move.l  d0,-(a7)                        ; 00112
        move.l  free_Block(a6),-(a7)            ; 00114
        move.l  d0,free_Size2(a6)               ; 00118
        bsr.b   _free                           ; 0011C
        addq.l  #$8,a7                          ; 0011E
        unlk    a6                              ; 00120
        rts                                     ; 00122

;-------------------------------------------------------------------------------
; _free - Puts a block back on the free list, merging it with its neighbours.
;-------------------------------------------------------------------------------
; _free's frame: arguments from 8(a6), locals below a6 (after its link)
                rsset   8
_free_Block             rs.l    1               ; the block
_free_Size              rs.l    1               ; its size
_free_Free              equ     -$4             ; the free block looked at
_free_FreeEnd           equ     -$8             ; its end
_free_Prev              equ     -$C             ; the one before it
_free_PrevEnd           equ     -$10            ; its end
_free_End               equ     -$14            ; the freed block's end
_free_Start             equ     -$18            ; the freed block
_free_Units             equ     -$1C            ; its size in 8-byte units
_free:
        link.w  a6,#$ffe4                       ; 00124
        tst.l   _free_Size(a6)                  ; 00128
        bgt.b   l_126_00134                     ; 0012C
        moveq   #-1,d0                          ; 0012E
        unlk    a6                              ; 00130
        rts                                     ; 00132
l_126_00134:
        movea.l _free_Block(a6),a0              ; 00134
        exg.l   d0,a0                           ; 00138
        andi.w  #$fffe,d0                       ; 0013A
        exg.l   d0,a0                           ; 0013E
        move.l  _free_Size(a6),d0               ; 00140
        addq.l  #$7,d0                          ; 00144
        moveq   #$8,d1                          ; 00146
        jsr     (CXD33).l                       ; 00148
        move.l  d0,_free_Units(a6)              ; 0014E
        asl.l   #$3,d0                          ; 00152
        move.l  a0,_free_End(a6)                ; 00154
        adda.l  d0,a0                           ; 00158
        move.l  _free_Units(a6),d0              ; 0015A
        add.l   d0,(MemoryUsed).l               ; 0015E
        move.l  #RbrkData6,_free_Prev(a6)       ; 00164
        movea.l _free_Prev(a6),a1               ; 0016C
        move.l  (a1),_free_Free(a6)             ; 00170
        move.l  a0,_free_Start(a6)              ; 00174
l_126_00178:
        tst.l   _free_Free(a6)                  ; 00178
        beq.w   l_126_00266                     ; 0017C
        movea.l _free_Free(a6),a0               ; 00180
        move.l  $4(a0),d0                       ; 00184
        asl.l   #$3,d0                          ; 00188
        adda.l  d0,a0                           ; 0018A
        move.l  a0,_free_FreeEnd(a6)            ; 0018C
        movea.l _free_Free(a6),a0               ; 00190
        cmpa.l  _free_Start(a6),a0              ; 00194
        bls.b   l_126_001B2                     ; 00198
        movea.l _free_End(a6),a1                ; 0019A
        move.l  a0,(a1)                         ; 0019E
        move.l  _free_Units(a6),$4(a1)          ; 001A0
        movea.l _free_Prev(a6),a0               ; 001A6
        move.l  a1,(a0)                         ; 001AA
        moveq   #$0,d0                          ; 001AC
        unlk    a6                              ; 001AE
        rts                                     ; 001B0
l_126_001B2:
        movea.l _free_Free(a6),a0               ; 001B2
        cmpa.l  _free_Start(a6),a0              ; 001B6
        bne.b   l_126_001DA                     ; 001BA
        movea.l _free_End(a6),a1                ; 001BC
        move.l  (a0),(a1)                       ; 001C0
        move.l  _free_Units(a6),d0              ; 001C2
        add.l   $4(a0),d0                       ; 001C6
        move.l  d0,$4(a1)                       ; 001CA
        movea.l _free_Prev(a6),a0               ; 001CE
        move.l  a1,(a0)                         ; 001D2
        moveq   #$0,d0                          ; 001D4
        unlk    a6                              ; 001D6
        rts                                     ; 001D8
l_126_001DA:
        movea.l _free_End(a6),a0                ; 001DA
        cmpa.l  _free_FreeEnd(a6),a0            ; 001DE
        bcc.b   l_126_001F4                     ; 001E2
        move.l  _free_Units(a6),d0              ; 001E4
        sub.l   d0,(MemoryUsed).l               ; 001E8
        moveq   #-1,d0                          ; 001EE
        unlk    a6                              ; 001F0
        rts                                     ; 001F2
l_126_001F4:
        movea.l _free_End(a6),a0                ; 001F4
        cmpa.l  _free_FreeEnd(a6),a0            ; 001F8
        bne.b   l_126_0024E                     ; 001FC
        movea.l _free_Free(a6),a0               ; 001FE
        tst.l   (a0)                            ; 00202
        beq.b   l_126_00222                     ; 00204
        movea.l _free_Start(a6),a0              ; 00206
        movea.l _free_Free(a6),a1               ; 0020A
        cmpa.l  (a1),a0                         ; 0020E
        bls.b   l_126_00222                     ; 00210
        move.l  _free_Units(a6),d0              ; 00212
        sub.l   d0,(MemoryUsed).l               ; 00216
        moveq   #-1,d0                          ; 0021C
        unlk    a6                              ; 0021E
        rts                                     ; 00220
l_126_00222:
        move.l  _free_Units(a6),d0              ; 00222
        movea.l _free_Free(a6),a0               ; 00226
        add.l   d0,$4(a0)                       ; 0022A
        tst.l   (a0)                            ; 0022E
        beq.b   l_126_00248                     ; 00230
        movea.l _free_Start(a6),a0              ; 00232
        movea.l _free_Free(a6),a1               ; 00236
        cmpa.l  (a1),a0                         ; 0023A
        bne.b   l_126_00248                     ; 0023C
        move.l  $4(a0),d0                       ; 0023E
        add.l   d0,$4(a1)                       ; 00242
        move.l  (a0),(a1)                       ; 00246
l_126_00248:
        moveq   #$0,d0                          ; 00248
        unlk    a6                              ; 0024A
        rts                                     ; 0024C
l_126_0024E:
        move.l  _free_Free(a6),_free_Prev(a6)   ; 0024E
        move.l  _free_FreeEnd(a6),_free_PrevEnd(a6) ; 00254
        movea.l _free_Free(a6),a0               ; 0025A
        move.l  (a0),_free_Free(a6)             ; 0025E
        bra.w   l_126_00178                     ; 00262
l_126_00266:
        movea.l _free_Prev(a6),a0               ; 00266
        move.l  _free_End(a6),(a0)              ; 0026A
        suba.l  a0,a0                           ; 0026E
        movea.l _free_End(a6),a1                ; 00270
        move.l  a0,(a1)                         ; 00274
        move.l  _free_Units(a6),$4(a1)          ; 00276
        move.l  a0,d0                           ; 0027C
        unlk    a6                              ; 0027E
        rts                                     ; 00280
	dc.b	$00,$00
h126_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    7,148                           ; 7 longs pointing into hunk 148
	dc.l	$6,$46,$96,$160,$166,$1EA,$218
        dc.l    3,152                           ; 3 longs pointing into hunk 152
	dc.l	$40,$C6,$14A
        dc.l    2,1                             ; 2 longs pointing into hunk 1
	dc.l	$BC,$CC
        dc.l    1,154                           ; 1 longs pointing into hunk 154
	dc.l	$D2
        dc.l    1,123                           ; 1 longs pointing into hunk 123
	dc.l	$DE
	dc.l	0
	dc.l	HUNK_END
	endc
