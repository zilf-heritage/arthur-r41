

	.FUNCT	RT-RM-MERPATH:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"You are"
	ICALL1	RT-STANDING-MSG
	PRINTI	" on a path that winds up a hill to the northwest, and returns to the meadow to the southeast"
	JUMP	?CND4
?CCL6:	EQUAL?	OHERE,RM-MEADOW \?CCL9
	PRINTI	"As you leave the meadow, the path begins to wind up a"
	JUMP	?CND7
?CCL9:	PRINTI	"The path winds down the"
?CND7:	PRINTI	" hill that overlooks the town"
?CND4:	IN?	TH-MIDGES,RM-MERPATH \?CND10
	FSET	TH-MIDGES,FL-SEEN
	PRINTI	". Hundreds of tiny midges are buzzing around your "
	ZERO?	GL-PLAYER-FORM \?CCL14
	PRINTI	"ankles"
	JUMP	?CND10
?CCL14:	PRINTI	"head"
?CND10:	PRINTC	46
	CRLF	
	RFALSE	
?CCL3:	EQUAL?	CONTEXT,M-ENTER \?CCL16
	SET	'GL-PICTURE-NUM,K-PIC-MERLIN-PATH
	EQUAL?	GL-WINDOW-TYPE,K-WIN-PICT \FALSE
	ICALL1	RT-UPDATE-PICT-WINDOW
	RFALSE	
?CCL16:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-MERPATH-UP:ANY:0:1,QUIET
	EQUAL?	GL-PLAYER-FORM,K-FORM-OWL /?CTR2
	RETURN	RM-OUTSIDE-CRYSTAL-CAVE
?CTR2:	CALL2	RT-FLY-UP,QUIET
	RSTACK	


	.FUNCT	RT-RM-OUTSIDE-CRYSTAL-CAVE:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	ICALL2	THIS-IS-IT,TH-SCROLL
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"You are"
	ICALL1	RT-STANDING-MSG
	PRINTI	" in the clearing just to the south of Merlin's cave."
	JUMP	?CND4
?CCL6:	EQUAL?	OHERE,RM-MERPATH \?CCL9
	PRINTI	"The path ends in a clearing just to the south of a cave."
	JUMP	?CND4
?CCL9:	EQUAL?	OHERE,RM-CRYSTAL-CAVE \?CCL11
	PRINTI	"You blink you eyes as you emerge from the darkness of the cave into the "
	CALL2	RT-TIME-OF-DAY?,K-NIGHT
	ZERO?	STACK /?CCL14
	PRINTI	"bright moonlight"
	JUMP	?CND12
?CCL14:	PRINTI	"sunshine"
?CND12:	PRINTC	46
	JUMP	?CND4
?CCL11:	PRINTI	"You land in the clearing just to the south of Merlin's cave."
?CND4:	EQUAL?	CONTEXT,M-F-LOOK \?CCL17
	FSET	CH-MERLIN,FL-SEEN
	ICALL2	THIS-IS-IT,CH-MERLIN
	PRINTR	" An old man is sitting on a rock outside the cave, reading a scroll. A minute passes before you realize that this shabbily-dressed hermit is the same awe-inspiring Merlin who appeared to you in the churchyard."
?CCL17:	CRLF	
	RFALSE	
?CCL3:	EQUAL?	CONTEXT,M-ENTER \?CCL19
	SET	'GL-PICTURE-NUM,K-PIC-OUTSIDE-CAVE
	EQUAL?	GL-WINDOW-TYPE,K-WIN-PICT \FALSE
	ICALL1	RT-UPDATE-PICT-WINDOW
	RFALSE	
?CCL19:	EQUAL?	CONTEXT,M-ENTERED \?CCL23
	FSET?	CH-PLAYER,FL-LOCKED /?CCL26
	FSET	CH-PLAYER,FL-LOCKED
	PRINTR	"
Merlin looks up and says, ""Why hello, Arthur. I was just thinking about you."" He strokes his beard meditatively. ""I wish to help you, but if I give you magic spells that instantly fulfill your every desire, you will only prove that any man so favoured can accomplish a quest. Instead, I've been pondering the idea of allowing you to assume shapes other than your human form.""

""You see, as an animal, you could do things that humans can't. But at least these things would not be done for you by spells. You would still have to demonstrate the qualities which prove your worthiness to rule - and at the same time you would be gaining respect for all forms of life.""

His dark eyes bore into you for a second and then he seems to reach a decision. ""Yes. That is what we shall do."" He glances down at the scroll. ""The creatures here should be sufficient for our purpose. The owl, the badger, the salamander, the eel, and the turtle.""

Merlin waves his hand over you and mumbles a few words. ""There. It is done. The word you will need is 'Cyr,' the ancient word of transformation. When you wish to become another creature, say 'Cyr' and the name of that creature. Remember, however, that the people fear sorcery - if someone is present when you change form, he may kill you. Remember also that you cannot move directly from one foreign shape to another. You must become human first."""
?CCL26:	EQUAL?	OHERE,RM-CRYSTAL-CAVE \FALSE
	FSET?	RM-CELL,FL-TOUCHED /FALSE
	PRINTR	"
Merlin glances up from his scroll and gives you a look of mild reproval. ""Be on your way, Arthur - you have much to do. Even as we speak, a prisoner languishes unjustly in a cell below Lot's castle. If you wish to be England's king, you must help England's people."""
?CCL23:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-RM-CRYSTAL-CAVE:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	EQUAL?	CONTEXT,M-F-LOOK \?CCL6
	PRINTR	"Your heart thumps with anticipation as you edge into the mysterious cave of which you have heard so much. The walls here seem to shimmer with their own light. The ceiling is lost in the darkness overhead. You hear the sound of distant music, as if the earth itself were singing - and then the chord dies away and you are left in silence.

In the center of the room is a perfectly round crystal ball. On the ground near the wall is a bag."
?CCL6:	EQUAL?	CONTEXT,M-LOOK \?CCL9
	PRINTI	"You are"
	ICALL1	RT-STANDING-MSG
	PRINTI	" in"
	JUMP	?CND7
?CCL9:	PRINTI	"You enter"
?CND7:	ICALL	RT-PRINT-OBJ,RM-CRYSTAL-CAVE,K-ART-THE
	PRINTI	". The walls here seem to shimmer with their own light. The only exit is to the south.
"
	RFALSE	
?CCL3:	EQUAL?	CONTEXT,M-ENTER \?CCL11
	SET	'GL-PICTURE-NUM,K-PIC-CRYSTAL-CAVE
	EQUAL?	GL-WINDOW-TYPE,K-WIN-PICT \FALSE
	ICALL1	RT-UPDATE-PICT-WINDOW
	RFALSE	
?CCL11:	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?LOOK-IN,V?EXAMINE \FALSE
	EQUAL?	HERE,RM-OUTSIDE-CRYSTAL-CAVE \FALSE
	FSET	RM-CRYSTAL-CAVE,FL-SEEN
	PRINTR	"An eerie light seems to emanate from within the cave."


	.FUNCT	RT-CH-MERLIN:ANY:0:1,CONTEXT,FORM
	EQUAL?	CONTEXT,M-WINNER,FALSE-VALUE \?CCL3
	EQUAL?	PRSA,V?THANK,V?GOODBYE,V?HELLO \?CCL3
	EQUAL?	PRSA,V?HELLO \?CCL8
	PRINTR	"""Greetings, my young friend."""
?CCL8:	EQUAL?	PRSA,V?GOODBYE \?CCL10
	PRINTR	"""Farewell for now, Arthur. We shall meet again."""
?CCL10:	EQUAL?	PRSA,V?THANK \FALSE
	PRINTI	"""You're welcome, my young friend."""
	CRLF	
	FSET?	CH-PLAYER,FL-AIR /TRUE
	FSET	CH-PLAYER,FL-AIR
	ICALL	RT-SCORE-MSG,10,0,0,0
	RTRUE	
?CCL3:	EQUAL?	CONTEXT,M-WINNER \?CCL16
	EQUAL?	PRSA,V?TELL-ABOUT \?CCL19
	EQUAL?	PRSO,CH-PLAYER /FALSE
?CCL19:	PRINTR	"""You must not ask me to do too much, Arthur. It is you who must take action."""
?CCL16:	ZERO?	CONTEXT \FALSE
	ZERO?	NOW-PRSI \FALSE
	EQUAL?	PRSA,V?TELL \?CCL27
	ZERO?	P-CONT \FALSE
?CCL27:	EQUAL?	PRSA,V?ASK-ABOUT \?CCL31
	CALL	NOUN-USED?,PRSI,W?OWL
	ZERO?	STACK /?CCL34
	SET	'FORM,K-FORM-OWL
	JUMP	?CND32
?CCL34:	CALL	NOUN-USED?,PRSI,W?BADGER
	ZERO?	STACK /?CCL36
	SET	'FORM,K-FORM-BADGER
	JUMP	?CND32
?CCL36:	CALL	NOUN-USED?,PRSI,W?SALAMANDER
	ZERO?	STACK /?CCL38
	SET	'FORM,K-FORM-SALAMANDER
	JUMP	?CND32
?CCL38:	CALL	NOUN-USED?,PRSI,W?EEL
	ZERO?	STACK /?CCL40
	SET	'FORM,K-FORM-EEL
	JUMP	?CND32
?CCL40:	CALL	NOUN-USED?,PRSI,W?TURTLE
	ZERO?	STACK /?CCL42
	SET	'FORM,K-FORM-TURTLE
	JUMP	?CND32
?CCL42:	EQUAL?	PRSI,CH-PLAYER \?CND32
	ZERO?	GL-PLAYER-FORM /?CND32
	SET	'FORM,GL-PLAYER-FORM
?CND32:	EQUAL?	FORM,K-FORM-OWL \?CCL48
	PRINTR	"""From the owl you may learn to think. It is a noble bird indeed. Sacred to the roman goddess Minerva."""
?CCL48:	EQUAL?	FORM,K-FORM-BADGER \?CCL50
	PRINTR	"""The badger is a fierce defender of his territory. He is a fine digger who makes his nest and then fights to the death for it. So must you defend England."""
?CCL50:	EQUAL?	FORM,K-FORM-SALAMANDER \?CCL52
	PRINTR	"""Ah yes. The lizard that they say lives in fire. He doesn't really - but he does excrete a fluid that protects his skin from heat for short periods of time. From him you will learn how to survive the heat of battle."""
?CCL52:	EQUAL?	FORM,K-FORM-EEL \?CCL54
	PRINTR	"""From the eel you will learn how to slip out of tight spots."""
?CCL54:	EQUAL?	FORM,K-FORM-TURTLE \?CCL56
	PRINTR	"""From the turtle you will learn that sometimes it is better to be slow and sturdy than to be swift."""
?CCL56:	EQUAL?	PRSI,CH-DEMON \?CCL58
	FSET?	CH-DEMON,FL-BROKEN \?CCL61
	PRINTR	"""Even though you have defeated him this time, Arthur, his magic remains powerful."""
?CCL61:	PRINTR	"""He is evil incarnate. Many years ago, in a titanic struggle, my gods overcame him and imprisoned him within a mountain. He sits there still, bound by gold manacles, with a key of gold around his neck to taunt him. Should he ever free himself, unspeakable evil will once again descend upon England.""

""Even though he is manacled, he still has power. When you cross the river, you will find that my magic is no longer of any use to you. That is his land. Go there only if you must."""
?CCL58:	EQUAL?	PRSI,CH-LOT \?CCL63
	PRINTR	"""He is an evil man, ruled by greed. He plots to steal your throne, yet if you can defeat him in battle, he will become loyal to you."""
?CCL63:	EQUAL?	PRSI,CH-PRISONER \?CCL65
	PRINTR	"""He is the village smith who has been wrongly and cruelly imprisoned by Lot."""
?CCL65:	EQUAL?	PRSI,CH-MERLIN \?CCL67
	PRINTR	"""I walk among men, yet I am not a man. I see the future, yet am powerless to control it. I am but a tool to be used by my gods."""
?CCL67:	EQUAL?	PRSI,CH-NIMUE \?CCL69
	PRINTR	"""She is Nimue, the Lady of the Lake. On cold evenings, when story-tellers huddle close around the fire, they tell the legend of her enchantment. Little do they know that the stories are all true."""
?CCL69:	EQUAL?	PRSI,TH-BAG \?CCL71
	PRINTR	"""It is the bag my father's sister gave me when I first left home. Its magic is small, but useful."""
?CCL71:	EQUAL?	PRSI,TH-SILVER-KEY \?CCL73
	PRINTR	"""It is the key to a chamber wherein lies a beautiful lady."""
?CCL73:	EQUAL?	PRSI,RM-CRYSTAL-CAVE \?CCL75
	PRINTR	"""The crystal cave holds much knowledge, Arthur. But be careful. Sometimes it tells us things that we later wish we had learned for ourselves."""
?CCL75:	EQUAL?	PRSI,TH-CRYSTAL-BALL,TH-TORQUE \?CCL77
	PRINTR	"""The crystal contains the answers to all your questions. But use it sparingly, Arthur. Sometimes it reveals things you wish you had reasoned out for yourself."""
?CCL77:	EQUAL?	PRSI,TH-EXCALIBUR \?CCL79
	PRINTR	"""It is the sword of destiny, meant to be wielded by you alone."""
?CCL79:	EQUAL?	PRSI,TH-MAGIC-RING \?CCL81
	PRINTR	"""It's magic is useful. Remember well the words of the man who gave it to you."""
?CCL81:	EQUAL?	PRSI,TH-FUTURE-OBJECT,CH-PLAYER \?CCL83
	PRINTR	"A look of pain crosses Merlin's face. ""The future holds both triumph and sorrow for you, Arthur. But do not dwell on it. Live each day as it is given to you, and leave the future in the hands of the gods."""
?CCL83:	EQUAL?	PRSI,TH-SCROLL \?CCL85
	PRINTR	"""It is of no use to you, Arthur. Its magic is useful only to those who know how to wield it."""
?CCL85:	EQUAL?	PRSI,CH-BLACK-KNIGHT \?CCL87
	PRINTR	"""One need only look at him to discern what master he serves."""
?CCL87:	EQUAL?	PRSI,CH-BLUE-KNIGHT \?CCL89
	PRINTR	"""A harmless old man who loves to joust."""
?CCL89:	EQUAL?	PRSI,CH-RED-KNIGHT \?CCL91
	PRINTR	"""His life's mission is to rid the land of evil."""
?CCL91:	EQUAL?	PRSI,CH-I-KNIGHT \?CCL93
	PRINTR	"""He's just an ordinary man who is trying to turn a peculiar talent into a dishonest living."""
?CCL93:	EQUAL?	PRSI,CH-CELL-GUARD \?CCL95
	PRINTR	"""Like most of Lot's minions, he's not very bright."""
?CCL95:	EQUAL?	PRSI,CH-COOK \?CCL97
	PRINTR	"""His own meals are far better than anyone suspects."""
?CCL97:	EQUAL?	PRSI,CH-DRAGON \?CCL99
	PRINTR	"""If I drank what he drinks, I would breathe fire too."""
?CCL99:	EQUAL?	PRSI,CH-FARMERS \?CCL101
	PRINTR	"""They don't have much to do in the wintertime except sit in the tavern and gossip."""
?CCL101:	EQUAL?	PRSI,CH-GIRL \?CCL103
	PRINTR	"""I'm a poor one to ask for advice about women, Arthur. All I can say is, be careful."""
?CCL103:	EQUAL?	PRSI,CH-IDIOT \?CCL105
	PRINTR	"""He only imagines half of what he thinks he imagines."""
?CCL105:	EQUAL?	PRSI,CH-PEASANT \?CCL107
	PRINTR	"""He is but a humble man who makes his living from the soil."""
?CCL107:	EQUAL?	PRSI,TH-BIRD \?CCL109
	PRINTR	"""He is an infrequent visitor to our shores, and he tells more than he knows."""
?CCL109:	EQUAL?	PRSI,CH-RHYMER \?CCL111
	PRINTR	"""He seems inordinately fond of poetry, doesn't he?"""
?CCL111:	EQUAL?	PRSI,TH-BOAR \?CCL113
	PRINTR	"""Even though he has only one tusk, he is still very dangerous."""
?CCL113:	EQUAL?	PRSI,CH-RAVEN \?CCL115
	PRINTR	"""The giant bird is a menace to all other life in the forest."""
?CCL115:	EQUAL?	PRSI,LG-TOWER \?CCL117
	PRINTR	"""It is the home of a very interesting little old man."""
?CCL117:	EQUAL?	PRSI,RM-TAVERN \?CCL119
	PRINTR	"""Like all such places, it is frequented by men with little to do and much to say."""
?CCL119:	EQUAL?	PRSI,LG-CASTLE \?CCL121
	PRINTR	"""It is Lot's domain, Arthur. You must go in, but be careful when you do so."""
?CCL121:	EQUAL?	PRSI,RM-BOG \?CCL123
	PRINTR	"""The ground there is treacherous and shifting, Arthur. Do not venture in unless you are sure of your path."""
?CCL123:	EQUAL?	PRSI,LG-LAKE \?CCL125
	PRINTR	"""The lake is home to both beauty and the beast."""
?CCL125:	EQUAL?	PRSI,TH-SHERLOCK \?CCL127
	PRINTR	"""It's a wonderful game. I highly recommend it."""
?CCL127:	EQUAL?	PRSI,TH-HAWTHORN \?CCL129
	PRINTR	"Merlin's eyes cloud over as if he is looking far into the future. He mumbles strange words that sound like 'anti-piracy' and 'documentation,' and then he snaps out of his trance as if nothing had happened."
?CCL129:	PRINTR	"Merlin shrugs his shoulders and nods toward the cave. ""Perhaps the answer you seek lies within."""
?CCL31:	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTR	"The aged wizard gazes back at you with friendly eyes that seem to see the future, as well as the past."


	.FUNCT	RT-TH-SCROLL:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?READ /?CCL5
	CALL1	TOUCH-VERB?
	ZERO?	STACK /FALSE
?CCL5:	PRINTR	"Merlin moves the scroll beyond your reach and says, ""Some secrets, Arthur, are best kept hidden."""


	.FUNCT	RT-TH-BAG:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	ZERO?	NOW-PRSI /?CCL5
	EQUAL?	PRSA,V?PUT-IN \FALSE
	EQUAL?	PRSO,TH-SWORD,TH-CRUTCH,TH-SHIELD /?CTR10
	EQUAL?	PRSO,TH-SLEAN /?CTR10
	GRTR?	P-MULT,1 \?CCL11
	EQUAL?	PRSO,TH-RED-LANCE,TH-GREEN-LANCE \?CCL11
?CTR10:	ICALL	RT-PRINT-OBJ,PRSO,K-ART-THE,TRUE-VALUE,STR?69
	PRINTI	" too large to fit in"
	ICALL	RT-PRINT-OBJ,TH-BAG,K-ART-THE
	PRINTR	"."
?CCL11:	EQUAL?	PRSO,TH-RED-LANCE,TH-GREEN-LANCE \FALSE
	PRINTI	"You look at"
	ICALL	RT-PRINT-OBJ,PRSO,K-ART-THE
	PRINTI	". You look at"
	ICALL	RT-PRINT-OBJ,TH-BAG,K-ART-THE
	PRINTI	". You look at"
	ICALL	RT-PRINT-OBJ,PRSO,K-ART-THE
	PRINTR	". Slowly it dawns on you that it is just not going to work."
?CCL5:	EQUAL?	PRSA,V?READ,V?LOOK-ON,V?EXAMINE \?CCL20
	FSET	TH-BAG,FL-SEEN
	PRINTR	"It is a small black bag, monogrammed with the initial M."
?CCL20:	EQUAL?	PRSA,V?FILL \FALSE
	CALL1	RT-WASTE-OF-TIME-MSG
	RSTACK	


	.FUNCT	RT-TH-CRYSTAL-BALL:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?LOOK-IN /?CTR4
	EQUAL?	PRSA,V?READ,V?LOOK-ON,V?EXAMINE \?CCL5
?CTR4:	FSET	TH-CRYSTAL-BALL,FL-SEEN
	CALL1	V-HINT
	RSTACK	
?CCL5:	CALL1	TOUCH-VERB?
	ZERO?	STACK /FALSE
	PRINTR	"As you reach for the ball, the crystal walls of the cave start to vibrate ominously and you wisely withdraw."


	.FUNCT	RT-TH-TORQUE:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?EXAMINE \FALSE
	FSET	TH-TORQUE,FL-SEEN
	ICALL2	THIS-IS-IT,TH-TORQUE
	ICALL	RT-PRINT-OBJ,TH-TORQUE,K-ART-THE,TRUE-VALUE
	PRINTI	" is an open neckband made of twisted metal. It ends in two knobs, and imbedded in one of the knobs is a sliver of "
	FSET?	TH-CRYSTAL,FL-LOCKED \?CCL8
	PRINTI	"darkened crystal"
	JUMP	?CND6
?CCL8:	PRINTI	"crystal that gives off a faint glow"
?CND6:	PRINTR	"."


	.FUNCT	RT-TH-CRYSTAL:ANY:0:1,CONTEXT,W
	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?READ /?CTR4
	EQUAL?	PRSA,V?LOOK-ON,V?LOOK-IN,V?EXAMINE \?CCL5
?CTR4:	FSET	TH-CRYSTAL,FL-SEEN
	EQUAL?	HERE,RM-CRYSTAL-CAVE \?CCL10
	CALL1	V-HINT
	RSTACK	
?CCL10:	FSET?	TH-CRYSTAL,FL-LOCKED /?CTR11
	GETB	K-DEMON-DOMAIN-TBL,0
	INTBL?	HERE,K-DEMON-DOMAIN-TBL+1,STACK,1 \?CCL12
?CTR11:	PRINTR	"The crystal is dark."
?CCL12:	PRINTI	"You gaze intently into the crystal. After a moment, your vision blurs and you become disoriented. It seems you are standing in a darkened cave, gazing into a crystal ball.

"
	SET	'W,GL-HINT-WARNING
	ICALL1	V-HINT
	ZERO?	W \?CND15
	CRLF	
?CND15:	PRINTI	"Your vision clears and you are no longer in the cave.
"
	INC	'GL-CRYSTAL-HINT
	EQUAL?	GL-CRYSTAL-HINT,2 \TRUE
	FSET	TH-CRYSTAL,FL-LOCKED
	ADD	GL-MOVES,5
	ICALL	RT-QUEUE,RT-I-CRYSTAL,STACK
	PRINTR	"
The crystal goes dark. Its limited power has been temporarily exhausted."
?CCL5:	EQUAL?	PRSA,V?TAKE \FALSE
	PRINTI	"You can't remove the "
	ICALL2	NP-PRINT,PRSO-NP
	PRINTI	" from"
	ICALL	RT-PRINT-OBJ,TH-TORQUE,K-ART-THE
	PRINTR	"."


	.FUNCT	RT-I-CRYSTAL:ANY:0:0
	FCLEAR	TH-CRYSTAL,FL-LOCKED
	RFALSE	


	.FUNCT	RT-GN-KEY:ANY:2:2,TBL,FINDER,PTR,N,OBJ,I,O
	ADD	TBL,8 >PTR
	GET	TBL,1 >N
	INTBL?	P-IT-OBJECT,PTR,N \?CCL3
	SET	'OBJ,P-IT-OBJECT
	JUMP	?CND1
?CCL3:	EQUAL?	HERE,RM-TAV-KITCHEN \?CCL5
	SET	'OBJ,TH-CUPBOARD-KEY
	JUMP	?CND1
?CCL5:	EQUAL?	HERE,RM-DEMON-HALL \?CCL7
	SET	'OBJ,TH-GOLD-KEY
	JUMP	?CND1
?CCL7:	EQUAL?	HERE,RM-TOW-CLEARING,RM-CIRC-ROOM \?CCL9
	SET	'OBJ,TH-IVORY-KEY
	JUMP	?CND1
?CCL9:	EQUAL?	HERE,RM-ISLAND,RM-UG-CHAMBER \?CCL11
	SET	'OBJ,TH-SILVER-KEY
	JUMP	?CND1
?CCL11:	EQUAL?	HERE,RM-CELL,RM-HALL \?CCL13
	SET	'OBJ,TH-MASTER-KEY
	JUMP	?CND1
?CCL13:	SET	'I,N
?PRG14:	DLESS?	'I,0 /?CND1
	GET	PTR,0 >O
	FSET?	O,FL-SEEN \?CND16
	ZERO?	OBJ /?CCL22
	SET	'OBJ,FALSE-VALUE
?CND1:	ZERO?	OBJ \?CCL24
	RETURN	OBJ
?CCL22:	SET	'OBJ,O
?CND16:	ADD	PTR,2 >PTR
	JUMP	?PRG14
?CCL24:	PRINTC	91
	ICALL	RT-PRINT-OBJ,OBJ,K-ART-THE,TRUE-VALUE
	PRINTC	93
	CRLF	
	RETURN	OBJ


	.FUNCT	RT-RM-ABOVE-MERCAVE:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	FSET	LG-FOREST,FL-SEEN
	FSET	RM-MOOR,FL-SEEN
	FSET	RM-MEADOW,FL-SEEN
	PRINTI	"You are hovering over Merlin's cave. The prevailing northeast breeze would carry you over the enchanted forest, and just to the south of that is the edge of the woods. The meadow lies below you to the southeast.
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
