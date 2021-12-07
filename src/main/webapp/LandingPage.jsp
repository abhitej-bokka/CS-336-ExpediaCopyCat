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
		Welcome to our traveling web site, ${usernameLoggedIn}! <!-- the usual HTML way -->
		<br>
		<input type="button" value="Log Out!" onclick="window.location='Login.jsp'" >
		<input type="button" value="Search for flights!" onclick="window.location='FlightSearch.jsp'" >
		<input type="button" value="View Upcoming Reservations!" onclick="window.location='UpcomingFlights.jsp'" >
		<input type="button" value="View Past Reservations!" onclick="window.location='PastFlights.jsp'" >
		<input type="button" value="Visit the Forum!" onclick="window.location='Forum.jsp'" >
	</body>
</html>