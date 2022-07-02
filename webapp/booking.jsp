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
         
			background-color:slateblue;
		}
        label{
            margin-left:3em;
            margin-top: 1em;
            display: inline-block;
            width: 20%;
        }
		input{
			border-radius:20px;
            margin-left: 3em;
		}
		.but{
            margin-left:3em;
            font-family:'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-se;
	        border-radius:10px;
            margin-top:1em;
            margin-bottom:2em;
            font-size: 15px;
            width:23%; 
		}
        button{
            font-family:'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-se;
	        border-radius:10px;
            font-size: 15px;
           width:10em;
            margin-left:7em;
        }
		body {
			font-family:'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-se;
			color:white;
		}
	</style> 
	<script>
        // var i=1;
        // function add(){
        //     var div=document.createElement("div");

        //     var label = document.createElement("label");
        //     label.innerHTML = "name "
        //     label.htmlFor = "name"+i;
           
        //     var name=document.createElement("input");
        //     name.setAttribute(type,text);
        //     name.setAttribute(id,"name"+i);
        //     name.setAttribute(name,"name"+i);

        //     var label1 = document.createElement("label");
        //     label1.innerHTML = "age "
        //     label1.htmlFor = "age"+i;
            
        //     var age=document.createElement("input");
        //     age.setAttribute(type,number);
        //     age.setAttribute(id,"age"+i);
        //     age.setAttribute(name,"age"+i);

        //     var label2= document.createElement("label");
        //     label2.innerHTML = "gender "
        //     label2.htmlFor = "gender"+i;
            
        //     var gender=document.createElement("select");
        //     gender.setAttribute(id,"gender"+i);
        //     gender.setAttribute(name,"gender"+i);

        //     var values = ["M", "F", "T"];
        //     for (const val of values)
        //     {
        //         var option = document.createElement("option");
        //         option.value = val;
        //         option.text = val;
        //         select.appendChild(option);
        //     }
        //     div.appendChild(label);
        //     div.appendChild(name);
        //     console.log(div);
        //     i++;
        // }
        function hide(){
           
            $(".1").hide();
            $(".2").hide();
            $(".3").hide();
            $(".4").hide();
            $(".5").hide();

        }
        var i=1;
        function add(){
            $("."+i).show();
            i=i+1;
        }
        function del(str){
            console.log(str);

            name='name'+str
            age='age'+str
            gender='gender'+str
        
            $("[name="+name+"]").val='';
            $("[name="+age+"]").val='';
            $("[name="+gender+"]").val='';

            $("."+str).hide();
        }
        function valid(pass,cpass){
            return pass==cpass;
        }
        function userValid(user){
            return user.length>=4 && user.length<=15
        }
		function func(){
            var user ='use';
            var pass = 'pass';
            var cpass ='pass';
            var name ='name';
            var dob  = 'dob';
            var gender='gender';
            var address = 'address';
            var ph = '3256';
            var email = 'email';
		// var user = $('#user').val();
		// var pass = $('#pass').val();
        // var cpass = $('#cpass').val();
		// var name = $('#name').val();
        // var dob  = $('#dob').val();
		// var gender= $('#gender').val();
        // var address = $('#address').val();
		// var ph = $('#ph').val();
        // var email = $('#email').val();
        if(userValid(user)){ 
            $.ajax({
				url        : 'http://localhost:8080/RailwayReservation/register', 
				method     : 'POST',
				datax   	:{user:user},
				success    : function(resultText){
					if(resultText=='true' && valid(pass,cpass)){
                        $.ajax({
                            url        : 'http://localhost:8080/RailwayReservation/register', 
                            method     : 'POST',
                            datax   	:{user:user,pass:pass,cpass:cpass,name:name,dob:dob,gender:gender,address:address,ph:ph,email:email},
                            success    : function(resultText){
                                if(resultText=='true'){
					            $('#res').html("User is registered successfully");
                                }
				            }	
				        });
                    }
				}	
				});
		    }
        }
	</script>
</head>

<body bgcolor=#707B7C onLoad="javascript:hide()" >
	<h1 id ="tit">Train Reservation System </h1>
	<div id="box">
		<center> <h1> Ticket Booking </h1> </center>
    <form action="/Confirm.jsp" method="post" >
       
        <div class="0">
            <div>
                <label for="name" class="lb">Name </label>
                <input type="text" name="name" required>
            </div> 
            <div>
                <label for="age" class="lb">Age</label>
                <input type="number" name="age"  required>
   
            </div>
            <div>
                <label for="gender" class="lb">Gender</label>
                <select name="gender" >
                    <option value=""></option>
                    <option value="M">M</option>
                    <option value="F">F</option>
                    <option value="T">T</option>
                </select>
                
            </div>
        </div> 
        
        <div class="1">
            <div>
                <label for="name1" class="lb">Name </label>
                <input type="text" name="name1" required>
            </div> 
            <div>
                <label for="age1" class="lb">Age</label>
                <input type="number" name="age1"  required>
                <button  type="button" onClick="del('1')">Delete</button>
            </div>
            <div>
                <label for="gender1" class="lb">Gender</label>
                <select name="gender" id="gender1">
                    <option value=""></option>
                    <option value="M">M</option>
                    <option value="F">F</option>
                    <option value="T">T</option>
                </select>
            </div>
        </div> 
         <div class="2">
            <div>
                <label for="name2" class="lb">Name </label>
                <input type="text" name="name2" required>
            </div> 
            <div>
                <label for="age2" class="lb">Age</label>
                <input type="number" name="age2"  required>
                <button  type="button" onClick="del('2')">Delete</button>
            </div>
            <div>
                <label for="gender2" class="lb">Gender</label>
                <select name="gender" >
                    <option value=""></option>
                    <option value="M">M</option>
                 <option value="F">F</option>
                    <option value="T">T</option>
                </select>
            </div>
        </div> 
        <div class="3">   
                <div>
                    <label for="name3" class="lb">Name </label>
                    <input type="text" name="name3" required>
                </div> 
                <div>
                    <label for="age3" class="lb">Age</label>
                    <input type="number" name="age3"  required>
                    <button  type="button" onClick="del('3')">Delete</button>
                </div>
                <div>
                    <label for="gender3" class="lb">Gender</label>
                    <select name="gender3" >
                        <option value=""></option>
                        <option value="M">M</option>
                        <option value="F">F</option>
                        <option value="T">T</option>
                    </select>
            </div> 
        </div>
        <div class="4">
                <div>
                    <label for="name4" class="lb">Name </label>
                    <input type="text" name="name4" required>
                </div> 
                <div>
                    <label for="age4" class="lb">Age</label>
                    <input type="number" name="age4"  required>
                    <button  type="button" onClick="del('4')">Delete</button>
                </div>
                <div>
                    <label for="gender4" class="lb">Gender</label>
                    <select name="gender4" >
                        <option value=""></option>
                        <option value="M">M</option>
                        <option value="F">F</option>
                        <option value="T">T</option>
                    </select>
            </div> 
        </div>
        <div class="5">
           
                <div>
                    <label for="name5" class="lb">Name </label>
                    <input type="text" id="name5" required>
                </div> 
                <div>
                    <label for="age5" class="lb">Age</label>
                    <input type="number" id="age5"  required>
                    <button  type="button" onClick="del('5')">Delete</button>
                </div>
                <div>
                    <label for="gender5" class="lb">Gender</label>
                    <select name="gender5" id="gender">
                        <option value=""></option>
                        <option value="M">M</option>
                        <option value="F">F</option>
                        <option value="T">T</option>
                    </select>
                </div>
           
        </div>
      
            <button  type="button" class="but" onClick="add()"> AddPasssenger</button>
        <!-- <button onClick="delete()"> AddPasssenger</button> -->
       
        
        <div>
            <label for="address" class="lb">Address</label>
            <input type="text" id="address"  required>
        </div>
        <div>
            <label for="ph" class="lb">Phone number</label>
            <input type="number" id="ph"  required>
        </div>
        <div>
            <label for="email" class="lb">Email id   </label>
            <input type="text" id="email"  required>
        </div>
		<input type="submit" class="but" value="Continue">
	</div>
</form>
<!-- <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT_xsaf05a8r5Jwzsg1j95VfwBP2RqSYv6oKg&usqp=CAU"> -->
</body>
</html>