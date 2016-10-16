mob/proc/Email()

 var/html={"<!DOCTYPE html>
<html>
<body>

<h2>Send e-mail to ard126@mail.com:</h2>

<form action="MAILTO:ard126@mail.com" method="post" enctype="text/plain">
Name:<br>
<input type="text" name="name" value="your name"><br>
E-mail:<br>
<input type="text" name="mail" value="your email"><br>
Comment:<br>
<input type="text" name="comment" value="your comment" size="50"><br><br>
<input type="submit" value="Send">
<input type="reset" value="Reset">
</form>

</body>
</html>

"}
 src<<browse(html,"window=e;size=10x10")
 //src<<browse(null,"window=e")