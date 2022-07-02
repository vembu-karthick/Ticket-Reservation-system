
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>pnr</title>
<link rel="stylesheet" href="/RailwayReservation/topnav.css">
<style>

#box{
	border-style: groove ;
    width:33em;
    background-color: slateblue;
    margin-left:auto;
    margin-right:auto;
    border-radius:10px;
}
label{
    margin-top: 1em;
    display: inline-block;
    width: 35%;
    margin-bottom: 1em;
    margin-left: 1em;
}
input{
    border-radius:10px;
}
    .tb{  
    		width:60%;
            margin-top:1em;
            margin-left: auto;
            margin-right: auto;
            border-style:groove;
            border-color:white;
             background-color:slateblue;
           	text-align: center;
        }
        .tr{
        	background-color:black;	
        }
      
        button{
            font-family:'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-se;
            border-radius:10px;
            font-size: 15px;
            margin-left:1em;
            width:15%;
    	 
        }
        .tb button{
        font-family:'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-se;
            border-radius:10px;
            font-size: 15px;
            width:50%;
            text-align:center;
           
        }
         #nroutes{
        
        width:35em;
        margin:auto;
        text-align:center;
        background-color:darkmagenta;
        
    }
        
body{
    font-family:'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-se;
    color:white;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.7/handlebars.min.js"></script>
    <script id="table-template" type="text/x-handlebars-template">
			 <div id="nroutes"> {{res}} </div>
            <table class="tb">
                <tr class="tr">
                <th>Train No</th>
                <th>Source</th>
                <th>Destination</th>
				<th>Class</th>
                <th>Journey date</th>
				<th>Price</th>
				<th>Passenger</th>
                </tr>
                <tr> <td>{{train}}</td> <td>{{src}}</td> <td>{{des}}</td> <td>{{class}}</td><td>{{jd}}</td><td>{{pr}}</td><td>{{passn}}</td></tr>
            </table>
			<table class="tb">
                <tr class="tr">
                <th>Name</th>
                <th>Age</th>
                <th>Gender</th>
				<th>Berth</th>
                <th>Berth type</th>
				<th>Booking Status</th>
                </tr>
			{{#each pass}}
                <tr><td>{{name}}</td> <td>{{age}}</td> <td>{{gender}}</td> <td>{{berth}}</td><td>{{berth_t}}</td> <td>{{status}}</td><td> 
		{{#ifeq status 'CN'}}
    		<button onClick="canc({{berth}})">Cancel</button></td></tr>
		{{/ifeq}}
            {{/each}}
			</table>
    </script>
    <script>
    	function canc(b){
    		 var pnr = $('#tx').val();
                 $.ajax({
                     url        : 'cancel', 
                     method     : 'POST',
                     data	   :{berth:b,pnr:pnr},
                     success  : function(resultText){
                     //    const obj = JSON.parse(resultText);
                         alert(resultText);
                     }
              });
    	}
    	Handlebars.registerHelper('ifeq', function (a, b, options) {
    	    if (a == b) { return options.fn(this); }
    	    return options.inverse(this);
    	});
        function extract(ourData){
            var rawTemplate = document.getElementById("table-template").innerHTML;
            var compiledTemplate = Handlebars.compile(rawTemplate);
            var ourGeneratedHTML = compiledTemplate(ourData);
            var ticket = document.getElementById("ticket");
            ticket.innerHTML = ourGeneratedHTML;		
        }
    	 $(document).ready(function(){
    	 		$("#dataform").submit(function func(event){
    	 			event.preventDefault();
            var pnr = $('#tx').val();
                $.ajax({
                    url        : 'http://localhost:8080/RailwayReservation/pnr_status', 
                    method     : 'POST',
                    data	   :{pnr:pnr},
                    success  : function(resultText){
                        const obj = JSON.parse(resultText);
                        extract(obj);
                    }		
             });
        });
    	 });
    </script>
</head>
<body bgcolor=  #707B7C>
<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-store");
	HttpSession ses=request.getSession();
	if(ses.getAttribute("user")==null){
		 response.sendRedirect(request.getContextPath());
	}
 %>
 <div class="topnav">
        <a href="/RailwayReservation/SearchUI.jsp">Home</a>
        <a href="/RailwayReservation/ticket.jsp">Ticket</a>
        <a  href="/RailwayReservation/PNRStatus.jsp">PNR status</a>
        <a class="active" href="/RailwayReservation/cancellation.jsp">Cancellation</a>
        <a href="/RailwayReservation/profile.jsp">Profile</a>
    </div>
 <form id="dataform">
    <div id="box">
		<label>Enter your PNR number</label>
		<input type='text' id="tx" required/>
		<button type="submit">Find</button>
	</div>
	</form>
<div id="ticket"> </div>
</body>
</html>