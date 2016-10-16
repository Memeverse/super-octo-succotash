/*
 * _techmain.dm
 *
 * populate a global list at the start of the world with every dummy tech object we have.
 * these dummy objects will create the actual object once clicked.
*/

#ifndef DRILLS
#warn The drills.dm file is NOT included. This update will BREAK a running server!
#endif

#define TECH_GRID "grid_Tech"
#define MAGIC_GRID "grid_Magic"
#define TECHWINDOW "windowTech"

var/list/globTechlist = new
var/list/globMagiclist = new


// Global resource replenish proc
proc/Resources()
	var/Y = Year/50
	Y += 1
	if(Y <= 1)
		Y = 1
	var/Extra = 3000000 * Y
	var/Double = 2000000 * Y
	var/Normal = 1000000 * Y
	for(var/area/A in world)
		if(A.type!=/area&&A.type!=/area/Inside)
			if(A.type==/area/Changeling) A.Value+=Extra
			if(A.type==/area/Namek_Underground) A.Value+=Double
			else A.Value+=Normal
proc/Mana()
	var/Y = Year/50
	Y+= 1
	if(Y <= 1)
		Y = 1
	var/Extra = 3000000 * Y
	var/Double = 2000000 * Y
	var/Normal = 1000000 * Y
	if(round(Year,0.1)==round(Year,10))
		Extra = 6000000 * Y
		Double = 4000000 * Y
		Normal = 2000000 * Y
	for(var/area/A in world)
		if(A.type!=/area&&A.type!=/area/Inside)
			if(A.type==/area/Checkpoint) A.Value_Mana+=Extra
			if(A.type==/area/Hell) A.Value_Mana+=Double
			if(A.type==/area/Heaven) A.Value_Mana+=Double
			if(A.type==/area/Earth) A.Value_Mana+=Double
			if(A.type==/area/Arconia) A.Value_Mana+=Double
			if(A.type==/area/Namek) A.Value_Mana+=Double
			else A.Value_Mana+=Normal

proc/fill_techlist()

/*
 * fill_techlist()
 *
 * a simple for loop that adds all dummy objects to the global tech list
 * sleep is disabled because the loop is rather small, so there's no need to force it to the background.
*/

	for(var/A in childtypes(/obj/Technology))
		var/obj/Technology/B = new A
		if(B.Cost == 0) continue // If it has no cost, then the item is disabled. So skip.
		globTechlist+=B
	for(var/A in childtypes(/obj/Magic))
		var/obj/Magic/B = new A
		if(B.Cost == 0) continue // If it has no cost, then the item is disabled. So skip.
		globMagiclist+=B
		//sleep(0)

mob/proc
	refreshMagic()
		winset(src, MAGIC_GRID, "cells=0x0")

		var/row    = 0
		var/column = 0

		for(var/obj/Mana/A in src)
			row++
			src << output(A, "[MAGIC_GRID]:1,[row]")
			src << output("[Commas(A.Value)]", "[MAGIC_GRID]:2,[row]")

		for(var/obj/Magic/_mag in globMagiclist)

			if(src.Magic_Level >= _mag.Level)

				row++
				column = 1
				src << output(_mag, "[MAGIC_GRID]:[column],[row]")

				column++
				src << output("[Commas(round(initial(_mag.Cost)/src.Magic_Potential))]", "[MAGIC_GRID]:[column],[row]")
	refreshTech()
		winset(src, TECH_GRID, "cells=0x0")

		var/row    = 0
		var/column = 0

		for(var/obj/Resources/A in src)
			row++
			src << output(A, "[TECH_GRID]:1,[row]")
			src << output("[Commas(A.Value)]", "[TECH_GRID]:2,[row]")

		for(var/obj/Technology/_tech in globTechlist)

			if(src.Int_Level >= _tech.Level)

				row++
				column = 1
				src << output(_tech, "[TECH_GRID]:[column],[row]")

				column++
				src << output("[Commas(round(initial(_tech.Cost)/src.Add))]", "[TECH_GRID]:[column],[row]")