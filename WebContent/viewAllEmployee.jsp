<%@page import="java.sql.ResultSet"%>
<%@page import="farm.connection.DBfactory"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="css/style.css">
<title>View All Employee</title>
</head>
<body>
<div class="headerbox">
	<%@ include file="home.jsp" %>	
</div>
<%@ include file="menu.jsp" %>
<div class="box">
		<%
			Connection con = null;
			Statement st = null;
			try {
				DBfactory dbcon = new DBfactory();
				con = dbcon.DBconnection();
				st = con.createStatement();
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		%>
		<form action="" method="post">
		<h2>View All Employee</h2>
		<hr>
		
		<table>
			<tr>
				
				<td><input type="submit" name="sbtView" value="View" onclick="this.form.action='viewSingleEmpInfo.jsp'"></td>
				<td><input type="submit" name="sbtEdit" value="Edit" onclick="this.form.action='addEmpInfo.jsp'"></td>
				<td><input type="submit" name="sbtDelete" value="Delete" onclick="this.form.action='action/NewEmpInfoAction.jsp'"></td>
				<td><input type="submit" name="sbtAssignTask" value="Assign Task" onclick="this.form.action='assignTaskToEmployee.jsp'" style="width: 150px"></td>
				<td><input type="submit" name="sbtViewAllTransac" value="View All Transaction" onclick="this.form.action='02viewAllTransaction.jsp'" style="width: 150px"></td>
			</tr>
		</table>
		<table border="1" cellspacing="0" class="tableWidth">
			<thead>
				<tr>
					<th>Select</th>
					<th>Sr. No.</th>
					<th>Name</th>
					<th>Contact No.</th>
					<th>Address</th>
					<th>Bank Name</th>
					<th>Acc No</th>
					<!-- <th>Crop</th> -->
					
				</tr>
			</thead>
			<tbody>
				<%
				try{
					String query = "Select * from EMPLOYEEINFORMATION  order by EMP_ID asc";
					ResultSet rs=st.executeQuery(query);
					int cnt=0;
					while(rs.next()){
						cnt++;
						int emp_id=rs.getInt(1);
				%>
				<tr>
					<td>
						<input type="radio" name="radEmpId" id="radEmpId" value="<%=emp_id%>" required="required">
					</td>
					<td><%=cnt %></td>
					<td>
						<% 
							if(rs.getString(2)!=null && rs.getString(3)!=null && rs.getString(4)!=null){
								out.print(rs.getString(2) +" "+rs.getString(3)+" "+rs.getString(4)); 
							}else{
								out.print("-");
							}
						%>
					</td>
					<td><%if(rs.getString(5)!=null){out.print(rs.getString(5));}else{out.print("-");} %></td>
					<td><%if(rs.getString(6)!=null){out.print(rs.getString(6));}else{out.print("-");} %></td>
					<td><%if(rs.getString(7)!=null){out.print(rs.getString(7));}else{out.print("-");} %></td>
					<td><%if(rs.getString(8)!=null){out.print(rs.getString(8));}else{out.print("-");} %></td>
					<%-- <td>
						<%
							try{
								String field_qry="Select FIELD_NAME from FIELDINFO where FIELD_ID in(Select FIELD_ID_FK from EMPASSIGNFIELD where EMP_ID_FK="+emp_id+")";
								//System.out.print(field_qry);
								Statement field_st=con.createStatement();
								ResultSet field_res=field_st.executeQuery(field_qry);
								String FIELD_NAME=null;
								while(field_res.next()){
									if(FIELD_NAME!=null){
										FIELD_NAME=FIELD_NAME+","+field_res.getString("FIELD_NAME");
									}else{
										FIELD_NAME=field_res.getString("FIELD_NAME");
									}								
								}
								out.print(FIELD_NAME);
								field_res.close();
								field_st.close();
							}catch(Exception ex){
								ex.printStackTrace();
							}
						
						 %>
					</td>
					<td>
						<%
							try{
								String crop_qry="Select CROP_NAME from CROPSINFIELD where CROP_ID in(Select CROP_ID_FK from EMPASSIGNCROPS where EMP_ID_FK="+emp_id+")";
								//System.out.print(crop_qry);
								Statement crop_st=con.createStatement();
								ResultSet crop_res=crop_st.executeQuery(crop_qry);
								String CROP_NAME=null;
								while(crop_res.next()){								
									if(CROP_NAME!=null){
										CROP_NAME=CROP_NAME+","+crop_res.getString("CROP_NAME");
									}else{
										CROP_NAME=crop_res.getString("CROP_NAME");
									}								
								}
								out.print(CROP_NAME);
								crop_res.close();
								crop_st.close();
							}catch(Exception ex){
								ex.printStackTrace();
							}
						
						 %>
					</td> --%>
					
				</tr>
				<%}
					rs.close();
					con.close();
			}catch(Exception ex){
				ex.printStackTrace();
			}%>
			</tbody>
		</table>
		</form>
	</div>
</div>
</body>
</html>