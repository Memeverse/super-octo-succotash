
obj
	var
		DNA = 100
		Rarity = 100 //In percent, how likely to get a mutation.
		Very_Likely = 0 //If a trait is extra likely to pass on, adding an extra 50%
		Mother = null
		Father = null
		Racial = null
		lvl = 1 //Level of the trait or mutation.
		Activated = 0 //If set to 0, this trait has yet to be applied.
		Remove = 0 //If set to 1, this trait has been deactivated for now.
		//All bonus in percent
		Bonus_EndMod = 0
		Bonus_AllStats = 0
obj
	DNA
	Mutations
		Negative
			Genetic_Failure
				Rarity = 3//*****
				proc
					Activate(var/mob/M)
			Mod_Penalty
				Rarity = 50 //*
				proc
					Activate(var/mob/M)
						world << "[M] now has the [src] trait. It begins to activate."
						if(prob(25))
							if(src.lvl != 5)
								src.lvl += 1
						else if(prob(25))
							src.lvl -= 1
						else
							del(src)
							return
						var/list/Stats = list("ENG","STR","END","RES","FOR","OFF","DEF","SPD")
						var/P = pick(Stats)
						var/N = (5*src.lvl) / 100 + 1
						if(P == "ENG")
							M.KiMod /= N
						if(P == "STR")
							M.StrMod /= N
						if(P == "END")
							M.EndMod /= N
						if(P == "RES")
							M.ResMod /= N
						if(P == "FOR")
							M.PowMod /= N
						if(P == "OFF")
							M.OffMod /= N
						if(P == "DEF")
							M.DefMod /= N
						if(P == "SPD")
							M.SpdMod /= N
			BP_Penalty
				Rarity = 15//***
				proc
					Activate(var/mob/M)
						world << "[M] now has the [src] trait. It begins to activate."
						if(prob(25))
							if(src.lvl != 5)
								src.lvl += 1
						else if(prob(25))
							src.lvl -= 1
						else
							del(src)
							return
						var/N = (5*src.lvl) / 100 + 1
						M.BPMod /= N
			Anger_Penalty
				Rarity = 7//****
				proc
					Activate(var/mob/M)
						world << "[M] now has the [src] trait. It begins to activate."
						if(prob(15))
							src.lvl = 2
						var/N = 25*src.lvl
						M.MaxAnger -= N
						if(prob(80)) if(src.lvl == 1)
							src.lvl = 1
			Hollow_Bones
				Rarity = 15//***
				proc
					Activate(var/mob/M)
						world << "[M] now has the [src] trait. It begins to activate."
						M.Limb_Res -= 25
			Late_Bloomer
				Rarity = 15//***
				proc
					Activate(var/mob/M)
			Early_Bloomer
				Rarity = 15//***
				proc
					Activate(var/mob/M)
			Albino
				Rarity = 7//****
				proc
					Activate(var/mob/M)
			Dwarf
				Rarity = 7//****
				proc
					Activate(var/mob/M)
			Mutative_DNA
				Rarity = 7//****
				proc
					Activate(var/mob/M)
			Retard_Strength
				Rarity = 15//***
				proc
					Activate(var/mob/M)
			Mundane
				Rarity = 15//***
				proc
					Activate(var/mob/M)
			Lightweight
				Rarity = 15//***
				proc
					Activate(var/mob/M)
						world << "[M] now has the [src] trait. It begins to activate."
						M.EndMod /= 1.1
						M.StrMod /= 1.1
						M.SpdMod *= 1.1
		Positive
			Late_Bloomer
				Rarity = 15//***
				proc
					Activate(var/mob/M)
			Early_Bloomer
				Rarity = 15//***
				proc
					Activate(var/mob/M)
			Albino
				Rarity = 7//****
				proc
					Activate(var/mob/M)
			Dwarf
				Rarity = 7//****
				proc
					Activate(var/mob/M)
			Mod_Bonus
				Rarity = 50 //*
				proc
					Activate(var/mob/M)
						world << "[M] now has the [src] trait. It begins to activate."
						if(prob(25))
							if(src.lvl != 5)
								src.lvl += 1
						else if(prob(25))
							src.lvl -= 1
						else
							del(src)
							return
						var/list/Stats = list("ENG","STR","END","RES","FOR","OFF","DEF","SPD")
						var/P = pick(Stats)
						var/N = (5*src.lvl) / 100 + 1
						if(P == "ENG")
							M.KiMod *= N
						if(P == "STR")
							M.StrMod *= N
						if(P == "END")
							M.EndMod *= N
						if(P == "RES")
							M.ResMod *= N
						if(P == "FOR")
							M.PowMod *= N
						if(P == "OFF")
							M.OffMod *= N
						if(P == "DEF")
							M.DefMod *= N
						if(P == "SPD")
							M.SpdMod *= N
			Anger_Bonus
				Rarity = 7//****
				proc
					Activate(var/mob/M)
						world << "[M] now has the [src] trait. It begins to activate."
						if(prob(15))
							src.lvl = 2
						M.MaxAnger += 50*src.lvl
						if(prob(80)) if(src.lvl == 1)
							src.lvl = 1
			BP_Bonus
				Rarity = 15//***
				proc
					Activate(var/mob/M)
						world << "[M] now has the [src] trait. It begins to activate."
						if(prob(25))
							if(src.lvl != 5)
								src.lvl += 1
						else if(prob(25))
							src.lvl -= 1
						else
							del(src)
							return
						var/N = (5*src.lvl) / 100 + 1
						M.BPMod *= N
			Longevity
				Rarity = 25 //**
				proc
					Activate(var/mob/M)
						world << "[M] now has the [src] trait. It begins to activate."
						M.Decline *= 1.5
			Hardened_Bones
				Rarity = 15//***
				proc
					Activate(var/mob/M)
						world << "[M] now has the [src] trait. It begins to activate."
						M.Limb_Res += 25
			Elite
				Rarity = 7//****
				proc
					Activate(var/mob/M)
			Mutative_DNA
				Rarity = 7//****
				proc
					Activate(var/mob/M)
			Retard_Strength
				Rarity = 15//***
				proc
					Activate(var/mob/M)
			Mundane
				Rarity = 15//***
				proc
					Activate(var/mob/M)
			Lightweight
				Rarity = 15//***
				proc
					Activate(var/mob/M)
						world << "[M] now has the [src] trait. It begins to activate."
						M.EndMod /= 1.1
						M.StrMod /= 1.1
						M.SpdMod *= 1.1
	Traits
		Regenerative_Limbs
			proc
				Activate(var/mob/M)
		Namekian
			Ancient_Gene
				proc
					Activate(var/mob/M)
						world << "[M] now has the [src] trait. It begins to activate."
						M.Ancient_Namekian()
						..()
		Alien
			Shapeshifter
				proc
					Activate(var/mob/M)
		Demon
			Pure_Evil
				proc
					Activate(var/mob/M)
			Impurities
				proc
					Activate(var/mob/M)
		Kaio
			Pure_Good
				proc
					Activate(var/mob/M)
			Impurities
				proc
					Activate(var/mob/M)
		Makyo
			Enhanced_Expansion
				proc
					Activate(var/mob/M)
			Demonic_Link
				proc
					Activate(var/mob/M)
		Doll
			Energy_Affinity
				proc
					Activate(var/mob/M)
			Energy_Vampire
				proc
					Activate(var/mob/M)
						world << "[M] now has the [src] trait. It begins to activate."
						M.Asexual=1
						M.Magic_Potential = 4
						M.Sense_Mod=4
						M.Potential*=6
						M.Decline=9999999999999999999999999999999999999999999999999999999999999999999
						M.InclineSpeed=0
						M.InclineAge=18
						M.ITMod=3
						M.ZanzoMod=3
						M.KaiokenMod=3
						M.undelayed = 1
						M.NoLoss = 1
						M.FlyMod=3
						M.BPMod=1
						M.MaxAnger=100
						M.KiMod=4
						M.MaxKi=300
						M.SpdMod*=1.2
						M.StrMod*=1.2
						M.EndMod*=1.2
						M.ResMod*=1.2
						M.DefMod*=1.2
						M.OffMod*=1.2
						M.Regeneration*=2
						M.Recovery*=1.2
						M.GravMod=2
						M.Base=100
						M.Vampire = 2
						M.contents+=new/obj/Invisibility
						M.contents+=new/obj/Vampire_Infect
						alertAdmins("[M.key] created into a rare Ancient Vampire.",1)
						M.Regenerate+=0.3
						M.Alter_Age(1000)
						M.SDLearnable=1
						M << "Ancient Vampires. Immortal predators hiding in the shadows on the fringe of human society. The vampire has a body of eldritch power, and his craving for blood is to obtain sustenance for that body. He is neither dead nor alive; but living in death. He is an abnormality; the androgyne of the phantom world. A pariah among the fiends. How fearful a destiny is that of the vampire who has no rest in the grave but whose doom it is to come forth and prey upon the living... This, however, is the Ancient Vampire, and his destiny and power is greater than any collective of monsters he might spawn. Potent necro magic runs through his veins, granting him the ability to impose his will upon this reality with frightening ease - Though many of its spawns are damned with many weaknesses, only the Ancient is left unfettered. To the chagrin of its victims."
						M.sight |= (SEE_MOBS|SEE_OBJS|SEE_TURFS)
		Human
			Student_Master
				proc
					Activate(var/mob/M)
			Prodigy
				proc
					Activate(var/mob/M)
		Tuffle
			Genius
				proc
					Activate(var/mob/M)
			Super_Tuffle
				proc
					Activate(var/mob/M)
						M.Super_Tuffle()
		Oni
			Soul_Shepherd
				proc
					Activate(var/mob/M)
			Titan
				proc
					Activate(var/mob/M)
		Majin
			Near_Indestructible
				proc
					Activate(var/mob/M)
		Demigod
			Enduring
				proc
					Activate(var/mob/M)
						world << "[M] now has the [src] trait. It begins to activate."
						if(M.Gen >= 10)
							M.Limb_Res += 30
						else if(M.Gen >= 5)
							M.Limb_Res += 40
						else
							M.Limb_Res += 20
			Divine
				proc
					Activate(var/mob/M)
		Changeling
			Racial = "Changeling"
			Chitinous_Exterior
				desc = "Your chitinous exterior is far more durable than mere skin."
				Bonus_EndMod = 5
				Very_Likely = 1
				proc
					Activate(var/mob/M)
						world << "[M] now has the [src] trait. It begins to activate."
						if(M.Gen >= 10)
							M.ResMod *= 1.15
							M.EndMod *= 1.15
						else if(M.Gen >= 5)
							M.ResMod *= 1.1
							M.EndMod *= 1.1
						else
							M.ResMod *= 1.05
							M.EndMod *= 1.05
			Tail
				desc = "Some races have tails which allow them an increased sensory awareness. Losing their tail however can leave them off-balance and cause them to struggle to adapt."
				Bonus_AllStats = 2.5
				Very_Likely = 1
				proc
					Activate(var/mob/M)
			Horns
				desc = "Some species have special growths that might provide them with more than just mere looks, but a formidable weapon."
				proc
					Activate(var/mob/M)
			Additional_Form
				proc
					Activate(var/mob/M)
		Saiyan
			Racial = "Saiyan"
			LSSJ
				proc
					Activate(var/mob/M)
						M.LSSJ()
			SSJ
				Very_Likely = 1
				proc
					Activate(var/mob/M)
			Saiyan_Tail
				Bonus_AllStats = 10
				Very_Likely = 1
				proc
					Activate(var/mob/M)
			Zenkai
				proc
					Activate(var/mob/M)
mob
	var
		list/DNAs = list()
		Gen = 1 //The generation of this player, 1st, 2nd, ect.
		Limb_Res = 0
		//Activation = obj/proc/Activate
/*
	verb
		Test()
			usr << "Testing, please wait."
			for(var/obj/Traits/X in usr)
				call(X,"Activate")(usr)
			for(var/obj/Mutations/X in usr)
				call(X,"Activate")(usr)
*/
mob
	proc
		Starting_Age()
			if(src.Race != "Android")
				switch(alert(src,"Choose an age to start at.","","Adult","Youth","Infant"))
					if("Adult")
						src.Age = src.Decline / 1.6
					if("Youth")
						src.Age = src.Decline / 3
					if("Infant")
						src.Age = src.Decline / 10
				src.Age = round(src.Age,1)
				src.Real_Age = src.Age
		Traits(var/Pure,var/mob/Dad,var/mob/Mum)
			world << "Traits activating"
			var/chance = 0
			for(var/obj/DNA/D in src.DNAs)
				chance = D.DNA
				world << "Base percentage chance to pass a trait is [chance]."
				break
			for(var/obj/Traits/T in Dad)
				if(T.Very_Likely)
					chance += 50
				if(prob(chance))
					new T.type(src)
					world << "[src] inherited their Fathers([Dad]) [T] trait, having passed a [chance]% chance for it to pass along."
				else
					world << "[src] did not manage to inherit their Fathers([Dad]) [T] trait, having failed a [chance]% chance for it to pass along."
			for(var/obj/DNA/D in src.DNAs)
				chance = D.DNA
				break
			for(var/obj/Traits/T in Mum)
				if(T.Very_Likely)
					chance += 50
				if(prob(chance))
					new T.type(src)
					world << "[src] inherited their Mothers([Mum]) [T] trait, having passed a [chance]% chance for it to pass along."
				else
					world << "[src] did not manage to inherit their Mothers([Mum]) [T] trait, having failed a [chance]% chance for it to pass along."
			if(src.Gen >= 5)
				if(prob(100))
					if(src.Race == "Saiyan")
						world << "[src] spawned with a super rare trait, LSSJ!"
						new /obj/Traits/Saiyan/LSSJ(src)
			for(var/obj/Traits/X in src)
				world << "Found [X] in [src] as a trait, attempting to activate..."
				call(X,"Activate")(src)
		Mutations(var/Pure,var/mob/Dad,var/mob/Mum)
			world << "Mutations activating"
			if(Dad)
				for(var/obj/Mutations/M in Dad)
					if(prob(M.Rarity))
						new M.type(src)
						world << "[src] inherited their Fathers([Dad]) [M] mutation, having passed a [M.Rarity]% chance for it to pass along."
					else
						world << "Fathers([Dad]) [M] mutation failed to pass to [src]."
			if(Mum)
				for(var/obj/Mutations/M in Mum)
					if(prob(M.Rarity))
						new M.type(src)
						world << "[src] inherited their Mothers([Mum]) [M] mutation, having passed a [M.Rarity]% chance for it to pass along."
					else
						world << "Mothers([Mum]) [M] mutation failed to pass to [src]."
			var/Pos = 0
			var/Neg = 0
			if(Pure)
				Pos += 60
				world << "[src] is a pureblood and now has a +60% chance to mutate with a positive trait."
			else
				Neg += 60
				world << "[src] is a hybrid and now has a +60% chance to mutate with a negative trait."
			var/Mutate = pick(prob(Pos);Pos,prob(Neg);Neg)
			world << "Now rolling chances and picking type of mutation for [src]."
			if(Mutate == Pos)
				world << "Positive mutation chosen."
				var/list/Mutations_Positive = list()
				for(var/A in typesof(/obj/Mutations/Positive/))
					var/obj/Mutations/Positive/P = new A
					Mutations_Positive += P
				Mutations_Positive -= /obj/Mutations/Positive
				var/obj/Mutation = pick(Mutations_Positive)
				var/Chosen = 0
				while(Chosen == 0)
					if(prob(Mutation.Rarity))
						new Mutation.type(src)
						//Mutation.loc = src
						Chosen = 1
						world << "Positive mutation selected and added to [src], it was [Mutation]."
					else
						Mutation = pick(Mutations_Positive)
				for(var/obj/O in Mutations_Positive)
					del(O)
			if(Mutate == Neg)
				world << "Negative mutation chosen."
				var/list/Mutations_Negative = list()
				for(var/A in typesof(/obj/Mutations/Negative/))
					var/obj/Mutations/Negative/N = new A
					Mutations_Negative += N
				Mutations_Negative -= /obj/Mutations/Negative
				var/obj/Mutation = pick(Mutations_Negative)
				var/Chosen = 0
				while(Chosen == 0)
					if(prob(Mutation.Rarity))
						new Mutation.type(src)
						//Mutation.loc = src
						Chosen = 1
						world << "Negative mutation selected and added to [src], it was [Mutation]."
					else
						Mutation = pick(Mutations_Negative)
				for(var/obj/O in Mutations_Negative)
					del(O)
			for(var/obj/Mutations/X in src)
				world << "Found [X] in [src] as a mutation, attempting to activate..."
				call(X,"Activate")(src)
		Set_Traits()
			world << "Setting traits for [src.Race]."
			if(src.Race == "Saiyan")
				new /obj/Traits/Saiyan/Saiyan_Tail(src)
				new /obj/Traits/Saiyan/Zenkai(src)
				world << "Traits added, Tail and Zenkai."
			if(src.Race == "Changeling")
				new /obj/Traits/Changeling/Horns(src)
				new /obj/Traits/Changeling/Tail(src)
				new /obj/Traits/Changeling/Chitinous_Exterior(src)
				world << "Traits added, Horns, Tail and Chitinous Exterior."
		Set_Base_Mods()
			src.BaseMaxAnger=src.MaxAnger
			src.BaseBPMod=src.BPMod
			src.BaseKiMod=src.KiMod
			src.BasePowMod=src.PowMod
			src.BaseStrMod=src.StrMod
			src.BaseSpdMod=src.SpdMod
			src.BaseEndMod=src.EndMod
			src.BaseResMod=src.ResMod
			src.BaseOffMod=src.OffMod
			src.BaseDefMod=src.DefMod
			src.BaseRegeneration=src.Regeneration
			src.BaseRecovery=src.Recovery
			src.BaseGravMod=src.GravMod
			src.BaseZenkai=src.Zenkai
			src.BaseMedMod=src.MedMod
			src.BaseDecline = src.Decline
			src.BaseMagic_Potential = src.Magic_Potential
			src.BaseAdd = src.Add
			src.BaseInclineSpeed = src.InclineSpeed
			src.BaseInclineAge = src.InclineAge
		Stat_Variation(var/Num_High,var/Num_Low)
			var/Highest = 100 + Num_High
			var/Lowest = 100 - Num_Low
			src.MaxKi=src.MaxKi/100 * rand(Lowest,Highest)
			world << "Stat Variation - [src]'s MaxKi equals [src.MaxKi] after having rolled between [Lowest] and [Highest]."
			src.MaxAnger=src.MaxAnger/100 * rand(Lowest,Highest)
			world << "Stat Variation - [src]'s MaxAnger equals [src.MaxAnger] after having rolled between [Lowest] and [Highest]."
			src.KiMod=src.KiMod/100 * rand(Lowest,Highest)
			world << "Stat Variation - [src]'s KiMod equals [src.KiMod] after having rolled between [Lowest] and [Highest]."
			src.PowMod=src.PowMod/100 * rand(Lowest,Highest)
			world << "Stat Variation - [src]'s PowMod equals [src.PowMod] after having rolled between [Lowest] and [Highest]."
			src.StrMod=src.StrMod/100 * rand(Lowest,Highest)
			world << "Stat Variation - [src]'s StrMod equals [src.StrMod] after having rolled between [Lowest] and [Highest]."
			src.SpdMod=src.SpdMod/100 * rand(Lowest,Highest)
			world << "Stat Variation - [src]'s SpdMod equals [src.SpdMod] after having rolled between [Lowest] and [Highest]."
			src.EndMod=src.EndMod/100 * rand(Lowest,Highest)
			world << "Stat Variation - [src]'s EndMod equals [src.EndMod] after having rolled between [Lowest] and [Highest]."
			src.ResMod=src.ResMod/100 * rand(Lowest,Highest)
			world << "Stat Variation - [src]'s ResMod equals [src.ResMod] after having rolled between [Lowest] and [Highest]."
			src.OffMod=src.OffMod/100 * rand(Lowest,Highest)
			world << "Stat Variation - [src]'s OffMod equals [src.OffMod] after having rolled between [Lowest] and [Highest]."
			src.DefMod=src.DefMod/100 * rand(Lowest,Highest)
			world << "Stat Variation - [src]'s DefMod equals [src.DefMod] after having rolled between [Lowest] and [Highest]."
			src.GravMod=src.GravMod/100 * rand(Lowest,Highest)
			world << "Stat Variation - [src]'s GravMod equals [src.GravMod] after having rolled between [Lowest] and [Highest]."
			src.Regeneration=src.Regeneration/100 * rand(Lowest,Highest)
			world << "Stat Variation - [src]'s Regeneration equals [src.Regeneration] after having rolled between [Lowest] and [Highest]."
			src.Recovery=src.Recovery/100 * rand(Lowest,Highest)
			world << "Stat Variation - [src]'s Recovery equals [src.Recovery] after having rolled between [Lowest] and [Highest]."
			src.Zenkai=src.Zenkai/100 * rand(Lowest,Highest)
			world << "Stat Variation - [src]'s Zenkai equals [src.Zenkai] after having rolled between [Lowest] and [Highest]."
			src.MedMod=src.MedMod/100 * rand(Lowest,Highest)
			world << "Stat Variation - [src]'s MedMod equals [src.MedMod] after having rolled between [Lowest] and [Highest]."
		Clone(var/mob/Dad,var/mob/Mum,var/obj/Baby)
			var/mob/player/M = new/mob/player
			M.name = Dad.name
			M.icon = Dad.icon
			M.DNAs = Dad.DNAs
			for(var/obj/O in Dad.DNAs)
				world << "Copying Fathers([Dad]) [O] DNA for use later."
			M.Add=Dad.BaseAdd
			M.Magic_Potential = Dad.BaseMagic_Potential
			M.Sense_Mod=Dad.Sense_Mod
			M.FlyMod=Dad.FlyMod
			M.ZanzoMod=Dad.ZanzoMod
			M.RaceDescription=Dad.RaceDescription
			M.Race=Dad.Race
			M.Class=Dad.Class
			M.Age=Dad.Age
			M.Decline=Dad.Decline
			M.InclineSpeed=Dad.BaseInclineSpeed
			M.InclineAge=Dad.BaseInclineAge
			M.BPMod=Dad.BaseBPMod
			M.MaxKi=Dad.MaxKi
			M.MaxAnger=Dad.BaseMaxAnger
			M.KiMod=Dad.BaseKiMod
			M.PowMod=Dad.BasePowMod
			M.StrMod=Dad.BaseStrMod
			M.SpdMod=Dad.BaseSpdMod
			M.EndMod=Dad.BaseEndMod
			M.ResMod=Dad.BaseResMod
			M.OffMod=Dad.BaseOffMod
			M.DefMod=Dad.BaseDefMod
			M.GravMod=Dad.GravMod
			M.Regeneration=Dad.BaseRegeneration
			M.Recovery=Dad.BaseRecovery
			M.Zenkai=Dad.BaseZenkai
			M.MedMod=Dad.BaseMedMod
			M.Base=Dad.Base
			for(var/obj/Mutations/Mutes in Dad)
				new Mutes.type(M)
			for(var/obj/Traits/T in Dad)
				new T.type(M)
			Baby.Father = M

			var/mob/player/M2 = new/mob/player
			M2.name = Mum.name
			M2.icon = Mum.icon
			M2.DNAs = Mum.DNAs
			for(var/obj/O in Mum.DNAs)
				world << "Copying Mothers([Mum]) [O] DNA for use later."
			M2.Add=Mum.BaseAdd
			M2.Magic_Potential = Mum.BaseMagic_Potential
			M2.Sense_Mod=Mum.Sense_Mod
			M2.FlyMod=Mum.FlyMod
			M2.ZanzoMod=Mum.ZanzoMod
			M2.RaceDescription=Mum.RaceDescription
			M2.Race=Mum.Race
			M2.Class=Mum.Class
			M2.Age=Mum.Age
			M2.Decline=Mum.Decline
			M2.InclineSpeed=Mum.BaseInclineSpeed
			M2.InclineAge=Mum.BaseInclineAge
			M2.BPMod=Mum.BaseBPMod
			M2.MaxKi=Mum.MaxKi
			M2.MaxAnger=Mum.BaseMaxAnger
			M2.KiMod=Mum.BaseKiMod
			M2.PowMod=Mum.BasePowMod
			M2.StrMod=Mum.BaseStrMod
			M2.SpdMod=Mum.BaseSpdMod
			M2.EndMod=Mum.BaseEndMod
			M2.ResMod=Mum.BaseResMod
			M2.OffMod=Mum.BaseOffMod
			M2.DefMod=Mum.BaseDefMod
			M2.GravMod=Mum.BaseGravMod
			M2.Regeneration=Mum.BaseRegeneration
			M2.Recovery=Mum.BaseRecovery
			M2.Zenkai=Mum.BaseZenkai
			M2.MedMod=Mum.BaseMedMod
			M2.Base=Mum.Base
			for(var/obj/Mutations/Mutes in Mum)
				new Mutes.type(M2)
			for(var/obj/Traits/T in Mum)
				new T.type(M2)
			Baby.Mother = M2
		Create_DNA()
			src.BPMod=src.BPMod/100 * rand(90,110)
			var/list/No_DNA = list("Android","Majin")
			if(src.Race in No_DNA)
				return
			if(src.Born == 0)
				var/obj/DNA/D = new
				D.name = "[src.Race] DNA"
				src.DNAs += D
		Splice(var/mob/Dad,var/mob/Mum)
			for(var/obj/DNA/D in Dad.DNAs)
				var/obj/DNA/Strand = new
				Strand.name = D.name
				for(var/obj/DNA/Old in src.DNAs)
					if(Old.name == D.name)
						del(Strand)
					else
						continue
				if(Strand)
					src.DNAs += Strand
					world << "Found Fathers([Dad]) DNA [D] and added it to [src]'s."
			for(var/obj/DNA/D in Mum.DNAs)
				var/obj/DNA/Strand = new
				Strand.name = D.name
				for(var/obj/DNA/Old in src.DNAs)
					if(Old.name == D.name)
						del(Strand)
					else
						continue
				if(Strand)
					src.DNAs += Strand
					world << "Found Mothers([Mum]) DNA [D] and added it to [src]'s."
			var/N = 0
			for(var/obj/DNA/D in src.DNAs)
				N += 1
			world << "[src] now has [N] DNA's total."
			for(var/obj/DNA/D in src.DNAs)
				D.DNA = 100 / N
			if(Dad.Gen > Mum.Gen)
				src.Gen = Dad.Gen + 1
			if(Mum.Gen > Dad.Gen)
				src.Gen = Mum.Gen + 1
			if(Dad) if(Mum)
				var/R = 0
				R = rand(1,3)
				if(R == 1)  src.Add = ((Dad.Add*2)+Mum.Add)/3
				if(R == 2)  src.Add = (Dad.Add+(Mum.Add*2))/3
				if(R == 3) src.Add=(Dad.Add+Mum.Add) / 2
				world << "Result roll for [src]'s Add mod was result number [R], which now equals [src.Add]. Based on their Mothers, which is [Mum.Add] and their Fathers add, which is [Dad.Add]."
				R = rand(1,3)
				if(R == 1)  src.Magic_Potential = ((Dad.Magic_Potential*2)+Mum.Magic_Potential)/3
				if(R == 2)  src.Magic_Potential = (Dad.Magic_Potential+(Mum.Magic_Potential*2))/3
				if(R == 3) src.Magic_Potential=(Dad.Magic_Potential+Mum.Magic_Potential) / 2
				world << "Result roll for [src]'s Magic_Potential mod was result number [R], which now equals [src.Magic_Potential]. Based on their Mothers, which is [Mum.Magic_Potential] and their Fathers add, which is [Dad.Magic_Potential]."
				R = rand(1,3)
				if(R == 1)  src.Sense_Mod = ((Dad.Sense_Mod*2)+Mum.Sense_Mod)/3
				if(R == 2)  src.Sense_Mod = (Dad.Sense_Mod+(Mum.Sense_Mod*2))/3
				if(R == 3) src.Sense_Mod=(Dad.Sense_Mod+Mum.Sense_Mod) / 2
				world << "Result roll for [src]'s Sense_Mod mod was result number [R], which now equals [src.Sense_Mod]. Based on their Mothers, which is [Mum.Sense_Mod] and their Fathers add, which is [Dad.Sense_Mod]."
				R = rand(1,3)
				if(R == 1)  src.FlyMod = ((Dad.FlyMod*2)+Mum.FlyMod)/3
				if(R == 2)  src.FlyMod = (Dad.FlyMod+(Mum.FlyMod*2))/3
				if(R == 3) src.FlyMod=(Dad.FlyMod+Mum.FlyMod) / 2
				world << "Result roll for [src]'s FlyMod mod was result number [R], which now equals [src.FlyMod]. Based on their Mothers, which is [Mum.FlyMod] and their Fathers add, which is [Dad.FlyMod]."
				R = rand(1,3)
				if(R == 1)  src.ZanzoMod = ((Dad.ZanzoMod*2)+Mum.ZanzoMod)/3
				if(R == 2)  src.ZanzoMod = (Dad.ZanzoMod+(Mum.ZanzoMod*2))/3
				if(R == 3) src.ZanzoMod=(Dad.ZanzoMod+Mum.ZanzoMod) / 2
				world << "Result roll for [src]'s ZanzoMod mod was result number [R], which now equals [src.ZanzoMod]. Based on their Mothers, which is [Mum.ZanzoMod] and their Fathers add, which is [Dad.ZanzoMod]."
				R = rand(1,3)
				if(R == 1)  src.Decline = ((Dad.Decline*2)+Mum.Decline)/3
				if(R == 2)  src.Decline = (Dad.Decline+(Mum.Decline*2))/3
				if(R == 3) src.Decline=(Dad.Decline+Mum.Decline) / 2
				world << "Result roll for [src]'s Decline mod was result number [R], which now equals [src.Decline]. Based on their Mothers, which is [Mum.Decline] and their Fathers add, which is [Dad.Decline]."
				R = rand(1,3)
				if(R == 1)  src.InclineSpeed = ((Dad.InclineSpeed*2)+Mum.InclineSpeed)/3
				if(R == 2)  src.InclineSpeed = (Dad.InclineSpeed+(Mum.InclineSpeed*2))/3
				if(R == 3) src.InclineSpeed=(Dad.InclineSpeed+Mum.InclineSpeed) / 2
				world << "Result roll for [src]'s InclineSpeed mod was result number [R], which now equals [src.InclineSpeed]. Based on their Mothers, which is [Mum.InclineSpeed] and their Fathers add, which is [Dad.InclineSpeed]."
				R = rand(1,3)
				if(R == 1)  src.InclineAge = ((Dad.InclineAge*2)+Mum.InclineAge)/3
				if(R == 2)  src.InclineAge = (Dad.InclineAge+(Mum.InclineAge*2))/3
				if(R == 3) src.InclineAge=(Dad.InclineAge+Mum.InclineAge) / 2
				world << "Result roll for [src]'s InclineAge mod was result number [R], which now equals [src.InclineAge]. Based on their Mothers, which is [Mum.InclineAge] and their Fathers add, which is [Dad.InclineAge]."
				R = rand(1,3)
				if(R == 1)  src.BPMod = ((Dad.BPMod*2)+Mum.BPMod)/3
				if(R == 2)  src.BPMod = (Dad.BPMod+(Mum.BPMod*2))/3
				if(R == 3) src.BPMod=(Dad.BPMod+Mum.BPMod) / 2
				world << "Result roll for [src]'s BPMod mod was result number [R], which now equals [src.BPMod]. Based on their Mothers, which is [Mum.BPMod] and their Fathers add, which is [Dad.BPMod]."
				R = rand(1,3)
				if(R == 1)  src.MaxKi = ((Dad.MaxKi*2)+Mum.MaxKi)/3
				if(R == 2)  src.MaxKi = (Dad.MaxKi+(Mum.MaxKi*2))/3
				if(R == 3) src.MaxKi=(Dad.MaxKi+Mum.MaxKi) / 2
				world << "Result roll for [src]'s MaxKi mod was result number [R], which now equals [src.MaxKi]. Based on their Mothers, which is [Mum.MaxKi] and their Fathers add, which is [Dad.MaxKi]."
				R = rand(1,3)
				if(R == 1)  src.MaxAnger = ((Dad.MaxAnger*2)+Mum.MaxAnger)/3
				if(R == 2)  src.MaxAnger = (Dad.MaxAnger+(Mum.MaxAnger*2))/3
				if(R == 3) src.MaxAnger=(Dad.MaxAnger+Mum.MaxAnger) / 2
				world << "Result roll for [src]'s MaxAnger mod was result number [R], which now equals [src.MaxAnger]. Based on their Mothers, which is [Mum.MaxAnger] and their Fathers add, which is [Dad.MaxAnger]."
				R = rand(1,3)
				if(R == 1)  src.KiMod = ((Dad.KiMod*2)+Mum.KiMod)/3
				if(R == 2)  src.KiMod = (Dad.KiMod+(Mum.KiMod*2))/3
				if(R == 3) src.KiMod=(Dad.KiMod+Mum.KiMod) / 2
				world << "Result roll for [src]'s KiMod mod was result number [R], which now equals [src.KiMod]. Based on their Mothers, which is [Mum.KiMod] and their Fathers add, which is [Dad.KiMod]."
				R = rand(1,3)
				if(R == 1)  src.PowMod = ((Dad.PowMod*2)+Mum.PowMod)/3
				if(R == 2)  src.PowMod = (Dad.PowMod+(Mum.PowMod*2))/3
				if(R == 3) src.PowMod=(Dad.PowMod+Mum.PowMod) / 2
				world << "Result roll for [src]'s PowMod mod was result number [R], which now equals [src.PowMod]. Based on their Mothers, which is [Mum.PowMod] and their Fathers add, which is [Dad.PowMod]."
				R = rand(1,3)
				if(R == 1)  src.StrMod = ((Dad.StrMod*2)+Mum.StrMod)/3
				if(R == 2)  src.StrMod = (Dad.StrMod+(Mum.StrMod*2))/3
				if(R == 3) src.StrMod=(Dad.StrMod+Mum.StrMod) / 2
				world << "Result roll for [src]'s StrMod mod was result number [R], which now equals [src.StrMod]. Based on their Mothers, which is [Mum.StrMod] and their Fathers add, which is [Dad.StrMod]."
				R = rand(1,3)
				if(R == 1)  src.SpdMod = ((Dad.SpdMod*2)+Mum.SpdMod)/3
				if(R == 2)  src.SpdMod = (Dad.SpdMod+(Mum.SpdMod*2))/3
				if(R == 3) src.SpdMod=(Dad.SpdMod+Mum.SpdMod) / 2
				world << "Result roll for [src]'s SpdMod mod was result number [R], which now equals [src.SpdMod]. Based on their Mothers, which is [Mum.SpdMod] and their Fathers add, which is [Dad.SpdMod]."
				R = rand(1,3)
				if(R == 1)  src.EndMod = ((Dad.EndMod*2)+Mum.EndMod)/3
				if(R == 2)  src.EndMod = (Dad.EndMod+(Mum.EndMod*2))/3
				if(R == 3) src.EndMod=(Dad.EndMod+Mum.EndMod) / 2
				world << "Result roll for [src]'s EndMod mod was result number [R], which now equals [src.EndMod]. Based on their Mothers, which is [Mum.EndMod] and their Fathers add, which is [Dad.EndMod]."
				R = rand(1,3)
				if(R == 1)  src.ResMod = ((Dad.ResMod*2)+Mum.ResMod)/3
				if(R == 2)  src.ResMod = (Dad.ResMod+(Mum.ResMod*2))/3
				if(R == 3) src.ResMod=(Dad.ResMod+Mum.ResMod) / 2
				world << "Result roll for [src]'s ResMod mod was result number [R], which now equals [src.ResMod]. Based on their Mothers, which is [Mum.ResMod] and their Fathers add, which is [Dad.ResMod]."
				R = rand(1,3)
				if(R == 1)  src.OffMod = ((Dad.OffMod*2)+Mum.OffMod)/3
				if(R == 2)  src.OffMod = (Dad.OffMod+(Mum.OffMod*2))/3
				if(R == 3) src.OffMod=(Dad.OffMod+Mum.OffMod) / 2
				world << "Result roll for [src]'s OffMod mod was result number [R], which now equals [src.OffMod]. Based on their Mothers, which is [Mum.OffMod] and their Fathers add, which is [Dad.OffMod]."
				R = rand(1,3)
				if(R == 1)  src.DefMod = ((Dad.DefMod*2)+Mum.DefMod)/3
				if(R == 2)  src.DefMod = (Dad.DefMod+(Mum.DefMod*2))/3
				if(R == 3) src.DefMod=(Dad.DefMod+Mum.DefMod) / 2
				world << "Result roll for [src]'s DefMod mod was result number [R], which now equals [src.DefMod]. Based on their Mothers, which is [Mum.DefMod] and their Fathers add, which is [Dad.DefMod]."
				R = rand(1,3)
				if(R == 1)  src.GravMod = ((Dad.GravMod*2)+Mum.GravMod)/3
				if(R == 2)  src.GravMod = (Dad.GravMod+(Mum.GravMod*2))/3
				if(R == 3) src.GravMod=(Dad.GravMod+Mum.GravMod) / 2
				world << "Result roll for [src]'s GravMod mod was result number [R], which now equals [src.GravMod]. Based on their Mothers, which is [Mum.GravMod] and their Fathers add, which is [Dad.GravMod]."
				R = rand(1,3)
				if(R == 1)  src.Regeneration = ((Dad.Regeneration*2)+Mum.Regeneration)/3
				if(R == 2)  src.Regeneration = (Dad.Regeneration+(Mum.Regeneration*2))/3
				if(R == 3) src.Regeneration=(Dad.Regeneration+Mum.Regeneration) / 2
				world << "Result roll for [src]'s Regeneration mod was result number [R], which now equals [src.Regeneration]. Based on their Mothers, which is [Mum.Regeneration] and their Fathers add, which is [Dad.Regeneration]."
				R = rand(1,3)
				if(R == 1)  src.Recovery = ((Dad.Recovery*2)+Mum.Recovery)/3
				if(R == 2)  src.Recovery = (Dad.Recovery+(Mum.Recovery*2))/3
				if(R == 3) src.Recovery=(Dad.Recovery+Mum.Recovery) / 2
				world << "Result roll for [src]'s Recovery mod was result number [R], which now equals [src.Recovery]. Based on their Mothers, which is [Mum.Recovery] and their Fathers add, which is [Dad.Recovery]."
				R = rand(1,3)
				if(R == 1)  src.Zenkai = ((Dad.Zenkai*2)+Mum.Zenkai)/3
				if(R == 2)  src.Zenkai = (Dad.Zenkai+(Mum.Zenkai*2))/3
				if(R == 3) src.Zenkai=(Dad.Zenkai+Mum.Zenkai) / 2
				world << "Result roll for [src]'s Zenkai mod was result number [R], which now equals [src.Zenkai]. Based on their Mothers, which is [Mum.Zenkai] and their Fathers add, which is [Dad.Zenkai]."
				R = rand(1,3)
				if(R == 1)  src.MedMod = ((Dad.MedMod*2)+Mum.MedMod)/3
				if(R == 2)  src.MedMod = (Dad.MedMod+(Mum.MedMod*2))/3
				if(R == 3) src.MedMod=(Dad.MedMod+Mum.MedMod) / 2
				world << "Result roll for [src]'s MedMod mod was result number [R], which now equals [src.MedMod]. Based on their Mothers, which is [Mum.MedMod] and their Fathers add, which is [Dad.MedMod]."
				R = rand(1,3)
				if(R == 1)  src.Base = ((Dad.Base*2)+Mum.Base)/3
				if(R == 2)  src.Base = (Dad.Base+(Mum.Base*2))/3
				if(R == 3) src.Base=(Dad.Base+Mum.Base) / 2
				world << "Result roll for [src]'s Base mod was result number [R], which now equals [src.Base]. Based on their Mothers, which is [Mum.Base] and their Fathers add, which is [Dad.Base]."
			var/Same_Species = 1
			var/Found_Same_DNA = 0
			for(var/obj/DNA/DNA_Dad in Dad.DNAs)
				for(var/obj/DNA/DNA_Mum in Mum.DNAs)
					if(DNA_Dad.name == DNA_Mum.name)
						Found_Same_DNA = 1
						if(DNA_Dad.DNA != DNA_Mum.DNA)
							Same_Species = 0
			if(Found_Same_DNA == 0)
				Same_Species = 0
			if(Same_Species)
				world << "Pure blood detected."
				src.Stat_Variation(20,10)
				if(Dad.Race == "Changeling" && Mum.Race == "Changeling")
					new /obj/Traits/Changeling/Chitinous_Exterior(src)
					new /obj/Traits/Changeling/Tail(src)
					new /obj/Traits/Changeling/Horns(src)
				if(Dad.Race == "Saiyan" && Mum.Race == "Saiyan")
					if(typesof(/obj/Traits/Saiyan/LSSJ) in Dad || typesof(/obj/Traits/Saiyan/LSSJ) in Mum)
						if(prob(10))
							new /obj/Traits/Saiyan/LSSJ(src)
			else if(Dad.Race == "Saiyan" || Mum.Race == "Saiyan")
				if(typesof(/obj/Traits/Saiyan/LSSJ) in Dad || typesof(/obj/Traits/Saiyan/LSSJ) in Mum)
					if(prob(2.5))
						new /obj/Traits/Saiyan/LSSJ(src)
			if(Same_Species == 0)
				world << "Hybrid blood detected."
				src.Stat_Variation(25,15)
			src.Traits(Same_Species,Dad,Mum)
			src.Mutations(Same_Species,Dad,Mum)

