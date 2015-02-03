<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<%@ page import="java.sql.*"%>
<%@ page import="java.util.Random"%>
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
			ResultSet rset3 =null;
			String error_msg = "";
			String uuid = "";
			String msg = "Updated!";
			String mName = null;
			String mrcontent =null;
			int mrstar =0;
			int random =0;
			String mrdate =null;
			String mmid =null;
			try {
				uuid = session.getAttribute("uuid").toString();
				
				
				mName = request.getParameter("mName");
				mrcontent = request.getParameter("mrcontent");
				mrstar = Integer.parseInt(request.getParameter("mrstar"))   ;
				
				SimpleDateFormat date = new SimpleDateFormat(
						"yyyy/MM/dd HH:mm:ss");
				
				mrdate = date.format(new java.util.Date());
				System.out.print(mrdate);
				
			    random = (int) (Math.random()*100+1);
				
			    
			    
			    OracleDataSource ods = new OracleDataSource();

				ods.setURL("jdbc:oracle:thin:qz2198/VGeTjRzp@//w4111g.cs.columbia.edu:1521/ADB");
				conn = ods.getConnection();
				Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
				Statement stmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
				Statement stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
				
				String sql = "select * from Movie m where m.mName='" + mName + "'";
				rset1 = stmt.executeQuery(sql);
				rset1.next();
				
				mmid = rset1.getString("mmid");
				String sql2= "Select max(mm5.mrid) as aa from mr_about_wb mm5 ";
				rset3= stmt2.executeQuery(sql2);
				rset3.next();
				int maxID=Integer.parseInt(rset3.getString("aa"));
			    maxID++;
				
				
				String sql1 = "insert into mr_about_wb values ('"+ maxID +"', '"
						+ mrcontent
						+ "', '"
						+ mrstar  
						+ "', to_date('"
						+ mrdate
						+ "', 'yyyy/mm/dd hh24:mi:ss'),'"+
						
						mmid+ "', '"+ uuid+"')";
				
				
				
			stmt1.executeUpdate(sql1);
				

			} catch (SQLException e) {
				error_msg = e.getMessage();
			} 
			
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"> <title>Employee Table JSP Sample</title>
</head>
<body>

	  <script language="javascript">

       	alert("<%=msg%>");

        self.location='writemoviereview.jsp';</script>
	
	<%
	
	
	
	    if (conn != null)
	    {
	        conn.close();
	    }
	%>
	
</body>
</html>