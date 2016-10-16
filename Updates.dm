/*
Update empty template

      <h2><a href="javascript:void(0)" class="dsphead"
         onclick="dsp(this)">
         <span class="dsphead">+</span> heading</a></h2>
         <div class="dspcont"><ul><li></li></ul></div>

*/
var/Recent_Updates={"<ul>
<b>Xenosphere Beta V.003 - 12th of July, 2016.</b><br>
	<li>Status tab now displays the total overall number of role play points you have earned on your character.</li>
	<li>Only Android Ship spawned Androids can set their frequency to the default communication channel of their starting scanners.</li>
	<li>Being afk now adds to your rested role play points, which means you gain a bonus to how many rp points you earn. This should help those who are afk at work or in a time zone that doesn't correlate with peek times, in catching up to others who constantly rp.</li>
	<li>No longer able to gain transformation mastery while afk.</li>
	<li>Changelings can now select their starting icon correctly.</li>
	<li>Role Play Points used on Battle Power are a little over twice as effective.</li>
	<li>New tech item. Adamantine Skeleton, which costs 100,000,000 resources on a genius level alien. Applying it to your character adds 10% to your durability and prevents limb damage. However, using it without 80 intelligence has a 50% chance to kill you.</li>
	<li>The Android Ship now starts with a set of security cameras which are linked to Android Ship created Androids starting scanners.</li>
	<li>Energy gained from Role Play Points were set to be a static number. RRP's X 50 X EnergyMod = Result</li>
	<li>Magic/Intelligence exp from RPP's were doubled.</li>
	<li>Resource/Mana gains from RPP's were doubled.</li>
	<li>Android Upgrade Components had the max they can upgrade an Androids energy mod to 5, instead of 10. Androids were refunded any investment also.</li>
	<li>Magicial Healing used to heal 25% of an injury, now it only heals 10%.</li>
	<li>Says, Whispers and Telepaths now all count toward your rp points earned again.</li>
	<li>It's now only possible for one rare of each type to spawn.</li>
	<li>New characters past year 10 will now be given automatic gain boosts based on the year to help them catch up.</li>
	<li>Ancient Vampires infection now costs them 1000 of their max energy and 10% of their current stats.</li>
	<li>Sounds and music, credit to Xiathyl.</li>
	<li>Can grab pods again, just not in space.</li>
	<li>The damage guns were doing were lowered to better match the mod changes from the last large update.</li>
	<li>Creating portals via magic no longer allow you to do so between the AL and LR.</li>
	<li>Bug fix for planets spawning inside bases in space upon reboot.</li>
	<li>Piercer must charge now before it can fire, instead of being available instantly.</li>
	<li>Kaioken/Spirit Bomb/Instant Transmission can't be taught except by the rank holder linked to those skills.</li>
	<li>Cyberize was disabled for now, until a better and newer system is in place.</li>
	<li>Anger should remain now, unless you meditate, get koed or start to self train.</li>
	<li>Admin verb Give Rank can now also be used to remove someone as a rank if needed.</li>
	<li>Earth Gurdian now starts with a special crystal ball which doesn't need mana to use, but can only spy on people who are on the surface of Earth.</li>
	<li>Should now be impossible to travel between the AL and LR via teleport pads.</li>
	<p>
<b>Xenosphere Beta V.002 - 10th of July, 2016.</b><br>
	<li>Fixed several run time errors and divisions by zero.</li>
	<li>Fixed a bug with security cameras not being able to be assigned a password.</li>
	<li>Only Androids can pilot the Android Ship now.</li>
	<p>
<b>Xenosphere Beta V.001 - 2nd of July, 2016.</b><br>
	<li>Android bridge's mainframe now spawns an AU component every month.</li>
	<li>Clicking the Android ships mainframe now removes only one AU Component at a time.</li>
	<li>When a player clicks a mana pylon, a magical link chains them all together and the mana from any pylon within that link, are moved to your location and absorbed into your mana stack.</li>
	<li>Newly created realm portals can now be closed permanently by the creator and for a small refund.</li>
	<li>Gravity gains were made a bit better.</li>
	<li>Fixed a bug where some ranks weren't being given full body when assigned their rank.</li>
	<p>
<b>Xenosphere V.000 - 2nd of July, 2016.</b><br>
	<li>Saiyan had their energy mods increased by 0.5.</li>
	<li>Bug fixed with saving and items vanishing.</li>
	<li>Ancient Vampire don't have anger, so instead they now do not lose power or speed when hurt, like Android.</li>
	<li>The max length of Emotes has been increased.</li>
	<li>Passive RP Point gains while not being afk were lowered.</li>
	<li>The time an Emote or other form of communication is open vs the time it was closed had its mathematics adjusted slightly to accommodate for faster typers so admins aren't alerted of legitimately typed text.</li>
	<li>Number of RP Points earned was halved, since it seemed people were capping at 5 a little too easily.</li>
	<li>RP Point cost for skills were adjusted slighty. Before it took on average about 2 IC years to gather enough points for a skill. Now it should be 3.</li>
	<li>The RP Point cap should now update correctly for people who were offline during a month change and missed out on their caps adjusting.</li>
	<li>Saiyans had their max angers raised to what they used to be at.</li>
	<li>No longer able to grab pods.</li>
	<li>Hacking Consoles can now be used to hack into anything that has a password protecting it.</li>
	<li>Demigod had their energy mod reduced by 1.</li>
	<li>Fixed a bug with using RP points toward Int/Magic gains.</li>
	<li>Another bug with rp points and caps has now been fixed, it can be used once more.</li>
	<p>
<b>Xenosphere V.000 - 19th of June, 2016.</b><br>
	<li>All rares have a much lower chance to spawn now and in some cases, only one will spawn per type.</li>
	<li>Power leech toggle was removed. It's now always on.</li>
	<li>DBZ race names added back in.</li>
	<li>Bug where super fly was giving more BP than Self Train was fixed.</li>
	<li>Bug where Power Armour was unequipping Android Scanners fixed.</li>
	<li>Expand now only increases strength by 20% instead of 40% per level.</li>
	<li>Expand now only increases dura by 10% instead of 20% per level.</li>
	<li>Heaven spawn was redone.</li>
	<li>Hell spawn was redone.</li>
	<li>Namek spawn was redone.</li>
	<li>Elite Saiyan is now available for every 4 non-elites online.</li>
	<li>Oni now have a magic mod of 4, like their tech mod.</li>
	<li>Fixed a bug with power armor not displaying the correct durability.</li>
	<li>New rare. Small chance for a Kynoshi to spawn as an Ancient Vampire.</li>
	<li>Ancient Vampire can detect people through walls, due to the energy signature their potential prey emit.</li>
	<li>Androids now have highly sophisticated and advanced sensors and can see through walls.</li>
	<li>Unable to blind Androids and Vampries using Taiyoken, but Taiyoken will hurt a Vampire and damage it a little instead.</li>
	<li>New roofs, walls and objects.</li>
	<li>There is now a very low chance to learn a skill even if someones skill leech is off, if your energy is very high.</li>
	<li>Having good relations or rival relations with someone increases the chance of learning a skill from them.</li>
	<li>All stat mods for all races, for all sizes, were rebalanced based on a much older version of the game.</li>
	<li>Kynoshi incline speed was changed from 6 to 2, meaning they mature alot quicker.</li>
	<li>Reverted the +25% bonus to Resistence and Durability, since the current stat mods should be more balanced.</li>
	<li>King/Queen of Vegeta now gain the ability to create artifical moons out of energy.</li>
	<li>King/Queen of Vegeta now gain the Power Control ability.</li>
	<li>No longer able to expand while in Power Armor.</li>
	<li>Limit Breaker is no longer available to mutant/aliens upon creation.</li>
	<li>Tech items now have serial numbers.</li>
	<li>Kaioshin and Namekian Elder start out with their potentials unlocked. Demon Lord starts out with their equivalent, Dark Blessing, unlocked.</li>
	<li>Bandages last quite a bit longer.</li>
	<li>Now only able to put a max of 5 points into a new characters stat mods using your stat point, unless playing an Alien, which allow for 15.</li>
	<li>Magic based healing is easy to get, so its effectiveness is now only 1/4 that of the rarer energy based healing.</li>
	<li>Suggested Ranks, an old verb that stated guidelines on playing a rank responsibly, was re-added.</li>
	<li>Oozaru was changed somewhat back to what it used to be, stat wise. Now, it only halves def. Instead of adding speed, it adds 50% dura. Instead of x5 bp, it only gives x2. It lasts twice as long as before.</li>
	<li>Contacts are now automatically added when you meet a new person for the first time.</li>
	<li>Bojack and Ki Burst were rebalanced to work better with the new stat mods.</li>
	<li>Third eye was rebalanced and changed. It's no longer based off anger.</li>
	<li>Android stat cap for upgrades were changed from 3 to 2 to reflect the new stat mods for all races.</li>
	<li>Android Upgrade Components were once again doubled in price, to reflect the new stat mods for all races.</li>
	<li>Limit Breaker was rebalanced to work better along side the new stat mods and now includes strength in its formula.</li>
	<li>Kaioken was rebalanced to work better along side the new stat mods, it now scales at a steady pace with your base bp too and doesn't remove as much def.</li>
	<li>Third eye was made twice as easy to attain, within a random perimeter of 1 - 50,000 base bp, instead of 1 - 100,000.</li>
	<li>Gravity machines were made cheaper.</li>
	<li>Gravity was reworked and rebalanced. Training in it will give you a slight boost to bp gains. Mastering it will also give a slight bp gain boost during and out of a gravity field.</li>
	<li>Gravity no longer kills, but it can crush you to a pulp.</li>
	<li>Planetary Gravity was added back in.</li>
	<li>Aliens can now choose from three types of transformation upon creation. Melee, Ki and Hybrid. Each one has a random requirement between 10,000 base bp and 300,000.</li>
	<li>New Injury System!</li>
	<li>New tab named Injuries, which lists how much damage has been done to each limb, as a percentage.</li>
	<li>Injuries so far include Hearing, Speech, Arms and Legs, Head and Torso, along with the inability to Mate.</li>
	<li>A head injury at 100% will half your Intelligence and Magic mods until healed.</li>
	<li>A torso injury at 100% will take 25% away from your available power and 20% from your energy.</li>
	<li>A throat injury at 100% will prevent you speaking until healed.</li>
	<li>A hearing injury at 100% will prevent you hearing until healed.</li>
	<li>Explosion has a 25% chance to cause your ear drums to explode if you're caught in it.</li>
	<li>A limb injury at 100% will break that limb and remove 20% from your Strength, Defence, Offence, Force and Speed.</li>
	<li>Having an injury produces a little bit of zenkai.</li>
	<li>Head injury at 100% will prevent telepathy.</li>
	<li>Meditating will heal your injuries quicker.</li>
	<li>An injury will heal fairly slowly, based on your regeneration mod.</li>
	<li>Bandages increase the rate you heal from injuries.</li>
	<li>Having death regen helps you heal slightly faster than normal.</li>
	<li>Regenerators increase the rate you heal from your injuries.</li>
	<li>Energy Heal and Magical Heal will restore a random damaged limb.</li>
	<li>When hitting someone with Ki or Melee attacks, there is a chance based on the damage done to you, that a limb will take a percentage injury.</li>
	<li>New verb, Injure. Used on KO'ed players to apply an injury of your choosing upon them.</li>
	<li>New verb, Toggle Pull Punches. Pulling your punches prevents injury in melee. You pull your punches by default.</li>
	<li>Boxing Gloves always force you to count as pulling your punches in melee.</li>
	<li>Cloner and Phylactery sickness. Applies all injuries apart from sight to the user.</li>
	<li>Limit Breaker and Kaioken will slowly injure the user.</li>
	<li>Using Kikoho will injure you a little.</li>
	<li>Training with an injured limb prevents it healing.</li>
	<li>Training with a broken limb makes it worse.</li>
	<li>Gravity will injure you slowly, based on how much you have mastered and how much you use.</li>
	<li>New Reward System!</li>
	<li>Role Play Points. They are shown under the Status tab, along with how many emotes and says total you have done.</li>
	<li>RP Points increase from using emote, say whisper and telepathy. They also increase slowly when not afk.</li>
	<li>The number of RP Points earned from using verbs that increase them is determined by how often you use them and how long the text is.</li>
	<li>RP Points are not biased and only take into consideration effort put into how often you rp and how much, not the quality, since quality can vary both in actuality and opinion.</li>
	<li>Typing spam or pasting too larger an emote vs how long the verb remained open for won't count toward RP Points and alerts admins, and can also get you banned in some cases for trying to abuse the system.</li>
	<li>New verb. Role Play Points. Allows you to trade your RP Points for Energy, BP and skills.</li>
	<p>
<b>Xenosphere Alpha V.051 - 11th of June, 2016.</b><br>
	<li>Blast, Charge, ect, now instantly destroy a wall, bot not a roof, when they hit them.</li>
	<li>Fire! Don't stand in it.</li>
	<li>Kyonshi now start with energy telekinesis.</li>
	<li>Anti-virus now cures Heart Virus. Increased its price slightly.</li>
	<li>Androids no longer have an energy signature.</li>
	<li>Androids now spawn from an Android Chassis on the Ship. Chassis can now also be named and players can choose specific ones to create into.</li>
	<p>
<b>Xenosphere Alpha V.050 - 9th of June, 2016.</b><br>
	<li>Fixed a bug preventing the correct use of Shunkan Ido.</li>
	<li>New tech item, bandages. Equipping them increases your regen by 25%, but they only last two minutes and can't be used in battle.</li>
	<p>
<b>Xenosphere Alpha V.049 - 8th of June, 2016.</b><br>
	<li>Using Examine then selecting a skill you have learned should tell you the year you learned it and from who.</li>
	<li>LSSJ now only unlocks at year 10.</li>
	<li>LSSJ can only transform after the first SSJ, or as the first SSJ in future wipes.</li>
	<li>May have fixed a bug with doors and magic portals stacking on reboots.</li>
	<li>Contact familiarity was fixed and now raises correctly.</li>
	<li>Ancient Namekians starting ship had its speed increased so it doesn't just get left in one spot the whole wipe.</li>
	<li>Bio Android had its forms adjusted and were balanced better.</li>
	<li>Number of years before being able to teach someone a newly taught skill you have learned lowered from 10 to 5.</li>
	<li>Fixed a possible bug with absorbed bp and also lowered the time it takes for the absorb to fade away from 2.5 years to 5.</li>
	<li>Fixed a bug with an admin panel displaying player rank afk time incorrectly.</li>
	<li>Text indication when an Aquatian transforms.</li>
	<li>Aquatian forms BP's and starting BP were adjusted to be much closer to the show they're based on.</li>
	<li>Shunkan Ido was changed so you can only teleport to players in your contacts and only if you have 25+ familiarity.</li>
	<li>Added a Donate tab.</li>
	<p>
<b>Xenosphere Alpha V.049 - 31st of May, 2016.</b><br>
	<li>Fixed a bug where you can equip normal armour while wearing power armour. The two were stacking for unreasonable defence chances and enchantmeant gains.</li>
	<p>
<b>Xenosphere Alpha V.049 - 30th of May, 2016.</b><br>
	<li>Possible fix for an item duplication bug, and at the very least, a tidy up of old saving code.</li>
	<li>Fixed a bug with Lesser Teleport.</li>
	<li>Players must of had a skill for ten years before being able to teach it freely. This is mainly for balance purposes, but roleplay wise, we can assume that the student doesn't have enough experience. Ranks are able to teach skills straight away.</li>
	<p>
<b>Xenosphere Alpha V.049 - 29th of May, 2016.</b><br>
	<li>Android Upgrade Components now recalulate your current stats based on your new mod and adjust them accordingly.</li>
	<li>Bio Android's Imperfect form, after absorbing their 1st Android, no longer has a 75% nerf on Regen/Recov and is instead 25%.</li>
	<li>Being KO'ed didn't seem to reset your expand if it was in use, this should be fixed now.</li>
	<li>Death now cures the Heart Virus.</li>
	<li>LSSJ have .2 more recov and .5 more energy to their mods.</li>
	<li>LSSJ's SSJ2 form is now equal to a Low/Normal/Elite's SSJ1. SSJ1 on LSSJ can be considered as a restricted SSJ form.</li>
	<li>New tech item - Android Chassis. It costs 30,000,000 resources on a genius level mutant. When a player creates an Android, they have a chance to spawn into the new Chassis.</li>
	<p>
<b>Xenosphere Alpha V.048 - 25th of May, 2016.</b><br>
	<li>Imitate can be used on afk people now correctly.</li>
	<li>Makyojin expand doesn't drain as much.</li>
	<li>Lowered the percentage chance of rolling each rare race depending on their popularity, for the moment.</li>
	<li>No longer able to downgrade doors.</li>
	<li>New icon for Makyojin expand.</li>
	<li>Reverted the -25% damage nerf to Blast, since the +25% Resistence made Force 50% weaker overall.</li>
	<li>Tweaks to Blast relating to Speed Mod, and possible fix to Focus making Blast slower instead of faster.</li>
	<li>Should be able to upgrade Magical doors with the Enhance verb now.</li>
	<li>The range limit on Shunkon Ido was removed, but the mastery/skill level you aquire from using it still counts to how long it takes to use.</li>
	<li>The verb to make doors unable to be hacked is now Enchant instead of Enhance.</li>
	<li>Added an option to countdown that displays when you're close to 0 by doing a 10-0 mini countdown at the end.</li>
	<li>Energy gains were increased slightly to compensate for some of the balance changes.</li>
	<li>Fixed a bug with magic doors where it would cost 200,000 resources to upgrade, instead of 40,000 like other doors.</li>
	<li>All ki skills like Charge, Sokidan, ect, had their charging times halved in hopes we can see them used more in pvp instead of massive Blast spam.</li>
	<li>Fixed a calculation error with the new +25% dura buff that actually made it weaker.</li>
	<li>Explosion will now toggle off once used, so there's less risk of accidently leaving it on.</li>
	<li>Activation of the Focus skill looks better. Plans are to add flashy graphics to most skills if possible..</li>
	<p>
<b>Xenosphere Alpha V.047 - 23rd of May, 2016.</b><br>
	<li>More resource pool respawning fixes and tweaks.</li>
	<li>Adjusted blocking so it halves damage.</li>
	<li>Adjusted the melee calculations for dodge to include speed mod instead of the old speed stat. Thanks to Adamrpg and Nevets for their help.</li>
	<li>Fixed a bug where off was gaining twice as fast as def when training.</li>
	<li>Fixed yet more bugs with shield.</li>
	<li>Reboot now disconnects everyone from the server the moment the reboot message appears. Done to prevent item duping.</li>
	<p>
<b>Xenosphere Alpha V.045 - 22nd of May, 2016.</b><br>
	<li>Another fix to shields.</li>
	<li>Damage from blocking is no longer halved, but takes 1/3 off the damage instead now.</li>
	<li>Speed now factors more into how fast you can blast.</li>
	<li>The 25% increase to defence was removed in favour of the new blocking mechanic.</li>
	<li>Blast had its damage reduced by 25%. This is very experimental and I want to see how this pans out.</li>
	<li>Piercer now starts off at x4 charge, instead of x6 and charges at the same power rate as Final Flash.</li>
<p>
<b>Xenosphere Alpha V.045 - 22nd of May, 2016.</b><br>
	<li>The drain on expand was increased ever so slightly.</li>
	<li>Tweaked resource spawns again on planets.</li>
	<li>There is now a chance equal to your defence stats, that a melee attack/blast is blocked if a roll to dodge is failed. Blocking takes 50% damage off an attack. A block is indicated now by the tiny shock wave that used to appear in battle.</li>
	<li>The Majin race had their stats balanced and improved.</li>
	<li>There is now a 2% chance that the option to create a Majin will appear on your race selection menu.</li>
	<li>Majin start trapped within a randomly selected realm and must wait for someone to open a portal to it.</li>
	<li>Bojack and Ki burst now only need 10,000 bp to use, instead of 15,000.</li>
	<li>Bojack and Ki Burst drain like SSJ, but can be mastered.</li>
	<p>
<b>Xenosphere Alpha V.044 - 20th of May, 2016.</b><br>
	<li>Max dmg telekinesis can do capped at 10% HP.</li>
	<li>Energy absorb - Absorbs half as much energy from someone. Also fixed a bug with it.</li>
	<li>Android upgrade component had its price halved.</li>
	<li>New build menu.</li>
	<li>Adjusted resource spawnings on planets to scale with the year and made all places start with a moderate cache of resources to exploit.</li>
	<li>Locked doors are now only built within the tech menu and cost 100,000 resources on a genius level mutant. They can be upgraded like walls.</li>
	<li>Taiyoken won't last as long.</li>
	<li>Calculations for Endurance and Resistance were changed so fights last a bit longer.</li>
	<li>New icons/objs to build/place.</li>
	<li>Shield will now instead take 25% of the energy you use for Recovering and convert it into a shield which increases your Resistance by 25% while active.</li>
	<li>Digging manually now takes resources from the planets resource pool.</li>
	<li>Stat gains were nerfed slightly, as some changes to the code a while back made them too high.</li>
	<li>Shoud now gain quicker stats only when appropriate to your standing on the stat rankings.</li>
	<li>Android now start with a 2 bp mod again and a 3 energy mod.</li>
	<li>Android now start with a built in scanner.</li>
	<li>All smalls with mods below 1 were adjusted to 1.</li>
	<li>Pikkon have better and more balanced stats now.</li>
	<li>Large Demigod was made 0.2 faster.</li>
	<li>Slight nerf to medium Demigod stats.</li>
	<li>Celestial mods were adjusted to be better, especially for larges.</li>
	<li>Beastmen now decline at 40 instead of 30.</li>
	<li>Beastmen have a 25% chance to catch a Heart Virus when they land on Earth and leave a ship/pod, for the first time, before year 20.</li>
	<li>Slight buff to resources on all places apart from Ice.</li>
	<li>Expand now drains half as much energy as Focus does when in use.</li>
	<li>No longer able to land a ship or pod onto solid walls when landing.</li>
	<li>5% chance for an Android to spawn as an Ancient Progenitor; a fully upgraded mechanical being left over from a long forgotten fallen empire.</li>
	<li>5% chance for an Beastman to be born with an unstable Legendary gene.</li>
	<li>5% chance for an Earthen to awake as an Ancient of their species.</li>
	<li>5% chance for an Android to be created as a Biological Android.</li>
	<li>The server/code only allows you one chance every 10 ic years to roll a rare, so remaking for another chance is impossible until then.</li>
	<li>-1% chance per player with a rare of that type on subtracted from the chance to roll a rare of that same type.</li>
	<p>

	<li>Oni now spawn in the checkpoint.</li>
	<li>Cloning tanks now break once the clone inside activates and require half their cost in repairs to use again.</li>
	<li>Telepathy can no longer be learned naturally, only certain ranks can attain it.</li>
	<li>Magic system!</li>
	<li>New resource, Mana. Gained from focusing on magic levels or from the harvest of local ambient mana via pylons.</li>
	<li>The Makyo Star doubles all mana generated each month on the month it comes out.</li>
	<li>New meditation options. Focus on Intelligence or Magic.</li>
	<li>Magic Potential, a new variable that determines how good a race is at magic. Kaio, Demon and Mayko are the best. Earthen, Kynoshi and Oni are second. Humans and Pikkons are about half as good as the best races.</li>
	<li>Magical Attunement, a new starting trait for mutants that acts how the Genius trait does for technology, only it's for magic.</li>
	<li>Telekinesis and Magical Telekinesis. The former can be chosen as a new trait for mutants and makes use of energy to move objects and players. The latter makes use of mana as a resource and is unlocked at 60 magic skill. Both are used by holding a click on an object/player and dragging it around the screen. You can also throw items into people to harm them based on either your max energy or magic level.</li>
	<li>Demon Lord and Kaioshin start with both versions of Telekinesis unlocked.</li>
	<li>Changeling Lord starts with Telekinesis.</li>
	<li>Earthen Elder gains +1 Magical Poetential when ranked, making him as good as a Makyo.</li>
	<li>Each realm/planet has mana, like they do resources. The afterlife has the most, where as Namek, Earth and Arconia have half as much.</li>
	<li>New magic item, Mana Pylon. Acts like a tech drill and extracts ambient mana from planet/realms.</li>
	<li>New magic item, Crystal Ball. Once enough mana is added to the arcane device, it allows players to observe others.</li>
	<li>New magic item, Magic Circle. Sitting in the middle will increase the rate you gather ambient mana. It is also used in some advanced rituals.</li>
	<li>New magic item, Spell Book. When kept on you, increases the amount of ambient mana absorbed. When clicked, it can also be used to cast certain spells which unlock at certain magic levels.</li>
	<li>New magic item, Mana Vault. Like a tech safe, it can store mana and keep it secure.</li>
	<li>New magic item. Phylactery. Like a cloning tank, only the user dies if the item is destroyed. It also doesn't incur a decline lose.</li>
	<li>New spell, Heal. Accessed via clicking the Spell Book and unlocked after a certain magic level and coming with a mana cost, this spell allows you to heal others.</li>
	<li>New spell, Create Portal. Accessed via clicking the Spell Book and unlocked after a certain magic level and coming with a mana cost, this spell allows you to do one of two things. Either create a portal from one location to another that lasts a small amount of time, or create a Realm of your own, sort of like with ship creation, only the portal is permanent and can't be moved or closed.</li>
	<li>New spell, Enchant. Accessed via clicking the Spell Book and unlocked after a certain magic level and coming with a mana cost, this spell allows you to enchant swords and armor with percentage bonus stats, up to +5% per piece.</li>
	<li>New spell. Lightning Bolt. Accessed via clicking the Spell Book and unlocked after a certain magic level and coming with a mana cost, this spell allows you to send bolts of pure magical energy into the ground, damaging items and players.</li>
	<p>
<b>Xenosphere V.040 - 16th of January, 2016.</b><br>
	<li>Fixed another bug with adding resources to walls.</li>
	<li>Added Pikkon back as a race you can choose.</li>
	<li>Made it so there's no anger fail or cooldowns between anger.</li>
	<li>Emote now shows a typing overlay.</li>
	<li>Added a new tech item, the Boxing Glove, which makes you do 10 times less damage in melee, good for sparring. Icon courtesy of Alfogus.</li>
	<li>Sparring/Punching bag gains were made twice as good.</li>
	<p>
<b>Xenosphere V.039 - 7th of January, 2016.</b><br>
	<li>Moons are now unlocked at Intelligence level 100 and cost 20,000,000 resources on a genius-level mutant.</li>
	<li>Moons can only be used once every 3 months and if used near players who have a cooldown on their moon usage, the moon won't effect them. Natural moon transformations will still trigger once per year.</li>
	<li>Upgrading walls with resources was made twice as good.</li>
	<li>Power armor now increases raw power by +33%, instead of +25%.</li>
	<li>Defence bonus lowered from +50% to +33%.</li>
	<li>Moon transformations don't shake the screen nearly as much.</li>
	<li>Motion detectors will only activate near players now, instead of also split forms and drones.</li>
	<li>Low class now have a 2 bp mod, normal class a 2.2 and elite a 2.4.</li>
	<li>Human now start with a 1.5 bp mod, instead of only 1.</li>
	<li>Made Oni have slightly better off/def stats, speed and recovery.</li>
	<li>The Demon Lord can now observe those they have given Majin.</li>
	<p>
<b>Xenosphere V.038 - 17th of December, 2015.</b><br>
	<li>Fixed a bug with energy leech that made players able to gain far in excess of what their mods would normally allow via sparring.</li>
	<li>Android upgrade component is now 20,000,000 instead of 10,000,000, for a Genius-level mutant.</li>
	<li>Changed auto-repair/revive chance for Android to respawn back on their ship from 90% to 50%.</li>
	<li>New tech item, Power Armor. Unlocked at 120 intelligence and requires 200,000,000 resources on a genius-level mutant. Acts as normal armor, but gives +25 to Strength, Durability, Resistance and Power but -25% Speed. You also need 100 intelligence to enter it.</li>
	<li>Being absorbed, even if you have regeneration, kills you, since all available matter to regenerate from is transfered into power and used by the absorber.</li>
	<li>Defence is now +50% more effective than before.</li>
	<li>Contacts were re-added. They don't actually do much beyond keeping track of who you've met and what they look like just yet though.</li>
	<li>New tech item. Motion Detector, costs 100,000 resources on a genius-level mutant and unlocked at 30 intelligence.</li>
	<li>New tech item. Security Camera, costs 100,000 resources on a genius-level mutant and unlocked at 30 intelligence.</li>
	<li>You can now add extra resources to your walls to enhance them further.</li>
	<p>
<b>Xenosphere V.037 - 9th of December, 2015.</b><br>
	<li>Head admins can now toggle global reincarnation on and off. It is off by default.</li>
	<li>Expand will now only give +40% strength, instead of +50%.</li>
	<li>Majin for Demon now only gives +75% to power, as opposed to +100% before.</li>
	<li>Demon and Celestial will mature around age 18, instead of 32.</li>
	<li>Mystic now gives +30% power to Celestials and +15% to non-Celestials.</li>
	<li>Celestials now unlock their Observe skill at 1000 energy, instead of starting with it straight away.</li>
	<li>Limit Breaker previously had a 2% chance to KO the player every 2 seconds. It now has a 1% chance.</li>
	<li>Androids now start at 1 in every mod and can't choose a body size, but they have become highly customizable mod-wise via tech items.</li>
	<li>New tech item. Android Upgrade Component which is unlocked at intelligence level 40, costing 10,000,000 for a Genius-level mutant.</li>
	<li>Android Upgrade Components can be used on Androids to upgrade one of their mods by +0.1, or in the case of energy, +0.5, up to a max of 3 or 10 for energy.</li>
	<li>Small tweak to Focus, making it drain slightly less.</li>
	<li>Explosion now has a 25% chance to force someone to land, the power from the vacuum caused by the attack sucking its victim to the ground.</li>
	<li>May have fixed an issue that was causing crashes, along with a few smaller problems that may have contributed to accumulative chances of crashing the game.</li>
	<li>Made Self Destruct not randomly leak and adjusted and balanced the damage it caused.</li>
	<li>Spirit Dolls/Kyonshi now start with around 50% of their power, instead of only just 30%.</li>
	<li>Expand now gives +5% resistance per level.</li>
	<li>It should take twice as long to drown now if you're not being carried through water while ko.</li>
	<li>A new reward system has been added for the admins to make use of.</li>
	<li>Safes unlock at intelligence level 40 and cost 1 million resources for a genius level mutant.</li>
	<li>Kaioken can only be used at half its power now whilst dead.</li>
	<li>Fixed a bug where Solar Flare disabled your ability to see Says and Emotes.</li>
<p>
<b>Xenosphere V.036 - 2nd of December, 2015.</b><br>
	<li>Dig now has a cooldown between its uses, to prevent an issue with stacking.</li>
	<li>May have fixed a bug with Fly where if you spammed it, the skill would disturb your flight.</li>
	<li>Fixed a bug with Grab where you could make players and items teleport to you.</li>
	<li>Notifications for when a player charges and fires a beam.</li>
	<li>Magic balls no longer delete or become stuck when you log out in a pod.</li>
	<li>Head admins can now respawn global planet resources instead of rebooting the server</li>
	<li>You can now use the Remove verb on doors you own to delete them.</li>
	<li>Shockwaves damage was greatly reduced.</li>
	<li>Notifications for when a player equips armor and weapons.</li>
	<li>You can now unbolt items.</li>
	<li>Teleport pads can be bolted.</li>
	<li>Made Shockwave less laggy.</li>
	<li>Bojack now only gives +50% Strength and Endurance instead of +100%.</li>
	<li>Ki Burst now only gives +50% Speed instead of +100%.</li>
	<li>In regards to the Bojack/Ki Burst adjustment, these are subject to change and seem to be a way to balance them better. Especially seeing as at the time of writing this, going Expand x2 in Bojack is prohibited. Hopefully that can change soon.</li>
	<li>Fixed a bug where Focus drains were stacking.</li>
	<p>
<b>Xenosphere V.035</b><br>
	<li>The Amulet is no longer capable of sucking in doors and bolted items.</li>
	<li>Yes/No promps were added to certain admin verbs to avoid mistakes.</li>
	<li>Shadow Spar has been disabled for the moment due to many bugs. It was never actually added into the game anyway.</li>
	<li>Fairly certain that the bug where you are spam killed by beams and the likes has been fixed.</li>
	<li>Force fields become stronger when upgraded, based on the year, to help mitigate growing bp/force.</li>
	<li>Shield was adjusted to take less energy away.</li>
	<li>Certain vars like Super Tuffle are now hidden from admin edit and can only be granted by a head admin now or unlocked upon creation as normal.</li>
	<li>The Countdown verb has been fixed, it will now also display to everyone within 20 tiles and even through walls.</li>
	<li>Changed Third Eye so you can't buff into it via Expand/Focus, ect. Lowered the require of Third Eye from between 1 bp and 1,000,000 current bp to 1 and 100,000 base bp. </li>
	<li>Added a RNG to the admin verbs so admins can fairly roll a number between a lowest and highest setting which is then added to the logs and recorded for the team to see.</li>
	<li>Self train and Meditate now give the same bp.</li>
	<li>Fixed reverse sparring.</li>
	<p>

<br><br><b>Xenosphere V.03306</b><br>
	<li>Fixed contacts. </li>
	<li>Added a check to make sure AI is not activated when they're in the 'Death' area.</li>
	<li>Added an extra area called 'Limbo' and created a box on the map where the players will be sent to when they have a cloning tank, previously this was the same area NPCs were sent to awaiting a respawn.</li>
	<li>Changed the way digging checks for multiple instances. Propagated this check to training and digging.</li>
	<li>Made sure that looted armor does not auto-equip onto the robber, allowing infinite stacking of armor.</li>
	<br><br>

<br><br><b>Xenosphere V.03305</b><br>
	<li>Altered the structure of the event scheduler to attempt to address an issue causing crashing.</li>
	<li>Added an if null check to a client.address issue with emote.</li>
	<li>Removed a bug that was causing crashes with PC.</li>
	<li>Fixed a bug with train timers that could cause a crash.
	<li>Fixed a bug with scanning that could sometimes omit mobs.</li>
	<li>Fixed a very rare bug with reading a save that could cause it to register as a NPC save file.</li>
	<li>Increased the number of checks to cancel scheduled events on mob deletion and logout.</li><br><br>

<b>Xenosphere V.033042</b><br>
<li>Added a clause to mob deletion that should catch bad event scheduler calls that weren't terminating properly.</li>
<li>Added a clause to attack to handle a null.KB error that was initiating within a while loop due to logout and scheduler related issues.</li><br><br>

<b>Xenosphere V.033042</b<br>
	<li>Fixed an exploit that could allow players to stack stat gains.</li>
	<br><br>

<b>Xenosphere V.033041</b><br>
	<li>A new tech item, the altered teleportation watch, has been added in along with a new tier of travel gear progression.</li>
	<br><br>

<b>Xenosphere V.03304</b>
	<li>Added in a new base for male and female Aquatians and white male humanoids.  Enjoy the new animations, slightly bigger icons, and higher detail they have!  Raws for the artistic types will come once every race icon is done.</li>
	<li>Removed a pesky bug with power control that was causing crashes when used in conjunction with variable gravities.</li>
	<li>Modified the hair selection code to account for the larger bases.</li>
	<li>Removed a rare bug that could cause a crash on firing null beams.</li>
	<li>Added an experimental fix to stop the calling of null events.</li>
	<li>Fixed an error that could sometimes cause a crash mid-wipe.</li>
	<li>Added in a number of new turfs in preparation for the introduction of the new map.</li>
	<br><br>

<b>Xenosphere V.032 (Part 2 of 3 -  Part Two:  New Base Icons, Intelligence Energy Gain Revamp, Aquatian Base Graphical Revamp, Beastman KO Gains Revamp)</b><br>
	<li>Altered the path for PC to a more generalized setting, instead of being player specific.</li>
	<li>Numerous bug fixes.</li>
	<li>Added a check for power control to ensure that their user's ID was not applied to a NPC or non-valid mob</li>
	<li>Implemented numerous defensive programming measures against issues with scheduling events and loading saves.</li>
	<li>Aquatians are no longer genderless.  Currently, only male gender Aquatians can be made.  This will change once the female icon goes live for usage.</li>
	<li>Added in energy gains for meditating while leveling intelligence.  After testing, the lack of energy gains while meditating proved to be somewhat grindy for intelligence focused characters wanting to do something other than crafting.</li>
	<li><b>Added in new base icons for humanoid races.</b>  These icons are the new standard for humanoid races, and are vastly improved over the prior base icons.  The base possesses animated idle states for each race and a much higher level of detail in the icon.  The enhanced detailing should also allow for more much easier production of varied and interesting clothing from both players and the game.  Aquatians currently use these new icons as their base form.  The male version is complete and live for player usage, with animated idle states.  The female version currently has a workable private beta, but requires a bit more touching up visually before I put the version with animated idle states live for player usage.</li>
	<li>Cleaned up the text in the character creation process for Aquatians.  The new character creation process will obsolete the stodgy process being used now, but until then a bit of readability for new players will probably be helpful.</li>
	<li>Updated the Aquatian placeholder text for race description during character creation to be a bit more accurate.</li>
	<li>Added in energy gains for meditating while obtaining intelligence at a coefficient of .001.</li>
	<li>Increased the meditation energy gain coefficient from .001 to .002. </li>
	<li>At the request of the hosts, i'm releasing part of this update early.  As a result, I am splitting the content of the update into 3 parts.</li>
	<li>Changed low type Beastmen's KO BP bonus to 10 from 3.</li>
	<li>Changed normal type Beastmen's KO BP bonus to 10 from 5.</li>
	<li>Altered the coefficient for blast energy gains from .001 to .004.</li>
	<li>Altered the coefficient for sparring energy gains from .004 to .009.</li>
	<li>Altered the coefficient for flying energy gains from .004 to .009.</li>
	<li>Altered the coefficient for absorbing maximum energy from people with higher maximum energy from .002 to .005.</li>


	<br><br>
<b>Xenosphere V.03158</b><br>
	<li>Increased Celestial endurance mods across the board by .2.</li>
	<li>Fixed a bug with reincarnate that was allowing people to avoid death.</li>

	<br><br>
<b>Xenosphere V.03157</b><br>
	<li>Redid the reincarnation formula for intelligence so that there is a 1:1 ratio for same race transitions, and appropriate decreases or additions in required XP for other races.</li>
	<li>Added a stand in var to fix another null.var error that was occurring on knockbacks.</li>
	<li>Added a stand in var to fix another null.var error that was occurring on attempting to scan for players.</li>
	<li>Fixed yet another null.var error being caused by Byond.  This one fixes power control.  This represents the last known bug on that front.</li>
	<li>Fixed a null.var error being caused by Byond.  This one was linked to gravity machinery, and will ensure that they can be run without crashing the core statistics processes.</li>
	<li>Removed a src.var reference in power drain, that was sometimes causing crashes.</li>
	<li>Fixed a bug that could temporarily halt gains.</li>
	<li>Added in a weather system.</li>
	<li>Fixed a bug (again) with Matter Absorption being chooseable multiple times in custom character creation.  This was not intended, and could lead to characters wasting trait points.</li>
	<li>Vastly reduced the amount of formulas used for stats being tracked by the dynamic content balancing code.  This should reduce the CPU load for weaker computers.</li>
	<li>Added a new variable to handle the assignment, collection, and calculation of the active playerbase's combined stat progression.  This stat was applied to every NPC, and may require some minor tweaking in terms of balance.</li>
	<li>Altered when the dynamic content balancing code triggers, making it trigger every twenty five minutes, as opposed to every time a NPC spawns.  This should reduce the CPU load for weaker computers.</li>
	<li>Made optimizations to reduce the CPU load within the combat system.</li>
	<li>Increased the cooldown when hitting a bag to be equal to a normal attack.</li>
	<li>Made some optimizations to various background processes to lower the CPU requirements of hosting.</li>
	<li>Rebalanced the gains of multiple NPC's.</li>
	<li>Rebalanced the stat distribution of several high tier NPC's to make them more of a challenge.</li><br><br>
<b>Xenosphere V.03156</b><br>
	<li>Added in a small prototype mini dungeon on Earth.  This area contains mid tier mobs, and while currently unfinished will most likely serve as a testing bed for other features such as loot lists, bosses, NPC's using skills, controllable areas, and recruitable NPC's.</li>
	<li>Tweaked the gains of several mobs.  Several mobs had gains beyond their intended amounts.  This has been fixed.</li>
	<li>Added a new mob to the game.  This variant of bandit is stronger than the base type, scales, has its own unique clothing, and often attacks in much larger numbers.</li>
	<li>Tweaked the time to recalculate NPC Power after a reboot.  This should help ensure that NPC's are more challenging for "first in" players, making it harder to game the system.</li>
	<li>Added a penalty to reincarnation.  This is to offset the increased gains and remove an exploit.  It also gives benefits to not reincarnating.</li>
	<li>Added in a new "wish" type item, which can be crated by technicians.  This item is one of the higher end rewards from the yet to be implemented "Occult" tech tree.</li>
	<li>Added in a new "teleporter" type item.  It allows players to punch a hole through to the Afterlife and vice versa.  Anchoring two points can lead to a permanent route until one anchor is destroyed.</li>
	<li>Added in the framework for a NPC "uniform generator".  This system allows the game to create unique outfits for NPC's dependent on their profession and race while also randomizing each NPC so they they remain visually unique while following their profession's "theme".</li>
	<li>The current bandit NPC's are currently drawing from a (deliberately limited) testing list of clothing items, allowing them to look like human players.</li>
	<li>Added in a new NPC only piece of gear.  The goggles will be available as a rare drop off of Red Reaver bandits in one of the next updates.  This is to test the loot list system.</li><br><br>
<b>Xenosphere V.03155</b><br>
	<li>Added in new prototype respawn mechanics.</li>
	<li>Finished up the second part of the code that allows for faction NPC armies.  This is demonstrated on the new humanoid mob that was implemented this wipe.</li>
	<li>NPC AI type areas now have proper layering to allow for accurate weather effects.</li>
	<li>Updated the frontloaded blast on nukes to hit past walls that it can destroy.  This keeps it from deleting on contact with a wall it can destroy.</li>
	<li>Updated the planet destruction event.  It now contains updated special effects.</li>
	<li>Tweaked the Shade's stats..</li>
	<li>Decreased the overall time to activation for NPC's that are currently idling.</li>
	<li>Fixed a bug that was keeping the destruction of planets from firing properly.</li>
	<li>Added new graphics for a NPC type.</li><br><br>

<b>Xenosphere V.03154</b><br>
	<li>Changed the atmosphere of the ice planet to match the weather around the Aquatian spawn.</li>
	<li>Fixed the null.var bugs.</li>
	<li><b>Changed the way training works</b>.  Sparring with training NPC's or PC's now gives 2x gains.  Hunting NPC's now gives anywhere from 3x gains to 20x gains depending on the strength of the mob.</li>
	<li><b>NPC's now scale in power</b>.  Many NPC's now scale in relative power to the playerbase's average strength.  The scaling is dynamic.  For instance, a bandit might always be very weak compared to even new players.  However, a high level mob could be equivalent to the upper tiers of the stat and BP ranks.</li>
	<li>Added a new savable file.  NPCPower is now used to calculate the strength of NPC's, drones, and some weaponry and armor.  It is loaded on start up to calculate the initial spawn power for NPC's.</li>
	<li>Updated several craftable item icons.</li>
	<li>Added 122 new icons to the game, as part of the continuing icon update.  This places us at around 144 icons implemented out of the roughly 1000 new icons to be implemented.</li>
	<li>Removed shades from the desert region on Earth.  Shades are a top tier mob with equivalent top tier gains for killing them, however, with NPC's now having scaling power their overall power level is a bit beyond the average starting player on that planet.</li>
	<li>Added a large spawn of bandits at the desert region on Earth.  These mobs always have low BP by default, no matter what the average power of a wipe is.  This allows new characters to always be able to fight them for quick gains.</li>
	<li>Added a rare spawn of gremlins to the desert region on Earth.  These mobs have low BP by default, letting new players always be able to hunt them for early gains.</li>
	<li>Added a  new area to the IP, redoing the Aquatian spawn and adding an overlook to the island.</li>
	<li>Fixed a bug that could sometimes cause rare items to not be saved on shutdown.</li><br><br>


<b>Xenosphere V.03153</b><br>
	<li>Added a prototype of the Contacts system for public testing.  The Contacts features functions as both a friends and enemies list for IC characters, and has some minor hidden gameplay features.</li>
	<li>Added the ability for admins to silently message the game world for communication and story telling purposes.  This is available to any admin with beyond the probationary rank, and is titled "world narrate" in the commands.</li>
	<li>Fixed a bug with the new build code that was causing doors to spawn every reboot.</li>
	<li>Merry Christmas!  Added in roughly twenty new icons out of a range of almost 1000 at most.  These icons are part of a large number of assets I paid for the commercial rights too.  Further updates (Taking place immediately after this one.) will include more of the 1000 or so new icons as I convert them into a usable dmi. compatible format.</li>
	<li>Fixed a LARGE number of Byond-side null.var bugs.</li>
	<li>Resisted the urge to begin drinking heavily upon realizing how extensive the null.var bug was prior to the aforementioned fixes.</li><br><br>

<b>Xenosphere V.03152</b><br>
	<li>Fixed a typo in Fusion referencing a skill that no longer exists.</li>
	<li>Added an ASSERT(src.Str) call in the Stat Rank code.  May catch the last remaining null.var error.</li>
	<li>Removed a src.(var) call in the core stat code.</li>
	<li>Removed a src.(var) call in swimming for androids and demons.  The null.var Byond bug could chain outwards through other processes into causing fairly large stat gain issues if they attempted to enter any fluids.</li>
	<li>Temporarily removed a src.(var) call in Beastman character creation.  The null.var Byond bug was preventing Beastmen from making their characters properly.</li>
	<li>More fixes for a Byond-side error that hasn't been fixed on their end yet.</li><br><br>
<b>Xenosphere V.03151</b><br>
	<li>More fixes for a Byond-side error that hasn't been fixed on their end yet.</li>
	<li>Gave (un needed, but possibly useful in this case) definitions to a large number of variables classed under the var file in the hopes of preventing other runtime errors.</li>
	<li>Fixed a godawful number of runtime errors brought on by a bug with Byond.</li>
	<li>Fixed a divide by zero runtime error that could rarely crop up in the stat ranks.</li>
	<li>Fixed a bug that was causing people to intermittently not gain.</li>
	<li>Fixed a bug that had logs outputting as much gains as sparring did.</li>
	<li>Prototype death mechanics have been added.  The current prototype allows you to choose to reincarnate upon death, or continue to the afterlife.  As it is very new, some bugs may apply in this specific version.</li>
	<br><br>

<b>Xenosphere V.0315</b><br>
	<li>Aquatians are now immune to cold based damage</li>
	<li>World Narrate can now be used to narrate IC events in world without applying a name to the post.</li>
	<li>Fixed a bug that was causing periodic lag spikes.</li>
	<li>Demons no longer take damage or can die from lava.</li>
	<li>Demons no longer lose energy in lava.</li>
	<li>Aquatians can now breathe in water.</li>
	<li>Aquatians will no longer lose energy while in water.</li>
	<li>The ice planet now has weather effects reflecting it's dangerous climate.</li>
	<br><br>

<b>Xenosphere V.0314</b><br>
	<li>Holding items preventing you from drowning now fixed</li>
	<li>Don't piss in the pool kids. (KO bug now fixed)</li>
	<li>Added the 'Watch' command to Who for admins, as per requested by admins =)</li>
	<li>Added a sanity check in the statrank proc. Nothing the players will notice but hopefully deal with admin fuckups a bit.</li>
	<li>Changed how items are saved on the server.</li>
	<li>Changed how drills work in the background.</li>
	<li>Doubled the rate gravity mastery is gained.</li>
	<li>Slightly increased the BP gains from gravity training under gravity.</li>
	<li>Fixed a bug with absorb that was giving more power to the absorber than it should have.</li>
	<li>Increased the max craftable weight of materialize to the equivalent of a user's maximum energy.  Materialize previously capped out at previously half of a user's max energy.</li>
	<li>Added a new selection of learnable skills to several races.</li>
	<li>Lowered the energy requirements of almost every skill for every race, to reflect the current energy gain system.</li>
	<li>Added five new skills to the Celestial race.  These skills are Materialize, Fusion, Heal, Reincarnate (Rare), and an alternate form of revival that does not have any chance to kill the user (Very Rare.).</li>
	<li>The skill requirements for a Demon to learn imitate have changed so that it only requires five hundred energy to obtain.</li>
	<li>Imitate is now a "common" skill for Demons.  Every Demon has it as part of their learnable skill tree by default.</li>
	<br><br>

<b>Xenosphere V.0313 (Full)</b><br>
	<li>Removed a few debug verbs that did not belong in the player selection of verbs.</li>
	<li>Added a basic variant sidewalk tile for modern day environments.</li>
	<li>Added six damaged and cracked variants for sidewalk tiling.</li>
	<li>Added the basic variant street tile for modern day environments.</li>
	<li>Added a very large number of road markings and other similar objects for detailing streets and other locations.</li>
	<li>Added a new modern door type.  Glass doors fit especially well with the roof and modern door set in the next update.</li>
	<li>Added five new wall types.  These can be used by players to make modern buildings, and by admins to create modern skyscrapers and similar buildings with modeled interiors buildings using warpers.</li>
	<li>Added four new edge types.  These can be used to do the edges for various building types, or as makeshift "walls" similar to fences and the like.</li>
	<li>Added one new sign type.  The mailbox is a modern day variant to existing signs, and can be mounted on any tile.</li>
	<li>Added five new fence types.  Chain link fences can now be produced.</li>
	<li>Added three variants of traffic lights.  These can be mounted on any tile for visual effect.  The new version will include poles to place them on streets for extra decorative purposes.</li>
	<li>Added three new debris icons under the misc type tab.  These go well with destroyed or run down areas.</li>
	<li>Added two new fire types under the heatsource tab.</li>
	<li>Added two barrels from the basic variant.  The basic variant has both a normal and on fire version.  Lit barrels are located in the heat source tab.</li>
	<li>Added four damage overlays for all environments to the misc tab of props.  These have no density, and can be placed just about anywhere.</li>
	<li>A number of icons were held back in this update so as to facilitate getting it to the hosts on time.  The next update should include these icons, and possibly the various variant tilesets with them.</li>
<br><br>
<b>Xenosphere V.0312 - Test Build (Version 5)-</b><br>
	<li>Give Power can no longer be used to stack the extra recovery it gives you. (Thanks Burgle)</li>
	<li>Extra power is no longer retained when knocked out. (Thanks Burgle)</li>
	<li>Subcategories should now always load properly.</li>
	<li>The new build system has been adjusted to improve speed, will require feedback for possible further tweaking/adjusting.</li>
	<li>The Build verb has been removed and replaced with a panel that's integrated into a skin. A new window will no longer pop up.</li>
	<li>Admin help's spam filter has been adjusted.</li>
	<li>The Androidship is automagically spawned if it doesn't exist.</li>
	<li>Window focus defaults back to the map window when you select something in the build menu.</li>
	<li>Fixed a long standing issue with the admin and who panel where admins sometimes couldn't properly access player menus.</li>
	<li>The build menu was moved to a new window and sorted by category.</li>
	<li>The admin editing system has been changed using GhostAnime's library.</li>
	<li>Changed the way objects save, causing the map to load and save faster.</li>
</ul>

"}

var/New_Stuff={"

<html><head>
<title></title>

<meta name="save" content="history" />

<style type="text/css"><!--
.save{
   behavior:url(#default#savehistory);}
a.dsphead{
   text-decoration:none;
   color:white;
   margin-left:1.5em;}
a.dsphead:hover{
   text-decoration:underline;}
a.dsphead span.dspchar{
   font-family:monospace;
   font-weight:normal;}
.dspcont{
   display:none;
   color:white;
   margin-left:1.5em;}
//--></style>


<script><!--
function dsp(loc){
   if(document.getElementById){
      var foc=loc.firstChild;
      foc=loc.firstChild.innerHTML?
         loc.firstChild:
         loc.firstChild.nextSibling;
      foc.innerHTML=foc.innerHTML=='+'?'-':'+';
      foc=loc.parentNode.nextSibling.style?
         loc.parentNode.nextSibling:
         loc.parentNode.nextSibling.nextSibling;
      foc.style.display=foc.style.display=='block'?'none':'block';}}


//--></script>

<noscript>
<style type="text/css"><!--
.dspcont{display:block;}
//--></style>
</noscript>

</head><body bgcolor="#000000"><font size=3 color="#FFFFFF">

<b><u>We're now in Beta!</u></b>
<hr>
<p>
We are always improving the game. If you find any bugs, dont hesitate to let us know either via the forums or the Report function.<br>
Note to admins: Edit no longer requires you to be near an object.
</p></font>
<hr>

<div class="save">

<h1><a href="javascript:void(0)" class="dsphead"
   onclick="dsp(this)">
   <span class="dspchar">+</span>Recent Updates</a></h1>
   <div class="dspcont">[Recent_Updates]</div>

<h1><a href="javascript:void(0)" class="dsphead"
   onclick="dsp(this)">
   <span class="dspchar">+</span>Changelog</a></h1>
      <div class="dspcont">



   </div>
</div>

</body></html>
"}

var/Version_Notes={"<html><head><body><body bgcolor="#000000"><font size=1><font color="#FFFFFF">
"}

var/mob/WritingUpdates


proc/SaveLogin()
	var/savefile/S=new("Login Menu")
	S["VERSION"]<<Version_Notes
proc/LoadLogin() if(fexists("Login Menu"))
	var/savefile/S=new("Login Menu")
	S["VERSION"]>>Version_Notes
/*mob/verb/DB_BPs()
	set category="Other"
	usr<<browse(Battle_Powers,"window= ;size=700x600")
var/Battle_Powers={"<html><head><body><body bgcolor="#000000"><font size=1><font color="#CCCCCC">

These are the battle powers throughout the dragon ball chronology, as they would be if it had
happened within Finale. They are not all that different from the actual amounts, within reason. The
term "Max" refers to when their anger kicks in, and they hit the limit of their power.
<br><br>

Pre-Dragon Ball<br>
Bardock's Team in Oozaru = 40'000 to 60'000<br>
Bardock (base 300) = 6'000<br>
Toma (base 275) = 5'500<br>
Celipa (base 250) = 5'000<br>
Totepo (base 225) = 4'500<br>
Panboukin (base 200) = 4'000<br>
Tooro - Kanassan Warrior (base 200) = 4'000<br>
Tooro Limit Breaker = 8'000<br>
Bardock recovered from Kanassa (base 500) = 9'000<br>
Nappa (base 220, age 30) = 4'400<br>
Prince Vegeta (base 600, age 6) = 6'000<br>
Saibaman = 1'000 to 1'500 each<br>
Average Saiyan (100 base) = 2'000<br>
Alien Henchmen on Vegeta = 1'000 to 5'000<br>
Alien Henchmen from other planets = 5'000 to 20'000<br>
King Vegeta = 16'000<br>
Bardock angry from seeing his friends dead = 13'500<br>
Dodoria's Elite Squad = 5'000 to 7'000<br>
Dodoria = 18'000<br>
Zarbon = 20'000<br>
Frieza = 530'000<br>
Goku (2 base, age 1) = 2<br>
Paragus (40 base) = 800<br>
Broly (10'000 base, age 1) = 10'000<br>
<br>

Dragon Ball Beginning<br>
Grandpa Gohan (base 15, body 50%, age 55) = 150<br>
Goku (base 6, age 11) = 82<br>
Bear Bandit = 30<br>
Pterodactyl = 50<br>
Average Human = 20<br>
Average Human Fighter = 40<br>
Yamcha (base 4, age 15) = 60<br>
Roshi (base 29, body 20%) = 116<br>
Roshi 4x Expand = 232<br>
Roshi 5x Kamehameha 100% Mastered = 1'160 (Blew up a mountain)<br>
Goku 1x Kamehameha 10% Mastered = 9 (Dints a car lol)<br>
Krillan (base 4, age 12) = 48<br>
Tyrannosaurus = 160 to 200<br>
<br>

21st Budokai<br>
Goku (base 10, age 12) = 150<br>
Krillan (7 base, age 13) = 91<br>
Yamcha (5 base, age 16) = 80<br>
Bacterian = 20<br>
Ran Fuan = 30<br>
Namu = 100<br>
Giran = 130<br>
Namu Max = 150<br>
Krillan Max = 137<br>
Jackie Chun (base 30, body 20%) = 120<br>
Goku 3x Kamehameha 50% Mastered = 225<br>
Jackie Chun 2x Kamehameha = 240
Goku Max = 300<br>
Jackie Chun Max = 180<br>
Goku Oozaru = 3'000<br>
Jackie Chun x4 Expand = 360<br>
Jackie Chun 10x Kamehameha = 3'600 (Blows up the moon apparently)<br>
<br>

After recovering from the 21st Budokai<br>
Goku = 165<br>
Krillan = 93<br>
Yamcha = 82<br>
<br>

Red Ribbon Army<br>
Goku (base 11, age 12) = 165<br>
Seargent Metallic = 100<br>
Ninja Murasaki = 90<br>
Android 8 = 140<br>
Gum = 200<br>
Goku x4 Kamehameha 60% Mastered = 396<br>
Krillan after training with Roshi another month or two (9 base, age 13) = 117
General Blue = 140<br>
Pirate Robot = 140<br>
Mercenary Tao = 170<br>
Korin = 200<br>
Goku after Korin's "training", most of his new power is zenkai from getting his ass kicked by
Tao (base 12, age 12) = 180<br>
Goku Max = 360<br>
Yadjirobe = 150<br>
<br>

Baba Tournament<br>
Krillan after another Roshi training session (10 base, age 14) = 140
Goku (13 base, age 13) = 212<br>
Master Roshi (base 35, 20% body) = 140<br>
Yamcha after Roshi's training (9 base, age 17) = 153<br>
Devil Man = 115<br>
Mummy = 100<br>
Invisible Man = 70<br>
Dracula Man = 60<br>
Grandpa Gohan (16 base, 50% body) = 160<br>
Grandpa Gohan x3 Kamehameha = 480<br>
Goku x3 Kamehameha 75% Mastered = 477<br>
Goku Max = 424<br>
Grandpa Gohan Max = 240<br>
<br>

22nd Budokai<br>
Goku = 220<br>
Tien = 220<br>
Choutzu = 120 (Great skill masteries though)<br>
King Chapa = 110<br>
Tien theoretically without 3rd eye = 170
Yamcha = 159<br>
Krillan = 145<br>
Krillan x1 Kamehameha 50% Mastered = 73<br>
Yamcha x2 Kamehameha 70% Mastered = 223<br>
Tien's Ki Deflection Barrier = 330<br>
Tsurusennin (Crane Hermit) = 128<br>
Jackie Chun (36 base) = 144<br>
Jackie Chun x1 Expand = 173<br>
Tien x1 Kamehameha 20% Mastered = 44 (Roshi deflects it easily, but is surprised that Tien picked it
up so fast)<br>
Tien Dodompa = 330<br>
Tien Kikoho = 1'100<br>
Goku x4 Kamehameha 80% Mastered = 704<br>
Goku Max = 440<br>
<br>

King Piccolo<br>
Goku exhausted = 100<br>
Tien exhausted = 100<br>
Yamcha = 160<br>
Krillan 146<br>
Yadjirobe = 170<br>
Tambourine = 170<br>
King Piccolo (70% body) = 238<br>
Cymbal = 150<br>
Tien recovered, mastery of demon containment technique = 222<br>
Goku recovered = 260<br>
King Piccolo +20% = 286<br>
Drum = 240<br>
Goku sacred water = 270 (sacred water in here gives more endurance than anything)<br>
King Piccolo (100% body) = 340<br>
King Piccolo Demon Ray = 510 each<br>
Goku x3 Kamehameha 80% Mastered = 648<br>
Goku Max = 540<br>
<br>

23rd Budokai<br>
Goku with weights (base 25, age 16) = 330
Tien (base 15, age 20) = 300<br>
Choutzu (base 9) = 180<br>
Yamcha (base 12, age 20) = 240<br>
Krillan (base 13, age 17) = 221<br>
Chichi (base 10, age 17) = 170<br>
Roshi (37 base, 20% body) = 148<br>
Goku = 500<br>
Piccolo with weights (base 34, 75% body because a namek isn't fully grown til age 4) = 255<br>
Krillan Max = 332<br>
Krillan x3 Kamehameha 80% Mastered = 797<br>
Piccolo = 510<br>
Goku x4 "Super" Kamehameha 100% Mastered = 2'000<br>
Goku Max, half health = 500<br>
Piccolo 80% Health = 408<br>
Goku's final attack, energy colission = 2'000<br>
<br>

Raditz - 5 years later<br>
Goku with weights (base 30, age 21) = 400<br>
Piccolo with weights (base 40) = 400<br>
Gohan (base 56, age 4) = 224, Gohan is apparently packaged <_< Only way to explain him having more
base than his father after he was born<br>
Raditz = 1'200<br>
Goku without weights = 600<br>
Piccolo without weights = 800<br>
Goku x2 Kamehameha = 1'200<br>
Gohan Max = 1'120<br>
Raditz Max = 1'800<br>
Piccolo +50% = 1'200<br>
Piccolo x5 Piercer = 6'000<br>
<br>

After Raditz<br>
Goku dead (base 40) = 800<br>
Tien (base 20, age 25) = 520 (30% more from 3rd eye, as usual, just listed different here)<br>
Yamcha (base 20, age 25) = 400<br>
Krillan (base 20, age 22) = 400<br>
Choutzu (base 14) = 280<br>
Yadjirobe (base 12) = 240<br>
<br>

One Year Later<br>
Krillan, Choutzu, Yamcha, Tien, and Yadjirobe benefitted from the time room and using weights during
their training, thus they improved immensely unlike ever before. Goku, through a combination of his
weights, mastering kaioken, mastering gravity, and mastering genki dama, also improved at a more
rapid pace than ever before. Piccolo always trains with weights of course, and Gohan has a huge bp
mod for an unascended race, so he also improved greatly through survival training and Piccolo's
teachings.<br>
Choutzu (base 42) = 840<br>
Krillan (base 60, age 23) = 1'200<br>
Yamcha (base 60, age 26) = 1'200 (It would not be unusual for two grown humans who spar together
often without outside interference to be the exact bp as each other, due to the weaker one always
gaining twice as much from the spars it would keep it even if one falls behind even in the
slightest.<br>
Tien (base 60, age 26) = 1'560<br>
Gohan (base 200, age 5) = 1'000<br>
Piccolo (base 100) = 2'000<br>
Saibamen = 1'200<br>
Krillan +20%, Angry from Yamcha's death = 2'160<br>
Krillan's Large Ki Ball = 10'800<br>
Large Ki Ball divided into 5 homing shots = 2'160 each<br>
Nappa (base 400, age 51, 50% body) = 4'000<br>
Nappa +10% = 4'400
Choutzu Self Destruct = 8'400 (I guess Nappa must have had great resistance to survive this?)
Krillan's Kienzan = 9'000<br>
Tien +40%, but half health due to only having 1 arm = 5'460<br>
Gohan Max = 5'000<br>
Gohan x4 Masenko 50% Mastered = 10'000<br>
Nappa Max = 6'000<br>
Goku (base 200, body age 21, age 22) = 4'000<br>
Goku Kaioken = 8'000<br>
Goku Kaioken x2 = 12'000 (I don't remember if he used x2 on Nappa or not but here it is anyway)<br>
Vegeta (900 base, age 27) = 18'000<br>
Goku Kaioken x2 Max = 24'000<br>
Vegeta Max = 22'500<br>
Gohan Oozaru, 80% health = 40'000<br>
Vegeta Oozaru, 80% health = 180'000<br>
Goku Kaioken x3 Max = 32'000<br>
Goku Kaioken x3 Max, x5 Kamehameha = 160'000<br>
Vegeta Max x7 Galic Gun = 157'500 (So close it'd be a stalemate for a long time)<br>
Goku Kaioken x4 Max, x5 Kamehameha = 200'000<br>
Goku Kaioken x4 Max, 20% Health = 8'000
Vegeta Max, 50% Health = 11'000
Goku's Small Genki Dama = 40'000<br>
<br>

Arrival on Namek<br>
Krillan (110 base, age 24) = 2'200<br>
Gohan (450 base, age 6) = 2'700<br>
Alien Henchmen = 1'500 (Unskilled and badly trained by comparison as well)<br>
Vegeta (base 1400, age 28) = 28'000 (nearly all of his new power is zenkai from the toughest fight
of his life with Goku)<br>
Kui = 14'000<br>
Dodoria = 18'000<br>
Zarbon = 20'000<br>
Zarbon x2 Expand = 29'000<br>
Vegeta Max +10% = 37'000<br>
<br>

That same time, on King Kai's planet...<br>
Through a combination of the experience with the saiyans, maxed out zenkai from dying, gravity
mastery, much sparring, they have all improved quite more than Krillan and Gohan have having
survived the battle with the Saiyans<br>
Choutzu (140 base) = 2'800<br>
Yamcha (190 base, age 26) = 3'800<br>
Tien (190 base, age 26) = 3'800<br>
Piccolo (350 base) = 7'000<br>
<br>

And, that same time, as Goku has finished most of his training in space<br>
By mastering 100x gravity, and kaioken x20, and from the zenkai he recieved from battling Vegeta,
he has improved immensely.<br>
Goku (1'000 base, age 22) = 20'000<br>
Goku Kaioken x10 = 420'000<br>
<br>

Ginyu Force<br>
Krillan Potential Unlocked (1'200 base, age 24) = 24'000<br>
Gohan Potential Unlocked (3'000 base, age 6) = 18'000<br>
Vegeta (1'800 base, age 28) = 36'000<br>
Guldo = 20'000<br>
Burter = 30'000<br>
Jeice = 32'000<br>
Recoome = 44'000<br>
Vegeta Max = 45'000<br>
Recoome Max = 66'000<br>
Goku (1'000 base, age 22) = 20'000<br>
Goku Kaioken x5 = 220'000 (Ginyu's scouter broke, but its last reading was 180'000)<br>
Ginyu = 40'000<br>
Ginyu Max = 60'000<br>
Ginyu in Goku's Body = 20'000, and with none of Goku's skills.<br>
<br>

Frieza<br>
Krillan (1'300 base, age 24) = 26'000<br>
Gohan (3'500 base, age 6) = 21'000<br>
Vegeta (3'000 base, age 28) = 60'000<br>
Vegeta +20% = 72'000<br>
Vegeta Max = 90'000<br>
Frieza = 530'000<br>
Frieza Form 2 = 1'000'000<br>
<br>

Piccolo fuses with Nail<br>
Nail = 40'000<br>
Piccolo (500 base) = 10'000<br>
Piccolo fused with Nail (30'500 base) = 610'000<br>
Piccolo +40% = 854'000<br>
Frieza Form 3 = 2'000'000<br>
Gohan Max = 105'000<br>
<br>

Goku recovers and heads to the battle<br>
Frieza Final Form 50% Power = 4'000'000
Goku, zenkai maxed once again (1'500 base, age 22) = 30'000
Goku Kaioken x10 = 430'000<br>
Goku Kaioken x10 Max = 860'000<br>
Goku Kaioken x20 Max = 1'660'000<br>
Goku Kaioken x20 Max, x3 Kamehameha = 4'980'000<br>
Frieza 75% Power = 6'000'000<br>
Goku's Large Genki Dama = 24'900'000<br>
Frieza 100% Power = 8'000'000 (Frieza could possibly survive a spirit bomb of that power, since a
Changeling's resistance mod is extremely high)<br>
Super Saiyan Goku = 10'000'000<br>
Frieza x2 Expand Angry = 13'200'000<br>
Super Saiyan Goku Angry = 20'000'000<br>
<br>

One Year Later<br>
Choutzu (3'800 base) = 76'000<br>
Yamcha (5'500 base, age 27) = 110'000<br>
Tien (5'500 base, age 27) = 143'000<br>
Krillan (6'000 base, age 25) = 120'000<br>
Gohan (20'000 base, age 7) = 140'000<br>
Piccolo (41'000 base) = 820'000<br>
Vegeta (16'000 base, age 29) = 320'000<br>
Frieza = 10'000'000<br>
King Kold Expand x1 = 10'000'000<br>
Trunks (200'000 base, age 16) = 4'000'000<br>
Trunks +25% = 5'000'000<br>
Super Saiyan Trunks = 17'000'000<br>
Super Saiyan Trunks +25% = 21'250'000<br>
Goku (400'000 base, age 23) = 8'000'000<br>
Super Saiyan Goku = 20'000'000<br>
Super Saiyan Goku +25% = 25'000'000<br>
<br>

3 Years Later<br>
Humans are falling behind by a lot now, as the Saiyans have already ascended, and Piccolo, and Gohan
will sometime soon.<br>
Choutzu (11'000 base) = 220'000<br>
Yamcha (16'000 base, age 30) = 320'000<br>
Tien (16'000 base, age 30) = 416'000<br>
Krillan (16'000 base, age 28) = 320'000<br>
Gohan (70'000 base, age 10) = 700'000<br>
Piccolo (500'000 base) = 10'000'000<br>
Vegeta (1'000'000 base, age 32) = 20'000'000<br>
Trunks (400'000 base, age 17) = 8'000'000<br>
Goku (900'000 base, age 26) = 18'000'000<br>
Android 19 = 20'000'000<br>
Android 20 = 8'000'000<br>
SSj Goku (Before the sickness) = 32'500'000<br>
SSj Vegeta = 37'500'000<br>
SSj Vegeta Max (If it had restored his health) = 47'000'000<br>
Android 18 = 40'000'000 (17 & 18 have the stats of a human, so they are more dangerous than their bp tells)<br>
SSj Trunks = 23'000'000<br>
SSj Trunks Max = 34'500'000<br>
<br>

Imperfect Cell<br>
Piccolo (2'000'000) = 40'000'000<br>
Piccolo +25% = 50'000'000<br>
Imperfect Cell = 25'000'000<br>
Android 17 = 40'000'000<br>
Piccolo +40% = 56'000'000<br>
Imperfect Cell Focused +40% = 52'500'000<br>
Android 16 = 60'000'000<br>
<br>

Perfect Cell<br>
Semiperfect Cell = 75'000'000<br>
Trunks (1'600'000 base, age 18) = 32'000'000<br>
Vegeta (2'250'000 base, age 33, 95% body) = 42'000'000<br>
SSj Trunks = 59'000'000<br>
SSj Vegeta = 65'000'000<br>
SSj Trunks Expand x2 = 85'000'000<br>
SSj Vegeta Expand x2 = 94'000'000<br>
Perfect Cell = 150'000'000<br>
SSj Vegeta Expand x3, 70% energy, Angry = 99'000'000<br>
SSj Trunks Expand x4 Max = 183'000'000 (Energy draining fast due to accelerated ssj drain
from using expand)<br>
Cell Expand x2 (Used it to show Trunks that it is futile to try and match him) = 225'000'000<br>
<br>

Cell Games<br>
Choutzu (21'000 base) = 420'000<br>
Yamcha (30'000 base, age 31, 97.5% body) = 585'000<br>
Krillan (30'000 base, age 29) = 600'000<br>
Tien (30'000 base, age 31, 97.5% body) = 760'500<br>
Trunks (1'700'000 base, age 18) = 34'000'000<br>
Vegeta, after entering the time room again (3'000'000 base, age 34, 90% body) = 54'000'000<br>
Gohan (2'000'000 base, age 11) = 22'000'000<br>
Goku (2'400'000 base, age 27) = 48'000'000<br>
SSj Gohan = 59'000'000<br>
SSj Goku = 70'000'000<br>
Android 16 Upgraded = 80'000'000<br>
Piccolo (4'000'000 base) = 80'000'000 (Sure Piccolo and Android 16 seem uber, but they have 0 anger.)<br>
Cell = 150'000'000<br>
<br>

Goku vs Cell<br>
SSj Goku = 70'000'000<br>
Cell = 150'000'000<br>
SSj Goku +50% = 105'000'000<br>
Cell +10% = 165'000'000<br>
Goku x2 Kamehameha = 210'000'000<br>
Cell x5 Kamehameha = 825'000'000<br>
SSj Goku Max, 80% energy = 168'000'000<br>
Cell Focused = 247'000'000<br>
SSj Goku Max, 60% energy = 126'000'000<br>
<br>

Gohan vs Cell<br>
SSj Gohan = 59'000'000<br>
Cell = 150'000'000<br>
SSj Gohan Angry = 295'000'000<br>
Super Saiyan 2 Gohan Max = 443'000'000<br>
Cell Juniors = 100'000'000 each<br>
Cell Focused = 225'000'000<br>
Cell Expand x4 = 300'000'000<br>
Semiperfect Cell = 75'000'000<br>
Semiperfect Cell's Self Destruct = 750'000'000<br>
<br>

Cell is seemingly defeated<br>
Super Saiyan 2 Gohan, 60% Energy = 265'000'000<br>
Cell Max +40% = 315'000'000<br>
SSj Trunks Expand x2 = 90'000'000 (Before Cell owned him)<br>
Cell x5 Kamehameha = 1'575'000'000<br>
Gohan x5 Kamehameha = 1'375'000'000<br>
Choutzu Max +100%, Focused = 1'890'000<br>
Yamcha Max +60%, Focused = 2'106'000<br>
Krillan Max +70%, Focused = 2'295'000<br>
Tien +70%, Focused = 1'940'000<br>
Piccolo +40%, Focused = 168'000'000<br>
SSj Vegeta x2 Expand Max Focused, 70% energy = 151'000'000<br>
Vegeta's Big Bang or whatever he used on Cell, x5 Charged = 755'000'000<br>
SSj Goku Max Focused +20%, 70% body due to being dead = 177'000'000<br>
Goku x5 Kamehameha = 885'000'000<br>
Goku and Gohan's Kamehameha's combined = 2'260'000'000<br>
<br>

1 Years Later<br>
Sometime during the last year, Tien was the first human to ascend. After the Satan Tournament,
Krillan gives up fighting to settle down with #18. Right after this point, Krillan ascends, but he
still gives up much training. Yamcha ascends sometime not long after that too. Human ascension
increases decline by 10 years as well.<br>
Choutzu (35'000 base) = 560'000<br>
Yamcha (50'000 base, age 32, 95% body) = 950'000<br>
Krillan (50'000 base, age 30) = 1'000'000<br>
Tien (1'500'000 base, age 32, 100% body) = 30'000'000<br>
Trunks (2'900'000 base, age 19) = 58'000'000<br>
Vegeta (3'600'000 base, age 35, 85% body) = 62'000'000<br>
Gohan (2'600'000 base, age 12) = 32'000'000<br>
Piccolo (6'000'000 base) = 120'000'000<br>
Goku (3'400'000 base, age 27) = 68'000'000<br>
<br>

7 Years after Cell<br>
Vegeta has not declined too much, due to luck and harder training, he has remained stable.<br>
Choutzu (800'000 base) = 16'000'000<br>
Yamcha (1'100'000 base, age 38) = 22'000'000<br>
Krillan (800'000 base, age 36) = 16'000'000<br>
Tien (2'500'000 base, age 38) = 50'000'000<br>
Vegeta (6'250'000 base, age 41, 85% body) = 107'000'000<br>
Gohan (2'700'000 base, age 18) = 49'000'000<br>
Goku (5'000'000 base, age 27) = 100'000'000<br>
Piccolo (10'000'000 base) = 200'000'000<br>
Goten (3'000'000 base, age 7) = 21'000'000<br>
Trunks (3'000'000 base, age 8) = 24'000'000<br>
<br>
SSj Goten = 37'000'000<br>
SSj Trunks = 47'000'000<br>
SSj Gohan = 113'000'000<br>
Dabura = 150'000'000<br>
SSj2 Gohan = 157'000'000<br>
SSj Vegeta = 147'000'000<br>
SSj2 Vegeta = 355'000'000<br>
Majin SSj2 Vegeta = 426'000'000<br>
SSj2 Goku = 320'000'000<br>
SSj2 Goku Max, 80% energy = 512'000'000<br>
Majin SSj2 Vegeta Max, 70% energy = 300'000'000<br>
Fat Buu = 500'000'000<br>
Super Saiyan 3 Goku = 528'000'000<br>
Super Buu = 550'000'000<br>
<br>

Gotenks<br>
Goten and Trunks enter the time chamber, and master SSj2, and fusion.<br>
Goten (4'000'000 base, age 7) = 28'000'000<br>
Trunks (4'000'000 base, age 8) = 32'000'000<br>
SSj Goten = 45'000'000<br>
SSj Trunks = 63'000'000<br>
SSj2 Goten = 140'000'000<br>
SSj2 Trunks = 161'000'000<br>
Gotenks = 301'000'000<br>
Super Gotenks = 362'000'000<br>
SSj3 Gotenks = 595'000'000<br>
SSj3 Gotenks Max = 715'000'000<br>
<br>

Mystic Gohan<br>
Gohan (3'500'000 base, age 18) = 63'000'000<br>
SSj2 Gohan = 192'000'000<br>
Mystic Gohan = 192'000'000<br>
Mystic Gohan +300% = 574'000'000<br>
Buu + Piccolo = 670'000'000<br>
Buu + Gotenks = 970'000'000<br>
Buu + Gohan = 1'040'000'000<br>
Buu - Gotenks = 740'000'000<br>
Buu + Goten + Trunks = 800'000'000<br>
Tien's Kikoho = 250'000'000<br>
<br>

Vegetto<br>
Vegeta is now at 70% body, due to being dead.<br>
Goku (5'000'000 base, age 27) = 100'000'000<br>
Vegeta (6'500'000 base, age 41, 70% body) = 91'000'000<br>
SSj2 Vegeta = 315'000'000<br>
SSj2 Goku = 320'000'000<br>
Vegetto = 860'000'000<br>
Super Vegetto = 1'032'000'000<br>
Super Vegetto +20% = 1'239'000'000<br>
Buu + Vegetto = 1'660'000'000<br>
<br>

End of Buu<br>
SSj2 Vegeta = 315'000'000<br>
SSj2 Goku = 320'000'000<br>
Majin Buu = 650'000'000<br>
SSj2 Vegeta Max = 394'000'000<br>
SSj2 Goku Max = 640'000'000<br>
SSj3 Goku Max = 1'056'000'000 (Drains down quite fast though)<br>
SSj3 Goku Max, 70% energy, x5 Kamehameha = 3'700'000'000 (He would need to generate like 6.5 billion to actually kill Majin Buu)<br>
SSj3 Goku Max, 50% energy = 528'000'000<br>
Goku Max, 50% energy, +50% Powerup = 150'000'000<br>
Goku's Large Genki Dama = 2'250'000'000<br>
Goku Max, +50% Powerup, Energy restored = 300'000'000<br>
Genki Dama adjusting to Goku's full power = 4'500'000'000<br>
SSj2 Goku Max, +50% Powerup, Energy restored = 960'000'000<br>
Genki Dama adjusted to Goku's SSj2 Power = 14'400'000'000<br>
<br>

5 Years Later<br>
Choutzu (2'200'000 base) = 44'000'000<br>
Yamcha (3'100'000 base, age 43, 92.5% body) = 57'350'000<br>
Krillan (2'500'000 base, age 41, 97.5% body) = 48'750'000<br>
Tien (5'500'000 base, age 43, 92.5% body) = 101'750'000<br>
Vegeta (7'000'000 base, age 46, 80% body) = 112'000'000<br>
Gohan (3'650'000 base, age 23) = 73'000'000<br>
Goku (5'500'000 base, age 32) = 110'000'000<br>
Piccolo (11'250'000 base) = 225'000'000<br>
Goten (4'100'000 base, age 12) = 49'200'000<br>
Trunks (4'300'000 base, age 13) = 55'900'000<br>
<br>

10 Years After Buu<br>
Choutzu (3'600'000 base) = 72'000'000<br>
Yamcha (5'100'000 base, age 48, 85% body) = 86'700'000<br>
Krillan (4'000'000 base, age 46, 85% body) = 68'000'000<br>
Tien (8'000'000 base, age 48, 85% body) = 136'000'000<br>
Vegeta (7'700'000 base, age 51, 60% body) = 92'400'000<br>
Gohan (3'800'000 base, age 28) = 76'000'000<br>
Goku (6'000'000 base, age 37) = 120'000'000<br>
Piccolo (12'500'000 base) = 250'000'000<br>
Goten (4'300'000 base, age 17) = 73'100'000<br>
Trunks (5'000'000 base, age 18) = 90'000'000<br>
Pan (4'000'000 base, age 9) = 36'000'000<br>
Uub (15'000'000 base, age 10) = 150'000'000 (If Majin Buu ("Kid" version or whatever), reincarnated,
this is what he would be. He would be a born ascended human. This includes death zenkai as well.)<br>
<br>

Goku vs Uub<br>
Goku = 120'000'000<br>
Uub = 150'000'000 (But at this point, far less skilled than Goku, in terms of Offense and Defense,
and actual abilities he has available to use in battle)<br>
Uub Max = 225'000'000<br>
Uub kicks Goku's ass down to the ground, everyone thinks Uub has won, but Goku busts out of the
ground powered up.<br>
Goku +50% = 180'000'000<br>
Goku then kicks Uubs ass, Uub is kicked to the edge of the ring, he then thinks about his tribe back
home, and how he promised he wouldn't lose, then to Goku's surprise he began to powerup just from
seeing Goku use it. Goku is knocked back just by the force of his increased power.<br>
Uub +60% = 360'000'000<br>
As Uub comes at him, Goku disappears into the sky, Uub is surprised that he can fly, and then, Goku
begins charging his Kamehameha <_<, but before Goku can fire it, the ring underneath Uub breaks and
Uub is about to fall to the ground, but Goku swoops down and grabs him before that can happen. And
flies off into the horizon grasping Uub by his arm, right then, Michael Jackson jumps over the
tournament walls, and yells "Damn, too late", then he starts moonwalking and everyone turns into
MJ clones and diarea shits themselves as Goku flies out of sight.<br>
<br>



<br><br>
2 Years Later<br>
Choutzu (4'300'000 base) = 72'000'000<br>
Yamcha (6'100'000 base, age 50, 80% body) = 97'600'000<br>
Krillan (4'500'000 base, age 48, 80% body) = 72'000'000<br>
Tien (9'200'000 base, age 50, 82.5% body) = 151'800'000<br>
Vegeta (9'000'000 base, age 53, 50% body) = 90'000'000<br>
Gohan (4'000'000 base, age 30) = 80'000'000<br>
Piccolo (15'000'000 base) = 300'000'000<br>
Goten (4'600'000 base, age 19) = 87'400'000<br>
Trunks (6'000'000 base, age 20) = 120'000'000<br>
Pan (5'000'000 base, age 11) = 55'000'000<br>
Goku (7'000'000 base, age 39) = 140'000'000<br>
Uub (17'000'000 base, age 12) = 204'000'000<br>
Goku Focused, +50% = 315'000'000<br>
Uub Focused, +70% = 520'000'000<br>
Goku x3 Kamehameha = 945'000'000<br>
Uub x3 Beam = 780'000'000<br>
<br>

If they went Super Saiyan at this time<br>
Goten = 120'000'000<br>
Vegeta = 125'000'000<br>
Gohan = 175'000'000<br>
Goku = 185'000'000<br>
Trunks = 191'000'000<br>
<br>

Super Saiyan 2<br>
Gohan = 234'000'000<br>
Goten = 290'000'000<br>
Vegeta = 313'000'000<br>
Trunks = 374'000'000<br>
Goku = 420'000'000<br>
<br>

Super Saiyan 3<br>
Super Saiyan 3 Goku = 693'000'000<br>
<br>

Max Form, Max Anger<br>
Choutzu Max = 90'000'000<br>
Yamcha Max = 147'000'000<br>
Krillan Max = 108'000'000<br>
Tien doesn't have anger in 3rd eye, but if he were to revert:<br>
Tien reverted = 117'000'000<br>
Tien Max = 176'000'000<br>
Pan Max = 275'000'000<br>
Piccolo Max = 315'000'000<br>
SSj2 Vegeta Max = 392'000'000<br>
SSj2 Goten Max = 435'000'000<br>
SSj2 Trunks Max = 561'000'000<br>
SSj2 Gohan Max = 1'160'000'000<br>
SSj3 Goku Max = 1'386'000'000<br>
Since Mystic Gohan would not have anger, I'll instead show what he would be at +300% powerup, since
he could easily hold that for quite a long time<br>
Mystic Gohan = 934'000'000<br>


http://www.tv.com/dragon-ball/show/4607/new-and-improved-power-level-list/topic/3205-1091809/msgs.html

"}*/