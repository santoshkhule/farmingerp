<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="farm.connection.DBfactory"%>
<%@page import="java.sql.Connection"%>
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
	try{
		Connection con = null;
		DBfactory dBfactory = new DBfactory();
		con = dBfactory.DBconnection();
		int cnt=0;
		cnt=Integer.parseInt(request.getParameter("count"));
		if(null!=request.getParameter("catId") && !request.getParameter("catId").equalsIgnoreCase("")){
		int catId=Integer.parseInt(request.getParameter("catId"));
		String qry_prod="select fertilizer_id,fertilizer_name from fertilizer where cat_id="+catId; 
		/* String qry_prod="select fertilizer_id,fertilizer_name from fertilizer"; */
		Statement st_prod=con.createStatement();
		ResultSet rs_prod=st_prod.executeQuery(qry_prod);
		
			
			
		 
%>
	<select name="selProdName<%=cnt%>" id="selProdName<%=cnt%>" required="required">
		<option value="">---select---</option>
		<%while(rs_prod.next()){
			%>
			<option value="<%=rs_prod.getInt(1)%>"><%=rs_prod.getString(2)%></option>
			<%
		} %>
	</select>

<%
		}else{ %>
<select name="selProdName<%=cnt%>" id="selProdName<%=cnt%>"	disabled="disabled" required="required">
	<option value="">---select---</option>		
</select>
<%
}
	}catch(Exception ex){
	ex.printStackTrace();
} %>
</body>
</html>