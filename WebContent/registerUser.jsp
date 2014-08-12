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

<title>Register User</title>
</head>
<script type="text/javascript">
 function validationEmail(){
	 var Email_id=document.getElementById("txt_Email_id").value;
	 var confirm_Email_id=document.getElementById("txt_confirm_Email_id").value;
	 var pass=document.getElementById("txt_passwrd").value;
	 var confirm_pass=document.getElementById("txt_confirm_passwrd").value;
	 if(Email_id!="" && confirm_Email_id!="" && Email_id!=confirm_Email_id){
		 alert("Email ID Is Not Matching");
		// document.getElementById("txt_Email_id").value="";
		 document.getElementById("txt_confirm_Email_id").value="";
	 }
	 if(pass!="" && confirm_pass!="" && pass!=confirm_pass){
		 alert("Password Is Not Matching");
		 //document.getElementById("txt_passwrd").value="";
		 document.getElementById("txt_confirm_passwrd").value="";
	 }
 }
</script>
<body>
<div class="headerbox">
	<%@ include file="home.jsp" %>	
</div>
<%@ include file="menu.jsp" %>
<div class="box">
<%
	Connection con=null;		
	DBfactory objDbFactory=new DBfactory();
	con=objDbFactory.DBconnection();
	boolean edit=false;
	ResultSet rs_select_edit=null;
	boolean isValid=false;
	if(request.getParameter("isValid")!=null){
		isValid=Boolean.parseBoolean(request.getParameter("isValid"));
		if(isValid){
			%>
			<script>
				alert("Email Id Already Exist");
				window.location="registerUser.jsp";
			</script>
			<%
		}	
	}
	if(request.getParameter("isCurPwdValid")!=null){
		boolean isCurPwdValid=false;
		isCurPwdValid=Boolean.parseBoolean(request.getParameter("isCurPwdValid"));
		if(!isCurPwdValid){
			%>
			<script>
				alert("Enter Correct Current Password");
				window.location="registerUser.jsp";
			</script>
			<%
		}else{
			%>
			<script>
				alert("Password Changed Successfully");				
				window.location="registerUser.jsp";
			</script>
			<%
		}	
	}
	if(null!=request.getParameter("sbt_Edit")){
		edit=true;
		int loginId=Integer.parseInt(request.getParameter("rad_user_login_id"));
		String qry_select_edit="Select * from loginuser where loginid="+loginId;
		Statement stmt_select_edit=con.createStatement();
		rs_select_edit=stmt_select_edit.executeQuery(qry_select_edit);
		rs_select_edit.next();
	}
%>
	<h2>Register User</h2>
	<hr>
	<div align="center">
	<form name="frmRegUser" action="action/registerUserAction.jsp">
		<table>
			<tr>
				<td style="text-align: right;font-weight: bold;">User:</td>
				<%try{
				
						String result="select * from userType";
						Statement st1=con.createStatement();
						ResultSet rs1=st1.executeQuery(result);
				%>
				<td>
					<select name="selUser">
					<option value="-1">---Select---</option>
					<%
						while(rs1.next()){
							if(edit && rs_select_edit!=null){
								if(rs1.getInt(1)==rs_select_edit.getInt(4)){
							%>
								<option value="<%=rs1.getInt(1)%>" selected="selected"><%=rs1.getString(2)%></option>	
							<%
							
								}else{
									%>
									<option value="<%=rs1.getInt(1)%>"><%=rs1.getString(2)%></option>	
								<%	
								}
							}else{							
							%>
								<option value="<%=rs1.getInt(1)%>"><%=rs1.getString(2)%></option>	
							<%
								}
							}
					rs1.close();
					st1.close();
				}catch(Exception ex){
					ex.printStackTrace();
				}
					%>
					</select>					
				</td>
			</tr>
			<tr>		
				<td style="text-align: right;font-weight: bold;">Email Id:</td>
				<td><input type="text" name="txt_Email_id" id="txt_Email_id" required 
						placeholder="username@domain.com"
						pattern="[a-zA-Z0-9._-]+\@[a-zA-Z]+\.[a-z]+"
						oninvalid="setCustomValidity('Enter Valid Email Address')"
						onchange="setCustomValidity('')"  onblur="validationEmail()" 
						value=<%if(edit && rs_select_edit!=null){out.println(rs_select_edit.getString(2));%> readonly="readonly"<%} %>>
				</td>
			</tr>
			<%if(!edit && rs_select_edit==null){%>
			<tr>
				<td style="text-align: right;font-weight: bold;">Confirm Email Id:</td>
				<td><input type="text" name="txt_confirm_Email_id" id="txt_confirm_Email_id" required
						placeholder="username@domain.com"
						pattern="[a-zA-Z0-9._-]+\@[a-zA-Z]+\.[a-z]+"
						oninvalid="setCustomValidity('Enter Valid Email Address')"
						onchange="setCustomValidity('')" onblur="validationEmail()">						
				</td>
			</tr>
			<%} %>
			<%if(edit && rs_select_edit!=null){%>
			<tr>
				<td style="text-align: right;font-weight: bold;">Current Password:</td>
				<td><input type="password" name="txt_cur_passwrd" id="txt_cur_passwrd" required onblur="validationEmail()"></td>
			</tr>
			<%} %>
			<tr>
				<td style="text-align: right;font-weight: bold;"><%if(edit && rs_select_edit!=null){%>New<%} %> Password:</td>
				<td><input type="password" name="txt_passwrd" id="txt_passwrd" required onblur="validationEmail()"></td>
			</tr>
			<tr>
				<td style="text-align: right;font-weight: bold;">Confirm <%if(edit && rs_select_edit!=null){%>New<%} %>  Password:</td>
				<td><input type="password" name="txt_confirm_passwrd" id="txt_confirm_passwrd" required onblur="validationEmail()"></td>
			</tr>
			<tr>
				
				<td colspan="2" style="text-align: center;">
				<%if(!edit){ %>
					<input type="submit" name="sbt_sign_up" id="sbt_sign_up" value="Register">
					<%}else{ %>
					<input type="submit" name="sbt_update" id="sbt_update" value="Update">
					
					<%} %>
				</td>
			</tr>
		</table>
		</form>
	</div>
	<hr>
	<%if(!edit && rs_select_edit==null){%>
	<div>
		<form method="post">
			<input type="submit" name="sbt_Edit" id="sbt_Edit" value="Edit" onclick="this.form.action='registerUser.jsp'">
			<input type="submit" name="sbt_Delete" id="sbt_Delete" value="Delete" onclick="this.form.action='action/registerUserAction.jsp'">
			<table style="width: 100%" border=1 cellSpacing=0>
				<tr>
					<th>Select</th>				
					<th>User Type</th>
					<th>Email Id</th>
				</tr>
				<%
					String qry_login="select * from loginuser";
					Statement stmt_login=con.createStatement();
					ResultSet rs_login=stmt_login.executeQuery(qry_login);
					while(rs_login.next()){
				%>
				<tr>
					<%try{ %>
					<td><input type="radio" name="rad_user_login_id" id="rad_user_login_id" required="required" value="<%=rs_login.getInt(1) %>"></td>
					<td><%=rs_login.getString(5) %></td>
					<td><%=rs_login.getString(2) %></td>
					<%}catch(Exception ex){
						ex.printStackTrace();
					} %>
				</tr>
				<%} %>
			</table>	
		</form>	
	</div>
	<%} %>
	</div>
</body>
</html>