<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Demo1.aspx.cs" Inherits="Demo_Demo1" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <script language="javascript" type="text/javascript">
        var intIndex = 0; arrList = new Array();
        <%=like_message %>

        function test() {
            init();
            smanPromptList(arrList, "tbx_Microsoft")
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
                    var keyCode = evt.keyCode
                    if (keyCode == 40 || keyCode == 38) {
                        var isUp = false
                        if (keyCode == 40) isUp = true;
                        chageSelection(isUp)
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
                var strInput = objInput.value
                if (strInput != "") {
                    divPosition(evt);
                    selectedIndex = -1;
                    objouter.innerHTML = "";


                    for (intTmp = 0; intTmp < arrList.length; intTmp++) {
                        if (arrList[intTmp].substr(0, strInput.length) == strInput) {
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
                objouter.style.width = objInput.clientWidth;
            }
        }
        document.write("<div id='__smanDisp' style='position:absolute;display:none;background:#E8F7EB;border: 1px solid #CCCCCC;font-size:14px;cursor: default;' onbulr> </div>");
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
    
</head>
<body onload="test()">
    
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        
    <div>
        
        Please enter 'm':<br />
        <asp:TextBox ID="tbx_Microsoft" runat="server" autocomplete="off" AutoPostBack="true"
            OnTextChanged="tbx_Microsoft_TextChanged"></asp:TextBox>
        <br />
        <br />
        TreeView:<br />
        <asp:TreeView ID="TreeView1" runat="server" SelectedNodeStyle-BackColor="Purple">
        </asp:TreeView>
        <br />
        <br />
        GridView:
        <br />
        <asp:GridView ID="GridView1" runat="server">
        </asp:GridView>
    </div>
    </form>
</body>
</html>
