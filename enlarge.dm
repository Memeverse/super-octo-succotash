obj/Enlarge_Icon/verb/Enlarge()
	set category="Other"
	usr.Enlarge_Icon()
atom/proc/Enlarge_Icon()
	if(!icon)
		return
	var/icon/A=new(icon)
	A.Scale(64,64)
	//var/image/b=image(icon=A,icon_state="0,0",pixel_x=-16,pixel_y=-16)
	//var/image/C=image(icon=A,icon_state="1,0",pixel_x=16,pixel_y=-16)
	//var/image/D=image(icon=A,icon_state="0,1",pixel_x=-16,pixel_y=16)
	//var/image/E=image(icon=A,icon_state="1,1",pixel_x=16,pixel_y=16)
	icon = A
	Enlarge_Overlays()
	//overlays.Add(b)
	//overlays.Add(b,C,D,E)
atom/proc/Enlarge_Overlays()
	if(!overlays)
		return
	for(var/O in overlays) if(O:icon)
		var/icon/A=new(O:icon,O:icon_state)
		A.Scale(64,64)
		overlays -= O
		overlays += A
		//var/image/b=image(icon=A,icon_state="0,0",pixel_x=-16,pixel_y=-16)
		//var/image/C=image(icon=A,icon_state="1,0",pixel_x=16,pixel_y=-16)
		//var/image/D=image(icon=A,icon_state="0,1",pixel_x=-16,pixel_y=16)
		//var/image/E=image(icon=A,icon_state="1,1",pixel_x=16,pixel_y=16)
		//spawn(1) overlays.Add(b)
		//spawn(1) overlays.Add(b,C,D,E)

