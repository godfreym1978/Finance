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

rs = statement.executeQuery("SELECT * FROM BOA_BANK_DTL ORDER BY BBD_DATE DESC ");
%>
<table border="1" class="gridtable">
<tr>
	<th>BBD_DATE</th>
	<th>BBD_DESC</th>
	<th>BBD_DEPOSIT</th>
	<th>BBD_WITH</th>
	<th>BBD_BAL</th>
</tr>
<%
while(rs.next()){
	
	if(firstRec){
		firstRec = false;
		oldDep = rs.getFloat("BBD_DEPOSIT");
		oldWith = rs.getFloat("BBD_WITH");
		oldMonth = rs.getDate("BBD_DATE").getMonth(); 
		%>
		<tr>
		<td><%=rs.getDate("BBD_DATE") %></td>
		<td><%=rs.getString("BBD_DESC") %></td>
		<td><%=rs.getFloat("BBD_DEPOSIT") %></td>
		<td><%=rs.getFloat("BBD_WITH") %></td>
		<td><%=rs.getFloat("BBD_BAL") %></td>
		</tr>
		<%
	}else{
		newMonth = rs.getDate("BBD_DATE").getMonth();
		if(oldMonth==newMonth){
			oldDep = oldDep+rs.getFloat("BBD_DEPOSIT");
			oldWith = oldWith+rs.getFloat("BBD_WITH");
			//oldMonth = rs.getDate("BBD_DATE").getMonth(); 
			%>
			<tr>
			<td><%=rs.getDate("BBD_DATE") %></td>
			<td><%=rs.getString("BBD_DESC") %></td>
			<td><%=rs.getFloat("BBD_DEPOSIT") %></td>
			<td><%=rs.getFloat("BBD_WITH") %></td>
			<td><%=rs.getFloat("BBD_BAL") %></td>
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
			oldDep = rs.getFloat("BBD_DEPOSIT");
			oldWith = rs.getFloat("BBD_WITH");
			oldMonth = rs.getDate("BBD_DATE").getMonth(); 
			%>
			<tr>
			<td><%=rs.getDate("BBD_DATE") %></td>
			<td><%=rs.getString("BBD_DESC") %></td>
			<td><%=rs.getFloat("BBD_DEPOSIT") %></td>
			<td><%=rs.getFloat("BBD_WITH") %></td>
			<td><%=rs.getFloat("BBD_BAL") %></td>
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