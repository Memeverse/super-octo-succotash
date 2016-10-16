obj/Attacks/Kikoho
	Fatal=1
	Difficulty=10
	icon='16.dmi'
	desc="Similar to the charge attack, but much more powerful because it drains health and energy \
	to use it. A very strong attack. If you let it drain all your health, there is a chance you may die."
	verb/Kikoho()
		set category="Skills"
		if((usr.icon_state in list("Meditate","Train","KO","KB"))||usr.Frozen) return
		if(usr.attacking|usr.Ki<20) return
		if(!Learnable)
			Learnable=1
			spawn(100) Learnable=0
		usr.Ki-=20
		usr.Health-=20
		var/L = list("Random")
		usr.Injure_Hurt(20,L)
		usr.attacking=3
		charging=1
		var/S = pick("1","2")
		if(S == "1")
			hearers(6,usr) << 'Charging.wav'
		if(S == "2")
			hearers(6,usr) << 'Charging2.wav'
		usr.overlays+=usr.BlastCharge
		sleep(25/usr.SpdMod)
		usr.overlays-=usr.BlastCharge
		var/obj/ranged/Blast/Kikoho/A=new(get_step(src,usr.dir))
		A.loc=get_step(A,usr.dir)
		A.Belongs_To=usr
		A.Damage=250*usr.BP*usr.Pow*Ki_Power
		A.Power=250*usr.BP*Ki_Power
		A.Offense=usr.Off
		walk(A,usr.dir,2)
		usr.attacking=0
		charging=0
		spawn(100) if(usr.Health<0&&prob(10)) usr.Death(usr)


obj/ranged/Blast/Kikoho
	Piercer=0
	Explosive=1
	density=1
	New()
		var/Icon='deathball.dmi'
		Icon+=rgb(200,200,100,120)
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