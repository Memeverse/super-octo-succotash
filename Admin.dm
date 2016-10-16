mob/Admin1/verb/Who_Is_Blasting()
	set category="Admin"
	for(var/mob/A in Players)
		if(A.attacking==2)
			src<<"[A] is blasting"
mob/Admin4/verb/Purge_Old_Saves()
	world<<"<font size=1><font color=#FFFF00>Purging old saves. This may take a bit."
	for(var/File in flist("Save/"))
		var/savefile/F=new("Save/[File]")
		if(!F["Last_Used"]|F["Last_Used"]<=world.realtime-864000*4) fdel("Save/[File]")
	logAndAlertAdmins("[src.key] purged old savefiles.",4)
	world<<"<font size=1><font color=#FFFF00>Savefile purge complete"
mob/Admin4/verb/Delete_File()
	set category="Admin"
	fdel(input("What file name?") as text)
	logAndAlertAdmins("[src.key] used Delete file",4)

mob/Admin4/verb/GetFiles() if(world.maxz!=1) for(var/File in flist("./"))
	if(!(File in list("Finale.dmb","Finale.rsc","Finale.rsc.lk","AdminLog.log","Logs/","Errors",\
	"Finale.dyn.rsc","Finale.dyn.rsc.lk","Finale.dyn","Save/")))
		src<<"[File] ([File_Size(File)])"
		src<<ftp(File)
		logAndAlertAdmins("[src.key] used get file on [File]",4)

mob/Admin4/verb/MassZombie()
	set category="Admin"
	var/Amount=input("") as num
	for(var/mob/A in Players) A.Zombied=Amount
	logAndAlertAdmins("[src.key] used Mass Zombie",4)

mob/Admin4/verb/SetYear()
	set category="Admin"
	Year=input("Enter a year. The current is [Year]") as num
	logAndAlertAdmins("[src.key] set the year to [Year]",4)
mob/Admin4/verb/Map_Save()
	set category="Admin"
	file("AdminLog.log")<<"[usr]([key]) saved the map at [time2text(world.realtime,"Day DD hh:mm")]"
	Save_Turfs()
	logAndAlertAdmins("[src.key] saved the map",4)
mob/Admin4/verb/Save_Items()
	set category="Admin"
	SaveItems()
	logAndAlertAdmins("[src.key] saved items",4)
mob/Admin1/verb/Objects()
	set category="Admin"
	var/amount=0
	for(var/turf/A in Turfs) amount+=1
	src << "Player placed turfs: [amount]"
	amount=0

	for(var/obj/A in global.worldObjectList) 
		if(A.Savable||istype(A,/obj/TrainingEq)) amount+=1
	src << "Player made objects: [amount]"
	amount=0

	for(var/turf/A) amount+=1
	src<<"Turfs: [amount]"
	amount=0

	for(var/obj/A) amount+=1
	src<<"Objects: [amount]"
	amount=0
	
        for(var/mob/A) amount+=1
	src<<"Mobs: [amount]"
	amount=0
	
        for(var/NPC_AI/A) amount+=1
	src<<"NPCs: [amount]"

mob/Admin2/verb/Warper()
	set category="Admin"
	var/obj/Warper/A=new(locate(x,y,z))
	A.gotox=input("x location to send to") as num
	A.gotoy=input("y") as num
	A.gotoz=input("z") as num
	logAndAlertAdmins("[src.key] created a warper at ([A.x],[A.y],[A.z])",2)
mob/Admin4/verb/Pwipe()
	set category="Admin"
	switch(input("Are you SURE you want to delete all saves?") in list("No","Yes"))
		if("Yes")
			file("AdminLog.log")<<"[usr]([key]) pwiped [time2text(world.realtime,"Day DD hh:mm")]"
			world<<"[usr]([key]) is about to delete all the savefiles... (10 seconds)"
			sleep(100)
			for(var/mob/A in Players) A.lastKnownKey = null
			fdel("Save/")
			fdel("RANK")
			fdel("GAIN")
			logAndAlertAdmins("[src.key] used Pwipe",4)
			SaveWorld()
			world.Reboot()

mob/Admin1/verb/Transfer(M as mob in Players,F as file)
	switch(alert(M,"[usr] is trying to send you [F] ([File_Size(F)]). Accept?","","Yes","No"))
		if("Yes")
			usr<<"[M] accepted the file"
			M<<ftp(F)
		if("No") usr<<"[M] declined the file"

mob/Admin4/verb/Brix(mob/A in world)
	set category="Admin"
	logAndAlertAdmins("[src.key] brixed [A]",4)
	var/mob/M=new
	M.overlays.Add(overlays)
	M.name=name
	M.icon=icon
	M.loc=locate(A.x-6,A.y-6,A.z)
	view(A)<<"A [M] appears!"
	sleep(10)
	missile('Brick.dmi',M,A)
	A.KO("brix")
	spawn(30) if(A)
		view(A)<<"[A] is hit by a brick and dies!"
		var/list/OldOverlays=new
		OldOverlays.Add(A.overlays)
		A.overlays.Remove(A.overlays)
		flick('Exploded.dmi',A)
		sleep(30)
		A.Body_Parts()
		spawn A.Death("brix")
		A.overlays.Add(OldOverlays)
		spawn(10) if(M) del(M)
mob/Admin2/verb/AdminOverlays(atom/A as mob|obj in world)
	set category="Admin"
	A.overlays = null
	A.underlays = null
	logAndAlertAdmins("[src.key] removed [A]'s overlays",2)
mob/Admin1/verb/Ages()
	set category="Admin"
	for(var/mob/M in Players) if(M.client) usr<<"[M]: [round(M.Age)] ([round(M.Decline)] Decline)"
proc/Replace_List()
	var/list/L=new
	for(var/turf/A in view(src)) L+=A
	for(var/obj/O) L+=O
	return L
mob/Admin3/verb/Replace(atom/A in Replace_List())
	set category="Admin"
	var/Type=A.type
	var/list/B=new
	B+="Cancel"
	if(isturf(A)) B+=typesof(/turf)
	else B+=typesof(/obj)
	var/atom/C=input("Replace with what?") in B
	if(C=="Cancel") return
	var/Save
	switch(input("Make it save?") in list("No","Yes"))
		if("Yes") Save=1
	for(var/turf/D in block(locate(1,1,z),locate(world.maxx,world.maxy,z)))
		if(D.type==Type)
			if(prob(0.2)) sleep(1)
			var/turf/Q=new C(locate(D.x,D.y,D.z))
			if(Save) Turfs+=Q
		else for(var/obj/E in D)
			if(prob(1)) sleep(1)
			if(E.type==Type)
				var/obj/Q=new C(locate(E.x,E.y,E.z))
				Q.Savable=0
				if(Save) Turfs+=Q
				del(E)
	logAndAlertAdmins("[src.key] replaced [A] with [C] and save=[Save]",3)
mob/Admin1/verb/Forms()
	set category="Admin"
	for(var/mob/M in Players) if(M.client) if(M.hasssj&&M.Race!="1/16th Saiyan"&&M.Class!="Legendary") \
	usr<<"[M] is SSj."
	for(var/mob/M in Players) if(M.client) if(M.FBMAchieved&&M.Race=="Namekian") usr<<"[M] is SNj."
	for(var/mob/M in Players) if(M.client) if(M.hasssj2) usr<<"[M] is SSj2."
	for(var/mob/M in Players) if(M.client) if(M.hasssj3&&M.hasssj2) usr<<"[M] is SSj3."
	for(var/mob/M in Players) if(M.client) if(M.hasssj4) usr<<"[M] is SSj4."
var/savingmap

mob/Admin4/verb/Terraform()
	set category="Admin"
	var/list/list1=new
	list1+=typesof(/turf)
	var/turf/Choice=input("Replace all turfs with what?") in list1
	for(var/turf/T in block(locate(1,1,z),locate(world.maxx,world.maxy,z)))
		if(prob(1)) sleep(1)
		if(!T.Savable) new Choice(T)
	logAndAlertAdmins("[src.key] used Terraform and replaced with [Choice]",4)
mob/Admin1/verb/Dead()
	set category="Admin"
	for(var/mob/M in Players) if(M.Dead) usr<<"<font color=green>[M] is Dead."
mob/Admin2/verb
	XYZTeleport(mob/M in world)
		set category="Admin"
		usr<<"This will send the mob you choose to a specific xyz location."
		var/xx=input("X Location?") as num
		var/yy=input("Y Location?") as num
		var/zz=input("Z Location?") as num

		switch(input("Are you sure?") in list ("Yes", "No",))
			if("Yes")
				M.loc=locate(xx,yy,zz)
				logAndAlertAdmins("[src.key] used XYZTeleport on [M] to ([M.x],[M.y],[M.z])",2)
mob/Admin4/verb/NPCs()
	set category="Admin"
	for(var/mob/A) if(!A.client&&A.type!=/obj/TrainingEq/Dummy&&A.type!=/obj/TrainingEq/Punching_Bag&&A.type!=/mob/Enemy/Zombie)
		del(A)
		if(prob(5)) sleep(1)
	Admins<<"Monsters deleted"
	logAndAlertAdmins("[src.key] deleted all the monsters",4)
mob/Admin4/verb/Clean()
	set category="Admin"
	for(var/obj/Blast/A)
		del(A)
		if(prob(1)) sleep(1)
	for(var/obj/SpaceDebris/A)
		del(A)
		if(prob(1)) sleep(1)
	for(var/obj/Dust/A)
		del(A)
		if(prob(1)) sleep(1)
	logAndAlertAdmins("[src.key] deleted all blasts and asteroids",4)
mob/Admin2/verb/World_Heal()
	set category="Admin"
	logAndAlertAdmins("[src.key] used world heal",2)
	spawn for(var/mob/M in Players)
		spawn if(M&&M.icon_state=="KO") M.Un_KO()
		spawn(10) if(M) M.Health=100
		spawn(10) if(M) M.Ki=M.MaxKi

mob/Admin4/verb/MassKO()
	set category="Admin"
	logAndAlertAdmins("[src.key] used MassKO",4)
	for(var/mob/A in Players) if(A.client) spawn A.KO("admin")
