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
<link rel="stylesheet" href="Menu_files/style.css">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add New Fertilizer</title>
</head>
<body>
<%@include file="checkSession.jsp" %>
<%-- <div class="headerbox">
	<%@ include file="home.jsp" %>	
</div>
<%@ include file="menu.jsp" %>
<div class="box"> --%>
			<%
			if(null!=request.getParameter("cat_id") && !request.getParameter("cat_id").equalsIgnoreCase("null")){
				Connection con = null;
				DBfactory dBfactory = new DBfactory();
				con = dBfactory.DBconnection();
				boolean edit=false;
				String fertilizer_Name=null,vendor=null;
				double price=0;
				int fertilizer_id=0,cat_id=0;
				cat_id=Integer.parseInt(request.getParameter("cat_id"));
				if (null != request.getParameter("sbtEdit") && null != request.getParameter("radFertiId")) {
					edit=true;
					fertilizer_id =Integer.parseInt(request.getParameter("radFertiId"));
					/* System.out.print("ok"+edit); */
					//Select current max id
					String qry = "select * from fertilizer where fertilizer_id='"+fertilizer_id+"'";
					Statement st = con.createStatement();
					ResultSet rs = st.executeQuery(qry);
					while (rs.next()) {
						fertilizer_Name = rs.getString(2);
						price=rs.getDouble(3);
						vendor=rs.getString(4);
					}
					st.close();
					rs.close();
				}
			%>
			<!-- <div  style="width: 100%"> -->
			<%-- <h2><%if(!edit){ %>Add New<%}else{%>Edit<%} %> Fertilizer</h2>
			<hr> --%>
			<form action="action/addFertilizerAction.jsp" name="frmNewFertilizer" method="post">
			<input type="hidden" name="hdnCatId" id="hdnCatId" value="<%=cat_id%>">
				<table>
					<tr>
						<td style="text-align: right;">Product Name:</td>
						<td>
							<%if(edit){ %>
							<input type="hidden" name="radFertiId" id="radFertiId" value="<%=fertilizer_id%>">
							<%} %>
							<input type="text" required="required" name="txtFertilizerName" id="txtFertilizerName" <%if(edit){ %>value="<%=fertilizer_Name%>"<%} %>>
						</td>
					</tr>
					<%-- <tr>
						<td style="text-align: right;">Price:</td>
						<td><input type="text" required="required" name="txtPrice" id="txtPrice" <%if(edit){ %>value="<%=price%>"<%}else{out.println(0);} %>></td>
					</tr>
					<tr>
						<td style="text-align: right;">Vendor:</td>
						<td><input type="text" required="required" name="txtVendor" id="txtVendor" <%if(edit){ %>value="<%=vendor%>"<%}%>></td>
					</tr> --%>
					<tr>
						<td colspan="2" style="text-align: center;"><input type="submit" name="sbtAdd" value="Add" onclick="frmNewFertilizer.action='action/addFertilizerAction.jsp'"  <%if(edit){ %>hidden="true"<% }%>>
							<input type="submit" id="sbtSave" name="sbtSave" value="Save" onclick="frmNewFertilizer.action='action/addFertilizerAction.jsp'" <%if(!edit){ %>hidden="false"<% }%>>
						</td>			
					</tr>
				</table>
			</form>
			<hr>
			<%if(!edit){ %>
			
			<form action="" name="frmShowFertilizer" method="post">
			<input type="hidden" name="hdnCatId" id="hdnCatId" value="<%=cat_id%>">
				<table>
					<tr>
						<td style="text-align: left;">
							<input type="submit" id="sbtEdit" name="sbtEdit" value="Edit" onclick="frmShowFertilizer.action='addFertilizer.jsp'">
						</td>
						<td>				
							<input type="submit" name="sbtDelete" value="Delete" onclick="frmShowFertilizer.action='action/addFertilizerAction.jsp'">
						</td>
					</tr>
				</table>				
				<table border=1 cellspacing=0 class="viewTable" style="width: 100%">
					<tr>
						<th>Select</th>
						<th>Sr no.</th>
						<th>Product</th>
											
					</tr>
					<%try{
						String selectQry = "select * from fertilizer where cat_id="+cat_id;
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
											if(rs1.getInt(1)==fertilizer_id){
												checked=true;
											}
										}
									%>
									<input type="radio" name="radFertiId" value="<%=rs1.getInt(1)%>" required="required">
								</td>
								<td><%=cnt %></td>
								<td><%=rs1.getString(2) %></td>
								
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
			<!-- </div>
		</div> -->
<%}else{%>
<table>
	<tr>
		<td><font style="color: red;"><i> Note : Select Category to View Product</i> </font> <br> <br></td>
	</tr>
</table>
<%} %>	
</body>
</html>
