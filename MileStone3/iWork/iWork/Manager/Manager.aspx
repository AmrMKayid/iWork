<%@ Page Language="C#" Inherits="iWork.Manager.Manager" %>
<!DOCTYPE html>
<html>
<head runat="server">
	<title>Manager</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

</head>
<body>
	<form id="form1" runat="server">

        <asp:Label runat="server" Text="Manager "></asp:Label>
            
        <div>
             
             <asp:Button runat="server" ID="NewRequests" Text="Requests" onclick="ViewNewRequests" type="submit" class="btn btn-info"></asp:Button>

            <div>  
                <asp:GridView ID="RequestsGridView" runat="server" AutoGenerateColumns="false" CssClass="table table-striped table-bordered table-hover" EmptyDataText="There are no data records to display.">
                    <Columns>  
                        <asp:BoundField DataField="username" HeaderText="username" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg"/>  
                        <asp:BoundField DataField="request_date" HeaderText="Request Date" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg"/>  
                        <asp:BoundField DataField="start_date" HeaderText="Start Date" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg"/>  
                        <asp:BoundField DataField="end_date" HeaderText="End Date" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg"/>  
                        <asp:BoundField DataField="leave_days" HeaderText="Leave Days" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg"/>  
                        <asp:BoundField DataField="hr_status" HeaderText="HR Status" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg"/> 
						<asp:BoundField DataField="manager_status" HeaderText="Final Status" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg"/>  

                        <asp:TemplateField HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg">
                            <ItemTemplate>  <!--OnClick="AcceptRequest"-->
                                <asp:Button runat="server" HeaderText="Accept" id="Accept" CommandArgument='<%# Container.DataItemIndex %>' OnCommand="AcceptRequest" Text="Accept" type="submit" class="btn btn-success"></asp:Button>    
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg">
                            <ItemTemplate>
                                <asp:Button runat="server" HeaderText="Reject" id="Reject" CommandArgument='<%# Container.DataItemIndex %>' OnCommand="RejectRequest" Text="Reject" type="submit" class="btn btn-danger"></asp:Button>    
                            </ItemTemplate>
                        </asp:TemplateField>
                                
                    </Columns>  
                </asp:GridView>  
            </div>
        </div>
			
		<!--###############################################################################################################-->

        <div>
            <asp:Button runat="server" ID="NewApplications" Text="Applications" onclick="ViewNewApplications" type="submit" class="btn btn-info"></asp:Button>

           <div>
                <asp:GridView ID="ApplicationGridView" runat="server" AutoGenerateColumns="false" CssClass="table table-striped table-bordered table-hover" EmptyDataText="There are no data records to display.">

                    <Columns>  
                        <asp:BoundField DataField="id" HeaderText="id" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg"/>  
                        <asp:BoundField DataField="job_title" HeaderText="Title" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg"/>  
                        <asp:BoundField DataField="app_username" HeaderText="Applicant" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg"/>  
                        <asp:BoundField DataField="score" HeaderText="Score" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg"/>  
                        <asp:BoundField DataField="short_description" HeaderText="Description" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg"/>  
                        <asp:BoundField DataField="working_hours" HeaderText="W. Hours" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg"/>  
                        <asp:BoundField DataField="vacancy" HeaderText="Vacancy" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg"/>  
                        <asp:BoundField DataField="deadline" HeaderText="Deadline" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg"/>  
                        <asp:BoundField DataField="min_years_of_experience" HeaderText="minYearsOfExp" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg"/>  
                        <asp:BoundField DataField="hr_username" HeaderText="HR" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg"/>  
                        <asp:BoundField DataField="manager_status" HeaderText="Final Status" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg"/>  

                        <asp:TemplateField HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg">
                            <ItemTemplate>
                                <asp:Button runat="server" HeaderText="Accept" id="Accept" CommandArgument='<%# Container.DataItemIndex %>' OnCommand="AcceptApplication" Text="Accept" type="submit" class="btn btn-success"></asp:Button>    
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg">
                            <ItemTemplate>
                                <asp:Button runat="server" HeaderText="Reject" id="Reject" CommandArgument='<%# Container.DataItemIndex %>' OnCommand="RejectApplication" Text="Reject" type="submit" class="btn btn-danger"></asp:Button>    
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                    </Columns>
                </asp:GridView>  
           </div>
                
        
        </div>

		<!--###############################################################################################################-->

        <asp:Button runat="server" ID="NewProject" Text="New Project" onclick="NewProjectClicked" type="submit" class="btn btn-info"></asp:Button>

		<asp:Label ID="ProjectNamelbl" Text="Project Name: "></asp:Label>
        <asp:TextBox ID="ProjectNametxt" runat="server" type="text" class="form-control" ></asp:TextBox>


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

	</form>
</body>
</html>
