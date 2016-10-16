
obj/items/Gun
	Tech=10
	Can_Drop_With_Suffix=1
	desc="Guns are quite weak. But have a greater affect against NPCs. They do have advantages however. They are \
	very accurate, drain no energy, and thats about it. They can be very good against people with low BP, even \
	if that person has good stats."
	icon='GUNS.dmi'
	var/Ammo=100
	var/Max_Ammo=100
	var/Delay=5
	var/Damage_Percent=5
	var/Velocity=1
	var/Precision=100000
	var/Battle_Power=0.005
	var/Force=500
	var/Knockbacks=1
	var/Explodes=0
	var/Spread=0
	var/Deviation=4
	var/Bullet_Icon='Bullet.dmi'
	Bullet=1
	var/tmp/Firing
	Stealable=1
	New()
		suffix="[Commas(Ammo)]"
		Gun_Description_Update()
	proc/Gun_Upgrade()
		if(usr.Int_Level<Tech)
			usr<<"This is too advanced for you to mess with."
			return
		var/obj/Resources/A
		for(var/obj/Resources/B in usr) A=B
		var/Cost=4000/usr.Add
		var/Max_Upgrade=(A.Value/Cost)+Tech
		if(Max_Upgrade>usr.Int_Level) Max_Upgrade=usr.Int_Level
		var/Upgrade=input("Upgrade it to what level? (1-[round(Max_Upgrade)]). The maximum amount you can upgrade is determined by your intelligence (Max Upgrade cannot exceed Intelligence), and how much resources you have. So if the maximum is less than your intelligence then it is instead due to not having enough resources to upgrade it higher than the said maximum.") as num
		if(Upgrade>usr.Int_Level) Upgrade=usr.Int_Level
		if(Upgrade>Max_Upgrade) Upgrade=Max_Upgrade
		if(Upgrade<1) Upgrade=1
		Upgrade=round(Upgrade)
		if(Upgrade<Tech) switch(input("You wish to bring this Level [Tech] [src] to Level [Upgrade]?") in list("Yes","No"))
			if("No") return
		Cost*=Upgrade-Tech
		if(Cost<0) Cost=0
		if(Cost>A.Value)
			usr<<"You do not have enough resources to upgrade it to level [Upgrade]"
			return
		view(src)<<"[usr] upgrades the [src] to level [Upgrade]"
		usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrads the [src] to level [Upgrade].<br>")
		A.Value-=Cost
		Tech=Upgrade
		Gun_Description_Update()
	proc/Gun_Fire()
		if((usr.icon_state in list("Meditate","Train","KO","KB"))||usr.Frozen) return
		if(Firing) return
		if(Ammo<=0) return
		if(usr.key in Noobs)
			usr<<"Noobed people cannot use guns"
			return
		Ammo-=1
		if(Spread) Ammo-=2
		if(Ammo<0) Ammo=0
		suffix="[Commas(Ammo)]"
		Firing=1
		spawn(Delay) Firing=0
		var/obj/Blast/A=new
		A.Bullet=Bullet
		A.Owner=usr
		A.pixel_x=rand(-Deviation,Deviation)
		A.pixel_y=rand(-Deviation,Deviation)
		A.icon=Bullet_Icon
		var/Damage_Formula=0.1*Damage_Percent*Battle_Power*Force*(Tech**4)
		var/Power_Formula=0.1*Damage_Percent*Battle_Power*(Tech**4)
		A.Damage=Damage_Formula
		A.Power=Power_Formula
		A.Offense=Precision
		A.Shockwave=Knockbacks
		A.Explosive=Explodes
		A.dir=usr.dir
		A.loc=usr.loc
		walk(A,A.dir,Velocity)
		//sd_SetLuminosity(2)	//Make this be based off of gun shooting it
		if(Spread)
			var/obj/Blast/B=new
			B.Bullet=Bullet
			B.Owner=usr
			B.pixel_x=rand(-Deviation,Deviation)
			B.pixel_y=rand(-Deviation,Deviation)
			B.icon=Bullet_Icon
			B.Damage=Damage_Formula
			B.Power=Power_Formula
			B.Offense=Precision
			B.Shockwave=Knockbacks
			B.Explosive=Explodes
			B.loc=get_step(usr,turn(usr.dir,90))
			B.dir=usr.dir
			walk(B,B.dir,Velocity)
			var/obj/Blast/C=new
			C.Bullet=Bullet
			C.Owner=usr
			C.pixel_x=rand(-Deviation,Deviation)
			C.pixel_y=rand(-Deviation,Deviation)
			C.icon=Bullet_Icon
			C.Damage=Damage_Formula
			C.Power=Power_Formula
			C.Offense=Precision
			C.Shockwave=Knockbacks
			C.Explosive=Explodes
			C.loc=get_step(usr,turn(usr.dir,-90))
			C.dir=usr.dir
			walk(C,C.dir,Velocity)
	proc/Gun_Description_Update()
		desc="*Level [Tech] [src]*<br>\
		Ammo Capacity: [Commas(Max_Ammo)]<br>\
		Refire Delay: [Delay]<br>\
		Shot Precision: [Commas(Precision*0.01)]<br>\
		Damage: [Commas(Battle_Power*Damage_Percent*(Tech**4))]<br>\
		Projectile Velocity: [Commas(1000/Velocity)]<br>\
		Knockback Effect: [Knockbacks+Explodes]<br>\
		Explosion Radius: [Explodes]<br>"
		if(Spread) desc+="Fires 3 shots at once.<br>"
	/*
	Default Ammo is 500, divided by the power of the gun.
	Each Knockback is x0.8 ammo
	Each explosion level is x0.8 ammo
	Damage is multiplied by the square root of the movement speed.
	(x2 movement = x1.42 damage)
	(x3 movement = 1.73x damage)
	(x4 movement = 2x damage)
	(x5 movement = 2.24x damage)
	(x10 movement = 3.17x damage)
	Every time you double power but sacrifice precision you must divide precision by 10.
	Spread Attribute halves damage.
	*/
	Blaster
		icon='Item, Blaster.dmi'
		Bullet=0
		Ammo=80
		Max_Ammo=80
		Delay=5
		Damage_Percent=34.6
		Precision=1000
		Velocity=3
		Knockbacks=0
		Explodes=1
		Spread=0
		Deviation=4
		Bullet_Icon='Plasma1.dmi'
		var/Equipped
		Click() if(locate(src) in usr)
			if(!Equipped)
				Equipped=1
				usr.overlays+=icon
			else
				Equipped=0
				usr.overlays-=icon
		verb/Blaster()
			set category="Skills"
			Gun_Fire()
		verb/Upgrade()
			set src in oview(1)
			Gun_Upgrade()
	SMG
		icon_state="SMG"
		Ammo=500
		Max_Ammo=500
		Delay=1
		Damage_Percent=0.5
		Precision=100000
		Velocity=1
		Knockbacks=0
		Explodes=0
		Spread=1
		Deviation=16
		Bullet_Icon='Bullet.dmi'
		verb/SMG()
			set category="Skills"
			Gun_Fire()
		verb/Upgrade()
			set src in oview(1)
			Gun_Upgrade()

	Shotgun
		icon_state="Shotgun"
		Ammo=32
		Max_Ammo=32
		Delay=10
		Damage_Percent=5
		Precision=100000
		Velocity=1
		Knockbacks=2
		Explodes=0
		Spread=1
		Deviation=4
		Bullet_Icon='Bullet.dmi'
		verb/Shotgun()
			set category="Skills"
			Gun_Fire()
		verb/Upgrade()
			set src in oview(1)
			Gun_Upgrade()
	Handgun
		icon_state="Handgun"
		Ammo=100
		Max_Ammo=100
		Delay=5
		Damage_Percent=5
		Precision=100000
		Velocity=1
		Knockbacks=0
		Explodes=0
		Spread=0
		Deviation=3
		Bullet_Icon='Bullet.dmi'
		verb/Handgun()
			set category="Skills"
			Gun_Fire()
		verb/Upgrade()
			set src in oview(1)
			Gun_Upgrade()
	Rifle
		icon_state="Rifle"
		Ammo=20
		Max_Ammo=20
		Delay=20
		Damage_Percent=20
		Precision=100000
		Velocity=1
		Knockbacks=1
		Explodes=0
		Spread=0
		Deviation=3
		Bullet_Icon='Bullet.dmi'
		verb/Rifle()
			set category="Skills"
			Gun_Fire()
		verb/Upgrade()
			set src in oview(1)
			Gun_Upgrade()
	Minigun
		icon_state="TMP"
		Ammo=500
		Max_Ammo=500
		Delay=1
		Damage_Percent=1
		Precision=100000
		Velocity=1
		Knockbacks=0
		Explodes=0
		Spread=0
		Deviation=16
		Bullet_Icon='Bullet.dmi'
		verb/Minigun()
			set category="Skills"
			Gun_Fire()
		verb/Upgrade()
			set src in oview(1)
			Gun_Upgrade()
	Red9
		icon_state="Red 9"
		Ammo=100
		Max_Ammo=100
		Delay=4
		Damage_Percent=4
		Precision=100000
		Velocity=1
		Knockbacks=0
		Explodes=1
		Spread=0
		Deviation=4
		Bullet_Icon='Bullet 2.dmi'
		verb/Red9()
			set category="Skills"
			Gun_Fire()
		verb/Upgrade()
			set src in oview(1)
			Gun_Upgrade()
	Punisher
		icon_state="Punisher"
		Ammo=54
		Max_Ammo=54
		Delay=6
		Damage_Percent=6
		Precision=100000
		Velocity=1
		Knockbacks=1
		Explodes=1
		Spread=0
		Deviation=4
		Bullet_Icon='Bullet 1.dmi'
		verb/Punisher()
			set category="Skills"
			Gun_Fire()
		verb/Upgrade()
			set src in oview(1)
			Gun_Upgrade()
	RPG
		icon_state="Rocket Left"
		Ammo=5
		Max_Ammo=5
		Delay=30
		Damage_Percent=60
		Precision=100000
		Velocity=4
		Knockbacks=4
		Explodes=2
		Spread=0
		Deviation=1
		Bullet_Icon='Missile.dmi'
		verb/RPG()
			set category="Skills"
			Gun_Fire()
		verb/Upgrade()
			set src in oview(1)
			Gun_Upgrade()
	Photon_Repeaters
		icon_state="Photon Repeaters"
		Ammo=80
		Max_Ammo=80
		Delay=2
		Damage_Percent=4
		Precision=10000
		Velocity=2
		Knockbacks=1
		Explodes=1
		Spread=0
		Deviation=8
		Bullet_Icon='Bullet 4.dmi'
		verb/Photon_Repeaters()
			set category="Skills"
			Gun_Fire()
		verb/Upgrade()
			set src in oview(1)
			Gun_Upgrade()

obj/items/Resource_Vaccuum
	icon='Item, Vaccuum.dmi'
	var/tmp/Vaccuuming
	Click() if(locate(src) in usr)
		if(Vaccuuming) return
		Vaccuuming=1
		spawn(100) Vaccuuming=0
		for(var/obj/Resources/R in view(10,usr))
			spawn while(!(R in usr)&&R.loc)
				if(!R) break // sanity check
				var/Old_Loc=R.loc
				step_towards(R,usr)
				if(R.loc==Old_Loc) break
				if(R in view(1,usr))
					for(var/obj/Resources/A in usr) A.Value+=R.Value
					del(R)
				sleep(2)
obj/items/Ammo
	desc="Click this to reload whichever gun you want."
	icon='GUNS.dmi'
	icon_state="Ammo 1"
	Stealable=1
	var/Ammo=1000
	var/tmp/Reloading
	Can_Drop_With_Suffix=1
	New() suffix="[Commas(Ammo)]"
	Click() if(locate(src) in usr)
		for(var/obj/items/Ammo/A in usr) if(A.Reloading)
			usr<<"You are busy reloading already."
			return
		var/list/Guns=new
		for(var/obj/items/Gun/A in usr) if(A.Ammo<A.Max_Ammo) Guns+=A
		if(!Guns) return
		//Guns+="Cancel"
		var/obj/items/Gun/A=input("Which gun do you want to reload?") in Guns
		if(A=="Cancel") return
		Reloading=1
		view(usr)<<"[usr] is reloading their weapon"
		usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] is reloading their weapon.<br>")
		spawn(50) if(src&&A&&usr)
			Reloading=0
			view(usr)<<"[usr] is done reloading their weapon"
			usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] is done reloading their weapon.<br>")
			var/Needed_Amount=A.Max_Ammo-A.Ammo
			if(Needed_Amount>Ammo) Needed_Amount=Ammo
			A.Ammo+=Needed_Amount
			Ammo-=Needed_Amount
			A.suffix="[Commas(A.Ammo)]"
			suffix="[Commas(Ammo)]"
			if(Ammo<=0) del(src)

obj/items/Door_Pass
	name="Key"
	icon='Door Pass.dmi'
	Stealable=1
	desc="Click this to set it's password. Door's will check if it is correct and only let you in if it is."
	Password = null
	Click()
		if(Password)
			usr<<"It has already been programmed and cannot be reprogrammed."
			return
		Password=input("Enter a password for the doors to check if it is correct") as text
obj/items/Cloning_Tank
	layer=4
	density=1
	Bolted=1
	Stealable=1
	desc="This will revive you each time you are killed. Each time you are cloned however, you lose decline."
	New()
		var/image/A=image(icon='Lab.dmi',icon_state="Tube2",layer=layer,pixel_y=20,pixel_x=0)
		var/image/B=image(icon='Lab.dmi',icon_state="Tube2Top",layer=layer+1,pixel_y=52,pixel_x=0)
		var/image/C=image(icon='Lab.dmi',icon_state="Lab2",layer=layer,pixel_y=32,pixel_x=28)
		overlays.Add(A,B,C)
		spawn if(src) Clone_Detection()
	proc/Clone_Detection() while(src)
		for(var/mob/A in Players) if(Password=="[A.name] ([A.key])"&&A.Dead)
			view(A)<<"[A] has been revived by their [src]"
			usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has been revived by their [src].<br>")
			A.overlays-='Halo.dmi'
			A.Dead=0
			A.loc=loc
			A.Decline*=0.8
		sleep(rand(12000,24000))
	Click()
		usr<<"This machine is set to clone [Password]"
	verb/Set()
		set src in oview(1)
		if(usr.Dead)
			usr<<"Dead people cannot use this"
			return
		usr<<"[src] has been set to clone [usr] if they die."
		usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has set [src] to clone themselves.<br>")
		Password="[usr.name] ([usr.key])"

turf/proc/Nuke(Damage,Range) spawn if(src)
	var/obj/Blast/Fireball/F=new(src)
	F.Damage=Damage*1000
	F.Power=Damage
	walk_rand(F)

obj/Blast/Fireball
	icon='Explosion.dmi'
	density=1
	Shockwave=1
	Deflectable=0
	Explosive=0
	Piercer=1
	luminosity=1	//Lotta cpu but it looks SO COOL
	layer=MOB_LAYER+50
	Distance=5000000
	Owner="the nuclear explosion!"
	New()
		..()
		spawn(rand(600,1800))
			if(src)
				//sd_SetLuminosity(0)
				del(src)
		var/Amount=5
		while(Amount)
			var/image/A=image(icon='Explosion.dmi',pixel_x=rand(-32,32),pixel_y=rand(-32,32))
			overlays+=A
			Amount-=1

	Move()
		for(var/obj/A in get_step(src,dir)) if(A.type!=type)
			Bump(A)
			break
		for(var/mob/A in get_step(src,dir))
			Bump(A)
			break
		for(var/turf/A in range(1,src))
			if(A.density)
				Bump(A)
			else if(prob(5) && !istype(A,/turf/GroundDirt))
				A.Health=0
				if(usr!=0) A.Destroy(usr,usr.key)
				else A.Destroy("Unknown","Unknown")
				new	/turf/meltingrock(locate(A.x,A.y,A.z))
		..()
		sleep(1)
	Bump(mob/A)
		if(ismob(A))
			//for(var/obj/Shield/S in A) if(S.Using)
				//A.Ki-=(A.MaxKi*0.01)*(Damage/(A.BP*A.Res))
				//if(A.Ki>0) return
			for(var/obj/Cybernetics/Force_Field/S in A) if(S.suffix)
				for(var/obj/Cybernetics/Generator/G in A) if(G.suffix)
					if(G.Current>80)
						G.Current-=80
						A.Force_Field()
			for(var/obj/items/Force_Field/S in A) if(S.Level>0)//if(S.suffix)
				S.Level-=Damage*0.01
				if(S.Level<=0)
					S.Level=0
					S.suffix=null
					view(src)<<"[A]'s force field is drained!"
					A.Force_Field()
					for(var/mob/player/M in view(src))
						if(!M.client) return
						M.saveToLog("| [A.client.address ? (A.client.address) : "IP not found"] | ([A.x], [A.y], [A.z]) | [key_name(A)] 's force field is drained! .<br>")
				return
			if(prob(95)&&A.Precognition) if(A.icon_state in list("","Flight"))
				step(A,turn(dir,pick(-45,45)))
				return
			if((A.icon_state=="KO"&&A.client)||(A.Frozen&&!A.client))
				A.Life-=1*(Damage/(A.Base*A.Body*A.Res))
				if(A.Life<=0)
					if(A.Regenerate) if(A.Life<=-10*A.Regenerate) A.Dead=1
					A.Death(Owner)
			if(A)
				A.Health-=Damage/(A.BP*A.Res)
				if(A.Health<=0)
					if(type!=/obj/Blast/Genki_Dama) A.KO(Owner)
					else
						if(!A.client) A.Death(Owner)
						else
							A.Life-=1*(Damage/(A.Base*A.Body*A.Res))
							if(A.Life<=0)
								if(A.Regenerate) if(A.Life<=-10*A.Regenerate) A.Dead=1
								A.Death(Owner)
				if(Paralysis)
					A<<"You become paralyzed"
					A.saveToLog("| [A.client.address ? (A.client.address) : "IP not found"] | ([A.x], [A.y], [A.z]) | [key_name(A)] is paralyzed.<br>")
					A.Frozen=1
				if(A&&src&&A.dir==dir&&A.icon_state=="KO"&&A.Tail)
					view(A)<<"[A]'s tail is blasted off!"
					A.Tail_Remove()
					for(var/mob/player/M in view(A))
						if(!M.client) return
						M.saveToLog("| [A.client.address ? (A.client.address) : "IP not found"] | ([A.x], [A.y], [A.z]) | [key_name(A)] 's tail is blasted off.<br>")
				if(Shockwave) step_away(A,src,100)
				Explode()
		else
			if(isnum(A.Health))
				if(ismob(Owner)) A.Health-=Damage
				else A.Health-=Damage/2000
			if(A.Health<=0)
				if(isturf(A))
					new	/turf/meltingrock(locate(A.x,A.y,A.z))
			Explode()

obj/items/Nuke/proc/doDamage(var/atom/A)
	//var/distance	=	length(getline(A,src.loc))	//Abuse of getline derp de derp
	//A low level nuke doesn't do a whole lot.
	//Your nuke efficiency essentially determines
	//How many tiles from epicenter damage
	//begins to taper off
	var/PercentDamage = max(0,min(100,(src.Range)*src.Efficiency))	//Between 1-100% 'damage'
	var/Damage = PercentDamage*(src.Force**5)*10	//**5 = to the fifth

	if(istype(A, /mob/))
		var/mob/M = A
		if(!M)	return
		//for(var/obj/Shield/S in M)
			//if(S.Using)
				//M.Ki -= (M.MaxKi*0.01)*(Damage/(M.BP*M.Res))
				//if(M.Ki > 0)
					//return
		for(var/obj/Cybernetics/Force_Field/S in M) if(S.suffix)
			for(var/obj/Cybernetics/Generator/G in M) if(G.suffix)
				if(G.Current > 80)
					G.Current -= 80
					M.Force_Field()
		for(var/obj/items/Force_Field/S in M) if(S.Level>0)
			S.Level-=Damage*0.01
			if(S.Level<=0)
				S.Level=0
				S.suffix=null
				view(src) << "[M]'s force field is drained!"
			M.Force_Field()
			for(var/mob/player/K in view(M))
				if(!K.client) return
				K.saveToLog("| [M.client.address ? (M.client.address) : "IP not found"] | ([M.x], [M.y], [M.z]) | [key_name(M)] 's force field is drained! <br>")
			return
		if(M.Precognition && !prob(PercentDamage))	//Precognition isn't going to save you from a NUKE
			if(M.icon_state in list("","Flight"))//Unless of course the efficiency is lower, meaning
				step(M,turn(dir,pick(-45,45)))	//The nuke would be less powerful.. at that turf
				return
		var/RemainingDamage = (Damage/(M.BP*M.Res) - M.Health)	//Get this incase they end up knocked out
		M.Health -= Damage/(M.BP*M.Res)
		if(M.Health <= 0)
			M.KO("the nuclear explosion")
			if(M.Tail && prob(PercentDamage))	//Tail goin ham
				view(M) << "[M]'s tail is blasted off!"
				for(var/mob/player/K in view(M))
					if(!K.client) return
					K.saveToLog("| [M.client.address ? (M.client.address) : "IP not found"] | ([M.x], [M.y], [M.z]) | [key_name(M)] 's tail is blasted off!<br>")
				M.Tail_Remove()
			M.Life -= RemainingDamage/((M.Base*M.Body*M.Res)/PercentDamage)	//Greater chance to die if you're near the center, REGARDLESS
		if(M.Life <= 0 && (M.Life <= -10*M.Regenerate))
			M.Dead = 1
			M.Death("the nuclear explosion")
		else if(prob(PercentDamage))
			M.Shockwave_Knockback(((src.Range/2)),src.loc)
	else if (istype(A, /turf/))
		var/turf/T = A
		T.Health -= Damage
		if(T.Health <= 0)
			new	/turf/meltingrock(locate(T.x,T.y,T.z))
	else if (istype(A, /obj/Blast))
		var/obj/Blast/B = A
		B.Explode()
	else if (istype(A, /obj/))
		var/obj/O = A
		O.Health -= Damage
		if(O.Health <= 0)
			del(O)
		//else if(prob(PercentDamage))
			//O.Shockwave_Knockback(PercentDamage,src.loc)	//Buggy?


/turf/meltingrock
	name = "Super-heated rock"
	desc = "The aftermath of a nuclear bomb"
	icon = 'nuclearfire.dmi'
	icon_state = "1"
	Buildable = 0
/turf/meltingrock/New()
	icon_state = pick("1", "2", "3")
	dir = pick(cardinal)
	Turfs += src	//Glass a planet, it persists!
	spawn(rand(16,64))
		new /turf/moltenrock(locate(src.x,src.y,src.z))
	..()
/turf/meltingrock/Del()
	Turfs -= src
	..()

/turf/moltenrock
	name = "Super-heated rock"
	desc = "The aftermath of a nuclear bomb"
	icon = 'Turfs1.dmi'
	icon_state = "lava"
	Buildable = 0
/turf/moltenrock/New()
	icon_state = pick("lava", "lava2", "lava3", "lava4", "lava5", "ash", "ash2", "ash3", "ash4", "ash5")
	Turfs += src	//Glass a planet, it persists!
	//if(prob(5))
		//overlays += icon('icon.dmi',"icon_state")	//steam rising from freshly molten ground :v
	..()
/turf/moltenrock/Del()
	Turfs -= src
	..()

#define RADIATION_NUKE	1	//Tens style
#define FRONTLOADED_NUKE	2	//Persh style

obj/items/Nuke
	icon='Lab.dmi'
	icon_state="Panel1"
	name="Nuclear Warhead"
	density=1
	Stealable=1
	desc="A primed nuclear warhead."
	var/Type = RADIATION_NUKE
	var/Force=20
	var/Range=20
	var/Efficiency=20

	New()
		Reset_Desc()
		spawn
			if(src)
				if(Bolted)
					Proximity_Detonation()
	proc/Reset_Desc()
		desc=initial(desc)
		desc+="<br>Force (Radiation): [Commas((Force**4)*500)] BP"
		desc+="<br>Force (Front Loaded): [Commas((Force**5)*500)] BP"
		desc+="<br>Radius: [Range]"
		desc+="<br>Efficiency: [Efficiency]"
	proc/Detonate()
		flick("nuclearexplosion", src) //Going ham procedure commenced
		if(src.Type == RADIATION_NUKE)
			var/AmountMade = 0
			for(var/turf/T in oview(src,src.Range/2)-src.loc)
				if(T && AmountMade<Efficiency/2)
					AmountMade++
					T.Nuke((Force**4)-1,1) //-1 so it cant destroy walls of the same level
			var/turf/T = src.loc
			T.Nuke((Force**4)-1,1)	//We nuke our tile last so the proc doesn't quit
		else if(src.Type == FRONTLOADED_NUKE)
			for(var/turf/T in oview(src,Range/2)-src.loc)	//Now we assume that Range is the radius here.
				if(T)
					missile('explosion.dmi',src,T)	//Baller, shot caller, 20 inch blades on the impala
					for(var/atom/A in T)
						src.doDamage(A)	//Bitches goin ham
					src.doDamage(T)	//People then the turf (go ham)
			var/turf/T = src.loc
			for(var/atom/A in T)	//Stuff on our turf
				src.doDamage(A)
			src.doDamage(T)	//	Our turf
		del(src)	//In case we survived WE ARE GOIN HAM

	verb/Set()
		set src in oview(1,usr)
		if(Bolted)
			usr<<"It is already armed, you cannot reprogram it"
			return
		view(src)<<"[usr] has begun to program the bomb."
		usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] programmed [src].<br>")
		Password=input("Set the access code for remote detonation.") as text
	verb/Arm()
		set src in oview(1,usr)
		if(usr.key in Noobs)
			usr<<"Noobed people cannot use this"
			return
		if(Bolted)
			usr<<"It is already armed"
			return
		switch(input("Choose detonation method.") in list("Cancel", "Radiation Nuke", "Front Loaded Nuke"))
			if("Radiation Nuke")	Type = RADIATION_NUKE
			if("Front Loaded Nuke")	Type = FRONTLOADED_NUKE
			else	return
		switch(input("Choose method. Only choose if you do not plan on remote detonation. Once \
		activated, it cannot be deactivated.") in list("Cancel","Immediate","Timer","Proximity"))
			if("Timer") Timed_Detonation()
			if("Proximity") Proximity_Detonation()
			if("Immediate")	Immediate_Detonation()
		usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] armed [src].<br>")

	verb/Upgrade()
		set src in oview(1)
		if(usr.Int_Level < src.Tech)
			usr << "This is too advanced for you to mess with."
			return
		var/obj/Resources/R
		for(var/obj/Resources/R2 in usr)
			R = R2
			break
		var/Cost
		var/Max_Upgrade=min(usr.Int_Level,((R.Value/Cost)+Tech))
		switch(input("Upgrade what part of the warhead?") in list("Cancel", "Force", "Range", "Efficiency"))
			if("Cancel")
				return
			if("Force")	//Damage
				var/Upgrade=input("Upgrade FORCE to what level? (1-[round(Max_Upgrade)]). The maximum amount you can upgrade is determined by your intelligence (Max Upgrade cannot exceed Intelligence), and how much resources you have. So if the maximum is less than your intelligence then it is instead due to not having enough resources to upgrade it higher than the said maximum.") as num
				Upgrade = round(max(0,min(Max_Upgrade,Upgrade)))
				Cost = 400000/usr.Add
				Cost*=Upgrade-Force
				if(Cost > R.Value)
					usr << "You do not have enough resources to upgrade it to level [Upgrade]."
					return
				R.Value -= Cost
				Force = max(Upgrade,Force)
				Tech = max(Tech,Upgrade)	//Tech is still tracked
			if("Range")	//How far
				Max_Upgrade = min(Max_Upgrade,75)	//Max range is 75
				var/Upgrade=input("Upgrade RANGE to what level? (1-[round(Max_Upgrade)]). The maximum amount you can upgrade is determined by your intelligence (Max Upgrade cannot exceed Intelligence), and how much resources you have. So if the maximum is less than your intelligence then it is instead due to not having enough resources to upgrade it higher than the said maximum.") as num
				Upgrade = round(max(0,min(Max_Upgrade,Upgrade)))
				Cost = 800000/usr.Add
				Cost*=Upgrade-Range
				if(Cost > R.Value)
					usr << "You do not have enough resources to upgrade it to level [Upgrade]."
					return
				R.Value -= Cost
				Range = max(Range,Upgrade)
				Tech = max(Tech,Upgrade)	//Tech is still tracked
			if("Efficiency")	//How far off the damage is still 100%
				var/Upgrade=input("Upgrade RANGE to what level? (1-[round(Max_Upgrade)]). The maximum amount you can upgrade is determined by your intelligence (Max Upgrade cannot exceed Intelligence), and how much resources you have. So if the maximum is less than your intelligence then it is instead due to not having enough resources to upgrade it higher than the said maximum.") as num
				Upgrade = round(max(0,min(Max_Upgrade,Upgrade)))
				Cost = 200000/usr.Add
				Cost*=Upgrade-Range
				if(Cost > R.Value)
					usr << "You do not have enough resources to upgrade it to level [Upgrade]."
					return
				R.Value -= Cost
				Efficiency = max(Efficiency,Upgrade)
				Tech = max(Tech,Upgrade)	//Tech is still tracked

	proc/Timed_Detonation()
		var/Timer=input("Set the timer, in minutes. (1-30)") as num
		Bolted=1
		if(Timer<1) Timer=1
		if(Timer>30) Timer=30
		Timer=round(Timer)
		if(Timer!=1)
			view(src)<<"[src]: Detonation in [Timer] minutes."
			for(var/mob/player/M in view(src))
				if(!M.client) return
				M.saveToLog("| [M.client.address ? (M.client.address) : "IP not found"] | ([M.x], [M.y], [M.z]) | [src]: Detonation in [Timer] minutes.<br>")
		Timer-=1
		sleep(Timer)
		view(src)<<"[src]: Detonation in 1 minute."
		sleep(300)
		view(src)<<"[src]: Detonation in 30 seconds."
		sleep(200)
		view(src)<<"[src]: Detonation in 10..."
		sleep(10)
		for(var/mob/player/M in view(src))
			if(!M.client) return
			M.saveToLog("| [M.client.address ? (M.client.address) : "IP not found"] | ([M.x], [M.y], [M.z]) | [src] detonates.<br>")
		var/Amount=9
		while(src&&Amount)
			view(src)<<"[src]: [Amount]..."
			Amount-=1
			sleep(10)
		if(src) Detonate()

	proc/Proximity_Detonation()
		view(src)<<"[src]: Proximity Detonation activation in 1 minute"
		for(var/mob/player/M in view(src))
			if(!M.client) return
			M.saveToLog("| [M.client.address ? (M.client.address) : "IP not found"] | ([M.x], [M.y], [M.z]) | [src]: Proximity Detonation activation in 1 minute.<br>")
		Bolted=1
		sleep(600)
		while(src)
			for(var/mob/A in view(5,src)) if(A.client)
				view(src)<<"[src]: Proximity Breach. Detonation Commencing in 5 seconds..."
				for(var/mob/player/M in view(src))
					if(!M.client) return
					M.saveToLog("| [M.client.address ? (M.client.address) : "IP not found"] | ([M.x], [M.y], [M.z]) | [src]: Proximity Breach. Detonation Commencing in 5 seconds...<br>")
				spawn(50) if(src) Detonate()
				return
			sleep(100)

	proc/Remote_Detonation()
		Bolted=1
		Detonate()

	proc/Immediate_Detonation()
		Bolted=1
		Detonate()

obj/items/Cybernetics_Guide
	desc={"Cybernetics is actually quite simple. There are many modules that have different purposes.
	When you install a module, it will serve its intended purpose, but they have various drawbacks.
	These advantages and drawbacks can be read using the description verb. You can activate modules
	by picking them up and clicking them, once activated, only death can undo them. Common side effects
	of cyberization include lowering of energy, recovery, and regeneration. And yes, due to the lowered
	biological energy, it can slow learning and skill mastery of biological skills. Certain
	cyberizations will also restrict access to certain biological abilities, such as body expand. Any
	abilities lost can usually be replaced by a mechanical alternative. The more intelligence you
	gain the more modules you can make. Modules themselves are usually trade-offs of one thing for
	another, but also they will increase the effect upgrades have on you, but decrease the effect of
	biological training. When you get weapons or attacks from modules, they hardly ever use your
	natural battle power or energy to decide their damage capabilities, but rather, they will decide
	damage based on your cybernetic/artificial power from upgrading, and they will drain the energy
	from your generator to use them. Ballistic weaponry uses your strength to augment damage rather
	than force. Another common side effect of modules is loss of natural battle power gain, but
	increased effect from cybernetic power gotten from upgrades as you get more modules. Since most
	cybernetic modules decrease natural power gain, certain races would have a harder time achieving
	certain things, such as Super Saiyan for instance, and even ascension. But the cybernetic power
	you acquire can help you to become more powerful very fast, and if your race is considered weak,
	it can tip the odds heavily. In the very long run, it may be bad to be a cybernetic being, but,
	all you have to do to restore yourself, is die, and you are returned to normal. Another common
	effect of cybernetic modules is increased lifespan that rises with each new module. Many modules
	can be further upgraded before or after being installed on someone. Scientist's can upgrade not
	only the amount of available energy an android has in its generator, but the generator is also
	the biggest part of an android's artificial battle power, upgrading it is the key to having an
	android with a lot of battle power. Other modules increase artificial power very slightly just by
	having them installed.
	<br><br>
	Cybernetic weaponry comes in different types. Here they are listed from least advanced to most
	advanced.
	<br>
	Ballistic Weaponry: These drain no energy to use and their damage is based on strength instead of
	force. They are typically very fast, but weak, and have infinite ammo.
	<br><br>
	Laser Weaponry: These drain some energy from the reactor, but not much. They are fast, but weak,
	and the flexibility of what sort of attacks lasers can do is limited. Since lasers can't turn,
	can't explode, and so on. The most dramatic difference with laser weapons, is that they cannot be
	deflected.
	<br><br>
	Plasma Weaponry: A more advanced energy than any before it, it drains heavily, and is slow, but
	powerful. It has more flexibility than lasers, but perhaps not to the extent of natural ki. All
	plasma weaponry is highly explosive."}
obj/items/Hacking_Console
	icon='Lab.dmi'
	icon_state="Labtop"
	Stealable=1
	desc="If this is upgraded past the upgrade level of a door, it can open the door for you."
	verb/Upgrade()
		set src in oview(1)
		if(usr.Int_Level<Tech)
			usr<<"This is too advanced for you to mess with."
			return
		var/obj/Resources/A
		for(var/obj/Resources/B in usr) A=B
		var/Cost=10000/usr.Add
		var/Max_Upgrade=(A.Value/Cost)+Tech
		if(Max_Upgrade>usr.Int_Level) Max_Upgrade=usr.Int_Level
		var/Upgrade=input("Upgrade it to what level? (1-[round(Max_Upgrade)]). The maximum amount you can upgrade is determined by your intelligence (Max Upgrade cannot exceed Intelligence), and how much resources you have. So if the maximum is less than your intelligence then it is instead due to not having enough resources to upgrade it higher than the said maximum.") as num
		if(Upgrade>usr.Int_Level) Upgrade=usr.Int_Level
		if(Upgrade>Max_Upgrade) Upgrade=Max_Upgrade
		if(Upgrade<1) Upgrade=1
		Upgrade=round(Upgrade)
		if(Upgrade<Tech) switch(input("You wish to bring this Level [Tech] [src] to Level [Upgrade]?") in list("Yes","No"))
			if("No") return
		Cost*=Upgrade-Tech
		if(Cost<0) Cost=0
		if(Cost>A.Value)
			usr<<"You do not have enough resources to upgrade it to level [Upgrade]"
			return
		view(src)<<"[usr] upgrades the [src] to level [Upgrade]"
		for(var/mob/player/M in view(src))
			if(!M.client) return
			M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades the [src] to level [Upgrade].<br>")
		A.Value-=Cost
		Tech=Upgrade
		desc="Level [Tech] [src]"
		Level=Upgrade
	/*verb/Upgrade()
		set src in oview(1,usr)
		if(Level<usr.Int_Level)
			Level=usr.Int_Level
			usr<<"You upgrade the [src] to level [Level]"
		else usr<<"It is beyond your upgrading capabilities"*/
	verb/Use()
		for(var/obj/Turfs/Door/A in get_step(usr,usr.dir))
			if(A.Level<Level)
				view(usr)<<"[usr] uses the [src] to hack into the [A] and opens it!"
				for(var/mob/player/M in view(src))
					if(!M.client) return
					M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] uses the [src] to hack into [A] and opens it!<br>")
				A.Open()
			else
				view(usr)<<"[usr] tries to hack into the [A], but it is too advanced"
				for(var/mob/player/M in view(src))
					if(!M.client) return
					M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] uses the [src] to hack into [A] but it is too advanced!<br>")

obj/items/Force_Field
	desc="Activate this and it will protect you against energy attack so long as its energy remains. \
	Each shot it deflects drains the battery."
	icon='Lab.dmi'
	icon_state="Computer 1"
	Stealable=1
	/*Click() if(locate(src) in usr)
		if(!suffix)
			if(Level<=0)
				usr<<"[src]'s battery is drained"
				return
			suffix="*Equipped*"
		else suffix=null*/
	verb/Upgrade()
		set src in oview(1,usr)
		var/Amount=input("How many resources do you want to put into its battery?") as num
		if(Amount<1) return
		for(var/obj/Resources/A in usr)
			if(Amount>A.Value) Amount=A.Value
			Amount=round(Amount)
			A.Value-=Amount
			Level+=Amount*100*usr.Add
			view(usr)<<"[usr] adds [Commas(Amount*usr.Add)] to the [src]'s battery"
			desc=initial(desc)+"<br>[Commas(Level)] Battery Remaining"
			for(var/mob/player/M in view(src))
				if(!M.client) return
				M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] adds to the [Commas(Amount*usr.Add)] [src]'s battery.<br>")

mob/proc/Force_Field() spawn if(src)
	var/A='Force Field.dmi'
	A+=rgb(100,200,250,120)
	overlays-=A
	overlays+=A
	spawn(50) overlays-=A
obj/items/Bomb
	icon='Lab.dmi'
	icon_state="Panel1"
	density=1
	Stealable=1
	desc="Upgrading force will increase the damage of whatever the explosion touches. Upgrading \
	range will increase the distance the explosion reaches. Upgrading speed will increase the rate \
	that the explosion reaches its full range. If you turn it into a missile, you will have to input \
	coordinates using the Set verb, then use the detonator on it to commence launching."
	var/Force=1
	var/Range=15
	var/Speed=1
	var/Missile
	var/MissileX
	var/MissileY
	New()
		spawn if(src) if(Bolted) Proximity_Detonation()
		//..()
	/*verb/Upgrade()
		set src in oview(1)
		var/obj/Resources/A
		for(var/obj/Resources/B in usr) A=B
		var/list/Choices=new
		if(A.Value>=2000*Tech/usr.Add) Choices+="Force ([2000*Tech/usr.Add])"
		if(Range<35&&A.Value>=2000*Tech/usr.Add) Choices+="Explosion Radius ([2000*Tech/usr.Add])"
		if(Speed<20&&A.Value>=2000*Tech/usr.Add) Choices+="Explosion Speed ([2000*Tech/usr.Add])"
		if(!Missile&&A.Value>=10000/usr.Add) Choices+="Convert to Missile ([10000/usr.Add])"
		if(!Choices)
			usr<<"You do not have enough resources"
			return
		var/Choice=input("Change what?") in Choices
		if(Choice=="Force ([2000*Tech/usr.Add])")
			if(A.Value<2000*Tech/usr.Add) return
			A.Value-=2000*Tech/usr.Add
			Force+=1
		if(Choice=="Explosion Radius ([2000*Tech/usr.Add])")
			if(A.Value<2000*Tech/usr.Add) return
			A.Value-=2000*Tech/usr.Add
			Range+=1
		if(Choice=="Explosion Speed ([2000*Tech/usr.Add])")
			if(A.Value<2000*Tech/usr.Add) return
			A.Value-=2000*Tech/usr.Add
			Speed+=1
		if(Choice=="Convert to Missile ([10000/usr.Add])")
			if(A.Value<10000/usr.Add) return
			A.Value-=10000/usr.Add
			Missile=1
			usr<<"If you want the missile to go anywhere, you will need to reprogram it"
			icon='Missile.dmi'
		Tech+=1
		Reset_Desc()*/
	verb/Upgrade()
		set src in oview(1)
		if(usr.Int_Level<Tech)
			usr<<"This is too advanced for you to mess with."
			return
		var/obj/Resources/A
		for(var/obj/Resources/B in usr) A=B
		var/Cost=700000/usr.Add
		var/Max_Upgrade=(A.Value/Cost)+Tech
		if(Max_Upgrade>usr.Int_Level) Max_Upgrade=usr.Int_Level
		var/Upgrade=input("Upgrade it to what level? (1-[round(Max_Upgrade)]). The maximum amount you can upgrade is determined by your intelligence (Max Upgrade cannot exceed Intelligence), and how much resources you have. So if the maximum is less than your intelligence then it is instead due to not having enough resources to upgrade it higher than the said maximum.") as num
		if(Upgrade>usr.Int_Level) Upgrade=usr.Int_Level
		if(Upgrade>Max_Upgrade) Upgrade=Max_Upgrade
		if(Upgrade<1) Upgrade=1
		Upgrade=round(Upgrade)
		if(Upgrade<Tech) switch(input("You wish to bring this Level [Tech] [src] to Level [Upgrade]?") in list("Yes","No"))
			if("No") return
		Cost*=Upgrade-Tech
		if(Cost<0) Cost=0
		if(Cost>A.Value)
			usr<<"You do not have enough resources to upgrade it to level [Upgrade]"
			return
		view(src)<<"[usr] upgrades the [src] to level [Upgrade]"
		for(var/mob/player/M in view(src))
			if(!M.client) return
			M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades the [src] to level [Upgrade].<br>")

		A.Value-=Cost
		Tech=Upgrade
		desc="Level [Tech] [src]"
		Force=Upgrade*0.01*rand(90,110)
	//	Range=Upgrade
		Speed=10
		if(Upgrade>10) switch(input("Do you want to convert it into a missile?") in list("Yes","No"))
			if("Yes")
				Missile=1
				icon='Missile.dmi'
	proc/Reset_Desc()
		desc=initial(desc)
		desc+="<br>Force: [Commas((Force**3)*500)] BP"
		desc+="<br>Radius: [Range]"
		desc+="<br>Explosion Speed: [Speed]"
		if(Missile) desc+="<br>Missile Capability"
	proc/Detonate()
		if(Missile&&MissileX&&MissileY) while(src&&(x!=MissileX||y!=MissileY))
			density=0
			step_towards(src,locate(MissileX,MissileY,z))
			density=1
			sleep(10)
		var/Damage=100*(Force**3)
		var/Amount=5
		while(Amount)
			Amount-=1
			for(var/turf/A in view(src,Range))
				A.Health-=Damage
				for(var/obj/B in A) if(B!=src)
					B.Health-=Damage
					if(B.Health<=0||istype(B,/obj/Edges)) del(B)
				for(var/mob/B in A)
					B.Health-=(Damage*100)/(B.Base*B.Body*B.Res)
					if(B.Health<=0) B.Death()
				if(A.Health<=0)
					if(usr!=0) A.Destroy(usr,usr.key)
					else A.Destroy("Unknown","Unknown")
				A.Self_Destruct_Lightning(100)
				if(prob(100/(Speed**2))) sleep(1)
			sleep(15)
			del(src)
	verb/Set()
		set src in oview(1,usr)
		if(Bolted)
			usr<<"It is already armed, you cannot reprogram it"
			return
		view(src)<<"[usr] has begun to program the bomb."
		for(var/mob/player/M in view(src))
			if(!M.client) return
			M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has begun to program the bomb.<br>")
		Password=input("Set the access code for remote detonation.") as text
		if(Missile)
			MissileX=input("Input X coordinate for missile. (1-500). Input 0 to explode at drop location \
			instead.") as num
			MissileY=input("Input Y coordinate for missile. (1-500)") as num
			if(MissileX<1) MissileX=1
			if(MissileY<1) MissileY=1
			if(MissileX>world.maxx) MissileX=world.maxx
			if(MissileY>world.maxy) MissileY=world.maxy
		name=input("Name this bomb") as text
		if(!name) name=initial(name)
	verb/Arm()
		set src in oview(1,usr)
		if(usr.key in Noobs)
			usr<<"Noobed people cannot use this"
			return
		if(Bolted)
			usr<<"It is already armed"
			return
		switch(input("Choose method. Only choose if you do not plan on remote detonation. Once \
		activated, it cannot be deactivated.") in list("Cancel","Timer","Proximity"))
			if("Timer") Timed_Detonation()
			if("Proximity") Proximity_Detonation()
	proc/Timed_Detonation()
		var/Timer=input("Set the timer, in minutes. (1-30)") as num
		Bolted=1
		if(Timer<1) Timer=1
		if(Timer>30) Timer=30
		Timer=round(Timer)
		if(Timer!=1)
			view(src)<<"[src]: Detonation in [Timer] minutes."
			for(var/mob/player/M in view(src))
				if(!M.client) return
				M.saveToLog("| [M.client.address ? (M.client.address) : "IP not found"] | ([M.x], [M.y], [M.z]) | [src]: Detonation in [Timer] minutes.<br>")

		Timer-=1
		sleep(Timer)
		view(src)<<"[src]: Detonation in 1 minute."
		sleep(300)
		view(src)<<"[src]: Detonation in 30 seconds."
		sleep(200)
		view(src)<<"[src]: Detonation in 10..."
		sleep(10)
		for(var/mob/player/M in view(src))
			if(!M.client) return
			M.saveToLog("| [M.client.address ? (M.client.address) : "IP not found"] | ([M.x], [M.y], [M.z]) | [src] detonates.<br>")
		var/Amount=9
		while(src&&Amount)
			view(src)<<"[src]: [Amount]..."
			Amount-=1
			sleep(10)
		if(src) Detonate()
	proc/Proximity_Detonation()
		view(src)<<"[src]: Proximity Detonation activation in 1 minute"
		for(var/mob/player/M in view(src))
			if(!M.client) return
			M.saveToLog("| [M.client.address ? (M.client.address) : "IP not found"] | ([M.x], [M.y], [M.z]) | [src]: Proximity Detonation activation in 1 minute.<br>")
		Bolted=1
		sleep(600)
		while(src)
			for(var/mob/A in view(5,src)) if(A.client)
				view(src)<<"[src]: Proximity Breach. Detonation Commencing in 5 seconds..."
				spawn(50) if(src) Detonate()
				for(var/mob/player/M in view(src))
					if(!M.client) return
					M.saveToLog("| [M.client.address ? (M.client.address) : "IP not found"] | ([M.x], [M.y], [M.z]) | [src] detonates.<br>")
				return
			sleep(100)
	proc/Remote_Detonation()
		Bolted=1
		for(var/mob/player/M in view(src))
			if(!M.client) return
			M.saveToLog("| [M.client.address ? (M.client.address) : "IP not found"] | ([M.x], [M.y], [M.z]) | [src] detonates.<br>")
		Detonate()
		return
obj/items/Detonator
	icon='Cell Phone.dmi'
	Stealable=1
	desc="This can be used to activate the detonation sequence on bombs or missiles from afar."
	verb/Set() Password=input("Set a password to activate bombs of matching passwords.") as text
	verb/Use()
		if(usr.key in Noobs)
			usr<<"Noobed people cannot use this"
			return
		if(!Password)
			usr<<"You must set a password to activate bombs of the same password"
			return
		switch(input("Confirm detonation command:") in list("Yes","No"))
			if("Yes")
				view(usr)<<"[usr] activates their remote detonator"
				for(var/mob/player/M in view(usr))
					if(!M.client) return
					M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] activates their remote detonator, bomb will detonate in 30 seconds.<br>")
				var/list/Bombs=new
				for(var/obj/items/Bomb/A) Bombs+=A
				for(var/obj/items/Nuke/A) Bombs+=A
				for(var/obj/B in Bombs)
					var/obj/items/Bomb/A=B
					if(src&&A.Password==Password&&!A.Bolted)
						if(!A.z) view(usr)<<"[src]: Command code denied for [A] (Someone is carrying it)"
						else
							view(usr)<<"[src]: Command code confirmed for [A]. It will detonate in 30 seconds."
							range(20,A)<<"<font color=red><font size=2>[A]: Detonation Code Confirmed. Nuclear Detonation in 30 Seconds."
							for(var/mob/player/M in range(20,A))
								if(!M.client) return
								M.saveToLog("| [M.client.address ? (M.client.address) : "IP not found"] | ([M.x], [M.y], [M.z]) | [A]: Detonation Code Confirmed. Nuclear Detonation in 30 Seconds. Location: [A.x],[A.y],[A.z]<br>")
							spawn(300) if(A) A.Remote_Detonation()

/*
obj/Antivirus_Tower
	icon='Lab.dmi'
	icon_state="Tower 1"
	density=1
	desc="This emits a pulse every minute that will carry with it the antivirus, killing all zombies \
	in proximity, and curing anyone who is infected."
	var/Distance=35
	New()
		spawn if(src) Antivirus_Tower()
		var/image/A=image(icon='Lab.dmi',icon_state="Tower 2",pixel_y=32,layer=MOB_LAYER+1)
		var/image/B=image(icon='Lab.dmi',icon_state="Tower 3",pixel_y=64,layer=MOB_LAYER+1)
		overlays.Remove(A,B)
		overlays.Add(A,B)
		//sd_SetLuminosity(3)
		//..()
	proc/Antivirus_Tower() while(src)
		for(var/mob/A in view(Distance,src))
			if(A.client) A.Zombied=0
			else if(A.Zombied) del(A)
		sleep(rand(400,800))
*/

obj/items/Hover_Chair
	icon='Item, Hover Chair.dmi'
	icon_state="base"
	density=1
	layer=MOB_LAYER+10
	Savable=1
	New()
		var/image/A=image(icon='Item, Hover Chair.dmi',icon_state="side1",pixel_y=0,pixel_x=-32,layer=10)
		var/image/B=image(icon='Item, Hover Chair.dmi',icon_state="side2",pixel_y=0,pixel_x=32,layer=10)
		var/image/C=image(icon='Item, Hover Chair.dmi',icon_state="back",pixel_y=0,pixel_x=-0,layer=MOB_LAYER-1)
		var/image/D=image(icon='Item, Hover Chair.dmi',icon_state="front",pixel_y=0,pixel_x=0,layer=MOB_LAYER+10)
		var/image/E=image(icon='Item, Hover Chair.dmi',icon_state="bottom",pixel_y=-32,pixel_x=0,layer=10)
		overlays.Remove(A,B,C,D,E)
		overlays.Add(A,B,C,D,E)

		//..()
	Click() if(locate(src) in usr)
		if(!suffix)
			usr.overlays+=src
			suffix="*Equipped*"
		else
		//	usr.overlays-=src
			usr.layer=MOB_LAYER+10
			usr.overlays-=usr.overlays
			suffix=null
obj/items/Cloak_Controls
	icon='Cloak.dmi'
	icon_state="Controls"
	desc="You can use this to activate or deactivate all cloaked objects matching the same password \
	you have set for the controls. You can also use this to remove the cloaking chip from objects \
	next to you by using uninstall on it. You can upgrade this to have more cloaking capability so \
	that it is harder to detect. This is also a personal cloak, if you activate it, you will become \
	out of phase, and stay out of phase until you deactivate it. While out of phase you will also see \
	anything that is in the same phase or lower than yourself. The personal cloak is 5 levels less \
	powerful than the cloaking modules themselves."
	var/Active
	Level=1
	Stealable=1
	verb/Use()
		if(Level<1)
			usr<<"You cannot use this without further upgrades"
			return
		if(!usr.invisibility)
			view(usr)<<"[usr] activates their personal cloak"
			for(var/mob/player/M in view(usr))
				if(!M.client) return
				M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] activates their personal cloak.<br>")
			usr<<"You are now [Level] levels out of phase"
			usr.invisibility=Level
			usr.see_invisible=Level
		else
			usr.invisibility=0
			usr.see_invisible=0
			view(usr)<<"[usr] deactivates their personal cloak."
			for(var/mob/player/M in view(usr))
				if(!M.client) return
				M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] deactivates their personal cloak.<br>")
	verb/Activate()
		if(!Active)
			view(usr)<<"[usr] activates the cloaking controls"
			Active=1
			for(var/mob/player/M in view(usr))
				if(!M.client) return
				M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] activates their cloak controls.<br>")

		else
			view(usr)<<"[usr] deactivates the cloaking controls"
			Active=0
			for(var/mob/player/M in view(usr))
				if(!M.client) return
				M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] deactivates their cloak controls.<br>")
		for(var/obj/A) for(var/obj/items/Cloak/B in A) if(B.Password==Password)
			if(Active) A.invisibility=Level
			else A.invisibility=0
	verb/Set() Password=input("Set the password for tracking cloaking chips of the same password") as text
	verb/Uninstall() for(var/obj/A in get_step(usr,usr.dir)) for(var/obj/items/Cloak/B in A)
		view(usr)<<"[usr] removes the cloaking system from [A]"
		A.invisibility=0
		B.loc=usr.loc
	verb/Upgrade()
		set src in oview(1)
		if(Level>=100)
			usr<<"It is at the maximum."
			return
		if(usr.Int_Level<Tech)
			usr<<"This is too advanced for you to mess with."
			return
		var/obj/Resources/A
		for(var/obj/Resources/B in usr) A=B
		var/Cost=400000/usr.Add
		var/Max_Upgrade=(A.Value/Cost)+Tech
		if(Max_Upgrade>usr.Int_Level) Max_Upgrade=usr.Int_Level
		var/Upgrade=input("Upgrade it to what level? (1-[round(Max_Upgrade)]). The maximum amount you can upgrade is determined by your intelligence (Max Upgrade cannot exceed Intelligence), and how much resources you have. So if the maximum is less than your intelligence then it is instead due to not having enough resources to upgrade it higher than the said maximum.") as num
		if(Upgrade>usr.Int_Level) Upgrade=usr.Int_Level
		if(Upgrade>Max_Upgrade) Upgrade=Max_Upgrade
		if(Upgrade<1) Upgrade=1
		Upgrade=round(Upgrade)
		if(Upgrade<Tech) switch(input("You wish to bring this Level [Tech] [src] to Level [Upgrade]?") in list("Yes","No"))
			if("No") return
		Cost*=Upgrade-Tech
		if(Cost<0) Cost=0
		if(Cost>A.Value)
			usr<<"You do not have enough resources to upgrade it to level [Upgrade]"
			return
		view(src)<<"[usr] upgrades the [src] to level [Upgrade]"
		for(var/mob/player/M in view(src))
			if(!M.client) return
			M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades [src] to level [Upgrade].<br>")
		A.Value-=Cost
		Tech=Upgrade
		desc="Level [Tech] [src]"
		Level=1+round(0.1*Upgrade*0.01*rand(50,200))
		if(Level<1) Level=1
		if(Level>100) Level=100
	/*verb/Upgrade()
		set src in oview(1)
		var/obj/Resources/A
		for(var/obj/Resources/B in usr) A=B
		var/list/Choices=new
		if(Level<100&&A.Value>=1000*Tech/usr.Add) Choices.Add("Cloak Ability ([1000*Tech/usr.Add])")
		if(!Choices)
			usr<<"You do not have enough resources"
			return
		Choices+="Cancel"
		var/Choice=input("Change what?") in Choices
		if(Choice=="Cancel") return
		if(Choice=="Cloak Ability ([1000*Tech/usr.Add])")
			if(A.Value<1000*Tech/usr.Add) return
			A.Value-=1000*Tech/usr.Add
			Level+=1
		Tech+=1
		desc=initial(desc)
		desc+="<br><br>Level [Level] Cloak"*/
obj/items/Cloak
	icon='Cloak.dmi'
	desc="You can install this on any object to cloak it using cloak controls. First you must set the \
	password so that it matches the password of your cloak controls or it cannot be activated by those \
	controls."
	Stealable=1
	verb/Set() Password=input("Set the password for this cloak") as text
	verb/Use()
		if(!Password)
			usr<<"You must Set it first"
			return
		for(var/obj/A in get_step(usr,usr.dir))
			view(usr)<<"[usr] installs a cloaking system onto the [A]"
			for(var/mob/player/M in view(usr))
				if(!M.client) return
				M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] installs a cloaking system onto [A].<br>")
			A.contents+=src
obj/items/Communicator
	icon='Cell Phone.dmi'
	desc="Use this to call somebody who also has a cell phone. Just use Say or Whisper and you can \
	talk to them til the call has ended. You end a call by hitting Use again. Anyone within 1 space \
	of you can hear your conversation and also be heard on the cell phone"
	var/Frequency=1
	Stealable=1
	verb/Transmit(msg as text) for(var/mob/A in Players)
		for(var/obj/items/Scanner/B in A) if(B.suffix&&A.Dead==usr.Dead&&B.Frequency==Frequency)
			A<<"<font color=#FFFFFF>(Scanner)<font color=[usr.TextColor]>[usr] says, '[msg]'"
			A.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] SCOUTER: [msg]<br>")
		for(var/obj/items/Communicator/B in A) if(A.Dead==usr.Dead&&B.Frequency==Frequency)
			A<<"<font color=#FFFFFF>(Scanner)<font color=[usr.TextColor]>[usr] says, '[msg]'"
			A.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] SCOUTER: [msg]<br>")
	verb/Frequency() Frequency=input("Choose a frequency, it can be anything. It lets you talk to \
	others on the same frequency. Default is 1") as text
obj/items/Stun_Chip
	icon='Control Chip.dmi'
	Stealable=1
	desc="You can install this on someone and use the Stun Remote to stun them temporarily. To use the \
	remote to stun them your remote must share the same remote access code as the installed chip. \
	You can also use this to remove chips from somebody using the Remove command, both chips will be \
	destroyed in the process."
	New()
		name=initial(name)
		//..()
	verb/Use(mob/A in view(1,usr))
		if(A==usr||A.icon_state=="KO"||A.Frozen)
			view(usr)<<"[usr] installs a stun chip in [A]"
			for(var/mob/player/M in view(usr))
				if(!M.client) return
				M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] installs a stun chip in [A].<br>")
			var/obj/Stun_Chip/B=new
			B.Password=input("Input a remote access code to activate the chip") as text
			A.contents+=B
			del(src)
	verb/Remove(mob/A in view(1,usr))
		for(var/obj/Stun_Chip/B in A)
			view(usr)<<"[usr] removes a Stun Chip from [A]"
			for(var/mob/player/M in view(usr))
				if(!M.client) return
				M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] removes a Stun Chip from [A].<br>")
			del(B)
		del(src)
obj/Stun_Chip
	desc="You can install this on someone and use the Stun Remote to stun them temporarily. To use the \
	remote to stun them your remote must share the same remote access code as the installed chip. \
	You can also use this to remove chips from somebody using the Remove command, both chips will be \
	destroyed in the process."
	icon='Control Chip.dmi'
obj/items/Stun_Controls
	icon='Stun Controls.dmi'
	desc="You can use this to activate a stun chip you have installed on somebody. It only works \
	within your visual range."
	Stealable=1
	verb/Set() Password=input("Input a remote access code for activating nearby stun chips") as text
	verb/Use()
		view(usr)<<"[usr] activates their stun controls"
		for(var/mob/A in view(usr))
			A.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] activates their stun controls.<br>")
			for(var/obj/Stun_Chip/B in A) if(B.Password==Password) A.KO("by stun chip!")
obj/items/Transporter_Pad
	icon='Transporter Pad.dmi'
	desc="You can use this to transport yourself between other pads sharing the same remote access code"
	Stealable=1
	Level=1
	proc/Transport()
		var/list/A=new
		for(var/obj/items/Transporter_Pad/B) if(B!=src)
			if(Level<2&&B.z!=z&&B.z)
			else if(B.Password==Password&&B.z) A+=B
		if(!A) return
		A+="Cancel"
		var/obj/items/Transporter_Pad/C=input("Go to which transporter?") in A
		if(C=="Cancel") return
		usr.overlays+='SBombGivePower.dmi'
		sleep(30)
		if(usr)
			usr.overlays-='SBombGivePower.dmi'
			usr.overlays-='SBombGivePower.dmi'
			if(C) usr.loc=C.loc
			usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] uses [src] to teleport to [C] ([C.x],[C.y],[C.z]) <br>")
	verb/Set()
		set src in oview(1)
		if(!Password)
			Password=input("Set the indentification code, you can only transport to \
			other pads using the same code") as text
			name=input("Name the transporter pad, preferably name it after the location it will take you \
			to") as text
			if(!name) name=initial(name)
		else usr<<"It is already initialized"
	verb/Upgrade()
		set src in oview(1)
		var/Cost=20000000/usr.Add
		for(var/obj/Resources/A in usr)
			if(A.Value>=Cost)
				A.Value-=Cost
				Level+=1
			else usr<<"Only with [Commas(Cost)] resources can you upgrade this, allowing to to travel between \
			planets."
obj/items/Transporter_Watch
	icon='Transporter Watch.dmi'
	desc="You can use this to transport yourself to any transporter pad that matches your watch's \
	remote access code"
	Level=1
	Stealable=1
	proc/Transport()
		var/list/A=new
		for(var/obj/items/Transporter_Pad/B)
			if(Level<2&&B.z!=usr.z&&B.z)
			else if(B.Password==Password&&B.z) A+=B
		var/obj/items/Transporter_Pad/C=input("Go to which transporter?") in A
		usr.overlays+='SBombGivePower.dmi'
		sleep(30)
		usr.overlays-='SBombGivePower.dmi'
		usr.overlays-='SBombGivePower.dmi'
		if(C)
			if(usr.S) usr.S.loc=C.loc
			else usr.loc=C.loc
			usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] uses [src] to teleport to [C] ([C.x],[C.y],[C.z]) <br>")
	verb/Use() if(icon_state!="KO") Transport()
	verb/Set() Password=input("Set the remote identification code.") as text
	verb/Upgrade()
		set src in oview(1)
		var/Cost=20000000/usr.Add
		for(var/obj/Resources/A in usr)
			if(A.Value>=Cost)
				A.Value-=Cost
				Level+=1
			else usr<<"Only with [Commas(Cost)] resources can you upgrade this, allowing to to travel between \
			planets."

obj/items/Poison_Injection
	Injection=1
	icon='Poison Injection.dmi'
	Level=1
	Stealable=1
	verb/Use(mob/A in view(1,usr))
		if(A==usr|A.icon_state=="KO"|A.Frozen)
			view(usr)<<"[usr] injects [A] with a mysterious needle!"
			for(var/mob/player/M in view(usr))
				if(!M.client) return
				M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] injects [A] with Poison (Level: [src.Level])!<br>")
			A.Poisoned+=Level
			del(src)
/*
// Upgrading for poison serves no function other then to waste resources as the ANTIVIRUS does not need to be upgraded to cure level X of poison.
// As such, I've commented it out. -- Valekor
	verb/Upgrade()
		set src in oview(1)
		if(usr.Int_Level<Tech)
			usr<<"This is too advanced for you to mess with."
			return
		var/obj/Resources/A
		for(var/obj/Resources/B in usr) A=B
		var/Cost=1000/usr.Add
		var/Max_Upgrade=(A.Value/Cost)+Tech
		if(Max_Upgrade>usr.Int_Level) Max_Upgrade=usr.Int_Level
		var/Upgrade=input("Upgrade it to what level? (1-[round(Max_Upgrade)]). The maximum amount you can upgrade is determined by your intelligence (Max Upgrade cannot exceed Intelligence), and how much resources you have. So if the maximum is less than your intelligence then it is instead due to not having enough resources to upgrade it higher than the said maximum.") as num
		if(Upgrade>usr.Int_Level) Upgrade=usr.Int_Level
		if(Upgrade>Max_Upgrade) Upgrade=Max_Upgrade
		if(Upgrade<1) Upgrade=1
		Upgrade=round(Upgrade)
		if(Upgrade<Tech) switch(input("You wish to bring this Level [Tech] [src] to Level [Upgrade]?") in list("Yes","No"))
			if("No") return
		Cost*=Upgrade-Tech
		if(Cost<0) Cost=0
		if(Cost>A.Value)
			usr<<"You do not have enough resources to upgrade it to level [Upgrade]"
			return
		view(src)<<"[usr] upgrades the [src] to level [Upgrade]"
		A.Value-=Cost
		Tech=Upgrade
		desc="Level [Tech] [src]"
		Level=0.5+(Upgrade*0.1)
*/
/*
obj/items/Diarea_Injection
	Injection=1
	icon='Diarea Injection.dmi'
	Level=1
	Stealable=1
	verb/Use(mob/A in view(1,usr))
		if(A==usr|A.Frozen|A.icon_state=="KO")
			view(usr)<<"[usr] injects [A] with a mysterious needle!"
			A.Diarea+=Level
			del(src)
	verb/Upgrade()
		set src in oview(1)
		for(var/obj/Resources/A in usr)
			var/Amount=input("How many levels do you want to add? Up to [Commas(A.Value/10000*usr.Add)]") as num
			if(Amount>round(A.Value/10000*usr.Add)) Amount=round(A.Value/10000*usr.Add)
			if(Amount<0) Amount=0
			Level+=Amount
			A.Value-=Amount*10000/usr.Add
			view(usr)<<"[usr] upgraded the [src] to level [Level]"
		desc="Level [Level] [src]"
obj/items/T_Virus_Injection
	icon='T Virus.dmi'
	Level=1
	Stealable=1
	Injection=1
	verb/Use(mob/A in view(1,usr))
		if(A==usr|A.Frozen|A.icon_state=="KO")
			view(usr)<<"[usr] injects [A] with a mysterious needle!"
			var/Old_Zombied=A.Zombied
			A.Zombied+=Level*0.1
			if(!A.client)
				if(A.icon_state!="KO"&&Old_Zombied==1)
					A.Zombied=Old_Zombied
					//A.Mutate(Level)
				//else A.Zombies() //If its state is KO, its a body, and will turn into a zombie soon after.
				// NO! FUCK ZOMBIES!
			del(src)
	/*verb/Upgrade()
		set src in oview(1)
		for(var/obj/Resources/A in usr)
			var/Amount=input("How many levels do you want to add? Up to [Commas(A.Value/10000*usr.Add)]") as num
			if(Amount>round(A.Value/10000*usr.Add)) Amount=round(A.Value/10000*usr.Add)
			if(Amount<0) Amount=0
			Level+=Amount
			A.Value-=Amount*10000/usr.Add
			view(usr)<<"[usr] upgraded the [src] to level [Level]"
		desc="Level [Level] [src]"*/
*/

obj/items/Steroid_Injection
	icon='Roids.dmi'
	Level=1
	Stealable=1
	Injection=1
	verb/Use(mob/A in view(1,usr))
		if(A==usr|A.Frozen|A.icon_state=="KO")
			view(usr)<<"[usr] injects [A] with a mysterious needle!"
			for(var/mob/player/M in view(usr))
				if(!M.client) return
				M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] injects [A] with Steroids (Level: [src.Level])!<br>")
			if(A.client)
				A.Roid_Power+=5*Level*A.BPMod
				if(A.Roid_Power>A.Base*4) A.Roid_Power=A.Base*4
			else A.BP+=100*Level*A.BPMod
			for(var/obj/Mate/B in A) B.LastUse=Year+5
			del(src)

	verb/Upgrade()
		set src in oview(1)
		for(var/obj/Resources/A in usr)
			var/Amount=input("How many levels do you want to add? Up to [Commas(A.Value/4000*usr.Add)]") as num
			if(Amount>round(A.Value/4000*usr.Add)) Amount=round(A.Value/4000*usr.Add)
			if(Amount<0) Amount=0
			Level+=Amount
			A.Value-=Amount*4000/usr.Add
			view(usr)<<"[usr] upgraded the [src] to level [Level]"
			name="Steroids x[Level]"
		desc="Level [Level] [src]. This will increase Battle Power, but decrease Regeneration and \
		Recovery by the same factor, and Refire between attacks. The more steroids you take the longer \
		the effects take to wear off, it could even be years. If you die however, the effects disappear \
		instantly and you are returned to normal. It will also make you infertile for 5 years since your \
		last injection."

obj/items/Elixir_Of_Life
	icon='Roids.dmi'
	Level=1
	Stealable=1
	Injection=1
	desc="This extends life by 5 years. But it takes away 1000 energy per use."
	verb/Use(mob/A in view(1,usr))
		if(A.MaxKi<1000)
			usr<<"They do not have enough energy to take this."
			return
		if(A==usr|A.Frozen|A.icon_state=="KO")
			view(usr)<<"[usr] injects [A] with a mysterious needle!"
			for(var/mob/player/M in view(usr))
				if(!M.client) return
				M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] injects [A] with Elixer of Life!<br>")
			A.Decline+=5
			A.MaxKi-=1000
			A.Ki-=1000
			del(src)
obj/items/LSD
	icon='LSD.dmi'
	Level=1
	Stealable=1
	Injection=1
	verb/Use(mob/A in view(1,usr))
		if(A==usr|A.Frozen|A.icon_state=="KO")
			view(usr)<<"[usr] injects [A] with a mysterious needle!"
			for(var/mob/player/M in view(usr))
				if(!M.client) return
				M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] injects [A] with LSD (level: [src.Level]!<br>")

			if(A.client)
				if(A.client.dir==NORTH) A.LSD()
			del(src)
	verb/Upgrade()
		set src in oview(1)
		for(var/obj/Resources/A in usr)
			var/Amount=input("How many levels do you want to add? Up to [Commas(A.Value/500)]") as num
			if(Amount>round(A.Value/500)) Amount=round(A.Value/500)
			if(Amount<0) Amount=0
			Level+=Amount
			A.Value-=Amount*500
			view(usr)<<"[usr] upgraded the [src] to level [Level]"
		desc="Level [Level] [src]. This will increase Battle Power, but decrease Regeneration and \
		Recovery by the same factor, and Refire between attacks. The more steroids you take the longer \
		the effects take to wear off, it could even be years. If you die however, the effects disappear \
		instantly and you are returned to normal. It will also make you infertile for 5 years since your \
		last injection."
mob/proc/LSD() spawn(100) while(src)
	src<<"OSHIT!"
	client.dir=pick(SOUTH,EAST,WEST,SOUTHEAST,SOUTHWEST,NORTHEAST,NORTHWEST)
	sleep(rand(10,600))
	if(client.dir==NORTH) return
obj/items/Antivirus
	icon='Antivirus.dmi'
	Stealable=1
	Level=1
	verb/Use()
		view(usr)<<"[usr] uses the [src] and all infection disappears"
		for(var/mob/player/M in view(usr))
			if(!M.client) return
			M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] uses Antivirus and all infection disappears!<br>")

		usr.Poisoned=0
		del(src)
/*
// Commented this out. The upgrade for the ANTIVIRUS creates a new ANTIVIRUS TOWER
// Doesn't look like it has any use since a level 1 Antivirus just nullyfies any infection
	verb/Upgrade()
		set src in oview(1,usr)
		for(var/obj/Resources/A in usr)
			if(A.Value<20000000/usr.Add)
				usr<<"You need [Commas(20000000/usr.Add)] resources to build this."
				return
			A.Value-=20000000/usr.Add
			new/obj/Antivirus_Tower(loc)
			del(src)
*/

obj/items/layer=4
obj/items/Fruit
	icon='Yemma Fruit.dmi'
	Add=10 //minutes of training
	Stealable=1
	desc="Eating this will give you some power, and some energy. It will also speed up your \
	regeneration and recovery rate temporarily, much like a Senzu bean."
	verb/Eat()
		usr.Base+=Add*(usr.gain*6000)*usr.BPMod*GG*usr.BPRank/usr.Fruits
		usr.MaxKi+=100*usr.KiMod/usr.Fruits
		usr.Senzu+=3
		usr.Fruits+=1
		view(usr)<<"[usr] eats a [src]"
		for(var/mob/player/M in view(usr))
			if(!M.client) return
			M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] eats [src]!<br>")
		del(src)


obj/items/Moon
	icon='Moon.dmi'
	Stealable=1
	desc="Using this will turn nearby Saiyans that still have tails into Oozaru"
	var/Emitter
	verb/Use()
		set src in oview(1)
		if(icon_state=="On") return
		icon_state="On"
		view(usr)<<"[usr] activates the [src]!"
		for(var/mob/player/M in view(usr))
			if(!M.client) return
			M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] activates the [src]!<br>")

		for(var/mob/A in view(12,src)) A.Oozaru()
		spawn(10) if(src&&Emitter) for(var/mob/A in view(12,src)) if(A.ssjdrain>=300&&!usr.hasssj4&&usr.Race=="Saiyan") A.Golden()
		spawn(100) if(src) del(src)
	verb/Upgrade()
		set src in oview(1)
		var/obj/Resources/A
		for(var/obj/Resources/B in usr) A=B
		var/list/Choices=new
		if(A.Value>=50000000*Tech/usr.Add&&!Emitter) Choices.Add("Turn into Emitter ([50000000*Tech/usr.Add])")
		if(!Choices)
			usr<<"You do not have enough resources"
			return
		var/Choice=input("Change what?") in Choices
		if(Choice=="Turn into Emitter ([50000000*Tech/usr.Add])")
			if(A.Value<50000000*Tech/usr.Add) return
			A.Value-=50000000*Tech/usr.Add
			Emitter=1
			name="Emitter"
			icon='Moon2.dmi'
		Tech+=1

obj/items/PDA
	icon='PDA.dmi'
	desc="This can be used to store information, even youtube videos if you know how."
	Stealable=1
	var/notes={"<html>
<head><title>Notes</title><body>
<center><body bgcolor="#000000"><font size=2><font color="#CCCCCC">
</body><html>"}
	verb/Name() name=input("") as text
	verb/View()
		set src in world
		usr<<browse(notes,"window= ;size=700x600")
	verb/Input()
		notes=input(usr,"Notes","Notes",notes) as message
obj/items/Shuriken
	icon='Shuriken.dmi'
	Stealable=1
	desc="This is a ranged move based on the thrower's strength and the sharpness of the blade"
	verb/Shuriken()
		set category="Skills"
		var/obj/Blast/A=new
		A.Shuriken=1
		A.Shrapnel=1
		A.loc=usr.loc
		A.icon='Shuriken.dmi'
		A.density=1
		A.Damage=1000000
		A.Power=1000000
		A.Offense=1000
		A.Fatal=0
		walk(A,usr.dir)
		spawn(100) if(A) del(A)
obj/Well
	icon='props.dmi'
	icon_state="21"
	density=1
	var/effectiveness=2
	Savable=0
	Grabbable=0
	Spawn_Timer=180000
	New()
		for(var/obj/Well/A in range(0,src)) if(A!=src) del(A)
		//..()
	verb/Action()
		set category="Other"
		set src in oview(1)
		if(usr.icon_state!="Meditate"&&usr.icon_state!="Train")
			view(6)<<"<font color=red>* [usr] drinks some water. *"
			for(var/mob/player/M in view(6))
				if(!M.client) return
				M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] drinks some water.<br>")
			if(usr.Health<100) usr.Health+=(100/effectiveness)
			if(usr.Ki<usr.MaxKi) if(!usr.Dead) usr.Ki+=(usr.MaxKi/effectiveness)
obj/items
	Weights
		icon='Clothes_ShortSleeveShirt.dmi'
		Stealable=1
		New()
			name="[round(Weight)]lb Weights"
			//..()
		Click() if(locate(src) in usr)
			var/CurrentWeight=0
			var/Weights=0
			if(!suffix) for(var/obj/Expand/A in usr) if(A.Using) return
			if(!suffix) for(var/obj/Majin/A in usr) if(A.Using) return
			for(var/obj/items/Weights/A in usr) if(A.suffix)
				CurrentWeight+=A.Weight
				Weights+=1
			if(!suffix&&Weights>=3)
				usr<<"You cannot wear more than 3 of these at once"
				return
			if(!suffix&&(CurrentWeight+Weight)>((usr.Str+usr.End)*2))
				usr<<"Putting this on would exceed your maximum lift of [Commas(round((usr.Str+usr.End)*2))] pounds. You cannot use it."
				return
			for(var/obj/Oozaru/A in usr) if(A.suffix) return
			if(!suffix)
				suffix="*Equipped*"
				usr.overlays+=icon
				usr<<"You put on the [src]. Your max lift is [Commas(round((usr.Str+usr.End)*2))] pounds"
				usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] puts on the [src].<br>")
			else
				suffix=null
				usr.overlays-=icon
				usr<<"You take off the [src]. Your max lift is [Commas(round((usr.Str+usr.End)*2))] pounds"
				usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] removes the [src].<br>")
	Regenerator
		Stealable=1
		desc="Stepping into this will accelerate your healing rate. It heals faster the more upgraded \
		it is. It will break in the strain of high gravity."
		New()
			var/image/A=image(icon='Heal Tank.dmi',icon_state="top",pixel_y=32)
			var/image/B=image(icon='Heal Tank.dmi',icon_state="bottom",pixel_y=-32)
			overlays.Remove(A,B)
			overlays.Add(A,B)
			spawn if(src) Regenerator_Loop()
			//..()
		proc/Regenerator_Loop() while(src)
			if(z) if(icon_state!="middlebroke")
				if(z==0&&isnull(loc)) del(src)
				if(prob(5)) for(var/turf/A in range(0,src)) if(A.gravity>10)
					icon_state="middlebroke"
					view(src)<<"The [src] is crushed by the force of the gravity!"
					for(var/mob/player/M in view(src))
						if(!M.client) return
						M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] is crushed by the force of the gravity.<br>")
				for(var/mob/A in range(0,src)) if(A.Health<100)
					A.Health+=1*Level*A.Regeneration
					if(A.icon_state=="KO"&&A.Health>=100) A.Un_KO()
			sleep(rand(10,90))
		icon='Heal Tank.dmi'
		icon_state="middle"
		layer=MOB_LAYER+1
		verb/Bolt()
			set src in oview(1)
			if(x&&y&&z&&!Bolted)
				switch(input("Are you sure you want to bolt this to the ground so nobody can ever pick it up? Not even you?") in list("Yes","No"))
					if("Yes")
						view(src)<<"<font size=1>[usr] bolts the [src] to the ground."
						Bolted=1
						for(var/mob/player/M in view(src))
							if(!M.client) return
							M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] bolts [src] to the ground.<br>")
		/*verb/Upgrade()
			set src in oview(1)
			var/obj/Resources/A
			for(var/obj/Resources/B in usr) A=B
			var/list/Choices=new
			if(A.Value>=1000*Tech/usr.Add) Choices.Add("Heal Rate ([1000*Tech/usr.Add])")
			if(A.Value>=1000/usr.Add&&icon_state=="middlebroke") Choices+="Repair ([1000/usr.Add])"
			if(!Choices)
				usr<<"You do not have enough resources"
				return
			var/Choice=input("Change what?") in Choices
			if(Choice=="Cancel") return
			if(Choice=="Heal Rate ([1000*Tech/usr.Add])")
				if(A.Value<1000*Tech/usr.Add) return
				A.Value-=1000*Tech/usr.Add
				Level+=1
			if(Choice=="Repair ([1000/usr.Add])")
				if(A.Value<1000/usr.Add) return
				A.Value-=1000/usr.Add
				icon_state="middle"
			Tech+=1
			desc="[Level]x Heal Rate"*/
		verb/Upgrade()
			set src in oview(1)
			if(usr.Int_Level<Tech)
				usr<<"This is too advanced for you to mess with."
				return
			var/obj/Resources/A
			for(var/obj/Resources/B in usr) A=B
			var/Cost=20000/usr.Add
			var/Max_Upgrade=(A.Value/Cost)+Tech
			if(Max_Upgrade>usr.Int_Level) Max_Upgrade=usr.Int_Level
			var/Upgrade=input("Upgrade it to what level? (1-[round(Max_Upgrade)]). The maximum amount you can upgrade is determined by your intelligence (Max Upgrade cannot exceed Intelligence), and how much resources you have. So if the maximum is less than your intelligence then it is instead due to not having enough resources to upgrade it higher than the said maximum.") as num
			if(Upgrade>usr.Int_Level) Upgrade=usr.Int_Level
			if(Upgrade>Max_Upgrade) Upgrade=Max_Upgrade
			if(Upgrade<1) Upgrade=1
			Upgrade=round(Upgrade)
			if(Upgrade<Tech) switch(input("You wish to bring this Level [Tech] [src] to Level [Upgrade]?") in list("Yes","No"))
				if("No") return
			Cost*=Upgrade-Tech
			if(Cost<0) Cost=0
			if(Cost>A.Value)
				usr<<"You do not have enough resources to upgrade it to level [Upgrade]"
				return
			view(src)<<"[usr] upgrades the [src] to level [Upgrade]"
			for(var/mob/player/M in view(src))
				if(!M.client) return
				M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades [src] to level [Upgrade].<br>")
			A.Value-=Cost
			Tech=Upgrade
			icon_state="middle"
			Level=0.1*Upgrade*0.01*rand(50,200)
			desc="Level [Tech] [src]"
obj/items/Armor
	Health=100
	Stealable=1
	New()
		desc="<br>[Commas(Health)] Durability Armor"
		//..()
	verb/Upgrade()
		set src in oview(1)
		var/obj/Resources/A
		for(var/obj/Resources/B in usr) A=B
		var/Amount=round(input("Add how much resources to this armor's durability?") as num)
		if(Amount>A.Value) Amount=A.Value
		if(Amount<0) Amount=0
		A.Value-=Amount
		Amount*=usr.Add
		Health+=Amount
		desc="<br>[Commas(Health)] Durability Armor"
		view(usr)<<"[usr] adds +[Commas(Amount)] to the [src]"
		for(var/mob/player/M in view(usr))
			if(!M.client) return
			M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] adds +[Commas(Amount)] to the [src].<br>")

	Click()
		if(locate(src) in usr)
			for(var/obj/items/Armor/A in usr)
				if(A.suffix&&A!=src)
					usr<<"You already have armor equipped."
					return
				if(!suffix)
					suffix="*Equipped*"
					usr.overlays+=icon
					usr<<"You put on the [src]."
					usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] equips [src]<br>")
					return
				else
					suffix=null
					usr.overlays-=icon
					usr<<"You take off the [src]."
					usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] removes [src]<br>")
					return

obj/items/Armor/Armor1
	icon='Armor1.dmi'

obj/items/Armor/Bardock_Armor
	icon='BardockArmor.dmi'

obj/items/Armor/Turles_Armor
	icon='TurlesArmor.dmi'

obj/items/Armor/Armor_Black
	icon='Nappa Armor.dmi'

obj/items/Armor/Armor2
	icon='Armor2.dmi'

obj/items/Armor/Armor3
	icon='Armor3.dmi'

obj/items/Armor/Armor4
	icon='Armor4.dmi'

obj/items/Armor/Armor5
	icon='Armor5.dmi'

obj/items/Armor/Armor6
	icon='Armor6.dmi'

obj/items/Armor/Armor7
	icon='Armor7.dmi'

obj/items/Armor/Armor8
	icon='White Male Armor.dmi'


obj/items/verb/Drop()
	var/Amount=0
	for(var/obj/A in get_step(usr,usr.dir)) if(!(locate(A) in usr)) Amount+=1
	if(Amount>4)
		usr<<"Nothing more can be placed on this spot."
		return
	if(suffix) if(!Can_Drop_With_Suffix)
		usr<<"You must unequip it first"
		return
	for(var/mob/player/A in view(usr))
		if(A.see_invisible>=usr.invisibility)
			A<<"[usr] drops [src]"
			A.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] drops [src].<br>")
	usr.overlays-=icon
	//loc=get_step(usr,usr.dir)
	loc=usr.loc
	step_to(src,usr.dir)
	dir=SOUTH

obj/Money
	icon='Misc.dmi'
	icon_state="ZenniBag"
	var/getkey
	var/getIP

	verb/Drop()
		var/Money=input("Drop how much Money?") as num
		if(Money>usr.Money) Money=usr.Money
		if(Money<=0) usr<<"You must atleast drop 1 Money."
		if(Money>=1)
			Money=round(Money)
			usr.Money-=Money
			var/obj/Money/A=new
			A.loc=usr.loc
			A.Money=Money
			A.name="[Commas(A.Money)] Money"
			A.getkey=usr.key
			A.getIP=usr.client.address
			step(A,usr.dir)
			view(usr)<<"<font size=1><font color=teal>[usr] drops [Commas(Money)] Money."
			for(var/mob/player/M in view(usr)) if(M.client) M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] drops [Commas(Money)] Money<br>")
			if(A.Money<100) A.icon_state="Zenni1"
			else if(A.Money<200) A.icon_state="Zenni2"
			else if(A.Money<500) A.icon_state="Zenni3"
			else if(A.Money<1000) A.icon_state="Zenni4"
			else
				A.icon_state="Zenni4"
				var/Size=round(A.Money/2000)
				var/Offset=10+round(A.Money/8000)
				if(Size>50) Size=50
				if(Offset>30) Offset=30
				while(Size&&src)
					Size-=1
					var/image/I=image(icon='Misc.dmi',icon_state="Zenni4",pixel_y=rand(-Offset,Offset),pixel_x=rand(-Offset,Offset))
					if(A) A.underlays.Add(I)
					sleep(1)
obj/items
	Scouter
		icon='Scouter.dmi'
		var/Scan=1
		var/Range=5
		var/Detects
		var/CanDetect
		var/Frequency=1
		Stealable=1
		desc="Equipping this will open a tab that allows you to see the battle power of all people \
		within the scouter's range and detection capabilities."
		Click() if(locate(src) in usr)
			if(!suffix)
				usr<<"You put on the [src]."
				usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] equips [src].<br>")
				usr.overlays+=icon
				suffix="*Equipped*"
			else
				usr<<"You take off the [src]."
				usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] removes [src].<br>")
				usr.overlays-=icon
				suffix=null
		verb
			Transmit(msg as text) for(var/mob/A in Players)
				for(var/obj/items/Scouter/B in A) if(B.suffix&&A.Dead==usr.Dead&&B.Frequency==Frequency)
					A<<"<font color=#FFFFFF>(Scouter)<font color=[usr.TextColor]>[usr] says, '[msg]'"
					A.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] SCOUTER: [msg]<br>")
				for(var/obj/items/Communicator/B in A) if(A.Dead==usr.Dead&&B.Frequency==Frequency)
					A<<"<font color=#FFFFFF>(Scouter)<font color=[usr.TextColor]>[usr] says, '[msg]'"
					A.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] SCOUTER: [msg]<br>")
			Frequency() Frequency=input("Choose a frequency, it can be anything. It lets you talk to \
			others on the same frequency. Default is 1") as text
			Detect()
				if(!CanDetect)
					usr<<"This feature is not installed. It can only be installed by a very intelligent person."
					return
				if(Detects) switch(input("Are you sure you want to reset detecting?") in list("No","Yes"))
					if("Yes") Detects=null
					if("No") return
				var/list/A=new
				for(var/obj/B in oview(1,usr)) A+=B
				if(!A)
					usr<<"You are not near an object to set the scanner to."
					return
				A+="Cancel"
				var/obj/B=input("Set to detect what type of object?") in A
				if(B=="Cancel") return
				Detects=B.type
				usr<<"Set to detect [B]"
				usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] sets their scouter to detect [B].<br>")
			/*Upgrade()
				set src in oview(1)
				var/obj/Resources/A
				for(var/obj/Resources/B in usr) A=B
				var/list/Choices=new
				if(A.Value>=1000*Tech/usr.Add) Choices.Add("Scan Limit ([1000*Tech/usr.Add])")
				if(A.Value>=1000*Tech/usr.Add&&Range<1000) Choices.Add("Scan Range ([1000*Tech/usr.Add])")
				if(A.Value>=100000/usr.Add&&!CanDetect&&usr.Int_Level>=25) Choices.Add("Item Detection ([100000/usr.Add])")
				if(!Choices)
					usr<<"You do not have enough resources"
					return
				var/Choice=input("Change what?") in Choices
				if(Choice=="Scan Limit ([1000*Tech/usr.Add])")
					if(A.Value<1000*Tech/usr.Add) return
					A.Value-=1000*Tech/usr.Add
					Scan+=1
				if(Choice=="Scan Range ([1000*Tech/usr.Add])")
					if(A.Value<1000*Tech/usr.Add) return
					A.Value-=1000*Tech/usr.Add
					Range*=2
				if(Choice=="Item Detection ([100000/usr.Add])")
					if(A.Value<100000/usr.Add) return
					A.Value-=100000/usr.Add
					CanDetect=1
				Tech+=1
				desc=null
				desc+="<br>Scan Limit: [Scan] ([Commas((Scan**3)*1000)] bp)"
				desc+="<br>Scan Range: [Range]"
				if(CanDetect) desc+="<br>Object Detection Installed"*/
			Upgrade()
				set src in oview(1)
				if(usr.Int_Level<Tech)
					usr<<"This is too advanced for you to mess with."
					return
				var/obj/Resources/A
				for(var/obj/Resources/B in usr) A=B
				var/Cost=20000/usr.Add
				var/Max_Upgrade=(A.Value/Cost)+Tech
				if(Max_Upgrade>usr.Int_Level) Max_Upgrade=usr.Int_Level
				var/Upgrade=input("Upgrade it to what level? (1-[round(Max_Upgrade)]). The maximum amount you can upgrade is determined by your intelligence (Max Upgrade cannot exceed Intelligence), and how much resources you have. So if the maximum is less than your intelligence then it is instead due to not having enough resources to upgrade it higher than the said maximum.") as num
				if(Upgrade>usr.Int_Level) Upgrade=usr.Int_Level
				if(Upgrade>Max_Upgrade) Upgrade=Max_Upgrade
				if(Upgrade<1) Upgrade=1
				Upgrade=round(Upgrade)
				if(Upgrade<Tech) switch(input("You wish to bring this Level [Tech] [src] to Level [Upgrade]?") in list("Yes","No"))
					if("No") return
				Cost*=Upgrade-Tech
				if(Cost<0) Cost=0
				if(Cost>A.Value)
					usr<<"You do not have enough resources to upgrade it to level [Upgrade]"
					return
				view(src)<<"[usr] upgrades the [src] to level [Upgrade]"
				for(var/mob/player/M in view(src)) if(M.client) M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades the [src] to level [Upgrade].<br>")
				for(var/mob/player/M in view(usr))
					if(!M.client) return
					M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] <br>")
				A.Value-=Cost
				Tech=Upgrade
				Scan=0.5*Upgrade*0.001*rand(990,1010)
				Range=5*Upgrade*0.01*rand(80,120)
				if(Upgrade>=60) CanDetect=1
				desc="Level [Tech] [src] ([Commas((Scan**3)*20)] BP)"
	Sword
		icon='Sword_Trunks.dmi'
		Health=1000
		Stealable=1
		New()
			desc="<br>+[Commas(Health)] BP to each melee attack. However this bonus cannot exceed \
		triple your own BP no matter how great the sword is. Swords are twice as easy to evade for your \
		Opp compared to melee attacks."
			//..()
		Click() if(locate(src) in usr)
			for(var/obj/items/Sword/A in usr) if(A!=src&&A.suffix)
				usr<<"You already have a sword equipped."
				return
			if(!suffix)
				suffix="*Equipped*"
				usr.overlays+=icon
				usr<<"You put on the [src]."
			else
				suffix=null
				usr.overlays-=icon
				usr<<"You take off the [src]."
		verb/Upgrade()
			set src in oview(1)
			var/obj/Resources/A
			for(var/obj/Resources/B in usr) A=B
			var/Amount=round(input("Add how much resources to this sword's attack power?") as num)
			if(Amount>A.Value) Amount=A.Value
			if(Amount<0) Amount=0
			A.Value-=Amount
			Amount*=usr.Add
			Health+=Amount
			view(usr)<<"[usr] adds [Commas(Amount)] to the [src]"
			for(var/mob/player/M in view(usr)) if(M.client) M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] adds [Commas(Amount)] to the [src]<br>")
			desc="<br>+[Commas(Health)] BP to each melee attack. However this bonus cannot exceed \
		triple your own BP no matter how great the sword is. Swords are twice as easy to evade for your \
		Opp compared to melee attacks."
		Knight_Sword icon='Sword 2.dmi'
		Demon_Sword icon='Sword 1.dmi'
		Katana icon='Item - Katana 2.dmi'
		Random_Sword icon='Item - Katana.dmi'
		Short_Sword icon='Short Sword.dmi'
		Rebellion icon='Item, Sword 1.dmi'
		Buster_Sword icon='Item, Buster Sword.dmi'
		Dual_Blaze icon='Item, Dual Blaze Sword.dmi'
		Dual_Electric icon='Item, Dual Electric Sword.dmi'
		Great_Sword icon='Item, Great Sword.dmi'
		Flame_Sword icon='Sword Flame.dmi'
		Double_Katana icon='Sword, 2 Katanas.dmi'
		Samurai icon='Sword, Samurai.dmi'
	Digging
		var/DigMult=1
		Shovel
			icon='Shovel.dmi'
			desc="This will help increase the speed at which you can dig up resources."
			DigMult=5
			Click() if(src in usr)
				for(var/obj/items/Digging/A in usr) if(A!=src&&A.suffix)
					usr<<"You already have one equipped."
					return
				if(!suffix) suffix="*Equipped*"
				else suffix=null
				usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] [suffix ? "Equips" : "Unqequips"] the [src]<br>")
		Hand_Drill
			icon='Drill Hand 2.dmi'
			desc="This will help increase the speed at which you can dig up resources."
			DigMult=25
			Click() if(src in usr)
				for(var/obj/items/Digging/A in usr) if(A!=src&&A.suffix)
					usr<<"You already have one equipped."
					return
				if(!suffix) suffix="*Equipped*"
				else suffix=null
				usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] [suffix ? "Unequips" : "Equips"] the [src]<br>")

mob/proc/Clothes_Equip(obj/A) if(A in usr)
	if(!A.suffix)
		A.suffix = "*Equipped*"
		overlays += A.icon
	else
		A.suffix = null
		overlays -= A.icon
	usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] [suffix ? "Unequips" : "Equips"] the [A]<br>")
mob/proc/Clothes_Proc(obj/A)
	if(A in Clothing)
		var/obj/B=new A.type
		var/RGB=input(src,"") as color|null
		if(!B) return
		if(RGB) B.icon+=RGB
		contents+=B
	else Clothes_Equip(A)
var/list/Clothing=new
obj/items/Clothes
	Savable=0
	Naraku
		icon='Clothes, Naraku.dmi'
		Click() usr.Clothes_Proc(src)
	Demon_Arm
		icon='Clothes, Demon Arm.dmi'
		Click() usr.Clothes_Proc(src)
	Azure_Armor
		icon='Armor, Azure.dmi'
		Click() usr.Clothes_Proc(src)
	Wolf_Hermit
		icon='Clothes, Wolf Hermit.dmi'
		Click() usr.Clothes_Proc(src)
	Wolf_Hood
		icon='Wolf Hood.dmi'
		Click() usr.Clothes_Proc(src)
	Wristband
		icon='Clothes_Wristband.dmi'
		Click() usr.Clothes_Proc(src)
	Angel_Wings
		icon='Angel Wings.dmi'
		Click() usr.Clothes_Proc(src)
	Red_Eyes
		icon='Red Eyes.dmi'
		Click() usr.Clothes_Proc(src)
	Yellow_Eyes
		icon='Yellow Eyes.dmi'
		Click() usr.Clothes_Proc(src)
	Black_Eyes
		icon='Eyes_Black.dmi'
		Click() usr.Clothes_Proc(src)
	Blue_Eyes
		icon='Eyes_Blue.dmi'
		Click() usr.Clothes_Proc(src)
	Brown_Eyes
		icon='Eyes_Brown.dmi'
		Click() usr.Clothes_Proc(src)
	Green_Eyes
		icon='Eyes_Green.dmi'
		Click() usr.Clothes_Proc(src)
	Orange_Eyes
		icon='Eyes_Orange.dmi'
		Click() usr.Clothes_Proc(src)
	Violet_Eyes
		icon='Eyes_Purple.dmi'
		Click() usr.Clothes_Proc(src)
	White_Eyes
		icon='Eyes_White.dmi'
		Click() usr.Clothes_Proc(src)
	Full_Yardrat
		icon='Clothes Full Yardrat.dmi'
		Click() usr.Clothes_Proc(src)
	Turban
		icon='Clothes_Turban.dmi'
		Click() usr.Clothes_Proc(src)
	TankTop
		icon='Clothes_TankTop.dmi'
		name="Tank Top"
		Click() usr.Clothes_Proc(src)
	ShortSleeveShirt
		icon='Clothes_ShortSleeveShirt.dmi'
		name="Shirt"
		Click() usr.Clothes_Proc(src)
	Loose_Fitting_Shirt
		icon='Cloths_Long_Shirt.dmi'
		Click() usr.Clothes_Proc(src)
	Shoes
		icon='Clothes_Shoes.dmi'
		Click() usr.Clothes_Proc(src)
	Goggles
		icon='Goggles.dmi'
		Click() usr.Clothes_Proc(src)
	TightJumpsuit
		icon='Tight Jumpsuit.dmi'
		Click() usr.Clothes_Proc(src)
	Jacket_2
		icon='Jacket 2.dmi'
		name="Jacket"
		Click() usr.Clothes_Proc(src)
	Hat
		icon='Hat.dmi'
		Click() usr.Clothes_Proc(src)
	Shoulder_Strap
		icon='Shoulder Strap.dmi'
		Click() usr.Clothes_Proc(src)
	Mask
		icon='Mask.dmi'
		Click() usr.Clothes_Proc(src)
	Sash
		icon='Clothes_Sash.dmi'
		Click() usr.Clothes_Proc(src)
	Kimono
		icon='Clothes, Kimono.dmi'
		Click() usr.Clothes_Proc(src)
	Pants
		icon='Clothes_Pants.dmi'
		Click() usr.Clothes_Proc(src)
	NamekianScarf
		icon='Clothes_NamekianScarf.dmi'
		Click() usr.Clothes_Proc(src)
		name="Scarf"
	LongSleeveShirt
		icon='Clothes_LongSleeveShirt.dmi'
		name="Long Shirt"
		Click() usr.Clothes_Proc(src)
	KaioSuit
		icon='Clothes_KaioSuit.dmi'
		name="Kaio Suit"
		Click() usr.Clothes_Proc(src)
	Jacket
		icon='Clothes_Jacket.dmi'
		Click() usr.Clothes_Proc(src)
	Headband
		icon='Clothes_Headband.dmi'
		Click() usr.Clothes_Proc(src)
	Gloves
		icon='Clothes_Gloves.dmi'
		Click() usr.Clothes_Proc(src)
	Boots
		icon='Clothes_Boots.dmi'
		Click() usr.Clothes_Proc(src)
	Bandana
		icon='Clothes_Bandana.dmi'
		Click() usr.Clothes_Proc(src)
	Belt
		icon='Clothes_Belt.dmi'
		Click() usr.Clothes_Proc(src)
	Cape
		icon='Clothes_Cape.dmi'
		Click() usr.Clothes_Proc(src)
	Kaio_Shirt
		icon='Clothes, Kaio Shirt.dmi'
		Click() usr.Clothes_Proc(src)
	Tsurusennin
		icon='Clothes, Tsurusennin.dmi'
		Click() usr.Clothes_Proc(src)
	Shorts
		icon='Clothes, Female Shorts.dmi'
		Click() usr.Clothes_Proc(src)
	Female_Shirt
		icon='Clothes, Female Shirt.dmi'
		name="Shirt"
		Click() usr.Clothes_Proc(src)
	Frontless_Cape
		icon='Clothes, Cape 2.dmi'
		Click() usr.Clothes_Proc(src)
	Female_Gi
		icon='Clothes, Gi Female.dmi'
		Click() usr.Clothes_Proc(src)
		name="Gi"
	Ninja_Mask
		icon='Clothes, Ninja Mask.dmi'
		Click() usr.Clothes_Proc(src)
	Ninja_Mask_2
		icon='Clothes, Ninja Mask 2.dmi'
		name="Ninja Mask"
		Click() usr.Clothes_Proc(src)
	Neko
		icon='Clothes, Neko.dmi'
		Click() usr.Clothes_Proc(src)
	Pimp_Hat
		icon='Clothes, Pimp Hat.dmi'
		Click() usr.Clothes_Proc(src)
	Assassin_Hoodless
		icon='Clothes, Assassin, Hoodless.dmi'
		Click() usr.Clothes_Proc(src)
/*	Wasteland_Style_Cloak
		icon='Hagard Cloak.dmi'
		Click() usr.Clothes_Proc(src)*/
	Assassin
		icon='Clothes, Assassin.dmi'
		Click() usr.Clothes_Proc(src)
	Power_Suit
		icon='Armor 8.dmi'
		Click() usr.Clothes_Proc(src)
	Daimaou_Cape
		icon='Clothes, Daimaou Cape.dmi'
		Click() usr.Clothes_Proc(src)
	Saiyan_Gloves
		icon='Clothes, Saiyan Gloves.dmi'
		Click() usr.Clothes_Proc(src)
	Horns
		icon='Clothes, Horns.dmi'
		Click() usr.Clothes_Proc(src)
	High_Boots
		icon='HighBoots.dmi'
		Click() usr.Clothes_Proc(src)
	Arm_Socks_Transparent
		icon='ArmSocksTransparent.dmi'
		Click() usr.Clothes_Proc(src)
	Arm_Socks_Solid
		icon='ArmSocks-Solid.dmi'
		Click() usr.Clothes_Proc(src)
	Book
		icon='Clothes, Book.dmi'
		Click() usr.Clothes_Proc(src)
	Saiyan_Shoes
		icon='Clothes, Saiyan Shoes.dmi'
		Click() usr.Clothes_Proc(src)
	Gi_Bottom
		icon='Clothes_GiBottom.dmi'
		Click() usr.Clothes_Proc(src)
	Gi_Top
		icon='Clothes_GiTop.dmi'
		Click() usr.Clothes_Proc(src)
	Kitsune
		icon='Kitsune.dmi'
		name="Neko? Maybe."
		Click() usr.Clothes_Proc(src)
	Tuxedo
		icon='Clothes Tuxedo.dmi'
		Click() usr.Clothes_Proc(src)
	Beard
		icon='Beard.dmi'
		Click() usr.Clothes_Proc(src)
	Sunglasses
		icon='Item - Sun Glassess.dmi'
		Click() usr.Clothes_Proc(src)
	Tien
		icon='Tien Clothes.dmi'
		Click() usr.Clothes_Proc(src)
	Kaio_Suit
		icon='Clothes Kaio Suit.dmi'
		Click() usr.Clothes_Proc(src)
	Namek_Jacket
		icon='Clothes Namek Jacket.dmi'
		Click() usr.Clothes_Proc(src)
	Guardian_Robe
		icon='Clothes Guardian.dmi'
		Click() usr.Clothes_Proc(src)
	Daimaou_Robe
		icon='Clothes Daimaou.dmi'
		Click() usr.Clothes_Proc(src)
	Undies
		icon='Clothes Diaper.dmi'
		Click() usr.Clothes_Proc(src)
	Tattoo1
		icon='Jecht.dmi'
		Click() usr.Clothes_Proc(src)
	Tattoo2
		icon='Red Tattoo.dmi'
		Click() usr.Clothes_Proc(src)
	Useless_Armor
		icon='Succubus Armor.dmi'
		Click() usr.Clothes_Proc(src)
	Bowler_Hat
		icon='Darkman Hat.dmi'
		Click() usr.Clothes_Proc(src)
	Large_Cloak_Changeling
		icon='Large Changeling Cloak.dmi'
		Click() usr.Clothes_Proc(src)
	Sentai_Helmet
		icon='Soldier Helmet.dmi'
		Click() usr.Clothes_Proc(src)
	Officers_Jacket
		icon='Super 17.dmi'
		Click() usr.Clothes_Proc(src)
	Tuffle_Uniform
		icon='TuffleTux.dmi'
		Click() usr.Clothes_Proc(src)
	Loose_Fitting_Coat
		icon='BaggyTrenchCoat.dmi'
		Click() usr.Clothes_Proc(src)
	Funny_Mask
		icon='Warrior of Time Mask.dmi'
		Click() usr.Clothes_Proc(src)
	Gas_Mask
		icon='EDFGas.dmi'
		Click() usr.Clothes_Proc(src)
	Face_Mask
		icon='EDFMask.dmi'
		Click() usr.Clothes_Proc(src)
	Mask_With_Visor
		icon='EDFVisor.dmi'
		Click() usr.Clothes_Proc(src)



obj/items/Senzu
	icon='Senzu.dmi'
	name="Senzu"
	desc="Eating this will temporarily and drastically increase your regeneration and recovery."
	var/Increase=4
	var/division=1
	Stealable=1
	New()
		pixel_x+=rand(-16,16)
		pixel_y+=rand(-16,16)
		//..()
	verb
		Eat()
			if(usr.icon_state!="KO")
				if(usr.Senzu<10) usr.Senzu+=Increase
				view(usr)<<"[usr] eats a [src]"
				for(var/mob/player/M in view(usr)) if(M.client) M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] eats a [src].<br>")
				del(src)
			else usr<<"You can't eat a Senzu while unconscious"
		Throw(mob/M in oview(usr))
			view(usr)<<"[usr] throws a Senzu to [M]"
			missile('Senzu.dmi',usr,M)
			sleep(3)
			view(usr)<<"[M] catches the Senzu"
			for(var/mob/player/K in view(usr)) if(K.client) K.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] catches the [src].<br>")
			Move(M)
		Use_on(mob/M in oview(1))
			if(M.icon_state=="KO")
				view(usr)<<"[usr] gives a [src] to [M]"
				for(var/mob/player/K in view(usr)) if(K.client) K.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] gives a [src] to [M]<br>")
				M.icon_state=""
				M.Un_KO()
				if(M.Senzu<10) M.Senzu+=Increase
				del(src)
			else usr<<"You can only use this on an unconscious person."
		Split()
			view(usr)<<"[usr] splits a [src] in half"
			for(var/mob/player/M in view(usr)) if(M.client) M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] splits a [src] in half.<br>")
			var/amount=2
			while(amount)
				var/obj/items/Senzu/A=new
				A.division=division*2
				A.Increase=Increase*0.5
				A.name="1/[A.division] Senzu"
				usr.contents+=A
				amount-=1
			del(src)
		Plant()
			loc=usr.loc
			view(src)<<"[usr] plants a [src] bean in the ground..."
			for(var/mob/player/M in view(usr)) if(M.client) M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] plants a [src] in the ground.<br>")
			Senzu_Grow()
obj/items/Senzu/proc/Senzu_Grow() while(z)
	sleep(100)
	if(Increase==initial(Increase))
		view(src)<<"The senzu is done growing"
		return
	if(src&&prob(1)&&z)
		var/blarg=name
		division*=0.5
		Increase*=2
		if(division>1) name="1/[division] Senzu"
		else
			icon='Senzu.dmi'
			name="Senzu"
		view(src)<<"The [blarg] grows into a [name]..."


obj/items/Gun
	Turret
		var/multitrack = 0 //Allows multiple targets.
		var/homing = 0 // Allows homing projectiles.
		var/lethal = 0 // Allows turret to KO or Kill.
		var/mob/target // For single-targeting.
		var/refire = 10 // Delay in ticks, between shots.
		Force = 500 // Damage Calculation purposes.
		var/activated = 0 // Allows turrets to be enabled or disabled.
		var/explosive = 0 // Allows explosive rounds.
		var/shockwave = 0 // Allows rounds with knockback.
		Damage_Percent = 20
		density=1
		Health=5000
		Deviation = 3
		Precision = 100000
		icon='Turret.dmi'
		New()
			..()
			Turret_AI()
obj/items/Gun/Turret
	verb
		Toggle_Power()
			set src in oview(1)
			for(var/obj/items/Door_Pass/O in usr.contents)
				if(O.Password == src.Password)
					if(src.activated)
						src.activated = 0
						usr << "Turret deactivated."
					else
						src.activated = 1
						usr << "WARNING: Turret activated."

		Set_Password()
			set src in oview(1)
			if(!src.Password)
				src.Password = input(usr,"Please specify the password for the turret.","Password") as text
				usr << "Password set."
			else
				for(var/obj/items/Door_Pass/O in usr.contents)
					if(O.Password == src.Password)
						src.Password = input(usr,"Please specify the password for the turret.","Password") as text
						usr << "Password changed."

	proc
		Turret_AI()
			set background = 1
			while(src)
				if(src.activated)
					var/tmp/list/friendlies = new
					for(var/mob/M in range(5+(src.Level/10),src))

						for(var/obj/items/Door_Pass/O in M.contents)
							if(O.Password == src.Password)
								if(!friendlies.Find(M))
									friendlies += M

						if(!friendlies.Find(M))
							src.dir = get_dir(src,M)
							if(src.multitrack)
								spawn()
									src.LockOn(M)
							else
								if(!src.target)
									src.target = M
									spawn()
										src.LockOn()
				sleep(10)


		LockOn(mob/M)
			if(src.activated)
				if(src.multitrack)
					spawn()
						while (M in range(5+(src.Level/10),src))
							if(lethal)
								if(homing)
									src.HS(M)
									sleep(refire)
								else
									src.SS(get_dir(src,M))
									sleep(refire)
							else
								if(M.icon_state != "KO")
									if(homing)
										src.HS(M)
										sleep(refire)
									else
										src.dir = get_dir(src,M)
										src.SS()
										sleep(refire)
				else
					if(src.target)
						spawn()
							while(src.target in range(5+(src.Level/10),src))
								if(lethal)
									if(homing)
										src.HS(src.target)
										sleep(refire)
									else
										src.SS(get_dir(src,src.target))
										sleep(refire)
								else
									if(M.icon_state != "KO")
										if(homing)
											src.HS(src.target)
											sleep(refire)
										else
											src.dir = get_dir(src,src.target)
											src.SS()
											sleep(refire)
									else
										src.target = null
							if(!src.target in range(5+(src.Level/10),src))
								src.target = null



		HS(mob/M)
			var/obj/Blast/A=new
			A.density=0
			A.Owner=src
			A.icon='1.dmi'
			A.loc=get_step(src,turn(src.dir,pick(NORTH,SOUTH,EAST,WEST,NORTHWEST,NORTHEAST,SOUTHWEST,SOUTHEAST)))
			if(src.explosive)
				A.Explosive=1
			if(src.shockwave)
				A.Shockwave=1
			var/Damage_Formula=0.1*Damage_Percent*Battle_Power*Force*(Tech**4)
			var/Power_Formula=0.1*Damage_Percent*Battle_Power*(Tech**4)
			A.Damage=Damage_Formula
			A.Power=Power_Formula
			A.Offense=src.Precision
			if(A) A.dir=pick(NORTH,SOUTH,EAST,WEST,NORTHEAST,NORTHWEST,SOUTHEAST,SOUTHWEST)
			spawn while(prob(90))
				if(prob(80)) if(A) step(A,A.dir)
				else step_rand(A)
			spawn(rand(90,110)/2) if(A)
				A.density=1
				if(M) walk_towards(A,M)
		SS()
			var/obj/Blast/A=new
			Owner=src
			A.pixel_x=rand(-Deviation,Deviation)
			A.pixel_y=rand(-Deviation,Deviation)
			A.icon='1.dmi'
			var/Damage_Formula=0.1*Damage_Percent*Battle_Power*Force*(Tech**4)
			var/Power_Formula=0.1*Damage_Percent*Battle_Power*(Tech**4)
			A.Damage=Damage_Formula
			A.Power=Power_Formula
			A.Offense=src.Precision
			A.Shockwave=src.explosive
			A.Explosive=src.shockwave
			A.dir=usr.dir
			A.loc=usr.loc
			walk(A,A.dir,Velocity)


obj/items/Gun/Turret
	New()
		..()
		Turret_AI()