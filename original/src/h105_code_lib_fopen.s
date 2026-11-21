; F/A-18 Interceptor - hunk 105 (code)
; C library: fopen, freopen, fclose.
; Included by ../f18_main.s.

;===============================================================================
; Hunk 105: CODE, $2C8 bytes
;===============================================================================
	CODE_HUNK	h105

;-------------------------------------------------------------------------------
; fopen - fopen(name, mode): takes the first free FILE of _iob (20, 24 bytes each) and opens it
; with freopen.
;-------------------------------------------------------------------------------
; fopen's frame: arguments from 8(a6), locals below a6 (after its link)
                rsset   8
fopen_Name              rs.l    1               ; the file's name
fopen_Mode              rs.l    1               ; the mode string ("r", "w", "a"...)
fopen_FP                equ     -$4             ; the free FILE found
fopen:
        link.w  a6,#$fff8                       ; 00000
        move.l  #_iob,fopen_FP(a6)              ; 00004
l_105_0000C:
        movea.l fopen_FP(a6),a0                 ; 0000C
        cmpa.l  #h143_end,a0                    ; 00010
        bcc.b   l_105_0002A                     ; 00016
        move.b  $10(a0),d0                      ; 00018
        tst.b   d0                              ; 0001C
        beq.b   l_105_0002A                     ; 0001E
        addi.l  #$18,fopen_FP(a6)               ; 00020
        bra.b   l_105_0000C                     ; 00028
l_105_0002A:
        movea.l fopen_FP(a6),a0                 ; 0002A
        cmpa.l  #h143_end,a0                    ; 0002E
        bne.b   l_105_0003C                     ; 00034
        moveq   #$0,d0                          ; 00036
        unlk    a6                              ; 00038
        rts                                     ; 0003A
l_105_0003C:
        move.l  fopen_FP(a6),-(a7)              ; 0003C
        move.l  fopen_Mode(a6),-(a7)            ; 00040
        move.l  fopen_Name(a6),-(a7)            ; 00044
        bsr.b   freopen                         ; 00048
        lea.l   $c(a7),a7                       ; 0004A
        unlk    a6                              ; 0004E
        rts                                     ; 00050

;-------------------------------------------------------------------------------
; freopen - freopen(name, mode, fp): mode r/w/a, + and b; opens the file with open() and fills
; in the FILE.
;-------------------------------------------------------------------------------
; freopen's frame: arguments from 8(a6), locals below a6 (after its link)
                rsset   8
freopen_Name            rs.l    1               ; the file's name
freopen_Mode            rs.l    1               ; the mode string
freopen_FP              rs.l    1               ; the FILE to open it on
freopen_IOBFlags        equ     -$1             ; the FILE's new flags
freopen_Access          equ     -$4             ; 0 read, 1 write, 2 both (open's mode)
freopen_FD              equ     -$8             ; what open returned
freopen_Translate       equ     -$C             ; _fmode (FreopenData1) by default; 0 or $8000 from the mode's letters
freopen_ModePtr         equ     -$10            ; the next character of Mode
freopen_Char            equ     -$11            ; the mode's character
freopen:
        link.w  a6,#$ffea                       ; 00052
        movea.l freopen_FP(a6),a0               ; 00056
        tst.b   iob_Flag(a0)                    ; 0005A
        beq.b   l_105_00068                     ; 0005E
        move.l  a0,-(a7)                        ; 00060
        bsr.w   fclose                          ; 00062
        addq.l  #$4,a7                          ; 00066
l_105_00068:
        move.l  (FreopenData1).l,freopen_Translate(a6) ; 00068
        move.l  freopen_Mode(a6),freopen_ModePtr(a6) ; 00070
        moveq   #$0,d0                          ; 00076
        movea.l freopen_ModePtr(a6),a0          ; 00078
        move.b  $1(a0),d0                       ; 0007C
        cmpi.l  #$62,d0                         ; 00080
        beq.b   l_105_00096                     ; 00086
        cmpi.l  #$61,d0                         ; 00088
        bne.b   l_105_000A2                     ; 0008E
        clr.l   freopen_Translate(a6)           ; 00090
        bra.b   l_105_0009E                     ; 00094
l_105_00096:
        move.l  #$8000,freopen_Translate(a6)    ; 00096
l_105_0009E:
        addq.l  #$1,freopen_ModePtr(a6)         ; 0009E
l_105_000A2:
        movea.l freopen_ModePtr(a6),a0          ; 000A2
        move.b  $1(a0),d0                       ; 000A6
        cmpi.b  #$2b,d0                         ; 000AA
        seq.b   d1                              ; 000AE
        neg.b   d1                              ; 000B0
        ext.w   d1                              ; 000B2
        ext.l   d1                              ; 000B4
        moveq   #$0,d0                          ; 000B6
        movea.l freopen_Mode(a6),a0             ; 000B8
        move.b  (a0),d0                         ; 000BC
        move.b  d1,freopen_Char(a6)             ; 000BE
        cmpi.l  #$77,d0                         ; 000C2
        beq.w   l_105_0019A                     ; 000C8
        cmpi.l  #$72,d0                         ; 000CC
        beq.w   l_105_00156                     ; 000D2
        cmpi.l  #$61,d0                         ; 000D6
        bne.w   l_105_001F2                     ; 000DC
        move.l  freopen_Translate(a6),d0        ; 000E0
        ori.l   #$8,d0                          ; 000E4
        move.l  d0,$0(a7)                       ; 000EA
        tst.b   freopen_Char(a6)                ; 000EE
        beq.b   l_105_000F8                     ; 000F2
        moveq   #$2,d1                          ; 000F4
        bra.b   l_105_000FA                     ; 000F6
l_105_000F8:
        moveq   #$1,d1                          ; 000F8
l_105_000FA:
        move.l  $0(a7),d0                       ; 000FA
        or.l    d1,d0                           ; 000FE
        ori.l   #$100,d0                        ; 00100
        move.l  #$1a4,-(a7)                     ; 00106
        move.l  d0,-(a7)                        ; 0010C
        move.l  freopen_Name(a6),-(a7)          ; 0010E
        jsr     (open).l                        ; 00112
        lea.l   $c(a7),a7                       ; 00118
        move.l  d0,freopen_FD(a6)               ; 0011C
        addq.l  #$1,d0                          ; 00120
        bne.b   l_105_0012A                     ; 00122
        moveq   #$0,d0                          ; 00124
        unlk    a6                              ; 00126
        rts                                     ; 00128
l_105_0012A:
        moveq   #$2,d0                          ; 0012A
        move.l  d0,-(a7)                        ; 0012C
        clr.l   -(a7)                           ; 0012E
        move.l  freopen_FD(a6),-(a7)            ; 00130
        jsr     (lseek).l                       ; 00134
        lea.l   $c(a7),a7                       ; 0013A
        tst.b   freopen_Char(a6)                ; 0013E
        beq.b   l_105_0014C                     ; 00142
        move.l  #$80,d0                         ; 00144
        bra.b   l_105_0014E                     ; 0014A
l_105_0014C:
        moveq   #$2,d0                          ; 0014C
l_105_0014E:
        move.l  d0,freopen_Access(a6)           ; 0014E
        bra.w   l_105_001F8                     ; 00152
l_105_00156:
        tst.b   freopen_Char(a6)                ; 00156
        beq.b   l_105_00160                     ; 0015A
        moveq   #$2,d0                          ; 0015C
        bra.b   l_105_00162                     ; 0015E
l_105_00160:
        moveq   #$0,d0                          ; 00160
l_105_00162:
        move.l  freopen_Translate(a6),d1        ; 00162
        or.l    d0,d1                           ; 00166
        move.l  d1,-(a7)                        ; 00168
        move.l  freopen_Name(a6),-(a7)          ; 0016A
        jsr     (open).l                        ; 0016E
        addq.l  #$8,a7                          ; 00174
        move.l  d0,freopen_FD(a6)               ; 00176
        addq.l  #$1,d0                          ; 0017A
        bne.b   l_105_00184                     ; 0017C
        moveq   #$0,d0                          ; 0017E
        unlk    a6                              ; 00180
        rts                                     ; 00182
l_105_00184:
        tst.b   freopen_Char(a6)                ; 00184
        beq.b   l_105_00192                     ; 00188
        move.l  #$80,d0                         ; 0018A
        bra.b   l_105_00194                     ; 00190
l_105_00192:
        moveq   #$1,d0                          ; 00192
l_105_00194:
        move.l  d0,freopen_Access(a6)           ; 00194
        bra.b   l_105_001F8                     ; 00198
l_105_0019A:
        tst.b   freopen_Char(a6)                ; 0019A
        beq.b   l_105_001A4                     ; 0019E
        moveq   #$2,d0                          ; 001A0
        bra.b   l_105_001A6                     ; 001A2
l_105_001A4:
        moveq   #$1,d0                          ; 001A4
l_105_001A6:
        move.l  freopen_Translate(a6),d1        ; 001A6
        or.l    d0,d1                           ; 001AA
        ori.l   #$100,d1                        ; 001AC
        ori.l   #$200,d1                        ; 001B2
        move.l  #$1a4,-(a7)                     ; 001B8
        move.l  d1,-(a7)                        ; 001BE
        move.l  freopen_Name(a6),-(a7)          ; 001C0
        jsr     (open).l                        ; 001C4
        lea.l   $c(a7),a7                       ; 001CA
        move.l  d0,freopen_FD(a6)               ; 001CE
        addq.l  #$1,d0                          ; 001D2
        bne.b   l_105_001DC                     ; 001D4
        moveq   #$0,d0                          ; 001D6
        unlk    a6                              ; 001D8
        rts                                     ; 001DA
l_105_001DC:
        tst.b   freopen_Char(a6)                ; 001DC
        beq.b   l_105_001EA                     ; 001E0
        move.l  #$80,d0                         ; 001E2
        bra.b   l_105_001EC                     ; 001E8
l_105_001EA:
        moveq   #$2,d0                          ; 001EA
l_105_001EC:
        move.l  d0,freopen_Access(a6)           ; 001EC
        bra.b   l_105_001F8                     ; 001F0
l_105_001F2:
        moveq   #$0,d0                          ; 001F2
        unlk    a6                              ; 001F4
        rts                                     ; 001F6
l_105_001F8:
        move.l  freopen_FD(a6),d0               ; 001F8
        moveq   #$6,d1                          ; 001FC
        jsr     (CXM33).l                       ; 001FE
        movea.l d0,a0                           ; 00204
        adda.l  #_ufbs,a0                       ; 00206
        tst.b   $1(a0)                          ; 0020C
        beq.b   l_105_0022A                     ; 00210
        bset    #$2,freopen_IOBFlags(a6)        ; 00212
        movea.l freopen_FP(a6),a0               ; 00218
        adda.w  #$16,a0                         ; 0021C
        movea.l freopen_FP(a6),a1               ; 00220
        move.l  a0,iob_Base(a1)                 ; 00224
        bra.b   l_105_00232                     ; 00228
l_105_0022A:
        movea.l freopen_FP(a6),a0               ; 0022A
        clr.l   iob_Base(a0)                    ; 0022E
l_105_00232:
        move.l  freopen_FD(a6),d0               ; 00232
        movea.l freopen_FP(a6),a0               ; 00236
        move.b  d0,iob_File(a0)                 ; 0023A
        move.l  iob_Base(a0),(a0)               ; 0023E
        moveq   #$0,d0                          ; 00242
        move.l  d0,iob_WCnt(a0)                 ; 00244
        move.l  d0,iob_RCnt(a0)                 ; 00248
        move.l  freopen_Access(a6),d0           ; 0024C
        move.b  d0,iob_Flag(a0)                 ; 00250
        move.l  a0,d0                           ; 00254
        unlk    a6                              ; 00256
        rts                                     ; 00258

;-------------------------------------------------------------------------------
; fclose - fclose(fp): flushes the buffer, closes the file and frees the buffer.
;-------------------------------------------------------------------------------
; fclose's frame: arguments from 8(a6), locals below a6 (after its link)
                rsset   8
fclose_FP               rs.l    1               ; the stream
fclose:
        link.w  a6,#$0                          ; 0025A
        movea.l fclose_FP(a6),a0                ; 0025E
        move.b  iob_Flag(a0),d0                 ; 00262
        btst    #$1,d0                          ; 00266
        beq.b   l_105_0027A                     ; 0026A
        move.l  a0,-(a7)                        ; 0026C
        moveq   #-1,d0                          ; 0026E
        move.l  d0,-(a7)                        ; 00270
        jsr     (_flsbuf).l                     ; 00272
        addq.l  #$8,a7                          ; 00278
l_105_0027A:
        movea.l fclose_FP(a6),a0                ; 0027A
        move.b  iob_Flag(a0),d0                 ; 0027E
        andi.b  #$c,d0                          ; 00282
        tst.b   d0                              ; 00286
        bne.b   l_105_002A0                     ; 00288
        tst.l   iob_Size(a0)                    ; 0028A
        beq.b   l_105_002A0                     ; 0028E
        move.l  iob_Size(a0),-(a7)              ; 00290
        move.l  iob_Base(a0),-(a7)              ; 00294
        jsr     (free).l                        ; 00298
        addq.l  #$8,a7                          ; 0029E
l_105_002A0:
        suba.l  a0,a0                           ; 002A0
        movea.l fclose_FP(a6),a1                ; 002A2
        move.l  a0,iob_Base(a1)                 ; 002A6
        move.l  a0,iob_Size(a1)                 ; 002AA
        clr.b   iob_Flag(a1)                    ; 002AE
        moveq   #$0,d0                          ; 002B2
        move.b  iob_File(a1),d0                 ; 002B4
        move.l  d0,-(a7)                        ; 002B8
        jsr     (close).l                       ; 002BA
        addq.l  #$4,a7                          ; 002C0
        unlk    a6                              ; 002C2
        rts                                     ; 002C4
	dc.b	$00,$00
h105_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    3,143                           ; 3 longs pointing into hunk 143
	dc.l	$6,$12,$30
        dc.l    1,103                           ; 1 longs pointing into hunk 103
	dc.l	$6A
        dc.l    5,117                           ; 5 longs pointing into hunk 117
	dc.l	$114,$170,$1C6,$136,$2BC
        dc.l    1,154                           ; 1 longs pointing into hunk 154
	dc.l	$200
        dc.l    1,137                           ; 1 longs pointing into hunk 137
	dc.l	$208
        dc.l    1,120                           ; 1 longs pointing into hunk 120
	dc.l	$274
        dc.l    1,126                           ; 1 longs pointing into hunk 126
	dc.l	$29A
	dc.l	0
	dc.l	HUNK_END
	endc
