area
	mouse_opacity=0
	var/Value=33000000
	var/Value_Mana = 33000000
	var/Temperature=1
	New()
		layer=99
		icon='Weather.dmi'
		//..()
/*	var/area/master				// master area used for power calcluations
								// (original area before splitting due to sd_DAL)
	var/list/related			// the other areas of the same type as this
	New()
		var/sd_created = findtext(tag,"sd_L")
		sd_New(sd_created)
		if(sd_created)
			related += src
			return
		master = src
		related = list(src)
*/

	portal // This area can be placed on the edges of each map and will ensure the player is teleported to the other side.
			// Should work on ever Z-level and doesn't need to be adjusted.
		var/zportal
		Entered(var/atom/movable/O)
			if(istype(O,/NPC_AI/)) return
			var/nx = O.x
			var/ny = O.y
			zportal= O.z

			switch(nx)

				if(1) nx = world.maxx-1

				if(500) nx = 2

			switch(ny)

				if(1) ny = world.maxy-1


				if(500) ny = 2

			O.loc = locate(nx,ny,src.zportal)

	half_portal
		var/zportal
		Entered(var/atom/movable/O)
			if(istype(O,/NPC_AI/)) return
			var/nx = O.x
			var/ny = O.y
			zportal= O.z

			switch(nx)

				if(1)
					nx += 247

				if(249)
					nx = 2

			switch(ny)

				if(1)
					if(O.icon_state=="Flight")// south DP border Flight in order to prevent players from getting STUCK
						ny += 247

				if(500)
					ny -= 247

				if(252)
					if(O.icon_state=="Flight") // south JP border
						ny = world.maxy-1
				if(249)
					ny = 2

			O.loc = locate(nx,ny,src.zportal)

	Realm
	Inside
		//sd_outside = 0	//Fire good, fire bright, man need fire!
		//sd_outside = 1
	Namek
		//sd_outside = 1
	Vegeta
		//sd_outside = 1
	Arconia
		//sd_outside = 1
	Alien
	Checkpoint
		//sd_lighting	= 0
	Heaven
		//sd_lighting	= 0
	Hell
		//sd_lighting	= 0
	Changeling
		Temperature = 0.80
		icon_state="Blizzard Heavy"
		New()
			icon='Weather.dmi'
			icon_state="Blizzard Heavy"
			layer=10

		//sd_outside = 1
	Space
		//sd_lighting = 0	//Not yet
		Entered(var/mob/player/A)
			spawn A.Walking_In_Space()
	Android
		//sd_outside = 0	//Big hollow ships have no sun!
	Jungle
		//sd_outside = 1
	Desert
		//sd_outside = 1
	Namek_Underground
		//sd_outside = 0	//Cave
	Ice_Underground
		//sd_outside = 0
	Vegeta_Underground
		//sd_outside = 0
	Ship_Inside
		//sd_outside = 0
	Earth
	Afterlife
		Gravity = 1

	Limbo // An area players get thrown into awaiting their respawn

proc/Save_Area()
	var/savefile/F=new("Data/Areas.bdb")
	//if(global.startRuin) F["success"] << global.startRuin
	for(var/area/Checkpoint/A)
		F["Checkpoint"]<<A.icon_state
		F["Checkpoint Value"]<<A.Value
		F["Checkpoint Value Mana"]<<A.Value_Mana
		break
	for(var/area/Heaven/A)
		F["Heaven"]<<A.icon_state
		F["Heaven Value"]<<A.Value
		F["Heaven Value Mana"]<<A.Value_Mana
		break
	for(var/area/Hell/A)
		F["Hell"]<<A.icon_state
		F["Hell Value"]<<A.Value
		F["Hell Value Mana"]<<A.Value_Mana
		break
	for(var/area/Space/A)
		F["Space"]<<A.icon_state
		F["Space Value"]<<A.Value
		F["Space Value Mana"]<<A.Value_Mana
		break
	for(var/area/Earth/A)
		F["Earth"]<<A.icon_state
		F["Earth Value"]<<A.Value
		F["Earth Value Mana"]<<A.Value_Mana
		break
	for(var/area/Namek/A)
		F["Namek"]<<A.icon_state
		F["Namek Value"]<<A.Value
		F["Namek Value Mana"]<<A.Value_Mana
		break
	for(var/area/Vegeta/A)
		F["Vegeta"]<<A.icon_state
		F["Vegeta Value"]<<A.Value
		F["Vegeta Value Mana"]<<A.Value_Mana
		break
	for(var/area/Arconia/A)
		F["Arconia"]<<A.icon_state
		F["Arconia Value"]<<A.Value
		F["Arconia Value Mana"]<<A.Value_Mana
		break
	for(var/area/Changeling/A)
		F["Changeling"]<<A.icon_state
		F["Changeling Value"]<<A.Value
		F["Changeling Value Mana"]<<A.Value_Mana
		break
	for(var/area/Android/A)
		F["Android"]<<A.icon_state
		F["Android Value"]<<A.Value
		F["Android Value Mana"]<<A.Value_Mana
		break
	for(var/area/Jungle/A)
		F["Jungle"]<<A.icon_state
		F["Jungle Value"]<<A.Value
		F["Jungle Value Mana"]<<A.Value_Mana
		break
	for(var/area/Desert/A)
		F["Desert"]<<A.icon_state
		F["Desert Value"]<<A.Value
		F["Desert Value Mana"]<<A.Value_Mana
		break
	F["Earth2"]<<Earth
	F["Namek2"]<<Namek
	F["Vegeta2"]<<Vegeta
	F["Arconia2"]<<Arconia
	F["Icer"]<<Ice
	//F["timeofday"]<<timeofday

proc/Load_Area() if(fexists("Data/Areas.bdb"))
	var/savefile/F=new("Data/Areas.bdb")
	//if(length(F["success"])) global.startRuin = 1
	for(var/area/Earth/A)
		F["Earth"]>>A.icon_state
		F["Earth Value"]>>A.Value
		F["Earth Value Mana"]>>A.Value_Mana
	for(var/area/Namek/A)
		F["Namek"]>>A.icon_state
		F["Namek Value"]>>A.Value
		F["Namek Value Mana"]>>A.Value_Mana
	for(var/area/Vegeta/A)
		F["Vegeta"]>>A.icon_state
		F["Vegeta Value"]>>A.Value
		F["Vegeta Value Mana"]>>A.Value_Mana
	for(var/area/Arconia/A)
		F["Arconia"]>>A.icon_state
		F["Arconia Value"]>>A.Value
		F["Arconia Value Mana"]>>A.Value_Mana
	for(var/area/Changeling/A)
		F["Changeling"]>>A.icon_state
		F["Changeling Value"]>>A.Value
		F["Changeling Value Mana"]>>A.Value_Mana
	for(var/area/Jungle/A)
		F["Jungle"]>>A.icon_state
		F["Jungle Value"]>>A.Value
		F["Jungle Value Mana"]>>A.Value_Mana
	for(var/area/Desert/A)
		F["Desert"]>>A.icon_state
		F["Desert Value"]>>A.Value
		F["Desert Value Mana"]>>A.Value_Mana
	for(var/area/Checkpoint/A)
		F["Checkpoint"]>>A.icon_state
		F["Checkpoint Value"]>>A.Value
		F["Checkpoint Value Mana"]>>A.Value_Mana
	for(var/area/Heaven/A)
		F["Heaven"]>>A.icon_state
		F["Heaven Value"]>>A.Value
		F["Heaven Value Mana"]>>A.Value_Mana
	for(var/area/Hell/A)
		F["Hell"]>>A.icon_state
		F["Hell Value"]>>A.Value
		F["Hell Value Mana"]>>A.Value_Mana
	for(var/area/Space/A)
		F["Space"]>>A.icon_state
		F["Space Value"]>>A.Value
		F["Space Value Mana"]>>A.Value_Mana
	F["Earth2"]>>Earth
	F["Namek2"]>>Namek
	F["Vegeta2"]>>Vegeta
	F["Arconia2"]>>Arconia
	F["Icer"]>>Ice
//	F["timeofday"]>>timeofday

/*
var/global/timeofday = 1	//0-7, 7=bright 0=pitch black
var/global/timeModifier = 1	//1 for forward, -1 for.. backwards
proc/DayNight_Loop()
	while(!WorldLoaded)	sleep(10)	//Wait until everything is loaded
	//Long = full day or night, short is dusk/dawn
	var/long = 12000	//20 minutes
	var/short = 600	//1 minute

	world.log << "Beginning daynight loop at [timeofday] with modifier [timeModifier]"
	while(1)
		sd_OutsideLight(timeofday)
		if(timeofday == (7||0))	//Derp de derp
			sleep(long)
			if(timeModifier == 1)	//because modifier = modifier*-1 just wasn't good enough
				timeModifier = -1	//for byond!
			else
				timeModifier = 1
			world.log << "Modifier is now [timeModifier]"
		else
			sleep(short)
		timeofday += timeModifier
		world.log << "Sun is currently at [timeofday]"
*/



proc/Weather() while(1)
	for(var/area/A) if(A.Temperature==1)                                   //Map currently updates weather properly, but only does it for two areas randomly.  Weather is also disjoint -  IE: One weather in one /area does not match the weather in another.
		if(istype(A,/area/Inside) || istype(A,/area/Ship_Inside)) continue // Skip the goddamn inside area, how about that?
		if(A.z==1)
		//	if(istype(A,/area/Inside) || istype(A,/area/Ship_Inside))
		//		break   Commented out until confirmed that all areas in a map are updating.  Ensures no more fuckery happens with the code structure.
			if(prob(1)) A.icon_state=""
			else
				A.icon_state=pick("Rain","Namek Rain","Snow","Dark","Fog","Storm","Night Snow")
			//	if(istype(A,/area/NPC_AI/Earth/North)) This commented out code was used as an experiment to see if I can easily assign unique weather to a region in the event that a maps weather changes.
			//	A.icon_state=pick("Snow","Fog")   		It's probably not that efficient as it stands, compared to what it could be.  But it was mostly for a proof of concept to see if it would work.  Obviously I can't confirm this yet.
		if(istype(A,/area||istype(A,/area/NPC_AI/Namek)))
			if(istype(A,/area/Inside) || istype(A,/area/Ship_Inside))
				break
			if(prob(1)|!Namek) A.icon_state=""
			else
				A.icon_state=pick("Namek Rain","Fog","Storm")
		if(istype(A,/area||istype(A,/area/NPC_AI/Vegeta)))
			if(istype(A,/area/Inside) || istype(A,/area/Ship_Inside))
				break
			if(prob(70)|!Vegeta) A.icon_state=""
			else A.icon_state=pick("Rain","Namek Rain","Storm","Dark","Smog")
		if(istype(A,/area||istype(A,/area/NPC_AI/Arconia)))
			if(istype(A,/area/Inside) || istype(A,/area/Ship_Inside))
				break
			if(prob(80)|!Arconia) A.icon_state=""
			else A.icon_state=pick("Rain","Namek Rain","Storm","Dark","Snow","Night Snow")
		if(istype(A,/area/Checkpoint))
			if(prob(80)) A.icon_state=""
			else A.icon_state=pick("Snow","Dark","Storm","Night Snow")
		if(istype(A,/area/Heaven))
			if(prob(80)) A.icon_state=""
			else A.icon_state=pick("Rain","Namek Rain","Snow","Dark","Storm","Night Snow")
		if(istype(A,/area/Hell))
			if(prob(40)) A.icon_state=""
			else A.icon_state=pick("Blood Rain","Dark","Storm","Rising Rocks","Smog")
		if(istype(A,/area/Changeling))
			if(prob(30)|!Ice) A.icon_state="Blizzard"
			else A.icon_state=pick("Snow","Night Snow","Blizzard")
		if(istype(A,/area/Jungle))
			if(prob(30)) A.icon_state="Fog"
			else A.icon_state=pick("Dark","Fog","Storm")
		if(istype(A,/area/Desert))
			if(prob(30)) A.icon_state="Smog"
			else if(prob(40)) A.icon_state="Dark"
			else A.icon_state=pick("Smog")
	for(var/area/A) if(A.Temperature>1)
		if(istype(A,/area/Inside) || istype(A,/area/Ship_Inside)) continue // Skip the goddamn inside area, how about that?
		if(istype(A,/area/Earth))
			if(prob(80)|!Earth) A.icon_state="Blizzard Heavy"
			else A.icon_state=pick("Snow","Night Snow")
		if(istype(A,/area/Namek))
			if(prob(90)|!Namek) A.icon_state="Blizzard Heavy"
			else A.icon_state=pick("Snow","Night Snow")
		if(istype(A,/area/Vegeta))
			if(prob(70)|!Vegeta) A.icon_state="Blizzard Heavy"
			else A.icon_state=pick("Snow","Night Snow")
		if(istype(A,/area/Arconia))
			if(prob(80)|!Arconia) A.icon_state="Blizzard Heavy"
			else A.icon_state=pick("Snow","Night Snow")
		if(istype(A,/area/Checkpoint))
			if(prob(80)) A.icon_state="Blizzard Heavy"
			else A.icon_state=pick("Snow","Night Snow")
		if(istype(A,/area/Heaven))
			if(prob(80)) A.icon_state="Blizzard Heavy"
			else A.icon_state=pick("Snow","Night Snow")
		if(istype(A,/area/Hell))
			if(prob(40)) A.icon_state="Blizzard Heavy"
			else A.icon_state=pick("Snow","Night Snow")
		if(istype(A,/area/Changeling))
			if(prob(30)|!Ice) A.icon_state="Blizzard Severe"
			else A.icon_state=pick("Night Snow","Blizzard Heavy")
		if(istype(A,/area/Jungle))
			if(prob(30)) A.icon_state="Blizzard Heavy"
			else A.icon_state=pick("Snow","Night Snow")
		if(istype(A,/area/Desert))
			if(prob(30)) A.icon_state="Blizzard Heavy"
			else if(prob(40)) A.icon_state="Night Snow"
			else A.icon_state=pick("Snow")
	sleep(36000)


/*proc/Weather() while(1)
	for(var/area/A) if(A.Temperature==1)                                   //Map currently updates weather properly, but only does it for two areas randomly.  Weather is also disjoint -  IE: One weather in one /area does not match the weather in another.
		if(istype(A,/area/Inside) || istype(A,/area/Ship_Inside)) continue // Skip the goddamn inside area, how about that?
		if(ispath(A,/area)||ispath(A,/area/NPC_AI/Earth))
			if(istype(A,/area/Inside) || istype(A,/area/Ship_Inside))
				break   //Commented out until confirmed that all areas in a map are updating.  Ensures no more fuckery happens with the code structure.
			if(prob(1)) A.icon_state=""
			else
				A.icon_state=pick("Rain","Namek Rain","Snow","Dark","Fog","Storm","Night Snow")
			//	if(istype(A,/area/NPC_AI/Earth/North)) This commented out code was used as an experiment to see if I can easily assign unique weather to a region in the event that a maps weather changes.
			//	A.icon_state=pick("Snow","Fog")   		It's probably not that efficient as it stands, compared to what it could be.  But it was mostly for a proof of concept to see if it would work.  Obviously I can't confirm this yet.
		if(istype(A,/area||istype(A,/area/NPC_AI/Namek)))
			if(istype(A,/area/Inside) || istype(A,/area/Ship_Inside))
				break
			if(prob(1)|!Namek) A.icon_state=""
			else
				A.icon_state=pick("Namek Rain","Fog","Storm")
		if(istype(A,/area||istype(A,/area/NPC_AI/Vegeta)))
			if(istype(A,/area/Inside) || istype(A,/area/Ship_Inside))
				break
			if(prob(70)|!Vegeta) A.icon_state=""
			else A.icon_state=pick("Rain","Namek Rain","Storm","Dark","Smog")
		if(istype(A,/area||istype(A,/area/NPC_AI/Arconia)))
			if(istype(A,/area/Inside) || istype(A,/area/Ship_Inside))
				break
			if(prob(80)|!Arconia) A.icon_state=""
			else A.icon_state=pick("Rain","Namek Rain","Storm","Dark","Snow","Night Snow")
		if(istype(A,/area/Checkpoint))
			if(prob(80)) A.icon_state=""
			else A.icon_state=pick("Snow","Dark","Storm","Night Snow")
		if(istype(A,/area/Heaven))
			if(prob(80)) A.icon_state=""
			else A.icon_state=pick("Rain","Namek Rain","Snow","Dark","Storm","Night Snow")
		if(istype(A,/area/Hell))
			if(prob(40)) A.icon_state=""
			else A.icon_state=pick("Blood Rain","Dark","Storm","Rising Rocks","Smog")
		if(istype(A,/area/Changeling))
			if(prob(30)|!Ice) A.icon_state="Blizzard"
			else A.icon_state=pick("Snow","Night Snow","Blizzard")
		if(istype(A,/area/Jungle))
			if(prob(30)) A.icon_state="Fog"
			else A.icon_state=pick("Dark","Fog","Storm")
		if(istype(A,/area/Desert))
			if(prob(30)) A.icon_state="Smog"
			else if(prob(40)) A.icon_state="Dark"
			else A.icon_state=pick("Smog")
	for(var/area/A) if(A.Temperature>1)
		if(istype(A,/area/Inside) || istype(A,/area/Ship_Inside)) continue // Skip the goddamn inside area, how about that?
		if(istype(A,/area/Earth))
			if(prob(80)|!Earth) A.icon_state="Blizzard Heavy"
			else A.icon_state=pick("Snow","Night Snow")
		if(istype(A,/area/Namek))
			if(prob(90)|!Namek) A.icon_state="Blizzard Heavy"
			else A.icon_state=pick("Snow","Night Snow")
		if(istype(A,/area/Vegeta))
			if(prob(70)|!Vegeta) A.icon_state="Blizzard Heavy"
			else A.icon_state=pick("Snow","Night Snow")
		if(istype(A,/area/Arconia))
			if(prob(80)|!Arconia) A.icon_state="Blizzard Heavy"
			else A.icon_state=pick("Snow","Night Snow")
		if(istype(A,/area/Checkpoint))
			if(prob(80)) A.icon_state="Blizzard Heavy"
			else A.icon_state=pick("Snow","Night Snow")
		if(istype(A,/area/Heaven))
			if(prob(80)) A.icon_state="Blizzard Heavy"
			else A.icon_state=pick("Snow","Night Snow")
		if(istype(A,/area/Hell))
			if(prob(40)) A.icon_state="Blizzard Heavy"
			else A.icon_state=pick("Snow","Night Snow")
		if(istype(A,/area/Changeling))
			if(prob(30)|!Ice) A.icon_state="Blizzard Severe"
			else A.icon_state=pick("Night Snow","Blizzard Heavy")
		if(istype(A,/area/Jungle))
			if(prob(30)) A.icon_state="Blizzard Heavy"
			else A.icon_state=pick("Snow","Night Snow")
		if(istype(A,/area/Desert))
			if(prob(30)) A.icon_state="Blizzard Heavy"
			else if(prob(40)) A.icon_state="Night Snow"
			else A.icon_state=pick("Snow")
	sleep(36000)*/

/*	var/list/EarthList=new
	EarthList=new/list()
	EarthList.Add(/area/NPC_AI/Earth)
	EarthList.Add(/area)
	for(var/area/A) if(A.Temperature==1) //for(var/list/EarthList/E)
		if(istype(A,/area)||istype(A,/area/NPC_AI/Earth))
			if(istype(A,/area/Inside) || istype(A,/area/Ship_Inside))
				break
			if(prob(1)) A.icon_state=""
			else for(var/area/B in EarthList)
				B.icon_state=pick("Rain","Namek Rain","Snow","Dark","Fog","Storm","Night Snow")
*/
			//	E.icon_state==Weather_Choice
			//	if(istype(A,/area/NPC_AI/Earth/North))
			//	A.icon_state=pick("Snow","Fog")   Scrap ideas and potential approaches I used.  Obviously didn't work at the time.

/*proc/setWeatherOverlay(var/area/A, var/weather)
	A.overlays += image(icon="Weather.dmi", icon_state="[weather]")
	if(!weather)	return
	A.overlays += image(icon="Weather.dmi", icon_state="[weather]")

// Unused weather icons: "Night Snow", "Dark"
proc/Weather() while(1)
	for(var/area/A) if(A.Temperature == 1)
		if(istype(A,/area/Earth))
			if(prob(80) | !Earth)
				setWeatherOverlay(A,"")
			else
				var/pick = pick("Rain", "Namek Rain", "Snow", "Fog", "Storm")
				setWeatherOverlay(A,pick)
		if(istype(A,/area/Namek))
			if(prob(90) | !Namek)
				setWeatherOverlay(A,"")
			else
				var/pick = pick("Namek Rain","Fog","Storm")
				setWeatherOverlay(A,pick)
		if(istype(A,/area/Vegeta))
			if(prob(70) | !Vegeta)
				setWeatherOverlay(A,"")
			else
				var/pick = pick("Rain","Namek Rain","Storm","Smog")
				setWeatherOverlay(A,pick)
		if(istype(A,/area/Arconia))
			if(prob(80) | !Arconia)
				setWeatherOverlay(A,"")
			else
				var/pick = pick("Rain","Namek Rain","Storm","Snow")
				setWeatherOverlay(A,pick)
		if(istype(A,/area/Checkpoint))
			if(prob(80))
				setWeatherOverlay(A,"")
			else
				var/pick = pick("Snow","Storm","Night Snow")
				setWeatherOverlay(A,pick)
		if(istype(A,/area/Heaven))
			if(prob(80))
				setWeatherOverlay(A,"")
			else
				var/pick = pick("Rain","Namek Rain","Snow","Storm")
				setWeatherOverlay(A,pick)
		if(istype(A,/area/Hell))
			if(prob(40))
				setWeatherOverlay(A,"")
			else
				var/pick = pick("Blood Rain","Storm","Rising Rocks","Smog")
				setWeatherOverlay(A,pick)
		if(istype(A,/area/Changeling))
			if(prob(30)|!Ice)
				setWeatherOverlay(A,"Blizzard")
			else
				var/pick = pick("Snow","Blizzard")
				setWeatherOverlay(A,pick)
		if(istype(A,/area/Jungle))
			if(prob(30))
				setWeatherOverlay(A,"Fog")
			else
				var/pick = pick("Fog","Storm")
				setWeatherOverlay(A,pick)
		if(istype(A,/area/Desert))
			if(prob(30))
				setWeatherOverlay(A,"Smog")
			else
				setWeatherOverlay(A,"")
	for(var/area/A) if(A.Temperature>1)
		if(istype(A,/area/Earth))
			if(prob(80)|!Earth)
				setWeatherOverlay(A,"Blizzard Heavy")
			else
				setWeatherOverlay(A,"Snow")
		if(istype(A,/area/Namek))
			if(prob(90)|!Namek)
				setWeatherOverlay(A,"Blizzard Heavy")
			else
				setWeatherOverlay(A,"Snow")
		if(istype(A,/area/Vegeta))
			if(prob(70)|!Vegeta)
				setWeatherOverlay(A,"Blizzard Heavy")
			else
				setWeatherOverlay(A,"Snow")
		if(istype(A,/area/Arconia))
			if(prob(80)|!Arconia)
				setWeatherOverlay(A,"Blizzard Heavy")
			else
				setWeatherOverlay(A,"Snow")
		if(istype(A,/area/Checkpoint))
			if(prob(80))
				setWeatherOverlay(A,"Blizzard Heavy")
			else
				setWeatherOverlay(A,"Snow")
		if(istype(A,/area/Heaven))
			if(prob(80))
				setWeatherOverlay(A,"Blizzard Heavy")
			else
				setWeatherOverlay(A,"Snow")
		if(istype(A,/area/Hell))
			if(prob(40))
				setWeatherOverlay(A,"Blizzard Heavy")
			else
				setWeatherOverlay(A,"Snow")
		if(istype(A,/area/Changeling))
			if(prob(30)|!Ice)
				setWeatherOverlay(A,"Blizzard Severe")
			else
				setWeatherOverlay(A,"Blizzard Heavy")
		if(istype(A,/area/Jungle))
			if(prob(30))
				setWeatherOverlay(A,"Blizzard Heavy")
			else
				setWeatherOverlay(A,"Snow")
		if(istype(A,/area/Desert))
			if(prob(30))
				setWeatherOverlay(A,"Blizzard Heavy")
			else
				setWeatherOverlay(A,"Snow")
	sleep(36000)	36000*/