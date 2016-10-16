
/*
mob/Dummy
	name="Log"
	icon='Dummy.dmi'
	icon_state="Off"
	BP=100
	Health=100
	End=250000
	Res=250000
	Def=0.01
	New()
		Health=100
		icon_state="Off"
		//..()
	verb/Upgrade()
		set src in oview(1)
		for(var/obj/Resources/A in usr)
			var/Amount=input("How much endurance do you want to add? (Up to [Commas(A.Value)])") as num
			if(Amount>round(A.Value)) Amount=round(A.Value)
			if(Amount<0) Amount=0
			A.Value-=Amount
			Amount*=usr.Add
			Un_KO()
			Health+=Amount
			view(usr)<<"[usr] added [Commas(Amount)] to the [src]'s armor"
		desc="Health: [Health*10]"
		icon_state="Off"
*/

mob/proc/Heal_Zenkai()// if(Zenkai_Power<Base*0.5)
	var/Amount=1
	if(Zenkai_Power) Amount=(Base/(Zenkai_Power*5))**3
	if(Amount>10) Amount=10
	Base+=Amount*500*BPMod*Zenkai*Regeneration*(1+Senzu)*GG*Gain_Multiplier
	Zenkai_Power+=Amount*5000*BPMod*Zenkai*Regeneration*(1+Senzu)*GG*Gain_Multiplier

mob/proc/Zenkai() if(Zenkai_Power<Base*0.5)
	var/Amount=1
	if(Zenkai_Power) Amount=(Base/(Zenkai_Power*5))**3
	if(Amount>10) Amount=10
	var/Multiplier=1
	if(icon_state=="KO") Multiplier=10
	Base+=Amount*10*Multiplier*BPMod*Zenkai*Regeneration*(1+Senzu)*GG*Gain_Multiplier
	Zenkai_Power+=Amount*10*Multiplier*BPMod*Zenkai*Regeneration*(1+Senzu)*GG*Gain_Multiplier
	if(z==10)
		Base+=Amount*90*Multiplier*BPMod*Zenkai*Regeneration*(1+Senzu)*GG*Gain_Multiplier
		Zenkai_Power+=Amount*90*Multiplier*BPMod*Zenkai*Regeneration*(1+Senzu)*GG*Gain_Multiplier

mob/proc/Death_Zenkai() if(!Dead&&Zenkai_Power<Base*0.5)
	Base+= 10000*BPMod*Zenkai*Regeneration*(1+Senzu)*GG*Gain_Multiplier
	Zenkai_Power+= 10000*BPMod*Zenkai*Regeneration*(1+Senzu)*GG*Gain_Multiplier

mob/proc/Increase_Gain_Multiplier(Amount=1) Gain_Multiplier+=0.01*Amount
mob/proc/XP_Gained(Amount=1) XPGained+=.01*Amount

mob/proc/Attack_Gain()
	ASSERT(src)
//	ASSERT(src.P_BagG)  Removed for testing.
	if(!src)
		world<<"Error!"
		return
	if(src.Opp)if(ismob(src.Opp))
		var/mob/M = src.Opp
		if(M.Opp)if(M.Opp != src)
			return // (This fix was broken, so I re-fixed the fix. - WtfDontBanMe)If their Opponent is a player, but that player's opponent isn't them (i.e. reverse sparring) then they don't gain shit.
	var/BP_Gain=2
	if(istype(Opp,/mob/player)) if(prob(50)) if(Opp.client)
	//	if(Opp.Race==Race) if(Opp.BPMod>BPMod)
	//		BPMod+=Opp.BPMod*0.01
	//		if(BPMod>Opp.BPMod) BPMod=Opp.BPMod
		if(Opp.Gain_Multiplier>Gain_Multiplier) Gain_Multiplier=Opp.Gain_Multiplier
		if(Opp.Base>Base&&prob(10))
			BP_Gain*=20
			if((Base/BPMod)<0.2*(Opp.Base/Opp.BPMod))
				Base+=(Opp.Base/Opp.BPMod)*BPMod*0.001
//				if((Base/BPMod)>(Opp.Base/Opp.BPMod)) Base+=(Opp.Base/Opp.BPMod)*BPMod
		//if((MaxKi/KiMod)<(Opp.MaxKi/Opp.KiMod))
			//if(prob(10)) MaxKi+=Opp.MaxKi*0.005  //001 Statrev notifier  2013 -  Was .002  Now is .005
//			if((MaxKi/KiMod)>(Opp.MaxKi/Opp.KiMod)) MaxKi+=(Opp.MaxKi/Opp.KiMod)*KiMod
// The two lines that were commented out were done so because of balance issues.
// If the opponent happens to have MORE energy but a HIGHER energy MOD (say 5) then they'll
// gain their opponents max energy, same with base.
//2866 vs 1239 -
/* Example:
Player A has 22k MaxKi kiMod of 5
Player B has 6k MaxKi KiMod of 1.5
The if statement becomes true then so does the second one (it checks if they have HIGHER energy then their opponent)
As such, the energy Player A will gain is:
 6000/1.5 = 4000
 4000 * 5 = 20 000

I dont think that's what we want.
*/

/*	if(pfocus=="Balanced")
		if(prob(10)) Str+=0.048*StrMod*Stat_Gain
		if(prob(10)) End+=0.048*EndMod*Stat_Gain
	else if(pfocus=="Strength") if(prob(10)) Str+=0.096*StrMod*Stat_Gain
	else if(pfocus=="Endurance") if(prob(10)) End+=0.096*EndMod*Stat_Gain
	if(sfocus=="Balanced")
		if(prob(10)) Pow+=0.04*PowMod*Stat_Gain
		if(prob(10)) Res+=0.04*ResMod*Stat_Gain
	else if(sfocus=="Force") if(prob(10)) Pow+=0.08*PowMod*Stat_Gain
	else if(sfocus=="Resistance") Res+=0.08*ResMod*Stat_Gain
	if(prob(10)) Spd+=0.052*SpdMod*Stat_Gain
	if(mfocus=="Balanced")
		if(prob(10)) Off=0.04*OffMod*Stat_Gain
		if(prob(10)) Def+=0.05*DefMod*Stat_Gain
	else if(mfocus=="Offense") if(prob(10)) Off+=0.09*OffMod*Stat_Gain
	else if(mfocus=="Defense") if(prob(10)) Def+=0.09*DefMod*Stat_Gain*/
	/*	if(RP_Power<Opp.RP_Power)
			RP_Power+=Opp.RP_Power*0.001
			if(RP_Power>Opp.RP_Power) RP_Power=Opp.RP_Power
		if(GravMastered<Opp.GravMastered)
			GravMastered+=Opp.GravMastered*0.005
			if(GravMastered>Opp.GravMastered) GravMastered=Opp.GravMastered*/

	//var/Stat_Gain=1
	//if(Opp.client) if(Opp.StatRank<StatRank) Stat_Gain*=20

	if( shadspar && istype(Opp, /mob/sparpartner) )
		BP_Gain*=15

	Increase_Gain_Multiplier(3)
	if(Gravity>=GravMastered)
		if(GravMastered<=300)
			if (prob(20))
				GravMastered+=0.05*GravMod //Was .009.  Turned it up at Kirby's request on 10/22 - Arch
	StatRank()
	XPRank()
	var/HBTC=1
	if(z==10) HBTC=10
	//Base+=50*GG*BPMod*Weight*HBTC*BP_Gain*(BPRank/2)*Gain_Multiplier*(Gravity/25) Re-added the gravity portion on 10/22 - Arch
	var/N = 15 + GravMulti
	Base+= N*GG*BPMod*HBTC*Weight*BP_Gain*(BPRank/2)*Gain_Multiplier*Boost
	MaxKi+=0.05*KiMod*Boost
	Zanzoken+=0.1*ZanzoMod/SpdMod
	if(prob(0.04*(KiMod+Recovery))) Decline+=0.1*Year_Speed
	if(prob(10)) Spd+=0.034*SpdMod

	//Physical
	if(!src.P_BagG)
		world<<"Null.Var P_BagG error detected!  Check defensive programming!"
		return
/*	if(!Opp.P_BagG)
		world<<"Null.Var P_Bag Opp based error detected!"*/
	if(pfocus=="Balanced")
		if(prob(10))
		//	ASSERT(Opp)
			Str+=0.01*StrMod*(StatRank/2)*Opp.P_BagG*Boost
			//Str+=0.002*StrMod*(StatRank/2)*Opp.P_BagG*(Gravity/50)
		if(prob(10))
			End+=0.01*EndMod*(StatRank/2)*Opp.P_BagG*Boost
			//End+=0.002*EndMod*(StatRank/2)*Opp.P_BagG*(Gravity/50)
	else if(pfocus=="Strength")
		if(prob(10))
		//	ASSERT(Opp)
			Str+=0.02*StrMod*(StatRank/2)*Opp.P_BagG*Boost
			//Str+=0.004*StrMod*(StatRank/2)*Opp.P_BagG*(Gravity/50)
	else if(pfocus=="Endurance")
		if(prob(10))
		//	ASSERT(Opp)
			End+=0.02*EndMod*(StatRank/2)*Opp.P_BagG*Boost
			//End+=0.004*EndMod*(StatRank/2)*Opp.P_BagG*(Gravity/50)

//	Spiritual
	if(sfocus in list("Balanced","Intelligence"))
		if(prob(10))
		//	ASSERT(Opp)
			Pow+=0.01*PowMod*(StatRank/2)*Opp.P_BagG*Boost
			//Pow+=0.002*PowMod*(StatRank/2)*Opp.P_BagG*(Gravity/50)
		if(prob(10))
		//	ASSERT(Opp)
			Res+=0.01*ResMod*(StatRank/2)*Opp.P_BagG*Boost
			//Res+=0.002*ResMod*(StatRank/2)*Opp.P_BagG*(Gravity/50)
	else if(sfocus=="Force")
		if(prob(10))
		//	ASSERT(Opp)
			Pow+=0.02*PowMod*(StatRank/2)*Opp.P_BagG*Boost
			//Pow+=0.004*PowMod*(StatRank/2)*Opp.P_BagG*(Gravity/50)
	else if(sfocus=="Resistance")
		if(prob(10))
		//	ASSERT(Opp)
			Res+=0.02*ResMod*(StatRank/2)*Opp.P_BagG*Boost
			//Res+=0.004*ResMod*(StatRank/2)*Opp.P_BagG*(Gravity/40)
//	Ability
	if(mfocus=="Balanced")
		if(prob(10))
		//	ASSERT(Opp)
			Off+=0.1*OffMod*(StatRank/2)*Opp.P_BagG*Boost
			//Off+=0.01*OffMod*(StatRank/2)*Opp.P_BagG*(Gravity/40)
		if(prob(5))
		//	ASSERT(Opp)
			Def+=0.2*DefMod*(StatRank/2)*Opp.P_BagG*Boost
			//Def+=0.02*DefMod*(StatRank/2)*Opp.P_BagG*(Gravity/40)
	else if(mfocus=="Offense")
		if(prob(10))
		//	ASSERT(Opp)
			Off+=0.2*OffMod*(StatRank/2)*Opp.P_BagG*Boost
			//Off+=0.02*OffMod*(StatRank/2)*Opp.P_BagG*(Gravity/40)
	else if(mfocus=="Defense")
		if(prob(10))
		//	ASSERT(Opp)
			Def+=0.2*DefMod*(StatRank/2)*Opp.P_BagG*Boost
			//Def+=0.02*DefMod*(StatRank/2)*Opp.P_BagG*(Gravity/40)

mob/proc/Flying_Gain()
	var/HBTC=1
	if(z==10) HBTC=10
	Base+= 2*GG*BPMod*Weight*HBTC*(BPRank/2)*Gain_Multiplier
	MaxKi+=0.009*KiMod  //Was .004 as of 2013
	if(prob(0.01*(KiMod+Recovery))) Decline+=0.2*Year_Speed

	Increase_Gain_Multiplier(1)


mob/proc/Blast_Gain()
	var/HBTC=1
	if(z==10) HBTC=10
	Base+=2*GG*BPMod*Weight*HBTC*Gain_Multiplier
	MaxKi+=0.004*KiMod  //Was .001 as of 2013
	if(prob(10)) Pow+=0.05*PowMod
	if(prob(10)) Off+=0.05*OffMod

	Increase_Gain_Multiplier(1)



proc/Save_Int()
	var/savefile/S=new("Data/IntGain.bdb")
	S["intgain"]<<Admin_Int_Setting
	if(global.startRuin) S["success"] << global.startRuin
proc/Load_Int() if(fexists("Data/IntGain.bdb"))
	var/savefile/S=new("Data/IntGain.bdb")
	if(length(S["success"])) global.startRuin = 1
	S["intgain"]>>Admin_Int_Setting



mob/verb
	StatFocus()
		set category="Other"
		ASSERT(src)
		var/Choice=alert(src,"Physical Focus (Training)","","Balanced","Strength","Endurance")
		switch(Choice)
			if("Strength") pfocus="Strength"
			if("Endurance") pfocus="Endurance"
			if("Balanced") pfocus="Balanced"
		Choice=alert(src,"Spiritual Focus (Meditation)","","Balanced","Force","Resistance")
		switch(Choice)
			if("Force") sfocus="Force"
			if("Resistance") sfocus="Resistance"
			if("Balanced") sfocus="Balanced"
		Choice=alert(src,"Style Focus (Sparring)","","Balanced","Offense","Defense")
		switch(Choice)
			if("Offense") mfocus="Offense"
			if("Defense") mfocus="Defense"
			if("Balanced") mfocus="Balanced"
		Choice=alert(src,"Do you want to focus on Intelligence gains, Magical Skill or nothing at all?","","Intelligence","Magical Skill","Nothing")
		switch(Choice)
			if("Intelligence")
				ifocus="Intelligence"
				magicfocus = 0
			if("Magical Skill")
				magicfocus="Magical Skill"
				ifocus = 0
			if("Nothing")
				ifocus=0
				magicfocus=0