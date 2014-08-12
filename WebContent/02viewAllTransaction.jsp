<%@page import="farm.util.FarmUtility"%>
<%@page import="farm.connection.DBfactory"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<!-- <link rel="stylesheet" href="css/style.css"> -->
<link rel="stylesheet" href="Menu_files/menu.css" type="text/css" media="screen">
<title>View All Transaction</title>
</head>
<body>
<div class="headerbox">
	<%@ include file="home.jsp" %>	
</div>
<%@ include file="menu.jsp" %>
<div class="box">
				<%
				Connection con = null;
				Statement st = null;
				double ttlAmountToPay=0;
				double ttlAmountPaid=0;
				double ttlBalance=0,ttlExcessAmount=0,ttlAdvancedPaid=0;
				try {
					DBfactory dbcon = new DBfactory();
					con = dbcon.DBconnection();
					st = con.createStatement();
				} catch (Exception ex) {
					ex.printStackTrace();
				}
				int empId=0;
				if(null!=request.getParameter("radEmpId")){
					 empId=Integer.parseInt(request.getParameter("radEmpId"));
				}
		%>
			<h2>View All Transaction Of Employee</h2>
			<hr>
			<br>
			<table border="1" cellspacing="0" style="width: 100%">
				
					<tr>
						<th>Sr.no.</th>				
						<th>Name</th>
						<th>Date</th>
						<th>Time</th>
						<th>Site Name</th>
						<th>Crop Name</th>				
						<th>Work Type</th>
						<th>Work Status</th>
						<th>Assign Work</th>
						<th>Amount To Pay</th>
						<th>Advanced</th>
						<th>Total Amount Paid</th>
						<th>Balance</th>	
						<th>Excess Amount</th>				
					</tr>		
				<tbody>
					<%
					try{
						String query = "Select * from ASSIGNWORK where EMP_ID_FK="+empId+" order by ASSIGNWORK_ID asc";
						ResultSet rs=st.executeQuery(query);
						int cnt=0;
						while(rs.next()){
							cnt++;
							int assign_Work_id=rs.getInt(1);
							int emp_id=rs.getInt(2);
					%>
					<tr>
						<td>
							<%=cnt %>
						</td>				
						<td>
							<% 
							try{
								String sel_Emp_query = "Select * from EMPLOYEEINFORMATION where EMP_ID="+emp_id;
								//System.out.print("\nsel_Emp_query:"+sel_Emp_query);
								Statement sel_Emp_st=con.createStatement();
								ResultSet sel_Emp_rs=sel_Emp_st.executeQuery(sel_Emp_query);						
								while(sel_Emp_rs.next()){							
									
								//if(sel_Emp_rs.getString(2)!=null && sel_Emp_rs.getString(3)!=null && sel_Emp_rs.getString(4)!=null){
									out.print(sel_Emp_rs.getString(2) +" "+sel_Emp_rs.getString(3)+" "+sel_Emp_rs.getString(4)); 
								//}else{
									//out.print("-");
								//}						
								
								}
								sel_Emp_rs.close();
								sel_Emp_st.close();
								
							}catch(Exception ex){
									ex.printStackTrace();
								}
							%>
						</td>
						<td><%if(rs.getString(3)!=null){out.print(FarmUtility.convertfrom_yymmddToddmmyy(rs.getString(3)));}else{out.print("-");} %></td>				
						<td><%if(rs.getString(4)!=null){out.print(rs.getString(4));}else{out.print("-");} %></td> 
						<td>
							<%
								try{
									String field_qry="Select FIELD_NAME from FIELDINFO where FIELD_ID in(Select FIELD_ID_FK from EMPASSIGNFIELD where ASSIGNWORK_ID_FK="+assign_Work_id+")";
									//System.out.print(field_qry);
									Statement field_st=con.createStatement();
									ResultSet field_res=field_st.executeQuery(field_qry);
									String FIELD_NAME=null;
									while(field_res.next()){
										if(FIELD_NAME!=null){
											FIELD_NAME=FIELD_NAME+","+field_res.getString("FIELD_NAME");
										}else{
											FIELD_NAME=field_res.getString("FIELD_NAME");
										}								
									}
									out.print(FIELD_NAME);
									field_res.close();
									field_st.close();
								}catch(Exception ex){
									ex.printStackTrace();
								}
							
							 %>
						</td>
						<td>
							<%
								try{
									String crop_qry="Select CROP_NAME from CROPSINFIELD where CROP_ID in(Select CROP_ID_FK from EMPASSIGNCROP where ASSIGNWORK_ID_FK="+assign_Work_id+")";
									//System.out.print(crop_qry);
									Statement crop_st=con.createStatement();
									ResultSet crop_res=crop_st.executeQuery(crop_qry);
									String CROP_NAME=null;
									while(crop_res.next()){								
										if(CROP_NAME!=null){
											CROP_NAME=CROP_NAME+","+crop_res.getString("CROP_NAME");
										}else{
											CROP_NAME=crop_res.getString("CROP_NAME");
										}								
									}
									out.print(CROP_NAME);
									crop_res.close();
									crop_st.close();
								}catch(Exception ex){
									ex.printStackTrace();
								}
							
							 %>
						</td>
						<td><%if(rs.getString(5)!=null){out.print(rs.getString(5));}else{out.print("-");} %></td>
						<td><%out.print(rs.getString(8));%></td>
						<td>
							<%
								try{
									String work_qry="Select WORK_NAME from WORKTYPE where WORK_ID in(Select WORK_ID_FK from EMPASSIGNWORK where ASSIGNWORK_ID_FK="+assign_Work_id+")";
									//System.out.print(crop_qry);
									Statement work_st=con.createStatement();
									ResultSet work_res=work_st.executeQuery(work_qry);
									String work_NAME=null;
									while(work_res.next()){								
										if(work_NAME!=null){
											work_NAME=work_NAME+","+work_res.getString("WORK_NAME");
										}else{
											work_NAME=work_res.getString("WORK_NAME");
										}								
									}
									if(work_NAME!=null){
										out.print(work_NAME);
									}else{
										out.print("-");
									}
									work_res.close();
									work_st.close();
								}catch(Exception ex){
									ex.printStackTrace();
								}
							
							 %>
						</td>
						<%
						
							double ttl_transaction_paid_amount=0;
							double excessAmount=0;
							double balanceAmount=0;
							try{
								String cal_query = "Select * from EMPSALTRANSACTION where ASSIGNWORK_ID_FK='"+assign_Work_id+"' order by EMPSALTRANSACTIONID asc";
								Statement cal_st=con.createStatement();
								ResultSet cal_rs=cal_st.executeQuery(cal_query);						
								while(cal_rs.next()){
									ttl_transaction_paid_amount=ttl_transaction_paid_amount+cal_rs.getDouble(4);
								}
							}catch(Exception ex){
							ex.printStackTrace();			
						}
						balanceAmount=rs.getDouble(6)-(rs.getDouble(7)+ttl_transaction_paid_amount);
						if(balanceAmount<0){
							excessAmount=-balanceAmount;
							balanceAmount=0;
						}
						//Calculating total Amount to Pay,Total Amount Paid and Total Balance
						ttlAmountToPay=ttlAmountToPay+rs.getDouble(6);
						ttlAmountPaid=ttlAmountPaid+(rs.getDouble(7)+ttl_transaction_paid_amount-excessAmount);
						ttlBalance=ttlBalance+balanceAmount;
						ttlExcessAmount=ttlExcessAmount+excessAmount;				
						%>
						<td><%out.print(rs.getDouble(6));%></td>
						<td><%
						ttlAdvancedPaid=ttlAdvancedPaid+rs.getDouble(7);
						out.print(rs.getDouble(7));%></td>
						<td><%out.print(rs.getDouble(7)+ttl_transaction_paid_amount-excessAmount); %></td>
						<td><%out.print(balanceAmount); %></td>
						<td><%out.print(excessAmount); %>
							<%-- <input type="hidden" id="hdnTtlAmtPaid<%=assign_Work_id%>" value="<%=rs.getDouble(7)+ttl_transaction_paid_amount-excessAmount %>">
							<input type="hidden" id="hdnTtlAmtBal<%=assign_Work_id%>" value="<%=balanceAmount %>"> --%>
						</td>
					</tr>
					
					<%}
					%>
					<tr>
						<td style="font-weight: bold; text-align: right;" colspan="9">Total</td>
						<td><%=ttlAmountToPay %></td>
						<td><%=ttlAdvancedPaid %></td>
						<td><%=ttlAmountPaid %></td>
						<td><%=ttlBalance %></td>
						<td><%=ttlExcessAmount %>
							
							
							
						</td>
					</tr>
					<%
						rs.close();
						con.close();
				}catch(Exception ex){
					ex.printStackTrace();
				}
		%>
				</tbody>
		</table>
	</div>
</div>
</body>
</html>