<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="farm.util.FarmConstants"%>
<%@page import="farm.util.FarmUtility"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="farm.util.MyFileRenamePolicy"%>
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
<title>Insert title here</title>
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
		if(ServletFileUpload.isMultipartContent(request)){
			MyFileRenamePolicy objFileRenamePolicy=new MyFileRenamePolicy();
			MultipartRequest multipart=new MultipartRequest(request,FarmConstants.getInstance().getFarmProperty("path.name"),
					Integer.parseInt(FarmConstants.getInstance().getFarmProperty("filesize")),objFileRenamePolicy);
		
		if (null != multipart.getParameter("sbtAdd") || null != multipart.getParameter("sbtSave")) {			
			String empPicPath = FarmUtility.uploadedFilesCSV(multipart);
			//System.out.println("empPicPath:="+empPicPath);
			String fName = multipart.getParameter("txtFName");
			String mName = multipart.getParameter("txtMName");
			String lName = multipart.getParameter("txtLName");
			String contactNo=multipart.getParameter("txtCntNo");
			String address = multipart.getParameter("txtArAddress");
			String bankName = multipart.getParameter("txtBankName");
			String accNo = multipart.getParameter("txtAccNO");
			String hdnPhotoPath=multipart.getParameter("hdnUploadedPhoto");
			if(empPicPath==null){
				empPicPath=hdnPhotoPath;
			}
			//Insert Operation
			if (null != multipart.getParameter("sbtAdd")) {
				int emp_id=1;	
				try{
					String qry = "select max(EMP_ID) from EMPLOYEEINFORMATION";			
					ResultSet rs = st.executeQuery(qry);
					while (rs.next()) {
						emp_id = rs.getInt(1);
					}
					rs.close();
				}catch(Exception ex){
					ex.printStackTrace();
				}				
				emp_id++;
				
				//insert query
				System.out.println(empPicPath);
				try{
					String query = "insert into EMPLOYEEINFORMATION values('" + emp_id + "','" + fName + "','" + mName + "','" + lName + "','"
						+ contactNo + "','" + address + "','" + bankName + "','" + accNo + "','"+empPicPath+"',1)";			
					System.out.println(query);
					st.execute(query);
				}catch(Exception ex){
					ex.printStackTrace();
				}
						
			}
			
			//Update Operation
			if (null != multipart.getParameter("sbtSave")) {
				try{
					int emp_id=Integer.parseInt(multipart.getParameter("hdnEmpId"));	
					System.out.println("update:="+empPicPath);
					//Update query Employee Information table
					String query = "update EMPLOYEEINFORMATION set FIRSTNAME='" + fName + "',MIDDLENAME='" + mName + "',LASTNAME='" + lName + "',CONTACTNO='"
						+ contactNo + "',ADDRESS='" + address + "',BANK_NAME='" + bankName + "',BANK_ACC_NO='" + accNo + "',EMP_PIC_PATH='"+empPicPath+"' where EMP_ID="+emp_id;
					System.out.println("\n"+query);
					
					st.execute(query);		
				}catch(Exception ex){
					ex.printStackTrace();
				}				
			}
		}
		}else{
		//Delete Operation
		if (null != request.getParameter("sbtDelete")) {
			try{
				int emp_id=Integer.parseInt(request.getParameter("radEmpId"));
				String delete_emp_qry="delete from EMPLOYEEINFORMATION where EMP_ID="+emp_id;
				st.execute(delete_emp_qry);
			}catch(Exception ex){
				ex.printStackTrace();
			}	
		}
		}
		//close all opration
		st.close();
		con.close();
		response.sendRedirect("../viewAllEmployee.jsp");
	%>
</body>
</html>