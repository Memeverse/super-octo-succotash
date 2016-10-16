//We defining in this bitch
#define SMALL 1
#define MEDIUM 2
#define LARGE 3

mob
	var
		Size
mob
	proc
		Body_Sizes()	//In leiu of changing stats directly here, it's done in races.dm in each race proc.. :(
			switch(input("Choose your body type here, each one has different advantages and disadvantages.", text) in list ("Small", "Medium", "Large",))
				if("Small")
					src.Size = SMALL
				if("Medium")
					src.Size = MEDIUM
				if("Large")
					src.Size = LARGE