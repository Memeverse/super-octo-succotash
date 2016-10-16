
/obj/Reward_Instance
	Click()
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		if(src.Reward_Given == "Yes")
			usr << "This player was already given their rewards on this key."
			switch(input("Do you want to revert the reward on this player? In doing so, the currently set reward tier will be removed from their BP and Energy and they will be reset and placed back into the Reward Pending tab.") in list("No","Yes"))
				if("No")
					return
				if("Yes")
					log_admin("[key_name(usr)] reverted [src]'s rewards.")
					alertAdmins("[key_name(usr)] reverted [src]'s rewards.")
					src.Reward_Given = "No"
					src.Reward_Revert = 1
					for(var/mob/player/M in Players)
						if(src.Reward_Key == M.client.key) if(src.Reward_Save == M.real_name) if(src.Reward_Confirmed == "Yes")if(src.Reward_Given == "No")
							var/N = 1
							if(src.Reward_Tier == "Low")
								N = Rewards_Low
							if(src.Reward_Tier == "Medium")
								N = Rewards_Medium
							if(src.Reward_Tier == "Medium High")
								N = Rewards_Medium_High
							if(src.Reward_Tier == "High")
								N = Rewards_High
							N = N * M.BPMod
							M.Base -= N
							M.MaxKi -= Rewards_Energy
							M.Ki = M.MaxKi
							usr << "[M] had their reward reverted just now."
							alertAdmins("[src]'s reward was just reverted.")
							src.icon = null
							src.overlays = null
							src.name = "[M.client.key] - [M.real_name]"
							src.Reward_Revert = 0
							var/icon/A=new(M.icon)
							src.icon = A
							for(var/X in M.overlays) if(X:icon)
								var/icon/A2=new(X:icon,X:icon_state)
								src.overlays += A2
					src.Reward_Tier = "Not assigned"
					src.Reward_Confirmed = "No"
					return
			return
		if(src.Reward_Confirmed == "Yes")
			switch(input("Do you want to reset the confirmation on this players reward? If you select yes, the reward won't be auto-assigned until you re-confirm the reward.") in list("No","Yes"))
				if("No")
					return
				if("Yes")
					usr << "[src]'s reward is no longer confirmed."
					src.Reward_Confirmed = "No"
					return
		if(src.Reward_Given == "No")
			switch(input("Select which tier of reward this player deserves.") in list("Low","Medium","Medium High","High"))
				if("Low")
					usr << "[src] has now been set to have a Low tier reward."
					src.Reward_Tier = "Low"
					log_admin("[key_name(usr)] set [src]'s rewards for Low.")
					alertAdmins("[key_name(usr)] set [src]'s rewards for Low.")
				if("Medium")
					usr << "[src] has now been set to have a Medium tier reward."
					src.Reward_Tier = "Medium"
					log_admin("[key_name(usr)] set [src]'s rewards for Medium.")
					alertAdmins("[key_name(usr)] set [src]'s rewards for Medium.")
				if("Medium High")
					usr << "[src] has now been set to have a High tier reward."
					src.Reward_Tier = "Medium High"
					log_admin("[key_name(usr)] set [src]'s rewards for High.")
					alertAdmins("[key_name(usr)] set [src]'s rewards for High.")
				if("High")
					usr << "[src] has now been set to have a Very High tier reward."
					src.Reward_Tier = "High"
					log_admin("[key_name(usr)] set [src]'s rewards for Very High.")
					alertAdmins("[key_name(usr)] set [src]'s rewards for Very High.")
		if(src.Reward_Confirmed == "No")if(src.Reward_Tier != "Not assigned")
			switch(input("Do you want to confirm this reward? In doing so, the player will be assigned the reward when possible. If you select No, you can re-assign the reward again after clicking the player once more.") in list("No","Yes"))
				if("No")
					return
				if("Yes")
					usr << "[src]'s rewards have been confirmed."
					log_admin("[key_name(usr)] confirms [src]'s rewards.")
					alertAdmins("[key_name(usr)] confirms [src]'s rewards.")
					src.Reward_Confirmed = "Yes"
					for(var/mob/player/M in Players)
						if(src.Reward_Key == M.client.key) if(src.Reward_Save == M.real_name) if(src.Reward_Confirmed == "Yes") if(src.Reward_Given == "No")
							src.Reward_Given = "Yes"
							var/N = 1
							if(src.Reward_Tier == "Low")
								N = Rewards_Low
							if(src.Reward_Tier == "Medium")
								N = Rewards_Medium
							if(src.Reward_Tier == "Medium High")
								N = Rewards_Medium_High
							if(src.Reward_Tier == "High")
								N = Rewards_High
							N = N * M.BPMod
							M.Base += N
							M.MaxKi += Rewards_Energy
							usr << "[M] was just assigned their reward!"
							alertAdmins("[src]'s reward was just applied.")
							src.icon = null
							src.overlays = null
							src.name = "[M.client.key] - [M.real_name]"
							var/icon/A=new(M.icon)
							src.icon = A
							for(var/X in M.overlays) if(X:icon)
								var/icon/A2=new(X:icon,X:icon_state)
								src.overlays += A2
							M << "Your reward has been given."
					return
obj
	var
		Reward_Given = "No"
		Reward_Confirmed = "No"
		Reward_Key = null
		Reward_Tier = "Not assigned"
		Reward_Save = null
		Reward_Revert = 0

/client/proc/Toggle_Rewards()
	set name = "Toggle Rewards"
	set category = "Admin"

	if(!usr.client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	if(Rewards_Active == 0)
		for(var/mob/M in Players)
			if(!Reward_Key_List.Find(M.client.key))
				Reward_Key_List += M.client.key
				var/obj/Reward_Instance/O = new
				if(M.real_name)
					O.Reward_Save = "[M.real_name]"
				O.name = "[M.client.key] - [M.real_name]"
				O.Reward_Key = "[M.client.key]"
				var/icon/A=new(M.icon)
				O.icon = A
				for(var/X in M.overlays) if(X:icon)
					var/icon/A2=new(X:icon,X:icon_state)
					O.overlays += A2
				Reward_List += O
		Rewards_Active = 1
		log_admin("[key_name(usr)] activated the reward tab, rewarding has now begun.")
		alertAdmins("[key_name(usr)] activated rewarding. A tab has appeared with players who have logged into the game with their characters. Inside the Reward tab, click each player to assign a reward.")
		return
	else
		switch(input("Are you sure you want to turn rewarding off? Admins won't be able to reward players after and the list of players who have been rewarded will be wiped clean and ready for next time rewards are activated.") in list("No","Yes"))
			if("No")
				return
			if("Yes")
				switch(input("Choose") in list("Confirm","Cancel"))
					if("Cancel")
						return
					if("Confirm")
						Rewards_Active = 0
						for(var/obj/Reward_Instance/O in Reward_List)
							O.Reward_Given = "No"
							O.Reward_Confirmed = "No"
							O.Reward_Tier = "Not assigned"
						log_admin("[key_name(usr)] disabled the reward tab, rewarding has now stopped.")
						alertAdmins("[key_name(usr)] has disabled the reward tab, rewarding has now stopped. The player reward list has been wiped clean for when the next set of rewards begin.")
						return