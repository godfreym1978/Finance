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
float buyMF =0;
float buyMFVal =0;
float sellMF =0;
float sellMFVal =0;
float divMF =0;
float divMFVal =0;
float reinvMF =0;
float reinvMFVal =0;
float cashMF =0;
float cashMFVal =0;

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
			buyMF = buyMF + rs.getFloat("FMT_QTY");
			buyMFVal = buyMFVal + rs.getFloat("FMT_VALUE");
		}else if(rs.getString("FMT_TRAN").equals("SELL")){
			sellMF = sellMF + rs.getFloat("FMT_QTY");
			sellMFVal = sellMFVal + rs.getFloat("FMT_VALUE");
		}else if(rs.getString("FMT_TRAN").indexOf("REINV")>0){
			reinvMF = reinvMF + rs.getFloat("FMT_QTY");
			reinvMFVal = reinvMFVal + rs.getFloat("FMT_VALUE");
		}else if(rs.getString("FMT_TRAN").indexOf("CASH")>0){
			cashMF = cashMF + rs.getFloat("FMT_QTY");
			cashMFVal = cashMFVal + rs.getFloat("FMT_VALUE");
		}	

		%>
		<tr>
		<td><%=rs.getString("FMT_MF") %></td>
		<td><%=rs.getDate("FMT_TRADE_DT") %></td>
		<td><%=rs.getString("FMT_TRAN") %></td>
		<td><%=rs.getFloat("FMT_VALUE") %></td>
		<td><%=rs.getFloat("FMT_PRICE") %></td>
		<td><%=rs.getFloat("FMT_QTY") %></td>
		<td><%=rs.getFloat("FMT_BAL") %></td>
		</tr>
		<%
	}else{
		newMF = rs.getString("FMT_MF");
		
		if(oldMF.equals(newMF)){
			oldMF = newMF;
			if(rs.getString("FMT_TRAN").equals("BUY")){
				buyMF = buyMF + rs.getFloat("FMT_QTY");
				buyMFVal = buyMFVal + rs.getFloat("FMT_VALUE");
			}else if(rs.getString("FMT_TRAN").equals("SELL")){
				sellMF = sellMF + rs.getFloat("FMT_QTY");
				sellMFVal = sellMFVal + rs.getFloat("FMT_VALUE");
			}else if(rs.getString("FMT_TRAN").indexOf("REINV")>0){
				reinvMF = reinvMF + rs.getFloat("FMT_QTY");
				reinvMFVal = reinvMFVal + rs.getFloat("FMT_VALUE");
			}else if(rs.getString("FMT_TRAN").indexOf("CASH")>0){
				cashMF = cashMF + rs.getFloat("FMT_QTY");
				cashMFVal = cashMFVal + rs.getFloat("FMT_VALUE");
			}	

			%>
			<tr>
			<td><%=rs.getString("FMT_MF") %></td>
			<td><%=rs.getDate("FMT_TRADE_DT") %></td>
			<td><%=rs.getString("FMT_TRAN") %></td>
			<td><%=rs.getFloat("FMT_VALUE") %></td>
			<td><%=rs.getFloat("FMT_PRICE") %></td>
			<td><%=rs.getFloat("FMT_QTY") %></td>
			<td><%=rs.getFloat("FMT_BAL") %></td>
			</tr>
			<%
		}else{
			%>
			<tr>
			<th colspan="7">
			<b>
			Buy Qty - <%=buyMF%> / Buy Cost Value - $<%=buyMFVal%> |
			Sell Qty - <%=sellMF%> / Sell Cost Value - $<%=sellMFVal%> |
			ReInv Qty - <%=reinvMF%> / ReInv Value - $<%=reinvMFVal%> |
			Div Cash - $<%=cashMFVal%>
			</b>
			</th>
			</tr>
			<%
			oldMF = newMF;
			
			buyMF =0;
			buyMFVal =0;
			sellMF =0;
			sellMFVal =0;
			reinvMF =0;
			reinvMFVal =0;
			cashMF =0;
			cashMFVal =0;

			if(rs.getString("FMT_TRAN").equals("BUY")){
				buyMF = buyMF + rs.getFloat("FMT_QTY");
				buyMFVal = buyMFVal + rs.getFloat("FMT_VALUE");
			}else if(rs.getString("FMT_TRAN").equals("SELL")){
				sellMF = sellMF + rs.getFloat("FMT_QTY");
				sellMFVal = sellMFVal + rs.getFloat("FMT_VALUE");
			}else if(rs.getString("FMT_TRAN").indexOf("REINV")>0){
				reinvMF = reinvMF + rs.getFloat("FMT_QTY");
				reinvMFVal = reinvMFVal + rs.getFloat("FMT_VALUE");
			}else if(rs.getString("FMT_TRAN").indexOf("CASH")>0){
				cashMF = cashMF + rs.getFloat("FMT_QTY");
				cashMFVal = cashMFVal + rs.getFloat("FMT_VALUE");
			}	

			%>
			<tr>
			<td><%=rs.getString("FMT_MF") %></td>
			<td><%=rs.getDate("FMT_TRADE_DT") %></td>
			<td><%=rs.getString("FMT_TRAN") %></td>
			<td><%=rs.getFloat("FMT_VALUE") %></td>
			<td><%=rs.getFloat("FMT_PRICE") %></td>
			<td><%=rs.getFloat("FMT_QTY") %></td>
			<td><%=rs.getFloat("FMT_BAL") %></td>
			</tr>
			<%

		}
		
	}

}
			%>
			<tr>
			<th colspan="7">
			<b>
			Buy Qty - <%=buyMF%> / Buy Cost Value - $<%=buyMFVal%> |
			Sell Qty - <%=sellMF%> / Sell Cost Value - $<%=sellMFVal%> |
			ReInv Qty - <%=reinvMF%> / ReInv Value - $<%=reinvMFVal%> |
			Div Cash - $<%=cashMFVal%>
			</b>
			</th>
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