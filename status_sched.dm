
//mob/var/tmp/Event/Timer/StatusTimer/status_event = null
/*
Event/Timer/StatusTimer
	var/mob/player
	var/EventScheduler/sched

	New(var/EventScheduler/scheduler, var/mob/M)
		..(scheduler, 12)
		src.player = M
		src.sched = scheduler

	fire()
		..()

		if(isnull(player)){sched.cancel(src);log_errors("Unable to shutdown StatusTimer, forcing it to stop.");return}

		if(player.client)

			player.Spd=player.SpdMod*10
			if(player.see_invisible>=player.invisibility&&!player.client.holder) player.see_invisible=player.invisibility

			//Taiyoken and Time Freeze
			if(player.sight&&prob(player.Regeneration)) player.sight=0

			//Escaping from Time Freeze
			if(player.Frozen&&prob(player.ResMod))
				player.Frozen=0
				player.overlays-='TimeFreeze.dmi'

			//Attack Gain
			if(player.Opp) player.nn()
			if(player.attacking==3) player.Blast_Gain()

			//Meditate / Healing
			if(player.Health<100|player.Ki<player.MaxKi)
				player.Healing()
			if(player.Health>100)
				player.Health=100

			//Return to Afterlife if you run out of energy in the living world
			player.Dead_In_Living_World()

			//Freezing weather
			player.Temperature_Check()

			//Gravity
			if(player.Gravity>player.GravMastered) player.Gravity_Gain()

			//KO
			if(player.Health<=0&&player.icon_state!="KO") player.KO("low health")

			// Health
			if(player.Ki>player.MaxKi) player.Ki*=0.998
			if(player.Health>100) player.Health*=0.998

			//Anger
			if(player.Anger>player.MaxAnger*2) player.Anger=player.MaxAnger*2
			if(player.Anger>100&&prob(0.1)) player.Calm()
			if(player.Health<=50&&!(player.icon_state in list("Meditate","Train","KO")))
				if(player.Last_Anger<=world.realtime-3000) player.Anger()

			//Weighted Clothing
			var/BaseWeight=1
			for(var/obj/items/Weights/A in player) if(A.suffix) BaseWeight+=A.Weight
			player.Weight=(BaseWeight/(player.Str+player.End))
			if(player.Weight<1) player.Weight=1
			if(BaseWeight>1+((player.Str+player.End)*2)&&player.icon_state!="KO") player.KO("wearing too heavy of weights")

			if(player.SpdMod<=0||!isnum(player.SpdMod)) player.SpdMod=1 // Sanity check
			if(player.Base<=0||!isnum(player.Base)) player.Base=1 // Sanity check

			player.Refire=((40/player.SpdMod)*player.Weight)/(player.Base/(player.Base+player.Roid_Power))

			//Available Power
			player.Available_Power()

		//else player.Cancel_Status_Scheduler()


mob/proc/Cancel_Status_Scheduler()
	if (src.status_event)
		status_scheduler.cancel(src.status_event)
		src.status_event = null
*/


mob/proc/Invisibility_Check()
	for(var/obj/Invisibility/A in src)
		if(locate(A) in src)
			if(A.Using) A.Using=0
			src.invisibility = 0
			src.see_invisible = 0

mob/proc/Time_Freeze_Check()
	if(isnum(src.Time_Frozen)||isnum(src.Frozen))
		if(src.Time_Frozen>1)
			if(!src) return
			src.Time_Frozen--
			src.overlays-='TimeFreeze.dmi'
			src.overlays+='TimeFreeze.dmi'
			sleep(10)
			.()
		else
			src.Frozen=null
			src.Time_Frozen=null
			src.overlays-='TimeFreeze.dmi'

mob/proc/Status()
	ASSERT(src)  // null bug check  May not be needed/may interrupt stat proc

//	spawn if(src) Experience_Transferrence()

	spawn if(src) Steroid_Wearoff()
	spawn if(src) Senzu_Wearoff()

//	spawn if(src) TrainingTimer()

	spawn if(src) Bind_Return()
	spawn if(src) Power_Giving_Reset()

	spawn if(src) Walking_In_Space()
	spawn if(src) Faction_Update()

	spawn if(src) if(Regenerating) Regenerate()

	spawn if(src) Poisoned_Check() // Checks if they're poisoned

	spawn if(src) Invisibility_Check()

	spawn if(src) Time_Freeze_Check()

	while(src&&(client||adminObserve||TestChar))
		src.Spd=src.SpdMod*10
		if(src.client)
			if(src.see_invisible>=src.invisibility&&!src.client.holder) src.see_invisible=src.invisibility

		//Taiyoken and Time Freeze
		if(src.Critical_Sight == 0) if(src.sight != (SEE_MOBS|SEE_OBJS|SEE_TURFS)) if(src.sight&&prob(src.Regeneration*2)) src.sight=0

		//Escaping from Time Freeze
//		if(src.Frozen&&prob(src.ResMod))
//			src.Frozen=0
//			src.overlays-='TimeFreeze.dmi'

		//src.RP_Points = round(src.RP_Points,0.0001)
		//src.RP_Earned = round(src.RP_Earned,0.0001)
		//src.RP_Total = round(src.RP_Total,0.0001)
		//Attack Gain
	//	for(var/mob/F)
	//		for(var/NPC_AI/T)
		if(src.Opp) src.Attack_Gain() //if(src.Opp)  -   Original pre-null bug code
		if(src.attacking==3) src.Blast_Gain()  //if(src.attacking)  -  Original pre-null bug code

		//Meditate / Healing
		if(src.Health<100||src.Ki<src.MaxKi)
			src.Healing()
		if(src.Health>100)
			src.Health=100
		if(src.Boost < 1)
			src.Boost = 1
		//Return to Afterlife if you run out of energy in the living world
		if(Dead) src.Dead_In_Living_World()

		//Freezing weather
		src.Temperature_Check()

		//Gravity
		if(src.Gravity>src.GravMastered) src.Gravity_Gain()
		if(src.Gravity <= 0)
			src.Gravity = 1
		src.GravMulti = src.GravMastered + src.Gravity
		if(src.GravMulti > 1)
			src.GravMulti/=30
		//KO
		if(src.Health<=0&&src.icon_state!="KO") src.KO("low health")

		// Health
		if(src.Ki>src.MaxKi) src.Ki*=0.998
		if(src.Health>100) src.Health*=0.998
		//RP Points
		var/Y = Year*50
		if(src.RP_Points > Y)
			src.RP_Points = Y
		if(src.RP_Rested > Y)
			src.RP_Rested = Y
		//Anger
		if(src.Anger>src.MaxAnger*2) src.Anger=src.MaxAnger*2
		//if(src.Anger>100&&prob(0.1)) src.Calm()
		if(src.icon_state in list("Meditate"))
			if(src.Anger > 100)
				src.Calm()
		else if(src.Health<=50) if(src.Anger<src.MaxAnger)
			//if(src.Last_Anger<=world.realtime-3000)
			src.Anger()
		//Weighted Clothing
		var/BaseWeight=1
		for(var/obj/items/Weights/A in contents) if(A.suffix) BaseWeight+=A.Weight
		src.Weight=(BaseWeight/(Str+End))
		if(src.Weight<1) src.Weight=1
		if(BaseWeight>1+((Str+End)*2)&&icon_state!="KO") src.KO("wearing too heavy of weights")

		if(SpdMod<=0||!isnum(SpdMod)) SpdMod=1 // Sanity check
		if(Base<=0||!isnum(Base)) Base=1 // Sanity check

		Refire=((40/SpdMod)*Weight)/(Base/(Base+Roid_Power))
	/*	src.Weight=(BaseWeight/(A.Str+src.End))
		if(src.Weight<1) src.Weight=1
		if(BaseWeight>1+((src.Str+src.End)*2)&&src.icon_state!="KO") src.KO("wearing too heavy of weights")

		if(src.SpdMod<=0||!isnum(src.SpdMod)) src.SpdMod=1 // Sanity check
		if(src.Base<=0||!isnum(src.Base)) src.Base=1 // Sanity check

		src.Refire=((40/src.SpdMod)*src.Weight)/(src.Base/(src.Base+src.Roid_Power))*/
//The above commented out code is the preferable code to use once Byond fixes the null.var bug.  As it currently is, using src.(var) creates massive issues in the program's interpreter or compiler.
		//Available Power
		src.Available_Power()

		sleep(15)
/*
	for (var/mob/player/M in world)
		if (src == M && src.client.address == M.client.address)
			M.Cancel_Status_Scheduler()
*/

	//var/EventScheduler/status_scheduler = new()
	//status_scheduler.start()

/*
	if(isnull(src.status_event))
		src.status_event = new(status_scheduler, src)
		status_scheduler.schedule(src.status_event, 12)
*/

/*
	while(src&&(client||adminObserve))
		Spd=SpdMod*10
		if(see_invisible>=101&&!client.holder) see_invisible=0

		//Majin capped powerup
		//if(Race=="Majin"&&BPpcnt>200) BPpcnt=200

		//Taiyoken and Time Freeze
		if(sight&&prob(Regeneration)) sight=0

		//Escaping from Time Freeze
		if(Frozen&&prob(ResMod))
			Frozen=0
			overlays-='TimeFreeze.dmi'

		//Attack Gain
		if(Opp) Attack_Gain()
		if(attacking==3) Blast_Gain()

		//Meditate / Healing
		if(Health<100|Ki<MaxKi)
			Healing()
		if(Health>100)
			Health=100

		//Return to Afterlife if you run out of energy in the living world
		Dead_In_Living_World()

		//Freezing weather
		Temperature_Check()

		//Gravity
		if(Gravity>GravMastered) Gravity_Gain()

/*
		//Super Saiyan Drain
		if(ssj==1|ssj==2)
			if(Ki>=MaxKi/ssjdrain)
				if(ssjdrain<300)
					if(!ismystic) Ki-=0.5*(MaxKi/ssjdrain)
					if(Class!="Legendary")
						ssjdrain+=0.01*ssjmod
						if(z==10) ssjdrain+=0.09*ssjmod
				if(Ki<=MaxKi/10&&ssjdrain<300)
					Revert()
					src<<"You are too tired to sustain your form."

		//Super Saiyan 2 Drain
		if(ssj==2&&Ki>=MaxKi/ssj2drain)
			if(ssj2drain<300)
				if(!ismystic) Ki-=0.5*(MaxKi/ssj2drain)
				ssj2drain+=0.01*ssj2mod
				if(z==10) ssj2drain+=0.09*ssjmod
			if(Ki<=(MaxKi/10))
				Revert()
				src<<"You are too tired to sustain your form."
			if(!ismystic) Ki-=MaxKi/300

		//Super Saiyan 3 Drain
		if(ssj==3&&Ki+1>=MaxKi/ssj3drain)
			if(ssj3drain<300)
				Ki-=0.5*(MaxKi/ssj3drain)
				ssj3drain+=0.01*ssj3mod
				if(z==10) ssj3drain+=0.09*ssjmod
			if(Ki<=(MaxKi/5))
				Revert()
				src<<"You are too tired to sustain your form."
			Ki-=MaxKi/200
*/

		//KO
		if(Health<=0&&icon_state!="KO") spawn KO("low health")

/*
		//Focus
		for(var/obj/Focus/A in src) if(A.Using)
			if(Ki>=(MaxKi*0.004)/Recovery/KiMod) Ki-=(MaxKi*0.004)/pick(1,Recovery)/KiMod
			else Focus_Revert()
*/

		if(Ki>MaxKi) Ki*=0.998
		if(Health>100) Health*=0.998

		//Anger
		if(Anger>MaxAnger*2) Anger=MaxAnger*2
		if(Anger>100&&prob(0.1)) Calm()
		if(Health<=50&&!(icon_state in list("Meditate","Train","KO")))
			if(Last_Anger<=world.realtime-3000) Anger()

/*
		//Limit Breaker
		if(prob(2)) for(var/obj/Limit_Breaker/A in src) if(A.Using) Limit_Revert()
		if(prob(2)&&Overdrive_Power)
			Overdrive_Power=0
			Health-=50
			for(var/obj/Cybernetics/Generator/G in src) if(G.suffix) G.Current=0
			src<<"<font color=red>System: Overdrive limit reached. Reactor is drained."
*/

		//Weighted Clothing
		var/BaseWeight=1
		for(var/obj/items/Weights/A in src) if(A.suffix) BaseWeight+=A.Weight
		Weight=(BaseWeight/(Str+End))
		if(Weight<1) Weight=1
		if(BaseWeight>1+((Str+End)*2)&&icon_state!="KO") spawn KO("wearing too heavy of weights")

		if(SpdMod<=0||!isnum(SpdMod)) SpdMod=1 // Sanity check
		if(Base<=0||!isnum(Base)) Base=1 // Sanity check

		Refire=((40/SpdMod)*Weight)/(Base/(src.Base+Roid_Power))

		//Available Power
		Available_Power()
		sleep(12)
*/




/*
Test code for an alternate way to handle null.var.  Not complete.

		for(var/mob/player/G)
			G.Weight=(BaseWeight/(G.Str+G.End))
			if(G.Weight<1) G.Weight=1
			if(BaseWeight>1+((G.Str+G.End)*2)&&G.icon_state!="KO") G.KO("wearing too heavy of weights")

			if(G.SpdMod<=0||!isnum(G.SpdMod)) G.SpdMod=1 // Sanity check
			if(G.Base<=0||!isnum(G.Base)) G.Base=1*/ // Sanity check