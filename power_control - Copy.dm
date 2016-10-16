
Event/Timer/PowerControl
	var/mob/playerID  //Altered from var/mob/player to ensure there's no crossover in calls.  Something hinky is happening with null.var and this.
	var/mob/playerpower
//	var/ToPcnt
//	var/CurPcnt

	New(var/EventScheduler/scheduler, var/mob/D)  //Was var/mob, if issues occur change it back.  Is part of the null.var bug crap.  6/29/2013 update -  Changing back to var/mob due to issues at spawn(1) playerID.PC_Drain calls in this chunk of code.  Was var/mob/player/D
		..(scheduler, 20)
		src.playerID = D
		src.playerpower = src.playerID  //NULL VAR BUG CRASH FIX
//		src.ToPcnt = P
//		src.CurPcnt = C
	//		ASSERT(e)
		if(D.client)  //NULL VAR BUG FIX  -  Attempt to remove PC Drain calls.    Updated to add it back in -  2013 then taken out -  BACK IN AGAIN, WOOHOO 9/5/2013
			spawn(1) src.playerID.PC_Drain(src.playerpower,40) //NULL VAR BUG CRASH  Was src.player,40  |  Switched back to src.player due to mob call issues.
	//	else  //NULL VAR BUG FIX  -  Attempt to remove PC Drain calls.
	//		return  //NULL VAR BUG FIX  -  Attempt to remove PC Drain calls.

	fire()
		..()

//		if(isnull(playerID)){log_errors("PowerControl Timer did not end properly, ending it now.");skills_scheduler.cancel(src);return} // Cancels itself when it has no player. Updated to add it back in to remove null calls in errorlogs - 2013
		if(isnull(playerID)){skills_scheduler.cancel(src);return}
		if(playerID.icon_state=="KO"){playerID.Cancel_PowerControl();playerID<<"You are no longer able to hold your power";playerID=null;return}

		//Power Control
		for(var/obj/Power_Control/A in playerID.contents)
			if(playerID.icon_state=="KO"&&A.Powerup)
				A.Powerup=0
				playerID.AuraOverlays()
				playerID.Cancel_PowerControl(src)
				playerID=null
			if(A.Powerup&&A.Powerup!=-1)
				if(playerID.icon_state=="Meditate"&&playerID.BPpcnt>=99){playerID.BPpcnt=100;return}
				else playerID.BPpcnt += 1*playerID.Recovery
			else if(A.Powerup==-1) playerID.BPpcnt*=0.9

//			if(A.Powerup&&A.Powerup!=-1&&player.BPpcnt>=(CurPcnt+ToPcnt)) player.Cancel_PowerControl()
//			else if(A.Powerup==-1&&player.BPpcnt<=(CurPcnt-ToPcnt)) player.Cancel_PowerControl()

// Above 100% Drain

		if(playerID.icon_state!="KO"&&playerID.BPpcnt>100)
			var/Drain=1*(playerID.BPpcnt-100)/pick(1,playerID.Recovery)
			if(playerID.Ki>=Drain*10) playerID.Ki-=Drain
			else
				playerID.BPpcnt=100
				for(var/obj/Power_Control/A in playerID.contents) A.Powerup=0
				if(playerID.Race in list("Beastman","Saiyan","Half-Saiyan")) playerID.Cancel_Transformation()
				playerID << "You are too tired to hold the energy you gathered, your energy levels return to normal."
				playerID.Cancel_PowerControl()
				playerID = null

mob/var/tmp/Event/Timer/PowerControl/powercontrol_event = null

mob/proc/Cancel_PowerControl()
	if (src.powercontrol_event)
		skills_scheduler.cancel(src.powercontrol_event)
		src.powercontrol_event.playerID=null
		spawn src.AuraOverlays()
		src.powercontrol_event = null
		for(var/obj/Power_Control/A in src) A.Powerup=0
		src.PC_Drain(src)


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
		//for(var/mob/player/T)
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
					spawn usr.Power_Effects(src)

			else

				if(!usr.ssj&&usr.BP>usr.ssjat&&usr.SSjAble) usr.SSj()
				else if(usr.SSj2Able&&usr.ssj==1&&usr.BP>=usr.ssj2at&&usr.ssjdrain>=300) usr.SSj2()
				else if(!usr.ismystic&&usr.ssj==2&&usr.BP>=usr.ssj3at&&usr.hasssj3) usr.SSj3()
				usr.Changeling_Forms()
				usr.Bojack()
				usr.Ki_Burst()

		usr.AuraOverlays()
		usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] [Powerup ? "begins" : "stops"] powering up.<br>")


		/*	if(T.KaiokenBP||T.icon_state=="KO") return
			for(var/obj/Power_Control in src)
				switch(Powerup)
					if(-1)
						T<<"You stop powering down"
						Powerup=0
						usr.Cancel_PowerControl()

					if(0)

						if(isnull(T.powercontrol_event))

//					var/goalPcnt = input("How much do you want to power-up? In percentages. (i.e 50 = +50%)","Power up to?") as num
//					if(!goalPcnt||goalPcnt<1) return

							T.powercontrol_event = new(skills_scheduler, T)
							skills_scheduler.schedule(T.powercontrol_event, 20)

							Powerup=1
							T<<"You begin powering up"
							spawn T.Power_Effects(src)

					else

						if(!T.ssj&&T.BP>T.ssjat&&T.SSjAble) T.SSj()
						else if(T.SSj2Able&&T.ssj==1&&T.BP>=T.ssj2at&&T.ssjdrain>=300) T.SSj2()
						else if(!T.ismystic&&T.ssj==2&&T.BP>=T.ssj3at&&T.hasssj3) T.SSj3()
						T.Changeling_Forms()
						T.Bojack()
						T.Ki_Burst()

			T.AuraOverlays()
			T.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] [Powerup ? "begins" : "stops"] powering up.<br>")*/

/*  See below in power down for info on why this is here.

_______________________

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
					spawn usr.Power_Effects(src)

			else

				if(!usr.ssj&&usr.BP>usr.ssjat&&usr.SSjAble) usr.SSj()
				else if(usr.SSj2Able&&usr.ssj==1&&usr.BP>=usr.ssj2at&&usr.ssjdrain>=300) usr.SSj2()
				else if(!usr.ismystic&&usr.ssj==2&&usr.BP>=usr.ssj3at&&usr.hasssj3) usr.SSj3()
				usr.Changeling_Forms()
				usr.Bojack()
				usr.Ki_Burst()

		usr.AuraOverlays()
		usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] [Powerup ? "begins" : "stops"] powering up.<br>")
*/

	verb/Power_Down()
		set category="Skills"
		//for(var/mob/TL)
		if(usr.KaiokenBP||usr.icon_state=="KO") return

		switch(Powerup)

			if(-1) usr.Cancel_Transformation()

			if(1)
				Powerup=0
				usr<<"You stop powering up"
				usr.AuraOverlays()
				usr.Cancel_PowerControl()

			else

				if(isnull(usr.powercontrol_event))

//					var/goalPcnt = input("How much do you want to power-down? In percentages. (i.e 50 = +50%)","Power down to?") as num
//					if(!goalPcnt||goalPcnt<1) return


					usr.powercontrol_event = new(skills_scheduler, usr)
					skills_scheduler.schedule(usr.powercontrol_event, 20)

/*
This code was the original codeas of 1/28/2014.  I removed usr due to a bad mob runtime error listed below:

runtime error: BYOND Error: bad mob
proc name: fire (/Event/Timer/TrainTimer/fire)
  source file: train_verb.dm,25
  usr: null
  src: /Event/Timer/TrainTimer (/Event/Timer/TrainTimer)
  call stack:
/Event/Timer/TrainTimer (/Event/Timer/TrainTimer): fire()
/EventScheduler (/EventScheduler):   iteration()
/EventScheduler (/EventScheduler):   loop()
/EventScheduler (/EventScheduler): start()
PC Drain(Ryobi Ryukishi (/mob/player), 20)
PC Drain(Ryobi Ryukishi (/mob/player), 20)
PC Drain(Ryobi Ryukishi (/mob/player), 20)
PC Drain(Ryobi Ryukishi (/mob/player), 20)
PC Drain(Ryobi Ryukishi (/mob/player), 20)
PC Drain(Ryobi Ryukishi (/mob/player), 20)
...
PC Drain(Ryobi Ryukishi (/mob/player), 20)
PC Drain(Ryobi Ryukishi (/mob/player), 20)
PC Drain(Ryobi Ryukishi (/mob/player), 20)
PC Drain(Ryobi Ryukishi (/mob/player), 20)
PC Drain(Ryobi Ryukishi (/mob/player), 20)
PC Drain(Ryobi Ryukishi (/mob/player), 20)
PC Drain(Ryobi Ryukishi (/mob/player), 20)
PC Drain(Ryobi Ryukishi (/mob/player), 20)
Power Down()

Reinstall the code if this does not work at fixing that error.
if(isnull(usr.powercontrol_event))

//					var/goalPcnt = input("How much do you want to power-down? In percentages. (i.e 50 = +50%)","Power down to?") as num
//					if(!goalPcnt||goalPcnt<1) return


					usr.powercontrol_event = new(skills_scheduler, usr)
					skills_scheduler.schedule(usr.powercontrol_event, 20)*/

					Powerup=-1
					usr<<"You begin powering down"

		usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] [Powerup ? "begins" : "stops"] powering down.<br>")
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
	if(player==null) return
//	ASSERT(var/mob)  Removed 2013

//mob/proc/Cancel_PC_Drain

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
			if(player.Race in list("Beastman","Saiyan","Half-Saiyan")) player.Cancel_Transformation()
			player << "You are too tired to hold the energy you gathered, your energy levels return to normal."
			player.Cancel_PowerControl()
		//	player = null  NULL VAR BUG FIX  -  2013 -  Was temporarily removed.  Re-added to try and fix null scheduler assignments to NPC's.  Removed on 2014