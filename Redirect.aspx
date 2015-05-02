<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Redirect.aspx.vb" Inherits="Essentials.Redirect" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

   
    <title>MYOB Sample WebApp</title>
       <link href="css/bootstrap.min.css" rel="stylesheet"/>
    <link href="css/view.css" rel="stylesheet" />
    <script src="Scripts/view.js"></script>
    <link href="css/spinner.css" rel="stylesheet"/>
<script src="app.js" type="text/javascript">
</script>
    <script src="https://code.jquery.com/jquery-2.1.3.js"></script>
    
        <script>
            $(document).ready(function () {

                $("#btn").click(function () {
                    $.ajax({
                        url: "https://api.myob.com/accountright/",
                        headers: {
                            "Authorization": "Bearer " + $("#hdnAccessToken").val(),
                            "x-myobapi-key": "YOUR_Key",
                            "x-myobapi-version": "v2"
                        },
                        method: "GET",
                        success: function (data) {
                             populateCompany(data);
                         
                        },
                        beforeSend: function(){
                            $('.loader').show()
                        },
                        complete: function(){
                            $('.loader').hide();
                        },
                       
                        error: function (err) {
                            var x = "";
                        }
                    });
                    return false;
                });
            });

            function populateCompany(x) {
               showCompanyTable();
              

                var cf = document.getElementById("companyTable");
                
                var index;

                $(x).each(function (i, e) {
                    var row = cf.insertRow();
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);


                    cell1.innerHTML = e.Name;
                    cell2.innerHTML = e.ProductVersion;



                });
              
               
                getItems(x, "companyTable");
                 
            }


            function populateContact(companyUID, x, companyName) {
                showContactTable(companyName);
               

                var cT = document.getElementById("contactTable");

                $(x).each(function (i, e) {
              
                    if (e.IsIndividual) {
                   
                        var row = cT.insertRow();
                        var cell1 = row.insertCell(0);
                        var cell2 = row.insertCell(1);
                        var cell3 = row.insertCell(2);
                        var cell4 = row.insertCell(3);

                        
                            cell1.innerHTML = e.FirstName;
                            cell2.innerHTML = e.LastName;
                            cell3.innerHTML = e.CurrentBalance;
                            cell4.innerHTML = e.Type;
                        }


                       
                });
               // alert(companyUID);
                document.getElementById("createCustomer").onclick = function () {
                    // alert(companyUID);
                    document.getElementById("companyTable").style.display = "none";
                    document.getElementById("contactTable").style.display = "none";
                    document.getElementById("createCustomer").style.display = "none";
                    var head = document.getElementById("myHeader");
                    head.innerHTML = "Create new customer for: " + companyName;
                    document.getElementById("form_container").style.display = "block";

                    $('#frmNewCust').submit(processForm(companyUID));
                }
                
            }


            function showContactTable(companyName) {
               
                    document.getElementById("companyTable").style.display = "none";
                    document.getElementById("contactTable").style.display = "table";
                    var head = document.getElementById("myHeader");
                    head.innerHTML = "Current Individuals In " + companyName;
                    document.getElementById("createCustomer").style.display = "block";
                    

                }
    

    

                function showCompanyTable() {
               
                    document.getElementById("contactTable").style.display = "none";
                    document.getElementById("companyTable").style.display = "table";
                    var head = document.getElementById("myHeader");
                    head.innerHTML = "Your Company Files";
                
                }

  

                function getCustomerDetails(x,companyName) {
                    //alert(x);
                    $.ajax({
                        url: "https://api.myob.com/accountright/" + x + "/Contact/",
                        headers: {
                            "Authorization": "Bearer " + $("#hdnAccessToken").val(),
                            "x-myobapi-key": "YOUR_KEY",
                            "x-myobapi-version": "v2",
                            "x-myobapi-cftoken": "BASE64Encoded_UserName_And_Password"
                        },
                        method: "GET",
                        success: function (data) {
                           
                            var contacts = data.Items
                       

                            populateContact(x,contacts, companyName);
                        
                        },
                        beforeSend: function () {
                            $('.loader').show()
                        },
                        complete: function () {
                            $('.loader').hide();
                        },
                        error: function (err) {
                            var x = "JTO JTO JTO";
                            alert(x)
                        }
                    });
                    return false;
                };


                function processForm(x) {
                    //alert(x);
                    $.ajax({
                        url: "https://api.myob.com/accountright/" + x + "/Contact/Customer",
                        headers: {
                            "Authorization": "Bearer " + $("#hdnAccessToken").val(),
                            "x-myobapi-key": "YOUR_KEY",
                            "x-myobapi-version": "v2",
                            "x-myobapi-cftoken": "BASE64_Encoded_UsernameAndPassword"
                        },
                        method: "POST",
                        contentType: 'application/x-www-form-urlencoded',
                        data: $(this).serialize(),
                        success: function (data) {

                            var contacts = data.Items


                            //populateContact(x, contacts, companyName);

                        },
                        beforeSend: function () {
                            $('.loader').show()
                        },
                        complete: function () {
                            $('.loader').hide();
                        },
                        error: function (err) {
                            var x = "JTO JTO JTO";
                            alert(x)
                        }
                    });
                    //  return false;
                 //   $('#frmNewCust').submit(createCustomer);
                };

                                
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
  <div class="page-header">
        <h1 id ="myHeader" align="center">
            Your Company Files</h1>
      </div>
                      <button style="display:none; position:absolute; left:1345px; top:155px;" class="btn btn-primary" id="createCustomer" onclick="">Create a New Customer</button>
                                              <%--<button style="position:absolute; left:1450px; top:50px;" class="btn btn-primary" id="back" onClick="history.go(-1); return true;">Back</button>--%>

    <form id="form1" runat="server">
    <div>
    
    </div>
        <!-- setup top of table -->
        <table  style= " display:none; cursor: pointer;" id="companyTable" class="table table-striped table-bordered table-hover table-condensed"  runat="server" >
      
              <thead>
              <tr>
                
                <th>Company File Name</th>
                <th>Product Version</th>
                
              </tr>
            </thead>




        </table>
          <table  style= " display:none; cursor: pointer;" id="contactTable" class="table table-striped table-bordered table-hover table-condensed"  runat="server" >
      
              <thead>
              <tr>
                
                <th>First Name</th>
                <th>Last Name</th>
                  <th>Current Balance</th>
                <th>Type</th>


                
              </tr>
            </thead>




        </table>

      










                <asp:HiddenField ID="hdnAccessToken" runat="server" />
        <button class="btn btn-primary" id="btn">Click Me To View Your Company Files</button> 


</body>
</html>



