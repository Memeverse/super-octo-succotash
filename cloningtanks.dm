var/list/glob_ClonTanks


obj/items/Cloning_Tank
// BYOND works by way of inheritence. Because I've defined New() for Cloning_Tank and
// all other cloning tanks fall under this one, they'll trigger the New() here, which works
// excellently because the variables defined here, and the calls required are the same for
// reach cloning tank.
// Only when something differs will you have to adjust them within that specific cloning tanks.
	icon = 'New cloning tank.dmi'
	layer=4
	density=1
	Bolted=1
	Stealable=1
	Savable = 1
	var/dura_take = 100
	var/dura = 100
	var/reviveTime
	var/show_name
	var/nerfMult=0.6 // Default value, just in case.
	var/mob/player/playerRevival // The player being revived
	New()
		..()
		src.pixel_x -= 32
		src.pixel_y -= 16
		//var/image/A=image(icon='Lab.dmi',icon_state="Tube2",layer=layer+1,pixel_y=-12,pixel_x=0)
		//var/image/B=image(icon='Lab.dmi',icon_state="Tube2Top",layer=layer+1,pixel_y=20,pixel_x=0)
		//var/image/C=image(icon='Lab.dmi',icon_state="Lab2",layer=layer,pixel_y=0,pixel_x=28)
		//overlays.Add(A,B,C)
		if(!glob_ClonTanks) glob_ClonTanks=new // If the list hasn't been created yet, create a new one.
		//if(z!=0)
		glob_ClonTanks+=src // glob_ClonTanks is the global list which is looked through
							// upon a players death, to see if they should be revived.
	Del()

		if(glob_ClonTanks)
			src.Password=null
			glob_ClonTanks-=src // And when a cloning tank is destroyed, we want it to be removed from the list
			if(!glob_ClonTanks|!glob_ClonTanks.len) glob_ClonTanks=null // If the list is empty, let the garbage handler delete the list.

		if(playerRevival)
			playerRevival.Death("the destruction of their cloning tank") // If there's a player in there, kill them.
			//playerRevival.insideTank=null // FIRST erase the tank they should be revived at and THEN trigger death, incase they have another tank.

		..() // and then continue on with the default behavior, like removing the actual object and creating a crater and such.

proc/Has_Tank(var/mob/player/P)
	checkNullTanks()
	for(var/obj/items/Cloning_Tank/tank in glob_ClonTanks)
		if(tank.Password=="[P.real_name] ([P.key])"&&P.Dead)
			return tank
			break

proc/checkNullTanks()
	for(var/obj/items/Cloning_Tank/tank in glob_ClonTanks)
		if(tank.z==0) // sanity check procedure. This should never happen though.
			tank.Password=null
			glob_ClonTanks-=tank
			del tank

proc/Clone_Detection(var/mob/player/P)

	var/obj/items/Cloning_Tank/chosentank = Has_Tank(P)

	if(chosentank)
		var/olddecline=P.Decline
		P.loc=chosentank.loc
		P.Decline*=chosentank.nerfMult
		P.saveToLog("| [P.client.address ? (P.client.address) : "IP not found"] | ([P.x], [P.y], [P.z]) | [key_name(usr)] has been revived by their [chosentank] cloning tank.\n")
		P.saveToLog("| [P.client.address ? (P.client.address) : "IP not found"] | ([P.x], [P.y], [P.z]) | [key_name(usr)]'s decline has been nerfed from [olddecline] to [P.Decline] by their [chosentank] cloning tank.\n")

	if(chosentank) Clone_Awaken(P,chosentank)

proc/Clone_Awaken(var/mob/player/P,var/obj/items/Cloning_Tank/chosentank)

	P << "<span class=announce>SYSTEM: Death of registrant detected. Activating new body... This process will take [chosentank.reviveTime/600] minutes.</span>"
	//P.y=chosentank.y+1 // Move em one square  up so it looks like they're inside the tank, using the tank as reference so they dont move up each relog.
	chosentank.playerRevival=P
	chosentank.underlays = null
	P.insideTank=chosentank
	P.forbidMovement=1 // Dont want them to move until the tank is 'done'
	if(P.icon_state == "KO") P.Un_KO(1) // They need to be up.
	P.overlays-='Halo Custom.dmi'
	P.Dead=0
	P.dir=SOUTH
	P.Health = 100
	P.Ki = P.MaxKi
	sleep(chosentank.reviveTime)
	if(!P||!chosentank){return}
	chosentank.playerRevival = null // make sure that they dont get killed once the tank gets blown up and they're already out.
	P << "<span class=announce>SYSTEM: Clone awakened. Welcome back [P.name].</span>"
	P.insideTank=null
	step(P,SOUTH)
	P.forbidMovement=0
	chosentank.dura -= chosentank.dura_take
	chosentank.icon_state = "ez"
	chosentank.Password = null
	P.Heart_Virus_Cure()
	var/L = list("Head","Left Arm","Right Arm","Right Leg","Left Leg","Torso","Throat","Hearing","Mating Ability")
	P.Injure_Hurt(100,L)
	P << "<font color = red>You feel very weak from cloning sickness."

obj/items/Cloning_Tank/Modernized

	nerfMult=0.8
	reviveTime=3000 // 5 minutes.
	desc="This will revive you each time you are killed. \
	This is the most efficient model of cloner, \
	taking the least amount of decline per death and requiring the least amount of time to activate your body.  \
	Each time you are cloned and the cloner is activated, you lose decline."

	Click()
		usr<<"This machine is set to clone [show_name]"
	verb/Repair()
		set src in oview(1)
		if(src.dura <= 0)
			for(var/obj/Resources/R in usr)
				if(R.Value >= src.cost/2)
					R.Value -= src.cost/2
					usr << "You repair the cloning machine, it cost you [Commas(src.cost/2)]."
					src.dura = 100
					src.icon_state = ""
					return
	verb/Set()
		set src in oview(1)
		if(usr.Dead)
			usr<<"Dead people cannot use this"
			return
		if(src.dura <= 0)
			usr << "This cloning tank needs to be repaired first."
			return
		usr<<"[src] has been set to clone [usr] if they die."
		src.underlays = null
		var/image/A=new(usr.icon)
		A.pixel_x = 32
		A.pixel_y = 16
		if(usr.hair)
			var/image/H=new(usr.hair)
			H.pixel_x = 32
			H.pixel_y = 16
			src.underlays += H
		src.underlays += A
		usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has set [src] to clone themselves.\n")
		Password="[usr.real_name] ([usr.key])"
		show_name="[usr.name]"

/*

OLD

*/

/*obj/items/Cloning_Tank
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
		for(var/mob/player/A in Players) if(Password=="[A.name] ([A.key])"&&A.Dead)
			view(A)<<"[A] has been revived by their [src]"
			usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has been revived by their [src].\n")
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
		usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has set [src] to clone themselves.\n")
		Password="[usr.name] ([usr.key])"*/