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
<!-- <link rel="stylesheet" href="css/style.css"> -->
<title>Site information</title>
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
	boolean edit=false;
	int siteId=0;
	ResultSet edit_rs=null;
	if(request.getParameter("sbtEdit")!=null){
		edit=true;
		siteId=Integer.parseInt(request.getParameter("radSiteId"));
		String edit_qry="Select * from FIELDINFO where FIELD_ID="+siteId;
		//out.print(edit_qry);
		Statement edit_st=con.createStatement();
		edit_rs=edit_st.executeQuery(edit_qry);
		edit_rs.next();
	}
%>
	<%-- <%
out.print("session:="+session.getAttribute("uname").toString());
%>
<input type="button" value="Logout" name="btnLogout" id="btnLogout" onclick="logout();" >
welcome to my world........ --%>
<form action="action/siteInformationAction.jsp">
	<h2>Site information</h2>
	<hr>
	<table>
		<tr>
			<td style="text-align: right;">Site Name:</td>
			<td><input type="text" required="required" name="txtSiteName" id="txtSiteName" value="<%if(edit && edit_rs!=null){out.print(edit_rs.getString(2));} %>"></td>
		</tr>
		<tr>
			<td style="text-align: right;">Site Area:</td>
			<td><input type="text" required="required" name="txtArea" id="txtArea" value="<%if(edit && edit_rs!=null){out.print(edit_rs.getString(3));} %>" placeholder=" in acres" pattern="[0-9]+|[0-9]+\.[0-9]+"></td>
		</tr>
		<tr>
			<td style="text-align: right;">Site Location:</td>
			<td><input type="text" required="required" name="txtLocation" id="txtLocation" value="<%if(edit && edit_rs!=null){out.print(edit_rs.getString(4));} %>"></td>
		</tr>
		<tr>
		
			<td colspan="2" style="text-align: center;">
			<%if(edit && edit_rs!=null){
				 %>
				 
				 <input type="hidden" name="hdnSiteId" id="hdnSiteId" value="<%=edit_rs.getInt(1)%>">
					<input type="submit" name="sbtSave" id="sbtSave" value="Save">
				<%
			}else{ %>
				<input type="submit" name="sbtAdd" id="sbtAdd" value="Add">
			<%} %>
			</td>
		</tr>
	</table>
</form>

<hr>
<%if(!edit && edit_rs==null){%>
<form>
	<table>
		<tr>
			<td><input type="submit" name="sbtEdit" value="Edit" onclick="this.form.action='siteInformation.jsp'"></td>
			<td><input type="submit" name="sbtDelete" value="Delete" onclick="this.form.action='action/siteInformationAction.jsp'"></td>
		</tr>
	</table>
	<table border="1" cellspacing="0" style="width: 100%">
		<tr>
			<th>Select</th>
			<th>Sr.no.</th>
			<th>Site Name</th>
			<th>Site Area</th>
			<th>Site Location</th>			
		</tr>
		<%
			String view_query="select * from FIELDINFO order by FIELD_ID asc";
			Statement view_st=con.createStatement();
			ResultSet view_rs=view_st.executeQuery(view_query);
			int cnt=0;
			while(view_rs.next()){
				cnt++;
		%>
		<tr>
			<td><input type="radio" name="radSiteId" id="radSiteId" value="<%=view_rs.getInt(1)%>"></td>
			<td><%=cnt %></td>
			<td><%=view_rs.getString(2) %></td>
			<td><%=view_rs.getString(3) %></td>
			<td><%=view_rs.getString(4) %></td>
		</tr>
		<%} %>
	</table>
</form>
<%}}catch(Exception ex){
	ex.printStackTrace();
} %>
</div>
</div>
</body>
</html>