; F/A-18 Interceptor - hunk 129 (code)
; C library: strcat, strncat.
; Included by ../f18_main.s.

;===============================================================================
; Hunk 129: CODE, $88 bytes
;===============================================================================
	CODE_HUNK	h129

;-------------------------------------------------------------------------------
; strcat - strcat(dst, src).
;-------------------------------------------------------------------------------
; strcat's frame: arguments from 8(a6), locals below a6 (after its link)
                rsset   8
strcat_Dest             rs.l    1               ; the string added to (returned)
strcat_Src              rs.l    1               ; the string added
strcat_End              equ     -$4             ; the next byte of Dest
strcat:
        link.w  a6,#$fffc                       ; 00000
        move.l  strcat_Dest(a6),-(a7)           ; 00004
        jsr     (strlen).l                      ; 00008
        addq.l  #$4,a7                          ; 0000E
        movea.l strcat_Dest(a6),a0              ; 00010
        adda.l  d0,a0                           ; 00014
        move.l  a0,strcat_End(a6)               ; 00016
l_129_0001A:
        movea.l strcat_End(a6),a0               ; 0001A
        addq.l  #$1,strcat_End(a6)              ; 0001E
        movea.l strcat_Src(a6),a1               ; 00022
        move.b  (a1),d0                         ; 00026
        move.b  d0,(a0)                         ; 00028
        addq.l  #$1,strcat_Src(a6)              ; 0002A
        tst.b   d0                              ; 0002E
        bne.b   l_129_0001A                     ; 00030
        move.l  strcat_Dest(a6),d0              ; 00032
        unlk    a6                              ; 00036
        rts                                     ; 00038
; strncat's frame: arguments from 8(a6), locals below a6 (after its link)
                rsset   8
strncat_Dest            rs.l    1               ; the string added to (returned)
strncat_Src             rs.l    1               ; the string added
strncat_Count           rs.l    1               ; at most this many characters
strncat_End             equ     -$4             ; the next byte of Dest
strncat:
        link.w  a6,#$fffc                       ; 0003A
        move.l  strncat_Dest(a6),-(a7)          ; 0003E
        jsr     (strlen).l                      ; 00042
        addq.l  #$4,a7                          ; 00048
        movea.l strncat_Dest(a6),a0             ; 0004A
        adda.l  d0,a0                           ; 0004E
        move.l  a0,strncat_End(a6)              ; 00050
l_129_00054:
        move.l  strncat_Count(a6),d0            ; 00054
        subq.l  #$1,strncat_Count(a6)           ; 00058
        tst.l   d0                              ; 0005C
        ble.b   l_129_0007A                     ; 0005E
        movea.l strncat_Src(a6),a0              ; 00060
        move.b  (a0),d0                         ; 00064
        movea.l strncat_End(a6),a1              ; 00066
        move.b  d0,(a1)                         ; 0006A
        addq.l  #$1,strncat_Src(a6)             ; 0006C
        tst.b   d0                              ; 00070
        beq.b   l_129_0007A                     ; 00072
        addq.l  #$1,strncat_End(a6)             ; 00074
        bra.b   l_129_00054                     ; 00078
l_129_0007A:
        movea.l strncat_End(a6),a0              ; 0007A
        clr.b   (a0)                            ; 0007E
        move.l  strncat_Dest(a6),d0             ; 00080
        unlk    a6                              ; 00084
        rts                                     ; 00086
h129_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    2,132                           ; 2 longs pointing into hunk 132
	dc.l	$A,$44
	dc.l	0
	dc.l	HUNK_END
	endc
