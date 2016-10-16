atom/movable/var
	tmp/turf/Spawn_Location
	Spawn_Timer=0
/*atom/movable/New()
	if(Spawn_Timer) Spawn_Location=loc
	..()
atom/movable/Del()
	if(Spawn_Timer&&Spawn_Location&&!Builder) Remake(type,Spawn_Location,Spawn_Timer)
	Spawn_Location=null
	..()*/
proc/Remake(Type,turf/Location,Timer) spawn(Timer) if(!Location.Builder)
	for(var/obj/A in Location) return
	new Type(Location)

/*
obj/Write(savefile/F)

	log_errors("Obj/Write called from/by [src] [src.type]")

	var/list/OldOverlays=new
	OldOverlays.Add(overlays)
	overlays-=overlays
	..()
	overlays.Add(OldOverlays)
*/

obj/Props
	Savable=0
	layer=4
	Spawn_Timer=180000
	Buildable = 1
		GlassDoor
			icon = 'GlassDoors.dmi'
			icon_state = "Closed"
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
				flick("Opening",src)	//Wait until door opens to let people through
				icon_state = "Open"
				density = 0
				opacity = 0
				//src.sd_SetOpacity(0)
				//sd_ObjSpillLight(src)
				spawn(50)
					Close()
			Close()
				flick("Closing",src)	//Wait until door closes to actually be dense
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
	bleft
		icon = 'Skyscraper.dmi'
		icon_state = "bleft"
	bright
		icon = 'Skyscraper.dmi'
		icon_state = "bright"
	TopC
		icon = 'Street.dmi'
		icon_state = "TopC"

	LeftC
		icon = 'Street.dmi'
		icon_state = "LeftC"

	RightC
		icon = 'Street.dmi'
		icon_state = "RightC"

	BottomC
		icon = 'Street.dmi'
		icon_state = "BottomC"

	C_Horiz
		icon = 'Street.dmi'
		icon_state = "C_Horiz"

	C_Vert
		icon = 'Street.dmi'
		icon_state = "C_Vert"


	TLV_L
		icon = 'Street.dmi'
		icon_state = "TLV_L"

	TLV_R
		icon = 'Street.dmi'
		icon_state = "TLV_R"

	TLH_T
		icon = 'Street.dmi'
		icon_state = "TLH_T"

	TLH_B
		icon = 'Street.dmi'
		icon_state = "TLH_B"

	LW_L
		icon = 'Street.dmi'
		icon_state = "LW_L"

	LW_R
		icon = 'Street.dmi'
		icon_state = "LW_R"

	LW_T
		icon = 'Street.dmi'
		icon_state = "LW_T"

	LW_B
		icon = 'Street.dmi'
		icon_state = "LW_B"

	LWE_B
		icon = 'Street.dmi'
		icon_state = "LWE_B"

	LWE_T
		icon = 'Street.dmi'
		icon_state = "LWE_T"

	LWE_R
		icon = 'Street.dmi'
		icon_state = "LWE_R"

	LWE_L
		icon = 'Street.dmi'
		icon_state = "LWE_L"
	Glass_B
		icon = 'Skyscraper.dmi'
		icon_state = "Glass"
	Glass_S
		icon = 'Skyscraper.dmi'
		icon_state = "Glass_S"
	Glass_S2
		icon = 'Skyscraper.dmi'
		icon_state = "Glass_S2"
	Glass_S3
		icon = 'Skyscraper.dmi'
		icon_state = "Glass_S3"

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
	//	New()
	//		var/image/A=image(icon='New Throne.dmi',icon_state="",pixel_y=32,layer=MOB_LAYER+1)
	//		overlays+=A
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

turf/var/Water

var/HBTC_Open

turf/Other
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

turf/Special

	Buildable=0

	Teleporter
		density=1
		var/gotox
		var/gotoy
		var/gotoz
		Enter(mob/M) M.loc=locate(gotox,gotoy,gotoz)

	EnterHBTC/Enter(mob/A)

		if(ismob(A))
			if(A.HBTC_Enters<2)
				A.HBTC_Enters++
				A.loc=locate(258,274,10)
				HBTC_Open=1
				HBTC()
			else if(ismob(A)) A<<"You cannot enter the time chamber more than twice a lifetime"

	ExitHBTC/Enter(mob/A) if(HBTC_Open) A.loc=locate(128,1,2)

proc/HBTC()
	for(var/mob/player/A in Players) if(A.z==10) A<<"The time chamber will remain open for one hour, \
	if you do not exit before then you will be trapped until someone enters the time chamber again, \
	and you will continue aging at ten times the normal rate until you exit"
	sleep(6000)
	for(var/mob/player/A in Players) if(A.z==10) A<<"The time chamber will be unlocked for 50 more minutes"
	sleep(6000)
	for(var/mob/player/A in Players) if(A.z==10) A<<"The time chamber will be unlocked for 40 more minutes"
	sleep(6000)
	for(var/mob/player/A in Players) if(A.z==10) A<<"The time chamber will be unlocked for 30 more minutes"
	sleep(6000)
	for(var/mob/player/A in Players) if(A.z==10) A<<"The time chamber will be unlocked for 20 more minutes"
	sleep(6000)
	for(var/mob/player/A in Players) if(A.z==10) A<<"The time chamber will be unlocked for 10 more minutes"
	sleep(3000)
	for(var/mob/player/A in Players) if(A.z==10) A<<"The time chamber will be unlocked for 5 more minutes"
	sleep(2400)
	for(var/mob/player/A in Players) if(A.z==10) A<<"The time chamber will remain unlocked for ONE more minute"
	sleep(600)
	for(var/mob/player/A in Players) if(A.z==10) A<<"The time chamber exit disappears. You are now trapped"
	HBTC_Open=0

turf
	var/tmp/DestroyedBy=null
	FWall
		icon = 'walltest.dmi'
		icon_state = "Framed"
		density = 1

	Grass
		icon = 'grass.dmi'

	RoofExtension
		icon = 'Roofs.dmi'
		icon_state = "RoofExtension"

	RoofTop
		icon = 'Roofs.dmi'
		icon_state = "RoofTop"

	Roof_Horizontal
		icon = 'Roofs.dmi'
		icon_state = "Horizontal"

	RoofLedge
		icon = 'Roofs.dmi'
		icon_state = "RoofLedge"

	RDirRight
		icon = 'Roofs.dmi'
		icon_state = "RDirRight"

	BlankTile
		icon = 'Tiles.dmi'
		icon_state = "Blank Tile"

	Shadow
		icon = 'Tiles.dmi'
		icon_state = "Shadow"

	Sidewalk
		icon = 'Sidewalk.dmi'
	Sidewalk_T
		icon = 'Sidewalk.dmi'
		icon_state = "STop"

	Street
		icon = 'Street.dmi'

	Street_T
		icon = 'Street.dmi'
		icon_state = "Top"

	Street_B
		icon = 'Street.dmi'
		icon_state = "Bottom"
	Street_L
		icon = 'Street.dmi'
		icon_state = "Left"
	Street_R
		icon = 'Street.dmi'
		icon_state = "Right"


	Wall_B
		icon = 'Skyscraper.dmi'
		icon_state = "Wall"


	ChainLink_M
		icon = 'Urban.dmi'
		icon_state = "ChainLink_M"

	ChainLink_T
		icon = 'Urban.dmi'
		icon_state = "ChainLink_T"

	ChainLink_P
		icon = 'Urban.dmi'
		icon_state = "ChainLink_P"

	ChainLink_PL
		icon = 'Urban.dmi'
		icon_state = "ChainLink_PL"

	ChainLink_PR
		icon = 'Urban.dmi'
		icon_state = "ChainLink_PR"
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




// Upgradable, all turf that can be upgraded and thus, right clicked.
	Upgradeable
		Wall
		icon = 'walltest.dmi'
		density = 1

		BottomWall
			icon = 'walltest.dmi'
			icon_state = "BottomWall"
			density = 1

		MidWall
			icon = 'walltest.dmi'
			icon_state = "MidWall"
			density = 1

		TopWall
			icon = 'walltest.dmi'
			icon_state = "TopWall"
			density = 1

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
	layer=2
	Savable=0
	Spawn_Timer=180000
	Grabbable=0
	Shockwaveable=0
	Water10Surf
		icon='Surf1.dmi'
	Water10Surf2
		icon='Surf1.dmi'
		icon_state="N"
	Water9Surf
		icon='Surf6.dmi'
	Water9Surf2
		icon='Surf6.dmi'
		icon_state="N"
	Water2Surf
		icon='Surf2.dmi'
	Water2Surf2
		icon='Surf2.dmi'
		icon_state="N"
	Water8Surf
		icon='Surf4.dmi'
	Water8Surf2
		icon='Surf4.dmi'
		icon_state="N"
	Water3Surf
		icon='Surf3.dmi'
	Water3Surf2
		icon='Surf3.dmi'
		icon_state="N"
	Water5Surf
		icon='Surf5.dmi'
	Water5Surf2
		icon='Surf5.dmi'
		icon_state="S"


obj/Explosion
	icon='Explosion.dmi'
	layer=MOB_LAYER+1
	luminosity=8
	New()
		pixel_x=rand(-8,8)
		pixel_y=rand(-8,8)
		spawn(rand(4,6)) if(src) del(src)
		//..()