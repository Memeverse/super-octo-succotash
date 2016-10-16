mob/var/tmp/list/Lootables=list()
obj/Cancel_Loot
	name="Cancel"
	Click()
		usr.Lootables=null//if(usr.Lootables || usr.Lootables.len) usr.Lootables=null
		usr.Lootables = list()

client/Click(atom/A)
	if(mob&&isobj(A)&&(A in mob.Lootables)&&!istype(A,/obj/Cancel_Loot)) for(var/mob/player/B in Players) if(A in B)
		if(B.icon_state!="KO")
			usr<<"They are no longer knocked out"
			mob.Lootables=null
			return
		if(!(A in B))
			src<<"Someone has already taken it"
			mob.Lootables-=A
			return
		if(!(B in oview(1,mob)))
			src<<"You are not near them"
			mob.Lootables=null
			return
		view(mob)<<"[mob]([src]) steals [A] from [B]"
		for(var/mob/player/M in view(mob)) if(M.client) M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] stole [A] from [key_name(B)].\n")
		mob.Lootables-=A
		if(istype(A,/obj/Resources)) for(var/obj/Resources/R in mob)
			var/obj/Resources/C=A
			R.Value+=C.Value
			C.Value=0
		else if(istype(A,/obj/Mana)) for(var/obj/Mana/R in mob)
			var/obj/Mana/C=A
			R.Value+=C.Value
			C.Value=0
		else
			B.overlays-=A.icon
			if(A.suffix)
				if(A.suffix == "*Equipped*")
					B.Equip_Magic(A,"Remove")
					A.suffix = null
					if(istype(A,/obj/items/Bandages))
						B.Bandages()
				if(B)
					B.Click(A)
			if(A)
				mob.contents+=A
	else ..()

mob/player/Stat() if(Tabs)
	ASSERT(src)  //null bug marker
	var/Looting
	for(var/obj/A in Lootables) Looting=1
	if(src.afk) if(src.client.inactivity <= 100) if(src.client.inactivity >= 0) if(src.Went_Afk == 0) if(!src.client.holder)
		src.TRIGGER_AFK(0)
	if(src.client.inactivity>=afk_time) 	// If they're gone long enough.
		if(!src.afk) 				// And they're not AFK.
			src.TRIGGER_AFK(1) 				// Trigger afk() so they become inactive.
		//This bit is if they haven't been gone long enough.
//	else
//		if(src.afk&&src.afk!=2) //If they happen to be AFK...
//			src.TRIGGER_AFK(1) //Trigger afk() so they can return.

	if(src.client.holder && src.show_ranks)
		statpanel("Ranks")
		if(statpanel("Ranks"))
			for(var/obj/R in Rankings)
				stat(R)
				stat("Rank Name - [R.name]")
				stat("Rank Player Name - [R.Rank_Player_Name]")
				stat("Rank Key - [R.Rank_Key]")
				stat("Rank Online - [R.Rank_Online]")
				stat("Rank Inactivity Time - [R.Rank_AFK] seconds")
				stat("Rank Total Inactivity Time - [R.Rank_AFK_Total] seconds")
				stat("Rank Last Online - [R.Rank_Activity]")
				stat("Rank RP Points - [R.Rank_RP]")
				stat("Rank Total Emotes/Says - [R.Rank_Emotes]")
				stat("---------------------------------------------------------------------------------------")
	if(Rewards_Active && src.client.holder && src.show_rewards)
		statpanel("Rewards Pending")
		if(statpanel("Rewards Pending"))
			for(var/obj/O in Reward_List)
				if(O.Reward_Confirmed == "No")
					stat(O)
					stat("Reward Given - [O.Reward_Given]")
					stat("Reward Tier - [O.Reward_Tier]")
					stat("Reward Confirmed - [O.Reward_Confirmed]")
					stat("---------------------------------------------------------------------------------------")
		statpanel("Rewards Complete")
		if(statpanel("Rewards Complete"))
			for(var/obj/O in Reward_List)
				if(O.Reward_Confirmed == "Yes")
					stat(O)
					stat("Reward Given - [O.Reward_Given]")
					stat("Reward Tier - [O.Reward_Tier]")
					stat("Reward Confirmed - [O.Reward_Confirmed]")
					stat("---------------------------------------------------------------------------------------")

	if(Looting)
		statpanel("Looting")
		if(statpanel("Looting")) stat(Lootables)
	if(Clothes)
		statpanel("Clothes")
		if(statpanel("Clothes")) stat(Clothing)
	if(Tabs==10)
		for(var/obj/Auras/A in src)
			statpanel("Auras")
			if(statpanel("Auras")) stat(A)
			else break
		for(var/obj/Charges/A in src)
			statpanel("Charges")
			if(statpanel("Charges")) stat(A)
			else break
		for(var/obj/Blasts/A in src)
			statpanel("Blasts")
			if(statpanel("Blasts")) stat(A)
			else break


	switch(Tabs)

		if("Choosing Alien Icon")
			statpanel("Icons")
			if(statpanel("Icons"))
				for(var/obj/Alien_Icons/A in src) stat(A)
	//			stat(Demon_Icons)
	//			stat(Android_Icons)
				return

		if("Demon Icons")
			statpanel("Icons")
			if(statpanel("Icons"))
				for(var/obj/Demon_Icons/A in src) stat(A)
				for(var/obj/Alien_Icons/A in src) stat(A)
	//			stat(Android_Icons)
				return

		if ("Android Icons")
			statpanel("Icons")
			if(statpanel("Icons"))
				for(var/obj/Android_Icons/A in src) stat(A)
				return

		if ("Makyo Icons")
			statpanel("Icons")
			if(statpanel("Icons"))
				for(var/obj/Makyo_Icons/A in src) stat(A)
				return

		if ("SD Icons")
			statpanel("Icons")
			if(statpanel("Icons"))
				for(var/obj/SD_Icons/A in src) stat(A)
				return

		if ("Oni Icons")
			statpanel("Icons")
			if(statpanel("Icons"))
				for(var/obj/Oni_Icons/A in src) stat(A)
				return

		if(3)
			statpanel("Form Icons")
			for(var/obj/Aquatian/A in src) stat(A)
		else
			//Stats
			var/atom/E
			if(S) E=S
			else E=src
			Stat_Labels()
			statpanel("Status")
			if(statpanel("Status"))
				if(Temperature) stat("Status:","[Temperature]")
				if(Poisoned>Immunity) stat("Status:","Poisoned x[Poisoned-Immunity]")

				if(Gravity<=10&&Health<0) Health=0
				if(Ki<0) Ki=0
				/*if(BPpcnt>100) stat("Battle Power","[round((Health*0.01)*(Ki/MaxKi)*(BPpcnt)*(Body/20)*(Anger/100))]% (+[round(BPpcnt-100,0.1)]%)")
				else if(BPpcnt<100) stat("Battle Power","[round((Health*0.01)*(Ki/MaxKi)*(BPpcnt)*(Body/20)*(Anger/100))]% (-[round(BPpcnt-100,0.1)]%)")
				else stat("Battle Power","[round((Health*0.01)*(Ki/MaxKi)*(BPpcnt)*(Body/20)*(Anger/100))]%")
				stat("Health","[round(Health)]%")
				stat("Energy","[round((Ki/MaxKi)*100)]%")*/
				if(viewstats)
					//stat("Battle Power",round(BP))
					stat("Skill leeching:","[Skill_Leech_On ? "On" : "Off"]")
					stat("Energy","[round(Ki)]")
					stat("Strength",Percent(Str))
					stat("Endurance",Percent(End))
					stat("Force",Percent(Pow))
					stat("Resistance",Percent(Res))
					//stat("Speed","[SpdMod]")
					stat("Offense",Percent(Off))
					stat("Defense",Percent(Def))
					//stat("Strength","[round(Str)] ([StrMod])")
					//stat("Durability","[round(End)] ([EndMod])")
					//stat("Force","[round(Pow)] ([PowMod])")
					//stat("Resistance","[round(Res)] ([ResMod])")
					//stat("Speed","[SpdMod]")
					//stat("Offense","[round(Off)] ([OffMod])")
					//stat("Defense","[round(Def)] ([DefMod])")
					//stat("Regeneration","[Regeneration]")
					//stat("Recovery","[Recovery]")
					stat("Energy Signature","[Signature]")
					stat("Alignment","[AlignmentTxt]")
					stat("Gravity","[Gravity]x")
					stat("Intelligence","[round(Int_Level)] ([Commas(Int_XP)] / [Commas(Int_Difficulty*(Int_Next/Add))])")
					stat("Magical Skill","[round(Magic_Level)] ([Commas(Magic_XP)] / [Commas(Magic_Difficulty*(Magic_Next/Magic_Potential))])")
					stat("Current Year","[round(Year)].[round((Year-round(Year))*10)]")
					stat("Role Play Points","[RP_Points]")
					stat("Role Play Points Total","[RP_Total]")
					stat("Rested Role Play Points","[RP_Rested]")
					stat("Total Emotes/Says","[RPs]")
				if(src.client.holder)
					stat("Processor","[world.cpu]% ([E.x],[E.y],[E.z])")
					stat("Year Speed","[Year_Speed]x (Once every [(9000/Year_Speed)/600] minutes)")
					stat("Gain Speed","[GG/Gain_Divider]%")
					stat("INT Gain Speed","[Admin_Int_Setting]")
					if(global.ItemsLoaded&&global.MapsLoaded) stat("Server is: ","OPEN FOR ALL")
					else if (!global.ItemsLoaded||!global.MapsLoaded) stat("Server is: ","ADMIN ONLY (ItemsLoaded: [global.ItemsLoaded] | MapsLoaded: [global.MapsLoaded])")
					stat("Hubtext","[global.HubText]")
					stat("Revive Loop","[global.reviveloop ? "Every [global.reviveloop] minutes" : "Off"]")
					stat("Energy Reward","[global.Rewards_Energy]")
					stat("Low Reward","[global.Rewards_Low]")
					stat("Medium Reward","[global.Rewards_Medium]")
					stat("Medium High Reward","[global.Rewards_Medium_High]")
					stat("High Reward","[global.Rewards_High]")
				//if(src.ckey=="wtfdontbanme")
					//stat("Ruin","[global.startRuin ? "ON" : "OFF"]")

			//Tabs
			if(S) if(S.Nav&&S.z==11)//if(S.Nav&&S.Planets&&S.z==11)
				statpanel("Navigation")
				if(statpanel("Navigation"))
					//for(var/obj/Planets/A) if(S.Planets.Find(A.name)) stat("[Direction(get_dir(S.loc,A.loc))]",A)
					for(var/obj/Planets/A) stat("[dir2text(get_dir(S.loc,A.loc))]",A)

			for(var/obj/Baby/A in src)
				statpanel("Baby!")
				if(statpanel("Baby!")) stat(A)
				else break
			if(!Toggled_Contacts)
				for(var/obj/Contact/A in src.Contacts)
					statpanel("Contacts")
					if(statpanel("Contacts")) stat(A)
					else break
			if(!Toggled_Inventory)
				for(var/obj/Resources/A in src)
					statpanel("Items")
					if(statpanel("Items"))
						A.suffix="[Commas(A.Value)]"
						stat(A)
					else break
				for(var/obj/Mana/M in src)
					statpanel("Items")
					if(statpanel("Items"))
						M.suffix="[Commas(M.Value)]"
						stat(M)
					else break
				if(Money) for(var/obj/Money/A in src)
					statpanel("Items")
					if(statpanel("Items")) stat(A)
					else break
				for(var/obj/items/O in src)
					statpanel("Items")
					if(statpanel("Items")) stat(O)
					else break
				for(var/obj/Faction/F in src)
					statpanel("Items")
					if(statpanel("Items")) stat(F)
					else break

/*
			if(world.maxz==100||Build&&(Year>=BirthYear+1||src.client.holder))
				statpanel("Build")
				if(statpanel("Build")) stat(Builds)
*/

/*
			if(TechTab)
				statpanel("Create")
				if(statpanel("Create"))
					stat("Intelligence","[round(Int_Level)] ([Commas(Int_XP)] / [Commas(Int_Difficulty*(Int_Next/Add))])")
					for(var/obj/Resources/A in src)
						A.suffix="[Commas(A.Value)]"
						stat(A)
					//stat(Technology)
					for(var/obj/Technology/A in techlist) stat(A)
*/
			if(!Toggled_Injuries)
				statpanel("Injuries")
				if(statpanel("Injuries"))
					stat("Head Damage","[Injury_Head]%")
					stat("Torso Damage","[Injury_Torso]%")
					stat("Left Arm Damage","[Injury_Left_Arm]%")
					stat("Right Arm Damage","[Injury_Right_Arm]%")
					stat("Left Leg Damage","[Injury_Left_Leg]%")
					stat("Right Leg Damage","[Injury_Right_Leg]%")
					stat("Throat Damage","[Injury_Throat]%")
					stat("Hearing Damage","[Injury_Hearing]%")
					stat("Sight Damage","[Injury_Sight]%")
					stat("Mating Ability Damage","[Injury_Mate]%")
					if(src.Race == "Saiyan")
						stat("Tail Damage","[Injury_Tail]%")
			for(var/obj/Cybernetics/A in src)
				statpanel("Modules")
				if(statpanel("Modules")) stat(A)
				else break
			//Cybernetic Sensor
/*
			for(var/obj/Cybernetics/Sensor/A in src) if(A.suffix)
				statpanel("Scanner")
				if(statpanel("Scanner"))
					stat("Location","([E.x],[E.y],[E.z])")
					var/mob/Center
					if(usr.S) Center=S
					else Center=src
					for(var/mob/B in Mob_Range_Scanner(Center,round(A.Level*10))) if(B.client)
						var/Scan=B.BP
						if(Scan>(A.Level**3)*1000) Scan="!?"
						else Scan=Commas(Scan)
						//if(B.client.holder && B.invisibility)
						stat("[Scan], [dir2text(get_dir(Center.loc,B.loc))]",B)
			var/Cyborg
			for(var/obj/Cybernetics/Sensor/A in src) if(A.suffix) Cyborg=1
			//Integrated Scanner
			if(Scanner) if(!afk)
				var/mob/Center=src
				if(S) Center=S
				statpanel("Scan")
				if(statpanel("Scan"))
					stat("Location","([E.x],[E.y],[E.z])")
					for(var/mob/B in Mob_Range_Scanner(Center,round(1000)))
						var/Scan=Commas(B.BP)
						//if(B.client.holder && B.invisibility)
						stat("[Scan], [dir2text(get_dir(Center.loc,B.loc))]",B)
*/
			//Scouter
			var/Scouter
			if(!Toggled_Sense)
				for(var/obj/items/Scanner/A in src) if(A.suffix)
					Scouter=1
					var/mob/Center
					if(usr.S) Center=S
					else Center=src
					if(!afk)
						statpanel("Scan")
						if(statpanel("Scan"))
							stat("Location","([E.x],[E.y],[E.z])")
							for(var/mob/player/B in Mob_Range_Scanner(Center,round(A.Range)))
								if(!B.Vampire)
									var/Scan=B.BP
									if(Scan>(A.Scan**3)*20) Scan="!?"
									else Scan=Commas(Scan)
									if(isnull(B)||isnull(B.client)) continue
									//if(B.client.holder&&B.invisibility)
									stat("[Scan], [dir2text(get_dir(Center.loc,B.loc))]",B)
					if(A&&A.Detects) if(!afk)
						statpanel("Radar")
						if(statpanel("Radar"))
							stat("Location","([E.x],[E.y],[E.z])")
							for(var/obj/B) if(B.z==Center.z&&B.type==A.Detects) if(B.invisibility<=see_invisible)
								if(B.x>Center.x-A.Range&&B.x<Center.x+A.Range&&B.y>Center.y-A.Range&&B.y<Center.y+A.Range)
									if(!(B.type==/obj/items/Magic_Ball&&!B.icon_state))
										stat("[dir2text(get_dir(Center.loc,B.loc))]",B)
							for(var/mob/B in Mob_Range_Scanner(Center,round(A.Range))) for(var/obj/C in B) if(C.type==A.Detects)
								if(!(C.type==/obj/items/Magic_Ball&&!C.icon_state)) if(C.invisibility<=see_invisible)
									stat("[dir2text(get_dir(Center.loc,B.loc))]",C)
					if(sec_toggle) if(!afk)
						statpanel("Security")
						if(statpanel("Security"))
							for(var/obj/items/Security_Camera/C in A.detections)
								if(C.z == 0)
									del(C)
								else
									stat(C)
									stat("[C]'s Location - [C.x],[C.y],[C.z]")
									if(C.display)
										stat("Known detections")
										stat("---------------------------------------------------------------------------------------")
										for(var/obj/Contact/X in C.detections)
											stat(X)
											stat("---------------------------------------------------------------------------------------")
					break
				//Sense
				if(!Scouter && (MaxKi>=1000/Sense_Mod/KiMod||src.client.holder))
					if(!Scanner) if(!afk)
						statpanel("Sense")
						if(statpanel("Sense"))
							var/mob/Center
							if(usr.S) Center=S
							else Center=src
							for(var/mob/A in Mob_Range(Center,round(0.1*(MaxKi/KiMod)*Sense_Mod))) if(A.client&&A.Race!="Android") if(!A.Vampire)
								var/Power=round((A.BP/BP)*100)
								if(Power>100000) Power=100000
								//if(A.client.holder && A.invisibility)
								var/Alignment = ""
								if(usr.Sense_Alignment)
									Alignment = "([A.AlignmentTxt])"
								stat("[Power]%, [dir2text(get_dir(Center.loc,A.loc))][Alignment]",A)

			if(Target && ismob(Target))

				if(src&&src.client.holder)

					statpanel("[Target]")
					if(statpanel("[Target]"))
						var/mob/Center
						if(usr.S) Center=S
						else Center=src
						stat("Direction","[dir2text(get_dir(Center.loc,Target.loc))]")

						if(ismob(Target))
							if(Target.BPpcnt < 25 && get_dist(src,Target) > 35 )
								if(src.client.holder) stat("NOTICE!","This player is ICly within range. Target not removed due to admin status.")
							if(Target.Race=="Android")
								if(src.client.holder) stat("NOTICE!","This player is an android and cannot ICly be sensed. Target not removed due to admin status.")
							if(MaxKi>500/Sense_Mod/KiMod&&Target.icon_state!="KO") stat("Power","[round((Target.BP/BP)*100)]% your power")
							else stat("Life","[round(Target.Life)]%")
							if(MaxKi>1500/Sense_Mod/KiMod&&Target.icon_state!="KO")
								stat("Health","[round(Target.Health)]%")
								stat("Energy","[round(Target.Ki/Target.MaxKi*100)]%")
								stat("Energy Signature","[Target.Signature]")
							/*if(MaxKi>2000/Sense_Mod/KiMod)
								stat("Strength","[round((Target.Str/Str)*100)]% yours")
								stat("Endurance","[round((Target.End/End)*100)]% yours")
								stat("Force","[round((Target.Pow/Pow)*100)]% yours")
								stat("Resistance","[round((Target.Res/Res)*100)]% yours")
								stat("Speed","[round((Target.Spd/Spd)*100)]% yours")
								stat("Offense","[round((Target.Off/Off)*100)]% yours")
								stat("Defense","[round((Target.Def/Def)*100)]% yours")
		*/
							for(var/obj/A in Target.contents)
								if(istype(A, /obj/Technology)) continue
								stat(A)
/*
							stat("*Assess*")
							stat("Race","[Target.Race] [Target.Class]")
							stat("Age","[Target.Age] ([Target.Real_Age] Real)")
							stat("Body","[Target.Body*100]%")
							stat("Anger","[Target.Anger]%")
							stat("Base BP","[Commas(Target.Base)]")
							stat("Current BP","[Commas(Target.BP)]")
							stat("Energy","[round(Target.MaxKi)]")
							stat("Strength","[round(Target.Str)]")
							stat("Endurance","[round(Target.End)]")
							stat("Speed","[round(Target.Spd)]")
							stat("Force","[round(Target.Pow)]")
							stat("Resistance","[round(Target.Res)]")
							stat("Offense","[round(Target.Off)]")
							stat("Defense","[round(Target.Def)]")
							stat("Regeneration","[round(Target.Regeneration,0.01)]")
							stat("Recovery","[round(Target.Recovery,0.01)]")
							stat("Zenkai","[Target.Zenkai]")
							stat("Gravity","[round(Target.GravMastered)] ([Target.GravMod])")
							stat("Meditation","[Target.MedMod]")
							stat("Flying","[round(Target.FlySkill)] ([Target.FlyMod])")
							stat("Zanzoken","[round(Target.Zanzoken)] ([Target.ZanzoMod])")
							stat("Potential","[Target.Potential]")
							stat("Energy Signature","[Target.Signature]")
							stat("Experience","[Commas(round(Target.Gain_Multiplier))]x")
							stat("Technology","[round(Target.Add*Target.Tech,0.01)] ([round(Target.Add,0.01)]x[Target.Tech])")
*/
				else
					if(istype(Target, /mob/player) && Target.client)
						if(istype(Target, /obj/Build)) // WTF?
							debuglog << "[__FILE__]:[__LINE__] || src: [src ? src : "null"] usr: [usr ? usr : "null"] type: [Target.type ? Target.type : "null"] client: [Target.client ? Target.client : "null"]"
							return //Remove this if it causes issues with the stat process.
						if(Target.Race==null)
							//world<<"Null.Var scanning race based scanning error detected."
							return
						var/ScannerRace=Target.Race
						if(Target==null)  // 3-30-2013 added to try and prevent artificial power and target.z null bugs.
							return
						if((ScannerRace!="Android" || Target!=null || src.client.holder) && Target in Mob_Range(src,round(0.1*(MaxKi/KiMod)*Sense_Mod)) )  // 	if((Target.Race!="Android" || src.client.holder) &&Target.Artificial_Power<1000000&&Target.z==z && Target in Mob_Range(src,round(0.1*(MaxKi/KiMod)*Sense_Mod)) )   Null var bug edit  (src.client.holder) and Target.Artificial_Power edited     Reference for removed code for art power  -  cannerRace!="Android" || Target!=null || src.client.holder) &&Target.Artificial_Power<1000000   &&Target.z==z  readd this if it breaks scanning
							statpanel("[Target]")
							if(statpanel("[Target]"))
								var/mob/Center
								if(usr.S) Center=S
								else Center=src
								stat("Direction","[dir2text(get_dir(Center.loc,Target.loc))]")

								if(ismob(Target))
									if(MaxKi>500/Sense_Mod/KiMod&&Target.icon_state!="KO") stat("Power","[round((Target.BP/BP)*100)]% your power")
									else stat("Life","[round(Target.Life)]%")
									if(MaxKi>1500/Sense_Mod/KiMod&&Target.icon_state!="KO")
										stat("Health","[round(Target.Health)]%")
										stat("Energy","[round(Target.Ki/Target.MaxKi*100)]%")


/*
	else if(Tabs==2)
		statpanel("Customization")
		stat("Energy","[KiMod]")
		stat("Strength","[StrMod]")
		stat("Endurance","[EndMod]")
		stat("Speed","[SpdMod]")
		stat("Force","[PowMod]")
		stat("Resistance","[ResMod]")
		stat("Offense","[OffMod]")
		stat("Defense","[DefMod]")
		stat("Regeneration","[Regeneration]")
		stat("Recovery","[Recovery]")
*/


	sleep(Stat_Lag)

var/gainget=0.00000001
var/GG=0.000000100
proc/Save_Gain()
	var/savefile/S=new("Data/GAIN.bdb")
	S["GAIN"]<<GG
	S["PORTALS"]<<Portals
	//if(global.startRuin) S["success"] << global.startRuin
proc/Load_Gain() if(fexists("Data/GAIN.bdb"))
	var/savefile/S=new("Data/GAIN.bdb")
	S["GAIN"]>>GG
	S["PORTALS"]>>Portals
	//if(length(S["success"])) global.startRuin = 1

proc/sanityStats(mob/player/_player)

	if(!ismob(_player)) return FALSE // If the mob isn't a player mob. Then we're not checking stats.
	var/list/statlist = list(_player.Str, _player.StrMod, _player.End, _player.EndMod,
							  _player.Spd, _player.SpdMod, _player.Res, _player.ResMod,
							  _player.Pow, _player.PowMod, _player.Off, _player.OffMod,
							  _player.Def, _player.DefMod) // All of their stats in a list.
	var/statcount = 0

	for(var/stat in statlist) // Loop through the list
		if(isnum(stat)) // Check if each entry is an actual number
			sleep (1)
			statcount++ // Add one to the count
		else continue

	if(statcount == statlist.len) // If the count is as long as the list, then every stat was a number
		return TRUE // And we can continue the statrank proc.
	else
		return FALSE // If not, then something was wrong and we kill the statrank proc.


mob/proc/StatRank()
	ASSERT(src)
	ASSERT(src.Str||src.End||src.Spd||src.Spd||src.Res||src.Pow||src.Off||src.Def)
	var/StrongerStats=1
	var/StrongerBPs=1
	var/People=0.1 // Was 0.  Creates a potential divide by zero runtime error when attempting to assess the number of people present. -Arch
	for(var/mob/player/A in Players)
		People++
	//	if(!sanityStats(A)) return   The way this is set up is very bad.  Using src, or any sort of .reference (IE:  A.STR) in the same context as a proc can do bad things for all procs in it and associated with it.  It was one of the three causes for null.var errors.  - Arch
	//	ASSERT(A)
	//	ASSERT(A.Str)  // Null bug runtime error fix
	//	ASSERT(A.StrMod)
	//	ASSERT(A.End)
	//	ASSERT(src.Str)
		ASSERT(src)  //world<<"Debug:  Assertion passed"
		if(!src)
			world <<  "Null.Var runtime error detected."
			return
		if(!src.Str||!src.End||!src.Spd||!src.Spd||!src.Res||!src.Pow||!src.Off||!src.Def)
			world<< "Null.Var runtime Error detected.  Stat reroute."
			return
/*		if(!A.Str||!A.End||!A.Spd||!A.Spd||!A.Res||!A.Pow||!A.Off||!A.Def)
			world<<"Null.Var runtime error detected.  Assignment reroute."
			return*/
		var/TheirStats=(A.Str/A.StrMod)+(A.End/A.EndMod)+(A.Spd/A.SpdMod)+(A.Res/A.ResMod)+(A.Pow/A.PowMod)+(A.Off/A.OffMod)+(A.Def/A.DefMod)
		var/YourStats=(Str/StrMod)+(End/EndMod)+(Spd/SpdMod)+(Res/ResMod)+(Pow/PowMod)+(Off/OffMod)+(Def/DefMod)
		if(TheirStats>YourStats) StrongerStats++
		if(A.Base/A.BPMod>Base/BPMod) StrongerBPs++
		//else if(!A.FinalMod&&FinalMod) if(10*A.Base/A.BPMod>Base/BPMod) StrongerBPs++
		//else if(A.FinalMod&&!FinalMod) if(A.Base/A.BPMod>10*Base/BPMod) StrongerBPs++
//	if(People<=1)	// <= 1This case occurs when the last person logs out  Added a !length too
//		return
	var/Modifier=100/People
	StatRank=StrongerStats*Modifier
	BPRank=StrongerBPs*Modifier

	if(world.maxz==100)
		StatRank=0
		BPRank=0
	//Sanity check
	if(!isnum(StatRank)||!isnum(BPRank)){log_errors("StatRank for [src] is not a number!");return}
	if(StatRank > 100) StatRank=100
	if(StatRank < 1) StatRank=1
	if(BPRank > 100) BPRank=100
	if(BPRank < 1) BPRank=1

/var/ScalingPower=1
/var/ScalingStats=1
var/ScalingStr=1
var/ScalingEnd=1
var/ScalingRes=1
var/ScalingOff=1
var/ScalingDef=1
/
//mob/proc/ScalingMobBP()   //You can use this proc to create scaling BP and power for NPC's.  To set the position of a mob in terms of relative power to them, when calculating their personal power
						  //simply divide by where you want them to go on the "ranks".  IE:  50 would be *(1/2). -  Arch
	/*for(var/mob/player/A in Players)
		ScalingPower=A.Base/A.BPMod
		ScalingStr=A.Str/A.StrMod
		ScalingRes=A.Res/A.ResMod
		ScalingEnd=A.End/A.EndMod
		ScalingOff=A.Off/A.OffMod
		ScalingDef=A.Def/A.DefMod*/

		//Note -  As a variant, you can also take the players in an area and apply the same formula for their stats.  This would allow for more focused power and NPC content.

mob/proc/XPRank()
	XPRank=0
//	var/HigherXP=1
//	var/LowerXP=1
	var/People=0
	for(var/mob/player/A in Players)
		if(A.Age>=20) //XPGained>=(Year*50)
			People++
			var/TheirXP=A.Gain_Multiplier*(1/2)
			if(People==1)
				XPRank+=TheirXP*(1/2)
			else
				XPRank+=TheirXP/People

mob/proc/resetTarget()
	Target=null

mob/proc/XPGrant()
//	for(var/mob/player/A in Players)
	Gain_Multiplier=XPRank
	switch(Year)
		if(1 to 5)
			if(Gain_Multiplier>100) Gain_Multiplier=100
		if(6 to 10)
			if(Gain_Multiplier>500) Gain_Multiplier=500
		if(11 to 40)
			Gain_Multiplier=(Year*100)
		if(50 to 70)
			Gain_Multiplier=(Year*300)

mob/proc/Learn() if(world.maxz!=1) while(src)
	sleep(200)
	if(Race=="Kaio"&&MaxKi>=1000&&!(locate(/obj/Materialization) in src))
		contents+=new/obj/Materialization
		src<<"Your mastery over your inherent energies has progressed to the point where you can use it to forge training items for yourself and others.  These items can be given variable levels of strength, and their maximum potential is always equivalent to your maximum energy."
	if(Race=="Kaio"&&MaxKi>=6000&&!(locate(/obj/Fusion) in src))
		contents+=new/obj/Fusion
		src<<"Your mastery over your own inherent energies has progressed to the point where you may now give them to another individual.  Unfortunately, this process is rather final, as it gives -all- of your energies to someone else.  This has the regrettable result of killing you.  However, the power boost the recipient receives is quite substantial."
	if(Race=="Kaio"&&MaxKi>=500&&!(locate(/obj/Heal) in src))
		contents+=new/obj/Heal
		src<<"Your control over the supernatural energies that make up your body has progressed to the point where you can expend them to mend the wounds of others.  This effect only works on individuals in melee range however, as you must be able to touch the injuries to heal them."
	if(MaxKi>=1500&&!(locate(/obj/Attacks/Blast) in src))
		contents+=new/obj/Attacks/Blast
		src<<"You automatically learned Blast on your own because of your immense energy"
//		usr.hasblast1=1
	if(MaxKi>=2000&&!(locate(/obj/Attacks/Charge) in src))
		contents+=new/obj/Attacks/Charge
		src<<"You automatically learned Charge on your own because of your immense energy"
	if(MaxKi>=2500&&!(locate(/obj/Attacks/Beam) in src))
		contents+=new/obj/Attacks/Beam
		src<<"You automatically learned Beam on your own because of your immense energy"
	if(MaxKi>=3000&&!(locate(/obj/Fly) in src))
		contents+=new/obj/Fly
		src<<"You automatically learned Fly on your own because of your immense energy"
	//if(Race=="Taranian"&&Int_Level>=200&&!(locate(/obj/Bebi) in src))
		//contents+=new/obj/Bebi
	if(Race=="Kaio"&&MaxKi>=10000&&Age>=50&&!(locate(/obj/Kaio_Revive) in src))
		contents+=new/obj/Kaio_Revive
		src<<"Through age, wisdom, and a truly immense amount of energy, you have learned how to turn back the clock and revive other players!"
	if(Race=="Kaio"&&MaxKi>=1000&&!(locate(/obj/Observe) in src))
		contents+=new/obj/Observe
		src<<"You have automatically learned to observe thanks to your race and immense energy."
	if(Race=="Kaio"&&MaxKi>=3000&&!(locate(/obj/Teleport) in src))  //stat revamp 7000
		contents+=new/obj/Teleport
		src<<"You have automatically learned to teleport thanks to your race and immense energy."
	if(Race=="Oni"&&MaxKi>=1000&&!(locate(/obj/Teleport)in src))
		contents+=new/obj/Teleport
		src<<"You have automatically learned to teleport thanks to your race and immense energy."
	if(Race=="Oni"&&MaxKi>=4000&&!(locate(/obj/Oni_Revive)in src))
		contents+=new/obj/Oni_Revive
		src<<"You have now learned how to revive people, though the process does at some risk to your own health."
	if(Race=="Makyojin"&&MaxKi>=2500&&!(locate(/obj/Conjure)in src))
		contents+=new/obj/Conjure
		src<<"Your ki has grown so great that you may now pierce the veil between realities and summon minions from Hell!"
	if(Race=="Makyojin"&&Str>=1000&&MaxKi>=5000&&!(locate(/obj/Expand)in src))
		contents+=new/obj/Expand
		src<<"Through strength and ki training, you have learned how to expand your body to a gargantuan size!  By doing so as a Makyojin you gain huge amounts of battle power, along with a massive increase in strength!"
	if(Race=="Namekian"&&MaxKi>=2000&&Base>=1000&&FusionLearnable==1&&!(locate(/obj/Fusion)in src))
		contents+=new/obj/Fusion
		src<<"Through luck, skill, or intense training, you have discovered that you can fuse!  Congratulations!"
	if(Race=="Namekian"&&MaxKi>=2000&&PiercerLearnable==1&&!(locate(/obj/Attacks/Piercer)in src))
		contents+=new/obj/Attacks/Piercer
		src<<"Through luck and a fairly large amount of energy training, you have learned how to use Piercer!"
	if(Race=="Human"&&MaxKi>=1000&&Str>=2000&&ExpandLearnable==1&&!(locate(/obj/Expand)in src))
		contents+=new/obj/Expand
		src<<"Through extensive strength training, ki training, and luck, you have learned how to expand your muscles to increase your strength and resilience!"
	if(Race=="Human"&&MaxKi>=1000&&Pow>=2000&&FocusLearnable==1&&!(locate(/obj/Focus)in src))
		contents+=new/obj/Focus
		src<<"Through intensive ki training, force training, and luck, you have learned to use Focus.  By doing so, you take your senses to a super-human level!"
	if(Race=="Tsufurujin"&&MaxKi>=1000&&Int_Level>=50&&!(locate(/obj/Focus)in src))
		contents+=new/obj/Focus
		src<<"Through applying your race's heightened intelligence and awareness, you have learned to focus your attention on an enemy for a limited amount of time!"
	if(Race=="Demon"&&MaxKi>=500&&!(locate(/obj/Imitation)in src))
		contents+=new/obj/Imitation
		src<<"You have learned how to imitate another person's physical featuers through the usage of your ki and dark magic!"
	if(Race=="Kyonshi"&&MaxKi>=5000&&SDLearnable==1&&!(locate(/obj/Self_Destruct)in src))
		contents+=new/obj/Self_Destruct
		src<<"You've learned how to focus your life energies outwards into a catastrophic explosive wave!  While destructive, this attack will also tear your body apart after using it.  Lucky you!"
	if(Race=="Kyonshi"&&MaxKi>=3000&&!(locate(/obj/Attacks/Homing_Finisher)in src))
		contents+=new/obj/Attacks/Homing_Finisher
		src<<"You have learned Homing Finisher!  This attack lets you convert some of your own life-force into destructive balls of energy that will home in on your enemies.  Watch for friendly fire!"
	if(Race=="Saiyan"&&Str>=2000&&ExpandLearnable==1&&!(locate(/obj/Expand)in src))
		contents+=new/obj/Expand
		src<<"Through extensive strength training and luck, you have learned how to expand your muscles to increase your strength and resilience!"
	if(Race=="Tsufurujin"&&Int_Level>=50&&Base>=300&&Super_Tsufu_Learnable==1&&Super_Tsufu_Learned==0)
		src.Add=5.5
		src.KiMod*=2
		src.PowMod*=2
		src.OffMod*=2
		src.DefMod*=2
		src.BPMod=2.2
		Super_Tsufu_Learned=1
		src<<"You are one of the few Tsufurujins who was born with a special mental mutation.  Through much meditation you have learned how to exploit this mutation to your own benefit, increasing your mental capabilities!"
		src<<"Your intelligence, offense, defense, BP mod, and control over Ki soars to super-human heights!"
//	if(Race=="Tsufurujin"&&Int_Level>=40&&!(locate(/obj/Construct_Robot)in src)||Race=="Alien"&&Int_Level==40&&Potential>=4&&!(locate(/obj/Construct_Robot)in src)||Race=="Human"&&Int_Level>=40&&!(locate(/obj/Construct_Robot)in src))
//		contents+=new/obj/Construct_Robot

	if(src)
		if(ismob(SkillsOpp)) // If they are already have somebody they're leeching from
			if(get_dist(src,SkillsOpp)>5) // And the distance between them and their opponent is above 5
				SkillsOpp=null // Then they're no longer allowed to leech form that guy.

		for(var/mob/player/P in oview(src,5))
			SkillsOpp=P
			break
		Learnify()

mob/proc/Learnify()

	if(!ismob(SkillsOpp)||isnull(SkillsOpp)) return // sanity check
	else if(!isnull(SkillsOpp)&&ismob(SkillsOpp)) //if(SkillsOpp.client.address!=src.client.address)
		spawn(rand(120,300)) SkillsOpp = null // Makes sure that after a second, the person they're leeching from gets reset
									// Consider this a way to make sure that if they suddenly change locations, things dont screw up.

		if(SkillsOpp.Skill_Leech_On==1)
			for(var/obj/B in SkillsOpp)
				if(B.Teach >= 5)
					var/Chance = 0.02
					for(var/obj/Contact/A in src.Contacts) if(A.Signature == SkillsOpp.Signature)
						if(A.relation in list("Rival/Bad","Rival/Good")) Chance = 0.03
						if(A.relation in list("Good","Very Good")) Chance = 0.04
					if(prob((MaxKi*Chance)/B.Difficulty)&&!locate(B) in src)
						if(B.Learnable)
							view(src)<<"[src] learned [B] from [SkillsOpp]"
							src.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(src)] leeched [B] from [key_name(SkillsOpp)]")
							log_ability("[key_name(src)] learned [B] from [key_name(SkillsOpp)]")
							var/obj/Skill = new B.type(src)
							Skill.Teach = 0
							Skill.desc += "You learned this at year [Year] from [SkillsOpp]."
							//contents+=new B.type
							return
						if(istype(B,/obj/Shield)|istype(B,/obj/Focus)|istype(B,/obj/Expand)|istype(B,/obj/Self_Destruct)|istype(B,/obj/Shunkan_Ido)|istype(B,/obj/Attacks/Sokidan))
							if(B.Using)
								view(src)<<"[src] learned [B] from [SkillsOpp]"
								src.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(src)] leeched [B] from [key_name(SkillsOpp)]")
								log_ability("[key_name(src)] leeched [B] from [key_name(SkillsOpp)]")
								var/obj/Skill = new B.type(src)
								Skill.Teach = 0
								Skill.desc += "You learned this at year [Year] from [SkillsOpp]."
								//contents+=new B.type
								return
						if(SkillsOpp.icon_state=="Flight"&&istype(B,/obj/Fly))
							view(src)<<"[src] learned [B] from [SkillsOpp]"
							src.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(src)] leeched [B] from [key_name(SkillsOpp)]")
							log_ability("[key_name(src)] leeched [B] from [key_name(SkillsOpp)]")
							var/obj/Skill = new B.type(src)
							Skill.Teach = 0
							Skill.desc += "You learned this at year [Year] from [SkillsOpp]."
							//contents+=new B.type
							return

						if(istype(B,/obj/Power_Control))
							var/obj/Power_Control/P=B
							if(P.Powerup)
								view(src)<<"[src] learned [B] from [SkillsOpp]"
								src.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(src)] leeched [B] from [key_name(SkillsOpp)]")
								log_ability("[key_name(src)] leeched [B] from [key_name(SkillsOpp)]")
								var/obj/Skill = new B.type(src)
								Skill.Teach = 0
								Skill.desc += "You learned this at year [Year] from [SkillsOpp]."
								//contents+=new B.type
								return

		if(SkillsOpp.Skill_Leech_On==0)
			for(var/obj/B in SkillsOpp)
				if(B.Teach >= 5)
					if(locate(B) in src)  return // If they already HAVE the skill then there's no need to leech it'
					var/Chance = 0.0001
					for(var/obj/Contact/A in src.Contacts) if(A.Signature == SkillsOpp.Signature)
						if(A.relation in list("Rival/Bad","Rival/Good")) Chance = 0.0002
						if(A.relation in list("Good","Very Good")) Chance = 0.0004
					if(prob((MaxKi*Chance)/B.Difficulty)&&!locate(B) in src)
						if(B.Learnable)
							view(src)<<"[src] learned [B] from [SkillsOpp]"
							src.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(src)] leeched [B] from [key_name(SkillsOpp)]")
							log_ability("[key_name(src)] learned [B] from [key_name(SkillsOpp)]")
							var/obj/Skill = new B.type(src)
							Skill.Teach = 0
							Skill.desc += "You learned this at year [Year] from [SkillsOpp]."
							//contents+=new B.type
							return
						if(istype(B,/obj/Limit_Breaker)|istype(B,/obj/Shield)|istype(B,/obj/Focus)|istype(B,/obj/Expand)|istype(B,/obj/Self_Destruct)|istype(B,/obj/Shunkan_Ido)|istype(B,/obj/Attacks/Sokidan))
							if(B.Using)
								view(src)<<"[src] learned [B] from [SkillsOpp]"
								src.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(src)] leeched [B] from [key_name(SkillsOpp)]")
								log_ability("[key_name(src)] leeched [B] from [key_name(SkillsOpp)]")
								var/obj/Skill = new B.type(src)
								Skill.Teach = 0
								Skill.desc += "You learned this at year [Year] from [SkillsOpp]."
								//contents+=new B.type
								return
						if(SkillsOpp.icon_state=="Flight"&&istype(B,/obj/Fly))
							view(src)<<"[src] learned [B] from [SkillsOpp]"
							src.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(src)] leeched [B] from [key_name(SkillsOpp)]")
							log_ability("[key_name(src)] leeched [B] from [key_name(SkillsOpp)]")
							var/obj/Skill = new B.type(src)
							Skill.Teach = 0
							Skill.desc += "You learned this at year [Year] from [SkillsOpp]."
							//contents+=new B.type
							return
						if(istype(B,/obj/Power_Control))
							var/obj/Power_Control/P=B
							if(P.Powerup)
								view(src)<<"[src] learned [B] from [SkillsOpp]"
								src.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(src)] leeched [B] from [key_name(SkillsOpp)]")
								log_ability("[key_name(src)] leeched [B] from [key_name(SkillsOpp)]")
								var/obj/Skill = new B.type(src)
								Skill.Teach = 0
								Skill.desc += "You learned this at year [Year] from [SkillsOpp]."
								//contents+=new B.type
								return
			/*if(istype(B,/obj/Kaioken)&&A.KaiokenBP)
					view(src)<<"[src] learned [B] from [A]"
					contents+=new B.type
					return*/
obj/proc/Teachify(mob/A,var/B,var/Y)
	if(locate(type) in A)
		usr<<"They already have this ability."
		return
	if(usr.MaxKi<B)
		view(usr)<<"[usr] tried to teach [A] the [src] ability, but [usr] did not have enough energy."
		return
	if(A.MaxKi<B*0.5)
		view(usr)<<"[usr] tried to teach [A] the [src] ability, but [A] does not have enough energy."
		return
	if(src.Teach < 5)
		view(usr)<<"[usr] tried to teach [A] the [src] ability, but [usr] is not the rank holder linked to this skill."
		return
	src.Teach = 0
	if(Y)
		src.Teach = Y
	src.desc += "You were taught this at year [Year] from [usr]."
	view(usr)<<"[usr] taught [A] the [src] ability."
	log_ability("[key_name(usr)] taught [key_name(A)] [src]")
	A.saveToLog("| [A.client.address ? (A.client.address) : "IP not found"] | ([A.x], [A.y], [A.z]) | [key_name(A)] was taught [src] by [key_name(usr)]")
	usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] taught [key_name(A)] [src]")
	A.contents+=new type
mob/proc/Stat_Labels()
	src<<output("Health: [round(Health)]%","Health")
	if(MaxKi&&isnum(MaxKi)) src<<output("Energy: [round((Ki/MaxKi)*100)]%","Energy")
	if(BPpcnt>100) src<<output("Power: [round((Health*0.01)*(Ki/MaxKi)*(BPpcnt)*(Body)*(Anger/100))]% (+[round(BPpcnt-100,0.1)]%)","Power")
	else if(BPpcnt<100) src<<output("Power: [round((Health*0.01)*(Ki/MaxKi)*(BPpcnt)*(Body)*(Anger/100))]% (-[round(BPpcnt-100,0.1)]%)","Power")
	else src<<output("Power: [round((Health*0.01)*(Ki/MaxKi)*(BPpcnt)*(Body)*(Anger/100))]%","Power")
	src<<output("Gravity: [Gravity]x","Gravity")
mob/proc/Stat_Labels_Visible()
	if(client) if(src)
		winset(src,"Health","is-visible=true")
		winset(src,"Energy","is-visible=true")
		winset(src,"Power","is-visible=true")
		winset(src,"Gravity","is-visible=true")