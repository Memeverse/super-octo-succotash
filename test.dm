//get_speed_delay(n) takes an argument speed "n" and returns how long it would take to travel 1 tile at this speed in 10ths of a second
proc/get_speed_delay(n)
	return (world.icon_size * world.tick_lag) / (!n ? 1 : n)

//get_glide_size(n, dir) takes an argument speed "n", and direction "dir", and returns the smoothest possible glide_size setting
proc/get_glide_size(n, dir)
	return (dir & (dir - 1)) ? n + (n >> 1) : n

atom/movable
	var/speed = 4
	var/tmp/move_time = 0
	var/tmp/transferring = 0
	var/moves = 0

	Move()
		moves += 1
		world << "Moves = [moves]"
		if(!src.loc) return ..()

		if(world.time < src.move_time) return 0

		if(transferring) return 0

		. = ..()

		if(.)
			src.move_time = world.time + get_speed_delay(src.speed)
			src.glide_size = get_glide_size(src.speed, src.dir)

		return .

mob
	var/w,a,s,d = 0
	proc/move_loop()
		if(world.time >= move_time) //should we do anything?
			if(!step(src, (s && (SOUTH || s)) | (w && (NORTH || w)) | (a && (WEST || a)) | (d && (EAST || d)))) //try desired direction
				if(!step(src, (s && (SOUTH || s)) | (w && (NORTH || w)))) //that failed, try north or south
					step(src, (a && (WEST || a)) | (d && (EAST || d))) //that failed, try east or west
		spawn(world.tick_lag) move_loop() //return, and do it again

	verb/keydown(k as text)
		set hidden = 1
		set instant = 1
		if(k == "w") w = 1
		if(k == "a") a = 1
		if(k == "s") s = 1
		if(k == "d") d = 1

	verb/keyup(k as text)
		set hidden = 1
		set instant = 1
		if(k == "w") w = 0
		if(k == "a") a = 0
		if(k == "s") s = 0
		if(k == "d") d = 0