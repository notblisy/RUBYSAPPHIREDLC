INCLUDE "../macros.asm"
INCLUDE "../constants/items.asm"
INCLUDE "../constants/scriptcommandsjirachibattlespa.asm"

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


GoSeeYourFather:
	Text_EN "La roca blanca de CIUDAD ALGARIA\n"
	Text_EN "está brillando@"




NormanScriptStart:
	setvirtualaddress NormanScriptStart

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


			   CHANNELRNG
			   STORAGETABLE
			   TEMPJIRACHI
			   STRUCTURETABLEG
			   MEMCOPYJIRACHI
			   RETURN
			   FIXJIRACHIANDCOPY
			   CAPTUREJIRACHI
			   FINALSTORAGE
			   MOVEPLAYERDOWNRIGHT
			   MOVEPLAYERRIGHTFACEUP
			   MOVEPLAYERQUESTION
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

		   virtualgotoif 5, Movement2

Movement1:

		   
                   applymovement $FF, $02029034

                   waitmovement $FF

Movement2:



                   applymovement $FF, $02029037

battle:
                   waitmovement $FF

		   pause $10

		   special $13B	   

		   sound $83

		   pause $10

		   pause $10

                   applymovement $FF, $0202903C

                   waitmovement $FF

		   sound $15

		   virtualmsgbox Pokemon

		   waitmsg

		   waitkeypress

		   release

		   playmoncry $199, $0

		   virtualmsgbox Jirachi

		   waitmsg

		   waitkeypress

		   release

		   callasm $02028DF1

		   callasm $02028FBD

                   waitmoncry

		   special $139
		
		   playsong $01CE, $0

                   waitstate

		   db $43

		   comparevar LASTRESULT, $800B		   
		   
		   virtualgotoif 3, FlewAway


Catch:
                   callasm $02028FF1
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
	end
	
Wish:
	Text_EN "¿Tienes un deseo?@"

Youdo:
	Text_EN "¡En ese caso, coloca una tablilla\n"
	Text_EN "con el deseo sobre la roca blanca!@"
Change:
	Text_EN "Pensaba que todos tenían deseos@"
Flew:
        Text_EN "¡JIRACHI ha huido!@"
NoSpace:
	Text_EN "Será mejor antes hacer hueco\n"
	Text_EN "en el equipo@"

Pokemon:
	Text_EN "Un POKéMON@"
Jirachi:
	Text_EN "¡Achi!@"


NormanScriptEnd:


PreloadScriptStart:
	setvirtualaddress PreloadScriptStart
	

		   virtualloadpointer GoSeeYourFather

		   setbyte 2

		   end





DataEnd:
	EOF
  	