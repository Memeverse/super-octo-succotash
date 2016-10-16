obj/Make_Magic_Balls
	desc="Scatter will allow you to automatically scatter any Magic balls in your inventory across \
	the planet you are on. Magic Balls command will create any missing Magic Balls from your set \
	and update all existing Magic Balls to your current wishing power."
	verb/Scatter()
		set category="Skills"
		if(usr.z==1|usr.z==3|usr.z==4|usr.z==5|usr.z==6|usr.z==7|usr.z==8|usr.z==12)
			for(var/obj/items/Magic_Ball/A in view(usr)) if(A.Creator==usr.key)
				A.Home=usr.z
				spawn A.Scatter()
			log_ability("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] scattered the magic balls on z[usr.z]")
			logAndAlertAdmins("[key_name(usr)] scattered the magic balls on z[usr.z]")
			usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] scatters the magic balls.\n")
		else src<<"You cannot scatter them in here."
	verb/Magic_Balls()
		set category="Skills"
		var/DB1
		var/DB2
		var/DB3
		var/DB4
		var/DB5
		var/DB6
		var/DB7
		for(var/obj/items/Magic_Ball/A) if(A.Creator==usr.key)
			if(A.name=="Magic Ball 1") DB1=1
			if(A.name=="Magic Ball 2") DB2=1
			if(A.name=="Magic Ball 3") DB3=1
			if(A.name=="Magic Ball 4") DB4=1
			if(A.name=="Magic Ball 5") DB5=1
			if(A.name=="Magic Ball 6") DB6=1
			if(A.name=="Magic Ball 7") DB7=1
		if(!DB1)
			var/obj/items/Magic_Ball/A=new(locate(usr.x,usr.y,usr.z))
			A.name="Magic Ball 1"
			A.Creator=usr.key
		if(!DB2)
			var/obj/items/Magic_Ball/A=new(locate(usr.x,usr.y,usr.z))
			A.name="Magic Ball 2"
			A.Creator=usr.key
		if(!DB3)
			var/obj/items/Magic_Ball/A=new(locate(usr.x,usr.y,usr.z))
			A.name="Magic Ball 3"
			A.Creator=usr.key
		if(!DB4)
			var/obj/items/Magic_Ball/A=new(locate(usr.x,usr.y,usr.z))
			A.name="Magic Ball 4"
			A.Creator=usr.key
		if(!DB5)
			var/obj/items/Magic_Ball/A=new(locate(usr.x,usr.y,usr.z))
			A.name="Magic Ball 5"
			A.Creator=usr.key
		if(!DB6)
			var/obj/items/Magic_Ball/A=new(locate(usr.x,usr.y,usr.z))
			A.name="Magic Ball 6"
			A.Creator=usr.key
		if(!DB7)
			var/obj/items/Magic_Ball/A=new(locate(usr.x,usr.y,usr.z))
			A.name="Magic Ball 7"
			A.Creator=usr.key
		var/DB_Icon
		for(var/obj/items/Magic_Ball/A) if(A.Creator==usr.key)
			if(A.icon!=initial(A.icon)) DB_Icon=A.icon
			A.WishPower=usr.MaxKi
		var/R=rand(0,150)
		var/G=rand(0,150)
		var/B=rand(0,150)
		for(var/obj/items/Magic_Ball/A) if(A.Creator==usr.key)
			if(DB_Icon) A.icon=DB_Icon
			else A.icon+=rgb(R,G,B)
		usr<<"All existing Magic Balls made by you were brought up to [Commas(usr.MaxKi)] Wish Power"
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		if(A.Race!=usr.Race) usr<<"They are not the same race as you and therefore cannot learn."
		else
			Teachify(A,25000)
obj/items/Magic_Ball
	icon='Dragon Balls.dmi'
	desc="One of the seven magic balls. When all seven are gathered you will be granted a wish"
	Health=1.#INF
	Stealable=1
	var/Creator
	var/WishPower
	var/Home
	var/Wishes
	New()
		spawn(10) Active()
		//..()
	proc/Scatter()
		overlays+='Dragon Ball Aura.dmi'
		walk_rand(src)
		spawn(100) z=Home
		sleep(3000)
		walk(src,0)
		overlays-='Dragon Ball Aura.dmi'
	proc/Inert()
		icon_state=null
		spawn(360000) Active()
	proc/Active()
		Wishes=1+(round(WishPower/20000))
		Wishes = min(Wishes,5)
		overlays-='Dragon Ball Aura.dmi'
		if(name=="Magic Ball 1")
			icon_state="1"
			pixel_x=0
			pixel_y=0
		if(name=="Magic Ball 2")
			icon_state="2"
			pixel_x=-16
			pixel_y=0
		if(name=="Magic Ball 3")
			icon_state="3"
			pixel_x=16
			pixel_y=0
		if(name=="Magic Ball 4")
			icon_state="4"
			pixel_x=-8
			pixel_y=16
		if(name=="Magic Ball 5")
			icon_state="5"
			pixel_x=8
			pixel_y=16
		if(name=="Magic Ball 6")
			icon_state="6"
			pixel_x=-8
			pixel_y=-16
		if(name=="Magic Ball 7")
			icon_state="7"
			pixel_x=8
			pixel_y=-16
	verb/Wish()
		set src in oview(1)
		var/Magic_Balls=0
		for(var/obj/items/Magic_Ball/A in range(0,src)) if(A.Creator==Creator) Magic_Balls++
		if(Magic_Balls<7)
			usr<<"All 7 Magic Balls are not gathered here."
			return
		if(!icon_state)
			usr<<"THE BALLS ARE INERT!"
			return
		if(!Home)
			usr<<"These Magic Balls cannot be wished with until they have been scattered for the first \
			time by their creator."
			return
		var/list/Choices=new
		Choices+="Power For Someone"
		if(WishPower>2000) Choices+="Immortality"
		if(WishPower>2000) Choices+="Revive"
		if(!Earth|!Namek|!Vegeta|!Arconia|!Ice)
			if(WishPower>10000) Choices+="Restore Planet"
			if(WishPower>70000) Choices+="Restore Galaxy"
		Choices+="Nothing"
		while(Wishes)
			Wishes-=1
			view(src)<<"[usr] is making a wish!"
			switch(input("What is your wish?") in Choices)
				if("Nothing")
					if(!Wishes) return
					view(usr)<<"[usr] cancelled their wish"
					Wishes++
					return
				if("Restore Planet")
					if(!Wishes) return
					var/list/Planets=new
					if(!Earth) Planets+="Earth"
					if(!Namek) Planets+="Namek"
					if(!Vegeta) Planets+="Vegeta"
					if(!Arconia) Planets+="Arconia"
					if(!Ice) Planets+="Ice"
					if(!Planets)
						view(usr)<<"There are no planets destroyed, please make another wish."
						return
					switch(input("Which planet?") in Planets)
						if("Earth")
							spawn Planet_Restore(1)
							view(usr)<<"[usr] wishes to restore Earth!"
							log_game("[key_name(usr)] has wished to restore Earth with the Magic Balls")
							logAndAlertAdmins("[key_name(usr)] has wished to restore Earth with the Magic Balls")
							usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] restored planet Earth with the Magic Balls.\n")

						if("Namek")
							spawn Planet_Restore(3)
							view(usr)<<"[usr] wishes to restore Namek!"
							log_game("[key_name(usr)] has wished to restore Namek with the Magic Balls")
							logAndAlertAdmins("[key_name(usr)] has wished to restore Namek with the Magic Balls")
							usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] restored planet Namek with the Magic Balls.\n")
						if("Vegeta")
							spawn Planet_Restore(4)
							view(usr)<<"[usr] wishes to restore Vegeta!"
							log_game("[key_name(usr)] has wished to restore Vegeta with the Magic Balls")
							logAndAlertAdmins("[key_name(usr)] has wished to restore Vegeta with the Magic Balls")
							usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] restored planet Vegeta with the Magic Balls.\n")
						if("Arconia")
							spawn Planet_Restore(8)
							view(usr)<<"[usr] wishes to restore Arconia!"
							log_game("[key_name(usr)] has wished to restore Arconia with the Magic Balls")
							logAndAlertAdmins("[key_name(usr)] has wished to restore Arconia with the Magic Balls")
							usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] restored planet Arconia with the Magic Balls.\n")
						if("Ice")
							spawn Planet_Restore(12)
							view(usr)<<"[usr] wishes to restore Ice Planet!"
							log_game("[key_name(usr)] has wished to restore Ice Planet with the Magic Balls")
							alertAdmins("[key_name(usr)] has wished to restore Ice Planet with the Magic Balls")
							usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] restored planet Ice with the Magic Balls.\n")
				if("Restore Galaxy")
					if(!Wishes) return
					spawn if(src)
						if(!Earth) Planet_Restore(1)
						if(!Namek) Planet_Restore(3)
						if(!Vegeta) Planet_Restore(4)
						if(!Arconia) Planet_Restore(8)
						if(!Ice) Planet_Restore(12)
					view(usr)<<"[usr] wishes for the Galaxy to be restored"
					log_game("[key_name(usr)] has wished to restore the Galaxy with the Magic Balls")
					alertAdmins("[key_name(usr)] has wished to restore the Galaxy with the Magic Balls")
					usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] restored the Galaxy with the Magic Balls.\n")
				if("Power For Someone")
					if(!Wishes) return
					var/mob/A=input(usr,"Choose the person you want to give power to") in Players
					A.Off += (0.25*A.OffMod)*A.Off
					A.Def += (0.25*A.DefMod)*A.Def
					A.MaxKi += (0.5*A.KiMod)*A.MaxKi
					A.Base += WishPower
					A.Health = 200
					A.Ki = A.MaxKi*2
					view(usr) << "[usr] wishes to give [A] more power!"
					log_game("[key_name(usr)] has wished to give [key_name(A)] more power with the Magic Balls")
					alertAdmins("[key_name(usr)] has wished to give [key_name(A)] more power with the Magic Balls")
					usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] wished for [A] to have more power.\n")

				if("Immortality")
					if(!Wishes) return
					if(!usr.Immortal)
						usr.Immortal=1
						usr.Regenerate+=0.5
						view(usr)<<"[usr] wishes for immortality!"
						log_game("[key_name(usr)] has wished for immortality")
						alertAdmins("[key_name(usr)] has wished for immortality")
						usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] wished for immortality.\n")

					else
						usr.Immortal=0
						usr.Regenerate-=0.5
						view(usr)<<"[usr] wishes to be mortal!"
						log_game("[key_name(usr)] has wished to be mortal with the Magicballs")
						alertAdmins("[key_name(usr)] has wished to be mortal with the Magicballs")
						usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] wished to be mortal.\n")

				if("Revive")
					if(!Wishes) return
					var/Revives=round(WishPower/500)
					while(Revives)
						var/list/Peoples=new
						for(var/mob/player/A in Players) if(A.Dead) Peoples+=A
						Peoples+="I'm Done Reviving"
						var/mob/B=input("Choose who to revive. You can revive [Revives] more people.") in Peoples
						if(B=="I'm Done Reviving") break
						else
							log_game("[key_name(usr)] has revived [key_name(B)] with the Magic Balls")
							alertAdmins("[key_name(usr)] has revived [key_name(B)] with the Magic Balls")
							usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] revived [key_name(B)] with the Magic Balls.\n")
							B.Revive()
							B.loc=usr.loc
							Revives-=1
		view(src)<<"The Magic Balls scatter randomly across their home world"
		for(var/obj/items/Magic_Ball/A) if(A.Creator==Creator)
			spawn A.Scatter()
			spawn A.Inert()
