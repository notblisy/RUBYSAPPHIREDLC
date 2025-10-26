INCLUDE "../macros.asm"
INCLUDE "../constants/items.asm"
INCLUDE "../constants/scriptcommandsdeoxys.asm"

	Mystery_Event

	db CHECKSUM_CRC
	dd 0 ; checksum placeholder
	GBAPTR DataStart
	GBAPTR DataEnd

DataStart:
	db IN_GAME_SCRIPT
	db 24,3 ; Meteor Falls BF2
	db 1   ; TM02 Item
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

	Text_EN "A Meteorite has crashed in METEOR FALLS.\n"
	Text_EN "Something now lurks in the caverns below..@"



NormanScriptStart:
	setvirtualaddress NormanScriptStart

		   checkitemroom MOON_STONE, 1

		   compare LASTRESULT, 0

		   virtualgotoif 1, NoRoomToGive




		   setwildbattle $19A, $1E, $122
		   
		   copyvarifnotzero $8000, MOON_STONE

		   copyvarifnotzero $8001, 1

		   checkitemtype $0001

		   callstd 1

		   closeonkeypress

		   fadeout $3

		   virtualmsgbox Rumbling

		   waitmsg

		   waitkeypress

		   release

		   setvar $8004, $000F

	   	   setvar $8005, $000F

		   setvar $8006, $0FF3

		   setvar $8007, $000F



		   special $136
	 	   
		   sound $58

		   sound $58

		   waitstate

		   pause $28

		   special $136

		   waitstate

		   pause $28  

		   callasm $2028E49
		   
		   callasm $2028E5F
		
		   callasm $2028E77

		   playmoncry $19A, $0
                  
                   waitmoncry

		   special $138
		
		   playsong $01CF, $0


		
		   
                  	   

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

	Text_EN "The Items Pocket in your Bag\n"
	Text_EN "is full.@"

Rumbling:
	Text_DE "Lauf und besuche deinen Vater in der@"

	Text_EN "What is that rumbling?@"





NormanScriptEnd:


PreloadScriptStart:
	setvirtualaddress PreloadScriptStart
	
		   clearflag $0438

		   virtualloadpointer GoSeeYourFather

		   setbyte 2

		   end





DataEnd:
	EOF
  	