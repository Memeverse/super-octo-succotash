obj/Attacks/Final_Flash
	Difficulty=10
	Wave=1
	icon='Beam2.dmi'
	KiReq=16
	WaveMult=4
	ChargeRate=3
	MaxDistance=40
	MoveDelay=9
	Piercer=0
	luminosity=2
	New()
		BeamDescription()
		..()
	verb/Final_Flash()
		set category="Skills"
		if(usr.icon_state in list("Meditate","Train","KO","KB")) return
		if(usr.Ki<KiReq||usr.Frozen) return
		for(var/obj/Attacks/A in usr) if(A!=src) if(A.charging|A.streaming) return
		for(var/mob/M in range(0,usr))
			if(M != usr) if(M.GrabbedMob == usr)
				usr << "Can't charge a beam while being held!"
				return
		if(!charging&&!usr.attacking)
			usr.BeamCharge(src)
			for(var/mob/M in range(20,usr))
				M << "[usr] begins to charge a Final Flash!"
				hearers(6,usr) << 'finalflash_charge.wav'
				M.saveToLog("[key_name(M)] [usr] begins to charge a Final Flash! - ([usr.x],[usr.y],[usr.z])\n")
		else if(!streaming&&charging&&usr.attacking)
			usr.BeamStream(src)
			for(var/mob/M in range(20,usr))
				M << "[usr] begins to fire a Final Flash!"
				hearers(6,usr) << 'finalflash.wav'
				M.saveToLog("[key_name(M)] [usr] begins to fire a Final Flash! - ([usr.x],[usr.y],[usr.z])\n")
		else usr.BeamStop(src)