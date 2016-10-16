mob/verb/Fires()
	for(var/atom/A in range(20,usr))
		if(A.Flammable)
			A.Burning = 1
			A.Burn(A.Health)
obj
	proc
		Smoke()
			src.dir = NORTH
			step_rand(src)
			spawn(5)
				if(src) src.Smoke()
atom
	proc
		Burn(var/H)
			if(src.Burning)
				if(isobj(src))
					src.overlays -= 'fire obj.dmi'
					src.overlays += 'fire obj.dmi'
					new /obj/Smoke(src.loc)
				if(isturf(src))
					src.overlays -= 'fire turf.dmi'
					src.overlays += 'fire turf.dmi'
					new /obj/Smoke(src)
				if(H)
					var/dmg = H / 80
					src.Health -= dmg
				if(src.Health < 0)
					if(isobj(src))
						new /obj/Ash(src.loc)
						del(src)
					if(isturf(src))
						src.overlays -= 'fire turf.dmi'
						new /turf/Terrain/Ground/Ground17(src)
			spawn(5)
				if(src) src.Burn(H)