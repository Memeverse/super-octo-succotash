
obj/Baby
	icon='Baby Boy.dmi'
	density=1
	var
		Race
		Class
		Base
		Gain_Multiplier
		MaxKi
		Decline
		ParentAddress
		ParentKey
obj/Mate
	var/LastUse=0
	desc="You can use this to create an offspring that will inherit your base power, some of your \
	energy, along with some other things. Depending on your race, you must mate with the opposite sex, \
	or you can reproduce asexually by laying eggs."
	verb/Mate()
		set category="Other"
		if(usr.Injury_Mate == 100)
			usr << "You're too injured to do that."
			return
		if(usr.icon=='Oozbody.dmi'|usr.icon=='Oozarou Gold.dmi') return
		if(Year<LastUse+1)
			usr<<"You cannot use this until 1 year after you last used it"
			return
		if(usr.icon_state=="KO"|usr.Dead) return
		if(!usr.Asexual) for(var/mob/A in get_step(usr,usr.dir)) if(A.client)
			if(A.Injury_Mate == 100)
				usr << "They're too injured to do that."
				return
			switch(input(A,"[usr] wants to mate with you") in list("Yes","No"))
				if("No") return
			if(Year<LastUse+1)
				usr<<"You cannot use this until 1 year after you last used it"
				return
			if(usr.gender!=A.gender&&A.Age>=13&&!A.Asexual&&!usr.Dead&&!A.Dead)
				LastUse=Year
				var/mob/B
				if(prob(50)) B=usr
				else B=A
				B.Cancel_Focus()
				B.Cancel_Expand()
				B.Expand_Revert()
				B.Majin_Revert()
				B.Mystic_Revert()
				B.Cancel_LimitBreaker()
				var/Amount=5
				while(Amount)
					B.Cancel_Transformation()
					Amount-=1
				var/obj/Baby/C=new
				C.Race=B.Race
				C.Base=B.Base-B.Zenkai_Power
				if(Year>=30) if((usr.Race=="Saiyan"&&A.Race=="Human")||(usr.Race=="Human"&&A.Race=="Saiyan"))
					C.Race="Half-Saiyan"
					C.Base*=0.5
				if((usr.Race=="Human"&&A.Race=="Half-Saiyan")||(usr.Race=="Half-Saiyan"&&A.Race=="Human"))
					C.Race="Quarter Saiyan"
					C.Base*=0.5
				if((usr.Race=="Human"&&A.Race=="Quarter Saiyan")||(usr.Race=="Quarter Saiyan"&&A.Race=="Human"))
					C.Race="1/16th Saiyan"
					C.Base*=0.5
				C.Gain_Multiplier=B.Gain_Multiplier
				C.MaxKi=B.MaxKi*0.2/B.KiMod
				C.Decline=B.Decline
				C.ParentAddress=B.client.address
				C.ParentKey=B.key
				C.name="[C.Race], Parent: [B]"
				log_ability("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] mated with [key_name(A)], base ([C.Base])")
				if(usr.gender=="female")
					C.loc = usr.loc
					usr.Clone(A,usr,C)
				else if(A.gender=="female")
					C.loc = A.loc
					usr.Clone(usr,A,C)
			break
		else if(!usr.Dead)
			LastUse=Year
			usr.Cancel_Focus()
			usr.Cancel_Expand()
			usr.Expand_Revert()
			usr.Majin_Revert()
			usr.Mystic_Revert()
			usr.Cancel_LimitBreaker()
			var/Amount=5
			while(Amount)
				usr.Cancel_Transformation()
				Amount-=1
			var/obj/Baby/A=new
			A.Race=usr.Race
			A.Base=usr.Base-usr.Zenkai_Power
			A.Gain_Multiplier=usr.Gain_Multiplier
			A.MaxKi=usr.MaxKi/usr.KiMod
			A.Decline=usr.Decline
			A.icon='Egg.dmi'
			usr.Clone(usr,usr,A)
			A.loc=locate(usr.x,usr.y,usr.z)
			A.name="[A.Race], Parent: [usr]"
			log_ability("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] laid an egg (base ([A.Base])")
			usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] laid an egg. (base [A.Base])\n")
