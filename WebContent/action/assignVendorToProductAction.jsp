<%@page import="farm.connection.DBfactory"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Actions Perform Process</title>
</head>
<body>
<%
int vendor_id=0,cat_id=1;
try{
		Connection con = null;
		DBfactory dBfactory = new DBfactory();
		con = dBfactory.DBconnection();
		
		String arr[]=null;
		String comment=null,prod_desc=null;
		int cnt=0,prod_id=0,brand_id=0,unit_id=0;
		double price=0;
		int assignProd_Vendor_id=0;
		arr=request.getParameterValues("chkProd");			
		cnt=Integer.parseInt(request.getParameter("hdnCnt"));
		vendor_id=Integer.parseInt(request.getParameter("hdnVendorId"));
		if(null!=request.getParameter("sbtAdd")){
			for(int i=0;i<arr.length;i++){
				cat_id=Integer.parseInt(request.getParameter("selCat"+arr[i]));
				prod_id=Integer.parseInt(request.getParameter("selProdName"+arr[i]));
				brand_id=Integer.parseInt(request.getParameter("selBrandName"+arr[i]));
				unit_id=Integer.parseInt(request.getParameter("selUnitName"+arr[i]));
				price=Double.parseDouble(request.getParameter("txtPrice"+arr[i]));			
				prod_desc=request.getParameter("txtProdDesc"+arr[i]);
				comment=request.getParameter("txtComment"+arr[i]);
				/* out.println(prod_id+" "+brand_id+" "+vendor_id+" "+comment+" "+prod_desc+"\n");
				out.println("arr.length:=>>>"+arr.length); */
				String query = "insert into assignvendortoprod(cat_id_fk,price,prod_desc,comment,prod_id_fk,brand_id_fk,vendor_id_fk,unit_id_fk) values("+cat_id+"," +price + ",'" +prod_desc + "','" +comment + "'," +prod_id + "," +brand_id + "," +vendor_id + ","+unit_id+")";
				
				System.out.println("query:=>>>"+query);
				Statement stmt = con.createStatement();
				stmt.execute(query);
				stmt.close();
			}
		}		
		if(null!=request.getParameter("sbtInsert")){
			int dynArrCount=Integer.parseInt(request.getParameter("hdnDynArrCnt"));
			for(int i=cnt+1;i<=dynArrCount;i++){
				
				cat_id=Integer.parseInt(request.getParameter("selCat"+i));
				prod_id=Integer.parseInt(request.getParameter("selProdName"+i));
				brand_id=Integer.parseInt(request.getParameter("selBrandName"+i));
				unit_id=Integer.parseInt(request.getParameter("selUnitName"+i));
				price=Double.parseDouble(request.getParameter("txtPrice"+i));			
				prod_desc=request.getParameter("txtProdDesc"+i);
				comment=request.getParameter("txtComment"+i);
				
				String query = "insert into assignvendortoprod(cat_id_fk,price,prod_desc,comment,prod_id_fk,brand_id_fk,vendor_id_fk,unit_id_fk) values("+cat_id+"," +price + ",'" +prod_desc + "','" +comment + "'," +prod_id + "," +brand_id + "," +vendor_id + ","+unit_id+")";
				
				System.out.println("query:=>>>"+query);
				Statement stmt = con.createStatement();
				stmt.execute(query);
				stmt.close();
			}
		}
		
		int count=0;
		count=Integer.parseInt(request.getParameter("count"));
		if(null!=request.getParameter("sbtEdit"+count) || null!=request.getParameter("sbtDelete"+count)){			
			assignProd_Vendor_id=Integer.parseInt(request.getParameter("assignProd_Vendor_id"));		
			if(null!=request.getParameter("sbtEdit"+count)){			
				cat_id=Integer.parseInt(request.getParameter("selCat"+count));
				prod_id=Integer.parseInt(request.getParameter("selProdName"+count));
				brand_id=Integer.parseInt(request.getParameter("selBrandName"+count));
				unit_id=Integer.parseInt(request.getParameter("selUnitName"+count));
				price=Double.parseDouble(request.getParameter("txtPrice"+count));			
				prod_desc=request.getParameter("txtProdDesc"+count);
				comment=request.getParameter("txtComment"+count);
				
				String query = "update assignvendortoprod set cat_id_fk="+cat_id+",price="+price+",prod_desc='"+prod_desc+"',comment='"+comment+"',prod_id_fk="+prod_id+",brand_id_fk="+brand_id+",vendor_id_fk="+vendor_id+",unit_id_fk="+unit_id+" where ass_vend_prod_id="+assignProd_Vendor_id;
					
				System.out.println("query:=>>>"+query);
				Statement stmt = con.createStatement();
				stmt.execute(query);
				stmt.close();
			}
			if(null!=request.getParameter("sbtDelete"+count)){
				
				String query = "delete from assignvendortoprod where ass_vend_prod_id="+assignProd_Vendor_id;			
				
				System.out.println("query:=>>>"+query);
				Statement stmt = con.createStatement();
				stmt.execute(query);
				stmt.close();
			}
		}
		con.close();
}catch(Exception ex){
	ex.printStackTrace();
}
	response.sendRedirect("../assignVendorToProductViewIframe.jsp?vendor_id="+vendor_id+"&cat_id="+cat_id);
		
	
%>
</body>
</html>