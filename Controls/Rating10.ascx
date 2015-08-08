<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Rating10.ascx.cs" Inherits="Rating10" EnableViewState="True" ViewStateMode="Enabled" %>
<link href="Scripts/Styles.css" rel="stylesheet" />
<style type="text/css">
    .auto-style3 {
        width: 54px;
        border-radius: 6px 6px;
        text-align: center;
    }
</style>
<table id="controlTable" runat="server" style="border: thin solid #C0C0C0; border-radius:8px 8px;"><tbody>
    <tr><td>
    <table id="radioTable" runat="server" style="border-radius:6px 6px; border: thin solid #99FF99; text-align:center;"><tbody>
    <tr style="border-bottom-style: solid; border-bottom-width: thin; border-bottom-color: #000000;"><td>1</td><td>2</td><td>3</td><td>4</td><td>5</td><td>6</td><td>7</td><td>8</td><td>9</td><td>10</td></tr>
    <tr>
    <td><asp:RadioButton AutoPostBack="true" ID="Radio1" runat="server" OnCheckedChanged="Radio_ServerChange"/></td>
    <td><asp:RadioButton AutoPostBack="true" ID="Radio2" runat="server" OnCheckedChanged="Radio_ServerChange"/></td>      
        <td><asp:RadioButton AutoPostBack="true" ID="Radio3" runat="server" OnCheckedChanged="Radio_ServerChange"/></td>
        <td><asp:RadioButton AutoPostBack="true" ID="Radio4" runat="server" OnCheckedChanged="Radio_ServerChange"/></td>
        <td><asp:RadioButton AutoPostBack="true" ID="Radio5" runat="server" OnCheckedChanged="Radio_ServerChange"/></td>
        <td><asp:RadioButton AutoPostBack="true" ID="Radio6" runat="server" OnCheckedChanged="Radio_ServerChange"/></td>
        <td><asp:RadioButton AutoPostBack="true" ID="Radio7" runat="server" OnCheckedChanged="Radio_ServerChange"/></td>
        <td><asp:RadioButton AutoPostBack="true" ID="Radio8" runat="server" OnCheckedChanged="Radio_ServerChange"/></td>
        <td><asp:RadioButton AutoPostBack="true" ID="Radio9" runat="server" OnCheckedChanged="Radio_ServerChange"/></td>
        <td><asp:RadioButton AutoPostBack="true" ID="Radio10" runat="server" OnCheckedChanged="Radio_ServerChange"/></td> 
    </tr></tbody></table>
        </td>
    <td id="ratingDisp" runat="server" class="auto-style3" style="font-size: large; background-color: #99FF99"></td>
    </tr>
</tbody></table>


