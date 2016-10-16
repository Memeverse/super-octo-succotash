sf_SpamFilter

	//============================================================================================
	proc
		//----------------------------------------------------------------------------------------
		//	Gives verbs to C.
		//	The default ones are listed below.
		//	You may wish to remove them if you don't like my interface.
		//	Returns TRUE on success.
		sf_AddInterface(client/C)
			if ( !istype(C) )	return	FALSE

			if(src.sf_SpamControlOpen)
				C << "<b>[C] already has the Spam Control window open.</b>"
				return FALSE

			src.sf_SpamControlOpen = "[C]"

			C.sf_instance	= src

			src.sf_UpdateDisplay(C)

			C.verbs	-= /sf_SpamFilter/verb/sf_Max_Chats_Per_Period
			C.verbs	-= /sf_SpamFilter/verb/sf_Reset
			C.verbs	-= /sf_SpamFilter/verb/sf_Max_Length
			C.verbs	-= /sf_SpamFilter/verb/sf_Punishment
			C.verbs	-= /sf_SpamFilter/verb/sf_Period
			C.verbs	-= /sf_SpamFilter/verb/sf_Save_Settings
			C.verbs	-= /sf_SpamFilter/verb/sf_Edit_Word_Filter
			C.verbs	-= /sf_SpamFilter/verb/sf_Close_Window
			C.verbs	-= /sf_SpamFilter/verb/sf_Refresh_Window

			C.verbs	+= /sf_SpamFilter/verb/sf_Max_Chats_Per_Period
			C.verbs	+= /sf_SpamFilter/verb/sf_Reset
			C.verbs	+= /sf_SpamFilter/verb/sf_Max_Length
			C.verbs	+= /sf_SpamFilter/verb/sf_Punishment
			C.verbs	+= /sf_SpamFilter/verb/sf_Period
			C.verbs	+= /sf_SpamFilter/verb/sf_Save_Settings
			C.verbs	+= /sf_SpamFilter/verb/sf_Edit_Word_Filter
			C.verbs	+= /sf_SpamFilter/verb/sf_Close_Window
			C.verbs	+= /sf_SpamFilter/verb/sf_Refresh_Window

			return TRUE

		//----------------------------------------------------------------------------------------
		//	Removes verbs from C and returns TRUE on success.
		//	Be sure to overwrite this with any skin-specific controls.
		sf_RemoveInterface(client/C)
			if ( !istype(C) )	return FALSE

			C.sf_instance	= null

			C.verbs	-= /sf_SpamFilter/verb/sf_Max_Chats_Per_Period
			C.verbs	-= /sf_SpamFilter/verb/sf_Reset
			C.verbs	-= /sf_SpamFilter/verb/sf_Max_Length
			C.verbs	-= /sf_SpamFilter/verb/sf_Punishment
			C.verbs	-= /sf_SpamFilter/verb/sf_Period
			C.verbs	-= /sf_SpamFilter/verb/sf_Save_Settings
			C.verbs	-= /sf_SpamFilter/verb/sf_Edit_Word_Filter
			C.verbs	-= /sf_SpamFilter/verb/sf_Close_Window
			C.verbs	-= /sf_SpamFilter/verb/sf_Refresh_Window

			src.sf_SpamControlOpen = null

			return TRUE

		//----------------------------------------------------------------------------------------
		//	Updates Viewer's chat option display and returns TRUE on success.
		//	Called by the included verbs.
		//	By default, it does nothing but make sure Viewer is a client.
		//	You'll want to override it for your interface.
		sf_UpdateDisplay(client/Viewer)
			return istype(Viewer)

		Admincheck(client/C)
			if(!C.holder)
				alert("Only administrators may use this command.")
				return FALSE

	//============================================================================================
	verb
		//----------------------------------------------------------------------------------------
		sf_Max_Chats_Per_Period()
			if (!usr || !usr.client || !usr.client.sf_instance)	return FALSE
			usr.client.sf_instance.Admincheck(usr.client)

			var/amount	= input(usr,"How many messages can a chatter send in a period?", \
				"Spam Filter",usr.client.sf_instance.sf_maxChatsPerPeriod) as num
			.		= usr.client.sf_instance.sf_SetMaxChatsPerPeriod(amount)

			logAndAlertAdmins("[key_name_admin(usr)] has adjusted the anti-spam settings. Players can now send [amount] messages in a period.", 2)

			if (.)	usr.client.sf_instance.sf_UpdateDisplay(usr.client)

		//----------------------------------------------------------------------------------------
		sf_Max_Length()
			if (!usr || !usr.client || !usr.client.sf_instance)	return FALSE
			usr.client.sf_instance.Admincheck(usr.client)

			var/amount	= input(usr,"How long can a message be?", \
				"Spam Filter",usr.client.sf_instance.sf_maxLength) as num
			.		= usr.client.sf_instance.sf_SetMaxLength(amount)

			logAndAlertAdmins("[key_name_admin(usr)] has adjusted the OOC character limit to [amount].", 2)

			if (.)	usr.client.sf_instance.sf_UpdateDisplay(usr.client)

		//----------------------------------------------------------------------------------------
		sf_Period()
			if (!usr || !usr.client || !usr.client.sf_instance)	return FALSE
			usr.client.sf_instance.Admincheck(usr.client)

			var/amount	= input(usr,"How many seconds should messages be counted during?", \
				"Spam Filter",usr.client.sf_instance.sf_period/10) as num
			.		= usr.client.sf_instance.sf_SetPeriod(amount*10)

			logAndAlertAdmins("[key_name_admin(usr)] has adjusted the period within which players can send messages to [amount].", 2)

			if (.)	usr.client.sf_instance.sf_UpdateDisplay(usr.client)

		//----------------------------------------------------------------------------------------
		sf_Punishment()
			if (!usr || !usr.client || !usr.client.sf_instance)	return FALSE
			usr.client.sf_instance.Admincheck(usr.client)

			var/amount	= input(usr,"How many minutes should spammers be muted?", \
				"Spam Filter",usr.client.sf_instance.sf_punishment/600) as num
			.		= usr.client.sf_instance.sf_SetPunishment(amount*600)

			logAndAlertAdmins("[key_name_admin(usr)] has adjusted the time spammers are muted for to [amount] minutes.", 2)

			if (.)	usr.client.sf_instance.sf_UpdateDisplay(usr.client)

		//----------------------------------------------------------------------------------------
		sf_Edit_Word_Filter()
			if (!usr || !usr.client || !usr.client.sf_instance)	return FALSE
			usr.client.sf_instance.Admincheck(usr.client)

			var/oldfilter = usr.client.sf_instance.sf_wordfilter

			var/filter	= input(usr, "Seperate the words by using a ; . No spaces. Example: red;white", \
				"Spam filter", list2params(usr.client.sf_instance.sf_wordfilter)) as message
			.		= usr.client.sf_instance.sf_SetWordFilter(params2list(filter))

			var/words
			for(var/a in oldfilter)
				if(a in filter) continue
				words += "[a];"

			logAndAlertAdmins("[key_name_admin(usr)] has adjusted the spam filter. They added [words] ")

			if (.)	usr.client.sf_instance.sf_UpdateDisplay(usr.client)

		//----------------------------------------------------------------------------------------
		sf_Reset()
			if (!usr || !usr.client || !usr.client.sf_instance)	return FALSE
			usr.client.sf_instance.Admincheck(usr.client)

			.		= usr.client.sf_instance.sf_Defaults()
			logAndAlertAdmins("[key_name_admin(usr)] has reset the Spam Control settings to their default value. ")
			if (.)	usr.client.sf_instance.sf_UpdateDisplay(usr.client)

		//----------------------------------------------------------------------------------------
		sf_Save_Settings()
			if (!usr || !usr.client || !usr.client.sf_instance)	return FALSE
			usr.client.sf_instance.Admincheck(usr.client)

			.		= usr.client.sf_instance.sf_Save()
			logAndAlertAdmins("[key_name_admin(usr)] saved the current Spam Control settings.")
			//if (.)	usr.client.sf_instance.sf_UpdateDisplay(usr.client)

		//----------------------------------------------------------------------------------------
		sf_Refresh_Window()
			if (!usr || !usr.client || !usr.client.sf_instance)	return FALSE
			usr.client.sf_instance.Admincheck(usr.client)

			usr.client.sf_instance.sf_UpdateDisplay(usr.client)


		//----------------------------------------------------------------------------------------
		sf_Close_Window()
			if (!usr || !usr.client || !usr.client.sf_instance)	return FALSE
			usr.client.sf_instance.sf_RemoveInterface(usr.client)
			winshow(usr.client,"options_chat", 0)
			alertAdmins("[key_name_admin(src)] is done adjusting the Spam Control settings.", 1)

//////////////////////////////////////////////////////////////////////////////////////////////////
client
	var/sf_SpamFilter/sf_instance