var/Stat_Lag = 10
/client/proc/statlag(number as num)
	set category = "Admin"
	set name = "Statlag"
	set desc = "Statlag"

	number = max(5,number)	//No less then 5

	if(src.holder)
		if(!src.mob)
			return
		if(src.holder.rank in list("Coder", "Owner"))
			Stat_Lag = number
			log_admin("[key_name(src.mob)] set stat_lag to [number]")
			alertAdmins("[key_name_admin(usr)] modified world's stat_lag to [number]")
	else
		alert("Fuck off guy")
		alertAdmins("[key_name_admin(usr)] tried to modify world's stat_lag to [number] and was \red REJECTED")
		log_admin("[key_name_admin(usr)] tried to modify world's stat_lag to [number] and was \red REJECTED")
		return