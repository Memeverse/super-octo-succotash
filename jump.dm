/client/proc/Jump(var/area/A in world)
	set desc = "Area to jump to"
	set category = "Admin"
	if(!src.holder)
		src << "Only administrators may use this command."
		return

	usr.loc = pick(get_area_turfs(A))

	log_admin("[key_name(usr)] jumped to [A]")
	alertAdmins("[key_name_admin(usr)] jumped to [A]", 1)

/client/proc/jumptoturf(var/turf/T in world)
	set category = "Admin"
	set name = "Jump to turf"

	if(!src.holder)
		src << "Only administrators may use this command."
		return

	log_admin("[key_name(usr)] jumped to [T.x],[T.y],[T.z] in [T.loc]")
	alertAdmins("[key_name_admin(usr)] jumped to [T.x],[T.y],[T.z] in [T.loc]", 1)

	usr.unSummonX = usr.x
	usr.unSummonY = usr.y
	usr.unSummonZ = usr.z
	usr.loc = T

/client/proc/jumptomob(var/mob/M in world)
	set category = "Admin"
	set name = "Jump to Mob"

	if(!src.holder)
		src << "Only administrators may use this command."
		return

	log_admin("[key_name(usr)] jumped to [key_name(M)]")
	alertAdmins("[key_name_admin(usr)] jumped to [key_name_admin(M)]", 1)

	usr.unSummonX = usr.x
	usr.unSummonY = usr.y
	usr.unSummonZ = usr.z
	usr.loc = get_turf(M)


/client/proc/jumptokey()
	set category = "Admin"
	set name = "Jump to Key"

	if(!src.holder)
		src << "Only administrators may use this command."
		return

	var/list/keys = list()
	for(var/client/C)
		keys += C
	var/selection = input("Please, select a player!", "Admin Jumping", null, null) as null|anything in keys
	if(!selection)
		return
	var/mob/M = selection:mob
	log_admin("[key_name(usr)] jumped to [key_name(M)]")
	alertAdmins("[key_name_admin(usr)] jumped to [key_name_admin(M)]", 1)

	usr.unSummonX = usr.x
	usr.unSummonY = usr.y
	usr.unSummonZ = usr.z
	usr.loc = M.loc


/client/proc/Getmob(var/mob/M in world)
	set category = "Admin"
	set name = "Get Mob"
	set desc = "Mob to teleport"
	if(!src.holder)
		src << "Only administrators may use this command."
		return
	log_admin("[key_name(usr)] summon [key_name(M)]")
	alertAdmins("[key_name_admin(usr)] summon [key_name_admin(M)]", 1)

	M.unSummonX = M.x
	M.unSummonY = M.y
	M.unSummonZ = M.z
	M.loc = get_turf(usr)

/client/proc/returnmob(var/mob/M in world)
	set category = "Admin"
	set name = "Return Mob"
	set desc = "Return a mob to its previous location"
	if(!src.holder)
		src << "Only administrators may use this command."
		return

	if(!M.unSummonX||!M.unSummonY||!M.unSummonZ){src << "This mob does not have coordinates to return to."; return}

	log_admin("[key_name(usr)] teleported [key_name(M)] to their old location.")
	alertAdmins("[key_name_admin(usr)] teleported [key_name_admin(M)] to their old location.", 1)

	M.loc = locate(M.unSummonX,M.unSummonY,M.unSummonZ)
	M.unSummonX = null
	M.unSummonY = null
	M.unSummonZ = null

/client/proc/sendmob(var/mob/M in world, var/area/A in world)
	set category = "Admin"
	set name = "Send Mob"
	if(!src.holder)
		src << "Only administrators may use this command."
		return

	M.unSummonX = M.x
	M.unSummonY = M.y
	M.unSummonZ = M.z
	M.loc = pick(get_area_turfs(A))

	log_admin("[key_name(usr)] teleported [key_name(M)] to [A]")
	alertAdmins("[key_name_admin(usr)] teleported [key_name_admin(M)] to [A]", 1)