<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.time.*, java.time.format.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Reservations</title>
	</head>
	
	<body>
		<br>
		
		<% try {
	
			//Get the database connection
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();		
				
				//Create a SQL statement
				Statement stmt = con.createStatement();
				String ticketNumber = request.getParameter("ticketNumber");
				
				ApplicationDB db2 = new ApplicationDB();	
				Connection con2 = db2.getConnection();
				Statement stmt2 = con2.createStatement();
				
				String query = "SELECT * FROM customers WHERE username = '" + request.getParameter("customerName") + "'";
				System.out.println(query);
				ResultSet result2 = stmt.executeQuery(query);
				result2.first();
				int currentUserId = result2.getInt("cid");
				
				
				String str = "SELECT * FROM FlightTicket where ticketNumber = "+Integer.parseInt(ticketNumber);
				ResultSet result = stmt.executeQuery(str);				
				
				if(!result.first()) {
					request.setAttribute("message", "There is no such ticket number!");
					request.getRequestDispatcher("ViewAllReservations.jsp").forward(request,response);
					con.close();
				}else{					
					int totalPrice = result.getInt("totalPrice");
					int flightNumber = result.getInt("flightNumber");
					System.out.println(totalPrice);
					DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");  
					LocalDateTime now = LocalDateTime.now(); 
					String[] dateTimeSplit = dtf.format(now).split(" ");
					str = "INSERT INTO BoughtBy VALUES ("+totalPrice+",'"+dateTimeSplit[0]+"','"+dateTimeSplit[1]+"',"+flightNumber+","+Integer.parseInt(ticketNumber)+","+currentUserId+")";
					System.out.println(str);
					stmt.execute(str);
					
					
					request.setAttribute("message", "Successfully reserved ticket for flight number "+flightNumber+"!");
					request.getRequestDispatcher("ViewAllReservations.jsp").forward(request,response);
				}
			
			}catch(Exception e) {
				if(e instanceof MySQLIntegrityConstraintViolationException) {
					request.setAttribute("customerName", request.getParameter("customerName"));
					request.setAttribute("message", "The customer has already reserved this ticket!");
					request.getRequestDispatcher("ViewAllReservations.jsp").forward(request,response);
				}
				System.out.println(e.toString());
				request.setAttribute("message", "");
			}
			
		%>
			
		<!--  Make an HTML table to show the results in: -->
		
		<p>${message}</p>

</body>
</html>