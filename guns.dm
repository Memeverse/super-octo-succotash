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
		usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] is reloading their weapon.\n")
		spawn(50) if(src&&A&&usr)
			Reloading=0
			view(usr)<<"[usr] is done reloading their weapon"
			usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] is done reloading their weapon.\n")
			var/Needed_Amount=A.Max_Ammo-A.Ammo
			if(Needed_Amount>Ammo) Needed_Amount=Ammo
			A.Ammo+=Needed_Amount
			Ammo-=Needed_Amount
			A.suffix="[Commas(A.Ammo)]"
			suffix="[Commas(Ammo)]"
			if(Ammo<=0) del(src)


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
	var/Battle_Power=0.0025
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
		usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrads the [src] to level [Upgrade].\n")
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
		var/obj/ranged/Blast/A=new
		A.Bullet=Bullet
		A.Belongs_To=usr
		A.pixel_x=rand(-Deviation,Deviation)
		A.pixel_y=rand(-Deviation,Deviation)
		A.icon=Bullet_Icon
		var/Damage_Formula=0.1*Damage_Percent*Battle_Power*Force*(Tech**3.5)
		var/Power_Formula=0.1*Damage_Percent*Battle_Power*(Tech**3.5)
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
			var/obj/ranged/Blast/B=new
			B.Bullet=Bullet
			B.Belongs_To=usr
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
			var/obj/ranged/Blast/C=new
			C.Bullet=Bullet
			C.Belongs_To=usr
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
		Damage: [Commas(Battle_Power*Damage_Percent*(Tech**3.5))]<br>\
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
		Damage_Percent=15
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
		Damage_Percent=2.5
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
		Damage_Percent=2.5
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
		Damage_Percent=10
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
		Damage_Percent=2
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
		Damage_Percent=3
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
		Damage_Percent=30
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
		Damage_Percent=2
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