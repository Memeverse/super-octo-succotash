mob/proc/Regenerate()
	loc=locate(250,250,15)
	spawn(1200/Regenerate) if(src)
		loc=locate(savedX,savedY,savedZ)
		for(var/mob/A in view(src)) if(A.name=="Body of [src]") del(A)
		src<<"[src] regenerates back to life!"
		Regenerating=0
		flick("Regenerate",src)
mob/proc/Experience_Transferrence() while(src&&(client||adminObserve))
	sleep(600)
	for(var/mob/A in oview(src)) if(gain<A.gain*0.2) gain=A.gain*0.2
mob/proc/Shadow_King_Unmastered_Revert() while(src&&(client||adminObserve))
	sleep(1200)
	if(Shadow_Power)
		if(locate(/obj/Pseudo_King) in src) Pseudo_Revert()
		else if(!locate(/obj/Shadow_King) in src) Shadow_Revert()
mob/proc/Zariun_Barrier_Activated() while(src&&(client||adminObserve))
	sleep(12)
	for(var/obj/Attacks/Zariun_Barrier/A in src) if(A.Active)
		if(Ki<100) A.Active=0
		else
			spawn for(var/turf/T in oview(2,src))
				var/obj/Barrier_Fire/C=new(T)
				C.Battle_Power=BP
				C.Force=Pow
				C.Owner=usr
				sleep(1)
			Ki-=100
mob/proc/Cosmic_Barrier_Activated() while(src&&(client||adminObserve))
	sleep(12)
	for(var/obj/Attacks/Cosmic_Barrier/A in src) if(A.Active)
		if(Ki<500) A.Active=0
		else
			spawn for(var/turf/T in oview(2,src))
				var/obj/Cosmic_Fire/C=new(T)
				C.Battle_Power=BP
				C.Force=Pow
				C.Owner=usr
				sleep(1)
			Ki-=500
mob/proc/Void_Barrier_Activated() while(src&&(client||adminObserve))
	sleep(12)
	for(var/obj/Attacks/Void_Barrier/A in src) if(A.Active)
		if(Ki<100) A.Active=0
		else
			spawn for(var/turf/T in oview(2,src))
				var/obj/Void_Fire/C=new(T)
				C.Battle_Power=BP
				C.Force=Pow*0.5
				C.Owner=usr
				sleep(1)
			Ki-=100

mob/proc/LSD_Recovery() while(src&&(client||adminObserve))
	sleep(2400)
	if(client&&client.dir!=NORTH)
		src<<"The LSD wears off..."
		client.dir=NORTH

mob/proc/Steroid_Wearoff() while(src&&(client||adminObserve))
	sleep(1200)
	if(Roid_Power)
		Roid_Power*=0.99
		if(Roid_Power<=10) Roid_Power=0
/*
mob/proc/T_Fusion_Wearoff() while(src&&(client||adminObserve))
	sleep(1200)
	if(Zombie_Power)
		Zombie_Power*=0.99
		if(Zombie_Power<5000*BPMod) Zombie_Power=0
*/

mob/proc/Bind_Return() while(src&&(client||adminObserve))
	sleep(1200)
	if(key in Noobs) if(z!=6)
		src<<"You are deemed an ooc threat by the roleplayer alliance therefore you cannot leave hell"
		loc=locate(410,290,6)
	else if(z!=6&&z!=15&&locate(/obj/Curse) in src)
		src<<"The bind on you takes effect and you are returned to hell"
		loc=locate(410,290,6)

mob/proc/Power_Giving_Reset() while(src&&(client||adminObserve))
	sleep(9000)
	GavePower=0

mob/proc/Flying_Loop() while(src&&(client||adminObserve))
	sleep(20)
	if(icon_state=="Flight")
		var/Cyber_Flight
		for(var/obj/Cybernetics/Antigravity/A in src)
			if(A.suffix)
				Cyber_Flight=1
				break
		if(!Cyber_Flight)
			if(Ki>2+(MaxKi*0.5/FlySkill/KiMod) && client.inactivity<=3000)
				Flying_Gain()
				if(Super_Fly)
					Ki -= 18+((MaxKi*0.5)/(FlySkill/20)/KiMod)
					FlySkill += (0.6*FlyMod)
				else
					Ki -= 2+((MaxKi*0.5)/FlySkill/KiMod)
					FlySkill += (0.2*FlyMod)
			else
				src<< "You stop flying."
				Ki = max(0,Ki)	//don't want negatives
				Flight_Land()
		else for(var/obj/Cybernetics/Generator/A in src)
			if(A.suffix)
				if(A.Current>=10)
					A.Current-=10
			else
				src<< "Your generator is drained."
				Flight_Land()

mob/proc/Senzu_Wearoff() while(src&&(client||adminObserve))
	sleep(50)
	if(Senzu>10) Senzu=10
	if(Senzu<0) Senzu=0
	if(prob(5)&&Senzu) Senzu-=1

mob/proc/Walking_In_Space() while(src&&(client||adminObserve))
	sleep(500)
	if(!Lungs)
		var/Shielding
		for(var/obj/Shield/A in src) if(A.Using)
			Shielding=1
			//Ki-=100
		if(!Shielding)
			var/turf/Turf=loc
			if(istype(Turf,/turf/Other/Stars))
				spawn
					Death("space")

mob/proc/Faction_Update() while(src&&(client||adminObserve))
	sleep(3000)
	FactionUpdate()

mob/proc/Ascension_Check() while(src&&(client||adminObserve))
	sleep(3000)
	Final_Mod()

mob/proc/Status()

	spawn if(src) Experience_Transferrence()
	spawn if(src) Shadow_King_Unmastered_Revert()
	spawn if(src) Cosmic_Barrier_Activated()
	spawn if(src) Void_Barrier_Activated()
	spawn if(src) Zariun_Barrier_Activated()
	spawn if(src) LSD_Recovery()
	spawn if(src) Steroid_Wearoff()
	//spawn if(src) T_Fusion_Wearoff()
	spawn if(src) Bind_Return()
	spawn if(src) Power_Giving_Reset()
	spawn if(src) Flying_Loop()
	spawn if(src) Senzu_Wearoff()
	spawn if(src) Walking_In_Space()
	spawn if(src) Faction_Update()
	spawn if(src) Ascension_Check()
	spawn if(src) if(Regenerating) Regenerate()

	while(src&&(client||adminObserve))
		Spd=SpdMod*10
		//Final Realm instant recovery.
		if(z==15)
			if(Health<100)
				Health=100
				if(icon_state=="KO") Un_KO()
		//Majin capped powerup
		//if(Race=="Majin"&&BPpcnt>200) BPpcnt=200
		//Poisoned
		if(Poisoned)
			if(Poisoned>Immunity) Health-=(Poisoned-Immunity)
			if(prob(1))
				Poisoned-=1
				Immunity+=1

		//Shield Revert
		//Digging
		if(!Opp) Digging()
		//Taiyoken and Time Freeze
		if(sight&&prob(Regeneration)) sight=0
		//Escaping from Time Freeze
		if(Frozen&&prob(ResMod))
			Frozen=0
			overlays-='TimeFreeze.dmi'
		//Power Control
		for(var/obj/Power_Control/A in src)
			if(icon_state=="KO"&&A.Powerup)
				A.Powerup=0
				AuraOverlays()
			if(A.Powerup&&A.Powerup!=-1) BPpcnt+=1*Recovery
			else if(A.Powerup==-1) BPpcnt*=0.9
		//Train
		if(icon_state=="Train")
			if(Ki>=(1/Recovery)*(Weight**3)&&icon_state!="KO")
				Ki-=(1/Recovery)*(Weight**3)
				if(z==10) Ki-=9*(1/Recovery)*(Weight**3)
				Train_Gain()
			else
				src<<"You stop training."
				icon_state=""
				move=1
		else if(icon_state=="Meditate"||medreward)
			Med_Gain()
			Healing()
		//Attack Gain
		if(Opp) Attack_Gain()
		if(attacking==3) Blast_Gain()
		//Meditate / Healing
		if(Health<100|Ki<MaxKi)
			Healing()
		if(Health>100)
			Health=100
		//Return to Afterlife if you run out of energy in the living world
		Dead_In_Living_World()
		//Freezing weather
		Temperature_Check()
		//Gravity
		if(Gravity>GravMastered) Gravity_Gain()
		//Super Saiyan Drain
		if(ZangyaTransed)
			if(Ki>=MaxKi/burstdrain)
				if(burstdrain<300)
					if(!ismystic) Ki-=0.5*(MaxKi/burstdrain)
					burstdrain+=0.01*1
					if(z==10) burstdrain+=0.09*1
				if(Ki<=MaxKi/10&&burstdrain<300)
					Revert()
					src<<"You are too tired to sustain your form."
		if(BojackTransed)
			if(Ki>=MaxKi/bojackdrain)
				if(bojackdrain<300)
					if(!ismystic) Ki-=0.5*(MaxKi/bojackdrain)
					bojackdrain+=0.01*1
					if(z==10) bojackdrain+=0.09*1
				if(Ki<=MaxKi/10&&bojackdrain<300)
					Revert()
					src<<"You are too tired to sustain your form."
		if(ssj==1|ssj==2)
			if(Ki>=MaxKi/ssjdrain)
				if(ssjdrain<300)
					if(!ismystic) Ki-=0.5*(MaxKi/ssjdrain)
					if(Class!="Legendary")
						ssjdrain+=0.01*ssjmod
						if(z==10) ssjdrain+=0.09*ssjmod
				if(Ki<=MaxKi/10&&ssjdrain<300)
					Revert()
					src<<"You are too tired to sustain your form."
		//Super Saiyan 2 Drain
		if(ssj==2&&Ki>=MaxKi/ssj2drain)
			if(ssj2drain<300)
				if(!ismystic) Ki-=0.5*(MaxKi/ssj2drain)
				ssj2drain+=0.01*ssj2mod
				if(z==10) ssj2drain+=0.09*ssjmod
			if(Ki<=(MaxKi/10))
				Revert()
				src<<"You are too tired to sustain your form."
			if(!ismystic) Ki-=MaxKi/300
		//Super Saiyan 3 Drain
		if(ssj==3&&Ki+1>=MaxKi/ssj3drain)
			if(ssj3drain<300)
				Ki-=0.5*(MaxKi/ssj3drain)
				ssj3drain+=0.01*ssj3mod
				if(z==10) ssj3drain+=0.09*ssjmod
			if(Ki<=(MaxKi/5))
				Revert()
				src<<"You are too tired to sustain your form."
			Ki-=MaxKi/200
		//KO
		if(Health<=0&&icon_state!="KO") spawn KO("low health")
		//Focus
		for(var/obj/Focus/A in src) if(A.Using)
			if(Ki>=(MaxKi*0.004)/Recovery/KiMod) Ki-=(MaxKi*0.004)/pick(1,Recovery)/KiMod
			else Focus_Revert()
		//Beyond 100% Drain
		if(icon_state!="KO"&&BPpcnt>100)
			var/Drain=1*(BPpcnt-100)/pick(1,Recovery)
			if(Ki>=Drain*10) Ki-=Drain
			else
				BPpcnt=100
				for(var/obj/Power_Control/A in usr) A.Powerup=0
				AuraOverlays()
				if(Race in list("Saiyan","Half-Saiyan")) Revert()
				src<<"You are too tired to hold the energy you gathered, your energy levels return to normal."
		if(Ki>MaxKi) Ki*=0.998
		if(Health>100) Health*=0.998
		//Anger
		if(Anger>MaxAnger*2) Anger=MaxAnger*2
		if(Anger>100&&prob(0.1)) Calm()
		if(Health<=50&&!(icon_state in list("Meditate","Train","KO")))
			if(Last_Anger<=world.realtime-3000) Anger()
		//Limit Breaker
		if(prob(2)) for(var/obj/Limit_Breaker/A in src) if(A.Using) Limit_Revert()
		if(prob(2)&&Overdrive_Power)
			Overdrive_Power=0
			Health-=50
			for(var/obj/Cybernetics/Generator/G in src) if(G.suffix) G.Current=0
			src<<"<font color=red>System: Overdrive limit reached. Reactor is drained."
		//Kaioken
		if(KaiokenBP)
			var/Amount=KaiokenBP/1000/Kaioken/BPMod/KaiokenMod //Translates to the Amount you are using.
			//So if you have 3x mastered, and use 6x, and have 2 bp mod.
			//Your Kaioken bp is 1000 x 2 x 3 x 6, or +36'000.
			//So to to get the answer it is 36000 / 1000 / 3 / 2 = 6. Meaning your using 6x.
			if(Health>0)
				Health-=0.15*((Amount/Kaioken)**3.5) //The amount your using divided by your mastery of Kaioken.
				if(Kaioken<Amount) Kaioken+=Amount*0.001*KaiokenMod
				if(Kaioken>20) Kaioken=20
				if(Kaioken<Amount) Kaioken_Gain()
			if(Health<=0)
				src<<"The strain of Kaioken becomes too much for you"
				if(Amount>Kaioken*2)
					if(!Dead) Body_Parts()
					spawn Death("Kaioken!")
				KaiokenRevert()
		//Weighted Clothing
		var/BaseWeight=1
		for(var/obj/items/Weights/A in src) if(A.suffix) BaseWeight+=A.Weight
		Weight=(BaseWeight/(Str+End))
		if(Weight<1) Weight=1
		if(BaseWeight>1+((Str+End)*2)&&icon_state!="KO") spawn KO("wearing too heavy of weights")
		if(SpdMod<=0||!isnum(SpdMod)) SpdMod=1 // Sanity check
		if(Base<=0||!isnum(Base)) Base=1 // Sanity check
		Refire=((40/SpdMod)*Weight)/(Base/(src.Base+Roid_Power))
		//Available Power
		Available_Power()
		sleep(12)

mob/proc/Healing() if(!Dead||(Dead&&z in list(5,6,7,13,15)))
	if(Health<50) Zenkai()
	if(icon_state!="KO")
		if(Health<100)
			if(!(prob(50)&&Artificial_Power))
				Health+=0.2*Regeneration*(1+Senzu)*(Base/(Base+(Absorb*2)+(Roid_Power*2)))
			if(Health>100)
				Health=100
				sleep(1)
		for(var/obj/Focus/A in src) if(A.Using) return
		if(/*icon_state!="Flight"&&*/icon_state!="Train"&&!attacking&&BPpcnt<=100&&Ki<MaxKi)
			if(!(prob(50)&&Artificial_Power))
				Ki+=0.002*MaxKi*Recovery*(1+Senzu)*(Base/(Base+(Absorb*2)+(Roid_Power*2)))
			if(Ki>MaxKi) Ki=MaxKi

mob/proc/Available_Power()
	if(BPpcnt<0.01) BPpcnt=0.01
	if(Ki<0) Ki=0
	if(Age<0) Age=0
	if(Real_Age<0) Real_Age=0
	if(Health<0) Health=0
	if(RP_Power<1)	RP_Power=1
	Body()
	if(Artificial_Power<0) Artificial_Power=0
	if(FormPower<0) FormPower=0
	if(SSjPower<0) SSjPower=0
	var/Health_Multiplier=Health/100
	var/Energy_Multiplier=Ki/MaxKi
	if(icon_state=="KO" || src.Race == "Android")  //null var bug check
		Health_Multiplier=1
		Energy_Multiplier=1
	if(Anger>100&&Anger_Restoration) Health_Multiplier=1
	var/Gravity_Multiplier=sqrt(sqrt(GravMastered))
	BP=0.3*RP_Power*BP_Multiplier*Base*Body*Gravity_Multiplier*Energy_Multiplier*Health_Multiplier*(BPpcnt/100)*(Anger/100)/Weight
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

mob/proc/Dead_In_Living_World() if(Dead&&Ki<MaxKi*0.1&&Ki>0) if(!(z in list(5,6,7,13,15)))
	Ki=0
	src<<"You have exhausted all your energy, you will return to the afterlife in 1 minute"
	spawn(600) if(src)
		view(src)<<"[src] is returned to the afterlife due to lack of energy"
		loc=locate(170,190,5)