_objectobj/Weather_Debug
	verb/Weather_Test()
		set category="Skills"
		set name= "Test Weather"
	//	Weather()



obj/Wings
	verb
		Toggle_Wings()
			set category="Other"
			set name = "Toggle Wings"
			if(usr.Wings == 0)
				usr.Wings = 1
				usr.AngelWings()
				return
			else
				usr.overlays = null
				usr.Wings = 0
obj/Conjure
	verb/DeConjure()
		set category="Skills"
		set name = "Deconjure"
		desc="This will unsummon a demon you have summoned."
		var/list/Demons=new/list
		for(var/mob/Demon in Players)
			if(Demon.client)
				if(Demon.ConjuredKey==usr.key)
					Demons.Add(Demon)
		var/mob/Choice=input("Send back which Demon?") in Demons
		if(Choice)
			if (Choice.ConjuredKey!=usr.lastKnownKey)
				src<<"This character has not been summoned by you!"
				return
			Choice<<"[usr] has sent you back from whence you came."
			log_ability("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has deconjured [key_name(Choice)]")
			usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has deconjured [key_name(Choice)].\n")
			Choice.saveToLog("| [Choice.client.address ? (Choice.client.address) : "IP not found"] | ([Choice.x], [Choice.y], [Choice.z]) | [key_name(Choice)] has been deconjured by [key_name(usr)]. \n")
			var/image/I=image(icon='Black Hole.dmi',icon_state="full")
			flick(I,Choice)
			Choice.loc=locate(Choice.ConjureX,Choice.ConjureY,Choice.ConjureZ)
			flick(I,Choice)
			//usr.MaxKi/=0.75
			Choice.Conjured=0
			Choice.ConjuredKey=null
	verb/Conjure()
		set category="Skills"
		set name = "Conjure"
		desc="This will conjure a demon from Hell to serve you.  Make sure your contract is specific enough to control it.  \
		Summoning a demon removes part of your ki until it is desummoned."
		var/list/Demons=new/list
		for(var/mob/player/Demon in Players)
			if(Demon.client)
				if(Demon.Race=="Demon")
					Demons.Add(Demon)
		var/mob/Choice=input("Conjure which Demon?") in Demons
		if(Choice)
			if (Choice.MaxKi>=usr.MaxKi)
				usr<<"[Choice] is far beyond your ability to summon!"
				return
			if (Choice.Conjured==1)
				usr<<"[Choice] has already been conjured!"
				return
			else
				var/Reason=input("Input the contract you want the Demon to sign and abide by, allowing them to decide wether to agree or not.") as message
				spawn switch(input(Choice,"[usr] wishes to conjure you from the underworld to \his location. Their contract is as follows:\n [Reason]", "Summon request", text) in list ("No", "Yes",))
					if("Yes")
						var/Price
						do
							Price=input(Choice,"What will be your price? (in Energy) | Their max is [usr.MaxKi], it cannot be above this.","Price", 1000) as num
						while(!Price || Price > usr.MaxKi)
						if(usr)
							switch(alert("[Choice] has agreed to be conjured. Their price is [Price]. This is permanent. Do you accept?",,"Yes","No"))
								if("Yes")
								//usr<<"[Choice] has agreed to be conjured to you."
									log_ability("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has conjured [key_name(Choice)] to do \his bidding! Price: [Price]\nContract: [Reason]")
									usr.MaxKi -= Price
									usr.Ki = usr.Ki - Price <= 0 ? 0 : usr.Ki - Price
									usr.Health*=0.5
									Choice.MaxKi += Price
									Choice.Ki = Choice.MaxKi
									oview(usr)<<"[usr] conjures the demon [Choice] to do \his bidding!"
									for(var/mob/player/M in view(usr)) if(M.client) M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] conjures [Choice] to do \his bidding. \n")
									usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] Conjured [Choice]. <b>Price:</b> [Price]<br><b>Contract:</b> [Reason]\n")
									Choice.ConjureX=Choice.x
									Choice.ConjureY=Choice.y
									Choice.ConjureZ=Choice.z
									var/image/I=image(icon='Black Hole.dmi',icon_state="full")
									flick(I,Choice)
									Choice.loc=locate(usr.x,usr.y-1,usr.z)
									flick(I,Choice)
									spawn(1) step(Choice,SOUTH)
									Choice.Conjured=1
									Choice.ConjuredKey=usr.lastKnownKey
								if("No")
									Choice << "[usr] did not agree with your price."
					else if(usr)
						usr<<"[Choice] has denied the conjurer."

obj/Blessing


obj/Dark_Power_Blessing
	var/Used
	verb/Dark_Power_Blessing(mob/player/M in view(1))
		set category="Other"
		set src = usr.contents
		if(locate(/obj/Majin) in M)
			src<<"They already have it"
			return
		for(var/obj/Mystic/A in M)
			del(A)
		M.contents += new /obj/Majin_Temp
		log_ability("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] Majinized (Dark Blessing) [key_name(M)]")
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(A,10000)
/*mob/var/tmp
	blasting=0
	charging=0
	firable=0
mob/var
	CBLASTICON='1.dmi'
	kimanip=1 //governs all ki attacks.
	kimanipmod=1
	hasblast1
	hasblast2
	hasblast3
	hasblast4
	hasblast5
	hasblast6
	hasblast7
	hasblast8
	hasblast9
	hasblast10
	hasblast11
	kinxt=10
	kinxtadd=1
mob/proc/Learn_3 //Lets a player learn a new energy attack randomly per level
	//10% chance per level to learn a new one
	if (usr.kimanip==100)
		var/chance=rand(1,10) //Last time I tested this I got all attacks by the time the total level
	//was 140 across all attacks.
		if(chance==10)
			var/whichone=rand(1,13)
			if(whichone==1&&!usr.hasblast1)
				usr.hasblast1=1
				usr<<"Through training, you have learned a new ability."
				usr.contents+=new/obj/Attacks/Blast
			else if(whichone==2)  //&&!usr.hasblast
				if(usr.Race=="Jinzouningen"|usr.Race=="Ancient Namekian"|usr.Race=="Kanassa-Jin"|usr.Race=="Human"|usr.Class=="Earth-Halfie"|usr.Race=="Changeling"|usr.Race=="Alien"|usr.Race=="Cyborg"|usr.Class=="Legendary"|usr.Race=="Bio-Android")
					if(usr.Class!="Bebi")
						usr.hasblast2=1
						usr<<"You have learned a new attack."
						usr.contents+=new/obj/Shield
			else if(whichone==3&&!usr.hasblast3)
				usr.hasblast3=1
				usr<<"Through training, you have learned a new ability."
				usr.contents+=new/obj/Attacks/Shockwave
			else if(whichone==4&&!usr.hasblast4) //Legendaries shouldnt be able to learn sokidan.
				usr.hasblast4=1
				usr<<"Through training, you have learned a new ability."
				usr.contents+=new/obj/Attacks/Sokidan
			else if(whichone==5&&!usr.hasblast5)
				if(usr.Race=="Jinzouningen"|usr.Race=="Bebi"|usr.Race=="Human"|usr.Race=="Namekian"|usr.Race=="Alien"|usr.Race=="Changeling"|usr.Race=="Majin"|usr.Race=="Bio-Android"|usr.Race=="Demon"|usr.Race=="Android")
					usr.hasblast5=1
				usr<<"Through training, you have learned a new ability."
				usr.contents+=new/obj/Attacks/Piercer
			else if(whichone==6&&!usr.hasblast6)
				usr.hasblast6=1
				usr<<"Through training, you have learned a new ability."
				usr.contents+=new/obj/Give_Power
	/*	else if(whichone==7&&!usr.hasblast7)
			usr.hasblast7=1
			usr<<"You have learned a new attack."
			usr.contents+=new/obj/KiAttacks/SpinBlast*/
			else if(whichone==8&&!usr.hasblast8)
				if(usr.Race=="Ancient Namekian"|usr.Race=="Kanassa-Jin"|usr.Race=="Bebi"|usr.Race=="Human"|usr.Race=="Namekian"|usr.Race=="Yardrat"|usr.Race=="Alien"|usr.Race=="Changeling"|usr.Race=="Kaio"|usr.Race=="Majin"|usr.Race=="Bio-Android")
					usr.hasblast8=1
				usr<<"Through training, you have learned a new ability."
				usr.contents+=new/obj/Zanzoken
			else if(whichone==9&&!usr.hasblast9) //Legendary cannot learn Explosion
				usr.hasblast9=1
				usr<<"Through training, you have learned a new ability."
				usr.contents+=new/obj/Attacks/Explosion	//if(!usr.legendary)
	/*	else if(whichone==11&&!usr.hasmegaburst)
			if(Race=="Ancient Namekian"|Race=="Kanassa-Jin"|Race=="Human"|Race=="Namekian"|Race=="Alien"|Race=="Majin"|Race=="Makyojin")
				if(Class!="Bebi")
					hasmegaburst=1
					contents+=new/obj/KiAttacks/MegaBurst
					usr<<"You have learned a new attack."*/
			else if(whichone==12)  //&&!usr.hashomingfinisher)
				if(Race=="Kanassa-Jin"|Race=="Human"|Race=="Namekian"|Race=="Alien")
					if(Class!="Bebi")
						contents+=new/obj/Attacks/Homing_Finisher
						usr<<"You have learned a new attack."*/



/*var/chance=rand(1,10) //Last time I tested this I got all attacks by the time the total level
	//was 140 across all attacks.
	if(chance==10)
		var/whichone=rand(1,13)
		if(whichone==1&&!usr.hasblast1)
			usr.hasblast1=1
			usr<<"Through training, you have learned a new ability."
			usr.contents+=new/obj/Attacks/Blast
		else if(whichone==2)  //&&!usr.hasblast
			if(usr.Race=="Jinzouningen"|usr.Race=="Ancient Namekian"|usr.Race=="Kanassa-Jin"|usr.Race=="Human"|usr.Class=="Earth-Halfie"|usr.Race=="Changeling"|usr.Race=="Alien"|usr.Race=="Cyborg"|usr.Class=="Legendary"|usr.Race=="Bio-Android")
				if(usr.Class!="Bebi")
					usr.hasblast2=1
					usr<<"You have learned a new attack."
					usr.contents+=new/obj/Shield
		else if(whichone==3&&!usr.hasblast3)
			usr.hasblast3=1
			usr<<"Through training, you have learned a new ability."
			usr.contents+=new/obj/Attacks/Shockwave
		else if(whichone==4&&!usr.hasblast4) //Legendaries shouldnt be able to learn sokidan.
			usr.hasblast4=1
			usr<<"Through training, you have learned a new ability."
			usr.contents+=new/obj/Attacks/Sokidan
		else if(whichone==5&&!usr.hasblast5)
			if(usr.Race=="Jinzouningen"|usr.Race=="Bebi"|usr.Race=="Human"|usr.Race=="Namekian"|usr.Race=="Alien"|usr.Race=="Changeling"|usr.Race=="Majin"|usr.Race=="Bio-Android"|usr.Race=="Demon"|usr.Race=="Android")
				usr.hasblast5=1
			usr<<"Through training, you have learned a new ability."
			usr.contents+=new/obj/Attacks/Piercer
		else if(whichone==6&&!usr.hasblast6)
			usr.hasblast6=1
			usr<<"Through training, you have learned a new ability."
			usr.contents+=new/obj/Give_Power
	/*	else if(whichone==7&&!usr.hasblast7)
			usr.hasblast7=1
			usr<<"You have learned a new attack."
			usr.contents+=new/obj/KiAttacks/SpinBlast*/
		else if(whichone==8&&!usr.hasblast8)
			if(usr.Race=="Ancient Namekian"|usr.Race=="Kanassa-Jin"|usr.Race=="Bebi"|usr.Race=="Human"|usr.Race=="Namekian"|usr.Race=="Yardrat"|usr.Race=="Alien"|usr.Race=="Changeling"|usr.Race=="Kaio"|usr.Race=="Majin"|usr.Race=="Bio-Android")
				usr.hasblast8=1
			usr<<"Through training, you have learned a new ability."
			usr.contents+=new/obj/Zanzoken
		else if(whichone==9&&!usr.hasblast9) //Legendary cannot learn Explosion
			usr.hasblast9=1
			usr<<"Through training, you have learned a new ability."
			usr.contents+=new/obj/Attacks/Explosion	//if(!usr.legendary)
	/*	else if(whichone==11&&!usr.hasmegaburst)
			if(Race=="Ancient Namekian"|Race=="Kanassa-Jin"|Race=="Human"|Race=="Namekian"|Race=="Alien"|Race=="Majin"|Race=="Makyojin")
				if(Class!="Bebi")
					hasmegaburst=1
					contents+=new/obj/KiAttacks/MegaBurst
					usr<<"You have learned a new attack."*/
		else if(whichone==12)  //&&!usr.hashomingfinisher)
			if(Race=="Kanassa-Jin"|Race=="Human"|Race=="Namekian"|Race=="Alien")
				if(Class!="Bebi")
					contents+=new/obj/Attacks/Homing_Finisher
					usr<<"You have learned a new attack."*/

obj/Give_Power
	Difficulty=5
	desc="You can transfer your health and energy to someone right beside you by clicking them. It will \
	knock your character out. The person can exceed 100% power if you have enough health and energy \
	to give to them. The effect is only temporary, because health and energy do not stay above 100% \
	for long."
	verb/Give_Power()
		set category="Skills"
		if(usr.icon_state=="KO") return
		for(var/mob/A in get_step(usr,usr.dir)) if(A.client)
			Learnable=1
			spawn(100) if(src) Learnable=0
			if(A.Senzu==0)
				A.Senzu+=2
			A.Health+=usr.Health
			A.Ki+=usr.Ki
			usr.KO("giving power to [A]")
			A.Power_Giving_Reset()
			log_ability("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] gives [key_name(A)] their power")


obj/Zanzoken
	desc="Teleport allows you to instantly move to another location within a short range. \
	To use it, simply click the spot you want to go to, within sight, and your character will teleport there."
	Difficulty=1
obj/Telekinesis
	verb/Toggle_Telekinesis()
		set category="Other"
		if(usr.TK)
			usr.TK = 0
			usr << "Telekinesis toggled off."
			return
		else
			usr.TK = 1
			usr << "Telekinesis toggled on."
			return
obj/Telekinesis_Magic
	verb/Toggle_Magical_Telekinesis()
		set category="Other"
		if(usr.TK_Magic)
			usr.TK_Magic = 0
			usr << "Magical telekinesis toggled off."
			return
		else
			usr.TK_Magic = 1
			usr << "Magical telekinesis toggled on."
			return
obj/Keep_Body
	desc="Using this on someone will allow them to use 50% of their power while dead."
	verb/Keep_Body()
		set category="Other"
		for(var/mob/M in get_step(usr,usr.dir))
			switch(input("Allow [M] to keep their body?") in list("Yes","No"))
				if("Yes")
					M.KeepsBody=1
					if(M.last_icon)
						M.icon = M.last_icon
					log_ability("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has allowed [key_name(M)] to keep their body.")
					alertAdmins("[key_name(usr)] has allowed [key_name(M)] to keep their body")
					usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has allowed [key_name(M)] to keep their body.\n")
				if("No")
					M.KeepsBody=0
					log_ability("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has prevented [key_name(M)] from keeping their body")
					alertAdmins("[key_name(usr)] has prevented [key_name(M)] from keeping their body")
			break
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(A,10000)

obj/Basic_texthandling
obj/Shield
	desc="This ability will take 20% of the energy you use for recovering and convert it into a shield which increases your resistance by 20% while active."
	Difficulty=10
	Using = 0
	verb/Shield()
		set category="Skills"
		if(src.Using == 0)
			src.Using=1
			usr.Res*=1.2
			usr.ResMod*=1.2
			usr.Recovery/=1.2
			usr.overlays-='Shield Blue.dmi'
			usr.overlays-='Shield, Legendary.dmi'
			if(usr.Class=="Legendary") usr.overlays+='Shield, Legendary.dmi'
			else usr.overlays+='Shield Blue.dmi'
			return
		else
			usr.overlays-='Shield Blue.dmi'
			usr.overlays-='Shield, Legendary.dmi'
			usr.Res/=1.2
			usr.ResMod/=1.2
			usr.Recovery*=1.2
			//usr.Recovery = round(usr.Recovery,0.01)
			src.Using=0
			return
obj/Make_Fruit
	desc="With this you can make fruits that will increase the power and energy of those who eat them, \
	along with a temporary boost to regeneration and recovery. The more of them you eat however, the \
	less of an effect they will have each time."
	var/tmp/Making
	verb/Fruit()
		set category="Skills"
		if(Making)
			usr<<"You are already making one"
			return
		Making=1
		view(usr)<<"[usr] begins planting something"
		sleep(600)
		view(usr)<<"A strange fruit appears in front of [usr]"
		Making=0
		usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] makes a Fruit.\n")
		var/obj/items/Fruit/A=new(get_step(usr,usr.dir))
		A.name="[usr] Fruit"
		A.EXP = usr.Experience
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(A,10000)
/*obj/Invade_Body
	verb/Invade_Body()
		set category="Skills"
		if(usr.icon_state=="KO")
			MobChange(mob/M in world)
			(usr.==mob/var in world)
				mob/var
					Race
					Class
					BP_Multiplier=1
					BP=1
					Base=1
					Body=1
					Ki=1
					MaxKi=1
					Pow=1
					Str=1
					Spd=1
					End=1
					Res=1
					Off=1
					Def=1
					GravMastered=1
					Anger=100
					MaxAnger=120
					BPMod=1
					KiMod=1
					PowMod=1
					StrMod=1
					SpdMod=1
					EndMod=1
					ResMod=1
					OffMod=1
					DefMod=1
					Regeneration=1
					Recovery=1
					GravMod=1
					Zenkai=1
					MedMod=1
					Age=0
					Real_Age=0
					Immortal=0
					InclineAge=20
					InclineSpeed=1
					Decline=50
					Tech=1
					hair
					ssjhair
					ssjfphair
					ussjhair
					ssj2hair
					ssj3hair
					HairColor
					BPpcnt=100
					displaykey
					gain=0
					attackable=1
					Admin
					Money=0
					Bank=0
					Lungs=0
					Logins=1
					MakyoPower=0
					Artificial_Power=0
					FormPower=0
					SSjPower=0
					Zombie_Power=0
					Overdrive_Power=0
					Sense_Mod=1
			M.Save()
			M.KEY=key
			M.key=key*/
obj/Power_Ball
	Difficulty=10000000000000
	desc="This extremely rare skill lets you create an artificial moon in the palm of your hand.  Using it\
	will cause all nearby Saiyans to go into Oozaru at the cost of all of your Ki.  Unlike most skills\
	this skill works off of your Ki percentage.  Without at least one hundred percent Ki, it will not work."
	verb/Power_Ball()
		set category="Skills"
		if(usr.icon_state=="KO") return
		if(usr.Ki<=100) return
		else
			var/obj/items/Moon/M = new
			M.loc=locate(usr.x,usr.y+1,usr.z)
			M.icon_state="On"
			spawn(100)
				if(M) del(M)
			for(var/mob/A in view(12,usr))
				if(A.Moon_Used)
					A << "The effect of the moons rays don't seem to do anything for you at the moment, you must wait for [A.Moon_Used] months!"
				else
					A.Oozaru()
			usr.Moon_Used = 3
			usr.Ki/=1.5
mob/proc/Injury_Healing()
	while(src)
		if(src.HasCreated)
			//Blindness
			if(src.Blindness)
				src.client.screen -= src.Blindness
				var/obj/O = src.Blindness
				O.screen_loc = "1,1 to [src.x_view],[src.y_view]"
				src.Blindness = O
				src.client.screen += src.Blindness
			//RP Points
			if(src.afk) if(src.RP_Earned < -1)
				src.RP_Rested += 0.002
			if(src.RP_Earned < -1) if(!src.afk)
				var/Rested = 0
				if(src.RP_Rested > 1)
					Rested = src.RP_Rested/10000
					src.RP_Rested -= Rested
				src.RP_Points += 0.0005 + Rested
				src.RP_Earned += 0.0005 + Rested
				src.RP_Total += 0.0005 + Rested
			//Healing
			var/Healing = 0.01
			if(src.icon_state == "Meditate")
				Healing += 0.01
			Healing += src.Regeneration / 100
			for(var/obj/items/Bandages/B in src)
				if(B.suffix)
					Healing += 0.01
					break
			for(var/obj/items/Regenerator/R in range(0,src))
				Healing += R.Tech / 2500
				break
			if(src.Regenerate)
				Healing += 0.03
			if(src.Senzu)
				Healing = Healing*2
			if(src.icon_state == "Train")
				Healing = 0.00001
			var/L = list("All")
			src.Injure_Heal(Healing,L)
		sleep(50)
mob
	proc
		Injure_Hurt(var/Percent,var/list/Limbs,var/mob/M)
			if(src.Limb_Res)
				var/RES = abs(src.Limb_Res)
				var/N = RES / 100 + 1
				if(src.Limb_Res > 0)
					Percent /= N
				else
					Percent *= N
				if(src.Limb_Res == 100)
					return
				if(Percent < 0)
					return
			if(src.client)
				if(src.KeepsBody == 0) if(src.Dead)
					return
				var/list/Areas = list("Head","Left Arm","Right Arm","Right Leg","Left Leg","Torso")
				if(src.Injury_Head == 100)
					Areas -= "Head"
				if(src.Injury_Torso == 100)
					Areas -= "Torso"
				if(src.Injury_Left_Arm == 100)
					Areas -= "Left Arm"
				if(src.Injury_Right_Arm == 100)
					Areas -= "Right Arm"
				if(src.Injury_Left_Leg == 100)
					Areas -= "Left Leg"
				if(src.Injury_Right_Leg == 100)
					Areas -= "Right Leg"
				if(Limbs.Find("All"))
					Areas += "Throat"
					Areas += "Hearing"
					Areas += "Mating Ability"
					Areas += "Sight"
					Limbs = Areas
				if(Limbs.Find("Random"))
					if(Areas.len)
						var/L = pick(Areas)
						Limbs.Add(L)
				if(Limbs == null)
					if(Areas.len)
						Limbs += pick(Areas)
				if(Limbs.Find("Tail"))
					if(src.Injury_Tail != 100)
						src.Injury_Tail += Percent
						if(src.Injury_Tail >= 100)
							src.Injury_Tail = 100
							if(src.Critical_Tail== 0)
								src.Critical_Tail = 1
								src.Tail = 0
								src.Tail_Remove()
								src << "Your tail has been removed!"
								if(M)
									view(6,src) << "<font color = red>[M] has removed [src]'s tail!"
								else
									view(6,src) << "<font color = red>[src]'s tail has been removed!"
								src.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(src)] Tail has been removed.\n")
				if(Limbs.Find("Sight"))
					if(src.Injury_Sight != 100)
						src.Injury_Sight += Percent
						if(src.Injury_Sight >= 100)
							src.Injury_Sight = 100
							if(src.Critical_Sight == 0)
								src.Critical_Sight = 1
								var/obj/Blindness/B = new
								B.screen_loc = "1,1 to 15,15"
								src.Blindness = B
								src << "Your ability to see has been damaged."
								if(M)
									view(6,src) << "<font color = red>[M] has severely damaged [src]'s ability to see!"
								else
									view(6,src) << "<font color = red>[src]'s ability to see has been severely damaged!"
								//src.sight = 1
								src.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(src)] Sight has been damaged.\n")
				if(Limbs.Find("Mating Ability"))
					if(src.Injury_Mate != 100)
						src.Injury_Mate += Percent
						if(src.Injury_Mate >= 100)
							src.Injury_Mate = 100
							if(src.Critical_Mate == 0)
								src.Critical_Mate = 1
								src << "Your ability to reproduce has been damaged."
								if(M)
									view(6,src) << "<font color = red>[M] has severely damaged [src]'s ability to reproduce!"
								else
									view(6,src) << "<font color = red>[src]'s ability to reproduce has been severely damaged!"
								src.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(src)] Mating has been damaged.\n")
				if(Limbs.Find("Throat"))
					if(src.Injury_Throat != 100)
						src.Injury_Throat += Percent
						if(src.Injury_Throat >= 100)
							src.Injury_Throat = 100
							if(src.Critical_Throat == 0)
								src.Critical_Throat = 1
								src << "Your ability to speak has been severely damaged."
								if(M)
									view(6,src) << "<font color = red>[M] has severely damaged [src]'s ability to speak!"
								else
									view(6,src) << "<font color = red>[src]'s ability to speak has been severely damaged!"
								src.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(src)] Throat has been damaged.\n")
				if(Limbs.Find("Hearing"))
					if(src.Injury_Hearing != 100)
						src.Injury_Hearing += Percent
						if(src.Injury_Hearing >= 100)
							src.Injury_Hearing = 100
							if(src.Critical_Hearing == 0)
								src.Critical_Hearing = 1
								src << "Your ability to hear has been severely damaged."
								if(M)
									view(6,src) << "<font color = red>[M] has severely damaged [src]'s ability to hear!"
								else
									view(6,src) << "<font color = red>[src]'s ability to hear has been severely damaged!"
								src.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(src)] Hearing has been damaged.\n")
				if(Limbs.Find("Torso"))
					if(src.Injury_Torso != 100)
						src.Injury_Torso += Percent
						if(src.Injury_Torso >= 100)
							src.Injury_Torso = 100
							if(src.Critical_Torso == 0)
								src.Critical_Torso = 1
								src.BP_Multiplier/=1.25
								if(src.Ki >= src.MaxKi/Injury_Max)
									src.Ki = src.MaxKi/Injury_Max
								src.MaxKi /=Injury_Max
								src.KiMod /=Injury_Max
								src << "Your torso has been crushed badly, you feel some of your energy and power slip away..."
								if(M)
									view(6,src) << "<font color = red>[M] has severely crushed [src]'s torso!"
								else
									view(6,src) << "<font color = red>[src]'s torso has been badly crushed!"
								src.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(src)] Torso has been crushed.\n")
				if(Limbs.Find("Head"))
					if(src.Injury_Head != 100)
						src.Injury_Head += Percent
						if(src.Injury_Head >= 100)
							src.Injury_Head = 100
							if(src.Critical_Head == 0)
								src.Critical_Head = 1
								src.Add/=2
								src.Magic_Potential/=2
								src << "Your head has been crushed badly, you have alot of trouble thinking straight..."
								if(M)
									view(6,src) << "<font color = red>[M] has severely crushed [src]'s head!"
								else
									view(6,src) << "<font color = red>[src]'s head has been badly crushed!"
								src.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(src)] Head has been crushed.\n")
				if(Limbs.Find("Left Leg"))
					if(src.Injury_Left_Leg != 100)
						src.Injury_Left_Leg += Percent
						if(src.Injury_Left_Leg >= 100)
							src.Injury_Left_Leg = 100
							if(src.Critical_Left_Leg == 0)
								src.Critical_Left_Leg = 1
								src.StrMod/=Injury_Max
								src.Str/=Injury_Max
								src.PowMod/=Injury_Max
								src.Pow/=Injury_Max
								src.OffMod/=Injury_Max
								src.Off/=Injury_Max
								src.DefMod/=Injury_Max
								src.Def/=Injury_Max
								src.SpdMod/=Injury_Max
								src << "Your left leg has been broken..."
								if(M)
									view(6,src) << "<font color = red>[M] has broken [src]'s left leg!"
								else
									view(6,src) << "<font color = red>[src]'s left leg breaks!"
								src.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(src)] Left Leg has been broken.\n")
				if(Limbs.Find("Right Leg"))
					if(src.Injury_Right_Leg != 100)
						src.Injury_Right_Leg += Percent
						if(src.Injury_Right_Leg >= 100)
							src.Injury_Right_Leg = 100
							if(src.Critical_Right_Leg == 0)
								src.Critical_Right_Leg = 1
								src.StrMod/=Injury_Max
								src.Str/=Injury_Max
								src.PowMod/=Injury_Max
								src.Pow/=Injury_Max
								src.OffMod/=Injury_Max
								src.Off/=Injury_Max
								src.DefMod/=Injury_Max
								src.Def/=Injury_Max
								src.SpdMod/=Injury_Max
								src << "Your right leg has been broken..."
								if(M)
									view(6,src) << "<font color = red>[M] has broken [src]'s right leg!"
								else
									view(6,src) << "<font color = red>[src]'s right leg breaks!"
								src.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(src)] Right Leg has been broken.\n")
				if(Limbs.Find("Right Arm"))
					if(src.Injury_Right_Arm != 100)
						src.Injury_Right_Arm += Percent
						if(src.Injury_Right_Arm >= 100)
							src.Injury_Right_Arm = 100
							if(src.Critical_Right_Arm == 0)
								src.Critical_Right_Arm = 1
								src.StrMod/=Injury_Max
								src.Str/=Injury_Max
								src.PowMod/=Injury_Max
								src.Pow/=Injury_Max
								src.OffMod/=Injury_Max
								src.Off/=Injury_Max
								src.DefMod/=Injury_Max
								src.Def/=Injury_Max
								src.SpdMod/=Injury_Max
								src << "Your right arm has been broken..."
								if(M)
									view(6,src) << "<font color = red>[M] has broken [src]'s right arm!"
								else
									view(6,src) << "<font color = red>[src]'s right arm breaks!"
								src.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(src)] Right Arm has been broken.\n")
				if(Limbs.Find("Left Arm"))
					if(src.Injury_Left_Arm != 100)
						src.Injury_Left_Arm += Percent
						if(src.Injury_Left_Arm >= 100)
							src.Injury_Left_Arm = 100
							if(src.Critical_Left_Arm == 0)
								src.Critical_Left_Arm = 1
								src.StrMod/=Injury_Max
								src.Str/=Injury_Max
								src.PowMod/=Injury_Max
								src.Pow/=Injury_Max
								src.OffMod/=Injury_Max
								src.Off/=Injury_Max
								src.DefMod/=Injury_Max
								src.Def/=Injury_Max
								src.SpdMod/=Injury_Max
								src << "Your left arm has been broken..."
								if(M)
									view(6,src) << "<font color = red>[M] has broken [src]'s left arm!"
								else
									view(6,src) << "<font color = red>[src]'s left arm breaks!"
								src.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(src)] Left Arm has been broken.\n")
		Injure_Heal(var/Percent,var/list/Limbs)
			if(src.client)
				var/list/Areas = list("Head","Left Arm","Right Arm","Right Leg","Left Leg","Torso")
				if(Limbs.Find("All"))
					Areas += "Throat"
					Areas += "Hearing"
					Areas += "Mating Ability"
					Areas += "Sight"
					if(src.Race == "Saiyan")
						Areas += "Tail"
					Limbs = Areas
				if(Limbs.Find("Random"))
					Areas += "Throat"
					Areas += "Hearing"
					Areas += "Mating Ability"
					Areas += "Sight"
					if(src.Race == "Saiyan")
						Areas += "Tail"
				if(src.Race == "Saiyan") if(src.Injury_Tail == 0)
					Areas -= "Tail"
				if(src.Injury_Head == 0)
					Areas -= "Head"
				if(src.Injury_Right_Arm == 0)
					Areas -= "Right Arm"
				if(src.Injury_Left_Arm == 0)
					Areas -= "Left Arm"
				if(src.Injury_Right_Leg == 0)
					Areas -= "Right Leg"
				if(src.Injury_Left_Leg == 0)
					Areas -= "Left Leg"
				if(src.Injury_Torso == 0)
					Areas += "Torso"
				if(src.Injury_Hearing == 0)
					Areas -= "Hearing"
				if(src.Injury_Sight == 0)
					Areas -= "Sight"
				if(src.Injury_Throat == 0)
					Areas -= "Throat"
				if(src.Injury_Mate == 0)
					Areas -= "Mating Ability"
				if(Limbs.Find("Random"))
					if(Areas.len)
						var/L = pick(Areas)
						Limbs.Add(L)
				if(Limbs.Find("Tail"))
					if(src.Injury_Tail > 0)
						src.Base+=1*2*1*BPMod*Zenkai*Regeneration*(1+Senzu)*GG*Gain_Multiplier
					src.Injury_Tail -= Percent
					if(src.Injury_Tail <= 0)
						src.Injury_Tail = 0
						if(src.Critical_Tail)
							src.Critical_Tail = 0
							src.Tail = 1
							src.Tail_Add()
							src << "The injury to your Tail seems to have completely healed now."
							src.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(src)] Tail injury has healed.\n")
				if(Limbs.Find("Sight"))
					if(src.Injury_Sight > 0)
						src.Base+=1*2*1*BPMod*Zenkai*Regeneration*(1+Senzu)*GG*Gain_Multiplier
					src.Injury_Sight -= Percent
					if(src.Injury_Sight <= 0)
						src.Injury_Sight = 0
						if(src.Critical_Sight)
							src.Critical_Sight = 0
							if(src.Blindness)
								src.client.screen -= src.Blindness
								var/obj/B = src.Blindness
								del(B)
							//src.sight = 0
							src << "The injury to your Sight seems to have completely healed now."
							src.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(src)] Sight injury has healed.\n")
				if(Limbs.Find("Mating Ability"))
					if(src.Injury_Mate > 0)
						src.Base+=1*2*1*BPMod*Zenkai*Regeneration*(1+Senzu)*GG*Gain_Multiplier
					src.Injury_Mate -= Percent
					if(src.Injury_Mate <= 0)
						src.Injury_Mate = 0
						if(src.Critical_Mate)
							src.Critical_Mate = 0
							src << "The injury to your ability to mate seems to have completely healed now."
							src.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(src)] Mating ability injury has healed.\n")
				if(Limbs.Find("Throat"))
					if(src.Injury_Throat > 0)
						src.Base+=1*2*1*BPMod*Zenkai*Regeneration*(1+Senzu)*GG*Gain_Multiplier
					src.Injury_Throat -= Percent
					if(src.Injury_Throat <= 0)
						src.Injury_Throat = 0
						if(src.Critical_Throat)
							src.Critical_Throat = 0
							src << "The injury to your Throat seems to have completely healed now."
							src.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(src)] Throat injury has healed.\n")
				if(Limbs.Find("Hearing"))
					if(src.Injury_Hearing > 0)
						src.Base+=1*2*1*BPMod*Zenkai*Regeneration*(1+Senzu)*GG*Gain_Multiplier
					src.Injury_Hearing -= Percent
					if(src.Injury_Hearing <= 0)
						src.Injury_Hearing = 0
						if(src.Critical_Hearing)
							src.Critical_Hearing = 0
							src << "The injury to your Hearing seems to have completely healed now."
							src.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(src)] Hearing injury has healed.\n")
				if(Limbs.Find("Torso"))
					if(src.Injury_Torso > 0)
						src.Base+=1*2*1*BPMod*Zenkai*Regeneration*(1+Senzu)*GG*Gain_Multiplier
					src.Injury_Torso -= Percent
					if(src.Injury_Torso <= 0)
						src.Injury_Torso = 0
						if(src.Critical_Torso)
							src.Critical_Torso = 0
							src.MaxKi *=Injury_Max
							src.KiMod *=Injury_Max
							src.BP_Multiplier*=1.25
							src << "The injury to your Torso seems to have completely healed now."
							src.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(src)] Torso injury has healed.\n")
				if(Limbs.Find("Head"))
					if(src.Injury_Head > 0)
						src.Base+=1*2*1*BPMod*Zenkai*Regeneration*(1+Senzu)*GG*Gain_Multiplier
					src.Injury_Head -= Percent
					if(src.Injury_Head <= 0)
						src.Injury_Head = 0
						if(src.Critical_Head)
							src.Critical_Head = 0
							src.Add*=2
							src.Magic_Potential*=2
							src << "The injury to your Head seems to have completely healed now."
							src.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(src)] Head injury has healed.\n")
				if(Limbs.Find("Left Leg"))
					if(src.Injury_Left_Leg > 0)
						src.Base+=1*2*1*BPMod*Zenkai*Regeneration*(1+Senzu)*GG*Gain_Multiplier
					src.Injury_Left_Leg -= Percent
					if(src.Injury_Left_Leg <= 0)
						src.Injury_Left_Leg = 0
						if(src.Critical_Left_Leg)
							src.Critical_Left_Leg = 0
							src.StrMod*=Injury_Max
							src.Str*=Injury_Max
							src.PowMod*=Injury_Max
							src.Pow*=Injury_Max
							src.OffMod*=Injury_Max
							src.Off*=Injury_Max
							src.DefMod*=Injury_Max
							src.Def*=Injury_Max
							src.SpdMod*=Injury_Max
							src << "The injury to your Left Leg seems to have completely healed now."
							src.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(src)] Left Leg injury has healed.\n")
				if(Limbs.Find("Right Leg"))
					if(src.Injury_Right_Leg > 0)
						src.Base+=1*2*1*BPMod*Zenkai*Regeneration*(1+Senzu)*GG*Gain_Multiplier
					src.Injury_Right_Leg -= Percent
					if(src.Injury_Right_Leg <= 0)
						src.Injury_Right_Leg = 0
						if(src.Critical_Right_Leg)
							src.Critical_Right_Leg = 0
							src.StrMod*=Injury_Max
							src.Str*=Injury_Max
							src.PowMod*=Injury_Max
							src.Pow*=Injury_Max
							src.OffMod*=Injury_Max
							src.Off*=Injury_Max
							src.DefMod*=Injury_Max
							src.Def*=Injury_Max
							src.SpdMod*=Injury_Max
							src << "The injury to your Right Leg seems to have completely healed now."
							src.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(src)] Right Leg injury has healed.\n")
				if(Limbs.Find("Right Arm"))
					if(src.Injury_Right_Arm > 0)
						src.Base+=1*2*1*BPMod*Zenkai*Regeneration*(1+Senzu)*GG*Gain_Multiplier
					src.Injury_Right_Arm -= Percent
					if(src.Injury_Right_Arm <= 0)
						src.Injury_Right_Arm = 0
						if(src.Critical_Right_Arm)
							src.Critical_Right_Arm = 0
							src.StrMod*=Injury_Max
							src.Str*=Injury_Max
							src.PowMod*=Injury_Max
							src.Pow*=Injury_Max
							src.OffMod*=Injury_Max
							src.Off*=Injury_Max
							src.DefMod*=Injury_Max
							src.Def*=Injury_Max
							src.SpdMod*=Injury_Max
							src << "The injury to your Right Arm seems to have completely healed now."
							src.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(src)] Right Arm injury has healed.\n")
				if(Limbs.Find("Left Arm"))
					if(src.Injury_Left_Arm > 0)
						src.Base+=1*2*1*BPMod*Zenkai*Regeneration*(1+Senzu)*GG*Gain_Multiplier
					src.Injury_Left_Arm -= Percent
					if(src.Injury_Left_Arm <= 0)
						src.Injury_Left_Arm = 0
						if(src.Critical_Left_Arm)
							src.Critical_Left_Arm = 0
							src.StrMod*=Injury_Max
							src.Str*=Injury_Max
							src.PowMod*=Injury_Max
							src.Pow*=Injury_Max
							src.OffMod*=Injury_Max
							src.Off*=Injury_Max
							src.DefMod*=Injury_Max
							src.Def*=Injury_Max
							src.SpdMod*=Injury_Max
							src << "The injury to your Left Arm seems to have completely healed now."
							src.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(src)] Left Arm injury has healed.\n")
obj/Injure
	desc="You can use this to injure someone, crippling them. Wounds tend to heal after about a year, but can be fixed instantly using non-magicial, energy based healing.\
	Wounds will also heal slightly faster while inside a regenerator or while wearing bandages."
	verb/Injure_Self()
		set category="Skills"
		if(usr.KeepsBody == 0) if(usr.Dead)
			usr << "They don't have a body and can't be harmed that way."
			return
		var/list/Choices=new
		if(usr.Race == "Saiyan") if(usr.Tail)
			Choices += "Tail"
		if(usr.Critical_Head == 0)
			Choices += "Head"
		if(usr.Critical_Right_Arm == 0)
			Choices += "Right Arm"
		if(usr.Critical_Left_Arm == 0)
			Choices += "Left Arm"
		if(usr.Critical_Right_Leg == 0)
			Choices += "Right Leg"
		if(usr.Critical_Left_Leg == 0)
			Choices += "Left Leg"
		if(usr.Critical_Torso == 0)
			Choices += "Torso"
		if(usr.Critical_Hearing == 0)
			Choices += "Hearing"
		if(usr.Critical_Sight == 0) if(usr.sight != (SEE_MOBS|SEE_OBJS|SEE_TURFS))
			Choices += "Sight"
		if(usr.Critical_Throat == 0)
			Choices += "Throat"
		if(usr.Critical_Mate == 0) if(usr.Race != "Android")
			Choices += "Mating Ability"
		Choices.Add("Cancel")
		var/Result = input("Choose injury to apply") in Choices
		if(Result)
			var/L = list("[Result]")
			usr.Injure_Hurt(100,L,usr)
	verb/Injure()
		set category="Skills"
		for(var/mob/A in get_step(usr,usr.dir)) if(A.client)
			if(A.icon_state == "KO")
				if(A.KeepsBody == 0) if(A.Dead)
					usr << "They don't have a body and can't be harmed that way."
					return
				var/list/Choices=new
				if(A.Race == "Saiyan") if(A.Tail)
					Choices += "Tail"
				if(A.Critical_Head == 0)
					Choices += "Head"
				if(A.Critical_Right_Arm == 0)
					Choices += "Right Arm"
				if(A.Critical_Left_Arm == 0)
					Choices += "Left Arm"
				if(A.Critical_Right_Leg == 0)
					Choices += "Right Leg"
				if(A.Critical_Left_Leg == 0)
					Choices += "Left Leg"
				if(A.Critical_Torso == 0)
					Choices += "Torso"
				if(A.Critical_Hearing == 0)
					Choices += "Hearing"
				if(A.Critical_Sight == 0) if(A.sight != (SEE_MOBS|SEE_OBJS|SEE_TURFS))
					Choices += "Sight"
				if(A.Critical_Throat == 0)
					Choices += "Throat"
				if(A.Critical_Mate == 0) if(A.Race != "Android")
					Choices += "Mating Ability"
				Choices.Add("Cancel")
				var/Result = input("Choose injury to apply") in Choices
				if(A.icon_state == "KO") if(A in range(1,usr))
					if(Result)
						var/L = list("[Result]")
						A.Injure_Hurt(100,L,usr)
obj/Blindness
	icon = 'blindess.dmi'
	layer = 100
	mouse_opacity = 0
obj/Curse/var/CursePower=0

obj/Bind
	var/Last_Usage=0
	desc="You can use this to bind someone to hell. You can only bind a person who is less than your \
	own power at the time. The stronger they are compared to you the more energy it will drain \
	to bind them"

	verb/Bind()
		set category="Skills"
		for(var/mob/A in get_step(usr,usr.dir)) if(A.client)
			if(A.icon_state == "KO")
				if(A.BP>usr.BP)
					view(usr)<<"[usr] attempts to bind [A] to hell, but [A]'s spiritual power deflects it!"
					return
				if(usr.Ki<usr.MaxKi*0.9)
					usr<<"You need at least 90% energy to attempt a bind"
					return
				if(locate(/obj/Curse) in A)
					view(usr)<<"[usr] strengthens the bind already placed on [A]!"
					for(var/mob/player/M in view(usr)) if(M.client) M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] strenghtens the bind already placed on [A].\n")
					for(var/obj/Curse/B in A) B.CursePower+=usr.MaxKi
				else
					view(usr)<<"[usr] successfully binds [A] to hell!"
					log_ability("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] binds [key_name(A)] to Hell.")
					for(var/mob/player/M in view(usr)) if(M.client) M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] binds [key_name(A)] to Hell.\n")
					var/obj/Curse/B=new
					B.CursePower+=usr.MaxKi
					A.contents+=B
					spawn A.Bind_Return()
				usr.Ki=0
			else
				usr << "[A] must be knocked out in order to use this."
				return

	verb/UnBind()
		set category="Skills"
		if(Last_Usage>Year-1)
			usr<<"You can only use this once every year"
			return
		for(var/mob/A in get_step(usr,usr.dir)) if(A.client) for(var/obj/Curse/B in A)
			if(usr.Ki<usr.MaxKi*0.9)
				usr<<"You need at least 90% energy to attempt to remove a bind"
				return
			Last_Usage=Year
			B.CursePower-=usr.Ki
			usr.Ki=0
			if(B.CursePower<=0)
				view(usr)<<"[usr] succeeds in breaking the bind placed on [A]!"
				log_ability("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] unbound [key_name(A)] from hell")
				for(var/mob/player/M in view(usr)) if(M.client) M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] unbound [key_name(A)] from Hell.\n")
				del(B)
			else
				view(usr)<<"[usr] weakened the bind somewhat, but did not yet break it"
				for(var/mob/player/M in view(usr)) if(M.client) M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] weakened the bind somewhat, but did not yet break it.\n")
			return

	//verb/Teach(mob/player/A in view(usr))
		//set category="Other"
		//Teachify(A,5000)
//mob/verb/Description(obj/A in world) if(A&&A.desc) src<<"<br><br>[A.desc]"

mob/proc/Bio_Forms(mob/A) if(Race=="Bio-Android"&&A.Race=="Android")
	if(!Semiperfect_Form)
		Semiperfect_Form=1
		BP_Multiplier*=1.25
		Regeneration*=1.5
		Recovery*=1.5
		Decline*=1.5
		if(icon=='Bio Android 1.dmi') icon='Bio Android 2.dmi'
		if(icon=='Bio1.dmi') icon='Bio2.dmi'
	else if(!Perfect_Form)
		Perfect_Form=1
		BP_Multiplier*=1.25
		Regeneration*=1.5
		Recovery*=1.5
		Decline*=1.5
		if(icon=='Bio Android 2.dmi') icon='Bio Android 3.dmi'
		if(icon=='Bio2.dmi') icon='Bio3.dmi'
		for(var/obj/Absorb/B in src) del(B)
mob/var/tmp/Absorbed = 0

obj/Absorb
	var/LastUse = 0
	desc="This allows you to add the power of a person you absorb into your own. You cannot hold more \
	than double your own power. The Release option lets you release the power you have absorbed. \
	Absorb does have disadvantages, the more you exceed your own power the less your Regeneration and \
	Recovery become until you release the power, so going to the max of 2x your own power, means \
	regeneration and recovery are divided by 2x. Also if your a living creature you cannot absorb \
	androids, unless you yourself are a bio-android. Androids can absorb androids."
	verb/Release()
		set category="Skills"
		switch(input("Are you sure you want to release this absorbed power?") in list("No","Yes"))
			if("Yes")
				usr<<"You release all your absorbed power"
				log_ability("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has released their absorb of [usr.Absorb].")
				usr.Absorb=0
	verb/Absorb(mob/M in get_step(usr,usr.dir))
		set category="Skills"
		if(!M.client) return
		if(M.client) if(M.client.address==usr.client.address) return
		if(usr.icon_state=="KO"|M.icon_state!="KO") return
		if(usr.Race!="Android"&&M.Race=="Android"&&usr.Race!="Bio-Android") return
		if(usr.Race=="Android"&&M.Race!="Android") return
		if(Year<LastUse+5)
			usr<<"You cannot use this until 5 years after you last used it"
			return
		if(usr.Absorb>=usr.Base)
			view(usr)<<"[usr] attempts to absorb [M], but finds that they cannot hold any more power"
			return
		view(usr)<<"[usr] absorbs [M]!"
		log_ability("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has Absorbed [key_name(M)] for [usr.Absorb+M.BP]")
		alertAdmins("([usr.x], [usr.y], [usr.z])[key_name(usr)] has Absorbed [key_name(M)] for [M.BP] power.")
		for(var/mob/player/K in view(usr)) if(K.client) K.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has absorbed [key_name(M)] for [usr.Absorb+M.BP].\n")
		usr.Absorb+=M.BP
		usr.Absorb_Max += M.BP
		LastUse =Year
		if(usr.Absorb>usr.Base)
			usr.Absorb=usr.Base
			usr.Absorb_Max = usr.Base
		usr.Health=100
		usr.Ki=usr.MaxKi
		usr.Bio_Forms(M)
		M.Absorbed = 1
		spawn M.Death(usr)
obj/Absorb_Energy
	var/LastUse = 0
	desc="This will allow you to steal a portion of energy from a victim, adding it to your own max.\
	However, it will not kill your victim or remove any of their max energy, but will remove a small portion of their decline.\
	Like other types of absorb, it can only be used once in a while and requires the victim to be knocked out first."
	verb/Energy_Absorb(mob/M in get_step(usr,usr.dir))
		set category="Skills"
		if(!M.client) return
		if(M.client) if(M.client.address==usr.client.address) return
		if(usr.icon_state=="KO"|M.icon_state!="KO") return
		if(usr.Race!="Android"&&M.Race=="Android") return
		if(Year<LastUse+5)
			usr<<"You cannot use this until 5 years after you last used it"
			return
		view(usr)<<"[usr] absorbs some of [M]'s energy!"
		M << "You feel weaker, as if some years of your life were suddenly stolen or consumed..."
		usr.MaxKi += M.MaxKi / 10
		usr.Decline += M.Decline / 10
		M.Decline -= M.Decline / 10
		usr.Ki=usr.MaxKi
		log_ability("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has Absorbed  some of [key_name(M)]'s energy!")
		alertAdmins("([usr.x], [usr.y], [usr.z])[key_name(usr)] has Absorbed [key_name(M)]'s energy.")
		for(var/mob/player/K in view(usr)) if(K.client) K.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has Absorbed  some of [key_name(M)]'s energy!.\n")
		LastUse =Year
		usr.Ki=usr.MaxKi
obj/Shunkan_Ido

/*
	Write(savefile/F)
		var/OldUsing=Using
		Using=0
		..()
		Using=OldUsing
*/

	var/Teachable=1
	Difficulty=100
	var/tmp/inUse //A temporary var so the state doesn't get saved or logging out while using it might bug the skill.
	desc="Shunkan Ido, also known as Instant Transmission, is self-explanatory. If you have enough \
	skill you can detect powers further away, and teleport to them. The more skill you have the \
	less time it will take to locate their energy. Anyone next to you will also be brought with you. \
	Some people are just too weak to sense, even to someone with very high skill in Shunkan Ido"
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		if(!Teachable)
			src<<"This is unteachable until re-taught to you."
			return
		for(var/obj/Shunkan_Ido/S in A)
			S.Teachable=1
			view(A)<<"[A] has learned [src]"
		Teachify(A,6000,-1000)
	verb/Shunkan_Ido(var/obj/Contact/X in usr.Contacts)
		set category="Skills"
		set src=usr.contents
		var/mob/A = null
		for(var/mob/M in Players)
			if(M.ckey == X.pkey)
				if(X.familiarity >= 25)
					A = M
					break
				else
					usr << "You're not familiar enough with that energy signature to find it."
					return
		if(A) if((A.z==10||A.z==15)&&usr.z!=A.z)
			usr<<"You cannot teleport to other dimensions."
			return
		/*for(var/area/B in range(0,A)) if(istype(B,/area/Inside))
			usr<<"You cannot teleport inside people's houses"
			return*/
		if(usr.Ki<100||inUse)
			usr<<"You do not have enough energy"
			return
		if(A.Race == "Android")
			usr << "Androids do not have an energy signature!"
			return
		//var/mob/Found
		//for(var/mob/B in orange(usr.MaxKi,usr)) if(B==A|usr.MaxKi>1000)
			//Found=A
			//break
		//if(!Found)
			//usr<<"They are out of your range..."
			//return
		inUse=1
		view(usr)<<"[usr] begins concentrating..."
		usr<<"This may take a minute..."
		sleep(1200/Level)
		Level+=0.1
		if(usr)
			if(A)
				usr<<"You found their energy signature."
				oview(usr)<<"[usr] disappears in a flash!"
				for(var/mob/B in oview(1,usr)) if(B.client) if(B.client.address!=usr.client.address)
					oview(B)<<"[B] disappears!"
					B.loc=A.loc
					step_rand(B)
					spawn(1) oview(B)<<"[B] suddenly appears!"
				usr.loc=A.loc
				log_ability("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] teleported to [key_name(A)] who was at [A.loc]")
				usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] teleported to [key_name(A)] who was at [A.loc]\n")
				step_rand(usr)
				inUse=0
			else
				usr<<"They logged out..."
				inUse=0
/*verb/Shunkan_Ido(mob/A in Players)
		set category="Skills"
		set src=usr.contents
		var/MOBS = list()
		for(var/mob/X in Players)
			MOBS += "[X.name] - [X.Signature]"
		if((A.z==10||A.z==15)&&usr.z!=A.z)
			usr<<"You cannot teleport to other dimensions."
			return
		/*for(var/area/B in range(0,A)) if(istype(B,/area/Inside))
			usr<<"You cannot teleport inside people's houses"
			return*/
		if(usr.Ki<100||inUse)
			usr<<"You do not have enough energy"
			return
		var/mob/Found
		for(var/mob/B in orange(usr.MaxKi,usr)) if(B==A|usr.MaxKi>1000)
			Found=A
			break
		if(!Found)
			usr<<"They are out of your range..."
			return
		inUse=1
		view(usr)<<"[usr] begins concentrating..."
		usr<<"This may take a minute..."
		sleep(1200/Level)
		Level+=0.1
		if(A&&usr)
			usr<<"You found their energy signature."
			oview(usr)<<"[usr] disappears in a flash!"
			for(var/mob/B in oview(1,usr)) if(B.client) if(B.client.address!=usr.client.address)
				oview(B)<<"[B] disappears!"
				B.loc=A.loc
				step_rand(B)
				spawn(1) oview(B)<<"[B] suddenly appears!"
			usr.loc=A.loc
			log_ability("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] teleported to [key_name(A)] who was at [A.loc]")
			usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] teleported to [key_name(A)] who was at [A.loc]\n")
			step_rand(usr)
			inUse=0
		else
			usr<<"[A] logged out..."
			inUse=0
*/
obj/Teleport
	desc="Teleport to any planet instantly. This will drain all your energy. Anyone who is beside \
	you will be taken with you."
	verb/Celestial_Teleport()
		set category="Skills"
		if(usr.z==15)
			usr<<"You can not teleport out of this place."
			return
		if(usr.Ki<usr.MaxKi)
			usr<<"You need full energy to use this"
			return
		var/list/Planets=new
		Planets.Add("Afterlife","Heaven","Arconia","Earth","Namek","Vegeta","Ice","Desert","Jungle",\
		"Android","Alien","???")
		if(usr.Race != "Kaio")
			Planets.Remove("???")
		var/image/I=image(icon='Black Hole.dmi',icon_state="full")
		I.icon+=rgb(rand(0,255),rand(0,255),rand(0,255))
		var/CHOICE
		switch(input("Choose a realm") in Planets)
			if("Afterlife")
				flick(I,usr)
				for(var/mob/A in oview(1,usr)) spawn(1) A.loc=usr.loc
				usr.loc=locate(250,250,5)
				CHOICE="Afterlife"
			if("Heaven")
				flick(I,usr)
				for(var/mob/A in oview(1,usr)) spawn(1) A.loc=usr.loc
				usr.loc=locate(250,250,7)
				CHOICE="Heaven"
			if("Arconia")
				flick(I,usr)
				for(var/mob/A in oview(1,usr)) spawn(1) A.loc=usr.loc
				usr.loc=locate(250,250,8)
				CHOICE="Arconia"
			if("Earth")
				flick(I,usr)
				for(var/mob/A in oview(1,usr)) spawn(1) A.loc=usr.loc
				usr.loc=locate(250,250,1)
				CHOICE="Earth"
			if("Namek")
				flick(I,usr)
				for(var/mob/A in oview(1,usr)) spawn(1) A.loc=usr.loc
				usr.loc=locate(250,250,3)
				CHOICE="Namek"
			if("Vegeta")
				flick(I,usr)
				for(var/mob/A in oview(1,usr)) spawn(1) A.loc=usr.loc
				usr.loc=locate(250,250,4)
				CHOICE="Vegeta"
			if("Ice")
				flick(I,usr)
				for(var/mob/A in oview(1,usr)) spawn(1) A.loc=usr.loc
				usr.loc=locate(250,250,12)
				CHOICE="Ice"
			if("Desert")
				flick(I,usr)
				for(var/mob/A in oview(1,usr)) spawn(1) A.loc=usr.loc
				usr.loc=locate(100,90,14)
				CHOICE="Desert"
			if("Jungle")
				flick(I,usr)
				for(var/mob/A in oview(1,usr)) spawn(1) A.loc=usr.loc
				usr.loc=locate(150,443,14)
				CHOICE="Jungle"
			if("Android")
				flick(I,usr)
				for(var/mob/A in oview(1,usr)) spawn(1) A.loc=usr.loc
				usr.loc=locate(321,425,14)
				CHOICE="Android"
			if("Alien")
				flick(I,usr)
				for(var/mob/A in oview(1,usr)) spawn(1) A.loc=usr.loc
				usr.loc=locate(370,143,14)
				CHOICE="Alien"
			if("???")
				flick(I,usr)
				for(var/mob/A in oview(1,usr)) spawn(1) A.loc=usr.loc
				usr.loc=locate(271,494,13)
				CHOICE="???"
		usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] used Kaio Teleport to go to planet [CHOICE].\n")
		usr.Ki=0

	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(A,15000)



mob/proc/AuraOverlays()
	overlays.Remove(Aura,/obj/Auras_Special/SSJ1,/obj/Auras_Special/LSSJ,/obj/Auras_Special/SN,'Aura SSj3.dmi','Sparks LSSj.dmi','SNj Elec.dmi',\
	'Electric_Mystic.dmi','Mutant Aura.dmi','Void Aura.dmi')
	underlays-=SSj4Aura
	for(var/obj/Power_Control/A in src) if(A.Powerup)
		if(Race=="Void Spawn"|Void_Power) overlays+='Void Aura.dmi'
		if(Race == "Namekian") if(src.Ascended)
			overlays+=/obj/Auras_Special/SN
		if(Class=="Legendary")
			overlays+='Sparks LSSj.dmi'
			overlays+=/obj/Auras_Special/LSSJ
		else if(Race=="Mutant Saiyan") overlays+='Mutant Aura.dmi'
		else if(!ssj) if(MaxKi>=600) overlays+=Aura
		else if(ssj == 1|ssj == 2) overlays+=/obj/Auras_Special/SSJ1
		else if(ssj == 3) overlays+=/obj/Auras_Special/SSJ1
		else if(ssj == 4) underlays+=SSj4Aura
		//if(Race=="Namekian"&&FBMAchieved) overlays+='SNj Elec.dmi'
		if(ismystic) overlays+='Electric_Mystic.dmi'
		break


turf/proc/Rising_Rocks()
	overlays-='Rising Rocks.dmi'
	overlays+='Rising Rocks.dmi'
	spawn(600) if(src) overlays-='Rising Rocks.dmi'


var/image/Self_Destruct_Fire=image(icon='Lightning flash.dmi',layer=99)

turf/proc/Self_Destruct_Lightning(B) if(B)
	overlays-=Self_Destruct_Fire
	overlays+=Self_Destruct_Fire
	spawn(B) if(src) overlays-=Self_Destruct_Fire

obj/Self_Destruct

/*
	Write(savefile/F)
		var/OldUsing=Using
		Using=0
		..()
		Using=OldUsing
*/

	Difficulty=2
	desc="Using this will kill you. It is an extremely powerful attack, one of the top 3 at least. \
	It will affect a large area."
	verb/Self_Destruct()
		set category="Skills"
		if(Using)return
		switch(input("Self Destruct?") in list("No","Yes"))
			if("Yes") if(!usr.Dead&&src.icon_state!="KO")
				usr.move=0
				Using=1
				view(20)<<"[usr] begins gathering all the energy around him into his body!"
				sleep(30)
				view(20)<<"The ground begins to shake fiercely around [usr]!"
				sleep(30)
				view(12)<<"A huge explosion eminates from [usr] and surrounds the area!"
				for(var/turf/T in view(usr,20))
					if(prob(7)) sleep(1)
					spawn T.Self_Destruct_Lightning(rand(50,100))
					T.Health-=100*usr.Pow
					spawn(rand(50,100)) {if(usr!=0) T.Destroy(usr,usr.key);else T.Destroy("Unknown","Unknown")}
					for(var/mob/M in T) if(M!=usr)
						M.Health-=((usr.BP+usr.Pow)/(M.BP+M.Res))*250
						if(M.Health<=0)
							if(M.Regenerate&&M.icon_state!="KO") if(usr.BP>M.BP*M.Regenerate) M.Dead=1
							spawn M.Death(usr)
				usr.Death(usr)
				log_ability("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] used Self Destruct")
				usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] used Self Destruct.\n")
				usr.Ki=0
				usr.move=1
				spawn(10)
					if(usr)
						src.Using=0

	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(A,2000)

obj/Kaio_Revive
	desc="This will bring someone back to life. You cannot use it more than once every year."
	var/Last_Use=0
	verb/Revive()
		set category="Skills"
		if(Year<Last_Use+1)
			usr<<"You can not use this til year [Last_Use+1]"
			return
		if(usr.Dead)
			usr<<"You cannot use this if you are dead."
			return
		for(var/mob/A in get_step(usr,usr.dir)) if(A.client&&A.Dead)
			if(Year<A.Died+Dead_Time)
				usr<<"This can't be used on someone not attuned to the realm of the dead, their incorporeal form hasn't been deceased long enough. This process usually takes [Dead_Time] years."
				return
			view(usr)<<"[A] is revived by [usr]"
			Last_Use=Year
			A.Revive()
			log_ability("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] used Kaio Revive on [key_name(A)]")
			alertAdmins("[key_name(usr)] used Kaio Revive on [key_name(A)]")
			usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] used Kaio Revive on [key_name(A)].\n")
			A.saveToLog("| [A.client.address ? (A.client.address) : "IP not found"] | ([A.x], [A.y], [A.z]) | [key_name(A)] was revived by [key_name(usr)] (Kaio Revive).\n")
			break

	//verb/Teach(mob/player/A in view(usr))
		//set category="Other"
		//Teachify(A,10000)

obj/Oni_Revive
	desc="This will bring someone back to life with a fifty percent chance to kill you each time it's used. You cannot use it more than once every year."
	var/Last_Use=0
	verb/Revive()
		set category="Skills"
		if(Year<Last_Use+1)
			usr<<"You can not use this til year [Last_Use+1]"
			return
		if(usr.Dead)
			usr<<"You cannot use this if you are dead."
			return
		for(var/mob/A in get_step(usr,usr.dir)) if(A.client&&A.Dead)
			view(usr)<<"[A] is revived by [usr]"
			Last_Use=Year
			A.Revive()
			log_ability("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] used Oni Revive on [key_name(A)]")
			alertAdmins("[key_name(usr)] used Oni Revive on [key_name(A)]")
			usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] used Oni Revive on [key_name(A)].\n")
			A.saveToLog("| [A.client.address ? (A.client.address) : "IP not found"] | ([A.x], [A.y], [A.z]) | [key_name(A)] was revived by [key_name(usr)] (Oni Revive).\n")

			if(prob(50))
				usr.Death()
			break
	//verb/Teach(mob/player/A in view(usr))
		//set category="Other"
		//Teachify(A,10000000000000)

obj/Heal
	Difficulty=10
	desc="You can heal anyone in front of you by giving up some of your own health and energy. If they \
	have certain status problems they can be further alleviated by healing them, with multiple heals \
	they may be cured."
	verb/Heal()
		set category="Skills"
		if(usr.icon_state=="KO"||usr.Ki<usr.MaxKi/usr.KiMod) return
		for(var/mob/A in get_step(usr,usr.dir))
			if(!A.client) return
			if(!Learnable)
				Learnable=1
				spawn(100) Learnable=0
			usr.Health-=50
			usr.Ki-=usr.MaxKi/usr.KiMod
			A.Un_KO()
			A.Health=100
			var/L = list("Random")
			A.Injure_Heal(100,L)
			A.Heal_Zenkai()
			if(A.Poisoned) A.Poisoned-=1

			view(usr)<<"<font color=#FFFF00>[usr] heals [A]"
			log_ability("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] healed [key_name(A)]")
			usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] healed [key_name(A)].\n")
			A.saveToLog("| [A.client.address ? (A.client.address) : "IP not found"] | ([A.x], [A.y], [A.z]) | [key_name(A)] was healed by [key_name(usr)].\n")
			break

obj/Unlock_Potential
	var/Usable=0 //The year you may next use this.
	desc="Using this on someone will greatly increase their power and energy. Each use will add 5 years \
	to how long you must wait to use it on someone again."
	verb/Unlock_Potential(mob/A in oview(1))
		set category="Skills"
		if(!A.client) return
		if(Year<Usable)
			usr<<"You cannot use this until year [Usable]"
			return
		Usable+=5
		switch(input(A,"[usr] wants to unlock your hidden powers") in list("No","Yes"))
			if("Yes")
				if(A.UP)
					usr<<"Their potential is already unlocked"
					return
				view(usr)<<"[usr] uses unlock potential on [A]"
				log_ability("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] unlocked [key_name(A)]'s potential")
				usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] unlocked [key_name(A)]'s potential.\n")
				A.saveToLog("| [A.client.address ? (A.client.address) : "IP not found"] | ([A.x], [A.y], [A.z]) | [key_name(A)] had their potential unlocked by [key_name(usr)].\n")
				alertAdmins("[key_name(usr)] used Unlock Potential on [key_name(A)]")
				A.UP=1
				A.Base = A.Base*2
				A.MaxKi = A.MaxKi*2
				A.KiMod = A.KiMod*1.2
				A.BPMod = A.BPMod*1.2
				var/Potent = A.Potential
				Potent = Potent / 50
				Potent += 1
				A.Base = A.Base*Potent
				A.MaxKi = A.MaxKi*Potent
			if("No") if(usr) usr<<"[A] declined your offer."
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(A,15000)
obj/Dark_Blessing
	var/Usable=0 //The year you may next use this.
	desc="Using this on someone will greatly increase their power, decline, dura and offence. Each use will add 5 years \
	to how long you must wait to use it on someone again."
	verb/Dark_Blessing(mob/A in oview(1))
		set category="Skills"
		if(!A.client) return
		if(Year<Usable)
			usr<<"You cannot use this until year [Usable]"
			return
		Usable+=5
		switch(input(A,"[usr] wants to give you a dark blessing.") in list("No","Yes"))
			if("Yes")
				if(A.UP)
					usr<<"Their potency is already unlocked."
					return
				view(usr)<<"[usr] uses dark blessing on [A]"
				log_ability("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] gave [key_name(A)] a dark blessing. ")
				usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] gave [key_name(A)] a dark blessing..\n")
				A.saveToLog("| [A.client.address ? (A.client.address) : "IP not found"] | ([A.x], [A.y], [A.z]) | [key_name(A)] was given a dark blessing by [key_name(usr)].\n")
				alertAdmins("[key_name(usr)] has given [key_name(A)] a dark blessing.")
				A.UP=1
				A.Base = A.Base*2
				A.Decline = A.Decline*1.1
				A.EndMod = A.EndMod*1.2
				A.OffMod = A.OffMod*1.2
				var/Potent = A.Potential
				Potent = Potent / 50
				Potent += 1
				A.Base = A.Base*Potent
				A.Decline = A.Decline*Potent
				A.EndMod = A.EndMod*Potent
				A.OffMod = A.OffMod*Potent
			if("No") if(usr) usr<<"[A] declined your offer."

obj/Taiyoken
	Difficulty=5
	desc="Taiyoken, also known as Solar Flare, blinds an Opp for a limited amount of time. \
	The amount of time the person is blinded depends on their regeneration. It is mainly used so \
	that they dont see what direction you went in, and so that they cant pursue you until they can \
	see again"
	verb/Taiyoken()
		set category="Skills"
		if(!usr.attacking)
			if(!Learnable)
				Learnable=1
				spawn(100) Learnable=0
			usr.attacking=3
			usr.Ki*=0.7
			var/distance=round(usr.Ki*0.01)
			if(distance>15) distance=15
			if(distance<1) distance=1
			var/originalLum = usr.luminosity	//Restore their lum after attack
			usr.luminosity = max(distance,usr.luminosity)
			for(var/turf/A in oview(usr,distance)) A.Self_Destruct_Lightning(5)
			sleep(5)
			for(var/mob/A in oview(usr,distance))
				if(A.sight != (SEE_MOBS|SEE_OBJS|SEE_TURFS))
					if(A == usr)	continue	//don't blind yourself lol
					A<<"You are blinded by [usr]'s Taiyoken"
					A.saveToLog("| ([A.x], [A.y], [A.z]) | [key_name(A)] was blinded by [usr]'s Taiyoken.\n")
					var/L = list("Sight")
					if(A.Critical_Sight == 0)
						var/E = A.Injury_Sight
						A.Injure_Hurt(100,L,usr)
						A.Injury_Sight = E + 5
				if(A.Vampire)
					A<<"You are burned by [usr]'s Taiyoken"
					A.saveToLog("| ([A.x], [A.y], [A.z]) | [key_name(A)] was burned by [usr]'s Taiyoken.\n")
					A.Health -= 10
			usr.luminosity = originalLum
			sleep(usr.Refire*5)
			usr.attacking=0

obj/Rift_Teleport/verb/Rift_Teleport()
	set category="Skills"
	var/image/I=image(icon='Black Hole.dmi',icon_state="full")
	switch(input("Person or Location?") in list("Person","Location",))
		if("Location")
			var/xx=input("X Location?") as num
			var/yy=input("Y Location?") as num
			var/zz=input("Z Location?") as num
			oview(usr)<<"[usr] disappears into a mysterious rift that disappears after they enter."
			spawn flick(I,usr)
			sleep(10)
			usr.loc=locate(xx,yy,zz)
			oview(usr)<<"[usr] appears out of a rift in time-space."
		else
			var/list/A=new
			for(var/mob/player/M in Players) if(M.client) A.Add(M)
			var/Choice=input("Who?") in A
			oview(usr)<<"[usr] disappears into a mysterious rift that disappears after they enter."
			spawn flick(I,usr)
			sleep(10)
			for(var/mob/M in A) if(M==Choice) usr.loc=locate(M.x+rand(-1,1),M.y+rand(-1,1),M.z)
			oview(usr)<<"[usr] appears out of a rift in time-space."
	usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] used Rift Teleport to get here.\n")

obj/Imitation
	desc="You can use this on someone to imitate them in almost every way, so much so that you may \
	be confused with them. You can hit it again to stop imitating."
	var/imitating
	var/imitatorname
	var/list/imitatoroverlays=new
	var/imitatoricon
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(A,10000)
	verb/Imitate()
		set category="Skills"
		if(!imitating)
			imitating=1
			imitatorname=usr.name
			imitatoroverlays.Add(usr.overlays)
			imitatoricon=usr.icon
			var/list/People=new
			for(var/mob/A in oview(usr)) People.Add(A)
			var/Choice=input("Imitate who?") in People
			for(var/mob/A in People) if(A==Choice)
				usr.icon=A.icon
				usr.overlays.Remove(usr.overlays)
				usr.overlays.Add(A.overlays)
				usr.overlays -= 'afk.dmi'
				usr.name=A.name
				usr.Signature_True = usr.Signature
				usr.Signature = A.Signature
				imitating=1
				usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] imitates [key_name(A)].\n")
		else
			imitating=0
			usr.name=imitatorname
			usr.overlays.Remove(usr.overlays)
			usr.overlays.Add(imitatoroverlays)
			usr.icon=imitatoricon
			usr.Signature = usr.Signature_True
			imitatoroverlays.Remove(imitatoroverlays)
			usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] deactivates imitate.\n")

obj/Invisibility
	desc="You can use this to make yourself invisible. Some people with very good senses will still \
	know you are there, or if they have visors capable of seeing invisible objects."
	verb/Invisibility()
		set category="Skills"
		if(Using&&!usr.invisibility) // Using will be 1 but their invisiblity disabled if they've attacked while invisible.
			usr<<"Your body feels too tense and you are unable to turn invisible!"
			return
		else if(!usr.invisibility&&!Using)
			usr.invisibility=1
			usr.see_invisible=1
			Using=1
			usr<<"You are now invisible."
		else if(usr.invisibility&&Using)
			usr.see_invisible=0
			usr.invisibility=0
			usr<<"You are visible again."
			spawn(45){Using=0;src<<"You can now turn invisible again."}

		usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] [usr.invisibility ? "is now invisible" : "is no longer invisible"].\n")

/*
/client/proc/admin_observe()
	set category = "Admin"
	set name = "Set Observe"
	if(!src.holder)
		alert("You are not an admin")
		return

	src.verbs += /client/proc/admin_play
	src.verbs -= /client/proc/admin_observe
	var/rank = src.holder.rank
	clear_admin_verbs()
	src.holder.state = 2
	update_admins(rank)
	if(!istype(src.mob, /mob/observer))
		src.mob.adminObserve = 1
		src.mob.ghostize()
	src << "You are now observing"

mob/Admin2/verb
	XYZTeleport(mob/M in world)
		set category="Admin"
		usr<<"This will send the mob you choose to a specific xyz location."
		var/xx=input("X Location?") as num
		var/yy=input("Y Location?") as num
		var/zz=input("Z Location?") as num

		switch(input("Are you sure?") in list ("Yes", "No",))
			if("Yes")
				M.loc=locate(xx,yy,zz)
				logAndAlertAdmins("[src.key] used XYZTeleport on [M] to ([M.x],[M.y],[M.z])",2)
*/
/*
obj/Kaio_Observe
	verb/Observe()
		var/list/Options = new
		Options.Add("Cancel","Earth","Namek","Vegeta","Arconia",\
		"Ice","Desert Planet","Jungle Planet","Android Ship","Hell"\
		"Checkpoint","Heaven","Space")
		switch(input(src,"Give what?") in Options)
*/

obj/Observe
	verb/Observe(mob/M in Players)
		set category="Skills"
		set src=usr.contents
		usr.Get_Observe(M)
		usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] uses observe on [key_name(M)].\n")
obj/Observe_Majinizations
	verb/Observe_Majinizations(mob/M in Players)
		set category="Skills"
		set src=usr.contents
		if(M == usr)
			usr.Get_Observe(M)
			return
		if(M.Majin_By == usr.key)
			usr << "You use your link to [M] and see through their eyes. Observe yourself to reset your view."
			usr.Get_Observe(M)
			usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] uses observe majinization on [key_name(M)].\n")

	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(A,30000)

mob/proc/Get_Observe(mob/M)
	if(M==src)
		if(S) client.eye=S
		else client.eye=src
	else client.eye=M

obj/Fusion
	desc="You can use this to fuse with another person of the same race. You will die from it, but the \
	other person will gain a very large power boost. If the person was your counterpart, it breaks that \
	bond forever."
	var/list/Fused=new
	var/tmp/Fusing
	verb/Fuse(mob/A in oview(usr))
		set src=usr.contents
		if(Fusing) return
		Fusing=1
		if(A.client) if(Fused.Find(A.key)|A.client.address==usr.client.address|!A.client|A.Dead|A.Race!=usr.Race)
			usr<<"You cannot fuse with this person"
			return
		var/Choice=alert(A,"[usr] wants to fuse with you and give you their power, do you accept?","","No","Yes")
		switch(Choice)
			if("Yes")
				view(usr)<<"[usr] fuses with [A]!"
				log_ability("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] used Fusion with [key_name(A)]")
				alertAdmins("[key_name(usr)] used Fusion with [key_name(A)]")
				usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] used Fusion with [key_name(A)]\n")
				A.saveToLog("| [A.client.address ? (A.client.address) : "IP not found"] | ([A.x], [A.y], [A.z]) | [key_name(A)] fused via Fusion with [key_name(usr)].\n")
				A.Base+=usr.Base
				A.BPMod += usr.BPMod /2
				//A.Final_Mod()
				Fused.Add(A.key)
				if(usr.Counterpart=="[A]([A.key])")
					usr.Counterpart=null
					A.Counterpart=null
				spawn usr.Death("sacrificed their life through fusion")
			else view(A)<<"[A] declines [usr]'s offer to fuse"
		Fusing=0

obj/Materialization
	desc="You can use this to materialize clothing that has different weights. The more energy you get \
	the higher weight you can make. You can also make swords, the swords will match your own power \
	roughly, and recieve a bonus if you have higher energy."
	verb/Materialize()
		set category="Skills"
		switch(input("") in list("Check Lift","Make Weights","Make Sword","Cancel"))
			if("Check Lift")
				var/list/Mobs=new
				for(var/mob/B in view(usr)) Mobs+=B
				var/mob/A=input("Who?") in Mobs as mob|null
				alert("[A] can lift [Commas((A.Str+A.End)*2)] pounds. You make up to [Commas(usr.MaxKi*usr.KiMod)]")  //Was .5
			if("Make Weights")
				var/Weights=input("How heavy? Between 1 and [Commas(usr.MaxKi*usr.KiMod)] pounds (Your race's ability with \
				Materialization is [usr.KiMod]x the average). You can lift [Commas((usr.Str+usr.End)*2)] pounds") as num
				if(!Weights) return
				if(Weights>usr.MaxKi*usr.KiMod) Weights=usr.MaxKi*usr.KiMod
				if(Weights<1) Weights=1
				Weights=round(Weights)
				var/obj/items/Weights/A=new(get_step(usr,usr.dir))
				A.Weight=Weights
				A.name="[round(A.Weight)]lb Weights"
				switch(input("Choose a style") in list("Cape","Shirt","Wristbands","Scarf","Turban"))
					if("Cape") A.icon='Clothes_Cape.dmi'
					if("Shirt") A.icon='Clothes_ShortSleeveShirt.dmi'
					if("Wristbands") A.icon='Clothes_Wristband.dmi'
					if("Scarf") A.icon='Clothes_NamekianScarf.dmi'
					if("Turban") A.icon='Clothes_Turban.dmi'
				var/RGB=input("") as color|null
				usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] creates [A.name].\n")
				if(RGB) A.icon+=RGB
			if("Make Sword")
				var/list/Swords=new
				for(var/A in typesof(/obj/items/Sword)) Swords+=new A
				var/obj/items/Sword/A=input("What kind of sword?") in Swords
				A.Health+=usr.Base*usr.Body*usr.KiMod
				A.desc="[Commas(A.Health)] BP Sword"
				A.loc=get_step(usr,usr.dir)
				Swords=null
				usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] creates a [A.desc].\n")
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(A,2000)
/*obj/Construct_Robot
	verb/Construct_Spider_Drone()
		set category="Construction"
		set name="Construct Spider Drone"
		desc="This will allow you to construct a Spider type drone, which is effective in melee"
		if (usr.Race=="Tsufurujin")
			Create_Drone()



	//	Create_Drone()
mob/proc/Create_Drone((mob/player/M in oview(1,usr)))
	var/CreatesDrone

	if(Race=="Tuffle"&&Int_Level>=40||Race=="Human"&&Int_Level>=40||Race=="Alien"&&Potential==4&&Int_Level>=40)
		for(var/obj/Resources/B in usr)
		if(B.Value>=15000)
			B.Value-=15000
		var/obj/A=new Creates*/
obj/Mystic
	desc="Mystic will decrease, or even stop, the drain \
	of other forms you may be in. It greatly increases speed, and especially recovery. It allows you \
	to power up much faster and higher than in your regular form. But, it will also cause you to not \
	be able to tap into your anger for power. However, it does increase your power by 30% if you're a \
	Kaio and by 15% if you're not."
	verb/Mystic()
		set category="Skills"
		if(usr.ismajin)
			usr<<"You cant use this with Majin"
			return
		if(!usr.attacking)
			usr.attacking=1
			if(usr.ssj==3)
				usr<<"<font color=teal>This cannot be used with Super Saiyan 3."
				usr.ismystic=0
				return
			else if(!usr.ismystic)
				usr<<"You are now using mystic"
				usr.ismystic=1
				usr.Recovery*=2
				usr.Spd*=1.5
				usr.SpdMod*=1.5
				usr.BP_Multiplier*=1.15
				usr.overlays-=/obj/Auras_Special/SSJ1
				usr.overlays-=/obj/Auras_Special/LSSJ
				usr.overlays-=/obj/Auras_Special/SN
				usr.overlays-='Elec.dmi'
				usr.overlays-='Electric_Blue.dmi'
				usr.overlays-='Electric_Majin.dmi'
				usr.overlays-=usr.ssjhair
				usr.overlays-=usr.ussjhair
				usr.overlays-=usr.ssjfphair
				usr.overlays-=usr.ssj2hair
				usr.overlays-=usr.ssj3hair
				usr.overlays-=usr.hair
				usr.overlays+=usr.hair
				if (usr.Race=="Kaio")
					usr.BP_Multiplier*=1.14
				usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] activates Mystic.\n")
			else usr.Mystic_Revert()
			sleep(20)
			usr.attacking=0
mob/proc/Mystic_Revert() if(ismystic)
	src<<"You stop using mystic"
	src.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(src)] stops using Mystic.\n")
	ismystic=0
	Recovery*=0.5
	Spd/=1.5
	SpdMod/=1.5
	usr.BP_Multiplier/=1.15
	if (usr.Race=="Kaio")
		usr.BP_Multiplier/=1.14
/*
mob/proc/Eclipse_Revert() if(ismajin)
	usr.BP_Multiplier /= 2
	usr.Off /= 1.2
	usr.OffMod /= 1.2
	usr.End /= 1.2
	usr.EndMod /= 1.2
	usr.MaxAnger *= 1.2
	usr.Decline -= 10
	usr.Recovery /=2
	usr.Spd /=1.5
	usr.SpdMod /=1.5
	src<<"You stop using Eclipse"
	overlays-='Eclipse Aura.dmi'
	ismajin=0
	src.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(src)] stops using Majin.\n")
	Cancel_Transformation()
obj/Eclipse
	desc="Eclipse increases power by double, endurance, and offense by 20%, the power comes from your anger, \
	so maximum anger is decreased by 20%. It also increases decline by 10 years while in the form, \
	so if your character is old, their youth is temporarily restored significantly by using this. \
	It will also decrease, or even stop, the drain \
	of other forms you may be in. It greatly increases speed, and especially recovery. It allows you \
	to power up much faster and higher than in your regular form. But, it will also cause you to not."
	verb/Eclipse()
		set category="Skills"
		if(usr.ismystic)
			usr<<"You cant use this with Mystic"
			return
		if(!usr.attacking)
			usr.attacking=1
			if(!usr.ismajin)
				usr<<"You are now in Eclipse"
				usr.ismajin = 1
				usr.BP_Multiplier *= 2
				usr.Off *= 1.2
				usr.OffMod *= 1.2
				usr.End *= 1.2
				usr.EndMod *= 1.2
				usr.MaxAnger /= 1.2
				usr.Decline += 10
				usr.Recovery*=2
				usr.Spd*=1.5
				usr.SpdMod*=1.5
				usr.overlays-='SSj Aura.dmi'
				usr.overlays-='Elec.dmi'
				usr.overlays-='Electric_Blue.dmi'
				usr.overlays+='Eclipse Aura.dmi'
				usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] activates Majin.\n")
			else usr.Eclipse_Revert()
			sleep(20)
			usr.attacking=0
*/
obj/Majin
	desc="Majin increases power, endurance, and offense by 20%, the power comes from your anger, \
	so maximum anger is decreased by 20%. It also increases decline by 10 years while in the form, \
	so if your character is old, their youth is temporarily restored significantly by using this. \
	If you're a Demon, your power is increased instead by 75%."
	verb/Majin()
		set category="Skills"
		if(usr.ismystic)
			usr<<"You cant use this with Mystic"
			return
		if(!usr.attacking)
			usr.attacking=1
			if(!usr.ismajin)
				usr<<"You are now in majin"
				usr.ismajin = 1
				usr.BP_Multiplier *= 1.2
				usr.MaxAnger /= 1.2
				usr.Off *= 1.2
				usr.OffMod *= 1.2
				usr.End *= 1.2
				usr.EndMod *= 1.2
				usr.Decline += 10
				usr.overlays-=/obj/Auras_Special/SSJ1
				usr.overlays-=/obj/Auras_Special/LSSJ
				usr.overlays-=/obj/Auras_Special/SN
				usr.overlays-='Elec.dmi'
				usr.overlays-='Electric_Blue.dmi'
				usr.overlays+='Electric_Majin.dmi'
				if(usr.Race=="Demon")
					usr.BP_Multiplier*=1.46
				usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] activates Majin.\n")
			else usr.Majin_Revert()
			sleep(20)
			usr.attacking=0
obj/Majin_Temp
	desc="You have received a significant power boost from a demon.  This blessing will wear off after a certain amount of time."


mob/proc/Majin_Revert() if(ismajin)
	BP_Multiplier/=1.2
	MaxAnger*=1.2
	Off/=1.2
	OffMod/=1.2
	End/=1.2
	EndMod/=1.2
	Decline-=10
	src<<"You stop using majin"
	overlays-='Electric_Majin.dmi'
	ismajin=0
	if(usr.Race=="Demon")
		usr.BP_Multiplier/=1.46
	src.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(src)] stops using Majin.\n")
	Cancel_Transformation()

obj/Majinize
	var/Used
	verb/Majinize(mob/player/M in view(1))
		set category="Other"
		set src = usr.contents
		if(M.Alignment > 0)
			usr << "You're unable to touch [M]'s soul with your evil powers, their [M.AlignmentTxt] aura prevents it!"
			return
		M.Majin_By = usr.key
		alertAdmins("[key_name(usr)] has Majinized [key_name(M)].")
		if(locate(/obj/Majin) in M)
			src<<"They already have it"
			return
		for(var/obj/Mystic/A in M)
			del(A)
		M.contents += new /obj/Majin
		log_ability("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] Majinized [key_name(M)]")
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(A,10000)

obj/Mystify
	var/Used
	verb/Mystify(mob/player/M in view(1))
		set category="Other"
		set src = usr.contents
		if(M.Alignment < 0)
			usr << "You're unable to touch [M]'s soul with your good powers, their [M.AlignmentTxt] aura prevents it!"
			return
		if(locate(/obj/Mystic) in M)
			src<<"They already have it"
			return
		for(var/obj/Majin/A in M)
			del(A)
		M.contents += new/obj/Mystic
		alertAdmins("[key_name(usr)] has Mystified [key_name(M)].")
		log_ability("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] Mystified [key_name(M)]")
		usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] Mystified [key_name(M)].\n")
		M.saveToLog("| [M.client.address ? (M.client.address) : "IP not found"] | ([M.x], [M.y], [M.z]) | [key_name(M)] was Mystified by [key_name(usr)].\n")
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(A,15000)
obj/Restore_Youth
	desc="You can use this to make someone any age you want."
	verb/Restore_Youth(mob/player/M in oview(1,usr))
		set category="Skills"
		set src=usr.contents
		var/age=input("Restore them to what age? Between 0 and 20") as num
		if(!M) return
		if(!M.client) return
		if(age<0) age=0
		if(age>20) age=20
		switch(input(M,"Do you want [usr] to restore your age to [age] years?") in list("No","Yes",))
			if("Yes")
				M.Age=age
				M.Body=age
				log_ability("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has restored [key_name(M)]'s youth to [age]")
				alertAdmins("[key_name(usr)] has restored [key_name(M)]'s youth to [age]")
				usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has restored[key_name(M)]'s youth to [age].\n")
				M.saveToLog("| [M.client.address ? (M.client.address) : "IP not found"] | ([M.x], [M.y], [M.z]) | [key_name(M)]'s youth was restoryed to [age] by [key_name(usr)].\n")
			if("No")
				usr<<"[M] declined your offer."
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(A,20000)
obj/Sacred_Water
	icon='props.dmi'
	icon_state="Closed"
	desc="This raises your endurance up to a certain level, as long as it is not already above that \
	level"
	density=1
	Savable=0
	Spawn_Timer=180000
	verb/Drink()
		set category="Other"
		set src in oview(1)
		if(usr.icon_state=="KO") return
		if(icon_state!="Open")
			icon_state="Open"
			spawn(600) icon_state="Closed"
		view(usr)<<"[usr] drinks from the sacred water jar"
		for(var/mob/player/M in view(usr)) if(M.client) M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] drinks from the sacred water jar.\n")
		usr.Health-=20000/usr.End
		if(usr.End<400*usr.EndMod) usr.End=400*usr.EndMod
obj/RankChat
	verb/RankChat(A as text)
		set category="Other"
		var/msg = copytext(sanitize(A), 1, MAX_MESSAGE_LEN)
		if(!msg)	return
		for(var/mob/player/B in Players)
			if(locate(/obj/RankChat) in B)
				log_ooc("RC: [usr.name]/[usr.key] : [msg]")
				B << output("<font color=teal><font size=[B.TextSize]>(Rank)[usr.name]: [msg]","RankChat")


/*verb/Give_Power()
		set category="Skills"
		if(usr.icon_state=="KO") return
		for(var/mob/A in get_step(usr,usr.dir)) if(A.client)
			Learnable=1
			spawn(100) if(src) Learnable=0
			A.Senzu+=2
			A.Health+=usr.Health
			A.Ki+=usr.Ki
			usr.KO("giving power to [A]")*/
	/*verb/Ranks()
		set category="Other"
		usr<<browse(Ranks,"window= ;size=700x600")*/


/*obj/Take_Body
	var/hasbody
	var/oicon
	verb/Take_Body()
		set category="Skills"
		if(!hasbody)
			var/list/PeopleList=new/list
			PeopleList+="Cancel"
			for(var/mob/player/P in oview(usr)) if(P.client) PeopleList.Add(P.key)
			var/Choice=input("Take who's body?") in PeopleList
			if(Choice=="Cancel")
			else
				for(var/mob/player/M in oview(1,usr))
					if(M.key==Choice)
						if(M.Health==0&&!hasbody)
							if(M.client)
								M.client.perspective=EYE_PERSPECTIVE
								M.client.eye=usr
							hasbody=1
					//		usr.absorbadd=M.RecordPL*M.Body
							usr.Body=M.Body
							usr.hasssj=M.hasssj
							usr.hasssj2=M.hasssj2
							usr.icon=M.icon
							usr.overlays=M.overlays
							usr.underlays=M.underlays
							usr.overlays-=M.hair
							usr.overlays+='Bebi Face Stripes.dmi'
							usr.hair=M.hair
							usr.hair+=rgb(100,100,100)
							usr.overlays+=usr.hair
							usr.ssjhair=M.ssjhair
							usr.ussjhair=M.ussjhair
							usr.ssj2hair=M.ssj2hair
						//	usr.Oozarouskill=M.Oozarouskill+5
							usr.ssjmult=1.1
							usr.ssj2mult=1.1
							usr.ssjat=1
							usr.ssj2at=1
							usr.Race=M.Race
							usr.Class="Bebi"
							view(usr)<<"[usr] steals [M]'s body!"
							usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has stolen [key_name(M)]'s body. \n")
							M.saveToLog("| [M.client.address ? (M.client.address) : "IP not found"] | ([M.x], [M.y], [M.z]) | [key_name(M)]'s body has been stolen by [key_name(usr)].\n")
							log_ability("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has stolen [key_name(M)]'s body")
							alertAdmins("[key_name(usr)] has stolen [key_name(M)]'s body")
							M.loc=locate(150,150,27)
							M.BebiAbsorber=usr.name
						else usr<<"They must be knocked out."
		else
			hasbody=0
			usr<<"You give up the body you possessed."
			usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has released the body they possessed.\n")
			usr.icon=usr.oicon
			usr.overlays-=usr.overlays
			usr.underlays-=usr.underlays
			usr.hair=null
			usr.ssj=0
			usr.hasssj=0
			usr.hasssj2=0
	//		usr.Form2=0
	//		usr.Form3=0
	//		usr.Form4=0
		//	usr.absorbadd=0
			usr.Body=25-(usr.Age-usr.Decline)
			if(usr.Body>25) usr.Body=25
			usr.Class="None"
			usr.Race="Bebi"
	//		usr.absorbadd=0
			usr.overlays-='Bebi Face Stripes.dmi'
			for(var/mob/player/M) if(M.BebiAbsorber==usr.name)
				spawn M.KO()
				M << "The Bebi has left your body."
				M.client.eye = M
				M.loc=locate(usr.x-1,usr.y,usr.z)
				M.BebiAbsorber=null
*/
obj/Bebi
	var/choosing
	verb/Bebi()
		set category="Skills"
		if(!choosing)
			choosing=1
			alert("By doing this you will lose your current character and be playing as a new one who only inherits very few of your traits. Bebi's regenerate damage and lost energy both very fast. They can throw attacks one after the other at great speed. They start with very high skills already. They gain the same amount from both Meditation and Training, but unfortunately for them it is a very low amount, their sparring is normal though. Despite their training being almost useless, they make up for it because they gain power without training at all. They gain power faster than a Super Saiyan 2 but their anger is almost nonexistant. Their fighting style is highly offensive and has very low defense. Their upgrading skill will be above your own by a bit due to being able to cybernetically interface with machines, their potential to increase their skills are the same as yours though. Now as for their weaknesses, they do not progress any further in skills easily, not including energy attacks. They have low zenkai about equivalent to a Namekian. Their physical stats, strength, speed, endurance, are fairly below average, but they attack twice as fast as normal so they deal twice as much damage over time and they land hits easily due to high offense. They start with extremely high starting stats.")
			switch(input("Are you sure you want to do this?", "", text) in list ("No", "Yes",))
				if("Yes")
				//	usr.player=0
					usr.Savable=0
					var/mob/player/M=new/mob/player
					M.name=input("What do you want their name to be?") as text
					M.attackable=1
				//	M.player=1
					M.Savable=1
					M.Race="Bebi"
					M.Lungs=1
					M.Class="None"
				//	M.bursticon='Black Hole.dmi'
			//		M.burststate="full2"
			//		M.CBLASTSTATE="27"
//					M.formgain=1
					var/bicon='Bio Experiment.dmi'
					var/redd=input("How much red do you want to SUBTRACT? 0 for all of them will leave you the default grey color. +50 and -50 are the limits.") as num
					var/greenn=input("How much green?") as num
					var/bluee=input("And blue...") as num
					if(redd>50) redd=50
					if(greenn>50) greenn=50
					if(bluee>50) bluee=50
					if(redd<-50) redd=-50
					if(greenn<-50) greenn=-50
					if(bluee<-50) bluee=-50
					bicon-=rgb(redd,greenn,bluee)
					M.icon=bicon
					M.oicon=M.icon
			//		M.BLASTSTATE="27"
			//		M.Cblastpower=3
					M.InclineAge=25
					M.Decline=rand(90,110)
			//		M.refire/=2
			//		M.orefire/=2
			//		M.kinxt=-20
			//		M.kinxtadd=2 //Because of high refire.
			//		M.Makkankoicon='Makkankosappo4.dmi'
			//		M.WaveIcon='Energy Wave 1.dmi'
					M.ITMod=1
					M.Regeneration=7
					M.ZanzoMod=1
					M.Zanzoken=50
					M.KaiokenMod=0.1
					M.FlyMod=1.5
					M.FlySkill=100
				//	M.PLMod=300
				//	M.MaxPLpcnt=500
					M.MaxAnger=110
					M.KiMod=1
					M.PowMod=1
					M.StrMod=1
					M.SpdMod=1
					M.EndMod=1
					M.BirthYear=Year
					M.OffMod=2
					M.DefMod=0.5
					M.MaxKi=200
					M.Pow=100
					M.Str=100
					M.Spd=100
					M.End=100
					M.Res=100
					M.Off=200
					M.Def=50
				//	M.kimanip=3
					M.GravMod=1
				//	M.HPRegen=9
					M.Recovery=10
					M.Zenkai=0.5
				//	M.TrainMod=0.1
					M.MedMod=0.4
				//	M.SparMod=1
				//	M.RecordPL=2000000
					M.Body=5
					M.Age=0
				//	M.SAge=0
					M.GravMastered=600
					M.GravMod=1
					M.Int_Level=usr.Int_Level/2
					M.Add=usr.Add
					M.loc=usr.loc
			//		M.haszanzo=1
					//M.contents+=new/obj/Take_Body
					M.contents+=new/obj/Resources
					//The bebi kills its creator...
					M.loc=locate(usr.x,usr.y,usr.z)
					view(M)<<"Bebi: AAAARRRRAAAAAGHHHHHHHHH..."
					flick('Zanzoken.dmi',M)
					M.x=usr.x+2
					M.BebiX=usr.x
					M.BebiY=usr.y
					M.BebiZ=usr.z
					view(M)<<"The Bebi kills its creator!!"

/*
					sleep(10)
					for(var/mob/player/A in oview(usr))
						if(A.client)
							var/obj/Z=new/obj
							if(isnull(Z)) continue
							Z.icon='12.dmi'
							Z.icon_state="12"
							missile(Z,M,A)
				//			if(A.PL<M.PL) spawn(10) A.KO()
							sleep(10)
*/

					usr<<"Wait a moment."
					sleep(50)
					//-----------------------------
					log_ability("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has become a Bebi")
					alertAdmins("[key_name(usr)] has become a Bebi")
					usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has become a Bebi.\n")
					M.lastKnownKey=usr.key
					M.key=usr.key
				//	Save()
					//There is more in the Login proc past this point.
				if("No") choosing=0
/*

mob/player/var

	boostBebi_Base
	boostBebi_Strength
	boostBebi_Force
	boostBebi_Endurance
	boostBebi_Resistance
	boostBebi_Speed
	boostBebi_SpeedMod
	boostBebi_Offense
	boostBebi_Defense

	preBebi_Race

	preBebi_Class
	preBebi_icon
	preBebi_overlays
	preBebi_Hair



mob/verb/Infect()
	Teachable=0
	Level=100
	desc="Infect another person with yourself! You gain their exact stats plus a small boost for each time you've infected someone."

	verb/Infect(mob/M)
		set category="Skills"
		/*      if(usr.Infecting)
		        usr<<"You cannot use this unless you're not currently in someone's body."*/

		if(M==usr) return
		if(M.Health>=2) return

		if(usr.BebiAbsorbs<1)
			usr.BebiAbsorbs+=0.2
			if(usr.BebiAbsorbs>1){usr.BebiAbsorbs=1} // Sanity check!

//		if(usr.BebiAbsorbs>=1)
//			usr.BebiAbsorbs=1

		//STAT Boost they get
		usr.boostBebi_Base			=	M.Base 			*	(1+usr.BebiAbsorbs)
		usr.boostBebi_Strength		=	M.Strength 		*	(1+usr.BebiAbsorbs)
		usr.boostBebi_Force			=	M.Force 		*	(1+usr.BebiAbsorbs)
		usr.boostBebi_Endurance		=	M.Endurance 	*	(1+usr.BebiAbsorbs)
		usr.boostBebi_Resistance	=	M.Resistance 	*	(1+usr.BebiAbsorbs)
		usr.boostBebi_Speed			=	M.Speed 		*	(1+usr.BebiAbsorbs)
		usr.boostBebi_SpeedMod		=	M.SpeedMod 		*	(1+usr.BebiAbsorbs)
		usr.boostBebi_Offense		=	M.Offense 		*	(1+usr.BebiAbsorbs)
		usr.boostBebi_Defense		=	M.Defense 		*	(1+usr.BebiAbsorbs)

		// Backup their original race and graphics
		usr.preBebi_Race		=	M.Race

		usr.preBebi_Class		=	usr.Class
		usr.preBebi_icon		=	usr.icon // This saves their icon into their savefile, might want to consider improving this at some point.
		usr.preBebi_overlays	=	usr.overlays
		usr.preBebi_Hair		=	usr.Hair

		usr.modif_Bebi(TRUE) // Change their stats, backup mods and graphics

		//Change their mods
		usr.BaseMod			=	M.BaseMod/2
		usr.StrengthMod		=	M.StrengthMod/2
		usr.ForceMod		=	M.ForceMod/2
		usr.EnduranceMod	=	M.EnduranceMod/2
		usr.ResistanceMod	=	M.ResistanceMod/2
		usr.SpeedMod		=	M.SpeedMod/2
		usr.OffenseMod		=	M.OffenseMod/2
		usr.DefenseMod		=	M.DefenseMod/2

		//Change their race and other crap.
		usr.Race			=	M.Race

		//Spiffy graphics
		usr.Class			=	M.Class
		usr.icon			=	M.icon
		usr.overlays		=	M.overlays
		usr.Hair			=	M.Hair

		//      usr.contents+=M.contents
		M.Infected			=	1
		usr.Infecting		=	1
		usr.SetVars()

		M.loc				=	locate(487,460,13)

		M<<"You have been infected."
		usr<<"You have infected someone. Alert an admin when you switch bodies."


mob/proc/modif_Bebi(trans)

	switch(trans)
		if(TRUE)

			//Modifying their actual stats
			src.Base					=	src.boostBebi_Base
			src.Strength				=	src.boostBebi_Strength
			src.Force					=	src.boostBebi_Force
			src.Endurance				=	src.boostBebi_Endurance
			src.Resistance				=	src.boostBebi_Resistance
			src.Speed					=	src.boostBebi_Speed
			src.SpeedMod				=	src.boostBebi_SpeedMod
			src.Offense					=	src.boostBebi_Offense
			src.Defense					=	src.boostBebi_Defense

			//Mods
			src.preBebi_BaseMod			=	src.BaseMod
			src.preBebi_StrengthMod		=	src.StrengthMod
			src.preBebi_ForceMod		=	src.ForceMod
			src.preBebi_EnduranceMod	=	src.EnduranceMod
			src.preBebi_ResistanceMod	=	src.ResistanceMod
			src.preBebi_SpeedMod		=	src.SpeedMod
			src.preBebi_OffenseMod		=	src.OffenseMod
			src.preBebi_DefenseMod		=	src.DefenseMod

			//Race
			usr.preBebi_Race=M.Race

			//Spiffy graphics before bebi
			usr.preBebi_Class=M.Class
			usr.preBebi_icon=M.icon
			usr.preBebi_overlays=M.overlays
			usr.preBebi_Hair=M.Hair


		if(FALSE)

			//Undo the boost their recieved but leave other 'gained' crap intact
			src.Base					-=	src.boostBebi_Base
			src.Strength				-=	src.boostBebi_Strength
			src.Force					-=	src.boostBebi_Force
			src.Endurance				-=	src.boostBebi_Endurance
			src.Resistance				-=	src.boostBebi_Resistance
			src.Speed					-=	src.boostBebi_Speed
			src.SpeedMod				-=	src.boostBebi_SpeedMod
			src.Offense					-=	src.boostBebi_Offense
			src.Defense					-=	src.boostBebi_Defense

			//Return their mods to their original state
			src.BaseMod					=	src.preBebi_BaseMod
			src.StrengthMod				=	src.preBebi_StrengthMod
			src.ForceMod				=	src.preBebi_ForceMod
			src.EnduranceMod			=	src.preBebi_EnduranceMod
			src.ResistanceMod			=	src.preBebi_ResistanceMod
			src.SpeedMod				=	src.preBebi_SpeedMod
			src.OffenseMod				=	src.preBebi_OffenseMod
			src.DefenseMod				=	src.preBebi_DefenseMod

			// same with race and graphics
			src.Race					=	src.preBebi_Race

			src.Class					=	src.preBebi_Class
			src.icon					=	src.preBebi_icon
			src.overlays				=	src.preBebi_overlays
			src.Hair					=	src.preBebi_Hair

			// Set all their Boosted shit back to null so it doesnt needlessly waste savefile space

			usr.boostBebi_Base			=	null
			usr.boostBebi_Strength		=	null
			usr.boostBebi_Force			=	null
			usr.boostBebi_Endurance		=	null
			usr.boostBebi_Resistance	=	null
			usr.boostBebi_Speed			=	null
			usr.boostBebi_SpeedMod		=	null
			usr.boostBebi_Offense		=	null
			usr.boostBebi_Defense		=	null

			//Mod boosts
			usr.preBebi_BaseMod			=	null
			usr.preBebi_StrengthMod		=	null
			usr.preBebi_ForceMod		=	null
			usr.preBebi_EnduranceMod	=	null
			usr.preBebi_ResistanceMod	=	null
			usr.preBebi_SpeedMod		=	null
			usr.preBebi_OffenseMod		=	null
			usr.preBebi_DefenseMod		=	null

			usr.preBebi_Race			=	null

			usr.preBebi_Class			=	null
			usr.preBebi_icon			=	null
			usr.preBebi_overlays		=	null
			usr.preBebi_Hair			=	null


		else
			world << "SOMETHING DUN GON DERPED WITH BEBI. THE FUCK YOU FEEDING IT?"
			world.log << "Bebi modif_Bebi() crashed with [trans] in the switch statement instead of TRUE/FALSE"


mob/verb/Bebi_reversal()
	Teachable=0
	Level=100

//		if(usr.BebiAbsorbs>=1)
//			usr.BebiAbsorbs=1


	usr.modif_Bebi(FALSE)

//	M.Infected=1 // Up to you on how to change this if you want to keep them alive
	usr.Infecting=0

	usr.SetVars()
	usr<<"You release the body you possessed." // Like taking off a coat!

	*/