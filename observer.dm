mob/observer/var/mob/body
mob/observer/TextColor = "White"	//Uniform color yo
mob/observer/icon = null
mob/observer/GravMastered = 1000000	//a million~
mob/observer/Lungs = 1
mob/observer/Immortal = 1
mob/observer/attackable = 0
mob/observer/anchored = 1	//Don't float through space

/mob/observer/Login()
	..()
	if (!isturf(src.loc))
		src.client.eye = src.loc
		src.client.perspective = EYE_PERSPECTIVE

	return

/mob/observer/New(mob/body)
	src.invisibility = 10
	src.sight |= SEE_TURFS | SEE_MOBS | SEE_OBJS | SEE_SELF
	src.see_invisible = 15
	src.see_in_dark = 100

	if(body)
		src.body = body
		src.loc = get_turf(body.loc)
		src.real_name = body.real_name
		src.name = body.name+" - Observer"
		//src.verbs += /mob/observer/proc/reenter_body

/mob/proc/ghostize()
	set name = "Ghost"
	set desc = "Observe the world, transparently!"
	if(src.client)
		var/ObserverBody = new /mob/observer(src)
		src.client.mob = ObserverBody
	return

/mob/observer/Move(NewLoc, direct)
	if(NewLoc)
		src.loc = NewLoc
		return
	if((direct & NORTH) && src.y < world.maxy)
		src.y++
	if((direct & SOUTH) && src.y > 1)
		src.y--
	if((direct & EAST) && src.x < world.maxx)
		src.x++
	if((direct & WEST) && src.x > 1)
		src.x--

/mob/observer/examine()
	if(usr)
		usr << src.desc

/mob/observer/proc/reenter_body()
	set category = "Admin"
	set name = "Re-enter Body"
	if(!body)
		alert("You don't have a body!")
		return
	if(src.client && src.client.holder && src.client.holder.state == 2)
		var/rank = src.client.holder.rank
		src.client.clear_admin_verbs()
		src.client.holder.state = 1
		src.client.update_admins(rank)
	src.client.mob = body
	del(src)