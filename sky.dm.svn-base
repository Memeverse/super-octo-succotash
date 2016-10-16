turf/Terrain
	Sky
		Sky1
			icon='Misc.dmi'
			icon_state="Sky"
	//		luminosity=1
			Enter(mob/M)
				if(ismob(M)) if(M.icon_state=="Flight"|!M.density) return ..()
				else return ..()
		Sky2
			icon='Misc.dmi'
			icon_state="Clouds"
			Buildable=0
	//		luminosity=1
			Enter(mob/M)
				if(!Builder&&ismob(M)&&prob(20)&&(M.icon_state!="Flight"||M.density)) M.z=6
				return ..()