.asm_1c60
	waita 1

	LD_HL_IND $00C2
	ld a, l
	and $01
	jr z, .asm_1c7c

	; IS_SOUND_PLAYING 1
	API $08D
	dec b ; was this supposed
	nop   ; to be ld b, $00?
	ld e, $01
	ld hl, $0005 ; was this supposed to be $0006?
	API $119
	ld a, $01 ; return
	EXIT

	jr .asm_1c60

.asm_1c7c
	LD_HL_IND $00C2
	ld a, l
	and $02
	jr z, .asm_1c60

	IS_SOUND_PLAYING 2

	jr .asm_1c60