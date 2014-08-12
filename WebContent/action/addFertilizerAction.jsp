<%@page import="org.apache.catalina.startup.Catalina"%>
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
int cat_id =0;
	try{
		Connection con = null;
		DBfactory dBfactory = new DBfactory();
		con = dBfactory.DBconnection();
		cat_id =Integer.parseInt(request.getParameter("hdnCatId"));
		if (null != request.getParameter("sbtAdd") || null != request.getParameter("sbtSave")) {
			
		String fertilizerName = request.getParameter("txtFertilizerName");
		
		
		/* String price = request.getParameter("txtPrice");	
		String vendor = request.getParameter("txtVendor"); */
		
		//Insert Operation
		if (null != request.getParameter("sbtAdd")) {					
			//insert query
			String query = "insert into fertilizer(fertilizer_name,cat_id) values('" + fertilizerName+ "',"+cat_id+")";
			//String query = "insert into fertilizer(fertilizer_name,Price,Vendor) values('" + fertilizerName+ "','" + price + "','" + vendor + "')";
			System.out.println("query:=>>>"+query);
			Statement stmt = con.createStatement();
			stmt.execute(query);
			
			//close all opration
			/* st.close();
			rs.close();  */ 
			stmt.close();			
		}
		
		//Update Operation
		if (null != request.getParameter("radFertiId") && null != request.getParameter("sbtSave")) {		
			int fertiId = Integer.parseInt(request.getParameter("radFertiId"));		
			//Update query
			String query = "Update fertilizer set fertilizer_name='" + fertilizerName + "',cat_id="+cat_id+" where fertilizer_id="+fertiId+"";
			//String query = "Update fertilizer set fertilizer_name='" + fertilizerName + "',Price='" + price + "',Vendor='" + vendor + "' where fertilizer_id="+fertiId+"";
			Statement stmt = con.createStatement();
			stmt.execute(query);			
			//close all opration		
			stmt.close();		
		}
		}
		//Delete Operation
		if (null != request.getParameter("radFertiId") && null != request.getParameter("sbtDelete")) {		
			int fertiId = Integer.parseInt(request.getParameter("radFertiId"));		
			//System.out.print("crop_id:==>"+crop_id);
			//Delete query
			String query = "delete from fertilizer where fertilizer_id="+fertiId+"";
			Statement stmt = con.createStatement();
			stmt.execute(query);			
			//close all opration		
			stmt.close();
			
		}
		con.close();
	}catch(Exception ex){
		ex.printStackTrace();
	}
	response.sendRedirect("../addFertilizer.jsp?cat_id="+cat_id);
%>
</body>
</html>