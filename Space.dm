
proc/Bump_Planet(obj/Planets/Planet,obj/Ships/Bumper)
	var/Landed = 0
	while(Landed == 0)
		if(!Planet.Planet_X) Bumper.loc=locate(rand(1,world.maxx),rand(1,world.maxy),Planet.Planet_Z)

		else Bumper.loc=locate(Planet.Planet_X+rand(-10,50),Planet.Planet_Y+rand(-10,50),Planet.Planet_Z)

		if(istype(Bumper,/obj/Ships)) if(Bumper.Nav) if(!Bumper.Planets.Find(Planet.name))
			Bumper.Planets+=Planet.name
		new/obj/Crater(Bumper.loc)
		var/Dense = 0
		for(var/atom/A in Bumper.loc)
			if(A != Bumper)
				if(A.density)
					Dense = 1
		if(Dense == 0)
			Landed = 1

obj/items/Spacesuit
	icon='Mask.dmi'
	name="Air Mask"
	density=1
	desc="You can survive in space if you equip this"
	Stealable=1
	Click()
		if(!suffix)
			for(var/obj/items/Spacesuit/A in usr) if(A!=src&&A.suffix) return
			suffix="*Equipped*"
			usr.overlays+=icon
			usr<<"You put on the [src]."
			usr.Lungs++
		else
			suffix=null
			usr.overlays-=icon
			usr<<"You take off the [src]."
			usr.Lungs-=1
		usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] [suffix ? "removes" : "equips"] the [src].\n")
obj/Controls
	icon='Scan Machine.dmi'
	icon_state="2"
	density=1
	Savable=0
	Health=1.#INF
	Spawn_Timer=3000
	Grabbable=0
	Shockwaveable=0
	var/Ship=0
	proc/Ship_Interior_Reset()
		for(var/turf/A in block(locate(src.x-1,src.y-15,src.z),locate(src.x+16,src.y+1,src.z)))
			for(var/mob/P in A)
				for(var/obj/Ships/S in world)
					if(S.Ship==src.Ship)
						P.loc=locate(S.x+1,S.y+1,S.z)
			for(var/obj/O in A)
				if(O!=src) if(O.type != /obj/Airlock)
					del(O)
			if(A.InitialType)
				new A.InitialType(A)
	verb/Toggle_Stabilizers()
		set src in oview(1)
		for(var/obj/Ships/Ship/A) if(A.Ship==Ship)
			if(A.StabilizeInertia())
				usr << "Stabilizers are now engaged."
			else
				usr << "Stabilizers are now disengaged."
			return
	verb/View_Ship()
		set src in oview(1)
		for(var/obj/Ships/Ship/A) if(A.Ship==Ship)
			usr<<"Click the ship to stop observing"
			usr.reset_view(A)
			return
	verb/Pilot()
		set src in oview(1)
		for(var/obj/Ships/Ship/A) if(A.Ship==Ship)
			if(A.Pilot)
				usr<<"[A.Pilot] is already piloting the ship"
				return
			A.Pilot=usr
			usr.reset_view(A)
			usr.S=A
			usr<<"Click the ship to stop piloting"
			view(usr)<<"[usr] is now piloting the ship"
			usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] is piloting the ship.\n")
			return
	verb/Launch()
		set src in oview(1)
		for(var/obj/Ships/Ship/A) if(A.Ship==Ship) if(A.z!=11&&!A.Launching)
			A.Launching=1
			usr<<"Launching in 3 minutes..."
			usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has initiated the launch for their ship.\n")
			spawn(1800) if(src&&A)
				A.Launching=0
				Liftoff(A)

/*	verb/Leave()
		set src in oview(1)
		for(var/obj/Ships/Ship/A) if(A.Ship==Ship&&A)
			usr.loc=A.loc
			if(A.Pilot==usr) A.Pilot=null
			if(usr.S==A) usr.S=null
			usr.client.eye=usr
			return
		usr.z=0
		usr.Location()*/
obj/Airlock
	icon='Lab.dmi'
	icon_state="doorshut"
	density=1
	Savable=0
	Health=1.#INF
	Spawn_Timer=3000
	Grabbable=0
	Shockwaveable=0
	var/Ship=0
	verb/Leave()
		set src in oview(1)
		var/Found = 0
		for(var/obj/Ships/Ship/A) for(var/obj/AndroidShips/B) if(A.Ship==Ship&&A||B.Ship==Ship&&B)
			usr.loc=A.loc
			Found = 1
			if(A.Pilot==usr) A.Pilot=null
			if(usr.S==A) usr.S=null
			usr.reset_view()
			usr.Heart_Virus()
			return
		if(Found == 0)
			usr.client.sendToSpawn(usr)
			usr.Heart_Virus()
	proc/Ship_Interior_Reset()
		for(var/turf/A in block(locate(src.x-1,src.y-15,src.z),locate(src.x+16,src.y+1,src.z)))
			for(var/mob/P in A) for(var/obj/Ships/S in world) if(S.Ship==Ship) P.loc=locate(S.x+1,S.y+1,S.z)
			for(var/obj/O in A) if(O!=src) if(O.type != /obj/Airlock) del(O)
			if(A.InitialType) new A.InitialType(A)
		usr.z=0
		usr.Location()
obj/AndroidAirlock
	icon='Lab.dmi'
	icon_state="doorshut"
	density=1
	Savable=0
	Health=1.#INF
	Spawn_Timer=3000
	Grabbable=0
	Shockwaveable=0
	var/Ship=0
	verb/Leave()
		set src in oview(1)
		var/Found = 0
		for(var/obj/AndroidShips/Ship/A)  if(A.Ship==Ship&&A)
			usr.loc=A.loc
			Found = 1
			if(A.Pilot==usr) A.Pilot=null
			if(usr.S==A) usr.S=null
			usr.reset_view()
			usr.Heart_Virus()
			return
		if(Found == 0)
			usr.client.sendToSpawn(usr)
			usr.Heart_Virus()
	proc/Ship_Interior_Reset()
		for(var/turf/A in block(locate(src.x-1,src.y-15,src.z),locate(src.x+16,src.y+1,src.z)))
			for(var/mob/P in A) for(var/obj/Ships/S in world) if(S.Ship==Ship) P.loc=locate(S.x+1,S.y+1,S.z)
			for(var/obj/O in A) if(O!=src) if(O.type != /obj/Airlock) del(O)
			if(A.InitialType) new A.InitialType(A)
		usr.z=0
		usr.Location()
//Only thing left is to finish the cloaking system
obj/AndroidControls
	icon='control_new.dmi'
	density=1
	Savable=0
	Health=1.#INF
	Spawn_Timer=3000
	Grabbable=0
	Shockwaveable=0
	pixel_x = -88
	pixel_y = -60
	var/Ship=0
	proc/Ship_Interior_Reset()
		for(var/turf/A in block(locate(src.x-1,src.y-15,src.z),locate(src.x+16,src.y+1,src.z)))
			for(var/mob/P in A)
				for(var/obj/Ships/S in world)
					if(S.Ship==src.Ship)
						P.loc=locate(S.x+1,S.y+1,S.z)
			for(var/obj/O in A)
				if(O!=src) if(O.type != /obj/Airlock)
					del(O)
			if(A.InitialType)
				new A.InitialType(A)
	verb/Toggle_Stabilizers()
		set src in oview(1)
		for(var/obj/AndroidShips/Ship/A) if(A.Ship==Ship)
			if(A.StabilizeInertia())
				usr << "Stabilizers are now engaged."
			else
				usr << "Stabilizers are now disengaged."
			return
	verb/View_Ship()
		set src in oview(1)
		if(usr.Race != "Android")
			usr << "Looks like only an Android can interface with this control panel. The supreme artificial intelligence of the Android Ship bars your access!"
			return
		for(var/obj/AndroidShips/Ship/A) if(A.Ship==Ship)
			usr<<"Click the ship to stop observing"
			usr.reset_view(A)
			return
	verb/Pilot()
		set src in oview(1)
		if(usr.Race != "Android")
			usr << "Looks like only an Android can interface with this control panel. The supreme artificial intelligence of the Android Ship bars your access!"
			return
		for(var/obj/AndroidShips/Ship/A) if(A.Ship==Ship)
			if(A.Pilot)
				usr<<"[A.Pilot] is already piloting the ship"
				return
			A.Pilot=usr
			usr.reset_view(A)
			usr.S=A
			usr<<"Click the ship to stop piloting"
			view(usr)<<"[usr] is now piloting the ship"
			A.Tech=2
			usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] is piloting the ship.\n")
			return
	verb/Launch()
		set src in oview(1)
		if(usr.Race != "Android")
			usr << "Looks like only an Android can interface with this control panel. The supreme artificial intelligence of the Android Ship bars your access!"
			return
		for(var/obj/AndroidShips/Ship/A) if(A.Ship==Ship) if(A.z!=11&&!A.Launching)
			A.Launching=1
			usr<<"Launching in 3 minutes..."
			usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has initiated the launch for their ship.\n")
			spawn(1800) if(src&&A)
				A.Launching=0
				Liftoff(A)

obj/Ships
	density=1
	Savable=1
	layer=MOB_LAYER+1
	var/tmp/mob/Pilot
	var/tmp/Launching
	Health=5000
	var/Fuel=100
	var/Armor=1
	var/Speed=64
	var/Efficiency=1
	var/Refire=64
	var/Cloak=0
	var/Nav
	var/list/Planets=new
	var/HasLasers
	var/tmp/Moving
	var/Small
	var/Ship
	var/tmp/Firing
	Move()
		var/Former_Location=loc
		..()
		Door_Check(Former_Location)
	proc/Door_Check(turf/Former_Location) for(var/obj/Door/A in loc) if(A.density)
		loc=Former_Location
		if(Pilot) Pilot.Bump(A)
		break
	proc/Fuel()
		Fuel-=1/Efficiency
		if(Fuel<0)
			usr<<"Your ship is out of fuel"
			Fuel=0
	proc/Lasers()
		if(!HasLasers||Firing) return
		Firing=1
		spawn(Refire) Firing=0
		var/obj/ranged/Blast/A=new
		A.Belongs_To=usr
		A.pixel_x=rand(-16,16)
		A.pixel_y=rand(-16,16)
		A.icon='13.dmi'
		A.icon+=rgb(200,0,0)
		A.Damage=2000*1000 //2000 bp, 1000 force
		A.Power=2000
		A.Offense=500
		A.Shockwave=1
		A.Explosive=1
		A.dir=dir
		A.loc=loc
		walk(A,A.dir)
	proc/StabilizeInertia()
		//Heh we toggle in this shit
		anchored = !(anchored)
		return anchored
	verb/Upgrade()
		set src in oview(1)
		var/obj/Resources/A
		for(var/obj/Resources/B in usr) A=B
		var/list/Choices=new
		if(A.Value>=100000*Tech/usr.Add&&Speed>1) Choices.Add("Speed ([100000*Tech/usr.Add])")
		if(A.Value>=100000*Tech/usr.Add) Choices.Add("Fuel Efficiency ([100000*Tech/usr.Add])")
		if(A.Value>=100000*Tech/usr.Add) Choices.Add("Armor + Repair ([100000*Tech/usr.Add])")
		if(A.Value>=100000*Tech/usr.Add&&Refire>1) Choices.Add("Laser Defense ([100000*Tech/usr.Add])")
		if(A.Value>=100000*Tech/usr.Add&&!Nav) Choices.Add("Navigation Computer ([100000*Tech/usr.Add])")
		if(Fuel<100) Choices.Add("Refuel (Up to 5000)")
		if(usr.Int_Level<Tech)
			usr<<"This ship is far beyond your technical capabilities!"
			return
		if(!Choices)
			usr<<"You do not have enough resources"
			return
		var/Choice=input("Change what?") in Choices
		if(Choice=="Refuel (Up to 5000)")
			var/Cost=round((100-Fuel)*50)
			if(A.Value<Cost) return
			usr<<"Refueling cost you [Cost]"
			Fuel=100
			A.Value-=Cost
			return
		if(Choice=="Speed ([100000*Tech/usr.Add])")
			if(A.Value<50000*Tech/usr.Add) return
			A.Value-=50000*Tech/usr.Add
			src.cost += 50000*Tech/usr.Add
			Speed*=0.5
			Tech++
		if(Choice=="Fuel Efficiency ([100000*Tech/usr.Add])")
			if(A.Value<50000*Tech/usr.Add) return
			A.Value-=50000*Tech/usr.Add
			src.cost += 50000*Tech/usr.Add
			Efficiency*=2
			Tech++
		if(Choice=="Armor + Repair ([100000*Tech/usr.Add])")
			if(A.Value<50000*Tech/usr.Add) return
			A.Value-=50000*Tech/usr.Add
			src.cost += 50000*Tech/usr.Add
			Armor*=5
			Health=100000*Armor
		if(Choice=="Laser Defense ([100000*Tech/usr.Add])")
			if(A.Value<50000*Tech/usr.Add) return
			A.Value-=50000*Tech/usr.Add
			src.cost += 50000*Tech/usr.Add
			if(!HasLasers) HasLasers=1
			else Refire*=0.5
		if(Choice=="Navigation Computer ([100000*Tech/usr.Add])")
			if(A.Value<50000*Tech/usr.Add) return
			A.Value-=50000*Tech/usr.Add
			src.cost += 50000*Tech/usr.Add
			Nav=1
		Tech++
		desc=null
		desc+="<br>Speed: [64/Speed]"
		desc+="<br>Fuel Efficiency: [Efficiency] ([round(Fuel)]% Fuel)"
		desc+="<br>Armor: [Armor] ([round((Health/(5000*Armor))*100)]% Remaining)"
		if(HasLasers) desc+="<br>Laser Defense: [64/Refire]"
		if(Cloak) desc+="<br>Cloak: [Cloak]"
		if(Nav)
			desc+="<br>Nav Computer Installed"
			for(var/P in Planets) desc+="<br>*[P]"
/*	verb/Upgrade()
		set src in oview(1)
		if(usr.Int_Level<Tech)
			usr<<"This is too advanced for you to mess with."
			return
		var/obj/Resources/A
		for(var/obj/Resources/B in usr) A=B
		var/Cost=400000/usr.Add
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
		A.Value-=Cost
		Tech=Upgrade
		desc="Level [Tech] [src]"
		Fuel=100
		Efficiency=Upgrade*0.01*rand(50,200)
		Speed=round(64/Upgrade)*0.01*rand(50,200)
		Armor=Upgrade*0.01*rand(50,200)
		Health=5000*Armor
		if(Speed<1) Speed=1
		if(Upgrade>=50)
			HasLasers=1
			Refire=5
		if(Upgrade>60) Nav=1*/
	proc/MoveReset() spawn(Speed) Moving=0
	New() //spawn if(src) Ship_Loop()
	proc/Ship_Loop() while(src)
		if(HasLasers) for(var/OBJ_AI/SpaceDebris/A in view(src))
			missile('Laser.dmi',src,A)
			A.Health-=5000
			if(A.Health<=0) spawn(3) if(A) del(A)
		sleep(Refire)
	Del()
		if(Pilot)
			Pilot.loc=locate(src.x+1,src.y+1,src.z)
			Pilot.dir=SOUTH
			Pilot.reset_view()
			Pilot=null
		for(var/obj/Controls/A in world)
			if(A.Ship==src.Ship)
				A.Ship_Interior_Reset()
		for(var/turf/A in view(2,src))
			new/obj/Explosion(locate(A.x,A.y,A.z))
		new/obj/BigCrater(locate(x,y,z))
		..()
	Bump(obj/A)
		if(Small&&istype(A,/obj/Ships/Ship))
			var/obj/Ships/Ship/B=A
			for(var/obj/Airlock/C in world) if(C.Ship==B.Ship)
				view(src)<<"[src] enters the ship"
				loc=locate(C.x,C.y-1,C.z)
		if(istype(A,/obj/Planets)) Bump_Planet(A,src)
			/*var/obj/Planets/B=A
			if(!B.Planet_X) loc=locate(rand(1,world.maxx),rand(1,world.maxy),B.Planet_Z)
			else loc=locate(B.Planet_X+rand(-10,10),B.Planet_Y+rand(-10,10),B.Planet_Z)
			if(Nav) if(!Planets.Find(B.name)) Planets+=B.name
			new/obj/Crater(locate(x,y,z))*/
		if(Pilot&&istype(A,/obj/Door)) Pilot.Bump(A)

	Ship
		Health=25000
		Speed=64
		Efficiency=1
		Grabbable=0
		Click()
			if(usr.client.eye==src) usr.reset_view()
			if(Pilot==usr)
				Pilot=null
				usr.S=null
		New()
			//if(isnull(src.loc)&&src.z==0) del (src)
			spawn(10)
				if(!src.Ship) for(var/obj/Controls/B in world)
					if(B.Ship)
						var/FoundShip = 0
						for(var/obj/Ships/Ship/C in world) if(C.Ship==B.Ship) FoundShip=1
						if(!FoundShip)
							src.Ship=B.Ship
							break
				if(!Ship)
					view(src)<<"An available ship interior could not be found."
					del(src)
				var/image/A=image(icon='Huge Ship Red Dark.dmi',icon_state="1 1",pixel_x=-37,pixel_y=-48,layer=MOB_LAYER-1)
				//var/image/A=image(icon='Ship.dmi',icon_state="1 1",pixel_x=-16,pixel_y=-16,layer=MOB_LAYER-1)
				/*var/image/B=image(icon='Ship.dmi',icon_state="1 2",pixel_x=16,pixel_y=-16,layer=MOB_LAYER-1)
				var/image/C=image(icon='Ship.dmi',icon_state="2 1",pixel_x=-48,pixel_y=-16,layer=MOB_LAYER-1)
				var/image/D=image(icon='Ship.dmi',icon_state="2 2",pixel_x=-48,pixel_y=16,layer=MOB_LAYER-1)
				var/image/E=image(icon='Ship.dmi',icon_state="2 3",pixel_x=-16,pixel_y=16,layer=MOB_LAYER-1)
				var/image/F=image(icon='Ship.dmi',icon_state="2 4",pixel_x=16,pixel_y=16,layer=MOB_LAYER-1)
				var/image/G=image(icon='Ship.dmi',icon_state="2 5",pixel_x=48,pixel_y=16,layer=MOB_LAYER-1)
				var/image/H=image(icon='Ship.dmi',icon_state="2 6",pixel_x=48,pixel_y=-16,layer=MOB_LAYER-1)
				var/image/I=image(icon='Ship.dmi',icon_state="3 1",pixel_x=-48,pixel_y=48)
				var/image/J=image(icon='Ship.dmi',icon_state="3 2",pixel_x=-16,pixel_y=48)
				var/image/K=image(icon='Ship.dmi',icon_state="3 3",pixel_x=16,pixel_y=48)
				var/image/L=image(icon='Ship.dmi',icon_state="3 4",pixel_x=48,pixel_y=48)
				var/image/M=image(icon='Ship.dmi',icon_state="4 1",pixel_x=-48,pixel_y=80)
				var/image/N=image(icon='Ship.dmi',icon_state="4 2",pixel_x=-16,pixel_y=80)
				var/image/O=image(icon='Ship.dmi',icon_state="4 3",pixel_x=16,pixel_y=80)
				var/image/P=image(icon='Ship.dmi',icon_state="4 4",pixel_x=48,pixel_y=80)*/
				//overlays.Remove(A)
				overlays.Add(A)
			//	overlays.Remove(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P)
			//	overlays.Add(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P)
		Ship_Mother
			name = "Mother Ship"
			icon = 'mothership.dmi'
			Health=250000000000000000000000
			Speed=1
			Efficiency=1
			Grabbable=0
			Click()
				if(usr.client.eye==src) usr.reset_view()
				if(Pilot==usr)
					Pilot=null
					usr.S=null
			New()
				src.pixel_x = -115
				src.pixel_y = -128
	Spacepod
		icon='Spacepod.dmi'
		Small=1
		Health=5000
		Speed=64
		Efficiency=3
		Grabbable=1
		var/Claim_Pod
		var/Access_Validated
		verb/Use()
			set src in world
			if(((locate(usr.client.mob) in range(1,src))&&usr.z==z)||usr.S==src)
				if(usr.client.eye!=usr&&usr.client.eye!=src) return
				var/pass=input("What is this pod's password?")
				if(pass!=password)
					usr<<"Incorrect password.  Disengaging user interface."
					return
				if(pass==password)
					if(Pilot)
						if(Pilot!=usr)
							usr<<"The pod is already in use by [Pilot]"
							return
						else
							usr.isGrabbing = null
							usr.loc=loc
							usr.dir=SOUTH
							usr.reset_view()
							usr.S=null
							Pilot=null
							usr.Heart_Virus()
					else
						usr.isGrabbing = null
						Pilot=usr
						usr.S=src
						usr.loc=locate(0,0,0)
						usr.reset_view(src)
		verb/Launch()
			set src in world
			if(!(locate(usr.client.mob) in range(1,src))&&Pilot!=usr) return
			if(Pilot!=usr)
				usr<<"You are not the pilot"
				return
			else if(!Launching)
				icon_state="Launching"
				Launching=1
				usr<<"Launching in 1 minute..."
				usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] is launching [src].\n")
				spawn(600) if(src)
					icon_state=""
					Launching=0
					Liftoff(src)
		verb/Set_Password()
			set src in oview(1)
			if (password==" ")
				password=input("Enter a password to keep this spacepod from being stolen from you.") as text
				usr<<"Password set!"
			else
				usr<<"You are not the owner of this pod.  Have control transferred to you to set the password."
				return
		verb/Claim_Pod()
			set src in oview(1)
			var/Claim_Pod=input("What is this spacepod's password?")
			if (Claim_Pod!=password)
				usr<<"Incorrect password."
				return
			if (Claim_Pod==password)
			//	password=" "
				usr<<"You have claimed this pod!"
				usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has claimed [src].\n")
	SpacepodMKII
		icon='NewSpacePod.dmi'
		icon_state = "idle"
		Small=1
		Health=50000
		Speed=1
		Nav = 1
		Efficiency=30
		Armor = 500
		HasLasers = 1
		pixel_x = -32
		pixel_y = -32
		Grabbable=0
		var/Claim_Pod
		var/Access_Validated
		verb/Use()
			set src in world
			if(((locate(usr.client.mob) in range(1,src))&&usr.z==z)||usr.S==src)
				if(usr.client.eye!=usr&&usr.client.eye!=src) return
				var/pass=input("What is this pod's password?")
				if(pass!=password)
					usr<<"Incorrect password.  Disengaging user interface."
					return
				if(pass==password)
					if(Pilot)
						if(Pilot!=usr)
							usr<<"The pod is already in use by [Pilot]"
							return
						else
							usr.isGrabbing = null
							usr.loc=loc
							usr.dir=SOUTH
							usr.reset_view()
							usr.S=null
							Pilot=null
							src.icon_state = "idle"
					else
						usr.isGrabbing = null
						src.icon_state = ""
						Pilot=usr
						usr.S=src
						usr.loc=locate(0,0,0)
						usr.reset_view(src)
		verb/Launch()
			set src in world
			if(!(locate(usr.client.mob) in range(1,src))&&Pilot!=usr) return
			if(Pilot!=usr)
				usr<<"You are not the pilot"
				return
			else if(!Launching)
				icon_state="Launching"
				Launching=1
				usr<<"Launching in 30 seconds..."
				usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] is launching [src].\n")
				spawn(300) if(src) if(src.icon_state == "Launching")
					icon_state=""
					Launching=0
					Liftoff(src)
		verb/Set_Password()
			set src in oview(1)
			if (password==" ")
				password=input("Enter a password to keep this spacepod from being stolen from you.") as text
				usr<<"Password set!"
			else
				usr<<"You are not the owner of this pod.  Have control transferred to you to set the password."
				return
		verb/Claim_Pod()
			set src in oview(1)
			var/Claim_Pod=input("What is this spacepod's password?")
			if (Claim_Pod!=password)
				usr<<"Incorrect password."
				return
			if (Claim_Pod==password)
			//	password=" "
				usr<<"You have claimed this pod!"
				usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has claimed [src].\n")

obj/AndroidShips
	density=1
	Savable=1
	layer=MOB_LAYER+1
	var/tmp/mob/Pilot
	var/tmp/Launching
	Health=99999999999999999999
	var/Fuel=999999999999999999
	var/Armor=999999999999999999
	var/Speed=5
	var/Efficiency=99999999999
	var/Refire=64
	var/Cloak=0
	var/Nav
	var/list/Planets=new
	var/HasLasers
	var/tmp/Moving
	var/Small
	var/Ship = 50
	var/tmp/Firing
	Move()
		var/Former_Location=loc
		..()
		Door_Check(Former_Location)
	proc/Door_Check(turf/Former_Location) for(var/obj/Door/A in loc) if(A.density)
		loc=Former_Location
		if(Pilot) Pilot.Bump(A)
		break
	proc/Fuel()
		return
		/*Fuel-=1/Efficiency
		if(Fuel<0)
			usr<<"Your ship is out of fuel"
			Fuel=0*/
	proc/Lasers()
		if(!HasLasers||Firing) return
		Firing=1
		spawn(Refire) Firing=0
		var/obj/ranged/Blast/A=new
		A.Belongs_To=usr
		A.pixel_x=rand(-16,16)
		A.pixel_y=rand(-16,16)
		A.icon='13.dmi'
		A.icon+=rgb(200,0,0)
		A.Damage=2000*1000 //2000 bp, 1000 force
		A.Power=2000
		A.Offense=500
		A.Shockwave=1
		A.Explosive=1
		A.dir=dir
		A.loc=loc
		walk(A,A.dir)
	proc/StabilizeInertia()
		//Heh we toggle in this shit
		anchored = !(anchored)
		return anchored
	proc/MoveReset() spawn(Speed) Moving=0
	New() //spawn if(src) Ship_Loop()
	proc/Ship_Loop() while(src)
		if(HasLasers) for(var/OBJ_AI/SpaceDebris/A in view(src))
			missile('Laser.dmi',src,A)
			A.Health-=5000
			if(A.Health<=0) spawn(3) if(A) del(A)
		sleep(Refire)
	Del()
		if(Pilot)
			Pilot.loc=loc
			Pilot.dir=SOUTH
			Pilot.reset_view()
			Pilot=null
		for(var/obj/Controls/A)
			if(A.Ship==src.Ship)
				A.Ship_Interior_Reset()
		for(var/turf/A in view(2,src))
			new/obj/Explosion(locate(A.x,A.y,A.z))
		new/obj/BigCrater(locate(x,y,z))
		..()
	Bump(obj/A)
		if(Small&&istype(A,/obj/AndroidShips/Ship))
			var/obj/AndroidShips/Ship/B=A
			for(var/obj/AndroidAirlock/C in world) if(C.Ship==B.Ship)
				view(src)<<"[src] enters the ship"
				loc=locate(C.x,C.y-1,C.z)
//		else if(istype(A,/obj/AndroidShips))
//			var/obj/AndroidShips/B=A
//			B.Health-=5000
//			Health-=2500
//			if(B.Health<=0) del(B)
//			if(Health<=0) del(src)
		if(istype(A,/obj/Planets)) Bump_Planet(A,src)
			/*var/obj/Planets/B=A
			if(!B.Planet_X) loc=locate(rand(1,world.maxx),rand(1,world.maxy),B.Planet_Z)
			else loc=locate(B.Planet_X+rand(-10,10),B.Planet_Y+rand(-10,10),B.Planet_Z)
			if(Nav) if(!Planets.Find(B.name)) Planets+=B.name
			new/obj/Crater(locate(x,y,z))*/
		if(Pilot&&istype(A,/obj/Door)) Pilot.Bump(A)

	Ship
		Health=25000000
		Speed=1
		Efficiency=1
		icon='AWESOMEPLANETS.dmi'
		icon_state="Android"
		Grabbable=0
		Click()
			if(usr.client.eye==src) usr.reset_view()
			if(Pilot==usr)
				Pilot=null
				usr.S=null
/*		New()
			if(!Ship) for(var/obj/Controls/B) if(B.Ship)
				var/FoundShip
				for(var/obj/Ships/Ship/C) if(C.Ship==B.Ship) FoundShip=1
				if(!FoundShip)
					Ship=B.Ship
					break
			if(!Ship)
				view(src)<<"An available ship interior could not be found."
				del(src)*/



proc/Liftoff(obj/Ships/O)
	if(O.loc==/area/Inside){O.Pilot<<"Launch failed. You are inside a building."; return}
	var/obj/Planets/A = (O.z==1 ? locate(/obj/Planets/Earth) : O.z==4 ? locate(/obj/Planets/Vegeta) : \
	O.z==3 ? locate(/obj/Planets/Namek) : O.z==8 ? locate(/obj/Planets/Arconia) : \
	O.z==12 ? locate(/obj/Planets/Ice) : O.z==14&&O.x<=249&&O.y<=249 ? locate(/obj/Planets/Desert) : \
	O.z==14&&O.x<=249&&O.y>=252 ? locate(/obj/Planets/Jungle) : O.z==14&&O.x>=252&&O.y>=252 ? locate(/obj/Planets/Android) : O.z==14&&O.x>=252&&O.y<=249 ? locate(/obj/Planets/Alien) : null)

	if(!A){O.Pilot<<"Launch failed. This is not a planet's surface."; return}

	O.Move(locate(A.x,A.y-2,A.z))

obj/Planets
	icon='AWESOMEPLANETS.dmi'
	density=1
	var/Planet_X
	var/Planet_Y
	var/Planet_Z
	var/Ship
	Savable=1
	Grabbable=0
	Health=1.#INF
	Earth
		icon_state="Earth"
		Planet_Z=1
		New()
			//..()
			if(!Earth) del(src)
			//else walk_rand(src,50)
			for(var/obj/A) if(A.type==type) if(A!=src) del(A)
	Namek
		icon_state="Namek"
		Planet_Z=3
		New()
			//..()
			if(!Namek) del(src)
			//else walk_rand(src,100)
			for(var/obj/A) if(A.type==type) if(A!=src) del(A)
	Vegeta
		icon_state="Vegeta"
		Planet_Z=4
		New()
			//..()
			if(!Vegeta) del(src)
			//else walk_rand(src,100)
			for(var/obj/A) if(A.type==type) if(A!=src) del(A)
	Alien
		icon_state="Alien"
		Planet_Z=14
		Planet_X=360
		Planet_Y=80
		New()
			//..()
			if(!Alien) del(src)
			//else walk_rand(src,100)
			for(var/obj/A) if(A.type==type) if(A!=src) del(A)
	Arconia
		icon_state="Arconia"
		Planet_Z=8
		New()
			//..()
			if(!Arconia) del(src)
			//else walk_rand(src,100)
			for(var/obj/A) if(A.type==type) if(A!=src) del(A)
	Ice
		icon_state="Ice"
		Planet_Z=12
		New()
			//..()
			if(!Ice) del(src)
			//else walk_rand(src,100)
			for(var/obj/A) if(A.type==type) if(A!=src) del(A)
	Desert
		icon_state="Desert"
		Planet_X=120
		Planet_Y=170
		Planet_Z=14
		New()
			//..()
			if(!Desert) del(src)
			//else walk_rand(src,100)
			for(var/obj/A) if(A.type==type) if(A!=src) del(A)
	Jungle
		icon_state="Jungle"
		Planet_X=220
		Planet_Y=280
		Planet_Z=14
		New()
			//..()
			if(!Jungle) del(src)
			//else walk_rand(src,100)
			for(var/obj/A) if(A.type==type) if(A!=src) del(A)
	Android
		icon_state="Android"
//		Planet_X=290
//		Planet_Y=270
//		Planet_Z=14
		New()
			//..()
			if(!Android) del(src)
			//else walk_rand(src,100)
			for(var/obj/A) if(A.type==type) if(A!=src) del(A)