/*
 * Every admin command that has no actual administration function other than to test things and/or potentially break the server
 * should be categorized as a debug function and as such declared HERE.
*/

mob/Debug/verb

	TestTrainOpp()
		set category = "Debug"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		usr.TrainOpp(usr,30)
		usr.TrainOpp(usr)

	TechList()
		set category = "Debug"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		for(var/obj/_tech in global.globTechlist)
			src << "[_tech.name]"

	ResetObjIcons()
		set category = "Debug"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		for(var/obj/Drill/_drill in world)
			var/image/A=image(icon='Space.dmi',icon_state="d1",pixel_y=16,pixel_x=-16)
			var/image/Z=image(icon='Space.dmi',icon_state="d2",pixel_y=16,pixel_x=16)
			var/image/C=image(icon='Space.dmi',icon_state="d3",pixel_y=-16,pixel_x=-16)
			var/image/D=image(icon='Space.dmi',icon_state="d4",pixel_y=-16,pixel_x=16)
			_drill.overlays.Remove(A,Z,C,D)
			_drill.overlays.Add(A,Z,C,D)

		for(var/obj/Ships/Ship/_ship in world)
			var/image/A=image(icon='Huge Ship Red Dark.dmi',icon_state="1 1",pixel_x=-37,pixel_y=-48,layer=MOB_LAYER-1)
			_ship.overlays.Add(A)

		for(var/obj/items/Regenerator/R in world)

			var/image/A=image(icon='Heal Tank.dmi',icon_state="top",pixel_y=32)
			var/image/B=image(icon='Heal Tank.dmi',icon_state="bottom",pixel_y=-32)
			R.overlays.Remove(A,B)
			R.overlays.Add(A,B)

/*
	Spam_Control()
		set category = "Debug"
		gSpamFilter.sf_AddInterface(usr.client)
		//winshow(src,"options_chat", 1)

	Close_Spam_Filter_Control()
		set category = "Debug"
		gSpamFilter.sf_RemoveInterface(usr.client)
		//winshow(src,"options_chat", 0)
*/

/*
	Debug_Mapsave() is a verb to see exactly what the dmm_suite library is writing
	without saving a file.
	DMM_IGNORE_MOBS == DMM_IGNORE_PLAYERS & DMM_IGNORE_NPCS
*/
/*

	Debug_Mapsave()
		set category = "Debug"
		set name = "Mapsave Dryrun"
		var/dmm_suite/D = new()
		var/turf/south_west_deep = locate(1,1,1)
		var/turf/north_east_shallow = locate(world.maxx,world.maxy,world.maxz)
		var/map_text = D.write_map(south_west_deep, north_east_shallow, flags = DMM_IGNORE_MOBS)
		usr << browse("<pre>[map_text]</pre>")
*/


	Wake_NPCs()
		set category = "Debug"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		src << "Waking up the AI everywhere."
		for(var/area/NPC_AI/_area in world)
			_area.Wake_Area()
		src << "done"

	BuildLists()
		set category = "Debug"
		src << "build_categ is [build_categ.len] long"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		for(var/a in build_categ)
			src << "[a] - [build_categ[a]]"

		src << "buildter_sub is [buildter_sub.len] long"
		for(var/a in buildter_sub)
			src << "[a] - [buildter_sub[a]]"

		src << "buildprop_sub is [buildprop_sub.len] long"
		for(var/a in buildprop_sub)
			src << "[a] - [buildprop_sub[a]]"

		switch(alert("Empty these lists?",,"Yes","No"))
			if("Yes")
				buildprop_sub = null
				buildter_sub = null
				build_categ = null


	Suicide()
		set category = "Debug"
		usr.Death("suicide")
		// usr is the MOB
		// src is the CLIENT

	Remove_CloningTanks()
		set category = "Debug"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		for(var/obj/items/Cloning_Tank/tank as anything in world)
			if(tank.z==0)
				tank.Password=null
				del tank

	Check_Cloning_Machines()
		set category = "Debug"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		src << "[glob_ClonTanks] list is [global.glob_ClonTanks.len] long."
		src << "[glob_ClonTanks] contains: [list2params(global.glob_ClonTanks)]"
		for(var/obj/items/Cloning_Tank/tank as anything in glob_ClonTanks)
			src << "Cloning tank [tank.type] located at: [tank.x],[tank.y],[tank.z] has password [tank.Password]"

	Check_AllowraresList()
		set category = "Debug"
		src << "[AllowRares] list is [global.AllowRares.len] long."
		src << "[AllowRares] contains: [list2params(global.AllowRares)]"
		for(var/atom/I as anything in AllowRares)
			src << "[I] is a [I.type]"

	Clear_TurfsList()
		set category = "Debug"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		src << "Turfs list is [global.Turfs.len] long."
		switch(alert(src,"Are you sure?","","Yes","No"))
			if("No") return
			else
				global.Turfs=null
				src << "Turfs List emptied. It now contains: [list2params(global.Turfs)]"
				src << "If you just used this on a live server, congratulations you destroyed mapsaving."

	Show_MutedList()
		set category = "Debug"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		src << "Muted list contains: [list2params(global.MutedList)]"

	Make_Empty_Mobs()
		set category = "Debug"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		if(!usr.client.holder||usr.client.holder.level<5) return
		var/amount = input("How many clientless player mobs do you want to create?") as num
		if(!amount) return

		log_errors("\n\n### CREATING [amount] TEST PLAYER MOBS AT: [time2text(world.realtime,"Day DD hh:mm")]  ###\n\n")
		src << "Creating [amount] player mobs"

		for(var/i, i<amount, i++)
			var/mob/player/M = new/mob/player
			M.loc = locate(usr.x+i,usr.y,usr.z)
			M.icon = usr.icon
			M.TestChar = 1
			spawn M.Update_Player()
			M.name = "TESTCHAR #[i]"
			Players += M.name


		src << "DONE! Created [amount] player mobs"
		log_errors("\n\n### DONE CREATING [amount] TEST PLAYER MOBS AT: [time2text(world.realtime,"Day DD hh:mm")]  ###\n\n")

	WrongObjects()
		set category = "Debug"
		var/amount
		if(!usr.client.holder||usr.client.holder.level<5) return
		log_errors("\n\n### OBJECT COUNT AT: [time2text(world.realtime,"Day DD hh:mm")]  ###\n\n")
		for(var/obj/A)
			if(isnull(A.loc)&&A.z==0&&A.type!=/obj/admins)
				if(A.name in global.DEBUGLIST) continue
				else log_errors("DEBUG NEW: #[amount] || [A] ([A.type] has no location. ([A.x],[A.y],[A.z] :: [A.loc])")
				amount++ // The coordinates (x,y,z) can be 0 but if the loc is ALSO 0 then it's not in anybody's inventory.
				//log_errors("DEBUG: #[amount] || [A] ([A.type] has no location. ([A.x],[A.y],[A.z] :: [A.loc])")
				global.DEBUGLIST+=A.name
		if(amount)
			src<<"<font color=red>WARNING:</font> [amount] objects have NO LOCATION!"
		else
			src<<"<font color=green>No wrongly placed objects found.</font>"

	cleanup()
		set category = "Debug"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		src<<"Cleaning..."
		var/count = 0
		var/list/removed = new

		Clean_Mobs()
		Clean_Objs()

		for(var/obj/O in world)
			if (O.loc == null && O.z==0 && O.type != /obj/admins && \
				!O in (buildRoofs || \
	buildWalls || \
	buildDoors || \

// Terrain category
	buildGrass || \
	buildGround || \
	buildSky || \
	buildStairs || \
	buildTiles || \
	buildWater || \
	terrainMisc || \

// Props category
	buildChairs || \
	buildTables || \
	buildHeatsources || \
	buildSigns || \

	buildRocks || \
	buildEdges || \
	buildSurf || \

	buildBushes || \
	buildPlants || \
	buildTrees || \

	propMisc) && \
				!O in Clothing)
				count ++
				removed += O
				del(O)

		src << "Done cleaning up."
		src << "[count] objects removed."
		for(var/x as anything in removed)
			src << "[x]"

/*
	SPAMLOG()
		set category = "Debug"
		if(!usr.client.holder||usr.client.holder.level<5) return
		switch(alert(src,"Are you sure? The verb reads SPAM for a reason! Shit will LAG!","","Yes","No"))

			if("No") return
			else
				var/EventScheduler/scheduler = new()
				scheduler.start()
				for (var/A in 1 to 10000)
					scheduler.schedule(new/Event/writeToLog("THIS IS FUCKLOADS OF SPAM I BE TESTIN FOR LAGGZZZ", lastKnownKey, real_name), rand(10))
*/

	ClearTech()
		set category="Debug"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		src << "Clearing tech and refilling it for all players. Please hold."
		for(var/mob/player/M in world)
			M.TechTab=0
			for(var/obj/Technology/B in M) { del (B) }
			for(var/obj/Technology/D in M.contents) { del (D) }
			//for(var/obj/Technology/C in M.techlist) { del (C) }
		src << "Done."


	Count_Doubles()
		set category = "Debug"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		var/count=0
		//var/noclient=0
		//var/nostatus=0

		for (var/mob/player/M in world)
			if(!M.client)
				count++
				src << "[M] at [M.x],[M.y],[M.z] is a player mob but does not have a client."
/*
			if(!M.status_event&&!M.client)
				count++
			if(M.status_event&&!M.client)
				noclient++
			if(!M.status_event&&M.client)
				nostatus++

		if(count) src << "There are [count] player mobs with no client and no status_event."
		if(noclient) src << "There are [noclient] player mobs with no client but DO HAVE a status_event."
		if(nostatus) src << "There are [nostatus] player mobs with a client BUT NOT a status_event."
		if(!count&&!noclient&&!nostatus) src << "Nothing out of order found."
*/
		if(count) src << "There are [count] player mobs with no client and no status_event."
		else if(!count) src << "Nothing out of order found."

	Write_null_objlist()
		set category = "Debug"
		set background = 1
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		src << "Writing every object with z = 0 in the world to file"
		var/date = "[time2text(world.realtime, "YYYY-MM-Month-DD-Day")]"
		var/time = "[time2text(world.timeofday, "hh")]"
		var/objlog = file("Data/Logs/[date]_[time]_null_objectlist_log.log")
		var/count = 0

		for(var/obj/O in world)
			if(O.z != 0) continue
			objlog << "[O.type], [O.x], [O.y], [O.z], [O.loc]"
			sleep(1)
			count ++

		objlog << "[count] objects"
		src << "done ([count])"

	Write_all_objlist()
		set category = "Debug"
		set background = 1
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		src << "Writing every object in the world to file"
		var/date = "[time2text(world.realtime, "YYYY-MM-Month-DD-Day")]"
		var/time = "[time2text(world.timeofday, "hh")]"
		var/objlog = file("Data/Logs/[date]_[time]_full_objectlist_log.log")
		var/count = 0

		for(var/obj/O in world)
			objlog << "[O.type], [O.x], [O.y], [O.z], [O.loc]"
			sleep(1)
			count ++

		objlog << "[count] objects"
		src << "done ([count])"


/*
mob/Debug/verb/Disable_Logging()
	switch(alert("WARNING! This will disable the SaveToLog function, effectively turning logging off for the ENTIRE server. Continue?",,"Yes","No"))
		if("Yes")
			ServerLogging=0
			src<< "Logging has been turned off."
		else
			return
*/

/*
mob/Debug/verb/DeleteNullLocObjects()
	set category = "Debug"
	switch(alert("WARNING! USING THIS WILL DELETE ALL OBJECTS THAT ARENT IN AN INVENTORY AND HAVE NO REAL LOCATION! CONTINUE?!",,"Yes","No"))
		if("No")
			return
		if("Yes")
			var/amount
			for(var/obj/A in world)
				if(isnull(A.loc)&&A.z==0&&!istype(A,/obj/admins))
					log_errors("REMOVED: [A] found at ([A.x],[A.y],[A.z] :: [A.loc])")
					del(A)
					amount++
			src << "Done deleting all objects with no location. ([amount])"
		else
			return
*/
/*
mob/Debug/verb/LocateNullLocObject(obj/A in world)
	set category = "Debug"
	switch(alert("WARNING! USING THIS WILL GIVE A LONG LIST OF LOCATIONS FOR THAT ITEM! CONTINUE?!",,"Yes","No"))
		if("No")
			return
		if("Yes")
			var/amount
			for(A in world)
				if(isnull(A.loc)&&A.z==0)
					src << "[A] found at ([A.x],[A.y],[A.z])"
					amount++
			src << "Total: [amount]"
		else
			return
*/
