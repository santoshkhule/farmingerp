<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Vector"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="farm.connection.DBfactory"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="Menu_files/style.css">
<title>Insert title here</title>
</head>
<script type="text/javascript">
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
	function disableEnableTextBox(cnt){
		//alert(cnt+" "+document.getElementById("selCat0").value);
		if(document.getElementById("chkProd"+cnt).checked){
		document.getElementById("selCat"+cnt).disabled=false;
		document.getElementById("selProdName"+cnt).disabled=false;
		document.getElementById("selBrandName"+cnt).disabled=false;
		document.getElementById("selUnitName"+cnt).disabled=false;
		document.getElementById("txtPrice"+cnt).disabled=false;
		document.getElementById("txtProdDesc"+cnt).disabled=false;
		document.getElementById("txtComment"+cnt).disabled=false;
		}else{
			document.getElementById("selCat"+cnt).disabled=true;
			document.getElementById("selProdName"+cnt).disabled=true;
			document.getElementById("selBrandName"+cnt).disabled=true;
			document.getElementById("selUnitName"+cnt).disabled=true;
			document.getElementById("txtPrice"+cnt).disabled=true;
			document.getElementById("txtProdDesc"+cnt).disabled=true;
			document.getElementById("txtComment"+cnt).disabled=true;
		}
	}
</script>
<script type="text/javascript">
function addRow(tableID) {	
   var table = document.getElementById(tableID);
   var rowCount = table.rows.length;
  
   var row = table.insertRow(rowCount);
   var firstCell = row.insertCell(0);  
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
   secondCell.innerHTML="<select style='width: 110px' name='selCat"+rowCount+"' id='selCat"+rowCount+"' onchange='showProdByCatId("+rowCount+")' disabled='disabled'>"+option+"</select>";
   
   var thirdCell = row.insertCell(2);  
   thirdCell.innerHTML="<div id='divProdName"+rowCount+"'><select style='width: 110px' name='selProdName"+rowCount+"' id='selProdName"+rowCount+"' disabled='disabled'><option>---select---</option></select></div>";
   
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
   fourthCell.innerHTML="<select style='width: 110px' name='selBrandName"+rowCount+"' id='selBrandName"+rowCount+"' disabled='disabled'>"+option+"</select>";
   
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
  // alert(option);
   fourthCell1.innerHTML="<select style='width: 110px' name='selUnitName"+rowCount+"' id='selUnitName"+rowCount+"' disabled='disabled'>"+option+"</select>";
   
   //alert(rowCount);
   var fifthCell = row.insertCell(5);  
   fifthCell.innerHTML="<input type='text' style='width: 110px' name='txtPrice"+rowCount+"' id='txtPrice"+rowCount+"' disabled='disabled'>";
   
   var sixthCell = row.insertCell(6);  
   sixthCell.innerHTML="<input type='text' style='width: 110px' name='txtProdDesc"+rowCount+"' id='txtProdDesc"+rowCount+"' disabled='disabled'>";
   
   var seventhCell = row.insertCell(7);  
   seventhCell.innerHTML="<input type='text' style='width: 110px' name='txtComment"+rowCount+"' id='txtComment"+rowCount+"' disabled='disabled'>";
   
   var eighthCell = row.insertCell(8);  
   eighthCell.innerHTML="<img name='imgRemove' id='imgRemove' src='images/remove.jpg' height='18' width='20' onclick='deleteRow()'>";
   
}
function deleteRow() {
	//alert("hi");
	
	var table = document.getElementById("dataTable");
	var rowCount = table.rows.length;
	rowCount--;
	//alert(rowCount);
	try {
		table.deleteRow(rowCount);		
	}catch(e) {
		alert(e);
	}
}
</script>
<body>
<%
try{
	//out.println("vendor_id:=>>"+request.getParameter("vendor_id"));
	 if(null!=request.getParameter("vendor_id") && !request.getParameter("vendor_id").equals("") 
			/* && null!=request.getParameter("cat_id") && !request.getParameter("cat_id").equals("") */){
		int vendor_id=Integer.parseInt(request.getParameter("vendor_id"));
		
		Connection con = null;
		DBfactory dBfactory = new DBfactory();
		con = dBfactory.DBconnection();
		
		//out.println("vendor_id:=>>"+request.getParameter("vendor_id") +"  cat_id:=>"+request.getParameter("cat_id") );
		%>
		<form name="frmAssignVendorToProd" method="post">
			<input type="submit" id="sbtAdd" name="sbtAdd" value="Add" onclick="frmAssignVendorToProd.action='action/assignVendorToProductAction.jsp'">
			<input type="hidden" name="hdnVendorId" id="hdnVendorId" value="<%=vendor_id %>">
			<!-- <input type="button" value="Add Row" onclick="addRow('dataTable')" /> -->
			<table border="1" id="dataTable" cellspacing="0" style="width: 100%">
				<tr>
					<th>Select</th>
					<th>Category</th>
					<th>Product</th>
					<th>Brand</th>
					<th>Unit</th>
					<th>Price</th>
					<th>Product Description</th>
					<th>Comment <img name="imgAdd" id="imgAdd" src="images/add.jpg" height="18" width="20" onclick="addRow('dataTable')"></th>				
				</tr>
				<% 
				int cnt=1;		
				try{
					
					
					
				 /* 	String qry_prod="select fertilizer_id,fertilizer_name from fertilizer where cat_id="+cat_id; 
					String qry_prod="select fertilizer_id,fertilizer_name from fertilizer";
					Statement st_prod=con.createStatement();
					ResultSet rs_prod=st_prod.executeQuery(qry_prod);
					Vector vec_prod=new Vector();
					while(rs_prod.next()){
						//cnt++;
						vec_prod.add(rs_prod.getString(1));
						vec_prod.add(rs_prod.getString(2));
					}  */
				%>
				<tr>
				
					<td><input type="checkbox" name="chkProd" id="chkProd<%=cnt%>" value="<%=cnt%>" required="required" onclick="disableEnableTextBox(this.value)">
					</td>
					
						<td>
						<%
						String categoryName=null,categoryValue=null;
						try{
							String selectQry = "select * from category";
							Statement st1 = con.createStatement();
							ResultSet rs1 = st1.executeQuery(selectQry);							
						%>
							<select style='width: 110px' name="selCat<%=cnt %>" id="selCat<%=cnt%>" onchange="showProdByCatId(<%=cnt %>)" disabled="disabled" required="required">
								<option value="">---Select---</option>
								<%
								
									while (rs1.next()) {
										%>
										<option value="<%=rs1.getInt(1)%>"><%=rs1.getString(2)%></option>
										<%
										if(categoryName!=null){
											categoryName=categoryName+","+rs1.getString(2);
											categoryValue=categoryValue+","+rs1.getString(1);
										}else{
											categoryName=rs1.getString(2);
											categoryValue=rs1.getString(1);
										}
										
									}
								rs1.close();
								st1.close();
							}catch(Exception ex){
								ex.printStackTrace();
							}
								%>
							</select>
							<input type="hidden" name="hdnCatName" id="hdnCatName" value="<%=categoryName%>">
							<input type="hidden" name="hdnCatValue" id="hdnCatValue" value="<%=categoryValue%>">
						</td>	
					<td>						
						<div id="divProdName<%=cnt%>">
							<select name="selProdName<%=cnt%>" id="selProdName<%=cnt%>" disabled="disabled" required="required">
								<option value="">---select---</option>								
							</select>
						</div>
					</td>
					<td>	
					<%
						try{
							String brandName=null,brandValue=null;
							String qry_brand="select * from brand";
							Statement st_brand=con.createStatement();
							ResultSet rs_brand=st_brand.executeQuery(qry_brand);										
							try{
					%>					
						<select style='width: 110px' name="selBrandName<%=cnt%>" id="selBrandName<%=cnt%>" disabled="disabled" required="required">
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
								%>
								<option value="<%=rs_brand.getInt(1)%>"><%=rs_brand.getString(2) %></option>
								<%
							} 								
							%>
						</select>
						<input type="hidden" name="hdnBrandName" id="hdnBrandName" value="<%=brandName%>">
						<input type="hidden" name="hdnBrandValue" id="hdnBrandValue" value="<%=brandValue%>">
						<%}catch(Exception ex){
							
						}}catch(Exception ex){
							
						} %>
					</td>
					<td>	
					<%
						try{
							String unitName=null,unitValue=null;
							String qry_unit="select * from units";
							Statement st_unit=con.createStatement();
							ResultSet rs_unit=st_unit.executeQuery(qry_unit);										
							try{
					%>					
						<select style='width: 110px' name="selUnitName<%=cnt%>" id="selUnitName<%=cnt%>" disabled="disabled" required="required">
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
								%>
								<option value="<%=rs_unit.getInt(1)%>"><%=rs_unit.getString(2) %></option>
								<%
							} 								
							%>
						</select>
						<input type="hidden" name="hdnUnitName" id="hdnUnitName" value="<%=unitName%>">
						<input type="hidden" name="hdnUnitValue" id="hdnUnitValue" value="<%=unitValue%>">
						<%}catch(Exception ex){
							
						}}catch(Exception ex){
							
						} %>
					</td>
					<td><input style='width: 110px' type="text" name="txtPrice<%=cnt %>" id="txtPrice<%=cnt%>" value="" disabled="disabled" required="required">
					</td>
					<td><input style='width: 110px' type="text" name="txtProdDesc<%=cnt %>" id="txtProdDesc<%=cnt%>" value="" disabled="disabled">
					</td>
					<td><input style='width: 110px' type="text" name="txtComment<%=cnt %>" id="txtComment<%=cnt%>" value="" disabled="disabled">
					</td>
				</tr>				
				<%
					
					}catch(Exception ex){
						ex.printStackTrace();
					}
				%>
				
			</table>
			<input type="hidden" name="hdnCnt" id="hdnCnt" value="<%=cnt%>">
		</form>
		<%
	}else{
		%>
<table>
	<tr>
		<td><font style="color: red;"><i> Note : Select Vendor to Assign Product</i> </font> <br> <br></td>
	</tr>
</table>
		<%
	}
}catch(Exception ex){
	ex.printStackTrace();
}
%>
</body>
</html>