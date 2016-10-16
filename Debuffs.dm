//Place for things like heart virus, ect, to be defined.

mob
	var
		Heart_Virus_Catch = 0
		Heart_Virus_Caught = 0
		Heart_Virus_Immune = 0
	proc
		Heart_Virus()
			if(src.Race == "Saiyan") if(src.Heart_Virus_Caught == 0) if(src.Heart_Virus_Immune == 0) if(src.z == 1) if(Year < 20)
				src.Heart_Virus_Catch = prob(25)
				if(src.Heart_Virus_Catch)
					src.Heart_Virus_Caught = 1
					src.Heart_Virus_Immune = 1
					src.Recovery *= 0.5
					src.Decline *= 0.5
					src << "<font color = red>Your heart feels strange, you feel faint!<br>"
				else
					src.Heart_Virus_Immune = 1
		Heart_Virus_Cure()
			if(src.Heart_Virus_Caught)
				src.Heart_Virus_Caught = 0
				src.Recovery *= 2
				src.Decline *= 2
				src.Heart_Virus_Immune = 1
				return