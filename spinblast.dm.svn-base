obj/Attacks/Spin_Blast
	Fatal=1
	Difficulty=1
	Experience=1
	icon='1.dmi'
	desc="An attack that becomes more rapid as your skill with it develops, and shoots in multiple \
	directions easily."
	verb/SpinBlast()
		set category="Skills"
		if((usr.icon_state in list("Meditate","Train","KO","KB"))||usr.Frozen) return
		if(usr.attacking|usr.Ki<1) return
		if(!Learnable)
			Learnable=1
			spawn(100) Learnable=0
		usr.Ki-=1
		if(prob(50))
			usr.attacking=3
			var/Delay=100/Experience/usr.SpdMod
			if(Delay<1) Delay=1
			spawn(Delay) usr.attacking=0
		Experience+=0.01
		var/obj/ranged/Blast/A=new
		A.Belongs_To=usr
		A.pixel_x=rand(-16,16)
		A.pixel_y=rand(-16,16)
		A.icon=icon
		A.Damage=4*usr.BP*usr.Pow*Ki_Power
		A.Power=4*usr.BP*Ki_Power
		A.Offense=usr.Off
		A.Shockwave=Shockwave
		A.Explosive=0
		A.dir=usr.dir
		A.loc=usr.loc
		usr.dir=turn(usr.dir,45)
		walk(A,A.dir)
		if(prob(20)) sleep(1)
		if(prob(67))
			if(A) step(A,turn(A.dir,pick(-45,0,45)))
			if(A) walk(A,pick(A.dir,turn(A.dir,45),turn(A.dir,-45)))