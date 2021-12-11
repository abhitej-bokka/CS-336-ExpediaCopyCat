package com.cs336.pkg;

import java.io.IOException;

import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException;


@WebServlet("/DCurrentReservations")
public class DCurrentReservations extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public DCurrentReservations() {

    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String submitType = request.getParameter("submit");
		
		if(submitType.equals("Remove Reservation!")) {
			try {
				StringBuilder queryString = new StringBuilder();
				StringBuilder also = new StringBuilder();
				StringBuilder third = new StringBuilder();
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();
				Statement stmt = con.createStatement();
				String ticketNumber = request.getParameter("flightTicketNumber");
				DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");  
				LocalDateTime now = LocalDateTime.now(); 
				String[] dateTimeSplit = dtf.format(now).split(" ");
				int currentUserId = getCurrentUserId(ApplicationDB.currentUsername, request);
				//String ticketNumber = request.getParameter("flightTicketNumber");
				
				//String query = "SELECT * FROM customers WHERE username = '" + ApplicationDB.currentUsername + "'";
				//ResultSet result;
				//result.first();
				
				
				//queryString.append("SELECT FlightTicket.class FROM FlightTicket WHERE (SELECT * FROM BoughtBy WHERE cid = "+currentUserId+" AND (SELECT departureTime FROM (SELECT * FROM FlightTicket WHERE ticketNumber = "+ticketNumber+" AND departureDate >= '"+dateTimeSplit[0]+"') A) >= '00:00:00')");		
				
				queryString.append("SELECT FlightTicket.class FROM FlightTicket WHERE ticketNumber = "+ticketNumber+"");
				
				System.out.println("abhitejSaysHello: "+queryString.toString());
				ResultSet result = stmt.executeQuery(queryString.toString());
				result.first();
				
				also.append("SELECT * FROM FlightTicket WHERE ticketNumber = "+ticketNumber+"");
				
				System.out.println("abhitejSayswiglllyly: "+also.toString());
				
				
				
				
				if(!result.first()) {
					request.setAttribute("message", "This is the first error!");
					request.getRequestDispatcher("CurrentReservations.jsp").forward(request,response);
					request.setAttribute("message", "");
				}
				System.out.println("ab--hitejSaysHello: "+also.toString());
				
				String classyy;
				if(result.getString("class").equals("Economy")) {
					classyy = "Economy";
				}else {
					classyy = "Business";
				}
				
				
				
				if(!(result.getString("class").equals("Economy"))) {
					
					String str = "DELETE FROM BoughtBy WHERE ticketNumber = "+Integer.parseInt(ticketNumber)+" AND cid = "+currentUserId;
					stmt.execute(str);
					request.setAttribute("message", ticketNumber+" is no longer reserved!");
					request.getRequestDispatcher("CurrentReservations.jsp").forward(request,response);
				
					
					System.out.println("Executedayya");
					
				}else {
					
					String str = "DELETE FROM BoughtBy WHERE ticketNumber = "+Integer.parseInt(ticketNumber)+" AND cid = "+currentUserId;
					stmt.execute(str);
					
					ResultSet resultalso = stmt.executeQuery(also.toString());
					resultalso.first();
					
					int flightNumber = resultalso.getInt("flightNumber");
					String alid = resultalso.getString("alid");
					System.out.println(flightNumber);
					System.out.println(alid);
					third.append("SELECT * FROM RSEATS WHERE flightNumber = "+flightNumber+" AND alid = '"+alid+"'");
					System.out.println("yee: "+third.toString());
					ResultSet resultthird = stmt.executeQuery(third.toString());
					resultthird.first();
					
					int ESeats = resultthird.getInt("ESeats");
					int BSeats = resultthird.getInt("BSeats");
					str = "DELETE FROM RSEATS WHERE flightNumber = "+flightNumber+" AND alid = '"+alid+"'";
					stmt.execute(str);
					if(classyy.equals("Economy")) {
						ESeats--;
						str = "INSERT INTO RSEATS VALUES ("+flightNumber+",'"+alid+"',"+ESeats+","+BSeats+")";
					}else {
						BSeats--;
						str = "INSERT INTO RSEATS VALUES ("+flightNumber+",'"+alid+"',"+ESeats+","+BSeats+")";
					}
					stmt.execute(str);
					
					//add airline ID and class
					System.out.println(str);
				}
				
				/*
				if(result.getString("class").equals("Economy") && check == 1) {
					String str = "DELETE FROM BoughtBy WHERE ticketNumber = "+Integer.parseInt(ticketNumber)+" AND cid = "+currentUserId;
					stmt.execute(str);
					request.setAttribute("message", ticketNumber+" is no longer reserved!");
					request.getRequestDispatcher("CurrentReservations.jsp").forward(request,response);
					System.out.println("Executed_twice");
					check = 0;
				}
				 */
		
				//Get parameters from the HTML form at the index.jsp
				
				
				
				/*
				 ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();		
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the selected radio button from the index.jsp
			StringBuilder queryString = new StringBuilder();
			
			DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");  
			LocalDateTime now = LocalDateTime.now(); 
			String[] dateTimeSplit = dtf.format(now).split(" ");
			
			String query = "SELECT * FROM customers WHERE username = '" + ApplicationDB.currentUsername + "'";
			ResultSet result = stmt.executeQuery(query);
			result.first();
			queryString.append("SELECT * FROM BoughtBy WHERE cid = "+result.getInt("cid")+" AND (SELECT departureTime FROM (SELECT * FROM FlightTicket WHERE ticketNumber = BoughtBy.ticketNumber AND departureDate >= '"+dateTimeSplit[0]+"') A) >= '00:00:00'");		
			System.out.println("Hello: "+queryString.toString());
			result = stmt.executeQuery(queryString.toString());

				 */
				
				
				
				
				
				
				
			}catch(Exception e) {
				
				System.out.println(e.getClass().getSimpleName());
				if(e instanceof MySQLIntegrityConstraintViolationException) {
					request.setAttribute("message", "You've already reserved this ticket!");
					request.getRequestDispatcher("CurrentReservations.jsp").forward(request,response);
				}
				System.out.println(e.toString());
				request.setAttribute("message", "Error ---finding user. That is not this user.!");
				request.getRequestDispatcher("CurrentReservations.jsp").forward(request,response);
				request.setAttribute("message", "");
			}
		}
		/*
		else {
			try {
				
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();
				Statement stmt = con.createStatement();
		
				//Get parameters from the HTML form at the index.jsp
				String ticketNumber = request.getParameter("flightTicketNumber");
					
				int currentUserId = getCurrentUserId(ApplicationDB.currentUsername, request);
				String str = "DELETE FROM BoughtBy WHERE ticketNumber = "+Integer.parseInt(ticketNumber)+" AND cid = "+currentUserId;
				stmt.execute(str);
				request.setAttribute("message", ticketNumber+" is no longer reserved!");
				request.getRequestDispatcher("ViewAllReservations.jsp").forward(request,response);
						
				
			}catch(Exception e) {
				
				System.out.println(e.getClass().getSimpleName());
				if(e instanceof MySQLIntegrityConstraintViolationException) {
					request.setAttribute("message", "You've already reserved this ticket!");
					request.getRequestDispatcher("ViewAllReservations.jsp").forward(request,response);
				}
				System.out.println(e.toString());
				request.setAttribute("message", "Error finding user. That is not this user.!");
				request.getRequestDispatcher("ViewAllReservations.jsp").forward(request,response);
				request.setAttribute("message", "");
			}
		}
		*/
	}

	private int getCurrentUserId(String currentUsername, HttpServletRequest request) throws SQLException {
		// TODO Auto-generated method stub
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		String query = "";
		if(request.getParameter("customerName") != null && !request.getParameter("customerName").isBlank()) {
			query = "SELECT * FROM customers WHERE username = '" + request.getParameter("customerName") + "'";
		}else {
			query = "SELECT * FROM customers WHERE username = '" + ApplicationDB.currentUsername + "'";
		}
		System.out.println("Hi: "+query);
		ResultSet result = stmt.executeQuery(query);
		
		result.first();
		
		
		System.out.println(result.getInt("cid"));
		
		return result.getInt("cid");
	}
	
	private boolean checkIfAlreadyReserved(int ticketNumber, int currentUserId) throws Exception{
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		
		String query = "SELECT * FROM BoughtBy WHERE cid = "+currentUserId+" AND ticketNumber = "+ticketNumber;
		System.out.println(query);
		ResultSet result = stmt.executeQuery(query);
		if(!result.first()) return true;
		return false;
		
	}

}
