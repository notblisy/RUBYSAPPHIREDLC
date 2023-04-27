	API_106 $0040, UNKNOWN_VALUE

.asm_1bfe
	waita $01

	ld hl, Space_3
	API $0C8

	or a
	jr nz, .asm_1c18

	IS_SOUND_PLAYING 1 ; return

.asm_1c18
	LD_HL_IND Space_3
	LD_IND_HL Space_4
	ld a, l
	cp $22
	jr nz, .asm_1bfe

	ld a, h
	cp $22
	jr nz, .asm_1bfe

	ld de, 60 ; transfer length
	ld hl, Prologue
	call TransferData

	ld de, DATA_TRANSFER_LENGTH ; transfer length
	ld hl, DataPacket
	call TransferData