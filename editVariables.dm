/client/proc/modifyvariables(atom/O as obj|mob|turf|area, var/variable)
//	set category = "Admin"
//	set name = "Edit Variables"
//	set desc="(target) Edit a target item's variables"

	if(!holder)
		usr << "Only administrators may use this command."
		return

	//var/variable = input("Which var?","Var") in O.vars
	var/default
	var/typeof = O.vars[variable]
	var/dir

	if(isnull(typeof))
		usr << "Unable to determine variable type."

	else if(isnum(typeof))
		usr << "Variable appears to be <b>NUM</b>."
		default = "num"
		dir = 1

	else if(istext(typeof))
		usr << "Variable appears to be <b>TEXT</b>."
		default = "text"

	else if(isloc(typeof))
		usr << "Variable appears to be <b>REFERENCE</b>."
		default = "reference"

	else if(isicon(typeof))
		usr << "Variable appears to be <b>ICON</b>."
		typeof = "\icon[typeof]"
		default = "icon"

	else if(istype(typeof,/atom) || istype(typeof,/datum))
		usr << "Variable appears to be <b>TYPE</b>."
		default = "type"

	else if(istype(typeof,/list))
		usr << "Variable appears to be <b>LIST</b>."
		default = "cancel"

	else if(istype(typeof,/client))
		usr << "Variable appears to be <b>CLIENT</b>."
		default = "cancel"

	else
		usr << "Variable appears to be <b>FILE</b>."
		default = "file"

	usr << "Variable contains: [typeof]"
	if(dir)
		switch(typeof)
			if(1)
				dir = "NORTH"
			if(2)
				dir = "SOUTH"
			if(4)
				dir = "EAST"
			if(8)
				dir = "WEST"
			if(5)
				dir = "NORTHEAST"
			if(6)
				dir = "SOUTHEAST"
			if(9)
				dir = "NORTHWEST"
			if(10)
				dir = "SOUTHWEST"
			else
				dir = null
		if(dir)
			usr << "If a direction, direction is: [dir]"


	var/class = input("What kind of variable?","Variable Type",default) in list("text",
		"num","type","reference","icon","file","list","restore to default","cancel")

	switch(class)
		if("cancel")
			return

		if("list")
			mod_list(O.vars[variable])

		if("restore to default")
			O.vars[variable] = initial(O.vars[variable])

		if("text")
			O.vars[variable] = input("Enter new text:","Text",\
				O.vars[variable]) as text

		if("num")
			O.vars[variable] = input("Enter new number:","Num",\
				O.vars[variable]) as num

		if("type")
			O.vars[variable] = input("Enter type:","Type",O.vars[variable]) \
				in typesof(/obj,/mob,/area,/turf)

		if("reference")
			O.vars[variable] = input("Select reference:","Reference",\
				O.vars[variable]) as mob|obj|turf|area in world

		if("file")
			O.vars[variable] = input("Pick file:","File",O.vars[variable]) \
				as file

		if("icon")
			O.vars[variable] = input("Pick icon:","Icon",O.vars[variable]) \
				as icon

	alertAdmins("[usr.key] modified [O.name]'s [variable] to [O.vars[variable]]",2)
	log_admin("[usr.key] modified [O.name]'s [variable] to [O.vars[variable]]")
	//file("AdminLog.log")<<"[usr]([usr.key] modified [O.name]'s [variable] to [O.vars[variable]] at [time2text(world.realtime,"Day DD hh:mm")]"


/client/proc/mod_list_add_ass()

	var/class = input("What kind of variable?","Variable Type") as null|anything in list("text",
	"num","type","reference","mob reference", "icon","file")

	if(!class)
		return

	var/var_value = null

	switch(class)

		if("text")
			var_value = input("Enter new text:","Text") as text

		if("num")
			var_value = input("Enter new number:","Num") as num

		if("type")
			var_value = input("Enter type:","Type") in typesof(/obj,/mob,/area,/turf)

		if("reference")
			var_value = input("Select reference:","Reference") as mob|obj|turf|area in world

		if("mob reference")
			var_value = input("Select reference:","Reference") as mob in world

		if("file")
			var_value = input("Pick file:","File") as file

		if("icon")
			var_value = input("Pick icon:","Icon") as icon

	if(!var_value) return

	return var_value


/client/proc/mod_list_add(var/list/L)

	var/class = input("What kind of variable?","Variable Type") as null|anything in list("text",
	"num","type","reference","mob reference", "icon","file")

	if(!class)
		return

	var/var_value = null

	switch(class)

		if("text")
			var_value = input("Enter new text:","Text") as text

		if("num")
			var_value = input("Enter new number:","Num") as num

		if("type")
			var_value = input("Enter type:","Type") in typesof(/obj,/mob,/area,/turf)

		if("reference")
			var_value = input("Select reference:","Reference") as mob|obj|turf|area in world

		if("mob reference")
			var_value = input("Select reference:","Reference") as mob in world

		if("file")
			var_value = input("Pick file:","File") as file

		if("icon")
			var_value = input("Pick icon:","Icon") as icon

	if(!var_value) return

	switch(alert("Would you like to associate a var with the list entry?",,"Yes","No"))
		if("Yes")
			L += var_value
			L[var_value] = mod_list_add_ass()
		if("No")
			L += var_value


/client/proc/mod_list(var/list/L)
	if(!istype(L,/list)) src << "Not a List."

	var/list/locked = list("vars", "key", "ckey", "client", "firemut", "ishulk", "telekinesis", "xray", "virus", "cuffed", "ka", "last_eaten", "urine", "poo", "icon", "icon_state")

	var/list/names = sortList(L)

	var/variable = input("Which var?","Var") as null|anything in names + "(ADD VAR)"

	if(variable == "(ADD VAR)")
		mod_list_add(L)
		return

	if(!variable)
		return

	var/default

	var/dir

	if (locked.Find(variable) && !(src.holder.rank in list("Host", "Coder")))
		return

	if(isnull(variable))
		usr << "Unable to determine variable type."

	else if(isnum(variable))
		usr << "Variable appears to be <b>NUM</b>."
		default = "num"
		dir = 1

	else if(istext(variable))
		usr << "Variable appears to be <b>TEXT</b>."
		default = "text"

	else if(isloc(variable))
		usr << "Variable appears to be <b>REFERENCE</b>."
		default = "reference"

	else if(isicon(variable))
		usr << "Variable appears to be <b>ICON</b>."
		variable = "\icon[variable]"
		default = "icon"

	else if(istype(variable,/atom) || istype(variable,/datum))
		usr << "Variable appears to be <b>TYPE</b>."
		default = "type"

	else if(istype(variable,/list))
		usr << "Variable appears to be <b>LIST</b>."
		default = "list"

	else if(istype(variable,/client))
		usr << "Variable appears to be <b>CLIENT</b>."
		default = "cancel"

	else
		usr << "Variable appears to be <b>FILE</b>."
		default = "file"

	usr << "Variable contains: [variable]"
	if(dir)
		switch(variable)
			if(1)
				dir = "NORTH"
			if(2)
				dir = "SOUTH"
			if(4)
				dir = "EAST"
			if(8)
				dir = "WEST"
			if(5)
				dir = "NORTHEAST"
			if(6)
				dir = "SOUTHEAST"
			if(9)
				dir = "NORTHWEST"
			if(10)
				dir = "SOUTHWEST"
			else
				dir = null

		if(dir)
			usr << "If a direction, direction is: [dir]"

	var/class = input("What kind of variable?","Variable Type",default) as null|anything in list("text",
		"num","type","reference","mob reference", "icon","file","list","edit referenced object", "(DELETE FROM LIST)","restore to default")

	if(!class)
		return

	switch(class)

		if("list")
			mod_list(variable)

		if("restore to default")
			variable = initial(variable)

		if("edit referenced object")
			modifyvariables(variable)

		if("(DELETE FROM LIST)")
			L -= variable
			return

		if("text")
			variable = input("Enter new text:","Text",\
				variable) as text

		if("num")
			variable = input("Enter new number:","Num",\
				variable) as num

		if("type")
			variable = input("Enter type:","Type",variable) \
				in typesof(/obj,/mob,/area,/turf)

		if("reference")
			variable = input("Select reference:","Reference",\
				variable) as mob|obj|turf|area in world

		if("mob reference")
			variable = input("Select reference:","Reference",\
				variable) as mob in world

		if("file")
			variable = input("Pick file:","File",variable) \
				as file

		if("icon")
			variable = input("Pick icon:","Icon",variable) \
				as icon
