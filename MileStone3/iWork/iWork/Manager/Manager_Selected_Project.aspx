﻿<%@ Page Language="C#" Inherits="iWork.Manager.Profile.templates.Manager_Selected_Project" EnableEventValidation="false" %>

<!DOCTYPE html>
<html lang="en">
  <head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>iWork | DashBoard </title>

    <!-- Bootstrap -->
    <link href="../Style/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="../Style/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="../Style/vendors/nprogress/nprogress.css" rel="stylesheet">
    <!-- iCheck -->
    <link href="../Style/vendors/iCheck/skins/flat/green.css" rel="stylesheet">

    <!-- Custom Theme Style -->
    <link href="../Style/build/css/custom.min.css" rel="stylesheet">

     <!-- bootstrap-daterangepicker -->
    <link href="../Style/vendors/bootstrap-daterangepicker/daterangepicker.css" rel="stylesheet">
    <!-- bootstrap-datetimepicker -->
    <link href="../Style/vendors/bootstrap-datetimepicker/build/css/bootstrap-datetimepicker.css" rel="stylesheet">
    <!-- Ion.RangeSlider -->
    <link href="../Style/vendors/normalize-css/normalize.css" rel="stylesheet">
    <link href="../Style/vendors/ion.rangeSlider/css/ion.rangeSlider.css" rel="stylesheet">
    <link href="../Style/vendors/ion.rangeSlider/css/ion.rangeSlider.skinFlat.css" rel="stylesheet">
    <!-- Bootstrap Colorpicker -->
    <link href="../Style/vendors/mjolnic-bootstrap-colorpicker/dist/css/bootstrap-colorpicker.min.css" rel="stylesheet">

    <link href="../Style/vendors/cropper/dist/cropper.min.css" rel="stylesheet">
  </head>

  <body class="nav-md">
    <form id="ProjectsForm" runat="server">
    <div class="container body">
      <div class="main_container">
        <div class="col-md-3 left_col">
          <div class="left_col scroll-view">
            <div class="navbar nav_title" style="border: 0;">
              <a href="index.html" class="site_title"><i class="fa fa-paw"></i> <span>iWork!</span></a>
            </div>

            <div class="clearfix"></div>

            <!-- menu profile quick info -->
            <div class="profile clearfix">
              <div class="profile_pic">
                <img src="images/img.jpg" alt="..." class="img-circle profile_img">
              </div>
              <div class="profile_info">
                <span>Welcome,</span>
                <h2><asp:Label runat="server" id="usernameLbl"></asp:Label></h2> 
              </div>
            </div>
            <!-- /menu profile quick info -->

            <br />

            <!-- sidebar menu -->
            <div id="sidebar-menu" class="main_menu_side hidden-print main_menu">
              <div class="menu_section">
                <h3>General</h3>
                <ul class="nav side-menu">
                  <li><a><i class="fa fa-home"></i> Home <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="../Default.aspx">Main</a></li>
                        <li><a href="Manager.aspx">Profile</a></li>												
                    </ul>
                  </li>
                </ul>
              </div>
              <div class="menu_section">
                <h3>[Managers Only]</h3>
                <ul class="nav side-menu">

                  <li><a><i class="fa fa-check-square"></i> Requests <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="Manager_Requests.aspx">View Requests</a></li>
                      <li><a href="Manager_Requests_Review.aspx">Review Requests</a></li>
                    </ul>
                  </li>

                  <li><a><i class="fa fa-pencil"></i> Applications <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                        <li><a href="Manager_Applications.aspx">Review Applications</a></li>
                    </ul>
                  </li>                     
                                        
                  <li><a><i class="fa fa-laptop"></i> Projects & Tasks <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="Manager_Projects.aspx">Projects</a></li>
                      <li><a href="Manager_Selected_Project.aspx">Project Details</a></li>
                      <li><a href="Manager_Selected_Task.aspx">Task Details</a></li>
                    </ul>
                  </li>

                </ul>
              </div>

            </div>
            <!-- /sidebar menu -->

            <!-- /menu footer buttons -->
            <div class="sidebar-footer hidden-small">
              <a data-toggle="tooltip" data-placement="top" title="Settings">
                <span class="glyphicon glyphicon-cog" aria-hidden="true"></span>
              </a>
              <a data-toggle="tooltip" data-placement="top" title="FullScreen">
                <span class="glyphicon glyphicon-fullscreen" aria-hidden="true"></span>
              </a>
              <a data-toggle="tooltip" data-placement="top" title="Lock">
                <span class="glyphicon glyphicon-eye-close" aria-hidden="true"></span>
              </a>
              <a data-toggle="tooltip" data-placement="top" title="Logout" href="login.html">
                <span class="glyphicon glyphicon-off" aria-hidden="true"></span>
              </a>
            </div>
            <!-- /menu footer buttons -->
          </div>
        </div>

        <!-- top navigation -->
        <div class="top_nav">
          <div class="nav_menu">
            <nav>
              <div class="nav toggle">
                <a id="menu_toggle"><i class="fa fa-bars"></i></a>
              </div>

              <ul class="nav navbar-nav navbar-right">
                <li class="">
                  <a href="javascript:;" class="user-profile dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                    <img src="images/img.jpg" alt="">Amr Kayid
                    <span class=" fa fa-angle-down"></span>
                  </a>
                  <ul class="dropdown-menu dropdown-usermenu pull-right">
                    <li><a href="javascript:;"> Profile</a></li>
                    <li>
                      <a href="javascript:;">
                        <span class="badge bg-red pull-right">50%</span>
                        <span>Settings</span>
                      </a>
                    </li>
                    <li><a href="javascript:;">Help</a></li>
                    <li><a href="login.html"><i class="fa fa-sign-out pull-right"></i> Log Out</a></li>
                  </ul>
                </li>

             </ul>
            </nav>
          </div>
        </div>
        <!-- /top navigation -->

        <!-- page content -->
        <div class="right_col" role="main">
          <div class="">
            <div class="page-title">
              <div class="title_left">
                <h3>Projects <small>Dashboard</small></h3>
              </div>

              <div class="title_right">
                <div class="col-md-5 col-sm-5 col-xs-12 form-group pull-right top_search">
                  <div class="input-group">
                    <input type="text" class="form-control" placeholder="Search for...">
                    <span class="input-group-btn">
                      <button class="btn btn-default" type="button">Go!</button>
                    </span>
                  </div>
                </div>
              </div>
            </div>

            <div class="clearfix"></div>

            <div class="row">
              <div class="col-md-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>Projects</h2>

                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">

                    <p>Projects you have created</p>

                    <!-- start project list -->

				<!--Assign regular employees-->
                 <div>
                <asp:GridView ID="RegEmpView" runat="server" AutoGenerateColumns="false" CssClass="table table-striped table-bordered table-hover" EmptyDataText="There are no data records to display.">
                    <Columns>
                        <asp:BoundField DataField="username" HeaderText="username" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg"/>
                        <asp:BoundField DataField="Projects" HeaderText="# of Projects" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg"/>

                        <asp:TemplateField HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg">
                            <ItemTemplate>
                                <asp:Button runat="server" id="AddToProject" CommandArgument='<%# Container.DataItemIndex %>' OnCommand="AddToProject_Clicked" Text="Add" type="submit" class="btn btn-success"></asp:Button>
                            </ItemTemplate>
                        </asp:TemplateField>
                      
                    </Columns>
                </asp:GridView>
             </div>

             <!--Delete regular employees-->
			<div class="row">
              <div class="col-md-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>Project's Employees</h2>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">

                    <p>Regular Employees in This Project</p>
			<div>
                <asp:GridView ID="DeleteRegEmpView" runat="server" AutoGenerateColumns="false" CssClass="table table-striped table-bordered table-hover" EmptyDataText="There are no data records to display.">
                    <Columns>
                        <asp:BoundField DataField="regular_employee_username" HeaderText="username" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg"/>
					
                        <asp:TemplateField HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg">
                            <ItemTemplate>
                                <asp:Button runat="server" id="RemoveFromProject" CommandArgument='<%# Container.DataItemIndex %>' OnCommand="RemoveFromProject_Clicked" Text="Remove" type="submit" class="btn btn-danger"></asp:Button>
                            </ItemTemplate>
                        </asp:TemplateField>

                    </Columns>
                </asp:GridView>
             </div>


              </div>
            </div>
          </div>
        </div>


                    <!-- Create New Task -->
                  <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12">
                      <div class="x_panel">
                        <div class="x_title">
                          <h2>New Task</h2>
                          <ul class="nav navbar-right panel_toolbox">
                            <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                            </li>
                            <li class="dropdown">
                              <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                              <ul class="dropdown-menu" role="menu">
                                <li><a href="#">Settings 1</a>
                                </li>
                                <li><a href="#">Settings 2</a>
                                </li>
                              </ul>
                            </li>
                            <li><a class="close-link"><i class="fa fa-close"></i></a>
                            </li>
                          </ul>
                          <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                          <br>
                          <form id="demo-form2" data-parsley-validate="" class="form-horizontal form-label-left" novalidate="">
      
                            <div class="form-group">
                              <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name">Task Name <span class="required">*</span>
                              </label>
                              <div class="col-md-6 col-sm-6 col-xs-12">
                                <asp:TextBox ID="TaskNametxt" runat="server" type="text" class="form-control col-md-7 col-xs-12" ></asp:TextBox>                                                                     
                              </div>
                            </div>
																
							<div class="form-group">
                              <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name">Description<span class="required">*</span>
                              </label>
                              <div class="col-md-6 col-sm-6 col-xs-12">
                                <asp:TextBox ID="descriptiontxt" runat="server" type="text" class="form-control col-md-7 col-xs-12" ></asp:TextBox>                                                                     
                              </div>
                            </div>									

                            <div class="form-group">
                              <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">Deadline <span class="required">*</span>
                              </label>
                              <div class="form-group">
                                <div class="input-group date" id="datetimepicker6">
<!--                                    <input type="text" class="form-control">-->
                                     <asp:TextBox ID="deadline" runat="server" class="form-control col-md-7 col-xs-12"></asp:TextBox>                                       
                                    <span class="input-group-addon">
                                       <span class="glyphicon glyphicon-calendar"></span>
                                    </span>
                                </div>
                              </div>
                            </div>
                            
                            <div class="ln_solid"></div>
                            <div class="form-group">
                              <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3">
                                <button class="btn btn-primary" type="button">Cancel</button>
                                <button class="btn btn-primary" type="reset">Reset</button>
                                <asp:Button runat="server" ID="CreateTask" Text="Create Task" onclick="CreateNewTask" type="submit" class="btn btn-info"></asp:Button>
                              </div>
                            </div>
      
                          </form>
                        </div>
                      </div>
                    </div>
                  </div>
                        											

		<div class="clearfix"></div>

            <div class="row">
              <div class="col-md-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>Project: Tasks</h2>

                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">

                    <p>Tasks you have created</p>
									
        <div>
          <asp:GridView ID="MyTasksView" runat="server" AutoGenerateColumns="false" CssClass="table table-striped table-bordered table-hover" EmptyDataText="There are no data records to display.">
                  <Columns>
                <asp:BoundField DataField="project" HeaderText="Project" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg"/>
                  <asp:BoundField DataField="name" HeaderText="Task" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg"/>
                <asp:BoundField DataField="regular_employee_username" HeaderText="Employee" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg"/>
                <asp:BoundField DataField="status" HeaderText="Status" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg"/>
                  <asp:BoundField DataField="deadline" HeaderText="Deadline" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg"/>
                <asp:BoundField DataField="description" HeaderText="Description" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg"/>
																	

                <asp:TemplateField HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg">
                  <ItemTemplate>
                      <asp:Button runat="server" id="SelectTask" CommandArgument='<%# Container.DataItemIndex %>' OnCommand="SelectTask_Clicked" Text="Select" type="submit" class="btn btn-success"></asp:Button>
                  </ItemTemplate>
              </asp:TemplateField>
																		
                  </Columns>
          </asp:GridView>
        </div>	

	     </div>
            </div>
          </div>
        </div>	

		 <div class="clearfix"></div>

            <div class="row">
              <div class="col-md-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>Search for Tasks</h2>

                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">

                    <p>Search for specific task in certain project</p>
															
						<div>
                            <form class="form-inline">
                              <div class="form-group">
                                <label for="email" style="margin-left: 250px;">Project Name: </label>
								<asp:TextBox ID="projectNameforTaskTxt" runat="server" class="form-control"></asp:TextBox> 
                                </div>

								<div class="form-group">
                                <label for="pwd" style="margin-left: 50px;">Status: </label>
                                <asp:TextBox ID="statusTxt" runat="server" class="form-control"></asp:TextBox> 
							</div>

                                <asp:Button runat="server" ID="SearchForTask" Text="Search" onclick="SearchForTask_Clicked" type="submit" class="btn btn-info"></asp:Button>
                            </form>
						</div>

                         <div>

						<asp:GridView ID="SearchForTaskView" runat="server" AutoGenerateColumns="false" CssClass="table table-striped table-bordered table-hover" EmptyDataText="There are no data records to display.">
                                  <Columns>
                                <asp:BoundField DataField="project" HeaderText="Project" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg"/>
                                  <asp:BoundField DataField="name" HeaderText="Task" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg"/>
                                <asp:BoundField DataField="regular_employee_username" HeaderText="Employee" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg"/>
                                <asp:BoundField DataField="status" HeaderText="Status" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg"/>
                                  <asp:BoundField DataField="deadline" HeaderText="Deadline" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg"/>
                                <asp:BoundField DataField="description" HeaderText="Description" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg"/>
                                                                                    

                                <asp:TemplateField HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg">
                                  <ItemTemplate>
                                      <asp:Button runat="server" id="SelectTask" CommandArgument='<%# Container.DataItemIndex %>' OnCommand="SelectTask_Clicked" Text="Select" type="submit" class="btn btn-success"></asp:Button>
                                  </ItemTemplate>
                              </asp:TemplateField>
                                                                                        
                                  </Columns>
                          </asp:GridView>
                        </div>  
 															
    			</div>
            </div>
          </div>
        </div>

                                       
                    <!-- Create New Project -->
                  
                                        
                  <!-- end project list -->

                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <!-- /page content -->

        <!-- footer content -->
        <footer>
          <div class="pull-right">
            Gentelella - Bootstrap Admin Template by <a href="https://colorlib.com">Colorlib</a>
          </div>
          <div class="clearfix"></div>
        </footer>
        <!-- /footer content -->
      </div>
    </div>

    <!-- jQuery -->
    <script src="../Style/vendors/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap -->
    <script src="../Style/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- FastClick -->
    <script src="../Style/vendors/fastclick/lib/fastclick.js"></script>
    <!-- NProgress -->
    <script src="../Style/vendors/nprogress/nprogress.js"></script>
    <!-- bootstrap-progressbar -->
    <script src="../Style/vendors/bootstrap-progressbar/bootstrap-progressbar.min.js"></script>

     <!-- bootstrap-daterangepicker -->
     <script src="../Style/vendors/moment/min/moment.min.js"></script>
     <script src="../Style/vendors/bootstrap-daterangepicker/daterangepicker.js"></script>
     <!-- bootstrap-datetimepicker -->    
     <script src="../Style/vendors/bootstrap-datetimepicker/build/js/bootstrap-datetimepicker.min.js"></script>
     <!-- Ion.RangeSlider -->
     <script src="../Style/vendors/ion.rangeSlider/js/ion.rangeSlider.min.js"></script>
     <!-- Bootstrap Colorpicker -->
     <script src="../Style/vendors/mjolnic-bootstrap-colorpicker/dist/js/bootstrap-colorpicker.min.js"></script>
     <!-- jquery.inputmask -->
     <script src="../Style/vendors/jquery.inputmask/dist/min/jquery.inputmask.bundle.min.js"></script>
     <!-- jQuery Knob -->
     <script src="../Style/vendors/jquery-knob/dist/jquery.knob.min.js"></script>
     <!-- Cropper -->
     <script src="../Style/vendors/cropper/dist/cropper.min.js"></script>
 
     <!-- Custom Theme Scripts -->
     <script src="../Style/build/js/custom.min.js"></script>
     
 
     
     <!-- Initialize datetimepicker -->
 <script>
     $('#myDatepicker').datetimepicker();
     
     $('#myDatepicker2').datetimepicker({
         format: 'DD.MM.YYYY'
     });
     
     $('#myDatepicker3').datetimepicker({
         format: 'hh:mm A'
     });
     
     $('#myDatepicker4').datetimepicker({
         ignoreReadonly: true,
         allowInputToggle: true
     });
 
     $('#datetimepicker6').datetimepicker();
     
     $('#datetimepicker7').datetimepicker({
         useCurrent: false
     });
     
     $("#datetimepicker6").on("dp.change", function(e) {
         $('#datetimepicker7').data("DateTimePicker").minDate(e.date);
     });
     
     $("#datetimepicker7").on("dp.change", function(e) {
         $('#datetimepicker6').data("DateTimePicker").maxDate(e.date);
     });
 </script>

    </form>
  </body>
</html>