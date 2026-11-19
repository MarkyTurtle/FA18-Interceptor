; F/A-18 Interceptor - hunk 59 (code)
; Text: the head-up display's warning messages (STALL, LOW FUEL - CRITICAL...).
; Included by ../f18_main.s.

;===============================================================================
; Hunk 59: CODE, $5E8 bytes
;===============================================================================
	CODE_HUNK	h059
dat_059_00000:
	dc.b	'@                          '
	dc.b	$00,$80
	dc.b	'           STALL          '
	dc.b	$00,$86
	dc.b	'    LOW FUEL - CRITICAL   '
	dc.b	$00,$80
	dc.b	'    LOW FUEL -            '
	dc.b	$00,$80
	dc.b	'      FUEL EXHAUSTED      '
	dc.b	$00
	dc.b	'H  RE-FUELED AND RE-ARMED  '
	dc.b	$00,$82
	dc.b	' CRASH IMMINENT           '
	dc.b	$00,$80
	dc.b	' CRASH IMMINENT - PULL UP '
	dc.b	$00
	dc.b	'D    AT MAXIMUM ALTITUDE   '
	dc.b	$00,$80
	dc.b	'         LOW FUEL         '
	dc.b	$00,$80
	dc.b	'   COLLISION PROXIMITY    '
	dc.b	$00,$86
	dc.b	'  MINOR HYDRAULIC DAMAGE  '
	dc.b	$00,$86
	dc.b	'  MINOR STRUCTURE DAMAGE  '
	dc.b	$00
	dc.b	'H   FRIENDLY IN VICINITY   '
	dc.b	$00,$84
	dc.b	' ALERT: ENEMY IN VICINITY '
	dc.b	$00,$80
	dc.b	' ALERT:                   '
	dc.b	$00,$88
	dc.b	'  ALERT:  IR MISSILE      '
	dc.b	$00,$80
	dc.b	'  ALERT:                  '
	dc.b	$00,$88
	dc.b	'  ALERT:  RH MISSILE      '
	dc.b	$00,$80
	dc.b	'  ALERT:                  '
	dc.b	$00,$80
	dc.b	' WARNING: TURBINE FAILURE '
	dc.b	$01,$80
	dc.b	' WARNING:                 '
	dc.b	$00,$88
	dc.b	'     TARGET DESTROYED     '
	dc.b	$00
	dc.b	'@       AILERON ROLL       '
	dc.b	$00
	dc.b	'@        BARREL ROLL       '
	dc.b	$00
	dc.b	'@        INSIDE LOOP       '
	dc.b	$00
	dc.b	'@        BREAK TURN        '
	dc.b	$00
	dc.b	'@          SPLIT-S         '
	dc.b	$00
	dc.b	'@      INVERTED FLIGHT     '
	dc.b	$00
	dc.b	'@     PATTERN EXHAUSTED    '
	dc.b	$00
	dc.b	'@     END OF MANEUVERS     '
	dc.b	$00
	dc.b	'ENOT YET RDY TO RE-POSITION'
	dc.b	$00,$88
	dc.b	'TARG SIGNATURE  OUT OF RNG'
	dc.b	$00
	dc.b	'E      DESTRUCT IMMUNE     '
	dc.b	$00
	dc.b	'E     ARRESTOR HOOK UP     '
	dc.b	$00
	dc.b	'E    ARRESTOR HOOK DOWN    '
	dc.b	$00,$88
	dc.b	'  ALERT: CRUISE MISSILE   '
	dc.b	$00,$80
	dc.b	'  ALERT:                  '
	dc.b	$00
	dc.b	'H      IR FLARE FIRED      '
	dc.b	$00
	dc.b	'H    NO FLARES REMAINING   '
	dc.b	$00
	dc.b	'H      CHAFF DISPENSED     '
	dc.b	$00
	dc.b	'H    NO CHAFF REMAINING    '
	dc.b	$00,$88
	dc.b	'- EJECT - EJECT - EJECT - '
	dc.b	$00
	dc.b	'A    VERTICAL HALF-LOOP    '
	dc.b	$00
	dc.b	'D TRIGGER TO START MANEUVER'
	dc.b	$00
	dc.b	'D TRIGGER FOR NEXT MANEUVER'
	dc.b	$00
	dc.b	'@ TRIGGER FOR: AILERON ROLL'
	dc.b	$00
	dc.b	'@ TRIGGER FOR: BARREL ROLL '
	dc.b	$00
	dc.b	'@ TRIGGER FOR: INSIDE LOOP '
	dc.b	$00
	dc.b	'@ TRIGGER FOR:  BREAK TURN '
	dc.b	$00
	dc.b	'@ TRIGGER FOR:   SPLIT-S   '
	dc.b	$00
	dc.b	'@ TRIGGER FOR: VRT HALFLOOP'
	dc.b	$00
	dc.b	'@ TRIGGER FOR: INVERTED FLT'
	dc.b	$00,$80
	dc.b	'    TOO LOW FOR SPLIT-S   '
	dc.b	$00
h059_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc
