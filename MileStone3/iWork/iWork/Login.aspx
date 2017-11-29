<%@ Page Language="C#" Inherits="iWork.Login" %>
<!DOCTYPE html>
<html>
<head runat="server">
	<title>Login</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

</head>
<body>
	<form id="form1" runat="server">
			
		<div class="form-group">
            <asp:Label ID="lbl_username" runat="server" Text="Username: "></asp:Label>
        
            <asp:TextBox ID="txt_username" runat="server" type="text" class="form-control"></asp:TextBox>
        </div>
			
        <br />
				
		<div class="form-group">
            <asp:Label ID="lbl_password" runat="server" Text="Password: "></asp:Label>
            <asp:TextBox ID="txt_password" runat="server" TextMode="Password" type="password" class="form-control" ></asp:TextBox>
        
            <br />
            <asp:Button ID="btn_login" runat="server" Text="Login" onclick="login" type="submit" class="btn btn-info"/>
        </div>

     </form>
</body>
</html>
