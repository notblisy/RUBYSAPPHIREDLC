INCLUDE "../macros.asm"
SECTION "eonticket",ROM0[$100]
jp Start
db $00

TicketSprite: ; 104
	INCBIN "hoohtest.bin"
TicketPalette: ; 1604
	INCBIN "hoohtestpal.bin"

Prologue:
	INCBIN "prologue-{REGION_NAME}.bin"

DataPacket: ; 164a
	INCBIN "eonticket-{REGION_NAME}.mev"
	db 0,0,0 ; padding

INCLUDE "../common/mem_struct.asm"

SpriteData:
	dw TicketSprite,TicketPalette
	db $06,$06,$00,$00,$01,$01,$01 ; width 15, height 8

Instructions1: ; 1921
	db "Link e-Reader to Pokémon Ruby or \n"
	db "Sapphire and select MYSTERY EVENTS\n"
	db "on the game's main menu.\n"
	db "Press the B Button to cancel.\0"

Instructions2: ; 199d
	db "Press the A Button on the Game Boy\n"
	db "Advance containing Pokémon Ruby or\n"
	db "Sapphire to begin sending the\n"
	db "Ho-Oh EVENT.\0"

DeliveryInProcess: ; 1a0d
	db "Ho-Oh EVENT delivery in Progress...\0"

TicketDelivered: ; 1a2f
	db "Ho-Oh EVENT delivered!\n"
	db "\n"
	db "Press the A Button to resend.\n"
	db "Press the B Button to cancel.\0"

; this function is subtly different than the one
; on the Battle e cards, for no apparent reason
TransferData:
	LD_IND_HL SomeVar1
	push de
	ld hl, $bbbb
	LD_IND_HL Space_1
	EX_DE_HL
	LD_IND_HL Space_2
	API_0C7 Space_1

	wait $01
	pop hl
	inc hl
	ld b, $01
	call WordShiftRight

	LD_IND_HL SomeVar2
.asm_1aa1
	LD_HL_IND SomeVar2
	ld a, l
	or h
	ret z

	ld hl, $8888
	LD_IND_HL Space_1
	ld e, $01

.asm_1aaf
	ld a, e
	cp $08
	jr nc, .asm_1ad9

	push de
	LD_HL_IND SomeVar1
	ld c, [hl]
	inc hl
	ld b, [hl]
	inc hl
	LD_IND_HL SomeVar1
	ld l, e
	ld h, $00
	add hl, hl
	ld de, Space_1
	add hl, de
	ld [hl], c
	inc hl
	ld [hl], b
	pop de
	LD_HL_IND SomeVar2
	dec hl
	LD_IND_HL SomeVar2
	ld a, l
	or h
	jr z, .asm_1ad9

	inc e
	jr .asm_1aaf

.asm_1ad9
	API_0C7 Space_1
	wait $01
	jr .asm_1aa1

Start: ; 1ae2
	API_121

	CreateCustomSprite SpriteHandlePtr, $80, SpriteData
	SetSpritePos SpriteHandlePtr, 120, 64
	SpriteHide SpriteHandlePtr

	CreateRegion RegionHandlePtr, 30, 6, 0, 14, 0, 4

	ld h, a
	ld l, $00
	SetTextSize

	API_09B RegionHandlePtr, $0102
	SetTextColor RegionHandlePtr, 2, 0
	SetRegionColor RegionHandlePtr, 0
	SetBackgroundPalette 16, $0040, TicketPalette

	FadeIn 16
	wait 16

	API $0C6

	DrawText RegionHandlePtr, Instructions1, 8, 4
	API $08D

INCLUDE "../common/wait_for_link.asm"

	SpriteShow SpriteHandlePtr

	DrawText RegionHandlePtr, Instructions2, 8, 4
	API $08D

	ld a, b
	nop

UNKNOWN_VALUE EQU $0078
INCLUDE "../common/wait_for_ready.asm"

	DrawText RegionHandlePtr, DeliveryInProcess, 8, 4

DATA_TRANSFER_LENGTH EQU 6144
INCLUDE "../common/transfer_data.asm"
	ld hl, $5fff
	LD_IND_HL Space_1
	API_0C7 Space_1

	wait $80

	SpriteHide SpriteHandlePtr

	DrawText RegionHandlePtr, TicketDelivered, 8, 4

	API $08D
	ld c, a
	nop

INCLUDE "../common/wrap_up.asm"

INCLUDE "../common/word_shift_right.asm"

SomeVar1: ; 1CA2
	db $FF,0 ; mark EOF
RegionHandlePtr: db 0 ; 1CA4
SpriteHandlePtr: db 0,0 ; 1CA5
SomeVar2: db 0,0 ; 1CA7