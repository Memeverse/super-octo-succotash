sf_SpamFilter

	//============================================================================================
	var
		sf_file	= "sf_save.xml"

	//============================================================================================
	proc
		//----------------------------------------------------------------------------------------
		//	Loads the chat settings.  Called automatically when created.
		//	Returns TRUE on success.
		sf_Load()
			if ( !fexists(src.sf_file) )	return FALSE

			var/XML/Element/root			= xmlRootFromFile(src.sf_file)
			if (!root)						return

			var/XML/Element/E

			E		= root.FirstChildElement("characterspermessage")
			if (E)	src.sf_maxLength			= text2num(E.Text())

			E		= root.FirstChildElement("muteminutes")
			if (E)	src.sf_punishment			= text2num(E.Text())*600

			E		= root.FirstChildElement("chatsperperiod")
			if (E)	src.sf_maxChatsPerPeriod	= text2num(E.Text())

			E		= root.FirstChildElement("secondsperperiod")
			if (E)	src.sf_period				= text2num(E.Text())*10

			E		= root.FirstChildElement("wordfilter")
			if (E)	src.sf_wordfilter			= params2list(sf_wordfilter)

			return TRUE

		//----------------------------------------------------------------------------------------
		//	Saves the chat settings and returns TRUE on success.
		sf_Save()
			if ( fexists(src.sf_file) )	fdel(src.sf_file)
			var/saveText	= \
{"
<chat>
	<characterspermessage>[src.sf_maxLength]</characterspermessage>
	<muteminutes>[src.sf_punishment/600]</muteminutes>
	<chatsperperiod>[src.sf_maxChatsPerPeriod]</chatsperperiod>
	<secondsperperiod>[src.sf_period/10]</secondsperperiod>
	<wordfilter>[list2params(src.sf_wordfilter)]</wordfilter>
</chat>
"}
			text2file(saveText, src.sf_file)

			return TRUE
