
//Perhaps temporary placeholder merely to increase cybernetic power.
obj/Cyberize/verb/Cyberize()
	set category="Skills"
	if(Year<20)
		usr<<"It has to be past year 20 to do this"
		return
	var/list/Choices=new
	Choices+="Cancel"
	Choices+=usr
	for(var/mob/A in get_step(usr,usr.dir)) Choices+=A
	var/mob/A=input("Choose a target") in Choices
	if(A=="Cancel") return
	if(A.Dead)
		usr<<"Dead people cannot get cybernetic implants.";return
	var/Int=usr.Int_Level
	if(Int<1) Int=1
	if(Int>usr.Int_Level) Int=usr.Int_Level
	var/Max=(Int**4)*0.2
	var/Amount=input("How much cybernetic power do you want them to have? It must be more than \
	they currently have ([Commas(A.Artificial_Power)]), and less than or equal to the maximum \
	amount you can grant ([Commas(Max)])") as num
	if(Amount>Max) Amount=Max
	var/Cost=(((Amount*40)-(A.Artificial_Power*40))+2000000)/usr.Add
	if(Cost<0) Cost=0
	for(var/obj/Resources/R in usr)
		if(R.Value<Cost)
			usr<<"You need [Commas(Cost)]$ to do this."
			return
		switch(input("This will cost [Commas(Cost)]$. Are you sure you want to do this?") in list("Yes","No"))
			if("No") return
		R.Value-=Cost
	if(Amount<=A.Artificial_Power) usr<<"You cannot decrease their artificial power."
	else switch(alert(A,"Do you want to recieve cybernetic implants that will artificially boost your \
	battle power? Your cybernetic power will be upgraded to +[Commas(Amount)] if you accept. \
	It is not all advantages, the more of your power that is cybernetic, the less of an effect \
	certain natural skills will have on you, such as anger, power up, focus, expand, super-natural powers, and \
	so forth, since they only increase natural power and not cybernetic power. You will also \
	recover energy and heal considerably slower for as long as you have cybernetic power. Cybernetic power \
	will only go away if you die. For as long as you have cybernetic power, anger shall be disabled as well\
	","Cyberization","Yes","No"))
		if("Yes")
			A.Artificial_Power = Amount
			view(usr) << "[A] accepts the offer from [usr] to become a cyborg."
			log_ability("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has cyberized [key_name(A)] granting an additional [Amount] BP")
			logAndAlertAdmins("[key_name(usr)] has cyberized [key_name(A)] granting an additional [Amount] BP")

			A.saveToLog("| [A.client.address ? (A.client.address) : "IP not found"] | ([A.x], [A.y], [A.z]) | [key_name(A)] accepts the offer from [usr] to become a cyborg.\n")
			usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] turns [A] into a cyborg.\n")

		if("No") view(usr)<<"[A] declines the offer from [usr] to become a cyborg."
	if(A.Artificial_Power>100000000) A.Artificial_Power=100000000
	switch(input("Do you want to add any skill modules?") in list("No","Yes"))
		if("Yes")
			var/list/Skills=new
			Skills+="Cancel"
			if(!A.Lungs) Skills+="Breath in Space"
			if(!A.Scanner) Skills+="Integrated Scanner"
			if(!(locate(/obj/Absorb) in A)) Skills+="Manual Absorb"
			if(A.Blast_Absorb<2) Skills+="Blast Absorb"
			switch(input("What skill module?") in Skills)
				if("Cancel") return
				if("Breath in Space")
					Cost=2000000
					for(var/obj/Resources/R in usr)
						if(R.Value<Cost)
							usr<<"You need [Commas(Cost)]$ to do this."
							return
						switch(input("This will cost [Commas(Cost)]$. Are you sure you want to do this?") in list("Yes","No"))
							if("No") return
						R.Value-=Cost
					A.Lungs=1
				if("Integrated Scanner")
					Cost=20000000
					for(var/obj/Resources/R in usr)
						if(R.Value<Cost)
							usr<<"You need [Commas(Cost)]$ to do this."
							return
						switch(input("This will cost [Commas(Cost)]$. Are you sure you want to do this?") in list("Yes","No"))
							if("No") return
						R.Value-=Cost
					A.Scanner=1
				if("Manual Absorb")
					Cost=20000000
					for(var/obj/Resources/R in usr)
						if(R.Value<Cost)
							usr<<"You need [Commas(Cost)]$ to do this."
							return
						switch(input("This will cost [Commas(Cost)]$. Are you sure you want to do this?") in list("Yes","No"))
							if("No") return
						R.Value-=Cost
					A.contents+=new/obj/Absorb
					A.Cyber_Absorb=1
				if("Blast Absorb")
					Cost=100000000
					for(var/obj/Resources/R in usr)
						if(R.Value<Cost)
							usr<<"You need [Commas(Cost)]$ to do this."
							return
						switch(input("This will cost [Commas(Cost)]$. Are you sure you want to do this?") in list("Yes","No"))
							if("No") return
						R.Value-=Cost
					A.Blast_Absorb++
					view(1,usr)<<"[A] now has the ability to absorb blasts."
					if(A.Blast_Absorb==1) view(1,usr)<<"Currently [A] can only absorb blasts when facing them. \
					However another module of this kind will allow them to absorb from any direction."
/*
Level 10 = 5'006'000$
Level 20 = 5'096'000$
Level 30 = 5'486'000$
Level 50 = 8'750'000$
Level 70 = 19'406'000$
Level 100 = 65'000'000$
*/
//--------------------------

obj/Cybernetics
	icon='Modules.dmi'
	icon_state="1"
	var/Cost=1000
	var/Advancement=1 //The level of intelligence you need to make this
	Stealable=1

/*
	Write(savefile/F)
		var/OldUsing=Using
		Using=0
		..()
		Using=OldUsing
*/

	Click()
		src:Install(usr)
		usr.Modules=0
		for(var/obj/Cybernetics/A in usr) if(A.suffix) usr.Modules++
	Cybernetic_Strength
		desc="Doubles strength, but decreases speed, power gain, regeneration, recovery, energy, \
		and natural power gain by 25%."
		Advancement=12
		Cost=10000
		proc/Install(mob/A) if(!suffix)
			suffix="Installed"
			A.Str*=2
			A.StrMod*=2
			A.Base*=0.8
			A.BP_Multiplier*=0.8
			A.Spd*=0.8
			A.SpdMod*=0.8
			A.Regeneration*=0.8
			A.Recovery*=0.8
			A.MaxKi*=0.8
			A.KiMod*=0.8
		proc/Uninstall(mob/A) if(suffix)
			suffix=null
			A.Str/=2
			A.StrMod/=2
			A.Base/=0.8
			A.BP_Multiplier/=0.8
			A.Spd/=0.8
			A.SpdMod/=0.8
			A.Regeneration/=0.8
			A.Recovery/=0.8
			A.MaxKi/=0.8
			A.KiMod/=0.8
	Armored_Skin
		desc="Double endurance, but decrease speed, power gain, regeneration, recovery, energy, \
		and natural power gain by 25%."
		Advancement=12
		Cost=10000
		proc/Install(mob/A) if(!suffix)
			suffix="Installed"
			A.End*=2
			A.EndMod*=2
			A.Base*=0.8
			A.BP_Multiplier*=0.8
			A.Spd*=0.8
			A.SpdMod*=0.8
			A.Regeneration*=0.8
			A.Recovery*=0.8
			A.MaxKi*=0.8
			A.KiMod*=0.8
		proc/Uninstall(mob/A) if(suffix)
			suffix=null
			A.End/=2
			A.EndMod/=2
			A.Base/=0.8
			A.BP_Multiplier/=0.8
			A.Spd/=0.8
			A.SpdMod/=0.8
			A.Regeneration/=0.8
			A.Recovery/=0.8
			A.MaxKi/=0.8
			A.KiMod/=0.8
	Machine_Gun
		desc="A very rapid fire ballistics weapon integrated into your body. It relies on strength and \
		cybernetic power to decide the damage is does. Not force and battle power. It will lower \
		power gain and energy by 10% to install this."
		Advancement=12
		Cost=10000
		proc/Install(mob/A) if(!suffix)
			suffix="Installed"
			A.Base*=0.9
			A.BP_Multiplier*=0.9
			A.MaxKi*=0.9
			A.KiMod*=0.9
		proc/Uninstall(mob/A) if(suffix)
			suffix=null
			A.Base/=0.9
			A.BP_Multiplier/=0.9
			A.MaxKi/=0.9
			A.KiMod/=0.9
		verb/Machine_Gun()
			set category="Skills"
			if(!suffix|Using) return
			if(usr.icon_state in list("Meditate","Train","KO")) return
			Using=1
			spawn(1) Using=0
			var/Amount=1
			while(Amount)
				Amount-=1
				var/obj/ranged/Blast/A=new
				A.Belongs_To=usr
				A.pixel_x=rand(-16,16)
				A.pixel_y=rand(-16,16)
				A.icon='Bullet.dmi'
				A.Damage=0.5*usr.Artificial_Power*(usr.Str+300)
				A.Power=0.5*usr.Artificial_Power
				A.Offense=usr.Off
				A.Shockwave=1
				A.dir=usr.dir
				A.loc=usr.loc
				walk(A,A.dir)
	Spread_Gun
		desc="A very rapid fire ballistics weapon with a wide spread. It uses strength and cybernetic \
		power to decide damage. it will lower power gain and energy by 10% to install this."
		Advancement=12
		Cost=10000
		proc/Install(mob/A) if(!suffix)
			suffix="Installed"
			A.Base*=0.9
			A.BP_Multiplier*=0.9
			A.MaxKi*=0.9
			A.KiMod*=0.9
		proc/Uninstall(mob/A) if(suffix)
			suffix=null
			A.Base/=0.9
			A.BP_Multiplier/=0.9
			A.MaxKi/=0.9
			A.KiMod/=0.9
		verb/Spread_Gun()
			set category="Skills"
			if(!suffix|Using) return
			if(usr.icon_state in list("Meditate","Train","KO")) return
			Using=1
			spawn(1) Using=0
			var/Amount=1
			while(Amount)
				Amount-=1
				var/obj/ranged/Blast/A=new
				A.Belongs_To=usr
				A.pixel_x=rand(-16,16)
				A.pixel_y=rand(-16,16)
				A.icon='Bullet.dmi'
				A.Damage=0.5*usr.Artificial_Power*(usr.Str+300)
				A.Power=0.5*usr.Artificial_Power
				A.Offense=usr.Off
				A.Shockwave=1
				A.dir=usr.dir
				switch(pick(1,2,3))
					if(1) A.loc=usr.loc
					if(2) A.loc=get_step(usr.loc,turn(usr.dir,45))
					if(3) A.loc=get_step(usr.loc,turn(usr.dir,-45))
				walk(A,A.dir)
	Shotgun
		desc="A wide spread ballistic attack that fires multiple bullets at once. It uses strength and \
		cybernetic power to decide damage. it will lower power gain and energy by 10% to install this."
		Advancement=12
		Cost=10000
		proc/Install(mob/A) if(!suffix)
			suffix="Installed"
			A.Base*=0.9
			A.BP_Multiplier*=0.9
			A.MaxKi*=0.9
			A.KiMod*=0.9
		proc/Uninstall(mob/A) if(suffix)
			suffix=null
			A.Base/=0.9
			A.BP_Multiplier/=0.9
			A.MaxKi/=0.9
			A.KiMod/=0.9
		verb/Shotgun()
			set category="Skills"
			if(!suffix|Using) return
			if(usr.icon_state in list("Meditate","Train","KO")) return
			Using=1
			spawn(15) Using=0
			var/Amount=5
			while(Amount)
				Amount-=1
				var/obj/ranged/Blast/A=new
				A.Belongs_To=usr
				A.pixel_x=rand(-16,16)
				A.pixel_y=rand(-16,16)
				A.icon='Bullet.dmi'
				A.Damage=0.5*usr.Artificial_Power*(usr.Str+300)
				A.Power=0.5*usr.Artificial_Power
				A.Offense=usr.Off
				A.Shockwave=1
				A.dir=usr.dir
				switch(pick(1,2,3))
					if(1) A.loc=usr.loc
					if(2) A.loc=get_step(usr.loc,turn(usr.dir,45))
					if(3) A.loc=get_step(usr.loc,turn(usr.dir,-45))
				walk(A,A.dir)
	Grenade
		desc="An explosive that detonates a couple seconds after being launched. It uses strength and \
		cybernetic power to decide damage. It will lower power gain and energy by 10% to install this."
		Advancement=12
		Cost=10000
		proc/Install(mob/A) if(!suffix)
			suffix="Installed"
			A.Base*=0.9
			A.BP_Multiplier*=0.9
			A.MaxKi*=0.9
			A.KiMod*=0.9
		proc/Uninstall(mob/A) if(suffix)
			suffix=null
			A.Base/=0.9
			A.BP_Multiplier/=0.9
			A.MaxKi/=0.9
			A.KiMod/=0.9
		verb/Grenade()
			set category="Skills"
			if(!suffix|Using) return
			if(usr.icon_state in list("Meditate","Train","KO")) return
			Using=1
			spawn(20) Using=0
			var/Amount=1
			while(Amount)
				Amount-=1
				var/obj/Explosive/Grenade/A=new
				A.Belongs_To=usr
				A.pixel_x=rand(-16,16)
				A.pixel_y=rand(-16,16)
				A.icon='Grenade.dmi'
				A.Damage=5*usr.Artificial_Power*(usr.Str+300)
				A.Explosive=2
				A.dir=usr.dir
				A.loc=usr.loc
				var/Steps=5
				while(Steps)
					Steps-=1
					step(A,A.dir)
					sleep(5)
				A.Explode()
	Missile
		desc="A large missile that explodes on contact. It uses strength and cybernetic power to decide \
		damage. It will lower power gain and energy by 10% to install this."
		Advancement=12
		Cost=10000
		proc/Install(mob/A) if(!suffix)
			suffix="Installed"
			A.Base*=0.9
			A.BP_Multiplier*=0.9
			A.MaxKi*=0.9
			A.KiMod*=0.9
		proc/Uninstall(mob/A) if(suffix)
			suffix=null
			A.Base/=0.9
			A.BP_Multiplier/=0.9
			A.MaxKi/=0.9
			A.KiMod/=0.9
		verb/Missile()
			set category="Skills"
			if(!suffix|Using) return
			if(usr.icon_state in list("Meditate","Train","KO")) return
			Using=1
			spawn(20) Using=0
			var/Amount=1
			while(Amount)
				Amount-=1
				var/obj/ranged/Blast/A=new
				A.Belongs_To=usr
				A.icon='Missile.dmi'
				A.Damage=20*usr.Artificial_Power*(usr.Str+300)
				A.Power=20*usr.Artificial_Power
				A.Offense=usr.Off
				A.Shockwave=1
				A.dir=usr.dir
				A.loc=usr.loc
				A.Explosive=2
				walk(A,A.dir,5)
	Boosters
		desc="Boosters that allow you to fly when necessary if you can't walk there. Such as when \
		trying to cross water or a wall. They are quite draining and only activate when needed. Power \
		gain and energy will be lowered by 10%"
		Advancement=13
		Cost=10000
		proc/Install(mob/A) if(!suffix)
			if(locate(/obj/Cybernetics/Antigravity) in A)
				A<<"This part cannot be installed with an antigravity unit. It is unecessary anyway."
				return
			if(!(locate(/obj/Cybernetics/Generator) in A))
				A<<"This cannot be installed without a generator."
				return
			suffix="Installed"
			A.Base*=0.9
			A.BP_Multiplier*=0.9
			A.MaxKi*=0.9
			A.KiMod*=0.9
		proc/Uninstall(mob/A) if(suffix)
			suffix=null
			A.Base/=0.9
			A.BP_Multiplier/=0.9
			A.MaxKi/=0.9
			A.KiMod/=0.9
	Homing_Missiles
		desc="Many tiny missiles that can home in on targets. Power gain and energy will be lowered by \
		10% to install this."
		Advancement=13
		Cost=10000
		proc/Install(mob/A) if(!suffix)
			suffix="Installed"
			A.Base*=0.9
			A.BP_Multiplier*=0.9
			A.MaxKi*=0.9
			A.KiMod*=0.9
		proc/Uninstall(mob/A) if(suffix)
			suffix=null
			A.Base/=0.9
			A.BP_Multiplier/=0.9
			A.MaxKi/=0.9
			A.KiMod/=0.9
		verb/Homing_Missiles()
			set category="Skills"
			if(!suffix|Using) return
			if(usr.icon_state in list("Meditate","Train","KO")) return
			var/mob/P=input("Choose a target") as mob in oview(usr)
			if(!P) return
			Using=1
			spawn(20) Using=0
			var/Amount=5
			while(Amount)
				Amount-=1
				var/obj/ranged/Blast/A=new
				A.Belongs_To=usr
				A.icon='Missile Small.dmi'
				A.Damage=2*usr.Artificial_Power*(usr.Str+300)
				A.Power=2*usr.Artificial_Power
				A.Offense=usr.Off
				A.dir=usr.dir
				A.loc=usr.loc
				A.pixel_x=rand(-16,16)
				A.pixel_y=rand(-16,16)
				A.Explosive=1
				A.Shockwave=1
				walk_towards(A,P,4)
				Delete_Missiles(A,50)
				spawn if(A) Random_Movement(A)
				sleep(4)
		proc/Random_Movement(obj/A) while(A)
			step_rand(A)
			sleep(rand(8,14))
		proc/Delete_Missiles(obj/A,Timer) spawn(Timer) if(A) del(A)
	Damage_Rectifier
		desc="Allows you to ignore damage, which will prevent you from being slowed down as you \
		become more damaged. Power gain, regeneration, and energy will be lowered by 20% each to \
		install this."
		Advancement=14
		Cost=10000
		var/undelayed
		proc/Install(mob/A) if(!suffix)
			suffix="Installed"
			A.Base*=0.8
			A.BP_Multiplier*=0.8
			A.MaxKi*=0.8
			A.KiMod*=0.8
			A.Regeneration*=0.8
			undelayed=A.undelayed
			A.undelayed=1
		proc/Uninstall(mob/A) if(suffix)
			suffix=null
			A.Base/=0.8
			A.BP_Multiplier/=0.8
			A.MaxKi/=0.8
			A.KiMod/=0.8
			A.Regeneration/=0.8
			A.undelayed=undelayed
	Sensor
		desc="An internal sensor with very high capabilities. Power gain and energy will be reduced by \
		10% to install this."
		Advancement=15
		Cost=10000
		proc/Install(mob/A) if(!suffix)
			suffix="Installed"
			A.Base*=0.9
			A.BP_Multiplier*=0.9
			A.MaxKi*=0.9
			A.KiMod*=0.9
		proc/Uninstall(mob/A) if(suffix)
			suffix=null
			A.Base/=0.9
			A.BP_Multiplier/=0.9
			A.MaxKi/=0.9
			A.KiMod/=0.9
		proc/Upgrade(mob/A)
			if(A.Int_Level<Level)
				A<<"It is too advanced for you to alter"
				return
			var/Amount=input(A,"You can decide how far to upgrade this. Between level 1 and [A.Int_Level]") as num
			if(Amount>A.Int_Level|Amount<1)
				A<<"You chose an invalid number."
				return
			Level=round(Amount)
	Iron_Lung
		desc="If you can't breath in space, you won't need to anymore with this. Power gain and energy \
		will reduce by 10% to install this."
		Advancement=15
		Cost=10000
		proc/Install(mob/A) if(!suffix)
			suffix="Installed"
			A.Base*=0.9
			A.BP_Multiplier*=0.9
			A.MaxKi*=0.9
			A.KiMod*=0.9
			A.Lungs++
		proc/Uninstall(mob/A) if(suffix)
			suffix=null
			A.Base/=0.9
			A.BP_Multiplier/=0.9
			A.MaxKi/=0.9
			A.KiMod/=0.9
			A.Lungs-=1
	Generator
		desc="Artificial Energy Generator used for some artificial abilities. Natural energy will be \
		reduced by 50% to install this. Regeneration and recovery will lower by 25%."
		Advancement=16
		Cost=10000
		var/Current=100
		var/Max=100
		Level=10
		proc/Install(mob/A) if(!suffix)
			suffix="Installed"
			A.MaxKi*=0.5
			A.KiMod*=0.5
			A.Recovery*=0.8
			A.Regeneration*=0.8
		proc/Uninstall(mob/A) if(suffix)
			suffix=null
			A.MaxKi/=0.5
			A.KiMod/=0.5
			A.Recovery/=0.8
			A.Regeneration/=0.8
		proc/Upgrade(mob/A)
			if(A.Int_Level<Level)
				A<<"It is too advanced for you to alter"
				return
			var/Amount=input(A,"You can decide how far to upgrade this. Between level 1 and [A.Int_Level]") as num
			if(Amount>A.Int_Level|Amount<1)
				A<<"You chose an invalid number."
				return
			Level=round(Amount)
			Max=Level**2
			Current=Max
/*		verb/Recharge_Generator()     //To be used to manually recharge generators.  Code not finished.
			set category="Skills"
			if(usr.icon_state in list("Meditate","Train","KO")) return
			if(Using|!suffix) return
			else if(Current!=Max in /obj/Cybernetics/Generator in usr)
				return
			else if (Current!=Max in /obj/Cybernetics/Generator in usr)
				for (Current)
					Current+= 1*/
	Laser_Cannon
		desc="A laser based weapon that fires a short laser burst that is decently powerful. You \
		cannot move while using this. Natural power gain, energy, and recovery will be lowered by \
		25% to install this."
		Advancement=16
		Cost=10000
		proc/Install(mob/A) if(!suffix)
			if(!(locate(/obj/Cybernetics/Generator) in A))
				A<<"This cannot be installed without a generator."
				return
			suffix="Installed"
			A.Base*=0.8
			A.BP_Multiplier*=0.8
			A.MaxKi*=0.8
			A.KiMod*=0.8
			A.Recovery*=0.8
		proc/Uninstall(mob/A) if(suffix)
			suffix=null
			A.Base/=0.8
			A.BP_Multiplier/=0.8
			A.MaxKi/=0.8
			A.KiMod/=0.8
			A.Recovery/=0.8
		verb/Laser_Cannon()
			set category="Skills"
			if(usr.icon_state in list("Meditate","Train","KO")) return
			if(Using|!suffix) return
			for(var/obj/Cybernetics/Generator/G in usr) if(G.suffix)
				if(G.Current<100) return
				G.Current-=100
				Using=1
				usr.overlays+='Laser Particles.dmi'
				sleep(40)
				usr.overlays-='Laser Particles.dmi'
				Using=0
				var/Amount=5
				var/turf/Location=get_step(usr,usr.dir)
				while(Amount)
					var/obj/ranged/Blast/A=new
					Delete_Lasers(A,10)
					A.Belongs_To=usr
					A.icon='Laser Cannon Beam.dmi'
					if(Amount==5) A.icon_state="Tail"
					if(Amount==1) A.icon_state="Head"
					A.Damage=10*usr.Artificial_Power*(usr.Pow+300)
					A.Power=10*usr.Artificial_Power
					A.Offense=usr.Off
					A.Deflectable=0
					A.dir=usr.dir
					A.loc=Location
					for(var/atom/P in Location) if(ismob(P)|isobj(P)) if(A) A.Bump(P)
					Location=get_step(Location,usr.dir)
					Amount-=1
		proc/Delete_Lasers(obj/A,Timer) spawn(Timer) if(A) del(A)
	Cybernetic_Reflexes
		desc="This increases speed by 50% but some armor must be sacrificed so endurance falls by 25%. \
		Energy and recovery and natural power gain will decrease by 25%"
		Advancement=16
		Cost=10000
		proc/Install(mob/A) if(!suffix)
			suffix="Installed"
			A.Base*=0.8
			A.BP_Multiplier*=0.8
			A.MaxKi*=0.8
			A.KiMod*=0.8
			A.Recovery*=0.8
			A.Spd*=1.5
			A.SpdMod*=1.5
			A.End*=0.8
			A.EndMod*=0.8
		proc/Uninstall(mob/A) if(suffix)
			suffix=null
			A.Base/=0.8
			A.BP_Multiplier/=0.8
			A.MaxKi/=0.8
			A.KiMod/=0.8
			A.Recovery/=0.8
			A.Spd/=1.5
			A.SpdMod/=1.5
			A.End/=0.8
			A.EndMod/=0.8
	Rapid_Lasers
		desc="A very rapid laser based attack. Natural power gain and energy will decrease by 10% \
		to install this."
		Advancement=17
		Cost=10000
		proc/Install(mob/A) if(!suffix)
			if(!(locate(/obj/Cybernetics/Generator) in A))
				A<<"This cannot be installed without a generator."
				return
			suffix="Installed"
			A.Base*=0.9
			A.BP_Multiplier*=0.9
			A.MaxKi*=0.9
			A.KiMod*=0.9
		proc/Uninstall(mob/A) if(suffix)
			suffix=null
			A.Base/=0.9
			A.BP_Multiplier/=0.9
			A.MaxKi/=0.9
			A.KiMod/=0.9
		verb/Rapid_Lasers()
			set category="Skills"
			if(!suffix|Using) return
			if(usr.icon_state in list("Meditate","Train","KO")) return
			for(var/obj/Cybernetics/Generator/G in usr) if(G.suffix)
				if(G.Current<10) return
				G.Current-=10
				Using=1
				spawn(1) Using=0
				var/Amount=1
				while(Amount)
					Amount-=1
					var/obj/ranged/Blast/A=new
					A.Belongs_To=usr
					A.pixel_x=rand(-8,8)
					A.pixel_y=rand(-8,8)
					A.icon='Rapid Lasers.dmi'
					A.icon+=rgb(255,50,50)
					A.Damage=0.5*usr.Artificial_Power*(usr.Pow+300)
					A.Power=0.5*usr.Artificial_Power
					A.Offense=usr.Off
					A.Deflectable=0
					A.dir=usr.dir
					A.loc=usr.loc
					walk(A,A.dir)
	Hand_Laser
		desc="A less rapid but larger and more powerful laser based attack. Natural power gain and \
		energy will decrease by 10% to install this."
		Advancement=17
		Cost=10000
		proc/Install(mob/A) if(!suffix)
			if(!(locate(/obj/Cybernetics/Generator) in A))
				A<<"This cannot be installed without a generator."
				return
			suffix="Installed"
			A.Base*=0.9
			A.BP_Multiplier*=0.9
			A.MaxKi*=0.9
			A.KiMod*=0.9
		proc/Uninstall(mob/A) if(suffix)
			suffix=null
			A.Base/=0.9
			A.BP_Multiplier/=0.9
			A.MaxKi/=0.9
			A.KiMod/=0.9
		verb/Hand_Lasers()
			set category="Skills"
			if(!suffix|Using) return
			if(usr.icon_state in list("Meditate","Train","KO")) return
			for(var/obj/Cybernetics/Generator/G in usr) if(G.suffix)
				if(G.Current<50) return
				G.Current-=50
				Using=1
				spawn(5) Using=0
				var/Amount=1
				while(Amount)
					Amount-=1
					var/obj/ranged/Blast/A=new
					A.Belongs_To=usr
					A.pixel_x=rand(-8,8)
					A.pixel_y=rand(-8,8)
					A.icon='36.dmi'
					A.icon+=rgb(255,50,50)
					A.Damage=2.5*usr.Artificial_Power*(usr.Pow+300)
					A.Power=2.5*usr.Artificial_Power
					A.Offense=usr.Off
					A.Deflectable=0
					A.dir=usr.dir
					A.loc=usr.loc
					walk(A,A.dir)
	Spread_Laser
		desc="A laser that fires around you in all directions at high speed. Natural power gain and \
		energy will fall by 10% to install this."
		Advancement=18
		Cost=10000
		proc/Install(mob/A) if(!suffix)
			if(!(locate(/obj/Cybernetics/Generator) in A))
				A<<"This cannot be installed without a generator."
				return
			suffix="Installed"
			A.Base*=0.9
			A.BP_Multiplier*=0.9
			A.MaxKi*=0.9
			A.KiMod*=0.9
		proc/Uninstall(mob/A) if(suffix)
			suffix=null
			A.Base/=0.9
			A.BP_Multiplier/=0.9
			A.MaxKi/=0.9
			A.KiMod/=0.9
	Advanced_Laser_Cannon
		desc="A sustainable laser beam that cannot be charged, but fires instantly. Natural power gain \
		and energy will decrease by 10% to install this."
		Advancement=19
		Cost=10000
		proc/Install(mob/A) if(!suffix)
			if(!(locate(/obj/Cybernetics/Generator) in A))
				A<<"This cannot be installed without a generator."
				return
			suffix="Installed"
			A.Base*=0.9
			A.BP_Multiplier*=0.9
			A.MaxKi*=0.9
			A.KiMod*=0.9
		proc/Uninstall(mob/A) if(suffix)
			suffix=null
			A.Base/=0.9
			A.BP_Multiplier/=0.9
			A.MaxKi/=0.9
			A.KiMod/=0.9
	Destructo_Laser
		desc="Decimates objects in a large radius in front of you by projecting a wide laser beam. \
		Natural power gain and energy will fall by 10% to install this."
		Advancement=20
		Cost=10000
		proc/Install(mob/A) if(!suffix)
			if(!(locate(/obj/Cybernetics/Generator) in A))
				A<<"This cannot be installed without a generator."
				return
			suffix="Installed"
			A.Base*=0.9
			A.BP_Multiplier*=0.9
			A.MaxKi*=0.9
			A.KiMod*=0.9
		proc/Uninstall(mob/A) if(suffix)
			suffix=null
			A.Base/=0.9
			A.BP_Multiplier/=0.9
			A.MaxKi/=0.9
			A.KiMod/=0.9
	Force_Field
		desc="This very powerful passive force field will activate whenever a blast is about to hit \
		you. It will drain energy from your generator to use this.Natural power gain, recovery, and \
		energy will decrease by 25% to install this."
		Advancement=21
		Cost=10000
		proc/Install(mob/A) if(!suffix)
			if(!(locate(/obj/Cybernetics/Generator) in A))
				A<<"This cannot be installed without a generator."
				return
			suffix="Installed"
			A.Base*=0.8
			A.BP_Multiplier*=0.8
			A.MaxKi*=0.8
			A.KiMod*=0.8
			A.Recovery*=0.8
		proc/Uninstall(mob/A) if(suffix)
			suffix=null
			A.Base/=0.8
			A.BP_Multiplier/=0.8
			A.MaxKi/=0.8
			A.KiMod/=0.8
			A.Recovery/=0.8
	Antigravity
		desc="Allows you to fly by using the energy from your generator. It is quite efficient. \
		Equipping this will unequip Boosters if they are installed. Natural power gain and energy \
		will decrease by 10% to install this."
		Advancement=21
		Cost=10000
		var/Had_Flight_Previously
		proc/Install(mob/A) if(!suffix)
			if(!(locate(/obj/Cybernetics/Generator) in A))
				A<<"This cannot be installed without a generator."
				return
			suffix="Installed"
			A.Base*=0.9
			A.BP_Multiplier*=0.9
			A.MaxKi*=0.9
			A.KiMod*=0.9
			Had_Flight_Previously=1
			if(!(locate(/obj/Fly) in A))
				contents+=new/obj/Fly
				Had_Flight_Previously=0
			for(var/obj/Cybernetics/Boosters/B in A) if(B.suffix)
				A<<"The booster was unequiped as it is no longer necessary."
				B.Uninstall(A)
		proc/Uninstall(mob/A) if(suffix)
			suffix=null
			A.Base/=0.9
			A.BP_Multiplier/=0.9
			A.MaxKi/=0.9
			A.KiMod/=0.9
			if(!Had_Flight_Previously) for(var/obj/Fly/F in A) del(F)
		verb/Flight()
	Plasma_Shot
		desc="An experimental plasma weapon. It is slower and more draining than laser weapons, \
		but also more powerful and more flexible, comparable to biological energy. Natural power gain \
		and energy will decrease by 25% to install this."
		Advancement=21
		Cost=10000
		proc/Install(mob/A) if(!suffix)
			if(!(locate(/obj/Cybernetics/Generator) in A))
				A<<"This cannot be installed without a generator."
				return
			suffix="Installed"
			A.Base*=0.8
			A.BP_Multiplier*=0.8
			A.MaxKi*=0.8
			A.KiMod*=0.8
		proc/Uninstall(mob/A) if(suffix)
			suffix=null
			A.Base/=0.8
			A.BP_Multiplier/=0.8
			A.MaxKi/=0.8
			A.KiMod/=0.8
	Overdrive_Module
		desc="Increases available power for a short random period. Your reactor will be left completely \
		drained and you may take damage. Installing this will decrease natural power gain, energy, and \
		recovery by 25%"
		Advancement=22
		Cost=10000
		proc/Install(mob/A) if(!suffix)
			if(!(locate(/obj/Cybernetics/Generator) in A))
				A<<"This cannot be installed without a generator."
				return
			suffix="Installed"
			A.Base*=0.8
			A.BP_Multiplier*=0.8
			A.MaxKi*=0.8
			A.KiMod*=0.8
			A.Recovery*=0.8
		proc/Uninstall(mob/A) if(suffix)
			suffix=null
			A.Base/=0.8
			A.BP_Multiplier/=0.8
			A.MaxKi/=0.8
			A.KiMod/=0.8
			A.Recovery/=0.8
		verb/Overdrive()
			set category="Skills"
			if(usr.icon_state in list("KO")) return
			if(usr.Overdrive_Power)
				usr<<"<font color=red>System: Overdrive is already active."
				return
			usr.Overdrive_Power=usr.Artificial_Power*1.5
	Energy_Absorbtion
		desc="Allows you to absorb the energy of a person just by grabbing them. Natural power gain, \
		energy, and recovery will be lowered by 10%."
		Advancement=22
		Cost=10000
		proc/Install(mob/A) if(!suffix)
			suffix="Installed"
			A.Base*=0.9
			A.BP_Multiplier*=0.9
			A.MaxKi*=0.9
			A.KiMod*=0.9
			A.Recovery*=0.9
		proc/Uninstall(mob/A) if(suffix)
			suffix=null
			A.Base/=0.9
			A.BP_Multiplier/=0.9
			A.MaxKi/=0.9
			A.KiMod/=0.9
			A.Recovery/=0.9
	Blast_Absorbtion
		desc="Allows you to absorb blasts to restore your own energy. It will only work from angles \
		close to where you are facing. Natural power gain, energy, and recovery will be lowered by \
		10% to install this."
		Advancement=23
		Cost=10000
		proc/Install(mob/A) if(!suffix)
			suffix="Installed"
			A.Base*=0.9
			A.BP_Multiplier*=0.9
			A.MaxKi*=0.9
			A.KiMod*=0.9
			A.Recovery*=0.9
		proc/Uninstall(mob/A) if(suffix)
			suffix=null
			A.Base/=0.9
			A.BP_Multiplier/=0.9
			A.MaxKi/=0.9
			A.KiMod/=0.9
			A.Recovery/=0.9
	Power_Absorbtion
		desc="Increase absorbed battle power by draining it from a person you have grabbed. Natural \
		power gain, energy, and regeneration will be lowered by 10% to install this."
		Advancement=23
		Cost=10000
		proc/Install(mob/A) if(!suffix)
			suffix="Installed"
			A.Base*=0.9
			A.BP_Multiplier*=0.9
			A.MaxKi*=0.9
			A.KiMod*=0.9
			A.Regeneration*=0.9
		proc/Uninstall(mob/A) if(suffix)
			suffix=null
			A.Base/=0.9
			A.BP_Multiplier/=0.9
			A.MaxKi/=0.9
			A.KiMod/=0.9
			A.Regeneration/=0.9
	Air_Absorbtion
		desc="Allows you to gradually restore artificial energy by gathering it from the air \
		around you. It is quite slow, but it helps compensate for the loss of recovery that occurs \
		from installing cybernetics. Natural power gain and energy will decrease by 10% to install this."
		Advancement=24
		Cost=10000
		proc/Install(mob/A) if(!suffix)
			if(!(locate(/obj/Cybernetics/Generator) in A))
				A<<"This cannot be installed without a generator."
				return
			suffix="Installed"
			A.Base*=0.9
			A.BP_Multiplier*=0.9
			A.MaxKi*=0.9
			A.KiMod*=0.9
		proc/Uninstall(mob/A) if(suffix)
			suffix=null
			A.Base/=0.9
			A.BP_Multiplier/=0.9
			A.MaxKi/=0.9
			A.KiMod/=0.9
	Nano_Physical_Enhancement
		desc="Enhances both strength and endurance by 20%. Regeneration and Recovery fall by 20%. \
		Natural power gain and energy fall by 25%."
		Advancement=25
		Cost=10000
		proc/Install(mob/A) if(!suffix)
			suffix="Installed"
			A.Base*=0.8
			A.BP_Multiplier*=0.8
			A.MaxKi*=0.8
			A.KiMod*=0.8
			A.Regeneration/=1.2
			A.Recovery/=1.2
			A.Str*=1.2
			A.StrMod*=1.2
			A.End*=1.2
			A.EndMod*=1.2
		proc/Uninstall(mob/A) if(suffix)
			suffix=null
			A.Base/=0.8
			A.BP_Multiplier/=0.8
			A.MaxKi/=0.8
			A.KiMod/=0.8
			A.Regeneration*=1.2
			A.Recovery*=1.2
			A.Str/=1.2
			A.StrMod/=1.2
			A.End/=1.2
			A.EndMod/=1.2
	Nano_Energy_Enhancement
		desc="Enhances both force and resistance by 20%. Regeneration and recovery fall by 20%. \
		Natural power gain and energy fall by 25%."
		Advancement=25
		Cost=10000
		proc/Install(mob/A) if(!suffix)
			suffix="Installed"
			A.Base*=0.8
			A.BP_Multiplier*=0.8
			A.MaxKi*=0.8
			A.KiMod*=0.8
			A.Regeneration/=1.2
			A.Recovery/=1.2
			A.Pow*=1.2
			A.PowMod*=1.2
			A.Res*=1.2
			A.ResMod*=1.2
		proc/Uninstall(mob/A) if(suffix)
			suffix=null
			A.Base/=0.8
			A.BP_Multiplier/=0.8
			A.MaxKi/=0.8
			A.KiMod/=0.8
			A.Regeneration*=1.2
			A.Recovery*=1.2
			A.Pow/=1.2
			A.PowMod/=1.2
			A.Res/=1.2
			A.ResMod/=1.2
	Plasma_Barrage
		desc="A rapid and explosive plasma attack that is quite powerful, and covers a decent radius. \
		Installing this will cause natural power gain and energy to fall by 25%."
		Advancement=26
		Cost=10000
		proc/Install(mob/A) if(!suffix)
			if(!(locate(/obj/Cybernetics/Generator) in A))
				A<<"This cannot be installed without a generator."
				return
			suffix="Installed"
			A.Base*=0.8
			A.BP_Multiplier*=0.8
			A.MaxKi*=0.8
			A.KiMod*=0.8
		proc/Uninstall(mob/A) if(suffix)
			suffix=null
			A.Base/=0.8
			A.BP_Multiplier/=0.8
			A.MaxKi/=0.8
			A.KiMod/=0.8
	Nano_Combat_Enhancement
		desc="Enhances both offense and defense by 20%. Natural power gain and energy fall by 25%. \
		Regeneration and Recovery fall by 20%."
		Advancement=26
		Cost=10000
		proc/Install(mob/A) if(!suffix)
			suffix="Installed"
			A.Base*=0.8
			A.BP_Multiplier*=0.8
			A.MaxKi*=0.8
			A.KiMod*=0.8
			A.Regeneration/=1.2
			A.Recovery/=1.2
			A.Off*=1.2
			A.OffMod*=1.2
			A.Def*=1.2
			A.DefMod*=1.2
		proc/Uninstall(mob/A) if(suffix)
			suffix=null
			A.Base/=0.8
			A.BP_Multiplier/=0.8
			A.MaxKi/=0.8
			A.KiMod/=0.8
			A.Regeneration*=1.2
			A.Recovery*=1.2
			A.Off/=1.2
			A.OffMod/=1.2
			A.Def/=1.2
			A.DefMod/=1.2
	Charged_Plasma
		desc="Charges an explosive plasma shot that is slow but powerful. Natural power gain and energy \
		fall by 25%."
		Advancement=27
		Cost=10000
		proc/Install(mob/A) if(!suffix)
			if(!(locate(/obj/Cybernetics/Generator) in A))
				A<<"This cannot be installed without a generator."
				return
			suffix="Installed"
			A.Base*=0.8
			A.BP_Multiplier*=0.8
			A.MaxKi*=0.8
			A.KiMod*=0.8
		proc/Uninstall(mob/A) if(suffix)
			suffix=null
			A.Base/=0.8
			A.BP_Multiplier/=0.8
			A.MaxKi/=0.8
			A.KiMod/=0.8
	Plasma_Wave
		desc="A sustainable beam of plasma that can be charged. Slow, but powerful. Natural power gain \
		and energy fall by 25%."
		Advancement=28
		Cost=10000
		proc/Install(mob/A) if(!suffix)
			if(!(locate(/obj/Cybernetics/Generator) in A))
				A<<"This cannot be installed without a generator."
				return
			suffix="Installed"
			A.Base*=0.8
			A.BP_Multiplier*=0.8
			A.MaxKi*=0.8
			A.KiMod*=0.8
		proc/Uninstall(mob/A) if(suffix)
			suffix=null
			A.Base/=0.8
			A.BP_Multiplier/=0.8
			A.MaxKi/=0.8
			A.KiMod/=0.8
	Warp_Module
		desc="Allows you to warp short distances to any location you click and increases your mobility \
		in combat, allowing you to warp around doing combos. It is very efficient. Natural power gain \
		and energy fall by 10%."
		Advancement=28
		Cost=10000
		proc/Install(mob/A) if(!suffix)
			suffix="Installed"
			A.Base*=0.9
			A.BP_Multiplier*=0.9
			A.MaxKi*=0.9
			A.KiMod*=0.9
		proc/Uninstall(mob/A) if(suffix)
			suffix=null
			A.Base/=0.9
			A.BP_Multiplier/=0.9
			A.MaxKi/=0.9
			A.KiMod/=0.9
	Health_Absorbtion
		desc="An ability which lets you absorb the health a person just by grabbing them, \
		to heal yourself. Natural power gain and energy fall by 25%."
		Advancement=29
		Cost=10000
		proc/Install(mob/A) if(!suffix)
			suffix="Installed"
			A.Base*=0.8
			A.BP_Multiplier*=0.8
			A.MaxKi*=0.8
			A.KiMod*=0.8
		proc/Uninstall(mob/A) if(suffix)
			suffix=null
			A.Base/=0.8
			A.BP_Multiplier/=0.8
			A.MaxKi/=0.8
			A.KiMod/=0.8
	Nano_Repair_Module
		desc="Nanites will repair you gradually if you are damaged. This will also compensate for the \
		loss of regeneration that occurs from installing cybernetics. Regeneration increases by 25%. \
		Natural power gain and energy fall by 25%."
		Advancement=30
		Cost=10000
		proc/Install(mob/A) if(!suffix)
			suffix="Installed"
			A.Base*=0.8
			A.BP_Multiplier*=0.8
			A.MaxKi*=0.8
			A.KiMod*=0.8
			A.Regeneration*=1.25
		proc/Uninstall(mob/A) if(suffix)
			suffix=null
			A.Base/=0.8
			A.BP_Multiplier/=0.8
			A.MaxKi/=0.8
			A.KiMod/=0.8
			A.Regeneration/=1.25
/*
You can clone someone by taking their DNA

When a cyborg is killed their modules are dropped.

Cyberization will disable certain skills at some time.

People who's intelligence is less than the advancement of the module they want to install cannot
install it themselves. Rather, there is a device that allows another person to upgrade and install
modules on to someone.
*/

/*proc(Generator) for(var/obj/Cybernetics/Generator in src)
	if (/obj/Cybernetics/Generator/ in src||/obj/Cybernetics/Generator/Current!=/obj/Cybernetics/Generator/Max)
		for(var/obj/Cybernetics/Generator in src) if(Current!=Max)
			Current++
			*/

			/*for(var/obj/Cybernetics/Force_Field/S in A) if(S.suffix)
				for(var/obj/Cybernetics/Generator/G in A) if(G.suffix)
					if(G.Current>80)
						G.Current-=80
						A.Force_Field()



						in ((var/obj/Cybernetics/Generator/) if (A.Suffix.)*/