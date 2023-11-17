INCLUDE "../macros.asm"
INCLUDE "../constants/items.asm"
INCLUDE "../constants/jpscriptcommandscelebibattleunlocked.asm"

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
	Text_EN "トウカのもりで　まばゆい　ひかりが\n"
	Text_EN "もくげき　されました！\p"
	Text_EN "それいらい　めずらしい　ポケモンが\n"
	Text_EN "ほそいきに　いると　うわさ　されています。@"

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

		   callasm $02028C11
	
		   callasm $02028CF1

		   callasm $02028D01

		   callasm $02028D35

		   callasm $02028D4D

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
                   callasm $02028D11
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
        killscript

PartyFull:
	Text_EN "てもちポケモンの　あきを　つくって\n"
	Text_EN "ふしぎなできごとを　たいけん　しましょう！@"
Poor:
	Text_EN "ポケモンが　ゴソゴソしている！\n"
	Text_EN "しらべてみますか？@"
Change:
	Text_EN "つぎの　きかいに　しよう。@"
Flew:
	Text_EN "ゴソゴソ　していたのは　セレビィ　だった!\n"
	Text_EN "セレビィは　とびさって　いった。@"
NoSpace:
	Text_EN "てもちポケモンが　いっぱいです！@"

Celebi:
	Text_EN "るるらららっ！@"



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
  	