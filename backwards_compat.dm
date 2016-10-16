/*
#######

This file was made with the sole intention of allowing a live server to be updated
with the restructured items and objects.

It should stop being included after version 0.312

#######
*/

obj/Turfs
	Savable=0
	layer=4
	Spawn_Timer=180000
	Buildable = 1
	Door
		density = 0
		opacity = 0
		icon = 'Door.dmi'
		icon_state = "Closed"
		Shockwaveable = 0

		Door2
			density=1
			icon='Door2.dmi'
			icon_state="Closed"
		Rusted_Door
			density=1
			icon='RustedDoor.dmi'
			icon_state="Closed"
		Namekian_Door
			density=1
			icon='NamekDoor.dmi'
			icon_state="Closed"
		Tech_Door_1
			density=1
			icon='Techie Door 1.dmi'
			icon_state="Closed"
		Reinforced_Door
			density=1
			icon='Prison Door.dmi'
			icon_state="Closed"
		Click()
			if(usr.client.mob in range(1,src))
				range(10,src) << "<font color=#FFFF00>There is a knock at the door!"
		New()
			for(var/obj/Controls/C in view(1,src))
				del(src)
			for(var/turf/Special/Teleporter/R in view(1,src))
				del(src)
			Close()
		proc
			Open()
				flick("Opening",src)    //Wait until door opens to let people through
				icon_state = "Open"
				density = 0
				opacity = 0
				//src.sd_SetOpacity(0)
				//sd_ObjSpillLight(src)
				spawn(50)
					Close()
			Close()
				flick("Closing",src)    //Wait until door closes to actually be dense
				icon_state="Closed"
				//src.sd_SetOpacity(1)
				//sd_ObjUnSpillLight(src)
				opacity = 1
				density = 1
			check_access(var/obj/items/Door_Pass/D)
				if(src.Password == D.Password)
					return 1
				else
					return 0
	Sign
		icon='Sign.dmi'
		density=1
		Click() if(desc) usr<<desc
	Sign/Information_Panel
		icon='Lab.dmi'
		icon_state="Radar"
		Click() if(desc) usr<<desc
	Rock
		icon='Turfs 2.dmi'
		icon_state="rock"
	LargeRock
		density=1
		icon='turfs.dmi'
		icon_state="rockl"
	firewood
		icon='roomobj.dmi'
		icon_state="firewood"
		density=1
	WaterRock
		density=1
		icon='turfs.dmi'
		icon_state="waterrock"
	Throne_1
		icon='Throne 2.dmi'
		icon_state="white"
		New()
			var/image/A=image(icon='Throne 2.dmi',icon_state="white top",pixel_y=32,layer=MOB_LAYER+1)
			overlays+=A
	Throne_2
		icon='Throne 2.dmi'
		icon_state="jade"
		New()
			var/image/A=image(icon='Throne 2.dmi',icon_state="jade top",pixel_y=32,layer=MOB_LAYER+1)
			overlays+=A
	Throne_3
		icon='Throne 2.dmi'
		icon_state="pink"
		New()
			var/image/A=image(icon='Throne 2.dmi',icon_state="pink top",pixel_y=32,layer=MOB_LAYER+1)
			overlays+=A
	Throne_4
		icon='Throne 2.dmi'
		icon_state="snow"
		New()
			var/image/A=image(icon='Throne 2.dmi',icon_state="snow top",pixel_y=32,layer=MOB_LAYER+1)
			overlays+=A
	Throne_5
		icon='Throne 2.dmi'
		icon_state="evil"
		New()
			var/image/A=image(icon='Throne 2.dmi',icon_state="evil top",pixel_y=32,layer=MOB_LAYER+1)
			overlays+=A
	Throne_6
		icon='Throne 2.dmi'
		icon_state="tie-dye2"
		New()
			var/image/A=image(icon='Throne 2.dmi',icon_state="tie-dye2 top",pixel_y=32,layer=MOB_LAYER+1)
			overlays+=A
	Throne_7
		icon='Throne 2.dmi'
		icon_state="dragon"
		New()
			var/image/A=image(icon='Throne 2.dmi',icon_state="dragon top",pixel_y=32,layer=MOB_LAYER+1)
			overlays+=A
	Throne_8
		icon='Throne 2.dmi'
		icon_state="gold"
		New()
			var/image/A=image(icon='Throne 2.dmi',icon_state="gold top",pixel_y=32,layer=MOB_LAYER+1)
			overlays+=A
	Throne_9
		icon='Throne 2.dmi'
		icon_state="light blue"
		New()
			var/image/A=image(icon='Throne 2.dmi',icon_state="light blue top",pixel_y=32,layer=MOB_LAYER+1)
			overlays+=A
	Throne_10
		icon='Throne 2.dmi'
		icon_state="bronze"
		New()
			var/image/A=image(icon='Throne 2.dmi',icon_state="bronze top",pixel_y=32,layer=MOB_LAYER+1)
			overlays+=A
	Throne_11
		icon='zzzz.dmi'
		icon_state="zarchair1"
		New()
			var/image/A=image(icon='zzzz.dmi',icon_state="zarchair4",pixel_y=32,layer=MOB_LAYER+1)
			overlays+=A
	Throne_12
		icon='New Throne.dmi'
		icon_state=""
		layer=3
	//      New()
	//	      var/image/A=image(icon='New Throne.dmi',icon_state="",pixel_y=32,layer=MOB_LAYER+1)
	//	      overlays+=A
	Hell_Skull
		density=1
		icon='Hell turf.dmi'
		icon_state="h7"
	HellRock
		density=1
		icon='turfs.dmi'
		icon_state="hellrock1"
		New()
			spawn if(src) Fire_Cook(100)
			//..()
	HellRock2
		density=1
		icon='turfs.dmi'
		icon_state="hellrock2"
		New()
			spawn if(src) Fire_Cook(100)
			//..()
	HellRock3
		density=1
		icon='turfs.dmi'
		icon_state="hellrock3"
		New()
			spawn if(src) Fire_Cook(100)
			//..()
	LargeRock2
		density=1
		icon='turfs.dmi'
		icon_state="terrainrock"
	Rock1
		icon='Turf 50.dmi'
		icon_state="1.9"
		density=1
	Rock2
		icon='Turf 50.dmi'
		icon_state="2.0"
		density=1
	Stalagmite
		density=1
		icon='Turf 57.dmi'
		icon_state="44"
	Fence
		density=1
		icon='Turf 55.dmi'
		icon_state="woodenfence"
	Rock3
		icon='Turf 57.dmi'
		icon_state="19"
		density=1
	Rock4
		icon='Turf 57.dmi'
		icon_state="20"
		density=1
	Flowers
		icon='Turf 52.dmi'
		icon_state="flower bed"
	Rock6
		icon='Turf 57.dmi'
		icon_state="64"
		density=1
	Bush1
		icon='Turf 57.dmi'
		icon_state="bush"
		density=1
	Whirlpool icon='Whirlpool.dmi'
	Bush2
		icon='Turf 57.dmi'
		icon_state="bushbig1"
		density=1
	Bush3
		icon='Turf 57.dmi'
		icon_state="bushbig2"
		density=1
	Bush4
		icon='Turf 57.dmi'
		icon_state="bushbig3"
		density=1
	Bush5
		icon='Turf 50.dmi'
		icon_state="2.1"
		density=1
	SnowBush
		icon='Turf 57.dmi'
		icon_state="snowbush"
		density=1
	Plant12
		icon='Plants.dmi'
		icon_state="plant1"
		density=1
	Table7
		icon='Turf3.dmi'
		icon_state="168"
		density=1
	Table8
		icon='Turf3.dmi'
		icon_state="169"
		density=1
	Plant11
		icon='Plants.dmi'
		icon_state="plant2"
		density=1
	Plant10
		icon='Plants.dmi'
		icon_state="plant3"
		density=1
	Plant16
		icon='roomobj.dmi'
		icon_state="flowers"
	Plant15
		icon='roomobj.dmi'
		icon_state="flowers2"
	Plant2
		icon='Turf3.dmi'
		icon_state="plant"
		density=1
	Plant3
		icon='turfs.dmi'
		icon_state="groundplant"
	Plant4
		icon='Turf2.dmi'
		icon_state="plant2"
	Plant5
		icon='Turf2.dmi'
		icon_state="plant3"
	Plant13
		icon='turfs.dmi'
		icon_state="bush"
	Plant14
		icon='Turfs 1.dmi'
		icon_state="frozentree"
		density=1
	Plant18
		icon='Trees.dmi'
		icon_state="Dead Tree1"
		density=1
	Plant6
		icon='Turfs1.dmi'
		icon_state="1"
		density=1
	Plant20
		icon='Turfs1.dmi'
		icon_state="2"
		density=1
	Plant19
		icon='Turfs1.dmi'
		icon_state="3"
		density=1
	Plant7
		icon='Trees.dmi'
		icon_state="Tree1"
		density=1
	Plant8
		icon='Turfs 1.dmi'
		icon_state="smalltree"
		density=1
	Plant9
		icon='Turfs 2.dmi'
		icon_state="treeb"
		density=1
	bridgeN
		icon='Misc.dmi'
		icon_state="N"
		density=1
	bridgeS
		icon='Misc.dmi'
		icon_state="S"
		density=1
	bridgeE
		icon='Misc.dmi'
		icon_state="E"
		density=1
	Table9
		icon='Turf 52.dmi'
		icon_state="small table"
		density=1
	bridgeW
		icon='Misc.dmi'
		icon_state="W"
		density=1
	Chest
		icon='Turf3.dmi'
		icon_state="161"
	Tech_Console
		icon='customtiles1.dmi'
		icon_state="Walldisplay1"
		density=1
		luminosity=1
	Tech_Console2
		icon='customtiles1.dmi'
		icon_state="Walldisplay2"
		density=1
		luminosity=1
	Tech_Console3
		icon='customtiles1.dmi'
		icon_state="Walldisplay3"
		luminosity=1
		density=1
	HellPot
		icon='turfs.dmi'
		icon_state="flamepot2"
		density=1
		luminosity=8
		New()
			var/image/A=image(icon='turfs.dmi',icon_state="flamepot1",pixel_y=32)
			overlays.Remove(A)
			overlays.Add(A)
			spawn if(src) Fire_Cook(100)
			//..()
	RugLarge
		New()
			var/image/A=image(icon='Turfs 96.dmi',icon_state="spawnrug1",pixel_x=-16,pixel_y=16,layer=2)
			var/image/B=image(icon='Turfs 96.dmi',icon_state="spawnrug2",pixel_x=16,pixel_y=16,layer=2)
			var/image/C=image(icon='Turfs 96.dmi',icon_state="spawnrug3",pixel_x=-16,pixel_y=-16,layer=2)
			var/image/D=image(icon='Turfs 96.dmi',icon_state="spawnrug4",pixel_x=16,pixel_y=-16,layer=2)
			overlays.Remove(A,B,C,D)
			overlays.Add(A,B,C,D)
			//..()
	Apples
		icon='Turf3.dmi'
		icon_state="163"
	Angel_Statue
		icon='zzzz.dmi'
		icon_state="statuebottom"
		New()
			var/image/A=image(icon='zzzz.dmi',icon_state="statuetop",layer=MOB_LAYER+1,pixel_y=32)
			overlays+=A
	Book
		icon='Turf3.dmi'
		icon_state="167"
	Light
		icon='Space.dmi'
		icon_state="light"
		density=1
		luminosity=10
	Glass
		icon='Space.dmi'
		icon_state="glass1"
		density=1
		layer=MOB_LAYER+1

	Glass_Solid
		icon='Space.dmi'
		icon_state="glass1"
		density=1


	Table6
		icon='turfs.dmi'
		icon_state="Table"
		density=1
	Table5
		icon='Turfs 2.dmi'
		icon_state="tableL"
		density=1
	Log
		density=1
		New()
			var/image/A=image(icon='Turf 57.dmi',icon_state="log1",pixel_x=-16)
			var/image/B=image(icon='Turf 57.dmi',icon_state="log2",pixel_x=16)
			overlays.Remove(A,B)
			overlays.Add(A,B)
			//..()
	FancyCouch
		New()
			var/image/A=image(icon='Turf 52.dmi',icon_state="couch left",pixel_x=-16)
			var/image/B=image(icon='Turf 52.dmi',icon_state="couch right",pixel_x=16)
			overlays.Remove(A,B)
			overlays.Add(A,B)
			//..()
	Table3
		icon='Turfs 2.dmi'
		icon_state="tableR"
		density=1
	Table4
		icon='Turfs 2.dmi'
		icon_state="tableM"
		density=1
	Jugs
		icon='Turf 52.dmi'
		icon_state="jugs"
		density=1
	Hay
		icon='Turf 52.dmi'
		icon_state="hay"
		density=1
	Clock
		icon='Turf 52.dmi'
		icon_state="clock"
		density=1
	Torch3
		icon= 'Turf 57.dmi'
		icon_state = "83"
		density = 1
		luminosity=8
		New()
			spawn()
				if(src)
					Fire_Cook(100)
			//..()
		Buildable = 1
	Fire
		icon='Turf 57.dmi'
		icon_state="82"
		density=1
		luminosity=8
		New()
			spawn()
				if(src)
					Fire_Cook(100)
			//..()
	Table9
		icon='Turf 52.dmi'
		icon_state="small table"
		density=1
	Waterpot
		icon='Turf 52.dmi'
		icon_state="water pot"
		density=1
	Log
		density=1
		New()
			var/image/A=image(icon='Turf 57.dmi',icon_state="log1",pixel_x=-16)
			var/image/B=image(icon='Turf 57.dmi',icon_state="log2",pixel_x=16)
			overlays.Remove(A,B)
			overlays.Add(A,B)
	FancyCouch
		New()
			var/image/A=image(icon='Turf 52.dmi',icon_state="couch left",pixel_x=-16)
			var/image/B=image(icon='Turf 52.dmi',icon_state="couch right",pixel_x=16)
			overlays.Remove(A,B)
			overlays.Add(A,B)
	Stove
		icon='Turf 52.dmi'
		icon_state="stove"
		density=1
		New()
			spawn()
				if(src)
					Fire_Cook(100)
			//..()
	Apples
		icon='Turf3.dmi'
		icon_state="163"
		density=1
	Drawer
		icon='Turf 52.dmi'
		icon_state="drawers"
		density=1
		New()
			var/image/A=image(icon='Turf 52.dmi',icon_state="drawers top",pixel_y=32)
			overlays.Remove(A)
			overlays.Add(A)
	Bed
		icon='Turf 52.dmi'
		icon_state="bed top"
		New()
			var/image/A=image(icon='Turf 52.dmi',icon_state="bed",pixel_y=-32)
			overlays.Remove(A)
			overlays.Add(A)
	Torch1
		icon='Turf2.dmi'
		icon_state="168"
		density=1
		luminosity=8
		New()
			spawn()
				if(src)
					Fire_Cook(100)
			//..()
	Torch2
		icon='Turf2.dmi'
		icon_state="169"
		density=1
		luminosity=8
		New()
			spawn()
				if(src)
					Fire_Cook(100)
			//..()
	Torch3
		icon='Turf 57.dmi'
		icon_state="83"
		density=1
		luminosity=8
		New()
			spawn()
				if(src)
					Fire_Cook(100)
			//..()
	Fire
		icon='Turf 57.dmi'
		icon_state="82"
		density=1
		luminosity=8
		New()
			spawn()
				if(src)
					Fire_Cook(100)
			//..()
	barrel
		icon='Turfs 2.dmi'
		icon_state="barrel"
		density=1
	Waterfall
		icon='waterfall.dmi'
		layer=MOB_LAYER+1
	chair
		icon='turfs.dmi'
		icon_state="Chair"

	box2
		icon='Turfs 5.dmi'
		icon_state="box"
		density=1
	Flowers
		icon='tuft2.dmi'
	Giant_Statue
		density=1
		New()
			var/image/A=image(icon='Turfs Temple.dmi',icon_state="force",pixel_x=-16)
			var/image/B=image(icon='Turfs Temple.dmi',icon_state="force2",pixel_x=16)
			var/image/C=image(icon='Turfs Temple.dmi',icon_state="force5",pixel_x=-16,pixel_y=32,layer=MOB_LAYER+1)
			var/image/D=image(icon='Turfs Temple.dmi',icon_state="force6",pixel_x=16,pixel_y=32,layer=MOB_LAYER+1)
			var/image/E=image(icon='Turfs Temple.dmi',icon_state="force7",pixel_x=-16,pixel_y=64,layer=MOB_LAYER+1)
			var/image/F=image(icon='Turfs Temple.dmi',icon_state="force8",pixel_x=16,pixel_y=64,layer=MOB_LAYER+1)
			overlays.Add(A,B,C,D,E,F)
obj/Trees
	Savable=0
	layer=4
	density=1
	Spawn_Timer=180000
	Dead_Tree_1
		New()
			var/image/A=image(icon='turfs66.dmi',icon_state="2",pixel_x=0,pixel_y=0,layer=layer)
			var/image/B=image(icon='turfs66.dmi',icon_state="3",pixel_x=-32,pixel_y=32,layer=MOB_LAYER+1)
			var/image/C=image(icon='turfs66.dmi',icon_state="42",pixel_x=0,pixel_y=32,layer=MOB_LAYER+1)
			var/image/D=image(icon='turfs66.dmi',icon_state="31",pixel_x=32,pixel_y=32,layer=MOB_LAYER+1)
			overlays.Add(A,B,C,D)
	Dead_Tree_2
		New()
			var/image/A=image(icon='turfs66.dmi',icon_state="d1",pixel_x=0,pixel_y=0,layer=layer)
			var/image/B=image(icon='turfs66.dmi',icon_state="d2",pixel_x=-32,pixel_y=32,layer=MOB_LAYER+1)
			var/image/C=image(icon='turfs66.dmi',icon_state="d3",pixel_x=0,pixel_y=32,layer=MOB_LAYER+1)
			var/image/D=image(icon='turfs66.dmi',icon_state="d4",pixel_x=32,pixel_y=32,layer=MOB_LAYER+1)
			overlays.Add(A,B,C,D)
	Dark_Tree
		New()
			var/image/A=image(icon='turfs66.dmi',icon_state="treebotleft",pixel_x=-16,pixel_y=0,layer=layer)
			var/image/B=image(icon='turfs66.dmi',icon_state="treebotright",pixel_x=16,pixel_y=0,layer=layer)
			var/image/C=image(icon='turfs66.dmi',icon_state="treetopleft",pixel_x=-16,pixel_y=32,layer=MOB_LAYER+1)
			var/image/D=image(icon='turfs66.dmi',icon_state="treetopright",pixel_x=16,pixel_y=32,layer=MOB_LAYER+1)
			overlays.Add(A,B,C,D)
	Strange_Pine
		New()
			var/image/A=image(icon='turfs66.dmi',icon_state="treeleftbot1",pixel_x=-16,pixel_y=0,layer=layer)
			var/image/B=image(icon='turfs66.dmi',icon_state="treerightbot1",pixel_x=16,pixel_y=0,layer=layer)
			var/image/C=image(icon='turfs66.dmi',icon_state="treelefttop1",pixel_x=-16,pixel_y=32,layer=MOB_LAYER+1)
			var/image/D=image(icon='turfs66.dmi',icon_state="treerighttop1",pixel_x=16,pixel_y=32,layer=MOB_LAYER+1)
			overlays.Add(A,B,C,D)
	Nice_Tree
		New()
			var/image/A=image(icon='turfs66.dmi',icon_state="treeleftbot2",pixel_x=-16,pixel_y=0,layer=layer)
			var/image/B=image(icon='turfs66.dmi',icon_state="treerightbot2",pixel_x=16,pixel_y=0,layer=layer)
			var/image/C=image(icon='turfs66.dmi',icon_state="treelefttop2",pixel_x=-16,pixel_y=32,layer=MOB_LAYER+1)
			var/image/D=image(icon='turfs66.dmi',icon_state="treerighttop2",pixel_x=16,pixel_y=32,layer=MOB_LAYER+1)
			overlays.Add(A,B,C,D)
	SmallPine
		icon='Turf 58.dmi'
		icon_state="2"
		density=1
		New()
			var/image/A=image(icon='Turf 58.dmi',icon_state="1",pixel_y=0,pixel_x=-32,layer=50)
			var/image/B=image(icon='Turf 58.dmi',icon_state="0",pixel_y=-32,pixel_x=0,layer=50)
			var/image/C=image(icon='Turf 58.dmi',icon_state="3",pixel_y=32,pixel_x=-32,layer=50)
			var/image/D=image(icon='Turf 58.dmi',icon_state="4",pixel_y=32,pixel_x=0,layer=50)
			overlays.Remove(A,B,C,D)
			overlays.Add(A,B,C,D)
			new/obj/Trees/LargePine(loc)
			del(src)
			//..()
	RedTree
		density=1
		New()
			var/image/A=image(icon='Turf 55.dmi',icon_state="1",pixel_y=32,pixel_x=-32,layer=50)
			var/image/B=image(icon='Turf 55.dmi',icon_state="2",pixel_y=0,pixel_x=0,layer=50)
			var/image/C=image(icon='Turf 55.dmi',icon_state="3",pixel_y=32,pixel_x=32,layer=50)
			var/image/D=image(icon='Turf 55.dmi',icon_state="4",pixel_y=0,pixel_x=-32,layer=50)
			var/image/E=image(icon='Turf 55.dmi',icon_state="5",pixel_y=32,pixel_x=0,layer=50)
			var/image/F=image(icon='Turf 55.dmi',icon_state="6",pixel_y=0,pixel_x=32,layer=50)
			overlays.Remove(A,B,C,D,E,F)
			overlays.Add(A,B,C,D,E,F)
			//..()
	Tall_Tree
		density=1
		icon='treee.dmi'
		icon_state="bottom"
		New()
			var/image/A=image(icon='treee.dmi',icon_state="top",layer=MOB_LAYER+1,pixel_y=32)
			overlays+=A
	BigHousePlant
		density=1
		icon='Turf 52.dmi'
		icon_state="plant bottom"
		New()
			var/image/A=image(icon='Turf 52.dmi',icon_state="plant top",pixel_y=32,pixel_x=0,layer=50)
			overlays.Remove(A)
			overlays.Add(A)
			//..()
	Oak
		density=1
		New()
			var/image/A=image(icon='turfs.dmi',icon_state="1",pixel_y=0,pixel_x=-16,layer=50)
			var/image/B=image(icon='turfs.dmi',icon_state="2",pixel_y=0,pixel_x=16,layer=50)
			var/image/C=image(icon='turfs.dmi',icon_state="3",pixel_y=32,pixel_x=-16,layer=50)
			var/image/D=image(icon='turfs.dmi',icon_state="4",pixel_y=32,pixel_x=16,layer=50)
			var/image/E=image(icon='turfs.dmi',icon_state="5",pixel_y=64,pixel_x=-16,layer=50)
			var/image/F=image(icon='turfs.dmi',icon_state="6",pixel_y=64,pixel_x=16,layer=50)
			overlays.Remove(A,B,C,D,E,F)
			overlays.Add(A,B,C,D,E,F)
			//..()
	RoundTree
		density=1
		New()
			var/image/A=image(icon='turfs.dmi',icon_state="01",pixel_y=0,pixel_x=-16,layer=50)
			var/image/B=image(icon='turfs.dmi',icon_state="02",pixel_y=0,pixel_x=16,layer=50)
			var/image/C=image(icon='turfs.dmi',icon_state="03",pixel_y=32,pixel_x=-16,layer=50)
			var/image/D=image(icon='turfs.dmi',icon_state="04",pixel_y=32,pixel_x=16,layer=50)
			overlays.Remove(A,B,C,D)
			overlays.Add(A,B,C,D)
			//..()
	Tree
		density=1
		icon='turfs.dmi'
		icon_state="bottom"
		New()
			var/image/B=image(icon='turfs.dmi',icon_state="middle",pixel_y=32,pixel_x=0,layer=50)
			var/image/C=image(icon='turfs.dmi',icon_state="top",pixel_y=64,pixel_x=0,layer=50)
			overlays.Remove(B,C)
			overlays.Add(B,C)
			//..()
	Palm
		density=1
		New()
			var/image/A=image(icon='Trees2.dmi',icon_state="1",pixel_y=0,pixel_x=-16,layer=50)
			var/image/B=image(icon='Trees2.dmi',icon_state="2",pixel_y=0,pixel_x=16,layer=50)
			var/image/C=image(icon='Trees2.dmi',icon_state="3",pixel_y=32,pixel_x=-16,layer=50)
			var/image/D=image(icon='Trees2.dmi',icon_state="4",pixel_y=32,pixel_x=16,layer=50)
			var/image/E=image(icon='Trees2.dmi',icon_state="5",pixel_y=64,pixel_x=-16,layer=50)
			var/image/F=image(icon='Trees2.dmi',icon_state="6",pixel_y=64,pixel_x=16,layer=50)
			var/image/G=image(icon='Trees2.dmi',icon_state="7",pixel_y=96,pixel_x=-16,layer=50)
			var/image/H=image(icon='Trees2.dmi',icon_state="8",pixel_y=96,pixel_x=16,layer=50)
			overlays.Remove(A,B,C,D,E,F,G,H)
			overlays.Add(A,B,C,D,E,F,G,H)
			//..()
	LargePine
		density=1
		New()
			var/image/A=image(icon='Tree Good.dmi',icon_state="1",pixel_y=0,pixel_x=-16,layer=50)
			var/image/B=image(icon='Tree Good.dmi',icon_state="2",pixel_y=0,pixel_x=16,layer=50)
			var/image/C=image(icon='Tree Good.dmi',icon_state="3",pixel_y=32,pixel_x=-16,layer=50)
			var/image/D=image(icon='Tree Good.dmi',icon_state="4",pixel_y=32,pixel_x=16,layer=50)
			var/image/E=image(icon='Tree Good.dmi',icon_state="5",pixel_y=64,pixel_x=-16,layer=50)
			var/image/F=image(icon='Tree Good.dmi',icon_state="6",pixel_y=64,pixel_x=16,layer=50)
			overlays.Remove(A,B,C,D,E,F)
			overlays.Add(A,B,C,D,E,F)
			//..()
	LargePineSnow
		density=1
		New()
			var/image/A=image(icon='Tree GoodSnow.dmi',icon_state="1",pixel_y=0,pixel_x=-16,layer=50)
			var/image/B=image(icon='Tree GoodSnow.dmi',icon_state="2",pixel_y=0,pixel_x=16,layer=50)
			var/image/C=image(icon='Tree GoodSnow.dmi',icon_state="3",pixel_y=32,pixel_x=-16,layer=50)
			var/image/D=image(icon='Tree GoodSnow.dmi',icon_state="4",pixel_y=32,pixel_x=16,layer=50)
			var/image/E=image(icon='Tree GoodSnow.dmi',icon_state="5",pixel_y=64,pixel_x=-16,layer=50)
			var/image/F=image(icon='Tree GoodSnow.dmi',icon_state="6",pixel_y=64,pixel_x=16,layer=50)
			overlays.Remove(A,B,C,D,E,F)
			overlays.Add(A,B,C,D,E,F)
			//..()
	RedPine
		density=1
		New()
			var/image/A=image(icon='Tree Red.dmi',icon_state="1",pixel_y=0,pixel_x=-16,layer=50)
			var/image/B=image(icon='Tree Red.dmi',icon_state="2",pixel_y=0,pixel_x=16,layer=50)
			var/image/C=image(icon='Tree Red.dmi',icon_state="3",pixel_y=32,pixel_x=-16,layer=50)
			var/image/D=image(icon='Tree Red.dmi',icon_state="4",pixel_y=32,pixel_x=16,layer=50)
			var/image/E=image(icon='Tree Red.dmi',icon_state="5",pixel_y=64,pixel_x=-16,layer=50)
			var/image/F=image(icon='Tree Red.dmi',icon_state="6",pixel_y=64,pixel_x=16,layer=50)
			overlays.Remove(A,B,C,D,E,F)
			overlays.Add(A,B,C,D,E,F)
			//..()
	TallBush
		density=1
		icon='Turf3.dmi'
		icon_state="tallplantbottom"
		density=1
		New()
			var/image/A=image(icon='Turf3.dmi',icon_state="tallplanttop",pixel_y=32,layer=50)
			overlays.Remove(A)
			overlays.Add(A)
			//..()
	NamekTree
		density=1
		New()
			overlays=null
			switch(pick(1,2,3,4))
				if(1)
					var/image/A=image(icon='turfs.dmi',icon_state="nt2",pixel_y=32,layer=50)
					var/image/B=image(icon='turfs.dmi',icon_state="nt1")
					overlays.Add(A,B)
				if(2)
					var/image/A=image(icon='Trees Namek.dmi',icon_state="1 Bottom")
					var/image/B=image(icon='Trees Namek.dmi',icon_state="1 Middle",pixel_y=32)
					var/image/C=image(icon='Trees Namek.dmi',icon_state="1 Top",pixel_y=64)
					overlays.Add(A,B,C)
				if(3)
					var/image/A=image(icon='Trees Namek.dmi',icon_state="2.0")
					var/image/B=image(icon='Trees Namek.dmi',icon_state="2.1",pixel_y=32)
					var/image/C=image(icon='Trees Namek.dmi',icon_state="2.2",pixel_y=64)
					var/image/D=image(icon='Trees Namek.dmi',icon_state="2.3",pixel_y=64,pixel_x=32)
					overlays.Add(A,B,C,D)
				if(4)
					var/image/A=image(icon='Trees Namek.dmi',icon_state="1")
					var/image/B=image(icon='Trees Namek.dmi',icon_state="2",pixel_y=32)
					var/image/C=image(icon='Trees Namek.dmi',icon_state="3",pixel_y=64)
					var/image/D=image(icon='Trees Namek.dmi',icon_state="4",pixel_y=32,pixel_x=32)
					var/image/E=image(icon='Trees Namek.dmi',icon_state="5",pixel_y=64,pixel_x=32)
					overlays.Add(A,B,C,D,E)

obj/Edges
	Savable=0
	Buildable=1
	Grabbable=0
	Shockwaveable=0
	RockEdgeN
		icon='Edges1.dmi'
		icon_state="N"
		dir=NORTH
	RockEdgeW
		icon='Edges1.dmi'
		icon_state="W"
		dir=WEST
	RockEdgeE
		icon='Edges1.dmi'
		icon_state="E"
		dir=EAST
	RockEdge2N
		icon='Edges2.dmi'
		icon_state="N"
		dir=NORTH
	RockEdge2W
		icon='Edges2.dmi'
		icon_state="W"
		dir=WEST
	RockEdge2E
		icon='Edges2.dmi'
		icon_state="E"
		dir=EAST
	Edge3N
		icon='Edges3.dmi'
		icon_state="N"
		dir=NORTH
	Edge3W
		icon='Edges3.dmi'
		icon_state="W"
		dir=WEST
	Edge3E
		icon='Edges3.dmi'
		icon_state="E"
		dir=EAST
	Edge4N
		icon='Edges4.dmi'
		icon_state="N"
		dir=NORTH
	Edge4W
		icon='Edges4.dmi'
		icon_state="W"
		dir=WEST
	Edge4E
		icon='Edges4.dmi'
		icon_state="E"
		dir=EAST
	Edge5N
		icon='Edges5.dmi'
		icon_state="N"
		dir=NORTH
	Edge5W
		icon='Edges5.dmi'
		icon_state="W"
		dir=WEST
	Edge5E
		icon='Edges5.dmi'
		icon_state="E"
		dir=EAST
	Edge6N
		icon='Edges6.dmi'
		icon_state="N"
		dir=NORTH
	Edge6W
		icon='Edges6.dmi'
		icon_state="W"
		dir=WEST
	Edge6E
		icon='Edges6.dmi'
		icon_state="E"
		dir=EAST


turf/Other
	New()
		if(type==/turf/Other) Buildable=0
		//..()
	Lava
		icon='turfs.dmi'
		icon_state="lava"
//	      luminosity=2
		Water=1
		Enter(mob/M)
			if(ismob(M)) if(M.icon_state=="Flight"|!M.density) return ..()
			else return ..()
	UndergroundTunnelable1
		icon='Turfs 4.dmi'
		icon_state="wall"
		density=1
		opacity=1
		FlyOverAble=0
		Buildable=0
		Health=100000
		Enter(mob/M)
			if(ismob(M))
				if(M.client && M.client.holder) return ..()
				else return
		//      else if(!istype(M,/obj/Blast/Fireball)) del(M)

		/*		      for(var/obj/items/Digging/Hand_Drill/A in usr.contents)
				if(ismob(M))
					if(M.client && M.client.holder) return ..()
				if(usr.Dead==0&&A.suffix=="*Equipped*")
					Health-=100000
				else return
*/
	Blank
		opacity=1
		Buildable=0
		Enter(mob/M)
			if(ismob(M))
				if(M.client && M.client.holder)
					return ..()
				else
					return
			else if(!istype(M,/obj/ranged/Blast/Fireball)||istype(M,/obj/AndroidShips/Ship))
				del(M)
	Glass_Unflyable
		icon='Space.dmi'
		icon_state="glass1"
		density=1
		FlyOverAble=0
		Buildable=0
		layer=MOB_LAYER+1
		Health=9999999999999
	Abyss
		icon='Hell turf.dmi'
		Water=1
		Buildable=0
		Enter(mob/M)
			if(ismob(M)) if(M.icon_state=="Flight"||!M.density) return ..()
			else return ..()

	MountainCave
		density=1
		icon='Turf1.dmi'
		icon_state="mtn cave"
		Buildable=0
	Stars
		icon='Space.dmi'
		icon_state="placeholder"
		Buildable=0
		Health=1.#INF
		New()
			icon_state = "[rand(1,25)]"
			..()
	Orb
		icon='Turf1.dmi'
		icon_state="spirit"
		density=0
		Buildable=0
	Ladder
		icon='Turf1.dmi'
		icon_state="ladder"
		density=0
		Buildable=0
	Sky1
		New()
			var/turf/Terrain/Sky/Sky1/_turf = new(locate(src.x,src.y,src.z))
			Turfs-=src
			Turfs+=_turf
			del(src)


	Sky2
		New()
			var/turf/Terrain/Sky/Sky2/_turf = new(locate(src.x,src.y,src.z))
			Turfs-=src
			Turfs+=_turf
			del(src)


turf
	Bridge1V
		icon='Turf 50.dmi'
		icon_state="1.8"
	Bridge1H
		icon='Turf 50.dmi'
		icon_state="3.3"
	Bridge2V
		icon='Turf 57.dmi'
		icon_state="26"
	Bridge2H
		icon='Turf 57.dmi'
		icon_state="123"
	Bridge1V
		icon='Turf 50.dmi'
		icon_state="1.8"
	Bridge1H
		icon='Turf 50.dmi'
		icon_state="3.3"
	Bridge2V
		icon='Turf 57.dmi'
		icon_state="26"
	Bridge2H
		icon='Turf 57.dmi'
		icon_state="123"
	GroundDirt
		icon='Turfs 14.dmi'
		icon_state="Dirt"
	GroundIce
		icon='Turf 57.dmi'
		icon_state="8"
	GroundIce2
		icon='Turf 55.dmi'
		icon_state="ice"
	GroundDirtSand
		icon='Turfs 96.dmi'
		icon_state="dirt"
	GroundSnow icon='Turf Snow.dmi'
	Ground4
		icon='Turfs 12.dmi'
		icon_state="desert"
	Ground10
		icon='Turf1.dmi'
		icon_state="light desert"
	Ground17
		icon='Turfs1.dmi'
		icon_state="dirt2"
	Ground18
		icon='turfs.dmi'
		icon_state="hellfloor"
	Ground19
		icon='Turfs 96.dmi'
		icon_state="darktile"
	GroundIce3
		icon='Turfs 12.dmi'
		icon_state="ice"
	GroundHell
		icon='Turf 57.dmi'
		icon_state="hellturf1"
	Ground16
		icon='FloorsLAWL.dmi'
		icon_state="Flagstone"
	Ground12
		icon='Turfs 1.dmi'
		icon_state="dirt"
	Ground13
		icon='Turfs 1.dmi'
		icon_state="rock"
		density=1
	GroundPebbles
		icon='Turfs 7.dmi'
		icon_state="Sand"
	Ground11
		icon='Turfs 1.dmi'
		icon_state="crack"
		density=1
	GroundSandDark
		icon='Turf1.dmi'
		icon_state="dark desert"
		density=0
	Ground3
		icon='Turf1.dmi'
		icon_state="very dark desert"
		density=0
	Grass9
		icon='Turfs 96.dmi'
		icon_state="grass d"
	Grass13
		icon='Turf 57.dmi'
		icon_state="grass"
	Grass7
		icon='Turfs 1.dmi'
		icon_state="grass"
	Grass5
		icon='Turfs 14.dmi'
		icon_state="Grass"
	Grass11
		icon='Turfs 1.dmi'
		icon_state="Grass 50"
	Grass12
		icon='Turfs1.dmi'
		icon_state="grassremade"
	Grass1
		icon='Turfs 12.dmi'
		icon_state="grass2"
	Grass8
		icon='Turfs 96.dmi'
		icon_state="grass a"
	GrassNamek
		icon='turfs.dmi'
		icon_state="ngrass"
	Grass2
		icon='Turfs 5.dmi'
		icon_state="grass"
	Grass3
		icon='Turfs 96.dmi'
		icon_state="grass b"
	Grass4
		icon='Turfs 96.dmi'
		icon_state="grass c"
	Grass10
		icon='turfs.dmi'
		icon_state="ngrass"
	Ground14
		icon='Turfs 2.dmi'
		icon_state="desert"
	Grass14
		icon='Turfs 96.dmi'
		icon_state="grass a"
	Grass10
		icon='Turfs 1.dmi'
		icon_state="Grass!"

	TileWood
		icon='Turfs 96.dmi'
		icon_state="woodfloor"
	TileBlue
		icon='turfs.dmi'
		icon_state="tile11"
	Tile26
		icon='turfs.dmi'
		icon_state="tile9"
	Tile25
		icon='Turfs 4.dmi'
		icon_state="cooltiles"
	Tile21
		icon='Turfs 12.dmi'
		icon_state="Girly Carpet"
	Tile23
		icon='Turfs 12.dmi'
		icon_state="Wood_Floor"
	Tile17
		icon='turfs.dmi'
		icon_state="roof4"
	Tile15
		icon='Turfs 12.dmi'
		icon_state="stonefloor"
	Tile6
		icon='Turfs 12.dmi'
		icon_state="floor4"
	Tile14
		icon='turfs.dmi'
		icon_state="tile10"
	Tile22
		icon='FloorsLAWL.dmi'
		icon_state="SS Floor"
	TileStone
		icon='Turf 57.dmi'
		icon_state="55"
	Tile13
		icon='Turfs 1.dmi'
		icon_state="ground"
	TileWood
		icon='Turf 57.dmi'
		icon_state="woodfloor"
	Tile19
		icon='Turfs 12.dmi'
		icon_state="floor2"
	Tile20
		icon='turfs.dmi'
		icon_state="tile4"
	Tile2
		icon='FloorsLAWL.dmi'
		icon_state="Tile"
	Tile12
		icon='Turfs 15.dmi'
		icon_state="floor7"
	TileBlue2
		icon='turfs.dmi'
		icon_state="tile12"
	Tile13
		icon='Turfs 15.dmi'
		icon_state="floor6"
	Tile24
		icon='turfs.dmi'
		icon_state="bridgemid2"
	Tile10
		icon='FloorsLAWL.dmi'
		icon_state="Flagstone Vegeta"
	Tile11
		icon='Turfs 2.dmi'
		icon_state="dirt"
	Tile29
		icon='temptile.dmi'
	Tile30
		icon='Turfs Temple.dmi'
		icon_state="floor"
	Tile31
		icon='Turfs Temple.dmi'
		icon_state="glassfloor"
	Tile32
		icon='Turfs Temple.dmi'
		icon_state="tile"
	Tile33
		icon='Turfs Temple.dmi'
		icon_state="tile2"
	Tile34
		icon='Turfs Temple.dmi'
		icon_state="tile3"
	Tile35
		icon='Turfs Temple.dmi'
		icon_state="tile4"
	Tile36
		icon='floor3.dmi'
	Tile37
		icon='woodfloor1.dmi'
	Tile_Hell1
		icon='Hell turf.dmi'
		icon_state="h1"
	Tile_Hell2
		icon='Hell turf.dmi'
		icon_state="h3"
	Tile_Hell3
		icon='Hell turf.dmi'
		icon_state="h4"
	Tile_Hell4
		icon='Hell turf.dmi'
		icon_state="h5"
	Tile_Hell5
		icon='Hell turf.dmi'
	Tile18
		icon='Turfs 12.dmi'
		icon_state="Aluminum Floor"
	Tile8
		icon='Turfs 1.dmi'
		icon_state="woodenground"
	Tile16
		icon='Turfs 14.dmi'
		icon_state="Stone"
	Tile27
		icon='turfs.dmi'
		icon_state="tile7"
	Tile28
		icon='turfs.dmi'
		icon_state="floor"
	TileGold
		icon='Turf 55.dmi'
		icon_state="goldfloor"
	Tile9
		icon='Turfs 18.dmi'
		icon_state="wooden"
	Tile8
		icon='Turfs 18.dmi'
		icon_state="diagwooden"
	Tile1
		icon='Turfs 12.dmi'
		icon_state="Brick_Floor"
	TileWhite icon='White.dmi'
	Tile2
		icon='Turfs 12.dmi'
		icon_state="Stone Crystal Path"
	Tile3
		icon='Turfs 12.dmi'
		icon_state="Stones"
	Tile4
		icon='Turfs 12.dmi'
		icon_state="Black Tile"
	Tile5
		icon='Turfs 12.dmi'
		icon_state="Dirty Brick"
	MetalFloor
		icon='metaltiles1.dmi'
		icon_state="metalfloora"
	MetalFloorDirty
		icon='metaltiles1.dmi'
		icon_state="metalfloorsn"
	MetalFloorDark
		icon='metaltiles1.dmi'
		icon_state="metalfloorb"
	MetalGrating1
		icon='metaltiles1.dmi'
		icon_state="gratingfloora"
	MetalGrating2
		icon='metaltiles1.dmi'
		icon_state="gratingfloorb"
	Stairs1
		icon='Turfs 96.dmi'
		icon_state="steps"
	StairsHell
		icon='Turf 57.dmi'
		icon_state="hellstairs"
	Stairs4
		icon='Turfs 1.dmi'
		icon_state="stairs1"
	Stairs5
		icon='Turfs 1.dmi'
		icon_state="earthstairs"
	Stairs3
		icon='Turfs 1.dmi'
		icon_state="stairs2"
	Stairs2
		icon='Turfs 12.dmi'
		icon_state="Steps"
	Stairs6
		icon='Turfs Temple.dmi'
		icon_state="council"
	Water6
		icon='Turfs 1.dmi'
		icon_state="water"
		Water=1
		Enter(mob/M)
			if(ismob(M)) if(M.icon_state=="Flight"|!M.density) return ..()
			else return ..()
	WaterReal
		icon='Turfs 96.dmi'
		icon_state="water1"
		Water=1
		Enter(mob/M)
			if(ismob(M)) if(M.icon_state=="Flight"|!M.density) return ..()
			else return ..()
	Water5
		icon='Turfs 4.dmi'
		icon_state="kaiowater"
		Water=1
		Enter(mob/M)
			if(ismob(M)) if(M.icon_state=="Flight"|!M.density) return ..()
			else return ..()
	WaterFall
		icon='Turfs 1.dmi'
		icon_state="waterfall"
		density=1
		layer=MOB_LAYER+1
		Water=1
		Enter(mob/M)
			if(ismob(M)) if(M.icon_state=="Flight"|!M.density) return ..()
			else return ..()
	Water3
		icon='Misc.dmi'
		icon_state="Water"
		Water=1
		Enter(mob/M)
			if(ismob(M)) if(M.icon_state=="Flight"|!M.density) return ..()
			else return ..()
	WaterFast
		icon='water.dmi'
		Water=1
		Enter(mob/M)
			if(ismob(M)) if(M.icon_state=="Flight"|!M.density) return ..()
			else return ..()
	Water8
		icon='turfs.dmi'
		icon_state="nwater"
		Water=1
		Enter(mob/M)
			if(ismob(M)) if(M.icon_state=="Flight"|!M.density) return ..()
			else return ..()
	Water1
		icon='Turfs 12.dmi'
		icon_state="water3"
		Water=1
		Enter(mob/M)
			if(ismob(M)) if(M.icon_state=="Flight"|!M.density) return ..()
			else return ..()
	Water11
		icon='Turfs 12.dmi'
		icon_state="water1"
		Water=1
		Enter(mob/M)
			if(ismob(M)) if(M.icon_state=="Flight"|!M.density) return ..()
			else return ..()
	Water7
		icon='turfs.dmi'
		icon_state="lava"
//	      luminosity=2
		Enter(mob/M)
			if(ismob(M)) if(M.icon_state=="Flight"|!M.density) return ..()
			else return ..()
	Water2
		icon='Turfs 96.dmi'
		icon_state="stillwater"
		Water=1
		Enter(mob/M)
			if(ismob(M)) if(M.icon_state=="Flight"|!M.density) return ..()
			else return ..()
	Water12
		icon='Turfs 12.dmi'
		icon_state="water4"
		Water=1
		Enter(mob/M)
			if(ismob(M)) if(M.icon_state=="Flight"|!M.density) return ..()
			else return ..()
	Water9
		icon='Turfs 12.dmi'
		icon_state="water1"
		Water=1
		Enter(mob/M)
			if(ismob(M)) if(M.icon_state=="Flight"|!M.density) return ..()
			else return ..()
	Water10
		icon='Turf 50.dmi'
		icon_state="9.1"
		Water=1
		Enter(mob/M)
			if(ismob(M)) if(M.icon_state=="Flight"|!M.density) return ..()
			else return ..()

	CaveEntrance
		icon='Turf 57.dmi'
		icon_state="13"

// Upgradable, all turf that can be upgraded and thus, right clicked.
	Upgradeable
	/*
		New()
			var/type = text2path("/turf/Upgradeable/Roofs/[src.name]")
			if(findtextEx("[src.type]","wall"))
				type = text2path("/turf/Upgradeable/Walls/[src.name]")
			var/_turf = new type(locate(src.x,src.y,src.z))
			global.Turfs-=src
			global.Turfs+=_turf
			del(src)
			*/
		Wall21
			icon='Turfs Temple.dmi'
			icon_state="wall2"
			density=1
		Wall12
			icon='Turfs 3.dmi'
			icon_state="cliff"
			density=1
		Wall10
			icon='Turfs 4.dmi'
			icon_state="ice cliff"
			density=1
		Wall8
			icon='Turfs 15.dmi'
			icon_state="wall2"
			density=1
		Wall3
			icon='Turfs 4.dmi'
			icon_state="wall"
			density=1
		Wall17
			icon='Turf 57.dmi'
			icon_state="1"
			density=1
		Wall7
			icon='Turfs 1.dmi'
			icon_state="cliff"
			density=1
		Wall2
			icon='Turfs 1.dmi'
			icon_state="wall6"
			opacity=0
			density=1
		WallSand
			icon='Turf 50.dmi'
			icon_state="3.2"
			density=1
		WallStone
			icon='Turf 57.dmi'
			icon_state="stonewall2"
			density=1
		WallStone2
			icon='Turf 57.dmi'
			icon_state="stonewall4"
			density=1
		WallStone3
			icon='Turfs 96.dmi'
			icon_state="wall3"
			density=1
		WallTech
			icon='Space.dmi'
			icon_state="bottom"
			density=1
		MetalWall1
			icon='metaltiles1.dmi'
			icon_state="metalwalla"
			density=1
		WallDarkTech1
			icon='customtiles1.dmi'
			icon_state="WallTypeA-U"
			density=1
		WallDarkTech2
			icon='customtiles1.dmi'
			icon_state="WallTypeA-L"
			density=1
		MetalWall2
			icon='metaltiles1.dmi'
			icon_state="metalwallb"
			density=1
		Wall18
			icon='Turf 57.dmi'
			icon_state="2"
			density=1
		Wall19
			icon='Turf 57.dmi'
			icon_state="3"
			density=1
		Wall20
			icon='Turf 57.dmi'
			icon_state="6"
			density=1
		Wall13
			icon='turfs.dmi'
			icon_state="wall8"
			density=1
		Wall16
			icon='Turf 50.dmi'
			icon_state="2.6"
			density=1
		Wall11
			icon='Turfs 18.dmi'
			icon_state="stone"
			density=1
		Wall5
			icon='turfs.dmi'
			icon_state="tile1"
			density=1
		Wall6
			icon='Turfs 2.dmi'
			icon_state="brick2"
			density=1
		Wall15
			icon='Turf1.dmi'
			icon_state="1"
			density=1
		Wall1
			icon='turfs.dmi'
			icon_state="tile5"
			density=1
			opacity=0
		Wall_Hell
			icon='Hell turf.dmi'
			icon_state="h2"
			density=1
		RoofTech
			icon='Space.dmi'
			icon_state="top"
			density=1
			opacity=1
			Enter(atom/A)
				if(FlyOverAble||ghostDens_check(A)||(!A.density&&istype(A,/obj/items/Bomb))) return ..()
				else return
		Hell_Roof
			icon='Hell turf.dmi'
			density=1
			opacity=1
			luminosity=1
			Enter(atom/A)
				if(FlyOverAble||ghostDens_check(A)||(!A.density&&istype(A,/obj/items/Bomb))) return ..()
				else return
		Roof1
			icon='Turfs 96.dmi'
			icon_state="roof3"
			density=1
			opacity=1
			luminosity=1
			Enter(atom/A)
				if(FlyOverAble||ghostDens_check(A)||(!A.density&&istype(A,/obj/items/Bomb))) return ..()
				else return
		Roof2
			icon='Turfs.dmi'
			icon_state="roof2"
			density=1
			opacity=1
			luminosity=1
			Enter(atom/A)
				if(FlyOverAble||ghostDens_check(A)||(!A.density&&istype(A,/obj/items/Bomb))) return ..()
				else return
		Roof3
			icon='Turfs 96.dmi'
			icon_state="roof4"
			density=1
			opacity=1
			luminosity=1
			Enter(atom/A)
				if(FlyOverAble||ghostDens_check(A)||(!A.density&&istype(A,/obj/items/Bomb))) return ..()
				else return
		RoofWhite
			icon='turfs.dmi'
			icon_state="block_wall1"
			density=1
			opacity=1
			luminosity=1
			Enter(atom/A)
				if(FlyOverAble||ghostDens_check(A)||(!A.density&&istype(A,/obj/items/Bomb))) return ..()
				else return
		MetalRoof1
			icon='metaltiles1.dmi'
			icon_state="metalroofa"
			density=1
			opacity=1
			luminosity=1
			Enter(atom/A)
				if(FlyOverAble||ghostDens_check(A)||(!A.density&&istype(A,/obj/items/Bomb))) return ..()
				else return
		MetalRoof2
			icon='metaltiles1.dmi'
			icon_state="metalroofb"
			density=1
			opacity=1
			luminosity=1
			Enter(atom/A)
				if(FlyOverAble||ghostDens_check(A)||(!A.density&&istype(A,/obj/items/Bomb))) return ..()
				else return
		MetalRoof3
			icon='metaltiles1.dmi'
			icon_state="metalroofc"
			density=1
			opacity=1
			luminosity=1
			Enter(atom/A)
				if(FlyOverAble||ghostDens_check(A)||(!A.density&&istype(A,/obj/items/Bomb))) return ..()
				else return


obj/Surf
	New()
		var/type = text2path("/obj/Props/Surf/[src.name]")
		var/_turf = new type(locate(src.x,src.y,src.z))
		global.Turfs-=src
		global.Turfs+=_turf
		del(src)

	Water10Surf
	Water10Surf2
	Water9Surf
	Water9Surf2
	Water2Surf
	Water2Surf2
	Water8Surf
	Water8Surf2
	Water3Surf
	Water3Surf2
	Water5Surf
	Water5Surf2
