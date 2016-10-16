obj/Vampire_Infect
	desc="You can use this ability to give someone vampiric abilities and stats, however there are draw backs. Each infection will drain you of 1000 of your max energy and 10% of your current stats while adding 10% to your chosen targets stat mods."
	verb/Vampire_Infect()
		set category="Skills"
		if(usr.MaxKi >= 1000)
			for(var/mob/P in get_step(usr,usr.dir)) if(P.client)
				if(P.icon_state!="KO") switch(input(P,"Do you want [usr] to turn you into a vampire?") in list("No","Yes"))
					if("No") return
				if(P.Vampire_Immune)
					usr<<"They seem to be immune to vampirism."
					return
				if(P.Vampire)
					usr<<"They are already a vampire"
					return
				usr.MaxKi -= 1000
				view(usr)<<"[usr] bites [P] and turns them into a vampire!"
				usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] turns [P] into a vampire \n")
				alertAdmins("[key_name_admin(usr)] has turned [P] into a vampire.")
				usr.Str/= 1.1
				usr.End/= 1.1
				usr.Res/= 1.1
				usr.Def/= 1.1
				usr.Off/= 1.1
				usr.Pow/= 1.1
				P.Vampire=1
				P.Decline=9999999999999999999999999999999999999999999999999999999999999999999
				P.Regeneration*=2
				P.SpdMod*=1.1
				P.StrMod*=1.1
				P.Str*= 1.1
				P.EndMod*=1.1
				P.End*=1.1
				P.ResMod*=1.1
				P.Res*=1.1
				P.DefMod*=1.1
				P.Def*=1.1
				P.OffMod*=1.1
				P.Off*=1.1
				P.Magic_Potential += 0.5
				P.BPMod*=1.1
				if(P.Regenerate == 0)
					P.Regenerate+=0.3
				P.Un_KO()
				return

obj/Vampire_Absorb
	desc="This ability can be turned on to allow you to absorb the energy of a person you are sparring \
	with each time you hit them. The drawback is that while using this your resistance and force will be halved."
	var/Active
	verb/Vampire_Absorb()
		set category="Skills"
		Active=!Active
		if(Active)
			usr<<"You will now absorb the energy of people you spar with."
			usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] activates Vampire Absorb and will now absorb the energy of the people they fight/spar.\n")
			usr.Pow*=0.5
			usr.PowMod*=0.5
			usr.Res*=0.5
			usr.ResMod*=0.5
		else
			usr<<"You will not absorb the energy of people you spar with."
			usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] deactivates Vampire Absorb and will no longer absorb the energy of the people they fight/spar.\n")
			usr.Pow*=2
			usr.PowMod*=2
			usr.Res*=2
			usr.ResMod*=2

obj/Turn_To_Smoke
	desc="When you active this, you can turn into smoke and move really fast, but you will not be able to \
	use melee attacks"
	var/Active
	verb/Smoke_Form()
		set category="Skills"

		usr << "Smoke form is being phased out. Please do not use this skill."
		del(src)
/*
		if(!Active)
			Active=1
			icon=usr.icon
			overlays=usr.overlays
			usr.icon='Smoke.dmi'
			usr.overlays-=usr.overlays
		else
			Active=0
			usr.icon=icon
			usr.overlays=overlays
*/

mob/proc/Vampire_Skills()
	contents.Add(new/obj/Vampire_Absorb,new/obj/Turn_To_Smoke,new/obj/Vampire_Infect,new/obj/Send_Energy)