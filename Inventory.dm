// ### VERBS ###

obj/items/verb/Drop()
	if(src.suffix == "Applied")
		return
	if(global.rebooting)
		usr << "Unable to pick up or drop items while a reboot is in progress."
		return
	if(isturf(usr.loc))
		var/Amount=0
		for(var/obj/A in get_step(usr,usr.dir)) if(!(locate(A) in usr)) Amount++
		if(Amount>4)
			usr<<"Nothing more can be placed on this spot."
			return
		if(suffix) if(!Can_Drop_With_Suffix)
			usr<<"You must unequip it first"
			return
		for(var/mob/player/A in view(usr))
			if(A.see_invisible>=usr.invisibility)
				A<<"[usr] drops [src]"
				A.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] drops [src].\n")
		usr.overlays-=icon
		//loc=get_step(usr,usr.dir)
		loc=usr.loc
		step_to(src,usr.dir)
		dir=SOUTH
		if(src.type == /obj/items/Spell_Book)
			usr.Close_Spells()

// ### ITEMS ###

/*

obj/items/Resource_Vaccuum
	icon='Item, Vaccuum.dmi'
	var/tmp/Vaccuuming
	Click() if(locate(src) in usr)
		if(Vaccuuming) return
		Vaccuuming=1
		spawn(100) Vaccuuming=0
		spawn while(Vaccuuming)		//while(R&&!(R in usr)&&R.loc)
			for(var/obj/Resources/R in view(10,usr))
				//if(!R||isnull(R)) break // sanity check
				var/Old_Loc=R.loc
				step_towards(R,usr)
				if(R.loc==Old_Loc) break
				if(R in view(1,usr))
					for(var/obj/Resources/A in usr) A.Value+=R.Value
					del(R)
				sleep(2)

*/
mob/var/tmp/spells_open = 0
mob
	proc
		Close_Spells()
			src.spells_open = 0
			src.Spell_Power = 0
			src.Spell_Cost = 0
			if(client)
				winshow(src,"Spellbook",0)

				winset(src,"Lightning Bolt","is-visible=false")
				winset(src,"Lightning Bolt Spell","is-visible=false")

				winset(src,"Enchant","is-visible=false")
				winset(src,"Enchant Spell","is-visible=false")

				winset(src,"Create Portal","is-visible=false")
				winset(src,"Create Portal Spell","is-visible=false")
obj/items/Spell_Book
	name="Spell Book"
	icon='Magic Items.dmi'
	icon_state = "spell book"
	Stealable=1
	desc="This is a magical book full of spells. Keeping it on you while drawing on ambient forces will increase the rate you attain mana."
	Click()
		if(src.loc == usr) if(usr.icon_state != "KO")
			if(usr.spells_open == 0)
				if(usr.Magic_Level >= 10)
					usr.spells_open = 1
					winshow(usr,"Spellbook",1)
					if(usr.Magic_Level >= 40)
						if(usr.client)
							winset(usr,"Lightning Bolt","is-visible=true")
							winset(usr,"Lightning Bolt Spell","is-visible=true")
					if(usr.Magic_Level >= 60)
						if(usr.client)
							winset(usr,"Enchant","is-visible=true")
							winset(usr,"Enchant Spell","is-visible=true")
					if(usr.Magic_Level >= 80)
						if(usr.client)
							winset(usr,"Create Portal","is-visible=true")
							winset(usr,"Create Portal Spell","is-visible=true")
					return
				else
					usr << "You do not possess enough magic skill to use this item."
			else
				usr.Close_Spells()
				return
obj/items/Recycler
	icon='Recyle.dmi'
	icon_state = "open"
	Grabbable = 1
	Stealable=0
	Savable = 1
	Bolted = 0
	layer = 2.9
	desc="Clicking this will activate the recycling process and crush anything within into raw resources, but only returning half of the cost used to make the object."
	var/tmp/in_use = 0
	var/unable = list(/obj/Airlock,/obj/AndroidAirlock,/obj/AndroidControls,/obj/Controls,/obj/Door,/obj/Magical_Portal,/obj/Planets/,/obj/Sacred_Water,/obj/Resources)
	New()
		src.pixel_x = -15
		src.pixel_y = -25
	Click()
		if(src.in_use == 0) if(src in range(1,usr))
			usr.saveToLog("| [usr] clicked [src].\n")
			if(src.icon_state != "closed")
				src.in_use = 1
				flick("closing",src)
				spawn(5)if(src)
					src.layer = 5
					spawn(10)
						if(src)
							src.icon_state = "closed"
							src.in_use = 0
							for(var/obj/I in src.loc)
								if(I != src)
									if(istype(I,/obj/items/Magic_Ball/))
										for(var/turf/A in view(2,src))
											new/obj/Explosion(locate(A.x,A.y,A.z))
										new/obj/BigCrater(locate(src.x,src.y,src.z))
										usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] tries to recycle a magic ball but fails.\n")
										del(src)
										return
									if(istype(I,/obj/Mana))
										for(var/turf/A in view(2,src))
											new/obj/Explosion(locate(A.x,A.y,A.z))
										new/obj/BigCrater(locate(src.x,src.y,src.z))
										usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] tries to recycle a mana but fails.\n")
										del(src)
										return
									for(var/X in unable)
										if(I.type == X)
											return
									var/obj/Resources/A=new
									A.loc=src.loc
									if(I.cost)
										A.Value=I.cost / 2
									else
										A.Value = 1
									A.name="[Commas(A.Value)] Resources"
									usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] recycles [I] for [Commas(A.Value)] Resources.\n")
									del(I)
									break
							for(var/mob/M in src.loc)
								if(M.afk == 0)
									if(M.icon_state == "KO")
										spawn M.Death("recycler")
									else
										M.Health -= 25
										if(M.Health<=0) M.KO(src)
			else
				src.in_use = 1
				flick("opening",src)
				spawn(7)if(src)
					src.layer = 2.9
					spawn(8)
						if(src)
							src.icon_state = "open"
							in_use = 0
		else
			usr << "This item is in the process of recycling already."
			return
obj/items/Magic_Circle
	icon='magic circle.dmi'
	icon_state = "less white"
	Grabbable = 1
	Bolted = 1
	Savable = 1
	layer = 2
	desc="This is a magical creation of sorts, able to bolster the amount of ambient mana absorbed into yourself when sitting in the middle and meditating. It can also be used for some magical rituals too."
	New()
		src.pixel_x = -64
		src.pixel_y = -64
	verb
		Relocate()
			set src in oview(1)
			if(x&&y&&z&&!Bolted)
				Bolted=1
				range(20,src)<<"[usr] secures the [src] to the ground."
				for(var/mob/player/M in view(src)) if(M.client) M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] bolts [src] to the ground.\n")
				return
			if(Bolted) if(src.Builder == "[key_name(usr)], [usr.client.address]")
				range(20,src)<<"[usr] moves the [src] from the ground."
				Bolted=0
				for(var/mob/player/M in view(src)) if(M.client) M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] un-bolts [src] from the ground.\n")
				return
		Remove()
			set src in range(1,usr)
			if(src.Builder == "[key_name(usr)], [usr.client.address]")
				switch(input("Are you sure you want to remove this circle?") in list("No","Yes"))
					if("Yes")
						if(usr in range(1,src))
							range(20,src) << "[usr] removes their [src]."
							for(var/mob/M in range(20,src))
								if(M.client)
									M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] removed their circle [src].\n")
							del(src)
obj/items/Door_Pass
	name="Key"
	icon='Door Pass.dmi'
	Stealable=1
	desc="Click this to set it's password. Door's will check if it is correct and only let you in if it is."
	Password = null
	Click()
		if(Password)
			usr<<"It has already been programmed and cannot be reprogrammed."
			return
		Password=input("Enter a password for the doors to check if it is correct") as text




obj/items/Cybernetics_Guide
	desc={"Cybernetics is actually quite simple. There are many modules that have different purposes.
	When you install a module, it will serve its intended purpose, but they have various drawbacks.
	These advantages and drawbacks can be read using the description verb. You can activate modules
	by picking them up and clicking them, once activated, only death can undo them. Common side effects
	of cyberization include lowering of energy, recovery, and regeneration. And yes, due to the lowered
	biological energy, it can slow learning and skill mastery of biological skills. Certain
	cyberizations will also restrict access to certain biological abilities, such as body expand. Any
	abilities lost can usually be replaced by a mechanical alternative. The more intelligence you
	gain the more modules you can make. Modules themselves are usually trade-offs of one thing for
	another, but also they will increase the effect upgrades have on you, but decrease the effect of
	biological training. When you get weapons or attacks from modules, they hardly ever use your
	natural battle power or energy to decide their damage capabilities, but rather, they will decide
	damage based on your cybernetic/artificial power from upgrading, and they will drain the energy
	from your generator to use them. Ballistic weaponry uses your strength to augment damage rather
	than force. Another common side effect of modules is loss of natural battle power gain, but
	increased effect from cybernetic power gotten from upgrades as you get more modules. Since most
	cybernetic modules decrease natural power gain, certain races would have a harder time achieving
	certain things, such as Super Saiyan for instance, and even ascension. But the cybernetic power
	you acquire can help you to become more powerful very fast, and if your race is considered weak,
	it can tip the odds heavily. In the very long run, it may be bad to be a cybernetic being, but,
	all you have to do to restore yourself, is die, and you are returned to normal. Another common
	effect of cybernetic modules is increased lifespan that rises with each new module. Many modules
	can be further upgraded before or after being installed on someone. Scientist's can upgrade not
	only the amount of available energy an android has in its generator, but the generator is also
	the biggest part of an android's artificial battle power, upgrading it is the key to having an
	android with a lot of battle power. Other modules increase artificial power very slightly just by
	having them installed.
	<br><br>
	Cybernetic weaponry comes in different types. Here they are listed from least advanced to most
	advanced.
	<br>
	Ballistic Weaponry: These drain no energy to use and their damage is based on strength instead of
	force. They are typically very fast, but weak, and have infinite ammo.
	<br><br>
	Laser Weaponry: These drain some energy from the reactor, but not much. They are fast, but weak,
	and the flexibility of what sort of attacks lasers can do is limited. Since lasers can't turn,
	can't explode, and so on. The most dramatic difference with laser weapons, is that they cannot be
	deflected.
	<br><br>
	Plasma Weaponry: A more advanced energy than any before it, it drains heavily, and is slow, but
	powerful. It has more flexibility than lasers, but perhaps not to the extent of natural ki. All
	plasma weaponry is highly explosive."}
obj/items/Hacking_Console
	icon='Lab.dmi'
	icon_state="Labtop"
	Stealable=1
	desc="If this is upgraded past the upgrade level of a door, it can open the door for you."
	verb/Upgrade()
		set src in oview(1)
		if(usr.Int_Level<Tech)
			usr<<"This is too advanced for you to mess with."
			return
		var/obj/Resources/A
		for(var/obj/Resources/B in usr) A=B
		var/Cost=10000/usr.Add
		var/Max_Upgrade=(A.Value/Cost)+Tech
		if(Max_Upgrade>usr.Int_Level) Max_Upgrade=usr.Int_Level
		var/Upgrade=input("Upgrade it to what level? (1-[round(Max_Upgrade)]). The maximum amount you can upgrade is determined by your intelligence (Max Upgrade cannot exceed Intelligence), and how much resources you have. So if the maximum is less than your intelligence then it is instead due to not having enough resources to upgrade it higher than the said maximum.") as num
		if(Upgrade>usr.Int_Level) Upgrade=usr.Int_Level
		if(Upgrade>Max_Upgrade) Upgrade=Max_Upgrade
		if(Upgrade<1) Upgrade=1
		Upgrade=round(Upgrade)
		if(Upgrade<Tech) switch(input("You wish to bring this Level [Tech] [src] to Level [Upgrade]?") in list("Yes","No"))
			if("No") return
		Cost*=Upgrade-Tech
		if(Cost<0) Cost=0
		if(Cost>A.Value)
			usr<<"You do not have enough resources to upgrade it to level [Upgrade]"
			return
		view(src)<<"[usr] upgrades the [src] to level [Upgrade]"
		for(var/mob/player/M in view(src))
			if(!M.client) return
			M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades the [src] to level [Upgrade].\n")
		A.Value-=Cost
		src.cost += Cost
		Tech=Upgrade
		desc="Level [Tech] [src]"
		Level=Upgrade
	/*verb/Upgrade()
		set src in oview(1,usr)
		if(Level<usr.Int_Level)
			Level=usr.Int_Level
			usr<<"You upgrade the [src] to level [Level]"
		else usr<<"It is beyond your upgrading capabilities"*/
	verb/Use()
		for(var/obj/Door/A in get_step(usr,usr.dir))
			if(A.Magic_Secure)
				view(usr)<<"[usr] tries to hack into the [A], but a magical force upon the door prevents it so!"
				return
			if(A.Level<Level)
				view(usr)<<"[usr] uses the [src] to hack into the [A] and opens it!"
				for(var/mob/player/M in view(src))
					if(!M.client) return
					M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] uses the [src] to hack into [A] and opens it!\n")
				A.Open()
				return
			else
				view(usr)<<"[usr] tries to hack into the [A], but it is too advanced"
				for(var/mob/player/M in view(src))
					if(!M.client) return
					M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] uses the [src] to hack into [A] but it is too advanced!\n")
				return
		for(var/atom/X in get_step(usr,usr.dir))
			if(X.password)
				view(usr)<<"[usr] uses the [src] to hack into the [X] and opens it!"
				usr << "The password is [X.password]"
				for(var/mob/player/M in view(src))
					if(!M.client) return
					M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] uses the [src] to hack into [X] and opens it!\n")
obj/items/Magic_Vault
	desc       = "A magic vault allows for the safe storage of valuable mana.  Right click the vault and choose either 'deposit' or 'withdraw' to place or remove mana from storage."
	icon       = 'Magic Items.dmi'
	icon_state = "magic vault"
	Can_Change = 0
	Stealable = 1
	Savable = 1
	var/SafeResources = 0
	var/SafePassword  = ""

	Shockwaveable=0
	verb/Set_Password()
		set src in oview(1)
		if(SafePassword == "")
			SafePassword = input("Entering a password will help keep this vault private.")
			usr << "Password set!"
			return
		else
			usr << "The password has already been set!"
			return

	verb/Deposit()
		set src in oview(1)
		var/passwd = input("What is this safe's password?")
		if(passwd != SafePassword)
			usr << "Incorrect Password"
			return
		else
			var/putRSC = input("How much mana would you like to place in the vault?") as num

			for(var/obj/Mana/A in usr)
				if(A.Value < 1) return
				if(A.Value < putRSC)
					usr << "You do not have that much mana!"
					return
				else
					A.Value       -= putRSC
					SafeResources += putRSC
					return

	verb/Withdraw()
		set src in oview(1)
		var/passwd = input("What is this vault's password?")
		if(passwd != SafePassword)
			usr << "Incorrect Password"
			return
		else
			var/getRSC = input("How much mana would you like to withdraw from the vault?") as num
			if(getRSC < 1) return

			if(getRSC > SafeResources)
				usr << "You do not have that much mana inside of the vault!"
				return
			else
				for(var/obj/Mana/A in usr)
					A.Value       += getRSC
					SafeResources -= getRSC
				return

	verb/Check_Storage()
		set src in oview(1)
		var/passwd = input ("What is this vault's password?")
		if(passwd != SafePassword)
			usr << "Incorrect Password"
			return
		else
			usr << "You have [Commas(SafeResources)] in the vault."
			return
obj/items/Safe
	desc       = "A safe allows for the safe storage of valuable resources.  Right click the safe and choose either 'deposit' or 'withdraw' to place or remove materials from storage."
	icon       = 'Safe.dmi'
	icon_state = ""
	Stealable = 1
	Can_Change = 0
	Savable = 1
	var/SafeResources = 0
	var/SafePassword  = ""

	Shockwaveable=0
	verb/Set_Password()
		set src in oview(1)
		if(SafePassword == "")
			SafePassword = input("Entering a password will help keep this safe private.")
			usr << "Password set!"
			return
		else
			usr << "The password has already been set!"
			return

	verb/Deposit()
		set src in oview(1)
		if(SafeResources <= 0)
			SafeResources = 0
		var/passwd = input("What is this safe's password?")
		if(passwd != SafePassword)
			usr << "Incorrect Password"
			return
		else
			var/putRSC = input("How many resources would you like to place in the safe?") as num

			for(var/obj/Resources/A in usr)
				if(A.Value < 1) return
				if(A.Value < putRSC)
					usr << "You do not have that many resources!"
					return
				else
					A.Value       -= putRSC
					SafeResources += putRSC
					return

	verb/Withdraw()
		set src in oview(1)
		var/passwd = input("What is this safe's password?")
		if(SafeResources <= 0)
			SafeResources = 0
		if(passwd != SafePassword)
			usr << "Incorrect Password"
			return
		else
			var/getRSC = input("How many resources would you like to withdraw from the safe?") as num
			if(getRSC < 1) return

			if(getRSC > SafeResources)
				usr << "You do not have that many resources inside of the safe!"
				return
			else
				for(var/obj/Resources/A in usr)
					A.Value       += getRSC
					SafeResources -= getRSC
				return

	verb/Check_Storage()
		set src in oview(1)
		if(SafeResources <= 0)
			SafeResources = 0
		var/passwd = input ("What is this safe's password?")
		if(passwd != SafePassword)
			usr << "Incorrect Password"
			return
		else
			usr << "You have [Commas(SafeResources)] in the safe."
			return


obj/items/Force_Field
	desc="Activate this and it will protect you against energy attack so long as its energy remains. \
	Each shot it deflects drains the battery."
	icon='Lab.dmi'
	icon_state="Computer 1"
	Stealable=1
	/*Click() if(locate(src) in usr)
		if(!suffix)
			if(Level<=0)
				usr<<"[src]'s battery is drained"
				return
			suffix="*Equipped*"
		else suffix=null*/
	verb/Upgrade()
		set src in oview(1,usr)
		var/Amount=input("How many resources do you want to put into its battery?") as num
		if(Amount<1) return
		for(var/obj/Resources/A in usr)
			if(Amount>A.Value) Amount=A.Value
			Amount=round(Amount)
			src.cost += Amount
			A.Value-=Amount
			var/Extra = 100 + Year * 10 //Helps make force fields stronger as years go by.
			Level+=Amount*Extra*usr.Add
			view(usr)<<"[usr] adds [Commas(Amount*usr.Add)] to the [src]'s battery"
			desc=initial(desc)+"<br>[Commas(Level)] Battery Remaining"
			for(var/mob/player/M in view(src))
				if(!M.client) return
				M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] adds to the [Commas(Amount*usr.Add)] [src]'s battery.\n")

mob/proc/Force_Field() spawn if(src)
	var/A='Force Field.dmi'
	A+=rgb(100,200,250,120)
	overlays-=A
	overlays+=A
	spawn(50) overlays-=A

/*
obj/Antivirus_Tower
	icon='Lab.dmi'
	icon_state="Tower 1"
	density=1
	desc="This emits a pulse every minute that will carry with it the antivirus, killing all zombies \
	in proximity, and curing anyone who is infected."
	var/Distance=35
	New()
		spawn if(src) Antivirus_Tower()
		var/image/A=image(icon='Lab.dmi',icon_state="Tower 2",pixel_y=32,layer=MOB_LAYER+1)
		var/image/B=image(icon='Lab.dmi',icon_state="Tower 3",pixel_y=64,layer=MOB_LAYER+1)
		overlays.Remove(A,B)
		overlays.Add(A,B)
		//sd_SetLuminosity(3)
		//..()
	proc/Antivirus_Tower() while(src)
		for(var/mob/A in view(Distance,src))
			if(A.client) A.Zombied=0
			else if(A.Zombied) del(A)
		sleep(rand(400,800))
*/

obj/items/Hover_Chair
	icon='Item, Hover Chair.dmi'
	icon_state="base"
	density=1
	layer=MOB_LAYER+10
	Savable=1
	New()
		var/image/A=image(icon='Item, Hover Chair.dmi',icon_state="side1",pixel_y=0,pixel_x=-32,layer=10)
		var/image/B=image(icon='Item, Hover Chair.dmi',icon_state="side2",pixel_y=0,pixel_x=32,layer=10)
		var/image/C=image(icon='Item, Hover Chair.dmi',icon_state="back",pixel_y=0,pixel_x=-0,layer=MOB_LAYER-1)
		var/image/D=image(icon='Item, Hover Chair.dmi',icon_state="front",pixel_y=0,pixel_x=0,layer=MOB_LAYER+10)
		var/image/E=image(icon='Item, Hover Chair.dmi',icon_state="bottom",pixel_y=-32,pixel_x=0,layer=10)
		overlays.Remove(A,B,C,D,E)
		overlays.Add(A,B,C,D,E)

		//..()
	Click() if(locate(src) in usr)
		if(!suffix)
			usr.overlays+=src
			suffix="*Equipped*"
		else
		//	usr.overlays-=src
			usr.layer=MOB_LAYER+10
			usr.overlays-=usr.overlays
			suffix=null
obj/items/Cloak_Controls
	icon='Cloak.dmi'
	icon_state="Controls"
	desc="You can use this to activate or deactivate all cloaked objects matching the same password \
	you have set for the controls. You can also use this to remove the cloaking chip from objects \
	next to you by using uninstall on it. You can upgrade this to have more cloaking capability so \
	that it is harder to detect. This is also a personal cloak, if you activate it, you will become \
	out of phase, and stay out of phase until you deactivate it. While out of phase you will also see \
	anything that is in the same phase or lower than yourself. The personal cloak is 5 levels less \
	powerful than the cloaking modules themselves."
	var/Active
	Level=1
	Stealable=1
	verb/Use()
		if(Level<1)
			usr<<"You cannot use this without further upgrades"
			return
		if(!usr.invisibility)
			view(usr)<<"[usr] activates their personal cloak"
			for(var/mob/player/M in view(usr))
				if(!M.client) return
				M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] activates their personal cloak.\n")
			usr<<"You are now [Level] levels out of phase"
			usr.invisibility=Level
			usr.see_invisible=Level
		else
			usr.invisibility=0
			usr.see_invisible=0
			view(usr)<<"[usr] deactivates their personal cloak."
			for(var/mob/player/M in view(usr))
				if(!M.client) return
				M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] deactivates their personal cloak.\n")
	verb/Activate()
		if(!Active)
			view(usr)<<"[usr] activates the cloaking controls"
			Active=1
			for(var/mob/player/M in view(usr))
				if(!M.client) return
				M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] activates their cloak controls.\n")

		else
			view(usr)<<"[usr] deactivates the cloaking controls"
			Active=0
			for(var/mob/player/M in view(usr))
				if(!M.client) return
				M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] deactivates their cloak controls.\n")
		for(var/obj/A) for(var/obj/items/Cloak/B in A) if(B.Password==Password)
			if(Active) A.invisibility=Level
			else A.invisibility=0
	verb/Set() Password=input("Set the password for tracking cloaking chips of the same password") as text
	verb/Uninstall() for(var/obj/A in get_step(usr,usr.dir)) for(var/obj/items/Cloak/B in A)
		view(usr)<<"[usr] removes the cloaking system from [A]"
		A.invisibility=0
		B.loc=usr.loc
	verb/Upgrade()
		set src in oview(1)
		if(Level>=100)
			usr<<"It is at the maximum."
			return
		if(usr.Int_Level<Tech)
			usr<<"This is too advanced for you to mess with."
			return
		var/obj/Resources/A
		for(var/obj/Resources/B in usr) A=B
		var/Cost=400000/usr.Add
		var/Max_Upgrade=(A.Value/Cost)+Tech
		if(Max_Upgrade>usr.Int_Level) Max_Upgrade=usr.Int_Level
		var/Upgrade=input("Upgrade it to what level? (1-[round(Max_Upgrade)]). The maximum amount you can upgrade is determined by your intelligence (Max Upgrade cannot exceed Intelligence), and how much resources you have. So if the maximum is less than your intelligence then it is instead due to not having enough resources to upgrade it higher than the said maximum.") as num
		if(Upgrade>usr.Int_Level) Upgrade=usr.Int_Level
		if(Upgrade>Max_Upgrade) Upgrade=Max_Upgrade
		if(Upgrade<1) Upgrade=1
		Upgrade=round(Upgrade)
		if(Upgrade<Tech) switch(input("You wish to bring this Level [Tech] [src] to Level [Upgrade]?") in list("Yes","No"))
			if("No") return
		Cost*=Upgrade-Tech
		if(Cost<0) Cost=0
		if(Cost>A.Value)
			usr<<"You do not have enough resources to upgrade it to level [Upgrade]"
			return
		view(src)<<"[usr] upgrades the [src] to level [Upgrade]"
		for(var/mob/player/M in view(src))
			if(!M.client) return
			M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades [src] to level [Upgrade].\n")
		A.Value-=Cost
		src.cost += Cost
		Tech=Upgrade
		desc="Level [Tech] [src]"
		Level=1+round(0.1*Upgrade*0.01*rand(50,200))
		if(Level<1) Level=1
		if(Level>100) Level=100
	/*verb/Upgrade()
		set src in oview(1)
		var/obj/Resources/A
		for(var/obj/Resources/B in usr) A=B
		var/list/Choices=new
		if(Level<100&&A.Value>=1000*Tech/usr.Add) Choices.Add("Cloak Ability ([1000*Tech/usr.Add])")
		if(!Choices)
			usr<<"You do not have enough resources"
			return
		Choices+="Cancel"
		var/Choice=input("Change what?") in Choices
		if(Choice=="Cancel") return
		if(Choice=="Cloak Ability ([1000*Tech/usr.Add])")
			if(A.Value<1000*Tech/usr.Add) return
			A.Value-=1000*Tech/usr.Add
			Level++
		Tech++
		desc=initial(desc)
		desc+="<br><br>Level [Level] Cloak"*/
obj/items/Android_Upgrade
	icon='android tech.dmi'
	name = "Android Upgrade Component"
	icon_state = "component"
	desc="This is an Android Upgrade Component, a special device capable of enhancing an artifical being. Use it on an Android and you can select which mod \
	to upgrade. Each upgrade will increase the mod you choose by 0.1. Once a mod reaches 2, you can no longer upgrade that mod, apart from power, which caps at 2.5\
	Energy will increase by 0.5 per upgrade, up to a max of 10."
	Stealable=1
	Savable = 1
	verb/Use(mob/M in range(1,usr))
		if(src in usr)
			if(M.Race == "Android")
				if(M.Critical_Left_Arm || M.Critical_Right_Arm || M.Critical_Right_Leg || M.Critical_Left_Leg || M.Critical_Torso)
					usr << "Unable to use this until your systems are repaired."
					return
				for(var/obj/X in M)
					if(X.Using)
						if(M != usr)
							usr << "[M] must not be using any buffs before they are upgraded!"
						M << "You can't use buffs while being upgraded, please disable them so [usr] can try upgrading you again."
						return
				usr << "<font color = teal>Select a mod to upgrade. Each Android Upgrade Component will increase the selected mod by 0.1 for all but Energy, up to a cap of 2. Energy will increase by 0.5 per component up to a cap of 5.<p>"
				var/T = "[M] Power - [M.BPMod]<br>[M] Energy - [M.KiMod]<br>[M] Strength - [M.StrMod]<br>[M] Durability - [M.EndMod]<br>[M] Force - [M.PowMod]<br>[M] Resistance - [M.ResMod]<br>[M] Speed - [M.SpdMod]<br>[M] Offense - [M.OffMod]<br>[M] Defense - [M.DefMod]<br>[M] Regeneration - [M.Regeneration]<br>[M] Recovery - [M.Recovery]<br>"
				M << "[T]"
				if(M != usr)
					usr << "[T]"
				var/list/Choices=new
				Choices.Add("Power","Energy","Strength","Durability","Force","Resistance","Speed","Offense","Defense","Regeneration","Recovery","Cancel")
				switch(input("Choose Option") in Choices)
					if("Cancel")
						return
					if("Power")
						if(M in range(1,usr))
							if(M.BPMod > 2.4)
								M.BPMod = 2.5
								usr << "They already have 2.5 in that mod."
								return
							M.BPMod += 0.1
							view(20,usr) << "[usr] inserts the [src] into [M].<p>"
							if(M != usr)
								usr << "<font color = teal>[M]'s potential for power has been increased! Their BP mod went up by 0.1.     It is now [M.BPMod].<p>"
							M << "<font color = teal>Your potential for power has increased! Your BP mod went up by 0.1.     It is now [M.BPMod].<p>"
							usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades [M]'s bp mod by 0.1\n")
							if(M != usr)
								M.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades [M]'s bp mod by 0.1\n")
							del(src)
					if("Energy")
						if(M in range(1,usr))
							if(M.KiMod > 4.9)
								M.KiMod = 5
								usr << "They already have 5 in that mod."
								return
							M.KiMod += 0.5
							view(20,usr) << "[usr] inserts the [src] into [M].<p>"
							if(M != usr)
								usr << "<font color = teal>[M]'s potential for energy has been increased! Their energy mod went up by 0.5.     It is now [M.KiMod].<p>"
							M << "<font color = teal>Your potential for energy has increased! Your energy mod went up by 0.5.     It is now [M.KiMod].<p>"
							usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades [M]'s energy mod by 0.1\n")
							if(M != usr)
								M.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades [M]'s energy mod by 0.1\n")
							del(src)
					if("Speed")
						if(M in range(1,usr))
							if(M.SpdMod > 1.9)
								M.SpdMod = 2
								usr << "They already have 2 in that mod."
								return
							M.SpdMod += 0.1
							view(20,usr) << "[usr] inserts the [src] into [M].<p>"
							if(M != usr)
								usr << "<font color = teal>[M]'s potential for speed has been increased! Their speed mod went up by 0.1.     It is now [M.SpdMod].<p>"
							M << "<font color = teal>Your potential for speed has increased! Your speed mod went up by 0.1.     It is now [M.SpdMod].<p>"
							usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades [M]'s speed mod by 0.1\n")
							if(M != usr)
								M.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades [M]'s speed mod by 0.1\n")
							del(src)
					if("Strength")
						if(M in range(1,usr))
							if(M.StrMod > 1.9)
								M.StrMod = 2
								usr << "They already have 2 in that mod."
								return
							var/N = M.Str / M.StrMod
							M.StrMod += 0.1
							M.Str = N * M.StrMod
							view(20,usr) << "[usr] inserts the [src] into [M].<p>"
							if(M != usr)
								usr << "<font color = teal>[M]'s potential for strength has been increased! Their strength mod went up by 0.1.     It is now [M.StrMod].<p>"
							M << "<font color = teal>Your potential for strength has increased! Your strength mod went up by 0.1.     It is now [M.StrMod].<p>"
							usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades [M]'s strength mod by 0.1\n")
							if(M != usr)
								M.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades [M]'s strength mod by 0.1\n")
							del(src)
					if("Durability")
						if(M in range(1,usr))
							if(M.EndMod > 1.9)
								M.EndMod = 2
								usr << "They already have 2 in that mod."
								return
							var/N = M.End / M.EndMod
							M.EndMod += 0.1
							M.End = N * M.EndMod
							view(20,usr) << "[usr] inserts the [src] into [M].<p>"
							if(M != usr)
								usr << "<font color = teal>[M]'s potential for durability has been increased! Their durability mod went up by 0.1.     It is now [M.EndMod].<p>"
							M << "<font color = teal>Your potential for durability has increased! Your durability mod went up by 0.1.     It is now [M.EndMod].<p>"
							usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades [M]'s durability mod by 0.1\n")
							if(M != usr)
								M.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades [M]'s durability mod by 0.1\n")
							del(src)
					if("Force")
						if(M in range(1,usr))
							if(M.PowMod > 1.9)
								M.PowMod = 2
								usr << "They already have 2 in that mod."
								return
							var/N = M.Pow / M.PowMod
							M.PowMod += 0.1
							M.Pow = N * M.PowMod
							view(20,usr) << "[usr] inserts the [src] into [M].<p>"
							if(M != usr)
								usr << "<font color = teal>[M]'s potential for force has been increased! Their force mod went up by 0.1.     It is now [M.PowMod].<p>"
							M << "<font color = teal>Your potential for force has increased! Your force mod went up by 0.1.     It is now [M.PowMod].<p>"
							usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades [M]'s force mod by 0.1\n")
							if(M != usr)
								M.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades [M]'s force mod by 0.1\n")
							del(src)
					if("Resistance")
						if(M in range(1,usr))
							if(M.ResMod > 1.9)
								M.ResMod = 2
								usr << "They already have 2 in that mod."
								return
							var/N = M.Res / M.ResMod
							M.ResMod += 0.1
							M.Res = N * M.ResMod
							view(20,usr) << "[usr] inserts the [src] into [M].<p>"
							if(M != usr)
								usr << "<font color = teal>[M]'s potential for resistance has been increased! Their resistance mod went up by 0.1.     It is now [M.ResMod].<p>"
							M << "<font color = teal>Your potential for resistance has increased! Your resistance mod went up by 0.1.     It is now [M.ResMod].<p>"
							usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades [M]'s resistance mod by 0.1\n")
							if(M != usr)
								M.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades [M]'s resistance mod by 0.1\n")
							del(src)
					if("Offense")
						if(M in range(1,usr))
							if(M.OffMod > 1.9)
								M.OffMod = 2
								usr << "They already have 2 in that mod."
								return
							var/N = M.Off / M.OffMod
							M.OffMod += 0.1
							M.Off = N * M.OffMod
							view(20,usr) << "[usr] inserts the [src] into [M].<p>"
							if(M != usr)
								usr << "<font color = teal>[M]'s potential for offense has been increased! Their offense mod went up by 0.1.     It is now [M.OffMod].<p>"
							M << "<font color = teal>Your potential for offense has increased! Your offense mod went up by 0.1.     It is now [M.OffMod].<p>"
							usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades [M]'s offense mod by 0.1\n")
							if(M != usr)
								M.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades [M]'s offense mod by 0.1\n")
							del(src)
					if("Defense")
						if(M in range(1,usr))
							if(M.DefMod > 1.9)
								M.DefMod = 2
								usr << "They already have 2 in that mod."
								return
							var/N = M.Def / M.DefMod
							M.DefMod += 0.1
							M.Def = N * M.DefMod
							view(20,usr) << "[usr] inserts the [src] into [M].<p>"
							if(M != usr)
								usr << "<font color = teal>[M]'s potential for defense has been increased! Their defense mod went up by 0.1.     It is now [M.DefMod].<p>"
							M << "<font color = teal>Your potential for defense has increased! Your defense mod went up by 0.1.     It is now [M.DefMod].<p>"
							usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades [M]'s defense mod by 0.1\n")
							if(M != usr)
								M.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades [M]'s defense mod by 0.1\n")
							del(src)
					if("Regeneration")
						if(M in range(1,usr))
							if(M.Regeneration > 1.9)
								M.Regeneration = 2
								usr << "They already have 2 in that mod."
								return
							M.Regeneration += 0.1
							view(20,usr) << "[usr] inserts the [src] into [M].<p>"
							if(M != usr)
								usr << "<font color = teal>[M]'s potential for regeneration has been increased! Their regeneration mod went up by 0.1.     It is now [M.Regeneration].<p>"
							M << "<font color = teal>Your potential for regeneration has increased! Your regeneration mod went up by 0.1.     It is now [M.Regeneration].<p>"
							usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades [M]'s regen mod by 0.1\n")
							if(M != usr)
								M.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades [M]'s regen mod by 0.1\n")
							del(src)
					if("Recovery")
						if(M in range(1,usr))
							if(M.Recovery > 1.9)
								M.Recovery = 2
								usr << "They already have 2 in that mod."
								return
							M.Recovery += 0.1
							view(20,usr) << "[usr] inserts the [src] into [M].<p>"
							if(M != usr)
								usr << "<font color = teal>[M]'s potential for recovery has been increased! Their recovery mod went up by 0.1.     It is now [M.Recovery].<p>"
							M << "<font color = teal>Your potential for recovery has increased! Your recovery mod went up by 0.1.     It is now [M.Recovery].<p>"
							usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades [M]'s recov mod by 0.1\n")
							if(M != usr)
								M.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades [M]'s recov mod by 0.1\n")
							del(src)
			else
				usr << "This can only be used on an Android."
				return
		else
			return
obj/items/Cloak
	icon='Cloak.dmi'
	desc="You can install this on any object to cloak it using cloak controls. First you must set the \
	password so that it matches the password of your cloak controls or it cannot be activated by those \
	controls."
	Stealable=1
	verb/Set() Password=input("Set the password for this cloak") as text
	verb/Use()
		if(!Password)
			usr<<"You must Set it first"
			return
		for(var/obj/A in get_step(usr,usr.dir))
			for(var/X in NoCloak)
				if(A.type == X)
					usr << "Unable to bend light around this item using a cloaking device....how strange..."
					return
			view(usr)<<"[usr] installs a cloaking system onto the [A]"
			for(var/mob/player/M in view(usr))
				if(!M.client) return
				M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] installs a cloaking system onto [A].\n")
			A.contents+=src
obj/items/Stun_Chip
	icon='Control Chip.dmi'
	Stealable=1
	desc="You can install this on someone and use the Stun Remote to stun them temporarily. To use the \
	remote to stun them your remote must share the same remote access code as the installed chip. \
	You can also use this to remove chips from somebody using the Remove command, both chips will be \
	destroyed in the process."
	New()
		name=initial(name)
		//..()
	verb/Use(mob/A in view(1,usr))
		if(A==usr||A.icon_state=="KO"||A.Frozen)
			view(usr)<<"[usr] installs a stun chip in [A]"
			for(var/mob/player/M in view(usr))
				if(!M.client) return
				M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] installs a stun chip in [A].\n")
			var/obj/Stun_Chip/B=new
			B.Password=input("Input a remote access code to activate the chip") as text
			A.contents+=B
			del(src)
	verb/Remove(mob/A in view(1,usr))
		for(var/obj/Stun_Chip/B in A)
			view(usr)<<"[usr] removes a Stun Chip from [A]"
			for(var/mob/player/M in view(usr))
				if(!M.client) return
				M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] removes a Stun Chip from [A].\n")
			del(B)
		del(src)
obj
	items
		Savable = 1
obj/Stun_Chip
	desc="You can install this on someone and use the Stun Remote to stun them temporarily. To use the \
	remote to stun them your remote must share the same remote access code as the installed chip. \
	You can also use this to remove chips from somebody using the Remove command, both chips will be \
	destroyed in the process."
	icon='Control Chip.dmi'
obj/items/Stun_Controls
	icon='Stun Controls.dmi'
	desc="You can use this to activate a stun chip you have installed on somebody. It only works \
	within your visual range."
	Stealable=1
	verb/Set() Password=input("Input a remote access code for activating nearby stun chips") as text
	verb/Use()
		view(usr)<<"[usr] activates their stun controls"
		for(var/mob/A in view(usr))
			A.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] activates their stun controls.\n")
			for(var/obj/Stun_Chip/B in A) if(B.Password==Password) A.KO("by stun chip!")
obj/items/Transporter_Pad
	icon='Telepad.dmi'
	desc="You can use this to transport yourself between other pads sharing the same remote access code"
	Stealable=1
	Level=1
	pixel_x=-1
	pixel_y=-13
	layer=3
	Savable = 1
	proc/Transport()
		var/list/A=new
		for(var/obj/items/Transporter_Pad/B) if(B!=src)
			if(Level<2&&B.z!=z&&B.z)
			else if(B.Password==Password&&B.z)
				A+=B
				var/restricted = list(15,9,10)
				var/al = list(13,5,6,7,13)
				var/lr = list(1,2,3,4,8,11,12,14,16)
				var/travel_al = 0
				if(B.z in al)
					travel_al = 1
				if(B.z in restricted)
					A-=B
				if(usr.z in al) if(travel_al == 0)
					A-=B
				if(usr.z in lr) if(travel_al)
					A-=B
		if(!A) return
		A+="Cancel"
		var/obj/items/Transporter_Pad/C=input("Go to which transporter?") in A
		if(C=="Cancel") return
		usr.overlays+='SBombGivePower.dmi'
		sleep(30)
		if(usr)
			usr.overlays-='SBombGivePower.dmi'
			usr.overlays-='SBombGivePower.dmi'
			if(C) usr.loc=C.loc
			usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] uses [src] to teleport to [C] ([C.x],[C.y],[C.z]) \n")
	verb/Set()
		set src in oview(1)
		if(!Password)
			Password=input("Set the indentification code, you can only transport to \
			other pads using the same code") as text
			name=input("Name the transporter pad, preferably name it after the location it will take you \
			to") as text
			if(!name) name=initial(name)
		else usr<<"It is already initialized"
	verb/Bolt()
		set src in oview(1)
		if(x&&y&&z&&!Bolted)
			Bolted=1
			range(20,src)<<"[usr] bolts the [src] to the ground."
			for(var/mob/player/M in view(src)) if(M.client) M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] bolts [src] to the ground.\n")
			return
		if(Bolted) if(src.Builder == "[key_name(usr)], [usr.client.address]")
			range(20,src)<<"[usr] un-bolts the [src] from the ground."
			Bolted=0
			for(var/mob/player/M in view(src)) if(M.client) M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] un-bolts [src] from the ground.\n")
			return
	verb/Upgrade()
		set src in oview(1)
		var/Cost=20000000/usr.Add
		for(var/obj/Resources/A in usr)
			if(A.Value>=Cost)
				A.Value-=Cost
				src.cost += Cost
				Level++
			else usr<<"Only with [Commas(Cost)] resources can you upgrade this, allowing to to travel between \
			planets."
obj/items/Transporter_Watch
	icon='Transporter Watch.dmi'
	desc="You can use this to transport yourself to any transporter pad that matches your watch's \
	remote access code"
	Level=1
	Stealable=1
	Savable = 1
	proc/Transport()
		var/list/A=new
		for(var/obj/items/Transporter_Pad/B)
			if(Level<2&&B.z!=usr.z&&B.z)
			else if(B.Password==Password&&B.z)
				A+=B
				var/restricted = list(15,9,10)
				var/al = list(13,5,6,7,13)
				var/lr = list(1,2,3,4,8,11,12,14,16)
				var/travel_al = 0
				if(B.z in al)
					travel_al = 1
				if(B.z in restricted)
					A-=B
				if(usr.z in al) if(travel_al == 0)
					A-=B
				if(usr.z in lr) if(travel_al)
					A-=B
		var/obj/items/Transporter_Pad/C=input("Go to which transporter?") in A
		usr.overlays+='SBombGivePower.dmi'
		sleep(120)
		usr.overlays-='SBombGivePower.dmi'
		usr.overlays-='SBombGivePower.dmi'
		if(C)
			usr.loc=C.loc
			usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] uses [src] to teleport to [C] ([C.x],[C.y],[C.z]) \n")
	verb/Use() if(icon_state!="KO") Transport()
	verb/Set() Password=input("Set the remote identification code.") as text
	verb/Upgrade()
		set src in oview(1)
		var/Cost=20000000/usr.Add
		for(var/obj/Resources/A in usr)
			if(A.Value>=Cost)
				A.Value-=Cost
				src.cost += Cost
				Level++
			else usr<<"Only with [Commas(Cost)] resources can you upgrade this, allowing to to travel between \
			planets."


/*
// Upgrading for poison serves no function other then to waste resources as the ANTIVIRUS does not need to be upgraded to cure level X of poison.
// As such, I've commented it out. -- Valekor
	verb/Upgrade()
		set src in oview(1)
		if(usr.Int_Level<Tech)
			usr<<"This is too advanced for you to mess with."
			return
		var/obj/Resources/A
		for(var/obj/Resources/B in usr) A=B
		var/Cost=1000/usr.Add
		var/Max_Upgrade=(A.Value/Cost)+Tech
		if(Max_Upgrade>usr.Int_Level) Max_Upgrade=usr.Int_Level
		var/Upgrade=input("Upgrade it to what level? (1-[round(Max_Upgrade)]). The maximum amount you can upgrade is determined by your intelligence (Max Upgrade cannot exceed Intelligence), and how much resources you have. So if the maximum is less than your intelligence then it is instead due to not having enough resources to upgrade it higher than the said maximum.") as num
		if(Upgrade>usr.Int_Level) Upgrade=usr.Int_Level
		if(Upgrade>Max_Upgrade) Upgrade=Max_Upgrade
		if(Upgrade<1) Upgrade=1
		Upgrade=round(Upgrade)
		if(Upgrade<Tech) switch(input("You wish to bring this Level [Tech] [src] to Level [Upgrade]?") in list("Yes","No"))
			if("No") return
		Cost*=Upgrade-Tech
		if(Cost<0) Cost=0
		if(Cost>A.Value)
			usr<<"You do not have enough resources to upgrade it to level [Upgrade]"
			return
		view(src)<<"[usr] upgrades the [src] to level [Upgrade]"
		A.Value-=Cost
		Tech=Upgrade
		desc="Level [Tech] [src]"
		Level=0.5+(Upgrade*0.1)
*/
/*
obj/items/Diarea_Injection
	Injection=1
	icon='Diarea Injection.dmi'
	Level=1
	Stealable=1
	verb/Use(mob/A in view(1,usr))
		if(A==usr|A.Frozen|A.icon_state=="KO")
			view(usr)<<"[usr] injects [A] with a mysterious needle!"
			A.Diarea+=Level
			del(src)
	verb/Upgrade()
		set src in oview(1)
		for(var/obj/Resources/A in usr)
			var/Amount=input("How many levels do you want to add? Up to [Commas(A.Value/10000*usr.Add)]") as num
			if(Amount>round(A.Value/10000*usr.Add)) Amount=round(A.Value/10000*usr.Add)
			if(Amount<0) Amount=0
			Level+=Amount
			A.Value-=Amount*10000/usr.Add
			view(usr)<<"[usr] upgraded the [src] to level [Level]"
		desc="Level [Level] [src]"
obj/items/T_Virus_Injection
	icon='T Virus.dmi'
	Level=1
	Stealable=1
	Injection=1
	verb/Use(mob/A in view(1,usr))
		if(A==usr|A.Frozen|A.icon_state=="KO")
			view(usr)<<"[usr] injects [A] with a mysterious needle!"
			var/Old_Zombied=A.Zombied
			A.Zombied+=Level*0.1
			if(!A.client)
				if(A.icon_state!="KO"&&Old_Zombied==1)
					A.Zombied=Old_Zombied
					//A.Mutate(Level)
				//else A.Zombies() //If its state is KO, its a body, and will turn into a zombie soon after.
				// NO! FUCK ZOMBIES!
			del(src)
	/*verb/Upgrade()
		set src in oview(1)
		for(var/obj/Resources/A in usr)
			var/Amount=input("How many levels do you want to add? Up to [Commas(A.Value/10000*usr.Add)]") as num
			if(Amount>round(A.Value/10000*usr.Add)) Amount=round(A.Value/10000*usr.Add)
			if(Amount<0) Amount=0
			Level+=Amount
			A.Value-=Amount*10000/usr.Add
			view(usr)<<"[usr] upgraded the [src] to level [Level]"
		desc="Level [Level] [src]"*/
*/




/*
// Commented this out. The upgrade for the ANTIVIRUS creates a new ANTIVIRUS TOWER
// Doesn't look like it has any use since a level 1 Antivirus just nullyfies any infection
	verb/Upgrade()
		set src in oview(1,usr)
		for(var/obj/Resources/A in usr)
			if(A.Value<20000000/usr.Add)
				usr<<"You need [Commas(20000000/usr.Add)] resources to build this."
				return
			A.Value-=20000000/usr.Add
			new/obj/Antivirus_Tower(loc)
			del(src)
*/

obj/items/layer=4



obj/items/Moon
	icon='Moon.dmi'
	Stealable=1
	desc="Using this may be unhealthy."
	var/Emitter
	verb/Use()
		set src in oview(1)
		if(icon_state=="On") return
		if(usr.Moon_Used == 0)
			view(usr)<<"[usr] activates the [src]!"
			icon_state="On"
			for(var/mob/player/M in view(usr))
				if(!M.client) return
				M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] activates the [src]!\n")

			for(var/mob/A in view(12,src))
				if(A.Moon_Used)
					A << "The effect of the moons rays don't seem to do anything for you at the moment, you must wait for [A.Moon_Used] months!"
				else
					A.Oozaru()
			usr.Moon_Used = 3
			spawn(10) if(src&&Emitter) for(var/mob/A in view(12,src)) if(A.ssjdrain>=300&&usr.Race=="Saiyan"&&usr.Hasssj > 0) A.Golden()
			spawn(100) if(src) del(src)
		else
			usr << "The strain of using that so soon would damage your body beyond recovery, you must wait for [usr.Moon_Used] months!"
			return
	verb/Upgrade()
		set src in oview(1)
		var/obj/Resources/A
		for(var/obj/Resources/B in usr) A=B
		var/list/Choices=new
		if(A.Value>=50000000*Tech/usr.Add&&!Emitter) Choices.Add("Turn into Emitter ([50000000*Tech/usr.Add])")
		if(!Choices)
			usr<<"You do not have enough resources"
			return
		var/Choice=input("Change what?") in Choices
		if(Choice=="Turn into Emitter ([50000000*Tech/usr.Add])")
			if(A.Value<50000000*Tech/usr.Add) return
			A.Value-=50000000*Tech/usr.Add
			Emitter=1
			name="Emitter"
			icon='Moon2.dmi'
		Tech++

obj/items/PDA
	icon='PDA.dmi'
	desc="This can be used to store information, even youtube videos if you know how."
	Stealable=1
	var/notes={"<html>
<head><title>Notes</title><body>
<center><body bgcolor="#000000"><font size=2><font color="#CCCCCC">
</body><html>"}
	verb/Name() name=input("") as text
	verb/View()
		set src in world
		usr<<browse(notes,"window= ;size=700x600")
	verb/Input()
		notes=input(usr,"Notes","Notes",notes) as message
		if( length(notes) > 800 )
			debuglog << "[__FILE__]:[__LINE__] || src: [src ? src : "null"] usr: [usr ? usr : "null"] client: [usr.client ? usr.client : "null"] message([length(notes)]): [notes]"
obj/items/Shuriken
	icon='Shuriken.dmi'
	Stealable=1
	desc="This is a ranged move based on the thrower's strength and the sharpness of the blade"
	verb/Shuriken()
		set category="Skills"
		var/obj/ranged/Blast/A=new
		A.Shuriken=1
		A.Shrapnel=1
		A.loc=usr.loc
		A.icon='Shuriken.dmi'
		A.density=1
		A.Damage=1000000
		A.Power=1000000
		A.Offense=1000
		A.Fatal=0
		walk(A,usr.dir)
		spawn(100) if(A) del(A)
obj/Well
	icon='props.dmi'
	icon_state="21"
	density=1
	var/effectiveness=2
	Savable=0
	Grabbable=0
	Spawn_Timer=180000
	New()
		for(var/obj/Well/A in range(0,src)) if(A!=src) del(A)
		//..()
	verb/Action()
		set category="Other"
		set src in oview(1)
		if(usr.icon_state!="Meditate"&&usr.icon_state!="Train")
			view(6)<<"<font color=red>* [usr] drinks some water. *"
			for(var/mob/player/M in view(6))
				if(!M.client) return
				M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] drinks some water.\n")
			if(usr.Health<100) usr.Health+=(100/effectiveness)
			if(usr.Ki<usr.MaxKi) if(!usr.Dead) usr.Ki+=(usr.MaxKi/effectiveness)
obj/items
	Main_Frame
		icon = 'android tech.dmi'
		icon_state = "main frame"
		Health = 10000000000000000000
		Bolted = 1
		Grabbable = 0
		Click()
			if(src in range(1,usr))
				for(var/obj/items/I in src)
					I.loc = usr.loc
					view(6,usr) << "[usr] removes a [I] from [src]."
					alertAdmins("[key_name(usr)] removed a [I] from [src]</b>!")
					hearers(6,usr) << 'pop.wav'
					break
		verb/Use()
			set src in range(1,usr)
			if(usr.Race == "Android")
				switch(input(usr, "Placing 20'000'000 resources into the mainframe will produce an Android Upgrade Component. Are you sure you want to continue?") in list("No", "Yes"))
					if("Yes")
						for(var/obj/Resources/R in usr)
							if(R.Value >= 20000000)
								R.Value -= 20000000
								var/obj/items/Android_Upgrade/AU = new
								AU.loc = usr.loc
								alertAdmins("[key_name(usr)] placed 20'000'000 resources into the [src] and it created a [AU].</b>!")
								view(6)<<"<font color=red> [usr] placed 20'000'000 resources into the [src] and it created a [AU]."
								usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] placed 20'000'000 resources into the [src] and it created a [AU]..\n")
								return
	Weights
		icon='Clothes_ShortSleeveShirt.dmi'
		Stealable=1
		Flammable = 1
		New()
			name="[round(Weight)]lb Weights"
			//..()
		Click() if(locate(src) in usr)
			var/CurrentWeight=0
			var/Weights=0
			if(!suffix) for(var/obj/Expand/A in usr) if(A.Using) return
			if(!suffix) for(var/obj/Majin/A in usr) if(A.Using) return
			for(var/obj/items/Weights/A in usr) if(A.suffix)
				CurrentWeight+=A.Weight
				Weights++
			if(!suffix&&Weights>=3)
				usr<<"You cannot wear more than 3 of these at once"
				return
			if(!suffix&&(CurrentWeight+Weight)>((usr.Str+usr.End)*2))
				usr<<"Putting this on would exceed your maximum lift of [Commas(round((usr.Str+usr.End)*2))] pounds. You cannot use it."
				return
			for(var/obj/Oozaru/A in usr) if(A.suffix) return
			if(!suffix)
				suffix="*Equipped*"
				usr.overlays+=icon
				view(20,usr) << "[usr] puts on the [src]."
				usr<<"You put on the [src]. Your max lift is [Commas(round((usr.Str+usr.End)*2))] pounds"
				usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] puts on the [src].\n")
			else
				suffix=null
				usr.overlays-=icon
				view(20,usr) << "[usr] takes off the [src]."
				usr<<"You take off the [src]. Your max lift is [Commas(round((usr.Str+usr.End)*2))] pounds"
				usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] removes the [src].\n")
	Regenerator
		Stealable=0
		Grabbable = 1
		Savable=1
		Can_Change = 0
		desc="Stepping into this will accelerate your healing rate. It heals faster the more upgraded \
		it is. It will break in the strain of high gravity."
		icon = 'New regen tank.dmi'
		New()
			//var/image/A=image(icon='Heal Tank.dmi',icon_state="top",pixel_y=32)
			//var/image/B=image(icon='Heal Tank.dmi',icon_state="bottom",pixel_y=-32)
			//overlays.Remove(A,B)
			//overlays.Add(A,B)
			src.pixel_x = -32
			src.pixel_y = -16
			spawn if(src) Regenerator_Loop()
			//..()
		proc/Regenerator_Loop() while(src)
			if(z) if(icon_state!="ez")
				if(z==0&&isnull(loc)) del(src)
				if(prob(5)) for(var/turf/A in range(0,src)) if(A.Gravity>10)
					icon_state="middlebroke"
					view(src)<<"The [src] is crushed by the force of the gravity!"
					for(var/mob/player/M in view(src))
						if(!M.client) return
						M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] is crushed by the force of the gravity.\n")
				for(var/mob/A in range(0,src)) if(A.Health<100)
					A.Health+= 1*Level*A.Regeneration
					if(A.icon_state=="KO"&&A.Health>=100) A.Un_KO()
			sleep(rand(10,90))
		layer=MOB_LAYER+1
		verb/Bolt()
			set src in oview(1)
			if(x&&y&&z&&!Bolted)
				Bolted=1
				range(20,src)<<"[usr] bolts the [src] to the ground."
				for(var/mob/player/M in view(src)) if(M.client) M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] bolts [src] to the ground.\n")
				return
			if(Bolted) if(src.Builder == "[key_name(usr)], [usr.client.address]")
				range(20,src)<<"[usr] un-bolts the [src] from the ground."
				Bolted=0
				for(var/mob/player/M in view(src)) if(M.client) M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] un-bolts [src] from the ground.\n")
				return
		/*verb/Upgrade()
			set src in oview(1)
			var/obj/Resources/A
			for(var/obj/Resources/B in usr) A=B
			var/list/Choices=new
			if(A.Value>=1000*Tech/usr.Add) Choices.Add("Heal Rate ([1000*Tech/usr.Add])")
			if(A.Value>=1000/usr.Add&&icon_state=="middlebroke") Choices+="Repair ([1000/usr.Add])"
			if(!Choices)
				usr<<"You do not have enough resources"
				return
			var/Choice=input("Change what?") in Choices
			if(Choice=="Cancel") return
			if(Choice=="Heal Rate ([1000*Tech/usr.Add])")
				if(A.Value<1000*Tech/usr.Add) return
				A.Value-=1000*Tech/usr.Add
				Level++
			if(Choice=="Repair ([1000/usr.Add])")
				if(A.Value<1000/usr.Add) return
				A.Value-=1000/usr.Add
				icon_state="middle"
			Tech++
			desc="[Level]x Heal Rate"*/
		verb/Upgrade()
			set src in oview(1)
			if(usr.Int_Level<Tech)
				usr<<"This is too advanced for you to mess with."
				return
			var/obj/Resources/A
			for(var/obj/Resources/B in usr) A=B
			var/Cost=20000/usr.Add
			var/Max_Upgrade=(A.Value/Cost)+Tech
			if(Max_Upgrade>usr.Int_Level) Max_Upgrade=usr.Int_Level
			var/Upgrade=input("Upgrade it to what level? (1-[round(Max_Upgrade)]). The maximum amount you can upgrade is determined by your intelligence (Max Upgrade cannot exceed Intelligence), and how much resources you have. So if the maximum is less than your intelligence then it is instead due to not having enough resources to upgrade it higher than the said maximum.") as num
			if(Upgrade>usr.Int_Level) Upgrade=usr.Int_Level
			if(Upgrade>Max_Upgrade) Upgrade=Max_Upgrade
			if(Upgrade<1) Upgrade=1
			Upgrade=round(Upgrade)
			if(Upgrade<Tech) switch(input("You wish to bring this Level [Tech] [src] to Level [Upgrade]?") in list("Yes","No"))
				if("No") return
			Cost*=Upgrade-Tech
			if(Cost<0) Cost=0
			if(Cost>A.Value)
				usr<<"You do not have enough resources to upgrade it to level [Upgrade]"
				return
			view(src)<<"[usr] upgrades the [src] to level [Upgrade]"
			for(var/mob/player/M in view(src))
				if(!M.client) return
				M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades [src] to level [Upgrade].\n")
			A.Value-=Cost
			src.cost += Cost
			Tech=Upgrade
			icon_state="middle"
			Level=0.1*Upgrade*0.01*rand(50,200)
			desc="Level [Tech] [src]"





obj/Money
	icon='Misc.dmi'
	icon_state="ZenniBag"
	var/getkey
	var/getIP

	verb/Drop()
		var/Money=input("Drop how much Money?") as num
		if(Money>usr.Money) Money=usr.Money
		if(Money<=0) usr<<"You must atleast drop 1 Money."
		if(Money>=1) if(isturf(usr.loc))
			Money=round(Money)
			usr.Money-=Money
			var/obj/Money/A=new
			A.loc=usr.loc
			A.Money=Money
			A.name="[Commas(A.Money)] Money"
			A.getkey=usr.key
			A.getIP=usr.client.address
			step(A,usr.dir)
			view(usr)<<"<font size=1><font color=teal>[usr] drops [Commas(Money)] Money."
			for(var/mob/player/M in view(usr)) if(M.client) M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] drops [Commas(Money)] Money\n")
			if(A.Money<100) A.icon_state="Zenni1"
			else if(A.Money<200) A.icon_state="Zenni2"
			else if(A.Money<500) A.icon_state="Zenni3"
			else if(A.Money<1000) A.icon_state="Zenni4"
			else
				A.icon_state="Zenni4"
				var/Size=round(A.Money/2000)
				var/Offset=10+round(A.Money/8000)
				if(Size>50) Size=50
				if(Offset>30) Offset=30
				while(Size&&src)
					Size-=1
					var/image/I=image(icon='Misc.dmi',icon_state="Zenni4",pixel_y=rand(-Offset,Offset),pixel_x=rand(-Offset,Offset))
					if(A) A.underlays.Add(I)
					sleep(1)
obj/var/Special_Ball = 0
obj/items

	Crystal_Ball
		icon='Magic Items.dmi'
		icon_state = "crystal ball"
		Health=100
		Stealable=1
		New()
			desc="<br>Clicking this will let you observe people....for a time...for a cost.."
			//..()
		Click()
			if(src in usr.client.screen)
				usr.client.screen.Remove(src)
				usr.client.eye=usr
				usr << "View returned to normal."
				return
			if(src in range(1,usr))
				if(usr.Magic_Level >= 25)
					if(src.Special_Ball)
						view(6,usr) << "[usr] activates their crystal ball..."
						var/list/P = list()
						for(var/mob/M in Players)
							if(M.z == 1)
								P += M
						var/mob/O=input(usr,"Choose someone to observe.") as mob in P
						usr << "You are now watching [O] through your crystal ball."
						usr.Get_Observe(O)
						src.screen_loc = "1,1"
						usr.client.screen.Add(src)
						return
					if(src.Health < 100000)
						usr << "The crystal ball must have at least 100,000 mana to work!"
						return
					if(src.Health >= 100000)
						view(6,usr) << "[usr] activates their crystal ball..."
						var/mob/O=input(usr,"Choose someone to observe.") as mob in Players
						usr << "You are now watching [O] through your crystal ball."
						usr.Get_Observe(O)
						src.Health -= 100000
						desc="<br>Clicking this will let you observe people....for a time...for a cost..<br>[Commas(Health)] Durability Crystal Ball"
						src.screen_loc = "1,1"
						usr.client.screen.Add(src)
						return
				else
					usr << "You do not possess enough magic skill to use that item."
					return
		verb/Enhance()
			set src in oview(1)
			var/obj/Mana/A
			for(var/obj/Mana/B in usr) A=B
			var/Amount=round(input("Add how much mana to this crystal ball?") as num)
			if(Amount>A.Value) Amount=A.Value
			if(Amount<0) Amount=0
			A.Value-=Amount
			Amount*=usr.Magic_Potential
			Health+=Amount
			desc="<br>Clicking this will let you observe people....for a time...for a cost..<br>[Commas(Health)] Durability Crystal Ball"
			view(usr)<<"[usr] adds +[Commas(Amount)] to the [src]"
			for(var/mob/player/M in view(usr))
				if(!M.client) return
				M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] adds +[Commas(Amount)] to the [src].\n")

	Boxing_Gloves
		icon='Boxing Gloves.dmi'
		Health=100
		Stealable=1
		Flammable = 1
		New()
			desc="<br>Equipping these make your hits alot less powerful, good for sparring."
			//..()
		Click()
			if(src in usr)
				for(var/obj/items/Boxing_Gloves/A in usr) if(A!=src) if(A.suffix)
					usr<<"You already have a set of boxing gloves equipped."
					return
				if(!suffix)
					suffix="*Equipped*"
					usr.overlays+=icon
					view(20,usr) << "[usr] puts on the [src]."
					usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] equips [src]\n")
					return
				else
					suffix=null
					usr.overlays-=icon
					view(20,usr) << "[usr] removes the [src]."
					usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] removes [src]\n")
					return
	Sword
		icon='Sword_Trunks.dmi'
		Health=1000
		Stealable=1
		Savable = 1
		New()
			desc="<br>+[Commas(Health)] BP to each melee attack. However this bonus cannot exceed \
		double your own BP no matter how great the sword is. Swords are twice as easy to evade for your \
		Opp compared to melee attacks."
			//..()
		Click()
			if(src in usr)
				for(var/obj/items/Sword/A in usr) if(A!=src) if(A.suffix)
					usr<<"You already have a sword equipped."
					return
				if(!suffix)
					suffix="*Equipped*"
					usr.Equip_Magic(src,"Add")
					usr.overlays+=icon
					view(20,usr) << "[usr] puts on the [src]."
					usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] equips [src]\n")
					return
				else
					suffix=null
					usr.overlays-=icon
					usr.Equip_Magic(src,"Remove")
					view(20,usr) << "[usr] removes the [src]."
					usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] removes [src]\n")
					return
		verb/Upgrade()
			set src in oview(1)
			var/obj/Resources/A
			for(var/obj/Resources/B in usr) A=B
			var/Amount=round(input("Add how much resources to this sword's attack power?") as num)
			if(Amount>A.Value) Amount=A.Value
			if(Amount<0) Amount=0
			A.Value-=Amount
			src.cost += Amount
			Amount*=usr.Add
			Health+=Amount
			view(usr)<<"[usr] adds [Commas(Amount)] to the [src]"
			for(var/mob/player/M in view(usr)) if(M.client) M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] adds [Commas(Amount)] to the [src]\n")
			desc="<br>+[Commas(Health)] BP to each melee attack. However this bonus cannot exceed \
		double your own BP no matter how great the sword is. Swords are twice as easy to evade for your \
		Opp compared to melee attacks."
		Knight_Sword icon='Sword 2.dmi'
		Demon_Sword icon='Sword 1.dmi'
		Katana icon='Item - Katana 2.dmi'
		Random_Sword icon='Item - Katana.dmi'
		Short_Sword icon='Short Sword.dmi'
		Rebellion icon='Item, Sword 1.dmi'
		Buster_Sword icon='Item, Buster Sword.dmi'
		Dual_Blaze icon='Item, Dual Blaze Sword.dmi'
		Dual_Electric icon='Item, Dual Electric Sword.dmi'
		Great_Sword icon='Item, Great Sword.dmi'
		Flame_Sword icon='Sword Flame.dmi'
		Double_Katana icon='Sword, 2 Katanas.dmi'
		Samurai icon='Sword, Samurai.dmi'
	Digging
		var/DigMult=1
		Shovel
			icon='Shovel.dmi'
			desc="This will help increase the speed at which you can dig up resources."
			DigMult=5
			Flammable = 1
			Click() if(src in usr)
				for(var/obj/items/Digging/A in usr) if(A!=src&&A.suffix)
					usr<<"You already have one equipped."
					return
				if(!suffix) suffix="*Equipped*"
				else suffix=null
				usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] [suffix ? "Equips" : "Unqequips"] the [src]\n")
		Hand_Drill
			icon='Drill Hand 2.dmi'
			desc="This will help increase the speed at which you can dig up resources."
			DigMult=25
			Click() if(src in usr)
				for(var/obj/items/Digging/A in usr) if(A!=src&&A.suffix)
					usr<<"You already have one equipped."
					return
				if(!suffix) suffix="*Equipped*"
				else suffix=null
				usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] [suffix ? "Unequips" : "Equips"] the [src]\n")


obj/items/Gun
	Turret
		var/multitrack = 0 //Allows multiple targets.
		var/homing = 0 // Allows homing projectiles.
		var/lethal = 0 // Allows turret to KO or Kill.
		var/mob/target // For single-targeting.
		var/refire = 10 // Delay in ticks, between shots.
		Force = 500 // Damage Calculation purposes.
		var/activated = 0 // Allows turrets to be enabled or disabled.
		var/explosive = 0 // Allows explosive rounds.
		var/shockwave = 0 // Allows rounds with knockback.
		Damage_Percent = 20
		density=1
		Health=5000
		Deviation = 3
		Precision = 100000
		icon='Turret.dmi'
		New()
			..()
			Turret_AI()
obj/items/Gun/Turret
	verb
		Toggle_Power()
			set src in oview(1)
			for(var/obj/items/Door_Pass/O in usr.contents)
				if(O.Password == src.Password)
					if(src.activated)
						src.activated = 0
						usr << "Turret deactivated."
					else
						src.activated = 1
						usr << "WARNING: Turret activated."

		Set_Password()
			set src in oview(1)
			if(!src.Password)
				src.Password = input(usr,"Please specify the password for the turret.","Password") as text
				usr << "Password set."
			else
				for(var/obj/items/Door_Pass/O in usr.contents)
					if(O.Password == src.Password)
						src.Password = input(usr,"Please specify the password for the turret.","Password") as text
						usr << "Password changed."

	proc
		Turret_AI()
			set background = 1
			while(src)
				if(src.activated)
					var/tmp/list/friendlies = new
					for(var/mob/M in range(5+(src.Level/10),src))

						for(var/obj/items/Door_Pass/O in M.contents)
							if(O.Password == src.Password)
								if(!friendlies.Find(M))
									friendlies += M

						if(!friendlies.Find(M))
							src.dir = get_dir(src,M)
							if(src.multitrack)
								spawn()
									src.LockOn(M)
							else
								if(!src.target)
									src.target = M
									spawn()
										src.LockOn()
				sleep(10)


		LockOn(mob/M)
			if(src.activated)
				if(src.multitrack)
					spawn()
						while (M in range(5+(src.Level/10),src))
							if(lethal)
								if(homing)
									src.HS(M)
									sleep(refire)
								else
									src.SS(get_dir(src,M))
									sleep(refire)
							else
								if(M.icon_state != "KO")
									if(homing)
										src.HS(M)
										sleep(refire)
									else
										src.dir = get_dir(src,M)
										src.SS()
										sleep(refire)
				else
					if(src.target)
						spawn()
							while(src.target in range(5+(src.Level/10),src))
								if(lethal)
									if(homing)
										src.HS(src.target)
										sleep(refire)
									else
										src.SS(get_dir(src,src.target))
										sleep(refire)
								else
									if(M.icon_state != "KO")
										if(homing)
											src.HS(src.target)
											sleep(refire)
										else
											src.dir = get_dir(src,src.target)
											src.SS()
											sleep(refire)
									else
										src.target = null
							if(!src.target in range(5+(src.Level/10),src))
								src.target = null



		HS(mob/M)
			var/obj/ranged/Blast/A=new
			A.density=0
			A.Belongs_To=src
			A.icon='1.dmi'
			A.loc=get_step(src,turn(src.dir,pick(NORTH,SOUTH,EAST,WEST,NORTHWEST,NORTHEAST,SOUTHWEST,SOUTHEAST)))
			if(src.explosive)
				A.Explosive=1
			if(src.shockwave)
				A.Shockwave=1
			var/Damage_Formula=0.1*Damage_Percent*Battle_Power*Force*(Tech**4)
			var/Power_Formula=0.1*Damage_Percent*Battle_Power*(Tech**4)
			A.Damage=Damage_Formula
			A.Power=Power_Formula
			A.Offense=src.Precision
			if(A) A.dir=pick(NORTH,SOUTH,EAST,WEST,NORTHEAST,NORTHWEST,SOUTHEAST,SOUTHWEST)
			spawn while(prob(90))
				if(prob(80)) if(A) step(A,A.dir)
				else step_rand(A)
			spawn(rand(90,110)/2) if(A)
				A.density=1
				if(M) walk_towards(A,M)
		SS()
			var/obj/ranged/Blast/A=new
			Belongs_To=src
			A.pixel_x=rand(-Deviation,Deviation)
			A.pixel_y=rand(-Deviation,Deviation)
			A.icon='1.dmi'
			var/Damage_Formula=0.1*Damage_Percent*Battle_Power*Force*(Tech**4)
			var/Power_Formula=0.1*Damage_Percent*Battle_Power*(Tech**4)
			A.Damage=Damage_Formula
			A.Power=Power_Formula
			A.Offense=src.Precision
			A.Shockwave=src.explosive
			A.Explosive=src.shockwave
			A.dir=usr.dir
			A.loc=usr.loc
			walk(A,A.dir,Velocity)


obj/items/Gun/Turret
	New()
		..()
		Turret_AI()


obj/items/TV
	icon='Lab.dmi'
	icon_state="tv"
	Health=1000
	Grabbable=1
	density=1
	desc="You've discovered the worlds greatest time waster!"

obj/items/Bookcase
	icon='Lab.dmi'
	icon_state="Books"
	Flammable = 1
	New()
		var/image/A=image(icon='Lab.dmi',icon_state="BooksTop",layer=layer,pixel_y=32,pixel_x=0)
		overlays.Add(A)
	Health=1000
	Grabbable=1
	density=1
	layer=4
	desc="It's a book-case.  Which is obviously used for storing books.  Now if only you had something to read..."

obj/items/Medicine_Cabinet
	icon='Lab.dmi'
	icon_state="Cabnit"
	New()
		var/image/A=image(icon='Lab.dmi',icon_state="CabnitTop",layer=layer,pixel_y=32,pixel_x=0)
		overlays.Add(A)
	Health=1000
	Grabbable=1
	Flammable = 1
	density=1
	layer=4
	desc="It's a cabinet.  One that's typically used for storing medicine or laboratory supplies.  It looks quite well built.  Now you just need to find something to put in it!"
