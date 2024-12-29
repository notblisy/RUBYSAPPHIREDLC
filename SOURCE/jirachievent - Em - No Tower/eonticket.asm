INCLUDE "../macros.asm"
INCLUDE "../constants/items.asm"
INCLUDE "../constants/scriptcommandsjirachibattleemeraldnotower.asm"

	Mystery_Event

	db CHECKSUM_CRC
	dd 0 ; checksum placeholder
	GBAPTR DataStart
	GBAPTR DataEnd

DataStart:
	db IN_GAME_SCRIPT
	db 0,6 ; mossdeep
	db 8   ; girl near rock
	GBAPTR NormanScriptStart
	GBAPTR NormanScriptEnd


	db PRELOAD_SCRIPT
	GBAPTR PreloadScriptStart

	db END_OF_CHUNKS



PreloadScriptStart:
	setvirtualaddress PreloadScriptStart

	callasm $0201C045
	
	virtualloadpointer GoSeeYourFather
	
	setbyte 2
	
	dw $0000
	
	end

	WriteFlashMemory


JirachiScriptStart:
	setvirtualaddress JirachiScriptStart
		   db $5A

	           virtualmsgbox Wish

		   waitmsg

		   db $6E, $17, $8

	           release

	   	   compare LASTRESULT, 0

		   virtualgotoif 5, checkspot

Changemind:
	virtualmsgbox Change
	waitmsg
	waitkeypress
	release
	end	   
	db $00
	db $00
	db $00
	db $00


			   CHANNELRNG
			   STORAGETABLE
			   TEMPJIRACHI2
			   STRUCTURETABLEG
			   MEMCOPYJIRACHI
			   RETURN
			   FIXJIRACHIANDCOPY
			   CAPTUREJIRACHI
			   FINALSTORAGE
			   MOVEPLAYERDOWNRIGHT
			   MOVEPLAYERRIGHTFACEUP
			   MOVEPLAYERQUESTION
			   db $00
			   TEMPJIRACHI
			   MOVEPLAYERLEFTFACEUP
			   
checkspot:

	           virtualmsgbox Youdo

		   waitmsg

		   waitkeypress

		   release

		   db $43

		   compare LASTRESULT, 5

		   virtualgotoif 2, NoRoom

		   copyvar $800B, $800D
		   
		   getplayerpos $8000, $8001
		
		   compare $8000, $37

		   virtualgotoif 5, Movement1

Movement0:

		   
                   applymovement $FF, $0203ADE0

                   waitmovement $FF

Movement1:



                   applymovement $FF, $0203ADE3

battle:
                   waitmovement $FF

		   pause $10

		   special $13D	   

		   sound $83

		   pause $10

		   pause $10

                   applymovement $FF, $0203ade8

                   waitmovement $FF

		   sound $15
		   setwildbattle $F4, $30, $00

		   virtualmsgbox Pokemon

		   waitmsg

		   waitkeypress

		   release

		   playmoncry $199, $0

		   virtualmsgbox Jirachi

		   waitmsg

		   waitkeypress

		   release

		   callasm $0203ABE5 ;Channel RNG

		   callasm $0203AD69 ;FIXJIRACHIANDCOPY

                   waitmoncry

		   special $145
		
		   playsong $01CE, $0

		   waitstate

		   db $43

		   comparevar LASTRESULT, $800B		   
		   
		   virtualgotoif 3, FlewAway


Catch:
                   callasm $0203AD9D
		   killscript


NoRoom:
	virtualmsgbox NoSpace
	waitmsg
	waitkeypress
	release
	end


FlewAway:

	db $97, $01
	db $97, $00
	virtualmsgbox Flew
	waitmsg
	waitkeypress
	release
	applymovement $FF, $0203AE3C
         waitmovement $FF
	end

Wish:
	Text_EN "Do you have a wish?@"

Youdo:
	Text_EN "You do? Then leave a wish tag\n"
	Text_EN "on the WHITE ROCK!@"
Change:
	Text_EN "Really? I thought everyone had\n"
	Text_EN "a wish...@"
Flew:
        Text_EN "The JIRACHI flew away!@"
NoSpace:
	Text_EN "You can’t make wish\n"
	Text_EN "with a full party!@"

Pokemon:
	Text_EN "Huh? A POKéMON?@"
Jirachi:
	Text_EN "Wiish!@"

GoSeeYourFather:
	Text_EN "The WHITE ROCK in MOSSDEEP has\n"
	Text_EN "been glowing...@"


NormanScriptStart:
	setvirtualaddress NormanScriptStart
	
		
	writebytetoaddr $1E, $2024744
	writebytetoaddr $20, $2024745
	writebytetoaddr $01, $2024746
	writebytetoaddr $49, $2024747
	writebytetoaddr $01, $2024748
	writebytetoaddr $4B, $2024749
	writebytetoaddr $18, $202474A
	writebytetoaddr $47, $202474B
	writebytetoaddr $BC, $202474C
	writebytetoaddr $AB, $202474D
	writebytetoaddr $03, $202474E
	writebytetoaddr $02, $202474F
	writebytetoaddr $4D, $2024750
	writebytetoaddr $31, $2024751
	writebytetoaddr $15, $2024752
	writebytetoaddr $08, $2024753
	
	callasm $02024745 ;readflash

	goto $0203abbc

NormanScriptEnd:




DataEnd:
	EOF
  	