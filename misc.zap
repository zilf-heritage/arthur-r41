

	.FUNCT	RT-CH-PLAYER:ANY:0:1,CONTEXT,PERSON
	EQUAL?	CONTEXT,M-WINNER \?CCL3
	ZERO?	GL-NEXT-WINNER /?CCL6
	SET	'WINNER,GL-NEXT-WINNER
	SET	'GL-NEXT-WINNER,FALSE-VALUE
	ICALL	PERFORM,PRSA,PRSO,PRSI
	RTRUE	
?CCL6:	FSET?	TH-HEAD,FL-LOCKED \?CCL8
	CALL1	SEE-VERB?
	ZERO?	STACK /?CCL8
	PRINTI	"You can't see anything with"
	ICALL	RT-PRINT-OBJ,TH-HEAD,K-ART-THE
	PRINTR	" in your shell."
?CCL8:	FSET?	TH-LEGS,FL-LOCKED \?CCL12
	EQUAL?	PRSA,V?DISMOUNT,V?CLIMB-OVER,V?CLIMB-ON /?CTR11
	EQUAL?	PRSA,V?CLIMB-DOWN,V?CLIMB-UP,V?JUMP /?CTR11
	EQUAL?	PRSA,V?EXIT,V?ENTER,V?HIDE-BEHIND /?CTR11
	EQUAL?	PRSA,V?HIDE,V?WALK-TO,V?WALK \?CCL12
?CTR11:	PRINTI	"You can't go anywhere with"
	ICALL	RT-PRINT-OBJ,TH-LEGS,K-ART-THE
	PRINTR	" in your shell."
?CCL12:	CALL1	SPEAKING-VERB?
	ZERO?	STACK /FALSE
	EQUAL?	GL-PLAYER-FORM,K-FORM-ARTHUR /FALSE
	EQUAL?	PRSO,FALSE-VALUE,ROOMS \?PRD26
	CALL	FIND-FLAG-HERE,FL-PERSON,CH-PLAYER >PERSON
	ZERO?	PERSON \?PRD24
?PRD26:	SET	'PERSON,PRSO
	ZERO?	PERSON /FALSE
	FSET?	PRSO,FL-PERSON \FALSE
?PRD24:	EQUAL?	PERSON,CH-MERLIN,CH-PLAYER /FALSE
	PRINTI	"Animals can't talk to people."
	CRLF	
	RETURN	2
?CCL3:	ZERO?	CONTEXT \FALSE
	ZERO?	NOW-PRSI /?CCL41
	PUSH	2
	JUMP	?CND39
?CCL41:	PUSH	1
?CND39:	CALL2	EVERYWHERE-VERB?,STACK
	ZERO?	STACK \?CCL36
	EQUAL?	PRSA,V?TRANSFORM /?CCL36
	CALL	NOUN-USED?,CH-PLAYER,W?ARTHUR
	ZERO?	STACK /?PRD44
	EQUAL?	GL-PLAYER-FORM,K-FORM-ARTHUR \?CTR35
?PRD44:	CALL	NOUN-USED?,CH-PLAYER,W?OWL
	ZERO?	STACK /?PRD47
	EQUAL?	GL-PLAYER-FORM,K-FORM-OWL \?CTR35
?PRD47:	CALL	NOUN-USED?,CH-PLAYER,W?BADGER
	ZERO?	STACK /?PRD50
	EQUAL?	GL-PLAYER-FORM,K-FORM-BADGER \?CTR35
?PRD50:	CALL	NOUN-USED?,CH-PLAYER,W?SALAMANDER
	ZERO?	STACK /?PRD53
	EQUAL?	GL-PLAYER-FORM,K-FORM-SALAMANDER \?CTR35
?PRD53:	CALL	NOUN-USED?,CH-PLAYER,W?TURTLE
	ZERO?	STACK /?PRD56
	EQUAL?	GL-PLAYER-FORM,K-FORM-TURTLE \?CTR35
?PRD56:	CALL	NOUN-USED?,CH-PLAYER,W?EEL
	ZERO?	STACK /?CCL36
	EQUAL?	GL-PLAYER-FORM,K-FORM-EEL /?CCL36
?CTR35:	CALL1	NP-CANT-SEE
	RSTACK	
?CCL36:	EQUAL?	PRSA,V?EXAMINE \FALSE
	FSET	CH-PLAYER,FL-SEEN
	PRINTI	"You look like a perfectly normal"
	ICALL1	RT-FORM-MSG
	PRINTR	"."


	.FUNCT	VISIBLE?:ANY:1:1,OBJ
	CALL	ACCESSIBLE?,OBJ,TRUE-VALUE
	RSTACK	


	.FUNCT	CLOSED?:ANY:1:2,OBJ,VIS?
	ZERO?	OBJ /TRUE
	IN?	OBJ,ROOMS /FALSE
	FSET?	OBJ,FL-CONTAINER \?CCL7
	FSET?	OBJ,FL-OPEN /FALSE
	ZERO?	VIS? /TRUE
	FSET?	OBJ,FL-TRANSPARENT /FALSE
	RTRUE	
?CCL7:	FSET?	OBJ,FL-SURFACE /FALSE
	FSET?	OBJ,FL-ALIVE /FALSE
	FSET?	OBJ,FL-PERSON /FALSE
	RTRUE	


	.FUNCT	ACCESSIBLE?:ANY:1:2,OBJ,VIS?,WLOC,OLOC,CLSD-PTR,PTR,CNT,TBL,END,L
	ZERO?	OBJ /FALSE
	EQUAL?	OBJ,ROOMS /TRUE
	IN?	OBJ,GLOBAL-OBJECTS /TRUE
	EQUAL?	OBJ,PSEUDO-OBJECT \?CCL9
	EQUAL?	HERE,LAST-PSEUDO-LOC /TRUE
	RFALSE	
?CCL9:	IN?	OBJ,GENERIC-OBJECTS \?CND1
	RETURN	VIS?
?CND1:	SET	'PTR,GL-LOC-TRAIL
	SET	'OLOC,OBJ
?PRG13:	PUT	PTR,0,OLOC
	INC	'CNT
	ZERO?	OLOC /?REP14
	EQUAL?	OLOC,WINNER /?REP14
	IN?	OLOC,ROOMS /?REP14
	IN?	OLOC,LOCAL-GLOBALS /?REP14
	IN?	OLOC,GLOBAL-OBJECTS /?REP14
	IN?	OLOC,GENERIC-OBJECTS /?REP14
	LOC	OLOC >OLOC
	ADD	PTR,2 >PTR
	ZERO?	OLOC /?PRG13
	CALL	CLOSED?,OLOC,VIS?
	ZERO?	STACK /?PRG13
	ZERO?	CLSD-PTR \?PRG13
	SET	'CLSD-PTR,PTR
	JUMP	?PRG13
?REP14:	SET	'PTR,FALSE-VALUE
	SET	'WLOC,WINNER
?PRG29:	ZERO?	WLOC /FALSE
	INTBL?	WLOC,GL-LOC-TRAIL,CNT >PTR /?REP30
	IN?	WLOC,ROOMS /?REP30
	LOC	WLOC >WLOC
	ZERO?	WLOC /?PRG29
	CALL	CLOSED?,WLOC,VIS?
	ZERO?	STACK /?PRG29
	RFALSE	
?REP30:	ZERO?	WLOC /?CND41
	ZERO?	PTR \?CND43
	GETPT	WLOC,P?GLOBAL >TBL
	ZERO?	TBL /?CND43
	PTSIZE	TBL
	ADD	TBL,STACK >END
?PRG47:	LESS?	TBL,END \?CND43
	GET	TBL,0
	INTBL?	STACK,GL-LOC-TRAIL,CNT >PTR /?CND43
	ADD	TBL,2 >TBL
	JUMP	?PRG47
?CND43:	ZERO?	PTR \?CND53
	FIRST?	GLOBAL-OBJECTS >TBL /?PRG56
?PRG56:	ZERO?	TBL /?CND53
	INTBL?	TBL,GL-LOC-TRAIL,CNT >PTR /?CND53
	NEXT?	TBL >TBL /?PRG56
	JUMP	?PRG56
?CND53:	ZERO?	VIS? /?CND41
	ZERO?	PTR \?CND41
	GETP	WLOC,P?ADJACENT >TBL
	ZERO?	TBL /?CND41
	GETB	TBL,0 >END
	INC	'TBL
?PRG68:	DLESS?	'END,0 /?CND41
	GETB	TBL,1
	ZERO?	STACK /?CND70
	GETB	TBL,0
	INTBL?	STACK,GL-LOC-TRAIL,CNT >PTR /?CND41
?CND70:	ADD	TBL,2 >TBL
	JUMP	?PRG68
?CND41:	ZERO?	PTR /FALSE
	ZERO?	CLSD-PTR /TRUE
	GRTR?	PTR,CLSD-PTR /FALSE
	RTRUE	


	.FUNCT	RT-PRINT-DESC:ANY:1:1,OBJ
	FSET?	OBJ,FL-HAS-SDESC \?CCL3
	GETP	OBJ,P?ACTION
	CALL	STACK,M-OBJDESC
	RSTACK	
?CCL3:	PRINTD	OBJ
	RTRUE	


	.FUNCT	PRINT-ARTICLE:ANY:3:4,OBJ,ART,CAP?,SP?,MASK
	ASSIGNED?	'SP? /?CND1
	SET	'SP?,TRUE-VALUE
?CND1:	ZERO?	CAP? \?CND3
	ZERO?	SP? /?CND5
	PRINTC	32
?CND5:	SET	'MASK,32
?CND3:	EQUAL?	ART,K-ART-A \?CCL9
	FSET?	OBJ,FL-YOUR \?CCL12
	BOR	89,MASK
	PRINTC	STACK
	PRINTI	"our"
	RTRUE	
?CCL12:	FSET?	OBJ,FL-PLURAL \?CCL14
	BOR	83,MASK
	PRINTC	STACK
	PRINTI	"ome"
	RTRUE	
?CCL14:	BOR	65,MASK
	PRINTC	STACK
	FSET?	OBJ,FL-VOWEL \FALSE
	PRINTC	110
	RTRUE	
?CCL9:	EQUAL?	ART,K-ART-THE \?CCL19
	FSET?	OBJ,FL-YOUR \?CCL22
	BOR	89,MASK
	PRINTC	STACK
	PRINTI	"our"
	RTRUE	
?CCL22:	BOR	84,MASK
	PRINTC	STACK
	PRINTI	"he"
	RTRUE	
?CCL19:	EQUAL?	ART,K-ART-ANY \?CCL24
	BOR	65,MASK
	PRINTC	STACK
	PRINTI	"ny"
	RTRUE	
?CCL24:	EQUAL?	ART,K-ART-HE \?CCL26
	FSET?	OBJ,FL-PLURAL \?CCL29
	FSET?	OBJ,FL-COLLECTIVE /?CCL29
	BOR	84,MASK
	PRINTC	STACK
	PRINTI	"hey"
	RTRUE	
?CCL29:	FSET?	OBJ,FL-PERSON /?CCL33
	BOR	73,MASK
	PRINTC	STACK
	PRINTC	116
	RTRUE	
?CCL33:	EQUAL?	OBJ,CH-PLAYER \?CCL35
	BOR	89,MASK
	PRINTC	STACK
	PRINTI	"ou"
	RTRUE	
?CCL35:	FSET?	OBJ,FL-FEMALE \?CCL37
	BOR	83,MASK
	PRINTC	STACK
	PRINTI	"he"
	RTRUE	
?CCL37:	BOR	72,MASK
	PRINTC	STACK
	PRINTC	101
	RTRUE	
?CCL26:	EQUAL?	ART,K-ART-HIM \?CCL39
	FSET?	OBJ,FL-PLURAL \?CCL42
	FSET?	OBJ,FL-COLLECTIVE /?CCL42
	BOR	84,MASK
	PRINTC	STACK
	PRINTI	"hem"
	RTRUE	
?CCL42:	FSET?	OBJ,FL-PERSON /?CCL46
	BOR	73,MASK
	PRINTC	STACK
	PRINTC	116
	RTRUE	
?CCL46:	EQUAL?	OBJ,CH-PLAYER \?CCL48
	BOR	89,MASK
	PRINTC	STACK
	PRINTI	"ou"
	RTRUE	
?CCL48:	FSET?	OBJ,FL-FEMALE \?CCL50
	BOR	72,MASK
	PRINTC	STACK
	PRINTI	"er"
	RTRUE	
?CCL50:	BOR	72,MASK
	PRINTC	STACK
	PRINTI	"im"
	RTRUE	
?CCL39:	EQUAL?	ART,K-ART-HIS \FALSE
	FSET?	OBJ,FL-PLURAL \?CCL55
	FSET?	OBJ,FL-COLLECTIVE /?CCL55
	BOR	84,MASK
	PRINTC	STACK
	PRINTI	"heir"
	RTRUE	
?CCL55:	FSET?	OBJ,FL-PERSON /?CCL59
	BOR	73,MASK
	PRINTC	STACK
	PRINTI	"ts"
	RTRUE	
?CCL59:	EQUAL?	OBJ,CH-PLAYER \?CCL61
	BOR	89,MASK
	PRINTC	STACK
	PRINTI	"our"
	RTRUE	
?CCL61:	FSET?	OBJ,FL-FEMALE \?CCL63
	BOR	72,MASK
	PRINTC	STACK
	PRINTI	"er"
	RTRUE	
?CCL63:	BOR	72,MASK
	PRINTC	STACK
	PRINTI	"is"
	RTRUE	


	.FUNCT	RT-PRINT-OBJ:ANY:0:5,O,ART,CAP?,VERB,SP?,MASK
	ASSIGNED?	'ART /?CND1
	SET	'ART,K-ART-THE
?CND1:	ASSIGNED?	'SP? /?CND3
	SET	'SP?,TRUE-VALUE
?CND3:	ZERO?	O \?CND5
	SET	'O,PRSO
?CND5:	FSET?	O,FL-HAS-SDESC \?CCL9
	GETP	O,P?ACTION
	ICALL	STACK,M-OBJDESC,ART,CAP?
	JUMP	?CND7
?CCL9:	EQUAL?	ART,K-ART-HE,K-ART-HIM,K-ART-HIS \?CCL11
	FSET	O,FL-SEEN
	ICALL	PRINT-ARTICLE,O,ART,CAP?
	JUMP	?CND7
?CCL11:	FSET?	O,FL-NO-ARTICLE /?CCL13
	FSET	O,FL-SEEN
	ICALL	PRINT-ARTICLE,O,ART,CAP?
	PRINTC	32
	ICALL2	RT-PRINT-DESC,O
	JUMP	?CND7
?CCL13:	ZERO?	CAP? \?CND14
	PRINTC	32
	SET	'MASK,32
?CND14:	EQUAL?	O,CH-PLAYER \?CCL18
	BOR	89,MASK
	PRINTC	STACK
	PRINTI	"ou"
	JUMP	?CND7
?CCL18:	ICALL2	RT-PRINT-DESC,O
?CND7:	ZERO?	VERB /FALSE
	CALL	RT-PRINT-VERB,O,VERB
	RSTACK	


	.FUNCT	THIS-IS-IT:ANY:1:1,OBJ
	EQUAL?	OBJ,FALSE-VALUE,ROOMS,NOT-HERE-OBJECT /TRUE
	EQUAL?	OBJ,CH-PLAYER,INTDIR,GLOBAL-HERE /TRUE
	CALL1	DIR-VERB?
	ZERO?	STACK /?CND1
	EQUAL?	OBJ,PRSO /TRUE
?CND1:	FSET?	OBJ,FL-PERSON \?CCL11
	FSET?	OBJ,FL-FEMALE \?CCL14
	FSET	HER,FL-TOUCHED
	SET	'P-HER-OBJECT,OBJ
	RTRUE	
?CCL14:	FSET	HIM,FL-TOUCHED
	SET	'P-HIM-OBJECT,OBJ
	RTRUE	
?CCL11:	FSET?	OBJ,FL-PLURAL \?CCL16
	FSET?	OBJ,FL-COLLECTIVE /?CCL16
	FSET	THEM,FL-TOUCHED
	SET	'P-THEM-OBJECT,OBJ
	RTRUE	
?CCL16:	FSET	IT,FL-TOUCHED
	SET	'P-IT-OBJECT,OBJ
	RTRUE	


	.FUNCT	RT-PRINT-VERB:ANY:2:2,OBJ,VERB
	PRINTC	32
	EQUAL?	OBJ,CH-PLAYER /?CTR2
	FSET?	OBJ,FL-PLURAL \?CCL3
	FSET?	OBJ,FL-COLLECTIVE /?CCL3
?CTR2:	PRINT	VERB
	RTRUE	
?CCL3:	EQUAL?	VERB,STR?69 \?CCL10
	PRINTI	"is"
	RTRUE	
?CCL10:	EQUAL?	VERB,STR?75 \?CCL12
	PRINTI	"has"
	RTRUE	
?CCL12:	EQUAL?	VERB,STR?76 \?CCL14
	PRINTI	"tries"
	RTRUE	
?CCL14:	EQUAL?	VERB,STR?77 \?CCL16
	PRINTI	"empties"
	RTRUE	
?CCL16:	EQUAL?	VERB,STR?78 \?CCL18
	PRINTI	"flies"
	RTRUE	
?CCL18:	EQUAL?	VERB,STR?79 \?CCL20
	PRINTI	"dries"
	RTRUE	
?CCL20:	PRINT	VERB
	EQUAL?	VERB,STR?80,STR?81,STR?82 /?CCL22
	EQUAL?	VERB,STR?83,STR?84,STR?85 /?CCL22
	EQUAL?	VERB,STR?86,STR?87,STR?88 \?CND21
?CCL22:	PRINTC	101
?CND21:	PRINTC	115
	RTRUE	


	.FUNCT	RT-IN-ON-MSG:ANY:1:2,OBJ,CAP?,MASK
	EQUAL?	OBJ,TH-BEHIND-G-STONE,TH-BEHIND-ROCK,TH-BEHIND-DOOR /FALSE
	ZERO?	CAP? \?CND4
	PRINTC	32
	SET	'MASK,32
?CND4:	FSET?	OBJ,FL-SURFACE \?CCL8
	BOR	79,MASK
	PRINTC	STACK
	JUMP	?CND6
?CCL8:	BOR	73,MASK
	PRINTC	STACK
?CND6:	PRINTC	110
	RTRUE	


	.FUNCT	RT-OUT-OFF-MSG:ANY:1:2,OBJ,CAP?
	FSET?	OBJ,FL-SURFACE /?CCL3
	FSET?	OBJ,FL-CONTAINER \FALSE
?CCL3:	ZERO?	CAP? \?CCL8
	PRINTI	" o"
	JUMP	?CND6
?CCL8:	PRINTC	79
?CND6:	FSET?	OBJ,FL-SURFACE \?CCL11
	PRINTI	"ff"
	RTRUE	
?CCL11:	PRINTI	"ut"
	RTRUE	


	.FUNCT	RT-OPEN-MSG:ANY:0:1,OBJ
	ZERO?	OBJ \?CND1
	SET	'OBJ,PRSO
?CND1:	PRINTC	32
	FSET?	OBJ,FL-OPEN \?CCL5
	PRINTI	"open"
	RTRUE	
?CCL5:	PRINTI	"closed"
	RTRUE	


	.FUNCT	RT-WALK-MSG:ANY:0:1,ING?,N
	PRINTC	32
	EQUAL?	GL-PLAYER-FORM,K-FORM-ARTHUR \?CCL3
	PRINTI	"walk"
	JUMP	?CND1
?CCL3:	EQUAL?	GL-PLAYER-FORM,K-FORM-OWL \?CCL5
	RANDOM	3 >N
	EQUAL?	N,1 \?CCL8
	PRINTI	"fly"
	JUMP	?CND1
?CCL8:	EQUAL?	N,2 \?CCL10
	PRINTI	"hop"
	JUMP	?CND1
?CCL10:	PRINTI	"scurry"
	JUMP	?CND1
?CCL5:	EQUAL?	GL-PLAYER-FORM,K-FORM-BADGER,K-FORM-SALAMANDER \?CCL12
	RANDOM	4 >N
	EQUAL?	N,1 \?CCL15
	PRINTI	"walk"
	JUMP	?CND1
?CCL15:	EQUAL?	N,2 \?CCL17
	PRINTI	"crawl"
	JUMP	?CND1
?CCL17:	EQUAL?	N,3 \?CCL19
	PRINTI	"scamper"
	JUMP	?CND1
?CCL19:	PRINTI	"scurry"
	JUMP	?CND1
?CCL12:	EQUAL?	GL-PLAYER-FORM,K-FORM-EEL,K-FORM-TURTLE \?CND1
	RANDOM	2 >N
	EQUAL?	N,1 \?CCL23
	PRINTI	"swim"
	ZERO?	ING? /?CND1
	PRINTC	109
	JUMP	?CND1
?CCL23:	PRINTI	"glid"
	ZERO?	ING? \?CND1
	PRINTC	101
?CND1:	ZERO?	ING? /FALSE
	PRINTI	"ing"
	RTRUE	


	.FUNCT	RT-STANDING-MSG:ANY:0:0,N
	PRINTC	32
	EQUAL?	GL-PLAYER-FORM,K-FORM-ARTHUR \?CCL3
	PRINTI	"standing"
	RTRUE	
?CCL3:	EQUAL?	GL-PLAYER-FORM,K-FORM-OWL \?CCL6
	PRINTI	"scamper"
	JUMP	?CND4
?CCL6:	EQUAL?	GL-PLAYER-FORM,K-FORM-BADGER,K-FORM-SALAMANDER \?CCL8
	PRINTI	"crawl"
	JUMP	?CND4
?CCL8:	EQUAL?	GL-PLAYER-FORM,K-FORM-EEL \?CCL10
	RANDOM	2 >N
	EQUAL?	N,1 \?CCL13
	PRINTI	"swimm"
	JUMP	?CND4
?CCL13:	PRINTI	"float"
	JUMP	?CND4
?CCL10:	EQUAL?	GL-PLAYER-FORM,K-FORM-TURTLE \?CND4
	FSET?	HERE,FL-WATER \?CCL17
	PRINTI	"swimm"
	JUMP	?CND4
?CCL17:	PRINTI	"crawl"
?CND4:	PRINTI	"ing around"
	RTRUE	


	.FUNCT	RT-I-BELL:ANY:0:0
	ADD	GL-MOVES,180
	ICALL	RT-QUEUE,RT-I-BELL,STACK
	FSET?	CH-CELL-GUARD,FL-ASLEEP /?CND1
	ADD	GL-MOVES,1
	ICALL	RT-QUEUE,RT-I-GUARD-1,STACK
?CND1:	SET	'GL-POEM-LINE,0
	FSET?	CH-PLAYER,FL-ASLEEP /FALSE
	EQUAL?	HERE,RM-GREAT-HALL,RM-BEHIND-THRONE /?CCL8
	EQUAL?	PRSA,V?WAIT \?CCL8
	ZERO?	GL-BELL-WAIT \?CTR7
	ADD	GL-MOVES,180
	GRTR?	GL-NEW-TIME,STACK \?CCL8
?CTR7:	ZERO?	GL-BELL-WAIT \FALSE
	SET	'GL-BELL-WAIT,TRUE-VALUE
	PRINTI	"
While you wait, you hear the bells in the distance tolling the hours.
"
	RFALSE	
?CCL8:	EQUAL?	PRSA,V?WAIT /?CND16
	SET	'GL-BELL-WAIT,FALSE-VALUE
?CND16:	PRINTI	"
In the distance, you hear the sound of the bells calling the monks to prayer.
"
	EQUAL?	HERE,RM-GREAT-HALL \?CCL20
	FSET?	CH-SOLDIERS,FL-LOCKED /?CCL20
	PRINTI	"
The soldier"
	ICALL1	RT-LEAVE-CASTLE
	RTRUE	
?CCL20:	EQUAL?	HERE,RM-GREAT-HALL,RM-BEHIND-THRONE \FALSE
	RANDOM	4 >GL-POEM-LINE
	PRINTI	"
King Lot calls out to the captain of his guards, ""The new password is verse three, line"
	ICALL2	RT-WORD-NUMBERS,GL-POEM-LINE
	PRINTI	".""
"
	FSET?	TH-PASSWORD,FL-TOUCHED /TRUE
	FSET	TH-PASSWORD,FL-TOUCHED
	ICALL	RT-SCORE-MSG,0,2,0,1
	RTRUE	


	.FUNCT	CLOCKER:ANY:0:0,NT,ABORT?,RTN,TIME,ANY?,MULT?,DIF,N,VAL,I,Z1,Z2
	SET	'GL-DROP-HERE,FALSE-VALUE
	EQUAL?	GL-QUESTION,1 \?CCL3
	INC	'GL-QUESTION
	JUMP	?CND1
?CCL3:	SET	'GL-QUESTION,0
?CND1:	ZERO?	CLOCK-WAIT /?CND4
	SET	'CLOCK-WAIT,FALSE-VALUE
	RFALSE	
?CND4:	SET	'GL-NEW-TIME,GL-MOVES
	SET	'NT,GL-MOVES
	SET	'VAL,FALSE-VALUE
?PRG6:	EQUAL?	GL-WINDOW-TYPE,K-WIN-INVT \?CCL10
	BAND	GL-UPDATE-WINDOW,K-UPD-INVT
	ZERO?	STACK /?CND8
	ICALL1	RT-UPDATE-INVT-WINDOW
	JUMP	?CND8
?CCL10:	EQUAL?	GL-WINDOW-TYPE,K-WIN-DESC \?CND8
	BAND	GL-UPDATE-WINDOW,K-UPD-DESC
	ZERO?	STACK \?CCL15
	BAND	GL-UPDATE-WINDOW,K-UPD-OBJS
	ZERO?	STACK /?CND8
?CCL15:	ICALL1	RT-UPDATE-DESC-WINDOW
?CND8:	SET	'RTN,FALSE-VALUE
	SET	'TIME,NT
	SET	'ANY?,FALSE-VALUE
	SET	'MULT?,FALSE-VALUE
	SET	'I,0
?PRG18:	GET	GL-Q-TBL,I >Z1
	ADD	I,1
	GET	GL-Q-TBL,STACK >Z2
	ZERO?	Z1 /?CND20
	GRTR?	Z2,TIME /?CND20
	ZERO?	RTN /?CND24
	EQUAL?	Z2,TIME \?CND24
	SET	'MULT?,TRUE-VALUE
?CND24:	SET	'RTN,Z1
	SET	'TIME,Z2
	SET	'N,I
	SET	'ANY?,TRUE-VALUE
?CND20:	ADD	I,2 >I
	LESS?	I,K-Q-SIZE \?REP19
	LESS?	I,GL-Q-MAX /?PRG18
?REP19:	ZERO?	ANY? /?REP7
	SET	'GL-MOVES,TIME
	FSET?	CH-PLAYER,FL-ASLEEP /?CND35
	ICALL1	UPDATE-STATUS-LINE
?CND35:	LESS?	TIME,NT /?PRD37
	PUSH	0
	JUMP	?PRD38
?PRD37:	PUSH	1
?PRD38:	SET	'DIF,STACK
	PUT	GL-Q-TBL,N,0
	ADD	N,1
	PUT	GL-Q-TBL,STACK,0
	ADD	N,2
	EQUAL?	STACK,GL-Q-MAX \?CND39
	SUB	GL-Q-MAX,2 >GL-Q-MAX
?CND39:	SET	'GL-CLK-RUN,TRUE-VALUE
	CALL	RTN
	ZERO?	STACK /?CND41
	SET	'VAL,TRUE-VALUE
?CND41:	SET	'GL-CLK-RUN,FALSE-VALUE
	GRTR?	GL-MOVES,NT \?CND43
	SET	'GL-NEW-TIME,GL-MOVES
	SET	'NT,GL-MOVES
?CND43:	ZERO?	VAL /?PRG6
	ZERO?	MULT? \?PRG6
	ZERO?	DIF /?PRG6
	EQUAL?	PRSA,V?WAIT \?PRG6
	FSET?	CH-PLAYER,FL-ASLEEP /?PRG6
	SET	'VAL,FALSE-VALUE
	PRINTI	"
Do you want to continue waiting"
	CALL1	YES?
	ZERO?	STACK \?CCL54
	SET	'NT,TIME
	SET	'ABORT?,TRUE-VALUE
?REP7:	SET	'GL-MOVES,NT
	INC	'GL-MOVES
	SET	'GL-IDIOT-WAIT,FALSE-VALUE
	SET	'GL-BELL-WAIT,FALSE-VALUE
	ZERO?	ABORT? /FALSE
	RETURN	2
?CCL54:	PRINT	K-TIME-PASSES-MSG
	CRLF	
	JUMP	?PRG6


	.FUNCT	RT-QUEUE:ANY:2:3,RTN,TIME,ABS?,I
?PRG1:	GET	GL-Q-TBL,I
	ZERO?	STACK \?CCL5
	PUT	GL-Q-TBL,I,RTN
	ADD	I,1
	PUT	GL-Q-TBL,STACK,TIME
	ADD	I,2
	GRTR?	STACK,GL-Q-MAX \TRUE
	ADD	I,2 >GL-Q-MAX
	RTRUE	
?CCL5:	ADD	I,2 >I
	LESS?	I,K-Q-SIZE /?PRG1
	RFALSE	


	.FUNCT	RT-DEQUEUE:ANY:1:1,RTN,I
?PRG1:	GET	GL-Q-TBL,I
	EQUAL?	STACK,RTN \?CCL5
	PUT	GL-Q-TBL,I,0
	ADD	I,1
	PUT	GL-Q-TBL,STACK,0
	ADD	I,2
	EQUAL?	STACK,GL-Q-MAX \TRUE
	SUB	GL-Q-MAX,2 >GL-Q-MAX
	RTRUE	
?CCL5:	ADD	I,2 >I
	LESS?	I,K-Q-SIZE \FALSE
	LESS?	I,GL-Q-MAX /?PRG1
	RFALSE	


	.FUNCT	RT-IS-QUEUED?:ANY:1:1,RTN,TIME,I
?PRG1:	GET	GL-Q-TBL,I
	EQUAL?	STACK,RTN \?CCL5
	ADD	I,1
	GET	GL-Q-TBL,STACK >TIME
	RETURN	TIME
?CCL5:	ADD	I,2 >I
	LESS?	I,K-Q-SIZE \FALSE
	LESS?	I,GL-Q-MAX /?PRG1
	RFALSE	


	.FUNCT	C-PIXELS:ANY:1:1,X
	SUB	X,1
	MUL	STACK,GL-FONT-X
	ADD	STACK,1
	RSTACK	


	.FUNCT	L-PIXELS:ANY:1:1,Y
	SUB	Y,1
	MUL	STACK,GL-FONT-Y
	ADD	STACK,1
	RSTACK	


	.FUNCT	PIXELS-C:ANY:1:1,X
	SUB	X,1
	DIV	STACK,GL-FONT-X
	ADD	STACK,1
	RSTACK	


	.FUNCT	PIXELS-L:ANY:1:1,Y
	SUB	Y,1
	DIV	STACK,GL-FONT-Y
	ADD	STACK,1
	RSTACK	


	.FUNCT	CCURSET:ANY:2:3,Y,X,W,?TMP1
	ASSIGNED?	'W /?CND1
	SET	'W,-3
?CND1:	CALL2	L-PIXELS,Y >?TMP1
	CALL2	C-PIXELS,X
	CURSET	?TMP1,STACK,W
	RTRUE	


	.FUNCT	CSPLIT:ANY:1:1,Y
	MUL	Y,GL-FONT-Y
	SPLIT	STACK
	RTRUE	


	.FUNCT	RT-SCRIPT-INBUF:ANY:0:1,BUF,CNT,N,CHR
	ASSIGNED?	'BUF /?CND1
	SET	'BUF,P-INBUF
?CND1:	GETB	BUF,1 >N
	DIROUT	D-SCREEN-OFF
	INC	'BUF
?PRG3:	IGRTR?	'CNT,N /?REP4
	GETB	BUF,CNT >CHR
	LESS?	CHR,97 /?CCL10
	GRTR?	CHR,122 /?CCL10
	SUB	CHR,32
	PRINTC	STACK
	JUMP	?PRG3
?CCL10:	PRINTC	CHR
	JUMP	?PRG3
?REP4:	CRLF	
	DIROUT	D-SCREEN-ON
	RTRUE	


	.FUNCT	GO:ANY:0:0
?FCN:	GETB	0,33 >GL-SCR-WID
	LESS?	GL-SCR-WID,64 \?CND1
	PRINTI	"[The screen is too narrow.]"
	CRLF	
	QUIT	
?CND1:	WINGET	0,WFSIZE
	SHIFT	STACK,-8
	BAND	STACK,255 >GL-FONT-Y
	WINGET	0,WFSIZE
	BAND	STACK,255 >GL-FONT-X
	DIROUT	K-D-TBL-ON,K-DIROUT-TBL
	PRINTC	32
	DIROUT	K-D-TBL-OFF
	GET	0,24 >GL-SPACE-WIDTH
	ZERO?	GL-SPACE-WIDTH \?CND3
	GET	0,17 >GL-SPACE-WIDTH
	GETB	0,33
	DIV	GL-SPACE-WIDTH,STACK >GL-SPACE-WIDTH
?CND3:	CLEAR	-1
	ICALL2	RT-CENTER-PIC,K-PIC-TITLE
	CURSET	-1
	INPUT	1,150,RT-STOP-READ
	CURSET	-2
	CLEAR	-1
?PRG5:	PRINTI	"
Would you like to restore a saved position"
	CALL1	YES?
	ZERO?	STACK /?REP6
	ICALL1	V-RESTORE
	JUMP	?PRG5
?REP6:	CLEAR	-1
	ICALL2	RT-CENTER-PIC,K-PIC-SWORD
	CURSET	-1
	INPUT	1,150,RT-STOP-READ
	CURSET	-2
	CLEAR	-1
	PRINTI	"You are shivering in the cold night air of an English churchyard, unsure of the forces that are driving you on this night of destiny. Here among the gravestones, the most famous sword in all England grows out of the anvil-shaped rock. A shaft of moonlight falls upon the magic runes that shimmer in the polished steel:

"
	PRINT	K-WHOSO-PULLETH-MSG
	PRINTI	".

The local chieftain, King Lot, has declared a curfew, and you know that even a boy such as yourself would be thrown in prison should you be caught by his soldiers. Yet you have come anyway, irresistibly drawn by this sword of mystery. Noblemen from far and wide have tried and failed to draw the sword from the stone, yet something inside urges you to try.

Slowly you approach the sword. Driven by some inner force, you clasp your hand around the hilt. The two seem made for one another. You pull. Nothing happens. You strain harder. The sword gives a little, and then....
"
	INPUT	1,600,RT-STOP-READ
	CLEAR	-1
	ICALL2	RT-CENTER-PIC,K-PIC-SWORD
	ICALL2	RT-CENTER-PIC,K-PIC-SWORD-MERLIN
	CURSET	-1
	INPUT	1,150,RT-STOP-READ
	CURSET	-2
	CLEAR	-1
	ICALL1	INIT-STATUS-LINE
	CALL1	LIT? >LIT
	ICALL1	V-FIRST-LOOK
	ICALL	RT-QUEUE,RT-I-SOLDIER-1,1437,TRUE-VALUE
	ICALL	RT-QUEUE,RT-I-BELL,1439,TRUE-VALUE
	ICALL	RT-QUEUE,RT-I-SUNSET,2490,TRUE-VALUE
	ICALL	RT-QUEUE,RT-I-BLOOM,4695,TRUE-VALUE
	ICALL	RT-QUEUE,RT-I-OUT-OF-TIME,5040,TRUE-VALUE
	SET	'GL-PICTURE-NUM,K-PIC-CHURCHYARD
	ICALL2	RT-UPDATE-PICT-WINDOW,TRUE-VALUE
	MOUSE-LIMIT	-1
	ICALL1	MAIN-LOOP
	JUMP	?FCN

	.ENDI
