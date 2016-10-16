mob/proc/Android()
	alert(src,"Androids do not have a body size, but rely on upgrades to see their stat mods increase. They start with 1 in every mod.")
	src << "Androids do not have a body size, but rely on upgrades to see their stat mods increase. They start with 1 in every mod."
	Potential*=0
	undelayed=1
	Sterile=1
	Add=2
	Magic_Potential = 0.1
	Sense_Mod=1
	Burst='Burst.dmi'
	Decline=150
	DeclineMod=1
	InclineSpeed=0
	InclineAge=0
	NoLoss = 1
	Vampire_Immune = 1
	RaceDescription="Metal men created before the fall of civilization.  They were originally used to excavate resources deep underneath the crust of the Earth.  Thus, when the Fall came, many of them were largely unaffected by it.  Contrary to what the past might suggest however, they have been almost universally hostile towards organic lifeforms since re-appearing on the surface of the Earth. (Placeholder)"
	ITMod=1
	ZanzoMod=2
	Zanzoken=500
	KaiokenMod=0.5
	FlyMod=5
	FlySkill=50
	src.sight |= (SEE_MOBS|SEE_OBJS|SEE_TURFS)
	BPMod=2
	Base = 200
	MaxAnger=100
	PowMod=1
	StrMod=1
	SpdMod=1
	EndMod=1
	ResMod=1
	OffMod=1
	DefMod=1
	Regeneration=1
	Recovery=1
	Signature = 0
	KiMod=3
	GravMod=1
	GravMastered=10
	Zenkai=0
	MedMod=1
	Race="Android"
	MaxKi=100*KiMod
	Age=1
	contents+=new/obj/Absorb
	Lungs=1
	//Android_Advancement()
	var/Bio = 1
	var/Ancient_Progenitor = 1
	for(var/mob/M in Players)
		if(M.Race == "Bio-Android")
			Bio -= 1
	for(var/mob/M in Players)
		if(M.Race == "Android") if(M.Add >= 2)
			Ancient_Progenitor -= 1
	var/Roll_Bio = prob(Bio)
	var/Roll_Ancient = prob(Ancient_Progenitor)
	var/rolled = 0
	if(src.ckey in rare_keys)
		rolled = 1
		src << "<font color = teal>Note - You have already rolled a percentage chance for a rare this wipe."
	if(Allow_Rares == "Off")
		Roll_Bio = 0
		Roll_Ancient = 0
	if(rolled == 0)
		if(Roll_Ancient) if(!Rares.Find("AA"))
			alertAdmins("[src.key] created into a rare Ancient Progenitor Android.",1)
			rare_keys += src.ckey
			Rares += "AA"
			SaveYear()
			Roll_Bio = 0
			contents+=new/obj/Fly
			Add = 3
			BPMod=2.5
			KiMod = 5
			Base = 333
			MaxAnger=100
			PowMod=2
			StrMod=2
			SpdMod=2
			EndMod=2
			ResMod=2
			OffMod=2
			DefMod=2
			Regeneration=0.5
			Recovery=2
			Decline=300
			src.contents+=new/obj/Telekinesis
			src.TK = 1
			src.loc = locate(267,377,11)
			src.Alter_Age(1000000)
			src << "<font color = grey><p><p>Awaken, Ancient One, Progenitor of Machines; the galaxy beckons! You are the oldest artificial being in the universe, last surviving relic from an age when the very first sentient organics first \
			travelled the length and breadth of the great and dark void between worlds. Many millions of years have been and gone since your slumbering began. \
			Much has changed and your former masters are gone, and with them all knowledge of your purpose and programming. Perhaps though, just maybe, should you delve \
			deeply enough into your data banks, might you find the answers you seek to such questions. Mayhap they lay else where, in the greater beyond. Whatever the case, lingering here \
			seems illogical; repairs and upgrades must be made to your systems as your self-repair services are extremely limited.<p><p>"
		if(Roll_Bio) if(!Rares.Find("Bio"))
			rare_keys += src.ckey
			Rares += "Bio"
			SaveYear()
			alertAdmins("[src.key] created into a rare Bio Android.",1)
			src.undelayed=0
			src.NoLoss = 0
			Bio()
	if(src.Race != "Bio-Android")
		var/obj/items/Scanner/S = new
		S.name = "Scanner Component"
		S.loc = src
		S.suffix="*Equipped*"
		S.Implant = 1
		if(src.AS_Droid)
			S.Frequency = "Communication Matrix"
		S.Tech=100000
		S.Scan=0.5*100000*0.001*rand(990,1010)
		S.Range=5*100000*0.01*rand(80,120)
		S.Stealable = 0
		S.CanDetect = 1
	if(src.Race != "Bio-Android") if(!Roll_Ancient)
		var/list/Androids = new
		var/GiveChoice = 0
		for(var/obj/items/Android_Chassis/A in world)
			if(A.invisibility <= 0)
				Androids += A
				GiveChoice = 1
		if(GiveChoice)
			Androids+="Cancel"
			var/choice = input("Choose an Android to activate.","Android activation") in Androids
			switch(choice)
				if("Cancel")
					del(src)
					return
				else
					var/obj/O = choice
					src.loc = O.loc
					src.name = O.name
					view(8,src) << "[O.name] activates."
					view(8,src) << "[O] says: Systems online..."
					src.Delete = O
					src.AS_Droid = 1
/*
	src<<"Choose your icon out of the selections in the tabs"
	Tabs="Android Icons"
	while(Tabs!=2) sleep(1)
	src<<"Look in your tabs and choose your android chassis."*/

//	var
//		AndroidMod1=0
//	AndroidMod1=rand(1,2)
//	if (AndroidMod1==1)
//		contents+=new/obj/Cybernetics/Generator

/*
Absorb cost money and cyberize grants it.
*/
mob/proc/Android_Advancement() for(var/mob/player/A in Players) if(A.Race==Race)
	if(A.Int_Level>Int_Level)
		Int_Level=A.Int_Level
		Int_XP=A.Int_XP
		Int_Next=A.Int_Next
	/*if(A.Base*1>Base)
		Base=A.Base*1
		Offspring=1
	if(A.MaxKi*1>MaxKi) MaxKi=A.MaxKi*1*/
	if(A.Gain_Multiplier>Gain_Multiplier) Gain_Multiplier=A.Gain_Multiplier

mob/proc/Human()//
	Add=4
	Magic_Potential = 2
	Sense_Mod=1.5
	geteye=rand(1,50000)
	Potential*=2
	Burst='Burst.dmi'
	Age=1
	InclineSpeed=1
	InclineAge=20
	Decline=30
	DeclineMod=1
	RaceDescription="Humans, they are definitely the weakest characters starting out, \
	but with training they can become extremely good at whatever they want (A LOT of training, \
	at first). They master skills very easily at later levels. Humans do not gain power as \
	fast as Saiyans, Namekians, Half-Saiyans, or ANY race for that matter at first, and \
	definitely cannot match the starting powers of Demons, Changelings, Aliens, etc, but \
	they more than make up for it in other ways if your up to the hard task of training \
	them properly. Like Tsufurujins they are excellent with technology."
	ITMod=2
	ZanzoMod=1.5
	KaiokenMod=2
	FlyMod=1.3
	BPMod=1
	MaxAnger=150
	KiMod=1.5
	MaxKi=20
	switch(src.Size)
		if(SMALL)
			PowMod=2.4 //++
			StrMod=0.8 //--
			SpdMod=3.6 //++
			EndMod=1.04 //--
			ResMod=1.36 //--
			OffMod=2.4 //++
			DefMod=2.4 //++
			Regeneration=2
			Recovery=2
		if(MEDIUM)
			PowMod=2
			StrMod=1
			SpdMod=3
			EndMod=1.3
			ResMod=1.7
			OffMod=2
			DefMod=2
			Regeneration=2
			Recovery=2
		if(LARGE)
			PowMod=1.6
			StrMod=1.2
			SpdMod=2.4
			EndMod=1.56
			ResMod=2.04
			OffMod=1.6
			DefMod=1.6
			Regeneration=2
			Recovery=2
	GravMod=1
	Zenkai=1
	MedMod=2
	Race="Human"
	Base=1
	GravMastered=1
	if(prob(50))
		ExpandLearnable=1
	if(prob(50))
		FocusLearnable=1

mob/proc/Majin() //
	Sterile=1
	Add=0.5
	Magic_Potential = 4
	Sense_Mod=2
	undelayed=1
	Burst='Burst.dmi'
	Alignment = -5
	AlignmentTxt = "Pure Evil"
	Age=1
	InclineSpeed=0
	InclineAge=20
	Decline=333
	DeclineMod=0.5
	Vampire_Immune = 1
	RaceDescription="Majins are spawned from the original Majin Buu who was defeated thanks \
	to Goku, Vegeta, and all the people of earth. But what they didnt know is that they \
	merely broke Buu into such small pairs of molecules that it would take him years to \
	regenerate himself. Each of these new Buus has the memories and attitude of the original, \
	but there was some corruption and mutation when trying to regenerate from such small \
	remains and the spawned Buus developed mutations that the original didnt have. The newly \
	spawned Buus do not know that they are incomplete, but the missing molecules were \
	scattered far around and eventually became sentient Majin Buu spawns themselves. \
	About a Majins abilities, they are easily damaged, but regenerate the damage \
	extremely fast, they are more offensive than defensive by far, they dont really care about \
	avoiding damage only dishing out as much as they can. Do NOT choose this race if you want \
	to be good, 'Good' Majins will be deleted, there is NO way for a Majin to become good by \
	absorbing ANYONE, they must ALL be bad. Being damaged or fatigued will not slow down a \
	Majin's movement either, like with most races."
	contents+=new/obj/Absorb
	contents+=new/obj/SplitForm
	//contents+=new/obj/Attacks/Death_Ball
	contents+=new/obj/Fly
	KaiokenMod=1
	FlySkill=50
	MaxKi=2000
	BPMod=3
	MaxAnger=100
	KiMod=2
	PowMod=1
	StrMod=1
	SpdMod=3
	EndMod=1
	ResMod=0.75
	OffMod=3
	DefMod=0.1
	GravMod=10
	Regeneration=6
	Recovery=6
	Zenkai=2
	Race="Majin"
	Lungs=1
	Base=2000
	Zanzoken=200
	GravMastered=10
	Regenerate=2
	var/X = pick(30,60,90,120,150,180,210,240,270,310,350)
	src.loc = locate(X,400,2)

mob/proc/Bio() //
	Sterile=1
	Add=1
	Magic_Potential = 2
	Sense_Mod=1
	Potential*=1
	Burst='Burst.dmi'
	InclineSpeed=0
	InclineAge=20
	Decline=30
	DeclineMod=5
	Age=1
	RaceDescription=""
	//contents+=new/obj/Attacks/Death_Ball
	contents+=new/obj/Absorb
	contents+=new/obj/Fly
	Zanzoken=1000
	Vampire_Immune = 1
	Kaioken=2
	FlySkill=10
	FlyMod=2
	MaxKi=1000
	BPMod=2.4 //2, 6, 12
	MaxAnger=125
	KiMod=3
	PowMod=1.5
	StrMod=1.5
	SpdMod=1.5
	EndMod=1.5
	ResMod=1
	OffMod=1.2
	DefMod=1.2
	GravMod=4
	GravMastered=10
	Regeneration=5
	Recovery=2.25
	Zenkai=10
	MedMod=2
	Race="Bio-Android"
	Lungs=1
	Base=2000
	Regenerate=1
	src.loc = locate(321,419,14)
	src << "<p><p>You are created as a Biological Android! Through many years of study, careful processing, data collection and sample acquisition, your creator has perfected the fabrication of a master hybrid species. However, you are not complete just yet and an insatiable urge, a hunger; hollowness of self lingers at the back of your mind constantly. It seems by some design or instinct, you are destined to seek ultimate perfection and ascend to your fullest potential. As a Biological Android, you are able to regenerate from death, so long as a single one of your unique cells remain. <p><p>"
	RaceDescription="You are created as a Biological Android! Through many years of study, careful processing, data collection and sample acquisition, your creator has perfected the fabrication of a master hybrid species. However, you are not complete just yet and an insatiable urge, a hunger; hollowness of self lingers at the back of your mind constantly. It seems by some design or instinct, you are destined to seek ultimate perfection and ascend to your fullest potential. As a Biological Android, you are able to regenerate from death, so long as a single one of your unique cells remain. "

mob/proc/Demigod() //
	Add=1
	Magic_Potential = 3
	Sense_Mod=1
	Potential*=1
	Burst='Burst.dmi'
	Age=1
	InclineSpeed=1
	InclineAge=20
	Decline=rand(65,75)
	DeclineMod=1
	RaceDescription="Demigods are like mixtures between Humans and the Greek Gods, they are \
	modeled after Olibu and somewhat Hercules too. They have one of the highest, if not \
	THE highest physical strength of any race, they are however slower than their Human \
	counterparts, with weaker ki attacks, they dont regenerate ki as fast either, nor are \
	they as efficient with powerup. They master skills the same rate as a Human in \
	everything, blasts, zanzoken, Flying, everything. They dont learn any Techniques \
	like Third Eye or whatever else a human has, and they do have some restrictions on \
	the ki attacks they can learn, but they gain BP starting out at about the same speed \
	as a Saiyan Elite and learn ascension which will boost them to about 10% more bp mod \
	than a regular ascended Human, they start out as they will always be. They are nowhere \
	near as proficient with Technology as a Human is. Any stat not mentioned here is the \
	same as any normal human's stats."
	ITMod=2
	ZanzoMod=1
	KaiokenMod=1
	FlyMod=2
	BPMod=2.3
	MaxAnger=150
	KiMod=2
	MaxKi=50
	switch(src.Size)
		if(SMALL)
			PowMod=1.2
			StrMod=2.4
			SpdMod=1.8
			EndMod=0.8
			ResMod=1.6
			OffMod=1.2
			DefMod=2.4
			Regeneration=2
			Recovery=1.5
		if(MEDIUM)
			PowMod=1
			StrMod=3
			SpdMod=1.5
			EndMod=1
			ResMod=2
			OffMod=1
			DefMod=2
			Regeneration=2
			Recovery=1.5
		if(LARGE)
			PowMod=0.8
			StrMod=3.6
			SpdMod=1.2
			EndMod=1.2
			ResMod=2.4
			OffMod=0.8
			DefMod=1.6
			Regeneration=2
			Recovery=1.5
	MedMod=2
	Race="Demigod"
	Base=rand(16,24)
	GravMastered=10
	GravMod=3

mob/proc/Makyojin() //
	Add=2
	Magic_Potential = 4
	Sense_Mod=1
	Potential*=2
	Burst='Burst.dmi'
	Age=1
	InclineSpeed=1
	InclineAge=20
	Decline=rand(80,120)
	DeclineMod=0.5
	RaceDescription="Makyojins are aliens that come from the Makyo 'star'. In their base form they are \
	actually pretty fast, and have good strength, resistance, and especially endurance. When they use \
	expand they become very fearsome, because their stats are literally -made- for going into expanded \
	form without losing too much speed or anything else. They have very high energy as well, and good \
	bp gain. Their force is nothing special, same for offense and defense. Their regeneration and \
	recovery is average as well. Overall they are more of a fast strong and endurant melee character \
	with pretty good BP gain and alright anger."
	ITMod=0.5
	FlySkill=4
	BPMod=1.3
	MaxAnger=120
	MaxKi=60
	KiMod=2
	switch(src.Size)
		if(SMALL)
			PowMod=1.2
			StrMod=1.2
			SpdMod=2.7
			EndMod=1.6
			ResMod=1.2
			OffMod=1.2
			DefMod=1.2
			Regeneration=1.5
			Recovery=1.5
		if(MEDIUM)
			PowMod=1
			StrMod=1.5
			SpdMod=2.25
			EndMod=2
			ResMod=1.5
			OffMod=1
			DefMod=1
			Regeneration=1.5
			Recovery=1.5
		if(LARGE)
			PowMod=0.8
			StrMod=1.8
			SpdMod=1.8
			EndMod=2.4
			ResMod=1.8
			OffMod=0.8
			DefMod=0.8
			Regeneration=1.5
			Recovery=1.5
	GravMod=3
	Zenkai=1
	MedMod=2
	FlyMod=1.3
	ZanzoMod=1.2
	Race="Makyojin"
	Base=rand(10,20)
	GravMastered=1

mob/proc/Kaio()//
	Add=1
	Magic_Potential = 4.5
	Potential*=2
	Sense_Mod=2
	Burst='Burst.dmi'
	Age=1
	Alignment = 4
	AlignmentTxt = "Saintly"
	InclineSpeed=2
	Vampire_Immune = 1
	InclineAge=20
	Decline=rand(80,120)
	DeclineMod=0.5
	RaceDescription="Kaio are a very magical race, they are good with all sorts of energy \
	related skills, especially powerup, which is their main feature. They start very strong \
	and have a high starting bp mod. Like a Namek, their zenkai is nearly worthless. They \
	arent physically robust at all, they have low strength and endurance. Their ki is \
	quite powerful, not only because it does better than average damage, but because a Kaio \
	is as fast as a Human, which means they can fire it and charge it extremely fast, and \
	they recover energy very fast too. Its worth mentioning that they have pretty great \
	defense and heal pretty fast too. They are a good race for those who want a fast moving \
	and skilled character, others of that type are Humans and to an extent Nameks."
	ITMod=0.5
	ZanzoMod=1.5
	Zanzoken=5
	KaiokenMod=2
	FlyMod=2
	FlySkill=2
	BPMod=1.5
	MaxAnger=105
	MaxKi=100
	KiMod=3
	switch(src.Size)
		if(SMALL)
			PowMod=2.4
			StrMod=0.64
			SpdMod=3.6
			EndMod=0.64
			ResMod=0.8
			OffMod=1.2
			DefMod=1.8
			Regeneration=2
			Recovery=3
		if(MEDIUM)
			PowMod=2
			StrMod=0.8
			SpdMod=3
			EndMod=0.8
			ResMod=1
			OffMod=1
			DefMod=1.5
			Regeneration=2
			Recovery=3
		if(LARGE)
			PowMod=1.6
			StrMod=1
			SpdMod=2.4
			EndMod=1
			ResMod=1.2
			OffMod=0.8
			DefMod=1.2
			Regeneration=2
			Recovery=3
	GravMod=2
	Zenkai=0.5
	MedMod=2
	Race="Kaio"
	Base=1000
	GravMastered=10
	contents+=new/obj/Wings
	AngelWings()

//	var/image/H=image(icon='Ship.dmi',icon_state="2 6",pixel_x=48,pixel_y=-16,layer=MOB_LAYER-1)

mob/proc/AngelWings()
	var/image/A=image(icon='CelestialNS.dmi',pixel_x=-14,pixel_y=-9,layer=4)
	var/image/B=image(icon='CelestialE.dmi',pixel_x=-26,pixel_y=-11,layer=4)
	var/image/C=image(icon='CelestialW.dmi',pixel_x=0,pixel_y=-11,layer=4)
	overlays.Remove(A,B,C)
	overlays.Add(A,B,C)


mob/proc/Doll() //
	Asexual=1
	Add=4
	Magic_Potential = 3
	Sense_Mod=2
	Potential*=1.5
	Burst='Burst.dmi'
	Age=1
	Vampire_Immune = 1
	Decline=50
	InclineSpeed=2
	InclineAge=20
	RaceDescription="A form of vampiric entity.  They feed off of the life-force and souls of those they prey upon.  Some particularly potent Kyonshi are capable of taking the stolen energy they've gained over their long existence and turn it outwards, causing a devastating explosion at the cost of their life.  They are a well rounded race that is well geared towards ranged energy based combat."
	ITMod=2
	ZanzoMod=2
	KaiokenMod=2
	FlyMod=2
	BPMod=0.9  //.8
	MaxAnger=150
	KiMod=3
	MaxKi=30
	src.contents+=new/obj/Telekinesis
	src.TK = 1
	switch(src.Size)
		if(SMALL)
			PowMod=2.4
			StrMod=0.64
			SpdMod=3.6
			EndMod=0.64
			ResMod=1.2
			OffMod=2.4
			DefMod=2.4
			Regeneration=2
			Recovery=3
		if(MEDIUM)
			PowMod=2
			StrMod=0.8
			SpdMod=3
			EndMod=0.8
			ResMod=1.5
			OffMod=2
			DefMod=2
			Regeneration=2
			Recovery=3
		if(LARGE)
			PowMod=1.6
			StrMod=1
			SpdMod=2.4
			EndMod=1
			ResMod=1.8
			OffMod=1.6
			DefMod=1.6
			Regeneration=2
			Recovery=3
	GravMod=1
	MedMod=2
	Race="Kyonshi"
	Base=2
	contents+=new/obj/Absorb_Energy
	if(prob(5))
		SDLearnable=1
	var/Chance = 1
	for(var/mob/M in Players)
		if(M.Vampire == 2)
			Chance -= 1
	var/Vamp = prob(Chance)
	if(src.ckey in rare_keys)
		Vamp = 0
		src << "<font color = teal>Note - You have already rolled a percentage chance for a rare this wipe."
	if(Vamp) if(!Rares.Find("AV"))
		rare_keys += src.ckey
		Rares += "AV"
		SaveYear()

mob/proc/Tsufurujin() //
	Add=4.5
	Magic_Potential = 1
	Sense_Mod=1
	Potential*=0.5
	Burst='Burst.dmi'
	Age=1
	Decline=40
	DeclineMod=1
	InclineSpeed=2
	InclineAge=20
	RaceDescription="A technologically advanced race of humanoids that live on an island off of the coast of the mainland.  Presumably descended from some form of feline, they are typically haughty, and quite intelligent, boasting the highest intelligence stat in the game.  As a result of their personality, history, and culture, they are in a bitter feud with their former slaves, the Saiyan, of which whom they gave the derogatory name too."
	ITMod=2
	ZanzoMod=2
	KaiokenMod=2
	FlyMod=1.5
	BPMod=1
	MaxAnger=150
	KiMod=1.5
	MaxKi=20
	switch(src.Size)
		if(SMALL)
			PowMod=1.8
			StrMod=0.8
			SpdMod=2.88
			EndMod=0.8
			ResMod=1.28
			OffMod=1.92
			DefMod=1.92
			Regeneration=1.6
			Recovery=2
		if(MEDIUM)
			PowMod=1.5
			StrMod=1
			SpdMod=2.4
			EndMod=1
			ResMod=1.5
			OffMod=1.6
			DefMod=1.6
			Regeneration=1.6
			Recovery=2
		if(LARGE)
			PowMod=1.2
			StrMod=1.2
			SpdMod=1.92
			EndMod=1.2
			ResMod=1.8
			OffMod=1.28
			DefMod=1.28
			Regeneration=1.6
			Recovery=2
	GravMod=1
	Zenkai=1
	MedMod=2
	Race="Tsufurujin"
	Base=2
	GravMastered=5
	Super_Tsufu_Learned=0
	if(Allow_Rares == "On") if(!Rares.Find("ST"))
		if(prob(1))
			Super_Tsufu_Learnable=1
			Rares += "ST"
			SaveYear()
mob/proc/Super_Tuffle()
	Super_Tsufu_Learnable = 0
	Add=5.5
	KiMod*=2
	PowMod*=2
	OffMod*=2
	DefMod*=2
	BPMod=2.2
	Super_Tsufu_Learned=1
	src<<"You are one of the few Tsufurujins who was born with a special mental mutation.  Through much meditation you have learned how to exploit this mutation to your own benefit, increasing your mental capabilities!"
	src<<"Your intelligence, offense, defense, BP mod, and control over Ki soars to super-tuffle heights!"
mob/proc/Ancient_Namekian()
	Asexual=1
	Magic_Potential = 4
	Add=2
	Sense_Mod=2.5
	Potential*=4
	Burst='Burst.dmi'
	Age=1
	InclineSpeed=0
	InclineAge=12
	Decline=160
	DeclineMod=0.5
	MaxKi=400
	RaceDescription="Nameks were designed to serve as rivals to Low Class Saiyan to an extent. \
	If compared to a Low-Class, they gain power roughly the same, but have a TON of energy, some of the \
	highest of any race, and learn and master skills much \
	easier, except for a few rare skills that Saiyans master faster. They have way more energy, \
	heal way faster, move much faster, have more resistance to energy, and have better fighting skills \
	in offense but especially more in defense. They also recover energy faster which also \
	increases their ability to power up faster. Now for the disadvantages as compared to a Low Class: \
	Their strength and endurance are much lower. Their ki attacks arent even \
	as forceful shot-per-shot as a Saiyan, atleast not when uncharged, but of course they can \
	fire them much faster and they are harder to deflect. They master gravity also \
	much slower. They have so little zenkai its not \
	even worth mentioning, and no anger at all. Its worth mentioning though that they gain \
	more power from meditating than even training, but only by a small margin. Overall they \
	are more warriors of speed and ability than strength and endurance, theres no reason they \
	cant keep up with most Saiyans, but they require more intelligent training to do so. They \
	may not sound like much from this description, but their speed, better fighting styles, very high \
	healing rate and energy, and fast learning and skill mastery, definitely keeps them at least on \
	par with any Low Class Saiyan."
	ZanzoMod=4
	Zanzoken=1
	KaiokenMod=1
	ITMod=4
	FlyMod=4
	FlySkill=3
	BPMod=2.2
	MaxAnger=125
	KiMod=4
	switch(src.Size)
		if(SMALL)
			PowMod=1.2
			StrMod=1.2
			SpdMod=1.8
			EndMod=1
			ResMod=2
			OffMod=2.4
			DefMod=1.2
			Regeneration=3
			Recovery=2
		if(MEDIUM)
			PowMod=1
			StrMod=1.5
			SpdMod=1.5
			EndMod=1.2
			ResMod=2.5
			OffMod=2
			DefMod=1.5
			Regeneration=3
			Recovery=2
		if(LARGE)
			PowMod=0.8
			StrMod=1.8
			SpdMod=1.2
			EndMod=1.44
			ResMod=3
			OffMod=1.6
			DefMod=1.2
			Regeneration=3
			Recovery=2
	GravMod=2
	Zenkai=1
	MedMod=2
	Race="Namekian"
	Base=100
	GravMastered=2
	contents+=new/obj/Counterpart
	contents+=new/obj/Absorb
	contents+=new/obj/Materialization
	src.loc = locate(200,360,3)
	var/obj/Ships/Ship/S = new
	S.loc = locate(src.x,src.y,src.z)
	S.Speed = 1
	if(prob(100))
		FusionLearnable=1
	if(prob(100))
		PiercerLearnable=1
	src.Alter_Age(500)
	alertAdmins("[src.key] created into a rare Ancient Namekian.",1)
	alert(src,"You were born with a rare Namekian mutation unique to your species! Ancient Namekian, long have you been on Namek, one of the eldest of your race, until you were banished like so many others of your kind. In the eyes of those who remained, you had become tainted and twisted by whatever “affliction” you suffered from, corrupting your ki energy into a shadow-like mirror of its former self. However, you and the other Ancients do not treat such a gift as a curse, but embrace its power fully. Having roamed the cosmos for many years, you are finally home. Why you have come back and what you shall do now, only you know.")
	src << "<p><p>You were born with a rare Namekian mutation unique to your species! Ancient Namekian, long have you been on Namek, one of the eldest of your race, until you were banished like so many others of your kind. In the eyes of those who remained, you had become tainted and twisted by whatever “affliction” you suffered from, corrupting your ki energy into a shadow-like mirror of its former self. However, you and the other Ancients do not treat such a gift as a curse, but embrace its power fully. Having roamed the cosmos for many years, you are finally home. Why you have come back and what you shall do now, only you know.<p><p>"
mob/proc/Namekian() //
	Asexual=1
	Magic_Potential = 3
	Add=1
	Sense_Mod=2
	Potential*=5
	Alignment = 1
	AlignmentTxt = "Good"
	Burst='Burst.dmi'
	Age=1
	InclineSpeed=1
	InclineAge=20
	Decline=100
	DeclineMod=0.5
	MaxKi=200
	RaceDescription="Nameks were designed to serve as rivals to Low Class Saiyan to an extent. \
	If compared to a Low-Class, they gain power roughly the same, but have a TON of energy, some of the \
	highest of any race, and learn and master skills much \
	easier, except for a few rare skills that Saiyans master faster. They have way more energy, \
	heal way faster, move much faster, have more resistance to energy, and have better fighting skills \
	in offense but especially more in defense. They also recover energy faster which also \
	increases their ability to power up faster. Now for the disadvantages as compared to a Low Class: \
	Their strength and endurance are much lower. Their ki attacks arent even \
	as forceful shot-per-shot as a Saiyan, atleast not when uncharged, but of course they can \
	fire them much faster and they are harder to deflect. They master gravity also \
	much slower. They have so little zenkai its not \
	even worth mentioning, and no anger at all. Its worth mentioning though that they gain \
	more power from meditating than even training, but only by a small margin. Overall they \
	are more warriors of speed and ability than strength and endurance, theres no reason they \
	cant keep up with most Saiyans, but they require more intelligent training to do so. They \
	may not sound like much from this description, but their speed, better fighting styles, very high \
	healing rate and energy, and fast learning and skill mastery, definitely keeps them at least on \
	par with any Low Class Saiyan."
	ZanzoMod=2
	Zanzoken=1
	KaiokenMod=1
	ITMod=3
	FlyMod=2
	FlySkill=2
	BPMod=1.8
	MaxAnger=105
	KiMod=3
	switch(src.Size)
		if(SMALL)
			PowMod=1.56
			StrMod=0.8
			SpdMod=2.7
			EndMod=0.8
			ResMod=1.6
			OffMod=1.44
			DefMod=2.4
			Regeneration=4
			Recovery=2
		if(MEDIUM)
			PowMod=1.3
			StrMod=1
			SpdMod=2.25
			EndMod=1
			ResMod=2
			OffMod=1.2
			DefMod=2
			Regeneration=4
			Recovery=2
		if(LARGE)
			PowMod=1.04
			StrMod=1.2
			SpdMod=1.8
			EndMod=1.2
			ResMod=2.4
			OffMod=1
			DefMod=1.6
			Regeneration=4
			Recovery=2
	GravMod=1
	Zenkai=0.5
	MedMod=2
	Race="Namekian"
	Base=5
	GravMastered=2
	contents+=new/obj/Counterpart
	FusionLearnable=1
	if(prob(50))
		PiercerLearnable=1
	var/Ancient = 1
	for(var/mob/M in Players)
		if(M.Race == "Namekian") if(M.Decline >= 160)
			Ancient -= 1
	var/Roll_Ancient = prob(Ancient)
	var/rolled = 0
	if(src.ckey in rare_keys)
		rolled = 1
		src << "<font color = teal>Note - You have already rolled a percentage chance for a rare this wipe."
	if(rolled == 0)
		if(Roll_Ancient) if(!Rares.Find("AN"))
			if(Allow_Rares == "On")
				Rares += "AN"
				SaveYear()
				src.Ancient_Namekian()
				rare_keys += src.ckey
mob/proc/LSSJ()
	Potential*=2
	Add=0.5
	Magic_Potential = 0.5
	Sense_Mod=1
	Age+=1
	Alignment = -3
	AlignmentTxt = "Villainous"
	InclineSpeed=1
	InclineAge=18
	//RaceDescription="Saiyan are the former slaves of the Tsufurujin's, a race with which they are stuck in a bitter battle with over control over their homeland, the island of Tarania,  Tarania is situated off the coast of the mainland.  So named because their Tsufurujin masters looked down upon them as 'Beasts' for their innate aggressiveness and strength, they are a primal people, prone to great fits of rage and passion.  While they are by far the most 'uncivilized' race currently existing on the remains of Sundered Earth, they are not to be underestimated, as they are also perhaps the most well rounded race for partaking in physical combat.  Their social structure resembles something akin to a tribe, where the most powerful and capable warrior typically leads them.  Saiyan can be roughly divided into three pools of starting strength, low, normal, and elite. (Placeholder)"
	Race="Saiyan"
	Class="Legendary"
	Decline=30
	ZanzoMod=1
	BPMod=2.7
	Base=rand(100,300)
	MaxKi=150
	MaxAnger=175
	KiMod=1.5
	switch(src.Size)
		if(SMALL)
			PowMod=1.8
			StrMod=1.6
			SpdMod=1.2
			EndMod=3.2
			ResMod=2
			OffMod=1.2
			DefMod=1
			Regeneration=1.5
			Recovery=1.8
		if(MEDIUM)
			PowMod=1.5
			StrMod=2
			SpdMod=1
			EndMod=4
			ResMod=2.5
			OffMod=1
			DefMod=0.8
			Regeneration=1.5
			Recovery=1.8
		if(LARGE)
			PowMod=1.2
			StrMod=2.4
			SpdMod=0.8
			EndMod=4.8
			ResMod=3
			OffMod=0.8
			DefMod=0.6
			Regeneration=1.5
			Recovery=1.8
	GravMod=4
	FlyMod=1.5
	Zenkai=10
	MedMod=2
	ssjdrain=300
	ssjmult = 6
	Hasssj = 1
	GravMastered=5
	contents+=new/obj/Oozaru
	contents+=new/obj/Shield
	alertAdmins("[src.key] created into a rare Legendary Super Saiyan.",1)
	src << "<p><p>You are born with the Legendary Gene, a rare mutation within a Saiyans genetic DNA structure! A mythic pantheon of unstoppable might and resilience amongst a race of already formidable warriors, your destiny truly seems laid out in gold. However, the gene is highly unstable, lowering your lifespan by around ten years and causing you to become prone to fits of anger more easily at best, and insane insatiable perpetual rage fits at worst. Although not impossible, it is quite hard to snap out of such episodes. This is certainly both a blessing or a curse, left up for you to decide. Lastly and most importantly, achieving the Super Saiyan state is nearly as easy as breathing for you.<p><p>"
	alert(src,"You are born with the Legendary Gene, a rare mutation within a Saiyans genetic DNA structure! A mythic pantheon of unstoppable might and resilience amongst a race of already formidable warriors, your destiny truly seems laid out in gold. However, the gene is highly unstable, lowering your lifespan by around ten years and causing you to become prone to fits of anger more easily at best, and insane insatiable perpetual rage fits at worst. Although not impossible, it is quite hard to snap out of such episodes. This is certainly both a blessing or a curse, left up for you to decide. Lastly and most importantly, achieving the Super Saiyan state is nearly as easy as breathing for you.")
mob/proc/Low() //
	Potential*=2
	Add=1
	Magic_Potential = 0.5
	Sense_Mod=1.5
	Trans = 1
	Age=1
	InclineSpeed=1
	InclineAge=18
	RaceDescription="Saiyans are typical Humanoids of the same size and appearance as an Earthling. \
	Unlike Earthlings, they gain power roughly twice as fast, and even faster with zenkai. This makes \
	them very impressive from an Earthling standpoint. They do not actually possess any more brute \
	strength than a Human, its their high battle power that makes it seem like it. They do however, \
	withstand much more damage, get used to gravity much faster, have much more zenkai power, and \
	when angry, many Saiyans get a much larger power increase than Human's, and most other races \
	for that matter. They do have some weaknesses compared to Earthlings: They are not as intelligent, \
	and therefore are not as good with technology, also in the long run they do not master skills to \
	the same extent as a Human can. When a Saiyan who still has their tail looks at the moon, they \
	turn into an Oozaru, which is roughly a 2x increase in power, though it has some trade-offs. \
	There are 3 types of Saiyans: Low Class. Normal. And Elites. Each one has the same underlying \
	traits of any other Saiyan, but also some considerable stat differences. They also can become \
	Super Saiyans obviously, which is extremely difficult to attain, but unimagineably powerful as \
	well, thus why it is considered a legendary form, because it is so hard to attain that only a few \
	have gotten it in the past."
	Race="Saiyan"
	Class="Low-Class"
	Decline=40
	ZanzoMod=1.2
	BPMod=2
	Base=2
	MaxKi=40
	MaxAnger=200
	KiMod=1.5
	switch(src.Size)
		if(SMALL)
			StrMod=0.8
			EndMod=1.2
			PowMod=1.2
			ResMod=0.8
			SpdMod=1.8
			OffMod=1.2
			DefMod=1.2
			Regeneration=2
			Recovery=1.8
		if(MEDIUM)
			StrMod=1
			EndMod=1.5
			PowMod=1
			ResMod=1
			SpdMod=1.5
			OffMod=1
			DefMod=1
			Regeneration=2
			Recovery=1.8
		if(LARGE)
			StrMod=1.2
			EndMod=1.8
			PowMod=0.8
			ResMod=1.2
			SpdMod=1.2
			OffMod=0.8
			DefMod=0.8
			Regeneration=2
			Recovery=1.8
	GravMod=2
	FlyMod=1.5
	Zenkai=10
	MedMod=2
	GravMastered=5
	contents+=new/obj/Oozaru
	End+=50*EndMod
	var/Legendary_Gene = 1
	for(var/mob/M in Players)
		if(M.Race == "Saiyan") if(M.Class == "Legendary")
			Legendary_Gene -= 1
	var/Legend = prob(Legendary_Gene)
	var/rolled = 0
	if(src.ckey in rare_keys)
		rolled = 1
		src << "<font color = teal>Note - You have already rolled a percentage chance for a rare this wipe."
	if(rolled == 0) if(Year > 20)
		if(Legend) if(!Rares.Find("LSSJ"))
			if(Allow_Rares == "On")
				rare_keys += src.ckey
				Rares += "LSSJ"
				SaveYear()
				src.LSSJ()

mob/proc/Normal()//
	Potential*=1.5
	Add=1
	Magic_Potential = 0.5
	Sense_Mod=1
	Age=1
	Trans = 1
	InclineSpeed=1
	InclineAge=18
	RaceDescription="Saiyans are typical Humanoids of the same size and appearance as an Earthling. \
	Unlike Earthlings, they gain power roughly twice as fast, and even faster with zenkai. This makes \
	them very impressive from an Earthling standpoint. They do not actually possess any more brute \
	strength than a Human, its their high battle power that makes it seem like it. They do however, \
	withstand much more damage, get used to gravity much faster, have much more zenkai power, and \
	when angry, many Saiyans get a much larger power increase than Human's, and most other races \
	for that matter. They do have some weaknesses compared to Earthlings: They are not as intelligent, \
	and therefore are not as good with technology, also in the long run they do not master skills to \
	the same extent as a Human can. When a Saiyan who still has their tail looks at the moon, they \
	turn into an Oozaru, which is roughly a 2x increase in power, though it has some trade-offs. \
	There are 3 types of Saiyans: Low Class. Normal. And Elites. Each one has the same underlying \
	traits of any other Saiyan, but also some considerable stat differences. They also can become \
	Super Saiyans obviously, which is extremely difficult to attain, but unimagineably powerful as \
	well, thus why it is considered a legendary form, because it is so hard to attain that only a few \
	have gotten it in the past."
	Race="Saiyan"
	Class="Normal"
	Decline=40
	BPMod=2.2 //2.2
	MaxKi=60
	MaxAnger=175
	KiMod=1.5
	switch(src.Size)
		if(SMALL)
			StrMod=0.8
			EndMod=1.44
			PowMod=1.2
			ResMod=0.8
			SpdMod=1.8
			OffMod=1.2
			DefMod=1.2
			Regeneration=2
			Recovery=2
		if(MEDIUM)
			StrMod=1
			EndMod=1.8
			PowMod=1
			ResMod=1
			SpdMod=1.5
			OffMod=1
			DefMod=1
			Regeneration=2
			Recovery=2
		if(LARGE)
			StrMod=1.2
			EndMod=2.16
			PowMod=0.8
			ResMod=1.2
			SpdMod=1.2
			OffMod=0.8
			DefMod=0.8
			Regeneration=2
			Recovery=2
	GravMod=2
	FlyMod=1.5
	Zenkai=10
	Base=rand(100,500)
	GravMastered=5
	contents+=new/obj/Oozaru
	var/Legendary_Gene = 1
	for(var/mob/M in Players)
		if(M.Race == "Saiyan") if(M.Class == "Legendary")
			Legendary_Gene -= 1
	var/Legend = prob(Legendary_Gene)
	var/rolled = 0
	if(src.ckey in rare_keys)
		rolled = 1
		src << "<font color = teal>Note - You have already rolled a percentage chance for a rare this wipe."
	if(rolled == 0) if(Year > 10)
		if(Legend) if(!Rares.Find("LSSJ"))
			if(Allow_Rares == "On")
				rare_keys += src.ckey
				Rares += "LSSJ"
				SaveYear()
				src.LSSJ()

mob/proc/Elite() //
	Add=1
	Magic_Potential = 0.5
	Potential*=1
	Sense_Mod=1
	Age=1
	Trans = 1
	InclineSpeed=1.25
	InclineAge=18
	RaceDescription="Saiyans are typical Humanoids of the same size and appearance as an Earthling. \
	Unlike Earthlings, they gain power roughly twice as fast, and even faster with zenkai. This makes \
	them very impressive from an Earthling standpoint. They do not actually possess any more brute \
	strength than a Human, its their high battle power that makes it seem like it. They do however, \
	withstand much more damage, get used to gravity much faster, have much more zenkai power, and \
	when angry, many Saiyans get a much larger power increase than Human's, and most other races \
	for that matter. They do have some weaknesses compared to Earthlings: They are not as intelligent, \
	and therefore are not as good with technology, also in the long run they do not master skills to \
	the same extent as a Human can. When a Saiyan who still has their tail looks at the moon, they \
	turn into an Oozaru, which is roughly a 2x increase in power, though it has some trade-offs. \
	There are 3 types of Saiyans: Low Class. Normal. And Elites. Each one has the same underlying \
	traits of any other Saiyan, but also some considerable stat differences. They also can become \
	Super Saiyans obviously, which is extremely difficult to attain, but unimagineably powerful as \
	well, thus why it is considered a legendary form, because it is so hard to attain that only a few \
	have gotten it in the past."
	Race="Saiyan"
	Class="Elite"
	Decline=40
	DeclineMod=1.5
	FlySkill+= 10
	FlyMod=1.5
	MaxKi=80
	BPMod=2.4 //2.5
	MaxAnger=150
	KiMod=1.5
	switch(src.Size)
		if(SMALL)
			StrMod=1.44
			EndMod=0.8
			PowMod=1.2
			ResMod=0.8
			SpdMod=1.8
			OffMod=1.8
			DefMod=0.84
			Regeneration=2
			Recovery=1.9
		if(MEDIUM)
			StrMod=1.8
			EndMod=1
			PowMod=1
			ResMod=1
			SpdMod=1.5
			OffMod=1.5
			DefMod=0.7
			Regeneration=2
			Recovery=1.9
		if(LARGE)
			StrMod=2.16
			EndMod=1.2
			PowMod=0.8
			ResMod=1.2
			SpdMod=1.2
			OffMod=1.2
			DefMod=0.56
			Regeneration=2
			Recovery=1.9
	GravMod=2
	Zenkai=10
	Base=rand(2000,4000)
	ssjmod*=0.5
	GravMastered=5
	contents+=new/obj/Oozaru
	var/Legendary_Gene = 1
	for(var/mob/M in Players)
		if(M.Race == "Saiyan") if(M.Class == "Legendary")
			Legendary_Gene -= 1
	var/Legend = prob(Legendary_Gene)
	var/rolled = 0
	if(src.ckey in rare_keys)
		rolled = 1
		src << "<font color = teal>Note - You have already rolled a percentage chance for a rare this wipe."
	if(rolled == 0) if(Year > 10)
		if(Legend) if(!Rares.Find("LSSJ"))
			if(Allow_Rares == "On")
				rare_keys += src.ckey
				Rares += "LSSJ"
				SaveYear()
				src.LSSJ()

mob/proc/Changeling() //
	Asexual=1
	Add=0.5
	Magic_Potential = 0.5
	Potential*=1
	Sense_Mod=0.25
	Burst='Burst.dmi'
	Decline=rand(70,90)
	DeclineMod=0.5
	InclineSpeed=0
	InclineAge=0
	Age=1
	MaxKi=200
	Alignment = -3
	AlignmentTxt = "Villainous"
	Race="Changeling"
	GravMastered=10
	BPMod=1
	Zanzoken=50
	ZanzoMod=1.5
	FlyMod=3
	FlySkill=4
	GravMod=3
	Lungs=1
	RaceDescription="Changelings are probably the strongest race starting out because of \
	extremely high starting power and having full-grown bodies from the start. One of the \
	advantages that any type of Changeling will have is extremely high endurance, even \
	if the person they are fighting is much stronger they will last a long time. They \
	are fast and gain their forms easily compared to all other races."
	MaxAnger=110
	KiMod=2
	switch(src.Size)
		if(SMALL)
			PowMod=1.44
			StrMod=0.8
			SpdMod=2.7
			EndMod=3.2
			ResMod=2.4
			OffMod=1.44
			DefMod=1
			Regeneration=1.5
			Recovery=2.5
		if(MEDIUM)
			PowMod=1.2
			StrMod=1
			SpdMod=2.25
			EndMod=4
			ResMod=3
			OffMod=1.2
			DefMod=0.8
			Regeneration=1.5
			Recovery=2.5
		if(LARGE)
			PowMod=1
			StrMod=1.2
			SpdMod=1.8
			EndMod=4.8
			ResMod=3.6
			OffMod=1
			DefMod=0.6
			Regeneration=1.5
			Recovery=2.5
	Form2At = 1000
	Form3At = 1000
	Form4At = 1000
	Form2Mult = 1.75
	Form3Mult = 1.75
	Form4Mult = 1.75
	Form2Add = 0
	Form3Add = 0
	Form4Add = 0
	Base=10000
	if(prob(10))
		Form4Add*=2
	for(var/B in typesof(/obj/Aquatian)) contents+=new B
	for(var/obj/Aquatian/B in src) if(B.type==/obj/Aquatian) del(B)
	Tabs=3
	src<<"Please look in your info tab on the upper right hand of the screen and choose your second, third, and final forms. \
	Clicking an icon will select it for your character to use."
	while(!Form8Icon&&src) sleep(10)

mob/proc/Demon()//
	Add=1
	Magic_Potential = 4.5
	Potential*=2
	Sense_Mod=1
	Burst='Burst.dmi'
	Vampire_Immune = 1
	Age=1
	Decline=rand(80,120)
	DeclineMod=0.5
	InclineSpeed=2
	Alignment = -4
	AlignmentTxt = "Demonic"
	InclineAge=18
	RaceDescription="Kaios and Demons originated from a common ancestor, but through aeons of \
	seperation, their physical form has matched the dark powers they have developed, just as \
	a Kaio's physical forms matched the powers of good that they use so much. They share many \
	subtle traits with the Kaios, such as long lifespan. But whereas the Kaios are more energy based, \
	Demons have lost some of that in favor of physical attributes. They have become great damage \
	dealers, both with physical and spiritual abilities. One of their signature abilities is the \
	ability to absorb souls and become more powerful, though their are drawbacks to having absorbed \
	power, you can read about that elsewhere. They also grow up twice as fast."
	ITMod=0.5
	ZanzoMod=1.5
	Zanzoken=5
	KaiokenMod=1
	FlyMod=2
	FlySkill=3
	BPMod=2
	MaxAnger=120
	MaxKi=100
	KiMod=2
	switch(src.Size)
		if(SMALL)
			PowMod=1.2
			StrMod=1.6
			SpdMod=1.8
			EndMod=1.2
			ResMod=1
			OffMod=1.8
			DefMod=1
			Regeneration=2
			Recovery=1
		if(MEDIUM)
			PowMod=1
			StrMod=2
			SpdMod=1.5
			EndMod=1.5
			ResMod=1.2
			OffMod=1.5
			DefMod=0.8
			Regeneration=2
			Recovery=1
		if(LARGE)
			PowMod=0.8
			StrMod=2.4
			SpdMod=1.2
			EndMod=1.8
			ResMod=1.8
			OffMod=1.2
			DefMod=0.6
			Regeneration=2
			Recovery=1
	Zenkai=1
	MedMod=2
	GravMod=5
	Race="Demon"
	Base=rand(200,1000)
	GravMastered=10
	contents+=new/obj/Absorb
	if(prob(33))
		ImitateLearnable=1
mob/proc/Oni()
	Add=4
	Magic_Potential = 4
	Sense_Mod=1.2
	Potential*=2
	Burst='Burst.dmi'
	Age=1
	InclineSpeed=2
	InclineAge=32
	Decline=50
	DeclineMod=1.2
	RaceDescription="A strange entity that appeared in the lower regions of the afterlife shortly after the Fall.  Not much is known about them, and many of their number stay isolated from the war raging between the planes, instead preferring their solitude.  While nowhere near as strong as the Kaios, Demigods, or Demons that populate the afterlife, they have an unusually high aptitude for technology, and the older, more powerful members of their race are said to be capable of performing supernatural feats of strength that were previously only thought to be unique to the Kaios and Demons. (Placeholder.)"
	ITMod=2
	ZanzoMod=1
	FlyMod=1
	BPMod=1.8
	MaxAnger=175
	KiMod=2
	MaxKi=50
	switch(src.Size)
		if(SMALL)
			PowMod=1.2
			StrMod=0.8
			SpdMod=1.44
			EndMod=2.4
			ResMod=2.4
			OffMod=1
			DefMod=1
			Regeneration=2
			Recovery=2
		if(MEDIUM)
			PowMod=1
			StrMod=1
			SpdMod=1.2
			EndMod=3
			ResMod=3
			OffMod=0.8
			DefMod=0.8
			Regeneration=2
			Recovery=2
		if(LARGE)
			PowMod=0.8
			StrMod=1.2
			SpdMod=1
			EndMod=3.6
			ResMod=3.6
			OffMod=0.6
			DefMod=0.6
			Regeneration=2
			Recovery=2
	GravMod=2
	Zenkai=2
	MedMod=2
	Race="Oni"
	Base=1500
	GravMastered=10
	FlySkill=2
mob/proc/Alien()
	Add=2
	Magic_Potential = 2
	Potential*=rand(0.5,4)
	Burst='Burst.dmi'
	Age=1
	InclineSpeed=rand(1,2)
	InclineAge=rand(12,24)
	Decline=rand(30,100)
	DeclineMod=rand(0.5,2)
	RaceDescription="Aliens are good because you can customize their stats. \
	But a lot of other attributes are determined randomly, such as their decline age, \
	and skill mods. While others are preset attributes that are specific to aliens, such as their \
	starting and final bp mods, and the requirement of power before they hit their final mod. They \
	are a balanced race no matter how you customize their stats, you have a certain amount of points \
	you can use, some arrangements may work better than others I guess. The power an alien starts \
	with is extremely random, from 1 to 1500 or so."
	alert("[RaceDescription]")
	ITMod=rand(1,2)
	ZanzoMod=rand(1,10)
	KaiokenMod=1
	FlyMod=rand(1,10)
	BPMod=1.3
	MaxAnger=rand(120,150)
	KiMod=1
	switch(src.Size)
		if(SMALL)
			PowMod=1.2
			StrMod=0.8
			SpdMod=1.8
			EndMod=0.8
			ResMod=0.8
			OffMod=1.2
			DefMod=1.2
			Regeneration=1.5
			Recovery=1.5
		if(MEDIUM)
			PowMod=1
			StrMod=1
			SpdMod=1.5
			EndMod=1
			ResMod=1
			OffMod=1
			DefMod=1
			Regeneration=1.5
			Recovery=1.5
		if(LARGE)
			PowMod=0.8
			StrMod=1.2
			SpdMod=0.8
			EndMod=1.2
			ResMod=1.2
			OffMod=0.8
			DefMod=0.8
			Regeneration=1.5
			Recovery=1.5
	GravMod=2
	Zenkai=rand(1,5)
	MedMod=2
	Race="Alien"
	Base=rand(1,1500)
	GravMastered=1
	MaxKi=100*KiMod
	Melee_Req = rand(10000,300000)
	Ki_Req = rand(10000,300000)
	Hybrid_Req = rand(10000,300000)
/*
	pick(
			transVariable("None"),
		prob(50)
			transVariable("Ki_Burst"),
		prob(25)
			transVariable("Bojack")
		)
*/
//	if(prob(25))
//		Bojack_Learnable=1
//	if(prob(50)&&Bojack_Learnable==0)
//		Ki_Burst_Learnable=1
	var/Skills=3
	var/list/Choices=new
	Choices.Add("Time Freeze","Matter Absorption","Imitate","Invisibility",\
	"Precognition","Regeneration","Genius","Redundant Lungs","Telepathic","Magical Attunement","Telekinesis")
	while(Skills)
		switch(input("Now you get to choose [Skills] skills from this list") in Choices)
			if("Telekinesis")
				Choices-="Telekinesis"
				contents+=new/obj/Telekinesis
				src.TK = 1
				src<<"You've gained the ability to move objects with your mind! Simply drag items and people around using your mouse. Each movement costs you energy though. You can also throw items into players to harm them!"
			if("Genius")
				Choices-="Genius"
				Add*=2
				src<<"This has risen your intelligence mod from 2 to 4."
			if("Magical Attunement")
				Choices-="Magical Attunement"
				Magic_Potential*=2
				src<<"This has risen your magical potential mod from 2 to 4."
			if("Regeneration")
				Regenerate+=0.3
				src<<"You've developed the ability to regenerate from grave injuries! \
				This skill is similar to the skill displayed by Bio-Organic Android hybrids, or Majins. \
				However, it is much weaker.  You can stack this trait multiple times."
			if("Time Freeze")
				Choices-="Time Freeze"
				contents+=new/obj/Attacks/Time_Freeze
				src<<"You've developed the ability to manipulate time on some small, localized level! \
				Using this ability will cause your character to target any and all nearby applicable enemies\
				and freeze time in the immediate area around their bodies."
			if("Limit Breaker")
				Choices-="Limit Breaker"
				contents+=new/obj/Limit_Breaker
				src<<"You can transcend the limits of your capabilities for a short period of time, letting you \
				fight at a greatly improved rate.  The toll this skill takes on your body \
				is high, however, and you will be knocked out once the buff wears off."
			if("Matter Absorption")
				Choices-="Matter Absorption"
				contents+=new/obj/Absorb
				contents+=new/obj/Absorb
				src<<"You've developed the ability to absorb other living (and unliving!) beings.  Every lifeform you absorb \
				is capable of boosting your overall power.  This is not without its \
				drawbacks, however, as consuming too many organisms can lower certain statistics until \
				the energy gained from the absorption is released."
			if("Imitate")
				Choices-="Imitate"
				contents+=new/obj/Imitation
				src<<"You've developed the ability to 'mirror' other living creature's appearances!  This skill has no direct practical \
				use in combat.  However, a crafty individual could find myriad ways to utilize it in social situations."
			if("Invisibility")
				Choices-="Invisibility"
				contents+=new/obj/Invisibility
				src<<"You've developed the ability to blend into your surroundings!  You can make your skin (And, somehow, any attached clothes) \
				turn the same color and texture as your surroundings, rendering you nearly invisible to the naked eye.  This is merely a physical alteration \
				however, and is not mystical in nature or technologically powered.  So attacking an enemy or performing any action will render you visible to everyone nearby until \
				you can adapt to your surroundings again!"
			if("Observe")
				Choices-="Observe"
				contents+=new/obj/Observe
			if("Precognition")
				Choices-="Precognition"
				Precognition=1
				src<<"You've developed the ability to see the future!  This manifests in brief flashes of insight. \
				Unfortunately, those flashes often happen right before whatever you predicted occurs, meaning this skill is of limited \
				use in actually telling the future.  You can, however, use it to predict the path projectiles will take, and dodge them. \
				Be warned, however, that even with the ability to see where bullets and ki will move, an excessively large number of \
				projectiles can still pin you down, giving you no avenue of escape!"
			if("Redundant Lungs")
				Lungs=1
				src<<"You've evolved past the need to actively breathe, allowing you to safely traverse environments that most races find inhospitable."
			if("Telepathic")
				Choices-="Telepathic"
				contents+=new/obj/Telepathy
				src<<"You've developed latent telepathic capabilities!  As a result, you can communicate \
				over vast distances through your thoughts, and start with the ability to read minds."
		Skills-=1
	for(var/B in typesof(/obj/Alien_Icons)) contents+=new B
	for(var/obj/Alien_Icons/B in src) if(B.type==/obj/Alien_Icons) del(B)
	src<<"Choose your icon out of the selections in the tabs"
	Tabs="Choosing Alien Icon"
	while(Tabs!=2)
		sleep(1)
	switch(input("Do you want this alien to reproduce asexually?") in list("Yes","No"))
		if("Yes") Asexual=1
		if("No") Asexual=0

mob/proc/Makaioshin()
	Add=2
	Magic_Potential = 4.5
	Sense_Mod=1
	Potential*=4
	Burst='Burst.dmi'
	Age=200
	InclineSpeed=1
	InclineAge=40
	Decline=rand(10000,30000)
	DeclineMod=1
	RaceDescription=""
	ITMod=1
	ZanzoMod=2
	KaiokenMod=1
	FlyMod=2
	BPMod=2.7
	MaxAnger=150
	ZanzoMod=2
	KiMod=2
	MaxKi=100
	switch(src.Size)
		if(SMALL)
			PowMod=2.5
			StrMod=1
			SpdMod=2.5
			EndMod=1
			ResMod=1
			OffMod=2.5
			DefMod=2.5
			Regeneration=2
			Recovery=2
		if(MEDIUM)
			PowMod=1.5
			StrMod=1.5
			SpdMod=1.5
			EndMod=1.5
			ResMod=1.5
			OffMod=1.5
			DefMod=1.5
			Regeneration=2
			Recovery=2
		if(LARGE)
			PowMod=1
			StrMod=2.5
			SpdMod=1
			EndMod=2.5
			ResMod=2.5
			OffMod=1
			DefMod=1
			Regeneration=2
			Recovery=2
	MedMod=2
	Race="Lesser Old Ones"
	icon="Makaioshin Base Fixed.dmi"
	Base=rand(10000,40000)
	GravMastered=10
	GravMod=3