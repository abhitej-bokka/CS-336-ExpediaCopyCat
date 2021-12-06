<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Flight Search Query</title>
	</head>
	<body>
	
		<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		
			
			if(!request.getParameter("specificAirlineFilter").isBlank() && request.getParameter("specificAirlineFilter").length() != 2) throw new Exception();

			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the selected radio button from the index.jsp
			StringBuilder queryString = new StringBuilder();
			queryString.append("SELECT * FROM FlightTicket");
			queryString.append(" WHERE (SELECT isOneWay FROM Flights WHERE FlightTicket.flightNumber = Flights.flightNumber) = ");
			queryString.append(request.getParameter("tripType").equals("isOneWay") ? "1" : "0");
			queryString.append(!request.getParameter("maximumPriceFilter").isBlank() ? " AND FlightTicket.totalPrice <= "+request.getParameter("maximumPriceFilter") : "");
			System.out.println(!request.getParameter("specificAirlineFilter").isBlank() ? " AND FlightTicket.alid = "+request.getParameter("specificAirlineFilter") : "");
			queryString.append(!request.getParameter("specificAirlineFilter").isBlank() ? " AND FlightTicket.alid = "+request.getParameter("specificAirlineFilter") : "");
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(queryString.toString());
		%>
			
		<!--  Make an HTML table to show the results in: -->
	<table>
		<tr>    
			<td>Ticket Number</td>
			<td>From</td>
			<td>To</td>
			<td>Airline</td>
			<td>Class</td>
			<td>Seat Number</td>
			<td>Booking Fee</td>
			<td>Cancel Charge</td>
			<td>Departure Date</td>
			<td>Departure Time</td>
			<td>Destination Date</td>
			<td>Destination Time</td>
			<td>Total Price</td>
		</tr>
			<%
			//parse out the results
			while (result.next()) { %>
				<tr>    
					<td><%= result.getString("ticketNumber") %></td>
					<td><%= result.getString("fromAirport") %></td>
					<td><%= result.getString("toAirport") %></td>
					<td><%= result.getString("alid") %></td>
					<td><%= result.getString("class") %></td>
					<td><%= result.getString("seatNumber") %></td>
					<td><%= result.getString("bookingFee") %></td>
					<td><%= result.getString("cancelCharge") %></td>
					<td><%= result.getString("departureDate") %></td>
					<td><%= result.getString("departureTime") %></td>
					<td><%= result.getString("destinationDate") %></td>
					<td><%= result.getString("destinationTime") %></td>
					<td><%= result.getString("totalPrice") %></td>
				</tr>
				

			<% }
			//close the connection.
			db.closeConnection(con);
			%>
		</table>

			
		<%} catch (Exception e) {
			out.print(e.toString());
			out.print("There was an error with the query. Try revamping your inputs and try again.");
		}%>
	

	</body>
</html>