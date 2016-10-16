proc/SaveScalingPower()
	var/savefile/S=new("Data/NPCPower.bdb")
	S["ScalingPower"] << ScalingPower
	S["ScalingStats"] << ScalingStats
/*	S["ScalingStr"] << ScalingStr
	S["ScalingEnd"] << ScalingEnd
	S["ScalingRes"] << ScalingRes
	S["ScalingOff"] << ScalingOff
	S["ScalingDef"] << ScalingDef*/

proc/LoadScalingPower() if(fexists("Data/NPCPower.bdb"))
	var/savefile/S=new("Data/NPCPower.bdb")
	S["ScalingPower"] >> ScalingPower
	S["ScalingStats"] >> ScalingStats
	/*S["ScalingStr"] >> ScalingStr
	S["ScalingEnd"] >> ScalingEnd
	S["ScalingRes"] >> ScalingRes
	S["ScalingOff"] >> ScalingOff
	S["ScalingDef"] >> ScalingDef*/
proc/SaveRankings()
	var/savefile/S=new("Data/Rankings.bdb")
	S["Rankings"]<<Rankings
proc/LoadRankings()
	var/savefile/S=new("Data/Rankings.bdb")
	S["Rankings"]>>Rankings
	var/Empty = 1
	for(var/X in Rankings)
		Empty = 0
	if(Empty)
		Rankings = list()
proc/SaveActivation()
	var/savefile/S=new("Data/x76dgfshd.bdb")
	S["Activated"]<<Server_Activated

proc/LoadActivation() if(fexists("Data/x76dgfshd.bdb"))
	var/savefile/S=new("Data/x76dgfshd.bdb")
	S["Activated"]>>Server_Activated

proc/SaveYear()
	var/savefile/S=new("Data/Year.bdb")
	S["Year"]<<Year
	S["Speed"]<<Year_Speed
	S["Rares"]<<rare_keys
	S["Rares Rolled"]<<Rares
	S["Androids"]<<Androids
	S["Security"]<<Security
	S["MainFrame"]<<MainFrame
	S["First SSJ"]<<First_SSJ

proc/LoadYear() if(fexists("Data/Year.bdb"))
	var/savefile/S=new("Data/Year.bdb")
	S["Year"]>>Year
	S["Speed"]>>Year_Speed
	S["Rares"]>>rare_keys
	S["Rares Rolled"]>>Rares
	S["Androids"]>>Androids
	S["Security"]>>Security
	S["MainFrame"]>>MainFrame
	S["First SSJ"]>>First_SSJ
proc/Create_Events()
	var/Items = 3
	while(Items)
		var/X = rand(1,500)
		var/Y = rand(1,500)
		var/Z = pick(1,3,4,8,12)
		Items -= 1
		var/Type = pick(/obj/Mana/Mana_Crystal,/obj/Resources/Treasure)
		var/obj/O=new Type
		O.loc = locate(X,Y,Z)
var/Year=0.1
var/rare_keys = list()
proc/Years()
	while(1)
		Resources()
		Mana()
		sleep(9000/Year_Speed)
		Year+=0.1
		//if(round(Year,0.1)==round(Year,0.5)) world.Repop()
		var/obj/items/Android_Upgrade/AU = new
		for(var/obj/items/Main_Frame/X in worldObjectList)
			AU.loc = X
			break
		if(First_SSJ < 3)
			First_SSJ += 0.1
		spawn for(var/mob/player/A in world)
			A.Yearly_Update()
		//file("Logs/[A.key].log")<<"<br>Year [round(Year,0.1)]<br>"
mob/proc/Yearly_Update()
	var/mob/A = src
	A.RP_Earned -= 5
	if(A.Boost > 1)
		A.Boost -= 0.1
	for(var/obj/B in src)
		if(B.Teach < 10)
			B.Teach += 0.1
	if(A.client)
		//log_errors("Updating year for [A] ([A.x],[A.y],[A.z])")
		A.Age_Update()
		//log_errors("Year updated for [A] ([A.x],[A.y],[A.z])")
		if(A.Counterpart) for(var/mob/player/B in world) if(A.Counterpart=="[B]([B.key])"&&B.Race==A.Race)
			B.Counterpart="[A]([A.key])"
			if(A.Gain_Multiplier<B.Gain_Multiplier) A.Gain_Multiplier=B.Gain_Multiplier
			A<<"<span class=\"narrate\">Your gain has equaled your counterpart, [A.Counterpart]</span>"
		if(round(Year,0.1)==round(Year))
			A<<"<span class=\"narrate\">The moon comes out!</span>"
			for(var/obj/Oozaru/B in A)
				if(!A.Tail) if(A.Age<16) A.Tail_Add()
				if(B.Setting) A.Oozaru()
		if(round(Year,0.1)==round(Year,10))
			rare_keys = null
			rare_keys = list()
			A<<"<span class=\"narrate\">The Makyo Star approaches the planet...</span>"
			if(A.Race=="Demon") A.MakyoPower=100000
			else if(A.Vampire) A.MakyoPower=100000
			else if(A.Race=="Makyojin")
				A.MakyoPower=1000000
				A.BPMod += 0.1
				if(A.BPMod >= 2)
					A.BPMod = 2
				else
					A << "The Makyo Star has permanently infused you with a lasting power."
			else if(locate(/obj/Majin) in A) A.MakyoPower=50000
		else if(Year>round(Year,10)+1) A.MakyoPower=0
	if(!Players.Find(A))
		Players += A
		A.Update_Player()
mob/proc/Age_Update()

	Real_Age=Year-BirthYear
	Moon_Used -= 1
	if(Moon_Used <= 0)
		Moon_Used = 0
	if(!Dead)
		Age+=Year-LogYear
		if(z==10)
			Age+=0.9
/*
	var/Cap = Year * 50.5
	Cap*=2//10.1
	var/Result = Year*50.5 //5.05
	Result = Result - Cap //= -5.05
	if(RP_Earned < Result)
		RP_Earned = Result
*/
	if(LogYear != Year)
		var/Y = Year - LogYear
		Y = Y*50
		RP_Earned -= Y
	LogYear=Year
	if(src.Absorb) if(src.Race != "Majin") if(src.Race != "Bio-Android")
		if(src.Absorb_Max)
			var/N = src.Absorb_Max
			N = N / 50
			src.Absorb -= N
			if(src.Absorb <= 0)
				src.Absorb = 0
				src << "All your absorbed power has faded away."
	if(!Dead&&Age>Decline&&Body<=0.05)
		Die()
	GreyHair()

	if(Age>40&&icon=='Namek Young.dmi') icon='Namek Adult.dmi'
	if(Age>=Decline&&icon=='Namek Adult.dmi') icon='Namek Old.dmi'

	if(!Sterile&&Age>=13&&!(locate(/obj/Mate) in src))
		contents+=new/obj/Mate
		for(var/obj/Mate/B in src) B.LastUse=Year-1

	src<<"<span class=\"narrate\">It is now month [round((Year-round(Year))*10)] of year [round(Year)]</span>"
	src<<"<span class=\"narrate\">You are now [round(Real_Age,0.1)] years old</span>"

	//log_errors("[src]::[src.client] || It is now month [round((Year-round(Year))*10)] of year [round(Year)]")
	//log_errors("[src]::[src.client] || You are now [round(Real_Age,0.1)] years old")

mob/proc/Body()
	//Body=Age*InclineSpeed
	// Whereas in actual math you'd use a ^ in code this is an XOR statement.
	// ** should be used instead, (2**3=8) and as such I've changed where relevant. -- Vale
	if((Age<InclineAge) && (InclineAge>0))
		Body = min(100,100/((InclineAge-Age)**(InclineSpeed*0.1)))	//Incline speed works better this way
	else if((Age>Decline) && (Decline>0))
		Body = max(0.0001,100/((Age-Decline)**DeclineMod))
		if(Body>100) Body=100
	else
		Body = 100	//100 percent niggaaa
	if(Dead)
		if(KeepsBody)
			Body = 50
		else
			Body = 1
	if(Immortal)	//Forever
		Body = 100
	if(Noobs.Find(key))
		Body = 1

/*
	if(Body > 100)
		while(Body > 100)
			Body/=10
			sleep(10)
*/

	Body *= 0.01	//Body is a percent
mob/proc/Die() //from old age
	if(inertia_dir)
		inertia_dir = 0
		last_move = null
	UP=0
	Experience=0
	HBTC_Enters=0
	Age=1
	if(icon=='Namek Old.dmi')
		icon='Namek Young.dmi'
	src << "<span class=\"narrate\">Old age takes it's toll, and you pass away.</span>"
	Death("old age")
	Body()
mob/proc/GreyHair()
	if(!ssj&&hair&&Age>Decline)
		if(Hair_Age<Decline)
			Hair_Age=Decline
		overlays -= hair
		hair = Hair_Base
		if(HairColor)
			hair+=HairColor
		hair += rgb(round(5*(Age-Hair_Age)),round(5*(Age-Hair_Age)),round(5*(Age-Hair_Age)))
		overlays += hair
