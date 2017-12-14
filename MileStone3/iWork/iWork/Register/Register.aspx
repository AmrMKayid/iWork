<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="iWork.Register.Register" %>

<!DOCTYPE html>

<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head>
      <meta charset="UTF-8"/>
    <title>Join iWork</title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <link href='https://fonts.googleapis.com/css?family=Roboto:400,700' rel='stylesheet' type='text/css'/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css"/>


      <link rel="stylesheet" href="css/style.css"/>
</head>
<body>
    <form id="form1" runat="server">
          <div class="user">
    <header class="user__header">
        <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/3219/logo.svg" alt="" />
        <h1 class="user__title">Welcome to iWork | Sign Up!</h1>
    </header>

              <br />
              <br />
    <%--<form class="form">--%>
        <div class="form__group">
            <input id="Username_TextBox" runat="server" type="text" placeholder="Username" class="form__input" />
        </div>

        <div class="form__group">
            <input id="Password_TextBox" runat="server" type="password" placeholder="Password" class="form__input" />
        </div>

        <div class="form__group">
            <input id="Email_TextBox" runat="server" type="email" placeholder="Email" class="form__input" />
        </div>

        <div class="form__group">
            <input id="FirstName_TextBox" runat="server" type="text" placeholder="First Name" class="form__input" />
        </div>

        <div class="form__group">
            <input id="MiddleName_TextBox" runat="server" type="text" placeholder="Middle Name" class="form__input" />
        </div>

        <div class="form__group">
            <input id="LastName_TextBox" runat="server" type="text" placeholder="Last Name" class="form__input" />
        </div>

        <div class="form__group">
            <input id="BirthDate_TextBox" runat="server" type="text" placeholder="Birth Date" class="form__input" />
        </div>

        <div class="form__group">
            <input id="YearsOfExperience_TextBox" runat="server" type="text" placeholder="Years of Experience" class="form__input" />
        </div>



        <asp:Button ID="Register_Button" runat="server" Text="Register" CssClass="btn" OnClick="Register_Button_Click" />
    <%--</form>--%>
</div>
  <script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>

    <script  src="js/index.js"></script>
    </form>
</body>
</html>