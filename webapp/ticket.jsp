<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>


<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="/RailwayReservation/topnav.css">
<style>
    body {
        font-family:'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-se;
        color:white;
    }
    
    .topnav {
    margin-bottom:2em;
    }

    .act {
    background-color:slateblue;
    color: white;
    }
    .tic{
    	
        margin:auto;
        width: 19.9em;
        overflow: hidden;
        background-color: #333;
    }
    .tic a {
    float: left;
    color: #f2f2f2;
    text-align: center;
    padding: 15px 40px;
    text-decoration: none;
    font-size: 17px;
    }
    .tic a:hover {
    background-color: #ddd;
    color: black;
    }
    .tic a.active {
    background-color:slateblue;
    color: white;
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
    .box  button{
        font-family:'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-se;
        border-radius:10px;
        margin-top:13px;
        font-size: 15px;
        width:20%; 
    }
    .tb{ 
        width:90%;
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
    .tno{
        margin-top:1em;
        text-align:center;
        background-color:darkmagenta;
         width:20%;
        font-size:30px;
        margin-left: auto;
        margin-right: auto;
        border-style:groove;
        border-radius:10px;
        
    }
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.7/handlebars.min.js"></script>
<script id="table-template" type="text/x-handlebars-template">
    {{#each tickets}}
        <table class="tb">
            <tr class="tr">
            <th>PNR</th>
            <th>Train no</th>
            <th>Source</th>
            <th>Destination</th>
            <th>Class</th>
			<th>Price</th>
			<th>Passengers</th>
            <th>Journey Date</th>
            <th>Booking Date</th>

            </tr>
            <tr>
                <td>{{pnr_no}}</td> 
                <td>{{train_no}}</td>
                <td>{{src}}</td> 
                <td>{{des}}</td>
                <td>{{class}}</td>
				<td>{{pr}}</td>
				<td>{{pass}}</td>
                <td>{{jd}}</td>
                <td>{{bd}}</td>
            </tr>
        </table>
        <br>
        <br>    
    {{/each}}
</script>
<script>
    function extract(ourData){

        var rawTemplate = document.getElementById("table-template").innerHTML;
        var compiledTemplate = Handlebars.compile(rawTemplate);
        var ourGeneratedHTML = compiledTemplate(ourData);
        var up_tickets = document.getElementById("up_tickets");
        up_tickets.innerHTML = ourGeneratedHTML;
    }
 //   window.onload = function() {
	 function func(type){	
		console.log(type);
		 if(type=='com'){
		 document.getElementById('com').className ="act";
		 document.getElementById('up').className ="act_";
		 }
		 else{
			 document.getElementById('up').className ="act";
			 document.getElementById('com').className ="act_";
		 }
         $.ajax({
            url        : 'http://localhost:8080/RailwayReservation/upcoming', 
            method     : 'POST',
            data	   :{type:type},
      	    success  : function(resultText){
            const obj = JSON.parse(resultText);
            console.log(obj);
                 extract(obj);
             	}
            });
    }
</script>
</head>
<body bgcolor=#707B7C>
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
        <a class="active" href="/RailwayReservation/ticket.jsp">Ticket</a>
        <a href="/RailwayReservation/PNRStatus.jsp">PNR status</a>
        <a href="/RailwayReservation/cancellation.jsp">Cancellation</a>
        <a href="/RailwayReservation/profile.jsp">Profile</a>
    </div>
<div class="tic">
    <a onClick="func('up')" id="up">Upcoming</a>
    <a onClick="func('com')" id="com">Completed</a>
</div>
<div id="up_tickets"></div>
</body>
</html>