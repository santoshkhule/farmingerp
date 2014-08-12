<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="farm.connection.DBfactory"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
/* created connnection wth Databse */
Connection con=null;
try{
	DBfactory dBfactory=new DBfactory();
	con=dBfactory.DBconnection();
}catch(Exception ex){
	ex.printStackTrace();
}

/* Code for Insert Updated Delete operation */
if(con!=null){
	boolean isValid=false,isCurPwdValid=false;
	if(null!=request.getParameter("sbt_sign_up")|| null!=request.getParameter("sbt_update")){
		String email_id="";
		String password="";
		String uname="";
		int user_type_id=0;
		if(null!=request.getParameter("txt_Email_id")){
			email_id=request.getParameter("txt_Email_id");
		}
		if(null!=request.getParameter("txt_passwrd")){
			password=request.getParameter("txt_passwrd");
		}
		if(null!=request.getParameter("selUser")){
			user_type_id=Integer.parseInt(request.getParameter("selUser"));
		}
		/* retrive uname from userType table  */
		try{
			String qry_user_name="Select USERTYPE from usertype where usertypeid="+user_type_id;
			System.out.println(qry_user_name);
			Statement stmt_user_name=con.createStatement();
			ResultSet rs_user_name=stmt_user_name.executeQuery(qry_user_name);
			while(rs_user_name.next()){
				uname=rs_user_name.getString("USERTYPE");
			}
			rs_user_name.close();
			stmt_user_name.close();
		}catch(Exception ex){
			ex.printStackTrace();
		}
		//insert operation
		if(null!=request.getParameter("sbt_sign_up")){			
			int max_login_id=0;			
			String qry_login_max="Select max(LOGINID) from loginuser";
			Statement stmt_login_max=con.createStatement();
			ResultSet rs_login_max=stmt_login_max.executeQuery(qry_login_max);
			while(rs_login_max.next()){
				max_login_id=rs_login_max.getInt(1);
			}
			max_login_id++;
			rs_login_max.close();
			stmt_login_max.close();
			
			/* Validation Code:to check uname Exist or not */
			try{
				String qry_login_validation="Select uname from loginuser where uname like '"+email_id+"'";
				//System.out.println("qry_login_validation:="+qry_login_validation);
				Statement stmt_login_validation=con.createStatement();
				ResultSet rs_login_validation=stmt_login_validation.executeQuery(qry_login_validation);
				
				while(rs_login_validation.next()){				
					isValid=true;
				}				
				rs_login_validation.close();
				stmt_login_validation.close();				
			}catch(Exception ex){
				ex.printStackTrace();
			}
			
			if(!isValid){
				/* Insert into Login table into loginuser */
				String qry_login_insert="insert into loginuser values("+max_login_id+",'"+email_id+"','"+password+"',"+user_type_id+",'"+uname+"')";
				Statement stmt_login_insert=con.createStatement();
				stmt_login_insert.executeUpdate(qry_login_insert);
				stmt_login_insert.close();
				
				/* Insert into Login table into authemployeeinfo */	
				String qry_auth_emp_insert="insert into authemployeeinfo (loginid) values("+max_login_id+")";			
				Statement stmt_auth_emp_insert=con.createStatement();
				stmt_auth_emp_insert.executeUpdate(qry_auth_emp_insert);			
				stmt_auth_emp_insert.close();
			}		
		}
		//Update operation
		if(null!=request.getParameter("sbt_update")){
			String cur_passwrd=request.getParameter("txt_cur_passwrd");
			System.out.println("cur_passwrd:="+cur_passwrd);
			int login_id=0;
			/* Validation Code:to check Current password Exist or not */
			try{
				String qry_login_validation="Select * from loginuser where uname like '"+email_id+"' and password like '"+cur_passwrd+"'";
				System.out.println("qry_login_validation:="+qry_login_validation);
				Statement stmt_login_validation=con.createStatement();
				ResultSet rs_login_validation=stmt_login_validation.executeQuery(qry_login_validation);
				
				while(rs_login_validation.next()){				
					isCurPwdValid=true;
					login_id=rs_login_validation.getInt(1);
				}				
				rs_login_validation.close();
				stmt_login_validation.close();				
			}catch(Exception ex){
				ex.printStackTrace();
			}
			String qry_update_login="update loginuser set password='"+password+"' where loginid="+login_id;
			System.out.println(qry_update_login);
			if(isCurPwdValid){
				//String qry_update_login="update loginuser set password='"+password+"' where loginid="+login_id;
				Statement stmt_update_login=con.createStatement();
				stmt_update_login.executeUpdate(qry_update_login);
				stmt_update_login.close();
			}
		}
	}
	//Delete operation
	if(null!=request.getParameter("sbt_Delete")){
		int loginId=Integer.parseInt(request.getParameter("rad_user_login_id"));
		String qry_delete="delete from loginuser where LOGINID="+loginId;
		Statement stmt_delete=con.createStatement();
		stmt_delete.executeUpdate(qry_delete);
	}
	response.sendRedirect("../registerUser.jsp?isValid="+isValid+"&isCurPwdValid="+isCurPwdValid);
}else{
	out.println("Pease Check DataBase Connection");
	%>
	<script>
		alert("Please check database Connection");
	</script>
	<%
}
%>
</body>
</html>