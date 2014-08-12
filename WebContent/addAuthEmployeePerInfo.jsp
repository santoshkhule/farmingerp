<%@page import="farm.util.FarmUtility"%>
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
<link rel="stylesheet" href="css/jquery-ui.css" />
<script src="js/jquery-1.9.1.js"></script>
<script src="js/jquery-ui.js"></script>
<title>Employee Information</title>
</head>
<script>
	$(function() {		
		$("#txt_birth_date").datepicker({

			changeMonth : true,
			changeYear : true,
			dateFormat : "dd/mm/yy"
		}).val();

	});
</script>
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
			int user_login_id=0;
			ResultSet edit_rs=null;
			if(request.getParameter("user_login_id")!=null){
				edit=true;
				user_login_id=Integer.parseInt(request.getParameter("user_login_id"));
				String edit_qry="Select * from authemployeeinfo where loginid="+user_login_id;
				System.out.print(edit_qry);
				Statement edit_st=con.createStatement();
				edit_rs=edit_st.executeQuery(edit_qry);
				edit_rs.next();
			}
		%>
			<h2>Employee Information</h2>
			<hr>
			<form  name="frmAddEmp" action="action/addAuthEmployeePerInfoAction.jsp" enctype="multipart/form-data" method="post">
			<table border=0 style="width: 100%" cellSpacing=0>
				<tr>
					<td rowspan="4"<%if(!edit && edit_rs==null){ %> colspan="2"<%} %>>
					Upload Employee Photo:
					<input type="file" name="fileEmpPhoto" id="fileEmpPhoto"></td>
					<%if(edit && edit_rs!=null && edit_rs.getString(12)!=null && !edit_rs.getString(12).equalsIgnoreCase("")){ %>					
					<td style="text-align: center;" rowspan="4">
					<input type="hidden" name="hdnUploadedPhoto" value="<%=edit_rs.getString(12)%>">					
							<% try{
								//out.println(edit_rs.getString(12));
							String photo[]=null;
							String pic=null;
							if(edit_rs.getString(12)!=null && !edit_rs.getString(12).equalsIgnoreCase("") && !edit_rs.getString(12).equalsIgnoreCase("null")){
								photo=edit_rs.getString(12).split("/");															
								pic=photo[photo.length-2]+"/"+photo[photo.length-1];							
							//out.println(pic);
							%>
						<a href="DownloadFileServlet?fileName=<%=photo[photo.length-1]%>">
							<img src="<%=pic%>" width="135" height="100">
						</a>
						<%}else{%>
						<img src="" width="135" height="100">
						<%} %>
					</td>	
					<%}catch(Exception ex){
						ex.printStackTrace();
					}} %>	
					
					
				</tr>
				<tr>
					<td style="text-align: right;width: 20%;height: 2.2em" >First Name:</td>
					<td style="text-align: left;"><input type="text" name="txtFName" id="txtFName" required="required" value="<%if(edit && edit_rs!=null && edit_rs.getString(2)!=null){out.print(edit_rs.getString(2)); }%>"></td>
				</tr>
				<tr>
					<td style="text-align: right;height: 2.2em">Middle Name:</td>
					<td style="text-align: left;"><input type="text" name="txtMName" id="txtMName" value="<%if(edit && edit_rs!=null && edit_rs.getString(3)!=null){out.print(edit_rs.getString(3)); }%>"></td>
				</tr>
				<tr>
					<td style="text-align: right;height: 2.2em">Last Name:</td>
					<td style="text-align: left;"><input type="text" name="txtLName" id="txtLName" required value="<%if(edit && edit_rs!=null && edit_rs.getString(4)!=null){out.print(edit_rs.getString(4)); }%>"></td>			
				</tr>
				<tr>
					<td colspan="4">
					<hr>
					</td>
				</tr>
				<tr>
				<%
					String qry_select_email="select distinct(uname) from loginuser where loginid="+user_login_id;
					Statement stmt_select_email=con.createStatement();
					ResultSet rs_select_email=stmt_select_email.executeQuery(qry_select_email);
					System.out.println(qry_select_email);
					rs_select_email.next();	
					System.out.println("rs_select_email.getString:="+rs_select_email.getString("uname"));
				%>
					<td style="text-align: right;">Email_id:</td>
					<td style="text-align: left;"><input type="text" name="txt_email_id" id="txt_email_id" readonly="readonly" value="<%if(edit && rs_select_email!=null){out.print(rs_select_email.getString("uname")); }%>">
					</td>
					<td style="text-align: right;">Birth_Date:</td>
					<td style="text-align: left;">
								<input type="text" name="txt_birth_date" id="txt_birth_date" placeholder="dd/mm/yyyy" 
								pattern="(0[1-9]|[12][0-9]|3[01])\/(0[1-9]|1[0-2])\/\d{4}" oninvalid="setCustomValidity('Select Date From Calender')"								 
								value="<%if(edit && edit_rs!=null && edit_rs.getString(9)!=null){out.print(FarmUtility.convertfrom_yymmddToddmmyy(edit_rs.getString(9))); }%>">
					</td>				
				</tr>
				<tr>
					<td style="text-align: right;">Contact Number1:</td>
					<td style="text-align: left;"><input type="text" name="txtCntNo1" id="txtCntNo1" required value="<%if(edit && edit_rs!=null && edit_rs.getString(5)!=null){out.print(edit_rs.getString(5)); }%>">
					</td>
					<td style="text-align: right;">Contact Number2:</td>
					<td style="text-align: left;"><input type="text" name="txtCntNo2" id="txtCntNo2"  value="<%if(edit && edit_rs!=null && edit_rs.getString(6)!=null){out.print(edit_rs.getString(6)); }%>">
					</td>				
				</tr>
								
				<tr>
					<td style="text-align: right;width: 25%">Local Address:</td>
					<td style="text-align: left;width: 10%"><textarea name="txtArLAddress" required="required"  id="txtArLAddress" rows="" cols="20"><%if(edit && edit_rs!=null && edit_rs.getString(8)!=null){out.print(edit_rs.getString(8)); }%></textarea></td>
					<td style="text-align: right;">Permanent Address:</td>
					<td style="text-align: left;width: 30%"><textarea name="txtArPAddress" required="required"  id="txtArPAddress" rows="" cols="20"><%if(edit && edit_rs!=null && edit_rs.getString(7)!=null){out.print(edit_rs.getString(7)); }%></textarea></td>
															
				</tr>				
				<tr>
					<td style="text-align: right;">Bank Name:</td>
					<td style="text-align: left;"><input type="text" name="txtBankName" required="required" id="txtBankName" value="<%if(edit && edit_rs!=null && edit_rs.getString(10)!=null){out.print(edit_rs.getString(10)); }%>"></td>
					<td style="text-align: right;">Account Number:</td>
					<td style="text-align: left;"><input type="text" name="txtAccNO" id="txtAccNO" required="required" value="<%if(edit && edit_rs!=null && edit_rs.getString(11)!=null){out.print(edit_rs.getString(11)); }%>"></td>
								
				</tr>
				<tr>
					<td style="text-align: right;">Comment:</td>
					<td style="text-align: left;"><textarea name="txtComment" rows="" cols="25"><%if(edit && edit_rs!=null && edit_rs.getString(13)!=null){out.print(edit_rs.getString(13)); }%> </textarea></td>
					
								
				</tr>
				<tr>
					<td colspan="5" style="text-align: center;"><br>
					<%if(edit && edit_rs!=null){
					%>
						<input type="hidden" name="hdnEmpId" value="<%=user_login_id%>">
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