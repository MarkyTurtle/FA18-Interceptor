; F/A-18 Interceptor - hunk 71 (code)
; The game's variables (zeros in the file): ObjectTable (16 records of 512 bytes), FrameStage,
; FrameCount, the controls, the drawing state...
; Included by ../f18_main.s.

;===============================================================================
; Hunk 71: CODE, $2D54 bytes
;===============================================================================
	CODE_HUNK	h071
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
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; TitleChecksum - The title picture's checksum ($C560 when it is the original: then the title
; sequence plays).
TitleChecksum:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00020:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00024:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00028:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_0002C:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00030:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00034:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00038:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_0003C:
	dc.b	$00
	dc.b	$00
dat_071_0003E:
	dcb.b	32,$00
dat_071_0005E:
	dcb.b	40,$00
; DrawPlanes - Points at the four plane pointers that drawing goes to (the buffer being drawn).
DrawPlanes:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_0008A:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_0008E:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00092:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00096:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_0009A:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_0009E:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_000A2:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_000A6:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_000AA:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_000AE:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_000B2:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_000B6:
	dc.b	$00
; DrawMask - Which planes drawing changes (bit n = plane n).
DrawMask:
	dc.b	$00
; DrawXor - >= 0: XOR the planes in DrawXorMask.
DrawXor:
	dc.b	$00
dat_071_000B9:
	dc.b	$00
dat_071_000BA:
	dc.b	$00
; DrawXorMask - The planes XORed when DrawXor >= 0.
DrawXorMask:
	dc.b	$00
dat_071_000BC:
	dc.b	$00
	dc.b	$00
dat_071_000BE:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_000C2:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_000C6:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_000CA:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_000CE:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_000D6:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_000DA:
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
dat_071_000E6:
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
dat_071_000F2:
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
dat_071_0010A:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_0010E:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00112:
	dc.b	$00
	dc.b	$00
dat_071_00114:
	dc.b	$00
	dc.b	$00
dat_071_00116:
	dc.b	$00
	dc.b	$00
dat_071_00118:
	dc.b	$00
	dc.b	$00
dat_071_0011A:
	dcb.b	40,$00
dat_071_00142:
	dc.b	$00
	dc.b	$00
dat_071_00144:
	dc.b	$00
	dc.b	$00
; MouseX - The mouse pointer's x (moved by MouseInterrupt).
MouseX:
	dc.b	$00
	dc.b	$00
; MouseY - The mouse pointer's y.
MouseY:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_0014C:
	dc.b	$00
	dc.b	$00
dat_071_0014E:
	dc.b	$00
	dc.b	$00
dat_071_00150:
	dc.b	$00
	dc.b	$00
dat_071_00152:
	dc.b	$00
	dc.b	$00
; FlightPhysics - Set: the fuller flight model - the stall check (UpdateAttitude), the speed
; lost climbing and gained diving and the lift (ClimbDivePhysics).
FlightPhysics:
	dc.b	$00
dat_071_00155:
	dc.b	$00
dat_071_00156:
	dc.b	$00
dat_071_00157:
	dc.b	$00
dat_071_00158:
	dc.b	$00
dat_071_00159:
	dc.b	$00
dat_071_0015A:
	dc.b	$00
	dc.b	$00
dat_071_0015C:
	dc.b	$00
	dc.b	$00
dat_071_0015E:
	dc.b	$00
dat_071_0015F:
	dc.b	$00
dat_071_00160:
	dc.b	$00
dat_071_00161:
	dc.b	$00
dat_071_00162:
	dc.b	$00
dat_071_00163:
	dc.b	$00
	dc.b	$00
dat_071_00165:
	dc.b	$00
dat_071_00166:
	dc.b	$00
dat_071_00167:
	dc.b	$00
dat_071_00168:
	dc.b	$00
dat_071_00169:
	dc.b	$00
dat_071_0016A:
	dc.b	$00
	dc.b	$00
dat_071_0016C:
	dc.b	$00
dat_071_0016D:
	dc.b	$00
dat_071_0016E:
	dc.b	$00
dat_071_0016F:
	dc.b	$00
dat_071_00170:
	dc.b	$00
dat_071_00171:
	dc.b	$00
dat_071_00172:
	dc.b	$00
dat_071_00173:
	dc.b	$00
dat_071_00174:
	dc.b	$00
dat_071_00175:
	dc.b	$00
dat_071_00176:
	dc.b	$00
dat_071_00177:
	dc.b	$00
dat_071_00178:
	dc.b	$00
dat_071_00179:
	dc.b	$00
	dc.b	$00
dat_071_0017B:
	dc.b	$00
dat_071_0017C:
	dc.b	$00
dat_071_0017D:
	dc.b	$00
dat_071_0017E:
	dc.b	$00
dat_071_0017F:
	dc.b	$00
dat_071_00180:
	dc.b	$00
dat_071_00181:
	dc.b	$00
dat_071_00182:
	dc.b	$00
dat_071_00183:
	dc.b	$00
dat_071_00184:
	dc.b	$00
dat_071_00185:
	dc.b	$00
dat_071_00186:
	dc.b	$00
dat_071_00187:
	dc.b	$00
dat_071_00188:
	dc.b	$00
dat_071_00189:
	dc.b	$00
; LaunchRequest - 1: launch the selected missile.
LaunchRequest:
	dc.b	$00
dat_071_0018B:
	dc.b	$00
dat_071_0018C:
	dc.b	$00
dat_071_0018D:
	dc.b	$00
dat_071_0018E:
	dc.b	$00
	dc.b	$00
dat_071_00190:
	dc.b	$00
dat_071_00191:
	dc.b	$00
	dc.b	$00
dat_071_00193:
	dc.b	$00
	dc.b	$00
dat_071_00195:
	dc.b	$00
dat_071_00196:
	dc.b	$00
dat_071_00197:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_0019B:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_001A3:
	dc.b	$00
dat_071_001A4:
	dc.b	$00
dat_071_001A5:
	dc.b	$00
dat_071_001A6:
	dc.b	$00
dat_071_001A7:
	dc.b	$00
dat_071_001A8:
	dc.b	$00
dat_071_001A9:
	dc.b	$00
	dc.b	$00
dat_071_001AB:
	dc.b	$00
dat_071_001AC:
	dc.b	$00
dat_071_001AD:
	dc.b	$00
dat_071_001AE:
	dc.b	$00
dat_071_001AF:
	dc.b	$00
dat_071_001B0:
	dc.b	$00
dat_071_001B1:
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
dat_071_001BB:
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
dat_071_001C5:
	dc.b	$00
dat_071_001C6:
	dc.b	$00
dat_071_001C7:
	dc.b	$00
dat_071_001C8:
	dc.b	$00
dat_071_001C9:
	dc.b	$00
dat_071_001CA:
	dc.b	$00
dat_071_001CB:
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_001CE:
	dc.b	$00
dat_071_001CF:
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
dat_071_001DA:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_001DE:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_001E7:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_001F0:
	dc.b	$00
dat_071_001F1:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_001FA:
	dc.b	$00
dat_071_001FB:
	dc.b	$00
dat_071_001FC:
	dc.b	$00
dat_071_001FD:
	dc.b	$00
; PitchInput - The stick / cursor keys, pitch: $10 up, $20 down, 0 centre.
PitchInput:
	dc.b	$00
; CommaPeriodInput - The , and . keys: $80 ',', $40 '.', 0 neither.
CommaPeriodInput:
	dc.b	$00
; RollInput - The stick / cursor keys, roll: $08 left, $04 right, 0 centre.
RollInput:
	dc.b	$00
dat_071_00201:
	dc.b	$00
dat_071_00202:
	dc.b	$00
dat_071_00203:
	dc.b	$00
dat_071_00204:
	dc.b	$00
dat_071_00205:
	dc.b	$00
dat_071_00206:
	dc.b	$00
dat_071_00207:
	dc.b	$00
dat_071_00208:
	dc.b	$00
dat_071_00209:
	dc.b	$00
dat_071_0020A:
	dc.b	$00
dat_071_0020B:
	dc.b	$00
dat_071_0020C:
	dc.b	$00
dat_071_0020D:
	dc.b	$00
dat_071_0020E:
	dc.b	$00
dat_071_0020F:
	dc.b	$00
dat_071_00210:
	dc.b	$00
dat_071_00211:
	dc.b	$00
dat_071_00212:
	dc.b	$00
dat_071_00213:
	dc.b	$00
dat_071_00214:
	dc.b	$00
dat_071_00215:
	dc.b	$00
dat_071_00216:
	dc.b	$00
dat_071_00217:
	dc.b	$00
dat_071_00218:
	dc.b	$00
dat_071_00219:
	dc.b	$00
	dc.b	$00
; RecordMode - The flight recording's mode: 0 recording, 1-3 replaying (1: the events' second
; word is not replayed), 4 finished.
RecordMode:
	dc.b	$00
dat_071_0021C:
	dc.b	$00
dat_071_0021D:
	dc.b	$00
dat_071_0021E:
	dc.b	$00
dat_071_0021F:
	dc.b	$00
dat_071_00220:
	dc.b	$00
; ViewSubCell - The viewing object's sub-cell (its +$0A).
ViewSubCell:
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00224:
	dc.b	$00
dat_071_00225:
	dc.b	$00
dat_071_00226:
	dc.b	$00
dat_071_00227:
	dc.b	$00
; RedrawFlags - What must be drawn again (set when the view moves into another map cell...).
RedrawFlags:
	dc.b	$00
dat_071_00229:
	dc.b	$00
dat_071_0022A:
	dc.b	$00
dat_071_0022B:
	dc.b	$00
dat_071_0022C:
	dc.b	$00
dat_071_0022D:
	dc.b	$00
dat_071_0022E:
	dc.b	$00
dat_071_0022F:
	dc.b	$00
dat_071_00230:
	dc.b	$00
dat_071_00231:
	dc.b	$00
dat_071_00232:
	dc.b	$00
dat_071_00233:
	dc.b	$00
dat_071_00234:
	dc.b	$00
dat_071_00235:
	dc.b	$00
dat_071_00236:
	dc.b	$00
dat_071_00237:
	dc.b	$00
dat_071_00238:
	dc.b	$00
dat_071_00239:
	dc.b	$00
dat_071_0023A:
	dc.b	$00
dat_071_0023B:
	dc.b	$00
dat_071_0023C:
	dc.b	$00
dat_071_0023D:
	dc.b	$00
dat_071_0023E:
	dc.b	$00
dat_071_0023F:
	dc.b	$00
dat_071_00240:
	dc.b	$00
dat_071_00241:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00248:
	dc.b	$00
dat_071_00249:
	dc.b	$00
dat_071_0024A:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00253:
	dc.b	$00
dat_071_00254:
	dc.b	$00
dat_071_00255:
	dc.b	$00
dat_071_00256:
	dc.b	$00
dat_071_00257:
	dc.b	$00
dat_071_00258:
	dc.b	$00
dat_071_00259:
	dc.b	$00
dat_071_0025A:
	dc.b	$00
dat_071_0025B:
	dc.b	$00
dat_071_0025C:
	dc.b	$00
dat_071_0025D:
	dc.b	$00
dat_071_0025E:
	dc.b	$00
dat_071_0025F:
	dc.b	$00
dat_071_00260:
	dc.b	$00
dat_071_00261:
	dc.b	$00
dat_071_00262:
	dc.b	$00
dat_071_00263:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00267:
	dc.b	$00
dat_071_00268:
	dc.b	$00
dat_071_00269:
	dc.b	$00
dat_071_0026A:
	dc.b	$00
dat_071_0026B:
	dc.b	$00
dat_071_0026C:
	dc.b	$00
dat_071_0026D:
	dc.b	$00
dat_071_0026E:
	dc.b	$00
dat_071_0026F:
	dc.b	$00
dat_071_00270:
	dc.b	$00
dat_071_00271:
	dc.b	$00
	dc.b	$00
dat_071_00273:
	dc.b	$00
dat_071_00274:
	dc.b	$00
dat_071_00275:
	dc.b	$00
dat_071_00276:
	dc.b	$00
; Difficulty - The difficulty (the flight log's +$02): how often computer aircraft may fire.
Difficulty:
	dc.b	$00
; DifficultySaved - The difficulty as loaded from the flight log.
DifficultySaved:
	dc.b	$00
dat_071_00279:
	dc.b	$00
dat_071_0027A:
	dc.b	$00
dat_071_0027B:
	dc.b	$00
dat_071_0027C:
	dc.b	$00
dat_071_0027D:
	dc.b	$00
dat_071_0027E:
	dc.b	$00
dat_071_0027F:
	dc.b	$00
dat_071_00280:
	dc.b	$00
dat_071_00281:
	dc.b	$00
dat_071_00282:
	dc.b	$00
dat_071_00283:
	dc.b	$00
dat_071_00284:
	dc.b	$00
dat_071_00285:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_0028B:
	dc.b	$00
dat_071_0028C:
	dc.b	$00
dat_071_0028D:
	dc.b	$00
dat_071_0028E:
	dc.b	$00
	dc.b	$00
dat_071_00290:
	dc.b	$00
	dc.b	$00
dat_071_00292:
	dc.b	$00
	dc.b	$00
dat_071_00294:
	dc.b	$00
	dc.b	$00
; GunFlags - Bit 3: the gun is firing.
GunFlags:
	dc.b	$00
	dc.b	$00
dat_071_00298:
	dc.b	$00
	dc.b	$00
dat_071_0029A:
	dc.b	$00
	dc.b	$00
dat_071_0029C:
	dc.b	$00
dat_071_0029D:
	dc.b	$00
dat_071_0029E:
	dc.b	$00
	dc.b	$00
dat_071_002A0:
	dc.b	$00
	dc.b	$00
dat_071_002A2:
	dc.b	$00
	dc.b	$00
dat_071_002A4:
	dc.b	$00
	dc.b	$00
dat_071_002A6:
	dc.b	$00
	dc.b	$00
; ViewY - The y offset of what is drawn with PlotInView.
ViewY:
	dc.b	$00
	dc.b	$00
; FrameCount - Counts frames (GameFrame runs some parts every 2nd, 4th, 8th, 16th or 32nd
; frame).
FrameCount:
	dc.b	$00
dat_071_002AB:
	dc.b	$00
dat_071_002AC:
	dc.b	$00
	dc.b	$00
; ViewObject - The offset (number << 9) of the object the view is from (normally the player,
; 0).
ViewObject:
	dc.b	$00
	dc.b	$00
dat_071_002B0:
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
dat_071_002BC:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_002C0:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_002C6:
	dc.b	$00
	dc.b	$00
dat_071_002C8:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_002CC:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_002D0:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_002D4:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_002D8:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_002DC:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_002E0:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_002E4:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_002E8:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_002EC:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_002F0:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_002F4:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_002F8:
	dc.b	$00
	dc.b	$00
dat_071_002FA:
	dc.b	$00
	dc.b	$00
dat_071_002FC:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00300:
	dc.b	$00
	dc.b	$00
dat_071_00302:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00306:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_0030A:
	dc.b	$00
	dc.b	$00
dat_071_0030C:
	dc.b	$00
	dc.b	$00
dat_071_0030E:
	dc.b	$00
	dc.b	$00
dat_071_00310:
	dc.b	$00
	dc.b	$00
dat_071_00312:
	dc.b	$00
	dc.b	$00
dat_071_00314:
	dc.b	$00
	dc.b	$00
dat_071_00316:
	dc.b	$00
	dc.b	$00
dat_071_00318:
	dc.b	$00
	dc.b	$00
dat_071_0031A:
	dc.b	$00
	dc.b	$00
; ViewCellX - The viewing object's map cell X (its +$06).
ViewCellX:
	dc.b	$00
	dc.b	$00
; ViewCellZ - The viewing object's map cell Z (its +$08).
ViewCellZ:
	dc.b	$00
	dc.b	$00
dat_071_00320:
	dc.b	$00
	dc.b	$00
dat_071_00322:
	dc.b	$00
	dc.b	$00
; DrawColour - The colour Plot and DrawLine draw in (0-15).
DrawColour:
	dc.b	$00
dat_071_00325:
	dc.b	$00
dat_071_00326:
	dc.b	$00
dat_071_00327:
	dc.b	$00
dat_071_00328:
	dc.b	$00
	dc.b	$00
dat_071_0032A:
	dc.b	$00
	dc.b	$00
dat_071_0032C:
	dc.b	$00
	dc.b	$00
dat_071_0032E:
	dc.b	$00
	dc.b	$00
dat_071_00330:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00334:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00338:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_0033E:
	dc.b	$00
	dc.b	$00
dat_071_00340:
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
dat_071_0034C:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00350:
	dc.b	$00
	dc.b	$00
dat_071_00352:
	dc.b	$00
	dc.b	$00
; ClipY - The row PlotBigAbove switches at ($90 = 144: the top of the panel).
ClipY:
	dc.b	$00
	dc.b	$00
dat_071_00356:
	dc.b	$00
	dc.b	$00
; ViewX - The x offset of what is drawn with PlotInView (the view window's left edge).
ViewX:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_0035C:
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
; FrameEvents1 - The first word of the frame's key / button events (recorded and replayed).
FrameEvents1:
	dc.b	$00
	dc.b	$00
; FrameEvents2 - The second word of the frame's events.
FrameEvents2:
	dc.b	$00
	dc.b	$00
; JoyEvents - Joystick button events waiting for ReadControls (bit 2 fire down, bit 3 fire up).
JoyEvents:
	dc.b	$00
dat_071_0036B:
	dc.b	$00
dat_071_0036C:
	dc.b	$00
dat_071_0036D:
	dc.b	$00
dat_071_0036E:
	dc.b	$00
	dc.b	$00
dat_071_00370:
	dc.b	$00
	dc.b	$00
dat_071_00372:
	dc.b	$00
	dc.b	$00
dat_071_00374:
	dc.b	$00
	dc.b	$00
dat_071_00376:
	dc.b	$00
	dc.b	$00
dat_071_00378:
	dc.b	$00
	dc.b	$00
dat_071_0037A:
	dc.b	$00
	dc.b	$00
dat_071_0037C:
	dc.b	$00
	dc.b	$00
dat_071_0037E:
	dc.b	$00
	dc.b	$00
dat_071_00380:
	dc.b	$00
	dc.b	$00
dat_071_00382:
	dc.b	$00
	dc.b	$00
; CurrentObject - The number of the object being worked on.
CurrentObject:
	dc.b	$00
dat_071_00385:
	dc.b	$00
; CurrentObjectOffset - Its offset in ObjectTable (number << 9).
CurrentObjectOffset:
	dc.b	$00
	dc.b	$00
dat_071_00388:
	dc.b	$00
	dc.b	$00
dat_071_0038A:
	dc.b	$00
	dc.b	$00
dat_071_0038C:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00390:
	dc.b	$00
	dc.b	$00
dat_071_00392:
	dc.b	$00
	dc.b	$00
dat_071_00394:
	dc.b	$00
	dc.b	$00
dat_071_00396:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_0039A:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_0039E:
	dcb.b	96,$00
dat_071_003FE:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00402:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00406:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_0040A:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_0040E:
	dc.b	$00
	dc.b	$00
dat_071_00410:
	dc.b	$00
	dc.b	$00
dat_071_00412:
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
dat_071_0041C:
	dc.b	$00
	dc.b	$00
dat_071_0041E:
	dc.b	$00
	dc.b	$00
dat_071_00420:
	dc.b	$00
	dc.b	$00
dat_071_00422:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00426:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_0042A:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_0042E:
	dc.b	$00
	dc.b	$00
dat_071_00430:
	dc.b	$00
	dc.b	$00
dat_071_00432:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00436:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_0043A:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_0043E:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00442:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00446:
	dc.b	$00
	dc.b	$00
dat_071_00448:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_0044C:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00450:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00454:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00458:
	dc.b	$00
	dc.b	$00
dat_071_0045A:
	dc.b	$00
	dc.b	$00
dat_071_0045C:
	dc.b	$00
	dc.b	$00
dat_071_0045E:
	dc.b	$00
	dc.b	$00
dat_071_00460:
	dc.b	$00
	dc.b	$00
dat_071_00462:
	dc.b	$00
	dc.b	$00
dat_071_00464:
	dc.b	$00
	dc.b	$00
dat_071_00466:
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
dat_071_00470:
	dc.b	$00
	dc.b	$00
dat_071_00472:
	dc.b	$00
	dc.b	$00
dat_071_00474:
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
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00486:
	dc.b	$00
	dc.b	$00
dat_071_00488:
	dc.b	$00
	dc.b	$00
dat_071_0048A:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00490:
	dc.b	$00
	dc.b	$00
dat_071_00492:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00496:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_0049A:
	dc.b	$00
	dc.b	$00
dat_071_0049C:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_004A0:
	dc.b	$00
	dc.b	$00
dat_071_004A2:
	dc.b	$00
	dc.b	$00
; FrameStage - Which part of GameFrame is running ($08, $10 ... $1D4): set before each part.
FrameStage:
	dc.b	$00
	dc.b	$00
dat_071_004A6:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_004AE:
	dc.b	$00
	dc.b	$00
dat_071_004B0:
	dc.b	$00
	dc.b	$00
dat_071_004B2:
	dc.b	$00
	dc.b	$00
dat_071_004B4:
	dc.b	$00
	dc.b	$00
dat_071_004B6:
	dc.b	$00
	dc.b	$00
dat_071_004B8:
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
; TimeSeconds - The system time (ReadTime): seconds.
TimeSeconds:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; TimeMicros - The system time (ReadTime): microseconds.
TimeMicros:
	dc.b	$00
	dc.b	$00
dat_071_004C8:
	dc.b	$00
dat_071_004C9:
	dc.b	$00
dat_071_004CA:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_004CE:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_004D2:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_004D6:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_004DA:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_004DE:
	dc.b	$00
	dc.b	$00
dat_071_004E0:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_004E4:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_004E8:
	dc.b	$00
	dc.b	$00
dat_071_004EA:
	dc.b	$00
	dc.b	$00
dat_071_004EC:
	dc.b	$00
	dc.b	$00
; BCDIn - BinToBCD's number.
BCDIn:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; BCDOut - BinToBCD's result: eight BCD digits.
BCDOut:
	dc.b	$00
	dc.b	$00
dat_071_004F4:
	dc.b	$00
	dc.b	$00
dat_071_004F6:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_004FA:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_004FE:
	dc.b	$00
	dc.b	$00
dat_071_00500:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00504:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00508:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_0050C:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00510:
	dc.b	$00
	dc.b	$00
dat_071_00512:
	dc.b	$00
	dc.b	$00
dat_071_00514:
	dc.b	$00
	dc.b	$00
dat_071_00516:
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
; WarningFlags - Warning bits (bit 0 / bit 1: the fuel's two low levels, bit 6: out of
; fuel...).
WarningFlags:
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00523:
	dc.b	$00
; SoundRequests - Sound request bits for CockpitSounds (4 bytes: $00524-$00527), set by the
; game (UpdateObject sets $80 for a warning...).
SoundRequests:
	dc.b	$00
	dc.b	$00
dat_071_00526:
	dc.b	$00
dat_071_00527:
	dc.b	$00
dat_071_00528:
	dc.b	$00
	dc.b	$00
; SoundFlags - Sound flags (bit 2: text201 loaded).
SoundFlags:
	dc.b	$00
dat_071_0052B:
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_0052E:
	dc.b	$00
	dc.b	$00
dat_071_00530:
	dc.b	$00
	dc.b	$00
dat_071_00532:
	dc.b	$00
	dc.b	$00
dat_071_00534:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00538:
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
dat_071_00544:
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
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00560:
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
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00572:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00576:
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
dat_071_00582:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_0058A:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_0058E:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00592:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00596:
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
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_005A8:
	dc.b	$00
	dc.b	$00
dat_071_005AA:
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
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_005BA:
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
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_005CC:
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
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_005DE:
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
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_005F0:
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
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00602:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00606:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_0060A:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; CameraX - The camera's position X (the eye the 3D view is drawn from).
CameraX:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; CameraY - The camera's position Y (height).
CameraY:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; CameraZ - The camera's position Z.
CameraZ:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_0061A:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_0061E:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00622:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00626:
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
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00642:
	dcb.b	1280,$00
dat_071_00B42:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00B48:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
dat_071_00B4E:
	dc.b	$00
	dc.b	$00
dat_071_00B50:
	dc.b	$00
	dc.b	$00
dat_071_00B52:
	dc.b	$00
	dc.b	$00
; ObjectTable - The 16 objects (aircraft, missiles, ships...; the player's aircraft is record 0):
; records of 512 bytes, $00B54-$02B53 (an object's offset = its number << 9). What is known:
;   +$00 w  flags ($2000 throttle at full, $0008 probably the afterburner, $0400 spent...)
;                                       +$01 b  bit 6 the object exists, bit 4 in a cell being drawn
;   +$03 b  bit 7   +$05 b  state (the computer pilot's: 1 pull up, 8 route...)   +$06 w  map cell X   +$08 w  map cell Z
;   +$0A b  sub-cell                    +$10 l
;   +$14 l  position X (low 22 bits: inside the cell)   +$18 l  Y (height; negative is up)
;   +$1C l  position Z (low 22 bits: inside the cell)   +$26 w  (a missile: $14 at launch)
;   +$22 w  (a weight-like term in the stall check)   +$26 w  responsiveness (at most 15)
;   +$28 b  pitch stick (-20..20)   +$29 b  rudder (-20..20)   +$2A b  roll stick (-60..60)
;   +$2B b  the throttle (0-120)   +$39 b  low nibble: the throttle's step   +$38 b  (copied to its missiles)
;   +$3E l  velocity X   +$42 l  velocity Y   +$46 l  velocity Z
;   +$4C w  a timer (a missile: $96 / $C8 at launch)
;   +$50 w, +$52 w, +$54 w  target rotation rates (computer aircraft)
;   +$56 w, +$58 w, +$5A w  rotation rates: the +$80 matrix turns by them each frame
;   +$5F b  missiles left: low nibble AMRAAMs, high nibble Sidewinders ($24 at the start)
;   +$62 b  type (0 Sidewinder, 1 AMRAAM; $1x aircraft flown by rotation rates; $3x ...)   +$64 b  more control bits
;   +$63 b  selected weapon (high nibble: $10 gun, $30 AMRAAM, else Sidewinder)
;   +$65 b  control bits: $80/$40 rudder (the , and . keys), $20/$10 pitch, $08/$04 roll, $02/$01 throttle
;   +$66 w  pitch   +$68 w  heading   +$6A w  roll  (1/80 degree; SetAttitude, UpdateAttitude)
;   +$80-$90 w  a 3 x 3 rotation matrix made from them (2.14)
;   +$6C w  speed   +$6E w  the speed flown (+$6C + +$78)   +$76 w  lift / sink (vertical velocity)
;   +$78 w  speed lost climbing / gained diving (ClimbDivePhysics)
;   +$7E w  ($1400 for a computer aircraft)   +$71 b   +$72 l  fuel (6,400,000 at the start)
;   +$7C b  bit 7
;   +$92-$A2 w  the opposite rotation (from the negated angles; rows at +$92, +$98, +$9E)
ObjectTable:
	dc.b	$00
	dc.b	$00
Player_02:
	dc.b	$00
Player_03:
	dc.b	$00
Player_04:
	dc.b	$00
	dc.b	$00
PlayerCellX:
	dc.b	$00
	dc.b	$00
PlayerCellZ:
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
; PlayerX - The player's position X (ObjectTable+$14).
PlayerX:
	dc.b	$00
	dc.b	$00
Player_16:
	dc.b	$00
	dc.b	$00
; PlayerY - The player's height (ObjectTable+$18; negative is up).
PlayerY:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; PlayerZ - The player's position Z (ObjectTable+$1C).
PlayerZ:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
Player_20:
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
Player_2B:
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
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
Player_3B:
	dc.b	$00
	dc.b	$00
	dc.b	$00
; PlayerVelX - The player's velocity X (ObjectTable+$3E).
PlayerVelX:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; PlayerVelY - The player's velocity Y (ObjectTable+$42).
PlayerVelY:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; PlayerVelZ - The player's velocity Z (ObjectTable+$46).
PlayerVelZ:
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
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
Player_56:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; PlayerMissiles - The player's missiles left (ObjectTable+$5F): low nibble AMRAAMs, high
; nibble Sidewinders.
PlayerMissiles:
	dc.b	$00
Player_60:
	dc.b	$00
	dc.b	$00
PlayerType:
	dc.b	$00
; PlayerWeapon - The player's selected weapon (ObjectTable+$63; high nibble $10 gun, $30
; AMRAAM, else Sidewinder).
PlayerWeapon:
	dc.b	$00
	dc.b	$00
; PlayerControls - The player's control bits (ObjectTable+$65).
PlayerControls:
	dc.b	$00
Player_66:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
Player_6C:
	dc.b	$00
	dc.b	$00
Player_6E:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; PlayerFuel - The player's fuel (ObjectTable+$72): 6,400,000 at the start; the warnings at
; 768,000 and 460,800, out of fuel at 0.
PlayerFuel:
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
Player_7C:
	dc.b	$00
Player_7D:
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
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; PlayerM11 - The player's orientation matrix (ObjectTable+$92-$A2: 9 words, rows M11-M13,
; M21-M23, M31-M33).
PlayerM11:
	dc.b	$00
	dc.b	$00
PlayerM12:
	dc.b	$00
	dc.b	$00
PlayerM13:
	dc.b	$00
	dc.b	$00
PlayerM21:
	dc.b	$00
	dc.b	$00
PlayerM22:
	dc.b	$00
	dc.b	$00
PlayerM23:
	dc.b	$00
	dc.b	$00
PlayerM31:
	dc.b	$00
	dc.b	$00
PlayerM32:
	dc.b	$00
	dc.b	$00
PlayerM33:
	dcb.b	350,$00
; Object1 - Object 1 of ObjectTable.
Object1:
	dc.b	$00
Object1_01:
	dcb.b	511,$00
; Object2 - Object 2 of ObjectTable.
Object2:
	dc.b	$00
Object2_01:
	dcb.b	511,$00
; Object3 - Object 3 of ObjectTable.
Object3:
	dc.b	$00
Object3_01:
	dcb.b	511,$00
; Object4 - Object 4 of ObjectTable.
Object4:
	dc.b	$00
	dc.b	$00
Object4_02:
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
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
Object4_14:
	dcb.b	492,$00
; Object5 - Object 5 of ObjectTable.
Object5:
	dcb.b	512,$00
; Object6 - Object 6 of ObjectTable.
Object6:
	dcb.b	512,$00
; Object7 - Object 7 of ObjectTable.
Object7:
	dcb.b	512,$00
; Object8 - Object 8 of ObjectTable.
Object8:
	dc.b	$00
Object8_01:
	dcb.b	511,$00
; Object9 - Object 9 of ObjectTable.
Object9:
	dcb.b	512,$00
; Object10 - Object 10 of ObjectTable.
Object10:
	dc.b	$00
Object10_01:
	dcb.b	511,$00
; Object11 - Object 11 of ObjectTable.
Object11:
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
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
Object11_14:
	dcb.b	492,$00
; Object12 - Object 12 of ObjectTable.
Object12:
	dcb.b	512,$00
; Object13 - Object 13 of ObjectTable.
Object13:
	dcb.b	512,$00
; Object14 - Object 14 of ObjectTable.
Object14:
	dcb.b	512,$00
; Object15 - Object 15 of ObjectTable.
Object15:
	dcb.b	512,$00
; SmallObjects - 16 small objects of 32 bytes after the ObjectTable, with the same +$01 flags,
; +$06 / +$08 map cell and +$0A sub-cell.
SmallObjects:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
SmallObjects_04:
	dcb.b	508,$00
h071_end:
	ifnd	HUNKEXE
	dc.l	HUNK_END
	endc
