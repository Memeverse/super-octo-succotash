obj/Attacks/Shockwave
	var/Drain=50
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(A,10000)
	verb/Shockwave()
		set category="Skills"
		if((usr.icon_state in list("Meditate","Train","KO","KB"))||usr.Frozen) return
		if(usr.attacking||usr.Ki<Drain||charging) return
		usr.Ki-=Drain
		usr.attacking=3
		charging=1
		if(!Learnable)
			Learnable=1
			spawn(100) Learnable=0
		var/Amount=10
		spawn if(usr) while(Amount)
			Amount-=1
			for(var/turf/T in oview(usr,7))
				if(prob(15)&&!T.density&&!T.Water)
					var/Dirts=1
					while(Dirts)
						Dirts-=1
						var/image/I=image(icon='Damaged Ground.dmi',pixel_x=rand(-16,16),pixel_y=rand(-16,16))
						T.overlays+=I
						T.Remove_Damaged_Ground(I)
				spawn(rand(0,10)) missile(pick('Haze.dmi','Electric_Blue.dmi','Dust.dmi'),usr,T)
			sleep(3)
		spawn if(usr) for(var/mob/P in oview(usr,8)) if(P!=usr)
			var/Distance=round(10*(usr.Pow/P.Res)*(usr.BP/P.BP))
			if(Distance>30) Distance=30
			P.Shockwave_Knockback(Distance,usr.loc)
			P.Health-=10*(usr.BP/P.BP)*(usr.Pow/P.Res)
			sleep(1)
		spawn if(usr) for(var/obj/O in oview(usr,8)) if(O.z) if(O.Shockwaveable)
			var/obj/Crater/C=new
			C.loc=O.loc
			O.Shockwave_Knockback(10,usr.loc)
			sleep(1)
		spawn(100/usr.SpdMod) if(usr)
			usr.attacking=0
			charging=0

obj/Attacks/Experience=0.1
obj/Attacks/Beam
	Wave=1
	Difficulty=3
	icon='Beam3.dmi'
	KiReq=1
	WaveMult=1
	ChargeRate=1
	MaxDistance=60 //Move delay x40
	MoveDelay=3
	Piercer=0
	luminosity=2
	New()
		BeamDescription()
		..()	//Beams are bright...
	verb/Beam()
		set category="Skills"
		// *!* usr.Stop_TrainDig_Schedulers()
		if(usr.icon_state in list("Meditate","Train","KO","KB")) return
		if(usr.Ki<KiReq||usr.Frozen) return
		for(var/obj/Attacks/A in usr) if(A!=src) if(A.charging|A.streaming) return
		if(!charging&&!usr.attacking) usr.BeamCharge(src)
		else if(!streaming&&charging&&usr.attacking) usr.BeamStream(src)
		else usr.BeamStop(src)
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
		for(var/obj/Attacks/A in usr) if(A!=src) if(A.charging|A.streaming) return
		if(!charging&&!usr.attacking) usr.BeamCharge(src)
		else if(!streaming&&charging&&usr.attacking) usr.BeamStream(src)
		else usr.BeamStop(src)
obj/Attacks/Piercer
	Difficulty=10
	Wave=1
	icon='Makkankosappo.dmi'
	KiReq=10
	WaveMult=2
	ChargeRate=5
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
		for(var/obj/Attacks/A in usr) if(A!=src) if(A.charging|A.streaming) return
		if(!charging&&!usr.attacking) usr.BeamCharge(src)
		else if(!streaming&&charging&&usr.attacking) usr.BeamStream(src)
		else usr.BeamStop(src)
obj/Attacks/Kamehameha
	Difficulty=10
	Wave=1
	icon='Beam6.dmi'
	KiReq=4
	WaveMult=2
	ChargeRate=1
	MaxDistance=120
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
		for(var/obj/Attacks/A in usr) if(A!=src) if(A.charging|A.streaming) return
		if(!charging&&!usr.attacking) usr.BeamCharge(src)
		else if(!streaming&&charging&&usr.attacking) usr.BeamStream(src)
		else usr.BeamStop(src)
obj/Attacks/Dodompa
	Difficulty=10
	Wave=1
	icon='Beam4.dmi'
	KiReq=3
	WaveMult=1
	ChargeRate=0.2
	MaxDistance=10
	MoveDelay=2
	Piercer=0
	luminosity=2
	New()
		BeamDescription()
		..()
	verb/Dodompa()
		set category="Skills"
		if(usr.icon_state in list("Meditate","Train","KO","KB")) return
		if(usr.Ki<KiReq||usr.Frozen) return
		for(var/obj/Attacks/A in usr) if(A!=src) if(A.charging|A.streaming) return
		if(!charging&&!usr.attacking) usr.BeamCharge(src)
		else if(!streaming&&charging&&usr.attacking) usr.BeamStream(src)
		else usr.BeamStop(src)
obj/Attacks/Final_Flash
	Difficulty=10
	Wave=1
	icon='Beam2.dmi'
	KiReq=16
	WaveMult=4
	ChargeRate=3
	MaxDistance=360
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
		if(!charging&&!usr.attacking) usr.BeamCharge(src)
		else if(!streaming&&charging&&usr.attacking) usr.BeamStream(src)
		else usr.BeamStop(src)
obj/Attacks/Galic_Gun
	Difficulty=10
	Wave=1
	icon='Beam1.dmi'
	KiReq=6
	WaveMult=2.5
	ChargeRate=2
	MaxDistance=140
	MoveDelay=7
	Piercer=0
	luminosity=3
	New()
		BeamDescription()
		..()
	verb/Galic_Gun()
		set category="Skills"
		if(usr.icon_state in list("Meditate","Train","KO","KB")) return
		if(usr.Ki<KiReq||usr.Frozen) return
		for(var/obj/Attacks/A in usr) if(A!=src) if(A.charging|A.streaming) return
		if(!charging&&!usr.attacking) usr.BeamCharge(src)
		else if(!streaming&&charging&&usr.attacking) usr.BeamStream(src)
		else usr.BeamStop(src)
obj/Attacks/Masenko
	Difficulty=10
	Wave=1
	icon='Beam5.dmi'
	KiReq=20
	WaveMult=3
	ChargeRate=2
	MaxDistance=40
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
		for(var/obj/Attacks/A in usr) if(A!=src) if(A.charging|A.streaming) return
		if(!charging&&!usr.attacking) usr.BeamCharge(src)
		else if(!streaming&&charging&&usr.attacking) usr.BeamStream(src)
		else usr.BeamStop(src)
obj/Attacks/var
	Wave
	chargelvl=1
	tmp/charging
	tmp/streaming
	KiReq
	WaveMult
	ChargeRate
	MaxDistance
	MoveDelay
	Piercer
obj/Attacks/proc/BeamDescription() desc="[src] drains [KiReq]x energy to use. Does [WaveMult]x \
damage. Charges higher every [ChargeRate*5] seconds. Has a range of [round(MaxDistance/MoveDelay)]. \
And moves at [round(100/MoveDelay)] kilometers an hour. All stats listed are when the beam is \
fully trained. By practicing beams you can increase their \
charging speed, and movement speed, and range."

mob/proc/BeamCharge(obj/Attacks/A)
	if(Beam_Refire_Delay_Active) return
	A.Experience=1 //Makes them fully mastered from the start.
	A.charging=1
	attacking=2 //Was 3
	overlays.Remove(BlastCharge,BlastCharge)
	overlays+=BlastCharge
	spawn(10) while(A.charging|A.streaming|attacking)
		sleep(1)
		if(icon_state=="KO"|Ki<A.KiReq)
		 A.charging=0
		 A.streaming=0
		 attacking=0
		 spawn(10) if(icon_state!="KO") move=1
		 src<<"You lose the energy you were charging."
		 src.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(src)] loses the energy they were charging.<br>")
		 overlays-=BlastCharge
	spawn while(A.charging&&!A.streaming)
		if(!A.chargelvl) A.chargelvl=1
		else A.chargelvl+=A.ChargeRate
		Ki-=A.KiReq*A.ChargeRate
		sleep((Refire*A.ChargeRate)/A.Experience)
mob/proc/BeamStream(obj/Attacks/A)
	A.charging=0
	A.streaming=1
	overlays-=BlastCharge
	if(icon_state!="Flight") icon_state="Blast"
	if(A.MoveDelay<1) A.MoveDelay=1
	spawn while(A.streaming&&src)
		if(istype(src.loc, /turf/Other/Stars))	//Beams are a viable travel method right
			inertia_dir = reverseDir(dir2text(src.dir))
			var/turf/T = get_step(src, src.inertia_dir)
			if(!T.density) step(src, src.inertia_dir)
		if(!A.Learnable)
			A.Learnable=1
			spawn(100) A.Learnable=0
		if(prob(0.1*A.MoveDelay)&&A.Experience<1) A.Experience+=0.1
		sleep(round(A.MoveDelay/A.Experience))
		var/obj/Blast/B=new
		B.icon=A.icon
		B.luminosity=(A.luminosity)
		B.animate_movement=0
		B.layer=MOB_LAYER+1
		B.icon_state="origin"
		B.density=0
		B.Beam=1
		B.Piercer=A.Piercer
		B.dir=dir
		B.Damage=BP*Pow*A.chargelvl*A.WaveMult*Ki_Power
		B.Power=BP*A.chargelvl*A.WaveMult*Ki_Power
		B.Offense=Off
		B.Belongs_To=src
		B.loc=get_step(src,dir)
		walk(B,dir,round(A.MoveDelay/A.Experience))
		spawn(round(A.MoveDelay/A.Experience)) if(B)
			B.icon_state="tail"
			B.Beam()
		Ki-=A.KiReq
		spawn(A.MaxDistance*0.5) if(B) del(B)
		if(Ki<=0) BeamStop(A)
mob/proc/BeamStop(obj/Attacks/A)
	Beam_Refire_Delay_Active=1
	spawn(50/SpdMod) if(src) Beam_Refire_Delay_Active=0
	A.charging=0
	A.streaming=0
	attacking = 1
	spawn(Refire) attacking = 0
	A.chargelvl=1
	if(icon_state=="Blast"&&icon_state!="Flight") icon_state=""
	if(icon_state!="KO") move=1