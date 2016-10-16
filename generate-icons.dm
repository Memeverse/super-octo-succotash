
proc
	__generate_edge_icons(icon_file, mask_file, icon_mask)

		var/icon/master = new()

		var/list/dirs = list(NORTH, SOUTH, EAST, WEST, NORTHEAST, SOUTHEAST, NORTHWEST, SOUTHWEST)

		for(var/icon_state in icon_states(icon_file))

			world << icon_state
			sleep(world.tick_lag)

			var/icon/edge_icon = icon('turf-edges-blank.dmi', "blank")

			for(var/d in dirs)
				var/icon/turf_icon = icon(icon_file, icon_state)
				var/icon/mask_icon = icon(mask_file, icon_mask[icon_state], d)

				for(var/x = 1 to 32)
					for(var/y = 1 to 32)
						var/Color/turf_color = new (turf_icon.GetPixel(x, y))
						var/Color/mask_color = new (mask_icon.GetPixel(x, y))

						turf_color.alpha = 255 - mask_color.red
						turf_icon.DrawBox(turf_color.RGB(), x, y)

				// output the icon state as an indication of progress
				world << "\icon[turf_icon] \c"

				sleep(world.tick_lag)

				edge_icon.Insert(turf_icon, dir = d)

			world << ""

			master.Insert(edge_icon, icon_state)

		return master

proc
	my_text2num(txt, base = 10)
		ASSERT(istext(txt))
		ASSERT(base >= 2)
		ASSERT(base <= 16)

		. = 0

		var/negative = 0
		if(copytext(txt,1,2) == "-")
			txt = copytext(txt,2)
			negative = 1

		txt = uppertext(txt)
		var/list/num_char = list("0"=0,"1"=1,"2"=2,"3"=3,"4"=4,"5"=5,"6"=6,"7"=7,"8"=8,"9"=9,"A"=10,"B"=11,"C"=12,"D"=13,"E"=14,"F"=15)
		for(var/i = 1 to length(txt))
			var/c = copytext(txt,i,i+1)
			if(c in num_char)
				c = num_char[c]
				if(c >= base)
					. = usr
					CRASH("Invalid character '[c]' in base [base] string '[txt]'.")
				. = (base * .) + c
			else
				return null

		if(negative)
			. = -.

Color
	var
		red = 0
		green = 0
		blue = 0
		alpha = 255

	// The constructor has three forms:
	//
	//     new /Color()
	//     new /Color(red, green, blue, [alpha])
	//     new /Color(color_string)
	//
	// For the first form, all RGBA components are initialized
	// to zero.
	// For the second form, the RGBA components are set as you
	// specify. If you leave out the alpha it is set to 255.
	// For the third form the string can be of the form "#RRGGBB"
	// or "#RRGGBBAA".
	New(a, b = 0, c = 0, d = 255)
		if(istext(a))
			red = my_text2num(copytext(a,2,4),16)
			green = my_text2num(copytext(a,4,6),16)
			blue = my_text2num(copytext(a,6,8),16)
			if(length(a) > 7)
				alpha = my_text2num(copytext(a,8,10),16)

		else if(isnum(a))
			red = a
			green = b
			blue = c
			alpha = d
		else if(isnull(a))
			alpha = 0

	proc
		RGB()
			if(alpha >= 0)
				return rgb(red, green, blue, alpha)
			return rgb(red, green, blue)