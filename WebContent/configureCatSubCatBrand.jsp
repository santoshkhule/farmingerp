<%@page import="farm.connection.DBfactory"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<!-- <script  src="js/script.js"></script> -->
<link rel="stylesheet" href="css/style.css">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add New Category</title>
</head>
<body>
<div class="headerbox">
	<%@ include file="home.jsp" %>	
</div>
<%@ include file="menu.jsp" %>
<div class="box">
			
			<div  style="width: 100%">
			<h2>Configuration</h2>
			<!-- <form action="" name="frmShowCategory" method="post"> -->
							
				<table border=1 cellspacing=0 class="viewTable" style="width: 100%">
					<tr>
						<th>Category</th>
						<th>Product</th>
						<th>Brand</th>					
					</tr>
					<tr>
						<td><iframe name="ifrmCat" src="addCategory.jsp" width="100%" height="400"></iframe></td>
						<td><iframe name="ifrmProd" src="addFertilizer.jsp" width="100%" height="400"></iframe></td>
						<td><iframe name="ifrmBrand" src="addBrand.jsp" width="100%" height="400"></iframe></td>					
					</tr>
				</table>
			<!-- </form> -->
			
			</div>
		</div>
	
</body>
</html>
