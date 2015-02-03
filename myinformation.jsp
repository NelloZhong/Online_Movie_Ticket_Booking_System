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
        String sql = "select * from MUser U where U.uname='" + uuid + "'";
        //String sql = "select * from mr_about_wb m where m.mmid='m1'";
        rset = stmt.executeQuery(sql);
        rset.next();
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
<title>My Information</title>
</head>
<body>
	<jsp:include page="include/menu.jsp" />
	<h2>My Information</h2>

	<div class='myinfo'>
	<div>
		<label class="login_lb">ID:</label>
		<p><%=rset.getString("uuid")%></p>
	</div>
	<div>
		<label class="login_lb">Name:</label>
		<p><%=rset.getString("uname")%></p>
	</div>
	<div>
		<label class="login_lb">Email:</label>
		<p><%=rset.getString("uemail")%></p>
	</div>


	
</div>

<%
    if (conn != null)
    {
        conn.close();
    }
%>
</body>
</html>