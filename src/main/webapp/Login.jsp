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

		Login <!-- the usual HTML way -->
		<br>
	
		 <!-- Show html form to i) display something, ii) choose an action via a 
		  | radio button -->
		<!-- forms are used to collect user input 
			The default method when submitting form data is GET.
			However, when GET is used, the submitted form data will be visible in the page address field-->
		<form action = "LoginRegister" method = "POST">
	         Username: <input type="text" name="username">
	         <br />
	         Password: <input type="text" name="password" />
	         <br />
	         <input type="submit" name="submit" value="login" />
      	</form>
		<br>
		<input type="button" value="Register Here!" onclick="window.location='Register.jsp'" >
		<p>${message}</p>

</body>
</html>