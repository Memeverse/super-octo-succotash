mob/proc
	New_Character()
		//RareChance=rand(1,10)
		winshow(src, "maintitle",0)
		winset(src,"OutputWindow","pos = 0,500")
		Tabs=2
		src.Age = 0
		if(src.Born == 0)
			src.Body_Sizes()
		else
			src.Size = MEDIUM
		if(src)
			src.Race()
		if(src)
			alert("[RaceDescription]")
			switch(input("Are you sure you want to be \an [Race]?") in list("Yes","No"))
				if("No")
					var/mob/player/A = new
					A.key = key
					A = src
					del(src)
		if(src.Born == 0)
			src.Racial_Stats()
		if(src)
			src.Alien_Trans_Type()
		if(src)
			switch(input("Create \an [Race] with the chosen attributes?") in list("Yes","No"))
				if("No")
					if(src)
						var/mob/player/A = new
						A.key = key
						A = src
						del(src)
		if(src.Born == 0)
			src.Starting_Age()
		if(src)
			src.Gender()
		if(src)
			src.Choose_Hair()
		if(src)
			src.Skin()
		if(src)
			src.StatRank()
		if(src)
			src.Check_Incarnates()
		if(src)
			src.Name()
		if(src.Born == 0)
			src.Location()
		//Update_Player()
		if(src)
			src.XPRank()
		if(src)
			src.XPGrant()
		if(src)
			src.Stats()
		if(src.Born == 0)
			src.Set_Traits()
		if(src)
			LogYear=Year
			BirthYear=Year
			oicon=src.icon
			Ki = MaxKi
			contents+=new/obj/Resources
			contents+=new/obj/Mana
			//contents+=new/obj/Assess
			contents+=new/obj/Crandal
			contents+=new/obj/Colorfy
			if(src.ckey == "the real lockem shoto")
				contents+=new/obj/Expand
				contents+=new/obj/Fly
				contents+=new/obj/Attacks/Beam
				contents+=new/obj/Attacks/Explosion
				src.Base = 8000
				src.ssj = 1

			/* GENETICS
			for(var/obj/DNA/dna in src.DNAs)
				if(dna.name == "Saiyan DNA")
					if(!Tail)
						Tail_Add()
						break
						*/
			if(Race=="Tsufurujin")
				src.Neko_Add()
			//	contents+=new/obj/Oozaru
			src.Create_DNA()
			var/Y = Year
			Y = Y*50
			src.RP_Earned -= Y
			contents+=new/obj/Injure
			if(src.Born == 0)
				src.Stat_Variation(25,25)
			src.Set_Base_Mods()
			HasCreated=1
			if(src.Delete)
				var/obj/O = src.Delete
				del(O)
	Stats()
		if(Year > 10)
			var/Cap = Year * 0.1
			src.Boost = Cap
			src.MaxKi += 5000 * src.KiMod
			src.Ki = src.MaxKi
	Name()
		if(!client)
			return
		if(src.Race == "Android")
			src.real_name = sanitize_name(src.name)
		else
			var/newname = strip_html(copytext(input(src,"Name? ([MAX_NAME_LENGTH] character limit)  This will be your 'Realname' for the rest of your characters life, so choose wisely!"),1,MAX_NAME_LENGTH))
			real_name = sanitize_name(newname)
			name = newname
		if(!real_name)
			Name()
	Race()
		src.Signature = rand(111111,999999)
		var/list/A=new
		if(Vegeta)
			A+="Saiyan"
			A+="Tsufurujin"
		if(Earth) A+="Human"
		if(Namek) A+="Namekian"
		if(Ice) A+="Changeling"
		A+="Android"
		A+="Oni"
		A+="Demon"
		A+="Kaio"
		A+="Kyonshi"
		A+="Demigod"
		A+="Makyojin"

		if(src.client && src.client.holder && src.client.holder.level >= 5 || global.TestServerOn || (AllowRares&&AllowRares.Find(src.ckey)) )	//Coder or above | Testserver on or not | Player allowed to pick a rare.    AllowRares.Find(src.client)
			A.Add("Majin","Bio-Android", "Makaioshin")  //  Added my name in the case of the if statement, in case we need to use that code later.
		var/Majin = 1
		for(var/mob/M in Players)
			if(M.Race == "Majin")
				Majin -= 1
		var/Roll_Majin = prob(Majin)
		var/rolled = 0
		if(src.ckey in rare_keys)
			rolled = 1
			src << "<font color = teal>Note - You have already rolled a percentage chance for a rare this wipe."
		if(src.key == "Caims Second Soul")
			Roll_Majin = 1
		if(rolled == 0)
			if(Roll_Majin)
				A+="Majin"
				rare_keys += src.ckey
				alert(src, "The option to create a Majin has appeared.")
				src << "The option to create a Majin has appeared."
		if(Arconia|Vegeta) A+="Alien"
		for(var/obj/Baby/B) A+=B.Race
		A = sortList(A)
		var/obj/Baby/C=input("Choose Race") in A
		if(src) if(client)
			for(var/obj/Baby/D) C=D
		if(!isobj(C)) //If no available child is found let them choose their own standard race.
			if(C=="Android") Android()
			else if(C=="Human") Human()
			else if(C=="Alien") Alien()
			else if(C=="Majin")
				Majin()
				alertAdmins("[src.key] created a Majin rare.",1)
			else if(C=="Bio-Android") Bio()
			else if(C=="Demigod") Demigod()
			else if(C=="Makyojin") Makyojin()
			else if(C=="Kaio") Kaio()
			else if(C=="Kyonshi") Doll()
			else if(C=="Tsufurujin") Tsufurujin()
			else if(C=="Oni") Oni()
			else if(C=="Namekian") Namekian()
			else if(C=="Makaioshin") Makaioshin()
			else if(C=="Saiyan")
				var/list/Saiyan_Choices=new
				var/Elites=0
				var/Non_Elites=0
				if(src) if(client)
					for(var/mob/player/M in Players) if(M.client&&M.Race=="Saiyan"&&M.client.address!=client.address)
						if(M.Class=="Elite") Elites+=1
						else Non_Elites+=1
					if(src.client && src.client.holder && src.client.holder.level>=5 || AllowRares.Find(ckey)) //|| Elites*4 < Non_Elites)  AllowRares.Find(src.ckey))  null var bug edit
						Saiyan_Choices+="Elite"
					if(Elites*4 < Non_Elites) Saiyan_Choices+="Elite"
					Saiyan_Choices.Add("Normal","Low-Class")
					var/Choice=input("Choose Option. If Elite does not appear here it is because there can only \
					be 1 Elite for every 4 other types of Saiyan online.") in Saiyan_Choices
					if(Choice=="Normal") Normal()
					if(Choice=="Elite") Elite()
					if(Choice=="Low-Class") Low()
			else if(C=="Changeling") Changeling()
			else if(C=="Demon") Demon()
		else //If there is an available child of that race
			if(!C) client.mob=new/mob/player
			Offspring=1
			if(C.Race=="Android") Android()
			else if(C.Race=="Human") Human()
			else if(C.Race=="Namekian") Namekian()
			else if(C.Race=="Saiyan")
				var/Choice=alert(src,"Choose Option. If Elite does not appear here it is because there can \
				only be 1 Elite for every 4 other Saiyan types online.","","Normal","Elite","Low-Class")
				switch(Choice)
					if("Normal") Normal()
					if("Elite") Elite()
					if("Low-Class") Low()
			else if(C.Race=="Alien") Alien()
			else if(C.Race=="Demigod") Demigod()
			else if(C.Race=="Makyojin") Makyojin()
			else if(C.Race=="Kaio") Kaio()
			else if(C.Race=="Kyonshi") Doll()
			else if(C.Race=="Tsufurujin") Tsufurujin()
			else if(C.Race=="Changeling") Changeling()
			else if(C.Race=="Demon") Demon()
			else if(C.Race=="Oni") Oni()
			Base=C.Base
			Gain_Multiplier=C.Gain_Multiplier
			MaxKi=C.MaxKi*KiMod
			Decline=C.Decline
			if(C.z)
				loc=locate(C.x,C.y,C.z)
				view(C)<<"[src] hatches out of the egg!"
				Splice(C.Father,C.Mother)
				src.Born = 1
			else for(var/mob/D in Players) for(var/obj/Baby/E in D) if(C==E)
				loc=locate(D.x,D.y,D.z)
				Splice(E.Father,E.Mother)
				view(D)<<"[src] is finally born from their parent [D]!"
				src.Born = 1
			del(C)


mob/proc/Location()
	if(!z)
		if((Race in list("Human","Kyonshi","Makyojin"))||\
		(Class in list("Human Dominant","Balanced Mix")))
			loc=locate(Human_SpawnX,Human_SpawnY,Human_SpawnZ)
		else if(Race=="Majin") loc=locate(rand(1,world.maxx),rand(1,world.maxy),13)
		else if(Race=="Bio-Android") loc=locate(497,497,14)
		else if(Race=="Namekian") loc=locate(Namekian_SpawnX,Namekian_SpawnY,Namekian_SpawnZ)
		else if(Race=="Okage"|Race=="Saiyan"|Class=="Saiyan Dominant") loc=locate(405,350,2)
		else if(Race=="Demon") loc=locate(Demon_SpawnX,Demon_SpawnY,Demon_SpawnZ)
		else if(Race=="Tsufurujin") loc=locate(Tsufurujin_SpawnX,Tsufurujin_SpawnY,Tsufurujin_SpawnZ)
		else if(Race=="Android") loc=locate(321,419,14)
		else if(Race=="Changeling") loc=locate(Changeling_SpawnX,Changeling_SpawnY,Changeling_SpawnZ)
		else if(Race=="Kaio") loc=locate(Kaio_SpawnX,Kaio_SpawnY,Kaio_SpawnZ)
		else if(Race=="Demigod") loc=locate(Demi_SpawnX,Demi_SpawnY,Demi_SpawnZ)
		else if(Race=="Agorothian") loc=locate(210,189,8)
		else if(Race=="Vorlon") loc=locate(210,189,8)
		else if(Race=="Lesser Old One") loc=locate(420,134,6)
		else if(Race=="Alien") loc=locate(116,289,9)
		else if(Race=="Oni") loc=locate(Oni_SpawnX,Oni_SpawnY,Oni_SpawnZ)
		else if(Race=="Makyojin") loc=locate(Makyojin_SpawnX,Makyojin_SpawnY,Makyojin_SpawnZ)

	if(GravMastered<Gravity)
		GravMastered=Gravity
	if(!z)
		loc=locate(1,1,1)

mob/proc
	Alien_Trans_Type()
		if(Race == "Alien")
			var/Choice=alert(src,"Choose the type of transformation that best suits the build for your character.","","Ki","Melee","Hybrid")
			switch(Choice)
				if("Hybrid")
					Hybrid_Build = 1
					src << "You have chosen the Hybrid transformation, which acts best for a balanced build."
				if("Melee")
					Melee_Build = 1
					src << "You have chosen the Melee transformation, which acts best for a melee build with high strength, durability and regeneration."
				if("Ki")
					Ki_Build = 1
					src << "You have chosen the Ki transformation, which acts best for a ki build with high force, offence and speed."
	Gender()
		if(Race!="Majin"&&Race!="Bio-Android"&&Race!="Namekian"&&Race!="Yardrat"&&Race!="Makaioshin")
			var/Choice=alert(src,"Choose a gender","","Male","Female")
			switch(Choice)
				if("Female")
					gender="female"
				//	if(prob(90))	//Females mature faster most of the time
					//	InclineSpeed *= 1.2
				if("Male") gender="male"
	Choose_Hair()
		ssj3hair='Hair_SSj4.dmi'
		ssj3hair+=rgb(160,150,30)
		if(Race in list("Majin","Bio-Android","Namekian","Makyojin")) return
		var/list/Hairs=new
		Hairs.Add("Bald","Afro","The Hair Gel Lover","The Extreme","The Player","The Suave","The Everyman","Long","The Kid",\
		"The Punk","The Bowlcut","Spike","Mohawk","Freak","The Mini Gelled","The Anime 2","The Protaganist","The Bowl","The Unkempt","The Nerd","The Anime 3","The Gelled 2",\
		"Spikey","Super Curled","Female","Female 2","Female 3","Female 4","The Chick","The Anime","Hair, Blue, Male","Bushy",\
		"Hair + Headband","Female Ponytail","Messy","Male Ponytail","Short Female Hair","Ren?","The 80's","The Goldilocks",\
		"Shaggy","The Goldilocks","The Stylist","Hair Bun - Pinned","Hair Bob","Ponytail Left Side","Ponytail Back","Ponytail Right",\
		"Pigtails","Pigtails -  High","Long Haired, Pinned Back","The Emo","Long Hair -  Headband","Blue Hair -  Anime","The Fop","The Mullet","The Randley")
		Hairs = sortList(Hairs)
		switch(input(src,"Choose your hair") in Hairs)
			if("Bald")
				hair=null
				ssjhair=null
				ussjhair=null
				ssjfphair=null
				ssj2hair=null
				ssj3hair=null
			if("The Randley")
				hair='Maleek Hair.dmi'
				ssjhair=hair+rgb(150,150,0)
				ussjhair=ssjhair
				ssjfphair=hair+rgb(160,160,80)
				ssj2hair=hair+rgb(160,160,20)
			if("Shaggy")
				hair='Hair, Shaggy.dmi'
				ssjhair=hair+rgb(150,150,0)
				ussjhair=ssjhair
				ssjfphair=hair+rgb(160,160,80)
				ssj2hair=hair+rgb(160,160,20)
			if("Ren?")
				hair='Hair, Ren.dmi'
				ssjhair=hair+rgb(150,150,0)
				ussjhair=ssjhair
				ssjfphair=hair+rgb(160,160,80)
				ssj2hair=hair+rgb(160,160,20)
			if("Short Female Hair")
				hair='Hair, Short Female.dmi'
				ssjhair=hair+rgb(150,150,0)
				ussjhair=ssjhair
				ssjfphair=hair+rgb(160,160,80)
				ssj2hair=hair+rgb(160,160,20)
			if("Male Ponytail")
				hair='Hair, Ponytail.dmi'
				ssjhair='Hair, Ponytail, SSJ.dmi'
				ussjhair=ssjhair
				ssjfphair='Hair, Ponytail, SSJFP.dmi'
				ssj2hair=ssjhair
			if("Female Ponytail")
				hair='Hair, Female, Ponytail.dmi'
				ssjhair=hair+rgb(150,150,0)
				ussjhair=ssjhair
				ssjfphair=hair+rgb(160,160,80)
				ssj2hair=hair+rgb(160,160,20)
			if("Messy")
				hair='Hair, Messy.dmi'
				ssjhair=hair+rgb(150,150,0)
				ussjhair=ssjhair
				ssjfphair=hair+rgb(160,160,80)
				ssj2hair=hair+rgb(160,160,20)
			if("Bushy")
				hair='Hair, Bushy.dmi'
				ssjhair=hair+rgb(150,150,0)
				ussjhair=ssjhair
				ssjfphair=hair+rgb(160,160,80)
				ssj2hair=hair+rgb(160,160,20)
			if("Hair + Headband")
				hair='Hair, Brown, Headband.dmi'
				ssjhair=hair+rgb(150,150,0)
				ussjhair=ssjhair
				ssjfphair=hair+rgb(160,160,80)
				ssj2hair=hair+rgb(160,160,20)
			if("Hair, Blue, Male")
				hair='Hair, Blue, Male.dmi'
				ssjhair=hair+rgb(150,150,0)
				ussjhair=ssjhair
				ssjfphair=hair+rgb(160,160,80)
				ssj2hair=hair+rgb(160,160,20)
			if("The Anime")
				hair='Hair, Cloud.dmi'
				ssjhair=hair
				ussjhair=hair
				ssjfphair=hair
				ssj2hair=hair
				ssj3hair=hair
			if("The Nerd")
				hair='Hair Super 17.dmi'
				ssjhair='Hair_LongSSj.dmi'
				ussjhair='Hair_LongUSSj.dmi'
				ssjfphair='Hair_LongSSjFP.dmi'
				ssj2hair='Hair_LongSSj.dmi'
			if("The Bowl")
				hair='Hair Kidd.dmi'
				ssjhair='Hair_LongSSj.dmi'
				ussjhair='Hair_LongUSSj.dmi'
				ssjfphair='Hair_LongSSjFP.dmi'
				ssj2hair='Hair_LongSSj.dmi'
			if("The Unkempt")
				hair='Hair Muse.dmi'
				ssjhair='Hair_GokuSSj.dmi'
				ussjhair='Hair_GokuUSSj.dmi'
				ssjfphair='Hair_GokuSSjFP.dmi'
				ssj2hair='Hair_GokuUSSj.dmi'
				ssj3hair='Hair_GokuSSj3.dmi'
			if("The Protaganist")
				hair='Hair_Goku.dmi'
				ssjhair='Hair_GokuSSj.dmi'
				ussjhair='Hair_GokuUSSj.dmi'
				ssjfphair='Hair_GokuSSjFP.dmi'
				ssj2hair='Hair_GokuUSSj.dmi'
				ssj3hair='Hair_GokuSSj3.dmi'
			if("The Hair Gel Lover")
				hair='Hair_Vegeta.dmi'
				ssjhair='Hair_VegetaSSj.dmi'
				ussjhair='Hair_VegetaUSSj.dmi'
				ssjfphair='Hair_VegetaSSjFP.dmi'
				ssj2hair='Hair_VegetaSSj.dmi'
			if("The Extreme")
				hair='Hair_Raditz.dmi'
				ssjhair='Hair_RaditzSSj.dmi'
				ussjhair='Hair_GokuSSj3.dmi'
				ssjfphair='Hair_RaditzSSjFP.dmi'
				ssj2hair='Hair_RaditzSSj.dmi'
				ssj3hair='Hair_GokuSSj3.dmi'
			if("The Suave")
				hair='Hair_FutureGohan.dmi'
				ssjhair='Hair_GohanSSj.dmi'
				ussjhair='Hair_GohanUSSj.dmi'
				ssjfphair='Hair_GohanSSjFP.dmi'
				ssj2hair='Hair_GohanSSj.dmi'
			if("The Everyman")
				hair='Hair_Gohan.dmi'
				ssjhair='Hair_GohanSSj.dmi'
				ussjhair='Hair_GohanUSSj.dmi'
				ssjfphair='Hair_GohanSSjFP.dmi'
				ssj2hair='Hair_GohanSSj.dmi'
			if("Long")
				hair='Hair_Long.dmi'
				ssjhair='Hair_LongSSj.dmi'
				ussjhair='Hair_LongUSSj.dmi'
				ssjfphair='Hair_LongSSjFP.dmi'
				ssj2hair='Hair_LongSSj.dmi'
			if("The Kid")
				hair='Hair_KidGohan.dmi'
				ssjhair='Hair_KidGohanSSj.dmi'
				ussjhair='Hair_KidGohanUSSj.dmi'
				ssjfphair='Hair_KidGohanSSjFP.dmi'
				ssj2hair='Hair_KidGohanUSSj.dmi'
			if("The Chick")
				hair='Hair Kylin 2.dmi'
				ssjhair=hair+rgb(150,150,0)
				ussjhair='Hair_FemaleLongSSj.dmi'
				ssjfphair=hair+rgb(160,160,80)
				ssj2hair=hair+rgb(160,160,20)
			if("Female 4")
				hair='Hair Kylin 3.dmi'
				ssjhair=hair+rgb(150,150,0)
				ussjhair='Hair_FemaleLongSSj.dmi'
				ssjfphair=hair+rgb(160,160,80)
				ssj2hair=hair+rgb(160,160,20)
			if("Afro")
				hair='Hair Afro.dmi'
				ssjhair=hair+rgb(150,150,0)
				ussjhair=ssjhair
				ssjfphair=hair+rgb(160,160,80)
				ssj2hair=hair+rgb(160,160,20)
			if("Female 3")
				hair='Hair Kylin 1.dmi'
				ssjhair=hair+rgb(150,150,0)
				ussjhair='Hair_FemaleLongSSj.dmi'
				ssjfphair=hair+rgb(160,160,80)
				ssj2hair=hair+rgb(160,160,20)
			if("Female 2")
				hair='Hair_FemaleLong.dmi'
				ssjhair=hair+rgb(150,150,0)
				ussjhair='Hair_FemaleLongSSj.dmi'
				ssjfphair=hair+rgb(160,160,80)
				ssj2hair=hair+rgb(160,160,20)
			if("Female")
				hair='Hair_FemaleLong2.dmi'
				ssjhair=hair+rgb(150,150,0)
				ussjhair='Hair_FemaleLongSSj.dmi'
				ssjfphair=hair+rgb(160,160,80)
				ssj2hair=hair+rgb(160,160,20)
			if("Long")
				hair='Hair_Long.dmi'
				ssjhair='Hair_LongSSj.dmi'
				ussjhair='Hair_LongUSSj.dmi'
				ssjfphair='Hair_LongSSjFP.dmi'
				ssj2hair='Hair_LongSSj.dmi'
			if("The Punk")
				hair='Hair_Goten.dmi'
				ssjhair='Hair_GokuSSj.dmi'
				ussjhair='Hair_GokuUSSj.dmi'
				ssjfphair='Hair_GokuSSjFP.dmi'
				ssj2hair='Hair_GokuSSj.dmi'
			if("The Bowlcut")
				hair='Hair_GTTrunks.dmi'
				ssjhair='Hair_LongSSj.dmi'
				ussjhair='Hair_GokuUSSj.dmi'
				ssjfphair='Hair_LongSSjFP.dmi'
				ssj2hair='Hair_LongSSj.dmi'
			if("Spike")
				hair='Hair_GTVegeta.dmi'
				ssjhair='Hair_GTVegetaSSj.dmi'
				ussjhair='Hair_LongUSSj.dmi'
				ssjfphair=hair+rgb(150,150,50)
				ssj2hair='Hair_GTVegetaSSj.dmi'
			if("Mohawk")
				hair='Hair_Mohawk.dmi'
				ssjhair='Hair_MohawkSSj.dmi'
				ussjhair='Hair_LongUSSj.dmi'
				ssjfphair=hair+rgb(150,150,50)
				ssj2hair='Hair_MohawkSSj.dmi'
			if("Freak")
				hair='Hair_Spike.dmi'
				ssjhair='Hair_SpikeSSj.dmi'
				ussjhair='Hair_LongUSSj.dmi'
				ssjfphair=hair+rgb(150,150,50)
				ssj2hair='Hair_SpikeSSj.dmi'
			if("The Player")
				hair='Hair_Yamcha.dmi'
				ssjhair=hair+rgb(150,150,20)
				ussjhair='Hair_FemaleLongSSj.dmi'
				ssjfphair=hair+rgb(160,160,80)
				ssj2hair=hair+rgb(160,160,20)
			if("The Mini Gelled")
				hair='Hair Vegeta Junior.dmi'
				ssjhair=hair+rgb(150,150,20)
				ussjhair='Hair_VegetaUSSj.dmi'
				ssjfphair=hair+rgb(160,160,80)
				ssj2hair=hair+rgb(150,150,20)
			if("The Anime 2")
				hair='Hair Lan.dmi'
				ssjhair=hair+rgb(150,150,20)
				ussjhair=hair+rgb(100,150,20)
				ssjfphair=hair+rgb(160,160,80)
				ssj2hair=hair+rgb(160,160,20)
			if("The Anime 3")
				hair='BlackSSJhair.dmi'
				ssjhair=hair+rgb(150,150,20)
				ussjhair='Hair_GokuSSj.dmi'
				ssjfphair=hair+rgb(160,160,80)
				ssj2hair=hair+rgb(150,150,20)
			if("The Gelled 2")
				hair='GT Goten Hair.dmi'
				ssjhair=hair+rgb(150,150,20)
				ussjhair='GT Gotens Hair ASsj.dmi'
				ssjfphair=hair+rgb(160,160,80)
				ssj2hair=hair+rgb(150,150,20)
			if("Spikey")
				hair='New Hair.dmi'
				ssjhair=hair+rgb(150,150,20)
				ussjhair='Hair_VegetaUSSj.dmi'
				ssjfphair=hair+rgb(160,160,80)
				ssj2hair=hair+rgb(150,150,20)
			if("Super Curled")
				hair='SSJ4.dmi'
				ssjhair=hair+rgb(150,150,20)
				ussjhair='Hair_GokuSSj.dmi'
				ssjfphair=hair+rgb(160,160,80)
				ssj2hair=hair+rgb(150,150,20)
			if("The 80's")
				hair='Zangya Hair.dmi'
			if("The Goldilocks")
				hair='Blonde hair.dmi'
			if("The Stylist")
				hair='Brown flicky hair.dmi'
			if("Hair Bun - Pinned")
				hair='BUN.dmi'
			if("Hair Bob")
				hair='CHEGWEG BOB.dmi'
			if("Ponytail Left Side")
				hair='CHEGWEG left side ponytail.dmi'
			if("Ponytail Back")
				hair='CHEGWEG ponytail.dmi'
			if("Ponytail Right")
				hair='CHEGWEG right side ponytail.dmi'
			if("Pigtails")
				hair='CHEGWEG PIGTAILS.dmi'
			if("Pigtails -  High")
				hair='High pigtails.dmi'
			if("Long Haired, Pinned Back")
				hair='cosmic blue pinned back hair.dmi'
			if("The Emo")
				hair='Emo hair.dmi'
			if("Long Hair -  Headband")
				hair='Female hair with pink alice band long.dmi'
			if("Blue Hair -  Anime")
				hair='Large blue hair.dmi'
			if("The Fop")
				hair='GenesisHair.dmi'
			if("The Mullet")
				hair='HairBroly.dmi'

		Hair_Base=hair
		Hair_Age=Age
		if((Race!="Saiyan"&&hair)||(Race=="Saiyan"&&icon))
			HairColor=input("Choose your hair color") as color|null
			if(HairColor) hair+=HairColor
		ssj4hair='Hair_SSj4.dmi'
		if(HairColor) ssj4hair+=HairColor
		//Add line for Aquatian hair shifting here.
		if(hair)
			overlays+=hair
		if(Race=="Mutant Saiyan")
			ssjhair='Hair Mutant 2.dmi'
			ussjhair='Hair Mutant.dmi'
	Human_Skins()
		if(gender=="male") switch(input(src,"Choose your skin color") in list("Pale","Tan","Dark"))
			if("Pale") icon='new human white.dmi'
			if("Tan") icon='Tan male.dmi'
			if("Dark") icon='Black male.dmi'
		else switch(input(src,"Choose your skin color") in list("Pale","Tan","Dark","Pale 2"))
			if("Pale") icon='White Female.dmi'
			if("Tan") icon='Tan female.dmi'
			if("Dark") icon='Black female.dmi'
			if("Pale 2") icon='White Female 2.dmi'
	Aqua_Skins()
		if(gender=="male")
			icon='Aqua Male Base.dmi'
			Form1Icon='Aqua Male Base.dmi'
		if(gender=="female")
			icon='Aqua Female Base.dmi'
			Form1Icon='Aqua Female Base.dmi'
	Skin()
		var/Colorable
		switch(Race)
			if("Alien") // Do nothing
				return
			if("Bio-Android") switch(input(src,"What color body?") in list("Green","Blue"))
				if("Green") icon='Bio Android 1.dmi'
				if("Blue") icon='Bio1.dmi'
			if("Changeling")
				//icon='Aqua Male Base.dmi'
				//Form1Icon='Aqua Male Base.dmi'
				//Aqua_Skins()
				return
			if("Android")
				for(var/B in typesof(/obj/Android_Icons)) contents+=new B
				for(var/obj/Android_Icons/B in src) if(B.type==/obj/Android_Icons) del(B)
				src<<"Choose your icon out of the selections in the browser tab."
				Tabs="Android Icons"
				while(Tabs!=2) sleep(1)
			if("Spirit Doll") //icon='Spirit Doll.dmi'
				for(var/B in typesof(/obj/SD_Icons)) contents+=new B
				for(var/obj/SD_Icons/B in src) if(B.type==/obj/SD_Icons) del(B)
				src<<"Choose your icon out of the selections in the browser tab."
				Tabs="SD Icons"
				while(Tabs!=2) sleep(1)
			if("Makyojin")
				icon='Makyojin 2.dmi'
				for(var/B in typesof(/obj/Makyo_Icons)) contents+=new B
				for(var/obj/Makyo_Icons/B in src) if(B.type==/obj/Makyo_Icons) del(B)
				src<<"Choose your icon out of the selections in the browser tab."
				Tabs="Makyo Icons"
				while(Tabs!=2) sleep(1)
				if (src.icon=='Makyojin 2.dmi')
					Colorable=1
			if("Oni")
				for(var/B in typesof(/obj/Oni_Icons)) contents+=new B
				for(var/obj/Oni_Icons/B in src) if(B.type==/obj/Oni_Icons) del(B)
				src<<"Choose your icon out of the selections in the browser tab."
				Tabs="Oni Icons"
				while(Tabs!=2) sleep(1)
			if("Phrexian" || "Kaio")
				if(gender=="male") icon='Custom Male.dmi'
				else icon='Custom Female.dmi'
				Colorable=1
				switch(input(src,"What icon do you want?") in list("Custom","Human","Avatar"))
					if("Human")
						Human_Skins()
						Colorable=0
					if("Avatar") icon='Avatar.dmi'
			if("Demon")
				for(var/B in typesof(/obj/Demon_Icons)) contents+=new B
				for(var/obj/Demon_Icons/B in src) if(B.type==/obj/Demon_Icons) del(B)
				src<<"Choose your icon out of the selections in the browser tab."
				Tabs="Demon Icons"
				while(Tabs!=2) sleep(1)
				Colorable=1
			if("Makaioshin")
				icon='Makaioshin Base Fixed.dmi'
			if("Majin")
				icon='Majin.dmi'
				Colorable=1
			if("Namekian" || "Ancient Namekian")
			//	return
				icon='Namek.dmi'
				switch(input(src,"Choose your skin color") in list("Light Green","Green","Dark Green","Dragon Clan","Foreign Namek"))
					if("Light Green") icon+=rgb(30,30,30)
					if("Dark Green") icon-=rgb(30,30,30)
					if("Dragon Clan") icon='Namek Young.dmi'
					if("Foreign Namek") icon='Namek 2.dmi'
			else
				Human_Skins()
				if(Race=="Demigod")
					icon+=rgb(60,60,60)
		if(Colorable)
			var/A=input("Choose a color") as color|null
			var/icon/I = new(icon)
			if(A)
				I.MapColors(A,"#ffffff","#000000")
				I.MapColors(A,"#ffffff","#000000")
				I.MapColors(A,"#ffffff","#000000")
			icon=I
