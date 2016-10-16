/*****


Players find bugs.
Forums aren't that good for reporting them, and players dont usually feel like leaving the game for it.
So this is a fast fix for that. I'll make it more efficient later.

*****/

proc
	Save_Reports()
		var/savefile/F = new("Data/Reports.sav")
		F["Reports"] << Reports
		F["Reports_anon"] << Reports_anon
		F["Reports_fullanon"] << Reports_fullanon
		//if(global.startRuin) F["success"] << global.startRuin

	Load_Reports()
		if(fexists("Data/Reports.sav"))
			var/savefile/F = new("Data/Reports.sav")
			F["Reports"] >> Reports
			F["Reports_anon"] >> Reports_anon
			F["Reports_fullanon"] >> Reports_fullanon
			//if(length(F["success"])) global.startRuin = 1


var/list/
	Reports = new// Coders/Owners see this version
	Reports_anon = new// Head Admins see this version
	Reports_fullanon = new// Admins see this version

mob/verb/Report()

	set category = "Other"
	var/user_name
	var/user_key
	var/user_ip
	var/reportcategory = input("Filing your report, go with whatever category your report is supposed to be in.","File Report")\
	in list("Bug / Glitch","Map / Icon Error","Spelling / Grammar Mistakes","Admin Abuse","Player Abuse","Other","Cancel")
	if(reportcategory=="Admin Abuse")
		switch(alert("Do you want it to be anonymous?","Yes will mean a Head Admin can still see your name.\nFull means only Coder/Owner levels can see your identity.","Yes","No","Full"))

			if("Yes")
				user_name = "Anonymous"
				user_key = "Anonymous"
				user_ip = "Anonymous"

			if("Full")
				user_name = "Anonymous"
				user_key = "Anonymous"
				user_ip = "Anonymous"

			if("No")
				user_name = src
				user_key = src.key
				user_ip = src.client.address

	else
		user_name = src
		user_key = src.key
		user_ip = src.client.address


	var/reportname = input("Please name your report.","Report Name") as text | null
	if(!reportname)
		src<<"<small><b><font color=red>Your report failed to send, beause it has no name</font></b></small>"
		return

	if(length(reportname) > 50)
		src<<"<small><b><font color=red>Your report failed to send, because the name was longer than 50 characters</font</b></small>"
		return

	var/reportdesc = input("Now please explain your report\n- Your IP, Key, and Name are being logged","Explanation") as message | null
	if(!reportdesc)
		src<<"<small><b><font color=red>Your report failed to send, because it had no explanation</font></b></small>"
		return

	//if(!Reports || !Reports.len) Reports = new
	//if(!Reports_anon || !Reports_anon.len) Reports = new
	//if(!Reports_fullanon || !Reports_fullanon.len) Reports = new

	Reports_fullanon+=	"[time2text(world.realtime)] - <b>[reportcategory]</b> [user_ip] - [user_name] ([user_key])<br><b><u>[html_encode(reportname)]</u></b><br>[html_encode(reportdesc)]<br>"
	Reports_anon+=		"[time2text(world.realtime)] - <b>[reportcategory]</b> [user_ip] - [user_name] ([user_key])<br><b><u>[html_encode(reportname)]</u></b><br>[html_encode(reportdesc)]<br>"
	Reports+=			"[time2text(world.realtime)] - <b>[reportcategory]</b> [src.client.address] - [src] ([src.key])<br><b><u>[html_encode(reportname)]</u></b><br>[html_encode(reportdesc)]<br>"

	src<<"<small><b>Your report has been sent</b></small>"



/client/proc/View_Report()
	set category = "Admin"
	var/html = {"<font size=3><b>Reports: </b></font size>
	<hr>
	<font color=black>
	<font size=2>"}
	if(src.holder.level >=5)
		if(Reports || Reports.len)
			for(var/R in Reports)
				html+="[R]<br><br>"

		else
			html+="<br><b>No Reports</b>"

	if(src.holder.level ==4)
		if(Reports_anon || Reports_anon.len)
			for(var/R in Reports_anon)
				html+="[R]<br><br>"

		else
			html+="<br><b>No Reports</b>"

	if(src.holder.level <=3 && Reports_fullanon.len)
		if(Reports_fullanon || Reports_fullanon.len)
			for(var/R in Reports_fullanon)
				html+="[R]<br><br>"

		else
			html+="<br><b>No Reports</b>"

	else if(!src.holder.level)
		src << "You're not allowed to view this."
		src.verbs -= /client/proc/View_Report
		return

	html+="<br>---------------------------<br><br><b><u>Current Time</u>:  [time2text(world.realtime)]</b>"
	src<<browse(html,"window=who,size=550x600")

/client/proc/Delete_Report()
	set category = "Admin"
	if(src.holder.level>=5)
		Reports = new()
		fdel("Data/Reports.sav")
		logAndAlertAdmins("[key_name(src)] deleted all Bug/Abuse/Glitch reports",2)
