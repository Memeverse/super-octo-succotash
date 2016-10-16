obj/Assess/verb/Assess(mob/M in world)
	set src=usr.contents
	set category="Other"
	usr.Get_Assess(M)

mob/proc/Get_Assess(mob/M)
	var/BPMod = 0
	var/KiMod = 0
	var/StrMod = 0
	var/EndMod = 0
	var/SpdMod = 0
	var/PowMod = 0
	var/ResMod = 0
	var/OffMod = 0
	var/DefMod = 0
	var/Regen = 0
	var/Recov = 0
	var/MagicMod = 0
	var/AddMod = 0
	var/MaxAnger = 0
	var/Zenkai = 0
	var/Decline = 0
	var/GravMastered = 0
	var/GravMod = 0
	var/MaxKi = 0
	var/ZanzoMod = 0
	var/MedMod = 0
	var/FlyMod = 0
	var/Base = 0

	var/BP = 0
	var/Str = 0
	var/End = 0
	var/Spd = 0
	var/Pow = 0
	var/Res = 0
	var/Off = 0
	var/Def = 0
	var/Zanzo = 0
	var/Fly = 0
	if(src.client.holder.level >= 4)
		BPMod = M.BPMod
		KiMod = M.KiMod
		StrMod = M.StrMod
		EndMod = M.EndMod
		SpdMod = M.SpdMod
		PowMod = M.PowMod
		ResMod = M.ResMod
		OffMod = M.OffMod
		DefMod = M.DefMod
		Regen = M.Regeneration
		Recov = M.Recovery
		MagicMod = M.Magic_Potential
		AddMod = M.Add
		MaxAnger = M.MaxAnger
		Zenkai = M.Zenkai
		Decline = M.Decline
		GravMastered = M.GravMastered
		GravMod = M.GravMod
		MaxKi = M.MaxKi
		Zanzo = M.Zanzoken
		MedMod = M.MedMod
		Fly = M.FlySkill
		FlyMod = M.FlyMod
		Base = M.Base

		BP = M.BP
		Str = M.Str
		End = M.End
		Spd = M.Spd
		Pow = M.Pow
		Res = M.Res
		Off = M.Off
		Def = M.Def
	var/S = M.Size
	if(S == 1)
		S = "Small"
	if(S == 2)
		S = "Medium"
	if(S == 3)
		S = "Large"
	var/A={"
	<html>
	<style type="text/css">
	<!--
	body {
	     color:#449999;
	     background-color:black;
	     font-size:12;
	 }
	table {
	     font-size:12;
	 }
	//-->
	</style>
	<body>
	[M]<br>
	Current Anger: [M.Anger]%<br>
	<table cellspacing="6%" cellpadding="1%">
	<tr><td>Race:</td><td>[M.Race]</td></tr>
	<tr><td>Race Class:</td><td>[M.Class]</td></tr>
	<tr><td>Key:</td><td>[M.key]</td></tr>
	<tr><td>Body Size:</td><td>[S]</td></tr>
	<tr><td>Age:</td><td>[M.Age] ([M.Real_Age] True Age)</td></tr>
	<tr><td>Body:</td><td>[M.Body*100]% ([Decline] Decline)</td></tr>
	<tr><td>Base:</td><td>[Commas(Base)] ([BPMod])</td></tr>
	<tr><td>Current BP:</td><td>[Commas(BP)]</td></tr>
	<tr><td>Energy:</td><td>[round(MaxKi)] ([KiMod])</td></tr>
	<tr><td>Strength:</td><td>[round(Str)] ([StrMod])</td></tr>
	<tr><td>Endurance:</td><td>[round(End)] ([EndMod])</td></tr>
	<tr><td>Speed:</td><td>[round(Spd)] ([SpdMod])</td></tr>
	<tr><td>Force:</td><td>[round(Pow)] ([PowMod])</td></tr>
	<tr><td>Resistance:</td><td>[round(Res)] ([ResMod])</td></tr>
	<tr><td>Offense:</td><td>[round(Off)] ([OffMod])</td></tr>
	<tr><td>Defense:</td><td>[round(Def)] ([DefMod])</td></tr>
	<tr><td>Regeneration:</td><td>[Regen]</td></tr>
	<tr><td>Recovery:</td><td>[Recov]</td></tr>
	<tr><td>Zenkai:</td><td>[Zenkai]</td></tr>
	<tr><td>Gravity:</td><td>[round(GravMastered)] ([GravMod])</td></tr>
	<tr><td>Anger:</td><td>[MaxAnger]%</td></tr>
	<tr><td>Meditation:</td><td>[MedMod]</td></tr>
	<tr><td>Flying:</td><td>[round(Fly)] ([FlyMod])</td></tr>
	<tr><td>Zanzoken:</td><td>[round(Zanzo)] ([ZanzoMod])</td></tr>
	<tr><td>Intelligence:</td><td>([AddMod])</td></tr>
	<tr><td>Magic:</td><td>([MagicMod])</td></tr>
	<tr><td>Potential:</td><td>[M.Potential]</td></tr>
	<tr><td>Energy Signature:</td><td>[M.Signature]</td></tr>
	<tr><td>Gain Multiplier: [round(M.Gain_Multiplier)]</td></tr>
	</table>"}



	if(M.Race in list("Saiyan","Half-Saiyan"))
		A+="<font color=#FFFF00>Has Super Saiyan: [M.Hasssj]<br>"
	if(M.Race=="Human")
		A+="<font color=#FFFF99>Third Eye at: [Commas(M.geteye)]"
	A+="<br><font color=red>.:Mutations:.<br>"
	/*GENETICS
	for(var/obj/Mutations/X in M)
		A+="<font color=red>[X]<br>"
	A+="<br><font color=green>.:Traits:.<br>"
	for(var/obj/Traits/X in M)
		A+="<font color=green>[X]<br>"
		*/
	usr<<browse(A,"window=[M.name];size=350x700")