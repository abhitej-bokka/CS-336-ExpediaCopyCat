<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%!
	public boolean checkTime(String time){
		if(time.matches("\\d{2}:\\d{2}")) return false;
		String[] timeSplit = time.split(":");
		if(Integer.parseInt(timeSplit[0]) > 23) return false;
		if(Integer.parseInt(timeSplit[1]) > 23) return false;
		return true;
	}
%>

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
			
			if(!request.getParameter("specificAirlineFilter").isBlank() && request.getParameter("specificAirlineFilter").length() != 2) throw new Exception("Airline filter format is incorrect. ");
			if(!request.getParameter("fromAirport").isBlank() && !request.getParameter("fromAirport").matches("[A-Z]{3}")) throw new Exception("From airport format is incorrect. ");
			if(!request.getParameter("toAirport").isBlank() && !request.getParameter("toAirport").matches("[A-Z]{3}")) throw new Exception("To airport format is incorrect. ");


			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the selected radio button from the index.jsp
			StringBuilder queryString = new StringBuilder();
			queryString.append("SELECT * FROM FlightTicket");
			
			
			
			queryString.append(" WHERE (SELECT isOneWay FROM Flights WHERE FlightTicket.flightNumber = Flights.flightNumber) = ");
			queryString.append(request.getParameter("tripType").equals("isOneWay") ? "1" : "0");
			
			if(!request.getParameter("fromAirport").isBlank()) {
				queryString.append(" AND fromAirport = '"+request.getParameter("fromAirport")+"'");
			}
			if(!request.getParameter("toAirport").isBlank()){
				queryString.append(" AND toAirport = '"+request.getParameter("toAirport")+"'");
			}
			
			queryString.append(!request.getParameter("maximumPriceFilter").isBlank() ? " AND FlightTicket.totalPrice <= "+request.getParameter("maximumPriceFilter") : "");
			queryString.append(!request.getParameter("numberOfStopsFilter").isBlank() ? " AND FlightTicket.numberOfStops = "+request.getParameter("numberOfStopsFilter") : "");
			queryString.append(!request.getParameter("specificAirlineFilter").isBlank() ? " AND FlightTicket.alid = '"+request.getParameter("specificAirlineFilter")+"'" : "");
			
			
			if(!request.getParameter("takeOffStartTime").isBlank()){
				String time = request.getParameter("takeOffStartTime");
				if(!time.matches("\\d{2}:\\d{2}")) throw new Exception("Take Off / Departure Time format is incorrect. ");
				String[] timeSplit = time.split(":");
				if(Integer.parseInt(timeSplit[0]) > 23) throw new Exception("Take Off / Departure Time format is incorrect. ");
				if(Integer.parseInt(timeSplit[1]) > 59) throw new Exception("Take Off / Departure Time format is incorrect. ");
				 
				queryString.append(" AND FlightTicket.departureTime >= '" + request.getParameter("takeOffStartTime")+"'");

			}
			if(!request.getParameter("takeOffEndTime").isBlank()){
				String time = request.getParameter("takeOffEndTime");
				if(!time.matches("\\d{2}:\\d{2}")) throw new Exception("Take Off / Departure Time format is incorrect. ");
				String[] timeSplit = time.split(":");
				if(Integer.parseInt(timeSplit[0]) > 23) throw new Exception("Take Off / Departure Time format is incorrect. ");
				if(Integer.parseInt(timeSplit[1]) > 59) throw new Exception("Take Off / Departure Time format is incorrect. ");	
				queryString.append(" AND FlightTicket.departureTime <= '" + request.getParameter("takeOffEndTime")+"'");
			}
			if(!request.getParameter("landingStartTime").isBlank()){
				String time = request.getParameter("landingStartTime");
				if(!time.matches("\\d{2}:\\d{2}")) throw new Exception("Take Off / Departure Time format is incorrect. ");
				String[] timeSplit = time.split(":");
				if(Integer.parseInt(timeSplit[0]) > 23) throw new Exception("Take Off / Departure Time format is incorrect. ");
				if(Integer.parseInt(timeSplit[1]) > 59) throw new Exception("Take Off / Departure Time format is incorrect. ");
				queryString.append(" AND FlightTicket.destinationTime >= '" + request.getParameter("landingStartTime")+"'");
			}
			if(!request.getParameter("landingEndTime").isBlank()){
				String time = request.getParameter("landingEndTime");
				if(!time.matches("\\d{2}:\\d{2}")) throw new Exception("Take Off / Departure Time format is incorrect. ");
				String[] timeSplit = time.split(":");
				if(Integer.parseInt(timeSplit[0]) > 23) throw new Exception("Take Off / Departure Time format is incorrect. ");
				if(Integer.parseInt(timeSplit[1]) > 59) throw new Exception("Take Off / Departure Time format is incorrect. ");
				queryString.append(" AND FlightTicket.destinationTime <= '" + request.getParameter("landingEndTime")+"'");
			}
			
			if(request.getParameter("searchDateType").equals("searchBySpecificDate")){
				if(!request.getParameter("trip-start-single-date").matches("\\d{4}-\\d{2}-\\d{2}")) throw new Exception("Date format is incorrect. ");
				queryString.append(" AND FlightTicket.departureDate = '"+request.getParameter("trip-start-single-date")+"'");
				
			}else if(request.getParameter("searchDateType").equals("searchByFlexibleDate")){
				if(!request.getParameter("trip-start").matches("\\d{4}-\\d{2}-\\d{2}")) throw new Exception("Date format is incorrect. ");
				if(!request.getParameter("trip-end").matches("\\d{4}-\\d{2}-\\d{2}")) throw new Exception("Date format is incorrect. ");
				queryString.append(" AND FlightTicket.departureDate >= '"+request.getParameter("trip-start")+"' AND FlightTicket.departureDate <= '"+request.getParameter("trip-end")+"'");
				
			}
			
			if(request.getParameter("sortByDropDown").equals("priceSortBy")){
				queryString.append(" order by totalPrice asc");
			}else if(request.getParameter("sortByDropDown").equals("takeOffTime")){
				queryString.append(" order by departureTime asc");
			}else if(request.getParameter("sortByDropDown").equals("landingTime")){
				queryString.append(" order by destinationTime asc");
			}else if(request.getParameter("sortByDropDown").equals("flightDuration")){
				queryString.append(" order by TIMESTAMPDIFF(minute, TIMESTAMP(departureDate, departureTime), TIMESTAMP(destinationDate, destinationTime)) asc");
			}
			
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			//Run the query against the database.
			System.out.println(queryString.toString());
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
			<td>Number of Stops</td>
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
					<td><%= result.getString("numberOfStops") %></td>
				</tr>

			<% }
			//close the connection.
			db.closeConnection(con);
			%>
		</table>
		
		<br />
		
		<form action="FlightSearch" method = "POST">
			 Reserve a ticket!<br />
			 Flight Ticket Number: <input type="text" name="flightTicketNumber"><br/>
			<input type="submit" name="submit" value="Reserve!" /><br />
		</form>
		
		<input type="button" value="Back to landing page!" onclick="window.location='LandingPage.jsp'" >
		

			
		<%} catch (Exception e) {
			out.print(e.toString());
			out.print("There was an error with the query. Try revamping your inputs and try again.");
		}%>
	

	</body>
</html>