<%@page import="farm.connection.DBfactory"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<script  src="js/script.js"></script>
<link rel="stylesheet" href="css/style.css">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add new Crop</title>
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
				String crop_Name=null;
				int crop_id=0;
				if (null != request.getParameter("sbtEdit") && null != request.getParameter("radCropId")) {
					edit=true;
					crop_id =Integer.parseInt(request.getParameter("radCropId"));
					/* System.out.print("ok"+edit); */
					//Select current max id
					String qry = "select * from CROPSINFIELD where CROP_ID='"+crop_id+"'";
					Statement st = con.createStatement();
					ResultSet rs = st.executeQuery(qry);
					while (rs.next()) {
						crop_Name = rs.getString(2);
					}
					st.close();
					rs.close();
				}
			%>
			<div  style="width: 100%">
			<h2><%if(!edit){ %>Add New<%}else{%>Edit<%} %> Crop Name</h2>
			<hr>
			<form action="action/newCropAction.jsp" name="frmNewCrop" method="post">
				<table>
					<tr>
						<td>Crop Name:</td>
						<td>
							<%if(edit){ %>
							<input type="hidden" name="radCropId" id="radCropId" value="<%=crop_id%>">
							<%} %>
							<input type="text" required="required" name="txtCName" id="txtCName" <%if(edit){ %>value="<%=crop_Name%>"<%} %>>
						</td>
					</tr>
					<tr>
						<td colspan="2" style="text-align: center;"><input type="submit" name="sbtAdd" value="Add" onclick="frmNewCrop.action='action/newCropAction.jsp'"  <%if(edit){ %>hidden="true"<% }%>>
							<input type="submit" id="sbtSave" name="sbtSave" value="Save" onclick="frmNewCrop.action='action/newCropAction.jsp'" <%if(!edit){ %>hidden="false"<% }%>>
						</td>			
					</tr>
				</table>
			</form>
			<hr>
			<form action="" name="frmShowCrop" method="get">
				<table>
					<tr>
						<td style="text-align: left;">
							<input type="submit" id="sbtEdit" name="sbtEdit" value="Edit" onclick="frmShowCrop.action='addNewCrop.jsp'" <%if(edit){ %>hidden="true"<% }%>>
						</td>
						<td>				
							<input type="submit" name="sbtDelete" value="Delete" onclick="frmShowCrop.action='action/newCropAction.jsp'" <%if(edit){ %>hidden="true"<% }%>>
						</td>
					</tr>
				</table>	
				
				<table border=1 cellspacing=0 <%if(edit){ %>hidden="true"<% }%> class="viewTable" style="width: 80%">
					<tr>
						<th>Select</th>
						<th>Sr no.</th>
						<th>Crop Name</th>
					</tr>
					<%try{
						String selectQry = "select * from CROPSINFIELD";
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
											if(rs1.getInt(1)==crop_id){
												checked=true;
											}
										}
									%>
									<input type="radio" name="radCropId" value="<%=rs1.getInt(1)%>" <%if(checked){%>checked<%} %>>
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
			</div>
		</div>
	</div>
</body>
</html>
