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
<title>Insert title here</title>
</head>
<body>
	<%
		Connection con = null;
		Statement st = null;
		int flag=0;
		int assignWork_id =Integer.parseInt(request.getParameter("assignWorkId"));
		try {
			DBfactory dbcon = new DBfactory();
			con = dbcon.DBconnection();
			st = con.createStatement();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		if (null != request.getParameter("sbtPayAmount") || null != request.getParameter("sbtUpdateAmount")) {
			/* int assignWork_id =Integer.parseInt(request.getParameter("assignWorkId")); */
			String paymentType=request.getParameter("selPaymentType");
			String remark=request.getParameter("txtComment");
			String bankName=request.getParameter("txtBankName");
			String accNo=request.getParameter("txtAccNO");
			
			double amountPaid = Double.parseDouble(request.getParameter("txtAmount"));
			Date date= Date.valueOf(FarmUtility.convertfrom_ddmmyyToyymmdd(request.getParameter("txtDate")));
			//Insert Operation
			if (null != request.getParameter("sbtPayAmount")) {
				int transactionId=0;
				try{
					String qry = "select max(EMPSALTRANSACTIONID) from EMPSALTRANSACTION";			
					ResultSet rs = st.executeQuery(qry);
					while (rs.next()) {
						transactionId = rs.getInt(1);
					}
					rs.close();
				}catch(Exception ex){
					ex.printStackTrace();
				}
				if(transactionId!=0){
					transactionId++;
				}
				//insert query
				String query = "insert into EMPSALTRANSACTION values('" + transactionId + "'," + assignWork_id + ",'" + paymentType + "','" + amountPaid + "','"
					+ bankName + "','" + accNo + "','" + remark + "','"+date+"')";			
				st.execute(query);
				flag=1;
				/* out.print("<script>");
				out.print("alert('Inserted Successfully');");				
				out.print("</script>"); */
			}
			
			  //Update Operation
			  if (null != request.getParameter("sbtUpdateAmount")) {
				int sal_transac_Id=Integer.parseInt(request.getParameter("hdnTransacId"));
						
				//Update query Employee Information table
				String query = "update EMPSALTRANSACTION set EMPSALTRANSACTIONID='" + sal_transac_Id + "',ASSIGNWORK_ID_FK=" + assignWork_id + ",PAYMENT_TYPE='" 
				+ paymentType + "',AMOUNTPAID='" + amountPaid + "',BANK_NAME='"+ bankName + "',BANK_ACC_NO='" + accNo + "',REMARK='" + remark + "',TRANSACTIONDATE='"+date+"' where EMPSALTRANSACTIONID="+sal_transac_Id;							
				st.execute(query);
				flag=2;
				/* out.print("<script>");
				out.print("alert('Updated Successfully');");				
				out.print("</script>"); */
				
			} 
		}
		//Delete Operation
		if (null != request.getParameter("sbtDelete")) {
			int emp_transac_id=Integer.parseInt(request.getParameter("radEmpSalTrancastionId"));
			String delete_transac_qry="delete from EMPSALTRANSACTION where EMPSALTRANSACTIONID="+emp_transac_id;
			st.execute(delete_transac_qry);
			flag=3;
			/* out.print("<script>");
			out.print("alert('Deleted Successfully');");			
			out.print("</script>"); */
		}
		
		//close all opration
		st.close();
		con.close();
		/* out.print("<script>");		
		out.print("window.open('../01employeeSalaryProcess.jsp','_parent')");
		out.print("</script>"); */
		response.sendRedirect("../001SalaryProcessing.jsp?assignWorkId="+assignWork_id+"&flag="+flag);
	%>
</body>
</html>