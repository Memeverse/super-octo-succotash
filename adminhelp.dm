/mob/verb/adminhelp(msg as text)
	set category = "Other"
	set name = "Admin Help"

	msg = copytext(sanitize(msg), 1, MAX_MESSAGE_LEN)

	msg = gSpamFilter.sf_Filter(src,msg)

	if (!msg)
		return

	if (client.muted)
		return

	for (var/mob/M in Players)
		if (M.client && M.client.holder && M.client.holder.listen_Chat)
			M << output("<font color=cyan><b><font color=red>HELP: </font>[key_name(src, M)](<A HREF='?src=\ref[M.client.holder];adminplayeropts=\ref[src]'>X</A>):</b> [msg]</font>","Achat")
	src.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(src)] <font color=red>ADMIN HELP:</font> [msg] \n")
	src << "Your message:\n\n[msg]\n\nhas been broadcast to the administrators."
	src << "Be sure to state your problem, the admins cannot do much without knowing what it is you require help with."
	log_help("[key_name(src)]: [msg]")
	log_admin("HELP: [key_name(src)]: [msg]")
