/proc/stars(n, pr)	//Use if someone can't understand what's being said

	if (pr == null)
		pr = 25
	if (pr <= 0)
		return null
	else
		if (pr >= 100)
			return n
	var/te = n
	var/t = ""
	n = length(n)
	var/p = null
	p = 1
	while(p <= n)
		if ((copytext(te, p, p + 1) == " " || prob(pr)))
			t = text("[][]", t, copytext(te, p, p + 1))
		else
			t = text("[]*", t)
		p++
	return t

/proc/stutter(n)	//Returns a staggered version of input
	var/te = html_decode(n)
	var/t = ""
	n = length(n)
	var/p = null
	p = 1
	while(p <= n)
		var/n_letter = copytext(te, p, p + 1)
		if (prob(80))
			if (prob(10))
				n_letter = text("[n_letter][n_letter][n_letter][n_letter]")
			else
				if (prob(20))
					n_letter = text("[n_letter][n_letter][n_letter]")
				else
					if (prob(5))
						n_letter = null
					else
						n_letter = text("[n_letter][n_letter]")
		t = text("[t][n_letter]")
		p++
	return copytext(sanitize(t),1,MAX_MESSAGE_LEN)
/*mob/verb/Get_Logs()
	set category="Other"
	if(fexists("Data/Players/[usr.lastKnownKey]/Logs/full_[usr.real_name].log"))
		usr << "Found file."
		var/log = file2text("Data/Players/[usr.lastKnownKey]/Logs/full_[usr.real_name].log")
		var/T = "[log]"
		var/TextLength = lentext(log)
		var/TextNew = null
		var/Text = null
		while(TextLength)
			Text ="[copytext(T,(lentext(T)-TextLength)+1,(lentext(T)-TextLength)+2)]"
			var/N = 9
			while(N != -1)
				if(findtext("[N]",Text))
					TextNew+="*"
				N -= 1
			TextLength -= 1
		//T = TextNew
		usr << "[T]"
*/
mob/verb/Countdown()
	set category="Other"
	if(usr.RP_Length <= 300) if(usr.RP_Length != 0) if(RP_Actual != null)
		usr << "<font color = red> Warning, potentially illegal emote detected. The minimal length of an emote resulting in a negative action is 300 letters. \
		Admins have been alerted so they may investigate further. If this countdown is not related to a negative action, please do not worry."
		alertAdmins("[key_name_admin(src)](<A HREF='?src=\ref[src.client.holder];adminplayeropts=\ref[src]'>X</A>) may have created an illegal emote with a possible negative action at [src.x],[src.y],[src.z]. - [src.RP_Actual]")
		src.saveToLog("<span class=\"Countdown\">[src]([key]):may have created an illegal emote with a possible negative action at [src.x],[src.y],[src.z].</span>\n")
	usr.RP_Length = 0
	usr.RP_Actual = null
	switch(input(usr,"Do you want this CD to display when it gets close to 0?") in list("No","Yes"))
		if("No")
			for(var/mob/M in range(20,usr))
				M<<"<font color = red>[src] is waiting 30 seconds."
				M.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(usr)] is waiting 30 seconds.\n")
			spawn(300)
				if(usr)
					for(var/mob/M in range(20,usr))
						M<<"<font color = red>[usr] has waited 30 seconds."
						M.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(usr)] has waited 30 seconds.\n")
		if("Yes")
			for(var/mob/M in range(20,usr))
				M<<"<font color = red>[src] is waiting 30 seconds."
				M.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(usr)] is waiting 30 seconds.\n")
			spawn(190)
				if(usr)
					for(var/mob/M in range(20,usr))
						M<<"<font color = red>10"
						M.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(usr)] has waited 20 seconds.\n")
					spawn(10)
						if(usr)
							for(var/mob/M in range(20,usr))
								M<<"<font color = red>9"
								M.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(usr)] has waited 21 seconds.\n")
							spawn(10)
								if(usr)
									for(var/mob/M in range(20,usr))
										M<<"<font color = red>8"
										M.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(usr)] has waited 22 seconds.\n")
									spawn(10)
										if(usr)
											for(var/mob/M in range(20,usr))
												M<<"<font color = red>7"
												M.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(usr)] has waited 23 seconds.\n")
											spawn(10)
												if(usr)
													for(var/mob/M in range(20,usr))
														M<<"<font color = red>6"
														M.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(usr)] has waited 24 seconds.\n")
													spawn(10)
														if(usr)
															for(var/mob/M in range(20,usr))
																M<<"<font color = red>5"
																M.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(usr)] has waited 25 seconds.\n")
															spawn(10)
																if(usr)
																	for(var/mob/M in range(20,usr))
																		M<<"<font color = red>4"
																		M.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(usr)] has waited 26 seconds.\n")
																	spawn(10)
																		if(usr)
																			for(var/mob/M in range(20,usr))
																				M<<"<font color = red>3"
																				M.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(usr)] has waited 27 seconds.\n")
																			spawn(10)
																				if(usr)
																					for(var/mob/M in range(20,usr))
																						M<<"<font color = red>2"
																						M.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(usr)] has waited 28 seconds.\n")
																					spawn(10)
																						if(usr)
																							for(var/mob/M in range(20,usr))
																								M<<"<font color = red>1"
																								M.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(usr)] has waited 29 seconds.\n")
																							spawn(10)
																								if(usr)
																									for(var/mob/M in range(20,usr))
																										M<<"<font color = red>GO!"
																										M.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(usr)] has waited 30 seconds.\n")
var/mob/tmp/say_spark

mob
	var
		Toggled_Contacts = 0
		Toggled_Injuries = 0
		Toggled_Inventory = 0
		Toggled_Sense = 0
mob/verb/Toggle_Contacts()
	set category="Other"
	if(usr.Toggled_Contacts)
		usr.Toggled_Contacts = 0
		usr << "You have made your contacts tab show."
		return
	else
		usr.Toggled_Contacts = 1
		usr << "You have made your contacts tab hidden."
		return
mob/verb/Toggle_Injuries()
	set category="Other"
	if(usr.Toggled_Injuries)
		usr.Toggled_Injuries = 0
		usr << "You have made your injuries tab show."
		return
	else
		usr.Toggled_Injuries = 1
		usr << "You have made your injuries tab hidden."
		return
mob/verb/Toggle_Inventory()
	set category="Other"
	if(usr.Toggled_Inventory)
		usr.Toggled_Inventory = 0
		usr << "You have made your inventory tab show."
		return
	else
		usr.Toggled_Inventory = 1
		usr << "You have made your inventory tab hidden."
		return
mob/verb/Toggle_Sense()
	set category="Other"
	if(usr.Toggled_Sense)
		usr.Toggled_Sense = 0
		usr << "You have made your sense tab show."
		return
	else
		usr.Toggled_Sense = 1
		usr << "You have made your sense tab hidden."
		return
mob/verb/Toggle_Pull_Punches()
	set category="Other"
	if(usr.Spar)
		usr.Spar = 0
		usr << "You will now no longer pull your punches. This means your hits have a chance to injure the body parts of others."
		view(6,usr) << "<font color = green>[usr] seems to be no longer pulling their punches."
		usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] begins to pull their punches.\n")
		return
	else
		usr.Spar = 1
		usr << "You will now pull your punches."
		view(6,usr) << "<font color = green>[usr] begins to pull their punches."
		usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] stops pulling their punches.\n")
		return
mob/verb/Toggle_Security()
	set category="Other"
	if(usr.sec_toggle)
		usr.sec_toggle = 0
		usr << "Toggled Security tab off."
		return
	else
		usr.sec_toggle = 1
		usr << "Toggled Security tab on."
		return


mob/var/sec_toggle = 1
mob/verb/Role_Play_Points()
	set category="Other"
	usr << "You can only have 3 skills maximum per character learned from this skill tree. You have currently used [usr.Skills_Current]/3 slots. You may also choose to invest points into other areas, such as Intelligence levels, ect. Trying to abuse this system will get you banned."
	var/deny_points = 0
	var/deny_max = 0
	var/list/Choices=new
/*
	if(usr.Trans)
		Choices.Add("Transformations")
	else
		Choices.Add("Ascensions")
*/
	Choices.Add("Battle Power","Energy","Intelligence Levels","Magic Levels","Resources","Mana","Dragon Nova(200)","Focus(150)","Expand(150)","Power Control(150)","Split Form(250)","Sokidan(150)","Ray(250)","Piercer(250)","Shield(150)","Zanzoken(200)","Telepathy(150)","Power Ball(200)","Explosion(150)","Heal(150)","Limit Breaker(250)","Materialization(250)","Cancel")
	for(var/obj/SplitForm/x in usr)
		Choices -= "Split Form(250)"
	for(var/obj/Telepathy/x in usr)
		Choices -= "Telepathy(150)"
	for(var/obj/Attacks/Dragon_Nova/x in usr)
		Choices -= "Dragon Nova(200)"
	for(var/obj/Shield/x in usr)
		Choices -= "Shield(150)"
	for(var/obj/Focus/x in usr)
		Choices -= "Focus(150)"
	for(var/obj/Expand/x in usr)
		Choices -= "Expand(150)"
	for(var/obj/Power_Control/x in usr)
		Choices -= "Power Control(150)"
	for(var/obj/Attacks/Explosion/x in usr)
		Choices -= "Explosion(150)"
	for(var/obj/Attacks/Sokidan/x in usr)
		Choices -= "Sokidan(150)"
	for(var/obj/Attacks/Ray/x in usr)
		Choices -= "Ray(250)"
	for(var/obj/Attacks/Piercer/x in usr)
		Choices -= "Piercer(250)"
	for(var/obj/Zanzoken/x in usr)
		Choices -= "Zanzoken(200)"
	for(var/obj/Heal/x in usr)
		Choices -= "Heal(200)"
	for(var/obj/Power_Ball/x in usr)
		Choices -= "Power_Ball(200)"
	for(var/obj/Limit_Breaker/x in usr)
		Choices -= "Limit Breaker(250)"
	for(var/obj/Materialization/x in usr)
		Choices -= "Materialization(250)"
	switch(input("Skill slots used [usr.Skills_Current]/3. The point cost of each option is designated within the parenthesis. You currently have [usr.RP_Points] to spend.") in Choices)
		if("Cancel")
			return
		if("Ascensions")
			var/Price = 10000
			if(usr.Race == "Human")
				Price = 750
			if(usr.Race == "Namekian")
				Price = 750
			if(usr.Race == "Demon" || usr.Race == "Kaio")
				Price = 1250
			switch(input("Your ascensions don't cost points you have already spent, but are based off how many you have earned total on this character. Yours will cost [Price] role play points earned total. Do you wish to proceed?") in list("No","Yes"))
				if("Yes")
					if(usr.RP_Total >= Price)
						if(usr.Race == "Namekian")
							if(usr.Ascended == 0)
								usr.Ascended = 1
								usr.BPMod *= 2
								alertAdmins("[key_name_admin(usr)] has managed to unlock the first stage of their Ascension after having reached [Price] total role play points.")
								usr << "You have managed to unlock the first stage of your ascension, congratulations!"
		if("Transformations")
			var/Price = 10000
			if(usr.Race == "Alien")
				Price = 750
			var/txt = ""
			if(usr.Race == "Saiyan")
				if(usr.Hasssj < 3)
					Price = 1500
				if(usr.Hasssj < 2)
					Price = 1250
				if(usr.Hasssj < 1)
					Price = 1000
					if(First_SSJ == 0)
						txt = " NOTE that the first Super Saiyan has not yet been unlocked, which means you will need a proper situation in order to proceed; such as the harm or death of someone close."
			switch(input("Your transformations don't cost points you have already spent, but are based off how many you have earned total on this character. Yours will cost [Price] role play points earned total. Do you wish to proceed?[txt]") in list("No","Yes"))
				if("Yes")
					if(usr.RP_Total >= Price)
						if(usr.Race == "Alien")
							if(usr.Hybrid_Build == 1)
								usr.Hybrid_Build = 2
							if(usr.Melee_Build == 1)
								usr.Melee_Build = 2
							if(usr.Ki_Build == 1)
								usr.Ki_Build = 2
							alertAdmins("[key_name_admin(usr)] has managed to unlock their Alien transformation after having reached [Price] total role play points.")
							usr << "You have managed to unlock your Alien transformation, congratulations!"
						if(usr.Hasssj == 1) if(usr.ssjdrain < 300)
							usr << "You are unable to unlock your Super Saiyan Two transformation until you master your first. Your current mastery is [usr.ssjdrain]/300"
							return
						if(usr.Hasssj == 2) if(usr.ssj2drain < 300)
							usr << "You are unable to unlock your Super Saiyan Three transformation until you master your second. Your current mastery is [usr.ssj2drain]/300"
							return
						if(usr.Race == "Saiyan") if(usr.Hasssj < 1)
							if(First_SSJ == 3)
								alertAdmins("[key_name_admin(usr)] has managed to unlock their Super Saiyan transformation after having reached [Price] total role play points.")
								usr << "You have managed to unlock your Super Saiyan transformation, congratulations!"
								usr.Hasssj = 1
								usr.SSj()
								return
							else if(usr.ssjanger)
								world << 'first ssj.ogg'
								alertAdmins("[key_name_admin(usr)] has managed to unlock their Super Saiyan transformation via a need, after having reached [Price] total role play points and having someone close to them die or badly harmed.")
								usr << "You have managed to unlock your Super Saiyan transformation via a need, congratulations!"
								usr.Hasssj = 1
								First_SSJ = 1
								usr.SSj()
								return
							else
								usr << "The first Super Saiyan on the server has not yet appeared. This means you need special situations to unlock this transformation, such as the death or harm of those close to you."
								return
						if(usr.Race == "Saiyan") if(usr.Hasssj < 2)
							if(usr.ssjdrain >= 300)
								alertAdmins("[key_name_admin(usr)] has managed to unlock their Super Saiyan Two transformation after having reached [Price] total role play points.")
								usr << "You have managed to unlock your Super Saiyan Two transformation, congratulations!"
								usr.Hasssj = 2
								usr.SSj2()
								return
							else
								usr << "You need to master your Super Saiyan form before being able to unlock the second."
								return
						if(usr.Race == "Saiyan") if(usr.Hasssj < 3)
							if(usr.ssj2drain >= 300)
								alertAdmins("[key_name_admin(usr)] has managed to unlock their Super Saiyan Three transformation after having reached [Price] total role play points.")
								usr << "You have managed to unlock your Super Saiyan Three transformation, congratulations!"
								usr.Hasssj = 3
								usr.SSj3()
								return
							else
								usr << "You need to master your Super Saiyan Two form before being able to unlock the third."
								return
		if("Mana")
			var/P = input("You have [usr.RP_Points] Role Play points to spend.") as num
			if(P > usr.RP_Points)
				P = usr.RP_Points
			if(P <= 0)
				P = 0
				return
			if(P == 0)
				return
			if(P < 1)
				usr << "Only whole numbers."
				return
			usr.RP_Points -= P
			var/N = P * 400000
			alertAdmins("[key_name_admin(usr)] has used [P] RP points and gained [Commas(N)] mana.")
			usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has used [P] RP points and gained [Commas(N)] mana. \n")
			usr << "You gain [Commas(N)] mana for [P] RP Points."
			for(var/obj/Mana/C in usr)
				C.Value += N
				break
		if("Resources")
			var/P = input("You have [usr.RP_Points] Role Play points to spend.") as num
			if(P > usr.RP_Points)
				P = usr.RP_Points
			if(P <= 0)
				P = 0
				return
			if(P == 0)
				return
			if(P < 1)
				usr << "Only whole numbers."
				return
			usr.RP_Points -= P
			var/N = P * 400000
			alertAdmins("[key_name_admin(usr)] has used [P] RP points and gained [Commas(N)] resources.")
			usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has used [P] RP points and gained [Commas(N)] resources. \n")
			usr << "You gain [Commas(N)] resources for [P] RP Points."
			for(var/obj/Resources/C in usr)
				C.Value += N
				break
		if("Magic Levels")
			var/P = input("You have [usr.RP_Points] Role Play points to spend.") as num
			if(P > usr.RP_Points)
				P = usr.RP_Points
			if(P <= 0)
				P = 0
				return
			if(P == 0)
				return
			if(P < 1)
				usr << "Only whole numbers."
				return
			var/Used = P
			usr.RP_Points -= P
			P = P * usr.Magic_Potential * 2000
			//P = P / 7.5 / 4 * usr.Magic_Potential
			alertAdmins("[key_name_admin(usr)] has used [Used] RP points and gained [P] experience toward their magic levels.")
			usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has used [Used] RP points and gained [P] experience toward their magic levels. \n")
			usr.Magic_XP += P
			usr << "All done."
		if("Intelligence Levels")
			var/P = input("You have [usr.RP_Points] Role Play points to spend.") as num
			if(P > usr.RP_Points)
				P = usr.RP_Points
			if(P <= 0)
				P = 0
				return
			if(P == 0)
				return
			if(P < 1)
				usr << "Only whole numbers."
				return
			var/Used = P
			usr.RP_Points -= P
			P = P * usr.Add * 2000
			alertAdmins("[key_name_admin(usr)] has used [Used] RP points and gained [P] experience toward their intelligence levels.")
			usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has used [Used] RP points and gained [P] experience toward their intelligence levels. \n")
			usr.Int_XP += P
			usr << "All done."
		if("Battle Power")
			var/P = input("You have [usr.RP_Points] Role Play points to spend.") as num
			if(P > usr.RP_Points)
				P = usr.RP_Points
			if(P < 0)
				P = 0
				return
			if(P == 0)
				return
			var/Y = 1 + Year
			var/Points = P * 5
			var/BP = Points * Y * usr.BPMod
			usr.Base += BP
			usr.RP_Points -= P
			usr << "[BP] Battle Power was added to your base."
			alertAdmins("[key_name_admin(usr)] has used [P] RP points and gained [BP] base Battle Power.")
			usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has used [P] RP points and gained [BP] base Battle Power. \n")
			return
		if("Energy")
			var/P = input("You have [usr.RP_Points] Role Play points to spend.") as num
			if(P > usr.RP_Points)
				P = usr.RP_Points
			if(P < 0)
				P = 0
				return
			if(P == 0)
				return
			var/Points = P * 50
			var/E = Points * usr.KiMod
			usr.MaxKi += E
			usr.RP_Points -= P
			usr << "You gain [E] Energy."
			alertAdmins("[key_name_admin(usr)] has used [P] RP points and gained [E] Energy.")
			usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has used [P] RP points and gained [E] Energy. \n")
			return
		if("Telepathy(150)")
			if(usr.Skills_Current < 3)
				if(usr.RP_Points >= 150)
					usr << "<font color = teal>You have been rewarded the Telepathy skill for 150 RP points, congratulations!<p>"
					usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] rewards themselves with the Telepathy skill for 150 RP points.\n")
					alertAdmins("[key_name_admin(usr)] has used 150 RP points and chosen the Telepathy skill to learn.")
					var/obj/Telepathy/x = new
					x.Teach = 0
					x.desc += "You learned this at year [Year] from using your RP Points."
					usr.contents += x
					usr.Skills_Current += 1
					usr.RP_Points -= 150
				else
					deny_points = 1

			else
				deny_max = 1
		if("Dragon Nova(200)")
			if(usr.Skills_Current < 3)
				if(usr.RP_Points >= 200)
					usr << "<font color = teal>You have been rewarded the Dragon Nova skill for 200 RP points, congratulations!<p>"
					usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] rewards themselves with the Dragon Nova skill for 200 RP points.\n")
					alertAdmins("[key_name_admin(usr)] has used 200 RP points and chosen the Dragon Nova skill to learn.")
					var/obj/Attacks/Dragon_Nova/x = new
					x.Teach = 0
					x.desc += "You learned this at year [Year] from using your RP Points."
					usr.contents += x
					usr.Skills_Current += 1
					usr.RP_Points -= 200
				else
					deny_points = 1

			else
				deny_max = 1
		if("Focus(150)")
			if(usr.Skills_Current < 3)
				if(usr.RP_Points >= 150)
					usr << "<font color = teal>You have been rewarded the Focus skill for 150 RP points, congratulations!<p>"
					usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] rewards themselves with the Focus skill for 150 RP points.\n")
					alertAdmins("[key_name_admin(usr)] has used 150 RP points and chosen the Focus skill to learn.")
					var/obj/Focus/x = new
					x.Teach = 0
					x.desc += "You learned this at year [Year] from using your RP Points."
					usr.contents += x
					usr.Skills_Current += 1
					usr.RP_Points -= 150
				else
					deny_points = 1

			else
				deny_max = 1
		if("Explosion(150)")
			if(usr.Skills_Current < 3)
				if(usr.RP_Points >= 150)
					usr << "<font color = teal>You have been rewarded the Explosion skill for 150 RP points, congratulations!<p>"
					usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] rewards themselves with the Explosion skill for 150 RP points.\n")
					alertAdmins("[key_name_admin(usr)] has used 150 RP points and chosen the Explosion skill to learn.")
					var/obj/Attacks/Explosion/x = new
					x.Teach = 0
					x.desc += "You learned this at year [Year] from using your RP Points."
					usr.contents += x
					usr.Skills_Current += 1
					usr.RP_Points -= 150
				else
					deny_points = 1

			else
				deny_max = 1
		if("Expand(150)")
			if(usr.Skills_Current < 3)
				if(usr.RP_Points >= 150)
					usr << "<font color = teal>You have been rewarded the Expand skill for 150 RP points, congratulations!<p>"
					usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] rewards themselves with the Expand skill for 150 RP points.\n")
					alertAdmins("[key_name_admin(usr)] has used 150 RP points and chosen the Expand skill to learn.")
					var/obj/Expand/x = new
					x.Teach = 0
					x.desc += "You learned this at year [Year] from using your RP Points."
					usr.contents += x
					usr.Skills_Current += 1
					usr.RP_Points -= 150
				else
					deny_points = 1

			else
				deny_max = 1
		if("Power Control(150)")
			if(usr.Skills_Current < 3)
				if(usr.RP_Points >= 150)
					usr << "<font color = teal>You have been rewarded the Power Control skill for 150 RP points, congratulations!<p>"
					usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] rewards themselves with the Power Control skill for 150 RP points.\n")
					alertAdmins("[key_name_admin(usr)] has used 150 RP points and chosen the Power Control skill to learn.")
					var/obj/Power_Control/x = new
					x.Teach = 0
					x.desc += "You learned this at year [Year] from using your RP Points."
					usr.contents += x
					usr.Skills_Current += 1
					usr.RP_Points -= 150
				else
					deny_points = 1

			else
				deny_max = 1
		if("Split Form(250)")
			if(usr.Skills_Current < 3)
				if(usr.RP_Points >= 250)
					usr << "<font color = teal>You have been rewarded the Split Form skill for 250 RP points, congratulations!<p>"
					usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] rewards themselves with the Split Form skill for 250 RP points.\n")
					alertAdmins("[key_name_admin(usr)] has used 250 RP points and chosen the Split Form skill to learn.")
					var/obj/SplitForm/x = new
					x.Teach = 0
					x.desc += "You learned this at year [Year] from using your RP Points."
					usr.contents += x
					usr.Skills_Current += 1
					usr.RP_Points -= 250
				else
					deny_points = 1

			else
				deny_max = 1
		if("Heal(200)")
			if(usr.Skills_Current < 3)
				if(usr.RP_Points >= 200)
					usr << "<font color = teal>You have been rewarded the Heal skill for 200 RP points, congratulations!<p>"
					usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] rewards themselves with the Heal skill for 200 RP points.\n")
					alertAdmins("[key_name_admin(usr)] has used 200 RP points and chosen the Heal skill to learn.")
					var/obj/Heal/x = new
					x.Teach = 0
					x.desc += "You learned this at year [Year] from using your RP Points."
					usr.contents += x
					usr.Skills_Current += 1
					usr.RP_Points -= 200
				else
					deny_points = 1

			else
				deny_max = 1
		if("Sokidan(150)")
			if(usr.Skills_Current < 3)
				if(usr.RP_Points >= 150)
					usr << "<font color = teal>You have been rewarded the Sokidan skill for 150 RP points, congratulations!<p>"
					usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] rewards themselves with the Sokidan skill for 150 RP points.\n")
					alertAdmins("[key_name_admin(usr)] has used 150 RP points and chosen the Sokidan skill to learn.")
					var/obj/Attacks/Sokidan/x = new
					x.Teach = 0
					x.desc += "You learned this at year [Year] from using your RP Points."
					usr.contents += x
					usr.Skills_Current += 1
					usr.RP_Points -= 150
				else
					deny_points = 1

			else
				deny_max = 1
		if("Shield(150)")
			if(usr.Skills_Current < 3)
				if(usr.RP_Points >= 150)
					usr << "<font color = teal>You have been rewarded the Shield skill for 150 RP points, congratulations!<p>"
					usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] rewards themselves with the Shield skill for 150 RP points.\n")
					alertAdmins("[key_name_admin(usr)] has used 150 RP points and chosen the Shield skill to learn.")
					var/obj/Shield/x = new
					x.Teach = 0
					x.desc += "You learned this at year [Year] from using your RP Points."
					usr.contents += x
					usr.Skills_Current += 1
					usr.RP_Points -= 150
				else
					deny_points = 1

			else
				deny_max = 1
		if("Zanzoken(200)")
			if(usr.Skills_Current < 3)
				if(usr.RP_Points >= 200)
					usr << "<font color = teal>You have been rewarded the Zanzoken skill for 200 RP points, congratulations!<p>"
					usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] rewards themselves with the Zanzoken skill for 200 RP points.\n")
					alertAdmins("[key_name_admin(usr)] has used 200 RP points and chosen the Zanzoken skill to learn.")
					var/obj/Zanzoken/x = new
					x.Teach = 0
					x.desc += "You learned this at year [Year] from using your RP Points."
					usr.contents += x
					usr.Skills_Current += 1
					usr.RP_Points -= 200
				else
					deny_points = 1

			else
				deny_max = 1
		if("Ray(250)")
			if(usr.Skills_Current < 3)
				if(usr.RP_Points >= 250)
					usr << "<font color = teal>You have been rewarded the Ray skill for 250 RP points, congratulations!<p>"
					usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] rewards themselves with the Ray skill for 250 RP points.\n")
					alertAdmins("[key_name_admin(usr)] has used 250 RP points and chosen the Ray skill to learn.")
					var/obj/Attacks/Ray/x = new
					x.Teach = 0
					x.desc += "You learned this at year [Year] from using your RP Points."
					usr.contents += x
					usr.Skills_Current += 1
					usr.RP_Points -= 250
				else
					deny_points = 1

			else
				deny_max = 1
		if("Piercer(250)")
			if(usr.Skills_Current < 3)
				if(usr.RP_Points >= 250)
					usr << "<font color = teal>You have been rewarded the Piercer skill for 250 RP points, congratulations!<p>"
					usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] rewards themselves with the Piercer skill for 250 RP points.\n")
					alertAdmins("[key_name_admin(usr)] has used 250 RP points and chosen the Piercer skill to learn.")
					var/obj/Attacks/Piercer/x = new
					x.Teach = 0
					x.desc += "You learned this at year [Year] from using your RP Points."
					usr.contents += x
					usr.Skills_Current += 1
					usr.RP_Points -= 250
				else
					deny_points = 1

			else
				deny_max = 1
		if("Power Ball(200)")
			if(usr.Skills_Current < 3)
				if(usr.RP_Points >= 200)
					usr << "<font color = teal>You have been rewarded the Power Ball skill for 200 RP points, congratulations!<p>"
					usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] rewards themselves with the Power Ball skill for 200 RP points.\n")
					alertAdmins("[key_name_admin(usr)] has used 200 RP points and chosen the Power Ball skill to learn.")
					var/obj/Power_Ball/x = new
					x.Teach = 0
					x.desc += "You learned this at year [Year] from using your RP Points."
					usr.contents += x
					usr.Skills_Current += 1
					usr.RP_Points -= 200
				else
					deny_points = 1

			else
				deny_max = 1
		if("Materialization(250)")
			if(usr.Skills_Current < 3)
				if(usr.RP_Points >= 250)
					usr << "<font color = teal>You have been rewarded the Materialization skill for 250 RP points, congratulations!<p>"
					usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] rewards themselves with the Materialization skill for 250 RP points.\n")
					alertAdmins("[key_name_admin(usr)] has used 250 RP points and chosen the Materialization skill to learn.")
					var/obj/Materialization/x = new
					x.Teach = 0
					x.desc += "You learned this at year [Year] from using your RP Points."
					usr.contents += x
					usr.Skills_Current += 1
					usr.RP_Points -= 250
				else
					deny_points = 1

			else
				deny_max = 1
		if("Limit Breaker(250)")
			if(usr.Skills_Current < 3)
				if(usr.RP_Points >= 250)
					usr << "<font color = teal>You have been rewarded the Limit Breaker skill for 250 RP points, congratulations!<p>"
					usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] rewards themselves with the Limit Breaker skill for 250 RP points.\n")
					alertAdmins("[key_name_admin(usr)] has used 250 RP points and chosen the Limit Breaker skill to learn.")
					usr.contents.Add(new/obj/Limit_Breaker)
					var/obj/Limit_Breaker/x = new
					x.Teach = 0
					x.desc += "You learned this at year [Year] from using your RP Points."
					usr.contents += x
					usr.Skills_Current += 1
					usr.RP_Points -= 250
				else
					deny_points = 1

			else
				deny_max = 1
	if(deny_points)
		usr << "You need more role play points to choose this option. They can be earned from not being afk. Using the Emote verb and using the Say verb."
		return
	if(deny_max)
		usr << "You already have the maximum number of learnable skills allowed per character."
		return
//Make sure players don't spam qunatity over quality.
//Add a filter to prevent spam of some kind.
//Track number of rp's and factor into rewards.
//Make ooc says not count or anything with brackets.
//real talk, set up a timer that looks at the length of the rp v the time it took for it to be posted
//have a limit on how many skills max can be chosen per character, so not every lands up with all the skills.
//Or a cap on how many points can be spent.
mob/proc/Check_RP(var/msg,var/num,var/seconds,var/type)
	if(msg) if(!findtext(msg,"oocly says"))
		var/T = world.timeofday
		T = time2text(T,"hh")
		var/RP = text2num(T)
		var/Player_RP = text2num(src.RP_Last)
		if(!src.RP_Last)
			src.RP_Last = T
		if(Player_RP == RP)
			if(src.RP_Earned < 0)
				src.RP_Points += num*10
				src.RP_Earned += num*10
				src.RP_Total += num*10
		src.RP_Last = T
		var/TextLength = length(msg)
		src.RP_Length = TextLength
		var/divide = 40
		var/MinTime = TextLength / divide
		if(seconds) if(MinTime >= seconds)
			src << "Possible pre-typed RP detected. The admins have been alerted."
			for (var/mob/M in Players)
				if (M.client && M.client.holder && M.client.holder.listen_Chat)
					M << "<font color=[TextColor]><b><font color=red> </font>[key_name(src, M)](<A HREF='?src=\ref[M.client.holder];adminplayeropts=\ref[src]'>X</A>)</b> has created a possible pre-typed Emote.</font>"
					M << "<font color = teal>[type] - [msg]"
			return
		src.RPs += 1
		while(TextLength)
			TextLength -= 1
			if(src.RP_Earned < 0)
				var/Rested = 0
				if(src.RP_Rested > 0)
					Rested = src.RP_Rested/10000
					src.RP_Rested -= Rested
				src.RP_Points += num + Rested
				src.RP_Earned += num + Rested
				src.RP_Total += num + Rested
mob/proc/Say_Spark()
	var/image/A=image(icon='Say Spark.dmi',pixel_y=6)
	A.icon-=rgb(255,255,255)
	A.icon+=rgb(100,200,250)
	overlays+=A
	say_spark = A
	spawn(20) if(src) overlays-=A

/*mob/verb/Chronology()
	set category="Other"
	src<<browse(Chronology)*/

mob/verb
/*
	SeeTelepathy()
		set category="Other"
		if(seetelepathy)
			usr<<"Telepathy messages off."
			seetelepathy=0
		else
			usr<<"Telepathy messages on."
			seetelepathy=1
*/
	TextSize()
		set category="Other"
		TextSize=input("Enter a size for the text you will see on your screen, between 1 and 10, default is 2") as num
	TextColor()
		set category="Other"
		TextColor=input("Choose a color for OOC and Say.") as color

/mob/verb/listen_ooc()
	set name = "Toggle OOC"
	set category="Other"

	if (src.client)
		src.client.listen_ooc = !src.client.listen_ooc
		if (src.client.listen_ooc)
			src << "You are now listening to messages on the OOC channel."
		else
			src << "You are no longer listening to messages on the OOC channel."

mob/verb/AFK()
		set category = "Other"
		usr.TRIGGER_AFK()

mob/proc/TRIGGER_AFK(var/A=0)
	if(src.insideTank)
		src << "Unable to go afk inside a cloning tank."
		return
	if(src.insidePhylactery)
		src << "Unable to go afk while using a Phylactery."
		return
	if(src.afk==0)
		view(15) << "<span class=announce>[src.name] has gone AFK.</span>" // tells the world that they \
		gone AFK
		src.overlays += 'afk.dmi' // overlays the AFK image on player
		src.afk=1 // so it can effect it when they press AFK again and makes them immobile
		src.Went_Afk = 1
		spawn(100)
			if(src) src.Went_Afk = 0

		for(var/mob/player/M in view(15))
			if(M.client)
				if(A) M.saveToLog("[src] has automatically been set to AFK!")
				else M.saveToLog("[src] has set themselves to AFK!")
		return
	if(src.afk)
		for(var/obj/Rank/R in Rankings)
			if(R.Rank_Key)
				var/mob/M = null
				if(src.key == R.Rank_Key)
					M = src
				if(M)
					if(istext(R.Rank_AFK))
						R.Rank_AFK = 0
					R.Rank_AFK_Total += R.Rank_AFK
					R.Rank_AFK = 0
		view(15) << "<span class=announce>[src.name] came back from AFK.</span>" // tells the world \
		that they arrived back from AFK.
		src.overlays -= 'afk.dmi' // removes the AFK image.
		src.afk=0
		for(var/mob/player/M in view(15))
			if(M.client)
				M.saveToLog("[src] has returned from AFK!")
		return

/mob/verb/ooc(msg as text)
	set category = "Other"
	set name = "OOC"
	set instant = 1
	if (IsGuestKey(usr.key))
		usr << "You are not authorized to communicate over these channels."
		return
	if (!usr.client.listen_ooc)
		usr << "You have OOC disabled, you'll have to enable it to speak."
		return
	//msg = copytext(sanitize(msg), 1, MAX_MESSAGE_LEN)
	if(usr.Crazy) msg=Crazy(msg)
	msg = gSpamFilter.sf_Filter(usr,msg)
	if(!msg) return
	else if (!usr.client.listen_ooc)
		return
	else if (!ooc_allowed && !usr.client.holder)
		return
	else if (usr.client.muted)
		return
	else if (findtext(msg, "byond://") && !usr.client.holder)
		usr << "<B>Advertising other servers is not allowed.</B>"
		log_admin("[key_name(usr)] has attempted to advertise in OOC.")
		alertAdmins("[key_name_admin(usr)] has attempted to advertise in OOC.")
		return

	log_ooc("[usr.name]/[usr.key] : [msg]")

	for(var/client/C)
		if(C.listen_ooc)
			if (C.holder)
				C << output("<font color=green><span class=\"adminooc\"><span class=\"prefix\">OOC:</span> <span class=\"name\">[usr.key][usr.client.stealth ? "/([usr.client.fakekey])" : ""]([usr.name]) (<A HREF='?src=\ref[C.holder];adminplayeropts=\ref[usr]'>X</A>) :</span></font> <span class=\"message\">[msg]</span></span>","OOC")
			else if(usr.client.holder && usr.client.stealth)
				C << output("<font color=green><span class=\"ooc\"><span class=\"prefix\">OOC:</span> <span class=\"name\">[usr.client.stealth ? usr.client.fakekey : usr.key]:</span></font> <span class=\"message\">[msg]</span></span>","OOC")
			else
				C << output("<font color=green><span class=\"ooc\"><span class=\"prefix\">OOC:</span> <span class=\"name\">[usr.client.stealth ? usr.client.fakekey : usr.key]:</span></font> <span class=\"message\">[msg]</span></span>","OOC")

/mob/verb/
	Whisper(msg as text)
		set category="Other"
		set instant=1
		//var/Secs_Open = world.time / 10
		//var/msg = input("Whisper") as text
		var/icon/I = usr.getIconImage()
		msg = copytext(sanitize(msg), 1, MAX_MESSAGE_LEN)
		if(!msg)	return

		var/Old_Sight=see_invisible
		see_invisible=101
		//var/Secs_Close = world.time / 10
		//Secs_Close -= Secs_Open
		usr.Check_RP(msg,0.001)
		if(usr.Critical_Throat)
			msg = "*Mumbles incoherently*..."
		log_whisper("[usr.name]/[usr.key] : [msg]")

		if(!findtext(msg,"oocly")) if(usr.Health<=0 && prob(95))
			msg=stutter(msg)

		for(var/mob/player/M in view(usr)-view(2))
			if(M.Injury_Hearing == 0)
				M << "<BIG>\icon[I]</BIG><font size=[M.TextSize]>-[name] whispers something..."
		for(var/mob/player/M in view(2))
			if(M.client)
				var/Hear = 1
				if(M.Critical_Hearing)
					Hear = 0
				if(Hear)
					if(M.client.holder)
						M << "<BIG>\icon[I]</BIG><span class=\"whisper\"><font size=[M.TextSize] color=[TextColor]>*[usr.name] (<A HREF='?usr=\ref[M.client.holder];adminplayeropts=\ref[usr]'>X</A>) whispers, \"[msg]\"</span>"
					else
						M << "<BIG>\icon[I]</BIG><span class=\"whisper\"><font size=[M.TextSize] color=[TextColor]>*[usr.name] whispers, \"[msg]\"</span>"
					M.saveToLog("<span class=\"whisper\">[usr]([key]): whispers [msg]</span>\n")
				else
					M << "<i>You hear a distant noise...</i>"
		see_invisible=Old_Sight
		usr.Say_Spark()

	Say(msg as text)
		set category="Other"
		//var/Secs_Open = world.time / 10
		//var/msg = input("Say") as text
		var/icon/I = usr.getIconImage()
		msg = copytext(sanitize(msg), 1, MAX_MESSAGE_LEN)
		if(!msg)	return
		var/Old_Sight=see_invisible
		see_invisible=101
		log_say("[usr.name]/[usr.key] : [msg]")

		if(!findtext(msg,"oocly")) if(usr.Health<=0) if(prob(95))
			msg=stutter(msg)
		msg=say_quote(msg)	//Moved to after stutter
		//var/Secs_Close = world.time / 10
		//Secs_Close -= Secs_Open
		if(!findtext(msg,"oocly")) if(usr.Critical_Throat)
			msg = "*Mumbles incoherently*..."
		var/RP = 0.001
		for(var/mob/player/M in hearers(ViewX,usr))
			if(M.client)
				var/Hear = 1
				if(M.Critical_Hearing)
					Hear = 0
				if(findtext(msg,"oocly"))
					Hear = 1
					RP += 0.0005
				if(Hear)
					if(M.client.holder)
						M << "<BIG>\icon[I]</BIG><span class=\"say\"><font size=[M.TextSize] color=[TextColor]>[usr.name] (<A HREF='?usr=\ref[M.client.holder];adminplayeropts=\ref[usr]'>X</A>) [msg]</span>"
					else
						M << "<BIG>\icon[I]</BIG><span class=\"say\"><font size=[M.TextSize] color=[TextColor]>[usr.name] [msg]</span>"
					M.saveToLog("<span class=\"say\">[usr]([key]): [msg]</span>\n")
				else
					M << "<i>You hear a distant noise...</i>"
		if(!findtext(msg,"oocly"))
			usr.Check_RP(msg,RP)
			var/say_logfile = "Data/Players/[usr.lastKnownKey]/Logs/Say_[usr.real_name].log"
			file(say_logfile) << "Year - [Year], Time - [time2text(world.timeofday, "YYYY-MM-DDThh:mm:ss")] [usr] says [msg]"
		see_invisible=Old_Sight
		usr.Say_Spark()

	Emote()
		set category="Other"
		set instant=1
		for(var/mob/player/M in hearers(ViewX,usr))
			if(M.client)
				M.saveToLog("<br> | [M.client.address ? (M.client.address) : "IP not found"] | ([M.x], [M.y], [M.z]) | [key_name(M)] ::<br> <span class=\"emote\">*[usr] starts typing an emote.*</span>\n")
		overlays -= 'Typing.dmi'
		overlays += 'Typing.dmi'
		var/Secs_Open = world.time / 10
		var/msg = input("Emote") as message
		//var/Mins_Open = time2text(world.timeofday,"mm")
		msg = copytext(sanitize_n(msg), 1, MAX_MESSAGE_LEN)
		if(!msg)
			overlays -= 'Typing.dmi'
			for(var/mob/player/M in hearers(ViewX,usr))
				if(M.client)
					M.saveToLog("<br> | [M.client.address ? (M.client.address) : "IP not found"] | ([M.x], [M.y], [M.z]) | [key_name(M)] ::<br> <span class=\"emote\">*[usr] cancels their emote.*</span>\n")
			return
		var/icon/I = usr.getIconImage()
		var/Old_Sight=see_invisible
		see_invisible=101
		var/Secs_Close = world.time / 10
		Secs_Close -= Secs_Open
		usr.RP_Actual = msg
		log_emote("[usr.name]/[usr.key] : [msg]")
		var/RP = 0.001
		for(var/mob/player/M in hearers(ViewX,usr))
			if(M.client)
				if(RP < 0.005)
					RP += 0.0005
				if(M.client.holder)
					M << "<BIG>\icon[I]</BIG><span class=\"emote\"><font size=[M.TextSize]>*[usr] [msg]*</span>"
				else
					M << "<BIG>\icon[I]</BIG><span class=\"emote\"><font size=[M.TextSize]>*[usr] [msg]*</span>"
				M.saveToLog("<br> | [M.client.address ? (M.client.address) : "IP not found"] | ([M.x], [M.y], [M.z]) | [key_name(M)] ::<br> <span class=\"emote\">*[usr] [msg]*</span>\n")
		usr.Check_RP(msg,RP,Secs_Close,"Emote")
		see_invisible=Old_Sight
		usr.Say_Spark()
		overlays -= 'Typing.dmi'
		var/emote_logfile = "Data/Players/[lastKnownKey]/Logs/Emote_[real_name].log"
		file(emote_logfile) << "Year - [Year], Time - [time2text(world.timeofday, "YYYY-MM-DDThh:mm:ss")] [usr] [msg]"

obj/Telepathy_Hive/verb/Telepathy_Hive()
	set src=usr.contents
	set category="Skills"
	set instant=1
	if(usr.Dead)
		usr << "Unable to do this while deceased."
		return
	var/message=input("Say what in hive telepathy?") as text
	usr << "<span class=\"telepathy\"><font size=[usr.TextSize]>You say in hive telepathy \"[message]\"</font></span>"
	usr.saveToLog("<span class=\"telepathy\">You say in hive telepathy \"[message]\"</span>\n")
	var/say_logfile = "Data/Players/[usr.lastKnownKey]/Logs/Say_[usr.real_name].log"
	file(say_logfile) << "Year - [Year], Time - [time2text(world.timeofday, "YYYY-MM-DDThh:mm:ss")] [usr] says in hive telepathy \"[message]\""
	usr.Check_RP(message,0.001)
	for(var/mob/player/M in Players)
		if(locate(/obj/Telepathy_Hive) in M)
			if(M.seetelepathy) if(M != usr)

				message = copytext(sanitize(message), 1, MAX_MESSAGE_LEN)
				if(!message)	return
				log_telepathy("[usr.name]/[usr.key] : [message]")

				if(M)
					M << "<span class=\"telepathy\"><font size=[M.TextSize]>[usr] says in hive telepathy, \"[message]\"</font></span>"
					M.saveToLog("<span class=\"telepathy\">[usr] says in hive telepathy, \"[message]\"</span>\n")
					M.saveToLog("<span class=\"telepathy\">| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] Hive Telepaths: \"[message]\"</span>\n")
					if(M.client.holder)
						M << "- Telepathy from [usr.key] (<A HREF='?usr=\ref[M.client.holder];adminplayeropts=\ref[usr]'>X</A>)"
			else
				usr << "You are unable to communicate with [M.name]!"
obj/Telepathy/verb/Telepathy(mob/player/M in Players)
	set src=usr.contents
	set category="Skills"
	set instant=1
	if(usr.Critical_Head)
		usr << "Your head injury is preventing you from doing this for now."
		return
	if(M.seetelepathy)
		var/Secs_Open = world.time / 10
		var/message=input("Say what in telepathy?") as text

		message = copytext(sanitize(message), 1, MAX_MESSAGE_LEN)
		if(!message)	return
		log_telepathy("[usr.name]/[usr.key] : [message]")

		if(M)
			if(locate(/obj/Telepathy) in M)
				M << "<span class=\"telepathy\"><font size=[M.TextSize]>[usr] says in telepathy, \"[message]\"</font></span>"
				M.saveToLog("<span class=\"telepathy\">[usr] says in telepathy, \"[message]\"</span>\n")
			else
				M << "<span class=\"telepathy\"><font size=[M.TextSize]>A voice in your head says, \"[message]\"</font></span>"
				M.saveToLog("<span class=\"telepathy\">A voice in your head says, \"[message]\"</span>\n")
			if(M.client.holder)
				M << "- Telepathy from [usr.key] (<A HREF='?usr=\ref[M.client.holder];adminplayeropts=\ref[usr]'>X</A>)"
		var/Secs_Close = world.time / 10
		Secs_Close -= Secs_Open
		usr.Check_RP(message,0.001)
		usr << "<span class=\"telepathy\"><font size=[usr.TextSize]>You say in telepathy to [M.name], \"[message]\"</font></span>"
		usr.saveToLog("<span class=\"telepathy\">You say in telepathy to [M.name], \"[message]\"</span>\n")
		M.saveToLog("<span class=\"telepathy\">| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] Telepaths: \"[message]\"</span>\n")
		var/say_logfile = "Data/Players/[usr.lastKnownKey]/Logs/Say_[usr.real_name].log"
		file(say_logfile) << "Year - [Year], Time - [time2text(world.timeofday, "YYYY-MM-DDThh:mm:ss")] [usr] says in telepathy to [M.name], \"[message]\""
	else
		usr << "You are unable to communicate with [M.name]!"

mob/verb/Screen_Size()
	set category="Other"
	var/stretch=0

	var/choice=input("Set screentype to?") in list("Default","Stretch-to-fit")
	switch(choice)
		if("Stretch-to-fit")
			stretch=1

	ViewX=input("Enter the width of the screen, limits are 70.") as num
	ViewY=input("Enter the height of the screen.") as num
	if(ViewX<1) ViewX=1
	if(ViewY<1) ViewY=1
	if(ViewX>70) ViewX=70
	if(ViewY>70) ViewY=70
	if(isnum(ViewX)&&isnum(ViewY)) client.view="[ViewX]x[ViewY]"
	if(stretch)
		winset(src,"mapwindow.map","icon-size=0")
		winset(src,"mapwindow.map","icon-size=0")
		winset(src,"mapwindow.map","icon-size=0")
		winset(src.client,"mapwindow.map","icon-size=0")
	else
		winset(src,"mapwindow.map","icon-size=32")
		winset(src,"mapwindow.map","icon-size=32")
		winset(src,"mapwindow.map","icon-size=32")
		winset(src.client,"mapwindow.map","icon-size=32")
	usr.x_view = ViewX
	usr.y_view = ViewY

mob/var/viewstats=1

mob/verb/ViewStats()
	set category="Other"
	viewstats = !(viewstats)
	if(viewstats)
		usr<<"Stat display on."
	else
		usr<<"Stat display off."