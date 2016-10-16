mob/Splitform
	var/function
	New()
		spawn Splitty()
		//..()
	Bump(atom/Z)
		MeleeAttack()
	proc/Splitty() while(src)
		if(Health<=0)
			view(src)<<"[src] has been defeated."
			del(src)
		sleep(10)
	Click(c)
		var/choice = c
		var/list/Choices=new
		Choices.Add("Follow","Stop","Attack Target","Attack Nearest","Destroy Splitforms","Cancel")
		if(choice in Choices)
			if(choice == "Attack Nearest") return
			if(usr) DoChoice(choice)
		else
			if(lastKnownKey==usr.key)
				choice = input("Choose Option") in Choices
				if(usr) DoChoice(choice)

	proc/DoChoice(var/_choice)
		var/c = _choice
		switch(c)
			if("Attack Nearest")
				walk(src,0)
				attacking=0
				function=1
				while(src&&function)
					for(var/mob/A in oview(12,src))
						if(A.icon_state != "KO")
							step_towards(src,A)
							break
					sleep(5)
			if("Destroy Splitforms")
				for(var/mob/Splitform/A)
					if(A.lastKnownKey == usr.key)
						del(A)
			if("Follow")
				function=0
				attacking=1
				walk(src,0)
				walk_towards(src,usr)
			if("Stop")
				function=0
				walk(src,0)
			if("Attack Target")
				walk(src,0)
				function=0
				attacking=0
				var/mob/list/Targets=new
				for(var/mob/M in oview(12,src)) Targets.Add(M)
				var/mob/Choice=input("Attack who?") in Targets
				if(Choice)
					sleep(10)
					function=1
					while(src&&function)
						if(Choice.icon_state != "KO")
							step_towards(src,Choice)
						sleep(10)


obj/SplitForm
	Difficulty=10
	desc="This will materialize a copy of yourself, made of energy. It has much the same power as you, \
	and makes a good sparring partner or assistant in battle. You can command their actions by clicking \
	on them"
	Level=1
	verb/SplitForm() if(usr.icon_state!="KO")
		set category="Skills"
		if(usr.Ki<0.5*usr.MaxKi/Level)
			usr<<"You do not have the energy"
			return
		var/Amount=0
		for(var/mob/Splitform/Z) if(Z.lastKnownKey==usr.key) Amount++
		if(Amount<Level)
			if(prob(10/(Level**2)))
				usr<<"Your split form skill has increased."
				Level++
			view(6,usr) << "[usr] creates a copy of themselves."
			Learnable=1
			spawn(100) Learnable=0
			usr.Ki-=0.5*usr.MaxKi/Level
			var/mob/Splitform/A=new
			for(var/obj/items/Boxing_Gloves/G in usr)
				if(G.suffix)
					var/obj/items/Boxing_Gloves/X = new
					X.loc = A
					X.suffix = "*Equipped*"
					break
			A.lastKnownKey=usr.key
			A.Race=usr.Race
			A.icon=usr.icon
			A.Zanzoken=usr.Zanzoken
			A.MaxKi=usr.MaxKi
			A.KiMod=usr.KiMod
			A.Pow=usr.Pow
			A.Str=usr.Str
			A.Spd=usr.Spd
			A.End=usr.End
			A.Res=usr.Res
			A.Off=usr.Off
			A.Def=usr.Def
			A.BP=usr.BP
			A.BPMod=usr.BPMod
			A.PowMod=usr.PowMod
			A.StrMod=usr.StrMod
			A.SpdMod=usr.SpdMod
			A.EndMod=usr.EndMod
			A.ResMod=usr.ResMod
			A.OffMod=usr.OffMod
			A.DefMod=usr.DefMod
			A.GravMastered=usr.GravMastered
			A.loc = usr.loc
			A.dir=usr.dir
			A.overlays.Add(usr.overlays)
			var/copies=0
			for(var/mob/Splitform/B) if(B.lastKnownKey==usr.key) copies++
			A.layer=MOB_LAYER+10
			A.name="[usr.name] Copy [copies]"
			A.screen_loc="[copies],1:0"
			usr.client.screen.Add(A)
			usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] creates [A.name].\n")
			//if(usr.Race=="Bio-Android")
				//A.overlays.Remove(A.overlays)
				//A.icon='Cell Jr.dmi'
				//var/icon/I=new(A.icon)
				//I.Scale(16,16)
				//A.icon=I
			//if(usr.Race=="Majin")
				//A.overlays.Remove(A.overlays)
				//var/icon/I=new(A.icon)
				//I.Scale(16,16)
				//A.icon=I
			if(usr.Race=="Tsufurujin"|usr.Class=="Tsufurujin") A.icon='GochekAndroid.dmi'
		else usr<<"You do not have the skill to create this many splitforms."


