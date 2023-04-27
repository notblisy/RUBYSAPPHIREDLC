INCLUDE "../macros.asm"
INCLUDE "../constants/items.asm"
INCLUDE "../constants/scriptcommandskyogre.asm"

	Mystery_Event

	db CHECKSUM_CRC
	dd 0 ; checksum placeholder
	GBAPTR DataStart
	GBAPTR DataEnd

DataStart:
	db IN_GAME_SCRIPT
	db 24,26 ; Underwater
	db 2   ; Middle of Submarine
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

	Text_EN "Something ANCIENT beneath the sea is\n"
	Text_EN "disturbing the Sumbarine Explorer 1...@"



NormanScriptStart:
	setvirtualaddress NormanScriptStart

		   checkitemroom BLUE_ORB, 1

		   compare LASTRESULT, 0

		   virtualgotoif 1, NoRoomToGive



		   setwildbattle $194, $46, $00C6

		   copyvarifnotzero $8000, BLUE_ORB

		   copyvarifnotzero $8001, 1

		   checkitemtype $0002

		   callstd 1

		   closeonkeypress
		   
		   fadeout $3
		  

		   setvar $8004, $000F

	   	   setvar $8005, $000F

		   setvar $8006, $0FF3

		   setvar $8007, $000F

		   special $131
	 	   
		   sound $D8

		   pause $28

	      	   sound $D8

 		   virtualmsgbox Ancient
		   
	      	   sound $D8


		   waitmsg

	      	   sound $D8

		   waitkeypress

		   release

		   callasm $2028E59
		   
		   callasm $2028E71

		   playmoncry $194, $0

		   virtualmsgbox Kyogre

		   waitmsg

		   waitmoncry

		   waitkeypress

		   release
		   
		   special $119

		   sound $6B

		   waitstate

		   pause $70

		   special $138
		
		   playsong $01CF, $0




		   setflag $81
	
		   setflag $03D4
		
		   
                  	   

.delete_script
	killscript


		

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

	Text_EN "The KEY ITEMS Pocket in your Bag\n"
	Text_EN "is full.@"

Kyogre:
	Text_DE "Lauf und besuche deinen Vater in der@"

	Text_EN "Kyogre: Gyararoooah!@"

Ancient:
	Text_DE "Lauf und besuche deinen Vater in der@"

	Text_EN "A Super Ancient Pokémon is\n"
	Text_EN "reacting with the BLUE ORB!@"





NormanScriptEnd:


PreloadScriptStart:
	setvirtualaddress PreloadScriptStart

		   checkitem BLUE_ORB, 1

		   compare LASTRESULT, 1

		   virtualgotoif 1, .ineligible

		   checkpcitem BLUE_ORB, 1

		   compare LASTRESULT, 1

		   virtualgotoif 1, .ineligible

		   checkflag $123

		   virtualgotoif 0, .defeated
		   

		   clearflag $81
	
		   clearflag $03D4

		   virtualloadpointer GoSeeYourFather

		   setbyte 2

		   end

.ineligible
	virtualloadpointer RubyVersion
	setbyte 3
	end

.defeated
	virtualloadpointer Elite4
	setbyte 3
	end

RubyVersion:
	Text_EN "This event is only for Pokémon RUBY\n""
	Text_EN "and can only be played once.@""

	Text_DE "Deine BASIS-TASCHE ist voll\n"
	Text_DE "Deine BASIS-TASCHE ist voll.@"

Elite4:
	Text_EN "You must have defeated the\n"
	Text_EN "Elite 4 to play this event.@"

	Text_DE "Deine BASIS-TASCHE ist voll\n"
	Text_DE "Deine BASIS-TASCHE ist voll.@"

DataEnd:
	EOF
  	