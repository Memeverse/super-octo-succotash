obj/Attacks/Time_Freeze
	desc="This will send paralyzing energy rings all around nearby people and they will not be able \
	to move until it wears off. The more powerful you are compared to your Opp, the longer the \
	effect will last on them."
	verb/Time_Freeze()
		set category="Skills"
		if(usr.Frozen||usr.icon_state=="KO") return
		usr.overlays-='TimeFreeze.dmi'
		usr.overlays+='TimeFreeze.dmi'
		spawn(10) usr.overlays-='TimeFreeze.dmi'
		for(var/mob/player/M in view(usr)) if(M.client) M.saveToLog("| ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] uses Time Freeze.\n")
		for(var/mob/A in oview(usr))
			if(!A.Frozen&&A.client)
				sleep(10)
				usr.Ki*=0.5
				var/obj/ranged/Blast/Time_Freeze/_TF=new
				_TF.Power=usr.Pow/usr.PowMod
				_TF.Damage=1
				_TF.Offense=usr.Off
				_TF.Belongs_To=usr
				_TF.density=1
				missile(_TF,usr,A)
				_TF.Bump(A)

				//missile('TimeFreeze.dmi',usr,A)

obj/ranged/Blast/Time_Freeze

	icon='TimeFreeze.dmi'
	Deflectable=1

	Bump(mob/A)

		.=..() //call the parent (/obj/ranged/Blast/Bump() ), store the return value
		if(!.)
			oview(A) << "[A] breaks through the Time Freeze technique!"
			for(var/mob/player/M in view(A)) if(M.client) M.saveToLog("| ([A.x], [A.y], [A.z]) | [key_name(A)] defeats [src.Belongs_To]'s Time Freeze.\n")
			return //if it returned false, (movement failed), return false too (and stop this proc)

		A.overlays-='TimeFreeze.dmi'
		A.overlays+='TimeFreeze.dmi'

		if(src.Belongs_To.Lungs) A.Time_Frozen=60
		else A.Time_Frozen=300
		A.Frozen=1
		for(var/mob/player/M in view(A)) if(M.client) M.saveToLog("| ([A.x], [A.y], [A.z]) | [key_name(A)] is captured by [src.Belongs_To]'s Time Freeze.\n")
		spawn(1) A.Time_Freeze_Check()
