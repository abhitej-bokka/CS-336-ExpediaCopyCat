<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Forum Page</title>
</head>
<body>
	Welcome to the Waitlist page!
	<br>
	<% Date date = new Date();
	SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("MM-dd-yyyy");
	String mmDDyyyyToday = DATE_FORMAT.format(date);
	%>
	Today's date is: 
	<%= mmDDyyyyToday
	%>
	<br>
	<input type="button" value="Go Back to Landing Page!"
		onclick="window.location='LandingPage.jsp'">

	<br>
	<br>
	<form method="post" action="ForumSearchQuery.jsp">
		<table>
			<tr>
				<td>Ask a question:</td>
				<td><input type="text" name="question"></td>
			</tr>
		</table>
		<input type="submit" value="Ask Question!">
	</form>

	<br>

	<form method="post" action="ForumSearchQuery.jsp">
		<table>
			<tr>
				<td>Search questions by a keyword:</td>
				<td><input type="text" name="keyword"></td>
			</tr>
		</table>
		<input type="submit" value="Search Question!">
	</form>
	<br>


	<%
		try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();

		//if(!request.getParameter("specificAirlineFilter").isBlank() && request.getParameter("specificAirlineFilter").length() != 2) throw new Exception();

		//Create a SQL statement
		Statement stmt = con.createStatement();
		//Get the selected radio button from the index.jsp
		StringBuilder queryString = new StringBuilder();
		queryString.append("SELECT * FROM Forum");
		
		//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
		//Run the query against the database.
		ResultSet result = stmt.executeQuery(queryString.toString());
	%>

	<!--  Make an HTML table to show the results in: -->
	<table>
		<tr>
			<td>Number</td>
			<td>Question</td>
			<td>Answer</td>
		</tr>
		<%
			//parse out the results
		while (result.next()) {
		%>
		<tr>
			<td><%=result.getString("qnumber")%></td>
			<td><%=result.getString("question")%></td>
			<td><%=result.getString("answer")%></td>
		</tr>


		<%
			}
		//close the connection.
		db.closeConnection(con);
		%>
	</table>


	<%
		} catch (Exception e) {
	out.print(e.toString());
	out.print("There was an error with the query. Try revamping your inputs and try again.");
	}
	%>














</body>
</html>