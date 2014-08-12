<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Vector"%>
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
<link rel="stylesheet" href="css/style.css">

<title>Employee Information</title>
</head>
<body>
<div class="headerbox">
	<%@ include file="home.jsp" %>	
</div>
<%@ include file="menu.jsp" %>
<div class="box">
		<%
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
			int emp_id=0;
			ResultSet edit_rs=null;
			if(request.getParameter("sbtEdit")!=null && request.getParameter("radEmpId")!=null){
				edit=true;
				emp_id=Integer.parseInt(request.getParameter("radEmpId"));
				String edit_qry="Select * from EMPLOYEEINFORMATION where EMP_ID="+emp_id;
				//out.print(edit_qry);
				Statement edit_st=con.createStatement();
				edit_rs=edit_st.executeQuery(edit_qry);
				edit_rs.next();
			}
		%>
			<h2>Employee Information</h2>
			<hr>
			<form  name="frmAddEmp" action="action/NewEmpInfoAction.jsp" enctype="multipart/form-data" method="post">
			<table border=0 style="width: 100%" cellSpacing=0>
				<tr>
					<td rowspan="4"<%if(!edit && edit_rs==null){ %> colspan="2"<%} %>>
					Upload Employee Photo:
					<input type="file" name="fileEmpPhoto" id="fileEmpPhoto"></td>
					<%if(edit && edit_rs!=null && edit_rs.getString(9)!=null && !edit_rs.getString(9).equalsIgnoreCase("")){ %>					
					<td style="text-align: center;" rowspan="4">
					<input type="hidden" name="hdnUploadedPhoto" value="<%=edit_rs.getString(9)%>">					
							<%
							String photo[]=null;
							String pic=null;
							if(edit_rs.getString(9)!=null && !edit_rs.getString(9).equalsIgnoreCase("") && !edit_rs.getString(9).equalsIgnoreCase("null")){
								photo=edit_rs.getString(9).split("/");															
								pic=photo[photo.length-2]+"/"+photo[photo.length-1];							
							//out.println(pic);
							%>
						<a href="DownloadFileServlet?fileName=<%=photo[photo.length-1] %>">
							<img src="<%=pic%>" width="135" height="100">
						</a>
						<%}else{%>
						<img src="" width="135" height="100">
						<%} %>
					</td>	
					<%} %>	
					
					
				</tr>
				<tr>
					<td style="text-align: right;width: 20%;height: 2.2em" >First Name:</td>
					<td style="text-align: left;"><input type="text" name="txtFName" id="txtFName" required="required" value="<%if(edit && edit_rs!=null){out.print(edit_rs.getString(2)); }%>"></td>
				</tr>
				<tr>
					<td style="text-align: right;height: 2.2em">Middle Name:</td>
					<td style="text-align: left;"><input type="text" name="txtMName" id="txtMName" value="<%if(edit && edit_rs!=null){out.print(edit_rs.getString(3)); }%>"></td>
				</tr>
				<tr>
					<td style="text-align: right;height: 2.2em">Last Name:</td>
					<td style="text-align: left;"><input type="text" name="txtLName" id="txtLName" required value="<%if(edit && edit_rs!=null){out.print(edit_rs.getString(4)); }%>"></td>			
				</tr>
				<tr>
					<td colspan="4">
					<hr>
					</td>
				</tr>
				<tr>
				
					<td style="text-align: right;"><br>Address:</td>
					<td style="text-align: left;width: 10%"><br><textarea name="txtArAddress" required="required"  id="txtArAddress" rows="" cols="20"><%if(edit && edit_rs!=null){out.print(edit_rs.getString(6)); }%></textarea></td>
					<td style="text-align: right;">Contact Number:</td>
					<td style="text-align: left;"><input type="text" name="txtCntNo" id="txtCntNo" required value="<%if(edit && edit_rs!=null){out.print(edit_rs.getString(5)); }%>"></td>
					
											
				</tr>
				<tr>
					<td style="text-align: right;">Bank Name:</td>
					<td style="text-align: left;"><input type="text" name="txtBankName" id="txtBankName" value="<%if(edit && edit_rs!=null){out.print(edit_rs.getString(7)); }%>"></td>
					<td style="text-align: right;">Account Number:</td>
					<td style="text-align: left;"><input type="text" name="txtAccNO" id="txtAccNO" value="<%if(edit && edit_rs!=null){out.print(edit_rs.getString(8)); }%>"></td>
								
				</tr>
				<%-- <tr>
					<td>For Which Field:</td>
					<td>
						<select name="selField" id="selField" multiple="multiple" required>
							<option value="-1">Select</option>
							<%
								try{
								String query="select * from FIELDINFO";	
								Statement field_St=con.createStatement();
								ResultSet rs=field_St.executeQuery(query);
								
								//Edit operation						
								String edit_field_result=null;
								String arr[]=null;
								if(edit && edit_rs!=null){
									String edit_crop_qry="select * from EMPASSIGNFIELD where EMP_ID_FK="+emp_id;	
									Statement edit_field_St=con.createStatement();
									ResultSet edit_field_rs=edit_field_St.executeQuery(edit_crop_qry);
									 while(edit_field_rs.next()){
										 if(edit_field_result!=null){
											edit_field_result=edit_field_result+","+edit_field_rs.getInt(3);
										}else{
											edit_field_result=String.valueOf(edit_field_rs.getInt(3));
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
					<td>For Which Crop:</td>
					<td>
						<select name="selCrop" id="selCrop" multiple="multiple" required>
							<option value="-1">Select</option>
							<%
								try{
								String query="select * from CROPSINFIELD";	
								Statement crop_st=con.createStatement();
								ResultSet rs=crop_st.executeQuery(query);
								
								//Edit operation						
								String edit_crop_result=null;
								String arr[]=null;
								if(edit && edit_rs!=null){
									String edit_crop_qry="select * from EMPASSIGNCROPS where EMP_ID_FK="+emp_id;	
									Statement edit_crop_St=con.createStatement();
									ResultSet edit_crop_rs=edit_crop_St.executeQuery(edit_crop_qry);
									 while(edit_crop_rs.next()){
										 if(edit_crop_result!=null){
											 edit_crop_result=edit_crop_result+","+edit_crop_rs.getInt(3);
										}else{
											edit_crop_result=String.valueOf(edit_crop_rs.getInt(3));
										}	
										
									} 
									 System.out.print("edit_crop_result:="+edit_crop_result);
								}
								
								while(rs.next()){
									boolean flag=false;
									if(edit && edit_rs!=null){
										arr=edit_crop_result.split(",");
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
									crop_st.close();						
								}catch(Exception ex){
									ex.printStackTrace();
								}
							%>
						</select>
					</td>						
				</tr>
				<tr>
					<td>Type Of Work:</td>
					<td>				
						<select name="selWorkType" id="selWorkType" required>
						<option value="-1">Select</option>
						<%if(edit && edit_rs!=null){
							if(edit_rs.getString(9).equalsIgnoreCase("Ukta")){
								%>					
								<option value="Ukta" selected="selected">Ukta</option>	
								<option value="Per Day Payment">Per Day Payment</option>
								<%				
							}else if(edit_rs.getString(9).equalsIgnoreCase("Per Day Payment")){
								%>					
								<option value="Ukta">Ukta</option>	
								<option value="Per Day Payment" selected="selected">Per Day Payment</option>
								<%
							}
						}else{%>					
							<option value="Ukta">Ukta</option>	
							<option value="Per Day Payment">Per Day Payment</option>
							<%} %>				
						</select>
					</td>
					<td>Amount:</td>
					<td><input type="text" name="txtAmount" id="txtAmount" value="<%if(edit && edit_rs!=null){out.print(edit_rs.getString(10)); }else{out.print(0);}%>"></td>	
				</tr> --%>
				<tr>
					<td colspan="5" style="text-align: center;"><br>
					<%if(edit && edit_rs!=null){
					%>
						<input type="hidden" name="hdnEmpId" value="<%=emp_id%>">
						<input type="Submit" name="sbtSave" value="Save">
					<%
					}else{
					%>
					<input type="Submit" name="sbtAdd" value="Add">
					<%} %></td>
				</tr>
			</table>
			</form>
			<br>
			<hr>
			<%
				con.close();
			%>
		</div>
	<!-- <center >
		<input type="Submit" name="sbtAdd" value="Add">
	</center> -->
	</div>
</body>
</html>