Event/Timer/Expand

	var/mob/player

	New(var/EventScheduler/scheduler, var/mob/D)
		..(scheduler, 20)
		src.player = D

	fire()
		..() // Make sure we allow the /Event/Timer fire() to do it's thing.

		//if(isnull(player)){log_errors("Focus Timer did not end properly, ending it now.");skills_scheduler.cancel(src);return} // Cancels itself when it has no player.
		if(isnull(player)){skills_scheduler.cancel(src);return}

		//Focus
		if(player.Expand_Clicks > 2)
			player.Expand_Clicks -= 1
			return
		for(var/obj/Expand/A in player) if(A.Using)
			var/DRAIN = 0.003
			if(player.Race == "Makyojin")
				DRAIN = 0.002
			if(player.Ki>=(player.MaxKi*DRAIN)/player.Recovery/player.KiMod) player.Ki-=(player.MaxKi*DRAIN)/pick(1,player.Recovery)/player.KiMod
			else {player.Cancel_Expand();player=null}

mob/var/tmp/Event/Timer/Expand/expand_event = null
mob/var/tmp/Expand_Clicks = 0
mob/proc/Cancel_Expand()
	if (src.expand_event)
		skills_scheduler.cancel(src.expand_event)
		var/obj/O = src.expand_event
		del(O)
		//src.focus_event = null
	src.Expand_Revert()

obj/Expand
	var/list/Overlays=new
	Difficulty=10
	var/Icon
	desc="Body Expand has four choosable levels. Each level adds 25% BP, -25% speed, +20% strength, \
	and +10% endurance, -30% defense, -15% offense, and +5% resistance. No matter what level you choose you will have \
	half regeneration and recovery. \
	It will amplify the drain of forms that already drain, such as Super Saiyan, because your recovery \
	is lower so its drain will affect you more."
	verb/Expand()
		set category="Skills"
		if(usr.icon=='Oozbody.dmi'|usr.icon=='Oozarou Gold.dmi') return
		if(!Using)
			for(var/obj/items/Power_Armor/A in usr)
				if(A.suffix)
					usr << "Unable to expand while in power armor."
					return
			var/Amount=input("Choose the expand level between 1 and 4") as num
			var/choice
			if(usr.Race=="Namekian")
				switch(alert("Enlarge also?",,"Yes","No"))
					if("Yes")
						choice=1
					else
						choice=0
			if(Using) return
			if(Amount<1) Amount=1
			if(Amount>4) Amount=4
			if(isnull(usr.expand_event))
				if(usr.Race!="Makyojin")
					usr.expand_event = new(skills_scheduler, usr)
					skills_scheduler.schedule(usr.expand_event, 20)
				usr.Expand_Clicks += 1
				Amount=round(Amount)
				Using=Amount
				Icon=usr.icon
				usr.Bandages()
				view(usr)<<"[usr]'s muscles suddenly expand ([Amount]x)"
				for(var/mob/player/M in view(usr)) if(M.client) M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] 's muscles suddenly expand ([Amount]x).\n")
				usr.Recovery*=0.5
				usr.Regeneration*=0.5
				while(Amount)
					usr.BP_Multiplier*=1.2
					//usr.FormPower*=1.2
					//usr.SSjPower*=1.2
					usr.Str*=1.2
					usr.StrMod*=1.2
					usr.Spd*=0.8
					usr.SpdMod*=0.8
					usr.End*=1.1
					usr.EndMod*=1.1
					usr.Off*=0.85
					usr.OffMod*=0.85
					usr.Def*=0.7
					usr.DefMod*=0.7
					usr.Res*=1.05
					usr.ResMod*=1.05
					Amount-=1
				if(usr.Race=="Changeling")
				//	if(Using==1) usr.icon=usr.Form5Icon
					if(Using==2) usr.icon=usr.Form6Icon
					else if(Using==3) usr.icon=usr.Form7Icon
					else if(Using==4) usr.icon=usr.Form8Icon
				if(usr.Race=="Makyojin")
					Overlays-=Overlays
					Overlays+=usr.overlays
					usr.overlays-=usr.overlays
					//usr.BP_Multiplier*=1.6
					usr.icon='Makyan.dmi'
				if(usr.Race=="Namekian"&&choice)
					usr.Enlarge_Icon()
				if(usr.icon=='Demon6.dmi') usr.icon='Demon4.dmi'
				if(usr.icon=='White Male.dmi') usr.icon='White Male Muscular 2.dmi'
				if(usr.icon=='Bio Android 3.dmi') usr.icon='Bio Android 4.dmi'
				if(usr.icon=='Bio3.dmi') usr.icon='Bio4.dmi'
				if(usr.icon=='Alien 4.dmi') usr.icon='Alien 5.dmi'
				if(usr.icon=='Spirit Doll.dmi') usr.icon='Ripped_SpiritDoll2.dmi'
				if(usr.ssj == 1||(usr.Race=="Mutant Saiyan"&&usr.Form))
					usr.overlays-=usr.ssjhair
					usr.overlays+=usr.ussjhair
		else {usr.Cancel_Expand()}
		//else usr.Expand_Revert()

mob/proc/Expand_Revert() for(var/obj/Expand/A in src) if(A.Using)
	if(icon=='Oozbody.dmi'|icon=='Oozarou Gold.dmi') return
	if(A.Overlays) overlays+=A.Overlays
	icon=A.Icon
	Recovery*=2
	Regeneration*=2
	if(ssj==1||(Race=="Mutant Saiyan"&&Form))
		overlays+=ssjhair
		overlays-=ussjhair
	while(A.Using)
		BP_Multiplier/=1.2
		//FormPower/=1.2
		//SSjPower/=1.2
		Str/=1.2
		StrMod/=1.2
		Spd/=0.8
		SpdMod/=0.8
		Off/=0.85
		OffMod/=0.85
		Def/=0.7
		DefMod/=0.7
		End/=1.1
		EndMod/=1.1
		Res/=1.05
		ResMod/=1.05
		A.Using-=1
	//if(usr.Race=="Makyojin")
		//usr.BP_Multiplier/=1.6
	if (Race=="Namekian")
		overlays-=overlays
		for(var/obj/I in usr)
			if(I.suffix == "*Equipped*")
				overlays += I
	//	usr.underlays-=usr.underlays
	view(usr)<<"[usr] stops expanding their muscles"
	for(var/mob/player/M in view(usr)) if(M.client) M.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(usr)] stops expanding their muscles.\n")
	break