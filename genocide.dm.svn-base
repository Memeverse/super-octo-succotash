obj/Attacks/Genocide
	var/Charging
	Difficulty=10
	icon='18.dmi'
	desc="This is a very weak attack, but it homes in on random targets across the planet. You can \
	press it once to begin firing, and you can press it again to stop or wait til you run out of \
	energy. It drains a lot of energy to use."
	verb/Genocide()
		set category="Skills"
		if(Charging)
			Charging=0
		else if(!Charging)
			if((usr.icon_state in list("Meditate","Train","KO","KB"))||usr.Frozen) return
			if(usr.attacking|usr.Ki<10) return
			Charging=1
			usr.overlays+='SBombGivePower.dmi'
			usr.attacking=3
			sleep(100/usr.Refire)
			var/list/Peoples=new
			for(var/mob/Z)
				if(Z.z==usr.z&&Z!=usr)
					if(Z.real_name || istype(Z, /mob/player)|| istype(Z, /NPC_AI))	//no punching bags lol
						Peoples+=Z
			while(Charging&&usr.icon_state!="KO"&&usr.Ki>10)
				for(var/mob/B in Peoples)
					var/obj/ranged/Blast/A=new
					A.Belongs_To=usr
					A.icon=icon
					A.Damage=2*usr.BP*usr.Pow*Ki_Power
					A.Power=2*usr.BP*Ki_Power
					A.Offense=usr.Off
					A.loc=usr.loc
					A.dir=NORTH
					walk_towards(A,B)
					sleep(2)
				usr.Ki-=10
				sleep(rand(1,5))
			usr.overlays-='SBombGivePower.dmi'
			usr.attacking=0
			Charging=0
		else Charging=0