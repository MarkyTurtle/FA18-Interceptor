; F/A-18 Interceptor - hunk 1 (data)
; Initialised data: the C library's variables (_SysBase, _DOSBase...), the library and file
; names, the code-check tables.
; Included by ../f18_main.s.

;===============================================================================
; Hunk 1: DATA, $36C bytes
;===============================================================================
	DATA_HUNK	h001
	dc.b	$00,$00,$00,$00
; _StackSize - The stack size.
_StackSize:
	dc.b	$00,$00,$00,$00
; RbrkData1 - Data used by rbrk.
RbrkData1:
	dc.b	$00,$00,$00,$00
; RbrkData2 - Data used by rbrk.
RbrkData2:
	dc.b	$00,$00,$00,$00
; RbrkData3 - Data used by rbrk.
RbrkData3:
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
; StrGraphicsLibrary - "graphics.library"
StrGraphicsLibrary:
	dc.b	'graphics.library'
	dc.b	$00
; StrPixSplsh - "df0:pix/splsh"
StrPixSplsh:
	dc.b	'df0:pix/splsh'
	dc.b	$00
; StrPixInst5 - "df0:pix/inst5"
StrPixInst5:
	dc.b	'df0:pix/inst5'
	dc.b	$00
; StrPixFrnt5 - "df0:pix/frnt5"
StrPixFrnt5:
	dc.b	'df0:pix/frnt5'
	dc.b	$00
; StrIntuitionLibrary - "intuition.library"
StrIntuitionLibrary:
	dc.b	'intuition.library'
	dc.b	$00,$00,$00,$00
; CheckDiskData1 - Data used by CheckDisk.
CheckDiskData1:
	dc.b	$64,$66,$30,$3A,$00,$00,$00,$00
; StrInputDevice - "input.device"
StrInputDevice:
	dc.b	'input.device'
	dc.b	$00,$00,$00,$00
; StrGraphicsLibrary2 - "graphics.library"
StrGraphicsLibrary2:
	dc.b	'graphics.library'
	dc.b	$00,$00,$00,$00
; ConfigOnDisk - 1 when df0:config was read or written.
ConfigOnDisk:
	dc.b	$00,$00
; StrConfig - "df0:config"
StrConfig:
	dc.b	'df0:config'
	dc.b	$00
; StrConfig2 - "df0:config"
StrConfig2:
	dc.b	'df0:config'
	dc.b	$00
; StrConfig3 - "df0:config"
StrConfig3:
	dc.b	'df0:config'
	dc.b	$00
; StrTextTextply - "df0:text/textply"
StrTextTextply:
	dc.b	'df0:text/textply'
	dc.b	$00
; StrTextTextply2 - "df0:text/textply"
StrTextTextply2:
	dc.b	'df0:text/textply'
	dc.b	$00
; StrTextTextctl - "df0:text/textctl"
StrTextTextctl:
	dc.b	'df0:text/textctl'
	dc.b	$00
; StrTextTextctl2 - "df0:text/textctl"
StrTextTextctl2:
	dc.b	'df0:text/textctl'
	dc.b	$00
; StrTextTextply3 - "df0:text/textply"
StrTextTextply3:
	dc.b	'df0:text/textply'
	dc.b	$00
; StrTextTextctl3 - "df0:text/textctl"
StrTextTextctl3:
	dc.b	'df0:text/textctl'
	dc.b	$00
; StrTextTextply4 - "df0:text/textply"
StrTextTextply4:
	dc.b	'df0:text/textply'
	dc.b	$00
; StrTextTextctl4 - "df0:text/textctl"
StrTextTextctl4:
	dc.b	'df0:text/textctl'
	dc.b	$00,$00
; CodeCheckData1 - Data used by CodeCheck, CodeHash.
CodeCheckData1:
	dc.b	$00,$00,$00,$04,$00,$12,$00,$17,$00,$25,$00,$31,$00,$33,$00,$46
	dc.b	$00,$54,$00,$62,$00,$66,$00,$70,$00,$83,$00,$85,$00,$91,$00,$97
; CodeCheckData2 - Data used by CodeCheck.
CodeCheckData2:
	dc.b	$00,$0D,$00,$07,$00,$00,$00,$02,$00,$06,$00,$09,$00,$0F,$00,$03
	dc.b	$00,$05,$00,$0C,$00,$0A,$00,$01,$00,$0E,$00,$08,$00,$04,$00,$0B
; CodeCheckData3 - Data used by CodeCheck.
CodeCheckData3:
	dc.b	$01,$FF,$0F,$FF,$7F,$FF,$FF,$FF
; KeyboardIOReq - The keyboard device's IO request (an IOStdReq, 48 bytes).
KeyboardIOReq:
	dcb.b	48,$00
; KeyboardIO - Points at KeyboardIOReq: the keyboard device's IO request.
KeyboardIO:
        dc.l    KeyboardIOReq                   ; 001FC
	dc.b	$00
	dc.b	$00
; KeyboardMsgPort - The keyboard request's reply port (a MsgPort, 34 bytes).
KeyboardMsgPort:
	dcb.b	34,$00
; KeyboardPort - Points at KeyboardMsgPort: the keyboard request's reply port (MakePort).
KeyboardPort:
        dc.l    KeyboardMsgPort                 ; 00224
; StrKeyboardDevice - "keyboard.device"
StrKeyboardDevice:
	dc.b	'keyboard.device'
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00
; KeyWaiting - Set when a key is waiting (PushKey; GetKey takes it).
KeyWaiting:
	dc.b	$00,$00,$50,$48,$4D,$4B
; StrTimerDevice - "timer.device"
StrTimerDevice:
	dc.b	'timer.device'
	dc.b	$00,$00,$00,$00,$00,$00
; StrGameportDevice - "gameport.device"
StrGameportDevice:
	dc.b	'gameport.device'
	dc.b	$00,$00,$00
; MouseMinX - The mouse's limits (with MouseMinY, MouseMaxX, MouseMaxY: SetMouseLimits).
MouseMinX:
	dc.b	$00,$00
; MouseMinY - See MouseMinX.
MouseMinY:
	dc.b	$00,$00
; MouseMaxX - See MouseMinX.
MouseMaxX:
	dc.b	$01,$3F
; MouseMaxY - See MouseMinX.
MouseMaxY:
	dc.b	$00,$C7
; MouseInterruptName - The mouse interrupt's name.
MouseInterruptName:
	dc.b	$76,$62,$00,$00
; StrTextText201 - "df0:text/text201"
StrTextText201:
	dc.b	'df0:text/text201'
	dc.b	$00
; StrTextTexti0a - "df0:text/texti0a"
StrTextTexti0a:
	dc.b	'df0:text/texti0a'
	dc.b	$00
; StrTextTexti0b - "df0:text/texti0b"
StrTextTexti0b:
	dc.b	'df0:text/texti0b'
	dc.b	$00
; StrTextTexti1 - "df0:text/texti1"
StrTextTexti1:
	dc.b	'df0:text/texti1'
	dc.b	$00
; StrTextTexti2 - "df0:text/texti2"
StrTextTexti2:
	dc.b	'df0:text/texti2'
	dc.b	$00
; StrTextTexti3 - "df0:text/texti3"
StrTextTexti3:
	dc.b	'df0:text/texti3'
	dc.b	$00
; StrTextTexti4 - "df0:text/texti4"
StrTextTexti4:
	dc.b	'df0:text/texti4'
	dc.b	$00
; StrTextTexti5 - "df0:text/texti5"
StrTextTexti5:
	dc.b	'df0:text/texti5'
	dc.b	$00
; StrTextTextegn - "df0:text/textegn"
StrTextTextegn:
	dc.b	'df0:text/textegn'
	dc.b	$00
; StrTextTextegn2 - "df0:text/textegn2"
StrTextTextegn2:
	dc.b	'df0:text/textegn2'
	dc.b	$00
; StrTextTexttre - "df0:text/texttre"
StrTextTexttre:
	dc.b	'df0:text/texttre'
	dc.b	$00
; StrTextTextger - "df0:text/textger"
StrTextTextger:
	dc.b	'df0:text/textger'
	dc.b	$00
; StrTextTextcpt - "df0:text/textcpt"
StrTextTextcpt:
	dc.b	'df0:text/textcpt'
	dc.b	$00
; StrTextTextwnd - "df0:text/textwnd"
StrTextTextwnd:
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
