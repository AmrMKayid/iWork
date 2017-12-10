<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QuestionsLibrary.aspx.cs" Inherits="iWork.Staff_Member.HR_Employee.Jobs.QuestionsLibrary" %>

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

        <h3>Interview Questions Library</h3>

        <asp:GridView id="Questions_GridView" runat="server" />

        <br />

        <h3>Add Question to the Library</h3>

        <table>
            <thead>
                <tr>
                    <td colspan="4">Question</td>
                    <td>Answer</td>
                </tr>
            </thead>
            <tr>
                <td colspan="4"><asp:TextBox id="NewQuestion_TextBox" runat="server" MaxLength="100" /></td>
                <td>
                    <asp:DropDownList id="AnswerNewQ_DropDownList" runat="server">
                        <asp:ListItem Text="True / Yes" Value="True" />
                        <asp:ListItem Text="False / No" Value="False" />
                    </asp:DropDownList>
                </td>
                <td><asp:Button id="AddNewQ_Button" runat="server" Text="Add" OnClick="AddNewQ_Button_Click" /></td>
            </tr>
        </table>

        <footer />
    </form>
</body>
</html>