/*
 * shadow_spar.dm
 * by: valekor
 * date: 3/30/2014
 * description:
 * A different way to train, spawns a copy of yourself, much like you'd expect splitform but with a bit more interaction into it.
 * Shadow Sparring is not something players already have. For now it'll be given out by admins.
 * The idea is to give roleplays an easier, yet still fun/involved way to train with a bit better gains.
 *
 * variables:
 * shadspar - temporary variable to determine if a player is shadow sparring
 *
 *
*/

#ifndef TO_HEX_DIGIT
#error You don't have the library LummoxJR.IconProcs included! Go here: http://www.byond.com/forum/?post=51608
#endif

mob/sparpartner // mobtype for the shadow
	P_BagG = 8
	var/dodge = NORTH // first direction they're supposed to move to

mob/player/proc

	Shadow_Spar()
		set category = "Skills"
		return //I'd like to see this disabled for the moment, due to a few instances of abuse that is currently undetectable.
		if( shadspar )
			End_Shadow()
			return

		if( icon_state=="Flight"|| icon_state=="Meditate"|| icon_state=="KO"|| icon_state=="KB"|| icon_state=="Train" || attacking || Frozen ) return

		src << "Your shadow suddenly gains mass and out of it steps a grey and white copy of you, ready to attack. Dodge the barrage of attacks!"
		var/mob/sparpartner/shadow = new(loc) // create a new mob so we can turn it into their copy
		shadows += list(shadow) // add them to the list of created shadowclones
		shadspar = 1
		dir = EAST
		Frozen = 1 // they're not allowed to move

		// position the shadow correctly and such
		shadow.name         = "[name]'s Shadow"
		shadow.loc          = locate( x == world.maxx ? x : x + 1 , shadow.x == x + 1 ? (y == world.maxy ? y : y + 1) : y , z)
		shadow.dir          = WEST
		shadow.density      = 0
		shadow.invisibility = invisibility

		var/icon/shadowIcon = new(src.icon)
		shadowIcon.GrayScale() // turn them into a black 'n white version ofthe original for cool points
		shadow.icon         = shadowIcon

		shadow.overlays     = overlays.Copy()
		shadow.icon_state   = icon_state

		Opp = shadow // we're dealing with how they gain stats/etc via Attack_Gain()
		src << "<font color=red size=1><b>Use the movement keys to train. Press up to begin.</b></font>"

mob/proc

	Shadow_Train(_dir)

		var/mob/sparpartner/shadow
		shadow = Opp

		if(_dir != shadow.dodge)
			flick("Attack", shadow)
			src << "<font color=red size=1><b>You fail to dodge and take a hit!</b></font>"
			src.Ki -= src.MaxKi/30

		else
			flick("Attack", shadow)
			flick('Zanzoken.dmi', src)
			Attack_Gain()
			src.Ki -= src.MaxKi/90
			Attack_Gain()

		shadow.dodge = pick(NORTH, WEST, SOUTH, EAST)
		src << "<font color=green size=1><b>Your shadow clone is about to [shadow.dodge == NORTH ? "attack from below" : shadow.dodge == WEST ? "attack from the right" : shadow.dodge == SOUTH ? "attack from the front" : "attack from the left"]!</b></font>"


// Make sure the have enough energy left to continue.
		if( Ki < 10 )
			Ki = 0
			src << "You are too fatigued to continue."
			End_Shadow()
			return

	End_Shadow()
		src << "The shadow clone vanishes."
		src.icon_state = null
		src.Frozen = 0
		src.Opp = null
		src.shadspar = 0
		for ( var/atom/A in shadows )
			if(A) del A