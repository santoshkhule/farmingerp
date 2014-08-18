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
			
		String unitName = request.getParameter("txtUnitName");
		
		//Insert Operation
		if (null != request.getParameter("sbtAdd")) {
			
			//insert query
			String query = "insert into units(unit_name) values('" + unitName+ "')";
			//String query = "insert into unit(unit_name,Price,Vendor) values('" + unitName+ "','" + price + "','" + vendor + "')";
			//System.out.println("query:=>>>"+query);
			Statement stmt = con.createStatement();
			stmt.execute(query);
			
			//close all opration			
			stmt.close();			
		}
		
		//Update Operation
		if (null != request.getParameter("radUnitId") && null != request.getParameter("sbtSave")) {		
			int unitId = Integer.parseInt(request.getParameter("radUnitId"));		
			//Update query
			String query = "Update units set unit_name='" + unitName + "' where unit_id="+unitId+"";
			//String query = "Update unit set unit_name='" + unitName + "',Price='" + price + "',Vendor='" + vendor + "' where unit_id="+fertiId+"";
			Statement stmt = con.createStatement();
			stmt.execute(query);			
			//close all opration		
			stmt.close();		
		}
		}
		//Delete Operation
		if (null != request.getParameter("radUnitId") && null != request.getParameter("sbtDelete")) {		
			int unitId = Integer.parseInt(request.getParameter("radUnitId"));	
			
			//Delete query
			String query = "delete from units where unit_id="+unitId+"";
			Statement stmt = con.createStatement();
			stmt.execute(query);			
			//close all opration		
			stmt.close();
			
		}
		con.close();
	}catch(Exception ex){
		ex.printStackTrace();
	}
	response.sendRedirect("../addUnits.jsp");
%>
</body>
</html>