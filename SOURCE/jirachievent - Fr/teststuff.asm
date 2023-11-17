INCLUDE "../macros.asm"
INCLUDE "../constants/items.asm"
INCLUDE "../constants/scriptcommands.asm"

	Mystery_Event

	db CHECKSUM_CRC
	dd 0 ; checksum placeholder
	GBAPTR DataStart
	GBAPTR DataEnd

DataStart:
	db IN_GAME_SCRIPT
	db 14,10 ; Petalburg Gym
	db 2   ; Norman
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

	Text_EN "Go see your father at the GYM in\n"
	Text_EN "PETALBURG.@"


NormanScriptStart:
	setvirtualaddress NormanScriptStart


		   setwildbattle $19A, $1E, $5e

		   callasm $08080ec1 

	           callasm $08053441

		   callasm $08080919

		   callasm $0805334d
		
		   pause $300
		    

		   playmoncry $19A, $0
                  
                   waitmoncry
		
		   dowildbattle
		
		   
                   
		   
		   
		   

.delete_script
	killscript



		   EVENTLEGAL2
		   METLOCATION
		   GAMEORIGIN

NormanScriptEnd:


PreloadScriptStart:
	setvirtualaddress PreloadScriptStart
	
		   clearflag $0438

		   virtualloadpointer GoSeeYourFather
			
		   setbyte 2

		   end





DataEnd:
	EOF
  	