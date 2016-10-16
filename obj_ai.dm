OBJ_AI
	parent_type = /obj

	var
		LOCKED
		active
		minwait = 5
		maxwait = 10

	proc
		Activate_OBJ_AI()
			active=1
			//world << "OBJ AI: \green ON"
			while(active)
				AI_OBJ_WANDER()

		Deactivate_OBJ_AI()
			//world << "NPC AI: \red OFF"
			active = null

		AI_OBJ_WANDER()

			while(active)

				var/wait = rand(minwait,maxwait)
				var/list/direc = step_rand(src)
				var/turf/T = get_step(src, direc)
				var/area/NPC_AI/A = T ? (T.loc) : null

				if(A && loc && A.awake)
					step(src,direc)

				sleep(wait)

	SpaceDebris
		density=1
		Savable=0
		Grabbable=0
		layer=5

		Bump(atom/A) if(istype(A,/obj/Ships))
			var/obj/Ships/B=A
			B.Health-=5000
			if(B.Health<=0) del(B)

		Asteroid
			icon='Asteroid2.dmi'
			icon_state="1"
			Health=25000
			New()
				var/image/A=image(icon='Asteroid2.dmi',icon_state="1",pixel_y=16,pixel_x=-16)
				var/image/B=image(icon='Asteroid2.dmi',icon_state="2",pixel_y=16,pixel_x=16)
				var/image/C=image(icon='Asteroid2.dmi',icon_state="3",pixel_y=-16,pixel_x=-16)
				var/image/D=image(icon='Asteroid2.dmi',icon_state="4",pixel_y=-16,pixel_x=16)
				overlays.Remove(A,B,C,D)
				overlays.Add(A,B,C,D)

			Del()
				for(var/turf/A in view(1,src)) new/obj/Explosion(locate(x,y,z))
				..()

		Meteor
			icon='Asteroid.dmi'
			Health=5000

			Del()
				new/obj/Explosion(locate(x,y,z))
				..()