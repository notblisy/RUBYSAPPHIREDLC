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
        db $50
        db \1 
        dw \2
        ENDM
waitmovement: MACRO
        db $51
        db \1 
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
EVENTLEGAL: MACRO
	db $02
	db $48
	db $4F
	db $21
	db $03
	db $4B
	db $03
	db $A2
	db $18
	db $47
	db $70
	db $47
	db $C0
	db $45
	db $00
	db $03
	db $ED
	db $D2
	db $03
	db $08
	db $10
	db $00
	db $00
	db $00
	ENDM
EVENTLEGAL2: MACRO
	db $00
	db $02
	db $48
	db $4F
	db $21
	db $02
	db $4B
	db $03
	db $A2
	db $18
	db $47
	db $00
	db $00
	db $C0
	db $45
	db $00
	db $03
	db $ED
	db $D2
	db $03
	db $08
	db $10
	db $00
	db $00
	db $00
	ENDM
METLOCATION: MACRO
        db $02
        db $48
        db $23
        db $21
        db $02
        db $4B
        db $03
        db $A2
        db $18
        db $47
        db $00
        db $00
        db $C0
        db $45
        db $00
        db $03
        db $ED
        db $D2
        db $03
        db $08
        db $D3
        db $00
        db $00
        db $00
        ENDM
GAMEORIGIN: MACRO
        db $02
        db $48
        db $25
        db $21
        db $02
        db $4B
        db $03
        db $A2
        db $18
        db $47
        db $00
        db $00
        db $C0
        db $45
        db $00
        db $03
        db $ED
        db $D2
        db $03
        db $08
        db $03
        db $00
        db $00
        db $00
        ENDM
GAMELANG: MACRO
        db $02
        db $48
        db $03
        db $21
        db $02
        db $4B
        db $03
        db $A2
        db $18
        db $47
        db $00
        db $00
        db $C0
        db $45
        db $00
        db $03
        db $ED
        db $D2
        db $03
        db $08
        db $01
        db $00
        db $00
        db $00
        ENDM
COLORNG: MACRO
        db $13
        db $48
	db $01
	db $68
        db $13
        db $4A
	db $02
	db $23
	db $13
	db $4D
	db $69
	db $43
	db $13
	db $4D
	db $29
	db $44
	db $0F
	db $1C
	db $3F
	db $0C
	db $17
	db $80
	db $02
	db $32
	db $01
	db $3B
	db $F5
	db $D5
	db $10
	db $48
	db $0D
	db $4D
	db $69
	db $43
	db $0D
	db $4D
	db $29
	db $44
	db $0F
	db $1C
	db $3F
	db $0C
	db $0A
	db $4D
	db $69
	db $43
	db $0A
	db $4D
	db $29
	db $44
	db $0E
	db $1C
	db $36
	db $0C
	db $78
	db $40
	db $70
	db $40
	db $07
	db $28
	db $EE
	db $D9
	db $02
	db $32
	db $17
	db $80
	db $02
	db $32
	db $16
	db $80
	db $06
	db $4B
	db $18
	db $47
	db $00
	db $00
	db $00
	db $00
        db $18
        db $48
        db $00
        db $03
        db $F4
        db $91
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
	db $90
	db $79
	db $00
	db $00
	db $6D
	db $8E
	db $02
	db $02
        ENDM
CREATEMONSETUP: MACRO
	db $00
	db $B5
        db $84
        db $B0
        db $01
        db $20
        db $00
        db $90
        db $00
        db $00
        db $08
        db $49
        db $08
        db $68
        db $01
        db $90
        db $07
        db $48
	db $03
	db $90
        db $00
        db $00
        db $07
        db $48
        db $FB
        db $21
        db $0A
        db $22
        db $20
        db $23
        db $06
        db $4F        
	db $7E	
        db $46
	db $05
	db $36
	db $B6
	db $46
	db $38
	db $47
        db $04
        db $B0
        db $00
        db $BD
        db $FC
        db $91
        db $02
        db $02
        db $91
        db $79
        db $00
        db $00
        db $C0
        db $45
        db $00
        db $03
        db $99
        db $A7
        db $03
        db $08
        ENDM
GIVEMONSETUP: MACRO
	db $01
	db $48
	db $02
	db $49
        db $08
        db $47
        db $00
        db $00
	db $C0
	db $45
	db $00
	db $03
        db $1d
        db $d9
        db $03
        db $08
	ENDM
SEENFLAG: MACRO
	db $FB
	db $20
	db $02
	db $21
	db $00
	db $4A
	db $10
	db $47
	db $91
	db $0d
	db $09
	db $08
	ENDM
CAUGHTFLAG: MACRO
	db $FB
	db $20
	db $03
	db $21
	db $00
	db $4A
	db $10
	db $47
	db $91
	db $0d
	db $09
	db $08
	ENDM
DECRYPT: MACRO
	db $04
	db $48
	db $64
	db $21
	db $04
	db $4B
	db $1A
	db $78
	db $51
	db $43
	db $08
	db $44
	db $03
	db $4B
	db $04
	db $4A
	db $10
	db $60
	db $18
	db $47
	db $60
	db $43
	db $00
	db $03
	db $DC
	db $E8
	db $02
	db $02
	db $15
	db $C6
	db $03
	db $08
	db $00
	db $92
	db $02
	db $02
	ENDM
SETOTID: MACRO
        db $02
        db $49
        db $08
        db $68
        db $01
        db $21
        db $03
        db $A2
        db $01
        db $4B
        db $18
        db $47
        db $00
        db $92
        db $02
        db $02
        db $ED
        db $D2
        db $03
        db $08
        db $91
        db $79
        db $00
        db $00
        ENDM
CHECKSUM: MACRO
	db $01
	db $49
	db $08
	db $68
	db $01
	db $4B
	db $18
	db $47
        db $00
        db $92
        db $02
        db $02
	db $25
	db $B1
	db $03
	db $08
	ENDM
ENCRYPT: MACRO
	db $01
	db $49
	db $08
	db $68
	db $01
	db $4B
	db $18
	db $47
        db $00
        db $92
        db $02
        db $02
	db $f1
	db $C5
	db $03
	db $08
	ENDM
CREATEMON: MACRO
	db $05
	db $48
	db $FB
	db $21
	db $0A
	db $22
	db $00
	db $23
	db $01
	db $24
	db $01
	db $25
	db $05
	db $4F
	db $C0
	db $45
	db $00
	db $03
	db $FA
	db $91
	db $02
	db $02
	db $00
	db $00
	ENDM
TID: MACRO
	db $00
	db $02
	db $49
	db $00
	db $20
	db $08
	db $80
	db $70
	db $47
	db $00
	db $00
	db $AE
	db $4E
	db $02
	db $02
	ENDM
fadescreen: MACRO
	db $97
	db \1
	ENDM
doanimation: MACRO
	db $9C
	dw \1
	ENDM
SPRITE: MACRO
	db $00
	db $06
	db $48
	db $07
	db $4D
	db $03
	db $4E
	db $00
	db $21
	db $00
	db $22
	db $00
	db $23
	db $02
	db $4F
	db $18
	db $24
	db $38
	db $47
	db $00
	db $00
	db $44
	db $21
	db $37
	db $08
	db $DD
	db $0B
	db $00
	db $08
	db $98
	db $7D
	db $00
	db $03
	db $0C
	db $49
	db $00
	db $30
	ENDM
