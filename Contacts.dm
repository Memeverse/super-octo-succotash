
obj/Counterpart
	desc="This is something only Namekians can do. It forms a Piccolo and Kami type relationship \
	with you and one other person. The effect is permanent and irreversible. If one of you die both \
	die. The counterpart with the lowest training experience will match the other counterpart's \
	training experience at all times. You can only have one counterpart."
	verb/Set_Counterpart(mob/A in oview(1))
		set src=usr.contents
		if(!A.client) return
		if(A.Race!=usr.Race)
			usr<<"They arent the same race as you"
			return
		if(A.Counterpart)
			usr<<"They already have a counterpart"
			return
		switch(input(A,"[usr] wants to be your counterpart. Do you want this?") in list("No","Yes"))
			if("Yes")
				view(A)<<"[A] accepts [usr] as their counterpart"
				A.saveToLog("| [A.client.address ? (A.client.address) : "IP not found"] | ([A.x], [A.y], [A.z]) | [key_name(A)] accepts [usr] as their counterpart.\n")
				usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has made [A] their counterpart.\n")
				A.Counterpart="[usr]([usr.key])"
				usr.Counterpart="[A]([A.key])"
				for(var/obj/Counterpart/B in A) del(B)
				del(src)

obj/Contact
	var/familiarity=0
	var/pkey // short for player key
	var/list/listOfContacts
	var/relation="Neutral"
	suffix="0 / Neutral"
	Click()
		if(src in usr.Contacts)
			var/list/Choices=new
			Choices.Add("Very Good","Good","Rival Good","Rival Bad","Neutral","Bad","Very Bad","Remove")
			switch(input("Choose a relationship") in Choices)
				if("Remove")
					del(src)
					return
				if("Neutral")
					relation="Neutral"
					suffix="[round(familiarity)] / [relation]"
				if("Rival Bad")
					if(familiarity>=15)
						relation="Rival/Bad"
						suffix="[round(familiarity)] / [relation]"
					else usr<<"You need 15 or more familiarity"
				if("Rival Good")
					if(familiarity>=15)
						relation="Rival/Good"
						suffix="[round(familiarity)] / [relation]"
					else usr<<"You need 15 or more familiarity"
				if("Good")
					if(familiarity>=50)
						relation="Good"
						suffix="[round(familiarity)] / [relation]"
					else usr<<"You need 50 or more familiarity"
				if("Bad")
					if(familiarity>=10)
						relation="Bad"
						suffix="[round(familiarity)] / [relation]"
					else usr<<"You need 10 or more familiarity"
				if("Very Good")
					if(familiarity>=100)
						relation="Very Good"
						suffix="[round(familiarity)] / [relation]"
					else usr<<"You need 100 or more familiarity"
				if("Very Bad")
					if(familiarity>=20)
						relation="Very Bad"
						suffix="[round(familiarity)] / [relation]"
					else usr<<"You need 20 or more familiarity"
		else
			del(src)
			return

/*/mob/verb/Set_Contact(var/mob/M in oview())
	set category="Other"
	var/contacts=0
	for(var/obj/Contact/A in usr) contacts++ // count the number of contacts
	if(contacts<20) if(M) //M.client)
		var/disapproved
		for(var/obj/Contact/A in usr.Contacts) if(A.name=="[M.name] - [M.Signature]"&&A.pkey=="[M.ckey]") disapproved=1 // if they already have this person as a contact, skip
		if(!disapproved)
			var/obj/Contact/C = new // add Contact to player inventory
			C.name = "[M.name] - [M.Signature]"
			C.pkey = "[M.ckey]"
			C.familiarity++
			if(M.icon)
				C.icon=M.icon
			C.overlays=M.overlays
			C.suffix="[C.familiarity] / [C.relation]"
			usr.Contacts += C
		/*	if(!A)
				contents+=A
			else
				contents+=A.listOfContacts*/
			//src.contents+=A
			usr.savingContacts=1
	//		saveContacts()

	else usr<<"You can only have 20 contacts."
*/
mob/proc/Contacts()
	while(src)
		for(var/mob/M in oview(6,src))
			if(M.client)
				var/disapproved
				for(var/obj/Contact/A in src.Contacts) if(A.Signature == M.Signature) disapproved=1 // if they already have this person as a contact, skip
				if(!disapproved)
					var/obj/Contact/C = new
					C.name = "[M.name] - [M.Signature]"
					C.pkey = "[M.ckey]"
					C.Signature = M.Signature
					C.familiarity++
					if(M.icon)
						C.icon=M.icon
					C.overlays+=M.overlays
					C.suffix="[C.familiarity] / [C.relation]"
					src.Contacts += C
				if(!M.afk) if(!src.afk)
					for(var/obj/Contact/A in src.Contacts) if(A.Signature == M.Signature)
						A.familiarity+= 0.01
						A.suffix="[A.familiarity] / [A.relation]"
						if(First_SSJ == 0) if(src.Hasssj < 1) if(src.RP_Total >= 1000) if(A.relation in list("Rival/Bad","Rival/Good")) if(M.BP > src.BP)
							alertAdmins("[key_name_admin(src)] has managed to unlock their Super Saiyan transformation via a need to better their rival, and after having reached 1000 total role play points.")
							src << "You have managed to unlock your Super Saiyan transformation via a need to better your rival, congratulations!"
							view(6,src) << "<font color = green>Something snaps in [src]. A deep desire to become better and stronger than [M] finally overcomes them..."
							src.Hasssj = 1
							First_SSJ = 1
							src.SSj()
						break
		//var/C = list()
		//for(var/obj/Contact/A in src.Contacts)
			//C += A
		sleep(100)



	//	if(!SSjAble&&M.ssj&&M.SSj_Leech)


/*
 * Old code for saving contacts
 * should be automagically done via character saves.
 *
*/

/*mob/proc/saveContacts(filename, savingContacts)
	//var/savefile/C=new(filename)
	if(src.savingContacts==1)
	//	for(var/mob/player/B)
		for(var/obj/Contact/A in src.contents)
			var/savefile/S=new("Data/Players/[src.lastKnownKey]/Characters/[src.real_name] Contacts.bdb")
			S["playerContact"]<<src

		src.savingContacts=0
		world<<"Saved."
mob/proc/loadContacts(var/list/contactList)
	//for(var/mob/player/B)
	for(var/obj/Contact/A in src.contents)
		var/savefile/C = new("Data/Players/[src.lastKnownKey]/Characters/[src.real_name] Contacts.bdb")
		C["playerContact"]>> contactList
		world<<"List Variable Loaded and Defined"
	//	del(A)
		contents+=contactList
		world<<"Deleted A and replaced contacts."


		/*	world<<"Contact List defined."
			C["playerContact"]>> contactList
			world<<"Contact List loaded to variable."
			var/i
			for(i=1,i<=contactList.len,i++)
				contactList.Insert(i,A)*/


		//	contactList.Insert(Index=0,"playerContact")
			//	world<<"Contact List Loaded to [B]"

			//list.Cut(Start=1,End=0)
			//L.Insert(Index=0,contactlist)

		//	world<<"Loaded [contactList]"
		//	world<<"["playerContact]"
mob/verb/DebugSave()
	var/savefile/C= new("Data/Players/[src.lastKnownKey]/Characters/[src.real_name] Contacts.bdb")
	var/list/debuggingsave
	C["playerContact"]>>debuggingsave
	world<<debuggingsave*/

/*client/proc/Load(filename)
	var/savefile/F = new(filename)
	F["Player"] >> src.mob*/

/*mob/proc/LoadSaveChar(filename, saving)
	var/savefile/F = new(filename)
	if(length(F)<1024 && !saving)	//less then a kb isn't enough for a save
		spawn Load_Character()
		del(src)
		return
	if(saving)
		//Write(F)
		F["Player"] << src
	else
		//Read(F)
		//Update_Player()
		client.Load(filename)


			var/savefile/S=new("Data/IntGain.bdb")
	S["intgain"]<<Admin_Int_Setting*/

/*mob/proc/Save()
	if(lastKnownKey && real_name)
		if(z && !Regenerating)
			savedX = x
			savedY = y
			savedZ = z
		if(S && S.z)
			savedX = S.x
			savedY = S.y
			savedZ = S.z
		//Actual saving
		LoadSaveChar("Data/Players/[lastKnownKey]/Characters/[real_name].sav",1)
	else
		src << "Failed to save your mob as you have no lastKnownKey or real_name!"
		log_game("Saving [key_name(src)] failed as lastKnownKey or real_name was null!")*/

	//Random test code
