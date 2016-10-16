var/list/Reincarnations=new
var/Reincarnation_Status = "Off"
obj/Reincarnation
	var/Flight
	var/Zanzoken
	var/Kaioken
	var/Intelligence
	var/IntNext
	var/Power
	var/Energy
	var/Strength
	var/Endurance
	var/Force
	var/Resistance
	var/Speed
	var/Offense
	var/Defense
	var/Training_Experience
//	var/Intelligence_Experience

mob/proc/Reincarnation()
	var/obj/Reincarnation/A=new
	A.name=key
	A.Flight=FlySkill/FlyMod
	A.Zanzoken=Zanzoken/ZanzoMod
	if(Kaioken)
		A.Kaioken=Kaioken/KaiokenMod
	else
		A.Kaioken=1
	A.Intelligence=Int_Level/5
	A.IntNext= Int_Next/(Int_Level/5)
//	A.Intelligence_Experience=Int_Next/Add
	A.Power=Base/BPMod
	A.Energy=MaxKi/KiMod
	A.Strength=Str/StrMod
	A.Endurance=End/EndMod
	A.Force=Pow/PowMod
	A.Resistance=Res/ResMod
	A.Speed=Spd/SpdMod
	A.Offense=Off/OffMod
	A.Defense=Def/DefMod
	A.Training_Experience=Gain_Multiplier
	for(var/obj/Attacks/B in src)
		A.contents += B
	Reincarnations += A
	var/mob/player/B = new
	B.key=key

mob/proc/Check_Incarnates() for(var/obj/Reincarnation/A in Reincarnations) if(A.name==key)
	FlySkill = A.Flight*FlyMod
	Zanzoken = A.Zanzoken*ZanzoMod
	Kaioken = A.Kaioken*KaiokenMod
	Int_Level = A.Intelligence*Add
	Int_Next = Int_Level*(A.IntNext/Add)
	Base = A.Power*BPMod/1.5
	MaxKi = A.Energy*KiMod/1.5
	Str = A.Strength*StrMod/1.5
	End = A.Endurance*EndMod/1.5
	Pow = A.Force*PowMod/1.5
	Res = A.Resistance*ResMod/1.5
	Spd = A.Speed*SpdMod/1.5
	Off = A.Offense*OffMod/1.5
	Def = A.Defense*DefMod/1.5
	Gain_Multiplier = A.Training_Experience/1.5
	contents += A.contents
	Body()
	del(A)

obj/Reincarnate
	desc="This can be used to reincarnate someone into an entirely different race, but they keep their \
	stats, but they are reproportioned to match the new mods of that race."
	verb/Reincarnate(mob/M in oview(1,usr))
		set src=usr.contents
		set category="Other"
		if(!M.Dead||M.icon_state=="KO")
			usr<<"They must be dead and not unconscious"
			return
		switch(input(M,"[usr] has offered to help reincarnate you into another body and mind, this \
		will purify your spirit and erase your memories, starting your life in the living world all \
		over again. You will keep your power and some of your skills, but re-proportioned for the new \
		race you choose. If you hit yes it will be too late to turn back. Do you want to do this?") \
		in list("Yes","No"))
			if("Yes")
				log_ability("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has reincarnated [key_name(M)]")
				alertAdmins("[key_name(usr)] has reincarnated [key_name(M)]")
				usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has reincarnated [key_name(M)]\n")
				M.saveToLog("| [M.client.address ? (M.client.address) : "IP not found"] | ([M.x], [M.y], [M.z]) | [key_name(M)] has been reincarnated by [key_name(usr)]\n")
				view(usr) << "[usr] has reincarnated [M]"
				M.Reincarnation()
			if("No")
				view(M) << "[M] declined reincarnation from [usr]"
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(A,15000)

mob/proc/NewGameReincarnation()
	switch (input(src,"Would you like to continue on to the afterlife, or reincarnate to a new character?") in list("Continue to the Afterlife","Reincarnate to a New Character"))
		if("Reincarnate to a New Character")
			Reincarnation()
		if("Continue to the Afterlife")
			ReincCall=0
			  //Previously return
			  //src.ReincCall  Possible trigger for Byond-side null.var errors.