; F/A-18 Interceptor - hunk 78 (data)
; Data: "audio.device", the channel allocation.
; Included by ../f18_main.s.

;===============================================================================
; Hunk 78: DATA, $28 bytes
;===============================================================================
	DATA_HUNK	h078
; InitSoundData1 - Data used by InitSound.
InitSoundData1:
	dc.b	$0F,$00
; InitSoundData2 - Data used by CloseSound, InitSound.
InitSoundData2:
	dc.b	$00,$00,$00,$00
; InitSoundData3 - Data used by CloseSound, InitSound.
InitSoundData3:
	dc.b	$00,$00,$00,$00
; InitSoundData4 - Data used by CloseSound, InitSound.
InitSoundData4:
	dc.b	$00,$00,$00,$00
; AudioDeviceOpen - Non-zero once audio.device is open (no sound otherwise).
AudioDeviceOpen:
	dc.b	$00,$00,$00,$00
; StrPortName - "abcdefg"
StrPortName:
	dc.b	'abcdefg'
	dc.b	$00
; StrAudioDevice - "audio.device"
StrAudioDevice:
	dc.b	'audio.device'
	dc.b	$00,$00
h078_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc
