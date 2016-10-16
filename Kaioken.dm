
mob/proc/Kaioken_Gain() gain+=gainget*10
obj/Kaioken
	desc="Kaioken is a masterable skill. The more past your mastery you use the faster you \
	master it. Kaioken can only be set to a maximum of 20, but you can master beyond 20. But since \
	your mastery past that is ever-higher than the max amount you can use, your mastery slows \
	further and further past 20. The amount of power you gain per level depends on your mastery, \
	that is why mastering it is important, a person with 1x mastery using 1x will get about 1000 \
	power, a person with 20 mastered who uses 1x will get about 20000 power for instance. Kaioken \
	will drain your health when using it, you can decrease the amount it drains \
	by mastering it further, but each level adds more drain to be mastered. While in Kaioken, not \
	only will your power increase, but your movement speed will also greatly increase, but you will \
	lose a lot of defense as well. Also while using this your combo chance will automatically go \
	to 100%, despite what it is when your not using Kaioken. Using more than double your mastery and \
	running out of health will kill you"
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(A,2000)
	verb/Kaioken()
		set category="Skills"
		if(usr.KaiokenBP) usr.KaiokenRevert()
		else if(!usr.KaiokenBP&&usr.icon_state!="KO")
			for(var/obj/Power_Control/A in usr) if(A.Powerup) return
			if(usr.ssj&&usr.BP<100000000&&usr.ssjdrain<300)
				usr<<"To use this in a Super Saiyan form you must have more than 100'000'000 bp in the form and have \
				Super Saiyan mastered."
				return
			var/amount=input("Kaioken multiple. (You have Kaioken x[round(usr.Kaioken)] mastered). x20 is the maximum ever.") as num
			if(amount<1) amount=1
			if(amount>20) amount=20
			amount=round(amount)
			if(!usr.KaiokenBP)
				if(amount>usr.Kaioken*0.5)
					usr.overlays+='Aura Kaioken.dmi'
					view(usr)<<"A bright red aura focuses around [usr]."
					for(var/mob/player/M in view(usr)) if(M.client) M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | A bright red aura focuses around [key_name(usr)]<br>")
				else usr<<"You begin using Kaioken, an aura does not appear because this level of kaioken is effortless to you."
				usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] uses Kaioken.<br>")
				usr.KaiokenBP=1000*usr.Kaioken*amount*usr.BPMod*usr.KaiokenMod
				usr.Spd*=2
				usr.SpdMod*=2
				usr.Def*=0.5
				usr.DefMod*=0.5
				usr.Zanzoken+=1000
mob/proc/KaiokenRevert() if(KaiokenBP)
	src<<"You stop using Kaioken."
	KaiokenBP=0
	Spd*=0.5
	SpdMod*=0.5
	Def*=2
	DefMod*=2
	Zanzoken-=1000
	overlays-='Aura Kaioken.dmi'
mob/proc/Body_Parts()
	var/Amount=10
	var/list/Turfs=new
	for(var/turf/A in view(src)) if(!A.density) Turfs+=A
	while(Amount&&Turfs)
		if(locate(/turf) in Turfs)
			var/obj/Body_Part/A=new
			A.name="[src] chunk"
			A.loc=pick(Turfs)
			Amount-=1
			break
		else return
obj/Body_Part
	icon='Body Parts.dmi'
	Savable=0
	New()
		spawn(rand(2000,4000)) del(src)
		pixel_y+=rand(-16,16)
		pixel_x+=rand(-16,16)
		dir=pick(NORTH,SOUTH,EAST,WEST,NORTHEAST,SOUTHEAST,NORTHWEST,SOUTHWEST)
		//..()