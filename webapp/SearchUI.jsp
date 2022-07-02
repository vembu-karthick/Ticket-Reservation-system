<%@ page language="java" contentType="text/html; charset=ISO-8859-1"  pageEncoding="ISO-8859-1"%>
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
        margin-bottom:2em;
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
    .tno{
        text-align:center;
        background-color:darkmagenta;
       	width:15em;
        font-size:30px;
        margin-left: auto;
        margin-right: auto;
        border-style:groove;
        border-radius:10px;
        margin-bottom:1em;
    }
    .dno{
    	text-align:center;
        background-color:darkmagenta;
       	width:20em;
        font-size:13px;
        margin-left: auto;
        margin-right: auto;
        border-style:groove;
        border-radius:10px;
        margin-bottom:1em;
    }
    #nroutes{
        
        width:35em;
        margin:auto;
        text-align:center;
        background-color:darkmagenta;
        
    }
    .cap{
        text-align:center;
        width:25em;
        margin-top:1em;
        margin-left:auto;
        margin-right:auto;
        
    }
    .cap button{
        font-family:'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-se;
        color:white;
        text-align:center;
        width:6em;
        background-color:darkmagenta;
        border-radius:10px;
    } 
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.7/handlebars.min.js"></script>
 <script id="table-template" type="text/x-handlebars-template">
    <div id="nroutes"> {{res}} </div>
    {{#each train}}
     <div class="tno">Train no : {{train_no}}</div>
	<div class="dno">Days : {{days}}</div>
        <table class="tb">
            <tr  class="tr">
            <th>Station</th>
            <th>Timing</th>
            <th>Days</th>
            </tr>
            {{#each routes}}
            <tr> <td>{{station}}</td> <td>{{timing}}</td> <td>{{days}}</td> </tr>
            {{/each}}	
        </table>
    <form action="/RailwayReservation/addpassenger" method="POST" id="slform">
            <input name="fromIn" type="hidden" value="{{fromIn}}"/>
            <input name="toIn" type="hidden" value="{{toIn}}"/>
            <input name="from" type="hidden" value="{{from}}"/>
            <input name="to" type="hidden" value="{{to}}"/>
            <input name="fromt" type="hidden" value="{{fromt}}"/>
            <input name="tot" type="hidden" value="{{tot}}"/>
            <input name="train_no" type="hidden" value="{{train_no}}"/>
            <input name="date" type="hidden" value="{{date}}"/>
            <input name="cl" type="hidden" value="SL"/>
            <input name="clv" type="hidden" value="{{SL}}"/>
            <input name="pr" type="hidden" value="{{lpr}}"/>	
    </form>
    <form action="/RailwayReservation/addpassenger" method="POST" id="2sform">
            <input name="fromIn" type="hidden" value="{{fromIn}}"/>
            <input name="train_no" type="hidden" value="{{train_no}}"/>
            <input name="from" type="hidden" value="{{from}}"/>
            <input name="to" type="hidden" value="{{to}}"/>
            <input name="fromt" type="hidden" value="{{fromt}}"/>
            <input name="tot" type="hidden" value="{{tot}}"/>
            <input name="toIn" type="hidden" value="{{toIn}}"/>
            <input name="date" type="hidden" value="{{date}}"/>
            <input name="cl" type="hidden" value="2S"/>
            <input name="clv" type="hidden" value="{{2S}}"/>
            <input name="pr" type="hidden" value="{{spr}}"/>	
    </form>
    <form action="/RailwayReservation/addpassenger" method="POST" id="acform">
            <input name="fromIn" type="hidden" value="{{fromIn}}"/>
            <input name="toIn" type="hidden" value="{{toIn}}"/>
            <input name="from" type="hidden" value="{{from}}"/>
            <input name="to" type="hidden" value="{{to}}"/>
            <input name="fromt" type="hidden" value="{{fromt}}"/>
            <input name="tot" type="hidden" value="{{tot}}"/>
            <input name="train_no" type="hidden" value="{{train_no}}"/>
            <input name="date" type="hidden" value="{{date}}"/>
            <input name="cl" type="hidden" value="AC"/>
            <input name="clv" type="hidden" value="{{AC}}"/>
            <input name="pr" type="hidden" value="{{apr}}"/>	
    </form>
    <div class="cap">
        <button type="submit" form="slform" value="Submit"> SL - {{SL}} <br>{{lpr}}</button>
        <button type="submit" form="2sform" value="Submit"> 2S - {{2S}} <br>{{spr}}</button>
        <button type="submit" form="acform" value="Submit"> AC - {{AC}} <br>{{apr}}</button>
    </div>
        <br>
        <br>    
    {{/each}}
</script>   
 <script>
	 function next(fi,ti,c,p){
	     var q="/RailwayReservation/addpassenger?fromIn="+fi+"&toIn="+ti+"&cl="+c+"&pr="+p;
	     console.log(q);
	     window.location.href=q;
	 }
    function findDay(dateString){
        var d = new Date(dateString);
        return d.getDay();

    }
    function extract(ourData){
        var rawTemplate = document.getElementById("table-template").innerHTML;
        var compiledTemplate = Handlebars.compile(rawTemplate);
        var ourGeneratedHTML = compiledTemplate(ourData);
        var routes = document.getElementById("routes");
         routes.innerHTML = ourGeneratedHTML;	
       }
	 $(document).ready(function(){
		$("#dataform").submit(function func(event){
			event.preventDefault();
        var from = $('#from').val();
        var to = $('#to').val();
        var date = $('#date').val();
        /* 
          from='erode';
        to='salem';  */
        var day=findDay(date);
        
        console.log(date);
        console.log(typeof date);
            $.ajax({
                url        : 'http://localhost:8080/RailwayReservation/journey', 
                method     : 'GET',
                data	   :{from:from,to:to,date:date,day:day},
                success  : function(resultText){
                 	$('#from').val('');
                    $('#to').val('');
                    $('#date').val(''); 
                    const obj = JSON.parse(resultText);
                    extract(obj);
                }
                });     
   		});
	 });
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
    <a class="active" href="/RailwayReservation/SearchUI.jsp">Home</a>
    <a href="/RailwayReservation/ticket.jsp">Ticket</a>
    <a href="/RailwayReservation/PNRStatus.jsp">PNR status</a>
    <a href="/RailwayReservation/cancellation.jsp">Cancellation</a>
    <a href="/RailwayReservation/profile.jsp">Profile</a>
</div>
<div class="box">
<form id="dataform">
    <div class="f">
        <label> From</label>	
        <br>
        <input type="text" id="from" required/> 
    </div>
    <div class="f">	
        <label> To</label>
        <br>
        <input type="text" id="to" required/> 
    </div>
    <div class="f">
        <label> Date</label>
        <br>
        <input type="date" id="date" required/> 
    </div>
    <button type="submit" onCLick="func()"> Search
    </button>

</form>
</div>
<div id="routes"></div>
</body>
</html>