; Amiga hardware: the custom chip registers (offsets from CUSTOM) the program uses

CUSTOM		equ	$DFF000		; the custom chips

DMACONR     equ	$002
JOY0DAT     equ	$00A
POTGOR      equ	$016
BLTCON0     equ	$040
BLTCON1     equ	$042
BLTAFWM     equ	$044
BLTALWM     equ	$046
BLTCPTH     equ	$048
BLTBPTH     equ	$04C
BLTAPTH     equ	$050
BLTAPTL     equ	$052
BLTDPTH     equ	$054
BLTSIZE     equ	$058
BLTCMOD     equ	$060
BLTBMOD     equ	$062
BLTAMOD     equ	$064
BLTDMOD     equ	$066
BLTBDAT     equ	$072
BLTADAT     equ	$074
DMACON      equ	$096
INTENA      equ	$09A
INTREQ      equ	$09C
