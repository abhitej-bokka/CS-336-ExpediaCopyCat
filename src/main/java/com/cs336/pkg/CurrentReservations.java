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


@WebServlet("/CurrentReservations")
public class CurrentReservations extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public CurrentReservations() {

    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String submitType = request.getParameter("submit");
		
		if(submitType.equals("Remove Reservation!")) {
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
				request.getRequestDispatcher("CurrentReservations.jsp").forward(request,response);
						
				
			}catch(Exception e) {
				
				System.out.println(e.getClass().getSimpleName());
				if(e instanceof MySQLIntegrityConstraintViolationException) {
					request.setAttribute("message", "You've already reserved this ticket!");
					request.getRequestDispatcher("CurrentReservations.jsp").forward(request,response);
				}
				System.out.println(e.toString());
				request.setAttribute("message", "Error finding user. That is not this user.!");
				request.getRequestDispatcher("CurrentReservations.jsp").forward(request,response);
				request.setAttribute("message", "");
			}
		}else {
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
	}

	private int getCurrentUserId(String currentUsername, HttpServletRequest request) throws SQLException {
		// TODO Auto-generated method stub
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		String query = "";
		if(!request.getParameter("customerName").isBlank()) {
			query = "SELECT * FROM customers WHERE username = '" + request.getParameter("customerName") + "'";
		}else {
			query = "SELECT * FROM customers WHERE username = '" + "ayush" + "'";
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
