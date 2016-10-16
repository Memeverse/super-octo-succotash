

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
		//if(prob(10)&&Level<1) Level++
		if(prob(10)&&Experience<1) Experience+=0.1
		usr.Ki-=50
		usr.attacking=3
		charging=1
		usr.overlays+='Black Hole.dmi'
		sleep(40/usr.SpdMod)
		usr.overlays-='Black Hole.dmi'
		var/obj/ranged/Blast/A=new
		A.Belongs_To=usr
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
				usr.Decline+= 10
	verb/DeVoid()
		set category="Skills"
		var/list/People=new
		People+="Cancel"
		for(var/mob/player/A in Players) if(A.Void_Power) People+=A
		var/mob/B=input("Remove Void powers from who?") in People
		if(B=="Cancel") return
		B.DeVoidify()
		usr.Decline-=10

mob/proc/Voidify()
	Void_Power+=Base*20
	Void_Power+= 10000
	if(Void_Power>100000) Void_Power=100000
	Decline-=10

mob/proc/DeVoidify()
	Void_Power=0
	Decline+= 10

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
		Belongs_To=null
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