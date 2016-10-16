

var/tmp/EventScheduler/skills_scheduler = new()

var/tmp/EventScheduler/technology_scheduler = new()

var/tmp/EventScheduler/training_scheduler = new()

//var/EventScheduler/status_scheduler = new()

var/global/tmp/EventScheduler/LOGscheduler = new()
/**
 * Starts global schedulers for things like technology events etc. Break this and
 * you break digging, technology, training and meditation.
 */
proc/StartGlobalSchedulers()
	technology_scheduler.start() // Digging
	training_scheduler.start() // Training and meditation
	skills_scheduler.start() // Manages skills that require a loop of sorts.
	LOGscheduler.start()

//	Weather()


	//status_scheduler.start() // Status proc

/*
* Stop_Train_Dig_Schedulers()
* As the name suggests, it cancels training and digging,
* this isn't JUST for logging out, but for other events such as being KO'd as well.
*/

mob/proc/Stop_TrainDig_Schedulers(var/mob/player/M)

	if(!M)
		if(icon_state!="KO")
			src.Cancel_Training()
			src.Cancel_Digging()
			src.Cancel_Meditation()

	else if(M)
		if(M.icon_state!="KO")
			M.Cancel_Training()
			M.Cancel_Digging()
			M.Cancel_Meditation()

/*
* All important schedulers that are required to be stopped upon logout.
* Just call the Cancel_ procs in here, less of a hassle to go through the code
* since it's already placed properly.
*/

mob/proc/Cancel_Sched_OnLogout(var/mob/player/M)

	if(!M)

		//spawn src.Cancel_Status_Scheduler() // Status loop that checks health, etc, for that player.

		src.Stop_TrainDig_Schedulers()

		src.Cancel_PowerControl()
		src.Cancel_Transformation() // SSJ Transformations
		src.Cancel_Focus()
		src.Cancel_Expand()
		src.Cancel_LimitBreaker()
		src.Cancel_Kaioken()
		src.Flight_Land()

	else if(M)
		//spawn M.Cancel_Status_Scheduler() // Status loop that checks health, etc, for that player.

		M.Stop_TrainDig_Schedulers()

		M.Cancel_PowerControl()
		M.Cancel_Transformation() // SSJ Transformations
		M.Cancel_Focus()
		M.Cancel_Expand()
		M.Cancel_LimitBreaker()
		M.Cancel_Kaioken()
		M.Flight_Land()

/*
	__shift_down_events()
		var/list/result = null
		for (var/T in src.__scheduled_events)
			var/A = src.__scheduled_events[T]
			src.__scheduled_events.Remove(T)
			var/index = text2num(T)
			if (--index)
				src.__scheduled_events["[index]"] = A
			else
				result = A
		return result
*/