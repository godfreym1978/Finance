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
<title>Chase Bank Check</title>
</head>
<body>
<%
Connection conn = null;
Statement statement = null;
float oldDep =0;
float oldWith =0;
float newDep =0;
float newWith =0;
boolean firstRec = true;
int oldMonth = 0;
int newMonth = 0;


try{
ConnectDB newConnectDB = new ConnectDB();

ResultSet rs = null;

conn = newConnectDB.getDBConnection();

statement = conn.createStatement();

rs = statement.executeQuery("SELECT * FROM CHASE_BANK_CHK ORDER BY CBC_DATE DESC ");
%>
<table border="1" class="gridtable">
<tr>
	<th>CBC_DATE</th>
	<th>CBC_DESC</th>
	<th>CBC_DEPOSIT</th>
	<th>CBC_WITH</th>
	<th>CBC_BAL</th>
</tr>
<%
while(rs.next()){
	
	if(firstRec){
		firstRec = false;
		oldDep = rs.getFloat("CBC_DEPOSIT");
		oldWith = rs.getFloat("CBC_WITH");
		oldMonth = rs.getDate("CBC_DATE").getMonth(); 
		%>
		<tr>
		<td><%=rs.getDate("CBC_DATE") %></td>
		<td><%=rs.getString("CBC_DESC") %></td>
		<td><%=rs.getFloat("CBC_DEPOSIT") %></td>
		<td><%=rs.getFloat("CBC_WITH") %></td>
		<td><%=rs.getFloat("CBC_BAL") %></td>
		</tr>
		<%
	}else{
		newMonth = rs.getDate("CBC_DATE").getMonth();
		if(oldMonth==newMonth){
			oldDep = oldDep+rs.getFloat("CBC_DEPOSIT");
			oldWith = oldWith+rs.getFloat("CBC_WITH");
			//oldMonth = rs.getDate("CBC_DATE").getMonth(); 
			%>
			<tr>
			<td><%=rs.getDate("CBC_DATE") %></td>
			<td><%=rs.getString("CBC_DESC") %></td>
			<td><%=rs.getFloat("CBC_DEPOSIT") %></td>
			<td><%=rs.getFloat("CBC_WITH") %></td>
			<td><%=rs.getFloat("CBC_BAL") %></td>
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
			oldDep = rs.getFloat("CBC_DEPOSIT");
			oldWith = rs.getFloat("CBC_WITH");
			oldMonth = rs.getDate("CBC_DATE").getMonth(); 
			%>
			<tr>
			<td><%=rs.getDate("CBC_DATE") %></td>
			<td><%=rs.getString("CBC_DESC") %></td>
			<td><%=rs.getFloat("CBC_DEPOSIT") %></td>
			<td><%=rs.getFloat("CBC_WITH") %></td>
			<td><%=rs.getFloat("CBC_BAL") %></td>
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