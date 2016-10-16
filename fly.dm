


/*

Event/Timer/Fly

	var/mob/player
	var/oldmob

	New(var/EventScheduler/scheduler, var/mob/D)
		..(scheduler, 12)
		src.player = D
		src.oldmob = D.name

	fire()
		..()

		//if(isnull(player)){log_errors("Fly Timer did not end properly, ending it now.");skills_scheduler.cancel(src);return} // Cancels itself when it has no player.
		if(isnull(player)){skills_scheduler.cancel(src);return}

		if(player.icon_state=="Flight")
			var/Cyber_Flight
			for(var/obj/Cybernetics/Antigravity/A in player)
				if(A.suffix)
					Cyber_Flight=1
					break

			if(!Cyber_Flight)
				if( ( player.Ki > round((2 + (player.MaxKi*0.5/player.FlySkill/player.KiMod))) ) && !player.afk)
					player.Flying_Gain()
					if(player.Super_Fly||player.Super_Fly==1)
						player.Ki -= round(18+((player.MaxKi*0.5)/((player.FlySkill/20)/player.KiMod)))
						if(player.FlySkill<(1000*player.FlyMod)) player.FlySkill += (0.6*player.FlyMod)

					else
						player.Ki -= round(2+((player.MaxKi*0.5)/(player.FlySkill/player.KiMod)),1.5)
						if(player.FlySkill<(1000*player.FlyMod)) player.FlySkill += (0.2*player.FlyMod)

				else
					player<< "You stop flying."
					player.Ki = max(0,player.Ki)	//don't want negatives
					player.Flight_Land()
					player = null

			else for(var/obj/Cybernetics/Generator/A in player)
				if(A.suffix)
					if(A.Current>=10)
						A.Current-=10

				else
					player<< "Your generator is drained."
					player.Flight_Land()
					player = null

		else
			player.Flight_Land()
			player = null

mob/var/tmp/Event/Timer/Fly/fly_event = null

obj/Fly
	Difficulty=3
	desc="Obviously this lets you fly. But it drains energy to do so. The more you use it the more you \
	master it, and the more you master it, the less it drains. Also you can decrease the drain to a \
	lesser level by simply gaining more energy, but the effect is not the same as mastering the move \
	itself. This will let you move much faster than you can by walking."
	var/tmp/Attempted

	verb/Fly()
		set category="Skills"
		for(var/obj/Cybernetics/Antigravity/A in usr) if(A.suffix) usr.Super_Fly=0

		if(usr.icon_state!="KO"&&usr.icon_state!="Train"&&usr.icon_state!="Meditate"&&!Attempted)
			if(usr.icon_state!="Flight")
				if(usr.Ki>=1+(usr.MaxKi*0.5/usr.FlySkill))

					if(isnull(usr.fly_event))
						usr.fly_event = new(skills_scheduler, usr)
						skills_scheduler.schedule(usr.fly_event, 12)

						usr.icon_state="Flight"
						usr.layer=MOB_LAYER+10

						if(usr.Super_Fly) usr.overlays+=usr.FlightAura

						if(usr.icon=='Demon6.dmi')
							overlays-=overlays
							overlays=usr.overlays
							usr.overlays-=usr.overlays

				else usr<<"You are too tired to fly."

			else usr.Flight_Land()

	verb/Super_Fly()
		set category="Other"
		for(var/obj/Cybernetics/Antigravity/A in usr) if(A.suffix)
			usr<<"Super flight cannot be enabled for cybernetic flight."
			return
		usr.Super_Fly=!usr.Super_Fly
		if(usr.Super_Fly) usr<<"Super flight activated for when flying"
		else usr<<"Super flight deactivated"

mob/proc/Flight_Land()

	if (src.fly_event)
		spawn(20) src.fly_event = null
		skills_scheduler.cancel(src.fly_event)

	density=1
	icon_state=""
	layer=MOB_LAYER
	overlays-=FlightAura
	for(var/obj/Fly/A in src) if(A.overlays) overlays+=A.overlays



// OLD FLY


mob/proc/Flight_Land()

	density=1
	if(src.icon_state!="KO") icon_state=""
	layer=MOB_LAYER
	overlays-=FlightAura
	for(var/obj/Fly/A in src)
		if(A.overlays) overlays+=A.overlays
		spawn(15) A.Flying=null
*/
mob/proc/Flight_Land()

	density=1
	if(src.icon_state!="KO") icon_state=""
	layer=MOB_LAYER
	overlays-=FlightAura
	for(var/obj/Fly/A in src)
		if(A.overlays) overlays+=A.overlays
		A.Flying=0

obj/Fly
	Difficulty=3
	desc="Obviously this lets you fly. But it drains energy to do so. The more you use it the more you \
	master it, and the more you master it, the less it drains. Also you can decrease the drain to a \
	lesser level by simply gaining more energy, but the effect is not the same as mastering the move \
	itself. This will let you move much faster than you can by walking."
	var/tmp/Flying
	var/tmp/Clicks = 0

	verb/Fly()
		set category="Skills"
		if(isobj(usr.loc))
			return
		if(usr.loc == locate(0,0,0))
			return
		for(var/obj/Cybernetics/Antigravity/A in usr) if(A.suffix) usr.Super_Fly=0

		if(usr.icon_state!="KO"&&usr.icon_state!="Train"&&usr.icon_state!="Meditate")
			if(usr.icon_state!="Flight"&&!Flying)
				if(usr.Ki>=1+(usr.MaxKi*0.5/usr.FlySkill))
					Clicks += 1
					usr.Flying_Loop(src)
					usr.icon_state="Flight"
					hearers(6,usr) << 'Flight Start.wav'
					usr.layer=MOB_LAYER+10

					if(usr.Super_Fly) usr.overlays+=usr.FlightAura

					if(usr.icon=='Demon6.dmi')
						overlays-=overlays
						overlays=usr.overlays
						usr.overlays-=usr.overlays

				else usr<<"You are too tired to fly."

			else
				hearers(6,usr) << 'groundhit.wav'
				usr.Flight_Land()

	verb/Super_Fly()
		set category="Other"
		for(var/obj/Cybernetics/Antigravity/A in usr) if(A.suffix)
			usr<<"Super flight cannot be enabled for cybernetic flight."
			return
		usr.Super_Fly=!usr.Super_Fly
		if(usr.Super_Fly) usr<<"Super flight activated for when flying"
		else usr<<"Super flight deactivated"

mob/var/tmp/fly_event = null // Does nothing, simply there to enable an easy return to the other flight system

mob/proc/Flying_Loop(var/obj/Fly/flySkillObj)
	if(flySkillObj)
		flySkillObj.Flying=1
		spawn(20)
			if(flySkillObj.Clicks >= 2)
				flySkillObj.Clicks -= 1
				return
			if(src&&(client||adminObserve))
				if(icon_state=="Flight"&&flySkillObj.Flying)
					var/Cyber_Flight
					for(var/obj/Cybernetics/Antigravity/A in src)
						if(A.suffix)
							Cyber_Flight=1
							return
					if(isobj(src.loc))
						flySkillObj.Clicks -= 1
						src<< "You stop flying."
						Ki = max(0,Ki)	//don't want negatives
						Flight_Land()
						return
					if(src.loc == locate(0,0,0))
						flySkillObj.Clicks -= 1
						src<< "You stop flying."
						Ki = max(0,Ki)	//don't want negatives
						Flight_Land()
						return
					if(!Cyber_Flight)
						if(Ki>2+(MaxKi*0.5/FlySkill/KiMod)&& afk == 0)  //&& client.inactivity<=3000
							Flying_Gain()
							if(Super_Fly)
								Ki -= 18+((MaxKi*0.5)/(FlySkill/20)/KiMod)
								if(FlySkill<(1000*FlyMod)) FlySkill += (0.6*FlyMod)

							else
								Ki -= 2+((MaxKi*0.5)/FlySkill/KiMod)
								if(FlySkill<(1000*FlyMod)) FlySkill += (0.2*FlyMod)

						else
							flySkillObj.Clicks -= 1
							src<< "You stop flying."
							Ki = max(0,Ki)	//don't want negatives
							Flight_Land()
							return
					else for(var/obj/Cybernetics/Generator/A in src)
						if(A.suffix)
							if(A.Current>=10)
								A.Current-=10
						else
							src<< "Your generator is drained."
							Flight_Land()
							return
				else
					Flight_Land()
					flySkillObj.Clicks = 0
					return
			src.Flying_Loop(flySkillObj)
	else
		return

/**mob/proc/Flying_Loop(var/obj/Fly/flySkillObj) - Disabled for testing, tried creating a better method. - Ginseng
	flySkillObj.Attempted=1
	while(src&&(client||adminObserve))
		sleep(20)
		if(icon_state=="Flight"&&flySkillObj.Attempted)
			var/Cyber_Flight
			for(var/obj/Cybernetics/Antigravity/A in src)
				if(A.suffix)
					Cyber_Flight=1
					break
			if(!Cyber_Flight)
				if(Ki>2+(MaxKi*0.5/FlySkill/KiMod)&& client.inactivity<=3000)  //&& client.inactivity<=3000
					Flying_Gain()
					if(Super_Fly)
						Ki -= 18+((MaxKi*0.5)/(FlySkill/20)/KiMod)
						if(FlySkill<(1000*FlyMod)) FlySkill += (0.6*FlyMod)

					else
						Ki -= 2+((MaxKi*0.5)/FlySkill/KiMod)
						if(FlySkill<(1000*FlyMod)) FlySkill += (0.2*FlyMod)

				else
					src<< "You stop flying."
					Ki = max(0,Ki)	//don't want negatives
					Flight_Land()
					break
			else for(var/obj/Cybernetics/Generator/A in src)
				if(A.suffix)
					if(A.Current>=10)
						A.Current-=10
				else
					src<< "Your generator is drained."
					Flight_Land()
					break
		else
			Flight_Land()
			break

mob/proc/Flying_Loop() while(src&&(client||adminObserve))
	sleep(20)
	if(icon_state=="Flight")
		var/Cyber_Flight
		for(var/obj/Cybernetics/Antigravity/A in src)
			if(A.suffix)
				Cyber_Flight=1
				break
		if(!Cyber_Flight)
			if(Ki>2+(MaxKi*0.5/FlySkill/KiMod) && client.inactivity<=3000)
				Flying_Gain()
				if(Super_Fly)
					Ki -= 18+((MaxKi*0.5)/(FlySkill/20)/KiMod)
					FlySkill += (0.6*FlyMod)
				else
					Ki -= 2+((MaxKi*0.5)/FlySkill/KiMod)
					FlySkill += (0.2*FlyMod)
			else
				usr << "You stop flying."
				Ki = max(0,Ki)	//don't want negatives
				Flight_Land()
		else for(var/obj/Cybernetics/Generator/A in src)
			if(A.suffix)
				if(A.Current>=10)
					A.Current-=10
			else
				usr << "Your generator is drained."
				Flight_Land()*/