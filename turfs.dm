/*

######### Turf Saving/Loading #########

*/

proc/Save_Turfs()
	if(global.CanSave)
		var/Amount=0
		var/E=1
		var/savefile/F=new("Data/Maps/Map[E]")
		world << "Creating Map[E].sav"
		var/list/Types=new
		var/list/Healths=new
		var/list/Levels=new
		var/list/Builders=new
		var/list/Xs=new
		var/list/Ys=new
		var/list/Zs=new
		var/list/FlyOver=new
		for(var/turf/A in Turfs)
			Types+=A.type
			Healths+="[num2text(round(A.Health),100)]"
			Levels+="[num2text(A.Level,100)]"
			Builders+=A.Builder
			Xs+=A.x
			Ys+=A.y
			Zs+=A.z
			FlyOver+=A.FlyOverAble
			Amount++
			if(Amount >= 20000)
				F["Types"]<<Types
				F["Healths"]<<Healths
				F["Levels"]<<Levels
				F["Builders"]<<Builders
				F["Xs"]<<Xs
				F["Ys"]<<Ys
				F["Zs"]<<Zs
				F["FlyOver"]<<FlyOver
				E ++
				F=new("Data/Maps/Map[E]")
				world << "Creating Map[E].sav"
				Types=new
				Healths=new
				Levels=new
				Builders=new
				Xs=new
				Ys=new
				Zs=new
				FlyOver=new
				Amount = 0

			//sleep(1) // Allow a context switch!

		if(Amount <= 19999)
			F["Types"]<<Types
			F["Healths"]<<Healths
			F["Levels"]<<Levels
			F["Builders"]<<Builders
			F["Xs"]<<Xs
			F["Ys"]<<Ys
			F["Zs"]<<Zs
			F["FlyOver"]<<FlyOver

		//if(global.startRuin) F["success"] << global.startRuin
		world<<"Maps Saved ([Amount])"

proc/Load_Turfs()
	set background = 1
	var/Amount=0
	var/DebugAmount= 0
	var/E=1
	//if(fexists("Map[E]"))
	load
	if(E>1)
		world << "Successfully jumped to next file."

	if(fexists("Data/Maps/Map[E]"))
		world << "File found. (Map File [E])"

	else
		world << "No more files found. Done loading turfs."
		goto end

	var/savefile/F=new("Data/Maps/Map[E]")
	//if(length(F["success"])) global.startRuin = 1

	sleep(1)
	var/list/Types=F["Types"]
	diary << "Types loaded."
	var/list/Healths=F["Healths"]
	diary << "Healths loaded."
	var/list/Levels=F["Levels"]
	diary << "Levels loaded."
	var/list/Builders=F["Builders"]
	diary << "Builders loaded."
	var/list/Xs=F["Xs"]
	diary << "Xs loaded."
	var/list/Ys=F["Ys"]
	diary << "Ys loaded."
	var/list/Zs=F["Zs"]
	diary << "Zs loaded."
	var/list/FlyOver=F["FlyOver"]
	diary << "Fly Over loaded."
	Amount = 0
	sleep(1)

	world << "Done loading Map File [E]"
	sleep(1)
	for(var/A in Types)
		Amount++
		DebugAmount ++
		var/turf/T=new A(locate(text2num(list2params(Xs.Copy(Amount,Amount+1))),text2num(list2params(Ys.Copy(Amount,Amount+1))),text2num(list2params(Zs.Copy(Amount,Amount+1)))))
		T.Health=text2num(list2params(Healths.Copy(Amount,Amount+1)))
		T.Level=text2num(list2params(Levels.Copy(Amount,Amount+1)))
		T.Builder=list2params(Builders.Copy(Amount,Amount+1))
		T.FlyOverAble=text2num(list2params(FlyOver.Copy(Amount,Amount+1)))
		Turfs+=T

		if(T.Builder)
			new/area/Inside(T)

		for(var/obj/Door/B in T)
			if(!B.Builder)
				del(B)
/*
		for(var/obj/Props/Edges/B in T)
			if(!B.Builder)
				del(B)
		for(var/obj/Props/Surf/B in T)
			if(!B.Builder)
				del(B)
		for(var/obj/Props/Trees/B in T)
			if(!B.Builder)
				del(B)
*/
		for(var/obj/Props/B in T)
			if(!B.Builder)
				del(B)


		if(Amount >= 20000)
			diary << "End of Map File [E] reached. Preparing to load next file."
			sleep(1)
			break

	if(Amount >= 20000)
		diary << "Moving to Map File [E+1]"
		E ++
		goto load

	end
	for(var/obj/Door/X in world)
		var/turf/T = X.loc
		var/Doors = 0
		for(var/obj/Door/x in T)
			Doors += 1
			if(Doors > 1)
				del(x)
	for(var/obj/Drill/D in world)
		var/turf/T = D.loc
		var/Drills = 0
		for(var/obj/Drill/d in T)
			Drills += 1
			if(Drills > 1)
				del(d)
	for(var/obj/Mana_Pylon/P in world)
		var/turf/T = P.loc
		var/Pylons = 0
		for(var/obj/Mana_Pylon/p in T)
			Pylons += 1
			if(Pylons > 1)
				del(p)
	world << "All Maps Loaded ([DebugAmount])"
	world << "Allowing normal players to log in again."

	global.MapsLoaded=1
	global.CanSave = 1





/*

OLD

*/


/*turf/Write(savefile/F)
	var/list/Contents=new
	for(var/atom/A in contents) if(ismob(A)|isobj(A))
		A.saved_x=x
		A.saved_y=y
		A.saved_z=z
		Contents+=A
	contents=null
	..()
	for(var/mob/A in Contents) A.loc=locate(A.saved_x,A.saved_y,A.saved_z)
	for(var/obj/A in Contents) A.loc=locate(A.saved_x,A.saved_y,A.saved_z)
proc/MapSave()
	if(fexists("MapSave")) fcopy("MapSave","MapSave Backup")
	var/amount=0
	var/savefile/F=new("MapSave")
	for(var/turf/A in Turfs)
		amount++
		if(!A.z) Turfs-=A
	for(var/mob/A in Turfs) Turfs-=A
	world<<"Map Saved ([amount])"
	F<<Turfs
	fdel("MapSave Backup")
proc/MapLoad()
	if(fexists("MapSave Backup"))
		fcopy("MapSave Backup","MapSave")
		fdel("MapSave Backup")
	if(fexists("MapSave"))
		var/amount=0
		var/savefile/F=new("MapSave")
		F>>Turfs
		for(var/turf/A in Turfs)
			amount++
			new/area/Inside(locate(A.x,A.y,A.z))
			for(var/obj/Props/Edges/B in A) if(!B.Builder) del(B)
			for(var/obj/Props/Surf/B in A) if(!B.Builder) del(B)
			for(var/obj/Props/Trees/B in A) if(!B.Builder) del(B)
			for(var/obj/Turfs/B in A) if(!B.Builder) del(B)
		world<<"<font size=1>Map Loaded ([amount])"*/
