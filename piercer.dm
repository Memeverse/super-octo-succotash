obj/Attacks/Piercer
	Difficulty=10
	Wave=1
	icon='Makkankosappo.dmi'
	KiReq=10
	WaveMult=2
	ChargeRate=3
	MaxDistance=20
	MoveDelay=1
	Piercer=0
	luminosity=2
	New()
		BeamDescription()
		..()
	verb/Piercer()
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
				M << "[usr] begins to charge a Piercer!"
				M.saveToLog("[key_name(M)] [usr] begins to charge a Piercer! - ([usr.x],[usr.y],[usr.z])\n")
		else if(!streaming&&charging&&usr.attacking)
			if(src.chargelvl < 7)
				return
			usr.BeamStream(src)
			for(var/mob/M in range(20,usr))
				M << "[usr] begins to fire a Piercer!"
				M.saveToLog("[key_name(M)] [usr] begins to fire a Piercer! - ([usr.x],[usr.y],[usr.z])\n")
		else usr.BeamStop(src)