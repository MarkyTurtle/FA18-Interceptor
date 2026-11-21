; F/A-18 Interceptor - hunk 167 (code)
; C library: __main (the command line, stdio, calls main).
; Included by ../f18_main.s.

;===============================================================================
; Hunk 167: CODE, $26C bytes
;===============================================================================
	CODE_HUNK	h167

;-------------------------------------------------------------------------------
; __main - Lattice C __main(cmdline): splits the command line into argc/argv (quotes allowed:
; "Error: non-terminated quoted string"), sets up stdin, stdout and stderr (the CLI's
; Input()/Output(), or a con: window), and calls main(argc, argv), then exit().
;-------------------------------------------------------------------------------
; __main's frame: arguments from 8(a6), locals below a6 (after its link)
                rsset   8
__main_CmdLine          rs.l    1               ; the command line
__main:
        link.w  a6,#$fffa                       ; 00000
l_167_00004:
        cmpi.l  #$20,(MainData14).l             ; 00004
        bge.w   l_167_00116                     ; 0000E
l_167_00012:
        movea.l __main_CmdLine(a6),a0           ; 00012
        move.b  (a0),d0                         ; 00016
        ext.w   d0                              ; 00018
        ext.l   d0                              ; 0001A
        addq.l  #$1,d0                          ; 0001C
        movea.l d0,a1                           ; 0001E
        adda.l  #_ctype,a1                      ; 00020
        move.b  (a1),d0                         ; 00026
        btst    #$3,d0                          ; 00028
        beq.b   l_167_00034                     ; 0002C
        addq.l  #$1,__main_CmdLine(a6)          ; 0002E
        bra.b   l_167_00012                     ; 00032
l_167_00034:
        movea.l __main_CmdLine(a6),a0           ; 00034
        move.b  (a0),d0                         ; 00038
        tst.b   d0                              ; 0003A
        beq.w   l_167_00116                     ; 0003C
        movea.l __main_CmdLine(a6),a0           ; 00040
        move.b  (a0),d0                         ; 00044
        cmpi.b  #$22,d0                         ; 00046
        bne.b   l_167_000BC                     ; 0004A
        move.l  (MainData14).l,d0               ; 0004C
        asl.l   #$2,d0                          ; 00052
        addq.l  #$1,(MainData14).l              ; 00054
        movea.l d0,a1                           ; 0005A
        adda.l  #MainData15,a1                  ; 0005C
        addq.l  #$1,a0                          ; 00062
        move.l  a0,(a1)                         ; 00064
        move.l  a0,__main_CmdLine(a6)           ; 00066
l_167_0006A:
        movea.l __main_CmdLine(a6),a0           ; 0006A
        move.b  (a0),d0                         ; 0006E
        tst.b   d0                              ; 00070
        beq.b   l_167_00080                     ; 00072
        cmpi.b  #$22,d0                         ; 00074
        beq.b   l_167_00080                     ; 00078
        addq.l  #$1,__main_CmdLine(a6)          ; 0007A
        bra.b   l_167_0006A                     ; 0007E
l_167_00080:
        movea.l __main_CmdLine(a6),a0           ; 00080
        move.b  (a0),d0                         ; 00084
        tst.b   d0                              ; 00086
        bne.b   l_167_000AE                     ; 00088
        pea.l   (StrErrorNonTerminatedQuotedStri).l ; 0008A
        pea.l   (MainData10).l                  ; 00090
        jsr     (fprintf).l                     ; 00096
        addq.l  #$8,a7                          ; 0009C
        moveq   #$1,d0                          ; 0009E
        move.l  d0,-(a7)                        ; 000A0
        jsr     (exit).l                        ; 000A2
        addq.l  #$4,a7                          ; 000A8
        bra.w   l_167_00004                     ; 000AA
l_167_000AE:
        movea.l __main_CmdLine(a6),a0           ; 000AE
        clr.b   (a0)                            ; 000B2
        addq.l  #$1,__main_CmdLine(a6)          ; 000B4
        bra.w   l_167_00004                     ; 000B8
l_167_000BC:
        move.l  (MainData14).l,d0               ; 000BC
        asl.l   #$2,d0                          ; 000C2
        addq.l  #$1,(MainData14).l              ; 000C4
        movea.l d0,a0                           ; 000CA
        adda.l  #MainData15,a0                  ; 000CC
        move.l  __main_CmdLine(a6),(a0)         ; 000D2
l_167_000D6:
        movea.l __main_CmdLine(a6),a0           ; 000D6
        move.b  (a0),d0                         ; 000DA
        ext.w   d0                              ; 000DC
        ext.l   d0                              ; 000DE
        tst.l   d0                              ; 000E0
        beq.b   l_167_000FC                     ; 000E2
        addq.l  #$1,d0                          ; 000E4
        movea.l d0,a1                           ; 000E6
        adda.l  #_ctype,a1                      ; 000E8
        move.b  (a1),d0                         ; 000EE
        btst    #$3,d0                          ; 000F0
        bne.b   l_167_000FC                     ; 000F4
        addq.l  #$1,__main_CmdLine(a6)          ; 000F6
        bra.b   l_167_000D6                     ; 000FA
l_167_000FC:
        movea.l __main_CmdLine(a6),a0           ; 000FC
        move.b  (a0),d0                         ; 00100
        tst.b   d0                              ; 00102
        bne.b   l_167_00108                     ; 00104
        bra.b   l_167_00116                     ; 00106
l_167_00108:
        movea.l __main_CmdLine(a6),a0           ; 00108
        clr.b   (a0)                            ; 0010C
        addq.l  #$1,__main_CmdLine(a6)          ; 0010E
        bra.w   l_167_00004                     ; 00112
l_167_00116:
        clr.b   (MainData7).l                   ; 00116
        moveq   #$1,d0                          ; 0011C
        move.b  d0,(MainData6).l                ; 0011E
        move.b  d0,(MainData9).l                ; 00124
        moveq   #$2,d0                          ; 0012A
        move.b  d0,(MainData8).l                ; 0012C
        move.b  d0,(MainData12).l               ; 00132
        move.b  d0,(MainData11).l               ; 00138
        tst.l   (MainData14).l                  ; 0013E
        bne.w   l_167_001CA                     ; 00144
        movea.l (_WBenchMsg).l,a1               ; 00148
        movea.l $24(a1),a0                      ; 0014E
        moveq   #$28,d0                         ; 00152
        move.l  d0,-(a7)                        ; 00154
        move.l  $4(a0),-(a7)                    ; 00156
        pea.l   (s_ConsoleWindow).l             ; 0015A
        jsr     (strncat).l                     ; 00160
        lea.l   $c(a7),a7                       ; 00166
        move.l  #$3ee,-(a7)                     ; 0016A
        pea.l   (s_ConsoleWindow).l             ; 00170
        jsr     (_Open).l                       ; 00176
        addq.l  #$8,a7                          ; 0017C
        move.l  d0,(MainData1).l                ; 0017E
        move.l  d0,(MainData3).l                ; 00184
        moveq   #$4,d1                          ; 0018A
        move.b  d1,(MainData2).l                ; 0018C
        move.l  d0,(MainData5).l                ; 00192
        move.b  d1,(MainData4).l                ; 00198
        asl.l   #$2,d0                          ; 0019E
        clr.l   -(a7)                           ; 001A0
        move.l  d0,(MainData17).l               ; 001A2
        jsr     (_FindTask).l                   ; 001A8
        addq.l  #$4,a7                          ; 001AE
        movea.l (MainData17).l,a0               ; 001B0
        movea.l d0,a1                           ; 001B6
        move.l  $8(a0),$a4(a1)                  ; 001B8
        clr.l   -$6(a6)                         ; 001BE
        move.l  d0,(MainData16).l               ; 001C2
        bra.b   l_167_00202                     ; 001C8
l_167_001CA:
        jsr     (_Input).l                      ; 001CA
        move.l  d0,(MainData1).l                ; 001D0
        jsr     (_Output).l                     ; 001D6
        move.l  d0,(MainData3).l                ; 001DC
        move.l  #$3ed,-(a7)                     ; 001E2
        pea.l   (MainData13).l                  ; 001E8
        jsr     (_Open).l                       ; 001EE
        addq.l  #$8,a7                          ; 001F4
        move.l  d0,(MainData5).l                ; 001F6
        moveq   #$4,d0                          ; 001FC
        move.l  d0,-$6(a6)                      ; 001FE
l_167_00202:
        move.l  -$6(a6),d0                      ; 00202
        ori.l   #$c0,d0                         ; 00206
        move.b  (_ufbs).l,d1                    ; 0020C
        ext.w   d1                              ; 00212
        ext.l   d1                              ; 00214
        or.l    d0,d1                           ; 00216
        move.b  d1,(_ufbs).l                    ; 00218
        move.l  -$6(a6),d0                      ; 0021E
        ori.l   #$a0,d0                         ; 00222
        move.b  (MainData2).l,d1                ; 00228
        ext.w   d1                              ; 0022E
        ext.l   d1                              ; 00230
        or.l    d0,d1                           ; 00232
        move.b  d1,(MainData2).l                ; 00234
        move.b  (MainData4).l,d0                ; 0023A
        ori.b   #$a0,d0                         ; 00240
        move.b  d0,(MainData4).l                ; 00244
        pea.l   (MainData15).l                  ; 0024A
        move.l  (MainData14).l,-(a7)            ; 00250
        jsr     (main).l                        ; 00256
        addq.l  #$8,a7                          ; 0025C
        clr.l   -(a7)                           ; 0025E
        jsr     (exit).l                        ; 00260
        addq.l  #$4,a7                          ; 00266
        unlk    a6                              ; 00268
        rts                                     ; 0026A
h167_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    4,168                           ; 4 longs pointing into hunk 168
	dc.l	$1EA,$172,$15C,$8C
        dc.l    13,169                          ; 13 longs pointing into hunk 169
	dc.l	$252,$24C,$1C4,$1B2,$1A4,$140,$CE,$C6
	dc.l	$BE,$5E,$56,$4E,$A
        dc.l    2,91                            ; 2 longs pointing into hunk 91
	dc.l	$22,$EA
        dc.l    7,143                           ; 7 longs pointing into hunk 143
	dc.l	$92,$118,$120,$126,$12E,$134,$13A
        dc.l    1,108                           ; 1 longs pointing into hunk 108
	dc.l	$98
        dc.l    2,96                            ; 2 longs pointing into hunk 96
	dc.l	$A4,$262
        dc.l    1,1                             ; 1 longs pointing into hunk 1
	dc.l	$14A
        dc.l    1,129                           ; 1 longs pointing into hunk 129
	dc.l	$162
        dc.l    2,171                           ; 2 longs pointing into hunk 171
	dc.l	$178,$1F0
        dc.l    14,137                          ; 14 longs pointing into hunk 137
	dc.l	$180,$186,$18E,$194,$19A,$1D2,$1DE,$1F8
	dc.l	$20E,$21A,$22A,$236,$23C,$246
        dc.l    1,172                           ; 1 longs pointing into hunk 172
	dc.l	$1AA
        dc.l    1,171                           ; 1 longs pointing into hunk 171
	dc.l	$1CC
        dc.l    1,171                           ; 1 longs pointing into hunk 171
	dc.l	$1D8
        dc.l    1,0                             ; 1 longs pointing into hunk 0
	dc.l	$258
	dc.l	0
	dc.l	HUNK_END
	endc
