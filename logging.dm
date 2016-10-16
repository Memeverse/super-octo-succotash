
/proc/log_admin(text)
	//admin_log.Add(text)
	text=html_decode(text)
	//diary << "[time2text(world.timeofday, "YYYY-MM-DDThh:mm:ss")] ADMIN: [text]"
	file("AdminLog.log")<<"[time2text(world.timeofday, "YYYY-MM-DDThh:mm:ss")] ADMIN: [text]"

/proc/log_help(text)
	diary << "[time2text(world.timeofday, "YYYY-MM-DDThh:mm:ss")] HELP: [text]"
	pre_log << "[time2text(world.timeofday, "YYYY-MM-DDThh:mm:ss")] HELP: [text]"

/proc/log_game(text)
	text=html_decode(text)
	diary << "[time2text(world.timeofday, "YYYY-MM-DDThh:mm:ss")] GAME: [text]"
	pre_log << "[time2text(world.timeofday, "YYYY-MM-DDThh:mm:ss")] GAME: [text]"

/proc/log_ability(text)
	text=html_decode(text)
	diary << "[time2text(world.timeofday, "YYYY-MM-DDThh:mm:ss")] ABILITY: [text]"
	pre_log << "[time2text(world.timeofday, "YYYY-MM-DDThh:mm:ss")] ABILITY: [text]"

/proc/log_access(text, type)
	text=html_decode(text)
	diary << "[time2text(world.timeofday, "YYYY-MM-DDThh:mm:ss")] [type] [text]"
	pre_log << "[time2text(world.timeofday, "YYYY-MM-DDThh:mm:ss")] [type] [text]"

/proc/log_say(text)
	text=html_decode(text)
	diary << "[time2text(world.timeofday, "YYYY-MM-DDThh:mm:ss")] SAY: [text]"
	pre_log << "[time2text(world.timeofday, "YYYY-MM-DDThh:mm:ss")] SAY: [text]"

/proc/log_ooc(text)
	text=html_decode(text)
	diary << "[time2text(world.timeofday, "YYYY-MM-DDThh:mm:ss")] OOC: [text]"
	pre_log << "[time2text(world.timeofday, "YYYY-MM-DDThh:mm:ss")] OOC: [text]"

/proc/log_whisper(text)
	text=html_decode(text)
	diary << "[time2text(world.timeofday, "YYYY-MM-DDThh:mm:ss")] WHISPER: [text]"
	pre_log << "[time2text(world.timeofday, "YYYY-MM-DDThh:mm:ss")] WHISPER: [text]"

/proc/log_telepathy(text)
	text=html_decode(text)
	diary << "[time2text(world.timeofday, "YYYY-MM-DDThh:mm:ss")] TELEPATHY: [text]"
	pre_log << "[time2text(world.timeofday, "YYYY-MM-DDThh:mm:ss")] TELEPATHY: [text]"

/proc/log_emote(text)
	text=html_decode(text)
	diary << "[time2text(world.timeofday, "YYYY-MM-DDThh:mm:ss")] EMOTE: [text]"
	pre_log << "[time2text(world.timeofday, "YYYY-MM-DDThh:mm:ss")] EMOTE: [text]"

/proc/log_errors(text)
	text=html_decode(text)
	errors << "[time2text(world.timeofday, "YYYY-MM-DDThh:mm:ss")] | [text]"


/proc/log_warning(text)
	text=html_decode(text)
	diary << "\n!! ------------------ !!\n[time2text(world.timeofday, "YYYY-MM-DDThh:mm:ss")] WARNING: [text]\n!! ------------------ !!\n"
	pre_log << "\n!! ------------------ !!\n[time2text(world.timeofday, "YYYY-MM-DDThh:mm:ss")] WARNING: [text]\n!! ------------------ !!\n"



// NEW LOG SYSTEM

mob/proc/saveToLog(var/text)

	if(!(text || src))
		return
	//Almost put it under Data/Logs/blabla, but ehh

// I'm using Stephen001's EventScheduler library /
// I'm hoping this will help reduce the lag caused by massive saveToLog calls

	var/Event/E = new/Event/writeToLog(text, lastKnownKey, real_name)
	LOGscheduler.schedule(E, rand(2,8))

Event/writeToLog

	New(var/T, var/K, var/R)
		src.text = T
		src.real_name = R
		src.lastKnownKey = K

	fire()
		..()

		var/logfile = "Data/Players/[lastKnownKey]/Logs/[time2text(world.realtime, "YYYY/MM-Month/DD-Day")].log"
		file(logfile) << "Year - [Year], Time - [time2text(world.timeofday, "YYYY-MM-DDThh:mm:ss")] [text]"

		var/full_logfile = "Data/Players/[lastKnownKey]/Logs/full_[real_name].log"
		file(full_logfile) << "Year - [Year], Time - [time2text(world.timeofday, "YYYY-MM-DDThh:mm:ss")] [text]"

	var
		lastKnownKey
		real_name
		text



/*
// OLD LOG SYSTEM


mob/proc/saveToLog(var/text)

	if(!(text || src))
		return
	//Almost put it under Data/Logs/blabla, but ehh

	var/logfile = "Data/Players/[lastKnownKey]/Logs/[time2text(world.realtime, "YYYY/MM-Month/DD-Day")].log"
	file(logfile) << "[time2text(world.timeofday, "YYYY-MM-DDThh:mm:ss")] [text]"

	var/full_logfile = "Data/Players/[lastKnownKey]/Logs/full_[real_name].log"
	file(full_logfile) << "[time2text(world.timeofday, "YYYY-MM-DDThh:mm:ss")] [text]"
*/
