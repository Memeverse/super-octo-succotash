
Event/Timer/PowerControl
	var/mob/player
//	var/ToPcnt
//	var/CurPcnt

	New(var/EventScheduler/scheduler, var/mob/D)
		..(scheduler, 20)
		src.player = D
//		src.ToPcnt = P
//		src.CurPcnt = C
		spawn(1) player.PC_Drain(src.player,40)

	fire()
		..() // Make sure we allow the /Event/Timer fire() to do it's thing.

		//if(isnull(player)){log_errors("PowerControl Timer did not end properly, ending it now.");skills_scheduler.cancel(src);return} // Cancels itself when it has no player.
		if(isnull(player)){skills_scheduler.cancel(src);return}
		if(player.icon_state=="KO"){player.Cancel_PowerControl();player<<"You are no longer able to hold your power";player=null;return}

		//Power Control
		//spawn(5) hearers(6,player) << 'Power_Control_Continuous.wav'
		for(var/obj/Power_Control/A in player.contents)
			if(player.icon_state=="KO"&&A.Powerup)
				A.Powerup=0
				player.AuraOverlays()
				player.Cancel_PowerControl(src)
				player=null
			if(A.Powerup&&A.Powerup!=-1)
				if(player.icon_state=="Meditate"&&player.BPpcnt>=99){player.BPpcnt=100;return}
				else player.BPpcnt += 1*player.Recovery
			else if(A.Powerup==-1) player.BPpcnt*=0.9

//			if(A.Powerup&&A.Powerup!=-1&&player.BPpcnt>=(CurPcnt+ToPcnt)) player.Cancel_PowerControl()
//			else if(A.Powerup==-1&&player.BPpcnt<=(CurPcnt-ToPcnt)) player.Cancel_PowerControl()

// Above 100% Drain

		if(player.icon_state!="KO"&&player.BPpcnt>100)
			var/Drain=1*(player.BPpcnt-100)/pick(1,player.Recovery)
			if(player.Ki>=Drain*10) player.Ki-=Drain
			else
				player.BPpcnt=100
				for(var/obj/Power_Control/A in player.contents) A.Powerup=0
				if(player.Race in list("Saiyan","Half-Saiyan","Alien")) player.Cancel_Transformation()
				player << "You are too tired to hold the energy you gathered, your energy levels return to normal."
				player.Cancel_PowerControl()
				player = null

mob/var/tmp/Event/Timer/PowerControl/powercontrol_event = null

mob/proc/Cancel_PowerControl()
	if (src.powercontrol_event)
		skills_scheduler.cancel(src.powercontrol_event)
		src.powercontrol_event.player=null
		spawn src.AuraOverlays()
		src.powercontrol_event = null
		for(var/obj/Power_Control/A in src) A.Powerup=0
		if(src) src.PC_Drain(src)


obj/Power_Control
	Difficulty=5
	desc="This allows you to power up and power down. Also, for certain forms, such as those of \
	Saiyans and Changelings, powering up twice will cause them to go into their next form, powering \
	down twice will cause them to revert. Powering up will increase your Battle Power, but drain your \
	energy the higher you go. The more energy you have the higher you can power up without worrying \
	about the drain sucking you back down again."
	var/Powerup=0
	verb/Power_Up()
		set category="Skills"
		if(usr.KaiokenBP||usr.icon_state=="KO") return
		switch(Powerup)
			if(-1)
				usr<<"You stop powering down"
				Powerup=0
				usr.Cancel_PowerControl()

			if(0)
				if(isnull(usr.powercontrol_event))

//					var/goalPcnt = input("How much do you want to power-up? In percentages. (i.e 50 = +50%)","Power up to?") as num
//					if(!goalPcnt||goalPcnt<1) return

					usr.powercontrol_event = new(skills_scheduler, usr)
					skills_scheduler.schedule(usr.powercontrol_event, 20)

					Powerup=1
					usr<<"You begin powering up"
					hearers(6,usr) << 'Power_Control_Start.wav'
					new/obj/largedust(usr.loc)
					spawn usr.Power_Effects(src)

			else

				if(!usr.ssj&&usr.Hasssj > 0) usr.SSj()
				else if(usr.Hasssj > 1&&usr.ssj == 1&&usr.ssjdrain>=300) usr.SSj2()
				else if(!usr.ismystic&&usr.ssj == 2&&usr.Hasssj > 2) usr.SSj3()
				usr.Changeling_Forms()
				usr.Bojack()
				usr.Ki_Burst()
				usr.Hybrid()

		usr.AuraOverlays()
		usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] [Powerup ? "begins" : "stops"] powering up.\n")

	verb/Power_Down()
		set category="Skills"
		if(usr.KaiokenBP||usr.icon_state=="KO") return

		switch(Powerup)

			if(-1) usr.Cancel_Transformation()

			if(1)
				Powerup=0
				usr<<"You stop powering up"
				hearers(6,usr) << 'Power_Control_Stop.wav'
				usr.AuraOverlays()
				usr.Cancel_PowerControl()

			else

				if(isnull(usr.powercontrol_event))

//					var/goalPcnt = input("How much do you want to power-down? In percentages. (i.e 50 = +50%)","Power down to?") as num
//					if(!goalPcnt||goalPcnt<1) return


					usr.powercontrol_event = new(skills_scheduler, usr)
					skills_scheduler.schedule(usr.powercontrol_event, 20)

				Powerup=-1
				usr<<"You begin powering down"

		usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] [Powerup ? "begins" : "stops"] powering down.\n")
		usr.AuraOverlays()

mob/proc/Power_Effects(obj/Power_Control/A) while(A.Powerup>=1)
	var/Sleep=1600
	if(BP>1000) Sleep=800
	if(BP>10000) Sleep=400
	if(BP>100000) Sleep=200
	if(BP>1000000) Sleep=100
	if(BP>10000000) Sleep=50
	for(var/turf/B in range(10,src)) if(prob(5)&&A.Powerup>=1)
		B.Rising_Rocks()
		sleep(Sleep*0.1)
	sleep(Sleep)

mob/proc/PC_Drain(var/mob/player,var/sleeptime=20)

	var/obj/Power_Control/_powcontrol

	for(var/obj/Power_Control/A in player.contents)
		_powcontrol = A
		break

	sleep(sleeptime)
	if(player.icon_state!="KO"&&player.BPpcnt>100&&(_powcontrol.Powerup==0||isnull(_powcontrol.Powerup)) )
		var/Drain=1*(player.BPpcnt-100)/pick(1,player.Recovery)
		if(player.Ki>=Drain*10)
			player.Ki-=Drain
			.() // It calls itself again
		else
			player.BPpcnt=100
			for(var/obj/Power_Control/A in player.contents) A.Powerup=0
			if(player.Race in list("Saiyan","Half-Saiyan","Alien")) player.Cancel_Transformation()
			player << "You are too tired to hold the energy you gathered, your energy levels return to normal."
			player.Cancel_PowerControl()
			player = null