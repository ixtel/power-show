﻿<%@ Page Language="VB" AutoEventWireup="true" CodeFile="vb_SpellCheckOnSubmit.aspx.vb" Inherits="SpellChecker_vb_SpellCheckOnSubmit" %>
<%@ Register
    Assembly="Obout.Ajax.UI"
    Namespace="Obout.Ajax.UI.SpellChecker"
    TagPrefix="obout" %>
<%@ Register
    Assembly="Obout.Ajax.UI"
    Namespace="Obout.Ajax.UI.HTMLEditor"
    TagPrefix="obout" %>
<%@ Register
    Assembly="Obout.Ajax.UI"
    Namespace="Obout.Ajax.UI.HTMLEditor.Popups"
    TagPrefix="obout" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Spell Checker example</title>
    <style type="text/css">
            a {
                   font-size:10pt;font-family:Tahoma
            }
            a:hover {
                   color:crimson;
            }
            .tdText {
                    font:11px Verdana;
                    color:#333333;
            }
    </style>
</head>
<body>
    <script type="text/JavaScript">
        function checkFinished(sender, args) {
            // for all TextBoxes was clicked or emulated 'OK' in SpellChecker popup?
            if (args.get_targetsCount() == args.get_targetsAccepted().length) {
                // yes - force submit
                __doPostBack(sender.get_button().id.replace(/_/, "$"), "");
            }
        }
        function pageLoad() {
            function invokingRequest() {
                Sys.Net.WebRequestManager.remove_invokingRequest(invokingRequest);
                document.getElementById("wait").style.visibility = "visible";
            }
            Sys.Net.WebRequestManager.add_invokingRequest(invokingRequest);
            document.getElementById("wait").style.visibility = "hidden";
            document.getElementById("wait").style.height = document.getElementById("<%=button.ClientID%>").offsetHeight + "px";
            setTimeout(function() {
                $get("<%=textbox1.ClientID%>").focus();
            }, 100);
        }
    </script>
    <span class="tdText"><b>Obout.Ajax.UI.SpellChecker</b> - Spell check on submit</span>
    <br /><br />
    Checked text can be submitted here only.<br />
    TextBoxes will be submitted if their text doesn't contain misspellings or if you click <b>"OK"</b> in the <b>Spell Checker</b> popup for each TextBox.
    <br /><br />
    <form id="form1" runat="server">
        <asp:ScriptManager runat="Server" EnablePartialRendering="true" ID="ScriptManager1" />
        <obout:PopupHolder runat="server" id="popupHolder" >
         <Preload>
            <obout:SpellCheckPopup ID="SpellCheckPopup1" runat="server" ShowOnResult="true" AutoCloseOnGoodResult="true" />
         </Preload>
        </obout:PopupHolder>
        <asp:UpdatePanel ID="updatePanel1" runat="server">
           <ContentTemplate>
               <asp:TextBox runat="server" Rows="5" Columns="60" Text="qqq aaa text mmm"
                            TextMode="MultiLine" id="textbox1" spellcheck="false" />
               <asp:TextBox runat="server" Rows="5" Columns="60" Text="qqq aaa text mmm"
                            TextMode="MultiLine" id="textbox2" spellcheck="false" />
               <br /><br />
               <asp:LinkButton runat="server" Text="Submit" OnClientClick="return false;" ID="button" />
               <img alt="" id="wait" align="absMiddle" style="visibility:hidden; height: 30px" src="<%=Page.ClientScript.GetWebResourceUrl(GetType(Obout.Ajax.UI.HTMLEditor.Editor), "Obout.Ajax.UI.HTMLEditor.Images.ed_wait.gif")%>" />
               <obout:SpellCheckExtender runat="server" ID="spelcheck" PopupHolderID="popupHolder"
                           PopupButtonID="button" TargetControlIDs="textbox1,textbox2"
                           OnClientCheckFinished="checkFinished" LeftMarker="[[" RightMarker="]]"
               />
           </ContentTemplate>
        </asp:UpdatePanel>
    </form>
    <br /><br />
    <a href="Default.aspx?type=VBNET">< Back to examples</a>
</body>
</html>
