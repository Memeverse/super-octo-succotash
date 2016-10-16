
Event/Timer/Transformation
	var/mob/player

	New(var/EventScheduler/scheduler, var/mob/D)
		..(scheduler, 20)
		src.player = D

	fire()
		..()  // Make sure we allow the /Event/Timer fire() to do it's thing.

		if(isnull(player)){skills_scheduler.cancel(src);return}

		var/Trans = 0
		if(player.Hybrid_Trans || player.Melee_Trans || player.Ki_Trans)
			Trans = 1
			if(player.Ki>=player.MaxKi/player.Trans_Drain)
				if(player.Trans_Drain<300)
					if(!player.ismystic) player.Ki-=0.5*(player.MaxKi/player.Trans_Drain)
					if(!player.afk) player.Trans_Drain+=0.01
					if(player.z==10) player.Trans_Drain+=0.09*1
				if(player.Ki<=player.MaxKi/10&&player.Trans_Drain<300)
					player.Cancel_Transformation()
					player <<"You are too tired to sustain your form."
		if(player.ssj>=1)
			Trans = 1
		//Super Saiyan Drain
			if(player.ssj == 1||player.ssj == 2)
				if(player.Ki>=player.MaxKi/player.ssjdrain)
					if(player.ssjdrain<300)
						if(!player.ismystic) player.Ki-=0.5*(player.MaxKi/player.ssjdrain)
						if(player.Class!="Legendary")
							if(!player.afk)player.ssjdrain+=0.01*player.ssjmod
							if(player.z==10) player.ssjdrain+=0.09*player.ssjmod
					if(player.Ki<=player.MaxKi/10&&player.ssjdrain<300)
						player.Cancel_Transformation()
						player <<"You are too tired to sustain your form."

			//Super Saiyan 2 Drain
			if(player.ssj == 2&&player.Ki>=player.MaxKi/player.ssj2drain)
				if(player.ssj2drain<300)
					if(!player.ismystic) player.Ki-=0.5*(player.MaxKi/player.ssj2drain)
					if(!player.afk)player.ssj2drain+=0.01*player.ssj2mod
					if(player.z==10) player.ssj2drain+=0.09*player.ssjmod
				if(player.Ki<=(player.MaxKi/10))
					player.Cancel_Transformation()
					player <<"You are too tired to sustain your form."
				if(!player.ismystic) player.Ki-=player.MaxKi/300

			//Super Saiyan 3 Drain
			if(player.ssj == 3&&player.Ki+1>=player.MaxKi/player.ssj3drain)
				if(player.ssj3drain<300)
					player.Ki-=0.5*(player.MaxKi/player.ssj3drain)
					if(!player.afk)player.ssj3drain+=0.01*player.ssj3mod
					if(player.z==10) player.ssj3drain+=0.09*player.ssjmod
				if(player.Ki<=(player.MaxKi/5))
					player.Cancel_Transformation()
					player <<"You are too tired to sustain your form."
				player.Ki-=player.MaxKi/200

		if(Trans == 0)
			player.Cancel_Transformation()
			player = null

mob/var/tmp/Event/Timer/Transformation/transformation_event = null

mob/proc/Cancel_Transformation()
	if (src.transformation_event)
		skills_scheduler.cancel(src.transformation_event)
		src.transformation_event = null

	src.Revert()
	/*
	* Revert should be called regardless of wether or not
	* It has a transformation_event as Revert() also deals with changelings and I can't be bothered sorting
	* that out. -- Vale
	*/


mob/proc/Revert()
	if(Race=="Changeling")
		Changeling_Revert()
	else if(Race=="Alien")
		Alien_Revert()
	else if(ssj>0&&!transing)
		if(ssj==1)
			Recovery*=1.2
			BP_Multiplier/=ssjmult
			Zenkai_Power/=ssjmult
		else if(ssj==2)
			Recovery*=1.2
			BP_Multiplier/=ssjmult*ssj2mult
			Zenkai_Power/=ssj2mult
		else if(ssj==3)
			Recovery*=1.2
			BP_Multiplier/=ssjmult*ssj2mult*ssj3mult
			Zenkai_Power/=ssjmult*ssj2mult*ssj3mult
		else if(ssj==4)
			Recovery*=10
			SpdMod/=2
			BP_Multiplier/=ssj4mult
			Zenkai_Power/=ssj4mult
			MaxAnger*=2
			Regeneration*=0.5
		KaiokenMod*=0.1
		SSjPower=0
		ssj=0
		Super_Sparks()
		Super_Hair()
		Expand_Revert()
		AuraOverlays()
		overlays-='SSj4 Overlay.dmi'

mob/proc/Super_Sparks()
	overlays.Remove('Elec.dmi','Electric_Blue.dmi','Electric_Yellow.dmi','SSj4 Overlay.dmi')
	if(ssj==2) overlays+='Electric_Blue.dmi'
	if(ssj==3) overlays+='Electric_Blue.dmi'

mob/proc/Super_Hair()
	overlays.Remove(hair,ssjhair,ussjhair,ssjfphair,ssj2hair,ssj3hair,ssj4hair)
	if(!ssj|ismystic) overlays+=hair
	else if(ssj==1&&ssjdrain<300) overlays+=ssjhair
	else if(ssj==1) overlays+=ssjfphair
	else if(ssj==2) overlays+=ssj2hair
	else if(ssj==3) overlays+=ssj3hair
	else if(ssj==4) overlays+=ssj4hair
	var/T='Tail.dmi'
	T+=rgb(120,120,60)
	overlays-=T
	if(Tail&&ssj&&ssj<4&&!ismystic) overlays+=T

mob/var
	Hybrid_Build = 0
	Ki_Build = 0
	Melee_Build = 0

	Hybrid_Trans = 0
	Ki_Trans = 0
	Melee_Trans = 0

	Trans_Drain = 0

	Melee_Req = 10000
	Ki_Req = 10000
	Hybrid_Req = 10000

	Trans = 0 //Does this race have a trans or an ascension instead?

	Ascended = 0
	Hasssj = 0
mob/proc/Bojack()
	if(src.Roid_Power||src.Artificial_Power) return
	if(!src.transing&&src.Melee_Build==2&&!src.Melee_Trans&&src.Base>=src.Melee_Req)
		src.transing=1
		src.Melee_Trans=1
		src.BP_Multiplier*=2

		src.Str*=1.2
		src.StrMod*=1.2
		src.End*=1.2
		src.EndMod*=1.2
		src.Regeneration*=1.2

		//src.Overlays-=Overlays
		src.Overlays+=usr.overlays
		usr.overlays-=usr.overlays

		if(src.gender=="male"||"asexual")
			src.icon='Bojack Expand.dmi'
		if(src.gender=="female")
			src.icon='Bojack Expand Female.dmi'
		if(isnull(src.transformation_event))
			src.transformation_event = new(skills_scheduler, src)
			skills_scheduler.schedule(src.transformation_event, 20)
mob/proc/Hybrid()
	if(src.Roid_Power||src.Artificial_Power) return
	if(!src.transing&&src.Hybrid_Build==2&&!src.Hybrid_Trans&&src.Base>=src.Hybrid_Req)
		src.transing=1
		src.Hybrid_Trans=1
		src.BP_Multiplier*=2

		src.Pow*=1.1
		src.PowMod*=1.1
		src.SpdMod*=1.1
		src.Off*=1.1
		src.OffMod*=1.1
		src.Str*=1.1
		src.StrMod*=1.1
		src.End*=1.1
		src.EndMod*=1.1
		src.Regeneration*=1.1

		src.overlays+=/obj/hybrid_aura
		if(isnull(src.transformation_event))
			src.transformation_event = new(skills_scheduler, src)
			skills_scheduler.schedule(src.transformation_event, 20)
mob/proc/Ki_Burst()
	if(src.Roid_Power||src.Artificial_Power) return
	if(!src.transing&&src.Ki_Build==2&&!src.Ki_Trans&&src.Base>=src.Ki_Req)
		src.transing=1
		src.Ki_Trans=1
		src.BP_Multiplier*=2

		src.Pow*=1.2
		src.PowMod*=1.2
		src.SpdMod*=1.2
		src.Off*=1.2
		src.OffMod*=1.2

		src.overlays+='Ki burst trans2.dmi'
		if(isnull(src.transformation_event))
			src.transformation_event = new(skills_scheduler, src)
			skills_scheduler.schedule(src.transformation_event, 20)

mob/proc/Alien_Revert()

	if(src.Hybrid_Trans==1)
		src.BP_Multiplier/=2

		src.Str/=1.1
		src.StrMod/=1.1
		src.End/=1.1
		src.EndMod/=1.1
		src.Pow/=1.1
		src.PowMod/=1.1
		src.SpdMod/=1.1
		src.Off/=1.1
		src.OffMod/=1.1
		src.Regeneration/=1.1

		src.transing=0
		src.overlays -=/obj/hybrid_aura
		src.Hybrid_Trans=0

	if(src.Melee_Trans==1)
		src.BP_Multiplier/=2

		src.Str/=1.2
		src.StrMod/=1.2
		src.End/=1.2
		src.EndMod/=1.2

		src.transing=0
		src.Regeneration/=1.2
		src.icon=src.oicon
		src.Melee_Trans=0

	if(src.Ki_Trans==1)
		src.BP_Multiplier/=2

		src.Pow/=1.2
		src.PowMod/=1.2
		src.SpdMod/=1.2
		src.Off/=1.2
		src.OffMod/=1.2

		src.transing=0
		src.overlays-='Ki burst trans2.dmi'
		src.Ki_Trans=0

mob/proc/SSj()
	if(Roid_Power||Artificial_Power) return
	if(!transing&&!ssj)
		transing=1
		ssj=1
		if(!ismystic) Super_Saiyan_Effects()
		Super_Hair()
		BP_Multiplier*=ssjmult
		Zenkai_Power*=ssjmult
		//SSjPower+=ssjadd
		Recovery/=1.2
		KaiokenMod*=10
		transing=0

		if(isnull(src.transformation_event))
			src.transformation_event = new(skills_scheduler, src)
			skills_scheduler.schedule(src.transformation_event, 20)
			//for (var/mob/player/M in Players)
				//if (src != M)
					//M.Cancel_Transformation()


mob/proc/SSj2() if(!transing&&ssj==1&&Class!="Legendary")
	transing=1
	ssj=2
	//if(!hasssj2) ssj2at*=0.2
	if(!ismystic) Super_Saiyan_2_Effects()
	Super_Hair()
	Super_Sparks()
	BP_Multiplier*=ssj2mult
	Zenkai_Power*=ssj2mult
	//SSjPower+=ssj2add
	transing=0

	if(isnull(src.transformation_event))
		src.transformation_event = new(skills_scheduler, src)
		skills_scheduler.schedule(src.transformation_event, 20)
		//for (var/mob/player/M in Players)
			//if (src != M)
				//M.Cancel_Transformation()


mob/proc/SSj3() if(!transing&&ssj==2)
	transing=1
	ssj=3
	Super_Saiyan_3_Effects()
	Super_Sparks()
	Super_Hair()
	BP_Multiplier*=ssj3mult
	Zenkai_Power*=ssj3mult
	transing=0
	if(isnull(src.transformation_event))
		src.transformation_event = new(skills_scheduler, src)
		skills_scheduler.schedule(src.transformation_event, 20)
		//for (var/mob/player/M in Players)
			//if (src != M)
				//M.Cancel_Transformation()

mob/proc/SSj4() if(!transing&&ssj==3)
	transing=1
	ssj=4
	Super_Saiyan_4_Effects()
	Super_Sparks()
	BP_Multiplier*=ssj4mult
	Zenkai_Power*=ssj4mult
	//SSjPower=ssjadd+ssj2add
	SpdMod*=2
	Recovery*=0.1
	MaxAnger*=0.5
	Regeneration*=2
	transing=0
	var/list/Old_Overlays=new
	overlays-=hair
	Old_Overlays.Add(overlays)
	overlays-=overlays
	overlays+='SSj4 Overlay.dmi'
	overlays+=Old_Overlays
	Super_Hair()

mob/proc/Changeling_Forms() if(Race=="Changeling")
	if(Form==2&&BP>=Form4At)
		Form=3
		FormPower     += Form4Add // Is 0 by default, merely there for Event edit purposes
		BP_Multiplier *= Form4Mult
		Recovery/=1.5
		icon=Form4Icon
		overlays-=overlays
		view(8,src) << "[src] transform into their fourth form!"
	if(Form==1&&BP>=Form3At)
		Form=2
		FormPower     += Form3Add // Is 0 by default, merely there for Event edit purposes
		BP_Multiplier *= Form3Mult
		Recovery/=1.5
		icon=Form3Icon
		overlays-=overlays
		view(8,src) << "[src] transform into their third form!"
	if(!Form&&BP>=Form2At)
		Form=1
		FormPower     += Form2Add // Is 0 by default, merely there for Event edit purposes
		BP_Multiplier *= Form2Mult

		Recovery/=1.5
		icon=Form2Icon
		overlays-=overlays
		view(8,src) << "[src] transform into their second form!"


obj/Third_Eye
	desc="Third Eye is a relatively simplistic Human ability, but it can be extremely hard to attain \
	for most Humans. What it does is unlock your third eye chakra, like Tien.\
	It will decrease your regeneration by 20%, and also decrease your rate of Recovery by 20% due to \
	a tax on your concentration and energy flow. There is also a large increase in power, but a deduction in anger. Further more, using this makes you able to see in many directions at once and even through walls, thus \
	increasing your ability to fight offensively and defensively by 10%. There is also a slight 10% increase in speed."
	verb/Third_Eye()
		set category="Skills"
		if(!usr.thirdeye)
			usr.BP_Multiplier *= 1.7
			usr.MaxAnger /= 1.2
			usr.Regeneration/=1.2
			usr.Recovery/=1.2
			usr.SpdMod*=1.1
			usr.OffMod*=1.1
			usr.Off*=1.1
			usr.DefMod*=1.1
			usr.Def*=1.1
			usr.sight |= (SEE_MOBS|SEE_OBJS|SEE_TURFS)
			usr.overlays+='Third Eye.dmi'
			usr<<"You concentrate on the power of your mind and unlock your third eye chakra, increasing your power significantly."
			usr.thirdeye=1
		else
			usr.Third_Eye_Revert()
mob/proc/Third_Eye_Revert() if(thirdeye)
	src.BP_Multiplier/=1.7
	src.MaxAnger*=1.2
	src.Regeneration*=1.2
	src.Recovery*=1.2
	src.SpdMod/=1.1
	src.OffMod/=1.1
	src.Off/=1.1
	src.DefMod/=1.1
	src.Def/=1.1
	src.sight = 0
	overlays-='Third Eye.dmi'
	src<<"You repress the power of your third eye chakra."
	thirdeye=0
mob/proc/Super_Alien() if(!transing)
	transing=1
	Super_Saiyan_Effects()
	if(!Form)
		if(Tail)
			var/T='Tail.dmi'
			T+=rgb(100,200,200)
			overlays-=T
			overlays+=T
		overlays-=hair
		overlays+=ssjhair
		BP_Multiplier*=ssjmult
		Zenkai_Power*=ssjmult
		Form=1
	transing=0
mob/proc/Quake()
	var/duration=rand(10,50)
	if(client) while(duration)
		duration-=1
		for(var/mob/player/M in view(src)) if(M.client)
			M.client.pixel_x+=rand(-8,8)
			M.client.pixel_y+=rand(-8,8)
			if(!duration)
				M.client.pixel_x=0
				M.client.pixel_y=0
		sleep(1)
mob/proc/MoonQuake()
	var/duration=rand(10,45)
	if(client) while(duration)
		duration-=1
		for(var/mob/player/M in view(src)) if(M.client)
			M.client.pixel_x+=rand(-5,5)
			M.client.pixel_y+=rand(-5,5)
			if(!duration)
				M.client.pixel_x=0
				M.client.pixel_y=0
mob/proc/Changeling_Revert()
	Expand_Revert()
	switch(Form)
		if(1)
			icon=Form1Icon
			Form=0
			BP_Multiplier /= Form2Mult
			FormPower     -= Form2Add
			Recovery*=1.5

		if(2)
			icon=Form2Icon
			Form=1
			BP_Multiplier /= Form3Mult
			FormPower     -= Form3Add
			Recovery*=1.5

		if(3)
			icon=Form3Icon
			Form=2
			BP_Multiplier /= Form4Mult
			FormPower     -= Form4Add
			Recovery*=1.5

mob/proc/Super_Saiyan_Effects()
	if(ssjdrain<160)
		spawn for(var/area/A in view(src)) A.Super_Darkness()
		spawn for(var/area/NPC_AI/A in view(src)) A.Super_Darkness()
	if(ssjdrain<220) spawn for(var/turf/A in view(10,src)) if(prob(10))
		A.Rising_Rocks()
		sleep(10)
	var/Quakes=5
	if(ssjdrain>160) Quakes=3
	if(ssjdrain>180) Quakes=2
	if(ssjdrain>200) Quakes=1
	if(ssjdrain>220) Quakes=0
	spawn while(Quakes)
		sleep(rand(30,100))
		Quakes-=1
		for(var/mob/A in view(20,src)) if(A.client) spawn A.Quake()
	if(ssjdrain<160) spawn Super_Lightning()
	var/Amount=10
	if(ssjdrain>160) Amount=5
	if(ssjdrain>180) Amount=3
	if(ssjdrain>200) Amount=2
	if(ssjdrain>220) Amount=1
	if(ssjdrain>240) Amount=0
	while(Amount)
		Amount-=1
		overlays-=hair
		overlays+=ssjhair
		sleep(rand(1,3))
		overlays-=ssjhair
		overlays+=hair
		sleep(rand(1,50))
	overlays+=/obj/Auras_Special/SSJ1
	if(ssjdrain<200) new/obj/BigCrater(loc)
	if(ssjdrain<240) spawn for(var/turf/A in view(10,src)) if(prob(20)) A.Rising_Rocks()
mob/proc/Super_Saiyan_2_Effects() Super_Saiyan_Effects()
mob/proc/Super_Saiyan_3_Effects() Super_Saiyan_Effects()
mob/proc/Super_Saiyan_4_Effects() Super_Saiyan_Effects()
area/proc/Super_Darkness()
	var/A=icon
	icon='Weather.dmi'
	icon_state="Super Darkness"
	spawn(600) if(src)
		icon=A
		icon_state=null
mob/proc/Super_Lightning()
	var/Amount=10
	var/list/Locs=new
	for(var/turf/B in range(20,src)) Locs+=B
	while(Amount)
		Amount-=1
		var/obj/Lightning_Strike/A=new
		A.loc=pick(Locs)
		sleep(rand(1,50))