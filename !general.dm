obj/Attacks/var
	Wave
	tmp/chargelvl=1
	tmp/charging
	tmp/streaming
	KiReq
	WaveMult
	ChargeRate
	MaxDistance
	MoveDelay
	Piercer
	Power=1 //Damage multiplier
	Explosive=0
	Shockwave=0
	Paralysis=0
	Scatter=0 //A barrage effect
	Fatal=1 //Certain attacks may not be capable of killing

obj/ranged/Blast/proc/Zig_Zag(B,Z) while(src)
	var/A=dir
	var/C=B
	density=0
	while(C)
		step_rand(src)
		C-=1
	density=1
	dir=A
	sleep(Z)
obj/largedust
	icon='largedust.dmi'
	Health=1.#INF
	Grabbable=0
	Shockwaveable=0
	Bolted = 1
	density = 0
	New()
		src.pixel_x = - 100
		src.pixel_y = -10
		spawn(11)
			if(src) del(src)
obj/sworddust
	icon='Slash.dmi'
	Health=1.#INF
	Grabbable=0
	Shockwaveable=0
	Bolted = 1
	density = 0
	New()
		src.pixel_y = -32
		spawn(7)
			if(src) del(src)
obj/shockwave
	icon='Impact.dmi'
	icon_state = "shock"
	Health=1.#INF
	Grabbable=0
	Shockwaveable=0
	Bolted = 1
	density = 0
	New()
		src.pixel_x = rand(-12,12)
		src.pixel_y = rand(-12,12)
		spawn(6)
			if(src) del(src)
obj/impact1
	icon='Impact.dmi'
	icon_state = "impact1"
	Health=1.#INF
	Grabbable=0
	Shockwaveable=0
	Bolted = 1
	density = 0
	New()
		spawn(7)
			if(src) del(src)
obj/Crater
	icon='Craters.dmi'
	icon_state="small crater"
	Health=1.#INF
	Grabbable=0
	Shockwaveable=0
	Bolted = 1
	New()
		for(var/obj/Crater/A in range(0,src)) if(A!=src) del(A)
		spawn(6000) if(src) del(src)
		//..()
obj/Ash
	icon = 'fx.dmi'
	icon_state="ash"
	Health=1.#INF
	Grabbable=0
	Savable=0
	Shockwaveable=0
	Bolted = 1
	New()
		spawn(6000) if(src) del(src)
obj/Smoke
	icon = 'smoke.dmi'
	icon_state = "1"
	Health=1.#INF
	Grabbable=0
	Savable=0
	Shockwaveable=0
	Bolted = 1
	layer = 100
	New()
		var/I = pick(1,2,3)
		src.icon_state = "[I]"
		src.Smoke()
		spawn(50) if(src) del(src)
obj/BigCrater
	icon='Craters.dmi'
	icon_state="Center"
	Health=1.#INF
	Grabbable=0
	Savable=0
	Shockwaveable=0
	Bolted = 1
	New()
		if(src.z==0) del(src)
		for(var/obj/BigCrater/A in view(3,src)) if(A!=src) del(src)
		var/image/A=image(icon='Craters.dmi',icon_state="N",pixel_y=32)
		var/image/B=image(icon='Craters.dmi',icon_state="S",pixel_y=-32)
		var/image/C=image(icon='Craters.dmi',icon_state="E",pixel_x=32)
		var/image/D=image(icon='Craters.dmi',icon_state="W",pixel_x=-32)
		var/image/E=image(icon='Craters.dmi',icon_state="NE",pixel_y=32,pixel_x=32)
		var/image/F=image(icon='Craters.dmi',icon_state="NW",pixel_y=32,pixel_x=-32)
		var/image/G=image(icon='Craters.dmi',icon_state="SE",pixel_y=-32,pixel_x=32)
		var/image/H=image(icon='Craters.dmi',icon_state="SW",pixel_y=-32,pixel_x=-32)
		overlays.Remove(A,B,C,D,E,F,G,H)
		overlays.Add(A,B,C,D,E,F,G,H)
		spawn(6000) if(src) del(src)
		//..()