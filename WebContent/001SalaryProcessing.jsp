<%@page import="farm.util.FarmUtility"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="farm.connection.DBfactory"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="Menu_files/style.css">
<!-- <link rel="stylesheet" href="Menu_files/menu.css" type="text/css" media="screen"> -->
<link rel="stylesheet" href="css/jquery-ui.css" />
<script src="js/jquery-1.9.1.js"></script>
<script src="js/jquery-ui.js"></script>
<title>Salary Processing</title>
</head>
<script type="text/javascript">
	function validation(){
		var paymentType=document.getElementById("selPaymentType").value;
		var flag=0;
		if(paymentType==-1){
			alert("Select Payment Type");
		}else{
			flag=1;
		}
		if(flag==0){
			return false;
		}else{
		 	return true;
		}
	}
</script>
<script>
	$(function() {		
		$("#txtDate").datepicker({

			changeMonth : true,
			changeYear : true,
			dateFormat : "dd/mm/yy"
		}).val();

	});
</script>
	
<body>
	<form onsubmit="return validation();">
		<%
	if(session.getAttribute("uname")==null){
	//	out.println(session.getAttribute("uname"));
	
		%>
		<script type="text/javascript">
			window.open("login.jsp", "_parent");
		</script>
		<%
	}
			if (request.getParameter("assignWorkId") != null) {
				try {
					Connection con = null;
					Statement st = null;
					try {
						DBfactory dbcon = new DBfactory();
						con = dbcon.DBconnection();
						st = con.createStatement();
					} catch (Exception ex) {
						ex.printStackTrace();
					}
					int assignWorkId = Integer.parseInt(request.getParameter("assignWorkId"));
					int flag=0;
					if(request.getParameter("flag")!=null){
						flag=Integer.parseInt(request.getParameter("flag"));
						if(flag==1){
						%>
						<script type="text/javascript">
							alert("Employee Salary Process Successfully");
							//alert("1");
							window.open("001ViewEmployeeForSalaryProcess.jsp?assignWorkId=<%=assignWorkId%>", "ifrmViewEmployee");
							//alert("2");
						</script>						
						<%
						}
						if(flag==2){
							%>
							<script type="text/javascript">
								alert("Employee Salary Updated Successfully");
								window.open("001ViewEmployeeForSalaryProcess.jsp?assignWorkId=<%=assignWorkId%>", "ifrmViewEmployee");
							</script>						
							<%
						}
						if(flag==3){
							%>
							<script type="text/javascript">
								alert("Record Deleted Successfully");
								window.open("001ViewEmployeeForSalaryProcess.jsp?assignWorkId=<%=assignWorkId%>", "ifrmViewEmployee");
							</script>						
							<%
						}
						%>
						<%-- <script type="text/javascript">
						alert("1");
							window.open("001ViewEmployeeForSalaryProcess.jsp?assignWorkId="<%=assignWorkId%>, "ifrmViewEmployee");
							alert("2");
						</script> --%>						
						<%
					}
					double ttlPaid=0;					
					//out.println("assignWorkId:=" + assignWorkId);
					String sel_qry = "Select * from ASSIGNWORK where ASSIGNWORK_ID="+ assignWorkId;
					//out.print(edit_qry);
					Statement sel_st = con.createStatement();
					ResultSet sel_rs=sel_st.executeQuery(sel_qry);				
					sel_rs.next();
					boolean edit=false;
					ResultSet edit_trancas_rs=null;
					if(request.getParameter("sbtEdit")!=null && request.getParameter("radEmpSalTrancastionId")!=null){
						edit=true;
						int empSalTransacId=Integer.parseInt(request.getParameter("radEmpSalTrancastionId"));
						String edit_transac_query="select * from EMPSALTRANSACTION where EMPSALTRANSACTIONID ="+empSalTransacId;
						Statement edit_transac_st=con.createStatement();
						edit_trancas_rs=edit_transac_st.executeQuery(edit_transac_query);
						edit_trancas_rs.next();						
					}
					
					//to calculate Paid Amount and Balance Amount
					try{
						String sel_query = "Select * from EMPSALTRANSACTION where ASSIGNWORK_ID_FK='"+assignWorkId+"' order by EMPSALTRANSACTIONID asc";
						Statement cal_st=con.createStatement();
						ResultSet cal_rs=cal_st.executeQuery(sel_query);						
						while(cal_rs.next()){
							ttlPaid=ttlPaid+cal_rs.getDouble(4);
						}
					}catch(Exception ex){
						ex.printStackTrace();
					}
					double balance=0;
					double excess=0;
					balance=sel_rs.getDouble(6)-(sel_rs.getDouble(7)+ttlPaid);
					if(balance<0){
						excess=-balance;
						balance=0;
					}
					
		%>
		<table style="width: 70%" border="1" cellspacing="0" align="center">
			<tr>			
				<td style="text-align: right;">Amount To Pay:</td>
				<td style="text-align: left;"><input type="text" value="<%=sel_rs.getDouble(6)%>" readonly="readonly"></td>
				<td style="text-align: right;">Amount Paid:</td>
				<td style="text-align: left;"><input type="text" value="<%=sel_rs.getDouble(7)+ttlPaid-excess%>" readonly="readonly"></td>
				<td style="text-align: right;">Balance:</td>
				<td style="text-align: left;"><input type="text" value="<%if(balance>=0){out.println(balance);}else{out.print("0");}%>" readonly="readonly" style="text-align: left;"></td>
			</tr>
			<tr>
				<td style="text-align: right;">Payment type:</td>
				<td style="text-align: left;">
					<select name="selPaymentType" id="selPaymentType" required=required>
						<option value="">Select</option>
					<% if(edit && edit_trancas_rs!=null){
						if(edit_trancas_rs.getString(3).equalsIgnoreCase("Cash")){
							%>
							<option value="Cash" selected="selected">Cash</option>
							<option value="Check">Check</option>
							<option value="Other">Other</option>
							<%	
						}else if(edit_trancas_rs.getString(3).equalsIgnoreCase("Check")){
							%>
							<option value="Cash">Cash</option>
							<option value="Check" selected="selected">Check</option>
							<option value="Other">Other</option>
							<%	
						}else if(edit_trancas_rs.getString(3).equalsIgnoreCase("Other")){
							%>
							<option value="Cash">Cash</option>
							<option value="Check">Check</option>
							<option value="Other" selected="selected">Other</option>
							<%	
						}					
					}else{ %>						
						<option value="Cash">Cash</option>
						<option value="Check">Check</option>
						<option value="Other">Other</option>
					<%} %>
					</select>
				</td>
				<td style="text-align: right;">Amount:</td>
				<td style="text-align: left;">
					<input type="text" name="txtAmount" id="txtAmount" value="<%if(edit && edit_trancas_rs!=null){out.print(edit_trancas_rs.getString(4));}else{out.print(0);} %>" required="required" pattern="[0-9]+|[0-9]+\.[0-9]+">
				</td>			
				<td style="text-align: right;">Date:</td>
				<td style="text-align: left;">
					<input type="text" name="txtDate" id="txtDate"	pattern="(0[1-9]|[12][0-9]|3[01])\/(0[1-9]|1[0-2])\/\d{4}"
					oninvalid="setCustomValidity('Enter Date: Select From Calender')" onchange="setCustomValidity('')" title="Enter Date"
					placeholder="dd/mm/yyyy" required="required" value="<%if(edit && edit_trancas_rs!=null){out.print(FarmUtility.convertfrom_yymmddToddmmyy(edit_trancas_rs.getString(8)));} %>"></td>
				
			</tr>
			<tr>
				<td style="text-align: right;">Bank Name:</td>
				<td style="text-align: left;">
					<input type="text" name="txtBankName" id="txtBankName" value="<%if(edit && edit_trancas_rs!=null){out.print(edit_trancas_rs.getString(5));} %>">
				</td>
				<td style="text-align: right;">Account Number:</td>
				<td style="text-align: left;">
					<input type="text" name="txtAccNO" id="txtAccNO" value="<%if(edit && edit_trancas_rs!=null){out.print(edit_trancas_rs.getString(6));}else{out.print(0);} %>">
				</td>
				<td style="text-align: right;">
					Comment:
				</td>
				<td style="text-align: left;">
					<textarea rows="1" cols="20" name="txtComment" id="txtComment" placeholder="Comment If Any"><%if(edit && edit_trancas_rs!=null){out.print(edit_trancas_rs.getString(7));} %></textarea>
				</td>				
			</tr>
			<tr>			
				<td colspan="6" style="text-align: center;">
					<input type="hidden" name="assignWorkId" id="assignWorkId" value="<%=assignWorkId%>">
					<%
						if(edit && edit_trancas_rs!=null){
							%>
							<input type="hidden" name="hdnTransacId" id="hdnTransacId" value="<%=edit_trancas_rs.getString(1)%>">
							<input type="submit" name="sbtUpdateAmount" id="sbtUpdateAmount" value="Update Paid Amount" style="width: 12em" onclick="this.form.action='action/SalaryProcessingAction.jsp'">
							<%
						}else{
					%>
						<input type="submit" name="sbtPayAmount" id="sbtPayAmount" value="Pay Amount" style="width: 10em" onclick="this.form.action='action/SalaryProcessingAction.jsp'">
					<%} %>
				</td>
			</tr>
		</table>
</form>		
<%
	if(!edit && edit_trancas_rs==null){
%>
<hr>
<form>
	<table>
	<tr>
		<td>
			<input type="hidden" name="assignWorkId" id="assignWorkId" value="<%=assignWorkId%>">
			<input type="submit" name="sbtEdit" value="Edit" onclick="this.form.action='001SalaryProcessing.jsp'">
		</td>
		<td><input type="submit" name="sbtDelete" value="Delete" onclick="this.form.action='action/SalaryProcessingAction.jsp'"></td>
	</tr>
	</table>
	<table border="1" cellspacing="0" style="width: 100%">
		
			<tr>
				<th>Select</th>
				<th>Sr. No.</th>
				<th>Payment Type</th>
				<th>Date</th>
				<th>Amount</th>
				<th>Bank Name</th>
				<th>Account Number</th>			
				<th>Comment</th>				
			</tr>
		
		
			<%
			try{
				String sel_query = "Select * from EMPSALTRANSACTION where ASSIGNWORK_ID_FK='"+assignWorkId+"' order by EMPSALTRANSACTIONID asc";
				Statement view_st=con.createStatement();
				ResultSet rs=view_st.executeQuery(sel_query);
				int cnt=0;
				while(rs.next()){
					cnt++;
					int EMPSALTRANSACTIONID=rs.getInt(1);
					//int emp_id=rs.getInt(2);
			%>
			<tr>
				<td>
					<input type="radio" name="radEmpSalTrancastionId" id="radEmpSalTrancastionId" value="<%=EMPSALTRANSACTIONID%>" required="required">
				</td>
				<td><%=cnt %></td>
				<td>
					<%=	rs.getString(3)%>
				</td>
				<td><%if(rs.getString(8)!=null){out.print(FarmUtility.convertfrom_yymmddToddmmyy(rs.getString(8)));}else{out.print("-");} %></td>				
				<td><%if(rs.getString(4)!=null){out.print(rs.getString(4));}else{out.print("-");} %></td> 
				
				<td><%if(rs.getString(5)!=null){out.print(rs.getString(5));}else{out.println("-");}%></td>
				<td><%if(rs.getString(6)!=null){out.print(rs.getString(6));}else{out.println("-");} %></td>
				<td><%if(rs.getString(7)!=null){out.print(rs.getString(7));}else{out.println("-");} %></td>
			</tr>
			<%}
				rs.close();
				con.close();
		}catch(Exception ex){
			ex.printStackTrace();
		}
%>
		
	</table>
	</form>
		<%
	}//if edit
			} catch (Exception ex) {
					ex.printStackTrace();
				}
			}
		%>
	
</body>
</html>