mob/proc/Blast_Absorb_Graphics()
	overlays+='Black Hole.dmi'
	spawn(10) overlays-='Black Hole.dmi'
obj/Blast
	var/Damage
	var/Fatal=1
	var/Explosive
	var/Shockwave
	var/Piercer
	var/Paralysis
	var/Beam
	var/Shuriken
	var/Shrapnel //Shrapnel from explosions if any
	var/Deflectable=1
	var/Power=1 //BP of the Blast. Force can be obtained by dividing damage by Power.
	var/Offense=1
	luminosity=2
	layer=MOB_LAYER+1
	Savable=0
	density=1
	Grabbable=0
	var/Distance=30
	Move()
		if(icon_state=="origin") icon_state="tail"
		if(density&&!Sokidan)
			Distance-=1
			if(Distance<=0) del(src)
		..()
	New()
		if(type!=/obj/Blast/Genki_Dama)
			spawn(1) if(Belongs_To&&ismob(Belongs_To)&&Belongs_To.icon_state!="Blast") if(Belongs_To.client) flick("Blast",Belongs_To)
			spawn(300) if(src) del(src)
		spawn Edge_Check()
		//..()
	proc/Beam() while(src)
		if(!Belongs_To) del(src)
		spawn if(icon_state!="struggle"&&Beam)
			if(!(locate(/obj/Blast) in get_step(src,dir))) icon_state="head"
			else if(!(locate(/obj/Blast) in get_step(src,turn(dir,180)))) icon_state="end"
			else icon_state="tail"
		if(prob(3)&&locate(/obj/Blast) in get_step(src,turn(dir,180))) Explode()
		for(var/mob/B in range(0,src))
			var/mob/A=B
			if(!ismob(A)) return // Sanity check
			if(B.GrabbedMob) A=B.GrabbedMob
			if(A.Blast_Absorb&&A.Ki<A.MaxKi*2&&(A.dir==turn(dir,180)||A.Blast_Absorb>=2)&&A.icon_state!="KO")
				A.Ki+=A.MaxKi*0.01
				A.Blast_Absorb_Graphics()
				del(src)
				return
			//for(var/obj/Shield/S in A) if(S.Using)
				//A.Ki-=(A.MaxKi*0.01)*(Damage/(A.BP*A.Res))
				//for(var/obj/Blast/BB in get_step(src,turn(dir,180))) BB.icon_state="struggle"
				//del(src)
				//return
			for(var/obj/Cybernetics/Force_Field/S in A) if(S.suffix)
				for(var/obj/Cybernetics/Generator/G in A) if(G.suffix)
					if(G.Current>80)
						G.Current-=80
						A.Force_Field()
						del(src)
			for(var/obj/items/Force_Field/S in A) if(S.Level>0)// if(S.suffix)
				S.Level-=Damage*0.01
				if(S.Level<=0)
					S.Level=0
					S.suffix=null
					view(src)<<"[A]'s force field is drained!"
					for(var/mob/player/M in view(src)) if(M.client) M.saveToLog("| [A.client.address ? (A.client.address) : "IP not found"] | ([A.x], [A.y], [A.z]) | [key_name(A)] 's force field is drained!<br>")
				A.Force_Field()
				del(src)
			if(isnum(A.Health))
				A.Health-=Damage/(1+(A.BP*A.Res))
				if(A.Health<=0) A.KO(Belongs_To)
			if(Paralysis)
				A<<"You become paralyzed"
				A.Frozen=1
			if((A.icon_state=="KO"&&A.client)||(A.Frozen&&!A.client))
				A.Life-=1*(Damage/(A.Base*A.Body*A.Res))
				if(A.Life<=0)
					if(A.Regenerate) if(A.BP*20*A.Regenerate<Power) A.Dead=1
					A.Death(Belongs_To)
			if(!Piercer)
				for(var/obj/Blast/BB in get_step(src,turn(dir,180))) BB.icon_state="struggle"
				if(src) del(src)
			break
		for(var/obj/Blast/A in get_step(src,turn(dir,180))) if(A.dir!=dir) del(A)
		for(var/obj/Blast/A in range(0,src))
			if(A.dir!=dir)
				icon_state="struggle"
				A.icon_state="struggle"
				layer=MOB_LAYER+2
				A.layer=MOB_LAYER+2
				if(!(locate(/obj/Blast) in get_step(src,turn(dir,180)))) del(src)
				for(var/obj/Blast/C in get_step(src,dir)) if(C.dir==dir)
					icon_state="tail"
					layer=MOB_LAYER+1
					break
				for(var/obj/Blast/C in get_step(src,turn(dir,180))) if(C.dir==dir&&C.icon_state=="struggle")
					C.icon_state="tail"
					C.layer=MOB_LAYER+1
				//if(prob(round(50*(Damage/A.Damage))))
				if(A.Damage<Damage&&prob(70))
					walk(src,dir,10)
					for(var/obj/Blast/B in get_step(A,turn(A.dir,180)))
						B.icon_state="struggle"
						break
					del(A)
				break
			if(A.dir==dir&&A.icon_state=="struggle") if(A.Damage<Damage) del(A)
		for(var/turf/A in range(0,src)) if(A.density)
			if(isnum(A.Health))
				A.Health-=Power*(Damage/Power)*0.001 //BP * Force/1000 (Force assumed to be 1000 on average for this)
				//if(istype(src,/obj/Blast/Fireball)) Power*=Wall_Strength
				//if(Power>A.Health) A.Health=0
				if(A.Health<=0)
					var/turf/B=A
					if(usr!=0) B.Destroy(usr,usr.key)
					else B.Destroy("Unknown","Unknown")
				if(A) if(!Piercer&&A.density)
					for(var/obj/Blast/B in get_step(src,turn(dir,180))) B.icon_state="struggle"
					del(src)
		for(var/obj/A in range(0,src)) if(!istype(A,/obj/Blast))

			if(isnum(A.Health))

				A.Health-=Damage
				//if(istype(src,/obj/Blast/Fireball)) Power*=Wall_Strength
				//if(Power>A.Health) A.Health=0
				if(A.Health<=0)
					new/obj/BigCrater(locate(A.x,A.y,A.z))
					del(A)
				if(A) if(!Piercer&&A.density)
					for(var/obj/Blast/B in get_step(src,turn(dir,180))) B.icon_state="struggle"
					del(src)
				break
		sleep(1)
	proc/Explode() if(Explosive)
		for(var/mob/A in view(Explosive,src))
			var/Shielding
			//for(var/obj/Shield/S in A) if(S.Using)
				//A.Ki-=(A.MaxKi*0.01)*(Damage/(A.BP*A.Res))
				//Shielding=1
			for(var/obj/Cybernetics/Force_Field/S in A) if(S.suffix)
				for(var/obj/Cybernetics/Generator/G in A) if(G.suffix)
					if(G.Current>80)
						G.Current-=80
						A.Force_Field()
						del(src)
			for(var/obj/items/Force_Field/S in A)
				//if(S.suffix) Shielding=1
				if(S.Level>0) Shielding=1
			if(!Shielding)
				A.Shockwave_Knockback(Explosive,loc)

				if(isnum(A.Health))

					A.Health-=(Damage/(A.BP*A.Res))*0.1
					if(A.Health<=0) A.KO(Belongs_To)
					if(Paralysis)
						A<<"You become paralyzed"
						A.saveToLog("| [A.client.address ? (A.client.address) : "IP not found"] | ([A.x], [A.y], [A.z]) | [key_name(A)] becomes paralyzed.<br>")
						A.Frozen=1
		for(var/obj/A in view(Explosive,src)) if(A!=src&&!istype(A,/obj/Blast))
			if(isnum(A.Health))
				A.Health-=Damage
				if(istype(src,/obj/Blast/Fireball)) Power*=Wall_Strength
				//if(Power>A.Health) A.Health=0
				if(isnum(A.Health)&&A.Health<=0)
					new/obj/BigCrater(locate(A.x,A.y,A.z))
					del(A)
		for(var/turf/A in view(Explosive,src)) if(prob(80))
			var/obj/Explosion/B=new
			if(!Shrapnel) B.icon='Plasma Explosion.dmi'
			B.loc=locate(A.x,A.y,A.z)
			if(isnum(A.Health)) A.Health-=Power*(Damage/Power)*0.001 //BP * Force/1000 (Force assumed to be 1000 on average for this)
			//if(istype(src,/obj/Blast/Fireball)) Power*=Wall_Strength
			//if(Power>A.Health) A.Health=0
			if(usr!=0) A.Destroy(usr,usr.key)
			else A.Destroy("Unknown","Unknown")
		while(prob(90)&&Shrapnel)
			var/obj/Blast/B=new(locate(x,y,z))
			B.Damage=(Damage*0.2)+1
			B.Belongs_To=Belongs_To
			B.Fatal=Fatal
			B.icon='Shuriken.dmi'
			B.Shrapnel=1
			if(prob(10)&&Explosive) B.Explosive=Explosive-1
			B.dir=pick(NORTH,SOUTH,EAST,WEST,NORTHEAST,NORTHWEST,SOUTHEAST,SOUTHWEST)
			walk(B,B.dir,rand(1,2))
	Bump(mob/A)
		if(!Belongs_To) del(src)
		else if(A.type==type&&A.dir==dir)
			density=0
			spawn(1) if(src) density=1
		else if(ismob(A)||istype(A,/NPC_AI))
			if(istype(A,/NPC_AI)&&isnum(A.Health)&&A.Health<=0){A.Death(Belongs_To);del(A);return}
			if(istype(A,/mob/Cookable)){del(A);return}
			var/Original_Damage=Damage
			if(Bullet) Damage/=A.BP*A.End
			else Damage/=A.BP*A.Res
			var/Life_Decrease=1*(Damage/(A.Base*A.Body*A.Res))
			if(Bullet) Life_Decrease=1*(Damage/(A.Base*A.Body*A.End))
			if(Bullet&&!A.client) Damage*=100 //Guns do much more damage against NPCs.
			if(ismob(A))
				if(A.Blast_Absorb&&A.Ki<A.MaxKi*2&&(A.dir==turn(dir,180)||A.Blast_Absorb>=2||A.Precognition)&&A.icon_state!="KO")
					A.Ki+=A.MaxKi*0.01
					A.Blast_Absorb_Graphics()
					del(src)
					return
			//for(var/obj/Shield/S in A) if(S.Using)
				//A.Ki-=(A.MaxKi*0.01)*Damage
				//if(A.Ki>0)
					//walk(src,pick(NORTH,SOUTH,EAST,WEST,NORTHWEST,NORTHEAST,SOUTHWEST,SOUTHEAST))
					//return
			for(var/obj/Cybernetics/Force_Field/S in A) if(S.suffix)
				for(var/obj/Cybernetics/Generator/G in A) if(G.suffix)
					if(G.Current>80)
						G.Current-=80
						A.Force_Field()
						del(src)
			for(var/obj/items/Force_Field/S in A) if(S.Level>0) //if(S.suffix)
				S.Level-=Original_Damage
				if(S.Level<=0)
					S.Level=0
					S.suffix=null
					view(src)<<"[A]'s force field is drained!"
					for(var/mob/player/M in view(A)) if(M.client) M.saveToLog("| [A.client.address ? (A.client.address) : "IP not found"] | ([A.x], [A.y], [A.z]) | [key_name(A)] 's force field is drained!<br>")
				A.Force_Field()
				walk(src,pick(NORTH,SOUTH,EAST,WEST,NORTHWEST,NORTHEAST,SOUTHWEST,SOUTHEAST))
				return
			if(prob(50)&&A.Precognition) if(A.icon_state in list("","Flight"))
				step(A,turn(dir,pick(-45,45)))
				return
			var/Hit_Chance=50*((((Power/Ki_Power)*0.25)*Offense)/(A.BP*A.Def))
			if(prob(Hit_Chance)||!Deflectable||A.icon_state=="KO"||A.Frozen)
				if(A.icon_state=="KO"||(A.Frozen&&!A.client))
					A.Life-=Life_Decrease
					if(A.Life<=0)
						if(A.Regenerate) if(A.BP*200*A.Regenerate<Power) A.Dead=1
						A.Death(Belongs_To)
				else if(A)
					if(isnum(A.Health)) A.Health-=Damage
					if(istype(A,/NPC_AI)){var/NPC_AI/T=A;T.target=Belongs_To;if(!T.active)T.Activate_NPC_AI()}
					if(isnum(A.Health)&&A.Health<=0)
						if(type!=/obj/Blast/Genki_Dama) A.KO(Belongs_To)
						else
							if(!A.client||istype(A,/NPC_AI)) A.Death(Belongs_To)
							else
								A.Life-=Life_Decrease
								if(A.Life<=0)
									if(A.Regenerate) if(A.BP*200*A.Regenerate<Power) A.Dead=1
									A.Death(Belongs_To)
					if(Paralysis)
						A<<"You become paralyzed"
						A.saveToLog("| [A.client.address ? (A.client.address) : "IP not found"] | ([A.x], [A.y], [A.z]) | [key_name(A)] becomes paralyzed.<br>")
						A.Frozen=1
					if(A&&src&&A.dir==dir&&A.icon_state=="KO"&&A.Tail)
						view(A)<<"[A]'s tail is blasted off!"
						for(var/mob/player/M in view(A)) if(M.client) M.saveToLog("| [A.client.address ? (A.client.address) : "IP not found"] | ([A.x], [A.y], [A.z]) | [key_name(A)] 's tail is blasted off!<br>")
						A.Tail_Remove()
					//if(Shockwave) step_away(A,src)
					if(Shockwave) A.Shockwave_Knockback(Shockwave,loc)
					Explode()
					if(prob(95)&&Shuriken)
						dir=pick(NORTH,SOUTH,EAST,WEST,NORTHEAST,NORTHWEST,SOUTHEAST,SOUTHWEST)
						walk(src,dir)
			else
				dir=pick(NORTH,SOUTH,EAST,WEST,NORTHEAST,NORTHWEST,SOUTHEAST,SOUTHWEST)
				if(A.client) flick("Attack",A)
				loc=A.loc
				walk(src,dir)
				return
			if(!Piercer) del(src)

		else
			if(isnum(A.Health))
				if(isturf(A))
					A.Health-=Power*(Damage/Power)*0.001 //BP * Force/1000 (Force assumed to be 1000 on average for this)
					//if(istype(src,/obj/Blast/Fireball)) Power*=Wall_Strength
					//if(Power>A.Health) A.Health=0
				else
					if(ismob(Belongs_To)) A.Health-=Damage/Belongs_To.Pow
					else A.Health-=Damage/2000
					//if(istype(src,/obj/Blast/Fireball)) Power*=Wall_Strength
					//if(Power>A.Health) A.Health=0
			if(isnum(A.Health)&&A.Health<=0&&!istype(A,/obj/Blast))
				if(isturf(A))
					var/turf/B=A
					if(!usr||usr==0||isnull(usr)) B.Destroy("Unknown","Unknown")
					else B.Destroy(usr,usr.key)
				else
					new/obj/BigCrater(locate(A.x,A.y,A.z))
					del(A)
			if(istype(A,/obj/Blast))
				var/obj/Blast/J=A
				if(J.Damage<Damage) del(A)
			Explode()
			if(prob(95)&&Shuriken)
				dir=pick(NORTH,SOUTH,EAST,WEST,NORTHEAST,NORTHWEST,SOUTHEAST,SOUTHWEST)
				walk(src,dir)
			else if(!Piercer) del(src)
obj/proc/Edge_Check() while(src)
	if(!(locate(Belongs_To) in range(12,src))) if(x==1|x==world.maxx|y==1|y==world.maxy) del(src)
	sleep(50)
obj/Explosive/Grenade
	var/Explosive=1
	var/Damage
	proc/Explode()
		for(var/turf/T in view(Explosive,src))

			for(var/mob/P in T)
				if(isnum(P.Health)) P.Health-=Damage/usr.BP/usr.End

			for(var/obj/P in T) if(P!=src)
				if(isnum(P.Health))
					P.Health-=Belongs_To.Pow*5
					if(P.Health<=0)
						new/obj/Crater(T)
						del(P)
			if(isnum(T.Health)) T.Health-=Belongs_To.Pow*5
			new/obj/Explosion(T)
			if(isnum(T.Health)&&T.Health<=0)
				if(usr!=0) T.Destroy(usr,usr.key)
				else T.Destroy("Unknown","Unknown")
		del(src)
mob/proc/Shockwave_Knockback(Amount,turf/A) spawn if(src)
	var/Old_State
	if(icon_state!="KB") Old_State=icon_state
	icon_state="KB"
	while(Amount)
		Amount-=1
		KB=1
		Knockback()
		step_away(src,A,100)
		sleep(1)
	KB=0
	if((Old_State||Old_State=="")&&icon_state!="KO") icon_state=Old_State
obj/proc/Shockwave_Knockback(Amount,turf/A) spawn if(src)
	while(Amount)
		Amount-=1
		step_away(src,A,100)
		sleep(1)