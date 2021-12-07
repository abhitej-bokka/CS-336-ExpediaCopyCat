<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Forum Search Query</title>
</head>
<body>

	<%
		try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();

		//if(!request.getParameter("sendQuestion").isBlank() && request.getParameter("searchQuestions").length() != 2) throw new Exception();
		//idk why we check if its isn't blank and length!=2

		//Create a SQL statement
		Statement stmt = con.createStatement();
		Statement stmt2 = con.createStatement();
		//Get the selected radio button from the index.jsp	
		StringBuilder queryString = new StringBuilder();
		//StringBuilder secondQuery = new StringBuilder();
		//secondQuery.append("SELECT Forum.qnumber FROM Forum ORDER BY qnumber DESC LIMIT 2");
		//ResultSet secondresult = stmt2.executeQuery(secondQuery.toString());
		//String number = secondresult.getString("qnumber");
		//number++;
		//System.out.println(number);
		queryString.append("SELECT * FROM Forum");
		//queryString.append(!request.getParameter("keyword").isBlank() ? " WHERE Forum.question LIKE '%" + request.getParameter("keyword") + "%' " : "");

		if (!(request.getParameter("keyword") == null)) {
			String keyword = request.getParameter("keyword");
			String[] words = keyword.split("\\W+");

			//for(int i = 0; i <words.length; i++){
			//System.out.println(words[i]);
			//}
			queryString.append(" WHERE Forum.question LIKE '%" + keyword + "%'");
			queryString.append(" OR Forum.answer LIKE '%" + keyword + "%'");

			for (int j = 0; j < words.length; j++) {
		queryString.append(" OR Forum.question LIKE '%" + words[j] + "%'");
		queryString.append(" OR Forum.answer LIKE '%" + words[j] + "%'");
		//System.out.println("hi");
			}
			
		}

		if (!(request.getParameter("question") == null)) {
			//System.out.println("hi");
			//float qnumber = Float.valueOf(request.getParameter("qnumber"));
			int qnumber = (int) Math.floor(Math.random() * 1000);
			
			//System.out.println(qnumber);
			String question = request.getParameter("question");
			String answer = "Not Answered Yet.";

			String insert = "INSERT INTO Forum(qnumber, question, answer)" + "VALUES (?, ?, ?)";
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(insert);

			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps.setInt(1, qnumber);
			ps.setString(2, question);
			ps.setString(3, answer);
			//Run the query against the DB
			ps.executeUpdate();
			//con.close();
		}

		

		//Run the query against the DB

		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.

		
		//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
		//Run the query against the database.
		ResultSet result = stmt.executeQuery(queryString.toString());
	%>

	<!--  Make an HTML table to show the results in: -->

	<input type="button" value="Go Back to Forum!"
		onclick="window.location='Forum.jsp'">
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