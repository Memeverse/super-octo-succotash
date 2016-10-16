/client/proc/Reward(var/mob/player/A in Players)
	set name = "Reward"
	set category = "Admin"

	if(!src.holder)
		src << "Only administrators may use this command."
		return

	if(!A)
		A = input("Select a player to reward") in Players
	if(!A)
		alert("Canceled rewarding!")
		return
	var/list/Options = new
	Options.Add("Cancel")
	if(src.holder.level >= 2)
		Options.Add("Battle Power","Intelligence","Magic")
	if(src.holder.level >= 3)
		Options.Add("Stats", "Energy", "Resources","Mana","RP Points")
	if(src.holder.level >= 4)
		Options.Add("Gain Rate", "RP Power")
	switch(input(src,"Give what?") in Options)
		if("Cancel")
			alert("Canceled rewarding!")
			return
		if("Magic")
			if(src.holder.level < 2)
				alert("You cannot perform this action. You must be of a higher administrative rank!")
				return
			switch(alert(src,"Reward Magic Levels or Experience?",,"Levels","Experience","Cancel"))
				if("Cancel")
					return
				if("Levels")
					var/oldlevel = A.Magic_Level
					var/Amount=input(src,"How much levels do you want to give them?\nTheir current level is: [A.Magic_Level] ([A.Magic_XP]/[A.Magic_Next])") as num
					if(Amount<=0){src<<"Levels were not raised.";return}
					A.medrewardmagic=Amount
					var/c
					if(!A.magicfocus) {A.magicfocus=1;c=1}
					A.Med()
					A << "Your magic level is being raised, please wait a moment."

/*
					for(var/i=0, i < Amount, i++)
						A.Int_XP = Int_Difficulty*(A.Int_Next/A.Add)
						sleep(20)
*/
					while(A.Magic_Level<(oldlevel+Amount))
						sleep(50)

					if(c)A.magicfocus=0
					A.medrewardmagic=0
					logAndAlertAdmins("[key_name(src)] raised [key_name(A)]'s Magic Level from [oldlevel] to [A.Magic_Level].",2)
					A << "All done."

				if("Experience")
					var/Amount=input(src,"How much Magic XP do you want to give them?\nTheir current level is: [A.Magic_Level] ([A.Magic_XP]/[A.Magic_Next])") as num
					if(Amount<=0){src << "No EXP was given.";return}
					A.Magic_XP += Amount
					logAndAlertAdmins("[key_name(src)] raised [key_name(A)]'s magic XP by [Amount]",2)
		if("Intelligence")
			if(src.holder.level < 2)
				alert("You cannot perform this action. You must be of a higher administrative rank!")
				return
			switch(alert(src,"Reward Intelligence Levels or Experience?",,"Levels","Experience","Cancel"))
				if("Cancel")
					return
				if("Levels")
					var/oldlevel = A.Int_Level
					var/Amount=input(src,"How much levels do you want to give them?\nTheir current level is: [A.Int_Level] ([A.Int_XP]/[A.Int_Next])") as num
					if(Amount<=0){src<<"Levels were not raised.";return}
					A.medreward=Amount
					var/c
					if(!A.ifocus) {A.ifocus=1;c=1}

					A.Med()
					A << "Your intelligence level is being raised, please wait a moment."

/*
					for(var/i=0, i < Amount, i++)
						A.Int_XP = Int_Difficulty*(A.Int_Next/A.Add)
						sleep(20)
*/
					while(A.Int_Level<(oldlevel+Amount))
						sleep(50)

					if(c)A.ifocus=0
					A.medreward=0
					logAndAlertAdmins("[key_name(src)] raised [key_name(A)]'s Intelligence Level from [oldlevel] to [A.Int_Level].",2)
					A << "All done."

				if("Experience")
					var/Amount=input(src,"How much Intelligence XP do you want to give them?\nTheir current level is: [A.Int_Level] ([A.Int_XP]/[A.Int_Next])") as num
					if(Amount<=0){src << "No EXP was given.";return}
					A.Int_XP += Amount
					logAndAlertAdmins("[key_name(src)] raised [key_name(A)]'s Intelligence XP by [Amount]",2)

		if("Stats")

			if(src.holder.level < 3)
				alert("You cannot perform this action. You must be of a higher administrative rank!")
				return

			var/Player_Count = length(Players)
			var/Str_Total=0
			var/End_Total=0
			var/Spd_Total=0
			var/Pow_Total=0
			var/Res_Total=0
			var/Off_Total=0
			var/Def_Total=0

			for(var/mob/player/P in Players)

				var/str = (P.StrMod<1 ? P.StrMod+1 : P.StrMod)
				var/end = (P.EndMod<1 ? P.EndMod+1 : P.EndMod)
				var/spd = (P.SpdMod<1 ? P.SpdMod+1 : P.SpdMod)
				var/pow = (P.PowMod<1 ? P.PowMod+1 : P.PowMod)
				var/res = (P.ResMod<1 ? P.ResMod+1 : P.ResMod)
				var/off = (P.OffMod<1 ? P.OffMod+1 : P.OffMod)
				var/def = (P.DefMod<1 ? P.DefMod+1 : P.DefMod)

				Str_Total+=P.Str/str
				End_Total+=P.End/end
				Spd_Total+=P.Spd/spd
				Pow_Total+=P.Pow/pow
				Res_Total+=P.Res/res
				Off_Total+=P.Off/off
				Def_Total+=P.Def/def

			var/list/statslist= list("Strength","Endurance","Speed","Force","Resistance","Offense","Defense","Everything","Cancel")
			var/statchoice=input(src,"Which stat ") in statslist

			switch(statchoice)
				if("Strength")
					var/Stat_Average=Str_Total/Player_Count
					var/Amount=input(src,"How much you want to raise their [statchoice]?\nAverage is [Commas(Stat_Average)]") as num
					if(!Amount)
						return
					logAndAlertAdmins("[key_name(src)] raised [key_name(A)]'s [statchoice] by [Commas(Amount)] from [Commas(A.Str/A.StrMod)] to [Commas((A.Str/A.StrMod)+Amount)]",2)
					A.Str+=Amount

				if("Endurance")
					var/Stat_Average=End_Total/Player_Count
					var/Amount=input(src,"How much you want to raise their [statchoice]?\nAverage is [Commas(Stat_Average)]") as num
					if(!Amount)
						return
					logAndAlertAdmins("[key_name(src)] raised [key_name(A)]'s [statchoice] by [Commas(Amount)] from [Commas(A.End/A.EndMod)] to [Commas((A.End/A.EndMod)+Amount)]",2)
					A.End+=Amount

				if("Speed")
					var/Stat_Average=Spd_Total/Player_Count
					var/Amount=input(src,"How much you want to raise their [statchoice]?\nAverage is [Commas(Stat_Average)]") as num
					if(!Amount)
						return
					logAndAlertAdmins("[key_name(src)] raised [key_name(A)]'s [statchoice] by [Commas(Amount)] from [Commas(A.Spd/A.SpdMod)] to [Commas((A.Spd/A.SpdMod)+Amount)]",2)
					A.Spd+=Amount

				if("Force")
					var/Stat_Average=Pow_Total/Player_Count
					var/Amount=input(src,"How much you want to raise their [statchoice]?\nAverage is [Commas(Stat_Average)]") as num
					if(!Amount)
						return
					logAndAlertAdmins("[key_name(src)] raised [key_name(A)]'s [statchoice] by [Commas(Amount)] from [Commas(A.Pow/A.PowMod)] to [Commas((A.Pow/A.PowMod)+Amount)]",2)
					A.Pow+=Amount

				if("Resistance")
					var/Stat_Average=Res_Total/Player_Count
					var/Amount=input(src,"How much you want to raise their [statchoice]?\nAverage is [Commas(Stat_Average)]") as num
					if(!Amount)
						return
					logAndAlertAdmins("[key_name(src)] raised [key_name(A)]'s [statchoice] by [Commas(Amount)] from [Commas(A.Res/A.ResMod)] to [Commas((A.Res/A.ResMod)+Amount)]",2)
					A.Res+=Amount

				if("Offense")
					var/Stat_Average=Off_Total/Player_Count
					var/Amount=input(src,"How much do you want to raise their [statchoice]?\nAverage is [Commas(Stat_Average)]") as num
					if(!Amount)
						return
					logAndAlertAdmins("[key_name(src)] raised [key_name(A)]'s [statchoice] by [Commas(Amount)] from [Commas(A.Off/A.OffMod)] to [Commas((A.Off/A.OffMod)+Amount)]",2)
					A.Off+=Amount

				if("Defense")
					var/Stat_Average=Def_Total/Player_Count
					var/Amount=input(src,"How much you want to raise their [statchoice]?\nAverage is [Commas(Stat_Average)]") as num
					if(!Amount)
						return
					logAndAlertAdmins("[key_name(src)] raised [key_name(A)]'s [statchoice] by [Commas(Amount)] from [Commas(A.Def/A.DefMod)] to [Commas((A.Def/A.DefMod)+Amount)]",2)
					A.Def+=Amount

				if("Everything")
					var/Stat_Average=(Str_Total+End_Total+Spd_Total+Pow_Total+Res_Total+Off_Total+Def_Total)/Player_Count
					var/Amount=input(src,"How much you want to raise their stats?\nAverage is [Commas(Stat_Average)]") as num
					if(!Amount)
						return
					logAndAlertAdmins("[key_name(src)] changed [key_name(A)]'s stats to [Commas(Amount)]",2)
					A.Str+=Amount
					A.End+=Amount
					A.Spd+=Amount
					A.Pow+=Amount
					A.Res+=Amount
					A.Off+=Amount
					A.Def+=Amount
				else
					return


		if("RP Points")
			if(src.holder.level < 3)
				alert("You cannot perform this action. You must be of a higher administrative rank!")
				return
			var/Amount=input(src,"How many RP Points do you want to give them? They already have [A.RP_Points]") as num
			if(!Amount)
				return
			if(Amount < 0)
				Amount = 0
				return
			if(Amount == 0)
				return
			A.RP_Points += Amount
			A.RP_Earned -= Amount
			A.RP_Total += Amount
			logAndAlertAdmins("[key_name(src)] raised [key_name(A)]'s RP Points by [Amount].",2)
		if("Energy")
			if(src.holder.level < 3)
				alert("You cannot perform this action. You must be of a higher administrative rank!")
				return
			var/Amount=input(src,"What do you want to set their Maximum Ki to?\nTheir current level is: [A.Ki]/[A.MaxKi])") as num
			if(!Amount)
				return
			var/oldenergy = A.MaxKi
			A.MaxKi=Amount
			logAndAlertAdmins("[key_name(src)] raised [key_name(A)]'s energy from [Commas(oldenergy)] to [Commas(Amount)]",2)
		if("Resources")
			if(src.holder.level < 3)
				alert("You cannot perform this action. You must be of a higher administrative rank!")
				return
			var/curamount
			for(var/obj/Resources/R in A) curamount=R.Value
			var/Amount=input(src,"How many resources?\nThey currently have: [curamount]") as num
			if(!Amount)
				return
			for(var/obj/Resources/R in A) R.Value+=Amount
			logAndAlertAdmins("[key_name(src)] gave [A] [Commas(Amount)]$",2)
		if("Mana")
			if(src.holder.level < 3)
				alert("You cannot perform this action. You must be of a higher administrative rank!")
				return
			var/curamount
			for(var/obj/Mana/R in A) curamount=R.Value
			var/Amount=input(src,"How much mana? They currently have: [curamount]") as num
			if(!Amount)
				return
			for(var/obj/Mana/R in A) R.Value+=Amount
			logAndAlertAdmins("[key_name(src)] gave [A] [Commas(Amount)] mana",2)
		if("Battle Power")
			var/Player_Count=0
			var/Average_Power=0
			var/Strongest_Power=0
			for(var/mob/player/B in Players) if(B.Race==A.Race&&B.Class==A.Class)
				Player_Count++
				Average_Power+=B.Base
				if(B.Base>Strongest_Power) Strongest_Power=B.Base
			Average_Power/=Player_Count
			var/Boost=input("Base: [Commas(A.Base)]. Race: [A.Race] [A.Class]. Average: [Commas(Average_Power)]. \
			Strongest: [Commas(Strongest_Power)]. Total Online: [Player_Count]. Recommended for Class 2: \
			[Commas(Average_Power*1.2)]. Recommended for Class 3: [Commas(Average_Power*1.5)]") as num
			if(!A) return
			if(round(A.Base)==Boost) return
			logAndAlertAdmins("[key_name(src)] brought [key_name(A)] the [A.Race] [A.Class] from [Commas(A.Base)] to [Commas(Boost)] base",2)
			A.Base=Boost
		if("Gain Rate")
			if(src.holder.level < 4)
				alert("You cannot perform this action. You must be of a higher administrative rank!")
				return
			var/Boost=input(src,"[A] the [A.Race]'s Gain Rate is currently at [Commas(A.BPMod)]x. Input what \
			amount you want them to have.") as num
			if(!Boost)
				return
			logAndAlertAdmins("[key_name(src)] brought [key_name(A)] the [A.Race] from [Commas(A.BPMod)]x to [Commas(Boost)]x Gain Rate",2)
			A.BPMod=Boost
		if("RP Power")
			if(src.holder.level < 4)
				alert("You cannot perform this action. You must be of a higher administrative rank!")
				return
			var/Boost=input(src,"[A] the [A.Race]'s RP Power is currently at [Commas(A.RP_Power)]x. Input what \
			amount you want them to have.") as num
			if(!Boost)
				return
			logAndAlertAdmins("[key_name(src)] brought [key_name(A)] the [A.Race] from [Commas(A.RP_Power)]x to [Commas(Boost)]x RP Power",2)
			A.RP_Power=Boost