TransferData:
	LD_IND_HL SomeVar2
	push de
	ld hl, $BBBB
	LD_IND_HL Space_1 ; Space_1 = $BBBB
	EX_DE_HL
	LD_IND_HL Space_2 ; store transfer length in Space_2, which is odd,
	                  ; because we never refer to it again
	API_0C7 Space_1

	wait 1
	pop hl ; number of bytes to transfer

	; calculate number of words to transfer:
	; de = (hl + 1) >> 1
	inc hl
	ld b, 1
	call WordShiftRight
	EX_DE_HL

.asm_18FE
	ld a, e
	or d
	ret z
	; while de > 0…

	ld hl, $8888
	LD_IND_HL Space_1 ; Space_1 = $8888
	ld a, $01
	LD_IND_A SomeVar1 ; SomeVar1 = 1

.asm_190C
	LD_A_IND SomeVar1 ; a = SomeVar1
	cp $08
	jr nc, .asm_193B

	push de
	LD_HL_IND SomeVar2
	ld c, [hl]
	inc hl
	ld b, [hl]
	inc hl
	LD_IND_HL SomeVar2
	ld hl, SomeVar1
	ld l, [hl]
	ld h, $00
	add hl, hl
	ld de, Space_1
	add hl, de
	ld [hl], c
	inc hl
	ld [hl], b
	pop de
	dec de
	ld a, e
	or d
	jr z, .asm_193B

	ld hl, SomeVar1
	ld a, $01
	add a, [hl]
	ld [hl], a
	jr .asm_190C

.asm_193B ; if SomeVar1 > 8
	push de
	API_0C7 Space_1 ; this must be the data transfer? it’s the only API function called

	wait 1
	pop de
	jr .asm_18FE