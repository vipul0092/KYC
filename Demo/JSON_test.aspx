<%@ Page Language="C#" AutoEventWireup="true" CodeFile="JSON_test.aspx.cs" Inherits="Demo_jQueryTest" %>
<%@ Register Src="~/Controls/RateComment.ascx" TagPrefix="my" TagName="rComment" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>jQuery Test</title> 
    <style type="text/css">
        .PleaseWait {
            height: 32px;
            width: 500px;
            background-image: url('../Images/PleaseWait.gif');
            background-repeat: no-repeat;
            padding-left: 40px;
            line-height: 32px; 
        }
    </style>
    <script type="text/javascript" src="../Scripts/jquery-2.0.2.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server" ID="scm" EnablePageMethods="true">
        </asp:ScriptManager>
    <input value="How You Doin' ?" placeholder="Enter Your Name" runat="server" clientidmode="static" type="text" id="jsonInput" /><input runat="server" clientidmode="static" type="button" value="Press For JSON Test" id="jsonBtn" />
    <br />
    <label id="jsonResult" runat="server" clientidmode="static"></label>
    <br />
        <div id="wait"></div>
        <script type="text/javascript">
    function HelloWorld()
    {
        $('#jsonInput').fadeOut('slow'); $('#jsonBtn').fadeOut('slow');
        $('#wait').addClass('PleaseWait').html(' Please Wait...');
       
    var yourName = $get('jsonInput').value;
    PageMethods.sendHelloToPage(yourName, HelloWorldCallback);
    }
    function HelloWorldCallback(result)
    {
        $('#wait').fadeOut('slow');
        $('#jsonResult').delay(3000).html(result);
    }
    $addHandler($get('jsonBtn'), 'click', HelloWorld);
    </script>
    </form>
</body>
</html>
