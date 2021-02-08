

	.FUNCT	RT-RM-SHALLOWS:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	FSET?	RM-MID-LAKE,FL-WATER /?CCL6
	EQUAL?	CONTEXT,M-LOOK \?CCL9
	PRINTI	"You are"
	ICALL1	RT-STANDING-MSG
	PRINTI	" on"
	JUMP	?CND7
?CCL9:	PRINTI	"You"
	ICALL1	RT-WALK-MSG
	PRINTI	" to"
?CND7:	PRINTI	" the edge of a dry lake bed.
"
	RFALSE	
?CCL6:	EQUAL?	CONTEXT,M-LOOK \?CCL12
	PRINTI	"You are"
	ICALL1	RT-STANDING-MSG
	PRINTI	" in"
	JUMP	?CND10
?CCL12:	EQUAL?	OHERE,RM-FIELD-OF-HONOUR \?CCL15
	PRINTI	"You wade into"
	JUMP	?CND10
?CCL15:	PRINTI	"You swim to"
?CND10:	PRINTI	" the shallow water near the shore of the lake. "
	EQUAL?	GL-PLAYER-FORM,K-FORM-EEL,K-FORM-TURTLE \?CCL18
	PRINTI	"Light filters down from the surface above, and the"
	JUMP	?CND16
?CCL18:	PRINTI	"The"
?CND16:	PRINTI	" bottom drops away sharply to the south.
"
	RFALSE	
?CCL3:	EQUAL?	CONTEXT,M-BEG \?CCL20
	EQUAL?	PRSA,V?WALK \FALSE
	IN?	CH-KRAKEN,RM-SHALLOWS \FALSE
	FSET?	CH-KRAKEN,FL-LOCKED \FALSE
	PRINT	K-KRAKEN-HOLD-MSG
	RTRUE	
?CCL20:	EQUAL?	CONTEXT,M-ENTER \?CCL28
	EQUAL?	GL-PLAYER-FORM,K-FORM-EEL \?CCL31
	SET	'GL-PICTURE-NUM,K-PIC-UNDERWATER
	JUMP	?CND29
?CCL31:	SET	'GL-PICTURE-NUM,K-PIC-SHALLOWS
?CND29:	EQUAL?	GL-WINDOW-TYPE,K-WIN-PICT \FALSE
	ICALL1	RT-UPDATE-PICT-WINDOW
	RFALSE	
?CCL28:	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?THROW-OVER,V?THROW /?CCL37
	EQUAL?	PRSA,V?PUT-IN,V?PUT \FALSE
	EQUAL?	P-PRSA-WORD,W?THROW,W?TOSS,W?HURL /?CCL37
	EQUAL?	P-PRSA-WORD,W?CHUCK,W?FLING,W?PITCH /?CCL37
	EQUAL?	P-PRSA-WORD,W?HEAVE \FALSE
?CCL37:	EQUAL?	HERE,RM-SHALLOWS \?CCL47
	ICALL	PERFORM,V?DROP,PRSO
	RTRUE	
?CCL47:	EQUAL?	HERE,RM-FIELD-OF-HONOUR \?CCL49
	CALL1	IDROP
	ZERO?	STACK /TRUE
	CALL	RT-THROW-INTO-ROOM-MSG,PRSO,RM-SHALLOWS
	RSTACK	
?CCL49:	CALL2	NOT-HERE,PRSI
	RSTACK	


	.FUNCT	RT-EXIT-SHALLOW-1:ANY:0:1,QUIET
	EQUAL?	GL-PLAYER-FORM,K-FORM-EEL /?CTR2
	RETURN	RM-FIELD-OF-HONOUR
?CTR2:	ZERO?	QUIET \FALSE
	PRINTI	"You can't swim any further towards shore.
"
	RFALSE	


	.FUNCT	RT-EXIT-SHALLOW-2:ANY:0:1,QUIET
	EQUAL?	GL-PLAYER-FORM,K-FORM-EEL,K-FORM-TURTLE /?CTR2
	FSET?	RM-MID-LAKE,FL-WATER /?CCL3
?CTR2:	RETURN	RM-MID-LAKE
?CCL3:	ZERO?	QUIET \FALSE
	PRINT	K-WOULD-DROWN-MSG
	RFALSE	


	.FUNCT	RT-THROW-INTO-ROOM-MSG:ANY:2:2,OBJ,RM
	MOVE	OBJ,RM
	ICALL	RT-PRINT-OBJ,WINNER,K-ART-THE,TRUE-VALUE,STR?85
	ICALL	RT-PRINT-OBJ,OBJ,K-ART-THE
	PRINTI	" into"
	ICALL	RT-PRINT-OBJ,RM,K-ART-THE
	PRINTR	"."


	.FUNCT	RT-RM-MID-LAKE:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	FSET?	RM-MID-LAKE,FL-WATER /?CCL6
	EQUAL?	CONTEXT,M-LOOK \?CCL9
	PRINTI	"You are"
	ICALL1	RT-STANDING-MSG
	PRINTI	" in the middle of a dry lake bed."
	CRLF	
	RFALSE	
?CCL9:	ICALL2	THIS-IS-IT,TH-EXCALIBUR
	ICALL2	THIS-IS-IT,CH-LOT
	ICALL2	THIS-IS-IT,CH-COURTIERS
	PRINTI	"The cheering mob parts on either side of you to allow you to walk to the water's edge. Slowly, you venture out between the two walls of water that are being held back by some magical, unseen force. After a few moments, you reach the center of the lake. Here, the sunken boat rests on dry ground and a shaft of light illuminates the sword in the stone.

Lot and the crowd follow you."
	CRLF	
	RFALSE	
?CCL6:	EQUAL?	CONTEXT,M-LOOK \?CCL12
	PRINTI	"You are"
	ICALL2	RT-WALK-MSG,TRUE-VALUE
	PRINTI	" in"
	JUMP	?CND10
?CCL12:	PRINTI	"You"
	ICALL1	RT-WALK-MSG
	PRINTI	" to"
?CND10:	PRINTI	" the middle of the lake. To the east, steep rocks that form the island rise out of the water. To the southwest "
	IN?	CH-KRAKEN,RM-BOAT-ROOM \?CCL15
	PRINTI	"the water is murky with some kind of inky fluid"
	JUMP	?CND13
?CCL15:	PRINTI	"you see the dim outline of a sunken rowboat resting on the lake's bottom"
?CND13:	PRINTI	". You feel a current flowing into the lake from the southeast.
"
	RFALSE	
?CCL3:	EQUAL?	CONTEXT,M-ENTER \?CCL17
	FSET?	RM-MID-LAKE,FL-WATER \?CCL20
	SET	'GL-PICTURE-NUM,K-PIC-UNDERWATER
	JUMP	?CND18
?CCL20:	SET	'GL-PICTURE-NUM,K-PIC-BOAT-DRY
	MOVE	CH-LOT,RM-MID-LAKE
	MOVE	CH-COURTIERS,RM-MID-LAKE
?CND18:	EQUAL?	GL-WINDOW-TYPE,K-WIN-PICT \FALSE
	ICALL1	RT-UPDATE-PICT-WINDOW
	RFALSE	
?CCL17:	EQUAL?	CONTEXT,M-EXIT \?CCL24
	FSET?	RM-MID-LAKE,FL-WATER /FALSE
	PRINTR	"The mob blocks your path."
?CCL24:	EQUAL?	CONTEXT,M-END \?CCL29
	EQUAL?	PRSA,V?TRANSFORM \FALSE
	FSET?	RM-MID-LAKE,FL-WATER /FALSE
	EQUAL?	GL-PLAYER-FORM,GL-OLD-FORM /FALSE
	PRINTI	"
The mob recoils in horror for a moment, and then they close in and kill you.
"
	CALL1	RT-END-OF-GAME
	RSTACK	
?CCL29:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-RM-BOAT-ROOM:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	IN?	CH-KRAKEN,RM-BOAT-ROOM \?CCL9
	FSET	CH-KRAKEN,FL-SEEN
	ICALL2	THIS-IS-IT,CH-KRAKEN
	ICALL2	THIS-IS-IT,TH-BRACELET
	PRINTI	"You are swimming in murky waters, just to the southwest of the middle of the lake. A giant kraken is floating nearby. His tentacles are long, thick, and slimy, and one of them is adorned with a golden bracelet."
	JUMP	?CND4
?CCL9:	PRINTI	"You are swimming in the waters just to the southwest of the middle of the lake. There is rowboat here that has a large hole in its side, as if it had been deliberately sunk."
	JUMP	?CND4
?CCL6:	IN?	CH-KRAKEN,RM-BOAT-ROOM \?CCL12
	FSET?	CH-KRAKEN,FL-SEEN /?CCL15
	FSET	CH-KRAKEN,FL-SEEN
	ICALL2	THIS-IS-IT,CH-KRAKEN
	PRINTI	"Cautiously, you swim into the murky waters. Suddenly a giant kraken emerges from the depths and floats menacingly in front of you."
	JUMP	?CND4
?CCL15:	ICALL2	THIS-IS-IT,CH-KRAKEN
	PRINTI	"You slowly make your way back into the inky fluid, until you are once again face to face with the giant kraken."
	JUMP	?CND4
?CCL12:	PRINTI	"You swim towards the rowboat. As you get closer, you can see that it has a large hole in its side."
?CND4:	IN?	CH-KRAKEN,RM-BOAT-ROOM \?CND16
	PRINTI	" Below the kraken you can see the dim outline of a sunken rowboat resting on the lake-bed."
?CND16:	PRINTI	" The middle of the lake lies behind you to the northeast.
"
	RFALSE	
?CCL3:	EQUAL?	CONTEXT,M-ENTER \?CCL19
	IN?	CH-KRAKEN,RM-BOAT-ROOM \?CCL22
	SET	'GL-PICTURE-NUM,K-PIC-KRAKEN
	JUMP	?CND20
?CCL22:	SET	'GL-PICTURE-NUM,K-PIC-BOAT
?CND20:	EQUAL?	GL-WINDOW-TYPE,K-WIN-PICT \FALSE
	ICALL1	RT-UPDATE-PICT-WINDOW
	RFALSE	
?CCL19:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-CH-KRAKEN:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-WINNER,FALSE-VALUE \?CCL3
	EQUAL?	PRSA,V?THANK,V?GOODBYE,V?HELLO \?CCL3
	EQUAL?	PRSA,V?HELLO \?CCL8
	PRINTR	"""Forsooth, I shall greet thee not, for I liketh not your face."""
?CCL8:	EQUAL?	PRSA,V?GOODBYE \?CCL10
	PRINTR	"""Adieu. If I seeth thee not ever anon, 'twill be over soonly."""
?CCL10:	EQUAL?	PRSA,V?THANK \FALSE
	PRINTI	"""Thou may keepest thy thanks. A use for them have I not."""
	CRLF	
	FSET?	CH-PLAYER,FL-AIR /TRUE
	FSET	CH-PLAYER,FL-AIR
	ICALL	RT-SCORE-MSG,10,0,0,0
	RTRUE	
?CCL3:	EQUAL?	CONTEXT,M-WINNER \?CCL16
	EQUAL?	PRSA,V?TELL-ABOUT \?CCL19
	EQUAL?	PRSO,CH-PLAYER /FALSE
?CCL19:	PRINTR	"""Knave! That will I not do."""
?CCL16:	ZERO?	CONTEXT \FALSE
	ZERO?	NOW-PRSI \FALSE
	EQUAL?	PRSA,V?TELL \?CCL27
	ZERO?	P-CONT \FALSE
?CCL27:	EQUAL?	PRSA,V?TALK-TO \?CCL31
	PRINTR	"""If thou wouldst have speak with me, spitteth it out!"""
?CCL31:	EQUAL?	PRSA,V?ASK-ABOUT \?CCL33
	EQUAL?	PRSI,CH-KRAKEN \?CCL36
	PRINTR	"""I floateth like a butterfly and stingeth like a bee."""
?CCL36:	EQUAL?	PRSI,TH-BRACELET \?CCL38
	PRINTR	"""'Tis a precious ringlet, one from which I fain would not part."""
?CCL38:	EQUAL?	PRSI,CH-PLAYER \?CCL40
	PRINTR	"""I liketh not thy face."""
?CCL40:	PRINTR	"""I knoweth not. Catchest thou my drift?"""
?CCL33:	EQUAL?	PRSA,V?ASK-FOR \?CCL42
	EQUAL?	PRSI,TH-BRACELET \FALSE
	PRINTR	"""Gadzooks! Wouldst thou take from me my most prized possession?"""
?CCL42:	EQUAL?	PRSA,V?CUT,V?ATTACK \?CCL47
	EQUAL?	PRSI,TH-SWORD \?CCL50
	CALL1	RT-KILL-KRAKEN
	RSTACK	
?CCL50:	EQUAL?	P-PRSA-WORD,W?BITE /?CTR51
	EQUAL?	PRSI,TH-MOUTH \?CCL52
?CTR51:	PRINTR	"The kraken moves his tentacle out of the way and says, ""If thou thinkest to bite me, thinkst again."""
?CCL52:	ICALL	RT-PRINT-OBJ,WINNER,K-ART-THE,TRUE-VALUE,STR?256
	ICALL	RT-PRINT-OBJ,CH-KRAKEN,K-ART-THE
	PRINTI	" with"
	ICALL	RT-PRINT-OBJ,PRSI,K-ART-THE
	PRINTR	", but it doesn't do any good."
?CCL47:	EQUAL?	PRSA,V?SHOCK \?CCL56
	FSET?	PRSO,FL-BROKEN /?CCL59
	FSET	CH-KRAKEN,FL-BROKEN
	ADD	GL-MOVES,1
	ICALL	RT-QUEUE,RT-I-KRAKEN-FOLLOW,STACK
	PRINTR	"You zap the kraken. He recoils for an instant and then recovers. His tentacles start to reach out for you and he says, ""Thou hast made a grievous error, varlet. Now I must needs squeezeth thee until thou art dead."""
?CCL59:	PRINTI	"You zap the kraken, but this time he was ready for you and he scarcely notices. His tentacles slowly close around you and squeeze the life from your body.
"
	CALL1	RT-END-OF-GAME
	RSTACK	
?CCL56:	EQUAL?	PRSA,V?EXAMINE \?CCL61
	FSET	CH-KRAKEN,FL-SEEN
	CALL	NOUN-USED?,CH-KRAKEN,W?TENTACLE,W?TENTACLES
	ZERO?	STACK /?CCL64
	PRINTR	"The kraken's tentacles are thick and slimy."
?CCL64:	PRINTR	"The kraken looks like a giant octopus. His tentacles are long and slimy. One of the tentacles is adorned by a golden bracelet."
?CCL61:	CALL1	TOUCH-VERB?
	ZERO?	STACK /FALSE
	FSET?	CH-KRAKEN,FL-LOCKED \?CCL69
	ICALL	RT-PRINT-OBJ,CH-KRAKEN,K-ART-THE,TRUE-VALUE
	PRINTI	" scarcely notices. His tentacles slowly close tighter and squeeze the life from your body.
"
	CALL1	RT-END-OF-GAME
	RSTACK	
?CCL69:	PRINTR	"""Villain! Toucheth thee not me, lest I take ire and kill thee."""


	.FUNCT	RT-KILL-KRAKEN:ANY:0:0
	EQUAL?	HERE,RM-FORD \?CCL3
	MOVE	TH-BRACELET,RM-RIVER-1
	JUMP	?CND1
?CCL3:	MOVE	TH-BRACELET,RM-MID-LAKE
?CND1:	REMOVE	CH-KRAKEN
	FCLEAR	CH-KRAKEN,FL-LOCKED
	FCLEAR	TH-BRACELET,FL-TRY-TAKE
	FCLEAR	TH-BRACELET,FL-NO-DESC
	FSET	TH-BRACELET,FL-TAKEABLE
	ICALL2	RT-DEQUEUE,RT-I-KRAKEN-FIGHT-1
	ICALL2	RT-DEQUEUE,RT-I-KRAKEN-FIGHT-2
	PRINTI	"You hack at"
	ICALL	RT-PRINT-OBJ,CH-KRAKEN,K-ART-THE
	PRINTI	" with"
	ICALL	RT-PRINT-OBJ,TH-SWORD,K-ART-THE
	PRINTI	". The tentacle bearing"
	ICALL	RT-PRINT-OBJ,TH-BRACELET,K-ART-THE
	PRINTI	" flies up into the air and lands with a plop in the deep water. The wounded kraken immediately releases its grip on you and disappears into the murky waters."
	CRLF	
	CALL	RT-SCORE-MSG,0,5,7,4
	RSTACK	


	.FUNCT	RT-I-KRAKEN-FOLLOW:ANY:0:0
	IN?	CH-KRAKEN,HERE \?CCL3
	CRLF	
	ICALL	RT-PRINT-OBJ,CH-KRAKEN,K-ART-THE,TRUE-VALUE
	PRINTC	32
	EQUAL?	HERE,RM-SHALLOWS,RM-FORD \?CCL6
	EQUAL?	PRSA,V?TRANSFORM \?CCL6
	EQUAL?	GL-PLAYER-FORM,GL-OLD-FORM /?CCL6
	ADD	GL-MOVES,1
	ICALL	RT-QUEUE,RT-I-KRAKEN-FIGHT-1,STACK
	PRINTI	"recoils for a moment, and then reaches out a slimy tentacle towards you. "
	ICALL	RT-PRINT-OBJ,TH-BRACELET,K-ART-THE,TRUE-VALUE
	PRINTR	" glistens in the sunlight."
?CCL6:	PRINTI	"catches up to you and wraps his blood-sucking tentacles around you. Then slowly, inexorably, he squeezes the life out of you.
"
	CALL1	RT-END-OF-GAME
	RSTACK	
?CCL3:	FSET?	HERE,FL-WATER /?CCL11
	MOVE	CH-KRAKEN,RM-BOAT-ROOM
	FCLEAR	CH-KRAKEN,FL-BROKEN
	RFALSE	
?CCL11:	ADD	GL-MOVES,1
	ICALL	RT-QUEUE,RT-I-KRAKEN-FOLLOW,STACK
	MOVE	CH-KRAKEN,HERE
	CRLF	
	ICALL	RT-PRINT-OBJ,CH-KRAKEN,K-ART-THE,TRUE-VALUE
	PRINTR	" follows you."


	.FUNCT	RT-I-KRAKEN-FIGHT-1:ANY:0:0
	FSET?	HERE,FL-WATER \FALSE
	ADD	GL-MOVES,1
	ICALL	RT-QUEUE,RT-I-KRAKEN-FIGHT-2,STACK
	FSET	CH-KRAKEN,FL-LOCKED
	PRINTR	"
A slimy tentacle wraps around you, and the kraken begins to squeeze."


	.FUNCT	RT-I-KRAKEN-FIGHT-2:ANY:0:0
	CRLF	
	ICALL	RT-PRINT-OBJ,CH-KRAKEN,K-ART-THE,TRUE-VALUE
	PRINTI	" squeezes the life out of you.
"
	CALL1	RT-END-OF-GAME
	RSTACK	


	.FUNCT	RT-TH-BRACELET:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	CALL1	TOUCH-VERB?
	ZERO?	STACK \?PRD7
	EQUAL?	PRSA,V?ENTER \?CCL5
?PRD7:	IN?	PRSO,CH-KRAKEN \?CCL5
	ZERO?	GL-PLAYER-FORM /?CCL5
	PRINTR	"As you approach the bracelet, the kraken moves his tentacle out of your way and says, ""Villain! Toucheth thee not me, lest I take ire and kill thee."""
?CCL5:	EQUAL?	PRSA,V?EXAMINE \?CCL12
	FSET	TH-BRACELET,FL-SEEN
	PRINTR	"It is a beautiful gold bracelet, inlaid with many fine jewels."
?CCL12:	EQUAL?	PRSA,V?ENTER /?PRD16
	EQUAL?	PRSA,V?PUT-THRU \?CCL14
	EQUAL?	PRSO,TH-HEAD \?CCL14
?PRD16:	FSET?	HERE,FL-WATER \?CCL14
	EQUAL?	GL-PLAYER-FORM,K-FORM-TURTLE,K-FORM-EEL \?CCL14
	EQUAL?	GL-PLAYER-FORM,K-FORM-TURTLE \?CCL24
	FSET?	TH-HEAD,FL-LOCKED \?CCL27
	PRINTI	"You bump up against"
	ICALL	RT-PRINT-OBJ,TH-BRACELET,K-ART-THE
	PRINTR	", but it fails to catch on anything since your head is inside your shell."
?CCL27:	PRINTI	"Your head passes through"
	ICALL	RT-PRINT-OBJ,TH-BRACELET,K-ART-THE
	PRINTI	" and it nestles around your neck, up against your shell."
	CRLF	
	FSET?	TH-BRACELET,FL-TOUCHED /?CND28
	FSET	TH-BRACELET,FL-TOUCHED
	ICALL	RT-SCORE-MSG,0,3,0,1
?CND28:	ICALL	RT-DO-TAKE,TH-BRACELET,TRUE-VALUE
	FSET	TH-BRACELET,FL-WORN
	RTRUE	
?CCL24:	PRINTI	"You swim through"
	ICALL	RT-PRINT-OBJ,TH-BRACELET,K-ART-THE
	PRINTR	". It catches for a moment, but your body is too slim and you pass right through it."
?CCL14:	EQUAL?	PRSA,V?CUT \?CCL31
	IN?	TH-BRACELET,CH-KRAKEN \FALSE
	EQUAL?	PRSI,TH-SWORD \FALSE
	IN?	TH-SWORD,CH-PLAYER \FALSE
	CALL1	RT-KILL-KRAKEN
	RSTACK	
?CCL31:	EQUAL?	PRSA,V?TAKE \FALSE
	IN?	TH-BRACELET,RM-FIELD-OF-HONOUR \FALSE
	CALL2	RT-IS-QUEUED?,RT-I-LOT-WIN
	ZERO?	STACK /FALSE
	PRINTI	"Before you can get to"
	ICALL	RT-PRINT-OBJ,TH-BRACELET,K-ART-THE
	PRINTI	", Lot snatches it up and then runs you through with his sword.
"
	CALL1	RT-END-OF-GAME
	RSTACK	


	.FUNCT	RT-TH-BOAT:ANY:0:3,CONTEXT,ART,CAP?
	EQUAL?	CONTEXT,M-OBJDESC \?CCL3
	ZERO?	ART /?CND4
	ICALL	PRINT-ARTICLE,TH-BOAT,ART,CAP?
?CND4:	EQUAL?	ART,FALSE-VALUE,K-ART-THE,K-ART-A /?CCL8
	EQUAL?	ART,K-ART-ANY \FALSE
?CCL8:	ZERO?	ART /?CND11
	PRINTC	32
?CND11:	CALL	NOUN-USED?,TH-BOAT,W?HOLE
	ZERO?	STACK /?CCL15
	PRINTI	"hole"
	RTRUE	
?CCL15:	PRINTI	"boat"
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?LOOK-IN,V?EXAMINE \?CCL17
	CALL	NOUN-USED?,TH-BOAT,W?HOLE
	ZERO?	STACK /?CCL20
	PRINTR	"It's a jagged hole that looks man-made."
?CCL20:	IN?	TH-BOAT,HERE /?CCL22
	PRINTR	"All you can see from here is a vague outline."
?CCL22:	PRINTR	"It's an old rowboat that looks as if it was deliberately sunk. It contains a huge stone that has a magnificent sword embedded in it."
?CCL17:	EQUAL?	PRSA,V?ENTER \FALSE
	FSET?	HERE,FL-WATER \FALSE
	PRINTR	"You swim through the hole in the side of the boat, but nothing happens."


	.FUNCT	RT-RM-LAKE-WINDOW:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"You are"
	ICALL2	RT-WALK-MSG,TRUE-VALUE
	PRINTI	" near"
	JUMP	?CND4
?CCL6:	PRINTI	"You"
	ICALL1	RT-WALK-MSG
	PRINTI	" towards"
?CND4:	FSET	LG-WINDOW,FL-SEEN
	PRINTI	" the island. There is a window in the rock through which light is coming. The middle of the lake lies behind you to the west.
"
	RFALSE	
?CCL3:	EQUAL?	CONTEXT,M-ENTER \?CCL8
	IN?	CH-NIMUE,TH-BIER \?CCL11
	SET	'GL-PICTURE-NUM,K-PIC-WINDOW-WOMAN
	JUMP	?CND9
?CCL11:	SET	'GL-PICTURE-NUM,K-PIC-WINDOW
?CND9:	EQUAL?	GL-WINDOW-TYPE,K-WIN-PICT \FALSE
	ICALL1	RT-UPDATE-PICT-WINDOW
	RFALSE	
?CCL8:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-WINDOW-UP:ANY:0:1,QUIET
	ZERO?	QUIET \FALSE
	EQUAL?	GL-PLAYER-FORM,K-FORM-EEL \?CCL6
	ICALL2	RT-YOU-CANT-MSG,STR?120
	RETURN	ROOMS
?CCL6:	PRINT	K-ROCKS-STEEP-MSG
	RETURN	ROOMS


	.FUNCT	RT-PS-ROCKS:ANY:0:3,CONTEXT,ART,CAP?
	EQUAL?	CONTEXT,M-OBJDESC \?CCL3
	FSET	PSEUDO-OBJECT,FL-PLURAL
	FCLEAR	PSEUDO-OBJECT,FL-VOWEL
	ZERO?	ART /?CND4
	ICALL	PRINT-ARTICLE,PSEUDO-OBJECT,ART,CAP?
?CND4:	EQUAL?	ART,FALSE-VALUE,K-ART-THE,K-ART-A /?CCL8
	EQUAL?	ART,K-ART-ANY \FALSE
?CCL8:	ZERO?	ART /?CND11
	PRINTC	32
?CND11:	PRINTI	"rocks"
	RTRUE	
?CCL3:	EQUAL?	HERE,RM-MID-LAKE \?CCL14
	ICALL2	THIS-IS-IT,PSEUDO-OBJECT
	CALL1	TOUCH-VERB?
	ZERO?	STACK \?CCL17
	EQUAL?	PRSA,V?ENTER,V?EXAMINE \FALSE
?CCL17:	PRINTR	"The rocks lie well to the east."
?CCL14:	EQUAL?	PRSA,V?EXAMINE \?CCL21
	ICALL2	THIS-IS-IT,PSEUDO-OBJECT
	PRINTR	"The sheer rocks rise straight out of the water."
?CCL21:	EQUAL?	PRSA,V?ENTER \?CCL23
	ICALL2	THIS-IS-IT,LG-WINDOW
	PRINTR	"The window is firmly sealed. It can't be opened."
?CCL23:	EQUAL?	PRSA,V?CLIMB-OVER,V?CLIMB-UP,V?CLIMB-ON \FALSE
	ICALL2	THIS-IS-IT,PSEUDO-OBJECT
	PRINT	K-ROCKS-STEEP-MSG
	RTRUE	


	.FUNCT	RT-LG-WINDOW:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?LOOK-IN,V?LOOK-THRU,V?EXAMINE \?CCL5
	FSET	LG-WINDOW,FL-SEEN
	EQUAL?	HERE,RM-LAKE-WINDOW \?CCL8
	FSET	RM-UG-CHAMBER,FL-SEEN
	FSET	TH-BIER,FL-SEEN
	PRINTI	"Through the window you see an underground chamber. "
	IN?	CH-NIMUE,TH-BIER \?CCL11
	FSET	CH-NIMUE,FL-SEEN
	PRINTR	"Lying on a bier in the middle of the chamber is a beautiful woman."
?CCL11:	PRINTR	"In the middle of the chamber is an empty bier."
?CCL8:	PRINTR	"Through the window you see only water."
?CCL5:	EQUAL?	PRSA,V?ENTER,V?OPEN \?CCL13
	PRINTR	"The window is firmly sealed. It can't be opened."
?CCL13:	EQUAL?	PRSA,V?BREAK \FALSE
	ICALL	RT-PRINT-OBJ,WINNER,K-ART-THE,TRUE-VALUE
	PRINTR	" can't break the window."


	.FUNCT	RT-RM-INLET:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"You are swimming in the lake, near where a river enters it from the northeast. The middle of the lake lies to the northwest.
"
	RFALSE	
?CCL3:	EQUAL?	CONTEXT,M-ENTER \?CCL5
	SET	'GL-PICTURE-NUM,K-PIC-UNDERWATER
	EQUAL?	GL-WINDOW-TYPE,K-WIN-PICT \FALSE
	ICALL1	RT-UPDATE-PICT-WINDOW
	RFALSE	
?CCL5:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-LG-LAKE:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	ZERO?	NOW-PRSI /?CCL5
	EQUAL?	PRSA,V?THROW-OVER,V?THROW /?CTR7
	EQUAL?	PRSA,V?PUT-IN,V?PUT \?CCL8
	EQUAL?	P-PRSA-WORD,W?THROW,W?TOSS,W?HURL /?CTR7
	EQUAL?	P-PRSA-WORD,W?CHUCK,W?FLING,W?PITCH /?CTR7
	EQUAL?	P-PRSA-WORD,W?HEAVE \?CCL8
?CTR7:	EQUAL?	HERE,RM-SHALLOWS \?CCL18
	CALL	NOUN-USED?,LG-LAKE,W?LAKE
	ZERO?	STACK /?CCL21
	CALL1	IDROP
	ZERO?	STACK /TRUE
	REMOVE	PRSO
	BOR	GL-UPDATE-WINDOW,K-UPD-INVT >GL-UPDATE-WINDOW
	ICALL	RT-PRINT-OBJ,WINNER,K-ART-THE,TRUE-VALUE,STR?299
	ICALL	RT-PRINT-OBJ,PRSO,K-ART-THE
	PRINTR	" into the depths of the lake."
?CCL21:	ICALL	PERFORM,V?DROP,PRSO
	RTRUE	
?CCL18:	EQUAL?	HERE,RM-FIELD-OF-HONOUR \?CCL26
	CALL1	IDROP
	ZERO?	STACK /TRUE
	CALL	RT-THROW-INTO-ROOM-MSG,PRSO,RM-SHALLOWS
	RSTACK	
?CCL26:	CALL2	NOT-HERE,PRSI
	RSTACK	
?CCL8:	EQUAL?	PRSA,V?PUT-IN,V?PUT \FALSE
	EQUAL?	HERE,RM-SHALLOWS \?CCL34
	ICALL	PERFORM,V?DROP,PRSO
	RTRUE	
?CCL34:	CALL2	NOT-HERE,PRSI
	RSTACK	
?CCL5:	EQUAL?	PRSA,V?EAT,V?DRINK-FROM,V?DRINK \?CCL36
	FSET?	HERE,FL-WATER \?CCL39
	ICALL	RT-PRINT-OBJ,WINNER,K-ART-THE,TRUE-VALUE,STR?208
	PRINTR	" a small, refreshing sip of water."
?CCL39:	CALL2	NOT-HERE,LG-RIVER
	RSTACK	
?CCL36:	EQUAL?	PRSA,V?WALK-TO,V?ENTER \?CCL41
	EQUAL?	HERE,RM-FIELD-OF-HONOUR,RM-SHALLOWS \FALSE
	CALL2	RT-DO-WALK,P?SOUTH
	RSTACK	
?CCL41:	EQUAL?	PRSA,V?EXIT \?CCL46
	EQUAL?	HERE,RM-SHALLOWS \FALSE
	CALL2	RT-DO-WALK,P?NORTH
	RSTACK	
?CCL46:	EQUAL?	PRSA,V?EXAMINE \FALSE
	FSET	LG-LAKE,FL-SEEN
	FSET?	HERE,FL-WATER \?CCL54
	ICALL2	PERFORM,V?LOOK
	RTRUE	
?CCL54:	FSET	RM-ISLAND,FL-SEEN
	PRINTI	"It a large lake with an island in the middle of it. A causeway leads out to the island."
	FSET?	RM-MID-LAKE,FL-WATER /?CND55
	PRINTI	" A magical force is holding back the waters of the lake on either side of a dry path that leads south"
	EQUAL?	HERE,RM-FIELD-OF-HONOUR /?CND57
	PRINTI	" from"
	ICALL	RT-PRINT-OBJ,RM-FIELD-OF-HONOUR,K-ART-THE
?CND57:	PRINTR	"."
?CND55:	CRLF	
	RTRUE	


	.FUNCT	RT-LG-RIVER:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	ZERO?	NOW-PRSI /?CCL5
	EQUAL?	PRSA,V?THROW-OVER,V?THROW /?CTR7
	EQUAL?	PRSA,V?PUT-IN,V?PUT \?CCL8
	EQUAL?	P-PRSA-WORD,W?THROW,W?TOSS,W?HURL /?CTR7
	EQUAL?	P-PRSA-WORD,W?CHUCK,W?FLING,W?PITCH /?CTR7
	EQUAL?	P-PRSA-WORD,W?HEAVE \?CCL8
?CTR7:	EQUAL?	HERE,RM-FORD,RM-EAST-OF-FORD,RM-WEST-OF-FORD \?CCL18
	CALL1	IDROP
	ZERO?	STACK /TRUE
	EQUAL?	PRSO,TH-APPLE \?CCL23
	MOVE	PRSO,RM-SHALLOWS
	ICALL	RT-PRINT-OBJ,PRSO,K-ART-THE,TRUE-VALUE
	PRINTI	" quickly"
	ICALL	RT-PRINT-VERB,PRSO,STR?164
	PRINTR	" down the river and out of sight."
?CCL23:	REMOVE	PRSO
	ICALL	RT-PRINT-OBJ,WINNER,K-ART-THE,TRUE-VALUE,STR?299
	ICALL	RT-PRINT-OBJ,PRSO,K-ART-THE
	PRINTR	" into the depths of the river."
?CCL18:	CALL2	NOT-HERE,PRSI
	RSTACK	
?CCL8:	EQUAL?	PRSA,V?PUT-IN,V?PUT \FALSE
	EQUAL?	HERE,RM-FORD \?CCL28
	ICALL	PERFORM,V?DROP,PRSO
	RTRUE	
?CCL28:	CALL2	NOT-HERE,PRSI
	RSTACK	
?CCL5:	EQUAL?	PRSA,V?EAT,V?DRINK-FROM,V?DRINK \?CCL30
	FSET?	HERE,FL-WATER \?CCL33
	ICALL	RT-PRINT-OBJ,WINNER,K-ART-THE,TRUE-VALUE,STR?208
	PRINTR	" a small, refreshing sip of water."
?CCL33:	CALL2	NOT-HERE,LG-RIVER
	RSTACK	
?CCL30:	EQUAL?	PRSA,V?WALK-TO,V?ENTER \?CCL35
	EQUAL?	HERE,RM-FORD \?CCL38
	CALL2	RT-DO-WALK,P?SOUTH
	RSTACK	
?CCL38:	EQUAL?	HERE,RM-INLET \?CCL40
	CALL2	RT-DO-WALK,P?NE
	RSTACK	
?CCL40:	EQUAL?	HERE,RM-EAST-OF-FORD \?CCL42
	CALL2	RT-DO-WALK,P?WEST
	RSTACK	
?CCL42:	EQUAL?	HERE,RM-WEST-OF-FORD \FALSE
	CALL2	RT-DO-WALK,P?EAST
	RSTACK	
?CCL35:	EQUAL?	PRSA,V?EXIT \FALSE
	EQUAL?	HERE,RM-RIVER-1 \?CCL49
	CALL2	RT-DO-WALK,P?NORTH
	RSTACK	
?CCL49:	EQUAL?	HERE,RM-RIVER-3 \?CCL51
	CALL2	RT-DO-WALK,P?SW
	RSTACK	
?CCL51:	EQUAL?	HERE,RM-FORD \FALSE
	CALL1	V-WALK-AROUND
	RSTACK	


	.FUNCT	RT-RM-RIVER-3:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"You are"
	ICALL2	RT-WALK-MSG,TRUE-VALUE
	PRINTI	" in"
	JUMP	?CND4
?CCL6:	PRINTI	"You"
	ICALL1	RT-WALK-MSG
	EQUAL?	OHERE,RM-INLET \?CCL9
	PRINTI	" against the current into"
	JUMP	?CND4
?CCL9:	PRINTI	" with the current down"
?CND4:	PRINTI	" the river, where it takes a bend from the north to the southwest."
	EQUAL?	CONTEXT,M-LOOK /?CND10
	PRINTI	" A school of minnows scurries out of your way"
	IN?	TH-MINNOW,RM-RIVER-3 \?CND12
	FSET	TH-MINNOW,FL-SEEN
	ADD	GL-MOVES,1
	ICALL	RT-QUEUE,RT-I-MINNOW,STACK
	PRINTI	", but "
	EQUAL?	GL-PLAYER-FORM,K-FORM-EEL \?CND14
	PRINTI	"a "
	PRINT	K-TASTY-MSG
?CND14:	PRINTI	"one lags behind"
?CND12:	PRINTC	46
?CND10:	CRLF	
	EQUAL?	CONTEXT,M-LOOK \TRUE
	RFALSE	
?CCL3:	EQUAL?	CONTEXT,M-ENTER \?CCL20
	SET	'GL-PICTURE-NUM,K-PIC-UNDERWATER
	EQUAL?	GL-WINDOW-TYPE,K-WIN-PICT \?CND21
	ICALL1	RT-UPDATE-PICT-WINDOW
?CND21:	FSET?	TH-MINNOW,FL-LOCKED /FALSE
	MOVE	TH-MINNOW,RM-RIVER-3
	ADD	GL-MOVES,1
	ICALL	RT-QUEUE,RT-I-MINNOW,STACK
	RFALSE	
?CCL20:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-PS-MINNOWS:ANY:0:3,CONTEXT,ART,CAP?
	EQUAL?	CONTEXT,M-OBJDESC \?CCL3
	FSET	PSEUDO-OBJECT,FL-PLURAL
	FCLEAR	PSEUDO-OBJECT,FL-VOWEL
	ZERO?	ART /?CND4
	ICALL	PRINT-ARTICLE,PSEUDO-OBJECT,ART,CAP?
?CND4:	EQUAL?	ART,FALSE-VALUE,K-ART-THE,K-ART-A /?CCL8
	EQUAL?	ART,K-ART-ANY \FALSE
?CCL8:	ZERO?	ART /?CND11
	PRINTC	32
?CND11:	PRINTI	"minnows"
	RTRUE	
?CCL3:	ZERO?	CONTEXT \FALSE
	ZERO?	NOW-PRSI /?CCL19
	PUSH	2
	JUMP	?CND17
?CCL19:	PUSH	1
?CND17:	CALL2	EVERYWHERE-VERB?,STACK
	ZERO?	STACK \FALSE
	ICALL2	THIS-IS-IT,PSEUDO-OBJECT
	PRINTI	"All"
	IN?	TH-MINNOW,RM-RIVER-3 \?CND20
	ICALL2	THIS-IS-IT,TH-MINNOW
	PRINTI	" but one"
?CND20:	PRINTR	" of the minnows are gone."


	.FUNCT	RT-RM-RIVER-1:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"You are"
	ICALL2	RT-WALK-MSG,TRUE-VALUE
	PRINTI	" in the river, which flows from north to south.
"
	RFALSE	
?CCL3:	EQUAL?	CONTEXT,M-ENTER \?CCL5
	SET	'GL-PICTURE-NUM,K-PIC-UNDERWATER
	EQUAL?	GL-WINDOW-TYPE,K-WIN-PICT \FALSE
	ICALL1	RT-UPDATE-PICT-WINDOW
	RFALSE	
?CCL5:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-RM-ABOVE-LAKE:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	FSET	LG-LAKE,FL-SEEN
	FSET	RM-FIELD-OF-HONOUR,FL-SEEN
	PRINTI	"You are hovering over the lake. Below you to the north you see the Field of Honour.
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
