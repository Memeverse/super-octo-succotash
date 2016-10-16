obj/After_Image/New()
	spawn(50) if(src)
		flick('Zanzoken.dmi',src)
		spawn(1) if(src) del(src)
mob/proc/After_Image()
	if(Shadow_Power|Zanzoken>=1000) if(!(locate(/obj/After_Image) in loc))
		var/obj/After_Image/A=new(loc)
		A.dir=dir
		A.icon=icon
		A.overlays=overlays
		A.underlays=underlays

turf/Click(turf/T)
	if(!istype(T, /turf/))
		return 0
	if(usr.move&&!usr.KB&&!usr.attacking&&usr.icon_state!="KO"&&usr.icon_state!="Meditate"&&usr.icon_state!="Train")
		if(usr.client.eye!=usr) return
		if(locate(usr) in src) return
		if(usr.Spell_Power) if(usr.Spell_Cost) if(T in range(10,usr)) if(usr.Spell_CD == 0) if(usr.spells_open)
			for(var/obj/Mana/M in usr)
				if(M.Value >= usr.Spell_Cost)
					M.Value -= usr.Spell_Cost
					usr.Spell_CD = 1
					log_ability("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] attempted to strike [key_name(src)] with lightening.")
					usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] attempted to strike [key_name(src)] with lightening.\n")
					spawn(20)
						if(usr)
							usr.Spell_CD = 0
					var/obj/Lightning_Strike/S = new
					S.loc = locate(T.x,T.y + 10,T.z)
					S.Power = usr.Spell_Power
					S.Dest = T
					break
				else
					usr << "You do not have enough mana to continue using this spell."
					usr.Spell_Power = 0
					usr.Spell_Cost = 0
		for(var/obj/Attacks/Explosion/K in usr) if(K.On&&!usr.Using_Explosion)
			if(usr.Ki>=50)
				usr.attacking=3
				usr.Using_Explosion=1
				hearers(6,usr) << 'explosion.wav'
				K.On = 0
				if(prob(10) && K.Experience<4)
					if(K.Level == K.Experience) K.Level++
					K.Experience++
				var/exprange = K.Level <= 4 ? range(K.Level,T) : range(4,T)
				for(var/turf/A in exprange) if(prob(70))
					for(var/atom/X in A)
						if(X.Flammable)
							X.Burning = 1
							X.Burn(X.Health)
					for(var/mob/B in A)
						if(prob(25))
							var/L = list("Hearing")
							B.Injure_Hurt(100,L)
						if(B.icon_state == "Flight") if(prob(25))
							view(20,B) << "[B] is sucked to the ground by the force of the explosion!"
							B.Flight_Land()
						if(B.icon_state!="Flight")

							B.Health-=30*(usr.Pow/B.Res)*(usr.BP/B.BP)
							if(B.Health<=0)
								if(B.client) spawn B.KO("[usr]")
								else spawn B.Death("[usr]")
					for(var/obj/B in A)
						B.Health-=usr.Pow*5
						if(B.Health<=0)
							new /obj/BigCrater(locate(B.x,B.y,B.z))
							del(B)
					new/obj/Explosion(A)
					if(!A.density)
						A.Health=0
						if(usr!=0) A.Destroy(usr,usr.key)
						else A.Destroy("Unknown","Unknown")
					else
						A.Health -= usr.Pow*5
						if(usr!=0) A.Destroy(usr,usr.key)
						else A.Destroy("Unknown","Unknown")
					if(prob(25))
						sleep(1)
				usr.Ki -= 50
				if(!K.Learnable)
					K.Learnable=1
					spawn(100) K.Learnable=0
				spawn(usr.Refire*3)
					if(usr)
						usr.attacking=0
						usr.Using_Explosion=0
			else
				usr<<"You do not have enough energy."
			return
		if(locate(/obj/Door) in src) return
		for(var/obj/Cybernetics/Warp_Module/A in usr) if(A.suffix) if(locate(T) in view(usr))
			if(!T.density)
				flick('Black Hole.dmi',usr)
				usr.Move(T)
				return
		for(var/obj/Zanzoken/A in usr)
			if(usr.Spell_Power) return
			if(usr.Spell_Cost) return
			if(!usr.Warp) return
			if(usr.icon_state=="KB") return
			if(T in view(world.view,usr))
				var/Drain = usr.MaxKi / usr.Zanzoken / usr.KiMod
				if(Drain > usr.MaxKi)
					Drain = usr.MaxKi
				if(!T.density && (!T.Water || usr.icon_state=="Flight") && usr.Ki >= Drain)
					if(!A.Learnable)
						A.Learnable=1
						spawn(100)
							if(A)
								A.Learnable=0
					flick('Zanzoken.dmi',usr)
					var/S = pick("1","2")
					if(S == "1")
						hearers(6,usr) << 'Zanzo1.wav'
					if(S == "2")
						hearers(6,usr) << 'Zanzo2.wav'
					var/turf/Can = get_step_to(usr,T,0)
					if(isturf(Can))
						//world << "Is a turf."
						var/OldDir = usr.dir
						usr.After_Image()
						usr.Move(T)
						usr.dir = OldDir
						usr.Zanzoken += 0.1*usr.ZanzoMod
						usr.Ki-=Drain
					if(Can == null)
						usr << "You can't seem to reach there..."
				return
	if(!T.density&&!(locate(/obj/Door) in T)) if(usr && usr.client.eye==usr) if(usr.icon_state!="KO")
		for(var/obj/Shunkan_Ido/A in usr) if(A.Level>=20)
			if(!usr.Warp) return
			usr.Ki*=0.9
			if(!T.density&&!T.Water)
				flick('Zanzoken.dmi',usr)
				usr.loc=locate(x,y,z)
mob/Click()
	usr.saveToLog("| [usr] clicked [src].\n") //Added so it's easier to keep track of situations where people chase other people or if admins are using super sense.
	if(usr.icon_state != "KO") if(usr.Spell_Power) if(usr.Spell_Cost) if(usr.spells_open) if(usr.Spell_CD == 0) if(src in range(10,usr))
		for(var/obj/Mana/M in usr)
			if(M.Value >= usr.Spell_Cost)
				M.Value -= usr.Spell_Cost
				usr.Spell_CD = 1
				log_ability("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] attempted to strike [key_name(src)] with lightening.")
				usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] attempted to strike [key_name(src)] with lightening.\n")
				spawn(33)
					if(usr)
						usr.Spell_CD = 0
				var/obj/Lightning_Strike/S = new
				S.loc = locate(src.x,src.y + 10,src.z)
				S.Power = usr.Spell_Power
				S.Dest = src.loc
				break
			else
				usr << "You do not have enough mana to continue using this spell."
				usr.Spell_Power = 0
				usr.Spell_Cost = 0
	if(client&&icon_state=="KO"&&src!=usr&&(src in view(1,usr)))
		if(!usr.Lootables || !usr.Lootables.len)
			usr.Lootables = list()
		var/obj/Cancel_Loot/CL = new
		usr.Lootables+= CL
		for(var/obj/Resources/A in src) usr.Lootables+=A
		for(var/obj/Mana/A in src) usr.Lootables+=A
		for(var/obj/A in src) if(A.Stealable) usr.Lootables+=A
		return
	if(usr.client && usr.client.holder && usr==src && !usr.Target)
		Target=src
		return
	if(src==usr|usr.Target==src) Target=null
	else if(client) usr.Target=src
	else for(var/obj/items/Scanner/A in usr) if(A.suffix) usr<<"Scanner: [Commas(BP)]"