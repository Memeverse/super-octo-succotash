mob/Pet
	Saiba
		icon='DBZ.dmi'
		icon_state="Saibaman"
		RecordPL=1200
		BasePL=1200
		MaxPL=1200
		PL=1200
		A.HP=100
		MaxKi=5
		Ki=5
		Str=15
		Pow=10
		Spd=10
		End=3
		Off=10
		Def=1
		GravMastered=30
		MaxPLpcnt=105
		MaxAnger=105
		PLMod=1
		KiMod=1
		PowMod=1
		StrMod=1
		SpdMod=1
		EndMod=1
		OffenseMod=1
		DefenseMod=1
		HPRegen=0.5
		KiRegen=0.2
		GravMod=0.2
		ZenkaiMod=0.5
		movespeed=3
		pet=1
		player=0
		monster=0
		attackable=1
		move=1
mob/var/pet
mob/var/petmaster
mob/var/petxp=0
mob/var/petlvl=1

mob/proc/Pokevolve()
	petxp+=1
	if(petxp>=(petlvl*petlvl*5))
		petxp-=petlvl*petlvl*5
		petlvl+=1
		view(src)<<"[src] pokevolves!"
		PL*=2
		zanzoken+=20
	for(var/obj/items/Saibaman_Seed/A) if(originator==A)
		A.SXP=petxp
		A.SLVL=petlvl
		A.SBP=PL
		A.suffix="Level [A.SLVL]"
mob/proc/Pet_AI()
	spawn while(src)
		if(HP<=0)
			view(src)<<"[src] is defeated..."
			for(var/obj/items/Saibaman_Seed/A) if(originator==A)
				A.saibaout=0
			del(src)
		if(!KO)
			if(!Target)
				var/dostuff=1
				for(var/mob/M in view(2,src)) if(petmaster==M)
					dostuff=0
					break
				if(dostuff)
					for(var/mob/M) if(petmaster==M)
						z=M.z
						if(prob(20)) step_rand(src)
						else step_towards(src,M)
			if(Target)
				step_towards(src,Target)
				//Blasts--------
				if(prob(petlvl**3))
					var/bcolor='12.dmi'
					bcolor+=rgb(50,250,50)
					var/obj/A=new/obj/attack/blast/
					spawn(Pow+50) if(A) del(A)
					A.loc=locate(x,y,z)
					A.icon=bcolor
					A.icon_state="12"
					A.density=0
					A.Pow=Pow
					A.PL=PL
					A.KiSetting=1
					A.owner=src
					step(A,dir)
					walk(A,dir,2)
					A.density=1
				//--------------
				var/confirmtarget=0
				for(var/mob/M in oview(src))
					if(M.z==z&&Target==M)
						confirmtarget=1
						break
				if(!confirmtarget) Target=null
		sleep(movespeed)