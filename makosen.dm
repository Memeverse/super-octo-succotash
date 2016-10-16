obj/Attacks/Makosen
	Fatal=1
	Difficulty=50
	var/Spread=1
	var/ChargeTime=25
	var/Shots=200
	var/ShotSpeed=1
	var/SleepProb=5
	var/Deletion=8
	var/ExplosiveChance=0
	var/Explosiveness=1
	icon='27.dmi'
	desc="A very, very powerful attack, widespread and very destructive. Made up of many smaller shots \
	that inflict a lot of damage all together. It is very draining, not very long range, and has a \
	long charge time."
	verb/Makosen()
		set category="Skills"
		if((usr.icon_state in list("Meditate","Train","KO","KB"))||usr.Frozen) return
		if(usr.attacking|usr.Ki<1000) return
		if(!Learnable)
			Learnable=1
			spawn(100) Learnable=0
		usr.Ki-=1000
		usr.attacking=3
		usr.overlays+=usr.BlastCharge
		sleep(ChargeTime/usr.SpdMod)
		usr.overlays-=usr.BlastCharge
		var/Amount=Shots
		while(Amount)
			Amount-=1
			var/obj/ranged/Blast/A=new
			A.Belongs_To=usr
			A.icon=icon
			A.layer=4
			A.Damage=5*usr.BP*usr.Pow*Ki_Power
			A.Power=5*usr.BP*Ki_Power
			A.Offense=usr.Off
			if(prob(ExplosiveChance)) A.Explosive=Explosiveness
			A.dir=usr.dir
			A.pixel_x=rand(-16,16)
			A.pixel_y=rand(-16,16)
			A.loc=get_step(usr,usr.dir)
//			spawn if(A) A.Beam()
			spawn(1) if(A)
				walk(A,usr.dir,ShotSpeed)
				if(A) A.Zig_Zag(Spread,ShotSpeed)
			spawn(Deletion) if(A) del(A)
			if(prob(SleepProb)) sleep(1)
		usr.attacking=0