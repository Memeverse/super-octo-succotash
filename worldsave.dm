proc/SaveWorld()
	// If we dont sleep, BYOND isn't able to switch context and it causes the entire game to freeze.
	// So keep sleep(1) in there.
	world << "<span class=announce>Saving the world in 30 seconds.</span>"
	sleep(300)
	if(Server_Activated == 0)
		world << "<font color = yellow><font size = 6>Unable to verify server as legal, shutting down in 30 seconds..."
		sleep(300)
		del(world)
	find_savableObjects()

	SaveHubText()
	world << "<span class=announce>Hubtext saved.</span>"
	sleep(-1)
	SaveYear()
	world << "<span class=announce>Year saved.</span>"
	sleep(-1)
	Save_Gain()
	world << "<span class=announce>Gain saved.</span>"
	sleep(-1)
	Save_Area()
	world << "<span class=announce>Area saved.</span>"
	sleep(-1)
	Save_Int()
	world << "<span class=announce>Int saved.</span>"
	sleep(-1)
	if(global.CanSave) Save_Turfs()
	world << "<span class=announce>Turfs saved.</span>"
	sleep(-1)
	SaveRanks()
	SaveRankings()
	world << "<span class=announce>Ranks saved.</span>"
	sleep(-1)
	SaveItems()
	world << "<span class=announce>Items saved.</span>"
	sleep(-1)
	Save_Reports() // Save bug reports
	world << "<span class=announce>Reports saved.</span>"
	sleep(-1)
	world.save_admins()
	world << "<span class=announce>Admins saved.</span>"
	sleep(-1)
	SaveScalingPower()
	//world << "<span class=announce>Dynamic power rankings saved.  Power ranking is [ScalingPower].</span>"
	sleep(-1)
	Clear_Stray_Clothes()
	world << "<span class=announce>Stray clothes removed.</span>"
	sleep(-1)

	for(var/mob/player/M in Players)
		if(M.z!=0&&M.client)
			M.Save()
			sleep(-1)

	world << "<span class=announce>World saved.</span>"


proc/SaveWorldRepeat()	while(1)
	sleep(180000) // every thirty minutes
	for(var/mob/player/A in Players)
		A.StatRank()
		A.XPRank()
		sleep(1)
	spawn SaveWorld()
