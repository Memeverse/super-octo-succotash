
/*

Upgrade loops through all turfs owned by the player and upgrades them accordingly.

*/
obj/Mana_Upgrade
	icon = 'fx.dmi'
	icon_state = "Arcane wall"
	New()
		src.alpha = 50

turf/Upgradeable/verb/Upgrade()
	set src in oview(1)
	//debuglog << "[__FILE__]:[__LINE__] || src: [src ? src : "null"] usr: [usr ? usr : "null"] upgrade()"
	if(src.Builder==usr.ckey)
		var/Setting=1
		switch(input("Make walls able to be flown over?") in list("Yes","No"))
			if("No") Setting=0
		spawn for(var/turf/A in Turfs)
			if(prob(0.1)) sleep(1)
			if(src.Builder==A.Builder) A.FlyOverAble=Setting
	var/Amount_R = 0
	var/Amount_M = 0
	var/obj/Arcane = null
	var/Remove_Arcane = 0
	switch(input("Do you want to add resources to [Builder]'s walls, enhancing their strength further?") in list("Yes","No"))
		if("Yes")
			var/obj/Resources/A
			for(var/obj/Resources/B in usr) A=B
			Amount_R=round(input("Add how much resources to this walls durability?") as num)
			if(Amount_R>A.Value) Amount_R=A.Value
			if(Amount_R<0) Amount_R=0
			A.Value-=Amount_R
			view(usr)<<"[usr] upgraded [Builder]'s wall armor with [Commas(Amount_R)] resources."
			usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgraded [Builder]'s wall armor with [Commas(Amount_R)] resources.\n")
	if(usr.Magic_Level >= 33)
		switch(input("Do you want to add mana to [Builder]'s walls, enhancing their strength further?") in list("Yes","No"))
			if("Yes")
				var/obj/Mana_Upgrade/X = new
				switch(input("Would you like your walls and floors to have mana overlays?") in list("Yes","No"))
					if("Yes")
						Arcane = X
					if("No")
						Arcane = null
						Remove_Arcane = 1
				var/obj/Mana/A
				for(var/obj/Mana/B in usr) A=B
				Amount_M=round(input("Add how much mana to this walls durability?") as num)
				if(Amount_M>A.Value) Amount_M=A.Value
				if(Amount_M<0) Amount_M=0
				A.Value-=Amount_M
				view(usr)<<"[usr] upgraded [Builder]'s wall armor with [Commas(Amount_M)] mana."
				usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgraded [Builder]'s wall armor with [Commas(Amount_M)] mana.\n")
	for(var/turf/B in Turfs)
		if(prob(0.1)) sleep(1)
		if(usr) if(src.Builder==B.Builder)
			if(Amount_R)
				B.Health += Amount_R*1000
			if(Amount_M)
				B.Health += Amount_M*1000
				if(Arcane)
					B.overlays = null
					B.overlays += Arcane
				if(Remove_Arcane)
					B.overlays = null
	for(var/obj/B in global.worldObjectList)
		if(prob(0.1)) sleep(1)
		if(usr) if(src.Builder==B.Builder)
			if(Amount_R)
				B.Health += Amount_R*1000
			if(Amount_M)
				B.Health += Amount_M*1000
	if(Level>usr.Int_Level)
		usr<<"It is already beyond your upgrading capabilities."
		return
	if(src.Builder)
		view(usr)<<"[usr] upgraded [Builder]'s wall armor to level [usr.Int_Level]"
		usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgraded [Builder]'s wall armor to level [usr.Int_Level].\n")
		var/Y = 1 + Year
		Y = Y / 20
		for(var/turf/B in Turfs)
			if(prob(0.1)) sleep(1)
			if(usr) if(src.Builder==B.Builder)
				if(B.Level<usr.Int_Level)
					B.Level=usr.Int_Level
					B.Health=(usr.Int_Level**4)*Wall_Strength*200*Y
		for(var/obj/B in global.worldObjectList)
			if(prob(0.1)) sleep(1)
			if(usr) if(src.Builder==B.Builder)
				if(B.Level<usr.Int_Level)
					B.Level=usr.Int_Level
					B.Health=(usr.Int_Level**4)*Wall_Strength*200*Y