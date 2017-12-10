<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Post_Announcement.aspx.cs" Inherits="iWork.Staff_Member.HR_Employee.Announcements.Post_Announcement" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>New Announcement - iWork</title>
    <meta name="viewport" content="width=device-width" />
</head>
<body>
    <form id="form1" runat="server">

        <div>
            <h1>iWork</h1>
            <hr />
        </div>

        <div>

            <h2>Post new announcement</h2><br />

            <asp:Label id="A_Type_Label" runat="server" Text="Type: " />
            <asp:TextBox id="A_Type_TextBox" runat="server" MaxLength="50" />
            <br />

            <br />
            <asp:Label id="A_Title_Label" runat="server" Text="Title: " />
            <asp:TextBox id="A_Title_TextBox" runat="server" MaxLength="50" />
            <br />

            <br />
            <asp:Label id="A_Desc_Label" runat="server" Text="Description: " />
            <asp:TextBox id="A_Desc_TextBox" runat="server" TextMode="MultiLine" Wrap="true" />
            <br />

            <br />
            <asp:Button id="PostAnnouncement_Button" runat="server" Text="Post Announcement" OnClick="PostAnnouncement_Button_Click" />

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