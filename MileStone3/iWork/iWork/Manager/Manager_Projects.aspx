<%@ Page Language="C#" Inherits="iWork.Manager.Manager_Projects" %>
<!DOCTYPE html>
<html>
<head runat="server">
	<title>Manager_Projects</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

</head>
<body>
	<form id="ProjectsForm" runat="server">

		<div>
              <asp:Label ID="ProjectNamelbl" Text="Project Name: "></asp:Label>
              <asp:TextBox ID="ProjectNametxt" runat="server" type="text" class="form-control" ></asp:TextBox>
        </div>


        <div>
            <asp:Calendar ID="Calendar1" runat="server" Visible="False" OnSelectionChanged="Calendar1_SelectionChanged"></asp:Calendar>
        </div>
        <asp:LinkButton ID="LinkButton1" runat="server" onclick="LinkButton1_Click">Start Date: </asp:LinkButton>
        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>

        <div>
            <asp:Calendar ID="Calendar2" runat="server" Visible="False" OnSelectionChanged="Calendar2_SelectionChanged"></asp:Calendar>
        </div>
        <asp:LinkButton ID="LinkButton2" runat="server" onclick="LinkButton2_Click">End Date: </asp:LinkButton>
        <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>


        <asp:Button runat="server" ID="CreateProject" Text="Create Project" onclick="CreateNewProject" type="submit" class="btn btn-info"></asp:Button>


	    <!--################################################################-->

	    <asp:Button runat="server" ID="viewMyProjects" Text="My Projects" onclick="viewMyProjects_Clicked" type="submit" class="btn btn-info"></asp:Button>
        <div>
                <asp:GridView ID="MyProjectsView" runat="server" AutoGenerateColumns="false" CssClass="table table-striped table-bordered table-hover" EmptyDataText="There are no data records to display.">
                        <Columns>
        					    <asp:BoundField DataField="name" HeaderText="Project" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg"/>
                                <asp:BoundField DataField="start_date" HeaderText="Start Date" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg"/>
            					<asp:BoundField DataField="end_date" HeaderText="End Date" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg"/>

        						<asp:TemplateField HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg">
                                    <ItemTemplate>
                                        <asp:Button runat="server" id="SelectProject" CommandArgument='<%# Container.DataItemIndex %>' OnCommand="SelectProject_Clicked" Text="Select" type="submit" class="btn btn-success"></asp:Button>
                                    </ItemTemplate>
                                </asp:TemplateField>
                        </Columns>
                </asp:GridView>
       </div>

        <asp:Button runat="server" ID="viewRegularEmp" Text="view Employee" onclick="viewRegularEmp_Clicked" type="submit" class="btn btn-info"></asp:Button>
		<div>
                <asp:GridView ID="RegEmpView" runat="server" AutoGenerateColumns="false" CssClass="table table-striped table-bordered table-hover" EmptyDataText="There are no data records to display.">
                    <Columns>
                        <asp:BoundField DataField="username" HeaderText="username" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg"/>
                        <asp:BoundField DataField="Projects" HeaderText="Request Date" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg"/>

                        <asp:TemplateField HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg">
                            <ItemTemplate>
                                <asp:Button runat="server" id="AddToProject" CommandArgument='<%# Container.DataItemIndex %>' OnCommand="AddToProject_Clicked" Text="Add" type="submit" class="btn btn-success"></asp:Button>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg">
                            <ItemTemplate>
                                <asp:Button runat="server" id="RemoveFromProject" CommandArgument='<%# Container.DataItemIndex %>' OnCommand="RemoveFromProject_Clicked" Text="Remove" type="submit" class="btn btn-danger"></asp:Button>
                            </ItemTemplate>
                        </asp:TemplateField>

                    </Columns>
                </asp:GridView>
       </div>

	</form>
</body>
</html>
