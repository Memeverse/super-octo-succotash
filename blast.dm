/*
The object that's put inside the player's inventory. This is NOT the object created upon firing.
Look further down for the actual blast object that triggers Bump()
*/

obj/Blast/var

	Damage
	Fatal=1
	Explosive
	Shockwave
	Piercer
	Paralysis
	Beam
	Shuriken
	Shrapnel //Shrapnel from explosions if any
	Deflectable=1
	Power=1 //BP of the Blast. Force can be obtained by dividing damage by Power.
	Offense=1
	Distance=30


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
		switch(input("Do you want your blasts to destroy walls when they hit?") in list("Yes","No"))
			if("Yes") usr.Destroy_Walls = 1
			if("No") usr.Destroy_Walls = 0
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
		usr.Bandages()
		var/Delay = usr.Refire / 8
		Delay += 150 / Experience
		//if(Delay<6) Delay=5 - usr.SpdMod
		spawn(Delay) usr.attacking=0
		Experience+=0.05
		var/S = pick("1","2")
		if(S == "1")
			hearers(6,usr) << 'Blast1.wav'
		if(S == "2")
			hearers(6,usr) << 'Blast2.wav'
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
			var/obj/ranged/Blast/A=new
			A.Belongs_To=usr
			A.pixel_x=rand(-16,16)
			A.pixel_y=rand(-16,16)
			A.icon=icon
			A.Damage=3*usr.BP*usr.Pow*global.Ki_Power  //200
			A.Power=3*usr.BP*global.Ki_Power			//200
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

/*
Actual damage doing object.
Using two different object allows for easy tweaking/renaming of these objects without affecting players.
*/


obj/ranged/Blast

	density=1

	Bump(mob/A)

		if(isobj(A)||isturf(A))

			if(isnum(A.Health))
				if(isturf(A))
					A.Health-=Power*(Damage/Power)*0.001 //BP * Force/1000 (Force assumed to be 1000 on average for this)
					if(istype(A,/turf/Upgradeable/Walls/))
						if(src.Belongs_To)
							var/mob/M = src.Belongs_To
							if(M.Destroy_Walls)
								A.Health = -100
					//if(istype(src,/obj/Blast/Fireball)) Power*=Wall_Strength
					//if(Power>A.Health) A.Health=0
				else
					if(ismob(Belongs_To)) A.Health-=Damage/Belongs_To.Pow
					else A.Health-=Damage/2000
					//if(istype(src,/obj/Blast/Fireball)) Power*=Wall_Strength
					//if(Power>A.Health) A.Health=0
			if(isnum(A.Health)&&A.Health<=0&&!istype(A,/obj/ranged/Blast))
				if(isturf(A))
					var/turf/B=A
					if(!usr||usr==0||isnull(usr)) B.Destroy("Unknown","Unknown")
					else B.Destroy(usr,usr.key)
				else
					new/obj/BigCrater(locate(A.x,A.y,A.z))
					del(A)
			if(istype(A,/obj/ranged/Blast))
				var/obj/ranged/Blast/J=A
				if(J.Damage<Damage) del(A)
			Explode()
			if(prob(95)&&Shuriken)
				dir=pick(NORTH,SOUTH,EAST,WEST,NORTHEAST,NORTHWEST,SOUTHEAST,SOUTHWEST)
				walk(src,dir)
			else if(!Piercer) del(src)

		else if(ismob(A)||istype(A,/NPC_AI)) // Either the object hit by the beam is a mob or an NPC

			if(istype(A,/NPC_AI)&&isnum(A.Health)&&A.Health<=0){A.Death(Belongs_To);del(A);return FALSE} // If the NPC's health is a number (sanity) and below 0, kill them.
			if(istype(A,/mob/Cookable)){del(A);return FALSE} // If it's a cookable mob, just destroy it.

			var/Original_Damage=Damage
			if(Bullet) Damage/=A.BP*A.End
			else Damage/=A.BP*A.Res
			var/Life_Decrease=1*(Damage/(A.Base*A.Body*A.Res))

			if(Bullet) Life_Decrease=1*(Damage/(A.Base*A.Body*A.End))
			if(Bullet&&!A.client) Damage*=100 //Guns do much more damage against NPCs.



			for(var/obj/items/Force_Field/S in A) if(S.Level>0) //if(S.suffix)
				S.Level = max(0, (S.Level - Original_Damage) )
				S.desc = initial(S.desc)+"<br>[Commas(S.Level)] Battery Remaining"
				walk(src,pick(NORTH,SOUTH,EAST,WEST,NORTHWEST,NORTHEAST,SOUTHWEST,SOUTHEAST))
				return FALSE

			if(prob(50)&&A.Precognition) if(A.icon_state in list("","Flight"))
				step(A,turn(dir,pick(-45,45)))
				return FALSE

			var/DEF = A.Def
			var/Hit_Chance=50*((((src.Power/global.Ki_Power)*0.25)*src.Offense)/(A.BP*DEF))

			if(prob(Hit_Chance)||!Deflectable||A.icon_state=="KO") //||A.Frozen)
				if(prob(Hit_Chance)||!Deflectable||A.icon_state=="KO")
					new/obj/shockwave(A.loc)
					Damage = Damage * 0.5
					hearers(6,usr) << 'Ki_Deflect.wav'
				if(A.icon_state=="KO")
					A.Life-=Life_Decrease
					if(A.Life<=0)
						if(A.Regenerate) if(A.BP*200*A.Regenerate<Power) A.Dead=1
						A.Death(Belongs_To)
						return FALSE

				else if (!A.client&&A.Frozen)
					A.Life-=Life_Decrease
					if(A.Life<=0)
						if(A.Regenerate) if(A.BP*200*A.Regenerate<Power) A.Dead=1
						A.Death(Belongs_To)
						return FALSE


				else if(A)
					if(isnum(A.Health))
						var/C = Damage*3
						if(prob(C))
							var/L = list("Random")
							A.Injure_Hurt(Damage,L)
						A.Health-=Damage
						if(istype(src,/obj/ranged/Blast/Time_Freeze))
							return TRUE
					if(istype(A,/NPC_AI)){var/NPC_AI/T=A;T.target=Belongs_To;if(!T.active)T.Activate_NPC_AI()}

					if(isnum(A.Health)&&A.Health<=0)
						if(type!=/obj/ranged/Blast/Genki_Dama)
							A.KO(Belongs_To)
							return FALSE
						else
							if(!A.client||istype(A,/NPC_AI))
								A.Death(Belongs_To)
								return FALSE
							else
								A.Life-=Life_Decrease
								if(A.Life<=0)
									if(A.Regenerate) if(A.BP*200*A.Regenerate<Power) A.Dead=1
									A.Death(Belongs_To)
									return FALSE
					if(Paralysis)
						A<<"You become paralyzed"
						A.saveToLog("| [A.client.address ? (A.client.address) : "IP not found"] | ([A.x], [A.y], [A.z]) | [key_name(A)] becomes paralyzed.\n")
						A.Frozen=1
					if(A&&src&&A.dir==dir&&A.icon_state=="KO"&&A.Tail)
						view(A)<<"[A]'s tail is blasted off!"
						for(var/mob/player/M in view(A)) if(M.client) M.saveToLog("| [A.client.address ? (A.client.address) : "IP not found"] | ([A.x], [A.y], [A.z]) | [key_name(A)] 's tail is blasted off!\n")
						A.Tail_Remove()
					//if(Shockwave) step_away(A,src)
					if(Shockwave)
						A.Shockwave_Knockback(Shockwave,loc)
						return TRUE
					Explode()
					if(prob(95)&&Shuriken)
						dir=pick(NORTH,SOUTH,EAST,WEST,NORTHEAST,NORTHWEST,SOUTHEAST,SOUTHWEST)
						walk(src,dir)
						return TRUE

			else
				dir=pick(NORTH,SOUTH,EAST,WEST,NORTHEAST,NORTHWEST,SOUTHEAST,SOUTHWEST)
				if(A.client) flick("Attack",A)
				loc=A.loc
				walk(src,dir)
				return FALSE

			if(!Piercer) del(src)

		..()