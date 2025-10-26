INCLUDE "../macros.asm"
SECTION "prologue", ROM0[$100]

	db "GameFreak inc."
	db 0,0,0,0,0,0
	dd 0
	Text "e reader" ; no string terminator
	db 0,0,0,0,$01,$55
	db 0,0,0,0
	db REGION
	db 0
	db "GameFreak inc."
	db 0,0

	EOF