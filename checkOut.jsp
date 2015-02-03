<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import="java.sql.*"%>
<%@ page import="oracle.jdbc.pool.OracleDataSource"%>
<%@ page import="com.csw4111.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Random"%>

<%
    Connection conn = null;
    ResultSet rset = null;
    ResultSet rset2 = null;
    ResultSet rset3 = null;
    ResultSet rset4 = null;
    ResultSet rset5 = null;
    String error_msg = "";
    String tnumber = "";
    String uName = session.getAttribute("username").toString();
    String uuid = "";
    String ooDate =null;
    String msg="purchesed";
    try
    {
        OracleDataSource ods = new OracleDataSource();

        ods.setURL("jdbc:oracle:thin:qz2198/VGeTjRzp@//w4111g.cs.columbia.edu:1521/ADB");
        conn = ods.getConnection();
        Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
        Statement stmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
        Statement stmt3 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
        Statement stmt4 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
        Statement stmt5 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
        tnumber = request.getParameter("tNumber");
        System.out.print(tnumber);
        String sql2= "Select max(oid) as aa from Order_OrderBy_GetFrom ";
		rset3= stmt3.executeQuery(sql2);
		rset3.next();
        int maxID=Integer.parseInt(rset3.getString("aa"));
	    maxID++;
	    System.out.print(maxID);
	    String mxID=Integer.toString(maxID);
	   // System.out.print(mxID);
	    SimpleDateFormat date = new SimpleDateFormat(
				"yyyy/MM/dd HH:mm:ss");
		
		ooDate = date.format(new java.util.Date());
		System.out.print(ooDate);
       String sql1 ="select * from MUser m where m.uName='"+uName+"'";
       rset2 = stmt2.executeQuery(sql1);
       rset2.next();
       uuid = rset2.getString("UUID");
       System.out.print(uuid);
      String sql = "insert into Order_OrderBy_GetFrom(oid,odate,tnumber,uuid) values('"+mxID+"', to_date('"+ooDate+"','yyyy/mm/dd hh24:mi:ss'),'"+tnumber+"','"+uuid+"')";
      //stmt.executeQuery(sql);
       stmt.executeUpdate(sql);
       
       String sql4="select O.tid, O.mmid,to_char(O.mdate,'YYYYMMDD HH24:MI:SS') as nn1,O.amount as amount from Ticket_Ticketabout T, OnShow O where T.tid=O.tid and T.mmid=O.mmid and T.mdate=O.mdate and T.tNumber='"+ tnumber +"'";
       rset4=stmt4.executeQuery(sql4);
       rset4.next();
       int aamount=Integer.parseInt(rset4.getString("amount"));
       aamount=aamount-1;
       String nn2=rset4.getString("tid");
       String nn3=rset4.getString("mmid");
       String nn4=rset4.getString("nn1");
       
       
      // String aamount=rset4.getString("amount");
       System.out.print(aamount);
       String sql5="update OnShow O set O.amount=O.amount-1 where O.tid='"+ nn2 +"' and O.mmid='"+ nn3 +"' and to_char(O.mdate,'YYYYMMDD HH24:MI:SS')='"+ nn4 +"'   ";
       stmt5.executeUpdate(sql5);
       
       
       
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
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"> <title>Employee Table JSP Sample</title>
</head>
<body>

	  <script language="javascript">

       	alert("<%=msg%>");

        self.location='buyticketstep2.jsp';</script>
	
	<%
	
	
	
	    if (conn != null)
	    {
	        conn.close();
	    }
	%>
	
</body>
</html>