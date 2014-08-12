<%@page import="farm.util.FarmUtility"%>
<%@page import="farm.connection.DBfactory"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="css/jquery-ui.css" />
<script src="js/jquery-1.9.1.js"></script>
<script src="js/jquery-ui.js"></script> 
<title>Assign Site And Work</title>
</head>
<body>

			
			<h2 onclick="window.print()">View Assign Site And Work</h2>
			<hr>
			<%
			try{
			Connection con=null;
			Statement st=null;
			try{
				DBfactory dbcon=new DBfactory();
				con=dbcon.DBconnection();
				st=con.createStatement();
			}catch(Exception ex){
				ex.printStackTrace();
			}
			boolean edit=false;
			int edit_Assign_Work_id=0;
			ResultSet edit_rs=null;
			if(request.getParameter("sbtView")!=null && request.getParameter("radAssignWorkId")!=null){
				edit=true;
				edit_Assign_Work_id=Integer.parseInt(request.getParameter("radAssignWorkId"));
				String edit_qry="Select * from ASSIGNWORK where ASSIGNWORK_ID="+edit_Assign_Work_id;
				//out.print(edit_qry);
				Statement edit_st=con.createStatement();
				edit_rs=edit_st.executeQuery(edit_qry);
				edit_rs.next();
			}
			%>
			
				<table border=1 cellSpacing="0" style="width: 40%;">
					<tr>
						<td style="text-align: right;">Employee Name:</td>
						<td>
							
							<%
							try{
								String query="select * from EMPLOYEEINFORMATION where EMP_ID="+edit_rs.getInt(2);	
								Statement emp_St=con.createStatement();
								ResultSet emp_rs=emp_St.executeQuery(query);
								while(emp_rs.next()){														
									out.println(emp_rs.getString(2)+" "+emp_rs.getString(3)+" "+emp_rs.getString(4) );										
								}
								emp_rs.close();
								emp_St.close();
							}catch(Exception ex){
								ex.printStackTrace();
							}
							
							%>
							
						</td>
					</tr>					
					<tr>
						<td style="text-align: right;">Date:</td>			
						<td>
							<%if(edit && edit_rs!=null){out.print(FarmUtility.convertfrom_yymmddToddmmyy(edit_rs.getString(3)));} %></td>
					</tr>					
					<tr>
						<td style="text-align: right;">Time:</td>
						<td><%if(edit && edit_rs!=null && edit_rs.getString(4)!=null && !edit_rs.getString(4).equalsIgnoreCase("null")){out.print(edit_rs.getString(4));} %></td>	
					</tr>					
					<tr>
								<td style="text-align: right;">For Which Site:</td>
								<td>
															
										<%
											try{											
											if(edit && edit_rs!=null){
												String edit_crop_qry="select FIELD_ID_FK from EMPASSIGNFIELD where ASSIGNWORK_ID_FK="+edit_Assign_Work_id;	
												Statement edit_field_St=con.createStatement();
												ResultSet edit_field_rs=edit_field_St.executeQuery(edit_crop_qry);
												 while(edit_field_rs.next()){
													 String query="select FIELD_NAME from FIELDINFO where FIELD_ID="+edit_field_rs.getInt("FIELD_ID_FK");	
														Statement field_St=con.createStatement();
														ResultSet rs=field_St.executeQuery(query);
														 while(rs.next()){
															 out.println(rs.getString("FIELD_NAME")+"<br>");
														 }
																										
												} 
											}											
											}catch(Exception ex){
												ex.printStackTrace();
											}
										%>
									
								</td>
					</tr>					
					<tr>
						<td style="text-align: right;">For Which Crop:</td>
						<td>															
							<%
											try{
											
											if(edit && edit_rs!=null){
												String edit_crop_qry="select CROP_ID_FK from EMPASSIGNCROP where ASSIGNWORK_ID_FK="+edit_Assign_Work_id;	
												Statement edit_crop_St=con.createStatement();
												ResultSet edit_crop_rs=edit_crop_St.executeQuery(edit_crop_qry);
												 while(edit_crop_rs.next()){
													 	String query="select CROP_NAME from CROPSINFIELD where CROP_ID="+edit_crop_rs.getInt("CROP_ID_FK");	
														Statement crop_st=con.createStatement();
														ResultSet rs=crop_st.executeQuery(query);
														while(rs.next()){
															out.println(rs.getString("CROP_NAME")+"<br>");		
														}
												}												 
											}
											}catch(Exception ex){
												ex.printStackTrace();
											}
										%>
									
						</td>
					</tr>					
					<tr>
								<td style="text-align: right;">Type Of Work:</td>
								<td>				
									<%if(edit && edit_rs!=null){
										out.println(edit_rs.getString(5));
									}
									%>
								</td>								
							</tr>
							<tr>	
								<td style="text-align: right;">Work:</td>
								<td>
									
										<%
											try{
												String edit_work_result=null;
												String arr[]=null;
												if(edit && edit_rs!=null){
													String edit_work_qry="select WORK_ID_FK from EMPASSIGNWORK where ASSIGNWORK_ID_FK="+edit_Assign_Work_id;	
													Statement edit_work_St=con.createStatement();
													ResultSet edit_work_rs=edit_work_St.executeQuery(edit_work_qry);
													 while(edit_work_rs.next()){
														 	String work_query="select WORK_NAME from WORKTYPE where WORK_ID="+edit_work_rs.getInt("WORK_ID_FK");	
															Statement work_st=con.createStatement();
															ResultSet work_rs=work_st.executeQuery(work_query);
															while(work_rs.next()){															
														 		out.print(work_rs.getString("WORK_NAME")+"<br>");
															}
													} 												
												}
											}catch(Exception ex){
												ex.printStackTrace();
											}											
											%>
								</td>	
							</tr>				
							<tr>
								<td style="text-align: right;">Amount:</td>
								<td>
									<%if(edit && edit_rs!=null){out.print(edit_rs.getString(6)); }else{out.print(0);}%>
								</td>
							</tr>					
							<tr>
								<td style="text-align: right;">Advance Payment:</td>
								<td><%if(edit && edit_rs!=null){out.print(edit_rs.getString(7)); }else{out.print(0);}%></td>
							</tr>
							<%				
									double ttl_transaction_paid_amount=0;
									double excessAmount=0;
									double balanceAmount=0;
									try{
										String cal_query = "Select * from EMPSALTRANSACTION where ASSIGNWORK_ID_FK='"+edit_Assign_Work_id+"' order by EMPSALTRANSACTIONID asc";
										Statement cal_st=con.createStatement();
										ResultSet cal_rs=cal_st.executeQuery(cal_query);						
										while(cal_rs.next()){
											ttl_transaction_paid_amount=ttl_transaction_paid_amount+cal_rs.getDouble(4);
										}
									}catch(Exception ex){
									ex.printStackTrace();			
									}
									balanceAmount=edit_rs.getDouble(6)-(edit_rs.getDouble(7)+ttl_transaction_paid_amount);
									if(balanceAmount<0){
										excessAmount=-balanceAmount;	
										balanceAmount=0;
									}%>	
							<tr>
								<td style="text-align: right;">Total Paid:</td>
								<td><%if(edit && edit_rs!=null){out.print(edit_rs.getDouble(7)+ttl_transaction_paid_amount); }%></td>
								
							</tr>				
							<tr>
								<td style="text-align: right;">Work Status:</td>
								<td>
									<%if(edit && edit_rs!=null && edit_rs.getString(8)!=null){
										out.println(edit_rs.getString(8));
									}
									%>
								</td>
					</tr>					
					
				</table>
			
			
			<%
			}catch(Exception ex){
					ex.printStackTrace();
			} %>
			

</body>
</html>