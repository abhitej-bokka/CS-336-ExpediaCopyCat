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


@WebServlet("/FlightSearch")
public class FlightSearch extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public FlightSearch() {

    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			Statement stmt = con.createStatement();
	
			//Get parameters from the HTML form at the index.jsp
			String ticketNumber = request.getParameter("flightTicketNumber");
			String submitType = request.getParameter("submit");
			
			
			if(submitType.equals("Reserve!")) {
				
				String str = "SELECT * FROM FlightTicket where ticketNumber = "+Integer.parseInt(ticketNumber);
				ResultSet result = stmt.executeQuery(str);
				
				if(!result.first()) {
					request.setAttribute("message", "There is no such ticket number!");
					request.getRequestDispatcher("CurrentReservations.jsp").forward(request,response);
					con.close();
				}else{					
					int currentUserId = getCurrentUserId(ApplicationDB.currentUsername);

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
					request.getRequestDispatcher("CurrentReservations.jsp").forward(request,response);
				}
			}
		}catch(Exception e) {
			if(e instanceof MySQLIntegrityConstraintViolationException) {
				request.setAttribute("message", "You've already reserved this ticket!");
				request.getRequestDispatcher("CurrentReservations.jsp").forward(request,response);
			}
			System.out.println(e.toString());
			request.setAttribute("message", "");
		}
	}

	private int getCurrentUserId(String currentUsername) throws SQLException {
		// TODO Auto-generated method stub
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		
		String query = "SELECT * FROM customers WHERE username = '" + "ayush" + "'";
		System.out.println(query);
		ResultSet result = stmt.executeQuery(query);
		
		result.first();
		
		
		System.out.println(result.getInt("cid"));
		
		return result.getInt("cid");
	}
	
	private boolean checkIfAlreadyReserved(int ticketNumber, int currentUserId) throws SQLException{
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
