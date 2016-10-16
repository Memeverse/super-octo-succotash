mob/proc/Mutate(A)
	if(!A) A=rand(2,10)
	Flyer=0
	if(A==2)
		name="Zombie Dog"
		icon='Zombie Dog.dmi'
		SpdMod*=1.2
		Spawn_Delay*=2
	if(A==3)
		name="Licker"
		icon='Zombie Licker.dmi'
		Spd*=1.5
		SpdMod*=1.5
		Def*=5
		Zombied=5
		Spawn_Delay*=2
	if(A==4)
		name="Hunter"
		icon='Zombie Hunter.dmi'
		End*=2
		Res*=2
		Zombied=1
		Spawn_Delay*=2
	if(A==5)
		name="Tyrant"
		icon='Zombie Tyrant.dmi'
		Spd*=1.2
		SpdMod*=1.2
		Str*=2
		Def*=3
		End*=0.5
		Res*=0.5
		Zombied=20
		Spawn_Delay*=2
	if(A==6)
		name="Nemesis"
		icon='Zombie Nemesis.dmi'
		Str*=2
		End*=2
		Res*=2
		Def*=5
		Zombied=1
		Spawn_Delay*=2
	if(A==7)
		name="Mr X"
		icon='Zombie X.dmi'
		Spd*=1.5
		SpdMod*=1.5
		Off*=2
		Def*=10
		Zombied=10
		Spawn_Delay*=2
	if(A==8)
		name="Thanatos"
		icon='Zombie Thanatos.dmi'
		Str*=2
		End*=2
		Res*=2
		Def*=5
		Spd*=1.2
		SpdMod*=1.2
		Zombied=10
		Spawn_Delay*=2
	if(A==9)
		name="Gargoyle"
		icon='Gargoyle.dmi'
		Str*=0.5
		End*=0.5
		Res*=0.5
		SpdMod*=1.5
		Spd*=1.5
		Zombied=1
		Flyer=1
		Spawn_Delay*=2
	if(A==10)
		name="Reptile Zombie"
		icon='Reptile Monster.dmi'
		End*=0.5
		Spd*=1.5
		SpdMod*=1.5
		Zombied=1
		Spawn_Delay*=2
	Target=null //Now it can lead its own pack and not follow others.
	Level=A //This is used by the DNA detector to see what it is supposed to get from the zombie.
	overlays-=overlays
	spawn if(src&&type!=/mob/Enemy/Zombie) Hoarde()
obj/items/DNA_Container
	icon='Item, DNA Extractor.dmi'
	desc="This can be used to store DNA from whoever you use it on. Which can be used for genetic \
	engineering and possibly other stuff."
	Stealable=1
	verb/Use()
		for(var/mob/A in get_step(usr,usr.dir)) if(A.Frozen||A.icon_state=="KO")
			view(usr)<<"[usr] extracts DNA from [A]"
			if(istype(A,/mob/Enemy/Zombie))
				A.Zombie_Drop()
				del(src)
			return
		usr<<"You extract DNA from yourself"
mob/proc/Zombie_Drop()
	if(Level==1) new/obj/items/Antivirus(get_step(src,dir)) //Regular
	if(Level==2) new/obj/items/T_Energy(get_step(src,dir)) //Dog
	if(Level==3) new/obj/items/T_Heal(get_step(src,dir)) //Licker
	if(Level==4) new/obj/items/T_Vitality(get_step(src,dir)) //Hunter
	if(Level==5) new/obj/items/T_Strength(get_step(src,dir)) //Tyrant
	if(Level==6) new/obj/items/T_Fusion(get_step(src,dir)) //Nemesis
	if(Level==7) new/obj/items/T_Immunity(get_step(src,dir)) //Mr X
	if(Level==8) new/obj/items/T_Life(get_step(src,dir)) //Thanatos
	if(Level==9) new/obj/items/T_Regeneration(get_step(src,dir)) //Gargoyle
	if(Level==10) new/obj/items/T_Recovery(get_step(src,dir)) //Reptile
mob/var/Used_T_Recovery
obj/items/T_Recovery
	Stealable=1
	desc="Doubles recovery but halves energy."
	icon='Item, Needle.dmi'
	verb/Use(mob/A in view(1,usr)) if(A==usr||A.Frozen||A.icon_state=="KO")
		if(!A.Used_T_Recovery)
			A.Used_T_Recovery=1
			A.Recovery*=2
			A.Ki*=0.5
			A.MaxKi*=0.5
			A.KiMod*=0.5
			A.Decline*=0.8
		view(usr)<<"[usr] injects [A] with a mysterious needle!"
		del(src)
mob/var/Used_T_Regeneration
obj/items/T_Regeneration
	Stealable=1
	desc="Doubles regeneration and divides force by 10 permanently making energy almost useless."
	icon='Item, Needle.dmi'
	verb/Use(mob/A in view(1,usr)) if(A==usr||A.Frozen||A.icon_state=="KO")
		if(!A.Used_T_Regeneration)
			A.Used_T_Regeneration=1
			A.Regeneration*=2
			A.Pow*=0.1
			A.PowMod*=0.1
			A.Decline*=0.8
		view(usr)<<"[usr] injects [A] with a mysterious needle!"
		del(src)
obj/items/T_Energy
	Stealable=1
	desc="Raises energy to a certain level if it is below that level."
	icon='Item, Needle.dmi'
	verb/Use(mob/A in view(1,usr)) if(A==usr||A.Frozen||A.icon_state=="KO")
		if(A.MaxKi<2000*A.KiMod)
			A.MaxKi=2000*A.KiMod
			A.Decline*=0.8
		view(usr)<<"[usr] injects [A] with a mysterious needle!"
		del(src)
obj/items/T_Vitality
	Stealable=1
	desc="Raises endurance and resistance immensely if they are already under certain levels."
	icon='Item, Needle.dmi'
	verb/Use(mob/A in view(1,usr)) if(A==usr||A.Frozen||A.icon_state=="KO")
		if(A.End<500*A.EndMod)
			A.End=500*A.EndMod
			A.Decline*=0.8
		if(A.Res<500*A.ResMod) A.Res=500*A.ResMod
		view(usr)<<"[usr] injects [A] with a mysterious needle!"
		del(src)
obj/items/T_Heal
	Stealable=1
	desc="Temporarily speeds up regeneration when used."
	icon='Item, Needle.dmi'
	verb/Use(mob/A in view(1,usr)) if(A==usr||A.Frozen||A.icon_state=="KO")
		A.Senzu+=4
		spawn if(A) A.Un_KO()
		view(usr)<<"[usr] injects [A] with a mysterious needle!"
		del(src)
obj/items/T_Fusion
	Stealable=1
	desc="This will increase your battle power greatly but it will slowly wear off. You can take it as many \
	times as you want to keep your power high but each time will lessen your decline a little bit."
	icon='Item, Needle.dmi'
	verb/Use(mob/A in view(1,usr)) if(A==usr||A.Frozen||A.icon_state=="KO")
		if(A.Zombie_Power<20000*A.BPMod)
			A.Zombie_Power=20000*A.BPMod
			A.Decline*=0.9
			A.overlays-='Red Eyes.dmi'
			A.overlays+='Red Eyes.dmi'
		view(usr)<<"[usr] injects [A] with a mysterious needle!"
		del(src)
obj/items/T_Strength
	Stealable=1
	desc="This will greatly increase strength and speed if they are under certain levels."
	icon='Item, Needle.dmi'
	verb/Use(mob/A in view(1,usr)) if(A==usr||A.Frozen||A.icon_state=="KO")
		if(A.Str<500*A.StrMod)
			A.Str=500*A.StrMod
			A.Decline*=0.8
		if(A.Spd<500*A.SpdMod) A.Spd=500*A.SpdMod
		view(usr)<<"[usr] injects [A] with a mysterious needle!"
		del(src)
obj/items/T_Immunity
	Stealable=1
	desc="This will raise your immunity to infection up to 20."
	icon='Item, Needle.dmi'
	verb/Use(mob/A in view(1,usr)) if(A==usr||A.Frozen||A.icon_state=="KO")
		if(A.Immunity<20)
			A.Immunity=20
			A.Decline*=0.8
		view(usr)<<"[usr] injects [A] with a mysterious needle!"
		del(src)
mob/var/Took_T_Life
obj/items/T_Life
	Stealable=1
	desc="This will slow your decline IMMENSELY. Extending your lifespan nearly 4x its normal amount."
	icon='Item, Needle.dmi'
	verb/Use(mob/A in view(1,usr)) if(A==usr||A.Frozen||A.icon_state=="KO")
		if(!A.Took_T_Life)
			A.Took_T_Life=1
			A.DeclineMod*=0.25
			A.Decline*=0.8
		view(usr)<<"[usr] injects [A] with a mysterious needle!"
		del(src)
mob/proc/Zombies() spawn(rand(500,700)) if(src&&Zombied)
	var/mob/Enemy/Zombie/Z=new(loc)
	Z.Enlarged=Enlarged
	Z.BP=Base*Body
	Z.Str=Str
	Z.End=End*5
	Z.Res=Res
	Z.Spd=Spd*0.5
	Z.SpdMod=SpdMod*0.5
	Z.Off=Off
	Z.Def=Def*0.05
	Z.icon=icon
	Z.overlays=overlays
	Z.overlays+='Zombie.dmi'
	Z.name="Zombie"
	Z.contents+=contents //Mostly to put attached stun chips onto the zombie.
	del(src)
mob/proc/Hoarde() spawn(600) while(src) //Was 3000
	for(var/mob/P in oview(src))
		if(BP<P.BP*0.2) BP=P.BP*0.2
		if(BP<P.BP*0.7)
			BP*=1.5
			if(BP>P.BP*0.7) BP=P.BP*0.7
	if(!z) del(src)
	else if(!Frozen&&!(locate(/mob/Enemy/Zombie) in oview(src)))
		var/Zombies=0
		for(var/mob/Enemy/Zombie/B) Zombies+=1
		if(Zombies<700)
			Target=null //Now it is the leader of its own pack.
			if(prob(70)||Level!=1||!Mutater)
				var/mob/Enemy/Zombie/Q=new(loc)
				Q.Enlarged=Enlarged
				Q.Zombied=Zombied
				Q.Flyer=Flyer
				Q.BP=BP
				Q.Str=Str
				Q.End=End
				Q.Res=Res
				Q.Spd=Spd
				Q.SpdMod=SpdMod
				Q.Off=Off
				Q.Def=Def
				Q.icon=icon
				Q.overlays=overlays
				Q.name=name
				Q.Level=Level
				//Q.Target=src
				for(var/obj/Stun_Chip/A in src)
					var/obj/Stun_Chip/B=new
					B.Password=A.Password
					Q.contents+=B
			else Mutate()
	sleep(rand(2500*Spawn_Delay,3500*Spawn_Delay))
mob/Del()
	Target=null
	if(z&&!sim&&!istype(src,/mob/Splitform)&&!lastKnownKey&&!istype(src,/mob/Enemy)&&!istype(src,/mob/Cookable))
		Body_Parts()
	if(istype(src,/mob/Enemy/Zombie)) Body_Parts()
	..()
mob/var/Mutater=1 //If 0, this zombie will not mutate but remain the default type of zombie forever.
mob/var/Spawn_Delay=1
mob/Enemy/Zombie
	Zombied=1
	Spawn_Timer=0
	Can_Blast=0
	New()
		if(prob(50)) Mutater=0
		spawn if(src) Hoarde()
		..()