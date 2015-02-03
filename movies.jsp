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
    String searchParam = "";
    try
    {
        OracleDataSource ods = new OracleDataSource();

        ods.setURL("jdbc:oracle:thin:qz2198/VGeTjRzp@//w4111g.cs.columbia.edu:1521/ADB");
        conn = ods.getConnection();
        Statement stmt = conn.createStatement();
        String sql = "select * from movie";
        if (request.getParameter("search") != null && request.getParameter("search") != "")
        {
            searchParam = request.getParameter("search");
            String likeParam = "%" + searchParam + "%";
            sql = "select * from movie where LOWER(mName) like LOWER('" + likeParam + "') or LOWER(mYear) like LOWER('" + likeParam + "') or LOWER(mGenre) like LOWER('" + likeParam + "')";
        }
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
<title>Movies</title>
</head>
<body>
	<jsp:include page="include/menu.jsp" />
	<h2>Movies</h2>
	

	<form action="movies.jsp">
		<div style="margin-bottom:10px;">
			<p style="float:left;margin-right:5px;height:26px;line-height:26px;">Search for Title, Year or Genre: </p><input type="text" name="search"
				value='<%=searchParam%>' style="width:200px;"></input>
				<input class="btn" type=submit value="Search">
				<input class="btn" type=button value="Clear" onclick="location.href='movies.jsp'">
		</div>		
	</form>
	
	<table cellpadding="5" border="1">
		<tr>
			
			<th>Title</th>
			<th>Year</th>
			<th>Genre</th>
			
			
			
		</tr>
		<%
		    if (rset != null)
		    {
		        while (rset.next())
		        {
		            out.print("<tr>");
		            out.print("<td><a href='movie.jsp?mName=" + rset.getString("mName") + "'>" + rset.getString("mName") + "</td><td><a href='movie.jsp?mName=" + rset.getString("mName") + "'>" + rset.getString("mYear") + "</td>" + "<td><a href='movie.jsp?mName=" + rset.getString("mName") + "'>" + rset.getString("mGenre") + "</td>");
		         //   out.print("<td><input value='Add' type=button onclick=\"location.href='addToCart.jsp?isbn=" + rset.getString("isbn") + "&mid=" + rset.getString("mid") + "'\"></input></td>");
		            out.print("</tr>");
		        }
		    }
		    else
		    {
		        out.print(error_msg);
		    }
		    if (conn != null)
		    {
		        conn.close();
		    }
		%>
	</table>
</body>
</html>