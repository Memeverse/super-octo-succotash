/*

This way of viewing logs is slow.
If anybody has any suggestions on the speed/efficiency while keeping the ability to go through offline logs, then please improve it. -- Vale

*/

mob/admin/verb/viewerrors()
	set name = "ErrorLog"
	set category = "Admin"
	if(!usr.client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	src << ftp("Data/Logs/errors.log","errors.log")
	return

//file = logfile, portion = what part of log to read
/client/proc/get_log(log,portion)

	src<< "The logfile is being downloaded. Please be patient. Any lag is due to the download and is limited to just you."
	src<< "If you want the HTML to WORK, save the .log extension to .html (so it'll be something like wtfdontbanme.html)."
	src<<browse(file(log))

/*
	set background = 1
	if(!log) return

	if(!isnum(portion) && portion)
		portion = text2num(portion)	//derp derp this is awesome
	portion=max(portion,0)	//bla
	var/dat
	var/readLog = dd_file2list(log)
	var/k

	if(portion > 0)	//previous and return to beginning
		dat	+=	"<B><A HREF='?src=\ref[src];getlog=[log];portion=0;'>Return to beginning</a></B> | "
		dat	+=	"<B><A HREF='?src=\ref[src];getlog=[log];portion=[portion-1];'>Previous</a></B> | "

	for(var/i in readLog)
		k += "[i]<br>"

	//If we added a previous, add a next. this just looks complicated but it isn't
	if(length(k) > MAX_MESSAGE_LEN*(portion+1))	//Still have more log to read
		dat	+=	"<B><A HREF='?src=\ref[src];getlog=[log];portion=[portion+1];'>Next</a></B><br><hr>"

	dat += copytext(k,min(length(k),(1+MAX_MESSAGE_LEN*portion)),min(length(k),MAX_MESSAGE_LEN*(portion+1)))

	if(length(k) > MAX_MESSAGE_LEN*(portion+1))	//Still have more log to read
		dat	+=	"<hr><br><B><A HREF='?src=\ref[src];getlog=[log];portion=[portion+1];'>Next</a></B> | "
		var/last = (length(k)/MAX_MESSAGE_LEN)-1	//Jump to end
		dat	+=	"<B><A HREF='?src=\ref[src];getlog=[log];portion=[last];'>Last</a></B> | "
		dat	+=	"<B><A HREF='?src=\ref[src];getlog=[log];portion=0;'>Return to beginning</a></B>"

	usr << browse(dat, "window=Log;size=600x600")
*/
/obj/admins/proc/check_log()
	set category = "Admin"
	set name = "Check Player Logs"

	if(!usr.client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return

	if(!fexists("Data/Players/"))
		alert("No world logs found!")
		return

	var/filedialog/F = new(usr.client, /client/proc/get_log)


	F.msg = "Choose a logfile."   // message in the window
	F.title = "Load Player Log"      // popup window title
	F.root = "Data/Players/"               // directory to use
	F.saving = 0                    // saving? (false is default)
	//F.default_file = "./[time2text(world.realtime, "YYYY/Month")]"    // default file name
	F.ext = ".log"                  // default extension
	F.filter = ".log"

	F.Create(usr.client)            // now display the dialog

/client/proc/read_world_log(log,portion)

	src<< "The logfile is being downloaded. Please be patient. Any lag is due to the download and is limited to just you."
	src<<browse(file(log))

/*
	set background = 1
	if(!usr.client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return

	if(log)

		var/readLog = dd_file2list(log)
		var/dat	//roundabout way of doing this but ohwell :p
		var/k

		if(!isnum(portion) && portion)
			portion = text2num(portion)	//derp derp this is awesome
		portion=max(portion,0)	//bla

		for(var/i in readLog)
			k += "[i]<br>"

		if(portion > 0)	//previous and return to beginning
			dat	+=	"<B><A HREF='?src=\ref[src];getworldlog=[log];portion=0;'>Return to beginning</a></B> | "
			dat	+=	"<B><A HREF='?src=\ref[src];getworldlog=[log];portion=[portion-1];'>Previous</a></B> | "

		//If we added a previous, add a next. this just looks complicated but it isn't
		if(length(k) > MAX_MESSAGE_LEN*(portion+1))	//Still have more log to read
			dat	+=	"<B><A HREF='?src=\ref[src];getworldlog=[log];portion=[portion+1];'>Next</a></B><br>"


		dat += "<span style=\"h1\">[log]</span><hr>"
//		for(LINES=-3, LINES<=MAX_LINES, LINES++)
			//for(var/i in readLog[(LINES <= 0 ? 1 : LINES)+(MAX_LINES*portion == 0 ? 1 : MAX_LINES*portion) ]) dat += "[i]<br>"
//			for(var/i in readLog[10]) dat += "[i]<br>"

		dat += copytext(k,min(length(k),(1+MAX_MESSAGE_LEN*portion)),min(length(k),MAX_MESSAGE_LEN*(portion+1)))

		if(length(k) > MAX_MESSAGE_LEN*(portion+1))	//Still have more log to read
			dat	+=	"<br><B><A HREF='?src=\ref[src];getworldlog=[log];portion=[portion+1];'>Next</a></B> | "
			var/last = (length(k)/MAX_MESSAGE_LEN)-1	//Jump to end
			dat	+=	"<B><A HREF='?src=\ref[src];getworldlog=[log];portion=[last];'>Last</a></B> | "
			dat	+=	"<B><A HREF='?src=\ref[src];getworldlog=[log];portion=0;'>Return to beginning</a></B>"

		usr << browse(dat, "window=WorldLog;size=640x800")
*/

/obj/admins/proc/check_world_logs()
	set category = "Admin"
	set name = "Check World Logs"

	if(!usr.client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return

	if(!fexists("Data/Logs/"))
		alert("No world logs found!")
		return

	var/filedialog/F = new(usr.client, /client/proc/read_world_log)


	F.msg = "Choose a logfile."   // message in the window
	F.title = "Load World Log"      // popup window title
	F.root = "Data/Logs/"               // directory to use
	F.saving = 0                    // saving? (false is default)
	//F.default_file = "./[time2text(world.realtime, "YYYY/Month")]"    // default file name
	F.ext = ".log"                  // default extension
	F.filter = ".log"

	F.Create(usr.client)            // now display the dialog

/* BACKUP - OLD

/obj/admins/proc/get_log(var/mob/M, var/portion = 0)
	set background = 1
	if(!M || !fexists("Data/Players/[M.lastKnownKey]/Logs/full_[M.real_name].log"))
		return
	if(!isnum(portion) && portion)
		portion = text2num(portion)	//derp derp this is awesome
	portion=max(portion,0)	//bla
	var/dat

	if(portion > 0)	//previous and return to beginning
		dat	+=	"<B><A HREF='?src=\ref[src];getlog=\ref[M];portion=0;'>Return to beginning</a></B><br>"
		dat	+=	"<B><A HREF='?src=\ref[src];getlog=\ref[M];portion=[portion-1];'>Previous</a></B><br>"

	var/log = file2text("Data/Players/[M.lastKnownKey]/Logs/full_[M.real_name].log")	//Load the log into.. log

	//If we added a previous, add a next. this just looks complicated but it isn't
	if(length(dat) && length(log) > MAX_MESSAGE_LEN*(portion+1))	//Still have more log to read
		dat	+=	"<B><A HREF='?src=\ref[src];getlog=\ref[M];portion=[portion+1];'>Next</a></B><br>"


	dat += copytext(log,min(length(log),(1+MAX_MESSAGE_LEN*portion)),min(length(log),MAX_MESSAGE_LEN*(portion+1)))

	if(length(log) > MAX_MESSAGE_LEN*(portion+1))	//Still have more log to read
		dat	+=	"<br><B><A HREF='?src=\ref[src];getlog=\ref[M];portion=[portion+1];'>Next</a></B>"
		var/last = (length(log)/MAX_MESSAGE_LEN)-1	//Jump to end
		dat	+=	"<br><B><A HREF='?src=\ref[src];getlog=\ref[M];portion=[last];'>Last</a></B>"
	dat	+=	"<br><B><A HREF='?src=\ref[src];getlog=\ref[M];portion=0;'>Return to beginning</a></B>"

	usr << browse(dat, "window=Log;size=600x600")


/*
/obj/admins/proc/check_log(mob/M in Players)
	set category = "Admin"
	set name = "Check Logs"

	if(!usr.client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return

	if(!fexists("Data/Players/[M.lastKnownKey]/Logs/full_[M.real_name].log"))
		alert("[key_name(M)] has no logfile!")
		return

	usr.client.holder.get_log(M)
*/

*/