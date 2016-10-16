turf/Del()
	var/Type=type
	if(InitialType) Type=InitialType
	spawn InitialType=Type
	Builder=null
	if(Turfs) Turfs-=src
	//if(!Turfs|!Turfs.len) Turfs=null
	..()
turf/var/InitialType
var
	Earth=1
	Namek=1
	Vegeta=1
	Arconia=1
	Ice=1
	Desert=1
	Jungle=1
	Android=1
	Alien = 1
proc/Planet_Restore(Z) spawn if(1)
	if(Z==1) Earth=1
	if(Z==3) Namek=1
	if(Z==4) Vegeta=1
	if(Z==8) Arconia=1
	if(Z==12) Ice=1
	for(var/turf/A in block(locate(1,1,Z),locate(world.maxx,world.maxy,Z)))
		if(A.InitialType) new A.InitialType(A)
		if(prob(0.5)) sleep(1)
proc/Planet_Destroyed()
	if(!Earth)
		for(var/turf/A in block(locate(1,1,1),locate(world.maxx,world.maxy,1)))
			new/turf/Other/Stars(locate(A.x,A.y,A.z))
			new/area/Space(locate(A.x,A.y,A.z))
			if(prob(1)) sleep(1)
		for(var/obj/Props/A)
			if(A.z==1) del(A)

	if(!Namek)
		for(var/turf/A in block(locate(1,1,3),locate(world.maxx,world.maxy,3)))
			new/turf/Other/Stars(locate(A.x,A.y,A.z))
			new/area/Space(locate(A.x,A.y,A.z))
			if(prob(1)) sleep(1)
		for(var/obj/Props/A) if(A.z==3) del(A)

	if(!Vegeta)
		for(var/turf/A in block(locate(1,1,4),locate(world.maxx,world.maxy,4)))
			new/turf/Other/Stars(locate(A.x,A.y,A.z))
			new/area/Space(locate(A.x,A.y,A.z))
			if(prob(1)) sleep(1)
		for(var/obj/Props/A) if(A.z==4) del(A)

	if(!Arconia)
		for(var/turf/A in block(locate(1,1,8),locate(world.maxx,world.maxy,8)))
			new/turf/Other/Stars(locate(A.x,A.y,A.z))
			new/area/Space(locate(A.x,A.y,A.z))
			if(prob(1)) sleep(1)
		for(var/obj/Props/A) if(A.z==8) del(A)

	if(!Ice)
		for(var/turf/A in block(locate(1,1,12),locate(world.maxx,world.maxy,12)))
			new/turf/Other/Stars(locate(A.x,A.y,A.z))
			new/area/Space(locate(A.x,A.y,A.z))
			if(prob(1)) sleep(1)
		for(var/obj/Props/Trees/A) if(A.z==12) del(A)

/*
	if(!Earth)
		for(var/obj/Props/Edges/A) if(A.z==1) del(A)
		for(var/obj/Props/Surf/A) if(A.z==1) del(A)
		for(var/obj/Props/Trees/A) if(A.z==1) del(A)
		for(var/obj/Props/A) if(A.z==1) del(A)
	if(!Namek)
		for(var/obj/Props/Edges/A) if(A.z==3) del(A)
		for(var/obj/Props/Surf/A) if(A.z==3) del(A)
		for(var/obj/Props/Trees/A) if(A.z==3) del(A)
		for(var/obj/Props/A) if(A.z==3) del(A)
	if(!Vegeta)
		for(var/obj/Props/Edges/A) if(A.z==4) del(A)
		for(var/obj/Props/Surf/A) if(A.z==4) del(A)
		for(var/obj/Props/Trees/A) if(A.z==4) del(A)
		for(var/obj/Props/A) if(A.z==4) del(A)
	if(!Arconia)
		for(var/obj/Props/Edges/A) if(A.z==8) del(A)
		for(var/obj/Props/Surf/A) if(A.z==8) del(A)
		for(var/obj/Props/Trees/A) if(A.z==8) del(A)
		for(var/obj/Props/A) if(A.z==8) del(A)
	if(!Ice)
		for(var/obj/Props/Edges/A) if(A.z==12) del(A)
		for(var/obj/Props/Surf/A) if(A.z==12) del(A)
		for(var/obj/Props/Trees/A) if(A.z==12) del(A)
		for(var/obj/Props/A) if(A.z==12) del(A)
*/

proc/Destroy_Planet(Z)
	if(Z==1) Earth=0
	if(Z==3) Namek=0
	if(Z==4) Vegeta=0
	if(Z==8) Arconia=0
	if(Z==12) Ice=0
	var/Destroying=1
	spawn while(Destroying)
		for(var/mob/player/A in Players) if(A.z==Z) spawn A.Quake()
		sleep(rand(100,1200))
	for(var/area/A) if(A.type!=/area&&A.type!=/area/Inside&&A.z==Z) A.icon_state="Mega Darkness"
	sleep(3000)  // Added explosion block back in.
	spawn while(Destroying) for(var/turf/A in block(locate(1,1,Z),locate(world.maxx,world.maxy,Z)))
		if(prob(0.002))
			for(var/turf/B in range(10,A)) if(prob(60)&&B.type!=/turf/Other/Stars)
				new/obj/Explosion(locate(B.x,B.y,B.z))
				if(prob(90)) new/turf/meltingrock(locate(B.x,B.y,B.z))
				else new/turf/Terrain/Water/Water7(locate(B.x,B.y,B.z))
			sleep(10)
	sleep(3000) //  ^^  Added explosion block back in - Arch
/*	var/Asteroids=100
	spawn while(Asteroids)
		if(prob(50)) new/obj/SpaceDebris/Asteroid(locate(rand(1,world.maxx),rand(1,world.maxy),Z))
		else new/obj/SpaceDebris/Meteor(locate(rand(1,world.maxx),rand(1,world.maxy),Z))
		Asteroids-=1
		sleep(10)*/
	spawn while(Destroying)
		var/obj/Lightning_Strike/A=new(locate(rand(1,world.maxx),world.maxy,Z))
		spawn(1200) if(A) del(A)
		sleep(12)
	sleep(10000)
	/*spawn while(Destroying) for(var/turf/A in block(locate(1,1,Z),locate(world.maxx,world.maxy,Z)))
		if(prob(0.001))
			for(var/turf/B in range(5,A)) if(B.type!=/turf/Other/Stars)
				new/turf/Other/Stars(locate(B.x,B.y,B.z))
			sleep(10)
	sleep(6000)*/
	Destroying=0
	for(var/turf/A in block(locate(1,1,Z),locate(world.maxx,world.maxy,Z))) if(A.type!=/turf/Other/Stars)
		new/turf/Other/Stars(locate(A.x,A.y,A.z))
		new/area/Space(locate(A.x,A.y,A.z))
		if(prob(0.2)) sleep(1)
	/*
	for(var/obj/Props/Edges/A) if(A.z==Z) del(A)
	for(var/obj/Props/Surf/A) if(A.z==Z) del(A)
	for(var/obj/Props/Trees/A) if(A.z==Z) del(A)
	*/
	for(var/obj/Props/A) if(A.z==Z) del(A)
	for(var/mob/A) if(A.z==Z&&!A.client) del(A)
	for(var/obj/A) if(A.z==Z) del(A)
	for(var/mob/player/A in Players) if(A.z==Z) Liftoff(A)
	for(var/obj/Planets/A)
		A.Spawn_Timer=1
		del(A)
turf
	proc
		Wave(var/Amount,var/Chance)
			spawn if(src) while(Amount)
				Amount-=1
				for(var/turf/T in oview(src,7))
					if(prob(15)&&!T.density&&!T.Water)
						var/Dirts=1
						while(Dirts)
							Dirts-=1
							var/image/I=image(icon='Damaged Ground.dmi',pixel_x=rand(-16,16),pixel_y=rand(-16,16))
							T.overlays+=I
							T.Remove_Damaged_Ground(I)
					if(prob(Chance))
						spawn(rand(0,10)) missile(pick('Haze.dmi','Electric_Blue.dmi','Dust.dmi'),src,T)
				sleep(3)
obj/Lightning_Strike
	Savable=0
	var/Power = 0
	var/Dest = null
	density = 0
	New()
		var/image/A=image(icon='Lightning Strike.dmi',icon_state="Front",layer=99)
		var/image/B=image(icon='Lightning Strike.dmi',pixel_y=32,layer=99)
		var/image/C=image(icon='Lightning Strike.dmi',pixel_y=64,layer=99)
		var/image/D=image(icon='Lightning Strike.dmi',pixel_y=96,icon_state="End",layer=99)
		overlays.Add(A,B,C,D)
		spawn(1)
			hearers(12,src) << 'lightning01.wav'
			src.Bolt()
		if(!src.Power)
			spawn(300) if(src) del(src)
	proc
		Bolt()
			if(src.z)
				src.loc = locate(src.x,src.y-1,src.z)
			if(src.loc == src.Dest)
				new/obj/BigCrater(src.loc)
				for(var/obj/O in range(0,src))
					if(O != src)
						O.Health -= 100
						if(istype(O,/obj/Door))
							O.Health -= src.Power*10000
						if(O.Flammable)
							O.Burning = 1
							O.Burn(O.Health)
						if(O.Health <= 0)
							del(O)
				for(var/mob/M in range(0,src))
					M.Health -= 1
					M.Health-=((src.Power)/(M.BP+M.Res*10))
					if(M.Health<=0) M.KO(src)
				var/turf/T = src.loc
				T.Wave(1,100)
				del(src)
			spawn(1)
				if(src)
					src.Bolt()
		//..()
obj/Planet_Destroy
	desc="This will destroy an entire planet. Don't use it without a really good reason."
	verb/Planet_Destroy()
		set category="Skills"
		if(usr.z!=1&&usr.z!=3&&usr.z!=4&&usr.z!=8&&usr.z!=12)
			usr<<"This is not a planet's surface"
			return
		if(usr.z==1&&!Earth) return
		if(usr.z==3&&!Namek) return
		if(usr.z==4&&!Vegeta) return
		if(usr.z==8&&!Arconia) return
		if(usr.z==12&&!Ice) return
		switch(input("Destroy the planet?") in list("No","Yes"))
			if("Yes")
				var/image/A=image(icon='14.dmi',pixel_y=32)
				usr.overlays+=A
				sleep(100)
				usr.overlays-=A
				var/obj/ranged/Blast/B=new(locate(usr.x,usr.y,usr.z))
				B.icon='14.dmi'
			//	walk(B,SOUTH,5,0)
				sleep(25)
				walk(B,0)
				for(var/mob/C in range(10,B)) C<<sound('Explosion 2.wav')
				new/obj/BigCrater(locate(B.x,B.y,B.z))
				del(B)
				spawn Destroy_Planet(usr.z)
				log_ability("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has started Planet Destroy  on [usr.z == 1 ? "Earth" : usr.z == 2 ? "Namek" : usr.z == 4 ? "Vegeta" : usr.z == 12 ? "Ice" : "Not somewhere they're supposed to! WTF?" ].\n")
				usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has started Planet Destroy on [usr.z == 1 ? "Earth" : usr.z == 2 ? "Namek" : usr.z == 4 ? "Vegeta" : usr.z == 12 ? "Ice" : "Not somewhere they're supposed to! WTF?" ].\n")