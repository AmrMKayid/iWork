<%@ Page Language="C#" Inherits="iWork.Home.Company_Departments"  enableEventValidation="false"  %>
<!DOCTYPE html>
<html lang="en" class=" "><head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>DataTables | Gentelella</title>

    <!-- Bootstrap -->
    <link href="../vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="../vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="../vendors/nprogress/nprogress.css" rel="stylesheet">
    <!-- iCheck -->
    <link href="../vendors/iCheck/skins/flat/green.css" rel="stylesheet">
    <!-- Datatables -->
    <link href="../vendors/datatables.net-bs/css/dataTables.bootstrap.min.css" rel="stylesheet">
    <link href="../vendors/datatables.net-buttons-bs/css/buttons.bootstrap.min.css" rel="stylesheet">
    <link href="../vendors/datatables.net-fixedheader-bs/css/fixedHeader.bootstrap.min.css" rel="stylesheet">
    <link href="../vendors/datatables.net-responsive-bs/css/responsive.bootstrap.min.css" rel="stylesheet">
    <link href="../vendors/datatables.net-scroller-bs/css/scroller.bootstrap.min.css" rel="stylesheet">

    <!-- Custom Theme Style -->
    <link href="../build/css/custom.min.css" rel="stylesheet">

    <link type="text/css" rel="stylesheet" href="https://cdn.datatables.net/1.10.9/css/dataTables.bootstrap.min.css" />
    <link type="text/css" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" />
    <link type="text/css" rel="stylesheet" href="https://cdn.datatables.net/responsive/1.0.7/css/responsive.bootstrap.min.css" />
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/1.10.9/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/responsive/1.0.7/js/dataTables.responsive.min.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/1.10.9/js/dataTables.bootstrap.min.js"></script>
    <script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
    <script type="text/javascript">
        $(function () {
            $('[id*=CompanyDepartmentGridView]').prepend($("<thead></thead>").append($('[id*=CompanyDepartmentGridView]').find("tr:first"))).DataTable({
                "responsive": true,
                "sPaginationType": "full_numbers"
            });
        });

        $.fn.dataTable.ext.errMode = 'none';
    </script>
        
  </head>

  <body class="nav-md vsc-initialized">
    <div class="container body">
      <div class="main_container">

        <div class="right_col" role="main" style="min-height: 3820px;">
          <div class="">
            

            <div class="clearfix"></div>

            <div class="row">
              <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>iWork <small>Company's Departments</small></h2>
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

            <form id="form1" runat="server">


            <asp:GridView ID="CompanyGridView" runat="server" AutoGenerateColumns="false" CssClass="table table-striped table-bordered table-hover" EmptyDataText="You Do NOT have this Job in Your Department!">

            <Columns>
                <asp:BoundField DataField="name" HeaderText="Name" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg"/>
                <asp:BoundField DataField="address" HeaderText="Address" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg"/>
                <asp:BoundField DataField="domain" HeaderText="Domain" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg"/>
                <asp:BoundField DataField="email" HeaderText="Email" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg"/>
                <asp:BoundField DataField="specialization" HeaderText="Specialization" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg"/>
                <asp:BoundField DataField="vision" HeaderText="vision" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg"/>
				<asp:BoundField DataField="type" HeaderText="Type" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg"/>
                <asp:BoundField DataField="salary" HeaderText="Avg. Salary" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg"/>

            </Columns>
        </asp:GridView>


                  <br>
                                            
            <asp:GridView ID="CompanyDepartmentGridView" runat="server" AutoGenerateColumns="false" CssClass="table table-striped table-bordered table-hover" EmptyDataText="You Do NOT have this Job in Your Department!">

            <Columns>
                <asp:BoundField DataField="name" HeaderText="Name" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg"/>
                <asp:BoundField DataField="code" HeaderText="Code" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg"/>
                <asp:BoundField DataField="company" HeaderText="Company" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg"/>


            <asp:TemplateField HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg">
                <ItemTemplate>
                    <asp:Button runat="server" HeaderText="Select" id="viewDepartmentJobs" CommandArgument='<%# Container.DataItemIndex %>' OnCommand="viewDepartmentJobs_Clicked" Text="View Jobs" type="submit" class="btn btn-success"></asp:Button>
                </ItemTemplate>
            </asp:TemplateField>


            </Columns>
        </asp:GridView>
    </form>
                                        
                  </div>
                </div>
              </div>

              
            </div>
          </div>
        </div>
 
      </div>
    </div>

    <!-- jQuery -->
    <script src="../vendors/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap -->
    <script src="../vendors/bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- FastClick -->
    <script src="../vendors/fastclick/lib/fastclick.js"></script>
    <!-- NProgress -->
    <script src="../vendors/nprogress/nprogress.js"></script>
    <!-- iCheck -->
    <script src="../vendors/iCheck/icheck.min.js"></script>
    <!-- Datatables -->
    <script src="../vendors/datatables.net/js/jquery.dataTables.min.js"></script>
    <script src="../vendors/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
    <script src="../vendors/datatables.net-buttons/js/dataTables.buttons.min.js"></script>
    <script src="../vendors/datatables.net-buttons-bs/js/buttons.bootstrap.min.js"></script>
    <script src="../vendors/datatables.net-buttons/js/buttons.flash.min.js"></script>
    <script src="../vendors/datatables.net-buttons/js/buttons.html5.min.js"></script>
    <script src="../vendors/datatables.net-buttons/js/buttons.print.min.js"></script>
    <script src="../vendors/datatables.net-fixedheader/js/dataTables.fixedHeader.min.js"></script>
    <script src="../vendors/datatables.net-keytable/js/dataTables.keyTable.min.js"></script>
    <script src="../vendors/datatables.net-responsive/js/dataTables.responsive.min.js"></script>
    <script src="../vendors/datatables.net-responsive-bs/js/responsive.bootstrap.js"></script>
    <script src="../vendors/datatables.net-scroller/js/dataTables.scroller.min.js"></script>
    <script src="../vendors/jszip/dist/jszip.min.js"></script>
    <script src="../vendors/pdfmake/build/pdfmake.min.js"></script>
    <script src="../vendors/pdfmake/build/vfs_fonts.js"></script>

    <!-- Custom Theme Scripts -->
    <script src="../build/js/custom.min.js"></script>

  
</body></html>