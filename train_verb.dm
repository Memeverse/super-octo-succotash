mob
	Del() // Makes it so any mob, including NPC, execute the following commands when deleted from the game world.
	//	if(src.client) // Check if it's a player.
		src.Cancel_Training() // Checks if the player was training upon deletion, and if they were, removes that task from the scheduler.
		src.Cancel_PowerControl()
		src.Stop_TrainDig_Schedulers()

		src.Cancel_Transformation() // SSJ Transformations
		src.Cancel_Focus()
		src.Cancel_Expand()
		src.Cancel_LimitBreaker()
		src.Cancel_Kaioken()
		src.Flight_Land()
		sleep(1)
			//Add the other Cancel() proc's here, like Cancel_Digging() for example.
		..()
//The isnull med timer bug probably initiates from fixing stack bugs.  Check it out when I have a chance. - 10/6/2013
Event/Timer/TrainTimer
	var/tmp/mob/trainer
	var/id

	New(var/EventScheduler/scheduler, var/mob/player/D, var/_id)
		src.trainer = D
		src.id = _id
		if(trainer.training_event) // If they spammed a macro to spam hundreds of triggers, let's spam them back in turn.
			trainer << "<span class=announce>SYSTEM: Multiple training instances found. Canceling your current actions. (macro spam?)</span>"
			trainer.Cancel_Training()
			return

		..(scheduler, 12)

	fire()
		..()

		//if(isnull(trainer)){training_scheduler.cancel(src);log_errors("Unable to shutdown TrainTimer, forcing it to stop.");return} // Cancels itself when it has no trainer.
		if(isnull(trainer) || isnull(trainer.client)) {training_scheduler.cancel(src);return} // if trainer has no client then the player is no longer logged in
		if(id!=trainer.training_id){training_scheduler.cancel(src);return} // if the id the player has mismatches the id for the scheduled event, the event will cancel.
		if(isnull(trainer.training_event) ){trainer.Cancel_Training();return}

		if(trainer.icon_state=="Train"&&trainer.Ki>=(1/trainer.Recovery)*(trainer.Weight**3))
			trainer.Ki-=(1/trainer.Recovery)*(trainer.Weight**3)
			var/L = list()
			var/Wound = 0
			if(trainer.Critical_Head)
				L += ("Head")
				Wound = 1
			if(trainer.Critical_Torso)
				L += ("Torso")
				Wound = 1
			if(trainer.Critical_Left_Arm)
				L += ("Left Arm")
				Wound = 1
			if(trainer.Critical_Right_Arm)
				L += ("Right Arm")
				Wound = 1
			if(trainer.Critical_Left_Leg)
				L += ("Left_Leg")
				Wound = 1
			if(trainer.Critical_Right_Leg)
				L += ("Right Leg")
				Wound = 1
			if(Wound)
				trainer.Injure_Hurt(0.001,L)
			if(trainer.z==10) trainer.Ki-=9*(1/trainer.Recovery)*(trainer.Weight**3)

			var/HBTC=1
			if(trainer.z==10) HBTC=10
			var/N = 2 + trainer.GravMulti
			trainer.Base+= N*GG*trainer.BPMod*trainer.Weight*HBTC*(trainer.BPRank/2)*trainer.Gain_Multiplier*trainer.Boost
			trainer.MaxKi+=0.001*trainer.KiMod*trainer.Boost
			if(trainer.pfocus=="Balanced")// Added *TESTGAIN for the test server
				if(prob(10)) trainer.Str+=0.03*trainer.StrMod*trainer.Boost
				if(prob(10)) trainer.End+=0.03*trainer.EndMod*trainer.Boost
			else if(trainer.pfocus=="Strength") if(prob(10)) trainer.Str+=0.05*trainer.StrMod*trainer.Boost
			else if(trainer.pfocus=="Endurance") if(prob(10)) trainer.End+=0.05*trainer.EndMod*trainer.Boost
			if(prob(10)) trainer.Spd+=0.017*trainer.SpdMod
			trainer.Increase_Gain_Multiplier(1)

/*
		else if( icon_state=="Flight"|| icon_state=="Meditate"|| icon_state=="KO"|| attacking )
			training_scheduler.cancel(src)
			player.training_event = null
*/

		else
			trainer.Cancel_Training()
			//trainer << "You stop training."
			trainer=null
			/*
			* Trainer=null Is a dirty trick intent to make sure \
			* the proc actually shuts down when you're KO'd.
			* Else it'll wait until you're back up until it actually STOPS the proc.
			*/

mob/var/tmp/Event/Timer/TrainTimer/training_event = null

mob/proc/Cancel_Training() // Cancel training is used for both meditating AND training.

	if(!istype(src,/mob/player)) return
	if (src.training_event)
		training_scheduler.cancel(src.training_event)
		spawn(20) src.training_event = null

	if( src.icon_state=="Flight" || src.icon_state=="KO" || src.attacking ) return
	else
		src.icon_state = ""
		src.move=1
	training_id=null

mob/verb/Train()
	set category="Skills"
	if( icon_state=="Flight"|| icon_state=="Meditate"|| icon_state=="KO"|| icon_state=="KB"|| attacking ) return

	if(ghostDens_check())
		src << "You're currently in Ghost Form. Disable it first."
		return

	if(isnull(src.training_event))
		if(isnull(src.meditating_event)&&isnull(usr.fly_event)) // This is just so the 'you stop training' shit doesnt show when it's still waiting to cancel and/or meditate.

			if(icon_state!="Train"&&Ki>=1&&move)
				dir=SOUTH
				icon_state="Train"
				training_id="[src][world.realtime][rand()]"
				src.training_event = new(training_scheduler, src, training_id)
				training_scheduler.schedule(src.training_event, 12)


/*
		for (var/mob/player/M in world)
			if (src != M && src.client.address == M.client.address)
				M.Cancel_Training()
*/

	else
		Cancel_Training()
		src << "You stop training."
		sleep(30)