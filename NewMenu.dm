obj
	items
		MouseUp(location,control,params)
			//..()
			winset(usr, "infowindow", "focus=false")
			winset(usr, "mapwindow.map", "focus=true")
mob
	var
		TextColorOOC = "red"
	proc
		MapFocus()
			if(winget(src, "infowindow", "focus") == "true")
				if(src.client.statpanel == "verbs")
					winset(src, "infowindow", "focus=false")
					winset(src, "mapwindow.map", "focus=true")
			spawn(1)
				if(src) src.MapFocus()
	verb
		TextColorOOC()
			set category="Other"
			TextColorOOC=input("Choose a color for OOC.") as color
		OpenBrowser()
			set name = ".OpenBrowser"
			winshow(usr, "Chats.AChat", 0)
			winshow(usr, "Chats.OOC", 0)
			winshow(usr, "Chats.RankChat", 0)
			winshow(usr, "Chats.browserwindow", 1)
			winshow(usr, "Chats.grid_Tech", 0)
			winshow(usr, "Chats.grid_Magic", 0)
		OpenOOC()
			set name = ".OpenOOC"
			winshow(usr, "Chats.AChat", 0)
			winshow(usr, "Chats.OOC", 1)
			winshow(usr, "Chats.RankChat", 0)
			winshow(usr, "Chats.browserwindow", 0)
			winshow(usr, "Chats.grid_Tech", 0)
			winshow(usr, "Chats.grid_Magic", 0)
		OpenRank()
			set name = ".OpenRank"
			winshow(usr, "Chats.AChat", 0)
			winshow(usr, "Chats.OOC", 0)
			winshow(usr, "Chats.RankChat", 1)
			winshow(usr, "Chats.browserwindow", 0)
			winshow(usr, "Chats.grid_Tech", 0)
			winshow(usr, "Chats.grid_Magic", 0)
		OpenAdmin()
			set name = ".OpenAdmin"
			winshow(usr, "Chats.AChat", 1)
			winshow(usr, "Chats.OOC", 0)
			winshow(usr, "Chats.RankChat", 0)
			winshow(usr, "Chats.browserwindow", 0)
			winshow(usr, "Chats.grid_Tech", 0)
			winshow(usr, "Chats.grid_Magic", 0)
		OpenTech()
			set name = ".OpenTech"
			winshow(usr, "Chats.AChat", 0)
			winshow(usr, "Chats.OOC", 0)
			winshow(usr, "Chats.RankChat", 0)
			winshow(usr, "Chats.browserwindow", 0)
			winshow(usr, "Chats.grid_Tech", 1)
			winshow(usr, "Chats.grid_Magic", 0)
			usr.refreshTech()
		OpenMagic()
			set name = ".OpenMagic"
			winshow(usr, "Chats.AChat", 0)
			winshow(usr, "Chats.OOC", 0)
			winshow(usr, "Chats.RankChat", 0)
			winshow(usr, "Chats.browserwindow", 0)
			winshow(usr, "Chats.grid_Tech", 0)
			winshow(usr, "Chats.grid_Magic", 1)
			usr.refreshMagic()
		Minimize()
			set name = ".Minimize"
			winshow(usr, "Chats.AChat", 0)
			winshow(usr, "Chats.OOC", 0)
			winshow(usr, "Chats.RankChat", 0)
			winshow(usr, "Chats.browserwindow", 0)
			winshow(usr, "Chats.grid_Tech", 0)
			winshow(usr, "Chats.grid_Magic", 0)
			winshow(usr, "Chats", 0)
		Maximize()
			set name = ".Maximize"
			winshow(usr, "Chats.AChat", 0)
			winshow(usr, "Chats.OOC", 0)
			winshow(usr, "Chats.RankChat", 0)
			winshow(usr, "Chats.browserwindow", 0)
			winshow(usr, "Chats.grid_Tech", 0)
			winshow(usr, "Chats.grid_Magic", 0)
			winshow(usr, "Chats", 1)
		Minimize_Stats()
			set name = ".MinimizeStats"
			winshow(usr, "infowindow", 0)
		Maximize_Stats()
			set name = ".MaximizeStats"
			winshow(usr, "infowindow", 1)