


obj/grid

	icon = 'symbols.dmi'
	var/tmp/owner

	SelectorL
		name = ""
		icon_state = "SelectorL"

	SelectorR
		name = ""
		icon_state= "Selectorr"

	category
		name = ""
		icon = 'symbols.dmi'
		icon_state = "Plus"

		Click(location)
			if(src.icon_state == "Plus")
				src.icon_state = "Minus"

				for(var/i in build_categ) // Loop through the list in the user's inventory.
					if(i != src.name)  //continue // If it's not the object they clicked, skip it.
						build_categ[i] = 0
					else
						build_categ[i] = 1  // Set the value to 1, telling the proc that populates
											//the grid that this category should be expanded

			else
				src.icon_state = "Plus"
				for(var/i in build_categ)
					if(i != src.name) continue
					build_categ[i] = 0 // Same as above, but now it shouldn't be expanded.

			usr.buildMainCat(BUILD_CATS)

	subcategory
		name = ""
		icon = 'symbols.dmi'
		icon_state = "Plus"

		Click(location)
			if(src.icon_state == "Plus")
				src.icon_state = "Minus"

				for(var/i in buildter_sub)
					if(i != src.name) //continue
						buildter_sub[i] = 0
					else
						//build_categ["Terrain"] = 2
						buildter_sub[i] = 1
						usr.buildSubCats("Terrain")

				for(var/i in buildprop_sub)
					if(i != src.name) //continue
						buildprop_sub[i] = 0
					else
						//build_categ["Props"] = 2
						buildprop_sub[i] = 1
						usr.buildSubCats("Props")

			else
				src.icon_state = "Plus"
				for(var/i in buildter_sub)
					if(i != src.name) continue
					buildter_sub[i] = 0
					usr.buildSubCats("Terrain")

				for(var/i in buildprop_sub)
					if(i != src.name) continue
					buildprop_sub[i] = 0
					usr.buildSubCats("Props")

/*

Grid related procs.

showBuildGrid()
is responsible for setting up the list with settings if it doesn't exist yet
and then populating it with the categories.

It only does this once. After that it'll 'build' the main categories and then display the window.

*/


mob/proc/showBuildGrid()

	if(!build_categ || !build_categ.len)
		var/list/catnames = list("Roofs","Walls","Doors","Terrain","Props")
		build_categ = new

		for(var/i=1, i<catnames.len+1, i++)
			var/obj/grid/category/C=new
			C.name = "[catnames[i]]"
			build_categ+=C
			build_categ["[C.name]"]=0

	if(!buildter_sub || !buildter_sub.len)
		var/list/ternames = list("Grass","Ground","Sky","Stairs","Tiles","Water","TerrainMisc")
		buildter_sub = new

		for(var/i=1, i<ternames.len+1, i++)
			var/obj/grid/subcategory/C=new
			C.name = "[ternames[i]]"
			buildter_sub+=C
			buildter_sub["[C.name]"]=0

	if(!buildprop_sub || !buildprop_sub.len)
		var/list/propnames = list("Chairs","Tables","Heatsources","Signs","Rocks","Edges","Surf","Bushes","Plants","Trees","PropsMisc")
		buildprop_sub = new

		for(var/i=1, i<propnames.len+1, i++)
			var/obj/grid/subcategory/C=new
			C.name = "[propnames[i]]"
			buildprop_sub+=C
			buildprop_sub["[C.name]"]=0

	src.buildMainCat(BUILD_CATS)
	//winshow(src, BUILDWINDOW, 1)


mob/proc/clearGrid(grid)  // This proc does as the name implies, it empties the grid.

	var
		size = winget(src,grid,"cells")
		pos = findtext(size,"x") //

	if(pos) // We found an x, which means it returned the cells paramater and means the grid exists.

		var
			rows=text2num( copytext(size,pos+1) )
			cols=text2num( copytext(size,1,pos) )

		if(rows&&cols) // If we've got the rows and columns
			for(rows=rows, rows>0, rows--) // Loop through all the rows
				for(var/i=cols, i>0, i--) // For each row, empty it, then move a column to the side
					winset(src,grid,"current-cell=[i],[rows]")
					src<<output(null,grid)

	winset(src, grid, "cells=1x1")
	// Once we've emptied out the entire grid, reset it to 1x1, since we recreate the size of the grid manually.
	// Note that if we skip this step, the grid will retain its size causing it to grow indefinitely.

mob/proc/buildMainCat(gridID)

	var
		rows = 1
		cols = 1

	//debuglog << "[__FILE__]:[__LINE__] || src: [src ? src : "null"] usr: [usr ? usr : "null"] buildmaincat()"
	if(src)
		src.clearGrid(gridID) // First, empty the grid again.

		switch(gridID)
			if(BUILD_CATS)
				for(var/i in build_categ) // Trigger the proc that populates the grid for every category
					src.updateBuildGrid(categ   = i,
										expand  = build_categ[i],
										col     = cols)

					//sleep(1)
					cols = gridColRow(BUILD_CATS,"cols")+1 // Calculate the current amount of rows in the grid and add one.

			else
				errors << "[__FILE__]:[__LINE__] >> No gridID clause could be satisfied. [gridID ? gridID : "null"]"

		if(src)
			cols = src.gridColRow(BUILD_CATS,"cols")+1
			winset(src, BUILD_CATS, "cells=[cols]x[rows]")

		//winset(src, BUILDWINDOW, "on-close=\"closebuild\"")

mob/proc/buildSubCats(gridID)

	var
		cols = 1

	winset(src, BUILD_SUBS, "cells=0x0")

	switch(gridID)
		if("Terrain")

//			for(var/obj/O in buildter_sub)
//				src << output(O, "[BUILD_SUBS]:1,[++cols]")

			for(var/obj/O in buildter_sub)
				if(buildter_sub[O.name]!=0)
					O.icon_state = "Minus"
				else
					O.icon_state = "Plus"

				src << output(O, "[BUILD_SUBS]:1,[++cols]")
				if(!.)
					. = src.updateBuildSub( categ   = O.name,
										expand  = buildter_sub[O.name],
										col     = cols)

		if("Props")

			for(var/obj/O in buildprop_sub)
				if(buildprop_sub[O.name]!=0)
					O.icon_state = "Minus"
				else
					O.icon_state = "Plus"

				src << output(O, "[BUILD_SUBS]:1,[++cols]")

				if(!.)
					. = src.updateBuildSub( categ   = O.name,
										expand  = buildprop_sub[O.name],
										col     = cols)


// This proc calculates the grid's Columns or Rows

mob/proc/gridColRow(gridID,what)

	var
		size = winget(src,gridID,"cells")  // Get the 'cells' paramater of whatever grid you tell it to.
		pos = findtext(size,"x") // The cells are written down in columnxrow format, and is a text string.
								// The 'x' is the seperator if you will and you can use this to determine the search bounds within the text string
	switch(what)	// Self explenatory
		if("rows")
			return text2num( copytext(size,pos+1) ) // copy everything AFTER the x (the rows) and return it
		if("cols")
			return text2num( copytext(size,1,pos) ) // Copy everything BEFORE the x (the columns) and return it
		else
			errors << "[__FILE__]:[__LINE__] >> gridColRow() No clause could be satisfied. [what ? what : "null"]"



/*
##############################################

   updateBuildGrid(categ,expand=0,row=1)

 categ

 The category you're placing, each time it's placed the proc checks
 if the user had this category expanded before. If so, it expands it.

 expand

 By default, 0 meaning the category is not expanded. 1 if it is, 2 if any of its subcategories are expanded.

 row

 This is row at which the grid should continue to be filled.

##############################################
*/

mob/proc/updateBuildGrid(categ,expand=0,col=1)

	var
		row=1

	//debuglog << "[__FILE__]:[__LINE__] || src: [src ? src : "null"] usr: [usr ? usr : "null"] updatebuildgrid()"
	if(src)
		switch(categ) // See which category it's placing

			if("Roofs")

				for(var/obj/O in build_categ)
					if(O.name != categ) continue

					winset(src, BUILD_CATS, "current-cell=[col],[row]")
					if(expand!=0)
						O.icon_state = "Minus"
					else
						O.icon_state = "Plus"
					src << output(O, BUILD_CATS)
					//sleep(1)

				if(expand!=0)
					//row = 1

					winset(src, BUILD_CONTENT, "cells=0x0")
					for(var/buildobject in global.buildRoofs)
						src << output(buildobject, "[BUILD_CONTENT]:1,[++row]")

					return 2

				else
					//winset(src, BUILD_CATS, "current-cell=1,[row]")
					//src << output(null, BUILD_CATS)
					return col++

			if("Walls")

				for(var/obj/O in build_categ)
					if(O.name != categ) continue

					winset(src, BUILD_CATS, "current-cell=[col],[row]")
					if(expand!=0)
						O.icon_state = "Minus"
					else
						O.icon_state = "Plus"
					src << output(O, BUILD_CATS)


				if(expand!=0)
					//row = 1
					winset(src, BUILD_CONTENT, "cells=0x0")
					for(var/buildobject in global.buildWalls)
						src << output(buildobject, "[BUILD_CONTENT]:1,[++row]")

					return 2

				else
					col++
					//winset(src, BUILD_CATS, "current-cell=1,[row]")
					//src << output(null, BUILD_CATS)
					return col

			if("Doors")

				for(var/obj/O in build_categ)
					if(O.name != categ) continue

					winset(src, BUILD_CATS, "current-cell=[col],[row]")
					if(expand!=0)
						O.icon_state = "Minus"
					else
						O.icon_state = "Plus"
					src << output(O, BUILD_CATS)

				if(expand!=0)
					row = 1
					winset(src, BUILD_CONTENT, "cells=0x0")
					for(var/buildobject in global.buildDoors)
						src << output(buildobject, "[BUILD_CONTENT]:1,[++row]")
					return 7

				else
					//row += 2
					//winset(src, BUILD_CATS, "current-cell=1,[row]")
					//src << output(null, "buildGrid")
					return 3

			if("Terrain")

				for(var/obj/O in build_categ)
					if(O.name != categ) continue

					winset(src, BUILD_CATS, "current-cell=[col],[row]")
					if(expand!=0)
						O.icon_state = "Minus"
					else
						O.icon_state = "Plus"
					src << output(O, BUILD_CATS)

				switch(expand)
					if(1) // Display the sub categories.

						row = 1
						col = 1
						winset(src, BUILD_SUBS, "cells=0x0")
						for(var/obj/O in buildter_sub)
							src << output(O, "[BUILD_SUBS]:1,[++col]")

						return col
	/*
					if(2) // Load the objects belong to a subcategory

						col = 1
						row = 1

						for(var/i in buildter_sub)
							for(var/obj/O in buildter_sub)
								if(O.name != i) continue

								winset(src, BUILD_SUBS, "current-cell=[col],[row]")
								if(buildter_sub[i]!=0)
									O.icon_state = "Minus"
								else
									O.icon_state = "Plus"
								src << output(O, BUILD_SUBS)

								if(buildter_sub[i]==0) continue

								src.updateBuildSub(categ   = i,
													expand  = buildter_sub[i],
													row     = row+1)

							sleep(1)
							col = gridColRow(BUILD_SUBS,"cols")+1
						return col

						//for(var/i in buildter_sub)
	*/
					else
						//row += 2
						//winset(src, BUILD_CATS, "current-cell=1,[row]")
						col = gridColRow(BUILD_CATS,"cols")+1
						return row

			if("Props")

				for(var/obj/O in build_categ)
					if(O.name != categ) continue

					winset(src, BUILD_CATS, "current-cell=[col],[row]")
					if(expand!=0)
						O.icon_state = "Minus"
					else
						O.icon_state = "Plus"
					src << output(O, BUILD_CATS)

				switch(expand)

					if(1)
						row = 1
						col = 1
						winset(src, BUILD_SUBS, "cells=0x0")
						for(var/obj/O in buildprop_sub)
							src << output(O, "[BUILD_SUBS]:1,[++col]")

						return col
	/*
					if(2)

						row = 1
						col = gridColRow(BUILD_SUBS,"cols")+1

						for(var/i in buildprop_sub)
							for(var/obj/O in buildprop_sub)
								if(O.name != i) continue

								winset(src, BUILD_SUBS, "current-cell=[col],[row]")
								if(buildter_sub[i]!=0)
									O.icon_state = "Minus"
								else
									O.icon_state = "Plus"
								src << output(O, BUILD_SUBS)

								if(buildprop_sub[i]==0) continue

								src.updateBuildSub(categ   = i,
													expand  = buildprop_sub[i],
													row     = row+1)

							sleep(1)
							col = gridColRow(BUILD_SUBS,"cols")+1
						return col
	*/
					else
						//row += 2
						//winset(src, "grid_buildCat", "current-cell=1,[row]")
						//src << output(null, "grid_buildCat")
						col = gridColRow(BUILD_CATS,"cols")+1
						return col

		//else
			//errors << "[__FILE__]:[__LINE__] >> [src] No categ clause could be satisfied. [categ ? categ : "null"]"

/*
##############################################

   updateBuildSub(categ,expand=0,row=1)

The same as the proc above, but for the subcategories.
Expand's only purpose in this case, is a sanity check of sorts.

##############################################
*/

mob/proc/updateBuildSub(categ,expand=0,col=1)

	//debuglog << "[__FILE__]:[__LINE__] || src: [src ? src : "null"] usr: [usr ? usr : "null"] updatebuildsub()"
	var/row=1

	switch(categ) // See which category it's placing

		if("Grass")
			if(expand!=0)
				winset(src, BUILD_CONTENT, "cells=0x0")
				for(var/buildobject in global.buildGrass)
					src << output(buildobject, "[BUILD_CONTENT]:1,[++row]")
				return TRUE

		if("Ground")
			if(expand!=0)
				winset(src, BUILD_CONTENT, "cells=0x0")
				for(var/buildobject in global.buildGround)
					src << output(buildobject, "[BUILD_CONTENT]:1,[++row]")
				return TRUE

		if("Sky")
			if(expand!=0)
				winset(src, BUILD_CONTENT, "cells=0x0")
				for(var/buildobject in global.buildSky)
					src << output(buildobject, "[BUILD_CONTENT]:1,[++row]")
				return TRUE

		if("Stairs")
			if(expand!=0)
				winset(src, BUILD_CONTENT, "cells=0x0")
				for(var/buildobject in global.buildStairs)
					src << output(buildobject, "[BUILD_CONTENT]:1,[++row]")
				return TRUE

		if("Tiles")
			if(expand!=0)
				winset(src, BUILD_CONTENT, "cells=0x0")
				for(var/buildobject in global.buildTiles)
					src << output(buildobject, "[BUILD_CONTENT]:1,[++row]")
				return TRUE

		if("Water")
			if(expand!=0)
				winset(src, BUILD_CONTENT, "cells=0x0")
				for(var/buildobject in global.buildWater)
					src << output(buildobject, "[BUILD_CONTENT]:1,[++row]")
				return TRUE

		if("TerrainMisc")
			if(expand!=0)
				winset(src, BUILD_CONTENT, "cells=0x0")
				for(var/buildobject in global.terrainMisc)
					src << output(buildobject, "[BUILD_CONTENT]:1,[++row]")
				return TRUE

		if("Chairs")
			if(expand!=0)
				winset(src, BUILD_CONTENT, "cells=0x0")
				for(var/buildobject in global.buildChairs)
					src << output(buildobject, "[BUILD_CONTENT]:1,[++row]")
				return TRUE

		if("Tables")
			if(expand!=0)
				winset(src, BUILD_CONTENT, "cells=0x0")
				for(var/buildobject in global.buildTables)
					src << output(buildobject, "[BUILD_CONTENT]:1,[++row]")
				return TRUE

		if("Heatsources")
			if(expand!=0)
				winset(src, BUILD_CONTENT, "cells=0x0")
				for(var/buildobject in global.buildHeatsources)
					src << output(buildobject, "[BUILD_CONTENT]:1,[++row]")
				return TRUE

		if("Signs")
			if(expand!=0)
				winset(src, BUILD_CONTENT, "cells=0x0")
				for(var/buildobject in global.buildSigns)
					src << output(buildobject, "[BUILD_CONTENT]:1,[++row]")
				return TRUE

		if("Rocks")
			if(expand!=0)
				winset(src, BUILD_CONTENT, "cells=0x0")
				for(var/buildobject in global.buildRocks)
					src << output(buildobject, "[BUILD_CONTENT]:1,[++row]")
				return TRUE

		if("Edges")
			if(expand!=0)
				winset(src, BUILD_CONTENT, "cells=0x0")
				for(var/buildobject in global.buildEdges)
					src << output(buildobject, "[BUILD_CONTENT]:1,[++row]")
				return TRUE

		if("Surf")
			if(expand!=0)
				winset(src, BUILD_CONTENT, "cells=0x0")
				for(var/buildobject in global.buildSurf)
					src << output(buildobject, "[BUILD_CONTENT]:1,[++row]")
				return TRUE

		if("Bushes")
			if(expand!=0)
				winset(src, BUILD_CONTENT, "cells=0x0")
				for(var/buildobject in global.buildBushes)
					src << output(buildobject, "[BUILD_CONTENT]:1,[++row]")
				return TRUE

		if("Plants")
			if(expand!=0)
				winset(src, BUILD_CONTENT, "cells=0x0")
				for(var/buildobject in global.buildPlants)
					src << output(buildobject, "[BUILD_CONTENT]:1,[++row]")
				return TRUE

		if("Trees")
			if(expand!=0)
				winset(src, BUILD_CONTENT, "cells=0x0")
				for(var/buildobject in global.buildTrees)
					src << output(buildobject, "[BUILD_CONTENT]:1,[++row]")
				return TRUE

		if("PropsMisc")
			if(expand!=0)
				winset(src, BUILD_CONTENT, "cells=0x0")
				for(var/buildobject in global.propMisc)
					src << output(buildobject, "[BUILD_CONTENT]:1,[++row]")
				return TRUE

		//else
			//errors << "[__FILE__]:[__LINE__] >> [src] No categ clause could be satisfied. [categ ? categ : "null"]"