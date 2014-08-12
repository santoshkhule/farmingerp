<%@page import="farm.connection.DBfactory"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Actions Perform Process</title>
</head>
<body>
<%
	try{
		Connection con = null;
		DBfactory dBfactory = new DBfactory();
		con = dBfactory.DBconnection();
		
		if (null != request.getParameter("sbtAdd") || null != request.getParameter("sbtSave")) {
			
		String CategoryName = request.getParameter("txtCategoryName");
		
		//Insert Operation
		if (null != request.getParameter("sbtAdd")) {
			
			//insert query
			String query = "insert into Category(cat_name) values('" + CategoryName+ "')";
			//String query = "insert into Category(Category_name,Price,Vendor) values('" + CategoryName+ "','" + price + "','" + vendor + "')";
			//System.out.println("query:=>>>"+query);
			Statement stmt = con.createStatement();
			stmt.execute(query);
			
			//close all opration			
			stmt.close();			
		}
		
		//Update Operation
		if (null != request.getParameter("radCategoryId") && null != request.getParameter("sbtSave")) {		
			int CategoryId = Integer.parseInt(request.getParameter("radCategoryId"));		
			//Update query
			String query = "Update Category set cat_name='" + CategoryName + "' where cat_id="+CategoryId+"";
			//String query = "Update Category set Category_name='" + CategoryName + "',Price='" + price + "',Vendor='" + vendor + "' where Category_id="+fertiId+"";
			Statement stmt = con.createStatement();
			stmt.execute(query);			
			//close all opration		
			stmt.close();		
		}
		}
		//Delete Operation
		if (null != request.getParameter("radCategoryId") && null != request.getParameter("sbtDelete")) {		
			int CategoryId = Integer.parseInt(request.getParameter("radCategoryId"));	
			
			//Delete query
			String query = "delete from Category where cat_id="+CategoryId+"";
			Statement stmt = con.createStatement();
			stmt.execute(query);			
			//close all opration		
			stmt.close();
			
		}
		con.close();
	}catch(Exception ex){
		ex.printStackTrace();
	}
	response.sendRedirect("../addCategory.jsp");
%>
</body>
</html>