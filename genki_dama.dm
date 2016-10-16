obj/ranged/Blast/Genki_Dama
	Piercer=0
	Explosive=1
	density=1
	Sokidan=1
	var/Size
	New()
		spawn if(src) Health=Damage
	proc/Medium(Icon,X,Y,Z,T)
		Icon+=rgb(X,Y,Z,T)
		var/image/A=image(icon=Icon,icon_state="1",pixel_x=-16,pixel_y=-16,layer=5)
		var/image/B=image(icon=Icon,icon_state="2",pixel_x=16,pixel_y=-16,layer=5)
		var/image/C=image(icon=Icon,icon_state="3",pixel_x=-16,pixel_y=16,layer=5)
		var/image/D=image(icon=Icon,icon_state="4",pixel_x=16,pixel_y=16,layer=5)
		overlays.Add(A,B,C,D)
	proc/Large(Icon,X,Y,Z,T)
		Icon+=rgb(X,Y,Z,T)
		var/image/A=image(icon=Icon,icon_state="1",pixel_x=-32,pixel_y=-32,layer=5)
		var/image/B=image(icon=Icon,icon_state="2",pixel_x=0,pixel_y=-32,layer=5)
		var/image/C=image(icon=Icon,icon_state="3",pixel_x=32,pixel_y=-32,layer=5)
		var/image/D=image(icon=Icon,icon_state="4",pixel_x=-32,pixel_y=0,layer=5)
		var/image/E=image(icon=Icon,icon_state="5",pixel_x=0,pixel_y=0,layer=5)
		var/image/F=image(icon=Icon,icon_state="6",pixel_x=32,pixel_y=0,layer=5)
		var/image/G=image(icon=Icon,icon_state="7",pixel_x=-32,pixel_y=32,layer=5)
		var/image/H=image(icon=Icon,icon_state="8",pixel_x=0,pixel_y=32,layer=5)
		var/image/I=image(icon=Icon,icon_state="9",pixel_x=32,pixel_y=32,layer=5)
		overlays.Add(A,B,C,D,E,F,G,H,I)
	Move()
		var/Distance=0
		if(Size) Distance=Size
		for(var/atom/A in orange(Distance,src)) if(A!=src&&A.density&&!isarea(A)) Bump(A)
		if(src) ..()
obj/Attacks/Genki_Dama
	desc="This is perhaps the most powerful 1-hit attack in existance. You press it once to begin \
	gathering the energy. When it is done gathering energy, a ball of charged energy appears at your \
	hand. Once that is done, you can then press it again to release the genki dama, which is \
	somewhere above your character, and you will have to guide it to its target, much like sokidan. \
	It is somewhat masterable, you can decrease the time it takes to charge it by using it, \
	but even at maximum charge rate, it charges pretty slow compared to other attacks. This move is \
	extremely deadly, so do not use it on someone because it may kill them in a single hit."
	var/IsCharged
	var/Mode="Small"
	KiReq=1000
	verb/Settings()
		set category="Other"
		switch(input("Choose a size. It will affect the power and speed in different ways.") in \
		list("Small","Medium","Large"))
			if("Small") Mode="Small"
			if("Medium") Mode="Medium"
			if("Large") Mode="Large"
	verb/Genki_Dama()
		set category="Skills"
		if((usr.icon_state in list("Meditate","Train","KO","KB"))||usr.Frozen) return
		if(usr.attacking|usr.Ki<KiReq|charging) return
		if(!IsCharged)
			var/obj/ranged/Blast/Genki_Dama/A=new(usr.loc)
			A.y+=10
			if(!A||!A.z) return
			A.Belongs_To=usr
			A.Damage=250*usr.BP*usr.Pow*Ki_Power
			A.Power=250*usr.BP*Ki_Power
			A.Offense=usr.Off
			if(Mode=="Small") A.icon='SBomb.dmi'
			if(Mode=="Medium")
				A.Size=1
				A.Damage*=2
				A.Power*=2
				A.Explosive=2
				A.Medium('deathball.dmi',100,200,250,180)
			if(Mode=="Large")
				A.Size=1
				A.Damage*=3
				A.Power*=3
				A.Explosive=2
				A.Large('Spirit Bomb.dmi',0,0,0,180)
			usr.attacking=3
			charging=1
			if(prob(10)&&Experience<1) Experience+=0.1
			usr.overlays+='SBombGivePower.dmi'
			if(Mode=="Small") sleep(100/usr.SpdMod/Experience)
			if(Mode=="Medium") sleep(150/usr.SpdMod/Experience)
			if(Mode=="Large") sleep(200/usr.SpdMod/Experience)
			charging=0
			usr.overlays-='SBombGivePower.dmi'
			usr.attacking=0
			if(A)
				IsCharged=1
				usr.overlays+=usr.BlastCharge
		else
			IsCharged=0
			usr.Ki-=KiReq
			usr.overlays-=usr.BlastCharge
			flick("Attack",usr)
			charging=1
			var/obj/ranged/Blast/Genki_Dama/A
			for(var/obj/ranged/Blast/Genki_Dama/B) if(B.Belongs_To==usr) A=B
			while(A&&usr)
				step(A,usr.dir)
				if(Mode=="Small") sleep(2)
				if(Mode=="Medium") sleep(3)
				if(Mode=="Large") sleep(4)
			charging=0
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(A,2000,-1000)
