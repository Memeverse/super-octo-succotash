/*

######### Vars #########

*/

turf/var/FlyOverAble=1
atom/var/Buildable=1

var/list/Turfs = new // List of all user-built turfs.
var/list/CreatedItems
var/Wall_Strength=50

/*
The Build_Lay proc is responsible for placing the turfs at the player's current location.

*/


proc/Build_Lay(obj/Build/O,mob/P) if(P.icon_state!="KO" && !P.inertia_dir) //Type to build, player who is building it, location to put it, can't be floundering through space

	//debuglog << "[__FILE__]:[__LINE__] || src: [src ? src : "null"] usr: [usr ? usr : "null"] build_lay()"

	var/atom/D=P
	if(P.S) D=P.S
	for(var/obj/Controls/N in view(1,locate(D.x,D.y,D.z)))
		P<<"You cannot build this close to ship controls"
		return
	for(var/obj/Airlock/N in view(1,locate(D.x,D.y,D.z)))
		P<<"You cannot build this close to an airlock!"
		return
	for(var/turf/Special/Teleporter/N in view(1,locate(D.x,D.y,D.z)))
		P<<"You cannot build this close to entrances."
		return
	for(var/obj/Warper/W in view(1,locate(D.x,D.y,D.z)))
		P<<"You cannot build this close to warpers."
		return
	for(var/area/portal/W in view(4,locate(D.x,D.y,D.z)))
		P<<"You cannot build this close to the map edge."
		return
	for(var/area/half_portal/W in view(4,locate(D.x,D.y,D.z)))
		P<<"You cannot build this close to the map edge."
		return
	if(P.z == SPACE_Z_LEVEL)
		if((P.x <= 3) || (P.x >= (world.maxx-3)) || (P.y <= 3) || (P.y >= (world.maxy-3)))
			P << "You cannot build this close to the edge of space."
			return
	var/atom/C=new O.Creates(locate(D.x,D.y,D.z))
	C.Builder=P.ckey

	if(isobj(C))
		C:Spawn_Timer=0
		var/Turf_Objects=0

		for(var/obj/K in get_turf(P))
			if(!(locate(K) in P))
				Turf_Objects++
			if(Turf_Objects>4)
				P<<"Nothing more can be placed here."
				del(C)
				return
			else
				global.worldObjectList+=C
				C.Savable=1
				//return

		if(istype(C,/obj/Door))
			C:Grabbable=0
			var/New_Password=input(P,"Enter a password or leave blank") as text
			if(!C) return
			C.Password=New_Password

		if(istype(C,/obj/Props/Sign))
			C.desc=input(P,"What do you want to write on the sign?") as text

	else
		C.Savable=0
		new/area/Inside(locate(P.x,P.y,P.z))
		//for(var/obj/Props/Edges/E in C) del(E)
		//for(var/obj/Props/Surf/E in C) del(E)
		//for(var/obj/Props/Trees/E in C) del(E)
		//for(var/obj/Turfs/E in C) del(E)
		for(var/obj/Props/E in C) del(E)
		Turfs+=C

