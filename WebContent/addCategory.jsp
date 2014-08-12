<%@page import="farm.connection.DBfactory"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<!-- <script  src="js/script.js"></script> -->
<!-- <link rel="stylesheet" href="css/style.css"> -->
<link rel="stylesheet" href="Menu_files/style.css">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add New Category</title>
</head>
<script type="text/javascript">
	function showProduct(id){
		window.open("addFertilizer.jsp?cat_id="+id, "ifrmProd");
	}
</script>
<body onload="showProduct(null)">
<%@include file="checkSession.jsp" %>
<%-- <div class="headerbox">
	<%@ include file="home.jsp" %>	
</div>
<%@ include file="menu.jsp" %>
<div class="box"> --%>
			<%
				Connection con = null;
				DBfactory dBfactory = new DBfactory();
				con = dBfactory.DBconnection();
				boolean edit=false;
				String Category_Name=null,vendor=null;
				double price=0;
				int Category_id=0;
				if (null != request.getParameter("sbtEdit") && null != request.getParameter("radCategoryId")) {
					edit=true;
					Category_id =Integer.parseInt(request.getParameter("radCategoryId"));
					/* System.out.print("ok"+edit); */
					//Select current max id
					String qry = "select * from Category where cat_id='"+Category_id+"'";
					Statement st = con.createStatement();
					ResultSet rs = st.executeQuery(qry);
					while (rs.next()) {
						Category_Name = rs.getString(2);						
					}
					st.close();
					rs.close();
				}
			%>
			<!-- <div  style="width: 100%"> -->
			<%-- <h2><%if(!edit){ %>Add New<%}else{%>Edit<%} %> Category</h2> --%>
			<!-- <hr> -->
			<form name="frmNewCategory" method="post">
				<table>
					<tr>
						<td style="text-align: right;">Category Name:</td>
						<td>
							<%if(edit){ %>
							<input type="hidden" name="radCategoryId" id="radCategoryId" value="<%=Category_id%>">
							<%} %>
							<input type="text" required="required" name="txtCategoryName" id="txtCategoryName" <%if(edit){ %>value="<%=Category_Name%>"<%} %>>
						</td>
					</tr>
					
					<tr>
						<td colspan="2" style="text-align: center;">
						     <input type="submit" name="sbtAdd" value="Add" onclick="frmNewCategory.action='action/addCategoryAction.jsp'"  <%if(edit){ %>hidden="true"<% }%>>
							<input type="submit" id="sbtSave" name="sbtSave" value="Save" onclick="frmNewCategory.action='action/addCategoryAction.jsp'" <%if(!edit){ %>hidden="false"<% }%>>
						</td>			
					</tr>
				</table>
			</form>
			<hr>
			<%if(!edit){ %>
			
			<form action="" name="frmShowCategory" method="post">
				<table>
					<tr>
						<td style="text-align: left;">
							<input type="submit" id="sbtEdit" name="sbtEdit" value="Edit" onclick="frmShowCategory.action='addCategory.jsp'">
						</td>
						<td>				
							<input type="submit" name="sbtDelete" value="Delete" onclick="frmShowCategory.action='action/addCategoryAction.jsp'">
						</td>
					</tr>
				</table>				
				<table border=1 cellspacing=0 class="viewTable" style="width: 100%">
					<tr>
						<th>Select</th>
						<th>Sr no.</th>
						<th>Category</th>					
					</tr>
					<%try{
						String selectQry = "select * from Category";
						Statement st1 = con.createStatement();
						ResultSet rs1 = st1.executeQuery(selectQry);
						int cnt=0;
						while (rs1.next()) {
							cnt++;
							%>
							<tr>
								<td>
									<%
										boolean checked=false;
										if(edit){
											if(rs1.getInt(1)==Category_id){
												checked=true;
											}
										}
									%>
									<input type="radio" required="required" name="radCategoryId" value="<%=rs1.getInt(1)%>" onchange="showProduct(this.value)">
								</td>
								<td><%=cnt %></td>
								<td><%=rs1.getString(2) %></td>
								
							</tr>
							<%
						}
						st1.close();
						rs1.close();
						con.close();
					}catch(Exception ex){
						ex.printStackTrace();
					}
					%>
					
				</table>
			</form>
			<%} %>
			<!-- </div>
		</div> -->
	
</body>
</html>
