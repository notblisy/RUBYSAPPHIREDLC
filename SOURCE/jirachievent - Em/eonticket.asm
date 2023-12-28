INCLUDE "../macros.asm"
INCLUDE "../constants/items.asm"
INCLUDE "../constants/scriptcommandsjirachibattleemerald.asm"

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
	Text_EN "The WHITE ROCK in MOSSDEEP has\n"
	Text_EN "been glowing...@"




NormanScriptStart:
	setvirtualaddress NormanScriptStart


Start:
		   callasm $02025301

		   writebytetoaddr $00, $030026F9

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
	db $00

			   CHANNELRNG
			   STORAGETABLE
			   TEMPJIRACHI2
			   STRUCTURETABLEG
			   MEMCOPYJIRACHI
			   RETURN
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

		   virtualgotoif 5, Movement1

Movement0:

		   
                   applymovement $FF, $020292E4

                   waitmovement $FF

Movement1:



                   applymovement $FF, $020292E7

battle:
                   waitmovement $FF

		   pause $10

		   special $13D	   

		   sound $83

		   pause $10

		   pause $10

                   applymovement $FF, $020292EC

                   waitmovement $FF

		   sound $15

		   writebytetoaddr $00, $02028590

		   writebytetoaddr $69, $02025398

		   writebytetoaddr $54, $02025399

		   setwildbattle $F4, $30, $00

		   virtualmsgbox Pokemon

		   waitmsg

		   waitkeypress

		   release

		   playmoncry $199, $0

		   virtualmsgbox Jirachi

		   waitmsg

		   waitkeypress

		   release

		   callasm $02029161

		   callasm $0202518D

                   waitmoncry

		   special $145
		
		   playsong $01CE, $0

                   db $00

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


Catch:
                   callasm $020251C1
		   killscript


NoRoom:
	virtualmsgbox NoSpace
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
	writebytetoaddr $3A, $02025398
	writebytetoaddr $91, $02025399
	end

Wish:
	Text_EN "Do you have a wish?@"

Youdo:
	Text_EN "You do? Then leave a wish tag\n"
	Text_EN "on the WHITE ROCK!@"
Change:
	Text_EN "Really? I thought everyone had\n"
	Text_EN "a wish.@"
Flew:
        Text_EN "JIRACHI ran away!@"
NoSpace:
	Text_EN "You can’t wish with a\n"
	Text_EN "full party!@"

Pokemon:
	Text_EN "Huh? A POKéMON?@"
Jirachi:
	Text_EN "Wiish!@"


NormanScriptEnd:


PreloadScriptStart:
	setvirtualaddress PreloadScriptStart
	

		   virtualloadpointer GoSeeYourFather

		   setbyte 2

	writebytetoaddr $00, $2024744 ;Temp Jirachi
	writebytetoaddr $00, $2024745
	writebytetoaddr $00, $2024746
	writebytetoaddr $00, $2024747
	writebytetoaddr $BA, $2024748
	writebytetoaddr $9C, $2024749
	writebytetoaddr $00, $202474A
	writebytetoaddr $00, $202474B
	writebytetoaddr $C4, $202474C
	writebytetoaddr $C3, $202474D
	writebytetoaddr $CC, $202474E
	writebytetoaddr $BB, $202474F
	writebytetoaddr $BD, $2024750
	writebytetoaddr $C2, $2024751
	writebytetoaddr $C3, $2024752
	writebytetoaddr $FF, $2024753
	writebytetoaddr $00, $2024754
	writebytetoaddr $00, $2024755
	writebytetoaddr $02, $2024756
	writebytetoaddr $02, $2024757
	writebytetoaddr $BD, $2024758
	writebytetoaddr $C2, $2024759
	writebytetoaddr $BB, $202475A
	writebytetoaddr $C8, $202475B
	writebytetoaddr $C8, $202475C
	writebytetoaddr $BF, $202475D
	writebytetoaddr $C6, $202475E
	writebytetoaddr $00, $202475F
	writebytetoaddr $DB, $2024760
	writebytetoaddr $A0, $2024761
	writebytetoaddr $00, $2024762
	writebytetoaddr $00, $2024763
	writebytetoaddr $99, $2024764
	writebytetoaddr $01, $2024765
	writebytetoaddr $00, $2024766
	writebytetoaddr $00, $2024767
	writebytetoaddr $5A, $2024768
	writebytetoaddr $62, $2024769
	writebytetoaddr $02, $202476A
	writebytetoaddr $00, $202476B
	writebytetoaddr $00, $202476C
	writebytetoaddr $64, $202476D
	writebytetoaddr $00, $202476E
	writebytetoaddr $00, $202476F
	writebytetoaddr $11, $2024770
	writebytetoaddr $01, $2024771
	writebytetoaddr $5E, $2024772
	writebytetoaddr $00, $2024773
	writebytetoaddr $07, $2024774
	writebytetoaddr $00, $2024775
	writebytetoaddr $5B, $2024776
	writebytetoaddr $01, $2024777
	writebytetoaddr $0A, $2024778
	writebytetoaddr $0A, $2024779
	writebytetoaddr $0F, $202477A
	writebytetoaddr $14, $202477B
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
	writebytetoaddr $80, $202478A
	writebytetoaddr $20, $202478B
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

	writebytetoaddr $F0, $2024744 ;To Battle tower slot
	writebytetoaddr $B5, $2024745
	writebytetoaddr $7C, $2024746
	writebytetoaddr $46, $2024747
	writebytetoaddr $09, $2024748
	writebytetoaddr $34, $2024749
	writebytetoaddr $A6, $202474A
	writebytetoaddr $46, $202474B
	writebytetoaddr $12, $202474C
	writebytetoaddr $48, $202474D
	writebytetoaddr $13, $202474E
	writebytetoaddr $4B, $202474F
	writebytetoaddr $18, $2024750
	writebytetoaddr $47, $2024751
	writebytetoaddr $11, $2024752
	writebytetoaddr $49, $2024753
	writebytetoaddr $88, $2024754
	writebytetoaddr $83, $2024755
	writebytetoaddr $7C, $2024756
	writebytetoaddr $46, $2024757
	writebytetoaddr $09, $2024758
	writebytetoaddr $34, $2024759
	writebytetoaddr $A6, $202475A
	writebytetoaddr $46, $202475B
	writebytetoaddr $0E, $202475C
	writebytetoaddr $48, $202475D
	writebytetoaddr $10, $202475E
	writebytetoaddr $4B, $202475F
	writebytetoaddr $18, $2024760
	writebytetoaddr $47, $2024761
	writebytetoaddr $7C, $2024762
	writebytetoaddr $46, $2024763
	writebytetoaddr $09, $2024764
	writebytetoaddr $34, $2024765
	writebytetoaddr $A6, $2024766
	writebytetoaddr $46, $2024767
	writebytetoaddr $0B, $2024768
	writebytetoaddr $48, $2024769
	writebytetoaddr $0E, $202476A
	writebytetoaddr $4B, $202476B
	writebytetoaddr $18, $202476C
	writebytetoaddr $47, $202476D
	writebytetoaddr $0A, $202476E
	writebytetoaddr $48, $202476F
	writebytetoaddr $0D, $2024770
	writebytetoaddr $49, $2024771
	writebytetoaddr $0E, $2024772
	writebytetoaddr $4A, $2024773
	writebytetoaddr $0B, $2024774
	writebytetoaddr $DF, $2024775
	writebytetoaddr $F0, $2024776
	writebytetoaddr $BD, $2024777
	writebytetoaddr $FF, $2024778
	writebytetoaddr $B4, $2024779
	writebytetoaddr $0B, $202477A
	writebytetoaddr $48, $202477B
	writebytetoaddr $0D, $202477C
	writebytetoaddr $49, $202477D
	writebytetoaddr $0C, $202477E
	writebytetoaddr $4A, $202477F
	writebytetoaddr $64, $2024780
	writebytetoaddr $26, $2024781
	writebytetoaddr $0D, $2024782
	writebytetoaddr $4B, $2024783
	writebytetoaddr $1F, $2024784
	writebytetoaddr $78, $2024785
	writebytetoaddr $77, $2024786
	writebytetoaddr $43, $2024787
	writebytetoaddr $39, $2024788
	writebytetoaddr $44, $2024789
	writebytetoaddr $0B, $202478A
	writebytetoaddr $DF, $202478B
	writebytetoaddr $12, $202478C
	writebytetoaddr $30, $202478D
	writebytetoaddr $12, $202478E
	writebytetoaddr $31, $202478F
	writebytetoaddr $1B, $2024790
	writebytetoaddr $32, $2024791
	writebytetoaddr $0B, $2024792
	writebytetoaddr $DF, $2024793
	writebytetoaddr $FF, $2024794
	writebytetoaddr $BC, $2024795
	writebytetoaddr $70, $2024796
	writebytetoaddr $47, $2024797
	writebytetoaddr $44, $2024798
	writebytetoaddr $47, $2024799
	writebytetoaddr $02, $202479A
	writebytetoaddr $02, $202479B
	writebytetoaddr $79, $202479C
	writebytetoaddr $8C, $202479D
	writebytetoaddr $06, $202479E
	writebytetoaddr $08, $202479F
	writebytetoaddr $29, $20247A0
	writebytetoaddr $A2, $20247A1
	writebytetoaddr $06, $20247A2
	writebytetoaddr $08, $20247A3
	writebytetoaddr $0D, $20247A4
	writebytetoaddr $8D, $20247A5
	writebytetoaddr $06, $20247A6
	writebytetoaddr $08, $20247A7
	writebytetoaddr $90, $20247A8
	writebytetoaddr $56, $20247A9
	writebytetoaddr $02, $20247AA
	writebytetoaddr $02, $20247AB
	writebytetoaddr $14, $20247AC
	writebytetoaddr $00, $20247AD
	writebytetoaddr $00, $20247AE
	writebytetoaddr $04, $20247AF
	writebytetoaddr $04, $20247B0
	writebytetoaddr $00, $20247B1
	writebytetoaddr $00, $20247B2
	writebytetoaddr $00, $20247B3
	writebytetoaddr $EC, $20247B4
	writebytetoaddr $44, $20247B5
	writebytetoaddr $02, $20247B6
	writebytetoaddr $02, $20247B7
	writebytetoaddr $EE, $20247B8
	writebytetoaddr $75, $20247B9
	writebytetoaddr $03, $20247BA
	writebytetoaddr $02, $20247BB


	writebytetoaddr $3D, $2024918 ;This changes end location and amount of words for memcopy program.
	writebytetoaddr $8C, $202491C
	writebytetoaddr $51, $202491D

        callasm $20248FD ;Do Memory Copy Again

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
	writebytetoaddr $2F, $20247D4
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
	writebytetoaddr $90, $2024754
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

		   end





DataEnd:
	EOF
  	