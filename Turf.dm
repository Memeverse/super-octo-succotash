turf/proc/Destroy(var/U,var/K)
	var/image/I=image(icon='Lightning flash.dmi',layer=99)
	overlays-=I
	if(Health<=0)
		if(type!=/turf/Terrain/Ground/GroundDirt&&type!=/turf/Special/Teleporter&&type!=/turf/Other/Blank&&type!=/turf/Other/Stars/&&type!=/turf)
			var/turf/S = new/turf/Terrain/Ground/GroundDirt(locate(x,y,z))
			S.DestroyedBy="[U]/[K]"

turf/proc/Remove_Damaged_Ground(image/I)
	spawn(rand(600,3000))
		if(src&&I)
			overlays-=I

/turf/Entered(atom/movable/M as mob|obj)
	if(!istype(src, /turf/Other/Stars))
		M.inertia_dir = 0
	..()

/turf/Other/Stars

	icon='Space.dmi'
	icon_state="placeholder"
	Buildable=0
	Health=1.#INF
	New()
		icon_state = "[rand(1,25)]"
		..()

	Entered(atom/movable/A as mob|obj)
		..()
		if (!A || src != A.loc || istype(A,/obj/Attacks) || istype(A,/OBJ_AI/SpaceDebris))
			return

		if (!(A.last_move))
			return

		if (istype(A, /mob/))
			var/mob/M = A
			if (!(M.icon_state == "Flight" && M.Super_Fly))	//Gotta superfly to get through space
				spawn(5)
					if(M && M.loc == src)
						if(!M.anchored)
							if(M.inertia_dir) //they keep moving the same direction
								if(M.icon_state != ("Blast" || "KO"))
									spawn
										flick("KB",M)	//as we go through space, aaaa
								var/turf/T = get_step(M, M.inertia_dir)
								if(!T.density) M.loc = T
								if(M.loc)	M.loc.Entered(M)
							else
								if(M.icon_state != ("Blast" || "KO"))
									spawn
										flick("KB",M)	//as we go through space, aaaa
								M.inertia_dir = M.last_move
								var/turf/T = get_step(M, M.inertia_dir)
								if(!T.density) M.loc = T //TODO: DEFERRED
								if(M.loc)	M.loc.Entered(M)
						else	//anchored
							M.inertia_dir = 0
		else if(istype(A, /obj/Ships))
			var/obj/Ships/S = A
			spawn(5)
				if (S && S.loc == src)
					if (!S.anchored)
						if(S.inertia_dir) //they keep moving the same direction
							var/turf/T = get_step(S, S.inertia_dir)
							if(!T.density) S.loc = T // Walls and other objects, we dont want them to magically move through walls, do we?
							if(S.loc)	S.loc.Entered(S)
						else
							S.inertia_dir = S.last_move
							var/turf/T = get_step(S, S.inertia_dir)
							if(!T.density) S.loc = T
							if(S.loc)	S.loc.Entered(S)
					else
						S.inertia_dir = 0	//Stop moving
						S.last_move = null
	/*
		else if(istype(A, /obj/))
			var/obj/O = A
			if ((O && !( O.anchored ) && O.loc == src))
				if(O.inertia_dir) //they keep moving the same direction
					step(O, O.inertia_dir)
				else
					O.inertia_dir = O.last_move
					step(O, O.inertia_dir)
		else if(istype(A, /atom/movable/))
			if ((A && !( A.anchored ) && A.loc == src))
				if(A.inertia_dir) //they keep moving the same direction
					step(A, A.inertia_dir)
				else
					A.inertia_dir = A.last_move
					step(A, A.inertia_dir)
	*/
		if(src.z == SPACE_Z_LEVEL)
			if(src.x <= 2)
				A.x = world.maxx - 3
				spawn (0)
					if(A && A.loc)
						A.loc.Entered(A)
			else if(src.x >= (world.maxx-2))
				A.x = 3
				spawn (0)
					if(A && A.loc)
						A.loc.Entered(A)
			if(src.y <= 2)
				A.y = world.maxy - 3
				spawn (0)
					if(A && A.loc)
						A.loc.Entered(A)
			else if(src.y >= (world.maxy-2))
				A.y = 3
				spawn (0)
					if(A && A.loc)
						A.loc.Entered(A)