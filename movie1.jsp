<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import="java.sql.*"%>
<%@ page import="oracle.jdbc.pool.OracleDataSource"%>

<%
    Connection conn = null;
    ResultSet rset = null;
    String error_msg = "";
    String mYear = "";
    try
    {
        OracleDataSource ods = new OracleDataSource();

        ods.setURL("jdbc:oracle:thin:qz2198/VGeTjRzp@//w4111g.cs.columbia.edu:1521/ADB");
        conn = ods.getConnection();
        Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
        mYear = request.getParameter("mYear");
        String sql = "select * from Movie where mYear='" + mYear + "'";
        rset = stmt.executeQuery(sql);
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
<title>Movie</title>
</head>
<body>
	<jsp:include page="include/menu.jsp" />
	<h2>Movie</h2>

	<div class='movie_detail'>
		<%
		  while(rset != null){
		    if (rset.next())
		    {
		        out.print("<div><p class='movie_label'>mYear :</p><p>" + rset.getString("mYear") + "</p></div>");
		        
		      //  rset.beforeFirst();
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