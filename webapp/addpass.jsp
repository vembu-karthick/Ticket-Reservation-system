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
			width:50em;
            margin-right:auto;
            margin-left:auto;
			border-style:groove;
			border-radius:20px;
			background-color:slateblue;
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
        #fromt{
            font-size:20px;
        }
        #tot{
            font-size:20px;
        }
        #oth{
            font-size:20px;
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
      
        
        var ind=1;
        var li=new Set();
        li.add(0);
        function att(){
        	var di=`<div id="`+ind+`"><div>
                <label for="name`+ind+`" >Name </label>
                <input type="text" name="name`+ind+`" required/>
            </div> 
            <div>
                <label for="age`+ind+`" class="lb">Age</label>
                <input type="number" name="age`+ind+`" required/>
                <button  type="button" onClick="del(`+ind+`)">Delete</button>
            </div>
            <div>
                <label for="gender`+ind+`" class="lb">Gender</label>
                <select name="gender`+ind+`" id="gender" required>
                    <option value=""></option>
                    <option value="M">M</option>
                    <option value="F">F</option>
                    <option value="T">T</option>
                </select>
            </div>
    </div>`
    var parser = new DOMParser();
	var doc = parser.parseFromString(di, 'text/html');
	console.log(doc);
    var db=doc.body.firstChild;
    console.log(db);
    var of=document.getElementById("pass");
    of.appendChild(db);
    console.log(of);
    li.add(ind);
    ind++;
    console.log(li);
        }
    function del(i){
        var of=document.getElementById("pass");
        var ch=document.getElementById(i);
        console.log(ch);
    // var parser = new DOMParser();
	// var doc = parser.parseFromString(ch, 'text/html');
	// console.log(doc);x
    // var db=doc.body.firstChild;
        of.removeChild(ch);
        li.delete(i);
        console.log(li);
    }
    function ext(){
        var str='';
        for(let i of li){
            str+=i;
        }
        console.log(str);
       document.getElementsByName("arr")[0].value=str;;
            arr=document.getElementsByName("arr")[0];
        console.log(arr);
        console.log(arr.value);
        
    }
    $(document).ready(function(){
		$("#dataform").submit(function func(event){
			event.preventDefault();
		    ext();
		 	document.getElementById("dataform").submit();
		     document.getElementById("dataform").reset();
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
	<h1 id ="tit">Train Reservation System </h1>
	<!-- <div id="upbox">
        <div id="from">${from}</div>
        <div id="to">${to}</div>
        <div id="from_t">${fromt}</div>
        <div id="to_t">${tot}</div>
		<div id="oth">
		${train_no}<br>
		${cl}<br>
		${clv}<br>
		${date}<br>
		${pr}</div>
	</div> -->
    <table id="upbox">
        <tr ><td class="r1">${from}</td><td></td><td class="r1">${to}</td></tr>
        <tr ><td class="r2">${fromt}</td><td></td><td class="r2">${tot}</td></tr>
        <tr><td></td><td class="m">Date - ${date}</td><td></td></tr>
        <tr><td></td><td class="m">Class - ${cl}</td><td></td></tr>
        <tr><td></td><td class="m">Seats - ${clv}</td><td></td></tr>
        <tr><td></td><td class="m">Price - ${pr}</td><td></td></tr>
    </table>
	<div id="box">
		<center> <h1> Ticket Booking </h1> </center>
    <form action="confirm" method="post" id="dataform">
        <div id="pass">
        <div id="0">
            <div>
                <label for="name0" >Name </label>
                <input type="text" name="name0" required/>
            </div>
            <div>
                <label for="age0" >Age</label>
                <input type="number" name="age0" required/>
                
            </div>
            <div>
                <label for="gender0" >Gender</label>
                <select name="gender0" required>
                    <option value=""></option>
                    <option value="M">M</option>
                    <option value="F">F</option>
                    <option value="T">T</option>
                </select>
            </div>
        </div> 
    </div> 
      
            <button  type="button" class="but" onClick="att()"> AddPasssenger</button>
        <!-- <button onClick="delete()"> AddPasssenger</button> -->
       
       <%--  <div class="coa">
            <label >Class </label> <h3 id="cl">${cl}</h3> --%>
       <!--   </div> -->
       <%--  <div class="coa">
         <label >Price</label> <h3 id="pr">${pr}</h3> </div> --%>
         	<input type="hidden" name="cl" value="${cl}"/>
         	<input type="hidden" name="clv" value="${clv}"/>
         	<input type="hidden" name="pr" value="${pr}"/>
			<input type="hidden" name="train_no" value="${train_no}"/>
			<input type="hidden" name="date" value="${date}"/>
			<input type="hidden" name="fromIn" value="${fromIn}"/>
         	<input type="hidden" name="toIn" value="${toIn}"/>
             <input type="hidden" name="arr" value="" />
        <div>
            <label for="address" class="lb">Address</label>
            <input type="text" name="address"  required>
        </div>
        <div>
            <label for="ph" class="lb">Phone number</label>
            <input type="tel" name="ph"  required>
        </div>
        <div>
            <label for="email" class="lb">Email id   </label>
            <input type="email" name="email"  required>
        </div>
		<input type="submit" class="but" value="Continue">
	</div>
</form>
<!-- <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT_xsaf05a8r5Jwzsg1j95VfwBP2RqSYv6oKg&usqp=CAU"> -->
</body>
</html>