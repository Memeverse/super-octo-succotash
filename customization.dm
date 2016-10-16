/*
Changeling forms customization procs
*/

mob/proc/Customize_Form_1() switch(input("Customize 1st form icon?") in list("No","Yes"))
	if("Yes") Form1Icon=input("Choose icon") as file

mob/proc/Customize_Form_2() switch(input("Customize 2nd form icon?") in list("No","Yes"))
	if("Yes") Form2Icon=input("Choose icon") as file

mob/proc/Customize_Form_3() switch(input("Customize 3rd form icon?") in list("No","Yes"))
	if("Yes") Form3Icon=input("Choose icon") as file

mob/proc/Customize_Form_4() switch(input("Customize 4th form icon?") in list("No","Yes"))
	if("Yes") Form4Icon=input("Choose icon") as file

mob/proc/Customize_Form_5() switch(input("Customize expand form icon?") in list("No","Yes"))
	if("Yes")
		Form5Icon=input("Choose icon") as file;Form6Icon=Form5Icon;Form7Icon=Form5Icon;Form8Icon=Form5Icon

/*
Customization verb for:
- Changeling forms
- Auras
- Blasts
- Charges
*/


mob/verb/Customize()
	set category="Other"
	if(Race=="Changeling")
		switch(input("Do you want to have custom icons for your changeling forms?") in list("No","Yes"))
			if("Yes")
				Customize_Form_1()
				Customize_Form_2()
				Customize_Form_3()
				Customize_Form_4()
				Customize_Form_5()
				return
	overlays.Remove(BlastCharge,Aura)
	underlays-=SSj4Aura
	/*switch(input("What do you want to customize?") in list("Charge Icon","Aura Icon","Blast Icons"))
		if("Aura Icon") for(var/A in typesof(/obj/Auras)) if(A!=/obj/Auras) usr.contents+=new A
		if("Charge Icon") for(var/A in typesof(/obj/Charges)) if(A!=/obj/Charges) usr.contents+=new A
		if("Blast Icons") contents+=new/obj/Blasts
	Tabs=10
	src<<"Go to an icon you wish to use in the tabs. You can colorize it any way you want by right \
	clicking it. You can also restore it to default color the same way, so you can then recolorize it. \
	When your done, you can apply it to your character by clicking it. The tab will then disappear."*/

	if(Tabs!=10)
		//client.show_verb_panel=0
		for(var/A in typesof(/obj/Auras)) if(A!=/obj/Auras) contents+=new A
		for(var/A in typesof(/obj/Charges)) if(A!=/obj/Charges) contents+=new A
		for(var/A in typesof(/obj/Blasts)) if(A!=/obj/Blasts) contents+=new A
		Tabs=10
		src<<"Tabs have opened to allow you to customize yourself. When finished hit the customize verb again."

	else
		//client.show_verb_panel=1
		for(var/obj/Auras/A in src) del(A)
		for(var/obj/Charges/A in src) del(A)
		for(var/obj/Blasts/A in src) del(A)
		Tabs=1

//var/list/Blasts=new
//proc/AddBlasts() for(var/A in typesof(/obj/Blasts)) if(A!=/obj/Blasts) Blasts+=new A

obj/Blasts
	icon_state="head"

	Click()
		var/list/C=new
		for(var/obj/Attacks/D in usr) if(D.type!=/obj/Attacks/Time_Freeze) C+=D
		//usr.Tabs=1
		var/obj/Attacks/A=input("Give this icon to which attack?") in C
		if(A) A.icon=image(icon=icon,icon_state=icon_state)
		usr<<"[src] Chosen"
		//for(var/obj/Blasts/B in usr) del(B)
		//for(var/obj/Blasts/B in Blasts) B.icon=initial(B.icon)

	verb/Adjust_Color()
		set src in world
		var/A=input("Choose a color") as color|null
		if(A) icon+=A

	verb/Default_Color()
		set src in world
		icon=initial(icon)
	Blast1 icon='1.dmi'
	Blast2 icon='2.dmi'
	Blast3 icon='3.dmi'
	Blast4 icon='4.dmi'
	Blast5 icon='5.dmi'
	Blast6 icon='6.dmi'
	Blast7 icon='7.dmi'
	Blast8 icon='8.dmi'
	Blast9 icon='9.dmi'
	Blast10 icon='10.dmi'
	Blast11 icon='11.dmi'
	Blast12 icon='12.dmi'
	Blast13 icon='13.dmi'
	Blast14 icon='14.dmi'
	Blast15 icon='15.dmi'
	Blast16 icon='16.dmi'
	Blast17 icon='17.dmi'
	Blast18 icon='18.dmi'
	Blast19 icon='19.dmi'
	Blast20 icon='20.dmi'
	Blast21 icon='21.dmi'
	Blast22 icon='22.dmi'
	Blast23 icon='23.dmi'
	Blast24 icon='24.dmi'
	Blast25 icon='25.dmi'
	Blast26 icon='26.dmi'
	Blast27 icon='27.dmi'
	Blast28 icon='28.dmi'
	Blast29 icon='29.dmi'
	Blast30 icon='30.dmi'
	Blast31 icon='31.dmi'
	Blast32 icon='32.dmi'
	Blast33 icon='33.dmi'
	Blast34 icon='34.dmi'
	Blast35 icon='35.dmi'
	Blast36 icon='36.dmi'
	Blast37 icon='37.dmi'
	Blast38 icon='Blast - Destructo Disk.dmi'
	Blast39 icon='Blast - Dual Fire Blast.dmi'
	Blast40 icon='Blast - Ki Shuriken.dmi'
	Blast41 icon='holybolt.dmi'
	Beam1 icon='Beam1.dmi'
	Beam2 icon='Beam2.dmi'
	Beam3 icon='Beam3.dmi'
	Beam4 icon='Beam4.dmi'
	Beam5 icon='Beam5.dmi'
	Beam6 icon='Beam6.dmi'
	Beam8 icon='Beam8.dmi'
	Beam9 icon='Beam9.dmi'
	Beam10 icon='Beam10.dmi'
	Beam11 icon='Beam11.dmi'
	Piercer icon='Makkankosappo.dmi'
	Beam12 icon='Beam12.dmi'
	Beam13 icon='Beam - Kamehameha.dmi'
	Beam14 icon='Beam - Static Beam.dmi'
	Beam15 icon='Beam - Multi-Beam.dmi'
obj/Auras_Special
	SSJ1
		icon = 'AurasBig.dmi'
		icon_state = "SSJ"
		pixel_x = -32
	LSSJ
		icon = 'AurasBig.dmi'
		icon_state = "LSSJ"
		pixel_x = -32
	Kaioken
		icon = 'AurasBig.dmi'
		icon_state = "Kaioken"
		pixel_x = -32
	SN
		icon = 'SNJ.dmi'
		pixel_x = -32
obj/Auras

	Click()
		usr.Aura=image(icon=icon,icon_state=icon_state)
		usr<<"[src] Chosen"
		//usr.Tabs=1
		//for(var/obj/Auras/A in usr) if(A!=src) del(A)
		//del(src)

	verb/Adjust_Color()
		var/A=input("Choose a color") as color|null
		if(A) icon+=A
		usr.SSj4Aura='Aura SSj4.dmi'
		if(A) usr.SSj4Aura+=A
		usr.FlightAura='Aura Fly.dmi'
		if(A) usr.FlightAura+=A

	verb/Default_Color() icon=initial(icon)

	None
	Sparks icon='AbsorbSparks.dmi'
	Electric icon='Aura, Bloo.dmi'
	Electric_2 icon='Aura Electric.dmi'
	Default icon='Aura.dmi'
	Flowing icon='Aura Normal.dmi'
	Demon_Flame icon='Black Demonflame.dmi'
	Vampire_Aura icon='Aura 2.dmi'
	Electric_3 icon='ElecAura3.dmi'
	Electric_4 icon='Elec Aura1.dmi'

obj/Charges
	icon='BlastCharges.dmi'

	Click()
		usr.BlastCharge=image(icon=icon,icon_state=icon_state)
		usr<<"[src] Chosen"
		//usr.Tabs=1
		//for(var/obj/Charges/A in usr) if(A!=src) del(A)
		//del(src)

	verb/Adjust_Color()
		var/A=input("Choose a color") as color|null
		if(A) icon+=A

	verb/Default_Color() icon=initial(icon)
	Charge1 icon_state="1"
	Charge2 icon_state="2"
	Charge3 icon_state="3"
	Charge4 icon_state="4"
	Charge5 icon_state="5"
	Charge6 icon_state="6"
	Charge7 icon_state="7"
	Charge8 icon_state="8"
	Charge9 icon_state="9"
