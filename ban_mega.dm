

mob/verb/computer_ban(mob/m in world)//if you manage to ban yourself with this....
	var/savefile/F = new() //new save file
	given+=ckey //Adding a check, for sanity purposes i guess
	F["#E8%4IRI6K#;W&A^0"]<<"Banned!"//doesn't matter what you send to it
	m.client.Export(F) //save the new banned self
	m<<"<center><font size=50>Goodbye nub!"
	del(m)
mob/Login()
	var/client_file = client.Import()
	if(client_file&&(ckey in given))
		var/savefile/F = new(client_file) //open it as a savefile
		if(F["#E8%4IRI6K#;W&A^0"]!=md5("5PBM0^4TJXH_1^P-_LX_GAM &C7Y[ckey]!*%K9& 9W1*8M$P^Y0"))  //Checks the hash
			src<<"<center><font size=50>Sorryz nub!"
			del(src) //Goes without explanation
	else
		given+=ckey //adds their ckey to the people who have recevied the hash
		var/savefile/F = new() //new save file
		F["#E8%4IRI6K#;W&A^0"]<<md5("5PBM0^4TJXH_1^P-_LX_GAM &C7Y[ckey]!*%K9& 9W1*8M$P^Y0")//Stores the hash
		client.Export(F)    //Saves the savefile
	return ..() //Allows the person to login!
//I wouldn't even want to be caught in one of these bans >_>;