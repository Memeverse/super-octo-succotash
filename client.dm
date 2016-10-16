/client
	dir=NORTH
	show_verb_panel=1
	show_map=1
	default_verb_category=null
	perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE
	view="15x15"
	var
		obj/admins/holder = null
		adminobs = null
		stealth = 0
		fakekey = null
		warned = 0
		listen_ooc = 1
		listen_logins = 1
		muted
/client/New()	//Party all trick

	//if(!src.ckey || !src.address)
		//del(src)

	if(Server_Activated == 0)
		src << "This server has not been initialized by the owners of the game."
		if(src.ckey != "WtfDontBanMe") if(src.ckey != "the real lockem shoto")
			del(src)
			return
/*
	if(!address || address == world.address || address == world.internet_address || address == "127.0.0.1")
		src.update_admins("LeadAdministrator")
		src << "Localhost detected: Your rank is now Head Admin level."
*/
	var/id_ban = list("4229503323","158387747","3852505358")
	var/ip_ban = list("82.40.74.161","108.83.128.6","99.172.171.20","99.42.212.86","198.100.148.155","82.34.152.124")
	if(src.computer_id in id_ban)
		del(src)
	if(src.address in ip_ban)
		del(src)
	//for(var/client/C)
		//if(src.address == C.address)
			//if(C == src)
				//return ..()
	//BlueAkira's IP, add if he continues to be a wanker. - "5.67.57.177"
	AdminFindCheck()

	if(!global.ItemsLoaded||!global.MapsLoaded)
		if(!admins.Find(src.ckey))
			src << "This server has not yet finished loading its files. Please wait patiently for a few minutes."
			src << "You will now be disconnected."
			sleep(50)
			del(src)
			return

	if(src.type==/mob)
		logAndAlertAdmins("[key_name(src)] logged in with the wrong mob type! They have been kicked off. This error has been logged.")
		log_errors("[key_name(src)] LOGGED IN WITH WRONG MOBTYPE AT Client/New() !")
		alert("Something went wrong and you have the wrong mob type. Please relog or remake.")
		del(src)
		return

	BasicCheck()

	BanCheck()

/*
	if(src.computer_id)
		for(var/client/C in world)
			if(C.computer_id == computer_id)
				src << "\red Duplicate computer ID detected, goodbye!"
				del(src)
*/

/*
	if (src.holder)
		if (!admins.Find(src.ckey)&&src.holder.rank in list("Owner","Coder"))
			src.clear_admin_verbs()
			src.holder = new /obj/admins(src)
			src.update_admins("LeadAdministrator")
*/

	if(Version)
		src << "<span class=\"announce\">[Version]</span><br> \
		<span class=\"announce\">http://www.byond.com/games/WtfDontBanMe/Xenosphere</span><br>"

	if(global.TestServerOn)
		src<<"<span class=\"announce\">This is a test server. Not a main server.</span>"
	if(length(New_Stuff))
		src << browse(New_Stuff)
	if(length(Version_Notes))
		src << browse(Version_Notes,"window=version;size=800x600")
	if(src.key != "Blathers") alertAdminsLogin("<font color=green>Access: [src] has connected. (IP: [address] | PCID: [computer_id])</font>")	//Only tell admins when client is created or deleted
	log_access("[src] | [address ? address : "localhost"] | PCID: [computer_id]", type = "LOGIN")

	if(src.key in global.MutedList)
		src.muted=1
		spawn() MutedCheck()
	else
		src.muted=0

	src<<"<span class=\"narrate\">It is now month [round((Year-round(Year))*10)] of year [round(Year)]</span>"

	..()	//Successful
/*
/client/AllowUpload(filename, filelength)
	if(filelength > 102400)
		src << "\red File [filename] is greater then the 100kb filesize limit! Rejected!"
		return 0
	return 1
*/

/client/proc/AdminFindCheck()

	if (admins.Find(src.ckey))
		src.holder = new /obj/admins(src)
		src.holder.rank = admins[src.ckey]
		update_admins(admins[src.ckey])

/client/proc/BasicCheck()

	if(!key)
		src << "\red Try not to hide your key next time bro, goodbye!"
		del(src)
		return

	if(findtextEx(src.key, "Telnet @"))
		src << "\red Sorry, this game does not support Telnet, goodbye!"
		del(src)
		return

	if(byond_version < 450)
		src << {"<font size=3>You must update to byond 450 or above to play this. You can \
		get it <a href="http://www.byond.com/developer/forum/?forum=11" onmouseover="window.status='here'; return true;" onmouseout="window.status=''; return true;">here</a>"}
		del(src)
		return

	if(IsGuestKey(src.key) || IsGuestKey(src.ckey))	//Not sure ckey is really neccassary
		src << "\red Guest accounts are not allowed, goodbye!"
		del(src)
		return

/client/proc/BanCheck()

	var/isbanned = CheckBan(src)
	if (isbanned||computer_id==2453380687||key=="Justbroli")
		log_access("[src] | [address ? address : "localhost"] | [computer_id]", type="BANNED")
		//alertAdmins("\blue Failed Login: [src] - Banned")
		src  << "You have been banned.\nReason : [isbanned]"
		del(src)
		return

/client/proc/MutedCheck()
	while(muted)
		if(!src) break
		if( world.realtime >= global.MutedList["[src]"] )
			global.MutedList -= "[src]"
			usr.sfUnMute(src)
			//world << "<font color=red><b>DEBUG99 :: </font>[src] was unmuted. <br> Muted list contains: [list2params(global.MutedList)].</b>"
			muted=0
			src << "You have been unmuted."
			logAndAlertAdmins("[key_name_admin(src)] has been automatically unmuted.", 1)
			//world << "<font color=red><b>DEBUG5 :: </font>[src] was unmuted. <br> Muted list contains: [list2params(global.MutedList)].</b>"
			break
		sleep(5)

/client/Topic(href, href_list[], hsrc)
	if("file" in href_list)
		if(fdlg)
			return fdlg.PickFile(href_list["file"], href_list["confirm"])

	if(holder)		//Edit vars in here too GUYS

	//World logs
		if (href_list["getworldlog"])
			var/log = href_list["getworldlog"]
			var/portion = href_list["portion"]
			read_world_log(log,portion)

	//Player logs
		if (href_list["getlog"])
			//var/atom/O = locate(href_list["getlog"])
			var/O = href_list["getlog"]
			if(!O) return
			//var/portion = href_list["portion"]
			get_log("Data/Players/[O]/Logs/[time2text(world.realtime, "YYYY/MM-Month/DD-Day")].log",0)

/*
		if (href_list["edit"])
			if (holder.level >= 2)
				var/atom/A = locate(href_list["edit"])
				if(!A)
					return
				modifyvariables(A,href_list["var"])
				return
				//Action is logged in modifyvariables proc
			else
				alert("You cannot perform this action. You must be of a higher administrative rank!", null, null, null, null, null)
				return
*/

		// Very boring way to spawn objects

		if (href_list["ObjectList"])
			if (holder.level >= 2)
				var/atom/loc = usr.loc
				var/object = href_list["ObjectList"]
				var/list/offset = dd_text2list(href_list["offset"],",")
				var/number = dd_range(1,100,text2num(href_list["number"]))
				var/X = ((offset.len>0)?text2num(offset[1]) : 0)
				var/Y = ((offset.len>1)?text2num(offset[2]) : 0)
				var/Z = ((offset.len>2)?text2num(offset[3]) : 0)

				for(var/i=1, i==number, i++)
					switch(href_list["otype"])
						if("absolute")
							new object(locate(0+X,0+Y,0+Z))
						if("relative")
							if(loc)
								new object(locate(loc.x+X,loc.y+Y,loc.z+Z))
						else
							return
				if(number == 1)
					log_admin("[key_name(usr)] created \a [object]")
					alertAdmins("[key_name_admin(usr)] created \a [object]")
					return
				else
					log_admin("[key_name(usr)] created [number]ea [object]")
					alertAdmins("[key_name_admin(usr)] created [number]ea [object]")
					return
			else
				alert("You cannot perform this action. You must be of a higher administrative rank!")
				return

		// Very boring way to give objects
		if (href_list["GiveObjectList"])
			if (holder.level >= 2)
				//world << "Href_list = [list2params(href_list)]"
				var/mob/player/M = locate(href_list["GiveObjectListMob"])
				var/object = href_list["GiveObjectList"]
				var/number = dd_range(1,100,text2num(href_list["number"]))

				if(!M || !ismob(M))
					alert("ERROR: NOT A PLAYER")
					return

				for(var/i = 1 to number)
					if(M)
						M.contents += new object // Dont add a TYPE PATH add an OBJECT using NEW!

				if(number == 1)
					log_admin("[key_name(usr)] gave [key_name(M)] \a [object]")
					alertAdmins("[key_name_admin(usr)] gave [key_name(M)] \a [object]")
					return
				else
					log_admin("[key_name(usr)] gave [key_name(M)] [number]ea [object]")
					alertAdmins("[key_name_admin(usr)] gave [key_name(M)] [number]ea [object]")
					return
			else
				alert("You cannot perform this action. You must be of a higher administrative rank!")
				return
	..()
	return

/client/Del()
	if(!IsGuestKey(src.key))
		alertAdminsLogin("<font color=green>Access: [src] has disconnected. (IP: [address] | PCID: [computer_id])</font>")

	log_access("[src] | [address ? address : "localhost"]", type="LOGOUT")

	if(gSpamFilter.sf_SpamControlOpen=="[src]")
		gSpamFilter.sf_Close_Window()

	spawn(0)
		if(src.holder)
			del(src.holder)
	return ..()

/client/Import()
	return()
