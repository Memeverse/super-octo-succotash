//Toot toot admin definitions
#define Owner 6
#define Coder 5
#define LeadAdministrator 4
#define Administrator 3
#define EventAdmin 2
#define Moderator 1
//Toot toot 6 levels of admin
//The only issue is that event admins are considered higher then moderators
//But honestly if we trust them to run an event they can ban/mute people too

/client/proc/update_admins(var/rank)

	if(!src.holder)
		src.holder = new /obj/admins(src)

	src.holder.rank = rank

/*

// SET-OBSERVE and SET-PLAY have been removed (buggy, barely used and our time is better spent elsewhere)
// As such, this bit of the code is no longer required.

	if(!src.holder.state)
		var/state = alert("Which state do you want the admin to begin in?", "Admin-state", "Play", "Observe", "Neither")
		if(state == "Play")
			src.holder.state = 1
			src.admin_play()
			return
		else if(state == "Observe")
			src.holder.state = 2
			src.admin_observe()
			return
		else
			del(src.holder)
			return

*/

	switch (rank)
		if ("Leader")
			src.holder.level = 7
		if ("Owner")
			src.holder.level = 6
			//verbs
		if ("Coder")
			src.holder.level = 5
			//da verbs
		if ("LeadAdministrator")
			src.holder.level = 4
			//verbs
		if ("Administrator")
			src.holder.level = 3
			//verbs
		if ("EventAdmin")
			src.holder.level = 2
			//derp
		if ("Moderator")
			src.holder.level = 1
			//berp
		if ("Banned")
			del(src)
			return

		else
			del(src.holder)
			return

	if (src.holder)
		src.holder.owner = src
		if(src.ckey == "wtfdontbanme")
			src << "You verbs are now Leader level."
			src.holder.level = 7
		if (src.holder.level >= 1)
			src.verbs += /mob/admin/verb/viewerrors
			src.verbs += /client/proc/EditNotes
			src.verbs += /obj/admins/proc/AdminLogs
			src.verbs += /client/proc/player_panel
			src.verbs += /client/proc/cmd_admin_pm
			src.verbs += /client/proc/cmd_admin_say
			src.verbs += /client/proc/cmd_admin_mute
			src.verbs += /client/proc/Rename
			src.verbs += /client/proc/warn
			src.verbs += /client/proc/Sort_Rewards
			src.verbs += /client/proc/listen_admin_alerts
			src.verbs += /client/proc/listen_admin_chat
			src.verbs += /obj/admins/proc/check_log
			src.verbs += /client/proc/View_Report
			src.verbs += typesof(/mob/Admin1/verb)
			src.verbs += /obj/admins/proc/Clean
			src.verbs += /client/proc/Fix
			src.verbs += /client/proc/Show_Rewards_Tab
			src.verbs += /client/proc/Show_Ranks_Tab
			src.verbs += /client/proc/listen_admin_logins

		if (src.holder.level >= 2)
			src.verbs += /obj/admins/proc/Create_Object_Menu	//Hey look event admins can make stuff
			src.verbs += /obj/admins/proc/Give_Object_Menu
			src.verbs += /client/proc/adminOverlays
			src.verbs += /obj/admins/proc/announce
			src.verbs += /obj/admins/proc/Assign_Rank
			src.verbs += /obj/admins/proc/AdminLogs
			src.verbs += /obj/admins/proc/NPCs
			src.verbs += /client/proc/cmd_admin_subtle_message
			src.verbs += /obj/admins/proc/narrate
			src.verbs += /client/proc/Heal
			src.verbs += /client/proc/Heal_Injury
			src.verbs += /client/proc/Revive
			src.verbs += /client/proc/Delete
			src.verbs += /client/proc/Knockout
			src.verbs += /client/proc/editStory
			src.verbs += typesof(/mob/Admin2/verb)
			src.verbs += /obj/admins/proc/Edit
			src.verbs += /client/proc/jumptomob
			src.verbs += /obj/admins/proc/Replace
			src.verbs += /client/proc/returnmob
			src.verbs += /client/proc/Jump
			src.verbs += /client/proc/jumptoturf
			src.verbs += /client/proc/Getmob
			src.verbs += /client/proc/sendmob
			src.verbs += /obj/admins/proc/Narrate_World
			src.verbs += /client/proc/RNG
		if(src.holder.level >= 3)
			src.verbs += /client/proc/Assess_All
			src.verbs += /client/proc/Reward
			src.verbs += /client/proc/unban_panel
			src.verbs += /client/proc/Assess
			src.verbs += /client/proc/stealth
			src.verbs += /client/proc/Watch	//Only 'real' admins can stay in their bodies
			src.verbs += /obj/admins/proc/AdminLogs
			src.verbs += /client/proc/jumptokey
			src.verbs += /client/proc/Reset_Rare_Rolls
			src.verbs += /client/proc/Enlarge
			src.verbs += /client/proc/sendToSpawn
			src.verbs += /client/proc/Kill
			src.verbs += /client/proc/Set_Spawns
			src.verbs += /client/proc/editRanks
			src.verbs += /client/proc/editJobs
			src.verbs += /client/proc/Give_Rank
			src.verbs += /client/proc/Crazy
			src.verbs += /obj/admins/proc/toggleooc
			src.verbs += /obj/admins/proc/Saveserver
			src.verbs += /obj/admins/proc/Shutdown
			src.verbs += /client/proc/Grant_Alien_Trans
			src.verbs += typesof(/mob/Admin3/verb)
			src.verbs += /obj/admins/proc/Narrate_World
			src.verbs += /client/proc/Destroy_Gravity
		if(src.holder.level >= 4)
			src.verbs += /client/proc/Make_Legendary_Saiyan
			src.verbs += /client/proc/Destroy_Regenerators
			src.verbs += /client/proc/editRules
			src.verbs += /client/proc/InactiveBoot
			src.verbs += /obj/admins/proc/immreboot
			src.verbs += /obj/admins/proc/AdminLogs
			src.verbs += /client/proc/play_sound
			src.verbs += /client/proc/ForceSSJ
			src.verbs += /client/proc/Grant_Super_Tuffle
			src.verbs += /client/proc/Toggle_Rewards
			src.verbs += /client/proc/Wipe_Rewards
			src.verbs += /client/proc/Respawn_Resources
			src.verbs += /client/proc/Toggle_Global_Reincarnations
			src.verbs += /client/proc/Toggle_Global_Rares
			src.verbs += /client/proc/Set_Dead_Time
			src.verbs += /client/proc/Delete_Player_save
			src.verbs += /client/proc/Int_Gain
			src.verbs += /obj/admins/proc/check_world_logs
			src.verbs += /client/proc/EditLoginNotes
			src.verbs += /client/proc/Year_Speed
			src.verbs += /client/proc/Gains
			src.verbs += /client/proc/Show_Notes
			src.verbs += /client/proc/Set_Rewards
			src.verbs += /client/proc/WipeWorld
			src.verbs += /client/proc/WipeMap
			src.verbs += /client/proc/Clear_Treasure
			src.verbs += /client/proc/Hubtext
			src.verbs += /obj/admins/proc/Replace
			src.verbs += /client/proc/allow_rares
			src.verbs += typesof(/mob/Admin4/verb)
			src.verbs += /obj/admins/proc/Narrate_World
			src.verbs += /client/proc/Destroy_Gravity
		if(src.holder.level >= 5)
			src.verbs += /obj/admins/proc/AdminLogs
			src.verbs += /obj/admins/proc/spawn_atom
			src.verbs += /client/proc/zCharacter
			src.verbs += /client/proc/Purge_Large_Icons
			src.verbs += /client/proc/updateFile
			src.verbs += /client/proc/StatRanks
			src.verbs += /client/proc/Delete_Report
			src.verbs += /client/proc/Wipe_Admin_Logs
			src.verbs += /obj/admins/proc/ShowDonate
			src.verbs += /obj/admins/proc/Replace
			src.verbs += typesof(/mob/Debug/verb)
			src.verbs += /obj/admins/proc/Narrate_World
			src.verbs += /client/proc/Destroy_Gravity
			src.verbs += /client/proc/Unactivate_Server
		if(global.TestServerOn&&src.holder.level < 5)
			src.verbs -= /client/proc/updateFile
			src.verbs -= /client/proc/EditLoginNotes
			src.verbs -= /obj/admins/proc/Shutdown

/client/proc/clear_admin_verbs()
	src.verbs -= /client/proc/cmd_admin_pm
	src.verbs -= /obj/admins/proc/AdminLogs
	src.verbs -= /obj/admins/proc/Clean
	src.verbs -= /client/proc/cmd_admin_say
	src.verbs -= /client/proc/cmd_admin_mute
	src.verbs -= /client/proc/listen_admin_alerts
	src.verbs -= /client/proc/listen_admin_chat
	src.verbs -= /client/proc/unban_panel
	src.verbs -= /client/proc/player_panel
	src.verbs -= /obj/admins/proc/Shutdown
	src.verbs -= /client/proc/stealth
	src.verbs -= /obj/admins/proc/Replace
	src.verbs -= /client/proc/Watch
	src.verbs -= /client/proc/statlag
	src.verbs -= /client/proc/play_sound
	src.verbs -= /obj/admins/proc/spawn_atom
	src.verbs -= /client/proc/jumptomob
	src.verbs -= /client/proc/Jump
	src.verbs -= /client/proc/Unactivate_Server
	src.verbs -= /client/proc/Crazy
	src.verbs -= /client/proc/Toggle_Rewards
	src.verbs -= /client/proc/Wipe_Rewards
	src.verbs -= /client/proc/jumptoturf
	src.verbs -= /client/proc/jumptokey
	src.verbs -= /client/proc/Getmob
	src.verbs -= /obj/admins/proc/ShowDonate
	src.verbs -= /client/proc/sendmob
	src.verbs -= /client/proc/Make_Legendary_Saiyan
	src.verbs -= /client/proc/Destroy_Regenerators
	src.verbs -= /client/proc/RNG
	src.verbs -= /client/proc/Grant_Super_Tuffle
	src.verbs -= /client/proc/Respawn_Resources
	src.verbs -= /client/proc/Toggle_Global_Reincarnations
	src.verbs -= /client/proc/Toggle_Global_Rares
	src.verbs -= /client/proc/Set_Dead_Time
	src.verbs -= /client/proc/Grant_Alien_Trans
	src.verbs -= /client/proc/Enlarge
	src.verbs -= /client/proc/sendToSpawn
	src.verbs -= /client/proc/Reset_Rare_Rolls
	src.verbs -= /obj/admins/proc/Create_Object_Menu
	src.verbs -= /obj/admins/proc/Give_Object_Menu
	//src.verbs -= /client/proc/Give
	src.verbs -= /client/proc/InactiveBoot
	src.verbs -= /client/proc/Kill
	src.verbs -= /client/proc/Knockout
	src.verbs -= /client/proc/Set_Rewards
	src.verbs -= /client/proc/WipeWorld
	src.verbs -= /client/proc/WipeMap
	src.verbs -= /client/proc/Hubtext
	src.verbs -= /client/proc/Rename
	src.verbs -= /obj/admins/proc/announce
	src.verbs -= /obj/admins/proc/Assign_Rank
	src.verbs -= /obj/admins/proc/immreboot
	src.verbs -= /client/proc/cmd_admin_subtle_message
	src.verbs -= /client/proc/warn
	src.verbs -= /obj/admins/proc/narrate
	src.verbs -= /obj/admins/proc/Edit
	src.verbs -= /client/proc/Year_Speed
	src.verbs -= /client/proc/Assess
	src.verbs -= /client/proc/Assess_All
	src.verbs -= /client/proc/ForceSSJ
	src.verbs -= /client/proc/Set_Spawns
	src.verbs -= /client/proc/Heal
	src.verbs -= /client/proc/Heal_Injury
	src.verbs -= /client/proc/Revive
	src.verbs -= /client/proc/Gains
	src.verbs -= /client/proc/Delete
	src.verbs -= /client/proc/Delete_Player_save
	src.verbs -= /client/proc/Wipe_Admin_Logs
	src.verbs -= /client/proc/Int_Gain
	src.verbs -= /client/proc/zCharacter
	src.verbs -= /client/proc/Reward
	src.verbs -= /client/proc/Purge_Large_Icons
	src.verbs -= /obj/admins/proc/check_log
	src.verbs -= /client/proc/editStory
	src.verbs -= /client/proc/editRules
	src.verbs -= /client/proc/editRanks
	src.verbs -= /client/proc/editJobs
	src.verbs -= /client/proc/EditLoginNotes
	src.verbs -= typesof(/mob/Admin1/verb)
	src.verbs -= /client/proc/updateFile
	src.verbs -= /client/proc/Give_Rank
	src.verbs -= /client/proc/StatRanks
	src.verbs -= /client/proc/Sort_Rewards
	src.verbs -= /obj/admins/proc/check_world_logs
	src.verbs -= /client/proc/View_Report
	src.verbs -= /client/proc/Delete_Report
	src.verbs -= typesof(/mob/Admin2/verb)
	src.verbs -= /client/proc/returnmob
	src.verbs -= /client/proc/Fix
	src.verbs -= /mob/admin/verb/viewerrors
	src.verbs -= /obj/admins/proc/toggleooc
	src.verbs -= /client/proc/adminOverlays
	src.verbs -= /client/proc/EditNotes
	src.verbs -= /obj/admins/proc/NPCs
	src.verbs -= /client/proc/Show_Notes
	src.verbs -= /client/proc/Clear_Treasure
	src.verbs -= /obj/admins/proc/Saveserver
	src.verbs -= /client/proc/allow_rares
	src.verbs -= typesof(/mob/Admin4/verb)
	src.verbs -= typesof(/mob/Debug/verb)
	src.verbs -= typesof(/mob/Admin3/verb)
	src.verbs -= /client/proc/listen_admin_logins
	src.verbs -= /obj/admins/proc/Narrate_World
	src.verbs -= /client/proc/Destroy_Gravity
	src.verbs -= /client/proc/Show_Rewards_Tab
	src.verbs += /client/proc/Show_Ranks_Tab
	if(src.holder)
		src.holder.level = 0