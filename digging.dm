Event/Timer/DigTimer
	var/tmp/mob/digger
	var/tmp/id

	New(var/EventScheduler/scheduler, var/mob/D, var/_id)
		src.digger = D
		src.id = _id
		if(digger.digging_event) // If they're spamming the macro and they already triggered a dig macro, kill it.
			digger << "<span class=announce>SYSTEM: Multiple dig instances found. Canceling dig. (macro spam?)</span>"
			digger.Cancel_Digging()
			return

		..(scheduler, 120)

	fire()
		..()
		if(isnull(digger) || isnull(digger.client)){technology_scheduler.cancel(src);return} // sanity, it is important.
		if(id!=digger.training_id){technology_scheduler.cancel(src);return} // Still some dig events scheduled that dont belong to the current digging event? Kill them.
		if(isnull(digger.digging_event)){digger.Cancel_Digging();return}

		if(digger.icon_state=="KB")

			if(digger.Dig_Clicks > 2)
				digger.Dig_Clicks -= 1
				return
			var/DigPower = 50
			for (var/obj/items/Digging/digging_tool in digger)
				if (digging_tool.suffix) // If it's equipped.
					DigPower *= digging_tool.DigMult
			DigPower = round(DigPower)
			for(var/obj/Resources/resource_bag in digger)
				for(var/area/B in range(0,digger))
					if(B.type==/area||B.type==/area/Inside) continue
					if(B.Value > 1)
						if(B.Value>=DigPower)
							resource_bag.Value+=DigPower
							B.Value-=DigPower
							//world << "DEBUG: Drill \ref[drillObj] has collected: [50*drillObj.DrillRate] from [B] ([B.type])."
							//world << "DEBUG: Drill \ref[drillObj] has collected: [B.Value] from [B] ([B.type])."

		else
			digger.Cancel_Digging()
			digger = null

mob/var/tmp/Event/Timer/DigTimer/digging_event = null
mob/var/tmp/digging = 0
mob/var/tmp/Dig_Clicks = 0
mob/proc/Cancel_Digging()
	if(!istype(src,/mob/player)) return
	if(src.digging_event)
		technology_scheduler.cancel(src.digging_event)
		src.icon_state = ""
		spawn(15) src.digging_event = null
	training_id=null

mob/verb/Dig()
	set category = "Skills"
	if(isturf(src.loc))
		if(src.digging)
			src << "Wait a while before trying to dig again."
			src.Cancel_Digging()
			src.icon_state = ""
			return
		if(icon_state == "KO" || icon_state=="Train"|| icon_state=="Meditate" ) return
		if(isnull(src.digging_event))
			var/area/A = src.loc.loc
			if(istype(A,/area/Inside) || A.type==/area)
				src << "You will not find any resources in this area..."
				return
			TechTab = 1
			src.digging = 1
			spawn(200)
				if(src)src.digging = 0
			training_id="[src][world.realtime][rand()]"
			src << "You begin digging for resources."
			src.Dig_Clicks += 1
			icon_state = "KB"


			Cancel_Digging()
			sleep(15) // Sleep for 1.5 seconds to allow previous digging to be canceled.
					// This is required because apparently, setting a macro on repeat allows you to stack them regardless.

			src.digging_event = new(technology_scheduler, src, training_id)
			technology_scheduler.schedule(src.digging_event, 120)
		else
			Cancel_Digging()