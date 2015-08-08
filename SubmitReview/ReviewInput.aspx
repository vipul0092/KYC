<%@ Page Title="Know Your Company - Submit A Review" Language="C#" MasterPageFile="~/MasterPages/MasterPage_sub.master" AutoEventWireup="true" CodeFile="ReviewInput.aspx.cs" Inherits="SubmitReview_Default" %>
<%@ Register TagPrefix="my" TagName="Rating10" Src="~/Controls/Rating10.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
 
    <style type="text/css">
        .auto-style6 {
            height: 33px;
            
        }
        .auto-style9 {
            height: 23px;
            
        }
        .auto-style10 {
            height: 22px;
        }
        .auto-style11 {
            height: 63px;
        }
        .question {
            font-size:18px;
            color: #27264d;
            text-shadow: 1px 1px 12px #726a6a;
        }
        .error {
            color: #f00;
        }
    </style>
 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpMainContent" Runat="Server">
       <link href="../Scripts/Styles.css" rel="stylesheet" />
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
<table id="conRevMainTop" class="classFloatLeft" style="border-bottom-style: solid; border-bottom-color: #008000; margin-bottom: 15px;">
    <tr><td style="width: 759px">
        <table align="center" style="margin-left: 30px">
        <tr>
        <td class="centerAlign"><img runat="server" id="cLogo" width="30" height="30" src="../Images/Logos/logo_6.png" /></td>
        <td id="cName" runat="server" class="centerAlign" style="text-transform:uppercase; text-shadow: 1px 1px 2px #726a6a; font-size: 30px; color: #07187e; padding-left: 30px;"><b>Microsoft</b></td>
         </tr>
        </table>
    </td></tr></table>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
    <table align="center"><tbody><tr><td>
        <table  id="preEmployment" class="classFloatLeft" style="border-width: medium; margin-bottom: 30px; border-bottom-style: double;"><tbody>
        <tr><td class="auto-style6" style="text-align: center; font-weight: bold; font-style: normal; font-size: large; background-color: #FFFF99; border-bottom-style: solid; border-bottom-color: #000066; text-transform: uppercase; border-top-style: double;">RATE YOUR EMPLOYER</td></tr>
        <tr><td class="auto-style9 , question" style="padding-left: 10px">1. How would you describe the atmosphere during the interview?</td><td class="error" id="td" runat="server"/></td></tr>
        <tr style="border-width: thick; border-color: #003300; margin-bottom: 30px; border-bottom-style: solid;"><td style="padding-left: 30px;" class="auto-style11"><my:Rating10 id="rating1" runat="server"></my:Rating10></td></tr>
        <tr><td><hr /></td></tr>
        <tr><td style="padding-left: 10px" class="auto-style10 , question">2. How would you rate the recruitment process of the company?</td><td class="error" id="Td1" runat="server"/></td></tr>
        <tr><td style="padding-left: 30px"><my:Rating10 id="rating2" runat="server"></my:Rating10></td></tr>
        <tr><td><hr /></td></tr>
        <tr><td style="padding-left: 10px" class="question">3. Are you satisfied with the level of stress at work?</td><td class="error" id="Td2" runat="server"/></td></tr>
        <tr><td style="padding-left: 30px"><my:Rating10 id="rating3" runat="server" ClientIDMode="Static"></my:Rating10></td></tr>
        <tr><td><hr /></td></tr>
        <tr><td style="padding-left: 10px" class="question">4. How would you describe the physical conditions at your workplace?</td><td class="error" id="Td3" runat="server"/></td></tr>
        <tr><td style="padding-left: 10px">Security, Surroundings, Equipment, Office Space etc.</td></tr>
        <tr><td style="padding-left: 30px"><my:Rating10 id="rating4" runat="server"></my:Rating10></td></tr>
            <tr><td><hr /></td></tr>
        <tr><td style="padding-left: 10px" class="question">5. How good do you find the HR practices at your Employer?</td><td class="error" id="Td4" runat="server"/></td></tr>
        <tr><td style="padding-left: 30px"><my:Rating10 id="rating5" runat="server"></my:Rating10></td></tr>
            <tr><td><hr /></td></tr>
        <tr><td style="padding-left: 10px" class="question">6. Are you satisfied with the salary and benefits you get?</td><td class="error" id="Td5" runat="server"/></td></tr>
        <tr><td style="padding-left: 30px"><my:Rating10 id="rating6" runat="server"></my:Rating10></td></tr>
            <tr><td><hr /></td></tr>
        <tr><td style="padding-left: 10px" class="question">7. Are you satisfied with the schedule, work hours and holidays?</td><td class="error" id="Td6" runat="server"/></td></tr>
        <tr><td style="padding-left: 30px"><my:Rating10 id="rating7" runat="server"></my:Rating10></td></tr>
            <tr><td><hr /></td></tr>
        <tr><td style="padding-left: 10px" class="question">8. Do you feel there are good opportunities for advancement and promotion?</td><td class="error" id="Td7" runat="server"/></td></tr>
        <tr><td style="padding-left: 30px"><my:Rating10 id="rating8" runat="server"></my:Rating10></td></tr>
            <tr><td><hr /></td></tr>
        <tr><td style="padding-left: 10px" class="question">9. Do you feel you are an important part of the organisation?</td><td class="error" id="Td8" runat="server"/></td></tr></tr>
        <tr><td style="padding-left: 30px"><my:Rating10 id="rating9" runat="server"></my:Rating10></td></tr>
            <tr><td><hr /></td></tr>
        <tr><td style="padding-left: 10px" class="question">10. How much is your satisfaction level after working with the employer?</td><td class="error" id="Td9" runat="server"/></td></tr>
        <tr><td style="padding-left: 30px"><my:Rating10 id="rating10" runat="server"></my:Rating10></td></tr>
            <tr><td><hr /></td></tr>
        <tr><td style="padding-left: 10px" class="question">11. Does the employer pay attention to work/family life balance?</td><td class="error" id="Td10" runat="server"/></td></tr>
        <tr><td style="padding-left: 30px"><my:Rating10 id="rating11" runat="server"></my:Rating10></td></tr>
            <tr><td><hr /></td></tr>
        <tr><td style="padding-left: 10px" class="question">12. How likely would you recommend this employer to a friend?</td><td class="error" id="Td11" runat="server"/></td></tr>
        <tr><td style="padding-left: 30px"><my:Rating10 id="rating12" runat="server"></my:Rating10></td></tr>
        <tr><td><hr /></td></tr>
        <tr><td style="padding-left: 10px" class="question">Additional Text Review...</td><td class="error" id="Td12" runat="server"/></td></tr>
        <tr><td style="padding-left: 10px"><textarea runat="server" id="comments" cols="60" rows="7" style="font-size: 15px; border-radius:6px 6px;" maxlength="300"></textarea></td></tr>
        </tbody></table>
       </td></tr>
     <tr><td style="text-align:center">
        <asp:Button ID="submitButton" runat="server" Text="SUBMIT FEEDBACK" Width="200" Height="40" Font-Bold="True" OnClick="submitButton_Click" />
     </td></tr>
       </tbody></table>
  </ContentTemplate>
  </asp:UpdatePanel>
</asp:Content>

