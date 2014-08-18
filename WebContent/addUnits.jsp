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
<title>Add New Unit</title>
</head>
<body>
<%-- <%@include file="checkSession.jsp" %>
 <div class="headerbox">
	<%@ include file="home.jsp" %>	
</div>
<%@ include file="menu.jsp" %>
<div class="box">  --%>
			<%
				Connection con = null;
				DBfactory dBfactory = new DBfactory();
				con = dBfactory.DBconnection();
				boolean edit=false;
				String Unit_Name=null;
				double price=0;
				int unit_id=0;
				if (null != request.getParameter("sbtEdit") && null != request.getParameter("radUnitId")) {
					edit=true;
					unit_id =Integer.parseInt(request.getParameter("radUnitId"));
					/* System.out.print("ok"+edit); */
					//Select current max id
					String qry = "select * from units where unit_id='"+unit_id+"'";
					Statement st = con.createStatement();
					ResultSet rs = st.executeQuery(qry);
					while (rs.next()) {
						Unit_Name = rs.getString(2);						
					}
					st.close();
					rs.close();
				}
			%>
			
			<form name="frmNewUnit" method="post">
				<table>
					<tr>
						<td style="text-align: right;">Unit Name:</td>
						<td>
							<%if(edit){ %>
							<input type="hidden" name="radUnitId" id="radUnitId" value="<%=unit_id%>">
							<%} %>
							<input type="text" required="required" name="txtUnitName" id="txtUnitName" <%if(edit){ %>value="<%=Unit_Name%>"<%} %>>
						</td>
					</tr>
					
					<tr>
						<td colspan="2" style="text-align: center;">
						     <input type="submit" name="sbtAdd" value="Add" onclick="frmNewUnit.action='action/addUnitAction.jsp'"  <%if(edit){ %>hidden="true"<% }%>>
							<input type="submit" id="sbtSave" name="sbtSave" value="Save" onclick="frmNewUnit.action='action/addUnitAction.jsp'" <%if(!edit){ %>hidden="false"<% }%>>
						</td>			
					</tr>
				</table>
			</form>
			<hr>
			<%if(!edit){ %>
			
			<form action="" name="frmShowUnit" method="post">
				<table>
					<tr>
						<td style="text-align: left;">
							<input type="submit" id="sbtEdit" name="sbtEdit" value="Edit" onclick="frmShowUnit.action='addUnits.jsp'">
						</td>
						<td>				
							<input type="submit" name="sbtDelete" value="Delete" onclick="frmShowUnit.action='action/addUnitAction.jsp'">
						</td>
					</tr>
				</table>				
				<table border=1 cellspacing=0 class="viewTable" style="width: 100%">
					<tr>
						<th>Select</th>
						<th>Sr no.</th>
						<th>Units</th>
					</tr>
					<%try{
						String selectQry = "select * from units";
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
											if(rs1.getInt(1)==unit_id){
												checked=true;
											}
										}
									%>
									<input type="radio" name="radUnitId" value="<%=rs1.getInt(1)%>" required="required">
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
		</div>  -->
	
</body>
</html>
