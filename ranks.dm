/client/proc/Give_Rank(mob/A in Players)
	set category="Admin"
	set name = "Give Rank"

	if(!usr.client.holder&&!global.TestServerOn)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	var/Remove = 0
	var/TXT = "made"
	var/list/choice=new
	choice.Add("Cancel","Add Rank","Remove Rank")
	switch(input(src,"Choose") in choice)
		if("Cancel") return
		if("Remove Rank")
			Remove = 1
			TXT = "removed"
	var/list/Planets=new
	Planets.Add("Cancel","Earth","Namek","Vegeta","Arconia","Ice Planet","Heaven","Hell")
	var/list/Ranks=new
	switch(input(src,"Choose Planet Rank") in Planets)
		if("Cancel") return
		if("Earth")
			Ranks.Add("Cancel","Earth Guardian","Korin","Turtle Hermit","Crane Hermit","Teacher")
			switch(input(src,"What Rank?") in Ranks)
				if("Cancel") return
				if("Earth Guardian")
					A.Guardian(Remove)
					A.CreateRank("Earth Guardian")
					logAndAlertAdmins("[key_name(src)] [TXT] [key_name(A)] Earth Guardian",2)
				if("Korin")
					A.Korin(Remove)
					A.CreateRank("Korin")
					logAndAlertAdmins("[key_name(src)] [TXT] [key_name(A)] Korin",2)
				if("Turtle Hermit")
					A.Turtle_Hermit(Remove)
					A.CreateRank("Turtle Hermit")
					logAndAlertAdmins("[key_name(src)] [TXT] [key_name(A)] Turtle Hermit",2)
				if("Crane Hermit")
					A.Crane_Hermit(Remove)
					A.CreateRank("Crane Hermit")
					logAndAlertAdmins("[key_name(src)] [TXT] [key_name(A)] Crane Hermit",2)
				if("Teacher")
					A.Earth_Teacher(Remove)
					A.CreateRank("Earth Teacher")
					logAndAlertAdmins("[key_name(src)] [TXT] [key_name(A)] Earth Teacher",2)
		if("Namek")
			Ranks.Add("Cancel","Elder","Teacher")
			switch(input(src,"What Rank?") in Ranks)
				if("Cancel") return
				if("Elder")
					A.Elder(Remove)
					A.contents+=new/obj/Telekinesis_Magic
					A.contents+=new/obj/Telekinesis
					A.TK = 1
					A.TK_Magic = 1
					if(A.UP == null)
						A.KiMod = A.KiMod*1.2
						A.BPMod = A.BPMod*1.2
						A.UP = 1
					A.CreateRank("Namek Elder")
					logAndAlertAdmins("[key_name(src)] [TXT] [key_name(A)] Namekian elder",2)
				if("Teacher")
					A.Namek_Teacher(Remove)
					A.CreateRank("Namek Teacher")
					logAndAlertAdmins("[key_name(src)] [TXT] [key_name(A)] Namekian Teacher",2)
		if("Vegeta")
			Ranks.Add("Cancel","King/Queen","Teacher")
			switch(input(src,"What Rank?") in Ranks)
				if("Cancel") return
				if("King/Queen")
					A.Royalty(Remove)
					A.CreateRank("King/Queen")
					logAndAlertAdmins("[key_name(src)] [TXT] [key_name(A)] King/Queen of Vegeta",2)
				if("Teacher")
					A.Vegeta_Teacher(Remove)
					A.CreateRank("Vegeta Teacher")
					logAndAlertAdmins("[key_name(src)] [TXT] [key_name(A)] Saiyan Teacher",2)
		if("Arconia")
			Ranks.Add("Cancel","Yardrat Master","Skill Master")
			switch(input(src,"What Rank?") in Ranks)
				if("Cancel") return
				if("Yardrat Master")
					A.Yardrat_Master(Remove)
					A.CreateRank("Yardrat Master")
					logAndAlertAdmins("[key_name(src)] [TXT] [key_name(A)] Yardrat Master",2)
				if("Skill Master")
					A.Alien_Skill_Master(Remove)
					A.CreateRank("Arconia Skill Master")
					logAndAlertAdmins("[key_name(src)] [TXT] [key_name(A)] Arconia Skill Master",2)
		if("Ice Planet")
			Ranks.Add("Cancel","Skill Master")
			switch(input(src,"What Rank?") in Ranks)
				if("Cancel") return
				if("Skill Master")
					A.Ice_Skill_Master(Remove)
					A.contents+=new/obj/Telekinesis
					A.TK = 1
					A.CreateRank("Ice Skill Master")
					logAndAlertAdmins("[key_name(src)] [TXT] [key_name(A)] Ice Skill Master",2)
		if("Heaven")
			Ranks.Add("Cancel","Kaioshin","North Kaio","South/East/West Kaio","Kaio Helper")
			switch(input(src,"What Rank?") in Ranks)
				if("Cancel") return
				if("Kaioshin")
					A.Kaioshin(Remove)
					A.contents+=new/obj/Telekinesis_Magic
					A.contents+=new/obj/Telekinesis
					A.TK = 1
					A.TK_Magic = 1
					A.CreateRank("Kaioshin")
					if(A.UP == null)
						A.KiMod = A.KiMod*1.2
						A.BPMod = A.BPMod*1.2
						A.UP = 1
					logAndAlertAdmins("[key_name(src)] [TXT] [key_name(A)] Kaioshin",2)
				if("North Kaio")
					A.North_Kaio(Remove)
					A.CreateRank("North Kai")
					logAndAlertAdmins("[key_name(src)] [TXT] [key_name(A)] North Kaio",2)
				if("South/East/West Kaio")
					A.Cardinal_Kaio(Remove)
					A.CreateRank("South/East/West Kai")
					logAndAlertAdmins("[key_name(src)] [TXT] [key_name(A)] Cardinal Kaio",2)
				if("Kaio Helper")
					A.Kaio_Helper(Remove)
					A.CreateRank("Kai Helper")
					logAndAlertAdmins("[key_name(src)] [TXT] [key_name(A)] Kaio Helper",2)
		if("Hell")
			Ranks.Add("Cancel","Demon Lord","Hell Skillmaster")
			switch(input(src,"What Rank?") in Ranks)
				if("Cancel") return
				if("Demon Lord")
					A.Daimaou(Remove)
					A.contents+=new/obj/Telekinesis_Magic
					A.contents+=new/obj/Telekinesis
					A.TK = 1
					A.TK_Magic = 1
					if(A.UP == null)
						A.EndMod = A.EndMod*1.2
						A.OffMod = A.OffMod*1.2
						A.Decline = A.Decline*1.1
						A.UP = 1
					A.CreateRank("Demon Lord")
					logAndAlertAdmins("[key_name(src)] [TXT] [key_name(A)] Daimaou",2)
				if("Hell Skillmaster")
					A.Demon_Master(Remove)
					A.CreateRank("Hell Skill Master")
					logAndAlertAdmins("[key_name(src)] [TXT] [key_name(A)] Demon Master",2)
	A.Remove_Duplicate_Moves() // A dirty fix.
	src<<"You will still have to add them to the Ranks window. This only gives them the skills."
mob/proc
	Guardian(var/R)
		if(R == 0)
			contents.Add(new/obj/Attacks/Blast,new/obj/Attacks/Charge,new/obj/Attacks/Beam,new/obj/Fly,\
			new/obj/Power_Control,new/obj/Heal,new/obj/Materialization,new/obj/Shield,new/obj/Give_Power,\
			new/obj/Keep_Body,new/obj/Bind,new/obj/Telepathy)
			if(Race=="Namekian") contents.Add(new/obj/Make_Magic_Balls,new/obj/Fusion)
			Alter_Age(50)
			contents+=new/obj/RankChat
			var/obj/items/Crystal_Ball/B = new
			B.Special_Ball = 1
			B.loc = src
			src.Sense_Alignment = 1
		else
			src << "Your rank was removed."
			var/list/Skills = list(/obj/Attacks/Blast,/obj/Attacks/Charge,/obj/Attacks/Beam,/obj/Fly,\
			/obj/Power_Control,/obj/Heal,/obj/Materialization,/obj/Shield,/obj/Give_Power,\
			/obj/Keep_Body,/obj/Bind,/obj/Telepathy)
			if(Race=="Namekian") Skills.Add(/obj/Make_Magic_Balls,/obj/Fusion)
			Skills.Add(/obj/RankChat)
			for(var/obj/O in src)
				if(O.type in Skills) del(O)
	Korin(var/R)
		if(R == 0)
			contents.Add(new/obj/items/Senzu,new/obj/Fly,new/obj/Heal,new/obj/Give_Power,new/obj/Zanzoken,\
			new/obj/Power_Control)
			Alter_Age(50)
			contents+=new/obj/RankChat
		else
			src << "Your rank was removed."
			var/list/Skills = list(/obj/items/Senzu,/obj/Fly,/obj/Heal,/obj/Give_Power,/obj/Zanzoken,\
			/obj/Power_Control,/obj/RankChat)
			for(var/obj/O in src)
				if(O.type in Skills) del(O)
	Turtle_Hermit(var/R)
		if(R == 0)
			contents.Add(new/obj/Attacks/Charge,new/obj/Attacks/Beam,new/obj/Attacks/Kamehameha,\
			new/obj/Zanzoken,new/obj/Fly,new/obj/Expand,new/obj/Focus,new/obj/Heal,new/obj/Give_Power)
			Alter_Age(30)
			contents+=new/obj/RankChat
		else
			src << "Your rank was removed."
			var/list/Skills = list(/obj/Attacks/Charge,/obj/Attacks/Beam,/obj/Attacks/Kamehameha,\
			/obj/Zanzoken,/obj/Fly,/obj/Expand,/obj/Focus,/obj/Heal,/obj/Give_Power)
			for(var/obj/O in src)
				if(O.type in Skills) del(O)
	Crane_Hermit(var/R)
		if(R == 0)
			contents.Add(new/obj/Attacks/Blast,new/obj/Attacks/Beam,new/obj/Attacks/Dodompa,new/obj/Taiyoken,\
			new/obj/SplitForm,new/obj/Self_Destruct,new/obj/Attacks/Kikoho,new/obj/Fly)
			Alter_Age(30)
			contents+=new/obj/RankChat
		else
			src << "Your rank was removed."
			var/list/Skills = list(/obj/Attacks/Blast,/obj/Attacks/Beam,/obj/Attacks/Dodompa,/obj/Taiyoken,\
			/obj/SplitForm,/obj/Self_Destruct,/obj/Attacks/Kikoho,/obj/Fly)
			for(var/obj/O in src)
				if(O.type in Skills) del(O)
	Earth_Teacher(var/R)
		if(R == 0)
			contents.Add(new/obj/Attacks/Blast,new/obj/Attacks/Charge,new/obj/Attacks/Beam,new/obj/Fly,\
			new/obj/Attacks/Sokidan,new/obj/Heal,new/obj/Shield,new/obj/Attacks/Kienzan)
		else
			src << "Your rank was removed."
			var/list/Skills = list(/obj/Attacks/Blast,/obj/Attacks/Charge,/obj/Attacks/Beam,/obj/Fly,\
			/obj/Attacks/Sokidan,/obj/Heal,/obj/Shield,/obj/Attacks/Kienzan)
			for(var/obj/O in src)
				if(O.type in Skills) del(O)
	Elder(var/R)
		if(R == 0)
			contents.Add(new/obj/Attacks/Charge,new/obj/Fly,new/obj/Heal,new/obj/Power_Control,new/obj/Focus,\
			new/obj/Materialization,new/obj/Unlock_Potential,new/obj/Give_Power,new/obj/Shield,new/obj/Telepathy)
			if(Race=="Namekian") contents.Add(new/obj/Make_Magic_Balls,new/obj/Fusion)
			Alter_Age(10)
			Magic_Potential = 4
			contents+=new/obj/RankChat
			src.Sense_Alignment = 1
		else
			src << "Your rank was removed."
			var/list/Skills = list(/obj/Attacks/Charge,/obj/Fly,/obj/Heal,/obj/Power_Control,/obj/Focus,\
			/obj/Materialization,/obj/Unlock_Potential,/obj/Give_Power,/obj/Shield,/obj/Telepathy)
			if(Race=="Namekian") contents.Add(/obj/Make_Magic_Balls,/obj/Fusion)
			for(var/obj/O in src)
				if(O.type in Skills) del(O)
	Namek_Teacher(var/R)
		if(R == 0)
			contents.Add(new/obj/Attacks/Blast,new/obj/Attacks/Charge,new/obj/Attacks/Masenko,\
			new/obj/Attacks/Piercer,new/obj/Attacks/Sokidan,new/obj/Attacks/Homing_Finisher,\
			new/obj/Attacks/Makosen,new/obj/Expand,new/obj/Focus,new/obj/Fly,new/obj/Zanzoken,\
			new/obj/Power_Control,new/obj/SplitForm,new/obj/Heal,new/obj/Materialization,new/obj/Shield,\
			new/obj/Give_Power)
			if(Race=="Namekian") contents.Add(new/obj/Fusion)
			Alter_Age(5)
		else
			src << "Your rank was removed."
			var/list/Skills = list(/obj/Attacks/Blast,/obj/Attacks/Charge,/obj/Attacks/Masenko,\
			/obj/Attacks/Piercer,/obj/Attacks/Sokidan,/obj/Attacks/Homing_Finisher,\
			/obj/Attacks/Makosen,/obj/Expand,/obj/Focus,/obj/Fly,/obj/Zanzoken,\
			/obj/Power_Control,/obj/SplitForm,/obj/Heal,/obj/Materialization,/obj/Shield,\
			/obj/Give_Power)
			for(var/obj/O in src)
				if(O.type in Skills) del(O)
	Royalty(var/R)
		if(R == 0)
			contents.Add(new/obj/Attacks/Charge,new/obj/Attacks/Explosion,new/obj/Attacks/Beam,\
			new/obj/Attacks/Galic_Gun,new/obj/Attacks/Final_Flash,new/obj/Fly,new/obj/Attacks/Kienzan,\
			new/obj/Attacks/Shockwave,new/obj/Power_Ball,new/obj/Power_Control)
			Alter_Age(10)
		else
			src << "Your rank was removed."
			var/list/Skills = list(/obj/Attacks/Charge,/obj/Attacks/Explosion,/obj/Attacks/Beam,\
			/obj/Attacks/Galic_Gun,/obj/Attacks/Final_Flash,/obj/Fly,/obj/Attacks/Kienzan,\
			/obj/Attacks/Shockwave,/obj/Power_Ball,/obj/Power_Control)
			for(var/obj/O in src)
				if(O.type in Skills) del(O)
	Vegeta_Teacher(var/R)
		if(R == 0)
			contents.Add(new/obj/Attacks/Blast,new/obj/Attacks/Charge,new/obj/Attacks/Beam,\
			new/obj/Attacks/Explosion,new/obj/Self_Destruct,new/obj/Fly,new/obj/Expand)
			Alter_Age(5)
		else
			src << "Your rank was removed."
			var/list/Skills = list(/obj/Attacks/Blast,/obj/Attacks/Charge,/obj/Attacks/Beam,\
			/obj/Attacks/Explosion,/obj/Self_Destruct,/obj/Fly,/obj/Expand)
			for(var/obj/O in src)
				if(O.type in Skills) del(O)
	Yardrat_Master(var/R)
		if(R == 0)
			contents.Add(new/obj/Shunkan_Ido,new/obj/Fly,new/obj/Zanzoken,new/obj/Attacks/Blast,\
			new/obj/Attacks/Charge,new/obj/Attacks/Sokidan,new/obj/Heal,new/obj/Shield,new/obj/Limit_Breaker,new/obj/Telepathy)
			Alter_Age(10)
		else
			src << "Your rank was removed."
			var/list/Skills = list(/obj/Shunkan_Ido,/obj/Fly,/obj/Zanzoken,/obj/Attacks/Blast,\
			/obj/Attacks/Charge,/obj/Attacks/Sokidan,/obj/Heal,/obj/Shield,/obj/Limit_Breaker,/obj/Telepathy)
			for(var/obj/O in src)
				if(O.type in Skills) del(O)
	Alien_Skill_Master(var/R)
		if(R == 0)
			contents.Add(new/obj/Attacks/Blast,new/obj/Attacks/Charge,new/obj/Attacks/Beam,\
			new/obj/Attacks/Spin_Blast,new/obj/Attacks/Explosion,new/obj/Attacks/Sokidan,new/obj/Fly,\
			new/obj/Power_Control,new/obj/Expand,new/obj/SplitForm,new/obj/Attacks/Shockwave)
			Alter_Age(5)
		else
			src << "Your rank was removed."
			var/list/Skills = list(/obj/Attacks/Blast,/obj/Attacks/Charge,/obj/Attacks/Beam,\
			/obj/Attacks/Spin_Blast,/obj/Attacks/Explosion,/obj/Attacks/Sokidan,/obj/Fly,\
			/obj/Power_Control,/obj/Expand,/obj/SplitForm,/obj/Attacks/Shockwave)
			for(var/obj/O in src)
				if(O.type in Skills) del(O)
	Ice_Skill_Master(var/R)
		if(R == 0)
			contents.Add(new/obj/Attacks/Blast,new/obj/Attacks/Charge,new/obj/Attacks/Explosion,\
			new/obj/Attacks/Beam,new/obj/Attacks/Ray,new/obj/Attacks/Sokidan,new/obj/Attacks/Death_Ball,\
			new/obj/Fly,new/obj/Power_Control,new/obj/Expand,new/obj/Shield,new/obj/Attacks/Kienzan)
		else
			src << "Your rank was removed."
			var/list/Skills = list(/obj/Attacks/Blast,/obj/Attacks/Charge,/obj/Attacks/Explosion,\
			/obj/Attacks/Beam,/obj/Attacks/Ray,/obj/Attacks/Sokidan,/obj/Attacks/Death_Ball,\
			/obj/Fly,/obj/Power_Control,/obj/Expand,/obj/Shield,/obj/Attacks/Kienzan)
			for(var/obj/O in src)
				if(O.type in Skills) del(O)
	Kaioshin(var/R)
		if(R == 0)
			contents.Add(new/obj/Attacks/Blast,new/obj/Attacks/Charge,new/obj/Attacks/Beam,\
			new/obj/Attacks/Sokidan,new/obj/Attacks/Homing_Finisher,new/obj/Heal,new/obj/Shield,\
			new/obj/Give_Power,new/obj/Fly,new/obj/Power_Control,new/obj/Focus,new/obj/Materialization,\
			new/obj/Mystify,new/obj/Unlock_Potential,new/obj/Keep_Body,new/obj/Restore_Youth,new/obj/Kaio_Revive,\
			new/obj/Reincarnate,new/obj/Bind,new/obj/Make_Fruit,new/obj/Teleport,new/obj/Telepathy)
			Base*=10
			Base+= 10000
			Alter_Age(1500)
			contents+=new/obj/RankChat
			src.Sense_Alignment = 1
		else
			src << "Your rank was removed."
			var/list/Skills = list(/obj/Attacks/Blast,/obj/Attacks/Charge,/obj/Attacks/Beam,\
			/obj/Attacks/Sokidan,/obj/Attacks/Homing_Finisher,/obj/Heal,/obj/Shield,\
			/obj/Give_Power,/obj/Fly,/obj/Power_Control,/obj/Focus,/obj/Materialization,\
			/obj/Mystify,/obj/Unlock_Potential,/obj/Keep_Body,/obj/Restore_Youth,/obj/Kaio_Revive,\
			/obj/Reincarnate,/obj/Bind,/obj/Make_Fruit,/obj/Teleport,/obj/Telepathy)
			for(var/obj/O in src)
				if(O.type in Skills) del(O)
	North_Kaio(var/R)
		if(R == 0)
			contents.Add(new/obj/Attacks/Charge,new/obj/Attacks/Sokidan,new/obj/Fly,new/obj/Heal,new/obj/Give_Power,\
			new/obj/Power_Control,new/obj/Focus,new/obj/Keep_Body,new/obj/Kaio_Revive,new/obj/Materialization,\
			new/obj/Bind,new/obj/Kaioken,new/obj/Attacks/Genki_Dama,new/obj/Telepathy)
			Alter_Age(100)
			contents+=new/obj/RankChat
		else
			src << "Your rank was removed."
			var/list/Skills = list(/obj/Attacks/Charge,/obj/Attacks/Sokidan,/obj/Fly,/obj/Heal,/obj/Give_Power,\
			/obj/Power_Control,/obj/Focus,/obj/Keep_Body,/obj/Kaio_Revive,/obj/Materialization,\
			/obj/Bind,/obj/Kaioken,/obj/Attacks/Genki_Dama,/obj/Telepathy)
			for(var/obj/O in src)
				if(O.type in Skills) del(O)
	Cardinal_Kaio(var/R)
		if(R == 0)
			contents.Add(new/obj/Attacks/Blast,new/obj/Attacks/Charge,new/obj/Attacks/Beam,new/obj/Attacks/Sokidan,\
			new/obj/Fly,new/obj/Heal,new/obj/Shield,new/obj/Give_Power,new/obj/Power_Control,new/obj/Focus,\
			new/obj/Materialization,new/obj/Keep_Body,new/obj/Kaio_Revive,new/obj/Limit_Breaker,new/obj/Bind,new/obj/Telepathy)
			Alter_Age(100)
			contents+=new/obj/RankChat
		else
			src << "Your rank was removed."
			var/list/Skills = list(/obj/Attacks/Blast,/obj/Attacks/Charge,/obj/Attacks/Beam,/obj/Attacks/Sokidan,\
			/obj/Fly,/obj/Heal,/obj/Shield,/obj/Give_Power,/obj/Power_Control,/obj/Focus,\
			/obj/Materialization,/obj/Keep_Body,/obj/Kaio_Revive,/obj/Limit_Breaker,/obj/Bind,/obj/Telepathy)
			for(var/obj/O in src)
				if(O.type in Skills) del(O)
	Kaio_Helper(var/R)
		if(R == 0)
			contents.Add(new/obj/Kaio_Revive,new/obj/Keep_Body,new/obj/Heal,new/obj/Bind,new/obj/Telepathy)
			src.Sense_Alignment = 1
		else
			src << "Your rank was removed."
			var/list/Skills = list(/obj/Kaio_Revive,/obj/Keep_Body,/obj/Heal,/obj/Bind,/obj/Telepathy)
			for(var/obj/O in src)
				if(O.type in Skills) del(O)
	Daimaou(var/R)
		if(R == 0)
			contents.Add(new/obj/Observe_Majinizations,new/obj/Attacks/Blast,new/obj/Attacks/Charge,new/obj/Attacks/Explosion,\
			new/obj/Attacks/Beam,new/obj/Attacks/Spin_Blast,new/obj/Attacks/Sokidan,new/obj/Attacks/Piercer,\
			new/obj/Self_Destruct,new/obj/Attacks/Genocide,new/obj/Fly,new/obj/Shield,new/obj/Expand,\
			new/obj/Focus,new/obj/SplitForm,new/obj/Majinize,new/obj/MakeAmulet,new/obj/Keep_Body,\
			new/obj/Reincarnate,new/obj/Restore_Youth,new/obj/Materialization,new/obj/Bind,new/obj/Make_Fruit,\
			new/obj/Kaio_Revive,new/obj/Attacks/Kienzan,new/obj/Telepathy/,new/obj/Majin,new/obj/Dark_Blessing/*,new/obj/Imitation*/)
			Base*=10
			Base+= 10000
			Alter_Age(1500)
			contents+=new/obj/RankChat
			src.Sense_Alignment = 1
		else
			src << "Your rank was removed."
			var/list/Skills = list(/obj/Observe_Majinizations,/obj/Attacks/Blast,/obj/Attacks/Charge,/obj/Attacks/Explosion,\
			/obj/Attacks/Beam,/obj/Attacks/Spin_Blast,/obj/Attacks/Sokidan,/obj/Attacks/Piercer,\
			/obj/Self_Destruct,/obj/Attacks/Genocide,/obj/Fly,/obj/Shield,/obj/Expand,\
			/obj/Focus,/obj/SplitForm,/obj/Majinize,/obj/MakeAmulet,/obj/Keep_Body,\
			/obj/Reincarnate,/obj/Restore_Youth,/obj/Materialization,/obj/Bind,/obj/Make_Fruit,\
			/obj/Kaio_Revive,/obj/Attacks/Kienzan,/obj/Telepathy/,/obj/Majin,/obj/Dark_Blessing)
			for(var/obj/O in src)
				if(O.type in Skills) del(O)
	Demon_Master(var/R)
		if(R == 0)
			contents.Add(new/obj/Attacks/Blast,new/obj/Attacks/Charge,new/obj/Attacks/Explosion,\
			new/obj/Attacks/Spin_Blast,new/obj/Attacks/Beam,new/obj/Attacks/Sokidan,new/obj/Attacks/Piercer,\
			new/obj/Self_Destruct,new/obj/Attacks/Genocide,new/obj/Fly,new/obj/Expand,new/obj/SplitForm,\
			new/obj/Keep_Body,new/obj/Materialization/*,new/obj/Imitation*/,new/obj/Majin,new/obj/Restore_Youth)
			Alter_Age(30)
		else
			src << "Your rank was removed."
			var/list/Skills = list(/obj/Attacks/Blast,/obj/Attacks/Charge,/obj/Attacks/Explosion,\
			/obj/Attacks/Spin_Blast,/obj/Attacks/Beam,/obj/Attacks/Sokidan,/obj/Attacks/Piercer,\
			/obj/Self_Destruct,/obj/Attacks/Genocide,/obj/Fly,/obj/Expand,/obj/SplitForm,\
			/obj/Keep_Body,/obj/Materialization/*,new/obj/Imitation*/,/obj/Majin,/obj/Restore_Youth)
			for(var/obj/O in src)
				if(O.type in Skills) del(O)
mob/proc/Alter_Age(A)
	Age+=A
	Real_Age+=A
	Decline+=A
	BirthYear-=A
var/SuggestedRanks={"<html>
<head><body>
<body bgcolor="#000000"><font size=2><font color="#CCCCCC">

All ranks are RP characters. Meaning you do not teach your skills to people OOCly. The rarer the
skill, the more selective you should be about who you teach, and only give it to those who deserve
it or it is actually critical to the success of people that are the same alignment as you. If someone
learns it just because your training it or using it or whatever, then so be it I guess.<br><br>

None of these ranks should be given to a person who does not deserve them or will abuse them. No
matter how desperately they need filled. Just dont have your standards silly-high either.
Also, ranks of the same alignment should associate with each other to form a coherent "government"
of sorts, to keep order among the players beneath them. Like the Kaioshins, the Cardinal Kaios, and
the Guardian of Earth, should all associate because they all have the same goal, protecting good in
the universe. Make sure they know that they aren't just getting a rank for abilities, the rank is NOT
for them its for everyone, and if they don't live up to the ranked people in the series in ALL ways
they should be stripped for being too lazy and selfish because obviously they only wanted the rank
all for themselves so they could just have abilities. Ranked people are supposed to affect all those
beneath them in significant ways.
<br><br>

Abilities such as Keep Body, Bind, Make Dragon Balls, Unlock Potential, Mystify, Majinize,
Restore Youth, Revive, Reincarnate, Make Fruit, Teleport, and Make Amulet, and whatever rank-only
abilities that are added in the future, ARE teachable, manually, by the person who possesses them.
BUT, they are the rarest of rare abilities, even more so than Kaioken or Shunkan Ido, they should
only be given to someone who will become the successor of that ranked person, in the case that they
die, or remake, or whatever. The ranked person may only have ONE successor. If an admin determines
later that the successor is not worthy of the rank they will inherit, well, strip em.<br><br>

*Earth*<br>
Guardian (The purpose they MUST fullfill is to protect earth from evil forces that actually threaten
Earth itself or a large amount of its people. If they or any of the other ranks do NOT fulfill their
purpose when its called for, they should be removed.)<br>
Teleport them to the lookout, give them Blast, Charge, Beam, Fly, Power Control, Heal,
Materialization, Shield,
Give Power, Keep Body, Bind (Optional). If Namekian, give them Make
Dragon Balls and Namekian Fusion. Add 20 years to age and decline.
<br><br>

Korin (Has no static purpose)<br>
Take them to the lookout. Give them a Senzu Bean to start a garden with. Give them Fly, Heal,
Give Power, Zanzoken, Power Control. Add 20 years to age and decline.<br><br>

Turtle Hermit (Has no static purpose)<br>
Give them Charge, Beam, Kamehameha, Zanzoken, Fly, Expand, Focus, Heal, Give Power. Add 20 years
to age and decline.
<br><br>

Crane Hermit (Has no static purpose)<br>
Give them Blast, Beam, Dodompa, Taiyoken, Split Form, Self Destruct, Kikoho, Fly. Add 20 years to
age and decline.<br><br>

Teacher (1 to 3 of them. Teachers must NEVER have less than 1 student. Suggested to open schools.
They can still be selective about who they teach if they don't want to teach just any nub. "Skill
Masters" however, are not obligated to teach anyone, they can do whatever they want.)<br>
Blast, Charge, Beam, Fly, Guide Bomb, Heal, Shield<br><br>

<br><br>
*Namek*<br>
Elder (Same purpose as the Guardian of Earth)<br>
Charge, Fly, Heal, Power Control, Focus, Materialization, Unlock Potential, Make Dragon Balls,
Namekian Fusion, Give Power, Shield<br><br>

Teacher (1 to 3 of them)<br>
Blast, Charge, Masenko, Piercer, Guide Bomb, Homing Finisher, Makosen, Expand, Focus, Fly, Zanzoken,
Power Control, Split Form, Heal, Materialization, Shield, Give Power, and Namekian Fusion.<br><br>

<br><br>
*Vegeta*<br>
King/Queen (Purpose is to rule Vegeta in a way beneficial to the Saiyan people, and actually have
most Saiyans KNOW that they actually are
the ruler(s). They should attempt to control all of the resources of the planet, even if it means
outlawing and destroying other drills. They will then use the resources to "civilize" the Saiyan
people with equipment, and whatever else. They can be selective about which Saiyans they outfit with
supplies, such as only outfitting those who join in military service. This is just a suggested
purpose, you can also be an evil douchebag if you really want to, but the other Saiyans will probably
kill you for it eventually.<br>
Charge, Explosion, Beam, Galic Gun, Final Flash, Power Ball, Fly. Add 10 years to age and decline.<br><br>

Teacher (1 to 3 of them)<br>
Blast, Charge, Beam, Explosion, Self Destruct, Fly, Expand<br><br>

<br><br>
*Arconia*<br>
Yardrat Master (No static purpose)<br>
Shunkan Ido, Fly, Zanzoken, Blast, Charge, Guide Bomb, Heal, Shield, Limit Breaker<br><br>

Teachers & Skill Masters (1-3 each)
Blast, Charge, Beam, Spin Blast, Explosion, Guide Bomb, Fly, Power Control, Expand, Split Form<br><br>

<br><br>
*Ice Planet*<br>
Skill Master (at least 2 of them)<br>
Blast, Charge, Explosion, Beam, Ray, Guide Bomb, Death Ball, Fly, Power Control, Expand,
Shield<br><br>

<br><br>
*Heaven / Checkpoint*<br>
Kaioshin (1-4 Kaioshins but definitely no more than 4, purpose is to keep Afterlife peaceful and
actively and noticeably police Demons, making sure they don't bring evil to the Afterlife)<br>
Blast, Charge, Beam, Guide Bomb, Homing Finisher, Heal, Shield, Give Power, Fly, Power Control, Focus,
Materialization, Mystify, Unlock Potential, Keep Body, Restore Youth, Revive, Reincarnate, Bind, Make
Fruit, Teleport. Raise their base to 10x what a Kaio starts with.<br><br>

North Kaio (No static purpose)<br>
Charge, Guide Bomb, Fly, Heal, Give Power, Power Control, Focus, Keep Body, Revive,
Materialization, Bind, Kaioken, Genki Dama.<br><br>

South, East, West Kaios (Teachers)<br>
Blast, Charge, Beam, Guide Bomb, Fly, Heal, Shield, Give Power, Power Control, Focus, Materialization.
Also give them Keep Body, Revive, Limit Breaker, and Bind if they deserve it.<br><br>

Kaio Helper (As many as are worthy and needed)<br>
Revive, Keep Body, Heal, Bind. The point of this rank is to help roleplayers with unRP kills and
such. If someone is killed by a OOC Noob, revive them or at least allow them to keep their body
so they can use their full power to protect themselves against noobs. If you are this rank do not
EVER use your powers to revive a noob or anyone who OOC kills/steals/attacks. If the person is not
a great roleplayer, but not a noob either, do not revive them, just use keep body on them to allow
them to use their full power so dead noobs aren't a threat to them. If they prove themselves worthy
of a revive later, so be it.<br><br>

<br><br>
*Hell*<br>
Daimou(s) (1-2) (Purpose exists to be evil and provide ACTIVE and NOTICEABLE opposition to the Kaios)
<br>
Blast, Charge, Explosion, Beam, Spin Blast, Guide Bomb, Piercer, Self Destruct, Genocide, Fly, Shield,
Expand, Focus,
Split Form, Majinize, Make Amulet, Keep Body, Reincarnate, Restore Youth, Materialization, Bind, Make
Fruit, Revive, Imitation, Dark Blessing. Raise them to 10x the base that their race starts with.<br><br>

Demon Skill Masters (1-3 of them)<br>
Blast, Charge, Explosion, Spin Blast, Beam, Guide Bomb, Piercer, Self Destruct, Genocide, Fly, Expand,
Split Form,
Keep Body, Materialization, Imitation. Also give them Amulets or Make Amulet if they deserve either, and also
give them Majinize, Reincarnate, and Restore Youth if they really deserve it.<br><br>

<br><br>
Give all ranks except Skill Masters, Teachers, and King of Vegeta, the RankChat object. So they can
OOCly keep up with rank news and stuff and coordinate their efforts.<br><br>

Make damn sure the ranked person knows they are NOT recieving this rank for themselves. They are
getting it to serve the roleplaying community as a whole. NOT noobs. The roleplaying community.
They are part of the roleplaying community, but they better not forget they are a SMALL part, one
of many. If they want to go hide in a corner somewhere after getting their rank, they need to be
stripped of all their skills. Thats not what being a rank is all about. If you dont want to agree
to this, DONT ACCEPT A DAMN RANK. Because there are a lot of people who do this. Going afk and/or
having personal time is one thing, but doing whats mentioned above is another.

</body><html>"}
mob/verb/SuggestedRanks()
	set category="Other"
	usr<<browse(SuggestedRanks,"window= ;size=700x600")
var/Notes={"<html>
<head><title>Notes</title><body>
<center><body bgcolor="#000000"><font size=2><font color="#CCCCCC">



</body><html>"}