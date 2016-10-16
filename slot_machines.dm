obj/Slot_Machine
	icon='White Male.dmi'
	Stealable=1
	desc="This machine lets you input money to play a round of slots.  You may win big, or you may lose hard.  It's all up to chance!<br><br>\
	<b>Stats:</b><br>\
	<i>Claimable (Password)</i>:  You can claim this item once by setting a password for it.<br>\
	<i>Gambling Device (Slot Machine)</i>:  If the usage fee isn't set, the usage fee defaults to 100 resources.  This item may be upgraded to increase the max usage fee.<br>\
	<i>Safe Linkable</i>: You may link this item to a safe.  It will automatically take or input funds there.  If the item lacks funds to draw from, it will shut down.\
	<i>Artificial Female Voice</i>:  Someone designed this machine to have a (presumably) enticing female voice.  Subliminal advertising or high octane nightmare fuel at its finest!"
	var/Link_to_Safe
	var/Input_Amount=100
	var/Payout_Amount
	var/Win
	var/Check_Password
	var/Chat

	verb/Use_Slot_Machine()
		set src in oview(1)
		for(var/obj/Resources/B in usr)
			if(B.Value<=Input_Amount)
				return
			if(B.Value>=Input_Amount)
				B.Value-=Input_Amount
				usr<<"The slot machine whirs for a moment, pausing, before a feminine mechanical voice says:  <font color=#F660AB>'Rolling your slots!~  Please stand by...'</font>"
				sleep(10)
				Win=rand(1,15)
				switch (Win)
					if(1,2,3,4,5,6,12)
						usr<<"The slot machine sounds dejected as it says:  <font color=#F660AB>'Aww, no match!  Care to try your luck again?'</font>"
						return
					if(7,8,9,10,11)
						usr<<"As the slots settle into place, the slot machine chirps out the words:  <font color=#F660AB>'Low match!  Congratulations!  You're a winner!  Here's your reward of [Input_Amount*1.3] credits!'</font>"
						B.Value+=Input_Amount*1.3
						return
					if(13,14)
						usr<<"As the slots settle into place, the slot machine happily says the words:  <font color=#F660AB>High match!  Congratulations!  You're a winner!  Here's your reward of [Input_Amount*2] credits!</font>"
						B.Value+=Input_Amount*2
						return
					if(15)
						usr<<"As the slots settle into place, you can see that you've come up with three 7's.  Lights begin to flash all around the machine, as the voice says exuberantly: <font color=#F660AB>Jackpot!  CONGRATULATIONS!~  You're a winner!  Here's your reward of [Input_Amount*4] credits!</font>"
						B.Value+=Input_Amount*4
						return
/*					if(Win==1||2||3||4||5||6)
						usr<<"The slot machine sounds dejected as it says:  <font color=pink>'Aww, no match!  Care to try your luck again?'</font>"
						return
					if(Win==7||8||9||10||11||12)
						usr<<"As the slots settle into place, the slot machine chirps out the words:  <font color=pink>'Low match!  Congratulations!  You're a winner!  Here's your reward of [Input_Amount*1.3] credits!'</font>"
						B.Value=Input_Amount*1.3
						return
					if(Win==13||14)
						usr<<"As the slots settle into place, the slot machine happily says the words:  <font color=pink>High match!  Congratulations!  You're a winner!  Here's your reward of [Input_Amount*2] credits!</font>"
						B.Value=Input_Amount*2
						return
					if(Win==15)
						usr<<"As the slots settle into place, you can see that you've come up with three 7's.  Lights begin to flash all around the machine, as the voice says exuberantly: <font color=pink>Jackpot!  CONGRATULATIONS!~  You're a winner!  Here's your reward of [Input_Amount*4] credits!</font>"
						B.Value=Input_Amount*4
						return*/
	verb/Claim_Slot_Machine()
		set src in oview(1)
		if (password=="")
			password=input("Enter a password to keep this slot machine from being accessed by unauthorized personnel.") as text
			usr<<"Password set!"
	verb/Set_Usage_Fee()
		set src in oview(1)
		Check_Password=input("What is this slot machine's password?") as text
		if(Check_Password!=password)
			usr<<"Incorrect password."
		if(Check_Password==password)
			Input_Amount=input("Password received!  Input the amount of money you would like to require this machine to be used at!  All rewards will be multiplied by this input amount, so make sure you have enough money in your safe to cover the usage fee!")
			if(Input_Amount==0)
				usr<<"Invalid number.  Resetting the fee to the default amount."
				Input_Amount=100
			name= "[Input_Amount] Credit Slot Machine"


/*	proc/Slot_Flavor
		sleep(1)
		rand(1,2)
		var/Chat
		if(*/








/*				if(Win==1||2||3||4||5||6)
					usr<<"The slot machine sounds dejected as it says:  'Aww, no match!  Care to try your luck again?'"
					break
				if(Win==7||8||9||10||11||12)
					usr<<"As the slots settle into place, the slot machine chirps out the words:  'Low match!  Congratulations!  You're a winner!  Here's your reward of [Input_Amount*1.3] credits!'"
					B.Value=Input_Amount*1.3
					break
				if(Win==13||14)
					usr<<"High match!  Congratulations!  You're a winner!  Here's your reward of [Input_Amount*2] credits!"
					B.Value=Input_Amount*2
					break
				if(Win==15)
					usr<<"Jackpot!  CONGRATULATIONS!~  You're a winner!  Here's your reward of [Input_Amount*4] credits!"
					B.Value=Input_Amount*4
					break*/