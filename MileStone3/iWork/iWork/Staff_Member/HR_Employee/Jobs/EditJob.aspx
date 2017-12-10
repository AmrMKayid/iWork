<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditJob.aspx.cs" Inherits="iWork.Staff_Member.HR_Employee.Jobs.EditJob" %>

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

            <h3>Job Details</h3>

            <table>
                <tr>
                    <td><asp:Label id="JobTitle_Label" runat="server" Text="Title: " /></td>
                    <td colspan="2"><asp:TextBox id="JobTitle_TextBox" runat="server" ReadOnly="true" /></td>
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
                        <asp:Button id="Save_Button" runat="server" Text="Save Changes" OnClick="Save_Button_Click"/>
                    </td>
                </tr>
            </table>

            <br />

            <h3>Interview</h3>

            <asp:GridView id="JobQuestions_GridView" runat="server" OnRowCommand="JobQuestions_GridView_RowCommand" />

            <br />
            <h4>Add Question</h4>

            <table>
                <tr>
                    <td><asp:DropDownList id="NewQuestion_DropDownList" runat="server" /></td>
                    <td><asp:Button id="AddQuestion_Button" runat="server" Text="Add" OnClick="AddQuestion_Button_Click" /></td>
                </tr>
            </table>

            <h3>Applications</h3>

            <asp:GridView id="Applications_GridView" runat="server" OnRowCommand="Applications_GridView_RowCommand" />

        </div>

        <footer />
    </form>
</body>
</html>
