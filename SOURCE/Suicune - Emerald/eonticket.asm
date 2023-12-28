INCLUDE "../macros.asm"
INCLUDE "../constants/items.asm"
INCLUDE "../constants/scriptcommandsraikouemerald.asm"

	Mystery_Event

	db CHECKSUM_CRC
	dd 0 ; checksum placeholder
	GBAPTR DataStart
	GBAPTR DataEnd

DataStart:
	db IN_GAME_SCRIPT
	db 0,26 ; Route 111
	db 34     ; Guy near winstrates.
	GBAPTR NormanScriptStart
	GBAPTR NormanScriptEnd

	db PRELOAD_SCRIPT
	GBAPTR PreloadScriptStart

	db END_OF_CHUNKS




NormanScriptStart:
	setvirtualaddress NormanScriptStart



	           db $43                  ;This checks if your party is bigger than 0

		   compare LASTRESULT, 0   ;It's so I can store thumb code in static spot. 

		   virtualgotoif 2, Start  ;It should never fail.


		   BEASTRNG



		      
Start:

		   callasm $02025301

		   writebytetoaddr $00, $030026F9
		
                   checkflag $91B

	           virtualgotoif 1, MirageIsland

                   checkflag $91A

	           virtualgotoif 1, VictoryRoad	

		   setflag $91A		

		   fadesong $164

		   pause $10

		   applymovement $22, $020251C0

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

		   dw $22

		   db $63 ;This teleports him to top of map

		   dw $22, $0, $0 

	           db $98, $00, $03 ;Fades map back in.

	   	   db $35 ;this returns the songs map to current map

                   writebytetoaddr $18, $0202912D ;Sets ramscript person event to victory road boulder.
                  
		   writebytetoaddr $2C, $0202912E

                   writebytetoaddr $06, $0202912F

		   callasm $020251A5

		   end
			

VictoryRoad:

		   braillemessage $02025640

		   waitkeypress

		   db $DA

		   writebytetoaddr $00, $020263C8 ;Sets step count to be 0.

                   setflag $91B

                   copybyte $02026DE4, $020244EC

                   copybyte $02026DE5, $020244ED

                   copybyte $02026DE6, $020244EE

                   copybyte $02026DE7, $020244EF

		   db $8A, $52, $24, $5 ;resets mirage island berry tree

		   special $13D

		   sound $A3

		   db $30

		   special $13D

		   sound $8

		   db $30

                   writebytetoaddr $0, $0202912D  ;Mapgroup Sets ramscript berry mirage island.
                  
		   writebytetoaddr $2D, $0202912E ;Map index

                   writebytetoaddr $03, $0202912F ;person event

		   callasm $020251A5              ;calcramscript checksum

 	   	   end	

		   
MirageIsland:
		
		   comparefarbytetobyte $020263C8, $94 ;Checking if steps were long enough.

		   virtualgotoif 3, Battle

		   sound $16

                   clearflag $91B		

		   braillemessage $202566C ;Failure. Try Again.

		   waitkeypress

		   db $DA ;This is emerald only hidebraillebox

                   writebytetoaddr $18, $0202912D ;Sets ramscript person event to victory road boulder.
                  
		   writebytetoaddr $2C, $0202912E

                   writebytetoaddr $06, $0202912F

		   callasm $020251A5

		   end

Battle:



		   db $43

		   compare LASTRESULT, 5

		   virtualgotoif 2, NoRoom2

		   copyvar $800B, $800D

		   setwildbattle $F4, $55, $D7

		   callasm $02029143

		   writebytetoaddr $00, $02028590

		   writebytetoaddr $68, $02025398

		   writebytetoaddr $54, $02025399

		   applymovement $FF, $020251C0

		   sound $15

		   db $30

		   special $13D
	 	   
		   sound $D8

		   db $30

		   playmoncry $F5, $0

                   waitmoncry

		   special $145
		
		   playsong $0166, $0

		   callasm $020253A1

		   waitstate

		   db $00

		   db $00

		   db $00

		   pause $A0

		   callasm $02025301

		   writebytetoaddr $00, $030026F9

		   db $43

		   comparevar LASTRESULT, $800B		   
		   
		   virtualgotoif 3, FlewAway

                   callasm $02029207

		   copyvarifnotzero $8000, LIECHI_BERRY

		   copyvarifnotzero $8001, 1

		   checkitemtype $0005

		   callstd 1

		   db $8A, $52, $24, $5 ;resets mirage island berry tree

                   writebytetoaddr $00, $0202912D ;Sets ramscript person event to original Eusine. 
                  
		   writebytetoaddr $1A, $0202912E

                   writebytetoaddr $24, $0202912F

                   setflag $91C	

		   callasm $020251A5  ;calcramscript checksum

		   killscript





NoRoom2: 
	virtualmsgbox NoRoom
	waitmsg
	waitkeypress
	release
	end


FlewAway:

        copybyte $03005D80, $02022C34

        copybyte $03005D81, $02022C35

        copybyte $03005D82, $02022C36

        copybyte $03005D83, $02022C37
	virtualmsgbox Flew
	waitmsg
	waitkeypress
	release
	writebytetoaddr $65, $02025398
	writebytetoaddr $92, $02025399
	end

Flew:
        Text_EN "The SUICUNE flew away!@"

Hello:
	Text_EN "\v1! I see you’ve caught RAIKOU.\n"
	Text_EN "SUICUNE is all that’s left.\p"
	Text_EN "The final clue is in VICTORY ROAD.\n"
	Text_EN "If you can bring SUICUNE to me,\l"
	Text_EN "I’ll be forever grateful!@"

NoRoom:
	Text_EN "There is no room in your party.@"

NormanScriptEnd:

	
PreloadScriptStart:
	setvirtualaddress PreloadScriptStart


       checkflag $918

       virtualgotoif 5, .delete


	writebytetoaddr $01, $2024744 ;First two Braille Boxes and Temp Suicune
	writebytetoaddr $03, $2024745
	writebytetoaddr $1C, $2024746
	writebytetoaddr $0E, $2024747
	writebytetoaddr $02, $2024748
	writebytetoaddr $04, $2024749
	writebytetoaddr $2E, $202474A
	writebytetoaddr $01, $202474B
	writebytetoaddr $16, $202474C
	writebytetoaddr $1E, $202474D
	writebytetoaddr $09, $202474E
	writebytetoaddr $00, $202474F
	writebytetoaddr $1B, $2024750
	writebytetoaddr $19, $2024751
	writebytetoaddr $00, $2024752
	writebytetoaddr $16, $2024753
	writebytetoaddr $1E, $2024754
	writebytetoaddr $09, $2024755
	writebytetoaddr $17, $2024756
	writebytetoaddr $FE, $2024757
	writebytetoaddr $06, $2024758
	writebytetoaddr $00, $2024759
	writebytetoaddr $01, $202475A
	writebytetoaddr $13, $202475B
	writebytetoaddr $00, $202475C
	writebytetoaddr $2E, $202475D
	writebytetoaddr $0D, $202475E
	writebytetoaddr $09, $202475F
	writebytetoaddr $1D, $2024760
	writebytetoaddr $09, $2024761
	writebytetoaddr $FE, $2024762
	writebytetoaddr $13, $2024763
	writebytetoaddr $06, $2024764
	writebytetoaddr $1D, $2024765
	writebytetoaddr $01, $2024766
	writebytetoaddr $0F, $2024767
	writebytetoaddr $09, $2024768
	writebytetoaddr $16, $2024769
	writebytetoaddr $00, $202476A
	writebytetoaddr $15, $202476B
	writebytetoaddr $06, $202476C
	writebytetoaddr $35, $202476D
	writebytetoaddr $09, $202476E
	writebytetoaddr $FF, $202476F
	writebytetoaddr $05, $2024770
	writebytetoaddr $06, $2024771
	writebytetoaddr $18, $2024772
	writebytetoaddr $0D, $2024773
	writebytetoaddr $06, $2024774
	writebytetoaddr $07, $2024775
	writebytetoaddr $07, $2024776
	writebytetoaddr $01, $2024777
	writebytetoaddr $06, $2024778
	writebytetoaddr $15, $2024779
	writebytetoaddr $31, $202477A
	writebytetoaddr $1D, $202477B
	writebytetoaddr $09, $202477C
	writebytetoaddr $FE, $202477D
	writebytetoaddr $1E, $202477E
	writebytetoaddr $1D, $202477F
	writebytetoaddr $3B, $2024780
	writebytetoaddr $00, $2024781
	writebytetoaddr $01, $2024782
	writebytetoaddr $0F, $2024783
	writebytetoaddr $01, $2024784
	writebytetoaddr $06, $2024785
	writebytetoaddr $1B, $2024786
	writebytetoaddr $FF, $2024787
	writebytetoaddr $06, $2024788
	writebytetoaddr $1D, $2024789
	writebytetoaddr $16, $202478A
	writebytetoaddr $1E, $202478B
	writebytetoaddr $FF, $202478C
	writebytetoaddr $01, $202478D
	writebytetoaddr $05, $202478E
	writebytetoaddr $0B, $202478F
	writebytetoaddr $09, $2024790
	writebytetoaddr $07, $2024791
	writebytetoaddr $0E, $2024792
	writebytetoaddr $15, $2024793
	writebytetoaddr $13, $2024794
	writebytetoaddr $19, $2024795
	writebytetoaddr $34, $2024796
	writebytetoaddr $39, $2024797
	writebytetoaddr $1E, $2024798
	writebytetoaddr $11, $2024799
	writebytetoaddr $00, $202479A
	writebytetoaddr $01, $202479B
	writebytetoaddr $03, $202479C
	writebytetoaddr $04, $202479D
	writebytetoaddr $05, $202479E
	writebytetoaddr $09, $202479F
	writebytetoaddr $0B, $20247A0
	writebytetoaddr $0C, $20247A1
	writebytetoaddr $0E, $20247A2
	writebytetoaddr $1B, $20247A3
	writebytetoaddr $19, $20247A4
	writebytetoaddr $13, $20247A5
	writebytetoaddr $16, $20247A6
	writebytetoaddr $00, $20247A7
	writebytetoaddr $00, $20247A8
	writebytetoaddr $00, $20247A9
	writebytetoaddr $00, $20247AA
	writebytetoaddr $00, $20247AB
	writebytetoaddr $00, $20247AC
	writebytetoaddr $00, $20247AD
	writebytetoaddr $00, $20247AE
	writebytetoaddr $00, $20247AF
	writebytetoaddr $CD, $20247B0
	writebytetoaddr $CF, $20247B1
	writebytetoaddr $C3, $20247B2
	writebytetoaddr $BD, $20247B3
	writebytetoaddr $CF, $20247B4
	writebytetoaddr $C8, $20247B5
	writebytetoaddr $BF, $20247B6
	writebytetoaddr $FF, $20247B7
	writebytetoaddr $FF, $20247B8
	writebytetoaddr $FF, $20247B9
	writebytetoaddr $02, $20247BA
	writebytetoaddr $02, $20247BB
	writebytetoaddr $C0, $20247BC
	writebytetoaddr $BB, $20247BD
	writebytetoaddr $CC, $20247BE
	writebytetoaddr $CE, $20247BF
	writebytetoaddr $FF, $20247C0
	writebytetoaddr $00, $20247C1
	writebytetoaddr $00, $20247C2
	writebytetoaddr $00, $20247C3
	writebytetoaddr $67, $20247C4
	writebytetoaddr $A7, $20247C5
	writebytetoaddr $00, $20247C6
	writebytetoaddr $00, $20247C7
	writebytetoaddr $F5, $20247C8
	writebytetoaddr $00, $20247C9
	writebytetoaddr $00, $20247CA
	writebytetoaddr $00, $20247CB
	writebytetoaddr $A8, $20247CC
	writebytetoaddr $B6, $20247CD
	writebytetoaddr $0B, $20247CE
	writebytetoaddr $00, $20247CF
	writebytetoaddr $F0, $20247D0
	writebytetoaddr $23, $20247D1
	writebytetoaddr $00, $20247D2
	writebytetoaddr $00, $20247D3
	writebytetoaddr $A4, $20247D4
	writebytetoaddr $00, $20247D5
	writebytetoaddr $5B, $20247D6
	writebytetoaddr $01, $20247D7
	writebytetoaddr $38, $20247D8
	writebytetoaddr $00, $20247D9
	writebytetoaddr $D6, $20247DA
	writebytetoaddr $00, $20247DB
	writebytetoaddr $0A, $20247DC
	writebytetoaddr $14, $20247DD
	writebytetoaddr $08, $20247DE
	writebytetoaddr $0F, $20247DF
	writebytetoaddr $00, $20247E0
	writebytetoaddr $00, $20247E1
	writebytetoaddr $00, $20247E2
	writebytetoaddr $00, $20247E3
	writebytetoaddr $00, $20247E4
	writebytetoaddr $00, $20247E5
	writebytetoaddr $00, $20247E6
	writebytetoaddr $00, $20247E7
	writebytetoaddr $00, $20247E8
	writebytetoaddr $00, $20247E9
	writebytetoaddr $00, $20247EA
	writebytetoaddr $00, $20247EB
	writebytetoaddr $00, $20247EC
	writebytetoaddr $7D, $20247ED
	writebytetoaddr $A8, $20247EE
	writebytetoaddr $27, $20247EF
	writebytetoaddr $00, $20247F0
	writebytetoaddr $00, $20247F1
	writebytetoaddr $00, $20247F2
	writebytetoaddr $00, $20247F3
	writebytetoaddr $00, $20247F4
	writebytetoaddr $00, $20247F5
	writebytetoaddr $00, $20247F6
	writebytetoaddr $01, $20247F7

	writebytetoaddr $00, $20248FB ;MemCopy CallASM
	writebytetoaddr $04, $20248FC ;This memory copies from enemy ram to Battle-E Location
	writebytetoaddr $4D, $20248FD
	writebytetoaddr $2D, $20248FE
	writebytetoaddr $68, $20248FF
	writebytetoaddr $04, $2024900
	writebytetoaddr $48, $2024901
	writebytetoaddr $06, $2024902
	writebytetoaddr $49, $2024903
	writebytetoaddr $04, $2024904
	writebytetoaddr $4A, $2024905
	writebytetoaddr $06, $2024906
	writebytetoaddr $4E, $2024907
	writebytetoaddr $AD, $2024908
	writebytetoaddr $1B, $2024909
	writebytetoaddr $29, $202490A
	writebytetoaddr $44, $202490B
	writebytetoaddr $0B, $202490C
	writebytetoaddr $DF, $202490D
	writebytetoaddr $70, $202490E
	writebytetoaddr $47, $202490F
	writebytetoaddr $90, $2024910
	writebytetoaddr $5D, $2024911
	writebytetoaddr $00, $2024912
	writebytetoaddr $03, $2024913
	writebytetoaddr $44, $2024914
	writebytetoaddr $47, $2024915
	writebytetoaddr $02, $2024916
	writebytetoaddr $02, $2024917
	writebytetoaddr $2D, $2024918
	writebytetoaddr $00, $2024919
	writebytetoaddr $00, $202491A
	writebytetoaddr $04, $202491B
	writebytetoaddr $40, $202491C
	writebytetoaddr $56, $202491D
	writebytetoaddr $02, $202491E
	writebytetoaddr $02, $202491F
	writebytetoaddr $54, $2024920
	writebytetoaddr $4A, $2024921
	writebytetoaddr $02, $2024922
	writebytetoaddr $02, $2024923

        callasm $20248FD ;Do Memory Copy


	writebytetoaddr $E4, $2024744 ;Rest of stuff
	writebytetoaddr $B4, $2024745
	writebytetoaddr $D8, $2024746
	writebytetoaddr $9C, $2024747
	writebytetoaddr $78, $2024748
	writebytetoaddr $6C, $2024749
	writebytetoaddr $E1, $202474A
	writebytetoaddr $B1, $202474B
	writebytetoaddr $D2, $202474C
	writebytetoaddr $93, $202474D
	writebytetoaddr $72, $202474E
	writebytetoaddr $63, $202474F
	writebytetoaddr $C9, $2024750
	writebytetoaddr $8D, $2024751
	writebytetoaddr $C6, $2024752
	writebytetoaddr $87, $2024753
	writebytetoaddr $4E, $2024754
	writebytetoaddr $4B, $2024755
	writebytetoaddr $39, $2024756
	writebytetoaddr $2D, $2024757
	writebytetoaddr $36, $2024758
	writebytetoaddr $27, $2024759
	writebytetoaddr $1E, $202475A
	writebytetoaddr $1B, $202475B
	writebytetoaddr $FF, $202475C
	writebytetoaddr $B5, $202475D
	writebytetoaddr $7C, $202475E
	writebytetoaddr $46, $202475F
	writebytetoaddr $07, $2024760
	writebytetoaddr $34, $2024761
	writebytetoaddr $A6, $2024762
	writebytetoaddr $46, $2024763
	writebytetoaddr $02, $2024764
	writebytetoaddr $48, $2024765
	writebytetoaddr $00, $2024766
	writebytetoaddr $47, $2024767
	writebytetoaddr $02, $2024768
	writebytetoaddr $4A, $2024769
	writebytetoaddr $10, $202476A
	writebytetoaddr $80, $202476B
	writebytetoaddr $FF, $202476C
	writebytetoaddr $BD, $202476D
	writebytetoaddr $00, $202476E
	writebytetoaddr $00, $202476F
	writebytetoaddr $AD, $2024770
	writebytetoaddr $90, $2024771
	writebytetoaddr $09, $2024772
	writebytetoaddr $08, $2024773
	writebytetoaddr $28, $2024774
	writebytetoaddr $91, $2024775
	writebytetoaddr $02, $2024776
	writebytetoaddr $02, $2024777
	writebytetoaddr $56, $2024778
	writebytetoaddr $12, $2024779
	writebytetoaddr $FE, $202477A
	
	
	writebytetoaddr $35, $2024918
	writebytetoaddr $8C, $202491C
	writebytetoaddr $51, $202491D
 

        callasm $20248FD ;Do Memory Copy

	writebytetoaddr $00, $2024744 ;ASLR Compensation code. Forces ASLR to be lowes value code or w/e.
	writebytetoaddr $00, $2024745
	writebytetoaddr $17, $2024746
	writebytetoaddr $4E, $2024747
	writebytetoaddr $30, $2024748
	writebytetoaddr $68, $2024749
	writebytetoaddr $17, $202474A
	writebytetoaddr $49, $202474B
	writebytetoaddr $08, $202474C
	writebytetoaddr $60, $202474D
	writebytetoaddr $17, $202474E
	writebytetoaddr $48, $202474F
	writebytetoaddr $00, $2024750
	writebytetoaddr $68, $2024751
	writebytetoaddr $17, $2024752
	writebytetoaddr $49, $2024753
	writebytetoaddr $47, $2024754
	writebytetoaddr $1A, $2024755
	writebytetoaddr $17, $2024756
	writebytetoaddr $48, $2024757
	writebytetoaddr $17, $2024758
	writebytetoaddr $49, $2024759
	writebytetoaddr $01, $202475A
	writebytetoaddr $60, $202475B
	writebytetoaddr $17, $202475C
	writebytetoaddr $4A, $202475D
	writebytetoaddr $02, $202475E
	writebytetoaddr $23, $202475F
	writebytetoaddr $13, $2024760
	writebytetoaddr $70, $2024761
	writebytetoaddr $17, $2024762
	writebytetoaddr $48, $2024763
	writebytetoaddr $38, $2024764
	writebytetoaddr $44, $2024765
	writebytetoaddr $01, $2024766
	writebytetoaddr $78, $2024767
	writebytetoaddr $01, $2024768
	writebytetoaddr $30, $2024769
	writebytetoaddr $02, $202476A
	writebytetoaddr $78, $202476B
	writebytetoaddr $01, $202476C
	writebytetoaddr $30, $202476D
	writebytetoaddr $03, $202476E
	writebytetoaddr $78, $202476F
	writebytetoaddr $01, $2024770
	writebytetoaddr $30, $2024771
	writebytetoaddr $04, $2024772
	writebytetoaddr $78, $2024773
	writebytetoaddr $11, $2024774
	writebytetoaddr $44, $2024775
	writebytetoaddr $19, $2024776
	writebytetoaddr $44, $2024777
	writebytetoaddr $21, $2024778
	writebytetoaddr $44, $2024779
	writebytetoaddr $49, $202477A
	writebytetoaddr $42, $202477B
	writebytetoaddr $11, $202477C
	writebytetoaddr $4A, $202477D
	writebytetoaddr $12, $202477E
	writebytetoaddr $4B, $202477F
	writebytetoaddr $09, $2024780
	writebytetoaddr $04, $2024781
	writebytetoaddr $51, $2024782
	writebytetoaddr $43, $2024783
	writebytetoaddr $19, $2024784
	writebytetoaddr $44, $2024785
	writebytetoaddr $31, $2024786
	writebytetoaddr $60, $2024787
	writebytetoaddr $00, $2024788
	writebytetoaddr $00, $2024789
	writebytetoaddr $00, $202478A
	writebytetoaddr $00, $202478B
	writebytetoaddr $14, $202478C
	writebytetoaddr $4A, $202478D
	writebytetoaddr $0F, $202478E
	writebytetoaddr $4B, $202478F
	writebytetoaddr $00, $2024790
	writebytetoaddr $00, $2024791
	writebytetoaddr $0F, $2024792
	writebytetoaddr $48, $2024793
	writebytetoaddr $0F, $2024794
	writebytetoaddr $49, $2024795
	writebytetoaddr $01, $2024796
	writebytetoaddr $60, $2024797
	writebytetoaddr $0F, $2024798
	writebytetoaddr $48, $2024799
	writebytetoaddr $10, $202479A
	writebytetoaddr $49, $202479B
	writebytetoaddr $01, $202479C
	writebytetoaddr $60, $202479D
	writebytetoaddr $00, $202479E
	writebytetoaddr $00, $202479F
	writebytetoaddr $13, $20247A0
	writebytetoaddr $60, $20247A1
	writebytetoaddr $70, $20247A2
	writebytetoaddr $47, $20247A3
	writebytetoaddr $80, $20247A4
	writebytetoaddr $5D, $20247A5
	writebytetoaddr $00, $20247A6
	writebytetoaddr $03, $20247A7
	writebytetoaddr $34, $20247A8
	writebytetoaddr $2C, $20247A9
	writebytetoaddr $02, $20247AA
	writebytetoaddr $02, $20247AB
	writebytetoaddr $90, $20247AC
	writebytetoaddr $5D, $20247AD
	writebytetoaddr $00, $20247AE
	writebytetoaddr $03, $20247AF
	writebytetoaddr $54, $20247B0
	writebytetoaddr $4A, $20247B1
	writebytetoaddr $02, $20247B2
	writebytetoaddr $02, $20247B3
	writebytetoaddr $EC, $20247B4
	writebytetoaddr $2F, $20247B5
	writebytetoaddr $02, $20247B6
	writebytetoaddr $02, $20247B7
	writebytetoaddr $02, $20247B8
	writebytetoaddr $00, $20247B9
	writebytetoaddr $3E, $20247BA
	writebytetoaddr $01, $20247BB
	writebytetoaddr $F9, $20247BC
	writebytetoaddr $26, $20247BD
	writebytetoaddr $00, $20247BE
	writebytetoaddr $03, $20247BF
	writebytetoaddr $5E, $20247C0
	writebytetoaddr $4A, $20247C1
	writebytetoaddr $02, $20247C2
	writebytetoaddr $02, $20247C3
	writebytetoaddr $65, $20247C4
	writebytetoaddr $EB, $20247C5
	writebytetoaddr $B9, $20247C6
	writebytetoaddr $EE, $20247C7
	writebytetoaddr $A1, $20247C8
	writebytetoaddr $61, $20247C9
	writebytetoaddr $35, $20247CA
	writebytetoaddr $0A, $20247CB
	writebytetoaddr $B1, $20247CC
	writebytetoaddr $61, $20247CD
	writebytetoaddr $08, $20247CE
	writebytetoaddr $08, $20247CF
	writebytetoaddr $C4, $20247D0
	writebytetoaddr $75, $20247D1
	writebytetoaddr $03, $20247D2
	writebytetoaddr $02, $20247D3
	writebytetoaddr $00, $20247D4
	writebytetoaddr $6F, $20247D5
	writebytetoaddr $FD, $20247D6
	writebytetoaddr $FF, $20247D7
	writebytetoaddr $48, $20247D8
	writebytetoaddr $0E, $20247D9
	writebytetoaddr $00, $20247DA
	writebytetoaddr $03, $20247DB
	writebytetoaddr $65, $20247DC
	writebytetoaddr $92, $20247DD
	writebytetoaddr $02, $20247DE
	writebytetoaddr $02, $20247DF
	writebytetoaddr $C4, $20247E0
	writebytetoaddr $22, $20247E1
	writebytetoaddr $00, $20247E2
	writebytetoaddr $03, $20247E3

	writebytetoaddr $28, $2024918
	writebytetoaddr $00, $202491C
	writebytetoaddr $53, $202491D

        callasm $20248FD ;Do Memory Copy Again

	writebytetoaddr $03, $2024744 ;Memory copy for second half of script
	writebytetoaddr $48, $2024745
	writebytetoaddr $05, $2024746
	writebytetoaddr $49, $2024747
	writebytetoaddr $03, $2024748
	writebytetoaddr $4A, $2024749
	writebytetoaddr $0B, $202474A
	writebytetoaddr $DF, $202474B
	writebytetoaddr $04, $202474C
	writebytetoaddr $48, $202474D
	writebytetoaddr $05, $202474E
	writebytetoaddr $49, $202474F
	writebytetoaddr $08, $2024750
	writebytetoaddr $60, $2024751
	writebytetoaddr $70, $2024752
	writebytetoaddr $47, $2024753
	writebytetoaddr $AC, $2024754
	writebytetoaddr $93, $2024755
	writebytetoaddr $02, $2024756
	writebytetoaddr $02, $2024757
	writebytetoaddr $54, $2024758
	writebytetoaddr $00, $2024759
	writebytetoaddr $00, $202475A
	writebytetoaddr $04, $202475B
	writebytetoaddr $60, $202475C
	writebytetoaddr $54, $202475D
	writebytetoaddr $02, $202475E
	writebytetoaddr $02, $202475F
	writebytetoaddr $60, $2024760
	writebytetoaddr $54, $2024761
	writebytetoaddr $02, $2024762
	writebytetoaddr $02, $2024763
	writebytetoaddr $48, $2024764
	writebytetoaddr $0E, $2024765
	writebytetoaddr $00, $2024766
	writebytetoaddr $03, $2024767


	writebytetoaddr $09, $2024918
	writebytetoaddr $A0, $202491C
	writebytetoaddr $53, $202491D

        callasm $20248FD ;Do Memory Copy Again


	end


.delete:


	setbyte 1	

	killscript



DataEnd:
	EOF
  	