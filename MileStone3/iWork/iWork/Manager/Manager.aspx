﻿<%@ Page Language="C#" Inherits="iWork.Manager" %>
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
		<div>
             <asp:Label runat="server" Text="Manager "></asp:Label>

             <asp:Button runat="server" ID="NewRequests" Text="Requests" onclick="ViewNewRequests" type="submit" class="btn btn-info"></asp:Button>

			<div>  
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" CssClass="table table-striped table-bordered table-hover" EmptyDataText="There are no data records to display.">
                <Columns>  
                    <asp:BoundField DataField="username" HeaderText="username" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg"/>  
                    <asp:BoundField DataField="request_date" HeaderText="Request Date" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg"/>  
                    <asp:BoundField DataField="start_date" HeaderText="Start Date" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg"/>  
                    <asp:BoundField DataField="end_date" HeaderText="End Date" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg"/>  
                    <asp:BoundField DataField="leave_days" HeaderText="Leave Days" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg"/>  
                    <asp:BoundField DataField="hr_status" HeaderText="HR Status" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg"/>  

                    <asp:TemplateField HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg">
                        <ItemTemplate>
                            <asp:Button runat="server" HeaderText="Accept" id="Accept" CommandName="LoanItem" Text="Accept" OnClick="AcceptRequest" type="submit" class="btn btn-info"></asp:Button>    
                        </ItemTemplate>
                    </asp:TemplateField>

				    <asp:TemplateField HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg">
                        <ItemTemplate>
                            <asp:Button runat="server" HeaderText="Reject" id="Reject" CommandName="LoanItem" Text="Reject" OnClick="RejectRequest" type="submit" class="btn btn-info"></asp:Button>    
                        </ItemTemplate>
                    </asp:TemplateField>
							
                </Columns>  
            </asp:GridView>  
        </div> 


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
                                <asp:Button runat="server" HeaderText="Accept" id="Accept" CommandName="LoanItem" Text="Accept" OnClick="AcceptApplication" type="submit" class="btn btn-info"></asp:Button>    
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg">
                            <ItemTemplate>
                                <asp:Button runat="server" HeaderText="Reject" id="Reject" CommandName="LoanItem" Text="Reject" OnClick="RejectApplication" type="submit" class="btn btn-info"></asp:Button>    
                            </ItemTemplate>
                        </asp:TemplateField>
						
                    </Columns>
                </asp:GridView>  
           </div>
                
		
		</div>

		</div>
	</form>
</body>
</html>
