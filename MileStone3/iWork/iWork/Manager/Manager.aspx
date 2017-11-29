<%@ Page Language="C#" Inherits="iWork.Manager" %>
<!DOCTYPE html>
<html>
<head runat="server">
	<title>Manager</title>
</head>
<body>
	<form id="form1" runat="server">
		<div>
             <asp:Label runat="server" Text="Manager "></asp:Label>

             <asp:Button runat="server" ID="NewRequests" Text="Requests" onclick="ViewNewRequests"></asp:Button>

			<asp:GridView ID="grdloadproperties" runat="server"></asp:GridView>

				
        </div>
	</form>
</body>
</html>
