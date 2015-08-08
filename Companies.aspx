<%@ Page Title="Know Your Company - Companies" Language="C#" AutoEventWireup="true" CodeFile="Companies.aspx.cs" Inherits="Companies" %>
<%@ Register TagPrefix="my" TagName="Rating10" Src="~/Controls/Rating10.ascx" %>

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


                objouter.style.top = (top + objInput.clientHeight) + 'px';
                objouter.style.left = left + 'px';
                objouter.style.width = '240px';
            }
        }
        document.write("<div id='__smanDisp' style='position:absolute;display:none;background:#E8F7EB;border: 1px solid #CCCCCC;font-size:15px;cursor: default;' onbulr> </div>");
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
        .mystyle1 {
            text-align:center; border-top-style: solid; border-color: #3366FF;
            padding-left: 18px; padding-right: 18px;
        }
        .btn { display:block;
            height: 30px; border-radius: 2px 2px; font-weight: bold; text-decoration:none;
            font-family: Arial,sans-serif; background-color: #d14836; font-size: 11px; text-transform:uppercase;
            color: #FFF; padding: 0px 5px 0px 5px; line-height: 30px;
        }
        .btn:hover {
            background-color: #c53727; box-shadow:0px 1px 1px rgba(0,0,0,0.1);
            border-color: #b0281a;
        }
        .auto-style6 {
            width: 751px;
            text-align: center;
            font-size: 17px;
        }
        .auto-style7 {
            width: 751px;
            text-align: center;
            height: 26px;
        }
        .auto-style8 {
            text-align: center; border-bottom-style: solid; border-color: #3366FF;
            width: 148px;
            height: 34px;
        }
        .auto-style9 {
            width: 148px;
        }
        .auto-style15 {
            width: 190px;
            text-align: center;
            color: #000;
        }
        .auto-style17 {
            width: 312px;
            text-align: center;
            padding: 0px 0px 0px 10px;
        }
        .auto-style18 {
            width: 190px; border-right:thin solid #000;
            text-align: center;
            font-size: 20px; font-weight: 300;
            color: #2a3a69;
            height: 43px;
            text-shadow: 1px 1px 12px #726a6a;
        }
        .auto-style19 {
            width: 312px;
            text-align: center; font-size: 20px;
            font-weight: 300;
            height: 43px;
            text-shadow: 1px 1px 12px #726a6a;
            color: #2a3a69;
        }
        .selected {
            border-width: thin; border-style: solid; background-color: #FFFCBF
        }
        .auto-style7 ul {
            list-style:none;
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
        .compLinks {
            font-size: 17px;
        }
        .compLinks:hover {
           background-color: #f6e84c;
           text-shadow: 1px 1px 2px #726a6a;
        }
    </style>
</head>
<body style="background-repeat:repeat; background-image:url('Images/background.jpg'); margin: 0px 0px 0px 0px;" onload="test()">
  <form id="form1" runat="server">
     <table id="mainTable" align="center"><tbody>
       <tr><td><table><tr><td><div id="Header"><a id="A1" href="~/" runat="server"><img src="../Images/logo.png" style="height: 100px" /></a></div></td></tr></table></td></tr>
       <tr><td><div id="MenuWrapper" style="margin-bottom:1.5px">                              
          <table style="width: 850px; border-style: solid; border-width: thin; background-color: #81ca18; border-radius: 4px 4px;">
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
    <asp:ScriptManager ID="ScriptManager2" runat="server"></asp:ScriptManager>
    <table align="center" style="margin-top: 30px;">
        <tbody>
         <tr><td style="padding:0px 0px 0px 330px" class="auto-style6"><div class="searchText"> Search A Company...</div></td></tr>
            <tr>
                <td class="auto-style7">
                        <asp:TextBox AutoPostBack="true" ID="searchBox" runat="server" placeholder="Type here to search..." Width="240px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style6">

                    <asp:DropDownList ID="DropDownList1" Width="250px" runat="server">
                    </asp:DropDownList>
                    
                </td>
            </tr>
            <tr>
                <td class="auto-style6">
                    <input type="image" src="Images/sButtonT.png" runat="server" id="searchImg" onserverclick="search_ServerClick" />
                </td>
            </tr>
                   
             
        </tbody>
    </table>
    <hr style="width: 724px; color: #008000; clip: rect(20px, auto, 20px, auto); margin-top: 20px; margin-bottom: 20px;" />
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
    <ContentTemplate>
    <table id="orderby" class="classFloatLeft" style="border-style: solid; border-color: #3366FF; margin-left: 25px; margin-bottom: 25px">
        <tbody><tr><td class="auto-style8">ORDER BY</td>
            </tr><tr><td class="auto-style9"><asp:RadioButton AutoPostBack="true" ID="RadioButton1" runat="server" Text="Alphabetical" Width="148px" OnCheckedChanged="RadioButton1_CheckedChanged"/></td></tr>
            <tr><td class="auto-style9"><asp:RadioButton AutoPostBack="true" ID="RadioButton2" runat="server" Text="Ratings" Width="148px" OnCheckedChanged="RadioButton2_CheckedChanged" /></td></tr>
            <tr><td class="auto-style9"><asp:RadioButton AutoPostBack="true" ID="RadioButton3" runat="server" Text="No. Of Ratings" Width="148px" OnCheckedChanged="RadioButton3_CheckedChanged" /></td></tr>
            <tr><td class="mystyle1"><a class="btn" id="orderByRes" runat="server">Get Results</a></td></tr>
        </tbody>
    </table>
    </ContentTemplate>
    </asp:UpdatePanel>
    <table style="margin:0px 0px 0px 20px;" id="rightCompanytable" class="classFloatLeft">
        <tbody><tr><td>
        <table id="alphabets" runat="server"><tr><td class="alphacol , centerAlign"><a class="nodecor" href="Companies.aspx?letter=A&page=1">A</a></td><td class="alphacol , centerAlign"><a class="nodecor" href="Companies.aspx?letter=B&page=1">B</a></td><td class="alphacol , centerAlign"><a class="nodecor" href="Companies.aspx?letter=C&page=1">C</a></td><td class="alphacol , centerAlign"><a class="nodecor" href="Companies.aspx?letter=D&page=1">D</a></td><td class="alphacol , centerAlign"><a class="nodecor" href="Companies.aspx?letter=E&page=1">E</a></td><td class="alphacol , centerAlign"><a class="nodecor" href="Companies.aspx?letter=F&page=1">F</a></td><td class="alphacol , centerAlign"><a class="nodecor" href="Companies.aspx?letter=G&page=1">G</a></td><td class="alphacol , centerAlign"><a class="nodecor" href="Companies.aspx?letter=H&page=1">H</a></td><td class="alphacol , centerAlign"><a class="nodecor" href="Companies.aspx?letter=I&page=1">I</a></td><td class="alphacol , centerAlign"><a class="nodecor" href="Companies.aspx?letter=J&page=1">J</a></td><td class="alphacol , centerAlign"><a class="nodecor" href="Companies.aspx?letter=K&page=1">K</a></td><td class="alphacol , centerAlign"><a class="nodecor" href="Companies.aspx?letter=L&page=1">L</a></td><td class="alphacol , centerAlign"><a class="nodecor" href="Companies.aspx?letter=M&page=1">M</a></td><td class="alphacol , centerAlign"><a class="nodecor" href="Companies.aspx?letter=N&page=1">N</a></td><td class="alphacol , centerAlign"><a class="nodecor" href="Companies.aspx?letter=O&page=1">O</a></td><td class="alphacol , centerAlign"><a class="nodecor" href="Companies.aspx?letter=P&page=1">P</a></td><td class="alphacol , centerAlign"><a class="nodecor" href="Companies.aspx?letter=Q&page=1">Q</a></td><td class="alphacol , centerAlign"><a class="nodecor" href="Companies.aspx?letter=R&page=1">R</a></td><td class="alphacol , centerAlign"><a class="nodecor" href="Companies.aspx?letter=S&page=1">S</a></td><td class="alphacol , centerAlign"><a class="nodecor" href="Companies.aspx?letter=T&page=1">T</a></td><td class="alphacol , centerAlign"><a class="nodecor" href="Companies.aspx?letter=U&page=1">U</a></td><td class="alphacol , centerAlign"><a class="nodecor" href="Companies.aspx?letter=V&page=1">V</a></td><td class="alphacol , centerAlign"><a class="nodecor" href="Companies.aspx?letter=W&page=1">W</a></td><td class="alphacol , centerAlign"><a class="nodecor" href="Companies.aspx?letter=X&page=1">X</a></td><td class="alphacol , centerAlign"><a class="nodecor" href="Companies.aspx?letter=Y&page=1">Y</a></td><td class="alphacol , centerAlign"><a class="nodecor" href="Companies.aspx?letter=Z&page=1">Z</a></td></tr></table>
            </td></tr>
            <tr><td>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                     <ContentTemplate>
                    <table align="center" id="companyNameRating" style="border-radius: 6px 6px;border-style: dotted; border-width: thin;" runat="server" class="centerAlign, nodecor">
                        <tr><td id="nameTop" class="auto-style18" style="border-bottom-style: solid; background-color: #CCFFFF">NAME</td><td id="ratingTop" class="auto-style19" style="border-bottom-style: solid; background-color: #CCFFFF">RATING</td></tr>
                        <tr><td runat="server" id="name1" class="auto-style15"></td><td runat="server" id="rating1" class="auto-style17"><my:Rating10 ID="ratingCtrl1" runat="server" Visible="false"/></td></tr>
                        <tr><td runat="server" id="name2" class="auto-style15"></td><td runat="server" id="rating2" class="auto-style17"><my:Rating10 ID="ratingCtrl2" runat="server" Visible="false"/></td></tr>
                        <tr><td runat="server" id="name3" class="auto-style15"></td><td runat="server" id="rating3" class="auto-style17"><my:Rating10 ID="ratingCtrl3" runat="server" Visible="false"/></td></tr>
                        <tr><td runat="server" id="name4" class="auto-style15"></td><td runat="server" id="rating4" class="auto-style17"><my:Rating10 ID="ratingCtrl4" runat="server" Visible="false"/></td></tr>
                        <tr><td runat="server" id="name5" class="auto-style15"></td><td runat="server" id="rating5" class="auto-style17"><my:Rating10 ID="ratingCtrl5" runat="server" Visible="false"/></td></tr>
                        <tr><td runat="server" id="name6" class="auto-style15"></td><td runat="server" id="rating6" class="auto-style17"><my:Rating10 ID="ratingCtrl6" runat="server" Visible="false"/></td></tr>
                        <tr><td runat="server" id="name7" class="auto-style15"></td><td runat="server" id="rating7" class="auto-style17"><my:Rating10 ID="ratingCtrl7" runat="server" Visible="false"/></td></tr>
                        <tr><td runat="server" id="name8" class="auto-style15"></td><td runat="server" id="rating8" class="auto-style17"><my:Rating10 ID="ratingCtrl8" runat="server" Visible="false"/></td></tr>
                        <tr><td runat="server" id="name9" class="auto-style15"></td><td runat="server" id="rating9" class="auto-style17"><my:Rating10 ID="ratingCtrl9" runat="server" Visible="false"/></td></tr>
                        <tr><td runat="server" id="name10" class="auto-style15"></td><td runat="server" id="rating10" class="auto-style17"><my:Rating10 ID="ratingCtrl10" runat="server" Visible="false"/></td></tr>
                    </table></ContentTemplate></asp:UpdatePanel>
                </td></tr>
            <tr><td>
                <table align="center" id="numLinksTable" runat="server"><tbody><tr>
        <td runat="server" id="first" class="numCol , centerAlign"></td>
        <td runat="server" id="previous" class="numCol , centerAlign"></td>
        <td runat="server" id="num1" class="numCol , centerAlign"></td>
        <td runat="server" id="num2" class="numCol , centerAlign"></td>
        <td runat="server" id="num3" class="numCol , centerAlign"></td>
        <td runat="server" id="num4" class="numCol , centerAlign"></td>
        <td runat="server" id="num5" class="numCol , centerAlign"></td>
        <td runat="server" id="num6" class="numCol , centerAlign"></td>
        <td runat="server" id="num7" class="numCol , centerAlign"></td>
        <td runat="server" id="num8" class="numCol , centerAlign"></td>
        <td runat="server" id="num9" class="numCol , centerAlign"></td>
        <td runat="server" id="num10" class="numCol , centerAlign"></td>
        <td runat="server" id="next" class="numCol , centerAlign"></td>
        <td runat="server" id="last" class="numCol , centerAlign"></td>
      </tr></tbody></table>
            </td></tr>
        </tbody>
    </table>
    
    <br />
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
