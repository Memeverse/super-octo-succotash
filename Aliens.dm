//var/list/Alien_Icons=new
obj/Alien_Icons
	Click()
		usr.icon=icon
//		if(istype(src,/obj/Alien_Icons/Human)) usr.Human_Skins()
		usr.Tabs=2
		for(var/obj/Alien_Icons/A in usr) if(A!=src) del(A)
		del(src)
	Alien1 icon='Alien, Beetle.dmi'
	Alien2 icon='Alien, Pikkon.dmi'
	Alien3 icon='Alien, Kanassa.dmi'
	Alien4 icon='Alien, Guldo.dmi'
	Alien5 icon='Alien, Bass.dmi'
	Alien6 icon='Alien, Burter.dmi'
	Alien7 icon='Race Ginyu.dmi'
	Alien8 icon='Race Kui.dmi'
	Alien9 icon='Alien 1.dmi'
	Alien10 icon='Alien 2.dmi'
	Alien11 icon='Alien 3.dmi'
	Alien12 icon='Immecka.dmi'
	Alien13 icon='Yukenojin.dmi'
	Alien14 icon='Baseniojin.dmi'
	Alien15 icon='Konatsu.dmi'
	Alien16 icon='Kanassan.dmi'
	Alien17 icon='Yardrat.dmi'
	Alien18 icon='Makyojin 2.dmi'
	Alien19 icon='Alien 5.dmi'
	Alien20 icon='Alien 4.dmi'
	Alien21 icon='Alien 6.dmi'
	Alien22 icon='Alien7.dmi'
	Alien23 icon='Alien 8.dmi'
	Alien24 icon='Alien 9.dmi'
	Alien25 icon='Alien 10.dmi'
	Alien26 icon='Alien, Frog.dmi'
	Alien27 icon='Hive Soldier.dmi'
//	Human suffix="Look like a Human"

//var/list/Demon_Icons=new
obj/Demon_Icons
	Click()
		usr.icon=icon
		if(istype(src,/obj/Demon_Icons/Human)) usr.Human_Skins()
		usr.Tabs=2
		for(var/obj/Demon_Icons/A in usr) if(A!=src) del(A)
		del(src)
	Demon1 icon='Demon1.dmi'
	Demon2 icon='Demon2.dmi'
	Demon3 icon='Hades.dmi'
	Demon4 icon='Alien 2.dmi'
	Demon5 icon='Alien 3.dmi'
	Demon6 icon='Demon4.dmi'
	Demon7 icon='Demon5.dmi'
	Demon8 icon='Demon6.dmi'
	Demon9 icon='Demon6, Female.dmi'
	Demon10 icon='Demon7.dmi'
	Demon11 icon='Darkrai2.dmi'
	Demon12 icon='Demon, Janemba.dmi'
	Demon13 icon='Demon, Uber Vampire.dmi'
	Demon14 icon='Demon, Wolf.dmi'
	Demon15 icon='DBFANdeathmask.dmi'
	Human suffix="Look like a Human"

//var/list/Android_Icons=new

obj/Android_Icons
	Click()
		usr.icon=icon
		usr.Tabs=2
		for(var/obj/Android_Icons/A in usr) if(A!=src) del(A)
		del(src)
	Android1 icon='White Male Muscular 2.dmi'
	Android2 icon='White Male.dmi'
	Android3 icon='Synthetic Human.dmi'
	Android4 icon='BaseAndroid1.dmi'
	Android5 icon='BaseAndroid2.dmi'
	Android6 icon='Android.dmi'
	Android7 icon='White female.dmi'
	Android8 icon='White Female 2.dmi'
	Android9 icon='Android Spider.dmi'
	Android10 icon='Android Probe.dmi'
	Android11 icon='Android Blackout.dmi'
	Android12 icon='Android Skeletor.dmi'
	Android13 icon='Transformed Ifrit2.dmi'

//var/list/Makyo_Icons=new

obj/Makyo_Icons
	Click()
		usr.icon=icon
		usr.Tabs=2
		for(var/obj/Makyo_Icons/A in usr) if(A!=src) del(A)
		del(src)
	MakyoClothed icon='DBFANMakyojin.dmi'
	MakyoColorable icon='Makyojin 2.dmi'
	MakyoFemaleColorable icon='Female Makyo.dmi'
	MakyoFemaleDefault icon='Female Makyo.dmi'

//var/list/SD_Icons=new
obj/SD_Icons
	Click()
		usr.icon=icon
		usr.Tabs=2
		for(var/obj/SD_Icons/A in usr) if(A!=src) del(A)
		del(src)
	SD1 icon='SpiritDollHatless.dmi'
	SD2 icon='Spirit Doll.dmi'

//var/list/Oni_Icons=new
obj/Oni_Icons
	name="Icon"
	Click()
		usr.icon=icon
		usr.Tabs=2
		for(var/obj/Oni_Icons/A in usr) if(A!=src) del(A)
		del(src)
	Oni1 icon='Red Oni.dmi'
	Oni2 icon='Blue Oni.dmi'

obj/Aquatian
	name="Icon"
	Click()
		if(!usr.icon)
			usr<<"First Form icon chosen"
			usr.icon=icon
			usr.Form1Icon=icon
		if(!usr.Form2Icon)
			usr<<"Second Form icon chosen."
			usr.Form2Icon=icon
		else if(!usr.Form3Icon)
			usr<<"Third Form icon chosen."
			usr.Form3Icon=icon
		else if(!usr.Form4Icon)
			usr<<"Final Form icon chosen.  You may now choose three progressing states demonstrating what your character will look like when using the 'expand' skill."
			usr.Form4Icon=icon
		//else if(!usr.Form5Icon)
		//	usr<<"Expand stage 1 icon chosen. Choose expand stage 2."
		//	usr.Form5Icon=icon
		else if(!usr.Form6Icon)
			usr<<"Expand stage 2 icon chosen, choose expand stage 3."
			usr.Form6Icon=icon
		else if(!usr.Form7Icon)
			usr<<"Expand stage 3 icon chosen, choose expand stage 4."
			usr.Form7Icon=icon
		else if(!usr.Form8Icon)
			usr<<"Expand stage 4 icon chosen."
			usr.Form8Icon=icon
			usr.Tabs=2
			for(var/obj/Aquatian/A in usr) if(A!=src) del(A)
			del(src)
	C30 icon='C1.dmi'
	C31 icon='C2.dmi'
	C32 icon='C3.dmi'
	C33 icon='C4.dmi'
	C34 icon='C5.dmi'
	C35 icon='C6.dmi'
	C36 icon='C7.dmi'
	C37 icon='C8.dmi'
	C38 icon='C9.dmi'
	C39 icon='C10.dmi'
	C40 icon='C11.dmi'
	C41 icon='2nd form Frieza.dmi'
	C42 icon='3rd form Frieza.dmi'
	C1 icon='Changeling Frieza 100% 2.dmi'
	C2 icon='Changeling Frieza 100%.dmi'
	C3 icon='Changeling Frieza 100% 3.dmi'
	C4 icon='Changeling Frieza 2.dmi'
	C5 icon='Changeling Frieza Form 2, 2.dmi'
	C6 icon='Changeling Frieza Form 2.dmi'
	C7 icon='Changeling Frieza Form 3, 2.dmi'
	C8 icon='Changeling Frieza Form 3.dmi'
	C9 icon='Changeling Frieza Form 4, 2.dmi'
	C10 icon='Changeling Frieza Form 4.dmi'
	C11 icon='Changeling Frieza.dmi'
	C12 icon='Changeling Kold 2.dmi'
	C13 icon='Changeling Kold Form 2.dmi'
	C14 icon='Changeling Kold.dmi'
	C15 icon='Changeling Koola 2.dmi'
	C16 icon='Changeling Koola Form 2.dmi'
	C17 icon='Changeling Koola Form 3, 2.dmi'
	C18 icon='Changeling Koola Form 3.dmi'
	C19 icon='Changeling Koola Form 4, 3.dmi'
	C20 icon='Changeling Koola Form 4.dmi'
	C21 icon='Changeling Koola.dmi'
	C22 icon='Changeling Kuriza.dmi'
	C23 icon='Changeling Koola Expand.dmi'
	C24 icon='Changeling Koola Expand 2.dmi'
	C25 icon='Changeling 1 Large.dmi'
	C26 icon='Changeling 5 Frieza.dmi'
	C27 icon='Changeling 5 Kold.dmi'
	C28 icon='Changeling Frieza Form 4, 3.dmi'
	C29 icon='Changeling Frieza BE.dmi'