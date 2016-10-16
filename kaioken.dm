Event/Timer/Kaioken

	var/mob/player

	New(var/EventScheduler/scheduler, var/mob/D)
		..(scheduler, 20)
		src.player = D

	fire()
		..() // Make sure we allow the /Event/Timer fire() to do it's thing.

		//if(isnull(player)){log_errors("Kaioken Timer did not end properly, ending it now.");skills_scheduler.cancel(src);return} // Cancels itself when it has no player.
		if(isnull(player)){skills_scheduler.cancel(src);return}

		//Kaioken
		if(player.KaiokenBP)
			var/BP = player.Base/10
			//var/Amount = player.KaiokenBP/1000/player.Kaioken/player.BPMod/player.KaiokenMod
			var/Amount = player.KaiokenBP/BP/player.Kaioken/player.BPMod/player.KaiokenMod

			/*
			* Translates to the Amount you are using.
			* So if you have 3x mastered, and use 6x, and have 2 bp mod.
			* Your Kaioken bp is 1000 x 2 x 3 x 6, or +36'000.
			* So to to get the answer it is 36000 / 1000 / 3 / 2 = 6. Meaning your using 6x.
			*/

			if(player.Health>0)
				var/dmg = 0.15*((Amount/player.Kaioken)**3.5)
				player.Health-=dmg //The amount your using divided by your mastery of Kaioken.
				dmg/=4
				var/L = list("Random")
				player.Injure_Hurt(dmg,L)
				if(player.Kaioken<Amount) player.Kaioken+=Amount*0.001*player.KaiokenMod
				if(player.Kaioken>20) player.Kaioken=20
				if(player.Kaioken<Amount) player.Kaioken_Gain()
			if(player.Health<=0)
				player << "The energies flowing through your body are too much for you."
				//if(Amount>player.Kaioken*2)
					//if(!player.Dead) player.Body_Parts()
					//spawn player.Death("")
				player.Cancel_Kaioken()
		else
			player.Cancel_Kaioken()
			player=null

mob/var/tmp/Event/Timer/Kaioken/kaioken_event = null

mob/proc/Cancel_Kaioken()
	if (src.kaioken_event)
		skills_scheduler.cancel(src.kaioken_event)
		src.kaioken_event = null
		src.KaiokenRevert()

mob/proc/Kaioken_Gain() Gain_Multiplier+=gainget*10

obj/Kaioken
	desc="Kaioken is a masterable skill. The more past your mastery you use the faster you \
	master it. Kaioken can only be set to a maximum of 20, but you can master beyond 20. But since \
	your mastery past that is ever-higher than the max amount you can use, your mastery slows \
	further and further past 20. The amount of power you gain per level depends on your mastery, \
	that is why mastering it is important, a person with 1x mastery using 1x will get about 1000 \
	power, a person with 20 mastered who uses 1x will get about 20000 power for instance. Kaioken \
	will drain your health when using it, you can decrease the amount it drains \
	by mastering it further, but each level adds more drain to be mastered. While in Kaioken, not \
	only will your power increase, but your movement speed will also greatly increase, but you will \
	lose a lot of defense as well. Also while using this your combo chance will automatically go \
	to 100%, despite what it is when your not using Kaioken. Using more than double your mastery and \
	running out of health will kill you"
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(A,2000,-1000)
	verb/Kaioken()
		set category="Skills"
		if(usr.KaiokenBP) usr.Cancel_Kaioken()
		else if(!usr.KaiokenBP&&usr.icon_state!="KO")
			for(var/obj/Power_Control/A in usr) if(A.Powerup) return
			if(usr.ssj&&usr.BP<100000000&&usr.ssjdrain<300)
				usr<<"To use this in a Super Saiyan form you must have more than 100'000'000 bp in the form and have \
				Super Saiyan mastered."
				return
			var/amount=input("Kaioken multiple. (You have Kaioken x[round(usr.Kaioken)] mastered). x20 is the maximum ever.") as num
			if(amount<1) amount=1
			if(amount>20) amount=20
			if(usr.Dead)
				if(amount>1)
					amount = amount / 2
				usr << "You can only gain half as much Kaioken power while dead."
			amount=round(amount)
			if(!usr.KaiokenBP)
				if(amount>usr.Kaioken*0.5)
					usr.overlays+=/obj/Auras_Special/Kaioken
					view(usr)<<"A bright red aura focuses around [usr]."
					for(var/mob/player/M in view(usr)) if(M.client) M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | A bright red aura focuses around [key_name(usr)]\n")
				else usr<<"You begin using Kaioken, an aura does not appear because this level of kaioken is effortless to you."
				usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] uses Kaioken.\n")
				var/BP = usr.Base/10
				usr.KaiokenBP=BP*amount*usr.BPMod*usr.KaiokenMod
				usr.Spd*=2
				usr.SpdMod*=2
				usr.Def/=1.25
				usr.DefMod/=1.25
				usr.Zanzoken+= 1000

				if(isnull(usr.kaioken_event))
					usr.kaioken_event = new(skills_scheduler, usr)
					skills_scheduler.schedule(usr.kaioken_event, 20)

mob/proc/KaiokenRevert() if(KaiokenBP)
	src<<"You stop using Kaioken."
	KaiokenBP=0
	Spd*=0.5
	SpdMod*=0.5
	Def*=1.25
	DefMod*=1.25
	Zanzoken-=1000
	overlays-=/obj/Auras_Special/Kaioken

mob/proc/Body_Parts()
	var/Amount=10
	var/list/Turfs=new
	for(var/turf/A in view(src)) if(!A.density) Turfs+=A
	while(Amount&&Turfs)
		if(locate(/turf) in Turfs)
			var/obj/Body_Part/A=new
			A.name="[src] chunk"
			A.loc=pick(Turfs)
			Amount-=1
			break
		else return

obj/Body_Part
	icon='Body Parts.dmi'
	Savable=0
	New()
		spawn(rand(2000,4000)) del(src)
		pixel_y+=rand(-16,16)
		pixel_x+=rand(-16,16)
		dir=pick(NORTH,SOUTH,EAST,WEST,NORTHEAST,SOUTHEAST,NORTHWEST,SOUTHWEST)
		//..()