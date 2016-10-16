obj/Attacks/Ray
	Wave=1
	Difficulty=10
	icon='Beam8.dmi'
	KiReq=1
	WaveMult=1
	ChargeRate=0.5
	MaxDistance=20 //Move delay x40
	MoveDelay=1
	Piercer=0
	luminosity=2
	New()
		BeamDescription()
		..()	//Beams are bright
	verb/Ray()
		set category="Skills"
		if(usr.icon_state in list("Meditate","Train","KO","KB")) return
		if(usr.Ki<KiReq||usr.Frozen) return
		for(var/mob/M in range(0,usr))
			if(M != usr) if(M.GrabbedMob == usr)
				usr << "Can't charge a beam while being held!"
				return
		for(var/obj/Attacks/A in usr) if(A!=src) if(A.charging|A.streaming) return
		if(!charging&&!usr.attacking)
			usr.BeamCharge(src)
			for(var/mob/M in range(20,usr))
				M << "[usr] begins to charge a Ray!"
				M.saveToLog("[key_name(M)] [usr] begins to charge a Ray! - ([usr.x],[usr.y],[usr.z])\n")
		else if(!streaming&&charging&&usr.attacking)
			usr.BeamStream(src)
			for(var/mob/M in range(20,usr))
				M << "[usr] begins to fire a Ray!"
				M.saveToLog("[key_name(M)] [usr] begins to fire a Ray! - ([usr.x],[usr.y],[usr.z])\n")
		else usr.BeamStop(src)
