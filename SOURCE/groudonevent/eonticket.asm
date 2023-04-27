INCLUDE "../macros.asm"
INCLUDE "../constants/items.asm"
INCLUDE "../constants/scriptcommandsgroudon.asm"

	Mystery_Event

	db CHECKSUM_CRC
	dd 0 ; checksum placeholder
	GBAPTR DataStart
	GBAPTR DataEnd

DataStart:
	db IN_GAME_SCRIPT
	db 24,13 ; Jagged Pass
	db 3   ; burn heal
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

	Text_EN "Something ANCIENT on JAGGED PASS\n"
	Text_EN "is disturbing the people of LAVARIDGE.@"



NormanScriptStart:
	setvirtualaddress NormanScriptStart

		   checkitemroom RED_ORB, 1

		   compare LASTRESULT, 0

		   virtualgotoif 1, NoRoomToGive



		   setwildbattle $195, $46, $00CB

		   copyvarifnotzero $8000, RED_ORB

		   copyvarifnotzero $8001, 1

		   checkitemtype $0002

		   callstd 1

		   closeonkeypress
		   
		   fadeout $3
		  
		   setweather $6

		   doweather	   

		   setvar $8004, $000F

	   	   setvar $8005, $000F

		   setvar $8006, $0FF3

		   setvar $8007, $000F

		   special $131
	 	   
		   sound $27

		   pause $28

 		   virtualmsgbox Ancient
		   
	      	   sound $27

		   waitmsg

	      	   sound $27

		   waitkeypress

	      	   sound $27

		   release

		   special $136

		   callasm $2028E59
		   
		   callasm $2028E71

		   playmoncry $195, $0

		   virtualmsgbox Groudon

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

Groudon:
	Text_DE "Lauf und besuche deinen Vater in der@"

	Text_EN "Groudon: Grrgggrrrrah!@"

Ancient:
	Text_DE "Lauf und besuche deinen Vater in der@"

	Text_EN "A Super Ancient Pokémon is\n"
	Text_EN "reacting with the RED ORB!@"





NormanScriptEnd:


PreloadScriptStart:
	setvirtualaddress PreloadScriptStart

		   checkitem RED_ORB, 1

		   compare LASTRESULT, 1

		   virtualgotoif 1, .ineligible

		   checkpcitem RED_ORB, 1

		   compare LASTRESULT, 1

		   virtualgotoif 1, .ineligible

		   checkflag $123

		   virtualgotoif 0, .defeated
		   

	
		   clearflag $042E

		   virtualloadpointer GoSeeYourFather

		   setbyte 2

		   end

.ineligible
	virtualloadpointer SapphireVersion
	setbyte 3
	end

.defeated
	virtualloadpointer Elite4
	setbyte 3
	end

SapphireVersion:
	Text_EN "This event is only for Pokémon Saphire\n""
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
  	