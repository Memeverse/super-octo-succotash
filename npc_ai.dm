/**********************************************************************************************
		NPC AI

	5 Dec 2010

NPC AI behaviour can be found here.

AdjacentDirections(dir, max_angle = 90)
	Generates a list of directories within max_angle, allows for more 'human' behaviour.

Set_Vars()
	A proc that allows the regeneration and randomization of stats for the NPCs

AI_FINDTARGET()
	Find a target within maxdist of the NPC. maxdist is defined as a variable of the NPC,
		allowing you to define how long each mob will 'chase' the player

AI_ATTACK()
	Checks if target is still within range and walks towards them. Bump actually handles the calling of MeleeAttack() and such.

AI_WANDER()
	As the name suggests, wanders about. Even the mobs that aren't hostile will walk about while looking for a player to attack.

(De)Activate_NPC_AI()
	This should also speak for itself, the AI is either activated or deactivated.

Respawn_NPC()
	After death, the mob is thrown into the area 'Death' defined in npc_areas.dm
		There, they wait for 2 minutes until they're put back where they died.
		This proc still requires some work, as just spawning where they died is a bit cheap,
		and it's not taking into account if the area is already activated and the NPC should walk around or not

-- Valekor

**********************************************************************************************/

NPC_AI
	parent_type = /mob

	var

		tmp/mob/target
		tmp/area/oldloc
		var/Unenlargeable=0
		maxdist = 12
		tmp/docile=1
		defz
		tmp/LOCKED = 0
		minwait = 10
		maxwait = 20
		tmp/active = 0
		//findtarget
		var/image/A
		var/image/B
		var/image/Hair

	proc

		AdjacentDirections(dir, max_angle = 90) // For more 'human' like behaviour, so the NPCs wont make a sudden 180 degree turn.
			. = list()
			for(var/angle = -max_angle, angle <= max_angle, angle += 45)
				. += turn(dir, angle)

		Set_Vars()
		//	Power_Check()
			sleep(10)
			Health=100
			attackable=1
			Power_Leech_On=0
			//world << "Vars set"

			if(istype(src,/NPC_AI/Docile))
				Health=100
				BP=rand(12,25)
				Str=rand(20,50)
				End=rand(300,500)
				Res=rand(50,100)
				Spd=rand(10,50)
				Off=rand(10,50)
				Def=10

				switch(Race)
					if("Frog")
						BP=rand(5,12)
						minwait = 10
						maxwait = 15
						return
					if("Dino Munky")
						BP=rand(100,150)
						return
					else
						return

			else if(istype(src,/NPC_AI/Hostile))
				docile=0
				Str=rand(10,20)
				End=rand(10,60)
				Res=10
				Spd=rand(10,50)
				Off=rand(10,50)
				Def=10

//You can use this proc to create scaling BP and power for NPC's.  To set the position of a mob in terms of relative power to them, when calculating their personal power
						  //simply divide by where you want them to go on the "ranks".  IE:  50 would be *(1/2). -  Arch
				switch(Race)

					if("Shade")

						BP=ScalingPower*4.5
						Str=ScalingStats*2
						End=ScalingStats*1.5
						Res=ScalingStats*3
						Off=ScalingStats*15
						Def=ScalingStats*2
						/*Str=ScalingStr*(2)
						End=ScalingEnd*(1.5)
						Res=ScalingRes*(3)
						Off=ScalingOff*15
						Def=ScalingDef*(2)  rand(1000,25000)*/
						P_BagG=6.5
						return

					if("Infernal Plantman")
						BP=ScalingPower*(1/2)
						Str=ScalingStats*(1.2)
						End=ScalingStats*(1/5)
						Res=ScalingStats*(1/10)
						Off=ScalingStats
						Def=ScalingStats*(1/2)

					        //	BP=rand(220,280)
						P_BagG=3
						return

					if("Evil Entity")
						BP=ScalingPower*(4.5)
						Str=ScalingStats*4
						End=ScalingStats
						Res=ScalingStats
						Off=ScalingStats*10
						Def=ScalingStats*2
						//BP=rand(900,1200)
						P_BagG=7
						return

					if("Giant Robot")
						//BP=rand(220,350)
						BP=ScalingPower*(1/3)
						Str=ScalingStats*(1/2)
						End=ScalingStats*(3/4)
						Res=ScalingStats*(1/2)
						Off=ScalingStats*(1/4)
						Def=ScalingStats*(1/4)
						P_BagG=6
						return

					if("Gremlin")
						BP=rand(1,3)
						P_BagG=3
						return

					if("Ice Dragon")
						BP=ScalingPower*(4/5)
						Str=ScalingStats*2
						End=ScalingStats*2
						Res=ScalingStats*(1/2)
						Off=ScalingStats*(5/10)
						Def=ScalingStats
						//BP=rand(1000,1500)
						P_BagG=6
						return

					if("Ice Flame")
						BP=ScalingPower*(4/5)
						Str=ScalingStats*(4/5)
						End=ScalingStats*(4/5)
						Res=ScalingStats
						Off=ScalingStats*(1.2)
						Def=ScalingStats*(4/5)

						//BP=rand(700,900)
						P_BagG=4
						return

					if("Mutated Plantman")
						BP=rand(150,200)
						P_BagG=3
						return

					if("Night Wolf")
						BP=rand(2,5)
						P_BagG=3
						return

					if("Robot")
						BP=rand(6,12)
						P_BagG=3
						return

					if("Plantman")
						BP=rand(100,150)
						P_BagG=5
						return

					if("Small Plantman")
						BP=rand(20,30)
						P_BagG=4
						return

					if("Tiger Bandit")
						BP=ScalingPower*(0.2)
						Str=ScalingStats*(0.4)
						End=ScalingStats*(0.3)
						Res=ScalingStats*(0.1)
						Off=ScalingStats*(0.2)
						Def=ScalingStats*(0.2)

						//BP=rand(3,7)
						P_BagG=3
						return

					if("RRBandit")
						BP=ScalingPower*(0.5)
						Str=ScalingStats*(0.5)
						End=ScalingStats*(0.5)
						Res=ScalingStats*(0.5)
						Off=ScalingStats*(0.5)
						Def=ScalingStats*(0.5)
						P_BagG=4
						Unenlargeable=1
						var/image/A=image(icon='Red Reaver Goggles.dmi')
						var/image/Hair=pick('Hair_SSj4.dmi','New Hair.dmi','GT Goten Hair.dmi')
						var/image/B=image(icon='Bandit Armor.dmi')
						overlays.Add(B,Hair,A)
						return

					if("Bandit")
						BP=10
						Unenlargeable=1
						icon=pick('White Male.dmi','Tan male.dmi','Black male.dmi')
						var/image/A=image(icon='Bandit Armor.dmi')
						Hair_Base=pick('Hair_SSj4.dmi','New Hair.dmi','GT Goten Hair.dmi')
						var/image/Hair=Hair_Base
						overlays.Add(A,Hair)
						if(prob(30))
							var/image/B=image(icon='Item - Sun Glassess.dmi')
							overlays.Add(B)
						P_BagG=3

					else
						BP=rand(12,25)
						return
				return


		AI_FINDTARGET()
			for(var/mob/player/P in oview(src,maxdist)) // find players
			//for(var/NPC_AI/P in oview(src,maxdist)) // find other AI
				sleep(25)  //Amount of CPU usage is very high, added a sleep to see if it'd help alleviate lag.
				return P

		AI_ATTACK()

			while(target&&active)

				if(get_dist(src,target) > maxdist)
					target=null
					if(istype(src,/NPC_AI/Docile)) docile=1
					spawn(1) AI_WANDER()
				//	world<<"Max distance to target exceeded.  Setting to AI wander."
					break

				if(target.z != src.z)
					target=null
					if(istype(src,/NPC_AI/Docile)) docile=1
					spawn(1) AI_WANDER()
				//	world<<"Different Z level.  Setting to AI wander."
					break


				if(!target) // Target ran away/escaped the area, but there are still players in the area
							// So instead we'll walk around in search of new prey.
					step(src,0)
					target = null
					Health= 100
					if(istype(src,/NPC_AI/Docile)) docile=1
					spawn(1) AI_WANDER()
				//	world<<"Setting to AI docile wander 3"
					break

				var/wait = rand(minwait,maxwait) // Not ever mob has the same delay
				var/turf/T = get_step_to(src,target) // Look at the Turf and Area it plans to go to next.
				var/area/NPC_AI/A = T ? (T.loc) : null  //If it's not within its own area, then dont go there.

				if(Frozen) // Dont want them to stop trying to walk when they're frozen/KO
					sleep(wait)
					return

				if(target)
					if(target.BP > BP+1000) // Run awayyyyyyyyy
						step_away(src,target, 25)
				//		world<<"Running away from target"
					else if(get_dist(src,target) <= 2 && A && loc && A.awake)
						walk_towards(src,target,wait)
					//	world<<"Moving towards [target]"
					else if(A && loc && A.awake)
						step_to(src,target, 0)
						//world<<"[src] moving to [target]"
					else
						target=null
					//	world<<"Resetting target"

				sleep(wait)

		AI_WANDER()
			while(!target&&active)

				var/wait = rand(minwait,maxwait) // Not ever mob has the same delay

				if(!docile&&!target)
					target = AI_FINDTARGET()

				if(target)
					spawn(2) AI_ATTACK()
					break

				// I've placed the vars here on purpose.
				// There's no need to affix these if any of the above would normally halt behaviour.

				var/list/stepto = AdjacentDirections(dir) // Get a list of directions within 90 degrees.
				var/list/direc = stepto[rand(1,stepto.len)] // Chose one of the five direction outputs
				var/turf/T = get_step(src, direc) // Look at the Turf and Area it plans to go to next.
				var/area/NPC_AI/A = T ? (T.loc) : null // If it's not within its own area, then dont go there.

				if(Frozen||icon_state=="KO"||icon_state=="KB")
					sleep(wait)
					return

				if(A && loc && A.awake && !Frozen)
					step(src,direc)

				sleep(wait)


		Activate_NPC_AI()
			active=1
			//world << "NPC AI: \green ON"
			if(!target)
			//	world<<"Activating Wander Code"
				spawn AI_WANDER()
			else
				//world<<"Activating attack code"
				spawn AI_ATTACK()
/*
			spawn while(active)

				if(!target&&!wander)
					wander=1

				if(wander)
					AI_WANDER()

				if(target)
					AI_ATTACK()

				sleep(30)
*/

		Deactivate_NPC_AI()

			//world << "NPC AI: \red OFF"
			active = null
			target = null
			Health = 100


//Was commented out for respawn mechs-------------
		Respawn_NPC() // Doesn't yet work as I'd like it to. But it works.

			Set_Vars() // Regenerate their stats
			loc = locate(oldloc.x,oldloc.y,oldloc.z)
			if(active==1)
				if(!target)
					spawn AI_WANDER()
				else
					spawn AI_ATTACK()

//Was commented out for respawn mechs--------------
	Bump(atom/A)
		if(ismob(A))
			if(LOCKED)return
			if(Frozen)return // If the mob is KO'd
			var
				mob/M = A
			if(!(M.client)) return

			if( M.Health <= 0)
				M.Health = null
				step(src, 0)
				target = null
				M.Death(src)
				docile = 1
				M = null
				return

			if(sim&&Health <= 0)
				del(src)
				return

			if(target&&sim&&target.Health<=20)
				target<<"Simulator: Simulation cancelled due to safety protocols."
				del(src)
				return

			if(target)
				flick('Zanzoken.dmi',src)
				MeleeAttack()

			LOCKED = 1
			spawn(10) if(src)
				LOCKED = null


	New()
		spawn(rand(1,10)) Set_Vars()
		if(!istype(src,/NPC_AI/Hostile/Bandit)||!istype(src,/NPC_AI/Hostile/Red_Reaver_Bandit)) if(prob(10)) spawn if(src&&!Enlarged)//Could create a do not enlarge variable to optimize this, but may require reworking of set_var sys.
			Enlarged=1
			//Enlarge_Icon()
			BP*=2
		var/obj/Resources/B=new(src)
	//	var/obj/items/Nuke = new
		B.Value=rand(50,200)
		if(prob(20)) B.Value*=10
		//if(BP<120&&prob(90)&&istype(src,/NPC_AI/Hostile))docile=1

	Del()
		if(isnull(src)){..();return}
		if(loc==null||x==null||y==null||z==null)
			..()
			return
		if(!sim)
			for(var/obj/A in src)
				A.loc=loc
				if(istype(A,/obj/Resources))
					A.Savable=0
					var/obj/Resources/R=A
					R.name="[Commas(R.Value)] Resources"
				if(A.type==/obj/Stun_Chip) del(A)
			//Leave_Body()

		if(sim){..();return}
		overlays.Remove(A,Hair,B)
		target=null
		step(src, 0)
		defz = z
		oldloc = loc
		active=0

		loc = locate(/area/NPC_AI/Death) // Toss 'em into their own temporary death room  Was commented out, reactivated it after reading the respawn mechanics needs work portion and working with it a bit - Arch
	//	..() // Default death behaviour, premanent deletion of the mob.

		spawn(6000) Respawn_NPC()//600 = 1min; 6000=10min

		target=null  //Was commented out for respawn mechs
		Frozen = null  //Was commented out for respawn mechs
		LOCKED = null //Was commented out for respawn mechs
	//	oldloc = null//Was commented out for respawn mechs
	//	return//Was commented out for respawn mechs

/*** DOCILE NPCS ***/
	Docile
		Bat
			Race="Bat"
			icon='Animal Bat.dmi'
			density=0

		Turtle
			icon='Turtle.dmi'
			Race="Turtle"
			Del()
				var/obj/items/Weights/A=new
				A.Weight=rand(50,1000)
				A.icon='Turtle Shell.dmi'
				A.name="[A.Weight]lb Turtle Shell"
				A.loc=locate(src.x,src.y,src.z)
				A.dir=NORTH
				A.Savable=0
				..()

		Cat
			Race="Cat"
			icon='Cat.dmi'

		Cow
			Race="Cow"
			icon='Animal Cow.dmi'

		Dino_Bird
			Race="Dino Bird"
			icon='Animal DinoBird.dmi'

		Dino_Munky
			Race="Dino Munky"
			icon='Oozarou.dmi'
			icon_state="Dino Munky"

		Frog
			Race="Frog"
			icon='Animal, Frog.dmi'


/*** HOSTILE NPCS ***/

	Hostile

		Shade
			Race="Shade"
			icon='New Shadow.dmi'
		Bandit
			Race="Bandit"
			icon='White Male.dmi'
		Red_Reaver_Bandit
			Race="RRBandit"
			icon='White Male.dmi'

		Big_Robot
			Race="Big Robot"
			icon='Gochekbots.dmi'
			icon_state="4"

		Infernal_Plantman
			Race="Infernal Plantman"
			icon='Black Saiba.dmi'

		Evil_Entity
			Race="Evil Entity"
			icon='Evil Man.dmi'

		Giant_Robot
			Race="Giant Robot"
			icon='Giant Robot 2.dmi'

		Gremlin
			Race="Gremlin"
			icon='GochekMonster.dmi'
			icon_state="1"

		Hover_Robot
			Race="Hover Robot"
			icon='Gochekbots.dmi'
			icon_state="5"

		Ice_Dragon
			Race="Ice Dragon"
			icon='Ice Robot.dmi'

		Ice_Flame
			Race="Ice Flame"
			icon='Ice Monster.dmi'

		Mutated_Plantman
			Race="Mutated Plantman"
			icon='Green Saibaman.dmi'

		Night_Wolf
			Race="Night Wolf"
			icon='Wolf.dmi'

		Robot
			Race="Robot"
			icon='Gochekbots.dmi'
			icon_state="3"

		Plantman
			Race="Plantman"
			icon='Saibaman.dmi'

		Small_Plantman
			Race="Plantman"
			icon='Small Saiba.dmi'

		Tiger_Bandit
			Race="Tiger Bandit"
			icon='Tiger Man.dmi'






