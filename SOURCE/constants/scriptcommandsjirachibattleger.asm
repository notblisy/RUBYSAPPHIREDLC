LASTRESULT EQU $800D
end: MACRO
	db $02
	ENDM
return: MACRO
	db $03
	ENDM
goto: MACRO
	db $05
	dd \1
	ENDM
goto_if: MACRO
	db $06
	db \1
	dd \2
	ENDM
call_if: MACRO
	db $07
	db \1
	dd \2
	ENDM
gotostd: MACRO
	db $08
	db \1
	ENDM
callstd: MACRO
	db $09, \1
	ENDM
gotostd_if: MACRO
	db $0A
	db \1
	db \2
	ENDM
callstd_if: MACRO
	db $0B
	db \3
	db \2
	ENDM
returnram: MACRO
	db $0C
	ENDM
killscript: MACRO
	db $0D
	ENDM
setbyte: MACRO
	db $0E, \1
	ENDM
loadword: MACRO
	db $0F
	db \1
	dd \2
	ENDM
callasm: MACRO
	db $23
	dd \1
	ENDM
loadbyte: MACRO
	db $10
	db \1
	db \2
	ENDM
writebytetoaddr: MACRO
	db $11
	db \1
	dd \2
	ENDM
loadbytefromaddr: MACRO
	db $12
	db \1
	dd \2
	ENDM
setptrbyte: MACRO
	db $13
	db \1
	dd \2
	ENDM
copylocal: MACRO
	db $14
	db \1
	db \2
	ENDM
copybyte: MACRO
	db $15
	dd \1
	dd \2
	ENDM
setvar: MACRO
	db $16
	dw \1
	dw \2
	ENDM
addvar: MACRO
	db $17
	dw \1
	dw \2
	ENDM
subvar: MACRO
	db $18
	dw \1
	dw \2
	ENDM
copyvar: MACRO
	db $19
	dw \1
	dw \2
	ENDM
copyvarifnotzero: MACRO
	db $1A
	dw \1, \2
	ENDM
compare: MACRO
	db $21
	dw \1, \2
	ENDM
comparevar: MACRO
	db $22
	dw \1, \2
	ENDM
setflag: MACRO
	db $29
	dw \1
	ENDM
clearflag: MACRO
	db $2A
	dw \1
	ENDM
checkflag: MACRO
	db $2B
	dw \1
	ENDM
playfanfare: MACRO
	db $31
	dw \1
	ENDM
waitfanfare: MACRO
	db $32
	ENDM
getpartysize: MACRO
	db $43
	ENDM
getplayerpos: MACRO
	db $42
	dw \1
	dw \2
	ENDM
fadeout: MACRO
	db $37
        dw \1
	ENDM
additem: MACRO
	db $44
	dw \1, \2
	ENDM
checkitemroom: MACRO
	db $46
	dw \1, \2
	ENDM
checkitem: MACRO
	db $47
	dw \1, \2
	ENDM
checkitemtype: MACRO
	db $48
	dw \1
	ENDM
checkpcitem: MACRO
	db $4A
	dw \1, \2
	ENDM
adddecoration: MACRO
	db $4b
	dw \1
	ENDM
faceplayer: MACRO
	db $5A
	ENDM
waitmsg: MACRO
	db $66
	ENDM
lock: MACRO
	db $6A
	ENDM
release: MACRO
	db $6C
	ENDM
waitkeypress: MACRO
	db $6D
	ENDM
showmonpic: MACRO
	db $75
	dw \1
	db \2
	db \3
	ENDM
hidemonpic: MACRO
	db $76
	ENDM
hidesprite: MACRO
	db $53
	dw \1
	ENDM
showcontestpainting: MACRO
	db $77
	db \1
	ENDM
braillemessage: MACRO
	db $78
	dd \1
	ENDM
brailleformat: MACRO
	db \1
	db \2
	db \3
	db \4
	db \5
	db \6
	ENDM
givemon: MACRO
	db $79
	dw \1
	db \2
	dw \3
	dd \4
	dd \5
	db \6
	ENDM
giveegg: MACRO
	db $7A
	dw \1
	ENDM
setmonmove: MACRO
	db $7b
	db \1
	db \2
	dw \3
	ENDM
checkpartymove: MACRO
	db $7c
	dw \1
	ENDM
bufferspeciesname: MACRO
	db $7d
	db \1
	dw \2
	ENDM
bufferleadmonspeciesname: MACRO
	db $7E
	db \1
	ENDM
bufferpartymonnick: MACRO
	db $7f
	db \1
	dw \2
	ENDM
bufferitemname: MACRO
	db $80
	db \1
	dw \2
	ENDM
bufferdecorationname: MACRO
	db $81
	db \1
	dw \2
	ENDM
buffermovename: MACRO
	db $82
	db \1
	dw \2
	ENDM
random: MACRO
	db $8F
	dw \1
	ENDM
sound: MACRO
       db $2F
       dw \1
       ENDM
special: MACRO
       db $25
       dw \1
       ENDM
pause: MACRO
       db $28
       dw \1
       ENDM
setrespawn: MACRO
	db $9F
	dw \1
	ENDM
checkplayergender: MACRO
	db $A0
	ENDM
applymovement: MACRO
        db $4F
        dw \1 
        dd \2
        ENDM
waitmovement: MACRO
        db $51
        dw \1
        ENDM
playmoncry: MACRO
	db $A1
	dw \1
	dw \2
	ENDM
playsong: MACRO
	db $33
	dw \1
	db \2
	ENDM
setwildbattle: MACRO
	db $B6
	dw \1
	db \2
	dw \3
	ENDM
dowildbattle: MACRO
	db $B7
	ENDM
setvirtualaddress: MACRO
	db $B8
	GBAPTR \1
	ENDM
waitstate: MACRO
           db $27
           ENDM
virtualgotoif: MACRO
	db $BB
	db \1
	GBAPTR \2
	ENDM
virtualmsgbox: MACRO
	db $BD
	GBAPTR \1
	ENDM
virtualloadpointer: MACRO
	db $BE
	GBAPTR \1
	ENDM
waitmoncry: MACRO
	db $C5
	ENDM
setmoneventlegal: MACRO
	db $CD
	dw \1
	ENDM
checkmoneventlegal: MACRO
	db $CE
	dw \1
	ENDM
setmonmetlocation: MACRO
	db $D2
	dw \1
	db \2
	ENDM
warp: MACRO
	db $3F
	db \1
	db \2
	db \3
	db \4
        db \5
	ENDM
buffernumber: MACRO
	db $83
	db \1
	dw \2
	ENDM
closeonkeypress: MACRO
	db $68
	ENDM
TEMPJIRACHI: MACRO
	dd $00000000
	dd $00009CBA
	dd $BBCCC3C4
	dd $FFC3C2BD
	dd $02050000
	dd $C8BBC2BD
	dd $00C6BFC8
	dd $0000A0DB
	dd $00000199
	dd $0002625A
	dd $00006400
	dd $005E0111
	dd $015B0007
	dd $140F0A0A
	dd $00000000
	dd $00000000
	dd $00000000
	dd $2080FF00	
	dd $00000000
	dd $00000000
	ENDM
CHANNELRNG: MACRO
	dw $B500
	dw $B4FF
	dw $4838
	dw $6800
	dw $4C34
	dw $4D35
	dw $2100
	dw $0000
	dw $2301
	dw $270E
	dw $4360
	dw $4428
	dw $0F82
	dw $4093
	dw $4319
	dw $4039
	dw $290E
	dw $D1F5
	dw $2100
	dw $4360
	dw $4428
	dw $3101
	dw $2905
	dw $D1FA
	dw $492E
	dw $0C02
	dw $428A
	dw $D802
	dw $4360
	dw $4428
	dw $E00C
	dw $4360
	dw $4428
	dw $492B
	dw $0C02
	dw $428A
	dw $D802
	dw $4360
	dw $4428
	dw $E003
	dw $4360
	dw $4428
	dw $4360
	dw $4428
	dw $4360
	dw $4428
	dw $0C01
	dw $4360
	dw $4428
	dw $0C02
	dw $4360
	dw $4428
	dw $0C03
	dw $4E25
	dw $0034
	dw $2B08
	dw $D501
	dw $2501
	dw $E000
	dw $2500
	dw $404C
	dw $4054
	dw $42AC
	dw $D001
	dw $4D1C
	dw $406A
	dw $0412
	dw $431A
	dw $4B16
	dw $601A
	dw $0409
	dw $4331
	dw $0C09
	dw $80D9
	dw $4C11
	dw $4D12
	dw $4360
	dw $4428
	dw $0FC1
	dw $22A9
	dw $440A
	dw $845A
	dw $4360
	dw $4428
	dw $0FC1
	dw $2280
	dw $408A
	dw $4360
	dw $4428
	dw $0FC1
	dw $03C9
	dw $430A
	dw $490F
	dw $430A
	dw $0000
	dw $0000
	dw $3344
	dw $805A
	dw $2600
	dw $2200
	dw $4360
	dw $4428
	dw $0EC1
	dw $40B1
	dw $430A
	dw $3605
	dw $2E19
	dw $DDF7
	dw $605A
	dw $E043
	ENDM
STORAGETABLE: MACRO
	dd $000343FD
	dd $00269EC3
	dd $02028EEC
	dd $03004828
	dd $00004000
	dd $0000547A
	dd $00008000
	dd $00002000
	ENDM
MEMCOPYJIRACHI: MACRO
	dw $3B44
	dw $0018
	dw $4910
	dw $4A11
	dw $DF0B
	dw $3820
	dw $4D12
	dw $6800
	dw $2118
	dw $0007
	dw $0000
	dw $DF06
	dw $0038
	dw $2800
	dw $D503
	dw $3110
	dw $2900
	dw $D500
	dw $3118
	dw $440D
	dw $782E
	dw $480D
	dw $2703
	dw $240C
	dw $2503
	dw $490A
	dw $4A06
	dw $0033
	dw $402B
	dw $4363
	dw $4419
	dw $DF0B
	dw $08B6
	dw $3F01
	dw $D5F5
	dw $E00C
	dd $030045D0
	dd $04000008
	dd $04000003
	dd $02028EEC
	dd $02028F3C
	dd $030045F0
	dd $02028F0C
	ENDM
BOXMONCHECKSUM: MACRO
	dw $4801
	dw $4B02
	dw $0000
	dw $4718
	dd $030045C0
	dd $0803B125
	ENDM
RETURN: MACRO
	dw $BCFF
	dw $BD00
	ENDM
FIXJIRACHIANDCOPY: MACRO
	dw $B5F0
	dw $467C
	dw $3409
	dw $46A6
	dw $4812
	dw $4B13
	dw $4718
	dw $4911
	dw $8388
	dw $467C
	dw $3409
	dw $46A6
	dw $480E
	dw $4B10
	dw $4718
	dw $467C
	dw $3409
	dw $46A6
	dw $480B
	dw $4B0E
	dw $4718
	dw $480A
	dw $490D
	dw $4A0E
	dw $DF0B
	dw $BDF0
	ENDM	
CAPTUREJIRACHI: MACRO
	dw $B4FF
	dw $480B
	dw $490D
	dw $4A0C
	dw $2664
	dw $4B0D
	dw $781F
	dw $4377
	dw $4439
	dw $DF0B
	dw $3012
	dw $3112
	dw $321B
	dw $DF0B
	dw $BCFF
	dw $4770
	ENDM
FINALSTORAGE: MACRO
	dd $030045D0
	dd $0803b2f9
	dd $0803c7c5
	dd $0803b38D
	dd $02028EEC
	dd $04000014
	dd $00000004
	dd $03004370
	dd $0202E8DA
	ENDM
STRUCTURETABLEG: MACRO
        db $E4
        db $B4
        db $D8
        db $9C
        db $78
        db $6C
        db $E1
        db $B1
        db $D2	
        db $93
        db $72
        db $63
        db $C9
        db $8D
        db $C6
        db $87
        db $4E
        db $4B
        db $39
        db $2D
        db $36
        db $27
        db $1E
        db $1B
	ENDM
STRUCTURETABLEA: MACRO
        db $0C
        db $0C
        db $18
        db $24
        db $18
        db $24
        db $00
        db $00
        db $00
        db $00
        db $00
        db $00
        db $18
        db $24
        db $0C
        db $0C
        db $24
        db $18
        db $18
        db $24
        db $0C
        db $0C
        db $24
        db $18
	ENDM
STRUCTURETABLEE: MACRO
        db $18
        db $24
        db $0C
        db $0C
        db $24
        db $18
        db $18
        db $24
        db $0C
        db $0C
        db $24
        db $18
        db $00
        db $00
        db $00
        db $00
        db $00
        db $00
        db $24
        db $18
        db $24
        db $18
        db $0C
        db $0C
	ENDM
STRUCTURETABLEM: MACRO
        db $24
        db $18
        db $24
        db $18
        db $0C
        db $0C
        db $24
        db $18
        db $24
        db $18
        db $0C
        db $0C
        db $24
        db $18
        db $24
        db $18
        db $0C
        db $0C
        db $00
        db $00
        db $00
        db $00
        db $00
        db $00
	ENDM
LOADSTOREPARTYAMOUNT: MACRO
        db $02
        db $49
        db $08
        db $78
        db $02
        db $49
        db $08
        db $60
        db $70
        db $47
	db $00
	db $00
        db $DC
        db $E8
        db $02
        db $02
        db $F4
        db $91
        db $02
        db $02
	ENDM
COLORNG: MACRO
	db $10
	db $48
	db $01
	db $68
	db $10
	db $4A
	db $11
	db $4B
	db $11
	db $4F
	db $59
	db $43
	db $39
	db $44
	db $48
	db $00
	db $40
	db $0C
	db $59
	db $43
	db $39
	db $44
	db $4D
	db $00
	db $6D
	db $0C
	db $ED
	db $03
	db $28
	db $43
	db $90
	db $64
	db $59
	db $43
	db $39
	db $44
	db $0B
	db $4E
	db $59
	db $43
	db $39
	db $44
	db $08
	db $0C
	db $59
	db $43
	db $39
	db $44
	db $0D
	db $0C
	db $46
	db $40
	db $6E
	db $40
	db $07
	db $2E
	db $F4
	db $D9
	db $50
	db $80
	db $15
	db $80
	db $06
	db $48
	db $00
	db $47
	db $00
	db $00
        db $18
        db $48
        db $00
        db $03
        db $EC
        db $8D
        db $02
        db $02
	db $FD
	db $43
	db $03
	db $00
	db $C3
	db $9E
	db $26
	db $00
	db $91
	db $79
	db $00
	db $00
	db $0D
	db $8F
	db $02
	db $02
        ENDM
MEMCPYSETUP: MACRO
	db $00
	db $B5
	db $02
	db $48
	db $02
	db $49
	db $03
	db $4A
	db $0B
	db $DF
	db $05
	db $E0
        db $EC
        db $8D
        db $02
        db $02
	db $C0
	db $45
	db $00
	db $03
	db $08
	db $00
	db $00
	db $04
	ENDM
SUBSTRUCTURECPY: MACRO
	db $20
	db $38
	db $0D
	db $4D
	db $00
	db $68
	db $18
	db $21
	db $07
	db $00
	db $06
	db $DF
	db $38
	db $00
	db $00
	db $28
	db $03
	db $D5
	db $10
	db $31
	db $00
	db $29
	db $00
	db $D5
	db $18
	db $31
	db $0D
	db $44
	db $03
	db $27
	db $07
	db $48
	db $20
	db $30
	db $07
	db $49
	db $07
	db $4A
	db $2E
	db $78
	db $89
	db $19
	db $0B
	db $DF
	db $00
	db $30
	db $18
	db $35
	db $01
	db $3F
	db $F6
	db $D5
	db $08
	db $E0
	db $00
	db $00
	db $3C
	db $8E
	db $02
	db $02
	db $EC
	db $8D
	db $02
	db $02
	db $E0
	db $45
	db $00
	db $03
	db $03
	db $00
	db $00
	db $04
	ENDM
CHECKSUM: MACRO
	db $05
	db $48
	db $06
	db $49
	db $06
	db $4A
	db $0E
	db $68
	db $17
	db $68
	db $37
	db $44
	db $36
	db $0C
	db $37
	db $44
	db $3F
	db $04
	db $3F
	db $0C
	db $07
	db $80
	db $00
	db $BD
        db $DC
        db $45
        db $00
        db $03
	db $34
	db $8E
	db $02
	db $02
	db $08
	db $8E
	db $02
	db $02
	ENDM
ENCRYPT: MACRO
	db $01
	db $48
	db $00
	db $00
	db $01
	db $4B
	db $18
	db $47
        db $C0
        db $45
        db $00
        db $03
	db $f1
	db $C5
	db $03
	db $08
	ENDM
CALCSTATS: MACRO
	db $01
	db $48
	db $00
	db $00
	db $01
	db $4B
	db $18
	db $47
        db $C0
        db $45
        db $00
        db $03
	db $B9
	db $B1
	db $03
	db $08
	ENDM
fadescreen: MACRO
	db $97
	db \1
	ENDM
doanimation: MACRO
	db $9C
	dw \1
	ENDM
CAPTURECELEBI: MACRO
	db $04
	db $48
	db $05
	db $49
	db $05
	db $4A
	db $64
	db $26
	db $05
	db $4B
	db $1F
	db $78
	db $77
	db $43
	db $39
	db $44
	db $0B
	db $DF
	db $70
	db $47
        db $EC
        db $8D
        db $02
        db $02
	db $60
	db $43
	db $00
	db $03
	db $14
	db $00
	db $00
	db $04
	db $DA
	db $E8
	db $02
	db $02
	ENDM
CELEBICOPY1: MACRO
	db $02
	db $48
	db $03
	db $49
	db $03
	db $4A
	db $0B
	db $DF
	db $70
	db $47
	db $00
	db $00
	db $C0
	db $45
	db $00
	db $03
        db $EC
        db $8D
        db $02
        db $02
	db $14
	db $00
	db $00
	db $04
	ENDM
SRTEST: MACRO
	db $00
	db $DF
	db $70
	db $47
	ENDM
SRFIX: MACRO
	db $01
	db $4D
	db $01
	db $4E
	db $00
	db $27
	db $70
	db $47
	db $70
	db $17
	db $00
	db $03
	db $A9
	db $33
	db $00
	db $03
	ENDM
MOVEPATHGIRLDOWN: MACRO
	db $08
	db $0B
	db $0B
	db $0B
	db $0B
	db $0B
	db $0B
	db $0B
	db $0B
	db $0B
	db $0B
	db $54
	db $FE
	ENDM
MOVEPATHGIRLLEFT: MACRO
	db $0A
	db $08
	db $FE
	ENDM
MOVEPLAYERDOWNRIGHT: MACRO
	db $08
	db $0B
	db $FE
	ENDM
MOVEPLAYERRIGHTFACEUP: MACRO
	db $0B
	db $01
	db $14
	db $14
	db $FE
	ENDM
MOVEPLAYERQUESTION: MACRO
	db $57
	db $12
	db $FE
	ENDM