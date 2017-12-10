<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EmployeeOfTheMonth.aspx.cs" Inherits="iWork.Staff_Member.HR_Employee.Attendance.EmployeeOfTheMonth" %>

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

        <h3>Top 3 Regular Employees of the Month</h3>

        <table>
            <tr>
                <td>Month: </td>
                <td>
                    <asp:DropDownList id="Month_DropDownList" runat="server">
                        <asp:ListItem Text="January" Value="1" />
                        <asp:ListItem Text="February" Value="2" />
                        <asp:ListItem Text="March" Value="3" />

                        <asp:ListItem Text="April" Value="4" />
                        <asp:ListItem Text="May" Value="5" />
                        <asp:ListItem Text="June" Value="6" />

                        <asp:ListItem Text="July" Value="7" />
                        <asp:ListItem Text="August" Value="8" />
                        <asp:ListItem Text="September" Value="9" />

                        <asp:ListItem Text="October" Value="10" />
                        <asp:ListItem Text="November" Value="11" />
                        <asp:ListItem Text="December" Value="12" />
                    </asp:DropDownList>
                </td>
                <td><asp:TextBox id="Year_TextBox" runat="server" TextMode="Number" /></td>
                <td><asp:Button id="View_Button" runat="server" Text="View" OnClick="View_Button_Click" /></td>
            </tr>
        </table>

        <br />

        <asp:GridView id="TopAchievers_GridView" runat="server" />

        <br />

        <asp:Button id="Congratulate_Button" runat="server" Text="Congratulate" Visible="false" OnClick="Congratulate_Button_Click" />

        <footer />
    </form>
</body>
</html>