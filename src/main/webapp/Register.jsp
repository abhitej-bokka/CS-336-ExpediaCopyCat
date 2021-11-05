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

		Register <!-- the usual HTML way -->
		<br>
	
		 <!-- Show html form to i) display something, ii) choose an action via a 
		  | radio button -->
		<!-- forms are used to collect user input 
			The default method when submitting form data is GET.
			However, when GET is used, the submitted form data will be visible in the page address field-->
		<form action = "LoginRegister" method="POST">
			 First Name: <input type="text" name="firstName" />
	         <br />
	         Last Name: <input type="text" name="lastName" />
	         <br />
	         Email: <input type="text" name="email" />
	         <br />
	         Username: <input type="text" name="username">
	         <br />
	         Password: <input type="text" name="password" />
	         <br />
	         <span>
	         <input type="submit" name="submit" value="register" />
	         <input type="button" value="Back to Login!" onclick="window.location='Login.jsp'" >
	         </span>
	         
      	</form>
		<br>
		<p>${message}</p>

</body>
</html>