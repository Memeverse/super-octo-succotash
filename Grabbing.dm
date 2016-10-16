
mob/verb
	Grab()
		set category="Skills"
		if(global.rebooting)
			usr << "Unable to pick up or drop items while a reboot is in progress."
			return
		if(GrabbedMob && src.isGrabbing==1)
			if(ismob(GrabbedMob)) GrabbedMob.grabberSTR=null
			for(var/mob/player/M in view(src)) if(M.client) M.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(src)] [key_name(usr)] releases [GrabbedMob]\n")
			src.GrabbedMob = null
			src.isGrabbing = null
			return

		if(icon_state!="KO")
			var/Amount=0
			var/list/Choices=new
			for(var/obj/A in get_step(src,dir)) if(A.Grabbable)
				Choices+=A
				Amount++
			for(var/mob/A in get_step(src,dir))
				if(ghostDens_check(A)) continue
				if(!A.attacking)
					Choices+=A
					Amount++
			var/obj/Resources/B
			for(var/atom/X in Choices)
				for(var/mob/Z in range(1,X))
					if(Z != src) if(Z.GrabbedMob == X)
						Choices -= X
			if(Amount==1) for(var/atom/A in Choices) B=A
			else B=input("Choose") in Choices
			if(!(locate(usr) in range(1,B))) return
			if(B&&isobj(B)&&B.Bolted)
				src<<"It is bolted. You cannot get it."
				return
			if(B)if(B.Burning)
				src << "It's on fire!"
				return
			if(istype(B,/obj/Ships/)) if(src.z == 11)
				src << "Unable to move that while in space."
				return
			if(istype(B,/obj/Resources)) for(var/obj/Resources/C in src)
				view(src)<<"[src] picks up [B]"
				for(var/mob/player/M in view(src)) if(M.client) M.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(src)]  picks up [B]\n")
				C.Value+=B.Value
				del(B)
				return
			if(istype(B,/obj/Mana)) for(var/obj/Mana/C in src)
				view(src)<<"[src] picks up [B]"
				for(var/mob/player/M in view(src)) if(M.client) M.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(src)]  picks up [B]\n")
				C.Value+=B.Value
				del(B)
				return

			if(istype(B,/obj/items))
				if(!istype(B,/obj/items/Android_Chassis)) if(!istype(B,/obj/items/Power_Armor)) if(!istype(B,/obj/items/Recycler)) if(!istype(B,/obj/items/Regenerator))
					if(istype(B,/obj/items/Gravity))
						var/obj/items/Gravity/C=B
						C.Deactivate()
					contents+=B
					view(src)<<"[src] picks up [B]"
					for(var/mob/player/M in view(src)) if(M.client) M.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(src)] picks up [B]\n")
					return

			if(!attacking)
				if(isobj(B)&&!B.Grabbable) return
				GrabbedMob=B
				src.isGrabbing=1 //Check if failure occurs
				if(ismob(B))
					if(B in range(1,src)) //Make sure they're at most 1 tile away.
						var/mob/M=B
						if(M.digging_event)
							src << "[M] is digging. You cannot grab them."
							return
						M.grabberSTR=Str*BP

				for(var/mob/player/M in orange(1,src)) if(M.client) M.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(src)] [key_name(usr)] grabs [M]\n")
				spawn grab()

mob/proc/grab()
	while(GrabbedMob && src.isGrabbing==1)
		//step_towards(GrabbedMob,loc)	//:v
		GrabbedMob.loc = loc	//double :v
		if(ismob(GrabbedMob))
			GrabbedMob.grabberSTR=Str*BP
			GrabbedMob.dir=turn(dir,180)
		if(icon_state=="KO")
			view()<<"[usr] is forced to release [GrabbedMob]!"
			for(var/mob/player/M in view(src)) if(M.client) M.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(src)] [key_name(usr)] is forced to release [GrabbedMob]\n")
			if(ismob(GrabbedMob)) GrabbedMob.grabberSTR=null
			attacking=0
			src.isGrabbing=null
		sleep(1)
