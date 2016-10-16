/*
// _interface.dm
// created:          24/3/2014
// last modified by: Valekor
// description: players like creating (extensive) descriptions of their characters. These can be look at using the 'Examine' verb
// but having entire walls of text be displayed in the same window as roleplay takes place would cause extensive amounts of clutter.
// as such, there are a few skin instances created to cater to these needs:

// win_playerDsc  - The window which will be opened to display the profile written. Either a simple bit of text or a HTML-styled page, this can be up to the player.
// brow_playerDsc - The actual brower to which the player description will be sent.
// lbl_playerDsc  - Top of the page, a label displaying the character name, perhaps a title of choice.

// win_playerEdit - The window for editing player description.
// inp_playerEdit - A multi-line text input area.
*/

mob/player/verb/edit_profile()
	set name = "Edit Character Profile"
	set category = "Other"

	var/tmp/char_desc = input(src,"Character Description","[src]",src.desc) as message
	src.desc = char_desc
	src << "Your character description has been updated."


/atom/verb/examine(atom/A as mob|obj|turf in view(15,usr))
	set name = "Examine"
	set category = "Other"
	var/tmp/used=0

	if(used==0)
		if(A)	//Derp derp implied versus explicit src
			src = A

		if (!usr)
			return

		if(ismob(usr) && get_dist(usr,src)>15)
			usr << "That's too far away to examine."
			return

		var/icon/I = src.getIconImage()
		usr << "This is \icon[I] \an [src.name]."
		if(A.Serial)
			usr << "It seems to have a serial number of [A.Serial]."
		if(src.desc)
			if(istype(src, /mob/player)) // if they're a player, load description window
				winshow(usr, "win_playerDsc")
				usr << browse(src.desc, "window=brow_playerDsc")
			else
				usr << src.desc
				if(isobj(src))
					usr.Display_Magic(src)

		used=1
		spawn(15) used=0

	return
