<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterPage_sub.master" AutoEventWireup="true" CodeFile="Reviews.aspx.cs" Inherits="View_Reviews" %>
<%@ Register Src="~/Controls/RateComment.ascx" TagPrefix="my" TagName="rateComment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    
    <link href="../Scripts/Styles.css" rel="stylesheet" />
    <style type="text/css">
        .PleaseWait {
            height: 32px;
            width: 500px;
            background-image: url('../Images/PleaseWait.gif');
            background-repeat: no-repeat;
            padding-left: 40px;
            line-height: 32px; 
        }
        #shownInfo {
            text-decoration: none; color: #009933;  text-shadow: 1px 1px 1px #000; font-weight: bold; background-color: #f5edad; border-radius: 3px 3px;
            border:thin solid #726a6a;
        }
        .more {
            text-decoration: none;
            color: #0B2896;
        }
        .more:hover {
            background-color: #e6a574;
            color: #000;
         }
        .border {
            border-radius:3px 4px;border-style: solid; border-width: thin; padding: 5px;
        }
        .btnEnable {
            height: 40px; background-color: #ef1818;
            border-radius: 6px 6px; color: #FFF;
        }
        .btnEnable:hover {
            text-shadow: 1px 1px 2px #726a6a;
        }
        .btnDisable {
            height: 40px; background-color: #bdaf92;
            border-radius: 6px 6px; color: #000;
        }
        .auto-style6 {
            height: 37px;
            font-size: 30px;
            text-align: center; color: #663300; font-weight: 600; border-bottom-style: solid; border-bottom-width: medium;
        }
        .revText {
            height: 100px; width: 400px;
            padding-left: 7px; padding-right: 7px;
            border-radius: 4px 6px; background-color: #ccd39c;
        }
        .auto-style7 {
            height: 23px;
        }
        #date {
            text-align: right;
        }
        .selected {
            border-width: thin; border-style: solid; background-color: #FFFCBF
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpMainContent" Runat="Server">
<asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true">
    <Scripts><asp:ScriptReference Path="~/Scripts/jquery-1.4.1.min.js" /></Scripts>
</asp:ScriptManager>
    <table style="margin: 0px 0px 0px 30px"><tr><td><div style="float:left">
    <table runat="server" style="border: thin solid #996633; border-radius:5px 6px ;float:left" id="showTable" clientidmode="static">
        <tr><td class="centerAlign"><table runat="server" id="reviewTopTable"><tr><td class="auto-style6" >Review For A Specific Company!</td></tr></table></td><td style="text-align: right"><input clientidmode="static" class="btnEnable" type="button" runat="server" id="viewMore" onserverclick="viewMore_ServerClick" value="View More Reviews" /></td></tr>
        <tr><td colspan="2"><textarea class="revText" runat="server" id="reviewText" value="The review text as submitted by a user shall be displayed here to the visitor." lang="en" readonly="readonly"></textarea></td></tr>
        <tr><td><my:rateComment ID="commentRate" runat="server"/></td><td clientidmode="static" runat="server" id="date">Submitted On: 00-00-0000</td></tr>
    </table></div>
    <div style="padding: 0px 0px 0px 40px; float: left"><asp:UpdatePanel ClientIDMode="Static" runat="server" ID="moreReviews"><ContentTemplate><table visible="false" align="center" runat="server" id="moreRevTable" style="margin:10px 0px 0px 0px ;border-spacing: 5px 5px;border-radius: 5px 6px;border: medium solid #3366FF">
        <tr><td></td></tr>
        <tr><td></td></tr>        
        <tr><td></td></tr>        
        <tr><td></td></tr>        
        <tr><td></td></tr>        
        <tr><td></td></tr>        
        <tr><td></td></tr>        
        <tr><td></td></tr>        
        <tr><td></td></tr>        
        <tr><td></td></tr>
        <tr><td><table align="center" runat="server" id="moreRevNum"><tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr></table></td></tr>
    </table></ContentTemplate></asp:UpdatePanel><asp:UpdateProgress AssociatedUpdatePanelID="moreReviews" runat="server" ID="moreRevProgress"><ProgressTemplate><div class ="PleaseWait">Please Wait...</div></ProgressTemplate></asp:UpdateProgress></div></td></tr></table>
</asp:Content>
<asp:Content ID="Scripts" ContentPlaceHolderID="cpScriptContent" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $('#shownInfo').delay(1000).slideUp('slow', done);
            function done() {
                document.getElementById('shownInfo').innerHTML = "";
            }
        });
    </script>
</asp:Content>

