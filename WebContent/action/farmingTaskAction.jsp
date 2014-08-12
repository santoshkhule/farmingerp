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
<title>Farming Task Action</title>
</head>
<body>
<%
try{
	Connection con = null;
	DBfactory dBfactory = new DBfactory();
	con = dBfactory.DBconnection();
	
	String taskName=null;
	if(null!=request.getParameter("sbtAdd")|| null!=request.getParameter("sbtSave")){
		taskName=request.getParameter("txtTaskName");
		
		if(null!=request.getParameter("sbtAdd")){			
		int taskId=0;
		//Select current max id
		try{
			String qry = "select max(WORK_ID) from worktype";
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery(qry);
			while (rs.next()) {
				taskId = rs.getInt(1);
			} 
			//close all opration
			st.close();
			rs.close();  
		}catch(Exception ex){
			ex.printStackTrace();
		}
		taskId++;
		//insert query
		String query = "insert into worktype values('" + taskId+ "','" + taskName + "')";
		Statement add_st=con.createStatement();
		Statement stmt = con.createStatement();
		stmt.execute(query);
		//close all opration
		add_st.close();
		}	
		
		//update operation
		if(request.getParameter("sbtSave")!=null){						
			int taskId=Integer.parseInt(request.getParameter("hdnTaskId"));
			System.out.print(taskId+"  "+taskName);
			String update_qry="update worktype set WORK_NAME='"+taskName+"' where WORK_ID="+taskId;
			Statement update_st=con.createStatement();
			update_st.execute(update_qry);
			
			//close operation
			update_st.close();
			
			out.print("<script>");
			out.print("alert(Updated Successfully);");
			out.print("</script>");
		}
	}
	
	//Delete operation
	if(request.getParameter("sbtDelete")!=null){						
		int taskId=Integer.parseInt(request.getParameter("radTaskId"));
		String delete_qry="delete from worktype where WORK_ID="+taskId;
		Statement delete_st=con.createStatement();
		delete_st.execute(delete_qry);
		
		//close operation
		delete_st.close();					
		out.print("<script>");
		out.print("alert(Deleted Successfully);");
		out.print("</script>");
	}
	
	//close all operation	
	con.close();
	/* out.print("<script>");		
	out.print("window.open('../addFarmingTask.jsp')");
	out.print("</script>"); */
	response.sendRedirect("../addFarmingTask.jsp");
}catch(Exception ex){
	
}

%>
</body>
</html>