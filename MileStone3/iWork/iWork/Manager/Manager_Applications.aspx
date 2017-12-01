<%@ Page Language="C#" Inherits="iWork.Manager.Manager_Applications" %>
<!DOCTYPE html>
<html>
<head runat="server">
	<title>Manager_Applications</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

</head>
<body>
	<form id="ApplicationGridForm" runat="server">

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
                
    </form>
</body>
</html>
