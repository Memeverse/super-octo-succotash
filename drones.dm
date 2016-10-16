/*
 * A bunch of code for Drones that I'm not willing to sort through. -- Vale
*/
/obj/items/Drone
	icon='Android Spider.dmi'
//	SpawnDrone(usr)
			/*check_access(var/obj/items/Door_Pass/D)
				if(src.Password == D.Password)
					return 1
				else
					return 0*/
/*check_keycard(var/obj/items/Door_Pass/L)
	for(var/mob/player/P in oview(12,src))
		if(!P.Client)
			sleep(10)
			break
		if(P.Password!=L.Password)
			step_towards(src,P)
			sleep(4)
			break   Just some remnants of random test code I made to try and test FoF.*/

mob/Drone
	icon='Android Spider.dmi'
	var/function
	var/dronekey
	var/target
	Savable = 1
/*	New()

		spawn Drone()
		//..()
	proc/Drone() while(src)
		if(Health<=0)
			view(src)<<"[src] has been defeated."
			del(src)
		sleep(10)*/
	Click()
		if(dronekey==usr.ckey)
			var/list/Choices=new
			Choices.Add("Follow","Stop","Attack Target","Guard Area","Destroy Drones","Destroy this drone","Cancel") //"Guard Area"
			switch(input("Choose Option") in Choices)

				/*if("Guard Area")
					walk(src,0)
					attacking=0
					function=1
					spawn while(src&&function)
						for(var/mob/A in oview(12,src))
							step_towards(src,A)
							break
						sleep(5)*/
				if("Guard Area")
					walk(src,0)
					attacking=0
					function=1

					spawn while(src&&function)
						var/obj/items/Door_Pass/L //=null
						sleep(15)

						for(var/mob/P in oview(12,src)) for(L in P) // for(var/mob/player/P in oview(12,src)) for(L in usr)  for(L in usr)  original   NPC_AI not taken into account.  Drones not attacking each other. /mob/Drone  /NPC_AI/Hostile/Tiger_Bandit
						//	if(!P.client)
							//	sleep (5)
							//	break

							if(L in P.contents)
								//world << "<font color=red><b>DEBUG:</b></font> Key found in [P]."
								for(L in P.contents)
									if(L.Password == src.password)
										sleep(2)
										//world << "<font color=red><b>DEBUG:</b></font> Drone password and [P]'s key are the same, ignoring target."
										break
									else if(P.icon_state != "KO")
										//world << "<font color=red><b>DEBUG:</b></font> Drone password [src.password] and [P]'s password [L.Password] are NOT the same. Attacking."
										step_towards(src,P)
										sleep(4)
										break


							else if(P.icon_state != "KO")
								//world << "<font color=red><b>DEBUG:</b></font> No key found in [P]. Attacking."
								step_towards(src,P)
								sleep(4)
								break

							sleep(15)


						/*for(var/mob/L in oview(12,src))
							if(L.displaykey!=usr.displaykey)
								step_towards(src,L)
								sleep(4)
								break
							else
								sleep(4)
								break*/
				if("Destroy Drones") for(var/mob/Drone/A) if(dronekey==usr.ckey) del(A)
				if("Destroy this drone") del(src)
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
					sleep(3)
					function=1
					while(src&&function)
						if(Choice.icon_state != "KO")
							step_towards(src,Choice)
						sleep(10)

	verb/Upgrade()
		set src in oview(1)
		if(usr.Int_Level<Tech)
			usr<<"This is too advanced for you to mess with."
			return
		var/obj/Resources/A
		for(var/obj/Resources/B in usr) A=B
		var/Cost=40000/usr.Add
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
		for(var/mob/player/M in view(src)) if(M.client) M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades the [src] to level [Upgrade]. \n")
		A.Value-=Cost
		Tech=Upgrade
		desc="Level [Tech] [src]"
		if (Race=="Tsufurujin")
			BP=Upgrade*(ScalingPower*(1/2)*(1/4))    //2*usr.Int_Level*(Year*Year_Speed)
		else
			BP=Upgrade*1.5*usr.Int_Level*(Year*Year_Speed)
		Str=Upgrade*(usr.Int_Level/1.4)
		End=Upgrade*(usr.Int_Level/1.4)
		Res=Upgrade*(usr.Int_Level/1.4)
		Off=Upgrade*(usr.Int_Level/1.4)
		Def=Upgrade*(usr.Int_Level/1.4)
	verb/Set_Password()
		set src in oview(1)
		if (password==" ")
			password=input("Enter a password to keep this drone from being stolen from you.") as text
			usr<<"Password set!"
	verb/Claim_Drone()
		set src in oview(1)
		var/Claim_Drone=input("What is this drone's password?")
		if (Claim_Drone!=password)
			usr<<"Incorrect password."
		if (Claim_Drone==password)
			dronekey=usr.ckey
			usr<<"You have claimed this drone!"
			usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has claimed [src].\n")
/*	for(var/mob/player/A in Players)
		if(A.Age>=20) //XPGained>=(Year*50)
			People++
			var/TheirXP=A.Gain_Multiplier*(1/2)
			if(People==1)
				XPRank+=TheirXP*(1/2)
			else
				XPRank+=TheirXP/People*/

/*mob/Drone
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
	Click()
		if(lastKnownKey==usr.key)
			var/list/Choices=new
			Choices.Add("Follow","Stop","Attack Target","Attack Nearest","Destroy Splitforms","Cancel")
			switch(input("Choose Option") in Choices)
				if("Attack Nearest")
					walk(src,0)
					attacking=0
					function=1
					while(src&&function)
						for(var/mob/A in oview(12,src))
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
					sleep(10)
					function=1
					while(src&&function)
						step_towards(src,Choice)
						sleep(10)*/