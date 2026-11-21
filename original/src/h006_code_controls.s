; F/A-18 Interceptor - hunk 6 (code)
; The fire button, the instruments' redraw counters, ResetPlayerAircraft.
; Included by ../f18_main.s.

;===============================================================================
; Hunk 6: CODE, $1D8 bytes
;===============================================================================
	CODE_HUNK	h006

;-------------------------------------------------------------------------------
; RedrawPanel - ClipY = 144 (the panel's top), then RedrawInstruments.
;-------------------------------------------------------------------------------
RedrawPanel:
        move.w  #$90,(ClipY).l                  ; 00000

;-------------------------------------------------------------------------------
; RedrawInstruments - Sets every instrument's redraw counter to 3 (PanelBlitCount the panel,
; PanelRedraw ... PanelLampRedraw), so each is drawn into both display buffers; and ViewY = 0
; unless ShakeKind is set.
;-------------------------------------------------------------------------------
RedrawInstruments:
        moveq   #$3,d4                          ; 00008
        move.b  d4,(PanelRedraw).l              ; 0000A
        move.b  d4,(PanelBlitCount).l           ; 00010
        move.b  d4,(GridZRedraw).l              ; 00016
        move.b  d4,(GridXRedraw).l              ; 0001C
        move.b  d4,(PanelIndicatorRedraw).l     ; 00022
        move.b  d4,(BackslashLampRedraw).l      ; 00028
        move.b  d4,(JLampRedraw).l              ; 0002E
        move.b  d4,(Redraw211).l                ; 00034
        move.b  d4,(WeaponRangeRedraw).l        ; 0003A
        move.b  d4,(RadarRangeRedraw).l         ; 00040
        move.b  d4,(StoresRedraw).l             ; 00046
        move.b  d4,(MissilesLeftRedraw).l       ; 0004C
        move.b  d4,(PanelLampRedraw).l          ; 00052
        move.b  d4,(TargetReadoutRedraw).l      ; 00058
        tst.b   (ShakeKind).l                   ; 0005E
        bne.b   l_006_00072                     ; 00064
        clr.w   (ViewY).l                       ; 00066
        clr.l   (PanelShakeOffset).l            ; 0006C
l_006_00072:
        rts                                     ; 00072

;-------------------------------------------------------------------------------
; StartGunSound - Sets bit 7 of GroundDetail, RadarScale = $80, and the instrument counter
; RadarRangeRedraw.
;-------------------------------------------------------------------------------
StartGunSound:
        bset    #$7,(GroundDetail).l            ; 00074
        move.w  #$80,(RadarScale).l             ; 0007C
        move.b  #$3,(RadarRangeRedraw).l        ; 00084
        rts                                     ; 0008C

;-------------------------------------------------------------------------------
; FirePressed - The fire button went down: queues the fire event (bit 2 of JoyEvents); with the
; gun selected (the player's weapon byte, ObjectTable+$63, high nibble $10) turns the gun on
; (bit 3 of GunFlags), with another weapon asks for a launch (LaunchRequest). In practice
; maneuvers (GameMode $7D) it does something else (bit 3 of Object4_02).
;-------------------------------------------------------------------------------
FirePressed:
        move.b  (PlayerEjection).l,d4           ; 0008E
        andi.b  #$f,d4                          ; 00094
        bne.b   l_006_000B4                     ; 00098
        cmpi.b  #$7d,(GameMode).l               ; 0009A
        bne.b   l_006_000B6                     ; 000A2
        tst.b   (TrainingWaitKey).l             ; 000A4
        bge.b   l_006_000B4                     ; 000AA
        bset    #$3,(Object4_02).l              ; 000AC
l_006_000B4:
        rts                                     ; 000B4
l_006_000B6:
        bset    #$2,(JoyEvents).l               ; 000B6
        move.b  (PlayerWeapon).l,d4             ; 000BE
        andi.b  #$f0,d4                         ; 000C4
        beq.b   l_006_000D8                     ; 000C8
        cmpi.b  #$10,d4                         ; 000CA
        beq.b   l_006_000DA                     ; 000CE
        move.b  #$1,(LaunchRequest).l           ; 000D0
l_006_000D8:
        rts                                     ; 000D8
l_006_000DA:
        ori.w   #$8,(GunFlags).l                ; 000DA
        rts                                     ; 000E2

;-------------------------------------------------------------------------------
; FireReleased - The fire button went up: queues the event (bit 3 of JoyEvents) and turns the
; gun off.
;-------------------------------------------------------------------------------
FireReleased:
        bset    #$3,(JoyEvents).l               ; 000E4
        andi.w  #$fff7,(GunFlags).l             ; 000EC
        rts                                     ; 000F4

;-------------------------------------------------------------------------------
; SetObjectBit7C - Sets the current object's obj_Ejection bit 7 (the entry after it, written as
; data, clears it), unless its +$03 bit 7 is set.
;-------------------------------------------------------------------------------
SetObjectBit7C:
        movem.l d4/d7/a1,-(a7)                  ; 000F6
        move.b  #$1,d7                          ; 000FA
        bra.b   l_006_00106                     ; 000FE
	dc.b	$48,$E7,$09,$40,$42,$07
l_006_00106:
        lea.l   (ObjectTable).l,a1              ; 00106
        adda.w  (CurrentObjectOffset).l,a1      ; 0010C
        btst    #$7,obj_Flags2+1(a1)            ; 00112
        bne.b   l_006_0012C                     ; 00118
        tst.b   d7                              ; 0011A
        bne.b   l_006_00126                     ; 0011C
        bclr    #$7,obj_Ejection(a1)            ; 0011E
        bra.b   l_006_0012C                     ; 00124
l_006_00126:
        bset    #$7,obj_Ejection(a1)            ; 00126
l_006_0012C:
        movem.l (a7)+,d4/d7/a1                  ; 0012C
        rts                                     ; 00130

;-------------------------------------------------------------------------------
; RearmAircraft - Re-arms and refuels the player's aircraft (ResetPlayerAircraft) with a
; message ($4005); in mission F6 the mission's result is cleared unless it is 1 or -1.
;-------------------------------------------------------------------------------
RearmAircraft:
        swap    d0                              ; 00132
        move.w  #$4005,d0                       ; 00134
        jsr     (StartWarning).l                ; 00138
        swap    d0                              ; 0013E
        cmpi.b  #$6,(GameMode).l                ; 00140
        bne.b   ResetPlayerAircraft             ; 00148
        move.b  (MissionResult).l,d3            ; 0014A
        subq.b  #$1,d3                          ; 00150
        beq.b   ResetPlayerAircraft             ; 00152
        addq.b  #$2,d3                          ; 00154
        beq.b   ResetPlayerAircraft             ; 00156
        clr.b   (MissionResult).l               ; 00158

;-------------------------------------------------------------------------------
; ResetPlayerAircraft - Sets the player's aircraft (ObjectTable record 0) back to its starting
; state: +$72 = 6,400,000, +$5F = $24, +$60 = 500; the instrument counters; then the other
; records...
;-------------------------------------------------------------------------------
ResetPlayerAircraft:
        move.l  #$61a800,(PlayerFuel).l         ; 0015E
        move.b  #$24,(PlayerMissiles).l         ; 00168
        move.w  #$1f4,(PlayerRounds).l          ; 00170
        move.b  #$3,(StoresRedraw).l            ; 00178
        move.b  #$3,(MissilesLeftRedraw).l      ; 00180
        move.b  #$10,(ChaffLeft).l              ; 00188
        move.b  #$10,(FlaresLeft).l             ; 00190
        clr.b   (CountermeasureSound).l         ; 00198
        clr.b   (BulletHitAircraft2).l          ; 0019E
        clr.b   (BulletHitAircraft).l           ; 001A4
        clr.w   (RescuePod).l                   ; 001AA
        movem.l d0/d4/a0-a1,-(a7)               ; 001B0
        lea.l   (ObjectTable).l,a0              ; 001B4
        adda.w  #$200,a0                        ; 001BA
        moveq   #$2,d0                          ; 001BE
l_006_001C0:
        moveq   #$28,d4                         ; 001C0
        lea.l   (a0),a1                         ; 001C2
l_006_001C4:
        clr.l   (a1)+                           ; 001C4
        dbra    d4,l_006_001C4                  ; 001C6
        adda.w  #$200,a0                        ; 001CA
        dbra    d0,l_006_001C0                  ; 001CE
        movem.l (a7)+,d0/d4/a0-a1               ; 001D2
        rts                                     ; 001D6
h006_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    48,71                           ; 48 longs pointing into hunk 71
	dc.l	$1AC,$1A6,$1A0,$19A,$A6,$DE,$F0,$D4
	dc.l	$BA,$E8,$14C,$15A,$9E,$144,$10E,$B0
	dc.l	$90,$C0,$164,$16C,$174,$108,$1B6,$80
	dc.l	$78,$6E,$68,$4,$60,$194,$18C,$5A
	dc.l	$54,$4E,$184,$48,$17C,$42,$88,$3C
	dc.l	$36,$30,$2A,$24,$1E,$18,$12,$C
        dc.l    1,20                            ; 1 longs pointing into hunk 20
	dc.l	$13A
	dc.l	0
	dc.l	HUNK_END
	endc
