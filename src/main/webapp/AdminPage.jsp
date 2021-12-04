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
		This is the Admin Panel! <!-- the usual HTML way -->
		<form action="#"  method="POST">
			<label for="salesReport">See sales report for specific month (format: Jan, Feb, Mar, etc.):</label>
	  		<input type="text" id="specificAirlineFilter" name="specificAirlineFilter"><br>		
			<input type="submit" name="submit" value="See Sales Report!">
		</form><br>
		<form action="#"  method="POST">
			<label for="reservations">See reservations by flight number: </label>
	  		<input type="text" id="flightNumberForReservations" name="flightNumberForReservations"><br>		
			<input type="submit" name="submit" value="See Reservations!">
		</form><br>
		<form action="#"  method="POST">
			<label for="reservations">See reservations by customer name: </label>
	  		<input type="text" id="customerNameForReservations" name="customerNameForReservations"><br>		
			<input type="submit" name="submit" value="See Reservations!">
		</form><br>
		<form action="#"  method="POST">
			<label for="reservations">See revenue by airline: </label>
	  		<input type="text" id="revenueByAirline" name="revenueByAirline"><br>		
			<input type="submit" name="submit" value="See Revenue!">
		</form><br>
		<form action="#"  method="POST">
			<label for="reservations">See revenue by customer name: </label>
	  		<input type="text" id="revenueByCustomerName" name="revenueByCustomerName"><br>		
			<input type="submit" name="submit" value="See Revenue!">
		</form><br>
		<form action="#"  method="POST">
			<label for="reservations">See revenue by flight number: </label>
	  		<input type="text" id="revenueByFlightNumber" name="revenueByFlightNumber"><br>		
			<input type="submit" name="submit" value="See Revenue!">
		</form><br>
		<input type="button" value="Show highest revenue-generating customer!" onclick="window.location='Login.jsp'" >
		<input type="button" value="Show most active flights!" onclick="window.location='Login.jsp'" >
		<br>
		<br>
		<br>
		<input type="button" value="Log Out!" onclick="window.location='Login.jsp'" >
		
	</body>
</html>