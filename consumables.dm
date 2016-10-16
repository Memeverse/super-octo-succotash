
//### Elixer of Life ###

obj/items/Elixir_Of_Life
	icon='Roids.dmi'
	Level=1
	Stealable=1
	Injection=1
	desc="This extends life by 5 years. But it takes away 1000 energy per use."
	verb/Use(mob/A in view(1,usr))
		if(A.MaxKi<1000)
			usr<<"They do not have enough energy to take this."
			return
		if(A==usr|A.Frozen|A.icon_state=="KO")
			view(usr)<<"[usr] injects [A] with a mysterious needle!"
			for(var/mob/player/M in view(usr))
				if(!M.client) return
				M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] injects [A] with Elixer of Life!\n")
			A.Decline+=5
			A.MaxKi-=1000
			A.Ki-=1000
			del(src)

// ### YEMMA FRUIT ###

obj/items/Fruit
	icon='Yemma Fruit.dmi'
	Add=10 //minutes of training
	Stealable=1
	Flammable = 1
	var/EXP = 0
	desc="Eating this will give you some power, and some energy. It will also speed up your \
	regeneration and recovery rate temporarily, much like a Senzu bean. It also gives you the experience of its creator, unless you have more than them."
	verb/Eat()
		usr.Base+=Add*usr.BPMod*GG*(usr.BPRank/usr.Fruits)*(usr.Gain_Multiplier*6000)
		usr.MaxKi+= 100*(usr.KiMod/usr.Fruits)
		if(usr.Experience <= src.EXP)
			usr.Experience = src.EXP
		usr.Senzu+=3
		usr.Fruits++
		view(usr)<<"[usr] eats a [src]"
		for(var/mob/player/M in view(usr))
			if(!M.client) return
			M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] eats [src]!\n")
		del(src)

//### POISON ###

obj/items/Poison_Injection
	Injection=1
	icon='Poison Injection.dmi'
	Level=1
	Stealable=1
	verb/Use(mob/A in view(1,usr))
		if(A==usr|A.icon_state=="KO"|A.Frozen)
			view(usr)<<"[usr] injects [A] with a mysterious needle!"
			for(var/mob/player/M in view(usr))
				if(!M.client) return
				M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] injects [A] with Poison (Level: [src.Level])!\n")
			A.Poisoned+=Level
			del(src)

// ### ANTIVIRUS ###

obj/items/Antivirus
	icon='Antivirus.dmi'
	Stealable=1
	Level=1
	verb/Use()
		view(usr)<<"[usr] uses the [src] and all infection disappears"
		for(var/mob/player/M in view(usr))
			if(!M.client) return
			M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] uses Antivirus and all infection disappears!\n")
		usr.Heart_Virus_Cure()
		usr.Poisoned=0
		del(src)

//### STEROIDS ###


obj/items/Steroid_Injection
	icon='Roids.dmi'
	Level=1
	Stealable=1
	Injection=1
	verb/Use(mob/A in view(1,usr))
		if(A==usr|A.Frozen|A.icon_state=="KO")
			view(usr)<<"[usr] injects [A] with a mysterious needle!"
			for(var/mob/player/M in view(usr))
				if(!M.client) return
				M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] injects [A] with Steroids (Level: [src.Level])!\n")
			if(A.client)
				A.Roid_Power+=5*Level*A.BPMod
				if(A.Roid_Power>A.Base*4) A.Roid_Power=A.Base*4
			else A.BP+= 100*Level*A.BPMod
			for(var/obj/Mate/B in A) B.LastUse=Year+5
			del(src)
			spawn usr.Steroid_Wearoff()

	verb/Upgrade()
		set src in oview(1)
		for(var/obj/Resources/A in usr)
			var/Amount=input("How many levels do you want to add? Up to [Commas(A.Value/4000*usr.Add)]") as num
			if(Amount>round(A.Value/4000*usr.Add)) Amount=round(A.Value/4000*usr.Add)
			if(Amount<0) Amount=0
			Level+=Amount
			A.Value-=Amount*4000/usr.Add
			view(usr)<<"[usr] upgraded the [src] to level [Level]"
			name="Steroids x[Level]"
		desc="Level [Level] [src]. This will increase Battle Power, but decrease Regeneration and \
		Recovery by the same factor, and Refire between attacks. The more steroids you take the longer \
		the effects take to wear off, it could even be years. If you die however, the effects disappear \
		instantly and you are returned to normal. It will also make you infertile for 5 years since your \
		last injection."
mob/proc/Bandages()
	for(var/obj/items/Bandages/B in src)
		if(ismob(B.loc))
			if(B.suffix=="*Equipped*")
				var/mob/X = B.loc
				X.Regeneration /= 1.25
				X.overlays-=B.icon
				view(20,X) << "[X]'s [B] fall away."
				del(B)
// ### Senzu ###

obj/items/Senzu
	icon='Senzu.dmi'
	name="Senzu"
	desc="Eating this will temporarily and drastically increase your regeneration and recovery."
	var/Increase=4
	var/division=1
	Flammable = 1
	Stealable=1
	New()
		pixel_x+=rand(-16,16)
		pixel_y+=rand(-16,16)
		//..()
	verb
		Eat()
			if(usr.icon_state!="KO")
				if(usr.Senzu<10) usr.Senzu+=Increase
				for(var/mob/player/M in view(usr)) if(M.client) M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] eats a [src].\n")
				view(usr)<<"[usr] eats a [src]"
				usr.Senzu_Wearoff(src)
				//del(src)
			else usr<<"You can't eat a Senzu while unconscious"
		Throw(mob/M in oview(usr))
			view(usr)<<"[usr] throws a Senzu to [M]"
			missile('Senzu.dmi',usr,M)
			sleep(3)
			view(usr)<<"[M] catches the Senzu"
			for(var/mob/player/K in view(usr)) if(K.client) K.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] catches the [src].\n")
			Move(M)
		Use_on(mob/M in oview(1))
			if(M.icon_state=="KO")
				view(usr)<<"[usr] gives a [src] to [M]"
				for(var/mob/player/K in view(usr)) if(K.client) K.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] gives a [src] to [M]\n")
				M.icon_state=""
				M.Un_KO()
				if(M.Senzu<10) M.Senzu+=Increase
				del(src)
				spawn M.Senzu_Wearoff(src)
			else usr<<"You can only use this on an unconscious person."
		Split()
			view(usr)<<"[usr] splits a [src] in half"
			for(var/mob/player/M in view(usr)) if(M.client) M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] splits a [src] in half.\n")
			var/amount=2
			while(amount)
				var/obj/items/Senzu/A=new
				A.division=division*2
				A.Increase=Increase*0.5
				A.name="1/[A.division] Senzu"
				usr.contents+=A
				amount-=1
			del(src)
		Plant()
			loc=usr.loc
			view(src)<<"[usr] plants a [src] bean in the ground..."
			for(var/mob/player/M in view(usr)) if(M.client) M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] plants a [src] in the ground.\n")
			Senzu_Grow()

obj/items/Senzu/proc/Senzu_Grow() while(z)
	sleep(100)
	if(Increase==initial(Increase))
		view(src)<<"The senzu is done growing"
		return
	if(src&&prob(1)&&z)
		var/blarg=name
		division*=0.5
		Increase*=2
		if(division>1) name="1/[division] Senzu"
		else
			icon='Senzu.dmi'
			name="Senzu"
		view(src)<<"The [blarg] grows into a [name]..."


//### LSD ###

obj/items/LSD
	icon='LSD.dmi'
	Level=1
	Stealable=1
	Injection=1
	verb/Use(mob/A in view(1,usr))
		if(A==usr|A.Frozen|A.icon_state=="KO")
			view(usr)<<"[usr] injects [A] with a mysterious needle!"
			for(var/mob/player/M in view(usr))
				if(!M.client) return
				M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] injects [A] with LSD (level: [src.Level]!\n")

			if(A.client)
				if(A.client.dir==NORTH) A.LSD(src.Level)
			del(src)
	verb/Upgrade()
		set src in oview(1)
		for(var/obj/Resources/A in usr)
			var/Amount=input("How many levels do you want to add? Up to [Commas(A.Value/500)]") as num
			if(Amount>round(A.Value/500)) Amount=round(A.Value/500)
			if(Amount<0) Amount=0
			Level+=Amount
			A.Value-=Amount*500
			view(usr)<<"[usr] upgraded the [src] to level [Level]"
		desc="Level [Level] [src]. This will increase Battle Power, but decrease Regeneration and \
		Recovery by the same factor, and Refire between attacks. The more steroids you take the longer \
		the effects take to wear off, it could even be years. If you die however, the effects disappear \
		instantly and you are returned to normal. It will also make you infertile for 5 years since your \
		last injection."

mob/proc/LSD(var/Level)
	spawn(100)

	while(src&&Level>1)
		src<<"OSHIT!"
		client.dir=pick(SOUTH,EAST,WEST,SOUTHEAST,SOUTHWEST,NORTHEAST,NORTHWEST)
		sleep(rand(10,600))
		Level--
		if(client.dir==NORTH) return
