datum/mind
	var/key
	var/mob/current

	var/memory

	proc/transfer_to(mob/new_character)
		if(current)
			current.mind = null
		if(!new_character)
			return
		src << "This function isn't finished yet and is disabled."
		return
		// Transfer mind crashes the server or just boots the player. Needs fixing so its disabled.
		/*
		new_character.mind = src
		current = new_character
		new_character.saveToLog("<span class=\"subtle_message\">Your mind no longer is yours to command!</span>\n")
		new_character << "<span class=\"subtle_message\">Your mind no longer is yours to command!</span>"
		//Make a new mob for the guy who's mind we just stole
		var/mob/player/A = new
		A.key = new_character.key
		new_character.client.mob = A
		//new_character.key = key
		//new_character.lastKnownKey = key
*/

	proc/wipe_memory()
		memory = null
		current.saveToLog("<span class=\"subtle_message\">Your mind suddenly feels blank...</span>\n")
		current << "<span class=\"subtle_message\">Your mind suddenly feels blank...</span>"

	proc/scramble_memory(var/amount = 50)
		var/scrambledMemory = html_decode(memory)
		scrambledMemory = stars(scrambledMemory,amount)
		scrambledMemory = html_encode(scrambledMemory)
		memory = scrambledMemory
		current.saveToLog("<span class=\"subtle_message\">You suddenly have trouble recalling details in your memory...</span>\n")
		current << "<span class=\"subtle_message\">You suddenly have trouble recalling details in your memory...</span>"

	proc/store_memory(new_text)
		var/newMemory = "[new_text]<BR>"
		newMemory += memory
		memory = newMemory	//This way we add new memories to the top
		if(length(memory) > MAX_MESSAGE_LEN*100)
			dd_limittext(memory,MAX_MESSAGE_LEN*100)	//Large limit but still a limit

	proc/show_memory(mob/recipient)
		var/output = "<B>[current.real_name]'s Memory</B><HR>"
		output += "<A HREF='?src=\ref[src];refreshmemory=\ref[src.current]'>Refresh Memory</A>"
		if(usr.client.holder && usr.client.holder.level >= 2 && src.current)
			output += " - <A HREF='?src=\ref[src];scramblememory=\ref[src.current]'>Scramble Memory</A> - "
			output += "<A HREF='?src=\ref[src];wipememory=\ref[src.current]'>Wipe Memory</A> - "
			output += "<A HREF='?src=\ref[src];addmemory=\ref[src.current]'>Add Memory</A>"
			if(usr.client.holder.level >= 4)	//Lets admin do mobchanges :v
				output += " - <A HREF='?src=\ref[src];transfermemory=\ref[src.current]'>Transfer Mind</A>"
		output += "<HR>"
		output += memory
		recipient << browse(output,"window=memory")

	proc/read_mind(mob/read)
		if(read.Kills)
			var/knows = 0
			if(current.Race == "Demon")
				knows = 1
			if(current.Race == "Kaio")
				knows = 1
			if(knows)
				current << "You sense that [read] has killed [read.Kills] people."
		var/mindReadingSkill = round(current.PowMod*current.Pow*current.Sense_Mod)
		var/theirMindReadingSkill = round(read.ResMod*read.Res*read.Sense_Mod)
		if(current.Race || read.Race in list("Android", "Bio-Android", "Majin") || mindReadingSkill <= 1000 || (mindReadingSkill-theirMindReadingSkill<=0))	//Can't read minds
			current << "<span class=\"subtle_message\">You fail to catch <b>any</b> glimpse of [read]'s mind!</span>"
		else
			if(mindReadingSkill > 15000+theirMindReadingSkill)	//Max mastery
				current << "<span class=\"subtle_message\">You [pick("delve","probe")] into [read]'s mind without their knowledge!</span>"
				current.saveToLog("<span class=\"subtle_message\">You [pick("delve","probe")] into [read]'s mind without their knowledge!</span>\n")
				read.saveToLog("<span class=\"subtle_message\">[key_name(current)] read my mind without my knowledge!</span>\n")
				read.mind.show_memory(current)
			else if(mindReadingSkill > 15000)
				current << "<span class=\"subtle_message\">You [pick("delve","probe")] into [read]'s mind, but you're certain they're aware of your presence!</span>"
				current.saveToLog("<span class=\"subtle_message\">You [pick("delve","probe")] into [read]'s mind, but you're certain they're aware of your presence!</span>\n")
				read << "<span class=\"subtle_message\">You feel [current] [pick("delving","probing")] into your mind!</span>"
				read.saveToLog("<span class=\"subtle_message\">You feel [current] [pick("delving","probing")] into your mind!</span>\n")
				read.mind.show_memory(current)
			else if(mindReadingSkill > 10000)
				current << "<span class=\"subtle_message\">You give it your best shot, but you're unable to catch any glimpse of [read]'s mind.</span>"
				read << "<span class=\"subtle_message\">[current] tried to read your mind and failed!"
			else if(mindReadingSkill > 5000)
				current << "<span class=\"subtle_message\">You strain yourself trying, but you're unable to catch any glimpse of [read]'s mind.</span>"
				read << "<span class=\"subtle_message\">[current] tried to read your mind and failed!"
			else if(mindReadingSkill > 1000)
				current << "<span class=\"subtle_message\">Try as you might, you're unable to catch any glimpse of [read]'s mind.</span>"
				read << "<span class=\"subtle_message\">[current] tried to read your mind and failed!"

	Topic(href, href_list)
		..()
		if(href_list["refreshmemory"])
			src.show_memory(usr)
		//Scramble
		if(href_list["scramblememory"])
			if(!usr.client.holder)
				alert("You cannot perform this action. You must be of a higher administrative rank!")
				return
			src.scramble_memory()
			src.show_memory(usr)
			alertAdmins("[key_name(usr)] scrambled [key_name(src.current)]'s <a HREF='?src=\ref[src];refreshmemory=\ref[src.current]'>memory</A>")
			log_admin("[key_name(usr)] scrambled [key_name(src.current)]'s memory")
		if(href_list["wipememory"])
			if(!usr.client.holder)
				alert("You cannot perform this action. You must be of a higher administrative rank!")
				return
			src.wipe_memory()
			src.show_memory(usr)
			alertAdmins("[key_name(usr)] wiped [key_name(src.current)]'s <a HREF='?src=\ref[src];refreshmemory=\ref[src.current]'>memory</A>")
			log_admin("[key_name(usr)] wiped [key_name(src.current)]'s memory")
		if(href_list["addmemory"])
			if(!usr.client.holder)
				alert("You cannot perform this action. You must be of a higher administrative rank!")
				return
			var/addedMemory = input("Add what to their memory?") as message
			addedMemory = copytext(addedMemory, 1, MAX_MESSAGE_LEN)
			if(!addedMemory)
				return
			else
				src.store_memory(addedMemory)
				src.show_memory(usr)
				alertAdmins("[key_name(usr)] added to [key_name(src.current)]'s <a HREF='?src=\ref[src];refreshmemory=\ref[src.current]'>memory</A>")
				log_admin("[key_name(usr)] added to [key_name(src.current)]'s memory")
		if(href_list["transfermemory"])
			if(!usr.client.holder)
				alert("You cannot perform this action. You must be of a higher administrative rank!")
				return
			var/mob/transferto = input(usr,"Transfer [key_name(src.current)]'s memory to who?","Transfer mind", src.current) in Players
			if(transferto == src.current)
				return
			else
				alertAdmins("[key_name(usr)] transfered [key_name(src.current)]'s mind to [key_name(transferto)]")
				log_admin("[key_name(usr)] transfered [key_name(src.current)]'s mind to [key_name(transferto)]")
				src.transfer_to(transferto)
				src.show_memory(usr)

//Mob procs
mob/proc/add_memory(memory as message)
	set name = "Add Memory"
	set category = "Other"

	if(!src.mind)
		alert("You've lost your marbles!")
		return
	memory = copytext(memory, 1, MAX_MESSAGE_LEN)	//Player input is limited
	if(!memory)
		return
	else
		src.mind.store_memory(memory)

mob/proc/check_memory()
	set name = "Memory"
	set category = "Other"

	if(!src.mind)
		alert("You've lost your marbles!")
		return
	src.mind.show_memory(src)

mob/proc/read_mind(mob/M in oview())
	set name = "Read Mind"
	set category = "Skills"
	set popup_menu = 0

	if(M == src)
		check_memory()
		return

	if(!src.mind)
		alert("This trick requires you not to have lost your marbles!")
		return
	if(!M.mind)
		alert("Try something with more action upstairs huh?")
		return

	src.mind.read_mind(M)