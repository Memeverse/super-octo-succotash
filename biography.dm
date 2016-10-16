var/mob/Description="An easy to use template for character creation is coming soon.  You may describe your character here.  This window is HTML capable to allow users to have full customization of their profile.  Use < br > to add in a line break and < b > and < i > without the spaces for bold and italics respectively."

atom/verb/Edit_Profile()
	var/EditingDescription
//	verb/Edit_Description()
	set category="Other"
	set name="Edit Character Profile"

	if(!src)
		alert("You are not this character!")
		return

	if(!EditingDescription)
		//world<<"Opening description window"
		EditingDescription=1
		Description= input(Description) as message
		src.desc=Description
		EditingDescription=0

/*obj/Show_Profile
	verb/Show_Profile()
		set category="Other"
		set name="Show Description"
		usr<<browse(Description,"window= ;size=700x600")*/
/*obj/Edit_Profile
	verb/Modify_Description()
		set category="Other"
		set name="Edit Description"
		world<<"Attempting to Edit Description"
		for(mob/proc/Edit_Description/M)
			Edit_Description()
		world<<"Edit_Description reached"
mob/proc/Edit_Description()

	var/EditingDescription
/*	verb/Edit_Description()
		set category="Other"
		set name="Edit Description"*/

	if(!src)
		alert("You are not this character!")
		return

	if(!EditingDescription)
		world<<"Opening description window"
		EditingDescription=1
		Description= input(Description) as message
		EditingDescription=0
		src.SaveDescription()
	else
		src<<"You are already editing your description!"
		return

mob/proc/SaveDescription()
	var/savefile/A=new("Data/Players/[lastKnownKey]/Characters/[real_name]desc.sav")
	A["Descriptors"]<<Description

mob/proc/LoadDescription()
	if(fexists("Data/Players/[lastKnownKey]/Characters/[real_name]desc.sav"))
		var/savefile/A=new("Data/Players/[lastKnownKey]/Characters/[real_name]desc.sav")
		A["Descriptors"]>>Description*/

