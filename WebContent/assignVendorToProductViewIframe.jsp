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
		var size=document.getElementById("hdnCnt").value;
		//alert(size +" "+cnt);
		if((document.getElementById("chkProd"+cnt).checked || !document.getElementById("chkProd"+cnt).checked) && size<cnt){
			//alert("disable");
			if(document.getElementById("chkProd"+cnt).checked){
				document.getElementById("selCat"+cnt).disabled=false;
				document.getElementById("selProdName"+cnt).disabled=false;
				document.getElementById("selBrandName"+cnt).disabled=false;
				document.getElementById("txtPrice"+cnt).disabled=false;
				document.getElementById("txtProdDesc"+cnt).disabled=false;
				document.getElementById("txtComment"+cnt).disabled=false;
				document.getElementById("selUnitName"+cnt).disabled=false;
				}else{
					document.getElementById("selCat"+cnt).disabled=true;
					document.getElementById("selProdName"+cnt).disabled=true;
					document.getElementById("selBrandName"+cnt).disabled=true;
					document.getElementById("txtPrice"+cnt).disabled=true;
					document.getElementById("txtProdDesc"+cnt).disabled=true;
					document.getElementById("txtComment"+cnt).disabled=true;
					document.getElementById("selUnitName"+cnt).disabled=false;
				}
		}else{
			//alert("hide");
		//alert(cnt+" "+document.getElementById("selCat0").value);
		if(document.getElementById("chkProd"+cnt).checked){
		document.getElementById("selCat"+cnt).hidden=false;
		document.getElementById("selProdName"+cnt).hidden=false;
		document.getElementById("selBrandName"+cnt).hidden=false;
		document.getElementById("txtPrice"+cnt).hidden=false;
		document.getElementById("txtProdDesc"+cnt).hidden=false;
		document.getElementById("txtComment"+cnt).hidden=false;
		document.getElementById("selUnitName"+cnt).hidden=false;
		
		//<span> Show
		document.getElementById("spanCat"+cnt).hidden=true;
		document.getElementById("spanProdName"+cnt).hidden=true;
		document.getElementById("spanBrandName"+cnt).hidden=true;
		document.getElementById("spanPrice"+cnt).hidden=true;
		document.getElementById("spanProdDesc"+cnt).hidden=true;
		document.getElementById("spanComment"+cnt).hidden=true;
		document.getElementById("spanUnitName"+cnt).hidden=true;
		
		//submit show 
		document.getElementById("sbtEdit"+cnt).hidden=false;
		document.getElementById("sbtDelete"+cnt).hidden=false;
		document.getElementById("thAction"+cnt).hidden=false;
		
		}else{
			document.getElementById("selCat"+cnt).hidden=true;
			document.getElementById("selProdName"+cnt).hidden=true;
			document.getElementById("selBrandName"+cnt).hidden=true;
			document.getElementById("selUnitName"+cnt).hidden=true;
			document.getElementById("txtPrice"+cnt).hidden=true;
			document.getElementById("txtProdDesc"+cnt).hidden=true;
			document.getElementById("txtComment"+cnt).hidden=true;
			
			//<span> hide
			document.getElementById("spanCat"+cnt).hidden=false;
			document.getElementById("spanProdName"+cnt).hidden=false;
			document.getElementById("spanBrandName"+cnt).hidden=false;
			document.getElementById("spanUnitName"+cnt).hidden=false;
			document.getElementById("spanPrice"+cnt).hidden=false;
			document.getElementById("spanProdDesc"+cnt).hidden=false;
			document.getElementById("spanComment"+cnt).hidden=false;
			
			//submit hide 
			document.getElementById("sbtEdit"+cnt).hidden=true;
			document.getElementById("sbtDelete"+cnt).hidden=true;
			document.getElementById("thAction"+cnt).hidden=true;
		}
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
   fifthCell.innerHTML="<input style='width: 110px' type='text' name='txtPrice"+rowCount+"' id='txtPrice"+rowCount+"' disabled='disabled'>";
   
   var sixthCell = row.insertCell(6);  
   sixthCell.innerHTML="<input style='width: 110px' type='text' name='txtProdDesc"+rowCount+"' id='txtProdDesc"+rowCount+"' disabled='disabled'>";
   
   var seventhCell = row.insertCell(7);  
   seventhCell.innerHTML="<input style='width: 110px' type='text' name='txtComment"+rowCount+"' id='txtComment"+rowCount+"' disabled='disabled'>";
   
   var eighthCell = row.insertCell(8);  
   eighthCell.innerHTML="<img name='imgRemove' id='imgRemove' src='images/remove.jpg' height='18' width='20' onclick='deleteRow()'>";
   
   document.getElementById("hdnDynArrCnt").value=rowCount;
   document.getElementById("sbtAdd").hidden=false;
 //  alert(rowCount+" document.getElementById(hdnDynArrCnt).value "+ document.getElementById("hdnDynArrCnt").value);
}
function deleteRow() {
	//alert("hi");
	
	var table = document.getElementById("dataTable");
	var rowCount = table.rows.length;
	rowCount--;
	//alert(rowCount);
	try {
		table.deleteRow(rowCount);
		 alert(rowCount);
		 document.getElementById("hdnDynArrCnt").value=rowCount-1;
		 alert(rowCount+" document.getElementById(hdnDynArrCnt).value "+ document.getElementById("hdnDynArrCnt").value);
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
			<input type="hidden" name="hdnVendorId" id="hdnVendorId" value="<%=vendor_id %>">			
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
					<th id="thAction">Action</th>				
				</tr>
				<% 
				int cnt=0;		
				try{				
					String qry_showAsignProd="select * from assignvendortoprod where vendor_id_fk="+vendor_id;					
					Statement st_showAsignProd=con.createStatement();
					ResultSet rs_showAsignProd=st_showAsignProd.executeQuery(qry_showAsignProd);
					
					while(rs_showAsignProd.next()){						
						
					 cnt++;
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
							<select name="selCat<%=cnt %>" style="width: 110px" id="selCat<%=cnt%>" onchange="showProdByCatId(<%=cnt %>)" hidden="true" required="required">
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
										
										if(rs1.getInt(1)==rs_showAsignProd.getInt(8)){
											cateogry=rs1.getString(2);
											%>
											<option value="<%=rs1.getInt(1)%>" selected="selected"><%=rs1.getString(2)%></option>
											<%	
										}else{
										%>
										<option value="<%=rs1.getInt(1)%>"><%=rs1.getString(2)%></option>
										<%
										}										
									}
								rs1.close();
								st1.close();
							}catch(Exception ex){
								ex.printStackTrace();
							}
								%>
							</select>
							<span id="spanCat<%=cnt%>"><% out.println(cateogry); %></span>
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
						<select name="selProdName<%=cnt%>" style="width: 110px" id="selProdName<%=cnt%>" required="required" hidden="true">
							<option value="">---select---</option>
							<%
								while(rs_prod.next()){
									if(rs_prod.getInt(1)==rs_showAsignProd.getInt(5)){
										product=rs_prod.getString(2);
							%>
								<option value="<%=rs_prod.getInt(1)%>" selected="selected"><%=rs_prod.getString(2)%></option>
							<%
							}else{
							%>
								<option value="<%=rs_prod.getInt(1)%>"><%=rs_prod.getString(2)%></option>
							<%
							}
							}
							%>
						</select>
						<span id="spanProdName<%=cnt%>"><%out.println(product); %></span>
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
						<select name="selBrandName<%=cnt%>" style="width: 110px" id="selBrandName<%=cnt%>" hidden="true" required="required">
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
								if(rs_brand.getInt(1)==rs_showAsignProd.getInt(6)){
									brand=rs_brand.getString(2);
									%>
									<option value="<%=rs_brand.getInt(1)%>" selected="selected"><%=rs_brand.getString(2) %></option>
									<%
								}else{
									%>
									<option value="<%=rs_brand.getInt(1)%>"><%=rs_brand.getString(2) %></option>
									<%
								}
								
							} 								
							%>
						</select>
						<span id="spanBrandName<%=cnt%>"><%out.println(brand); %></span>
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
						<select name="selUnitName<%=cnt%>" id="selUnitName<%=cnt%>" required="required" hidden="true" style="width: 110px">
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
								if(rs_unit.getInt(1)==rs_showAsignProd.getInt(9)){
									unit=rs_unit.getString(2);
									%>
									<option value="<%=rs_unit.getInt(1)%>" selected="selected"><%=rs_unit.getString(2) %></option>
									<%
								}else{
									%>
									<option value="<%=rs_unit.getInt(1)%>"><%=rs_unit.getString(2) %></option>
									<%
								}
								
							} 								
							%>
						</select>
						<span id="spanUnitName<%=cnt%>"><%out.println(unit); %></span>
						<input type="hidden" name="hdnUnitName" id="hdnUnitName" value="<%=unitName%>">
						<input type="hidden" name="hdnUnitValue" id="hdnUnitValue" value="<%=unitValue%>">
						<%}catch(Exception ex){
							ex.printStackTrace();
						}}catch(Exception ex){
							ex.printStackTrace();
						} %>
					</td>
					<td>
						<span id="spanPrice<%=cnt%>"><%=rs_showAsignProd.getDouble(2) %></span>
						<input type="text" style="width: 110px" name="txtPrice<%=cnt %>" id="txtPrice<%=cnt%>" hidden="true" value="<%=rs_showAsignProd.getDouble(2) %>" required="required">
					</td>
					<td>
						<span id="spanProdDesc<%=cnt%>"><%=rs_showAsignProd.getString(3) %></span>
						<input type="text" style="width: 110px" name="txtProdDesc<%=cnt %>" id="txtProdDesc<%=cnt%>" hidden="true" value="<%=rs_showAsignProd.getString(3) %>">
					</td>
					<td>
						<span id="spanComment<%=cnt%>"><%=rs_showAsignProd.getString(4) %></span>
						<input type="text" style="width: 110px" name="txtComment<%=cnt %>" id="txtComment<%=cnt%>" hidden="true" value="<%=rs_showAsignProd.getString(4) %>">
					</td>
					<td>						
						<input style="width: 2px" type="submit" name="sbtEdit<%=cnt %>" id="sbtEdit<%=cnt%>" hidden="true" value="Save" onclick="this.form.action='action/assignVendorToProductAction.jsp?assignProd_Vendor_id=<%=rs_showAsignProd.getInt(1)%>&count=<%= cnt %>'">
						<input style="width: 2px" type="submit" name="sbtDelete<%=cnt %>" id="sbtDelete<%=cnt%>" hidden="true" value="Delete" onclick="this.form.action='action/assignVendorToProductAction.jsp?assignProd_Vendor_id=<%=rs_showAsignProd.getInt(1)%>&count=<%= cnt %>'">
					</td>
				</tr>				
				<%
					}
					}catch(Exception ex){
						ex.printStackTrace();
					}
				%>				
			</table>
			
			<input style="text-align: center;" type="submit" id="sbtAdd" name="sbtInsert" value="Add" onclick="frmAssignVendorToProd.action='action/assignVendorToProductAction.jsp?count=0'" hidden="true">			
			<input type="hidden" name="hdnCnt" id="hdnCnt" value="<%=cnt%>">
			<input type="hidden" name="hdnDynArrCnt" id="hdnDynArrCnt">
		</form>
		<%
	}else{
		%>
<table>
	<tr>
		<td><font style="color: red;"><i> Note : Select Vendor to View Product</i> </font> <br> <br></td>
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