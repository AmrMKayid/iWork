﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Manage_Requests.aspx.cs" Inherits="iWork.Staff_Member.HR_Employee.Requests.Manage_Requests" %>

<!DOCTYPE html>

<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head>

    <title>Manage Requests - iWork</title>
    
    <!-- Meta, title, CSS, favicons, etc. -->

    <meta charset="utf-8"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>

    <meta name="viewport" content="width=device-width, initial-scale=1"/>

    <!-- Bootstrap -->
    <link href="../../../Style/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet"/>

    <!-- Font Awesome -->
    <link href="../../../Style/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet"/>

    <!-- NProgress -->
    <link href="../../../Style/vendors/nprogress/nprogress.css" rel="stylesheet"/>

    <!-- iCheck -->
    <link href="../../../Style/vendors/iCheck/skins/flat/green.css" rel="stylesheet"/>

    <!-- Custom Theme Style -->
    <link href="../../../Style/build/css/custom.min.css" rel="stylesheet"/>

     <!-- bootstrap-daterangepicker -->
    <link href="../../../Style/vendors/bootstrap-daterangepicker/daterangepicker.css" rel="stylesheet"/>

    <!-- bootstrap-datetimepicker -->
    <link href="../../../Style/vendors/bootstrap-datetimepicker/build/css/bootstrap-datetimepicker.css" rel="stylesheet"/>

    <!-- Ion.RangeSlider -->
    <link href="../../../Style/vendors/normalize-css/normalize.css" rel="stylesheet"/>
    <link href="../../../Style/vendors/ion.rangeSlider/css/ion.rangeSlider.css" rel="stylesheet"/>
    <link href="../../../Style/vendors/ion.rangeSlider/css/ion.rangeSlider.skinFlat.css" rel="stylesheet"/>

    <!-- Bootstrap Colorpicker -->
    <link href="../../../Style/vendors/mjolnic-bootstrap-colorpicker/dist/css/bootstrap-colorpicker.min.css" rel="stylesheet"/>
    <link href="../../../Style/vendors/cropper/dist/cropper.min.css" rel="stylesheet"/>

</head>
<body class="nav-md">
    <form id="form1" runat="server">
        <div class="container body">
            <div class="main_container">
                
                <div class="col-md-3 left_col">
                    
                    <div class="left_col scroll-view">
                        
                        <div class="navbar nav_title" style="border: 0;">
                            
                            <a href="../../../Default.aspx" class="site_title"><i class="fa fa-laptop"></i> <span>iWork</span></a>

                        </div>
                        
                        <div class="clearfix"></div>
                        
                        <!-- menu profile quick info -->
                        <div class="profile clearfix">
                            
                            <div class="profile_pic">
                                <img src="../../../images/img.jpg" alt="..." class="img-circle profile_img"/>
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
                                    <li><a href="../../../Default.aspx"><i class="fa fa-home"></i>Home</a></li>
                                </ul>
                            </div>
                            
                            <asp:Panel id="HR_Tasks_Panel" runat="server">
                                <div class="menu_section">

                                    <h3>Human Resources</h3>

                                    <ul class="nav side-menu">

                                        <li><a><i class="fa fa-check-square"></i>Requests<span class="fa fa-chevron-down"></span></a>
                                            <ul class="nav child_menu">
                                                <li><a href="../Requests/Manage_Requests.aspx">Review pending Requests</a></li>
                                            </ul>
                                        </li>

                                        <li><a><i class="fa fa-pencil"></i>Jobs & Applications<span class="fa fa-chevron-down"></span></a>
                                            <ul class="nav child_menu">
                                                <li><a href="../Jobs/ViewJobs.aspx">Manage Jobs</a></li>
                                                <li><a href="../Jobs/QuestionsLibrary.aspx">Library of Interview Questions</a></li>
                                            </ul>
                                        </li>

                                        <li><a><i class="fa fa-bullhorn"></i>Announcements<span class="fa fa-chevron-down"></span></a>
                                            <ul class="nav child_menu">
                                                <li><a href="../Announcements/Post_Announcement.aspx">Post Announcement</a></li>
                                            </ul>
                                        </li>

                                        <li><a><i class="fa fa-briefcase"></i>Attendance<span class="fa fa-chevron-down"></span></a>
                                            <ul class="nav child_menu">
                                                <li><a href="../Attendance/ViewStaffAttendance.aspx">View Staff Attendance</a></li>
                                                <li><a href="../Attendance/EmployeeOfTheMonth.aspx">Regular Employees of the Month</a></li>
                                            </ul>
                                        </li>

                                    </ul>

                                </div>
                            </asp:Panel>

                        </div>
                        <!-- /sidebar menu -->
                        
                        <!-- menu footer buttons -->
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
                                        <img src="../../../images/img.jpg" alt=""/>Amr Kayid<span class=" fa fa-angle-down"></span>
                                    </a>
                                    
                                    <ul class="dropdown-menu dropdown-usermenu pull-right">
                                        <li><a href="javascript:;">Profile</a></li>
                                        <li><a href="javascript:;">
                                            <span class="badge bg-red pull-right">50%</span>
                                            <span>Settings</span>
                                            </a>
                                        </li>
                                        <li><a href="javascript:;">Help</a></li>
                                        <li><a href="login.html"><i class="fa fa-sign-out pull-right"></i>Log Out</a></li>
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
                                <h3>Dashboard</h3>
                            </div>
                            
                            <div class="title_right">
                                <div class="col-md-5 col-sm-5 col-xs-12 form-group pull-right top_search">
                                    <div class="input-group">

                                        <input type="text" class="form-control" placeholder="Search for..."/>
                                        
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
                                
                                <asp:Panel ID="Requests_Panel" runat="server">
                                    
                                    <asp:Label ID="RequestsUpdate_Status_Label" runat="server" CssClass="status" />
                                    <br />

                                    <div id="leave_requests" class="x_panel">
                                        
                                        <div class="x_title">
                                            <h2>Leave Requests</h2>
                                            <div class="clearfix"></div>
                                        </div>
                                        
                                        <div class="x_content">
                                            <asp:GridView ID="Leave_Requests_GridView" runat="server" CssClass="table" OnRowCommand="Requests_GridView_RowCommand" />
                                        </div>

                                    </div>
                                    
                                    <br />

                                    <div id="business_trip_requests" class="x_panel">
                                        
                                        <div class="x_title">
                                            <h2>Business Trip Requests</h2>
                                            <div class="clearfix"></div>
                                        </div>
                                        
                                        <div class="x_content">
                                            <asp:GridView ID="Business_Trip_Requests_GridView" runat="server" CssClass="table" OnRowCommand="Requests_GridView_RowCommand" />
                                        </div>

                                    </div>

                                </asp:Panel>
                                
                                <asp:Panel id="NotHR_Panel" runat="server">
                                    <div class="x_panel">
                                        <div class="x_content">
                                            <p>Sorry, this page is made only for HR Employees.<br />
                                                If you are an HR Employees, please make sure you are logged in with your working account.
                                            </p>
                                            <asp:Button ID="LoginFirst_Button" runat="server" Text="Login" CssClass="btn" OnClick="LoginFirst_Button_Click" />
                                        </div>
                                    </div>
                                </asp:Panel>

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
        <script src="../../../Style/vendors/jquery/dist/jquery.min.js"></script>
        
        <!-- Bootstrap -->
        <script src="../../../Style/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
        
        <!-- FastClick -->
        <script src="../../../Style/vendors/fastclick/lib/fastclick.js"></script>
        
        <!-- NProgress -->
        <script src="../../../Style/vendors/nprogress/nprogress.js"></script>
        
        <!-- bootstrap-progressbar -->
        <script src="../../../Style/vendors/bootstrap-progressbar/bootstrap-progressbar.min.js"></script>
        
        <!-- bootstrap-daterangepicker -->
        <script src="../../../Style/vendors/moment/min/moment.min.js"></script>
        <script src="../../../Style/vendors/bootstrap-daterangepicker/daterangepicker.js"></script>
        
        <!-- bootstrap-datetimepicker -->    
        <script src="../../../Style/vendors/bootstrap-datetimepicker/build/js/bootstrap-datetimepicker.min.js"></script>
        
        <!-- Ion.RangeSlider -->
        <script src="../../../Style/vendors/ion.rangeSlider/js/ion.rangeSlider.min.js"></script>
        
        <!-- Bootstrap Colorpicker -->
        <script src="../../../Style/vendors/mjolnic-bootstrap-colorpicker/dist/js/bootstrap-colorpicker.min.js"></script>
        
        <!-- jquery.inputmask -->
        <script src="../../../Style/vendors/jquery.inputmask/dist/min/jquery.inputmask.bundle.min.js"></script>
        
        <!-- jQuery Knob -->
        <script src="../../../Style/vendors/jquery-knob/dist/jquery.knob.min.js"></script>
        
        <!-- Cropper -->
        <script src="../../../Style/vendors/cropper/dist/cropper.min.js"></script>
        
        <!-- Custom Theme Scripts -->
        <script src="../../../Style/build/js/custom.min.js"></script>
        
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

            $("#datetimepicker6").on("dp.change", function (e) {

                $('#datetimepicker7').data("DateTimePicker").minDate(e.date);

            });

            $("#datetimepicker7").on("dp.change", function (e) {

                $('#datetimepicker6').data("DateTimePicker").maxDate(e.date);

            });

        </script>

    </form>
</body>
</html>