obj
	Props
		Sign
			icon='Sign.dmi'
			icon_state = "sign1"
			density=1
			Click() if(desc) usr<<desc
		Sign/Information_Panel
			icon='Lab.dmi'
			icon_state="Radar"
			Click() if(desc) usr<<desc
		Sign/Cross
			icon='Cross.dmi'
			Click() if(desc) usr<<desc
		Sign/Grave2
			icon='Grave1.dmi'
			Flammable = 1
			Click() if(desc) usr<<desc
		Sign/Grave3
			icon='Grave2.dmi'
			Click() if(desc) usr<<desc
		Sign/SignPost
			icon='SignPost.dmi'
			Flammable = 1
			Click() if(desc) usr<<desc
		Sign/Caution
			icon='CautionSign.dmi'
			Click() if(desc) usr<<desc
		Sign/ChalkBoard
			icon='SignChalkBoard.dmi'
			pixel_x = -16
			Click() if(desc) usr<<desc
		Sign/Board
			icon='Sign.dmi'
			icon_state="sign2"
			Flammable = 1
			Click() if(desc) usr<<desc
		Sign/Grave
			icon='grave.dmi'
			Click() if(desc) usr<<desc
			New()
				src.pixel_x = -8
		Sign/Large_Stone_Engraving
			icon='stone.dmi'
			Click() if(desc) usr<<desc
			New()
				src.pixel_x = -8
		Sign/MailDeposit
			icon='Urban.dmi'
			icon_state="MailDeposit"
			Click() if(desc) usr<<desc