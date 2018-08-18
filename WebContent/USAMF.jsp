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
<title>USA Mutual Fund Details</title>
</head>
<body>
<%
Connection conn = null;
Statement statement = null;
String oldMF = new String();
String newMF = new String();
double buyMF =0.0;
double buyMFVal =0.0;
double sellMF =0.0;
double sellMFVal =0.0;
double divMF =0.0;
double divMFVal =0.0;
double reinvMF =0.0;
double reinvMFVal =0.0;
double cashMF =0.0;
double cashMFVal =0.0;

boolean firstRec = true;

try{
ConnectDB newConnectDB = new ConnectDB();

ResultSet rs = null;

conn = newConnectDB.getDBConnection();

statement = conn.createStatement();

rs = statement.executeQuery("SELECT * FROM FIDELITY_MF_TBL ORDER BY FMT_MF, FMT_TRADE_DT ASC ");
%>
<table border="1" class="gridtable">
<tr>

	<th>FMT_MF</th>
	<th>FMT_TRADE_DT</th>
	<th>FMT_TRAN</th>
	<th>FMT_VALUE</th>
	<th>FMT_PRICE</th>
	<th>FMT_QTY</th>
	<th>FMT_BAL</th>

</tr>
<%
while(rs.next()){
	
	if(firstRec){
		firstRec = false;
		oldMF = rs.getString("FMT_MF");
		if(rs.getString("FMT_TRAN").equals("BUY")){
			buyMF = buyMF + rs.getDouble("FMT_QTY");
			buyMFVal = buyMFVal + rs.getDouble("FMT_VALUE");
		}else if(rs.getString("FMT_TRAN").equals("SELL")){
			sellMF = sellMF + rs.getDouble("FMT_QTY");
			sellMFVal = sellMFVal + rs.getDouble("FMT_VALUE");
		}else if(rs.getString("FMT_TRAN").indexOf("REINV")>0){
			reinvMF = reinvMF + rs.getDouble("FMT_QTY");
			reinvMFVal = reinvMFVal + rs.getDouble("FMT_VALUE");
		}else if(rs.getString("FMT_TRAN").indexOf("CASH")>0){
			cashMF = cashMF + rs.getDouble("FMT_QTY");
			cashMFVal = cashMFVal + rs.getDouble("FMT_VALUE");
		}	

		%>
		<tr>
		<td><%=rs.getString("FMT_MF") %></td>
		<td><%=rs.getDate("FMT_TRADE_DT") %></td>
		<td><%=rs.getString("FMT_TRAN") %></td>
		<td><%=rs.getDouble("FMT_VALUE") %></td>
		<td><%=rs.getDouble("FMT_PRICE") %></td>
		<td><%=rs.getDouble("FMT_QTY") %></td>
		<td><%=rs.getDouble("FMT_BAL") %></td>
		</tr>
		<%
	}else{
		newMF = rs.getString("FMT_MF");
		
		if(oldMF.equals(newMF)){
			oldMF = newMF;
			if(rs.getString("FMT_TRAN").equals("BUY")){
				buyMF = buyMF + rs.getDouble("FMT_QTY");
				buyMFVal = buyMFVal + rs.getDouble("FMT_VALUE");
			}else if(rs.getString("FMT_TRAN").equals("SELL")){
				sellMF = sellMF + rs.getDouble("FMT_QTY");
				sellMFVal = sellMFVal + rs.getDouble("FMT_VALUE");
			}else if(rs.getString("FMT_TRAN").indexOf("REINV")>0){
				reinvMF = reinvMF + rs.getDouble("FMT_QTY");
				reinvMFVal = reinvMFVal + rs.getDouble("FMT_VALUE");
			}else if(rs.getString("FMT_TRAN").indexOf("CASH")>0){
				cashMF = cashMF + rs.getDouble("FMT_QTY");
				cashMFVal = cashMFVal + rs.getDouble("FMT_VALUE");
			}	

			%>
			<tr>
			<td><%=rs.getString("FMT_MF") %></td>
			<td><%=rs.getDate("FMT_TRADE_DT") %></td>
			<td><%=rs.getString("FMT_TRAN") %></td>
			<td><%=rs.getDouble("FMT_VALUE") %></td>
			<td><%=rs.getDouble("FMT_PRICE") %></td>
			<td><%=rs.getDouble("FMT_QTY") %></td>
			<td><%=rs.getDouble("FMT_BAL") %></td>
			</tr>
			<%
		}else{
			%>
			<tr>
			<th colspan="7">Buy Qty - <%=buyMF%> / Buy Cost Value - $<%=buyMFVal%> |
			Sell Qty - <%=sellMF%> / Sell Cost Value - $<%=sellMFVal%> |
			ReInv Qty - <%=reinvMF%> / ReInv Value - $<%=reinvMFVal%> |
			Div Cash - $<%=cashMFVal%></th>
			</tr>
			<%
			oldMF = newMF;
			
			buyMF =0.0;
			buyMFVal =0.0;
			sellMF =0.0;
			sellMFVal =0.0;
			reinvMF =0.0;
			reinvMFVal =0.0;
			cashMF =0.0;
			cashMFVal =0.0;

			if(rs.getString("FMT_TRAN").equals("BUY")){
				buyMF = buyMF + rs.getDouble("FMT_QTY");
				buyMFVal = buyMFVal + rs.getDouble("FMT_VALUE");
			}else if(rs.getString("FMT_TRAN").equals("SELL")){
				sellMF = sellMF + rs.getDouble("FMT_QTY");
				sellMFVal = sellMFVal + rs.getDouble("FMT_VALUE");
			}else if(rs.getString("FMT_TRAN").indexOf("REINV")>0){
				reinvMF = reinvMF + rs.getDouble("FMT_QTY");
				reinvMFVal = reinvMFVal + rs.getDouble("FMT_VALUE");
			}else if(rs.getString("FMT_TRAN").indexOf("CASH")>0){
				cashMF = cashMF + rs.getDouble("FMT_QTY");
				cashMFVal = cashMFVal + rs.getDouble("FMT_VALUE");
			}	

			%>
			<tr>
			<td><%=rs.getString("FMT_MF") %></td>
			<td><%=rs.getDate("FMT_TRADE_DT") %></td>
			<td><%=rs.getString("FMT_TRAN") %></td>
			<td><%=rs.getDouble("FMT_VALUE") %></td>
			<td><%=rs.getDouble("FMT_PRICE") %></td>
			<td><%=rs.getDouble("FMT_QTY") %></td>
			<td><%=rs.getDouble("FMT_BAL") %></td>
			</tr>
			<%

		}
		
	}

}
			%>
			<tr>
			<th colspan="7">Buy Qty - <%=buyMF%> / Buy Cost Value - $<%=buyMFVal%> |
			Sell Qty - <%=sellMF%> / Sell Cost Value - $<%=sellMFVal%> |
			ReInv Qty - <%=reinvMF%> / ReInv Value - $<%=reinvMFVal%> |
			Div Cash - $<%=cashMFVal%></th>
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