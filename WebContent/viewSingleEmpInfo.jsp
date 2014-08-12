<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Vector"%>
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
<link rel="stylesheet" href="css/style.css">

<title>Employee Information</title>
</head>
<body>

<%-- <div class="headerbox">
	<%@ include file="home.jsp" %>	
</div> --%>

		<%
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
			int emp_id=0;
			ResultSet edit_rs=null;
			if(request.getParameter("sbtView")!=null && request.getParameter("radEmpId")!=null){
				edit=true;
				emp_id=Integer.parseInt(request.getParameter("radEmpId"));
				String edit_qry="Select * from EMPLOYEEINFORMATION where EMP_ID="+emp_id;
				//out.print(edit_qry);
				Statement edit_st=con.createStatement();
				edit_rs=edit_st.executeQuery(edit_qry);
				edit_rs.next();
			}
		%>
			<h2 style="text-align: center;" onclick="window.print()">Employee Information</h2>
			<hr>
			
			<table border=1 style="width: 80%" cellSpacing=0 align="center">
				<tr>
					<td rowspan="4" colspan="2" style="text-align: center;">
									
							<%
								String photo[]=edit_rs.getString(9).split("/");
								String pic=null;							
								pic=photo[photo.length-2]+"/"+photo[photo.length-1];
							
							//out.println(pic);
							%>
						<a href="DownloadFileServlet?fileName=<%=photo[photo.length-1] %>">
							<img src="<%=pic%>" width="135" height="100">
						</a>
					</td>	
					
				</tr>
				<tr>
					<td style="text-align: right;width: 30%;height: 2.2em" >First Name:</td>
					<td style="text-align: left;"><%=edit_rs.getString(2)%></td>
				</tr>
				<tr>
					<td style="text-align: right;height: 2.2em">Middle Name:</td>
					<td style="text-align: left;"><%=edit_rs.getString(3)%></td>
				</tr>
				<tr>
					<td style="text-align: right;height: 2.2em">Last Name:</td>
					<td style="text-align: left;"> <%=edit_rs.getString(4)%></td>			
				</tr>
				
				<tr>
					<td style="text-align: right;width: 20%;height: 2.2em">Contact Number:</td>
					<td style="text-align: left;"><%=edit_rs.getString(5)%></td>
					<td style="text-align: right;">Address:</td>
					<td style="text-align: left;"><%=edit_rs.getString(6)%></td>
					
					
											
				</tr>
				<tr>
					<td style="text-align: right;height: 2.2em">Bank Name:</td>
					<td style="text-align: left;"><%=edit_rs.getString(7)%></td>
					<td style="text-align: right;">Account Number:</td>
					<td style="text-align: left;"><%=edit_rs.getString(8)%></td>
								
				</tr>
				
				<!-- <tr>
					<td colspan="5" style="text-align: center;"><br>
					
						
						<input type="button" name="sbtSave" value="Print" onclick="window.print()">
					
					
					</td>
				</tr> -->
			</table>
			
			
			<%
				con.close();
			%>
		
</body>
</html>