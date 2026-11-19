; F/A-18 Interceptor - hunk 1 (data)
; Included by ../f18_main.s.

;===============================================================================
; Hunk 1: DATA, $36C bytes
;===============================================================================
	DATA_HUNK	h001
	dc.b	$00,$00,$00,$00
; _StackSize - The stack size.
_StackSize:
	dc.b	$00,$00,$00,$00
dat_001_00008:
	dc.b	$00,$00,$00,$00
dat_001_0000C:
	dc.b	$00,$00,$00,$00
dat_001_00010:
	dc.b	$00,$00,$00,$00
; _MSTEP - How much the heap grows by when malloc runs out.
_MSTEP:
	dc.b	$00,$00,$04
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; _OSERR - The last AmigaDOS error (IoErr).
_OSERR:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; _FPERR - The last floating-point error (SetFPErr).
_FPERR:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; _StartDir - The process's current directory at startup (pr_CurrentDir).
_StartDir:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; _ConsoleHandle - The console window opened by OpenConsole.
_ConsoleHandle:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; _SysBase - ExecBase.
_SysBase:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; _DOSBase - dos.library.
_DOSBase:
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00
; _WBenchMsg - The Workbench startup message (0 when started from the CLI).
_WBenchMsg:
	dc.b	$00,$00,$00,$00
; __savsp - The stack pointer at _start (XCEXIT returns through it).
__savsp:
	dc.b	$00,$00,$00,$00
; _ArgLen - The command line's length (d0 at _start).
_ArgLen:
	dc.b	$00,$00,$00,$00
; _ArgPtr - The command line (a0 at _start).
_ArgPtr:
	dc.b	$00,$00,$00,$00
; _WBConsole - From Workbench: the tool window's file handle, if the icon gives one.
_WBConsole:
	dc.b	$00,$00,$00,$00
; _ProgramName - The program's name (from the CLI structure).
_ProgramName:
	dc.b	$00,$00,$00,$00
s_dos_library:
	dc.b	'dos.library'
	dc.b	$00
dat_001_0005C:
	dc.b	'graphics.library'
	dc.b	$00
dat_001_0006D:
	dc.b	'df0:pix/splsh'
	dc.b	$00
dat_001_0007B:
	dc.b	'df0:pix/inst5'
	dc.b	$00
dat_001_00089:
	dc.b	'df0:pix/frnt5'
	dc.b	$00
dat_001_00097:
	dc.b	'intuition.library'
	dc.b	$00,$00,$00,$00
dat_001_000AC:
	dc.b	$64,$66,$30,$3A,$00,$00,$00,$00
dat_001_000B4:
	dc.b	'input.device'
	dc.b	$00,$00,$00,$00
dat_001_000C4:
	dc.b	'graphics.library'
	dc.b	$00,$00,$00,$00
; ConfigOnDisk - 1 when df0:config was read or written.
ConfigOnDisk:
	dc.b	$00,$00
dat_001_000DA:
	dc.b	'df0:config'
	dc.b	$00
dat_001_000E5:
	dc.b	'df0:config'
	dc.b	$00
dat_001_000F0:
	dc.b	'df0:config'
	dc.b	$00
dat_001_000FB:
	dc.b	'df0:text/textply'
	dc.b	$00
dat_001_0010C:
	dc.b	'df0:text/textply'
	dc.b	$00
dat_001_0011D:
	dc.b	'df0:text/textctl'
	dc.b	$00
dat_001_0012E:
	dc.b	'df0:text/textctl'
	dc.b	$00
dat_001_0013F:
	dc.b	'df0:text/textply'
	dc.b	$00
dat_001_00150:
	dc.b	'df0:text/textctl'
	dc.b	$00
dat_001_00161:
	dc.b	'df0:text/textply'
	dc.b	$00
dat_001_00172:
	dc.b	'df0:text/textctl'
	dc.b	$00,$00
dat_001_00184:
	dc.b	$00,$00,$00,$04,$00,$12,$00,$17,$00,$25,$00,$31,$00,$33,$00,$46
	dc.b	$00,$54,$00,$62,$00,$66,$00,$70,$00,$83,$00,$85,$00,$91,$00,$97
dat_001_001A4:
	dc.b	$00,$0D,$00,$07,$00,$00,$00,$02,$00,$06,$00,$09,$00,$0F,$00,$03
	dc.b	$00,$05,$00,$0C,$00,$0A,$00,$01,$00,$0E,$00,$08,$00,$04,$00,$0B
dat_001_001C4:
	dc.b	$01,$FF,$0F,$FF,$7F,$FF,$FF,$FF
dat_001_001CC:
	dcb.b	48,$00
dat_001_001FC:
        dc.l    dat_001_001CC                   ; 001FC
	dc.b	$00
	dc.b	$00
dat_001_00202:
	dcb.b	34,$00
dat_001_00224:
        dc.l    dat_001_00202                   ; 00224
dat_001_00228:
	dc.b	'keyboard.device'
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00
dat_001_0024A:
	dc.b	$00,$00,$50,$48,$4D,$4B
dat_001_00250:
	dc.b	'timer.device'
	dc.b	$00,$00,$00,$00,$00,$00
dat_001_00262:
	dc.b	'gameport.device'
	dc.b	$00,$00,$00
dat_001_00274:
	dc.b	$00,$00
dat_001_00276:
	dc.b	$00,$00
dat_001_00278:
	dc.b	$01,$3F
dat_001_0027A:
	dc.b	$00,$C7
dat_001_0027C:
	dc.b	$76,$62,$00,$00
dat_001_00280:
	dc.b	'df0:text/text201'
	dc.b	$00
dat_001_00291:
	dc.b	'df0:text/texti0a'
	dc.b	$00
dat_001_002A2:
	dc.b	'df0:text/texti0b'
	dc.b	$00
dat_001_002B3:
	dc.b	'df0:text/texti1'
	dc.b	$00
dat_001_002C3:
	dc.b	'df0:text/texti2'
	dc.b	$00
dat_001_002D3:
	dc.b	'df0:text/texti3'
	dc.b	$00
dat_001_002E3:
	dc.b	'df0:text/texti4'
	dc.b	$00
dat_001_002F3:
	dc.b	'df0:text/texti5'
	dc.b	$00
dat_001_00303:
	dc.b	'df0:text/textegn'
	dc.b	$00
dat_001_00314:
	dc.b	'df0:text/textegn2'
	dc.b	$00
dat_001_00326:
	dc.b	'df0:text/texttre'
	dc.b	$00
dat_001_00337:
	dc.b	'df0:text/textger'
	dc.b	$00
dat_001_00348:
	dc.b	'df0:text/textcpt'
	dc.b	$00
dat_001_00359:
	dc.b	'df0:text/textwnd'
	dc.b	$00,$00,$00
h001_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    2,1                             ; 2 longs pointing into hunk 1
	dc.l	$224,$1FC
	dc.l	0
	dc.l	HUNK_END
	endc
