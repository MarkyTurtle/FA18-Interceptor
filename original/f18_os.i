; F/A-18 Interceptor - the system library calls the program makes (library vector offsets,
; from a6 = the library base), and the system structure offsets it uses.

; exec.library
_LVOOpenLibrary         equ	-552
_LVOSendIO              equ	-462
_LVODoIO                equ	-456
_LVOCloseDevice         equ	-450
_LVOOpenDevice          equ	-444
_LVOCloseLibrary        equ	-414
_LVOWaitPort            equ	-384
_LVOReplyMsg            equ	-378
_LVOGetMsg              equ	-372
_LVORemPort             equ	-360
_LVOAddPort             equ	-354
_LVOFreeSignal          equ	-336
_LVOAllocSignal         equ	-330
_LVOSetSignal           equ	-306
_LVOSetTaskPri          equ	-300
_LVOFindTask            equ	-294
_LVOAvailMem            equ	-216
_LVOFreeMem             equ	-210
_LVOAllocMem            equ	-198
_LVORemIntServer        equ	-174
_LVOAddIntServer        equ	-168
_LVOForbid              equ	-132
_LVOAlert               equ	-108

; dos.library
_LVOIoErr               equ	-132
_LVOCurrentDir          equ	-126
_LVOInfo                equ	-114
_LVOExamine             equ	-102
_LVOUnLock              equ	-90
_LVOLock                equ	-84
_LVORename              equ	-78
_LVODeleteFile          equ	-72
_LVOSeek                equ	-66
_LVOOutput              equ	-60
_LVOInput               equ	-54
_LVOWrite               equ	-48
_LVORead                equ	-42
_LVOClose               equ	-36
_LVOOpen                equ	-30

; graphics.library
_LVOGetColorMap         equ	-570
_LVOFreeRaster          equ	-498
_LVODisownBlitter       equ	-462
_LVOOwnBlitter          equ	-456
_LVOFreeSprite          equ	-414
_LVOWaitBOVP            equ	-402
_LVOInitBitMap          equ	-390
_LVOInitView            equ	-360
_LVOWaitBlit            equ	-228
_LVOLoadView            equ	-222
_LVOMakeVPort           equ	-216
_LVOMrgCop              equ	-210
_LVOInitVPort           equ	-204
_LVOInitRastPort        equ	-198
_LVOLoadRGB4            equ	-192

; intuition.library
_LVOCloseWorkBench      equ	-78

; struct Process (exec/dos)
pr_MsgPort		equ	$5C
pr_CurrentDir		equ	$98
pr_CLI			equ	$AC
pr_ConsoleTask		equ	$A4
pr_WindowPtr		equ	$B8

; struct CommandLineInterface
cli_CommandName		equ	$10

; struct WBStartup / WBArg
sm_NumArgs		equ	$1C
sm_ToolWindow		equ	$20
sm_ArgList		equ	$24
wa_Lock			equ	0
; dos.library Open() modes
MODE_OLDFILE		equ	1005
MODE_NEWFILE		equ	1006

; exec.library Alert() codes
AG_OpenLib		equ	$00030000
AO_DOSLib		equ	$00000007

; exec.library AllocMem() requirements
MEMF_PUBLIC		equ	1
MEMF_CHIP		equ	2
MEMF_FAST		equ	4
MEMF_CLEAR		equ	$10000
