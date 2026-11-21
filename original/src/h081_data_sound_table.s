; F/A-18 Interceptor - hunk 81 (data)
; SoundTable: the 37 sound slots.
; Included by ../f18_main.s.

;===============================================================================
; Hunk 81: DATA, $A4 bytes
;===============================================================================
	DATA_HUNK	h081
; SoundTable - The sound slots: 37 pointers to Sound records (0 = empty).
; Sound - a sound record (64 bytes; emits no bytes: the offsets). The sound driver plays the
; sample snd_Repeats + 1 times (-1: for ever), then snd_Next; each frame (AudioVBlank) it adds
; the steps to the period and volume for so many frames, and runs the sound's script: from
; snd_Script, pairs of longs - a field's offset and the value to store there - until a
; SND_WAIT pair (wait that many frames; 0 ends the sound), or SND_LOOP1 / SND_LOOP2 (go back
; to the offset given while snd_Loop1 / snd_Loop2 counts down).
                rsreset
snd_Data                rs.l    1               ; the sample (chip RAM)
snd_Length              rs.l    1               ; its length in bytes (bit 31: shared, not freed)
snd_Period              rs.l    1               ; the period (16.16)
snd_Volume              rs.l    1               ; the volume (16.16, 63 = full)
snd_Repeats             rs.l    1               ; the plays left (-1 loops)
snd_RepeatsSet          rs.l    1               ; ... set again from this for snd_Next
snd_PeriodStep          rs.l    1               ; added to the period each frame
snd_VolumeStep          rs.l    1               ; added to the volume each frame
snd_Next                rs.l    1               ; the sound to play after it (0: none)
snd_Loop1               rs.l    1               ; the script's loop counters
snd_Loop2               rs.l    1
snd_Wait                rs.l    1               ; frames until the script's next step (0: none)
snd_Script              rs.l    1               ; the script
snd_ScriptPos           rs.l    1               ; where it has got to (an offset)
snd_PeriodSteps         rs.l    1               ; frames left of snd_PeriodStep
snd_VolumeSteps         rs.l    1               ; frames left of snd_VolumeStep
SOUND_SIZE              rs.b    0
SND_WAIT                equ     snd_Wait        ; the script's commands (instead of a field)
SND_LOOP1               equ     $40
SND_LOOP2               equ     $44
SoundTable:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; CatapultSample - The sound loaded from text/textcpt (probably the catapult; SoundsLoaded bit
; 0), played by PlayCatapultSound.
CatapultSample:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; EngineSample - The engine sound loaded from text/textegn (SoundsLoaded bit 1).
EngineSample:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; EngineSample2 - The second engine sound, from text/textegn2.
EngineSample2:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; EffectSound - A sound made in memory for PlayEffect (its parameters at EffectParams).
EffectSound:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; TireSample - The sound loaded from text/texttre (probably the tyres' screech on landing;
; SoundsLoaded bit 2), played by PlayTireSound.
TireSample:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; SweepSound - A sound made in memory for PlaySweep (its parameters at SweepParams).
SweepSound:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; WindSample - The wind's sound, from text/textwnd (SoundsLoaded bit 4), with WindSample2.
WindSample:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; PlayWindSoundData1 - Data used by LoadEngineSounds, PlayWindSound.
PlayWindSoundData1:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; GunSoundCopy - A copy of a loaded sound used for the gun (PlayGunSound; parameters at
; GunParams; SoundsLoaded bit 5).
GunSoundCopy:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; GearSample - The sound loaded from text/textger (probably the landing gear; SoundsLoaded bit
; 6), played by PlayGearSound.
GearSample:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; EffectSound2 - A copy of a loaded sound for PlayEffect2 (parameters at Effect2Params).
EffectSound2:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; LoadMusicSamplesData1 - Data used by LoadMusicSamples.
LoadMusicSamplesData1:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; LoadMusicSamplesData2 - Data used by LoadMusicSamples.
LoadMusicSamplesData2:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; LoadMusicSamplesData3 - Data used by LoadMusicSamples.
LoadMusicSamplesData3:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; LoadMusicSamplesData4 - Data used by LoadMusicSamples.
LoadMusicSamplesData4:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; LoadMusicSamplesData5 - Data used by LoadMusicSamples.
LoadMusicSamplesData5:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; LoadMusicSamplesData6 - Data used by LoadMusicSamples.
LoadMusicSamplesData6:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; LoadMusicSamplesData7 - Data used by LoadMusicSamples.
LoadMusicSamplesData7:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; LoadMusicSamplesData8 - Data used by LoadMusicSamples.
LoadMusicSamplesData8:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; LoadMusicSamplesData9 - Data used by LoadMusicSamples.
LoadMusicSamplesData9:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; LoadMusicSamplesData10 - Data used by LoadMusicSamples.
LoadMusicSamplesData10:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; LoadMusicSamplesData11 - Data used by LoadMusicSamples.
LoadMusicSamplesData11:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; LoadMusicSamplesData12 - Data used by LoadMusicSamples.
LoadMusicSamplesData12:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00,$00,$00,$00
; LoadMusicSamplesData13 - Data used by LoadMusicSamples.
LoadMusicSamplesData13:
	dc.b	$00,$00,$00,$00
; LoadMusicSamplesData14 - Data used by LoadMusicSamples.
LoadMusicSamplesData14:
	dc.b	$00,$00,$00,$00
; LoadSound201Data1 - Data used by LoadSound201.
LoadSound201Data1:
	dc.b	$00,$00,$00,$00
; LoadSound201Data2 - Data used by LoadSound201.
LoadSound201Data2:
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
; LoadSoundData1 - Data used by LoadSound.
LoadSoundData1:
	dc.b	$72,$00,$00,$00
h081_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc
