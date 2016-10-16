

mob/proc/Anger() if(Anger<MaxAnger&&!ismystic)
	view(src)<<"<font color=#FF0000>[src] gets angry!"
	if(!isnull(src.client)) src.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(src)] gets angry!\n")

	//Last_Anger=world.realtime
	Anger_Restoration=1
	if(MaxAnger>100) Anger=MaxAnger
mob/proc/Calm()
	view(src)<<"[src] becomes calm"
	Anger=100
	Anger_Restoration=0


mob/proc/Fight() if(attacking)
	if(client)
		for(var/obj/items/Sword/A in src) if(A.suffix&&A.icon) if("Sword" in icon_states(A.icon))
			if("Sword" in icon_states(icon)) flick("Sword",src);return
	flick("Attack",src)

mob/proc/Blast() if(attacking) flick("Blast",src)
mob/proc/KO(mob/Z)
	ASSERT(Z)   //test assert

	/*
	* src = the player that GOT KO'd
	* Z = the player or the mob OR the cause of being KO'd
	* Take into account that Z isn't ALWAYS a mob!
	*/
	if(src.afk)
		return
	if(istype(src,/mob/observer))
		return
	if(istype(src,/obj/TrainingEq/Dummy)) del(src)
	if(client) if(icon_state!="KO") // The one who got knocked out
		Stop_TrainDig_Schedulers()
		Oozaru_Revert()
		Alien_Revert()
		Flight_Land()
		Life=100
		hearers(6,src) << 'Knockout.wav'
		Close_Spells()
		if(client)
			src.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(src)] is knocked out by [key_name(Z)]\n")
		icon_state="KO"
		KB=0
		Health=0
		if(src.BPpcnt > 100)
			src.BPpcnt = 100
	//	if(rivalisssj&&!hasssj==1) src<<"You push your training to the limit to catch up to your rival."
		//Anger to onlookers...
		for(var/mob/player/M in oview(src))
			var/KOerIsBad
			for(var/mob/player/A in oview(12))
				for(var/obj/Contact/C in M) if(C.Signature == M.Signature)
					if(C.relation in list("Bad","Very Bad")) KOerIsBad=1
			for(var/obj/Contact/C in M) if(C.Signature == M.Signature)
				if(KOerIsBad)
					if(C.relation=="Very Good")
						M.Anger+=M.MaxAnger-100
						M.ssjanger = 1
						view(M)<<"<font color=red>You notice [M] has become EXTREMELY enraged!!!"
		if(ismob(Z)&&Z.client) // For the one who's the responsible player
			Z.Stop_TrainDig_Schedulers()
			view(src)<<"[src] is knocked out by [Z]!"
			for(var/mob/player/M in view(src)) if(M.client) M.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(src)] is knocked out by [Z] ([Z.lastKnownKey])\n")
			Z.saveToLog("| [Z.client.address ? (Z.client.address) : "IP not found"] | ([Z.x], [Z.y], [Z.z]) | [key_name(Z)] just KOd [key_name(src)] ([src.lastKnownIP])\n")
		else
			view(src)<<"[src] is knocked out by [Z]!"
			for(var/mob/player/M in view(src)) if(M.client) M.saveToLog("| [key_name(src)] is knocked out by [Z]\n")

		if(src.z==15)
			if(src.Health<100)
				src.Health=100
				if(src.icon_state=="KO") src.Un_KO()
				return

		if(Trans_Drain)
			if(Trans_Drain>300)
			else Cancel_Transformation()
		if(ssj>0)
			if(ssjdrain>300&&ssj==1)
			else Cancel_Transformation()
		var/T = 2400/Regeneration
		src.Cancel_Expand()
		src.Cancel_LimitBreaker()
		if(isnum(Regeneration))
			spawn(300)
				spawn(T) src.Un_KO()
		if(Poisoned>Immunity&&prob(50)) spawn Death("???")

	else if(!Frozen)
		Life=100
		Frozen=1
		view(src)<<"[src] is knocked out"
		//if(sim){del(src);return}

		spawn(rand(500,700)) if(src)
			view(src)<<"[src] regains consciousness"
			Health=100
			Frozen=0

mob/proc/Un_KO() if(client&&icon_state=="KO")
	icon_state=""
	attacking=0
	Health=1
	Life=100
	Ki=0
	move=1
	if(Poisoned>Immunity&&prob(50)) spawn Death("???")
	view(src)<<"[src] regains consciousness."

	if(src.client)
		spawn(20) if(prob(10))
			src<<"Being knocked out so much angers you..."
			Anger=MaxAnger
			oview(src)<<"<font color=#FF0000>[src] becomes angry!"
			src.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(src)] gets angry! (being knocked out so much angers you!) \n")
			//spawn(600) if(SSjAble&&!hasssj&&Anger>100&&icon_state!="KO"&&BP>=ssjat) SSj()

mob/proc/resetChargelvl(mob/player/P)
	for(var/obj/Attacks/A in P)
		if(A.chargelvl>1) A.chargelvl=1
		sleep(1)

mob/verb/Attack()
	set category="Skills"
	Stop_TrainDig_Schedulers()
	if(ghostDens_check())
		src << "You're currently in Ghost Form. Disable it first."
		return
	if(Frozen) return
	MeleeAttack()

mob/proc/Opp(var/mob/P) if(!Opp)
	Opp=P
	Stop_TrainDig_Schedulers()
	spawn(100) Opp=null

mob/proc/TrainOpp(var/P)
	if(!P) return
	if(args.len>1)
		return

	var/obj/TrainingEq/_equipment
	if(!istype(P, /obj/TrainingEq))
		return
	else
		_equipment = P

	if(Opp) return
	Opp=_equipment
	Stop_TrainDig_Schedulers()
	spawn(100) Opp=null

mob/proc/DisableTraining()
	TrainingDeactivatedTime+=5
	TrainingDeactivated=1
	ProcOn=1

mob/proc/TrainingTimer()
	spawn while(TrainingDeactivated==1&&ProcOn==1)
		for(var/mob/player/D)
			if(D.TrainingDeactivated==1)  //in world
				sleep(1)
				if(D.TrainingDeactivatedTime>=0)
					D.TrainingDeactivatedTime-=5
					D.ProcOn=1
					D.TimerOn=1
				else
				//	D.TrainingDeactivatedTime=0
					D.ProcOn=0
					D.TimerOn=0 //sanity check
				if(D.TrainingDeactivatedTime==0||D.TrainingDeactivatedTime<=0)
					D.TrainingDeactivated=0
					D.ProcOn=0
					D.TimerOn=0
					return  //break
			else
				sleep(50)
				ProcOn=0
			sleep(50)
//Find out how to self reference proc so that it doesn't loop itself every time an attack is made.  Try setting proc on while cond to 1?


mob/proc/MeleeAttack()
	if(S)
		S.Lasers()
		return
	src.Bandages()
	for(var/obj/Invisibility/A in src)
		if(src.invisibility)
			if(locate(A) in src)
				if(A.Using)
					src.invisibility=0
					src.see_invisible=0
					src << "As you attack, you feel your body become tense and you turn visible again!"
					spawn(45){A.Using=0;src<<"You feel your body relax again."}


	for(var/obj/TrainingEq/E in get_step(src,dir)) if(icon_state!="Meditate"&&icon_state!="Train"&&icon_state!="KO")
		var/Bag = 0
		if(istype(E,/obj/TrainingEq/Dummy))
			if(!attacking)
				attacking=1
				spawn(2) attacking=0
				if(E.icon_state=="Off") spawn(1000) if(E) E.icon_state="Off"
				E.icon_state="On"
				if(E.dir==turn(dir,180))
					Fight()
					TrainOpp(E)
					if(prob(50)) E.dir=turn(E.dir,90)
					else E.dir=turn(E.dir,-90)
				else
					flick("Attack",src)
					DisableTraining()
					if(ProcOn==1&&TimerOn==0) TrainingTimer()  //	if(!usr.TrainingTimer()
				var/Damage=((Str/E.End)+(BP/(E.BP*10)))*rand(3,6)
				for(var/obj/items/Boxing_Gloves/G in src)
					if(G.suffix)
						Damage = Damage / 10
						src.Spar = 1
						break
				if(!isnum(E.Health)) return
				E.Health-=Damage
				if(E.Health<=0&&E.icon_state!="KO")
					E.Health=0
					E.icon_state="KO"
					spawn(600) if(E) if(E.Health<=0) del(E)
					return

		else if(istype(E,/obj/TrainingEq/Punching_Bag)) if(E.Health>0&&dir==EAST&&Ki>0.1)
			Bag = 1
		else if(istype(E,/obj/TrainingEq/Magic_Goo)) if(E.Health>0&&dir==EAST&&Ki>0.1)
			Bag = 1
		if(Bag)
			if(!attacking)
				flick("Hit",E)
				attacking=1
				TrainOpp(E)
				Ki-=0.1
				spawn(Refire) attacking=0 //Refire*.05 original code -  Combat CPU optimization
				flick("Hit",E)
				Fight()
				flick("Attack",src)
				var/Damage=((Str/E.End)+(BP/(E.BP*10)))*rand(3,6)
				for(var/obj/items/Boxing_Gloves/G in src)
					if(G.suffix)
						Damage = Damage / 10
						break
				if(!isnum(E.Health)) return
				E.Health-=Damage
				if(E.Health<=0&&E.icon_state!="Destroyed") E.icon_state="Destroyed"
		return

	for(var/mob/M in get_step(src,dir)) if(!ghostDens_check(M)&&M.attackable&&icon_state!="Meditate"&&icon_state!="Train"&&icon_state!="KO")
		for(var/obj/items/Regenerator/R in range(0,src)) if(R.z) return
		if(client&&!attacking)
			if(Ki<1) return
			Ki-=1
		if(M.client&&client) if(M.client.computer_id==client.computer_id) // Based on computer ID instead of IP.
			src<<"Do not interact with alternate keys"
			src.saveToLog("| [src.client.address ? (src.client.address) : "IP not found"] | ([src.x], [src.y], [src.z]) | [key_name(src)] has been forced off the server for attempted alt interaction.\n")
			Logout()
		if(istype(M,/mob/observer))
			return
		if(!attacking) if(M.afk == 0)
			if(client&&M.icon_state=="Flight"&&icon_state!="Flight") return
			if((M.icon_state!="KO"&&M.client)||(!M.Frozen&&!M.client))
				attacking=1
				Fight()
				if(M.attacking==1) Opp(M)
				var/Sword_Damage=0
				for(var/obj/items/Sword/A in src) if(A.suffix) Sword_Damage=A.Health
				if(Sword_Damage>BP*2) Sword_Damage=BP*2
				var/Damage=(Str*(BP+Sword_Damage))/(M.End*M.BP)*rand(2,5)
				for(var/obj/items/Boxing_Gloves/G in src)
					if(G.suffix)
						Damage = Damage / 10
						break
				var/Evasion=(BP*(Off+(Spd*0.2)))/(M.BP*(M.Def+(M.Spd*0.22)))
				if(Sword_Damage) Evasion*=0.5 // Evansion*=2 You'd ASSUME this meant the chance to evade is doubled. This isn't the case (if!prob <--)
				if(M.icon_state=="Meditate") Evasion*=0.5
			//	if(M.client) for(var/obj/Contact/C in src) if(C.name=="[M.name] ([M.lastKnownKey])")
			//		if(C.relation in list("Rival/Bad","Rival/Good")) Evasion*=0.5
			//		if(C.relation in list("Good","Very Good")) Damage*=0.5
				var/Your_Zanzoken=Zanzoken
				var/Their_Zanzoken=M.Zanzoken
				if(Your_Zanzoken>1000) Your_Zanzoken=1000
				if(Their_Zanzoken>1000) Their_Zanzoken=1000
				var/Zanzoken_Boost=Their_Zanzoken/Your_Zanzoken //Multiplies the effect of offense and defense.
				if(Zanzoken_Boost>2) Zanzoken_Boost=2
				if(!prob(Evasion*30/Zanzoken_Boost))
					flick('Zanzoken.dmi',M)
					var/S = pick("1","2","3")
					if(S == "1")
						hearers(6,M) << 'Melee_Dodge1.wav'
					if(S == "2")
						hearers(6,M) << 'Melee_Dodge2.wav'
					if(S == "3")
						hearers(6,M) << 'Melee_Dodge3.wav'
				else //Successful hit
					if(!prob(Evasion*30/Zanzoken_Boost))
						new/obj/shockwave(M.loc)
						Damage = Damage * 0.5
						var/S = pick("1","2")
						if(S == "1")
							hearers(6,M) << 'Melee_Block1.wav'
						if(S == "2")
							hearers(6,M) << 'Melee_Block2.wav'
					if(prob(25))
						var/obj/impact1/I = new(M.loc)
						if(prob(50))
							I.icon_state = "impact2"
						if(usr.dir == SOUTH)
							I.loc = locate(M.x,M.y-1,M.z)
						if(usr.dir == NORTH)
							I.loc = locate(M.x-1,M.y+1,M.z)
						if(usr.dir == EAST)
							I.loc = locate(M.x+1,M.y,M.z)
						if(usr.dir == WEST)
							I.loc = locate(M.x-2,M.y,M.z)
						I.dir = usr.dir
					var/Old_State=M.icon_state
					if(M.icon_state=="KB") Old_State=""
					M.KB=round(Damage*0.5)
					if(M.KB>20) M.KB=20
					ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
					while(M!=null&&M.KB>1)
						if(M==null) break // Sanity check
						if(M.client) M.icon_state="KB"
						M.KB-=1
						M.Knockback()
						if(M) step_away(M,src,50)
						sleep(1)
					//if(!isnull(M)) M.KB=0  Testing a fix for the null.kb error at 436.
					if(M&&M.client&&M.icon_state!="KO") M.icon_state=Old_State

					if(icon_state!="KO"&&prob(Zanzoken*0.1)&&Warp&&(locate(/obj/Zanzoken) in src||Zanzoken>5000))
						Damage*=0.1*SpdMod //Since speed doesnt play into refire for combos, it must compensate.
						flick('Zanzoken.dmi',src)
						sleep(1)
						attacking=0
						if(M&&M.Health-Damage>0)
							M.KB=0
							var/list/Locs=new
							for(var/turf/A in oview(1,M)) if(!A.density&&!(locate(/mob) in A)&&A.Enter(src)&&!(locate(/obj/Props/Edges) in A)&&!A.Water) Locs+=A
							for(var/turf/T in Locs) if(locate(/mob) in T) Locs-=T
							if(locate(/turf) in Locs)
								var/turf/B=pick(Locs)
								if(B)
									loc=locate(B.x,B.y,B.z)
									dir=get_dir(src,M)
									M.dir=get_dir(M,src)

					if(M)
						M.KB=0
						if(M.client) M.icon_state=Old_State
					var/obj/items/Armor/A
					var/Chance = 50
					for(var/obj/items/Armor/B in M) if(B.suffix)
						A=B
						break
					for(var/obj/items/Power_Armor/C in M) if(C.suffix)
						A=C
						Chance = 75
						break
					if(A&&prob(Chance))
						if(!isnum(A.Health)) return
						A.Health-=BP*StrMod*0.05
						A.desc = initial(A.desc)+"<br>[Commas(A.Health)] Durability Armor"
						if(A.Health<=0)
							A.Health=0
							view(M)<<"[M]'s [A] is destroyed"
							M.saveToLog("| [M.client.address] | ([M.x], [M.y], [M.z]) | [key_name(M)] [A] is destroyed.\n")
							if(istype(A,/obj/items/Power_Armor))
								M.Eject(A)
								A.desc = initial(A.desc)+"<br>[Commas(A.Health)] Durability Armor"
							else
								M.Equip_Magic(A,"Remove")
								M.overlays.Remove(A.icon)
								A.suffix=null
								A.desc = initial(A.desc)+"<br>[Commas(A.Health)] Durability Armor"
					else if(M)
						if(!isnum(M.Health)) return
						if(src.Spar == 0)
							var/C = Damage*3
							if(prob(C))
								var/L = list("Random")
								M.Injure_Hurt(Damage,L)
						var/S = pick("1","2","3")
						if(S == "1")
							hearers(6,M) << 'Melee_Strike1.wav'
						if(S == "2")
							hearers(6,M) << 'Melee_Strike2.wav'
						if(S == "3")
							hearers(6,M) << 'Melee_Strike3.wav'
						M.Health-=Damage
						if(M.Health<=0) M.KO(src)

				//world << "DEBUG: REFIRE [Refire]"
				spawn(Refire)
					attacking=0
					//world << "DEBUG: attacking 0 ([attacking]) **"

			else
				attacking=1
				spawn(Refire) attacking=0
				Fight()
				if(!isnum(M.Life)) return
				M.Life-=3*((BP*Str)/(M.Base*M.Body*M.End))
				M.KB=round((Str/M.End)*5)
				if(M.KB>5) M.KB=5
				while(M&&M.KB)
					step_away(M,src,50)
					M.KB-=1
					sleep(1)
				if(M&&M.Life<=0) M.Death(src)

// AI_START
// Activate the AI if attacking an NPC
// If things are giving you errors just comment this part out.
		if(istype(M,/NPC_AI))
		//	world<<"Initializing AI attack code"
			var/NPC_AI/A = M
			A.target = src
		//	world<<"[A] target set to [src]."
			if(A.Health<90) A.docile = 0
			if(!A.active)
			//	world<<"Activating NPC_AI code."
				spawn A.Activate_NPC_AI()
// AI_END

		return

	for(var/obj/A in get_step(src,dir)) if(icon_state!="Meditate"&&icon_state!="Train"&&icon_state!="KO"&&!attacking)
		if(A.type != /obj/Blast)
			attacking=1
			spawn(Refire) attacking=0
			Fight()
			if(!isnum(A.Health)) return
			if(A.type == /obj/Door/)
				A.Health-=Str*5
			else
				A.Health-=Str
			if(A.Health<=0)
				new/obj/Crater(locate(A.x,A.y,A.z))
				del(A)
/*obj/Dust
	density=0
	icon='Dust.dmi'
	layer=5
	Grabbable=0
	New() spawn(rand(120,150)) if(src) del(src) // Dust will stay 2 - 4 seconds tops
proc/Stir_Up_Dust(mob/A,Amount=2)
	while(Amount)
		Amount-=1
		var/obj/Dust/D=new
		D.loc=locate(A.x,A.y,A.z)
		D.icon=pick('Air Dust.dmi')
		D.pixel_y=rand(-16,16)
		D.pixel_x=rand(-16,16)
		walk_rand(D,rand(20,160))*/