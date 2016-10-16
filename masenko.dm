obj/Attacks/Masenko
	Difficulty=10
	Wave=1
	icon='Beam5.dmi'
	KiReq=20
	WaveMult=3
	ChargeRate=2
	MaxDistance=10
	MoveDelay=4
	Piercer=0
	luminosity=2
	New()
		BeamDescription()
		..()
	verb/Masenko()
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
				M << "[usr] begins to charge a Masenko!"
				M.saveToLog("[key_name(M)] [usr] begins to charge a Masenko! - ([usr.x],[usr.y],[usr.z])\n")
		else if(!streaming&&charging&&usr.attacking)
			usr.BeamStream(src)
			for(var/mob/M in range(20,usr))
				M << "[usr] begins to fire a Masenko!"
				M.saveToLog("[key_name(M)] [usr] begins to fire a Masenko! - ([usr.x],[usr.y],[usr.z])\n")
		else usr.BeamStop(src)