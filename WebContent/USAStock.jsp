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
<title>Fidelity Bank</title>
</head>
<body>
<%
Connection conn = null;
Statement statement = null;
String oldMF = new String();
String newMF = new String();
float buyMF =0;
float buyMFVal =0;
float sellMF =0;
float sellMFVal =0;
float divMF =0;
float divMFVal =0;
float commission = 0;
boolean firstRec = true;


try{
ConnectDB newConnectDB = new ConnectDB();

ResultSet rs = null;

conn = newConnectDB.getDBConnection();

statement = conn.createStatement();

rs = statement.executeQuery("SELECT * FROM USA_STOCK_TBL ORDER BY UST_TICK, UST_DATE ASC ");
%>
<table border="1" class="gridtable">
<tr>
	<th>UST_TICK</th>
	<th>UST_NAME</th>
	<th>UST_TRAN</th>
	<th>UST_DATE</th>
	<th>UST_QTY</th>
	<th>UST_PRICE</th>
	<th>UST_COMMISION</th>
</tr>
<%
while(rs.next()){
	
	if(firstRec){
		firstRec = false;
		oldMF = rs.getString("UST_TICK");
		if(rs.getString("UST_TRAN").equals("BUY")){
			buyMF = buyMF + rs.getFloat("UST_QTY");
			buyMFVal = buyMFVal + rs.getFloat("UST_PRICE")*rs.getFloat("UST_QTY");
			commission = commission + rs.getFloat("UST_COMMISION"); 
		}else if(rs.getString("UST_TRAN").equals("SELL")){
			sellMF = sellMF + rs.getFloat("UST_QTY");
			sellMFVal = sellMFVal + rs.getFloat("UST_PRICE")*rs.getFloat("UST_QTY");
			commission = commission + rs.getFloat("UST_COMMISION");
		}else{
			divMF = divMF + rs.getFloat("UST_QTY");
			divMFVal = divMFVal + rs.getFloat("UST_PRICE")*rs.getFloat("UST_QTY");
		}
		%>
		<tr>
		<td><%=rs.getString("UST_TICK") %></td>
		<td><%=rs.getString("UST_NAME") %></td>
		<td><%=rs.getString("UST_TRAN") %></td>
		<td><%=rs.getDate("UST_DATE") %></td>
		<td><%=rs.getFloat("UST_QTY") %></td>
		<td><%=rs.getFloat("UST_PRICE") %></td>
		<td><%=rs.getFloat("UST_COMMISION") %></td>
		</tr>
		<%
	}else{
		newMF = rs.getString("UST_TICK");
		
		if(oldMF.equals(newMF)){
			oldMF = newMF;
			if(rs.getString("UST_TRAN").equals("BUY")){
				buyMF = buyMF + rs.getFloat("UST_QTY");
				buyMFVal = buyMFVal + rs.getFloat("UST_PRICE")*rs.getFloat("UST_QTY");
				commission = commission + rs.getFloat("UST_COMMISION");
			}else if(rs.getString("UST_TRAN").equals("SELL")){
				sellMF = sellMF + rs.getFloat("UST_QTY");
				sellMFVal = sellMFVal + rs.getFloat("UST_PRICE")*rs.getFloat("UST_QTY");
				commission = commission + rs.getFloat("UST_COMMISION");
			}else{
				divMF = divMF + rs.getFloat("UST_QTY");
				divMFVal = divMFVal + rs.getFloat("UST_PRICE")*rs.getFloat("UST_QTY");
			}
			%>
		<tr>
		<td><%=rs.getString("UST_TICK") %></td>
		<td><%=rs.getString("UST_NAME") %></td>
		<td><%=rs.getString("UST_TRAN") %></td>
		<td><%=rs.getDate("UST_DATE") %></td>
		<td><%=rs.getFloat("UST_QTY") %></td>
		<td><%=rs.getFloat("UST_PRICE") %></td>
		<td><%=rs.getFloat("UST_COMMISION") %></td>
		</tr>

			<%
		}else{
			%>
			<tr>
				<th colspan="7"><%=oldMF%> / Total Buy Qty - <%=buyMF%> / Total Buy Value - <%=buyMFVal%> / Total Sell Qty - <%=sellMF%> / Total Sell Value - <%=sellMFVal%> / Total Div Value - <%=divMFVal%> / Commission - <%=commission %></th>			
			</tr>
			<%
			oldMF = newMF;
			
			buyMF =0;
			buyMFVal =0;
			sellMF =0;
			sellMFVal =0;
			divMF =0;
			divMFVal =0;
			commission = 0;

			
			if(rs.getString("UST_TRAN").equals("BUY")){
				buyMF = buyMF + rs.getFloat("UST_QTY");
				buyMFVal = buyMFVal + rs.getFloat("UST_PRICE")*rs.getFloat("UST_QTY");
				commission = commission + rs.getFloat("UST_COMMISION"); 
			}else if(rs.getString("UST_TRAN").equals("SELL")){
				sellMF = sellMF + rs.getFloat("UST_QTY");
				sellMFVal = sellMFVal + rs.getFloat("UST_PRICE")*rs.getFloat("UST_QTY");
				commission = commission + rs.getFloat("UST_COMMISION"); 
			}else{
				divMF = divMF + rs.getFloat("UST_QTY");
				divMFVal = divMFVal + rs.getFloat("UST_PRICE")*rs.getFloat("UST_QTY");
			}
			%>
		<tr>
		<td><%=rs.getString("UST_TICK") %></td>
		<td><%=rs.getString("UST_NAME") %></td>
		<td><%=rs.getString("UST_TRAN") %></td>
		<td><%=rs.getDate("UST_DATE") %></td>
		<td><%=rs.getFloat("UST_QTY") %></td>
		<td><%=rs.getFloat("UST_PRICE") %></td>
		<td><%=rs.getFloat("UST_COMMISION") %></td>
		</tr>

			<%

		}
		
	}

}
			%>
			<tr>
			<th colspan="7"><%=oldMF%> / Total Buy Qty - <%=buyMF%> / Total Buy Value - <%=buyMFVal%> / Total Sell Qty - <%=sellMF%> / Total Sell Value - <%=sellMFVal%> / Total Div Value - <%=divMFVal%></th>
			
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