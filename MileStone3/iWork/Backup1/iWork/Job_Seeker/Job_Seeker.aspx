<%@ Page Language="C#" AutoEventWireup="true" Inherits="iWork.Job_Seeker.Job_Seeker" EnableEventValidation="false" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>

    <title>iWork | DashBoard </title>

    <!-- Bootstrap -->
    <link href="../Style/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <!-- Font Awesome -->
    <link href="../Style/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet"/>
    <!-- NProgress -->
    <link href="../Style/vendors/nprogress/nprogress.css" rel="stylesheet"/>
    <!-- iCheck -->
    <link href="../Style/vendors/iCheck/skins/flat/green.css" rel="stylesheet"/>

    <!-- Custom Theme Style -->
    <link href="../Style/build/css/custom.min.css" rel="stylesheet"/>

     <!-- bootstrap-daterangepicker -->
    <link href="../Style/vendors/bootstrap-daterangepicker/daterangepicker.css" rel="stylesheet"/>
    <!-- bootstrap-datetimepicker -->
    <link href="../Style/vendors/bootstrap-datetimepicker/build/css/bootstrap-datetimepicker.css" rel="stylesheet"/>
    <!-- Ion.RangeSlider -->
    <link href="../Style/vendors/normalize-css/normalize.css" rel="stylesheet"/>
    <link href="../Style/vendors/ion.rangeSlider/css/ion.rangeSlider.css" rel="stylesheet"/>
    <link href="../Style/vendors/ion.rangeSlider/css/ion.rangeSlider.skinFlat.css" rel="stylesheet"/>
    <!-- Bootstrap Colorpicker -->
    <link href="../Style/vendors/mjolnic-bootstrap-colorpicker/dist/css/bootstrap-colorpicker.min.css" rel="stylesheet"/>

    <link href="../Style/vendors/cropper/dist/cropper.min.css" rel="stylesheet"/>
</head>

 <body class="nav-md">
    <form id="ProjectsForm" runat="server">
    <div class="container body">
      <div class="main_container">
        <div class="col-md-3 left_col">
          <div class="left_col scroll-view">
            <div class="navbar nav_title" style="border: 0;">
              <a href="index.html" class="site_title"><i class="fa fa-laptop"></i> <span>iWork!</span></a>
            </div>

            <div class="clearfix"></div>

            <!-- menu profile quick info -->
            <div class="profile clearfix">
              <div class="profile_pic">
                <img src="images/img.jpg" alt="..." class="img-circle profile_img"/>
              </div>
              <div class="profile_info">
                <span>Welcome, <br /> <%:Session["Username"]%></span>
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
                    </ul>
                  </li>
                </ul>
              </div>
              <div class="menu_section">
                <h3>[Job_Seeker]</h3>
                <ul  class="nav side-menu">


                  <li><a><i class="fa fa-pencil"></i> Applications <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                        <li> <asp:LinkButton ID="LinkButton2" runat="server" OnClick="View_AStatus">Application Status</asp:LinkButton></li>

                    </ul>
                  </li>

                      <li ><a><i class="fa fa-pencil"></i> Edit personal info <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                        <li>  <div id="y_exp" class="popover-markup">
    <asp:linkbutton runat="server" OnClientClick="return false;"   class="trigger" ><i class="fa fa-wrench"></i>Edit years_of_exp</asp:linkbutton>

    <div id="y_exp1"class="content hide">
        <div id="y_exp2" class="form-group">
            <asp:DropDownList id="yofexp"  runat="server">
                <asp:ListItem Selected="True" >0</asp:ListItem>
                <asp:ListItem>1</asp:ListItem>
                <asp:ListItem>2</asp:ListItem>
                <asp:ListItem>3</asp:ListItem>
                <asp:ListItem>4</asp:ListItem>
                <asp:ListItem>5</asp:ListItem>
                <asp:ListItem>6</asp:ListItem>
                <asp:ListItem>7</asp:ListItem>
                <asp:ListItem>8</asp:ListItem>
                <asp:ListItem>9</asp:ListItem>
                <asp:ListItem>10</asp:ListItem>

                </asp:DropDownList>
        </div>
        <asp:button  Text="Submit" class="btn btn-info" runat="server" type="submit"  onclick="Change_years_of_exp" >

        </asp:button>
    </div>
</div></li>

     <li>  <div  class="popover-markup">
    <a href="#" class="trigger"><i class="fa fa-wrench"></i>Edit first name</a>
    <div class="content hide">
        <div class="form-group">
           <asp:TextBox runat="server" id="fn" type="text"></asp:TextBox>
        </div>
        <asp:button Text="Submit" class="btn btn-info" runat="server" type="submit"  onclick="Change_first" >

        </asp:button>
    </div>
</div></li>

    <li> <div  class="popover-markup">
    <a href="#" class="trigger"><i class="fa fa-wrench"></i>Edit middle name</a>

    <div class="content hide">
        <div class="form-group">
           <asp:TextBox runat="server" id="mn"  ></asp:TextBox>
        </div>
        <asp:button Text="Submit" class="btn btn-info" runat="server" type="submit"  onclick="Change_middle" >

        </asp:button>
    </div>
</div></li>

               <li> <div  class="popover-markup">
    <a href="#" class="trigger"><i class="fa fa-wrench"></i>Edit last name</a>
    <div class="content hide">
        <div class="form-group">
           <asp:TextBox runat="server" id="ln" type="text" ></asp:TextBox>
        </div>
        <asp:button Text="Submit" class="btn btn-info" runat="server" type="submit"  onclick="Change_last" >

        </asp:button>
    </div>
</div></li>

            <li><div  class="popover-markup">
    <a href="#" class="trigger"><i class="fa fa-wrench"></i>Edit password</a>
    <div class="content hide">
        <div class="form-group">
           <asp:TextBox runat="server" id="pass" type="text" ></asp:TextBox>
        </div>
        <asp:button Text="Submit" class="btn btn-info" runat="server" type="submit"  onclick="Change_password" >

        </asp:button>
    </div>
</div></li>
                        <li> <div  class="popover-markup">
    <a href="#" class="trigger"><i class="fa fa-wrench"></i>Edit email</a>
    <div class="content hide">
        <div class="form-group">
           <asp:TextBox runat="server" id="email" type="text" ></asp:TextBox>
        </div>
        <asp:button Text="Submit" class="btn btn-info" runat="server" type="submit"  onclick="Change_email" >

        </asp:button>
    </div>
</div></li>
                        <li> <div  class="popover-markup">
    <a href="#" class="trigger"><i class="fa fa-wrench"></i>Edit Birth date</a>
    <div class="content hide">
        <div  class="form-group">
            <asp:DropDownList id="day"  runat="server">
                <asp:ListItem Selected="True">1</asp:ListItem>
                <asp:ListItem>2</asp:ListItem>
                <asp:ListItem>3</asp:ListItem>
                <asp:ListItem>4</asp:ListItem>
                <asp:ListItem>5</asp:ListItem>
                <asp:ListItem>6</asp:ListItem>
                <asp:ListItem>7</asp:ListItem>
                <asp:ListItem>8</asp:ListItem>
                <asp:ListItem>9</asp:ListItem>
                <asp:ListItem>10</asp:ListItem>
                <asp:ListItem>11</asp:ListItem>
                <asp:ListItem>12</asp:ListItem>
                <asp:ListItem>13</asp:ListItem>
                <asp:ListItem>14</asp:ListItem>
                <asp:ListItem>15</asp:ListItem>
                <asp:ListItem>16</asp:ListItem>
                <asp:ListItem>17</asp:ListItem>
                <asp:ListItem>18</asp:ListItem>
                <asp:ListItem>19</asp:ListItem>
                <asp:ListItem>20</asp:ListItem>
                <asp:ListItem>21</asp:ListItem>
                <asp:ListItem>22</asp:ListItem>
                <asp:ListItem>23</asp:ListItem>
                <asp:ListItem>24</asp:ListItem>
                <asp:ListItem>25</asp:ListItem>
                <asp:ListItem>26</asp:ListItem>
                <asp:ListItem>28</asp:ListItem>
                <asp:ListItem>29</asp:ListItem>
                <asp:ListItem>30</asp:ListItem>
                <asp:ListItem>31</asp:ListItem>
                </asp:DropDownList>
              <asp:DropDownList id="Month"  runat="server">
                <asp:ListItem Selected="True">1</asp:ListItem>
                <asp:ListItem>2</asp:ListItem>
                <asp:ListItem>3</asp:ListItem>
                <asp:ListItem>4</asp:ListItem>
                <asp:ListItem>5</asp:ListItem>
                <asp:ListItem>6</asp:ListItem>
                <asp:ListItem>7</asp:ListItem>
                <asp:ListItem>8</asp:ListItem>
                <asp:ListItem>9</asp:ListItem>
                <asp:ListItem>10</asp:ListItem>
                <asp:ListItem>11</asp:ListItem>
                <asp:ListItem>12</asp:ListItem>

                </asp:DropDownList>
            <asp:DropDownList id="Year"  runat="server">
                <asp:ListItem Selected="True">1960</asp:ListItem>
                <asp:ListItem>1965</asp:ListItem>
                <asp:ListItem>1970</asp:ListItem>
                <asp:ListItem>1975</asp:ListItem>
                <asp:ListItem>1980</asp:ListItem>
                <asp:ListItem>1985</asp:ListItem>
                <asp:ListItem>1990</asp:ListItem>
                <asp:ListItem>1995</asp:ListItem>


                </asp:DropDownList>
        </div>
        <asp:button Text="Submit"  class="btn btn-info" runat="server" type="submit"  onclick="Change_date" >

        </asp:button>
    </div>
</div></li>
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
                    <img src="images/img.jpg" alt=""/><%:Session["Username"]%>
                    <span class=" fa fa-angle-down"></span>
                  </a>
                  <ul class="dropdown-menu dropdown-usermenu pull-right">
                    <li><a href="Job_Seeker.aspx"> Profile</a></li>
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
                <h3>Profile <small></small></h3>
              </div>

              <div class="title_right">
                <div class="col-md-5 col-sm-5 col-xs-12 form-group pull-right top_search">
                  <div class="input-group">
                    <input type="text" id="Searched_job" class="form-control" placeholder="Search for jobs" runat="server"/>
                    <span class="input-group-btn">
                      <asp:button class="btn btn-default" type="button" runat="server" oncommand="show_searched_jobs"  text="Go!"></asp:button>
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
                    <h2>Profile</h2>
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


             <!--new-->

                      <div>

        <asp:DataList ID="DataList1" runat="server"  BorderColor="White"

            BorderStyle="None" BorderWidth="2px" CellPadding="3" CellSpacing="4"

            Font-Names="Verdana" Font-Size="Small" GridLines="Both"  RepeatDirection="Horizontal"

            Width="100%">

            <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />



            <ItemStyle ForeColor="Black" BorderWidth="2px" />

            <ItemTemplate >

                <b> First Name: </b>

                <asp:Label   ID="firstname" runat="server" Text='<%# Eval("first_name") %>'></asp:Label>
                <hr />

                <b> Middle Name: </b>

                <asp:Label ID="middlename" runat="server" Text='<%# Eval("middle_name") %>'></asp:Label>


                <hr />
                <b> Last Name: </b>

                <asp:Label ID="lastname" runat="server" Text='<%# Eval("last_name") %>'></asp:Label>


                <hr />
                <b> Password: </b>

                <asp:Label ID="Label1" runat="server" Text='<%# Eval("password") %>'></asp:Label>

                <hr />
                <b> Email: </b>

                <asp:Label ID="Label2" runat="server" Text='<%# Eval("email") %>'></asp:Label>

                <hr />

                <b> Birth date: </b>

                <asp:Label ID="lblName" runat="server" Text='<%# Eval("birth_date") %>'></asp:Label>

                <hr />

               <b> Age: </b>

                <asp:Label ID="lblCity" runat="server" Text=' <%# Eval("age") %>'></asp:Label>

                <hr />

                <b> Years of Experience: </b>

                <asp:Label ID="lblCountry" runat="server" Text='<%# Eval("years_of_experience") %>'></asp:Label>




                <br />

            </ItemTemplate>

        </asp:DataList>

    </div>
         <hr />
  <h2 >Previous Job Titles: </h2>

                       <asp:GridView ID="Previous" runat="server" AutoGenerateColumns="false" CssClass="table table-striped table-bordered table-hover" EmptyDataText="No Previous Job titles!">

                            <Columns>
                              <asp:BoundField DataField="title" HeaderText="Title" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg"/>
                                <asp:TemplateField HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg">
                                    <ItemTemplate>
                                  <asp:Button runat="server"  ID="Delete_pr"  Text="Delete" CommandArgument='<%#Eval("title") %>' OnClick="deleteprevious"   type="submit" Cssclass="btn btn-danger"></asp:Button>

                                    </ItemTemplate>
                                </asp:TemplateField>
                          </Columns>
                        </asp:GridView>
                      <asp:TextBox ID="new_previous" placeholder="Enter a previous job title" runat="server"></asp:TextBox>
                        <asp:Button runat="server"  ID="Delete_pr"  Text="ADD!" onclick="Addprevious" type="submit" Cssclass="btn btn-success"></asp:Button>


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
     $('.popover-markup>.trigger').popover({
         html: true,
         title: function () {
             return $(this).parent().find('.head').html();
         },
         content: function () {
             return $(this).parent().find('.content').html();
         }
     });


 </script>
    </form>
  </body>
</html>
