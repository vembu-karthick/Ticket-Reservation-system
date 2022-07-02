<%@ page language="java" contentType="text/html; charset=ISO-8859-1"  pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>bts.com</title>
    <meta name="description" content="Bus ticketing system">
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
	<meta http-equiv="Pragma" content="no-cache">
	<meta http-equiv="Expires" content="0">
  	<link rel="shortcut icon" href="https://icons.iconarchive.com/icons/graphicloads/transport/256/bus-4-icon.png">
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Audiowide">
	<style>
		.topnav{
			width:40em;
		}
		#tit{
			text-align:center;
			margin-top:5em;
		}
		#box{
			width:40em;
			margin-top:5em;
			margin-left:auto;
			margin-right:auto;
			border-style:groove;
			border-radius:20px;
			text-align: center;
			background-color:slateblue;
		}
		.lb{
			margin-top:1em;
		}
		.tb{
			border-radius:20px;
		}
		.sub{
			font-family:'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-se;
			margin-top: 1em;
			margin-bottom: 1em;
			border-radius:10px;
		}
		body {
			font-family:'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-se;
			color:white;
		}
	</style>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.7/handlebars.min.js"> </script>
	<script id="table-template" type="text/x-handlebars-template">
		{{res}}
	</script>
	<script>
	 function extract(ourData){
         var rawTemplate = document.getElementById("table-template").innerHTML;
         var compiledTemplate = Handlebars.compile(rawTemplate);
         var ourGeneratedHTML = compiledTemplate(ourData);
         var routes = document.getElementById("res");
      		routes.innerHTML = ourGeneratedHTML;
      	//	setInterval(function(){$('#res').fadeOut();},2000);
        }
	 $(document).ready(function(){
		 
		$("#dataform").submit(function func(event){
			 event.preventDefault();
		const user = $('#user').val();
		const pass = $('#pass').val();
		user1=user;
		//console.log(user);
			$.ajax({
				url        : 'login', 
				method     : 'POST',
				data	   :{user:user,pass:pass},
				success    : function(resultText){
					$('#user').val('');
					$('#pass').val('');
					console.log(user);
					console.log(pass);	
					console.log()
					const obj = JSON.parse(resultText);
					extract(obj);
					if(obj.val==true){						
						window.location.href="/RailwayReservation/SearchUI.jsp";
					}
				}
				});
			});
			});
		function reg(){
			window.location.href="/RailwayReservation/register.jsp";
		}
	</script>
</head>
<body bgcolor=#707B7C>
<%

	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-store");
	HttpSession ses=request.getSession();
	session.invalidate();

%>
	<h1 id ="tit">Train Reservation System </h1>
	<div id="box">
			<h1> Login </h1>
			<div id="res"></div>
	<form id="dataform">
		<div class="lb">
		<label for="user">User Id</label>
			<br>
			<input type="text" id="user" class= "tb" required>
			<div id="u"></div>
			<br>
		</div>
		<div class="lb">
			<label for="pass" class="lb">Password</label>
			<br>
			<input type="password" id="pass" class= "tb" required>
			<div id="p"></div>
			<br>
			<br>	
		</div>
			<button type="submit" class="sub"> Submit</button>
			<button onClick="reg()" class= "sub">New User</button> 
			<a></a>
	</form>
	</div>
</body>
</html>																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																			