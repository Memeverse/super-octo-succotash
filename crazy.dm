/client/proc/Crazy(mob/M in Players)
	set name = "Crazy"
	set category = "Admin"

	if(!usr.client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	if(M.Crazy)
		M.Crazy=0
		logAndAlertAdmins("[key_name(usr)] made it so [key_name(M)] no longer talks crazy in ooc.")
	else
		M.Crazy=1
		logAndAlertAdmins("[key_name(usr)] forces [key_name(M)] to talk crazy in ooc!")
proc/Crazy(A)
	return pick("ROFL","NO WAI!","XXDXDXDXDXDXDXDXDXDXDXDXDXDXDXD","LOLOLOLOLOLOLOLOLOLOLOLOLOLOLO",\
	"wtf?","what the fuck is going on?","is this some kind of joke?","STOP SPAMMING THE SERVER YOU \
	DICK","?","DOWN WITH THE POWER ARCH IS AN ASSHOLE DOWN WITH ARCH \
	FIGHT THE CORRUPTION WE CAN OVERTHROW THE CORRUPT OWNER SE BELONGS TO US","SHUT THE FACK UP \
	YOU FACKING MOROONS","GUYS FOR REAL STOP SPAMMING JEEZ","i fucked yer mom",\
	"why the fack is this happening","GUYS IM A FAG XD!!#%#$%^","This server has gone crazy <_<",\
	"o_O?","O_o?","XD","=DDDDDD",">_<","<_<","<_<>_>","WANKS STFU","YOU STFU","NO U","FUK U",\
	"wank","im h4x1ng d srber LOL","CAN I HAVE GM PLZ?","GIMME GM","DIS GAM SUX",\
	"guys dis is a rp gam u shudnt b doin dis","NIGGA CUCK W4ORE BITCH FACK PUSS","ASS  CUCK CONT \
	W4ORE FAG BITCH WAG CUCK","GUYS I JUST SHIT MYSELF",\
	"wtf is the internet?!?!?!","SOME1 TEL ME WUT IS RP????","I DEMAND ADMIN RIGHT NOW.","UNRP KILL!",\
	"SPAMSPAMSPAMSPAMSPAMASMPASPMASMPASPMASMPASPMASMPASPMASM","BAN HIM",\
	"BAAAAAANNNNNNNN!!!","U CHEETED I NO U CHEETED U SUMBITCH","The fucks, ju gaiz is noobs",\
	"Y U UNRP STEL ME?","Where are the PBags","WUT PL 4 SSJ??","300K U STUPED","DIS IS A RIP OF A COW \
	OF UR BALS N U R GAY","Y IS DER NO SUPER SAYIEN 5 IN DIS GAM?",\
	"GUYS I JUS HERD OF DAY R MAKIN DBAF 4 REELZ NAO","DBAF IS FAKE U NUB","nu, ur mom!!",\
	"wtf? ur mom!","NOBODY CARES STFU","I BEN PLEYEN 4 5 SEXUNDS N I STIL DUNT HABS SUPUR SEIYEN 5?!?!?!?!1? \
	OMFG \
	DIS GAM IS SO GAY U DUNT GO SS IN 5 SEKENS WTF IS DAT?","NO U, U STFU","NOOOOOOOOOOBSSSSS",\
	"U R ALL NOOOOOOOOOOBSSSS","CAN I HAVE GM?","Y CANT I LOG IN 2 DA GAM?",\
	"IS DIS ERF?","WHY ARE YOU PRICKS SPAMMING THE GAME?","cuz ur gayLOL","*explodes again*","OMFG ITS PEDOBEAR!",\
	"GAIZ HABS U HERD DAT IF U LOOK N D MIRROR 3 TIEMS N SAY \
	BLUDDY MARRY DEN SHE WIL CUM OUT N KILL UUUUUUUUUUUUU?!?!?!?!? OMFGGGGG IM SKEERD","weeeeeeeeee!",\
	"IM DOCTA ROXO BABEH, AN I DO COCAAINE!!!","*whispers* hay....i do cocayaaane <_<","DA RAPTURE IZ \
	CUMMIN","I GOT RAEPD","SKIttLEBUGZ!!!11!!","fuk dis i m goin 2 pley heros unated","me 2",\
	"There is no 'ctrl' button on Chuck Norris's computer. Chuck Norris is always in control.",\
	"Chuck Norris destroyed the periodic table, because he only recognizes the element of surprise.",\
	"There is no chin under Chuck Norris' Beard. There is only another fist.",\
	"Chuck Norris once roundhouse kicked someone so hard that his foot broke the speed of light, went \
	back in time, and killed Amelia Earhart while she was flying over the Pacific Ocean.",\
	"Crop circles are Chuck Norris' way of telling the world that sometimes corn needs to lie down.",\
	"The Great Wall of China was originally created to keep Chuck Norris out. It failed miserably.",\
	"If you ask Chuck Norris what time it is, he always says, 'Two seconds til. After you ask, \
	'Two seconds til what?' he roundhouse kicks you in the face.",\
	"Chuck Norris can win a game of Connect Four in only three moves.",\
	"If you spell Chuck Norris in Scrabble, you win. Forever.",\
	"Chuck Norris originally appeared in the 'Street Fighter II' video game, but was removed by \
	Beta Testers because every button caused him to do a roundhouse kick. When asked bout this \
	'glitch,' Norris replied, 'That's no glitch.'",\
	"The opening scene of the movie 'Saving Private Ryan' is loosely based on games of \
	dodgeball Chuck Norris played in second grade.",\
	"Someone once tried to tell Chuck Norris that roundhouse kicks aren't the best way to kick someone. \
	This has been recorded by historians as the worst mistake anyone has ever made.",\
	"Teenage Mutant Ninja Turtles is based on a true story: Chuck Norris once swallowed a turtle whole, \
	and when he crapped it out, the turtle was six feet tall and had learned karate.",\
	"Chuck Norris discovered a new theory of relativity involving multiple universes in which Chuck \
	Norris is even more badass than in this one. When it was discovered by Albert Einstein and made \
	public, Chuck Norris roundhouse-kicked him in the face. We know Albert Einstein today as Stephen \
	Hawking.","There are no steroids in baseball. Just players Chuck Norris has breathed on.",\
	"When Chuck Norris falls in water, Chuck Norris doesn't get wet. Water gets Chuck Norris.",\
	"Some people like to eat frogs' legs. Chuck Norris likes to eat lizard legs. Hence, snakes.",\
	"How much wood would a woodchuck chuck if a woodchuck could Chuck Norris? ...All of it.",\
	"Chuck Norris CAN divide by zero.","U STOLD MY GRAVY","Y U STOLD MY GRAVY?","I NO CHEET WUT R U \
	TLKN ABOT?","lol what?","Cool story bro.","Riveting tale comrade!","IM GAY","#hottiesfortrump","y tho","could u fucking not" ,
	"spicy","wew lad","I would hate to live in Australia","the rarest of pepes","JOHN CENNNNNNNNNNNNNNNNNNNNNNNNNNNNA","Bernie says no refunds guis what do we do nao",
	"I heard spongebob is based on the 7 deadly sins","such salt, many salines, much brines","jarl ballin'")