<%@page import="sun.security.provider.MD5"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import="java.sql.*"%>
<%@ page import="oracle.jdbc.pool.OracleDataSource"%>
<%
   if (session.getAttribute("username") == null)
   {
        response.sendRedirect("index.jsp");
      return;
    }

    Connection conn = null;
    ResultSet rset = null;
    String error_msg = "";
    String uName = session.getAttribute("username").toString();
    String uuid = "empty";
   
    
    try
    {
        OracleDataSource ods = new OracleDataSource();

        ods.setURL("jdbc:oracle:thin:qz2198/VGeTjRzp@//w4111g.cs.columbia.edu:1521/ADB");
        conn = ods.getConnection();
        Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
       
        String sql = "select * from MUser m where m.uName='"+uName+"'";
        
        rset = stmt.executeQuery(sql);
        rset.next();
        uuid = rset.getString("UUID");
        
        session.setAttribute("uuid", uuid);
        //System.out.println(rset.getString("UUID"));
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
<title>Welcome to Review</title>
</head>
<body>
	<jsp:include page="include/menu.jsp" />


	

	<h2>Write Review</h2>
  
	
	<form method=get action="writemoviereview1.jsp">
		<p>
			<label class="Review_lb" for="mName">Name:</label><input
				type="text" name="mName"></input>
		</p>
		<p>
			<label class="Review_lb" for="mrcontent">Review:</label><input
				type="text" name="mrcontent"></input>
		</p>
		<p>
			<label class="Review_lb" for="mrstar">Star:</label><input
				type="text" name="mrstar"></input>
		</p>
		
		
		<input class="btn Review_btn" type=submit value="Review">
	</form>
	
	
	
	
</body>
</html>