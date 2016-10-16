turf/proc/Nuke(Damage,Range) spawn if(src)
	var/obj/ranged/Blast/Fireball/F=new(src)
	F.Damage=Damage*1000
	F.Power=Damage
	walk_rand(F)

obj/ranged/Blast/Fireball
	icon='Explosion.dmi'
	density=1
	Shockwave=1
	Deflectable=0
	Explosive=0
	Piercer=1
	luminosity=1	//Lotta cpu but it looks SO COOL
	layer=MOB_LAYER+50
	Distance=5000000
	Belongs_To="the nuclear explosion!"
	New()
		..()
		spawn(rand(600,1800))
			if(src)
				//sd_SetLuminosity(0)
				del(src)
		var/Amount=5
		while(Amount)
			var/image/A=image(icon='Explosion.dmi',pixel_x=rand(-32,32),pixel_y=rand(-32,32))
			overlays+=A
			Amount-=1

	Move()
		for(var/obj/A in get_step(src,dir)) if(A.type!=type)
			Bump(A)
			break
		for(var/mob/A in get_step(src,dir))
			Bump(A)
			break
		for(var/turf/A in range(1,src))
			if(A.density)
				Bump(A)
			else if(prob(5) && !istype(A,/turf/Terrain/Ground/GroundDirt))
				A.Health=0
				if(usr!=0) A.Destroy(usr,usr.key)
				else A.Destroy("Unknown","Unknown")
				var/turf/meltingrock/rock = new /turf/meltingrock(locate(A.x,A.y,A.z))
				Turfs+=rock
		..()
		sleep(1)

	Bump(mob/A)
		if(ismob(A))
			for(var/obj/Cybernetics/Force_Field/S in A) if(S.suffix)
				for(var/obj/Cybernetics/Generator/G in A) if(G.suffix)
					if(G.Current>80)
						G.Current = max(0, (G.Current - 80) )
						G.desc = initial(G.desc)+"<br>[Commas(G.Current)] Battery Remaining"
						A.Force_Field()
			for(var/obj/items/Force_Field/S in A) if(S.Level>0)//if(S.suffix)
				S.Level = max(0, (S.Level - Damage*0.01) )
				if(S.Level<=0)
					S.Level=0
					S.suffix=null
					view(src)<<"[A]'s force field is drained!"
					A.Force_Field()
					for(var/mob/player/M in view(src))
						if(!M.client) return
						M.saveToLog("| [A.client.address ? (A.client.address) : "IP not found"] | ([A.x], [A.y], [A.z]) | [key_name(A)] 's force field is drained! .\n")
				S.desc = initial(S.desc)+"<br>[Commas(S.Level)] Battery Remaining"
				return
			if(prob(95)&&A.Precognition) if(A.icon_state in list("","Flight"))
				step(A,turn(dir,pick(-45,45)))
				return
			if((A.icon_state=="KO"&&A.client)||(A.Frozen&&!A.client))
				A.Life-=1*(Damage/(A.Base*A.Body*A.Res))
				if(A.Life<=0)
					if(A.Regenerate) if(A.Life<=-10*A.Regenerate) A.Dead=1
					A.Death(Belongs_To)
			if(A)
				A.Health-=Damage/(A.BP*A.Res)
				if(A.Health<=0)
					if(type!=/obj/ranged/Blast/Genki_Dama) A.KO(Belongs_To)
					else
						if(!A.client) A.Death(Belongs_To)
						else
							A.Life-=1*(Damage/(A.Base*A.Body*A.Res))
							if(A.Life<=0)
								if(A.Regenerate) if(A.Life<=-10*A.Regenerate) A.Dead=1
								A.Death(Belongs_To)
				if(Paralysis)
					A<<"You become paralyzed"
					A.saveToLog("| [A.client.address ? (A.client.address) : "IP not found"] | ([A.x], [A.y], [A.z]) | [key_name(A)] is paralyzed.\n")
					A.Frozen=1
				if(A&&src&&A.dir==dir&&A.icon_state=="KO"&&A.Tail)
					view(A)<<"[A]'s tail is blasted off!"
					A.Tail_Remove()
					for(var/mob/player/M in view(A))
						if(!M.client) return
						M.saveToLog("| [A.client.address ? (A.client.address) : "IP not found"] | ([A.x], [A.y], [A.z]) | [key_name(A)] 's tail is blasted off.\n")
				if(Shockwave) step_away(A,src,100)
				Explode()
		else
			if(isnum(A.Health))
				if(ismob(Belongs_To)) A.Health-=Damage
				else A.Health-=Damage/2000
			if(A.Health<=0)
				if(isturf(A))
					var/turf/meltingrock/rock = new /turf/meltingrock(locate(A.x,A.y,A.z))
					Turfs+=rock
			Explode()

obj/items/Nuke/proc/doDamage(var/atom/A)
	//var/distance	=	length(getline(A,src.loc))	//Abuse of getline derp de derp
	//A low level nuke doesn't do a whole lot.
	//Your nuke efficiency essentially determines
	//How many tiles from epicenter damage
	//begins to taper off
	var/PercentDamage = max(0,min(100,(src.Range)*src.Efficiency))	//Between 1-100% 'damage'
	var/Damage = PercentDamage*(src.Force**5)*10	//**5 = to the fifth

	if(istype(A, /mob/))
		var/mob/M = A
		if(!M)	return
		for(var/obj/Cybernetics/Force_Field/S in M) if(S.suffix)
			for(var/obj/Cybernetics/Generator/G in M) if(G.suffix)
				if(G.Current > 80)
					G.Current = max(0, (G.Current - 80) )
					G.desc = initial(G.desc)+"<br>[Commas(G.Current)] Battery Remaining"
					M.Force_Field()
		for(var/obj/items/Force_Field/S in M) if(S.Level>0)
			S.Level = max(0, (Damage * 0.01) )
			if(S.Level<=0)
				S.Level=0
				S.suffix=null
				view(src) << "[M]'s force field is drained!"
			S.desc = initial(S.desc)+"<br>[Commas(S.Level)] Battery Remaining"
			M.Force_Field()
			for(var/mob/player/K in view(M))
				if(!K.client) return
				K.saveToLog("| [M.client.address ? (M.client.address) : "IP not found"] | ([M.x], [M.y], [M.z]) | [key_name(M)] 's force field is drained! \n")
			return
		if(M.Precognition && !prob(PercentDamage))	//Precognition isn't going to save you from a NUKE
			if(M.icon_state in list("","Flight"))//Unless of course the efficiency is lower, meaning
				step(M,turn(dir,pick(-45,45)))	//The nuke would be less powerful.. at that turf
				return
		var/RemainingDamage = (Damage/(M.BP*M.Res) - M.Health)	//Get this incase they end up knocked out
		M.Health -= Damage/(M.BP*M.Res)
		if(M.Health <= 0)
			M.KO("the nuclear explosion")
			if(M.Tail && prob(PercentDamage))	//Tail goin ham
				view(M) << "[M]'s tail is blasted off!"
				for(var/mob/player/K in view(M))
					if(!K.client) return
					K.saveToLog("| [M.client.address ? (M.client.address) : "IP not found"] | ([M.x], [M.y], [M.z]) | [key_name(M)] 's tail is blasted off!\n")
				M.Tail_Remove()
			M.Life -= RemainingDamage/((M.Base*M.Body*M.Res)/PercentDamage)	//Greater chance to die if you're near the center, REGARDLESS
		if(M.Life <= 0 && (M.Life <= -10*M.Regenerate))
			M.Dead = 1
			M.Death("the nuclear explosion")
		else if(prob(PercentDamage))
			M.Shockwave_Knockback(((src.Range/2)),src.loc)
	else if (istype(A, /turf/))
		var/turf/T = A
		T.Health -= Damage
		if(T.Health <= 0)
			var/turf/meltingrock/rock = new /turf/meltingrock(locate(T.x,T.y,T.z))
			Turfs+=rock

	else if (istype(A, /obj/Blast))
		var/obj/ranged/Blast/B = A
		B.Explode()
	else if (istype(A, /obj/))
		var/obj/O = A
		O.Health -= Damage
		if(O.Health <= 0)
			del(O)
		//else if(prob(PercentDamage))
			//O.Shockwave_Knockback(PercentDamage,src.loc)	//Buggy?


/turf/meltingrock

	name = "Super-heated rock"
	desc = "The aftermath of a nuclear bomb"
	icon = 'nuclearfire.dmi'
	icon_state = "1"
	Buildable = 0

	New()
		icon_state = pick("1", "2", "3")
		dir = pick(cardinal)
		//Turfs += src	//Glass a planet, it persists!
		spawn(rand(16,64))
			var/turf/moltenrock/rock = new /turf/moltenrock(locate(src.x,src.y,src.z))
			Turfs-=src
			Turfs+=rock
		..()

///turf/meltingrock/Del()
//	Turfs -= src
//	..()

/turf/moltenrock
	name = "Super-heated rock"
	desc = "The aftermath of a nuclear bomb"
	icon = 'Turfs1.dmi'
	icon_state = "lava"
	Buildable = 0

	New()
		icon_state = pick("lava", "lava2", "lava3", "lava4", "lava5", "ash", "ash2", "ash3", "ash4", "ash5")
		//Turfs += src	//Glass a planet, it persists!
		//if(prob(5))
			//overlays += icon('icon.dmi',"icon_state")	//steam rising from freshly molten ground :v
		..()

///turf/moltenrock/Del()
//	Turfs -= src
//	..()