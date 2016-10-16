
obj/Leave_Planet/verb/Leave_Planet(var/how as text)
	set category="Skills"
	if(!how)
		how = input("Describe yourself leaving the planet. You will leave the planet after one minute.") as text
	how = copytext(sanitize(how), 1, MAX_MESSAGE_LEN)
	if(!how)
		return
	view(usr) << "[src] [how]"
	usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] LEAVE_PLANET: [src] [how].\n")
	spawn(600)
		Liftoff(usr)

obj/Restore_Planet/verb/Restore_Planet()
	set category="Skills"
	var/list/Planets=new
	Planets.Add("Cancel","Earth","Namek","Vegeta","Arconia","Ice")
	switch(input("") in Planets)
		if("Cancel") return
		if("Earth") Planet_Restore(1)
		if("Namek") Planet_Restore(3)
		if("Vegeta") Planet_Restore(4)
		if("Arconia") Planet_Restore(8)
		if("Ice") Planet_Restore(12)

proc/Shockwave(mob/Origin,Range=7,Icon='Shockwave.dmi')
	for(var/turf/T in range(Range,Origin)) missile(Icon,Origin,T)

mob/proc/Screen_Shake(Amount=10,Offset=8) if(client)
	while(Amount)
		Amount-=1
		client.pixel_x=rand(-Offset,Offset)
		client.pixel_y=rand(-Offset,Offset)
		sleep(1)

turf/proc/Make_Damaged_Ground(Amount=1) if(!density&&!Water)
	while(Amount)
		Amount-=1
		var/image/I=image(icon='Damaged Ground.dmi',pixel_x=rand(-16,16),pixel_y=rand(-16,16))
		overlays+=I
		Remove_Damaged_Ground(I)

obj/Send_Energy
	var/tmp/Active
	verb/Send_Energy()
		set category="Skills"
		if(Active) Active=0
		else
			var/list/Choices=new
			Choices+="Cancel"
			for(var/mob/P in view(10,usr)) if(P.client&&P!=usr) Choices+=P
			var/mob/P=input(usr,"Choose who to send energy to") in Choices
			if(!P||P=="Cancel") return
			Active=1
			spawn while(P&&Active)
				missile('Spirit.dmi',usr,P)
				sleep(1)
			spawn while(P&&Active)
				if(usr.Ki>usr.MaxKi*0.01)
					usr.Ki-=usr.MaxKi*0.01
					P.Ki+=usr.MaxKi*0.01
				else
					Active = 0
				if(usr.Health>=10)
					usr.Health-=1
					P.Health++
				else
					Active = 0
				sleep(10)

