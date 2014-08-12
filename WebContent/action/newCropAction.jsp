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
		
		//Insert Operation
		if (null != request.getParameter("txtCName") && !request.getParameter("txtCName").equals("") && null != request.getParameter("sbtAdd")) {
			int crop_id = 1;
			String cropName = request.getParameter("txtCName");			
			//Select current max id
			String qry = "select max(CROP_ID) from CROPSINFIELD";
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery(qry);
			while (rs.next()) {
				crop_id = rs.getInt(1);
			} 	
			crop_id++;
			//insert query
			String query = "insert into CROPSINFIELD values('" + crop_id+ "','" + cropName + "')";
			Statement stmt = con.createStatement();
			stmt.execute(query);
			
			//close all opration
			st.close();
			rs.close();  
			stmt.close();
			
		}
		
		//Update Operation
		if (null != request.getParameter("radCropId") && null != request.getParameter("sbtSave")) {		
			int crop_id = Integer.parseInt(request.getParameter("radCropId"));		
			String cropName = request.getParameter("txtCName");
			System.out.print("crop_id:"+crop_id+" cropName:="+cropName);
			//Update query
			String query = "Update CROPSINFIELD set CROP_NAME='" + cropName + "' where CROP_ID="+crop_id+"";
			Statement stmt = con.createStatement();
			stmt.execute(query);			
			//close all opration		
			stmt.close();		
		}
		
		//Delete Operation
		if (null != request.getParameter("radCropId") && null != request.getParameter("sbtDelete")) {		
			int crop_id = Integer.parseInt(request.getParameter("radCropId"));		
			//System.out.print("crop_id:==>"+crop_id);
			//Delete query
			String query = "delete from CROPSINFIELD where CROP_ID="+crop_id+"";
			Statement stmt = con.createStatement();
			stmt.execute(query);			
			//close all opration		
			stmt.close();
			
		}
		con.close();
	}catch(Exception ex){
		ex.printStackTrace();
	}
	response.sendRedirect("../addNewCrop.jsp");
%>
</body>
</html>