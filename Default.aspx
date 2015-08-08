<%@ Page Title="Know Your Company - Get & Share Employer Reviews" Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>
<%@ Register Src="~/Controls/Rating10.ascx" TagPrefix="my" TagName="Rating10" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    
    <style type="text/css">
        #searchBox {
            width: 255px;
        }
        .tableHeading {
            text-align: center;
            font-size: 20px; font-weight: 300;
            color: #2a3a69; 
            height: 43px;
            text-shadow: 1px 1px 12px #726a6a;
            border-bottom-style: solid; border-bottom-color: #FF6600;
            background-color: #c2bbbb;
        }
        .tableCellBdry {
            border-bottom-style: dotted; border-width: thin;
            font-size: 17px;
        }
        .links {
            text-decoration: none;
        }
        .links:hover {
            background-color: #f6e84c;
            text-shadow: 1px 1px 2px #726a6a;
        }
        .horbreak {
            width: 724px; color: #008000; margin-top: 20px; margin-bottom: 20px;
        }
        .cellBorder {
            border-right-style: solid; border-right-width: thin; border-right-color: #000000
        }
        .border {
            border-radius:3px 4px;border-style: solid; border-width: thin; padding: 5px;
        }
        .more {
            text-decoration: none;
            color: #0B2896;
        }
        .more:hover {
            background-color: #e6a574;
            color: #000;
         }
        .right {
            text-align: right;
        }
    </style>
    <link href="../Scripts/Styles.css" rel="stylesheet" />
    <script language="javascript" type="text/javascript">
        var intIndex = 0; arrList = new Array();
        <%=like_message %>

        function test() {
            init();
            smanPromptList(arrList, "searchBox")
        }
        function init() {
            if (arrList.constructor != Array) { alert('Initialization of the smanPromptListe error'); return; }
            arrList.sort(function (a, b) {
                if (a.length > b.length) return 1;
                else if (a.length == b.length) return a.localeCompare(b);
                else return -1;
            }
            );
        }
        function smanPromptList(arrList, objInputId) {
            var objouter = document.getElementById("__smanDisp")
            var objInput = document.getElementById(objInputId);
            var selectedIndex = -1;
            var intTmp;
            if (objInput == null) { alert('Initialization of the smanPromptListe error,can not find the "' + objInputId + '"textbox'); return; }


            objInput.onblur = function () {
                objouter.style.display = 'none';
            }


            objInput.onkeyup = checkKeyCode;


            objInput.onfocus = checkAndShow;
            function checkKeyCode(evt) {
                evt = evt || window.event;
                var ie = (document.all) ? true : false
                if (ie) {
                    var keyCode = evt.keyCode;
                    if (keyCode == 40 || keyCode == 38) {
                        var isUp = false;
                        if (keyCode == 40) isUp = true;
                        chageSelection(isUp);
                    } else if (keyCode == 13) {
                        outSelection(selectedIndex);
                    } else {
                        checkAndShow(evt)
                    }
                } else {
                    checkAndShow(evt)
                }
                divPosition(evt)
            }
            function checkAndShow(evt) {
                var strInput = String(objInput.value);
                if (strInput != "") {
                    var start1 = strInput[0].toLowerCase();
                    var str1 = start1 + strInput.substr(1, strInput.length);

                    var start2 = strInput[0].toUpperCase();
                    var str2 = start2 + strInput.substr(1, strInput.length);

                    divPosition(evt);
                    selectedIndex = -1;
                    objouter.innerHTML = "";


                    for (intTmp = 0; intTmp < arrList.length; intTmp++) {
                        if ((arrList[intTmp].substr(0, str1.length) == str1) || (arrList[intTmp].substr(0, str2.length) == str2)) {
                            addOption(arrList[intTmp]);


                        }
                    }
                    objouter.style.display = '';
                } else {
                    objouter.style.display = 'none';
                }
                function addOption(value) {
                    objouter.innerHTML += "<div onmouseover=\"this.className='sman_selectedStyle'\" onmouseout=\"this.className=''\" onmousedown=\"document.getElementById('" + objInputId + "').value='" + value + "';document.getElementById('" + objInputId + "').onchange();\">" + value + "</div>"
                }
            }
            function chageSelection(isUp) {
                if (objouter.style.display == 'none') {
                    objouter.style.display = '';
                } else {
                    if (isUp)
                        selectedIndex++
                    else
                        selectedIndex--
                }
                var maxIndex = objouter.children.length - 1;
                if (selectedIndex < 0) { selectedIndex = 0 }
                if (selectedIndex > maxIndex) { selectedIndex = maxIndex }
                for (intTmp = 0; intTmp <= maxIndex; intTmp++) {
                    if (intTmp == selectedIndex) {
                        objouter.children[intTmp].className = "sman_selectedStyle";
                    } else {
                        objouter.children[intTmp].className = "";
                    }
                }
            }
            function outSelection(Index) {
                objInput.value = objouter.children[Index].innerText;
                objouter.style.display = 'none';
            }
            function divPosition(evt) {
                var left = 0;
                var top = 0;
                var e = objInput;
                while (e.offsetParent) {
                    left += e.offsetLeft + (e.currentStyle ? (parseInt(e.currentStyle.borderLeftWidth)).NaN0() : 0);
                    top += e.offsetTop + (e.currentStyle ? (parseInt(e.currentStyle.borderTopWidth)).NaN0() : 0);
                    e = e.offsetParent;
                }
                left += e.offsetLeft + (e.currentStyle ? (parseInt(e.currentStyle.borderLeftWidth)).NaN0() : 0);
                top += e.offsetTop + (e.currentStyle ? (parseInt(e.currentStyle.borderTopWidth)).NaN0() : 0);


                objouter.style.top = (top + objInput.clientHeight + 4) + 'px';
                objouter.style.left = left + 'px';
                objouter.style.width = '255px';
            }
        }
        document.write("<div id='__smanDisp' style='position:absolute;display:none;background:#E8F7EB;border: 1px solid #CCCCCC;font-size:15px;cursor: pointer;' onbulr> </div>");
        document.write("<style>.sman_selectedStyle{background-Color:#102681;color:#FFFFFF}</style>");
        function getAbsoluteHeight(ob) {
            return ob.offsetHeight
        }
        function getAbsoluteWidth(ob) {
            return ob.offsetWidth
        }
        function getAbsoluteLeft(ob) {
            var mendingLeft = ob.offsetLeft;
            while (ob != null && ob.offsetParent != null && ob.offsetParent.tagName != "BODY") {
                mendingLeft += ob.offsetParent.offsetLeft;
                mendingOb = ob.offsetParent;
            }
            return mendingLeft;
        }
        function getAbsoluteTop(ob) {
            var mendingTop = ob.offsetTop;
            while (ob != null && ob.offsetParent != null && ob.offsetParent.tagName != "BODY") {
                mendingTop += ob.offsetParent.offsetTop;
                ob = ob.offsetParent;
            }
            return mendingTop;
        }
        Number.prototype.NaN0 = function () {
            return isNaN(this) ? 0 : this;
        }
</script>

    <script type="text/javascript" src="Scripts/jquery-1.4.1.min.js"></script>
    <script type="text/javascript" src="Scripts/jquery.browser.min.js"></script>
    
</head>
<body style="background-repeat:repeat; background-image:url('../Images/background.jpg'); margin: 0px 0px 0px 0px;" onload="test()">
  <form id="form1" runat="server">
     <div runat="server" clientidmode="static" id="special" class="specialDiv"></div>
     <table id="mainTable" align="center"><tbody>
       <tr><td><table><tr><td><div id="Header"><a id="A1" href="~/" runat="server"><img src="../Images/logo.png" style="height: 100px" /></a></div></td></tr></table></td></tr>
       <tr><td><div id="MenuWrapper" style="margin-bottom:1.5px">                              
          <table style="border-style: solid; border-width: thin; background-color: #81ca18; border-radius: 4px 4px; width:850px">
                     <tbody>
                         <tr>
                            <td class="menuHome , menuText , centerAlign , cellBorder , headerLink"><a class="menuLinks" href="../Default.aspx">HOME</a></td>
                            <td class="menuCompanies , menuText , centerAlign , cellBorder , headerLink"><a class="menuLinks" href="../Companies.aspx">COMPANIES</a></td>
                             <td class="menuReview , menuText , centerAlign , cellBorder , headerLink"><a class="menuLinks" href="../SubmitReview/Default.aspx">RATE EMPLOYER</a></td>
                             <td class="menuFAQ , menuText , centerAlign , cellBorder , headerLink"><a class="menuLinks" href="../View/FAQ.aspx">FAQ</a></td>
                             <td class="menuContact , menuText , centerAlign , headerLink"><a class="menuLinks" href="../View/Contact.aspx">CONTACT US</a></td>
                         </tr>
                     </tbody>
                 </table>                                              
            </div></td></tr>
         <tr><td runat="server" id="fullPage" clientidmode="static"><div id="MainContent"><table align="center" style="width:850px"><tr><td>
                <table align="center"><tr><td style="padding: 0px 10px 0px 0px"><table id="sideCompany" style="border: medium solid #0066FF; border-radius: 8px 8px;">
                <tbody><tr id="sideTop"><td id="sidebar" class="centerAlign , tableHeading" style="border-style: solid; border-width: 0px 0px medium 0px; border-color: #0066FF" >COMPANIES</td></tr>
            <tr><td class="centerAlign , tableCellBdry"><a title="Click to see detailed ratings for Microsoft" class="sideLinks , links" href="CompanyDetails.aspx?id=2">Microsoft</a></td></tr>
            <tr><td class="centerAlign , tableCellBdry"><a title="Click to see detailed ratings for Google" class="sideLinks , links" href="CompanyDetails.aspx?id=8">Google</a></td></tr>
            <tr><td class="centerAlign , tableCellBdry"><a title="Click to see detailed ratings for Facebook" class="sideLinks , links" href="CompanyDetails.aspx?id=5">Facebook</a></td></tr>
            <tr><td class="centerAlign , tableCellBdry"><a title="Click to see detailed ratings for Reliance Industries Limited" class="sideLinks , links" href="CompanyDetails.aspx?id=3">RIL</a></td></tr>
            <tr><td style="font-size:17px" class="centerAlign"><a title="Click to see detailed ratings for Qualcomm" class="sideLinks , links" href="CompanyDetails.aspx?id=4">Qualcomm</a></td></tr>
        </tbody>
    </table></td>
    <td><table style="border: thin solid #000000; padding-top: 40px; border-radius: 4px 6px">
        <tbody>
            <tr><td style="padding:0px 0px 0px 165px" class="auto-style1"><div class="searchText"> Search A Company...</div></td></tr>
            <tr><td colspan="2" class="auto-style2"><input clientidmode="static" runat="server" type="text" id="searchBox" placeholder="Type here to search..." /></td></tr>
            <tr><td colspan="2" class="auto-style1"><asp:DropDownList ID="DropDownList1" Width="250px" runat="server"></asp:DropDownList></td></tr>
            <tr><td colspan="2" class="centerAlign"><input type="image" src="Images/sButtonT.png" runat="server" id="searchImg" onserverclick="search_ServerClick" /></td></tr>
        </tbody>
    </table></td></tr></table></td></tr>
    <tr><td><hr class="horbreak"/></td></tr>
     <tr><td>
    <asp:Label ID="Label1" runat="server" Text="Now, you can also do background-checks on your prospective Employer." Width="167px" ClientIDMode="Static"></asp:Label>
    <asp:Label ID="Label2" runat="server" Text="Stop getting confused. Get the real information about any employer." Width="167px" ClientIDMode="Static"></asp:Label>
    <asp:Label ID="Label3" runat="server" Text="Share your job experiences with your employer and help others." Width="167px" ClientIDMode="Static"></asp:Label>
    </td></tr>
    <tr><td><hr style="width: 724px; color: #008000; clip: rect(20px, auto, 20px, auto); margin-top: 20px; margin-bottom: 20px;" /></td></tr>

<tr><td><table style="padding: 0px 0px 20px 0px" align="center"><tbody>
 <tr><td><table id="table1in3" runat="server" style="border: medium solid #FF6600; border-radius: 6px 6px;">
     <tr><td align="center" class="tableHeading">TOP REVIEWS</td></tr>
     <tr><td class="centerAlign , tableCellBdry" align="center"></td></tr>
     <tr><td class="centerAlign , tableCellBdry" align="center"></td></tr>
     <tr><td class="centerAlign , tableCellBdry" align="center"></td></tr>
     <tr><td class="centerAlign , tableCellBdry" align="center"></td></tr>
 </table></td>
 <td style="padding: 0px 20px 0px 20px"><table id="table2in3" runat="server" style="border: medium solid #FF6600; border-radius: 6px 6px; font-size: 17px">
     <tr><td colspan="3" align="center" class="tableHeading">TOP RATED COMPANIES</td></tr>
     <tr><td style="padding-top: 10px" class="right"></td><td style="padding-top: 10px" class="centerAlign"><img src="Images/arrow.gif" /></td><td style="padding-top: 10px"><my:Rating10 runat="server" ID="Rating" ClientIDMode="Static" Visible="false" /></td></tr>
     <tr><td colspan="3"><hr /></td ></tr>
     <tr><td class="right"></td><td class="centerAlign"><img src="Images/arrow.gif" /></td><td><my:Rating10 ID="Rating1" runat="server" ClientIDMode="Static" Visible="false" /></td></tr>
     <tr><td colspan="3"><hr /></td></tr>
     <tr><td class="right"></td><td class="centerAlign"><img src="Images/arrow.gif" /></td><td><my:Rating10 ID="Rating2" runat="server" ClientIDMode="Static" Visible="false" /></td></tr>
     <tr><td colspan="3"><hr /></td></tr>
     <tr><td class="right" style="padding-bottom: 10px"></td><td style="padding-bottom: 10px" class="centerAlign"><img src="Images/arrow.gif" /></td><td style="padding-bottom: 10px"><my:Rating10 ID="Rating3" runat="server" ClientIDMode="Static" Visible="false" /></td></tr>
 </table></td>
 <td><table id="table3in3" runat="server" style="border: medium solid #FF6600; border-radius: 6px 6px;">
     <tr><td align="center" class="tableHeading">RECENT REVIEWS</td></tr>
     <tr><td align="center"></td></tr>
     <tr><td align="center"></td></tr>
     <tr><td align="center"></td></tr>
     <tr><td align="center"></td></tr>
 </table></td>
</tr></tbody></table></td></tr></table></div></td></tr>
          <tr><td><div id="Footer">
              <table style="border-spacing:10px 10px;" align="center">
                    <tbody>
                        <tr>
                            <td class="footerLinks"><a style="text-decoration:none; color: #009933;" href="View/About.aspx" title="Know a bit more about us & our service">About Us</a></td>
                            <td class="footerLinks"><a style="text-decoration:none; color: #009933;" href="View/Contact.aspx" title="Drop a comment or Send Us an E-Mail">Contact Us</a></td>
                            <td class="footerLinks"><a style="text-decoration:none; color: #009933;" href="View/Suggestions.aspx" title="Make our service even more better by giving your inputs">Give A Suggestion</a></td>
                        </tr>
                    </tbody>
                </table>
            </div>
            </td></tr></tbody></table>      
    </form>
    <script type="text/javascript">
        $(document).ready(function () {
            if ($.browser.name != 'chrome')
            {
                $('#special').html('You are not using Google Chrome Browser. It is advised to use Chrome to browse KYC.com for the best experience.<br/><br/>Click To Dismiss').fadeIn('slow');
                $('#special').click(function () {
                    $('#special').fadeOut('slow');
                });
            }
        });
    </script>
</body>
</html>
