#define DRILLS

var/list/DrillList = new()

proc/loopThroughDrills()
	var/count = 0

	if(!global.DrillList.len || !global.DrillList)
		spawn(600) // Pause 1 minute
			.() // Then call itself again

	for(var/obj/Drill/drillObj in global.DrillList)
		count++
		sleep(0)

		//world << "DEBUG: Drill \ref[drillObj] is collecting."

		for(var/area/B in range(0,drillObj))
			if(B.type==/area||B.type==/area/Inside) continue
			if(B.Value > 1)
				if(B.Value>=50*drillObj.DrillRate)
					drillObj.Resources+=50*drillObj.DrillRate
					B.Value-=50*drillObj.DrillRate
					//world << "DEBUG: Drill \ref[drillObj] has collected: [50*drillObj.DrillRate] from [B] ([B.type])."
				else
					drillObj.Resources+=B.Value
					B.Value=0
					//world << "DEBUG: Drill \ref[drillObj] has collected: [B.Value] from [B] ([B.type])."
				if(B.Value<=1) continue
					//B.Value=0
					//continue
			sleep(-1)

		if(count >= 500) // pause every 500 drills
			count=0
			sleep(600) // for a full minute
	for(var/obj/Mana_Pylon/drillObj in global.DrillList)
		count++
		sleep(0)

		//world << "DEBUG: Drill \ref[drillObj] is collecting."

		for(var/area/B in range(0,drillObj))
			if(B.type==/area||B.type==/area/Inside) continue
			if(B.Value_Mana > 1)
				if(B.Value_Mana>=50*drillObj.DrillRate)
					drillObj.Resources+=50*drillObj.DrillRate
					B.Value_Mana-=50*drillObj.DrillRate
					//world << "DEBUG: Drill \ref[drillObj] has collected: [50*drillObj.DrillRate] from [B] ([B.type])."
				else
					drillObj.Resources+=B.Value_Mana
					B.Value_Mana=0
					//world << "DEBUG: Drill \ref[drillObj] has collected: [B.Value] from [B] ([B.type])."
				if(B.Value_Mana<=1) continue
					//B.Value=0
					//continue
			sleep(-1)

		if(count >= 500) // pause every 500 drills
			count=0
			sleep(600) // for a full minute

	spawn(3000) // Pause 5 minutes
		.() // Then call itself again
obj/Magical_Portal
	Bolted = 1
	Can_Change = 0
	Savable=1
	Health = 99999999999999999999999999999999
	desc="Click to travel. This is a magicial portal, it could lead anywhere..."
	icon = 'Magic Portal.dmi'
	var/Portal_Number
	Click()
		if(src in range(2,usr))
			for(var/obj/Magical_Portal/P in world)
				if(P != src) if(P.Portal_Number) if(P.Portal_Number == src.Portal_Number)
					view(8,usr) << "[usr] enters the portal."
					usr.loc = P.loc
					view(8,usr) << "[usr] exits the portal."
					return
	verb
		Remove()
			set src in range(1,usr)
			switch(input("Are you sure you want to close this portal permanently?") in list("No","Yes"))
				if("Yes")
					if(src.Builder == usr.ckey)
						var/N = 20
						while(N)
							N -= 1
							var/obj/Mana/M = new
							M.Value+=rand(100000,333333)
							M.loc = src.loc
							M.name = "[Commas(M.Value)] Mana"
							M.dir = rand(1,8)
							step_rand(M)
							sleep(1)
							step_rand(M)
							sleep(1)
							step_rand(M)
						del(src)
						return
	Del()
		if(src.Portal_Number)
			Portals += src.Portal_Number
		..()
	New()
		spawn(1000)
			if(src) src.pixel_x = -37
			if(Portals)
				if(!src.Portal_Number) if(src.tag != "Special")
					if(Portals)
						var/P = pick(Portals)
						src.Portal_Number = P
						Portals -= P
						src.Savable=1
			if(src.Portal_Number)
				for(var/obj/Magical_Portal/P in range(0,src))
					if(P != src)
						del(P)
			if(src.tag == "Special")
				spawn(9000)
					if(src)
						view(8,src) << "[src] closes shut!"
						del(src)
						return
obj
	var
		link_used = 0
	proc
		Move_Resources(var/turf/t,var/mob/M)
			if(src.loc == t)
				for(var/obj/Mana/Y in view(0,src))
					if(Y == src)
						for(var/mob/X in range(1,src))
							if(M) if(X == M)
								for(var/obj/Mana/magic in M)
									magic.Value += Y.Value
									del(src)
				return
			if(t) if(M) if(src.loc != t)
				step_towards(src,t)
				spawn(5)
					if(t) if(M) src.Move_Resources(t,M)
		Pylon_Link(var/mob/clicker)
			for(var/obj/Mana_Pylon/X in view(0,src))
				if(X == src)
					if(X.Resources > 0)
						var/obj/Mana/A = new
						A.Value+=X.Resources
						A.loc = X.loc
						A.name = "[Commas(X.Resources)] Mana"
						var/turf/t = clicker.loc
						A.Move_Resources(t,clicker)
					//var/obj/Auras/Sparks/S = new
					//S.loc = src.loc
					//S.pixel_y = 14
					//S.icon = 'blue elec.dmi'
					//S.layer = 100
					view(src)<<"[clicker] withdraws [Commas(X.Resources)] mana from [src]"
					clicker<<"This is a level [X.DrillRate] mana pylon."
					for(var/mob/player/M in view(src)) if(M.client) M.saveToLog("| [clicker.client.address ? (clicker.client.address) : "IP not found"] | ([clicker.x], [clicker.y], [clicker.z]) | [key_name(clicker)] withdraws [Commas(X.Resources)] mana from [src] (built by: [src.Builder]).\n")
					src.link_used = 1
					spawn(33)
						if(src) src.link_used = 0
					for(var/obj/Mana_Pylon/P in oview(2,src))
						if(P.Builder == src.Builder) if(P.link_used == 0)
							P.Pylon_Link(clicker)
						var/Step = get_step_towards(X,P)
						var/Dir = get_dir(X,P)
						if(Dir == SOUTH || Dir == EAST || Dir == WEST || Dir == NORTH)
							var/obj/Auras/Sparks/E = new
							E.loc = Step
							E.pixel_y = 14
							E.icon = 'blue elec.dmi'
							E.layer = 100
							spawn(20)
								if(E) del(E)
					//spawn(20)
						//if(S) del(S)
					X.Resources=0
obj/Mana_Pylon
	density=1
	var/Resources=0
	var/DrillRate=1
	Savable = 1
	desc="This is a Mana Pylon. It will slowly absorb ambient energy."
	icon = 'Mana_Pylon.dmi'
	New()
		global.DrillList += src // add them to the global list
	Click()
		if(!(usr in range(1,src))) return
		if(usr.client.eye!=usr) return
		src.Pylon_Link(usr)

	verb/Enhance()
		set src in oview(1)
		if(usr.Magic_Level<Tech)
			usr<<"This is too advanced for you to mess with."
			return
		var/obj/Mana/A
		for(var/obj/Mana/B in usr) A=B
		var/Cost=40000/usr.Magic_Potential
		var/Max_Upgrade=(A.Value/Cost)+Tech
		if(Max_Upgrade>usr.Magic_Level) Max_Upgrade=usr.Magic_Level
		var/Upgrade=input("Upgrade it to what level? (1-[round(Max_Upgrade)]). The maximum amount you can upgrade is determined by your magical skill (Max Upgrade cannot exceed magical skill), and how much mana you have. So if the maximum is less than your magic skill then it is instead due to not having enough mana to upgrade it higher than the said maximum.") as num
		if(Upgrade>usr.Magic_Level) Upgrade=usr.Magic_Level
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
		for(var/mob/player/M in view(src)) if(M.client) M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades the [src] to level [Upgrade]. \n")
		A.Value-=Cost
		Tech=Upgrade
		desc="Level [Tech] [src]"
		DrillRate=Upgrade
obj/Drill
	density=1
	var/Resources=0
	var/DrillRate=1
	Savable = 1
	desc="This is an automated drill.  While it has a slow extraction rate, it is always on."

	New()
		var/image/A=image(icon='Space.dmi',icon_state="d1",pixel_y=16,pixel_x=-16)
		var/image/Z=image(icon='Space.dmi',icon_state="d2",pixel_y=16,pixel_x=16)
		var/image/C=image(icon='Space.dmi',icon_state="d3",pixel_y=-16,pixel_x=-16)
		var/image/D=image(icon='Space.dmi',icon_state="d4",pixel_y=-16,pixel_x=16)
		overlays.Remove(A,Z,C,D)
		overlays.Add(A,Z,C,D)
		global.DrillList += src // add them to the global list
		//..()

	Click()
		if(!(usr in range(1,src))) return
		if(usr.client.eye!=usr) return
		view(src)<<"[usr] withdraws [Commas(Resources)] resources from [src]"
		usr<<"This is a level [DrillRate] drill."
		for(var/mob/player/M in view(src)) if(M.client) M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] withdraws [Commas(Resources)] resources from [src] (built by: [src.Builder]).\n")
		for(var/obj/Resources/A in usr)
			A.Value+=Resources
			Resources=0

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
		for(var/mob/player/M in view(src)) if(M.client) M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades the [src] to level [Upgrade]. \n")
		A.Value-=Cost
		src.cost += Cost
		Tech=Upgrade
		desc="Level [Tech] [src]"
		DrillRate=Upgrade