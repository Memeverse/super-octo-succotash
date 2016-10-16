mob/var/Diarea=0


mob/proc/Diarea() if(prob(Diarea-Immunity))
	overlays-='Shitspray.dmi'
	overlays+='Shitspray.dmi'
	spawn(50) overlays-='Shitspray.dmi'
	for(var/mob/A in view(src))
		if(A.client)
			A<<sound(pick('Fart1.wav','Fart2.wav','Fart3.wav','Fart3.wav','Fart4.wav','Fart5.wav','Fart6.wav',\
			'Fart7.wav','Fart8.wav','Fart9.wav','Fart10.wav','Fart11.wav','Fart12.wav','Fart13.wav',\
			'Fart14.wav'))
		if(prob(50)&&src!=A&&A.Diarea<200) A.Diarea+=1
	var/Turds=rand(1,2)
	var/list/TurdSpots=new
	for(var/turf/B in view(7,src)) TurdSpots+=B
	spawn while(Turds)
		var/obj/Turd/T=new
		T.loc=locate(x+rand(-1,1),y+rand(-1,1),z)
		walk_towards(T,pick(TurdSpots))
		Turds-=1
		sleep(1)
	if(Diarea>200) Diarea=200
	if(prob(20)) Diarea-=1
obj/Turd
	icon='Shit.dmi'
	New()
		pixel_x=rand(-16,16)
		pixel_y=rand(-16,16)
		spawn(rand(300,2400)) del(src)
		//..()