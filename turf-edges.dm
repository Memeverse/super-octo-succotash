
turf
	var
		edge_weight = 1
		edge_icon
		has_edges = 0

	proc
		__needs_edge(turf/t)
			if(!t) return 0
			if(istype(t, type)) return 0
			if(t.edge_weight > edge_weight) return 0
			return 1

		__add_edge(d)
			var/image/i = image(edge_icon, icon_state, layer = TURF_LAYER + 0.01 * edge_weight, dir = d)

			if(d & NORTH) i.pixel_y = 32
			if(d & SOUTH) i.pixel_y = -32
			if(d & EAST) i.pixel_x = 32
			if(d & WEST) i.pixel_x = -32

			overlays += i

		generate_edges()

			if(has_edges) return

			var/north = __needs_edge(locate(x, y + 1, z))
			var/south = __needs_edge(locate(x, y - 1, z))
			var/east = __needs_edge(locate(x + 1, y, z))
			var/west = __needs_edge(locate(x - 1, y, z))

			if(north) __add_edge(NORTH)
			if(north && east) __add_edge(NORTHEAST)
			if(north && west) __add_edge(NORTHWEST)

			if(south) __add_edge(SOUTH)
			if(south && east) __add_edge(SOUTHEAST)
			if(south && west) __add_edge(SOUTHWEST)

			if(east) __add_edge(EAST)
			if(west) __add_edge(WEST)

			has_edges = 1

			/*
			// this was the old code
			for(var/turf/t in oview(1, src))

				// if its the same type we don't need to show the edge
				if(istype(t, type)) continue

				// if t's edge_weight is less than or equal to this tiles,
				// we don't show the edge (because we'll show the edge for t).
				if(t.edge_weight > edge_weight) continue

				var/d = get_dir(src, t)

				var/image/i = image(edge_icon, icon_state, layer = TURF_LAYER + 0.01 * edge_weight, dir = d)

				if(d & NORTH) i.pixel_y = 32
				if(d & SOUTH) i.pixel_y = -32
				if(d & EAST) i.pixel_x = 32
				if(d & WEST) i.pixel_x = -32

				overlays += i

			has_edges = 1
			*/

		clear_edges()

			if(!has_edges) return

			overlays = null
			has_edges = 0