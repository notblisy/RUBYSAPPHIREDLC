WordShiftRight:
	; this function shifts HL by B bits to the right
	inc b
.asm_1B93
	dec b
	ret z
	
	and a
	ld a, h
	rra
	ld h, a 
	ld a, l
	rra
	ld l, a
	jp .asm_1B93