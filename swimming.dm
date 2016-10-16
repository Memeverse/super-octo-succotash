#define SWIMMING

mob/proc
	RemoveWaterOverlay()
		var/list/icon_states=list("1","2","3","4","5","6","7","8","9","10","11","12","waterfall")
		for(var/x in icon_states)
			src.overlays-=image('WaterOverlay.dmi',"[x]")

	goSwimming(var/watertype = "Water")
		var/swimOverlay
		var/mob/grabbedPlayer
		if(src.GrabbedMob && ismob(src.GrabbedMob)&& src.isGrabbing==1) // If the player is holding someone ..
			grabbedPlayer=src.GrabbedMob
			if(grabbedPlayer.client) // If it has a client, it must be a player.
				if(grabbedPlayer.icon_state!="Flight") // If this player is NOT flying
					spawn(1) grabbedPlayer.goSwimming(watertype) // Then they're being dragged (face first) across the ocean floor.

		switch(watertype)
			if("Water")
				swimOverlay = "6"
			if("WaterReal")
				swimOverlay = "4"
			if("Water5")
				swimOverlay = "5"
			if("WaterFall")
				swimOverlay = "waterfall"
			if("Water3")
				swimOverlay = "3"
			if("WaterFast")
				swimOverlay = "4" // Need a custom one for this actually
			if("Water8")
				swimOverlay = "8"
			if("Water1")
				swimOverlay = "1"
			if("Water11")
				swimOverlay = "11"
			if("Water7")
				swimOverlay = "7"
			if("Water2")
				swimOverlay = "2"
			if("Water12")
				swimOverlay = "12"
			if("Water9")
				swimOverlay = "9"
			if("Water10")
				swimOverlay = "10"

		src.overlays += image('WaterOverlay.dmi', "[swimOverlay]")
		src.isSwimming=1
		spawn(1) src.checkSwimming()


	stopSwimming()
		src.RemoveWaterOverlay()
		src.isSwimming=0

	checkSwimming() // This is a recursive proc. Checks if they're swimming, drains energy, adds skill, repeat
		var/rolldice = roll("3d6") // I just felt like using dice

		if(!istype(src.loc,/turf/Terrain/Water)) // If the terrain they're on is NOT water
			src.isSwimming = 0 // Then they're not swimming. (this proc takes care of the rest)

		if(src.isSwimming == 1)

			if(src.icon_state!="KO" && src.icon_state!="Flight")
				var/swimdrain = /*src.*/MaxKi/(/*src.*/swimSkill/src.KiMod)

				if(swimdrain > (src.MaxKi/2) ) // If the drain is above 50% of the maxKi of a user.
					swimdrain = src.MaxKi/2 // Then put it back to 50%
				if(src.MaxKi < 55 && swimdrain > 5) // If they have less than 55 energy and the drain is more than 5, put it back to five.
					swimdrain = 2 // It's so players have a small 'grace period' before the salty deathtrap kicks in hard.
				if(istype(src.loc,/turf/Terrain/Water/Water7)&&Race=="Demon"||!istype(src.loc,/turf/Terrain/Water/Water7)&&Race=="Changeling")  //&&src.Race=="Demon"||!istype(src.loc,/turf/Terrain/Water/Water7)&&src.Race=="Aquatian")
					swimdrain = 0.02
//Above if is src.race, not race.   Src removed due to null.var bug.
				if(src.Ki > swimdrain )
					src.Ki -= swimdrain


					if(src.swimSkill < 2000) // Theres no point giving swim skill above 2k. The drain is already nonexistant.
						if(rolldice>16) src.swimSkill += 10
						else if(rolldice>10) src.swimSkill += 4

					src.MaxKi+=0.001*src.KiMod // Give them a bit of energy for swimming.

					if(istype(src.loc,/turf/Terrain/Water/Water7)) // If it's lava they're in
						if(/*src.*/Race != "Demon" || /*src.*/BP < 3000 || /*src.*/End < 5000) // Lava wont hurt you if Demon/3K cur BP/5k Endurance
							src.swimHealthDown(10) // Lava does more damage than  just drowning, but only by a little.

				else
					//if(!istype(src.loc,/turf/Terrain/Water/Water7)&&!src.Race=="Demon")
					//	return
					//if(!istype(src.loc,/turf/Terrain/Water/Water7)&&src.Race=="Aquatian")
					//	return

				//	else
					KO("by swimming too long! They'll drown unless saved!")
					//src.Health=100

			else
				if(src.icon_state=="Flight")
					src.stopSwimming()
					return

				if(/*src.*/Race == "Changeling" || /*src.*/Race == "Android" || /*src.*/Lungs >= 1 || istype(src.loc,/turf/Terrain/Water/Water7)&&/*src.*/Race=="Demon") return // They cant drown.    Check istype for demons, can still drown.

				//src.swimHealthDown()

			spawn(15) .() // Call itself again after 1.5 seconds

		else
			src.stopSwimming()

	swimHealthDown(var/max=5)
	//	if (src.Race == "Aquatian") return
		if (istype(src.loc,/turf/Terrain/Water/Water7)&&Race == "Demon") return
		if(prob(30)) src.Life -= rand(1,max) // There's a 30% chance drowning makes them lose health
		if(src.Life <=50)
			if(prob(50))
				src.stopSwimming()
				src.Death("drowning!")