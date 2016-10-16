mob/proc/Shadow_King() if(!Shadow_Power)
	if(!(locate(/obj/Shadow_King) in src))
		Health=100
		Ki=MaxKi
		if(prob(10)) contents+=new/obj/Shadow_King //Master Shadow King, use it at will
	Shadow_Power++
	BP_Multiplier*=3
	Shadow_Overlays()

mob/proc/Shadow_Revert()
	Shadow_Power-=1
	BP_Multiplier/=3
	Shadow_Overlays()

mob/proc/Shadow_Overlays()
	var/image/A=image(icon='Okage.dmi',icon_state="1",layer=MOB_LAYER+2,pixel_y=32)
	var/image/B=image(icon='Okage.dmi',icon_state="2")
	underlays.Remove('Okage.dmi',A)
	overlays-=B
	if(Shadow_Power)
		underlays.Add('Okage.dmi',A)
		overlays+=B

obj/Shadow_King
	verb/Shadow_King()
		set category="Skills"
		if(!usr.Shadow_Power)
			view(usr)<<"[usr]'s power suddenly increases greatly!"
			usr.Shadow_King()
		else usr.Shadow_Revert()
	verb/Teach()
		set category="Skills"
		var/list/People=new
		for(var/mob/A in view(usr))
			if(A.client&&!(locate(/obj/Shadow_King) in A)&&!(locate(/obj/Pseudo_King) in A)) People+=A
		var/mob/A=input("Teach who?") in People
		switch(input(A,"[usr] wants to grant you the powers of the Shadow King. You will have access to \
		a great amount of new power, but your life will be in their hands. Do you want this?") in list(\
		"Yes","No"))
			if("No")
				view(usr)<<"[A] declines the offer from [usr]"
				usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] [A] declines the offer from [usr].\n")
				A.saveToLog("| [A.client.address ? (A.client.address) : "IP not found"] | ([A.x], [A.y], [A.z]) [A] declines the offer from [usr].\n")
			if("Yes")
				view(usr)<<"[A] accepts [usr]'s offer"
				usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] [A] accepts the offer from [usr].\n")
				A.saveToLog("| [A.client.address ? (A.client.address) : "IP not found"] | ([A.x], [A.y], [A.z]) [A] accepts the offer from [usr].\n")
				if(!(locate(/obj/Pseudo_King) in A)) A.contents+=new/obj/Pseudo_King
	verb/Kill_Minion()
		set category="Skills"
		var/list/People=new
		People+="Cancel"
		for(var/mob/player/A in Players) if(locate(/obj/Pseudo_King) in A) People+=A
		var/mob/A=input("You can kill anyone who possesses shadow king powers instantly. Who do you want \
		to kill?") in People
		if(A=="Cancel") return
		A.Pseudo_Revert()
		for(var/obj/Pseudo_King/B in A) del(B)
		usr.Shadow_Crush(A)
		A.Death("his own shadow king powers betraying him")

obj/Pseudo_King/verb/Shadow_King()
	set category="Skills"
	if(!usr.Shadow_Power)
		view(usr)<<"[usr]'s power suddenly increases greatly!"
		usr.Pseudo_King()
	else usr.Pseudo_Revert()

mob/proc/Pseudo_King() if(!Shadow_Power)
	Shadow_Power++
//	if(Shadow_Power>2000000) Shadow_Power=2000000
	BP_Multiplier*=1.5
	Shadow_Overlays()

mob/proc/Pseudo_Revert()
	BP_Multiplier/=1.5
	Shadow_Power-=1
	Shadow_Overlays()

mob/proc/Shadow_Crush(mob/M)
	if(Ki<100) return
	Ki-=100
	M.Health-=1*((Pow*BP)/(M.Res*M.BP))
	M.KB=rand(3,6)
	new/obj/Explosion(M.loc)
	while(M.KB>1&&M)
		if(M.client) M.icon_state="KB"
		M.KB-=1
		M.Knockback()
		step_away(M,usr,50)
		sleep(1)
	if(M&&M.icon_state!="KO") M.icon_state=""