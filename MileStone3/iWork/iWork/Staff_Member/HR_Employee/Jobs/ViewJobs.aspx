<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewJobs.aspx.cs" Inherits="iWork.Staff_Member.HR_Employee.Jobs.ViewJobs" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>View Jobs - iWork</title>
    <meta name="viewport" content="width=device-width" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h1>iWork</h1>
            <hr />
        </div>

        <div>
            <h3>Jobs</h3>

            <asp:GridView id="Jobs_GridView" runat="server" OnRowCommand="Jobs_GridView_RowCommand" />

            <br />
        </div>

        <div>
            <h3>New Job</h3>

            <table>
                <tr>
                    <td><asp:Label id="JobRole_Label" runat="server" Text="Role: " /></td>
                    <td colspan="2">
                        <asp:DropDownList id="JobRole_DropdownList" runat="server">
                            <asp:ListItem Text="Regular Employee" Value="Regular Employee" />
                            <asp:ListItem Text="Manager" Value="Manager" />
                            <asp:ListItem Text="HR Employee" Value="HR Employee" />
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td><asp:Label id="JobTitle_Label" runat="server" Text="Title: " /></td>
                    <td colspan="2"><asp:TextBox id="JobTitle_TextBox" runat="server" /></td>
                </tr>
                <tr>
                    <td><asp:Label id="WorkingHours_Label" runat="server" Text="Working Hours: " /></td>
                    <td colspan="2"><asp:TextBox id="WorkingHours_TextBox" runat="server" TextMode="Number" /></td>
                </tr>
                <tr>
                    <td><asp:Label id="Salary_Label" runat="server" Text="Salary: " /></td>
                    <td colspan="2"><asp:TextBox id="Salary_TextBox" runat="server" TextMode="Number" /></td>
                </tr>
                <tr>
                    <td><asp:Label id="MinYearsOfXp_Label" runat="server" Text="Minimum Years of Experience: " /></td>
                    <td colspan="2"><asp:TextBox id="MinYearsOfXp_TextBox" runat="server" TextMode="Number" /></td>
                </tr>
                <tr>
                    <td><asp:Label id="Vacancy_Label" runat="server" Text="Vacancy: " /></td>
                    <td colspan="2"><asp:TextBox id="Vacancy_TextBlock" runat="server" TextMode="Number" /></td>
                </tr>
                <tr>
                    <td><asp:Label id="Deadline_Label" runat="server" Text="Deadline: " /></td>
                    <td colspan="2"><asp:TextBox id="Deadline_TextBox" runat="server" TextMode="DateTime" /></td>
                </tr>
                <tr>
                    <td><asp:Label id="Job_ShortDesc_Label" runat="server" Text="Short Description: " /></td>
                    <td colspan="4">
                        <asp:TextBox id="Job_ShortDesc_TextBox" runat="server"
                            MaxLength="100" Wrap="true" TextMode="MultiLine" />
                    </td>
                </tr>
                <tr>
                    <td><asp:Label id="Job_DetailDesc_Label" runat="server" Text="Detailed Description: " /></td>
                    <td colspan="4">
                        <asp:TextBox id="Job_DetailDesc_TextBox" runat="server" Wrap="true" TextMode="MultiLine" />
                    </td>
                </tr>
                <tr />
                <tr>
                    <td colspan="3">
                        <asp:Button id="Submit_Button" runat="server" Text="Submit" OnClick="Submit_Button_Click" />
                    </td>
                </tr>
            </table>
            
        </div>

        <footer />
    </form>
</body>
</html>