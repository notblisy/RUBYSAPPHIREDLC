INCLUDE "../macros.asm"
INCLUDE "../constants/items.asm"
INCLUDE "../constants/scriptcommandsraikou.asm"

	Mystery_Event

	db CHECKSUM_CRC
	dd 0 ; checksum placeholder
	GBAPTR DataStart
	GBAPTR DataEnd

DataStart:
	db IN_GAME_SCRIPT
	db 0,32 ; Route 117
	db 10     ; Breeder near lakes
	GBAPTR NormanScriptStart
	GBAPTR NormanScriptEnd

	db PRELOAD_SCRIPT
	GBAPTR PreloadScriptStart

	db END_OF_CHUNKS


GoSeeYourFather:
	Text_EN "EUSINE is waiting for you\n"
	Text_EN "near VERDANTURF...@"



NormanScriptStart:
	setvirtualaddress NormanScriptStart



	           db $43                  ;This checks if your party is bigger than 0

		   compare LASTRESULT, 0   ;It's so I can store thumb code in static spot. 

		   virtualgotoif 2, Start  ;It should never fail.


		   BEASTRNG



		      
Start:		
                   comparefarbytetobyte $0202886E, $1	

	           virtualgotoif 1, Battle

                   comparefarbytetobyte $0202886D, $1	

	           virtualgotoif 1, CheckRain
   
                   comparefarbytetobyte $0202886C, $1

	           virtualgotoif 1, Rusturf

		   writebytetoaddr $01, $0202886C

		   fadesong $165

		   pause $10

		   applymovement $A, $2025074 

		   pause $10     

		   sound $15	

 		   pause $10
       
   		   faceplayer

		   virtualmsgbox Hello           

		   waitmsg
		
		   waitkeypress

		   release

	           db $97, $01  ;Fades map to black

		   db $53 ;Next two instructions make Eusine Dissapear

		   dw $A

		   db $63 ;This teleports him to top of map

		   dw $A, $0, $0 

	           db $98, $00, $03 ;Fades map back in.

		   writebytetoaddr $02, $02025763 ;this sets route 119s weather to bright weather.

	   	   db $35 ;this returns the songs map to current map

                   writebytetoaddr $18, $02028dc9 ;Sets ramscript person event to rusturf rocksmash rock.
                  
		   writebytetoaddr $04, $02028dca

                   writebytetoaddr $08, $02028dcb

		   callasm $2025009

		   end
			

Rusturf:


		   braillemessage $202533C

		   waitkeypress

		   hidebox $0, $0, $1D, $13

                   comparefarbytetobyte $02024eb8, $40

		   virtualgotoif 5, FailRock

SuccessRock:	

		   special $13B
	 	   
		   sound $57

		   db $30

	           writebytetoaddr $01, $0202886D

		   braillemessage $202535F

		   pause $60

		   waitkeypress

		   hidebox $0, $0, $1D, $13

                   writebytetoaddr $0, $02028dc9 ;Mapgroup Sets ramscript person event to Invisible Kecleon on 119.
                  
		   writebytetoaddr $22, $02028dca ;Map index

                   writebytetoaddr $24, $02028dcb ;person event

		   callasm $2025009               ;calcramscript checksum

		   clearflag $3DD

 	   	   end	
		   

FailRock:


 	   	   end	

CheckRain:
	           comparefarbytetobyte $02024db8, $5

		   virtualgotoif 5, KecleonSpot
CheckWon:

	           comparefarbytetobyte $030042e1, $1

		   virtualgotoif 5, KecleonSpot
CheckThunder:

	           comparefarbytetobyte $03004302, $57

		   virtualgotoif 1, Battle


		   
KecleonSpot:

		   braillemessage $2025024

		   waitkeypress

		   hidebox $0, $0, $1D, $13


Continue: 

		   special $13D

		   special $13B

		   sound $57

		   db $30

		   special $13B

		   sound $57

		   db $30

		   db $A4 ;sets weather to thunderstorm

		   dw $05

		   db $A5 ;does weather

		   writebytetoaddr $02, $02025763 ;this sets route 119s weather to thunderstorm.

		   end


Battle:




	           writebytetoaddr $01, $0202886E

		   db $43

		   compare LASTRESULT, 5

		   virtualgotoif 2, NoRoom

		   copyvar $800B, $800D

		   setwildbattle $F4, $55, $D7

		   callasm $02028DDF

		   applymovement $FF, $2025074 

		   sound $15

		   db $30

		   special $13D
	 	   
		   sound $57

		   db $30

		   pause $28

		   playmoncry $F3, $0

                   waitmoncry

		   special $138
		
		   playsong $0166, $0

		   waitstate

		   db $43

		   comparevar LASTRESULT, $800B		   
		   
		   virtualgotoif 3, FlewAway

                   callasm $02028ea3

		   braillemessage $20250A1

		   waitkeypress

		   hidebox $0, $0, $1D, $13

		   setflag $3DD
		
		   killscript


NoRoom:
		   braillemessage $202508D

		   waitkeypress

		   hidebox $0, $0, $1D, $13

 	   	   end


FlewAway:
	db $97, $01
	db $97, $00
	virtualmsgbox Flew
	waitmsg
	waitkeypress
	release
	end


Flew:
        Text_EN "The RAIKOU flew away!@"

Hello:
	Text_EN "\v1! Good to see you again.\n"
	Text_EN "I see you’ve caught ENTEI!\p"
	Text_EN "This means we’re one step closer\n"
	Text_EN "to finding SUICUNE.\p"
	Text_EN "I heard there was a clue to RAIKOU’s\n"
	Text_EN "location in RUSTURF TUNNEL.\p"
	Text_EN "You check that out. I’ll continue to\n"
	Text_EN "look for clues!@"




NormanScriptEnd:

	
PreloadScriptStart:
	setvirtualaddress PreloadScriptStart


                   comparefarbytetobyte $0202886B, $0

	           virtualgotoif 1, delete

	writebytetoaddr $E4, $2024FF0
	writebytetoaddr $E4, $2025090
	writebytetoaddr $E4, $2025130
	writebytetoaddr $E4, $20251D0
	writebytetoaddr $E4, $2025270
	writebytetoaddr $E4, $2025310

	callasm $08135c45

	writebytetoaddr $00, $202533C ;First Braille Box
	writebytetoaddr $06, $202533D
	writebytetoaddr $1D, $202533E
	writebytetoaddr $0D, $202533F
	writebytetoaddr $01, $2025340
	writebytetoaddr $07, $2025341
	writebytetoaddr $1D, $2025342
	writebytetoaddr $09, $2025343
	writebytetoaddr $01, $2025344
	writebytetoaddr $0B, $2025345
	writebytetoaddr $00, $2025346
	writebytetoaddr $1E, $2025347
	writebytetoaddr $0D, $2025348
	writebytetoaddr $06, $2025349
	writebytetoaddr $16, $202534A
	writebytetoaddr $00, $202534B
	writebytetoaddr $16, $202534C
	writebytetoaddr $15, $202534D
	writebytetoaddr $19, $202534E
	writebytetoaddr $2E, $202534F
	writebytetoaddr $FE, $2025350
	writebytetoaddr $06, $2025351
	writebytetoaddr $1B, $2025352
	writebytetoaddr $00, $2025353
	writebytetoaddr $1E, $2025354
	writebytetoaddr $0D, $2025355
	writebytetoaddr $09, $2025356
	writebytetoaddr $00, $2025357
	writebytetoaddr $03, $2025358
	writebytetoaddr $15, $2025359
	writebytetoaddr $19, $202535A
	writebytetoaddr $31, $202535B
	writebytetoaddr $0B, $202535C
	writebytetoaddr $16, $202535D
	writebytetoaddr $FF, $202535E
	  
	writebytetoaddr $00, $202535F ;Find me where thunder claps
	writebytetoaddr $06, $2025360
	writebytetoaddr $1D, $2025361
	writebytetoaddr $0D, $2025362
	writebytetoaddr $01, $2025363
	writebytetoaddr $07, $2025364
	writebytetoaddr $07, $2025365
	writebytetoaddr $06, $2025366
	writebytetoaddr $1B, $2025367
	writebytetoaddr $0B, $2025368
	writebytetoaddr $00, $2025369
	writebytetoaddr $13, $202536A
	writebytetoaddr $09, $202536B
	writebytetoaddr $00, $202536C
	writebytetoaddr $2E, $202536D
	writebytetoaddr $0D, $202536E
	writebytetoaddr $09, $202536F
	writebytetoaddr $1D, $2025370
	writebytetoaddr $09, $2025371
	writebytetoaddr $FE, $2025372
	writebytetoaddr $1E, $2025373
	writebytetoaddr $0D, $2025374
	writebytetoaddr $31, $2025375
	writebytetoaddr $1B, $2025376
	writebytetoaddr $0B, $2025377
	writebytetoaddr $09, $2025378
	writebytetoaddr $1D, $2025379
	writebytetoaddr $00, $202537A
	writebytetoaddr $03, $202537B
	writebytetoaddr $15, $202537C
	writebytetoaddr $01, $202537D
	writebytetoaddr $17, $202537E
	writebytetoaddr $16, $202537F
	writebytetoaddr $FF, $2025380

 
	writebytetoaddr $0, $202539F ;Alignment byte
	writebytetoaddr $00, $20253A0 ;Temp Raikou
	writebytetoaddr $00, $20253A1
	writebytetoaddr $00, $20253A2
	writebytetoaddr $00, $20253A3
	writebytetoaddr $00, $20253A4
	writebytetoaddr $00, $20253A5
	writebytetoaddr $00, $20253A6
	writebytetoaddr $00, $20253A7
	writebytetoaddr $CC, $20253A8
	writebytetoaddr $BB, $20253A9
	writebytetoaddr $C3, $20253AA
	writebytetoaddr $C5, $20253AB
	writebytetoaddr $C9, $20253AC
	writebytetoaddr $CF, $20253AD
	writebytetoaddr $FF, $20253AE
	writebytetoaddr $FF, $20253AF
	writebytetoaddr $FF, $20253B0
	writebytetoaddr $FF, $20253B1
	writebytetoaddr $02, $20253B2
	writebytetoaddr $02, $20253B3
	writebytetoaddr $C0, $20253B4
	writebytetoaddr $BB, $20253B5
	writebytetoaddr $CC, $20253B6
	writebytetoaddr $CE, $20253B7
	writebytetoaddr $FF, $20253B8
	writebytetoaddr $00, $20253B9
	writebytetoaddr $00, $20253BA
	writebytetoaddr $00, $20253BB
	writebytetoaddr $DB, $20253BC
	writebytetoaddr $A6, $20253BD
	writebytetoaddr $00, $20253BE
	writebytetoaddr $00, $20253BF
	writebytetoaddr $F3, $20253C0
	writebytetoaddr $00, $20253C1
	writebytetoaddr $00, $20253C2
	writebytetoaddr $00, $20253C3
	writebytetoaddr $A8, $20253C4
	writebytetoaddr $B6, $20253C5
	writebytetoaddr $0B, $20253C6
	writebytetoaddr $00, $20253C7
	writebytetoaddr $30, $20253C8
	writebytetoaddr $23, $20253C9
	writebytetoaddr $00, $20253CA
	writebytetoaddr $00, $20253CB
	writebytetoaddr $A4, $20253CC
	writebytetoaddr $00, $20253CD
	writebytetoaddr $5B, $20253CE
	writebytetoaddr $01, $20253CF
	writebytetoaddr $57, $20253D0
	writebytetoaddr $00, $20253D1
	writebytetoaddr $ED, $20253D2
	writebytetoaddr $00, $20253D3
	writebytetoaddr $0A, $20253D4
	writebytetoaddr $14, $20253D5
	writebytetoaddr $10, $20253D6
	writebytetoaddr $0F, $20253D7
	writebytetoaddr $00, $20253D8
	writebytetoaddr $00, $20253D9
	writebytetoaddr $00, $20253DA
	writebytetoaddr $00, $20253DB
	writebytetoaddr $00, $20253DC
	writebytetoaddr $00, $20253DD
	writebytetoaddr $00, $20253DE
	writebytetoaddr $00, $20253DF
	writebytetoaddr $00, $20253E0
	writebytetoaddr $00, $20253E1
	writebytetoaddr $00, $20253E2
	writebytetoaddr $00, $20253E3
	writebytetoaddr $00, $20253E4
	writebytetoaddr $7D, $20253E5
	writebytetoaddr $A8, $20253E6
	writebytetoaddr $27, $20253E7
	writebytetoaddr $00, $20253E8
	writebytetoaddr $00, $20253E9
	writebytetoaddr $00, $20253EA
	writebytetoaddr $00, $20253EB
	writebytetoaddr $00, $20253EC
	writebytetoaddr $00, $20253ED
	writebytetoaddr $00, $20253EE
	writebytetoaddr $01, $20253EF

	writebytetoaddr $E4, $2024FF0	;Substructure Copy Table
	writebytetoaddr $B4, $2024FF1	
	writebytetoaddr $D8, $2024FF2	
	writebytetoaddr $9C, $2024FF3	
	writebytetoaddr $78, $2024FF4	
	writebytetoaddr $6C, $2024FF5	
	writebytetoaddr $E1, $2024FF6	
	writebytetoaddr $B1, $2024FF7	
	writebytetoaddr $D2, $2024FF8	
	writebytetoaddr $93, $2024FF9	
	writebytetoaddr $72, $2024FFA	
	writebytetoaddr $63, $2024FFB	
	writebytetoaddr $C9, $2024FFC	
	writebytetoaddr $8D, $2024FFD	
	writebytetoaddr $C6, $2024FFE	
	writebytetoaddr $87, $2024FFF	
	writebytetoaddr $4E, $2025000	
	writebytetoaddr $4B, $2025001	
	writebytetoaddr $39, $2025002	
	writebytetoaddr $2D, $2025003	
	writebytetoaddr $36, $2025004	
	writebytetoaddr $27, $2025005	
	writebytetoaddr $1E, $2025006	
	writebytetoaddr $1B, $2025007

	writebytetoaddr $FF, $2025008  ;Calc RamScript Checksum
	writebytetoaddr $B5, $2025009
	writebytetoaddr $7C, $202500A
	writebytetoaddr $46, $202500B
	writebytetoaddr $07, $202500C
	writebytetoaddr $34, $202500D
	writebytetoaddr $A6, $202500E
	writebytetoaddr $46, $202500F
	writebytetoaddr $02, $2025010
	writebytetoaddr $48, $2025011
	writebytetoaddr $00, $2025012
	writebytetoaddr $47, $2025013
	writebytetoaddr $02, $2025014
	writebytetoaddr $48, $2025015
	writebytetoaddr $02, $2025016
	writebytetoaddr $80, $2025017
	writebytetoaddr $FF, $2025018
	writebytetoaddr $BD, $2025019
	writebytetoaddr $00, $202501A
	writebytetoaddr $00, $202501B
	writebytetoaddr $61, $202501C
	writebytetoaddr $57, $202501D
	writebytetoaddr $06, $202501E
	writebytetoaddr $08, $202501F
	writebytetoaddr $C4, $2025020
	writebytetoaddr $8D, $2025021
	writebytetoaddr $02, $2025022
	writebytetoaddr $02, $2025023

	writebytetoaddr $00, $2025024 ;Show your power in a storm
	writebytetoaddr $02, $2025025
	writebytetoaddr $1D, $2025026
	writebytetoaddr $11, $2025027
	writebytetoaddr $01, $2025028
	writebytetoaddr $03, $2025029
	writebytetoaddr $01, $202502A
	writebytetoaddr $00, $202502B
	writebytetoaddr $05, $202502C
	writebytetoaddr $1D, $202502D
	writebytetoaddr $31, $202502E
	writebytetoaddr $1E, $202502F
	writebytetoaddr $01, $2025030
	writebytetoaddr $15, $2025031
	writebytetoaddr $00, $2025032
	writebytetoaddr $13, $2025033
	writebytetoaddr $19, $2025034
	writebytetoaddr $35, $2025035
	writebytetoaddr $09, $2025036
	writebytetoaddr $FE, $2025037
	writebytetoaddr $19, $2025038
	writebytetoaddr $07, $2025039
	writebytetoaddr $00, $202503A
	writebytetoaddr $15, $202503B
	writebytetoaddr $06, $202503C
	writebytetoaddr $0F, $202503D
	writebytetoaddr $0D, $202503E
	writebytetoaddr $1E, $202503F
	writebytetoaddr $1B, $2025040
	writebytetoaddr $06, $2025041
	writebytetoaddr $1B, $2025042
	writebytetoaddr $0F, $2025043
	writebytetoaddr $FE, $2025044
	writebytetoaddr $13, $2025045
	writebytetoaddr $31, $2025046
	writebytetoaddr $16, $2025047
	writebytetoaddr $1E, $2025048
	writebytetoaddr $00, $2025049
	writebytetoaddr $1D, $202504A
	writebytetoaddr $06, $202504B
	writebytetoaddr $1B, $202504C
	writebytetoaddr $0F, $202504D
	writebytetoaddr $FE, $202504E
	writebytetoaddr $35, $202504F
	writebytetoaddr $06, $2025050
	writebytetoaddr $03, $2025051
	writebytetoaddr $1E, $2025052
	writebytetoaddr $19, $2025053
	writebytetoaddr $1D, $2025054
	writebytetoaddr $06, $2025055
	writebytetoaddr $19, $2025056
	writebytetoaddr $31, $2025057
	writebytetoaddr $16, $2025058
	writebytetoaddr $FF, $2025059

	writebytetoaddr $56, $2025074 ;EusineMove
	writebytetoaddr $12, $2025075
	writebytetoaddr $FE, $2025076

	writebytetoaddr $01, $202508D ;No Room in Party
	writebytetoaddr $07, $202508E
	writebytetoaddr $1C, $202508F
	writebytetoaddr $0A, $2025090
	writebytetoaddr $02, $2025091
	writebytetoaddr $08, $2025092
	writebytetoaddr $17, $2025093
	writebytetoaddr $01, $2025094
	writebytetoaddr $1D, $2025095
	writebytetoaddr $1E, $2025096
	writebytetoaddr $3B, $2025097
	writebytetoaddr $00, $2025098
	writebytetoaddr $06, $2025099
	writebytetoaddr $16, $202509A
	writebytetoaddr $00, $202509B
	writebytetoaddr $07, $202509C
	writebytetoaddr $31, $202509D
	writebytetoaddr $15, $202509E
	writebytetoaddr $15, $202509F
	writebytetoaddr $FF, $20250A0

	writebytetoaddr $00, $20250A1 ;ADVENTURE CONTINUE
	writebytetoaddr $02, $20250A2
	writebytetoaddr $1D, $20250A3
	writebytetoaddr $11, $20250A4
	writebytetoaddr $01, $20250A5
	writebytetoaddr $03, $20250A6
	writebytetoaddr $3B, $20250A7
	writebytetoaddr $19, $20250A8
	writebytetoaddr $31, $20250A9
	writebytetoaddr $1D, $20250AA
	writebytetoaddr $00, $20250AB
	writebytetoaddr $01, $20250AC
	writebytetoaddr $0B, $20250AD
	writebytetoaddr $35, $20250AE
	writebytetoaddr $09, $20250AF
	writebytetoaddr $1B, $20250B0
	writebytetoaddr $1E, $20250B1
	writebytetoaddr $31, $20250B2
	writebytetoaddr $1D, $20250B3
	writebytetoaddr $09, $20250B4
	writebytetoaddr $FE, $20250B5
	writebytetoaddr $2E, $20250B6
	writebytetoaddr $06, $20250B7
	writebytetoaddr $15, $20250B8
	writebytetoaddr $15, $20250B9
	writebytetoaddr $00, $20250BA
	writebytetoaddr $03, $20250BB
	writebytetoaddr $19, $20250BC
	writebytetoaddr $1B, $20250BD
	writebytetoaddr $1E, $20250BE
	writebytetoaddr $06, $20250BF
	writebytetoaddr $1B, $20250C0
	writebytetoaddr $31, $20250C1
	writebytetoaddr $09, $20250C2
	writebytetoaddr $FE, $20250C3
	writebytetoaddr $19, $20250C4
	writebytetoaddr $1B, $20250C5
	writebytetoaddr $00, $20250C6
	writebytetoaddr $1E, $20250C7
	writebytetoaddr $0D, $20250C8
	writebytetoaddr $09, $20250C9
	writebytetoaddr $00, $20250CA
	writebytetoaddr $1B, $20250CB
	writebytetoaddr $09, $20250CC
	writebytetoaddr $33, $20250CD
	writebytetoaddr $1E, $20250CE
	writebytetoaddr $FE, $20250CF
	writebytetoaddr $09, $20250D0
	writebytetoaddr $00, $20250D1
	writebytetoaddr $03, $20250D2
	writebytetoaddr $01, $20250D3
	writebytetoaddr $1D, $20250D4
	writebytetoaddr $0B, $20250D5
	writebytetoaddr $FF, $20250D6



		   virtualloadpointer GoSeeYourFather

		   setbyte 2
	   end


delete:


        callasm $08135c45 

	setbyte 1	

	killscript


		   end



DataEnd:
	EOF
  	