<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<title>Menu</title>
		<!-- Start Developer Santosh Khule HEAD section -->
	<link rel="stylesheet" href="Menu_files/style.css" type="text/css" /><style type="text/css">._css3m{display:none}</style>
	<!-- End Developer Santosh Khule HEAD section -->

	
</head>
<!--#EBEBEB  -->
<body style="background-color:gray;">
<!-- Start Developer Santosh Khule BODY section -->
<ul id="css3menu1" class="topmenu">
<input type="checkbox" id="css3menu-switcher" class="switchbox"><label onclick="" class="switch" for="css3menu-switcher"></label>

	
	<li class="topfirst">
		<a href="#" style="height:18px;line-height:18px;">Configuration</a>
		 <ul>
		
		    <li><a href=" registerUser.jsp">Register User</a></li>
                       <li><a href="siteInformation.jsp">Add/View Site</a></li>                      
					   <li><a href="addNewCrop.jsp">Add/View New Crop</a></li>					   	
					    <li><a href="addFarmingTask.jsp">Add/View Farming Task</a></li>	
					    <li><a href="configureCatSubCatBrand.jsp">Configure Fertilizers</a></li>
          </ul>
	</li>
	<li class="topmenu"><a href="#" style="height:18px;line-height:18px;"><span>Vendors</span></a>
		 <ul>                       
						<!-- <li><a href="addFertilizer.jsp">Add Fertilizer</a></li> -->
						<li><a href="addVendor.jsp">Add Vendor</a></li>	
						<li><a href="assignVendorToProduct.jsp">Assign Vendor To Product</a></li>
						<li><a href="assignVendorToProductView.jsp">View Assign Vendor To Product</a></li>
												
                    </ul>
	</li>
	<li class="topmenu"><a href="#" style="height:18px;line-height:18px;"><span>Employee</span></a>
		 <ul>                       
						<li><a href="addEmpInfo.jsp">Add Employee</a></li>
						<li><a href="viewAllEmployee.jsp">View All Employee</a></li>						
                    </ul>
	</li>
	
	<li class="topmenu"><a href="#" style="height:18px;line-height:18px;"><span>Assign Task</span></a>
		<ul>						
						<li><a href="assignTaskToEmployee.jsp">Assign Task to Employee</a></li>	
						<li><a href="assignTaskToEmployeeViewAll.jsp">View All Employee</a></li>
                    </ul>
	</li>
	<li class="toplast"><a href="01employeeSalaryProcess.jsp" style="height:18px;line-height:18px;">Salary Processing</a>
		
		<ul>
			<li><a href="01employeeSalaryProcess.jsp">Salary Processing</a></li>							
		</ul>		
	</li>
	<li class="topmenu"><a href="addAuthEmployeePerInfo.jsp?user_login_id=<%=session.getAttribute("userid")%>" style="height:18px;line-height:18px;"><span>User Profile</span></a>
	</li>
	<li class="toplast"><a href="logout.jsp" style="height:18px;line-height:18px;">Logout</a></li>
	<!-- <li class="toplast"><a href="logout.jsp" style="height:18px;line-height:18px;">Logout</a></li> -->
</ul>
<!-- End Developer Santosh Khule BODY section -->

</body>
</html>
