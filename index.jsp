<%@page import="sun.security.provider.MD5"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import="java.sql.*"%>
<%@ page import="com.csw4111.*"%>
<%@ page import="oracle.jdbc.pool.OracleDataSource"%>

<%
    Connection conn = null;
    ResultSet rsCustomer = null;
    String uName = "";
  
    String uPassword = "";
    String error_msg = "";
    try
    {

        uName = request.getParameter("username");
        uPassword = request.getParameter("password");
        
        
        if (uPassword != null)
        {
         

            OracleDataSource ods = new OracleDataSource();

            ods.setURL("jdbc:oracle:thin:qz2198/VGeTjRzp@//w4111g.cs.columbia.edu:1521/ADB");
            conn = ods.getConnection();

            Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            rsCustomer = stmt.executeQuery("select * from MUser m where m.uName='" + uName  +"' and m.uPassword= '" + uPassword + "'");
            
            if (rsCustomer != null && rsCustomer.next())
            {
            	
                conn.close();
                session.setAttribute("username", uName);
                
                response.sendRedirect("movies.jsp");
                return;
            }
            else
            {
                conn.close();
                response.sendRedirect("index.jsp?error=true");
             
                return;
            }
        }
    }
    catch (SQLException e)
    {
        error_msg = e.getMessage();
        if (conn != null)
        {
            conn.close();
        }
    }
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/layout.css">
<title>Welcome to our Website</title>
</head>
<body>
	<jsp:include page="include/menu.jsp" />

	<h2>Welcome to Website</h2>
	<%
	    if (session.getAttribute("username") == null)
	    {
	%>

	<h2>Please login</h2>

	<form method=get action="index.jsp">
		<p>
			<label class="login_lb" for="username">Username:</label><input
				type="text" name="username"></input>
		</p>
		<p>
			<label class="login_lb" for="password">Password:</label><input
				type="password" name="password"></input>
		</p>
		<div>
			<input class="btn login_btn" type=submit value="Login"></input> 
		</div>
	</form>
	<%
	    if (request.getParameter("error") != null)
	        { 
	    	
		
	%>
	<p class="login_error">Wrong username or password! Please try
		again.</p>
	<%
	    }
	%>
	<%
	    }
	%>

	<%
	    if (conn != null)
	    {
	        conn.close();
	    }
	%>
</body>
</html>