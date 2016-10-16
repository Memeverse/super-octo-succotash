/*
Categories:

Roofs	(/turf/Upgradeable/Roofs)

Walls	(/turf/Upgradeable/Walls)

Doors 	(/obj/Door)

Terrain (thing which change the terrain)
	> Grass			(/turf/Terrain/Grass)
	> Ground		(/turf/Terrain/Ground)
	> Sky			(/turf/Terrain/Sky)
	> Stairs		(/turf/Terrain/Stairs)
	> Tiles			(/turf/Terrain/Tiles)
	> Water			(/turf/Terrain/Water)
	> Misc			(/turf/Terrain/Misc)

Props (things which decorate)
	> Chairs		(/obj/Props/Chairs)
	> Tables		(/obj/Props/Tables)
	> Heatsources	(/obj/Props/Heatsources)
	> Signs			(/obj/Props/Signs)

	> Rocks			(/obj/Props/Rocks)
	> Edges			(/obj/Props/Edges)
	> Surf			(/obj/Props/Surf)

	> Bushes 		(/obj/Props/Bushes)
	> Plants		(/obj/Props/Plants)
	> Trees			(/obj/Props/Trees)

	> Misc			(/obj/Props/Misc)
*/


/*

######### Vars #########

*/

turf/var/FlyOverAble=1
atom/var/Buildable=1

var/list/Turfs = new // List of all user-built turfs.
var/list/CreatedItems
var/Wall_Strength=50


obj/Build
	var/Creates


/*
The Build_Lay proc is responsible for placing the turfs at the player's current location.
*/


proc/Build_Lay(obj/Build/O,mob/P) if(P.icon_state!="KO" && !P.inertia_dir) //Type to build, player who is building it, location to put it, can't be floundering through space

	//debuglog << "[__FILE__]:[__LINE__] || src: [src ? src : "null"] usr: [usr ? usr : "null"] build_lay()"

	var/atom/D=P
	if(P.S) D=P.S
	for(var/obj/Controls/N in view(1,locate(D.x,D.y,D.z)))
		P<<"You cannot build this close to ship controls"
		return
	for(var/obj/Airlock/N in view(1,locate(D.x,D.y,D.z)))
		P<<"You cannot build this close to an airlock!"
		return
	for(var/turf/Special/Teleporter/N in view(1,locate(D.x,D.y,D.z)))
		P<<"You cannot build this close to entrances."
		return
	for(var/obj/Warper/W in view(1,locate(D.x,D.y,D.z)))
		P<<"You cannot build this close to warpers."
		return
	for(var/area/portal/W in view(4,locate(D.x,D.y,D.z)))
		P<<"You cannot build this close to the map edge."
		return
	for(var/area/half_portal/W in view(4,locate(D.x,D.y,D.z)))
		P<<"You cannot build this close to the map edge."
	for(var/turf/Other/Stars/S in view(1,locate(D.x,D.y,D.z)))
		P<<"You cannot build in deep space."
		return
	if(P.z == SPACE_Z_LEVEL)
		if((P.x <= 3) || (P.x >= (world.maxx-3)) || (P.y <= 3) || (P.y >= (world.maxy-3)))
			P << "You cannot build this close to the edge of space."
			return
	var/atom/C=new O.Creates(locate(D.x,D.y,D.z))
	C.Builder=P.ckey

	if(isobj(C))
		C:Spawn_Timer=0
		var/Turf_Objects=0

		for(var/obj/K in get_turf(P))
			if(!(locate(K) in P))
				Turf_Objects++
			if(Turf_Objects>4)
				P<<"Nothing more can be placed here."
				del(C)
				return
			else
				global.worldObjectList+=C
				C.Savable=1
				//return

		//if(istype(C,/obj/Door))
			//C:Grabbable=0
			//var/New_Password=input(P,"Enter a password or leave blank") as text
			//if(!C) return
			//C.Password=New_Password

		if(istype(C,/obj/Props/Sign))
			C.desc=input(P,"What do you want to write on the sign?") as text

	else
		C.Savable=0
		new/area/Inside(locate(P.x,P.y,P.z))
		//for(var/obj/Props/Edges/E in C) del(E)
		//for(var/obj/Props/Surf/E in C) del(E)
		//for(var/obj/Props/Trees/E in C) del(E)
		//for(var/obj/Turfs/E in C) del(E)
		for(var/obj/Props/E in C) del(E)
		Turfs+=C
mob
	verb
		Roofs()
			usr.BuildTab = "Roofs"
			usr.BuildOpen = 0
			usr.OpenBuild()
		Walls()
			usr.BuildTab = "Walls"
			usr.BuildOpen = 0
			usr.OpenBuild()
		Doors()
			usr.BuildTab = "Doors"
			usr.BuildOpen = 0
			usr.OpenBuild()
		Grass()
			usr.BuildTab = "Grass"
			usr.BuildOpen = 0
			usr.OpenBuild()
		Ground()
			usr.BuildTab = "Ground"
			usr.BuildOpen = 0
			usr.OpenBuild()
		Sky()
			usr.BuildTab = "Sky"
			usr.BuildOpen = 0
			usr.OpenBuild()
		Stairs()
			usr.BuildTab = "Stairs"
			usr.BuildOpen = 0
			usr.OpenBuild()
		Tiles()
			usr.BuildTab = "Tiles"
			usr.BuildOpen = 0
			usr.OpenBuild()
		Water()
			usr.BuildTab = "Water"
			usr.BuildOpen = 0
			usr.OpenBuild()
		TerrainMisc()
			usr.BuildTab = "Terrain Misc"
			usr.BuildOpen = 0
			usr.OpenBuild()
		Chairs()
			usr.BuildTab = "Chairs"
			usr.BuildOpen = 0
			usr.OpenBuild()
		Tables()
			usr.BuildTab = "Tables"
			usr.BuildOpen = 0
			usr.OpenBuild()
		Heat()
			usr.BuildTab = "Heat"
			usr.BuildOpen = 0
			usr.OpenBuild()
		Signs()
			usr.BuildTab = "Signs"
			usr.BuildOpen = 0
			usr.OpenBuild()
		Rocks()
			usr.BuildTab = "Rocks"
			usr.BuildOpen = 0
			usr.OpenBuild()
		Edges()
			usr.BuildTab = "Edges"
			usr.BuildOpen = 0
			usr.OpenBuild()
		Surf()
			usr.BuildTab = "Surf"
			usr.BuildOpen = 0
			usr.OpenBuild()
		Bushes()
			usr.BuildTab = "Bushes"
			usr.BuildOpen = 0
			usr.OpenBuild()
		Plants()
			usr.BuildTab = "Plants"
			usr.BuildOpen = 0
			usr.OpenBuild()
		Trees()
			usr.BuildTab = "Trees"
			usr.BuildOpen = 0
			usr.OpenBuild()
		Misc()
			usr.BuildTab = "Misc"
			usr.BuildOpen = 0
			usr.OpenBuild()
		OpenBuild()
			set name = ".OpenBuild"
			if(usr.BuildOpen == 0)
				usr.BuildOpen = 1
				winshow(usr,"new_build",1)
				var/I = 1
				winset(usr, "new_build.new_build_grid", "cells=0x0")
				usr << output(null, "new_build.new_build_grid")
				if(usr.BuildTab == "Roofs")
					for(var/atom/a in global.buildRoofs)
						I += 1
						winset(usr, "new_build.new_build_grid", "cells=1x[I]")
						winset(usr, "new_build.new_build_grid", "current-cell=1,[I]")
						usr << output(a, "new_build.new_build_grid")
				if(usr.BuildTab == "Walls")
					for(var/atom/a in global.buildWalls)
						I += 1
						winset(usr, "new_build.new_build_grid", "cells=1x[I]")
						winset(usr, "new_build.new_build_grid", "current-cell=1,[I]")
						usr << output(a, "new_build.new_build_grid")
				if(usr.BuildTab == "Doors")
					for(var/atom/a in global.buildDoors)
						I += 1
						winset(usr, "new_build.new_build_grid", "cells=1x[I]")
						winset(usr, "new_build.new_build_grid", "current-cell=1,[I]")
						usr << output(a, "new_build.new_build_grid")
				if(usr.BuildTab == "Grass")
					for(var/atom/a in global.buildGrass)
						I += 1
						winset(usr, "new_build.new_build_grid", "cells=1x[I]")
						winset(usr, "new_build.new_build_grid", "current-cell=1,[I]")
						usr << output(a, "new_build.new_build_grid")
				if(usr.BuildTab == "Ground")
					for(var/atom/a in global.buildGround)
						I += 1
						winset(usr, "new_build.new_build_grid", "cells=1x[I]")
						winset(usr, "new_build.new_build_grid", "current-cell=1,[I]")
						usr << output(a, "new_build.new_build_grid")
				if(usr.BuildTab == "Sky")
					for(var/atom/a in global.buildSky)
						I += 1
						winset(usr, "new_build.new_build_grid", "cells=1x[I]")
						winset(usr, "new_build.new_build_grid", "current-cell=1,[I]")
						usr << output(a, "new_build.new_build_grid")
				if(usr.BuildTab == "Stairs")
					for(var/atom/a in global.buildStairs)
						I += 1
						winset(usr, "new_build.new_build_grid", "cells=1x[I]")
						winset(usr, "new_build.new_build_grid", "current-cell=1,[I]")
						usr << output(a, "new_build.new_build_grid")
				if(usr.BuildTab == "Tiles")
					for(var/atom/a in global.buildTiles)
						I += 1
						winset(usr, "new_build.new_build_grid", "cells=1x[I]")
						winset(usr, "new_build.new_build_grid", "current-cell=1,[I]")
						usr << output(a, "new_build.new_build_grid")
				if(usr.BuildTab == "Water")
					for(var/atom/a in global.buildWater)
						I += 1
						winset(usr, "new_build.new_build_grid", "cells=1x[I]")
						winset(usr, "new_build.new_build_grid", "current-cell=1,[I]")
						usr << output(a, "new_build.new_build_grid")
				if(usr.BuildTab == "Terrain Misc")
					for(var/atom/a in global.terrainMisc)
						I += 1
						winset(usr, "new_build.new_build_grid", "cells=1x[I]")
						winset(usr, "new_build.new_build_grid", "current-cell=1,[I]")
						usr << output(a, "new_build.new_build_grid")
				if(usr.BuildTab == "Chairs")
					for(var/atom/a in global.buildChairs)
						I += 1
						winset(usr, "new_build.new_build_grid", "cells=1x[I]")
						winset(usr, "new_build.new_build_grid", "current-cell=1,[I]")
						usr << output(a, "new_build.new_build_grid")
				if(usr.BuildTab == "Tables")
					for(var/atom/a in global.buildTables)
						I += 1
						winset(usr, "new_build.new_build_grid", "cells=1x[I]")
						winset(usr, "new_build.new_build_grid", "current-cell=1,[I]")
						usr << output(a, "new_build.new_build_grid")
				if(usr.BuildTab == "Heat")
					for(var/atom/a in global.buildHeatsources)
						I += 1
						winset(usr, "new_build.new_build_grid", "cells=1x[I]")
						winset(usr, "new_build.new_build_grid", "current-cell=1,[I]")
						usr << output(a, "new_build.new_build_grid")
				if(usr.BuildTab == "Signs")
					for(var/atom/a in global.buildSigns)
						I += 1
						winset(usr, "new_build.new_build_grid", "cells=1x[I]")
						winset(usr, "new_build.new_build_grid", "current-cell=1,[I]")
						usr << output(a, "new_build.new_build_grid")
				if(usr.BuildTab == "Rocks")
					for(var/atom/a in global.buildRocks)
						I += 1
						winset(usr, "new_build.new_build_grid", "cells=1x[I]")
						winset(usr, "new_build.new_build_grid", "current-cell=1,[I]")
						usr << output(a, "new_build.new_build_grid")
				if(usr.BuildTab == "Edges")
					for(var/atom/a in global.buildEdges)
						I += 1
						winset(usr, "new_build.new_build_grid", "cells=1x[I]")
						winset(usr, "new_build.new_build_grid", "current-cell=1,[I]")
						usr << output(a, "new_build.new_build_grid")
				if(usr.BuildTab == "Surf")
					for(var/atom/a in global.buildSurf)
						I += 1
						winset(usr, "new_build.new_build_grid", "cells=1x[I]")
						winset(usr, "new_build.new_build_grid", "current-cell=1,[I]")
						usr << output(a, "new_build.new_build_grid")
				if(usr.BuildTab == "Bushes")
					for(var/atom/a in global.buildBushes)
						I += 1
						winset(usr, "new_build.new_build_grid", "cells=1x[I]")
						winset(usr, "new_build.new_build_grid", "current-cell=1,[I]")
						usr << output(a, "new_build.new_build_grid")
				if(usr.BuildTab == "Plants")
					for(var/atom/a in global.buildPlants)
						I += 1
						winset(usr, "new_build.new_build_grid", "cells=1x[I]")
						winset(usr, "new_build.new_build_grid", "current-cell=1,[I]")
						usr << output(a, "new_build.new_build_grid")
				if(usr.BuildTab == "Trees")
					for(var/atom/a in global.buildTrees)
						I += 1
						winset(usr, "new_build.new_build_grid", "cells=1x[I]")
						winset(usr, "new_build.new_build_grid", "current-cell=1,[I]")
						usr << output(a, "new_build.new_build_grid")
				if(usr.BuildTab == "Misc")
					for(var/atom/a in global.propMisc)
						I += 1
						winset(usr, "new_build.new_build_grid", "cells=1x[I]")
						winset(usr, "new_build.new_build_grid", "current-cell=1,[I]")
						usr << output(a, "new_build.new_build_grid")
				return
			else
				usr.BuildOpen = 0
				winshow(usr,"new_build",0)
				return

