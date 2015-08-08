<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="SubmitReview_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../Scripts/Styles.css" rel="stylesheet" />

    <script language="javascript" type="text/javascript">
        var intIndex = 0; arrList = new Array();
        <%=like_message %>

        function test() {
            init();
            smanPromptList(arrList, "employerIn")
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


                objouter.style.top = (top + objInput.clientHeight + 8) + 'px';
                objouter.style.left = (left + 3) + 'px';
                objouter.style.width = '200px';
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

    <style type="text/css">
        .auto-style6 {
            height: 30px;
        }
        #nameIn, #employerIn, #empnumIn, #contactnumIn,  #emailIn, #nameIn {
            width: 200px;
        }
        .auto-style7 {
            height: 40px;
            width: 301px;
        }
        .auto-style8 {
            height: 21px;
        }
        .auto-style9 {
            height: 26px;
        }
        .auto-style3 {
            width: 112px;
            height: 26px;
        }
        .auto-style4 {
            width: 124px;
            height: 26px;
        }
        .auto-style5 {
            width: 126px;
            height: 26px;
        }
        .cellBorder {
            border-right-style: solid; border-right-width: thin; border-right-color: #000000
        }
    </style>
</head>
<body style="background-repeat:repeat; background-image:url('../Images/background.jpg'); margin: 0px 0px 0px 0px;" onload="test()"> 
  <form id="form1" runat="server">
     <table id="mainTable" align="center"><tbody>
       <tr><td><table><tr><td><div id="Header"><a id="A1" href="~/" runat="server"><img src="../Images/logo.png" style="height: 100px" /></a></div></td></tr></table></td></tr>
       <tr><td><div id="MenuWrapper" style="margin-bottom:1.5px">                              
          <table style="width:850px; border-style: solid; border-width: thin; background-color: #81ca18; border-radius: 4px 4px;">
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
         <tr><td runat="server" id="fullPage" clientidmode="static"><div id="MainContent">
                <table align="center">
        <tr><td><table style="text-align: center; font-weight: bold; margin-bottom: 15px; border-bottom-style: solid; border-bottom-color: #000066"><tr><td class="auto-style7">PROVIDE PERSONAL INFORMATION</td></tr></table></td></tr>
        <tr><td>
        <table class="classFloatLeft" style="border-style: double; border-radius:5px 6px; padding: 10px">
        <tr><td class="auto-style6" style="text-align: right">Your Name : </td>
        <td style="color: #FF0000" class="auto-style6"><input clientidmode="static" runat="server" id="nameIn" type="text"/></td></tr>
        <tr><td style="text-align: right">Employer's Name : </td>
        <td style="color: #FF0000"><input clientidmode="static" runat="server" id="employerIn" type="text" required="required" placeholder="Enter Employer Name here"/>&nbsp;&nbsp;&nbsp;   *</td></tr>
        <tr><td style="text-align: right" class="auto-style9">PF No. /ESIC No. : </td>
        <td style="color: #FF0000" class="auto-style9"><input clientidmode="static" runat="server" id="empnumIn" type="text"/></td></tr>
        <tr><td style="text-align: right">EMail ID : </td>
        <td style="color: #FF0000"><input clientidmode="static" runat="server" id="emailIn" type="text"/>&nbsp;&nbsp;&nbsp;   *</td></tr>
        <tr><td style="text-align: right">Contact Number : </td>
        <td style="color: #FF0000"><input clientidmode="static" runat="server" id="contactnumIn" type="text"/>&nbsp;&nbsp;&nbsp;   </td></tr>
        </table>
            </td></tr>
        <tr><td>
            <table align="center">
        <tr><td class="auto-style8" style="font-weight: lighter; font-size: smaller"><span id="red">*</span> - Required Field</td></tr>
        <tr><td style="text-align:center">
        <asp:Button ID="nextStep"  runat="server" Text="TO FEEDBACK PAGE" Width="150" Height="30" Font-Bold="True" OnClick="nextStep_Click" />
        </td></tr></table>
    </td></tr></table>
            </div></td></tr>
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
    
</body>
</html>


