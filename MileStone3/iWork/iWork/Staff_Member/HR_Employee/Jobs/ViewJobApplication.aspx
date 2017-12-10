<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewJobApplication.aspx.cs" Inherits="iWork.Staff_Member.HR_Employee.Jobs.ViewJobApplication" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Viewing Job Application - iWork</title>
    <meta name="viewport" content="width=device-width" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h1>iWork</h1>
            <hr />
        </div>

        <div>

            <h3>Application</h3>

            <table>
                <tr>
                    <td>ID: </td>
                    <td><asp:Label id="ApplicationID_Label" runat="server" /></td>
                </tr>
                <tr>
                    <td>Score: </td>
                    <td><asp:Label id="Score_Label" runat="server" /></td>
                </tr>
            </table>

            <br />
            <h3>Applicant</h3>

            <asp:DetailsView id="Applicant_DetailsView" runat="server" />

            <div>
                <asp:Panel id="CurrentEmployment_Panel" runat="server" Visible="false">
                    <h4>Current Employment</h4>

                    <asp:GridView id="CurrentJob_DetailsView" runat="server" />

                </asp:Panel>
            </div>

            <h4>Previous Job Titles</h4>
            <asp:GridView id="Applicant_PrevJobTitles_GridView" runat="server" />

            <br />
            <h3>Job</h3>

            <asp:DetailsView id="Job_DetailsView" runat="server" />

            <br />
            <br />

            <asp:GridView id="Response_GridView" runat="server" OnRowCommand="Response_GridView_RowCommand" />
            
        </div>

        <footer />
    </form>
</body>
</html>