/atom/movable/var/
	tmp/inertia_dir		//Which direction we're floating through space
	tmp/moved_recently
	tmp/last_move	//dir we moved last
	tmp/m_flag
	tmp/l_move_time	//last world.timeofday we moved
	tmp/move_speed	//How often we're moving
				//Gonna use it for proximity checks, move slow enough and you can get past shit
	savedX	//Self explanatory?
	savedY
	savedZ
	anchored = 0	//Whether or not it'll float through space, or if it can be pushed (not coded yet)

/atom/movable/overlay/New()
	for(var/x in src.verbs)
		src.verbs -= x
	return

/atom/movable/Move()
	var/atom/A = src.loc
	. = ..()
	src.move_speed = world.timeofday - src.l_move_time
	src.l_move_time = world.timeofday
	src.m_flag = 1
	if ((A != src.loc && A && A.z == src.z))
		src.last_move = get_dir(A, src.loc)
		src.moved_recently = 1
	return
/*
/atom/movable/Move(NewLoc, direct)
	if (direct & direct - 1)
		if (direct & 1)
			if (direct & 4)
				if (step(src, NORTH))
					step(src, EAST)
					src.dir = NORTHEAST
				else
					if (step(src, EAST))
						step(src, NORTH)
						src.dir = NORTHEAST
			else
				if (direct & 8)
					if (step(src, NORTH))
						step(src, WEST)
						src.dir = NORTHWEST
					else
						if (step(src, WEST))
							step(src, NORTH)
							src.dir = NORTHWEST
		else
			if (direct & 2)
				if (direct & 4)
					if (step(src, SOUTH))
						step(src, EAST)
						src.dir = SOUTHEAST
					else
						if (step(src, EAST))
							step(src, SOUTH)
							src.dir = SOUTHEAST
				else
					if (direct & 8)
						if (step(src, SOUTH))
							step(src, WEST)
							src.dir = SOUTHWEST
						else
							if (step(src, WEST))
								step(src, SOUTH)
								src.dir = SOUTHWEST
	else
		. = ..()
	return
*/
