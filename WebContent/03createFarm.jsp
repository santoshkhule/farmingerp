<%@page import="java.sql.ResultSet"%>
<%@page import="farm.connection.DBfactory"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html >
<html>
<script src="js/logout.js"></script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create Farm</title>
<script type="text/javascript">
	function showCropBySiteIdAndDate() {	
		var siteId=document.getElementById("selSite").value;
		var assignDate=document.getElementById("selDate").value;
		if (window.XMLHttpRequest) {
			xmlhttp = new XMLHttpRequest();
		} else {
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				//alert("divProdName"+cnt+"  ==> divProdName2");
				document.getElementById("divCrop").innerHTML = xmlhttp.responseText;				
			}
		};
		var url ="showCropBySiteIdAndDate.jsp?siteId="+siteId+"&assignDate="+assignDate;
		xmlhttp.open("GET", url, true);
		xmlhttp.send();
	}
	
	function showDateBySiteId() {	
		//alert("hi");
		var siteId=document.getElementById("selSite").value;
		document.getElementById("selCrop").innerHTML="<option value=''>---select---</option>";
		
		if (window.XMLHttpRequest) {
			xmlhttp = new XMLHttpRequest();
		} else {
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				//alert("divProdName"+cnt+"  ==> divProdName2");
				document.getElementById("divDate").innerHTML = xmlhttp.responseText;				
			}
		};
		var url ="showDateBySiteId.jsp?siteId="+siteId;
		xmlhttp.open("GET", url, true);
		xmlhttp.send();
	}
	function onchangeCallIfrm(){
		var siteId=document.getElementById("selSite").value;
		var cropId=document.getElementById("selCrop").value;
		var assignDate=document.getElementById("selDate").value;
		
		window.open("03assignResources.jsp?siteId="+siteId+"&cropId="+cropId+"&assignDate="+assignDate,"ifrmAssignResrc");
	}
</script>
</head>
<body>
<div class="headerbox">
	<%@ include file="home.jsp" %>	
</div>
<%@ include file="menu.jsp" %>
<div class="box">
<%
	try{
	Connection con=null;
	DBfactory objCon=new DBfactory();
	con=objCon.DBconnection();	
%>
<table>
		<tr>
			<td>Select Site:</td>
			
		<%
		
			String view_query="select * from FIELDINFO order by FIELD_ID asc";
			Statement view_st=con.createStatement();
			ResultSet view_rs=view_st.executeQuery(view_query);
			int cnt=0;
			
			
		%>		
			<td>
				<select name="selSite" id="selSite" onchange="showDateBySiteId()">
					<option value="">---select---</option>
					<%
					try{
					while(view_rs.next()){
						%>
							<option value="<%=view_rs.getString(1) %>"><%=view_rs.getString(2) %></option>
						<%
					}
					}catch(Exception ex){
						ex.printStackTrace();
					}
					%>
				</select>
			</td>
			<td>Date:</td>		
			<td>
				<div id="divDate">
					<select name="selDate" id="selDate" onchange="showCropBySiteIdAndDate()">
						<option value="">---select---</option>				
					</select>
				</div>
			</td>		
			<td>Select Crop:</td>		
			<td>
				<div id="divCrop">
					<select name="selCrop" id="selCrop" onchange="onchangeCallIfrm()">
						<option value="">---select---</option>				
					</select>
				</div>
			</td>
						
		</tr>		
	</table>
	<iframe name="ifrmAssignResrc" width="100%" height="440px" src="03assignResources.jsp"></iframe>
<%
}catch(Exception ex){
	ex.printStackTrace();
}
%>

</div>
</body>
</html>