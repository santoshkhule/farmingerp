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
			
		String vendorName = request.getParameter("txtVendorName");	
		String shopName = request.getParameter("txtShopName");	
		String perContactNo = request.getParameter("txtPerContactNo");
		String officeContactNo = request.getParameter("txtOfficeContactNo");	
		String vendorAddress = request.getParameter("txtVendorAddress");	
		String emailId = request.getParameter("txtEmailId");
		//Insert Operation
		if (null != request.getParameter("sbtAdd")) {
			int crop_id = 1;
			
			//insert query
			String query = "insert into vendor(vendor_name,Shop_name,per_contact_number,ofc_contact_number,Address,email_id) values('" + vendorName+ "','" + shopName + "','" + perContactNo + "','" + officeContactNo + "','" + vendorAddress + "','" + emailId + "')";
			
			Statement stmt = con.createStatement();
			stmt.execute(query);
			
			//close all opration			 
			stmt.close();			
		}
		
		//Update Operation
		if (null != request.getParameter("radVendorId") && null != request.getParameter("sbtSave")) {		
			int vendor_id = Integer.parseInt(request.getParameter("radVendorId"));		
			//Update query
			String query = "Update vendor set vendor_name='" + vendorName + "',Shop_name='" + shopName + "',per_contact_number='" + perContactNo + "',ofc_contact_number='"+officeContactNo+"',email_id='"+emailId+"',Address='"+vendorAddress+"' where vendor_id="+vendor_id+"";
			Statement stmt = con.createStatement();
			stmt.execute(query);
			
			//close all opration		
			stmt.close();		
		}
		}
		//Delete Operation
		if (null != request.getParameter("radVendorId") && null != request.getParameter("sbtDelete")) {		
			int vendor_id = Integer.parseInt(request.getParameter("radVendorId"));		
			//System.out.print("crop_id:==>"+crop_id);
			//Delete query
			String query = "delete from vendor where vendor_id="+vendor_id+"";
			Statement stmt = con.createStatement();
			stmt.execute(query);			
			//close all opration		
			stmt.close();
			
		}
		con.close();
	}catch(Exception ex){
		ex.printStackTrace();
	}
	response.sendRedirect("../addVendor.jsp");
%>
</body>
</html>