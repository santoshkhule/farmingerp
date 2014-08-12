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
			
		String brandName = request.getParameter("txtBrandName");
		
		//Insert Operation
		if (null != request.getParameter("sbtAdd")) {
			
			//insert query
			String query = "insert into brand(brand_name) values('" + brandName+ "')";
			//String query = "insert into brand(brand_name,Price,Vendor) values('" + brandName+ "','" + price + "','" + vendor + "')";
			//System.out.println("query:=>>>"+query);
			Statement stmt = con.createStatement();
			stmt.execute(query);
			
			//close all opration			
			stmt.close();			
		}
		
		//Update Operation
		if (null != request.getParameter("radBrandId") && null != request.getParameter("sbtSave")) {		
			int brandId = Integer.parseInt(request.getParameter("radBrandId"));		
			//Update query
			String query = "Update brand set brand_name='" + brandName + "' where brand_id="+brandId+"";
			//String query = "Update brand set brand_name='" + brandName + "',Price='" + price + "',Vendor='" + vendor + "' where brand_id="+fertiId+"";
			Statement stmt = con.createStatement();
			stmt.execute(query);			
			//close all opration		
			stmt.close();		
		}
		}
		//Delete Operation
		if (null != request.getParameter("radBrandId") && null != request.getParameter("sbtDelete")) {		
			int brandId = Integer.parseInt(request.getParameter("radBrandId"));	
			
			//Delete query
			String query = "delete from brand where brand_id="+brandId+"";
			Statement stmt = con.createStatement();
			stmt.execute(query);			
			//close all opration		
			stmt.close();
			
		}
		con.close();
	}catch(Exception ex){
		ex.printStackTrace();
	}
	response.sendRedirect("../addBrand.jsp");
%>
</body>
</html>