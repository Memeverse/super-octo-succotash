mob/proc/Customize_Form_1() switch(input("Customize 1st form icon?") in list("No","Yes"))
	if("Yes") Form1Icon=input("Choose icon") as file
mob/proc/Customize_Form_2() switch(input("Customize 2nd form icon?") in list("No","Yes"))
	if("Yes") Form2Icon=input("Choose icon") as file
mob/proc/Customize_Form_3() switch(input("Customize 3rd form icon?") in list("No","Yes"))
	if("Yes") Form3Icon=input("Choose icon") as file
mob/proc/Customize_Form_4() switch(input("Customize 4th form icon?") in list("No","Yes"))
	if("Yes") Form4Icon=input("Choose icon") as file
mob/proc/Customize_Form_5() switch(input("Customize expand form icon?") in list("No","Yes"))
	if("Yes")
		Form5Icon=input("Choose icon") as file;Form6Icon=Form5Icon;Form7Icon=Form5Icon;Form8Icon=Form5Icon
mob/verb/Customize()
	set category="Other"
	if(Race=="Changeling")
		switch(input("Do you want to have custom icons for your changeling forms?") in list("No","Yes"))
			if("Yes")
				Customize_Form_1()
				Customize_Form_2()
				Customize_Form_3()
				Customize_Form_4()
				Customize_Form_5()
				return
	overlays.Remove(BlastCharge,Aura)
	underlays-=SSj4Aura
	/*switch(input("What do you want to customize?") in list("Charge Icon","Aura Icon","Blast Icons"))
		if("Aura Icon") for(var/A in typesof(/obj/Auras)) if(A!=/obj/Auras) usr.contents+=new A
		if("Charge Icon") for(var/A in typesof(/obj/Charges)) if(A!=/obj/Charges) usr.contents+=new A
		if("Blast Icons") contents+=new/obj/Blasts
	Tabs=10
	src<<"Go to an icon you wish to use in the tabs. You can colorize it any way you want by right \
	clicking it. You can also restore it to default color the same way, so you can then recolorize it. \
	When your done, you can apply it to your character by clicking it. The tab will then disappear."*/

	if(Tabs!=10)
		//client.show_verb_panel=0
		for(var/A in typesof(/obj/Auras)) if(A!=/obj/Auras) contents+=new A
		for(var/A in typesof(/obj/Charges)) if(A!=/obj/Charges) contents+=new A
		for(var/A in typesof(/obj/Blasts)) if(A!=/obj/Blasts) contents+=new A
		Tabs=10
		src<<"Tabs have opened to allow you to customize yourself. When finished hit the customize verb again."
	else
		//client.show_verb_panel=1
		for(var/obj/Auras/A in src) del(A)
		for(var/obj/Charges/A in src) del(A)
		for(var/obj/Blasts/A in src) del(A)
		Tabs=1
//var/list/Blasts=new
//proc/AddBlasts() for(var/A in typesof(/obj/Blasts)) if(A!=/obj/Blasts) Blasts+=new A
obj/Blasts
	icon_state="head"
	Click()
		var/list/C=new
		for(var/obj/Attacks/D in usr) if(D.type!=/obj/Attacks/Time_Freeze) C+=D
		//usr.Tabs=1
		var/obj/Attacks/A=input("Give this icon to which attack?") in C
		if(A) A.icon=image(icon=icon,icon_state=icon_state)
		usr<<"[src] Chosen"
		//for(var/obj/Blasts/B in usr) del(B)
		//for(var/obj/Blasts/B in Blasts) B.icon=initial(B.icon)
	verb/Adjust_Color()
		set src in world
		var/A=input("Choose a color") as color|null
		if(A) icon+=A
	verb/Default_Color()
		set src in world
		icon=initial(icon)
	Blast1 icon='1.dmi'
	Blast2 icon='2.dmi'
	Blast3 icon='3.dmi'
	Blast4 icon='4.dmi'
	Blast5 icon='5.dmi'
	Blast6 icon='6.dmi'
	Blast7 icon='7.dmi'
	Blast8 icon='8.dmi'
	Blast9 icon='9.dmi'
	Blast10 icon='10.dmi'
	Blast11 icon='11.dmi'
	Blast12 icon='12.dmi'
	Blast13 icon='13.dmi'
	Blast14 icon='14.dmi'
	Blast15 icon='15.dmi'
	Blast16 icon='16.dmi'
	Blast17 icon='17.dmi'
	Blast18 icon='18.dmi'
	Blast19 icon='19.dmi'
	Blast20 icon='20.dmi'
	Blast21 icon='21.dmi'
	Blast22 icon='22.dmi'
	Blast23 icon='23.dmi'
	Blast24 icon='24.dmi'
	Blast25 icon='25.dmi'
	Blast26 icon='26.dmi'
	Blast27 icon='27.dmi'
	Blast28 icon='28.dmi'
	Blast29 icon='29.dmi'
	Blast30 icon='30.dmi'
	Blast31 icon='31.dmi'
	Blast32 icon='32.dmi'
	Blast33 icon='33.dmi'
	Blast34 icon='34.dmi'
	Blast35 icon='35.dmi'
	Blast36 icon='36.dmi'
	Blast37 icon='37.dmi'
	Blast38 icon='Blast - Destructo Disk.dmi'
	Blast39 icon='Blast - Dual Fire Blast.dmi'
	Blast40 icon='Blast - Ki Shuriken.dmi'
	Blast41 icon='holybolt.dmi'
	Beam1 icon='Beam1.dmi'
	Beam2 icon='Beam2.dmi'
	Beam3 icon='Beam3.dmi'
	Beam4 icon='Beam4.dmi'
	Beam5 icon='Beam5.dmi'
	Beam6 icon='Beam6.dmi'
	Beam8 icon='Beam8.dmi'
	Beam9 icon='Beam9.dmi'
	Beam10 icon='Beam10.dmi'
	Beam11 icon='Beam11.dmi'
	Piercer icon='Makkankosappo.dmi'
	Beam12 icon='Beam12.dmi'
	Beam13 icon='Beam - Kamehameha.dmi'
	Beam14 icon='Beam - Static Beam.dmi'
	Beam15 icon='Beam - Multi-Beam.dmi'
obj/Auras
	Click()
		usr.Aura=image(icon=icon,icon_state=icon_state)
		usr<<"[src] Chosen"
		//usr.Tabs=1
		//for(var/obj/Auras/A in usr) if(A!=src) del(A)
		//del(src)
	verb/Adjust_Color()
		var/A=input("Choose a color") as color|null
		if(A) icon+=A
		usr.SSj4Aura='Aura SSj4.dmi'
		if(A) usr.SSj4Aura+=A
		usr.FlightAura='Aura Fly.dmi'
		if(A) usr.FlightAura+=A
	verb/Default_Color() icon=initial(icon)
	None
	Sparks icon='AbsorbSparks.dmi'
	Electric icon='Aura, Bloo.dmi'
	Electric_2 icon='Aura Electric.dmi'
	Default icon='Aura.dmi'
	Flowing icon='Aura Normal.dmi'
	Demon_Flame icon='Black Demonflame.dmi'
	Vampire_Aura icon='Aura 2.dmi'
	Electric_3 icon='ElecAura3.dmi'
	Electric_4 icon='Elec Aura1.dmi'
obj/Charges
	icon='BlastCharges.dmi'
	Click()
		usr.BlastCharge=image(icon=icon,icon_state=icon_state)
		usr<<"[src] Chosen"
		//usr.Tabs=1
		//for(var/obj/Charges/A in usr) if(A!=src) del(A)
		//del(src)
	verb/Adjust_Color()
		var/A=input("Choose a color") as color|null
		if(A) icon+=A
	verb/Default_Color() icon=initial(icon)
	Charge1 icon_state="1"
	Charge2 icon_state="2"
	Charge3 icon_state="3"
	Charge4 icon_state="4"
	Charge5 icon_state="5"
	Charge6 icon_state="6"
	Charge7 icon_state="7"
	Charge8 icon_state="8"
	Charge9 icon_state="9"

obj/Attacks/var
	Power=1 //Damage multiplier
	Explosive=0
	Shockwave=0
	Paralysis=0
	Scatter=0 //A barrage effect
	Fatal=1 //Certain attacks may not be capable of killing
atom/var
	Experience=0 //Also how many times a mob has entered the HBTC
	Add=1
	Level=1
	//tmp/mob/Belongs_To
	tmp/mob/Belongs_To
	Password
	tmp/mob/Target
	Weight=1
	Health=500
	Savable=1
	Builder
obj/Attacks/Blast
	Fatal=1
	Difficulty=1
	Experience=1
	var/Spread=1
	icon='1.dmi'
	desc="An attack that becomes more rapid as your skill with it develops"
	verb/Settings()
		set category="Other"
		Spread=input("This allows you to choose the spread level of the Blast ability. Between \
		1 and 4 tiles. The more spread the less accuracy.") as num
		if(Spread<1) Spread=1
		if(Spread>4) Spread=4
		Spread=round(Spread)
		switch(input("Do you want your blasts to knock away the people they hit?") in list("Yes","No"))
			if("Yes") Shockwave=1
			if("No") Shockwave=0
	verb/Blast()
		set category="Skills"
	//	usr.Learn_Attack()
		if((usr.icon_state in list("Meditate","Train","KO","KB"))||usr.Frozen) return
		var/Ki_Use=1
	//	usr.kimanip+=(0.01*usr.kimanipmod)
		if(Spread>1)
			Ki_Use*=9*Spread
		if(usr.attacking||usr.Ki<Ki_Use) return
		if(!Learnable)
			Learnable=1
			spawn(100) Learnable=0
		usr.Ki-=Ki_Use
		usr.attacking=3
		var/Delay=300/Experience/usr.SpdMod
		if(Delay<1) Delay=1
		spawn(Delay) usr.attacking=0
		Experience+=0.05
		var/Amount=1
		if(Spread==2) Amount=2   // spread 2  amount 3
		if(Spread==3) Amount=4   // spread 3  amount 5
		if(Spread==4) Amount=6   //spread 4   amount 7
		//Space inertia
		//Lower probability then the 100% guarantee beams give you
		if(istype(src.loc, /turf/Other/Stars) && prob(Amount*10))	//Blasts are a viable travel method right
			src.inertia_dir = reverseDir(dir2text(src.dir))
			var/turf/T = get_step(src, src.inertia_dir)
			if(!T.density) step(src, src.inertia_dir)
		while(Amount)
			var/obj/Blast/A=new
			A.Belongs_To=usr
			A.pixel_x=rand(-16,16)
			A.pixel_y=rand(-16,16)
			A.icon=icon
			A.Damage=3*usr.BP*usr.Pow*Ki_Power  //200
			A.Power=3*usr.BP*Ki_Power			//200
			A.Offense=usr.Off
			A.Shockwave=Shockwave
			A.dir=usr.dir
			A.loc=usr.loc
			if(!A)
				return
			switch(Amount)
				if(7)
					if(A) step(A,turn(A.dir,45))
					if(A) step(A,A.dir)
					if(A) step(A,A.dir)
					spawn(1) if(A) walk(A,usr.dir)
				if(6)
					if(A) step(A,turn(A.dir,-45))
					if(A) step(A,A.dir)
					if(A) step(A,A.dir)
					spawn(1) if(A) walk(A,usr.dir)
				if(5)
					if(A) step(A,turn(A.dir,45))
					if(A) step(A,A.dir)
					spawn(1) if(A) walk(A,usr.dir)
				if(4)
					if(A) step(A,turn(A.dir,-45))
					if(A) step(A,A.dir)
					spawn(1) if(A) walk(A,usr.dir)
				if(3)
					if(A) step(A,turn(A.dir,pick(-45,45)))
					spawn(1) if(A) walk(A,usr.dir)
				if(2)
					if(A) step(A,turn(A.dir,pick(-45,45)))
					spawn(2) if(A) walk(A,usr.dir)
				else walk(A,A.dir)
			Amount-=1
obj/Attacks/Charge
	Fatal=1
	Difficulty=2
	Level=0
	Experience=0.1
	icon='20.dmi'
	desc="An explosive one-shot energy attack that takes a few seconds to charge. With training its \
	explosiveness and refire speed can increase."
	verb/Charge()
		set category="Skills"
		if(Level>1) Level=1
		if((usr.icon_state in list("Meditate","Train","KO","KB"))||usr.Frozen) return
		if(usr.attacking|usr.Ki<20) return
		if(!Learnable)
			Learnable=1
			spawn(100) Learnable=0
		if(prob(10)&&Level<1) Level++
		if(prob(10)&&Experience<1) Experience+=0.1
		usr.Ki-=20
		usr.attacking=3
		charging=1
		usr.overlays+=usr.BlastCharge
		sleep(160/usr.SpdMod)
		usr.overlays-=usr.BlastCharge
		var/obj/Blast/A=new
		A.Belongs_To=usr
		A.icon=icon
		A.Damage=20*usr.BP*usr.Pow*Ki_Power  //200
		A.Power=20*usr.BP*Ki_Power   //200
		A.Offense=usr.Off
		A.Explosive=Level
		A.dir=usr.dir
		A.loc=usr.loc
		step(A,A.dir)
		if(A) walk(A,A.dir,2)
		usr.attacking=0
		charging=0
obj/Attacks/Kienzan
	Fatal=1
	Difficulty=2
	Level=0
	Experience=1
	icon='Blast - Destructo Disk.dmi'
	desc="This attack is much like Charge at its core with some differences. Kienzan takes longer to \
	charge, is completely undeflectable, has a higher velocity, it is slightly more powerful than Charge, it also \
	drains much more energy to use."
	verb/Kienzan()
		set category="Skills"
		if(Level>1) Level=1
		if((usr.icon_state in list("Meditate","Train","KO","KB"))||usr.Frozen) return
		if(usr.attacking|usr.Ki<160) return
		if(!Learnable)
			Learnable=1
			spawn(100) Learnable=0
		if(prob(10)&&Level<1) Level++
		if(prob(10)&&Experience<1) Experience+=0.1
		usr.Ki-=160
		usr.attacking=3
		charging=1
		var/image/O=image(icon=icon,pixel_y=24)
		usr.overlays+=O
		sleep(240/usr.SpdMod/Experience)
		usr.overlays-=O
		var/obj/Blast/A=new
		A.Deflectable=0
		A.Belongs_To=usr
		A.icon=icon
		A.Damage=250*usr.BP*usr.Pow*Ki_Power
		A.Power=250*usr.BP*Ki_Power
		A.Offense=usr.Off
		A.Explosive=Level
		A.dir=usr.dir
		A.loc=usr.loc
		step(A,A.dir)
		if(A) walk(A,A.dir,1)
		usr.attacking=0
		charging=0
obj/Attacks/Spin_Blast
	Fatal=1
	Difficulty=1
	Experience=1
	icon='1.dmi'
	desc="An attack that becomes more rapid as your skill with it develops, and shoots in multiple \
	directions easily."
	verb/SpinBlast()
		set category="Skills"
		if((usr.icon_state in list("Meditate","Train","KO","KB"))||usr.Frozen) return
		if(usr.attacking|usr.Ki<1) return
		if(!Learnable)
			Learnable=1
			spawn(100) Learnable=0
		usr.Ki-=1
		if(prob(50))
			usr.attacking=3
			var/Delay=100/Experience/usr.SpdMod
			if(Delay<1) Delay=1
			spawn(Delay) usr.attacking=0
		Experience+=0.01
		var/obj/Blast/A=new
		A.Belongs_To=usr
		A.pixel_x=rand(-16,16)
		A.pixel_y=rand(-16,16)
		A.icon=icon
		A.Damage=4*usr.BP*usr.Pow*Ki_Power
		A.Power=4*usr.BP*Ki_Power
		A.Offense=usr.Off
		A.Shockwave=Shockwave
		A.Explosive=0
		A.dir=usr.dir
		A.loc=usr.loc
		usr.dir=turn(usr.dir,45)
		walk(A,A.dir)
		if(prob(20)) sleep(1)
		if(prob(67))
			if(A) step(A,turn(A.dir,pick(-45,0,45)))
			if(A) walk(A,pick(A.dir,turn(A.dir,45),turn(A.dir,-45)))
obj/Attacks/Makosen
	Fatal=1
	Difficulty=50
	var/Spread=1
	var/ChargeTime=50
	var/Shots=200
	var/ShotSpeed=1
	var/SleepProb=5
	var/Deletion=8
	var/ExplosiveChance=0
	var/Explosiveness=1
	icon='27.dmi'
	desc="A very, very powerful attack, widespread and very destructive. Made up of many smaller shots \
	that inflict a lot of damage all together. It is very draining, not very long range, and has a \
	long charge time."
	verb/Makosen()
		set category="Skills"
		if((usr.icon_state in list("Meditate","Train","KO","KB"))||usr.Frozen) return
		if(usr.attacking|usr.Ki<1000) return
		if(!Learnable)
			Learnable=1
			spawn(100) Learnable=0
		usr.Ki-=1000
		usr.attacking=3
		usr.overlays+=usr.BlastCharge
		sleep(ChargeTime/usr.SpdMod)
		usr.overlays-=usr.BlastCharge
		var/Amount=Shots
		while(Amount)
			Amount-=1
			var/obj/Blast/A=new
			A.Belongs_To=usr
			A.icon=icon
			A.layer=4
			A.Damage=5*usr.BP*usr.Pow*Ki_Power
			A.Power=5*usr.BP*Ki_Power
			A.Offense=usr.Off
			if(prob(ExplosiveChance)) A.Explosive=Explosiveness
			A.dir=usr.dir
			A.pixel_x=rand(-16,16)
			A.pixel_y=rand(-16,16)
			A.loc=get_step(usr,usr.dir)
			spawn if(A) A.Beam()
			spawn(1) if(A)
				walk(A,usr.dir,ShotSpeed)
				if(A) A.Zig_Zag(Spread,ShotSpeed)
			spawn(Deletion) if(A) del(A)
			if(prob(SleepProb)) sleep(1)
		usr.attacking=0
obj/Blast/proc/Zig_Zag(B,Z) while(src)
	var/A=dir
	var/C=B
	density=0
	while(C)
		step_rand(src)
		C-=1
	density=1
	dir=A
	sleep(Z)
obj/Attacks/Kikoho
	Fatal=1
	Difficulty=10
	icon='16.dmi'
	desc="Similar to the charge attack, but much more powerful because it drains health and energy \
	to use it. A very strong attack. If you let it drain all your health, there is a chance you may die."
	verb/Kikoho()
		set category="Skills"
		if((usr.icon_state in list("Meditate","Train","KO","KB"))||usr.Frozen) return
		if(usr.attacking|usr.Ki<20) return
		if(!Learnable)
			Learnable=1
			spawn(100) Learnable=0
		usr.Ki-=20
		usr.Health-=20
		usr.attacking=3
		charging=1
		usr.overlays+=usr.BlastCharge
		sleep(50/usr.SpdMod)
		usr.overlays-=usr.BlastCharge
		var/obj/Blast/Kikoho/A=new(get_step(src,usr.dir))
		A.loc=get_step(A,usr.dir)
		A.Belongs_To=usr
		A.Damage=250*usr.BP*usr.Pow*Ki_Power
		A.Power=250*usr.BP*Ki_Power
		A.Offense=usr.Off
		walk(A,usr.dir,2)
		usr.attacking=0
		charging=0
		spawn(100) if(usr.Health<0&&prob(10)) usr.Death(usr)
obj/Blast/Kikoho
	Piercer=0
	Explosive=1
	density=1
	New()
		var/Icon='deathball.dmi'
		Icon+=rgb(200,200,100,120)
		var/image/A=image(icon=Icon,icon_state="1",pixel_x=-16,pixel_y=-16,layer=5)
		var/image/B=image(icon=Icon,icon_state="2",pixel_x=16,pixel_y=-16,layer=5)
		var/image/C=image(icon=Icon,icon_state="3",pixel_x=-16,pixel_y=16,layer=5)
		var/image/D=image(icon=Icon,icon_state="4",pixel_x=16,pixel_y=16,layer=5)
		overlays.Remove(A,B,C,D)
		overlays.Add(A,B,C,D)
		//..()
	Move()
		for(var/atom/A in orange(1,src)) if(A!=src&&A.density&&!isarea(A)) Bump(A)
		if(src) ..()

obj/Attacks/Time_Freeze
	desc="This will send paralyzing energy rings all around nearby people and they will not be able \
	to move until it wears off. The more powerful you are compared to your Opp, the longer the \
	effect will last on them."
	verb/Time_Freeze()
		set category="Skills"
		if(usr.Frozen||usr.icon_state=="KO") return
		usr.overlays-='TimeFreeze.dmi'
		usr.overlays+='TimeFreeze.dmi'
		spawn(10) usr.overlays-='TimeFreeze.dmi'
		for(var/mob/A in oview(usr)) if(!A.Frozen&&A.client)
			sleep(10)
			usr.Ki*=0.5
			A.Frozen=1
			missile('TimeFreeze.dmi',usr,A)
			A.overlays-='TimeFreeze.dmi'
			A.overlays+='TimeFreeze.dmi'
obj/Attacks
	var/On
	desc="This attack causes an explosion on the ground, the more you use it the bigger the explosion"
	Explosion
		Difficulty=2
		Experience=0
		Level=0
		verb/Settings()
			var/Max=Experience
			if(Max>4) Max=4
			usr<<"This will increase the explosion radius. Current is [Level]. Minimum is 0. Max is [Max]"
			Level=input("") as num
			if(Level<0) Level=0
			if(Level>Max) Level=Max
		verb/Explosion()
			set category="Skills"
			if(!On)
				usr<<"Explosion activated, click the ground to trigger."
				usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] activated explosion.<br>")
				On=1
				usr.Warp=0
			else
				usr<<"Explosion deactivated."
				usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] deactivated explosion.<br>")
				On=0
				usr.Warp=1
obj/Attacks/Homing_Finisher
	Difficulty=10
	icon='17.dmi'
	desc="This will create multiple homing balls all around an Opp, and when its done they will \
	all collide at once on top of them. Individually each ball is weak, but all together it can be \
	extremely devastating to most people. The more energy you get the more balls you can make at once. \
	Use the Settings verb to change how many balls to make, between 1 and your max."
	var/Setting=10
	verb/Settings()
		Setting=input("Input the amount of blasts you want created when you use this attack. Default is [initial(Setting)]. You can fire [round(usr.MaxKi/20)] max") as num
		if(Setting<1) Setting=1
		if(Setting>usr.MaxKi/20) Setting=round(usr.MaxKi/20)
	verb/Scatter_Shot()
		set category="Skills"
		if((usr.icon_state in list("Meditate","Train","KO","KB"))||usr.Frozen) return
		if(!usr.move|usr.attacking|usr.Ki<20*Setting) return
		usr.attacking=3
		var/mob/B=input("Choose a target") as mob in orange(usr,100)
		Learnable=1
		spawn(100)
			Learnable=0
		usr.Ki-=20*Setting
		var/amount=Setting
		var/list/spawnArea = oview(usr,8)
		if(!length(spawnArea))
			usr.attacking=0
			return
		while(amount&&usr.icon_state!="KO"&&(B.z==usr.z))
			sleep(1)
			spawnArea = oview(usr,8)
			for(var/i=0, i<5, i++)
				if(!amount)
					break
				amount-=1
				flick("Blast",usr)
				var/obj/Blast/A=new
				A.density=0
				A.Belongs_To=usr
				A.icon=icon
				switch(usr.Race)
					if("Half-Saiyan" || "Saiyan" || "Quarter Saiyan" || "1/16 Saiyan")
						A.icon += rgb(rand(75,155),0,0)
					if("Android")
						A.icon += rgb(155,155,155)
					if("Majin")
						A.icon += rgb(155,0,155)
					if("Bio-Android")
						A.icon += rgb(rand(25,75),0,rand(25,75))
					if("Demigod")
						A.icon -= rgb(45,45,45)
					if("Kaio")
						A.icon += rgb(0,0,75)
					if("Namekian")
						A.icon += rgb(0,rand(75,155),0)
					if("Changeling")
						A.icon += rgb(45,0,0)
						A.icon -= rgb(0,45,45)
					if("Demon")
						A.icon -= rgb(100,100,100)
					if("Mutant")
						A.icon += rgb(rand(0,55),rand(0,55),rand(0,55))
				var/turf/pick = pick(spawnArea)
				A.loc = pick
				spawnArea -= pick
				if(prob(20))
					A.Explosive=1
				A.Shockwave=1
				A.Damage=usr.BP*usr.Pow*5*Ki_Power
				A.Power=5*usr.BP*Ki_Power
				A.Offense=usr.Off

				if(A)
					A.dir=pick(alldirs)

				spawn(rand(90,110)/usr.SpdMod)
					if(A)
						A.density=1
						if(B)
							walk_towards(A,B)
		usr.attacking=0

obj/Attacks/Sokidan
	Difficulty=5
	icon='17.dmi'
	desc="This makes a very powerful guided bomb of energy that explodes on contact. If you can get it \
	to actually hit someone it is a very nice attack. It will move faster and faster as you master it."
	var/Sokidan_Delay=50
	verb/Sokidan()
		set category="Skills"
		if((usr.icon_state in list("Meditate","Train","KO","KB"))||usr.Frozen) return
		if(!usr.move|usr.attacking|usr.Ki<50) return
		Using=1
		usr.attacking=3
		usr.Ki-=50
		if(Sokidan_Delay>2) Sokidan_Delay-=1
		var/obj/Blast/A=new
		A.Sokidan=1
		A.Belongs_To=usr
		A.icon=icon
		A.loc=get_step(usr,NORTH)
		A.Explosive=1
		A.Shockwave=1
		A.Piercer=0
		A.Damage=usr.BP*usr.Pow*100*Ki_Power
		A.Power=100*usr.BP*Ki_Power
		A.Offense=usr.Off
		sleep(100/usr.SpdMod)
		if(A)
			A.density=0
			flick("Blast",usr)
			spawn(100) if(usr)
				usr.attacking=0
				Using=0
			while(A&&usr)
				Using=1
				step(A,usr.dir)
				if(A) A.density=1
				sleep(Sokidan_Delay)
		Using=0
obj/Attacks/Genocide
	var/Charging
	Difficulty=10
	icon='18.dmi'
	desc="This is a very weak attack, but it homes in on random targets across the planet. You can \
	press it once to begin firing, and you can press it again to stop or wait til you run out of \
	energy. It drains a lot of energy to use."
	verb/Genocide()
		set category="Skills"
		if(Charging)
			Charging=0
		else if(!Charging)
			if((usr.icon_state in list("Meditate","Train","KO","KB"))||usr.Frozen) return
			if(usr.attacking|usr.Ki<10) return
			Charging=1
			usr.overlays+='SBombGivePower.dmi'
			usr.attacking=3
			sleep(100/usr.Refire)
			var/list/Peoples=new
			for(var/mob/Z)
				if(Z.z==usr.z&&Z!=usr)
					if(Z.real_name || istype(Z, /mob/player)|| istype(Z, /NPC_AI))	//no punching bags lol
						Peoples+=Z
			while(Charging&&usr.icon_state!="KO"&&usr.Ki>10)
				for(var/mob/B in Peoples)
					var/obj/Blast/A=new
					A.Belongs_To=usr
					A.icon=icon
					A.Damage=2*usr.BP*usr.Pow*Ki_Power
					A.Power=2*usr.BP*Ki_Power
					A.Offense=usr.Off
					A.loc=usr.loc
					A.dir=NORTH
					walk_towards(A,B)
					sleep(2)
				usr.Ki-=10
				sleep(rand(1,5))
			usr.overlays-='SBombGivePower.dmi'
			usr.attacking=0
			Charging=0
		else Charging=0
obj/Crater
	icon='Craters.dmi'
	icon_state="small crater"
	Health=1.#INF
	Grabbable=0
	Shockwaveable=0
	New()
		for(var/obj/Crater/A in range(0,src)) if(A!=src) del(A)
		spawn(6000) if(src) del(src)
		//..()
obj/BigCrater
	icon='Craters.dmi'
	icon_state="Center"
	Health=1.#INF
	Grabbable=0
	Savable=0
	Shockwaveable=0
	New()
		if(src.z==0) del(src)
		for(var/obj/BigCrater/A in view(3,src)) if(A!=src) del(src)
		var/image/A=image(icon='Craters.dmi',icon_state="N",pixel_y=32)
		var/image/B=image(icon='Craters.dmi',icon_state="S",pixel_y=-32)
		var/image/C=image(icon='Craters.dmi',icon_state="E",pixel_x=32)
		var/image/D=image(icon='Craters.dmi',icon_state="W",pixel_x=-32)
		var/image/E=image(icon='Craters.dmi',icon_state="NE",pixel_y=32,pixel_x=32)
		var/image/F=image(icon='Craters.dmi',icon_state="NW",pixel_y=32,pixel_x=-32)
		var/image/G=image(icon='Craters.dmi',icon_state="SE",pixel_y=-32,pixel_x=32)
		var/image/H=image(icon='Craters.dmi',icon_state="SW",pixel_y=-32,pixel_x=-32)
		overlays.Remove(A,B,C,D,E,F,G,H)
		overlays.Add(A,B,C,D,E,F,G,H)
		spawn(6000) if(src) del(src)
		//..()
obj/Blast/Genki_Dama
	Piercer=0
	Explosive=1
	density=1
	Sokidan=1
	var/Size
	New()
		spawn if(src) Health=Damage
	proc/Medium(Icon,X,Y,Z,T)
		Icon+=rgb(X,Y,Z,T)
		var/image/A=image(icon=Icon,icon_state="1",pixel_x=-16,pixel_y=-16,layer=5)
		var/image/B=image(icon=Icon,icon_state="2",pixel_x=16,pixel_y=-16,layer=5)
		var/image/C=image(icon=Icon,icon_state="3",pixel_x=-16,pixel_y=16,layer=5)
		var/image/D=image(icon=Icon,icon_state="4",pixel_x=16,pixel_y=16,layer=5)
		overlays.Add(A,B,C,D)
	proc/Large(Icon,X,Y,Z,T)
		Icon+=rgb(X,Y,Z,T)
		var/image/A=image(icon=Icon,icon_state="1",pixel_x=-32,pixel_y=-32,layer=5)
		var/image/B=image(icon=Icon,icon_state="2",pixel_x=0,pixel_y=-32,layer=5)
		var/image/C=image(icon=Icon,icon_state="3",pixel_x=32,pixel_y=-32,layer=5)
		var/image/D=image(icon=Icon,icon_state="4",pixel_x=-32,pixel_y=0,layer=5)
		var/image/E=image(icon=Icon,icon_state="5",pixel_x=0,pixel_y=0,layer=5)
		var/image/F=image(icon=Icon,icon_state="6",pixel_x=32,pixel_y=0,layer=5)
		var/image/G=image(icon=Icon,icon_state="7",pixel_x=-32,pixel_y=32,layer=5)
		var/image/H=image(icon=Icon,icon_state="8",pixel_x=0,pixel_y=32,layer=5)
		var/image/I=image(icon=Icon,icon_state="9",pixel_x=32,pixel_y=32,layer=5)
		overlays.Add(A,B,C,D,E,F,G,H,I)
	Move()
		var/Distance=0
		if(Size) Distance=Size
		for(var/atom/A in orange(Distance,src)) if(A!=src&&A.density&&!isarea(A)) Bump(A)
		if(src) ..()
obj/Attacks/Genki_Dama
	desc="This is perhaps the most powerful 1-hit attack in existance. You press it once to begin \
	gathering the energy. When it is done gathering energy, a ball of charged energy appears at your \
	hand. Once that is done, you can then press it again to release the genki dama, which is \
	somewhere above your character, and you will have to guide it to its target, much like sokidan. \
	It is somewhat masterable, you can decrease the time it takes to charge it by using it, \
	but even at maximum charge rate, it charges pretty slow compared to other attacks. This move is \
	extremely deadly, so do not use it on someone because it may kill them in a single hit."
	var/IsCharged
	var/Mode="Small"
	KiReq=1000
	verb/Settings()
		set category="Other"
		switch(input("Choose a size. It will affect the power and speed in different ways.") in \
		list("Small","Medium","Large"))
			if("Small") Mode="Small"
			if("Medium") Mode="Medium"
			if("Large") Mode="Large"
	verb/Genki_Dama()
		set category="Skills"
		if((usr.icon_state in list("Meditate","Train","KO","KB"))||usr.Frozen) return
		if(usr.attacking|usr.Ki<KiReq|charging) return
		if(!IsCharged)
			var/obj/Blast/Genki_Dama/A=new(usr.loc)
			A.y+=10
			if(!A||!A.z) return
			A.Belongs_To=usr
			A.Damage=250*usr.BP*usr.Pow*Ki_Power
			A.Power=250*usr.BP*Ki_Power
			A.Offense=usr.Off
			if(Mode=="Small") A.icon='SBomb.dmi'
			if(Mode=="Medium")
				A.Size=1
				A.Damage*=2
				A.Power*=2
				A.Explosive=2
				A.Medium('deathball.dmi',100,200,250,180)
			if(Mode=="Large")
				A.Size=1
				A.Damage*=3
				A.Power*=3
				A.Explosive=2
				A.Large('Spirit Bomb.dmi',0,0,0,180)
			usr.attacking=3
			charging=1
			if(prob(10)&&Experience<1) Experience+=0.1
			usr.overlays+='SBombGivePower.dmi'
			if(Mode=="Small") sleep(200/usr.SpdMod/Experience)
			if(Mode=="Medium") sleep(300/usr.SpdMod/Experience)
			if(Mode=="Large") sleep(400/usr.SpdMod/Experience)
			charging=0
			usr.overlays-='SBombGivePower.dmi'
			usr.attacking=0
			if(A)
				IsCharged=1
				usr.overlays+=usr.BlastCharge
		else
			IsCharged=0
			usr.Ki-=KiReq
			usr.overlays-=usr.BlastCharge
			flick("Attack",usr)
			charging=1
			var/obj/Blast/Genki_Dama/A
			for(var/obj/Blast/Genki_Dama/B) if(B.Belongs_To==usr) A=B
			while(A&&usr)
				step(A,usr.dir)
				if(Mode=="Small") sleep(2)
				if(Mode=="Medium") sleep(3)
				if(Mode=="Large") sleep(4)
			charging=0
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(A,2000)
obj/Attacks/Death_Ball
	desc="This is a big attack, and is direction can be controlled. It is very powerful, but very \
	draining, and a bit slow moving. But it does charge pretty fast for such a powerful attack, once \
	it is fully mastered that is."
	var/IsCharged
	KiReq=1000
	verb/Death_Ball()
		set category="Skills"
		if((usr.icon_state in list("Meditate","Train","KO","KB"))||usr.Frozen) return
		if(usr.attacking|usr.Ki<KiReq|charging) return
		if(!IsCharged)
			var/obj/Blast/Genki_Dama/A=new(usr.loc)
			A.y+=2
			if(!A||!A.z) return
			A.Belongs_To=usr
			A.Damage=100*usr.BP*usr.Pow*Ki_Power
			A.Power=100*usr.BP*Ki_Power
			A.Offense=usr.Off
			A.Size=1
			A.Explosive=2
			A.Large('Death Ball.dmi',0,0,0,180)
			usr.attacking=3
			charging=1
			if(prob(10)&&Experience<1) Experience+=0.1
			sleep(50/usr.SpdMod/Experience)
			charging=0
			IsCharged=1
			usr.overlays+=usr.BlastCharge
			usr.attacking=0
		else
			IsCharged=0
			usr.Ki-=KiReq
			usr.overlays-=usr.BlastCharge
			flick("Attack",usr)
			charging=1
			var/obj/Blast/Genki_Dama/A
			for(var/obj/Blast/Genki_Dama/B) if(B.Belongs_To==usr) A=B
			while(A&&usr)
				step(A,usr.dir)
				sleep(2)
			charging=0
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(A,2000)