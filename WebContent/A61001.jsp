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
<title>A61001</title>
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

rs = statement.executeQuery("SELECT * FROM AMEX_61001_DTL ORDER BY A61001_DATE DESC ");
%>
<table border="1" class="gridtable">
<tr>
	<th>A61001_DATE</th>
	<th>A61001_DESC</th>
	<th>A61001_DEPOSIT</th>
	<th>A61001_WITH</th>
</tr>
<%
while(rs.next()){
	
	if(firstRec){
		firstRec = false;
		oldDep = rs.getDouble("A61001_DEPOSIT");
		oldWith = rs.getDouble("A61001_WITH");
		oldMonth = rs.getDate("A61001_DATE").getMonth(); 
		%>
		<tr>
		<td><%=rs.getDate("A61001_DATE") %></td>
		<td><%=rs.getString("A61001_DESC") %></td>
		<td><%=rs.getDouble("A61001_DEPOSIT") %></td>
		<td><%=rs.getDouble("A61001_WITH") %></td>
		</tr>
		<%
	}else{
		newMonth = rs.getDate("A61001_DATE").getMonth();
		if(oldMonth==newMonth){
			oldDep = oldDep+rs.getDouble("A61001_DEPOSIT");
			oldWith = oldWith+rs.getDouble("A61001_WITH");
			//oldMonth = rs.getDate("A61001_DATE").getMonth(); 
			%>
			<tr>
			<td><%=rs.getDate("A61001_DATE") %></td>
			<td><%=rs.getString("A61001_DESC") %></td>
			<td><%=rs.getDouble("A61001_DEPOSIT") %></td>
			<td><%=rs.getDouble("A61001_WITH") %></td>
			</tr>
			<%
		}else{
			%>
			<tr>
			<th></th>
			<th>Summary</th>
			<th><%=oldDep %></th>
			<th><%=oldWith%></th>
			</tr>
			<%
			oldDep = rs.getDouble("A61001_DEPOSIT");
			oldWith = rs.getDouble("A61001_WITH");
			oldMonth = rs.getDate("A61001_DATE").getMonth(); 
			%>
			<tr>
			<td><%=rs.getDate("A61001_DATE") %></td>
			<td><%=rs.getString("A61001_DESC") %></td>
			<td><%=rs.getDouble("A61001_DEPOSIT") %></td>
			<td><%=rs.getDouble("A61001_WITH") %></td>
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