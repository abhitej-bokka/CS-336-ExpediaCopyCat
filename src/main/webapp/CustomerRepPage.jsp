<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Customer Representative</title>
	</head>
	
	<body>
		This is the Customer Representative Panel! <!-- the usual HTML way -->
		<br>
		<br>
		<form action="AddReservation.jsp"  method="POST">
			<label for="salesReport">Make a flight reservation for a specific customer: </label><br>
	  		<input type="text" id="ticketNumber" name="ticketNumber" placeholder="Enter ticket number"><br>
	  		<input type="text" id="customerName" name="customerName" placeholder="Enter customer username"><br>		
			<input type="submit" name="submit" value="Add Flight Reservation!">
		</form><br>
		<form action="ViewAllReservations.jsp"  method="POST">
			View Customer's Flight Reservations:
	  		<input type="text" id="customerName" name="customerName" placeholder="Enter Customer username"><br>		
			<input type="submit" name="submit" value="View flight reservations!" onclick="window.location='ViewAllReservations.jsp'">
		</form><br>
		<input type="button" value="View Customer Questions!" onclick="window.location='Login.jsp'" >
		<br>		
		<input type="button" value="View Aircrafts!" onclick="window.location='Login.jsp'" >
		<br>		
		<input type="button" value="View Airports!" onclick="window.location='Login.jsp'" >
		<br>		
		<input type="button" value="View Flights!" onclick="window.location='Login.jsp'" >
		<br>		
		<form action="#"  method="POST">
			View Waitlist for specific flight:
	  		<input type="text" id="flightNumber" name="flightNumber" placeholder="Enter Flight ID"><br>		
			<input type="submit" name="submit" value="View Waitlist!">
		</form><br>
		<form action="#"  method="POST">
			View Flights for specific airport:
	  		<input type="text" id="airportName" name="airportName" placeholder="Enter Airport"><br>		
			<input type="submit" name="submit" value="View Flights!">
		</form><br>
		<br>
		<br>
		<input type="button" value="Log Out!" onclick="window.location='Login.jsp'" >
	</body>
</html>