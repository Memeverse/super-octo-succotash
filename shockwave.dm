obj/Attacks/Shockwave
	var/Drain=50
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(A,10000)
	verb/Shockwave()
		set category="Skills"
		if((usr.icon_state in list("Meditate","Train","KO","KB"))||usr.Frozen) return
		if(usr.attacking||usr.Ki<Drain||charging) return
		usr.Ki-=Drain
		usr.attacking=3
		charging=1
		if(!Learnable)
			Learnable=1
			spawn(100) Learnable=0
		var/Amount=5
		spawn if(usr) while(Amount)
			Amount-=1
			for(var/turf/T in oview(usr,7))
				if(prob(15)&&!T.density&&!T.Water)
					var/Dirts=1
					while(Dirts)
						Dirts-=1
						var/image/I=image(icon='Damaged Ground.dmi',pixel_x=rand(-16,16),pixel_y=rand(-16,16))
						T.overlays+=I
						T.Remove_Damaged_Ground(I)
				spawn(rand(0,10)) missile(pick('Haze.dmi','Electric_Blue.dmi','Dust.dmi'),usr,T)
			sleep(3)
		spawn if(usr) for(var/mob/P in oview(usr,8)) if(P!=usr)
			var/Distance=round(10*(usr.Pow/P.Res)*(usr.BP/P.BP))
			if(Distance>30) Distance=30
			P.Shockwave_Knockback(Distance,usr.loc)
			P.Health-=2*(usr.BP/P.BP)*(usr.Pow/P.Res)
			sleep(1)
		spawn if(usr) for(var/obj/O in oview(usr,8)) if(O.z) if(O.Shockwaveable)
			var/obj/Crater/C=new
			C.loc=O.loc
			O.Shockwave_Knockback(10,usr.loc)
			sleep(1)
		spawn(100/usr.SpdMod) if(usr)
			usr.attacking=0
			charging=0