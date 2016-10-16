obj/items/Bomb
	icon='Lab.dmi'
	icon_state="Panel1"
	density=1
	Stealable=1
	Flammable = 1
	desc="Upgrading force will increase the damage of whatever the explosion touches. Upgrading \
	range will increase the distance the explosion reaches. If you turn it into a missile, you will have to input \
	coordinates using the Set verb, then use the detonator on it to commence launching."
	var/Force=1
	var/Range=15
	//var/Speed=1
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
			Force++
		if(Choice=="Explosion Radius ([2000*Tech/usr.Add])")
			if(A.Value<2000*Tech/usr.Add) return
			A.Value-=2000*Tech/usr.Add
			Range++
		if(Choice=="Explosion Speed ([2000*Tech/usr.Add])")
			if(A.Value<2000*Tech/usr.Add) return
			A.Value-=2000*Tech/usr.Add
			Speed++
		if(Choice=="Convert to Missile ([10000/usr.Add])")
			if(A.Value<10000/usr.Add) return
			A.Value-=10000/usr.Add
			Missile=1
			usr<<"If you want the missile to go anywhere, you will need to reprogram it"
			icon='Missile.dmi'
		Tech++
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
			M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades the [src] to level [Upgrade].\n")

		A.Value-=Cost
		Tech=Upgrade
		desc="Level [Tech] [src]"
		Force=Upgrade*0.01*rand(90,110)
	//	Range=Upgrade
		//Speed=10
		if(Upgrade>10) switch(input("Do you want to convert it into a missile?") in list("Yes","No"))
			if("Yes")
				Missile=1
				icon='Missile.dmi'
	proc/Reset_Desc()
		desc=initial(desc)
		desc+="<br>Force: [Commas((Force**3)*500)] BP"
		desc+="<br>Radius: [Range]"
		//desc+="<br>Explosion Speed: [Speed]"
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
					if(B.Health<=0||istype(B,/obj/Props/Edges)) del(B)
				for(var/mob/B in A)
					B.Health-=(Damage*100)/(B.Base*B.Body*B.Res)
					if(B.Health<=0) B.Death()
				if(A.Health<=0)
					if(usr!=0) A.Destroy(usr,usr.key)
					else A.Destroy("Unknown","Unknown")
				A.Self_Destruct_Lightning(100)
				//if(prob(100/(Speed**2))) sleep(1)
			spawn(10)
			del(src)
	verb/Set()
		set src in oview(1,usr)
		if(Bolted)
			usr<<"It is already armed, you cannot reprogram it"
			return
		view(src)<<"[usr] has begun to program the bomb."
		for(var/mob/player/M in view(src))
			if(!M.client) return
			M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has begun to program the bomb.\n")
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
				M.saveToLog("| [M.client.address ? (M.client.address) : "IP not found"] | ([M.x], [M.y], [M.z]) | [src]: Detonation in [Timer] minutes.\n")

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
			M.saveToLog("| [M.client.address ? (M.client.address) : "IP not found"] | ([M.x], [M.y], [M.z]) | [src] detonates.\n")
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
			M.saveToLog("| [M.client.address ? (M.client.address) : "IP not found"] | ([M.x], [M.y], [M.z]) | [src]: Proximity Detonation activation in 1 minute.\n")
		Bolted=1
		sleep(600)
		while(src)
			for(var/mob/A in view(5,src)) if(A.client)
				view(src)<<"[src]: Proximity Breach. Detonation Commencing in 5 seconds..."
				spawn(50) if(src) Detonate()
				for(var/mob/player/M in view(src))
					if(!M.client) return
					M.saveToLog("| [M.client.address ? (M.client.address) : "IP not found"] | ([M.x], [M.y], [M.z]) | [src] detonates.\n")
				return
			sleep(100)
	proc/Remote_Detonation()
		Bolted=1
		for(var/mob/player/M in view(src))
			if(!M.client) return
			M.saveToLog("| [M.client.address ? (M.client.address) : "IP not found"] | ([M.x], [M.y], [M.z]) | [src] detonates.\n")
		Detonate()
		return