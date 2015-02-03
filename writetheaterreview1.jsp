<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.csw4111.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="oracle.jdbc.pool.OracleDataSource"%>

<%
    if (session.getAttribute("username") == null) {
			response.sendRedirect("index.jsp");
			return;
		}

			Connection conn = null;
			ResultSet rset1 = null;
			ResultSet rset2 = null;
			ResultSet rset3 = null;
			String error_msg = "";
			String uuid = "";
			String msg = "Updated!";
			try {
				uuid = session.getAttribute("uuid").toString();
				String tName = request.getParameter("tName");
				String trcontent = request.getParameter("trcontent");
				int trstar = Integer.parseInt(request.getParameter("trstar")) ;
				SimpleDateFormat date = new SimpleDateFormat(
						"yyyy/MM/dd HH:mm:ss");
				
				String sql = "select * from Theater t where t.tName='" + tName + "'";
				
				
				
				String trdate= date.format(new java.util.Date());
				
			   // int random = (int) (Math.random()*100+1);
				
				OracleDataSource ods = new OracleDataSource();

				ods.setURL("jdbc:oracle:thin:qz2198/VGeTjRzp@//w4111g.cs.columbia.edu:1521/ADB");
				conn = ods.getConnection();
				Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
				Statement stmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
				Statement stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
				
				rset1 = stmt.executeQuery(sql);
				rset1.next();
				
				String tid = rset1.getString("tID");
				
				String sql2="select max(tt5.trid) as aa from tr_about_wb tt5 ";
				rset3 = stmt2.executeQuery(sql2);
				rset3.next();
				int maxID=Integer.parseInt(rset3.getString("aa"));
			    maxID++;
				
				
				String sql1 = "insert into tr_about_wb values ('"
						+ maxID
						+ "', '"
						+ trcontent
						+ "', '"
						+ trstar  
						+ "', to_date('"
						+ trdate
						+ "', 'yyyy/mm/dd hh24:mi:ss'),'"+
						
						tid+ "', '"+ uuid+"')";
				
				   stmt1.executeUpdate(sql1);
				
			
				

			} catch (SQLException e) {
				error_msg = e.getMessage();
			} 
			
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/layout.css">
<title>Update Cart</title>
</head>
<body>
	<script language="javascript">
		alert("<%=msg%>");
		self.location='writetheaterreview.jsp';
	</script>
	<%
	    if (conn != null)
	    {
	        conn.close();
	    }
	%>
</body>
</html>