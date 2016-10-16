/client/proc/Make_Legendary_Saiyan(mob/M in Players)
	set name = "Make LSSJ"
	set category = "Admin"

	if(!usr.client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return

	if(M.Race != "Saiyan")
		alert("[M] is not a saiyan and therefore cannot be made into a Legendary Super Saiyan")
		return
	if(M.Class == "Legendary")
		alert("[M] is already a LSSJ!")
		return
	switch(input(usr, "This will turn [M] into a Legendary Super Saiyan. This will allow them to gain LSSj form \ at 100,000 BP. They will not get any other forms. Do you really want to do this?") in list("Yes", "No", "Oh god what have I done"))
		if("Oh god what have I done")
			logAndAlertAdmins("[key_name(usr)] decided not to make [key_name(M)] into a LSSj!")
			return
		if("Yes")
			M.LSSJ()
			log_admin("[key_name(usr)] made [key_name(M)] into a Legendary Super Saiyan")
			alertAdmins("[key_name(usr)] made [key_name(M)] into a <b>Legendary Super Saiyan</b>!")
		if("No")
			alert("Be more careful then!")
			return
/client/proc/Unactivate_Server()
	set name = "(Un)Activate Server"
	set category = "Admin"

	if(!usr.client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	switch(input(usr, "Are you sure you want to prevent this server from being able to host?") in list("No", "Yes"))
		if("Yes")
			world << "<font color = yellow><font size = 6>[src.key] un-activated the server, disallowing connections from the hosts location."
			Server_Activated = 0
			SaveActivation()
/client/proc/Show_Rewards_Tab()
	set name = "Show Rewards Tab"
	set category = "Admin"

	if(!usr.client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	if(usr.show_rewards)
		usr.show_rewards = 0
		return
	else
		usr.show_rewards = 1
		return
/client/proc/Reset_Rare_Rolls()
	set name = "Reset Rare Rolls"
	set category = "Admin"

	if(!usr.client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	switch(input(usr, "Are you sure you want reset all the rare rolls for everyone?") in list("No", "Yes"))
		if("Yes")
			logAndAlertAdmins("[key_name(usr)] reset all the rare rolls so everyone can now reroll their chance to become a rare.")
			rare_keys = null
			rare_keys = list()
			SaveYear()
/client/proc/Show_Ranks_Tab()
	set name = "Show Ranks Tab"
	set category = "Admin"

	if(!usr.client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	if(usr.show_ranks)
		usr.show_ranks = 0
		return
	else
		usr.show_ranks = 1
		return
/client/proc/Show_Notes()
	set name = "Show Notes"
	set category = "Admin"

	if(!usr.client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	alertAdmins("[key_name(usr)] displayed notes to all admins.</b>")
	for(var/mob/M in Players)
		if(M.client) if(M.client.holder)
			var/html_doc="<head><title>Admin Notes</title></head><body bgcolor=#000000 text=#FFFF00><center>[Notes]"
			M<<browse(html_doc,"window=Admin Notes")
/client/proc/Fix(mob/M in Players)
	set name = "Fix"
	set category = "Admin"

	if(!usr.client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	usr << "You apply the fix to [M]. This is not guranteed to work."
	M.Update_Player()
	log_admin("[key_name(usr)] tried to fix [key_name(M)].")
	alertAdmins("[key_name(usr)] tried to fix [key_name(M)].</b>!")

/client/proc/Set_Spawns()
	set category="Admin"
	set name = "Set Spawns"
	if(!usr.client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	var/list/Choices=new
	Choices.Add("Human","Saiyan","Oni","Demon","Kaio","Demigod","Changeling","Namekian","Tsufurujin","Makyojin","Cancel")
	switch(input("Choose a spawn to set") in Choices)
		if("Cancel")
			return
		if("Makyojin")
			switch(input(usr, "Do you want to set the Makyojin spawn, or reset it?") in list("Set", "Reset","Cancel"))
				if("Cancel")
					return
				if("Reset")
					Makyojin_SpawnX = 102
					Makyojin_SpawnY = 276
					Makyojin_SpawnZ = 1
					Save_Spawns()
					logAndAlertAdmins("[key_name(usr)] reset the Makyojin spawn to be [Makyojin_SpawnX],[Makyojin_SpawnY],[Makyojin_SpawnZ].")
				if("Set")
					var/X = input(usr,"Enter the X location for the Makyojin spawn.") as num
					var/Y = input(usr,"Enter the Y location for the Makyojin spawn.") as num
					var/Z = input(usr,"Enter the Z location for the Makyojin spawn.") as num
					if(X >= 501)
						return
					if(Y >= 501)
						return
					if(Z >= 16)
						return
					if(X <= 0)
						return
					if(Y <= 0)
						return
					if(Z <= 0)
						return
					Makyojin_SpawnX = X
					Makyojin_SpawnY = Y
					Makyojin_SpawnZ = Z
					Save_Spawns()
					logAndAlertAdmins("[key_name(usr)] set the Makyojin spawn to be [X],[Y],[Z].")
		if("Tsufurujin")
			switch(input(usr, "Do you want to set the Tsufurujin spawn, or reset it?") in list("Set", "Reset","Cancel"))
				if("Cancel")
					return
				if("Reset")
					Tsufurujin_SpawnX = 82
					Tsufurujin_SpawnY = 303
					Tsufurujin_SpawnZ = 4
					logAndAlertAdmins("[key_name(usr)] reset the Tsufurujin spawn to be [Tsufurujin_SpawnX],[Tsufurujin_SpawnY],[Tsufurujin_SpawnZ].")
					Save_Spawns()
				if("Set")
					var/X = input(usr,"Enter the X location for the Tsufurujin spawn.") as num
					var/Y = input(usr,"Enter the Y location for the Tsufurujin spawn.") as num
					var/Z = input(usr,"Enter the Z location for the Tsufurujin spawn.") as num
					if(X >= 501)
						return
					if(Y >= 501)
						return
					if(Z >= 16)
						return
					if(X <= 0)
						return
					if(Y <= 0)
						return
					if(Z <= 0)
						return
					Tsufurujin_SpawnX = X
					Tsufurujin_SpawnY = Y
					Tsufurujin_SpawnZ = Z
					logAndAlertAdmins("[key_name(usr)] set the Tsufurujin spawn to be [X],[Y],[Z].")
					Save_Spawns()
		if("Kaio")
			switch(input(usr, "Do you want to set the Kaio spawn, or reset it?") in list("Set", "Reset","Cancel"))
				if("Cancel")
					return
				if("Reset")
					Kaio_SpawnX = 212
					Kaio_SpawnY = 187
					Kaio_SpawnZ = 7
					logAndAlertAdmins("[key_name(usr)] reset the Kaio spawn to be [Kaio_SpawnX],[Kaio_SpawnY],[Kaio_SpawnZ].")
					Save_Spawns()
				if("Set")
					var/X = input(usr,"Enter the X location for the Kaio spawn.") as num
					var/Y = input(usr,"Enter the Y location for the Kaio spawn.") as num
					var/Z = input(usr,"Enter the Z location for the Kaio spawn.") as num
					if(X >= 501)
						return
					if(Y >= 501)
						return
					if(Z >= 16)
						return
					if(X <= 0)
						return
					if(Y <= 0)
						return
					if(Z <= 0)
						return
					Kaio_SpawnX = X
					Kaio_SpawnY = Y
					Kaio_SpawnZ = Z
					logAndAlertAdmins("[key_name(usr)] set the Kaio spawn to be [X],[Y],[Z].")
					Save_Spawns()
		if("Demon")
			switch(input(usr, "Do you want to set the Demon spawn, or reset it?") in list("Set", "Reset","Cancel"))
				if("Cancel")
					return
				if("Reset")
					Demon_SpawnX = 419
					Demon_SpawnY = 289
					Demon_SpawnZ = 6
					logAndAlertAdmins("[key_name(usr)] reset the Demon spawn to be [Demon_SpawnX],[Demon_SpawnY],[Demon_SpawnZ].")
					Save_Spawns()
				if("Set")
					var/X = input(usr,"Enter the X location for the Demon spawn.") as num
					var/Y = input(usr,"Enter the Y location for the Demon spawn.") as num
					var/Z = input(usr,"Enter the Z location for the Demon spawn.") as num
					if(X >= 501)
						return
					if(Y >= 501)
						return
					if(Z >= 16)
						return
					if(X <= 0)
						return
					if(Y <= 0)
						return
					if(Z <= 0)
						return
					Demon_SpawnX = X
					Demon_SpawnY = Y
					Demon_SpawnZ = Z
					logAndAlertAdmins("[key_name(usr)] set the Demon spawn to be [X],[Y],[Z].")
					Save_Spawns()
		if("Namekian")
			switch(input(usr, "Do you want to set the Namekian spawn, or reset it?") in list("Set", "Reset","Cancel"))
				if("Cancel")
					return
				if("Reset")
					Namekian_SpawnX = 319
					Namekian_SpawnY = 270
					Namekian_SpawnZ = 3
					logAndAlertAdmins("[key_name(usr)] reset the Namekian spawn to be [Namekian_SpawnX],[Namekian_SpawnY],[Namekian_SpawnZ].")
					Save_Spawns()
				if("Set")
					var/X = input(usr,"Enter the X location for the Namekian spawn.") as num
					var/Y = input(usr,"Enter the Y location for the Namekian spawn.") as num
					var/Z = input(usr,"Enter the Z location for the Namekian spawn.") as num
					if(X >= 501)
						return
					if(Y >= 501)
						return
					if(Z >= 16)
						return
					if(X <= 0)
						return
					if(Y <= 0)
						return
					if(Z <= 0)
						return
					Namekian_SpawnX = X
					Namekian_SpawnY = Y
					Namekian_SpawnZ = Z
					logAndAlertAdmins("[key_name(usr)] set the Namekian spawn to be [X],[Y],[Z].")
					Save_Spawns()
		if("Changeling")
			switch(input(usr, "Do you want to set the Changeling spawn, or reset it?") in list("Set", "Reset","Cancel"))
				if("Cancel")
					return
				if("Reset")
					Changeling_SpawnX = 319
					Changeling_SpawnY = 416
					Changeling_SpawnZ = 12
					logAndAlertAdmins("[key_name(usr)] reset the Changeling spawn to be [Changeling_SpawnX],[Changeling_SpawnY],[Changeling_SpawnZ].")
					Save_Spawns()
				if("Set")
					var/X = input(usr,"Enter the X location for the Changeling spawn.") as num
					var/Y = input(usr,"Enter the Y location for the Changeling spawn.") as num
					var/Z = input(usr,"Enter the Z location for the Changeling spawn.") as num
					if(X >= 501)
						return
					if(Y >= 501)
						return
					if(Z >= 16)
						return
					if(X <= 0)
						return
					if(Y <= 0)
						return
					if(Z <= 0)
						return
					Changeling_SpawnX = X
					Changeling_SpawnY = Y
					Changeling_SpawnZ = Z
					logAndAlertAdmins("[key_name(usr)] set the Changeling spawn to be [X],[Y],[Z].")
					Save_Spawns()
		if("Demigod")
			switch(input(usr, "Do you want to set the Demi spawn, or reset it?") in list("Set", "Reset","Cancel"))
				if("Cancel")
					return
				if("Reset")
					Demi_SpawnX = 136
					Demi_SpawnY = 220
					Demi_SpawnZ = 5
					logAndAlertAdmins("[key_name(usr)] reset the Demi spawn to be [Demi_SpawnX],[Demi_SpawnY],[Demi_SpawnZ].")
					Save_Spawns()
				if("Set")
					var/X = input(usr,"Enter the X location for the Demi spawn.") as num
					var/Y = input(usr,"Enter the Y location for the Demi spawn.") as num
					var/Z = input(usr,"Enter the Z location for the Demi spawn.") as num
					if(X >= 501)
						return
					if(Y >= 501)
						return
					if(Z >= 16)
						return
					if(X <= 0)
						return
					if(Y <= 0)
						return
					if(Z <= 0)
						return
					Demi_SpawnX = X
					Demi_SpawnY = Y
					Demi_SpawnZ = Z
					logAndAlertAdmins("[key_name(usr)] set the Demi spawn to be [X],[Y],[Z].")
					Save_Spawns()
		if("Oni")
			switch(input(usr, "Do you want to set the Oni spawn, or reset it?") in list("Set", "Reset","Cancel"))
				if("Cancel")
					return
				if("Reset")
					Oni_SpawnX = 136
					Oni_SpawnY = 220
					Oni_SpawnZ = 5
					logAndAlertAdmins("[key_name(usr)] reset the Oni spawn to be [Oni_SpawnX],[Oni_SpawnY],[Oni_SpawnZ].")
					Save_Spawns()
				if("Set")
					var/X = input(usr,"Enter the X location for the Oni spawn.") as num
					var/Y = input(usr,"Enter the Y location for the Oni spawn.") as num
					var/Z = input(usr,"Enter the Z location for the Oni spawn.") as num
					if(X >= 501)
						return
					if(Y >= 501)
						return
					if(Z >= 16)
						return
					if(X <= 0)
						return
					if(Y <= 0)
						return
					if(Z <= 0)
						return
					Oni_SpawnX = X
					Oni_SpawnY = Y
					Oni_SpawnZ = Z
					logAndAlertAdmins("[key_name(usr)] set the Oni spawn to be [X],[Y],[Z].")
					Save_Spawns()
		if("Human")
			switch(input(usr, "Do you want to set the Human spawn, or reset it?") in list("Set", "Reset","Cancel"))
				if("Cancel")
					return
				if("Reset")
					Human_SpawnX = 102
					Human_SpawnY = 276
					Human_SpawnZ = 1
					logAndAlertAdmins("[key_name(usr)] reset the Human spawn to be [Human_SpawnX],[Human_SpawnY],[Human_SpawnZ].")
					Save_Spawns()
				if("Set")
					var/X = input(usr,"Enter the X location for the Human spawn.") as num
					var/Y = input(usr,"Enter the Y location for the Human spawn.") as num
					var/Z = input(usr,"Enter the Z location for the Human spawn.") as num
					if(X >= 501)
						return
					if(Y >= 501)
						return
					if(Z >= 16)
						return
					if(X <= 0)
						return
					if(Y <= 0)
						return
					if(Z <= 0)
						return
					Human_SpawnX = X
					Human_SpawnY = Y
					Human_SpawnZ = Z
					logAndAlertAdmins("[key_name(usr)] set the Human spawn to be [X],[Y],[Z].")
					Save_Spawns()
		if("Saiyan")
			switch(input(usr, "Do you want to set the Saiyan spawn, or reset it?") in list("Set", "Reset","Cancel"))
				if("Cancel")
					return
				if("Reset")
					Saiyan_SpawnX = 405
					Saiyan_SpawnY = 350
					Saiyan_SpawnZ = 2
					logAndAlertAdmins("[key_name(usr)] reset the Saiyan spawn to be [Saiyan_SpawnX],[Saiyan_SpawnY],[Saiyan_SpawnZ].")
					Save_Spawns()
				if("Set")
					var/X = input(usr,"Enter the X location for the Saiyan spawn.") as num
					var/Y = input(usr,"Enter the Y location for the Saiyan spawn.") as num
					var/Z = input(usr,"Enter the Z location for the Saiyan spawn.") as num
					if(X >= 501)
						return
					if(Y >= 501)
						return
					if(Z >= 16)
						return
					if(X <= 0)
						return
					if(Y <= 0)
						return
					if(Z <= 0)
						return
					Saiyan_SpawnX = X
					Saiyan_SpawnY = Y
					Saiyan_SpawnZ = Z
					logAndAlertAdmins("[key_name(usr)] set the Saiyan spawn to be [X],[Y],[Z].")
					Save_Spawns()
/client/proc/Clear_Treasure()
	set category="Admin"
	set name = "Clear Treasure"
	if(!usr.client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	switch(input(usr, "Are you sure you want to delete all the random treasure and mana crystals in the world?") in list("No", "Yes"))
		if("Yes")
			logAndAlertAdmins("[key_name(usr)] has deleted all mana/treasure in the game world.")
			for(var/obj/Resources/Treasure/T in world)
				del(T)
			for(var/obj/Mana/Mana_Crystal/C in world)
				del(C)
/client/proc/Wipe_Admin_Logs()
	set category="Admin"
	set name = "Wipe Admin Logs"
	if(!usr.client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	switch(input(usr, "Are you sure you want to wipe all the admin logs?") in list("No", "Yes"))
		if("Yes")
			fdel("AdminLog.log")
			logAndAlertAdmins("[key_name(usr)] has wiped the admin logs.")
/client/proc/Wipe_Rewards()
	set name = "Wipe Rewards"
	set category = "Admin"

	if(!src.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	switch(input(usr, "Are you sure you want to wipe all the rewards for players under the Rewards tab?") in list("No", "Yes"))
		if("Yes")
			logAndAlertAdmins("[key_name(usr)] has wiped the rewards tab clean.")
			for(var/obj/Reward_Instance/R in Reward_List)
				del(R)
			Reward_List = null
			Reward_List = list()
			return
/client/proc/Sort_Rewards()
	set name = "Sort Rewards"
	set category = "Admin"

	if(!src.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	var/Names = list()
	var/Rewards = list()
	for(var/obj/Reward_Instance/O in Reward_List)
		Names += O.Reward_Key
		Rewards += O
	Names = sortList(Names)
	Reward_List = null
	Reward_List = list()
	for(var/T in Names)
		for(var/obj/Reward_Instance/X in Rewards)
			if(X.Reward_Key == T)
				Reward_List += X
				Rewards -= X
	usr << "Rewards were sorted into alphabetical order by key."
/client/proc/Set_Rewards()
	set name = "Set Rewards"
	set category = "Admin"

	if(!src.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	usr << "Current rewards are. <br>Low - [Rewards_Low]<br>Medium - [Rewards_Medium]<br>High - [Rewards_Medium_High]<br>Very High - [Rewards_High]<br>Energy - [Rewards_Energy]"
	switch(input("Select which reward tier you want to change. Each reward tier is added to the players bp by the raw number multiplied by their BPMod. Energy is a static boost.") in list("Low","Medium","Medium High","High","Energy"))
		if("Energy")
			var/N = input(usr,"Enter how much energy you want a player to gain when rewarded. Keep in mind this is a static boost.") as num
			Rewards_Energy = N
			log_admin("[key_name(usr)] changed the Energy reward tier to [N].")
			alertAdmins("[key_name(usr)]  changed the Energy reward tier to [N]!")
			world.save_rewards()
			return
		if("Low")
			var/N = input(usr,"Enter how much you want the Low tier of reward to be. Keep in mind this number is multiplied by the players BPMod.") as num
			Rewards_Low = N
			log_admin("[key_name(usr)] changed the Low reward tier to [N].")
			alertAdmins("[key_name(usr)]  changed the Low reward tier to [N]!")
			world.save_rewards()
			return
		if("Medium")
			var/N = input(usr,"Enter how much you want the Medium tier of reward to be. Keep in mind this number is multiplied by the players BPMod.") as num
			Rewards_Medium = N
			log_admin("[key_name(usr)] changed the Medium reward tier to [N].")
			alertAdmins("[key_name(usr)]  changed the Medium reward tier to [N]!")
			world.save_rewards()
			return
		if("Medium High")
			var/N = input(usr,"Enter how much you want the High tier of reward to be. Keep in mind this number is multiplied by the players BPMod.") as num
			Rewards_Medium_High = N
			log_admin("[key_name(usr)] changed the High reward tier to [N].")
			alertAdmins("[key_name(usr)]  changed the High reward tier to [N]!")
			world.save_rewards()
			return
		if("High")
			var/N = input(usr,"Enter how much you want the Very High tier of reward to be. Keep in mind this number is multiplied by the players BPMod.") as num
			Rewards_High = N
			log_admin("[key_name(usr)] changed the Very High reward tier to [N].")
			alertAdmins("[key_name(usr)]  changed the Very High reward tier to [N]!")
			world.save_rewards()
			return
/client/proc/Toggle_Global_Rares()
	set name = "Toggle Global Rares"
	set category = "Admin"

	if(!src.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	usr << "Global Rares are currently [Allow_Rares]."
	switch(input("Toggling this off will no longer allow players the chance to roll a rare race.") in list("Off","On"))
		if("On")
			Allow_Rares = "On"
			log_admin("[key_name(src)] allowed global rares on for all players.")
			alertAdmins("[key_name(src)]  allowed global rares on for all players.")
			return
		if("Off")
			Allow_Rares = "Off"
			log_admin("[key_name(src)] turned global rares off for all players.")
			alertAdmins("[key_name(src)] turned global rares off for all players.")
			return
/client/proc/Toggle_Global_Reincarnations()
	set name = "Toggle Global Reincarnations"
	set category = "Admin"

	if(!src.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	usr << "Global reincarnations are currently [Reincarnation_Status]."
	switch(input("Toggling this on will allow players to reincarnate upon death.") in list("Off","On"))
		if("On")
			Reincarnation_Status = "On"
			log_admin("[key_name(src)] allowed global reincarnations after death for all players.")
			alertAdmins("[key_name(src)] allowed global reincarnations after death for all players.")
			return
		if("Off")
			Reincarnation_Status = "Off"
			log_admin("[key_name(src)] prevented global reincarnations after death for all players.")
			alertAdmins("[key_name(src)] prevented global reincarnations after death for all players.")
			return
/client/proc/Set_Dead_Time()
	set name = "Set Dead Time"
	set category = "Admin"

	if(!src.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	usr << "Global death times are set for [Dead_Time]."
	var/N = input(src,"Choose in years how long someone must remain dead before they can be revived. Current is [Dead_Time].") as num
	if(N <= 0)
		N = 1

	Dead_Time = N
	log_admin("[key_name(src)] set the global death times to [Dead_Time].")
	alertAdmins("[key_name(src)] set the global death times to [Dead_Time].")
/client/proc/Respawn_Resources()
	set name = "Respawn Resources"
	set category = "Admin"

	if(!src.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	switch(input("Are you sure you want to respawn all the resources on all planets?") in list("No","Yes"))
		if("Yes")
			Resources()
			log_admin("[key_name(src)] respawned all the servers resources on each planet.")
			alertAdmins("[key_name(src)] respawned all the servers resources on each planet.")
/client/proc/RNG()
	set name = "RNG"
	set category = "Admin"

	if(!src.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	var/L=input(usr,"Lowest number.") as num
	var/H=input(usr,"Highest number.") as num
	if(L && H)
		var/N = rand(L,H)
		log_admin("[key_name(src)] used RNG and rolled between [L] and [H] to get [N].")
		alertAdmins("[key_name(src)] used RNG and rolled between [L] and [H] to get [N].")
/client/proc/Destroy_Regenerators()
	set name = "Destroy all Regenerators"
	set category = "Admin"

	if(!src.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	switch(input("Are you sure you want to destroy all the regenerators currently on the server?") in list("No","Yes"))
		if("Yes")
			var/amount = 0
			for(var/obj/items/Regenerator/R)
				del(R)
				amount++
			if(!amount)
				log_admin("[key_name(src)] tried to destroy all regenerators in the world, but none were found.")
				alertAdmins("[key_name(src)] tried to destroy all regenerators in the world, but none were found.")
				return
			log_admin("[key_name(src)] destroyed all [amount] regenerators in the world.")
			alertAdmins("[key_name(src)] destroyed all [amount] regenerators in the world.")
		else
			return

/client/proc/Grant_Alien_Trans(mob/M as mob in world)
	set name = "Grant Alien Trans"
	set category = "Admin"

	if(!src.holder)
		alert("You cannot perform this action.  You must be of a higher administrative rank!")
		return
	switch(input("Which trans would you like to give to [M]?") in list("Ki Trans","Melee Trans","Hybrid Trans"))
		if("Hybrid Trans")
			if(M.Hybrid_Build == 1)
				M.Hybrid_Build = 2
				log_admin("[key_name(src)] has granted [M] their Hybrid trans.")
				alertAdmins("[key_name(src)] has granted [M] their Hybrid trans.")
				return
			else
				M.Hybrid_Build = 1
				log_admin("[key_name(src)] has removed [M]'s Melee trans.")
				alertAdmins("[key_name(src)] has removed [M]'s Melee trans.")
				return
		if("Melee Trans")
			if(M.Melee_Build == 1)
				M.Melee_Build = 2
				log_admin("[key_name(src)] has granted [M] their Melee trans.")
				alertAdmins("[key_name(src)] has granted [M] their Melee trans.")
				return
			else
				M.Melee_Build = 1
				log_admin("[key_name(src)] has removed [M]'s Melee trans.")
				alertAdmins("[key_name(src)] has removed [M]'s Melee trans.")
				return
		if("Ki Trans")
			if(M.Ki_Build == 1)
				M.Ki_Build = 2
				log_admin("[key_name(src)] has granted [M] their Ki Trans.")
				alertAdmins("[key_name(src)] has granted [M] their Ki Trans.")
				return
			else
				M.Ki_Build = 1
				log_admin("[key_name(src)] has removed [M]'s Ki Trans.")
				alertAdmins("[key_name(src)] has removed [M]'s Ki Trans.")
				return
/client/proc/Grant_Super_Tuffle(mob/M as mob in world)
	set name = "Grant Super Tuffle"
	set category = "Admin"

	if(!src.holder)
		alert("You cannot perform this action.  You must be of a higher administrative rank!")
		return
	switch(input("Would you like to grant [M] Super Tuffle? Or Remove it?") in list("Remove","Grant"))
		if("Grant")
			if(M.Super_Tsufu_Learned == 0)
				M.Super_Tsufu_Learnable = 1
			log_admin("[key_name(src)] has granted [M] the ability to unlock Super Tuffle eventually.")
			alertAdmins("[key_name(src)] has granted [M] the ability to unlock Super Tuffle eventually.")
			switch(input("Do you want to immediately unlock [M]'s Super Tuffle so they can gain all the mod changes now?") in list("No","Yes"))
				if("No")
					return
				if("Yes")
					if(M.Super_Tsufu_Learned == 0)
						M.Super_Tsufu_Learnable = 0
						M.Add=5.5
						M.KiMod*=2
						M.PowMod*=2
						M.OffMod*=2
						M.DefMod*=2
						M.BPMod=2.2
						M.Super_Tsufu_Learned=1
						M<<"You are one of the few Tsufurujins who was born with a special mental mutation.  Through much meditation you have learned how to exploit this mutation to your own benefit, increasing your mental capabilities!"
						M<<"Your intelligence, offense, defense, BP mod, and control over Ki soars to super-tuffle heights!"
						log_admin("[key_name(src)] has granted [M] Super Tuffle right away!")
						alertAdmins("[key_name(src)] has granted [M] Super Tuffle right away!")
						return
		if("Remove")
			if(M.Super_Tsufu_Learned)
				M.Super_Tsufu_Learnable = 0
				M.Add=4.5
				M.KiMod/=2
				M.PowMod/=2
				M.OffMod/=2
				M.DefMod/=2
				M.BPMod=1.5
				M.Super_Tsufu_Learned=0
				M<<"Your Super Tuffle has been removed."
				log_admin("[key_name(src)] has removed [M]'s Super Tuffle entirely.")
				alertAdmins("[key_name(src)] has removed [M]'s Super Tuffle entirely.")
				return
			else if(M.Super_Tsufu_Learnable)
				M.Super_Tsufu_Learnable = 0
				log_admin("[key_name(src)] has removed [M]'s ability to unlock Super Tuffle.")
				alertAdmins("[key_name(src)] has removed [M]'s ability to unlock Super Tuffle.")
				return
/client/proc/Destroy_Gravity()
	set name = "Destroy all Gravity Machines"
	set category = "Admin"

	if(!src.holder)
		alert("You cannot perform this action.  You must be of a higher administrative rank!")
		return
	var/amount = 0
	switch(input("Are you sure you want to destroy all the gravity machines currently on the server?") in list("No","Yes"))
		if("Yes")
			for(var/obj/items/Gravity/R)
				del(R)
				amount++
			if(!amount)
				log_admin("[key_name(src)] tried to destroy all gravity machines in the world, but none were found.")
				alertAdmins("[key_name(src)] tried to destroy all gravity machines in the world, but none were found.")
				return
			log_admin("[key_name(src)] destroyed all [amount] gravity machines in the world!")
			alertAdmins("[key_name(src)] destroyed all [amount] gravity machines in the world!")
		else
			return
/client/proc/Enlarge(atom/A as mob|obj in world)
	set category = "Admin"
	set name = "Enlarge Icon"

	if(!src.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	if(!A.icon)
		alert("They don't have an icon to enlarge!")
		return

	A.Enlarge_Icon()
	log_admin("[key_name(src)] used Enlarge Icon on [key_name(A)]")
	alertAdmins("[key_name(src)] used Enlarge Icon on [key_name(A)]")

/client/proc/sendToSpawn(mob/A in Players)
	set category = "Admin"
	set name = "Send to Spawn"

	if(!src.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return

	A.z = 0
	if(A.Dead)A.loc=locate(rand(163,173),rand(183,193),5)
	else A.Location()
	log_admin("[key_name(src)] sent [key_name(A)] to spawn")
	alertAdmins("[key_name(src)] sent [key_name(A)] to spawn")

/client/proc/Rename(atom/A in world)
	set category = "Admin"
	set name = "Force Rename"

	if (!src.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return

	var/newname = copytext(sanitize(input("Renaming [A]")), 1, MAX_NAME_LENGTH)
	if(!newname)
		return
	else
		log_admin("[key_name(src)] changed [key_name(A)]'s name to [newname]")
		alertAdmins("[key_name(src)] changed [key_name(A)]'s name to [newname]")
		A.name = newname

		//Doesn't mess with realname for now

/client/proc/Hubtext()
	set name = "Modify Hubtext"
	set category = "Admin"

	if(!src.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return

	global.HubText=input("Input a message to be displayed on the hub.") as text
	if(!HubText)
		return
	else
		log_admin("[key_name(src)] set HubText to [global.HubText]")
		alertAdmins("[key_name(src)] set the HubText to [global.HubText]")

/client/proc/WipeMap()
	set category = "Admin"
	set name = "Wipe Map"

	if(!src.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return


	switch(input("Are you sure you want to wipe the map?") in list("No","Yes"))
		if("No")
			return
		if("Yes")
			fdel("Data/ItemSaves/")
			var/I = 100
			while(I)
				if(fexists("Data/ItemSaves/ItemSave[I].bdb"))
					fdel("Data/ItemSaves/ItemSave[I].bdb")
				I -= 1
			I = 100
			while(I)
				if(fexists("Map[I]"))
					fdel("Map[I]")
				I -= 1
			log_admin("[key_name(src)] is commencing a map wipe")
/client/proc/WipeWorld()
	set category = "Admin"
	set name = "Wipe World"

	if(!src.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return

	var/reallySure = 0
	while(reallySure < 5)
		switch(input("Are you [pick("really", "seriously", "positively", "forreal", "super", "fucking", "actually")] SURE you want to delete all saves?") in list("No","Yes"))
			if("No")
				return
			else
				reallySure++
	world << "<span class=\"announce\"><font size=7>[key_name(src)] is commencing a <b>world wipe!</b></font></span>"
	log_admin("[key_name(src)] is commencing a world wipe")
	for(var/mob/player/M in world)
		M.lastKnownKey = null
	fdel("Data/Players/")
	fdel("Data/RANKS.bdb")
	fdel("Data/GAIN.bdb")
	fdel("Data/Year.bdb")
	fdel("Data/Zombies.bdb")
	fdel("Data/IntGain.bdb")
	fdel("Data/Areas.bdb")
	fdel("Data/ItemSave.bdb")
	//fdel("Data/Map1.bdb")
//	SaveWorld()
	world.Reboot()

/client/proc/InactiveBoot()
	set category = "Admin"
	set name = "AFKBoot"

	if(!src.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return

	for(var/mob/player/M in world)	//Logged in and not an admin
		if(M.client && !M.client.holder && M.client.inactivity >= 3000)
			M << "You have been booted for inactivity."
			M.Logout()
	log_admin("[key_name(src)] booted all inactive clients")
	alertAdmins("[key_name(src)] booted all inactive clients")

/client/proc/Knockout(mob/M in world)
	set category = "Admin"
	set name = "Knockout"

	if (!src.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return

	var/reason = input(src,"Reason") as text
	reason = copytext(sanitize(reason), 1, MAX_MESSAGE_LEN)
	if(!reason)
		reason = "admin"	//fallback

	M.KO(reason)

	log_admin("[key_name(src)] knocked out [key_name(M)] with reason \'[reason]\'")
	alertAdmins("[key_name(src)] knocked out [key_name(M)] with reason \'[reason]\'")


/client/proc/Kill(mob/M in world)
	set category = "Admin"
	set name = "Kill"

	if(!src.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return

	var/reason = input(src,"Reason") as text
	reason = copytext(sanitize(reason), 1, MAX_MESSAGE_LEN)
	if(!reason)
		reason = "admin"	//fallback

	M.Death(reason)

	log_admin("[key_name(src)] killed [key_name(M)] with reason \'[reason]\'")
	alertAdmins("[key_name(src)] killed [key_name(M)] with reason \'[reason]\'")

var/Year_Speed = 1
/client/proc/Year_Speed()
	set category = "Admin"
	set name = "Year Speed"
	if(!src.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return

	Year_Speed = input("Current is [Year_Speed]. The number must be greater than 0. Default is 1") as num
	log_admin("[key_name(src)] set Year Speed to [Year_Speed]")
	alertAdmins("[key_name(src)] set Year Speed to [Year_Speed]")

/client/proc/Assess(mob/M in Players)
	set category = "Admin"
	set name = "Assess"

	if(!src.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return

	if(mob)
		log_admin("[key_name(src)] used assess on [M].")
		alertAdmins("[key_name(usr)] used assess on [M].</b>")
		mob.Get_Assess(M)

/client/proc/Assess_All()
	set category = "Admin"
	set name = "Assess All"

	if(!src.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	if(src.holder.level >= 4)
		var/list/Powers=new
		for(var/mob/player/A in Players)
			Powers += A.BP
		var/Power_Window={"<html><head><body><body bgcolor="#000000"><font size=1><font color="#CCCCCC">"}
		for(var/P in Powers)
			var/Lowest_Power=min(Powers)
			for(var/mob/player/A in Players)
				if(Lowest_Power==A.BP)
					if(A in Power_Window) continue
					var/text = add_tspace("[A]",20)
					text += " [Commas(min(Powers))]<br>"
					Power_Window += text
			Powers-=min(Powers)
		src << browse(Power_Window,"window=World Assess;size=700x600")
		log_admin("[key_name(src)] used assess all.")

/client/proc/Heal_Injury(mob/M in Players)
	set category = "Admin"
	set name = "Admin Heal Injury"

	if(!src.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return

	if(!M)
		alert("Mob doesn't exist!")
		return
	var/L = list("All")
	M.Injure_Heal(100,L)

	log_admin("[key_name(src)] used AdminHeal Injury on [key_name(M)]")
	alertAdmins("[key_name(src)] used AdminHeal Injury on [key_name(M)]")
/client/proc/Heal(mob/M in Players)
	set category = "Admin"
	set name = "Admin Heal"

	if(!src.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return

	if(!M)
		alert("Mob doesn't exist!")
		return

	if(M.icon_state == "KO")
		M.Un_KO()

	M.Health = 100
	M.Ki = M.MaxKi

	log_admin("[key_name(src)] used AdminHeal on [key_name(M)]")
	alertAdmins("[key_name(src)] used AdminHeal on [key_name(M)]")

/client/proc/Revive(mob/M in Players)
	set category = "Admin"
	set name = "Admin Revive"

	if(!src.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return

	if(!M)
		alert("Mob doesn't exist!")
		return

	if(M.Dead)
		M.Revive()
	else
		alert("[M] isn't dead!")
		return
	log_admin("[key_name(src)] used AdminRevive on [key_name(M)]")
	alertAdmins("[key_name(src)] used AdminRevive on [key_name(M)]")

var/const/Gain_Divider = 0.000000001
/client/proc/Gains()
	set category = "Admin"
	set name = "Gains Multiplier"

	if(!src.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return

	src << "Current Gain: [GG/Gain_Divider]%"
	var/New_Gain = input(src, "Enter the new gain multiplier for this server as a percent.") as num
	New_Gain = New_Gain*Gain_Divider
	if(!New_Gain)
		alert("Canceled changing gain multiplier!")
		return
	else
		GG = New_Gain
		if(global.TestServerOn)
			TESTGAIN=GG
	log_admin("[key_name(src)] set the Gains Multipler to [New_Gain]")
	alertAdmins("[key_name(src)] set the Gains Multipler to [New_Gain]")

/client/proc/Delete(atom/A in world)
	set category = "Admin"
	set name = "Delete"

	if(!src.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return

	//Deleting areas fucks stuff up but i guess owners and stuff can do it if they want
	if(isarea(A) && !(src.holder.level >= 5))
		alert("You cannot delete areas! You must be of a higher administrative rank!")
		return

	//Don't let us boot a higher level admin
	if(ismob(A))
		var/mob/M = A
		if (M.client && M.client.holder && (M.client.holder.level >= src.holder.level) && !(M==src))
			alert("You cannot perform this action. You must be of a higher administrative rank!", null, null, null, null, null)
			return

	if(A)
		switch(input("Are you sure you want to delete [A]?") in list("No","Yes"))
			if("Yes")
				log_admin("[key_name(src)] deleted [A]")
				alertAdmins("[key_name(src)] deleted [A]")
				del(A)
			else
				return
	else
		alert("Object doesn't exist anymore!")
		return

/client/proc/ForceSSJ(mob/M in Players)
	set category = "Admin"
	set name = "Force +SSJ"

	if(!src.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return

	if(M.Race != "Saiyan")
		alert("[M] is not a Saiyan!")
		return
	if(M.Class == "Legendary")
		alert("[M] is already a LSSj!")
		return

	if(M && M.client)	//Do the checks in the reverse of what you'd assume
		if(M.Hasssj < 4)
			spawn
				M.Hasssj = 4
				M.SSj4()
		else if(M.Hasssj < 3)
			spawn
				M.Hasssj = 3
				M.SSj3()
		else if(M.Hasssj < 2)
			spawn
				M.Hasssj = 2
				M.SSj2()
		else if(M.Hasssj < 1)
			spawn
				M.Hasssj = 1
				M.SSj()
		else
			alert("[M] is already at SSJ4!")
			return
		log_admin("[key_name(src)] forced [key_name(M)] into SSJ[M.ssj+1]")
		alertAdmins("[key_name(src)] forced [key_name(M)] into SSJ[M.ssj+1]!")
	else
		alert("Player no longer exists!")
		return

/client/proc/Delete_Player_save(mob/A in Players)
	set category = "Admin"
	set name = "Del Player Save"

	if(!src.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return

	//Don't let us delete higher level admins saves!
	if (A.client && A.client.holder && (A.client.holder.level >= src.holder.level) && A != src)
		alert("You cannot perform this action. You must be of a higher administrative rank!", null, null, null, null, null)
		return

	switch(input("Really delete [key_name(A)]'s savefile?") in list("No","Yes"))
		if("Yes")
			log_admin("[key_name(src)] deleted [key_name(A)]'s savefile")
			alertAdmins("[key_name(src)] deleted [key_name(A)]'s savefile")
			var/charname = A.real_name
			var/lastkey = A.lastKnownKey
			del(A)
			if(fexists("Data/Players/[lastkey]/Characters/[charname].sav"))
				fcopy("Data/Players/[lastkey]/Characters/[charname].sav","Data/Players/[lastkey]/[charname].deleted")
				fdel("Data/Players/[lastkey]/Characters/[charname].sav")
		if("No")
			alert("Aborted deleting [key_name(A)]'s savefile!")
			return

var/Admin_Int_Setting = 0.05
/client/proc/Int_Gain(var/newIntGain as num)
	set category = "Admin"
	set name = "Int Gain"

	if(!src.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	if(!newIntGain)	//so you can just type int gain NUMBER if you want
		newIntGain = input(src,"Set a multiplier for how fast int_xp is gained. Current is [Admin_Int_Setting]x") \
	as num
	if(!newIntGain)
		alert("Aborted editting Int Gain!")
		return
	else
		Admin_Int_Setting = newIntGain
		alertAdmins("[key_name(src)] editted the Int Gain to [newIntGain]x")
		log_admin("[key_name(src)] editted the Int Gain to [newIntGain]x")

/client/proc/Purge_Large_Icons(var/size as num)
	set name = "Purge Large Icons"
	set category = "Admin"

	if(!src.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return

	if(!size)
		size = input("(CAREFUL) Delete icons above what FILESIZE? (CAREFUL)") as num
	if(!size)
		alert("Aborted Purge Large Icons!")
		return

	if(size)
		switch(alert("(CAREFUL) This will delete icons above [size] in FILESIZE! Continue?",,"Yes","No"))
			if("No")
				alert("Aborted Purge Large Icons!")
				return

	for(var/atom/A in world)
		var/filesize = length(A.icon)
		if(filesize >= size)
			alertAdmins("[key_name(src)]: Deleting [A] @ [A.loc] filesize was [filesize]",4)
			log_admin("[key_name(src)]: Deleting [A] @ [A.loc] filesize was [filesize]")
			view(A)	<< "[A]: My icon was too large! I am being deleted by an Administrator!"
			A.icon = null
			del(A)
	log_admin("[key_name(src)] used Purge Large Icons")
	return

/client/proc/Give(mob/M in Players)
	set category = "Admin"
	set name = "Give Obj"

	if(!src.holder || (src.holder.level < 2))	//EV and above
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	var/list/B = new
	B+="Cancel"
	B+=typesof(/obj)
	B.Remove(typesof(/obj/admins),typesof(/obj/Body_Part),typesof(/obj/Aquatian),typesof(/obj/Props),\
	typesof(/OBJ_AI/SpaceDebris),typesof(/obj/Planets),\
	typesof(/obj/Technology),typesof(/obj/Auras),typesof(/obj/Charges),typesof(/obj/Blasts)\
	,typesof(/obj/Warper),typesof(/obj/Crater),typesof(/obj/BigCrater),typesof(/obj/Build)\
	,typesof(/obj/Contact),typesof(/obj/DeadZone),typesof(/obj/Faction)\
	,typesof(/obj/Faction),typesof(/obj/Well),typesof(/obj/Explosion),typesof(/obj/Baby)\
	,typesof(/obj/Lightning_Strike),typesof(/obj/Blast),typesof(/obj/Curse),typesof(/obj/Sacred_Water)\
	,typesof(/obj/Controls),typesof(/obj/Ships),typesof(/obj/Drill),typesof(/obj/Tournament_Register))

	var/Choice=input("") in B
	if(Choice=="Cancel")
		return
	if(M.contents)	//You wouldn't expect an error to come of removing this, but one did!
		M.contents += new Choice
	else
		return
	log_admin("[key_name(src)] gave [key_name(M)] [Choice]")
	alertAdmins("[key_name(src)] gave [key_name(M)] [Choice]")

/client/proc/editStory()
	set category="Admin"
	set name = "Edit Story"

	if(!src.holder || src.holder.level < 2)	//EV and above
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return

	if(!WritingStory)
		WritingStory = src
		log_admin("[key_name(src)] is editting the story")
		alertAdmins("[key_name(src)] is editting the story")
		Story = input(usr,"Edit!","Edit Story",Story) as message
		log_admin("[key_name(src)] is finished editting the story")
		alertAdmins("[key_name(src)] is finished editting the story")
		WritingStory = 0
		SaveStory()
	else
		alert("[key_name(WritingStory)] is already editting the story!")
		return

/client/proc/editRules()
	set category="Admin"
	set name = "Edit Rules"

	if(!src.holder || (src.holder.level < 4))	//Coder and above
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return

	if(!WritingRules)
		WritingRules = src
		log_admin("[key_name(src)] is editting the rules")
		alertAdmins("[key_name(src)] is editting the rules")
		Rules=input(usr,"Edit!","Edit Rules",Rules) as message
		log_admin("[key_name(src)] is finished editting the rules")
		alertAdmins("[key_name(src)] is finished editting the rules")
		WritingRules = 0
		SaveRules()
	else
		alert("[key_name(WritingRules)] is already editting the rules!")
		return

/client/proc/editRanks()
	set category="Admin"
	set name = "Edit Ranks"

	if(!src.holder || src.holder.level < 3)	//Admin and above
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return

	if(!WritingRanks)
		WritingRanks = src
		log_admin("[key_name(src)] is editting the ranks")
		alertAdmins("[key_name(src)] is editting the ranks")
		Ranks=input(usr,"Edit!","Edit Ranks",Ranks) as message
		log_admin("[key_name(src)] is finished editting the ranks")
		alertAdmins("[key_name(src)] is finished editting the ranks")
		WritingRanks = 0
		SaveRanks()
	else
		alert("[key_name(WritingRanks)] is already editting the rules!")
		return

/client/proc/editJobs()
	set category="Admin"
	set name = "Edit Jobs"

	if(!src.holder || (src.holder.level < 3))	//Admin and above
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return

	if(!WritingJobs)
		WritingJobs = src
		log_admin("[key_name(src)] is editting the jobs")
		alertAdmins("[key_name(src)] is editting the jobs")
		Jobs=input(usr,"Edit!","Edit Jobs",Jobs) as message
		log_admin("[key_name(src)] is finished editting the jobs")
		alertAdmins("[key_name(src)] is finished editting the jobs")
		WritingJobs = 0
		SaveJobs()
	else
		alert("[key_name(WritingRanks)] is already editting the jobs!")
		return

/client/proc/EditLoginNotes()
	set category="Admin"
	set name = "Edit Login Notes"

	if(!src.holder || (src.holder.level < 4))	//LeadAdmin and above
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return

	if(!WritingUpdates)
		WritingUpdates = src
		log_admin("[key_name(src)] is editting the login notes")
		alertAdmins("[key_name(src)] is editting the login notes")
		Version_Notes=input(usr,"Edit!","Edit",Version_Notes) as message
		log_admin("[key_name(src)] is finished editting the login notes")
		alertAdmins("[key_name(src)] is finished editting the login notes")
		WritingUpdates = 0
		SaveLogin()
	else
		alert("[key_name(WritingUpdates)] is already editting the jobs!")
		return


//Temporary update proc
/client/proc/updateFile(var/F as file)
	set category = "Admin"
	set name = "Update File"

	if(!src.holder || (src.holder.level < 5))	//Coder and above
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return

	fcopy(F,"[F]")
	log_admin("[key_name(src)] updated file [F]")
	alertAdmins("[key_name(src)] updated file [F]")

/client/proc/StatRanks()
	set category = "Admin"
	set name = "Stat Ranks"

	if(!src.holder || (src.holder.level < 5))	//Coder and above
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return

	var/PowerRanks={"<html>
<head><body>
<body bgcolor="#000000"><font size=2><font color="#CCCCCC">
Name: ( BP Rank ) ( Stat Rank )"}
	for(var/mob/player/M in Players)
		if(M.client)
			PowerRanks += {"<br>[M.name]: ( [round(M.BPRank)] ) ( [round(M.StatRank)] )"}
	src << browse(PowerRanks,"window=statranks;size=400x400")

/client/proc/adminOverlays(mob/M in Players)
	set category = "Admin"
	set name = "Admin Overlays"

	if(!src.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return

	M.overlays = null
	M.underlays = null
	if(M.Dead)
		M.overlays += 'Halo Custom.dmi'
	log_admin("[key_name(src)] removed [key_name(M)]'s overlays")