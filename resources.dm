

obj/Resources
	icon='Misc.dmi'
	icon_state="ZenniBag"
	Savable=1
	var/Value=0
	verb/Drop()
		var/Money=input("Drop how much Resources? ([Commas(Value)])") as num
		if(Money>Value) Money=Value
		if(Money<=0) usr<<"You must atleast drop 1"
		if(Money>=1) if(isturf(usr.loc))
			Money=round(Money)
			Value-=Money
			var/obj/Resources/A=new
			A.loc=usr.loc
			A.Value=Money
			A.name="[Commas(A.Value)] Resources"
			view(usr)<<"<font size=1><font color=teal>[usr] drops [A]."
			step(A,usr.dir)
			for(var/mob/player/M in view(usr)) if(M.client)
				M.saveToLog("<font color=red>| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] drops [Commas(Money)] Resources</font>\n")
	Treasure
		icon = 'treasure.dmi'
		New()
			src.Value = rand(1000,10000)
			src.name = "Treasure - [Commas(src.Value)]"

obj/Mana
	icon='Mana.dmi'
	Savable=1
	var/Value=0
	verb/Drop()
		var/Money=input("Drop how much Mana? ([Commas(Value)])") as num
		if(Money>Value) Money=Value
		if(Money<=0) usr<<"You must atleast drop 1"
		if(Money>=1) if(isturf(usr.loc))
			Money=round(Money)
			Value-=Money
			var/obj/Mana/A=new
			A.loc=usr.loc
			A.Value=Money
			A.name="[Commas(A.Value)] Mana"
			view(usr)<<"<font size=1><font color=teal>[usr] drops [A]."
			step(A,usr.dir)
			for(var/mob/player/M in view(usr)) if(M.client)
				M.saveToLog("<font color=red>| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] drops [Commas(Money)] Mana</font>\n")
	Mana_Crystal
		icon = 'Magic Items.dmi'
		icon_state = "crystal"
		New()
			src.Value = rand(1000,10000)
			src.name = "Mana Crystal - [Commas(src.Value)]"