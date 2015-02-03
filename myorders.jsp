<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import="java.sql.*"%>
<%@ page import="oracle.jdbc.pool.OracleDataSource"%>

<%
    Connection conn = null;
    ResultSet rset = null;
    String error_msg = "";
    String uuid = "";
    try
    {
    	uuid=session.getAttribute("username").toString();
        OracleDataSource ods = new OracleDataSource();

        ods.setURL("jdbc:oracle:thin:qz2198/VGeTjRzp@//w4111g.cs.columbia.edu:1521/ADB");
        conn = ods.getConnection();
        Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
     
        System.out.print(uuid);
      // String sql = "select * from Order_OrderBy_GetFrom O where O.uuid='" + uuid + "'";
        String sql = "select * from order_orderby_getfrom  O, MUser U where U.uuid=O.uuid and U.uname='" + uuid + "'";
        //String sql = "select * from mr_about_wb m where m.mmid='m1'";
        rset = stmt.executeQuery(sql);
        rset.next();
        System.out.print(rset.getString("oid"));
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
<title>My Orders</title>
</head>
<body>
	<jsp:include page="include/menu.jsp" />
	<h2>My Orders</h2>
   
	<div class='order_detail'>
		<%
		   if(rset != null){
			    while (rset.next())
			    { // out.print("<td><a href='checkOut.jsp?tNumber=" + rset.getString("tNumber") + "'>"+ rset.getString("tNumber")); 
			        out.print("<div><p class='ticket_label'>oid :</p><p>" + rset.getString("oid") + "</p></div>");
			        out.print("<div><p class='ticket_label'>otime :</p><p>" + rset.getString("odate") + "</p></div>");
			    
			   
			     
			    }
			   }
		%>
	</div>

	
	
	<%
	    if (conn != null)
	    {
	        conn.close();
	    }
	%>
</body>
</html>