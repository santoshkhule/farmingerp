<%@page import="farm.util.FarmUtility"%>
<%@page import="java.sql.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="farm.connection.DBfactory"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Assign Task To Employee</title>
</head>
<body>
	<%
		Connection con = null;
		Statement st = null;
		try {
			DBfactory dbcon = new DBfactory();
			con = dbcon.DBconnection();
			st = con.createStatement();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		if (null != request.getParameter("sbtAdd") || null != request.getParameter("sbtSave")) {			
			
			Date date =Date.valueOf(FarmUtility.convertfrom_ddmmyyToyymmdd(request.getParameter("txtDate")));						
			String site_id =request.getParameter("selField");
			String[] crop_id = request.getParameterValues("selCrop");
			
			//Insert Operation
			if (null != request.getParameter("sbtAdd")) {					
				for(int i=0;i<crop_id.length;i++){			
					System.out.println(crop_id[i]+" ");
					String res = "insert into assigncroptosite(crop_id_fk,site_id_fk,date) values('" + crop_id[i]  + "','" +site_id + "','" +date + "')";			
					st.execute(res);
				}				
				//close all opration
				st.close();		
			}
			
			 //Update Operation
			if (null != request.getParameter("sbtSave")) {
				int assign_crop_site_id=Integer.parseInt(request.getParameter("hdnAssignCropSiteId"));
				try{	
					String qry_sel="select * from assigncroptosite where assign_crop_site_id="+assign_crop_site_id;
					Statement stmt_sel=con.createStatement();
					ResultSet rs_sel=stmt_sel.executeQuery(qry_sel);
					Statement del_stmt=con.createStatement();
					while(rs_sel.next()){
						String del_qry="delete from assigncroptosite where site_id_fk="+rs_sel.getInt(3)+" and date='"+rs_sel.getDate(4)+"'";						
						del_stmt.execute(del_qry);
					}
					del_stmt.close();
					rs_sel.close();
					stmt_sel.close();
				}catch(Exception ex){
					ex.printStackTrace();
				}				
							
				for(int i=0;i<crop_id.length;i++){			
					System.out.println(crop_id[i]+" ");
					String res = "insert into assigncroptosite(crop_id_fk,site_id_fk,date) values('" + crop_id[i]  + "','" +site_id + "','" +date + "')";			
					st.execute(res);
				}				
				//close all opration
				st.close();
			}
		}
		//Delete Operation
		if (null != request.getParameter("sbtDelete")) {
			int assign_crop_site_id=Integer.parseInt(request.getParameter("radAssignCroptoSiteId"));
			String delete_assigncroptosite_qry="delete from assigncroptosite where assign_crop_site_id="+assign_crop_site_id;
			st.execute(delete_assigncroptosite_qry);
		} 
		con.close();
		response.sendRedirect("../assignCropToSite.jsp");
	%>
</body>
</html>