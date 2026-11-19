; F/A-18 Interceptor - hunk 2 (bss)
; Included by ../f18_main.s.

;===============================================================================
; Hunk 2: BSS, $2A04 bytes
;===============================================================================
	BSS_HUNK	h002
; _IntuitionBase - intuition.library (opened only to close the Workbench screen).
_IntuitionBase:
        ds.b    $4                              ; 00000
dat_002_00004:
        ds.b    $4                              ; 00004
dat_002_00008:
        ds.b    $4                              ; 00008
dat_002_0000C:
        ds.b    $4                              ; 0000C
; GameView - The game's View.
GameView:
        ds.b    $4                              ; 00010
dat_002_00014:
        ds.b    $E                              ; 00014
; GameViewPort - The game's ViewPort (320 x 200).
GameViewPort:
        ds.b    $4                              ; 00022
dat_002_00026:
        ds.b    $4                              ; 00026
dat_002_0002A:
        ds.b    $10                             ; 0002A
dat_002_0003A:
        ds.b    $2                              ; 0003A
dat_002_0003C:
        ds.b    $2                              ; 0003C
dat_002_0003E:
        ds.b    $2                              ; 0003E
dat_002_00040:
        ds.b    $6                              ; 00040
dat_002_00046:
        ds.b    $4                              ; 00046
; GameColorMap - The ViewPort's ColorMap.
GameColorMap:
        ds.b    $4                              ; 0004A
dat_002_0004E:
        ds.b    $4                              ; 0004E
dat_002_00052:
        ds.b    $4                              ; 00052
dat_002_00056:
        ds.b    $2                              ; 00056
dat_002_00058:
        ds.b    $2                              ; 00058
; GameBitMap1 - The display's BitMap (5 planes, 320 x 200).
GameBitMap1:
        ds.b    $4                              ; 0005A
; GameBitMap2 - The second BitMap (4 planes, 320 x 200).
GameBitMap2:
        ds.b    $4                              ; 0005E
; BitMap1 - The display BitMap's structure.
BitMap1:
        ds.b    $28                             ; 00062
; BitMap2 - The second BitMap's structure.
BitMap2:
        ds.b    $28                             ; 0008A
dat_002_000B2:
        ds.b    $4                              ; 000B2
dat_002_000B6:
        ds.b    $4                              ; 000B6
dat_002_000BA:
        ds.b    $4                              ; 000BA
dat_002_000BE:
        ds.b    $4                              ; 000BE
; _GfxBase - graphics.library.
_GfxBase:
        ds.b    $4                              ; 000C2
dat_002_000C6:
        ds.b    $4                              ; 000C6
; GameRastPort1 - The RastPort of BitMap1.
GameRastPort1:
        ds.b    $4                              ; 000CA
dat_002_000CE:
        ds.b    $60                             ; 000CE
; GameRastPort2 - The RastPort of BitMap2.
GameRastPort2:
        ds.b    $4                              ; 0012E
dat_002_00132:
        ds.b    $60                             ; 00132
dat_002_00192:
        ds.b    $F02                            ; 00192
dat_002_01094:
        ds.b    $800                            ; 01094
dat_002_01894:
        ds.b    $800                            ; 01894
dat_002_02094:
        ds.b    $800                            ; 02094
; PictureColours - The colours read from a picture's CMAP (32 RGB4 words).
PictureColours:
        ds.b    $40                             ; 02894
; TitleBitMap - The title picture's BitMap (pix/splsh).
TitleBitMap:
        ds.b    $4                              ; 028D4
; TitleBMHD - The title picture's BMHD (20 bytes: width.w, height.w ...).
TitleBMHD:
        ds.b    $2                              ; 028D8
dat_002_028DA:
        ds.b    $12                             ; 028DA
dat_002_028EC:
        ds.b    $4                              ; 028EC
dat_002_028F0:
        ds.b    $4                              ; 028F0
dat_002_028F4:
        ds.b    $4                              ; 028F4
dat_002_028F8:
        ds.b    $4                              ; 028F8
dat_002_028FC:
        ds.b    $4                              ; 028FC
; PanelBitMap - The instrument panel picture's BitMap (pix/inst5, 320 x 55).
PanelBitMap:
        ds.b    $4                              ; 02900
; PanelBMHD - The instrument panel picture's BMHD.
PanelBMHD:
        ds.b    $2                              ; 02904
dat_002_02906:
        ds.b    $12                             ; 02906
dat_002_02918:
        ds.b    $4                              ; 02918
dat_002_0291C:
        ds.b    $4                              ; 0291C
dat_002_02920:
        ds.b    $4                              ; 02920
dat_002_02924:
        ds.b    $8                              ; 02924
dat_002_0292C:
        ds.b    $4                              ; 0292C
; FrontBitMap - The front picture's BitMap (pix/frnt5, 288 x 12).
FrontBitMap:
        ds.b    $4                              ; 02930
; FrontBMHD - The front picture's BMHD.
FrontBMHD:
        ds.b    $2                              ; 02934
dat_002_02936:
        ds.b    $12                             ; 02936
dat_002_02948:
        ds.b    $4                              ; 02948
dat_002_0294C:
        ds.b    $4                              ; 0294C
dat_002_02950:
        ds.b    $4                              ; 02950
dat_002_02954:
        ds.b    $4                              ; 02954
dat_002_02958:
        ds.b    $4                              ; 02958
dat_002_0295C:
        ds.b    $4                              ; 0295C
dat_002_02960:
        ds.b    $4                              ; 02960
dat_002_02964:
        ds.b    $4                              ; 02964
dat_002_02968:
        ds.b    $4                              ; 02968
; ConfigBuffer - The pilot's flight log (df0:config, 78 bytes; disk/FILES.md has its fields):
; +$02 copied to dat_071_00277, +$08 the accumulated flight time in seconds, +$36 missions
; started, +$38 missions completed, +$3A/+$3C cannon rounds fired/hits, +$3E/+$40 AMRAAMs
; fired/hits, +$42/+$44 Sidewinders fired/hits, +$46 crashes, +$48 hits from missiles.
ConfigBuffer:
        ds.b    $4                              ; 0296C
dat_002_02970:
        ds.b    $2                              ; 02970
dat_002_02972:
        ds.b    $2                              ; 02972
dat_002_02974:
        ds.b    $1                              ; 02974
dat_002_02975:
        ds.b    $1                              ; 02975
dat_002_02976:
        ds.b    $2                              ; 02976
dat_002_02978:
        ds.b    $2                              ; 02978
dat_002_0297A:
        ds.b    $2                              ; 0297A
dat_002_0297C:
        ds.b    $8                              ; 0297C
dat_002_02984:
        ds.b    $1                              ; 02984
dat_002_02985:
        ds.b    $1                              ; 02985
dat_002_02986:
        ds.b    $4                              ; 02986
dat_002_0298A:
        ds.b    $E                              ; 0298A
dat_002_02998:
        ds.b    $4                              ; 02998
dat_002_0299C:
        ds.b    $4                              ; 0299C
dat_002_029A0:
        ds.b    $4                              ; 029A0
dat_002_029A4:
        ds.b    $4                              ; 029A4
dat_002_029A8:
        ds.b    $2                              ; 029A8
dat_002_029AA:
        ds.b    $16                             ; 029AA
dat_002_029C0:
        ds.b    $2                              ; 029C0
dat_002_029C2:
        ds.b    $4                              ; 029C2
dat_002_029C6:
        ds.b    $4                              ; 029C6
dat_002_029CA:
        ds.b    $16                             ; 029CA
dat_002_029E0:
        ds.b    $4                              ; 029E0
dat_002_029E4:
        ds.b    $4                              ; 029E4
dat_002_029E8:
        ds.b    $8                              ; 029E8
dat_002_029F0:
        ds.b    $1                              ; 029F0
dat_002_029F1:
        ds.b    $1                              ; 029F1
dat_002_029F2:
        ds.b    $8                              ; 029F2
dat_002_029FA:
        ds.b    $4                              ; 029FA
dat_002_029FE:
        ds.b    $2                              ; 029FE
dat_002_02A00:
        ds.b    $4                              ; 02A00
h002_end:
	ifnd	HUNKEXE
	section	bin,code			; (back from the offset section)
	org	0
	dc.l	HUNK_END
	endc
