/**********************************************************************************************
		NPC SPAWN AREAS

	5 Dec 2010

Mobs are not dependant on where placed on the map, instead, you create an area for the
relevant planet, and then assign the mobs that should spawn in the area (Hostile or Docile)
and how much of said mob should be created.

The rest of the system will then take care of randomly placing these around the map.

Only when a player enters the designated area will the AI of that specific area activate.
For NPC AI behaviour, see 'npc_ai.dm'

The variables are a dirty fix to making sure the two Cleanup Procs dont start multiple times and fuck shit up.

SET_DOCILE_NPCS(var/L, var/area/NPC_AI/O)
	The params set, at area creation are read.
	Each mob is given a location, and it'll keep cycling through the areas until it finds one it can place the mob on.

Clean_Objs() & Clean_Mobs()
	They run through the objects and mobs in the game (the ones defined by the AI) and delete the ones that, for some reason, are not on the map.
	These procs are activated once all of the mob/object generation has been done respectively.

-- Valekor

**********************************************************************************************/

var/tmp/objcleaning=0
var/tmp/npccleaning=0
var/tmp/npcareacount=0
var/tmp/objareacount=0


proc/SET_DOCILE_NPCS(var/L,var/area/NPC_AI/O)
	set background = 1
	var/list/N = params2list(L)

	if(!global.MapsLoaded) // If the maps havn't loaded, the INSIDE areas have not yet been placed
		sleep(600) // sleep one minute
		return .(L,O) // Call self again to recheck.

	if(N)
		var/i
		for(i=1,i<=N.len,i++)

			var/M = N[i]
			var/NPC_AI/Docile/A = text2path("/NPC_AI/Docile/[M]")
			var/j
			var/max = text2num(N[M])

			for(j=1,j<=max,j++)
			//	ASSERT(/area/NPC_AI/A)
				var/NPC_AI/B = new A
				B.loc = null
				spawn while(!isnull(B)&&B.loc==null)
					sleep(3)
					var/turf/E = pick(get_area_turfs(O))
					if(E&&!E.density&&!E.Water&&!istype(E,/area/Inside))
						if(isnull(B)) break
						B.loc = locate(E.x,E.y,E.z)
						break
/*** DEBUG ***
				world.log << "B = [B]"
				world.log << "Src.Z = [O.z]"
				world.log << "Turf E = [E]"
				world.log << "Turf E.x = [E.x]"
				world.log << "B.loc = [B.loc]"
*/
				sleep(Set_Spawn_Delay())
		//log_game("All Docile NPCs spawned for [O].")
			Clean_Mobs()
		return

proc/SET_HOSTILE_NPCS(var/L,var/area/NPC_AI/O)
	set background = 1
	var/list/N = params2list(L)

	if(!global.MapsLoaded) // If the maps havn't loaded, the INSIDE areas have not yet been placed
		sleep(600) // sleep one minute
		return .(L,O) // Call self again to recheck.

	if(N)
		var/i
		for(i=1,i<=N.len,i++)

			var/M = N[i]
			var/NPC_AI/Hostile/A = text2path("/NPC_AI/Hostile/[M]")
			var/j
			var/max = text2num(N[M])

			for(j=1,j<=max,j++)

				var/NPC_AI/Hostile/B = new A
				B.loc = null
				spawn while(!isnull(B)&&B.loc==null)
					sleep(3)
					var/turf/E = pick(get_area_turfs(O))
					if(E&&!E.density&&!E.Water&&!istype(E,/area/Inside))
						if(isnull(B)) break
						B.loc = locate(E.x,E.y,E.z)
						break
/*** DEBUG ***
				world.log << "B = [B]"
				world.log << "Src.Z = [O.z]"
				world.log << "Turf E = [E]"
				world.log << "Turf E.x = [E.x]"
				world.log << "B.loc = [B.loc]"
*/
				sleep(Set_Spawn_Delay())
		//log_game("Hostile NPC's spawned for [O].")
			Clean_Mobs()
		return

proc/SET_SPACEDEBRIS(var/L,var/area/NPC_AI/O)
	set background = 1
	var/list/N = params2list(L)

	if(!global.MapsLoaded) // If the maps havn't loaded, the INSIDE areas have not yet been placed
		sleep(600) // sleep one minute
		return .(L,O) // Call self again to recheck.

	if(N)
		var/i
		for(i=1,i<=N.len,i++)

			var/M = N[i]
			var/OBJ_AI/SpaceDebris/A = text2path("/OBJ_AI/SpaceDebris/[M]")
			var/j
			var/max = text2num(N[M])

			for(j=1,j<=max,j++)

				var/OBJ_AI/B = new A
				B.loc = null
				spawn while(!isnull(B)&&B.loc==null)
					sleep(3)
					var/turf/E = pick(get_area_turfs(O))
					if(E&&!E.density&&!E.Water)
						if(isnull(B)) break
						B.loc = locate(E.x,E.y,E.z)
						break

				sleep(Set_Spawn_Delay())
		//log_game("Spawned all SpaceDebris for [O].")
			Clean_Objs()
	return

proc/Set_Spawn_Delay()
	//var/npc_spawn_delay
	npc_spawn_delay++
	if(npc_spawn_delay>=10)
		npc_spawn_delay=1
	return npc_spawn_delay

proc/Clean_Objs()
	if(isnum(objareacount) && objareacount < 3)
		objareacount ++
		//log_game("OBJ: Areacount [objareacount].")
		return
	else if (!isnum(objareacount))
		log_warning("CLEAN_OBJS: AREACOUNT NOT A NUMBER! ALERT A PROGRAMMER ABOUT THIS ERROR ASAP!")
		return
	else if(objareacount == 3&&!objcleaning)
		objcleaning=1
		log_game("Finding and removing wrongly placed Objects.")
		log_errors("Finding and removing wrongly placed Objects.")
		sleep(100)
		world<<"<span class=\"announce\">Finding and removing wrongly placed Objects.</span>"
		var/count
		for(var/OBJ_AI/SpaceDebris/O in world)
			if(isnull(O.loc)&&O.x==0||O.z==0||O.y==0) // Since it's impossible to have any of these coordinates 0 when you're ON the map, something must be wrong if any of the ARE 0 after placing the mobs.
				del(O)
				count++
			sleep(3)
		log_game("OBJ_AI cleaned. [count ? count : "0"] Erronous objects were removed.")
		log_errors("OBJ_AI cleaned. [count ? count : "0"] Erronous objects were removed.")
		world<<"<span class=\"announce\">Wrongly placed Objects cleansed.</span>"
		return

proc/Clean_Mobs()
	set background = 1
	if(isnum(npcareacount) && npcareacount < 33)
		if(npcareacount==1) world<<"<span class=\"announce\">Spawning NPCs.</span>"
		npcareacount ++
		//log_game("MOBS: Areacount [npcareacount].")

		if(npcareacount == 33&&!npccleaning)
			npccleaning=1
			log_game("Finding and removing wrongly placed AI.")
			log_errors("Finding and removing wrongly placed AI.")
			sleep(100)
			world<<"<span class=\"announce\">NPCs Spawned. Finding and removing wrongly placed AI.</span>"
			var/count
			for(var/NPC_AI/Docile/A in world)
				if(A.x==0||A.z==0||A.y==0)
					count++
					del(A)
				sleep(0)

			log_game("Docile mobs cleaned.")
			log_errors("Docile mobs cleaned.")

			for(var/NPC_AI/Hostile/A in world)
				if(A.x==0||A.z==0||A.y==0)
					count++
					del(A)
				sleep(0)

			log_game("Hostile mobs cleaned.")
			log_errors("Hostile mobs cleaned.")

			for(var/mob/Drone/A in world)
				if(A.x==0||A.z==0||A.y==0)
					count++
					del(A)
				sleep(0)

			log_game("Drone mobs cleaned.")
			log_errors("Drone mobs cleaned.")

			world<<"<span class=\"announce\">AI primed and ready.</span>"
			log_game("Finished cleaning mobs. [count ? count : "0"] Erronous mobs were removed.")
			log_errors("Finished cleaning mobs. [count ? count : "0"] Erronous mobs were removed.")
		return

	else if (!isnum(npcareacount))
		log_warning("CLEAN_MOBS: AREACOUNT NOT A NUMBER! ALERT A PROGRAMMER ABOUT THIS ERROR ASAP!")
		return


area/var/tmp/awake
var/tmp/npc_spawn_delay

area/NPC_AI // 34 sub areas total

	var/tmp/NPCs_in_area[0]
	var/tmp/Hostiles_in_area[0]
	var/tmp/Obj_in_area[0]

	Entered(mob/player/M)
		if(ismob(M) && M.client)
			Wake_Area()
		..()

	Exited(mob/player/M)
		if(ismob(M) && M.client)
			Sleep_Area()
		..()

/**** NPC WAKING/SLEEPING ****/

	proc/Wake_Area()
		for(var/client/C) // If there already is a player in the area and it's active, then there's no need to activate the AI a second time.
			if(C.mob in src&&awake) return
		var/count=0 //0 if the count++ line is uncommented
		if(!awake)
			awake = 1
			for(var/NPC_AI/M in src)
				if(count >= 10) count=0
				count++  //It'll take a tenth of a second longer for each new mob it finds. This is to prevent possible crashes.    -  Temporarily disabled to see how the servers handle less of a delay.
				sleep(count) //sleep(count)
				//log_errors("ACTIVATING AI [count]")
				if(M&&!M.active)
					spawn(15) M.Activate_NPC_AI()  //spawn(count)
			//log_game("")
		return

	proc/Sleep_Area()
		for(var/client/C) // If there are still players in the area when one leaves, then the AI needn't shutdown.
			if(C.mob in src) return
		var/count=0
		if(awake)
			awake = 0
			for(var/NPC_AI/M in src)
				if(count >= 10) count=0
				count++
				sleep(count)
				if(M&&M.active) M.Deactivate_NPC_AI()
		//log_game("")
		return

/**** OBJECT WAKING/SLEEPING ****/

	proc/Obj_Wake()
		for(var/client/C) // If there already is a player in the area and it's active, then there's no need to activate the AI a second time.
			if(C.mob in src&&awake) return
		var/count=0
		if(!awake)
			awake = 1
			for(var/OBJ_AI/M in src)
				if(count >= 10) count=0
				count++ // It'll take a tenth of a second longer for each new mob it finds. This is to prevent possible crashes.
				if(M&&!M.active)
					spawn(count) M.Activate_OBJ_AI()
			//log_game("")
		return

	proc/Obj_Sleep()
		for(var/client/C) // If there are still players in the area when one leaves, then the AI needn't shutdown.
			if(C.mob in src) return
		var/count=0
		if(awake)
			for(var/OBJ_AI/M in src)
				if(count >= 10) count=0
				count++
				sleep(count)
				if(M&&M.active) M.Deactivate_OBJ_AI()
		awake = 0
			//log_game("")
		return
	icon='Weather.dmi'
	Death // Just a blank area which we use to send the killed mobs to, awaiting their respawn.

	Earth // 10 sub-areas


		// Earth Areas and NPC numbers per area defined below
		// The list isn't of spawns isn't something I pulled out of my ass, I actually counted each NPC in these areas.
		// Earth alone has around 400 +/- NPCs

		Turtle_Beach
			New()
				NPCs_in_area["Turtle"]=9
				spawn(Set_Spawn_Delay()) SET_DOCILE_NPCS(list2params(NPCs_in_area),src)
				icon='Weather.dmi'
				layer=10

		Wild_SE
			New()
				Hostiles_in_area["Shade"]=64
				spawn(Set_Spawn_Delay()) SET_HOSTILE_NPCS(list2params(Hostiles_in_area),src)

				NPCs_in_area["Cat"]=25
				NPCs_in_area["Bat"]=12
				NPCs_in_area["Dino_Bird"]=18
				spawn(Set_Spawn_Delay()) SET_DOCILE_NPCS(list2params(NPCs_in_area),src)
				icon='Weather.dmi'
				layer=10
		Wild_SW
			New()
				Hostiles_in_area["Shade"]=25
				Hostiles_in_area["Tiger_Bandit"]=35
				spawn(Set_Spawn_Delay()) SET_HOSTILE_NPCS(list2params(Hostiles_in_area),src)
				icon='Weather.dmi'
				layer=10
		Desert
			New()
				icon='Weather.dmi'
				icon_state="Bright"
				Hostiles_in_area["Night_Wolf"]=9
				Hostiles_in_area["Tiger_Bandit"]=37
				Hostiles_in_area["Bandit"]=58
			//	Hostiles_in_area["Shade"]=3
			//	NPCs_in_area["Gremlin"]=10
				spawn(Set_Spawn_Delay()) SET_HOSTILE_NPCS(list2params(Hostiles_in_area),src)

				spawn(Set_Spawn_Delay()) SET_DOCILE_NPCS(list2params(NPCs_in_area),src)
				icon='Weather.dmi'
				layer=10

		North_East
			New()
				NPCs_in_area["Turtle"]=2
				NPCs_in_area["Frog"]=3
				NPCs_in_area["Bat"]=3
				spawn(Set_Spawn_Delay()) SET_DOCILE_NPCS(list2params(NPCs_in_area),src)
				icon='Weather.dmi'
				layer=10

		North
			New()
				NPCs_in_area["Bat"]=18
				NPCs_in_area["Dino_Bird"]=9
				NPCs_in_area["Cat"]=5
				spawn(Set_Spawn_Delay()) SET_DOCILE_NPCS(list2params(NPCs_in_area),src)
				icon='Weather.dmi'
				layer=10

		North_West
			New()
				Hostiles_in_area["Ice_Dragon"]=4
				Hostiles_in_area["Ice_Flame"]=4
				spawn(Set_Spawn_Delay()) SET_HOSTILE_NPCS(list2params(Hostiles_in_area),src)
				icon='Weather.dmi'
				layer=10
		North_of_Spawn
			New()
				NPCs_in_area["Frog"]=20
				spawn(Set_Spawn_Delay()) SET_DOCILE_NPCS(list2params(NPCs_in_area),src)

		Mountain_Area
			New()
				NPCs_in_area["Bat"]=5
				NPCs_in_area["Dino_Bird"]=3
				NPCs_in_area["Cat"]=2
				spawn(Set_Spawn_Delay()) SET_DOCILE_NPCS(list2params(NPCs_in_area),src)
				icon='Weather.dmi'
				layer=10

		Wolf_Island
			New()
				Hostiles_in_area["Night_Wolf"]=9
				spawn(Set_Spawn_Delay()) SET_HOSTILE_NPCS(list2params(Hostiles_in_area),src)
				icon='Weather.dmi'
				layer=10
		Reaver_Compound_NW
			New()
		//		Hostiles_in_area["Red Reaver Bandit"]=25
				Hostiles_in_area["Tiger_Bandit"]=25
				spawn(Set_Spawn_Delay()) SET_HOSTILE_NPCS(list2params(Hostiles_in_area),src)
				icon='Weather.dmi'
				layer=10
		Reaver_Compound_NE
			New()
				Hostiles_in_area["Red Reaver Bandit"]=25
				spawn(Set_Spawn_Delay()) SET_HOSTILE_NPCS(list2params(Hostiles_in_area),src)
				icon='Weather.dmi'
				layer=10
		Reaver_Compound_SE
			New()
				Hostiles_in_area["Red_Reaver_Bandit"]=25
				spawn(Set_Spawn_Delay()) SET_HOSTILE_NPCS(list2params(Hostiles_in_area),src)
				icon='Weather.dmi'
				layer=10
		Reaver_Compound_SW
			New()
				Hostiles_in_area["Red_Reaver_Bandit"]=25
				spawn(Set_Spawn_Delay()) SET_HOSTILE_NPCS(list2params(Hostiles_in_area),src)
				icon='Weather.dmi'
				layer=10
		Reaver_Compound_Boss_Room
			New()
			//	Hostiles_in_area["Red_Reaver_Champion"]=4
				spawn(Set_Spawn_Delay()) SET_HOSTILE_NPCS(list2params(Hostiles_in_area),src)
				icon='Weather.dmi'
				layer=10
	Namek // 4 sub areas
		NearSpawn
			New()
				NPCs_in_area["Frog"]=5
				spawn(Set_Spawn_Delay()) SET_DOCILE_NPCS(list2params(NPCs_in_area),src)
				icon='Weather.dmi'
				layer=10

		Spawn_Farm
			New()
				NPCs_in_area["Cow"]=3
				spawn(Set_Spawn_Delay()) SET_DOCILE_NPCS(list2params(NPCs_in_area),src)
				icon='Weather.dmi'
				layer=10
		Northern_Island_Rightside
			New()
				NPCs_in_area["Dino_Munky"]=12
				spawn(Set_Spawn_Delay()) SET_DOCILE_NPCS(list2params(NPCs_in_area),src)

				Hostiles_in_area["Gremlin"]=13
				spawn(Set_Spawn_Delay()) SET_HOSTILE_NPCS(list2params(Hostiles_in_area),src)
				icon='Weather.dmi'
				layer=10
		Northern_Island_Leftside
			New()
				NPCs_in_area["Dino_Bird"]=8
				spawn(Set_Spawn_Delay()) SET_DOCILE_NPCS(list2params(NPCs_in_area),src)

				Hostiles_in_area["Gremlin"]=5
				spawn(Set_Spawn_Delay()) SET_HOSTILE_NPCS(list2params(Hostiles_in_area),src)
				icon='Weather.dmi'
				layer=10
	Vegeta // 7 sub areas
		Island_NEast
			New()
				Hostiles_in_area["Big_Robot"]=4
				Hostiles_in_area["Hover_Robot"]=4
				Hostiles_in_area["Mutated_Plantman"]=4
				Hostiles_in_area["Robot"]=4
				spawn(Set_Spawn_Delay()) SET_HOSTILE_NPCS(list2params(Hostiles_in_area),src)
				icon='Weather.dmi'
				layer=10
		Island_South
			New()
				Hostiles_in_area["Mutated_Plantman"]=4
				Hostiles_in_area["Giant_Robot"]=4
				Hostiles_in_area["Small_Plantman"]=4
				Hostiles_in_area["Plantman"]=4
				spawn(Set_Spawn_Delay()) SET_HOSTILE_NPCS(list2params(Hostiles_in_area),src)
				icon='Weather.dmi'
				layer=10
		Island_SWest
			New()
				Hostiles_in_area["Plantman"]=6
				spawn(Set_Spawn_Delay()) SET_HOSTILE_NPCS(list2params(Hostiles_in_area),src)
				icon='Weather.dmi'
				layer=10
		Spawn_Island_NE
			New()
				Hostiles_in_area["Giant_Robot"]=4
				Hostiles_in_area["Small_Plantman"]=4
				Hostiles_in_area["Mutated_Plantman"]=4
				Hostiles_in_area["Plantman"]=4
				spawn(Set_Spawn_Delay()) SET_HOSTILE_NPCS(list2params(Hostiles_in_area),src)
				icon='Weather.dmi'
				layer=10
		Spawn_Island_NW
			New()
				Hostiles_in_area["Giant_Robot"]=4
				Hostiles_in_area["Small_Plantman"]=4
				Hostiles_in_area["Mutated_Plantman"]=4
				Hostiles_in_area["Plantman"]=4
				spawn(Set_Spawn_Delay()) SET_HOSTILE_NPCS(list2params(Hostiles_in_area),src)
				icon='Weather.dmi'
				layer=10
		Spawn_Island_SW
			New()
				Hostiles_in_area["Giant_Robot"]=4
				Hostiles_in_area["Small_Plantman"]=4
				Hostiles_in_area["Mutated_Plantman"]=4
				Hostiles_in_area["Plantman"]=4
				spawn(Set_Spawn_Delay()) SET_HOSTILE_NPCS(list2params(Hostiles_in_area),src)
				icon='Weather.dmi'
				layer=10
		Spawn_Island_SE
			New()
				Hostiles_in_area["Giant_Robot"]=4
				Hostiles_in_area["Small_Plantman"]=4
				Hostiles_in_area["Mutated_Plantman"]=4
				Hostiles_in_area["Plantman"]=4
				spawn(Set_Spawn_Delay()) SET_HOSTILE_NPCS(list2params(Hostiles_in_area),src)
				icon='Weather.dmi'
				layer=10
	Hell // 4 sub areas
		North_East
			New()
				Hostiles_in_area["Infernal_Plantman"]=20
				Hostiles_in_area["Shade"]=3
				Hostiles_in_area["Evil_Entity"]=35
				spawn(Set_Spawn_Delay()) SET_HOSTILE_NPCS(list2params(Hostiles_in_area),src)
				icon='Weather.dmi'
				layer=10
		North_West
			New()
				Hostiles_in_area["Infernal_Plantman"]=20
				Hostiles_in_area["Shade"]=3
				Hostiles_in_area["Evil_Entity"]=35
				spawn(Set_Spawn_Delay()) SET_HOSTILE_NPCS(list2params(Hostiles_in_area),src)
				icon='Weather.dmi'
				layer=10
		South_East
			New()
				Hostiles_in_area["Infernal_Plantman"]=20
				Hostiles_in_area["Shade"]=3
				Hostiles_in_area["Evil_Entity"]=35
				spawn(Set_Spawn_Delay()) SET_HOSTILE_NPCS(list2params(Hostiles_in_area),src)
				icon='Weather.dmi'
				layer=10
		South_West
			New()
				Hostiles_in_area["Infernal_Plantman"]=20
				Hostiles_in_area["Shade"]=3
				Hostiles_in_area["Evil_Entity"]=35
				spawn(Set_Spawn_Delay()) SET_HOSTILE_NPCS(list2params(Hostiles_in_area),src)
				icon='Weather.dmi'
				layer=10
	Heaven // 1 sub area
		Turtle_Island
			New()
				NPCs_in_area["Turtle"]=9
				spawn(Set_Spawn_Delay()) SET_DOCILE_NPCS(list2params(NPCs_in_area),src)
				icon='Weather.dmi'
				layer=10
	Arconia // 3 sub areas
		Northpole
			New()
				Hostiles_in_area["Ice_Dragon"]=9
				Hostiles_in_area["Ice_Flame"]=9
				spawn(Set_Spawn_Delay()) SET_HOSTILE_NPCS(list2params(Hostiles_in_area),src)
				icon='Weather.dmi'
				layer=10
		Island_SE
			New()
				Hostiles_in_area["Robot"]=9
				Hostiles_in_area["Hover_Robot"]=9
				spawn(Set_Spawn_Delay()) SET_HOSTILE_NPCS(list2params(Hostiles_in_area),src)
				icon='Weather.dmi'
				layer=10
		Turtle_Island
			New()
				NPCs_in_area["Turtle"]=9
				spawn(Set_Spawn_Delay()) SET_DOCILE_NPCS(list2params(NPCs_in_area),src)
				icon='Weather.dmi'
				layer=10

	Ice // 1 sub area
		NearSpawn
			New()
				Hostiles_in_area["Ice_Dragon"]=36
				Hostiles_in_area["Ice_Flame"]=56
				spawn(Set_Spawn_Delay()) SET_HOSTILE_NPCS(list2params(Hostiles_in_area),src)
				icon='Weather.dmi'
				icon_state="Blizzard Heavy"
				layer=10
	Space // 4 sub areas
		// Overriding the parent Entered/Exited calls, allows for immediate different proc calls
		// Specific to this area. In this case, it's only relevant for objects.
		Entered(atom/a)
			if(istype(a,/mob/player))
				Obj_Wake()
				var/mob/player/P=a
				spawn P.Walking_In_Space()
			else if(istype(a,/obj/Ships))
				Obj_Wake()

		Exited(atom/a)
			if(istype(a,/mob/player) || istype(a,/obj/Ships))
				Obj_Sleep()

		Space_North_East
			New()
				Obj_in_area["Asteroid"]=rand(8,12)
				Obj_in_area["Meteor"]=rand(8,12)
				spawn(Set_Spawn_Delay()) SET_SPACEDEBRIS(list2params(Obj_in_area),src)

		Space_North_West
			New()
				Obj_in_area["Asteroid"]=rand(8,12)
				Obj_in_area["Meteor"]=rand(8,12)
				spawn(Set_Spawn_Delay()) SET_SPACEDEBRIS(list2params(Obj_in_area),src)

		Space_South_East
			New()
				Obj_in_area["Asteroid"]=rand(8,12)
				Obj_in_area["Meteor"]=rand(8,12)
				spawn(Set_Spawn_Delay()) SET_SPACEDEBRIS(list2params(Obj_in_area),src)

		Space_South_West
			New()
				Obj_in_area["Asteroid"]=rand(8,12)
				Obj_in_area["Meteor"]=rand(8,12)
				spawn(Set_Spawn_Delay()) SET_SPACEDEBRIS(list2params(Obj_in_area),src)

