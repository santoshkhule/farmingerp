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
<title>site information Action</title>
</head>
<body>
	<%
		try{
			Connection con=null;
			DBfactory objCon=new DBfactory();
			con=objCon.DBconnection();
			if(con!=null){
				if(request.getParameter("sbtAdd")!=null || request.getParameter("sbtSave")!=null){
					String siteName=request.getParameter("txtSiteName");
					double siteArea=Double.parseDouble(request.getParameter("txtArea"));
					String siteLocation=request.getParameter("txtLocation");
					//insert operation
					if(request.getParameter("sbtAdd")!=null){						
						int siteid=1;
						try{
							
							String qry = "select max(FIELD_ID) from FIELDINFO";			
							Statement st=con.createStatement();
							ResultSet rs = st.executeQuery(qry);
							while (rs.next()) {
								siteid = rs.getInt(1);
							}
							rs.close();
						}catch(Exception ex){
							ex.printStackTrace();
						}
						siteid++;
						String insert_qry="insert into FIELDINFO values("+siteid+",'"+siteName+"','"+siteArea+"','"+siteLocation+"')";
						Statement insert_st=con.createStatement();
						insert_st.execute(insert_qry);
						
						//close operation
						insert_st.close();
						
						out.print("<script>");
						out.print("alert(Inserted Successfully);");
						out.print("</script>");
					}
					//update operation
					if(request.getParameter("sbtSave")!=null){						
						int siteid=Integer.parseInt(request.getParameter("hdnSiteId"));
						String update_qry="update FIELDINFO set FIELD_NAME='"+siteName+"',FIELD_AREA='"+siteArea+"',FILELD_LOCATION='"+siteLocation+"' where FIELD_ID="+siteid;
						Statement update_st=con.createStatement();
						update_st.execute(update_qry);
						
						//close operation
						update_st.close();
						
						out.print("<script>");
						out.print("alert(Updated Successfully);");
						out.print("</script>");
					}
				}
				//Delete operation
				if(request.getParameter("sbtDelete")!=null){						
					int siteid=Integer.parseInt(request.getParameter("radSiteId"));
					String delete_qry="delete from FIELDINFO where FIELD_ID="+siteid;
					Statement delete_st=con.createStatement();
					delete_st.execute(delete_qry);
					
					//close operation
					delete_st.close();					
					out.print("<script>");
					out.print("alert(Deleted Successfully);");
					out.print("</script>");
				}
			}	
			con.close();
			out.print("<script>");		
			out.print("window.open('../siteInformation.jsp','_self')");
			out.print("</script>");
		//	response.sendRedirect("../siteInformation.jsp");
		}catch(Exception ex){
			ex.printStackTrace();
		}
	%>
</body>
</html>