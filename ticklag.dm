
/client/proc/ticklag(number as num)
	set category = "Admin"
	set name = "Ticklag"
	set desc = "Ticklag"


	if(src.holder)
		if(!src.mob)
			return
		if(src.holder.rank in list("Coder", "Owner"))
			src << "World FPS is currently: [world.tick_lag]"
			switch(alert("You're about to change the world.tick_lag. This'll screw over the world FPS setting. Are you sure?",,"Yes","No"))
				if("Yes")
					number = max(1,number)	//No less then 1
					world.tick_lag = number
					log_admin("[key_name(src.mob)] set tick_lag to [number]")
					alertAdmins("[key_name_admin(usr)] modified world's tick_lag to [number]")
				else
					return
	else
		alertAdmins("[key_name_admin(usr)] tried to modify world's tick_lag and was \red REJECTED")
		log_admin("[key_name_admin(usr)] tried to modify world's tick_lag and was \red REJECTED")
		del(src)
		return


/client/proc/worldfps(number as num)
	set category = "Admin"
	set name = "WorldFPS"

	if(src.holder)
		if(!src.mob)
			return
		if(src.holder.rank in list("Coder", "Owner"))
			src << "World FPS is currently: [world.fps]"
			switch(alert("You're about to change the world.fps. Are you sure?",,"Yes","No"))
				if("Yes")
					//number = input("Select an FPS setting") in list(0,5,10,15,20,25,30,35)
					world.fps = number
					log_admin("[key_name(src.mob)] set world.fps to [number]")
					alertAdmins("[key_name_admin(usr)] modified world's FPS to [number]")
				else
					return
	else
		alertAdmins("[key_name_admin(usr)] tried to modify world's FPS and was \red REJECTED")
		log_admin("[key_name_admin(usr)] tried to modify world's FPS and was \red REJECTED")
		del(src)
		return
