/client/verb/who()
	set name = "Who"
	set category = "Other"

	var/list/peeps = list()
	var/planet

	for (var/mob/player/M in world)
		if (!M.client)
			continue

		planet = (M.z == 0 ? "Login screen" : M.z == 1 ? "Earth" : M.z == 2 ? "Caves/Ships/Tower" : M.z == 3 ? "Namek" : M.z == 4 ? "Vegeta" : \
			M.z == 5 ? "Checkpoint" : M.z == 6 ? "Hell" : M.z == 7 ? "Heaven" : \
			M.z == 8 ? "Arconia" : M.z == 9 ? "Custom map" : M.z == 10 ? "HBTC" : M.z == 11 ? "Space" : \
			M.z == 12 ? "Ice" : M.z == 13 ? "???" : M.z == 14 ? "DP/JP/AS" : M.z == 15 ? "TFR" : "Unknown")

		if (M.client.stealth && !usr.client.holder)
			peeps += "\t<td>[M.client.fakekey]</td><td> / </td> <td> / </td> <td> / </td> </tr>"
		else if(usr.client.holder)
			peeps += {"\t<tr><td>[M.client][M.client.stealth ? " <i>(as [M.client.fakekey])</i>" : ""]</td>
						<td>[M.client.address ? M.client.address : "localhost"]</td> <td>[M.name]</td>
						<td>[M.Race ? M.Race : "/"]</td>
						<td>[planet]</td>
						<td align=center><A HREF='?src=\ref[src.holder];adminplayeropts=\ref[M]'>X</A> |
						<A HREF='?src=\ref[src.holder];observe=\ref[M]'>Watch</A></td>
						</tr>"}
		else
			peeps += "\t<td>[M.client][M.client.stealth ? " <i>(as [M.client.fakekey])</i>" : ""]</td> <td> / </td> <td> / </td> <td> / </td> </tr>"

	peeps = sortList(peeps)
	var/dat

	dat += "<body><font size=6>Player Listing</font><hr><br>"
	dat += "<br><b>Total Players: [length(peeps)]</b><br><br>"
	dat += "<table border=1 cellspacing=5><B><tr><th>Key</th><th>IP</th><th>Name</th><th>Race</th><th>Planet</th><th>  </th></tr></B>"

	for (var/p in peeps)
		dat += "[p]"
	dat += "</table><br><b>Total Players: [length(peeps)]</b></body>"

	usr << browse(dat,"window=playerlist;size=600x800")

/client/verb/adminwho()
	set category = "Other"
	set name = "Adminwho"

	usr << "<b>Current Admins:</b>"

	for (var/mob/player/M in world)
		if(M && M.client && M.client.holder)
			if(usr.client.holder)
				usr << "[M.key] is a [M.client.holder.rank][M.client.stealth ? " <i>(as [M.client.fakekey])</i>" : ""] ([M.name])"
			else if(!M.client.stealth)
				usr << "\t[M.client]"
