; some Z80 opcodes aren’t supported by Game Boy, 
; but are used in e-Reader programs

; ld [\1], hl
LD_IND_HL: MACRO
	db $22, (\1 & $FF), (\1 >> 8)
	ENDM
; ld [\1], a
LD_IND_A: MACRO
	db $32, (\1 & $FF), (\1 >> 8)
	ENDM

; ld hl, [\1]
LD_HL_IND: MACRO
	db $2A, (\1 & $FF), (\1 >> 8)
	ENDM
; ld a, [\1]
LD_A_IND: MACRO
	db $3A
	dw \1
	ENDM

waita: MACRO
	ld a, \1
	db $76
	ENDM
; ld [hl], a
LD_IND_HL_A: MACRO
	db $77
	ENDM

; ld a, [hl]
LD_IND_A_HL: MACRO
	db $7E
	ENDM

; ld c, [hl]
LD_IND_C_HL: MACRO
	db $4E
	ENDM

; ld b, [hl]
LD_IND_B_HL: MACRO
	db $46
	ENDM

; ld l, [hl]
LD_IND_L_HL: MACRO
	db $6E
	ENDM

; ld e, [hl]
LD_IND_E_HL: MACRO
	db $5E
	ENDM

; ld d, [hl]
LD_IND_D_HL: MACRO
	db $56
	ENDM

; ld [hl], c
LD_IND_HL_C: MACRO
	db $71
	ENDM

; ld [hl], b
LD_IND_HL_B: MACRO
	db $70
	ENDM

; ld a, [de]
LD_IND_A_DE: MACRO
	db $1A
	ENDM

; add a, [hl]
ADD_A_HL_IND: MACRO
	db $86
	ENDM

EX_DE_HL: MACRO
	db $EB
	ENDM

wait: MACRO
	db $D3, \1
	ENDM

API: MACRO
	db ($C7 + (\1 & $100) >> 5), (\1 & $FF) ; $C7 for API $0xx, $CF for API $1xx
	ENDM



dd: MACRO
	dw (\1) & $FFFF
	dw (\1) >> 16
	ENDM

RGB: MACRO
	dw (\1) | ((\2) << 5) | ((\3) << 10)
	ENDM

GBAPTR: MACRO
	dd $02000000 + \1 - ScriptBaseAddress
	ENDM

Insert_Prologue: MACRO
	db "GameFreak inc."
	db 0,0,0,0,0,0
	dd \1
	db \2
	REPT 8 - STRLEN(\2)
		db 0
	ENDR
	db 0,0,0,0,$01,$55
	db 0,0,0,0
	db \3
	db 0
	db "GameFreak inc."
	db 0,0
	ENDM

Mystery_Event: MACRO
ScriptBaseAddress EQU $100
	SECTION "mysteryevent", ROM0[$100]
	db $01
	dd $02000000
	db REGION,0,REGION,0,0,0,$04,0,$80,$01,0,0
	ENDM

REGION_JP EQU $01
REGION_EN EQU $02
REGION_FR EQU $03 ; ?
REGION_IT EQU $04 ; ?
REGION_DE EQU $05 ; !
REGION_ES EQU $07 ; ¿?

; types of card data
END_OF_CHUNKS    EQU $02
LOADING_MESSAGE  EQU $03
SET_LOAD_STATUS  EQU $04
PRELOAD_SCRIPT   EQU $05
IN_GAME_SCRIPT   EQU $06
CUSTOM_BERRY     EQU $07
AWARD_RIBBON     EQU $08
NATIONAL_POKEDEX EQU $09
ADD_RARE_WORD    EQU $0A
MIX_RECORDS_ITEM EQU $0B
GIVE_POKEMON     EQU $0C
BATTLE_TRAINER   EQU $0D
CLOCK_ADJUSTMENT EQU $0E
CHECKSUM_BYTES   EQU $0F ; don’t use this
CHECKSUM_CRC     EQU $10 ; use this instead
DOME_TRAINER     EQU $11 ; Battle Dome trainer

; an FF byte followed by 00s will flag the end of the program so that it can
; be extracted automatically from the Game Boy ROM that rgbds tries to build
EOF: MACRO
	db $FF
	ENDM


; names for some API functions based on Martin Korth’s GBATEK
; http://problemkaputt.de/gbatek.htm
FadeIn: MACRO
	ld a, \1
	API $000
	ENDM
SetBackgroundAutoScroll: MACRO
	ld bc, \1
	ld de, \2
	xor a
	API $012
	ENDM
SetBackgroundMode: MACRO
	ld e, \1
	push de
	xor a
	API $019
	ENDM
API_02C: MACRO
	ld hl, $0000
	push hl
	ld bc, \1
	ld de, \2
	IF \3 == 0
		xor a ; save a byte
	ELSE
		ld a, \3
	ENDC
	API $02C
	ENDM
LoadCustomBackground: MACRO
	ld de, \1
	IF \2 == 0
		xor a ; save a byte
	ELSE
		ld a, \2
	ENDC
	API $02D
	ENDM
SetSpritePos: MACRO
	ld bc, \3
	ld de, \2
	LD_HL_IND \1
	API $032
	ENDM
SpriteShow: MACRO
	LD_HL_IND \1
	API $046
	ENDM
SpriteHide: MACRO
	LD_HL_IND \1
	API $047
	ENDM
SpriteMirrorToggle: MACRO
	ld e, \1
	LD_HL_IND \2
	API $048
	ENDM
CreateCustomSprite: MACRO
	ld e, \2
	ld hl, \3
	API $04D
	LD_IND_HL \1
	ENDM
SpriteAutoScaleUntilSize: MACRO
	ld c, \2
	ld de, \3
	LD_HL_IND \1
	API $05B
	ENDM
SetBackgroundPalette: MACRO
	ld c, \1
	ld de, \2
	ld hl, \3
	API $07E
	ENDM
API_084: MACRO
	ld l, \4
	push hl
	ld bc, \3
	ld de, \2
	LD_HL_IND \1
	API $084
	ENDM
CreateRegion: MACRO
	ld bc, (\2 << 8 + \3)
	ld de, (\4 << 8 + \5)
	ld hl, (\6 << 8 + \7)
	API $090
	LD_IND_A \1
	ENDM
SetRegionColor: MACRO
	ld e, \2
	LD_A_IND \1
	API $091
	ENDM
CLEAR_REGION: MACRO
	LD_A_IND \1
	API $092
	ENDM
SetTextColor: MACRO
	ld de, (\2 << 8 + \3)
	LD_A_IND \1
	API $098
	ENDM
DrawText: MACRO
	CLEAR_REGION \1
	ld bc, \2
	ld de, (\3 << 8 + \4)
	LD_A_IND \1
	API $099
	ENDM
SetTextSize: MACRO
	API $09A
	ENDM
API_09B: MACRO
	ld de, \2
	LD_A_IND \1
	API $09B
	ENDM
GetTextWidth: MACRO
	ld de, \2
	LD_A_IND \1
	API $0C0
	ENDM
API_0C7: MACRO
	ld hl, \1
	API $0C7
	ENDM
EXIT: MACRO
	API $100
	ENDM
API_106: MACRO
	ld de, \1
	ld hl, \2
	API $106
	ENDM
SOUND_PAUSE: MACRO
	API $116
	ENDM
IS_SOUND_PLAYING: MACRO
	API $08D
	ld b, $00
	ld e, $01
	ld hl, $0006
	API $119
	ld a, \1
	EXIT
	ENDM
API_121: MACRO
	ld de, $0000
	ld hl, $0000
	API $121
	ENDM