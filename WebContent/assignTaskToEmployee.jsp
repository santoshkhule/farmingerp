<%@page import="java.util.Date"%>
<%@page import="farm.util.FarmUtility"%>
<%@page import="farm.connection.DBfactory"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="css/jquery-ui.css" />
<script src="js/jquery-1.9.1.js"></script>
<script src="js/jquery-ui.js"></script> 
<title>Assign Site And Work</title>
</head>
<script>
	$(function() {		
		$("#txtDate").datepicker({

			changeMonth : true,
			changeYear : true,
			dateFormat : "dd/mm/yy"
		}).val();

	});
</script>

<script type="text/javascript">
	function validation(){		
		var empName=document.getElementById("selEmpName").value;
		var workType=document.getElementById("selWorkType").value;
		var assignWork=document.getElementById("assignWork").value;		
		var workStatus=document.getElementById("work_status").value;
		alert(workType);
		var flag=0;
		if(empName=="-1"){
			alert("Select Employee Name");			
		}else if(workType=="-1"){
			alert("Select Work Type");			
		}else if(assignWork=="-1"){
			alert("Select Work");			
		}else if(workStatus=="-1"){
			alert("Select Work Status");			
		}else{
			flag=1;
		}
		if(flag==0){
			return false;
		}else{
			return true;
		}
		
	}
</script>
<body>
<div class="headerbox">
	<%@ include file="home.jsp" %>	
</div>
<%@ include file="menu.jsp" %>
<div class="box">
			<form action="action/assignTaskToEmployeeAction.jsp" onsubmit="return validation();" method="post">
			<h2>Assign Site And Work</h2>
			<hr>
			<%
			try{
			Connection con=null;
			Statement st=null;
			try{
				DBfactory dbcon=new DBfactory();
				con=dbcon.DBconnection();
				st=con.createStatement();
			}catch(Exception ex){
				ex.printStackTrace();
			}
			boolean edit=false;
			int edit_Assign_Work_id=0;
			ResultSet edit_rs=null;
			if(request.getParameter("sbtEdit")!=null && request.getParameter("radAssignWorkId")!=null){
				edit=true;
				edit_Assign_Work_id=Integer.parseInt(request.getParameter("radAssignWorkId"));
				String edit_qry="Select * from ASSIGNWORK where ASSIGNWORK_ID="+edit_Assign_Work_id;
				//out.print(edit_qry);
				Statement edit_st=con.createStatement();
				edit_rs=edit_st.executeQuery(edit_qry);
				edit_rs.next();
			}
			%>
			
				<table border=0>
					<tr>
						<td>Employee Name:</td>
						<td>
							<select name="selEmpName" id="selEmpName" required=required>
							<option value="-1">Select</option>
							<%
							try{
								String query="select * from EMPLOYEEINFORMATION";	
								Statement emp_St=con.createStatement();
								ResultSet emp_rs=emp_St.executeQuery(query);
								while(emp_rs.next()){
									if(edit && edit_rs!=null){
										if(edit_rs.getInt(2)==emp_rs.getInt(1)){
										%>					
											<option value="<%=emp_rs.getInt(1)%>" selected="selected"><%out.println(emp_rs.getString(2)+" "+emp_rs.getString(3)+" "+emp_rs.getString(4) ); %></option>
										<%
										}else{
									%>					
										<option value="<%=emp_rs.getInt(1)%>"><%out.println(emp_rs.getString(2)+" "+emp_rs.getString(3)+" "+emp_rs.getString(4) ); %> </option>
									<%	
										}
									}else{
								%>					
									<option value="<%=emp_rs.getInt(1)%>"><%out.println(emp_rs.getString(2)+" "+emp_rs.getString(3)+" "+emp_rs.getString(4) ); %></option>
								<%
									}
								}
								emp_rs.close();
								emp_St.close();
							}catch(Exception ex){
								ex.printStackTrace();
							}
							
							%>
							</select>
						</td>
						<td style="text-align: right;">Date:</td>			
						<td>
						<%
							Date date=new Date(System.currentTimeMillis());
						date.getDate();
						%>
							<input type="text" name="txtDate" id="txtDate"
								pattern="(0[1-9]|[12][0-9]|3[01])\/(0[1-9]|1[0-2])\/\d{4}"
								oninvalid="setCustomValidity('Enter Date: Select From Calender')"
								onchange="setCustomValidity('')" title="Enter Date"
								 value="<%if(edit && edit_rs!=null){out.print(FarmUtility.convertfrom_yymmddToddmmyy(edit_rs.getString(3)));} %>" placeholder="dd/mm/yyyy" required="required"></td>
						<td style="text-align: right;">Time:</td>
						<td><input type="text" name="txtTime" id="txtTime" placeholder="hh:mm" pattern="([0-1][0-9]|2[0-3]):[0-5]{1}[0-9]{1}" value="<%if(edit && edit_rs!=null && edit_rs.getString(4)!=null && !edit_rs.getString(4).equalsIgnoreCase("null")){out.print(edit_rs.getString(4));} %>"></td>	
					</tr>
					<%-- <tr>
					<td style="text-align: right;">Time:</td>
						<td><input type="text" name="txtTime" id="txtTime" placeholder="hh:mm" value="<%if(edit && edit_rs!=null && edit_rs.getString(4)!=null && !edit_rs.getString(4).equalsIgnoreCase("null")){out.print(edit_rs.getString(4));} %>"></td>
					</tr> --%>
					<tr>
								<td rowspan="2">For Which Site:</td>
								<td rowspan="2">
									<select name="selField" id="selField" required multiple="multiple">							
										<%
											try{
											String query="select * from FIELDINFO";	
											Statement field_St=con.createStatement();
											ResultSet rs=field_St.executeQuery(query);
											
											//Edit operation						
											String edit_field_result=null;
											String arr[]=null;
											if(edit && edit_rs!=null){
												String edit_crop_qry="select * from EMPASSIGNFIELD where ASSIGNWORK_ID_FK="+edit_Assign_Work_id;	
												Statement edit_field_St=con.createStatement();
												ResultSet edit_field_rs=edit_field_St.executeQuery(edit_crop_qry);
												 while(edit_field_rs.next()){
													 if(edit_field_result!=null){
														edit_field_result=edit_field_result+","+edit_field_rs.getInt(2);
													}else{
														edit_field_result=String.valueOf(edit_field_rs.getInt(2));
													}	
													
												} 
											}					
											while(rs.next()){
												boolean flag=false;
												 if(edit && edit_rs!=null){
													arr=edit_field_result.split(",");
													if(arr!=null){
														for(int i=0;i<arr.length;i++){
															if(rs.getInt(1)==Integer.parseInt(arr[i])){
																flag=true;
															}
														}
													}
												} 
												if(flag){
													%>
													<option value="<%=rs.getInt(1)%>" selected="selected"><%=rs.getString(2)%></option>
													<%
												}else{
													%>
													<option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
													<%
												}							
											}
											rs.close();
											field_St.close();
											}catch(Exception ex){
												ex.printStackTrace();
											}
										%>
									</select>
								</td>
								<td style="text-align: right;" rowspan="2">For Which Crop:</td>
								<td rowspan="2">
									<select name="selCrop" id="selCrop" multiple="multiple" required>							
										<%
											try{
											String query="select * from CROPSINFIELD";	
											Statement crop_st=con.createStatement();
											ResultSet rs=crop_st.executeQuery(query);
											
											//Edit operation						
											String edit_crop_result=null;
											String arr[]=null;
											if(edit && edit_rs!=null){
												String edit_crop_qry="select * from EMPASSIGNCROP where ASSIGNWORK_ID_FK="+edit_Assign_Work_id;	
												Statement edit_crop_St=con.createStatement();
												ResultSet edit_crop_rs=edit_crop_St.executeQuery(edit_crop_qry);
												 while(edit_crop_rs.next()){
													 if(edit_crop_result!=null){
														 edit_crop_result=edit_crop_result+","+edit_crop_rs.getInt(2);
													}else{
														edit_crop_result=String.valueOf(edit_crop_rs.getInt(2));
													}	
													
												} 
												 System.out.print("edit_crop_result:="+edit_crop_result);
											} 								
											while(rs.next()){
												boolean flag=false;
												 if(edit && edit_rs!=null){
													if(edit_crop_result!=null){
														arr=edit_crop_result.split(",");
														if(arr!=null){
															for(int i=0;i<arr.length;i++){
																if(rs.getInt(1)==Integer.parseInt(arr[i])){
																	flag=true;
																}
															}
														}
													}
												} 
												if(flag){
													%>
													<option value="<%=rs.getInt(1)%>" selected="selected"><%=rs.getString(2)%></option>
													<%
												}else{
													%>
													<option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
													<%
												}
											}
												rs.close();
												crop_st.close();						
											}catch(Exception ex){
												ex.printStackTrace();
											}
										%>
									</select>
								</td>
									<td>Type Of Work:</td>
								<td>				
									<select name="selWorkType" id="selWorkType" required>
									<option value="-1">Select</option>
									 <%if(edit && edit_rs!=null){
										if(edit_rs.getString(5).equalsIgnoreCase("Contract")){
											%>					
											<option value="Contract" selected="selected">Contract</option>	
											<option value="Per Day Payment">Per Day Payment</option>
											<%				
										}else if(edit_rs.getString(5).equalsIgnoreCase("Per Day Payment")){
											%>					
											<option value="Contract">Contract</option>	
											<option value="Per Day Payment" selected="selected">Per Day Payment</option>
											<%
										}else{%>					
										<option value="Contract">Contract</option>	
										<option value="Per Day Payment">Per Day Payment</option>
									<%} 
									}else{%>					
										<option value="Contract">Contract</option>	
										<option value="Per Day Payment">Per Day Payment</option>
									<%} %>			
									</select>
								</td>
								
							</tr>
							<tr>	
								<td style="text-align: right;">Work:</td>
								<td>
									<select name="AssignWork" id="AssignWork">
										<option>Select</option>
										<%
											try{
											String work_query="select * from WORKTYPE";	
											Statement work_st=con.createStatement();
											ResultSet work_rs=work_st.executeQuery(work_query);
											
											//Edit operation						
											String edit_work_result=null;
											String arr[]=null;
											if(edit && edit_rs!=null){
												String edit_work_qry="select * from EMPASSIGNWORK where ASSIGNWORK_ID_FK="+edit_Assign_Work_id;	
												Statement edit_work_St=con.createStatement();
												ResultSet edit_work_rs=edit_work_St.executeQuery(edit_work_qry);
												 while(edit_work_rs.next()){
													 if(edit_work_result!=null){
														 edit_work_result=edit_work_result+","+edit_work_rs.getInt(2);
													}else{
														edit_work_result=String.valueOf(edit_work_rs.getInt(2));
													}	
													
												} 
												 System.out.print("edit_work_result:="+edit_work_result);
											} 
											
											while(work_rs.next()){
												boolean flag=false;
												 if(edit && edit_rs!=null && edit_work_result!=null){
													arr=edit_work_result.split(",");
													if(arr!=null){
														for(int i=0;i<arr.length;i++){
															if(work_rs.getInt(1)==Integer.parseInt(arr[i])){
																flag=true;
															}
														}
													}
												} 
												if(flag){
													%>
													<option value="<%=work_rs.getInt(1)%>" selected="selected"><%=work_rs.getString(2)%></option>
													<%
												}else{
													%>
													<option value="<%=work_rs.getInt(1)%>"><%=work_rs.getString(2)%></option>
													<%
												}
											}
											work_rs.close();
											work_st.close();						
											}catch(Exception ex){
												ex.printStackTrace();
											}
										%>
									</select>
								</td>	
							</tr>				
							<tr>
								<td style="text-align: right;">Amount:</td>
								<td>
									<input type="text" name="txtAmount" id="txtAmount" value="<%if(edit && edit_rs!=null){out.print(edit_rs.getString(6)); }else{out.print(0);}%>">
								</td>
								<td>Advance Payment:</td>
								<td><input type="text" name="txtAdvPayment" id="txtAdvPayment" value="<%if(edit && edit_rs!=null){out.print(edit_rs.getString(7)); }else{out.print(0);}%>"></td>
								<td style="text-align: right;">Work Status:</td>
								<td>
									<select name="work_status" id="work_status">
										<option value="">select</option>
										<%if(edit && edit_rs!=null && edit_rs.getString(8)!=null){
											if(edit_rs.getString(8).equalsIgnoreCase("Completed")){
												%>
											<option value="Completed" selected="selected">Completed</option>
											<option value="Pending">Pending</option>
											<option value="Reject">Reject</option>
												<%
											}else if(edit_rs.getString(8).equalsIgnoreCase("Pending")){
												%>
												<option value="Completed">Completed</option>
												<option value="Pending" selected="selected">Pending</option>
												<option value="Reject">Reject</option>
													<%
											}else if(edit_rs.getString(8).equalsIgnoreCase("Reject")){
												%>
												<option value="Completed">Completed</option>
												<option value="Pending">Pending</option>
												<option value="Reject" selected="selected">Reject</option>
													<%
											}
										}else{	%>				
											<option value="Completed">Completed</option>
											<option value="Pending">Pending</option>
											<option value="Reject">Reject</option>
										<%} %>
									</select>
								</td>
					</tr>
					
					<tr>
						<td colspan="8" style="text-align: center;"><br>
							<%if(edit && edit_rs!=null){ %>
								<input type="hidden" name="hdnAssignWorkId" id="hdnAssignWorkId" value="<%=edit_Assign_Work_id%>">
								<input type="submit" name="sbtSave" id="sbtSave" value="Save">
							<%}else{%>
								<input type="submit" name="sbtAdd" id="sbtAdd" value="Add">
							<%} %>
						</td>
					</tr>
				</table>
			</form>
			<hr>
			
			<%
			}catch(Exception ex){
					ex.printStackTrace();
			} %>
			</div>
	</div>
</body>
</html>