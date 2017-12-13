<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="iWork.Staff_Member.Dashboard.Index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">

        <asp:Panel id="HR_Tasks_Panel" runat="server" Visible="false">

            <h3>HR tasks</h3>
            
            <ul>
                <li><a href="../HR_Employee/Jobs/ViewJobs.aspx">Manage Jobs</a></li>
                <li><a href="../HR_Employee/Jobs/QuestionsLibrary.aspx">Library of Interview Questions</a></li>
                <li><a href="../HR_Employee/Announcements/Post_Announcement.aspx">Post Announcement</a></li>
                <li><a href="../HR_Employee/Requests/Manage_Requests.aspx">Review pending Requests</a></li>
                <li><a href="../HR_Employee/Attendance/ViewStaffAttendance.aspx">View Staff Attendance</a></li>
                <li><a href="../HR_Employee/Attendance/EmployeeOfTheMonth.aspx">Regular Employees of the Month</a></li>
            </ul>

        </asp:Panel>

    </form>
</body>
</html>