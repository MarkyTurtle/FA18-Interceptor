; F/A-18 Interceptor - hunk 16 (code)
; ObjectDrawTable: each object's draw routine and model (the models are in hunks 41-58, 69,
; 70); ModelTable.
; Included by ../f18_main.s.

;===============================================================================
; Hunk 16: CODE, $C2C bytes
;===============================================================================
	CODE_HUNK	h016
; ModelTable - The models, 20 bytes each, copied into an object's ObjectDrawTable entry when it
; is placed: +$00 the draw routine, +$04 the model (the base its offsets count from, passed in
; a0), +$08 the shape list to draw (ShapeNow), +$0C ShapeNext (changed for animations), +$10 a
; second model or 0. $00 Sidewinder, $14 AMRAAM, $28 and $104 a pilot under his parachute (hunk
; 58; the downed pilot in F4), $3C F-16, $50 F/A-18, $64 Air Force One, $78 and $8C the MiGs,
; $A0 and $B4 the carrier, $C8 the cruise missile, $DC the rescue pod under a parachute, $F0 the
; submarine (object 15 of F6), $118 and $12C the airliners. Pictures of them: docs/MODELS.md.
ModelTable:
        dc.l    DrawModel                       ; 00000
        dc.l    SidewinderModel                 ; 00004
        dc.l    SidewinderModel                 ; 00008
        dc.l    SidewinderInfo                  ; 0000C
	dc.b	$00,$00,$00,$00
        dc.l    DrawModel                       ; 00014
        dc.l    AmraamModel                     ; 00018
        dc.l    AmraamModel                     ; 0001C
        dc.l    AmraamInfo                      ; 00020
	dc.b	$00,$00,$00,$00
        dc.l    DrawAnimated                    ; 00028
        dc.l    ParachuteModel                  ; 0002C
        dc.l    ParachuteModel                  ; 00030
        dc.l    ParachuteModel                  ; 00034
	dc.b	$00,$00,$00,$00
        dc.l    DrawAircraft                    ; 0003C
        dc.l    F16Model                        ; 00040
        dc.l    F16Model                        ; 00044
        dc.l    F16Info                         ; 00048
	dc.b	$00,$00,$00,$00
        dc.l    DrawAircraft                    ; 00050
        dc.l    FA18Model                       ; 00054
        dc.l    FA18Model                       ; 00058
        dc.l    FA18Info                        ; 0005C
	dc.b	$00,$00,$00,$00
        dc.l    DrawAircraft                    ; 00064
        dc.l    AirlinerModel                   ; 00068
        dc.l    AirlinerModel                   ; 0006C
        dc.l    AirlinerInfo                    ; 00070
	dc.b	$00,$00,$00,$00
        dc.l    DrawAircraft                    ; 00078
        dc.l    MigModel                        ; 0007C
        dc.l    MigModel                        ; 00080
        dc.l    MigInfo                         ; 00084
	dc.b	$00,$00,$00,$00
        dc.l    DrawAircraft                    ; 0008C
        dc.l    MigModel                        ; 00090
        dc.l    MigModel                        ; 00094
        dc.l    MigInfo                         ; 00098
	dc.b	$00,$00,$00,$00
        dc.l    DrawAircraft                    ; 000A0
        dc.l    CarrierModel                    ; 000A4
        dc.l    CarrierModel                    ; 000A8
        dc.l    CarrierModel                    ; 000AC
        dc.l    CarrierModel2                   ; 000B0
        dc.l    DrawAircraft                    ; 000B4
        dc.l    CarrierModel                    ; 000B8
        dc.l    CarrierModel                    ; 000BC
        dc.l    CarrierModel                    ; 000C0
        dc.l    CarrierModel2                   ; 000C4
        dc.l    DrawAircraft                    ; 000C8
        dc.l    CruiseMissileModel              ; 000CC
        dc.l    CruiseMissileModel              ; 000D0
        dc.l    CruiseMissileInfo               ; 000D4
	dc.b	$00,$00,$00,$00
        dc.l    DrawParachute                   ; 000DC
        dc.l    RescuePodModel                  ; 000E0
        dc.l    RescuePodModel                  ; 000E4
        dc.l    RescuePodModel                  ; 000E8
	dc.b	$00,$00,$00,$00
        dc.l    DrawAircraft                    ; 000F0
        dc.l    SubmarineModel                  ; 000F4
        dc.l    SubmarineModel                  ; 000F8
        dc.l    SubmarineModel                  ; 000FC
        dc.l    SubmarineModel2                 ; 00100
        dc.l    DrawAnimated                    ; 00104
        dc.l    ParachuteModel                  ; 00108
        dc.l    ParachuteModel                  ; 0010C
        dc.l    ParachuteModel                  ; 00110
	dc.b	$00,$00,$00,$00
        dc.l    DrawAircraft                    ; 00118
        dc.l    AirlinerModel                   ; 0011C
        dc.l    AirlinerModel                   ; 00120
        dc.l    AirlinerInfo                    ; 00124
	dc.b	$00,$00,$00,$00
        dc.l    DrawAircraft                    ; 0012C
        dc.l    AirlinerModel                   ; 00130
        dc.l    AirlinerModel                   ; 00134
        dc.l    AirlinerInfo                    ; 00138
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; ObjectDrawTable - 118 entries of 20 bytes, as in ModelTable (the draw routine, the model,
; ShapeNow, ShapeNext, a second model): entries 0-15 are the 16 objects' (copied from
; ModelTable when placed), entries 17-117 the scenery shapes, numbered by the scenery items of
; SceneryMap0-2 (hunks 42-50, 54-56, 69 and 70). DrawObjects loads an entry's fields and calls
; its routine.
ObjectDrawTable:
	dc.b	$00
	dc.b	$00
	dc.b	$00
	dc.b	$00
; ObjectDrawEntries - ObjectDrawTable's entries for the objects (0-16), filled when the objects
; are placed.
ObjectDrawEntries:
	dcb.b	336,$00
        dc.l    DrawSceneryPlain                ; 00294
        dc.l    Shape17                         ; 00298
        dc.l    Shape17                         ; 0029C
        dc.l    Shape17                         ; 002A0
	dc.b	$00,$00,$00,$00
        dc.l    DrawSceneryPlain                ; 002A8
        dc.l    Shape18                         ; 002AC
        dc.l    Shape18                         ; 002B0
        dc.l    Shape18                         ; 002B4
	dc.b	$00,$00,$00,$00
        dc.l    DrawSceneryPlain                ; 002BC
        dc.l    Shape19                         ; 002C0
        dc.l    Shape19                         ; 002C4
        dc.l    Shape19                         ; 002C8
	dc.b	$00,$00,$00,$00
        dc.l    DrawGroundShape                 ; 002D0
        dc.l    Shape20                         ; 002D4
        dc.l    Shape20                         ; 002D8
        dc.l    Shape20                         ; 002DC
	dc.b	$00,$00,$00,$00
        dc.l    DrawGroundShapeFar              ; 002E4
        dc.l    Shape21                         ; 002E8
        dc.l    Shape21                         ; 002EC
        dc.l    Shape21                         ; 002F0
	dc.b	$00,$00,$00,$00
        dc.l    DrawGroundShape                 ; 002F8
        dc.l    Shape22                         ; 002FC
        dc.l    Shape22                         ; 00300
        dc.l    Shape22                         ; 00304
	dc.b	$00,$00,$00,$00
        dc.l    DrawGroundShapeFar              ; 0030C
        dc.l    Shape23                         ; 00310
        dc.l    Shape23                         ; 00314
        dc.l    Shape23                         ; 00318
	dc.b	$00,$00,$00,$00
        dc.l    DrawGroundShapeFar              ; 00320
        dc.l    Shape24                         ; 00324
        dc.l    Shape24                         ; 00328
        dc.l    Shape24                         ; 0032C
	dc.b	$00,$00,$00,$00
        dc.l    DrawGroundShapeFar              ; 00334
        dc.l    Shape25                         ; 00338
        dc.l    Shape25                         ; 0033C
        dc.l    Shape25                         ; 00340
	dc.b	$00,$00,$00,$00
        dc.l    DrawGroundShapeFar              ; 00348
        dc.l    Shape26                         ; 0034C
        dc.l    Shape26                         ; 00350
        dc.l    Shape26                         ; 00354
	dc.b	$00,$00,$00,$00
        dc.l    DrawScenery                     ; 0035C
        dc.l    Shape27                         ; 00360
        dc.l    Shape27                         ; 00364
        dc.l    Shape27                         ; 00368
	dc.b	$00,$00,$00,$00
        dc.l    DrawScenery                     ; 00370
        dc.l    Shape28                         ; 00374
        dc.l    Shape28                         ; 00378
        dc.l    Shape28                         ; 0037C
	dc.b	$00,$00,$00,$00
        dc.l    DrawScenery                     ; 00384
        dc.l    Shape29                         ; 00388
        dc.l    Shape29                         ; 0038C
        dc.l    Shape29                         ; 00390
	dc.b	$00,$00,$00,$00
        dc.l    DrawSceneryPlain                ; 00398
        dc.l    Shape30                         ; 0039C
        dc.l    Shape30                         ; 003A0
        dc.l    Shape30                         ; 003A4
        dc.l    Shape30_00290                   ; 003A8
        dc.l    DrawScenery                     ; 003AC
        dc.l    Shape31                         ; 003B0
        dc.l    Shape31                         ; 003B4
        dc.l    Shape31                         ; 003B8
	dc.b	$00,$00,$00,$00
        dc.l    DrawSceneryPlain                ; 003C0
        dc.l    Shape32                         ; 003C4
        dc.l    Shape32                         ; 003C8
        dc.l    Shape32                         ; 003CC
	dc.b	$00,$00,$00,$00
        dc.l    DrawSceneryPlain                ; 003D4
        dc.l    Shape33                         ; 003D8
        dc.l    Shape33                         ; 003DC
        dc.l    Shape33                         ; 003E0
	dc.b	$00,$00,$00,$00
        dc.l    DrawScenery                     ; 003E8
        dc.l    Shape34                         ; 003EC
        dc.l    Shape34                         ; 003F0
        dc.l    Shape34                         ; 003F4
	dc.b	$00,$00,$00,$00
        dc.l    DrawScenery                     ; 003FC
        dc.l    Shape35                         ; 00400
        dc.l    Shape35                         ; 00404
        dc.l    Shape35                         ; 00408
	dc.b	$00,$00,$00,$00
        dc.l    DrawScenery                     ; 00410
        dc.l    Shape36                         ; 00414
        dc.l    Shape36                         ; 00418
        dc.l    Shape36                         ; 0041C
	dc.b	$00,$00,$00,$00
        dc.l    DrawScenery                     ; 00424
        dc.l    Shape37                         ; 00428
        dc.l    Shape37                         ; 0042C
        dc.l    Shape37                         ; 00430
	dc.b	$00,$00,$00,$00
        dc.l    DrawScenery                     ; 00438
        dc.l    Shape38                         ; 0043C
        dc.l    Shape38                         ; 00440
        dc.l    Shape38                         ; 00444
	dc.b	$00,$00,$00,$00
        dc.l    DrawScenery                     ; 0044C
        dc.l    Shape39                         ; 00450
        dc.l    Shape39                         ; 00454
        dc.l    Shape39                         ; 00458
	dc.b	$00,$00,$00,$00
        dc.l    DrawScenery                     ; 00460
        dc.l    Shape40                         ; 00464
        dc.l    Shape40                         ; 00468
        dc.l    Shape40                         ; 0046C
	dc.b	$00,$00,$00,$00
        dc.l    DrawScenery                     ; 00474
        dc.l    Shape41                         ; 00478
        dc.l    Shape41                         ; 0047C
        dc.l    Shape41                         ; 00480
	dc.b	$00,$00,$00,$00
        dc.l    DrawSceneryPlain                ; 00488
        dc.l    Shape42                         ; 0048C
        dc.l    Shape42                         ; 00490
        dc.l    Shape42                         ; 00494
        dc.l    Shape42_005C6                   ; 00498
        dc.l    DrawScenery                     ; 0049C
        dc.l    Shape43                         ; 004A0
        dc.l    Shape43                         ; 004A4
        dc.l    Shape43                         ; 004A8
	dc.b	$00,$00,$00,$00
        dc.l    DrawScenery                     ; 004B0
        dc.l    Shape44                         ; 004B4
        dc.l    Shape44                         ; 004B8
        dc.l    Shape44                         ; 004BC
	dc.b	$00,$00,$00,$00
        dc.l    DrawScenery                     ; 004C4
        dc.l    Shape45                         ; 004C8
        dc.l    Shape45                         ; 004CC
        dc.l    Shape45                         ; 004D0
	dc.b	$00,$00,$00,$00
        dc.l    DrawScenery                     ; 004D8
        dc.l    Shape46                         ; 004DC
        dc.l    Shape46                         ; 004E0
        dc.l    Shape46                         ; 004E4
	dc.b	$00,$00,$00,$00
        dc.l    DrawScenery                     ; 004EC
        dc.l    Shape47                         ; 004F0
        dc.l    Shape47                         ; 004F4
        dc.l    Shape47                         ; 004F8
	dc.b	$00,$00,$00,$00
        dc.l    DrawScenery                     ; 00500
        dc.l    Shape48                         ; 00504
        dc.l    Shape48                         ; 00508
        dc.l    Shape48                         ; 0050C
	dc.b	$00,$00,$00,$00
        dc.l    DrawScenery                     ; 00514
        dc.l    Shape49                         ; 00518
        dc.l    Shape49                         ; 0051C
        dc.l    Shape49                         ; 00520
	dc.b	$00,$00,$00,$00
        dc.l    DrawScenery                     ; 00528
        dc.l    Shape50                         ; 0052C
        dc.l    Shape50                         ; 00530
        dc.l    Shape50                         ; 00534
	dc.b	$00,$00,$00,$00
        dc.l    DrawSceneryNear                 ; 0053C
        dc.l    Shape51                         ; 00540
        dc.l    Shape51                         ; 00544
        dc.l    Shape51                         ; 00548
	dc.b	$00,$00,$00,$00
        dc.l    DrawScenery                     ; 00550
        dc.l    Shape52                         ; 00554
        dc.l    Shape52                         ; 00558
        dc.l    Shape52                         ; 0055C
	dc.b	$00,$00,$00,$00
        dc.l    DrawScenery                     ; 00564
        dc.l    Shape53                         ; 00568
        dc.l    Shape53                         ; 0056C
        dc.l    Shape53                         ; 00570
	dc.b	$00,$00,$00,$00
        dc.l    DrawScenery                     ; 00578
        dc.l    Shape54                         ; 0057C
        dc.l    Shape54                         ; 00580
        dc.l    Shape54                         ; 00584
	dc.b	$00,$00,$00,$00
        dc.l    DrawScenery                     ; 0058C
        dc.l    Shape55                         ; 00590
        dc.l    Shape55                         ; 00594
        dc.l    Shape55                         ; 00598
	dc.b	$00,$00,$00,$00
        dc.l    DrawSceneryPlain                ; 005A0
        dc.l    Shape56                         ; 005A4
        dc.l    Shape56                         ; 005A8
        dc.l    Shape56                         ; 005AC
        dc.l    Shape56_004F0                   ; 005B0
        dc.l    DrawSceneryPlain                ; 005B4
        dc.l    Shape57                         ; 005B8
        dc.l    Shape57                         ; 005BC
        dc.l    Shape57                         ; 005C0
        dc.l    Shape57_0055A                   ; 005C4
        dc.l    DrawScenery                     ; 005C8
        dc.l    Shape58                         ; 005CC
        dc.l    Shape58                         ; 005D0
        dc.l    Shape58                         ; 005D4
	dc.b	$00,$00,$00,$00
        dc.l    DrawScenery                     ; 005DC
        dc.l    Shape59                         ; 005E0
        dc.l    Shape59                         ; 005E4
        dc.l    Shape59                         ; 005E8
	dc.b	$00,$00,$00,$00
        dc.l    DrawScenery                     ; 005F0
        dc.l    Shape60                         ; 005F4
        dc.l    Shape60                         ; 005F8
        dc.l    Shape60                         ; 005FC
	dc.b	$00,$00,$00,$00
        dc.l    DrawScenery                     ; 00604
        dc.l    Shape61                         ; 00608
        dc.l    Shape61                         ; 0060C
        dc.l    Shape61                         ; 00610
	dc.b	$00,$00,$00,$00
        dc.l    DrawScenery                     ; 00618
        dc.l    Shape62                         ; 0061C
        dc.l    Shape62                         ; 00620
        dc.l    Shape62                         ; 00624
	dc.b	$00,$00,$00,$00
        dc.l    DrawScenery                     ; 0062C
        dc.l    Shape63                         ; 00630
        dc.l    Shape63                         ; 00634
        dc.l    Shape63                         ; 00638
	dc.b	$00,$00,$00,$00
        dc.l    DrawScenery                     ; 00640
        dc.l    Shape64                         ; 00644
        dc.l    Shape64                         ; 00648
        dc.l    Shape64                         ; 0064C
	dc.b	$00,$00,$00,$00
        dc.l    DrawScenery                     ; 00654
        dc.l    Shape65                         ; 00658
        dc.l    Shape65                         ; 0065C
        dc.l    Shape65                         ; 00660
	dc.b	$00,$00,$00,$00
        dc.l    DrawScenery                     ; 00668
        dc.l    Shape66                         ; 0066C
        dc.l    Shape66                         ; 00670
        dc.l    Shape66                         ; 00674
	dc.b	$00,$00,$00,$00
        dc.l    DrawScenery                     ; 0067C
        dc.l    Shape67                         ; 00680
        dc.l    Shape67                         ; 00684
        dc.l    Shape67                         ; 00688
	dc.b	$00,$00,$00,$00
        dc.l    DrawScenery                     ; 00690
        dc.l    Shape68                         ; 00694
        dc.l    Shape68                         ; 00698
        dc.l    Shape68                         ; 0069C
	dc.b	$00,$00,$00,$00
        dc.l    DrawScenery                     ; 006A4
        dc.l    Shape69                         ; 006A8
        dc.l    Shape69                         ; 006AC
        dc.l    Shape69                         ; 006B0
	dc.b	$00,$00,$00,$00
        dc.l    DrawSceneryPlain                ; 006B8
        dc.l    Shape70                         ; 006BC
        dc.l    Shape70                         ; 006C0
        dc.l    Shape70                         ; 006C4
        dc.l    Shape88_004CE                   ; 006C8
        dc.l    DrawSceneryNear                 ; 006CC
        dc.l    Shape71                         ; 006D0
        dc.l    Shape71                         ; 006D4
        dc.l    Shape71                         ; 006D8
	dc.b	$00,$00,$00,$00
        dc.l    DrawSceneryPlain                ; 006E0
        dc.l    Shape72                         ; 006E4
        dc.l    Shape72                         ; 006E8
        dc.l    Shape72                         ; 006EC
	dc.b	$00,$00,$00,$00
        dc.l    DrawScenery                     ; 006F4
        dc.l    Shape73                         ; 006F8
        dc.l    Shape73                         ; 006FC
        dc.l    Shape73                         ; 00700
	dc.b	$00,$00,$00,$00
        dc.l    DrawScenery                     ; 00708
        dc.l    Shape74                         ; 0070C
        dc.l    Shape74                         ; 00710
        dc.l    Shape74                         ; 00714
	dc.b	$00,$00,$00,$00
        dc.l    DrawScenery                     ; 0071C
        dc.l    Shape75                         ; 00720
        dc.l    Shape75                         ; 00724
        dc.l    Shape75                         ; 00728
	dc.b	$00,$00,$00,$00
        dc.l    DrawScenery                     ; 00730
        dc.l    Shape76                         ; 00734
        dc.l    Shape76                         ; 00738
        dc.l    Shape76                         ; 0073C
	dc.b	$00,$00,$00,$00
        dc.l    DrawScenery                     ; 00744
        dc.l    Shape77                         ; 00748
        dc.l    Shape77                         ; 0074C
        dc.l    Shape77                         ; 00750
	dc.b	$00,$00,$00,$00
        dc.l    DrawScenery                     ; 00758
        dc.l    Shape78                         ; 0075C
        dc.l    Shape78                         ; 00760
        dc.l    Shape78                         ; 00764
	dc.b	$00,$00,$00,$00
        dc.l    DrawSceneryPlain                ; 0076C
        dc.l    Shape79                         ; 00770
        dc.l    Shape79                         ; 00774
        dc.l    Shape79                         ; 00778
        dc.l    Shape79_0023C                   ; 0077C
        dc.l    DrawScenery                     ; 00780
        dc.l    Shape80                         ; 00784
        dc.l    Shape80                         ; 00788
        dc.l    Shape80                         ; 0078C
	dc.b	$00,$00,$00,$00
        dc.l    DrawScenery                     ; 00794
        dc.l    Shape81                         ; 00798
        dc.l    Shape81                         ; 0079C
        dc.l    Shape81                         ; 007A0
	dc.b	$00,$00,$00,$00
        dc.l    DrawGroundShape                 ; 007A8
        dc.l    Shape82                         ; 007AC
        dc.l    Shape82                         ; 007B0
        dc.l    Shape82                         ; 007B4
	dc.b	$00,$00,$00,$00
        dc.l    DrawGroundShapeFar              ; 007BC
        dc.l    Shape83                         ; 007C0
        dc.l    Shape83                         ; 007C4
        dc.l    Shape83                         ; 007C8
	dc.b	$00,$00,$00,$00
        dc.l    DrawGroundShapeFar              ; 007D0
        dc.l    Shape84                         ; 007D4
        dc.l    Shape84                         ; 007D8
        dc.l    Shape84                         ; 007DC
	dc.b	$00,$00,$00,$00
        dc.l    DrawGroundShapeFar              ; 007E4
        dc.l    Shape85                         ; 007E8
        dc.l    Shape85                         ; 007EC
        dc.l    Shape85                         ; 007F0
	dc.b	$00,$00,$00,$00
        dc.l    DrawScenery                     ; 007F8
        dc.l    Shape86                         ; 007FC
        dc.l    Shape86                         ; 00800
        dc.l    Shape86                         ; 00804
	dc.b	$00,$00,$00,$00
        dc.l    DrawScenery                     ; 0080C
        dc.l    Shape86                         ; 00810
        dc.l    Shape86                         ; 00814
        dc.l    Shape86                         ; 00818
	dc.b	$00,$00,$00,$00
        dc.l    DrawSceneryPlain                ; 00820
        dc.l    Shape88                         ; 00824
        dc.l    Shape88                         ; 00828
        dc.l    Shape88                         ; 0082C
        dc.l    Shape88_004CE                   ; 00830
        dc.l    DrawGroundShapeFar              ; 00834
        dc.l    Shape89                         ; 00838
        dc.l    Shape89                         ; 0083C
        dc.l    Shape89                         ; 00840
	dc.b	$00,$00,$00,$00
        dc.l    DrawGroundShapeFar              ; 00848
        dc.l    Shape90                         ; 0084C
        dc.l    Shape90                         ; 00850
        dc.l    Shape90                         ; 00854
	dc.b	$00,$00,$00,$00
        dc.l    DrawScenery                     ; 0085C
        dc.l    Shape91                         ; 00860
        dc.l    Shape91                         ; 00864
        dc.l    Shape91                         ; 00868
	dc.b	$00,$00,$00,$00
        dc.l    DrawScenery                     ; 00870
        dc.l    Shape92                         ; 00874
        dc.l    Shape92                         ; 00878
        dc.l    Shape92                         ; 0087C
	dc.b	$00,$00,$00,$00
        dc.l    DrawGroundShapeFar              ; 00884
        dc.l    Shape93                         ; 00888
        dc.l    Shape93                         ; 0088C
        dc.l    Shape93                         ; 00890
	dc.b	$00,$00,$00,$00
        dc.l    DrawGroundShapeFar              ; 00898
        dc.l    Shape94                         ; 0089C
        dc.l    Shape94                         ; 008A0
        dc.l    Shape94                         ; 008A4
	dc.b	$00,$00,$00,$00
        dc.l    DrawGroundShapeFar              ; 008AC
        dc.l    Shape95                         ; 008B0
        dc.l    Shape95                         ; 008B4
        dc.l    Shape95                         ; 008B8
	dc.b	$00,$00,$00,$00
        dc.l    DrawGroundShapeFar              ; 008C0
        dc.l    Shape96                         ; 008C4
        dc.l    Shape96                         ; 008C8
        dc.l    Shape96                         ; 008CC
	dc.b	$00,$00,$00,$00
        dc.l    DrawGroundShapeFar              ; 008D4
        dc.l    Shape97                         ; 008D8
        dc.l    Shape97                         ; 008DC
        dc.l    Shape97                         ; 008E0
	dc.b	$00,$00,$00,$00
        dc.l    DrawGroundShapeFar              ; 008E8
        dc.l    Shape98                         ; 008EC
        dc.l    Shape98                         ; 008F0
        dc.l    Shape98                         ; 008F4
	dc.b	$00,$00,$00,$00
        dc.l    DrawGroundShapeFar              ; 008FC
        dc.l    Shape99                         ; 00900
        dc.l    Shape99                         ; 00904
        dc.l    Shape99                         ; 00908
	dc.b	$00,$00,$00,$00
        dc.l    DrawGroundShapeFar              ; 00910
        dc.l    Shape100                        ; 00914
        dc.l    Shape100                        ; 00918
        dc.l    Shape100                        ; 0091C
	dc.b	$00,$00,$00,$00
        dc.l    DrawGroundShapeFar              ; 00924
        dc.l    Shape101                        ; 00928
        dc.l    Shape101                        ; 0092C
        dc.l    Shape101                        ; 00930
	dc.b	$00,$00,$00,$00
        dc.l    DrawGroundShapeFar              ; 00938
        dc.l    Shape102                        ; 0093C
        dc.l    Shape102                        ; 00940
        dc.l    Shape102                        ; 00944
	dc.b	$00,$00,$00,$00
        dc.l    DrawGroundShapeFar              ; 0094C
        dc.l    Shape103                        ; 00950
        dc.l    Shape103                        ; 00954
        dc.l    Shape103                        ; 00958
	dc.b	$00,$00,$00,$00
        dc.l    DrawGroundShapeFar              ; 00960
        dc.l    Shape104                        ; 00964
        dc.l    Shape104                        ; 00968
        dc.l    Shape104                        ; 0096C
	dc.b	$00,$00,$00,$00
        dc.l    DrawGroundShapeFar              ; 00974
        dc.l    Shape105                        ; 00978
        dc.l    Shape105                        ; 0097C
        dc.l    Shape105                        ; 00980
	dc.b	$00,$00,$00,$00
        dc.l    DrawGroundShapeFar              ; 00988
        dc.l    Shape106                        ; 0098C
        dc.l    Shape106                        ; 00990
        dc.l    Shape106                        ; 00994
	dc.b	$00,$00,$00,$00
        dc.l    DrawGroundShapeFar              ; 0099C
        dc.l    Shape107                        ; 009A0
        dc.l    Shape107                        ; 009A4
        dc.l    Shape107                        ; 009A8
	dc.b	$00,$00,$00,$00
        dc.l    DrawGroundShapeFar              ; 009B0
        dc.l    Shape108                        ; 009B4
        dc.l    Shape108                        ; 009B8
        dc.l    Shape108                        ; 009BC
	dc.b	$00,$00,$00,$00
        dc.l    DrawGroundShapeFar              ; 009C4
        dc.l    Shape109                        ; 009C8
        dc.l    Shape109                        ; 009CC
        dc.l    Shape109                        ; 009D0
	dc.b	$00,$00,$00,$00
        dc.l    DrawGroundShapeFar              ; 009D8
        dc.l    Shape110                        ; 009DC
        dc.l    Shape110                        ; 009E0
        dc.l    Shape110                        ; 009E4
	dc.b	$00,$00,$00,$00
        dc.l    DrawGroundShapeFar              ; 009EC
        dc.l    Shape111                        ; 009F0
        dc.l    Shape111                        ; 009F4
        dc.l    Shape111                        ; 009F8
	dc.b	$00,$00,$00,$00
        dc.l    DrawGroundShapeFar              ; 00A00
        dc.l    Shape112                        ; 00A04
        dc.l    Shape112                        ; 00A08
        dc.l    Shape112                        ; 00A0C
	dc.b	$00,$00,$00,$00
        dc.l    DrawGroundShapeFar              ; 00A14
        dc.l    Shape113                        ; 00A18
        dc.l    Shape113                        ; 00A1C
        dc.l    Shape113                        ; 00A20
	dc.b	$00,$00,$00,$00
        dc.l    DrawGroundShapeFar              ; 00A28
        dc.l    Shape114                        ; 00A2C
        dc.l    Shape114                        ; 00A30
        dc.l    Shape114                        ; 00A34
	dc.b	$00,$00,$00,$00
        dc.l    DrawGroundShapeFar              ; 00A3C
        dc.l    Shape115                        ; 00A40
        dc.l    Shape115                        ; 00A44
        dc.l    Shape115                        ; 00A48
	dc.b	$00,$00,$00,$00
        dc.l    DrawGroundShapeFar              ; 00A50
        dc.l    Shape116                        ; 00A54
        dc.l    Shape116                        ; 00A58
        dc.l    Shape116                        ; 00A5C
	dc.b	$00,$00,$00,$00
        dc.l    DrawScenery                     ; 00A64
        dc.l    Shape117                        ; 00A68
        dc.l    Shape117                        ; 00A6C
        dc.l    Shape117                        ; 00A70
	dc.b	$00,$00,$00,$00

;-------------------------------------------------------------------------------
; DrawAircraft - The draw routine of the aircraft and most models: an object just hit (flags
; bit 9) starts its explosion (timer 15, flags bit 10); then DrawModel.
;-------------------------------------------------------------------------------
DrawAircraft:
        lea.l   (ObjectTable).l,a1              ; 00A78
        adda.w  (CurrentObjectOffset).l,a1      ; 00A7E
        move.w  obj_Flags(a1),d1                ; 00A84
        move.w  d1,d2                           ; 00A88
        andi.w  #$40,d1                         ; 00A8A
        beq.b   l_016_00ABC                     ; 00A8E
        andi.w  #$200,d2                        ; 00A90
        beq.b   l_016_00AB6                     ; 00A94
        move.w  #$f,obj_Timer(a1)               ; 00A96
        andi.w  #$fdff,obj_Flags(a1)            ; 00A9C
        ori.w   #$400,obj_Flags(a1)             ; 00AA2
        move.l  a0,-(a7)                        ; 00AA8
        bsr.w   NoDraw                          ; 00AAA
        jsr     (TargetMessage).l               ; 00AAE
        movea.l (a7)+,a0                        ; 00AB4
l_016_00AB6:
        jmp     (DrawModel).l                   ; 00AB6
l_016_00ABC:
        cmpi.b  #$5,$7a(a1)                     ; 00ABC
        beq.b   l_016_00AD0                     ; 00AC2
        tst.w   obj_Timer(a1)                   ; 00AC4
        bge.b   l_016_00AD0                     ; 00AC8
        ori.w   #$40,obj_Flags(a1)              ; 00ACA
l_016_00AD0:
        rts                                     ; 00AD0

;-------------------------------------------------------------------------------
; DrawAnimated - Draws hunk 58's animated object, its shape chosen by the timer (+$4C): 5 and
; over, 3-4, 1-2, 0, negative.
;-------------------------------------------------------------------------------
DrawAnimated:
        lea.l   (ObjectTable).l,a1              ; 00AD2
        adda.w  (CurrentObjectOffset).l,a1      ; 00AD8
        lea.l   (ParachuteModel).l,a0           ; 00ADE
        move.w  obj_Timer(a1),d0                ; 00AE4
        ble.b   l_016_00B28                     ; 00AE8
        cmpi.w  #$5,d0                          ; 00AEA
        bge.b   l_016_00B5A                     ; 00AEE
        cmpi.w  #$1,d0                          ; 00AF0
        beq.b   l_016_00B12                     ; 00AF4
        cmpi.w  #$2,d0                          ; 00AF6
        beq.b   l_016_00B12                     ; 00AFA
        move.l  #Parachute_00020,(ShapeNow).l   ; 00AFC
        move.l  #Parachute_00020,(ShapeNext).l  ; 00B06
        bra.b   l_016_00AB6                     ; 00B10
l_016_00B12:
        move.l  #Parachute_0002E,(ShapeNow).l   ; 00B12
        move.l  #Parachute_0002E,(ShapeNext).l  ; 00B1C
        bra.b   l_016_00AB6                     ; 00B26
l_016_00B28:
        blt.b   l_016_00B42                     ; 00B28
        move.l  #Parachute_00040,(ShapeNow).l   ; 00B2A
        move.l  #Parachute_00040,(ShapeNext).l  ; 00B34
        bra.w   l_016_00AB6                     ; 00B3E
l_016_00B42:
        move.l  #Parachute_0003C,(ShapeNow).l   ; 00B42
        move.l  #Parachute_0003C,(ShapeNext).l  ; 00B4C
        bra.w   l_016_00AB6                     ; 00B56
l_016_00B5A:
        move.l  #ParachuteModel,(ShapeNow).l    ; 00B5A
        move.l  #ParachuteModel,(ShapeNext).l   ; 00B64
        bra.w   l_016_00AB6                     ; 00B6E

;-------------------------------------------------------------------------------
; DrawParachute - Draws the ejected pilot (hunk 58 at $2A6), the shape chosen by the timer
; (+$4C) and the ejection's step (+$7C).
;-------------------------------------------------------------------------------
DrawParachute:
        lea.l   (ObjectTable).l,a1              ; 00B72
        adda.w  (CurrentObjectOffset).l,a1      ; 00B78
        lea.l   (RescuePodModel).l,a0           ; 00B7E
        move.w  obj_Timer(a1),d0                ; 00B84
        ble.b   l_016_00BD4                     ; 00B88
        ori.b   #$1,obj_Ejection(a1)            ; 00B8A
        cmpi.w  #$5,d0                          ; 00B90
        bge.w   l_016_00C10                     ; 00B94
        cmpi.w  #$1,d0                          ; 00B98
        beq.b   l_016_00BBC                     ; 00B9C
        cmpi.w  #$2,d0                          ; 00B9E
        beq.b   l_016_00BBC                     ; 00BA2
        move.l  #RescuePod_002C6,(ShapeNow).l   ; 00BA4
        move.l  #RescuePod_002C6,(ShapeNext).l  ; 00BAE
        bra.w   l_016_00AB6                     ; 00BB8
l_016_00BBC:
        move.l  #RescuePod_002D4,(ShapeNow).l   ; 00BBC
        move.l  #RescuePod_002D4,(ShapeNext).l  ; 00BC6
        bra.w   l_016_00AB6                     ; 00BD0
l_016_00BD4:
        blt.b   l_016_00BF8                     ; 00BD4
        move.b  obj_Ejection(a1),d0             ; 00BD6
        andi.b  #$f,d0                          ; 00BDA
        beq.b   l_016_00BF8                     ; 00BDE
        move.l  #Parachute_002A2,(ShapeNow).l   ; 00BE0
        move.l  #Parachute_002A2,(ShapeNext).l  ; 00BEA
        bra.w   l_016_00AB6                     ; 00BF4
l_016_00BF8:
        move.l  #RescuePod_002E2,(ShapeNow).l   ; 00BF8
        move.l  #RescuePod_002E2,(ShapeNext).l  ; 00C02
        bra.w   l_016_00AB6                     ; 00C0C
l_016_00C10:
        move.l  #RescuePodModel,(ShapeNow).l    ; 00C10
        move.l  #RescuePodModel,(ShapeNext).l   ; 00C1A
        bra.w   l_016_00AB6                     ; 00C24

;-------------------------------------------------------------------------------
; NoDraw - Does nothing (an object that is not drawn).
;-------------------------------------------------------------------------------
NoDraw:
        rts                                     ; 00C28
	dc.b	$00,$00
h016_end:
	ifnd	HUNKEXE				; the hunk's tables, as in the original file
	dc.l	HUNK_RELOC32
        dc.l    14,16                           ; 14 longs pointing into hunk 16
	dc.l	$12C,$118,$104,$F0,$DC,$C8,$B4,$A0
	dc.l	$8C,$78,$64,$50,$3C,$28
        dc.l    39,69                           ; 39 longs pointing into hunk 69
	dc.l	$7E8,$7EC,$7F0,$7AC,$7B0,$7B4,$34C,$350
	dc.l	$354,$338,$33C,$340,$7D4,$7D8,$7DC,$324
	dc.l	$328,$32C,$7C0,$7C4,$7C8,$310,$314,$318
	dc.l	$2D4,$2D8,$2DC,$2FC,$300,$304,$2E8,$2EC
	dc.l	$2F0,$734,$738,$73C,$720,$724,$728
        dc.l    12,56                           ; 12 longs pointing into hunk 56
	dc.l	$A68,$A6C,$A70,$7FC,$800,$804,$810,$814
	dc.l	$818,$504,$508,$50C
        dc.l    15,43                           ; 15 longs pointing into hunk 43
	dc.l	$43C,$440,$444,$428,$42C,$430,$3EC,$3F0
	dc.l	$3F4,$6E4,$6E8,$6EC,$540,$544,$548
        dc.l    6,44                            ; 6 longs pointing into hunk 44
	dc.l	$414,$418,$41C,$400,$404,$408
        dc.l    21,42                           ; 21 longs pointing into hunk 42
	dc.l	$478,$47C,$480,$464,$468,$46C,$450,$454
	dc.l	$458,$6D0,$6D4,$6D8,$3D8,$3DC,$3E0,$3C4
	dc.l	$3C8,$3CC,$518,$51C,$520
        dc.l    78,70                           ; 78 longs pointing into hunk 70
	dc.l	$A54,$A58,$A5C,$A40,$A44,$A48,$A2C,$A30
	dc.l	$A34,$A18,$A1C,$A20,$A04,$A08,$A0C,$9F0
	dc.l	$9F4,$9F8,$9B4,$9B8,$9BC,$9C8,$9CC,$9D0
	dc.l	$9DC,$9E0,$9E4,$9A0,$9A4,$9A8,$98C,$990
	dc.l	$994,$978,$97C,$980,$8C4,$8C8,$8CC,$964
	dc.l	$968,$96C,$950,$954,$958,$93C,$940,$944
	dc.l	$928,$92C,$930,$914,$918,$91C,$900,$904
	dc.l	$908,$8EC,$8F0,$8F4,$8D8,$8DC,$8E0,$8B0
	dc.l	$8B4,$8B8,$89C,$8A0,$8A4,$888,$88C,$890
	dc.l	$84C,$850,$854,$838,$83C,$840
        dc.l    21,54                           ; 21 longs pointing into hunk 54
	dc.l	$874,$878,$87C,$860,$864,$868,$4F0,$4F4
	dc.l	$4F8,$4DC,$4E0,$4E4,$70C,$710,$714,$6F8
	dc.l	$6FC,$700,$4C8,$4CC,$4D0
        dc.l    10,48                           ; 10 longs pointing into hunk 48
	dc.l	$77C,$75C,$760,$764,$748,$74C,$750,$770
	dc.l	$774,$778
        dc.l    26,49                           ; 26 longs pointing into hunk 49
	dc.l	$5C4,$5B0,$658,$65C,$660,$644,$648,$64C
	dc.l	$630,$634,$638,$61C,$620,$624,$608,$60C
	dc.l	$610,$5F4,$5F8,$5FC,$5B8,$5BC,$5C0,$5A4
	dc.l	$5A8,$5AC
        dc.l    28,45                           ; 28 longs pointing into hunk 45
	dc.l	$3A8,$6A8,$6AC,$6B0,$680,$684,$688,$66C
	dc.l	$670,$674,$694,$698,$69C,$784,$788,$78C
	dc.l	$360,$364,$368,$52C,$530,$534,$3B0,$3B4
	dc.l	$3B8,$39C,$3A0,$3A4
        dc.l    12,50                           ; 12 longs pointing into hunk 50
	dc.l	$5E0,$5E4,$5E8,$5CC,$5D0,$5D4,$57C,$580
	dc.l	$584,$388,$38C,$390
        dc.l    9,47                            ; 9 longs pointing into hunk 47
	dc.l	$798,$79C,$7A0,$590,$594,$598,$4A0,$4A4
	dc.l	$4A8
        dc.l    12,46                           ; 12 longs pointing into hunk 46
	dc.l	$568,$56C,$570,$4B4,$4B8,$4BC,$554,$558
	dc.l	$55C,$374,$378,$37C
        dc.l    15,51                           ; 15 longs pointing into hunk 51
	dc.l	$20,$18,$1C,$C,$4,$8,$84,$98
	dc.l	$7C,$80,$90,$94,$48,$40,$44
        dc.l    31,58                           ; 31 longs pointing into hunk 58
	dc.l	$BE2,$BEC,$BFA,$C04,$BBE,$BC8,$BA6,$BB0
	dc.l	$C12,$C1C,$E0,$E4,$E8,$B80,$B2C,$B36
	dc.l	$B44,$B4E,$B14,$B1E,$AFE,$B08,$B5C,$B66
	dc.l	$2C,$30,$34,$108,$10C,$110,$AE0
        dc.l    24,55                           ; 24 longs pointing into hunk 55
	dc.l	$D4,$CC,$D0,$498,$48C,$490,$494,$2C0
	dc.l	$2C4,$2C8,$2AC,$2B0,$2B4,$298,$29C,$2A0
	dc.l	$6C8,$830,$6BC,$6C0,$6C4,$824,$828,$82C
        dc.l    9,57                            ; 9 longs pointing into hunk 57
	dc.l	$70,$124,$138,$68,$6C,$11C,$120,$130
	dc.l	$134
        dc.l    3,41                            ; 3 longs pointing into hunk 41
	dc.l	$5C,$54,$58
        dc.l    4,53                            ; 4 longs pointing into hunk 53
	dc.l	$100,$F4,$F8,$FC
        dc.l    8,52                            ; 8 longs pointing into hunk 52
	dc.l	$B0,$C4,$A4,$A8,$AC,$B8,$BC,$C0
        dc.l    37,12                           ; 37 longs pointing into hunk 12
	dc.l	$2D0,$2F8,$7A8,$2E4,$30C,$320,$334,$348
	dc.l	$7BC,$7D0,$7E4,$834,$848,$884,$898,$8AC
	dc.l	$8C0,$8D4,$8E8,$8FC,$910,$924,$938,$94C
	dc.l	$960,$974,$988,$99C,$9B0,$9C4,$9D8,$9EC
	dc.l	$A00,$A14,$A28,$A3C,$A50
        dc.l    67,10                           ; 67 longs pointing into hunk 10
	dc.l	$53C,$6CC,$0,$14,$AB8,$294,$2A8,$2BC
	dc.l	$398,$3C0,$3D4,$488,$5A0,$5B4,$6B8,$6E0
	dc.l	$76C,$820,$35C,$370,$384,$3AC,$3E8,$3FC
	dc.l	$410,$424,$438,$44C,$460,$474,$49C,$4B0
	dc.l	$4C4,$4D8,$4EC,$500,$514,$528,$550,$564
	dc.l	$578,$58C,$5C8,$5DC,$5F0,$604,$618,$62C
	dc.l	$640,$654,$668,$67C,$690,$6A4,$6F4,$708
	dc.l	$71C,$730,$744,$758,$780,$794,$7F8,$80C
	dc.l	$85C,$870,$A64
        dc.l    1,18                            ; 1 longs pointing into hunk 18
	dc.l	$AB0
        dc.l    26,71                           ; 26 longs pointing into hunk 71
	dc.l	$A80,$ADA,$B7A,$A7A,$AD4,$B74,$B0C,$B22
	dc.l	$B3A,$B52,$B6A,$BB4,$BCC,$BF0,$C08,$C20
	dc.l	$B02,$B18,$B30,$B48,$B60,$BAA,$BC2,$BE6
	dc.l	$BFE,$C16
	dc.l	0
	dc.l	HUNK_END
	endc
