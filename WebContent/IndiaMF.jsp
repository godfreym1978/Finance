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
double buyMF =0.0;
double buyMFVal =0.0;
double sellMF =0.0;
double sellMFVal =0.0;

boolean firstRec = true;


try{
ConnectDB newConnectDB = new ConnectDB();

ResultSet rs = null;

conn = newConnectDB.getDBConnection();

statement = conn.createStatement();

rs = statement.executeQuery("SELECT * FROM MUTUAL_FUND_INV ORDER BY MFI_MF_NAME, MFI_TRAN_DATE ASC ");
%>
<table border="1" class="gridtable">
<tr>

	<th>MFI_MF_NAME</th>
	<th>MFI_TRAN_DATE</th>
	<th>MFI_TRAN</th>
	<th>MFI_AMT</th>
	<th>MFI_PUB_NAV</th>
	<th>MFI_TRAN_NAV</th>
	<th>MFI_TRAN_QTY</th>
	<th>MFI_BAL_QTY</th>

</tr>
<%
while(rs.next()){
	
	if(firstRec){
		firstRec = false;
		oldMF = rs.getString("MFI_MF_NAME");
		if(rs.getString("MFI_TRAN").equals("BUY")){
			buyMF = buyMF + rs.getDouble("MFI_TRAN_QTY");
			buyMFVal = buyMFVal + rs.getDouble("MFI_AMT");
		}else{
			sellMF = sellMF + rs.getDouble("MFI_TRAN_QTY");
			sellMFVal = sellMFVal + rs.getDouble("MFI_AMT");
		}
		%>
		<tr>
		<td><%=rs.getString("MFI_MF_NAME") %></td>
		<td><%=rs.getDate("MFI_TRAN_DATE") %></td>
		<td><%=rs.getString("MFI_TRAN") %></td>
		<td><%=rs.getDouble("MFI_AMT") %></td>
		<td><%=rs.getDouble("MFI_PUB_NAV") %></td>
		<td><%=rs.getDouble("MFI_TRAN_NAV") %></td>
		<td><%=rs.getDouble("MFI_TRAN_QTY") %></td>
		<td><%=rs.getDouble("MFI_BAL_QTY") %></td>
		</tr>
		<%
	}else{
		newMF = rs.getString("MFI_MF_NAME");
		
		if(oldMF.equals(newMF)){
			oldMF = newMF;
			if(rs.getString("MFI_TRAN").equals("BUY")){
				buyMF = buyMF + rs.getDouble("MFI_TRAN_QTY");
				buyMFVal = buyMFVal + rs.getDouble("MFI_AMT");
			}else{
				sellMF = sellMF + rs.getDouble("MFI_TRAN_QTY");
				sellMFVal = sellMFVal + rs.getDouble("MFI_AMT");
			}
			%>
			<tr>
			<td><%=rs.getString("MFI_MF_NAME") %></td>
			<td><%=rs.getDate("MFI_TRAN_DATE") %></td>
			<td><%=rs.getString("MFI_TRAN") %></td>
			<td><%=rs.getDouble("MFI_AMT") %></td>
			<td><%=rs.getDouble("MFI_PUB_NAV") %></td>
			<td><%=rs.getDouble("MFI_TRAN_NAV") %></td>
			<td><%=rs.getDouble("MFI_TRAN_QTY") %></td>
			<td><%=rs.getDouble("MFI_BAL_QTY") %></td>
			</tr>
			<%
		}else{
			%>
			<tr>
			<th><%=oldMF%></th>
			<th><%=buyMF%></th>
			<th><%=buyMFVal%></th>
			<th><%=sellMF%></th>
			<th><%=sellMFVal%></th>
			<th></th>
			<th></th>
			<th></th>
			</tr>
			<%
			oldMF = newMF;
			
			buyMF =0.0;
			buyMFVal =0.0;
			sellMF =0.0;
			sellMFVal =0.0;
			
			if(rs.getString("MFI_TRAN").equals("BUY")){
				buyMF = rs.getDouble("MFI_TRAN_QTY");
				buyMFVal = rs.getDouble("MFI_AMT");
			}else{
				sellMF = rs.getDouble("MFI_TRAN_QTY");
				sellMFVal = rs.getDouble("MFI_AMT");
			}
			%>
			<tr>
			<td><%=rs.getString("MFI_MF_NAME") %></td>
			<td><%=rs.getDate("MFI_TRAN_DATE") %></td>
			<td><%=rs.getString("MFI_TRAN") %></td>
			<td><%=rs.getDouble("MFI_AMT") %></td>
			<td><%=rs.getDouble("MFI_PUB_NAV") %></td>
			<td><%=rs.getDouble("MFI_TRAN_NAV") %></td>
			<td><%=rs.getDouble("MFI_TRAN_QTY") %></td>
			<td><%=rs.getDouble("MFI_BAL_QTY") %></td>
			</tr>
			<%

		}
		
	}

}
			%>
			<tr>
			<th><%=oldMF%></th>
			<th><%=buyMF%></th>
			<th><%=buyMFVal%></th>
			<th><%=sellMF%></th>
			<th><%=sellMFVal%></th>
			<th></th>
			<th></th>
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