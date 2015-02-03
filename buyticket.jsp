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
    ResultSet rset1 = null;
    ResultSet rset2 = null;
    String error_msg = "";
    String searchMovie = "";
    String searchTheater = "";
    int mmid;
    int tid;
    String date ="";
    String md="";
    
    try
    {
        OracleDataSource ods = new OracleDataSource();

        ods.setURL("jdbc:oracle:thin:qz2198/VGeTjRzp@//w4111g.cs.columbia.edu:1521/ADB");
        conn = ods.getConnection();
        Statement stmt = conn.createStatement();
        Statement stmt1 = conn.createStatement();
        Statement stmt2 = conn.createStatement();
        String sql = "select Th.tID,Th.tName,M.mmID,M.mName,Th.tLocation, o.mdate,to_char(o.mdate,'YYYYMMDD HH24:MI:SS') as md,o.amount,o.price from Movie M, Theater Th, OnShow o where o.mmid = M.mmid and Th.tid = o.tid";
   //    String sql="(select O.tID,O.mmID,O.mdate,O.price,count(O.amount) FROM Ticket_TicketAbout T1,OnShow O  Group by O.tID, O.mmID, O.mdate  Having count(O.amount)>0  WHERE Lower(M1.mName) like LOWER('" + likeParam1 + "') AND T1.mmID=O.mmID AND        O.tID=Th1.tID)";
        // String sql1 = null;
       // String sql2 = null;
        
        
        if (request.getParameter("search") != null && request.getParameter("search") != "")
        {
            searchMovie = request.getParameter("search");
            //searchTheater = request.getParameter("search");
            String likeParam1 = "%" + searchMovie + "%";
           // String likeParam2 = "%" + searchTheater + "%";
          // String sql = "select m.mmID form Movie m where m.mName= '" + mName + "'";
        //  String sql ="select m.mmID form Movie m where m.mName= '" + mName + "'";
        sql="select O.mmid, M.mname,T.tname, O.tID, O.mdate, to_char(O.mdate,'YYYYMMDD HH24:MI:SS') as md, O.amount O.price from onshow O, Movie M, Theater T where Lower(M.mName) like LOWER('" + likeParam1 + "') And O.mmid=M.mmid and T.tid=O.tid ";
       //   sql ="select Temp1.tID,Th.tName,Temp1.mmID,M1.mName, Temp1.mdate, Temp1.price,Th.tLocation from (select O.tID,O.mmID,O.mdate,count(O.amount) FROM Ticket_TicketAbout T1,OnShow O Group by O.tID, O.mmID,O.mdate Having count(O.amount)>0 WHERE T1.mmID=O.mmID AND O.tID=T1.tID) Temp1, Movie M1, Theater Th where Lower(M1.mName) like LOWER('" + likeParam1 + "') AND Temp1.mmID=M1.mmID AND Temp1.tID=Th.tID";
        	//sql="(select O.tID,O.mmID,O.mdate,count(O.amount) FROM Ticket_TicketAbout T1,OnShow O Group by O.tID, O.mmID, O.mdate Having count(O.amount)>0 WHERE T1.mmID=O.mmID AND  O.tID=Th1.tID)";	      
            //sql1 = "select t.tID form Theater t where t.tName= '" + tName + "'"; 
            
            
        }
        rset = stmt.executeQuery(sql);
        //System.out.print(rset.getString("md"));
       //rset.next();
     //  System.out.print(rset.getString("tid"));
        
      // if(sql1!=null){
      //  rset1 = stmt1.executeQuery(sql1);}
        
      //  mmid = rset.getInt("mmID");
        
      //  tid = rset1.getInt("tID");
        
      //  sql2 = "select * form OnShow o where o.tid= '" + tid + "' and o.mmid= '"+mmid+"'";
        
      //  rset2 = stmt2.executeQuery(sql2);
      //  date = rset2.getDate("mdate").toString();
     
      //  System.out.println(""+rset);
       
        

        
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
<title>Tickets</title>
</head>
<body>
	<jsp:include page="include/menu.jsp" />
	<h2>Tickets</h2>
	

	<form action="buyticket.jsp">
		<div style="margin-bottom:10px;">
			<p style="float:left;margin-right:5px;height:26px;line-height:26px;">Movie Name: </p><input type="text" name="search"
				value='<%=searchMovie%>' style="width:200px;"></input>
				<input class="btn" type=submit value="Search">
				<input class="btn" type=button value="Clear" onclick="location.href='buyticket.jsp'">
		</div>		
	</form>
	
	<table cellpadding="5" border="1">
		<tr>
		    <th>Movie ID</th>
			<th>Movie Name</th>
			<th>Theater ID</th>
			<th>Theater Name</th>
			<th>Theater Address</th>
			<th>Show Time</th>
			<th>Amount</th>
			<th>Price</th>
		</tr>
		<%
		    if (rset != null)
		    {
		        while (rset.next())
		        {
		            out.print("<tr>");
		           // out.print("<td><a href='buyticketstep2.jsp?mmID=" + rset.getString("mmID") + "'>" + rset.getString("mmID") + "</td><td><a href='buyticketstep2.jsp? mmID=" + rset.getString("mmID") + "'>" + rset.getString("mname") + "</td><td><a href='buyticketstep2.jsp?mmID=" + rset.getString("mmID") + "'>" + rset.getString("tID") + "</td></td><td><a href='buyticketstep2.jsp? mmID=" + rset.getString("mmID") + "'>" + rset.getString("tname") );
		            out.print("<td><a href='buyticketstep2.jsp?mmID=" + rset.getString("mmID") + "&tID=" + rset.getString("tID") + "&aa=" +rset.getString("md")+" '>" + rset.getString("mmID") + "</td><td><a href='buyticketstep2.jsp? mmID=" + rset.getString("mmID") + "'>" + rset.getString("mname") + "</td><td><a href='buyticketstep2.jsp?mmID=" + rset.getString("mmID") + "'>" + rset.getString("tID") + "</td></td><td><a href='buyticketstep2.jsp? mmID=" + rset.getString("mmID") + "'>" + rset.getString("tname")+"</td><td>"+rset.getString("tLocation")+"</td><td>"+rset.getString("mdate")+"</td><td>"+rset.getString("amount")+"</td><td>"+rset.getString("price"));
		           // out.print("<td>"+mName+tName+date+"</td>"  + "<td class=\"align_right\">" + String.format("%10.2f", rset.getBigDecimal("price")) +String.format("%10.2f", rset.getBigDecimal("amount"))+ "</td>");
		           // out.print("<td><input value='Add' type=button onclick=\"location.href='order.jsp?isbn=" + rset.getString("isbn") + "&mid=" + rset.getString("mid") + "'\"></input></td>");
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