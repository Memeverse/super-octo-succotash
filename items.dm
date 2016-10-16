/*

######### Item Saving/Loading #########

*/

proc/add_CreatedItems(var/item)

	if(!CreatedItems) CreatedItems=new
	CreatedItems+=item

proc/rem_CreatedItems(var/item)

	CreatedItems-=item
	if(!CreatedItems|!CreatedItems.len) CreatedItems=null


mob/proc/dropRares()
	for(var/obj/items/Magic_Ball/A in src)	//Remove dragonballs from their person
		A.loc=loc
		Save()

var/list/worldObjectList = new

proc/find_savableObjects()
	for(var/mob/player/M)
		M.dropRares()

	for(var/obj/_object in world) // Find all objects in the world
		if(!_object.z) continue

		if(_object in global.worldObjectList)
			if(!_object.z)
				global.worldObjectList -= _object
				del(_object)
			else continue // If it's already in the world object list, skip it.

		if(_object.Savable==1) global.worldObjectList+=_object // If it's NOT, and we want it saved, add it to the world object list.

		if(istype(_object,/obj/Drill)) // add drills to the global list.
			if(_object in global.DrillList) continue
			global.DrillList += _object
		if(istype(_object,/obj/Mana_Pylon)) // add pylons to the global list.
			if(_object in global.DrillList) continue
			global.DrillList += _object

		sleep(-1)

proc/SaveItems()
	if(global.CanSave)
		world<<"Saving items..."
		var/foundobjects=0
		var/savedobjs = list()
		var/E = 1
		var/savefile/F=new("Data/ItemSaves/ItemSave[E].bdb")
		var/list/L=new

		//if(global.startRuin) F["success"] << global.startRuin

		for(var/obj/A in global.worldObjectList)
			if(A.Savable||istype(A,/obj/TrainingEq))
				foundobjects ++
				A.savedX = A.x
				A.savedY = A.y
				A.savedZ = A.z
				A.Save_Loc = A.loc
				A.loc = null
				L += A
				savedobjs += A

			if(foundobjects % 3000 == 0)
				F["SavedItems"] << L
				E ++
				F=new("Data/ItemSaves/ItemSave[E].bdb")
				L=new

			sleep(-1)

		for(var/mob/A in global.worldObjectList)
			if(istype(A,/mob/Drone))
				foundobjects ++
				A.savedX=A.x
				A.savedY=A.y
				A.savedZ=A.z
				A.Save_Loc = A.loc
				A.loc = null
				L+=A
				savedobjs += A

			if(foundobjects % 3000 == 0)
				F["SavedItems"] << L
				E ++
				F=new("Data/ItemSaves/ItemSave[E].bdb")
				L=new

			sleep(-1)

		if(foundobjects % 3000 != 0)
			F["SavedItems"] << L

		for(var/obj/A in savedobjs)
			if(A.savedX) if(A.savedY) if(A.savedZ)
				A.loc = locate(A.savedX,A.savedY,A.savedZ)
			if(A.Save_Loc)
				A.loc = A.Save_Loc
		for(var/mob/A in savedobjs)
			if(A.savedX) if(A.savedY) if(A.savedZ)
				A.loc = locate(A.savedX,A.savedY,A.savedZ)
		world<<"<span class=\"announce\">Items saved ([foundobjects] items)</span>"
proc/LoadItems()
	if(global.ItemsLoaded == 0)
		if(fexists("Data/ItemSaves/ItemSave1.bdb"))
			spawn(0) LoadItemFiles()

		spawn(1) SpawnMaterial()
		global.ItemsLoaded=1

		spawn(1) loopThroughDrills()

proc/LoadItemFiles(E=1, amount=0)

	if(fexists("Data/ItemSaves/ItemSave[E].bdb")) // Check if the file exists
		var/savefile/F=new("Data/ItemSaves/ItemSave[E].bdb") // Load it
		//if(length(F["success"])) global.startRuin = 1

		var/list/L=F["SavedItems"]

		for(var/obj/Props/B in L)
			if(B.Builder) continue
			del(B)

		for(var/obj/Door/B in L)
			if(B.Builder) continue
			del(B)


		for(var/obj/A in L) // Loop through all objects that could be in the file
			amount++

			if(A.savedX) if(A.savedY) if(A.savedZ)
				A.loc=locate(A.savedX,A.savedY,A.savedZ)

//			var/turf/T = locate(A.savedX,A.savedY,A.savedZ)

			global.worldObjectList+=A
			sleep(-1)

		for(var/mob/A in L)
			amount++
			if(A.savedX) if(A.savedY) if(A.savedZ)
				A.loc=locate(A.savedX,A.savedY,A.savedZ)
			global.worldObjectList+=A
			sleep(-1)

		E++

		.(E,amount) // Recursive call (basically, move onto the next file)

	else
		world<<"<span class=\"announce\">Items Loaded ([amount]).</span>"


proc/SpawnMaterial()

/* Find the androidship */
	var/count=0
	for(var/obj/AndroidShips/A in world)
		count++
	if(count>=2)
		SpawnAndroidShip()
		errors << "Duplicate androidship removed."
		world << "<span class=\"announce\">Duplicate androidship removed.</span>"
	if(count<=0)
		SpawnAndroidShip()
		errors << "No Android Ship found, one has been spawned."
		world << "<span class=\"announce\">No Android Ship found, one has been spawned.</span>"