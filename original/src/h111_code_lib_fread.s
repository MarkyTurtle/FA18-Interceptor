; F/A-18 Interceptor - hunk 111 (code)
; C library: fread.
; Included by ../f18_main.s.

;===============================================================================
; Hunk 111: CODE, $7C bytes
;===============================================================================
	CODE_HUNK	h111

;-------------------------------------------------------------------------------
; fread - fread(buf, size, count, fp): reads size*count bytes one at a time (getc, _filbuf when
; the buffer is empty); returns the number of whole items.
;-------------------------------------------------------------------------------
; fread's frame: arguments from 8(a6), locals below a6 (after its link)
                rsset   8
fread_Buffer            rs.l    1               ; where the items go
fread_Size              rs.l    1               ; an item's size
fread_Count             rs.l    1               ; how many items
fread_FP                rs.l    1               ; the stream
fread_Items             equ     -$4             ; the items read
fread_Byte              equ     -$8             ; the bytes of this item read
fread_Char              equ     -$C             ; the character read (EOF: -1)
fread:
        link.w  a6,#$fff4                       ; 00000
        clr.l   fread_Items(a6)                 ; 00004
l_111_00008:
        move.l  fread_Items(a6),d0              ; 00008
        cmp.l   fread_Count(a6),d0              ; 0000C
        bge.b   l_111_00072                     ; 00010
        clr.l   fread_Byte(a6)                  ; 00012
l_111_00016:
        move.l  fread_Byte(a6),d0               ; 00016
        cmp.l   fread_Size(a6),d0               ; 0001A
        bge.b   l_111_0006C                     ; 0001E
        movea.l fread_FP(a6),a0                 ; 00020
        move.l  iob_RCnt(a0),d0                 ; 00024
        subq.l  #$1,d0                          ; 00028
        move.l  d0,iob_RCnt(a0)                 ; 0002A
        tst.l   d0                              ; 0002E
        bmi.b   l_111_0003C                     ; 00030
        movea.l (a0),a1                         ; 00032
        addq.l  #$1,(a0)                        ; 00034
        moveq   #$0,d0                          ; 00036
        move.b  (a1),d0                         ; 00038
        bra.b   l_111_00048                     ; 0003A
l_111_0003C:
        move.l  fread_FP(a6),-(a7)              ; 0003C
        jsr     (_filbuf).l                     ; 00040
        addq.l  #$4,a7                          ; 00046
l_111_00048:
        move.l  d0,fread_Char(a6)               ; 00048
        addq.l  #$1,d0                          ; 0004C
        bne.b   l_111_00058                     ; 0004E
        move.l  fread_Items(a6),d0              ; 00050
        unlk    a6                              ; 00054
        rts                                     ; 00056
l_111_00058:
        movea.l fread_Buffer(a6),a0             ; 00058
        addq.l  #$1,fread_Buffer(a6)            ; 0005C
        move.l  fread_Char(a6),d0               ; 00060
        move.b  d0,(a0)                         ; 00064
        addq.l  #$1,fread_Byte(a6)              ; 00066
        bra.b   l_111_00016                     ; 0006A
l_111_0006C:
        addq.l  #$1,fread_Items(a6)             ; 0006C
        bra.b   l_111_00008                     ; 00070
l_111_00072:
        move.l  fread_Items(a6),d0              ; 00072
        unlk    a6                              ; 00076
        rts                                     ; 00078
	dc.b	$00,$00
h111_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    1,120                           ; 1 longs pointing into hunk 120
	dc.l	$42
	dc.l	0
	dc.l	HUNK_END
	endc
