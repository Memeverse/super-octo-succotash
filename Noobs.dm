var/list/Alliance=new
var/list/Noobs=new
proc/Save_Noobs()
	var/savefile/S=new("Data/Alliance.bdb")
	S["Noobs"]<<Noobs
	S["Alliance"]<<Alliance
proc/Load_Noobs() if(fexists("Data/Alliance.bdb"))
	var/savefile/S=new("Data/Alliance.bdb")
	S["Noobs"]>>Noobs
	S["Alliance"]>>Alliance
obj/Noobify
	desc="Noobify lets you declare someone as a noob. Which will make it so any character using their \
	key will be stuck at very low power until removed as a noob. You can also use this to strip \
	Noobify from those who are abusing it. An example of abusing it is using it for IC situations, \
	only use it on NOOBS who pose an OOC threat to other roleplayers, including 100% CONFIRMED unrp \
	stealing/attacking/killing, and ONLY if you see it. If you use it on a situation that you did not \
	see based on someone else's word, you need to be fucking stripped because your a fucking abuser. \
	If not, good job, and thanks for making the noob menace a little less threatening to the \
	roleplayer community. You can also teach it to others, it is an OOC ability, only teach it to \
	people who are 100% capable of judging who should and should not be a noob, and will follow \
	everything listed here. Anyone who has Noobify is a member of the unsaid roleplayer alliance, \
	and you must all band together to protect roleplaying values if you truly don't want noobs \
	to succeed in corrupting everything. Anyone who has noobify, should be treated as a member of \
	a great alliance, like an empire of roleplayers, thats how it should be thought of, we are not \
	all solo, if we are, the noobs win anyway. If a member of that alliance betrays that and proves \
	to be a noob themselves, or proves corrupt and unable to truly determine noobs from roleplayers, \
	any other person in the alliance can strip them of noobify, using the Teach verb on them again."
	var/Alliance_On=1
	verb/Noobify()
		set category="Skills"
		switch(input("") in list("Add","Remove","Cancel"))
			if("Add")
				usr<<"Use the Description verb on Noobify before using this."
				var/list/Noobables=new
				Noobables.Add("Cancel",Players)
				var/mob/B=input("Choose") in Noobables as mob|null
				if(!B|B=="Cancel") return
				if(Noobs.Find(B.key))
					usr<<"They are already a certified noob"
					return
				for(var/mob/player/A in Players)
					if(A.client.holder || locate(type) in A)
					 A << "[key_name(usr)] noobified [key_name(B)]"
				Noobs+=B.key
				for(var/obj/Noobify/N in B) del(N)
				log_admin("[key_name(usr)] noobified [key_name(B)]")
			if("Remove")
				var/list/Noobables=new
				Noobables.Add("Cancel",Players)
				var/mob/B=input("Choose") in Noobables as mob|null
				if(!B|B=="Cancel") return
				if(!Noobs.Find(B.key))
					usr<<"They are not a noob"
					return
				for(var/mob/player/A) if(A.client.holder || locate(type) in A)
					A<<"[key_name(usr)] just un-noobified [key_name(B)]"
				Noobs-=B.key
				if(!B.Dead)
					B.z=0
					B.Location()
				log_admin("[key_name(usr)] un-noobified [key_name(B)]")
			if("Cancel") return
		Save_Noobs()
	verb/Teach()
		set category="Other"
		var/list/Choices=new
		Choices.Add("Cancel",Players)
		var/mob/A=input("Teach Noobify to who?") in Choices
		if(A=="Cancel") return
		if(locate(type) in A)
			switch(input("They already are a member of the roleplayer alliance. Should they be thrown \
			out? Only throw them out if they are a noob who somehow got noobify, or they are corrupt and \
			do not fairly or accurately judge noobs and roleplayers apart, so they abuse noobify.") in \
			list("No","Yes"))
				if("Yes")
					for(var/mob/player/P in Players)
						if(P.client.holder ||locate(type) in P)
							P << "[key_name(usr)] removed [key_name(A)] from the roleplayer alliance"
					for(var/obj/Noobify/N in A) del(N)
					log_admin("[key_name(usr)] removed noobify from [key_name(A)]")
					Alliance-=A.key
		else if(A)
			A.contents+=new type
			for(var/mob/B) if(B.client.holder||locate(type) in B) B<<"[usr] just gave [A.lastKnownKey] noobify"
			log_admin("[key_name(usr)] gave noobify to [key_name(A)]")
			Alliance+=A.key
	verb/Alliance_Members()
		set category="Other"
		switch(input("What category do you wish to see?") in list("Alliance Members","Certified Noobs"))
			if("Alliance Members") for(var/mob/player/A in Players) if(locate(type) in A) usr<<"[A.lastKnownKey] ([A])"
			if("Certified Noobs") for(var/A in Noobs) usr<<"[A]"
	verb/RPOOC(A as text)
		set category="Other"
		A = copytext(sanitize(A), 1, MAX_MESSAGE_LEN)
		log_ooc("RP: [A]")
		for(var/mob/player/B in Players) for(var/obj/Noobify/C in B) if(C.Alliance_On)
			B<<"<font size=[B.TextSize]>(Alliance)<font color=[usr.TextColor]>[usr.lastKnownKey]: [A]"
	verb/Alliance_Chat_Toggle()
		set category="Other"
		if(Alliance_On)
			Alliance_On=0
			usr<<"Alliance Chat Off"
		else
			Alliance_On=1
			usr<<"Alliance Chat On"