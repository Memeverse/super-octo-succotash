Event/Timer/Focus

	var/mob/player

	New(var/EventScheduler/scheduler, var/mob/D)
		..(scheduler, 20)
		src.player = D

	fire()
		..() // Make sure we allow the /Event/Timer fire() to do it's thing.

		//if(isnull(player)){log_errors("Focus Timer did not end properly, ending it now.");skills_scheduler.cancel(src);return} // Cancels itself when it has no player.
		if(isnull(player)){skills_scheduler.cancel(src);return}

		//Focus
		if(player.Focus_Clicks > 2)
			player.Focus_Clicks -= 1
			return
		for(var/obj/Focus/A in player) if(A.Using)
			if(player.Ki>=(player.MaxKi*0.004)/player.Recovery/player.KiMod) player.Ki-=(player.MaxKi*0.004)/pick(1,player.Recovery)/player.KiMod
			else {player.Cancel_Focus();player=null}

mob/var/tmp/Event/Timer/Focus/focus_event = null
mob/var/tmp/Focus_Clicks = 0
mob/proc/Cancel_Focus()
	if (src.focus_event)
		skills_scheduler.cancel(src.focus_event)
		var/obj/O = src.focus_event
		del(O)
		//src.focus_event = null
	src.Focus_Revert()

obj/Focus
	Difficulty=10
	desc="Using this ability drains a constant amount of energy, the drain will be less depending on \
	your max energy and recovery. While using this your BP, Speed, Force, and Regeneration will all \
	increase by 50%, for as long as your energy holds out or you stop using the form."
	verb/Focus()
		set category="Skills"
		if(!Using)
			if(isnull(usr.focus_event))
				usr.focus_event = new(skills_scheduler, usr)
				skills_scheduler.schedule(usr.focus_event, 20)
				usr.Focus_Clicks += 1
				new/obj/largedust(usr.loc)
				Using=1
				view(usr)<<"[usr] begins focusing their energy"
				for(var/mob/player/M in view(usr)) if(M.client) M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] begins focusing their energy.\n")
				usr.overlays -= 'blue elec.dmi'
				usr.overlays += 'blue elec.dmi'
				usr.BP_Multiplier*=1.5
				usr.Spd*=1.5
				usr.SpdMod*=1.5
				usr.Pow*=1.5
				usr.PowMod*=1.5
				usr.Regeneration*=1.5
		else {usr.Cancel_Focus()}

mob/proc/Focus_Revert() for(var/obj/Focus/A in src) if(A.Using)
	A.Using=0
	view(src)<<"[src] stops focusing"
	for(var/mob/player/M in view(usr)) if(M.client) M.saveToLog("| ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] stops focusing their energy.\n")
	BP_Multiplier/=1.5
	Spd/=1.5
	SpdMod/=1.5
	Pow/=1.5
	PowMod/=1.5
	Regeneration/=1.5
	overlays -= 'blue elec.dmi'