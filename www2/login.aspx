<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="_Default" Theme="theme" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
<title><%=PUBS.Txt("登录")%></title>
<link href=<%=(string)Session["css"] %> type="text/css" rel="stylesheet"/>

</head>
<body>
<form id="form1" runat="server">
    <div id="loginBg">
        <asp:HiddenField ID="screen_pix" runat="server" />
    
    </div>
    <div><a href="/status.htm">设备状态</a></div>
        <%=PUBS.OutputFoot("") %>
    <div id="loginDlg">
        <div class="title"><span class="title"><%=m_sUnitName%></span></div>
        <div>
        <asp:Login ID="Login1" runat="server" DestinationPageUrl="~/DetectList.aspx"
            DisplayRememberMe="False" OnLoggedIn="Login1_LoggedIn"  SkinID="Login_1" onloginerror="Login1_LoginError" 
                >
        </asp:Login>
        </div>
    </div>

</form>
<script language="javascript">
var screen_pix = document.getElementById("screen_pix");
screen_pix.value = screen.width;
</script>
</body>
</html>
