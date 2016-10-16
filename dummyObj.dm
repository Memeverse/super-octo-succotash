obj
	var
		cost = 0
		magical = 0
		add_energy
		add_bp = 0
		add_str = 0
		add_end = 0
		add_spd = 0
		add_res = 0
		add_off = 0
		add_def = 0
		add_force = 0
		add_recov = 0
		add_regen = 0
obj/Magic
	var/displaykey
	var/Creates
	var/Cost=0
	Level=1
	verb
		Inspect()
			set src in world
			set name = "Inspect"
			set category = "Other"
			if(src.Creates)
				var/obj/A=new src.Creates
				usr << A.desc
				del(A)
	Click()
		for(var/obj/Mana/B in usr)
			var/Amount=0
			for(var/obj/O in range(0,usr)) if(!(locate(O) in usr)) Amount++
			if(Amount>=20)
				usr<<"Nothing more can be placed on this spot."
				return
			if(B.Value < round(initial(Cost)/usr.Magic_Potential) )
				usr<<"You do not have the mana to create this."
				return
			B.Value -= round(initial(Cost)/usr.Magic_Potential)
			var/obj/A=new Creates
			if(A)
				view(20,usr) << "[usr] creates a [A]."
				A.loc=usr.loc
			//	for(var/obj/A=new Creates)

				A.Builder="[key_name(usr)], [usr.client.address]"
				usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] creates [A.name] ([A])")
				global.worldObjectList+=A


			else
				B.Value += round(initial(Cost)/usr.Magic_Potential)
				usr<<"There are no more available ship interiors, you cannot create this."
				del(A)
			if(istype(A,/obj/Door))
				A:Grabbable=0
				A.Builder = usr.ckey
				var/New_Password=input(usr,"Enter a password or leave blank") as text
				if(!A) return
				A.Password=New_Password


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

	Magic_Goo
		Level=4
		Creates=/obj/TrainingEq/Magic_Goo
		Cost=4000
	Spell_Book
		Level=10
		Creates=/obj/items/Spell_Book
		Cost=40000
	Magic_Door
		Level=10
		Creates=/obj/Door/Lockable/Magic_Door
		Cost=400000
	Magic_Circle
		Level=20
		Creates=/obj/items/Magic_Circle
		Cost=400000
	Crystal_Ball
		Level=25
		Creates=/obj/items/Crystal_Ball
		Cost=40000000
	Simulation_Crystal
		Level=33
		Creates=/obj/items/Simulation_Crystal
		Cost=80000000
	Magic_Vault
		Level=40
		Creates=/obj/items/Magic_Vault
		Cost=4000000
	Phylactery
		Level=120
		Creates=/obj/items/Phylactery
		Cost=5000000000
	Mana_Pylon
		Level=7
		Creates=/obj/Mana_Pylon
		Cost=40000
obj/Technology
	var/displaykey
	var/Creates
	var/Cost=0
	Level=1
	verb
		Inspect()
			set src in world
			set name = "Inspect"
			set category = "Other"
			if(src.Creates)
				var/obj/A=new src.Creates
				usr << A.desc
				del(A)
	Click()
		for(var/obj/Resources/B in usr)
			var/Amount=0
			for(var/obj/O in range(0,usr)) if(!(locate(O) in usr)) Amount++
			if(Amount>=20)
				usr<<"Nothing more can be placed on this spot."
				return
			if(B.Value < round(initial(Cost)/usr.Add) )
				usr<<"You do not have the resources to create this."
				return
			B.Value -= round(initial(Cost)/usr.Add)
			var/obj/A=new Creates
			if(A)
				view(20,usr) << "[usr] creates a [A]."
				A.Serial = rand(11111,99999)
				A.loc=usr.loc
				A.cost = round(initial(Cost)/usr.Add)
			//	for(var/obj/A=new Creates)

				A.Builder="[key_name(usr)], [usr.client.address]"
				usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] creates [A.name] ([A])")
				if(istype(A,/obj/items/Scanner)) if((A.z in list(1,5,7,10,13))||(usr.Race in list("Human","Spirit Doll","Kaio","Demigod")))
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
				B.Value += round(initial(Cost)/usr.Add)
				usr<<"There are no more available ship interiors, you cannot create this."
				del(A)
			if(istype(A,/obj/items/Drone)) for(var/mob/Drone in range(0,usr))
				del(A)
				A= new /mob/Drone		//Creates= new /mob/Drone/
				A.loc=usr.loc
				A.Builder="[key_name(usr)], [usr.client.address]"
				global.worldObjectList+=A
			if(istype(A,/obj/Door))
				A:Grabbable=0
				A.Builder = usr.ckey
				var/New_Password=input(usr,"Enter a password or leave blank") as text
				if(!A) return
				A.Password=New_Password
			if(istype(A,/obj/items/Android_Chassis))
				A.Builder = usr.ckey
				var/N=input(usr,"Enter a name.") as text
				if(!A)
					var/X = rand(100,900)
					A.name = "Android - [X]"
				A.name=N


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
	Boxing_Gloves
		Level=3
		Creates=/obj/items/Boxing_Gloves
		Cost=1000
	Bandages
		Level=3
		Creates=/obj/items/Bandages
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
	Reinforced_Vault
		Level=10
		Creates=/obj/Door/Lockable/Reinforced_Vault
		Cost=400000
	Reinforced_Door
		Level=10
		Creates=/obj/Door/Lockable/Reinforced_Door
		Cost=400000
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
	PDA
		Level=12
		Creates=/obj/items/PDA
		Cost=1000

	Spacesuit
		Level=20
		Creates=/obj/items/Spacesuit
		Cost=4000
	Motion_Detector
		Level=30
		Creates=/obj/items/Motion_Detector
		Cost=400000
	Security_Camera
		Level=30
		Creates=/obj/items/Security_Camera
		Cost=400000
	Bomb
		Level=30
		Creates=/obj/items/Bomb
		Cost=100000
	Recycler
		Level=33
		Creates=/obj/items/Recycler
		Cost=1000000
	//Automated_Tournament_Registrar
		//Level=30
		//Creates=/obj/Tournament_Register
		//Cost=700000
	Moon
		Level=100
		Creates=/obj/items/Moon
		Cost=80000000
	Scanner
		Level=22
		Creates=/obj/items/Scanner
		Cost=200000
	Drone
		Level=40
		Creates=/obj/items/Drone  // /mob/drone
		Cost=1000000
	Android_Upgrade_Component
		Level=40
		Creates=/obj/items/Android_Upgrade
		Cost=80000000
	Android_Chassis
		Level=40
		Creates=/obj/items/Android_Chassis
		Cost=120000000

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
		Level=60
		Creates=/obj/items/Gravity
		Cost=80000000
	Force_Field
		Level=28
		Creates=/obj/items/Force_Field
		Cost=4000000
	Pod
		Level=40
		Creates=/obj/Ships/Spacepod
		Cost=10000000
	PodMKII
		Level=60
		Creates=/obj/Ships/SpacepodMKII
		Cost=20000000
	Ship
		Level=80
		Creates=/obj/Ships/Ship
		Cost=100000000
	Transporter_Watch
		Level=90
		Cost=200000000
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
		Level=33
		Creates=/obj/items/Antivirus
		Cost=100000
	Modernized_Cloning_Tank
		Level=81
		Creates=/obj/items/Cloning_Tank/Modernized
		Cost=400000000
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
		Level=40
		Creates=/obj/items/Safe
		Cost=4000000
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
	//Nuke
		//Level=70
		//Creates=/obj/items/Nuke
		//Cost=120000000
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
	Adamantine_Skeleton
		Level=80
		Creates=/obj/items/Adamantine_Skeleton
		Cost=400000000
	Power_Armor
		Level=120
		Creates=/obj/items/Power_Armor
		Cost=800000000
	Drill_Tower
		Level=7
		Creates=/obj/Drill
		Cost=40000


/* // Temporarily Disabled.
	Turret
		Level=30
		Creates=/obj/items/Gun/Turret
		Cost=25000

	Hover_Chair
		Level=30
		Creates=/obj/items/Hover_Chair
		Cost=10000
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
	Cybernetics_Guide
		Level=12
		Creates=/obj/items/Cybernetics_Guide
		Cost=1000
	Shuriken
		Level=4
		Creates=/obj/items/Shuriken
		Cost=1000
*/
