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
		var/obj/ranged/Blast/Dragon_Nova/A=new(get_step(src,usr.dir))
		A.loc=get_step(A,usr.dir)
		A.Belongs_To=usr
		A.Damage=150*usr.BP*usr.Pow*global.Ki_Power
		A.Power=150*usr.BP*Ki_Power
		A.Offense=usr.Off
		walk(A,usr.dir,4)
		usr.attacking=0
		charging=0
		spawn(100) if(usr.Health<0&&prob(10)) usr.Death(usr)

obj/ranged/Blast/Dragon_Nova
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