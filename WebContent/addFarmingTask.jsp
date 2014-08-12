<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="farm.connection.DBfactory"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add and View Farming Task</title>
</head>
<body>
<div class="headerbox">
	<%@ include file="home.jsp" %>	
</div>
<%@ include file="menu.jsp" %>
<div class="box">
  		<%
		try{
			Connection con = null;
			DBfactory dBfactory = new DBfactory();
			con = dBfactory.DBconnection(); 
			boolean edit=false;
			int taskId=0;
			String task_name=null;
			if(request.getParameter("sbtEdit")!=null && request.getParameter("radTaskId")!=null){
				edit=true;
				taskId=Integer.parseInt(request.getParameter("radTaskId"));
				String qry = "select * from worktype where WORK_ID='"+taskId+"'";
				Statement st = con.createStatement();
				ResultSet rs = st.executeQuery(qry);
				while (rs.next()) {
					task_name = rs.getString(2);
				}
				st.close();
				rs.close();
			}
		%>
			<form action="action/farmingTaskAction.jsp" method="post">
				<h2>Add Farming Task</h2>
				<hr>
				<table>
					<tr>
						<td>Task Name:</td>
						<td>
							<input type="text" name="txtTaskName" id="txtTaskName" required="true" value="<%if(edit && task_name!=null){out.println(task_name);}%>"> 
						</td>
					</tr>
					<tr>
						<td colspan="2" style="text-align: center;">
						<%if(edit){
							%>
							<input type="hidden" name="hdnTaskId" id="hdnTaskId" value="<%=taskId%>">
							<input type="submit" name="sbtSave" id="sbtSave" value="Save">
							<%
						}else{ %>
							<input type="submit" name="sbtAdd" id="sbtAdd" value="Add">
							<%} %>
						</td>
					</tr>
				</table>
			</form>
			<hr>
			<form method="post">
				<table>
					<tr>
						<td style="text-align: left;">
							<input type="submit" id="sbtEdit" name="sbtEdit" value="Edit" onclick="this.form.action='addFarmingTask.jsp'">
						</td>
						<td>				
							<input type="submit" name="sbtDelete" id="sbtDelete" value="Delete" onclick="this.form.action='action/farmingTaskAction.jsp'">
						</td>
					</tr>
				</table>	
				<table border=1 cellspacing=0 style="width: 80%">
					<tr>
						<th>Select</th>
						<th>Sr no.</th>
						<th>Task Name</th>
					</tr>
					<%
					
						try{
							String selectQry = "select * from worktype order by WORK_ID asc";
							Statement st1 = con.createStatement();
							ResultSet rs1 = st1.executeQuery(selectQry);
							int cnt=0;
							while (rs1.next()) {
							cnt++;
					%>
					<tr>
						<td><input type="radio" name="radTaskId" id="radTaskId" value="<%=rs1.getInt(1)%>"></td>
						<td><%=cnt %></td>
						<td><%=rs1.getString(2)%></td>
					</tr>
					<%}
					}catch(Exception ex){
						ex.printStackTrace();
					}%>
				</table>
			</form>
		</div>
	</div>
	<%}catch(Exception ex){
		ex.printStackTrace();
	} %>
</body>
</html>