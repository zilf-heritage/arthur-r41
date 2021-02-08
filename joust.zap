

	.FUNCT	RT-RM-EDGE-OF-WOODS:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-BEG \?CCL3
	EQUAL?	PRSA,V?CLIMB-ON \?CCL6
	EQUAL?	PRSO,ROOMS \?CCL6
	ICALL	PERFORM,V?CLIMB-ON,TH-HORSE
	RTRUE	
?CCL6:	EQUAL?	PRSA,V?TAKE \FALSE
	EQUAL?	PRSO,ROOMS \FALSE
	ICALL	SETUP-ORPHAN-NP,STR?72,TH-RED-LANCE,TH-GREEN-LANCE
	PRINTI	"The knight slaps you on the wrist and says, ""Musn't be greedy. "
	PRINT	K-WHICH-LANCE-MSG
	RETURN	2
?CCL3:	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL16
	PRINTI	"You "
	EQUAL?	CONTEXT,M-LOOK \?CCL19
	PRINTI	"are"
	IN?	CH-PLAYER,TH-HORSE \?CCL22
	PRINTI	" riding a horse"
	JUMP	?CND20
?CCL22:	ICALL1	RT-STANDING-MSG
?CND20:	PRINTI	" at"
	JUMP	?CND17
?CCL19:	PRINTI	"come to"
?CND17:	FSET	TH-BLUE-PAVILION,FL-SEEN
	FSET	TH-HORN,FL-SEEN
	FSET	TH-TREE,FL-SEEN
	FSET	TH-HORSE,FL-SEEN
	PRINTI	" the edge of the woods, where you see a knight's pavilion decked out in blue. There is a horse tied to the tree next to the pavilion, and from a branch above its head hangs a horn. The path continues north into the woods, and south towards the town.
"
	RFALSE	
?CCL16:	EQUAL?	CONTEXT,M-END \?CCL24
	EQUAL?	PRSA,V?TRANSFORM \FALSE
	IN?	CH-BLUE-KNIGHT,RM-EDGE-OF-WOODS \FALSE
	EQUAL?	GL-PLAYER-FORM,GL-OLD-FORM /?CCL32
	PRINTI	"
The knight looks at you curiously, says ""Damned odd,"" and runs you through with his lance.
"
	CALL1	RT-END-OF-GAME
	RSTACK	
?CCL32:	ZERO?	GL-FORM-ABORT /FALSE
	PRINTI	"
Fortunately,"
	ICALL	RT-PRINT-OBJ,CH-BLUE-KNIGHT,K-ART-THE
	PRINTR	" didn't notice."
?CCL24:	EQUAL?	CONTEXT,M-ENTER \?CCL36
	SET	'GL-PICTURE-NUM,K-PIC-EDGE-OF-WOODS
	EQUAL?	GL-WINDOW-TYPE,K-WIN-PICT \FALSE
	ICALL1	RT-UPDATE-PICT-WINDOW
	RFALSE	
?CCL36:	EQUAL?	CONTEXT,M-ENTERED \?CCL40
	SET	'GL-HORN-CNT,0
	SET	'GL-HORSE-CNT,0
	RETURN	GL-HORSE-CNT
?CCL40:	EQUAL?	CONTEXT,M-EXIT \?CCL42
	IN?	CH-BLUE-KNIGHT,RM-EDGE-OF-WOODS \FALSE
	MOVE	TH-RED-LANCE,CH-BLUE-KNIGHT
	MOVE	TH-GREEN-LANCE,CH-BLUE-KNIGHT
	REMOVE	CH-BLUE-KNIGHT
	RFALSE	
?CCL42:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-GN-LANCE:ANY:2:2,TBL,FINDER
	GET	PARSE-RESULT,4
	EQUAL?	STACK,V?ASK-ABOUT \FALSE
	RETURN	TH-RED-LANCE


	.FUNCT	RT-TH-LANCE:ANY:0:1,CONTEXT,OTHER
	EQUAL?	PRSO,TH-RED-LANCE \?CCL3
	SET	'OTHER,TH-GREEN-LANCE
	JUMP	?CND1
?CCL3:	SET	'OTHER,TH-RED-LANCE
?CND1:	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?TAKE \?CCL8
	CALL2	RT-TAKE-LANCE,PRSO
	RSTACK	
?CCL8:	EQUAL?	PRSA,V?EXAMINE \FALSE
	FSET	PRSO,FL-SEEN
	CALL	NOUN-USED?,TH-RED-LANCE,W?LANCES
	ZERO?	STACK /?CCL13
	PRINTR	"They both look the same, except for the colour."
?CCL13:	PRINTR	"It looks just the same as the other lance."


	.FUNCT	RT-TAKE-LANCE:ANY:1:1,LANCE
	IN?	CH-PLAYER,TH-HORSE /?CCL3
	PRINTR	"The knight moves the lance beyond your reach and says, ""Haven't you read Hoyle, lad? First you mount up, then you choose your lance."""
?CCL3:	CALL2	RT-DO-TAKE,LANCE
	ZERO?	STACK /TRUE
	ICALL2	RT-JOUST,LANCE
	RTRUE	


	.FUNCT	RT-JOUST:ANY:1:1,LANCE,S,L,KS,KL
	PRINTI	"You take"
	ICALL	RT-PRINT-OBJ,LANCE,K-ART-THE
	PRINTI	". The knight keeps the "
	EQUAL?	LANCE,TH-RED-LANCE \?CCL3
	PRINTI	"green"
	JUMP	?CND1
?CCL3:	PRINTI	"red"
?CND1:	PRINTI	" one and fetches his horse from behind the pavilion. He unties your horse, which canters a little distance away and then turns to face the blue knight. After a moment's hesitation the two well-trained horses start to gallop towards one another.

"
	SET	'GL-PICTURE-NUM,K-PIC-JOUST
	EQUAL?	GL-WINDOW-TYPE,K-WIN-PICT \?CND4
	ICALL1	RT-UPDATE-PICT-WINDOW
?CND4:	RANDOM	3 >KS
	RANDOM	4 >KL
	PRINTI	"The knight"
	ICALL	RT-JOUST-STATUS-MSG,CH-BLUE-KNIGHT,CH-PLAYER,KS,KL
	CRLF	
	CRLF	
	SET	'GL-K-SH,KS
	SET	'GL-K-LN,KL
	CALL2	RT-JOUST-READ,FALSE-VALUE >S
	CALL2	RT-JOUST-READ,TRUE-VALUE >L
	ICALL	RT-PRINT-OBJ,CH-PLAYER,K-ART-THE,TRUE-VALUE
	ICALL	RT-JOUST-STATUS-MSG,CH-PLAYER,CH-BLUE-KNIGHT,S,L
	SET	'GL-SH,S
	SET	'GL-LN,L
	RANDOM	3 >KS
	RANDOM	4 >KL
	PRINTI	" The two horses thunder toward each other. You are about to clash when you see that the knight"
	ICALL	RT-JOUST-STATUS-MSG,CH-BLUE-KNIGHT,CH-PLAYER,KS,KL
	CRLF	
	CRLF	
	SET	'GL-K-SH,KS
	SET	'GL-K-LN,KL
	CALL2	RT-JOUST-READ,FALSE-VALUE >S
	CALL2	RT-JOUST-READ,TRUE-VALUE >L
	ICALL	RT-PRINT-OBJ,CH-PLAYER,K-ART-THE,TRUE-VALUE
	ICALL	RT-JOUST-STATUS-MSG,CH-PLAYER,CH-BLUE-KNIGHT,S,L
	MOVE	CH-PLAYER,HERE
	MOVE	LANCE,CH-BLUE-KNIGHT
	EQUAL?	L,4 \?CCL8
	REMOVE	CH-BLUE-KNIGHT
	PRINTI	" The knight pulls up short to prevent you from injuring his horse. He knocks you from your horse, and says, ""That's no way for a gentleman to fight."" He collects your lance, ties"
	ICALL	RT-PRINT-OBJ,TH-HORSE,K-ART-THE
	PRINTI	" to"
	ICALL	RT-PRINT-OBJ,TH-TREE,K-ART-THE
	PRINTI	" and disappears into his pavilion saying, ""Come back when you're ready to joust properly."""
	CRLF	
	BOR	GL-UPDATE-WINDOW,K-UPD-OBJS >GL-UPDATE-WINDOW
	EQUAL?	GL-WINDOW-TYPE,K-WIN-DESC \?CND6
	ICALL1	RT-UPDATE-DESC-WINDOW
	JUMP	?CND6
?CCL8:	SET	'KS,L
	SET	'KL,2
	PRINTI	" The knight"
	ICALL	RT-JOUST-STATUS-MSG,CH-BLUE-KNIGHT,CH-PLAYER,KS,KL
?CND6:	EQUAL?	S,2 \?CCL13
	EQUAL?	L,2 \?CCL13
	FSET	CH-BLUE-KNIGHT,FL-BROKEN
	REMOVE	CH-BLUE-KNIGHT
	ICALL	RT-DO-TAKE,TH-IVORY-KEY,TRUE-VALUE
	SET	'GL-QUESTION,1
	PRINTI	" The blue knight crashes to the turf. You try to stay upright on the horse, but seconds later you, too, hit the ground. ""Well struck, lad!"" the knight cries out. ""And by virtue of the fact that I was the first to be unseated, you are declared the winner."" After a few moments he staggers to his feet and disappears into the pavilion. He emerges moments later with an ivory key, which he hands to you.

""Congratulations, old chap. Spoils of war, what?""

The knight stumbles around the clearing, cleaning up after the joust. He ties the horse to the tree, collects the lances and disappears into the pavilion.
"
	BOR	GL-UPDATE-WINDOW,K-UPD-OBJS >GL-UPDATE-WINDOW
	EQUAL?	GL-WINDOW-TYPE,K-WIN-DESC \?CND16
	ICALL1	RT-UPDATE-DESC-WINDOW
?CND16:	ICALL	RT-SCORE-MSG,10,5,7,4
	JUMP	?CND11
?CCL13:	EQUAL?	L,4 /?CND11
	PRINTI	" The knight deals you a stunning blow on your "
	EQUAL?	S,2 \?CCL21
	PRINTI	"shield"
	JUMP	?CND19
?CCL21:	PRINTI	"chest"
?CND19:	PRINTI	", knocking you from the horse. He took the blow from your lance on his shield, and stayed on his horse."
	EQUAL?	L,2 /?CND22
	PRINTI	" He cuffs you on the head as he rides by and says, ""And that's for not jousting like a gentleman."""
?CND22:	PRINTI	"

Your horse stands next to you. The knight says, ""Tough luck, old bean. Care to try again?""
"
	ICALL1	UPDATE-STATUS-LINE
	CALL2	YES?,TRUE-VALUE
	ZERO?	STACK /?CCL26
	PRINTI	"""Mount up, then.""
"
	JUMP	?CND11
?CCL26:	REMOVE	CH-BLUE-KNIGHT
	PRINTI	"""Pity. I'll be running along then. Cheerio!"" The knight disappears into the pavilion.
"
	BOR	GL-UPDATE-WINDOW,K-UPD-OBJS >GL-UPDATE-WINDOW
	EQUAL?	GL-WINDOW-TYPE,K-WIN-DESC \?CND11
	ICALL1	RT-UPDATE-DESC-WINDOW
?CND11:	SET	'GL-PICTURE-NUM,K-PIC-EDGE-OF-WOODS
	EQUAL?	GL-WINDOW-TYPE,K-WIN-PICT \TRUE
	ICALL1	RT-UPDATE-PICT-WINDOW
	RTRUE	


	.FUNCT	RT-JOUST-STATUS-MSG:ANY:4:4,ATT,DEF,S,L
	ICALL	RT-PRINT-VERB,ATT,STR?334
	ICALL	RT-PRINT-OBJ,ATT,K-ART-HIS
	PRINTC	32
	ICALL2	RT-TARGET-MSG,S
	PRINTI	" and"
	ICALL	RT-PRINT-VERB,ATT,STR?335
	ICALL	RT-PRINT-OBJ,ATT,K-ART-HIS
	PRINTI	" lance at"
	ICALL	RT-PRINT-OBJ,DEF,K-ART-HIS
	PRINTC	32
	ICALL2	RT-TARGET-MSG,L
	PRINTC	46
	RTRUE	


	.FUNCT	RT-TARGET-MSG:ANY:1:1,T
	EQUAL?	T,1 \?CCL3
	PRINTI	"head"
	RTRUE	
?CCL3:	EQUAL?	T,2 \?CCL5
	PRINTI	"body"
	RTRUE	
?CCL5:	EQUAL?	T,3 \?CCL7
	PRINTI	"leg"
	RTRUE	
?CCL7:	EQUAL?	T,4 \FALSE
	PRINTI	"horse"
	RTRUE	


	.FUNCT	RT-JOUST-READ:ANY:1:1,LANCE?,VAL,WORD,I
?PRG1:	PUTB	P-INBUF,1,0
	PRINTI	"Do you want to "
	ZERO?	LANCE? /?CCL5
	SET	'VAL,4
	PRINTI	"aim your lance at his"
	JUMP	?CND3
?CCL5:	SET	'VAL,3
	PRINTI	"shield your"
?CND3:	SET	'I,1
?PRG6:	PRINTI	" ("
	PRINTN	I
	PRINTI	") "
	ICALL2	RT-TARGET-MSG,I
	IGRTR?	'I,VAL /?REP7
	PRINTC	44
	EQUAL?	I,VAL \?PRG6
	PRINTI	" or"
	JUMP	?PRG6
?REP7:	PRINTC	63
	CRLF	
	PRINTC	62
?PRG13:	READ	P-INBUF,P-LEXV >VAL
	EQUAL?	VAL,10,13 /?REP14
	ICALL2	RT-HOT-KEY,VAL
	JUMP	?PRG13
?REP14:	ICALL1	RT-SCRIPT-INBUF
	GET	P-LEXV,P-LEXSTART >WORD
	SET	'VAL,0
	EQUAL?	WORD,W?HEAD \?CCL20
	SET	'VAL,1
	JUMP	?CND18
?CCL20:	EQUAL?	WORD,W?BODY \?CCL22
	SET	'VAL,2
	JUMP	?CND18
?CCL22:	EQUAL?	WORD,W?LEG,W?LEGS \?CCL24
	SET	'VAL,3
	JUMP	?CND18
?CCL24:	ZERO?	LANCE? /?CCL26
	EQUAL?	WORD,W?HORSE \?CCL26
	SET	'VAL,4
	JUMP	?CND18
?CCL26:	EQUAL?	WORD,W?RESTART \?CCL30
	ICALL1	V-RESTART
	JUMP	?CND18
?CCL30:	EQUAL?	WORD,W?RESTORE \?CCL32
	ICALL1	V-RESTORE
	JUMP	?CND18
?CCL32:	EQUAL?	WORD,W?QUIT,W?Q \?CCL34
	ICALL1	V-QUIT
	JUMP	?CND18
?CCL34:	ADD	P-LEXV,2
	CALL2	NUMBER?,STACK
	ZERO?	STACK /?CND18
	EQUAL?	P-NUMBER,1,2,3 /?CCL37
	ZERO?	LANCE? /?CND18
	EQUAL?	P-NUMBER,4 \?CND18
?CCL37:	SET	'VAL,P-NUMBER
?CND18:	ZERO?	VAL /?PRG1
	RETURN	VAL


	.FUNCT	RT-TH-TREE:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?EXAMINE \FALSE
	FSET	TH-TREE,FL-SEEN
	FSET	TH-HORN,FL-SEEN
	PRINTR	"It's a large shade tree that has a horse tied to its trunk and a horn hanging from one of its lower branches."


	.FUNCT	RT-TH-HORN:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?BLOW \?CCL5
	ICALL2	THIS-IS-IT,TH-HORN
	ZERO?	GL-PLAYER-FORM \?CCL8
	FSET	TH-HORN,FL-LOCKED
	INC	'GL-HORN-CNT
	EQUAL?	GL-HORN-CNT,1 \?CCL11
	IN?	CH-BLUE-KNIGHT,HERE \?CCL14
	PRINTI	"The knight"
	JUMP	?CND12
?CCL14:	PRINTI	"The door to the pavilion opens and a knight with a bushy white mustache and splendid side-whiskers pokes his head out and"
?CND12:	PRINTI	" splutters, ""I say, I say. I mean, after all... What the deuce has happened to manners? Doesn't anyone knock anymore? It's not my fault that some damned fool hung that horn there. Why don't you knock on the door like a proper person?"""
	JUMP	?CND9
?CCL11:	EQUAL?	GL-HORN-CNT,2 \?CCL16
	IN?	CH-BLUE-KNIGHT,HERE \?CCL19
	PRINTI	"The"
	JUMP	?CND17
?CCL19:	PRINTI	"The door swings open again and the"
?CND17:	PRINTI	" knight says, ""I really must insist that you cease blowing that infernal horn. Otherwise I shall smite you."""
	JUMP	?CND9
?CCL16:	PRINTI	"The knight"
	IN?	CH-BLUE-KNIGHT,HERE /?CND20
	PRINTI	" emerges from the pavilion and"
?CND20:	PRINTI	" says, ""I'm sorry to have to do this, old chap. But you leave me no choice."" He deals you a mighty blow that puts a dent in his mailed fist and has the unfortunate side-effect of killing you.
"
	ICALL1	RT-END-OF-GAME
?CND9:	IN?	CH-BLUE-KNIGHT,HERE /?CND22
	PRINT	K-RETREATS-INSIDE-MSG
?CND22:	CRLF	
	RTRUE	
?CCL8:	PRINTI	"You can't reach the horn. You're"
	ICALL2	RT-FORM-MSG,K-ART-A
	PRINTR	"."
?CCL5:	EQUAL?	PRSA,V?MOVE,V?TAKE \?CCL25
	ICALL2	THIS-IS-IT,TH-HORN
	PRINTR	"You can't. The horn is chained to the tree."
?CCL25:	EQUAL?	PRSA,V?EXAMINE \FALSE
	FSET	TH-HORN,FL-SEEN
	ICALL2	THIS-IS-IT,TH-HORN
	CALL	NOUN-USED?,TH-HORN,W?HORN
	ZERO?	STACK /?CCL30
	PRINTR	"It is the kind of curved horn used in hunting."
?CCL30:	FSET	TH-TREE,FL-SEEN
	PRINTR	"The chains firmly attach the horn to the tree."


	.FUNCT	RT-TH-HORSE:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-WINNER \?CCL3
	PRINTR	"The horse doesn't seem to understand you."
?CCL3:	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?CLIMB-ON \?CCL7
	ZERO?	GL-PLAYER-FORM \?CCL10
	IN?	CH-PLAYER,TH-HORSE \?CCL13
	PRINTR	"You are already on the horse."
?CCL13:	MOVE	WINNER,TH-HORSE
	ICALL	RT-PRINT-OBJ,WINNER,K-ART-THE,TRUE-VALUE,STR?69
	PRINTI	" now on the horse."
	IN?	CH-BLUE-KNIGHT,RM-EDGE-OF-WOODS \?CCL16
	ICALL	SETUP-ORPHAN-NP,STR?72,TH-RED-LANCE,TH-GREEN-LANCE
	PRINTI	" ""Jolly good,"" says the knight. """
	PRINT	K-WHICH-LANCE-MSG
	JUMP	?CND14
?CCL16:	CRLF	
?CND14:	BOR	GL-UPDATE-WINDOW,K-UPD-DESC >GL-UPDATE-WINDOW
	EQUAL?	GL-WINDOW-TYPE,K-WIN-DESC \TRUE
	ICALL1	RT-UPDATE-DESC-WINDOW
	RTRUE	
?CCL10:	PRINTR	"The horse shies away from you."
?CCL7:	EQUAL?	PRSA,V?DISMOUNT \?CCL20
	IN?	CH-PLAYER,TH-HORSE \?CCL20
	MOVE	WINNER,HERE
	ICALL	RT-PRINT-OBJ,WINNER,K-ART-THE,TRUE-VALUE,STR?69
	PRINTI	" back on"
	ICALL	RT-PRINT-OBJ,TH-GROUND,K-ART-THE
	PRINTR	"."
?CCL20:	EQUAL?	PRSA,V?TAKE,V?RELEASE,V?UNTIE \?CCL24
	ZERO?	GL-PLAYER-FORM /?CCL27
	CALL	RT-ANIMAL-CANT-MSG,STR?337,TH-HORSE
	RSTACK	
?CCL27:	IN?	WINNER,TH-HORSE \?CCL29
	ICALL	RT-PRINT-OBJ,WINNER,K-ART-THE,TRUE-VALUE
	PRINTR	" can't do that while you are on the horse."
?CCL29:	INC	'GL-HORSE-CNT
	EQUAL?	GL-HORSE-CNT,1 \?CCL32
	PRINTI	"As you start to untie the horse, "
	IN?	CH-BLUE-KNIGHT,RM-EDGE-OF-WOODS \?CCL35
	PRINTI	"the knight"
	JUMP	?CND33
?CCL35:	PRINTI	"a knight pokes his head out of the door of the pavilion and"
?CND33:	PRINTI	" says, ""I'm awfully sorry, old chap. But if you steal that horse I shall be forced to kill you."""
	IN?	CH-BLUE-KNIGHT,RM-EDGE-OF-WOODS /?CND36
	PRINT	K-RETREATS-INSIDE-MSG
?CND36:	CRLF	
	RTRUE	
?CCL32:	EQUAL?	GL-HORSE-CNT,2 \?CCL39
	PRINTI	"The knight "
	IN?	CH-BLUE-KNIGHT,RM-EDGE-OF-WOODS /?CND40
	PRINTI	"pokes his head out of the door of the pavilion and "
?CND40:	PRINTR	"says, ""I'm not joking, you know. If you persist in trying to steal that horse, I shall smite you."""
?CCL39:	EQUAL?	GL-HORSE-CNT,3 \FALSE
	PRINTI	"The knight "
	IN?	CH-BLUE-KNIGHT,RM-EDGE-OF-WOODS /?CND44
	PRINTI	"comes out of the pavilion and "
?CND44:	PRINTI	"smites you. You are now smitten. You are also dead.
"
	CALL1	RT-END-OF-GAME
	RSTACK	
?CCL24:	EQUAL?	PRSA,V?EXAMINE \FALSE
	FSET	TH-HORSE,FL-SEEN
	PRINTR	"It is a sturdy creature, obviously bred for jousting."


	.FUNCT	RT-HORSE-TIED:ANY:0:1,QUIET
	ZERO?	QUIET \FALSE
	IN?	CH-BLUE-KNIGHT,RM-EDGE-OF-WOODS \?CCL5
	PRINTI	"The knight prevents you from leaving with his horse.
"
	RFALSE	
?CCL5:	PRINTI	"The horse is tied to the tree.
"
	RFALSE	


	.FUNCT	RT-CH-BLUE-KNIGHT:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,FALSE-VALUE,M-WINNER \?CCL3
	EQUAL?	PRSA,V?GOODBYE,V?HELLO \?CCL3
	EQUAL?	PRSA,V?HELLO \?CCL8
	PRINTR	"""Greetings, lad."""
?CCL8:	EQUAL?	PRSA,V?GOODBYE \FALSE
	PRINTR	"""Leaving so soon? Perhaps it's just as well. Come back when you've learned to joust like a gentleman."""
?CCL3:	EQUAL?	CONTEXT,M-WINNER \?CCL12
	EQUAL?	PRSA,V?TELL-ABOUT \?CCL15
	EQUAL?	PRSO,CH-PLAYER /FALSE
?CCL15:	EQUAL?	PRSA,V?JOUST \?CCL19
	PRINTI	"""I'd love to. "
	IN?	CH-PLAYER,TH-HORSE /?CCL22
	PRINTI	"Mount up"
	JUMP	?CND20
?CCL22:	PRINTI	"Take a lance"
?CND20:	PRINTR	", lad."""
?CCL19:	EQUAL?	PRSA,V?GIVE \?CCL24
	EQUAL?	PRSI,CH-PLAYER \?CCL24
	EQUAL?	PRSO,TH-RED-LANCE,TH-GREEN-LANCE \FALSE
	CALL2	RT-TAKE-LANCE,PRSO
	RSTACK	
?CCL24:	PRINTR	"The knight looks at you and says, ""Not now, old chap. Let's joust."""
?CCL12:	ZERO?	CONTEXT \FALSE
	ZERO?	NOW-PRSI \FALSE
	EQUAL?	PRSA,V?TELL \?CCL35
	ZERO?	P-CONT \FALSE
?CCL35:	EQUAL?	PRSA,V?ASK-ABOUT \?CCL39
	EQUAL?	PRSI,TH-RED-LANCE,TH-GREEN-LANCE \?CCL42
	PRINTR	"""They're both the same, old bean. Knight's honour and all that."""
?CCL42:	EQUAL?	PRSI,CH-BLUE-KNIGHT \?CCL44
	PRINTR	"""Oh, I'm just an old campaigner who enjoys a sportsmanlike joust every now and again."""
?CCL44:	EQUAL?	PRSI,TH-HORSE \?CCL46
	PRINTR	"""He's one of the best-trained jousting horses in the county."""
?CCL46:	EQUAL?	PRSI,CH-MERLIN \?CCL48
	PRINTR	"""I've never heard of him. What team does he joust for?"""
?CCL48:	EQUAL?	PRSI,CH-LOT \?CCL50
	PRINTR	"The knight snorts in derision. ""Nasty piece of business, there. I'd steer clear of him if I were you, lad."""
?CCL50:	EQUAL?	PRSI,TH-HORN \?CCL52
	PRINTR	"""Some blasted fool hung it up there while I was away on holiday and I haven't been able to get it down since."""
?CCL52:	EQUAL?	PRSI,TH-JOUST \?CCL54
	PRINTR	"""Jolly good question. King of sports, don't you know? Flower of chivalry and all that, what?"""
?CCL54:	PRINTR	"""Afraid I don't know too much about that, old fellow. Sorry."""
?CCL39:	EQUAL?	PRSA,V?ATTACK \?CCL56
	MOVE	TH-RED-LANCE,CH-BLUE-KNIGHT
	MOVE	TH-GREEN-LANCE,CH-BLUE-KNIGHT
	REMOVE	CH-BLUE-KNIGHT
	PRINTI	"The knight easily avoids your awkward attempt to "
	PRINTB	P-PRSA-WORD
	PRINTI	" him and cuffs you on the head. ""That's no way for a gentleman to fight,"" he says, disappearing into his pavilion. ""Come back when you're ready to joust."""
	CRLF	
	BOR	GL-UPDATE-WINDOW,K-UPD-OBJS >GL-UPDATE-WINDOW
	EQUAL?	GL-WINDOW-TYPE,K-WIN-DESC \TRUE
	ICALL1	RT-UPDATE-DESC-WINDOW
	RTRUE	
?CCL56:	EQUAL?	PRSA,V?EXAMINE \?CCL60
	FSET	CH-BLUE-KNIGHT,FL-SEEN
	PRINTR	"The knight is an elderly gentleman with a bushy white mustache and splendid side-whiskers."
?CCL60:	EQUAL?	PRSA,V?ASK-FOR \FALSE
	EQUAL?	PRSI,TH-RED-LANCE,TH-GREEN-LANCE \FALSE
	CALL2	RT-TAKE-LANCE,PRSI
	RSTACK	


	.FUNCT	RT-TH-BLUE-PAVILION:ANY:0:1,CONTEXT,J
	ZERO?	CONTEXT \FALSE
	CALL1	TOUCH-VERB?
	ZERO?	STACK /?CCL5
	IN?	CH-PLAYER,TH-HORSE \?CCL5
	ICALL	RT-PRINT-OBJ,WINNER,K-ART-THE,TRUE-VALUE
	PRINTI	" can't reach"
	CALL	NOUN-USED?,TH-BLUE-PAVILION,W?DOOR
	ZERO?	STACK /?CCL10
	PRINTI	" the door"
	JUMP	?CND8
?CCL10:	ICALL	RT-PRINT-OBJ,TH-BLUE-PAVILION,K-ART-THE
?CND8:	PRINTR	" while you're on the horse."
?CCL5:	CALL	NOUN-USED?,TH-BLUE-PAVILION,W?DOOR
	ZERO?	STACK /?CCL12
	EQUAL?	PRSA,V?SCRATCH,V?KNOCK \?CCL15
	IN?	CH-BLUE-KNIGHT,HERE \?CCL18
	PRINTR	"The knight says, ""Have ye gone daft, lad? I'm already here."""
?CCL18:	PRINTI	"The door to the pavilion opens and the knight emerges. "
	ZERO?	GL-PLAYER-FORM /?CCL21
	PRINTR	"He looks around, says ""Damn teenagers,"" and retreats inside."
?CCL21:	FSET?	CH-BLUE-KNIGHT,FL-BROKEN \?CCL23
	PRINTI	"""You again? You've beaten me once already. Go away."""
	PRINT	K-RETREATS-INSIDE-MSG
	CRLF	
	RTRUE	
?CCL23:	FSET?	CH-BLUE-KNIGHT,FL-LOCKED /?CND24
	FSET	CH-BLUE-KNIGHT,FL-LOCKED
	FSET?	TH-HORN,FL-LOCKED \?CCL28
	PRINTI	"""That's better,"" he fusses. ""Don't know what the world's coming to. "
	JUMP	?CND24
?CCL28:	PRINTI	"""I say, frightfully kind of you to knock. Most people just start to blow away on that beastly horn. "
?CND24:	PRINTI	"I suppose you're here to joust?"" He looks you up and down. "
	IN?	TH-ARMOUR,CH-PLAYER /?CCL31
	PRINTI	"""I see you have no armour. A man without armour is no nobleman, therefore I cannot joust with you."""
	PRINT	K-RETREATS-INSIDE-MSG
	CRLF	
	RTRUE	
?CCL31:	IN?	TH-SHIELD,CH-PLAYER /?CCL33
	PRINTI	"""I see you have no shield. I can't joust with a man who has no shield. It wouldn't be cricket - although I don't suppose that's been invented yet. Still, if it had, it wouldn't be, if you see what I mean. Sorry."""
	PRINT	K-RETREATS-INSIDE-MSG
	CRLF	
	RTRUE	
?CCL33:	FSET?	TH-SHIELD,FL-BROKEN \?CCL35
	PRINTI	"""I see your shield is tarnished. Can't joust with a man with a tarnished shield. It's just not done. Knight in shining armour and all that, don't you know. Sorry."""
	PRINT	K-RETREATS-INSIDE-MSG
	CRLF	
	RTRUE	
?CCL35:	MOVE	CH-BLUE-KNIGHT,RM-EDGE-OF-WOODS
	FSET	TH-RED-LANCE,FL-SEEN
	FSET	TH-GREEN-LANCE,FL-SEEN
	PRINTI	"""Splendid. I see you are a gentleman and prefer to joust without a helmet. Let's have at it then.""

The knight disappears into the pavilion for a moment and then emerges carrying two lances that are identical save that one is red and one is green. ""Mount up, lad,"" says the knight, ""And I shall give you your choice of lances.""
"
	BOR	GL-UPDATE-WINDOW,K-UPD-OBJS >GL-UPDATE-WINDOW
	EQUAL?	GL-WINDOW-TYPE,K-WIN-DESC \TRUE
	ICALL1	RT-UPDATE-DESC-WINDOW
	RTRUE	
?CCL15:	EQUAL?	PRSA,V?UNLOCK,V?OPEN \FALSE
	PRINTR	"The door is locked from the inside."
?CCL12:	EQUAL?	PRSA,V?ENTER \FALSE
	PRINTR	"The door is closed."


	.FUNCT	RT-ENTER-BLUE-PAVILION:ANY:0:1,QUIET
	ZERO?	QUIET \FALSE
	PRINTI	"The door is closed."
	CRLF	
	RFALSE	


	.FUNCT	RT-TH-SHIELD:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	ZERO?	NOW-PRSI \FALSE
	EQUAL?	PRSA,V?LOOK-IN,V?EXAMINE \?CCL7
	FSET	TH-SHIELD,FL-SEEN
	FSET?	TH-SHIELD,FL-BROKEN \?CCL10
	ICALL	RT-PRINT-OBJ,TH-SHIELD,K-ART-THE,TRUE-VALUE
	PRINTR	" looks old and tarnished, but serviceable."
?CCL10:	FSET	TH-SHIELD,FL-SEEN
	ICALL	RT-PRINT-OBJ,WINNER,K-ART-THE,TRUE-VALUE,STR?145
	PRINTI	" an amazingly clear reflection of yourself in"
	ICALL	RT-PRINT-OBJ,TH-SHIELD,K-ART-THE
	PRINTC	46
	CRLF	
	CALL2	RT-AUTHOR-MSG,STR?339
	RSTACK	
?CCL7:	EQUAL?	PRSA,V?POLISH \?CCL12
	FSET?	TH-SHIELD,FL-BROKEN \FALSE
	ZERO?	GL-PLAYER-FORM /?CCL18
	CALL1	RT-ANIMAL-CANT-MSG
	RSTACK	
?CCL18:	EQUAL?	PRSI,TH-PUMICE \?CCL20
	FCLEAR	TH-SHIELD,FL-BROKEN
	PRINTI	"A few minutes work puts a mirror-like shine on"
	ICALL	RT-PRINT-OBJ,TH-SHIELD,K-ART-THE
	PRINTC	46
	CRLF	
	CALL	RT-SCORE-MSG,0,2,0,0
	RSTACK	
?CCL20:	ICALL	RT-PRINT-OBJ,WINNER,K-ART-THE,TRUE-VALUE
	PRINTI	" can't shine"
	ICALL	RT-PRINT-OBJ,TH-SHIELD,K-ART-THE
	PRINTI	" with"
	ICALL	RT-PRINT-OBJ,PRSI,K-ART-THE
	PRINTR	"."
?CCL12:	EQUAL?	PRSA,V?POINT \?CCL22
	EQUAL?	PRSI,CH-BASILISK \?CCL25
	FSET?	CH-BASILISK,FL-ALIVE \?CCL25
	FSET?	TH-SHIELD,FL-BROKEN /?CCL25
	CALL1	RT-KILL-BASILISK
	RSTACK	
?CCL25:	FSET?	TH-SHIELD,FL-BROKEN /?CTR29
	FSET?	PRSI,FL-ALIVE \?CTR29
	FSET?	PRSI,FL-ASLEEP \?CCL30
?CTR29:	PRINTI	"You point"
	ICALL	RT-PRINT-OBJ,TH-SHIELD,K-ART-THE
	PRINTI	" at"
	ICALL	RT-PRINT-OBJ,PRSI,K-ART-THE
	PRINTR	", but nothing happens."
?CCL30:	ICALL	RT-PRINT-OBJ,PRSI,K-ART-THE,TRUE-VALUE,STR?340
	PRINTI	" at"
	ICALL	RT-PRINT-OBJ,PRSI,K-ART-HIS
	PRINTI	" reflection, but then"
	ICALL	RT-PRINT-VERB,PRSI,STR?154
	PRINTR	" it."
?CCL22:	EQUAL?	PRSA,V?RAISE,V?HIDE-BEHIND \?CCL35
	EQUAL?	HERE,RM-BAS-LAIR \?CCL35
	FSET?	CH-BASILISK,FL-ALIVE \?CCL35
	FSET?	TH-SHIELD,FL-BROKEN /?CCL35
	CALL1	RT-KILL-BASILISK
	RSTACK	
?CCL35:	EQUAL?	PRSA,V?SHOW \?CCL41
	EQUAL?	PRSI,CH-BASILISK \?CCL41
	FSET?	CH-BASILISK,FL-ALIVE \?CCL41
	FSET?	TH-SHIELD,FL-BROKEN /?CCL41
	CALL1	RT-KILL-BASILISK
	RSTACK	
?CCL41:	EQUAL?	PRSA,V?HIDE-BEHIND \FALSE
	ICALL	RT-PRINT-OBJ,TH-SHIELD,K-ART-THE,TRUE-VALUE
	PRINTR	" is too small to hide behind."


	.FUNCT	RT-TH-ARMOUR:ANY:0:1,CONTEXT,CR?
	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?WEAR \?CCL5
	FSET?	TH-ARMOUR,FL-WORN \?CCL8
	CALL	RT-ALREADY-MSG,WINNER,STR?341
	RSTACK	
?CCL8:	ZERO?	GL-PLAYER-FORM /?CCL10
	CALL1	RT-ANIMAL-CANT-MSG
	RSTACK	
?CCL10:	IN?	TH-ARMOUR,WINNER \?CCL13
	ICALL	RT-PRINT-OBJ,WINNER,K-ART-THE,TRUE-VALUE,STR?264
	PRINTI	" the chain mail on over"
	ICALL	RT-PRINT-OBJ,TH-TUNIC,K-ART-THE
	PRINTC	46
	JUMP	?CND11
?CCL13:	ICALL	RT-DO-TAKE,TH-ARMOUR,TRUE-VALUE
	SET	'CR?,TRUE-VALUE
	ICALL	RT-PRINT-OBJ,WINNER,K-ART-THE,TRUE-VALUE,STR?342
	PRINTI	" into the chain mail."
	CRLF	
	ICALL2	RT-SCORE-OBJ,TH-ARMOUR
?CND11:	FSET	TH-ARMOUR,FL-WORN
	ZERO?	CR? \?CND14
	CRLF	
?CND14:	BOR	GL-UPDATE-WINDOW,K-UPD-INVT >GL-UPDATE-WINDOW
	RTRUE	
?CCL5:	EQUAL?	PRSA,V?UNWEAR \?CCL17
	FSET?	TH-ARMOUR,FL-WORN \?CTR19
	IN?	TH-ARMOUR,WINNER /?CCL20
?CTR19:	DIROUT	D-TABLE-ON,K-DIROUT-TBL
	ICALL	RT-PRINT-OBJ,WINNER,K-ART-THE,TRUE-VALUE,STR?69
	PRINTI	"n't wearing"
	ICALL	RT-PRINT-OBJ,TH-ARMOUR,K-ART-THE
	PRINTC	46
	CALL1	RT-AUTHOR-OFF
	RSTACK	
?CCL20:	IN?	CH-KRAKEN,HERE \?CCL24
	FSET?	CH-KRAKEN,FL-LOCKED \?CCL24
	ICALL	RT-PRINT-OBJ,WINNER,K-ART-THE,TRUE-VALUE
	PRINTI	" can't remove"
	ICALL	RT-PRINT-OBJ,TH-ARMOUR,K-ART-THE
	PRINTI	" while that kraken is holding on to"
	ICALL	RT-PRINT-OBJ,WINNER,K-ART-HIM
	PRINTR	"."
?CCL24:	MOVE	TH-ARMOUR,HERE
	FCLEAR	TH-ARMOUR,FL-WORN
	BOR	GL-UPDATE-WINDOW,K-UPD-INVT >GL-UPDATE-WINDOW
	ICALL	RT-PRINT-OBJ,WINNER,K-ART-THE,TRUE-VALUE,STR?342
	PRINTI	" out of the chain mail, and it falls to"
	ICALL	RT-PRINT-OBJ,TH-GROUND,K-ART-THE
	PRINTC	46
	CRLF	
	EQUAL?	HERE,RM-BOG \TRUE
	CRLF	
	ICALL2	RT-DROP-IN-BOG,TH-ARMOUR
	RTRUE	
?CCL17:	EQUAL?	PRSA,V?EXAMINE \FALSE
	FSET	TH-ARMOUR,FL-SEEN
	ICALL	RT-PRINT-OBJ,TH-ARMOUR,K-ART-THE,TRUE-VALUE
	PRINTR	" is a brightly polished coat of chain mail."


	.FUNCT	RT-GN-ARMOUR:ANY:2:2,TBL,FINDER
	RETURN	TH-ARMOUR


	.FUNCT	RT-RM-ABOVE-EDGE-OF-WOODS:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	FSET	LG-FOREST,FL-SEEN
	FSET	RM-MEADOW,FL-SEEN
	FSET	RM-MOOR,FL-SEEN
	PRINTI	"You are hovering over the edge of the woods. The depths of the forest lie to the north, while to the south you can see the openness of the meadow. Merlin's hollow hill lies to the west, and to the east you see the desolate moor.
"
	RFALSE	
?CCL3:	EQUAL?	CONTEXT,M-ENTER \?CCL5
	SET	'GL-PICTURE-NUM,K-PIC-AIR-SCENE
	EQUAL?	GL-WINDOW-TYPE,K-WIN-PICT \FALSE
	ICALL1	RT-UPDATE-PICT-WINDOW
	RFALSE	
?CCL5:	ZERO?	CONTEXT \FALSE
	RFALSE	

	.ENDI
