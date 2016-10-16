/client/proc/stealth()
	set category = "Admin"
	set name = "Stealth Mode"
	if(!src.holder)
		src << "Only administrators may use this command."
		return
	src.stealth = !src.stealth
	if(src.stealth)
		var/new_key = trim(input("Enter your desired display name.", "Fake Key", src.key))
		if(!new_key)
			src.stealth = 0
			return
		new_key = strip_html(new_key)
		if(length(new_key) >= MAX_NAME_LENGTH)
			new_key = copytext(new_key, 1, MAX_NAME_LENGTH)
		src.fakekey = new_key
	else
		src.fakekey = null
	log_admin("[key_name(usr)] has turned stealth mode [src.stealth ? "ON" : "OFF"]")
	alertAdmins("[key_name_admin(usr)] has turned stealth mode [src.stealth ? "ON" : "OFF"]", 1)

