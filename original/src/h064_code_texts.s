; F/A-18 Interceptor - hunk 64 (code)
; Text: the menus, the briefings (the six missions), the flight log page, the training texts,
; the log disk messages.
; Included by ../f18_main.s.

;===============================================================================
; Hunk 64: CODE, $2428 bytes
;===============================================================================
	CODE_HUNK	h064
dat_064_00000:
	dc.b	$00,$4D,$00,$4E,$00,$4F,$00,$50,$00,$51
; TextPageTable - The text pages: entry n-1 is the offset (from this table) of page n: a row,
; then lines of text. A page number with bit 15 set is printed at the bottom, bit 14 set
; continues the page before.
TextPageTable:
	dc.b	$04,$24,$04,$D7,$04,$86,$02,$D4,$04,$24,$05,$2D,$03,$EE,$03,$EE
	dc.b	$0A,$9C,$0C,$1A
	dc.b	'#F#M#T!*!'
	dc.b	$CF,$21,$B5,$21,$B6,$21,$B7,$21,$B8,$21,$B9,$00,$00,$01,$26,$10
	dc.b	$B5,$02,$2A,$03,$ED,$10,$B5,$11,$3A,$02,$2A,$12,$08,$12,$D5,$13
	dc.b	$1F,$13,$DB,$02,$2A,$14,$77,$14,$F0,$15,$89,$16,$3D,$21,$53,$17
	dc.b	$31,$17,$31,$02,$2A,$17,$F8,$1F,$F3,$18,$E7,$18,$E0,$19,$45,$19
	dc.b	$F2,$02,$2A,$1A,$6F,$1B,$55,$1B,$B8,$1B,$FC,$1C,$CC,$02,$2A,$1D
	dc.b	$3C,$1F,$F3,$1D,$C3,$1E,$16,$1E,$A3,$1E,$A3,$02,$2A,$1F,$4C,$1F
	dc.b	$F3,$06,$F3,$12,$CE,$18,$E0,$02,$E2,$01,$29,$01,$4B,$01,$70,$02
	dc.b	$AA,$20,$0F,$0D,$E4,$0F,$2E,$20,$E1,$16,$BD,$07,$62,$07,$8A,$07
	dc.b	$B0,$07,$D8,$08,$06,$0A,$3F,$0A,$6E,$0F,$A6,$10,$0D,$10,$2A,$08
	dc.b	$26,$21,$64,$21,$85,$21,$9E,$10,$4A,$1E,$7C,$11,$E2,$01,$96,$02
	dc.b	$2A,$02,$8A,$03,$36,$03,$55,$03,$A1,$05,$53,$05,$61,$05,$72,$05
	dc.b	$A2,$05,$CB,$05,$F5,$06,$26,$06,$46,$06,$6F,$06,$9D,$0A,$1B
; TextGroups - Offsets to lists of page numbers, one list per game mode (missions' texts).
TextGroups:
	dc.b	$00,$E8,$00,$F2,$00,$FE,$01,$08,$01,$12,$01,$1C,$00,$1A,$00,$1B
	dc.b	$00,$5F,$00,$1D,$00,$1E,$00,$1F,$00,$20,$00,$5F,$00,$22,$00,$23
	dc.b	$13,$DA,$00,$27,$00,$28,$00,$5F,$00,$2A,$00,$2B,$00,$2E,$00,$2F
	dc.b	$00,$5F,$00,$31,$00,$32,$00,$34,$00,$35,$00,$5F,$00,$37,$00,$38
	dc.b	$00,$3B,$00,$3C,$00,$5F,$00,$3E,$00,$3F,$06,$02,$FF,$06,$04,$00
	dc.b	'#NO LOG DISK PRESENT IN DF0:'
	dc.b	$00,$0A,$FF,$06,$04,$00
	dc.b	'#UNINITIALIZED LOG DISK IN DF0:'
	dc.b	$00,$03,$FF,$06,$04,$00
	dc.b	'#LOG DISK DF0: NOT WRITE ENABLED'
	dc.b	$00,$03,$FF,$1C,$04,$00
	dc.b	'#IF YOU WISH TO KEEP A LOG,'
	dc.b	$00,$03,$00
	dc.b	'#INSERT AN INITIALIZED AND'
	dc.b	$00,$03,$00
	dc.b	'#WRITE ENABLED DISK INTO DF0:'
	dc.b	$00,$03,$00
	dc.b	'#THEN PRESS RETURN'
	dc.b	$00,$03,$00,$96,$00,$00,$00
	dc.b	'#IF NOT, JUST PRESS RETURN'
	dc.b	$00,$00,$FF,$11,$06,$03,$95
	dc.b	' SECURITY HAS BEEN COMPROMISED'
	dc.b	$00,$04,$03,$95
	dc.b	' ALL OTHER NODES OF DEFENSENET'
	dc.b	$00,$00,$03,$95
	dc.b	' HAVE BEEN SABOTAGED.'
	dc.b	$00,$0F,$FF,$1C,$08,$03,$95
	dc.b	'DEFENSENET SECURITY CHECK'
	dc.b	$00,$06,$FF,$48,$02
dat_064_002B6:
	dc.b	$03,$96
	dc.b	' ENTER SECURITY COUNTERCODE:      -'
	dc.b	$00,$14,$FF,$48,$22,$03,$96
	dc.b	'       '
	dc.b	$00,$00,$FF,$11,$08,$03,$97
	dc.b	'UNAUTHORIZED CLEARANCE'
	dc.b	$00,$00,$03,$97
	dc.b	'DUE TO THREE FAILED ATTEMPTS'
	dc.b	$00,$05,$03,$97,$00,$00,$03,$97
	dc.b	'     - REBOOT -'
	dc.b	$00,$00,$FF
dat_064_00340:
	dc.b	$2A,$0A,$03,$13
	dc.b	'CHECKSUM ERROR -        '
	dc.b	$00,$00,$FF,$40,$04,$03,$14
	dc.b	'            HEY ROOKIE,'
	dc.b	$00,$0A,$03,$18,$00,$00,$03,$14
	dc.b	'F/A-16'
	dc.b	$27
	dc.b	'S  DON'
	dc.b	$27
	dc.b	'T GROW ON TREES, YA KNOW'
	dc.b	$00,$28,$FF,$40,$04,$03,$13
	dc.b	'            HEY ROOKIE,'
	dc.b	$00,$0A,$03,$18,$00,$00,$03,$13
	dc.b	'F/A-18'
	dc.b	$27
	dc.b	'S  DON'
	dc.b	$27
	dc.b	'T GROW ON TREES, YA KNOW'
	dc.b	$00,$28,$FF,$FF,$B6,$0A,$03,$D3
	dc.b	'SELECT YOUR FREE FLIGHT'
	dc.b	$00,$02,$03,$D3
	dc.b	'   STARTING LOCATION'
	dc.b	$00,$02,$FF,$10,$04,$03
	dc.b	'&WELCOME TO YOUR FIRST TOUR OF DUTY.'
	dc.b	$00,$00,$03,$26,$00,$00,$03
	dc.b	'&ENTER YOUR CALLSIGN:'
	dc.b	$00,$00,$03
	dc.b	'& (END WITH "RETURN")'
	dc.b	$00,$06,$03,$26,$00,$00,$FF,$82,$04,$03
	dc.b	'V                                   '
	dc.b	$00,$00,$03,$26,$00,$00,$03
	dc.b	'&YOU ARE NOW OFFICIALLY ENLISTED'
	dc.b	$00,$50,$FF,$24,$04
dat_064_004E3:
	dc.b	$03
	dc.b	'&WELCOME                                '
	dc.b	$00,$00,$03,$26,$00,$00,$03
	dc.b	'&TO YOUR CONTINUING TOUR OF DUTY.'
	dc.b	$00,$32,$FF,$00,$02,$03
	dc.b	'R           F/A-18 INTERCEPTOR$^'
	dc.b	$00,$05,$FF,$14,$02,$00,$A3
	dc.b	'SELECT:'
	dc.b	$00,$04,$FF,$28,$02,$00
	dc.b	'B1 ... DEMO'
	dc.b	$00,$04,$FF,$34,$02,$00
	dc.b	'B2 ... FREE FLIGHT, NO ENEMY CONFRONTATION'
	dc.b	$00,$04,$FF,$46,$02,$00
	dc.b	'R3 ... TRAINING:  DEMO OF MANEUVERS'
	dc.b	$00,$04,$FF,$52,$02,$00
	dc.b	'R4 ... TRAINING:  PRACTICE MANEUVERS'
	dc.b	$00,$04,$FF,$5E,$02,$00
	dc.b	'R5 ... QUALIFICATION: REQUIRED FOR MISSIONS'
	dc.b	$00,$04,$FF,$70,$02,$00,$12
	dc.b	'6 ... SELECTABLE MISSIONS'
	dc.b	$00,$04,$FF,$7C,$02,$00,$12
	dc.b	'7 ... NEXT ACTIVE ADVANCED MISSION'
	dc.b	$00,$04,$FF,$8E,$02,$00,$B2
	dc.b	'8 ... YOUR CURRENT FLIGHT LOG STATISTICS'
	dc.b	$00,$04,$A5,$02,$00,$A2
	dc.b	'ESC ......... RESTARTS YOUR SELECTION'
	dc.b	$00,$04,$00,$A2
	dc.b	'SHIFT ESC ... RETURNS YOU TO THIS MENU'
	dc.b	$00,$04,$FF,$0C,$04,$03,$D3
	dc.b	'       SELECTABLE MISSIONS'
	dc.b	$00,$01,$03
	dc.b	'S     (REQUIRES QUALIFICATION)'
	dc.b	$00,$05,$03,$53,$00,$00,$03,$53,$00,$00,$00,$13
	dc.b	' F1 - VISUAL CONFIRMATION MISSION'
	dc.b	$00,$04,$FF,$4C,$04,$00,$13
	dc.b	' F2 - EMERGENCY DEFENSE OPERATION'
	dc.b	$00,$04,$FF,$60,$04,$00,$13
	dc.b	' F3 - INTERCEPT STOLEN AIRCRAFT'
	dc.b	$00,$04,$FF,$74,$04,$00,$13
	dc.b	' F4 - SEARCH AND RESCUE OPERATION'
	dc.b	$00,$04,$FF,$88,$04,$00,$13
	dc.b	' F5 - INTERCEPT INCOMING CRUISE MISSILE'
	dc.b	$00,$04,$FF,$9C,$04,$00,$13
	dc.b	' F6 - CARRIER SUB MISSION'
	dc.b	$00,$04,$FF,$00,$02,$03,$B2
	dc.b	'         FLIGHT LOG STATISTICS'
	dc.b	$00,$04,$03,$92,$00,$00
dat_064_00858:
	dc.b	$00
	dc.b	'BTOTAL MISSIONS STARTED ............    '
	dc.b	$00,$04
dat_064_00883:
	dc.b	$00
	dc.b	'BMISSIONS SUCCESSFULLY COMPLETED ...    '
	dc.b	$00,$04,$00,$92,$00,$00,$00,$12
	dc.b	'                      FIRED    HITS'
	dc.b	$00,$04
dat_064_008D9:
	dc.b	$00,$12
	dc.b	'M61     CANNON ROUNDS               '
	dc.b	$00,$04
dat_064_00901:
	dc.b	$00,$12
	dc.b	'AIM-120 AMRAAMS                     '
	dc.b	$00,$04
dat_064_00929:
	dc.b	$00,$12
	dc.b	'AIM-9L  SIDEWINDERS                 '
	dc.b	$00,$04,$00,$92,$00,$00
dat_064_00955:
	dc.b	$00
	dc.b	'RACCUM. FLIGHT TIME         HRS,    MIN'
	dc.b	$00,$04
dat_064_0097F:
	dc.b	$00
	dc.b	'RCRASHES ..............    '
	dc.b	$00,$04
dat_064_0099D:
	dc.b	$00
	dc.b	'RHITS FROM MISSILES ...    '
	dc.b	$00,$00,$00,$92,$00,$00,$00,$92,$00,$00,$00,$B2
	dc.b	'     ESC .. TO MAIN MENU'
	dc.b	$00,$04,$00,$B2
	dc.b	'      1 ... UPDATE CURRENT LOG ONTO DISK'
	dc.b	$00,$04,$00,$B2
	dc.b	'SHIFT 2 ... RESET LOG'
	dc.b	$00,$04,$FF,$00,$04,$03,$93,$00,$28,$03,$A5
	dc.b	'       ESC - TO MAIN MENU'
	dc.b	$00,$14,$FF,$B0,$04,$03,$93,$00,$28,$03,$A5
	dc.b	' (SHIFT ESC)  TO RETURN TO MAIN MENU'
	dc.b	$00,$14,$FF,$B0,$04,$03,$93,$00,$1E,$03,$95
	dc.b	'(SHIFT ESC)  TO RETURN TO MAIN MENU'
	dc.b	$00,$14,$FF,$0F,$02,$03,$96
	dc.b	'      BASIC FLIGHT MANEUVERS - PART 1'
	dc.b	$00,$06,$03,$96,$00,$00,$03,$96
	dc.b	'OBSERVE THE FOLLOWING MANEUVERS'
	dc.b	$00,$12,$03,$96,$00,$00,$03,$96
	dc.b	'THEY WILL CYCLE THROUGH REPEATEDLY'
	dc.b	$00,$08,$03,$96
	dc.b	'UNTIL YOU ARE PREPARED TO PERFORM THEM.'
	dc.b	$00,$14,$03,$96,$00,$00,$03,$96,$00,$00,$03,$96
	dc.b	'USE KEYPAD TO CHANGE POINT OF VIEW/DIST'
	dc.b	$00,$0C,$03,$96
	dc.b	'USE (RETURN) TO SKIP TO NEXT MANEUVER'
	dc.b	$00,$10,$03,$96,$00,$00,$03,$96
	dc.b	'WHEN YOU ARE READY TO PRACTICE'
	dc.b	$00,$00,$03,$96
	dc.b	'  THE MANEUVERS, PRESS THE (ESC) KEY'
	dc.b	$00,$0F,$03,$95
	dc.b	'  OR (SHIFT ESC)  TO RETURN TO MAIN MENU'
	dc.b	$00,$46,$FF,$06,$00,$03,$96
	dc.b	'      BASIC FLIGHT MANEUVERS - PART 2'
	dc.b	$00,$0E,$03,$96,$00,$00,$03,$96,$00,$00,$03,$98
	dc.b	' BRING THRUST TO 80%'
	dc.b	$00,$0F,$03,$98
	dc.b	' FOLLOW LEAD AIRCRAFT'
	dc.b	$00,$14,$03,$98,$00,$00,$03,$98
	dc.b	' THEN PERFORM'
	dc.b	$00,$00,$03,$98
	dc.b	'   THE SAME MANEUVERS.'
	dc.b	$00,$1E,$03,$98,$00,$00,$03,$98
	dc.b	' AFTER EACH MANEUVER:'
	dc.b	$00,$0C,$03,$98
	dc.b	'  YOU WILL BE SIGNALED TO TRIGGER THE NEXT.'
	dc.b	$00,$19,$03,$98
	dc.b	'  POSITION YOURSELF BEHIND LEAD AIRCRAFT'
	dc.b	$00,$14,$03,$98
	dc.b	'  OR PRESS (RETURN) TO BE RE-POSITIONED.'
	dc.b	$00,$19,$03,$98
	dc.b	'  EACH NEXT (RETURN) WILL SKIP A MANEUVER.'
	dc.b	$00,$19,$03,$98
	dc.b	'  PRESS (S) TO TURN ON/OFF HIS SMOKE TRAIL.'
	dc.b	$00,$19,$03,$98,$00,$00,$03
	dc.b	'H YOUR MESSAGE DISPLAY INDICATES THE MANEUVER.'
	dc.b	$00,$3C,$FF,$06,$02,$03,$96
	dc.b	'             QUALIFICATION'
	dc.b	$00,$1E,$03,$96,$00,$00,$03,$96
	dc.b	' TO QUALIFY FOR ACTIVE MISSIONS,'
	dc.b	$00,$0A,$03,$96
	dc.b	' YOU MUST FIRST PERFORM A SUCCESSFUL'
	dc.b	$00,$00,$03,$96
	dc.b	' CARRIER LANDING.'
	dc.b	$00,$14,$03,$96,$00,$00,$03,$96
	dc.b	' FOR F/A-18 CARRIER LAUNCHES'
	dc.b	$00,$05,$03,$96
	dc.b	' ATTAIN AT LEAST 90% THRUST.'
	dc.b	$00,$0C,$03,$96
	dc.b	' FLY AROUND, RETURN, THEN LAND ON CARRIER.'
	dc.b	$00,$14,$03,$96,$00,$00,$03,$95
	dc.b	'       (ESC)  RE-POSITION ON CATAPULT'
	dc.b	$00,$04,$03,$95
	dc.b	' (SHIFT ESC)  RETURN TO MAIN MENU'
	dc.b	$00,$50,$FF,$1E,$04,$03,$95
	dc.b	'         LANDING SUCCESSFUL'
	dc.b	$00,$1E,$03,$95,$00,$00,$03,$95
	dc.b	' YOU ARE NOW QUALIFIED FOR MISSIONS'
	dc.b	$00,$1E,$03,$95,$00,$00,$03,$95,$00,$00,$03,$95
	dc.b	'     PREPARE TO BE RE-LAUNCHED.'
	dc.b	$00,$0A,$FF,$1D,$04,$03,$95
	dc.b	'       YOUR LOG NOW REFLECTS'
	dc.b	$00,$00,$03,$95
	dc.b	'       THIS COMPLETED MISSION.'
	dc.b	$00,$14,$03,$95,$00,$00,$03,$95
	dc.b	'          CONGRATULATIONS!'
	dc.b	$00,$1E,$FF,$1E,$04,$03,$97
	dc.b	'        RETURN TO BASE'
	dc.b	$00,$14,$FF,$1E,$04,$03,$97
	dc.b	'        RETURN TO CARRIER'
	dc.b	$00,$14,$FF,$06,$04,$03,$95
	dc.b	'      NORAD STRATEGIC COMMAND'
	dc.b	$00,$1E,$03,$95,$00,$00,$03,$95
	dc.b	'LOCATION: SAN FRANCISCO'
	dc.b	$00,$10
dat_064_01096:
	dc.b	$01,$95
	dc.b	'DATE:     SEPTEMBER  6, 1994'
	dc.b	$00,$10,$03,$95,$00,$00,$03,$95,$00,$00,$FF,$4A,$04,$03,$96
	dc.b	'VISUAL CONFIRMATION OPERATION'
	dc.b	$00,$1E,$03,$95
	dc.b	'ALERT STATUS:'
	dc.b	$00,$0C,$03,$95,$00,$00,$03,$96
	dc.b	' UNKNOWN AIRCRAFT IN YOUR SECTOR'
	dc.b	$00,$0A,$03,$96
	dc.b	' INBOUND BOGEY CLOSING ON ENTERPRISE'
	dc.b	$00,$50,$FF,$4A,$04,$03,$95
	dc.b	'VISUAL CONFIRMATION OPERATION'
	dc.b	$00,$14,$03,$95
	dc.b	'ALERT STATUS:'
	dc.b	$00,$08,$03,$95,$00,$00,$03,$96
	dc.b	'CONTACT: MULTIPLE BOGEYS DETECTED'
	dc.b	$00,$01,$03,$96
	dc.b	'WARNING: THERE ARE MIGS IN THE AREA'
	dc.b	$00,$01,$03,$96
	dc.b	'CONFIDENCE OF HOSTILITY IS HIGH'
	dc.b	$00,$64,$FF,$56,$02,$03,$97
	dc.b	'        - CLEARANCE CONFIRMED -'
	dc.b	$00,$14,$FF,$68,$02,$03,$96
	dc.b	' SCRAMBLE IMMEDIATELY'
	dc.b	$00,$08,$03,$96
	dc.b	' INTERCEPT AIRCRAFT FOR AERIAL RECON'
	dc.b	$00,$0A,$03,$96
	dc.b	' CONFIRM IF FRIEND OR FOE'
	dc.b	$00,$08,$03,$96
	dc.b	' AND RETURN TO BASE'
	dc.b	$00,$0C,$03,$96
	dc.b	' DO NOT ENGAGE UNLESS FIRED UPON'
	dc.b	$00,$0A,$03,$95
	dc.b	' REPEAT: DO NOT FIRE UNLESS FIRED UPON'
	dc.b	$00,$50,$FF,$0A,$06,$03,$97,$00,$00,$FF,$01,$06,$03,$97,$00,$00
	dc.b	$03,$97
	dc.b	' YOU NOW HAVE CONFIRMED SIGNATURE'
	dc.b	$00,$00,$03,$97
	dc.b	'       OF UNKNOWN AIRCRAFT'
	dc.b	$00,$0F,$FF,$4A,$02,$03,$95
	dc.b	'  EMERGENCY DEFENSE STATUS:'
	dc.b	$00,$04,$03,$95,$00,$00,$03,$96
	dc.b	'WE HAVE HOSTILE AIRCRAFT IN YOUR SECTOR'
	dc.b	$00,$03,$03,$96
	dc.b	'AIR FORCE ONE CURRENTLY ON COURSE TO SFO'
	dc.b	$00,$0F,$03,$96,$00,$00,$03,$96
	dc.b	'INBOUND BOGEY CLOSING ON AIR FORCE ONE'
	dc.b	$00,$00,$03,$96
	dc.b	'AT 630 KNOTS'
	dc.b	$00,$50,$FF,$FF,$4A,$04,$03,$96
	dc.b	'EMERGENCY DEFENSE STATUS:'
	dc.b	$00,$04,$03,$96,$00,$00,$03,$96
	dc.b	' AIR FORCE ONE DAMAGED BY MISSILE'
	dc.b	$00,$0A,$03,$96
	dc.b	' ATTEMPTING EMERGENCY LANDING AT SFO'
	dc.b	$00,$0A,$03,$96,$00,$00,$03,$96
	dc.b	' ESCORT AIRCRAFT HAS BEEN DESTROYED'
	dc.b	$00,$32,$FF,$77,$02,$03,$96
	dc.b	' SCRAMBLE IMMEDIATELY'
	dc.b	$00,$05,$03,$96
	dc.b	' INTERCEPT AND DESTROY ATTACKING AIRCRAFT.'
	dc.b	$00,$0A,$03,$96
	dc.b	'REPEAT: THIS IS A TKO, ENGAGE AND TERMINATE'
	dc.b	$00,$64,$FF,$06,$06,$03,$97,$00,$00,$03,$97
	dc.b	'  AIR FORCE ONE HAS SAFELY LANDED'
	dc.b	$00,$00,$03,$97,$00,$00,$03,$97
	dc.b	'  AT SAN FRANCISCO INTERNATIONAL'
	dc.b	$00,$0A,$03,$97,$00,$00,$03,$97
	dc.b	'  THE PRESIDENT IS UNHARMED.'
	dc.b	$00,$0A,$03,$97,$00,$00,$03,$97,$00,$00,$03,$97
	dc.b	'           WELL DONE!'
	dc.b	$00,$0F,$FF,$06,$06,$03,$97,$00,$00,$03,$97
	dc.b	'  AIR FORCE ONE HAS BEEN DESTROYED'
	dc.b	$00,$00,$03,$97,$00,$00,$03,$97
	dc.b	'  BY TERRORIST AIR-TO-AIR MISSILE.'
	dc.b	$00,$0A,$03,$97,$00,$00,$03,$97
	dc.b	'  THE PRESIDENT WAS ON BOARD.'
	dc.b	$00,$0A,$03,$97,$00,$00,$03,$97,$00,$00,$03,$97
	dc.b	'  GOOD THING THIS IS ONLY'
	dc.b	$00,$00,$03,$97
	dc.b	'  A SIMULATION!'
	dc.b	$00,$0F,$FF,$06,$06,$03,$97,$00,$00,$03,$97
	dc.b	'  AIR FORCE ONE HAS BEEN DESTROYED'
	dc.b	$00,$00,$03,$97,$00,$00,$03,$97
	dc.b	'  BY TERRORIST AIR-TO-AIR MISSILE.'
	dc.b	$00,$0A,$03,$97,$00,$00,$03,$97
	dc.b	'  THE PRESIDENT WAS NOT ON BOARD.'
	dc.b	$00,$0A,$FF,$06,$04,$03,$97,$00,$00,$03,$97
	dc.b	'    YOU HAVE DESTROYED AIR FORCE ONE.'
	dc.b	$00,$14,$03,$97,$00,$00,$03,$97
	dc.b	'    LUCKY FOR YOU THE PRESIDENT'
	dc.b	$00,$00,$03,$97,$00,$00,$03,$97
	dc.b	'    WAS NOT ON BOARD.'
	dc.b	$00,$0A,$FF,$4A,$02,$03,$95
	dc.b	'ALERT STATUS:'
	dc.b	$00,$04,$03,$95,$00,$00,$03,$96
	dc.b	'TWO AMERICAN F-16 TEST AIRCRAFT HAVE BEEN'
	dc.b	$00,$01,$03,$96
	dc.b	'STOLEN FROM MOFFETT FIELD BY TERRORISTS'
	dc.b	$00,$08,$03,$96
	dc.b	'CURRENTLY ON COURSE TOWARD SOVIET UNION'
	dc.b	$00,$0A,$03,$96,$00,$00,$03,$96
	dc.b	'THEY HAVE AIR SUPPORT:  PAIR OF MIGS'
	dc.b	$00,$0A,$FF,$6A,$02,$03,$96
	dc.b	'SCRAMBLE IMMEDIATELY'
	dc.b	$00,$05,$03,$96
	dc.b	'INTERCEPT STOLEN AIRCRAFT AND ATTEMPT'
	dc.b	$00,$00,$03,$96
	dc.b	'TO FORCE THEIR RETURN WITHOUT CONFLICT'
	dc.b	$00,$0F,$03,$96
	dc.b	'DO NOT FIRE UNLESS FIRED UPON'
	dc.b	$00,$14,$03,$96
	dc.b	'F-16S EQUIPPED WITH TOP SECRET ECM SYSTEMS'
	dc.b	$00,$0A,$03,$96
	dc.b	'SAFE RETURN OF HARDWARE IS TOP PRIORITY'
	dc.b	$00,$64,$FF,$06,$02,$03,$97,$00,$00,$FF,$06,$02,$03,$97,$00,$00
	dc.b	$03,$97
	dc.b	'STOLEN AIRCRAFT ARE NOW BEYOND'
	dc.b	$00,$00,$03,$97,$00,$00,$03,$97
	dc.b	'RECOVERY RANGE.'
	dc.b	$00,$14,$03,$97,$00,$00,$03,$97
	dc.b	'BETTER LUCK NEXT TIME.'
	dc.b	$00,$28,$FF,$4A,$02,$03,$95
	dc.b	'RESCUE OPERATION:'
	dc.b	$00,$04,$03,$95,$00,$00,$03,$96
	dc.b	'WE HAVE MULTIPLE BOGEYS'
	dc.b	$00,$05,$03,$96
	dc.b	'AT 25 MILES 480 KNOTS CLOSURE'
	dc.b	$00,$0A,$03,$96
	dc.b	'ONE OF OUR PILOTS HAS BEEN HIT AND DOWNED'
	dc.b	$00,$08,$03,$96
	dc.b	'BAILED OUT NEAR THE FARALLON ISLANDS'
	dc.b	$00,$5A,$FF,$4A,$04,$03,$96
	dc.b	'RESCUE OPERATION:'
	dc.b	$00,$04,$03,$96,$00,$00,$03,$96
	dc.b	'CONTACT - MULTIPLE BOGEYS'
	dc.b	$00,$05,$03,$96
	dc.b	' DOWNED PILOT IN YOUR SECTOR'
	dc.b	$00,$05,$03,$96
	dc.b	' POSITION SHOWN ON SATELLITE MAP'
	dc.b	$00,$05,$FF,$6A,$02,$03,$96
	dc.b	'SCRAMBLE IMMEDIATELY FOR RESCUE OPERATION'
	dc.b	$00,$0F,$03,$96
	dc.b	'WARNING: TENSION IS HIGH'
	dc.b	$00,$0A,$03,$96
	dc.b	'ENGAGE BANDITS IF NECESSARY'
	dc.b	$00,$08,$03,$96
	dc.b	'   THEN SEARCH FOR DOWNED PILOT'
	dc.b	$00,$04,$03,$96
	dc.b	'   AND DEPLOY EMERGENCY RESCUE POD AT SITE'
	dc.b	$00,$0A,$03,$96
	dc.b	'WARNING: DOWNED PILOT HAS LIMITED TIME'
	dc.b	$00,$64,$FF,$0A,$06,$03,$97
	dc.b	' EMERYGENCY RESCUE POD'
	dc.b	$00,$00,$03,$97
	dc.b	' DEPLOYED CLOSE ENOUGH TO DOWNED PILOT'
	dc.b	$00,$05,$03,$97,$00,$00,$03,$97
	dc.b	'          WELL DONE!'
	dc.b	$00,$0F,$FF,$0A,$06,$03,$97
	dc.b	' EMERYGENCY RESCUE POD'
	dc.b	$00,$00,$03,$97
	dc.b	' DEPLOYED TOO FAR FROM DOWNED PILOT'
	dc.b	$00,$05,$FF,$4A,$02,$03,$96
	dc.b	'ALERT: NORAD HAS ENTERED DEFCON 3'
	dc.b	$00,$0A,$03,$96,$00,$00,$03,$96
	dc.b	'WE HAVE INCOMING CRUISE MISSILE'
	dc.b	$00,$08,$03,$96
	dc.b	'REPEAT: INCOMING CRUISE MISSILE'
	dc.b	$00,$0C,$03,$96,$00,$00,$03,$96
	dc.b	'BEARING 170 AT 30 MILES 680 KNOTS CLOSURE'
	dc.b	$00,$0C,$03,$96
	dc.b	'ETA DELIVERY AT MOFFETT FIELD:  9 MINUTES'
	dc.b	$00,$3C,$FF,$4A,$04,$03,$96
	dc.b	'ALERT: NORAD HAS ENTERED DEFCON 2'
	dc.b	$00,$0A,$03,$96,$00,$00,$03,$96
	dc.b	'   CRUISE MISSILE LAUNCH DETECTED'
	dc.b	$00,$05,$03,$96
	dc.b	'   CLOSING ON MOFFETT FIELD'
	dc.b	$00,$78,$FF,$6C,$02,$03,$96
	dc.b	'SCRAMBLE IMMEDIATELY FOR INTERCEPTION'
	dc.b	$00,$0A,$03,$96
	dc.b	'WARNING:'
	dc.b	$00,$04,$03,$96
	dc.b	'  MULTIPLE BANDITS PROVIDING AIR SUPPORT'
	dc.b	$00,$06,$03,$96,$00,$00,$03,$96
	dc.b	'ENGAGE BANDITS IF NECESSARY'
	dc.b	$00,$64,$FF,$06,$02,$03,$07,$00,$00,$03,$07
	dc.b	'    ENEMY CRUISE MISSILE HAS EXPLODED'
	dc.b	$00,$00,$03,$07,$00,$00,$03,$07
	dc.b	'    NORTH OF MOFFETT FIELD.'
	dc.b	$00,$0A,$FF,$06,$02,$03,$07
	dc.b	'    NUCLEAR DESTRUCTION WIDESPREAD.'
	dc.b	$00,$0A,$03,$07,$00,$00,$03,$07,$00,$00,$03,$07
	dc.b	'    GOOD THING THIS IS ONLY'
	dc.b	$00,$00,$03,$07
	dc.b	'    A SIMULATION!'
	dc.b	$00,$3C,$FF,$06,$06,$03,$07
	dc.b	'  NO NUCLEAR DETONATION OCCURED.'
	dc.b	$00,$14,$FF,$4A,$04,$03,$96
	dc.b	'ALERT: SHADOW SUB DETECTION:'
	dc.b	$00,$0A,$03,$96,$00,$00,$03,$96
	dc.b	'C-19 INTELLIGENCE REPORTS:'
	dc.b	$00,$0C,$03,$96
	dc.b	' SUBMERSIBLE AIRCRAFT CARRIER'
	dc.b	$00,$05,$03,$96
	dc.b	' DETERMINED TO BE POINT OF ORIGIN'
	dc.b	$00,$00,$03,$96
	dc.b	'    OF ALL ENEMY AIRCRAFT.'
	dc.b	$00,$50,$FF,$6C,$02,$03,$96
	dc.b	'SCRAMBLE AND INTERCEPT SHADOW SUB'
	dc.b	$00,$08,$03,$96
	dc.b	'FLY IN BELOW 100 FT TO AVOID RADAR'
	dc.b	$00,$08,$03,$96
	dc.b	'DESTROY SUB WHILE NOW SURFACED'
	dc.b	$00,$08,$03,$96
	dc.b	'WARNING:'
	dc.b	$00,$04,$03,$96
	dc.b	' MULTIPLE BANDITS PROVIDING AIR SUPPORT'
	dc.b	$00,$50,$FF,$2B,$06,$03,$97
	dc.b	'           WELL DONE!'
	dc.b	$00,$0F,$FF,$06,$02,$03,$97,$00,$00,$03,$97
	dc.b	'THE LEAD AIRCRAFT HAS BEEN DESTROYED.'
	dc.b	$00,$0A,$03,$97,$00,$00,$03,$97
	dc.b	'THE PILOT HAS SURVIVED BUT IS NOT'
	dc.b	$00,$00,$03,$97,$00,$00,$03,$97
	dc.b	'PLEASED ABOUT THE COLLISION.'
	dc.b	$00,$0F,$03,$97,$00,$00,$03,$97,$00,$00,$03,$97
	dc.b	'THESE AIRCRAFT ARE VERY EXPENSIVE !!'
	dc.b	$00,$14,$03,$97
	dc.b	'PLEASE BE MORE CAREFUL NEXT TIME.'
	dc.b	$00,$28,$FF,$20,$02,$03,$95
	dc.b	'    SELECT'
	dc.b	$00,$00,$03,$95,$00,$00,$03,$94
	dc.b	'1 ... F/A-18  HORNET'
	dc.b	$00,$00,$03,$94,$00,$00,$03,$94
	dc.b	'2 ..... F-16  FALCON'
	dc.b	$00,$01,$FF,$36,$02,$03,$96
	dc.b	'    YOU HAVE SURVIVED YOUR BAILOUT'
	dc.b	$00,$1E,$FF,$2B,$10,$03,$96
	dc.b	'- PAUSED -'
	dc.b	$00,$0A,$FF
dat_064_0216E:
	dc.b	$1A,$08,$03,$96
	dc.b	' YOUR VECTOR XXX FOR BOGEY'
	dc.b	$00,$0F,$FF,$30,$0C,$03,$96
	dc.b	' READY FOR TAKEOFF'
	dc.b	$00,$08,$FF,$30,$0C,$03,$96
	dc.b	' READY TO LAUNCH'
	dc.b	$00,$08,$FF,$FF,$FF,$FF,$FF,$2A,$0C,$03,$94
	dc.b	'   KEY P STARTS'
	dc.b	$00,$00,$FF,$08,$02,$03
	dc.b	'R         F/A-18 INTERCEPTOR$^'
	dc.b	$00,$05,$03
	dc.b	'T          &1988 INTELLISOFT'
	dc.b	$00,$06,$03,$D4,$00,$00,$03,$14
	dc.b	'      DESIGNED AND PROGRAMMED BY:'
	dc.b	$00,$05,$03,$D4
	dc.b	'            BOB DINNERMAN'
	dc.b	$00,$05,$03,$D4,$00,$00,$03,$14
	dc.b	'         DESIGN ASSISTANCE BY:'
	dc.b	$00,$05,$03,$D4
	dc.b	'              MOSES MA'
	dc.b	$00,$05,$03,$D4,$00,$00,$03,$14
	dc.b	'         SOUNDS AND MUSIC BY:'
	dc.b	$00,$05,$03,$D4
	dc.b	'             DAVE WARHOL'
	dc.b	$00,$05,$03,$D4,$00,$00,$03,$14
	dc.b	'            PUBLISHED BY:'
	dc.b	$00,$05,$03,$D4
	dc.b	'    ELECTRONIC ARTS, SAN MATEO, CA.'
	dc.b	$00,$3C,$03,$D4,$00,$00,$03,$D4,$00,$00,$03
	dc.b	'T            PRESS ANY KEY'
	dc.b	$00,$05,$FF,$04,$00,$03,$D4,$00,$00,$FF,$04,$00,$03,$D4,$00,$00
	dc.b	$FF,$04,$00,$03,$D4,$00,$00,$FF,$00
; TextColumns - The text's character columns on the screen: a byte offset and a bit shift for
; each.
TextColumns:
	dc.b	$00,$00,$00,$00,$00,$00,$70,$00,$00,$00,$E0,$00,$00,$02,$50,$00
	dc.b	$00,$02,$C0,$00,$00,$04,$30,$00,$00,$04,$A0,$00,$00,$06,$10,$00
	dc.b	$00,$06,$80,$00,$00,$06,$F0,$00,$00,$08,$60,$00,$00,$08,$D0,$00
	dc.b	$00,$0A,$40,$00,$00,$0A,$B0,$00,$00,$0C,$20,$00,$00,$0C,$90,$00
	dc.b	$00,$0E,$00,$00,$00,$0E,$70,$00,$00,$0E,$E0,$00,$00,$10,$50,$00
	dc.b	$00,$10,$C0,$00,$00,$12,$30,$00,$00,$12,$A0,$00,$00,$14,$10,$00
	dc.b	$00,$14,$80,$00,$00,$14,$F0,$00,$00,$16,$60,$00,$00,$16,$D0,$00
	dc.b	$00,$18,$40,$00,$00,$18,$B0,$00,$00,$1A,$20,$00,$00,$1A,$90,$00
	dc.b	$00,$1C,$00,$00,$00,$1C,$70,$00,$00,$1C,$E0,$00,$00,$1E,$50,$00
	dc.b	$00,$1E,$C0,$00,$00,$20,$30,$00,$00,$20,$A0,$00,$00,$22,$10,$00
	dc.b	$00,$22,$80,$00,$00,$22,$F0,$00,$00,$24,$60,$00,$00,$24,$D0,$00
	dc.b	$00,$26,$40,$00,$00,$26,$B0,$00,$00,$28,$20,$00,$00,$28,$90,$00
	dc.b	$00,$00
h064_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc
