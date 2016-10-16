#ifndef DRILLS
#warn The drills.dm file is NOT included. This update will BREAK a running server!
#endif


mob/verb/Create()
	set category="Other"
	if(!TechTab)
		TechTab=1
		src<<"Technology tab activated"
	else
		TechTab=0
		src<<"Technology tab deactivated"


/*proc/Resources()
	var/Extra = 10000000
	var/Double = 1000000
	var/Normal = 500000
	for(var/area/A in world)
		if(A.type!=/area&&A.type!=/area/Inside)
			if(A.type==/area/Changeling) A.Value+=Extra
			if(A.type==/area/Namek_Underground) A.Value+=Extra
			else if(A.type==/area/Sonku) A.Value+=Double
			else A.Value+=Normal
*/
obj/Resources
	icon='Misc.dmi'
	icon_state="ZenniBag"
	Savable=1
	var/Value=0
	verb/Drop()
		var/Money=input("Drop how much Resources? ([Commas(Value)])") as num
		if(Money>Value) Money=Value
		if(Money<=0) usr<<"You must atleast drop 1"
		if(Money>=1)
			Money=round(Money)
			Value-=Money
			var/obj/Resources/A=new
			A.loc=usr.loc
			A.Value=Money
			A.name="[Commas(A.Value)] Resources"
			view(usr)<<"<font size=1><font color=teal>[usr] drops [A]."
			step(A,usr.dir)
			for(var/mob/player/M in view(usr)) if(M.client)
				M.saveToLog("<font color=red>| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] drops [Commas(Money)] Resources</font><br>")


mob/proc/AddTech() //spawn if(src)
//	if(!Technology||!Technology.len)
//		Technology=new
//		world << "Tech list created, generating items."
	//for(var/obj/Technology/B in Technology) { del (B) }
	techlist=new
	for(var/A in typesof(/obj/Technology)) if(A!=/obj/Technology)
		var/obj/Technology/B=new A
		if(B.name in techlist)
			continue
		else
			if(isnum(B.Level)) if(B.Level<=Int_Level)
				//B.loc=src
				B.Cost=round(initial(B.Cost)/Add)
				B.suffix="[Commas(B.Cost)]"
				techlist+=B
				techlist+=B.name
		sleep(2)

/*
obj/Make_Logs
	verb/Create_Log()
		set category="Other"
		var/obj/TrainingEq/Dummy/A=new(locate(usr.x,usr.y,usr.z))
obj/Make_Punching_Bag
	verb/Create_Bag()
		set category="Other"
		var/obj/TrainingEq/Punching_Bag/A=new(locate(usr.x,usr.y,usr.z))

		//Comment this code out.  Reset price for sims to normal amount.  Reset price for sim upgrades for normal amount.  Re-activate crafting logs and bags.
*/

obj/Technology
	var/displaykey
	var/Creates
	var/Cost=0
	Level=1

	Click()
		for(var/obj/Resources/B in usr)
			var/Amount=0
			for(var/obj/O in range(0,usr)) if(!(locate(O) in usr)) Amount++
			if(Amount>=20)
				usr<<"Nothing more can be placed on this spot."
				return
			if(B.Value<Cost)
				usr<<"You do not have the resources to create this."
				return
			B.Value-=Cost
			var/obj/A=new Creates
			if(A)
				A.loc=usr.loc
			//	for(var/obj/A=new Creates)

				A.Builder="[key_name(usr)], [usr.client.address]"
				usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] creates [A.name] ([A])")
				if(istype(A,/obj/items/Scanner)) if((A.z in list(1,5,7,10,13))||(usr.Race in list("Human","Spirit Doll","Celestial","Demigod")))
					A.name="Scanner"
					A.icon='Item - Sun Glassess.dmi'
			/*if(istype(A,/obj/items/Drone)) for(var/mob/Drone in range(0,usr))
				del(A)
				A= new /mob/Drone		//Creates= new /mob/Drone/
				A.loc=usr.loc
				A.Builder="[key_name(usr)], [usr.client.address]"*/
				//	Creates=new /mob/Drone/         //var/obj/A=/mob/Drone   Creates=new /mob/Drone
				global.worldObjectList+=A


			else
				B.Value+=Cost
				usr<<"There are no more available ship interiors, you cannot create this."
				del(A)
			if(istype(A,/obj/items/Drone)) for(var/mob/Drone in range(0,usr))
				del(A)
				A= new /mob/Drone		//Creates= new /mob/Drone/
				A.loc=usr.loc
				A.Builder="[key_name(usr)], [usr.client.address]"
				global.worldObjectList+=A


		/*	if(A)
			//	for(var/obj/A=new Creates)
				if(A==/obj/items/Drone)
					Creates=/mob/Drone         This code isn't nearly done yet.  I'm going to come back to it later.  In order for Drones to be placed in-game,
					either the tech system needs to be completely redesigned, or I have to jury-rig a fix in the mean-time.	*/
	New()
		if(Creates)
			var/obj/A=new Creates
		//	if(A.name)
			//	Creates=A.name
			if(A)
				icon=A.icon
				icon_state=A.icon_state
				del(A)
		else del(src)
		//..()

	Armor1
		Level=2
		Creates=/obj/items/Armor/Armor1
		Cost=1000
	Heroic_Armor
		Level=2
		Creates=/obj/items/Armor/Green_Armor
		Cost=1000
	Green_Armor
		Level=2
		Creates=/obj/items/Armor/Heroic_Armor
		Cost=1000
	Black_Armor
		Level=2
		Creates=/obj/items/Armor/Armor_Black
		Cost=1000
	Armor2
		Level=2
		Creates=/obj/items/Armor/Armor2
		Cost=1000
	Armor3
		Level=2
		Creates=/obj/items/Armor/Armor3
		Cost=1000
	Armor4
		Level=2
		Creates=/obj/items/Armor/Armor4
		Cost=1000
	Armor5
		Level=2
		Creates=/obj/items/Armor/Armor5
		Cost=1000
	Armor6
		Level=2
		Creates=/obj/items/Armor/Armor6
		Cost=1000
	Armor7
		Level=2
		Creates=/obj/items/Armor/Armor7
		Cost=1000
	Armor8
		Level=2
		Creates=/obj/items/Armor/Armor8
		Cost=1000
	Sword
		Level=3
		Creates=/obj/items/Sword
		Cost=1000
	Knight_Sword
		Level=3
		Creates=/obj/items/Sword/Knight_Sword
		Cost=1000
	Demon_Sword
		Level=3
		Creates=/obj/items/Sword/Demon_Sword
		Cost=1000
	Katana
		Level=3
		Creates=/obj/items/Sword/Katana
		Cost=1000
	Random_Sword
		Level=3
		Creates=/obj/items/Sword/Random_Sword
		Cost=1000
	Short_Sword
		Level=3
		Creates=/obj/items/Sword/Short_Sword
		Cost=1000
	Rebellion
		Level=3
		Creates=/obj/items/Sword/Rebellion
		Cost=1000
	Buster_Sword
		Level=3
		Creates=/obj/items/Sword/Buster_Sword
		Cost=1000
	Dual_Blaze
		Level=3
		Creates=/obj/items/Sword/Dual_Blaze
		Cost=1000
	Dual_Electric
		Level=3
		Creates=/obj/items/Sword/Dual_Electric
		Cost=1000
	Great_Sword
		Level=3
		Creates=/obj/items/Sword/Great_Sword
		Cost=1000
	Flame_Sword
		Level=3
		Creates=/obj/items/Sword/Flame_Sword
		Cost=1000
	Samurai
		Level=3
		Creates=/obj/items/Sword/Samurai
		Cost=1000
	Double_Katana
		Level=3
		Creates=/obj/items/Sword/Double_Katana
		Cost=1000
	Dummy
		Level=4
		Creates=/obj/TrainingEq/Dummy
		Cost=4000
	Punching_Bag
		Level=4
		Creates=/obj/TrainingEq/Punching_Bag
		Cost=4000

// You dont want this in, it crashes the fucking server.
// Dont ask me how, I can't be bothered finding out.

/*
	Resource_Vaccuum
		Level="INF"
		Creates=/obj/items/Sword/Double_Katana
		Cost="INF"
*/

	LSD
		Level=6
		Creates=/obj/items/LSD
		Cost=200
	Door_Pass
		Level=8
		Creates=/obj/items/Door_Pass
		Cost=400
	Communicator
		Level=7
		Creates=/obj/items/Communicator
		Cost=400
	Ammo
		Level=9
		Creates=/obj/items/Ammo
		Cost=8000
	Handgun
		Level=9
		Creates=/obj/items/Gun/Handgun
		Cost=4000
	Shotgun
		Level=9
		Creates=/obj/items/Gun/Shotgun
		Cost=4000
	Rifle
		Level=9
		Creates=/obj/items/Gun/Rifle
		Cost=4000
	Sub_Machine_Gun
		Level=9
		Creates=/obj/items/Gun/SMG
		Cost=4000
	Minigun
		Level=9
		Creates=/obj/items/Gun/Minigun
		Cost=4000
	Punisher
		Level=11
		Creates=/obj/items/Gun/Punisher
		Cost=4000
	Red9
		Level=11
		Creates=/obj/items/Gun/Red9
		Cost=4000
	RPG
		Level=10
		Creates=/obj/items/Gun/RPG
		Cost=4000
	Photon_Repeaters
		Level=15
		Creates=/obj/items/Gun/Photon_Repeaters
		Cost=4000
	Book_Case
		Level=20
		Creates=/obj/items/Bookcase
		Cost=10000
	Medicine_Cabinet
		Level=20
		Creates=/obj/items/Medicine_Cabinet
		Cost=10000
	Blaster
		Level=21
		Creates=/obj/items/Gun/Blaster
		Cost=4000
	// PDA temporarily disabled
        //PDA
	//	Level=12
	//	Creates=/obj/items/PDA
	//	Cost=1000
	Spacesuit
		Level=20
		Creates=/obj/items/Spacesuit
		Cost=4000
	Bomb
		Level=30
		Creates=/obj/items/Bomb
		Cost=100000
	Automated_Tournament_Registrar
		Level=30
		Creates=/obj/Tournament_Register
		Cost=700000
	Moon
		Level=21
		Creates=/obj/items/Moon
		Cost=8000
	Scanner
		Level=22
		Creates=/obj/items/Scanner
		Cost=200000
	Drone
		Level=40
		Creates=/obj/items/Drone  // /mob/drone
		Cost=1000000

	Hacking_Console
		Level=25
		Creates=/obj/items/Hacking_Console
		Cost=400000000
	Regenerator
		Level=24
		Creates=/obj/items/Regenerator
		Cost=80000
	Simulator
		Level=26
		Creates=/obj/items/Simulator
		Cost=80000000   //8000000   80000000
	Gravity
		Level=27
		Creates=/obj/items/Gravity
		Cost=50000000
	Force_Field
		Level=28
		Creates=/obj/items/Force_Field
		Cost=4000000
	Pod
		Level=40
		Creates=/obj/Ships/Spacepod
		Cost=10000000
	Ship
		Level=80
		Creates=/obj/Ships/Ship
		Cost=100000000
	Transporter_Watch
		Level=90
		Cost=100000000
		Creates=/obj/items/Teleportation_Watch
	Poison
		Level=6
		Creates=/obj/items/Poison_Injection
		Cost=500
	Steroids
		Level=7
		Creates=/obj/items/Steroid_Injection
		Cost=4000
	Antivirus
		Level=29
		Creates=/obj/items/Antivirus
		Cost=10000
	Modernized_Cloning_Tank
		Level=81
		Creates=/obj/items/Cloning_Tank/Modernized
		Cost=400000000
	Obsoleted_Cloning_Tank
		Level=65
		Creates=/obj/items/Cloning_Tank/Obsoleted
		Cost=300000000
	Primitive_Cloning_Tank
		Level=50
		Creates=/obj/items/Cloning_Tank/Primitive
		Cost=150000000
	Jury_Rigged_Cloning_Tank
		Level=35
		Creates=/obj/items/Cloning_Tank/Jury_Rigged
		Cost=10000000
	Stun_Controls
		Level=15
		Creates=/obj/items/Stun_Controls
		Cost=1000
	Stun_Chip
		Level=15
		Creates=/obj/items/Stun_Chip
		Cost=1000
	Cloak
		Level=32
		Creates=/obj/items/Cloak
		Cost=20000000
	Cloak_Controls
		Level=32
		Creates=/obj/items/Cloak_Controls
		Cost=40000000
	Safe
		Level=25
		Creates=/obj/items/Safe
		Cost=5000000
	TV
		Level=30
		Creates=/obj/items/TV
		Cost=10000

	Transporter_Pad
		Level=33
		Creates=/obj/items/Transporter_Pad
		Cost=40000000
	Teleportation_Watch
		Level=34
		Creates=/obj/items/Transporter_Watch
		Cost=40000000
	Nuke
		Level=70
		Creates=/obj/items/Nuke
		Cost=120000000
	Detonator
		Level=10
		Creates=/obj/items/Detonator
		Cost=1000
	Shovel
		Level=2
		Creates=/obj/items/Digging/Shovel
		Cost=1000
	Hand_Drill
		Level=4
		Creates=/obj/items/Digging/Hand_Drill
		Cost=10000
	Elixir_Of_Life
		Level=50
		Creates=/obj/items/Elixir_Of_Life
		Cost=20000000
	Drill_Tower
		Level=7
		Creates=/obj/Drill
		Cost=40000
/* // Temporarily Disabled.
	Turret
		Level=30
		Creates=/obj/items/Gun/Turret
		Cost=25000
*/

/*

	// All Items that are no longer in the game below HERE

	Diarea_Injection
		Level=22
		Creates=/obj/items/Diarea_Injection
		Cost=10000*/
	/*DNA_Container
		Level=30
		Creates=/obj/items/DNA_Container
		Cost=20000
	T_Virus
		Level=30
		Creates=/obj/items/T_Virus_Injection
		Cost=120000000
	Antivirus_Tower
		Level=50
		Creates=/obj/Antivirus_Tower
		Cost=2000000
	Mysterious_Portal
		Level=27
		Creates=/obj/Mysterious_Portal
		Cost=10000000
	Hover_Chair
		Level=15
		Creates=/obj/items/Hover_Chair
		Cost=500
	Cybernetics_Guide
		Level=12
		Creates=/obj/items/Cybernetics_Guide
		Cost=1000
	Shuriken
		Level=4
		Creates=/obj/items/Shuriken
		Cost=1000
*/

/*
obj/Drill
	density=1
	var/Resources=0
	var/DrillRate=1
	desc="This is an automated drill.  While it has a slow extraction rate, it is always on."
	New()
		var/image/A=image(icon='Space.dmi',icon_state="d1",pixel_y=16,pixel_x=-16)
		var/image/Z=image(icon='Space.dmi',icon_state="d2",pixel_y=16,pixel_x=16)
		var/image/C=image(icon='Space.dmi',icon_state="d3",pixel_y=-16,pixel_x=-16)
		var/image/D=image(icon='Space.dmi',icon_state="d4",pixel_y=-16,pixel_x=16)
		overlays.Remove(A,Z,C,D)
		overlays.Add(A,Z,C,D)
		spawn Drill()
		//..()
	proc/Drill()
		while(src)

			world << "DEBUG: Old Drill loop fired for drill \ref[src]. They now have rsc: [Resources]"

			for(var/area/B in range(0,src))
				if(B.type==/area||B.type==/area/Inside) continue
				if(B.Value)
					if(B.Value>=50*DrillRate)
						Resources+=50*DrillRate
						B.Value-=50*DrillRate
					else
						Resources+=B.Value
						B.Value=0
					if(B.Value<0)
						B.Value=0
						continue
						//view(src)<<"This area is out of resources."

			sleep(rand(400,800))
			if(z==0) del (src)

	Click()
		if(!(usr in range(1,src))) return
		if(usr.client.eye!=usr) return
		view(src)<<"[usr] withdraws [Commas(Resources)] resources from [src]"
		usr<<"This is a level [DrillRate] drill."
		for(var/mob/player/M in view(src)) if(M.client) M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] withdraws [Commas(Resources)] resources from [src] (built by: [src.Builder]).<br>")
		for(var/obj/Resources/A in usr)
			A.Value+=Resources
			Resources=0
	/*verb/Upgrade()
		set src in oview(1)
		var/obj/Resources/A
		for(var/obj/Resources/B in usr) A=B
		var/list/Choices=new
		if(A.Value>=40000/usr.Add) Choices.Add("Drill Rate ([40000/usr.Add])")
		if(!Choices)
			usr<<"You do not have enough resources"
			return
		var/Choice=input("Change what?") in Choices
		if(Choice=="Drill Rate ([40000/usr.Add])")
			if(A.Value<40000/usr.Add) return
			A.Value-=40000/usr.Add
			DrillRate++
		Tech++
		desc=null
		desc+="<br>Drill Rate: [DrillRate]x"
		view(src)<<"[usr] increases the drill rate of [src] to [DrillRate]x"*/
	verb/Upgrade()
		set src in oview(1)
		if(usr.Int_Level<Tech)
			usr<<"This is too advanced for you to mess with."
			return
		var/obj/Resources/A
		for(var/obj/Resources/B in usr) A=B
		var/Cost=40000/usr.Add
		var/Max_Upgrade=(A.Value/Cost)+Tech
		if(Max_Upgrade>usr.Int_Level) Max_Upgrade=usr.Int_Level
		var/Upgrade=input("Upgrade it to what level? (1-[round(Max_Upgrade)]). The maximum amount you can upgrade is determined by your intelligence (Max Upgrade cannot exceed Intelligence), and how much resources you have. So if the maximum is less than your intelligence then it is instead due to not having enough resources to upgrade it higher than the said maximum.") as num
		if(Upgrade>usr.Int_Level) Upgrade=usr.Int_Level
		if(Upgrade>Max_Upgrade) Upgrade=Max_Upgrade
		if(Upgrade<1) Upgrade=1
		Upgrade=round(Upgrade)
		if(Upgrade<Tech) switch(input("You wish to bring this Level [Tech] [src] to Level [Upgrade]?") in list("Yes","No"))
			if("No") return
		Cost*=Upgrade-Tech
		if(Cost<0) Cost=0
		if(Cost>A.Value)
			usr<<"You do not have enough resources to upgrade it to level [Upgrade]"
			return
		view(src)<<"[usr] upgrades the [src] to level [Upgrade]"
		for(var/mob/player/M in view(src)) if(M.client) M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades the [src] to level [Upgrade]. <br>")
		A.Value-=Cost
		Tech=Upgrade
		desc="Level [Tech] [src]"
		DrillRate=Upgrade
*/

/*proc/SpawnDrone()
	if(usr.z==1||usr.z==2)
		var/Mob/Drone/A=new
		del(src)*/

/obj/items/Drone
	icon='Android Spider.dmi'
//	SpawnDrone(usr)
			/*check_access(var/obj/items/Door_Pass/D)
				if(src.Password == D.Password)
					return 1
				else
					return 0*/
/*check_keycard(var/obj/items/Door_Pass/L)
	for(var/mob/player/P in oview(12,src))
		if(!P.Client)
			sleep(10)
			break
		if(P.Password!=L.Password)
			step_towards(src,P)
			sleep(4)
			break   Just some remnants of random test code I made to try and test FoF.*/


mob/Drone
	icon='Android Spider.dmi'
	var/function
	var/password=""
	var/dronekey
	var/target
/*	New()

		spawn Drone()
		//..()
	proc/Drone() while(src)
		if(Health<=0)
			view(src)<<"[src] has been defeated."
			del(src)
		sleep(10)*/
	Click()
		if(dronekey==usr.ckey)
			var/list/Choices=new
			Choices.Add("Follow","Stop","Attack Target","Guard Area","Destroy Drones","Destroy this drone","Cancel") //"Guard Area"
			switch(input("Choose Option") in Choices)

				/*if("Guard Area")
					walk(src,0)
					attacking=0
					function=1
					spawn while(src&&function)
						for(var/mob/A in oview(12,src))
							step_towards(src,A)
							break
						sleep(5)*/
				if("Guard Area")
					walk(src,0)
					attacking=0
					function=1

					spawn while(src&&function)
						var/obj/items/Door_Pass/L //=null
						sleep(15)

						for(var/mob/P in oview(12,src)) for(L in P) // for(var/mob/player/P in oview(12,src)) for(L in usr)  for(L in usr)  original   NPC_AI not taken into account.  Drones not attacking each other. /mob/Drone  /NPC_AI/Hostile/Tiger_Bandit
						//	if(!P.client)
							//	sleep (5)
							//	break

							if(L in P.contents)
								//world << "<font color=red><b>DEBUG:</b></font> Key found in [P]."
								for(L in P.contents)
									if(L.Password == src.password)
										sleep(2)
										//world << "<font color=red><b>DEBUG:</b></font> Drone password and [P]'s key are the same, ignoring target."
										break
									else
										//world << "<font color=red><b>DEBUG:</b></font> Drone password [src.password] and [P]'s password [L.Password] are NOT the same. Attacking."
										step_towards(src,P)
										sleep(4)
										break


							else
								//world << "<font color=red><b>DEBUG:</b></font> No key found in [P]. Attacking."
								step_towards(src,P)
								sleep(4)
								break

							sleep(15)


						/*for(var/mob/L in oview(12,src))
							if(L.displaykey!=usr.displaykey)
								step_towards(src,L)
								sleep(4)
								break
							else
								sleep(4)
								break*/
				if("Destroy Drones") for(var/mob/Drone/A) if(dronekey==usr.ckey) del(A)
				if("Destroy this drone") del(src)
				if("Follow")
					function=0
					attacking=1
					walk(src,0)
					walk_towards(src,usr)
				if("Stop")
					function=0
					walk(src,0)
				if("Attack Target")
					walk(src,0)
					function=0
					attacking=0
					var/mob/list/Targets=new
					for(var/mob/M in oview(12,src)) Targets.Add(M)
					var/mob/Choice=input("Attack who?") in Targets
					sleep(3)
					function=1
					while(src&&function)
						step_towards(src,Choice)
						sleep(10)

	verb/Upgrade()
		set src in oview(1)
		if(usr.Int_Level<Tech)
			usr<<"This is too advanced for you to mess with."
			return
		var/obj/Resources/A
		for(var/obj/Resources/B in usr) A=B
		var/Cost=40000/usr.Add
		var/Max_Upgrade=(A.Value/Cost)+Tech
		if(Max_Upgrade>usr.Int_Level) Max_Upgrade=usr.Int_Level
		var/Upgrade=input("Upgrade it to what level? (1-[round(Max_Upgrade)]). The maximum amount you can upgrade is determined by your intelligence (Max Upgrade cannot exceed Intelligence), and how much resources you have. So if the maximum is less than your intelligence then it is instead due to not having enough resources to upgrade it higher than the said maximum.") as num
		if(Upgrade>usr.Int_Level) Upgrade=usr.Int_Level
		if(Upgrade>Max_Upgrade) Upgrade=Max_Upgrade
		if(Upgrade<1) Upgrade=1
		Upgrade=round(Upgrade)
		if(Upgrade<Tech) switch(input("You wish to bring this Level [Tech] [src] to Level [Upgrade]?") in list("Yes","No"))
			if("No") return
		Cost*=Upgrade-Tech
		if(Cost<0) Cost=0
		if(Cost>A.Value)
			usr<<"You do not have enough resources to upgrade it to level [Upgrade]"
			return
		view(src)<<"[usr] upgrades the [src] to level [Upgrade]"
		for(var/mob/player/M in view(src)) if(M.client) M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades the [src] to level [Upgrade]. <br>")
		A.Value-=Cost
		Tech=Upgrade
		desc="Level [Tech] [src]"
		if (Race=="Tsufurujin")
			BP=Upgrade*(ScalingPower*(1/2)*(1/4))    //2*usr.Int_Level*(Year*Year_Speed)
		else
			BP=Upgrade*1.5*usr.Int_Level*(Year*Year_Speed)
		Str=Upgrade*(usr.Int_Level/1.4)
		End=Upgrade*(usr.Int_Level/1.4)
		Res=Upgrade*(usr.Int_Level/1.4)
		Off=Upgrade*(usr.Int_Level/1.4)
		Def=Upgrade*(usr.Int_Level/1.4)
	verb/Set_Password()
		set src in oview(1)
		if (password=="")
			password=input("Enter a password to keep this drone from being stolen from you.") as text
			usr<<"Password set!"
	verb/Claim_Drone()
		set src in oview(1)
		var/Claim_Drone=input("What is this drone's password?")
		if (Claim_Drone!=password)
			usr<<"Incorrect password."
		if (Claim_Drone==password)
			dronekey=usr.ckey
			usr<<"You have claimed this drone!"
			usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has claimed [src].<br>")
/*	for(var/mob/player/A in Players)
		if(A.Age>=20) //XPGained>=(Year*50)
			People++
			var/TheirXP=A.Gain_Multiplier*(1/2)
			if(People==1)
				XPRank+=TheirXP*(1/2)
			else
				XPRank+=TheirXP/People*/

/*mob/Drone
	var/function
	New()
		spawn Splitty()
		//..()
	Bump(atom/Z)
		MeleeAttack()
	proc/Splitty() while(src)
		if(Health<=0)
			view(src)<<"[src] has been defeated."
			del(src)
		sleep(10)
	Click()
		if(lastKnownKey==usr.key)
			var/list/Choices=new
			Choices.Add("Follow","Stop","Attack Target","Attack Nearest","Destroy Splitforms","Cancel")
			switch(input("Choose Option") in Choices)
				if("Attack Nearest")
					walk(src,0)
					attacking=0
					function=1
					while(src&&function)
						for(var/mob/A in oview(12,src))
							step_towards(src,A)
							break
						sleep(5)
				if("Destroy Splitforms")
					for(var/mob/Splitform/A)
						if(A.lastKnownKey == usr.key)
							del(A)
				if("Follow")
					function=0
					attacking=1
					walk(src,0)
					walk_towards(src,usr)
				if("Stop")
					function=0
					walk(src,0)
				if("Attack Target")
					walk(src,0)
					function=0
					attacking=0
					var/mob/list/Targets=new
					for(var/mob/M in oview(12,src)) Targets.Add(M)
					var/mob/Choice=input("Attack who?") in Targets
					sleep(10)
					function=1
					while(src&&function)
						step_towards(src,Choice)
						sleep(10)*/
obj/Slot_Machine
	icon='White Male.dmi'
	Stealable=1
	var/password=""
	desc="This machine lets you input money to play a round of slots.  You may win big, or you may lose hard.  It's all up to chance!<br><br>\
	<b>Stats:</b><br>\
	<i>Claimable (Password)</i>:  You can claim this item once by setting a password for it.<br>\
	<i>Gambling Device (Slot Machine)</i>:  If the usage fee isn't set, the usage fee defaults to 100 resources.  This item may be upgraded to increase the max usage fee.<br>\
	<i>Safe Linkable</i>: You may link this item to a safe.  It will automatically take or input funds there.  If the item lacks funds to draw from, it will shut down.\
	<i>Artificial Female Voice</i>:  Someone designed this machine to have a (presumably) enticing female voice.  Subliminal advertising or high octane nightmare fuel at its finest!"
	var/Link_to_Safe
	var/Input_Amount=100
	var/Payout_Amount
	var/Win
	var/Check_Password
	var/Chat

	verb/Use_Slot_Machine()
		set src in oview(1)
		for(var/obj/Resources/B in usr)
			if(B.Value<=Input_Amount)
				return
			if(B.Value>=Input_Amount)
				B.Value-=Input_Amount
				usr<<"The slot machine whirs for a moment, pausing, before a feminine mechanical voice says:  <font color=#F660AB>'Rolling your slots!~  Please stand by...'</font>"
				sleep(10)
				Win=rand(1,15)
				switch (Win)
					if(1,2,3,4,5,6,12)
						usr<<"The slot machine sounds dejected as it says:  <font color=#F660AB>'Aww, no match!  Care to try your luck again?'</font>"
						return
					if(7,8,9,10,11)
						usr<<"As the slots settle into place, the slot machine chirps out the words:  <font color=#F660AB>'Low match!  Congratulations!  You're a winner!  Here's your reward of [Input_Amount*1.3] credits!'</font>"
						B.Value+=Input_Amount*1.3
						return
					if(13,14)
						usr<<"As the slots settle into place, the slot machine happily says the words:  <font color=#F660AB>High match!  Congratulations!  You're a winner!  Here's your reward of [Input_Amount*2] credits!</font>"
						B.Value+=Input_Amount*2
						return
					if(15)
						usr<<"As the slots settle into place, you can see that you've come up with three 7's.  Lights begin to flash all around the machine, as the voice says exuberantly: <font color=#F660AB>Jackpot!  CONGRATULATIONS!~  You're a winner!  Here's your reward of [Input_Amount*4] credits!</font>"
						B.Value+=Input_Amount*4
						return
/*					if(Win==1||2||3||4||5||6)
						usr<<"The slot machine sounds dejected as it says:  <font color=pink>'Aww, no match!  Care to try your luck again?'</font>"
						return
					if(Win==7||8||9||10||11||12)
						usr<<"As the slots settle into place, the slot machine chirps out the words:  <font color=pink>'Low match!  Congratulations!  You're a winner!  Here's your reward of [Input_Amount*1.3] credits!'</font>"
						B.Value=Input_Amount*1.3
						return
					if(Win==13||14)
						usr<<"As the slots settle into place, the slot machine happily says the words:  <font color=pink>High match!  Congratulations!  You're a winner!  Here's your reward of [Input_Amount*2] credits!</font>"
						B.Value=Input_Amount*2
						return
					if(Win==15)
						usr<<"As the slots settle into place, you can see that you've come up with three 7's.  Lights begin to flash all around the machine, as the voice says exuberantly: <font color=pink>Jackpot!  CONGRATULATIONS!~  You're a winner!  Here's your reward of [Input_Amount*4] credits!</font>"
						B.Value=Input_Amount*4
						return*/
	verb/Claim_Slot_Machine()
		set src in oview(1)
		if (password=="")
			password=input("Enter a password to keep this slot machine from being accessed by unauthorized personnel.") as text
			usr<<"Password set!"
	verb/Set_Usage_Fee()
		set src in oview(1)
		Check_Password=input("What is this slot machine's password?") as text
		if(Check_Password!=password)
			usr<<"Incorrect password."
		if(Check_Password==password)
			Input_Amount=input("Password received!  Input the amount of money you would like to require this machine to be used at!  All rewards will be multiplied by this input amount, so make sure you have enough money in your safe to cover the usage fee!")
			if(Input_Amount==0)
				usr<<"Invalid number.  Resetting the fee to the default amount."
				Input_Amount=100
			name= "[Input_Amount] Credit Slot Machine"


/*	proc/Slot_Flavor
		sleep(1)
		rand(1,2)
		var/Chat
		if(*/








/*				if(Win==1||2||3||4||5||6)
					usr<<"The slot machine sounds dejected as it says:  'Aww, no match!  Care to try your luck again?'"
					break
				if(Win==7||8||9||10||11||12)
					usr<<"As the slots settle into place, the slot machine chirps out the words:  'Low match!  Congratulations!  You're a winner!  Here's your reward of [Input_Amount*1.3] credits!'"
					B.Value=Input_Amount*1.3
					break
				if(Win==13||14)
					usr<<"High match!  Congratulations!  You're a winner!  Here's your reward of [Input_Amount*2] credits!"
					B.Value=Input_Amount*2
					break
				if(Win==15)
					usr<<"Jackpot!  CONGRATULATIONS!~  You're a winner!  Here's your reward of [Input_Amount*4] credits!"
					B.Value=Input_Amount*4
					break*/
