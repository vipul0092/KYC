﻿<%@ Control Language="C#" AutoEventWireup="true" CodeFile="RateComment.ascx.cs" Inherits="RateComment" %>
<table clientidmode="static" id="rateCommentTable" runat="server"><tr><td><input title="Rate Up" clientidmode="static" type="image" runat="server" id="rateUp" src="../Images/rate-up.png" alt="Rate Up" /></td><td clientidmode="static" runat="server" id="upv"></td><td style="padding-left:10px;"><input title="Rate Down" clientidmode="static" type="image" id="rateDown" runat="server" src="~/Images/rate-down.png" /></td><td clientidmode="static" runat="server" id="dnv"></td><td style="display:none" clientidmode="static" runat="server" hidden="hidden" id="comment"></td><td style="padding: 0px 5px 0px 5px;"><table><tr><td style="display:none" clientidmode="static" runat="server" hidden="hidden" id="shownInfo"></td></tr></table></td></tr></table>