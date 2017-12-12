<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="iWork.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>iWork</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h1>iWork</h1>
            <hr />
        </div>

        <h3>Register</h3>

        <table>
            <tr>
                <td>Username: </td>
                <td><asp:TextBox id="Username_TextBox" runat="server" /></td>
            </tr>
            <tr>
                <td>Password: </td>
                <td><asp:TextBox id="Password_TextBox" runat="server" TextMode="Password" /></td>
            </tr>
        </table>

        <br />

        <table>
            <tr>
                <td>First Name: </td>
                <td><asp:TextBox id="FirstName_TextBox" runat="server" AutoCompleteType="FirstName" /></td>
            </tr>
            <tr>
                <td>Middle Name: </td>
                <td><asp:TextBox id="MiddleName_TextBox" runat="server" AutoCompleteType="MiddleName" /></td>
            </tr>
            <tr>
                <td>Last Name: </td>
                <td><asp:TextBox id="LastName_TextBox" runat="server" AutoCompleteType="LastName" /></td>
            </tr>
        </table>

        <br />

        <table>
            <tr>
                <td>Email: </td>
                <td><asp:TextBox id="Email_TextBox" runat="server" AutoCompleteType="Email" /></td>
            </tr>
        </table>

        <br />

        <table>
            <tr>
                <td>Birth Date: </td>
                <td><asp:TextBox id="BirthDate_TextBox" runat="server" TextMode="Date"/></td>
            </tr>
        </table>

        <table>
            <tr>
                <td>Years of Experience: </td>
                <td><asp:TextBox id="YearsOfExperience_TextBox" runat="server" TextMode="Number"/></td>
            </tr>
        </table>

        <br />

        <asp:Button id="Register_Button" runat="server" Text="Register" OnClick="Register_Button_Click" />

        <footer />
    </form>
</body>
</html>