var/list/glob_Phylactery
proc/Phylactery_Awaken(var/mob/player/P,var/obj/items/Phylactery/chosenPhylactery)

	P << "<span class=announce>Your soul finds its way back to its Phylactery by which it is tethered. Through magic, a new body begins to form around the arcane device where your heart should be. This process will take [chosenPhylactery.reviveTime/600] minutes.</span>"
	chosenPhylactery.playerRevival=P
	chosenPhylactery.underlays = null
	P.insidePhylactery=chosenPhylactery
	chosenPhylactery.Bolted = 1
	P.forbidMovement=1 // Dont want them to move until the tank is 'done'
	if(P.icon_state == "KO") P.Un_KO(1) // They need to be up.
	P.overlays-='Halo Custom.dmi'
	P.Dead=0
	P.dir=SOUTH
	P.Health = 100
	P.Ki = P.MaxKi
	sleep(chosenPhylactery.reviveTime)
	if(!P||!chosenPhylactery){return}
	chosenPhylactery.playerRevival = null // make sure that they dont get killed once the tank gets blown up and they're already out.
	chosenPhylactery.Bolted = 0
	P << "<span class=announce>The process is complete and the Phylactery falls out of an open cavity in your chest where your heart should of been. The wound quickly seals. You are whole again!</span>"
	P.insidePhylactery=null
	step(P,SOUTH)
	P.forbidMovement=0
	P.Heart_Virus_Cure()
	var/L = list("Head","Left Arm","Right Arm","Right Leg","Left Leg","Torso","Throat","Hearing","Mating Ability")
	P.Injure_Hurt(100,L)
	P << "<font color = red>You feel very weak from the process."
proc/Phylactery_Detection(var/mob/player/P)

	var/obj/items/Phylactery/chosenPhylactery = Has_Phylactery(P)

	if(chosenPhylactery)
		P.loc=chosenPhylactery.loc
		P.saveToLog("| [P.client.address ? (P.client.address) : "IP not found"] | ([P.x], [P.y], [P.z]) | [key_name(src)] has been revived by their [chosenPhylactery] Phylactery.\n")
	if(chosenPhylactery) Phylactery_Awaken(P,chosenPhylactery)
proc/checkNullPhylactery(var/mob/player/P)
	for(var/obj/items/Phylactery/phy in glob_Phylactery)
		if(ismob(phy.loc))
			if(phy.Password=="[P.real_name] ([P.key])")
				var/mob/m = phy.loc
				m << "You are forced to drop the [phy]."
				phy.loc = m.loc
		else if(isobj(phy.loc))
			var/obj/o = phy.loc
			phy.loc = o.loc
		else if(phy.z == 0)
			glob_Phylactery-=phy
			del phy
proc/Has_Phylactery(var/mob/player/P)
	checkNullPhylactery(P)
	for(var/obj/items/Phylactery/phy in glob_Phylactery)
		if(phy.Password=="[P.real_name] ([P.key])"&&P.Dead)
			return phy
			break
obj/items/Phylactery
	icon = 'Magic Items.dmi'
	icon_state = "soul stone"
	name = "Phylactery"
	Stealable=1
	density = 1
	Health = 1000
	Can_Change = 0
	var/mob/player/playerRevival
	var/reviveTime=6000 // 10 minutes.
	desc="This will revive you each time you are killed. \
	This is the most efficient model of cloner, \
	taking the least amount of decline per death and requiring the least amount of time to activate your body.  \
	Each time you are cloned and the cloner is activated, you lose decline."

	verb/Use()
		set src in oview(1)
		if(usr.Phylactery)
			usr << "You already have a Phylactery which stores your soul."
			return
		if(src.Password)
			usr << "A soul has already been set for this Phylactery."
			return
		if(usr.Dead)
			usr<<"Dead people cannot use this"
			return
		usr<<""
		src.icon_state = "soul stone active"
		usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has set [src] to clone themselves.\n")
		Password="[usr.real_name] ([usr.key])"
	New()
		..()
		if(!glob_Phylactery) glob_Phylactery=new // If the list hasn't been created yet, create a new one.
		//if(z!=0)
		glob_Phylactery+=src
	Del()

		if(glob_Phylactery)
			//src.Password=null
			glob_Phylactery-=src
			if(!glob_Phylactery|!glob_Phylactery.len) glob_Phylactery=null

		for(var/mob/M in Players)
			if(src.Password=="[M.real_name] ([M.key])")
				var/turf/T = src.loc
				T.Explosion(M)
				M.saveToLog("| [M.client.address ? (M.client.address) : "IP not found"] | ([M.x], [M.y], [M.z]) | [key_name(M)]'s Phylactery was destroyed at [src.x],[src.y],[src.z].\n")
				alertAdmins(" | ([M.x], [M.y], [M.z]) | [key_name(M)] 's Phylactery was destroyed at [src.x],[src.y],[src.z].\n")
				M.Death(M)
		..()
turf
	proc
		Explosion(var/mob/M)
			for(var/turf/A in range(6,src))
				spawn(1)
					for(var/mob/B in A)
						if(prob(25))
							var/L = list("Hearing")
							B.Injure_Hurt(100,L)
						if(B.icon_state == "Flight") if(prob(50))
							view(20,B) << "[B] is sucked to the ground by the force of the explosion!"
							B.Flight_Land()
						if(B.icon_state!="Flight")
							B.Health-=30*(M.Pow/B.Res)*(M.BP/B.BP)
							if(B.Health<=0)
								if(B.client) spawn B.KO("[M]")
								else spawn B.Death("[M]")
					for(var/obj/B in A)
						B.Health-=M.Pow*5
						if(B.Health<=0)
							new /obj/BigCrater(locate(B.x,B.y,B.z))
							del(B)
					new/obj/Explosion(A)
					if(!A.density)
						A.Health=0
						if(M!=0) A.Destroy(M,M.key)
						else A.Destroy("Unknown","Unknown")
					else
						A.Health -= M.Pow*5
						if(M!=0) A.Destroy(M,M.key)
						else A.Destroy("Unknown","Unknown")
mob
	proc
		Equip_Magic(var/obj/I,var/State,var/Ver)
			if(I)
				var/N = 1
				if(I.magical) if(State == "Add")
					src << "The magic from this item empowers you."
					src.overlays -= /obj/magic_effects/tele
					src.overlays += /obj/magic_effects/tele
					src.Remove_Effects()
				if(I.add_bp)
					N = N + I.add_bp
					if(State == "Add")
						src.BP_Multiplier *= N
					if(State == "Remove")
						src.BP_Multiplier /= N
					if(!Ver)
						N = 1
				if(I.add_energy)
					N = N + I.add_energy
					if(State == "Add")
						src.MaxKi *= N
						src.KiMod *= N
					if(State == "Remove")
						src.MaxKi /= N
						src.KiMod /= N
						if(src.Ki > src.MaxKi)
							src.Ki = src.MaxKi
					if(!Ver)
						N = 1
				if(I.add_str)
					N = N + I.add_str
					if(State == "Add")
						src.Str *= N
						src.StrMod *= N
					if(State == "Remove")
						src.Str /= N
						src.StrMod /= N
					if(!Ver)
						N = 1
				if(I.add_end)
					N = N + I.add_end
					if(State == "Add")
						src.End *= N
						src.EndMod *= N
					if(State == "Remove")
						src.End /= N
						src.EndMod /= N
					if(!Ver)
						N = 1
				if(I.add_spd)
					N = N + I.add_spd
					if(State == "Add")
						src.Spd *= N
						src.SpdMod *= N
					if(State == "Remove")
						src.Spd /= N
						src.SpdMod /= N
					if(!Ver)
						N = 1
				if(I.add_force)
					N = N + I.add_force
					if(State == "Add")
						src.Pow *= N
						src.PowMod *= N
					if(State == "Remove")
						src.Pow /= N
						src.PowMod /= N
					if(!Ver)
						N = 1
				if(I.add_res)
					N = N + I.add_res
					if(State == "Add")
						src.Res *= N
						src.ResMod *= N
					if(State == "Remove")
						src.Res /= N
						src.ResMod /= N
					if(!Ver)
						N = 1
				if(I.add_off)
					N = N + I.add_off
					if(State == "Add")
						src.Off *= N
						src.OffMod *= N
					if(State == "Remove")
						src.Off /= N
						src.OffMod /= N
					if(!Ver)
						N = 1
				if(I.add_def)
					N = N + I.add_def
					if(State == "Add")
						src.Def *= N
						src.DefMod *= N
					if(State == "Remove")
						src.Def /= N
						src.DefMod /= N
					if(!Ver)
						N = 1
				if(I.add_regen)
					N = N + I.add_regen
					if(State == "Add")
						src.Regeneration *= N
					if(State == "Remove")
						src.Regeneration /= N
					if(!Ver)
						N = 1
				if(I.add_recov)
					N = N + I.add_recov
					if(State == "Add")
						src.Recovery *= N
					if(State == "Remove")
						src.Recovery /= N
					if(!Ver)
						N = 1
		Display_Magic(var/obj/I)
			if(I)
				if(I.add_bp)
					src << "Power enchantment of [I.add_bp*100]%"
				if(I.add_energy)
					src << "Energy enchantment of [I.add_energy*100]%"
				if(I.add_str)
					src << "Strength enchantment of [I.add_str*100]%"
				if(I.add_end)
					src << "Durability enchantment of [I.add_end*100]%"
				if(I.add_spd)
					src << "Speed enchantment of [I.add_spd*100]%"
				if(I.add_force)
					src << "Force enchantment of [I.add_force*100]%"
				if(I.add_res)
					src << "Resistence enchantment of [I.add_res*100]%"
				if(I.add_off)
					src << "Offence enchantment of [I.add_off*100]%."
				if(I.add_def)
					src << "Defence enchantment of [I.add_def*100]%"
				if(I.add_regen)
					src << "Regeneration enchantment of [I.add_regen*100]%"
				if(I.add_recov)
					src << "Recovery enchantment of [I.add_recov*100]%"

obj
	magic_effects
		tele_mana
			icon = 'fx.dmi'
			icon_state = "dispel"
			layer = 50
		tele
			icon = 'tk.dmi'
			layer = 50
atom
	MouseDrag(var/obj/Over_Object,var/turf/Turf_Start,var/obj/Over_Loc)
		var/Actual = 3
		var/can_use = 0
		var/using = null
		var/Logit = 0
		for(var/X in NoMove)
			if(src.type == X)
				return
		if(!usr.attacking)
			for(var/obj/Telekinesis_Magic in usr)
				if(usr.TK_Magic)
					Actual = 25
					Actual = round(initial(Actual)/usr.Magic_Potential)
					for(var/obj/Mana/X in usr)
						if(X.Value >= Actual)
							can_use = 1
							using = "mana"
							X.Value -= Actual
							if(ismob(src))
								var/mob/M = src
								if(usr.TK_Last != "[M.real_name] ([M.key])")
									usr.TK_Last = "[M.real_name] ([M.key])"
									Logit = 1
							else
								if(usr.TK_Last != "[src]")
									usr.TK_Last = "[src]"
									Logit = 1
			for(var/obj/Telekinesis in usr)
				if(usr.TK) if(can_use == 0)
					if(usr.Ki >= Actual)
						can_use = 1
						using = "energy"
						usr.Ki -= Actual
						if(ismob(src))
							var/mob/M = src
							if(usr.TK_Last != "[M.real_name] ([M.key])")
								usr.TK_Last = "[M.real_name] ([M.key])"
								Logit = 1
						else
							if(usr.TK_Last != "[src]")
								usr.TK_Last = "[src]"
								Logit = 1
			if(src in range(20,usr)) if(can_use) if(usr.icon_state != "KO") if(usr.afk == 0)
				if(ismob(src))
					var/mob/M = src
					var/moves = 25
					if(M.afk == 0) if(!usr.invisibility)
						if(using == "mana")
							moves += usr.Magic_Level
							moves -= M.Magic_Level
						if(using == "energy")
							moves += usr.MaxKi / 100
							moves -= M.MaxKi / 100
						if(prob(moves))
							if(using == "mana")
								M.overlays -= /obj/magic_effects/tele_mana
								M.overlays += /obj/magic_effects/tele_mana
								usr.overlays -= /obj/magic_effects/tele_mana
								usr.overlays += /obj/magic_effects/tele_mana
							if(using == "energy")
								M.overlays -= /obj/magic_effects/tele
								M.overlays += /obj/magic_effects/tele
								usr.overlays -= /obj/magic_effects/tele
								usr.overlays += /obj/magic_effects/tele
							usr.Remove_Effects()
							spawn(10)
								if(M)
									M.overlays -= /obj/magic_effects/tele
									M.overlays -= /obj/magic_effects/tele_mana
							if(M in view(1,Over_Loc))
								for(var/atom/A in Over_Loc)
									if(A.density)
										return
								M.Move(Over_Loc)
								if(Logit)
									for(var/mob/X in view(8,usr))
										if(X.client)
											X.saveToLog("| [X.client.address ? (X.client.address) : "IP not found"] | ([X.x], [X.y], [X.z]) | [key_name(usr)] moves [src] with their [using] based Telekinesis..\n")
				if(isobj(src))
					var/obj/O = src
					if(!O.Bolted) if(Over_Loc)
						if(using == "energy")
							usr.overlays -= /obj/magic_effects/tele
							usr.overlays += /obj/magic_effects/tele
							O.overlays -= /obj/magic_effects/tele
							O.overlays += /obj/magic_effects/tele
						if(using == "mana")
							usr.overlays -= /obj/magic_effects/tele_mana
							usr.overlays += /obj/magic_effects/tele_mana
							O.overlays -= /obj/magic_effects/tele_mana
							O.overlays += /obj/magic_effects/tele_mana
						usr.Remove_Effects()
						spawn(10)
							if(O)
								O.overlays -= /obj/magic_effects/tele
								O.overlays -= /obj/magic_effects/tele_mana
						if(!usr.invisibility)
							if(istype(O,/obj/Props/))
								var/obj/Props/P = src
								P.Slinger = "[usr]"
								P.Slinger_Key = "[key_name(usr)]"
							if(using == "mana")
								O.Projectile_Speed = usr.Magic_Level
							if(using == "energy")
								O.Projectile_Speed = usr.MaxKi / 100
						if(O in view(1,Over_Loc))
							for(var/atom/A in Over_Loc)
								if(A.density)
									O.Bump(A)
									return
							O.Move(Over_Loc)
							if(Logit)
								for(var/mob/X in view(8,usr))
									if(X.client)
										X.saveToLog("| [X.client.address ? (X.client.address) : "IP not found"] | ([X.x], [X.y], [X.z]) | [key_name(usr)] moves [src] with their [using] based Telekinesis..\n")

			if(using == "mana") if(can_use == 0)
				usr << "Not enough mana!"
			if(using == "energy") if(can_use == 0)
				usr << "Not enough energy!"
mob
	proc
		Remove_Effects()
			spawn(10)
				if(src)
					src.overlays -= /obj/magic_effects/tele_mana
					src.overlays -= /obj/magic_effects/tele
	verb
		Bolt_Spell()
			set name = ".Bolt_Spell"
			if(usr.Spell_Cost && usr.Spell_Power)
				usr << "You are no longer casting this spell."
				usr.Spell_Cost = 0
				usr.Spell_Power = 0
				return
			if(usr.spells_open)
				var/Cost = 1
				var/Y = Year + 1
				var/Power = input(usr, "How much mana will you put into this spell? Current max is 10000 X your Magic Potential of [usr.Magic_Potential] X current year of [Year] = [Commas(10000*usr.Magic_Potential*Y)]","Mana",10) as num
				if(Power < 0)
					Power = 10
				if(Power > 10000*usr.Magic_Potential*Y)
					Power = 10000*usr.Magic_Potential*Y
				Cost = Power
				var/Actual = round(initial(Cost)/usr.Magic_Potential)
				usr << "This spell will make use of [Commas(Cost)] mana. For you, it will cost [Commas(Actual)] mana."
				usr.Spell_Power = Cost
				usr.Spell_Cost = Actual
				view(usr)<<"<font color=teal>[usr] begins to conjure a spell."
				log_ability("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] made a lightning bolt spell ready with [Cost] mana into it.")
				usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] made a lightning bolt spell ready with [Cost] mana into it.\n")
				return
		Enchant()
			set name = ".Enchant"
			if(usr.spells_open)
				var/Cost = 10000000
				var/Actual = round(initial(Cost)/usr.Magic_Potential)
				switch(input("Do you want to enchant a sword or armor piece? The base cost is [Commas(Cost)] mana. For you it will cost [Commas(Actual)] mana.") in list("No","Yes"))
					if("Yes")
						for(var/obj/Mana/M in usr)
							if(M.Value > Actual)
								var/obj/X
								var/N = input(usr, "How many times do you want to enchant an item?") as num
								if(N <= 0)
									return
								if(N >= 5)
									N = 5
								for(var/obj/items/I in get_step(usr,usr.dir))
									if(I.magical)
										switch(input("Are you sure you want to enchant [I]?") in list("No","Yes"))
											if("Yes")
												X = I
								if(!X)
									for(var/obj/items/Sword/S in get_step(usr,usr.dir))
										switch(input("Are you sure you want to enchant [S]?") in list("No","Yes"))
											if("Yes")
												X = S
								if(!X)
									for(var/obj/items/Armor/A in get_step(usr,usr.dir))
										switch(input("Are you sure you want to enchant [A]?") in list("No","Yes"))
											if("Yes")
												X = A
								if(X)
									switch(input("It will cost [Commas(Actual)] mana for you to enchant [X] and grant it +1% in the chosen stat when equipped. Please choose a stat to enhance, up to a max of +5%.") in list("Power","Energy","Strength","Durability","Speed","Force","Resistance","Offence","Defence","Regeneration","Recovery","Cancel"))
										if("Cancel")
											return
										if("Power")
											if(isturf(X.loc))
												var/Num = N
												while(N)
													if(X.add_bp != 0.05)
														if(M.Value >= Actual)
															M.Value -= Actual
															X.add_bp += 0.0101
															if(X.add_bp >= 0.05)
																X.add_bp = 0.05
															X.magical = 1
															usr << "Enchantment applied. Total +[X.add_bp*100]% power."
															N -= 1
														else
															usr << "[Num - N] enchants were added before you ran out of available mana. It will grant +[X.add_bp*100]% power."
															N = 0
													else
														usr << "[Num - N] enchantments applied. The item can not be improved now beyond its current enchantments. It will currently grant +[X.add_bp*100]% power."
														N = 0
												log_ability("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] enchanted [X] with +0.1% Power [Num - N] times.")
												usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] enchanted [X] with +0.1% Power [Num - N] times.\n")
												return
										if("Energy")
											if(isturf(X.loc))
												var/Num = N
												while(N)
													if(X.add_energy != 0.05)
														if(M.Value >= Actual)
															M.Value -= Actual
															X.add_energy += 0.0101
															if(X.add_energy >= 0.05)
																X.add_energy = 0.05
															X.magical = 1
															usr << "Enchantment applied. Total +[X.add_energy*100]% energy."
															N -= 1
														else
															usr << "[Num - N] enchants were added before you ran out of available mana. It will grant +[X.add_energy*100]% energy."
															N = 0
													else
														usr << "[Num - N] enchantments applied. The item can not be improved now beyond its current enchantments. It will currently grant +[X.add_energy*100]% energy."
														N = 0
												log_ability("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] enchanted [X] with +0.1% energy [Num - N] times.")
												usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] enchanted [X] with +0.1% energy [Num - N] times.\n")
												return
										if("Strength")
											if(isturf(X.loc))
												var/Num = N
												while(N)
													if(X.add_str != 0.05)
														if(M.Value >= Actual)
															M.Value -= Actual
															X.add_str += 0.0101
															if(X.add_str >= 0.05)
																X.add_str = 0.05
															X.magical = 1
															usr << "Enchantment applied. Total +[X.add_str*100]% strength."
															N -= 1
														else
															usr << "[Num - N] enchants were added before you ran out of available mana. It will grant +[X.add_str*100]% strength."
															N = 0
													else
														usr << "[Num - N] enchantments applied. The item can not be improved now beyond its current enchantments. It will currently grant +[X.add_str*100]% strength."
														N = 0
												log_ability("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] enchanted [X] with +0.1% strength [Num - N] times.")
												usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] enchanted [X] with +0.1% strength [Num - N] times.\n")
												return
										if("Durability")
											if(isturf(X.loc))
												var/Num = N
												while(N)
													if(X.add_end != 0.05)
														if(M.Value >= Actual)
															M.Value -= Actual
															X.add_end += 0.0101
															if(X.add_end >= 0.05)
																X.add_end = 0.05
															X.magical = 1
															usr << "Enchantment applied. Total +[X.add_end*100]% durability."
															N -= 1
														else
															usr << "[Num - N] enchants were added before you ran out of available mana. It will grant +[X.add_end*100]% durability."
															N = 0
													else
														usr << "[Num - N] enchantments applied. The item can not be improved now beyond its current enchantments. It will currently grant +[X.add_end*100]% durability."
														N = 0
												log_ability("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] enchanted [X] with +0.1% durability [Num - N] times.")
												usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] enchanted [X] with +0.1% durability [Num - N] times.\n")
												return
										if("Force")
											if(isturf(X.loc))
												var/Num = N
												while(N)
													if(X.add_force != 0.05)
														if(M.Value >= Actual)
															M.Value -= Actual
															X.add_force += 0.0101
															if(X.add_force >= 0.05)
																X.add_force = 0.05
															X.magical = 1
															usr << "Enchantment applied. Total +[X.add_force*100]% force."
															N -= 1
														else
															usr << "[Num - N] enchants were added before you ran out of available mana. It will grant +[X.add_force*100]% force."
															N = 0
													else
														usr << "[Num - N] enchantments applied. The item can not be improved now beyond its current enchantments. It will currently grant +[X.add_force*100]% force."
														N = 0
												log_ability("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] enchanted [X] with +0.1% force [Num - N] times.")
												usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] enchanted [X] with +0.1% force [Num - N] times.\n")
												return
										if("Speed")
											if(isturf(X.loc))
												var/Num = N
												while(N)
													if(X.add_spd != 0.05)
														if(M.Value >= Actual)
															M.Value -= Actual
															X.add_spd += 0.0101
															if(X.add_spd >= 0.05)
																X.add_spd = 0.05
															X.magical = 1
															usr << "Enchantment applied. Total +[X.add_res*100]% speed."
															N -= 1
														else
															usr << "[Num - N] enchants were added before you ran out of available mana. It will grant +[X.add_res*100]% speed."
															N = 0
													else
														usr << "[Num - N] enchantments applied. The item can not be improved now beyond its current enchantments. It will currently grant +[X.add_res*100]% speed."
														N = 0
												log_ability("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] enchanted [X] with +0.1% speed [Num - N] times.")
												usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] enchanted [X] with +0.1% speed [Num - N] times.\n")
												return
										if("Resistance")
											if(isturf(X.loc))
												var/Num = N
												while(N)
													if(X.add_res != 0.05)
														if(M.Value >= Actual)
															M.Value -= Actual
															X.add_res += 0.0101
															if(X.add_res >= 0.05)
																X.add_res = 0.05
															X.magical = 1
															usr << "Enchantment applied. Total +[X.add_res*100]% resistance."
															N -= 1
														else
															usr << "[Num - N] enchants were added before you ran out of available mana. It will grant +[X.add_res*100]% resistance."
															N = 0
													else
														usr << "[Num - N] enchantments applied. The item can not be improved now beyond its current enchantments. It will currently grant +[X.add_res*100]% resistance."
														N = 0
												log_ability("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] enchanted [X] with +0.1% resistance [Num - N] times.")
												usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] enchanted [X] with +0.1% resistance [Num - N] times.\n")
												return
										if("Offence")
											if(isturf(X.loc))
												var/Num = N
												while(N)
													if(X.add_off != 0.05)
														if(M.Value >= Actual)
															M.Value -= Actual
															X.add_off += 0.0101
															if(X.add_off >= 0.05)
																X.add_off = 0.05
															X.magical = 1
															usr << "Enchantment applied. Total +[X.add_off*100]% offence."
															N -= 1
														else
															usr << "[Num - N] enchants were added before you ran out of available mana. It will grant +[X.add_off*100]% offence."
															N = 0
													else
														usr << "[Num - N] enchantments applied. The item can not be improved now beyond its current enchantments. It will currently grant +[X.add_off*100]% offence."
														N = 0
												log_ability("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] enchanted [X] with +0.1% offence [Num - N] times.")
												usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] enchanted [X] with +0.1% offence [Num - N] times.\n")
												return
										if("Defence")
											if(isturf(X.loc))
												var/Num = N
												while(N)
													if(X.add_def != 0.05)
														if(M.Value >= Actual)
															M.Value -= Actual
															X.add_def += 0.0101
															if(X.add_def >= 0.05)
																X.add_def = 0.05
															X.magical = 1
															usr << "Enchantment applied. Total +[X.add_def*100]% defence."
															N -= 1
														else
															usr << "[Num - N] enchants were added before you ran out of available mana. It will grant +[X.add_def*100]% defence."
															N = 0
													else
														usr << "[Num - N] enchantments applied. The item can not be improved now beyond its current enchantments. It will currently grant +[X.add_def*100]% defence."
														N = 0
												log_ability("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] enchanted [X] with +0.1% defence [Num - N] times.")
												usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] enchanted [X] with +0.1% defence [Num - N] times.\n")
												return
										if("Regeneration")
											if(isturf(X.loc))
												var/Num = N
												while(N)
													if(X.add_regen != 0.05)
														if(M.Value >= Actual)
															M.Value -= Actual
															X.add_regen += 0.0101
															if(X.add_regen >= 0.05)
																X.add_regen = 0.05
															X.magical = 1
															usr << "Enchantment applied. Total +[X.add_regen*100]% regeneration."
															N -= 1
														else
															usr << "[Num - N] enchants were added before you ran out of available mana. It will grant +[X.add_regen*100]% regeneration."
															N = 0
													else
														usr << "[Num - N] enchantments applied. The item can not be improved now beyond its current enchantments. It will currently grant +[X.add_regen*100]% regeneration."
														N = 0
												log_ability("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] enchanted [X] with +0.1% regeneration [Num - N] times.")
												usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] enchanted [X] with +0.1% regeneration [Num - N] times.\n")
												return
										if("Recovery")
											if(isturf(X.loc))
												var/Num = N
												while(N)
													if(X.add_recov != 0.05)
														if(M.Value >= Actual)
															M.Value -= Actual
															X.add_recov += 0.0101
															if(X.add_recov >= 0.05)
																X.add_recov = 0.05
															X.magical = 1
															usr << "Enchantment applied. Total +[X.add_recov*100]% recovery."
															N -= 1
														else
															usr << "[Num - N] enchants were added before you ran out of available mana. It will grant +[X.add_recov*100]% recovery."
															N = 0
													else
														usr << "[Num - N] enchantments applied. The item can not be improved now beyond its current enchantments. It will currently grant +[X.add_recov*100]% recovery."
														N = 0
												log_ability("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] enchanted [X] with +0.1% recovery [Num - N] times.")
												usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] enchanted [X] with +0.1% recovery [Num - N] times.\n")
												return
							else
								usr << "Not enough mana! You need [Commas(Actual)]"
								return
		Create_Realm_Spell()
			set name = ".Create_Realm_Spell"
			if(usr.spells_open)
				var/Cost = 100000000
				for(var/obj/Magical_Portal/P in range(4,usr))
					usr << "This is too close to another portal."
					return
				switch(input("Do you want to create a portal to a location, or do you want to create an entirely new realm?") in list("Location","Create Realm","Cancel"))
					if("Create Realm")
						var/Actual = round(initial(Cost)/usr.Magic_Potential)
						usr << "Base cost for this spell is [Commas(Cost)] mana. Your magic potential means it costs [Commas(Actual)] mana for you."
						switch(input("Are you very sure you want to create a new magical realm? Once you do, the portal can not be moved.") in list("No","Yes"))
							if("Yes")
								for(var/obj/Mana/M in usr)
									if(M.Value > Actual)
										M.Value -= Actual
										var/obj/Magical_Portal/P = new
										P.loc = usr.loc
										P.Builder = usr.ckey
										if(usr.key == "Kyarco")
											if(4 in Portals)
												P.Portal_Number = 4
												Portals -= 4
										view(usr)<<"<font color=teal>[usr] uses their magic to create a portal!"
										log_ability("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] created a new magical realm.")
										usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] created a new magical realm.\n")
										var/turf/T = usr.loc
										T.Wave(5,100)
										return
									else
										usr << "You do not have [Commas(Actual)] mana to spare in order to use create a new magical realm."
										return
							if("No")
								return
					if("Location")
						Cost = 40000000
						var/Actual = round(initial(Cost)/usr.Magic_Potential)
						usr << "Base cost for this spell is [Commas(Cost)] mana. Your magic potential means it costs [Commas(Actual)] mana for you."
						alert(usr,"Choose the X,Y,Z of the location you want to travel to. Keep in mind that different dimensions from the one you create the portal on cost more to travel to. These portals only last 15 minutes real time before they shut.")
						var/x = input(usr,"x coordinate") as num
						var/y = input(usr,"y coordinate") as num
						var/z = input(usr,"z coordinate") as num
						var/restricted = list(15,9,10)
						var/al = list(13,5,6,7,13)
						var/lr = list(1,2,3,4,8,11,12,14,16)
						var/travel_al = 0
						if(z in al)
							travel_al = 1
						if(z in restricted)
							usr << "Unable to teleport to that z coordinate, please choose another!"
							return
						if(usr.z in al) if(travel_al == 0)
							usr << "You're unable to pierce the veil between realms!"
							return
						if(usr.z in lr) if(travel_al)
							Actual = Actual * 2
							usr << "You're unable to pierce the veil between realms!"
							return
						for(var/obj/Mana/M in usr)
							if(M.Value > Actual)
								M.Value -= Actual
								var/obj/Magical_Portal/P = new
								P.tag = "Special"
								P.loc = usr.loc
								P.Portal_Number = rand(100000,1000000)
								var/turf/T = usr.loc
								T.Wave(5,100)
								var/obj/Magical_Portal/P2 = new
								P2.tag = "Special"
								P2.loc = locate(x,y,z)
								P2.Portal_Number = P.Portal_Number
								var/turf/T2 = P2.loc
								T2.Wave(5,100)
								log_ability("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] created a portal to [x],[y],[z]...")
								usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] created a portal to [x],[y],[z]...\n")
								return
					if("Cancel")
						return
		Heal_Spell()
			set name = ".Heal_Spell"
			if(usr.spells_open)
				var/Cost = 400000
				var/Actual = round(initial(Cost)/usr.Magic_Potential)
				usr << "Base cost for this spell is [Commas(Cost)] mana. Your magic potential means it costs [Commas(Actual)] mana for you."
				for(var/obj/Mana/M in usr)
					if(M.Value > Actual)
						for(var/mob/A in get_step(usr,usr.dir)) if(A.client)
							if(A.icon_state == "KO")
								A.Un_KO()
							A.Health += 25
							var/L = list("Random")
							A.Injure_Heal(10,L)
							A.Heal_Zenkai()
							M.Value -= Actual
							if(A.Poisoned) A.Poisoned-=1

							view(usr)<<"<font color=#FFFF00>[usr] uses their magic to heal [A]"
							log_ability("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] spell healed [key_name(A)]")
							usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] spell healed [key_name(A)].\n")
							A.saveToLog("| [A.client.address ? (A.client.address) : "IP not found"] | ([A.x], [A.y], [A.z]) | [key_name(A)] was spell healed by [key_name(usr)].\n")
							break
					else
						usr << "You do not have [Commas(Actual)] mana to spare in order to use the Heal spell."
						return