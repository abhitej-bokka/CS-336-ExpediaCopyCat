<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Login</title>
	</head>
	
	<body>
		Welcome to our traveling website, ${usernameLoggedIn}! <!-- the usual HTML way -->
		<br>
		<input type="button" value="Log Out!" onclick="window.location='Login.jsp'" >
		<input type="button" value="Search for flights!" onclick="window.location='FlightSearch.jsp'" >
		<input type="button" value="View Past Reservations!" onclick="window.location='PastReservations.jsp'" >
		<input type="button" value="View Upcoming Reservations!" onclick="window.location='CurrentReservations.jsp'" >
		<form action="#"  method="POST">
			<label for="specificAirline">Send a question!:</label>
	  		<input type="text" id="specificAirlineFilter" name="specificAirlineFilter"><br>		
			<input type="button" value="sendQuestion" onclick="window.location='FlightSearch.jsp'" >
		</form>
		<form action="#"  method="POST">
			<label for="specificAirline">Search questions by a keyword:</label>
	  		<input type="text" id="specificAirlineFilter" name="specificAirlineFilter"><br>		
			<input type="button" value="searchQuestions" onclick="window.location='FlightSearch.jsp'" >
		</form>
	</body>
</html>