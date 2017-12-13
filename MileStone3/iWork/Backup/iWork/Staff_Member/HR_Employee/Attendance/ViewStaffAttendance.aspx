<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewStaffAttendance.aspx.cs" Inherits="iWork.Staff_Member.HR_Employee.Attendance.ViewStaffAttendance" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>View Staff Attendance - iWork</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h1>iWork</h1>
            <hr />
        </div>

        <asp:Label id="ChooseStaffMember_Label" runat="server" Text="Display attendance of: " />
        <asp:DropDownList id="ChooseStaffMember_DropDownList" runat="server" />
        <asp:Button id="ChooseStaffMember_Button" runat="server" Text="View" OnClick="ChooseStaffMember_Button_Click" />

        <br />
        <br />

        <table>
            <tr>
                <td>From: </td>
                <td><asp:TextBox id="AttendanceFrom_TextBox" runat="server" TextMode="DateTime" /></td>
            </tr>
            <tr>
                <td>To: </td>
                <td><asp:TextBox id="AttendanceTo_TextBox" runat="server" TextMode="DateTime" /></td>
                <td><asp:Button runat="server" Text="View" OnClick="ChooseStaffMember_Button_Click" /></td>
            </tr>
        </table>

        <br />

        <asp:GridView id="AttendanceInRange_GridView" runat="server" />

        <br />

        <h3>Attended hours per month</h3>

        <table>
            <tr>
                <td>Year: </td>
                <td><asp:TextBox id="AttendanceOfYear_TextBox" runat="server" TextMode="Number" /></td>
                <td><asp:Button runat="server" Text="View" OnClick="ChooseStaffMember_Button_Click" /></td>
            </tr>
        </table>

        <br />

        <asp:GridView id="AttendanceOfYear_GridView" runat="server" />

        <footer />
    </form>
</body>
</html>