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
obj/hybrid_aura
	icon = 'Blue Aura.dmi'
	pixel_x = -32
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
		Belongs_To=null
		..()
	proc/Barrier_Fire() while(src)
		for(var/mob/A in range(0,src)) if(A!=Owner)
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