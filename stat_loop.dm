mob/proc/Regenerate()
	loc=locate(250,250,15)
	spawn(1200/Regenerate) if(src)
		loc=locate(savedX,savedY,savedZ)
		for(var/mob/A in view(src)) if(A.name=="Body of [src]") del(A)
		src<<"[src] regenerates back to life!"
		Regenerating=0
		flick("Regenerate",src)

/*
mob/proc/Experience_Transferrence() while(src&&(client||adminObserve))
	sleep(600)
	for(var/mob/player/A in oview(src)) if(Gain_Multiplier<A.Gain_Multiplier*0.2) Gain_Multiplier=A.Gain_Multiplier*0.2
*/

mob/proc/Steroid_Wearoff() while(src&&(client||adminObserve))
	if(Roid_Power)
		Roid_Power*=0.99
		if(Roid_Power<=10) Roid_Power=0
	else break
	sleep(1200)
/*
mob/proc/T_Fusion_Wearoff() while(src&&(client||adminObserve))
	sleep(1200)
	if(Zombie_Power)
		Zombie_Power*=0.99
		if(Zombie_Power<5000*BPMod) Zombie_Power=0
*/

mob/proc/Bind_Return() while(src&&(client||adminObserve))
	if(key in Noobs) if(z!=6)
		src<<"You are deemed an ooc threat by the roleplayer alliance therefore you cannot leave hell."
		loc=locate(410,290,6)
	else if(z!=6&&locate(/obj/Curse) in src)
		if(src.insidePhylactery == null) if(src.insideTank == null)
			src<<"The bind on you takes effect and you are returned to hell."
			loc=locate(410,290,6)
	if(!locate(/obj/Curse) in src) break
	sleep(1200)

mob/proc/Power_Giving_Reset() while(src&&(client||adminObserve))
	if(GavePower)
		sleep(9000)
		GavePower=0
	else break

mob/proc/Senzu_Wearoff(var/obj/S)
	if(S) del(S)
	while(src&&(client||adminObserve))
		if(prob(5)&&Senzu) Senzu-=1
		if(Senzu<=0){Senzu=0;break}
		if(Senzu>=10) Senzu=10
		sleep(50)

mob/proc/Walking_In_Space() while(src&&(client||adminObserve))
	sleep(500)
	var/turf/Turf=loc
	if(istype(Turf,/turf/Other/Stars)&&!Lungs)
		var/Shielding
		for(var/obj/Shield/A in src) if(A.Using)
			Shielding=1
			//Ki-=100
		if(!Shielding)
			if(istype(Turf,/turf/Other/Stars))
				spawn
					Death("space")
	else break

mob/proc/Faction_Update() while(src&&(client||adminObserve))
	sleep(3000)
	FactionUpdate()

mob/proc/Poisoned_Check() while(src&&client)
	//Poisoned
	if(Poisoned)
		sleep(50)
		if(Poisoned>Immunity) Health-=(Poisoned-Immunity)
		if(prob(1))
			Poisoned-=1
			Immunity++
	else break

mob/proc/Healing() if(!Dead||(Dead&&z in list(5,6,7,13,15)))
	if(Health<50) Zenkai()
	if(icon_state!="KO")
		if(Health<100)
			if(!(prob(50)&&Artificial_Power))
				Health+=0.1*Regeneration*(1+Senzu)*(Base/(Base+(Absorb*2)+(Roid_Power*2)))
			if(Health>100)
				Health=100
				sleep(1)
		for(var/obj/Focus/A in src) if(A.Using) return
		if(/*icon_state!="Flight"&&*/icon_state!="Train"&&!attacking&&BPpcnt<=100&&Ki<MaxKi)
			if(!(prob(50)&&Artificial_Power))
				Ki+=0.002*MaxKi*Recovery*(1+Senzu)*(Base/(Base+(Absorb*2)+(Roid_Power*2)))
			if(Ki>MaxKi) Ki=MaxKi

mob/proc/Available_Power()
	if(src.Senzu)
		if(src.Senzu >= 6)
			src.Senzu = 6
		src.Senzu -=(1/3000)
		if(src.Senzu <= 0.1)
			src.Senzu = 0
	if(src.Poisoned)
		src.Poisoned -= 0.001
		if(src.Poisoned <= 0.1)
			src.Poisoned = 0
	if(BPpcnt<0.01) BPpcnt=0.01
	if(Ki<0) Ki=0
	if(Age<0) Age=0
	if(Real_Age<0) Real_Age=0

	if(Gravity<=10&&Health<0) Health=0
		//if(Health<0) Health=0

	if(RP_Power<1)	RP_Power=1
	Body()
	if(Artificial_Power<0) Artificial_Power=0
	if(FormPower<0) FormPower=0
	if(SSjPower<0) SSjPower=0
	var/Health_Multiplier=Health/100
	var/Energy_Multiplier=Ki/MaxKi
	if(icon_state=="KO" || NoLoss)  //src.Race == "Android"  Null bug / null var bug edit
		Health_Multiplier=1
		Energy_Multiplier=1
	if(Anger>100&&Anger_Restoration) Health_Multiplier=1
	//var/Gravity_Multiplier=sqrt(sqrt(GravMastered))
	BP=0.3*RP_Power*BP_Multiplier*Base*Body*Energy_Multiplier*Health_Multiplier*(BPpcnt/100)*(Anger/100)/Weight//*Gravity_Multiplier  //Gives inherent bonus for grav mastered.
	BP+=BP_Multiplier*(MakyoPower*0.05)*Energy_Multiplier*Health_Multiplier*(BPpcnt/100)*(Anger/100)/Weight
	//BP+=(Zombie_Power*0.05)/Weight
	BP+=Roid_Power*Energy_Multiplier*Health_Multiplier*(BPpcnt/100)*(Anger/100)/Weight
	BP+=BP_Multiplier*FormPower*Energy_Multiplier*Health_Multiplier*(BPpcnt/100)*(Anger/100)/Weight
	BP+=WishPower*Energy_Multiplier*Health_Multiplier*(BPpcnt/100)
	BP+=Absorb*Energy_Multiplier*Health_Multiplier/Weight
	BP+=BP_Multiplier*(KaiokenBP*0.05)*(Anger/100)
	BP+=BP_Multiplier*SSjPower*(BPpcnt/100)*(Anger/100)
	var/Artificial_Energy=1
	if(Ki>MaxKi) Artificial_Energy=Ki/MaxKi
	BP+=Artificial_Power*Artificial_Energy
	BP+=Modules*100
	BP+=Overdrive_Power
	BP+=Cosmic_Power
	BP+=Void_Power
	BP+=Shadow_Power
	if(BP<1) BP=1
	if(key in Noobs) BP=1

mob/proc/Dead_In_Living_World()
	if(Dead&&Check_Dead_Location())
		if(Ki<MaxKi*0.1&&Ki>0)
			Ki=0
			src<<"You have exhausted all your energy, you will return to the afterlife in 1 minute."
			spawn(600) if(src)
				view(src)<<"[src] is returned to the afterlife due to lack of energy."
				loc=locate(170,190,5)

mob/proc/Check_Dead_Location()
	var/turf/t = locate(src.x, src.y, src.z) // Locate returns a turf.
	if(!t) return
	var/area/whereami = t.loc // A turf's location is the area it's in.
	if(z==2 && istype(whereami,/area/Afterlife) ) return FALSE
	if( !(z in list(5,6,7,9,13,15)) ) return TRUE
	else return FALSE
