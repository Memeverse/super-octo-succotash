
mob/proc/Gravity()
	while(src)
	//	ASSERT(src)  Shouldn't be necessary anymore.  Re-enable if needed.
		Gravity=1
		var/turf/A=loc
		if(A&&isturf(A))
			if(A.Gravity)
				Gravity=A.Gravity
			PlanetGravity()
		sleep(20)
mob/proc/PlanetGravity()
	if(z==1&&Gravity<1) Gravity=1
	else if(z==3&&Gravity<2) Gravity=2
	else if(z==4&&Gravity<5) Gravity=5
	else if(z==5&&y>422&&Gravity<10) Gravity=10
	else if(z==6&&Gravity<10) Gravity=10
	else if(z==7&&Gravity<1) Gravity=1
	else if(z==8&&Gravity<2) Gravity=2
	else if(z==12&&Gravity<10) Gravity=10
	if(src.Race == "Alien") if(src.Alien_Grav_Set == 0) if(src.z != 9)
		src.Alien_Grav_Set = src.Gravity
		src.GravMastered = Gravity
mob/proc/Gravity_Gain()
	if(ghostDens_check(src)) return
	var/DMG = 3*((((Gravity*2)/GravMastered)-2)**2)
	Health-=DMG
	var/L = list("Random")
	if(DMG > 0)
		src.Injure_Hurt(DMG/5,L)
	GravMastered+=0.001*Gravity*GravMod       //Enable this to turn on gravity mastery gains when standing in gravity.
	if(Gravity>10&&Health<=-120) if(DMG > 0) src.Injure_Hurt(DMG/2.5,L)
obj/var/Grav_Setting = 0
obj/items/Gravity
	Move()
		..()
		Deactivate()
	Del()
		Deactivate()
		..()
	layer=MOB_LAYER+5
	Stealable=1
	density=1
	desc="Place this anywhere on the ground to use it, it will affect anything within its radius."
	var/Max=1
	var/Range=1
	icon='Scan Machine.dmi'

	proc/Deactivate()
		var/image/I=image(icon='Gravity Field.dmi',layer=MOB_LAYER+5)
		for(var/turf/G in view(Range,src))
			G.overlays.Remove(I,'Gravity Field.dmi',I)
			G.Gravity-=src.Grav_Setting

	Click() if(usr in range(1,src))
		var/Grav=input("You can set the gravity multiplier by using this panel. Be aware that the level of gravity affects everyone in the room. Maxgrav is [Max*10]x") as num
		if(Grav>Max*10) Grav=Max*10
		if(Grav<0) Grav=0
		if(!Grav)
			view(src)<<"<center>[usr] sets the Gravity multiplier set to normal."
			usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] sets the gravity to normal. \n")
		else
			view(src)<<"<center>[usr] sets the Gravity multiplier set to [Grav]x"
			usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] sets the gravity to [Grav]x \n")
		var/image/I=image(icon='Gravity Field.dmi',layer=MOB_LAYER+5)
		src.Grav_Setting = Grav
		for(var/turf/G in view(Range,src))
			G.overlays.Remove(I,'Gravity Field.dmi',I)
			if(Grav>1) G.overlays+=I
			G.Gravity=Grav

	verb/Bolt()
		set src in oview(1)
		if(x&&y&&z&&!Bolted)
			Bolted=1
			range(20,src)<<"[usr] bolts the [src] to the ground."
			for(var/mob/player/M in view(src)) if(M.client) M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] bolts [src] to the ground.\n")
			return
		if(Bolted) if(src.Builder == "[key_name(usr)], [usr.client.address]")
			range(20,src)<<"[usr] un-bolts the [src] from the ground."
			Bolted=0
			for(var/mob/player/M in view(src)) if(M.client) M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] un-bolts [src] from the ground.\n")
			return

/*
	verb/Upgrade()
		set src in oview(1)
		if(usr.Int_Level<Tech)
			usr<<"This is too advanced for you to mess with."
			return
		var/obj/Resources/A
		for(var/obj/Resources/B in usr) A=B
		var/Cost=40000/usr.Add
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
		usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades the [src] to level [Upgrade].\n")
		A.Value-=Cost
		Tech=Upgrade
		desc="Level [Tech] [src]"
		Range=rand(1,5)
		Max=Upgrade*0.01*rand(80,120)
		*/

	verb/Upgrade()
		set src in oview(1)
		var/obj/Resources/A
		for(var/obj/Resources/B in usr) A=B
		var/list/Choices=new

		if(Max<1000) if(A.Value>=1000*Tech/usr.Add) Choices.Add("Field Limit ([round((50000+(1.1*Max))*(Tech/usr.Add))])")
		if(Range<10) if(A.Value>=1000*Tech/usr.Add) Choices.Add("Field Range ([round((50000+(0.6*Range))*(Tech/usr.Add))])")

		if(!Choices)
			usr<<"You have reached the limit of this machine or do not have enough resources."
			return

		var/Choice=input("Change what?") in Choices

		if(Choice=="Field Limit ([round((50000+(1.1*Max))*(Tech/usr.Add))])")
			//var/Upgrade=input("Upgrade it to what level? ([round((4000+(1.1*Max))*(Tech/usr.Add))] per level)") as num
			var/Cost=round((50000+(1.1*Max))*(Tech/usr.Add))
			//if(!Upgrade|Upgrade<1|Upgrade>1000) return
			if(A.Value<Cost){usr << "You do not have enough resources.";return}

			A.Value-=Cost //*Upgrade
			Max++ //Upgrade
			usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades the [src] to Field Limit level [Max].\n")

		if(Choice=="Field Range ([round((50000+(0.6*Range))*(Tech/usr.Add))])")
			//var/Upgrade=input("Upgrade it to what level? ([round((4000+(0.6*Range))*(Tech/usr.Add))]) per level") as num
			var/Cost=round((50000+(0.6*Range))*(Tech/usr.Add))
			//if(!Upgrade|Upgrade<1|Upgrade>10) return
			if(A.Value<Cost){usr << "You do not have enough resources.";return}

			A.Value-=Cost //*Upgrade
			Range++ //Upgrade
			usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades the [src] to Field Range [Range].\n")

		Tech++
		desc=null

		if(Max==1000) desc+="<br>Field Max: [Max] ([Max*10]x) <font color=red>MAXED</font>"
		else desc+="<br>Field Max: [Max] ([Max*10]x)"
		if(Range==10) desc+="<br>Field Range: [Range] <font color=red>MAXED</font>"
		else desc+="<br>Field Range: [Range]"
