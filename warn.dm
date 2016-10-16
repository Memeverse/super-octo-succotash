/client/proc/warn(var/mob/M in world)
	set category = "Admin"
	set name = "Warn"
	set desc = "Warn a player"
	if(!src.holder)
		src << "Only administrators may use this command."
		return
	if(M.client && M.client.holder && (M.client.holder.level >= src.holder.level))
		alert("You cannot perform this action. You must be of a higher administrative rank!", null, null, null, null, null)
		return
	if(!M.client.warned)
		M << "\red <B>You have been warned by an administrator. This is the only warning you will recieve.</B>"
		M.client.warned = 1
		alertAdmins("[key_name(src)] warned [key_name(M)].")
	else
		AddBan(M.ckey, M.computer_id, "Autobanning due to previous warn", src.ckey, 1, 10)
		M << "\red<BIG><B>You have been autobanned by [src.ckey]. This is what we in the biz like to call a \"second warning\".</B></BIG>"
		M << "\red This is a temporary ban; it will automatically be removed in 10 minutes."
		log_admin("[key_name(src)] warned [key_name(M)], resulting in a 10 minute autoban.")
		alertAdmins("[key_name(src)] warned [key_name(M)], resulting in a 10 minute autoban.")

		del(M.client)
		del(M)