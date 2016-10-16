mob/proc/MetaLoad() //returns you from a meta to your natural body.
	for(var/mob/B) if(!istype(B,/mob/Meta)&&B.displaykey==key)
		B.metafied=0
		B.temporary=1
		B.key=key
		spawn(10) B.temporary=0

mob/Meta
	var/function
	New()
		..()
		spawn(1) Ki=MaxKi
		spawn(1) Health=100
		spawn while(!client)
			sleep(10)
			switchx=x
			switchy=y
			switchz=z
		spawn while(src)
			sleep(10)
			if(HP<=0)
				flick('MetaRepair.dmi',src)
				view(src)<<"[src] has been defeated."
				if(client) MetaLoad()
				else del(src)
	Click()
		if(!client)
			for(var/obj/Core_Computer/A) if(A.controller!=usr.key)
				usr<<"You are not the one in control of these metas."
				return
			var/list/Choices=new/list
			Choices.Add("Follow")
			Choices.Add("Stop")
			Choices.Add("Attack Target")
			Choices.Add("Attack Nearest")
			Choices.Add("Inhabit")
			Choices.Add("Destroy Meta")
			Choices.Add("Cancel")
			switch(input("Choose Option","",text) in Choices)
				if("Inhabit")
					function=0
					name=usr.name
					usr.switchx=usr.x
					usr.switchy=usr.y
					usr.switchz=usr.z
					displaykey=usr.key
					usr.metafied=1
					key=usr.key
				if("Attack Nearest")
					function=4
					spawn while(function==4)
						sleep(refire)
						for(var/mob/M in oview(12))
							if(!istype(M,/mob/Meta)&&M.client)
								var/approved=1
								for(var/obj/Core_Computer/A) if(A.controller==M.key) approved=0
								if(approved)
									if(prob(20))
										var/bcolor=BLASTICON
										bcolor+=rgb(blastR,blastG,blastB)
										var/obj/A=new/obj/attack/blast
										A.loc=locate(x,y,z)
										A.Burnout()
										A.icon=bcolor
										A.icon_state=BLASTSTATE
										A.density=1
										A.shockwave=1
										A.Pow=(Pow*5)
										A.PL=PL
										A.KiSetting=KiSet
										A.owner=src
										walk(A,dir)
									else if(prob(10)) step_rand(src)
									else step_towards(src,M)
							break
				if("Destroy Meta")
					flick('MetaRepair.dmi',src)
					del(src)
				if("Follow")
					function=1
					spawn while(function==1)
						sleep(5)
						if(prob(20)) step_rand(src)
						else step_towards(src,usr)
				if("Stop") function=2
				if("Attack Target")
					function=3
					var/list/Targets=new/list
					for(var/mob/M in oview(12)) if(M.client) Targets.Add(M)
					var/Choice=input("Attack who?") in Targets
					for(var/mob/M in oview(12)) if(Choice==M)
						spawn while(function==3)
							sleep(refire)
							if(prob(20))
								var/bcolor=BLASTICON
								bcolor+=rgb(blastR,blastG,blastB)
								var/obj/A=new/obj/attack/blast
								A.loc=locate(x,y,z)
								A.Burnout()
								A.icon=bcolor
								A.icon_state=BLASTSTATE
								A.density=1
								A.shockwave=1
								A.Pow=(Pow*5)
								A.PL=PL
								A.KiSetting=KiSet
								A.owner=src
								walk(A,dir)
							else if(prob(10)) step_rand(src)
							else step_towards(src,M)
		else usr.MetaLoad()
obj/Core_Computer
	density=1
	var/controller //who controls the star
	var/destroyed
	Click() //Lets you assimilate with the computer.
		if(!controller)
			usr<<"You have assimilated with the Geti Star, you are now in control."
			controller=usr.key
			usr.loc=locate(x,y-1,z)
			usr.dir=NORTH
			for(var/mob/Meta/A)
				if(A.client) A.MetaLoad() //for(var/mob/B) if(!istype(B,/mob/Meta)&&B.displaykey==A.key) B.key=A.key
				if(!A.client) del(A)
		else if(controller!=usr.key) usr<<"The Core does not allow you access."
		else if(controller==usr.key)
			var/list/Choices=new/list
			Choices.Add("Create Meta")
			Choices.Add("Inhabit Meta")
			Choices.Add("Observe Meta")
			Choices.Add("Destroy All Metas")
			Choices.Add("Return to Body")
			Choices.Add("Disassimilate")
			Choices.Add("Cancel")
			switch(input("Choose Option","",text) in Choices)
				if("Create Meta")
					var/mob/A=new/mob/Meta
					A.contents+=new/obj/CreateMeta
					A.temporary=1
					A.displaykey=usr.key
					A.TextSize=usr.TextSize
					A.player=1
					A.Race="Meta"
					A.spacebreather=1
					A.Class="None"
					A.attackable=1
					A.SayColor=usr.SayColor
					A.bursticon=usr.bursticon
					A.burststate=usr.burststate
					A.CBLASTICON=usr.CBLASTICON
					A.CBLASTSTATE=usr.CBLASTSTATE
					A.formgain=usr.formgain
					A.icon=usr.icon
					A.oicon=usr.oicon
					A.BLASTICON=usr.BLASTICON
					A.BLASTSTATE=usr.BLASTSTATE
					A.Cblastpower=usr.Cblastpower
					A.InclineAge=25
					A.DeclineAge=rand(90,110)
					A.refire=usr.refire
					A.orefire=usr.orefire
					A.kinxt=usr.kinxt
					A.kinxtadd=usr.kinxtadd
					A.Makkankoicon=usr.Makkankoicon
					A.WaveIcon=usr.WaveIcon
					A.ITMod=usr.ITMod
					A.healmod=usr.healmod
					A.zanzomod=usr.zanzomod
					A.zanzoskill=usr.zanzoskill+100
					A.KaiokenMod=usr.KaiokenMod
					A.flightmod=usr.flightmod
					A.flightskill=usr.flightskill
					A.PLMod=usr.PLMod
					A.MaxPLpcnt=usr.MaxPLpcnt
					A.MaxAnger=usr.MaxAnger
					A.KiMod=usr.KiMod
					A.PowMod=usr.PowMod
					A.StrMod=usr.StrMod
					A.SpdMod=usr.SpdMod
					A.EndMod=usr.EndMod
					A.BirthYear=usr.BirthYear
					A.OffenseMod=usr.OffenseMod
					A.DefenseMod=usr.DefenseMod
					A.MaxKi=usr.MaxKi
					A.Pow=usr.Pow
					A.Str=usr.Str
					A.Spd=usr.Spd
					for(var/mob/Y) if(!istype(Y,/mob/Meta)&&Y.name==usr.name) A.End=usr.End*5
					A.Res=usr.Res
					A.Offense=usr.Offense
					A.Defense=usr.Defense
					A.kimanip=usr.kimanip
					A.GravMod=usr.GravMod
					A.HPRegen=usr.HPRegen*0.1
					A.KiRegen=usr.KiRegen*0.1
					A.ZenkaiMod=usr.ZenkaiMod
					A.TrainMod=usr.TrainMod
					A.MedMod=usr.MedMod
					A.SparMod=usr.SparMod
					A.RecordPL=usr.RecordPL+400000
					A.PL=(usr.RecordPL*25)+10000000
					A.Body=25
					A.Age=usr.Age
					A.SAge=usr.SAge
					A.GravMastered=usr.GravMastered
					A.GravMod=usr.GravMod
					A.techskill=usr.techskill
					A.techmod=usr.techmod
					A.haszanzo=1
					A.Savable=0
					A.loc=locate(x,y-1,z)
					A.name="[rand(1,1000)]"
					var/icon/I=new(A.icon)
					I.Blend(rgb(50,100,200,255),ICON_MULTIPLY)
					A.icon=I
					A.oicon=I
					A.nokill=1
					for(var/obj/KiAttacks/O in usr.contents)
						var/obj/W=new O.type
						W.kilevel=O.kilevel
						W.kixp=O.kixp
						W.kinxt=O.kinxt
						W.suffix=O.suffix
						A.contents+=W
				if("Inhabit Meta")
					var/list/Metas=new/list
					for(var/mob/Meta/A) Metas.Add(A)
					var/Choice=input("Inhabit which?") in Metas
					for(var/mob/Meta/A) if(Choice==A)
						usr.metafied=1
						usr.switchx=usr.x
						usr.switchy=usr.y
						usr.switchz=usr.z
						A.name=usr.name
						A.displaykey=usr.key
						A.key=usr.key
				if("Observe Meta")
					var/list/Metas=new/list
					for(var/mob/Meta/A) Metas.Add(A)
					var/Choice=input("Observe which?") in Metas
					for(var/mob/Meta/A) if(Choice==A)
						usr.client.perspective=EYE_PERSPECTIVE
						usr.client.eye=A
				if("Destroy All Metas")
					usr.MetaLoad()
					for(var/mob/Meta/A)
						//if(A.client) for(var/mob/B) if(!istype(B,/mob/Meta)&&B.displaykey==A.key) B.key=A.key
						if(!A.client) del(A)
				if("Return to Body")
					//for(var/mob/B) if(!istype(B,/mob/Meta)&&B.displaykey==usr.key) B.key=usr.key
					usr.MetaLoad()
				if("Disassimilate")
					usr.MetaLoad()
					//for(var/mob/B) if(!istype(B,/mob/Meta)&&B.displaykey==usr.key) B.key=usr.key
					controller=null
	New()
		..()
		for(var/obj/Core_Computer/Q) if(Q!=src)
			view(src)<<"Only 1 of these may exist at once."
			del(src)
		var/image/A=image(icon='Space.dmi',icon_state="1")
		var/image/B=image(icon='Space.dmi',icon_state="2")
		var/image/C=image(icon='Space.dmi',icon_state="3")
		var/image/D=image(icon='Space.dmi',icon_state="4")
		A.pixel_y+=16
		A.pixel_x-=16
		B.pixel_y+=16
		B.pixel_x+=16
		C.pixel_y-=16
		C.pixel_x-=16
		D.pixel_y-=16
		D.pixel_x+=16
		overlays+=A
		overlays+=B
		overlays+=C
		overlays+=D
mob/proc/MetaRepair()
	overlays+='MetaRepair.dmi'
	while(Health<100|Ki<MaxKi)
		sleep(10)
		Health+=10
		Ki+=MaxKi*0.1
	overlays-='MetaRepair.dmi'
obj/CreateMeta/verb/CreateMeta()
	set category="Metas"
	var/mob/A=new/mob/Meta
	A.contents+=new/obj/CreateMeta
	A.temporary=1
	A.displaykey=usr.key
	A.TextSize=usr.TextSize
	A.player=1
	A.Race="Meta"
	A.spacebreather=1
	A.Class="None"
	A.attackable=1
	A.SayColor=usr.SayColor
	A.bursticon=usr.bursticon
	A.burststate=usr.burststate
	A.CBLASTICON=usr.CBLASTICON
	A.CBLASTSTATE=usr.CBLASTSTATE
	A.formgain=usr.formgain
	A.icon=usr.icon
	A.oicon=usr.oicon
	A.BLASTICON=usr.BLASTICON
	A.BLASTSTATE=usr.BLASTSTATE
	A.Cblastpower=usr.Cblastpower
	A.InclineAge=25
	A.DeclineAge=rand(90,110)
	A.refire=usr.refire
	A.orefire=usr.orefire
	A.kinxt=usr.kinxt
	A.kinxtadd=usr.kinxtadd
	A.Makkankoicon=usr.Makkankoicon
	A.WaveIcon=usr.WaveIcon
	A.ITMod=usr.ITMod
	A.healmod=usr.healmod
	A.zanzomod=usr.zanzomod
	A.zanzoskill=usr.zanzoskill+100
	A.KaiokenMod=usr.KaiokenMod
	A.flightmod=usr.flightmod
	A.flightskill=usr.flightskill
	A.PLMod=usr.PLMod
	A.MaxPLpcnt=usr.MaxPLpcnt
	A.MaxAnger=usr.MaxAnger
	A.KiMod=usr.KiMod
	A.PowMod=usr.PowMod
	A.StrMod=usr.StrMod
	A.SpdMod=usr.SpdMod
	A.EndMod=usr.EndMod
	A.BirthYear=usr.BirthYear
	A.OffenseMod=usr.OffenseMod
	A.DefenseMod=usr.DefenseMod
	A.MaxKi=usr.MaxKi
	A.Pow=usr.Pow
	A.Str=usr.Str
	A.Spd=usr.Spd
	for(var/mob/Y) if(!istype(Y,/mob/Meta)&&Y.name==usr.name) A.End=usr.End*5
	A.Res=usr.Res
	A.Offense=usr.Offense
	A.Defense=usr.Defense
	A.kimanip=usr.kimanip
	A.GravMod=usr.GravMod
	A.HPRegen=usr.HPRegen*0.1
	A.KiRegen=usr.KiRegen*0.1
	A.ZenkaiMod=usr.ZenkaiMod
	A.TrainMod=usr.TrainMod
	A.MedMod=usr.MedMod
	A.SparMod=usr.SparMod
	A.RecordPL=usr.RecordPL+400000
	A.PL=(usr.RecordPL*25)+10000000
	A.Body=25
	A.Age=usr.Age
	A.SAge=usr.SAge
	A.GravMastered=usr.GravMastered
	A.GravMod=usr.GravMod
	A.techskill=usr.techskill
	A.techmod=usr.techmod
	A.haszanzo=1
	A.Savable=0
	A.loc=locate(usr.x,usr.y-1,usr.z)
	A.name="[rand(1,1000)]"
	var/icon/I=new(A.icon)
	I.Blend(rgb(50,100,200,255),ICON_MULTIPLY)
	A.icon=I
	A.oicon=I
	for(var/obj/KiAttacks/O in usr.contents)
		var/obj/W=new O.type
		W.kilevel=O.kilevel
		W.kixp=O.kixp
		W.kinxt=O.kinxt
		W.suffix=O.suffix
		A.contents+=W