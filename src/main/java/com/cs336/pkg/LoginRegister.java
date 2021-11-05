package com.cs336.pkg;

import java.io.IOException;

import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/LoginRegister")
public class LoginRegister extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public LoginRegister() {

    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			Statement stmt = con.createStatement();
	
			//Get parameters from the HTML form at the index.jsp
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			String submitType = request.getParameter("submit");
			
			
			if(submitType.equals("login")) {
				
				String str = "SELECT username, password FROM customers";
				//Run the query against the database.
				ResultSet result = stmt.executeQuery(str);
				
				while(result.next()){
					if(result.getString("username").equals(username)) {
						if(result.getString("password").equals(password)) {
							if(username.equals("admin")) {
								request.setAttribute("message", "");
								request.getRequestDispatcher("AdminPage.jsp").forward(request,response);
								con.close();
								return;
							}else if(username.equals("customerrep")){
								request.setAttribute("message", "");
								request.getRequestDispatcher("CustomerRepPage.jsp").forward(request,response);
								con.close();
								return;
							}else {
								request.setAttribute("message", "");
								request.setAttribute("usernameLoggedIn", username);
								request.getRequestDispatcher("LandingPage.jsp").forward(request,response);
								con.close();
								return;
							}
						}else {
							request.setAttribute("message", "Incorrect password.");
							request.getRequestDispatcher("Login.jsp").forward(request,response);
							con.close();
							return;
						}
					}
				}
				
				con.close();
				request.setAttribute("message", "Could not find user.");
				request.getRequestDispatcher("Login.jsp").forward(request,response);
				

				
				
			}else if(submitType.equals("register")) {
				String email = request.getParameter("email");
				String firstName = request.getParameter("firstName");
				String lastName = request.getParameter("lastName");
				
				String str = "SELECT username FROM customers";
				//Run the query against the database.
				ResultSet result = stmt.executeQuery(str);
				
				while(result.next()){
					if(result.getString("username").equals(username)) {
						con.close();
						request.setAttribute("message", "Username is already in use.");
						request.getRequestDispatcher("Register.jsp").forward(request,response);
						return;
					}
				}

				
				//Make an insert statement for the Sells table:
				String insert = "INSERT INTO customers(firstName, lastName, reservationList, email, username, password)"
						+ "VALUES (?, ?, ?, ?, ?, ?)";
				//Create a Prepared SQL statement allowing you to introduce the parameters of the query
				PreparedStatement ps = con.prepareStatement(insert);

				//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
				ps.setString(1, firstName);
				ps.setString(2, lastName);
				ps.setString(3, null);
				ps.setString(4, email);
				ps.setString(5, username);
				ps.setString(6, password);
				
				//Run the query against the DB
				ps.executeUpdate();
				//Run the query against the DB
				
				//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
				con.close();
				request.setAttribute("message", "");
				request.getRequestDispatcher("Login.jsp").forward(request,response);
			}
			
		}catch(Exception e) {
			System.out.println(e.toString());
			request.setAttribute("message", "");
		}
	}

}
