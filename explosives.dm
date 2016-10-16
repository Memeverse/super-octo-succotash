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