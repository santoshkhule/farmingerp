<%@page import="farm.util.FarmUtility"%>
<%@page import="farm.connection.DBfactory"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
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
//out.println(request.getParameter("assignDate"));
try{
	Connection con=null;
	DBfactory objCon=new DBfactory();
	con=objCon.DBconnection();
	if(null!=request.getParameter("siteId") && !request.getParameter("siteId").equalsIgnoreCase("")
			&& null!=request.getParameter("assignDate") && !request.getParameter("assignDate").equalsIgnoreCase("")){	
		
		int site_id=Integer.parseInt(request.getParameter("siteId"));
		//out.println(request.getParameter("assignDate"));
		String assign_date=request.getParameter("assignDate");
		
		String qry_view_Crop = "select * from CROPSINFIELD where CROP_ID in(select crop_id_fk from assigncroptosite where site_id_fk='"+site_id+"' and date='"+assign_date+"')";
		//out.println(qry_view_Crop);
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(qry_view_Crop);
		
%>
	<select name="selCrop" id="selCrop" onchange="onchangeCallIfrm()">
		<option value="">---select---</option>
		<%
			while (rs.next()) {
			%>
			<option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
			<%			
			}
			st.close();
			rs.close();
		%>		
	</select>
<%
	}else{
		%>
		<select name="selCrop" id="selCrop" onchange="onchangeCallIfrm()">
			<option value="">---select---</option>				
		</select>
		<%
	}
}catch(Exception ex){
	ex.printStackTrace();
}
%>
</body>
</html>