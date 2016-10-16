//Client/New { ..(); winshow(src,"skills",0);}
//(if((!winget(src,"skills","is-visible")=="true"))return
Client/New() { ..(); winshow(src,"skills",0); }

mob/proc/Set_Minimum_Stats()
	Minimum_Stats=list("Eff"=KiMod,"Str"=StrMod,"End"=EndMod,"Pow"=PowMod,"Res"=ResMod,\
	"Off"=OffMod,"Def"=DefMod,"Spd"=SpdMod,"Reg"=Regeneration,"Rec"=Recovery)
mob/verb/Skill_Points(type as text,skill as text)
	set name=".Skill_Points"
	set hidden=1
	if(!(skill in list("Energy","Strength","Endurance","Speed","Force","Resistance","Offense","Defense",\
	"Regeneration","Recovery"))) return
	if(!(winget(usr,"skills","is-visible")=="true")) return
	if(!(type in list("-","+"))) return
	var/Increase=1
	if(type=="-")
		if(Points==Max_Points) return //You cant subtract any more points if points are full
		Increase=-1
	if(type=="+")
		Increase=1
		if(Points==0) return //You cant add any more points if you had none left
	if(usr.HasCreated!=0)
		usr<< "Trying to abuse a bug, are we? Admins have been notified."
		logAndAlertAdmins("[usr] Tried to abuse to abuse a bug and use extra stat points on their character!",2)
		del(usr)
		return
	Redoing_Stats=1
	var/max = 5
	if(usr.Race == "Alien")
		max = 15
	if(!usr.Redoing_Stats) return
	switch(skill)
		if("Energy")
			if(type=="-")
				if(usr.Total_Stats_Energy != 0)
					usr.Total_Stats_Energy -= 1
				if(KiMod<=Minimum_Stats["Eff"])
					return
			if(type=="+")
				if(usr.Total_Stats_Energy == max)
					usr << "Unable to put more than [max] points into any mod."
					return
				else
					usr.Total_Stats_Energy += 1
			Raise_Energy(Increase)
			if(usr) if(client)
				winset(usr,"Efficiency","text=[KiMod]")
		if("Strength")
			if(type=="-")
				if(usr.Total_Stats_Strength != 0)
					usr.Total_Stats_Strength -= 1
				if(StrMod<=Minimum_Stats["Str"])
					return
			if(type=="+")
				if(usr.Total_Stats_Strength == max)
					usr << "Unable to put more than [max] points into any mod."
					return
				else
					usr.Total_Stats_Strength += 1
			Raise_Strength(Increase)
			if(usr) if(client)
				winset(usr,"[skill]","text=[StrMod]")
		if("Endurance")
			if(type=="-")
				if(usr.Total_Stats_Endurance != 0)
					usr.Total_Stats_Endurance -= 1
				if(EndMod<=Minimum_Stats["End"])
					return
			if(type=="+")
				if(usr.Total_Stats_Endurance == max)
					usr << "Unable to put more than [max] points into any mod."
					return
				else
					usr.Total_Stats_Endurance += 1
			Raise_Durability(Increase)
			if(usr) if(client)
				winset(usr,"[skill]","text=[EndMod]")
		if("Speed")
			if(type=="-")
				if(usr.Total_Stats_Speed != 0)
					usr.Total_Stats_Speed -= 1
				if(SpdMod<=Minimum_Stats["Spd"])
					return
			if(type=="+")
				if(usr.Total_Stats_Speed == max)
					usr << "Unable to put more than [max] points into any mod."
					return
				else
					usr.Total_Stats_Speed += 1
			Raise_Speed(Increase)
			if(usr) if(client)
				winset(usr,"[skill]","text=[SpdMod]")
		if("Force")
			if(type=="-")
				if(usr.Total_Stats_Force != 0)
					usr.Total_Stats_Force -= 1
				if(PowMod<=Minimum_Stats["Pow"])
					return
			if(type=="+")
				if(usr.Total_Stats_Force == max)
					usr << "Unable to put more than [max] points into any mod."
					return
				else
					usr.Total_Stats_Force += 1
			Raise_Force(Increase)
			if(usr) if(client)
				winset(usr,"[skill]","text=[PowMod]")
		if("Resistance")
			if(type=="-")
				if(usr.Total_Stats_Res != 0)
					usr.Total_Stats_Res -= 1
				if(ResMod<=Minimum_Stats["Res"])
					return
			if(type=="+")
				if(usr.Total_Stats_Res == max)
					usr << "Unable to put more than [max] points into any mod."
					return
				else
					usr.Total_Stats_Res += 1
			Raise_Resistance(Increase)
			if(usr) if(client)
				winset(usr,"[skill]","text=[ResMod]")
		if("Offense")
			if(type=="-")
				if(usr.Total_Stats_Off != 0)
					usr.Total_Stats_Off -= 1
				if(OffMod<=Minimum_Stats["Off"])
					return
			if(type=="+")
				if(usr.Total_Stats_Off == max)
					usr << "Unable to put more than [max] points into any mod."
					return
				else
					usr.Total_Stats_Off += 1
			Raise_Offense(Increase)
			if(usr) if(client)
				winset(usr,"[skill]","text=[OffMod]")
		if("Defense")
			if(type=="-")
				if(usr.Total_Stats_Def != 0)
					usr.Total_Stats_Def -= 1
				if(DefMod<=Minimum_Stats["Def"])
					return
			if(type=="+")
				if(usr.Total_Stats_Def == max)
					usr << "Unable to put more than [max] points into any mod."
					return
				else
					usr.Total_Stats_Def += 1
			Raise_Defense(Increase)
			if(usr) if(client)
				winset(usr,"[skill]","text=[DefMod]")
		if("Regeneration")
			if(type=="-")
				if(usr.Total_Stats_Regen != 0)
					usr.Total_Stats_Regen -= 1
				if(Regeneration<=Minimum_Stats["Reg"])
					return
			if(type=="+")
				if(usr.Total_Stats_Regen == max)
					usr << "Unable to put more than [max] points into any mod."
					return
				else
					usr.Total_Stats_Regen += 1
			Raise_Regeneration(Increase)
			winset(usr,"[skill]","text=[Regeneration]")
		if("Recovery")
			if(type=="-")
				if(usr.Total_Stats_Recov != 0)
					usr.Total_Stats_Recov -= 1
				if(Recovery<=Minimum_Stats["Rec"])
					return
			if(type=="+")
				if(usr.Total_Stats_Recov == max)
					usr << "Unable to put more than [max] points into any mod."
					return
				else
					usr.Total_Stats_Recov += 1
			Raise_Recovery(Increase)
			if(usr) if(client)
				winset(usr,"[skill]","text=[Recovery]")
		else
			alert("You really ought to try not to abuse character generation!")
			return
	Points-=Increase
	if(usr) if(client)
		winset(usr,"Points Remaining","text=[Points]")
	return
mob/verb/Skill_Points_Done()
	set name=".Skill_Points_Done"
	set hidden=1
	if(Points) usr<<"You still have points!"
	else
		winshow(usr,"skills",0)

mob/proc/Stat_Point_Window_Refresh()
	if(src) if(client)
		winset(src,"Points Remaining","text=[Points]")
		winset(src,"Race BP","text=\"This race has [BPMod]x Battle Power Gain\"")
		winset(src,"Efficiency","text=[KiMod]")
		winset(src,"Strength","text=[StrMod]")
		winset(src,"Endurance","text=[EndMod]")
		winset(src,"Speed","text=[SpdMod]")
		winset(src,"Force","text=[PowMod]")
		winset(src,"Resistance","text=[ResMod]")
		winset(src,"Offense","text=[OffMod]")
		winset(src,"Defense","text=[DefMod]")
		winset(src,"Regeneration","text=[Regeneration]")
		winset(src,"Recovery","text=[Recovery]")
mob/proc/Raise_Energy(Amount=1)
	KiMod+=(Minimum_Stats["Eff"]*0.1)*Amount
mob/proc/Raise_Speed(Amount=1)
	SpdMod+=(Minimum_Stats["Spd"]*0.1)*Amount
mob/proc/Raise_Strength(Amount=1)
	StrMod+=(Minimum_Stats["Str"]*0.1)*Amount
mob/proc/Raise_Durability(Amount=1)
	EndMod+=(Minimum_Stats["End"]*0.1)*Amount
mob/proc/Raise_Force(Amount=1)
	PowMod+=(Minimum_Stats["Pow"]*0.1)*Amount
mob/proc/Raise_Resistance(Amount=1)
	ResMod+=(Minimum_Stats["Res"]*0.1)*Amount
mob/proc/Raise_Offense(Amount=1)
	OffMod+=(Minimum_Stats["Off"]*0.1)*Amount
mob/proc/Raise_Defense(Amount=1)
	DefMod+=(Minimum_Stats["Def"]*0.1)*Amount
mob/proc/Raise_Regeneration(Amount=1)
	Regeneration+=(Minimum_Stats["Reg"]*0.1)*Amount
mob/proc/Raise_Recovery(Amount=1)
	Recovery+=(Minimum_Stats["Rec"]*0.1)*Amount
mob/proc/Racial_Stats()
	if(Race == "Android")
		return
	else
		Points = 10
		Max_Points = 10
		if(Race == "Alien")
			Points+=45
			Max_Points += 45
		if(Race == "Half-Saiyan")
			Points+=25
			Max_Points += 25
		if(Race == "Quarter Saiyan")
			Points+=25
			Max_Points += 25
		if(Race == "1/16th Saiyan")
			Points+=25
			Max_Points += 25
		Set_Minimum_Stats()
		Stat_Point_Window_Refresh()
		if(src) if(client)
			winshow(src,"skills",1)
			while(src && client && (winget(src,"skills","is-visible")=="true"))
				sleep(1)
		src.Redoing_Stats = 1

obj/Redo_Stats
	var/Last_Redo=0
	verb/Redo_Stats()
		set category="Other"
		if(Last_Redo+5>Year)
			usr<<"You can not do this til year [Last_Redo+5]"
			return
		usr.Redoing_Stats=1
		Last_Redo=Year
		usr.Redo_Stats()
mob/proc/Redo_Stats()
	set category="Other"
	Redoing_Stats=1
	Expand_Revert()
	Cancel_Focus()
	Cancel_Expand()
	Cancel_LimitBreaker()
	KaiokenRevert()
	Majin_Revert()
	Mystic_Revert()
	Third_Eye_Revert()
	var/Reverts=5
	while(Reverts)
		Reverts-=1
		Cancel_Transformation()
	MaxKi/=KiMod
	Off/=OffMod
	Def/=DefMod
	KiMod=Minimum_Stats["Eff"]
	SpdMod=Minimum_Stats["Spd"]
	StrMod=Minimum_Stats["Str"]
	EndMod=Minimum_Stats["End"]
	PowMod=Minimum_Stats["Pow"]
	ResMod=Minimum_Stats["Res"]
	OffMod=Minimum_Stats["Off"]
	DefMod=Minimum_Stats["Def"]
	Regeneration=Minimum_Stats["Reg"]
	Recovery=Minimum_Stats["Rec"]
	Racial_Stats()
	MaxKi*=KiMod
	Off*=OffMod
	Def*=DefMod
	Redoing_Stats=0