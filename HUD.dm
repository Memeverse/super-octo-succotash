mob
	proc
		Creation()
			var/obj/HUD/name_box/n = new
			src.name_box = n
			var/obj/HUD/background/back = new
			usr.client.screen += back

			var/obj/HUD/borders/border_north/b1 = new
			var/obj/HUD/borders/border_south/b2 = new
			var/obj/HUD/borders/border_east/b3 = new
			var/obj/HUD/borders/border_west/b4 = new
			usr.client.screen += b1
			usr.client.screen += b2
			usr.client.screen += b3
			usr.client.screen += b4

			var/obj/HUD/boxes/box_saiyan/box_s = new
			usr.client.screen += box_s
			var/obj/HUD/boxes/box_human/box_h = new
			usr.client.screen += box_h
			var/obj/HUD/boxes/box_doll/box_d = new
			usr.client.screen += box_d
			var/obj/HUD/boxes/box_makyo/box_m = new
			usr.client.screen += box_m
			var/obj/HUD/boxes/box_changeling/box_c = new
			usr.client.screen += box_c
			var/obj/HUD/boxes/box_namek/box_n = new
			usr.client.screen += box_n
			var/obj/HUD/boxes/box_demon/box_de = new
			usr.client.screen += box_de
			var/obj/HUD/boxes/box_kaio/box_k = new
			usr.client.screen += box_k
			var/obj/HUD/boxes/box_oni/box_o = new
			usr.client.screen += box_o
			var/obj/HUD/boxes/box_demi/box_demi = new
			usr.client.screen += box_demi
			var/obj/HUD/boxes/box_tuffle/box_t = new
			usr.client.screen += box_t
			var/obj/HUD/boxes/box_droid/box_dr = new
			usr.client.screen += box_dr
			var/obj/HUD/boxes/box_egg/box_egg = new
			usr.client.screen += box_egg
mob
	var
		name_box
obj
	var
	 X = 0
	 Y = 0
	HUD
		name_box
			icon = 'HUD name box.dmi'
			layer = 102
		background
			icon = 'HUD.dmi'
			icon_state = "back"
			layer = 100
			screen_loc = "2,2 to 10,10"
		borders
			layer = 101
			icon = 'HUD.dmi'
			border_north
				icon_state = "border north"
				screen_loc = "2,10 to 10,10"
			border_south
				icon_state = "border south"
				screen_loc = "2,2 to 10,2"
			border_east
				icon_state = "border east"
				screen_loc = "10,2 to 10,10"
			border_west
				icon_state = "border west"
				screen_loc = "2,2 to 2,10"
		boxes
			layer = 101
			box_saiyan
				icon = 'HUD.dmi'
				icon_state = "box"
				screen_loc = "3,9"
				Click()
					src.icon_state = "box ticked"
				MouseEntered(location,control,params)
					var/obj/n = usr.name_box
					n.screen_loc = "[src.X+1],[src.Y]"
					var/image/O = new
					O.maptext = "Saiyan"
					O.maptext_width = 128
					O.maptext_height = 128
					O.pixel_y = 9
					O.pixel_x = 28
					O.layer = FLOAT_LAYER
					n.overlays += O
					usr.client.screen += n
				MouseExited(location,control,params)
					var/obj/O = usr.name_box
					O.overlays = null
					usr.client.screen -= O
				New()
					src.X = 3
					src.Y = 9
					src.overlays += 'Tan male.dmi'
					src.overlays += 'Tail.dmi'
					src.overlays += 'Hair_Goku.dmi'

			box_human
				icon = 'HUD.dmi'
				icon_state = "box"
				screen_loc = "5,9"
				Click()
					src.icon_state = "box ticked"
				MouseEntered(location,control,params)
					var/obj/n = usr.name_box
					n.screen_loc = "[src.X+1],[src.Y]"
					var/image/O = new
					O.maptext = "Human"
					O.maptext_width = 128
					O.maptext_height = 128
					O.pixel_y = 9
					O.pixel_x = 28
					O.layer = FLOAT_LAYER
					n.overlays += O
					usr.client.screen += n
				MouseExited(location,control,params)
					var/obj/O = usr.name_box
					O.overlays = null
					usr.client.screen -= O
				New()
					src.X = 5
					src.Y = 9
					src.overlays += 'Tan male.dmi'
					src.overlays += 'Hair_Yamcha.dmi'
			box_doll
				icon = 'HUD.dmi'
				icon_state = "box"
				screen_loc = "7,9"
				Click()
					src.icon_state = "box ticked"
				MouseEntered(location,control,params)
					var/obj/n = usr.name_box
					n.screen_loc = "[src.X+1],[src.Y]"
					var/image/O = new
					O.maptext = "Spirit Doll"
					O.maptext_width = 128
					O.maptext_height = 128
					O.pixel_y = 9
					O.pixel_x = 20
					O.layer = FLOAT_LAYER
					n.overlays += O
					usr.client.screen += n
				MouseExited(location,control,params)
					var/obj/O = usr.name_box
					O.overlays = null
					usr.client.screen -= O
				New()
					src.X = 7
					src.Y = 9
					src.overlays += 'Spirit Doll.dmi'
			box_makyo
				icon = 'HUD.dmi'
				icon_state = "box"
				screen_loc = "9,9"
				Click()
					src.icon_state = "box ticked"
				MouseEntered(location,control,params)
					var/obj/n = usr.name_box
					n.screen_loc = "[src.X-3],[src.Y]"
					var/image/O = new
					O.maptext = "Makyojin"
					O.maptext_width = 128
					O.maptext_height = 128
					O.pixel_y = 9
					O.pixel_x = 22
					O.layer = FLOAT_LAYER
					n.overlays += O
					usr.client.screen += n
				MouseExited(location,control,params)
					var/obj/O = usr.name_box
					O.overlays = null
					usr.client.screen -= O
				New()
					src.X = 9
					src.Y = 9
					src.overlays += 'Makyojin 2.dmi'
			box_changeling
				icon = 'HUD.dmi'
				icon_state = "box"
				screen_loc = "3,7"
				Click()
					src.icon_state = "box ticked"
				MouseEntered(location,control,params)
					var/obj/n = usr.name_box
					n.screen_loc = "[src.X+1],[src.Y]"
					var/image/O = new
					O.maptext = "Changeling"
					O.maptext_width = 128
					O.maptext_height = 128
					O.pixel_y = 9
					O.pixel_x = 16
					O.layer = FLOAT_LAYER
					n.overlays += O
					usr.client.screen += n
				MouseExited(location,control,params)
					var/obj/O = usr.name_box
					O.overlays = null
					usr.client.screen -= O
				New()
					src.X = 3
					src.Y = 7
					src.overlays += 'C1.dmi'
			box_namek
				icon = 'HUD.dmi'
				icon_state = "box"
				screen_loc = "5,7"
				Click()
					src.icon_state = "box ticked"
				MouseEntered(location,control,params)
					var/obj/n = usr.name_box
					n.screen_loc = "[src.X+1],[src.Y]"
					var/image/O = new
					O.maptext = "Namekian"
					O.maptext_width = 128
					O.maptext_height = 128
					O.pixel_y = 9
					O.pixel_x = 20
					O.layer = FLOAT_LAYER
					n.overlays += O
					usr.client.screen += n
				MouseExited(location,control,params)
					var/obj/O = usr.name_box
					O.overlays = null
					usr.client.screen -= O
				New()
					src.X = 5
					src.Y = 7
					src.overlays += 'Namek Adult.dmi'
			box_demon
				icon = 'HUD.dmi'
				icon_state = "box"
				screen_loc = "7,7"
				Click()
					src.icon_state = "box ticked"
				MouseEntered(location,control,params)
					var/obj/n = usr.name_box
					n.screen_loc = "[src.X+1],[src.Y]"
					var/image/O = new
					O.maptext = "Demon"
					O.maptext_width = 128
					O.maptext_height = 128
					O.pixel_y = 9
					O.pixel_x = 28
					O.layer = FLOAT_LAYER
					n.overlays += O
					usr.client.screen += n
				MouseExited(location,control,params)
					var/obj/O = usr.name_box
					O.overlays = null
					usr.client.screen -= O
				New()
					src.X = 7
					src.Y = 7
					src.overlays += 'Demon1.dmi'
			box_kaio
				icon = 'HUD.dmi'
				icon_state = "box"
				screen_loc = "9,7"
				Click()
					src.icon_state = "box ticked"
				MouseEntered(location,control,params)
					var/obj/n = usr.name_box
					n.screen_loc = "[src.X-3],[src.Y]"
					var/image/O = new
					O.maptext = "Kaio"
					O.maptext_width = 128
					O.maptext_height = 128
					O.pixel_y = 9
					O.pixel_x = 33
					O.layer = FLOAT_LAYER
					n.overlays += O
					usr.client.screen += n
				MouseExited(location,control,params)
					var/obj/O = usr.name_box
					O.overlays = null
					usr.client.screen -= O
				New()
					src.X = 9
					src.Y = 7
					src.overlays += 'Tan male.dmi'
					var/obj/HUD/H = new
					H.icon = 'Hair_Mohawk.dmi'
					H.icon += rgb(100,100,100)
					src.overlays += H.icon
					src.overlays += 'Clothes_KaioSuit.dmi'
					del(H)
			box_oni
				icon = 'HUD.dmi'
				icon_state = "box"
				screen_loc = "3,5"
				Click()
					src.icon_state = "box ticked"
				MouseEntered(location,control,params)
					var/obj/n = usr.name_box
					n.screen_loc = "[src.X+1],[src.Y]"
					var/image/O = new
					O.maptext = "Oni"
					O.maptext_width = 128
					O.maptext_height = 128
					O.pixel_y = 9
					O.pixel_x = 33
					O.layer = FLOAT_LAYER
					n.overlays += O
					usr.client.screen += n
				MouseExited(location,control,params)
					var/obj/O = usr.name_box
					O.overlays = null
					usr.client.screen -= O
				New()
					src.X = 3
					src.Y = 5
					src.overlays += 'Blue Oni.dmi'
			box_demi
				icon = 'HUD.dmi'
				icon_state = "box"
				screen_loc = "5,5"
				Click()
					src.icon_state = "box ticked"
				MouseEntered(location,control,params)
					var/obj/n = usr.name_box
					n.screen_loc = "[src.X+1],[src.Y]"
					var/image/O = new
					O.maptext = "Demigod"
					O.maptext_width = 128
					O.maptext_height = 128
					O.pixel_y = 9
					O.pixel_x = 22
					O.layer = FLOAT_LAYER
					n.overlays += O
					usr.client.screen += n
				MouseExited(location,control,params)
					var/obj/O = usr.name_box
					O.overlays = null
					usr.client.screen -= O
				New()
					src.X = 5
					src.Y = 5
					src.overlays += 'Tan male.dmi'
					src.overlays += 'Hair_Gohan.dmi'
			box_tuffle
				icon = 'HUD.dmi'
				icon_state = "box"
				screen_loc = "7,5"
				Click()
					src.icon_state = "box ticked"
				MouseEntered(location,control,params)
					var/obj/n = usr.name_box
					n.screen_loc = "[src.X+1],[src.Y]"
					var/image/O = new
					O.maptext = "Tsufurujin"
					O.maptext_width = 128
					O.maptext_height = 128
					O.pixel_y = 9
					O.pixel_x = 22
					O.layer = FLOAT_LAYER
					n.overlays += O
					usr.client.screen += n
				MouseExited(location,control,params)
					var/obj/O = usr.name_box
					O.overlays = null
					usr.client.screen -= O
				New()
					src.X = 7
					src.Y = 5
					src.overlays += 'Tan male.dmi'
					src.overlays += 'Hair, Bushy.dmi'
					src.overlays += 'TaranianEars.dmi'
			box_droid
				icon = 'HUD.dmi'
				icon_state = "box"
				screen_loc = "9,5"
				Click()
					src.icon_state = "box ticked"
				MouseEntered(location,control,params)
					var/obj/n = usr.name_box
					n.screen_loc = "[src.X-3],[src.Y]"
					var/image/O = new
					O.maptext = "Android"
					O.maptext_width = 128
					O.maptext_height = 128
					O.pixel_y = 9
					O.pixel_x = 22
					O.layer = FLOAT_LAYER
					n.overlays += O
					usr.client.screen += n
				MouseExited(location,control,params)
					var/obj/O = usr.name_box
					O.overlays = null
					usr.client.screen -= O
				New()
					src.X = 9
					src.Y = 5
					src.overlays += 'Android.dmi'
			box_egg
				icon = 'HUD.dmi'
				icon_state = "box"
				screen_loc = "6,3"
				Click()
					src.icon_state = "box ticked"
				MouseEntered(location,control,params)
					var/obj/n = usr.name_box
					n.screen_loc = "[src.X+1],[src.Y]"
					var/image/O = new
					O.maptext = "Baby"
					O.maptext_width = 128
					O.maptext_height = 128
					O.pixel_y = 9
					O.pixel_x = 22
					O.layer = FLOAT_LAYER
					n.overlays += O
					usr.client.screen += n
				MouseExited(location,control,params)
					var/obj/O = usr.name_box
					O.overlays = null
					usr.client.screen -= O
				New()
					src.X = 6
					src.Y = 3
					src.overlays += 'Egg.dmi'