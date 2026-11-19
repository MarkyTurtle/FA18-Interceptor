; F/A-18 Interceptor - hunk 0 (code), part 1 of 3
; The C startup (c.o), main, RunGame and GameFrame (the frame loop); the EA IFF picture reader;
; memory and disk checks; the flight log (df0:config) and flight recording (textply/textctl)
; files; the keyboard, joystick, timer and mouse; loading and playing the sounds.
; Included by ../f18_main.s.

;===============================================================================
; Hunk 0: CODE, $A34C bytes
; Lattice C startup (c.o) first, then the game's first module.
;===============================================================================
	CODE_HUNK	h000

;-------------------------------------------------------------------------------
; _start - Lattice C startup (c.o), the program's entry point. Saves the command line (d0/a0),
; ExecBase and the stack, opens dos.library. From the CLI: builds the program name and
; arguments on the stack and calls __main (which calls main). From Workbench: waits for the
; startup message, makes its lock the current directory, opens its tool window if it has one,
; and calls main(0) directly. Falls into XCEXIT when main returns.
;-------------------------------------------------------------------------------
_start:
        move.l  d0,(_ArgLen).l                  ; 00000
        move.l  a0,(_ArgPtr).l                  ; 00006
        move.l  a7,d0                           ; 0000C
        movem.l d1-d6/a0-a6,-(a7)               ; 0000E
        movea.l d0,a5                           ; 00012
        movea.l (AbsExecBase).l,a6              ; 00014
        move.l  a6,(_SysBase).l                 ; 0001A
        move.l  a7,(__savsp).l                  ; 00020
        clr.l   (_WBenchMsg).l                  ; 00026
        suba.l  a1,a1                           ; 0002C
        jsr     _LVOFindTask(a6)                ; 0002E
        movea.l d0,a4                           ; 00032
        move.l  pr_CurrentDir(a4),(_StartDir).l ; 00034
        tst.l   pr_CLI(a4)                      ; 0003C
        beq.w   _start_fromWorkbench            ; 00040
        move.l  a5,d0                           ; 00044
        sub.l   $4(a5),d0                       ; 00046
        move.l  d0,(_StackSize).l               ; 0004A
        bsr.w   OpenDOSLibrary                  ; 00050
        movea.l #_start,a0                      ; 00054
        clr.l   -(a7)                           ; 0005A
        jsr     (_FindTask).l                   ; 0005C
        addq.l  #$4,a7                          ; 00062
        movea.l d0,a0                           ; 00064
        movea.l pr_CLI(a0),a0                   ; 00066
        adda.l  a0,a0                           ; 0006A
        adda.l  a0,a0                           ; 0006C
        movea.l cli_CommandName(a0),a1          ; 0006E
        adda.l  a1,a1                           ; 00072
        adda.l  a1,a1                           ; 00074
        move.l  (_ArgLen).l,d0                  ; 00076
        moveq   #$0,d1                          ; 0007C
        move.b  (a1)+,d1                        ; 0007E
        move.l  a1,(_ProgramName).l             ; 00080
        add.l   d1,d0                           ; 00086
        addq.l  #$1,d0                          ; 00088
        clr.w   -(a7)                           ; 0008A
        addq.l  #$1,d0                          ; 0008C
        andi.w  #$fffe,d0                       ; 0008E
        suba.l  d0,a7                           ; 00092
        subq.l  #$2,d0                          ; 00094
        clr.w   (a7,d0.w)                       ; 00096
        move.l  (_ArgLen).l,d0                  ; 0009A
        movea.l (_ArgPtr).l,a0                  ; 000A0
        move.l  d0,d2                           ; 000A6
        subq.l  #$1,d0                          ; 000A8
        add.l   d1,d2                           ; 000AA
l_000_000AC:
        move.b  (a0,d0.w),(a7,d2.w)             ; 000AC
        subq.l  #$1,d2                          ; 000B2
        dbra    d0,l_000_000AC                  ; 000B4
        move.b  #$20,(a7,d2.w)                  ; 000B8
        subq.l  #$1,d2                          ; 000BE
l_000_000C0:
        move.b  (a1,d2.w),(a7,d2.w)             ; 000C0
        dbra    d2,l_000_000C0                  ; 000C6
        movea.l a7,a1                           ; 000CA
        move.l  a1,-(a7)                        ; 000CC
        jsr     (__main).l                      ; 000CE
        moveq   #$0,d0                          ; 000D4
        bra.b   XCEXIT_d0                       ; 000D6
_start_fromWorkbench:
        move.l  $3a(a4),(_StackSize).l          ; 000D8
        bsr.w   OpenDOSLibrary                  ; 000E0
        bsr.w   WaitWBMessage                   ; 000E4
        move.l  d0,(_WBenchMsg).l               ; 000E8
        move.l  d0,-(a7)                        ; 000EE
        movea.l d0,a2                           ; 000F0
        move.l  sm_ArgList(a2),d0               ; 000F2
        beq.b   l_000_00108                     ; 000F6
        movea.l (_DOSBase).l,a6                 ; 000F8
        movea.l d0,a0                           ; 000FE
        move.l  wa_Lock(a0),d1                  ; 00100
        jsr     _LVOCurrentDir(a6)              ; 00104
l_000_00108:
        move.l  sm_ToolWindow(a2),d1            ; 00108
        beq.b   l_000_0012A                     ; 0010C
        move.l  #MODE_OLDFILE,d2                ; 0010E
        jsr     _LVOOpen(a6)                    ; 00114
        move.l  d0,(_WBConsole).l               ; 00118
        beq.b   l_000_0012A                     ; 0011E
        lsl.l   #$2,d0                          ; 00120
        movea.l d0,a0                           ; 00122
        move.l  $8(a0),pr_ConsoleTask(a4)       ; 00124
l_000_0012A:
        clr.l   -(a7)                           ; 0012A
        jsr     (main).l                        ; 0012C
        moveq   #$0,d0                          ; 00132
        bra.b   XCEXIT_d0                       ; 00134

;-------------------------------------------------------------------------------
; XCEXIT - exit(code) from anywhere: the code (4(sp)) goes back to whoever started the program.
; Frees what was allocated through AllocMemTracked, closes the Workbench window and current
; directory lock, replies to the Workbench message (inside Forbid), restores the startup stack
; and returns.
;-------------------------------------------------------------------------------
XCEXIT:
        move.l  $4(a7),d0                       ; 00136
XCEXIT_d0:
        move.l  d0,-(a7)                        ; 0013A
        jsr     (FreeAllTracked).l              ; 0013C
        tst.l   (_WBenchMsg).l                  ; 00142
        beq.b   l_000_00176                     ; 00148
        move.l  (_ConsoleHandle).l,d1           ; 0014A
        beq.b   l_000_00156                     ; 00150
        jsr     _LVOClose(a6)                   ; 00152
l_000_00156:
        move.l  (_WBConsole).l,d1               ; 00156
        beq.b   l_000_00162                     ; 0015C
        jsr     _LVOClose(a6)                   ; 0015E
l_000_00162:
        movea.l (AbsExecBase).l,a6              ; 00162
        jsr     _LVOForbid(a6)                  ; 00168
        movea.l (_WBenchMsg).l,a1               ; 0016C
        jsr     _LVOReplyMsg(a6)                ; 00172
l_000_00176:
        move.l  (a7)+,d0                        ; 00176
        movea.l (__savsp).l,a7                  ; 00178
        movem.l (a7)+,d1-d6/a0-a6               ; 0017E
        rts                                     ; 00182

;-------------------------------------------------------------------------------
; NoDOSLibrary - dos.library did not open: Alert(AG_OpenLib|AO_DOSLib) and exit with 100.
;-------------------------------------------------------------------------------
NoDOSLibrary:
        movem.l d7/a5-a6,-(a7)                  ; 00184
        move.l  #AG_OpenLib|AO_DOSLib,d7        ; 00188
        movea.l $4.w,a6                         ; 0018E
        jsr     _LVOAlert(a6)                   ; 00192
        movem.l (a7)+,d7/a5-a6                  ; 00196
        moveq   #$64,d0                         ; 0019A
        bra.b   XCEXIT_d0                       ; 0019C

;-------------------------------------------------------------------------------
; WaitWBMessage - Waits for and takes the Workbench startup message from the process's message
; port (pr_MsgPort, a4 = the process).
;-------------------------------------------------------------------------------
WaitWBMessage:
        lea.l   pr_MsgPort(a4),a0               ; 0019E
        jsr     _LVOWaitPort(a6)                ; 001A2
        lea.l   pr_MsgPort(a4),a0               ; 001A6
        jsr     _LVOGetMsg(a6)                  ; 001AA
        rts                                     ; 001AE

;-------------------------------------------------------------------------------
; OpenDOSLibrary - Opens dos.library (any version) into _DOSBase; NoDOSLibrary if it fails.
;-------------------------------------------------------------------------------
OpenDOSLibrary:
        lea.l   (s_dos_library).l,a1            ; 001B0
        moveq   #$0,d0                          ; 001B6
        jsr     _LVOOpenLibrary(a6)             ; 001B8
        move.l  d0,(_DOSBase).l                 ; 001BC
        beq.b   NoDOSLibrary                    ; 001C2
        rts                                     ; 001C4
	dc.b	$00,$00

;-------------------------------------------------------------------------------
; LoadPicture - LoadPicture(name, colours, bmhd): loads an IFF ILBM picture from the disk.
; Opens the file and the IFF context (OpenRIFF), reads the FORM header, the BMHD (20 bytes,
; into bmhd), the CMAP (up to 32 colours, as RGB4 words, into colours: GetCMAP), skips the next
; 4-byte chunk (the pictures on the disk have a GRAB chunk there), allocates a BitMap ($28
; bytes) and its planes in chip RAM (InitBitMap with the BMHD's depth, width and height) and a
; row buffer, and decompresses the BODY into it (GetBODY). The chunks must come in that order.
; Returns the BitMap (0 if the file did not open).
;-------------------------------------------------------------------------------
LoadPicture:
        link.w  a6,#$ffae                       ; 001C8
        movem.l d2-d3,-(a7)                     ; 001CC
        move.l  $10(a6),-$8(a6)                 ; 001D0
        move.l  #MODE_OLDFILE,-(a7)             ; 001D6
        move.l  $8(a6),-(a7)                    ; 001DC
        jsr     (_Open).l                       ; 001E0
        addq.l  #$8,a7                          ; 001E6
        move.l  d0,-$10(a6)                     ; 001E8
        tst.l   d0                              ; 001EC
        bne.b   l_000_001FA                     ; 001EE
        moveq   #$0,d0                          ; 001F0
        movem.l (a7)+,d2-d3                     ; 001F2
        unlk    a6                              ; 001F6
        rts                                     ; 001F8
l_000_001FA:
        clr.l   -(a7)                           ; 001FA
        pea.l   -$34(a6)                        ; 001FC
        move.l  -$10(a6),-(a7)                  ; 00200
        jsr     (OpenRIFF).l                    ; 00204
        lea.l   $c(a7),a7                       ; 0020A
        move.l  d0,-$c(a6)                      ; 0020E
        tst.l   d0                              ; 00212
        beq.b   l_000_00220                     ; 00214
        moveq   #$0,d0                          ; 00216
        movem.l (a7)+,d2-d3                     ; 00218
        unlk    a6                              ; 0021C
        rts                                     ; 0021E
l_000_00220:
        pea.l   -$34(a6)                        ; 00220
        jsr     (GetFChunkHdr).l                ; 00224
        addq.l  #$4,a7                          ; 0022A
        moveq   #$8,d0                          ; 0022C
        move.l  d0,-(a7)                        ; 0022E
        pea.l   -$49(a6)                        ; 00230
        pea.l   -$34(a6)                        ; 00234
        jsr     (IFFReadBytes).l                ; 00238
        lea.l   $c(a7),a7                       ; 0023E
        moveq   #$14,d0                         ; 00242
        move.l  d0,-(a7)                        ; 00244
        move.l  -$8(a6),-(a7)                   ; 00246
        pea.l   -$34(a6)                        ; 0024A
        jsr     (IFFReadBytes).l                ; 0024E
        lea.l   $c(a7),a7                       ; 00254
        moveq   #$8,d0                          ; 00258
        move.l  d0,-(a7)                        ; 0025A
        pea.l   -$49(a6)                        ; 0025C
        pea.l   -$34(a6)                        ; 00260
        jsr     (IFFReadBytes).l                ; 00264
        lea.l   $c(a7),a7                       ; 0026A
        move.b  #$20,-$41(a6)                   ; 0026E
        pea.l   -$41(a6)                        ; 00274
        move.l  $c(a6),-(a7)                    ; 00278
        pea.l   -$34(a6)                        ; 0027C
        jsr     (GetCMAP).l                     ; 00280
        lea.l   $c(a7),a7                       ; 00286
        moveq   #$8,d0                          ; 0028A
        move.l  d0,-(a7)                        ; 0028C
        pea.l   -$49(a6)                        ; 0028E
        pea.l   -$34(a6)                        ; 00292
        jsr     (IFFReadBytes).l                ; 00296
        lea.l   $c(a7),a7                       ; 0029C
        moveq   #$4,d0                          ; 002A0
        move.l  d0,-(a7)                        ; 002A2
        pea.l   -$49(a6)                        ; 002A4
        pea.l   -$34(a6)                        ; 002A8
        jsr     (IFFReadBytes).l                ; 002AC
        lea.l   $c(a7),a7                       ; 002B2
        move.l  #$10002,-(a7)                   ; 002B6
        moveq   #$28,d0                         ; 002BC
        move.l  d0,-(a7)                        ; 002BE
        jsr     (_AllocMem).l                   ; 002C0
        addq.l  #$8,a7                          ; 002C6
        moveq   #$0,d1                          ; 002C8
        movea.l -$8(a6),a0                      ; 002CA
        move.b  $8(a0),d1                       ; 002CE
        moveq   #$0,d2                          ; 002D2
        move.w  (a0),d2                         ; 002D4
        moveq   #$0,d3                          ; 002D6
        move.w  $2(a0),d3                       ; 002D8
        move.l  d3,-(a7)                        ; 002DC
        move.l  d2,-(a7)                        ; 002DE
        move.l  d1,-(a7)                        ; 002E0
        move.l  d0,-(a7)                        ; 002E2
        move.l  d0,-$4e(a6)                     ; 002E4
        jsr     (_InitBitMap).l                 ; 002E8
        lea.l   $10(a7),a7                      ; 002EE
        clr.l   -$4(a6)                         ; 002F2
l_000_002F6:
        moveq   #$0,d0                          ; 002F6
        movea.l -$8(a6),a0                      ; 002F8
        move.b  $8(a0),d0                       ; 002FC
        move.l  -$4(a6),d1                      ; 00300
        cmp.l   d0,d1                           ; 00304
        bcc.b   l_000_00340                     ; 00306
        move.w  (a0),d0                         ; 00308
        move.w  $2(a0),d2                       ; 0030A
        mulu.w  d2,d0                           ; 0030E
        lsr.l   #$3,d0                          ; 00310
        asl.l   #$2,d1                          ; 00312
        movea.l -$4e(a6),a0                     ; 00314
        addq.l  #$8,a0                          ; 00318
        adda.l  d1,a0                           ; 0031A
        move.l  #$10002,-(a7)                   ; 0031C
        move.l  d0,-(a7)                        ; 00322
        move.l  d0,-$40(a6)                     ; 00324
        move.l  a0,$10(a7)                      ; 00328
        jsr     (_AllocMem).l                   ; 0032C
        addq.l  #$8,a7                          ; 00332
        movea.l $8(a7),a0                       ; 00334
        move.l  d0,(a0)                         ; 00338
        addq.l  #$1,-$4(a6)                     ; 0033A
        bra.b   l_000_002F6                     ; 0033E
l_000_00340:
        moveq   #$0,d0                          ; 00340
        movea.l -$4e(a6),a0                     ; 00342
        move.w  (a0),d0                         ; 00346
        move.l  d0,$8(a7)                       ; 00348
        addi.l  #$7f,d0                         ; 0034C
        lsr.l   #$7,d0                          ; 00352
        move.l  $8(a7),d1                       ; 00354
        add.l   d0,d1                           ; 00358
        asl.l   #$1,d1                          ; 0035A
        move.l  #$10002,-(a7)                   ; 0035C
        move.l  d1,-(a7)                        ; 00362
        move.l  d1,-$3c(a6)                     ; 00364
        jsr     (_AllocMem).l                   ; 00368
        addq.l  #$8,a7                          ; 0036E
        moveq   #$8,d1                          ; 00370
        move.l  d1,-(a7)                        ; 00372
        pea.l   -$49(a6)                        ; 00374
        pea.l   -$34(a6)                        ; 00378
        move.l  d0,-$38(a6)                     ; 0037C
        jsr     (IFFReadBytes).l                ; 00380
        lea.l   $c(a7),a7                       ; 00386
        move.l  -$3c(a6),-(a7)                  ; 0038A
        move.l  -$38(a6),-(a7)                  ; 0038E
        move.l  -$8(a6),-(a7)                   ; 00392
        clr.l   -(a7)                           ; 00396
        move.l  -$4e(a6),-(a7)                  ; 00398
        pea.l   -$34(a6)                        ; 0039C
        jsr     (GetBODY).l                     ; 003A0
        lea.l   $18(a7),a7                      ; 003A6
        pea.l   -$34(a6)                        ; 003AA
        jsr     (CloseRGroup).l                 ; 003AE
        addq.l  #$4,a7                          ; 003B4
        move.l  -$10(a6),-(a7)                  ; 003B6
        jsr     (_Close).l                      ; 003BA
        addq.l  #$4,a7                          ; 003C0
        move.l  -$4e(a6),d0                     ; 003C2
        movem.l (a7)+,d2-d3                     ; 003C6
        unlk    a6                              ; 003CA
        rts                                     ; 003CC

;-------------------------------------------------------------------------------
; main - The game's main(): opens graphics.library and the sound, loads the title picture
; (pix/splsh), checks it, sets up the display, runs the title sequence, then loads the other
; two pictures (pix/inst5, pix/frnt5) and goes on into the game.
;-------------------------------------------------------------------------------
main:
        link.w  a6,#$ffe8                       ; 003CE
        movem.l d2/a2-a3,-(a7)                  ; 003D2
        move.w  #$3,(dat_071_00112).l           ; 003D6
        moveq   #$1d,d0                         ; 003DE
        move.l  d0,-(a7)                        ; 003E0
        pea.l   (dat_001_0005C).l               ; 003E2
        jsr     (_OpenLibrary).l                ; 003E8
        addq.l  #$8,a7                          ; 003EE
        move.l  d0,(_GfxBase).l                 ; 003F0
        tst.l   d0                              ; 003F6
        bne.b   l_000_00404                     ; 003F8
        clr.l   -(a7)                           ; 003FA
        jsr     (exit).l                        ; 003FC
        addq.l  #$4,a7                          ; 00402
l_000_00404:
        jsr     (InitSound).l                   ; 00404
        move.l  d0,-$4(a6)                      ; 0040A
        tst.l   d0                              ; 0040E
        beq.b   l_000_00418                     ; 00410
        jsr     (CloseSound).l                  ; 00412
l_000_00418:
        clr.b   (dat_071_001A7).l               ; 00418
        clr.l   (dat_071_00528).l               ; 0041E
        move.b  #$1,(dat_071_001A6).l           ; 00424
        pea.l   (TitleBMHD).l                   ; 0042C
        pea.l   (PictureColours).l              ; 00432
        pea.l   (dat_001_0006D).l               ; 00438
        bsr.w   LoadPicture                     ; 0043E
        lea.l   $c(a7),a7                       ; 00442
        move.l  d0,(TitleBitMap).l              ; 00446
        clr.l   -(a7)                           ; 0044C
        jsr     (_FreeSprite).l                 ; 0044E
        addq.l  #$4,a7                          ; 00454
        jsr     (LoadSound201).l                ; 00456
        clr.l   -(a7)                           ; 0045C
        jsr     (_FreeSprite).l                 ; 0045E
        addq.l  #$4,a7                          ; 00464
        moveq   #$2,d0                          ; 00466
        move.l  d0,-(a7)                        ; 00468
        jsr     (_AvailMem).l                   ; 0046A
        addq.l  #$4,a7                          ; 00470
        move.l  d0,-$4(a6)                      ; 00472
        cmpi.l  #$30d40,d0                      ; 00476
        ble.b   l_000_00484                     ; 0047C
        jsr     (LoadMusicSamples).l            ; 0047E
l_000_00484:
        clr.l   -(a7)                           ; 00484
        jsr     (_FreeSprite).l                 ; 00486
        addq.l  #$4,a7                          ; 0048C
        jsr     (InitDisplay).l                 ; 0048E
        bsr.w   CloseWorkbenchScreen            ; 00494
        pea.l   (GameViewPort).l                ; 00498
        jsr     (_WaitBOVP).l                   ; 0049E
        addq.l  #$4,a7                          ; 004A4
        pea.l   (GameView).l                    ; 004A6
        jsr     (_LoadView).l                   ; 004AC
        addq.l  #$4,a7                          ; 004B2
        movea.l (TitleBitMap).l,a1              ; 004B4
        movea.l $8(a1),a0                       ; 004BA
        movea.l $c(a1),a1                       ; 004BE
        movea.l (TitleBitMap).l,a3              ; 004C2
        movea.l $10(a3),a2                      ; 004C8
        movea.l $14(a3),a3                      ; 004CC
        moveq   #$0,d0                          ; 004D0
        move.w  (TitleBMHD).l,d0                ; 004D2
        moveq   #$0,d1                          ; 004D8
        move.w  (dat_002_028DA).l,d1            ; 004DA
        move.l  d1,-(a7)                        ; 004E0
        move.l  d0,-(a7)                        ; 004E2
        move.l  a3,-(a7)                        ; 004E4
        move.l  a2,-(a7)                        ; 004E6
        move.l  a1,-(a7)                        ; 004E8
        move.l  a0,-(a7)                        ; 004EA
        move.l  a0,-$c(a6)                      ; 004EC
        move.l  a1,-$10(a6)                     ; 004F0
        move.l  a2,-$14(a6)                     ; 004F4
        move.l  a3,-$18(a6)                     ; 004F8
        jsr     (ChecksumPlanes).l              ; 004FC
        lea.l   $18(a7),a7                      ; 00502
        move.w  d0,(TitleChecksum).l            ; 00506
        cmpi.w  #$c560,d0                       ; 0050C
        bne.b   l_000_0057E                     ; 00510
        pea.l   (GameViewPort).l                ; 00512
        jsr     (_WaitBOVP).l                   ; 00518
        addq.l  #$4,a7                          ; 0051E
        move.l  #$21000,-(a7)                   ; 00520
        bsr.w   BusyWait                        ; 00526
        addq.l  #$4,a7                          ; 0052A
        clr.l   -(a7)                           ; 0052C
        jsr     (_FreeSprite).l                 ; 0052E
        addq.l  #$4,a7                          ; 00534
        move.l  #$3f0000,d0                     ; 00536
        move.l  d0,(dat_074_000FE).l            ; 0053C
        move.l  d0,(dat_071_00038).l            ; 00542
        btst    #$7,(dat_071_0052B).l           ; 00548
        beq.b   l_000_00560                     ; 00550
        moveq   #$32,d0                         ; 00552
        move.l  d0,-(a7)                        ; 00554
        jsr     (sub_000_09CE6).l               ; 00556
        addq.l  #$4,a7                          ; 0055C
        bra.b   l_000_0056C                     ; 0055E
l_000_00560:
        moveq   #$f,d0                          ; 00560
        move.l  d0,-(a7)                        ; 00562
        jsr     (sub_000_09D7A).l               ; 00564
        addq.l  #$4,a7                          ; 0056A
l_000_0056C:
        move.l  #$43000,-(a7)                   ; 0056C
        bsr.w   BusyWait                        ; 00572
        addq.l  #$4,a7                          ; 00576
        jsr     (SaveTitleBitMap).l             ; 00578
l_000_0057E:
        movea.l (GameColorMap).l,a0             ; 0057E
        move.l  $4(a0),-$8(a6)                  ; 00584
        clr.l   -$4(a6)                         ; 0058A
l_000_0058E:
        cmpi.l  #$20,-$4(a6)                    ; 0058E
        bge.b   l_000_005A8                     ; 00596
        movea.l -$8(a6),a0                      ; 00598
        clr.w   (a0)                            ; 0059C
        addq.l  #$2,-$8(a6)                     ; 0059E
        addq.l  #$1,-$4(a6)                     ; 005A2
        bra.b   l_000_0058E                     ; 005A6
l_000_005A8:
        pea.l   (GameViewPort).l                ; 005A8
        jsr     (_WaitBOVP).l                   ; 005AE
        addq.l  #$4,a7                          ; 005B4
        moveq   #$20,d0                         ; 005B6
        move.l  d0,-(a7)                        ; 005B8
        movea.l (GameColorMap).l,a0             ; 005BA
        move.l  $4(a0),-(a7)                    ; 005C0
        pea.l   (GameViewPort).l                ; 005C4
        jsr     (_LoadRGB4).l                   ; 005CA
        lea.l   $c(a7),a7                       ; 005D0
        move.w  (TitleChecksum).l,d0            ; 005D4
        cmpi.w  #$c560,d0                       ; 005DA
        bne.w   l_000_00698                     ; 005DE
        jsr     (_OwnBlitter).l                 ; 005E2
        jsr     (sub_036_000C8).l               ; 005E8
        jsr     (_WaitBlit).l                   ; 005EE
        jsr     (CopyTitleToScreen).l           ; 005F4
        jsr     (_WaitBlit).l                   ; 005FA
        jsr     (_DisownBlitter).l              ; 00600
        movea.l (GameColorMap).l,a0             ; 00606
        move.l  $4(a0),-$8(a6)                  ; 0060C
        clr.l   -$4(a6)                         ; 00612
l_000_00616:
        move.l  -$4(a6),d0                      ; 00616
        cmpi.l  #$20,d0                         ; 0061A
        bge.b   l_000_0063C                     ; 00620
        asl.l   #$1,d0                          ; 00622
        movea.l d0,a0                           ; 00624
        adda.l  #PictureColours,a0              ; 00626
        movea.l -$8(a6),a1                      ; 0062C
        move.w  (a0),(a1)                       ; 00630
        addq.l  #$2,-$8(a6)                     ; 00632
        addq.l  #$1,-$4(a6)                     ; 00636
        bra.b   l_000_00616                     ; 0063A
l_000_0063C:
        pea.l   (GameViewPort).l                ; 0063C
        jsr     (_WaitBOVP).l                   ; 00642
        addq.l  #$4,a7                          ; 00648
        moveq   #$20,d0                         ; 0064A
        move.l  d0,-(a7)                        ; 0064C
        movea.l (GameColorMap).l,a0             ; 0064E
        move.l  $4(a0),-(a7)                    ; 00654
        pea.l   (GameViewPort).l                ; 00658
        jsr     (_LoadRGB4).l                   ; 0065E
        lea.l   $c(a7),a7                       ; 00664
        btst    #$7,(dat_071_0052B).l           ; 00668
        beq.b   l_000_00680                     ; 00670
        move.l  #$20000,-(a7)                   ; 00672
        bsr.w   BusyWait                        ; 00678
        addq.l  #$4,a7                          ; 0067C
        bra.b   l_000_00698                     ; 0067E
l_000_00680:
        moveq   #$32,d0                         ; 00680
        move.l  d0,-(a7)                        ; 00682
        jsr     (sub_000_09D7A).l               ; 00684
        addq.l  #$4,a7                          ; 0068A
        move.l  #$a000,-(a7)                    ; 0068C
        bsr.w   BusyWait                        ; 00692
        addq.l  #$4,a7                          ; 00696
l_000_00698:
        bsr.w   SetupGameDisplay                ; 00698
        clr.l   -(a7)                           ; 0069C
        jsr     (_FreeSprite).l                 ; 0069E
        addq.l  #$4,a7                          ; 006A4
        tst.l   (_GfxBase).l                    ; 006A6
        beq.b   l_000_006BC                     ; 006AC
        move.l  (_GfxBase).l,-(a7)              ; 006AE
        jsr     (_CloseLibrary).l               ; 006B4
        addq.l  #$4,a7                          ; 006BA
l_000_006BC:
        pea.l   (PanelBMHD).l                   ; 006BC
        pea.l   (PictureColours).l              ; 006C2
        pea.l   (dat_001_0007B).l               ; 006C8
        bsr.w   LoadPicture                     ; 006CE
        lea.l   $c(a7),a7                       ; 006D2
        move.l  d0,(PanelBitMap).l              ; 006D6
        pea.l   (FrontBMHD).l                   ; 006DC
        pea.l   (PictureColours).l              ; 006E2
        pea.l   (dat_001_00089).l               ; 006E8
        bsr.w   LoadPicture                     ; 006EE
        lea.l   $c(a7),a7                       ; 006F2
        move.l  d0,(FrontBitMap).l              ; 006F6
        movea.l (PanelBitMap).l,a1              ; 006FC
        movea.l $8(a1),a0                       ; 00702
        movea.l $c(a1),a2                       ; 00706
        movea.l $10(a1),a3                      ; 0070A
        movea.l $14(a1),a1                      ; 0070E
        moveq   #$0,d1                          ; 00712
        move.w  (PanelBMHD).l,d1                ; 00714
        moveq   #$0,d2                          ; 0071A
        move.w  (dat_002_02906).l,d2            ; 0071C
        move.l  d2,-(a7)                        ; 00722
        move.l  d1,-(a7)                        ; 00724
        move.l  a1,-(a7)                        ; 00726
        move.l  a3,-(a7)                        ; 00728
        move.l  a2,-(a7)                        ; 0072A
        move.l  a0,-(a7)                        ; 0072C
        move.l  a0,-$c(a6)                      ; 0072E
        move.l  a1,-$18(a6)                     ; 00732
        move.l  a2,-$10(a6)                     ; 00736
        move.l  a3,-$14(a6)                     ; 0073A
        jsr     (ChecksumPlanes).l              ; 0073E
        lea.l   $18(a7),a7                      ; 00744
        move.w  d0,(dat_071_00020).l            ; 00748
        movea.l (FrontBitMap).l,a1              ; 0074E
        movea.l $8(a1),a0                       ; 00754
        movea.l $c(a1),a2                       ; 00758
        movea.l $10(a1),a3                      ; 0075C
        movea.l $14(a1),a1                      ; 00760
        moveq   #$0,d0                          ; 00764
        move.w  (FrontBMHD).l,d0                ; 00766
        moveq   #$0,d1                          ; 0076C
        move.w  (dat_002_02936).l,d1            ; 0076E
        move.l  d1,-(a7)                        ; 00774
        move.l  d0,-(a7)                        ; 00776
        move.l  a1,-(a7)                        ; 00778
        move.l  a3,-(a7)                        ; 0077A
        move.l  a2,-(a7)                        ; 0077C
        move.l  a0,-(a7)                        ; 0077E
        move.l  a0,-$c(a6)                      ; 00780
        move.l  a1,-$18(a6)                     ; 00784
        move.l  a2,-$10(a6)                     ; 00788
        move.l  a3,-$14(a6)                     ; 0078C
        jsr     (ChecksumPlanes).l              ; 00790
        lea.l   $18(a7),a7                      ; 00796
        move.w  d0,(dat_071_00024).l            ; 0079A
        jsr     (RunGame).l                     ; 007A0
        movem.l (a7)+,d2/a2-a3                  ; 007A6
        unlk    a6                              ; 007AA
        rts                                     ; 007AC

;-------------------------------------------------------------------------------
; CloseWorkbenchScreen - Opens intuition.library just to close the Workbench screen
; (CloseWorkBench, frees chip RAM), then closes it again.
;-------------------------------------------------------------------------------
CloseWorkbenchScreen:
        moveq   #$1d,d0                         ; 007AE
        move.l  d0,-(a7)                        ; 007B0
        pea.l   (dat_001_00097).l               ; 007B2
        jsr     (_OpenLibrary).l                ; 007B8
        addq.l  #$8,a7                          ; 007BE
        move.l  d0,(_IntuitionBase).l           ; 007C0
        tst.l   d0                              ; 007C6
        bne.b   l_000_007D4                     ; 007C8
        clr.l   -(a7)                           ; 007CA
        jsr     (exit).l                        ; 007CC
        addq.l  #$4,a7                          ; 007D2
l_000_007D4:
        clr.l   -(a7)                           ; 007D4
        jsr     (_FreeSprite).l                 ; 007D6
        addq.l  #$4,a7                          ; 007DC
        jsr     (_CloseWorkBench).l             ; 007DE
        clr.l   -(a7)                           ; 007E4
        jsr     (_FreeSprite).l                 ; 007E6
        addq.l  #$4,a7                          ; 007EC
        tst.l   (_IntuitionBase).l              ; 007EE
        beq.b   l_000_00804                     ; 007F4
        move.l  (_IntuitionBase).l,-(a7)        ; 007F6
        jsr     (_CloseLibrary).l               ; 007FC
        addq.l  #$4,a7                          ; 00802
l_000_00804:
        rts                                     ; 00804

;-------------------------------------------------------------------------------
; SetupGameDisplay - Gives the title picture's planes to the game display: frees the display's
; own first plane buffer and points the game BitMap's four planes at the picture's (also kept
; in dat_071_000A2-000AE), makes the copper lists (sub_036_0004E), and allocates two $1F40-byte
; chip buffers.
;-------------------------------------------------------------------------------
SetupGameDisplay:
        movem.l a2,-(a7)                        ; 00806
        moveq   #$0,d0                          ; 0080A
        move.w  (TitleBMHD).l,d0                ; 0080C
        moveq   #$0,d1                          ; 00812
        move.w  (dat_002_028DA).l,d1            ; 00814
        move.l  d1,-(a7)                        ; 0081A
        move.l  d0,-(a7)                        ; 0081C
        movea.l (TitleBitMap).l,a0              ; 0081E
        move.l  $18(a0),-(a7)                   ; 00824
        jsr     (_FreeRaster).l                 ; 00828
        lea.l   $c(a7),a7                       ; 0082E
        movea.l (GameBitMap2).l,a0              ; 00832
        movea.l (TitleBitMap).l,a2              ; 00838
        movea.l $8(a2),a1                       ; 0083E
        move.l  a1,$8(a0)                       ; 00842
        move.l  a1,(dat_071_000A2).l            ; 00846
        movea.l (TitleBitMap).l,a2              ; 0084C
        movea.l $c(a2),a1                       ; 00852
        move.l  a1,$c(a0)                       ; 00856
        move.l  a1,(dat_071_000A6).l            ; 0085A
        movea.l (TitleBitMap).l,a2              ; 00860
        movea.l $10(a2),a1                      ; 00866
        move.l  a1,$10(a0)                      ; 0086A
        move.l  a1,(dat_071_000AA).l            ; 0086E
        movea.l (TitleBitMap).l,a2              ; 00874
        movea.l $14(a2),a1                      ; 0087A
        move.l  a1,$14(a0)                      ; 0087E
        move.l  a1,(dat_071_000AE).l            ; 00882
        jsr     (sub_036_0004E).l               ; 00888
        move.l  #$10002,-(a7)                   ; 0088E
        move.l  #$1f40,-(a7)                    ; 00894
        jsr     (_AllocMem).l                   ; 0089A
        addq.l  #$8,a7                          ; 008A0
        move.l  d0,(dat_071_000B2).l            ; 008A2
        tst.l   d0                              ; 008A8
        bne.b   l_000_008BA                     ; 008AA
        move.l  #$fffffc18,-(a7)                ; 008AC
        jsr     (exit).l                        ; 008B2
        addq.l  #$4,a7                          ; 008B8
l_000_008BA:
        move.l  #$10001,-(a7)                   ; 008BA
        move.l  #$202,-(a7)                     ; 008C0
        jsr     (_AllocMem).l                   ; 008C6
        addq.l  #$8,a7                          ; 008CC
        move.l  d0,(dat_073_016A4).l            ; 008CE
        movem.l (a7)+,a2                        ; 008D4
        rts                                     ; 008D8

;-------------------------------------------------------------------------------
; BusyWait - BusyWait(count): counts to count (a delay), then FreeSprite(0).
;-------------------------------------------------------------------------------
BusyWait:
        link.w  a6,#$fffc                       ; 008DA
        clr.l   -$4(a6)                         ; 008DE
l_000_008E2:
        move.l  -$4(a6),d0                      ; 008E2
        cmp.l   $8(a6),d0                       ; 008E6
        bge.b   l_000_008F2                     ; 008EA
        addq.l  #$1,-$4(a6)                     ; 008EC
        bra.b   l_000_008E2                     ; 008F0
l_000_008F2:
        clr.l   -(a7)                           ; 008F2
        jsr     (_FreeSprite).l                 ; 008F4
        addq.l  #$4,a7                          ; 008FA
        unlk    a6                              ; 008FC
        rts                                     ; 008FE

;-------------------------------------------------------------------------------
; GetCMAP - GetCMAP(context, colours, &ncolours): reads the CMAP chunk's RGB triplets (3 bytes
; each) and stores each as an RGB4 word ($0RGB, the top 4 bits of each); *ncolours = min(its
; value, the chunk's size / 3).
;-------------------------------------------------------------------------------
GetCMAP:
        link.w  a6,#$fff4                       ; 00900
        movea.l $8(a6),a0                       ; 00904
        move.l  $18(a0),d0                      ; 00908
        moveq   #$3,d1                          ; 0090C
        jsr     (CXD33).l                       ; 0090E
        moveq   #$0,d1                          ; 00914
        movea.l $10(a6),a0                      ; 00916
        move.b  (a0),d1                         ; 0091A
        move.l  d0,-$4(a6)                      ; 0091C
        cmp.l   d0,d1                           ; 00920
        bcc.b   l_000_0092C                     ; 00922
        moveq   #$0,d0                          ; 00924
        move.b  (a0),d0                         ; 00926
        move.l  d0,-$4(a6)                      ; 00928
l_000_0092C:
        move.l  -$4(a6),d0                      ; 0092C
        movea.l $10(a6),a0                      ; 00930
        move.b  d0,(a0)                         ; 00934
l_000_00936:
        tst.l   -$4(a6)                         ; 00936
        ble.b   l_000_00990                     ; 0093A
        lea.l   -$b(a6),a0                      ; 0093C
        moveq   #$3,d0                          ; 00940
        move.l  d0,-(a7)                        ; 00942
        move.l  a0,-(a7)                        ; 00944
        move.l  $8(a6),-(a7)                    ; 00946
        jsr     (IFFReadBytes).l                ; 0094A
        lea.l   $c(a7),a7                       ; 00950
        move.l  d0,-$8(a6)                      ; 00954
        tst.l   d0                              ; 00958
        beq.b   l_000_00960                     ; 0095A
        unlk    a6                              ; 0095C
        rts                                     ; 0095E
l_000_00960:
        moveq   #$0,d0                          ; 00960
        move.b  -$b(a6),d0                      ; 00962
        lsr.l   #$4,d0                          ; 00966
        asl.l   #$8,d0                          ; 00968
        moveq   #$0,d1                          ; 0096A
        move.b  -$a(a6),d1                      ; 0096C
        lsr.l   #$4,d1                          ; 00970
        asl.l   #$4,d1                          ; 00972
        or.l    d1,d0                           ; 00974
        moveq   #$0,d1                          ; 00976
        move.b  -$9(a6),d1                      ; 00978
        lsr.l   #$4,d1                          ; 0097C
        or.l    d1,d0                           ; 0097E
        movea.l $c(a6),a0                       ; 00980
        move.w  d0,(a0)                         ; 00984
        addq.l  #$2,$c(a6)                      ; 00986
        subq.l  #$1,-$4(a6)                     ; 0098A
        bra.b   l_000_00936                     ; 0098E
l_000_00990:
        moveq   #$0,d0                          ; 00990
        unlk    a6                              ; 00992
        rts                                     ; 00994

;-------------------------------------------------------------------------------
; GetBODY - GetBODY(context, bitmap, mask, bmhd, buffer, bufsize): reads the BODY chunk into
; the BitMap's planes row by row: uncompressed (IFFReadBytes), or ByteRun1 (compression 1)
; through _UnPackRow; an extra mask plane (masking 1) goes to mask if given. CLIENT_ERROR (-6)
; for an unknown compression or a BitMap too small, BAD_FORM (-7) for bad compressed data.
;-------------------------------------------------------------------------------
GetBODY:
        link.w  a6,#$ff8c                       ; 00996
        movem.l d2,-(a7)                        ; 0099A
        movea.l $14(a6),a0                      ; 0099E
        move.b  $8(a0),-$5(a6)                  ; 009A2
        moveq   #$0,d0                          ; 009A8
        move.w  (a0),d0                         ; 009AA
        addi.l  #$f,d0                          ; 009AC
        lsr.l   #$4,d0                          ; 009B2
        asl.l   #$1,d0                          ; 009B4
        move.l  d0,-$a(a6)                      ; 009B6
        addi.l  #$7f,d0                         ; 009BA
        asr.l   #$7,d0                          ; 009C0
        move.l  -$a(a6),d1                      ; 009C2
        add.l   d0,d1                           ; 009C6
        moveq   #$0,d0                          ; 009C8
        move.w  $2(a0),d0                       ; 009CA
        move.b  $a(a0),d2                       ; 009CE
        move.l  d0,-$12(a6)                     ; 009D2
        move.l  d1,-$e(a6)                      ; 009D6
        move.b  d2,-$13(a6)                     ; 009DA
        cmpi.b  #$1,d2                          ; 009DE
        bls.b   l_000_009EE                     ; 009E2
        moveq   #-6,d0                          ; 009E4
        movem.l (a7)+,d2                        ; 009E6
        unlk    a6                              ; 009EA
        rts                                     ; 009EC
l_000_009EE:
        moveq   #$0,d0                          ; 009EE
        movea.l $c(a6),a0                       ; 009F0
        move.w  (a0),d0                         ; 009F4
        move.l  -$a(a6),d1                      ; 009F6
        cmp.l   d0,d1                           ; 009FA
        bne.b   l_000_00A14                     ; 009FC
        move.l  -$e(a6),d0                      ; 009FE
        asl.l   #$1,d0                          ; 00A02
        move.l  $1c(a6),d1                      ; 00A04
        cmp.l   d0,d1                           ; 00A08
        blt.b   l_000_00A14                     ; 00A0A
        cmpi.b  #$11,-$5(a6)                    ; 00A0C
        bls.b   l_000_00A1E                     ; 00A12
l_000_00A14:
        moveq   #-6,d0                          ; 00A14
        movem.l (a7)+,d2                        ; 00A16
        unlk    a6                              ; 00A1A
        rts                                     ; 00A1C
l_000_00A1E:
        moveq   #$0,d0                          ; 00A1E
        movea.l $c(a6),a0                       ; 00A20
        move.w  $2(a0),d0                       ; 00A24
        move.l  -$12(a6),d1                     ; 00A28
        cmp.l   d0,d1                           ; 00A2C
        bls.b   l_000_00A3A                     ; 00A2E
        moveq   #$0,d1                          ; 00A30
        move.w  $2(a0),d1                       ; 00A32
        move.l  d1,-$12(a6)                     ; 00A36
l_000_00A3A:
        clr.l   -$18(a6)                        ; 00A3A
l_000_00A3E:
        moveq   #$0,d0                          ; 00A3E
        movea.l $c(a6),a0                       ; 00A40
        move.b  $5(a0),d0                       ; 00A44
        move.l  -$18(a6),d1                     ; 00A48
        cmp.l   d0,d1                           ; 00A4C
        bcc.b   l_000_00A60                     ; 00A4E
        asl.l   #$2,d1                          ; 00A50
        addq.l  #$8,a0                          ; 00A52
        adda.l  d1,a0                           ; 00A54
        move.l  (a0),-$74(a6,d1.l)              ; 00A56
        addq.l  #$1,-$18(a6)                    ; 00A5A
        bra.b   l_000_00A3E                     ; 00A5E
l_000_00A60:
        move.l  -$18(a6),d0                     ; 00A60
        cmpi.l  #$11,d0                         ; 00A64
        bge.b   l_000_00A78                     ; 00A6A
        asl.l   #$2,d0                          ; 00A6C
        clr.l   -$74(a6,d0.l)                   ; 00A6E
        addq.l  #$1,-$18(a6)                    ; 00A72
        bra.b   l_000_00A60                     ; 00A76
l_000_00A78:
        movea.l $14(a6),a0                      ; 00A78
        move.b  $9(a0),d0                       ; 00A7C
        subq.b  #$1,d0                          ; 00A80
        bne.b   l_000_00AAA                     ; 00A82
        tst.l   $10(a6)                         ; 00A84
        beq.b   l_000_00A9A                     ; 00A88
        moveq   #$0,d0                          ; 00A8A
        move.b  -$5(a6),d0                      ; 00A8C
        asl.l   #$2,d0                          ; 00A90
        move.l  $10(a6),-$74(a6,d0.l)           ; 00A92
        bra.b   l_000_00AA6                     ; 00A98
l_000_00A9A:
        moveq   #$0,d0                          ; 00A9A
        move.b  -$5(a6),d0                      ; 00A9C
        asl.l   #$2,d0                          ; 00AA0
        clr.l   -$74(a6,d0.l)                   ; 00AA2
l_000_00AA6:
        addq.b  #$1,-$5(a6)                     ; 00AA6
l_000_00AAA:
        movea.l $18(a6),a0                      ; 00AAA
        adda.l  -$e(a6),a0                      ; 00AAE
        move.l  a0,-$28(a6)                     ; 00AB2
        move.l  -$12(a6),-$1c(a6)               ; 00AB6
l_000_00ABC:
        tst.l   -$1c(a6)                        ; 00ABC
        ble.w   l_000_00BEE                     ; 00AC0
        clr.l   -$18(a6)                        ; 00AC4
l_000_00AC8:
        moveq   #$0,d0                          ; 00AC8
        move.b  -$5(a6),d0                      ; 00ACA
        move.l  -$18(a6),d1                     ; 00ACE
        cmp.l   d0,d1                           ; 00AD2
        bcc.w   l_000_00BE6                     ; 00AD4
        asl.l   #$2,d1                          ; 00AD8
        lea.l   -$74(a6),a0                     ; 00ADA
        adda.l  d1,a0                           ; 00ADE
        move.l  a0,-$30(a6)                     ; 00AE0
        tst.l   (a0)                            ; 00AE4
        bne.b   l_000_00AFC                     ; 00AE6
        movea.l $18(a6),a0                      ; 00AE8
        adda.l  -$e(a6),a0                      ; 00AEC
        move.l  a0,-$2c(a6)                     ; 00AF0
        lea.l   -$2c(a6),a0                     ; 00AF4
        move.l  a0,-$30(a6)                     ; 00AF8
l_000_00AFC:
        tst.b   -$13(a6)                        ; 00AFC
        bne.b   l_000_00B38                     ; 00B00
        move.l  -$a(a6),-(a7)                   ; 00B02
        movea.l -$30(a6),a0                     ; 00B06
        move.l  (a0),-(a7)                      ; 00B0A
        move.l  $8(a6),-(a7)                    ; 00B0C
        jsr     (IFFReadBytes).l                ; 00B10
        lea.l   $c(a7),a7                       ; 00B16
        move.l  d0,-$4(a6)                      ; 00B1A
        tst.l   d0                              ; 00B1E
        beq.b   l_000_00B2A                     ; 00B20
        movem.l (a7)+,d2                        ; 00B22
        unlk    a6                              ; 00B26
        rts                                     ; 00B28
l_000_00B2A:
        move.l  -$a(a6),d0                      ; 00B2A
        movea.l -$30(a6),a0                     ; 00B2E
        add.l   d0,(a0)                         ; 00B32
        bra.w   l_000_00BDE                     ; 00B34
l_000_00B38:
        move.l  -$28(a6),d0                     ; 00B38
        sub.l   $18(a6),d0                      ; 00B3C
        move.l  -$e(a6),d1                      ; 00B40
        sub.l   d0,d1                           ; 00B44
        move.l  d1,-(a7)                        ; 00B46
        move.l  $18(a6),-(a7)                   ; 00B48
        move.l  -$28(a6),-(a7)                  ; 00B4C
        move.l  d0,-$20(a6)                     ; 00B50
        move.l  d1,-$24(a6)                     ; 00B54
        jsr     (movmem).l                      ; 00B58
        lea.l   $c(a7),a7                       ; 00B5E
        movea.l $8(a6),a0                       ; 00B62
        move.l  $18(a0),d0                      ; 00B66
        sub.l   $20(a0),d0                      ; 00B6A
        move.l  -$20(a6),d1                     ; 00B6E
        cmp.l   d0,d1                           ; 00B72
        ble.b   l_000_00B84                     ; 00B74
        move.l  -$24(a6),d1                     ; 00B76
        add.l   d0,d1                           ; 00B7A
        move.l  d0,-$20(a6)                     ; 00B7C
        move.l  d1,-$e(a6)                      ; 00B80
l_000_00B84:
        movea.l $18(a6),a0                      ; 00B84
        adda.l  -$24(a6),a0                     ; 00B88
        move.l  -$20(a6),-(a7)                  ; 00B8C
        move.l  a0,-(a7)                        ; 00B90
        move.l  $8(a6),-(a7)                    ; 00B92
        jsr     (IFFReadBytes).l                ; 00B96
        lea.l   $c(a7),a7                       ; 00B9C
        move.l  d0,-$4(a6)                      ; 00BA0
        tst.l   d0                              ; 00BA4
        beq.b   l_000_00BB0                     ; 00BA6
        movem.l (a7)+,d2                        ; 00BA8
        unlk    a6                              ; 00BAC
        rts                                     ; 00BAE
l_000_00BB0:
        move.l  $18(a6),-$28(a6)                ; 00BB0
        move.l  -$a(a6),-(a7)                   ; 00BB6
        move.l  -$e(a6),-(a7)                   ; 00BBA
        move.l  -$30(a6),-(a7)                  ; 00BBE
        pea.l   -$28(a6)                        ; 00BC2
        jsr     (_UnPackRow).l                  ; 00BC6
        lea.l   $10(a7),a7                      ; 00BCC
        tst.w   d0                              ; 00BD0
        beq.b   l_000_00BDE                     ; 00BD2
        moveq   #-7,d0                          ; 00BD4
        movem.l (a7)+,d2                        ; 00BD6
        unlk    a6                              ; 00BDA
        rts                                     ; 00BDC
l_000_00BDE:
        addq.l  #$1,-$18(a6)                    ; 00BDE
        bra.w   l_000_00AC8                     ; 00BE2
l_000_00BE6:
        subq.l  #$1,-$1c(a6)                    ; 00BE6
        bra.w   l_000_00ABC                     ; 00BEA
l_000_00BEE:
        moveq   #$0,d0                          ; 00BEE
        movem.l (a7)+,d2                        ; 00BF0
        unlk    a6                              ; 00BF4
        rts                                     ; 00BF6

;-------------------------------------------------------------------------------
; FileLength - FileLength(file): the file's length (Seek to the end and back), NO_FILE (-5) if
; there is no file, DOS_ERROR (-3) if Seek fails.
;-------------------------------------------------------------------------------
FileLength:
        link.w  a6,#$fffc                       ; 00BF8
        moveq   #-5,d0                          ; 00BFC
        move.l  d0,-$4(a6)                      ; 00BFE
        tst.l   $8(a6)                          ; 00C02
        ble.b   l_000_00C3E                     ; 00C06
        moveq   #$1,d0                          ; 00C08
        move.l  d0,-(a7)                        ; 00C0A
        clr.l   -(a7)                           ; 00C0C
        move.l  $8(a6),-(a7)                    ; 00C0E
        jsr     (_Seek).l                       ; 00C12
        lea.l   $c(a7),a7                       ; 00C18
        moveq   #$0,d0                          ; 00C1C
        move.l  d0,-(a7)                        ; 00C1E
        move.l  d0,-(a7)                        ; 00C20
        move.l  $8(a6),-(a7)                    ; 00C22
        jsr     (_Seek).l                       ; 00C26
        lea.l   $c(a7),a7                       ; 00C2C
        move.l  d0,-$4(a6)                      ; 00C30
        tst.l   d0                              ; 00C34
        bpl.b   l_000_00C3E                     ; 00C36
        moveq   #-3,d0                          ; 00C38
        move.l  d0,-$4(a6)                      ; 00C3A
l_000_00C3E:
        move.l  -$4(a6),d0                      ; 00C3E
        unlk    a6                              ; 00C42
        rts                                     ; 00C44

;-------------------------------------------------------------------------------
; OpenRIFF - OpenRIFF(file, context, clientFrame): makes the context for reading an IFF file
; (its bound = the file's length); NOT_IFF (-4) if it is shorter than 8 bytes.
;-------------------------------------------------------------------------------
OpenRIFF:
        link.w  a6,#$fff4                       ; 00C46
        move.l  $8(a6),d0                       ; 00C4A
        move.l  $c(a6),-$8(a6)                  ; 00C4E
        moveq   #$0,d1                          ; 00C54
        movea.l -$8(a6),a0                      ; 00C56
        move.l  d1,(a0)                         ; 00C5A
        move.l  $10(a6),$4(a0)                  ; 00C5C
        move.l  d0,$8(a0)                       ; 00C62
        move.l  d1,$c(a0)                       ; 00C66
        move.l  d1,$1c(a0)                      ; 00C6A
        move.l  d1,$14(a0)                      ; 00C6E
        move.l  d1,$20(a0)                      ; 00C72
        move.l  d1,$18(a0)                      ; 00C76
        move.l  d0,-(a7)                        ; 00C7A
        move.l  d0,-$4(a6)                      ; 00C7C
        move.l  d1,-$c(a6)                      ; 00C80
        bsr.w   FileLength                      ; 00C84
        addq.l  #$4,a7                          ; 00C88
        movea.l -$8(a6),a0                      ; 00C8A
        move.l  d0,$10(a0)                      ; 00C8E
        tst.l   d0                              ; 00C92
        bpl.b   l_000_00C9C                     ; 00C94
        move.l  d0,-$c(a6)                      ; 00C96
        bra.b   l_000_00CC6                     ; 00C9A
l_000_00C9C:
        movea.l -$8(a6),a0                      ; 00C9C
        cmpi.l  #$8,$10(a0)                     ; 00CA0
        bge.b   l_000_00CB2                     ; 00CA8
        moveq   #-4,d0                          ; 00CAA
        move.l  d0,-$c(a6)                      ; 00CAC
        bra.b   l_000_00CC6                     ; 00CB0
l_000_00CB2:
        moveq   #-1,d0                          ; 00CB2
        move.l  d0,-(a7)                        ; 00CB4
        clr.l   -(a7)                           ; 00CB6
        move.l  -$4(a6),-(a7)                   ; 00CB8
        jsr     (_Seek).l                       ; 00CBC
        lea.l   $c(a7),a7                       ; 00CC2
l_000_00CC6:
        move.l  -$c(a6),d0                      ; 00CC6
        unlk    a6                              ; 00CCA
        rts                                     ; 00CCC

;-------------------------------------------------------------------------------
; CloseRGroup - CloseRGroup(context): adds what was read in the group to its parent's position.
;-------------------------------------------------------------------------------
CloseRGroup:
        link.w  a6,#$fffc                       ; 00CCE
        movea.l $8(a6),a0                       ; 00CD2
        tst.l   (a0)                            ; 00CD6
        beq.b   l_000_00CF6                     ; 00CD8
        movea.l $8(a6),a0                       ; 00CDA
        move.l  $c(a0),d0                       ; 00CDE
        movea.l (a0),a0                         ; 00CE2
        move.l  d0,-$4(a6)                      ; 00CE4
        sub.l   $c(a0),d0                       ; 00CE8
        add.l   d0,$20(a0)                      ; 00CEC
        move.l  -$4(a6),$c(a0)                  ; 00CF0
l_000_00CF6:
        moveq   #$0,d0                          ; 00CF6
        unlk    a6                              ; 00CF8
        rts                                     ; 00CFA

;-------------------------------------------------------------------------------
; SkipFwd - SkipFwd(context, bytes): Seek forward; BAD_IFF (-9) if that fails.
;-------------------------------------------------------------------------------
SkipFwd:
        link.w  a6,#$fffc                       ; 00CFC
        moveq   #$0,d0                          ; 00D00
        move.l  d0,-$4(a6)                      ; 00D02
        tst.l   $c(a6)                          ; 00D06
        ble.b   l_000_00D3C                     ; 00D0A
        move.l  d0,-(a7)                        ; 00D0C
        move.l  $c(a6),-(a7)                    ; 00D0E
        movea.l $8(a6),a0                       ; 00D12
        move.l  $8(a0),-(a7)                    ; 00D16
        jsr     (_Seek).l                       ; 00D1A
        lea.l   $c(a7),a7                       ; 00D20
        addq.l  #$1,d0                          ; 00D24
        bne.b   l_000_00D30                     ; 00D26
        moveq   #-9,d0                          ; 00D28
        move.l  d0,-$4(a6)                      ; 00D2A
        bra.b   l_000_00D3C                     ; 00D2E
l_000_00D30:
        move.l  $c(a6),d0                       ; 00D30
        movea.l $8(a6),a0                       ; 00D34
        add.l   d0,$c(a0)                       ; 00D38
l_000_00D3C:
        move.l  -$4(a6),d0                      ; 00D3C
        unlk    a6                              ; 00D40
        rts                                     ; 00D42

;-------------------------------------------------------------------------------
; GetChunkHdr - GetChunkHdr(context): skips what is left of the current chunk (and its pad
; byte) and reads the next chunk's header (ID and size, into the context); for a group chunk
; (FORM, CAT, LIST, PROP) also its type ID. Returns the chunk ID, END_MARK (-1) at the end of
; the group, or BAD_IFF (-9).
;-------------------------------------------------------------------------------
GetChunkHdr:
        link.w  a6,#$fff4                       ; 00D44
        movea.l $8(a6),a0                       ; 00D48
        move.l  $18(a0),d0                      ; 00D4C
        sub.l   $20(a0),d0                      ; 00D50
        move.l  $18(a0),d1                      ; 00D54
        andi.l  #$1,d1                          ; 00D58
        add.l   d1,d0                           ; 00D5E
        move.l  d0,-(a7)                        ; 00D60
        move.l  a0,-(a7)                        ; 00D62
        move.l  a0,-$4(a6)                      ; 00D64
        bsr.b   SkipFwd                         ; 00D68
        addq.l  #$8,a7                          ; 00D6A
        move.l  d0,-$8(a6)                      ; 00D6C
        tst.l   d0                              ; 00D70
        beq.b   l_000_00D78                     ; 00D72
        unlk    a6                              ; 00D74
        rts                                     ; 00D76
l_000_00D78:
        moveq   #-9,d0                          ; 00D78
        movea.l -$4(a6),a0                      ; 00D7A
        move.l  d0,$14(a0)                      ; 00D7E
        moveq   #$0,d0                          ; 00D82
        move.l  d0,$1c(a0)                      ; 00D84
        move.l  d0,$20(a0)                      ; 00D88
        move.l  $10(a0),d0                      ; 00D8C
        sub.l   $c(a0),d0                       ; 00D90
        move.l  d0,-$c(a6)                      ; 00D94
        tst.l   d0                              ; 00D98
        bne.b   l_000_00DAA                     ; 00D9A
        clr.l   $18(a0)                         ; 00D9C
        moveq   #-1,d0                          ; 00DA0
        move.l  d0,$14(a0)                      ; 00DA2
        bra.w   l_000_00EE8                     ; 00DA6
l_000_00DAA:
        move.l  -$c(a6),d0                      ; 00DAA
        cmpi.l  #$8,d0                          ; 00DAE
        bge.b   l_000_00DC2                     ; 00DB4
        movea.l -$4(a6),a0                      ; 00DB6
        move.l  d0,$18(a0)                      ; 00DBA
        bra.w   l_000_00EE8                     ; 00DBE
l_000_00DC2:
        movea.l -$4(a6),a0                      ; 00DC2
        adda.w  #$14,a0                         ; 00DC6
        move.l  a0,d0                           ; 00DCA
        moveq   #$8,d1                          ; 00DCC
        move.l  d1,-(a7)                        ; 00DCE
        move.l  d0,-(a7)                        ; 00DD0
        movea.l -$4(a6),a0                      ; 00DD2
        move.l  $8(a0),-(a7)                    ; 00DD6
        jsr     (_Read).l                       ; 00DDA
        lea.l   $c(a7),a7                       ; 00DE0
        tst.l   d0                              ; 00DE4
        beq.b   l_000_00DFE                     ; 00DE6
        cmpi.l  #$ffffffff,d0                   ; 00DE8
        bne.b   l_000_00E0C                     ; 00DEE
        moveq   #-3,d0                          ; 00DF0
        movea.l -$4(a6),a0                      ; 00DF2
        move.l  d0,$14(a0)                      ; 00DF6
        unlk    a6                              ; 00DFA
        rts                                     ; 00DFC
l_000_00DFE:
        moveq   #-9,d0                          ; 00DFE
        movea.l -$4(a6),a0                      ; 00E00
        move.l  d0,$14(a0)                      ; 00E04
        unlk    a6                              ; 00E08
        rts                                     ; 00E0A
l_000_00E0C:
        movea.l -$4(a6),a0                      ; 00E0C
        tst.l   (a0)                            ; 00E10
        bne.b   l_000_00E40                     ; 00E12
        move.l  $14(a0),d0                      ; 00E14
        cmpi.l  #$43415420,d0                   ; 00E18
        beq.b   l_000_00E40                     ; 00E1E
        cmpi.l  #$4c495354,d0                   ; 00E20
        beq.b   l_000_00E40                     ; 00E26
        cmpi.l  #$464f524d,d0                   ; 00E28
        beq.b   l_000_00E40                     ; 00E2E
        nop                                     ; 00E30
        moveq   #-4,d0                          ; 00E32
        movea.l -$4(a6),a0                      ; 00E34
        move.l  d0,$14(a0)                      ; 00E38
        unlk    a6                              ; 00E3C
        rts                                     ; 00E3E
l_000_00E40:
        movea.l -$4(a6),a0                      ; 00E40
        addq.l  #$8,$c(a0)                      ; 00E44
        subq.l  #$8,-$c(a6)                     ; 00E48
        tst.l   $14(a0)                         ; 00E4C
        bgt.b   l_000_00E5C                     ; 00E50
        moveq   #-9,d0                          ; 00E52
        move.l  d0,$14(a0)                      ; 00E54
        bra.w   l_000_00EE8                     ; 00E58
l_000_00E5C:
        movea.l -$4(a6),a0                      ; 00E5C
        tst.l   $18(a0)                         ; 00E60
        bmi.b   l_000_00E70                     ; 00E64
        move.l  $18(a0),d0                      ; 00E66
        cmp.l   -$c(a6),d0                      ; 00E6A
        ble.b   l_000_00E82                     ; 00E6E
l_000_00E70:
        movea.l -$4(a6),a0                      ; 00E70
        move.l  -$c(a6),$18(a0)                 ; 00E74
        moveq   #-9,d0                          ; 00E7A
        move.l  d0,$14(a0)                      ; 00E7C
        bra.b   l_000_00EE8                     ; 00E80
l_000_00E82:
        movea.l -$4(a6),a0                      ; 00E82
        move.l  $14(a0),d0                      ; 00E86
        moveq   #$20,d1                         ; 00E8A
l_000_00E8C:
        subi.l  #$8,d1                          ; 00E8C
        bmi.b   l_000_00EE8                     ; 00E92
        cmp.l   dat_000_00E9E(pc,d1.l),d0       ; 00E94
        bne.b   l_000_00E8C                     ; 00E98
        jmp     dat_000_00EA2(pc,d1.l)          ; 00E9A
dat_000_00E9E:
	dc.b	$43,$41,$54,$20
dat_000_00EA2:
	dc.b	$60,$00,$00,$1A,$50,$52,$4F,$50,$60,$00,$00,$12,$46,$4F,$52,$4D
	dc.b	$60,$00,$00,$0A,$4C,$49,$53,$54,$60,$00,$00,$02,$20,$6E,$FF,$FC
	dc.b	$D0,$FC,$00,$1C,$20,$08,$72,$04,$2F,$01,$2F,$00,$2F,$2E,$FF,$FC
	dc.b	$61,$20,$4F,$EF,$00,$0C,$2D,$40,$FF,$F8,$4A,$80,$67,$08,$20,$6E
	dc.b	$FF,$FC,$21,$40,$00,$14
l_000_00EE8:
        movea.l -$4(a6),a0                      ; 00EE8
        move.l  $14(a0),d0                      ; 00EEC
        unlk    a6                              ; 00EF0
        rts                                     ; 00EF2

;-------------------------------------------------------------------------------
; IFFReadBytes - IFFReadBytes(context, buffer, nbytes): reads from the current chunk;
; CLIENT_ERROR (-6) for a negative count, SHORT_CHUNK (-8) if the chunk is shorter, DOS_ERROR
; (-3), BAD_IFF (-9) at the end of the file.
;-------------------------------------------------------------------------------
IFFReadBytes:
        link.w  a6,#$fffc                       ; 00EF4
        moveq   #$0,d0                          ; 00EF8
        move.l  d0,-$4(a6)                      ; 00EFA
        tst.l   $10(a6)                         ; 00EFE
        bpl.b   l_000_00F0C                     ; 00F02
        moveq   #-6,d0                          ; 00F04
        move.l  d0,-$4(a6)                      ; 00F06
        bra.b   l_000_00F74                     ; 00F0A
l_000_00F0C:
        movea.l $8(a6),a0                       ; 00F0C
        move.l  $18(a0),d0                      ; 00F10
        sub.l   $20(a0),d0                      ; 00F14
        move.l  $10(a6),d1                      ; 00F18
        cmp.l   d0,d1                           ; 00F1C
        ble.b   l_000_00F28                     ; 00F1E
        moveq   #-8,d0                          ; 00F20
        move.l  d0,-$4(a6)                      ; 00F22
        bra.b   l_000_00F74                     ; 00F26
l_000_00F28:
        tst.l   $10(a6)                         ; 00F28
        ble.b   l_000_00F74                     ; 00F2C
        move.l  $10(a6),-(a7)                   ; 00F2E
        move.l  $c(a6),-(a7)                    ; 00F32
        movea.l $8(a6),a0                       ; 00F36
        move.l  $8(a0),-(a7)                    ; 00F3A
        jsr     (_Read).l                       ; 00F3E
        lea.l   $c(a7),a7                       ; 00F44
        tst.l   d0                              ; 00F48
        beq.b   l_000_00F5C                     ; 00F4A
        cmpi.l  #$ffffffff,d0                   ; 00F4C
        bne.b   l_000_00F64                     ; 00F52
        moveq   #-3,d0                          ; 00F54
        move.l  d0,-$4(a6)                      ; 00F56
        bra.b   l_000_00F74                     ; 00F5A
l_000_00F5C:
        moveq   #-9,d0                          ; 00F5C
        move.l  d0,-$4(a6)                      ; 00F5E
        bra.b   l_000_00F74                     ; 00F62
l_000_00F64:
        move.l  $10(a6),d0                      ; 00F64
        movea.l $8(a6),a0                       ; 00F68
        add.l   d0,$c(a0)                       ; 00F6C
        add.l   d0,$20(a0)                      ; 00F70
l_000_00F74:
        move.l  -$4(a6),d0                      ; 00F74
        unlk    a6                              ; 00F78
        rts                                     ; 00F7A

;-------------------------------------------------------------------------------
; GetFChunkHdr - GetFChunkHdr(context): GetChunkHdr inside a FORM, where a PROP is not allowed
; (BAD_IFF).
;-------------------------------------------------------------------------------
GetFChunkHdr:
        link.w  a6,#$fffc                       ; 00F7C
        move.l  $8(a6),-(a7)                    ; 00F80
        bsr.w   GetChunkHdr                     ; 00F84
        addq.l  #$4,a7                          ; 00F88
        move.l  d0,-$4(a6)                      ; 00F8A
        cmpi.l  #$50524f50,d0                   ; 00F8E
        bne.b   l_000_00FA4                     ; 00F94
        moveq   #-9,d1                          ; 00F96
        movea.l $8(a6),a0                       ; 00F98
        move.l  d1,$14(a0)                      ; 00F9C
        move.l  d1,-$4(a6)                      ; 00FA0
l_000_00FA4:
        move.l  -$4(a6),d0                      ; 00FA4
        unlk    a6                              ; 00FA8
        rts                                     ; 00FAA

;-------------------------------------------------------------------------------
; AllocRecordBuffers - Allocates the flight recording's buffers from what fast/public memory is
; free: half of AvailMem(MEMF_PUBLIC|MEMF_FAST), at most 125,000 bytes, /16 - RecordLength
; bytes for the positions (RecordBuffer) and 4 * that + 8 for the controls (RecordControls).
; Returns 1 if both were allocated, else 0 (no recording).
;-------------------------------------------------------------------------------
AllocRecordBuffers:
        link.w  a6,#$fffa                       ; 00FAC
        clr.w   -$2(a6)                         ; 00FB0
        move.l  #$10001,-(a7)                   ; 00FB4
        jsr     (_AvailMem).l                   ; 00FBA
        addq.l  #$4,a7                          ; 00FC0
        move.l  d0,-$6(a6)                      ; 00FC2
        asr.l   #$1,d0                          ; 00FC6
        move.l  -$6(a6),d1                      ; 00FC8
        sub.l   d0,d1                           ; 00FCC
        move.l  d1,-$6(a6)                      ; 00FCE
        cmpi.l  #$1e848,d1                      ; 00FD2
        ble.b   l_000_00FE2                     ; 00FD8
        move.l  #$1e848,-$6(a6)                 ; 00FDA
l_000_00FE2:
        move.l  -$6(a6),d0                      ; 00FE2
        asr.l   #$4,d0                          ; 00FE6
        move.l  d0,-$6(a6)                      ; 00FE8
        addq.l  #$2,d0                          ; 00FEC
        move.l  #$10001,-(a7)                   ; 00FEE
        move.l  d0,-(a7)                        ; 00FF4
        jsr     (_AllocMem).l                   ; 00FF6
        addq.l  #$8,a7                          ; 00FFC
        move.l  d0,(RecordBuffer).l             ; 00FFE
        tst.l   d0                              ; 01004
        beq.b   l_000_0103A                     ; 01006
        move.l  -$6(a6),d0                      ; 01008
        move.l  d0,(RecordLength).l             ; 0100C
        asl.l   #$2,d0                          ; 01012
        move.l  d0,-$6(a6)                      ; 01014
        addq.l  #$8,d0                          ; 01018
        move.l  #$10001,-(a7)                   ; 0101A
        move.l  d0,-(a7)                        ; 01020
        jsr     (_AllocMem).l                   ; 01022
        addq.l  #$8,a7                          ; 01028
        move.l  d0,(RecordControls).l           ; 0102A
        tst.l   d0                              ; 01030
        beq.b   l_000_0103A                     ; 01032
        move.w  #$1,-$2(a6)                     ; 01034
l_000_0103A:
        tst.w   -$2(a6)                         ; 0103A
        bne.b   l_000_0104E                     ; 0103E
        suba.l  a0,a0                           ; 01040
        move.l  a0,(RecordBuffer).l             ; 01042
        move.l  a0,(RecordControls).l           ; 01048
l_000_0104E:
        move.w  -$2(a6),d0                      ; 0104E
        ext.l   d0                              ; 01052
        unlk    a6                              ; 01054
        rts                                     ; 01056

;-------------------------------------------------------------------------------
; CheckDisk - Info() on df0:: returns 1 if that fails, 2 if the disk is not a DOS disk
; ('BAD\0'), 3 if it is write protected (ID_WRITE_PROTECTED), 0 if the config can be written.
;-------------------------------------------------------------------------------
CheckDisk:
        link.w  a6,#$fff0                       ; 01058
        move.l  #$10001,-(a7)                   ; 0105C
        moveq   #$28,d0                         ; 01062
        move.l  d0,-(a7)                        ; 01064
        jsr     (_AllocMem).l                   ; 01066
        addq.l  #$8,a7                          ; 0106C
        move.l  d0,(InfoData).l                 ; 0106E
        addq.l  #$3,d0                          ; 01074
        andi.l  #$fffffffc,d0                   ; 01076
        move.l  d0,(InfoData).l                 ; 0107C
        moveq   #-2,d1                          ; 01082
        move.l  d1,-(a7)                        ; 01084
        pea.l   (dat_001_000AC).l               ; 01086
        move.l  d0,-$10(a6)                     ; 0108C
        jsr     (_Lock).l                       ; 01090
        addq.l  #$8,a7                          ; 01096
        move.l  (InfoData).l,-(a7)              ; 01098
        move.l  d0,-(a7)                        ; 0109E
        move.l  d0,-$c(a6)                      ; 010A0
        jsr     (_Info).l                       ; 010A4
        addq.l  #$8,a7                          ; 010AA
        move.l  -$c(a6),-(a7)                   ; 010AC
        jsr     (_UnLock).l                     ; 010B0
        addq.l  #$4,a7                          ; 010B6
        movea.l (InfoData).l,a0                 ; 010B8
        move.l  $18(a0),d0                      ; 010BE
        move.l  d0,-$4(a6)                      ; 010C2
        tst.l   d0                              ; 010C6
        bpl.b   l_000_010D2                     ; 010C8
        moveq   #$1,d0                          ; 010CA
        move.l  d0,-$8(a6)                      ; 010CC
        bra.b   l_000_01100                     ; 010D0
l_000_010D2:
        cmpi.l  #$42414400,-$4(a6)              ; 010D2
        bne.b   l_000_010E4                     ; 010DA
        moveq   #$2,d0                          ; 010DC
        move.l  d0,-$8(a6)                      ; 010DE
        bra.b   l_000_01100                     ; 010E2
l_000_010E4:
        movea.l (InfoData).l,a0                 ; 010E4
        cmpi.l  #$50,$8(a0)                     ; 010EA
        bne.b   l_000_010FC                     ; 010F2
        moveq   #$3,d0                          ; 010F4
        move.l  d0,-$8(a6)                      ; 010F6
        bra.b   l_000_01100                     ; 010FA
l_000_010FC:
        clr.l   -$8(a6)                         ; 010FC
l_000_01100:
        tst.l   (InfoData).l                    ; 01100
        beq.b   l_000_0111A                     ; 01106
        moveq   #$28,d0                         ; 01108
        move.l  d0,-(a7)                        ; 0110A
        move.l  (InfoData).l,-(a7)              ; 0110C
        jsr     (_FreeMem).l                    ; 01112
        addq.l  #$8,a7                          ; 01118
l_000_0111A:
        move.l  -$8(a6),d0                      ; 0111A
        unlk    a6                              ; 0111E
        rts                                     ; 01120
	dc.b	$00,$00

;-------------------------------------------------------------------------------
; GameFrame - One frame of the game: the cockpit and the flight model, the other aircraft and
; the weapons, the 3D view and the instruments, the sound, the keyboard and the flight
; recording, in a fixed order; FrameStage is set before each part (so a crash says where it
; was).
;-------------------------------------------------------------------------------
GameFrame:
        link.w  a6,#$fffe                       ; 01124
        move.w  (FrameCount).l,-$2(a6)          ; 01128
        bsr.w   ReadControls                    ; 01130
        jsr     (sub_000_01748).l               ; 01134
        jsr     (sub_000_03C94).l               ; 0113A
        tst.b   (dat_071_00165).l               ; 01140
        beq.w   l_000_014C0                     ; 01146
        move.w  #$8,(FrameStage).l              ; 0114A
        jsr     (sub_000_041E8).l               ; 01152
        move.w  #$10,(FrameStage).l             ; 01158
        jsr     (sub_022_000B6).l               ; 01160
        jsr     (UpdateViewCell).l              ; 01166
        move.w  #$20,(FrameStage).l             ; 0116C
        jsr     (sub_022_000B4).l               ; 01174
        jsr     (SetupCamera).l                 ; 0117A
        jsr     (sub_008_00286).l               ; 01180
        jsr     (sub_020_00738).l               ; 01186
        jsr     (sub_000_043F2).l               ; 0118C
        jsr     (sub_008_00598).l               ; 01192
        move.w  #$60,(FrameStage).l             ; 01198
        jsr     (sub_020_007EA).l               ; 011A0
        jsr     (sub_020_00AB4).l               ; 011A6
        jsr     (sub_033_00010).l               ; 011AC
        move.w  #$68,(FrameStage).l             ; 011B2
        move.b  (dat_071_0026B).l,d0            ; 011BA
        tst.b   d0                              ; 011C0
        beq.b   l_000_011CC                     ; 011C2
        tst.b   (dat_071_00180).l               ; 011C4
        beq.b   l_000_011D2                     ; 011CA
l_000_011CC:
        jsr     (sub_028_00B9C).l               ; 011CC
l_000_011D2:
        move.w  #$70,(FrameStage).l             ; 011D2
        jsr     (sub_033_003CE).l               ; 011DA
        cmpi.l  #$f8000000,(dat_071_00436).l    ; 011E0
        ble.w   l_000_01274                     ; 011EA
        move.w  #$78,(FrameStage).l             ; 011EE
        jsr     (sub_008_0084C).l               ; 011F6
        move.w  #$80,(FrameStage).l             ; 011FC
        jsr     (sub_008_0085E).l               ; 01204
        move.w  #$90,(FrameStage).l             ; 0120A
        jsr     (sub_025_00000).l               ; 01212
        move.w  #$a0,(FrameStage).l             ; 01218
        tst.b   (dat_071_0017D).l               ; 01220
        beq.b   l_000_01230                     ; 01226
        jsr     (sub_000_072DC).l               ; 01228
        bra.b   l_000_01274                     ; 0122E
l_000_01230:
        jsr     (sub_023_00000).l               ; 01230
        tst.l   d0                              ; 01236
        beq.b   l_000_01258                     ; 01238
        move.w  #$a4,(FrameStage).l             ; 0123A
        jsr     (sub_000_072DC).l               ; 01242
        move.w  #$a8,(FrameStage).l             ; 01248
        jsr     (DrawObjects).l                 ; 01250
        bra.b   l_000_01274                     ; 01256
l_000_01258:
        move.w  #$ac,(FrameStage).l             ; 01258
        jsr     (DrawObjects).l                 ; 01260
        move.w  #$b0,(FrameStage).l             ; 01266
        jsr     (sub_000_072DC).l               ; 0126E
l_000_01274:
        move.w  #$c0,(FrameStage).l             ; 01274
        jsr     (sub_000_03D4C).l               ; 0127C
        jsr     (sub_000_04AA0).l               ; 01282
        move.w  #$d0,(FrameStage).l             ; 01288
        move.b  (dat_071_00155).l,d0            ; 01290
        tst.b   d0                              ; 01296
        beq.b   l_000_012A4                     ; 01298
        tst.b   (dat_071_00206).l               ; 0129A
        beq.w   l_000_013F8                     ; 012A0
l_000_012A4:
        move.w  (dat_071_002AC).l,d0            ; 012A4
        moveq   #$9,d1                          ; 012AA
        ext.l   d0                              ; 012AC
        asl.l   d1,d0                           ; 012AE
        movea.l d0,a0                           ; 012B0
        adda.l  #ObjectTable,a0                 ; 012B2
        move.b  $62(a0),d0                      ; 012B8
        cmpi.b  #$30,d0                         ; 012BC
        bne.b   l_000_012CC                     ; 012C0
        tst.b   (dat_071_00206).l               ; 012C2
        beq.w   l_000_0142C                     ; 012C8
l_000_012CC:
        jsr     (DrawPanel).l                   ; 012CC
        jsr     (sub_037_002F6).l               ; 012D2
        jsr     (sub_038_000FE).l               ; 012D8
        jsr     (sub_040_00064).l               ; 012DE
        jsr     (sub_038_00002).l               ; 012E4
        jsr     (sub_037_008B8).l               ; 012EA
        move.b  (dat_071_00207).l,d0            ; 012F0
        tst.b   d0                              ; 012F6
        bgt.b   l_000_01308                     ; 012F8
        move.w  -$2(a6),d0                      ; 012FA
        andi.w  #$3,d0                          ; 012FE
        cmpi.w  #$1,d0                          ; 01302
        ble.b   l_000_01314                     ; 01306
l_000_01308:
        jsr     (sub_039_005B6).l               ; 01308
        jsr     (sub_039_0064C).l               ; 0130E
l_000_01314:
        move.b  (dat_071_00207).l,d0            ; 01314
        tst.b   d0                              ; 0131A
        bgt.b   l_000_0132C                     ; 0131C
        move.w  -$2(a6),d0                      ; 0131E
        andi.w  #$3,d0                          ; 01322
        cmpi.w  #$2,d0                          ; 01326
        bge.b   l_000_01332                     ; 0132A
l_000_0132C:
        jsr     (sub_039_00878).l               ; 0132C
l_000_01332:
        move.b  (dat_071_00207).l,d0            ; 01332
        tst.b   d0                              ; 01338
        bgt.b   l_000_01356                     ; 0133A
        move.w  -$2(a6),d0                      ; 0133C
        andi.w  #$3,d0                          ; 01340
        cmpi.w  #$2,d0                          ; 01344
        blt.b   l_000_01356                     ; 01348
        cmpi.l  #$ffff8000,(dat_071_00436).l    ; 0134A
        ble.b   l_000_0135C                     ; 01354
l_000_01356:
        jsr     (sub_039_0071A).l               ; 01356
l_000_0135C:
        move.b  (dat_071_00207).l,d0            ; 0135C
        tst.b   d0                              ; 01362
        bgt.b   l_000_01374                     ; 01364
        move.w  -$2(a6),d0                      ; 01366
        andi.w  #$7,d0                          ; 0136A
        cmpi.w  #$2,d0                          ; 0136E
        bge.b   l_000_0137A                     ; 01372
l_000_01374:
        jsr     (sub_039_0082A).l               ; 01374
l_000_0137A:
        move.b  (dat_071_00207).l,d0            ; 0137A
        tst.b   d0                              ; 01380
        bgt.b   l_000_01392                     ; 01382
        move.w  -$2(a6),d0                      ; 01384
        andi.w  #$f,d0                          ; 01388
        cmpi.w  #$2,d0                          ; 0138C
        bge.b   l_000_01398                     ; 01390
l_000_01392:
        jsr     (sub_037_00258).l               ; 01392
l_000_01398:
        move.w  #$1a0,(FrameStage).l            ; 01398
        jsr     (sub_036_00BAA).l               ; 013A0
        jsr     (sub_039_00FA8).l               ; 013A6
        jsr     (sub_037_00340).l               ; 013AC
        jsr     (sub_039_008D2).l               ; 013B2
        jsr     (sub_039_00960).l               ; 013B8
        jsr     (sub_039_001CC).l               ; 013BE
        jsr     (sub_037_00674).l               ; 013C4
        jsr     (sub_039_00164).l               ; 013CA
        jsr     (sub_039_009EE).l               ; 013D0
        jsr     (sub_037_0049C).l               ; 013D6
        move.b  (dat_071_00207).l,d0            ; 013DC
        tst.b   d0                              ; 013E2
        bmi.b   l_000_013EE                     ; 013E4
        subq.b  #$1,d0                          ; 013E6
        move.b  d0,(dat_071_00207).l            ; 013E8
l_000_013EE:
        move.w  #$1d0,(FrameStage).l            ; 013EE
        bra.b   l_000_0142C                     ; 013F6
l_000_013F8:
        tst.b   (dat_071_00155).l               ; 013F8
        beq.b   l_000_0142C                     ; 013FE
        move.b  #$1,(dat_071_001A9).l           ; 01400
        jsr     (sub_039_0064C).l               ; 01408
        jsr     (sub_039_0071A).l               ; 0140E
        jsr     (sub_039_005B6).l               ; 01414
        nop                                     ; 0141A
        move.b  (dat_071_00276).l,d0            ; 0141C
        subq.b  #$2,d0                          ; 01422
        bne.b   l_000_0142C                     ; 01424
        jsr     (sub_039_009EE).l               ; 01426
l_000_0142C:
        move.w  #$1d4,(FrameStage).l            ; 0142C
        jsr     (sub_000_04392).l               ; 01434
        jsr     (sub_039_0064A).l               ; 0143A
        jsr     (sub_029_001A4).l               ; 01440
        jsr     (sub_020_00562).l               ; 01446
        move.w  -$2(a6),d0                      ; 0144C
        andi.w  #$7,d0                          ; 01450
        subq.w  #$7,d0                          ; 01454
        bne.b   l_000_0145E                     ; 01456
        jsr     (sub_020_006DA).l               ; 01458
l_000_0145E:
        move.w  -$2(a6),d0                      ; 0145E
        andi.w  #$f,d0                          ; 01462
        subq.w  #$4,d0                          ; 01466
        bne.b   l_000_01474                     ; 01468
        clr.l   -(a7)                           ; 0146A
        jsr     (_FreeSprite).l                 ; 0146C
        addq.l  #$4,a7                          ; 01472
l_000_01474:
        move.w  -$2(a6),d0                      ; 01474
        andi.w  #$1f,d0                         ; 01478
        subq.w  #$8,d0                          ; 0147C
        bne.b   l_000_01488                     ; 0147E
        jsr     (sub_036_000F2).l               ; 01480
        bra.b   l_000_014A6                     ; 01486
l_000_01488:
        move.b  (dat_071_0027E).l,d0            ; 01488
        tst.b   d0                              ; 0148E
        bne.b   l_000_014A6                     ; 01490
        move.w  -$2(a6),d0                      ; 01492
        andi.w  #$1f,d0                         ; 01496
        cmpi.w  #$10,d0                         ; 0149A
        bne.b   l_000_014A6                     ; 0149E
        jsr     (RedrawInstruments).l           ; 014A0
l_000_014A6:
        move.b  (dat_071_0017E).l,d0            ; 014A6
        tst.b   d0                              ; 014AC
        bne.b   l_000_014D0                     ; 014AE
        move.w  (FrameCount).l,d0               ; 014B0
        addq.w  #$1,d0                          ; 014B6
        move.w  d0,(FrameCount).l               ; 014B8
        bra.b   l_000_014D0                     ; 014BE
l_000_014C0:
        jsr     (sub_000_04AA0).l               ; 014C0
        clr.l   -(a7)                           ; 014C6
        jsr     (_FreeSprite).l                 ; 014C8
        addq.l  #$4,a7                          ; 014CE
l_000_014D0:
        jsr     (sub_029_00002).l               ; 014D0
        tst.b   (dat_071_00182).l               ; 014D6
        beq.b   l_000_01502                     ; 014DC
        tst.b   (dat_071_00165).l               ; 014DE
        beq.b   l_000_01502                     ; 014E4
        move.w  #$210,(FrameStage).l            ; 014E6
        jsr     (sub_036_0000C).l               ; 014EE
        move.w  #$218,(FrameStage).l            ; 014F4
        jsr     (sub_039_00276).l               ; 014FC
l_000_01502:
        move.w  #$220,(FrameStage).l            ; 01502
        jsr     (sub_039_013EE).l               ; 0150A
        unlk    a6                              ; 01510
        rts                                     ; 01512

;-------------------------------------------------------------------------------
; ReadControls - Reads the controls once a frame: the joystick (ReadJoystick) and the fire /
; mouse buttons (ReadButtons; a change goes to sub_000_05E84), then every key waiting (GetKey
; -> HandleKey).
;-------------------------------------------------------------------------------
ReadControls:
        link.w  a6,#$fffa                       ; 01514
        jsr     (ReadJoystick).l                ; 01518
        jsr     (ReadButtons).l                 ; 0151E
        move.w  (dat_071_0014E).l,d1            ; 01524
        move.w  d0,-$6(a6)                      ; 0152A
        cmp.w   d0,d1                           ; 0152E
        beq.b   l_000_01544                     ; 01530
        move.w  d0,(dat_071_0014E).l            ; 01532
        move.w  d0,(dat_071_00150).l            ; 01538
        jsr     (sub_000_05E84).l               ; 0153E
l_000_01544:
        move.b  (RecordMode).l,d0               ; 01544
        move.b  d0,-$2(a6)                      ; 0154A
        cmpi.b  #$1,d0                          ; 0154E
        beq.b   l_000_01558                     ; 01552
        subq.b  #$2,d0                          ; 01554
        bne.b   l_000_01568                     ; 01556
l_000_01558:
        tst.w   (FrameEvents1).l                ; 01558
        beq.b   l_000_0158A                     ; 0155E
        jsr     (sub_005_00010).l               ; 01560
        bra.b   l_000_01558                     ; 01566
l_000_01568:
        cmpi.b  #$3,-$2(a6)                     ; 01568
        bne.b   l_000_0158A                     ; 0156E
l_000_01570:
        move.w  (FrameEvents1).l,d0             ; 01570
        move.w  (FrameEvents2).l,d1             ; 01576
        or.w    d1,d0                           ; 0157C
        tst.w   d0                              ; 0157E
        beq.b   l_000_0158A                     ; 01580
        jsr     (sub_005_00010).l               ; 01582
        bra.b   l_000_01570                     ; 01588
l_000_0158A:
        jsr     (GetKey).l                      ; 0158A
        move.b  d0,-$1(a6)                      ; 01590
        cmpi.b  #$ff,d0                         ; 01594
        beq.b   l_000_015B0                     ; 01598
        move.b  d0,-$3(a6)                      ; 0159A
        andi.l  #$ff,d0                         ; 0159E
        move.l  d0,-(a7)                        ; 015A4
        jsr     (HandleKey).l                   ; 015A6
        addq.l  #$4,a7                          ; 015AC
        bra.b   l_000_0158A                     ; 015AE
l_000_015B0:
        tst.b   -$2(a6)                         ; 015B0
        bne.b   l_000_015DA                     ; 015B4
        move.w  (JoyEvents).l,(FrameEvents1).l  ; 015B6
        move.w  (dat_071_0036C).l,(FrameEvents2).l ; 015C0
        moveq   #$0,d0                          ; 015CA
        move.w  d0,(JoyEvents).l                ; 015CC
        move.w  d0,(dat_071_0036C).l            ; 015D2
        bra.b   l_000_015F2                     ; 015D8
l_000_015DA:
        cmpi.b  #$1,-$2(a6)                     ; 015DA
        bne.b   l_000_015F2                     ; 015E0
        move.w  (dat_071_0036C).l,(FrameEvents2).l ; 015E2
        clr.w   (dat_071_0036C).l               ; 015EC
l_000_015F2:
        unlk    a6                              ; 015F2
        rts                                     ; 015F4
sub_000_015F6:
        clr.l   -(a7)                           ; 015F6
        jsr     (StopSound).l                   ; 015F8
        addq.l  #$4,a7                          ; 015FE
        moveq   #$1,d0                          ; 01600
        move.l  d0,-(a7)                        ; 01602
        jsr     (StopSound).l                   ; 01604
        addq.l  #$4,a7                          ; 0160A
        moveq   #$2,d0                          ; 0160C
        move.l  d0,-(a7)                        ; 0160E
        jsr     (StopSound).l                   ; 01610
        addq.l  #$4,a7                          ; 01616
        moveq   #$3,d0                          ; 01618
        move.l  d0,-(a7)                        ; 0161A
        jsr     (StopSound).l                   ; 0161C
        addq.l  #$4,a7                          ; 01622
        rts                                     ; 01624
	dc.b	$00,$00

;-------------------------------------------------------------------------------
; InitInput - Opens the input: the timer, the keyboard, the joystick (gameport), the mouse
; interrupt; raises the task's priority (SetTaskPri) and installs the input.device handler.
;-------------------------------------------------------------------------------
InitInput:
        link.w  a6,#$fffc                       ; 01628
        jsr     (OpenTimer).l                   ; 0162C
        jsr     (OpenKeyboard).l                ; 01632
        pea.l   (dat_001_000B4).l               ; 01638
        jsr     (_FindTask).l                   ; 0163E
        addq.l  #$4,a7                          ; 01644
        moveq   #-128,d1                        ; 01646
        move.l  d1,-(a7)                        ; 01648
        move.l  d0,-(a7)                        ; 0164A
        move.l  d0,-$4(a6)                      ; 0164C
        jsr     (_SetTaskPri).l                 ; 01650
        addq.l  #$8,a7                          ; 01656
        jsr     (OpenJoystick).l                ; 01658
        jsr     (sub_020_004CC).l               ; 0165E
        jsr     (LoadEngineSounds).l            ; 01664
        move.l  #$3c0,d0                        ; 0166A
        move.l  d0,-(a7)                        ; 01670
        move.l  d0,-(a7)                        ; 01672
        move.l  #$fffffc40,d0                   ; 01674
        move.l  d0,-(a7)                        ; 0167A
        move.l  d0,-(a7)                        ; 0167C
        jsr     (SetMouseLimits).l              ; 0167E
        lea.l   $10(a7),a7                      ; 01684
        moveq   #$64,d0                         ; 01688
        move.l  d0,-(a7)                        ; 0168A
        move.l  #$a0,-(a7)                      ; 0168C
        jsr     (InitMouse).l                   ; 01692
        addq.l  #$8,a7                          ; 01698
        clr.b   (RecordMode).l                  ; 0169A
        jsr     (sub_004_0002C).l               ; 016A0
        jsr     (GetDifficulty).l               ; 016A6
        lea.l   sub_000_01962(pc),a0            ; 016AC
        move.l  a0,(dat_002_00004).l            ; 016B0
        unlk    a6                              ; 016B6
        rts                                     ; 016B8
sub_000_016BA:
        link.w  a6,#$fffe                       ; 016BA
        move.b  $13(a6),d0                      ; 016BE
        ext.w   d0                              ; 016C2
        ext.l   d0                              ; 016C4
        add.l   d0,$8(a6)                       ; 016C6
        clr.b   -$1(a6)                         ; 016CA
l_000_016CE:
        move.b  -$1(a6),d0                      ; 016CE
        cmp.b   $13(a6),d0                      ; 016D2
        bge.b   l_000_01712                     ; 016D6
        move.l  $c(a6),d0                       ; 016D8
        andi.l  #$f,d0                          ; 016DC
        addi.l  #$30,d0                         ; 016E2
        move.b  d0,-$2(a6)                      ; 016E8
        cmpi.b  #$39,d0                         ; 016EC
        ble.b   l_000_016F6                     ; 016F0
        addq.b  #$7,-$2(a6)                     ; 016F2
l_000_016F6:
        movea.l $8(a6),a0                       ; 016F6
        move.b  -$2(a6),(a0)                    ; 016FA
        subq.l  #$1,$8(a6)                      ; 016FE
        addq.b  #$1,-$1(a6)                     ; 01702
        move.l  $c(a6),d0                       ; 01706
        lsr.l   #$4,d0                          ; 0170A
        move.l  d0,$c(a6)                       ; 0170C
        bra.b   l_000_016CE                     ; 01710
l_000_01712:
        subq.b  #$1,$13(a6)                     ; 01712
        addq.l  #$1,$8(a6)                      ; 01716
        clr.b   -$1(a6)                         ; 0171A
l_000_0171E:
        move.b  -$1(a6),d0                      ; 0171E
        cmp.b   $13(a6),d0                      ; 01722
        bge.b   l_000_01744                     ; 01726
        movea.l $8(a6),a0                       ; 01728
        move.b  (a0),d0                         ; 0172C
        cmpi.b  #$30,d0                         ; 0172E
        bne.b   l_000_01744                     ; 01732
        move.b  #$20,(a0)                       ; 01734
        addq.l  #$1,$8(a6)                      ; 01738
        nop                                     ; 0173C
        addq.b  #$1,-$1(a6)                     ; 0173E
        bra.b   l_000_0171E                     ; 01742
l_000_01744:
        unlk    a6                              ; 01744
        rts                                     ; 01746
sub_000_01748:
        link.w  a6,#$fffc                       ; 01748
        move.b  (dat_071_00268).l,d0            ; 0174C
        tst.b   d0                              ; 01752
        bmi.w   l_000_01922                     ; 01754
        move.b  (dat_071_00276).l,d0            ; 01758
        tst.b   d0                              ; 0175E
        ble.w   l_000_01922                     ; 01760
        tst.b   (dat_071_001FA).l               ; 01764
        beq.w   l_000_01820                     ; 0176A
        move.b  (dat_071_00160).l,d0            ; 0176E
        tst.b   d0                              ; 01774
        bne.w   l_000_01820                     ; 01776
        move.b  (dat_071_001FC).l,d0            ; 0177A
        tst.b   d0                              ; 01780
        bpl.w   l_000_01820                     ; 01782
        tst.l   (dat_071_002E4).l               ; 01786
        beq.w   l_000_01820                     ; 0178C
        move.l  (TimeSeconds).l,d0              ; 01790
        sub.l   (dat_071_002E4).l,d0            ; 01796
        sub.l   (dat_071_002D8).l,d0            ; 0179C
        move.l  d0,-$4(a6)                      ; 017A2
        tst.l   (dat_071_002D4).l               ; 017A6
        beq.b   l_000_017BE                     ; 017AC
        move.l  (TimeSeconds).l,d1              ; 017AE
        sub.l   (dat_071_002D4).l,d1            ; 017B4
        sub.l   d1,-$4(a6)                      ; 017BA
l_000_017BE:
        move.l  -$4(a6),d0                      ; 017BE
        sub.l   (dat_071_002E0).l,d0            ; 017C2
        move.l  d0,-$4(a6)                      ; 017C8
        tst.l   (dat_071_002DC).l               ; 017CC
        beq.b   l_000_017E4                     ; 017D2
        move.l  (TimeSeconds).l,d1              ; 017D4
        sub.l   (dat_071_002DC).l,d1            ; 017DA
        sub.l   d1,-$4(a6)                      ; 017E0
l_000_017E4:
        tst.l   -$4(a6)                         ; 017E4
        bmi.b   l_000_0180C                     ; 017E8
        cmpi.l  #$4650,-$4(a6)                  ; 017EA
        bge.b   l_000_0180C                     ; 017F2
        move.l  -$4(a6),d0                      ; 017F4
        movea.l (ConfigBuffer).l,a0             ; 017F8
        add.l   d0,$8(a0)                       ; 017FE
        move.b  #$1,(dat_071_00195).l           ; 01802
        bra.b   l_000_0181A                     ; 0180A
l_000_0180C:
        move.w  #$3f,(dat_071_0036E).l          ; 0180C
        jsr     (Nop).l                         ; 01814
l_000_0181A:
        clr.l   (dat_071_002E4).l               ; 0181A
l_000_01820:
        move.b  (dat_071_00168).l,d0            ; 01820
        tst.b   d0                              ; 01826
        bmi.w   l_000_018EC                     ; 01828
        move.b  (dat_071_001FA).l,d0            ; 0182C
        cmpi.b  #$ff,d0                         ; 01832
        bne.b   l_000_01854                     ; 01836
        moveq   #$0,d0                          ; 01838
        move.b  d0,(dat_071_001FA).l            ; 0183A
        move.b  d0,(dat_071_001FB).l            ; 01840
        lea.l   sub_000_01A70(pc),a0            ; 01846
        move.l  a0,(dat_002_00004).l            ; 0184A
        bra.w   l_000_01922                     ; 01850
l_000_01854:
        move.b  (dat_071_001FA).l,d0            ; 01854
        subq.b  #$1,d0                          ; 0185A
        bne.b   l_000_018A0                     ; 0185C
        clr.b   (dat_071_001FA).l               ; 0185E
        tst.b   (dat_071_0027C).l               ; 01864
        beq.b   l_000_01874                     ; 0186A
        move.b  #$1,(dat_071_001FB).l           ; 0186C
l_000_01874:
        move.b  #$1,(dat_071_0017E).l           ; 01874
        move.w  #$3,(dat_071_004A6).l           ; 0187C
        moveq   #$0,d0                          ; 01884
        move.b  d0,(dat_071_00165).l            ; 01886
        move.b  d0,(dat_071_00271).l            ; 0188C
        lea.l   sub_000_01A96(pc),a0            ; 01892
        move.l  a0,(dat_002_00004).l            ; 01896
        bra.w   l_000_01922                     ; 0189C
l_000_018A0:
        move.b  (dat_071_001FA).l,d0            ; 018A0
        subq.b  #$2,d0                          ; 018A6
        bne.b   l_000_01922                     ; 018A8
        moveq   #$0,d0                          ; 018AA
        move.b  d0,(dat_071_001FB).l            ; 018AC
        move.b  (dat_071_001FC).l,d0            ; 018B2
        tst.b   d0                              ; 018B8
        bpl.b   l_000_01922                     ; 018BA
        move.b  #$f0,(dat_071_00168).l          ; 018BC
        clr.b   (dat_071_001FA).l               ; 018C4
        moveq   #$1,d0                          ; 018CA
        move.b  d0,(dat_071_0027D).l            ; 018CC
        move.b  d0,(dat_071_0017E).l            ; 018D2
        move.w  #$6,(dat_071_004A6).l           ; 018D8
        lea.l   dat_000_0319C(pc),a0            ; 018E0
        move.l  a0,(dat_002_00004).l            ; 018E4
        bra.b   l_000_01922                     ; 018EA
l_000_018EC:
        move.b  (dat_071_001FA).l,d0            ; 018EC
        subq.b  #$3,d0                          ; 018F2
        bne.b   l_000_01922                     ; 018F4
        moveq   #$0,d0                          ; 018F6
        move.b  d0,(dat_071_001FB).l            ; 018F8
        move.b  (dat_071_001FC).l,d0            ; 018FE
        tst.b   d0                              ; 01904
        bpl.b   l_000_01922                     ; 01906
        clr.b   (dat_071_001FA).l               ; 01908
        move.w  (dat_071_00290).l,(dat_071_004A6).l ; 0190E
        lea.l   dat_000_031C8(pc),a0            ; 01918
        move.l  a0,(dat_002_00004).l            ; 0191C
l_000_01922:
        move.b  (dat_071_001FC).l,d0            ; 01922
        tst.b   d0                              ; 01928
        bmi.b   l_000_01934                     ; 0192A
        subq.b  #$1,d0                          ; 0192C
        move.b  d0,(dat_071_001FC).l            ; 0192E
l_000_01934:
        move.b  (dat_071_00191).l,d0            ; 01934
        addq.b  #$1,d0                          ; 0193A
        move.b  d0,(dat_071_00191).l            ; 0193C
        move.w  (dat_071_004A6).l,d0            ; 01942
        subq.w  #$1,d0                          ; 01948
        move.w  d0,(dat_071_004A6).l            ; 0194A
        movea.l (dat_002_00004).l,a0            ; 01950
        jsr     (a0)                            ; 01956
        clr.b   (dat_071_00173).l               ; 01958
        unlk    a6                              ; 0195E
        rts                                     ; 01960
sub_000_01962:
        link.w  a6,#$fff2                       ; 01962
        jsr     (sub_004_0006E).l               ; 01966
        move.l  (dat_071_00030).l,-$4(a6)       ; 0196C
        clr.w   -$a(a6)                         ; 01974
l_000_01978:
        move.w  -$a(a6),d0                      ; 01978
        cmpi.w  #$20,d0                         ; 0197C
        bge.b   l_000_0199E                     ; 01980
        ext.l   d0                              ; 01982
        asl.l   #$1,d0                          ; 01984
        movea.l d0,a0                           ; 01986
        adda.l  #dat_021_00080,a0               ; 01988
        movea.l -$4(a6),a1                      ; 0198E
        move.w  (a0),(a1)                       ; 01992
        addq.l  #$2,-$4(a6)                     ; 01994
        addq.w  #$1,-$a(a6)                     ; 01998
        bra.b   l_000_01978                     ; 0199C
l_000_0199E:
        clr.b   (dat_071_00276).l               ; 0199E
        moveq   #-1,d0                          ; 019A4
        move.b  d0,(dat_071_0017D).l            ; 019A6
        move.b  d0,(dat_071_00227).l            ; 019AC
        move.w  #$3,(dat_071_004A6).l           ; 019B2
        move.l  #sub_000_03596,(dat_002_00004).l ; 019BA
        lea.l   (dat_064_00340).l,a0            ; 019C4
        move.l  a0,-$e(a6)                      ; 019CA
        adda.w  #$15,a0                         ; 019CE
        clr.l   -$8(a6)                         ; 019D2
        moveq   #$0,d0                          ; 019D6
        move.w  (TitleChecksum).l,d0            ; 019D8
        move.l  a0,-$e(a6)                      ; 019DE
        cmpi.l  #$c560,d0                       ; 019E2
        beq.b   l_000_019F2                     ; 019E8
        move.b  #$31,(a0)                       ; 019EA
        move.l  d0,-$8(a6)                      ; 019EE
l_000_019F2:
        moveq   #$0,d0                          ; 019F2
        move.w  (dat_071_00020).l,d0            ; 019F4
        cmpi.l  #$7e70,d0                       ; 019FA
        beq.b   l_000_01A12                     ; 01A00
        movea.l -$e(a6),a0                      ; 01A02
        move.b  (a0),d1                         ; 01A06
        ori.b   #$32,d1                         ; 01A08
        move.b  d1,(a0)                         ; 01A0C
        move.l  d0,-$8(a6)                      ; 01A0E
l_000_01A12:
        moveq   #$0,d0                          ; 01A12
        move.w  (dat_071_00024).l,d0            ; 01A14
        cmpi.l  #$4de8,d0                       ; 01A1A
        beq.b   l_000_01A32                     ; 01A20
        movea.l -$e(a6),a0                      ; 01A22
        move.b  (a0),d1                         ; 01A26
        ori.b   #$34,d1                         ; 01A28
        move.b  d1,(a0)                         ; 01A2C
        move.l  d0,-$8(a6)                      ; 01A2E
l_000_01A32:
        tst.l   -$8(a6)                         ; 01A32
        beq.b   l_000_01A60                     ; 01A36
        movea.l -$e(a6),a0                      ; 01A38
        addq.l  #$1,a0                          ; 01A3C
        moveq   #$4,d0                          ; 01A3E
        move.l  d0,-(a7)                        ; 01A40
        move.l  -$8(a6),-(a7)                   ; 01A42
        move.l  a0,-(a7)                        ; 01A46
        move.l  a0,-$e(a6)                      ; 01A48
        bsr.w   h000+$16BA                      ; 01A4C
        lea.l   $c(a7),a7                       ; 01A50
        move.l  #sub_000_03534,(dat_002_00004).l ; 01A54
        bra.b   l_000_01A6C                     ; 01A5E
l_000_01A60:
        moveq   #$32,d0                         ; 01A60
        move.l  d0,-(a7)                        ; 01A62
        jsr     (sub_000_09CE6).l               ; 01A64
        addq.l  #$4,a7                          ; 01A6A
l_000_01A6C:
        unlk    a6                              ; 01A6C
        rts                                     ; 01A6E
sub_000_01A70:
        jsr     (sub_004_0006E).l               ; 01A70
        moveq   #$0,d0                          ; 01A76
        move.b  d0,(dat_071_0027C).l            ; 01A78
        move.b  d0,(dat_071_00276).l            ; 01A7E
        move.b  d0,(RecordMode).l               ; 01A84
        lea.l   sub_000_01D30(pc),a0            ; 01A8A
        move.l  a0,(dat_002_00004).l            ; 01A8E
        rts                                     ; 01A94
sub_000_01A96:
        move.w  (dat_071_004A6).l,d0            ; 01A96
        tst.w   d0                              ; 01A9C
        bpl.b   l_000_01AC2                     ; 01A9E
        move.b  (dat_071_00270).l,d0            ; 01AA0
        move.b  (dat_071_00271).l,d1            ; 01AA6
        cmp.b   d1,d0                           ; 01AAC
        bne.b   l_000_01AC2                     ; 01AAE
        move.w  #$2,(dat_071_004A6).l           ; 01AB0
        lea.l   sub_000_01AC4(pc),a0            ; 01AB8
        move.l  a0,(dat_002_00004).l            ; 01ABC
l_000_01AC2:
        rts                                     ; 01AC2
sub_000_01AC4:
        move.w  (dat_071_004A6).l,d0            ; 01AC4
        tst.w   d0                              ; 01ACA
        bpl.b   l_000_01AE0                     ; 01ACC
        move.b  #$1,(dat_071_00165).l           ; 01ACE
        lea.l   h000+$1AE2(pc),a0               ; 01AD6
        move.l  a0,(dat_002_00004).l            ; 01ADA
l_000_01AE0:
        rts                                     ; 01AE0
        jsr     (sub_000_015F6).l               ; 01AE2
        jsr     (sub_004_0006E).l               ; 01AE8
        move.b  (dat_071_00276).l,d0            ; 01AEE
        subq.b  #$2,d0                          ; 01AF4
        bne.b   l_000_01B00                     ; 01AF6
        move.b  #$7d,(dat_071_00276).l          ; 01AF8
l_000_01B00:
        move.b  (RecordMode).l,d0               ; 01B00
        subq.b  #$3,d0                          ; 01B06
        bne.b   l_000_01B34                     ; 01B08
        move.b  #$1,(dat_071_0017E).l           ; 01B0A
        move.w  #$2,(dat_071_004A6).l           ; 01B12
        clr.b   (dat_071_00271).l               ; 01B1A
        move.b  #$7f,(dat_071_00276).l          ; 01B20
        lea.l   h000+$1B54(pc),a0               ; 01B28
        move.l  a0,(dat_002_00004).l            ; 01B2C
        bra.b   l_000_01B52                     ; 01B32
l_000_01B34:
        clr.b   (RecordMode).l                  ; 01B34
        pea.l   (dat_021_00000).l               ; 01B3A
        jsr     (sub_000_03C1C).l               ; 01B40
        addq.l  #$4,a7                          ; 01B46
        lea.l   h000+$1E04(pc),a0               ; 01B48
        move.l  a0,(dat_002_00004).l            ; 01B4C
l_000_01B52:
        rts                                     ; 01B52
        move.w  (dat_071_004A6).l,d0            ; 01B54
        tst.w   d0                              ; 01B5A
        bpl.b   l_000_01B94                     ; 01B5C
        bsr.w   l_000_01BF4                     ; 01B5E
        move.b  #$3,(RecordMode).l              ; 01B62
        moveq   #$0,d0                          ; 01B6A
        move.b  d0,(dat_071_00155).l            ; 01B6C
        move.w  #$2,(dat_071_004A6).l           ; 01B72
        move.b  #$f,(dat_071_00271).l           ; 01B7A
        move.b  d0,(dat_071_00270).l            ; 01B82
        lea.l   h000+$1B9C(pc),a0               ; 01B88
        move.l  a0,(dat_002_00004).l            ; 01B8C
        bra.b   l_000_01B9A                     ; 01B92
l_000_01B94:
        jsr     (sub_036_00892).l               ; 01B94
l_000_01B9A:
        rts                                     ; 01B9A
        move.w  (dat_071_004A6).l,d0            ; 01B9C
        tst.w   d0                              ; 01BA2
        bpl.b   l_000_01BCE                     ; 01BA4
        clr.b   (dat_071_00165).l               ; 01BA6
        move.b  (dat_071_00270).l,d0            ; 01BAC
        move.b  (dat_071_00271).l,d1            ; 01BB2
        cmp.b   d1,d0                           ; 01BB8
        bne.b   l_000_01BCE                     ; 01BBA
        move.w  #$2,(dat_071_004A6).l           ; 01BBC
        lea.l   h000+$1BD0(pc),a0               ; 01BC4
        move.l  a0,(dat_002_00004).l            ; 01BC8
l_000_01BCE:
        rts                                     ; 01BCE
        move.w  (dat_071_004A6).l,d0            ; 01BD0
        tst.w   d0                              ; 01BD6
        bpl.b   l_000_01BF2                     ; 01BD8
        clr.b   (dat_071_0017E).l               ; 01BDA
        move.b  #$1,(dat_071_00165).l           ; 01BE0
        lea.l   h000+$2D58(pc),a0               ; 01BE8
        move.l  a0,(dat_002_00004).l            ; 01BEC
l_000_01BF2:
        rts                                     ; 01BF2
l_000_01BF4:
        move.b  (Difficulty).l,(DifficultySaved).l ; 01BF4
        moveq   #$0,d0                          ; 01BFE
        move.b  d0,(Difficulty).l               ; 01C00
        moveq   #$4,d0                          ; 01C06
        move.b  d0,(dat_071_00218).l            ; 01C08
        subq.b  #$1,d0                          ; 01C0E
        move.b  d0,(dat_071_00218).l            ; 01C10
        moveq   #$0,d0                          ; 01C16
        move.b  d0,(dat_071_0027E).l            ; 01C18
        move.b  d0,(dat_071_0017D).l            ; 01C1E
        move.b  #$1,(dat_071_00160).l           ; 01C24
        jsr     (sub_026_00002).l               ; 01C2C
        move.b  #$3,(dat_071_00276).l           ; 01C32
        jsr     (sub_004_00392).l               ; 01C3A
        bsr.w   h000+$3462                      ; 01C40
        clr.b   (dat_071_0027D).l               ; 01C44
        move.b  #$1,(dat_071_00165).l           ; 01C4A
        moveq   #$0,d0                          ; 01C52
        move.w  d0,(dat_071_00356).l            ; 01C54
        move.w  d0,(ViewX).l                    ; 01C5A
        jsr     (RedrawPanel).l                 ; 01C60
        move.b  #$ff,(RedrawFlags).l            ; 01C66
        move.w  #$1,(dat_071_004A6).l           ; 01C6E
        rts                                     ; 01C76
        move.b  (dat_071_0017E).l,d0            ; 01C78
        tst.b   d0                              ; 01C7E
        bne.b   l_000_01CBE                     ; 01C80
        move.b  (dat_071_001B0).l,d0            ; 01C82
        tst.b   d0                              ; 01C88
        bpl.b   l_000_01CBE                     ; 01C8A
        move.b  #$1,(dat_071_00165).l           ; 01C8C
        bsr.w   h000+$3462                      ; 01C94
        moveq   #$0,d0                          ; 01C98
        move.w  d0,(dat_071_00356).l            ; 01C9A
        move.w  d0,(ViewX).l                    ; 01CA0
        jsr     (RedrawPanel).l                 ; 01CA6
        move.b  #$ff,(RedrawFlags).l            ; 01CAC
        lea.l   h000+$2D58(pc),a0               ; 01CB4
        move.l  a0,(dat_002_00004).l            ; 01CB8
l_000_01CBE:
        rts                                     ; 01CBE
        move.w  (dat_071_004A6).l,d0            ; 01CC0
        tst.w   d0                              ; 01CC6
        bpl.b   l_000_01D04                     ; 01CC8
        move.b  (dat_071_001FB).l,d0            ; 01CCA
        tst.b   d0                              ; 01CD0
        bne.b   l_000_01CEE                     ; 01CD2
        clr.b   (dat_071_00165).l               ; 01CD4
        move.w  #$49,(dat_071_0011A).l          ; 01CDA
        lea.l   h000+$1D06(pc),a0               ; 01CE2
        move.l  a0,(dat_002_00004).l            ; 01CE6
        bra.b   l_000_01D04                     ; 01CEC
l_000_01CEE:
        move.b  #$1,(dat_071_00165).l           ; 01CEE
        bsr.w   h000+$3462                      ; 01CF6
        lea.l   h000+$2D58(pc),a0               ; 01CFA
        move.l  a0,(dat_002_00004).l            ; 01CFE
l_000_01D04:
        rts                                     ; 01D04
        move.b  (dat_071_001B0).l,d0            ; 01D06
        tst.b   d0                              ; 01D0C
        bmi.b   l_000_01D18                     ; 01D0E
        tst.b   (dat_071_00173).l               ; 01D10
        beq.b   l_000_01D2E                     ; 01D16
l_000_01D18:
        move.b  #$1,(dat_071_00165).l           ; 01D18
        bsr.w   h000+$3462                      ; 01D20
        lea.l   h000+$2D58(pc),a0               ; 01D24
        move.l  a0,(dat_002_00004).l            ; 01D28
l_000_01D2E:
        rts                                     ; 01D2E
sub_000_01D30:
        link.w  a6,#$fffc                       ; 01D30
        move.l  #dat_071_0011A,-$4(a6)          ; 01D34
        move.l  #$1f0000,(dat_071_00038).l      ; 01D3C
        btst    #$7,(dat_071_0052B).l           ; 01D46
        beq.b   l_000_01D64                     ; 01D4E
        move.b  (dat_071_001A7).l,d0            ; 01D50
        tst.b   d0                              ; 01D56
        bne.b   l_000_01D64                     ; 01D58
        move.l  #$1f0000,(dat_074_000FE).l      ; 01D5A
l_000_01D64:
        moveq   #$f,d0                          ; 01D64
        move.l  d0,-(a7)                        ; 01D66
        jsr     (sub_000_09CE6).l               ; 01D68
        addq.l  #$4,a7                          ; 01D6E
        move.b  #$1,(dat_071_001A7).l           ; 01D70
        jsr     (sub_036_00892).l               ; 01D78
        bsr.w   sub_000_03462                   ; 01D7E
        move.l  #$c000,-(a7)                    ; 01D82
        jsr     (BusyWait).l                    ; 01D88
        addq.l  #$4,a7                          ; 01D8E
        clr.b   (dat_071_0027D).l               ; 01D90
        pea.l   (dat_021_00000).l               ; 01D96
        jsr     (sub_000_03C1C).l               ; 01D9C
        addq.l  #$4,a7                          ; 01DA2
        move.l  #$1e0,(dat_071_0010E).l         ; 01DA4
        movea.l -$4(a6),a0                      ; 01DAE
        move.w  #$6,(a0)                        ; 01DB2
        addq.l  #$2,a0                          ; 01DB6
        move.w  #$64,(a0)                       ; 01DB8
        addq.l  #$2,a0                          ; 01DBC
        move.w  #$65,(a0)                       ; 01DBE
        addq.l  #$2,a0                          ; 01DC2
        move.w  #$66,(a0)                       ; 01DC4
        addq.l  #$2,a0                          ; 01DC8
        move.w  #$67,(a0)                       ; 01DCA
        addq.l  #$2,a0                          ; 01DCE
        move.w  #$68,(a0)                       ; 01DD0
        addq.l  #$2,a0                          ; 01DD4
        move.w  #$69,(a0)                       ; 01DD6
        addq.l  #$2,a0                          ; 01DDA
        move.w  #$6a,(a0)                       ; 01DDC
        addq.l  #$2,a0                          ; 01DE0
        move.w  #$6b,(a0)                       ; 01DE2
        addq.l  #$2,a0                          ; 01DE6
        move.w  #$6c,(a0)                       ; 01DE8
        addq.l  #$2,a0                          ; 01DEC
        move.w  #$6d,(a0)                       ; 01DEE
        addq.l  #$2,a0                          ; 01DF2
        clr.w   (a0)                            ; 01DF4
        lea.l   sub_000_01E04(pc),a1            ; 01DF6
        move.l  a1,(dat_002_00004).l            ; 01DFA
        unlk    a6                              ; 01E00
        rts                                     ; 01E02
sub_000_01E04:
        link.w  a6,#$fffa                       ; 01E04
        move.l  #dat_071_0011A,-$4(a6)          ; 01E08
        move.b  (dat_071_00276).l,-$5(a6)       ; 01E10
        tst.b   (dat_071_001FA).l               ; 01E18
        beq.b   l_000_01E44                     ; 01E1E
        clr.b   (dat_071_001FA).l               ; 01E20
        move.w  (dat_071_00142).l,d0            ; 01E26
        subq.w  #$6,d0                          ; 01E2C
        beq.w   l_000_01F82                     ; 01E2E
        bsr.w   h000+$3462                      ; 01E32
        lea.l   h000+$1D30(pc),a0               ; 01E36
        move.l  a0,(dat_002_00004).l            ; 01E3A
        bra.w   l_000_01F82                     ; 01E40
l_000_01E44:
        move.b  (dat_071_00276).l,d0            ; 01E44
        tst.b   d0                              ; 01E4A
        ble.w   l_000_01F20                     ; 01E4C
        clr.l   (dat_071_00038).l               ; 01E50
        bsr.w   h000+$3462                      ; 01E56
        jsr     (sub_036_00892).l               ; 01E5A
        cmpi.b  #$7f,-$5(a6)                    ; 01E60
        bne.b   l_000_01E76                     ; 01E66
        movea.l -$4(a6),a0                      ; 01E68
        move.w  #$65,(a0)                       ; 01E6C
        addq.l  #$2,-$4(a6)                     ; 01E70
        bra.b   l_000_01EE8                     ; 01E74
l_000_01E76:
        cmpi.b  #$1,-$5(a6)                     ; 01E76
        bne.b   l_000_01E8C                     ; 01E7C
        movea.l -$4(a6),a0                      ; 01E7E
        move.w  #$66,(a0)                       ; 01E82
        addq.l  #$2,-$4(a6)                     ; 01E86
        bra.b   l_000_01EE8                     ; 01E8A
l_000_01E8C:
        cmpi.b  #$2,-$5(a6)                     ; 01E8C
        bne.b   l_000_01EA2                     ; 01E92
        movea.l -$4(a6),a0                      ; 01E94
        move.w  #$67,(a0)                       ; 01E98
        addq.l  #$2,-$4(a6)                     ; 01E9C
        bra.b   l_000_01EE8                     ; 01EA0
l_000_01EA2:
        cmpi.b  #$7d,-$5(a6)                    ; 01EA2
        bne.b   l_000_01EB8                     ; 01EA8
        movea.l -$4(a6),a0                      ; 01EAA
        move.w  #$68,(a0)                       ; 01EAE
        addq.l  #$2,-$4(a6)                     ; 01EB2
        bra.b   l_000_01EE8                     ; 01EB6
l_000_01EB8:
        cmpi.b  #$9,-$5(a6)                     ; 01EB8
        bne.b   l_000_01ECE                     ; 01EBE
        movea.l -$4(a6),a0                      ; 01EC0
        move.w  #$69,(a0)                       ; 01EC4
        addq.l  #$2,-$4(a6)                     ; 01EC8
        bra.b   l_000_01EE8                     ; 01ECC
l_000_01ECE:
        tst.b   (dat_071_00162).l               ; 01ECE
        beq.b   l_000_01EE8                     ; 01ED4
        movea.l -$4(a6),a0                      ; 01ED6
        move.w  #$6b,(a0)                       ; 01EDA
        addq.l  #$2,-$4(a6)                     ; 01EDE
        clr.b   (dat_071_00162).l               ; 01EE2
l_000_01EE8:
        movea.l -$4(a6),a0                      ; 01EE8
        clr.w   (a0)                            ; 01EEC
        move.b  (dat_071_001FB).l,d0            ; 01EEE
        tst.b   d0                              ; 01EF4
        bne.b   l_000_01F0C                     ; 01EF6
        btst    #$7,(dat_071_0052B).l           ; 01EF8
        beq.b   l_000_01F0C                     ; 01F00
        move.w  #$d2,(dat_071_004A6).l          ; 01F02
        bra.b   l_000_01F14                     ; 01F0A
l_000_01F0C:
        move.w  #$96,(dat_071_004A6).l          ; 01F0C
l_000_01F14:
        lea.l   h000+$201E(pc),a0               ; 01F14
        move.l  a0,(dat_002_00004).l            ; 01F18
        bra.b   l_000_01F82                     ; 01F1E
l_000_01F20:
        move.b  (dat_071_00276).l,d0            ; 01F20
        tst.b   d0                              ; 01F26
        bpl.b   l_000_01F7C                     ; 01F28
        bsr.w   h000+$3462                      ; 01F2A
        jsr     (sub_036_00892).l               ; 01F2E
        move.b  (dat_071_00276).l,d0            ; 01F34
        cmpi.b  #$ff,d0                         ; 01F3A
        bne.b   l_000_01F4C                     ; 01F3E
        lea.l   h000+$22CE(pc),a0               ; 01F40
        move.l  a0,(dat_002_00004).l            ; 01F44
        bra.b   l_000_01F74                     ; 01F4A
l_000_01F4C:
        jsr     (sub_036_00892).l               ; 01F4C
        jsr     (ShowFlightLog).l               ; 01F52
        movea.l -$4(a6),a0                      ; 01F58
        move.w  #$57,(a0)                       ; 01F5C
        addq.l  #$2,-$4(a6)                     ; 01F60
        movea.l -$4(a6),a0                      ; 01F64
        clr.w   (a0)                            ; 01F68
        lea.l   h000+$1F86(pc),a0               ; 01F6A
        move.l  a0,(dat_002_00004).l            ; 01F6E
l_000_01F74:
        clr.b   (dat_071_00276).l               ; 01F74
        bra.b   l_000_01F82                     ; 01F7A
l_000_01F7C:
        clr.b   (dat_071_001FA).l               ; 01F7C
l_000_01F82:
        unlk    a6                              ; 01F82
        rts                                     ; 01F84
        tst.b   (dat_071_00162).l               ; 01F86
        beq.b   l_000_02004                     ; 01F8C
        move.b  (dat_071_00162).l,d0            ; 01F8E
        subq.b  #$1,d0                          ; 01F94
        bne.b   l_000_01FD4                     ; 01F96
        tst.b   (dat_071_00195).l               ; 01F98
        beq.b   l_000_01FFC                     ; 01F9E
        move.w  (dat_071_002F8).l,d0            ; 01FA0
        tst.w   d0                              ; 01FA6
        bne.b   l_000_01FFC                     ; 01FA8
        jsr     (SaveConfig).l                  ; 01FAA
        move.b  #$ff,(dat_071_001A5).l          ; 01FB0
        movea.l (ConfigBuffer).l,a0             ; 01FB8
        move.w  $4(a0),d0                       ; 01FBE
        cmpi.w  #$1,d0                          ; 01FC2
        bhi.b   l_000_01FFC                     ; 01FC6
        move.l  #sub_000_03622,(dat_002_00004).l ; 01FC8
        bra.b   l_000_01FFC                     ; 01FD2
l_000_01FD4:
        move.b  (dat_071_00162).l,d0            ; 01FD4
        subq.b  #$2,d0                          ; 01FDA
        bne.b   l_000_01FFC                     ; 01FDC
        jsr     (ClearConfig).l                 ; 01FDE
        bsr.w   h000+$3462                      ; 01FE4
        jsr     (sub_036_00892).l               ; 01FE8
        jsr     (ShowFlightLog).l               ; 01FEE
        move.w  #$57,(dat_071_0011A).l          ; 01FF4
l_000_01FFC:
        clr.b   (dat_071_00162).l               ; 01FFC
        bra.b   l_000_02016                     ; 02002
l_000_02004:
        tst.b   (dat_071_001FA).l               ; 02004
        beq.b   l_000_02016                     ; 0200A
        lea.l   h000+$1D30(pc),a0               ; 0200C
        move.l  a0,(dat_002_00004).l            ; 02010
l_000_02016:
        clr.b   (dat_071_00276).l               ; 02016
        rts                                     ; 0201C
        link.w  a6,#$fffe                       ; 0201E
        move.b  (dat_071_00276).l,d0            ; 02022
        ext.w   d0                              ; 02028
        move.w  (dat_071_004A6).l,d1            ; 0202A
        move.w  d0,-$2(a6)                      ; 02030
        tst.w   d1                              ; 02034
        bpl.w   l_000_022CA                     ; 02036
        clr.b   (dat_071_001A7).l               ; 0203A
        clr.l   -(a7)                           ; 02040
        jsr     (StopSound).l                   ; 02042
        addq.l  #$4,a7                          ; 02048
        moveq   #$1,d0                          ; 0204A
        move.l  d0,-(a7)                        ; 0204C
        jsr     (StopSound).l                   ; 0204E
        addq.l  #$4,a7                          ; 02054
        move.l  #$3f0000,(dat_074_000FE).l      ; 02056
        move.w  -$2(a6),d0                      ; 02060
        cmpi.w  #$3,d0                          ; 02064
        bcs.b   l_000_0207E                     ; 02068
        cmpi.w  #$8,d0                          ; 0206A
        bhi.b   l_000_0207E                     ; 0206E
        moveq   #$28,d0                         ; 02070
        move.l  d0,-(a7)                        ; 02072
        jsr     (sub_000_09D7A).l               ; 02074
        addq.l  #$4,a7                          ; 0207A
        bra.b   l_000_020A8                     ; 0207C
l_000_0207E:
        btst    #$4,(dat_071_0052B).l           ; 0207E
        beq.b   l_000_02096                     ; 02086
        moveq   #$8,d0                          ; 02088
        move.l  d0,-(a7)                        ; 0208A
        jsr     (sub_000_09F9A).l               ; 0208C
        addq.l  #$4,a7                          ; 02092
        bra.b   l_000_020A8                     ; 02094
l_000_02096:
        moveq   #$8,d0                          ; 02096
        move.l  d0,-(a7)                        ; 02098
        move.l  #$300,-(a7)                     ; 0209A
        jsr     (sub_000_09E46).l               ; 020A0
        addq.l  #$8,a7                          ; 020A6
l_000_020A8:
        move.w  #$b3,(ClipY).l                  ; 020A8
        bsr.w   h000+$3462                      ; 020B0
        move.w  #$4,(dat_071_004A6).l           ; 020B4
        move.b  #$3,(dat_071_00267).l           ; 020BC
        move.b  #$2,(dat_071_00268).l           ; 020C4
        jsr     (sub_026_00002).l               ; 020CC
        clr.b   (dat_071_0017E).l               ; 020D2
        move.b  #$1,(dat_071_00165).l           ; 020D8
        move.b  #$3,(dat_071_00206).l           ; 020E0
        move.b  (dat_071_00270).l,(dat_071_00271).l ; 020E8
        jsr     (sub_000_03C5E).l               ; 020F2
        lea.l   h000+$2534(pc),a0               ; 020F8
        move.l  a0,(dat_002_00004).l            ; 020FC
        move.b  #$3,(dat_071_00218).l           ; 02102
        move.b  #$11,(dat_071_00219).l          ; 0210A
        moveq   #$0,d0                          ; 02112
        move.w  -$2(a6),d0                      ; 02114
        moveq   #$30,d1                         ; 02118
l_000_0211A:
        subi.l  #$8,d1                          ; 0211A
        bmi.w   l_000_022B2                     ; 02120
        cmp.l   h000+$212E(pc,d1.l),d0          ; 02124
        bne.b   l_000_0211A                     ; 02128
        jmp     h000+$2132(pc,d1.l)             ; 0212A
        ori.b   #$9,d0                          ; 0212E
        bra.w   l_000_02252                     ; 02132
        ori.b   #$7d,d0                         ; 02136
        bra.w   l_000_02202                     ; 0213A
        ori.b   #$3,d0                          ; 0213E
        bra.w   l_000_021F8                     ; 02142
        ori.b   #$2,d0                          ; 02146
        bra.w   l_000_02190                     ; 0214A
        ori.b   #$1,d0                          ; 0214E
        bra.w   l_000_02174                     ; 02152
        ori.b   #$7f,d0                         ; 02156
        bra.w   l_000_0215E                     ; 0215A
l_000_0215E:
        move.b  #$1,(dat_071_0017E).l           ; 0215E
        lea.l   h000+$1B54(pc),a0               ; 02166
        move.l  a0,(dat_002_00004).l            ; 0216A
        bra.w   l_000_022B2                     ; 02170
l_000_02174:
        jsr     (sub_004_00268).l               ; 02174
        move.b  #$5,(dat_071_00267).l           ; 0217A
        lea.l   h000+$234C(pc),a0               ; 02182
        move.l  a0,(dat_002_00004).l            ; 02186
        bra.w   l_000_022B2                     ; 0218C
l_000_02190:
        move.w  #$a7,(ClipY).l                  ; 02190
        move.b  #$ff,(dat_071_00184).l          ; 02198
        jsr     (sub_026_00D70).l               ; 021A0
        moveq   #$0,d0                          ; 021A6
        move.b  d0,(dat_071_0017D).l            ; 021A8
        moveq   #$1,d0                          ; 021AE
        move.b  d0,(dat_071_00155).l            ; 021B0
        clr.b   (dat_071_0027E).l               ; 021B6
        move.b  d0,(dat_071_00185).l            ; 021BC
        move.w  #$4,(dat_071_002AC).l           ; 021C2
        move.w  #$800,(ViewObject).l            ; 021CA
        move.b  #$3,(dat_071_00282).l           ; 021D2
        move.w  (Object4_02).l,d0               ; 021DA
        ori.w   #$100,d0                        ; 021E0
        move.w  d0,(Object4_02).l               ; 021E4
        lea.l   h000+$23C2(pc),a0               ; 021EA
        move.l  a0,(dat_002_00004).l            ; 021EE
        bra.w   l_000_022B2                     ; 021F4
l_000_021F8:
        clr.b   (dat_071_00218).l               ; 021F8
        bra.w   l_000_022B2                     ; 021FE
l_000_02202:
        move.b  #$1,(dat_071_00267).l           ; 02202
        move.w  #$a7,(ClipY).l                  ; 0220A
        move.b  #$ff,(dat_071_00184).l          ; 02212
        move.b  #$3,(dat_071_00186).l           ; 0221A
        move.b  #$2,(dat_071_00218).l           ; 02222
        bsr.w   l_000_02CE0                     ; 0222A
        jsr     (sub_026_00D7A).l               ; 0222E
        jsr     (sub_004_00290).l               ; 02234
        jsr     (sub_026_00002).l               ; 0223A
        clr.b   (dat_071_0017D).l               ; 02240
        lea.l   h000+$23C2(pc),a0               ; 02246
        move.l  a0,(dat_002_00004).l            ; 0224A
        bra.b   l_000_022B2                     ; 02250
l_000_02252:
        move.b  #$3,(dat_071_00218).l           ; 02252
        moveq   #$0,d0                          ; 0225A
        move.b  d0,(dat_071_0027E).l            ; 0225C
        move.b  d0,(dat_071_0017D).l            ; 02262
        jsr     (sub_026_00002).l               ; 02268
        jsr     (sub_004_00392).l               ; 0226E
        bsr.w   h000+$3462                      ; 02274
        moveq   #$1,d0                          ; 02278
        move.b  d0,(dat_071_0027D).l            ; 0227A
        move.b  d0,(dat_071_00165).l            ; 02280
        moveq   #$0,d0                          ; 02286
        move.w  d0,(dat_071_00356).l            ; 02288
        move.w  d0,(ViewX).l                    ; 0228E
        jsr     (RedrawPanel).l                 ; 02294
        move.b  #$ff,(RedrawFlags).l            ; 0229A
        clr.b   (dat_071_00155).l               ; 022A2
        lea.l   h000+$234C(pc),a0               ; 022A8
        move.l  a0,(dat_002_00004).l            ; 022AC
l_000_022B2:
        move.b  (dat_071_00218).l,d0            ; 022B2
        subq.b  #$3,d0                          ; 022B8
        bne.b   l_000_022C4                     ; 022BA
        move.b  #$11,(dat_071_00219).l          ; 022BC
l_000_022C4:
        jsr     (sub_008_00598).l               ; 022C4
l_000_022CA:
        unlk    a6                              ; 022CA
        rts                                     ; 022CC
        link.w  a6,#$fff6                       ; 022CE
        jsr     (sub_036_00892).l               ; 022D2
        lea.l   (dat_071_0011A).l,a0            ; 022D8
        move.w  #$40,(a0)                       ; 022DE
        addq.l  #$2,a0                          ; 022E2
        move.l  #dat_064_00000,-$8(a6)          ; 022E4
        move.b  #$3,-$9(a6)                     ; 022EC
        move.l  a0,-$4(a6)                      ; 022F2
l_000_022F6:
        move.b  -$9(a6),d0                      ; 022F6
        cmpi.b  #$9,d0                          ; 022FA
        bge.b   l_000_0232C                     ; 022FE
        ext.w   d0                              ; 02300
        ext.l   d0                              ; 02302
        movea.l (ConfigBuffer).l,a0             ; 02304
        adda.w  #$12,a0                         ; 0230A
        adda.l  d0,a0                           ; 0230E
        tst.b   (a0)                            ; 02310
        beq.b   l_000_02326                     ; 02312
        movea.l -$8(a6),a0                      ; 02314
        movea.l -$4(a6),a1                      ; 02318
        move.w  (a0),(a1)                       ; 0231C
        addq.l  #$2,-$8(a6)                     ; 0231E
        addq.l  #$2,-$4(a6)                     ; 02322
l_000_02326:
        addq.b  #$1,-$9(a6)                     ; 02326
        bra.b   l_000_022F6                     ; 0232A
l_000_0232C:
        movea.l -$4(a6),a0                      ; 0232C
        move.w  #$806e,(a0)                     ; 02330
        addq.l  #$2,-$4(a6)                     ; 02334
        movea.l -$4(a6),a0                      ; 02338
        clr.w   (a0)                            ; 0233C
        lea.l   sub_000_01E04(pc),a0            ; 0233E
        move.l  a0,(dat_002_00004).l            ; 02342
        unlk    a6                              ; 02348
        rts                                     ; 0234A
        move.w  (dat_071_004A6).l,d0            ; 0234C
        tst.w   d0                              ; 02352
        bpl.b   l_000_02376                     ; 02354
        moveq   #$0,d0                          ; 02356
        move.b  d0,(dat_071_00165).l            ; 02358
        move.b  #$f,(dat_071_00271).l           ; 0235E
        move.b  d0,(dat_071_00270).l            ; 02366
        lea.l   h000+$2378(pc),a0               ; 0236C
        move.l  a0,(dat_002_00004).l            ; 02370
l_000_02376:
        rts                                     ; 02376
        move.b  (dat_071_00270).l,d0            ; 02378
        move.b  (dat_071_00271).l,d1            ; 0237E
        cmp.b   d1,d0                           ; 02384
        bne.b   l_000_023C0                     ; 02386
        move.w  #$2,(dat_071_004A6).l           ; 02388
        moveq   #$1,d0                          ; 02390
        move.b  d0,(dat_071_00165).l            ; 02392
        move.b  #$ff,(RedrawFlags).l            ; 02398
        move.b  #$4,(dat_071_0027E).l           ; 023A0
        move.b  d0,(dat_071_0027D).l            ; 023A8
        move.w  #$5,(dat_071_004A6).l           ; 023AE
        lea.l   h000+$27C8(pc),a0               ; 023B6
        move.l  a0,(dat_002_00004).l            ; 023BA
l_000_023C0:
        rts                                     ; 023C0
        move.w  (dat_071_004A6).l,d0            ; 023C2
        tst.w   d0                              ; 023C8
        bpl.b   l_000_023EC                     ; 023CA
        moveq   #$0,d0                          ; 023CC
        move.b  d0,(dat_071_00165).l            ; 023CE
        move.b  #$f,(dat_071_00271).l           ; 023D4
        move.b  d0,(dat_071_00270).l            ; 023DC
        lea.l   h000+$23EE(pc),a0               ; 023E2
        move.l  a0,(dat_002_00004).l            ; 023E6
l_000_023EC:
        rts                                     ; 023EC
        move.b  (dat_071_00270).l,d0            ; 023EE
        move.b  (dat_071_00271).l,d1            ; 023F4
        cmp.b   d1,d0                           ; 023FA
        bne.b   l_000_02426                     ; 023FC
        moveq   #$1,d0                          ; 023FE
        move.b  d0,(dat_071_00165).l            ; 02400
        move.b  #$ff,(RedrawFlags).l            ; 02406
        move.b  d0,(dat_071_0027D).l            ; 0240E
        move.w  #$5,(dat_071_004A6).l           ; 02414
        lea.l   h000+$27C8(pc),a0               ; 0241C
        move.l  a0,(dat_002_00004).l            ; 02420
l_000_02426:
        rts                                     ; 02426
        moveq   #$1,d0                          ; 02428
        move.b  d0,(dat_071_00165).l            ; 0242A
        move.b  #$ff,(RedrawFlags).l            ; 02430
        move.b  d0,(dat_071_0027D).l            ; 02438
        move.w  #$5,(dat_071_004A6).l           ; 0243E
        lea.l   h000+$2452(pc),a0               ; 02446
        move.l  a0,(dat_002_00004).l            ; 0244A
        rts                                     ; 02450
        link.w  a6,#$fffc                       ; 02452
        move.l  #dat_071_0011A,-$4(a6)          ; 02456
        tst.b   (dat_071_00173).l               ; 0245E
        beq.b   l_000_0246A                     ; 02464
        bsr.b   l_000_024B2                     ; 02466
        bra.b   l_000_024AE                     ; 02468
l_000_0246A:
        move.w  (dat_071_004A6).l,d0            ; 0246A
        tst.w   d0                              ; 02470
        bpl.b   l_000_024AE                     ; 02472
        clr.b   (dat_071_00165).l               ; 02474
        move.b  (dat_071_00276).l,d0            ; 0247A
        subq.b  #$2,d0                          ; 02480
        bne.b   l_000_02492                     ; 02482
        movea.l -$4(a6),a0                      ; 02484
        move.w  #$9,(a0)                        ; 02488
        addq.l  #$2,-$4(a6)                     ; 0248C
        bra.b   l_000_024A4                     ; 02490
l_000_02492:
        movea.l -$4(a6),a0                      ; 02492
        move.w  #$a,(a0)                        ; 02496
        addq.l  #$2,-$4(a6)                     ; 0249A
        clr.b   (dat_071_0027D).l               ; 0249E
l_000_024A4:
        lea.l   h000+$24B2(pc),a0               ; 024A4
        move.l  a0,(dat_002_00004).l            ; 024A8
l_000_024AE:
        unlk    a6                              ; 024AE
        rts                                     ; 024B0
l_000_024B2:
        move.b  (dat_071_001B0).l,d0            ; 024B2
        tst.b   d0                              ; 024B8
        bmi.b   l_000_024C4                     ; 024BA
        tst.b   (dat_071_00173).l               ; 024BC
        beq.b   l_000_02532                     ; 024C2
l_000_024C4:
        move.b  #$1,(dat_071_00165).l           ; 024C4
        move.b  #$ff,(RedrawFlags).l            ; 024CC
        bsr.w   h000+$3462                      ; 024D4
        moveq   #$1,d0                          ; 024D8
        move.b  d0,(dat_071_00184).l            ; 024DA
        move.b  d0,(dat_071_00185).l            ; 024E0
        clr.b   (dat_071_0027D).l               ; 024E6
        move.b  (dat_071_00276).l,d0            ; 024EC
        cmpi.b  #$7d,d0                         ; 024F2
        bne.b   l_000_0250C                     ; 024F6
        move.b  #$6,(dat_071_0027E).l           ; 024F8
        lea.l   h000+$2D58(pc),a0               ; 02500
        move.l  a0,(dat_002_00004).l            ; 02504
        bra.b   l_000_02532                     ; 0250A
l_000_0250C:
        move.b  #$3,(dat_071_00206).l           ; 0250C
        clr.w   (dat_073_0162A).l               ; 02514
        clr.b   (dat_071_00158).l               ; 0251A
        move.w  #$5,(dat_071_004A6).l           ; 02520
        lea.l   h000+$2DB8(pc),a0               ; 02528
        move.l  a0,(dat_002_00004).l            ; 0252C
l_000_02532:
        rts                                     ; 02532
        move.b  #$1,(dat_071_0027D).l           ; 02534
        move.w  (dat_071_004A6).l,d0            ; 0253C
        tst.w   d0                              ; 02542
        bpl.b   l_000_02566                     ; 02544
        moveq   #$0,d0                          ; 02546
        move.b  d0,(dat_071_00165).l            ; 02548
        move.b  #$f,(dat_071_00271).l           ; 0254E
        move.b  d0,(dat_071_00270).l            ; 02556
        lea.l   h000+$2568(pc),a0               ; 0255C
        move.l  a0,(dat_002_00004).l            ; 02560
l_000_02566:
        rts                                     ; 02566
        move.b  (dat_071_00270).l,d0            ; 02568
        move.b  (dat_071_00271).l,d1            ; 0256E
        cmp.b   d1,d0                           ; 02574
        bne.b   l_000_025A6                     ; 02576
        moveq   #$1,d0                          ; 02578
        move.b  d0,(dat_071_00165).l            ; 0257A
        move.b  #$ff,(RedrawFlags).l            ; 02580
        move.b  d0,(dat_071_0017D).l            ; 02588
        move.b  d0,(dat_071_00227).l            ; 0258E
        move.w  #$9,(dat_071_004A6).l           ; 02594
        lea.l   h000+$25A8(pc),a0               ; 0259C
        move.l  a0,(dat_002_00004).l            ; 025A0
l_000_025A6:
        rts                                     ; 025A6
        move.b  (dat_071_00166).l,d0            ; 025A8
        move.b  (dat_071_00173).l,d1            ; 025AE
        or.b    d1,d0                           ; 025B4
        move.b  d0,(dat_071_00166).l            ; 025B6
        move.b  (dat_071_001FB).l,d0            ; 025BC
        tst.b   d0                              ; 025C2
        bne.b   l_000_025EE                     ; 025C4
        tst.b   (dat_071_00173).l               ; 025C6
        beq.b   l_000_025EE                     ; 025CC
        move.b  #$1,(dat_071_00165).l           ; 025CE
        bsr.w   h000+$3462                      ; 025D6
        move.w  #$ffff,(dat_071_004A6).l        ; 025DA
        lea.l   h000+$2744(pc),a0               ; 025E2
        move.l  a0,(dat_002_00004).l            ; 025E6
        bra.b   l_000_02610                     ; 025EC
l_000_025EE:
        move.w  (dat_071_004A6).l,d0            ; 025EE
        tst.w   d0                              ; 025F4
        bpl.b   l_000_02610                     ; 025F6
        clr.b   (dat_071_00227).l               ; 025F8
        move.w  #$1,(dat_071_004A6).l           ; 025FE
        lea.l   h000+$2612(pc),a0               ; 02606
        move.l  a0,(dat_002_00004).l            ; 0260A
l_000_02610:
        rts                                     ; 02610
        link.w  a6,#$fffe                       ; 02612
        movem.l d2,-(a7)                        ; 02616
        moveq   #$0,d0                          ; 0261A
        move.b  d0,(dat_071_0017E).l            ; 0261C
        move.b  (dat_071_00166).l,d0            ; 02622
        move.b  (dat_071_00173).l,d1            ; 02628
        or.b    d1,d0                           ; 0262E
        move.b  d0,(dat_071_00166).l            ; 02630
        move.b  (dat_071_001FB).l,d0            ; 02636
        tst.b   d0                              ; 0263C
        bne.b   l_000_0266A                     ; 0263E
        tst.b   (dat_071_00173).l               ; 02640
        beq.b   l_000_0266A                     ; 02646
        move.b  #$1,(dat_071_00165).l           ; 02648
        bsr.w   h000+$3462                      ; 02650
        move.w  #$ffff,(dat_071_004A6).l        ; 02654
        lea.l   h000+$2744(pc),a0               ; 0265C
        move.l  a0,(dat_002_00004).l            ; 02660
        bra.w   l_000_026EE                     ; 02666
l_000_0266A:
        move.w  (dat_071_004A6).l,d0            ; 0266A
        tst.w   d0                              ; 02670
        bpl.b   l_000_026EE                     ; 02672
        clr.b   (dat_071_00165).l               ; 02674
        move.b  (dat_071_00276).l,d0            ; 0267A
        ext.w   d0                              ; 02680
        move.w  d0,-$2(a6)                      ; 02682
        cmpi.w  #$3,d0                          ; 02686
        bcs.b   l_000_026E4                     ; 0268A
        cmpi.w  #$8,d0                          ; 0268C
        bhi.b   l_000_026E4                     ; 02690
        move.w  #$5b,(dat_071_0011A).l          ; 02692
        moveq   #$0,d1                          ; 0269A
        move.w  -$2(a6),d1                      ; 0269C
        movea.l (ConfigBuffer).l,a0             ; 026A0
        adda.w  #$12,a0                         ; 026A6
        adda.l  d1,a0                           ; 026AA
        move.b  (a0),d2                         ; 026AC
        tst.b   d2                              ; 026AE
        bne.b   l_000_026CC                     ; 026B0
        moveq   #$0,d1                          ; 026B2
        move.w  -$2(a6),d1                      ; 026B4
        clr.l   -(a7)                           ; 026B8
        moveq   #$1,d0                          ; 026BA
        move.l  d0,-(a7)                        ; 026BC
        move.l  d1,-(a7)                        ; 026BE
        jsr     (sub_020_001F4).l               ; 026C0
        lea.l   $c(a7),a7                       ; 026C6
        bra.b   l_000_026E4                     ; 026CA
l_000_026CC:
        moveq   #$0,d0                          ; 026CC
        move.w  -$2(a6),d0                      ; 026CE
        moveq   #$1,d1                          ; 026D2
        move.l  d1,-(a7)                        ; 026D4
        move.l  d1,-(a7)                        ; 026D6
        move.l  d0,-(a7)                        ; 026D8
        jsr     (sub_020_001F4).l               ; 026DA
        lea.l   $c(a7),a7                       ; 026E0
l_000_026E4:
        lea.l   h000+$26F6(pc),a0               ; 026E4
        move.l  a0,(dat_002_00004).l            ; 026E8
l_000_026EE:
        movem.l (a7)+,d2                        ; 026EE
        unlk    a6                              ; 026F2
        rts                                     ; 026F4
        move.b  (dat_071_001B0).l,d0            ; 026F6
        tst.b   d0                              ; 026FC
        bmi.b   l_000_02708                     ; 026FE
        tst.b   (dat_071_00173).l               ; 02700
        beq.b   l_000_02742                     ; 02706
l_000_02708:
        move.b  (dat_071_00166).l,d0            ; 02708
        move.b  (dat_071_00173).l,d1            ; 0270E
        or.b    d1,d0                           ; 02714
        move.b  d0,(dat_071_00166).l            ; 02716
        move.b  #$1,(dat_071_00165).l           ; 0271C
        bsr.w   h000+$3462                      ; 02724
        move.w  #$ffff,(dat_071_004A6).l        ; 02728
        move.b  #$3,(dat_071_00206).l           ; 02730
        lea.l   h000+$2744(pc),a0               ; 02738
        move.l  a0,(dat_002_00004).l            ; 0273C
l_000_02742:
        rts                                     ; 02742
        move.w  (dat_071_004A6).l,d0            ; 02744
        tst.w   d0                              ; 0274A
        bpl.b   l_000_02774                     ; 0274C
        moveq   #$1,d0                          ; 0274E
        move.b  d0,(dat_071_0017D).l            ; 02750
        move.b  d0,(dat_071_00227).l            ; 02756
        move.w  #$1,(dat_071_004A6).l           ; 0275C
        jsr     (sub_026_00C48).l               ; 02764
        lea.l   h000+$2776(pc),a0               ; 0276A
        move.l  a0,(dat_002_00004).l            ; 0276E
l_000_02774:
        rts                                     ; 02774
        move.w  (dat_071_004A6).l,d0            ; 02776
        tst.w   d0                              ; 0277C
        bpl.b   l_000_0279A                     ; 0277E
        move.b  #$2,(dat_071_0027E).l           ; 02780
        move.b  #$1,(dat_071_00185).l           ; 02788
        lea.l   h000+$279C(pc),a0               ; 02790
        move.l  a0,(dat_002_00004).l            ; 02794
l_000_0279A:
        rts                                     ; 0279A
        move.b  (dat_071_0027E).l,d0            ; 0279C
        subq.b  #$3,d0                          ; 027A2
        bne.b   l_000_027C6                     ; 027A4
        moveq   #$0,d0                          ; 027A6
        move.b  d0,(dat_071_00185).l            ; 027A8
        move.b  d0,(dat_071_00227).l            ; 027AE
        move.w  #$2,(dat_071_004A6).l           ; 027B4
        lea.l   h000+$27C8(pc),a0               ; 027BC
        move.l  a0,(dat_002_00004).l            ; 027C0
l_000_027C6:
        rts                                     ; 027C6
        link.w  a6,#$fffa                       ; 027C8
        move.w  (dat_071_004A6).l,d0            ; 027CC
        tst.w   d0                              ; 027D2
        bpl.w   l_000_0287A                     ; 027D4
        clr.b   (dat_071_00165).l               ; 027D8
        tst.b   (dat_071_001FB).l               ; 027DE
        beq.b   l_000_0280A                     ; 027E4
        move.b  #$1,(dat_071_0027C).l           ; 027E6
        move.b  #$2,(dat_071_0027D).l           ; 027EE
        move.w  #$3,(dat_071_004A6).l           ; 027F6
        lea.l   h000+$28DA(pc),a0               ; 027FE
        move.l  a0,(dat_002_00004).l            ; 02802
        bra.b   l_000_0287A                     ; 02808
l_000_0280A:
        move.b  (dat_071_00276).l,d0            ; 0280A
        ext.w   d0                              ; 02810
        move.l  #dat_071_0011A,-$4(a6)          ; 02812
        move.b  (dat_071_00166).l,d1            ; 0281A
        move.w  d0,-$6(a6)                      ; 02820
        tst.b   d1                              ; 02824
        bne.b   l_000_02852                     ; 02826
        cmpi.w  #$3,d0                          ; 02828
        bcs.b   l_000_02852                     ; 0282C
        cmpi.w  #$8,d0                          ; 0282E
        bhi.b   l_000_02852                     ; 02832
        subq.w  #$3,d0                          ; 02834
        bne.b   l_000_02846                     ; 02836
        movea.l -$4(a6),a0                      ; 02838
        move.w  #$5f,(a0)                       ; 0283C
        addq.l  #$2,-$4(a6)                     ; 02840
        bra.b   l_000_02852                     ; 02844
l_000_02846:
        movea.l -$4(a6),a0                      ; 02846
        move.w  #$60,(a0)                       ; 0284A
        addq.l  #$2,-$4(a6)                     ; 0284E
l_000_02852:
        clr.b   (dat_071_00166).l               ; 02852
        movea.l -$4(a6),a0                      ; 02858
        move.w  #$47,(a0)                       ; 0285C
        addq.l  #$2,-$4(a6)                     ; 02860
        movea.l -$4(a6),a0                      ; 02864
        clr.w   (a0)                            ; 02868
        jsr     (sub_020_003C6).l               ; 0286A
        lea.l   h000+$287E(pc),a0               ; 02870
        move.l  a0,(dat_002_00004).l            ; 02874
l_000_0287A:
        unlk    a6                              ; 0287A
        rts                                     ; 0287C
        move.b  (dat_071_001B0).l,d0            ; 0287E
        subq.b  #$1,d0                          ; 02884
        bne.b   l_000_028A8                     ; 02886
        move.w  #$4,(dat_071_0011A).l           ; 02888
        clr.b   (dat_071_00193).l               ; 02890
        move.b  #$3,(dat_071_001B0).l           ; 02896
        lea.l   h000+$28AA(pc),a0               ; 0289E
        move.l  a0,(dat_002_00004).l            ; 028A2
l_000_028A8:
        rts                                     ; 028A8
        tst.b   (dat_071_0027C).l               ; 028AA
        beq.b   l_000_028D8                     ; 028B0
        tst.b   (dat_071_00155).l               ; 028B2
        beq.b   l_000_028C2                     ; 028B8
        move.b  #$2,(dat_071_0027D).l           ; 028BA
l_000_028C2:
        bsr.w   h000+$3462                      ; 028C2
        move.w  #$3,(dat_071_004A6).l           ; 028C6
        lea.l   h000+$28DA(pc),a0               ; 028CE
        move.l  a0,(dat_002_00004).l            ; 028D2
l_000_028D8:
        rts                                     ; 028D8
        link.w  a6,#$fffe                       ; 028DA
        move.w  (dat_071_004A6).l,d0            ; 028DE
        tst.w   d0                              ; 028E4
        bpl.w   l_000_02A26                     ; 028E6
        move.b  (dat_071_00276).l,d0            ; 028EA
        ext.w   d0                              ; 028F0
        move.b  (dat_071_0027C).l,d1            ; 028F2
        move.w  d0,-$2(a6)                      ; 028F8
        tst.b   d1                              ; 028FC
        ble.w   l_000_029DA                     ; 028FE
        lea.l   h000+$2A50(pc),a0               ; 02902
        move.l  a0,(dat_002_00004).l            ; 02906
        cmpi.w  #$3,d0                          ; 0290C
        bcs.b   l_000_0295C                     ; 02910
        cmpi.w  #$8,d0                          ; 02912
        bhi.b   l_000_0295C                     ; 02916
        move.w  #$5d,(dat_071_0011A).l          ; 02918
        moveq   #$0,d1                          ; 02920
        move.w  -$2(a6),d1                      ; 02922
        moveq   #$3,d0                          ; 02926
        move.l  d0,-(a7)                        ; 02928
        moveq   #$1,d0                          ; 0292A
        move.l  d0,-(a7)                        ; 0292C
        move.l  d1,-(a7)                        ; 0292E
        jsr     (sub_020_001F4).l               ; 02930
        lea.l   $c(a7),a7                       ; 02936
        movea.l (ConfigBuffer).l,a0             ; 0293A
        move.w  $36(a0),d0                      ; 02940
        addq.w  #$1,d0                          ; 02944
        movea.l (ConfigBuffer).l,a0             ; 02946
        move.w  d0,$36(a0)                      ; 0294C
        move.b  #$1,(dat_071_00195).l           ; 02950
        bra.w   l_000_02A26                     ; 02958
l_000_0295C:
        moveq   #$0,d0                          ; 0295C
        move.w  -$2(a6),d0                      ; 0295E
        moveq   #$20,d1                         ; 02962
l_000_02964:
        subi.l  #$8,d1                          ; 02964
        bmi.w   l_000_02A26                     ; 0296A
        cmp.l   h000+$2978(pc,d1.l),d0          ; 0296E
        bne.b   l_000_02964                     ; 02972
        jmp     h000+$297C(pc,d1.l)             ; 02974
        ori.b   #$9,d0                          ; 02978
        bra.w   l_000_029BE                     ; 0297C
        ori.b   #$7d,d0                         ; 02980
        bra.w   l_000_029B2                     ; 02984
        ori.b   #$2,d0                          ; 02988
        bra.w   l_000_029A6                     ; 0298C
        ori.b   #$1,d0                          ; 02990
        bra.w   l_000_02998                     ; 02994
l_000_02998:
        lea.l   h000+$2AC0(pc),a0               ; 02998
        move.l  a0,(dat_002_00004).l            ; 0299C
        bra.w   l_000_02A26                     ; 029A2
l_000_029A6:
        lea.l   h000+$2428(pc),a0               ; 029A6
        move.l  a0,(dat_002_00004).l            ; 029AA
        bra.b   l_000_02A26                     ; 029B0
l_000_029B2:
        lea.l   h000+$2428(pc),a0               ; 029B2
        move.l  a0,(dat_002_00004).l            ; 029B6
        bra.b   l_000_02A26                     ; 029BC
l_000_029BE:
        move.b  #$1,(dat_071_00165).l           ; 029BE
        move.w  #$3,(dat_071_004A6).l           ; 029C6
        lea.l   h000+$1CC0(pc),a0               ; 029CE
        move.l  a0,(dat_002_00004).l            ; 029D2
        bra.b   l_000_02A26                     ; 029D8
l_000_029DA:
        move.b  (dat_071_0027C).l,d0            ; 029DA
        tst.b   d0                              ; 029E0
        bpl.b   l_000_02A26                     ; 029E2
        clr.b   (dat_071_0027C).l               ; 029E4
        move.b  #$1,(dat_071_00165).l           ; 029EA
        bsr.w   h000+$3462                      ; 029F2
        move.w  #$3,(dat_071_004A6).l           ; 029F6
        move.b  (dat_071_00268).l,d0            ; 029FE
        subq.b  #$1,d0                          ; 02A04
        move.b  d0,(dat_071_00268).l            ; 02A06
        tst.b   d0                              ; 02A0C
        bmi.b   l_000_02A1C                     ; 02A0E
        lea.l   h000+$27C8(pc),a0               ; 02A10
        move.l  a0,(dat_002_00004).l            ; 02A14
        bra.b   l_000_02A26                     ; 02A1A
l_000_02A1C:
        lea.l   h000+$2A2A(pc),a0               ; 02A1C
        move.l  a0,(dat_002_00004).l            ; 02A20
l_000_02A26:
        unlk    a6                              ; 02A26
        rts                                     ; 02A28
        move.w  (dat_071_004A6).l,d0            ; 02A2A
        tst.w   d0                              ; 02A30
        bpl.b   l_000_02A4C                     ; 02A32
        clr.b   (dat_071_00165).l               ; 02A34
        move.w  #$43,(dat_071_0011A).l          ; 02A3A
        lea.l   h000+$2A4E(pc),a0               ; 02A42
        move.l  a0,(dat_002_00004).l            ; 02A46
l_000_02A4C:
        rts                                     ; 02A4C
        rts                                     ; 02A4E
        move.b  (dat_071_00173).l,d0            ; 02A50
        subq.b  #$2,d0                          ; 02A56
        bne.b   l_000_02A60                     ; 02A58
        bsr.w   l_000_02CFE                     ; 02A5A
        bra.b   l_000_02A90                     ; 02A5E
l_000_02A60:
        move.b  (dat_071_001B0).l,d0            ; 02A60
        tst.b   d0                              ; 02A66
        bpl.b   l_000_02A90                     ; 02A68
        move.b  #$1,(dat_071_00165).l           ; 02A6A
        bsr.w   h000+$3462                      ; 02A72
        move.b  #$1,(dat_071_00227).l           ; 02A76
        move.w  #$3,(dat_071_004A6).l           ; 02A7E
        lea.l   h000+$2A92(pc),a0               ; 02A86
        move.l  a0,(dat_002_00004).l            ; 02A8A
l_000_02A90:
        rts                                     ; 02A90
        move.b  (dat_071_00173).l,d0            ; 02A92
        subq.b  #$2,d0                          ; 02A98
        bne.b   l_000_02AA2                     ; 02A9A
        bsr.w   l_000_02CFE                     ; 02A9C
        bra.b   l_000_02ABE                     ; 02AA0
l_000_02AA2:
        move.w  (dat_071_004A6).l,d0            ; 02AA2
        tst.w   d0                              ; 02AA8
        bpl.b   l_000_02ABE                     ; 02AAA
        move.b  #$1,(dat_071_00185).l           ; 02AAC
        lea.l   h000+$2AC0(pc),a0               ; 02AB4
        move.l  a0,(dat_002_00004).l            ; 02AB8
l_000_02ABE:
        rts                                     ; 02ABE
        move.b  (dat_071_00173).l,d0            ; 02AC0
        subq.b  #$2,d0                          ; 02AC6
        bne.b   l_000_02AD0                     ; 02AC8
        bsr.w   l_000_02CFE                     ; 02ACA
        bra.b   l_000_02AFA                     ; 02ACE
l_000_02AD0:
        move.b  (dat_071_0027E).l,d0            ; 02AD0
        subq.b  #$4,d0                          ; 02AD6
        bne.b   l_000_02AFA                     ; 02AD8
        moveq   #$0,d0                          ; 02ADA
        move.b  d0,(dat_071_00185).l            ; 02ADC
        move.b  d0,(dat_071_00227).l            ; 02AE2
        move.w  #$2,(dat_071_004A6).l           ; 02AE8
        lea.l   h000+$2AFC(pc),a0               ; 02AF0
        move.l  a0,(dat_002_00004).l            ; 02AF4
l_000_02AFA:
        rts                                     ; 02AFA
        move.b  (dat_071_00173).l,d0            ; 02AFC
        subq.b  #$2,d0                          ; 02B02
        bne.b   l_000_02B0C                     ; 02B04
        bsr.w   l_000_02CFE                     ; 02B06
        bra.b   l_000_02B72                     ; 02B0A
l_000_02B0C:
        move.w  (dat_071_004A6).l,d0            ; 02B0C
        tst.w   d0                              ; 02B12
        bpl.b   l_000_02B72                     ; 02B14
        clr.b   (dat_071_00165).l               ; 02B16
        move.b  (dat_071_00276).l,d0            ; 02B1C
        cmpi.b  #$1,d0                          ; 02B22
        ble.b   l_000_02B30                     ; 02B26
        move.b  #$1,(dat_071_00185).l           ; 02B28
l_000_02B30:
        move.b  (dat_071_00276).l,d0            ; 02B30
        ext.w   d0                              ; 02B36
        ext.l   d0                              ; 02B38
        cmpi.l  #$1,d0                          ; 02B3A
        bne.b   l_000_02B5A                     ; 02B40
        move.w  #$7,(dat_071_0011A).l           ; 02B42
        move.b  #$5,(dat_071_0027E).l           ; 02B4A
        move.b  #$1,(dat_071_00227).l           ; 02B52
l_000_02B5A:
        moveq   #$0,d0                          ; 02B5A
        move.b  d0,(dat_071_0027D).l            ; 02B5C
        move.b  d0,(dat_071_00193).l            ; 02B62
        lea.l   h000+$2B74(pc),a0               ; 02B68
        move.l  a0,(dat_002_00004).l            ; 02B6C
l_000_02B72:
        rts                                     ; 02B72
        move.b  (dat_071_00173).l,d0            ; 02B74
        subq.b  #$2,d0                          ; 02B7A
        bne.b   l_000_02B84                     ; 02B7C
        bsr.w   l_000_02CFE                     ; 02B7E
        bra.b   l_000_02C00                     ; 02B82
l_000_02B84:
        tst.b   (dat_071_00185).l               ; 02B84
        beq.b   l_000_02BEE                     ; 02B8A
        clr.b   (dat_071_00185).l               ; 02B8C
        bsr.w   h000+$3462                      ; 02B92
        moveq   #$0,d0                          ; 02B96
        move.b  d0,(dat_071_0017D).l            ; 02B98
        moveq   #$3,d0                          ; 02B9E
        move.b  d0,(dat_071_00206).l            ; 02BA0
        moveq   #$1,d0                          ; 02BA6
        move.b  d0,(dat_071_00165).l            ; 02BA8
        move.w  #$2,(dat_071_004A6).l           ; 02BAE
        move.b  (dat_071_00218).l,d0            ; 02BB6
        subq.b  #$3,d0                          ; 02BBC
        beq.b   l_000_02BE2                     ; 02BBE
        lea.l   h000+$2C02(pc),a0               ; 02BC0
        move.l  a0,(dat_002_00004).l            ; 02BC4
        move.b  #$1,(dat_071_00161).l           ; 02BCA
        clr.b   (dat_071_00227).l               ; 02BD2
        move.b  #$6,(dat_071_0027E).l           ; 02BD8
        bra.b   l_000_02C00                     ; 02BE0
l_000_02BE2:
        lea.l   h000+$2C6E(pc),a0               ; 02BE2
        move.l  a0,(dat_002_00004).l            ; 02BE6
        bra.b   l_000_02C00                     ; 02BEC
l_000_02BEE:
        move.b  (dat_071_001B0).l,d0            ; 02BEE
        subq.b  #$1,d0                          ; 02BF4
        bne.b   l_000_02C00                     ; 02BF6
        move.b  #$1,(dat_071_00165).l           ; 02BF8
l_000_02C00:
        rts                                     ; 02C00
        moveq   #$0,d0                          ; 02C02
        move.b  d0,(dat_071_00185).l            ; 02C04
        move.w  (dat_071_004A6).l,d0            ; 02C0A
        tst.w   d0                              ; 02C10
        bpl.b   l_000_02C34                     ; 02C12
        moveq   #$0,d0                          ; 02C14
        move.b  d0,(dat_071_00165).l            ; 02C16
        move.w  #$4b,(dat_071_0011A).l          ; 02C1C
        move.b  d0,(dat_071_00193).l            ; 02C24
        lea.l   h000+$2C36(pc),a0               ; 02C2A
        move.l  a0,(dat_002_00004).l            ; 02C2E
l_000_02C34:
        rts                                     ; 02C34
        move.b  (dat_071_00161).l,d0            ; 02C36
        tst.b   d0                              ; 02C3C
        bne.b   l_000_02C6C                     ; 02C3E
        move.w  #$2,(dat_071_004A6).l           ; 02C40
        move.b  #$1,(dat_071_00165).l           ; 02C48
        bsr.w   h000+$3462                      ; 02C50
        moveq   #$1,d0                          ; 02C54
        move.b  d0,(dat_071_00227).l            ; 02C56
        move.b  d0,(dat_071_0027D).l            ; 02C5C
        lea.l   h000+$2C6E(pc),a0               ; 02C62
        move.l  a0,(dat_002_00004).l            ; 02C66
l_000_02C6C:
        rts                                     ; 02C6C
        move.w  (dat_071_004A6).l,d0            ; 02C6E
        tst.w   d0                              ; 02C74
        bpl.b   l_000_02CDE                     ; 02C76
        move.b  #$1,(dat_071_00185).l           ; 02C78
        bsr.b   l_000_02CE0                     ; 02C80
        jsr     (sub_004_002DA).l               ; 02C82
        moveq   #$0,d0                          ; 02C88
        move.b  d0,(dat_071_00186).l            ; 02C8A
        move.b  #$6,(dat_071_0027E).l           ; 02C90
        move.b  d0,(dat_071_0027D).l            ; 02C98
        move.b  (dat_071_00276).l,d0            ; 02C9E
        cmpi.b  #$3,d0                          ; 02CA4
        blt.b   l_000_02CD4                     ; 02CA8
        cmpi.b  #$8,d0                          ; 02CAA
        bgt.b   l_000_02CD4                     ; 02CAE
        btst    #$4,(dat_071_0052B).l           ; 02CB0
        beq.b   l_000_02CC8                     ; 02CB8
        moveq   #$8,d0                          ; 02CBA
        move.l  d0,-(a7)                        ; 02CBC
        jsr     (sub_000_09F9A).l               ; 02CBE
        addq.l  #$4,a7                          ; 02CC4
        bra.b   l_000_02CD4                     ; 02CC6
l_000_02CC8:
        moveq   #$8,d0                          ; 02CC8
        move.l  d0,-(a7)                        ; 02CCA
        jsr     (sub_000_09E46).l               ; 02CCC
        addq.l  #$4,a7                          ; 02CD2
l_000_02CD4:
        lea.l   h000+$2D58(pc),a0               ; 02CD4
        move.l  a0,(dat_002_00004).l            ; 02CD8
l_000_02CDE:
        rts                                     ; 02CDE
l_000_02CE0:
        jsr     (sub_004_003AE).l               ; 02CE0
        move.w  (dat_071_0029C).l,d0            ; 02CE6
        ori.w   #$800,d0                        ; 02CEC
        move.w  d0,(dat_071_0029C).l            ; 02CF0
        jsr     (sub_017_00000).l               ; 02CF6
        rts                                     ; 02CFC
l_000_02CFE:
        move.b  #$1,(dat_071_00165).l           ; 02CFE
        bsr.b   l_000_02CE0                     ; 02D06
        move.b  #$ff,(RedrawFlags).l            ; 02D08
        clr.b   (dat_071_0027E).l               ; 02D10
        bsr.w   h000+$3462                      ; 02D16
        moveq   #$0,d0                          ; 02D1A
        move.b  d0,(dat_071_0017E).l            ; 02D1C
        move.b  d0,(dat_071_00185).l            ; 02D22
        moveq   #$1,d0                          ; 02D28
        move.b  d0,(dat_071_00227).l            ; 02D2A
        move.b  d0,(dat_071_00184).l            ; 02D30
        moveq   #$0,d0                          ; 02D36
        move.b  d0,(dat_071_0027D).l            ; 02D38
        move.b  d0,(dat_071_00158).l            ; 02D3E
        move.w  #$5,(dat_071_004A6).l           ; 02D44
        lea.l   h000+$2DB8(pc),a0               ; 02D4C
        move.l  a0,(dat_002_00004).l            ; 02D50
        rts                                     ; 02D56
sub_000_02D58:
        move.b  (dat_071_00155).l,d0            ; 02D58
        tst.b   d0                              ; 02D5E
        bne.b   l_000_02D92                     ; 02D60
        move.b  #$1,(dat_071_00184).l           ; 02D62
        moveq   #$0,d0                          ; 02D6A
        move.b  d0,(dat_071_0027E).l            ; 02D6C
        move.b  d0,(dat_071_0027D).l            ; 02D72
        move.b  d0,(dat_071_00158).l            ; 02D78
        move.w  #$5,(dat_071_004A6).l           ; 02D7E
        lea.l   sub_000_02DB8(pc),a0            ; 02D86
        move.l  a0,(dat_002_00004).l            ; 02D8A
        bra.b   l_000_02DB6                     ; 02D90
l_000_02D92:
        move.b  (dat_071_0017E).l,d0            ; 02D92
        tst.b   d0                              ; 02D98
        bpl.b   l_000_02DB6                     ; 02D9A
        move.w  #$2,(dat_071_004A6).l           ; 02D9C
        move.b  #$a,(dat_071_00271).l           ; 02DA4
        move.l  #sub_000_03B76,(dat_002_00004).l ; 02DAC
l_000_02DB6:
        rts                                     ; 02DB6
sub_000_02DB8:
        link.w  a6,#$fffa                       ; 02DB8
        move.w  (dat_071_004A6).l,d0            ; 02DBC
        tst.w   d0                              ; 02DC2
        bpl.w   l_000_02E4A                     ; 02DC4
        move.b  (dat_071_00276).l,d0            ; 02DC8
        clr.b   (dat_071_00165).l               ; 02DCE
        move.l  #dat_071_0011A,-$4(a6)          ; 02DD4
        move.b  d0,-$5(a6)                      ; 02DDC
        cmpi.b  #$3,d0                          ; 02DE0
        blt.b   l_000_02E02                     ; 02DE4
        cmpi.b  #$8,d0                          ; 02DE6
        bgt.b   l_000_02E02                     ; 02DEA
        jsr     (sub_020_002C0).l               ; 02DEC
        tst.l   d0                              ; 02DF2
        bmi.b   l_000_02E02                     ; 02DF4
        movea.l -$4(a6),a0                      ; 02DF6
        move.w  #$58,(a0)                       ; 02DFA
        addq.l  #$2,-$4(a6)                     ; 02DFE
l_000_02E02:
        cmpi.b  #$2,-$5(a6)                     ; 02E02
        beq.b   l_000_02E32                     ; 02E08
        move.b  (Player_04).l,d0                ; 02E0A
        btst    #$3,d0                          ; 02E10
        beq.b   l_000_02E24                     ; 02E14
        movea.l -$4(a6),a0                      ; 02E16
        move.w  #$5a,(a0)                       ; 02E1A
        addq.l  #$2,-$4(a6)                     ; 02E1E
        bra.b   l_000_02E3A                     ; 02E22
l_000_02E24:
        movea.l -$4(a6),a0                      ; 02E24
        move.w  #$59,(a0)                       ; 02E28
        addq.l  #$2,-$4(a6)                     ; 02E2C
        bra.b   l_000_02E3A                     ; 02E30
l_000_02E32:
        move.b  #$ff,(dat_071_001B0).l          ; 02E32
l_000_02E3A:
        movea.l -$4(a6),a0                      ; 02E3A
        clr.w   (a0)                            ; 02E3E
        lea.l   h000+$2E4E(pc),a0               ; 02E40
        move.l  a0,(dat_002_00004).l            ; 02E44
l_000_02E4A:
        unlk    a6                              ; 02E4A
        rts                                     ; 02E4C
        move.b  (dat_071_001B0).l,d0            ; 02E4E
        tst.b   d0                              ; 02E54
        bpl.w   l_000_02ED8                     ; 02E56
        moveq   #$1,d0                          ; 02E5A
        move.b  d0,(dat_071_00165).l            ; 02E5C
        move.w  (dat_071_0029C).l,d0            ; 02E62
        ori.w   #$40,d0                         ; 02E68
        move.w  d0,(dat_071_0029C).l            ; 02E6C
        move.w  (dat_071_0029E).l,d0            ; 02E72
        ori.w   #$100,d0                        ; 02E78
        move.w  d0,(dat_071_0029E).l            ; 02E7C
        move.w  (dat_071_002A2).l,d0            ; 02E82
        ori.w   #$2,d0                          ; 02E88
        move.w  d0,(dat_071_002A2).l            ; 02E8C
        move.b  (dat_071_00276).l,d0            ; 02E92
        subq.b  #$2,d0                          ; 02E98
        bne.b   l_000_02EA4                     ; 02E9A
        move.b  #$1,(dat_071_00163).l           ; 02E9C
l_000_02EA4:
        jsr     (ReadTime).l                    ; 02EA4
        move.l  (TimeSeconds).l,d0              ; 02EAA
        move.l  d0,(dat_071_002E4).l            ; 02EB0
        move.l  (TimeSeconds).l,(dat_071_002DC).l ; 02EB6
        clr.w   (FrameCount).l                  ; 02EC0
        move.w  #$3,(dat_071_004A6).l           ; 02EC6
        lea.l   h000+$2EDA(pc),a0               ; 02ECE
        move.l  a0,(dat_002_00004).l            ; 02ED2
l_000_02ED8:
        rts                                     ; 02ED8
        move.w  (dat_071_004A6).l,d0            ; 02EDA
        tst.w   d0                              ; 02EE0
        bpl.b   l_000_02EFC                     ; 02EE2
        move.b  #$1,(dat_071_00171).l           ; 02EE4
        jsr     (l_039_01880).l                 ; 02EEC
        lea.l   h000+$2EFE(pc),a0               ; 02EF2
        move.l  a0,(dat_002_00004).l            ; 02EF6
l_000_02EFC:
        rts                                     ; 02EFC
sub_000_02EFE:
        link.w  a6,#$fffe                       ; 02EFE
        move.b  (dat_071_00168).l,-$1(a6)       ; 02F02
        move.w  (ObjectTable).l,d0              ; 02F0A
        btst    #$9,d0                          ; 02F10
        beq.w   l_000_02FE6                     ; 02F14
        move.b  (Player_7C).l,d0                ; 02F18
        andi.b  #$f,d0                          ; 02F1E
        tst.b   d0                              ; 02F22
        bne.w   l_000_02FE6                     ; 02F24
        tst.b   (dat_071_0015C).l               ; 02F28
        beq.w   l_000_02FC4                     ; 02F2E
        movea.l (ConfigBuffer).l,a0             ; 02F32
        move.w  $10(a0),d0                      ; 02F38
        addq.w  #$1,d0                          ; 02F3C
        movea.l (ConfigBuffer).l,a0             ; 02F3E
        move.w  d0,$10(a0)                      ; 02F44
        moveq   #$1,d0                          ; 02F48
        move.b  d0,(dat_071_00195).l            ; 02F4A
        move.w  (dat_071_0029A).l,d0            ; 02F50
        andi.w  #$feff,d0                       ; 02F56
        move.w  d0,(dat_071_0029A).l            ; 02F5A
        move.w  (dat_071_0029C).l,d0            ; 02F60
        andi.w  #$ffbf,d0                       ; 02F66
        move.w  d0,(dat_071_0029C).l            ; 02F6A
        move.w  (ObjectTable).l,d0              ; 02F70
        andi.w  #$fdff,d0                       ; 02F76
        move.w  d0,(ObjectTable).l              ; 02F7A
        move.b  (dat_071_00155).l,d0            ; 02F80
        tst.b   d0                              ; 02F86
        bne.b   l_000_02FB6                     ; 02F88
        move.b  #$1,(dat_071_0026A).l           ; 02F8A
        clr.l   (PlayerVelY).l                  ; 02F92
        move.b  #$28,(dat_071_00269).l          ; 02F98
        jsr     (sub_000_015F6).l               ; 02FA0
        moveq   #$78,d0                         ; 02FA6
        move.l  d0,-(a7)                        ; 02FA8
        moveq   #$3f,d0                         ; 02FAA
        move.l  d0,-(a7)                        ; 02FAC
        jsr     (sub_000_0A0DC).l               ; 02FAE
        addq.l  #$8,a7                          ; 02FB4
l_000_02FB6:
        move.l  #sub_000_038D8,(dat_002_00004).l ; 02FB6
        bra.w   l_000_03198                     ; 02FC0
l_000_02FC4:
        move.w  (ObjectTable).l,d0              ; 02FC4
        andi.w  #$fdff,d0                       ; 02FCA
        move.w  d0,(ObjectTable).l              ; 02FCE
        move.l  #$4021,-(a7)                    ; 02FD4
        jsr     (sub_000_03D00).l               ; 02FDA
        addq.l  #$4,a7                          ; 02FE0
        bra.w   l_000_03198                     ; 02FE2
l_000_02FE6:
        move.b  (dat_071_0017E).l,d0            ; 02FE6
        tst.b   d0                              ; 02FEC
        bpl.b   l_000_0301E                     ; 02FEE
        move.w  #$2,(dat_071_004A6).l           ; 02FF0
        move.b  #$a,(dat_071_00271).l           ; 02FF8
        jsr     (ReadTime).l                    ; 03000
        move.l  (TimeSeconds).l,(dat_071_002D4).l ; 03006
        move.l  #sub_000_03B76,(dat_002_00004).l ; 03010
        bra.w   l_000_03198                     ; 0301A
l_000_0301E:
        move.b  -$1(a6),d0                      ; 0301E
        cmpi.b  #$ff,d0                         ; 03022
        bgt.w   l_000_03118                     ; 03026
        cmpi.b  #$fc,d0                         ; 0302A
        blt.w   l_000_03118                     ; 0302E
        tst.b   (dat_071_00193).l               ; 03032
        beq.w   l_000_03118                     ; 03038
        tst.b   (dat_071_001B0).l               ; 0303C
        beq.w   l_000_03118                     ; 03042
        cmpi.b  #$ff,d0                         ; 03046
        bne.b   l_000_03056                     ; 0304A
        move.b  #$1,(dat_071_00168).l           ; 0304C
        bra.b   l_000_03078                     ; 03054
l_000_03056:
        cmpi.b  #$fe,-$1(a6)                    ; 03056
        bne.b   l_000_03068                     ; 0305C
        move.b  #$2,(dat_071_00168).l           ; 0305E
        bra.b   l_000_03078                     ; 03066
l_000_03068:
        cmpi.b  #$fc,-$1(a6)                    ; 03068
        bne.b   l_000_03078                     ; 0306E
        move.b  #$4,(dat_071_00168).l           ; 03070
l_000_03078:
        move.b  #$1,(dat_071_00165).l           ; 03078
        bsr.w   sub_000_03462                   ; 03080
        moveq   #$0,d0                          ; 03084
        move.b  d0,(dat_071_0027D).l            ; 03086
        move.b  #$fe,(dat_071_00280).l          ; 0308C
        move.b  #$ff,(RedrawFlags).l            ; 03094
        move.b  d0,(dat_071_0017E).l            ; 0309C
        tst.w   (dat_071_002AC).l               ; 030A2
        beq.w   l_000_03198                     ; 030A8
        moveq   #$0,d0                          ; 030AC
        move.w  d0,(dat_071_002AC).l            ; 030AE
        move.w  d0,(ViewObject).l               ; 030B4
        move.b  (dat_071_00204).l,d0            ; 030BA
        move.b  d0,(dat_071_00155).l            ; 030C0
        tst.b   d0                              ; 030C6
        beq.b   l_000_030DC                     ; 030C8
        move.w  #$32,(dat_071_00356).l          ; 030CA
        move.w  #$a7,(ClipY).l                  ; 030D2
        bra.b   l_000_030EA                     ; 030DA
l_000_030DC:
        clr.w   (dat_071_00356).l               ; 030DC
        move.w  #$90,(ClipY).l                  ; 030E2
l_000_030EA:
        clr.b   (dat_071_00177).l               ; 030EA
        move.w  (dat_071_00356).l,d0            ; 030F0
        asl.w   #$4,d0                          ; 030F6
        move.w  d0,(ViewX).l                    ; 030F8
        jsr     (RedrawInstruments).l           ; 030FE
        move.b  (dat_071_0018E).l,d0            ; 03104
        andi.b  #$7f,d0                         ; 0310A
        move.b  d0,(dat_071_00282).l            ; 0310E
        bra.w   l_000_03198                     ; 03114
l_000_03118:
        move.b  (dat_071_001FA).l,d0            ; 03118
        cmpi.b  #$ff,d0                         ; 0311E
        bne.b   l_000_0313E                     ; 03122
        clr.b   (dat_071_001FA).l               ; 03124
        move.b  #$ff,(dat_071_001B0).l          ; 0312A
        move.l  #sub_000_03A4C,(dat_002_00004).l ; 03132
        bra.b   l_000_03198                     ; 0313C
l_000_0313E:
        cmpi.b  #$f0,-$1(a6)                    ; 0313E
        bne.b   l_000_03152                     ; 03144
        move.l  #sub_000_03A4C,(dat_002_00004).l ; 03146
        bra.b   l_000_03198                     ; 03150
l_000_03152:
        cmpi.b  #$ef,-$1(a6)                    ; 03152
        bne.b   l_000_03166                     ; 03158
        move.l  #sub_000_03AA8,(dat_002_00004).l ; 0315A
        bra.b   l_000_03198                     ; 03164
l_000_03166:
        move.w  (ViewObject).l,d0               ; 03166
        tst.w   d0                              ; 0316C
        bne.b   l_000_03190                     ; 0316E
        move.b  (dat_071_00155).l,d0            ; 03170
        tst.b   d0                              ; 03176
        bne.b   l_000_03190                     ; 03178
        move.b  (dat_071_00259).l,d0            ; 0317A
        cmpi.b  #$5,d0                          ; 03180
        ble.b   l_000_03190                     ; 03184
        move.b  #$2,(dat_071_00271).l           ; 03186
        bra.b   l_000_03198                     ; 0318E
l_000_03190:
        move.b  #$f,(dat_071_00271).l           ; 03190
l_000_03198:
        unlk    a6                              ; 03198
        rts                                     ; 0319A
dat_000_0319C:
	dc.b	$30,$39
        dc.l    dat_071_004A6                   ; 0319E
	dc.b	$4A,$40,$6A,$20,$70,$00,$13,$C0
        dc.l    dat_071_00165                   ; 031AA
	dc.b	$33,$FC,$00,$0E
        dc.l    dat_071_0011A                   ; 031B2
	dc.b	$13,$C0
        dc.l    dat_071_001B0                   ; 031B8
	dc.b	$23,$FC
        dc.l    sub_000_03A4C                   ; 031BE
        dc.l    dat_002_00004                   ; 031C2
	dc.b	$4E,$75
dat_000_031C8:
	dc.b	$30,$39
        dc.l    dat_071_004A6                   ; 031CA
	dc.b	$4A,$40,$6A,$20,$70,$01,$13,$C0
        dc.l    dat_071_0017E                   ; 031D6
	dc.b	$33,$FC,$00,$02
        dc.l    dat_071_004A6                   ; 031DE
	dc.b	$41,$FA,$00,$10,$23,$C8
        dc.l    dat_002_00004                   ; 031E8
	dc.b	$13,$C0
        dc.l    dat_071_0027D                   ; 031EE
	dc.b	$4E,$75,$4E,$56,$FF,$FA,$30,$39
        dc.l    dat_071_004A6                   ; 031FA
	dc.b	$4A,$40,$6A,$00,$02,$5C,$10,$39
        dc.l    dat_071_00276                   ; 03206
	dc.b	$48,$80,$2D,$7C
        dc.l    dat_071_0011A                   ; 0320E
	dc.b	$FF,$FA,$42,$39
        dc.l    dat_071_00165                   ; 03216
	dc.b	$41,$FA,$FC,$E2,$23,$C8
        dc.l    dat_002_00004                   ; 03220
	dc.b	$3D,$40,$FF,$FE,$61,$00,$02,$38,$10,$39
        dc.l    dat_071_00168                   ; 0322E
	dc.b	$0C,$00,$00,$FF,$66,$00,$00,$D2,$30,$2E,$FF,$FE,$0C,$40,$00,$03
	dc.b	$65,$4C,$0C,$40,$00,$08,$62,$46,$72,$00,$32,$2E,$FF,$FE,$70,$04
	dc.b	$2F,$00,$42,$A7,$2F,$01,$4E,$B9
        dc.l    sub_020_001F4                   ; 0325A
	dc.b	$4F,$EF,$00,$0C,$20,$6E,$FF,$FA,$54,$88,$2D,$48,$FF,$FA,$0C,$6E
	dc.b	$00,$03,$FF,$FE,$66,$0C,$30,$BC,$80,$55,$54,$AE,$FF,$FA,$60,$00
	dc.b	$01,$AE,$20,$6E,$FF,$FA,$30,$BC,$80,$56,$54,$AE,$FF,$FA,$60,$00
	dc.b	$01,$9E,$10,$39
        dc.l    dat_071_00276                   ; 03292
	dc.b	$48,$80,$48,$C0,$0C,$80,$00,$00,$00,$09,$67,$20,$0C,$80,$00,$00
	dc.b	$00,$7D,$66,$50,$20,$6E,$FF,$FA,$30,$BC,$00,$48,$54,$AE,$FF,$FA
	dc.b	$13,$FC,$00,$F0
        dc.l    dat_071_00168                   ; 032BA
	dc.b	$60,$00,$01,$6C,$20,$79
        dc.l    ConfigBuffer                    ; 032C4
	dc.b	$30,$BC,$00,$01,$4E,$B9
        dc.l    SaveConfig                      ; 032CE
	dc.b	$20,$6E,$FF,$FA,$30,$BC,$00,$4A,$54,$88,$30,$BC,$80,$53,$54,$88
	dc.b	$13,$FC,$00,$01
        dc.l    dat_071_001FB                   ; 032E6
	dc.b	$13,$FC,$00,$EF
        dc.l    dat_071_00168                   ; 032EE
	dc.b	$2D,$48,$FF,$FA,$60,$00,$01,$34,$20,$6E,$FF,$FA,$30,$BC,$00,$41
	dc.b	$54,$AE,$FF,$FA,$60,$00,$01,$24,$10,$39
        dc.l    dat_071_00168                   ; 0330C
	dc.b	$0C,$00,$00,$FE,$66,$00,$00,$E4,$10,$39
        dc.l    dat_071_00276                   ; 0331A
	dc.b	$48,$80,$48,$C0,$04,$80,$00,$00,$00,$04,$6D,$00,$00,$A0,$0C,$80
	dc.b	$00,$00,$00,$04,$6C,$00,$00,$96,$E3,$80,$4E,$FB,$08,$02,$60,$06
	dc.b	'`,`@`L09'
        dc.l    FrameCount                      ; 03346
	dc.b	$08,$00,$00,$00,$67,$0E,$20,$6E,$FF,$FA,$30,$BC,$00,$24,$54,$AE
	dc.b	$FF,$FA,$60,$78,$20,$6E,$FF,$FA,$30,$BC,$00,$25,$54,$AE,$FF,$FA
	dc.b	$60,$6A,$20,$6E,$FF,$FA,$30,$BC,$00,$2C,$54,$AE,$FF,$FA,$13,$FC
	dc.b	$00,$F0
        dc.l    dat_071_00168                   ; 0337C
	dc.b	$60,$54,$20,$6E,$FF,$FA,$30,$BC,$00,$33,$54,$AE,$FF,$FA,$60,$46
	dc.b	$20,$6E,$FF,$FA,$30,$BC,$00,$39,$54,$88,$30,$39
        dc.l    FrameCount                      ; 0339C
	dc.b	$2D,$48,$FF,$FA,$08,$00,$00,$00,$67,$12,$30,$BC,$80,$3A,$54,$AE
	dc.b	$FF,$FA,$13,$FC,$00,$F0
        dc.l    dat_071_00168                   ; 033B6
	dc.b	$60,$1A,$20,$6E,$FF,$FA,$30,$BC,$80,$5C,$54,$AE,$FF,$FA,$60,$0C
	dc.b	$20,$6E,$FF,$FA,$30,$BC,$00,$42,$54,$AE,$FF,$FA,$10,$39
        dc.l    dat_071_00168                   ; 033D8
	dc.b	$0C,$00,$00,$F0,$67,$4A,$20,$6E,$FF,$FA,$54,$88,$30,$BC,$80,$56
	dc.b	$54,$88,$30,$BC,$80,$53,$54,$88,$2D,$48,$FF,$FA,$60,$32,$10,$39
        dc.l    dat_071_00168                   ; 033FC
	dc.b	$0C,$00,$00,$FD,$66,$26,$10,$39
        dc.l    dat_071_00276                   ; 03408
	dc.b	$48,$80,$48,$C0,$0C,$80,$00,$00,$00,$04,$66,$14,$20,$6E,$FF,$FA
	dc.b	$30,$BC,$00,$4C,$54,$AE,$FF,$FA,$13,$FC,$00,$F0
        dc.l    dat_071_00168                   ; 03428
	dc.b	$10,$39
        dc.l    dat_071_00168                   ; 0342E
	dc.b	$0C,$00,$00,$FC,$66,$20,$20,$6E,$FF,$FA,$30,$BC,$00,$54,$54,$88
	dc.b	$30,$BC,$80,$53,$54,$88,$2D,$48,$FF,$FA,$4E,$B9
        dc.l    sub_000_034A0                   ; 0344E
	dc.b	$4E,$B9
        dc.l    SaveConfig                      ; 03454
	dc.b	$20,$6E,$FF,$FA
	dc.b	'BPN^Nu'
sub_000_03462:
        link.w  a6,#$fffc                       ; 03462
        lea.l   (dat_071_0011A).l,a0            ; 03466
        moveq   #$0,d0                          ; 0346C
        move.w  d0,(a0)                         ; 0346E
        addq.l  #$2,a0                          ; 03470
        move.w  d0,(a0)                         ; 03472
        addq.l  #$2,a0                          ; 03474
        move.l  #$1b8,(dat_071_0010E).l         ; 03476
        moveq   #$0,d0                          ; 03480
        move.b  d0,(dat_071_00196).l            ; 03482
        move.b  d0,(dat_071_00193).l            ; 03488
        move.b  d0,(dat_071_001B0).l            ; 0348E
        move.b  d0,(dat_071_00241).l            ; 03494
        unlk    a6                              ; 0349A
        rts                                     ; 0349C
	dc.b	$00,$00
sub_000_034A0:
        link.w  a6,#$fffc                       ; 034A0
        move.b  (dat_071_00276).l,d0            ; 034A4
        ext.w   d0                              ; 034AA
        ext.l   d0                              ; 034AC
        movea.l (ConfigBuffer).l,a0             ; 034AE
        adda.w  #$12,a0                         ; 034B4
        adda.l  d0,a0                           ; 034B8
        move.l  a0,-$4(a6)                      ; 034BA
        jsr     (PutDifficulty).l               ; 034BE
        movea.l (ConfigBuffer).l,a0             ; 034C4
        move.b  (dat_071_00276).l,$6(a0)        ; 034CA
        movea.l -$4(a6),a0                      ; 034D2
        movea.l (ConfigBuffer).l,a1             ; 034D6
        move.b  (a0),$7(a1)                     ; 034DC
        movea.l (ConfigBuffer).l,a0             ; 034E0
        move.w  $38(a0),d0                      ; 034E6
        addq.w  #$1,d0                          ; 034EA
        movea.l (ConfigBuffer).l,a0             ; 034EC
        move.w  d0,$38(a0)                      ; 034F2
        move.b  (Difficulty).l,d0               ; 034F6
        addq.b  #$1,d0                          ; 034FC
        move.b  d0,(Difficulty).l               ; 034FE
        cmpi.b  #$3,d0                          ; 03504
        ble.b   l_000_03512                     ; 03508
        move.b  #$3,(Difficulty).l              ; 0350A
l_000_03512:
        movea.l -$4(a6),a0                      ; 03512
        move.b  (a0),d0                         ; 03516
        addq.b  #$1,d0                          ; 03518
        move.b  d0,(a0)                         ; 0351A
        cmpi.b  #$3,d0                          ; 0351C
        bls.b   l_000_03526                     ; 03520
        move.b  #$3,(a0)                        ; 03522
l_000_03526:
        move.b  (Difficulty).l,(DifficultySaved).l ; 03526
        unlk    a6                              ; 03530
        rts                                     ; 03532
sub_000_03534:
        move.w  (dat_071_004A6).l,d0            ; 03534
        tst.w   d0                              ; 0353A
        bpl.b   l_000_03566                     ; 0353C
        pea.l   (dat_021_00000).l               ; 0353E
        bsr.w   sub_000_03C1C                   ; 03544
        addq.l  #$4,a7                          ; 03548
        move.w  #$61,(dat_071_0011A).l          ; 0354A
        move.w  #$1f4,(dat_071_004A6).l         ; 03552
        lea.l   sub_000_0356E(pc),a0            ; 0355A
        move.l  a0,(dat_002_00004).l            ; 0355E
        bra.b   l_000_0356C                     ; 03564
l_000_03566:
        jsr     (sub_036_00892).l               ; 03566
l_000_0356C:
        rts                                     ; 0356C
sub_000_0356E:
        move.b  (dat_071_001B0).l,d0            ; 0356E
        tst.b   d0                              ; 03574
        bpl.b   l_000_03594                     ; 03576
        move.w  (dat_071_004A6).l,d0            ; 03578
        tst.w   d0                              ; 0357E
        bpl.b   l_000_03594                     ; 03580
        move.w  #$3,(dat_071_004A6).l           ; 03582
        lea.l   sub_000_0356E(pc),a0            ; 0358A
        move.l  a0,(dat_002_00004).l            ; 0358E
l_000_03594:
        rts                                     ; 03594
sub_000_03596:
        move.w  (dat_071_004A6).l,d0            ; 03596
        tst.w   d0                              ; 0359C
        bpl.b   l_000_035C0                     ; 0359E
        pea.l   (dat_021_00000).l               ; 035A0
        bsr.w   sub_000_03C1C                   ; 035A6
        addq.l  #$4,a7                          ; 035AA
        move.w  #$f,(dat_071_0011A).l           ; 035AC
        lea.l   sub_000_035C8(pc),a0            ; 035B4
        move.l  a0,(dat_002_00004).l            ; 035B8
        bra.b   l_000_035C6                     ; 035BE
l_000_035C0:
        jsr     (sub_036_00892).l               ; 035C0
l_000_035C6:
        rts                                     ; 035C6
sub_000_035C8:
        tst.b   (dat_071_00173).l               ; 035C8
        beq.b   l_000_03620                     ; 035CE
        move.l  #$1f0000,(dat_071_00038).l      ; 035D0
        move.b  #$1,(dat_071_001A7).l           ; 035DA
        pea.l   (dat_021_00080).l               ; 035E2
        bsr.w   h000+$3C1C                      ; 035E8
        addq.l  #$4,a7                          ; 035EC
        jsr     (sub_000_03462).l               ; 035EE
        jsr     (sub_036_00892).l               ; 035F4
        move.b  #$1,(dat_071_001A3).l           ; 035FA
        move.w  #$5,(dat_071_004A6).l           ; 03602
        clr.b   (dat_071_00276).l               ; 0360A
        jsr     (LoadConfig).l                  ; 03610
        lea.l   h000+$3622(pc),a0               ; 03616
        move.l  a0,(dat_002_00004).l            ; 0361A
l_000_03620:
        rts                                     ; 03620
sub_000_03622:
        link.w  a6,#$fffc                       ; 03622
        jsr     (sub_036_00892).l               ; 03626
        move.w  #$5,(dat_071_004A6).l           ; 0362C
        move.b  (dat_071_001A3).l,d0            ; 03634
        tst.b   d0                              ; 0363A
        bne.b   l_000_0365A                     ; 0363C
        jsr     (LoadConfig).l                  ; 0363E
        move.b  #$ff,(dat_071_001A5).l          ; 03644
        lea.l   sub_000_0370A(pc),a0            ; 0364C
        move.l  a0,(dat_002_00004).l            ; 03650
        bra.w   l_000_036EA                     ; 03656
l_000_0365A:
        move.w  (dat_071_002F8).l,d0            ; 0365A
        tst.w   d0                              ; 03660
        bne.b   l_000_03676                     ; 03662
        clr.b   (dat_071_001A3).l               ; 03664
        lea.l   sub_000_0370A(pc),a0            ; 0366A
        move.l  a0,(dat_002_00004).l            ; 0366E
        bra.b   l_000_036EA                     ; 03674
l_000_03676:
        pea.l   (dat_021_00000).l               ; 03676
        bsr.w   sub_000_03C1C                   ; 0367C
        addq.l  #$4,a7                          ; 03680
        lea.l   (dat_071_0011A).l,a0            ; 03682
        move.w  (dat_071_002F8).l,d0            ; 03688
        move.l  a0,-$4(a6)                      ; 0368E
        subq.w  #$1,d0                          ; 03692
        bne.b   l_000_036A0                     ; 03694
        move.w  #$44,(a0)                       ; 03696
        addq.l  #$2,-$4(a6)                     ; 0369A
        bra.b   l_000_036CE                     ; 0369E
l_000_036A0:
        move.w  (dat_071_002F8).l,d0            ; 036A0
        subq.w  #$2,d0                          ; 036A6
        bne.b   l_000_036B8                     ; 036A8
        movea.l -$4(a6),a0                      ; 036AA
        move.w  #$45,(a0)                       ; 036AE
        addq.l  #$2,-$4(a6)                     ; 036B2
        bra.b   l_000_036CE                     ; 036B6
l_000_036B8:
        move.w  (dat_071_002F8).l,d0            ; 036B8
        subq.w  #$3,d0                          ; 036BE
        bne.b   l_000_036CE                     ; 036C0
        movea.l -$4(a6),a0                      ; 036C2
        move.w  #$46,(a0)                       ; 036C6
        addq.l  #$2,-$4(a6)                     ; 036CA
l_000_036CE:
        movea.l -$4(a6),a0                      ; 036CE
        move.w  #$5e,(a0)                       ; 036D2
        addq.l  #$2,-$4(a6)                     ; 036D6
        movea.l -$4(a6),a0                      ; 036DA
        clr.w   (a0)                            ; 036DE
        lea.l   dat_000_036EE(pc),a0            ; 036E0
        move.l  a0,(dat_002_00004).l            ; 036E4
l_000_036EA:
        unlk    a6                              ; 036EA
        rts                                     ; 036EC
dat_000_036EE:
	dc.b	$10,$39
        dc.l    dat_071_001A3                   ; 036F0
	dc.b	$4A,$00,$66,$10,$4E,$B9
        dc.l    sub_036_00892                   ; 036FA
	dc.b	$41,$FA,$FF,$22,$23,$C8
        dc.l    dat_002_00004                   ; 03704
	dc.b	$4E,$75
sub_000_0370A:
        link.w  a6,#$fff6                       ; 0370A
        move.w  (dat_071_002F8).l,d0            ; 0370E
        tst.w   d0                              ; 03714
        bne.w   l_000_037D6                     ; 03716
        move.w  (dat_071_004A6).l,d0            ; 0371A
        tst.w   d0                              ; 03720
        bpl.w   l_000_037CE                     ; 03722
        move.b  #$1,(dat_071_0027D).l           ; 03726
        pea.l   (dat_021_00000).l               ; 0372E
        bsr.w   h000+$3C1C                      ; 03734
        addq.l  #$4,a7                          ; 03738
        moveq   #$0,d0                          ; 0373A
        move.b  d0,(dat_071_001B0).l            ; 0373C
        move.b  d0,(dat_071_00193).l            ; 03742
        movea.l (ConfigBuffer).l,a0             ; 03748
        move.w  $4(a0),d0                       ; 0374E
        cmpi.w  #$0,d0                          ; 03752
        bhi.b   l_000_0376C                     ; 03756
        move.w  #$1,(dat_071_0011A).l           ; 03758
        lea.l   h000+$37EA(pc),a0               ; 03760
        move.l  a0,(dat_002_00004).l            ; 03764
        bra.b   l_000_037E6                     ; 0376A
l_000_0376C:
        move.w  #$2,(dat_071_0011A).l           ; 0376C
        lea.l   (dat_064_004E3).l,a0            ; 03774
        move.l  a0,-$6(a6)                      ; 0377A
        adda.w  #$a,a0                          ; 0377E
        movea.l (ConfigBuffer).l,a1             ; 03782
        adda.w  #$1e,a1                         ; 03788
        clr.w   -$2(a6)                         ; 0378C
        move.l  a0,-$6(a6)                      ; 03790
        move.l  a1,-$a(a6)                      ; 03794
l_000_03798:
        cmpi.w  #$18,-$2(a6)                    ; 03798
        bge.b   l_000_037C2                     ; 0379E
        movea.l -$a(a6),a0                      ; 037A0
        move.b  (a0),d0                         ; 037A4
        tst.b   d0                              ; 037A6
        beq.b   l_000_037C2                     ; 037A8
        movea.l -$a(a6),a0                      ; 037AA
        movea.l -$6(a6),a1                      ; 037AE
        move.b  (a0),(a1)                       ; 037B2
        addq.l  #$1,-$a(a6)                     ; 037B4
        addq.l  #$1,-$6(a6)                     ; 037B8
        addq.w  #$1,-$2(a6)                     ; 037BC
        bra.b   l_000_03798                     ; 037C0
l_000_037C2:
        lea.l   h000+$3800(pc),a0               ; 037C2
        move.l  a0,(dat_002_00004).l            ; 037C6
        bra.b   l_000_037E6                     ; 037CC
l_000_037CE:
        jsr     (sub_036_00892).l               ; 037CE
        bra.b   l_000_037E6                     ; 037D4
l_000_037D6:
        jsr     (sub_000_03462).l               ; 037D6
        move.l  #sub_000_01D30,(dat_002_00004).l ; 037DC
l_000_037E6:
        unlk    a6                              ; 037E6
        rts                                     ; 037E8
        move.b  (dat_071_001B0).l,d0            ; 037EA
        tst.b   d0                              ; 037F0
        bpl.b   l_000_037FE                     ; 037F2
        lea.l   h000+$381E(pc),a0               ; 037F4
        move.l  a0,(dat_002_00004).l            ; 037F8
l_000_037FE:
        rts                                     ; 037FE
        move.b  (dat_071_001B0).l,d0            ; 03800
        tst.b   d0                              ; 03806
        bmi.b   l_000_03812                     ; 03808
        tst.b   (dat_071_00173).l               ; 0380A
        beq.b   l_000_0381C                     ; 03810
l_000_03812:
        lea.l   h000+$381E(pc),a0               ; 03812
        move.l  a0,(dat_002_00004).l            ; 03816
l_000_0381C:
        rts                                     ; 0381C
        jsr     (sub_000_03462).l               ; 0381E
        move.w  #$5,(dat_071_004A6).l           ; 03824
        movea.l (ConfigBuffer).l,a0             ; 0382C
        move.w  $4(a0),d0                       ; 03832
        cmpi.w  #$0,d0                          ; 03836
        bhi.b   l_000_03866                     ; 0383A
        move.w  #$3,(dat_071_0011A).l           ; 0383C
        clr.b   (dat_071_00193).l               ; 03844
        move.b  #$2,(dat_071_001B0).l           ; 0384A
        move.b  #$14,(dat_071_001C5).l          ; 03852
        lea.l   h000+$3888(pc),a0               ; 0385A
        move.l  a0,(dat_002_00004).l            ; 0385E
        bra.b   l_000_03870                     ; 03864
l_000_03866:
        move.l  #sub_000_01D30,(dat_002_00004).l ; 03866
l_000_03870:
        movea.l (ConfigBuffer).l,a0             ; 03870
        move.w  $4(a0),d0                       ; 03876
        addq.w  #$1,d0                          ; 0387A
        movea.l (ConfigBuffer).l,a0             ; 0387C
        move.w  d0,$4(a0)                       ; 03882
        rts                                     ; 03886
        move.b  (dat_071_001B0).l,d0            ; 03888
        tst.b   d0                              ; 0388E
        bpl.b   l_000_038AA                     ; 03890
        jsr     (sub_000_03462).l               ; 03892
        move.w  #$5,(dat_071_004A6).l           ; 03898
        move.l  #sub_000_01D30,(dat_002_00004).l ; 038A0
l_000_038AA:
        rts                                     ; 038AA
        move.w  (dat_071_004A6).l,d0            ; 038AC
        tst.w   d0                              ; 038B2
        bpl.b   l_000_038C8                     ; 038B4
        clr.w   (FrameCount).l                  ; 038B6
        move.l  #sub_000_02EFE,(dat_002_00004).l ; 038BC
        bra.b   l_000_038D6                     ; 038C6
l_000_038C8:
        move.b  #$1,(dat_071_00165).l           ; 038C8
        jsr     (sub_000_03462).l               ; 038D0
l_000_038D6:
        rts                                     ; 038D6
sub_000_038D8:
        move.b  (dat_071_00155).l,d0            ; 038D8
        tst.b   d0                              ; 038DE
        bne.b   l_000_038EC                     ; 038E0
        move.b  (dat_071_00269).l,d0            ; 038E2
        tst.b   d0                              ; 038E8
        beq.b   l_000_03902                     ; 038EA
l_000_038EC:
        tst.b   (dat_071_00155).l               ; 038EC
        beq.w   l_000_0397E                     ; 038F2
        move.w  (ObjectTable).l,d0              ; 038F6
        btst    #$a,d0                          ; 038FC
        bne.b   l_000_0397E                     ; 03900
l_000_03902:
        move.w  (dat_071_0029C).l,d0            ; 03902
        andi.w  #$9fff,d0                       ; 03908
        move.w  d0,(dat_071_0029C).l            ; 0390C
        andi.w  #$fffe,d0                       ; 03912
        move.w  d0,(dat_071_0029C).l            ; 03916
        jsr     (sub_004_003E8).l               ; 0391C
        move.b  #$f,(dat_071_00271).l           ; 03922
        moveq   #$0,d0                          ; 0392A
        move.b  d0,(dat_071_00259).l            ; 0392C
        move.w  (dat_071_002A4).l,d0            ; 03932
        andi.w  #$fbff,d0                       ; 03938
        move.w  d0,(dat_071_002A4).l            ; 0393C
        move.b  (dat_071_00267).l,d0            ; 03942
        subq.b  #$1,d0                          ; 03948
        move.b  d0,(dat_071_00267).l            ; 0394A
        tst.b   d0                              ; 03950
        bgt.b   l_000_03974                     ; 03952
        jsr     (sub_036_00892).l               ; 03954
        move.w  #$5,(dat_071_004A6).l           ; 0395A
        clr.b   (dat_071_00165).l               ; 03962
        lea.l   dat_000_039F0(pc),a0            ; 03968
        move.l  a0,(dat_002_00004).l            ; 0396C
        bra.b   l_000_0397E                     ; 03972
l_000_03974:
        lea.l   dat_000_03980(pc),a0            ; 03974
        move.l  a0,(dat_002_00004).l            ; 03978
l_000_0397E:
        rts                                     ; 0397E
dat_000_03980:
	dc.b	$70,$00,$13,$C0
        dc.l    dat_071_0026A                   ; 03984
	dc.b	$30,$39
        dc.l    Player_02                       ; 0398A
	dc.b	$00,$40,$00,$02,$33,$C0
        dc.l    Player_02                       ; 03994
	dc.b	$10,$39
        dc.l    dat_071_00155                   ; 0399A
	dc.b	$4A,$00,$66,$06,$4E,$B9
        dc.l    sub_005_00CEE                   ; 039A4
	dc.b	$4E,$B9
        dc.l    sub_004_003E8                   ; 039AA
	dc.b	$33,$FC,$00,$05
        dc.l    dat_071_004A6                   ; 039B2
	dc.b	$41,$FA,$00,$0A,$23,$C8
        dc.l    dat_002_00004                   ; 039BC
	dc.b	$4E,$75,$30,$39
        dc.l    dat_071_004A6                   ; 039C4
	dc.b	'J@j"09'
        dc.l    dat_071_0029C                   ; 039CE
	dc.b	$00,$40,$00,$40,$33,$C0
        dc.l    dat_071_0029C                   ; 039D8
	dc.b	$13,$FC,$00,$FE
        dc.l    dat_071_00280                   ; 039E0
	dc.b	$23,$FC
        dc.l    sub_000_02EFE                   ; 039E6
        dc.l    dat_002_00004                   ; 039EA
	dc.b	$4E,$75
dat_000_039F0:
	dc.b	$30,$39
        dc.l    dat_071_004A6                   ; 039F2
	dc.b	'J@j:Hy'
        dc.l    dat_021_00000                   ; 039FC
	dc.b	$61,$00,$02,$1A,$58,$8F,$10,$39
        dc.l    dat_071_00219                   ; 03A08
	dc.b	$0C,$00,$00,$10,$66,$0A,$33,$FC,$00,$62
        dc.l    dat_071_0011A                   ; 03A16
	dc.b	$60,$08,$33,$FC,$00,$63
        dc.l    dat_071_0011A                   ; 03A20
	dc.b	$42,$39
        dc.l    dat_071_001FB                   ; 03A26
	dc.b	$41,$FA,$00,$0A,$23,$C8
        dc.l    dat_002_00004                   ; 03A30
	dc.b	$4E,$75,$10,$39
        dc.l    dat_071_001B0                   ; 03A38
	dc.b	$4A,$00,$6A,$0A,$23,$FC
        dc.l    sub_000_01A70                   ; 03A42
        dc.l    dat_002_00004                   ; 03A46
	dc.b	$4E,$75
sub_000_03A4C:
        move.b  (dat_071_001B0).l,d0            ; 03A4C
        tst.b   d0                              ; 03A52
        bpl.b   l_000_03A82                     ; 03A54
        move.w  (dat_071_0029C).l,d0            ; 03A56
        andi.w  #$ffbf,d0                       ; 03A5C
        move.w  d0,(dat_071_0029C).l            ; 03A60
        andi.w  #$9fff,d0                       ; 03A66
        move.w  d0,(dat_071_0029C).l            ; 03A6A
        move.w  #$64,(dat_071_004A6).l          ; 03A70
        lea.l   sub_000_03A84(pc),a0            ; 03A78
        move.l  a0,(dat_002_00004).l            ; 03A7C
l_000_03A82:
        rts                                     ; 03A82
sub_000_03A84:
        move.w  (dat_071_004A6).l,d0            ; 03A84
        tst.w   d0                              ; 03A8A
        bpl.b   l_000_03AA6                     ; 03A8C
        moveq   #$0,d0                          ; 03A8E
        move.b  d0,(dat_071_001FA).l            ; 03A90
        move.b  d0,(dat_071_00168).l            ; 03A96
        move.l  #sub_000_01A70,(dat_002_00004).l ; 03A9C
l_000_03AA6:
        rts                                     ; 03AA6
sub_000_03AA8:
        move.b  (dat_071_001B0).l,d0            ; 03AA8
        tst.b   d0                              ; 03AAE
        bpl.b   l_000_03AE0                     ; 03AB0
        move.w  (dat_071_0029C).l,d0            ; 03AB2
        andi.w  #$ffbf,d0                       ; 03AB8
        move.w  d0,(dat_071_0029C).l            ; 03ABC
        andi.w  #$9fff,d0                       ; 03AC2
        move.w  d0,(dat_071_0029C).l            ; 03AC6
        move.w  #$64,(dat_071_004A6).l          ; 03ACC
        lea.l   sub_000_03B24(pc),a0            ; 03AD4
        move.l  a0,(dat_002_00004).l            ; 03AD8
        bra.b   l_000_03B22                     ; 03ADE
l_000_03AE0:
        move.b  (dat_071_001FA).l,d0            ; 03AE0
        cmpi.b  #$ff,d0                         ; 03AE6
        bne.b   l_000_03B06                     ; 03AEA
        moveq   #$0,d0                          ; 03AEC
        move.b  d0,(dat_071_001FA).l            ; 03AEE
        move.b  d0,(dat_071_001FB).l            ; 03AF4
        move.l  #sub_000_01A70,(dat_002_00004).l ; 03AFA
        bra.b   l_000_03B22                     ; 03B04
l_000_03B06:
        move.b  (dat_071_001FA).l,d0            ; 03B06
        subq.b  #$1,d0                          ; 03B0C
        bne.b   l_000_03B22                     ; 03B0E
        move.w  #$ffff,(dat_071_004A6).l        ; 03B10
        lea.l   sub_000_03B24(pc),a0            ; 03B18
        move.l  a0,(dat_002_00004).l            ; 03B1C
l_000_03B22:
        rts                                     ; 03B22
sub_000_03B24:
        move.w  (dat_071_004A6).l,d0            ; 03B24
        tst.w   d0                              ; 03B2A
        bpl.b   l_000_03B74                     ; 03B2C
        moveq   #$0,d0                          ; 03B2E
        move.b  d0,(dat_071_001FA).l            ; 03B30
        move.b  d0,(dat_071_00168).l            ; 03B36
        tst.b   (dat_071_0027C).l               ; 03B3C
        beq.b   l_000_03B4C                     ; 03B42
        move.b  #$1,(dat_071_001FB).l           ; 03B44
l_000_03B4C:
        move.b  #$1,(dat_071_0017E).l           ; 03B4C
        move.w  #$3,(dat_071_004A6).l           ; 03B54
        moveq   #$0,d0                          ; 03B5C
        move.b  d0,(dat_071_00165).l            ; 03B5E
        move.b  d0,(dat_071_00271).l            ; 03B64
        move.l  #sub_000_01A96,(dat_002_00004).l ; 03B6A
l_000_03B74:
        rts                                     ; 03B74
sub_000_03B76:
        clr.b   (dat_071_00165).l               ; 03B76
        move.b  (dat_071_00270).l,d0            ; 03B7C
        move.b  (dat_071_00271).l,d1            ; 03B82
        cmp.b   d1,d0                           ; 03B88
        bne.b   l_000_03B9E                     ; 03B8A
        move.w  #$26,(dat_071_0011A).l          ; 03B8C
        lea.l   sub_000_03BA0(pc),a0            ; 03B94
        move.l  a0,(dat_002_00004).l            ; 03B98
l_000_03B9E:
        rts                                     ; 03B9E
sub_000_03BA0:
        move.b  (dat_071_0017E).l,d0            ; 03BA0
        tst.b   d0                              ; 03BA6
        bmi.b   l_000_03C1A                     ; 03BA8
        move.b  #$1,(dat_071_00165).l           ; 03BAA
        jsr     (sub_000_03462).l               ; 03BB2
        move.b  #$f,(dat_071_00271).l           ; 03BB8
        move.b  (dat_071_0027E).l,d0            ; 03BC0
        subq.b  #$6,d0                          ; 03BC6
        bne.b   l_000_03BD6                     ; 03BC8
        move.l  #sub_000_02D58,(dat_002_00004).l ; 03BCA
        bra.b   l_000_03C1A                     ; 03BD4
l_000_03BD6:
        jsr     (ReadTime).l                    ; 03BD6
        move.l  (dat_071_002D4).l,d0            ; 03BDC
        move.l  (TimeSeconds).l,d1              ; 03BE2
        sub.l   d0,d1                           ; 03BE8
        move.l  d1,(dat_071_002D4).l            ; 03BEA
        add.l   d1,(dat_071_002D8).l            ; 03BF0
        tst.l   (dat_071_002DC).l               ; 03BF6
        beq.b   l_000_03C0A                     ; 03BFC
        move.l  (dat_071_002D4).l,d0            ; 03BFE
        add.l   d0,(dat_071_002DC).l            ; 03C04
l_000_03C0A:
        clr.l   (dat_071_002D4).l               ; 03C0A
        move.l  #sub_000_02EFE,(dat_002_00004).l ; 03C10
l_000_03C1A:
        rts                                     ; 03C1A
sub_000_03C1C:
        link.w  a6,#$fff6                       ; 03C1C
        move.l  $8(a6),-$6(a6)                  ; 03C20
        move.l  (dat_071_00030).l,-$a(a6)       ; 03C26
        clr.w   -$2(a6)                         ; 03C2E
l_000_03C32:
        cmpi.w  #$10,-$2(a6)                    ; 03C32
        bge.b   l_000_03C52                     ; 03C38
        movea.l -$6(a6),a0                      ; 03C3A
        movea.l -$a(a6),a1                      ; 03C3E
        move.l  (a0),(a1)                       ; 03C42
        addq.l  #$4,-$6(a6)                     ; 03C44
        addq.l  #$4,-$a(a6)                     ; 03C48
        addq.w  #$1,-$2(a6)                     ; 03C4C
        bra.b   l_000_03C32                     ; 03C50
l_000_03C52:
        move.b  #$2,(dat_071_00274).l           ; 03C52
        unlk    a6                              ; 03C5A
        rts                                     ; 03C5C
sub_000_03C5E:
        link.w  a6,#$fffa                       ; 03C5E
        move.b  #$2,(dat_071_00274).l           ; 03C62
        move.l  (dat_071_00030).l,-$6(a6)       ; 03C6A
        clr.w   -$2(a6)                         ; 03C72
l_000_03C76:
        cmpi.w  #$10,-$2(a6)                    ; 03C76
        bge.b   l_000_03C8E                     ; 03C7C
        movea.l -$6(a6),a0                      ; 03C7E
        clr.l   (a0)                            ; 03C82
        addq.l  #$4,-$6(a6)                     ; 03C84
        addq.w  #$1,-$2(a6)                     ; 03C88
        bra.b   l_000_03C76                     ; 03C8C
l_000_03C8E:
        unlk    a6                              ; 03C8E
        rts                                     ; 03C90
	dc.b	$00,$00
sub_000_03C94:
        move.b  (dat_071_00260).l,d0            ; 03C94
        subq.b  #$1,d0                          ; 03C9A
        move.b  d0,(dat_071_00260).l            ; 03C9C
        tst.b   d0                              ; 03CA2
        bgt.b   l_000_03CB8                     ; 03CA4
        move.b  #$8,(dat_071_00260).l           ; 03CA6
        move.b  #$86,(dat_071_0025E).l          ; 03CAE
        bra.b   l_000_03CFE                     ; 03CB6
l_000_03CB8:
        move.b  (dat_071_00260).l,d0            ; 03CB8
        subq.b  #$4,d0                          ; 03CBE
        bne.b   l_000_03CCC                     ; 03CC0
        move.b  #$6,(dat_071_0025E).l           ; 03CC2
        bra.b   l_000_03CFE                     ; 03CCA
l_000_03CCC:
        move.b  (dat_071_00260).l,d0            ; 03CCC
        andi.b  #$3,d0                          ; 03CD2
        subq.b  #$2,d0                          ; 03CD6
        bne.b   l_000_03CE4                     ; 03CD8
        move.b  #$4,(dat_071_0025E).l           ; 03CDA
        bra.b   l_000_03CFE                     ; 03CE2
l_000_03CE4:
        move.b  (dat_071_00260).l,d0            ; 03CE4
        cmpi.b  #$8,d0                          ; 03CEA
        ble.b   l_000_03CFE                     ; 03CEE
        move.b  #$8,(dat_071_00260).l           ; 03CF0
        clr.b   (dat_071_0025E).l               ; 03CF8
l_000_03CFE:
        rts                                     ; 03CFE
sub_000_03D00:
        link.w  a6,#$0                          ; 03D00
        move.w  (dat_071_0029C).l,d0            ; 03D04
        btst    #$8,d0                          ; 03D0A
        beq.b   l_000_03D48                     ; 03D0E
        move.w  $a(a6),d1                       ; 03D10
        move.w  d1,(dat_071_004B0).l            ; 03D14
        ori.w   #$1,d0                          ; 03D1A
        move.w  d0,(dat_071_0029C).l            ; 03D1E
        andi.w  #$ff00,d1                       ; 03D24
        move.w  d1,$a(a6)                       ; 03D28
        cmpi.w  #$4000,d1                       ; 03D2C
        beq.b   l_000_03D38                     ; 03D30
        cmpi.w  #$4800,d1                       ; 03D32
        bne.b   l_000_03D48                     ; 03D36
l_000_03D38:
        move.w  (dat_071_0029E).l,d0            ; 03D38
        andi.w  #$dfff,d0                       ; 03D3E
        move.w  d0,(dat_071_0029E).l            ; 03D42
l_000_03D48:
        unlk    a6                              ; 03D48
        rts                                     ; 03D4A
sub_000_03D4C:
        link.w  a6,#$fff4                       ; 03D4C
        clr.b   -$8(a6)                         ; 03D50
        move.w  (dat_071_004B0).l,d0            ; 03D54
        move.w  d0,-$4(a6)                      ; 03D5A
        andi.w  #$ff,d0                         ; 03D5E
        move.l  (WarningFlags).l,-$c(a6)        ; 03D62
        move.w  (dat_071_0029C).l,d1            ; 03D6A
        move.w  d0,-$6(a6)                      ; 03D70
        btst    #$0,d1                          ; 03D74
        bne.w   l_000_03ECC                     ; 03D78
        move.w  (dat_071_00298).l,d0            ; 03D7C
        andi.w  #$8000,d0                       ; 03D82
        tst.w   d0                              ; 03D86
        beq.b   l_000_03D94                     ; 03D88
        move.w  #$9c06,-$4(a6)                  ; 03D8A
        bra.w   l_000_03EEA                     ; 03D90
l_000_03D94:
        move.w  (dat_071_002A6).l,d0            ; 03D94
        btst    #$5,d0                          ; 03D9A
        beq.b   l_000_03DAA                     ; 03D9E
        move.w  #$4000,-$4(a6)                  ; 03DA0
        bra.w   l_000_03EEA                     ; 03DA6
l_000_03DAA:
        tst.l   -$c(a6)                         ; 03DAA
        bne.b   l_000_03DBA                     ; 03DAE
        tst.b   (dat_071_0023E).l               ; 03DB0
        beq.w   l_000_03EAA                     ; 03DB6
l_000_03DBA:
        move.w  (dat_071_0029C).l,d0            ; 03DBA
        ori.w   #$80,d0                         ; 03DC0
        move.w  d0,(dat_071_0029C).l            ; 03DC4
        move.b  (dat_071_0023E).l,d0            ; 03DCA
        btst    #$4,d0                          ; 03DD0
        beq.b   l_000_03DE0                     ; 03DD4
        move.w  #$8010,-$4(a6)                  ; 03DD6
        bra.w   l_000_03EEA                     ; 03DDC
l_000_03DE0:
        move.b  (dat_071_0023E).l,d0            ; 03DE0
        btst    #$5,d0                          ; 03DE6
        beq.b   l_000_03DF6                     ; 03DEA
        move.w  #$8012,-$4(a6)                  ; 03DEC
        bra.w   l_000_03EEA                     ; 03DF2
l_000_03DF6:
        btst    #$6,-$9(a6)                     ; 03DF6
        beq.b   l_000_03E08                     ; 03DFC
        move.w  #$c004,-$4(a6)                  ; 03DFE
        bra.w   l_000_03EEA                     ; 03E04
l_000_03E08:
        btst    #$7,-$9(a6)                     ; 03E08
        beq.b   l_000_03E1A                     ; 03E0E
        move.w  #$c001,-$4(a6)                  ; 03E10
        bra.w   l_000_03EEA                     ; 03E16
l_000_03E1A:
        btst    #$1,-$9(a6)                     ; 03E1A
        beq.b   l_000_03E2C                     ; 03E20
        move.w  #$8002,-$4(a6)                  ; 03E22
        bra.w   l_000_03EEA                     ; 03E28
l_000_03E2C:
        move.b  (dat_071_0023E).l,d0            ; 03E2C
        btst    #$3,d0                          ; 03E32
        beq.b   l_000_03E52                     ; 03E36
        move.w  (dat_071_0029C).l,d0            ; 03E38
        andi.w  #$ff7f,d0                       ; 03E3E
        move.w  d0,(dat_071_0029C).l            ; 03E42
        move.w  #$8024,-$4(a6)                  ; 03E48
        bra.w   l_000_03EEA                     ; 03E4E
l_000_03E52:
        move.b  (dat_071_0023E).l,d0            ; 03E52
        btst    #$2,d0                          ; 03E58
        beq.b   l_000_03E76                     ; 03E5C
        move.w  (dat_071_0029C).l,d0            ; 03E5E
        andi.w  #$ff7f,d0                       ; 03E64
        move.w  d0,(dat_071_0029C).l            ; 03E68
        move.w  #$800e,-$4(a6)                  ; 03E6E
        bra.b   l_000_03EEA                     ; 03E74
l_000_03E76:
        btst    #$0,-$9(a6)                     ; 03E76
        beq.b   l_000_03E86                     ; 03E7C
        move.w  #$c09,-$4(a6)                   ; 03E7E
        bra.b   l_000_03EEA                     ; 03E84
l_000_03E86:
        move.b  (dat_071_0023E).l,d0            ; 03E86
        btst    #$1,d0                          ; 03E8C
        beq.b   l_000_03EEA                     ; 03E90
        move.w  (dat_071_0029C).l,d0            ; 03E92
        andi.w  #$ff7f,d0                       ; 03E98
        move.w  d0,(dat_071_0029C).l            ; 03E9C
        move.w  #$400d,-$4(a6)                  ; 03EA2
        bra.b   l_000_03EEA                     ; 03EA8
l_000_03EAA:
        move.w  (dat_071_0029C).l,d0            ; 03EAA
        btst    #$2,d0                          ; 03EB0
        bne.b   l_000_03EBA                     ; 03EB4
        clr.w   -$4(a6)                         ; 03EB6
l_000_03EBA:
        move.w  (dat_071_0029C).l,d0            ; 03EBA
        andi.w  #$ff7f,d0                       ; 03EC0
        move.w  d0,(dat_071_0029C).l            ; 03EC4
        bra.b   l_000_03EEA                     ; 03ECA
l_000_03ECC:
        move.w  (dat_071_004B0).l,d0            ; 03ECC
        tst.w   d0                              ; 03ED2
        bne.b   l_000_03EEA                     ; 03ED4
        move.w  (dat_071_0029C).l,d0            ; 03ED6
        andi.w  #$fffe,d0                       ; 03EDC
        move.w  d0,(dat_071_0029C).l            ; 03EE0
        clr.w   -$4(a6)                         ; 03EE6
l_000_03EEA:
        move.w  (dat_071_004B2).l,d0            ; 03EEA
        andi.w  #$ff,d0                         ; 03EF0
        move.w  -$4(a6),d1                      ; 03EF4
        andi.w  #$ff,d1                         ; 03EF8
        cmp.w   d1,d0                           ; 03EFC
        beq.w   l_000_03F8C                     ; 03EFE
        move.w  -$4(a6),d0                      ; 03F02
        move.w  d0,(dat_071_004B0).l            ; 03F06
        move.w  d0,(dat_071_004B2).l            ; 03F0C
        move.w  (dat_071_0029E).l,d0            ; 03F12
        andi.w  #$dfff,d0                       ; 03F18
        move.w  d0,(dat_071_0029E).l            ; 03F1C
        move.w  (dat_071_0029C).l,d0            ; 03F22
        andi.w  #$fffb,d0                       ; 03F28
        move.w  d0,(dat_071_0029C).l            ; 03F2C
        move.w  (dat_071_004B0).l,d0            ; 03F32
        andi.w  #$ff,d0                         ; 03F38
        move.w  d0,-$2(a6)                      ; 03F3C
        asl.w   #$4,d0                          ; 03F40
        move.w  -$2(a6),d1                      ; 03F42
        asl.w   #$3,d1                          ; 03F46
        add.w   d1,d0                           ; 03F48
        move.w  -$2(a6),d1                      ; 03F4A
        asl.w   #$2,d1                          ; 03F4E
        add.w   d1,d0                           ; 03F50
        move.w  d0,-$2(a6)                      ; 03F52
        ext.l   d0                              ; 03F56
        movea.l d0,a0                           ; 03F58
        adda.l  #dat_059_00000,a0               ; 03F5A
        move.b  (a0),d1                         ; 03F60
        move.b  d1,(dat_071_00232).l            ; 03F62
        addi.l  #$1b,d0                         ; 03F68
        movea.l d0,a0                           ; 03F6E
        adda.l  #dat_059_00000,a0               ; 03F70
        move.b  (a0),(dat_071_00233).l          ; 03F76
        move.b  (dat_071_00232).l,d0            ; 03F7C
        andi.b  #$3f,d0                         ; 03F82
        move.b  d0,(dat_071_00263).l            ; 03F86
l_000_03F8C:
        move.w  (dat_071_004B0).l,d0            ; 03F8C
        andi.w  #$8000,d0                       ; 03F92
        tst.w   d0                              ; 03F96
        beq.w   l_000_040F8                     ; 03F98
        move.w  (dat_071_0029E).l,d0            ; 03F9C
        btst    #$d,d0                          ; 03FA2
        bne.b   l_000_03FD4                     ; 03FA6
        ori.w   #$2000,d0                       ; 03FA8
        move.w  d0,(dat_071_0029E).l            ; 03FAC
        move.w  (dat_071_002A6).l,d0            ; 03FB2
        btst    #$5,d0                          ; 03FB8
        bne.b   l_000_03FCA                     ; 03FBC
        move.b  (dat_071_00263).l,(dat_071_00262).l ; 03FBE
        bra.b   l_000_03FD4                     ; 03FC8
l_000_03FCA:
        move.b  (dat_071_00544).l,(dat_071_00262).l ; 03FCA
l_000_03FD4:
        move.w  (dat_071_004B0).l,d0            ; 03FD4
        btst    #$c,d0                          ; 03FDA
        beq.b   l_000_03FE8                     ; 03FDE
        move.b  #$4,-$7(a6)                     ; 03FE0
        bra.b   l_000_03FEE                     ; 03FE6
l_000_03FE8:
        move.b  #$2,-$7(a6)                     ; 03FE8
l_000_03FEE:
        move.b  (dat_071_0025E).l,d0            ; 03FEE
        and.b   -$7(a6),d0                      ; 03FF4
        tst.b   d0                              ; 03FF8
        beq.w   l_000_041B6                     ; 03FFA
        move.w  (dat_071_0029E).l,d0            ; 03FFE
        btst    #$5,d0                          ; 04004
        beq.b   l_000_04060                     ; 04008
        move.b  (dat_071_0017E).l,d0            ; 0400A
        tst.b   d0                              ; 04010
        bne.b   l_000_04060                     ; 04012
        move.w  (dat_071_0029E).l,d0            ; 04014
        andi.w  #$ffdf,d0                       ; 0401A
        move.w  d0,(dat_071_0029E).l            ; 0401E
        move.w  (dat_071_004B0).l,d0            ; 04024
        andi.w  #$c000,d0                       ; 0402A
        cmpi.w  #$c000,d0                       ; 0402E
        bne.b   l_000_0403C                     ; 04032
        clr.w   (dat_071_004AE).l               ; 04034
        bra.b   l_000_0404A                     ; 0403A
l_000_0403C:
        move.w  (dat_071_004B0).l,d0            ; 0403C
        addq.w  #$1,d0                          ; 04042
        move.w  d0,(dat_071_004AE).l            ; 04044
l_000_0404A:
        tst.b   (dat_071_00233).l               ; 0404A
        beq.w   l_000_041B6                     ; 04050
        bset    #$3,(dat_071_00527).l           ; 04054
        bra.w   l_000_041B6                     ; 0405C
l_000_04060:
        move.w  (dat_071_0029E).l,d0            ; 04060
        ori.w   #$20,d0                         ; 04066
        move.w  d0,(dat_071_0029E).l            ; 0406A
        move.w  (dat_071_004B0).l,(dat_071_004AE).l ; 04070
        tst.b   (dat_071_00233).l               ; 0407A
        beq.b   l_000_0408A                     ; 04080
        bset    #$2,(dat_071_00527).l           ; 04082
l_000_0408A:
        tst.b   (dat_071_00263).l               ; 0408A
        beq.w   l_000_041B6                     ; 04090
        move.b  (dat_071_00262).l,d0            ; 04094
        subq.b  #$1,d0                          ; 0409A
        move.b  d0,(dat_071_00262).l            ; 0409C
        tst.b   d0                              ; 040A2
        bpl.w   l_000_041B6                     ; 040A4
        move.w  (dat_071_004AE).l,d0            ; 040A8
        andi.w  #$ff,d0                         ; 040AE
        move.w  d0,(dat_071_004AE).l            ; 040B2
        move.w  d0,(dat_071_004B2).l            ; 040B8
        move.w  d0,(dat_071_004B0).l            ; 040BE
        move.w  (dat_071_0029E).l,d0            ; 040C4
        andi.w  #$dfff,d0                       ; 040CA
        move.w  d0,(dat_071_0029E).l            ; 040CE
        move.w  (dat_071_002A6).l,d0            ; 040D4
        andi.w  #$ffdf,d0                       ; 040DA
        move.w  d0,(dat_071_002A6).l            ; 040DE
        move.w  (dat_071_0029C).l,d0            ; 040E4
        andi.w  #$fffe,d0                       ; 040EA
        move.w  d0,(dat_071_0029C).l            ; 040EE
        bra.w   l_000_041B6                     ; 040F4
l_000_040F8:
        move.w  (dat_071_004B0).l,d0            ; 040F8
        btst    #$e,d0                          ; 040FE
        beq.w   l_000_041AC                     ; 04102
        move.w  (dat_071_0029E).l,d0            ; 04106
        btst    #$d,d0                          ; 0410C
        bne.b   l_000_0414E                     ; 04110
        move.w  (dat_071_0029E).l,d0            ; 04112
        ori.w   #$2000,d0                       ; 04118
        move.w  d0,(dat_071_0029E).l            ; 0411C
        move.w  (dat_071_002A6).l,d0            ; 04122
        btst    #$5,d0                          ; 04128
        bne.b   l_000_0413A                     ; 0412C
        move.b  (dat_071_00263).l,(dat_071_00262).l ; 0412E
        bra.b   l_000_04144                     ; 04138
l_000_0413A:
        move.b  (dat_071_00544).l,(dat_071_00262).l ; 0413A
l_000_04144:
        move.w  (dat_071_004B0).l,(dat_071_004AE).l ; 04144
l_000_0414E:
        move.b  (dat_071_0025E).l,d0            ; 0414E
        btst    #$1,d0                          ; 04154
        beq.b   l_000_041B6                     ; 04158
        move.b  (dat_071_00262).l,d0            ; 0415A
        subq.b  #$1,d0                          ; 04160
        move.b  d0,(dat_071_00262).l            ; 04162
        tst.b   d0                              ; 04168
        bpl.b   l_000_041B6                     ; 0416A
        moveq   #$0,d0                          ; 0416C
        move.w  d0,(dat_071_004B0).l            ; 0416E
        move.w  d0,(dat_071_004AE).l            ; 04174
        move.w  (dat_071_0029E).l,d0            ; 0417A
        andi.w  #$dfff,d0                       ; 04180
        move.w  d0,(dat_071_0029E).l            ; 04184
        move.w  (dat_071_002A6).l,d0            ; 0418A
        andi.w  #$ffdf,d0                       ; 04190
        move.w  d0,(dat_071_002A6).l            ; 04194
        move.w  (dat_071_0029C).l,d0            ; 0419A
        andi.w  #$fffe,d0                       ; 041A0
        move.w  d0,(dat_071_0029C).l            ; 041A4
        bra.b   l_000_041B6                     ; 041AA
l_000_041AC:
        move.w  (dat_071_004B0).l,(dat_071_004AE).l ; 041AC
l_000_041B6:
        move.b  (dat_071_00232).l,d0            ; 041B6
        andi.b  #$c0,d0                         ; 041BC
        move.b  d0,(dat_071_00232).l            ; 041C0
        move.b  (dat_071_00230).l,d1            ; 041C6
        cmp.b   d0,d1                           ; 041CC
        beq.b   l_000_041DE                     ; 041CE
        move.b  d0,(dat_071_00230).l            ; 041D0
        move.b  #$2,(dat_071_00231).l           ; 041D6
l_000_041DE:
        clr.b   (dat_071_0025E).l               ; 041DE
        unlk    a6                              ; 041E4
        rts                                     ; 041E6
sub_000_041E8:
        link.w  a6,#$fffe                       ; 041E8
        move.b  (dat_071_00155).l,d0            ; 041EC
        tst.b   d0                              ; 041F2
        bne.b   l_000_04206                     ; 041F4
        move.b  (dat_071_00261).l,d0            ; 041F6
        tst.b   d0                              ; 041FC
        bne.b   l_000_04206                     ; 041FE
        jsr     (sub_005_00CEE).l               ; 04200
l_000_04206:
        move.w  (dat_071_002AC).l,d0            ; 04206
        moveq   #$9,d1                          ; 0420C
        ext.l   d0                              ; 0420E
        asl.l   d1,d0                           ; 04210
        movea.l d0,a0                           ; 04212
        adda.l  #ObjectTable,a0                 ; 04214
        move.b  $62(a0),d0                      ; 0421A
        andi.b  #$f0,d0                         ; 0421E
        move.w  (GunFlags).l,d1                 ; 04222
        move.b  d0,-$1(a6)                      ; 04228
        btst    #$1,d1                          ; 0422C
        beq.w   l_000_042EC                     ; 04230
        andi.w  #$fffd,d1                       ; 04234
        move.w  d1,(GunFlags).l                 ; 04238
        move.b  #$fe,(dat_071_00280).l          ; 0423E
        tst.b   (dat_071_00155).l               ; 04246
        beq.b   l_000_0426C                     ; 0424C
        moveq   #$0,d0                          ; 0424E
        move.b  d0,(dat_071_00155).l            ; 04250
        clr.w   (dat_071_00356).l               ; 04256
        move.b  d0,(dat_071_00176).l            ; 0425C
        move.b  #$1,(dat_071_00205).l           ; 04262
        bra.b   l_000_0427E                     ; 0426A
l_000_0426C:
        move.b  (dat_071_00203).l,(dat_071_00155).l ; 0426C
        move.w  #$32,(dat_071_00356).l          ; 04276
l_000_0427E:
        moveq   #$3,d0                          ; 0427E
        move.l  d0,-(a7)                        ; 04280
        jsr     (StopSound).l                   ; 04282
        addq.l  #$4,a7                          ; 04288
        cmpi.b  #$30,-$1(a6)                    ; 0428A
        bne.b   l_000_0429A                     ; 04290
        move.w  #$32,(dat_071_00356).l          ; 04292
l_000_0429A:
        move.w  (dat_071_00356).l,d0            ; 0429A
        asl.w   #$4,d0                          ; 042A0
        move.w  d0,(ViewX).l                    ; 042A2
        jsr     (StartGunSound).l               ; 042A8
        clr.b   (dat_071_00177).l               ; 042AE
        move.b  #$ff,(RedrawFlags).l            ; 042B4
        jsr     (sub_005_00E6E).l               ; 042BC
        cmpi.b  #$30,-$1(a6)                    ; 042C2
        beq.b   l_000_042D2                     ; 042C8
        tst.b   (dat_071_00155).l               ; 042CA
        beq.b   l_000_042EC                     ; 042D0
l_000_042D2:
        tst.b   (dat_071_0017D).l               ; 042D2
        beq.b   l_000_042E4                     ; 042D8
        move.w  #$b3,(ClipY).l                  ; 042DA
        bra.b   l_000_042EC                     ; 042E2
l_000_042E4:
        move.w  #$a7,(ClipY).l                  ; 042E4
l_000_042EC:
        cmpi.b  #$30,-$1(a6)                    ; 042EC
        bne.b   l_000_04330                     ; 042F2
        move.w  (dat_071_00356).l,d0            ; 042F4
        tst.w   d0                              ; 042FA
        bne.b   l_000_04330                     ; 042FC
        move.w  #$32,(dat_071_00356).l          ; 042FE
        move.w  #$320,(ViewX).l                 ; 04306
        jsr     (StartGunSound).l               ; 0430E
        clr.b   (dat_071_00177).l               ; 04314
        move.b  #$ff,(RedrawFlags).l            ; 0431A
        jsr     (sub_005_00E6E).l               ; 04322
        move.w  #$a7,(ClipY).l                  ; 04328
l_000_04330:
        tst.b   (dat_071_00155).l               ; 04330
        beq.b   l_000_0438E                     ; 04336
        move.w  (GunFlags).l,d0                 ; 04338
        btst    #$4,d0                          ; 0433E
        beq.b   l_000_0435E                     ; 04342
        andi.w  #$ffef,d0                       ; 04344
        move.w  d0,(GunFlags).l                 ; 04348
        move.b  (dat_071_0017C).l,d0            ; 0434E
        eori.b  #$1,d0                          ; 04354
        move.b  d0,(dat_071_0017C).l            ; 04358
l_000_0435E:
        move.b  (dat_071_0027E).l,d0            ; 0435E
        subq.b  #$6,d0                          ; 04364
        bne.b   l_000_0438E                     ; 04366
        cmpi.l  #$24000,(CameraY).l             ; 04368
        bge.b   l_000_0438E                     ; 04372
        move.w  (ClipY).l,d0                    ; 04374
        cmpi.w  #$a7,d0                         ; 0437A
        beq.b   l_000_0438E                     ; 0437E
        move.w  #$a7,(ClipY).l                  ; 04380
        jsr     (RedrawInstruments).l           ; 04388
l_000_0438E:
        unlk    a6                              ; 0438E
        rts                                     ; 04390
