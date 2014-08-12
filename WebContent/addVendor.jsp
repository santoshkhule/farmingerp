<%@page import="farm.connection.DBfactory"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<!-- <script  src="js/script.js"></script> -->
<link rel="stylesheet" href="css/style.css">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add New Vendor</title>
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
				boolean edit=false;
				String Vendor_Name=null,shop_Name=null,per_Contact_No=null,ofc_Contact_No=null,address=null,email_id=null;
				
				int Vendor_id=0;
				if (null != request.getParameter("sbtEdit") && null != request.getParameter("radVendorId")) {
					edit=true;
					Vendor_id =Integer.parseInt(request.getParameter("radVendorId"));
					/* System.out.print("ok"+edit); */
					//Select current max id
					String qry = "select * from vendor where vendor_id='"+Vendor_id+"'";
					Statement st = con.createStatement();
					ResultSet rs = st.executeQuery(qry);
					while (rs.next()) {
						Vendor_Name = rs.getString(2);
						shop_Name=rs.getString(3);
						per_Contact_No=rs.getString(5);
						ofc_Contact_No=rs.getString(6);
						address=rs.getString(4);
						email_id=rs.getString(7);
					}
					st.close();
					rs.close();
				}
			%>
			<div  style="width: 100%">
			<h2><%if(edit){%>Edit<%} %> Vendor Information</h2>
			<hr>
			<form action="action/addVendorAction.jsp" name="frmNewVendor" method="post">
				<table>
					<tr>
						<td style="text-align: right;">Vendor Name:</td>
						<td>
							<%if(edit){ %>
							<input type="hidden" name="radVendorId" id="radVendorId" value="<%=Vendor_id%>">
							<%} %>
							<input type="text" required="required" name="txtVendorName" id="txtVendorName" <%if(edit){ %>value="<%=Vendor_Name%>"<%} %>>
						</td>
					</tr>
					<tr>
						<td style="text-align: right;">Shop Name:</td>
						<td>
							
							<input type="text" required="required" name="txtShopName" id="txtShopName" <%if(edit){ %>value="<%=shop_Name%>"<%} %>>
						</td>
					</tr>
					<tr>
						<td style="text-align: right;">Personal Number:</td>
						<td>							
							<input type="text" required="required" name="txtPerContactNo" id="txtPerContactNo" <%if(edit){ %>value="<%=per_Contact_No%>"<%} %>>
						</td>
					</tr>
					<tr>
						<td style="text-align: right;">Shop Contact Number:</td>
						<td>							
							<input type="text" required="required" name="txtOfficeContactNo" id="txtOfficeContactNo" <%if(edit){ %>value="<%=ofc_Contact_No%>"<%} %>>
						</td>
					</tr>
					<tr>
						<td style="text-align: right;">Address:</td>
						<td>
							
							<textarea rows="" cols="25" required="required" name="txtVendorAddress" id="txtVendorAddress"><%if(edit){ %><%=address%><%}%></textarea>
						</td>
					</tr>
					<tr>
						<td style="text-align: right;">Email id:</td>
						<td><input type="text" required="required" name="txtEmailId" id="txtEmailId" <%if(edit){ %>value="<%=email_id%>"<%} %>></td>
					</tr>					
					<tr>
						<td colspan="2" style="text-align: center;"><input type="submit" name="sbtAdd" value="Add" onclick="frmNewVendor.action='action/addVendorAction.jsp'"  <%if(edit){ %>hidden="true"<% }%>>
							<input type="submit" id="sbtSave" name="sbtSave" value="Save" onclick="frmNewVendor.action='action/addVendorAction.jsp'" <%if(!edit){ %>hidden="false"<% }%>>
						</td>			
					</tr>
				</table>
			</form>
			<hr>
			<%if(!edit){ %>
			
			<form action="" name="frmShowVendor" method="post">
				<table>
					<tr>
						<td style="text-align: left;">
							<input type="submit" id="sbtEdit" name="sbtEdit" value="Edit" onclick="frmShowVendor.action='addVendor.jsp'">
						</td>
						<td>				
							<input type="submit" name="sbtDelete" value="Delete" onclick="frmShowVendor.action='action/addVendorAction.jsp'">
						</td>
					</tr>
				</table>				
				<table border=1 cellspacing=0 class="viewTable" style="width: 100%">
					<tr>
						<th>Select</th>
						<th>Sr no.</th>
						<th>Vendor name</th>
						<th>Shop Name</th>
						<th>Personal Contact No.</th>
						<th>Shop Contact No.</th>
						<th>Address</th>
						<th>Email Id</th>
					</tr>
					<%try{
						String selectQry = "select * from Vendor";
						Statement st1 = con.createStatement();
						ResultSet rs1 = st1.executeQuery(selectQry);
						int cnt=0;
						while (rs1.next()) {
							cnt++;
							%>
							<tr>
								<td>
									<%
										boolean checked=false;
										if(edit){
											if(rs1.getInt(1)==Vendor_id){
												checked=true;
											}
										}
									%>
									<input type="radio" name="radVendorId" value="<%=rs1.getInt(1)%>">
								</td>
								<td><%=cnt %></td>
								<td><%=rs1.getString(2) %></td>
								<td><%=rs1.getString(3) %></td>								
								<td><%=rs1.getString(5) %></td>
								<td><%=rs1.getString(6) %></td>
								<td><%=rs1.getString(4) %></td>
								<td><%=rs1.getString(7) %></td>
								
							</tr>
							<%
						}
						st1.close();
						rs1.close();
						con.close();
					}catch(Exception ex){
						ex.printStackTrace();
					}
					%>
					
				</table>
			</form>
			<%} %>
			</div>
		</div>
	
</body>
</html>
