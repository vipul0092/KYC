<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master" AutoEventWireup="true" CodeFile="CompanyDetails.aspx.cs" Inherits="CompanyRating" %>
<%@ Register TagName="Rating10" TagPrefix="my" Src="~/Controls/Rating10.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link href="Scripts/Styles.css" rel="stylesheet" />
    <style type="text/css">
        .auto-style6 {
            border-bottom-style: solid; border-bottom-width: thick; border-bottom-color: #0B2896;
            text-align: center; background-color: #dce248;
            height: 44px; text-shadow: 1px 1px 12px #726a6a;
            font-size: 20px;
            font-weight: 600;
        }
        .tableStyle {
            border-style: solid; border-width: thick; border-radius: 6px 6px; border-color:#0b2896;
        }
        #numRatings {
            font-size: 18px
        }
        .rightBorder {
         font-size: 18px; cursor: pointer;
        }
        .auto-style7 {
            width: 611px;
        }
        .button {
           color: #fff; background-color: #c42727; font-weight: 500; text-align: center;
           width: 102px; height: 40px; border-radius: 3px 4px;
        }
        .button:hover {
            background-color: #ce0000;
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
        .rateBtn {
            color: #FFFFFF; background-color: #ea0f0f; height: 60px; width: 100px; padding: 11px 10px 11px 10px;
            border-radius: 2px 3px; text-decoration: none; font-family: Arial,sans-serif; background-color: #d14836;text-transform:uppercase;
            font-size: 12px; font-weight: bold;
            }
            .rateBtn:hover {
                background-color: #c53727; box-shadow:0px 1px 1px rgba(0,0,0,0.1);
            border-color: #b0281a;
            }
        #rate {
            height: 60px;font-size: 17px;
        }
        .left {
            padding-left: 5px; padding-right: 10px;
        }
        .equalPad {
            padding-left: 5px; padding-right: 5px;
        }
        #numRatings {
            padding-left: 10px;
        }
        .comName {
            font-size: 30px; text-transform:uppercase; font-family:Arial, sans-serif; color: #07187e; padding-left: 15px;
            text-shadow: 1px 1px 2px #726a6a;
            }
        .nrt {
            margin: 10px 0px 0px 0px; padding: 10px 5px 10px 5px; display: block;
            border: thick solid #0b2896; border-radius: 6px 6px; text-align: center;
        }
        .myinfo {
             margin: 10px 0px 0px 15px;width: 230px; text-wrap:normal; padding: 0px 0px 12px 0px;
            border-radius: 6px 6px; text-align: center; border: thick solid #49b119; font-size: 14px;display: none;
            background-image:-webkit-gradient(linear, left top, left bottom, from(#beeae9), to(#a8cfce));
            background-image:-moz-linear-gradient(linear, left top, left bottom, from(#beeae9), to(#a8cfce));
            background-image:-ms-linear-gradient(linear, left top, left bottom, from(#beeae9), to(#a8cfce));
            background-image:-o-linear-gradient(linear, left top, left bottom, from(#beeae9), to(#a8cfce));
        }
        .viewAll {
            text-decoration: none; color: #009933;  text-shadow: 1px 1px 1px #000; font-weight: bold;
        }
        .viewAll:hover {
            background-color: #e6a574;
            color: #000; text-shadow: 1px 1px 1px #fff;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpMainContent" Runat="Server">
    <asp:ScriptManager ID="scm" runat="server"><Scripts><asp:ScriptReference Path="~/Scripts/jquery-1.4.1.min.js" /></Scripts></asp:ScriptManager>
    <table align="center" id="companyDetailsMain"><tbody>
    <tr><td style="border-bottom-style: solid; border-bottom-width: thick; border-bottom-color: #009933" class="auto-style7">
    <table align="center"><tr><td class="centerAlign"><img runat="server" id="companyLogo" width="30" height="30" src="../Images/Logos/logo_6.png" /></td>
    <td id="companyName" runat="server" class="centerAlign , comName"><b>Microsoft</b></td><td style="padding-left: 20px"></td><td clientidmode="static" runat="server" id="rate"><a class="rateBtn">Rate Now</a></td></tr></table></td></tr>
    
    <tr><td style="border-bottom-style: solid; border-bottom-width: thick; border-bottom-color: #009933; padding: 15px 0px 15px 0px;" class="auto-style7">
     <table align="center"><tr><td><my:Rating10 runat="server" ID="rating" ClientIDMode="Static"/></td><td class="centerAlign" runat="server" id="numRatings" clientidmode="static"> Based on X Ratings.</td></tr>
    </table></td></tr></tbody></table>

    <div style="float:left; padding: 15px 15px 10px 90px"><table clientidmode="static" id="ratingDetailsTable" runat="server" class="tableStyle">
             <tr><td colspan="3" class="auto-style6">DETAILED RATING</td></tr>           
             <tr><td title="Click for More Details" id="ia" runat="server" clientidmode="static" class="centerAlign , rightBorder">Interview Atmosphere</td><td class="arrow"></td><td><my:Rating10 runat="server" ID="dRating1" Visible="false" /></td></tr>
             <tr><td title="Click for More Details" id="rp" runat="server" clientidmode="static" class="centerAlign , rightBorder">Recruitment Process</td><td class="arrow"></td><td><my:Rating10 runat="server" ID="dRating2" Visible="false" /></td></tr>
             <tr><td title="Click for More Details" id="ls" runat="server" clientidmode="static" class="centerAlign , rightBorder">Level of Stress Satisfaction</td><td class="arrow"></td><td><my:Rating10 runat="server" ID="dRating3" Visible="false" /></td></tr>
             <tr><td title="Click for More Details" id="pc" runat="server" clientidmode="static" class="centerAlign , rightBorder">Physical Conditions at the Workplace</td><td class="arrow"></td><td><my:Rating10 runat="server" ID="dRating4" Visible="false" /></td></tr>
             <tr><td title="Click for More Details" id="hr" runat="server" clientidmode="static" class="centerAlign , rightBorder">HR Practices</td><td class="arrow"></td><td><my:Rating10 runat="server" ID="dRating5" Visible="false" /></td></tr>
             <tr><td title="Click for More Details" id="sb" runat="server" clientidmode="static" class="centerAlign , rightBorder">Salary & Benefits</td><td class="arrow"></td><td><my:Rating10 runat="server" ID="dRating6" Visible="false" /></td></tr>
             <tr><td title="Click for More Details" id="sw" runat="server" clientidmode="static" class="centerAlign , rightBorder">Schedule, Work Hours & Holidays</td><td class="arrow"></td><td><my:Rating10 runat="server" ID="dRating7" Visible="false" /></td></tr>
             <tr><td title="Click for More Details" id="ad" runat="server" clientidmode="static" class="centerAlign , rightBorder">Advancement & Promotion Opportunities</td><td class="arrow"></td><td><my:Rating10 runat="server" ID="dRating8" Visible="false" /></td></tr>
             <tr><td title="Click for More Details" id="rc" runat="server" clientidmode="static" class="centerAlign , rightBorder">Recognition by the Employer</td><td class="arrow"></td><td><my:Rating10 runat="server" ID="dRating9" Visible="false" /></td></tr>
             <tr><td title="Click for More Details" id="sl" runat="server" clientidmode="static" class="centerAlign , rightBorder">Satisfaction Level</td><td class="arrow"></td><td><my:Rating10 runat="server" ID="dRating10" Visible="false" /></td></tr>
             <tr><td title="Click for More Details" id="lb" runat="server" clientidmode="static" class="centerAlign , rightBorder">Work/Family Life Balance</td><td class="arrow"></td><td><my:Rating10 runat="server" ID="dRating11" Visible="false" /></td></tr>
             <tr><td title="Click for More Details" id="rf" runat="server" clientidmode="static" class="centerAlign , rightBorder">Recommendation to a Friend</td><td class="arrow"></td><td><my:Rating10 runat="server" ID="dRating12" Visible="false" /></td></tr>
         </table></div>
        <div style="float:left; padding: 15px 0px 10px 10px;"><table class="tableStyle">
            <tr><td class="auto-style6">TOP REVIEWS</td></tr>
            <tr><td><table style="border-spacing: 5px 5px" runat="server" id="reviewTable"><tr><td></td></tr>
            <tr><td></td></tr>
            <tr><td></td></tr>
            <tr><td></td></tr>
            <tr><td></td></tr>
            <tr><td></td></tr>
        </table></td></tr></table>
        <div align="center" clientidmode="static" class="nrt" id="numReviewsTotal" runat="server" visible="false"></div>
        <div align="center" clientidmode="static" class="myinfo" id="ratingInfo" runat="server"><table><tr><td><div runat="server" title="Close this Information Dialog." clientidmode="static" style="cursor:pointer;display:block; float:right;font-size:10px; float:right;" id="closeX">X</div><div runat="server" clientidmode="static" id="infoLabel" style="float:right;padding: 0px 7px 0px 7px"></div></td></tr></table></div>
         </div>
</asp:Content>
<asp:Content ID="scripts" ContentPlaceHolderID="cpScriptContent" runat="server" >
    <script type="text/javascript">
        /* Click Handling Script for the Review Table Elements
           Author: Vipul Gaur */
        $(document).ready(function () {
            var clickHandler = function (e) {
                var $this = $(this);
                if ($this.attr('id').match('ia'))
                { document.getElementById('infoLabel').innerHTML = "Tells how good the atmosphere was, when the Interview was taken."; }
                else if ($this.attr('id').match('rf'))
                { document.getElementById('infoLabel').innerHTML = "How likely would one recommend the employer to a friend."; }
                else if ($this.attr('id').match('rp'))
                { document.getElementById('infoLabel').innerHTML = "Tells how good the recruitment process was, as a whole."; }
                else if ($this.attr('id').match('ls'))
                { document.getElementById('infoLabel').innerHTML = "Tells how happy one is, with the level of stress while working for the employer."; }
                else if ($this.attr('id').match('pc'))
                { document.getElementById('infoLabel').innerHTML = "How good are physical conditions in and around the workplace. Like Security, Office Space etc."; }
                else if ($this.attr('id').match('hr'))
                { document.getElementById('infoLabel').innerHTML = "Tells how good are the HR Practices at the employer concerned."; }
                else if ($this.attr('id').match('sb'))
                { document.getElementById('infoLabel').innerHTML = "Tells how good are the Salary and Benefits at the employer."; }
                else if ($this.attr('id').match('sw'))
                { document.getElementById('infoLabel').innerHTML = "Tells how satisfied one is, with the Schedule, Work Hours and Holidays."; }
                else if ($this.attr('id').match('ad'))
                { document.getElementById('infoLabel').innerHTML = "Tells how good are the prospects of Promotion and Advancement at the employer."; }
                else if ($this.attr('id').match('rc'))
                { document.getElementById('infoLabel').innerHTML = "Tells how important one feels while  working for the employer."; }
                else if ($this.attr('id').match('sl'))
                { document.getElementById('infoLabel').innerHTML = "Tells how much is the Satisfaction Level in working for the employer."; }
                else if ($this.attr('id').match('lb'))
                { document.getElementById('infoLabel').innerHTML = "Tells how much attention the employer pays to the Work/Family Life Balance  of an employee."; }

                $('#ratingInfo').stop(true, true).fadeIn('slow');
                $('html, body').animate({ scrollTop: $('#ratingInfo').offset().top }, 'slow');
            }

            $('#ia').click(clickHandler); $('#ls').click(clickHandler); $('#rf').click(clickHandler); $('#rp').click(clickHandler);
            $('#pc').click(clickHandler); $('#hr').click(clickHandler); $('#sb').click(clickHandler); $('#sw').click(clickHandler);
            $('#ad').click(clickHandler); $('#rc').click(clickHandler); $('#sl').click(clickHandler); $('#lb').click(clickHandler);
            $('#closeX').click(function () { $('#ratingInfo').stop(true, true).fadeOut('slow'); });
        });
    </script>
</asp:Content>