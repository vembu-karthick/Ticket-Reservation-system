<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>bts.com</title>
<style>
	.box{   
            padding-top:1em;
            padding-bottom:1em;
            text-align:center;
            margin-top:3em;
            width:30em;
            font-size:20px;
            margin-left: auto;
            margin-right: auto;
            border-style:groove;
            border-radius:20px;
            background-color:rgb(58, 31, 147);
            margin-bottom:2em;
        }
       #upbox{
            padding-top: 1em;
            padding-bottom: 1em;
			margin-top:5em;
			width:39em;
            margin-right:auto;
            margin-left:auto;
            text-align:center;
            border-collapse: separate;
    		border-spacing: 10px;	
			
        }
         #upbox .r1{
            width:5em;
            font-size:25px;
            background-color:rgb(17, 17, 126);
            border-radius:10px;
        }
        #upbox .r2{
            width:9em;
            background-color:rgb(39, 39, 168);
            border-radius:10px;
        }
        #upbox .m{
            width:8em;
            background-color:rgb(50, 50, 217);
            border-radius:10px;
        }
        .pass{
        	margin-top:0.7em;
        }
        .pas{
            padding-top:0.4em;
           
        }
        .pas .n{
            display:inline-block;
            width:7em;
        
        }
        .pas .a{
            display:inline-block;
            width:7em;
            text-align: center;
        }
        .pas .g{
            display:inline-block;
            width:7em;
            text-align: center;
        }
        #details{
            padding-top:0.7em;
            text-align:center;
        }
        button{
        	font-family:'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-se;
        	color:white;
            padding:auto;
            margin-top:0.6em;
        	width:6em;
        	background-color:mediumblue;
        	border-radius:10px;
        } 
        body {
            font-family:'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-se;
            color:white;
        }
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>

    var json='${js}';
//     var json = '[' +
// '{ "firstName":"John" , "lastName":"Doe" },' +
// '{ "firstName":"Anna" , "lastName":"Smith" },' +
// '{ "firstName":"Peter" , "lastName":"Jones" } ]';

  //  console.log(json);
    const obj=JSON.parse(json);
  //  console.log(obj);
    var passdiv=document.createElement('div');
    passdiv.setAttribute('class','pas');
    function data(){
        for(var key in obj){
            var passdiv=document.createElement('div');
            passdiv.setAttribute('class','pas');
            var n=document.createElement('span');
            n.setAttribute('class','n');
            n.innerHTML=obj[key].name;
            passdiv.appendChild(n);
            var a=document.createElement('span');
            a.setAttribute('class','a');
            a.innerHTML=obj[key].age;
            passdiv.appendChild(a);
            var g=document.createElement('span');
            g.setAttribute('class','g');
            g.innerHTML=obj[key].gender;
            passdiv.appendChild(g);
     //   var c=`<span class="n">`+obj[key].firstName +`</span> <span class="a">`+ obj[key].firstName +`</span> <span class="g">`+obj[key].firstName+`</span>`;
     //  console.log(typeof passdiv);
      //  console.log(passdiv);
      document.getElementById("pass").appendChild(passdiv);
      //var passi=document.getElementById("pass");
        // passi.appendChild(passdiv);
        // console.log(passi);
            //   var c=`<div class="pas"> <span class="n">`+ obj[key].name+`</span> <span class="a">`+ obj[key].age+`</span> <span class="g">`+ obj[key].gender+`</span></div>`
           /*  $('#n'+a+' .n').html=obj[key].name;
            $('#n'+a+' .a').html=obj[key].age;
            $('#n'+a+' .g').html=obj[key].gender; */
        }
        
    }
    function func(){
        var js='${js}';
        console.log(js);
        var from ='${from}';
        var to='${to}';
        var train_no='${train_no}';
        var cl='${cl}';
        var pr='${pr}';
        var seats='${seats}';
        var address='${address}';
        var ph='${ph}';
        var email='${email}';
        var date='${date}';
			$.ajax({
				url        : 'http://localhost:8080/RailwayReservation/final', 
				method     : 'POST',
				data	   :{from:from,to:to,date:date,train_no:train_no,cl:cl,pr:pr,seats:seats,address:address,ph:ph,email:email,js:js},
				success  : function(resultText){
					const obj = JSON.parse(resultText)
					alert(obj.result);
				}
				});
        }
</script>
</head>

<body bgcolor=#707B7C onLoad="data()">
<!-- <%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-store");
	HttpSession ses=request.getSession();
	if(ses.getAttribute("user")==null){
		 response.sendRedirect(request.getContextPath());
	}
 %> -->
	<table id="upbox">
        <tr ><td class="r1">${from}</td><td></td><td class="r1">${to}</td></tr>
        <tr ><td class="r2">${fromt}</td><td></td><td class="r2">${tot}</td></tr>
        <tr><td></td><td class="m">Date - ${date}</td><td></td></tr>
        <tr><td></td><td class="m">Class - ${cl}</td><td></td></tr>
        <tr><td></td><td class="m">Berth - ${seats}</td><td></td></tr>
        <tr><td></td><td class="m">Price - ${pr}</td><td></td></tr>
    </table>
<div class="box">
	<div id="tr">Train No - ${train_no}</div>
    <div id="pass">
    </div>
	<div id="details">
        ${address}<br>
        ${ph}<br>
        ${email}<br>
    </div>
	<button onClick="func()">Confirm</button>
</div> 
</body>
</html>