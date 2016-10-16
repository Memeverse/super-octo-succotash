buildBrowser

	var/client/owner
	var/title = "Build Menu"
	var/bodyspec	// additional attributes in the <body> tag
	var/cssfile =  "https://dl.dropbox.com/u/3198442/build_system/scripts/style.css"	// CSS file to use, if any; include classes .file and .fileconfirm
	var/javafile = "https://dl.dropbox.com/u/3198442/build_system/scripts/java_hide.js"	// Javascript file to use, if any.
	var/size="640x480"

	proc/Create(client/C)
		owner = C
		Display()

	proc/PageHead()
		. = "<html>\n"
		if(cssfile || title)
			. += "<head>\n"
			if(cssfile) . += "<link rel=stylesheet href=\"[html_encode("[cssfile]")]\" />"
			if(javafile) . += "<script language=\"javascript\" type=\"text/javascript\" src=\"[html_encode("[javafile]")]\" /> </script>"
			if(title) . += "<title>[title]</title>\n"
			. += "</head>\n"
		. += "<body[bodyspec?" ":""][bodyspec]>\n<div id=\"wrap\">"

	proc/PageFoot()
		. = "\n</div></body></html>"

	proc/Display()
		var/html=PageHead()+PageLayout()+PageFoot()
		owner << browse(html,"window=buildwindow;size=[size]")

	proc/Category(name)
		var/list/buildlist
		var/i
		switch(name)
			if("Roofs")
				buildlist = global.buildRoofs
			if("Walls")
				buildlist = global.buildWalls
			if("Doors")
				buildlist = global.buildDoors
			//if("Terrain")
			//	buildlist = global.buildTerrain
			//if("Props")
			//	buildlist = global.buildProps
		.+= {"
		<div>
			<h3>[name] <a href="#" id="[name]-show" class="showLink" onclick="toggle('[name]')"> unfold</a></h3>
			<div id="[name]" class="toggleOff">
				<table class="grid">
		"}

				for(var/buildobject in buildlist)
					src << output(buildobject, "grid_buildObj:1,[++row]")
					if(i==1) .+={"<tr>"}

					.+={"
					<td class="square-inactive"><a href="#" onclick="swapme('[i]'); return false;" class="inactive" id="[name][i]">

					<IMG CLASS=icon SRC=\ref[usr.icon] ICONSTATE='glowing' ICONDIR=NORTH ICONFRAME=2>

					</a></td>
					"}

					i++
					if(i=>8)
						.+={"</tr>"}
						i=1

		.+= {"
				</table>
				<div><a href="#" id="[name]-hide" class="hideLink" onclick="toggle('[name]');return false;">Hide this category.</a></div>
			</div>
		</div>
		"}

	proc/PageLayout()
		var/list/maincatnames = list("Roofs","Walls","Doors","Terrain","Props")
		for(var/i in maincatnames)
			Category(i)