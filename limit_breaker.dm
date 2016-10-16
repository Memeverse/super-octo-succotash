Event/Timer/LimitBreaker

	var/mob/player

	New(var/EventScheduler/scheduler, var/mob/D)
		..(scheduler, 20)
		src.player = D

	fire()
		..() // Make sure we allow the /Event/Timer fire() to do it's thing.

		if(isnull(player)){log_errors("LimitBreaker Timer did not end properly, ending it now.");skills_scheduler.cancel(src);return} // Cancels itself when it has no player.
		if(isnull(player)){skills_scheduler.cancel(src);return}

		//Limit Breaker
		for(var/obj/Limit_Breaker/A in player)
			if(A.Using)
				var/L = list("Random")
				player.Injure_Hurt(1,L)
			if(prob(1)) {player.Cancel_LimitBreaker();player=null}
		if(prob(1)&&player.Overdrive_Power)
			player.Overdrive_Power=0
			player.Health-=50
			for(var/obj/Cybernetics/Generator/G in player) if(G.suffix) G.Current=0
			player <<"<font color=red>System: Overdrive limit reached. Reactor is drained."
			player.Overdrive_Power=0
			player.Cancel_LimitBreaker()
			player=null

mob/var/tmp/Event/Timer/LimitBreaker/limitbreaker_event = null

mob/proc/Cancel_LimitBreaker()
	if (src.limitbreaker_event)
		skills_scheduler.cancel(src.limitbreaker_event)
		src.limitbreaker_event = null
	src.Limit_Revert()

obj/Limit_Breaker
	desc="Using this will double your power, force, regeneration, and recovery, for a random \
	period of time, at the end of which you will be knocked out. It is very powerful, but is a big \
	gamble on your chances of winning, or losing, a fight."
	icon='Burst.dmi'
	Difficulty=100
	Learnable = 0
	verb/Limit_Breaker()
		set category="Skills"
		if(!Using)

			if(isnull(usr.limitbreaker_event))
				usr.limitbreaker_event = new(skills_scheduler, usr)
				skills_scheduler.schedule(usr.limitbreaker_event, 20)

				Using=1
				usr.overlays+=icon
				usr.BP_Multiplier*=2
				usr.Pow*=1.2
				usr.PowMod*=1.2
				usr.Str*=1.2
				usr.StrMod*=1.2
				usr.Regeneration*=2
				usr.Recovery*=2
				usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] uses Limit Breaker.\n")

mob/proc/Limit_Revert() for(var/obj/Limit_Breaker/A in src) if(A.Using)
	A.Using=0
	overlays-=A.icon
	BP_Multiplier*=0.5
	Pow/=1.2
	PowMod/=1.2
	Str/=1.2
	StrMod/=1.2
	Regeneration*=0.5
	Recovery*=0.5
	src<<"You lose your energy and revert to your normal form."
	spawn KO("limit breaker")