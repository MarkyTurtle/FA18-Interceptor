; F/A-18 Interceptor - hunk 74 (code)
; The sound driver's data: the four audio channels' descriptors.
; Included by ../f18_main.s.

;===============================================================================
; Hunk 74: CODE, $104 bytes
;===============================================================================
	CODE_HUNK	h074
; AudioChannels - The four channels' descriptors (AUD0-AUD3): the channel's registers
; ($DFF0A0...), the playing sound's variable, its exec Interrupt, its interrupt number (7-10),
; DMACON on/off bits, INTENA/INTREQ bits, the old handler.
AudioChannels:
        dc.l    AudioChannelsData1              ; 00000
        dc.l    AudioChannelsData2              ; 00004
        dc.l    AudioChannelsData3              ; 00008
        dc.l    AudioChannelsData4              ; 0000C
; ChannelSound - The sound each audio channel is playing (4 longs; 0 = none).
ChannelSound:
	dc.b	$00,$00,$00,$00
; EnginePitchData1 - Data used by EnginePitch, AudioChannelsData2.
EnginePitchData1:
	dc.b	$00,$00,$00,$00
; Hunk074Data1 - Data used by AudioChannelsData3.
Hunk074Data1:
	dc.b	$00,$00,$00,$00
; Hunk074Data2 - Data used by AudioChannelsData4.
Hunk074Data2:
	dc.b	$00,$00,$00,$00
; AudioChannelsData1 - Data used by AudioChannels, Hunk074Data3.
AudioChannelsData1:
	dc.b	$00,$DF,$F0,$A0
        dc.l    ChannelSound                    ; 00024
        dc.l    Hunk074Data3                    ; 00028
	dc.b	$00,$00,$00,$07,$82,$01,$00,$01,$80,$80,$00,$80,$00,$00,$00,$00
; AudioChannelsData2 - Data used by AudioChannels, Hunk074Data4.
AudioChannelsData2:
	dc.b	$00,$DF,$F0,$B0
        dc.l    EnginePitchData1                ; 00040
        dc.l    Hunk074Data4                    ; 00044
	dc.b	$00,$00,$00,$08,$82,$02,$00,$02,$81,$00,$01,$00,$00,$00,$00,$00
; AudioChannelsData3 - Data used by AudioChannels, Hunk074Data5.
AudioChannelsData3:
	dc.b	$00,$DF,$F0,$C0
        dc.l    Hunk074Data1                    ; 0005C
        dc.l    Hunk074Data5                    ; 00060
	dc.b	$00,$00,$00,$09,$82,$04,$00,$04,$82,$00,$02,$00,$00,$00,$00,$00
; AudioChannelsData4 - Data used by AudioChannels, Hunk074Data6.
AudioChannelsData4:
	dc.b	$00,$DF,$F0,$D0
        dc.l    Hunk074Data2                    ; 00078
        dc.l    Hunk074Data6                    ; 0007C
	dc.b	$00,$00,$00,$0A,$82,$08,$00,$08,$84,$00,$04,$00,$00,$00,$00,$00
; Hunk074Data3 - Data used by AudioChannelsData1.
Hunk074Data3:
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$02,$88,$00,$00,$00,$00
        dc.l    AudioChannelsData1              ; 0009E
        dc.l    AudioInterrupt                  ; 000A2
; Hunk074Data4 - Data used by AudioChannelsData2.
Hunk074Data4:
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$02,$88,$00,$00,$00,$00
        dc.l    AudioChannelsData2              ; 000B4
        dc.l    AudioInterrupt                  ; 000B8
; Hunk074Data5 - Data used by AudioChannelsData3.
Hunk074Data5:
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$02,$88,$00,$00,$00,$00
        dc.l    AudioChannelsData3              ; 000CA
        dc.l    AudioInterrupt                  ; 000CE
; Hunk074Data6 - Data used by AudioChannelsData4.
Hunk074Data6:
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$02,$88,$00,$00,$00,$00
        dc.l    AudioChannelsData4              ; 000E0
        dc.l    AudioInterrupt                  ; 000E4
; SoundVBlankNode - The sound driver's vertical-blank interrupt structure (AddSoundVBlank).
SoundVBlankNode:
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$02,$88,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00
        dc.l    AudioVBlank                     ; 000FA
; AudioPeriodMin - The shortest period allowed (AudioSetPeriod); the title music's timing reads
; it too.
AudioPeriodMin:
	dc.b	$00,$3F,$00,$00,$00,$00
h074_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    16,74                           ; 16 longs pointing into hunk 74
	dc.l	$E0,$CA,$B4,$9E,$7C,$78,$60,$5C
	dc.l	$44,$40,$28,$24,$C,$8,$4,$0
        dc.l    5,76                            ; 5 longs pointing into hunk 76
	dc.l	$FA,$A2,$B8,$CE,$E4
	dc.l	0
	dc.l	HUNK_END
	endc
