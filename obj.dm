obj/var
	ChangeIconOwner
	ChangeIconIP
	Stealable
	Can_Drop_With_Suffix
	Bullet
	Injection
	Money
	Using
	Shockwaveable=1
	Grabbable=1
	Bolted
	Difficulty=1
	Tech=1
	Can_Change = 1

	tmp
		Sokidan
		Learnable

proc/SpawnAndroidShip()
	var/totalcount
	var/count
	for(var/obj/AndroidShips/A in world)
		totalcount++
	if(totalcount==1)
		return
	else if(!totalcount)
		var/obj/AndroidShips/Ship/A = new
		A.loc = locate(258,406,11)
		A.Ship = 50
		log_errors("Found no androidships, added a new one.")
		src << "Found no androidships, added a new one."
		return
	else
		for(var/obj/AndroidShips/A in world)
			if(A.Tech==1)
				del(A)
				count++
		log_errors("Deleted [count] duplicate Androidships.")
		src << "Deleted [count] duplicate Androidships."
		if(totalcount-count<=0) SpawnAndroidShip()


/*obj/New()
	if(type==/obj)
		del(src)
	..()
*/
obj
	TrainingEq
		density =1
		Flammable = 1
		var
			BP
			End
			Res
			Def
			P_BagG=1
			Leech_On=0

		Dummy
			name="Log"
			icon='NEW DUMMY.dmi'
			icon_state="Off"
			desc = "You can strike this dummy, it will blink yellow in one of four different sides. Strike the correct side time after time to use this training tool effectively. Hitting the wrong side will incur the inability to gain stats for a time."
			BP=100
			Health=100
			End=250000
			Res=250000
			Def=0.01
			P_BagG=1

			New()
				Health=100
				icon_state="Off"
				P_BagG=1
				//..()
			verb/Upgrade()
				set src in oview(1)
				for(var/obj/Resources/A in usr)
					var/Amount=input("How much endurance do you want to add? (Up to [Commas(A.Value)])") as num
					if(Amount>round(A.Value)) Amount=round(A.Value)
					if(Amount<0) Amount=0
					A.Value-=Amount
					Amount*=usr.Add
					//Un_KO()
					Health+=Amount
					view(usr)<<"[usr] added [Commas(Amount)] to the [src]'s armor"
				desc="Health: [Health*10]"
				icon_state="Off"

		Magic_Goo
			icon='Magic Punching Bag.dmi'
			BP=100
			Health=100
			End=25000
			Res=250000
			Def=0.01
			P_BagG=0.5
			Can_Change = 0
			New()
				Health=100
				icon_state=""
				P_BagG=0.5
				//..()
			verb/Enhance()
				set src in oview(1)
				for(var/obj/Mana/A in usr)
					var/Amount=input("How much endurance do you want to add? (Up to [Commas(A.Value)])") as num
					if(Amount>round(A.Value)) Amount=round(A.Value)
					if(Amount<0) Amount=0
					A.Value-=Amount
					Amount*=usr.Magic_Potential
					//Un_KO()
					Health+=Amount
					view(usr)<<"[usr] added [Commas(Amount)] to the [src]'s armor"
				desc="Health: [Health]"
				icon_state=""
		Punching_Bag
			icon='Punching Bag.dmi'
			BP=100
			Health=100
			End=25000
			Res=250000
			Def=0.01
			P_BagG=0.5
			Can_Change = 0
			New()
				Health=100
				icon_state=""
				P_BagG=0.5
				//..()
			verb/Upgrade()
				set src in oview(1)
				for(var/obj/Resources/A in usr)
					var/Amount=input("How much endurance do you want to add? (Up to [Commas(A.Value)])") as num
					if(Amount>round(A.Value)) Amount=round(A.Value)
					if(Amount<0) Amount=0
					A.Value-=Amount
					Amount*=usr.Add
					//Un_KO()
					Health+=Amount
					view(usr)<<"[usr] added [Commas(Amount)] to the [src]'s armor"
				desc="Health: [Health]"
				icon_state=""
