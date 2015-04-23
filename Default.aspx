<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Default.aspx.vb" Inherits="EssentialsApp._Default" %>

<!DOCTYPE html>

<html xmlns="http:'www.w3.org/1999/xhtml">
<head runat="server">
    <title id="theTitle"></title>

    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <script src="app.js" type="text/javascript">
    </script>
    <link rel="stylesheet" href="http://getbootstrap.com/dist/css/bootstrap.min.css" />
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
    <script src="https://code.jquery.com/jquery-2.1.3.js"></script>
    <script type="text/javascript">

        function Redirect() {
            window.location = " https://secure.myob.com/oauth2/account/authorize?client_id=YOUR_API_KEY&redirect_uri=http%3A%2F%2Flocalhost%3A8107%2FRedirect.aspx&response_type=code&scope=la.global";
        }
    </script>











</head>
<body>
    <nav role="navigation" class="navbar navbar-default navbar-static-top">
        <div class="container-fluid">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" data-target="#navbarCollapse" data-toggle="collapse" class="navbar-toggle">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a href="#" class="navbar-brand">MYOB API</a>
            </div>
            <!-- Collection of nav links and other content for toggling -->
            <div id="navbarCollapse" class="collapse navbar-collapse">
                <ul class="nav navbar-nav">
                    <li class="active"><a href="#">Home</a></li>
                    <li><a href="#">Profile</a></li>
                    <li><a href="#">Messages</a></li>
                </ul>
                <ul class="nav navbar-nav navbar-right">
                    <li><a href="#">Login</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <a href="http://developer.myob.com/">
        <img class="img-responsive" alt="MYOB_LOGO" style="position:absolute; top:55px; left:0px;" longdesc="MYOB_LOGO" src="images/MYOB-LOGO.png" />&nbsp;
    </a>
    <div class="container">

        <div <%--style="padding-top: -10px; top:15px; position:absolute;" --%>class="jumbotron">
    <h1>Welcome To MYOB Sample Web App</h1>
    <p>This App demonstrates how easy it is to consume the MYOB Essentials API. All code used to develop this app has been made available for your use. let's do this!</p>
  </div>
        <p>Click the button below to begin the OAuth process.</p>

    </div>

    <form id="form1" runat="server">

        <div class="col-md-4 text-center">
            <button type="button" class="btn btn-primary" onclick="Redirect()">Let's Begin!</button>
        </div>

    </form>
</body>
</html>
