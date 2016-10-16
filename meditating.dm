Event/Timer/MedTimer
	var/tmp/mob/trainer
	var/id

	New(var/EventScheduler/scheduler, var/mob/player/D, var/_id)
		src.trainer = D
		src.id = _id
		if(trainer.meditating_event) // If they spammed a macro to spam hundreds of triggers, let's spam them back in turn.
			trainer << "<span class=announce>SYSTEM: Multiple meditate instances found. Canceling your current actions. (macro spam?)</span>"
			trainer.Cancel_Meditation()
			return

		..(scheduler, 12)

	fire()
		..()

		//if(isnull(trainer)){training_scheduler.cancel(src);log_errors("Unable to shutdown MedTimer, forcing it to stop.");return} // Cancels itself when it has no trainer.
		if(isnull(trainer) || isnull(trainer.client)){training_scheduler.cancel(src);return}
		if(id!=trainer.training_id && id!="reward"){training_scheduler.cancel(src);return} // if the id the player has mismatches the id for the scheduled event, the event will cancel.
		if(isnull(trainer.meditating_event) ){trainer.Cancel_Meditation();return}

		if(trainer.icon_state=="Meditate"||trainer.medreward||trainer.medrewardmagic)

			if(trainer.ifocus)
				trainer.Int_XP+=200*Admin_Int_Setting
				trainer.MaxKi+=0.0015*trainer.KiMod
				if(trainer.Int_Level_Up_Check(trainer.Int_XP))
					trainer.Int_Level_Up()
					trainer.refreshTechWindow()
					//if(trainer.Int_Level>=30&&!(locate(/obj/Cyberize) in trainer))
						//trainer << "You now have the ability to cyberize people.";trainer.contents+=new/obj/Cyberize
						//trainer.saveToLog("[trainer] unlocked cyberize!")
			else if(trainer.magicfocus)
				trainer.Magic_XP+=200*Admin_Int_Setting
				trainer.MaxKi+=0.0015*trainer.KiMod
				var/obj/Book
				var/obj/Circle
				for(var/obj/items/Spell_Book/B in trainer)
					Book = B
				for(var/obj/items/Magic_Circle/C in range(2,trainer))
					Circle = C
				for(var/obj/Mana/A in trainer)
					A.Value+=10
					if(Book)
						A.Value += 10
					if(Circle)
						A.Value += 20
				if(trainer.Magic_Level_Up_Check(trainer.Magic_XP))
					trainer.Magic_Level_Up()
					trainer.refreshMagicWindow()
					if(trainer.Magic_Level>=60&&!(locate(/obj/Telekinesis_Magic) in trainer))
						trainer << "Through dedicated study of the arcane, you have unlocked the ability to move objects via magic. Click and drag items and people to move them. Each movement will cost mana."
						trainer.saveToLog("[trainer] unlocked the ability to move objects via mana!")
						trainer.contents+=new/obj/Telekinesis_Magic
			if(trainer.ifocus == 0) if(trainer.magicfocus == 0)
				var/HBTC=1
				if(trainer.z==10) HBTC=10
				trainer.Increase_Gain_Multiplier(1)
				var/N = 15 + trainer.GravMulti
				trainer.Base+=N*GG*trainer.BPMod*HBTC*trainer.Gain_Multiplier*trainer.Boost
				if(prob(1)) trainer.MedSkills()
				if(trainer.sfocus=="Balanced")
					if(prob(10)) trainer.Pow+=0.03*trainer.PowMod*trainer.Boost
					if(prob(10)) trainer.Res+=0.03*trainer.ResMod*trainer.Boost
				else if(trainer.sfocus=="Force") if(prob(10)) trainer.Pow+=0.025*trainer.PowMod*trainer.Boost
				else if(trainer.sfocus=="Resistance") if(prob(10)) trainer.Res+=0.05*trainer.ResMod*trainer.Boost
				if(prob(10)) trainer.Spd+=0.017*trainer.SpdMod


			// If they're being rewarded.
			if(trainer.medreward>0)
				trainer.medreward-- // Medreward determines how many levels are left
				trainer.Int_XP = Int_Difficulty*(trainer.Int_Next/trainer.Add)
			else if(trainer.medrewardmagic>0)
				trainer.medrewardmagic-- // Medreward determines how many levels are left
				trainer.Magic_XP = Magic_Difficulty*(trainer.Magic_Next/trainer.Magic_Potential)
			else if(!trainer.magicfocus&&!trainer.ifocus&&trainer.medreward<1&&trainer.medrewardmagic<1) // If they're NOT being rewarded they should be gaining stats.
				trainer.MaxKi+=0.003*trainer.KiMod*trainer.Boost
				if(prob(0.01*(trainer.KiMod+trainer.Recovery))) trainer.Decline+=0.2*Year_Speed
				if(trainer.BPpcnt>100)
					trainer.BPpcnt-=trainer.Recovery
					if(trainer.BPpcnt<100) trainer.BPpcnt=100

			if(trainer.icon_state=="Meditate"&&trainer.BPpcnt>=101){trainer.BPpcnt=100;return}
			if(trainer.Ki<trainer.MaxKi) // Ki regeneration while meditating
				trainer.Ki+=0.02*trainer.MaxKi*trainer.Recovery*(1+trainer.Senzu)*(trainer.Base/(trainer.Base+(trainer.Absorb*2)+(trainer.Roid_Power*2)))
				if(trainer.Ki>trainer.MaxKi) trainer.Ki=trainer.MaxKi

		else
			trainer.Cancel_Meditation()
			trainer=null

mob/var/tmp/Event/Timer/MedTimer/meditating_event = null

mob/proc/Cancel_Meditation()

	if(!istype(src,/mob/player)) return
	if(src.meditating_event)
		training_scheduler.cancel(src.meditating_event)
		spawn(20) src.meditating_event = null

	if( src.icon_state=="Flight" || src.icon_state=="KO" || src.attacking ) return
	else
		src.icon_state = ""
		src.move=1

	training_id=null

var/Int_Difficulty=40
var/Magic_Difficulty=40
mob/proc/Int_Level_Up_Check(IntXP) if(IntXP>Int_Difficulty*(Int_Next/Add)) return 1
mob/proc/Magic_Level_Up_Check(MagXP) if(MagXP>Magic_Difficulty*(Magic_Next/Magic_Potential)) return 1
mob/proc/Int_Level_Up() //while(Int_Level_Up_Check(Int_XP)) // I've uncommented the while as it makes no sense to keep leveling while it returns 1. \
							They should just meditate for this and Meditate actively checks IF they've leveled up assuming they're focused on intelligence.
	var/ADD = src.Add
	if(src.Critical_Head)
		ADD = src.Add*2
	Int_XP-=Int_Difficulty*(Int_Next/ADD)
	Int_Next=round(Int_Next*1.03)
	Int_Level++
mob/proc/Magic_Level_Up() //while(Int_Level_Up_Check(Int_XP)) // I've uncommented the while as it makes no sense to keep leveling while it returns 1. \
							They should just meditate for this and Meditate actively checks IF they've leveled up assuming they're focused on intelligence.
	var/POTENT = src.Magic_Potential
	if(src.Critical_Head)
		POTENT = src.Magic_Potential*2
	Magic_XP-=Magic_Difficulty*(Magic_Next/POTENT)
	Magic_Next=round(Magic_Next*1.03)
	Magic_Level++

mob/proc/MedSkills()
	/*if(MaxKi>=1000) if(!(locate(/obj/Observe) in src))
		src<<"You can now observe people psychically"
		contents+=new/obj/Observe*/
	if(MaxKi>1500&&Race=="Demon") if(!(locate(/obj/Invisibility) in src))
		src<<"You acquired the invisibility skill"
		contents+=new/obj/Invisibility
	if(Race=="Alien")
		if(Base >= Melee_Req) if(Melee_Build == 1)
			Melee_Build = 2
			src<<"You acquired the ability to transform!"
			saveToLog("[src] unlocked their melee trans.")
		if(Base >= Ki_Req) if(Ki_Build == 1)
			Ki_Build = 2
			src<<"You acquired the ability to transform!"
			saveToLog("[src] unlocked their ki trans.")
		if(Base >= Hybrid_Req) if(Hybrid_Build == 1)
			Hybrid_Build = 2
			src<<"You acquired the ability to transform!"
			saveToLog("[src] unlocked their hybrid trans.")
	if(!(locate(/obj/Third_Eye) in src)&&Race=="Human"&&Base>geteye&&geteye)
		geteye=0 //Disables getting it again
		contents+=new/obj/Third_Eye
		src<<"You acquired the ability to unlock your third eye chakra."
		saveToLog("[src] unlocked Third Eye!")
	if(Race=="Kaio"||Class=="Kaio") if(Off+Def>=500&&MaxKi>=300)
		if(!(locate(/obj/Mystic) in src))
			contents+=new/obj/Mystic
			saveToLog("[src] unlocked Mystic!")
		//if(!(locate(/obj/Kaio_Revive) in src))contents+=new/obj/Kaio_Revive
		//if(!(locate(/obj/Teleport) in src))contents+=new/obj/Teleport
	if(Race=="Demon"||Class=="Demon") if(Str+Pow>=800)
		if(!(locate(/obj/Majin) in src)) contents+=new/obj/Majin
mob/proc/Med()
	if(src.icon_state=="Flight" || src.icon_state=="Train" || src.icon_state=="KO"|| src.icon_state=="KB"|| src.attacking ) return
	if(ghostDens_check())
		src << "You're currently in Ghost Form. Disable it first."
		return
	if(isnull(src.meditating_event)&&isnull(src.training_event)&&isnull(src.fly_event))
		training_id="[src][world.realtime][rand()]"
		if(src.medreward || src.medrewardmagic)
			src.icon_state="Meditate"
			src.meditating_event = new(training_scheduler, src, "reward") // we're assigning a different id so that rewards in this manner actually do NOT get killed.
			training_scheduler.schedule(src.meditating_event, 10)

		else if(src.icon_state!="Meditate") if(src.move) //&&!Smoke_Form())
			src.dir=SOUTH
			src.icon_state="Meditate"
			if(src.magicfocus)
				usr << "You begin to draw ambient magical energy into yourself."
			if(src.ifocus)
				usr << "You begin to study and improve your knowledge and intelligence."
			src.meditating_event = new(training_scheduler, src, training_id)
			training_scheduler.schedule(src.meditating_event, 12)

/*
		for (var/mob/player/M in world)
			if (src != M && src.client.address == M.client.address)
				M.Cancel_Meditation()
*/

//			spawn(100) if(icon_state=="Meditate"&&Anger>100)
//				Anger=100
//

	else
		src.Cancel_Meditation()
mob/verb/Meditate()
	set category="Skills"
	usr.Med()
