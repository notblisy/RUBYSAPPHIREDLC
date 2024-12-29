INCLUDE "../macros.asm"
INCLUDE "../constants/items.asm"
INCLUDE "../constants/scriptcommandscelebinotowerUnlocked.asm"

	Mystery_Event

	db CHECKSUM_CRC
	dd 0 ; checksum placeholder
	GBAPTR DataStart
	GBAPTR DataEnd

DataStart:
	db IN_GAME_SCRIPT
	db 24,11 ; petalburg gym
	db 2   ; norman
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
	
CelebiScriptStart:
	setvirtualaddress CelebiScriptStart
		db $00
		 dw $0000
	           virtualmsgbox Poor
		   waitmsg
		   db $6E, $17, $8
	           release

		   compare LASTRESULT, 0

		   virtualgotoif 1, Changemind	

		   virtualgotoif 5, CelebiEvent		   
			  			

			   db $00

			   TEMPCELEBI
			   STRUCTURETABLECOMPRESSED
			   LOADSTOREPARTYAMOUNT
			   CelebiRNGAlgo2
	   
   


CelebiEvent:
		   db $43

		   compare LASTRESULT, 5

		   virtualgotoif 2, NoRoom

		   copyvar $800B, $800D

		   setwildbattle $F4, $30, $00

		   callasm $0203AC5D ;Colo RNG 

		   special $13F

		   sound $13
		
		   waitstate

		   playmoncry $FB, $0

		   virtualmsgbox Celebi

		   waitmsg

                   waitmoncry

		   waitkeypress

		   release

		   special $145
		
		   playsong $0166, $0

                    waitmoncry
					
		   waitstate

		   db $43

		   comparevar LASTRESULT, $800B		   
		   
		   virtualgotoif 3, FlewAway

		   virtualgotoif 2, Catch




Catch:
                    callasm $0203AD19
		  killscript



NoRoom:
	virtualmsgbox NoSpace
	waitmsg
	waitkeypress
	release
	end

Changemind:
	virtualmsgbox Change
	waitmsg
	waitkeypress
	release
	end


NoRoomToGive:
	virtualloadpointer PartyFull
	setbyte 3
	killscript		

FlewAway:
	db $97, $01
	db $97, $00
	virtualmsgbox Flew
	waitmsg
	waitkeypress
	release
	end

PartyFull:
	Text_EN "You need space in your party\n"
	Text_EN "to play this MYSTERY EVENT!@"
Poor:
	Text_EN "A Pokemon is rustling around\n"
	Text_EN "in this tree.\p"
	Text_EN "Would you like to investigate?@"
Change:
	Text_EN "Maybe another time.@"
Flew:
    Text_EN "The CELEBI flew away!@"

NoSpace:
	Text_EN "You need space in your party\n"
	Text_EN "to capture CELEBI!@"

Celebi:
	Text_EN "CELEBI: Biyoo!@"

GoSeeYourFather:
	Text_EN "A bright flash was seen in\n"
	Text_EN "PETALBURG WOODS!\p"
	Text_EN "Ever since, a rare Pokemon has\n" 
	Text_EN "been seen healing thin trees.@"



NormanScriptStart:

	
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
  	