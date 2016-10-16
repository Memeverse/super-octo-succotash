/mob/proc/reset_view(atom/A)
	if (src.client)
		if (istype(A, /atom/movable))
			src.client.perspective = EYE_PERSPECTIVE
			src.client.eye = A
		else
			if (isturf(src.loc))
				src.client.eye = src.client.mob
				src.client.perspective = MOB_PERSPECTIVE
			else
				src.client.perspective = EYE_PERSPECTIVE
				src.client.eye = src.loc
	return

/*
/client/proc/admin_observe()
	set category = "Admin"
	set name = "Set Observe"
	if(!src.holder)
		alert("You are not an admin")
		return

	src.verbs += /client/proc/admin_play
	src.verbs -= /client/proc/admin_observe
	var/rank = src.holder.rank
	clear_admin_verbs()
	src.holder.state = 2
	update_admins(rank)
	if(!istype(src.mob, /mob/observer))
		src.mob.adminObserve = 1
		src.mob.ghostize()
	src << "You are now observing"

/client/proc/admin_play()
	set category = "Admin"
	set name = "Set Play"
	if(!src.holder)
		alert("You are not an admin")
		return
	src.verbs -= /client/proc/admin_play
	src.verbs += /client/proc/admin_observe
	var/rank = src.holder.rank
	clear_admin_verbs()
	src.holder.state = 1
	update_admins(rank)
	if(istype(src.mob, /mob/observer))
		src.mob:reenter_body()
		src.mob.adminObserve = 0
	src << "You are now playing"
*/

/mob/verb/cancel_camera()
	set name = "Reset View"
	set category = "Other"
	src.reset_view(null)

/client/proc/Watch()	//This is what admin.. observing is now, so to speak
	set name = "Watch"
	set category = "Admin"

	if(!src.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!", null, null, null, null, null)
		return
	if(src.mob)
		src.mob.observe()
	else
		alert("You've got no mob guy! That isn't good!")
		return

/mob/proc/observe()
	set name = "Observe"
	var/is_admin = 0

	if (src.client.holder && src.client.holder.level >= 1 && ( src.client.holder.state == 2 || src.client.holder.level > 3 ))
		is_admin = 1

	//Need to check if they're a kaio

	var/list/names = list()
	var/list/namecounts = list()
	var/list/creatures = list()
	if(is_admin)
		for (var/obj/items/Magic_Ball/D in world)
			var/name = "Magic Ball"
			if (name in names)
				namecounts[name]++
				name = "[name] ([namecounts[name]])"
			else
				names.Add(name)
				namecounts[name] = 1
			creatures[name] = D

		for (var/NPC_AI/B in world)
			var/name = "NPC: [B.name]"
			if (name in names)
				namecounts[name]++
				name = "[name] ([namecounts[name]])"
			else
				names.Add(name)
				namecounts[name] = 1
			creatures[name] = B

		for(var/mob/player/B in Players)
			var/name = "[B.name]"
			if (name in names)
				namecounts[name]++
				name = "[name] ([namecounts[name]])"
			else
				names.Add(name)
				namecounts[name] = 1
			creatures[name] = B


	//creatures += getmobs()

	src.client.perspective = EYE_PERSPECTIVE

	var/eye_name = null

	if (is_admin)
		eye_name = input("Please, select a player!", "Admin Observe", null, null) as null|anything in creatures
	else
		eye_name = input("Please, select a player!", "Observe", null, null) as null|anything in creatures

	if (!eye_name)
		return

	var/mob/eye = creatures[eye_name]
	if (is_admin)
		if (eye)
			src.reset_view(eye)
			client.adminobs = 1
			if(eye == src.client.mob)
				client.adminobs = 0
		else
			src.reset_view(null)
			client.adminobs = 0
	else
		if (eye)
			src.client.eye = eye
		else
			src.client.eye = src.client.mob