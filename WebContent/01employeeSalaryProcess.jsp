<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="css/style.css">
<title>Emplyee Salary Process</title>
</head>
<body>
	<div class="headerbox">
	<%@ include file="home.jsp" %>	
</div>
<%@ include file="menu.jsp" %>
<div class="box">
			<table border="1" cellspacing="0" width="100%">
				<thead>
					<tr>
						<th style="text-align: center;">View All Employee Assign for Work</th>
					</tr>
				</thead>
				<tr>
					<td><iframe src="001ViewEmployeeForSalaryProcess.jsp" name="ifrmViewEmployee" width="100%" height="400px"></iframe></td>
				</tr>
				<thead>
					<tr>
					<th>Salary Processing</th>
				</tr>
				</thead>
				<tr>
					<td><iframe src="001SalaryProcessing.jsp" name="iframSalProcess"  width="100%" height="400px"></iframe></td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>