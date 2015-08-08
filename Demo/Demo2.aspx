<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master" AutoEventWireup="true" CodeFile="Demo2.aspx.cs" Inherits="Demo_Demo2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="../Scripts/jquery-2.0.2.min.js" type="text/javascript"></script>
    <style type="text/css">
        #Search {
            width: 225px;
        }
    </style>
     <script type="text/javascript">
         $(document).ready(
             function () {
                 //When text changes
                 $("#Button1").click(LoadData);
             });

         function LoadData() {
             $('#Search').html("Pressed!");
             $.ajax({
                 type: "POST",
                 url: "../Demo/Demo2.aspx/GetCompanyDetail",
                 data: '{}',
                 contentType: "application/json; charset=utf-8",
                 dataType: "json",
                 sucess: OnSuccess,
                 failure: OnFailure,
                 error: OnError
             });

             return false; //avoids Page Refresh when fetching data
         }

         function OnSuccess(response) {
             var xmlData = $.parseXML(response.d);
             var xml = $(xmlData);
             var companyName = xml.find("Table");
             showOnForm(companyName);
         }

         function showOnForm(companyName) {
             var i = 0;
             $.each(companyName, function () {
                 var company = $(this);
                 $("#Search").html($(this).find("CompanyName").text());
             });
         }

         function OnFailure(response) {
             //debugger;
             alert('Failure!!!' + '<br/>' + response.reponseText);
         }

         function OnError(response) {
             //debugger;
             var errorText = response.responseText;
             alert('Error!!!' + '\n\n' + errorText);
         }

    </script>
    
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpMainContent" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <input type="text" id="Search" placeholder="Search a word here..." runat="server" />&nbsp;
    <input type="button" id="Submit" runat="server" value="Submit Query" OnServerClick="Submit_ServerClick" /><asp:Button ID="Button1" runat="server" Text="Button" />
    <br />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
    <asp:RadioButton ID="RadioButton1" runat="server" Text="1" AutoPostBack="true" OnCheckedChanged="RadioButton1_CheckedChanged" />
    <br />
    <asp:RadioButton ID="RadioButton2" runat="server" Text="2" AutoPostBack="true" OnCheckedChanged="RadioButton2_CheckedChanged" />
    <br />
    <asp:RadioButton ID="RadioButton3" runat="server" Text="3" AutoPostBack="true" OnCheckedChanged="RadioButton3_CheckedChanged" />
    <br />

        </ContentTemplate>
    </asp:UpdatePanel>
    <p id="result" runat="server">Search results here...Click "Submit Query" to continue.tinue.</p>
     
   
</asp:Content>

