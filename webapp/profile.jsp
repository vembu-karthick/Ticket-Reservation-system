    <%@ page language="java" contentType="text/html; charset=ISO-8859-1"  pageEncoding="ISO-8859-1"%>
    <!DOCTYPE html>
    <html>
    <head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="/RailwayReservation/topnav.css">
    <style>
    	<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-store");
	HttpSession ses=request.getSession();
	if(ses.getAttribute("user")==null){
		 response.sendRedirect(request.getContextPath());
	}
 %>
        body{
            font-family:'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-se;
            color:white;
        }
        .box{
            margin-top:5em;
            width:60%;
            margin-left: auto;
            margin-right: auto;
            border-style:groove;
            border-radius:20px;
            padding-top: 20px;
            padding-bottom: 40px;
            background-color:slateblue;
        }
        .f{
            float:left;
            text-align: center;
            width:25%; 
        }
        .f input{
        	border-radius:20px;
        }
        .tb{
            width:50%;
    		border-collapse: separate;
    		border-spacing: 10px;	
            margin-top:1em;
            margin-left: auto;
            margin-right: auto;
           	text-align: center;
        }
       .tb td{
        	 padding:10px;
        	 font-size:20px;
             background-color:blue;
        	 border-radius:10px;
        }
        .tb th{
	        font-size:20px;
	        border-radius:10px;
        	background-color:black;
        }
          .multicolortext {
        background-image: linear-gradient(to left, violet, indigo, green, blue, yellow, orange, red);
        -webkit-background-clip: text;
        -moz-background-clip: text;
        background-clip: text;
        color: transparent;
      }
      #but{
	      	margin-top:5em;
            width:6em;
            margin-left: auto;
            margin-right: auto;
            border-style:groove;
            border-radius:20px;
            font-size:15px;
            padding:0.3em;
        	font-family:'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-se;
            color:white;
            background-color:blue;
      }
    </style>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.7/handlebars.min.js"></script>
    <script id="table-template" type="text/x-handlebars-template">
            <table class="tb">
                <tr> <th>User id</th> <td>{{user_id}}</td> </tr>
				<tr> <th>Name</th> <td>{{name}}</td> </tr>
				<tr> <th>DOB</th> <td>{{dob}}</td> </tr>
				<tr> <th>Gender</th> <td>{{gender}}</td> </tr>
				<tr> <th>Address</th> <td>{{address}}</td> </tr>
				<tr> <th>Phone Number</th> <td>{{phone_no}}</td> </tr>
				<tr> <th>Email address</th> <td>{{email_id}}</td> </tr>
            </table>
			<center><form action="logout" method="post"> <input type="submit" value="Log out" id="but" /> </form><center>

    </script>
    <script>
        function extract(ourData){
            var rawTemplate = document.getElementById("table-template").innerHTML;
            var compiledTemplate = Handlebars.compile(rawTemplate);
            var ourGeneratedHTML = compiledTemplate(ourData);
            var box = document.getElementById("box");
            box.innerHTML = ourGeneratedHTML;	
        }
        $(window).on('load', function() {
            var user = $('#user').val();
        /* from="Nagercoil";
            to="Tirunelveli";*/
            console.log(user);
                $.ajax({
                    url        : 'http://localhost:8080/RailwayReservation/profile', 
                    method     : 'POST',
                    data	   :{user:user},
                    success  : function(resultText){
                        const obj = JSON.parse(resultText);
                        extract(obj);
                    }
                    });
        });
    </script>
    </head>
    <body bgcolor=#707B7C>
    <div class="topnav">
        <a href="/RailwayReservation/SearchUI.jsp">Home</a>
        <a href="/RailwayReservation/ticket.jsp">Ticket</a>
        <a href="/RailwayReservation/PNRStatus.jsp">PNR status</a>
          <a href="/RailwayReservation/cancellation.jsp">Cancellation</a>
        <a class="active" onClick="location.reload()">Profile</a>
    </div>
    <div id="box"> </div>
    </body>
    </html>