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
<link rel="stylesheet" href="Menu_files/style.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="css/jquery-ui.css" />
<script src="js/jquery-1.9.1.js"></script>
<script src="js/jquery-ui.js"></script> 
<title>Insert title here</title>
</head>
<script>
	$(function() {	
		//alert("hi");
		$("#txtDate").datepicker({
			changeMonth : true,
			changeYear : true,
			dateFormat : "dd/mm/yy"
		}).val();

	});
	
</script>

<script type="text/javascript">
function addRow(tableID) {	
   var table = document.getElementById(tableID);
   var rowCount = table.rows.length;
  // alert(tableID+" "+rowCount);
   var row = table.insertRow(rowCount);
  // alert(rowCount);
   var firstCell = row.insertCell(0);
   if(tableID=='dataTable'){
   var option="";
   var empName=document.getElementById("hdnEmpName").value;  
   var empId=document.getElementById("hdnEmpId").value;  
   var arrEmpName=empName.split(",");
   var arrEmpValue=empId.split(",");
   for(var i=0;i<arrEmpName.length;i++){		 
	   if(option!=""){
		   option=option+"<option value='"+arrEmpValue[i]+"'>"+arrEmpName[i]+"</option>";
	   }else{
		   option="<option value=''>---select---</option><option value='"+arrEmpValue[i]+"'>"+arrEmpName[i]+"</option>";
	   } 
   }
   firstCell.innerHTML="<select style='width: 100px' name='selEmpName"+rowCount+"' id='selEmpName"+rowCount+"' required>"+option+"</select>";
   
   var secondCell = row.insertCell(1);	   
   secondCell.innerHTML="<input type='text' name='txtDate"+rowCount+"' id='txtDate"+rowCount+"' oninvalid='setCustomValidity(Enter Date: Select From Calender)' onchange='setCustomValidity('')' title='Enter Date' style='width: 100px' pattern='(0[1-9]|[12][0-9]|3[01])\/(0[1-9]|1[0-2])\/\d{4}' placeholder='dd/mm/yyyy' required='required'>";
   
   var thirdCell = row.insertCell(2);
   var option="";
   var workName=document.getElementById("hdnWorkName").value;  
   var workId=document.getElementById("hdnWorkId").value;  
   var arrWorkName=workName.split(",");
   var arrworkId=workId.split(",");
   for(var i=0;i<arrWorkName.length;i++){
	   if(option!=""){
		   option=option+"<option value='"+arrworkId[i]+"'>"+arrWorkName[i]+"</option>";
	   }else{
		   option="<option value=''>---select---</option><option value='"+arrworkId[i]+"'>"+arrWorkName[i]+"</option>";
	   } 
   }
   thirdCell.innerHTML="<select style='width: 100px' name='selWork"+rowCount+"' id='selWork"+rowCount+"' required>"+option+"</select>";
   
   var fourthCell = row.insertCell(3);
   var option="<option value=''>---select---</option><option value='Contract'>Contract</option>";
  option=option+"<option value='Per Day Payment'>Per Day Payment</option>";
   fourthCell.innerHTML="<select style='width: 100px' name='selWorkType"+rowCount+"' id='selWorkType"+rowCount+"'>"+option+"</select>";
   
   var fifthCell = row.insertCell(4);
   fifthCell.innerHTML="<input type='text' name='txtAmount"+rowCount+"' id='txtAmount"+rowCount+"' value=0 required='required'>";
      
   var sixthCell = row.insertCell(5);  
   sixthCell.innerHTML="<input type='text' name='txtAdvPayment"+rowCount+"' id='txtAdvPayment"+rowCount+"' value=0 required='required'>";
   
   var seventhCell = row.insertCell(6);  
   var option="";
   option="<option value=''>---select---</option><option value='Completed'>Completed</option><option value='Pending'>Pending</option>";
   option=option+"<option value='Reject'>Reject</option>";
   seventhCell.innerHTML="<select style='width: 100px' name='selWorkStatus"+rowCount+"' id='selWorkStatus"+rowCount+"' required>"+option+"</select>"; 
  
   var eighthCell = row.insertCell(7);  
   eighthCell.innerHTML="<textarea name='txtComment"+rowCount+"' id='txtComment"+rowCount+"' cols='25' rows='1'></textarea>";
   
   var ninethCell = row.insertCell(8);  
   ninethCell.innerHTML="<img name='imgRemove' id='imgRemove' src='images/remove.jpg' height='18' width='20' onclick='deleteRow()'>";
   
   $(function() {	
		//alert("hi");
		$("#txtDate"+rowCount).datepicker({
			changeMonth : true,
			changeYear : true,
			dateFormat : "dd/mm/yy"
		}).val();

	});
   }else if(tableID=="dataTable1"){
	   
	   /* Code Dynamic Rows for Vendor */
	   var option="";
	   var vendorName=document.getElementById("hdnVendorName").value;  
	   var vendorId=document.getElementById("hdnVendorId").value;  
	   var arrVendorName=vendorName.split(",");
	   var arrVendorId=vendorId.split(",");
	   for(var i=0;i<arrVendorName.length;i++){		 
		   if(option!=""){
			   option=option+"<option value='"+arrVendorId[i]+"'>"+arrVendorName[i]+"</option>";
		   }else{
			   option="<option value=''>---select---</option><option value='"+arrVendorId[i]+"'>"+arrVendorName[i]+"</option>";
		   } 
	   }
	   //alert(option);
	   firstCell.style="text-align: left";
	   
	   firstCell.innerHTML="Vendor Name:<select name='selVendor"+rowCount+"' id='selVendor"+rowCount+"' onChange='showProdByVendorId("+rowCount+")' required>"+option+"</select><img name='imgRemove' id='imgRemove' src='images/remove.jpg' height='18' width='20' onclick='deleteRow("+tableID+")'>";
	  
	   var row = table.insertRow(rowCount+1);			
	   var firstCell = row.insertCell(0);   
	   firstCell.innerHTML="<div id='showProd"+rowCount+"'></div>";
	   
   }else if(tableID=="dataTable2"){
	   
	   /* Code Dynamic Rows for Home Products */
	   
	   firstCell.innerHTML="<input type='checkbox' name='chkProd' id='chkProd"+rowCount+"' value="+rowCount+" onclick=disableEnableTextBox(this.value)>";
	   
	   var secondCell = row.insertCell(1);
	   var option="";
	   var catName=document.getElementById("hdnCatName").value;  
	   var catValue=document.getElementById("hdnCatValue").value;  
	   var arrCatName=catName.split(",");
	   var arrCatValue=catValue.split(",");
	   for(var i=0;i<arrCatName.length;i++){
		 //  alert(arrCatValue[i]+"<=> "+arrCatName[i]);
		   if(option!=""){
			   option=option+"<option value='"+arrCatValue[i]+"'>"+arrCatName[i]+"</option>";
		   }else{
			   option="<option value=''>---select---</option><option value='"+arrCatValue[i]+"'>"+arrCatName[i]+"</option>";
		   } 
	   }
	   secondCell.innerHTML="<select style='width: 110px' name='selCat"+rowCount+"' id='selCat"+rowCount+"' onchange='showProdByCatId("+rowCount+")' >"+option+"</select>";
	   
	   var thirdCell = row.insertCell(2);  
	   thirdCell.innerHTML="<div id='divProdName"+rowCount+"'><select style='width: 110px' name='selProdName"+rowCount+"' id='selProdName"+rowCount+"' ><option>---select---</option></select></div>";
	   
	   var fourthCell = row.insertCell(3);
	   var option="";
	   var brandName=document.getElementById("hdnBrandName").value;  
	   var brandValue=document.getElementById("hdnBrandValue").value;  
	   var arrBrandName=brandName.split(",");
	   var arrBrandValue=brandValue.split(",");
	   for(var i=0;i<arrBrandName.length;i++){
		 //  alert(arrCatValue[i]+"<=> "+arrCatName[i]);
		   if(option!=""){
			   option=option+"<option value='"+arrBrandValue[i]+"'>"+arrBrandName[i]+"</option>";
		   }else{
			   option="<option value=''>---select---</option><option value='"+arrBrandValue[i]+"'>"+arrBrandName[i]+"</option>";
		   } 
	   }
	  // alert(option);
	   fourthCell.innerHTML="<select style='width: 110px' name='selBrandName"+rowCount+"' id='selBrandName"+rowCount+"' >"+option+"</select>";
	   
	   var fourthCell1 = row.insertCell(4);
	   var option="";
	   var unitName=document.getElementById("hdnUnitName").value;  
	   var unitValue=document.getElementById("hdnUnitValue").value;  
	   var arrUnitName=unitName.split(",");
	   var arrUnitValue=unitValue.split(",");
	   for(var i=0;i<arrUnitName.length;i++){
		 //  alert(arrCatValue[i]+"<=> "+arrCatName[i]);
		   if(option!=""){
			   option=option+"<option value='"+arrUnitValue[i]+"'>"+arrUnitName[i]+"</option>";
		   }else{
			   option="<option value=''>---select---</option><option value='"+arrUnitValue[i]+"'>"+arrUnitName[i]+"</option>";
		   } 
	   }
	  
	   fourthCell1.innerHTML="<select style='width: 110px' name='selUnitName"+rowCount+"' id='selUnitName"+rowCount+"' >"+option+"</select>"; 
	   
	   var fifthCell = row.insertCell(5);  
	   fifthCell.innerHTML="<input style='width: 110px' type='text' name='txtPrice"+rowCount+"' id='txtPrice"+rowCount+"' >";
	   
	   var sixthCell = row.insertCell(6);  
	   sixthCell.innerHTML="<input style='width: 110px' type='text' name='txtProdDesc"+rowCount+"' id='txtProdDesc"+rowCount+"' >";
	   
	   var seventhCell = row.insertCell(7);  
	   seventhCell.innerHTML="<input style='width: 110px' type='text' name='txtComment"+rowCount+"' id='txtComment"+rowCount+"' >";
	   
	   var eighthCell = row.insertCell(8);  
	   eighthCell.innerHTML="<img name='imgRemove' id='imgRemove' src='images/remove.jpg' height='18' width='20' onclick='deleteRow("+tableID+")'>";
   }	   
}
/* Function To delete Dynamic Generated rows */
function deleteRow(tableID) {	
	var table = document.getElementById(tableID.id);
	var rowCount = table.rows.length;
	rowCount--;	
	try {
		table.deleteRow(rowCount);		
	}catch(e) {
		alert(e);
	}
}
</script>
<script type="text/javascript">
	function showProdByVendorId(cnt) {
		//alert(cnt);
		var vendor_id = document.getElementById("selVendor"+cnt).value;
		//alert(catId);
		if (window.XMLHttpRequest) {
			xmlhttp = new XMLHttpRequest();
		} else {
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				//alert(xmlhttp.responseText);
				document.getElementById("showProd"+cnt).innerHTML = xmlhttp.responseText;				
			}
		};
		var url ="03showProductByVendorId.jsp?vendor_id="+vendor_id+"&count="+cnt;
		xmlhttp.open("GET", url, true);
		xmlhttp.send();
	}
	function showProdByCatId(cnt) {
		//alert(cnt);
		var catId = document.getElementById("selCat"+cnt).value;
		//alert(catId);
		if (window.XMLHttpRequest) {
			xmlhttp = new XMLHttpRequest();
		} else {
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				//alert("divProdName"+cnt+"  ==> divProdName2");
				document.getElementById("divProdName"+cnt).innerHTML = xmlhttp.responseText;				
			}
		};
		var url ="showProductByCatId.jsp?catId="+catId+"&count="+cnt;
		xmlhttp.open("GET", url, true);
		xmlhttp.send();
	}
</script>
<body>
<%@include file="checkSession.jsp" %>
<%
	if(null!=request.getParameter("siteId")&& null!=request.getParameter("cropId")&& null!=request.getParameter("assignDate")
			&& !request.getParameter("siteId").equalsIgnoreCase("") && !request.getParameter("cropId").equalsIgnoreCase("") && !request.getParameter("assignDate").equalsIgnoreCase("")){
		Connection con=null;
		Statement st=null;
		try{
			DBfactory dbcon=new DBfactory();
			con=dbcon.DBconnection();
			st=con.createStatement();
		}catch(Exception ex){
			ex.printStackTrace();
		}
		String siteId=request.getParameter("siteId");
		String cropId=request.getParameter("cropId");
		String assignDate=request.getParameter("assignDate");
		boolean edit=false;
		ResultSet edit_rs=null;
		//out.println(siteId+" "+cropId+" "+assignDate);
%>
<fieldset>
	<legend class="legend">Employee information</legend>
	<table border="1" cellspacing="0" id="dataTable" width="100%">
		<tr>
			<th>Name</th>
			<th>Date</th>
			<th>Work</th>
			<th>Type of Work</th>
			<th>Amount</th>
			<th>Advance Payment</th>
			<th>Work Status</th>
			<th>Comment<img name="imgAdd" id="imgAdd" src="images/add.jpg" height="18" width="20" onclick="addRow('dataTable')"></th>
		</tr>
		<tr>
			<td>
			<%
				int cnt=1;
				String empName=null,empId=null;
			%>
				<select name="selEmpName<%=cnt %>" id="selEmpName<%=cnt %>" required=required style="width: 100px">
					<option value="">---select---</option>
					<%
					try{						
						String query="select * from EMPLOYEEINFORMATION";	
						Statement emp_St=con.createStatement();
						ResultSet emp_rs=emp_St.executeQuery(query);
						while(emp_rs.next()){
							if(empName!=null){
								empName=empName+","+emp_rs.getString(2);
							}else{
								empName=emp_rs.getString(2);
							}
							
							if(empId!=null){
								empId=empId+","+emp_rs.getString(1);
							}else{
								empId=emp_rs.getString(1);
							}
							
							if(edit && edit_rs!=null){
								if(edit_rs.getInt(2)==emp_rs.getInt(1)){
								%>					
									<option value="<%=emp_rs.getInt(1)%>" selected="selected"><%out.println(emp_rs.getString(2)+" "+emp_rs.getString(3)+" "+emp_rs.getString(4) ); %></option>
								<%
								}else{
							%>					
								<option value="<%=emp_rs.getInt(1)%>"><%out.println(emp_rs.getString(2)+" "+emp_rs.getString(3)+" "+emp_rs.getString(4) ); %> </option>
							<%	
								}
							}else{
						%>					
							<option value="<%=emp_rs.getInt(1)%>"><%out.println(emp_rs.getString(2)+" "+emp_rs.getString(3)+" "+emp_rs.getString(4) ); %></option>
						<%
							}
						}
						emp_rs.close();
						emp_St.close();
					}catch(Exception ex){
						ex.printStackTrace();
					}					
					%>
				</select>
				<input type="hidden" id="hdnEmpName" name="hdnEmpName" value="<%=empName%>">
				<input type="hidden" id="hdnEmpId" name="hdnEmpId" value="<%=empId%>">
			</td>
			<td>				
				<input type="text" name="txtDate<%=cnt %>" id="txtDate" style="width: 100px" pattern="(0[1-9]|[12][0-9]|3[01])\/(0[1-9]|1[0-2])\/\d{4}"
					oninvalid="setCustomValidity('Enter Date: Select From Calender')" onchange="setCustomValidity('')" title="Enter Date"
					value="<%if(edit && edit_rs!=null){out.print(FarmUtility.convertfrom_yymmddToddmmyy(edit_rs.getString(3)));} %>" 
					placeholder="dd/mm/yyyy" required="required">				
					
			</td>
			<td>
				<select name="selWork<%=cnt %>" id="selWork<%=cnt %>" style="width: 100px">
					<option value="">---select---</option>
					<%
						String workName=null,workId=null;
						try{
						String work_query="select * from WORKTYPE";	
						Statement work_st=con.createStatement();
						ResultSet work_rs=work_st.executeQuery(work_query);
						
						//Edit operation						
						String edit_work_result=null;
						String arr[]=null;
						int edit_Assign_Work_id=0;
						if(edit){
							String edit_work_qry="select * from EMPASSIGNWORK where ASSIGNWORK_ID_FK="+edit_Assign_Work_id;	
							Statement edit_work_St=con.createStatement();
							ResultSet edit_work_rs=edit_work_St.executeQuery(edit_work_qry);
							 while(edit_work_rs.next()){
								 if(edit_work_result!=null){
									 edit_work_result=edit_work_result+","+edit_work_rs.getInt(2);
								}else{
									edit_work_result=String.valueOf(edit_work_rs.getInt(2));
								}	
								
							} 
							 System.out.print("edit_work_result:="+edit_work_result);
						} 
						
						while(work_rs.next()){
							if(workName!=null){
								workName=workName+","+work_rs.getString(2);
							}else{
								workName=work_rs.getString(2);;
							}
							if(workId!=null){
								workId=workId+","+work_rs.getString(1);
							}else{
								workId=work_rs.getString(1);
							}
							boolean flag=false;
							 if(edit && edit_rs!=null && edit_work_result!=null){
								arr=edit_work_result.split(",");
								if(arr!=null){
									for(int i=0;i<arr.length;i++){
										if(work_rs.getInt(1)==Integer.parseInt(arr[i])){
											flag=true;
										}
									}
								}
							} 
							if(flag){
								%>
								<option value="<%=work_rs.getInt(1)%>" selected="selected"><%=work_rs.getString(2)%></option>
								<%
							}else{
								%>
								<option value="<%=work_rs.getInt(1)%>"><%=work_rs.getString(2)%></option>
								<%
							}
						}
						work_rs.close();
						work_st.close();						
						}catch(Exception ex){
							ex.printStackTrace();
						}
					%>
				</select>
				<input type="hidden" name="hdnWorkName" id="hdnWorkName" value="<%=workName%>">
				<input type="hidden" name="hdnWorkId" id="hdnWorkId" value="<%=workId%>">
			</td>	
			<td>				
				<select name="selWorkType<%=cnt %>" id="selWorkType<%=cnt %>" required style="width: 100px">
					<option value=" ">---select---</option>
					 <%if(edit){
						if(edit_rs.getString(5).equalsIgnoreCase("Contract")){
					%>					
					<option value="Contract" selected="selected">Contract</option>	
					<option value="Per Day Payment">Per Day Payment</option>
					<%				
					}else if(edit_rs.getString(5).equalsIgnoreCase("Per Day Payment")){
					%>					
					<option value="Contract">Contract</option>	
					<option value="Per Day Payment" selected="selected">Per Day Payment</option>
					<%
					}else{%>					
					<option value="Contract">Contract</option>	
					<option value="Per Day Payment">Per Day Payment</option>
					<%} 
					}else{%>					
					<option value="Contract">Contract</option>	
					<option value="Per Day Payment">Per Day Payment</option>
				<%} %>			
				</select>
			</td>
			<td>
				<input type="text" name="txtAmount<%=cnt %>" id="txtAmount<%=cnt %>" value="<%if(edit && edit_rs!=null){out.print(edit_rs.getString(6)); }else{out.print(0);}%>">
			</td>
			<td>
				<input type="text" name="txtAdvPayment<%=cnt %>" id="txtAdvPayment<%=cnt %>" value="<%if(edit && edit_rs!=null){out.print(edit_rs.getString(7)); }else{out.print(0);}%>">
			</td>
			<td>
				<select name="selWorkStatus<%=cnt %>" id="selWorkStatus<%=cnt %>" style="width: 100px">
					<option value="">---select---</option>
					<%if(edit && edit_rs!=null && edit_rs.getString(8)!=null){
						if(edit_rs.getString(8).equalsIgnoreCase("Completed")){
							%>
						<option value="Completed" selected="selected">Completed</option>
						<option value="Pending">Pending</option>
						<option value="Reject">Reject</option>
							<%
						}else if(edit_rs.getString(8).equalsIgnoreCase("Pending")){
							%>
							<option value="Completed">Completed</option>
							<option value="Pending" selected="selected">Pending</option>
							<option value="Reject">Reject</option>
								<%
						}else if(edit_rs.getString(8).equalsIgnoreCase("Reject")){
							%>
							<option value="Completed">Completed</option>
							<option value="Pending">Pending</option>
							<option value="Reject" selected="selected">Reject</option>
								<%
						}
					}else{	%>				
						<option value="Completed">Completed</option>
						<option value="Pending">Pending</option>
						<option value="Reject">Reject</option>
					<%} %>
				</select>
			</td>
			<td>
				<textarea name="txtComment<%=cnt %>" id="txtComment<%=cnt %>" cols="25" rows="1"></textarea>
			</td>
			
		</tr>
	</table>
</fieldset>	
<!--  --><fieldset>
	<legend class="legend">Vendor Information</legend>
	<table width="100%" id="dataTable1" border="0">
		<tr>
			<td style="text-align: left;">Vendor Name:
				<%
				String vendorName=null,vendorId=null;
				try{
				String selectQry = "select * from Vendor";				
				Statement st1 = con.createStatement();
				ResultSet rs1 = st1.executeQuery(selectQry);
				%>
				<select name="selVendor<%=cnt %>" id="selVendor<%=cnt %>" onchange="showProdByVendorId(<%=cnt %>)">
				<option value="">---Select---</option>
				<%
					while (rs1.next()) {
						if(vendorName!=null){
							vendorName=vendorName+","+rs1.getString(2);
							vendorId=vendorId+","+rs1.getString(1);
						}else{
							vendorName=rs1.getString(2);
							vendorId=rs1.getString(1);							
						}
						%>
						<option value="<%=rs1.getInt(1)%>"><%=rs1.getString(2)%></option>
						<%
					}
				rs1.close();
				st1.close();
				}catch(Exception ex){
					ex.printStackTrace();
				}
				%>
				</select>
				<img name="imgAdd" id="imgAdd" src="images/add.jpg" height="18" width="20" onclick="addRow('dataTable1')" title="addVendor">
				<input type="hidden" id="hdnVendorName" name="hdnVendorName" value="<%=vendorName%>">
				<input type="hidden" id="hdnVendorId" name="hdnVendorId" value="<%=vendorId%>">
			</td>
		</tr>
		<tr>
			<td>
				<div id="showProd<%=cnt%>"></div>
			</td>
		</tr>					
	</table>
</fieldset>	
<fieldset>
	<legend class="legend">Home Products</legend>
		<table border="1" id="dataTable2" cellspacing="0" style="width: 100%">
				<tr>
					<th>Select</th>
					<th>Category</th>
					<th>Product</th>
					<th>Brand</th>
					<th>Unit</th>
					<th>Price</th>
					<th>Product Description</th>
					<th>Comment <img name="imgAdd" id="imgAdd" src="images/add.jpg" height="18" width="20" onclick="addRow('dataTable2')"></th>
					<!-- <th id="thAction">Action</th> -->				
				</tr>
				<% 
				//int cnt=0;		
				try{				
					/* String qry_showAsignProd="select * from assignvendortoprod where vendor_id_fk="+vendor_id;					
					Statement st_showAsignProd=con.createStatement();
					ResultSet rs_showAsignProd=st_showAsignProd.executeQuery(qry_showAsignProd);
					
					while(rs_showAsignProd.next()){						
						
					 cnt++; */
				%>
				<tr>				
					<td><input type="checkbox" name="chkProd" id="chkProd<%=cnt%>" value="<%=cnt%>" onclick="disableEnableTextBox(this.value)">
					</td>					
						<td>
						<%
						String categoryName=null,categoryValue=null;
						String cateogry=null;
						try{
							String selectQry = "select * from category";
							Statement st1 = con.createStatement();
							ResultSet rs1 = st1.executeQuery(selectQry);							
						%>
							<select name="selCat<%=cnt %>" style="width: 110px" id="selCat<%=cnt%>" onchange="showProdByCatId(<%=cnt %>)" required="required">
								<option value="">---Select---</option>
								<%
								
									while (rs1.next()) {
										if(categoryName!=null){
											categoryName=categoryName+","+rs1.getString(2);
											categoryValue=categoryValue+","+rs1.getString(1);
										}else{
											categoryName=rs1.getString(2);
											categoryValue=rs1.getString(1);
										}
										
										/*if(rs1.getInt(1)==rs_showAsignProd.getInt(8)){
											cateogry=rs1.getString(2);
											%>
											<option value="<%=rs1.getInt(1)%>" selected="selected"><%=rs1.getString(2)%></option>
											<%	
										}else{*/
										%>
										<option value="<%=rs1.getInt(1)%>"><%=rs1.getString(2)%></option>
										<%
										//}										
									}
								rs1.close();
								st1.close();
							}catch(Exception ex){
								ex.printStackTrace();
							}
								%>
							</select>
							<%-- <span id="spanCat<%=cnt%>"><% out.println(cateogry); %></span> --%>
							<input type="hidden" name="hdnCatName" id="hdnCatName" value="<%=categoryName%>">
							<input type="hidden" name="hdnCatValue" id="hdnCatValue" value="<%=categoryValue%>">
						</td>	
					<td>						
						<div id="divProdName<%=cnt%>">
							<%
							String product=null;
							String qry_prod="select fertilizer_id,fertilizer_name from fertilizer";
							Statement st_prod=con.createStatement();
							ResultSet rs_prod=st_prod.executeQuery(qry_prod);								 
							%>
						<select name="selProdName<%=cnt%>" style="width: 110px" id="selProdName<%=cnt%>" required="required" >
							<option value="">---select---</option>
							<%
								while(rs_prod.next()){
									/*if(rs_prod.getInt(1)==rs_showAsignProd.getInt(5)){
										product=rs_prod.getString(2);
							%>
								<option value="<%=rs_prod.getInt(1)%>" selected="selected"><%=rs_prod.getString(2)%></option>
							<%
							}else{*/
							%>
								<option value="<%=rs_prod.getInt(1)%>"><%=rs_prod.getString(2)%></option>
							<%
							//}
							}
							%>
						</select>
						<%-- <span id="spanProdName<%=cnt%>"><%out.println(product); %></span> --%>
						</div>						
					</td>
					<td>	
					<%
						try{
							String brandName=null,brandValue=null;
							String qry_brand="select * from brand";
							Statement st_brand=con.createStatement();
							String brand=null;
							ResultSet rs_brand=st_brand.executeQuery(qry_brand);										
							try{
					%>					
						<select name="selBrandName<%=cnt%>" style="width: 110px" id="selBrandName<%=cnt%>"  required="required">
							<option value="">---select---</option>
							<%
							
							while(rs_brand.next()){
								if(brandName!=null){
									brandName=brandName+","+rs_brand.getString(2);
									brandValue=brandValue+","+rs_brand.getString(1);
								}else{
									brandName=rs_brand.getString(2);
									brandValue=rs_brand.getString(1);
								}
							/*	if(rs_brand.getInt(1)==rs_showAsignProd.getInt(6)){
									brand=rs_brand.getString(2);
									%>
									<option value="<%=rs_brand.getInt(1)%>" selected="selected"><%=rs_brand.getString(2) %></option>
									<%
								}else{*/
									%>
									<option value="<%=rs_brand.getInt(1)%>"><%=rs_brand.getString(2) %></option>
									<%
								//}
								
							} 								
							%>
						</select>
						<%-- <span id="spanBrandName<%=cnt%>"><%out.println(brand); %></span> --%>
						<input type="hidden" name="hdnBrandName" id="hdnBrandName" value="<%=brandName%>">
						<input type="hidden" name="hdnBrandValue" id="hdnBrandValue" value="<%=brandValue%>">
						<%}catch(Exception ex){
							ex.printStackTrace();	
						}}catch(Exception ex){
							ex.printStackTrace();
						} %>
					</td>
					<td>	
					<%
						try{
							String unitName=null,unitValue=null,unit=null;
							String qry_unit="select * from units";
							Statement st_unit=con.createStatement();
							ResultSet rs_unit=st_unit.executeQuery(qry_unit);										
							try{
					%>					
						<select name="selUnitName<%=cnt%>" id="selUnitName<%=cnt%>" required="required"  style="width: 110px">
							<option value="">---select---</option>
							<%
							while(rs_unit.next()){
								if(unitName!=null){
									unitName=unitName+","+rs_unit.getString(2);
									unitValue=unitValue+","+rs_unit.getString(1);
								}else{
									unitName=rs_unit.getString(2);
									unitValue=rs_unit.getString(1);
								}
								/*if(rs_unit.getInt(1)==rs_showAsignProd.getInt(9)){
									unit=rs_unit.getString(2);
									%>
									<option value="<%=rs_unit.getInt(1)%>" selected="selected"><%=rs_unit.getString(2) %></option>
									<%
								}else{*/
									%>
									<option value="<%=rs_unit.getInt(1)%>"><%=rs_unit.getString(2) %></option>
									<%
								//}
								
							} 								
							%>
						</select>
						<%-- <span id="spanUnitName<%=cnt%>"><%out.println(unit); %></span> --%>
						<input type="hidden" name="hdnUnitName" id="hdnUnitName" value="<%=unitName%>">
						<input type="hidden" name="hdnUnitValue" id="hdnUnitValue" value="<%=unitValue%>">
						<%}catch(Exception ex){
							ex.printStackTrace();
						}}catch(Exception ex){
							ex.printStackTrace();
						} %>
					</td>
					<td>
						<%-- <span id="spanPrice<%=cnt%>"><%=rs_showAsignProd.getDouble(2) %></span> --%>
						<input type="text" style="width: 110px" name="txtPrice<%=cnt %>" id="txtPrice<%=cnt%>"  value="" required="required">
					</td>
					<td>
						<%-- <span id="spanProdDesc<%=cnt%>"><%=rs_showAsignProd.getString(3) %></span> --%>
						<input type="text" style="width: 110px" name="txtProdDesc<%=cnt %>" id="txtProdDesc<%=cnt%>"  value="">
					</td>
					<td>
						<%-- <span id="spanComment<%=cnt%>"><%=rs_showAsignProd.getString(4) %></span> --%>
						<input type="text" style="width: 110px" name="txtComment<%=cnt %>" id="txtComment<%=cnt%>"  value="">
					</td>
					<%-- <td>						
						<input style="width: 2px" type="submit" name="sbtEdit<%=cnt %>" id="sbtEdit<%=cnt%>" hidden="true" value="Save" onclick="this.form.action='action/assignVendorToProductAction.jsp?assignProd_Vendor_id=<%=rs_showAsignProd.getInt(1)%>&count=<%= cnt %>'">
						<input style="width: 2px" type="submit" name="sbtDelete<%=cnt %>" id="sbtDelete<%=cnt%>" hidden="true" value="Delete" onclick="this.form.action='action/assignVendorToProductAction.jsp?assignProd_Vendor_id=<%=rs_showAsignProd.getInt(1)%>&count=<%= cnt %>'">
					</td> --%>
				</tr>				
				<%
					//}
					}catch(Exception ex){
						ex.printStackTrace();
					}
				%>				
			</table>
</fieldset>			
<%
	}else{
		%>
		<table>
			<tr>
				<td><font style="color: red;"><i> Note : Select Crop to Assign Resources</i> </font> <br> <br></td>
			</tr>
		</table>
<%
	}

%>

</body>
</html>