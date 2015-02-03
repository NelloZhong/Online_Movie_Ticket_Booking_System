<div id="navigation">
	<ul class="menubar">
		<li><a href="index.jsp">Home</a></li>
		<li><a href="movies.jsp">Movies</a></li>
		<li><a href="theaters.jsp">Theaters</a></li>
	
		<li><a href="writemoviereview.jsp">Write Movie Review</a></li>
		<li><a href="writetheaterreview.jsp">Write Theater Review</a></li>
		<li><a href="buyticket.jsp">Buy Ticket</a></li>
		<li><a href="myinformation.jsp">My Information</a></li>
		<li><a href="myorders.jsp">My Orders</a></li>

		<%
		    if (session.getAttribute("username") != null)
		    {
		%>
		<li class="menu_username">Welcome <%=session.getAttribute("username")%>, <a
			href="Logout.jsp">Logout</a>
		</li>
		<%
		    }
		%>
	</ul>
</div>