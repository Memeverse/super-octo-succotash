atom/movable/var
	tmp/turf/Spawn_Location
	Spawn_Timer=0
/*atom/movable/New()
	if(Spawn_Timer) Spawn_Location=loc
	..()
atom/movable/Del()
	if(Spawn_Timer&&Spawn_Location&&!Builder) Remake(type,Spawn_Location,Spawn_Timer)
	Spawn_Location=null
	..()*/
proc/Remake(Type,turf/Location,Timer) spawn(Timer) if(!Location.Builder)
	for(var/obj/A in Location) return
	new Type(Location)

/*
obj/Write(savefile/F)

	log_errors("Obj/Write called from/by [src] [src.type]")

	var/list/OldOverlays=new
	OldOverlays.Add(overlays)
	overlays-=overlays
	..()
	overlays.Add(OldOverlays)
*/
obj/var/Projectile_Speed = 1
obj/LargeFire
	icon = 'large fire.dmi'
	layer = 5
obj/Props
	Savable=0
	layer=4
	Spawn_Timer=180000
	Buildable = 1
	var/Slinger = null
	var/Slinger_Key = null
	Bump(mob/m)
		if(isobj(m))
			m.Health -= 50
			if(m.Health <= 0)
				var/obj/Crater/C = new
				C.loc = m.loc
				del(m)
				del(src)
		if(ismob(m))
			for(var/mob/X in view(8,src))
				if(X.client)
					X.saveToLog("| [X.client.address ? (X.client.address) : "IP not found"] | ([X.x], [X.y], [X.z]) | [src] is slung into [m] by [src.Slinger_Key].\n")
			var/Evasion = 10
			if(m.Spd)
				Evasion += m.Spd
			if(m.Def)
				Evasion += m.Def/m.DefMod/100
			if(src.Projectile_Speed)
				Evasion -= src.Projectile_Speed / 10
			if(m.afk)
				Evasion = 100
			if(!prob(Evasion))
				view(10,m) << "[src.Slinger] slams [src] into [m]!"
				var/obj/Crater/C = new
				C.loc = m.loc
				if(src.Projectile_Speed)
					var/dmg = src.Projectile_Speed / 10
					dmg -= m.End / 1000
					if(dmg <= 0)
						dmg = 1
					if(dmg >= 10)
						dmg = 10
					m.Health -= dmg
				del(src)
			else
				flick('Zanzoken.dmi',m)

turf/var/Water

var/HBTC_Open

turf/Other
	Blank
		opacity=1
		Buildable=0
		Enter(mob/M)
			if(ismob(M))
				if(M.client && M.client.holder)
					return ..()
				else
					return
			else if(!istype(M,/obj/ranged/Blast/Fireball)) if(!istype(M,/obj/AndroidShips/Ship)) if(!istype(M,/obj/Ships)) if(!istype(M,/obj/Lightning_Strike))
				del(M)
			if(istype(M,/obj/Lightning_Strike))
				return ..()

turf/Special

	Buildable=0

	Teleporter
		density=1
		var/gotox
		var/gotoy
		var/gotoz
		Enter(mob/M) M.loc=locate(gotox,gotoy,gotoz)

	EnterHBTC/Enter(mob/A)

		if(ismob(A))
			if(A.HBTC_Enters<2)
				A.HBTC_Enters++
				A.loc=locate(258,274,10)
				logAndAlertAdmins("([A.key])[A] enters the HBTC.",1)
				HBTC_Open=1
				HBTC()
			else if(ismob(A)) A<<"You cannot enter the time chamber more than twice a lifetime"

	ExitHBTC/Enter(mob/A) if(HBTC_Open) A.loc=locate(128,1,2)

proc/HBTC()
	for(var/mob/player/A in Players) if(A.z==10) A<<"The time chamber will remain open for one hour, \
	if you do not exit before then you will be trapped until someone enters the time chamber again, \
	and you will continue aging at ten times the normal rate until you exit"
	sleep(6000)
	for(var/mob/player/A in Players) if(A.z==10) A<<"The time chamber will be unlocked for 50 more minutes"
	sleep(6000)
	for(var/mob/player/A in Players) if(A.z==10) A<<"The time chamber will be unlocked for 40 more minutes"
	sleep(6000)
	for(var/mob/player/A in Players) if(A.z==10) A<<"The time chamber will be unlocked for 30 more minutes"
	sleep(6000)
	for(var/mob/player/A in Players) if(A.z==10) A<<"The time chamber will be unlocked for 20 more minutes"
	sleep(6000)
	for(var/mob/player/A in Players) if(A.z==10) A<<"The time chamber will be unlocked for 10 more minutes"
	sleep(3000)
	for(var/mob/player/A in Players) if(A.z==10) A<<"The time chamber will be unlocked for 5 more minutes"
	sleep(2400)
	for(var/mob/player/A in Players) if(A.z==10) A<<"The time chamber will remain unlocked for ONE more minute"
	sleep(600)
	for(var/mob/player/A in Players) if(A.z==10) A<<"The time chamber exit disappears. You are now trapped"
	HBTC_Open=0

turf
	var/DestroyedBy=null



obj/Explosion
	icon='Explosion.dmi'
	layer=MOB_LAYER+1
	luminosity=8
	New()
		pixel_x=rand(-8,8)
		pixel_y=rand(-8,8)
		spawn(rand(4,6)) if(src) del(src)
		//..()