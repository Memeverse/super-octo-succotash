mob/verb/Hair()
	set category="Other"
	overlays-=hair
	var/T=Tail
	Tail_Remove()
	Tail=T
	Choose_Hair()
	if(src) if(Tail) Tail_Add()
	if(Race=="Tsufurujin") Neko_Add()

mob/verb/Clothes()
	set category="Other"
	if(!Clothes) Clothes=1
	else Clothes=0
	/*var/list/Choices=new
	Choices.Add("Cancel","Shirt","Tank Top","Long Shirt","Pants","Shoes","Socks","Sash","Belt",\
	"Gi","Jumpsuit","Cape","Turban","Jacket","Wristband","Gloves","Headband","Scarf","Bandana","Undies",\
	"Namek Vest","Kaioshin Suit","Elder Kaio Suit","Daimaou Cape","Daimaou Robe","Guardian Robe",\
	"Mask","Hat","Jacket 2","Sunglasses","Tuxedo","Tien","Beard","Power Suit","Assassin","Book",\
	"Assassin Hoodless","Pimp Hat","Kitsune",/*"Neko",*/"Tsurusennin (Crane Master)","Ninja Mask",\
	"Ninja Mask 2","Female Gi","Frontless Cape","Kaio Shirt","Shorts","Female Shirt","Horns",\
	"Saiyan Gloves","Saiyan Shoes","Kimono")
	var/obj/A
	switch(input("") in Choices)
		if("Cancel") return
		if("Kimono") A=new/obj/items/Clothes/Kimono
		if("Saiyan Gloves") A=new/obj/items/Clothes/Saiyan_Gloves
		if("Saiyan Shoes") A=new/obj/items/Clothes/Saiyan_Shoes
		if("Horns") A=new/obj/items/Clothes/Horns
		if("Book") A=new/obj/items/Clothes/Book
		if("Shorts") A=new/obj/items/Clothes/Shorts
		if("Female Shirt") A=new/obj/items/Clothes/Female_Shirt
		if("Kaio Shirt") A=new/obj/items/Clothes/Kaio_Shirt
		if("Frontless Cape") A=new/obj/items/Clothes/Frontless_Cape
		if("Female Gi") A=new/obj/items/Clothes/Female_Gi
		if("Ninja Mask") A=new/obj/items/Clothes/Ninja_Mask
		if("Ninja Mask 2") A=new/obj/items/Clothes/Ninja_Mask_2
		if("Tsurusennin (Crane Master)") A=new/obj/items/Clothes/Tsurusennin
		if("Neko") A=new/obj/items/Clothes/Neko
		if("Pimp Hat") A=new/obj/items/Clothes/Pimp_Hat
		if("Assassin Hoodless") A=new/obj/items/Clothes/Assassin_Hoodless
		if("Assassin") A=new/obj/items/Clothes/Assassin
		if("Beard") A=new/obj/items/Clothes/Beard
		if("Tien") A=new/obj/items/Clothes/Tien
		if("Kitsune") A=new/obj/items/Clothes/Kitsune
		if("Tuxedo") A=new/obj/items/Clothes/Tuxedo
		if("Sunglasses") A=new/obj/items/Clothes/Sunglasses
		if("Jacket 2") A=new/obj/items/Clothes/Jacket_2
		if("Gi") A=new/obj/items/Clothes/Gi_Top
		if("Kaioshin Suit") A=new/obj/items/Clothes/Kaio_Suit
		if("Undies") A=new/obj/items/Clothes/Undies
		if("Namek Vest") A=new/obj/items/Clothes/Namek_Jacket
		if("Jumpsuit") A=new/obj/items/Clothes/Gi_Bottom
		if("Cape") A=new/obj/items/Clothes/Cape
		if("Bandana") A=new/obj/items/Clothes/Bandana
		if("Belt") A=new/obj/items/Clothes/Belt
		if("Socks") A=new/obj/items/Clothes/Boots
		if("Gloves") A=new/obj/items/Clothes/Gloves
		if("Headband") A=new/obj/items/Clothes/Headband
		if("Jacket") A=new/obj/items/Clothes/Jacket
		if("Elder Kaio Suit") A=new/obj/items/Clothes/KaioSuit
		if("Long Shirt") A=new/obj/items/Clothes/LongSleeveShirt
		if("Scarf") A=new/obj/items/Clothes/NamekianScarf
		if("Pants") A=new/obj/items/Clothes/Pants
		if("Sash") A=new/obj/items/Clothes/Sash
		if("Shoes") A=new/obj/items/Clothes/Shoes
		if("Shirt") A=new/obj/items/Clothes/ShortSleeveShirt
		if("Tank Top") A=new/obj/items/Clothes/TankTop
		if("Turban") A=new/obj/items/Clothes/Turban
		if("Wristband") A=new/obj/items/Clothes/Wristband
		if("Daimaou Cape") A=new/obj/items/Clothes/Daimaou_Cape
		if("Daimaou Robe") A=new/obj/items/Clothes/Daimaou_Robe
		if("Guardian Robe") A=new/obj/items/Clothes/Guardian_Robe
		if("Mask") A=new/obj/items/Clothes/Mask
		if("Hat") A=new/obj/items/Clothes/Hat
		if("Power Suit") A=new/obj/items/Clothes/Power_Suit
	var/RGB=input("") as color|null
	if(RGB) A.icon+=RGB
	contents+=A*/