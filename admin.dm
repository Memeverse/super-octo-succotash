/obj/admins
	name = "admins"
	var/rank = null
	var/owner = null
	var/level = null
	var/state = 1
	var/listen_Chat = 1
	var/listen_Alerts = 1
	var/listen_Logins = 1
	//state = 1 for playing : default
	//state = 2 for observing

/client/proc/unban_panel()
	set name = "Unban Panel"
	set category = "Admin"
	if (src.holder)
		src.holder.unbanpanel()
	return
/obj/admins/proc/Clean()
	set category="Admin"
	if(!usr.client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	spawn Clear_Stray_Clothes()

	for(var/obj/items/Weights/C)
		sleep(1)
		if(C.loc && C.z!=0 && C.Savable==0) del(C)

	for(var/obj/Resources/B)
		sleep(1)
		if(B.loc && B.z!=0 && B.Savable==0)
			if(B.Value < 300) del(B)

	for(var/obj/ranged/Blast/A)
		del(A)
		sleep(1)
//	for(var/obj/SpaceDebris/A)
//		del(A)
//		if(prob(1)) sleep(1)
/*	for(var/obj/Dust/A)
		del(A)
		sleep(1)*/
	for(var/obj/Crater/A)
		del(A)
		sleep(1)

/client/proc/EditNotes()
	set category="Admin"
	if(!usr.client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	if(!WritingNotes)
		WritingNotes=src
		logAndAlertAdmins("[src.key] is editing the notes...",1)
		Notes=input(usr,"Edit!","Edit Notes",Notes) as message
		logAndAlertAdmins("[src.key] is done editing the notes...",1)
		WritingNotes=0
		SaveNotes()
	else usr<<"<b>Someone is already editing the notes."
/*
/client/proc/EZ_Check()
	set name = "EZ Check"
	set category = "Admin"
	if(!usr.client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	logAndAlertAdmins("[usr.key] produced an EZ check.",1)
	for(var/mob/P in Players)
		if(!P.afk)
			var/Bag = 0
			for(var/obj/TrainingEq/Punching_Bag/B in range(1,P))
				Bag = 1
				break
			if(Bag)
				var/N = rand(1111,9999)
				var/solved = 0
				spawn(600)
					if(P)
						if(solved == 0)
							P << "You failed to respond to this EZ check, the admins have been alerted!"
							logAndAlertAdmins("[P.key] has failed their EZ check!",1)
							solved = 3
					else
						logAndAlertAdmins("[P.key] logged out during their EZ test!",1)
				var/solve = input(P,"This is an official EZ check activated by [usr.key] and distributed to all players server wide who are near a punching bag. You have 60 seconds to input the following numbers before you are reported for potential EZing. [N]", "[N]")  as num
				if(solved == 3)
					return
				if(solve)
					solved = 1
				if(solve == N)
					solved = 2
				if(solved == 1)
					P << "You did not input the correct numbers!"
					logAndAlertAdmins("[P.key] did not input the correct numbers for their EZ check.",1)
					return
				if(solved == 2)
					P << "Correct, thank you for complying."
					return
*/
/client/proc/player_panel()
	set name = "Player Panel"
	set category = "Admin"
	if(!usr.client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	if (src.holder)
		src.holder.player()
	return

/obj/admins/proc/player()
	var/dat = "<html><head><title>Player Menu</title></head>"
	dat += "<body><table border=1 cellspacing=5><B><tr><th>Name</th><th>Real Name</th><th>Planet</th><th>Key</th><th>IP</th><th>Options</th><th>PM</th></tr></B>"

	for(var/mob/player/M in Players)
		if(M.key)
			dat += "<tr><td>[M.name]</td>"
			if(istype(M, /mob/) && M.real_name)
				dat += "<td>[M.real_name]</td>"
			else
				dat += "<td>None</td>"
			if(M.loc)
				dat += "<td>[dd_limittext(get_area(M),8)]</td>"	//Only show first 8 letters of area
			else
				dat += "<td><b>Null</b></td>"	//Ruro
			dat += {"<td>[(M.client ? "[M.client]</font>" : "No client")]</td>
			<td>(IP: [M.lastKnownIP])</td>
			<td align=center><A HREF='?src=\ref[src];adminplayeropts=\ref[M]'>X</A></td>
			<td align=center><A href='?src=\ref[usr];priv_msg=\ref[M]'>PM</A></td></tr>
			"}

	for(var/client/C)
		if(!Players.Find(C.mob))
			dat += "<tr><td>None</td>"
			dat += "<td>None</td>"	//Real name
			dat += "<td>Char Select</td>"
			dat += {"<td>[C]</td>
			<td>(IP: [C.address])</td>
			<td align=center><A HREF='?src=\ref[src];adminplayeropts=\ref[C.mob]'>X</A></td>
			<td align=center><A href='?src=\ref[usr];priv_msg=\ref[C.mob]'>PM</A></td></tr>
			"}

	dat += "</table></body></html>"

	usr << browse(dat, "window=players;size=640x480")
/obj/admins/proc/AdminLogs()
	set category="Admin"

	if(!usr.client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return

	usr<<browse(file("AdminLog.log"))
/obj/admins/proc/ShowDonate()
	set category="Admin"

	if(!usr.client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	for(var/mob/M in Players)
		winshow(M,"Donate",1)
/obj/admins/proc/announce(var/message as message)
	set category = "Admin"
	set name = "Announce"
	set desc="Announce your desires to the world"

	if(!usr.client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	if(!message)	//Lets you do announce "stuff" OR announce -> "bla bla"
		message = input("Global message to send:", "Admin Announce", null, null)  as message
	if (message)
		if(usr.client.holder.rank != "Owner" && usr.client.holder.rank != "Coder")
			message = adminscrub(message,MAX_MESSAGE_LEN)
		world << "<span class=\"announce\"><center><b>[usr.client.stealth ? "Administrator" : usr.key] Announces:</b><br>[message]</center></span>"
		log_admin("Announce: [key_name(usr)] : [message]")

/obj/admins/proc/narrate(var/message as message)
	set category = "Admin"
	set name = "Narrate"
	set desc = "Narrate to those within 20 tiles of you"

	if(!usr.client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	if(!message)	//Lets you do narrate "stuff" OR narrate -> "bla bla"
		message = input("Narrative message to send:", "Admin Narrate", null, null)  as message
	if (message)
		if(usr.client.holder.rank != "Owner" && usr.client.holder.rank != "Coder")
			message = adminscrub(message,MAX_MESSAGE_LEN)
		for(var/mob/M in oview(usr,20))
			M << "<span class=\"narrate\"><font size=[M.TextSize]>[message]</font></span>"
		log_admin("Narrate: [key_name(usr)] : [message]")
		alertAdmins("[key_name(usr)] used narrate.")

/obj/admins/proc/Narrate_World(var/message as message)
	set category = "Admin"
	set name = "Narrate World"
	set desc = "Narrate to everyone in the game world"

	if(!usr.client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	if(!message)	//Lets you do narrate "stuff" OR narrate -> "bla bla"
		message = input("Narrative message to send:", "Admin Narrate", null, null)  as message
	if (message)
		if(usr.client.holder.rank != "Owner" && usr.client.holder.rank != "Coder")
			message = adminscrub(message,MAX_MESSAGE_LEN)
		for(var/mob/M in world)
			M << "<span class=\"narrate\"><font size=[M.TextSize]>[message]</font></span>"
		log_admin("Narrate: [key_name(usr)] : [message]")
		alertAdmins("[key_name(usr)] used narrate world.")


/obj/admins/proc/NPCs()
	set category="Admin"
	if(!usr.client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	for(var/NPC_AI/A) if(!A.client&&A.type!=/obj/TrainingEq/Dummy&&A.type!=/obj/TrainingEq/Punching_Bag)
		del(A)
		if(prob(5)) sleep(1)
	logAndAlertAdmins("[usr]([usr.key]) cleaned NPC's at [time2text(world.realtime,"Day DD hh:mm")]\n")

	//file("AdminLog.log")<<"[usr]([usr.key]) cleaned NPC's at [time2text(world.realtime,"Day DD hh:mm")]\n"

proc/Replace_List()
	var/list/L=new
	for(var/turf/A in view(src)) L+=A
	for(var/obj/O) L+=O
	return L

obj/admins/proc/Replace(atom/A in Replace_List())
	set category="Admin"

	if(!usr.client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return

	var/Type=A.type
	var/list/B=new
	B+="Cancel"
	if(isturf(A)) B+=typesof(/turf)
	else B+=typesof(/obj)
	var/atom/C=input("Replace with what?") in B
	if(C=="Cancel") return
	var/Save
	switch(input("Make it save?") in list("No","Yes"))
		if("Yes") Save=1
	for(var/turf/D in block(locate(1,1,usr.z),locate(world.maxx,world.maxy,usr.z)))
		if(D.type==Type)
			if(prob(0.2)) sleep(1)
			var/turf/Q=new C(locate(D.x,D.y,D.z))
			if(Save) Turfs+=Q
		else for(var/obj/E in D)
			if(prob(1)) sleep(1)
			if(E.type==Type)
				var/obj/Q=new C(locate(E.x,E.y,E.z))
				Q.Savable=0
				if(Save) Turfs+=Q
				del(E)
//	file("AdminLog.log")<<"[usr]([usr.key]) replaced turfs at [time2text(world.realtime,"Day DD hh:mm")]\n"

	logAndAlertAdmins("[key_name(usr)] replaced [Type] with [C] and save=[Save] at ([usr.x],[usr.y],[usr.z])",3)

/obj/admins/proc/toggleooc()
	set category = "Admin"
	set desc="Toggle OOC on and off"
	set name="Toggle OOC Chat"

	if(!usr.client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return

	ooc_allowed = !( ooc_allowed )
	if (ooc_allowed)
		world << "<B>The OOC channel has been globally enabled!</B>"
	else
		world << "<B>The OOC channel has been globally disabled!</B>"
	log_admin("[key_name(usr)] toggled OOC.")
	alertAdmins("[key_name_admin(usr)] toggled OOC.", 1)

/obj/admins/proc/immreboot(var/reason as text)
	set category = "Admin"
	set desc="Reboots the server"
	set name="Reboot"
	if(!reason)
		reason = "No reason specified!"
	if(!usr.client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return

	if( alert("Reboot server?",,"Yes","No") == "No")
		return
	world << "<span class=\"announce\"> <b>Rebooting world!</b> Initiated by [usr.client.stealth ? "Administrator" : usr.key] with reason: [reason]</span>"
	log_admin("[key_name(usr)] initiated a reboot.")
	//file("AdminLog.log")<<"[usr]([usr.key]) rebooted at [time2text(world.realtime,"Day DD hh:mm")] \n"
	global.rebooting = 1
	SaveWorld()
	SaveRanks()
	//global.ItemsLoaded=0
	//global.MapsLoaded=0
	world << "<span class=\"announce\">World saved. Rebooting in 5 seconds.</span>"
	sleep(50) // Wait 5 seconds just to be safe
	world.Reboot("Initiated by [usr.key] with reason: [reason]")
	usr.Save()
	del(usr)
/obj/admins/proc/Assign_Rank (var/mob/M in Players)
	set category = "Admin"
	set desc="Adds a player to the ranks entry."
	set name="Assign Rank"
	if(!usr.client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	var/Rank_Name = input("Enter the name of the rank you're creating an entry for. This can be a custom name.","Rank Name") as text|null
	log_admin("[key_name(usr)] assigned [M] as a [Rank_Name] inside the Rank entries.")
	alertAdmins("[key_name(usr)] assigned [M] as a [Rank_Name] inside the Rank entries.", 1)
	M.CreateRank("[Rank_Name]")
/obj/admins/proc/Shutdown(var/reason as text)
	set category = "Admin"
	set desc="Shut down the server"
	set name="Shutdown"
	if(!reason)
		reason = "No reason specified!"
	if(!usr.client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	if( alert("Shut down server?",,"Yes","No") == "No")
		return
	global.rebooting = 1
	world << "<span class=\"announce\"> <b>Shutting down world!</b> Initiated by [usr.client.stealth ? "Administrator" : usr.key] with reason: [reason]!</span>"
	log_admin("[key_name(usr)] initiated a shutdown.")
	//file("AdminLog.log")<<"[usr]([usr.key]) initiated a shutdown at [time2text(world.realtime,"Day DD hh:mm")]\n"
	SaveWorld()
	SaveRanks()
	//global.ItemsLoaded=0
	//global.MapsLoaded=0
	world << "<span class=\"announce\"> Shutdown in 30 seconds.</span>"
	sleep(100)
	world << "<span class=\"announce\"> Shutdown in 20 seconds.</span>"
	sleep(100)
	world << "<span class=\"announce\"> Shutdown in 10 seconds.</span>"
	sleep(100)
	//Shutdown()
	world.Del()

/obj/admins/proc/Saveserver()
	set category = "Admin"
	set desc="Save the server"
	set name="Save Server"

	if(!usr.client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return

	world << "<span class=\"announce\"> <b>Saving world!</b> </span>"
	log_admin("[key_name(usr)] initiated a world save.")
	SaveWorld()

/obj/admins/Topic(href, href_list)
	..()
	//Don't allow people to enter html from cmd line
	if(!usr.client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	if (usr.client != src.owner)
		world << "\red [usr.key] has attempted to override the admin panel!"
		log_admin("[key_name(usr)] tried to use the admin panel without authorization.")
		return

	//Mute a player
	if (href_list["mute2"])
		if ((src.rank in list( "Owner", "Coder", "LeadAdministrator", "Administrator", "EventAdmin", "Moderator"  )))
			var/mob/M = locate(href_list["mute2"])
			if (ismob(M))
				if ((M.client && M.client.holder && (M.client.holder.level >= src.level)))
					alert("You cannot perform this action. You must be of a higher administrative rank!", null, null, null, null, null)
					return

				if(M.client.muted || usr.sfIsMuted(M))

					M << "You have been unmuted."
					log_admin("[key_name(usr)] has voiced [key_name(M)].")
					alertAdmins("[key_name_admin(usr)] has voiced [key_name_admin(M)].", 1)
					//file("AdminLog.log")<<"[usr]([usr.key] voiced [M] at [time2text(world.realtime,"Day DD hh:mm")]\n"
					global.MutedList-="[M.client]"
					global.MutedList-="[usr.sfID(M)]"
					M.client.muted = 0
					//MutedList-="[ckey(M.key)]"
					//usr.sfUnMute(M)
					//world << "<font color=red><b>DEBUG1 :: </font>[M] was unmuted. <br> Muted list contains: [list2params(global.MutedList)].</b>"

				else

					var
						time = input("Select an amount of time to mute [M.name] (1 = 1 second)","Mute") as num|null
						reason = input("Why are you muting [M.name] ? (This may be left blank.)","Reason") as text|null

					if( !(time) || time == null)
						src << "You can't have a null time!"
						return
					if( !(reason) || reason == "" || reason == null)
						reason = "Unknown."
					global.MutedList["[M.client]"] = (world.realtime)+(time*10)

					M << "You have been muted by [usr] for [time] seconds for the following reason: \"[reason]\"."
					log_admin("[key_name(usr)] has muted [key_name(M)] for [time] seconds for the following reason: \"[reason]\".")
					alertAdmins("[key_name_admin(usr)] has muted [key_name_admin(M)] for [time] seconds for the following reason: \"[reason]\".", 1)
					for (var/client/C)
						if(C.listen_ooc && C != M) C << "<span class=\"announce\">[usr.key] muted [M.key] for [time] seconds for the following reason: \"[reason]\".</span>"
					//file("AdminLog.log")<<"[usr]([usr.key] muted [M] at [time2text(world.realtime,"Day DD hh:mm")] for [time] seconds for the following reason: \"[reason]\"\n"
					spawn() M.client.MutedCheck()
					M.client.muted = 1

				//M.client.muted = !M.client.muted

	//Force a player to say something
	if (href_list["forcespeech"])
		if ((src.rank in list( "Owner", "Coder", "LeadAdministrator", "Administrator"  )))
			var/mob/M = locate(href_list["forcespeech"])
			if (ismob(M))
				if ((M.client && M.client.holder && (M.client.holder.level >= src.level)))
					alert("You cannot perform this action. You must be of a higher administrative rank!", null, null, null, null, null)
					return
				var/speech = input("What will [key_name(M)] say?.", "Force speech", "")
				speech = copytext(sanitize(speech), 1, MAX_MESSAGE_LEN)
				if(!speech)
					return
				M.Say(speech)
				log_admin("[key_name(usr)] forced [key_name(M)] to say: [speech]")
				alertAdmins("[key_name_admin(usr)] forced [key_name_admin(M)] to say: [speech]")
		else
			alert("You cannot perform this action. You must be of a higher administrative rank!", null, null, null, null, null)

			return

	if (href_list["jumpto"])
		if((src.rank in list("Owner", "Coder", "LeadAdministrator", "Administrator", "EventAdmin", "Moderator") || (istype(src, /mob/observer))))
			var/mob/M = locate(href_list["jumpto"])
			usr.client.jumptomob(M)
			//file("AdminLog.log")<<"[usr]([usr.key] teleported to [M] [time2text(world.realtime,"Day DD hh:mm")]\n"
		else
			alert("You are not a high enough administrator or you aren't observing!")
			return

	if (href_list["summon"])
		if((src.rank in list("Owner", "Coder", "LeadAdministrator", "Administrator", "EventAdmin", "Moderator") || (istype(src, /mob/observer))))
			var/mob/M = locate(href_list["summon"])
			usr.client.Getmob(M)
			//file("AdminLog.log")<<"[usr]([usr.key] summoned [M] [time2text(world.realtime,"Day DD hh:mm")]\n"
		else
			alert("You are not a high enough administrator or you aren't observing!")
			return

	if (href_list["prom_demot"])
		if ((src.rank in list("Owner", "Coder", "LeadAdministrator", "Administrator"  )))
			var/client/C = locate(href_list["prom_demot"])
			if(src != C && C.holder && (C.holder.level >= src.level))
				alert("This cannot be done as [C] is a [C.holder.rank]")
				return
			var/dat = "[C] is a [C.holder ? "[C.holder.rank]" : "non-admin"]<br><br>Change [C]'s rank?<br>"
			if(src.level == 7)
			//leader
				dat += {"
				<A href='?src=\ref[src];chgadlvl=Owner;client4ad=\ref[C]'>Owner</A><BR>
				<A href='?src=\ref[src];chgadlvl=Coder;client4ad=\ref[C]'>Coder</A><BR>
				<A href='?src=\ref[src];chgadlvl=LeadAdministrator;client4ad=\ref[C]'>Lead Administrator</A><BR>
				<A href='?src=\ref[src];chgadlvl=Administrator;client4ad=\ref[C]'>Administrator</A><BR>
				<A href='?src=\ref[src];chgadlvl=EventAdmin;client4ad=\ref[C]'>Event Admin</A><BR>
				<A href='?src=\ref[src];chgadlvl=Moderator;client4ad=\ref[C]'>Moderator</A><BR>
				<A href='?src=\ref[src];chgadlvl=Remove;client4ad=\ref[C]'>Remove Admin</A><BR>"}
			else if(src.level == 6)
			//owner
				dat += {"
				<A href='?src=\ref[src];chgadlvl=Owner;client4ad=\ref[C]'>Owner</A><BR>
				<A href='?src=\ref[src];chgadlvl=Coder;client4ad=\ref[C]'>Coder</A><BR>
				<A href='?src=\ref[src];chgadlvl=LeadAdministrator;client4ad=\ref[C]'>Lead Administrator</A><BR>
				<A href='?src=\ref[src];chgadlvl=Administrator;client4ad=\ref[C]'>Administrator</A><BR>
				<A href='?src=\ref[src];chgadlvl=EventAdmin;client4ad=\ref[C]'>Event Admin</A><BR>
				<A href='?src=\ref[src];chgadlvl=Moderator;client4ad=\ref[C]'>Moderator</A><BR>
				<A href='?src=\ref[src];chgadlvl=Remove;client4ad=\ref[C]'>Remove Admin</A><BR>"}
			else if(src.level == 5)
			//coder
				dat += {"
				<A href='?src=\ref[src];chgadlvl=Coder;client4ad=\ref[C]'>Coder</A><BR>
				<A href='?src=\ref[src];chgadlvl=LeadAdministrator;client4ad=\ref[C]'>Lead Administrator</A><BR>
				<A href='?src=\ref[src];chgadlvl=Administrator;client4ad=\ref[C]'>Administrator</A><BR>
				<A href='?src=\ref[src];chgadlvl=EventAdmin;client4ad=\ref[C]'>Event Admin</A><BR>
				<A href='?src=\ref[src];chgadlvl=Moderator;client4ad=\ref[C]'>Moderator</A><BR>
				<A href='?src=\ref[src];chgadlvl=Remove;client4ad=\ref[C]'>Remove Admin</A><BR>"}
			else if(src.level == 4)
			//LeadAdministrator
				dat += {"
				<A href='?src=\ref[src];chgadlvl=LeadAdministrator;client4ad=\ref[C]'>Lead Administrator</A><BR>
				<A href='?src=\ref[src];chgadlvl=Administrator;client4ad=\ref[C]'>Administrator</A><BR>
				<A href='?src=\ref[src];chgadlvl=EventAdmin;client4ad=\ref[C]'>Event Admin</A><BR>
				<A href='?src=\ref[src];chgadlvl=Moderator;client4ad=\ref[C]'>Moderator</A><BR>
				<A href='?src=\ref[src];chgadlvl=Remove;client4ad=\ref[C]'>Remove Admin</A><BR>"}
			else if(src.level == 3)
			//Administrator
				dat += {"
				<A href='?src=\ref[src];chgadlvl=Administrator;client4ad=\ref[C]'>Administrator</A><BR>
				<A href='?src=\ref[src];chgadlvl=EventAdmin;client4ad=\ref[C]'>Event Admin</A><BR>
				<A href='?src=\ref[src];chgadlvl=Moderator;client4ad=\ref[C]'>Moderator</A><BR>
				<A href='?src=\ref[src];chgadlvl=Remove;client4ad=\ref[C]'>Remove Admin</A><BR>"}
			else
				alert("This cannot happen")
				return
			usr << browse(dat, "window=prom_demot;size=480x300")
	if (href_list["chgadlvl"])
	//change admin level
		var/rank = href_list["chgadlvl"]
		var/client/C = locate(href_list["client4ad"])
		if(src!=src||!src.rank)
			alert("You are not an admin")
			log_admin("[key_name(usr)] tried to Give or Remove [C]'s adminship")
			alertAdmins("[key_name_admin(usr)] tried to Give or Remove [C]'s adminship", 1)
			return
		if(rank == "Remove")
			C.clear_admin_verbs()
			C.update_admins(null)
			log_admin("[key_name(usr)] has removed [C]'s adminship")
			alertAdmins("[key_name_admin(usr)] has removed [C]'s adminship", 1)
			admins.Remove(C.ckey)
			world.save_admins()
		else
			C.clear_admin_verbs()
			C.update_admins(rank)
			log_admin("[key_name(usr)] has made [C] a [rank]")
			alertAdmins("[key_name_admin(usr)] has made [C] a [rank]", 1)
			admins[C.ckey] = rank
			world.save_admins()


	//Spawning objects
	/*
	if (href_list["object_list"])
		if (src.holder.level >= 5)
			var/atom/loc = usr.loc

			var/dirty_paths
			if (istext(href_list["object_list"]))
				dirty_paths = list(href_list["object_list"])
			else if (istype(href_list["object_list"], /list))
				dirty_paths = href_list["object_list"]

			var/paths = list()
			var/removed_paths = list()
			for (var/dirty_path in dirty_paths)
				var/path = text2path(dirty_path)
				if (!path)
					removed_paths += dirty_path
				else if (!ispath(path, /obj) && !ispath(path, /turf) && !ispath(path, /mob))
					removed_paths += dirty_path
				else if (ispath(path, /mob) && !(src.rank in list("Primary Administrator", "Coder", "Owner")))
					removed_paths += dirty_path
				else
					paths += path

			if (!paths)
				return
			else if (length(paths) > 5)
				alert("Select less object types, jerko.")
				return
			else if (length(removed_paths))
				alert("Removed:\n" + dd_list2text(removed_paths, "\n"))

			var/list/offset = dd_text2list(href_list["offset"],",")
			var/number = dd_range(1, 100, text2num(href_list["object_count"]))
			var/X = offset.len > 0 ? text2num(offset[1]) : 0
			var/Y = offset.len > 1 ? text2num(offset[2]) : 0
			var/Z = offset.len > 2 ? text2num(offset[3]) : 0

			for (var/i = 1 to number)
				switch (href_list["offset_type"])
					if ("absolute")
						for (var/path in paths)
							new path(locate(0 + X,0 + Y,0 + Z))

					if ("relative")
						if (loc)
							for (var/path in paths)
								new path(locate(loc.x + X,loc.y + Y,loc.z + Z))
						else
							return

			if (number == 1)
				log_admin("[key_name(usr)] created a [english_list(paths)]")
				for(var/path in paths)
					if(ispath(path, /mob))
						alertAdmins("[key_name_admin(usr)] created a [english_list(paths)]", 1)
						break
			else
				log_admin("[key_name(usr)] created [number]ea [english_list(paths)]")
				for(var/path in paths)
					if(ispath(path, /mob))
						alertAdmins("[key_name_admin(usr)] created [number]ea [english_list(paths)]", 1)
						break
			return
		else
			alert("You cannot spawn items right now.")
			return
*/
	//Boot
	if (href_list["boot2"])
		if ((src.rank in list( "Owner", "Coder", "LeadAdministrator", "Administrator", "EventAdmin", "Moderator"  )))
			var/mob/M = locate(href_list["boot2"])
			if (ismob(M))
				if ((M.client && M.client.holder && (M.client.holder.level >= src.level)))
					alert("You cannot perform this action. You must be of a higher administrative rank!", null, null, null, null, null)
					return
				var/reason = input("Why are you booting them?") as text
				if(!reason){usr << "You need a reason to boot someone.";return}
				log_admin("[key_name(usr)] booted [key_name(M)] with reason: \"[reason]\".")
				alertAdmins("[key_name_admin(usr)] booted [key_name_admin(M)] with reason: \"[reason]\".", 1)
				var/punter = M.client.key
				if(M.client){M<<"[usr.key] has booted you with reason: \"[reason]\".";del(M.client)}
				if(M)		{M<<"[usr.key] has booted you with reason: \"[reason]\".";del(M)}
				//file("AdminLog.log")<<"[usr]([usr.key] booted [M] [time2text(world.realtime,"Day DD hh:mm")]"

				for (var/client/C)
					if(C.listen_ooc) C << "<span class=\"announce\">SERVER: [usr.client.key] booted [punter] for the following reason: \"[reason]\".</span>"


	//Bans
	if (href_list["newban"])
		if ((src.rank in list( "Owner", "Coder", "LeadAdministrator", "Administrator")))
			var/mob/M = locate(href_list["newban"])
			if(!ismob(M)) return
			if ((M.client && M.client.holder && (M.client.holder.level >= src.level)))
				alert("You cannot perform this action. You must be of a higher administrative rank!")
				return
			switch(alert("Temporary Ban?",,"Yes","No"))
				if("Yes")
					var/mins = input(usr,"How long (in minutes)?","Ban time",1440) as num
					if(!mins)
						return
					if(mins >= 525600) mins = 525599
					var/reason = input(usr,"Reason?","reason","Griefer") as text
					if(!reason)
						return
					AddBan(M.ckey, M.computer_id, reason, usr.ckey, 1, mins)
					M << "\red<BIG><B>You have been banned by [usr.client.ckey].\nReason: [reason].</B></BIG>"
					M << "\red This is a temporary ban, it will be removed in [mins] minutes."
					M << "\red To try to resolve this matter head to http://dbzphoenix.proboards.com/index.cgi"
					log_admin("[usr.client.ckey] has banned [M.ckey].\nReason: [reason]\nThis will be removed in [mins] minutes.")
					alertAdmins("[usr.client.ckey] has banned [M.ckey].\nReason: [reason]\nThis will be removed in [mins] minutes.")
					//file("AdminLog.log")<<"[usr]([usr.key] has temporarily banned [M] for [reason] for [mins] minutes at [time2text(world.realtime,"Day DD hh:mm")]\n"
					var/punter = M.client.key
					del(M.client)
					del(M)

					for (var/client/C)
						if(C.listen_ooc) C << "<span class=\"announce\">SERVER: [usr.client.key] banned [punter] for [mins] minutes for the following reason: \"[reason]\".</span>"

				if("No")
					var/reason = input(usr,"Reason?","reason","Griefer") as text
					if(!reason)
						return
					AddBan(M.ckey, M.computer_id, reason, usr.ckey, 0, 0)
					M << "\red<BIG><B>You have been banned by [usr.client.ckey].\nReason: [reason].</B></BIG>"
					M << "\red This is a permanent ban."
					M << "\red To try to resolve this matter head to http://dbzphoenix.proboards.com/index.cgi"
					log_admin("[usr.client.ckey] has banned [M.ckey].\nReason: [reason]\nThis is a permanent ban.")
					alertAdmins("[usr.client.ckey] has banned [M.ckey].\nReason: [reason]\nThis is a permanent ban.")
					//file("AdminLog.log")<<"[usr]([usr.key] has permanently banned [M] for [reason] at [time2text(world.realtime,"Day DD hh:mm")]\n"
					var/punter = M.client.key
					del(M.client)
					del(M)

					for (var/client/C)
						if(C.listen_ooc) C << "<span class=\"announce\">[usr.client.key] banned [punter] for the following reason: \"[reason]\".<br>This is a permanent ban.</span>"


	if(href_list["unbanf"])
		var/banfolder = href_list["unbanf"]
		Banlist.cd = "/base/[banfolder]"
		var/key = Banlist["key"]
		if(alert(usr, "Are you sure you want to unban [key]?", "Confirmation", "Yes", "No") == "Yes")
			if (RemoveBan(banfolder))
				unbanpanel()
			else
				alert(usr,"This ban has already been lifted / does not exist.","Error","Ok")
				unbanpanel()

	if(href_list["unbane"])
		UpdateTime()
		var/reason
		var/mins = 0
		var/banfolder = href_list["unbane"]
		Banlist.cd = "/base/[banfolder]"
		var/reason2 = Banlist["reason"]
		var/temp = Banlist["temp"]
		var/minutes = (Banlist["minutes"] - CMinutes)
		if(!minutes || minutes < 0) minutes = 0
		var/banned_key = Banlist["key"]
		Banlist.cd = "/base"

		switch(alert("Temporary Ban?",,"Yes","No"))
			if("Yes")
				temp = 1
				mins = input(usr,"How long (in minutes)? (Default: 1440)","Ban time",minutes ? minutes : 1440) as num
				if(!mins||mins==0||mins<0)
					return
				if(mins >= 525600) mins = 525599
				reason = input(usr,"Reason?","reason",reason2) as text
				if(!reason)
					return
			if("No")
				temp = 0
				reason = input(usr,"Reason?","reason",reason2) as text
				if(!reason)
					return

		log_admin("[key_name(usr)] edited [banned_key]'s ban. Reason: [reason] Duration: [GetExp(mins)]")
		alertAdmins("[key_name_admin(usr)] edited [banned_key]'s ban. Reason: [reason] Duration: [GetExp(mins)]", 1)
		Banlist.cd = "/base/[banfolder]"
		Banlist["reason"] << reason
		Banlist["temp"] << temp
		Banlist["minutes"] << (mins + CMinutes)
		Banlist["bannedby"] << usr.ckey
		Banlist.cd = "/base"
		unbanpanel()

	if(href_list["readmind"])
		if ((src.rank in list( "Owner", "Coder", "LeadAdministrator", "Administrator", "EventAdmin" )))
			var/mob/M = locate(href_list["readmind"])
			if(!M.mind)
				alert("[key_name(M)] has no mind! That is a problem!")
				return
			M.mind.show_memory(usr)
			log_admin("[key_name(usr)] read the memory of [key_name(M)]")
		else
			alert("You cannot perform this action. You must be of a higher administrative rank!", null, null, null, null, null)
			return

	if(href_list["heal"])
		if ((src.rank in list( "Owner", "Coder", "LeadAdministrator", "Administrator", "EventAdmin" )))
			var/mob/M = locate(href_list["heal"])
			if(M.icon_state=="KO")
				M.Un_KO()
			M.Health = 100
			M.Ki = M.MaxKi
			log_admin("[key_name(usr)] healed [key_name(M)]")
			alertAdmins("[key_name(usr)] healed [key_name(M)]")
			//file("AdminLog.log")<<"[usr]([usr.key] healed[M] at [time2text(world.realtime,"Day DD hh:mm")]\n"

		else
			alert("You cannot perform this action. You must be of a higher administrative rank!", null, null, null, null, null)
			return

	if(href_list["revive"])
		if ((src.rank in list( "Owner", "Coder", "LeadAdministrator", "Administrator", "EventAdmin" )))
			var/mob/M = locate(href_list["revive"])
			if(M.Dead)
				M.Revive()
				log_admin("[key_name(usr)] revived [key_name(M)]")
				alertAdmins("[key_name(usr)] revived [key_name(M)]")
				//file("AdminLog.log")<<"[usr]([usr.key] revived [M] at [time2text(world.realtime,"Day DD hh:mm")]\n"
			else
				alert("[M.name] is not dead!")
				return
		else
			alert("You cannot perform this action. You must be of a higher administrative rank!", null, null, null, null, null)
			return

//observe
	if(href_list["observe"])
		if ((src.rank in list( "Owner", "Coder", "LeadAdministrator", "Administrator")))
			var/mob/M = locate(href_list["observe"])
			usr.reset_view(M)
		else
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
//subtlemessage
	if(href_list["subtlemessage"])
		if(src.level >= 2)
			var/mob/M = locate(href_list["subtlemessage"])
			usr.client.cmd_admin_subtle_message(M)
		else
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return

//privatemessage
	if(href_list["privatemessage"])
		if(src.level >= 1)
			var/mob/M = locate(href_list["privatemessage"])
			usr.client.cmd_admin_pm(M)
		else
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return

//giveobj
	if(href_list["giveobj"])
		if(src.level >= 2)
			var/mob/M = locate(href_list["giveobj"])
			usr.client.Give(M)
			//file("AdminLog.log")<<"[usr]([usr.key] gave [M] to [usr] [time2text(world.realtime,"Day DD hh:mm")]\n"
		else
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return

//assess
	if(href_list["assess"])
		if(src.level >= 1)
			var/mob/M = locate(href_list["assess"])
			usr.client.Assess(M)
		else
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return

//kill
	if(href_list["kill"])
		if(src.level >= 3)
			var/mob/M = locate(href_list["kill"])
			usr.client.Kill(M)
			//file("AdminLog.log")<<"[usr]([usr.key] admin killed [M] at [time2text(world.realtime,"Day DD hh:mm")]\n"
		else
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return

//knockout
	if(href_list["knockout"])
		var/mob/M = locate(href_list["knockout"])
		usr.client.Knockout(M)
			//file("AdminLog.log")<<"[usr]([usr.key] admin KOed [M] at [time2text(world.realtime,"Day DD hh:mm")]\n"

//send to spawn
	if(href_list["sendToSpawn"])
		if(src.level >= 2)
			var/mob/M = locate(href_list["sendToSpawn"])
			usr.client.sendToSpawn(M)
		else
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return


//Player options
	if (href_list["adminplayeropts"])
		var/mob/M = locate(href_list["adminplayeropts"])
		if(!ismob(M))
			return
		var/dat = "<html><head><title>Options for [M.key]</title></head>"
		var/foo = "\[ "
		if(M.client)
			foo += text("<A HREF='?src=\ref[src];prom_demot=\ref[M.client]'>Promote/Demote</A> | ")
			//foo += text("<A href='?src=\ref[src];mute2=\ref[M]'>Mute: [M.client.muted ? "Muted" : usr.client.sfIsMuted(M.client ? "Muted" : "Voiced"]</A> | ")
			foo += text("<A href='?src=\ref[src];mute2=\ref[M]'>Mute: [M.client.muted ? "Muted" : usr.sfIsMuted(M.client) ? "Muted" : "Voiced"]</A> | ")
			foo += text("<A href='?src=\ref[src];subtlemessage=\ref[M]'>Subtle Message</A> | ")
			foo += text("<A href='?src=\ref[src];privatemessage=\ref[M]'>Private Message</A> | ")
			if (Players.Find(M))
				foo += text("<A HREF='?src=\ref[src];observe=\ref[M]'>Watch</A> | ")
				foo += text("<A HREF='?src=\ref[src];sendToSpawn=\ref[M]'>Send to Spawn</A> | ")
				foo += text("<A HREF='?src=\ref[src];assess=\ref[M]'>Assess</A> | ")
				foo += text("<A HREF='?src=\ref[src];giveobj=\ref[M]'>Give Obj</A> | ")
				foo += text("<A HREF='?src=\ref[src];kill=\ref[M]'>Kill</A> | ")
				foo += text("<A HREF='?src=\ref[src];knockout=\ref[M]'>Knockout</A> | ")
				foo += text("<A HREF='?src=\ref[src];heal=\ref[M]'>Heal</A> | ")
				foo += text("<A HREF='?src=\ref[src];revive=\ref[M]'>Revive</A> | ")
				foo += text("<A HREF='?src=\ref[src];readmind=\ref[M]'>R-Memory</A> | ")
				foo += text("<A HREF='?src=\ref[src];getlog=[M.lastKnownKey];portion=0'>Check Log</A> | ")
				foo += text("<A HREF='?src=\ref[src];forcespeech=\ref[M]'>Say</A> | ")
				foo += text("<A href='?src=\ref[src];summon=\ref[M]'>Summon</A> | ")
				foo += text("<A href='?src=\ref[src];jumpto=\ref[M]'>Jump to</A> | ")
				foo += text("<A href='?src=\ref[src];command=edit;target=\ref[M];type=view;'>Edit</A> | ")
		foo += text("<A href='?src=\ref[src];boot2=\ref[M]'>Boot</A> | ")
		foo += text("<A href='?src=\ref[src];newban=\ref[M]'>Ban</A> \]")
		dat += text("<body>[foo]</body></html>")
		usr << browse(dat, "window=adminplayeropts;size=480x100")

/mob/proc/sfIsMuted(var/M)

	//call(/sf_SpamFilter/proc/sf_IsMuted)(M)
	//gSpamFilter.sf_IsMuted(M)


	//if(src==null) src = usr
	if(!M) return FALSE
	M							= src.sfID(M)
	if (!(M in global.MutedList))	return FALSE
	return (global.MutedList[M] > world.realtime)


	return TRUE

/mob/proc/sfID(var/Chatter)
	if ( istype(Chatter,/client) )
		var/client/C	= Chatter
		return ckey(C.key)
	if ( ismob(Chatter) )
		var/mob/M	= Chatter
		return ckey(M.key)
	return null

/mob/proc/sfUnMute(var/M)

//	gSpamFilter.sf_UnMute(M)

	var/id	= src.sfID(M)
	if (id in global.MutedList)
		global.MutedList	-= id
		//world << "<font color=red><b>DEBUG71 :: </font>[M] was unmuted. <br> Muted list contains: [list2params(global.MutedList)].</b><br>called by [src]"

		M << "<font color=yellow><b>SYSTEM :: </font>You have been unmuted.</b>"

		return TRUE

	//call(/sf_SpamFilter/proc/sf_Unmute)(M)
//	return TRUE


/client/proc/get_admin_state()
	set category = "Debug"
	if(!usr.client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	for(var/mob/M in world)
		if(M.client && M.client.holder)
			if(M.client.holder.state == 1)
				src << "[M.key] is playing - [M.client.holder.state]"
			else if(M.client.holder.state == 2)
				src << "[M.key] is observing - [M.client.holder.state]"
			else
				src << "[M.key] is undefined - [M.client.holder.state]"



/*
/obj/admins/proc/Edit(atom/A in world)
	set category = "Admin"
	set name = "Edit Variables"

	if (!usr.client.holder)
		src << "Only administrators may use this command."
		return
	if (!A)
		alert("Object no longer exists!")
		return

	var/Edit = "<Edit><body bgcolor=#000000 text=#339999 link=#99FFFF>"
	var/list/B = new
	Edit += "[A]<br>[A.type]"
	Edit += "<table width=10%>"
	for(var/C in A.vars)
		B.Add(C)
	for(var/C in B)
		Edit += "<td><a href=byond://?src=\ref[src];edit=\ref[A];var=[C]>"
		Edit += C
		Edit += "<td>[Value(A.vars[C])]</td></tr>"

	usr << browse(Edit,"window=[A];size=350x500")
*/

/client/proc/listen_admin_alerts()
	set category = "Admin"
	set name = "(Un)Mute Admin Alerts"

	if (!src.holder)
		src << "Only administrators may use this command."
		return

	src.holder.listen_Alerts = !(src.holder.listen_Alerts)
	if (src.holder.listen_Alerts)
		src << "You are now listening to admin alerts."
	else
		src << "You are no longer listening to admin alerts."

/client/proc/listen_admin_logins()
	set category = "Admin"
	set name = "(Un)Mute Player Logins"

	if (!src.holder)
		src << "Only administrators may use this command."
		return

	src.holder.listen_Logins = !(src.holder.listen_Logins)
	if (src.holder.listen_Logins)
		src << "You are now listening to player logins."
	else
		src << "You are no longer listening to player logins."

/client/proc/listen_admin_chat()
	set category = "Admin"
	set name = "(Un)Mute Admin Chat"

	if (!src.holder)
		src << "Only administrators may use this command."
		return

	src.holder.listen_Chat = !(src.holder.listen_Chat)
	if (src.holder.listen_Chat)
		src << "You are now listening to admin chat."
	else
		src << "You are no longer listening to admin chat."

/client/proc/cmd_admin_subtle_message(mob/player/M as mob in world)
	set category = "Admin"
	set name = "Subtle Message"

	if (!src.holder)
		src << "Only administrators may use this command."
		return

	var/msg = input("Message:", text("Subtle PM to [M.key]")) as text

	if (!msg)
		return
	if (usr.client && usr.client.holder)
		M << "You hear a voice in your head... <span class=\"subtle_message\">[msg]<span>"

	log_admin("SubtlePM: [key_name(usr)] -> [key_name(M)] : [msg]")
	alertAdmins("SubtleMessage: [key_name_admin(usr)] -> [key_name_admin(M)] : [msg]", 1)

/client/proc/cmd_admin_pm(mob/player/M as mob in world)
	set category = "Admin"
	set name = "Admin PM"
	if(!src.holder)
		src << "Only administrators may use this command."
		return
	if(M)
		var/X = M.key
		if(src.muted)
			src << "You are muted have a nice day"
			return
		if (!( ismob(M) ))
			return
		var/t = input("Message:", text("Private message to [X]"))  as text
		if(src.holder.rank != "Coder" && src.holder.rank != "Owner")
			t = strip_html(t,500)
		if (!( t ))
			return
		if (usr.client && usr.client.holder)
			if(M)
				M << "<span class=\"admin\">Admin PM from-<b>[key_name(usr, M, 0)]:</b> [t]</span>"
				usr << "<span class=\"admin\">Admin PM to-<b>[key_name(M, usr, 1)]:</b> [t]</span>"
		else
			if(M)
				if (M.client && M.client.holder)
					M << "<span class=\"admin\">Reply PM from-<b>[key_name(usr, M, 1)]:</b> [t]</span>"
				else
					M << "<span class=\"admin\">Reply PM from-<b>[key_name(usr, M, 0)]:</b> [t]</span>"
				usr << "<span class=\"admin\">Reply PM to-<b>[key_name(M, usr, 0)]:</b> [t]</span>"

		log_admin("PM: [key_name(usr)]->[key_name(M)] : [t]")

		for(var/mob/K in Players)	//we don't use alertAdmins here because the sender/receiver might get it too
			if(K && K.client && K.client.holder && K.client.holder.listen_Chat && K.key != usr.key && K.key != M.key)
				K << "<span class=\"admin\"><B>PM: [key_name(usr, K)]-&gt;[key_name(M, K)]:</B> [t]</span>"

/*
/client/proc/cmd_admin_godmode(mob/M as mob in world)
	set category = "Admin"
	set name = "Toggle Godmode"
	if(!src.holder)
		src << "Only administrators may use this command."
		return
	if (M.nodamage == 1)
		M.nodamage = 0
		usr << "\blue Toggled OFF"
	else
		M.nodamage = 1
		usr << "\blue Toggled ON"

	log_admin("[key_name(usr)] has toggled [key_name(M)]'s nodamage to [(M.nodamage ? "On" : "Off")]")
	alertAdmins("[key_name_admin(usr)] has toggled [key_name_admin(M)]'s nodamage to [(M.nodamage ? "On" : "Off")]", 1)
*/

/client/proc/cmd_admin_mute(mob/player/C as mob in world)
	set category = "Admin"
	set name = "Toggle Mute"
	if(!src.holder)
		alert("Only administrators may use this command.")
		return

	if(!ismob(C))
		alert("[C] has no mob!")
		return

	if (C.client && C.client.holder && (C.client.holder.level >= src.holder.level))
		alert("You cannot perform this action. You must be of a higher administrative rank!", null, null, null, null, null)
		return


	if(C.client.muted || usr.sfIsMuted(C))

		C << "You have been unmuted."
		log_admin("[key_name(usr)] has voiced [key_name(C)].")
		alertAdmins("[key_name_admin(usr)] has voiced [key_name_admin(C)].", 1)
		//file("AdminLog.log")<<"[usr]([usr.key] voiced [C] at [time2text(world.realtime,"Day DD hh:mm")]\n"
		global.MutedList-="[C.client]"
		global.MutedList-="[usr.sfID(C)]"
		C.client.muted = 0
		//usr.sfUnMute(C)
		//world << "<font color=red><b>DEBUG2 :: </font>[C] was unmuted. <br> Muted list contains: [list2params(global.MutedList)].</b>"

	else

		var
			time = input("Select an amount of time to mute [C.name] (1 = 1 second)","Mute") as num|null
			reason = input("Why are you muting [C.name] ? (This may be left blank.)","Reason") as text|null

		if( !(time) || time == null)
			src << "You can't have a null time!"
			return
		if( !(reason) || reason == "" || reason == null)
			reason = "Unknown."
		global.MutedList["[C.client]"] = (world.realtime)+(time*10)

		C << "You have been muted for [time] seconds for the following reason: \"[reason]\"."
		log_admin("[key_name(usr)] has muted [key_name(C)] for [time] seconds for the following reason: \"[reason]\".")
		alertAdmins("[key_name_admin(usr)] has muted [key_name_admin(C)] for [time] seconds for the following reason: \"[reason]\".", 1)
		for (var/client/P)
			if(P.listen_ooc && P != C) P << "<span class=\"announce\">[usr.client.key] muted [C.client.key] for [time] seconds for the following reason: \"[reason]\".</span>"
		//file("AdminLog.log")<<"[usr]([usr.key] muted [C] at [time2text(world.realtime,"Day DD hh:mm")] for [time] seconds for the following reason: \"[reason]\"\n"
		spawn() C.client.MutedCheck()
		C.client.muted = 1

	//C.client.muted = !C.client.muted

/client/proc/allow_rares(var/client/C in world) // Yes. WORLD. Incase they havn't made a character yet.
	set category = "Admin"
	set name = "Allow Rares"
	set desc = "Allow this particulair player to chose a rare race."
	if(!ismob(C))
		return
	if(!src.holder)
		alert("Only administrators may use this command.")
		return

	if(src.holder.level < 4)
		alert("Only administrators may use this command.")
		return

	if(!AllowRares)AllowRares=new

	if(C.ckey in AllowRares)
		AllowRares-=C.ckey
		if(!AllowRares|!AllowRares.len) AllowRares=null
		log_admin("[key_name(src)] has removed the ability to create any race from [key_name(C)].")
		alertAdmins("[key_name_admin(src)] has removed the ability to create any race from [key_name(C)].", 1)
		C << "An admin has removed your ability to make all races."
		return
	else AllowRares+=C.ckey

	log_admin("[key_name(src)] has granted the ability to create any race to [key_name(C)].")
	alertAdmins("[key_name_admin(src)] has granted the ability to create any race to [key_name(C)].", 1)
	C << "An admin has granted you the ability to make all races. It's assumed you know how to handle this responsibly."

proc/ghostDens_check(atom/A)
	if(istype(A,/mob/player))
		var/mob/player/_player=A
		if(_player.adminDensity) return TRUE
		else return FALSE


mob/Admin2/verb

	Ghost_Form()
		set category = "Admin"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		if(usr.adminDensity)
			usr.adminDensity=0
			usr.density=1
			usr.immortal=0
			usr.invisibility = 0
			view(usr) << "([usr.key])[usr] disables their admin ghost form."
			log_admin("[key_name(usr)] exits ghost form.")
		else
			usr.adminDensity=1
			usr.density=0
			usr.immortal=1
			usr.invisibility = 100
			view(usr) << "([usr.key])[usr] activates their admin ghost form."
			log_admin("[key_name(usr)] enters ghost form.")

	Spam_Control()
		set category = "Admin"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		if(!gSpamFilter.sf_AddInterface(usr.client)) return FALSE
		//gSpamFilter.sf_AddInterface(src.client)
		alertAdmins("[key_name_admin(src)] is now editing the Spam Control settings.", 1)
		//winshow(src,"options_chat", 1)

	XYZTeleport(mob/M in Players)
		set category="Admin"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		if(!usr.client.holder||usr.client.holder.level<2) return
		usr<<"This will send the mob you choose to a specific xyz location."
		var/xx=input("X Location?") as num
		var/yy=input("Y Location?") as num
		var/zz=input("Z Location?") as num

		switch(input("Are you sure?") in list ("Yes", "No",))
			if("Yes")
				M.loc=locate(xx,yy,zz)
				logAndAlertAdmins("[key_name_admin(src)] used XYZTeleport on [M] to ([M.x],[M.y],[M.z])",2)

	Warper()
		set category="Admin"
		//if(!src.client.holder||src.client.holder.level<2) return
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		if(usr)
			var/obj/Warper/A=new(locate(usr.x,usr.y,usr.z))
			A.gotox=input("x location to send to") as num
			A.gotoy=input("y") as num
			A.gotoz=input("z") as num
			logAndAlertAdmins("[key_name_admin(src)] created a warper at ([A.x],[A.y],[A.z])",2)

	Give_Warpers(var/mob/player/M in Players)
		set category="Admin"
		if(!usr.client.holder||usr.client.holder.level<2) return
		M.verbs += /mob/Admin2/verb/Warper
		logAndAlertAdmins("[key_name_admin(src)] has given the Warper verb to [M]")

	Remove_Warpers(var/mob/player/M in Players)
		set category="Admin"
		if(!usr.client.holder||usr.client.holder.level<2) return
		M.verbs -= /mob/Admin2/verb/Warper
		logAndAlertAdmins("[key_name_admin(src)] has removed the Warper verb from [M]")

	Remove_Doubles()
		set category = "Admin"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		var/count=0
		for (var/mob/player/M in world)
			if(!M.client)
				del(M)
				count++

/*
			if(!M.status_event)
				del(M)
				count++

			if(M.status_event&&!M.client)
				del(M)
				count++
*/

		logAndAlertAdmins("[key_name_admin(src)] has removed [count] player mobs with no client.")

mob/Admin1/verb

	LocateAndroidShips()
		set category = "Admin"
		if(!usr.client.holder||usr.client.holder.level<1) return
		var/count
		for(var/obj/AndroidShips/A in world)
			src << "AndroidShip found at ([A.x],[A.y],[A.z])"
			count++
		if(count>=2)
			switch(alert("Found more then one AndroidShip, delete duplicates?",,"Yes","No"))
				if("Yes")
					SpawnAndroidShip()
					src << "Done."
				else return
		if(count<=0)
			switch(alert("Found NO AndroidShips, create one?",,"Yes","No"))
				if("Yes")
					SpawnAndroidShip()
					src << "Done."
				else return

	Objects()
		set category="Admin"
		if(!usr.client.holder||usr.client.holder.level<1) return
		var/amount=0
		for(var/turf/A) amount++
		src<<"Turfs: [amount]"
		amount=0

		for(var/turf/A in Turfs) amount++
		src<<"Player built Turfs: [amount]"
		amount=0

		for(var/obj/A in global.worldObjectList)
			if(A.Savable||istype(A,/obj/TrainingEq))
				amount++
		src<<"Player made objects: [amount]"
		amount=0

		for(var/obj/A) amount++
		src<<"Objects: [amount]"
		amount=0

		for(var/obj/Drill/A) amount ++
		src<<"Drills: [amount]"
		amount=0

		for(var/mob/A) amount++
		src<<"Mobs: [amount]"
		amount=0

		for(var/NPC_AI/A) amount++
		src<<"NPCs: [amount]"
		amount=0

		for(var/mob/Drone/A) amount++
		src<<"Drones: [amount]"

	IP(mob/M in Players)
		set category="Admin"
		if(!usr.client.holder||usr.client.holder.level<1) return
		if(M)
			if(M.client)
				src<<"[M] ([M.key]), \[ IP [M.client.address] || PCID : [M.client.computer_id] \]"
				for(var/mob/player/A in world)
					if(M == A) continue
					if(A.client&&((M.client.address==A.client.address)&&(M.client.computer_id==A.client.computer_id)))
						src<<"<font size=1 color=\"red\">   Multikey: [A] ([A.key]) \[ IP [A.client.address] || PCID : [A.client.computer_id] \]</font>"
					if(A.client&&((M.client.address==A.client.address)&&(M.client.computer_id!=A.client.computer_id)))
						src<<"<font size=1 color=\"#FF8040\">   Different computer_id: [A] ([A.key]) \[ IP [A.client.address] || PCID : [A.client.computer_id] \]</font>"


	IPs()
		set category="Admin"
		if(!usr.client.holder||usr.client.holder.level<1) return
		for(var/mob/player/A in world) if(A.client)
			var/Address=A.client.address
			usr<<"[A.key]: [Address]"

var/list/DEBUGLIST=new // Temporary list

sf_SpamFilter/Phoenix

/*
 * SPAM FILTER
 */

	sf_AddInterface(client/C)
		. = ..(C)
		if (.)
			winshow(C,"options_chat", 1)

	sf_RemoveInterface(client/C)

		. = ..(C)
		if (.) winshow(C,"options_chat", 0)

	sf_UpdateDisplay(client/Viewer)
		.			= ..(Viewer)
		if (.)
			Viewer	<< output(src.sf_maxLength,"sf_Max_Length")
			Viewer	<< output(src.sf_punishment/600,"sf_Punishment")
			Viewer	<< output(src.sf_maxChatsPerPeriod,"sf_Max_Chats_Per_Period")
			Viewer	<< output(src.sf_period/10,"sf_Period")


/*
 * END SPAM FILTER
 */


mob/Admin3/verb/ManualBan()

	set category="Admin"
	if(!usr.client.holder||usr.client.holder.level<3) return
	src << "To manual ban a player at least ONE of the pop ups need to be filled in."
	var/keyname = ckey(input(src, "What is the name of their BYOND key?","Keyname?","") as text)
	var/pc_id = input(src,"What is their IP or computer_id?","IP/PC_ID","") as text
	if(!keyname&&!pc_id){ src<<"Need atleast a key OR an IP OR a computer_id!"; return }
	switch(alert("Temporary Ban?",,"Yes","No"))

		if("Yes")
			var/mins = input(src,"How long (in minutes)?","Ban time",1440) as num
			if(!mins||mins==0||mins<0)
				return
			if(mins >= 525600) mins = 525599
			var/reason = input(usr,"Reason?","reason","Griefer") as text
			if(!reason)
				return
			AddBan(keyname, pc_id, reason, src.ckey, 1, mins)
			log_admin("[src] has manual banned [keyname] || [pc_id].\nReason: [reason]\nThis will be removed in [mins] minutes.")
			alertAdmins("[src] has manual banned [keyname] || [pc_id].\nReason: [reason]\nThis will be removed in [mins] minutes.")
			//file("AdminLog.log")<<"[src]([src.key]) has temporarily manual banned [keyname] for [reason] for [mins] minutes at [time2text(world.realtime,"Day DD hh:mm")]\n"

		if("No")
			var/reason = input(usr,"Reason?","reason","Griefer") as text
			if(!reason)
				return
			AddBan(keyname, pc_id, reason, src.ckey, 0, 0)
			log_admin("[src] has manual banned [keyname] || [pc_id].\nReason: [reason]\nThis is a permanent ban.")
			alertAdmins("[src] has manual banned [keyname] || [pc_id].\nReason: [reason]\nThis is a permanent ban.")
			//file("AdminLog.log")<<"[src]([src.key]) has permanently manual banned [keyname] for [reason] at [time2text(world.realtime,"Day DD hh:mm")]\n"

mob/Admin4/verb

	Terraform()
		set category="Admin"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		var/list/list1=new
		list1+=typesof(/turf)
		var/turf/Choice=input("Replace all turfs with what?") in list1
		for(var/turf/T in block(locate(1,1,z),locate(world.maxx,world.maxy,z)))
			if(prob(1)) sleep(1)
			if(!T.Savable) new Choice(T)
		logAndAlertAdmins("[src.key] used Terraform and replaced with [Choice]",4)


	Give_ShadowSpar(var/mob/player/P in Players)
		set category= "Admin"
		if(!usr.client.holder||usr.client.holder.level<4) return
		return


	Remove_Rares()
		set category= "Admin"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		src << "[AllowRares] list is [global.AllowRares.len] long."
		src << "[AllowRares] contains:"
		var/list/rarelist = new
		for(var/I in AllowRares)
			src << "[I]"
			rarelist+=I
		rarelist+="Cancel"
		var/choice = input("Remove who from the rares list?","Rare removal") in rarelist
		switch(choice)
			if("Cancel")
				return
			else
				for(var/i in AllowRares)
					AllowRares-=choice
					src << "You removed; [choice]"

	Strip_Admin()
		set category= "Admin"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		var/list/adminlist = new
		var/choicelevel

		src << "adminlist is [admins.len] long"

		for(var/i in admins)
			if(i=="WtfDontBanMe") continue
			adminlist+=i
			src << "ADMIN: [i] = [admins[i]]"

		adminlist+="Cancel"

		var/choice = input("Remove which admin?","Admin removal") in adminlist
		switch(choice)
			if("Cancel")
				return
			else

				for(var/i in admins)
					if(i=="WtfDontBanMe") continue
					if(i=="[choice]")
						switch(admins[i])
							if("Leader") choicelevel = 7
							if("Owner") choicelevel = 6
							if("Coder") choicelevel = 5
							if("LeadAdministrator") choicelevel = 4
							if("Administrator") choicelevel = 3
							if("EventAdmin") choicelevel = 2
							if("Moderator") choicelevel = 1
						break

				if(usr.client.holder.level > choicelevel)
					src << "You removed; [choice]"
					admins-=choice
				else
					src << "Their admin level exceeds or equals yours."
	Current_Staff()

		set category= "Admin"
		for(var/i in admins)
			src << "ADMIN: [i] = [admins[i]]"

	Force_Month_Change()
		set category = "Admin"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		switch(input(usr, "Are you sure you want to force a month change?") in list("No", "Yes"))
			if("Yes")
				Resources()
				Year+=0.1
				//if(round(Year,0.1)==round(Year,0.5)) world.Repop()
				var/obj/items/Android_Upgrade/AU = new
				for(var/obj/items/Main_Frame/X in worldObjectList)
					AU.loc = X
					break
				spawn for(var/mob/player/A in world)
					if(A.lastKnownKey&&A.client)
						//log_errors("Updating year for [A] ([A.x],[A.y],[A.z])")
						A.Age_Update()
						//log_errors("Year updated for [A] ([A.x],[A.y],[A.z])")
						if(A.Counterpart) for(var/mob/player/B in world) if(A.Counterpart=="[B]([B.key])"&&B.Race==A.Race)
							B.Counterpart="[A]([A.key])"
							if(A.Gain_Multiplier<B.Gain_Multiplier) A.Gain_Multiplier=B.Gain_Multiplier
							A<<"<span class=\"narrate\">Your gain has equaled your counterpart, [A.Counterpart]</span>"
						if(round(Year,0.1)==round(Year))
							A<<"<span class=\"narrate\">The moon comes out!</span>"
							for(var/obj/Oozaru/B in A)
								if(!A.Tail&&A.Age<16) A.Tail_Add()
								if(B.Setting) A.Oozaru()
						if(round(Year,0.1)==round(Year,10))
							A<<"<span class=\"narrate\">The Makyo Star approaches the planet...</span>"
							if(A.Race=="Demon") A.MakyoPower=100000
							else if(A.Race=="Makyojin") A.MakyoPower=1000000
							else if(locate(/obj/Majin) in A) A.MakyoPower=50000
						else if(Year>round(Year,10)+1) A.MakyoPower=0
				logAndAlertAdmins("[key_name(usr)] forced the month to change.")

	SetYear()
		set category="Admin"
		if(!usr.client.holder||usr.client.holder.level<4) return
		Year=input("Enter a year. The current is [Year]") as num
		logAndAlertAdmins("[src.key] set the year to [Year]",4)


	SetBirthYear()
		set category="Admin"
		if(!usr.client.holder||usr.client.holder.level<4) return
		var/BY=input("Enter a year. The current is [Year]") as num
		switch(alert("This will change the BirthYear of every player online! Continue?",,"Yes","No"))
			if("Yes")
				for(var/mob/player/P in Players)
					if(client)
						P.BirthYear=BY
				logAndAlertAdmins("[src.key] set everyone's Birthyear to [BY]",4)
			if("No")
				return
			else
				return

	OpenServer()
		set category="Admin"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		global.ItemsLoaded=1
		global.MapsLoaded=1
		logAndAlertAdmins("[src.key] has manually OPENED the server. (DEBUG: [global.MapsLoaded]:[global.ItemsLoaded])",4)

	CloseServer()
		set category="Admin"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		global.ItemsLoaded=0
		global.MapsLoaded=0
		logAndAlertAdmins("[src.key] has manually CLOSED the server. (DEBUG: [global.MapsLoaded]:[global.ItemsLoaded])",4)

	MassRevive()
		set category="Admin"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		switch(input("Are you sure you want to mass revive everyone on the server?") in list("No","Yes"))
			if("Yes")
				MassRevive_loop()
				logAndAlertAdmins("[src.key] revived everyone.",4)

	MassReviveLoop()
		set category="Admin"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		global.reviveloop=input("How often? in minutes") as num
		if(global.reviveloop)
			logAndAlertAdmins("[src.key] started the reviveloop. It will trigger every [global.reviveloop] minutes.",4)
			spawn(1) MassRevive_loop(TRUE)
		else if(!global.reviveloop) return
		else
			logAndAlertAdmins("[src.key] stopped the reviveloop.",4)
			global.reviveloop=0

proc/MassRevive_loop(var/i)
	if(!i)
		world << "<span class=\"announce\">All players revived.</span>"
		for(var/mob/player/P in Players)
			if(P.Dead) P.Revive()
			sleep(1)

	if(global.reviveloop)
		sleep(global.reviveloop*800)
		if(global.reviveloop)
			.()
