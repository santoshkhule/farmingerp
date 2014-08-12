<%@page import="farm.connection.DBfactory"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<!-- <script  src="js/script.js"></script> -->
<!-- <link rel="stylesheet" href="css/style.css"> -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>View Assign Product </title>
<script type="text/javascript">
	function showIframeContent() {
		var vendor_id=document.getElementById("selVendor").value;
	//	var cat_id=document.getElementById("selCat").value;
		window.open("assignVendorToProductViewIframe.jsp?vendor_id="+vendor_id, "ifrmShowAssignProduct");
	//window.open("assignVendorToProductViewIframe.jsp?vendor_id="+vendor_id+"&cat_id="+cat_id, "ifrmShowProdBrand");
	}
</script>
</head>
<body>
<div class="headerbox">
	<%@ include file="home.jsp" %>	
</div>
<%@ include file="menu.jsp" %>
<div class="box">
			<%
				Connection con = null;
				DBfactory dBfactory = new DBfactory();
				con = dBfactory.DBconnection();
			%>
			<div  style="width: 100%">
			<h2>View Assign Vendor To Product</h2>
			<!-- <form action="" name="frmShowCategory" method="post"> -->
				<hr>			
				<table>
					<tr>
						<td>Vendor Name:</td>
						<td>
						<%try{
							String selectQry = "select * from Vendor";
							Statement st1 = con.createStatement();
							ResultSet rs1 = st1.executeQuery(selectQry);
							
							
						%>
							<select name="selVendor" id="selVendor" onchange="showIframeContent()">
							<option value="">---Select---</option>
							<%
								while (rs1.next()) {
									%>
									<option value="<%=rs1.getInt(1)%>"><%=rs1.getString(2)%></option>
									<%
								}
							rs1.close();
							st1.close();
						}catch(Exception ex){
							ex.printStackTrace();
						}
							%>
							</select>
						</td>
						<%-- <td>Category:</td>
						<td>
						<%try{
							String selectQry = "select * from category";
							Statement st1 = con.createStatement();
							ResultSet rs1 = st1.executeQuery(selectQry);							
						%>
							<select name="selCat" id="selCat" onchange="showIframeContent()">
							<option value="">---Select---</option>
							<%
								while (rs1.next()) {
									%>
									<option value="<%=rs1.getInt(1)%>"><%=rs1.getString(2)%></option>
									<%
								}
							rs1.close();
							st1.close();
						}catch(Exception ex){
							ex.printStackTrace();
						}
							%>
							</select>
						</td>	 --%>				
					</tr>					
				</table>
			<iframe name="ifrmShowAssignProduct" width="100%" height="400" src="assignVendorToProductViewIframe.jsp"></iframe>
			
			</div>
		</div>
	
</body>
</html>
