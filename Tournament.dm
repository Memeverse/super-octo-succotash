obj/Tournament_Register
	icon='Turfs 5.dmi'
	icon_state="computer"
	var/inprogress
	var/mob/e1
	var/mob/e2
	var/mob/e3
	var/mob/e4
	var/mob/e5
	var/mob/e6
	var/mob/e7
	var/mob/e8
	var/mob/round1 //round 1 winner
	var/mob/round2
	var/mob/round3
	var/mob/round4
	var/mob/semi1
	var/mob/semi2
	verb/Register()
		set src in oview(1)
		if(e1==usr|e2==usr|e3==usr|e4==usr|e5==usr|e6==usr|e7==usr|e8==usr)
			usr<<"You are already registered."
			return
		if(e1) if(e1.client.address==usr.client.address)
			usr<<"You cannot register multikeys."
			return
		if(e2) if(e2.client.address==usr.client.address)
			usr<<"You cannot register multikeys."
			return
		if(e3) if(e3.client.address==usr.client.address)
			usr<<"You cannot register multikeys."
			return
		if(e4) if(e4.client.address==usr.client.address)
			usr<<"You cannot register multikeys."
			return
		if(e5) if(e5.client.address==usr.client.address)
			usr<<"You cannot register multikeys."
			return
		if(e6) if(e6.client.address==usr.client.address)
			usr<<"You cannot register multikeys."
			return
		if(e7) if(e7.client.address==usr.client.address)
			usr<<"You cannot register multikeys."
			return
		if(e8) if(e8.client.address==usr.client.address)
			usr<<"You cannot register multikeys."
			return
		if(e1&&e2&&e3&&e4&&e5&&e6&&e7&&e8)
			usr<<"All entrees are filled already."
			return
		if(!e1) e1=usr
		else if(!e2) e2=usr
		else if(!e3) e3=usr
		else if(!e4) e4=usr
		else if(!e5) e5=usr
		else if(!e6) e6=usr
		else if(!e7) e7=usr
		else if(!e8) e8=usr
		usr<<"Registered!"
	New()
		spawn if(src) Tournament()
		//..()
	proc/Tournament()
		while(src)
			if(e1&&e2&&e3&&e4&&e5&&e6&&e7&&e8&&!inprogress)
				inprogress=1
				e1.loc=locate(x-4,y-1,z)
				e2.loc=locate(x-3,y-1,z)
				e3.loc=locate(x-2,y-1,z)
				e4.loc=locate(x-1,y-1,z)
				e5.loc=locate(x+1,y-1,z)
				e6.loc=locate(x+2,y-1,z)
				e7.loc=locate(x+3,y-1,z)
				e8.loc=locate(x+4,y-1,z)
				view(src)<<"The tournament is about to begin!!"
				sleep(50)
				view(src)<<"**RULES**"
				view(src)<<"No killing."
				view(src)<<"No stealing."
				view(src)<<"Wins are by knockout only."
				view(src)<<"If it is not your turn to fight stay in your place,"
				view(src)<<"and dont fire blasts or attack at all until its your turn."
				view(src)<<"All fights are one-on-one, do not interfere."
				view(src)<<"If you cannot recover damage before your next fight begins, too bad.  This is an endurance tourney."
				sleep(300)
				if(e1&&e2)
					sleep(50)
					view(src)<<"First match: [e1] VS [e2]. FIGHT!"
					e1.loc=locate(x-3,y-5,z)
					e2.loc=locate(x+3,y-5,z)
					e1.dir=EAST
					e2.dir=WEST
					while(e1&&e2)
						sleep(1)
						if(e1.icon_state=="KO")
							view(src)<<"[e2] wins due to a knockout."
							round1=e2
							sleep(50)
							e1.loc=locate(x,y,z)
							e2.loc=locate(x,y,z)
							e1.Un_KO()
							break
						else if(e2.icon_state=="KO")
							view(src)<<"[e1] wins due to a knockout."
							round1=e1
							sleep(50)
							e1.loc=locate(x,y,z)
							e2.loc=locate(x,y,z)
							e2.Un_KO()
							break
				else
					if(!e1&&!e2) view(src)<<"Contestant 1 and Contestant 2 were not found."
					if(!e1&&e2)
						view(src)<<"Contestant 1 was not found, #2 [e2] advances."
						round1=e2
					else
						view(src)<<"Contestant 2 was not found, #1 [e1] advances."
						round1=e1
				if(e3&&e4)
					sleep(50)
					view(src)<<"Second match: [e3] VS [e4]. FIGHT!"
					e3.loc=locate(x-3,y-5,z)
					e4.loc=locate(x+3,y-5,z)
					e3.dir=EAST
					e4.dir=WEST
					while(e3&&e4)
						sleep(1)
						if(e3.icon_state=="KO")
							view(src)<<"[e4] wins due to a knockout."
							round2=e4
							sleep(50)
							e3.loc=locate(x,y,z)
							e4.loc=locate(x,y,z)
							e3.Un_KO()
							break
						else if(e4.icon_state=="KO")
							view(src)<<"[e3] wins due to a knockout."
							round2=e3
							sleep(50)
							e3.loc=locate(x,y,z)
							e4.loc=locate(x,y,z)
							e4.Un_KO()
							break
				else
					if(!e3&&!e4) view(src)<<"Contestant 3 and Contestant 4 were not found."
					if(!e3&&e4)
						view(src)<<"Contestant 3 was not found, #4 [e4] advances."
						round2=e4
					else
						view(src)<<"Contestant 4 was not found, #3 [e3] advances."
						round2=e3
				if(e5&&e6)
					sleep(50)
					view(src)<<"Third match: [e5] VS [e6]. FIGHT!"
					e5.loc=locate(x-3,y-5,z)
					e6.loc=locate(x+3,y-5,z)
					e5.dir=EAST
					e6.dir=WEST
					while(e5&&e6)
						sleep(1)
						if(e5.icon_state=="KO")
							view(src)<<"[e6] wins due to a knockout."
							round3=e6
							sleep(50)
							e5.loc=locate(x,y,z)
							e6.loc=locate(x,y,z)
							e5.Un_KO()
							break
						else if(e6.icon_state=="KO")
							view(src)<<"[e5] wins due to a knockout."
							round3=e5
							sleep(50)
							e5.loc=locate(x,y,z)
							e6.loc=locate(x,y,z)
							e6.Un_KO()
							break
				else
					if(!e5&&!e6) view(src)<<"Contestant 5 and Contestant 6 were not found."
					if(!e5&&e6)
						view(src)<<"Contestant 5 was not found, #6 [e6] advances."
						round3=e6
					else
						view(src)<<"Contestant 6 was not found, #5 [e5] advances."
						round3=e5
				if(e7&&e8)
					sleep(50)
					view(src)<<"Fourth match: [e7] VS [e8]. FIGHT!"
					e7.loc=locate(x-3,y-5,z)
					e8.loc=locate(x+3,y-5,z)
					e7.dir=EAST
					e8.dir=WEST
					while(e7&&e8)
						sleep(1)
						if(e7.icon_state=="KO")
							view(src)<<"[e8] wins due to a knockout."
							round4=e8
							sleep(50)
							e7.loc=locate(x,y,z)
							e8.loc=locate(x,y,z)
							e7.Un_KO()
							break
						else if(e8.icon_state=="KO")
							view(src)<<"[e7] wins due to a knockout."
							round4=e7
							sleep(50)
							e7.loc=locate(x,y,z)
							e8.loc=locate(x,y,z)
							e8.Un_KO()
							break
				else
					if(!e7&&!e8) view(src)<<"Contestant 7 and Contestant 8 were not found."
					if(!e7&&e8)
						view(src)<<"Contestant 7 was not found, #8 [e8] advances."
						round4=e8
					else
						view(src)<<"Contestant 8 was not found, #7 [e7] advances."
						round4=e7
				//Semifinals
				if(round1&&round2)
					sleep(50)
					view(src)<<"Semifinal 1 match: [round1] VS [round2]. FIGHT!"
					round1.loc=locate(x-3,y-5,z)
					round2.loc=locate(x+3,y-5,z)
					round1.dir=EAST
					round2.dir=WEST
					while(round1&&round2)
						sleep(1)
						if(round1.icon_state=="KO")
							view(src)<<"[round2] wins due to a knockout."
							semi1=round2
							sleep(50)
							round1.loc=locate(x,y,z)
							round2.loc=locate(x,y,z)
							round1.Un_KO()
							break
						else if(round2.icon_state=="KO")
							view(src)<<"[round1] wins due to a knockout."
							semi1=round1
							sleep(50)
							round1.loc=locate(x,y,z)
							round2.loc=locate(x,y,z)
							round2.Un_KO()
							break
				else
					if(!round1&&!round2) view(src)<<"Contestant 1 and Contestant 2 were not found."
					if(!round1&&round2)
						view(src)<<"Contestant 1 was not found, #2 [round2] advances."
						semi1=round2
					else
						view(src)<<"Contestant 2 was not found, #1 [round1] advances."
						semi1=round1
				if(round3&&round4)
					sleep(50)
					view(src)<<"Semifinal 2 match: [round3] VS [round4]. FIGHT!"
					round3.loc=locate(x-3,y-5,z)
					round4.loc=locate(x+3,y-5,z)
					round3.dir=EAST
					round4.dir=WEST
					while(round3&&round4)
						sleep(1)
						if(round3.icon_state=="KO")
							view(src)<<"[round4] wins due to a knockout."
							semi2=round4
							sleep(50)
							round3.loc=locate(x,y,z)
							round4.loc=locate(x,y,z)
							round3.Un_KO()
							break
						else if(round4.icon_state=="KO")
							view(src)<<"[round3] wins due to a knockout."
							semi2=round3
							sleep(50)
							round3.loc=locate(x,y,z)
							round4.loc=locate(x,y,z)
							round4.Un_KO()
							break
				else
					if(!round3&&!round4) view(src)<<"Contestant 3 and Contestant 4 were not found."
					if(!round3&&round4)
						view(src)<<"Contestant 3 was not found, #4 [round4] advances."
						semi2=round4
					else
						view(src)<<"Contestant 4 was not found, #3 [round3] advances."
						semi2=round3
				//Finals
				if(semi1&&semi2)
					sleep(50)
					view(src)<<"Final match: [semi1] VS [semi2]. FIGHT!"
					semi1.loc=locate(x-3,y-5,z)
					semi2.loc=locate(x+3,y-5,z)
					semi1.dir=EAST
					semi2.dir=WEST
					while(semi1&&semi2)
						sleep(1)
						if(semi1.icon_state=="KO")
							sleep(50)
							view(src)<<"[semi2] has won the tournament."
							view(src)<<"[semi2] recieves 10000 Money."
							view(src)<<"[semi1] recieves 5000 Money."
							semi1.Money+= 50000
							semi2.Money+= 100000
							semi1.Un_KO()
							e1=null
							e2=null
							e3=null
							e4=null
							e5=null
							e6=null
							e7=null
							e8=null
							return
						else if(semi2.icon_state=="KO")
							sleep(50)
							view(src)<<"[semi1] has won the tournament."
						//	view(src)<<"[semi1] recieves 10000 Money."
						//	view(src)<<"[semi2] recieves 5000 Money."
						//	semi1.Money+= 100000
						//	semi2.Money+=50000
							semi2.Un_KO()
							e1=null
							e2=null
							e3=null
							e4=null
							e5=null
							e6=null
							e7=null
							e8=null
							return
				else
					if(!semi1&&!semi2) view(src)<<"Neither finalists were found, the tournament is over."
					if(!semi1&&semi2) view(src)<<"Finalist 1 was not found. Nobody recieves a prize."
					else view(src)<<"Finalist 2 was not found. Nobody recieves a prize."
			sleep(600)