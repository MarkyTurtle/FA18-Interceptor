; F/A-18 Interceptor - hunk 74 (code)
; The sound driver's data: the four audio channels' descriptors.
; Included by ../f18_main.s.

;===============================================================================
; Hunk 74: CODE, $104 bytes
;===============================================================================
	CODE_HUNK	h074
; AudioChannels - The four channels' descriptors (Channel0-Channel3).
AudioChannels:
        dc.l    Channel0                        ; 00000
        dc.l    Channel1                        ; 00004
        dc.l    Channel2                        ; 00008
        dc.l    Channel3                        ; 0000C
; ChannelSound - The sound each audio channel is playing (a Sound record; 0 = none): channel
; 0's, then ChannelSound1-3.
ChannelSound:
        dc.l    0                               ; 00010
ChannelSound1:
        dc.l    0                               ; 00014
ChannelSound2:
        dc.l    0                               ; 00018
ChannelSound3:
        dc.l    0                               ; 0001C
; Channel - an audio channel's descriptor (emits no bytes: the offsets).
                rsreset
chan_Regs               rs.l    1               ; its registers (AUDxLCH)
chan_Sound              rs.l    1               ; its ChannelSound entry
chan_Int                rs.l    1               ; its exec Interrupt (ChannelNInt)
chan_IntNum             rs.l    1               ; its interrupt number (7-10, SetIntVector)
chan_DMAOn              rs.w    1               ; DMACON: its DMA on
chan_DMAOff             rs.w    1               ; DMACON: its DMA off
chan_IntOn              rs.w    1               ; INTENA: its interrupt on
chan_IntBit             rs.w    1               ; INTENA / INTREQ: its interrupt off, or done
chan_OldInt             rs.l    1               ; the handler SetIntVector replaced
CHAN_SIZE               rs.b    0
; Channel0 - Audio channel 0's descriptor.
Channel0:
        dc.l    CUSTOM+AUD0LCH                  ; 00020
        dc.l    ChannelSound                    ; 00024
        dc.l    Channel0Int                     ; 00028
        dc.l    INTB_AUD0+0                     ; 0002C
        dc.w    DMAF_SETCLR|DMAF_MASTER|DMAF_AUD0,DMAF_AUD0 ; 00030
        dc.w    INTF_SETCLR|INTF_AUD0,INTF_AUD0 ; 00034
        dc.l    0                               ; 00038
; Channel1 - Audio channel 1's descriptor.
Channel1:
        dc.l    CUSTOM+AUD1LCH                  ; 0003C
        dc.l    ChannelSound1                   ; 00040
        dc.l    Channel1Int                     ; 00044
        dc.l    INTB_AUD0+1                     ; 00048
        dc.w    DMAF_SETCLR|DMAF_MASTER|DMAF_AUD1,DMAF_AUD1 ; 0004C
        dc.w    INTF_SETCLR|INTF_AUD1,INTF_AUD1 ; 00050
        dc.l    0                               ; 00054
; Channel2 - Audio channel 2's descriptor.
Channel2:
        dc.l    CUSTOM+AUD2LCH                  ; 00058
        dc.l    ChannelSound2                   ; 0005C
        dc.l    Channel2Int                     ; 00060
        dc.l    INTB_AUD0+2                     ; 00064
        dc.w    DMAF_SETCLR|DMAF_MASTER|DMAF_AUD2,DMAF_AUD2 ; 00068
        dc.w    INTF_SETCLR|INTF_AUD2,INTF_AUD2 ; 0006C
        dc.l    0                               ; 00070
; Channel3 - Audio channel 3's descriptor.
Channel3:
        dc.l    CUSTOM+AUD3LCH                  ; 00074
        dc.l    ChannelSound3                   ; 00078
        dc.l    Channel3Int                     ; 0007C
        dc.l    INTB_AUD0+3                     ; 00080
        dc.w    DMAF_SETCLR|DMAF_MASTER|DMAF_AUD3,DMAF_AUD3 ; 00084
        dc.w    INTF_SETCLR|INTF_AUD3,INTF_AUD3 ; 00088
        dc.l    0                               ; 0008C
; Channel0Int - Channel 0's exec Interrupt (AudioSetVector): is_Data = Channel0,
; is_Code = AudioInterrupt.
Channel0Int:
        dc.l    0,0                             ; 00090
        dc.b    NT_INTERRUPT,-120               ; 00098
        dc.l    0                               ; 0009A
        dc.l    Channel0                        ; 0009E
        dc.l    AudioInterrupt                  ; 000A2
; Channel1Int - Channel 1's exec Interrupt (AudioSetVector): is_Data = Channel1,
; is_Code = AudioInterrupt.
Channel1Int:
        dc.l    0,0                             ; 000A6
        dc.b    NT_INTERRUPT,-120               ; 000AE
        dc.l    0                               ; 000B0
        dc.l    Channel1                        ; 000B4
        dc.l    AudioInterrupt                  ; 000B8
; Channel2Int - Channel 2's exec Interrupt (AudioSetVector): is_Data = Channel2,
; is_Code = AudioInterrupt.
Channel2Int:
        dc.l    0,0                             ; 000BC
        dc.b    NT_INTERRUPT,-120               ; 000C4
        dc.l    0                               ; 000C6
        dc.l    Channel2                        ; 000CA
        dc.l    AudioInterrupt                  ; 000CE
; Channel3Int - Channel 3's exec Interrupt (AudioSetVector): is_Data = Channel3,
; is_Code = AudioInterrupt.
Channel3Int:
        dc.l    0,0                             ; 000D2
        dc.b    NT_INTERRUPT,-120               ; 000DA
        dc.l    0                               ; 000DC
        dc.l    Channel3                        ; 000E0
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
