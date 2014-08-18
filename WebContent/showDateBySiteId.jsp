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
	Connection con=null;
	DBfactory objCon=new DBfactory();
	con=objCon.DBconnection();
	
	if(null!=request.getParameter("siteId") && !request.getParameter("siteId").equalsIgnoreCase("")){	
		
		int site_id=Integer.parseInt(request.getParameter("siteId"));
		
		String qry_view_Crop = "select distinct(date) from assigncroptosite where site_id_fk="+site_id;
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(qry_view_Crop);
		
%>
	<select name="selDate" id="selDate" onchange="showCropBySiteIdAndDate()">
		<option value="">---select---</option>
		<%
			while (rs.next()) {
			%>
			<option value="<%=rs.getDate("date")%>"><%=FarmUtility.convertfrom_yymmddToddmmyy(rs.getDate("date").toString())%></option>
			<%			
			}
			st.close();
			rs.close();
		%>		
	</select>
	
<%
	}else{
		%>
		<select name="selDate" id="selDate" onchange="showCropBySiteIdAndDate()">
		<option value="">---select---</option>			
		</select>
		<%
	}

%>
</body>
</html>