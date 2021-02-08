

	.FUNCT	RT-RM-END-OF-CAUSEWAY:ANY:0:1,CONTEXT,N
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	FSET	CH-RED-KNIGHT,FL-SEEN
	FSET	LG-LAKE,FL-SEEN
	FSET	RM-ISLAND,FL-SEEN
	FSET	RM-FIELD-OF-HONOUR,FL-SEEN
	PRINTI	"You are at the end of a causeway which is guarded by"
	ICALL	RT-PRINT-OBJ,CH-RED-KNIGHT,K-ART-A
	PRINTI	". The causeway leads south across the lake to an island. The Field of Honour lies to the west.
"
	RFALSE	
?CCL3:	EQUAL?	CONTEXT,M-ENTER \?CCL5
	SET	'GL-PICTURE-NUM,K-PIC-RED-KNIGHT
	EQUAL?	GL-WINDOW-TYPE,K-WIN-PICT \FALSE
	ICALL1	RT-UPDATE-PICT-WINDOW
	RFALSE	
?CCL5:	EQUAL?	CONTEXT,M-ENTERED \?CCL9
	ZERO?	GL-PLAYER-FORM \FALSE
	EQUAL?	GL-GIFT-COUNT,255 \?CCL14
	SET	'GL-GIFT-COUNT,0
	CRLF	
	ICALL	RT-PRINT-OBJ,CH-RED-KNIGHT,K-ART-THE,TRUE-VALUE
	PRINTI	" stands "
	EQUAL?	OHERE,RM-FIELD-OF-HONOUR \?CCL17
	PRINTI	"at attention before you, staring off into the distance. He acknowleges your presence enough to say,"
	JUMP	?CND15
?CCL17:	PRINTI	"at attention with his back to you. Suddenly he looks around and says, ""How did you get there? ... No matter."" He eyes you warily and continues,"
?CND15:	PRINTI	" ""You shall get no further unless you bring me"
	PRINT	K-RAVEN-EGG-MSG
	PRINTC	44
	PRINT	K-DRAGON-HAIR-MSG
	PRINTC	44
	PRINT	K-BOAR-TUSK-MSG
	PRINTI	", and"
	PRINT	K-GOLDEN-FLEECE-MSG
	PRINTR	"."""
?CCL14:	EQUAL?	GL-GIFT-COUNT,4 \?CCL19
	CRLF	
	ICALL	RT-PRINT-OBJ,CH-RED-KNIGHT,K-ART-THE,TRUE-VALUE
	PRINTR	" acknowledges your arrival with a polite nod and indicates that you are free to pass by."
?CCL19:	PRINTI	"
The knight removes his stare from the horizon long enough to say, "
	CALL1	RT-RED-GIFTS-MSG
	RSTACK	
?CCL9:	EQUAL?	CONTEXT,M-END \?CCL21
	EQUAL?	PRSA,V?TRANSFORM \FALSE
	EQUAL?	GL-PLAYER-FORM,GL-OLD-FORM /FALSE
	CRLF	
	ICALL	RT-PRINT-OBJ,CH-RED-KNIGHT,K-ART-THE,TRUE-VALUE
	PRINTI	" cries, ""Sorcery! Work of the Devil!!"" He kills you instantly."
	PRINT	K-HEEDED-WARNING-MSG
	CALL1	RT-END-OF-GAME
	RSTACK	
?CCL21:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-RED-GIFTS-MSG:ANY:0:0,N,OBJ,1ST?,NXT
	PRINTI	"""You "
	GRTR?	GL-GIFT-COUNT,0 \?CND1
	PRINTI	"have given me"
	FIRST?	CH-RED-KNIGHT >OBJ /?BOGUS3
?BOGUS3:	SET	'1ST?,TRUE-VALUE
?PRG4:	ZERO?	OBJ /?REP5
	NEXT?	OBJ >NXT /?BOGUS9
?BOGUS9:	ZERO?	1ST? /?CCL12
	SET	'1ST?,FALSE-VALUE
	JUMP	?CND10
?CCL12:	ICALL2	RT-COMMA-MSG,NXT
?CND10:	ICALL	RT-PRINT-OBJ,OBJ,K-ART-THE
	SET	'OBJ,NXT
	JUMP	?PRG4
?REP5:	PRINTI	" but you "
?CND1:	PRINTI	"still may not pass until you have given me"
	SET	'N,0
	IN?	TH-RAVEN-EGG,CH-RED-KNIGHT /?CND13
	INC	'N
	PRINT	K-RAVEN-EGG-MSG
?CND13:	IN?	TH-DRAGON-HAIR,CH-RED-KNIGHT /?CND15
	IGRTR?	'N,1 \?CND17
	ADD	N,GL-GIFT-COUNT
	LESS?	STACK,4 /?PRD19
	PUSH	0
	JUMP	?PRD20
?PRD19:	PUSH	1
?PRD20:	ICALL2	RT-COMMA-MSG,STACK
?CND17:	PRINT	K-DRAGON-HAIR-MSG
?CND15:	IN?	TH-TUSK,CH-RED-KNIGHT /?CND21
	IGRTR?	'N,1 \?CND23
	ADD	N,GL-GIFT-COUNT
	LESS?	STACK,4 /?PRD25
	PUSH	0
	JUMP	?PRD26
?PRD25:	PUSH	1
?PRD26:	ICALL2	RT-COMMA-MSG,STACK
?CND23:	PRINT	K-BOAR-TUSK-MSG
?CND21:	IN?	TH-FLEECE,CH-RED-KNIGHT /?CND27
	IGRTR?	'N,1 \?CND29
	ADD	N,GL-GIFT-COUNT
	LESS?	STACK,4 /?PRD31
	PUSH	0
	JUMP	?PRD32
?PRD31:	PUSH	1
?PRD32:	ICALL2	RT-COMMA-MSG,STACK
?CND29:	PRINT	K-GOLDEN-FLEECE-MSG
?CND27:	PRINTR	"."""


	.FUNCT	RT-CH-RED-KNIGHT:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-WINNER \?CCL3
	EQUAL?	PRSA,V?TELL-ABOUT \?CCL6
	EQUAL?	PRSO,CH-PLAYER /FALSE
?CCL6:	ICALL	RT-PRINT-OBJ,CH-RED-KNIGHT,K-ART-THE,TRUE-VALUE,STR?327
	PRINTR	" to stare straight ahead, ignoring your presence."
?CCL3:	EQUAL?	CONTEXT,M-CONT \?CCL10
	EQUAL?	PRSA,V?ASK-FOR \?CCL13
	ICALL	RT-PRINT-OBJ,CH-RED-KNIGHT,K-ART-THE,TRUE-VALUE,STR?328
	PRINTR	" a quick glance at you. ""It's very good of you to ask. The answer is no."""
?CCL13:	EQUAL?	PRSA,V?ASK-ABOUT \?CCL15
	ZERO?	NOW-PRSI \?CCL15
	ICALL	RT-PRINT-OBJ,CH-RED-KNIGHT,K-ART-THE,TRUE-VALUE
	PRINTR	" nods imperceptibly and says out of the side of his mouth, ""Yes, I have it. Thank you very much."""
?CCL15:	EQUAL?	PRSA,V?TRADE-FOR \?CCL19
	ICALL	RT-PRINT-OBJ,CH-RED-KNIGHT,K-ART-THE,TRUE-VALUE
	PRINTR	" refuses your offer, saying, ""I'm sorry. No substitutions."""
?CCL19:	CALL1	TOUCH-VERB?
	ZERO?	STACK /FALSE
	ICALL	RT-PRINT-OBJ,CH-RED-KNIGHT,K-ART-THE,TRUE-VALUE
	PRINTI	" moves"
	ICALL	RT-PRINT-OBJ,PRSO,K-ART-THE
	PRINTR	" beyond your grasp and cuffs you on the head, saying, ""It's not polite to take things without asking."""
?CCL10:	ZERO?	CONTEXT \FALSE
	ZERO?	NOW-PRSI /?CCL25
	EQUAL?	PRSA,V?SHOW,V?GIVE \FALSE
	EQUAL?	PRSO,TH-RAVEN-EGG,TH-DRAGON-HAIR,TH-TUSK /?CTR30
	EQUAL?	PRSO,TH-FLEECE \?CCL31
?CTR30:	MOVE	PRSO,CH-RED-KNIGHT
	FSET	PRSO,FL-TRY-TAKE
	FSET	PRSO,FL-NO-DESC
	INC	'GL-GIFT-COUNT
	BOR	GL-UPDATE-WINDOW,K-UPD-INVT >GL-UPDATE-WINDOW
	ICALL	RT-PRINT-OBJ,CH-RED-KNIGHT,K-ART-THE,TRUE-VALUE
	PRINTI	" takes"
	ICALL	RT-PRINT-OBJ,PRSO,K-ART-THE
	EQUAL?	GL-GIFT-COUNT,1 \?CCL36
	PRINTI	" and says, ""Now this is a very nice start. But I must have the other items to let you by."""
	CRLF	
	JUMP	?CND34
?CCL36:	EQUAL?	GL-GIFT-COUNT,2 \?CCL38
	PRINTI	", looks at you with delight and says, ""Well done. These aren't easy to come by."""
	CRLF	
	JUMP	?CND34
?CCL38:	EQUAL?	GL-GIFT-COUNT,3 \?CCL40
	PRINTI	" and says, ""You have been busy, haven't you. Still, there is that one other item I mentioned."""
	CRLF	
	JUMP	?CND34
?CCL40:	EQUAL?	GL-GIFT-COUNT,4 \?CND34
	PRINTI	" and looks at you with new-found respect. ""Appearances deceive,"" he says. ""The one who has done these things must be more than a mere boy."" He steps aside to let you pass."
	CRLF	
?CND34:	CALL	RT-SCORE-MSG,0,0,0,1
	RSTACK	
?CCL31:	EQUAL?	PRSO,TH-BRASS-EGG \?CCL43
	ICALL	RT-PRINT-OBJ,CH-RED-KNIGHT,K-ART-THE,TRUE-VALUE
	PRINTR	" refuses your offer, saying, ""This imitation might take in a giant raven, but it would never fool me."""
?CCL43:	ICALL	RT-PRINT-OBJ,CH-RED-KNIGHT,K-ART-THE,TRUE-VALUE
	PRINTR	" refuses your offer, saying, ""I'm sorry. No substitutions."""
?CCL25:	EQUAL?	PRSA,V?TELL \?CCL45
	ZERO?	P-CONT \FALSE
?CCL45:	EQUAL?	PRSA,V?ASK-ABOUT \?CCL49
	EQUAL?	PRSI,TH-RAVEN-EGG,CH-RAVEN \?CCL52
	PRINTR	"""The giant raven nests deep within the enchanted forest. It cannot be killed, but if I have the egg, I can lessen its evil."""
?CCL52:	EQUAL?	PRSI,TH-DRAGON-HAIR,CH-DRAGON \?CCL54
	PRINTR	"""The dragon guards the entrance to the demon's mountain."""
?CCL54:	EQUAL?	PRSI,TH-TUSK,TH-BOAR \?CCL56
	PRINTR	"""The boar roams the enchanted forest, making it unsafe for all who dwell there."""
?CCL56:	EQUAL?	PRSI,TH-FLEECE \?CCL58
	PRINTR	"""It was stolen by an evil demon who lets no one come near it."""
?CCL58:	EQUAL?	PRSI,TH-BRASS-EGG \?CCL60
	PRINTR	"He glances around quickly to see if anyone is looking, and then he lowers his voice and says, ""It looks like the kind of the trash the invisible knight deals in. Why they don't put that guy out of business is beyond me."""
?CCL60:	EQUAL?	PRSI,CH-RED-KNIGHT \?CCL62
	PRINTR	"""I stand here night and day. Anyone who would pass by me must prove his worth by helping rid the countryside of the evils that beset it."""
?CCL62:	EQUAL?	PRSI,CH-MERLIN \?CCL64
	PRINTR	"""Like myself, he seeks to rid the land of evil."""
?CCL64:	EQUAL?	PRSI,CH-DEMON \?CCL66
	PRINTR	"""He is evil incarnate. I shall never rest until he is slain."""
?CCL66:	EQUAL?	PRSI,CH-LOT \?CCL68
	PRINTR	"""Let him come here himself and he will find out soon enough what I think of him."""
?CCL68:	PRINTI	"""I'm sorry. I am not at liberty to reveal anything about"
	ICALL	RT-PRINT-OBJ,PRSI,K-ART-HIM
	PRINTR	"."""
?CCL49:	EQUAL?	PRSA,V?EXAMINE \?CCL70
	FSET	CH-RED-KNIGHT,FL-SEEN
	PRINTR	"He stands stiffly at attention and stares straight ahead. His uniform is bright red armour."
?CCL70:	EQUAL?	PRSA,V?ASK-FOR \?CCL72
	ICALL	RT-PRINT-OBJ,CH-RED-KNIGHT,K-ART-THE,TRUE-VALUE
	PRINTI	" responds, ""I do not have"
	ICALL	RT-PRINT-OBJ,PRSI,K-ART-HIM
	PRINTR	"."""
?CCL72:	EQUAL?	PRSA,V?ATTACK \?CCL74
	ZERO?	GL-PLAYER-FORM \?CTR76
	EQUAL?	GL-GIFT-COUNT,4 \?CCL77
?CTR76:	ICALL	RT-PRINT-OBJ,CH-RED-KNIGHT,K-ART-THE,TRUE-VALUE
	PRINTR	" sidesteps your attack and looks at you in surprise."
?CCL77:	ICALL	RT-PRINT-OBJ,CH-RED-KNIGHT,K-ART-THE,TRUE-VALUE
	PRINTR	" easily fends you off and says, ""No need to get violent, young fella. Just bring me the items I have asked for and you'll find me willing enough to let you by."""
?CCL74:	EQUAL?	PRSA,V?POLISH \?CCL81
	PRINTR	"You give the knight a quick spit-shine. He says, ""Thanks, kid. I'd give you a dime, but they haven't been invented yet. Take this instead."" He cuffs you on the side of the head."
?CCL81:	EQUAL?	PRSA,V?GOODBYE,V?HELLO \FALSE
	ICALL	RT-PRINT-OBJ,CH-RED-KNIGHT,K-ART-THE,TRUE-VALUE,STR?327
	PRINTR	" to stare straight ahead, ignoring your presence."


	.FUNCT	RT-RED-KNIGHT-GIFTS:ANY:0:1,QUIET
	ZERO?	QUIET \?CTR2
	ZERO?	GL-PLAYER-FORM /?CCL3
?CTR2:	RETURN	RM-CAUSEWAY
?CCL3:	EQUAL?	GL-GIFT-COUNT,4 \?CCL7
	ICALL	RT-PRINT-OBJ,CH-RED-KNIGHT,K-ART-THE,TRUE-VALUE
	PRINTI	" steps aside to let you pass.

"
	RETURN	RM-CAUSEWAY
?CCL7:	ICALL	RT-PRINT-OBJ,CH-RED-KNIGHT,K-ART-THE,TRUE-VALUE
	PRINTI	" blocks your path and says, "
	ICALL1	RT-RED-GIFTS-MSG
	RFALSE	


	.FUNCT	RT-RM-CAUSEWAY:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	FSET	RM-ISLAND,FL-SEEN
	PRINTI	"You are"
	ICALL1	RT-STANDING-MSG
	PRINTI	" on a causeway that leads from the mainland south to the island."
	JUMP	?CND4
?CCL6:	EQUAL?	OHERE,RM-END-OF-CAUSEWAY \?CCL8
	FSET	RM-ISLAND,FL-SEEN
	PRINTI	"You"
	ICALL1	RT-WALK-MSG
	PRINTI	" past the knight onto the causeway that leads south to the island."
	JUMP	?CND4
?CCL8:	PRINTI	"You step onto the causeway that leads north to the mainland."
?CND4:	CRLF	
	RFALSE	
?CCL3:	EQUAL?	CONTEXT,M-ENTER \?CCL10
	SET	'GL-PICTURE-NUM,K-PIC-CAUSEWAY
	EQUAL?	GL-WINDOW-TYPE,K-WIN-PICT \FALSE
	ICALL1	RT-UPDATE-PICT-WINDOW
	RFALSE	
?CCL10:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-YOU-WOULD-DROWN:ANY:0:1,QUIET
	ZERO?	QUIET \FALSE
	PRINTI	"If you went that way, you would drown."
	CRLF	
	RFALSE	

	.ENDI
