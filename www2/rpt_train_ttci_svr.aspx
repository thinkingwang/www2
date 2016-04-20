<%@ Page Language="C#" AutoEventWireup="true" CodeFile="rpt_train_ttci_svr.aspx.cs" Inherits="whms_wheel" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>轮对外形尺寸</title>
<link href="css/tycho/tycho.css" type="text/css" rel="stylesheet"/>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>

    <%=PUBS.OutputHead("") %>
    <div class="cmd">
        <asp:LoginName ID="LoginName2" runat="server"  />
        <asp:LoginStatus ID="LoginStatus2" runat="server"  LogoutAction="RedirectToLoginPage" 
             onloggedout="LoginStatus2_LoggedOut" />
        <asp:Button ID="bt_back" runat="server" Text="返回" onclientclick="javascript:history.go(-1);return false;" />
    </div>
    <div>
        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" 
            Font-Size="8pt" InteractiveDeviceInfos="(集合)" WaitMessageFont-Names="Verdana" 
            WaitMessageFont-Size="14pt" Width="848px" Height="748px">
            <LocalReport ReportPath="rpt_train_ttci.rdlc">
            </LocalReport>
        </rsweb:ReportViewer>
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" 
            TypeName="tycho_kcDataSetTableAdapters."></asp:ObjectDataSource>
    </div>

    <%=PUBS.OutputFoot("") %>
    </form>
</body>
</html>
