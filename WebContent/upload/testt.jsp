<%@page import="farm.connection.DBfactory"%>
<%@page import="org.apache.catalina.Session"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="Menu_files/style.css">
<title>Farm login</title>
</head>
<body background="../images/back-log.jpg">

<marquee>
 	<h1 style="color: gray;font-style: italic;">Welcome To Kute Farming</h1>
 </marquee>
<hr>
<div class="loginBox">
<%
	Connection con=null;
		
	DBfactory objDbFactory=new DBfactory();
	con=objDbFactory.DBconnection();
%>

	<form action="login.jsp" method="post">
	<h1 style="text-align: center;font-family: serif;">Login Page</h1>
	<span id="hdnErrMessage" style="color: red;font-weight: bold;font-style: italic;" hidden="true">Enter Correct UserName or Password</span>
	<table>
					
		<tr>
			<td style="text-align: right;font-weight: bold;">Username::</td>
			<td><input type="text" name="txtUname" id="txtUname"></td>
		</tr>
		<tr>
			<td style="text-align: right;font-weight: bold;">Password::</td>
			<td><input type="password" name="txtPwd" id="txtPwd"></td>
		</tr>
		<tr>
			<td style="text-align: center;" colspan="2"><input type="submit" name="sbtSignIn" value="Sign In"></td>
		</tr>
	</table>
	</form>
</div>
<% if(null!=request.getParameter("txtUname") && null!=request.getParameter("txtPwd")){
	
	String uname=request.getParameter("txtUname");
	String password=request.getParameter("txtPwd");
	
	String isExist="select * from loginUser where uname='"+uname+"' and password='"+password+"'";
	
	Statement stmt=con.createStatement();
	ResultSet rs =stmt.executeQuery(isExist);
	boolean result=false;
	int user_login_id=0;
	while(rs.next()){
		session.setAttribute("uname",uname);
		user_login_id=rs.getInt(1);
		session.setAttribute("userid",user_login_id);
	//System.out.println("\nresult:="+result);
	result=true;
	
	}
	if(result){
		response.sendRedirect("addAuthEmployeePerInfo.jsp?user_login_id="+user_login_id);
	}else{
		//out.println("\nEnter Correct Password");
		%>
		<script type="text/javascript">
			document.getElementById("hdnErrMessage").hidden=false;
		</script>
		<%
	}
	//rs.close();
	stmt.close();
	con.close();
}  %>
</body>
</html>