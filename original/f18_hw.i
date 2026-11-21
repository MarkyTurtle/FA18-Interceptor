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
AUD0LCH     equ	$0A0	; the audio channels' registers (16 bytes each: ac_...)
AUD1LCH     equ	$0B0
AUD2LCH     equ	$0C0
AUD3LCH     equ	$0D0

; an audio channel's registers (from AUDxLCH)
ac_ptr      equ	$0	; the sample's address
ac_len      equ	$4	; its length in words
ac_per      equ	$6	; the period
ac_vol      equ	$8	; the volume (0-64)

; DMACON / INTENA / INTREQ bits
DMAF_SETCLR equ	$8000
DMAF_MASTER equ	$0200
DMAF_AUD0   equ	$0001
DMAF_AUD1   equ	$0002
DMAF_AUD2   equ	$0004
DMAF_AUD3   equ	$0008
INTF_SETCLR equ	$8000
INTF_AUD0   equ	$0080
INTF_AUD1   equ	$0100
INTF_AUD2   equ	$0200
INTF_AUD3   equ	$0400
INTB_AUD0   equ	7
