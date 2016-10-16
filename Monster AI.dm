///mob/verb/persh()	//Oops teehee
//	new /mob/npc(locate(usr.x,usr.y,usr.z))
/*
/mob/npc/
	name = "Generic NPC"
	desc = "A Generic NPC that hasn't had any variables set. Probably looks like a frog!"
	icon	=	'Animal, Frog.dmi'	//If you see frogs, you forgot an icon. Or it's a frog.
	icon_state	=	""
	luminosity	=	0	//Frog does not glow. A demon that is on fire on the other hand, might!
						//If you want them to glow/not glow depending on.. whatever, use
						//sd_SetLuminosity(brightness)	okay? thank you~~~
	//NPC stats
	Health	= 100
	BP	= 5
	Str	= 50
	End	= 500
	Res	= 100
	Spd	= 50	//Divided by 50 nets their movement rate per update, can be less then 1
	Off	= 30
	Def	= 10
	var/Respawn_Timer	= 3000	//How long after death do we respawn, in 1/10 of seconds
	var/Invulnerable	= 0	//Can we be attacked or die? 1 if so

	//Other
	#define PEACEFUL 0	//Won't fight back
	#define NEUTRAL 1	//Will fight back
	#define AGGRESSIVE 2	//Will fight back and KILL
	var/Aggression = PEACEFUL
	var/ProcessingDelay	=	2	//Admins can change this, also adjustable per npc I guess?
	var/Enlarged =	0	//Are we enlarged by an admin proc or otherwise? 1 if so
	var/Can_Blast =	0	//Can we shoot us some balls?
	var/Flyer	=	0	//Are we able to fly? Dragons~

	var/obj/items/Door_Pass/ID = new()	//All npcs can have a 'password' to get in places by modifying the door_pass they all now carry

	//Pathfinding
	var/Strict = 0				//if you want NPC to only move when commanded
	var/mode = 0				//0 = idle/ready
								//1 = pickup/drop
								//2 = moving
								//3 = returning to home
								//4 = blocked
								//5 = computing navigation
								//6 = waiting for nav computation
								//7 = no destination found
	var/path[] = new()			//List of turfs in path, usually reversed
	var/atom/target				//our current movement target
	var/destination = ""		//destination tag
	var/home_destination = "" 	//tag of home
	var/atom/home				//Whatever home may be...
	var/blockcount	=	0		//how many times did pathfinding fail
	var/reached_target =	0	//Are we THERE yet?
	var/minFollowDist = 0		//How far away from our targets do we stay, useful for ranged attack mobs

	//These are inherited by all npc mobs, golly geebers!
	New()
		..()
		while(!WorldLoaded)
			sleep(10)
		while(processAI)
			src.process()
			sleep(ProcessingDelay)
	proc
		pickup(var/obj/O)
			//Code this
		drop()
			//Code this too
		// calculates a path to the current destination
		// given an optional turf to avoid
		calc_path(var/turf/avoid = null, var/minDistance = 0)
			src.path = AStar(src.loc, src.target, /turf/proc/CardinalTurfsWithAccess, /turf/proc/Distance, minDistance, 250, id=src.ID, exclude=avoid)
			src.path = reverselist(src.path)
		// sets the current destination
		set_destination(var/atom/A)
			if(istype(A, /turf/) && !A.density)	//Can't navigate to a wall or something
				src.target = A
				src.destination = A.name
				src.mode = 2
			else if(istype(A, /mob/))	//You CAN navigate to a mob however, path is recalculated every step making this VERY EXPENSIVE
				src.target = A			//PS it is buggy so just navigate to mobs turf for now ok?
				src.destination = A.name
				src.mode = 2
		at_target()
			if(!reached_target)
				reached_target = 1
				target = null

			//Perhaps have an auto-return to home here
			//If the bot was only sent to drop an item off\

			//Maybe later!
			//Until then we're just going to chill here.
			mode = 0

			return
		process()
			switch(mode)
				if(0)		// idle
					if(prob(5) && !Strict)
						step_rand(src)
				if(1)		// picking up or dropping item
					return
				if(2,3,4)		// navigating to target, home, or blocked
					if(loc == target)		// reached target
						at_target()
						return
					else if(path.len > 0 && target)		// valid path
						var/turf/next = path[1]
						reached_target = 0
						if(next == loc)
							path -= next
							return

						if(istype(next, /turf/))
							var/moved = step_towards(src, next)	// attempt to move
							if(moved)	// successful move
								blockcount = 0
								path -= loc
								//if(mode==4)
									//We might report back that we're stuck here
									//If our owner has a scouter or something
									//Maybe we can flash a big red icon on a computer screen
									//in our owners batcave!

								if(destination == home_destination)
									mode = 3
								else
									mode = 2

							else		// failed to move
								blockcount++
								mode = 4
								//if(blockcount == 3)
									//They're annoyed

								if(blockcount > 5)	// attempt 5 times before recomputing
									// find new path excluding blocked turf
									//Time to try something else...
									spawn(2)
										calc_path(next)
										//if(path.len > 0)
											//Oh god I'm so happy how can I express this
											//If only I could formulate words!
											//Maybe I could tell my owner over a radio!
											//Should invent one of those!
										mode = 4
									mode =6
									return
								return
						else
							//We could have them say something here
							//world << "Bad turf."
							mode = 5
							return
					else
						//world << "No path."
						mode = 5
						return

				if(5)		// calculate new path
					//world << "Calc new path."
					mode = 6
					spawn(0)

						calc_path()

						if(path.len > 0)
							blockcount = 0
							mode = 4
							//Delightful! Onward!
						else
							//Goddamnit fuck yo pathfinder
							mode = 7
				if(6)
					//world << "Pending path calc."
					//Pathfinder is still calculating if we're here.
				if(7)
					//world << "No dest / no route."
					//We would alert our owner that we have no way of getting to their destination here
					mode = 0
			return
mob/Bat
	icon='Animal Bat.dmi'
	Health=100
	BP=20
	Str=50
	End=500
	Res=100
	Spd=50
	Off=30
	Def=10
	density=0
	Spawn_Timer=3000
	Cow
		icon='Animal Cow.dmi'
		Health=100
		BP=20
		Str=50
		End=500
		Res=100
		Spd=50
		Off=30
		Def=10
		Spawn_Timer=3000
		New()
			..()
	Turtle
	icon='Turtle.dmi'
	Health=100
	BP=20
	Str=50
	End=500
	Res=100
	Spd=50
	Off=30
	Def=10
	Spawn_Timer=3000
	/Del()
		var/obj/items/Weights/A=new
		A.Weight=rand(50,1000)
		A.icon='Turtle Shell.dmi'
		A.name="[A.Weight]lb Turtle Shell"
		A.loc=loc
		A.dir=NORTH
		..()
*/
//Everything above here isn't done yet so don't fuck with it!
//Everything below here is fucking stupid

mob/var/tmp/Can_Blast=1
mob/var/Flyer

/*mob/proc/NPC_Blast()
	if(Frozen) return
	var/obj/Blast/A=new
	A.Owner=src
	A.pixel_x=rand(-16,16)
	A.pixel_y=rand(-16,16)
	A.icon='18.dmi'
	A.icon+=rgb(200,50,200)
	A.Damage=50*BP*Pow
	A.Power=50*BP
	A.Offense=Off
	A.Shockwave=1
	A.Explosive=1
	A.dir=dir
	A.loc=loc
	walk(A,A.dir)*/

mob/var/Docile //Certain predatory NPCs are docile until attacked, 10% are aggressive anyway.

mob/proc/AI() while(src&&!sim)
	var/mob/A
	sleep(10)
	//if(!A.client in view(30)) break
	//if(Diarea) Diarea()
	if(Health<100&&Docile) Docile=0
	if(Zombied&&prob(10)) for(var/mob/B in orange(5,src)) if(B.client)
		if(name=="Hunter") B<<sound('Zombie Hunter.wav')
		else if(name=="Licker") B<<sound('Zombie Licker.wav')
		else if(name=="Tyrant") B<<sound('Zombie Tyrant.WAV')
		else if(name=="Nemesis") B<<sound('Zombie Nemesis.wav')
		else if(name=="Mr X") B<<sound('Zombie X.WAV')
		else B<<sound(pick('Zombie 1.wav','Zombie 2.wav','Zombie 3.wav','Zombie 4.wav'))
	if(Target&&prob(20))
		if(Flyer&&!(Target in oview(1,src))) density=0
		step_towards(src,Target)
		if(!density) density=1
		sleep(5)
	else
		//var/mob/A
		if(prob(0.05)&&BP<initial(BP)*10) BP*=1.2
		if(Zombied&&Flyer&&prob(0.05)) for(var/turf/T in range(0,src)) if(!T.Water) Mutate()
		for(A in oview(30,src)) if(!A.client) break
		if(!KB)
			if(Docile){step_rand(src)}
			else
				for(A in oview(5,src)) if(A.client) break
				if(A&&prob(90))
					if(Flyer&&!(locate(A) in oview(1,src))) density=0
					else density=1
					step_towards(src,A)
					if(!density) density=1
				else
					if(Flyer) density=0
					step_rand(src)
					density=1
			//if(A&&!(A in view(3,src))&&prob(20)&&Can_Blast) NPC_Blast()
		if(A) sleep(7/SpdMod)
		else sleep(NPC_Delay*(rand(30,50)/SpdMod))
var/NPC_Delay=1

mob/Bump(mob/A)
	if(istype(A,/obj/Final_Realm_Portal))
		loc=locate(rand(163,173),rand(183,193),5)
		if(src.inertia_dir)
			src.inertia_dir=0
		return
	if(istype(A,/obj/Warper))
		var/obj/Warper/B=A
		loc=locate(B.gotox,B.gotoy,B.gotoz)
	if(client&&istype(A,/obj/Turfs/Door))
		var/obj/Turfs/Door/B=A
		for(var/obj/items/Door_Pass/D in src) if(D.Password==B.Password)
			B.Open()
			return
		if(B.Password)
			var/Guess=input(src,"You must know the password to enter here") as text
			if(B) if(Guess!=B.Password) return
		if(B) B.Open()
	if(istype(A,/obj/Ships/Ship))
		var/obj/Ships/Ship/B=A
		for(var/obj/Airlock/C) if(C.Ship==B.Ship)
			view(src)<<"[src] enters the ship"
			if(src.inertia_dir)
				src.inertia_dir=0	//If they entered from space\
				src.last_move=null
			loc=locate(C.x,C.y-1,C.z)
			break
	if(istype(A,/obj/AndroidShips/Ship))
		var/obj/AndroidShips/Ship/B=A
		for(var/obj/AndroidAirlock/C) if(C.Ship==B.Ship)
			view(src)<<"[src] enters the ship"
			if(src.inertia_dir)
				src.inertia_dir=0	//If they entered from space\
				src.last_move=null
			loc=locate(C.x,C.y-1,C.z)
			break
	if(ismob(A)) if(!client|icon=='Oozbody.dmi') if(!istype(src,/mob/Cat))
		if(!(type==/mob/Enemy/Zombie&&A.type==/mob/Enemy/Zombie)) MeleeAttack()
		if(sim&&A.Health<=20)
			usr<<"Simulator: Simulation cancelled due to safety protocols."
			del(src)
		if(A&&istype(src,/mob/Enemy)&&A.icon_state=="KO"&&prob(1)) spawn A.Death(src)
	if(istype(A,/obj/Planets))
		Bump_Planet(A,src)
		src.Heart_Virus()
	if(isobj(A)&&istype(src,/mob/Enemy))
		var/Old_Strength=Str
		Str*=1000
		MeleeAttack()//Busting down objects.
		Str=Old_Strength

mob/Enemy
	attackable=1
	move=1
	Str=20
	End=60
	Res=10
	Spd=50
	Off=50
	Def=10
	Health=100
	Spawn_Timer=3000
	New()
		if(prob(10)&&!Zombied) spawn if(src&&!Enlarged)
			Enlarged=1
			Enlarge_Icon()
			BP*=2
		spawn if(src) AI()
		var/obj/Resources/B=new(src)
		B.Value=rand(50,200)
		if(prob(20)) B.Value*=10
		BP*=0.01*rand(80,120)
		//..()
	Del()
		if(!sim)
			for(var/obj/A in src)
				A.loc=loc
				if(istype(A,/obj/Resources))
					A.Savable=0
					var/obj/Resources/R=A
					R.name="[Commas(R.Value)] Resources"
				if(A.type==/obj/Stun_Chip) del(A)
			Leave_Body()
		..()
	Dino_Munky
		name="Dino Munky"
		icon='Oozarou.dmi'
		icon_state="Dino Munky"
		BP=100
		P_BagG=3
		Can_Blast=0
		New()
			if(prob(90)) Docile=1
			..()
	Robot
		Race="Robot"
		icon='Gochekbots.dmi'
		icon_state="3"
		BP=6
		P_BagG=3
	Big_Robot
		Race="Robot"
		icon='Gochekbots.dmi'
		icon_state="4"
		BP=12
		P_BagG=3
	Hover_Robot
		Race="Robot"
		icon='Gochekbots.dmi'
		icon_state="5"
		BP=16
		P_BagG=3
	Gremlin
		Race="Gremlin!"
		icon='GochekMonster.dmi'
		icon_state="1"
		BP=1
		P_BagG=3
		Can_Blast=0
		New()
			if(prob(90)) Docile=1
			..()
	Saibaman
		Race="Saibaman"
		icon='Saibaman.dmi'
		BP=120
		P_BagG=3.3
		New()
			if(prob(90)) Docile=1
			..()
	Small_Saibaman
		Race="Saibaman"
		icon='Small Saiba.dmi'
		BP=24
		P_BagG=3.1
		New()
			if(prob(90)) Docile=1
			..()
	Black_Saibaman
		Race="Saibaman"
		icon='Black Saiba.dmi'
		BP=240
		P_BagG=4
	Mutated_Saibaman
		Race="Saibaman"
		icon='Green Saibaman.dmi'
		BP=180
		P_BagG=3.5
		New()
			if(prob(90)) Docile=1
			..()
	Evil_Entity
		Race="???"
		icon='Evil Man.dmi'
		BP=1000
		P_BagG=10
	Bandit
		Race="Human"
		icon='Tan male.dmi'
		BP=20
		P_BagG=3
		Can_Blast=0
		New()
			if(prob(50)) Docile=1
			..()
	Tiger_Bandit
		Race="Tiger Man"
		icon='Tiger Man.dmi'
		BP=3
		P_BagG=3
		Can_Blast=0
		New()
			if(prob(90)) Docile=1
			..()
	Night_Wolf
		Race="Night Wolf"
		icon='Wolf.dmi'
		BP=4
		P_BagG=3
		Can_Blast=0
		New()
			if(prob(90)) Docile=1
			..()
	Giant_Robot
		Race="Robot"
		icon='Giant Robot 2.dmi'
		BP=300
		P_BagG=4
	Ice_Dragon
		Race="Robot"
		icon='Ice Robot.dmi'
		BP=1200
		P_BagG=12
	Ice_Flame
		Race="Creature"
		icon='Ice Monster.dmi'
		BP=800
		P_BagG=8
mob/Frog
	icon='Animal, Frog.dmi'
	attackable=1
	Health=100
	BP=5
	Str=50
	End=500
	Res=100
	Spd=50
	Off=30
	Def=10
	Spawn_Timer=3000
	//New()
	//	spawn Turtle()
		//..()
	/*proc/Turtle()
		spawn while(src)
			if(Health<=0) del(src)
			sleep(10)
		spawn while(src)
			if(Health<90)
				spawn AI()
				return
			var/mob/A
			for(A in oview(src)) if(A.client) break
			for(A in view(30))
				if(!A.client) break
			step_rand(src)
			if(A) sleep(rand(10,15))
			else sleep(50)
	*/
mob/Dino_Bird
	icon='Animal DinoBird.dmi'
	attackable=1
	Health=100
	BP=20
	Str=50
	End=500
	Res=100
	Spd=50
	Off=30
	Def=10
	Spawn_Timer=3000
	New()
		spawn Turtle()
		//..()
	proc/Turtle()
		spawn while(src)
			if(Health<=0) del(src)
			sleep(10)
		spawn while(src)
			if(Health<90)
				spawn AI()
				return
			var/mob/A
			for(A in oview(src)) if(A.client) break
			for(A in oview(30,src)) if(!A.client) break
			step_rand(src)
			if(A) sleep(rand(10,15))
			else sleep(50)
mob/Cat
	icon='Cat.dmi'
	attackable=1
	Health=100
	BP=20
	Str=50
	End=500
	Res=100
	Spd=50
	Off=30
	Def=10
	var/Mode=1
	Spawn_Timer=3000
	New()
		Mode=pick(0,4)
		spawn Cat()
		//..()
	proc/Cat()
		var/mob/C
		spawn while(src)
			if(Health<=0) del(src)
			sleep(10)
		spawn while(src)
			for(C in oview(30,src)) if(!C.client) break
			if(prob(0.1)) Mode=pick(0,4)
			if(Health<95)
				Mode=4
				Health+=0.5
			if(Mode==1) step_rand(src)
			if(Mode==2)
				if(icon_state!="Sleep") view(src)<<"<font color=#FFFF00>*[src] yawns and goes to sleep*"
				icon_state="Sleep"
			else icon_state=""
			if(Mode==3) for(var/mob/A in oview(src)) if(!istype(A,/mob/Enemy))
				if(prob(5)) view(src)<<"<font color=#FFFF00>*[src] purrs*"
				step_towards(src,A)
				break
			if(Mode==4) for(var/mob/A in oview(src))
				if(prob(5)) view(src)<<"[src]: hiss!!!"
				step_away(src,A,5)
				break
			var/mob/A
			for(A in oview(src)) if(A.client) break
			if(A) sleep(rand(4,5))
			else sleep(50)
	Del()
		if(icon) icon=null
		..()
mob/Bat
	icon='Animal Bat.dmi'
	Health=100
	BP=20
	Str=50
	End=500
	Res=100
	Spd=50
	Off=30
	Def=10
	density=0
	Spawn_Timer=3000
	New()
		spawn Turtle()
		//..()
	proc/Turtle()
		spawn while(src)
			if(Health<=0) del(src)
			sleep(10)
		spawn while(src)
			if(Health<90)
				spawn AI()
				return
			var/mob/A
			for(A in oview(src)) if(A.client) break
			for(A in oview(30,src)) if(!A.client) break
			step_rand(src)
			if(A) sleep(rand(4,6))
			else sleep(50)
mob/Cow
	icon='Animal Cow.dmi'
	Health=100
	BP=20
	Str=50
	End=500
	Res=100
	Spd=50
	Off=30
	Def=10
	Spawn_Timer=3000
	New()
		spawn Turtle()
		//..()
	proc/Turtle()
		spawn while(src)
			if(Health<=0) del(src)
			sleep(10)
		spawn while(src)
			if(Health<90)
				spawn AI()
				return
			var/mob/A
			for(A in oview(src)) if(A.client) break
			for(A in oview(30,src)) if(!A.client) break
			step_rand(src)
			if(A) sleep(rand(20,30))
			else sleep(50)


mob/Turtle
	icon='Turtle.dmi'
	Health=100
	BP=20
	Str=50
	End=500
	Res=100
	Spd=50
	Off=30
	Def=10
	Spawn_Timer=3000
	New()
		spawn Turtle()
		//..()
	proc/Turtle()
		var/mob/A
		while(src)
			if(!istype(A,/mob)) break
			if(A.client in oview(30)) break
			if(Health<=0) del(src)
			sleep(10)
			if(Health<90)
				spawn AI()
				return

			//for(A in oview(src)) if(A.client) break
			//for(A in oview(30,src)) if(!A.client) break
			step_rand(src)
			sleep(rand(20,30))
	Del()
		var/obj/items/Weights/A=new
		A.Weight=rand(50,1000)
		A.icon='Turtle Shell.dmi'
		A.name="[A.Weight]lb Turtle Shell"
		A.loc=loc
		A.dir=NORTH
		..()


mob/Dummy
	name="Log"
	icon='Dummy.dmi'
	icon_state="Off"
	BP=100
	Health=100
	End=250000
	Res=250000
	Def=0.01
	P_BagG=0.5
	New()
		Health=100
		icon_state="Off"
		//..()
	verb/Upgrade()
		set src in oview(1)
		for(var/obj/Resources/A in usr)
			var/Amount=input("How much endurance do you want to add? (Up to [Commas(A.Value)])") as num
			if(Amount>round(A.Value)) Amount=round(A.Value)
			if(Amount<0) Amount=0
			A.Value-=Amount
			Amount*=usr.Add
			Un_KO()
			Health+=Amount
			view(usr)<<"[usr] added [Commas(Amount)] to the [src]'s armor"
		desc="Health: [Health*10]"
		icon_state="Off"

mob/Punching_Bag
	icon='Punching Bag.dmi'
	BP=100
	Health=100
	End=25000
	Res=250000
	Def=0.01
	P_BagG=0.2
	New()
		Health=100
		icon_state=""
		//..()
	verb/Upgrade()
		set src in oview(1)
		for(var/obj/Resources/A in usr)
			var/Amount=input("How much endurance do you want to add? (Up to [Commas(A.Value)])") as num
			if(Amount>round(A.Value)) Amount=round(A.Value)
			if(Amount<0) Amount=0
			A.Value-=Amount
			Amount*=usr.Add
			Un_KO()
			Health+=Amount
			view(usr)<<"[usr] added [Commas(Amount)] to the [src]'s armor"
		desc="Health: [Health]"
		icon_state=""
