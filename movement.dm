mob/proc/Boosters()
	var/turf/A=get_step(src,dir)
	if(A) if(A.density|A.Water) for(var/obj/Cybernetics/Boosters/C in src) if(C.suffix)
		for(var/obj/Cybernetics/Generator/B in src) if(B.suffix) if(B.Current>=20)
			B.Current-=20
			density=0
			spawn density=1

/*
mob/proc/Smoke_Form()
	for(var/obj/Turn_To_Smoke/T in src) if(T.Active) return 1
*/

mob/Move(NewLoc, Direct)	//Move requirements was remvoed because it was redundant
	var/atom/Former_Location = loc
	if(Frozen||forbidMovement) return
	if(afk){ src.TRIGGER_AFK(1);return }
	if(move==0) return
	if(!Target && ghostDens_check(src)) return ..()

	if(!client || KB )
		..()

/*
	else if(Smoke_Form())
		var/Original_Density = density
		density = 0
		step(src,dir)
		step(src,dir)
		density = Original_Density
*/

	else
		move=0	//If move=0 you no move ok
		var/Delay=2.5/SpdMod
		if(Health>0&&!undelayed)
			Delay*=100/Health
		if(Delay>40/SpdMod)
			Delay=40/SpdMod
		//if(Delay < 1)
			//Delay = 1
		if(icon_state=="Flight")
			density = 0
			Delay *= 0.5
			if(Super_Fly)
				Delay=0.2
	/*	Decimals += Delay-round(Delay)
		if(round(Delay)<2)
			Decimals += round(Delay)
		if(Decimals >= 2)
			Delay += 2
			Decimals -= 2*/
		//if(Delay>=0)
		//	move=0
		if(Delay >= 0.1)
			spawn(round(Delay))
				move=1
		else
			move=1
		Boosters()
		if(istype(loc, /turf/Other/Stars))
			if(icon_state == "Flight")
				if(!Super_Fly)
					if(prob(3))	//3% chance fly gets you moving in another direction
						inertia_dir = Direct
				else
					..()
					inertia_dir = 0
					//Ch-yea we flyin through space nikka
			else if(!inertia_dir)	//If you're just sitting in space, take one step to start moving
				..()
			else
				if(icon_state != "Blast")
					if(Direct)
						dir = Direct	//Dir is part of Move()
					else
						dir = get_dir(src,NewLoc)
			//else
				//Do nothing, you can't move
		else
			..()
		if(adminDensity) density=0
		else density=1

		if(!KB && Target && !inertia_dir && istype(Target,/obj/Build))
			Build_Lay(Target,src)
		Save_Location()
		for(var/obj/items/Transporter_Pad/A in loc)
			A.Transport()
		Edge_Check(Former_Location)
// AI call START
/*
/*		for(var/NPC_AI/A in oview(12) )
			if( !A.awake && !A.wander ) // If it's awake (attacking) then it's not wandering. If it's wandering then it's not attacking.
				A.target=src
				A.Activate_AI()*/
			if (A.awake && A.wander) // Sanity check?
				world.log << "DEBUG WARNING: Both 'awake' and 'wander' were at 1 ! This isn't supposed to be possible!"
				A.awake = 0
				A.wander = 0
*/
// AI call END


mob/proc/Edge_Check(turf/Former_Location)
	for(var/mob/A in loc) if(A!=src&&A.icon_state=="Flight"&&icon_state=="Flight")
		loc=Former_Location
		break
	for(var/obj/Door/A in loc) if(A.density)
		loc=Former_Location
		Bump(A)
		break
	if(icon_state!="Flight")//&&!Flyer
		var/turf/T=get_step(Former_Location,dir)
		if(T)
			if(!T.Enter(src)) return
			for(var/obj/Props/Edges/A in loc)
				if(!(A.dir in list(dir,turn(dir,90),turn(dir,-90),turn(dir,45),turn(dir,-45))))
					loc=Former_Location
					break
			for(var/obj/Props/Edges/A in Former_Location) if(A.dir in list(dir,turn(dir,45),turn(dir,-45)))
				loc=Former_Location
				break
mob/proc/Save_Location() if(z&&!Regenerating)
	src.savedX=x
	src.savedY=y
	src.savedZ=z

client/North()
	set instant = 1
	if(mob.Allow_Move(NORTH)) return ..()
client/South()
	set instant = 1
	if(mob.Allow_Move(SOUTH)) return ..()
client/East()
	set instant = 1
	if(mob.Allow_Move(EAST)) return ..()
client/West()
	set instant = 1
	if(mob.Allow_Move(WEST)) return ..()
client/Northwest()
	set instant = 1
	if(mob.Allow_Move(NORTHWEST)) return ..()
client/Northeast()
	set instant = 1
	if(mob.Allow_Move(NORTHEAST)) return ..()
client/Southwest()
	set instant = 1
	if(mob.Allow_Move(SOUTHWEST)) return ..()
client/Southeast()
	set instant = 1
	if(mob.Allow_Move(SOUTHEAST)) return ..()
mob/proc/Allow_Move(D)
//	if(locate(/obj/Michael_Jackson) in usr) return
	for(var/obj/Attacks/A in usr)
		if(A.charging||A.streaming||A.Using)
			dir=D
			return
	if(icon_state in list("KB","Train","Meditate", "KO") || !move || Frozen)
		return 0
	else if(grabberSTR&&prob(5)) for(var/mob/A in view(1,usr)) if(A.GrabbedMob==usr&&A.isGrabbing==1)
		if(prob(Str*BP*5)/grabberSTR)
			view(usr)<<"[usr] breaks free of [A]!"
			A.isGrabbing=null
			attacking=0
			A.attacking=0
			grabberSTR=null
		else
			view(src)<<"[usr] struggles against [A]"
		return 0
	else if(S&&S.Fuel>0&&!S.Moving)
		S.Moving=1
		S.MoveReset()
		if(S) if(S.z!=11)
			S.density=0
		step(S,D)
		if(S) if(S.last_move)
			S.inertia_dir = S.last_move
		if(S)
			if(S.z!=11)
				S.density=1
			S.Fuel()
	return 1