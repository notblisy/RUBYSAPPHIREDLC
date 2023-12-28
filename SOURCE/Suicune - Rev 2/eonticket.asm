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
	db 0,26 ; Route 111
	db 36     ; Guy near winstrates.
	GBAPTR NormanScriptStart
	GBAPTR NormanScriptEnd

	db PRELOAD_SCRIPT
	GBAPTR PreloadScriptStart

	db END_OF_CHUNKS


GoSeeYourFather:
	Text_EN "EUSINE is waiting for you\n"
	Text_EN "near MAUVILLE...@"



NormanScriptStart:
	setvirtualaddress NormanScriptStart



	           db $43                  ;This checks if your party is bigger than 0

		   compare LASTRESULT, 0   ;It's so I can store thumb code in static spot. 

		   virtualgotoif 2, Start  ;It should never fail.


		   BEASTRNG



		      
Start:

                   comparefarbytetobyte $02028871, $1

	           virtualgotoif 1, EusineEnd
		
                   comparefarbytetobyte $02028870, $1

	           virtualgotoif 1, MirageIsland

                   comparefarbytetobyte $0202886F, $1

	           virtualgotoif 1, VictoryRoad	

		   writebytetoaddr $1, $0202886F		

		   fadesong $164

		   pause $10

		   applymovement $24, $2025024

		   pause $10     

		   sound $15	

 		   pause $10
       
   		   faceplayer

		   msgbox $2025052         

		   waitmsg
		
		   waitkeypress

		   release

	           db $97, $01  ;Fades map to black

		   db $53 ;Next two instructions make Eusine Dissapear

		   dw $24

		   db $63 ;This teleports him to top of map

		   dw $24, $0, $0 

	           db $98, $00, $03 ;Fades map back in.

	   	   db $35 ;this returns the songs map to current map

                   writebytetoaddr $18, $02028dc9 ;Sets ramscript person event to victory road boulder.
                  
		   writebytetoaddr $2C, $02028dca

                   writebytetoaddr $06, $02028dcb

		   callasm $2025009

		   end
			

VictoryRoad:

		   braillemessage $202533C

		   waitkeypress

		   hidebox $0, $0, $1D, $13

		   writebytetoaddr $00, $020260AC ;Sets step count to be 0.

		   writebytetoaddr $1, $02028870 	

                   copybyte $02026ABC, $03004360

                   copybyte $02026ABD, $03004361 

                   copybyte $02026ABE, $03004362 

                   copybyte $02026ABF, $03004363 

		   db $8A, $52, $24, $5 ;resets mirage island berry tree

		   special $13B

		   sound $A3

		   db $30

		   special $13B

		   sound $8

		   db $30

                   writebytetoaddr $0, $02028dc9 ;Mapgroup Sets ramscript berry mirage island.
                  
		   writebytetoaddr $2D, $02028dca ;Map index

                   writebytetoaddr $03, $02028dcb ;person event

		   callasm $2025009               ;calcramscript checksum

 	   	   end	

		   
MirageIsland:
		
		   comparefarbytetobyte $020260AC, $94

		   virtualgotoif 3, Battle

		   sound $16

		   writebytetoaddr $0, $02028870		

		   braillemessage $2025368 ;Failure. Try Again.

		   waitkeypress

		   hidebox $0, $0, $1D, $13

                   writebytetoaddr $18, $02028dc9 ;Sets ramscript person event to victory road boulder.
                  
		   writebytetoaddr $2C, $02028dca

                   writebytetoaddr $06, $02028dcb

		   callasm $2025009

		   end

Battle:



		   db $43

		   compare LASTRESULT, 5

		   virtualgotoif 2, NoRoom

		   copyvar $800B, $800D

		   setwildbattle $F4, $55, $D7

		   callasm $02028DDF

		   applymovement $FF, $2025024

		   sound $15

		   db $30

		   special $13B
	 	   
		   sound $D8

		   db $30

		   playmoncry $F5, $0

                   waitmoncry

		   special $138
		
		   playsong $0166, $0

		   waitstate

		   db $43

		   comparevar LASTRESULT, $800B		   
		   
		   virtualgotoif 3, FlewAway

                   callasm $02028ea3

		   copyvarifnotzero $8000, LIECHI_BERRY

		   copyvarifnotzero $8001, 1

		   checkitemtype $0005

		   callstd 1

		   db $8A, $52, $24, $5 ;resets mirage island berry tree

                   writebytetoaddr $00, $02028dc9 ;Sets ramscript person event to original Eusine. 
                  
		   writebytetoaddr $1A, $02028dca

                   writebytetoaddr $24, $02028dcb

		   writebytetoaddr $01, $02028871	

		   callasm $2025009

		   end

EusineEnd:

		   db $69
       
   		   faceplayer

		   msgbox $20250EB

		   waitmsg

		   db $6F, $0, $0, $26, $1

		   release

                   setvar $8004, $99

		   compare LASTRESULT, $0

	           virtualgotoif 1, Bayleef

		   compare LASTRESULT, $1

	           virtualgotoif 1, Quilava
		   
		   addvar $8004, $3

Quilava:

		   addvar $8004, $3

Bayleef:

		   db $43

		   compare LASTRESULT, 5

		   virtualgotoif 2, NoRoom2

		   copyvar $800B, $800D		   

                   copybyte $20253C0, $0202e8cc  ;Changes species
		
		   writebytetoaddr $84, $20253E5 ;Changes met location

		   writebytetoaddr $9E, $20253E6 ;Changes met level

		   writebytetoaddr $C0, $020253A8 ;insane hack. I think this is name. 

		   writebytetoaddr $CC, $020253A9 

		   writebytetoaddr $BF, $020253AB

		   writebytetoaddr $C8, $020253AC

		   writebytetoaddr $BE, $020253AD

		   writebytetoaddr $FF, $020253AE

		   setwildbattle $F4, $55, $D7
			
		   callasm $02028DDF

		   writebytetoaddr $0C, $02028EA2 ;this changes the bytes of the program to call givemontoplayer

		   writebytetoaddr $D9, $02028EF5

		   writebytetoaddr $1D, $02028EF4

		   writebytetoaddr $00, $02028eb2

		   writebytetoaddr $00, $02028eb3

		   callasm $02028EA3              ;Call givemontoplayer

		   writebytetoaddr $38, $02028eb2 ;changes bytes to setboxmondata

		   writebytetoaddr $44, $02028eb3

		   writebytetoaddr $0B, $02028EA2

		   writebytetoaddr $D2, $02028EF5

		   writebytetoaddr $ED, $02028EF4

		   callasm $02028EA3              ;call setboxmondata

		   writebytetoaddr $B7, $02028EF5 ;changes bytes to giveboxmonInitialMoveset

		   writebytetoaddr $21, $02028EF4
            
		   callasm $02028EA3              ;call

		   msgbox $2025157

		   db $31

		   dw $13E

		   waitmsg

		   waitkeypress

                   callasm $08135c45 

	           db $97, $01  ;Fades map to black

	           release

		   db $53 ;Next two instructions make Eusine Dissapear

		   dw $24

		   db $63 ;This teleports him to top of map

		   dw $24, $0, $0 

	           db $98, $00, $03 ;Fades map back in.

		   killscript


NoRoom:
		   braillemessage $202508D

		   waitkeypress

		   hidebox $0, $0, $1D, $13

 	   	   end

NoRoom2: 
	msgbox $2025134
	waitmsg
	waitkeypress
	release
	end


FlewAway:
	db $97, $01
	db $97, $00
	msgbox $202503B
	waitmsg
	waitkeypress
	release
	end



NormanScriptEnd:

	
PreloadScriptStart:
	setvirtualaddress PreloadScriptStart


       comparefarbytetobyte $0202886E, $0

       virtualgotoif 1, .delete

	writebytetoaddr $E4, $2024FF0
	writebytetoaddr $E4, $2025090
	writebytetoaddr $E4, $2025130
	writebytetoaddr $E4, $20251D0
	writebytetoaddr $E4, $2025270
	writebytetoaddr $E4, $2025310

	callasm $08135c45

	writebytetoaddr $01, $202533C ;First Braille Box
	writebytetoaddr $03, $202533D
	writebytetoaddr $1C, $202533E
	writebytetoaddr $0E, $202533F
	writebytetoaddr $02, $2025340
	writebytetoaddr $04, $2025341
	writebytetoaddr $2E, $2025342
	writebytetoaddr $01, $2025343
	writebytetoaddr $16, $2025344
	writebytetoaddr $1E, $2025345
	writebytetoaddr $09, $2025346
	writebytetoaddr $00, $2025347
	writebytetoaddr $1B, $2025348
	writebytetoaddr $19, $2025349
	writebytetoaddr $00, $202534A
	writebytetoaddr $16, $202534B
	writebytetoaddr $1E, $202534C
	writebytetoaddr $09, $202534D
	writebytetoaddr $17, $202534E
	writebytetoaddr $FE, $202534F
	writebytetoaddr $06, $2025350
	writebytetoaddr $00, $2025351
	writebytetoaddr $01, $2025352
	writebytetoaddr $13, $2025353
	writebytetoaddr $00, $2025354
	writebytetoaddr $2E, $2025355
	writebytetoaddr $0D, $2025356
	writebytetoaddr $09, $2025357
	writebytetoaddr $1D, $2025358
	writebytetoaddr $09, $2025359
	writebytetoaddr $FE, $202535A
	writebytetoaddr $13, $202535B
	writebytetoaddr $06, $202535C
	writebytetoaddr $1D, $202535D
	writebytetoaddr $01, $202535E
	writebytetoaddr $0F, $202535F
	writebytetoaddr $09, $2025360
	writebytetoaddr $16, $2025361
	writebytetoaddr $00, $2025362
	writebytetoaddr $15, $2025363
	writebytetoaddr $06, $2025364
	writebytetoaddr $35, $2025365
	writebytetoaddr $09, $2025366
	writebytetoaddr $FF, $2025367
	  
	writebytetoaddr $05, $2025368 ;Failure. Try Again.
	writebytetoaddr $06, $2025369
	writebytetoaddr $18, $202536A
	writebytetoaddr $0D, $202536B
	writebytetoaddr $06, $202536C
	writebytetoaddr $07, $202536D
	writebytetoaddr $07, $202536E
	writebytetoaddr $01, $202536F
	writebytetoaddr $06, $2025370
	writebytetoaddr $15, $2025371
	writebytetoaddr $31, $2025372
	writebytetoaddr $1D, $2025373
	writebytetoaddr $09, $2025374
	writebytetoaddr $FE, $2025375
	writebytetoaddr $1E, $2025376
	writebytetoaddr $1D, $2025377
	writebytetoaddr $3B, $2025378
	writebytetoaddr $00, $2025379
	writebytetoaddr $01, $202537A
	writebytetoaddr $0F, $202537B
	writebytetoaddr $01, $202537C
	writebytetoaddr $06, $202537D
	writebytetoaddr $1B, $202537E
	writebytetoaddr $FF, $202537F

 
	writebytetoaddr $00, $202539F ;Alignment byte
	writebytetoaddr $00, $20253A0 ;Temp Suicune
	writebytetoaddr $00, $20253A1
	writebytetoaddr $00, $20253A2
	writebytetoaddr $00, $20253A3
	writebytetoaddr $00, $20253A4
	writebytetoaddr $00, $20253A5
	writebytetoaddr $00, $20253A6
	writebytetoaddr $00, $20253A7
	writebytetoaddr $CD, $20253A8
	writebytetoaddr $CF, $20253A9
	writebytetoaddr $C3, $20253AA
	writebytetoaddr $BD, $20253AB
	writebytetoaddr $CF, $20253AC
	writebytetoaddr $C8, $20253AD
	writebytetoaddr $BF, $20253AE
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
	writebytetoaddr $67, $20253BC
	writebytetoaddr $A7, $20253BD
	writebytetoaddr $00, $20253BE
	writebytetoaddr $00, $20253BF
	writebytetoaddr $F5, $20253C0
	writebytetoaddr $00, $20253C1
	writebytetoaddr $00, $20253C2
	writebytetoaddr $00, $20253C3
	writebytetoaddr $A8, $20253C4
	writebytetoaddr $B6, $20253C5
	writebytetoaddr $0B, $20253C6
	writebytetoaddr $00, $20253C7
	writebytetoaddr $F0, $20253C8
	writebytetoaddr $23, $20253C9
	writebytetoaddr $00, $20253CA
	writebytetoaddr $00, $20253CB
	writebytetoaddr $A4, $20253CC
	writebytetoaddr $00, $20253CD
	writebytetoaddr $5B, $20253CE
	writebytetoaddr $01, $20253CF
	writebytetoaddr $38, $20253D0
	writebytetoaddr $00, $20253D1
	writebytetoaddr $D6, $20253D2
	writebytetoaddr $00, $20253D3
	writebytetoaddr $0A, $20253D4
	writebytetoaddr $14, $20253D5
	writebytetoaddr $08, $20253D6
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
	writebytetoaddr $81, $202501C
	writebytetoaddr $57, $202501D
	writebytetoaddr $06, $202501E
	writebytetoaddr $08, $202501F
	writebytetoaddr $C4, $2025020
	writebytetoaddr $8D, $2025021
	writebytetoaddr $02, $2025022
	writebytetoaddr $02, $2025023

	writebytetoaddr $56, $2025024 ;EusineMove
	writebytetoaddr $12, $2025025
	writebytetoaddr $FE, $2025026

	writebytetoaddr $01, $2025027 ;No room in party braille
	writebytetoaddr $07, $2025028
	writebytetoaddr $1C, $2025029
	writebytetoaddr $0A, $202502A
	writebytetoaddr $02, $202502B
	writebytetoaddr $08, $202502C
	writebytetoaddr $17, $202502D
	writebytetoaddr $01, $202502E
	writebytetoaddr $1D, $202502F
	writebytetoaddr $1E, $2025030
	writebytetoaddr $3B, $2025031
	writebytetoaddr $00, $2025032
	writebytetoaddr $06, $2025033
	writebytetoaddr $16, $2025034
	writebytetoaddr $00, $2025035
	writebytetoaddr $07, $2025036
	writebytetoaddr $31, $2025037
	writebytetoaddr $15, $2025038
	writebytetoaddr $15, $2025039
	writebytetoaddr $FF, $202503A

	writebytetoaddr $CE, $202503B ;Flew away
	writebytetoaddr $DC, $202503C
	writebytetoaddr $D9, $202503D
	writebytetoaddr $00, $202503E
	writebytetoaddr $CD, $202503F
	writebytetoaddr $CF, $2025040
	writebytetoaddr $C3, $2025041
	writebytetoaddr $BD, $2025042
	writebytetoaddr $CF, $2025043
	writebytetoaddr $C8, $2025044
	writebytetoaddr $BF, $2025045
	writebytetoaddr $00, $2025046
	writebytetoaddr $DA, $2025047
	writebytetoaddr $E0, $2025048
	writebytetoaddr $D9, $2025049
	writebytetoaddr $EB, $202504A
	writebytetoaddr $00, $202504B
	writebytetoaddr $D5, $202504C
	writebytetoaddr $EB, $202504D
	writebytetoaddr $D5, $202504E
	writebytetoaddr $ED, $202504F
	writebytetoaddr $AB, $2025050
	writebytetoaddr $FF, $2025051

	writebytetoaddr $FD, $2025052 ;EusineHello
	writebytetoaddr $01, $2025053
	writebytetoaddr $AB, $2025054
	writebytetoaddr $00, $2025055
	writebytetoaddr $C3, $2025056
	writebytetoaddr $00, $2025057
	writebytetoaddr $E7, $2025058
	writebytetoaddr $D9, $2025059
	writebytetoaddr $D9, $202505A
	writebytetoaddr $00, $202505B
	writebytetoaddr $ED, $202505C
	writebytetoaddr $E3, $202505D
	writebytetoaddr $E9, $202505E
	writebytetoaddr $B4, $202505F
	writebytetoaddr $EA, $2025060
	writebytetoaddr $D9, $2025061
	writebytetoaddr $00, $2025062
	writebytetoaddr $D7, $2025063
	writebytetoaddr $D5, $2025064
	writebytetoaddr $E9, $2025065
	writebytetoaddr $DB, $2025066
	writebytetoaddr $DC, $2025067
	writebytetoaddr $E8, $2025068
	writebytetoaddr $00, $2025069
	writebytetoaddr $CC, $202506A
	writebytetoaddr $BB, $202506B
	writebytetoaddr $C3, $202506C
	writebytetoaddr $C5, $202506D
	writebytetoaddr $C9, $202506E
	writebytetoaddr $CF, $202506F
	writebytetoaddr $AB, $2025070
	writebytetoaddr $FE, $2025071
	writebytetoaddr $CD, $2025072
	writebytetoaddr $CF, $2025073
	writebytetoaddr $C3, $2025074
	writebytetoaddr $BD, $2025075
	writebytetoaddr $CF, $2025076
	writebytetoaddr $C8, $2025077
	writebytetoaddr $BF, $2025078
	writebytetoaddr $00, $2025079
	writebytetoaddr $DD, $202507A
	writebytetoaddr $E7, $202507B
	writebytetoaddr $00, $202507C
	writebytetoaddr $D5, $202507D
	writebytetoaddr $E0, $202507E
	writebytetoaddr $E0, $202507F
	writebytetoaddr $00, $2025080
	writebytetoaddr $E8, $2025081
	writebytetoaddr $DC, $2025082
	writebytetoaddr $D5, $2025083
	writebytetoaddr $E8, $2025084
	writebytetoaddr $B4, $2025085
	writebytetoaddr $E7, $2025086
	writebytetoaddr $00, $2025087
	writebytetoaddr $E0, $2025088
	writebytetoaddr $D9, $2025089
	writebytetoaddr $DA, $202508A
	writebytetoaddr $E8, $202508B
	writebytetoaddr $AD, $202508C
	writebytetoaddr $FB, $202508D
	writebytetoaddr $CE, $202508E
	writebytetoaddr $DC, $202508F
	writebytetoaddr $D9, $2025090
	writebytetoaddr $00, $2025091
	writebytetoaddr $DA, $2025092
	writebytetoaddr $DD, $2025093
	writebytetoaddr $E2, $2025094
	writebytetoaddr $D5, $2025095
	writebytetoaddr $E0, $2025096
	writebytetoaddr $00, $2025097
	writebytetoaddr $D7, $2025098
	writebytetoaddr $E0, $2025099
	writebytetoaddr $E9, $202509A
	writebytetoaddr $D9, $202509B
	writebytetoaddr $00, $202509C
	writebytetoaddr $DD, $202509D
	writebytetoaddr $E7, $202509E
	writebytetoaddr $00, $202509F
	writebytetoaddr $DD, $20250A0
	writebytetoaddr $E2, $20250A1
	writebytetoaddr $00, $20250A2
	writebytetoaddr $EA, $20250A3
	writebytetoaddr $DD, $20250A4
	writebytetoaddr $D7, $20250A5
	writebytetoaddr $E8, $20250A6
	writebytetoaddr $E3, $20250A7
	writebytetoaddr $E6, $20250A8
	writebytetoaddr $ED, $20250A9
	writebytetoaddr $00, $20250AA
	writebytetoaddr $E6, $20250AB
	writebytetoaddr $E3, $20250AC
	writebytetoaddr $D5, $20250AD
	writebytetoaddr $D8, $20250AE
	writebytetoaddr $AD, $20250AF
	writebytetoaddr $FE, $20250B0
	writebytetoaddr $C3, $20250B1
	writebytetoaddr $DA, $20250B2
	writebytetoaddr $00, $20250B3
	writebytetoaddr $ED, $20250B4
	writebytetoaddr $E3, $20250B5
	writebytetoaddr $E9, $20250B6
	writebytetoaddr $00, $20250B7
	writebytetoaddr $D7, $20250B8
	writebytetoaddr $D5, $20250B9
	writebytetoaddr $E2, $20250BA
	writebytetoaddr $00, $20250BB
	writebytetoaddr $D6, $20250BC
	writebytetoaddr $E6, $20250BD
	writebytetoaddr $DD, $20250BE
	writebytetoaddr $E2, $20250BF
	writebytetoaddr $DB, $20250C0
	writebytetoaddr $00, $20250C1
	writebytetoaddr $CD, $20250C2
	writebytetoaddr $E9, $20250C3
	writebytetoaddr $DD, $20250C4
	writebytetoaddr $D7, $20250C5
	writebytetoaddr $E9, $20250C6
	writebytetoaddr $E2, $20250C7
	writebytetoaddr $D9, $20250C8
	writebytetoaddr $00, $20250C9
	writebytetoaddr $E8, $20250CA
	writebytetoaddr $E3, $20250CB
	writebytetoaddr $00, $20250CC
	writebytetoaddr $E1, $20250CD
	writebytetoaddr $D9, $20250CE
	writebytetoaddr $B8, $20250CF
	writebytetoaddr $FA, $20250D0
	writebytetoaddr $C3, $20250D1
	writebytetoaddr $B4, $20250D2
	writebytetoaddr $E0, $20250D3
	writebytetoaddr $E0, $20250D4
	writebytetoaddr $00, $20250D5
	writebytetoaddr $D6, $20250D6
	writebytetoaddr $D9, $20250D7
	writebytetoaddr $00, $20250D8
	writebytetoaddr $DA, $20250D9
	writebytetoaddr $E3, $20250DA
	writebytetoaddr $E6, $20250DB
	writebytetoaddr $D9, $20250DC
	writebytetoaddr $EA, $20250DD
	writebytetoaddr $D9, $20250DE
	writebytetoaddr $E6, $20250DF
	writebytetoaddr $00, $20250E0
	writebytetoaddr $DB, $20250E1
	writebytetoaddr $E6, $20250E2
	writebytetoaddr $D5, $20250E3
	writebytetoaddr $E8, $20250E4
	writebytetoaddr $D9, $20250E5
	writebytetoaddr $DA, $20250E6
	writebytetoaddr $E9, $20250E7
	writebytetoaddr $E0, $20250E8
	writebytetoaddr $AB, $20250E9
	writebytetoaddr $FF, $20250EA

	writebytetoaddr $CD, $20250EB ;Eusinethanks
	writebytetoaddr $E9, $20250EC
	writebytetoaddr $DD, $20250ED
	writebytetoaddr $D7, $20250EE
	writebytetoaddr $E9, $20250EF
	writebytetoaddr $E2, $20250F0
	writebytetoaddr $D9, $20250F1
	writebytetoaddr $00, $20250F2
	writebytetoaddr $DD, $20250F3
	writebytetoaddr $E7, $20250F4
	writebytetoaddr $00, $20250F5
	writebytetoaddr $E8, $20250F6
	writebytetoaddr $E6, $20250F7
	writebytetoaddr $E9, $20250F8
	writebytetoaddr $E0, $20250F9
	writebytetoaddr $ED, $20250FA
	writebytetoaddr $00, $20250FB
	writebytetoaddr $DD, $20250FC
	writebytetoaddr $E2, $20250FD
	writebytetoaddr $E7, $20250FE
	writebytetoaddr $E4, $20250FF
	writebytetoaddr $DD, $2025100
	writebytetoaddr $E6, $2025101
	writebytetoaddr $DD, $2025102
	writebytetoaddr $E2, $2025103
	writebytetoaddr $DB, $2025104
	writebytetoaddr $AB, $2025105
	writebytetoaddr $FE, $2025106
	writebytetoaddr $BB, $2025107
	writebytetoaddr $E7, $2025108
	writebytetoaddr $00, $2025109
	writebytetoaddr $D5, $202510A
	writebytetoaddr $00, $202510B
	writebytetoaddr $E8, $202510C
	writebytetoaddr $DC, $202510D
	writebytetoaddr $D5, $202510E
	writebytetoaddr $E2, $202510F
	writebytetoaddr $DF, $2025110
	writebytetoaddr $00, $2025111
	writebytetoaddr $ED, $2025112
	writebytetoaddr $E3, $2025113
	writebytetoaddr $E9, $2025114
	writebytetoaddr $00, $2025115
	writebytetoaddr $DA, $2025116
	writebytetoaddr $E3, $2025117
	writebytetoaddr $E6, $2025118
	writebytetoaddr $00, $2025119
	writebytetoaddr $D5, $202511A
	writebytetoaddr $DD, $202511B
	writebytetoaddr $D8, $202511C
	writebytetoaddr $DD, $202511D
	writebytetoaddr $E2, $202511E
	writebytetoaddr $DB, $202511F
	writebytetoaddr $00, $2025120
	writebytetoaddr $E1, $2025121
	writebytetoaddr $D9, $2025122
	writebytetoaddr $B8, $2025123
	writebytetoaddr $FA, $2025124
	writebytetoaddr $E4, $2025125
	writebytetoaddr $DD, $2025126
	writebytetoaddr $D7, $2025127
	writebytetoaddr $DF, $2025128
	writebytetoaddr $00, $2025129
	writebytetoaddr $D5, $202512A
	writebytetoaddr $00, $202512B
	writebytetoaddr $E2, $202512C
	writebytetoaddr $E9, $202512D
	writebytetoaddr $E1, $202512E
	writebytetoaddr $D6, $202512F
	writebytetoaddr $D9, $2025130
	writebytetoaddr $E6, $2025131
	writebytetoaddr $AB, $2025132
	writebytetoaddr $FF, $2025133

	writebytetoaddr $BD, $2025134 ;EusineNoRoom
	writebytetoaddr $E3, $2025135
	writebytetoaddr $E1, $2025136
	writebytetoaddr $D9, $2025137
	writebytetoaddr $00, $2025138
	writebytetoaddr $D6, $2025139
	writebytetoaddr $D5, $202513A
	writebytetoaddr $D7, $202513B
	writebytetoaddr $DF, $202513C
	writebytetoaddr $00, $202513D
	writebytetoaddr $EB, $202513E
	writebytetoaddr $DD, $202513F
	writebytetoaddr $E8, $2025140
	writebytetoaddr $DC, $2025141
	writebytetoaddr $00, $2025142
	writebytetoaddr $E6, $2025143
	writebytetoaddr $E3, $2025144
	writebytetoaddr $E3, $2025145
	writebytetoaddr $E1, $2025146
	writebytetoaddr $00, $2025147
	writebytetoaddr $DD, $2025148
	writebytetoaddr $E2, $2025149
	writebytetoaddr $00, $202514A
	writebytetoaddr $ED, $202514B
	writebytetoaddr $E3, $202514C
	writebytetoaddr $E9, $202514D
	writebytetoaddr $E6, $202514E
	writebytetoaddr $00, $202514F
	writebytetoaddr $E4, $2025150
	writebytetoaddr $D5, $2025151
	writebytetoaddr $E6, $2025152
	writebytetoaddr $E8, $2025153
	writebytetoaddr $ED, $2025154
	writebytetoaddr $AD, $2025155
	writebytetoaddr $FF, $2025156

	writebytetoaddr $C2, $2025157 ;Take this
	writebytetoaddr $D9, $2025158
	writebytetoaddr $E6, $2025159
	writebytetoaddr $D9, $202515A
	writebytetoaddr $B8, $202515B
	writebytetoaddr $00, $202515C
	writebytetoaddr $E8, $202515D
	writebytetoaddr $D5, $202515E
	writebytetoaddr $DF, $202515F
	writebytetoaddr $D9, $2025160
	writebytetoaddr $00, $2025161
	writebytetoaddr $E8, $2025162
	writebytetoaddr $DC, $2025163
	writebytetoaddr $DD, $2025164
	writebytetoaddr $E7, $2025165
	writebytetoaddr $00, $2025166
	writebytetoaddr $CA, $2025167
	writebytetoaddr $C9, $2025168
	writebytetoaddr $C5, $2025169
	writebytetoaddr $1B, $202516A
	writebytetoaddr $C7, $202516B
	writebytetoaddr $C9, $202516C
	writebytetoaddr $C8, $202516D
	writebytetoaddr $AB, $202516E
	writebytetoaddr $00, $202516F
	writebytetoaddr $C3, $2025170
	writebytetoaddr $E8, $2025171
	writebytetoaddr $B4, $2025172
	writebytetoaddr $E7, $2025173
	writebytetoaddr $00, $2025174
	writebytetoaddr $DA, $2025175
	writebytetoaddr $E6, $2025176
	writebytetoaddr $E3, $2025177
	writebytetoaddr $E1, $2025178
	writebytetoaddr $FE, $2025179
	writebytetoaddr $E1, $202517A
	writebytetoaddr $ED, $202517B
	writebytetoaddr $00, $202517C
	writebytetoaddr $DC, $202517D
	writebytetoaddr $E3, $202517E
	writebytetoaddr $E1, $202517F
	writebytetoaddr $D9, $2025180
	writebytetoaddr $00, $2025181
	writebytetoaddr $E6, $2025182
	writebytetoaddr $D9, $2025183
	writebytetoaddr $DB, $2025184
	writebytetoaddr $DD, $2025185
	writebytetoaddr $E3, $2025186
	writebytetoaddr $E2, $2025187
	writebytetoaddr $AD, $2025188
	writebytetoaddr $00, $2025189
	writebytetoaddr $CE, $202518A
	writebytetoaddr $DD, $202518B
	writebytetoaddr $E0, $202518C
	writebytetoaddr $E0, $202518D
	writebytetoaddr $00, $202518E
	writebytetoaddr $EB, $202518F
	writebytetoaddr $D9, $2025190
	writebytetoaddr $00, $2025191
	writebytetoaddr $E1, $2025192
	writebytetoaddr $D9, $2025193
	writebytetoaddr $D9, $2025194
	writebytetoaddr $E8, $2025195
	writebytetoaddr $00, $2025196
	writebytetoaddr $D5, $2025197
	writebytetoaddr $DB, $2025198
	writebytetoaddr $D5, $2025199
	writebytetoaddr $DD, $202519A
	writebytetoaddr $E2, $202519B
	writebytetoaddr $AB, $202519C
	writebytetoaddr $FF, $202519D


		   virtualloadpointer GoSeeYourFather

		   setbyte 2


	

	end


.delete:


	setbyte 1	

	killscript



DataEnd:
	EOF
  	