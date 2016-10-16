/proc/alertAdmins(var/text, var/admin_ref = 0)
	if(!text)
		return 0	//Failed
	var/rendered = "<span class=\"admin\"><span class=\"prefix\">ADMIN LOG:</span> <span class=\"message\">[text]</span></span>"
	for (var/mob/player/M in Players)
		if(!M.client) continue
		if (M.client.holder && M.client.holder.listen_Alerts)
			if (admin_ref)
				M << dd_replaceText(rendered, "%admin_ref%", "\ref[M]")
			else
				M << rendered

/proc/logAndAlertAdmins(var/text)
	if(!text)
		return
	log_admin(text)
	alertAdmins(text)

/proc/alertAdminsLogin(var/text,var/color="green")
	if(!text)
		return 0	//Failed
	var/rendered = "<span class=\"admin\"><span class=\"prefix\">ADMIN LOG:</span> <span class=\"message\"><font color=\"[color]\">[text]</font></span></span>"
	log_admin(rendered)
	for (var/mob/player/M in Players)
		if(!M.client) continue
		if (M.client.holder && M.client.holder.listen_Alerts && M.client.holder.listen_Logins)
			M << rendered
