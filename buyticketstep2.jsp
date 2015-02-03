<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import="java.sql.*"%>
<%@ page import="oracle.jdbc.pool.OracleDataSource"%>

<%
    Connection conn = null;
    ResultSet rset = null;
    ResultSet rset2 = null;
    String error_msg = "";
    String mmid = "";
    String tid="";
    String mdate="";
    String odate="";
    String mName="";
    String mm="";
    String uName = session.getAttribute("username").toString();
    String uuid = "";
    System.out.print(uName);
    try
    {
        OracleDataSource ods = new OracleDataSource();

        ods.setURL("jdbc:oracle:thin:qz2198/VGeTjRzp@//w4111g.cs.columbia.edu:1521/ADB");
        conn = ods.getConnection();
        Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
        Statement stmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
        mmid = request.getParameter("mmID");
        tid = request.getParameter("tID");
        mdate=request.getParameter("aa");
        //mName=request.getParameter("mName");
        uName = session.getAttribute("username").toString();
        String sql1 ="select * from MUser m where m.uName='"+uName+"'";
       rset2 = stmt2.executeQuery(sql1);
       rset2.next();
        uuid = rset2.getString("UUID");
       //session.setAttribute("uuid", uuid);
       System.out.println(uuid);
        
        System.out.print(mmid);
        System.out.print(tid);
        System.out.print(mdate);
        System.out.print(mName);
        String sql = "select * from ticket_ticketabout T  where T.mmID='" + mmid + "' and T.tID='" + tid + "' and to_char(T.mdate,'YYYYMMDD HH24:MI:SS')='" +mdate+ "' and T.tNumber not in (select tNumber from Order_OrderBy_GetFrom)";
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
<title>Ticket</title>
</head>
<body>
	<jsp:include page="include/menu.jsp" />
	<h2>Ticket</h2>
   
	<div class='ticket_detail'>
		<%
		   if(rset != null){
			    while (rset.next())
			    { // out.print("<td><a href='checkOut.jsp?tNumber=" + rset.getString("tNumber") + "'>"+ rset.getString("tNumber")); 
			        out.print("<div><p class='ticket_label'>tNumber :</p><p>" + rset.getString("tNumber") + "</p></div>");
			        out.print("<div><p class='ticket_label'>time :</p><p>" + rset.getString("mdate") + "</p></div>");
			        %>
			    	
			    		
    	<%
			   
			     
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
<% 
//<input class="btn login_btn" type="button" value="Check Out"
	//		    		style='margin: 10px;' onclick="location.href='checkOut.jsp'">;
			    		
%>



