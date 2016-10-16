mob
	var
		last_icon = null
	proc
		Eject(var/obj/A)
			A.loc = src.loc
			A.suffix = null
			if(src.hair)
				src.overlays += src.hair
			src.icon = src.last_icon
			A.icon_state = "idle"
			view(20,src) << "[src] leaves the power armor!"
			src.BP_Multiplier /= 1.33
			src.Str /= 1.25
			src.StrMod /= 1.25
			src.End /= 1.25
			src.EndMod /= 1.25
			src.Res /= 1.25
			src.ResMod /= 1.25
			src.Spd/=0.8
			src.SpdMod/=0.8
			src.Lungs -= 1
			if(A.Health <= 0)
				A.icon_state = "broken"
			A.desc="<br>This is a suit of power armor. Entering it will confer +25% Strength, Durability, Resistance and increase Power by 33% but reduce your speed by -25%.\
		Like normal armor, you may upgrade it using resources. Unlike normal armor, it will block 75% of melee attacks, instead of 50%. \
		Once the armor is reduced to 0 durability, it will break and eject its user. To exit or enter the armor, simply use the associated verb.  \
		The suit can be grabbed and moved like a prop. It will also protect you from space, drowning and freezing. Requires 100 intelligence to enter and use.\
		[Commas(A.Health)] Durability Power Armor"
obj/items/Adamantine_Skeleton
	Health = 10000000000000000000000000000000000000000000000000000000000000000000000000
	Grabbable = 1
	Stealable=0
	density=1
	Savable=1
	icon = 'Adamantine Tech.dmi'
	New()
		desc="<br>This Adamantine Skeleton is utterly indestructible and will prevent you from taking limb damage and will even increase your durability by 10%. However, there are risks involved when applying it to you body, such as the process knocking you out completely and breaking all your bones to replace them with metal. You must have a fairly high intelligence to use this safely otherwise there is a 50% chance you will die, unless you are in a regen tank, which is only a 25% to die."
	verb/Use()
		if(src in usr)
			if(src.suffix == "Applied")
				return
			if(usr.Race == "Android" || usr.Race == "Majin")
				usr << "Your race is unable to make use of this."
				return
			if(usr.Limb_Res >= 100)
				usr << "Your limbs are already immune to being broken."
				return
			if(src.suffix != "Applied")
				var/txt = null
				var/Chance = 50
				for(var/obj/items/Regenerator/R in view(0,usr))
					Chance = 25
				if(usr.Int_Level < 80)
					txt = "There is a [Chance]% chance you will die from this due to your intelligence being lower than 80."
				switch(input("Are you sure you want to proceed? [txt]") in list("No","Yes"))
					if("Yes")
						var/L = list("Left Arm","Right Arm","Left Leg","Right Leg")
						for(var/mob/player/M in view(usr))
							if(!M.client) return
							M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] applies the [src]..\n")
						view(6,usr) << "<font color = grey>[usr] applies the [src] to their body!"
						if(txt)
							if(prob(Chance))
								usr.Death("applying the [src] to their body!")
								src.loc = usr.loc
								return
							else
								usr.KO("applying the [src] to their body!")
								usr.Injure_Hurt(100,L,usr)
								usr.EndMod*=1.1
								usr.End*=1.1
								usr.Limb_Res += 100
								src.loc = usr
								src.suffix = "Applied"
								return
						else
							usr.KO("applying the [src] to their body!")
							usr.Injure_Hurt(100,L,usr)
							usr.EndMod*=1.1
							usr.End*=1.1
							usr.Limb_Res += 100
							src.loc = usr
							src.suffix = "Applied"
							return
obj/items/Android_Chassis
	Health = 1000
	Grabbable = 1
	Stealable=0
	density=1
	Savable=1
	icon = 'Android Chasis.dmi'
	New()
		desc="<br>This is an Android Chassis. It's nearly finished and only requires a player to log into it to become active."
obj/items/Power_Armor
	Health = 1000
	Grabbable = 1
	Stealable=0
	density=1
	Savable=1
	icon = 'Power Armour.dmi'
	icon_state = "idle"
	New()
		desc="<br>This is a suit of power armor. Entering it will confer +25% Strength, Durability, Resistance and increase Power by 33% but reduce your speed by -25%.\
		Like normal armor, you may upgrade it using resources. Unlike normal armor, it will block 75% of melee attacks, instead of 50%. \
		Once the armor is reduced to 0 durability, it will break and eject its user. To exit or enter the armor, simply use the associated verb.  \
		The suit can be grabbed and moved like a prop. It will also protect you from space, drowning and freezing. Requires 100 intelligence to enter and use.\
		[Commas(Health)] Durability Power Armor"
	verb/Set_Password()
		set src in oview(1)
		if(src.password == " ")
			password=input("Choose a password for this device.") as text
			usr << "Password set."
			return
		else
			usr << "This device already has a password set."
			return
	verb/Upgrade()
		set src in oview(1)
		var/obj/Resources/A
		for(var/obj/Resources/B in usr) A=B
		var/Amount=round(input("Add how much resources to this armor's durability?") as num)
		if(Amount>A.Value) Amount=A.Value
		if(Amount<0) Amount=0
		A.Value-=Amount
		src.cost += Amount
		src.icon_state = "idle"
		Amount*=usr.Add
		Health+=Amount
		desc="<br>This is a suit of power armor. Entering it will confer +25% Strength, Durability, Resistance and increase Power by 33% but reduce your speed by -25%.\
		Like normal armor, you may upgrade it using resources. Unlike normal armor, it will block 75% of melee attacks, instead of 50%. \
		Once the armor is reduced to 0 durability, it will break and eject its user. To exit or enter the armor, simply use the associated verb.  \
		The suit can be grabbed and moved like a prop. It will also protect you from space, drowning and freezing. Requires 100 intelligence to enter and use.\
		[Commas(Health)] Durability Power Armor"
		view(usr)<<"[usr] adds +[Commas(Amount)] to the [src]"
		for(var/mob/player/M in view(usr))
			if(!M.client) return
			M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] adds +[Commas(Amount)] to the [src].\n")

	verb/Use_Power_Armor()
		set src in view(1)
		if(src.loc == usr) if(usr.icon_state != "KO")
			usr.Eject(src)
			return
		for(var/obj/Oozaru/O in usr)
			O.suffix="Active"
			usr << "Can't do that while in Oozaru."
			return
		if(usr.Int_Level < 100)
			usr << "You need an intelligence level of at least 100 in order to understand how to operate the complex controls used in this suit of power armor!"
			return
		for(var/obj/Expand/A in usr) if(A.Using)
			usr << "Unable to enter power armor while you're expanding."
			return
		var/p=input("Input password.") as text
		if(src in range(1,usr)) if(src.loc != usr) if(src.Health > 0) if(usr.Int_Level >= 100) if(usr.icon_state != "KO") if(p == src.password)
			for(var/obj/items/Armor/A in usr)
				if(A.suffix)
					A.suffix=null
					usr.Equip_Magic(A,"Remove")
					usr.overlays-=A.icon
					view(20,usr) << "[usr] removes the [A]."
					usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] removes [A]\n")
			for(var/mob/M in range(1,src))
				if(M.GrabbedMob == src)
					usr << "You're unable to enter power armor that is being carried by someone."
					return
			var/already_wearing = 0
			for(var/obj/items/Power_Armor/A in usr)
				already_wearing = 1
				break
			if(!already_wearing)
				usr.last_icon = usr.icon
				src.icon_state = ""
				usr.icon = src.icon
				if(usr.hair)
					usr.overlays -= usr.hair
				for(var/obj/I in usr)
					if(I.suffix) if(I.Tech!=100000)
						usr.Equip_Magic(I,"Remove")
						usr.Clothes_Equip(I)
				usr.loc = src.loc
				src.loc = usr
				src.suffix = "*Equipped*"
				view(20,usr) << "[usr] enters the power armor!"
				usr.Equip_Magic(src,"Add")
				usr.BP_Multiplier *= 1.33
				usr.Str *= 1.25
				usr.StrMod *= 1.25
				usr.End *= 1.25
				usr.EndMod *= 1.25
				usr.Res *= 1.25
				usr.ResMod *= 1.25
				usr.Spd*=0.8
				usr.SpdMod*=0.8
				usr.Lungs += 1
				return
			else
				usr << "You can't enter more than one suit of power armor at a time!"
				return
		if(src.Health <= 0)
			src.icon_state = "broken"
			usr << "You need to repair this armor using the Upgrade verb before you can use it again."
			return
	Click()
		if(src.suffix == "*Equipped*")
			usr << "Click the Use Power Armor verb to exit this suit."
obj/items/Bandages
	Health=100
	Stealable=1
	Flammable = 1
	icon = 'Torso Bandage.dmi'
	desc = "These are bandages. Equipping them gives you a +25% increase to your regeneration for two minutes. Using them in battle makes them wear away."
	New()
		spawn(3000)
			if(src)
				if(ismob(src.loc))
					if(src.suffix=="*Equipped*")
						var/mob/X = src.loc
						X.Regeneration /= 1.25
						X.overlays-=icon
						view(20,X) << "[X]'s [src] fall away, having served their use."
						del(src)
	verb
		Use_on(mob/M in oview(1))
			for(var/obj/items/Bandages/B in M)
				if(B.suffix)if(B!=src)
					usr<<"They already have bandages equipped."
					return
			src.suffix="*Equipped*"
			M.overlays+=src.icon
			view(20,usr) << "[usr] puts [src] on [M]."
			usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] equips [src] on [M].\n")
			M.Regeneration *= 1.25
			src.loc = M
			spawn(3000)
				if(src)
					if(ismob(src.loc))
						if(src.suffix=="*Equipped*")
							var/mob/X = src.loc
							X.Regeneration /= 1.25
							X.overlays-=icon
							view(20,X) << "[X]'s [src] fall away, having served their use."
							del(src)
	Click()
		if(src in usr)
			for(var/obj/items/Bandages/B in usr)
				if(B.suffix)if(B!=src)
					usr<<"You already have bandages equipped."
					return
			if(!suffix)
				suffix="*Equipped*"
				usr.overlays+=icon
				view(20,usr) << "[usr] puts on the [src]."
				usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] equips [src]\n")
				usr.Regeneration *= 1.25
				spawn(3000)
					if(src)
						if(ismob(src.loc))
							if(src.suffix=="*Equipped*")
								var/mob/M = src.loc
								M.Regeneration /= 1.25
								M.overlays-=icon
								view(20,M) << "[M]'s [src] fall away, having served their use."
								del(src)
				return
			else
				usr.overlays-=icon
				view(20,usr) << "[usr] takes off the [src]."
				usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] removes [src]\n")
				usr.Regeneration /= 1.25
				del(src)
				return
obj/items/Armor
	Health=100
	Stealable=1
	New()
		desc="<br>[Commas(Health)] Durability Armor"
		//..()
	verb/Upgrade()
		set src in oview(1)
		var/obj/Resources/A
		for(var/obj/Resources/B in usr) A=B
		var/Amount=round(input("Add how much resources to this armor's durability?") as num)
		if(Amount>A.Value) Amount=A.Value
		if(Amount<0) Amount=0
		A.Value-=Amount
		src.cost += Amount
		Amount*=usr.Add
		Health+=Amount
		desc="<br>[Commas(Health)] Durability Armor"
		view(usr)<<"[usr] adds +[Commas(Amount)] to the [src]"
		for(var/mob/player/M in view(usr))
			if(!M.client) return
			M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] adds +[Commas(Amount)] to the [src].\n")

	Click()
		if(src in usr)
			for(var/obj/items/Armor/A in usr)
				if(A.suffix)if(A!=src)
					usr<<"You already have armor equipped."
					return
			for(var/obj/items/Power_Armor/A in usr)
				if(A.suffix)if(A!=src)
					usr<<"You already have armor equipped."
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
				usr.Equip_Magic(src,"Remove")
				usr.overlays-=icon
				view(20,usr) << "[usr] removes the [src]."
				usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] removes [src]\n")
				return

obj/items/Armor/Armor1
	icon='Armor1.dmi'

obj/items/Armor/Heroic_Armor
	icon='BardockArmor.dmi'

obj/items/Armor/Green_Armor
	icon='TurlesArmor.dmi'

obj/items/Armor/Armor_Black
	icon='Nappa Armor.dmi'

obj/items/Armor/Armor2
	icon='Armor2.dmi'

obj/items/Armor/Armor3
	icon='Armor3.dmi'

obj/items/Armor/Armor4
	icon='Armor4.dmi'

obj/items/Armor/Armor5
	icon='Armor5.dmi'

obj/items/Armor/Armor6
	icon='Armor6.dmi'

obj/items/Armor/Armor7
	icon='Armor7.dmi'

obj/items/Armor/Armor8
	icon='White Male Armor.dmi'