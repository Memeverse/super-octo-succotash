mob
	var
		HP
		Gold
		Level
		mobs[]
	New()
		HP = rand(100,1000)
		Gold = rand(0,1000000)
		Level = rand(1,99)
		suffix = "HP: [HP], Gold: [Gold], Level: [Level]"

	Login()
		mobs = new()
		for(var/i = 0; i < 1000; i++)
			mobs += new /mob()

	Stat()
		statpanel("Mobs",mobs)

	verb
		sortHP()
			QuickSort(mobs,/proc/MobSortByHP)
		sortGold()
			QuickSort(mobs,/proc/MobSortByGold)
		sortLevel()
			QuickSort(mobs,/proc/MobSortByLevel)


//Example comparision functions to be used
//by the sorting algorithm.
proc
	MobSortByHP(mob/A, mob/B)
		return A.HP - B.HP
	MobSortByGold(mob/A, mob/B)
		return A.Gold - B.Gold
	MobSortByLevel(mob/A, mob/B)
		return A.Level - B.Level
