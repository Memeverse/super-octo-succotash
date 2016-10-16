
mob/verb/ReadLogin()
	set category="Other"
	src << browse(Version_Notes,"window=version;size=800x600")

var/mob/WritingNotes

mob/Admin1/verb/Notes()
	set category="Admin"
	usr<<browse(Notes,"window= ;size=700x600")

mob/Admin1/verb/EditNotes()
	set category="Admin"
	if(!WritingNotes)
		WritingNotes=src
		logAndAlertAdmins("[src.key] is editing the notes...",1)
		Notes=input(usr,"Edit!","Edit Notes",Notes) as message
		logAndAlertAdmins("[src.key] is done editing the notes...",1)
		WritingNotes=0
		SaveNotes()
	else usr<<"<b>Someone is already editing the notes.</b>"

proc/SaveNotes()
	var/savefile/S=new("Data/Notes.bdb")
	S["Notes"]<<Notes
proc/LoadNotes()
	if(fexists("Data/Notes.bdb"))
		var/savefile/S=new("Data/Notes.bdb")
		S["Notes"]>>Notes

	else if(fexists("Data/Notes"))
		var/savefile/S=new("Data/Notes")
		S["Notes"]>>Notes


var/Story={"<html>
<head><title>Story</title><body>
<center><body bgcolor="#000000"><font size=2><font color="#CCCCCC">



</body><html>"}
var/mob/WritingStory

mob/verb/Story()
	set category="Other"
	usr<<browse(Story,"window= ;size=700x600")

proc/SaveStory()
	var/savefile/S=new("Data/STORY.bdb")
	S["Storyline"]<<Story
proc/LoadStory()

	if(fexists("Data/STORY.bdb"))
		var/savefile/S=new("Data/STORY.bdb")
		S["Storyline"]>>Story

	else if(fexists("Data/STORY"))
		var/savefile/S=new("Data/STORY")
		S["Storyline"]>>Story

var/Rules={"<html>
<head><title>Rules</title><body>
<center><body bgcolor="#000000"><font size=2><font color="#CCCCCC">

Put rules here.

"}

var/mob/WritingRules

mob/verb/Rules()
	set category="Other"
	usr<<browse(Rules,"window= ;size=700x600")

proc/SaveRules()
	var/savefile/S=new("Data/Rules.bdb")
	S["Rules"]<<Rules
proc/LoadRules()

	if(fexists("Data/Rules.bdb"))
		var/savefile/S=new("Data/Rules.bdb")
		S["Rules"]>>Rules

	else if(fexists("Data/Rules"))
		var/savefile/S=new("Data/Rules")
		S["Rules"]>>Rules
var/Chronology={"
<html>
<head><title>Information</title><body><body bgcolor="black" text="#CCCCCC"><font size=2>
<center><B><H1></H1></B><p><H3><font size=2><b>

Note: GT is exluded from this history, events beyond Majin Buu have become an alternate
timeline.<br><br>

It is a decade since the world has been cleansed of the evil that was Majin Buu, the 37th Tenkaichi
Budokai is about to be held. Goku and the others enter, and Goku reveals why they have come there:
Goku claims that Majin Buu has been reincarnated into a pure human body, with his power intact, but
none of his evil. Of course that boy was Uub, and it soon becomes apparent that what Goku claims is
true, because Uub can keep up with Goku like no other Human would be capable of. Also Pan was there,
but neither are relevant. Long story short, Goku goes into seclusion with only Uub to begin
maximizing his power. Beyond this point is where the alternate timeline begins.<br><br>

Also I want to mention their ages as according to this timeline. The ages listed below are how old
they are a decade after Buu, and these are their physical ages, not actual ages, because Goku's
physical age for instance is much lower than his actual age because he has been Dead for long
periods of time.<br>
Vegeta: 50<br>
Tien: 48<br>
Yamcha: 48<br>
Krillan: 45<br>
Goku: 38<br>
Gohan: 28<br><br>

A decade later:<br>
Everything is going peacefully. Pan and Uub are grown up. All the original z-fighters except Gohan
are old as hell, even Gohan has been in decline for years because of his Halfie DNA. The only
original z-fighter that has even successfully maintained their top power is Goku due to his
constant effort. The only major people in this era are Goku, Uub, and Pan, the others are too
declined to really be in the same league as them. Gohan may be in a close second in power though,
even though he is far declined he still has the power of a Super Saiyan 2 Mystic at his disposal
<br><br>

Another decade later...<br>
I just thought this decade was relevant because at this point not even Goku could maintain
the power he once had, and by this point Pan and Uub are the only major people in terms of power.
But, even though its 20 years after Buu, there has been no earth-threatening events. Also its not
far from this time, that Vegeta dies, just so you know.<br><br>

Not many years later there is a massive explosion that destroys the north quadrant of the galaxy
completely. This explosion is not caused by a person, but is more similar to the
supposed "big bang" that started the universe as scientists know it today, except on a smaller
galactic scale. Unknown to anyone though, the trigger for this this was an instability between two
dimensions, which was actually caused by Majin Buu when he somehow used his power to open a
dimensional portal between the room of spirit and time and kami's tower, this caused a irrepairable
break in spacetime which began to expand in the room of spirit and time, until it reached critical
mass and became a singularity in both dimensions, destroying the north quadrant of the galaxy, but
also destroying an equally large chunk of the supposedly infinite space inside the room of time. It
looks like Majin Buu did win in a way, in the long run.<br><br>

The singularity of course took the form of a super-massive black hole in the north quadrant, which
had the gravitational pull of hundreds of thousands of billions of suns and began to affect the
other quadrants of the galaxy. A resident of one of the remaining quadrants who had the knowledge
solved this problem before it was too late, it is unknown exactly -how- they restored the damage,
but it seems like a similar method to the Dragon Balls, except whatever method they used it was
thousands of times more powerful than the Dragon Balls. Thanks to these people the North Quadrant
 was somehow restored, and the black hole somehow disappeared. All planets that had -ever-
 existed in the north part of the galaxy were restored to their places, but only a fraction
 of the life on each one was restored. None of the z-fighters were restored to life from this
 action, only children, children so young they retained no memory of the past.<br><br>

It is now a century after Buu was defeated. Nobody has any memory or relation to the former earth or
any other planet for that matter. There are only ruins from that era, and vague clues, but that is
all.<br><br>

Other notable events:<br>
Ten years after the defeat of Cell a probe reaches earth from deep space, and mysteriously knows exactly
where to find Gero's lab, which was destroyed years earlier. It makes it's way to the fragments of Gero's
computer, analyzes them, and sends what data it can back to wherever it came from. It turns out that it came
from the Android Planet, which was another incomplete project of Dr Gero, and was programmed to take his
operations to deep space in the case of his death and that Earth was somehow compromised. The Android Planet
was far from a planet when Gero first created it, it was a small space lab with a sentient computer which
controlled millions of nano-robots. The space lab then began advancing itself to the point that it became
so large and sophisticated that it became a small planet, and began creating more sentient Androids to
populate itself. Ten more years later the probe returns, with data on Gero's most perfect creation, Cell.
Unfortunately, the data is incomplete, the Android Computer fills in the gaps as best as it can but even
though it was programmed with the knowledge of Gero, it is still not as innovative or as good as improvising.
It is a far harder and longer process to create a Bio-Android than it is for regular Androids, so the
Android Planet does not construct them very often. It would take the Android Planet 80 more years before
it had become capable of making a working Bio-Android, bringing us to present day (Year 0).<br><br>

It has been 100 years since Majin Buu was seemingly defeated. And it's true, that Majin Buu is truly dead.
But not all of him is gone...It seems that Goku's Genki Dama did not truly erase all of Buu's body from
existance, it just broke him down into such small particles that he was incapable of restoring himself as he
once was. That Majin Buu is dead, but those individual particles, have been slowly regenerating all over
Kaioshin planet for 100 years now, and finally they have reached a point where they are coming back to life
in the form of Majin Buu-like creatures that still have a portion of his power, but are seperate beings and
slightly mutated from the original. Looks like Majin Buu's threat has returned, and this time it's not just
one Majin the universe has to deal with.<br><Br>

</body></html>"}

var/Ranks={"<html>
<head><title>Ranks</title><body>
<body bgcolor="#000000"><font size=2><font color="#CCCCCC">

*Earth*<br>
Guardian:<br>
Korin:<br>
Turtle Hermit:<br>
Crane Hermit:<br>
Teachers:<br>
<br>

*Namek*<br>
Elder:<br>
Teachers:<br>
<br>

*Vegeta*<br>
King/Queen:<br>
Teachers:<br>
<br>

*Arconia*<br>
Yardrat Master:<br>
Teachers:<br>
Skill Masters:<br>
<br>

*Ice Planet*<br>
Skill Masters:<br>
<br>

*Heaven / Checkpoint*<br>
Kaioshins:<br>
North Kaio:<br>
South Kaio:<br>
East Kaio:<br>
West Kaio:<br>
<br>

*Hell*<br>
Daimaous:<br>
Skill Masters:<br>
<br>

*Notes*<br>
Teachers and Skill Masters are the same except for one thing, Skill Masters are not obligated to
teach anybody, ever. Teachers can choose "worthy" students based on whatever criteria they want,
but they still must teach, even if its only to those they deem worthy.<br><br>

</body><html>"}

var/mob/WritingRanks

mob/verb/Ranks()
	set category="Other"
	usr<<browse(Ranks,"window= ;size=700x600")

proc/SaveRanks()
	var/savefile/S=new("Data/Ranks.bdb")
	S["Ranks"]<<Ranks
	//if(global.startRuin) S["success"] << global.startRuin

proc/LoadRanks()

	if(fexists("Data/Ranks.bdb"))
		var/savefile/S=new("Data/Ranks.bdb")
		S["Ranks"]>>Ranks
		//if(length(S["success"])) global.startRuin = 1


	else if(fexists("Data/Ranks"))
		var/savefile/S=new("Data/Ranks")
		S["Ranks"]>>Ranks
		//if(length(S["success"])) global.startRuin = 1

var/mob/WritingJobs

mob/verb/Jobs()
	set category="Other"
	usr<<browse(Jobs,"window= ;size=700x600")
proc/SaveJobs()
	var/savefile/S=new("Data/Jobs.bdb")
	S["Jobs"]<<Jobs
	//if(global.startRuin) S["success"] << global.startRuin

proc/LoadJobs()

	if(fexists("Data/Jobs.bdb"))
		var/savefile/S=new("Data/Jobs.bdb")
		S["Jobs"]>>Jobs
		//if(length(S["success"])) global.startRuin = 1
/*
	else if(fexists("Data/Jobs"))
		var/savefile/S=new("Data/Jobs")
		S["Jobs"]>>Jobs
		if(length(S["success"])) global.startRuin = 1
*/
var/Jobs={"<html>
<head><body>
<body bgcolor="#000000"><font size=2><font color="#CCCCCC">

All admins have one primary directive that at least 70% of their adminning should be focused on.
These are listed in order of importance, the greatest being first. Anything that focuses on noobs
is least important, noobs are infinite, and there are only a handful of people on Finale who deserve
anything by comparison, maybe 20-40. If you focus on the endless waves of noobs, you fail as an
admin here, unless thats your job. Because you will be completely neglecting the people who deserve
to be having fun in the game. That battle can be won, the battle against noobs can NEVER be won.
As I said most of your focus (when your doing admin stuff only) should go to your primary goal, but,
that doesn't mean you cant do other stuff with your admin powers, but you can only do other stuff if
it never hinders/detracts/damages/goes against/etc your primary admin directive. Only if there is no
possible way right now to do your primary goal, should you focus on other stuff as an admin. You can
choose to be active or inactive as an admin any time you want, being an admin doesn't mean you have
to be one all the time, its volunteer crap anyway, but if your inactive like 90% of the time,
unless your a good admin that other 10% of the time, don't be surprised if your not needed any more
by whoever is managing the admins. If you have not read the description for your directive, then
do so, if you don't there is no excuse for messing up.
<br><br>


*Head Admins (Recommended: 1-2):<br>


<br><br>
*Rankers (Recommended: 1-3):<br>


<br><br>
*Event Masters (Recommended: 3-5):<br>


<br><br>
*Rewards (Recommended: 3-5):<br>


<br><br>
*Enforcers (Recommended: 2-4):<br>


<br><br>
And here are definition of what these ranks purpose are:<br><br>

Head Admins can make and remove admins as they see fit. And change their primary directives as long
as it doesn't interfere with the natural order set up here. Their goal is to keep the entire admin
team as uncorrupt and pure as possible, no matter who needs removed or what else needs done.<br><br>

Rankers are fully in charge of ranks, NO other admin without the job Ranker is allowed to give ranks,
they can only suggest it to the rankers. The rankers are a TEAM, do not go ranking people solo
without telling other rankers, they should all know that person is going to be ranked and be fine
with it. There should also be a head ranker in charge of the other rankers. Rankers manage the ranks
and make sure they are acting how they are supposed to, just like the head admin does the same for
the other admins.<br><br>

Event Masters are a very important and also pretty hard job, unless you do it right. Same as rankers,
don't be trying to do this solo starting your own events without other Event Masters help, event
masters focus only on "high level" events, things players can't really organize on their own. Here is
how it works: Event Masters, all together, organize a story outline, their main goal is to make
something worthy of being added into the story. Once you have an outline of how things should go,
you choose story characters within it, and thats where it gets complicated. Event Masters play
certain story-critical characters, but NEVER main characters, the story isn't about you. For example,
if I had a story similar to DBZ, where an evil Changeling wants to conquer everything, and Event
Master would be playing that Changeling, usually they do end up playing major villains. Lets say that
the Changeling, according to the story outline, also has the goal of conquering Vegeta, you need a
support character there to rally the good side, who better than the King of Vegeta, so an Event
Master would play King of Vegeta as well. What is the King of Vegeta's goal? Same as always, benefit
and civilize the Saiyan people, its no different when an event master does it, and it doesn't
conflict with anything the Changeling is going to do, because he is still going to have to organize
a resistance against the Changeling. So those are two characters that event masters should play for
that particular story, because no player can do them because they don't know the story direction,
and they are crucial for sending the story in the right direction, they will get players involved in
the struggle. The players who deserve to be involved, will get involved, don't try to make certain
people get involved. Of course with my story, its inevitable that the Changeling wins and conquers
Vegeta, the reason for this is, he needs to have actually done and succeeded at something evil in
order to actually be feared and hated, or there is no point in him even being in the story in the
first place. So odds are the Changeling succeeds, he rules Vegeta for a couple years turning
everything into his personal servant, everyone hates him, hopefully players will form a rebellion of
some kind, event masters should have no involvement in forming it, that is something players can and
should do. Lets say that the rebellion comes, its no real threat to the Changeling but once it
reaches its climax (which it should be allowed to do), the Changeling would get pissed off and
just destroy the planet. Now he is a real and viable evil, just as intended. But remember, the goal
of the King, is to benefit the Saiyan people, so when the planet is about to be destroyed odds are
he sees the only way the Saiyan people will survive is for some of them to leave the planet, if
the King was ever worth his salt, he will already know Saiyans who should be saved (the good
role-playing ones already involved in the story situation), he would of course send his generals,
second in commands, some of the royal family like prince or princess or whatever, and hopefully,
send a Low Class Saiyan to earth hoping that player might turn out like Goku later on, which is not
guaranteed but its what I'd do. So anyway, 5 or so Saiyans are saved maybe, more or less. The King,
honestly, in my opinion should be killed before he can save himself, but it depends what you have
planned. So now there is a real villain who has done actual evil things, that villain should
continue to do evil things until stopped by actual players, but at the same time worthy players
should be encouraged to be able to do this if they are worthy, even if you have to bring the fight
to them, for example: The Low Class sent to earth, lets say he was a good role player, he has no
memory of Vegeta because he was a kid, and Vegeta was destroyed like 15 years ago or something,
the event master playing the Changeling has intentionally avoided earth up to this point, if the
Changeling is worth anything he should have made an army by now, hopefully with some of the remaining
Saiyans who were off-world under his command, so to get that Low Class involved without killing him,
but to test his worth as a hero, he would send an enemy that can actually pose a threat to that
Low Class, but without being overkill, if that Low Class is actually worthy, he will win and be one
step closer to being the hero of the story. You can't force a story to go a certain way, you
just make an outline, and then play characters capable of "encouraging" it to that desired outline.
How long a villain stays in control is really up to the players, but if there are worthy ones, they
should gradually be guided along the necessary path to being the hero and defeating the villain. But
it should be a long and worthwhile process, not something instantaneous and forgettable. Look in DBZ,
imagine Frieza was an event master, behind the scenes he saw whoever was playing Goku as a great
role-player and potential hero, of course he doesn't let them know that because he is for all
noticeable purposes a villain, but what does he do? He gradually sends stronger and strong enemies,
but only ones which Goku and his friends actually stand a chance of winning against. Raditz, Nappa,
Vegeta, Ginyu Force, Frieza, etc. And at the same time Goku's teacher, Master Roshi, was like an
event master, while the villains were constantly testing him and getting more and more menacing,
Roshi was setting Goku up to be more and more of a hero, first it was Roshi's teachings, then Kami's,
then King Kai, all of these made Goku as powerful as he NEEDED to be to become the hero, without
overdoing it, and all those who were involved with Goku also got rewards, because they are just as
good, but Goku made himself the hero, because he proved himself worthy to be one. The story is not
static, its flexible, you dont make the story go a certain way, you make characters with goals that
encourage the story a certain way, if that Changeling, when he first went to Vegeta, SOMEHOW found
himself in a situation where he was going to die, and the Saiyans do somehow kill him, tough luck,
the villain is now dead, don't admin revive him because that is abuse, the Saiyans won. Another
example is if everything goes to plan, but then upon sending "Raditz" to earth to test if "Goku" is
hero material, Raditz succeeds in killing Goku and takes over earth for Frieza, oh well, thats just
how it goes. Now anything can happen to earth. For every main villain killed, another one comes, for
every potential hero lost, such as with Goku's case, another potential one is tested. Eventually
one of those potential heroes being tested, will actually pass the test, and the MAIN villain will
be defeated, as subliminally intended the entire time. If the Changeling is killed, and you revive
him, its abuse, that is just how the story goes, you can't force it to go a certain way, only
encourage it with character-motives. So basically what you had in that story was: A Changeling with
the motive to conquer everything, he is ruthless as well. A King with the motive to protect and
benefit his people. This naturally creates a struggle between them because they have conflicting
motives. Event Masters also have the same goal as Rewarders, they do give rewards to those that
deserve it in a systematic way beneficial to the progression of the story, but they also do all the
other stuff making their job much more involved. Event Masters -NEVER- give deductions, that has
nothing to do with them at all, they are called Event Masters and that is what they should be
focused on, not dealing with noobs. Event Masters MUST work one ONE single thing til its ultimate
completion, do not go off doing two seperate stories, only ONE, and it must be focused on by
ALL event masters, two stories cannot go on til the first is completed, because all stories will
suffer.<br><br>

Rewarders basically go around and secretly reward those that they come across who are role-playing
something substantial and are doing good at it. Its a very passive job, you just fly around or do
whatever you normally do, and any person you come across who deserves a reward for actions they are
CURRENTLY doing, then give them one. There is a Reward verb specifically for this, but power is
not always the reward, there is also a Make verb which can reward them with some kind of item.
You do not tell people they are being rewarded, you just stumble across them and do it. Same with
event masters, nobody should know this is your job, their characters just mysteriously get a little
better because they deserved it. UNLIKE event masters, rewarders occasionally give deductions,
but only to unRP stealers and killers, those are the ONLY reason to give deductions, DO NOT DO IT
FOR ANYTHING ELSE YOU HAVE BEEN WARNED. The steal or kill has to either be totally unwarned by the
person committing it, or either they didn't wait the actual 10 seconds, which can be told by logs.
Only give a deduction if that player is actually a bad person and trouble maker who actually deserves
it. BUT STILL, DEDUCTIONS ARE A SIDE THING, YOUR JOB IS CALLED REWARDER. 80% of every use you have
of the Reward verb, should actually be for REWARDS, not deductions. Rewards are to be given in IC
only when you actually see someone doing something that deserves it, whatever is going on in OOC
is irrelevant and deserves no rewards unless you actually saw it. For deductions, you can see by
OOC if someone is complaining about being unRP killed or stolen from, but only deduct if you know
for a fact it happened, which you can by logs. If the person remakes to avoid their deduction,
which is stupid anyway, but still, ban them, because they are even more abusive than previously
thought and think they can go against admins.
<br><br>

Enforcers just keep trouble out, spammers, abusers, whatever. Basically enforcing the rules of the
game. This is the most easily abused of any rank, because they potentially enforce made-up rules
that have no place in this game and are retardedly strict and serve no purpose. If you do this, you
get removed, enforce the rules of the game only. Many people can't handle this and become extremely
corrupt. If someone spams, ban them, but it has to be actual spam, you just can "say" its spam,
because then you fit into the abuser category, DONT TWIST THE RULES. Enforcers have nothing to do
with role-playing at all. That includes "unRP kills" or whatever. Nothing that happens IC between
characters is any concern for them. Leave that to rewarders.
<br><br>

*Another note about rewards, pretty important*<br>
This is how I do rewards: When I am about to reward someone, I decide if they are either: 1)
Strong for their race. 2) Average for their race. or 3) Weak for their race. Then I decide if they
either: 1) Are a great roleplayer. 2) Not really a "great" roleplayer, but certainly not a noob and
does follow and know the rules and what they are doing. Or 3) Is not a good roleplayer at all, and
perhaps is a noob and doesn't know/follow the rules anyway, and is a potential threat to the other
roleplayers or is thought to be doing bad OOC actions when admins arent looking. If they fit into a
"Category 3"
roleplayer, I don't give them anything, because they could be a potential unRP threat to Category
1 and 2 roleplayers. If they are of Category 3 power, but are Category 2 roleplayers, up their
power to what most people of their race are averaging, which puts them at "middle" power for their
race. But never go past doubling their power with one boost, if a double isnt enough to help them
reach the middle level for their race, they'll just have to get more rewards elsewhere for other
activities over time. If they are Category 1 roleplayers with Category 2 power, try to give them a
boost to make them closer to Category 1 power as well, once again, no more than double power. Age
should -NOT- be considered for when giving rewards, only if their BASE power is either poor,
average, or great for their chosen race and that race only. If they are Category 1 in both aspects,
try not to reward them with power boosts, but rather other things such as more attention from ranked
people if the story calls for it, or some special item reward perhaps, but Category 1 roleplayers
with Category 1 power, only get rewards if its relevant to the roleplays/events going on at the time
it is being given, not simply at random for no other reason, but covertly show favoritism for them
when the time calls for it perhaps, since they are of the best roleplaying category. Another thing,
the "Class" of that race should be considered somewhat, I think Saiyans are the only ones that
actually have classes. But uh, basically don't pay AS MUCH consideration to class when giving
a reward, but maybe "half as much" or something, like when you see a Low Class, he has 2 bp mod,
a Normal has 2.4, an Elite has 2.5, so pretty much each one should be given that much more of a
reward, so that an Elite that roleplays just as well as a Low Class will maintain about a 25%
power advantage over them, which is how they should naturally be, and without it they would suck. So
the proportional BP Mod differences between classes should try to be maintained, relative to how
well they roleplay that is. Also if the person is a class 2 or 3 roleplayer, and their bp is less
than double what their race/class starts with, you can up them to double what their race starts
with. Such as for instance when a server has just started, and nobody is stronger than what their
race started with. That way noobs will still not be a threat to them even though the server is
very new.

</body><html>"}