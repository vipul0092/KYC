<%@ Page Language="C#" AutoEventWireup="true" CodeFile="JSON_WebService_Test.aspx.cs" Inherits="Demo_JSON_WebService_Test" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title>Web Service using JSON</title>
    <script src="../Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
    <script src="../Scripts/jquery.cookie.js" type="text/javascript"></script>
    <script language="javascript" type="text/javascript">
        $(function () {
            
            $("#btnShow").click(function () {
                data1 = "{\"name\":\"Vipul\"}";
                $.ajax(
                    {
                        type: "POST",
                        url: "/WebService/WebService.asmx/sendObject",
                        data: data1,
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {
                                if (data.hasOwnProperty('d')) {
                                    msg = data.d;
                                } else {
                                    msg = data;
                                }
                                alert(msg);

                        },
                        error: function (data, status, error) {
                            alert(data.d);
                        }
                    });
            });
        });

    </script>
</head>
<body>
    <input id="txtID" type="text" /><br />
    <input id="txtName" type="text" /><br />
    <input id="btnShow" type="button" value="Show" />
</body>
</html>