

obj/items
	Simulation_Crystal
		desc="You can use this to create a magical sparring partner with the BP that you choose. \
		To use it, click it once"
		layer=MOB_LAYER+10
		Stealable=1
		icon='fx.dmi'
		icon_state="crystal sim"
		density=1
		var/Max=1
		Click() if(usr in range(1,src))
			var/mob/A=new
			A.name="[usr] Simulation"
			var/Power_Setting=input("What BP will you give this simulation?.Up to [round((Max*500),20)]") as num
			if(!A) return
			A.BP=Power_Setting
			if(A.BP>Max*500) A.BP=Max*500
			for(var/mob/B) if(B.name=="[usr] Simulation"&&B!=A) del(B)
			if(A.BP<1) return
			A.sim=1
			A.Str=usr.Str
			A.Spd=usr.Spd
			A.End=usr.End
			A.Off=usr.Off
			A.Def=usr.Def
			var/icon/I=new(usr.icon)
			I.Blend(rgb(0,0,0,100),ICON_ADD)
			A.icon=I
			spawn(2400) if(A) del(A)
			A.loc=usr.loc
			walk_towards(A,usr)
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
		verb/Enhance()
			set src in oview(1)
			if(usr.Magic_Level<Tech)
				usr<<"This is too advanced for you to mess with."
				return
			var/obj/Mana/A
			for(var/obj/Mana/B in usr) A=B
			var/Cost=200000/usr.Magic_Potential
			var/Max_Upgrade=(A.Value/Cost)+usr.Magic_Level
			if(Max_Upgrade>usr.Magic_Level) Max_Upgrade=usr.Magic_Level
			var/Upgrade=input("Upgrade it to what level? (1-[round(Max_Upgrade)]). The maximum amount you can enchance is determined by your magical skill (Max Upgrade cannot exceed Magic Skill), and how much mana you have. So if the maximum is less than your magical skill then it is instead due to not having enough mana to enhance it higher than the said maximum.") as num
			if(Upgrade>usr.Magic_Level) Upgrade=usr.Magic_Level
			if(Upgrade>Max_Upgrade) Upgrade=Max_Upgrade
			if(Upgrade<1) Upgrade=1
			Upgrade=round(Upgrade)
			if(Upgrade<Tech) switch(input("You wish to bring this Level [Tech] [src] to Level [Upgrade]?") in list("Yes","No"))
				if("No") return
			Cost*=Upgrade-Tech
			if(Cost<0) Cost=0
			if(Cost>A.Value)
				usr<<"You do not have enough mana to upgrade it to level [Upgrade]"
				return
			view(src)<<"[usr] upgrades the [src] to level [Upgrade]"
			for(var/mob/player/M in view(src)) if(M.client) M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades [src] to level [Upgrade].\n")
			A.Value-=Cost
			Tech=Upgrade
			desc="Level [Tech] [src]"
			Max=Upgrade*0.01*rand(80,120)

			//Normal upgrade price 20000
			//Upgraded price 200000
	Simulator
		desc="You can use this to create a holographic sparring partner with the BP that you choose. \
		To use it, click it once"
		layer=MOB_LAYER+10
		Stealable=1
		icon='Space.dmi'
		icon_state="terminal"
		density=1
		Savable = 1
		var/Max=1
		Click() if(usr in range(1,src))
			var/mob/A=new
			A.name="[usr] Simulation"
			var/Power_Setting=input("What BP will you give this simulation? This drains some of the \
			simulator's energy each time you create one. Up to [round((Max*500),20)]") as num
			if(!A) return
			A.BP=Power_Setting
			if(A.BP>Max*500) A.BP=Max*500
			for(var/mob/B) if(B.name=="[usr] Simulation"&&B!=A) del(B)
			if(A.BP<1) return
			A.sim=1
			A.Str=usr.Str
			A.Spd=usr.Spd
			A.End=usr.End
			A.Off=usr.Off
			A.Def=usr.Def
			var/icon/I=new(usr.icon)
			I.Blend(rgb(0,0,0,100),ICON_ADD)
			A.icon=I
			spawn(2400) if(A) del(A)
			A.loc=usr.loc
			walk_towards(A,usr)
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
			if(A.Value>=1000*Tech/usr.Add) Choices.Add("Sim Power ([1000*Tech/usr.Add])")
			if(!Choices)
				usr<<"You do not have enough resources"
				return
			var/Choice=input("Change what?") in Choices
			if(Choice=="Sim Power ([1000*Tech/usr.Add])")
				if(A.Value<1000*Tech/usr.Add) return
				A.Value-=1000*Tech/usr.Add
				Max++
			Tech++
			desc=null
			desc+="<br>Sim Power: [Commas(Max*500)]"*/
		verb/Upgrade()
			set src in oview(1)
			if(usr.Int_Level<Tech)
				usr<<"This is too advanced for you to mess with."
				return
			var/obj/Resources/A
			for(var/obj/Resources/B in usr) A=B
			var/Cost=200000/usr.Add
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
			for(var/mob/player/M in view(src)) if(M.client) M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades [src] to level [Upgrade].\n")
			A.Value-=Cost
			Tech=Upgrade
			desc="Level [Tech] [src]"
			Max=Upgrade*0.01*rand(80,120)

			//Normal upgrade price 20000
			//Upgraded price 200000