<%@ Page Language="C#" Inherits="iWork.Manager.Manager_Requests" %>
<!DOCTYPE html>
<html>
<head runat="server">
	<title>Manager_Requests</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
		
</head>
<body>
	<form id="RequestsGridForm" runat="server">
    
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
                            <ItemTemplate> 
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
			
	</form>
</body>
</html>
