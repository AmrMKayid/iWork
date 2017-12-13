<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Manage_Requests.aspx.cs" Inherits="iWork.Staff_Member.HR_Employee.Requests.Manage_Requests" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h1>iWork</h1>
            <hr />
        </div>

        <div>
            <h3>Leave Requests</h3>
            <br />

            <asp:GridView ID="Leave_Requests_GridView" runat="server" OnRowCommand="Requests_GridView_RowCommand" />

            <br />

            <h3>Business Trip Requests</h3>
            <br />

            <asp:GridView ID="Business_Trip_Requests_GridView" runat="server" OnRowCommand="Requests_GridView_RowCommand" />

        </div>

        <footer>
            <br /><hr /><br />
            <a>About iWork</a> |
            <a>Privacy Policy</a> |
            <a>Terms and Conditions</a>
            <br />
            <p>Copyright (c) Team 45</p>
        </footer>
    </form>
</body>
</html>