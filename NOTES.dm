
/*mob/verb/Power_Leech_Toggle()
	set category="Other"
	Power_Leech_On=!Power_Leech_On
	if(Power_Leech_On) src<<"People can now leech your power by sparring you (skill leeching has a different verb)."
	else src<<"People can no longer leech your power by sparring you (skill leeching has a different verb)."
	usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] turned power leeching [Power_Leech_On ? "Off" : "On"].\n")
*/
mob/verb/Skill_Leech_Toggle()
	set category="Other"
	Skill_Leech_On=!Skill_Leech_On
	if(Skill_Leech_On) src<<"People can now leech your skills by watching you."
	else src<<"People can no longer leech your skills by watching you."
	usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] turned skill leeching [Skill_Leech_On ? "Off" : "On"].\n")


var/global/Ki_Power=0.2 //This is a multiplier of the overall damage of all ki attacks to balance them out.

#define DEBUG

/*
-Please make Gohan halfie rare like others. E.G % chance when a human mates a saiyan. only one per server.
(10%??)
-Edit to bombs? all players within range of the potential blast recieve a message 10 seconds from detonation.
you feel a rumble underfoot.
-Ray is essentially Frieza's death beam. It was a quick bursted beam. Like, a 3 tile long beam, fired like a blast would be, I think.: But have it drain energy a lot
 No ability to charge it. Very quick (Hard to dodge) and nice damage, but can't charge it and it has high drain.


-Revive removes some decline based on RNG, with a fixed minimum and maximum per use.
also a 5% chance of instant death.
-Add "Magical pads" (not watches.) which unlock at 250 magical skill, and a 10% chance of death. (lemme know if need ideas what to model it off ICly.)
-demon lord can make only 1 amulet , maybe HA can reset that count incase it is lost or whatevs.
-Uniform naming, Funimation Dub (I can provide list upon request.)
-a verb which displays majin/mystic individuals - for majin something to show if self learned/given
-unlock SSJ global button?
-modules potentially buggy (from mr.capricorn.)
-may we be able to send a message with observe? it could prompt us when we select our target? can we see their emotes and says please. (for rank observe not crystal ball.)

-Races have a RANGE of random mods, which you can influence by putting in points, eg putting 5 pooints in strength raises the chances to roll a high str mod, but at the same time luck may give u a high force mod. (maybe)
-when races mate, the system takes the mods of each parent, adds it together and divides it by 2, then REROLL using rng.
-The child then has  amixture of mods, as well as an aesthetic difference, eg a  half namek half saiyan has a tale, but is pale green. Also racial techniques that u can learn on ur own are impossible below 50% racial mix,
if you're 75%, (Eg third gen 3/4 saiyan.) you can then learn saiyan moves naturally. Otherwise someone that DOES know racial techniques within your bloodline,
(say that 3/4 saiyan is 1/4 demon) then a demon should be able to teach you demon techiniques.
[11:51:06] Jack/the real lockem shoto: I say positive mutations.
[11:51:16] Jack/the real lockem shoto: Like hard bones, more muscle mass etc.
[11:51:23] Jack/the real lockem shoto: whilst hybrids can have like, melanoma or summin

That reminds me. another thing you may want to factor in when building the genetics system, is that i'd like to take away 100%
character building from the player, and add some luck, chance and such.





Here's a few things planned for future updates in the next few months or so. I'll be working on balance still, as always, and bugs, but beside that.
I want to add stances, an injury verb and system, ability to create majins with magic and bios with tech.
Probably a throw verb and drag verb, so you can smack someone into a wall and watch their limbs explode off - ok,
 maybe not that dramatic, lol. I'm also wanting to work on power armour again,
 make it alot cheaper and strip it of boosts and have them added as upgrades.
 Just to name but a few cool little additions I've got in mind. I'm also going to work on ki swords/blades for magic and a
 magical version of the recyler that's basically a mini black hole/vortex, imagine the fun. Oh, and unlike Arch's feature-list spam,
 we can probably expect to see this sometime soonish, hehehe. Anyway, I'm off to write down a little list.

Add it so that there's a lethal toggle and if you're koed and someone has theirs on, your regen is debuffed so you can;t just leap right into battle so easyily.


[20:54:50] Medic: But the jobs page
[20:54:53] Medic: keeps erasing itself







Add FBM

Holograms, technological split forms basically

Surveilence cameras that alert you when someone is in the vicinity

Make Finale have less dust and make Clean get rid of dust

A package that brings you to the average bp of your race

redo stats doest re-adjust stats to their new proportionate values

unascended majin package is starting ascended

People must wait 1 game year before they can leave final realm.

Decay: (First glitch is Shield + absorb = Infinite shield (If getting ki blasted on.)

Music verb seems to think every file exceeds maximum allowed size

A skill where you can place down a object anywhere you have been and you can then teleport back to it at
will, up to 10 of them or so. If someone builds there it disappears and you cannot place it in someone's
house.

Precognition drains energy?

Sell Saiyan Elites as a package, perhaps combined with some other package such as Bio-Android?

So...With like 50 mil resources and some int, you get the ability to make a bebi, which can swap into a
very similar copy of a person's body with similar skills (but a few drawbacks), while that person
is stuck in a dead-zone-like place til that bebi either logs out or leaves the body?

Fix communicators

All levels of expand should not be available from the start, you should get new levels by staying in expand,
each new level of expand should be as close to possible as an equal trade off. The effects of expand will
likely need rethought.

Airplanes which are just ships without a launch verb

Make it so alliance members must be voted in on a 3 vote

Re-add super flight trails

Aliens default stats should possibly start at 0.5 and they get more points and also BP Mod would be made
customizeable using the points.

Give android's more icon appearances including Human. Make that and Demon icon choices use the tab based
system so you can see what it looks like before you get it. Also Alien icons need to be made to that system.

Hacking consoles can be used to make walls fly over able

Make Android Planet not suck so bad.

A way to see the stats of rare races to decide if you want them or not, even if you are unable to pick them.

Walls should be weaker. Almost any super being should be able to get through a wall if they really want to.
The main way of protecting your things should be bolting, and only if someone has a hacking console of a
higher level can they unbolt it. Also turrets and such to attack intruders would compliment these new ways
of protecting your base. Many security systems would be great.

Add Coded Elite to the Unascended Rares thing. Also perhaps throw Makyojin in there.

Package rename should be logged

Auto-pilot for ships that have been to a planet before.

In the Final Realm there should be an Alter of Reincarnation. You keep everything you have except BP and
perhaps skills and items.

Ability to convert a nuke into a missile

Level 80 or so technology called T Purification which can remove certain T Effects from your character.

Androids have no recovery and must absorb energy from other beings.

LSD makes monsters appear near you that only you can see
and your screen flashes a scary image and you hear a scream

Make ship consoles save the last location of a destroyed ship and do a loop to check for mobs who log in
to that ship later so the console will send them to the destroyed ship's last location.

Gun that shoots a small streaming laser.

Seperate the effects of T Vitality and T Strength to give individual stats instead of both that way there
can be more zombie types and choices of what to take

Scientists can make weights and materialize can make armor.

Let aliens choose the planet they want

Hacking Consoles should be able to hack Teleporter pads as well as other things.

Give Kaioken a cap of x10 base or something.

Poison dispensers that can be mounted on walls and programmed to emit poison that stuns or kills, space
masks protect against it. They spew gas that fills up rooms the same way nukes spew fire in a way. Perhaps
there is a small chance it will ruin the face mask and get you anyway, during cases of long exposure.

Pimp out space with black holes and suns and shit

Turrets

Taming NPCs to use as a type of splitform pet

A Defend verb that doubles defense but makes it so you can't attack back.

Add shockwave back in.

Make explosion objects show smoke.dmi after they go away

Kami Tower can float around earth

Sell unascended rares.

Namekian Regeneration skill again? Also choosable for Aliens.

An onscreen marker signifying whether you have explosion or zanzoken activated.

Bounty hunting thing where you have multiple flying cameras that fly around the planet looking for
whatever target you need to find and alerts you of their location. Also it could trick them by
projecting an image of their friend and pretending to lead them somewhere or give them something,
but its a trick.

Remote door opener that opens doors within range.

A Blaster type weapon, that shoots a continuous beam of energy, unchargeable, very draining, but
you can move around with it

Jetpacks.
Guns.
Turrets.

Might Tree seeds.

Buster Barrage style attack again

Combine all clothes under the Clothes branch, and make all their equip verbs into 1 verb. Then
Clothes() can be redone to be much simpler and automatically include new clothing additions.

Fountain of youth that slows decline rate to like 0.1 so you'll still age and be old but it'll be
so slow you dont even notice and you live like 400 more years like roshi

Another technology could be a jetpack, which gives you the equivalent of the flight verb. It has
its own battery and such, might be a bit slow, depends. But it would work well in conjuction with
the power suit.

A power suit technology. It has a static amount of BP that it adds, which is upgradeable. Then it
rearranges stats somewhat. Like x1.5 strength and x3 endurance, and x0.5 regeneration and recovery.
Give SSX one when he starts out as well so he can make it look like Iron Man.

The suit has different modes, such as:

Balanced Mode
	x1.5 Strength
	x1.5 Endurance
	x0.5 Regeneration
	x0.5 Recovery
	x0.5 Defense

Tank Mode
	x2 Strength
	x3 Endurance
	x0.75 Speed
	x0.5 Regeneration
	x0.5 Recovery
	x0.5 Defense

Damage Mode
	x4 Strength
	x0.5 Regeneration
	x0.5 Recovery
	x0.5 Defense

Speed Mode
	x1.5 Speed
	x0.5 Recovery
	x0.7 Defense

Force Fields should protect from self destruct and bombs. Same for Shields. And the Cosmic Attacks
must be blockable by shield and force field.

Prehistoric Saiyan, choosable from year 0 to 20. Loses heightened regeneration and recovery, but
has increased brute strength and endurance.

MSN of the guy who stole the source supposedly: shindaallnighter@hotmail.com

Candy Ray for Majins, turns anyone less than half your power or something into candy and absorbs
them automatically. If you use it on someone and it fails your energy is lowered to 0

A "magic" move that lets you go to the checkpoint whenever you want, then return to the spot you
left off at in the living world whenever you want. More magic style abilities as well. Magic could
be like, instead of directly manifesting ki, instead it is used to manipulate physical objects
instead by using ki. And physical objects obviously are no match for direct energy, but they can
be used for unique purposes.

Saibaman seeds that grant you a pet saibaman, which is just a splitform under your control.
Also other things, like Turtles, Cats, etc. And they increase in power based on YOUR experience.
The animal parents actually lay the eggs at certain times, and you can then get them.

1/8th Saiyans. Resemble low class in every way. But has no super saiyan forms period. Final mod is
about the same as a SSj2 Low Class, 250 or so.

Make Legendaries damage walls when they hit them again or something.

Alien 11.dmi is actually an android. A spider android. So use it for them.

Custom overlays verb for package 1. With pixel displacement settings.

Wolf Fang Fist

Fix hover chairs

Kienzan, Shockwave

Collission for skills like Sokidan, Genki Dama, etc, needs fixed up or something.

Certain cyberizations of an organic being will disable the usage of certain skills, such as
Expand, therefore Cyborg Frieza for instance could no longer use Expand

DB Multiverse

Make it so the beam proc is called from the blast's movement proc instead. Or whatever.

Explosive fireballs from bomb explosions

Make it so there is a difference between inside and outside turfs. Outside ones have weather.
Turfs that are of the Inside type, will have a 50 or so year lifespan, before eroding back to
natural turf. This will help get rid of buildings nobody uses anymore.

Flying zombies that remain undense until a player is within 2 tiles of them.

Upgrading verbs for almost everything should be redone, so you can just put how much to upgrade it
instead of having to click it so many times over and over

Astral Projection skill

Big Bang Attack

Fix Hover Chairs

An upgradeable thing that will tell you the password's of stuff, as long as its upgraded beyond
the tech level of the object it is attempting to retrieve the password from.

Give ships a settings verb, for laser blasting style.

Some sort of flying zombie mutation

Get some tech ideas from Justice League perhaps.

The creator of dragon balls should be able to put a secret word and you can only use them if you
know the secret word.

Put a thing that lets us strip offline admins.

Cloaking tower, that once activated, creates a field so that anything that was in it once the field
was activated, becomes invisible.

Turrets that attack people not wearing a badge with a certain code on it

Make Kikoho 3 tiles wide.

Finish the Super Saiyan effects

Can materialize swords

A verb that lets you check all admins, even offline admins

Consider letting scientists make weights

New choices of "skills" for aliens.

Shield lets you survive in space

A tower that prevents ships from launching or something.

Make some tech that allows you to build a portal to summon michael jackson and he starts dancing
and all the zombies head's explode on the planet or area.

Androids should not be able to be sensed when cybernetics is in.

Nanovirus to be used on Cybernetic beings later on.

Personal cloaking to make yourself invisible, through technology.

Get more zombie icons so scientists can mutate zombies by doing certain things to give them different
stats and appearances. Injecting zombies with steroids and higher levels of T Virus would cause
them to change.

Androids have learning-capable brains that allow them to develop offense and defense in battle.

When androids die they leave behind parts or resources or something.

Add the shenlong icon

Edges are currently unbuildable. But they should be buildable later, we just have to fix the bug
with "edge jumping" or whatever. Basically just redo the entire edge detection code.

*New Energy Abilities*
Falcon PUNCH!!!
New Beams maybe
Rasengan
Chidori
Force Lightning
Force Push
Ki Saber
Whirlwind
Double Charge, by pressing charge again while charging it

Shurikens should be like swords as well, based on the thrower's strength perhaps, but MAYBE based on
how much resources you put in

Ship controls that summon ships from anywhere

multi-purpose robots with many installable programs, from combat, to mining, to whatever...

Saibaman seeds as bio-tech

Technological weapons should be fairly effective to unascended beings...Atleast to a good degree.
It should be easier to develop tech weapons to be strong than it is to train yourself to be stronger.

Mining explosive, explodes leaving random amounts of resources

Auto pilot upgrade for ships that enables them to visit planets already navigated to

Object Detectors, as tech. Customize it to detect a certain type of object in range. Also as a defense,
include cloaking towers, that render anything in range of it not detectable by Detectors.

Blasters and Clone Machines again

Visors to see ever-increasing levels of invisible objects. For instance cloaked ships.

When the might tree is in, it should absorb a planet's resources, and produce fruits that increase
your absorbed power.

When tech is destroyed resources are dropped.

Add Spirit Bomb

A creatable item could be a tower that drains the energy out of all other technology on the planet, to
keep people in the stone age while giving it to the person who created it

When digging, make a small chance to find Cell's schematics, that is how bio androids will be unlocked

Very few, if any technological devices should last forever. If not repaired or whatever, I think the
average lifespan of technology may be 100 years.

Ways to alter the planets climate. Perhaps one day, technology to CONTROL climate.

EMP to disrupt electronics that arent protected against it

Scientists can make Robots that have a few modes, like Assassinate which lets you select
a person who will be killed if encountered, and Destroy which lets you choose any type of
object which will be destroyed if encountered. And money hunting mode, which the robot kills NPCs
and bounty hunting robots

Bombs, from crappy grenades to nuclear bombs and missiles. Also missile defense systems
of varying ingenuity. When a Nuke goes off it sends radiation smog everywhere, replacing
certain turfs with shitty Dead turfs and giving people radiation poisoning and such, only
really strong security walls could keep the radiation out. The radiation could also
mutate you and stuff. Also some negative radiation effects such as limited healing and
energy recovery, limited power, slowed movement, bad eyesite somehow, random blackouts,
they would never go away but multiple supernatural kaio or namek healings could get rid
of them and it also gives a reason for medical facilities.

*Advanced Mechanical Modules* Take up 10% organic body
Advanced Energy Reactor
Armor Skin +1000 endurance
Force Field Skin +1000 Health
Energy Accelerator Module +1000 force
BP Sensor (only difference is that it scans higher and takes less space
Ranged BP Sensor (Like Planet Sense)
Hacking Module
Hyper Module +1000 speed
Finger Laser (fires in stantly, moves fast)
Hand Laser (more powerful, Refire is slower, moves a little slower)
Force Blast (most powerful, fast, Refire very slow, somewhat high energy drain, explosive)
Sustainable Laser (Kind of like a robotic beam, cant beam struggle, and isnt powerful,
				(cant be charged but it can be held before attacking, and it moves pretty fast)
Overdrive Module x1.5 BP for a time period but then it wears off and halves energy.
Energy Absorbtion Module converts Biological energy into usable Mechanical energy.
Blast Absorbtion Module, can absorb actual blasts that hit you from the front
Advanced Repair Module (heals "armor" on its own slowly)
Advanced Energy Module (recovers energy very slowly on its own)

*Nano Mechanical Modules* Take up 5% organic body
Nano Physical Enhancement +1000 speed, strength, endurance
Nano Energy Enhancement +1000 force and Health and max ki perhaps
Nano Combat Enhancement +1000 offense and defense and +10 ki manip
Health Absorbtion to refill health faster

When you learn Genetic Cyborg or whatever, you can take a KO'd person's "Blood" or whatever
and clone their body and be able to swap into it, and you can trade their stats for other
stats and stuff. Then after that they could install nano cyborg features and whatever. The
copy would have weaknesses though, the gain, Zanzoken, kaiokenskill, and vars such as
that would instead be reset to whatever the copiers abilities with that skill are. Same
for Super Saiyan, the ssjdrain var shall be halved, as well as the SSj mods, and only SSj1
will be available even if the person cloned had SSj2 or beyond, and SSj1 wouldnt be
available unless that person had it mastered or had SSj2 or beyond.

Scientists can invent capsules to contain things that normally cant be picked up

As a scientist you can create seeds that grow fruits and people can eat the fruits and stuff.

You can place turrets in space near planets to prevent entrees or escapes.

When a bounty is cast I guess my only option is to do it from the PDA thing, you can put
it out globally that you need a bounty hunter, one will contact you, a price will be arranged.
The conditions for the bounty will be either that they are killed, or that they are sent to a
jail, if the person hires the bounty hunter then that hunter is added to a list of other bounty
hunters they have employed, then once they kill a bounty head or send one to a jail, then that
is checked with the employer's pda, if that person was on the employer's bounty list, then the
bounty becomes fulfilled and the money is transferred.

Need to think of some way to make bounty hunting an important part to the game, some more
incentives to make it a necessity or something. Right now all they get is:
Money
Ability to pay scientists with that money for cool stuff and upgrades.

Anyone can apply a bounty to anyone. And they can apply conditions to the bounty, like killing
them to collect it or bringing them to a certain range(0,src)ation to collect. Of course if its
bringing them to a certain range(0,src)ation, then its probably a jail, so an item called an energy
disrupter should be placed somewhere to keep people from using teleport or shunkan ido to get
to that location or away from that location. The stronger than are the less effect the disrupter
will have on them unless it is further upgraded. The stats of a disrupter are strength,
durability, range, and battery

When you conquer the space station itll be like a starship in a way, you can make it go
to coordinates and stuff, and you can disallow entrance by certain races maybe, or disallow
entrance in general.

**Detailed Cyborg Specifications**
*Body Parts that can be replaced between 1% and 100%*
*Unless the part works with biological functions, ki and Health regen will slow, because mech
parts cannot be naturally healed under most circumstances, so the mech parts will need their
own healing mechanisms or some other way to repair themselves, such as a repair tank or
something in a laboratory.
*** Installable Features ***
Each one of these adds a certain mechanical function, and deducts a certain biological function
Also for the 4 classes it determines the upgradeability of the installed features, like
if you have the Standard Mechanical (Class 1) Sensor, and you upgrade scan speed, scan speed
increases by the class, so if its standard, speed gets +1, if its advanced, its +2, if its
nano, then +3, if its Bio then it cannot be upgraded.

Sensor1
	Detects BP.
	Deducts Max Energy
	Upgrades: Max Scan. Scan Speed. Accuracy. Detects all BPs on the planet
Interface System
	Hack into pods and doors. Upgrades: Encryption level. Hack Speed.
Artificial Eyes
	see_invisible increases, gives a defense boost perhaps since you can see
	icoming attacks better and stuff.
Overclock
	You can go beyond 100% power but take some damage for it over time.
Nano Repair
	Repairs mech parts, it comes in Passive and Active repair, if you have the
	less advanced Active Repair you have to actually be meditating to repair your damage,
	Passive repairs you no matter what you are doing. This repairs the health of your parts.
Energy Reactor
	The max of this can be expanded, but also the method of how energy is
	refilled can be changed, first it doesnt refill at all unless the scientist builds a
	cyborg tank, which can repair different features. Then later cores can absorb bio energy
	from people. Then later they can refill themselves with nanites or whatever.
Absorbtion
	This can be made to absorb different biological energies. From health,
	to energy (mostly), and in different ways, first you can only absorb from KO'd people,
	then you can absorb blasts, then you can absorb just from grabbing someone, and so forth
	also you can increase absorbed BP with further upgrades too, health, energy, power. You
	can also upgrade how much you absorb per second, and your core determines the max you
	can handle, and if you go past 100% energy you begin taking damage.

**Artillery**
*Standard Mechanical - Class 1*
Missile 5% - Strong chest missile
Homing Missile 5% - Weaker but homing chest missile, slow moving
Machine Gun Arm 5% - Fast firing machine gun rounds
*Advanced Mechanical - Class 2*
Missile Barrage - 5 fast moving homing missiles fire out from the chest
Rocket Hand - Fires a fast moving knockback hand at someone which is slightly homing.

**Lasers**
*Standard Class 1*
Laser Arm 5% - medium speed laser arm
Laser Cannon 5% - Powerful but slower chest laser cannon (A lot like megaFocus)
*Advanced Class 2*
Finger Laser - Fast firing fast moving finger laser
Laser Burst - A slow moving but destructive plasma laser ball
Power Laser - A laser beam that sustains itself for about 5 seconds.
*Nano Class 3*
Laser Balls - Fires at half the speed of rapidblast but is not deflectable.
Charge Ball - A larger ball of energy that can be charged like a beam, but its single shot.
Force Field - Like Shield I guess but deflects people who bump into you away.

Ok, so there are 4 classes of Android Technology:
Standard Mech: Each module installed should take 5% of the natural body, so 20 modules total
Advanced Mech: Each module takes 4%, so 25 modules total
Nano Mech: Each module takes 2%, so 50 modules total
Bio Mech: Each module takes nothing. The only thing is that once a body is created it cannot
be altered (aside from adding mechanical parts) because it is 100% organic. As long as you have
enough money you can build different bodies, an entire consciousness transfer is required to use
them. These cannot be upgraded at all.
--------
Cyborg Repair Tanks - Scientists make them. They can be upgraded to do a variety of things.
Repair damage, refill energy. Whatever else.

Give a very good reason for Scientists to have laboratories. One being that they can build a
highly customizable computer capable of many things, including turning people into cyborgs,
they can program it to make specialized cyborgs too, by giving certain stat advantages and such.
Not only that, you can determine the percentage of cyborg they are, you could go fully
mechanical transferring your entire consciousness into a computerized body and mind, or just
have your brain be organic like Gero, or only have mechanical arms etc. And as you get more
skill you get different types of Cyborgs, fully mechanical (mostly melee, gains hardly any
power other than upgrades, no real energy but can be upgraded to have artillery missiles and
laser artillery too, these are like dr Wheelo and his henchmen's mechanical bodies.
standard mechanical like 19 and 20 (They have laser "Ki" and such that
comes directly from their energy cores, and they can have certain artillery like 16 did).
Nano cyborgs which appear fully "Human", they are like 17 and 18. and then ones that are
essentially replicas of the Human body enhanced to different levels of genetic specifications,
these types would be fully organic and be like creating your own custom race. The Nano style of
cyborgs should be broken into 2 seperate types, Nano Mechanical (Koola),
and Nano Biological (Like 17 and 18), perhaps.
Frieza Cyborgs would be possible through the "Standard Mechanical" type listed above, with
the systematic replacement of certain limbs with customized robotic alternatives. Koola types
would be the Nano Mechanical Type and the entire consciousness would be transferred into an
artificial body capable of unnatural things if desired.
*Replacing different parts of the body would have different effects, one example is: The Brain,
you could add different elements to the brain, such as a basic sensor package, which would make
the brain 5% mechanical, but allow them to sense BP directly, then there would be multiple
sensors that could additionally be added that take up more % of the natural brain. The less
% your brain is biologically though, the slower your natural ki regenerates perhaps and the
slower your natural ki increases, and it would perhaps eventually hinder what natural ki
attacks you could use, but further upgrades to the brain would include false "Ki" attacks such
as lasers and other things that would depend on your energy core to power it, these types have
different advantages, like perhaps harder to deflect maybe, but less forceful in some cases?

Customizable Security Systems: Mechanical and Laser Turrets. Trip-laser system which will
teleport people to a customizable location on the same map (maybe a jail, even). Alarm systems
of varying capabilities, some alarms would warn you only through com nodes installed throughout
the facility (com nodes should also function and communicators from one end of a facility to
another), others would warn people from afar through scouters or badge thingies maybe.

Different methods seen through out the series to train with.
Such as climbing Korin's tower, the stronger you are the faster and easier you climb, there
could be hazards along the way to make you fall such as lightning and pterodactyls

As bounty hunting "skill" increased, you would get access to different things, like armor,
weaponry, traps, poison, things to slow down your enemy, things to ATTRACT your enemy, things
to SPY on your enemy and track their location and/or allow you to view them from afar, and
transportation. A device that can crack Passwords of doors that bountied people have created.
Tracking transports can automatically take you to the bounty head as long as certain conditions
are met: They are wearing a scouter you can track them by. They are in a pod. They have armor
on. You have a tracking camera already following them.

List of profession ideas:
Bounty Hunter
Scientist
	You can make new things such as force fields, those defender robots that deflect blasts
	which should no longer be publicly available once their are scientists. They can change the
	stats of things like armors, blasters, and such. They can colorize things for 1000 Money.
	They can make robots which automatically bring them food.

	It will literally be the sole choice of the scientist whether everyone else is left in the
	stone age, or the space age.

	They can create diseases and viruses, they can set them to not be contagious if they want but
	there is a chance that they will be contagious anyway and destroy everything. Also vaccines
	can also be created, but vaccines are 20% harder to create than the actual virus. Certain
	races will have different immunity levels, and also you can set your virus to focus on a
	certain race and no matter what their immunity level is they will catch it unless immunized
	but no other races will catch it except for a slim chance

	Perhaps they should be able to create devices capable of detecting dragonballs and other such
	rare items that have energy signatures unique to them.

	They can make fishing devices, first fishing poles, then nets, then robots who fish for you.

	Devices that when equipped allow you to detect invisible things. Also a personal invisibility
	cloak that when activated will render the user invisible to an extend

	They can make pod controls that you can carry with you, they can tell the pod to come to you
	wherever you are, and they can decloak the pod as well. Pods decloak automatically when called.
	The controls Im sure can do other things as well.

People who die with Finish leave corpses. And you can start fires to cook food and burn
corpses, and canabilistically eat them or whatever. Also you can bury them and a grave will
form and itll be cool and stuff.

A Boxing Gym where you can enroll in one-on-one melee fights, when your matched up with
someone if you win you get about 10000 Money or so. Also there would be obstacle races, and
a tiny room where a robot chases wheover is nearest to him and whoever it tags first loses. And
there would be mazes too, and whoever gets to the other side first wins the prize.







Arch's gambling code testbed

obj/Slot_Machine
	icon='Slots.dmi'
	Stealable=1
	password=""
	desc="This machine lets you input money to play a round of slots.  You may win big, or you may lose hard.  It's all up to chance!<br><br>
	<b>Stats:</b><br>
	Claimable (Password):  You can claim this item by setting a password for it.<br>
	Gambling Device (Slot Machine):  If the usage fee isn't set, the usage fee defaults to 100 resources.  This item may be upgraded to increase the max usage fee.<br>
	Safe Linkable: You may link this item to a safe.  It will automatically take or input funds there.  If the item lacks funds to draw from, it will shut down."
	var/Link_to_Safe
	var/Input_Amount
	var/Payout_Amount
	var/Win

	verb/Use_Slot_Machine()
		set src in oview(1)
		for(var/obj/Resources/B in usr)
			if(B.Value<=Input_Amount)
				return
			if(B.Value>=Input_Amount)
				B.Value-=Input_Amount
				usr<<"Slot Machine:  Rolling your slots!~  Please stand by..."
				sleep(10)
				Win=rand(1,15)
				if(Win==1||2||3||4||5||6||7||8)
					usr<<"Aww, no match!  Care to try your luck again?"
					return
				if(Win==9||10||11||12)
					usr<<"Low match!  Congratulations!  You're a winner!  Here's your reward of [Input_Amount*1.3] credits!"
				if(Win==13||14)
					usr<<"High match!  Congratulations!  You're a winner!  Here's your reward of [Input_Amount*2] credits!"
				if(Win==15)
					usr<<"Jackpot!  CONGRATULATIONS!~  You're a winner!  Here's your reward of [Input_Amount*4] credits!"
	verb/Claim_Slot_Machine()
		set src in oview(1)
		if (password=="")
			password=input("Enter a password to keep this slot machine from being accessed by unauthorized personnel.") as text
			usr<<"Password set!"
	verb/Set_Usage_Fee
		set src in oview(1)
		var/Check_Password=input("What is this slot machine's password?")
			if(Check_Password!=password)
				usr<<"Incorrect password."
			if (Check_Password==password)
				Input_Amount=input("Password received!  Input the amount of money you would like this machine to require to be used now!  All rewards will be multiplied by this input amount, so make sure you have enough money in your safe to cover the usage fee!")
				name= "[Input_Amount] Credit Slot Machine"
	verb/Link_to_Safe
		for







	verb/Set_Password()
		set src in oview(1)
		if (password=="")
			password=input("Enter a password to keep this drone from being stolen from you.") as text
			usr<<"Password set!"
	verb/Claim_Drone()
		set src in oview(1)
		var/Claim_Drone=input("What is this drone's password?")
		if (Claim_Drone!=password)
			usr<<"Incorrect password."
		if (Claim_Drone==password)
			dronekey=usr.ckey
			usr<<"You have claimed this drone!"
			usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has claimed [src].\n")
/*	for(var/mob/player/A in Players)




*/

		for(var/obj/Resources/B in usr)
			var/Amount=0
			for(var/obj/O in range(0,usr)) if(!(locate(O) in usr)) Amount++
			if(Amount>=20)
				usr<<"Nothing more can be placed on this spot."
				return
			if(B.Value<Cost)
				usr<<"You do not have the resources to create this."
				return
			B.Value-=Cost
			var/obj/A=new Creates
			if(A)
				A.loc=usr.loc*/