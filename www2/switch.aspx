<%@ Page Language="C#" AutoEventWireup="true" CodeFile="switch.aspx.cs" Inherits="Switch" Theme="theme" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title>车轮在线检测装置  探伤开关</title>
<link href="css/tycho/tycho.css" type="text/css" rel="stylesheet"/>
<script language="javascript" type="text/javascript" src="My97DatePicker/WdatePicker.js"></script>
    <style type="text/css">
        .style1
        {
            width: 50%;
        }
        .style2
        {
            width: 50%;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
<div>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:tychoConnectionString %>"
            SelectCommand="SELECT * FROM Verify order by verifydate desc"></asp:SqlDataSource>
    
</div>

    <%=PUBS.OutputHead("") %>
        <div class="cmd">
            <asp:LoginName ID="LoginName2" runat="server" SkinID="LoginName1" />
            <asp:LoginStatus ID="LoginStatus2" runat="server"  LogoutAction="RedirectToLoginPage" 
                SkinID="LoginStatus1" onloggedout="LoginStatus2_LoggedOut" />
            <asp:Button ID="bt_back" runat="server" Text="返回" onclick="bt_back_Click" 
                CausesValidation="False" />
        </div>
    
        <div class="content">
            <div class="title"><span class="title">
                <asp:Label ID="lb_title" runat="server" Text="当前设置状态"></asp:Label></span>
            </div>
            <br />
        <asp:Label ID="Label1" runat="server" Text="Label">下一次进车：</asp:Label>    
        <asp:Label ID="lbStatus" runat="server" Text="未知" Font-Size="24"></asp:Label>    
        <br />
        <div class="cmd">
        <asp:Button ID="btRun" runat="server" Text="设为检测" onclick="btRun_Click" />&nbsp;
        <asp:Button ID="btPause" runat="server" Text="设为不检测" onclick="btPause_Click" />&nbsp;&nbsp;&nbsp;
        <asp:Button ID="btRefrush" runat="server" Text="刷新状态" onclick="btRefrush_Click" />
                
        </div>
        </div>





        <%=PUBS.OutputFoot("") %>

    </form>
</body>
</html>
