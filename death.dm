mob/proc/immortality(var/time=2)
// This proc disables death check for the relevant mob.
// time - time in seconds (is multiplied by 10 because spawn measures time in 1/10 of a second)

	immortal = 1
	spawn(time*10) immortal = 0

mob/var/tmp/DeadCap = 0 //Puts a cap/stopper on the Death() proc to avoid spamm killing that results from some ki attacks.
mob/var/Sense_Alignment = 0
mob/proc/Alignments(var/mob/Z)
	if(Z.Alignment < 0)
		src.Alignment += 1
	if(Z.Alignment > 0)
		src.Alignment -= 1
	if(Z.Alignment == 0)
		src.Alignment -= 1
	if(src.Alignment >= 5)
		src.Alignment = 5
	if(src.Alignment <= -5)
		src.Alignment = -5

	if(src.Alignment == 5)
		src.AlignmentTxt = "Pure of Heart"
	if(src.Alignment == 4)
		src.AlignmentTxt = "Saintly"
	if(src.Alignment == 3)
		src.AlignmentTxt = "Heroic"
	if(src.Alignment == 2)
		src.AlignmentTxt = "Virtuous"
	if(src.Alignment == 1)
		src.AlignmentTxt = "Good"
	if(src.Alignment == 0)
		src.AlignmentTxt = "Neutral"
	if(src.Alignment == -1)
		src.AlignmentTxt = "Bad"
	if(src.Alignment == -2)
		src.AlignmentTxt = "Corrupt"
	if(src.Alignment == -3)
		src.AlignmentTxt = "Villainous"
	if(src.Alignment == -4)
		src.AlignmentTxt = "Demonic"
	if(src.Alignment == -5)
		src.AlignmentTxt = "Pure Evil"

/*
	if(src.Alignment == "Good" && Z.Alignment == "Evil")
		src.Alignment = "Very Good"
	if(src.Alignment == "Good" && Z.Alignment == "Good")
		src.Alignment = "Evil"
	if(src.Alignment == "Very Good" && Z.Alignment == "Very Good")
		src.Alignment = "Evil"
	if(src.Alignment == "Very Good" && Z.Alignment == "Good")
		src.Alignment = "Evil"

	if(src.Alignment == "Evil" && Z.Alignment == "Good")
		src.Alignment = "Very Evil"
	if(src.Alignment == "Evil" && Z.Alignment == "Evil")
		src.Alignment = "Good"
	if(src.Alignment == "Very Evil" && Z.Alignment == "Very Evil")
		src.Alignment = "Good"
	if(src.Alignment == "Very Evil" && Z.Alignment == "Evil")
		src.Alignment = "Good"

	if(src.Alignment == "Neutral" && Z.Alignment == "Good")
		src.Alignment = "Evil"
	if(src.Alignment == "Neutral" && Z.Alignment == "Very Good")
		src.Alignment = "Evil"
	if(src.Alignment == "Neutral" && Z.Alignment == "Evil")
		src.Alignment = "Good"
	if(src.Alignment == "Neutral" && Z.Alignment == "Very Evil")
		src.Alignment = "Good"
*/
mob/proc/Death(var/Z)
	//ASSERT(Z)  test assert

	if(src.immortal) return // if they're temporary disabled from death, then do nothing.
	if(src.DeadCap) return //Same as above, only this is a tmp var instead, which is not saved and requires no further tweaks or changes elsewhere to function.
	src.DeadCap = 1 //Part of the anti death spam code.
	spawn(100) if(src) src.DeadCap = 0 //Part of the anti death spam code.
	Alien_Revert()

	if(istype(src,/mob/observer))
		return
	if(z==15) return //Final Realm
	if(istype(Z,/mob/Cookable)){del(src);return}
	//if(findtext(Z.name,"body of")==1){del(src);return}

	if(S) loc=S.loc

	view(src)<<"[src] was just killed by [Z]!"
	if(ismob(Z))
		var/mob/M = Z
		if(M != src) if(src.client)
			M.Kills += 1
	forbidMovement=0 // If they were being revived at the time, then they should be allowed to move.
	for(var/mob/player/M in view(src)) if(M.client) M.saveToLog(" | ([src.x], [src.y], [src.z]) | [key_name(src)] was just killed by [Z].\n")
	Poisoned=0

	if(istype(src,/NPC_AI)&&src.&&!sim)
		Leave_Body()
		del(src)
		return

	if(world.maxz==100)
		loc=locate(rand(1,world.maxx),rand(1,world.maxy),1)
		return

	if(client)
		if(ismob(Z))
			var/mob/M = Z
			M.Alignments(src)
			alertAdmins(" | ([src.x], [src.y], [src.z]) | [key_name(src)] was just killed by [key_name(M)].\n")
			alertAdmins(" | [M] has killed [M.Kills] total.\n")
		else
			alertAdmins(" | ([src.x], [src.y], [src.z]) | [key_name(src)] was just killed by [Z].\n")
		resetChargelvl(src)

		src.Frozen=0
		src.overlays-='TimeFreeze.dmi'

		if(ismob(Z))
			var/mob/X = Z
			if(X.lastKnownIP)
				for(var/mob/player/M in view(src)) if(M.client) M.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(src)] was just killed by [key_name(X)] ([X.lastKnownIP])\n")
				X.saveToLog("[key_name(X)] ([X.x], [X.y], [X.z]) [X] just killed [key_name(src)] ([src.lastKnownIP])\n")
		else
			for(var/mob/player/M in view(src)) if(M.client) M.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(src)] was just killed by [Z]!\n")

	if(GrabbedMob)
		if(src.isGrabbing==1&&src.GrabbedMob)  // somebody added a retarded check that checks if it's both 0 and 1 at the same time. that dun work yo
			view(src)<<"[src] is forced to release [GrabbedMob]!"
			for(var/mob/player/M in view(src)) if(M.client) M.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(src)] is forced to release [GrabbedMob]!\n")
			if(ismob(GrabbedMob)) GrabbedMob.attacking=0
			attacking=0
			GrabbedMob=null

	for(var/mob/A) if(A.GrabbedMob==src&&A.isGrabbing==1)
		A.GrabbedMob.attacking=0
		A.attacking=0
		A.isGrabbing=null

	if(client||Logged_Out_Body)
		for(var/obj/items/Power_Armor/A in src)
			src.Eject(A)
		Absorb=0
		for(var/obj/A in contents)
			if(A.Stealable)
				if(A.suffix)
					src.Equip_Magic(A,"Remove")
				A.suffix=null
				overlays-=A.icon
				A.loc=loc
			if(istype(A,/obj/Resources))
				var/obj/Resources/R=A
				if(R.Value)
					var/obj/Resources/S=new(loc)
					S.Value=R.Value
					R.Value=0
					S.name="[Commas(S.Value)] Resources"
			if(istype(A,/obj/Mana))
				var/obj/Mana/R=A
				if(R.Value)
					var/obj/Mana/S=new(loc)
					S.Value=R.Value
					R.Value=0
					S.name="[Commas(S.Value)] Mana"
		if(Regenerate&&!Dead&&!Regenerating&&!Absorbed) // This deals with natural regeneration after death.
			spawn Un_KO()
			src<<"You will regenerate in [2/Regenerate] minutes"
			src.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(src)] will regenerate in [2/Regenerate] minutes.\n")
			Regenerating=1
			savedX=x
			savedY=y
			savedZ=z
			Leave_Body()
			Regenerate()
			return

		if(Dead)// If they were already dead
			view(src)<<"[src] has been sent to the Final Realms"
			for(var/mob/player/M in view(src)) if(M.client) M.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(src)] has been sent to the Final Realms.\n")
			loc=locate(250,250,15)
			Save()
			if(Reincarnation_Status == "On")
				src.NewGameReincarnation()
			return

		if(!Dead)
			Roid_Power=0
			Death_Zenkai()
			Died = Year
			for(var/obj/items/Adamantine_Skeleton/S in src)
				Limb_Res -= 100
				EndMod/=1.1
				End/=1.1
				break
			var/L = list("All")
			src.Injure_Heal(100,L)
			//Friend getting killed major anger boost
			for(var/mob/A in view(src)) for(var/obj/Contact/C in A)
				if(C.Signature == A.Signature) if(C.relation in list("Very Good"))
					A.Anger+=(A.MaxAnger-100)*2
					A.ssjanger = 1
					view(A)<<"<font color=red>[A] has become insane with rage from the death of [src]!!!"
					for(var/mob/player/M in view(A)) if(M.client) M.saveToLog("| [A.client.address ? (A.client.address) : "IP not found"] | ([A.x], [A.y], [A.z]) | [key_name(A)] has become insane with rage from the death of [src]!\n")
					break
			if(ismob(Z)) for(var/mob/A in view(src)) if(A!=Z&&A.client&&A.icon_state!="KO")
				view(20,A)<<"<font color=red>[A] has become enraged from the death of [src]!!!"
				for(var/mob/player/M in view(20,A)) if(M.client) M.saveToLog("| [A.client.address ? (A.client.address) : "IP not found"] | ([A.x], [A.y], [A.z]) | [key_name(A)] has become enraged with the death of [src]!\n")

				A.Anger+=(A.MaxAnger-100)*2
				if(prob(50)) break
			Leave_Body()
			Heart_Virus_Cure()




		if(!Dead&&Race!="Cosmic Entity")
			overlays+='Halo Custom.dmi'
			Dead=1
			Artificial_Power=0
			if(Cyber_Absorb)
				Cyber_Absorb=0
				for(var/obj/Absorb/A in src) del(A)
			if(Blast_Absorb) Blast_Absorb=0

		if(Race=="Android")
			if(prob(25))
				loc=locate(321,419,14)
				Dead=0
				overlays-='Halo Custom.dmi'
				src<<"The Android Ship has deemed you useful enough to be rebuilt!"
				var/L = list("All")
				src.Injure_Heal(100,L)
				src.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(src)] has been rebuilt by the Android Ship!\n")
				Save()
				return

		if(Has_Tank(src)&&!Regenerating) // See if they have a cloning tank and they're NOT regenerating.
			loc = locate(/area/Limbo) // Send them to the Limbo area to wait for 2.5 seconds
			spawn(25)
				Clone_Detection(src) // Trigger a check for cloning machines related to this player.
				var/L = list("All")
				src.Injure_Heal(100,L)
		else if(Has_Phylactery(src)&&!Regenerating) // See if they have a cloning tank and they're NOT regenerating.
			loc = locate(/area/Limbo) // Send them to the Limbo area to wait for 2.5 seconds
			spawn(25)
				Phylactery_Detection(src) // Trigger a check for cloning machines related to this player.
				var/L = list("All")
				src.Injure_Heal(100,L)
		else // they weren't already dead
			loc=locate(rand(163,173),rand(183,193),5) // Send them to the checkpoint
			src.last_icon = src.icon
			if(!src.KeepsBody)
				var/icon/I=new(src.icon)
				I.Blend(rgb(0,0,0,100),ICON_ADD)
				src.icon=I
			WishPower=0
			Phylactery = 0
			Save()
			if(Reincarnation_Status == "On")
				src.NewGameReincarnation()
			return
			//src.NewGameReincarnation()
			/*if(ReincCall==0)
				ReincCall=1
				switch (input(src,"Would you like to continue on to the afterlife, or reincarnate to a new character?") in list("Continue to the Afterlife","Reincarnate to a New Character"))
					if("Reincarnate to a New Character")
						ReincCall=0
						Z.Reincarnation()
					else
						ReincCall=0*/

	else del(src)

mob/proc/Leave_Body()
	var/mob/Cookable/A=new
	for(var/obj/Stun_Chip/S in src) A.contents+=S
	A.Frozen=1 //Like being knocked out for NPCs, so it doesnt get knocked out again
	A.BP=BP
	A.Base=Base
	A.Body=Body
	A.MaxKi=MaxKi
	A.Str=Str
	A.End=End
	A.Spd=Spd
	A.Res=Res
	A.Pow=Pow
	A.Off=Off
	A.Def=Def
	A.Regeneration=Regeneration
	A.Recovery=Recovery
	A.Life=1000
	A.icon=icon
	if(client) A.icon_state="KO"
	A.overlays+=overlays
	A.overlays+='Zombie.dmi'
	A.loc=loc
	A.name="Body of [src]"
	//A.lastKnownKey = name	//i wonder if this is really needed

mob/proc/Revive()
	Dead=0
	overlays-='Halo Custom.dmi'
	src.icon = src.last_icon