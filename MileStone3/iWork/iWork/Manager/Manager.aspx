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

			
        <!--################################## Requests ################################################-->    

		<div>
           <asp:Button runat="server" ID="NewRequests" Text="Requests" onclick="ViewNewRequests" type="submit" class="btn btn-info"></asp:Button>				
        </div>

			
		<!--################################## Applications ################################################-->

        <div>
            <asp:Button runat="server" ID="NewApplications" Text="Applications" onclick="ViewNewApplications" type="submit" class="btn btn-info"></asp:Button>
        </div>

		<!--################################## Projects ################################################-->

        <asp:Button runat="server" ID="NewProject" Text="New Project" onclick="NewProjectClicked" type="submit" class="btn btn-info"></asp:Button>

		
	</form>
</body>
</html>
