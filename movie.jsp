<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import="java.sql.*"%>
<%@ page import="oracle.jdbc.pool.OracleDataSource"%>

<%
    Connection conn = null;
    ResultSet rset = null;
    ResultSet rset1 = null;
    ResultSet rset2 = null;
    String error_msg = "";
    String mName = "";
    String mmid ="";
    String l1="";
    try
    {
        OracleDataSource ods = new OracleDataSource();

        ods.setURL("jdbc:oracle:thin:qz2198/VGeTjRzp@//w4111g.cs.columbia.edu:1521/ADB");
        conn = ods.getConnection();
        Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
        Statement stmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
        mName = request.getParameter("mName");
        String sql = "select * from Movie m  where m.mName='" + mName + "'";
        rset = stmt.executeQuery(sql);
         
      
        String sql2 = "select * from Movie m  where m.mName='" + mName + "'";
        rset2 = stmt2.executeQuery(sql2);
        rset2.next();
        mmid = rset2.getString("mmid");
        
        
        Statement stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
        
        String sql1 = "select * from MoviePhoto_MPof m where m.mmid='"+mmid+"'";
        rset1 = stmt1.executeQuery(sql1);
        rset1.next();
        l1 = rset1.getString("mplink");
      
        
        
        
        
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
     <p>
     <img border="0" src="<%=l1%>" alt="Pulpit rock" width="304" height="228">
     </p>
	<div class='movie_detail'>
		<% 
		    if (rset.next())
		    {   //out.print(l1);
		        out.print("<div><p class='movie_label'></p><p>" + rset.getString("mName") + "</p></div>");
		        out.print("<div><p class='movie_label'></p><b>" + rset.getString("mYear") + "</b></div>");
		        out.print("<div><p class='movie_label'></p><p>" + rset.getString("mDescription") + "</p></div>");
		        out.print("<div><p class='movie_label'></p><p>" + rset.getString("mLength") + "</p></div>");
		        out.print("<div><p class='movie_label'></p><p>" + rset.getString("mGenre") + "</p></div>");
		        out.print("<td><a href='moviereview.jsp?mmid=" + rset.getString("mmid") + "'>" + "Review" + "</td>");
		        rset.beforeFirst();
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