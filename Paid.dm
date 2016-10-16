mob
	verb
		Donate()
			set name = ".Donate"
			set hidden = 1
			winshow(usr,"Donate",1)
		Direct()
			set name = ".Direct"
			set hidden = 1
			usr << "https://www.paypal.me/wtfdontbanme"
			usr << link("https://www.paypal.me/wtfdontbanme")
obj/Colorfy/verb/Color(obj/O as obj in view(usr))
	set category="Other"
	set src=usr.contents
	if(ismob(O)) switch(input(O,"[usr] wants to colorize you, accept?") in list("No","Yes"))
		if("No") return
	usr.Colorize(O)
mob/proc/Colorize(obj/O)
	if(O)
		switch(input("") in list("Add","Subtract","Multiply"))
			if("Multiply")
				if(O)
					var/icon/A=new(O.icon)
					var/B=input("Choose a color") as color|null
					if(B) A.MapColors(B,"#ffffff","#000000")
					if(A) O.icon=A
			if("Add") O.icon+=rgb(input("Red") as num,input("Green") as num,input("Blue") as num)
			if("Subtract") O.icon-=rgb(input("Red") as num,input("Green") as num,input("Blue") as num)
	usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] uses Colorize on [O].\n")

obj/Crandal
	verb/Add_Tile(var/icon/IO as icon)
		set category="Other"
		var/icon/I = new /icon(IO)
		if(!usr.client.holder && (length(I) > 102400))
			src << "\red File was [File_Size(length(I))]! File [I] is greater then the 100kb filesize limit! Rejected!"
			return
		if (!usr.client.holder && (I.Width()>128 || I.Height()>128))
			usr << "This icon exceeds the 128x128 add_Tile size limit!"
			return
		var/State=input("This verb allows you to make multi tile icons, first, you choose the icon you want, then \
		you pick an icon state within that icon, then you offset the chosen icon's pixels however you want, then \
		it is added to your character. Each tile is 32 pixels, so +32 is one tile away.") in \
		icon_states(I)
		var/X_Offset=input("Choose pixel_x offset, each tile is 32 pixels.") as num
		var/Y_Offset=input("Choose pixel_y offset") as num
		var/image/A=image(icon=I,icon_state=State,pixel_x=X_Offset,pixel_y=Y_Offset)
		usr.overlays+=A
		usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] adds [A] as a tile.\n")

	verb/ChangeIconObj(var/icon/IO as icon)
		set category="Skills"
		var/icon/Z = new /icon(IO)
		if(!usr.client.holder && (length(Z) > 102400))
			src << "\red File was [File_Size(length(IO))]! File [Z] is greater then the 100kb filesize limit! Rejected!"
			return
		if (!usr.client.holder && (Z.Width()>128 || Z.Height()>128))
			usr << "This icon exceeds the 128x128 ChangeIcon size limit!"
			return
		var/obj/A=input(usr,"") as obj in view(usr)
		var/X_Offset=input("Choose pixel_x offset, each tile is 32 pixels.") as num
		var/Y_Offset=input("Choose pixel_y offset") as num
		A.ChangeIconOwner = usr.lastKnownKey
		A.ChangeIconIP = usr.lastKnownIP
		if(A.Can_Change == 0)
			A = null
		if(!A)
			return
		else
			A.icon=Z
			A.icon_state=input("icon state") as text
			A.pixel_x = X_Offset
			A.pixel_y = Y_Offset
		//	var/image/D=image(icon=(Z),icon_state=A.icon_state,pixel_x = X_Offset,pixel_y = Y_Offset)
		//	A.icon+=D
			usr << "Icon accepted!"
			usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] changes the icon of object [A] to [A.icon].\n")

	verb/ChangeIcon(var/icon/IO as icon)
		set category="Skills"
		var/mob/player/A=input("") as mob in view(usr)
		if(!usr || !A) return
		var/icon/Z = new /icon(IO)

		if(usr.client && !usr.client.holder && (length(Z) > 102400))
			src << "\red File was [File_Size(length(IO))]! File [Z] is greater then the 100kb filesize limit! Rejected!"
			return
		if (usr.client && !usr.client.holder && (Z.Width()>96 || Z.Height()>96))
			usr << "This icon exceeds the 96x96 ChangeIcon size limit!"
			return

		var/X_Offset=input("Choose pixel_x offset, each tile is 32 pixels.") as num
		var/Y_Offset=input("Choose pixel_y offset") as num

		if(A == usr)
			A.icon = Z
			A.pixel_x = X_Offset
			A.pixel_y = Y_Offset
			usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] changes their own icon to [Z].\n")
		else switch(input(A,"[usr.name] wants to change your icon into \icon[Z], accept?") in list("Yes","No"))
			if("Yes")
				A.icon=Z
				A.pixel_x = X_Offset
				A.pixel_y = Y_Offset
				usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] changes [key_name(A)]'s icon to [Z]\n")
			else
				usr<<"[A] denies to change their icon"
		if(A.Dead) if(!A.KeepsBody)
			var/icon/I=new(A.icon)
			I.Blend(rgb(0,0,0,100),ICON_ADD)
			A.icon=I

	verb/Rename(obj/O as obj|mob in view(),ID as text)
		set category="Skills"
		set src=usr.contents
		if(!O||!ID) return
		if(usr)
			usr<<"Do not use this to give yourself a name that is against the rules. Or somehow blank names."
			if(O!=usr&&istype(O,/mob/player)) switch(input(O,"[usr.name] wants to change your name to [ID], accept?") in list("No","Yes"))
				if("No")
					usr<<"[O] declined the name change to [ID]"
					return
			O.name = strip_html(ID,MAX_NAME_LENGTH)
			usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] changes [key_name(O)] 's name to [ID].\n")

	verb/CopyIcon(mob/A in Players)
		set category="Skills"
		set src=usr.contents
		if(ismob(A))
			if(!A.client)
				usr << "Error: Not a player."
				return
			switch(input(A,"[usr.name] wants to copy your icon, accept?") in list("No","Yes"))
				if("No")
					usr << "[A] declined your request to copy their icon"
					return
		usr.icon = A.icon
		usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] copied [key_name(A)] 's icon [A.icon].\n")