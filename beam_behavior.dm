obj/ranged/Beam

	var/tmp
		obj/Attacks/origin
		kiDrain
		mob/owner

	Move()

		.=..() //call the parent (overriden by /obj/ranged/Move() ), store the return value
		if(!.) return //if it returned false, (movement failed), return false too (and stop this proc)
		 //otherwise, if movement succeeded...

		if(!origin)
			del(src)

		Belongs_To.Ki-=kiDrain // Drain their energy

		if(Belongs_To.Ki<=0) Belongs_To.BeamStop(origin) // If they don't have enough energy, prevent them from continuing the attack.

		if(prob(3)&&locate(/obj/ranged) in get_step(src,turn(dir,180))) Explode()

		src.shoot()

		beam_appearance()

/*
		var/obj/ranged/R = locate()
		if(R in get_step(src,dir)&&R.dir==dir)
			R.density=0


		for(var/obj/ranged/C in get_step(src,dir)) if(C.dir==dir)
			icon_state="tail"
			layer=MOB_LAYER+1
			break
		for(var/obj/ranged/C in get_step(src,turn(dir,180))) if(C.dir==dir&&C.icon_state=="struggle")
			C.icon_state="tail"
			C.layer=MOB_LAYER+1
*/

	Bump(atom/Z)

		.=..() //call the parent (/obj/ranged/Bump() ), store the return value
		if(!.) return //if it returned false, (movement failed), return false too (and stop this proc)

		if(isobj(Z))

			if(istype(Z,/obj/ranged))
				var/obj/ranged/R=Z
/*
				if(R.dir==dir)
					if(R.Belongs_To==Belongs_To)
						R.density=0
						world << "Debug: Beam is bumping into another Beam object [R] [R.type] Dens:[R.density]"

				if(R.dir==dir)
					if(R.icon_state=="struggle")
						if(R.Damage<Damage) del(R)
							//else if (R.Damage>=Damage) del(src)
*/
				if(R.dir!=dir)
					icon_state="struggle"
					R.icon_state="struggle"
					layer=MOB_LAYER+2
					R.layer=MOB_LAYER+2

					if(R.Damage<Damage&&prob(70))
						walk(src,dir,10)
						for(var/obj/ranged/Beam/B in get_step(R,turn(R.dir,180)))
							B.icon_state="struggle"
							break
						del(R)
						return
				if(R)
					if(R.dir==dir&&R.icon_state=="struggle")
						if(R.Damage<Damage)
							del(R)
							return

			else //if(isobj(A)&&!istype(A,/obj/ranged))

				if(isnum(Z.Health))

					Z.Health-=Power*(Damage/Power)*0.002
					Z.Health-=Damage
					if(Z.Health<=0)
						new/obj/BigCrater(locate(Z.x,Z.y,Z.z))
						del(Z)
						return

					if(Z)
						if(!Piercer&&Z.density)
							del(src)
							return

		else if(ismob(Z)||istype(Z,/NPC_AI))

			var/mob/A=Z // This -seems- entirely redundant, but if not done, the GrabbedMob check will not function.
			if(A.GrabbedMob && A.isGrabbing==1) A=A.GrabbedMob // If the mob the beam is hitting is holding someone, destroy them first.

			if(A.immortal) return // if they're not supposed to die, do no damage.

			// Shield damage calculations

			//for(var/obj/Shield/S in A)
				//if(S.Using&&A.Ki>10)
					//var/dmg = Damage / 3 //Slight nerf to the damage of the beam as its impact is softened by the barrier.
					//A.Ki-=(A.MaxKi*0.005)*(dmg/(A.BP*A.Res)) //Slightly nerfed the number of ki points removed per hit.
					//del(src)
					//return

			// Force Field damage calculations

			for(var/obj/items/Force_Field/S in A)
				if(S.Level>0)// if(S.suffix)
					S.Level = max(0, (S.Level - Damage*0.01) ) // damage
					S.desc = initial(S.desc)+"<br>[Commas(S.Level)] Battery Remaining"
					del(src)
					return

			if(isnum(A.Health))

				if(A.immortal) return // if they're not supposed to die, do no damage.

				var/DMG = Damage/(1+(A.BP*A.Res))
				A.Health-=DMG
				var/L = list("Random")
				A.Injure_Hurt(DMG,L)
				if(A.Health<=0)
					A.KO(Belongs_To)
			if(Paralysis)
				A<<"You become paralyzed"
				A.Frozen=1

			if(A.icon_state=="KO"&&A.client)

				if(A.immortal) return // if they're not supposed to die, do no damage.

				A.Life-=1*(Damage/(A.Base*A.Body*A.Res))
				if(A.Life<=2)
					if(A.Regenerate)
						if(A.BP*20*A.Regenerate<Power)
							A.Dead=1
					A.Death(Belongs_To)
					spawn(0) A.immortality(time=3) // make them immortal for 3 seconds
					return

			else if(!A.client&&A.Frozen)

				if(A.immortal) return // if they're not supposed to die, do no damage.

				var/RES = A.Res * 1.25
				A.Life-=1*(Damage/(A.Base*A.Body*RES))
				if(A.Life<=0)
					if(A.Regenerate)
						if(A.BP*20*A.Regenerate<Power)
							A.Dead=1
					A.Death(Belongs_To)
					return


			if(!Piercer)
				if(src)
					del(src)
					return

		else if(isturf(Z)&&Z.density)
			if(isnum(Z.Health))
				if(Power < 2)
					del(src)
					return
				Z.Health-=Power*(Damage/Power)*0.001 //BP * Force/1000 (Force assumed to be 1000 on average for this)

				//if(istype(src,/obj/Blast/Fireball)) Power*=Wall_Strength
				//if(Power>Z.Health) Z.Health=0
				if(Z.Health<=0)
					var/turf/B=Z
					if(usr!=0)
						B.Destroy(usr,usr.key)
						return
					else
						B.Destroy("Unknown","Unknown")
						return

				if(Z) if(!Piercer&&Z.density)
					del(src)
					return



	proc/beam_appearance()

		//var/d = turn(src.dir,180)
		if(icon_state!="struggle"&&Beam)
			if(!(locate(/obj/ranged/Beam) in get_step(src,dir))) icon_state="head" //If the next step doesn't have a Beam object in it, then the current object should be the 'head' of the beam
			//else if(locate(/obj/ranged/Beam) in get_step(src,dir)) icon_state="tail" // These two lines have been commented out because of a weird glitch causes every beam icon to change into icon_sate 'end'. Suspect this is because everything works much faster now.
			//else if(!locate(/obj/ranged/Beam) in get_step(src.dir,d)) icon_state="end" //If there's no Beam object BEHIND the current one, the current one is the end of the beam.
			//else if(locate(owner) in in get_step(src,d)) icon_state="origin"
			else
				icon_state="tail" //The others are its tail

		for(var/obj/ranged/Beam/B in get_step(src,dir))
			if(B.origin.Belongs_To!=src.origin.Belongs_To)
				B.icon_state="struggle"

		for(var/obj/ranged/Beam/C in get_step(src,dir))
			if(C.dir==dir)
				icon_state="tail"
				layer=MOB_LAYER+1

		for(var/obj/ranged/Beam/C in get_step(src,turn(dir,180)))
			if(C.dir==dir&&C.icon_state=="struggle")
				C.icon_state="tail"
				C.layer=MOB_LAYER+1



	proc/shoot()
		var/dense[0]
		for(var/atom/a in src.loc)
			if(istype(a,/obj/ranged)&&a.dir==dir) continue
			else if(a.density && a != src) dense+=a
		for(var/turf/a in range(0,src))
			if(a.density && a != src) dense+=a
		for(var/obj/ranged/a in range(0,src))
			//if(a != src && a.Belongs_To)
			if(a.dir != src.dir) dense+=a

		if(dense.len)
			for(var/atom/a in dense)
				src.Bump(a)


	proc/beamVariables(obj/Attacks/A,mob/P)
		luminosity=(A.luminosity)
		animate_movement=0
		layer=MOB_LAYER+1
		//B.icon_state="origin"
		density=0 // original at 0
		Beam=1
		Piercer=A.Piercer
		Damage=P.BP*P.Pow*A.chargelvl*A.WaveMult*global.Ki_Power
		Power=P.BP*A.chargelvl*A.WaveMult*global.Ki_Power
		Offense=P.Off
		maxSteps=A.MaxDistance
		origin=A
		owner=P
		kiDrain=A.KiReq


mob/proc

	Beam_Macro(obj/Attacks/Beam/O)
		if(icon_state in list("Meditate","Train","KO","KB")) return
		if(src.Ki<O.KiReq||src.Frozen) return
		for(var/obj/Attacks/A in src) if(A!=O) if(A.charging|A.streaming) return
		if(!O.charging&&!attacking)
			usr.BeamCharge(O)
			hearers(6,usr) << 'basicbeam_chargeoriginal.wav'
			for(var/mob/M in range(20,usr))
				M << "[usr] begins to charge a beam!"
				M.saveToLog("[key_name(M)] [usr] begins to charge a beam! - ([usr.x],[usr.y],[usr.z])\n")
		else if(!O.streaming&&O.charging&&src.attacking)
			usr.BeamStream(O)
			hearers(6,usr) << 'basicbeam_fire.wav'
			for(var/mob/M in range(20,usr))
				M << "[usr] fires their beam!"
				M.saveToLog("[key_name(M)] [usr] fires their beam! - ([usr.x],[usr.y],[usr.z])\n")
		else if(O.streaming)
			usr.BeamStop(O)

	BeamCharge(obj/Attacks/A)
		if(Beam_Refire_Delay_Active) return
		A.Experience=1 //Makes them fully mastered from the start.
		A.charging=1
		attacking=2 //Was 3
		overlays.Remove(BlastCharge,BlastCharge)
		overlays+=BlastCharge
		spawn(10) while(A.charging||A.streaming||attacking)
			sleep(1)
			if(icon_state=="KO"||Ki<A.KiReq)
			 A.charging=0
			 A.streaming=0
			 attacking=0
			 A.chargelvl=0
			 spawn(10) if(icon_state!="KO") move=1
			 src<<"You lose the energy you were charging."
			 src.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(src)] loses the energy they were charging.\n")
			 overlays-=BlastCharge
		spawn while(A.charging&&!A.streaming)
			if(!A.chargelvl||A.chargelvl<1) A.chargelvl=1
			else A.chargelvl+=A.ChargeRate
			usr<<"<b>[A] charge at [round(A.chargelvl,0.01)]x</b>"
			Ki-=A.KiReq*(A.chargelvl*A.ChargeRate)

/*
			if(A.ChargeRate<1)// Changed as of v0.0312p4. The drain of energy scales with the chargelevel.
				Ki-=A.KiReq*(A.chargelvl**(A.ChargeRate*3))
				world << "DEBUG: A.KiReq*(A.chargelvl**(A.ChargeRate*3))"
				world << "DEBUG: [A.KiReq*(A.chargelvl**(A.ChargeRate*3))] drain"
			else if (A.ChargeRate<2)
				Ki-=A.KiReq*(A.chargelvl**(A.ChargeRate*1.3))
				world << "DEBUG: A.KiReq*(A.chargelvl**(A.ChargeRate*1.3))"
				world << "DEBUG: [A.KiReq*(A.chargelvl**(A.ChargeRate*1.3))] drain"
			else
				Ki-=A.KiReq*(A.chargelvl**A.ChargeRate)
				world << "DEBUG: A.KiReq*(A.chargelvl**A.ChargeRate)"
				world << "DEBUG: [A.KiReq*(A.chargelvl**A.ChargeRate)] drain"
*/

			sleep((Refire*A.ChargeRate)/A.Experience)

	BeamStream(obj/Attacks/A)
		A.charging=0
		A.streaming=1
		overlays-=BlastCharge
		if(icon_state!="Flight") icon_state="Blast"
		if(A.MoveDelay<1) A.MoveDelay=1
		spawn while(A.streaming&&src)
			sleep(round(A.MoveDelay/A.Experience))

			if(prob(0.1*A.MoveDelay)&&A.Experience<1) A.Experience+=0.1

			var/obj/ranged/Beam/B=new(get_step(src,src.dir),src)
			B.icon=A.icon
			B.icon_state="origin"

			B.beamVariables(A,src)
			src.Ki-=B.kiDrain // ensures that even 'point blank' firing drains energy

			if(!A.Learnable)
				A.Learnable=1
				spawn(100) A.Learnable=0

			spawn(A.MoveDelay)
				if(B)
					B.icon_state="tail"
			if(B)
				spawn if(B) B.shoot()
			else
				return

			walk(B,dir,A.MoveDelay)


	BeamStop(obj/Attacks/A)
		Beam_Refire_Delay_Active=1
		spawn(50/SpdMod) if(src) Beam_Refire_Delay_Active=0
		A.charging=0
		A.streaming=0
		attacking = 1
		spawn(Refire) attacking = 0
		A.chargelvl=1
		if(icon_state=="Blast"&&icon_state!="Flight") icon_state=""
		if(icon_state!="KO") move=1


/*

// BACKUP

	BeamStream(obj/Attacks/A)
		A.charging=0
		A.streaming=1
		overlays-=BlastCharge
		if(icon_state!="Flight") icon_state="Blast"
		if(A.MoveDelay<1) A.MoveDelay=1
		spawn while(A.streaming&&src)
			if(istype(src.loc, /turf/Other/Stars))	//Beams are a viable travel method right
				inertia_dir = reverseDir(dir2text(src.dir))
				var/turf/T = get_step(src, src.inertia_dir)
				if(!T.density) step(src, src.inertia_dir)
			if(!A.Learnable)
				A.Learnable=1
				spawn(100) A.Learnable=0
			if(prob(0.1*A.MoveDelay)&&A.Experience<1) A.Experience+=0.1
			sleep(round(A.MoveDelay/A.Experience))
			var/obj/ranged/Beam/B=new

			B.icon=A.icon
			B.luminosity=(A.luminosity)
			B.animate_movement=0
			B.layer=MOB_LAYER+1
			B.icon_state="origin"
			B.density=0 // original at 0
			B.Beam=1
			B.Piercer=A.Piercer
			B.dir=dir
			B.Damage=BP*Pow*A.chargelvl*A.WaveMult*Ki_Power
			B.Power=BP*A.chargelvl*A.WaveMult*Ki_Power
			B.Offense=Off
			B.Belongs_To=src
			B.loc=get_step(src,dir)
			B.maxSteps=A.MaxDistance

			//walk(B,dir,round(A.MoveDelay/A.Experience))
			//spawn(round(A.MoveDelay/A.Experience))
			walk(B,dir,A.MoveDelay)

			spawn(A.MoveDelay)
				if(B)
					B.icon_state="tail"
					//spawn(1) walk(B,src.dir)
					B.beam_objects()
			Ki-=A.KiReq
			//spawn(A.MaxDistance*0.5) if(B) del(B)
			if(Ki<=0) BeamStop(A)



*/