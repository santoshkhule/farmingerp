<%@page import="java.util.Date"%>
<%@page import="farm.util.FarmUtility"%>
<%@page import="farm.connection.DBfactory"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="css/jquery-ui.css" />
<script src="js/jquery-1.9.1.js"></script>
<script src="js/jquery-ui.js"></script> 
<title>Assign Crop to site</title>
</head>
<script>
	$(function() {		
		$("#txtDate").datepicker({

			changeMonth : true,
			changeYear : true,
			dateFormat : "dd/mm/yy"
		}).val();

	});
</script>

<body>
	<div class="headerbox">
		<%@ include file="home.jsp"%>
	</div>
	<%@ include file="menu.jsp"%>
	<div class="box">
		<form action="action/assignCropToSiteAction.jsp" method="post">
			<h2>Assign Crop To Site</h2>
			<hr>
			<%
				try {
					Connection con = null;
					Statement st = null;
					try {
						DBfactory dbcon = new DBfactory();
						con = dbcon.DBconnection();
						st = con.createStatement();
					} catch (Exception ex) {
						ex.printStackTrace();
					}
					boolean edit = false;
					int edit_assign_crop_site_id = 0;
					ResultSet edit_rs = null;
					if (request.getParameter("sbtEdit") != null && request.getParameter("radAssignCropSiteId") != null) {
						edit = true;
						edit_assign_crop_site_id = Integer.parseInt(request.getParameter("radAssignCropSiteId"));
						String edit_qry = "Select * from assigncroptosite where assign_crop_site_id="+ edit_assign_crop_site_id;
						//out.print(edit_qry);
						Statement edit_st = con.createStatement();
						edit_rs = edit_st.executeQuery(edit_qry);
						edit_rs.next();
					}
			%>

			<table border=0>
				<tr>
					<td>Site:</td>
					<td><select name="selField" id="selField" required>
							<%
								try {
										String query = "select * from FIELDINFO";
										Statement field_St = con.createStatement();
										ResultSet rs = field_St.executeQuery(query);
										while(rs.next()){
										//Edit operation						
										
										if (edit && edit_rs != null) {
											if(rs.getInt(1)==edit_rs.getInt(3)){											
											%>
											<option value="<%=rs.getInt(1)%>" selected="selected"><%=rs.getString(2)%></option>
											<%
											}else{
												%>
												<option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
												<%	
											}
										} else {
										%>
											<option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
										<%
											}			
									}
										rs.close();
										field_St.close();
								} catch (Exception ex) {
										ex.printStackTrace();
								}
							%>
					</select>
				</td>
				</tr>
				<tr>
					<td style="text-align: right;">Crop:</td>
					<td><select name="selCrop" id="selCrop" multiple="multiple"
						required>
							<%
								try {
										String query = "select * from CROPSINFIELD";
										Statement crop_st = con.createStatement();
										ResultSet rs = crop_st.executeQuery(query);

										//Edit operation						
										String edit_crop_result = null;
										String arr[] = null;
										if (edit && edit_rs != null) {
											String edit_crop_qry = "Select * from assigncroptosite where site_id_fk="+edit_rs.getInt(3)+" and date = '"+edit_rs.getDate(4)+"'";
											Statement edit_crop_St = con.createStatement();
											ResultSet edit_crop_rs = edit_crop_St
													.executeQuery(edit_crop_qry);
											while (edit_crop_rs.next()) {
												if (edit_crop_result != null) {
													edit_crop_result = edit_crop_result + ","
															+ edit_crop_rs.getInt(2);
												} else {
													edit_crop_result = String.valueOf(edit_crop_rs
															.getInt(2));
												}

											}
											System.out.print("edit_crop_result:="
													+ edit_crop_result);
										}
										while (rs.next()) {
											boolean flag = false;
											if (edit && edit_rs != null) {
												if (edit_crop_result != null) {
													arr = edit_crop_result.split(",");
													if (arr != null) {
														for (int i = 0; i < arr.length; i++) {
															if (rs.getInt(1) == Integer
																	.parseInt(arr[i])) {
																flag = true;
															}
														}
													}
												}
											}
											if (flag) {
											%>
											<option value="<%=rs.getInt(1)%>" selected="selected"><%=rs.getString(2)%></option>
											<%
											} else {
											%>
											<option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
											<%
											}
									}
									rs.close();
									crop_st.close();
								} catch (Exception ex) {
								ex.printStackTrace();
								}
							%>
					</select>
				<tr>
				<tr>

					<td style="text-align: right;">Date:</td>
					<td>
						
					 <input type="text" name="txtDate" id="txtDate"
						pattern="(0[1-9]|[12][0-9]|3[01])\/(0[1-9]|1[0-2])\/\d{4}"
						oninvalid="setCustomValidity('Enter Date: Select From Calender')"
						onchange="setCustomValidity('')" title="Enter Date"
						value="<%if (edit && edit_rs != null) {out.print(FarmUtility.convertfrom_yymmddToddmmyy(edit_rs.getDate(4).toString()));
				}%>"
						placeholder="dd/mm/yyyy" required="required"></td>

				</tr>
				<tr>
					<td colspan="8" style="text-align: center;"><br> <%
						if (edit && edit_rs != null) { %>
						<input type="hidden" name="hdnAssignCropSiteId" id="hdnAssignCropSiteId"
						value="<%=edit_assign_crop_site_id%>"> <input
						type="submit" name="sbtSave" id="sbtSave" value="Save">
						 <%	} else {%>
						<input type="submit" name="sbtAdd" id="sbtAdd" value="Add">
						<%
							}
						%>
					</td>
				</tr>
			</table>
		</form>
		<hr>
		
	<%if(!edit){ %>
	<div>
	<form name="frmShowAllCropsAssignTo" method="post">
	<table>
		<tr>
			<td><input type="submit" name="sbtEdit" value="Edit" onclick="this.form.action='assignCropToSite.jsp'"></td>
			<td><input type="submit" name="sbtView" value="View" onclick="this.form.action='assignCropToSite.jsp',target='_blank'"></td>
			<td><input type="submit" name="sbtDelete" value="Delete" onclick="this.form.action='action/assignCropToSiteAction.jsp'"></td>
		</tr>
	</table>
		<table border=1 style="width: 100%" cellSpacing=0>
			<tr>
				<th>Select</th>
				<th>Sr. No.</th>
				<th>Date</th>
				<th>Site</th>
				<th>Crop</th>				
			</tr>
			 <%
			int cnt=0;		
				String query_sel_All_Crop_Site="select * from assigncroptosite";
				Statement stmt_sel_All_Crop_Site=con.createStatement();
				ResultSet rs_sel_All_Crop_Site=stmt_sel_All_Crop_Site.executeQuery(query_sel_All_Crop_Site);
				int site_id=0;
				Date assign_date=null;
				while(rs_sel_All_Crop_Site.next()){					
				if(assign_date!=rs_sel_All_Crop_Site.getDate(4) && site_id!=rs_sel_All_Crop_Site.getInt(3))	{
					cnt++;
					assign_date=rs_sel_All_Crop_Site.getDate(4);
					site_id=rs_sel_All_Crop_Site.getInt(3);
			%>
			<tr>
				<td>
					<input type="radio" name="radAssignCropSiteId" id="radAssignCropSiteId" value="<%=rs_sel_All_Crop_Site.getInt(1)%>" required="required">
				</td>
				<td><%=cnt %></td>
				<td>
					<%=FarmUtility.convertfrom_yymmddToddmmyy(rs_sel_All_Crop_Site.getDate(4).toString()) %>
				</td>
				<td>
									<%
										try{
											String field_qry="Select FIELD_NAME from FIELDINFO where FIELD_ID in(Select site_id_fk from assigncroptosite where assign_crop_site_id="+rs_sel_All_Crop_Site.getInt(1)+")";
											//System.out.print(field_qry);
											Statement field_st=con.createStatement();
											ResultSet field_res=field_st.executeQuery(field_qry);
											String FIELD_NAME=null;
											while(field_res.next()){
												if(FIELD_NAME!=null){
													FIELD_NAME=FIELD_NAME+","+field_res.getString("FIELD_NAME");
												}else{
													FIELD_NAME=field_res.getString("FIELD_NAME");
												}								
											}
											out.print(FIELD_NAME);
											field_res.close();
											field_st.close();
										}catch(Exception ex){
											ex.printStackTrace();
										}
									
									 %>
								</td>
								<td>
									<%
										try{
											String crop_qry="Select CROP_NAME from CROPSINFIELD where CROP_ID in(Select CROP_ID_FK from assigncroptosite where site_id_fk="+rs_sel_All_Crop_Site.getInt(3)+" and date = '"+rs_sel_All_Crop_Site.getDate(4)+"')";
										//	System.out.print(crop_qry);
											Statement crop_st=con.createStatement();
											ResultSet crop_res=crop_st.executeQuery(crop_qry);
											String CROP_NAME=null;
											while(crop_res.next()){								
												if(CROP_NAME!=null){
													CROP_NAME=CROP_NAME+","+crop_res.getString("CROP_NAME");
												}else{
													CROP_NAME=crop_res.getString("CROP_NAME");
												}								
											}
											out.print(CROP_NAME);
											crop_res.close();
											crop_st.close();
										}catch(Exception ex){
											ex.printStackTrace();
										}
									
									 %>
								</td>
			</tr>
			<%}} %>
		</table>
	</form>
	</div>
	<%} %>
	</div>
	<%
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		%>
</body>
</html>