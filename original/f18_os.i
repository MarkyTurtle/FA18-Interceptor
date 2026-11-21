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
; struct Node / Message / MsgPort (exec)
ln_Succ			equ	0
ln_Pred			equ	4
ln_Type			equ	8
ln_Pri			equ	9
ln_Name			equ	$A
mn_ReplyPort		equ	$E
mp_Flags		equ	$E
mp_SigBit		equ	$F
mp_SigTask		equ	$10
mp_MsgList		equ	$14
MP_SIZE			equ	$22
NT_MSGPORT		equ	4

; struct Interrupt (exec): a Node, then
is_Data			equ	$E
is_Code			equ	$12
NT_INTERRUPT		equ	2

; struct IOStdReq (exec)
io_Device		equ	$14
io_Unit			equ	$18
io_Command		equ	$1C
io_Flags		equ	$1E
io_Error		equ	$1F
io_Actual		equ	$20
io_Length		equ	$24
io_Data			equ	$28
io_Offset		equ	$2C
IOSTD_SIZE		equ	$30

; struct InputEvent (devices/inputevent)
ie_NextEvent		equ	0
ie_Class		equ	4
ie_SubClass		equ	5
ie_Code			equ	6
ie_Qualifier		equ	8
ie_X			equ	$A
ie_Y			equ	$C
ie_TimeStamp		equ	$E
IE_SIZE			equ	$16
IECODE_LBUTTON		equ	$68
IECODE_UP_PREFIX	equ	$80

; device commands
KBD_READEVENT		equ	9	; keyboard.device
GPD_READEVENT		equ	9	; gameport.device
GPD_ASKCTYPE		equ	10
GPD_SETCTYPE		equ	11
GPD_ASKTRIGGER		equ	12
GPD_SETTRIGGER		equ	13

; struct BitMap (graphics)
bm_BytesPerRow		equ	0
bm_Rows			equ	2
bm_Flags		equ	4
bm_Depth		equ	5
bm_Planes		equ	8
bm_SIZEOF		equ	$28

; struct FileInfoBlock (dos)
fib_Size		equ	$7C

; dos.library Open() modes
MODE_OLDFILE		equ	1005
MODE_NEWFILE		equ	1006

; dos.library Seek() modes
OFFSET_BEGINNING	equ	-1
OFFSET_CURRENT		equ	0
OFFSET_END		equ	1

; exec.library Alert() codes
AG_OpenLib		equ	$00030000
AO_DOSLib		equ	$00000007

; exec.library AllocMem() requirements
MEMF_PUBLIC		equ	1
MEMF_CHIP		equ	2
MEMF_FAST		equ	4
MEMF_CLEAR		equ	$10000

; Lattice C library: a stdio FILE (_iob holds 20)
iob_Ptr			equ	0	; the next character in the buffer
iob_RCnt			equ	4	; characters left to read in it
iob_WCnt			equ	8	; room left to write in it
iob_Base			equ	$C	; the buffer
iob_Flag			equ	$10	; (byte) bit 0 reading, 1 writing, 2 unbuffered, 4 EOF, 5 error...
iob_File			equ	$11	; (byte) the low-level file number
iob_Size			equ	$12	; the buffer's size
FILE_SIZE		equ	$18

; Lattice C library: a low-level file (_ufbs holds _nufbs)
ufb_Flags		equ	0	; (byte) 0 = free; bit 2: not to be closed, bit 3: append
ufb_Handle		equ	2	; the AmigaDOS file handle
UFB_SIZE		equ	6
