obj/Attacks/Charge
	Fatal=1
	Difficulty=2
	Level=0
	Experience=0.1
	icon='20.dmi'
	desc="An explosive one-shot energy attack that takes a few seconds to charge. With training its \
	explosiveness and refire speed can increase."
	verb/Charge()
		set category="Skills"
		if(Level>1) Level=1
		if((usr.icon_state in list("Meditate","Train","KO","KB"))||usr.Frozen) return
		if(usr.attacking|usr.Ki<20) return
		if(!Learnable)
			Learnable=1
			spawn(100) Learnable=0
		if(prob(10)&&Level<1) Level++
		if(prob(10)&&Experience<1) Experience+=0.1
		usr.Ki-=20
		usr.attacking=3
		charging=1
		var/S = pick("1","2")
		if(S == "1")
			hearers(6,usr) << 'Charging.wav'
		if(S == "2")
			hearers(6,usr) << 'Charging2.wav'
		usr.overlays+=usr.BlastCharge
		sleep(50/usr.SpdMod)
		hearers(6,usr) << 'Charge_Fire.wav'
		usr.overlays-=usr.BlastCharge
		var/obj/ranged/Blast/A=new
		A.Belongs_To=usr
		A.icon=icon
		A.Damage=20*usr.BP*usr.Pow*Ki_Power  //200
		A.Power=20*usr.BP*Ki_Power   //200
		A.Offense=usr.Off
		A.Explosive=Level
		A.dir=usr.dir
		A.loc=usr.loc
		step(A,A.dir)
		if(A) walk(A,A.dir,2)
		usr.attacking=0
		charging=0