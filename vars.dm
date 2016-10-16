



mob/var/tmp
	// tmp vars
	move=1
	Spell_CD = 0
	BuildOpen = 0
	BuildTab = "Roofs"
	TestChar=null // TestChar variable, used for looping the Status() proc on mobs with no clients.
					// Its specific use is stress testing.

	lastKnownIP
	computer_id
	lastKnownKey
	Logged_Out_Body
	adminObserve

	KB	//Knockback
	mob/GrabbedMob
	isGrabbing
	grabberSTR
	metafied
	WishPower=0
	attacking
	Beam_Refire_Delay_Active
	mob/Opp         // Leeching STATS
	mob/SkillsOpp   // Leeching SKILLS
	sim=0
	Went_Afk = 0
	TK_Last = null
	Delete = null
	Crazy = 0
	Born = 0

	Redoing_Stats
	Points=10
	Max_Points=10

	obj/Ships/S=null
	Can_Blast=1
	Total_Stats_Energy = 0
	Total_Stats_Strength = 0
	Total_Stats_Endurance = 0
	Total_Stats_Speed = 0
	Total_Stats_Force = 0
	Total_Stats_Res = 0
	Total_Stats_Off = 0
	Total_Stats_Def = 0
	Total_Stats_Regen = 0
	Total_Stats_Recov = 0

	// list/techlist = new

	adminDensity=0 // Admin density, allows admins to pass through walls and such unscathed

	shadspar // variable to determine if a player is shadow sparring
	list/shadows = new // keeps track of the shadows created, easier to get rid of them should they somehow create multiple

	immortal = 0 // temporary var that disables death checks on the mob, it's for a system to check if we can prevent people from dying multiple times from one attack

	training_id // id to make sure the scheduled event belongs to the current action. we dont want it saved so its a tmp
/* To elaborate, every time somebody meditates/trains/digs a new event is thrown into the timer.
 * Now, this event is simply recycled, consider it a fancy loop.
 * What spamming the train/dig/meditate macro is meant to do (when they want to abuse it) is start multiples
 * of this loop so that they gain, much, much more than they are supposed to.
 * The training_id ensures that whatever other loops they attempted to schedule are killed before they're actually
 * giving any stats to the player.

 * training_id is used for digging, meditate and training because they cannot use either of these at the same time anyway
 * so there is no reason to use a unique id for these events.
*/


mob/var

/* General Stats */

	HasCreated=0 // Prevent people from stacking statpoints to increase their mods.
	afk=0
	Race="Undefined"  //Was nothing  null.var bug
	RaceDescription="Undefined Race Desc"  //Was nothing  null.var bug
	Class="Undefined Class"  //Was nothing  null.var bug
	BP_Multiplier=1
	BP=1
	Base=1
	Body=1
	Ki=1
	MaxKi=1
	Pow=1
	Str=1
	Spd=1
	End=1
	Res=1
	Off=1
	Def=1
	GravMastered=1
	GravMulti = 1
	Anger=100
	MaxAnger=120
	BPMod=1
	KiMod=1
	PowMod=1
	StrMod=1
	SpdMod=1
	EndMod=1
	ResMod=1
	OffMod=1
	DefMod=1
	Regeneration=1
	Recovery=1
	GravMod=1
	Zenkai=1
	MedMod=1

	BaseMaxAnger=120
	BaseBPMod=1
	BaseKiMod=1
	BasePowMod=1
	BaseStrMod=1
	BaseSpdMod=1
	BaseEndMod=1
	BaseResMod=1
	BaseOffMod=1
	BaseDefMod=1
	BaseRegeneration=1
	BaseRecovery=1
	BaseGravMod=1
	BaseZenkai=1
	BaseMedMod=1
	BaseDecline = 30
	BaseMagic_Potential = 1
	BaseAdd = 1
	BaseInclineSpeed = 1
	BaseInclineAge = 1

	Age=0
	Real_Age=0
	Immortal=0
	InclineAge=18
	InclineSpeed=1
	Decline=30
	Tech=1
	TrainingDeactivatedTime=0
	TrainingDeactivated=0
	ProcOn=0
	TimerOn=0
	Moon_Used = 0
	TK_Magic = 0
	TK = 0
	Kills = 0
	Spell_Power = 0
	Spell_Cost = 0
	Signature_True = 0
	RP_Points = 0
	RP_Last
	RP_Length = 0
	RPs = 0
	RP_Actual = null
	Wings = 1
	show_rewards = 1
	show_ranks = 1
	Skills_Max = 3
	Skills_Current = 0
	Blindness = null
	x_view = 15
	y_view = 15
	Alien_Grav_Set = 0
	Destroy_Walls = 0
	NoLoss = 0
	operatingSystem = null
	Boost = 0
	Alignment = 0
	AlignmentTxt = "Neutral"

/* Transformation variables
We could try moving over to variables such as the ones below at some point.
It allows easier tweaking of transformations without possibly permanently damaging a character.


	BP_add=0
	Ki_add=0
	MaxKi_add=0
	Pow_add=0
	Str_add=0
	Spd_add=0
	End_add=0
	Res_add=0
	Off_add=0
	Def_add=0
	Base_add=0
	BPMod_add=0
	KiMod_add=0
	PowMod_add=0
	StrMod_add=0
	SpdMod_add=0
	EndMod_add=0
	ResMod_add=0
	OffMod_add=0
	DefMod_add=0
	Regeneration_add=0
	Recovery_add=0

*/

/* Variables required for UnTeleport and ReturnMob */

	unSummonX=1
	unSummonY=1
	unSummonZ=1

/* Unsorted as of yet */

	datum/mind/mind
	real_name

	undelayed
	ViewX=15
	ViewY=15
	Decimals=0
	TextColor="red"
	TextSize=2
	seetelepathy=1

	hair

	HairColor
	BPpcnt=100
	//gain=0
	attackable=1
	Money=0
	Bank=0
	Lungs=0
	Logins=1
	MakyoPower=0
	Artificial_Power=0
	FormPower=0
	SSjPower=0
	Roid_Power=0
	Overdrive_Power=0
	Sense_Mod=1
	RP_Power=1
	oicon=" "
	Warp=1
	FusionLearnable=0  //Was nothing  null.var bug
	PiercerLearnable=0  //Was nothing  null.var bug
	ExpandLearnable=0  //Was nothing  null.var bug
	FocusLearnable=0  //Was nothing  null.var bug
	PowerBallLearnable=0 //Was nothing  null.var bug
	SDLearnable=0 //Was nothing  null.var bug
	ImitateLearnable=0 //Was nothing  null.var bug
	Super_Tsufu_Learnable=0 //Was nothing  null.var bug
	Super_Tsufu_Learned=0 //Was nothing  null.var bug
	Ancient_Progenitor = 0

	Regenerate=0 //Like Majin and Bios regenerate instead of dying
	Regenerating

mob/var
	Refire=20
	Dead=0
	Died = 0
	ReincCall=0
	Life=100
	Anger_Restoration
	//Last_Anger=0 //So you can't get angry again til enough time passes

/* Human */

mob/var
	geteye //when you actually get the ability
	thirdeye

mob/var
/* Saiyan variables */

	ussjhair
	ssjfphair
	ssjhair
	ssj = 0
	ssjanger = 0

	ssjmult=3
	ssjdrain=100
	ssjmod=1

	ssj2hair
	ssj2mult=3
	ssj2drain=75
	ssj2mod=1

	ssj3hair
	ssj3mult=3
	ssj3drain=50
	ssj3mod=1

	ssj4hair
	ssj4mult=3
	tmp/transing
	SSj4Aura='Aura SSj4.dmi'

/* Bio android variables */
	cell2at=10000000
	cell2=0
	cell2mult=3
	cell3at=40000000
	cell3=0
	cell3mult=2
	cell4=0
	cell4mult=1.5 //this is the only temp form, others are perm.
	cell4drain=200

/* Changeling variables */
	Form=0

	Form2At   = 10000
	Form2Add  = 0
	Form2Mult = 3

	Form3At   = 600000
	Form3Add  = 0
	Form3Mult = 4

	Form4At   = 4500000
	Form4Add  = 0
	Form4Mult = 5

	Form1Icon
	Form2Icon
	Form3Icon
	Form4Icon
	Form5Icon //For body expand levels
	Form6Icon
	Form7Icon
	Form8Icon

	Enlarged
	Frozen

/* Time Freeze */

	Time_Frozen

	Aura='Aura.dmi'
	FlightAura='Aura Fly.dmi'
	BlastCharge='Charge1.dmi'
	Burst='Burst.dmi'

	Modules=0
	Blast_Absorb=0
	Cyber_Absorb
	Scanner
	Vampire
	Vampire_Immune = 0
	Void_Power=0
	Shadow_Power=0
	Cosmic_Power=0
	Temperature

	Counterpart

	forbidMovement

mob/var
	Zanzoken=1
	ZanzoMod=1
	tmp/Using_Explosion
	Build=1
	BebiAbsorber
	Nfuse=0
	RP_Earned = 0
	RP_Total = 0
	RP_Rested = 0 //How much rested rp points from being afk.
	Oozaru_Mastery = 0
	AS_Droid = 0 //Is this player a Android ship android?

mob/var
	fusee1
	fusee2
	fusee3
	fusee4

mob/var
	ismajin
	ismystic
	Precognition //for the blast avoidance...

mob/var
	UP
	Potential=1

mob/var
	FlySkill=1
	FlyMod=1
	Super_Fly
	ITMod=1
	Absorb=0
	Absorb_Max = 0
	Semiperfect_Form
	Perfect_Form
	Fruits=1
	KeepsBody //If this is 1 you keep your body when Dead.
	GavePower

	Injury_Left_Arm = 0
	Injury_Left_Leg = 0
	Injury_Right_Leg = 0
	Injury_Right_Arm = 0
	Injury_Head = 0
	Injury_Sight = 0
	Injury_Throat = 0
	Injury_Torso = 0
	Injury_Hearing = 0
	Injury_Mate = 0
	Injury_Tail = 0
	Spar = 1
	Critical_Left_Arm = 0
	Critical_Left_Leg = 0
	Critical_Right_Leg = 0
	Critical_Right_Arm = 0
	Critical_Head = 0
	Critical_Sight = 0
	Critical_Throat = 0
	Critical_Torso = 0
	Critical_Hearing = 0
	Critical_Mate = 0
	Critical_Tail = 0

mob/var
	Conjured=0
	Conjurer=""
	ConjureX=1
	ConjureY=1
	ConjureZ=1
	ConjuredKey

	Clothes
	list/Overlays=new
	Tail
	Power_Leech_On=1
	Skill_Leech_On=0


	Flyer
	Asexual
	Offspring
	Sterile
	HBTC_Enters=0

mob/var
	Kaioken=1
	KaiokenMod=1
	KaiokenBP=0
	Senzu
	Immunity=0
	Poisoned=0


	Hair_Base
	Hair_Age=1
	BirthYear=0
	DeclineMod=1
	LogYear=0 //The last year you logged out

	Majin_By = null //For majin to check who gave them it.

mob/var
	pfocus="Balanced"
	sfocus="Balanced"
	mfocus="Balanced"
	ifocus
	magicfocus
	Int_Level=1
	Int_XP=0
	Int_Next=1000

	Magic_Level=1
	Magic_XP=0
	Magic_Next=1000
	Magic_Potential = 1

	Gain_Multiplier=1
	XPGained=1

	P_BagG=2
	Zenkai_Power=0

	TechTab
	Tabs
	StatRank=1
	BPRank=1
	XPRank=1
	list/Minimum_Stats=new

	medreward // Variable to allow an admin to reward and raise their levels WITHOUT forcing the player to meditate
	medrewardmagic

mob/var
	GotBebi=0
	BebiX=0
	BebiY=0
	BebiZ=0
	savingContacts=0
	Contacts = list()

/* CLONING TANK related */

mob/var
	insideTank
	insidePhylactery
	Phylactery = 0

/* END CLONING TANK related */

mob/var  //Defines default hostility/friendliness of NPC's to PC's, and NPC's to NPC's of other races.  Can be used to model racial hatred, flag for hostility for a period of time, and more.  Will be used in the intelligent NPC system.
//Can also change the dynamic of randomized dungeons.  An android, for instance, could march into a laboratory filled with ancient machines, and not be bothered by them.
	CelestialFriendly=1  //0 for Demons and associated NPCs
	DemonHostile=1  //0 for Celestials and associated NPCs
	HumanFriendly=1
	CopFriendly=1  //This gets set to 0 for a period of time if a player does something in view range of a cop, trooper, or other NPC governmental enforcers in Haven, Tarania, the Beastman city, or any other civilized area.
	EarthenFriendly=1
	HorrorHostile=1  //
	UndeadFriendly=0 //1 if undead
	MachineFriendly=0 //1 if bio android, or android
	UCPNHostile=1  //Purist human faction made up of the former nations of Earth.  Hostile towards pretty much all the races, including playable Humans.  Have no ki/energy/whatever, as they lack the mutations that playable humans have, but sport copious amounts of high end old world tech, and have been developing it since the Fall, centuries ago.  Should be used in scripted/admin events only after the tech/combat revamp for the time being, as their main base of operations is located off-world, and to preserve a sense of mystery about them.  End-game threat.
	TaranianFriendly=1 //0 For beastmen and beastmen NPCs
	BeastmenFriendly=1 //0 for Taranians and beastmen NPCs

// Swimming related

	isSwimming = 0
	swimSkill = 100
