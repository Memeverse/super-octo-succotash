/client/proc/zCharacter(var/mob/player/A in Players)
	set name = "Z-Character-ize"
	set category = "Admin"
	set popup_menu = 0

	if(!src.holder)
		src << "Only administrators may use this command."
		return

	if(!A)
		A = input("Select a player to turn into a Z-Character") in Players
	if(!A)
		alert("Aborted Z-Character-ization!")
		return
	if(!A.contents)
		alert("Something is wrong with [key_name(A)]'s contents! Tell a coder!")
		return
	A.Tail=0
	A.overlays=null
	var/Red=100
	var/Green=200
	var/Blue=250
	switch(input("Choose skillset") in list("Generic","Goku","Vegeta","Gohan","Piccolo","Trunks","Tien","Yamcha",\
	"Krillan","Choutzu","Frieza","Cell","Majin Buu", "Cancel"))
		if("Cancel")
			alert("Aborted Z-Character-ization!")
			return
		if("Generic")
			Red=200;Green=50;Blue=200;A.MaxKi=2000*A.KiMod
		if("Goku")
			A.contents.Add(new/obj/Attacks/Genki_Dama,new/obj/Attacks/Kamehameha,new/obj/Taiyoken,\
			new/obj/Focus,new/obj/Expand,new/obj/Heal,new/obj/Kaioken,new/obj/Bind,new/obj/Keep_Body,\
			new/obj/Materialization,new/obj/Shield,new/obj/Shunkan_Ido,new/obj/SplitForm,,new/obj/Attacks/Kienzan,\
			new/obj/Unlock_Potential,new/obj/items/Senzu,new/obj/items/Senzu,new/obj/items/Senzu)
			A.ssj3drain=300;A.Age=27;A.Real_Age=135+Year;A.BirthYear=-135;A.Decline+= 15
			A.MaxKi=10000*A.KiMod;A.Kaioken=20
			for(var/obj/Shunkan_Ido/I in A) I.Level=100
		if("Vegeta")
			A.contents.Add(new/obj/Attacks/Explosion,new/obj/Attacks/Final_Flash,new/obj/Attacks/Galic_Gun,\
			new/obj/Attacks/Ray,new/obj/Self_Destruct,new/obj/Shield,new/obj/Attacks/Spin_Blast,\
			new/obj/Focus,new/obj/Expand,new/obj/Attacks/Kienzan)
			A.Age=40;A.Real_Age=140+Year;A.BirthYear=-140;A.Decline+= 13
			A.MaxKi=10000*A.KiMod
		if("Gohan")
			A.contents.Add(new/obj/Attacks/Kamehameha,new/obj/Attacks/Masenko,new/obj/Attacks/Piercer,\
			new/obj/Focus,new/obj/Heal,new/obj/Mystic,new/obj/Shield,new/obj/Taiyoken,new/obj/items/Senzu)
			A.Age=18;A.Real_Age=118+Year;A.BirthYear=-118;A.Decline+=5
			A.MaxKi=10000*A.KiMod
		if("Piccolo")
			A.contents.Add(new/obj/Attacks/Homing_Finisher,new/obj/Attacks/Makosen,new/obj/Attacks/Masenko,\
			new/obj/Attacks/Piercer,new/obj/Attacks/Ray,new/obj/Focus,new/obj/Expand,new/obj/Heal,\
			new/obj/Keep_Body,new/obj/Materialization,new/obj/Fusion,new/obj/Unlock_Potential)
			A.Age=23;A.Real_Age=123+Year;A.BirthYear=-121;A.Decline+= 10
			Red=250;Green=125;Blue=0
			A.MaxKi=10000*A.KiMod
		if("Trunks")
			A.contents.Add(new/obj/Expand,new/obj/Focus,new/obj/Shield)
			var/obj/items/Sword/Rebellion/R=new(A.contents);R.Health+= 10000000000
			A.Age=18;A.Real_Age=108+Year;A.BirthYear=-108;A.Decline+=5
			Red=100;Green=0;Blue=250
			A.MaxKi=10000*A.KiMod
		if("Tien")
			A.contents.Add(new/obj/Attacks/Dodompa,new/obj/Attacks/Kikoho,new/obj/Taiyoken,\
			new/obj/Attacks/Explosion,new/obj/Bind,new/obj/Expand,new/obj/Focus,new/obj/Heal,\
			new/obj/Materialization,new/obj/Shield,new/obj/SplitForm,new/obj/Third_Eye,new/obj/Unlock_Potential,\
			new/obj/Attacks/Kamehameha)
			A.Age=38;A.Real_Age=139+Year;A.BirthYear=-139;A.Decline+=20
			A.MaxKi=10000*A.KiMod
		if("Yamcha")
			A.contents.Add(new/obj/Attacks/Kamehameha,new/obj/Attacks/Dodompa,new/obj/Focus,\
			new/obj/Heal,new/obj/Materialization,new/obj/Shield,new/obj/SplitForm,new/obj/Taiyoken,\
			new/obj/Unlock_Potential)
			A.Age=38;A.Real_Age=139+Year;A.BirthYear=-139;A.Decline+=20
			A.MaxKi=10000*A.KiMod
		if("Krillan")
			A.contents.Add(new/obj/Attacks/Kamehameha,new/obj/Attacks/Masenko,new/obj/Focus,new/obj/Heal,\
			new/obj/Materialization,new/obj/Shield,new/obj/SplitForm,new/obj/Taiyoken,new/obj/Unlock_Potential,\
			new/obj/items/Senzu,new/obj/items/Senzu,new/obj/items/Senzu,new/obj/Attacks/Kienzan)
			A.Age=35;A.Real_Age=136+Year;A.BirthYear=-136;A.Decline+=20
			A.MaxKi=10000*A.KiMod
		if("Choutzu")
			A.contents.Add(new/obj/Attacks/Dodompa,new/obj/Attacks/Explosion,new/obj/Focus,new/obj/Heal,\
			new/obj/Materialization,new/obj/Shield)
			A.Age=38;A.Real_Age=139+Year;A.BirthYear=-139;A.Decline+=25
			Red=200;Green=0;Blue=0
			A.MaxKi=10000*A.KiMod
		if("Frieza")
			A.contents.Add(new/obj/Attacks/Death_Ball,new/obj/Attacks/Explosion,new/obj/Attacks/Ray,\
			new/obj/Attacks/Spin_Blast,new/obj/Expand,new/obj/Planet_Destroy,new/obj/Shield,new/obj/Attacks/Kienzan)
			A.Age=100;A.Real_Age=200+Year;A.BirthYear=-200;A.Decline=110
			A.MaxKi=5000*A.KiMod
		if("Cell")
			A.Age=10;A.Real_Age=110+Year;A.BirthYear=-110;A.Decline+=5;A.MaxKi=8000*A.KiMod
			A.contents.Add(new/obj/Attacks/Kamehameha,new/obj/Attacks/Piercer,new/obj/Attacks/Death_Ball,\
			new/obj/Attacks/Explosion,new/obj/Attacks/Galic_Gun,new/obj/Attacks/Homing_Finisher,\
			new/obj/Attacks/Spin_Blast,new/obj/Focus,new/obj/Expand,new/obj/Planet_Destroy,new/obj/Self_Destruct,\
			new/obj/Shunkan_Ido,new/obj/SplitForm,new/obj/Taiyoken,new/obj/Attacks/Kienzan)
		if("Majin Buu")
			A.Age=5000;A.Real_Age=5000+Year;A.BirthYear=-5000;A.Decline=5025;A.MaxKi=10000*A.KiMod
			A.contents.Add(new/obj/Attacks/Kamehameha,new/obj/Attacks/Explosion,new/obj/Attacks/Homing_Finisher,\
			new/obj/Attacks/Ray,new/obj/Attacks/Spin_Blast,new/obj/Heal,new/obj/Materialization,\
			new/obj/Planet_Destroy,new/obj/Self_Destruct,new/obj/Shield,new/obj/SplitForm,new/obj/Taiyoken,\
			new/obj/Unlock_Potential)
	A.Ki=A.MaxKi;A.Str=500*A.StrMod;A.End=500*A.EndMod;A.Pow=500*A.PowMod
	A.Res=500*A.ResMod;A.Spd=500*A.SpdMod;A.Off=1000*A.OffMod;A.Def=1000*A.DefMod
	A.GravMastered=500;A.Zanzoken=1000;A.FlySkill=1000
	if(!(locate(/obj/Power_Control) in A)) A.contents+=new/obj/Power_Control
	if(!(locate(/obj/Zanzoken) in A)) A.contents+=new/obj/Zanzoken
	if(!(locate(/obj/Give_Power) in A)) A.contents+=new/obj/Give_Power
	if(!(locate(/obj/Attacks/Blast) in A)) A.contents+=new/obj/Attacks/Blast
	if(!(locate(/obj/Attacks/Charge) in A)) A.contents+=new/obj/Attacks/Charge
	if(!(locate(/obj/Attacks/Beam) in A)) A.contents+=new/obj/Attacks/Beam
	if(!(locate(/obj/Telepathy) in A)) A.contents+=new/obj/Telepathy
	if(!(locate(/obj/Attacks/Sokidan) in A)) A.contents+=new/obj/Attacks/Sokidan
	for(var/obj/Attacks/O in A)
		if(O.Experience<1) O.Experience=1
		else if(O.Experience==1) O.Experience=1000
		if(O.icon==initial(O.icon)) O.icon+=rgb(Red,Green,Blue)
		if(O.type==/obj/Attacks/Sokidan) O:Sokidan_Delay=2
		if(O.type==/obj/Attacks/Explosion)
			O.Level=5;O.Experience=5
	if(A.Aura==initial(A.Aura)) A.Aura+=rgb(Red,Green,Blue)
	if(A.FlightAura==initial(A.FlightAura)) A.FlightAura+=rgb(Red,Green,Blue)
	if(A.BlastCharge==initial(A.BlastCharge)) A.BlastCharge+=rgb(Red,Green,Blue)
	if(A.Burst==initial(A.Burst)) A.Burst+=rgb(Red,Green,Blue)
	if(A.SSj4Aura==initial(A.SSj4Aura)) A.SSj4Aura+=rgb(Red,Green,Blue)
	A.Base=(input("What Battle Power do they have?") as num)/20
	alertAdmins("[key_name(src)] used Z Character on [key_name(A)], their base is now at [A.Base].")
	log_admin("[key_name(src)] used Z Character on [key_name(A)], their base is now at [A.Base].")