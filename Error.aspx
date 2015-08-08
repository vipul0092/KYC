<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master" AutoEventWireup="true" CodeFile="Error.aspx.cs" Inherits="Error" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .btn { 
            height: 30px; border-radius: 2px 2px; font-weight: bold; text-decoration:none;
            font-family: Arial,sans-serif; background-color: #d14836; font-size: 11px; text-transform:uppercase;
            color: #FFF; padding: 10px 7px 10px 7px; line-height: 30px;
        }
        .btn:hover {
            background-color: #c53727; box-shadow:0px 1px 1px rgba(0,0,0,0.1);
            border-color: #b0281a;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpMainContent" Runat="Server">
    <div runat="server" id="errBorder" style="padding: 10px; margin-right: 30px; margin-left: 30px; border-bottom-style: solid; border-width: medium; border-top-color: #000099; color: #FF0000; background-color: #FFFF99; font-weight: bold; text-transform: uppercase; font-size: 18px">ERROR</div>
    <div clientidmode="static" id="errorMessage" runat="server" style="padding: 10px; margin-right: 30px; border-radius:6px 6px; border: thin solid #000000; color: #003366; margin-left: 30px;"></div>
    <table visible="false" style="margin: 0px 0px 0px 30px; border-radius:6px 6px; border: thin solid #000000;" runat="server" clientidmode="static" id="errorCompany"><tr><td>Sorry The Company wasn'y found in the DB.</td></tr>
     <tr><td style="padding: 10px 0px 10px 20px"><a clientidmode="static" class="btn" id="addnRate" runat="server">Add and Rate The Company</a></td></tr>
    <tr><td></td></tr>
    </table>
    <br />
</asp:Content>

