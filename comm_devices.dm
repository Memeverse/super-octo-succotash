obj/items
	var/Frequency = 1
	var/detections
	var/saved_data
	Security_Camera
		desc="This is a Security Camera. A frequency can be set, along with a password. When someone is detected near this device, a snap-shot photo is taken and stored \
		inside the camera and sent to any scanner with the same frequency. From there, you can access the Security tab on your scanner and view the images. \
		Further more, you can click each camera and view what it can currently see, so long as you have a scanner set to the same frequency."
		layer=MOB_LAYER+10
		Stealable=1
		icon='tech security systems.dmi'
		icon_state="camera"
		var/display = 1
		Frequency=100
		Savable = 1
		Click()
			if(usr.client.eye==src)
				usr.reset_view()
				return
			if(src.Bolted)
				for(var/obj/items/Scanner/B in usr)
					if(B.Frequency&&B.Frequency==src.Frequency&&B.suffix)
						switch(input(usr, "Do you want to snap your view to this camera or toggle the display on the contacts it has saved?") in list("View Camera", "Toggle Contacts"))
							if("View Camera")
								usr.reset_view(src)
								usr << "Now viewing [src]. Click the camera to reset your view."
								return
							if("Toggle Contacts")
								if(src.display)
									src.display = 0
									usr << "Contacts for this camera have been toggled off."
									return
								else
									src.display = 1
									usr << "Contacts for this camera have been toggled on."
									return
		New()
			src.detections = list()
			spawn(10)
				if(src)
					src.Sweep()
		proc/Sweep()
			if(src.z)if(src.Bolted)
				for(var/mob/M in view(20,src))
					var/Logged = 0
					for(var/obj/Contact/O in src.detections)
						if(O.tag == "[M.name] [M.key]")
							Logged = 1
					if(Logged == 0)
						var/obj/Contact/X = new
						X.suffix = null
						X.name = "Unknown detection"
						if(M.icon)
							var/icon/A=new(M.icon)
							X.icon = A
						for(var/icon/I in M.overlays) if(I.icon)
							var/icon/I2=new(I.icon)
							X.overlays += I2
						X.tag = "[M.name] [M.key]"
						src.detections += X
			if(src.Bolted)
				for(var/mob/player/A in Players)
					for(var/obj/items/Scanner/B in A)
						if(B.Frequency&&B.Frequency==src.Frequency)
							var/list/Haystack = B.detections
							if(!Haystack.Find(src))
								B.detections += src
			spawn(100)
				if(src)
					src.Sweep()
		verb/Set_Password()
			set src in oview(1)
			if(src.password == " ")
				password=input("Choose a password for this device.") as text
				usr << "Password set."
				return
			else
				usr << "This device already has a password set."
				return
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
		verb/Frequency()
			set src in oview(1)
			var/p=input("Input password.") as text
			if(p == src.password)
				Frequency=input("Choose a frequency. It can be text and/or numbers. When someone is detected near the Motion Tracker it will send a notification to this \
				frequency alerting those on the channel that someone is near by.") as text
				usr << "Frequency set for [Frequency]."
				return
			else
				usr << "Wrong password."
				return
	Motion_Detector
		desc="This is a Motion Detector. A frequency can be set, along with a password. When someone is detected near this device, a message is sent to the frequency \
		alerting those on the frequency channel about the intruder. It is able to detect cloaked people also, since the laser motion trackers are disturbed when \
		the light is bent around the cloaker."
		layer=MOB_LAYER+10
		Stealable=1
		icon='tech security systems.dmi'
		icon_state="motion tracker"
		density=1
		Savable = 1
		var/Max=1
		Frequency=100
		var/cd = 0
		New()
			spawn(10)
				if(src)
					src.Scan()
		proc/Scan()
			if(src.cd)
				src.cd -= 1
			if(src.z)if(src.Bolted)if(src.cd == 0)
				for(var/mob/player/M in range(15,src))
					for(var/mob/player/A in Players)
						for(var/obj/items/B in A)
							if(B.Frequency) if(B.Frequency==src.Frequency) if(M != A)
								A<<"<font color=#FFFFFF>(Scanner Channel [src.Frequency])<font color=[A.TextColor]>[src] says, 'Warning! Intruder detected at [M.x],[M.y],[M.z]!'"
								A.saveToLog("| [A.client.address ? (A.client.address) : "IP not found"] | \
								([src.x], [src.y], [src.z]) | [key_name(A)] SCANNER: Warning! Intruder detected at [M.x],[M.y],[M.z]!\n")
								src.cd = 30
			spawn(10)
				if(src)
					src.Scan()
		verb/Bolt()
			set src in oview(1)
			if(x&&y&&z&&!Bolted)
				Bolted=1
				cd = 0
				range(20,src)<<"[usr] bolts the [src] to the ground."
				for(var/mob/player/M in view(src)) if(M.client) M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] bolts [src] to the ground.\n")
				return
			if(Bolted) if(src.Builder == "[key_name(usr)], [usr.client.address]")
				range(20,src)<<"[usr] un-bolts the [src] from the ground."
				Bolted=0
				for(var/mob/player/M in view(src)) if(M.client) M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] un-bolts [src] from the ground.\n")
				return
		verb/Set_Password()
			set src in oview(1)
			if(src.password == " ")
				password=input("Choose a password for this device.") as text
				usr << "Password set."
				return
			else
				usr << "This device already has a password set."
				return
		verb/Frequency()
			set src in oview(1)
			var/p=input("Input password.") as text
			if(p == src.password)
				Frequency=input("Choose a frequency. It can be text and/or numbers. When someone is detected near the Motion Tracker it will send a notification to this \
				frequency alerting those on the channel that someone is near by.") as text
				usr << "Frequency set for [Frequency]."
				return
			else
				usr << "Wrong password."
				return
	Communicator
		icon='Cell Phone.dmi'
		desc="Use this to call somebody who also has a cell phone. Just use Say or Whisper and you can \
		talk to them til the call has ended. You end a call by hitting Use again. Anyone within 1 space \
		of you can hear your conversation and also be heard on the cell phone"
		Stealable=1
		New()
			src.detections = list()
			src.Frequency = "[rand(1,1000)]"
		verb/Transmit(msg as text)
			for(var/mob/player/A in Players)

				for(var/obj/items/Scanner/B in A)
					if(B.suffix&&A.Dead==usr.Dead&&B.Frequency==Frequency)
						A<<"<font color=#FFFFFF>(Scanner Channel [Frequency])<font color=[usr.TextColor]>[usr] says, '[msg]'"
						A.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | \
						([usr.x], [usr.y], [usr.z]) | [key_name(usr)] SCANNER: [msg]\n")

				for(var/obj/items/Communicator/B in A)
					if(A.Dead==usr.Dead&&B.Frequency==Frequency)
						A<<"<font color=#FFFFFF>(Scanner Channel [Frequency])<font color=[usr.TextColor]>[usr] says, '[msg]'"
						A.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | \
						([usr.x], [usr.y], [usr.z]) | [key_name(usr)] SCANNER: [msg]\n")

			for(var/mob/player/C in view(10,usr.loc))
				C<< "<span class=\"say\"><font size=2 color=[usr.TextColor]> <b>[usr.name]</b>: [msg]</span>"


		verb/Frequency()
			Frequency=input("Choose a frequency, it can be anything. It lets you talk to \
							others on the same frequency. Default is 1") as text
			if(Frequency == "Communication Matrix") if(usr.AS_Droid == 0)
				usr << "This Frequency seems to be entirely blocking off your access."
				Frequency = ""


	Scanner
		icon='Item - Sun Glassess.dmi'
		var/Scan=1
		var/Range=5
		var/Detects
		var/CanDetect
		var/Implant = 0
		Stealable=1
		desc="Equipping this will open a tab that allows you to see the battle power of all people \
		within the scanner's range and detection capabilities."
		New()
			src.detections = list()
			src.Frequency = "[rand(1,1000)]"
		Click()
			if(src.Implant)
				usr << "You can't remove that, it's part of you!"
				return
			if(locate(src) in usr)
				if(!suffix)
					usr<<"You put on the [src]."
					usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | \
					([usr.x], [usr.y], [usr.z]) | [key_name(usr)] equips [src].\n")
					usr.overlays+=icon
					suffix="*Equipped*"
				else
					usr<<"You take off the [src]."
					usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | \
					([usr.x], [usr.y], [usr.z]) | [key_name(usr)] removes [src].\n")
					usr.overlays-=icon
					suffix=null

		verb
			Transmit(msg as text)
				for(var/mob/player/A in Players)

					for(var/obj/items/Scanner/B in A)

						if(B.suffix&&A.Dead==usr.Dead&&B.Frequency==Frequency)
							A<<"<font color=#FFFFFF>(Scanner Channel [Frequency])<font color=[usr.TextColor]>[usr] says, '[msg]'"
							A.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | \
							([usr.x], [usr.y], [usr.z]) | [key_name(usr)] SCANNER: [msg]\n")

					for(var/obj/items/Communicator/B in A)

						if(A.Dead==usr.Dead&&B.Frequency==Frequency)
							A<<"<font color=#FFFFFF>(Scanner Channel [Frequency])<font color=[usr.TextColor]>[usr] says, \'[msg]'"
							A.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | \
							([usr.x], [usr.y], [usr.z]) | [key_name(usr)] SCANNER: [msg]\n")

				for(var/mob/player/C in view(10,usr.loc))
					C<< "<span class=\"say\"><font size=2 color=[usr.TextColor]> <b>[usr.name]</b>: [msg]</span>"


			Frequency()
				Frequency=input("Choose a frequency, it can be anything. It lets you talk to \
								others on the same frequency. Default is 1") as text
				if(Frequency == "Communication Matrix") if(usr.AS_Droid == 0)
					usr << "This Frequency seems to be entirely blocking off your access."
					Frequency = ""

			Detect()
				if(!CanDetect)
					usr<<"This feature is not installed. It can only be installed by a very intelligent person."
					return
				if(Detects) switch(input("Are you sure you want to reset detecting?") in list("No","Yes"))
					if("Yes") Detects=null
					if("No") return
				var/list/A=new
				for(var/obj/B in oview(1,usr))
					A+=B
					if(B.type == /obj/items/Magic_Ball)
						A-=B
					if(B.type == /obj/items/Phylactery)
						A-=B
				if(!A)
					usr<<"You are not near an object to set the scanner to."
					return
				A+="Cancel"
				var/obj/B=input("Set to detect what type of object?") in A
				if(B=="Cancel") return
				Detects=B.type
				usr<<"Set to detect [B]"
				usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] sets their scanner to detect [B].\n")

			Upgrade()
				set src in oview(1)
				if(usr.Int_Level<Tech)
					usr<<"This is too advanced for you to mess with."
					return
				var/obj/Resources/A
				for(var/obj/Resources/B in usr) A=B
				var/Cost=20000/usr.Add
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
				for(var/mob/player/M in view(src)) if(M.client) M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades the [src] to level [Upgrade].\n")
				for(var/mob/player/M in view(usr))
					if(!M.client) return
					M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] \n")
				A.Value-=Cost
				Tech=Upgrade
				Scan=0.5*Upgrade*0.001*rand(990,1010)
				Range=5*Upgrade*0.01*rand(80,120)
				if(Upgrade>=60) CanDetect=1
				desc="Level [Tech] [src] ([Commas((Scan**3)*20)] BP)"

			/*Upgrade()
				set src in oview(1)
				var/obj/Resources/A
				for(var/obj/Resources/B in usr) A=B
				var/list/Choices=new
				if(A.Value>=1000*Tech/usr.Add) Choices.Add("Scan Limit ([1000*Tech/usr.Add])")
				if(A.Value>=1000*Tech/usr.Add&&Range<1000) Choices.Add("Scan Range ([1000*Tech/usr.Add])")
				if(A.Value>=100000/usr.Add&&!CanDetect&&usr.Int_Level>=25) Choices.Add("Item Detection ([100000/usr.Add])")
				if(!Choices)
					usr<<"You do not have enough resources"
					return
				var/Choice=input("Change what?") in Choices
				if(Choice=="Scan Limit ([1000*Tech/usr.Add])")
					if(A.Value<1000*Tech/usr.Add) return
					A.Value-=1000*Tech/usr.Add
					Scan++
				if(Choice=="Scan Range ([1000*Tech/usr.Add])")
					if(A.Value<1000*Tech/usr.Add) return
					A.Value-=1000*Tech/usr.Add
					Range*=2
				if(Choice=="Item Detection ([100000/usr.Add])")
					if(A.Value<100000/usr.Add) return
					A.Value-=100000/usr.Add
					CanDetect=1
				Tech++
				desc=null
				desc+="<br>Scan Limit: [Scan] ([Commas((Scan**3)*1000)] bp)"
				desc+="<br>Scan Range: [Range]"
				if(CanDetect) desc+="<br>Object Detection Installed"*/
