INCLUDE "../macros.asm"
INCLUDE "../constants/items.asm"
INCLUDE "../constants/scriptcommandsentei.asm"

	Mystery_Event

	db CHECKSUM_CRC
	dd 0 ; checksum placeholder
	GBAPTR DataStart
	GBAPTR DataEnd

DataStart:
	db IN_GAME_SCRIPT
	db 24,15 ; Mt Pyre
	db 3     ; Guy on left grave
	GBAPTR NormanScriptStart
	GBAPTR NormanScriptEnd

	db PRELOAD_SCRIPT
	GBAPTR PreloadScriptStart

	db END_OF_CHUNKS


GoSeeYourFather:
	Text_EN "An person hunting the LEGENDARY BEASTS\n"
	Text_EN "has appeared in MT.Pyre...@"



NormanScriptStart:
	setvirtualaddress NormanScriptStart



	           db $43                  ;This checks if your party is bigger than 0

		   compare LASTRESULT, 0   ;It's so I can store thumb code in static spot. 

		   virtualgotoif 2, Start  ;It should never fail.


		   BEASTRNG




		      
Start:		   

                   comparefarbytetobyte $0202886B, $1

	           virtualgotoif 1, FieryPath

		   writebytetoaddr $01, $0202886B		

		   fadesong $15F

		   pause $10

		   applymovement $3, $2025074 

		   pause $10     

		   sound $15	

 		   pause $10
       
   		   faceplayer

		   virtualmsgbox Hello           

		   waitmsg
		
		   waitkeypress

		   release

		   getplayerpos $8000, $8001
		
		   compare $8001, $A

		   virtualgotoif 1, Movement

		   applymovement $FF, $2025088

		   pause $11
			
Movement:

		   applymovement $03, $2025077

		   pause $90

	   	   db $35                              ;this returns the songs map to current map

                   writebytetoaddr $0E, $02028dca

		   random $000C

		   callasm $02025009

 	   	   end


FieryPath:

                   comparefarbytetobyte $0202886A, $1

	           virtualgotoif 1, SuccessBoulder

		   getplayerpos $8000, $8001

		   compare $8000, $10

		   virtualgotoif 5, FailBoulder

		   compare $800C, $4

		   virtualgotoif 5, FailBoulder

		   writebytetoaddr $C9, $2028230

		   special $13B

		   sound $29

		   pause $35

		   playmoncry $C9, $0

		   pause $25

SuccessBoulder:	

		   setvar $8004, 0

		   special2 $8004, $147

		   compare $8004, $C9

		   virtualgotoif 1, Letter


BoulderMessage2:

	           writebytetoaddr $01, $0202886A

		   braillemessage $02025358

		   waitkeypress

		   hidebox $0, $0, $1D, $13

 	   	   end	
		   

FailBoulder:

		   braillemessage $202533C

		   waitkeypress

		   hidebox $0, $0, $1D, $13

 	   	   end	
		   
Letter:

		   callasm $2025051

		   compare $8004, $00FF

		   virtualgotoif 1, Battle

		   virtualgotoif 5, BoulderMessage2


Battle:


		   db $43

		   compare LASTRESULT, 5

		   virtualgotoif 2, NoRoom

		   copyvar $800B, $800D

		   setwildbattle $F4, $55, $D7

		   callasm $02028DDF

		   applymovement $FF, $2025074 

		   sound $15

		   special $136
	 	   
		   sound $58

		   sound $58

		   waitstate

		   pause $28

		   special $136

		   waitstate

		   pause $28

		   playmoncry $F4, $0

                   waitmoncry

		   special $138
		
		   playsong $0166, $0

		   waitstate

		   writebytetoaddr $00, $2028230

		   db $43

		   comparevar LASTRESULT, $800B		   
		   
		   virtualgotoif 3, FlewAway

                   callasm $02028ea3

		   braillemessage $20250A1

		   waitkeypress

		   hidebox $0, $0, $1D, $13
		
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
        Text_EN "The ENTEI flew away!@"

Hello:
	Text_EN "My name’s Eusine. I’m on the trail\n"
	Text_EN "of a POKéMON named SUICUNE.\p"
	Text_EN "And you are...? \v1?\n"
	Text_EN "Glad to meet you!\p"
	Text_EN "I’ve read rumors of a POKéMON named\n"
	Text_EN "ENTEI in HOENN.\p"
	Text_EN "It, RAIKOU, and SUICUNE are often\n"
	Text_EN "seen together.\p"
	Text_EN "I read that there’s ANCIENT TEXT\n"
	Text_EN "in FIERY PATH.\p"
	Text_EN "You investigate, I’ll continue to\n"
	Text_EN "search for clues!@"




NormanScriptEnd:


PreloadScriptStart:
	setvirtualaddress PreloadScriptStart


	writebytetoaddr	$00, $0202886A

	writebytetoaddr	$00, $0202886C

	writebytetoaddr	$00, $0202886D

	writebytetoaddr	$00, $0202886E

	writebytetoaddr	$00, $0202886F

	writebytetoaddr	$00, $02028870

	writebytetoaddr	$00, $02028871

	writebytetoaddr $E4, $2024FF0
	writebytetoaddr $E4, $2025090
	writebytetoaddr $E4, $2025130
	writebytetoaddr $E4, $20251D0
	writebytetoaddr $E4, $2025270
	writebytetoaddr $E4, $2025310

	callasm $08135c65

 	writebytetoaddr $03, $202533C ;First Braille Box
	writebytetoaddr $04, $202533D
	writebytetoaddr $1A, $202533E
	writebytetoaddr $0D, $202533F
	writebytetoaddr $04, $2025340
	writebytetoaddr $06, $2025341
	writebytetoaddr $06, $2025342
	writebytetoaddr $00, $2025343
	writebytetoaddr $09, $2025344
	writebytetoaddr $1B, $2025345
	writebytetoaddr $0B, $2025346
	writebytetoaddr $00, $2025347
	writebytetoaddr $2E, $2025348
	writebytetoaddr $0D, $2025349
	writebytetoaddr $09, $202534A
	writebytetoaddr $1D, $202534B
	writebytetoaddr $09, $202534C
	writebytetoaddr $FE, $202534D
	writebytetoaddr $06, $202534E
	writebytetoaddr $00, $202534F
	writebytetoaddr $16, $2025350
	writebytetoaddr $1E, $2025351
	writebytetoaddr $01, $2025352
	writebytetoaddr $1D, $2025353
	writebytetoaddr $1E, $2025354
	writebytetoaddr $09, $2025355
	writebytetoaddr $0B, $2025356
	writebytetoaddr $FF, $2025357
	  
	writebytetoaddr $01, $2025358 ;Second Braille Box
	writebytetoaddr $03, $2025359
	writebytetoaddr $1C, $202535A
	writebytetoaddr $0e, $202535B
	writebytetoaddr $02, $202535C
	writebytetoaddr $04, $202535D
	writebytetoaddr $1E, $202535E
	writebytetoaddr $0D, $202535F
	writebytetoaddr $09, $2025360
	writebytetoaddr $3B, $2025361
	writebytetoaddr $00, $2025362
	writebytetoaddr $01, $2025363
	writebytetoaddr $1D, $2025364
	writebytetoaddr $09, $2025365
	writebytetoaddr $00, $2025366
	writebytetoaddr $07, $2025367
	writebytetoaddr $1D, $2025368
	writebytetoaddr $09, $2025369
	writebytetoaddr $09, $202536A
	writebytetoaddr $FE, $202536B
	writebytetoaddr $06, $202536C
	writebytetoaddr $1B, $202536D
	writebytetoaddr $00, $202536E
	writebytetoaddr $1E, $202536F
	writebytetoaddr $0D, $2025370
	writebytetoaddr $09, $2025371
	writebytetoaddr $00, $2025372
	writebytetoaddr $01, $2025373
	writebytetoaddr $16, $2025374
	writebytetoaddr $0D, $2025375
	writebytetoaddr $FE, $2025376
	writebytetoaddr $05, $2025377
	writebytetoaddr $1D, $2025378
	writebytetoaddr $06, $2025379
	writebytetoaddr $1B, $202537A
	writebytetoaddr $0F, $202537B
	writebytetoaddr $00, $202537C
	writebytetoaddr $07, $202537D
	writebytetoaddr $00, $202537E
	writebytetoaddr $07, $202537F
	writebytetoaddr $06, $2025380
	writebytetoaddr $1D, $2025381
	writebytetoaddr $16, $2025382
	writebytetoaddr $1E, $2025383
	writebytetoaddr $FF, $2025384
  
	writebytetoaddr $01, $2025385 ;Unown Letter Table Braille
	writebytetoaddr $05, $2025386
	writebytetoaddr $0B, $2025387
	writebytetoaddr $09, $2025388
	writebytetoaddr $07, $2025389
	writebytetoaddr $0E, $202538A
	writebytetoaddr $15, $202538B
	writebytetoaddr $13, $202538C
	writebytetoaddr $19, $202538D
	writebytetoaddr $34, $202538E
	writebytetoaddr $39, $202538F
	writebytetoaddr $1E, $2025390
	writebytetoaddr $11, $2025391
	  
	writebytetoaddr $00, $2025392 ;Unown Letter Table.
	writebytetoaddr $01, $2025393
	writebytetoaddr $03, $2025394
	writebytetoaddr $04, $2025395
	writebytetoaddr $05, $2025396
	writebytetoaddr $09, $2025397
	writebytetoaddr $0B, $2025398
	writebytetoaddr $0C, $2025399
	writebytetoaddr $0E, $202539A
	writebytetoaddr $1B, $202539B
	writebytetoaddr $19, $202539C
	writebytetoaddr $13, $202539D
	writebytetoaddr $16, $202539E


	writebytetoaddr	$00, $2028230 ;Unown Outbreak Info
	writebytetoaddr	$00, $2028231
	writebytetoaddr	$1C, $2028232
	writebytetoaddr	$00, $2028233
	writebytetoaddr	$0A, $2028234
	writebytetoaddr	$00, $2028235
	writebytetoaddr	$00, $2028236
	writebytetoaddr	$0A, $2028237
	writebytetoaddr	$ED, $2028238
	writebytetoaddr	$00, $2028239
	writebytetoaddr	$00, $202823A
	writebytetoaddr	$00, $202823B
	writebytetoaddr	$00, $202823C
	writebytetoaddr	$00, $202823D
	writebytetoaddr	$00, $202823E
	writebytetoaddr	$00, $202823F
	writebytetoaddr	$00, $2028240
	writebytetoaddr	$64, $2028241
	writebytetoaddr	$F9, $2028242
	writebytetoaddr	$0A, $2028243
	writebytetoaddr	$9D, $2028244
	writebytetoaddr	$00, $2028245
	writebytetoaddr	$06, $2028246
	writebytetoaddr	$00, $2028247
	writebytetoaddr	$35, $2028248
	writebytetoaddr	$00, $2028249
	writebytetoaddr	$FF, $202824A
	writebytetoaddr	$FF, $202824B


	writebytetoaddr $0, $202539F ;Temp Entei. Starts with bit for alignment.
	writebytetoaddr $0, $20253A0
	writebytetoaddr $0, $20253A1
	writebytetoaddr $0, $20253A2
	writebytetoaddr $0, $20253A3
	writebytetoaddr $0, $20253A4
	writebytetoaddr $0, $20253A5
	writebytetoaddr $0, $20253A6
	writebytetoaddr $0, $20253A7
	writebytetoaddr $BF, $20253A8
	writebytetoaddr $C8, $20253A9
	writebytetoaddr $CE, $20253AA
	writebytetoaddr $BF, $20253AB
	writebytetoaddr $C3, $20253AC
	writebytetoaddr $FF, $20253AD
	writebytetoaddr $0, $20253AE
	writebytetoaddr $0, $20253AF
	writebytetoaddr $0, $20253B0
	writebytetoaddr $0, $20253B1
	writebytetoaddr $2, $20253B2
	writebytetoaddr $2, $20253B3
	writebytetoaddr $C0, $20253B4
	writebytetoaddr $BB, $20253B5
	writebytetoaddr $CC, $20253B6
	writebytetoaddr $CE, $20253B7
	writebytetoaddr $FF, $20253B8
	writebytetoaddr $0, $20253B9
	writebytetoaddr $0, $20253BA
	writebytetoaddr $0, $20253BB
	writebytetoaddr $2C, $20253BC
	writebytetoaddr $9C, $20253BD
	writebytetoaddr $0, $20253BE
	writebytetoaddr $0, $20253BF
	writebytetoaddr $F4, $20253C0
	writebytetoaddr $0, $20253C1
	writebytetoaddr $0, $20253C2
	writebytetoaddr $0, $20253C3
	writebytetoaddr $A8, $20253C4
	writebytetoaddr $B6, $20253C5
	writebytetoaddr $0B, $20253C6
	writebytetoaddr $0, $20253C7
	writebytetoaddr $0, $20253C8
	writebytetoaddr $23, $20253C9
	writebytetoaddr $0, $20253CA
	writebytetoaddr $0, $20253CB
	writebytetoaddr $A4, $20253CC
	writebytetoaddr $0, $20253CD
	writebytetoaddr $5B, $20253CE
	writebytetoaddr $1, $20253CF
	writebytetoaddr $4C, $20253D0
	writebytetoaddr $0, $20253D1
	writebytetoaddr $7E, $20253D2
	writebytetoaddr $0, $20253D3
	writebytetoaddr $0A, $20253D4
	writebytetoaddr $14, $20253D5
	writebytetoaddr $0A, $20253D6
	writebytetoaddr $5, $20253D7
	writebytetoaddr $0, $20253D8
	writebytetoaddr $0, $20253D9
	writebytetoaddr $0, $20253DA
	writebytetoaddr $0, $20253DB
	writebytetoaddr $0, $20253DC
	writebytetoaddr $0, $20253DD
	writebytetoaddr $0, $20253DE
	writebytetoaddr $0, $20253DF
	writebytetoaddr $0, $20253E0
	writebytetoaddr $0, $20253E1
	writebytetoaddr $0, $20253E2
	writebytetoaddr $0, $20253E3
	writebytetoaddr $0, $20253E4
	writebytetoaddr $7D, $20253E5
	writebytetoaddr $A8, $20253E6
	writebytetoaddr $27, $20253E7
	writebytetoaddr $0, $20253E8
	writebytetoaddr $0, $20253E9
	writebytetoaddr $0, $20253EA
	writebytetoaddr $0, $20253EB
	writebytetoaddr $0, $20253EC
	writebytetoaddr $0, $20253ED
	writebytetoaddr $0, $20253EE
	writebytetoaddr $1, $20253EF

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

	writebytetoaddr $FF, $2025008 ;Calc RamScript Checksum
	writebytetoaddr $B5, $2025009
	writebytetoaddr $0C, $202500A
	writebytetoaddr $48, $202500B
	writebytetoaddr $0C, $202500C
	writebytetoaddr $49, $202500D
	writebytetoaddr $0D, $202500E
	writebytetoaddr $4A, $202500F
	writebytetoaddr $0D, $2025010
	writebytetoaddr $4B, $2025011
	writebytetoaddr $0E, $2025012
	writebytetoaddr $4C, $2025013
	writebytetoaddr $00, $2025014
	writebytetoaddr $78, $2025015
	writebytetoaddr $01, $2025016
	writebytetoaddr $44, $2025017
	writebytetoaddr $09, $2025018
	writebytetoaddr $78, $2025019
	writebytetoaddr $11, $202501A
	writebytetoaddr $70, $202501B
	writebytetoaddr $04, $202501C
	writebytetoaddr $44, $202501D
	writebytetoaddr $24, $202501E
	writebytetoaddr $78, $202501F
	writebytetoaddr $1C, $2025020
	writebytetoaddr $70, $2025021
	writebytetoaddr $7C, $2025022
	writebytetoaddr $46, $2025023
	writebytetoaddr $07, $2025024
	writebytetoaddr $34, $2025025
	writebytetoaddr $A6, $2025026
	writebytetoaddr $46, $2025027
	writebytetoaddr $02, $2025028
	writebytetoaddr $48, $2025029
	writebytetoaddr $00, $202502A
	writebytetoaddr $47, $202502B
	writebytetoaddr $02, $202502C
	writebytetoaddr $48, $202502D
	writebytetoaddr $02, $202502E
	writebytetoaddr $80, $202502F
	writebytetoaddr $FF, $2025030
	writebytetoaddr $BD, $2025031
	writebytetoaddr $00, $2025032
	writebytetoaddr $00, $2025033
	writebytetoaddr $81, $2025034
	writebytetoaddr $57, $2025035
	writebytetoaddr $06, $2025036
	writebytetoaddr $08, $2025037
	writebytetoaddr $C4, $2025038
	writebytetoaddr $8D, $2025039
	writebytetoaddr $02, $202503A
	writebytetoaddr $02, $202503B
	writebytetoaddr $DC, $202503C
	writebytetoaddr $E8, $202503D
	writebytetoaddr $02, $202503E
	writebytetoaddr $02, $202503F
	writebytetoaddr $85, $2025040
	writebytetoaddr $53, $2025041
	writebytetoaddr $02, $2025042
	writebytetoaddr $02, $2025043
	writebytetoaddr $7D, $2025044
	writebytetoaddr $53, $2025045
	writebytetoaddr $02, $2025046
	writebytetoaddr $02, $2025047
	writebytetoaddr $DA, $2025048
	writebytetoaddr $8F, $2025049
	writebytetoaddr $02, $202504A
	writebytetoaddr $02, $202504B
	writebytetoaddr $92, $202504C
	writebytetoaddr $53, $202504D
	writebytetoaddr $02, $202504E
	writebytetoaddr $02, $202504F

	writebytetoaddr $FF, $2025050	;CheckUnownLetter
	writebytetoaddr $B5, $2025051	
	writebytetoaddr $7C, $2025052	
	writebytetoaddr $46, $2025053	
	writebytetoaddr $0B, $2025054	
	writebytetoaddr $34, $2025055	
	writebytetoaddr $A6, $2025056	
	writebytetoaddr $46, $2025057	
	writebytetoaddr $03, $2025058	
	writebytetoaddr $48, $2025059	
	writebytetoaddr $04, $202505A	
	writebytetoaddr $4B, $202505B	
	writebytetoaddr $00, $202505C	
	writebytetoaddr $68, $202505D	
	writebytetoaddr $18, $202505E	
	writebytetoaddr $47, $202505F	
	writebytetoaddr $03, $2025060	
	writebytetoaddr $49, $2025061	
	writebytetoaddr $08, $2025062	
	writebytetoaddr $70, $2025063	
	writebytetoaddr $FF, $2025064	
	writebytetoaddr $BC, $2025065	
	writebytetoaddr $00, $2025066	
	writebytetoaddr $BD, $2025067	
	writebytetoaddr $60, $2025068	
	writebytetoaddr $43, $2025069	
	writebytetoaddr $00, $202506A	
	writebytetoaddr $03, $202506B	
	writebytetoaddr $95, $202506C	
	writebytetoaddr $D4, $202506D	
	writebytetoaddr $09, $202506E	
	writebytetoaddr $08, $202506F	
	writebytetoaddr $CC, $2025070	
	writebytetoaddr $E8, $2025071	
	writebytetoaddr $02, $2025072	
	writebytetoaddr $02, $2025073

	writebytetoaddr $56, $2025074 ;EusineMove
	writebytetoaddr $12, $2025075
	writebytetoaddr $FE, $2025076	

	writebytetoaddr $09, $2025077 ;Bye Bye Eusine
	writebytetoaddr $09, $2025078
	writebytetoaddr $0A, $2025079
	writebytetoaddr $09, $202507A
	writebytetoaddr $09, $202507B
	writebytetoaddr $09, $202507C
	writebytetoaddr $09, $202507D
	writebytetoaddr $09, $202507E
	writebytetoaddr $09, $202507F
	writebytetoaddr $09, $2025080
	writebytetoaddr $09, $2025081
	writebytetoaddr $09, $2025082
	writebytetoaddr $09, $2025083
	writebytetoaddr $09, $2025084
	writebytetoaddr $09, $2025085
	writebytetoaddr $09, $2025086
	writebytetoaddr $FE, $2025087

	writebytetoaddr $0B, $2025088 ;Get out of Eusines way.
	writebytetoaddr $02, $2025089
	writebytetoaddr $14, $202508A
	writebytetoaddr $14, $202508B
	writebytetoaddr $FE, $202508C

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




DataEnd:
	EOF
  	