obj/Attacks/Kamehameha
	Difficulty=10
	Wave=1
	icon='Beam6.dmi'
	KiReq=4
	WaveMult=2
	ChargeRate=1
	MaxDistance=20
	MoveDelay=6
	Piercer=0
	luminosity=3
	New()
		BeamDescription()
		..()
	verb/Kamehameha()
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
				M << "[usr] begins to charge a Kamehameha!"
				hearers(6,usr) << 'kame_charge.wav'
				M.saveToLog("[key_name(M)] [usr] begins to charge a Kamehameha! - ([usr.x],[usr.y],[usr.z])\n")
		else if(!streaming&&charging&&usr.attacking)
			usr.BeamStream(src)
			for(var/mob/M in range(20,usr))
				M << "[usr] begins to fire a Kamehameha!"
				hearers(6,usr) << 'kamehameha_fire.wav'
				M.saveToLog("[key_name(M)] [usr] begins to fire a Kamehameha! - ([usr.x],[usr.y],[usr.z])\n")
		else usr.BeamStop(src)