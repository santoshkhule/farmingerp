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
<title>Add New Brand</title>
</head>
<body>
<%@include file="checkSession.jsp" %>
<%-- <div class="headerbox">
	<%@ include file="home.jsp" %>	
</div>
<%@ include file="menu.jsp" %>
<div class="box"> --%>
			<%
				Connection con = null;
				DBfactory dBfactory = new DBfactory();
				con = dBfactory.DBconnection();
				boolean edit=false;
				String Brand_Name=null,vendor=null;
				double price=0;
				int brand_id=0;
				if (null != request.getParameter("sbtEdit") && null != request.getParameter("radBrandId")) {
					edit=true;
					brand_id =Integer.parseInt(request.getParameter("radBrandId"));
					/* System.out.print("ok"+edit); */
					//Select current max id
					String qry = "select * from Brand where brand_id='"+brand_id+"'";
					Statement st = con.createStatement();
					ResultSet rs = st.executeQuery(qry);
					while (rs.next()) {
						Brand_Name = rs.getString(2);						
					}
					st.close();
					rs.close();
				}
			%>
			<!-- <div  style="width: 100%"> -->
			<%-- <h2><%if(!edit){ %>Add New<%}else{%>Edit<%} %> Brand</h2>
			<hr> --%>
			<form name="frmNewBrand" method="post">
				<table>
					<tr>
						<td style="text-align: right;">Brand Name:</td>
						<td>
							<%if(edit){ %>
							<input type="hidden" name="radBrandId" id="radBrandId" value="<%=brand_id%>">
							<%} %>
							<input type="text" required="required" name="txtBrandName" id="txtBrandName" <%if(edit){ %>value="<%=Brand_Name%>"<%} %>>
						</td>
					</tr>
					
					<tr>
						<td colspan="2" style="text-align: center;">
						     <input type="submit" name="sbtAdd" value="Add" onclick="frmNewBrand.action='action/addBrandAction.jsp'"  <%if(edit){ %>hidden="true"<% }%>>
							<input type="submit" id="sbtSave" name="sbtSave" value="Save" onclick="frmNewBrand.action='action/addBrandAction.jsp'" <%if(!edit){ %>hidden="false"<% }%>>
						</td>			
					</tr>
				</table>
			</form>
			<hr>
			<%if(!edit){ %>
			
			<form action="" name="frmShowBrand" method="post">
				<table>
					<tr>
						<td style="text-align: left;">
							<input type="submit" id="sbtEdit" name="sbtEdit" value="Edit" onclick="frmShowBrand.action='addBrand.jsp'">
						</td>
						<td>				
							<input type="submit" name="sbtDelete" value="Delete" onclick="frmShowBrand.action='action/addBrandAction.jsp'">
						</td>
					</tr>
				</table>				
				<table border=1 cellspacing=0 class="viewTable" style="width: 100%">
					<tr>
						<th>Select</th>
						<th>Sr no.</th>
						<th>Brand</th>
						<!-- <th>Price</th>
						<th>Vendor</th> -->
						
					</tr>
					<%try{
						String selectQry = "select * from Brand";
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
											if(rs1.getInt(1)==brand_id){
												checked=true;
											}
										}
									%>
									<input type="radio" name="radBrandId" value="<%=rs1.getInt(1)%>" required="required">
								</td>
								<td><%=cnt %></td>
								<td><%=rs1.getString(2) %></td>
								<%-- <td><%=rs1.getString(3) %></td>
								<td><%=rs1.getString(4) %></td> --%>
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
		<!-- 	</div>
		</div> -->
	
</body>
</html>
