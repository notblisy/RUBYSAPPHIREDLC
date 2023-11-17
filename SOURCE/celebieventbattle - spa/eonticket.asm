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
	Text_EN "¡Se ha visto un gran resplandor en\n"
	Text_EN "el BOSQUE PETALIA!\p"
	Text_EN "Desde entonces, un extraño Pokémon\n" 
	Text_EN "se ha podido observar curando\l"
	Text_EN "árboles débiles.@"



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
	Text_EN "Se puede escuchar el murmullo\n"
	Text_EN "de un Pokemon en este árbol.\p"
	Text_EN "¿Investigar el árbol?@"
Change:
	Text_EN "Tal vez en otro momento.@"
Flew:
    Text_EN "¡El CELEBI ha salido volando!@"

NoSpace:
	Text_EN "¡Necesitas espacio en tu equipo para\n"
	Text_EN "capturar a CELEBI!@"

Celebi:
	Text_EN "CELEBI: ¡Biyoo!@"



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
  	