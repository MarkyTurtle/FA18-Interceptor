; F/A-18 Interceptor - hunk 117 (code)
; C library: low-level I/O (open, read, write, lseek, close...) and the console.
; Included by ../f18_main.s.

;===============================================================================
; Hunk 117: CODE, $608 bytes
;===============================================================================
	CODE_HUNK	h117

;-------------------------------------------------------------------------------
; chkufb - chkufb(fd): checks for CTRL-C and returns the low-level file's entry in _ufbs (6
; bytes each: flags.w, AmigaDOS handle.l), or 0 with errno = EBADF.
;-------------------------------------------------------------------------------
chkufb:
        link.w  a6,#$0                          ; 00000
        tst.l   (Enable_Abort).l                ; 00004
        beq.b   l_117_00012                     ; 0000A
        jsr     (Chk_Abort).l                   ; 0000C
l_117_00012:
        tst.l   $8(a6)                          ; 00012
        bmi.b   l_117_0003C                     ; 00016
        move.l  $8(a6),d0                       ; 00018
        cmp.l   (_nufbs).l,d0                   ; 0001C
        bge.b   l_117_0003C                     ; 00022
        moveq   #$6,d1                          ; 00024
        jsr     (CXM33).l                       ; 00026
        movea.l d0,a0                           ; 0002C
        adda.l  #_ufbs,a0                       ; 0002E
        move.b  (a0),d0                         ; 00034
        btst    #$7,d0                          ; 00036
        bne.b   l_117_0004A                     ; 0003A
l_117_0003C:
        moveq   #$9,d0                          ; 0003C
        move.l  d0,(errno).l                    ; 0003E
        moveq   #$0,d0                          ; 00044
        unlk    a6                              ; 00046
        rts                                     ; 00048
l_117_0004A:
        move.l  $8(a6),d0                       ; 0004A
        moveq   #$6,d1                          ; 0004E
        jsr     (CXM33).l                       ; 00050
        movea.l d0,a0                           ; 00056
        adda.l  #_ufbs,a0                       ; 00058
        move.l  a0,d0                           ; 0005E
        unlk    a6                              ; 00060
        rts                                     ; 00062

;-------------------------------------------------------------------------------
; open - open(name, mode, prot): low-level open; finds a free _ufbs entry and opens the file
; with MODE_OLDFILE / MODE_NEWFILE (O_CREAT, O_TRUNC deletes it first, O_APPEND seeks to the
; end). Returns the file number or -1 (errno).
;-------------------------------------------------------------------------------
open:
        link.w  a6,#$fff4                       ; 00064
        clr.l   -$4(a6)                         ; 00068
l_117_0006C:
        move.l  -$4(a6),d0                      ; 0006C
        cmp.l   (_nufbs).l,d0                   ; 00070
        bge.b   l_117_00094                     ; 00076
        moveq   #$6,d1                          ; 00078
        jsr     (CXM33).l                       ; 0007A
        movea.l d0,a0                           ; 00080
        adda.l  #_ufbs,a0                       ; 00082
        move.b  (a0),d0                         ; 00088
        tst.b   d0                              ; 0008A
        beq.b   l_117_00094                     ; 0008C
        addq.l  #$1,-$4(a6)                     ; 0008E
        bra.b   l_117_0006C                     ; 00092
l_117_00094:
        move.l  -$4(a6),d0                      ; 00094
        cmp.l   (_nufbs).l,d0                   ; 00098
        bne.b   l_117_000AE                     ; 0009E
        moveq   #$18,d0                         ; 000A0
        move.l  d0,(errno).l                    ; 000A2
        moveq   #-1,d0                          ; 000A8
        unlk    a6                              ; 000AA
        rts                                     ; 000AC
l_117_000AE:
        move.l  -$4(a6),d0                      ; 000AE
        moveq   #$6,d1                          ; 000B2
        jsr     (CXM33).l                       ; 000B4
        movea.l d0,a0                           ; 000BA
        adda.l  #_ufbs,a0                       ; 000BC
        move.l  (OpenData1).l,d0                ; 000C2
        andi.l  #$8000,d0                       ; 000C8
        move.l  $c(a6),d1                       ; 000CE
        eor.l   d1,d0                           ; 000D2
        move.l  d0,$c(a6)                       ; 000D4
        move.l  a0,-$c(a6)                      ; 000D8
        btst    #$f,d0                          ; 000DC
        beq.b   l_117_000E6                     ; 000E0
        moveq   #$10,d0                         ; 000E2
        bra.b   l_117_000E8                     ; 000E4
l_117_000E6:
        moveq   #$0,d0                          ; 000E6
l_117_000E8:
        ori.l   #$80,d0                         ; 000E8
        movea.l -$c(a6),a0                      ; 000EE
        move.b  d0,(a0)                         ; 000F2
        move.l  $c(a6),d0                       ; 000F4
        andi.l  #$3,d0                          ; 000F8
        cmpi.l  #$2,d0                          ; 000FE
        beq.b   l_117_00142                     ; 00104
        cmpi.l  #$1,d0                          ; 00106
        beq.b   l_117_00120                     ; 0010C
        tst.l   d0                              ; 0010E
        bne.b   l_117_00164                     ; 00110
        movea.l -$c(a6),a0                      ; 00112
        move.b  (a0),d0                         ; 00116
        ori.b   #$40,d0                         ; 00118
        move.b  d0,(a0)                         ; 0011C
        bra.b   l_117_00178                     ; 0011E
l_117_00120:
        btst    #$3,$f(a6)                      ; 00120
        beq.b   l_117_0012C                     ; 00126
        moveq   #$8,d0                          ; 00128
        bra.b   l_117_0012E                     ; 0012A
l_117_0012C:
        moveq   #$0,d0                          ; 0012C
l_117_0012E:
        ori.l   #$20,d0                         ; 0012E
        moveq   #$0,d1                          ; 00134
        movea.l -$c(a6),a0                      ; 00136
        move.b  (a0),d1                         ; 0013A
        or.l    d0,d1                           ; 0013C
        move.b  d1,(a0)                         ; 0013E
        bra.b   l_117_00178                     ; 00140
l_117_00142:
        btst    #$3,$f(a6)                      ; 00142
        beq.b   l_117_0014E                     ; 00148
        moveq   #$8,d0                          ; 0014A
        bra.b   l_117_00150                     ; 0014C
l_117_0014E:
        moveq   #$0,d0                          ; 0014E
l_117_00150:
        ori.l   #$60,d0                         ; 00150
        moveq   #$0,d1                          ; 00156
        movea.l -$c(a6),a0                      ; 00158
        move.b  (a0),d1                         ; 0015C
        or.l    d0,d1                           ; 0015E
        move.b  d1,(a0)                         ; 00160
        bra.b   l_117_00178                     ; 00162
l_117_00164:
        movea.l -$c(a6),a0                      ; 00164
        clr.b   (a0)                            ; 00168
        moveq   #$16,d0                         ; 0016A
        move.l  d0,(errno).l                    ; 0016C
        moveq   #-1,d0                          ; 00172
        unlk    a6                              ; 00174
        rts                                     ; 00176
l_117_00178:
        btst    #$1,$e(a6)                      ; 00178
        beq.b   l_117_0018C                     ; 0017E
        move.l  $8(a6),-(a7)                    ; 00180
        jsr     (_DeleteFile).l                 ; 00184
        addq.l  #$4,a7                          ; 0018A
l_117_0018C:
        move.l  $c(a6),d0                       ; 0018C
        andi.l  #$300,d0                        ; 00190
        tst.l   d0                              ; 00196
        beq.b   l_117_001A4                     ; 00198
        move.l  #$3ee,-$8(a6)                   ; 0019A
        bra.b   l_117_001AC                     ; 001A2
l_117_001A4:
        move.l  #$3ed,-$8(a6)                   ; 001A4
l_117_001AC:
        move.l  -$8(a6),-(a7)                   ; 001AC
        move.l  $8(a6),-(a7)                    ; 001B0
        jsr     (_Open).l                       ; 001B4
        addq.l  #$8,a7                          ; 001BA
        movea.l -$c(a6),a0                      ; 001BC
        move.l  d0,$2(a0)                       ; 001C0
        tst.l   d0                              ; 001C4
        bne.b   l_117_001E8                     ; 001C6
        jsr     (_IoErr).l                      ; 001C8
        move.l  d0,(_OSERR).l                   ; 001CE
        moveq   #$2,d0                          ; 001D4
        move.l  d0,(errno).l                    ; 001D6
        movea.l -$c(a6),a0                      ; 001DC
        clr.b   (a0)                            ; 001E0
        moveq   #-1,d0                          ; 001E2
        unlk    a6                              ; 001E4
        rts                                     ; 001E6
l_117_001E8:
        move.l  -$4(a6),d0                      ; 001E8
        unlk    a6                              ; 001EC
        rts                                     ; 001EE

;-------------------------------------------------------------------------------
; creat - creat(name, prot): open(name, O_WRONLY|O_CREAT|O_TRUNC, prot).
;-------------------------------------------------------------------------------
creat:
        link.w  a6,#$0                          ; 001F0
        move.l  $c(a6),d0                       ; 001F4
        andi.l  #$8000,d0                       ; 001F8
        ori.l   #$301,d0                        ; 001FE
        move.l  $c(a6),d1                       ; 00204
        andi.l  #$ffff7fff,d1                   ; 00208
        move.l  d1,-(a7)                        ; 0020E
        move.l  d0,-(a7)                        ; 00210
        move.l  $8(a6),-(a7)                    ; 00212
        bsr.w   open                            ; 00216
        lea.l   $c(a7),a7                       ; 0021A
        unlk    a6                              ; 0021E
        rts                                     ; 00220

;-------------------------------------------------------------------------------
; read - read(fd, buf, n): AmigaDOS Read; -1 and errno/_OSERR on error.
;-------------------------------------------------------------------------------
read:
        link.w  a6,#$fff8                       ; 00222
        tst.l   $10(a6)                         ; 00226
        bmi.b   l_117_0023E                     ; 0022A
        move.l  $8(a6),-(a7)                    ; 0022C
        bsr.w   chkufb                          ; 00230
        addq.l  #$4,a7                          ; 00234
        move.l  d0,-$8(a6)                      ; 00236
        tst.l   d0                              ; 0023A
        bne.b   l_117_0024C                     ; 0023C
l_117_0023E:
        moveq   #$16,d0                         ; 0023E
        move.l  d0,(errno).l                    ; 00240
        moveq   #-1,d0                          ; 00246
        unlk    a6                              ; 00248
        rts                                     ; 0024A
l_117_0024C:
        move.l  $10(a6),-(a7)                   ; 0024C
        move.l  $c(a6),-(a7)                    ; 00250
        movea.l -$8(a6),a0                      ; 00254
        move.l  $2(a0),-(a7)                    ; 00258
        jsr     (_Read).l                       ; 0025C
        lea.l   $c(a7),a7                       ; 00262
        move.l  d0,-$4(a6)                      ; 00266
        addq.l  #$1,d0                          ; 0026A
        bne.b   l_117_00282                     ; 0026C
        jsr     (_IoErr).l                      ; 0026E
        move.l  d0,(_OSERR).l                   ; 00274
        moveq   #$5,d0                          ; 0027A
        move.l  d0,(errno).l                    ; 0027C
l_117_00282:
        move.l  -$4(a6),d0                      ; 00282
        unlk    a6                              ; 00286
        rts                                     ; 00288

;-------------------------------------------------------------------------------
; write - write(fd, buf, n): AmigaDOS Write (seeking to the end first in append mode).
;-------------------------------------------------------------------------------
write:
        link.w  a6,#$fff8                       ; 0028A
        tst.l   $10(a6)                         ; 0028E
        bmi.b   l_117_002A6                     ; 00292
        move.l  $8(a6),-(a7)                    ; 00294
        bsr.w   chkufb                          ; 00298
        addq.l  #$4,a7                          ; 0029C
        move.l  d0,-$8(a6)                      ; 0029E
        tst.l   d0                              ; 002A2
        bne.b   l_117_002B4                     ; 002A4
l_117_002A6:
        moveq   #$16,d0                         ; 002A6
        move.l  d0,(errno).l                    ; 002A8
        moveq   #-1,d0                          ; 002AE
        unlk    a6                              ; 002B0
        rts                                     ; 002B2
l_117_002B4:
        movea.l -$8(a6),a0                      ; 002B4
        move.b  (a0),d0                         ; 002B8
        btst    #$3,d0                          ; 002BA
        beq.b   l_117_002D0                     ; 002BE
        moveq   #$2,d0                          ; 002C0
        move.l  d0,-(a7)                        ; 002C2
        clr.l   -(a7)                           ; 002C4
        move.l  $8(a6),-(a7)                    ; 002C6
        bsr.b   lseek                           ; 002CA
        lea.l   $c(a7),a7                       ; 002CC
l_117_002D0:
        move.l  $10(a6),-(a7)                   ; 002D0
        move.l  $c(a6),-(a7)                    ; 002D4
        movea.l -$8(a6),a0                      ; 002D8
        move.l  $2(a0),-(a7)                    ; 002DC
        jsr     (_Write).l                      ; 002E0
        lea.l   $c(a7),a7                       ; 002E6
        move.l  d0,-$4(a6)                      ; 002EA
        addq.l  #$1,d0                          ; 002EE
        bne.b   l_117_00306                     ; 002F0
        jsr     (_IoErr).l                      ; 002F2
        move.l  d0,(_OSERR).l                   ; 002F8
        moveq   #$5,d0                          ; 002FE
        move.l  d0,(errno).l                    ; 00300
l_117_00306:
        move.l  -$4(a6),d0                      ; 00306
        unlk    a6                              ; 0030A
        rts                                     ; 0030C

;-------------------------------------------------------------------------------
; lseek - lseek(fd, offset, mode): AmigaDOS Seek; returns the new position.
;-------------------------------------------------------------------------------
lseek:
        link.w  a6,#$fffc                       ; 0030E
        move.l  $8(a6),-(a7)                    ; 00312
        bsr.w   chkufb                          ; 00316
        addq.l  #$4,a7                          ; 0031A
        move.l  d0,-$4(a6)                      ; 0031C
        tst.l   d0                              ; 00320
        beq.b   l_117_0032E                     ; 00322
        cmpi.l  #$2,$10(a6)                     ; 00324
        bls.b   l_117_0033C                     ; 0032C
l_117_0032E:
        moveq   #$16,d0                         ; 0032E
        move.l  d0,(errno).l                    ; 00330
        moveq   #-1,d0                          ; 00336
        unlk    a6                              ; 00338
        rts                                     ; 0033A
l_117_0033C:
        move.l  $10(a6),d0                      ; 0033C
        asl.l   #$2,d0                          ; 00340
        movea.l d0,a0                           ; 00342
        adda.l  #LseekData1,a0                  ; 00344
        move.l  (a0),-(a7)                      ; 0034A
        move.l  $c(a6),-(a7)                    ; 0034C
        movea.l -$4(a6),a1                      ; 00350
        move.l  $2(a1),-(a7)                    ; 00354
        jsr     (_Seek).l                       ; 00358
        lea.l   $c(a7),a7                       ; 0035E
        addq.l  #$1,d0                          ; 00362
        bne.b   l_117_0037A                     ; 00364
        jsr     (_IoErr).l                      ; 00366
        move.l  d0,(_OSERR).l                   ; 0036C
        moveq   #$16,d0                         ; 00372
        move.l  d0,(errno).l                    ; 00374
l_117_0037A:
        moveq   #$0,d0                          ; 0037A
        move.l  d0,-(a7)                        ; 0037C
        move.l  d0,-(a7)                        ; 0037E
        movea.l -$4(a6),a0                      ; 00380
        move.l  $2(a0),-(a7)                    ; 00384
        jsr     (_Seek).l                       ; 00388
        lea.l   $c(a7),a7                       ; 0038E
        unlk    a6                              ; 00392
        rts                                     ; 00394

;-------------------------------------------------------------------------------
; close - close(fd): AmigaDOS Close, and frees the _ufbs entry.
;-------------------------------------------------------------------------------
close:
        link.w  a6,#$fff8                       ; 00396
        move.l  $8(a6),-(a7)                    ; 0039A
        bsr.w   chkufb                          ; 0039E
        addq.l  #$4,a7                          ; 003A2
        move.l  d0,-$8(a6)                      ; 003A4
        tst.l   d0                              ; 003A8
        bne.b   l_117_003B2                     ; 003AA
        moveq   #-1,d0                          ; 003AC
        unlk    a6                              ; 003AE
        rts                                     ; 003B0
l_117_003B2:
        moveq   #$0,d0                          ; 003B2
        movea.l -$8(a6),a0                      ; 003B4
        move.b  (a0),d1                         ; 003B8
        move.l  d0,-$4(a6)                      ; 003BA
        btst    #$2,d1                          ; 003BE
        beq.b   l_117_003C8                     ; 003C2
        unlk    a6                              ; 003C4
        rts                                     ; 003C6
l_117_003C8:
        movea.l -$8(a6),a0                      ; 003C8
        move.l  $2(a0),-(a7)                    ; 003CC
        jsr     (_Close).l                      ; 003D0
        addq.l  #$4,a7                          ; 003D6
        movea.l -$8(a6),a0                      ; 003D8
        clr.b   (a0)                            ; 003DC
        move.l  -$4(a6),d0                      ; 003DE
        unlk    a6                              ; 003E2
        rts                                     ; 003E4

;-------------------------------------------------------------------------------
; unlink - unlink(name): AmigaDOS DeleteFile.
;-------------------------------------------------------------------------------
unlink:
        link.w  a6,#$0                          ; 003E6
        move.l  $8(a6),-(a7)                    ; 003EA
        jsr     (_DeleteFile).l                 ; 003EE
        addq.l  #$4,a7                          ; 003F4
        tst.l   d0                              ; 003F6
        bne.b   l_117_00414                     ; 003F8
        jsr     (_IoErr).l                      ; 003FA
        move.l  d0,(_OSERR).l                   ; 00400
        moveq   #$2,d0                          ; 00406
        move.l  d0,(errno).l                    ; 00408
        moveq   #-1,d0                          ; 0040E
        unlk    a6                              ; 00410
        rts                                     ; 00412
l_117_00414:
        moveq   #$0,d0                          ; 00414
        unlk    a6                              ; 00416
        rts                                     ; 00418

;-------------------------------------------------------------------------------
; remove - remove(name): unlink(name).
;-------------------------------------------------------------------------------
remove:
        link.w  a6,#$0                          ; 0041A
        move.l  $8(a6),-(a7)                    ; 0041E
        bsr.b   unlink                          ; 00422
        addq.l  #$4,a7                          ; 00424
        unlk    a6                              ; 00426
        rts                                     ; 00428

;-------------------------------------------------------------------------------
; rename - rename(old, new): AmigaDOS Rename.
;-------------------------------------------------------------------------------
rename:
        link.w  a6,#$0                          ; 0042A
        move.l  $c(a6),-(a7)                    ; 0042E
        move.l  $8(a6),-(a7)                    ; 00432
        jsr     (_Rename).l                     ; 00436
        addq.l  #$8,a7                          ; 0043C
        tst.l   d0                              ; 0043E
        bne.b   l_117_0045C                     ; 00440
        jsr     (_IoErr).l                      ; 00442
        move.l  d0,(_OSERR).l                   ; 00448
        moveq   #$5,d0                          ; 0044E
        move.l  d0,(errno).l                    ; 00450
        moveq   #-1,d0                          ; 00456
        unlk    a6                              ; 00458
        rts                                     ; 0045A
l_117_0045C:
        moveq   #$0,d0                          ; 0045C
        unlk    a6                              ; 0045E
        rts                                     ; 00460

;-------------------------------------------------------------------------------
; OpenConsole - Opens the console window (con:10/10/320/80/) for the console routines below, if
; it is not open.
;-------------------------------------------------------------------------------
OpenConsole:
        move.l  #$3ed,-(a7)                     ; 00462
        pea.l   (OpenConsoleData1).l            ; 00468
        jsr     (_Open).l                       ; 0046E
        addq.l  #$8,a7                          ; 00474
        move.l  d0,(_ConsoleHandle).l           ; 00476
        rts                                     ; 0047C

;-------------------------------------------------------------------------------
; getch - Reads a character from the console window.
;-------------------------------------------------------------------------------
getch:
        link.w  a6,#$fffe                       ; 0047E
        tst.l   (Enable_Abort).l                ; 00482
        beq.b   l_117_00490                     ; 00488
        jsr     (Chk_Abort).l                   ; 0048A
l_117_00490:
        tst.l   (_ConsoleHandle).l              ; 00490
        bne.b   l_117_0049A                     ; 00496
        bsr.b   OpenConsole                     ; 00498
l_117_0049A:
        tst.b   (BreakFlag).l                   ; 0049A
        beq.b   l_117_004BE                     ; 004A0
        move.b  (BreakFlag).l,d0                ; 004A2
        move.b  d0,-$1(a6)                      ; 004A8
        clr.b   (BreakFlag).l                   ; 004AC
        moveq   #$0,d1                          ; 004B2
        move.b  -$1(a6),d1                      ; 004B4
        move.l  d1,d0                           ; 004B8
        unlk    a6                              ; 004BA
        rts                                     ; 004BC
l_117_004BE:
        moveq   #$1,d0                          ; 004BE
        move.l  d0,-(a7)                        ; 004C0
        pea.l   -$1(a6)                         ; 004C2
        move.l  (_ConsoleHandle).l,-(a7)        ; 004C6
        jsr     (_Read).l                       ; 004CC
        lea.l   $c(a7),a7                       ; 004D2
        moveq   #$0,d0                          ; 004D6
        move.b  -$1(a6),d0                      ; 004D8
        unlk    a6                              ; 004DC
        rts                                     ; 004DE

;-------------------------------------------------------------------------------
; GetBreakFlag - Takes and clears the console's break flag (BreakFlag).
;-------------------------------------------------------------------------------
GetBreakFlag:
        link.w  a6,#$fffe                       ; 004E0
        tst.b   (BreakFlag).l                   ; 004E4
        beq.b   l_117_00506                     ; 004EA
        move.b  (BreakFlag).l,d0                ; 004EC
        clr.b   (BreakFlag).l                   ; 004F2
        move.b  d0,-$1(a6)                      ; 004F8
        andi.l  #$ff,d0                         ; 004FC
        unlk    a6                              ; 00502
        rts                                     ; 00504
l_117_00506:
        bsr.w   getch                           ; 00506
        unlk    a6                              ; 0050A
        rts                                     ; 0050C

;-------------------------------------------------------------------------------
; putch - Writes the character (4(sp)) to the console window.
;-------------------------------------------------------------------------------
putch:
        link.w  a6,#$0                          ; 0050E
        tst.l   (Enable_Abort).l                ; 00512
        beq.b   l_117_00520                     ; 00518
        jsr     (Chk_Abort).l                   ; 0051A
l_117_00520:
        tst.l   (_ConsoleHandle).l              ; 00520
        bne.b   l_117_0052C                     ; 00526
        bsr.w   OpenConsole                     ; 00528
l_117_0052C:
        moveq   #$1,d0                          ; 0052C
        move.l  d0,-(a7)                        ; 0052E
        pea.l   $b(a6)                          ; 00530
        move.l  (_ConsoleHandle).l,-(a7)        ; 00534
        jsr     (_Write).l                      ; 0053A
        lea.l   $c(a7),a7                       ; 00540
        moveq   #$0,d0                          ; 00544
        move.b  $b(a6),d0                       ; 00546
        unlk    a6                              ; 0054A
        rts                                     ; 0054C

;-------------------------------------------------------------------------------
; TestBreakFlag - -1 if the break flag is set.
;-------------------------------------------------------------------------------
TestBreakFlag:
        link.w  a6,#$0                          ; 0054E
        tst.b   (BreakFlag).l                   ; 00552
        beq.b   l_117_00560                     ; 00558
        moveq   #-1,d0                          ; 0055A
        unlk    a6                              ; 0055C
        rts                                     ; 0055E
l_117_00560:
        move.l  $8(a6),d0                       ; 00560
        move.b  d0,(BreakFlag).l                ; 00564
        unlk    a6                              ; 0056A
        rts                                     ; 0056C

;-------------------------------------------------------------------------------
; cgets - Reads a line from the console window.
;-------------------------------------------------------------------------------
cgets:
        link.w  a6,#$fffc                       ; 0056E
        tst.l   (Enable_Abort).l                ; 00572
        beq.b   l_117_00580                     ; 00578
        jsr     (Chk_Abort).l                   ; 0057A
l_117_00580:
        tst.l   (_ConsoleHandle).l              ; 00580
        bne.b   l_117_0058C                     ; 00586
        bsr.w   OpenConsole                     ; 00588
l_117_0058C:
        move.l  #$ff,-(a7)                      ; 0058C
        move.l  $8(a6),-(a7)                    ; 00592
        move.l  (_ConsoleHandle).l,-(a7)        ; 00596
        jsr     (_Read).l                       ; 0059C
        lea.l   $c(a7),a7                       ; 005A2
        move.l  d0,-$4(a6)                      ; 005A6
        tst.l   d0                              ; 005AA
        bpl.b   l_117_005B2                     ; 005AC
        clr.l   -$4(a6)                         ; 005AE
l_117_005B2:
        movea.l $8(a6),a0                       ; 005B2
        adda.l  -$4(a6),a0                      ; 005B6
        clr.b   (a0)                            ; 005BA
        move.l  $8(a6),d0                       ; 005BC
        unlk    a6                              ; 005C0
        rts                                     ; 005C2

;-------------------------------------------------------------------------------
; cputs - Writes a string to the console window.
;-------------------------------------------------------------------------------
cputs:
        link.w  a6,#$0                          ; 005C4
        tst.l   (Enable_Abort).l                ; 005C8
        beq.b   l_117_005D6                     ; 005CE
        jsr     (Chk_Abort).l                   ; 005D0
l_117_005D6:
        tst.l   (_ConsoleHandle).l              ; 005D6
        bne.b   l_117_005E2                     ; 005DC
        bsr.w   OpenConsole                     ; 005DE
l_117_005E2:
        move.l  $8(a6),-(a7)                    ; 005E2
        jsr     (strlen).l                      ; 005E6
        addq.l  #$4,a7                          ; 005EC
        move.l  d0,-(a7)                        ; 005EE
        move.l  $8(a6),-(a7)                    ; 005F0
        move.l  (_ConsoleHandle).l,-(a7)        ; 005F4
        jsr     (_Write).l                      ; 005FA
        lea.l   $c(a7),a7                       ; 00600
        unlk    a6                              ; 00604
        rts                                     ; 00606
h117_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    10,118                          ; 10 longs pointing into hunk 118
	dc.l	$566,$554,$4F4,$4EE,$4E6,$4AE,$4A4,$49C
	dc.l	$46A,$346
        dc.l    5,100                           ; 5 longs pointing into hunk 100
	dc.l	$6,$484,$514,$574,$5CA
        dc.l    5,99                            ; 5 longs pointing into hunk 99
	dc.l	$E,$48C,$51C,$57C,$5D2
        dc.l    3,136                           ; 3 longs pointing into hunk 136
	dc.l	$1E,$72,$9A
        dc.l    4,154                           ; 4 longs pointing into hunk 154
	dc.l	$28,$52,$7C,$B6
        dc.l    4,137                           ; 4 longs pointing into hunk 137
	dc.l	$30,$5A,$84,$BE
        dc.l    12,94                           ; 12 longs pointing into hunk 94
	dc.l	$40,$A4,$16E,$1D8,$242,$27E,$2AA,$302
	dc.l	$332,$376,$40A,$452
        dc.l    1,115                           ; 1 longs pointing into hunk 115
	dc.l	$C4
        dc.l    2,171                           ; 2 longs pointing into hunk 171
	dc.l	$186,$3F0
        dc.l    2,171                           ; 2 longs pointing into hunk 171
	dc.l	$1B6,$470
        dc.l    6,171                           ; 6 longs pointing into hunk 171
	dc.l	$1CA,$270,$2F4,$368,$3FC,$444
        dc.l    15,1                            ; 15 longs pointing into hunk 1
	dc.l	$1D0,$276,$2FA,$36E,$402,$44A,$478,$492
	dc.l	$4C8,$522,$536,$582,$598,$5D8,$5F6
        dc.l    3,171                           ; 3 longs pointing into hunk 171
	dc.l	$25E,$4CE,$59E
        dc.l    3,171                           ; 3 longs pointing into hunk 171
	dc.l	$2E2,$53C,$5FC
        dc.l    2,171                           ; 2 longs pointing into hunk 171
	dc.l	$35A,$38A
        dc.l    1,171                           ; 1 longs pointing into hunk 171
	dc.l	$3D2
        dc.l    1,171                           ; 1 longs pointing into hunk 171
	dc.l	$438
        dc.l    1,132                           ; 1 longs pointing into hunk 132
	dc.l	$5E8
	dc.l	0
	dc.l	HUNK_END
	endc
