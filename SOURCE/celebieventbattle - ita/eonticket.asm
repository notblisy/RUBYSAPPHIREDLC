INCLUDE "../macros.asm"
INCLUDE "../constants/items.asm"
INCLUDE "../constants/scriptcommandscelebibattleita.asm"

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


GoSeeYourFather:
	Text_EN "Si è visto un bagliore accecante\n"
	Text_EN "nel BOSCO PETALO!\p"
	Text_EN "Da allora, un POKéMON raro è stato\n" 
	Text_EN "vvistato mentre curava alberelli\l"
	Text_EN "abbattuti.@"


NormanScriptStart:
	setvirtualaddress NormanScriptStart

	           virtualmsgbox Poor
		   waitmsg
		   db $6E, $17, $8
	           release

		   compare LASTRESULT, 0

		   virtualgotoif 1, Changemind	

		   virtualgotoif 5, CelebiEvent		   
			  			

			   TEMPCELEBI
			   STRUCTURETABLEG
			   STRUCTURETABLEA
			   STRUCTURETABLEE
			   STRUCTURETABLEM
			   LOADSTOREPARTYAMOUNT
			   COLORNG
			   MEMCPYSETUP
			   SUBSTRUCTURECPY
			   CHECKSUM
			   ENCRYPT
			   CALCSTATS
			   CAPTURECELEBI
			   CELEBICOPY1
			   SRFIX
	   
   


CelebiEvent:
		   db $43

		   compare LASTRESULT, 5

		   virtualgotoif 2, NoRoom

		   copyvar $800B, $800D

		   callasm $02028E9D

		   callasm $02028EB1
	
		   callasm $02028F91

		   callasm $02028FA1

		   callasm $02028FD5

		   callasm $02028FED

		   special $13D

		   sound $13
		
		   waitstate

		   playmoncry $FB, $0

		   virtualmsgbox Celebi

		   waitmsg

                   waitmoncry

		   waitkeypress

		   release

		   special $138
		
		   playsong $0166, $0

                   waitmoncry

		   waitstate

		   db $43

		   comparevar LASTRESULT, $800B		   
		   
		   virtualgotoif 3, FlewAway

		   virtualgotoif 2, Catch




Catch:
                   callasm $02028FB1
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
	virtualloadpointer NoSpace
	setbyte 3
	killscript		

FlewAway:
	db $97, $01
	db $97, $00
	virtualmsgbox Flew
	waitmsg
	waitkeypress
	release
        killscript

Poor:
	Text_EN "Si sente un fruscio provenire\n"
	Text_EN "da quest’albero.\p"
	Text_EN "Sembra che sia un POKéMON a causarlo,\n"
	Text_EN "vuoi controllare?@"
Change:
	Text_EN "Forse un’altra volta.@"
Flew:
        Text_EN "CELEBI è sparito fra gli alberi!@"
 
NoSpace:
	Text_EN "Hai bisogno di spazio libero\n"
	Text_EN "nella tua squadra\p"
	Text_EN "per catturare CELEBI!@"

Celebi:
	Text_EN "CELEBI: Biyoo!@"



NormanScriptEnd:


PreloadScriptStart:
	setvirtualaddress PreloadScriptStart
	

		   db $43

		   compare LASTRESULT, 5

		   virtualgotoif 2, NoRoomToGive	

		   virtualloadpointer GoSeeYourFather

		   setbyte 2

		   end





DataEnd:
	EOF
  	