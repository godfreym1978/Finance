<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.Godfrey.Finance.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Style-Type" content="text/css">
<style type="text/css">
<%@ include file="Style.css" %>
</style>
<title>Bank Of America Checking</title>
</head>
<body>
<%
Connection conn = null;
Statement statement = null;
double oldDep =0.0;
double oldWith =0.0;
double newDep =0.0;
double newWith =0.0;
boolean firstRec = true;
int oldMonth = 0;
int newMonth = 0;


try{
ConnectDB newConnectDB = new ConnectDB();

ResultSet rs = null;

conn = newConnectDB.getDBConnection();

statement = conn.createStatement();

rs = statement.executeQuery("SELECT * FROM SUNTRUST_BANK_DTL ORDER BY SBD_DATE DESC ");
%>
<table border="1" class="gridtable">
<tr>
	<th>SBD_DATE</th>
	<th>SBD_DESC</th>
	<th>SBD_DEPOSIT</th>
	<th>SBD_WITH</th>
	<th>SBD_BAL</th>
</tr>
<%
while(rs.next()){
	
	if(firstRec){
		firstRec = false;
		oldDep = rs.getDouble("SBD_DEPOSIT");
		oldWith = rs.getDouble("SBD_WITH");
		oldMonth = rs.getDate("SBD_DATE").getMonth(); 
		%>
		<tr>
		<td><%=rs.getDate("SBD_DATE") %></td>
		<td><%=rs.getString("SBD_DESC") %></td>
		<td><%=rs.getDouble("SBD_DEPOSIT") %></td>
		<td><%=rs.getDouble("SBD_WITH") %></td>
		<td><%=rs.getDouble("SBD_BAL") %></td>
		</tr>
		<%
	}else{
		newMonth = rs.getDate("SBD_DATE").getMonth();
		if(oldMonth==newMonth){
			oldDep = oldDep+rs.getDouble("SBD_DEPOSIT");
			oldWith = oldWith+rs.getDouble("SBD_WITH");
			//oldMonth = rs.getDate("SBD_DATE").getMonth(); 
			%>
			<tr>
			<td><%=rs.getDate("SBD_DATE") %></td>
			<td><%=rs.getString("SBD_DESC") %></td>
			<td><%=rs.getDouble("SBD_DEPOSIT") %></td>
			<td><%=rs.getDouble("SBD_WITH") %></td>
			<td><%=rs.getDouble("SBD_BAL") %></td>
			</tr>
			<%
		}else{
			%>
			<tr>
			<th></th>
			<th>Summary</th>
			<th><%=oldDep %></th>
			<th><%=oldWith%></th>
			<th></th>
			</tr>
			<%
			oldDep = rs.getDouble("SBD_DEPOSIT");
			oldWith = rs.getDouble("SBD_WITH");
			oldMonth = rs.getDate("SBD_DATE").getMonth(); 
			%>
			<tr>
			<td><%=rs.getDate("SBD_DATE") %></td>
			<td><%=rs.getString("SBD_DESC") %></td>
			<td><%=rs.getDouble("SBD_DEPOSIT") %></td>
			<td><%=rs.getDouble("SBD_WITH") %></td>
			<td><%=rs.getDouble("SBD_BAL") %></td>
			</tr>
			<%

		}
		
	}

}
%>
<tr>
<th></th>
<th>Summary</th>
<th><%=oldDep %></th>
<th><%=oldWith%></th>
<th></th>
</tr>
<%
} catch (SQLException e) {

	System.out.println(e.getMessage());

} finally {

	if (statement != null) {
		statement.close();
	}

	if (conn != null) {
		conn.close();
	}

}

%>
</table>
</body>
</html>