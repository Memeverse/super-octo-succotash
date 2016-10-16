
mob/proc/Clothes_Equip(obj/A) if(A in usr)
	if(!A.suffix)
		A.suffix = "*Equipped*"
		usr.Equip_Magic(A,"Add")
		var/image/_overlay = image(A.icon) // In order to get pixel offsets to stick to overlays we create an image
		_overlay.pixel_x = A.pixel_x
		_overlay.pixel_y = A.pixel_y
		overlays += _overlay
	else
		A.suffix = null
		var/image/_overlay = image(A.icon) // not sure if the equipped thing is an icon/object so
		overlays -= A.icon
		usr.Equip_Magic(A,"Remove")
		overlays -= _overlay // we're removing both overlay types to be sure.
	usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] [suffix ? "Unequips" : "Equips"] the [A]\n")
mob/proc/Clothes_Proc(obj/A)
	if(A in Clothing)
		var/obj/B=new A.type
		var/RGB=input(src,"") as color|null
		if(!B) return
		if(RGB) B.icon+=RGB
		contents+=B
	else Clothes_Equip(A)
var/list/Clothing=new
obj/items/Clothes
	Savable=0
	Flammable = 1
	Click()
		usr.Clothes_Proc(src)
//	A Strange Head
//		icon='Clothes, Naraku.dmi'
//		Click() usr.Clothes_Proc(src)
	Demon_Arm
		icon='Clothes, Demon Arm.dmi'
		Click() usr.Clothes_Proc(src)
	Azure_Armor
		icon='Armor, Azure.dmi'
		Click() usr.Clothes_Proc(src)
//	Wolf_Clothes
//		icon='Clothes, Wolf Hermit.dmi'
//		Click() usr.Clothes_Proc(src)
	Wolf_Head
		icon='Wolf Hood.dmi'
		Click() usr.Clothes_Proc(src)
	Wristband
		icon='Clothes_Wristband.dmi'
		Click() usr.Clothes_Proc(src)
	Angel_Wings
		icon='Angel Wings.dmi'
		Click() usr.Clothes_Proc(src)
	Red_Eyes
		icon='Red Eyes.dmi'
		Click() usr.Clothes_Proc(src)
	Yellow_Eyes
		icon='Yellow Eyes.dmi'
		Click() usr.Clothes_Proc(src)
	Black_Eyes
		icon='Eyes_Black.dmi'
		Click() usr.Clothes_Proc(src)
	Blue_Eyes
		icon='Eyes_Blue.dmi'
		Click() usr.Clothes_Proc(src)
	Brown_Eyes
		icon='Eyes_Brown.dmi'
		Click() usr.Clothes_Proc(src)
	Green_Eyes
		icon='Eyes_Green.dmi'
		Click() usr.Clothes_Proc(src)
	Orange_Eyes
		icon='Eyes_Orange.dmi'
		Click() usr.Clothes_Proc(src)
	Violet_Eyes
		icon='Eyes_Purple.dmi'
		Click() usr.Clothes_Proc(src)
	White_Eyes
		icon='Eyes_White.dmi'
		Click() usr.Clothes_Proc(src)
	Full_Yardrat
		icon='Clothes Full Yardrat.dmi'
		Click() usr.Clothes_Proc(src)
	Turban
		icon='Clothes_Turban.dmi'
		Click() usr.Clothes_Proc(src)
	TankTop
		icon='Clothes_TankTop.dmi'
		name="Tank Top"
		Click() usr.Clothes_Proc(src)
	ShortSleeveShirt
		icon='Clothes_ShortSleeveShirt.dmi'
		name="Shirt"
		Click() usr.Clothes_Proc(src)
	Loose_Fitting_Shirt
		icon='Cloths_Long_Shirt.dmi'
		Click() usr.Clothes_Proc(src)
	Shoes
		icon='Clothes_Shoes.dmi'
		Click() usr.Clothes_Proc(src)
	Goggles
		icon='Goggles.dmi'
		Click() usr.Clothes_Proc(src)
	TightJumpsuit
		icon='Tight Jumpsuit.dmi'
		Click() usr.Clothes_Proc(src)
	Jacket_2
		icon='Jacket 2.dmi'
		name="Jacket"
		Click() usr.Clothes_Proc(src)
	Hat
		icon='Hat.dmi'
		Click() usr.Clothes_Proc(src)
	Shoulder_Strap
		icon='Shoulder Strap.dmi'
		Click() usr.Clothes_Proc(src)
	Mask
		icon='Mask.dmi'
		Click() usr.Clothes_Proc(src)
	Sash
		icon='Clothes_Sash.dmi'
		Click() usr.Clothes_Proc(src)
	Kimono
		icon='Clothes, Kimono.dmi'
		Click() usr.Clothes_Proc(src)
	Pants
		icon='Clothes_Pants.dmi'
		Click() usr.Clothes_Proc(src)
	NamekianScarf
		icon='Clothes_NamekianScarf.dmi'
		Click() usr.Clothes_Proc(src)
		name="Scarf"
	LongSleeveShirt
		icon='Clothes_LongSleeveShirt.dmi'
		name="Long Shirt"
		Click() usr.Clothes_Proc(src)
	Expensive_Suit
		icon='Clothes_KaioSuit.dmi'
		name="Expensive Suit"
		Click() usr.Clothes_Proc(src)
	Jacket
		icon='Clothes_Jacket.dmi'
		Click() usr.Clothes_Proc(src)
	Headband
		icon='Clothes_Headband.dmi'
		Click() usr.Clothes_Proc(src)
	Gloves
		icon='Clothes_Gloves.dmi'
		Click() usr.Clothes_Proc(src)
	Boots
		icon='Clothes_Boots.dmi'
		Click() usr.Clothes_Proc(src)
	Bandana
		icon='Clothes_Bandana.dmi'
		Click() usr.Clothes_Proc(src)
	Belt
		icon='Clothes_Belt.dmi'
		Click() usr.Clothes_Proc(src)
	Cape
		icon='Clothes_Cape.dmi'
		Click() usr.Clothes_Proc(src)
	Gaudy_Shirt
		icon='Clothes, Kaio Shirt.dmi'
		Click() usr.Clothes_Proc(src)
	Tsurusennin
		icon='Clothes, Tsurusennin.dmi'
		Click() usr.Clothes_Proc(src)
	Shorts
		icon='Clothes, Female Shorts.dmi'
		Click() usr.Clothes_Proc(src)
	Female_Shirt
		icon='Clothes, Female Shirt.dmi'
		name="Shirt"
		Click() usr.Clothes_Proc(src)
	Frontless_Cape
		icon='Clothes, Cape 2.dmi'
		Click() usr.Clothes_Proc(src)
	Female_Gi
		icon='Clothes, Gi Female.dmi'
		Click() usr.Clothes_Proc(src)
		name="Gi"
	Ninja_Mask
		icon='Clothes, Ninja Mask.dmi'
		Click() usr.Clothes_Proc(src)
	Ninja_Mask_2
		icon='Clothes, Ninja Mask 2.dmi'
		name="Ninja Mask"
		Click() usr.Clothes_Proc(src)
	Neko
		icon='Clothes, Neko.dmi'
		Click() usr.Clothes_Proc(src)
	Pimp_Hat
		icon='Clothes, Pimp Hat.dmi'
		Click() usr.Clothes_Proc(src)
	Assassin_Hoodless
		icon='Clothes, Assassin, Hoodless.dmi'
		Click() usr.Clothes_Proc(src)
/*	Wasteland_Style_Cloak
		icon='Hagard Cloak.dmi'
		Click() usr.Clothes_Proc(src)*/
	Assassin
		icon='Clothes, Assassin.dmi'
		Click() usr.Clothes_Proc(src)
	Power_Suit
		icon='Armor 8.dmi'
		Click() usr.Clothes_Proc(src)
	Devil_Cape
		icon='Clothes, Daimaou Cape.dmi'
		Click() usr.Clothes_Proc(src)
	White_Gloves
		icon='Clothes, Saiyan Gloves.dmi'
		Click() usr.Clothes_Proc(src)
	Horns
		icon='Clothes, Horns.dmi'
		Click() usr.Clothes_Proc(src)
	High_Boots
		icon='HighBoots.dmi'
		Click() usr.Clothes_Proc(src)
	Arm_Socks_Transparent
		icon='ArmSocksTransparent.dmi'
		Click() usr.Clothes_Proc(src)
	Arm_Socks_Solid
		icon='ArmSocks-Solid.dmi'
		Click() usr.Clothes_Proc(src)
	Book
		icon='Clothes, Book.dmi'
		Click() usr.Clothes_Proc(src)
	White_Shoes
		icon='Clothes, Saiyan Shoes.dmi'
		Click() usr.Clothes_Proc(src)
	Gi_Bottom
		icon='Clothes_GiBottom.dmi'
		Click() usr.Clothes_Proc(src)
	Gi_Top
		icon='Clothes_GiTop.dmi'
		Click() usr.Clothes_Proc(src)
	Kitsune
		icon='Kitsune.dmi'
		name="Neko? Maybe."
		Click() usr.Clothes_Proc(src)
	Tuxedo
		icon='Clothes Tuxedo.dmi'
		Click() usr.Clothes_Proc(src)
	Beard
		icon='Beard.dmi'
		Click() usr.Clothes_Proc(src)
	Sunglasses
		icon='Item - Sun Glassess.dmi'
		Click() usr.Clothes_Proc(src)
//	Tien
//		icon='Tien Clothes.dmi'
//		Click() usr.Clothes_Proc(src)
	Celestial_Suit
		icon='Clothes Kaio Suit.dmi'
		Click() usr.Clothes_Proc(src)
	Earthen_Jacket
		icon='Clothes Namek Jacket.dmi'
		Click() usr.Clothes_Proc(src)
	Robe
		icon='Clothes Guardian.dmi'
		Click() usr.Clothes_Proc(src)
	Evil_Robe
		icon='Clothes Daimaou.dmi'
		Click() usr.Clothes_Proc(src)
	Undies
		icon='Clothes Diaper.dmi'
		Click() usr.Clothes_Proc(src)
	Tattoo1
		icon='Jecht.dmi'
		Click() usr.Clothes_Proc(src)
	Tattoo2
		icon='Red Tattoo.dmi'
		Click() usr.Clothes_Proc(src)
	Curiously_Useless_Armor
		icon='Succubus Armor.dmi'
		Click() usr.Clothes_Proc(src)
	Bowler_Hat
		icon='Darkman Hat.dmi'
		Click() usr.Clothes_Proc(src)
	Large_Cloak
		icon='Large Changeling Cloak.dmi'
		Click() usr.Clothes_Proc(src)
	Sentai_Helmet
		icon='Soldier Helmet.dmi'
		Click() usr.Clothes_Proc(src)
	Officers_Jacket
		icon='Super 17.dmi'
		Click() usr.Clothes_Proc(src)
	Taranian_Uniform
		icon='TuffleTux.dmi'
		Click() usr.Clothes_Proc(src)
	Loose_Fitting_Coat
		icon='BaggyTrenchCoat.dmi'
		Click() usr.Clothes_Proc(src)
	Funny_Mask
		icon='Warrior of Time Mask.dmi'
		Click() usr.Clothes_Proc(src)
	Gas_Mask
		icon='EDFGas.dmi'
		Click() usr.Clothes_Proc(src)
	Face_Mask
		icon='EDFMask.dmi'
		Click() usr.Clothes_Proc(src)
	Mask_With_Visor
		icon='EDFVisor.dmi'
		Click() usr.Clothes_Proc(src)
	Big_Scarf
		icon='Big fluffy scarf.dmi'
		Click() usr.Clothes_Proc(src)
	White_Dress
		icon='DRESS.dmi'
	Female_Shirt_Variant
		icon='Female shirt.dmi'
		Click() usr.Clothes_Proc(src)
	Grass_Skirt_and_Coconut_Bra
		icon='GRASS SKIRT AND COCONUT BRA.dmi'
		Click() usr.Clothes_Proc(src)
	Lipstick_Ruby_Red
		icon='Lipstick (ruby red).dmi'
		Click() usr.Clothes_Proc(src)
	Purple_and_Green_Dress
		icon='purple green dress.dmi'
		Click() usr.Clothes_Proc(src)
	Purple_Swimsuit
		icon='Purple swimsuit.dmi'
		Click() usr.Clothes_Proc(src)
	Red_and_Black_Dress
		icon='Red and black dress.dmi'
		Click() usr.Clothes_Proc(src)
	Short_Skirt
		icon='Shortskirt.dmi'
		Click() usr.Clothes_Proc(src)
	Stockings
		icon='Stockings.dmi'
		Click() usr.Clothes_Proc(src)
	Tight_Dress
		icon='Tight dress.dmi'
		Click() usr.Clothes_Proc(src)
	Curiously_Ugly_Boots
		icon='UGG BOOTS.dmi'
		Click() usr.Clothes_Proc(src)
	White_Wedding_Dress
		icon='WHITE wedding dress fixed.dmi'
		Click() usr.Clothes_Proc(src)
	Yellow_Hair_Bow
		icon='Yellow hair bow.dmi'
		Click() usr.Clothes_Proc(src)
	Eyepatch
		icon='Eyepatch.dmi'
		Click() usr.Clothes_Proc(src)
	Epic_Cape
		icon='KingCape.dmi'
		Click() usr.Clothes_Proc(src)
	Labcoat
		icon='Labcoat.dmi'
		Click() usr.Clothes_Proc(src)
	Ragged_Garb
		icon='ShadowstoneGarb.dmi'
		Click() usr.Clothes_Proc(src)
	Creepy_Mask
		icon='SpiritMask.dmi'
		Click() usr.Clothes_Proc(src)
	Arm_Tattoo
		icon='Tattoo.dmi'
		Click() usr.Clothes_Proc(src)
	Tight_Tanktop
		icon='TightTank.dmi'
		Click() usr.Clothes_Proc(src)
	White_Sneakers
		icon='WhiteShoes.dmi'
		Click() usr.Clothes_Proc(src)
	Wasteland_Clothes_1
		icon='ZelgiusArmor.dmi'
		Click() usr.Clothes_Proc(src)