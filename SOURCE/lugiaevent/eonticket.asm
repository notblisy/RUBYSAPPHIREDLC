INCLUDE "../macros.asm"
INCLUDE "../constants/items.asm"
INCLUDE "../constants/scriptcommandslugia.asm"

	Mystery_Event

	db CHECKSUM_CRC
	dd 0 ; checksum placeholder
	GBAPTR DataStart
	GBAPTR DataEnd

DataStart:
	db IN_GAME_SCRIPT
	db 24,66 ; Abandoned Ship
	db 4   ; item in bottom right room
	GBAPTR NormanScriptStart
	GBAPTR NormanScriptEnd



	db MIX_RECORDS_ITEM
	db 1  ; ???
IF REGION == REGION_DE
	db 5  ; distribution limit from German debug ROM
ELSE
	db 30 ; distribution limit from English release
ENDC
	dw EON_TICKET



	db PRELOAD_SCRIPT
	GBAPTR PreloadScriptStart

	db END_OF_CHUNKS


GoSeeYourFather:
	Text_DE "Lauf und besuche deinen Vater in der\n"
	Text_DE "ARENA von BLÜTENBURG CITY.@"

	Text_EN "The ABANDONED SHIP has been rumbling.\n"
	Text_EN "A powerful Pokémon has moved in.@"



NormanScriptStart:
	setvirtualaddress NormanScriptStart

		   checkitemroom TM04, 1

		   compare LASTRESULT, 0

		   virtualgotoif 1, NoRoomToGive




		   setwildbattle $F9, $46, $0061
		   
		   copyvarifnotzero $8000, TM04

		   copyvarifnotzero $8001, 1

		   checkitemtype $0004

		   callstd 1

		   closeonkeypress

		   fadeout $3
		   
		   playmoncry $F9, $0

		   virtualmsgbox Lugia

		   waitmsg

		   waitkeypress

		   release

		   waitmoncry	
		
		   setvar $8004, $000F

	   	   setvar $8005, $000F

		   setvar $8006, $0FF3

		   setvar $8007, $000F

		   special $13B
	 	   
		   sound $5E

		   waitstate

		   pause $28

		   special $13B



		   waitstate

		   pause $28

		   special $13B



		   waitstate

		   pause $28

		   callasm $2028E57
		   
		   callasm $2028E6D
		
		   callasm $2028E85
		   
		   special $119

		   sound $6B

		   waitstate

		   pause $28

		   special $139
		
		   playsong $0166, $0


		
		   
                  	   

.delete_script
	killscript


		
		   EVENTLEGAL2
		   METLOCATION
		   GAMEORIGIN


NoRoomToGive:
		   virtualmsgbox ItemsPocketIsFull
		   waitmsg
		   waitkeypress
		   release
		   end



ItemsPocketIsFull:
	Text_DE "Lauf und besuche deinen Vater in der\n"
	Text_DE "ARENA von BLÜTENBURG CITY.@"

	Text_EN "The TMs Pocket in your Bag\n"
	Text_EN "is full.@"

Lugia:
	Text_DE "Lauf und besuche deinen Vater in der@"

	Text_EN "LUGIA: Gyaaas!@"






NormanScriptEnd:


PreloadScriptStart:
	setvirtualaddress PreloadScriptStart
	
		   clearflag $044D

		   virtualloadpointer GoSeeYourFather

		   setbyte 2

		   end





DataEnd:
	EOF
  	