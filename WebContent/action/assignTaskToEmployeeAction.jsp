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
			int empId =Integer.parseInt(request.getParameter("selEmpName"));
			System.out.println("Date:::=>"+request.getParameter("txtDate"));
			Date date =Date.valueOf(FarmUtility.convertfrom_ddmmyyToyymmdd(request.getParameter("txtDate")));
			String time = request.getParameter("txtTime");			
			String[] fieldId =request.getParameterValues("selField");
			String[] cropId = request.getParameterValues("selCrop");
			String[] work=request.getParameterValues("AssignWork");
			String workType = request.getParameter("selWorkType");
			String work_status=request.getParameter("work_status");
			double amount = Double.parseDouble(request.getParameter("txtAmount"));
			double advPayment =Double.parseDouble(request.getParameter("txtAdvPayment"));
			//Insert Operation
			if (null != request.getParameter("sbtAdd")) {
				int assignWork_id=1;
				//Find max_Emp 
				try{
					String qry = "select max(ASSIGNWORK_ID) from ASSIGNWORK";			
					ResultSet rs = st.executeQuery(qry);
					while (rs.next()) {
						assignWork_id = rs.getInt(1);
					}
					rs.close();
				}catch(Exception ex){
					ex.printStackTrace();
				}
				assignWork_id++;
				//insert query
				String query = "insert into ASSIGNWORK values('" + assignWork_id + "'," + empId + ",'" + date + "','" + time + "','"
					+ workType + "','" + amount + "','" + advPayment + "','" + work_status + "')";			
				st.execute(query);
				
							
				for(int i=0;i<fieldId.length;i++){
					System.out.println(fieldId[i]+" ");
					String res = "insert into EMPASSIGNFIELD(ASSIGNWORK_ID_FK,FIELD_ID_FK) values('" + assignWork_id + "','" + fieldId[i] + "')";			
					st.execute(res);
				}
				
				for(int i=0;i<cropId.length;i++){			
					System.out.println(cropId[i]+" ");
					String res = "insert into EMPASSIGNCROP(ASSIGNWORK_ID_FK,CROP_ID_FK) values('" + assignWork_id  + "','" +cropId[i] + "')";			
					st.execute(res);
				}
				
				for(int i=0;i<work.length;i++){			
					System.out.println(work[i]+" ");
					String res = "insert into EMPASSIGNWORK(ASSIGNWORK_ID_FK,WORK_ID_FK) values('" + assignWork_id  + "','" +work[i] + "')";			
					st.execute(res);
				}
				//close all opration
				st.close();		
			}
			
			  //Update Operation
			if (null != request.getParameter("sbtSave")) {
				int assign_work_id=Integer.parseInt(request.getParameter("hdnAssignWorkId"));
						System.out.print("empId:====>"+empId);
				//Update query Employee Information table
				String query = "update ASSIGNWORK set EMP_ID_FK='" + empId + "',ASSIGNDATE='" + date + "',TIME='" + time + "',WORKTYPE='"
					+ workType + "',AMOUNT='" + amount + "',ADVPAYMENT='" + advPayment + "',WORK_STATUS='"+work_status+"' where ASSIGNWORK_ID="+assign_work_id;			
				st.execute(query);
				
				String delete_FIELD_qry="delete from EMPASSIGNFIELD where ASSIGNWORK_ID_FK="+assign_work_id;
				if(st.execute(delete_FIELD_qry)){					
					System.out.print("Fails to Delete");
				}else{
					System.out.print("Deleted SucessFully");
				}
							
				for(int i=0;i<fieldId.length;i++){
					//System.out.println(fieldId[i]+" ");
					String res = "insert into EMPASSIGNFIELD(ASSIGNWORK_ID_FK,FIELD_ID_FK) values('" + assign_work_id + "','" + fieldId[i] + "')";			
					//st.executeQuery(res);
					if(st.execute(res)){
						System.out.print("Fails to insert");						
					}else{
						System.out.print("Inserted SucessFully");
					}
				}
				
				String delete_crop_qry="delete from EMPASSIGNCROP where ASSIGNWORK_ID_FK="+assign_work_id;
				if(st.execute(delete_crop_qry)){
					System.out.print("Fails to Delete");
				}else{					
					System.out.print("Deleted SucessFully");
				}
				
				for(int i=0;i<cropId.length;i++){			
					//System.out.println(cropId[i]+" ");
					String res = "insert into EMPASSIGNCROP(ASSIGNWORK_ID_FK,CROP_ID_FK) values('" + assign_work_id  + "','" +cropId[i] + "')";			
					if(st.execute(res)){
						System.out.print("Fails to insert");
					}else{						
						System.out.print("Inserted SucessFully");
					}
				}
				
				String delete_work_qry="delete from empassignwork where ASSIGNWORK_ID_FK="+assign_work_id;
				if(st.execute(delete_work_qry)){
					System.out.print("Fails to Delete");
				}else{					
					System.out.print("Deleted SucessFully");
				}
				
				for(int i=0;i<work.length;i++){			
					//System.out.println(cropId[i]+" ");
					String res = "insert into empassignwork(ASSIGNWORK_ID_FK,WORK_ID_FK) values('" + assign_work_id  + "','" +work[i] + "')";			
					if(st.execute(res)){
						System.out.print("Fails to insert");
					}else{						
						System.out.print("Inserted SucessFully");
					}
				}
				
				//close all opration
				st.close();
			}
		}
		//Delete Operation
		if (null != request.getParameter("sbtDelete")) {
			int ASSIGNWORK_ID=Integer.parseInt(request.getParameter("radAssignWorkId"));
			String delete_work_qry="delete from ASSIGNWORK where ASSIGNWORK_ID="+ASSIGNWORK_ID;
			st.execute(delete_work_qry);
		} 
		con.close();
		response.sendRedirect("../assignTaskToEmployeeViewAll.jsp");
	%>
</body>
</html>