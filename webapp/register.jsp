 <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>bts.com</title>
    <meta name="description" content="Bus ticketing system">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Audiowide">
	<style>
		#tit{
			text-align:center;
			margin-top:1em;
		}
		#box{
			margin-top:5em;
			width:60%;
            margin-right:auto;
            margin-left:auto;
			border-style:groove;
			border-radius:20px;
            text-align: center;
			background-color:slateblue;
		}
        label{
            margin-top: 1em;
            display: inline-block;
            width: 30%;
        }
		input{
			border-radius:20px;
       		margin-left: 3em;
       		
		}
		#dob{
			margin-left:5em;
			margin-right:3em;
		}
		select{
			border-radius:20px;
       		margin-left: 8em;
       		margin-right:5em;
		}
		#sub{
            font-family:'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-se;
	        border-radius:10px;
            margin-top:1em;
            margin-bottom:2em;
            font-size: 15px;
            width:20%; 
		}
		body{
			font-family:'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-se;
			color:white;
		}
		#res{
			margin-top:0.8em;
			 text-align:center;
		}
	</style>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js">
	</script>
	<script type="text/x-handlebars-template">
		
	</script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.7/handlebars.min.js"></script>
	<script>
        function valid(pass,cpass){
            return pass==cpass;
        }
        function userValid(user){
            return user.length>=4 && user.length<=15
        }
        function cl(){
        	var va= document.getElementsByClassName("lb");
        	for (let i = 0; i < va.length; i++) {
        		va[i].value="";
        	}
        }
		function func(){
		 var user = $('#user').val();
		 var pass = $('#pass').val();
         var cpass = $('#cpass').val();
		 var name = $('#name').val();
         var dob  = $('#dob').val();
		 var gender= $('#gender').val();
         var address = $('#address').val();
		 var ph = $('#ph').val();
         var email = $('#email').val();
         if(userValid(user)){
        	 if(valid(pass,cpass)){
        		 
                 $.ajax({
                            url        : 'registration', 
                            method     : 'POST',
                            data 	:{user:user,pass:pass,cpass:cpass,name:name,dob:dob,gender:gender,address:address,ph:ph,email:email},
                            success    : function(resultText){
                            	const obj = JSON.parse(resultText)
                                if(obj.res==true){
					            	alert("User is registered successfully");
					            	cl();
					            	window.location.href="/RailwayReservation";
                                	}
                                else{
            						$('#res').html("User is already registered");
            			    	    }	
                        		}
				        	});
                    	}
						else{
							$('#res').html("Password didn't match");
						}
				}
			else{
				$('#res').html("Userid length must be between 3 and 16 ");	
				}
        }
	</script>
</head>

<body bgcolor=#707B7C>
	<h1 id ="tit">Train Reservation System </h1>
	<h6 id="res"></h6>
	<div id="box">
		<h1> Registration </h1>
		<div >
		    <label for="user" >User Id</label>
			<input type="text" class="lb" id="user"  required>
		</div>
		<div >
			<label for="pass" >Password</label>
			<input type="password" class="lb" id="pass"  required>
		</div>
    	<div >
            <label for="cpass" >Confirm Password</label>
            <input type="password" class="lb" id="cpass"  required>
        </div>
        <div>
            <label for="name" >Name </label>
            <input type="text" class="lb" id="name" required>
        </div>
        <div>
            <label for="dob">DOB</label>
            <input type="date" class="lb" id="dob" required>
        </div>
        <div>
            <label for="gender" >Gender</label>
            <select name="gender"  class="lb" id="gender">
                    <option value=""></option>
                    <option value="M">M</option>
                    <option value="F">F</option>
                    <option value="T">T</option>
                </select>
        </div>
        <div>
            <label for="address" >Address</label>
            <input type="text" id="address" class="lb"  required>
        </div>
        <div>
            <label for="ph" >Phone number</label>
            <input type="tel" id="ph" class="lb" required>
        </div>
        <div>
            <label for="email">Email id   </label>
            <input type="email" id="email"  class="lb"  required>
        </div>
		<button onClick="func()" id="sub"> Register</button>
	</div>
	
	
<!-- <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT_xsaf05a8r5Jwzsg1j95VfwBP2RqSYv6oKg&usqp=CAU"> -->
</body>
</html>																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																			