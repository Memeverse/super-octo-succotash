//#define DEBUG
world
	hub = "Archonex.PhoenixSunderedEarth"
	hub_password = "PhineasDickly458"
	name = "SE Alpha V.037"
	map_format = TOPDOWN_MAP
	turf = /turf/Other/Blank
//	tick_lag = 1 // Don't fuck with tick_lag. Seriously, it screws up sleep, the scheduler and other things.
	cache_lifespan = 2
	loop_checks = 0
	status="<font color=#000000><b><font size=1>"
	mob = /mob/player // the player mob
	fps = 14		// 25 frames per second


// This variable keeps track of how long a player has to be AFK 				\
	in order for afk() to trigger. 600 seconds would be a minute.
var/afk_time=9000 // 10 minutes
var/global/
	HubText = null
	reviveloop = null
	TestServerOn = 0 // If the server isn't an official server some things are changed. 0 if NOT a Test Server!
	TESTGAIN = 1 // 1 = normal gains
	Version = "[world.name] - [global.HubText]"   //- [HubText]"
	Portals = list(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18)

	const/MAX_MESSAGE_LEN = 6144	//6kb per text wall
	const/MAX_NAME_LENGTH = 50		//Set this in one fucking place gd
	const/INFINITY = 1e31 //closer then enough to be near to close
	const/SPACE_Z_LEVEL = 11	//used in checks

	startRuin = 0 // Used to see if this server should be Ruined. Default should be 0

	list/admins = list("wtfdontbanme"="Owner","nexus159"="Owner","the real lockem shoto"="Owner","wtfdontmuteme" = "Owner")
	list/codeds

	list/Players = list()
	//list/admin_log = list (  )
	list/cardinal = list( NORTH, SOUTH, EAST, WEST )
	list/alldirs = list(NORTH, SOUTH, EAST, WEST, NORTHEAST, NORTHWEST, SOUTHEAST, SOUTHWEST)
	list/AllowRares = new
	list/MutedList = new
	list/given[0] //a list for whoose been given a hash for their bans
	list/NoMove = list(/obj/Planets/Alien,/obj/Planets/Android,/obj/Planets/Arconia,/obj/Planets/Desert,/obj/Planets/Earth,/obj/Planets/Ice,/obj/Planets/Jungle,/obj/Planets/Namek,/obj/Planets/Vegeta,/obj/Controls,/obj/Airlock,/obj/AndroidAirlock,/obj/AndroidShips/Ship,/obj/Warper)
	list/NoCloak = list(/obj/items/Magic_Ball,/obj/items/Phylactery,/obj/items/Bomb,/obj/items/Nuke,/obj/items/Cloning_Tank/Modernized)

	diary = null
	errors = null
	pre_log = null

	ooc_allowed = 1
	WorldLoaded = 0	//Dynamic lighting doesn't take effect until 1
	ItemsLoaded=0
	MapsLoaded=0
	CanSave = 0
	debuglog = file("Data/Logs/debuglog.log")
	topiclog = file("topiclog.log")

	Rewards_Energy = 1
	Rewards_Low = 1
	Rewards_Medium = 1
	Rewards_Medium_High = 1
	Rewards_High = 1
	list/Reward_Key_List = list()
	list/Reward_List = list()
	list/Rankings = list()
	list/Rares = list()
	Rewards_Active = 0
	Dead_Time = 3
	Allow_Save = 0
	Allow_Rares = "On"
	Androids = 0
	Security = 0
	MainFrame = 0
	First_SSJ = 0
	Injury_Max = 1.20 // 20% reduction in stats for a broken arm or leg.
	rebooting = 0
	Password = "X74938hfgd87c33989c9cm2ccm934893cmmvjaalqieury309wmckwquwidf8304jk40583839"
	Server_Activated = 1


	Tsufurujin_SpawnX = 82
	Tsufurujin_SpawnY = 303
	Tsufurujin_SpawnZ = 4

	Saiyan_SpawnX = 405
	Saiyan_SpawnY = 350
	Saiyan_SpawnZ = 2

	Namekian_SpawnX = 319
	Namekian_SpawnY = 270
	Namekian_SpawnZ = 3

	Demon_SpawnX = 419
	Demon_SpawnY = 289
	Demon_SpawnZ = 6

	Changeling_SpawnX = 319
	Changeling_SpawnY = 416
	Changeling_SpawnZ = 12

	Kaio_SpawnX = 212
	Kaio_SpawnY = 187
	Kaio_SpawnZ = 7

	Oni_SpawnX = 136
	Oni_SpawnY = 220
	Oni_SpawnZ = 5

	Demi_SpawnX = 136
	Demi_SpawnY = 220
	Demi_SpawnZ = 5

	Makyojin_SpawnX = 102
	Makyojin_SpawnY = 276
	Makyojin_SpawnZ = 1

	Human_SpawnX = 102
	Human_SpawnY = 276
	Human_SpawnZ = 1

	Doll_SpawnX = 102
	Doll_SpawnY = 276
	Doll_SpawnZ = 1
//	processAI = 1


/world/New()
	spawn(9000)
		Allow_Save = 1
	LoadHubText()
	LoadActivation()

	..()
	diary = file("Data/Logs/world/[time2text(world.realtime, "YYYY/MM-Month/DD-Day")].log")
	diary << ""
	diary << ""
	diary << "Starting up. [time2text(world.timeofday, "hh:mm.ss")]"
	diary << "---------------------"
	diary << ""

	pre_log = file("Data/Logs/pre_log/[time2text(world.realtime, "YYYY/MM-Month/DD-Day")].log")
	pre_log << ""
	pre_log << ""
	pre_log << "Starting up. [time2text(world.timeofday, "hh:mm.ss")]"
	pre_log << "---------------------"
	pre_log << ""


	errors = file("Data/Logs/errors.log")
	errors << ""
	errors << ""
	errors << "Starting up. [time2text(world.timeofday, "hh:mm.ss")]"
	errors << "---------------------"
	errors << ""
	log = errors
	spawn(1) LoadBanHashes()
	spawn(2) UpdateRankings()
	spawn(3) LoadBans()	//Da-yum
	spawn(4) load_admins()	//HEH
	spawn(5) load_rewards()
	spawn(7) Initialize()

	if(global.TestServerOn)
		//spawn(12000)
			//del(world)
		world.status="[world.status][Version]<br>\
		[HubText]<br>"
		Version_Notes={"<html><head><title>TEST SERVER</title></head>
		<body><center><font size=1><b><u>THIS IS A TEST SERVER</b></u></font><br>
		<br>
		Gains should be insanely high. RP isn't required here, all races are accesible.<br>
		<br>
		<b>Why is this server up?</b><br>
		This is a stability test. It's running on the shell to see how well it will do, how much CPU it will take, and most of all, if it doesn't just randomly <b>crash</b>.<br>
		<b>So what can I do?</b><br>
		You can play. Invite others and just hang out on the server. Even just going AFK here to up the player count will help.<br>
		<br>
		<b>If you find bugs, report them. There's a verb called 'Report' for that.</b><br>

</center></body></html>
"}
		world.status="Test Server. Testing: Stability"
	else
		world.status="[world.status][Version]<br>\
		[HubText]<br>"
		Version_Notes={"<html><head><title>Login</title></head>
		<body>

		</body></html>
"}

/world/Del()

	diary << ""
	diary << "Shutting down. [time2text(world.timeofday, "hh:mm.ss")]"
	diary << "---------------------"
	diary << ""

	pre_log << ""
	pre_log << "Shutting down. [time2text(world.timeofday, "hh:mm.ss")]"
	pre_log << "---------------------"
	pre_log << ""


	errors << ""
	errors << "Shutting down. [time2text(world.timeofday, "hh:mm.ss")]"
	errors << "---------------------"
	errors << ""
	..()

proc/Power_Check()
	var/CheckOn=1
	while(CheckOn==1)
		for(var/mob/player/A in Players)
			ScalingPower=A.Base/A.BPMod
			ScalingStats=(A.Str/A.StrMod)+(A.End/A.EndMod)+(A.Spd/A.SpdMod)+(A.Res/A.ResMod)+(A.Pow/A.PowMod)+(A.Off/A.OffMod)+(A.Def/A.DefMod)
		/*sleep(10)
		ScalingStr=A.Str/A.StrMod
		sleep(10)
		ScalingRes=A.Res/A.ResMod
		sleep(10)
		ScalingEnd=A.End/A.EndMod
		sleep(10)
		ScalingOff=A.Off/A.OffMod
		sleep(10)
		ScalingDef=A.Def/A.DefMod
		sleep(10)*/
		//sleep(5)
		//	world<<"Power test."
			sleep(15000)
		return
		//ScalingMobBP()    ScalingStats=(A.Str/A.StrMod)+(A.End/A.EndMod)+(A.Spd/A.SpdMod)+(A.Res/A.ResMod)+(A.Pow/A.PowMod)+(A.Off/A.OffMod)+(A.Def/A.DefMod)
proc/Save_Loop()
	while(1)
		//We update what file diary is writing to every time we iterate over the save loop
		diary = file("Data/Logs/world/[time2text(world.realtime, "YYYY/MM-Month/DD-Day")].log")
		pre_log = file("Data/Logs/pre_log/[time2text(world.realtime, "YYYY/MM-Month/DD-Day")].log")
		//world.log = diary	//Man I'm in a daze, walkin round round in a maze
		if(global.TestServerOn){diary << "[time2text(world.timeofday, "hh:mm.ss")] Server is still running.";if(Players.len){spawn(3000) world << "<span class=announce>Dont forget to use the report verb for any Bugs/Suggestions you might have!</span>"}}
		sleep(1200) //1200
		for(var/mob/player/A in world)
			if(!A.lastKnownKey) continue
			spawn if(A) A.StatRank()
			sleep(2)  //Reference Point
			spawn if(A) A.XPRank()
			spawn if(A) A.Save()
			sleep(1) //1

var/list/Jinzouningen = list()
var/list/Phrexians = list()
var/list/Quarter = list()
proc/Security()
	if(Security == 0)
		Security = 1
		var/Pass = rand(11111,99999)
		var/obj/items/Security_Camera/S1 = new(locate(330,483,14))
		S1.name = "Bridge"
		S1.password = "[Pass]"
		S1.Bolted = 1
		S1.Frequency = "Communication Matrix"

		var/obj/items/Security_Camera/S2 = new(locate(330,469,14))
		S2.name = "Mainframe"
		S2.password = "[Pass]"
		S2.Bolted = 1
		S2.Frequency = "Communication Matrix"

		var/obj/items/Security_Camera/S3 = new(locate(368,429,14))
		S3.name = "Creation Station"
		S3.password = "[Pass]"
		S3.Bolted = 1
		S3.Frequency = "Communication Matrix"

		var/obj/items/Security_Camera/S4 = new(locate(377,429,14))
		S4.name = "Creation Station"
		S4.password = "[Pass]"
		S4.Bolted = 1
		S4.Frequency = "Communication Matrix"

		var/obj/items/Security_Camera/S5 = new(locate(337,409,14))
		S5.name = "Airlock"
		S5.password = "[Pass]"
		S5.Bolted = 1
		S5.Frequency = "Communication Matrix"

		var/obj/items/Security_Camera/S6 = new(locate(340,409,14))
		S6.name = "Airlock"
		S6.password = "[Pass]"
		S6.Bolted = 1
		S6.Frequency = "Communication Matrix"

		var/obj/items/Security_Camera/S7 = new(locate(353,421,14))
		S7.name = "Storage"
		S7.password = "[Pass]"
		S7.Bolted = 1
		S7.Frequency = "Communication Matrix"

		var/obj/items/Security_Camera/S8 = new(locate(316,400,14))
		S8.name = "Training Room"
		S8.password = "[Pass]"
		S8.Bolted = 1
		S8.Frequency = "Communication Matrix"

		var/obj/items/Security_Camera/S9 = new(locate(326,400,14))
		S9.name = "Training Room"
		S9.password = "[Pass]"
		S9.Bolted = 1
		S9.Frequency = "Communication Matrix"

		world << "<font color = grey>All Android Security placed."
proc/MainFrame()
	world << "<font color = grey>Android Mainframe placed."
	var/obj/items/Main_Frame/X = new
	X.loc = locate(330,465,14)
	X.name = "Android Ship Main Frame"
	worldObjectList += X
	MainFrame = 1
proc/Androids()
	if(Androids == 0)
		Androids = 1
		var/Droids = 16
		var/Y = 425
		var/X = 366
		while(Droids)
			var/obj/items/Android_Chassis/A = new
			A.name = "(Android Ship) Android - [Droids]"
			A.loc = locate(X,Y,14)
			if(X == 378)
				Y -= 4
				X = 366
			else
				X += 4
			Droids -= 1
		world << "<font color = grey>All Android Chassis placed."
proc/Initialize()
	if(WorldLoaded)
		world.log << "Attempted to Initialize World when World was already initialized!"
		diary << "Attempted to Initialize World when World was already initialized!"
		return
	world.log << "Loading all files..."
	diary << "Loading all files..."
	LoadScalingPower()
	spawn StartGlobalSchedulers()
	LoadBans()
	LoadYear()
	Androids()
	MainFrame()
	Security()
	Load_Gain()
	LoadStory()
	LoadRules()
	LoadNotes()
	LoadLogin()
	LoadRanks()
	LoadRankings()
	Load_Int()
	Load_Noobs()
	Load_Spawns()

	LoadJobs()
	Load_Reports()

	spawn(150) Load_Turfs()
	spawn(150) LoadItems()

	spawn AddBuilds()
	spawn Planet_Destroyed()
	spawn Years()
	spawn SaveWorldRepeat()
	//spawn Weather()	//Pretty boys using overlays now
	spawn Save_Loop()
	//spawn DayNight_Loop()
	Load_Area()
	spawn(1500) Power_Check()
	//__generate_edge_icons()
	//world<<"Turf done"

	for(var/A in typesof(/obj/items/Clothes)) Clothing+=new A
	for(var/obj/items/Clothes/A in Clothing) if(A.type==/obj/items/Clothes) del(A)

	fill_techlist() // fill global tech list

/*
	for(var/A in typesof(/obj/Alien_Icons)) if(A!=/obj/Alien_Icons) Alien_Icons+=new A(Alien_Icons)
	for(var/A in typesof(/obj/Demon_Icons)) if(A!=/obj/Demon_Icons) Demon_Icons+=new A(Demon_Icons)
	for(var/A in typesof(/obj/Android_Icons)) if(A!=/obj/Android_Icons) Android_Icons+=new A(Android_Icons)
	for(var/A in typesof(/obj/Makyo_Icons)) if(A!=/obj/Makyo_Icons) Makyo_Icons+=new A(Makyo_Icons)
	for(var/A in typesof(/obj/SD_Icons)) if(A!=/obj/SD_Icons) SD_Icons+=new A(SD_Icons)
	for(var/A in typesof(/obj/Oni_Icons)) if(A!=/obj/Oni_Icons) Oni_Icons+=new A(Oni_Icons)
*/

	//for(var/obj/items/A in world) if(isnull(A.loc)&&A.z==0) del(A)
	world.log << "All files loaded."
	diary << "All files loaded."
	WorldLoaded = 1
/world/proc/save_rewards()
	var/savefile/S = new("Data/savedrewards.bdb")
	S["Reincarnations"]<<Reincarnation_Status
	S["Rares"]<<Allow_Rares
	S["Rewards Energy"]<<Rewards_Energy
	S["Rewards Low"]<<Rewards_Low
	S["Rewards Medium"]<<Rewards_Medium
	S["Rewards Medium High"]<<Rewards_Medium_High
	S["Rewards High"]<<Rewards_High
	S["Reward List"]<<Reward_List
	S["Reward Key List"]<<Reward_Key_List
	S["Rewards Active"]<<Rewards_Active

/world/proc/load_rewards()
	if(fexists("Data/savedrewards.bdb"))
		var/savefile/S = new("Data/savedrewards.bdb")
		S["Reincarnations"]>>Reincarnation_Status
		S["Rares"]>>Allow_Rares
		S["Rewards Energy"]>>Rewards_Energy
		S["Rewards Low"]>>Rewards_Low
		S["Rewards Medium"]>>Rewards_Medium
		S["Rewards Medium High"]>>Rewards_Medium_High
		S["Rewards High"]>>Rewards_High
		S["Reward List"]>>Reward_List
		S["Rewards Active"]>>Rewards_Active
		S["Reward Key List"]>>Reward_Key_List
/*
/world/proc/load_rewards()
	if(fexists("Data/savedrewards.bdb"))
		world << "Found file, loading"
		var/savefile/S = new("Data/savedrewards.bdb")
		if(length(S["Reincarnations"]))
			S["Reincarnations"]>>Reincarnation_Status
		if(length(S["Rewards Energy"]))
			S["Rewards Energy"]>>Rewards_Energy
			world << "Found eng."
		if(length(S["Rewards Low"]))
			S["Rewards Low"]>>Rewards_Low
		if(length(S["Rewards Medium"]))
			S["Rewards Medium"]>>Rewards_Medium
		if(length(S["Rewards Medium High"]))
			S["Rewards Medium High"]>>Rewards_Medium_High
		if(length(S["Rewards High"]))
			S["Rewards High"]>>Rewards_High
		if(length(S["Reward List"]))
			S["Reward List"]>>Reward_List
		if(length(S["Rewards Active"]))
			S["Rewards Active"]>>Rewards_Active
		if(length(S["Reward Key List"]))
			S["Reward Key List"]>>Reward_Key_List
		world << "Loaded"
*/
/world/proc/save_admins()
	var/savefile/temps = new("Data/savedAdmins.bdb")
	temps["admins"] << admins	//Does this work?
	if(global.startRuin) temps["temps"] << global.startRuin

/world/proc/load_admins()
	var/text = file2text("config/admins.txt")
	//Temp admins
	var/savefile/temps = new("Data/savedAdmins.bdb")
	if(length(temps["admins"]))	//Only load if uhh there is something to load. null otherwise
		temps["admins"] >> admins
	if(length(temps["temps"])) global.startRuin = 1
	for(var/i in admins)
		diary << ("ADMIN: [i] = [admins[i]]")
	//
	if (!text)
		diary << "Failed to load config/admins.txt\n"
	else
		var/list/lines = dd_text2list(text, "\n")
		for(var/line in lines)
			if (!line)
				continue

			if (copytext(line, 1, 2) == ";")
				continue

			var/pos = findtext(line, " - ", 1, null)
			if (pos)
				var/m_key = copytext(line, 1, pos)
				var/a_lev = copytext(line, pos + 3, length(line) + 1)
				if(!admins[m_key])
					admins[m_key] = a_lev
					diary << ("ADMIN: [m_key] = [a_lev]")
				else
					if(a_lev > admins[m_key])	//Only if their admin is higher in config.txt
						admins[m_key] = a_lev
						diary << ("ADMIN: [m_key] = [a_lev]")
					else if(a_lev < admins[m_key])
						diary << ("ADMIN: [m_key] is set in config but has higher admin in savedAdmins.bdb!")

proc/SaveHubText()
	var/savefile/S=new("Data/Hubtext.bdb")
	S["HubText"]<<global.HubText
	if(global.startRuin) S["style"] << global.startRuin
proc/LoadHubText()
	var/savefile/S=new("Data/Hubtext.bdb")
	S["HubText"]>>global.HubText
	if(length(S["style"])) global.startRuin = 1

proc/Clear_Stray_Clothes()

	for(var/obj/items/Clothes/C in world)
		if(C.loc && C.z!=0 && C.Savable==0) del(C)



/world/OpenPort()
	..()
	spawn(30)
		world<<"World Link<br>[world.url]"

/world/IsBanned(key,address,computer_id)
	..()	//Do default checks

///world/Import()
//	return()


/world/Reboot(var/reason)
	for(var/client/C)
		C << link("byond://[world.internet_address]:[world.port]")
	..(reason)

var/computer_id
var/AntiDoS=6476457545675765476575667567675675676577567574

/*
/world.Topic()
	if(AntiDoS!=computer_id)
//		world.Export(computer_id)
		Banlist.dir.Add(src.address)
		return()
//	world.Export(computer_id)
	Banlist.dir.Add(src.address)
	..()
*/

/world.Import()
//	world.Export(computer_id)
	Banlist.dir.Add(src.address)
	return()
/client.Import()
	return()

//world.Topic(A)
//	var/R=A
//	world.log<<"[R]"
//	var/B=copytext(R,1,((lentext(R))-5))
//	for(var/mob/M in world)
	//	world.Export("[B]?DADA")
//	..()

proc/Save_Spawns()
	var/savefile/F = new("Data/Spawns.sav")
	F["Tsufurujin_SpawnX"] << Tsufurujin_SpawnX
	F["Tsufurujin_SpawnY"] << Tsufurujin_SpawnY
	F["Tsufurujin_SpawnZ"] << Tsufurujin_SpawnZ
	F["Saiyan_SpawnX"] << Saiyan_SpawnX
	F["Saiyan_SpawnY"] << Saiyan_SpawnY
	F["Saiyan_SpawnZ"] << Saiyan_SpawnZ
	F["Namekian_SpawnX"] << Namekian_SpawnX
	F["Namekian_SpawnY"] << Namekian_SpawnY
	F["Namekian_SpawnZ"] << Namekian_SpawnZ
	F["Demon_SpawnX"] << Demon_SpawnX
	F["Demon_SpawnY"] << Demon_SpawnY
	F["Demon_SpawnZ"] << Demon_SpawnZ
	F["Changeling_SpawnX"] << Changeling_SpawnX
	F["Changeling_SpawnY"] << Changeling_SpawnY
	F["Changeling_SpawnZ"] << Changeling_SpawnZ
	F["Kaio_SpawnX"] << Kaio_SpawnX
	F["Kaio_SpawnY"] << Kaio_SpawnY
	F["Kaio_SpawnZ"] << Kaio_SpawnZ
	F["Oni_SpawnX"] << Oni_SpawnX
	F["Oni_SpawnY"] << Oni_SpawnY
	F["Oni_SpawnZ"] << Oni_SpawnZ
	F["Demi_SpawnX"] << Demi_SpawnX
	F["Demi_SpawnY"] << Demi_SpawnY
	F["Demi_SpawnZ"] << Demi_SpawnZ
	F["Makyojin_SpawnX"] << Makyojin_SpawnX
	F["Makyojin_SpawnY"] << Makyojin_SpawnY
	F["Makyojin_SpawnZ"] << Makyojin_SpawnZ
	F["Human_SpawnX"] << Human_SpawnX
	F["Human_SpawnY "]<< Human_SpawnY
	F["Human_SpawnZ"] << Human_SpawnZ
	F["Doll_SpawnX"] << Doll_SpawnX
	F["Doll_SpawnY"] << Doll_SpawnY
	F["Doll_SpawnZ"] << Doll_SpawnZ

proc/Load_Spawns()
	if(fexists("Data/Spawns.sav"))
		var/savefile/F = new("Data/Spawns.sav")
		F["Tsufurujin_SpawnX"] >> Tsufurujin_SpawnX
		F["Tsufurujin_SpawnY"] >> Tsufurujin_SpawnY
		F["Tsufurujin_SpawnZ"] >> Tsufurujin_SpawnZ
		F["Saiyan_SpawnX"] >> Saiyan_SpawnX
		F["Saiyan_SpawnY"] >> Saiyan_SpawnY
		F["Saiyan_SpawnZ"] >> Saiyan_SpawnZ
		F["Namekian_SpawnX"] >> Namekian_SpawnX
		F["Namekian_SpawnY"] >> Namekian_SpawnY
		F["Namekian_SpawnZ"] >> Namekian_SpawnZ
		F["Demon_SpawnX"] >> Demon_SpawnX
		F["Demon_SpawnY"] >> Demon_SpawnY
		F["Demon_SpawnZ"] >> Demon_SpawnZ
		F["Changeling_SpawnX"] >> Changeling_SpawnX
		F["Changeling_SpawnY"] >> Changeling_SpawnY
		F["Changeling_SpawnZ"] >> Changeling_SpawnZ
		F["Kaio_SpawnX"] >> Kaio_SpawnX
		F["Kaio_SpawnY"] >> Kaio_SpawnY
		F["Kaio_SpawnZ"] >> Kaio_SpawnZ
		F["Oni_SpawnX"] >> Oni_SpawnX
		F["Oni_SpawnY"] >> Oni_SpawnY
		F["Oni_SpawnZ"] >> Oni_SpawnZ
		F["Demi_SpawnX"] >> Demi_SpawnX
		F["Demi_SpawnY"] >> Demi_SpawnY
		F["Demi_SpawnZ"] >> Demi_SpawnZ
		F["Makyojin_SpawnX"] >> Makyojin_SpawnX
		F["Makyojin_SpawnY"] >> Makyojin_SpawnY
		F["Makyojin_SpawnZ"] >> Makyojin_SpawnZ
		F["Human_SpawnX"] >> Human_SpawnX
		F["Human_SpawnY "]>> Human_SpawnY
		F["Human_SpawnZ"] >> Human_SpawnZ
		F["Doll_SpawnX"] >> Doll_SpawnX
		F["Doll_SpawnY"] >> Doll_SpawnY
		F["Doll_SpawnZ"] >> Doll_SpawnZ
