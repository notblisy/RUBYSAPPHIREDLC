.asm_1baf
	waita $01
	API $0DB

	ld l, a
	ld h, $00
	LD_IND_HL Space_5
	API $0CA

	cp $02
	jr nc, .asm_1bd4

	ld hl, UNKNOWN_VALUE
	SOUND_PAUSE

	IS_SOUND_PLAYING 1 ; return

.asm_1bd4
	LD_HL_IND Space_5
	ld a, l
	sub $04
	or h
	jr z, .asm_1be6

	LD_HL_IND Space_5
	ld a, l
	sub $03
	or h
	jr nz, .asm_1baf
.asm_1be6