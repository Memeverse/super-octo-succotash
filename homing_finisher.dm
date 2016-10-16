
obj/Attacks/Homing_Finisher
	Difficulty=10
	icon='17.dmi'
	desc="This will create multiple homing balls all around an Opp, and when its done they will \
	all collide at once on top of them. Individually each ball is weak, but all together it can be \
	extremely devastating to most people. The more energy you get the more balls you can make at once. \
	Use the Settings verb to change how many balls to make, between 1 and your max."
	var/Setting=10
	verb/Settings()
		Setting=input("Input the amount of blasts you want created when you use this attack. Default is [initial(Setting)]. You can fire 100 max") as num
		if(Setting<1) Setting=1
		if(Setting>100) Setting=100
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
		var/S = pick("1","2")
		if(S == "1")
			hearers(6,usr) << 'Charging.wav'
		if(S == "2")
			hearers(6,usr) << 'Charging2.wav'
		var/list/spawnArea = oview(usr,8)
		if(!length(spawnArea))
			usr.attacking=0
			return
		while(usr&&B)
			if(!amount||usr.icon_state=="KO"||(B.z!=usr.z)) break
			sleep(1)
			spawnArea = oview(usr,8)
			for(var/i=0, i<5, i++)
				if(!amount)
					break
				amount-=1
				flick("Blast",usr)
				var/obj/ranged/Blast/A=new
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
					if("Alien")
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
