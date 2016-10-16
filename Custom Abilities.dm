obj/Attacks/Dragon_Nova
	Fatal=1
	Difficulty=10000
	icon='16.dmi'
	desc="A giant charged energy ball. It is very powerful, and very explosive. It is very similar to \
	Kikoho but does not drain health, and due to that, it is a bit weaker, but still much stronger \
	than charge. It is quite a good finishing attack."
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(A,10000)
	verb/Dragon_Nova()
		set category="Skills"
		if((usr.icon_state in list("Meditate","Train","KO","KB"))||usr.Frozen) return
		if(usr.attacking|usr.Ki<100) return
		if(!Learnable)
			Learnable=1
			spawn(100) Learnable=0
		usr.Ki-=100
		usr.attacking=3
		charging=1
		usr.overlays+=usr.BlastCharge
		sleep(100/usr.SpdMod)
		usr.overlays-=usr.BlastCharge
		var/obj/Blast/Dragon_Nova/A=new(get_step(src,usr.dir))
		A.loc=get_step(A,usr.dir)
		A.Owner=usr
		A.Damage=200*usr.BP*usr.Pow*Ki_Power
		A.Power=200*usr.BP*Ki_Power
		A.Offense=usr.Off
		walk(A,usr.dir,4)
		usr.attacking=0
		charging=0
		spawn(100) if(usr.Health<0&&prob(10)) usr.Death(usr)
obj/Blast/Dragon_Nova
	Piercer=0
	Explosive=1
	density=1
	New()
		var/Icon='deathball.dmi'
		Icon+=rgb(100,200,250,120)
		var/image/A=image(icon=Icon,icon_state="1",pixel_x=-16,pixel_y=-16,layer=5)
		var/image/B=image(icon=Icon,icon_state="2",pixel_x=16,pixel_y=-16,layer=5)
		var/image/C=image(icon=Icon,icon_state="3",pixel_x=-16,pixel_y=16,layer=5)
		var/image/D=image(icon=Icon,icon_state="4",pixel_x=16,pixel_y=16,layer=5)
		overlays.Remove(A,B,C,D)
		overlays.Add(A,B,C,D)
		//..()
	Move()
		for(var/atom/A in orange(1,src)) if(A!=src&&A.density&&!isarea(A)) Bump(A)
		if(src) ..()
obj/Leave_Planet/verb/Leave_Planet(var/how as text)
	set category="Skills"
	if(!how)
		how = input("Describe yourself leaving the planet. You will leave the planet after one minute.") as text
	how = copytext(sanitize(how), 1, MAX_MESSAGE_LEN)
	if(!how)
		return
	view(usr) << "[src] [how]"
	usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] LEAVE_PLANET: [src] [how].<br>")
	spawn(600)
		Liftoff(usr)
obj/Restore_Planet/verb/Restore_Planet()
	set category="Skills"
	var/list/Planets=new
	Planets.Add("Cancel","Earth","Namek","Vegeta","Arconia","Ice")
	switch(input("") in Planets)
		if("Cancel") return
		if("Earth") Planet_Restore(1)
		if("Namek") Planet_Restore(3)
		if("Vegeta") Planet_Restore(4)
		if("Arconia") Planet_Restore(8)
		if("Ice") Planet_Restore(12)
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
				B.saveToLog("| [B.client.address ? (B.client.address) : "IP not found"] | ([B.x], [B.y], [B.z]) has become the Herald of Galactus.<br>")
				B.Heraldify()
	verb/DeHerald()
		set category="Skills"
		var/list/People=new
		People+="Cancel"
		for(var/mob/A in Players) if(locate(/obj/Heralded) in A) People+=A
		var/mob/B=input("Remove Herald powers from who?") in People
		if(B=="Cancel") return
		B.DeHeraldify()
		B.saveToLog("| [B.client.address ? (B.client.address) : "IP not found"] | ([B.x], [B.y], [B.z]) has lost his Herald of Galactus powers.<br>")


mob/proc/Heraldify()
	contents+=new/obj/Heralded
	End+=600*EndMod
	Res+=600*ResMod
	Pow+=300*PowMod
	MaxKi+=500*KiMod
	Lungs+=1
	FlySkill+=1000
	if(!(locate(/obj/Fly) in src)) contents+=new/obj/Fly
	if(!(locate(/obj/Telepathy) in src)) contents+=new/obj/Telepathy
	if(!(locate(/obj/Attacks/CosmicBlast) in src)) contents+=new/obj/Attacks/CosmicBlast
	if(!(locate(/obj/Attacks/Cosmic_Crush) in src)) contents+=new/obj/Attacks/Cosmic_Crush
	if(!(locate(/obj/Attacks/Cosmic_Barrier) in src)) contents+=new/obj/Attacks/Cosmic_Barrier
	if(!(locate(/obj/Shield) in src)) contents+=new/obj/Shield
	if(!(locate(/obj/Heal) in src)) contents+=new/obj/Heal
	if(!(locate(/obj/Leave_Planet) in src)) contents+=new/obj/Leave_Planet
	Cosmic_Power+=100000
mob/proc/DeHeraldify()
	for(var/obj/Heralded/A in src) del(A)
	for(var/obj/Attacks/CosmicBlast/A in src) del(A)
	for(var/obj/Attacks/Cosmic_Crush/A in src) del(A)
	for(var/obj/Attacks/Cosmic_Barrier/A in src) del(A)
	for(var/obj/Leave_Planet/A in src) del(A)
	Cosmic_Power=0
mob/proc/Galactus_Revival()
	z=11
	new/obj/Cosmic_Bubble(loc)
	Absorb=0
	Revive()
obj/Cosmic_Bubble/New()
	layer=50
	Savable=0
	var/icon/J=new('Portal.dmi')
	J.MapColors("#990099","#ffffff","#000000")
	J+=rgb(120,60,120)
	var/image/A=image(icon=J,icon_state="1",pixel_x=-32,pixel_y=-32)
	var/image/B=image(icon=J,icon_state="2",pixel_x=0,pixel_y=-32)
	var/image/C=image(icon=J,icon_state="3",pixel_x=32,pixel_y=-32)
	var/image/D=image(icon=J,icon_state="4",pixel_x=-32,pixel_y=0)
	var/image/E=image(icon=J,icon_state="5",pixel_x=0,pixel_y=0)
	var/image/F=image(icon=J,icon_state="6",pixel_x=32,pixel_y=0)
	var/image/G=image(icon=J,icon_state="7",pixel_x=-32,pixel_y=32)
	var/image/H=image(icon=J,icon_state="8",pixel_x=0,pixel_y=32)
	var/image/I=image(icon=J,icon_state="9",pixel_x=32,pixel_y=32)
	overlays.Remove(A,B,C,D,E,F,G,H,I)
	overlays.Add(A,B,C,D,E,F,G,H,I)
	spawn(300) if(src) del(src)
	//..()
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
		Owner=null
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
proc/Shockwave(mob/Origin,Range=7,Icon='Shockwave.dmi')
	for(var/turf/T in range(Range,Origin)) missile(Icon,Origin,T)
mob/proc/Screen_Shake(Amount=10,Offset=8) if(client)
	while(Amount)
		Amount-=1
		client.pixel_x=rand(-Offset,Offset)
		client.pixel_y=rand(-Offset,Offset)
		sleep(1)
turf/proc/Make_Damaged_Ground(Amount=1) if(!density&&!Water)
	while(Amount)
		Amount-=1
		var/image/I=image(icon='Damaged Ground.dmi',pixel_x=rand(-16,16),pixel_y=rand(-16,16))
		overlays+=I
		Remove_Damaged_Ground(I)
obj/Attacks/Zariun_Crush
	verb/Crush()
		set category="Skills"
		usr.Crush()
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(A,15000)
mob/proc/Crush(I='Trans1 Electric.dmi')
	if(Ki<2000) return
	Ki-=2000
	for(var/mob/M in view(src)) spawn if(M!=src)
		M.Health-=1*((Pow*BP)/(M.Res*M.BP))
		M.KB=rand(10,20)
		var/obj/Explosion/E=new(M.loc)
		E.icon=I
		while(M.KB>1&&M)
			if(M.client) M.icon_state="KB"
			M.KB-=1
			M.Knockback()
			step_away(M,usr,50)
			sleep(1)
		if(M&&M.icon_state!="KO") M.icon_state=""
obj/Attacks/Zariun_Barrier
	var/Active
	verb/Barrier()
		set category="Skills"
		Active=!Active
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(A,15000)
obj/Barrier_Fire
	icon='Trans1 Electric.dmi'
	icon_state="full2"
	layer=MOB_LAYER+1
	Savable=0
	var/Force=1
	var/Battle_Power=1
	New()
		pixel_x=rand(-16,16)
		pixel_y=rand(-16,16)
		var/Amount=2
		while(Amount)
			Amount-=1
			var/icon/B=icon
			var/image/A=image(icon=B,pixel_x=rand(-32,32),pixel_y=rand(-32,32))
			overlays+=A
		spawn(rand(10,100)) if(src) del(src)
		spawn if(src) Barrier_Fire()
	Del()
		Owner=null
		..()
	proc/Barrier_Fire() while(src)
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

mob/proc/Shadow_King() if(!Shadow_Power)
	if(!(locate(/obj/Shadow_King) in src))
		Health=100
		Ki=MaxKi
		if(prob(10)) contents+=new/obj/Shadow_King //Master Shadow King, use it at will
	Shadow_Power+=1
	BP_Multiplier*=3
	Shadow_Overlays()
mob/proc/Shadow_Revert()
	Shadow_Power-=1
	BP_Multiplier/=3
	Shadow_Overlays()
mob/proc/Shadow_Overlays()
	var/image/A=image(icon='Okage.dmi',icon_state="1",layer=MOB_LAYER+2,pixel_y=32)
	var/image/B=image(icon='Okage.dmi',icon_state="2")
	underlays.Remove('Okage.dmi',A)
	overlays-=B
	if(Shadow_Power)
		underlays.Add('Okage.dmi',A)
		overlays+=B
obj/Shadow_King
	verb/Shadow_King()
		set category="Skills"
		if(!usr.Shadow_Power)
			view(usr)<<"[usr]'s power suddenly increases greatly!"
			usr.Shadow_King()
		else usr.Shadow_Revert()
	verb/Teach()
		set category="Skills"
		var/list/People=new
		for(var/mob/A in view(usr))
			if(A.client&&!(locate(/obj/Shadow_King) in A)&&!(locate(/obj/Pseudo_King) in A)) People+=A
		var/mob/A=input("Teach who?") in People
		switch(input(A,"[usr] wants to grant you the powers of the Shadow King. You will have access to \
		a great amount of new power, but your life will be in their hands. Do you want this?") in list(\
		"Yes","No"))
			if("No")
				view(usr)<<"[A] declines the offer from [usr]"
				usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] [A] declines the offer from [usr].<br>")
				A.saveToLog("| [A.client.address ? (A.client.address) : "IP not found"] | ([A.x], [A.y], [A.z]) [A] declines the offer from [usr].<br>")
			if("Yes")
				view(usr)<<"[A] accepts [usr]'s offer"
				usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] [A] accepts the offer from [usr].<br>")
				A.saveToLog("| [A.client.address ? (A.client.address) : "IP not found"] | ([A.x], [A.y], [A.z]) [A] accepts the offer from [usr].<br>")
				if(!(locate(/obj/Pseudo_King) in A)) A.contents+=new/obj/Pseudo_King
	verb/Kill_Minion()
		set category="Skills"
		var/list/People=new
		People+="Cancel"
		for(var/mob/A in Players) if(locate(/obj/Pseudo_King) in A) People+=A
		var/mob/A=input("You can kill anyone who possesses shadow king powers instantly. Who do you want \
		to kill?") in People
		if(A=="Cancel") return
		A.Pseudo_Revert()
		for(var/obj/Pseudo_King/B in A) del(B)
		usr.Shadow_Crush(A)
		A.Death("his own shadow king powers betraying him")
obj/Pseudo_King/verb/Shadow_King()
	set category="Skills"
	if(!usr.Shadow_Power)
		view(usr)<<"[usr]'s power suddenly increases greatly!"
		usr.Pseudo_King()
	else usr.Pseudo_Revert()
mob/proc/Pseudo_King() if(!Shadow_Power)
	Shadow_Power+=1
//	if(Shadow_Power>2000000) Shadow_Power=2000000
	BP_Multiplier*=1.5
	Shadow_Overlays()
mob/proc/Pseudo_Revert()
	BP_Multiplier/=1.5
	Shadow_Power-=1
	Shadow_Overlays()
mob/proc/Shadow_Crush(mob/M)
	if(Ki<100) return
	Ki-=100
	M.Health-=1*((Pow*BP)/(M.Res*M.BP))
	M.KB=rand(3,6)
	new/obj/Explosion(M.loc)
	while(M.KB>1&&M)
		if(M.client) M.icon_state="KB"
		M.KB-=1
		M.Knockback()
		step_away(M,usr,50)
		sleep(1)
	if(M&&M.icon_state!="KO") M.icon_state=""
obj/Attacks/VoidBlast
	Fatal=1
	Difficulty=2
	Level=1
	Experience=1
	icon='Black Hole.dmi'
	desc="An explosive one-shot energy attack that takes a short time to charge. It starts fully \
	mastered"
	verb/VoidBlast()
		set category="Skills"
		if((usr.icon_state in list("Meditate","Train","KO","KB"))||usr.Frozen) return
		if(usr.attacking|usr.Ki<50) return
		/*if(!Learnable)
			Learnable=1
			spawn(100) Learnable=0*/
		//if(prob(10)&&Level<1) Level+=1
		if(prob(10)&&Experience<1) Experience+=0.1
		usr.Ki-=50
		usr.attacking=3
		charging=1
		usr.overlays+='Black Hole.dmi'
		sleep(40/usr.SpdMod)
		usr.overlays-='Black Hole.dmi'
		var/obj/Blast/A=new
		A.Owner=usr
		A.icon=icon
		A.Damage=50*usr.BP*usr.Pow
		A.Power=50*usr.BP
		A.Offense=usr.Off
		A.Explosive=Level
		A.dir=usr.dir
		A.loc=usr.loc
		step(A,A.dir)
		if(A) walk(A,A.dir,2)
		usr.attacking=0
		charging=0
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(A,1000)
obj/Void_Consume
	verb/Void_Consume()
		set category="Skills"
		var/list/People=new
		for(var/mob/A in oview(usr)) if(A.client&&!A.Void_Power) People+=A
		var/mob/B=input("Who?") in People
		switch(input(B,"Do you want to be consumed into the void of [usr]? This will give you immense \
		power, but in return, years of your life will be given to [usr]") in list("Yes","No"))
			if("No") usr<<"[B] denies your offer"
			if("Yes")
				view(B)<<"[B] has become part of the void"
				B.Voidify()
				usr.Decline+=10
	verb/DeVoid()
		set category="Skills"
		var/list/People=new
		People+="Cancel"
		for(var/mob/A in Players) if(A.Void_Power) People+=A
		var/mob/B=input("Remove Void powers from who?") in People
		if(B=="Cancel") return
		B.DeVoidify()
		usr.Decline-=10

mob/proc/Voidify()
	Void_Power+=Base*20
	Void_Power+=10000
	if(Void_Power>100000) Void_Power=100000
	Decline-=10
mob/proc/DeVoidify()
	Void_Power=0
	Decline+=10
obj/Attacks/Void_Crush
	verb/Void_Crush()
		set category="Skills"
		usr.Void_Crush()
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(A,15000)
mob/proc/Void_Crush()
	if(Ki<2000) return
	Ki-=2000
	for(var/mob/M in view(src)) spawn if(M!=src)
		M.Health-=1*((Pow*BP)/(M.Res*M.BP))
		M.KB=rand(10,20)
		var/obj/Explosion/E=new(M.loc)
		E.icon='Black Hole.dmi'
		while(M.KB>1&&M)
			if(M.client) M.icon_state="KB"
			M.KB-=1
			M.Knockback()
			step_away(M,usr,50)
			sleep(1)
		if(M&&M.icon_state!="KO") M.icon_state=""
obj/Attacks/Void_Barrier
	var/Active
	verb/Void_Barrier()
		set category="Skills"
		Active=!Active
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(A,15000)
obj/Void_Fire
	icon='Black Hole.dmi'
	icon_state="full2"
	layer=MOB_LAYER+1
	Savable=0
	var/Force=1
	var/Battle_Power=1
	New()
		icon_state=pick("","","","","full","full2")
		pixel_x=rand(-16,16)
		pixel_y=rand(-16,16)

		/*var/image/A=image(icon='Cosmic Fire.dmi',icon_state="1",pixel_x=-32)
		var/image/B=image(icon='Cosmic Fire.dmi',icon_state="2")
		var/image/C=image(icon='Cosmic Fire.dmi',icon_state="3",pixel_x=32)
		overlays.Add(A,B,C)*/

		var/Amount=2
		while(Amount)
			Amount-=1
			var/icon/B='Black Hole.dmi'
			var/image/A=image(icon=B,pixel_x=rand(-32,32),pixel_y=rand(-32,32),icon_state=pick("","","","","full","full2"))
			overlays+=A

		spawn(rand(10,50)) if(src) del(src)
		spawn if(src) Void_Fire()
		//..()
	Del()
		Owner=null
		..()
	proc/Void_Fire() while(src)
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
obj/Send_Energy
	var/tmp/Active
	verb/Send_Energy()
		set category="Skills"
		if(Active) Active=0
		else
			var/list/Choices=new
			Choices+="Cancel"
			for(var/mob/P in view(10,usr)) if(P.client&&P!=usr) Choices+=P
			var/mob/P=input(usr,"Choose who to send energy to") in Choices
			if(!P||P=="Cancel") return
			Active=1
			spawn while(P&&Active)
				missile('Spirit.dmi',usr,P)
				sleep(1)
			spawn while(P&&Active)
				if(usr.Ki>usr.MaxKi*0.01)
					usr.Ki-=usr.MaxKi*0.01
					P.Ki+=usr.MaxKi*0.01
				if(usr.Health>=10)
					usr.Health-=1
					P.Health+=1
				sleep(10)

obj/Vampire_Infect
	desc="You can use this ability to give someone vampiric abilities"
	verb/Vampire_Infect()
		set category="Skills"
		for(var/mob/P in get_step(usr,usr.dir)) if(P.client)
			if(P.Vampire)
				usr<<"They are already a vampire"
				return
			if(P.icon_state!="KO") switch(input(P,"Do you want [usr] to turn you into a vampire?") in list("No","Yes"))
				if("No") return
			view(usr)<<"[usr] bites [P] and turns them into a vampire!"
			usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] turns [P] into a vampire <br>")
			for(var/obj/Redo_Stats/R in P) R.Last_Redo=0
			P.Vampire=1
			P.contents.Add(new/obj/Vampire_Absorb,new/obj/Turn_To_Smoke)
			if(P.Base/P.BPMod<usr.Base/usr.BPMod) P.Base=(usr.Base/usr.BPMod)*P.BPMod
			if(P.MaxKi/P.KiMod<usr.MaxKi/usr.KiMod) P.MaxKi=(usr.MaxKi/usr.KiMod)*P.KiMod
			P.Immortal=1
			P.Un_KO()
			return
obj/Vampire_Absorb
	desc="This ability can be turned on to allow you to absorb the energy of a person you are sparring \
	with each time you hit them. The drawback is that while using this your resistance and force will be halved."
	var/Active
	verb/Vampire_Absorb()
		set category="Skills"
		Active=!Active
		if(Active)
			usr<<"You will now absorb the energy of people you spar with."
			usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] activates Vampire Absorb and will now absorb the energy of the people they fight/spar.<br>")
			usr.Pow*=0.5
			usr.PowMod*=0.5
			usr.Res*=0.5
			usr.ResMod*=0.5
		else
			usr<<"You will not absorb the energy of people you spar with."
			usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] deactivates Vampire Absorb and will no longer absorb the energy of the people they fight/spar.<br>")
			usr.Pow*=2
			usr.PowMod*=2
			usr.Res*=2
			usr.ResMod*=2
obj/Turn_To_Smoke
	desc="When you active this, you can turn into smoke and move really fast, but you will not be able to \
	use melee attacks"
	var/Active
	verb/Smoke_Form()
		set category="Skills"
		if(!Active)
			Active=1
			icon=usr.icon
			overlays=usr.overlays
			usr.icon='Smoke.dmi'
			usr.overlays-=usr.overlays
		else
			Active=0
			usr.icon=icon
			usr.overlays=overlays
mob/proc/Vampire_Skills()
	contents.Add(new/obj/Vampire_Absorb,new/obj/Turn_To_Smoke,new/obj/Vampire_Infect,new/obj/Send_Energy)