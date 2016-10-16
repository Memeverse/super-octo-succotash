obj/Heralded

obj/Herald
	verb/Herald()
		set category="Skills"
		var/list/People=new
		for(var/mob/A in oview(usr)) if(A.client&&!(locate(/obj/Heralded) in A)) People+=A
		var/mob/B=input("Herald who?") in People
		switch(input(B,"Do you want to become the Herald of [usr]?") in list("Yes","No"))
			if("No") usr<<"[B] denies your offer"
			if("Yes")
				view(B)<<"[B] has become the Herald of Galactus"
				B.saveToLog("| [B.client.address ? (B.client.address) : "IP not found"] | ([B.x], [B.y], [B.z]) has become the Herald of Galactus.\n")
				B.Heraldify()
	verb/DeHerald()
		set category="Skills"
		var/list/People=new
		People+="Cancel"
		for(var/mob/player/A in Players) if(locate(/obj/Heralded) in A) People+=A
		var/mob/B=input("Remove Herald powers from who?") in People
		if(B=="Cancel") return
		B.DeHeraldify()
		B.saveToLog("| [B.client.address ? (B.client.address) : "IP not found"] | ([B.x], [B.y], [B.z]) has lost his Herald of Galactus powers.\n")

mob/proc/Heraldify()
	contents+=new/obj/Heralded
	End+=600*EndMod
	Res+=600*ResMod
	Pow+=300*PowMod
	MaxKi+=500*KiMod
	Lungs++
	FlySkill+= 1000
	if(!(locate(/obj/Fly) in src)) contents+=new/obj/Fly
	if(!(locate(/obj/Telepathy) in src)) contents+=new/obj/Telepathy
	if(!(locate(/obj/Attacks/CosmicBlast) in src)) contents+=new/obj/Attacks/CosmicBlast
	if(!(locate(/obj/Attacks/Cosmic_Crush) in src)) contents+=new/obj/Attacks/Cosmic_Crush
	if(!(locate(/obj/Attacks/Cosmic_Barrier) in src)) contents+=new/obj/Attacks/Cosmic_Barrier
	if(!(locate(/obj/Shield) in src)) contents+=new/obj/Shield
	if(!(locate(/obj/Heal) in src)) contents+=new/obj/Heal
	if(!(locate(/obj/Leave_Planet) in src)) contents+=new/obj/Leave_Planet
	Cosmic_Power+= 100000

mob/proc/DeHeraldify()
	for(var/obj/Heralded/A in src) del(A)
	for(var/obj/Attacks/CosmicBlast/A in src) del(A)
	for(var/obj/Attacks/Cosmic_Crush/A in src) del(A)
	for(var/obj/Attacks/Cosmic_Barrier/A in src) del(A)
	for(var/obj/Leave_Planet/A in src) del(A)
	Cosmic_Power=0

obj/Attacks/CosmicBlast
	Difficulty=10000000000000
	Wave=1
	icon='Beam9.dmi'
	KiReq=3
	WaveMult=1
	ChargeRate=0.2
	MaxDistance=20
	MoveDelay=1
	Piercer=0
	Experience=1
	New()
		BeamDescription()
		//..()
	verb/Cosmic_Shot()
		set category="Skills"
		if(usr.icon_state in list("Meditate","Train","KO","KB")) return
		if(usr.Ki<KiReq||usr.Frozen) return
		for(var/obj/Attacks/A in usr) if(A!=src) if(A.charging|A.streaming) return
		if(!charging&&!usr.attacking) usr.BeamCharge(src)
		else if(!streaming&&charging&&usr.attacking) usr.BeamStream(src)
		else usr.BeamStop(src)

obj/Attacks/Cosmic_Crush/verb/Cosmic_Crush()
	set category="Skills"
	usr.Cosmic_Crush()

mob/proc/Cosmic_Crush()
	if(Ki<2000) return
	Ki-=2000
	for(var/mob/M in view(src)) spawn if(M!=src)
		M.Health-=1*((Pow*BP)/(M.Res*M.BP))
		M.KB=rand(10,20)
		var/obj/Explosion/E=new(M.loc)
		E.icon='Plasma Explosion.dmi'
		while(M.KB>1&&M)
			if(M.client) M.icon_state="KB"
			M.KB-=1
			M.Knockback()
			step_away(M,usr,50)
			sleep(1)
		if(M&&M.icon_state!="KO") M.icon_state=""

obj/Attacks/Cosmic_Barrier
	var/Active
	verb/Cosmic_Barrier()
		set category="Skills"
		Active=!Active

obj/Cosmic_Fire
	//icon='Plasma Explosion Transparent.dmi'
	layer=MOB_LAYER+1
	Savable=0
	var/Force=1
	var/Battle_Power=1
	New()
		pixel_x=rand(-16,16)
		pixel_y=rand(-16,16)

		var/image/A=image(icon='Cosmic Fire.dmi',icon_state="1",pixel_x=-32)
		var/image/B=image(icon='Cosmic Fire.dmi',icon_state="2")
		var/image/C=image(icon='Cosmic Fire.dmi',icon_state="3",pixel_x=32)
		overlays.Add(A,B,C)

		/*var/Amount=2
		while(Amount)
			Amount-=1
			var/icon/B='Plasma Explosion Transparent.dmi'
			var/image/A=image(icon=B,pixel_x=rand(-32,32),pixel_y=rand(-32,32))
			overlays+=A*/

		spawn(rand(10,50)) if(src) del(src)
		spawn if(src) Cosmic_Fire()
		//..()
	Del()
		Belongs_To=null
		..()
	proc/Cosmic_Fire() while(src)
		for(var/mob/A in range(0,src)) if(A!=Owner)
			//var/Shield
			//for(var/obj/Shield/S in A) if(S.Using) Shield=1
			A.Health-=1*(Force/A.Res)*(Battle_Power/A.BP)
			if(A.Health<=0)
				if(A.client) spawn A.KO("[usr]")
				else spawn A.Death("[usr]")
		for(var/obj/A in range(0,src)) if(A.type!=type)
			A.Health-=Force*2
			if(A.Health<=0)
				new/obj/BigCrater(A.loc)
				del(A)
		sleep(5)