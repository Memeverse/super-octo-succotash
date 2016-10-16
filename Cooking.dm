
mob/proc/Temperature_Check()
	for(var/area/A in range(0,src))

		if(A.Temperature<1)
			if( !(locate(/obj/Props/Heatsources) in range(2,src)) )
				for(var/obj/items/Power_Armor/PA in usr)
					return
				if(usr.Race=="Changeling") //put this into a new proc that runs on execution of temp check.  Will deal with it stopping.
					return
				Temperature="Freezing"
				var/Damage=(1-A.Temperature)*10/EndMod
				if(icon_state!="KO") Health-=Damage
				else
					Life-=Damage*0.5
					if(Life<=0) Death("freezing weather")
			else Temperature=null
		else Temperature=null
obj/proc/Fire_Cook(Timer) while(src)
	sleep(Timer)
	if(src) for(var/mob/Cookable/A in range(1,src)) if(!A.Cooked)
		view(A)<<"[A] is cooked by the [src]"
		A.Level*=10
		A.icon='Food Leg.dmi'
		A.overlays=null
		A.Cooked=1
mob/Cookable
	var/Cooked
	Savable = 1
	Level=0.2 //How much it boosts your healing if you eat this.
	Del()
		if(!Cooked) Body_Parts()
		..()
	verb/Eat()
		set src in oview(1,usr)
		if(usr.Senzu>=2)
			usr<<"You are too full to eat"
			return
		view(usr)<<"[usr] eats the [src]"
		usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] | [key_name(usr)] eats [src].\n")
		if(!Level)
			view(usr)<<"[usr] becomes poisoned"
			usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has become poisoned.\n")
			usr.Poisoned++
		else
			usr.Senzu+=Level
			if(usr.Senzu>2)
				usr.Senzu=2
				usr<<"You are now full"
		Cooked=1
		del(src)
	New()
		spawn(10) if(src)
			for(var/area/A in range(0,src))
				if(A.Temperature<1)
					var/icon/B=new(icon)
					B.MapColors("#00ffff","#ffffff","#000000")
					icon=B
		spawn(6000) if(src)
			overlays+='Flies.dmi'
			Level=0
		//..()