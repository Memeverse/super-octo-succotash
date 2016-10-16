obj/Attacks/Kienzan
	Fatal=1
	Difficulty=2
	Level=0
	Experience=1
	icon='Blast - Destructo Disk.dmi'
	desc="This attack is much like Charge at its core with some differences. Kienzan takes longer to \
	charge, is completely undeflectable, has a higher velocity, it is slightly more powerful than Charge, it also \
	drains much more energy to use."
	verb/Kienzan()
		set category="Skills"
		if(Level>1) Level=1
		if((usr.icon_state in list("Meditate","Train","KO","KB"))||usr.Frozen) return
		if(usr.attacking|usr.Ki<160) return
		if(!Learnable)
			Learnable=1
			spawn(100) Learnable=0
		if(prob(10)&&Level<1) Level++
		if(prob(10)&&Experience<1) Experience+=0.1
		usr.Ki-=160
		usr.attacking=3
		charging=1
		var/image/O=image(icon=icon,pixel_y=24)
		usr.overlays+=O
		hearers(6,usr) << 'Kienzan_Charge.wav'
		sleep(120/usr.SpdMod/Experience)
		usr.overlays-=O
		var/obj/ranged/Blast/A=new
		hearers(6,usr) << 'Kienzan Fire.wav'
		A.Deflectable=0
		A.Belongs_To=usr
		A.icon=icon
		A.Damage=250*usr.BP*usr.Pow*Ki_Power
		A.Power=250*usr.BP*Ki_Power
		A.Offense=usr.Off
		A.Explosive=Level
		A.dir=usr.dir
		A.loc=usr.loc
		step(A,A.dir)
		if(A) walk(A,A.dir,1)
		usr.attacking=0
		charging=0
