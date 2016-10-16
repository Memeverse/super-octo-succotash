var/WingsOn
/* GENETICS
mob/proc/Tail_Add()

	for(var/obj/DNA/dna in src.DNAs)
		if(dna.name == "Saiyan DNA")

			src<<"Your tail grew back!"
			if(!HairColor)
				var/T='Tail.dmi'
				for(var/obj/Oozaru/O in src) if(!O.Setting) T='Tail 2.dmi'
				T+=rgb(40,0,0)
				overlays+=T
			else
				var/T='Tail.dmi'
				for(var/obj/Oozaru/O in src) if(!O.Setting) T='Tail 2.dmi'
				T+=HairColor
				overlays+=T
			break
			Tail=1
			*/
mob/proc/Tail_Add() if(Race=="Saiyan"|Race=="Half-Saiyan")
	src<<"Your tail grew back!"
	if(!HairColor)
		var/T='Tail.dmi'
		for(var/obj/Oozaru/O in src) if(!O.Setting) T='Tail 2.dmi'
		T+=rgb(40,0,0)
		overlays+=T
	else
		var/T='Tail.dmi'
		for(var/obj/Oozaru/O in src) if(!O.Setting) T='Tail 2.dmi'
		T+=HairColor
		overlays+=T
	Tail=1


mob/proc/Neko_Add() if(Race=="Tsufurujin")
	src<<"Replaced ears!"
	var/T='TaranianEars.dmi'
	overlays+=T


mob/proc/Tail_Remove()
	Tail=0
	var/T='Tail.dmi'
	for(var/obj/Oozaru/O in src) if(!O.Setting) T='Tail 2.dmi'
	if(HairColor) T+=HairColor
	overlays-=T
	T='Tail.dmi'
	for(var/obj/Oozaru/O in src) if(!O.Setting) T='Tail 2.dmi'
	T+=rgb(40,0,0)
	overlays-=T
	Oozaru_Revert()

mob/proc/Oozaru_Revert() for(var/obj/Oozaru/O in src) if(O.suffix)
	O.suffix=0
	icon=O.icon
	var/image/A=image(icon='GlowEyes.dmi')
	//var/image/B=image(icon='Oozarou Gold.dmi',icon_state="head",pixel_y=32)
	var/image/B=image(icon='CustomAura.dmi')
	overlays.Remove(A,A,B)
	BP_Multiplier/=2
	Def*=2
	DefMod*=2
	End/=1.5
	EndMod/=1.5
	//overlays.Add(Overlays)
	//Overlays.Remove(Overlays)

mob/proc/Oozaru() for(var/obj/Oozaru/O in src) if(!O.suffix&&Tail&&!ssj&&!Dead)
	for(var/obj/items/Power_Armor/A in src)
		if(A.suffix)
			src.Eject(A)
	O.suffix="Active"
	O.icon=icon
	//overlays.Remove(overlays)
	//Overlays.Add(overlays)
	//spawn(rand(1,100)) for(var/mob/A in view(20,src))
		//var/sound/S=sound('Roar.wav')
		//A<<S
	var/image/A=image(icon='GlowEyes.dmi') //pixel_y=32
//	icon='Oozbody.dmi'
	var/image/B=image(icon='CustomAura.dmi')
	//spawn while(OozaruQuakes)
		//sleep(rand(10,30))
		//OozaruQuakes-=1
		//for(var/mob/C in view(13,src)) if(C.client) spawn C.Quake()
	overlays-=A
	overlays-=B
	overlays+=A
	overlays+=B
	BP_Multiplier*=2
	Def*=0.5
	DefMod*=0.5
	End*=1.5
	EndMod*=1.5
	spawn(6000) Oozaru_Revert()

mob/proc/Golden() for(var/obj/Oozaru/O in src) if(!O.suffix&&Tail&&!Dead)
	Oozaru_Revert()
	O.suffix="Active"
	O.Icon=icon
	Overlays.Add(overlays)
	overlays.Remove(overlays)
	//spawn(rand(1,100)) for(var/mob/A in view(20,src))
		//var/sound/S=sound('Roar.wav')
		//A<<S
	var/image/A=image(icon='Oozarou Gold.dmi',icon_state="head",pixel_y=32)
	icon='Oozarou Gold.dmi'
	overlays+=A
	BP_Multiplier*=10
	Def*=0.01
	DefMod*=0.01
	Spd*=0.5
	SpdMod*=0.5
	spawn while(src&&icon=='Oozarou Gold.dmi'&&usr.Hasssj < 4)
		if(prob(0.5))
			Oozaru_Revert()
			usr.Hasssj = 4
			SSj4()
		sleep(10)
	spawn(3000) Oozaru_Revert()

obj/Oozaru
	desc="Turns you into a large ape every full moon. Your power increases drastically, but some \
	things decrease, such as speed and defense."
	var/Setting=1
	var/Icon
	verb/Moon_Toggle()
		set category="Other"
		if(!usr.Tail) return
		usr.Tail_Remove()
		if(Setting)
			Setting=0
			usr<<"You decide not to look at the full moon if it comes out"
		else
			Setting=1
			usr<<"You decide to look at the moon if it comes out"
		/* GENETICS
		for(var/obj/DNA/dna in usr.DNAs)
			if(dna.name == "Saiyan DNA")
				usr.Tail_Add()
				break */
		usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] decides to [Setting ? "look" : "not look"] at the moon.\n")

/*mob/proc/Wings_Remove()
	var/A='CelestialNS.dmi'
	overlays-=A
	overlays-=B
	overlays-=C

obj/Toggle_Wings
	desc="Allows you to toggle wings on and off."
	verb/Toggle_Wings()
		set category="Other"
		usr.Wings_Remove()*/



/*mob/proc/AngelWings()
	var/image/A=image(icon='CelestialNS.dmi',pixel_x=-14,pixel_y=-9, layer=4)
	var/image/B=image(icon='CelestialE.dmi',pixel_x=-26,pixel_y=-11,layer=4)
	var/image/C=image(icon='CelestialW.dmi',pixel_x=0,pixel_y=-11,layer=4)
	overlays.Add(A,B,C)*/