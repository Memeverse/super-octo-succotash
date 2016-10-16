mob/player //The player mob

/*
mob/player/saiyan
mob/player/changeling
mob/player/namek
mob/player/human
mob/player/android
mob/player/majin
mob/player/bio
mob/player/tsufu
mob/player/spiritdoll
mob/player/makyo
mob/player/alien
*/
mob/Login()
	src << 'title.ogg'
	winset(src,"Maximize","pos = 0,25")
	winset(src,"StatsButton","pos = 35,25")
	//src.Creation()
	if(src.type==/mob)
		logAndAlertAdmins("[key_name(src)] logged in with the wrong mob type! They have been kicked off. This error has been logged.")
		log_errors("[key_name(src)] LOGGED IN WITH WRONG MOBTYPE IN mob/Login() !")
		alert("Something went wrong and you have the wrong mob type. Please relog or remake.")
		del(src)
		return

	if(src)
		if(src.client)
			if(!src.client.holder)
				if(!global.ItemsLoaded||!global.MapsLoaded)
					src << "This server has not yet finished loading its files. Please wait patiently for a few minutes."
					src << "You have been disconnected."
					del(src)
					return

	if(src)
		if(!istype(src, /mob/observer) && !src.icon)
			Choose_Login()
			while(src && client && !src.icon)	//We sit here until they select a file in load_character
				//winset(src,"mapwindow.map1","focus=true")
				sleep(10)
/*
		else if(istype(src, /mob/observer))
			var/mob/observer/O = src
			if(!O.body)
				spawn alert("You logged in as an observer, please pick a character to load!")
				if(src)
					Load_Character()
*/
	if(!src)
		return
	if(!real_name)
		alert("A new 'realname' system has been implemented, please retype your PERMANENT name!")
		Name()
	//Allows storing of memories on a per mob basis

	if(!src.mind)
		src.mind = new /datum/mind
		src.mind.key = src.key
		src.mind.current = src
	if(src)
		if(src.client)
			if(src.client.holder)
				var/html_doc="<head><title>Admin Notes</title></head><body bgcolor=#000000 text=#FFFF00><center>[Notes]"
				src<<browse(html_doc,"window=Admin Notes")
	src.verbs += /mob/proc/add_memory
	src.verbs += /mob/proc/read_mind	//Funny shit
	src.verbs += /mob/proc/check_memory
	src << sound(null)
	//src.CheckOS()
	src.MapFocus()
	winshow(src, "maintitle",0)
	src.mind.current = src	//You might say this is backwards :3

	luminosity = 0	//Hey people don't glow. usually. we assume they don't right now!


	if(src) if(src.client)
		src.lastKnownIP = src.client.address
		src.computer_id = src.client.computer_id
		src.lastKnownKey = src.client.key

	if(!Players.Find(src))
		if(!istype(src, /mob/observer))	//So when an admin goes back to their body it doesn't log
			if(src==null) return  //If this breaks the stuff below, alter the position of where it occurs in the code.  Added during the Deviant/Xirre/Arch code jam thing.
			if(!src.client) return
			log_access("[key_name(src)] | [src.client.address ? src.client.address : "localhost"] | [src.client.computer_id ? src.client.computer_id : "unknown" ]", type="LOGIN")	//Don't need to spam log with admins observing
		//No duplicates
		Players += src
	for(var/mob/player/M in Players)
		if(M.key != "Blathers")
			if(M == src)
				continue
			if(M.client && M.client.address == src.client.address)
				log_access("[key_name(src)] | [src.client.address ? src.client.address : "localhost"] | [src.client.computer_id ? src.client.computer_id : "unknown" ] | has the same IP address as [key_name(M)]", type="NOTICE")
				alertAdminsLogin("<font color='red'><B>Notice:</font></B> <A href='?src=\ref[src];priv_msg=\ref[src]'>[key_name_admin(src)]</A> has the same <font color='red'><B>IP address</B></font> as <A href='?src=\ref[src];priv_msg=\ref[M]'>[key_name_admin(M)]</A>", 1)
			else if (M.lastKnownIP && M.lastKnownIP == src.client.address && M.ckey != src.ckey && M.key)
				log_access("[key_name(src)] | [src.client.address ? src.client.address : "localhost"] | [src.client.computer_id ? src.client.computer_id : "unknown" ] | had the same IP as [key_name(M)] and is no longer logged in.", type="NOTICE")
				alertAdminsLogin("<font color='red'><B>Notice:</font></B> <A href='?src=\ref[src];priv_msg=\ref[src]'>[key_name_admin(src)]</A> has the same <font color='red'><B>IP address</B></font> as [key_name_admin(M)] did ([key_name_admin(M)] is no longer logged in).", 1)
			if(M.client && M.client.computer_id == src.client.computer_id)
				log_access("[key_name(src)] | [src.client.address ? src.client.address : "localhost"] | [src.client.computer_id ? src.client.computer_id : "unknown" ] | has same computer ID as [key_name(M)]", type="NOTICE")
				alertAdminsLogin("<font color='red'><B>Notice:</font></B> <A href='?src=\ref[src];priv_msg=\ref[src]'>[key_name_admin(src)]</A> has the same <font color='red'><B>computer ID</B></font> as <A href='?src=\ref[src];priv_msg=\ref[M]'>[key_name_admin(M)]</A>", 1)
				spawn() alert("You have logged in already with another key, please be sure to read/ask about the server rules regarding the use of multiple keys!")
			else if (M.computer_id && M.computer_id == src.client.computer_id && M.ckey != src.ckey && M.key)
				log_access("[key_name(src)] | [src.client.address ? src.client.address : "localhost"] | [src.client.computer_id ? src.client.computer_id : "unknown" ] | had the same computer ID as [key_name(M)] and is no longer logged in).", type="NOTICE")
				alertAdminsLogin("<font color='red'><B>Notice:</font></B> <A href='?src=\ref[src];priv_msg=\ref[src]'>[key_name_admin(src)]</A> has the same <font color='red'><B>computer ID</B></font> as [key_name_admin(M)] did ([key_name_admin(M)] is no longer logged in).", 1)
				spawn() alert("You have already logged in on another key! You can not have two characters on the same planet. The Afterlife as a whole (Hell, Checkpoint and Heaven) is considered one planet. Sharing anything between characters (resources, skills, technology) will likely result in a wipe ban for the first offence.")


	src.client.show_verb_panel=1 // We want them to see the verb panel Skills and Other after they're logged in. Herp Derp.
	src.overlays -= 'Typing.dmi'
	src.overlays -= /obj/magic_effects/tele
	src.Update_Player()
	if(!Reward_Key_List.Find(src.client.key))
		Reward_Key_List += src.client.key
	var/New_Instance = 1
	for(var/obj/Reward_Instance/RI in Reward_List)
		if(findtext(RI.Reward_Save,"[src.real_name]"))
			New_Instance = 0
	if(New_Instance)
		var/obj/Reward_Instance/O = new
		O.name = "[src.client.key] - [src.real_name]"
		O.Reward_Key = "[src.client.key]"
		if(src.real_name)
			O.Reward_Save = "[src.real_name]"
		if(src.icon)
			var/icon/A=new(src.icon)
			O.icon = A
		for(var/icon/X in src.overlays) if(X.icon)
			var/icon/A2=new(X.icon)
			O.overlays += A2
		Reward_List += O
	for(var/obj/Reward_Instance/R in Reward_List)
		if(R.Reward_Key == src.client.key) if(R.Reward_Save == src.real_name)
			R.name = "[src.client.key] - [src.real_name]"
			R.Reward_Key = "[src.client.key]"
			R.icon = null
			R.overlays = null
			if(src.icon)
				var/icon/A=new(src.icon)
				R.icon = A
			for(var/icon/X in src.overlays) if(X.icon)
				var/icon/A2=new(X.icon)
				R.overlays += A2
		if(R.Reward_Confirmed == "Yes")if(R.Reward_Given == "No") if(R.Reward_Save == src.real_name)
			R.Reward_Given = "Yes"
			var/N = 1
			if(R.Reward_Tier == "Low")
				N = Rewards_Low
			if(R.Reward_Tier == "Medium")
				N = Rewards_Medium
			if(R.Reward_Tier == "Medium High")
				N = Rewards_Medium_High
			if(R.Reward_Tier == "High")
				N = Rewards_High
			N = N * src.BPMod
			if(R.Reward_Revert == 1)
				src.Base -= N
				src.MaxKi -= Rewards_Energy
				src.Ki = src.MaxKi
				R.Reward_Revert = 0
				alertAdmins("[src]'s reward was just reverted.")
			else
				src.Base += N
				src.MaxKi += Rewards_Energy
				src << "Your reward has been given."
			break
	//src.verbs -= /mob/player/verb/Shadow_Spar  // Dont want them to keep this verb.

/*	if(global.TestServerOn)
		src<<"<span class=\"announce\"><b>If you find bugs, report them. There's a verb called 'Report' for that.</b></span>"
		src<<"<span class=\"announce\">You have Give Rank</span>"
		src.client.verbs += /client/proc/Give_Rank
	//src.StatRank() // Update the Statrank once a player has logged in.
	if(src.Health>100)Health=100

	log_access("[key_name(src)] | [src.client.address ? src.client.address : "localhost"] | [src.client.computer_id ? src.client.computer_id : "unknown" ]", type="LOGIN")
	src.saveToLog("| ([src.x], [src.y], [src.z]) | (IP: [src.client.address] | PCID: [src.client.computer_id] ) | [key_name(src)] logs in\n")
	Cancel_Sched_OnLogout(src)

	if(src.icon_state!="KO"&&src.BPpcnt>100)
		if(client)  //NULL VAR BUG FIX -  Attempt to remove constant null PC Drain () calls.
			spawn(1) PC_Drain(src)

	adminObserve = 0
	src.RemoveWaterOverlay()
	spawn(1) src.checkSwimming()
	if(src.ckey == "wtfdontbanme" || "extrakey")
		if(Server_Activated == 0)
			var/P = input(src,"Input password for the server. In doing so, you allow players to connect to this world and for it to host online. Leaving this blank or entering the wrong password will force the world to close.") as text
			if(P == global.Password)
				Server_Activated = 1
				world << "<font color = yellow><font size = 6>[src.key] has activated the world, allowing others to join and for the server to be hosted."
				SaveActivation()
			else
				world << "<font color = yellow><font size = 6>[src.key] failed or refused to activate the world, it will close now."
				del(world)
		else
			src << "<font color = green>This server is activated and can be hosted."*/

mob/observer/Logout()
	//Stop_TrainDig_Schedulers(src)
	//Cancel_Sched_OnLogout(src)
	Players -= src
	//Yay copy pasta
	//for(var/obj/items/Dragon_Ball/A in src)	//Remove dragonballs from their person
	//	A.loc=loc
	//del(body)
	//del(src)
	..()

mob/Logout()

/*
	if(istype(src, /mob/observer))
		Players -= src
		//Yay copy pasta
		for(var/obj/items/Dragon_Ball/A in src)	//Remove dragonballs from their person
			A.loc=loc
		del(body)
		del(src)
	else if(adminObserve)*/
	Alien_Revert()
	src.Spell_Power = 0
	src.Spell_Cost = 0
	src.RemoveWaterOverlay()
	//src.verbs -= /mob/player/verb/Shadow_Spar // Dont want them to keep this verb.
	//stopSwimming()
	if(say_spark)
		overlays-=say_spark
	if(adminObserve)
		Save()	//Just save, don't do anything else
		return
	else
		if(key)
			Cancel_Sched_OnLogout(src)

			Players-=src
			//for(var/obj/Blast/A in world)	//Delete stray blasts
			//	if(A.Owner == usr)
			//		del(A)
			orange(12,src) << "[src.name] has logged out."
			log_access("[key_name(src)]", type="LOGOUT")
			src.saveToLog("| ([src.x], [src.y], [src.z]) | (IP: [lastKnownIP] | PCID: [computer_id] ) | [key_name(src)] logs out\n")
			for(var/obj/items/I in src)
				if(I.detections)
					I.detections = null
					I.detections = list()
			for(var/obj/items/Magic_Ball/A in src)	//Remove dragonballs from their person
				if(isobj(src.loc))
					var/obj/O = src.loc
					A.loc=O.loc
				else
					A.loc=loc
			for(var/obj/items/Phylactery/A in src)	//Remove dragonballs from their person
				if(isobj(src.loc))
					var/obj/O = src.loc
					A.loc=O.loc
				else
					A.loc=loc
			Save()

			if(gSpamFilter.sf_SpamControlOpen=="[src.client]")
				gSpamFilter.sf_Close_Window()

			if(icon_state == "KO")
				view(src) << "Their body will disappear in 1 minute."
				alertAdmins("[key_name(src)] logged out while koed.")
				Logged_Out_Body=1
				spawn(600)
					if(src)
						Save()
						if(!client)
							del(src)
				return
		del(src)

/mob/Topic(href, href_list)
	if(href_list["priv_msg"])
		var/mob/M = locate(href_list["priv_msg"])
		if(M)
			if(src)if(src.client.muted)
				src << "You are muted have a nice day"
				return
			if (!( ismob(M) ))
				return
			var/t = input("Message:", text("Private message to [M.key]"))  as text
			if (!( t ))
				return
			if (src.client && src.client.holder)
				M << "<span class=\"admin\">Admin PM from-<b>[key_name(src, M, 0)]</b>: [t]</span>"
				src << "<span class=\"admin\">Admin PM to-<b>[key_name(M, src, 1)]</b>: [t]</span>"
			else
				if (M.client && M.client.holder)
					M << "<span class=\"admin\">Reply PM from-<b>[key_name(src, M, 1)]</b>: [t]</span>"
				else
					M << "<span class=\"admin\">Reply PM from-<b>[key_name(src, M, 0)]</b>: [t]</span>"
				src << "<span class=\"admin\">Reply PM to-<b>[key_name(M, src, 0)]</b>: [t]</span>"

			log_admin("PM: [key_name(src)]->[key_name(M)] : [t]")

			//we don't use alertAdmins here because the sender/receiver might get it too
			for (var/mob/player/K in world)
				if(K && K.client && K.client.holder && K.key != src.key && K.key != M.key)
					K << "<b><span class=\"admin\">PM: [key_name(src, K)]->[key_name(M, K)]:</b> [t]</span>"
	..()
	return

mob/proc/Load_Character()
	var/filedialog/F = new(src, /mob/proc/LoadSaveChar)

	F.msg = "Choose a character."   // message in the window
	F.title = "Load Character"      // popup window title
	F.root = "Data/Players/[key]/Characters/"               // directory to use
	F.saving = 0                    // saving? (false is default)
	F.default_file = "[key].sav"    // default file name
	F.ext = ".sav"                  // default extension
	F.filter = ".sav"               // only want them to be able to pick .sav files

	F.Create(src.client)            // now display the dialog

mob/proc/LoadSaveChar(filename, saving)
	var/savefile/F = new(filename)
	if(length(F)<1024 && !saving)	//less then a kb isn't enough for a save
		spawn if(src) Load_Character()
		del(src)
		return
	if(saving)
		//Write(F)
		F["Player"] << src

		//var/_contacts = list() // create a temporary list
		//for(var/obj/Contact/A in src) // loop through the contacts in the inventory
			//var/obj/Contact/c = new() // make a new object for each contact and set their variables
			//c.pkey = A.pkey
			//c.name = A.name
			//c.familiarity = A.familiarity
			//c.suffix = A.suffix
			//_contacts += A // add it to the temporary list

		//F["Contacts"] << _contacts // write the temporary list to the savefile

	else
		//Read(F)
		client.Load(filename)

client/proc/Load(filename)
	var/savefile/F = new(filename)
	F["Player"] >> src.mob

	//var/_contacts = list()
	//F["Contacts"] >> _contacts
	//for(var/obj/Contact/A in _contacts)
	//	A.loc = src.mob
	// contacts are still saved via << src being written in the first place. So we're going to empty them first and then read them in properly
/*
	for(var/obj/Contact/A in src.mob.contents)
		del(A)

	// And now we're going to add the contacts we saved
	for(var/obj/Contact/A in _contacts) // loop through the contacts in the inventory
		var/obj/Contact/c = new
		c.pkey = A.pkey
		c.name = A.name
		c.familiarity = A.familiarity
		c.suffix = A.suffix
		src.mob.contents += c
		sleep(-1)
*/

mob/proc/Save()
	if(lastKnownKey && real_name)
		if(z && !Regenerating)
			savedX = x
			savedY = y
			savedZ = z
		if(S && S.z)
			savedX = S.x
			savedY = S.y
			savedZ = S.z
		//Actual saving
		LoadSaveChar("Data/Players/[lastKnownKey]/Characters/[real_name].sav",1)
	//else
		//src << "Failed to save your mob as you have no lastKnownKey or real_name!"
		//log_game("Saving [key_name(src)] failed as lastKnownKey or real_name was null!")

mob/proc/Choose_Login() if(client && !istype(src,/mob/observer))
	switch(alert(src,"Make your choice","","New","Load","Exit"))
		if("Exit")
			del(src)
			return
		if("New")
			New_Character()
		if("Load")
			if(fexists("Data/Players/[key]/Characters/"))
				Load_Character()
			else
				alert("You have no saved characters")
				Choose_Login()
				return

mob/proc/Remove_Duplicate_Moves()
	var/list/Moves=new
	for(var/obj/O in src) if(!istype(O,/obj/items))
		if(O.type in Moves) del(O)
		else Moves+=O.type

mob/proc/Update_Player() // Only called for a new character and a returning character logging in.
	ASSERT(src)
	var/image/A = image(icon='Say Spark.dmi',pixel_y=6)
	if(A)
		A.icon -= rgb(255,255,255)
		A.icon += rgb(100,200,250)
	overlays.Remove('AbsorbSparks.dmi','TimeFreeze.dmi','SBombGivePower.dmi',BlastCharge,A)
	if(icon_state == "KO")
		Un_KO()
		KO("(logged in KO'd)")
	spawn	if(src) Gravity()

	spawn	if(src) Status()
	spawn	if(src) Contacts()
	spawn	if(src) Injury_Healing()

	spawn	if(src) Learn()

	spawn	if(src) Remove_Duplicate_Moves()
	spawn	if(src) Age_Update()
	spawn	if(src) Stat_Labels_Visible()
	Tabs = 1
	if(client)
		client.view="[ViewX]x[ViewY]"
		client.show_verb_panel=1
		client.show_map=1
	if(icon == 'Oozbody.dmi')
		Oozaru_Revert()
		Oozaru()
	for(var/obj/Reincarnation/R in Reincarnations)
		if(R.name==key)
			del(R)

	//spawn(20) src.showBuildGrid()
	//loadContacts()

	spawn(600)
		if(src)
			checkNullTanks()
			checkNullPhylactery()

			if(insideTank) // If they're still being revived
				if(insideTank in glob_ClonTanks) // If the tank they should be revived at still exists
					Clone_Awaken(src,insideTank) // Retrigger the activation
				else
					insideTank=null // FIRST set this to null and THEN trigger death, incase they have another tank.
					if(!Dead)
						src << "Your cloning tank is destroyed!"
						Death(src)
			if(insidePhylactery) // If they're still being revived
				if(insidePhylactery in glob_Phylactery) // If the tank they should be revived at still exists
					Phylactery_Awaken(src,insidePhylactery) // Retrigger the activation
				else
					insidePhylactery=null // FIRST set this to null and THEN trigger death, incase they have another tank.
					if(!Dead)
						src << "Your phylactery is destroyed!"
						Death(src)


/*
* Status_Event creation moved from the Status() proc
* Perhaps this will solve the odd issues we seem to have with double updates.
*/
/*
	if(isnull(src.status_event))
		src.status_event = new(status_scheduler, src)
		status_scheduler.schedule(src.status_event, 12)
*/

/*
	if(locate(/obj/Noobify) in src)
		if(!(key in Alliance))
			Alliance+=key
	if(key in Alliance)
		if(!(locate(/obj/Noobify) in src))
			contents += new/obj/Noobify
*/

mob/verb/Races()
	var/list/Races=new
	for(var/mob/player/A in Players) if(!(A.Race in Races))
		var/Amount=0
		Races+=A.Race
		for(var/mob/player/B in Players) if(B.Race==A.Race) Amount++
		src<<"[A.Race]: [Amount]"

mob/verb/Overlays()
	set category="Other"
	overlays = null
	underlays = null
	if(Dead)
		overlays += 'Halo Custom.dmi'

mob/proc/Percent(A)
	return "[round(100*(A/(Str+End+Pow+Res+Off+Def)),0.1)]%"

mob/proc/Knockback()
	Stop_TrainDig_Schedulers()
	if(istype(src,/mob/observer))
		return
	for(var/obj/A in view(1,src)) if(A.z) //if(A.type!=/obj/Dust)
		var/Knock_Range=0
		if(BP>=10000000) Knock_Range=1
		if(Knock_Range||get_dir(src,A)==dir)
			if(isnum(A.Health)) A.Health-=BP*0.1
			if(A.Health<=0)
				new/obj/Crater(locate(A.x,A.y,A.z))
				del(A)
	for(var/turf/A in view(1,src)) if(!A.Water)
		var/Knock_Range=0
		if(BP>=10000000) Knock_Range=1
		if(Knock_Range||get_dir(src,A)==dir) //if(A.density)
			var/Damage=BP*0.1
			if(!A.density) Damage*=0.2
			if(isnum(A.Health)) A.Health-=Damage
			if(A.Health<=0)
				if(A.density)
			//		Stir_Up_Dust(A,30)
					if(src!=0) A.Destroy(src,src.key)
					else A.Destroy("Unknown","Unknown")
				else if(!(icon_state in list("Flight")))
				//	Stir_Up_Dust(A,2)
					var/Amount=1
					while(Amount)
						Amount-=1
						var/image/I=image(icon='Damaged Ground.dmi',pixel_x=rand(-16,16),pixel_y=rand(-16,16))
						A.overlays+=I
						A.Remove_Damaged_Ground(I)
mob/verb/Warp()
	set category="Other"
	if(attacking) return

	if(!Warp)
		usr<<"Warping on"
		Warp=1
	else
		usr<<"Warping off"
		Warp=0
		Frozen=1
		spawn(20) Frozen=0

mob/Bump(mob/A)

	if(ghostDens_check(src))
		A.density=0
		spawn(12) A.density=1
		return

	if(istype(A,/obj/Final_Realm_Portal))
		loc=locate(rand(163,173),rand(183,193),5)
		if(src.inertia_dir)
			src.inertia_dir=0
		return
	if(istype(A,/obj/Warper))
		var/obj/Warper/B=A
		loc=locate(B.gotox,B.gotoy,B.gotoz)
	if(client&&istype(A,/obj/Door))
		var/obj/Door/B=A
		for(var/obj/items/Door_Pass/D in src) if(D.Password==B.Password)
			B.Open()
			return
		if(B.Password)
			var/Guess=input(src,"You must know the password to enter here") as text
			if(B) if(Guess!=B.Password) return
		if(B) B.Open()
	if(istype(A,/obj/Ships/Ship))
		var/obj/Ships/Ship/B=A
		for(var/obj/Airlock/C in world) if(C.Ship==B.Ship)
			view(src)<<"[src] enters the ship"
			if(src.inertia_dir)
				src.inertia_dir=0	//If they entered from space\
				src.last_move=null
			loc=locate(C.x,C.y-1,C.z)
			break
	if(istype(A,/obj/AndroidShips/Ship))
		var/obj/AndroidShips/Ship/B=A
		for(var/obj/AndroidAirlock/C in world) if(C.Ship==B.Ship)
			view(src)<<"[src] enters the ship"
			if(src.inertia_dir)
				src.inertia_dir=0	//If they entered from space\
				src.last_move=null
			loc=locate(C.x,C.y-1,C.z)
			break
	if(ismob(A)) if(!client|icon=='Oozbody.dmi')
		MeleeAttack()
		if(sim&&A.Health<=20)
			usr<<"Simulator: Simulation cancelled due to safety protocols."
			del(src)
		if(A&&istype(src,/NPC_AI)&&A.icon_state=="KO"&&prob(1)) spawn A.Death(src)
	if(istype(A,/obj/Planets))
		Bump_Planet(A,src)
		src.Heart_Virus()
	if(isobj(A)&&istype(src,/NPC_AI/Hostile))
		var/Old_Strength=Str
		Str*=1000
		MeleeAttack()//Busting down objects.
		Str=Old_Strength


var/global/const/SAVEFILE_VERSION = 23

/*mob/verb/readsavefile(var/sav as text)
	set name = "readsav"
	set category = "1"
	if(sav)
		src.Read(sav)*/

mob/Read(savefile/S)
	//src << "Save V. [SAVEFILE_VERSION]"
	var/lastused = S["lastused"]
	if(src.Base <= 8000) if(src.Race == "Saiyan")
		src.Base = 8000
	if(lastused)	//Only players
		var/version = S["savefile_version"]
		if(!version)
			version = 0
		src << "Save file version [version]"

		..()	//We do this after the savefile check because we might need to null stuff out
				//in the save before we load or something like that

		if(version < 23)
			if(src.Race == "Android")
				src.DNAs = null
				src.DNAs = list()
				src.Add += 1
			if(src.Race == "Majin")
				src.DNAs = null
				src.DNAs = list()
		if(version < 22)
			src.Create_DNA()
		if(version < 21)
			src.RP_Total = 50 * src.Real_Age
			if(src.Race == "Demon" || "Kaio")
				src.Vampire_Immune = 1
			if(src.Race == "Namekian")
				src.FusionLearnable = 1
			if(src.Race == "Saiyan")
				if(src.Class == "Legendary")
					if(!Rares.Find("LSSJ"))
						Rares += "LSSJ"
			if(src.Vampire == 2)
				if(!Rares.Find("AV"))
					Rares += "AV"
			if(src.Race == "Majin")
				if(!Rares.Find("Majin"))
					Rares += "Majin"
			if(src.Race == "Bio-Android")
				if(!Rares.Find("Bio"))
					Rares += "Bio"
			if(src.Race == "Android")
				if(src.Age > 1000)
					if(!Rares.Find("AA"))
						Rares += "AA"
				src.AS_Droid = 1
				if(src.KiMod > 5)
					while(src.KiMod != 5)
						src.KiMod -= 0.5
						for(var/obj/Resources/R in src)
							R.Value += 20000000
					src << "Your Energy Mod was taken down to 5 due to an important balance change for the game. However, you were fully refunded for the investment you made."
		if(version < 4)
			src.MaxKi += 100
			src << "You were awarded 100 energy due to all the disturbances to rp."
			if(src.Race == "Saiyan")
				if(src.Class == "Low-Class")
					src.MaxAnger = 200
				if(src.Class == "Normal")
					src.MaxAnger = 175
				if(src.Class == "Elite")
					src.MaxAnger = 150
			if(src.Vampire)
				src.undelayed = 1
				src.NoLoss = 1
			if(src.Race == "Android")
				NoLoss = 1
			if(src.Race == "Saiyan")
				src.KiMod += 0.5
			if(src.Race == "Demigod")
				src.KiMod -= 1
		src << "Save file version [version]"
		if(S["x"] && S["y"] && S["z"])	//Check here first
			loc = locate(S["x"],S["y"],S["z"])
		if(savedX && savedY && savedZ)	//Fallback
			loc = locate(savedX, savedY, savedZ)
		else	//Oh god
			loc = locate(1,1,1)
			alertAdmins("[key_name(src, include_link=1)] logged in without a saved location! Please assist them!")
		if(version < 22)
			if(src.z == 1)
				src.Heart_Virus_Immune = 1
	else	//This is an npc save
		..(S)
	if(loc)
		loc.Entered(src)

mob/Write(savefile/S)
//	sleep(1)  //  - CPU OPTIMIZATION TEST POINT
	..(S)
	if(lastKnownKey || lastKnownIP)	//Only players
		S["savefile_version"] << SAVEFILE_VERSION
		S["x"] << savedX
		S["y"] << savedY
		S["z"] << savedZ
		S["lastused"] << world.realtime
	if(S["lastused"] == null)
		S["lastused"] << "Error"

/*mob/verb/Fix_Save(savefile/S)
	for(src)
		S["lastused"] << "Error"  Start of an experimental verb to ensure no null read() errors occur.  Removed because Deviant and I may have fixed it.*/
