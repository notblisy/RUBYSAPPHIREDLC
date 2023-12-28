INCLUDE "../macros.asm"
INCLUDE "../constants/items.asm"
INCLUDE "../constants/scriptcommandscelebibattleunlockedem.asm"

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
	Text_EN "A bright flash was seen in\n"
	Text_EN "PETALBURG WOODS!\p"
	Text_EN "Ever since, a rare Pokemon has been\n" 
	Text_EN "seen healing thin trees.@"



NormanScriptStart:
	setvirtualaddress NormanScriptStart

		   callasm $02025301

		   writebytetoaddr $00, $030026F9

	           virtualmsgbox Poor
		   waitmsg
		   db $6E, $17, $8
	           release

		   compare LASTRESULT, 0

		   virtualgotoif 1, Changemind	

		   virtualgotoif 5, CelebiEvent		   
			  			

			   db $00

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

		   writebytetoaddr $00, $02028590

		   writebytetoaddr $69, $02025398

		   writebytetoaddr $54, $02025399

		   setwildbattle $F4, $30, $00

		   callasm $020291BD ;LOAD STORE PARTY

		   callasm $020291D1 ;Colo RNG
	
		   callasm $020292B1 ;Memcopy 

		   callasm $020292C1 ;checksum

		   callasm $020292F5 ;copy celebi over

		   callasm $0202930D

		   special $13F

		   sound $13
		
		   waitstate

		   playmoncry $FB, $0

		   virtualmsgbox Celebi

		   waitmsg

                   waitmoncry

		   waitkeypress

		   release

		   special $145
		
		   playsong $0166, $0

                   waitmoncry

		   callasm $020253A1

		   waitstate

		   db $00

		   db $00

		   db $00

		   pause $80

		   callasm $02025301

		   writebytetoaddr $00, $030026F9

		   db $43

		   comparevar LASTRESULT, $800B		   
		   
		   virtualgotoif 3, FlewAway

		   virtualgotoif 2, Catch




Catch:
                   callasm $020292D1
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
        copybyte $03005D80, $02022C34

        copybyte $03005D81, $02022C35

        copybyte $03005D82, $02022C36

        copybyte $03005D83, $02022C37
	virtualmsgbox Flew
	waitmsg
	waitkeypress
	release
	writebytetoaddr $3A, $02025398
	writebytetoaddr $91, $02025399
	end

PartyFull:
	Text_EN "You need space in your party\n"
	Text_EN "to play this MYSTERY EVENT!@"
Poor:
	Text_EN "A Pokemon is rustling around\n"
	Text_EN "in this tree.\p"
	Text_EN "Would you like to investigate?@"
Change:
	Text_EN "Maybe another time.@"
Flew:
    Text_EN "The CELEBI flew away!@"

NoSpace:
	Text_EN "You need space in your party\n"
	Text_EN "to capture CELEBI!@"

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

	writebytetoaddr $00, $2024744 ;Temp Celebi
	writebytetoaddr $00, $2024745
	writebytetoaddr $00, $2024746
	writebytetoaddr $00, $2024747
	writebytetoaddr $91, $2024748
	writebytetoaddr $79, $2024749
	writebytetoaddr $00, $202474A
	writebytetoaddr $00, $202474B
	writebytetoaddr $5E, $202474C
	writebytetoaddr $7A, $202474D
	writebytetoaddr $97, $202474E
	writebytetoaddr $80, $202474F
	writebytetoaddr $FF, $2024750
	writebytetoaddr $00, $2024751
	writebytetoaddr $00, $2024752
	writebytetoaddr $00, $2024753
	writebytetoaddr $00, $2024754
	writebytetoaddr $00, $2024755
	writebytetoaddr $01, $2024756
	writebytetoaddr $02, $2024757
	writebytetoaddr $51, $2024758
	writebytetoaddr $8A, $2024759
	writebytetoaddr $64, $202475A
	writebytetoaddr $FF, $202475B
	writebytetoaddr $00, $202475C
	writebytetoaddr $00, $202475D
	writebytetoaddr $00, $202475E
	writebytetoaddr $00, $202475F
	writebytetoaddr $CB, $2024760
	writebytetoaddr $18, $2024761
	writebytetoaddr $00, $2024762
	writebytetoaddr $00, $2024763
	writebytetoaddr $FB, $2024764
	writebytetoaddr $00, $2024765
	writebytetoaddr $00, $2024766
	writebytetoaddr $00, $2024767
	writebytetoaddr $30, $2024768
	writebytetoaddr $02, $2024769
	writebytetoaddr $00, $202476A
	writebytetoaddr $00, $202476B
	writebytetoaddr $00, $202476C
	writebytetoaddr $46, $202476D
	writebytetoaddr $00, $202476E
	writebytetoaddr $00, $202476F
	writebytetoaddr $5D, $2024770
	writebytetoaddr $00, $2024771
	writebytetoaddr $69, $2024772
	writebytetoaddr $00, $2024773
	writebytetoaddr $D7, $2024774
	writebytetoaddr $00, $2024775
	writebytetoaddr $DB, $2024776
	writebytetoaddr $00, $2024777
	writebytetoaddr $19, $2024778
	writebytetoaddr $14, $2024779
	writebytetoaddr $05, $202477A
	writebytetoaddr $19, $202477B
	writebytetoaddr $00, $202477C
	writebytetoaddr $00, $202477D
	writebytetoaddr $00, $202477E
	writebytetoaddr $00, $202477F
	writebytetoaddr $00, $2024780
	writebytetoaddr $00, $2024781
	writebytetoaddr $00, $2024782
	writebytetoaddr $00, $2024783
	writebytetoaddr $00, $2024784
	writebytetoaddr $00, $2024785
	writebytetoaddr $00, $2024786
	writebytetoaddr $00, $2024787
	writebytetoaddr $00, $2024788
	writebytetoaddr $FF, $2024789
	writebytetoaddr $0A, $202478A
	writebytetoaddr $A1, $202478B
	writebytetoaddr $00, $202478C
	writebytetoaddr $00, $202478D
	writebytetoaddr $00, $202478E
	writebytetoaddr $00, $202478F
	writebytetoaddr $00, $2024790
	writebytetoaddr $00, $2024791
	writebytetoaddr $00, $2024792
	writebytetoaddr $00, $2024793

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
	writebytetoaddr $69, $20247D4
	writebytetoaddr $6F, $20247D5
	writebytetoaddr $FD, $20247D6
	writebytetoaddr $FF, $20247D7
	writebytetoaddr $48, $20247D8
	writebytetoaddr $0E, $20247D9
	writebytetoaddr $00, $20247DA
	writebytetoaddr $03, $20247DB
	writebytetoaddr $3A, $20247DC
	writebytetoaddr $91, $20247DD
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
	writebytetoaddr $88, $2024754
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





DataEnd:
	EOF
  	