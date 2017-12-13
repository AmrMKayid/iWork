<%@ Page Language="C#" Inherits="iWork.DefaultSigned" EnableEventValidation="false" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <title>iWork</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
<!--    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">-->

    <link href="DefaultStyle/css/bootstrap.min.css" rel="stylesheet">
        
     <style>
        .navbar-brand {

                  font-size:1.8em;
        }
        #topContainer {
              background-image:url("DefaultStyle/resources/background.png");
              height:500px;
              width:100%;
              background-size:cover;
              }
        #topRow {
              margin-top:100px;
              text-align:center;
        }
        #topRow h1 {
              font-size:300%;
        }
        #emailSignup {
              margin-top:50px;
        }
        .bold {
              font-weight:bold;
        }
        .marginTop {

                      margin-top:30px;
            }
            .center {
                  text-align:center;
        }
            .title {
                  margin-top:100px;
                  font-size:300%;
            }
            #footer {
                  background-color:#B0D1FB;
                  padding-top:70px;
                  width:100%;
        }
            .marginBottom {
                  margin-bottom:30px;
            }
            .appstoreImage {
                  width:250px;
        }
        .playstoreImage {
          width: 250px;
        }
  </style>

</head>
<body>
    <form id="form1" runat="server">
      <div class="navbar navbar-default navbar-fixed-top">
      <div class="container">

            <div class="navbar-header">
                  <button class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                  </button>

                  <a class="navbar-brand">iWork</a>
            </div>

            <div class="collapse navbar-collapse">
                  <ul class="nav navbar-nav">
                        <li class="active"><a href="Default.aspx">Home</a></li>
<!--                        <li><a href="default.aspx">Profile</a></li>-->
                        <li><a href="Home/Companies.aspx">Companies</a></li>
                        <li><a href="#details">Jobs</a></li>
                        <li><a href="#footer">Download The App</a></li>

                    </ul>

                    <form>
                     <asp:Button ID="logoutBtn" runat="server" Text="Log Out" onclick="logoutBtn_Clicked" type="submit" class="btn btn-success navbar-form navbar-right" Style="height:37px; "/>
                    <asp:Button ID="profileBtn" runat="server" Text="Profile" onclick="profileBtn_Clicked" type="submit" class="btn btn-success navbar-form navbar-right" Style="height:37px; margin-right:5px"/>

                   </form>

                  </div>
            </div>
      </div>

      <div class="container contentContainer" id="topContainer">
        <div class="row">
              <div class="col-md-6 col-md-offset-3" id="topRow">
              <h1 class="marginTop" style="color: #88D8C0;">Welcome to iWork</h1>
              <p class="lead">This is why should download this fantastic app.</p>
                <p>Some more information about the app. You can go into a little more detail here if you want to.</p>
                <p class="bold marginTop">Want to Search for a JOB ?!</p>

            </div>
        </div>
    </div>

    <div class="container contentContainer" id="details">
        <div class="row center">
              <h1 class="center title">Why iWork Is Awesome</h1>
              <p class="lead center">Summary of iWork's awesomeness</p>
        </div>

        <div class="row  marginBottom">
                  <div class="col-md-4 marginTop">

                    <!-- Search iCon -->
                  <h2><span class="glyphicon glyphicon-search"></span> Search for Jobs</h2>
                  <p>A brief description of one of the best features of your app.
      Maybe a little more text. A brief description of one of the best features of
      your app. Maybe a little more text.</p>
<!--                  <asp:Button ID="singupBtn1" runat="server" Text="Sing Up!" onclick="singup_Clicked" type="submit" class="btn btn-success"/>-->
        </div>

        <div class="col-md-4 marginTop">
                    <h2><span class="glyphicon glyphicon-pencil"></span> Apply for Jobs</h2>
                    <p>A brief description of one of the best features of your app.
        Maybe a little more text. A brief description of one of the best features of
        your app. Maybe a little more text.</p>
<!--                    <asp:Button ID="singupBtn2" runat="server" Text="Sing Up!" onclick="singup_Clicked" type="submit" class="btn btn-success"/>-->
        </div>

        <div class="col-md-4 marginTop">
                    <h2><span class="glyphicon glyphicon-user"></span> Get Hired immediately</h2>
                    <p>A brief description of one of the best features of your app.
        Maybe a little more text. A brief description of one of the best features of
        your app. Maybe a little more text.</p>
<!--                    <asp:Button ID="singupBtn3" runat="server" Text="Sing Up!" onclick="singup_Clicked" type="submit" class="btn btn-success"/>-->
        </div>

        </div>
    </div>

    <div class="container contentContainer" id="footer">
        <div class="row">
              <h1 class="center title">Download The App!</h1>
              <p class="lead center">Really, why should I download this app?</p>
              <p class="center"><img src="DefaultStyle/resources/appstore.png" class="appstoreImage" />
              <p class="center"><img src="DefaultStyle/resources/playstore.png" class="playstoreImage" />
        </div>
    </div>


            <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/
        jquery.min.js"></script>
            <!-- Include all compiled plugins (below), or include individual files as
        needed -->
        <script src="DefaultStyle/js/bootstrap.min.js"></script>
        <script>
          $(".contentContainer").css("min-height",$(window).height());

        </script>
    </form>
</body>
</html>
