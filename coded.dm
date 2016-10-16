

proc/importCoded(var/addr)

	var/list/file = new()
	var/file_output
	var/coded_list

	file = world.Export("[addr]") // Retrieve the file from the URL
//	world<<"File retrieved from [addr]"

	file = file["CONTENT"] // The CONTENT header contains what we need
	file_output = file2text(file) // Turn it into something readable

	coded_list = params2list(file_output) // We want it to be an actual list for easier processing

	for(var/client/C in coded_list) // Every key online that's currently a coded admin (not yet read from the file)
		C.clear_admin_verbs()		// will have their verbs removed, just in case.
		C.update_admins(null)

	world.save_admins() // Once that is done, save all current admins.

	global.codeds = new() // Erase the old list of coded admins

	codeds.Add(coded_list) // Add the list we imported to the list of admins in the game

	for(var/client/C in codeds)
		C.clear_admin_verbs()
		C.update_admins(codeds[C]) 	// Update the admin level of all coded admins currently online
									// with their assigned admin level.

	world.save_admins() // Once that is done, save all current admins again.

/*

All that's required is to add the keys to the list and
create an according seperate admin level with corresponding verbs.

I suggest calling this proc on World/New()

and during each world save.

*/

//	for(var/t in coded_list)
//		world << "[t] is a [admin_list[t]] admin"
//		codeds[t]="[coded_list[t]]"