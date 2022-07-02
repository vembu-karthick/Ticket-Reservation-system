<%@ page language="java" contentType="text/html; charset=ISO-8859-1"  pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Search</ti	tle>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js">
	</script>
	<script>
		function func(){
		var name = $('#from').val();
			$.ajax({
				url     : 'http://localhost:8080/RailwayReservation/journey';
				method  : 'GET',
				data	:
				success : function(resultText){ $('#tab').html(resultText);},
				});
			}
	</script>
</head>
<body bgcolor=#707B7C>
	<div id="numlab" style="text-align:center" class="lab">
		<h1 id ="syName">Search Trains</h1>
			<label for="from"  class="lab">From  </label>
				<input type="text" id="from" class= "tx">
			<button  onClick="func()" id="sub">Submit</button>
		</div>
	<p id="tab"></p>
</body>
</html>	